Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611EBC5AD49
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Jun 2025 23:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E5E10E6D4;
	Sun,  8 Jun 2025 23:42:20 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Sat, 07 Jun 2025 12:24:09 UTC
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E6010E1BC
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Jun 2025 12:24:09 +0000 (UTC)
Authentication-Results: srv1.dorfdsl.de; none (SPF check N/A for local 
 connections -  client-ip=2a01:170:118f:2:b4a9:c2af:1caf:3146; 
 helo=[IPv6:2a01:170:118f:2:b4a9:c2af:1caf:3146]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1749298741;
 bh=0szOEnH+jBuXV7s+ytrzV49LWe4xW+d3uJDu45xxRf4=;
 h=Date:From:To:Subject:From;
 b=NUtvanVcubIyEAAITB7OOpFhpdtCzMwuEVR/SiLFrmkL7AeleuVbfWTdzhY0P62+A
 +2L6m45MRA2ZeZv9GJm/MzdmYnri0o57bSLEVonpW2Ez2ymstZlU/2kDecB7odzkJp
 QAqkDrgN/ERo9in+bN56yy9I4PfcNfHwhH6X3HAIKzNScWervnRlK9FWnKsxLWE1DY
 NGPPrDQNFfzvUsOxKkFvui0Z0uWs0jnfnXA5omJ90mlgju7vE7iOr7LkU7Cibty0Ch
 k9Q04YD1m+47nmTwYD3bcwN9ZnrmbRQMjS/u/Vn6lrUDQUDWgO6d9T/zEFPiDNMF7P
 Y1LTrc0/tGdmA==
Received: from ryz.dorfdsl.de ([IPv6:2a01:170:118f:2:b4a9:c2af:1caf:3146])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 557CJ1NH239642
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 7 Jun 2025 14:19:01 +0200
Date: Sat, 7 Jun 2025 14:19:00 +0200
From: Marco Moock <mm@dorfdsl.de>
To: <amd-gfx@lists.freedesktop.org>
Subject: standby issues with amd vega 1002:15d8
Message-ID: <20250607141900.08a1c27f@ryz.dorfdsl.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 08 Jun 2025 23:42:18 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello!

I have the 1002:15d8 running Debian Unstable with 6.12.30-amd64. I
currently use amdgpu.ppfeaturemask=3D0xfff73fff.

If I remove that, the system crashed at every attempt to go to S3. If I
keep it, It hangs on the screen and doesn't shut off. I can't "wake" it
up anymore into a working state on the screen. When querying the dmesg,
I noticed that the system itself was still running. If needed, I can
try to ssh into it and test more stuff.

m@ryz:~$ sudo journalctl -b -1 -S 12:16 |grep -v 'filter_\|STATE_INVALI\|CR=
ON\|NetworkManager' | cut -d " " -f 5-
systemd[1]: Starting fwupd-refresh.service - Refresh fwupd metadata and upd=
ate motd...
systemd[1]: fwupd-refresh.service: Deactivated successfully.
systemd[1]: Finished fwupd-refresh.service - Refresh fwupd metadata and upd=
ate motd.
polkitd[1185]: Registered Authentication Agent for unix-process:23827:17095=
77 (system bus name :1.436 [/usr/bin/pkttyagent --notify-fd 6 --fallback], =
object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale de_DE.U=
TF-8)
systemd-logind[1194]: The system will suspend now!
ModemManager[1345]: <msg> [sleep-monitor-systemd] system is about to suspend
polkitd[1185]: Unregistered Authentication Agent for unix-process:23827:170=
9577 (system bus name :1.436, object path /org/freedesktop/PolicyKit1/Authe=
nticationAgent, locale de_DE.UTF-8) (disconnected from bus)
dbus-daemon[1178]: [system] Successfully activated service 'org.freedesktop=
.nm_dispatcher'
kernel: r8169 0000:03:00.0 enp3s0: Link is Down
kernel: IPv6: ipv6_create_tempaddr: regeneration time exceeded - disabled t=
emporary address support
systemd[1]: Reached target sleep.target - Sleep.
systemd[1]: Starting systemd-suspend.service - System Suspend...
systemd[1]: user@1000.service: Unit now frozen-by-parent.
nscd[1193]: 1193 =C3=BCberwachte Datei =C2=BB/etc/resolv.conf=C2=AB wurde m=
oved into place, f=C3=BCge =C3=9Cberwachung hinzu
systemd-sleep[23844]: Failed to freeze unit 'user.slice': Connection timed =
out
systemd-sleep[23844]: Performing sleep operation 'suspend'...
kernel: PM: suspend entry (deep)
kernel: Filesystems sync: 0.003 seconds
kernel: Freezing user space processes
kernel: Freezing user space processes failed after 20.005 seconds (1 tasks =
refusing to freeze, wq_busy=3D0):
kernel: task:keepassxc       state:D stack:0     pid:22403 tgid:22403 ppid:=
1      flags:0x00004006
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x505/0xbf0
kernel:  schedule+0x27/0xf0
kernel:  request_wait_answer+0xd0/0x2a0
kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
kernel:  __fuse_simple_request+0xd7/0x290
kernel:  fuse_send_open+0xb9/0x110
kernel:  fuse_file_open+0x117/0x1a0
kernel:  fuse_open+0x8a/0x320
kernel:  ? __pfx_fuse_open+0x10/0x10
kernel:  do_dentry_open+0x14f/0x440
kernel:  vfs_open+0x2e/0xe0
kernel:  path_openat+0x82e/0x12d0
kernel:  ? do_statx+0x72/0xa0
kernel:  do_filp_open+0xc4/0x170
kernel:  do_sys_openat2+0xae/0xe0
kernel:  __x64_sys_openat+0x55/0xa0
kernel:  do_syscall_64+0x82/0x190
kernel:  ? syscall_exit_to_user_mode+0x4d/0x210
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? aa_file_perm+0x122/0x4d0
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? vfs_write+0xf8/0x450
kernel:  ? _copy_from_user+0x29/0x70
kernel:  ? apparmor_file_permission+0x75/0x190
kernel:  ? set_close_on_exec+0x31/0x70
kernel:  ? do_fcntl+0x3dd/0x740
kernel:  ? __x64_sys_fcntl+0x87/0xe0
kernel:  ? syscall_exit_to_user_mode+0x4d/0x210
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? syscall_exit_to_user_mode+0x4d/0x210
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel: RIP: 0033:0x7faf9a9b49ee
kernel: RSP: 002b:00007ffc9068bf88 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
101
kernel: RAX: ffffffffffffffda RBX: 00007faf99a56940 RCX: 00007faf9a9b49ee
kernel: RDX: 0000000000080000 RSI: 00005614c2f0f368 RDI: ffffffffffffff9c
kernel: RBP: 0000000000080000 R08: 0000000000000000 R09: 0000000000000000
kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00005614c2767360
kernel: R13: 00007ffc9068c058 R14: 00005614c2767380 R15: 00005614c1ee7b30
kernel:  </TASK>
kernel: OOM killer enabled.
kernel: Restarting tasks ... done.
kernel: random: crng reseeded on system resumption
kernel: PM: suspend exit
kernel: PM: suspend entry (s2idle)
rtkit-daemon[1684]: The canary thread is apparently starving. Taking action.
rtkit-daemon[1684]: Demoting known real-time threads.
rtkit-daemon[1684]: Successfully demoted thread 20457 of process 20123.
rtkit-daemon[1684]: Successfully demoted thread 2820 of process 1999.
rtkit-daemon[1684]: Successfully demoted thread 2285 of process 1992.
rtkit-daemon[1684]: Demoted 3 threads.
kernel: Filesystems sync: 0.008 seconds
kernel: Freezing user space processes
kernel: Freezing user space processes failed after 20.002 seconds (1 tasks =
refusing to freeze, wq_busy=3D0):
kernel: task:keepassxc       state:D stack:0     pid:22403 tgid:22403 ppid:=
1      flags:0x00004006
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x505/0xbf0
kernel:  schedule+0x27/0xf0
kernel:  request_wait_answer+0xd0/0x2a0
kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
kernel:  __fuse_simple_request+0xd7/0x290
kernel:  fuse_send_open+0xb9/0x110
kernel:  fuse_file_open+0x117/0x1a0
kernel:  fuse_open+0x8a/0x320
kernel:  ? __pfx_fuse_open+0x10/0x10
kernel:  do_dentry_open+0x14f/0x440
kernel:  vfs_open+0x2e/0xe0
kernel:  path_openat+0x82e/0x12d0
kernel:  ? do_statx+0x72/0xa0
kernel:  do_filp_open+0xc4/0x170
kernel:  do_sys_openat2+0xae/0xe0
kernel:  __x64_sys_openat+0x55/0xa0
kernel:  do_syscall_64+0x82/0x190
kernel:  ? syscall_exit_to_user_mode+0x4d/0x210
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? aa_file_perm+0x122/0x4d0
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? vfs_write+0xf8/0x450
kernel:  ? _copy_from_user+0x29/0x70
kernel:  ? apparmor_file_permission+0x75/0x190
kernel:  ? set_close_on_exec+0x31/0x70
kernel:  ? do_fcntl+0x3dd/0x740
kernel:  ? __x64_sys_fcntl+0x87/0xe0
kernel:  ? syscall_exit_to_user_mode+0x4d/0x210
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? syscall_exit_to_user_mode+0x4d/0x210
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  ? do_syscall_64+0x8e/0x190
kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kernel: RIP: 0033:0x7faf9a9b49ee
kernel: RSP: 002b:00007ffc9068bf88 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
101
kernel: RAX: ffffffffffffffda RBX: 00007faf99a56940 RCX: 00007faf9a9b49ee
kernel: RDX: 0000000000080000 RSI: 00005614c2f0f368 RDI: ffffffffffffff9c
kernel: RBP: 0000000000080000 R08: 0000000000000000 R09: 0000000000000000
kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00005614c2767360
kernel: R13: 00007ffc9068c058 R14: 00005614c2767380 R15: 00005614c1ee7b30
kernel:  </TASK>
kernel: OOM killer enabled.
kernel: Restarting tasks ... done.
kernel: random: crng reseeded on system resumption
kernel: PM: suspend exit
rtkit-daemon[1684]: The canary thread is apparently starving. Taking action.
systemd-sleep[23844]: Failed to put system to sleep. System resumed again: =
Device or resource busy
rtkit-daemon[1684]: Demoting known real-time threads.
rtkit-daemon[1684]: Successfully demoted thread 20457 of process 20123.
rtkit-daemon[1684]: Successfully demoted thread 2820 of process 1999.
rtkit-daemon[1684]: Successfully demoted thread 2285 of process 1992.
systemd-sleep[23844]: Successfully thawed unit 'user.slice'.
rtkit-daemon[1684]: Demoted 3 threads.
systemd[1]: systemd-suspend.service: Main process exited, code=3Dexited, st=
atus=3D1/FAILURE
systemd[1]: systemd-suspend.service: Failed with result 'exit-code'.
systemd[1]: Failed to start systemd-suspend.service - System Suspend.
systemd[1]: Dependency failed for suspend.target - Suspend.
systemd[1]: suspend.target: Job suspend.target/start failed with result 'de=
pendency'.
systemd[1]: systemd-suspend.service: Consumed 1.265s CPU time, 2.1M memory =
peak.
systemd[1]: user@1000.service: Unit now frozen.
systemd[1]: Stopped target sleep.target - Sleep.
systemd-logind[1194]: Operation 'suspend' finished.
systemd[1]: Starting grub-common.service - Record successful boot for GRUB.=
..
ModemManager[1345]: <msg> [sleep-monitor-systemd] system is resuming
kernel: Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY driver (mii_=
bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
systemd[1]: grub-common.service: Deactivated successfully.
systemd[1]: Finished grub-common.service - Record successful boot for GRUB.
kernel: r8169 0000:03:00.0 enp3s0: Link is Down
kernel: r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow control o=
ff
dbus-daemon[1178]: [system] Successfully activated service 'org.freedesktop=
.nm_dispatcher'
ModemManager[1345]: <msg> [base-manager] couldn't check support for device =
'/sys/devices/pci0000:00/0000:00:01.2/0000:01:00.2/0000:02:00.0/0000:03:00.=
0': not supported by any plugin
nscd[1193]: 1193 =C3=BCberwachte Datei =C2=BB/etc/resolv.conf=C2=AB wurde m=
oved into place, f=C3=BCge =C3=9Cberwachung hinzu
systemd[1]: Started anacron.service - Run anacron jobs.
anacron[23927]: Anacron 2.3 started on 2025-06-07
anacron[23927]: Normal exit (0 jobs run)
systemd[1]: anacron.service: Deactivated successfully.
systemd[1]: Starting fwupd-refresh.service - Refresh fwupd metadata and upd=
ate motd...
systemd[1]: fwupd-refresh.service: Deactivated successfully.
systemd[1]: Finished fwupd-refresh.service - Refresh fwupd metadata and upd=
ate motd.
systemd[1]: Started anacron.service - Run anacron jobs.
anacron[24087]: Anacron 2.3 started on 2025-06-07
anacron[24087]: Normal exit (0 jobs run)
systemd[1]: anacron.service: Deactivated successfully.
systemd-logind[1194]: Power key pressed short.
systemd-logind[1194]: Powering off...
systemd-logind[1194]: System is powering down.
systemd[1]: unattended-upgrades.service: Deactivated successfully.

Is that issue related to=20
https://lists.freedesktop.org/archives/amd-gfx/2025-January/118759.html

--=20
Gru=C3=9F
Marco

Send unsolicited bulk mail to 1749297491muell@stinkedores.dorfdsl.de
