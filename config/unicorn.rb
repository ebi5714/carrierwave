worker_processes 8

pid "tmp/pids/unicorn.pid"
listen "/opt/webapp/tmp/sockets/unicorn.sock"

stdout_path "./log/unicorn.stdout.log"
stderr_path "./log/unicorn.stderr.log"
