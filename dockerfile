FROM oraclelinux:8

# Set environment
ENV ORACLE_BASE=/opt/oracle \
    ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE \
    ORACLE_SID=XE \
    ORACLE_PASSWORD=YourPassword123 \
    PATH=$PATH:/opt/oracle/product/21c/dbhomeXE/bin \
    INSTALL_FILE=/tmp/oracle-database-xe.rpm

# Install prerequisites
RUN microdnf install -y oracle-release-el8 \
    && microdnf install -y oracle-database-preinstall-21c \
    && microdnf install -y libaio libnsl unzip shadow-utils glibc-langpack-en \
    && microdnf clean all

# Create Oracle user
RUN useradd -m -s /bin/bash oracleuser

# Copy RPM into container and install
COPY oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm $INSTALL_FILE
RUN rpm -ivh $INSTALL_FILE \
    && rm -f $INSTALL_FILE

# Setup DB as root
RUN echo -e "$ORACLE_PASSWORD\n$ORACLE_PASSWORD" | /etc/init.d/oracle-xe-21c configure

# Fix permissions for non-root
RUN chown -R oracleuser:oracleuser $ORACLE_BASE

# Switch to non-root user
USER oracleuser

# Expose port
EXPOSE 1521

# Startup
CMD ["bash", "-c", "$ORACLE_HOME/bin/lsnrctl start && tail -f /dev/null"]