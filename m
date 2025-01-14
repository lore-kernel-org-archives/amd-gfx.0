Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA61E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 20:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727A410E0C3;
	Tue, 14 Jan 2025 20:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=dorfdsl.de header.i=@dorfdsl.de header.b="mVtPdq0P";
	dkim-atps=neutral
X-Greylist: delayed 887 seconds by postgrey-1.36 at gabe;
 Tue, 14 Jan 2025 20:49:30 UTC
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313DD10E0C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 20:49:30 +0000 (UTC)
Authentication-Results: srv1; none (SPF check N/A for local connections 
 -  client-ip=2a01:170:118f:2:db9:8074:d7f:32eb; 
 helo=[IPv6:2a01:170:118f:2:db9:8074:d7f:32eb]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1736886761;
 bh=HgDqz75oF4eDjpoou+I3s6N0eWt9wNbbfQ3RO20MPcQ=;
 h=Date:From:To:Subject:From;
 b=mVtPdq0P7YTcDRzWa5LxTl+r6nWkXum8QkrCXKqyTk0CokSBJemi2OAb7CmXEcy09
 kAUFb3xTJ5LJbQrA6IvII8dKq1EARbtIo7xxZyQ0ZUKiFgfcvu6J9mvbEAhbDkfcgt
 49oNVOCXCLcM1Xs9+c1Yuc8ze3uP9z8YACmdOKh/akV62Cm8JiHaVMpvAEATmhLiYO
 VyesgXAh/Bs9Ol3ZFqgrcu+sZdJdAPIGh9hb9SFZ9FSJchofkknbqhn2GB3keHv6O6
 p0AAMotSgAjB5EPiuv1v1WpIdiGO25z9pQGkMt/7jiufoL+HtCJTwIXz9lOwi5GpNP
 EPG6FwFNaxsiQ==
Received: from ryz.dorfdsl.de ([IPv6:2a01:170:118f:2:db9:8074:d7f:32eb])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 50EKWfMj229218
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 21:32:41 +0100
Date: Tue, 14 Jan 2025 21:32:39 +0100
From: Marco Moock <mm@dorfdsl.de>
To: amd-gfx@lists.freedesktop.org
Subject: amdgpu 100% CPU usage causing freeze 1002:15d8
Message-ID: <20250114213157.19de9009@ryz.dorfdsl.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/.hlhHp+T9GvqNyhPt6vYIOp"
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

--MP_/.hlhHp+T9GvqNyhPt6vYIOp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!

This might be related to
https://lists.freedesktop.org/archives/amd-gfx/2025-January/118759.html
As I subscribed just now, I can't reply there and can't get the
Message-I

       description: Motherboard
       product: Pro A520M-C II
       vendor: ASUSTeK COMPUTER INC.
       physical id: 0
       version: Rev X.0x
       slot: Default string
     *-firmware
          description: BIOS
          vendor: American Megatrends Inc.
          physical id: 0
          version: 3612
          date: 12/03/2024

I updated the UEFI yesterday to the latest version, problem still
exists.

08:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
[AMD/ATI] Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile
Series] [1002:15d8] (rev c9) Subsystem: ASUSTeK Computer Inc. Device
[1043:876b] Kernel driver in use: amdgpu Kernel modules: amdgpu

Linux ryz 6.12.9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.9-1
(2025-01-10) x86_64 GNU/Linux

un  mesa-common-dev           <none>       <none>       (no description available)
un  mesa-glide2-dev           <none>       <none>       (no description available)
ii  mesa-libgallium:amd64     24.3.3-1     amd64        shared infrastructure for Mesa drivers
ii  mesa-libgallium:i386      24.3.3-1     i386         shared infrastructure for Mesa drivers
un  mesa-opencl-icd           <none>       <none>       (no description available)
ii  mesa-utils                9.0.0-2+b1   amd64        Miscellaneous Mesa utilities -- symlinks
ii  mesa-utils-bin:amd64      9.0.0-2+b1   amd64        Miscellaneous Mesa utilities -- native applications
un  mesa-utils-extra          <none>       <none>       (no description available)
ii  mesa-va-drivers:amd64     24.3.3-1     amd64        Mesa VA-API video acceleration drivers
ii  mesa-vdpau-drivers:amd64  24.3.3-1     amd64        Mesa VDPAU video acceleration drivers
ii  mesa-vulkan-drivers:amd64 24.3.3-1     amd64        Mesa Vulkan graphics drivers
ii  mesa-vulkan-drivers:i386  24.3.3-1     i386         Mesa Vulkan graphics drivers
un  mesag-dev                 <none>       <none>       (no description available)
un  mesag3                    <none>       <none>       (no description available)
un  mesag3+ggi-dev            <none>       <none>       (no description
available)


I am running Debian Unstable and encounter 100% CPU usage after some
hours, reproducible. I have to shut off the system with sysrq, I can't
shut it down the normal way as it is non-responsive.

I tried 6.12.9 and 6.12.8.

6.12.8 gave some dmesg error messages:

Jan 13 11:09:44 ryz kernel: amdgpu 0000:08:00.0: amdgpu: Dumping IP State
Jan 13 11:09:48 ryz kernel: [drm:amdgpu_dm_atomic_check [amdgpu]] *ERROR* [CRTC:73:crtc-0] hw_done or flip_done timed out
Jan 13 11:09:55 ryz kernel: amdgpu 0000:08:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
Jan 13 11:10:00 ryz kernel: sysrq: Keyboard mode set to system default
Jan 13 11:10:00 ryz kernel: sysrq: This sysrq operation is disabled.
Jan 13 11:10:00 ryz kernel: sysrq: This sysrq operation is disabled.
Jan 13 11:10:01 ryz kernel: sysrq: Emergency Sync


6.12.9 doesn't gave me them, but it doesn't list sysrq calls either, so
I assume it didn't manage to store them in dmesg.

I remember the first occurrence last Friday, some mesa packages were
updated and I assume it was running 6.12.8 according to the apt logs.




Please tell me which further info you need to track down the issue.


-- 
kind regards
Marco

--MP_/.hlhHp+T9GvqNyhPt6vYIOp
Content-Type: text/x-log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=history.log


Start-Date: 2025-01-01  06:11:25
Commandline: /usr/bin/unattended-upgrade
Upgrade: libpipewire-0.3-dev:amd64 (1.2.7-1, 1.2.7-1+b1), libspa-0.2-dev:amd64 (1.2.7-1, 1.2.7-1+b1), pipewire-pulse:amd64 (1.2.7-1, 1.2.7-1+b1), pipewire:amd64 (1.2.7-1, 1.2.7-1+b1), libspa-0.2-bluetooth:amd64 (1.2.7-1, 1.2.7-1+b1), pipewire-bin:amd64 (1.2.7-1, 1.2.7-1+b1), libspa-0.2-modules:amd64 (1.2.7-1, 1.2.7-1+b1), libpipewire-0.3-0t64:amd64 (1.2.7-1, 1.2.7-1+b1), libpipewire-0.3-modules:amd64 (1.2.7-1, 1.2.7-1+b1)
End-Date: 2025-01-01  06:11:33

Start-Date: 2025-01-01  06:11:36
Commandline: /usr/bin/unattended-upgrade
Upgrade: devscripts:amd64 (2.24.9, 2.24.10)
End-Date: 2025-01-01  06:11:40

Start-Date: 2025-01-01  06:11:47
Commandline: /usr/bin/unattended-upgrade
Upgrade: libgomp1:amd64 (14.2.0-11, 14.2.0-12), libgomp1:i386 (14.2.0-11, 14.2.0-12), libgcc-14-dev:amd64 (14.2.0-11, 14.2.0-12), libstdc++-14-dev:amd64 (14.2.0-11, 14.2.0-12), g++-14:amd64 (14.2.0-11, 14.2.0-12), gcc-14:amd64 (14.2.0-11, 14.2.0-12), libtsan2:amd64 (14.2.0-11, 14.2.0-12), g++-14-x86-64-linux-gnu:amd64 (14.2.0-11, 14.2.0-12), libhwasan0:amd64 (14.2.0-11, 14.2.0-12), libgfortran5:amd64 (14.2.0-11, 14.2.0-12), gcc-14-x86-64-linux-gnu:amd64 (14.2.0-11, 14.2.0-12), libcc1-0:amd64 (14.2.0-11, 14.2.0-12), libasan8:amd64 (14.2.0-11, 14.2.0-12), cpp-14:amd64 (14.2.0-11, 14.2.0-12), libitm1:amd64 (14.2.0-11, 14.2.0-12), cpp-14-x86-64-linux-gnu:amd64 (14.2.0-11, 14.2.0-12), libquadmath0:amd64 (14.2.0-11, 14.2.0-12), libubsan1:amd64 (14.2.0-11, 14.2.0-12), liblsan0:amd64 (14.2.0-11, 14.2.0-12), libobjc4:amd64 (14.2.0-11, 14.2.0-12), libstdc++6:amd64 (14.2.0-11, 14.2.0-12), libstdc++6:i386 (14.2.0-11, 14.2.0-12), libatomic1:amd64 (14.2.0-11, 14.2.0-12), libatomic1:i386 (!
 14.2.0-11, 14.2.0-12), gcc-14-base:amd64 (14.2.0-11, 14.2.0-12), gcc-14-base:i386 (14.2.0-11, 14.2.0-12), libgcc-s1:amd64 (14.2.0-11, 14.2.0-12), libgcc-s1:i386 (14.2.0-11, 14.2.0-12)
End-Date: 2025-01-01  06:11:55

Start-Date: 2025-01-01  06:11:58
Commandline: /usr/bin/unattended-upgrade
Upgrade: libctf-nobfd0:amd64 (2.43.50.20241221-1, 2.43.50.20241230-1), libbinutils:amd64 (2.43.50.20241221-1, 2.43.50.20241230-1), binutils-x86-64-linux-gnu:amd64 (2.43.50.20241221-1, 2.43.50.20241230-1), libctf0:amd64 (2.43.50.20241221-1, 2.43.50.20241230-1), binutils-common:amd64 (2.43.50.20241221-1, 2.43.50.20241230-1), libsframe1:amd64 (2.43.50.20241221-1, 2.43.50.20241230-1), libgprofng0:amd64 (2.43.50.20241221-1, 2.43.50.20241230-1), binutils:amd64 (2.43.50.20241221-1, 2.43.50.20241230-1)
End-Date: 2025-01-01  06:12:02

Start-Date: 2025-01-01  06:12:05
Commandline: /usr/bin/unattended-upgrade
Upgrade: pinentry-gnome3:amd64 (1.2.1-5, 1.3.1-2), pinentry-qt:amd64 (1.2.1-5, 1.3.1-2), pinentry-curses:amd64 (1.2.1-5, 1.3.1-2)
End-Date: 2025-01-01  06:12:07

Start-Date: 2025-01-01  06:12:10
Commandline: /usr/bin/unattended-upgrade
Upgrade: audacity:amd64 (3.7.0+dfsg-1, 3.7.1+dfsg-1), audacity-data:amd64 (3.7.0+dfsg-1, 3.7.1+dfsg-1)
End-Date: 2025-01-01  06:12:16

Start-Date: 2025-01-01  06:12:21
Commandline: /usr/bin/unattended-upgrade
Upgrade: libgcc-13-dev:amd64 (13.3.0-11, 13.3.0-12), libstdc++-13-dev:amd64 (13.3.0-11, 13.3.0-12), g++-13:amd64 (13.3.0-11, 13.3.0-12), gcc-13:amd64 (13.3.0-11, 13.3.0-12), cpp-13-x86-64-linux-gnu:amd64 (13.3.0-11, 13.3.0-12), cpp-13:amd64 (13.3.0-11, 13.3.0-12), g++-13-x86-64-linux-gnu:amd64 (13.3.0-11, 13.3.0-12), gcc-13-x86-64-linux-gnu:amd64 (13.3.0-11, 13.3.0-12), gcc-13-base:amd64 (13.3.0-11, 13.3.0-12)
End-Date: 2025-01-01  06:12:26

Start-Date: 2025-01-01  06:12:29
Commandline: /usr/bin/unattended-upgrade
Upgrade: libcares2:amd64 (1.34.4-2, 1.34.4-2.1)
End-Date: 2025-01-01  06:12:30

Start-Date: 2025-01-01  06:12:32
Commandline: /usr/bin/unattended-upgrade
Upgrade: libsdl2-image-2.0-0:amd64 (2.8.2+dfsg-1+b2, 2.8.4+dfsg-1)
End-Date: 2025-01-01  06:12:34

Start-Date: 2025-01-01  06:12:36
Commandline: /usr/bin/unattended-upgrade
Upgrade: dictionaries-common:amd64 (1.30.2, 1.30.3)
End-Date: 2025-01-01  06:12:42

Start-Date: 2025-01-01  06:12:44
Commandline: /usr/bin/unattended-upgrade
Upgrade: fig2dev:amd64 (1:3.2.9-4, 1:3.2.9a-1)
End-Date: 2025-01-01  06:12:47

Start-Date: 2025-01-02  19:32:09
Commandline: apt upgrade
Requested-By: m (1000)
Upgrade: dpkg:amd64 (1.22.11, 1.22.12), kwayland-integration:amd64 (6.2.4-1, 6.2.4-2), libcapstone5:amd64 (5.0.3-1, 5.0.3-1+b1), ircii:amd64 (20210328-2+b2, 20240918-1), apt:amd64 (2.9.20, 2.9.21), git:amd64 (1:2.45.2+next.20240614-1, 1:2.47.1-1), libatopology2t64:amd64 (1.2.12-1+b1, 1.2.13-1), module-assistant:amd64 (0.11.11, 0.11.12), libkf6windowsystem-data:amd64 (6.8.0-1, 6.8.0-2), libext2fs2t64:amd64 (1.47.2~rc1-2, 1.47.2-1), alsa-ucm-conf:amd64 (1.2.12-1, 1.2.13-1), libkf6windowsystem6:amd64 (6.8.0-1, 6.8.0-2), liblockfile-bin:amd64 (1.17-1+b2, 1.17-2), fonts-wine:amd64 (9.0~repack-7, 10.0~rc2~repack-2), libasound2t64:amd64 (1.2.12-1+b1, 1.2.13-1), libasound2t64:i386 (1.2.12-1+b1, 1.2.13-1), libcom-err2:amd64 (1.47.2~rc1-2, 1.47.2-1), libcom-err2:i386 (1.47.2~rc1-2, 1.47.2-1), comerr-dev:amd64 (2.1-1.47.2~rc1-2, 2.1-1.47.2-1), dpkg-dev:amd64 (1.22.11, 1.22.12), gsmartcontrol:amd64 (2.0.0-1, 2.0.1-1), linux-base:amd64 (4.10.1, 4.11), linux-sysctl-defaults:amd64 (4.10.1,!
  4.11), alsa-utils:amd64 (1.2.12-1, 1.2.13-1), libasound2-data:amd64 (1.2.12-1, 1.2.13-1), libdpkg-perl:amd64 (1.22.11, 1.22.12), libapt-pkg6.0t64:amd64 (2.9.20, 2.9.21), bash-completion:amd64 (1:2.14.0-2, 1:2.16.0-1), apt-transport-https:amd64 (2.9.20, 2.9.21), libchromaprint1:amd64 (1.5.1-6, 1.5.1-7), apt-utils:amd64 (2.9.20, 2.9.21), unattended-upgrades:amd64 (2.11+nmu1, 2.12), logsave:amd64 (1.47.2~rc1-2, 1.47.2-1), liblockfile1:amd64 (1.17-1+b2, 1.17-2), git-man:amd64 (1:2.45.2+next.20240614-1, 1:2.47.1-1), xdg-desktop-portal:amd64 (1.18.4-1, 1.18.4-2), libdebconfclient0:amd64 (0.276, 0.277), libasound2-dev:amd64 (1.2.12-1+b1, 1.2.13-1), e2fsprogs:amd64 (1.47.2~rc1-2, 1.47.2-1)
End-Date: 2025-01-02  19:33:14

Start-Date: 2025-01-03  21:23:11
Commandline: apt upgrade
Requested-By: m (1000)
Upgrade: dpkg:amd64 (1.22.12, 1.22.13), libzxing3:amd64 (2.2.1-3+b2, 2.3.0-1), udev:amd64 (257.1-5, 257.1-6), python3.13:amd64 (3.13.1-2, 3.13.1-3), gcc-12:amd64 (12.4.0-2, 12.4.0-4), systemd-timesyncd:amd64 (257.1-5, 257.1-6), libpam-systemd:amd64 (257.1-5, 257.1-6), libpython3.13-stdlib:amd64 (3.13.1-2, 3.13.1-3), python3.13-tk:amd64 (3.13.1-2, 3.13.1-3), libsystemd0:amd64 (257.1-5, 257.1-6), libsystemd0:i386 (257.1-5, 257.1-6), linux-cpupower:amd64 (6.12.6-1, 6.12.8-1), libnss-systemd:amd64 (257.1-5, 257.1-6), libudev-dev:amd64 (257.1-5, 257.1-6), libpython3.13-minimal:amd64 (3.13.1-2, 3.13.1-3), netcat-traditional:amd64 (1.10-48.2, 1.10-50), systemd:amd64 (257.1-5, 257.1-6), libudev1:amd64 (257.1-5, 257.1-6), libudev1:i386 (257.1-5, 257.1-6), python3.13-venv:amd64 (3.13.1-2, 3.13.1-3), systemd-cryptsetup:amd64 (257.1-5, 257.1-6), dpkg-dev:amd64 (1.22.12, 1.22.13), python3.13-full:amd64 (3.13.1-2, 3.13.1-3), cpp-12:amd64 (12.4.0-2, 12.4.0-4), python3.13-gdbm:amd64 (3.13.1!
 -2, 3.13.1-3), libdpkg-perl:amd64 (1.22.12, 1.22.13), python3-argcomplete:amd64 (3.5.2-1, 3.5.3-1), libsdl2-2.0-0:amd64 (2.30.10+dfsg-1, 2.30.11+dfsg-1), libsdl2-2.0-0:i386 (2.30.10+dfsg-1, 2.30.11+dfsg-1), python3.13-minimal:amd64 (3.13.1-2, 3.13.1-3), libsystemd-shared:amd64 (257.1-5, 257.1-6), systemd-sysv:amd64 (257.1-5, 257.1-6), 7zip:amd64 (24.09+dfsg-2, 24.09+dfsg-3), libcddb2:amd64 (1.3.2-7, 1.3.2-7.1), libcpupower1:amd64 (6.12.6-1, 6.12.8-1), liblz4-1:amd64 (1.9.4-3+b1, 1.9.4-4), libsdl2-dev:amd64 (2.30.10+dfsg-1, 2.30.11+dfsg-1), gcc-12-base:amd64 (12.4.0-2, 12.4.0-4), libsystemd-dev:amd64 (257.1-5, 257.1-6), libgcc-12-dev:amd64 (12.4.0-2, 12.4.0-4), linux-libc-dev:amd64 (6.12.6-1, 6.12.8-1)
End-Date: 2025-01-03  21:23:50

Start-Date: 2025-01-04  08:35:40
Commandline: apt upgrade
Requested-By: m (1000)
Upgrade: idle-python3.13:amd64 (3.13.1-2, 3.13.1-3), virtualbox:amd64 (7.0.20-dfsg-1+b1, 7.0.20-dfsg-1.1), libfluidsynth3:amd64 (2.4.0-1, 2.4.2-1), module-assistant:amd64 (0.11.12, 0.11.12.1), libfluidsynth-dev:amd64 (2.4.0-1, 2.4.2-1), libc6:amd64 (2.40-4, 2.40-5), libc6:i386 (2.40-4, 2.40-5), locales:amd64 (2.40-4, 2.40-5), libgstreamer-plugins-bad1.0-0:amd64 (1.24.10-2, 1.24.10-3), libpython3.13-testsuite:amd64 (3.13.1-2, 3.13.1-3), libxxhash0:amd64 (0.8.2-2+b2, 0.8.3-1), libc-dev-bin:amd64 (2.40-4, 2.40-5), libc-l10n:amd64 (2.40-4, 2.40-5), libc-bin:amd64 (2.40-4, 2.40-5), libc6-dbg:amd64 (2.40-4, 2.40-5), libc6-dev:amd64 (2.40-4, 2.40-5), virtualbox-qt:amd64 (7.0.20-dfsg-1+b1, 7.0.20-dfsg-1.1), python3.13-doc:amd64 (3.13.1-2, 3.13.1-3), nscd:amd64 (2.40-4, 2.40-5), gstreamer1.0-plugins-bad:amd64 (1.24.10-2, 1.24.10-3), python3.13-examples:amd64 (3.13.1-2, 3.13.1-3), virtualbox-source:amd64 (7.0.20-dfsg-1+b1, 7.0.20-dfsg-1.1), virtualbox-dkms:amd64 (7.0.20-dfsg-1+b1, 7.0!
 .20-dfsg-1.1)
End-Date: 2025-01-04  08:36:37

Start-Date: 2025-01-04  20:02:11
Commandline: apt install mumble
Requested-By: m (1000)
Install: libpocofoundation100:amd64 (1.13.0-6+b1, automatic), mumble:amd64 (1.5.517-3), libpocozip100:amd64 (1.13.0-6+b1, automatic), libpocoxml100:amd64 (1.13.0-6+b1, automatic)
End-Date: 2025-01-04  20:02:18

Start-Date: 2025-01-05  08:57:21
Commandline: /usr/bin/unattended-upgrade
Upgrade: udev:amd64 (257.1-6, 257.1-7), systemd-timesyncd:amd64 (257.1-6, 257.1-7), libpam-systemd:amd64 (257.1-6, 257.1-7), libsystemd0:amd64 (257.1-6, 257.1-7), libsystemd0:i386 (257.1-6, 257.1-7), libnss-systemd:amd64 (257.1-6, 257.1-7), libudev-dev:amd64 (257.1-6, 257.1-7), systemd:amd64 (257.1-6, 257.1-7), libudev1:amd64 (257.1-6, 257.1-7), libudev1:i386 (257.1-6, 257.1-7), systemd-cryptsetup:amd64 (257.1-6, 257.1-7), libsystemd-shared:amd64 (257.1-6, 257.1-7), systemd-sysv:amd64 (257.1-6, 257.1-7), libsystemd-dev:amd64 (257.1-6, 257.1-7)
End-Date: 2025-01-05  08:57:47

Start-Date: 2025-01-05  08:57:50
Commandline: /usr/bin/unattended-upgrade
Install: linux-headers-6.12.8-amd64:amd64 (6.12.8-1, automatic), linux-image-6.12.8-amd64:amd64 (6.12.8-1, automatic), linux-headers-6.12.8-common:amd64 (6.12.8-1, automatic), linux-kbuild-6.12.8:amd64 (6.12.8-1, automatic)
Upgrade: linux-headers-amd64:amd64 (6.12.6-1, 6.12.8-1), linux-image-amd64:amd64 (6.12.6-1, 6.12.8-1)
End-Date: 2025-01-05  08:58:43

Start-Date: 2025-01-05  08:58:46
Commandline: /usr/bin/unattended-upgrade
Upgrade: python3-pikepdf:amd64 (9.4.2+dfsg-1, 9.5.1+dfsg-1)
End-Date: 2025-01-05  08:58:47

Start-Date: 2025-01-05  08:58:50
Commandline: /usr/bin/unattended-upgrade
Upgrade: libzxing3:amd64 (2.3.0-1, 2.3.0-2)
End-Date: 2025-01-05  08:58:51

Start-Date: 2025-01-05  08:58:54
Commandline: /usr/bin/unattended-upgrade
Remove: linux-headers-6.12.5-amd64:amd64 (6.12.5-1), linux-image-6.12.5-amd64:amd64 (6.12.5-1)
End-Date: 2025-01-05  08:58:56

Start-Date: 2025-01-05  08:58:58
Commandline: /usr/bin/unattended-upgrade
Remove: linux-headers-6.12.5-common:amd64 (6.12.5-1)
End-Date: 2025-01-05  08:59:00

Start-Date: 2025-01-05  08:59:02
Commandline: /usr/bin/unattended-upgrade
Remove: linux-kbuild-6.12.5:amd64 (6.12.5-1)
End-Date: 2025-01-05  08:59:03

Start-Date: 2025-01-05  10:50:10
Commandline: apt upgrade
Requested-By: m (1000)
Upgrade: libavahi-common-dev:amd64 (0.8-15, 0.8-16), qemu-system-x86:amd64 (1:9.2.0+ds-3+b1, 1:9.2.0+ds-4), libxxf86vm1:amd64 (1:1.1.4-1+b3, 1:1.1.4-1+b4), libxxf86vm1:i386 (1:1.1.4-1+b3, 1:1.1.4-1+b4), libnetsnmptrapd40t64:amd64 (5.9.4+dfsg-1.1+b2, 5.9.4+dfsg-1.1+b3), libcapstone5:amd64 (5.0.3-1+b1, 5.0.3-1+b2), libglu1-mesa-dev:amd64 (9.0.2-1.1+b2, 9.0.2-1.1+b3), libpciaccess-dev:amd64 (0.17-3+b2, 0.17-3+b3), libavahi-compat-libdnssd1:amd64 (0.8-15, 0.8-16), gpm:amd64 (1.20.7-11+b1, 1.20.7-11+b2), libxshmfence1:amd64 (1.3-1+b2, 1.3-1+b3), libxshmfence1:i386 (1.3-1+b2, 1.3-1+b3), qemu-system-modules-opengl:amd64 (1:9.2.0+ds-3+b1, 1:9.2.0+ds-4), libsdl2-ttf-2.0-0:amd64 (2.22.0+dfsg-1+b1, 2.24.0+dfsg-1), libonnx1t64:amd64 (1.16.2-1+b1, 1.16.2-1+b2), libxss-dev:amd64 (1:1.2.3-1+b2, 1:1.2.3-1+b3), avahi-utils:amd64 (0.8-15, 0.8-16), libpocofoundation100:amd64 (1.13.0-6+b1, 1.13.0-6+b2), libavahi-common-data:amd64 (0.8-15, 0.8-16), libavahi-common-data:i386 (0.8-15, 0.8-16), dcm!
 tk:amd64 (3.6.8-6+b1, 3.6.8-6+b2), libpciaccess0:amd64 (0.17-3+b2, 0.17-3+b3), libpciaccess0:i386 (0.17-3+b2, 0.17-3+b3), libsnmp40t64:amd64 (5.9.4+dfsg-1.1+b2, 5.9.4+dfsg-1.1+b3), libavahi-core7:amd64 (0.8-15, 0.8-16), libxmuu1:amd64 (2:1.1.3-3+b3, 2:1.1.3-3+b4), libxpresent1:amd64 (1.0.1-1+b1, 1.0.1-1+b2), liblzf1:amd64 (3.6-4+b2, 3.6-4+b3), liblua5.4-0:amd64 (5.4.7-1+b1, 5.4.7-1+b2), libgpm2:amd64 (1.20.7-11+b1, 1.20.7-11+b2), libgpm2:i386 (1.20.7-11+b1, 1.20.7-11+b2), qemu-system-modules-spice:amd64 (1:9.2.0+ds-3+b1, 1:9.2.0+ds-4), libportmidi0:amd64 (1:217-6.1+b3, 1:217-6.1+b4), libdcmtk18:amd64 (3.6.8-6+b1, 3.6.8-6+b2), avahi-daemon:amd64 (0.8-15, 0.8-16), flex:amd64 (2.6.4-8.2+b3, 2.6.4-8.2+b4), libprotoc32t64:amd64 (3.21.12-10+b1, 3.21.12-10+b2), libsnmp-dev:amd64 (5.9.4+dfsg-1.1+b2, 5.9.4+dfsg-1.1+b3), libpoppler-cpp1:amd64 (24.08.0-3, 24.08.0-4), libxmu6:amd64 (2:1.1.3-3+b3, 2:1.1.3-3+b4), libxpm4:amd64 (1:3.5.17-1+b2, 1:3.5.17-1+b3), libxpm4:i386 (1:3.5.17-1+b2, !
 1:3.5.17-1+b3), libhunspell-1.7-0:amd64 (1.7.2+really1.7.2-10+b3, 1.7.2+really1.7.2-10+b4), libopenexr-3-1-30:amd64 (3.1.5-5.1+b3, 3.1.5-5.1+b4), libxss1:amd64 (1:1.2.3-1+b2, 1:1.2.3-1+b3), libxss1:i386 (1:1.2.3-1+b2, 1:1.2.3-1+b3), poppler-utils:amd64 (24.08.0-3, 24.08.0-4), libxxf86dga1:amd64 (2:1.1.5-1+b2, 2:1.1.5-1+b3), libxfont2:amd64 (1:2.0.6-1+b2, 1:2.0.6-1+b3), libfontenc1:amd64 (1:1.1.8-1+b1, 1:1.1.8-1+b2), qemu-utils:amd64 (1:9.2.0+ds-3+b1, 1:9.2.0+ds-4), libprotobuf-lite32t64:amd64 (3.21.12-10+b1, 3.21.12-10+b2), libpocozip100:amd64 (1.13.0-6+b1, 1.13.0-6+b2), libxt6t64:amd64 (1:1.2.1-1.2+b1, 1:1.2.1-1.2+b2), libnorm1t64:amd64 (1.5.9+dfsg-3.1+b1, 1.5.9+dfsg-3.1+b2), libavahi-ui-gtk3-0:amd64 (0.8-15, 0.8-16), libopenni2-0:amd64 (2.2.0.33+dfsg-18+b1, 2.2.0.33+dfsg-18+b2), libpoppler140:amd64 (24.08.0-3, 24.08.0-4), libhtml-parser-perl:amd64 (3.83-1+b1, 3.83-1+b2), libglu1-mesa:amd64 (9.0.2-1.1+b2, 9.0.2-1.1+b3), libfl-dev:amd64 (2.6.4-8.2+b3, 2.6.4-8.2+b4), libxxhash0:amd64
  (0.8.3-1, 0.8.3-2), libprotobuf32t64:amd64 (3.21.12-10+b1, 3.!
 21.12-10+b2), hunspell:amd64 (1.7.2+really1.7.2-10+b3, 1.7.2+really1.7.2-10+b4), libavahi-client-dev:amd64 (0.8-15, 0.8-16), libavahi-common3:amd64 (0.8-15, 0.8-16), libavahi-common3:i386 (0.8-15, 0.8-16), gir1.2-poppler-0.18:amd64 (24.08.0-3, 24.08.0-4), liblognorm5:amd64 (2.0.6-4+b2, 2.0.6-4+b3), qemu-system-common:amd64 (1:9.2.0+ds-3+b1, 1:9.2.0+ds-4), libxext-dev:amd64 (2:1.3.4-1+b2, 2:1.3.4-1+b3), libdaemon0:amd64 (0.14-7.1+b2, 0.14-7.1+b3), qemu-block-extra:amd64 (1:9.2.0+ds-3+b1, 1:9.2.0+ds-4), libpoppler-glib-dev:amd64 (24.08.0-3, 24.08.0-4), libavahi-glib1:amd64 (0.8-15, 0.8-16), libxt-dev:amd64 (1:1.2.1-1.2+b1, 1:1.2.1-1.2+b2), libpoppler-dev:amd64 (24.08.0-3, 24.08.0-4), libxext6:amd64 (2:1.3.4-1+b2, 2:1.3.4-1+b3), libxext6:i386 (2:1.3.4-1+b2, 2:1.3.4-1+b3), libpocoxml100:amd64 (1.13.0-6+b1, 1.13.0-6+b2), libxv-dev:amd64 (2:1.0.11-1.1+b2, 2:1.0.11-1.1+b3), libpoppler-glib8t64:amd64 (24.08.0-3, 24.08.0-4), libxpm-dev:amd64 (1:3.5.17-1+b2, 1:3.5.17-1+b3), libxxf86v!
 m-dev:amd64 (1:1.1.4-1+b3, 1:1.1.4-1+b4), libfl2:amd64 (2.6.4-8.2+b3, 2.6.4-8.2+b4), libinih1:amd64 (58-1+b1, 58-1+b2), qemu-system-data:amd64 (1:9.2.0+ds-3, 1:9.2.0+ds-4), libavahi-client3:amd64 (0.8-15, 0.8-16), libavahi-client3:i386 (0.8-15, 0.8-16), qemu-system-gui:amd64 (1:9.2.0+ds-3+b1, 1:9.2.0+ds-4), libmikmod3:amd64 (3.3.11.1-8, 3.3.12-1), libinireader0:amd64 (58-1+b1, 58-1+b2), libxmu-dev:amd64 (2:1.1.3-3+b3, 2:1.1.3-3+b4), libxv1:amd64 (2:1.0.11-1.1+b2, 2:1.0.11-1.1+b3), libxv1:i386 (2:1.0.11-1.1+b2, 2:1.0.11-1.1+b3)
End-Date: 2025-01-05  10:50:34

Start-Date: 2025-01-06  10:06:26
Commandline: apt upgrade
Requested-By: m (1000)
Upgrade: libwrap0:amd64 (7.6.q-34, 7.6.q-35), kwayland-integration:amd64 (6.2.4-2, 6.2.5-1), firmware-carl9170:amd64 (1.9.9-399-gcd480b9-1.2, 1.9.9-450-gad1c721+dfsg-0.1), kglobalacceld:amd64 (6.2.4-1, 6.2.5-1), tasksel-data:amd64 (3.77, 3.78), libplasmaactivities6:amd64 (6.2.4-2, 6.2.5-1), pamix:amd64 (1.6~git20180112.ea4ab3b-4+b1, 2.0-1), tasksel:amd64 (3.77, 3.78), dvisvgm:amd64 (3.4.2+ds-1, 3.4.3+ds-1), kactivitymanagerd:amd64 (6.2.4-1, 6.2.5-1), gettext-base:amd64 (0.22.5-3, 0.22.5-4), libaspell15:amd64 (0.60.8.1-2, 0.60.8.1-3), autopoint:amd64 (0.22.5-3, 0.22.5-4), python3-certifi:amd64 (2024.8.30+dfsg-1, 2024.12.14+ds-1), task-german:amd64 (3.77, 3.78), gettext:amd64 (0.22.5-3, 0.22.5-4), python3-jwt:amd64 (2.7.0-1, 2.10.1-1), qbittorrent:amd64 (5.0.3-1, 5.0.3-2), cmake-data:amd64 (3.31.2-1, 3.31.3-1), tcpd:amd64 (7.6.q-34, 7.6.q-35), firmware-ath9k-htc:amd64 (1.4.0-108-gd856466+dfsg1-1.5, 1.4.0-110-ge888634+dfsg1-0.1), cmake:amd64 (3.31.2-1, 3.31.3-1), libwrap0-dev:a!
 md64 (7.6.q-34, 7.6.q-35), libkglobalacceld0:amd64 (6.2.4-1, 6.2.5-1), aspell:amd64 (0.60.8.1-2, 0.60.8.1-3)
End-Date: 2025-01-06  10:06:42

Start-Date: 2025-01-07  17:32:41
Commandline: apt upgrade
Requested-By: m (1000)
Install: python3-isoduration:amd64 (20.11.0+git20211126.ae0bd61-2, automatic), python3-fqdn:amd64 (1.5.1-2, automatic), python3-rfc3986-validator:amd64 (0.1.1-2, automatic), libpython3.13:amd64 (3.13.1-3, automatic), python3-arrow:amd64 (1.3.0-1.1, automatic), python3-rfc3339-validator:amd64 (0.1.4-2, automatic), libpython3.13-dev:amd64 (3.13.1-3, automatic), python3.13-dev:amd64 (3.13.1-3, automatic)
Upgrade: claws-mail:amd64 (4.3.0-2, 4.3.0-2+b1), libxs-parse-sublike-perl:amd64 (0.32-1, 0.33-1), libltdl7:amd64 (2.4.7-8, 2.5.4-2), libltdl7:i386 (2.4.7-8, 2.5.4-2), gstreamer1.0-plugins-ugly:amd64 (1.24.10-1, 1.24.11-1), libplasmaactivitiesstats1:amd64 (6.2.4-1, 6.2.5-1), libgtk-4-common:amd64 (4.16.7+ds-1, 4.16.12+ds-1), gstreamer1.0-gl:amd64 (1.24.10-1, 1.24.11-1), libheif1:amd64 (1.19.3-1, 1.19.5-1), libheif1:i386 (1.19.3-1, 1.19.5-1), claws-mail-pgpmime:amd64 (4.3.0-2, 4.3.0-2+b1), libheif-plugin-libde265:amd64 (1.19.3-1, 1.19.5-1), libheif-plugin-libde265:i386 (1.19.3-1, 1.19.5-1), claws-mail-tnef-parser:amd64 (4.3.0-2, 4.3.0-2+b1), systemsettings:amd64 (4:6.2.4-1, 4:6.2.5-1), claws-mail-smime-plugin:amd64 (4.3.0-2, 4.3.0-2+b1), openssl-provider-legacy:amd64 (3.4.0-1, 3.4.0-2), claws-mail-dbgsym:amd64 (4.3.0-2, 4.3.0-2+b1), libgstreamer-gl1.0-0:amd64 (1.24.10-1, 1.24.11-1), libwbclient0:amd64 (2:4.21.2+dfsg-4, 2:4.21.3+dfsg-1), dracut-install:amd64 (105-2, 105-3), gst!
 reamer1.0-alsa:amd64 (1.24.10-1, 1.24.11-1), claws-mail-vcalendar-plugin:amd64 (4.3.0-2, 4.3.0-2+b1), libheif-plugin-aomdec:amd64 (1.19.3-1, 1.19.5-1), libheif-plugin-x265:amd64 (1.19.3-1, 1.19.5-1), libheif-plugin-x265:i386 (1.19.3-1, 1.19.5-1), libheif-plugin-aomenc:amd64 (1.19.3-1, 1.19.5-1), libheif-plugin-aomenc:i386 (1.19.3-1, 1.19.5-1), diffutils:amd64 (1:3.10-1, 1:3.10-2), ipxe-qemu:amd64 (1.0.0+git-20190125.36a4c85-5.2, 1.21.1+git20220113.fbbdc3926+dfsg-1), libltdl-dev:amd64 (2.4.7-8, 2.5.4-2), python3-jsonschema:amd64 (4.19.2-5, 4.19.2-6), python3-oauthlib:amd64 (3.2.2-2, 3.2.2-3), gstreamer1.0-x:amd64 (1.24.10-1, 1.24.11-1), gstreamer1.0-x:i386 (1.24.10-1, 1.24.11-1), claws-mail-multi-notifier:amd64 (4.3.0-2, 4.3.0-2+b1), tdb-tools:amd64 (2.10.0+samba4.21.2+dfsg-4, 2.10.0+samba4.21.3+dfsg-1), gstreamer1.0-plugins-good:amd64 (1.24.10-1, 1.24.11-1), gstreamer1.0-plugins-good:i386 (1.24.10-1, 1.24.11-1), gstreamer1.0-plugins-base:amd64 (1.24.10-1, 1.24.11-1), gstrea!
 mer1.0-plugins-base:i386 (1.24.10-1, 1.24.11-1), libtdb1:amd64 (2.10.0+samba4.21.2+dfsg-4, 2.10.0+samba4.21.3+dfsg-1), libssl-dev:amd64 (3.4.0-1, 3.4.0-2), libtool:amd64 (2.4.7-8, 2.5.4-2), libgstreamer1.0-0:amd64 (1.24.10-2, 1.24.11-1), libgstreamer1.0-0:i386 (1.24.10-2, 1.24.11-1), libtevent0t64:amd64 (2.10.0+samba4.21.2+dfsg-4, 2.10.0+samba4.21.3+dfsg-1), btrfs-progs:amd64 (6.12-1, 6.12-1+b1), gstreamer1.0-vaapi:amd64 (1.24.10-1, 1.24.11-1), libgtk-4-1:amd64 (4.16.7+ds-1, 4.16.12+ds-1), gtk-update-icon-cache:amd64 (4.16.7+ds-1, 4.16.12+ds-1), libssl3t64:amd64 (3.4.0-1, 3.4.0-2), libssl3t64:i386 (3.4.0-1, 3.4.0-2), libheif-plugin-dav1d:amd64 (1.19.3-1, 1.19.5-1), libheif-plugin-dav1d:i386 (1.19.3-1, 1.19.5-1), m4:amd64 (1.4.19-4, 1.4.19-5), claws-mail-spam-report:amd64 (4.3.0-2, 4.3.0-2+b1), sysvinit-utils:amd64 (3.11-1, 3.13-1), libgtk-4-bin:amd64 (4.16.7+ds-1, 4.16.12+ds-1), libgtk-4-media-gstreamer:amd64 (4.16.7+ds-1, 4.16.12+ds-1), libgstreamer-plugins-base1.0-0:amd64 (1.24.10
 -1, 1.24.11-1), libgstreamer-plugins-base1.0-0:i386 (1.24.10-1!
 , 1.24.11-1), gstreamer1.0-libav:amd64 (1.24.10-1, 1.24.11-1), libtalloc2:amd64 (2.10.0+samba4.21.2+dfsg-4, 2.10.0+samba4.21.3+dfsg-1), dkms:amd64 (3.1.0-1, 3.1.0-2), openssl:amd64 (3.4.0-1, 3.4.0-2), librav1e0.7:amd64 (0.7.1-7+b3, 0.7.1-9), librav1e0.7:i386 (0.7.1-7+b3, 0.7.1-9)
End-Date: 2025-01-07  17:33:21

Start-Date: 2025-01-07  17:57:03
Commandline: /usr/bin/unattended-upgrade
Upgrade: python3-samba:amd64 (2:4.21.2+dfsg-4, 2:4.21.3+dfsg-1), libldb2:amd64 (2:2.10.0+samba4.21.2+dfsg-4, 2:2.10.0+samba4.21.3+dfsg-1), samba-common-bin:amd64 (2:4.21.2+dfsg-4, 2:4.21.3+dfsg-1), python3-talloc:amd64 (2.10.0+samba4.21.2+dfsg-4, 2.10.0+samba4.21.3+dfsg-1), libsmbclient0:amd64 (2:4.21.2+dfsg-4, 2:4.21.3+dfsg-1), python3-ldb:amd64 (2:2.10.0+samba4.21.2+dfsg-4, 2:2.10.0+samba4.21.3+dfsg-1), smbclient:amd64 (2:4.21.2+dfsg-4, 2:4.21.3+dfsg-1), python3-tdb:amd64 (2.10.0+samba4.21.2+dfsg-4, 2.10.0+samba4.21.3+dfsg-1), samba-libs:amd64 (2:4.21.2+dfsg-4, 2:4.21.3+dfsg-1), samba-common:amd64 (2:4.21.2+dfsg-4, 2:4.21.3+dfsg-1)
End-Date: 2025-01-07  17:57:09

Start-Date: 2025-01-08  17:56:37
Commandline: apt upgrade
Requested-By: m (1000)
Upgrade: libblkid-dev:amd64 (2.40.2-13, 2.40.2-14), libzxing3:amd64 (2.3.0-2, 2.3.0-2+b1), libsmartcols1:amd64 (2.40.2-13, 2.40.2-14), libfdt1:amd64 (1.7.2-2, 1.7.2-2+b1), libglx-mesa0:amd64 (24.2.8-1, 24.3.3-1), libglx-mesa0:i386 (24.2.8-1, 24.3.3-1), librdmacm1t64:amd64 (52.0-2+b1, 52.0-2+b2), libmount-dev:amd64 (2.40.2-13, 2.40.2-14), gdb:amd64 (15.2-1, 15.2-1+b1), gir1.2-freedesktop:amd64 (1.82.0-3, 1.82.0-3+b1), vim:amd64 (2:9.1.0967-1, 2:9.1.0967-1+b1), libgbm1:amd64 (24.2.8-1, 24.3.3-1), libgbm1:i386 (24.2.8-1, 24.3.3-1), xxd:amd64 (2:9.1.0967-1, 2:9.1.0967-1+b1), libibverbs1:amd64 (52.0-2+b1, 52.0-2+b2), hexchat-python3:amd64 (2.16.2-1+b5, 2.16.2-1+b6), libgbm-dev:amd64 (24.2.8-1, 24.3.3-1), mesa-libgallium:amd64 (24.2.8-1, 24.3.3-1), mesa-libgallium:i386 (24.2.8-1, 24.3.3-1), libplist-2.0-4:amd64 (2.6.0-2, 2.6.0-2+b1), libmount1:amd64 (2.40.2-13, 2.40.2-14), libmount1:i386 (2.40.2-13, 2.40.2-14), libllvm19:amd64 (1:19.1.6-1, 1:19.1.6-1+b1), libllvm19:i386 (1:19.1.6-!
 1, 1:19.1.6-1+b1), libxatracker2:amd64 (24.2.8-1, 24.3.3-1), python3-pyqt5:amd64 (5.15.11+dfsg-1+b1, 5.15.11+dfsg-1+b2), util-linux:amd64 (2.40.2-13, 2.40.2-14), util-linux-extra:amd64 (2.40.2-13, 2.40.2-14), hexchat-lua:amd64 (2.16.2-1+b5, 2.16.2-1+b6), hexchat-plugins:amd64 (2.16.2-1+b5, 2.16.2-1+b6), mesa-va-drivers:amd64 (24.2.8-1, 24.3.3-1), fdisk:amd64 (2.40.2-13, 2.40.2-14), libgl1-mesa-dri:amd64 (24.2.8-1, 24.3.3-1), libgl1-mesa-dri:i386 (24.2.8-1, 24.3.3-1), libosmesa6:amd64 (24.2.8-1, 24.3.3-1), libosmesa6:i386 (24.2.8-1, 24.3.3-1), libvolume-key1:amd64 (0.3.12-8, 0.3.12-8+b1), libegl1-mesa-dev:amd64 (24.2.8-1, 24.3.3-1), libfdisk1:amd64 (2.40.2-13, 2.40.2-14), eject:amd64 (2.40.2-13, 2.40.2-14), libgirepository-1.0-1:amd64 (1.82.0-3, 1.82.0-3+b1), hexchat:amd64 (2.16.2-1+b5, 2.16.2-1+b6), gir1.2-girepository-2.0:amd64 (1.82.0-3, 1.82.0-3+b1), gir1.2-freedesktop-dev:amd64 (1.82.0-3, 1.82.0-3+b1), libnvme1t64:amd64 (1.11.1-1, 1.11.1-1+b1), libgstreamer-plugins-bad1!
 .0-0:amd64 (1.24.10-3, 1.24.11-1), libuuid1:amd64 (2.40.2-13, 2.40.2-14), libimath-3-1-29t64:amd64 (3.1.12-1+b1, 3.1.12-1+b2), sharutils:amd64 (1:4.15.2-9, 1:4.15.2-10), uuid-runtime:amd64 (2.40.2-13, 2.40.2-14), vim-tiny:amd64 (2:9.1.0967-1, 2:9.1.0967-1+b1), mesa-vulkan-drivers:amd64 (24.2.8-1, 24.3.3-1), mesa-vulkan-drivers:i386 (24.2.8-1, 24.3.3-1), libnss3:amd64 (2:3.106-1, 2:3.107-1), libyuv0:amd64 (0.0.1898.20241219-1, 0.0.1899.20250103-1), libyuv0:i386 (0.0.1898.20241219-1, 0.0.1899.20250103-1), python3-pil.imagetk:amd64 (10.4.0-1+b1, 10.4.0-1.1), login:amd64 (1:4.16.0-2+really2.40.2-13, 1:4.16.0-2+really2.40.2-14), uuid-dev:amd64 (2.40.2-13, 2.40.2-14), libunbound8:amd64 (1.22.0-1, 1.22.0-1+b1), python3-jwt:amd64 (2.10.1-1, 2.10.1-2), libminiupnpc18:amd64 (2.2.8-2+b1, 2.2.8-2+b2), python3-pil:amd64 (10.4.0-1+b1, 10.4.0-1.1), ibverbs-providers:amd64 (52.0-2+b1, 52.0-2+b2), rfkill:amd64 (2.40.2-13, 2.40.2-14), libglapi-mesa:amd64 (24.2.8-1, 24.3.3-1), libglapi-mesa:i386 (24.2
 .8-1, 24.3.3-1), mount:amd64 (2.40.2-13, 2.40.2-14), libcompfa!
 ceg1:amd64 (1:1.5.2-6, 1:1.5.2-6.1), hexchat-perl:amd64 (2.16.2-1+b5, 2.16.2-1+b6), libblkid1:amd64 (2.40.2-13, 2.40.2-14), libblkid1:i386 (2.40.2-13, 2.40.2-14), gstreamer1.0-plugins-bad:amd64 (1.24.10-3, 1.24.11-1), libegl-mesa0:amd64 (24.2.8-1, 24.3.3-1), libjs-sphinxdoc:amd64 (8.1.3-3, 8.1.3-4), mesa-vdpau-drivers:amd64 (24.2.8-1, 24.3.3-1), bsdutils:amd64 (1:2.40.2-13, 1:2.40.2-14), python3-dbus.mainloop.pyqt5:amd64 (5.15.11+dfsg-1+b1, 5.15.11+dfsg-1+b2), bsdextrautils:amd64 (2.40.2-13, 2.40.2-14), wdiff:amd64 (1.2.2-6, 1.2.2-7)
End-Date: 2025-01-08  17:57:04

Start-Date: 2025-01-10  17:49:17
Commandline: /usr/bin/unattended-upgrade
Upgrade: python3.12:amd64 (3.12.8-3, 3.12.8-4), python3.12-tk:amd64 (3.12.8-3, 3.12.8-4), libpython3.12-minimal:amd64 (3.12.8-3, 3.12.8-4), python3.12-venv:amd64 (3.12.8-3, 3.12.8-4), libpython3.12t64:amd64 (3.12.8-3, 3.12.8-4), python3.12-gdbm:amd64 (3.12.8-3, 3.12.8-4), libpython3.12-dev:amd64 (3.12.8-3, 3.12.8-4), python3.12-dev:amd64 (3.12.8-3, 3.12.8-4), python3.12-minimal:amd64 (3.12.8-3, 3.12.8-4), libpython3.12-stdlib:amd64 (3.12.8-3, 3.12.8-4)
End-Date: 2025-01-10  17:49:26

Start-Date: 2025-01-10  17:49:29
Commandline: /usr/bin/unattended-upgrade
Upgrade: ruby-concurrent:amd64 (1.2.3-4, 1.3.4-1~exp1)
End-Date: 2025-01-10  17:49:30

Start-Date: 2025-01-10  17:49:34
Commandline: /usr/bin/unattended-upgrade
Upgrade: udev:amd64 (257.1-7, 257.2-1), systemd-timesyncd:amd64 (257.1-7, 257.2-1), libpam-systemd:amd64 (257.1-7, 257.2-1), libsystemd0:amd64 (257.1-7, 257.2-1), libsystemd0:i386 (257.1-7, 257.2-1), libnss-systemd:amd64 (257.1-7, 257.2-1), libudev-dev:amd64 (257.1-7, 257.2-1), systemd:amd64 (257.1-7, 257.2-1), libudev1:amd64 (257.1-7, 257.2-1), libudev1:i386 (257.1-7, 257.2-1), systemd-cryptsetup:amd64 (257.1-7, 257.2-1), libsystemd-shared:amd64 (257.1-7, 257.2-1), systemd-sysv:amd64 (257.1-7, 257.2-1), libsystemd-dev:amd64 (257.1-7, 257.2-1)
End-Date: 2025-01-10  17:49:58

Start-Date: 2025-01-10  17:50:00
Commandline: /usr/bin/unattended-upgrade
Upgrade: fontconfig:amd64 (2.15.0-1.1+b1, 2.15.0-2), libfontconfig1-dev:amd64 (2.15.0-1.1+b1, 2.15.0-2), libfontconfig-dev:amd64 (2.15.0-1.1+b1, 2.15.0-2), libfontconfig1:amd64 (2.15.0-1.1+b1, 2.15.0-2), libfontconfig1:i386 (2.15.0-1.1+b1, 2.15.0-2), fontconfig-config:amd64 (2.15.0-1.1+b1, 2.15.0-2)
End-Date: 2025-01-10  17:50:33

Start-Date: 2025-01-10  17:50:36
Commandline: /usr/bin/unattended-upgrade
Upgrade: libicu72:amd64 (72.1-5+b1, 72.1-6), libicu72:i386 (72.1-5+b1, 72.1-6)
End-Date: 2025-01-10  17:50:38

Start-Date: 2025-01-10  17:50:41
Commandline: /usr/bin/unattended-upgrade
Upgrade: libpng-dev:amd64 (1.6.44-3, 1.6.45-1), libpng-tools:amd64 (1.6.44-3, 1.6.45-1), libpng16-16t64:amd64 (1.6.44-3, 1.6.45-1), libpng16-16t64:i386 (1.6.44-3, 1.6.45-1)
End-Date: 2025-01-10  17:50:45

Start-Date: 2025-01-10  17:50:47
Commandline: /usr/bin/unattended-upgrade
Upgrade: tzdata:amd64 (2024b-4, 2024b-5), tzdata-legacy:amd64 (2024b-4, 2024b-5)
End-Date: 2025-01-10  17:50:49

Start-Date: 2025-01-10  17:50:52
Commandline: /usr/bin/unattended-upgrade
Upgrade: libatopology2t64:amd64 (1.2.13-1, 1.2.13-1+b1), libasound2t64:amd64 (1.2.13-1, 1.2.13-1+b1), libasound2t64:i386 (1.2.13-1, 1.2.13-1+b1), libasound2-dev:amd64 (1.2.13-1, 1.2.13-1+b1)
End-Date: 2025-01-10  17:50:53

Start-Date: 2025-01-10  17:50:56
Commandline: /usr/bin/unattended-upgrade
Upgrade: glib-networking-common:amd64 (2.80.0-1, 2.80.1-1), glib-networking-services:amd64 (2.80.0-1, 2.80.1-1), glib-networking:amd64 (2.80.0-1, 2.80.1-1), glib-networking:i386 (2.80.0-1, 2.80.1-1)
End-Date: 2025-01-10  17:50:58

Start-Date: 2025-01-10  17:51:00
Commandline: /usr/bin/unattended-upgrade
Upgrade: mumble:amd64 (1.5.517-3, 1.5.735-1)
End-Date: 2025-01-10  17:51:03

Start-Date: 2025-01-10  17:51:06
Commandline: /usr/bin/unattended-upgrade
Upgrade: libpq5:amd64 (17.2-1, 17.2-1+b1)
End-Date: 2025-01-10  17:51:07

Start-Date: 2025-01-10  17:51:10
Commandline: /usr/bin/unattended-upgrade
Upgrade: libctf-nobfd0:amd64 (2.43.50.20241230-1, 2.43.50.20250108-1), libbinutils:amd64 (2.43.50.20241230-1, 2.43.50.20250108-1), binutils-x86-64-linux-gnu:amd64 (2.43.50.20241230-1, 2.43.50.20250108-1), libctf0:amd64 (2.43.50.20241230-1, 2.43.50.20250108-1), binutils-common:amd64 (2.43.50.20241230-1, 2.43.50.20250108-1), libsframe1:amd64 (2.43.50.20241230-1, 2.43.50.20250108-1), libgprofng0:amd64 (2.43.50.20241230-1, 2.43.50.20250108-1), binutils:amd64 (2.43.50.20241230-1, 2.43.50.20250108-1)
End-Date: 2025-01-10  17:51:14

Start-Date: 2025-01-10  17:51:17
Commandline: /usr/bin/unattended-upgrade
Upgrade: libgstreamer-plugins-bad1.0-0:amd64 (1.24.11-1, 1.24.11-2), gstreamer1.0-plugins-bad:amd64 (1.24.11-1, 1.24.11-2)
End-Date: 2025-01-10  17:51:18

Start-Date: 2025-01-10  17:51:21
Commandline: /usr/bin/unattended-upgrade
Upgrade: libzbar0t64:amd64 (0.23.93-6, 0.23.93-6+b1)
End-Date: 2025-01-10  17:51:22

Start-Date: 2025-01-10  17:51:25
Commandline: /usr/bin/unattended-upgrade
Upgrade: lrzsz:amd64 (0.12.21rc-0.1, 0.12.21rc-0.2)
End-Date: 2025-01-10  17:51:27

Start-Date: 2025-01-10  17:51:30
Commandline: /usr/bin/unattended-upgrade
Upgrade: libtorrent-rasterbar2.0t64:amd64 (2.0.10-1.1+b3, 2.0.10-1.1+b4)
End-Date: 2025-01-10  17:51:31

Start-Date: 2025-01-10  19:38:01
Commandline: apt upgrade
Requested-By: m (1000)
Upgrade: libblkid-dev:amd64 (2.40.2-14, 2.40.3-1), liborcus-parser-0.18-0:amd64 (0.19.2-6, 0.19.2-6+b1), libwireshark-data:amd64 (4.4.2-1, 4.4.3-1), libwebpmux3:amd64 (1.4.0-0.1+b1, 1.5.0-0.1), libsmartcols1:amd64 (2.40.2-14, 2.40.3-1), libimobiledevice-1.0-6:amd64 (1.3.0+git20240701-4, 1.3.0+git20240701-4+b1), libexif-dev:amd64 (0.6.24-1+b2, 0.6.24-2), libsharpyuv0:amd64 (1.4.0-0.1+b1, 1.5.0-0.1), libsharpyuv0:i386 (1.4.0-0.1+b1, 1.5.0-0.1), liballegro5-dev:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), liballegro-video5.2t64:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), libmount-dev:amd64 (2.40.2-14, 2.40.3-1), gir1.2-freedesktop:amd64 (1.82.0-3+b1, 1.82.0-4), libx86-1:amd64 (1.1+ds1-12, 1.1+ds1-13), liballegro-audio5.2t64:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), tasksel-data:amd64 (3.78, 3.79), libwebpdecoder3:amd64 (1.4.0-0.1+b1, 1.5.0-0.1), xdg-desktop-portal-gtk:amd64 (1.15.1-1+b1, 1.15.2-1), libwebp-dev:amd64 (1.4.0-0.1+b1, 1.5.0-0.1), x11-common:amd64 (1:7.7+23.1!
 , 1:7.7+23.2), libwsutil16:amd64 (4.4.2-1, 4.4.3-1), tasksel:amd64 (3.78, 3.79), liballegro-acodec5-dev:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), xserver-xorg-input-all:amd64 (1:7.7+23.1, 1:7.7+23.2), libwebpdemux2:amd64 (1.4.0-0.1+b1, 1.5.0-0.1), libtcl8.6:amd64 (8.6.15+dfsg-2, 8.6.16+dfsg-1), liballegro5.2t64:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), libmount1:amd64 (2.40.2-14, 2.40.3-1), libmount1:i386 (2.40.2-14, 2.40.3-1), libwbclient0:amd64 (2:4.21.3+dfsg-1, 2:4.21.3+dfsg-1+b1), xserver-xorg:amd64 (1:7.7+23.1, 1:7.7+23.2), util-linux:amd64 (2.40.2-14, 2.40.3-1), libtk8.6:amd64 (8.6.15-1, 8.6.16-1), liballegro-acodec5.2t64:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), util-linux-extra:amd64 (2.40.2-14, 2.40.3-1), libwiretap15:amd64 (4.4.2-1, 4.4.3-1), fdisk:amd64 (2.40.2-14, 2.40.3-1), ddccontrol-db:amd64 (20240920-1, 20250106-1), libwireshark18:amd64 (4.4.2-1, 4.4.3-1), libfdisk1:amd64 (2.40.2-14, 2.40.3-1), liballegro-physfs5-dev:amd64 (2:5.2.10.0+dfsg-1, 2:5!
 .2.10.1+dfsg-1), eject:amd64 (2.40.2-14, 2.40.3-1), libgudev-1.0-0:amd64 (238-5+b1, 238-6), libgudev-1.0-0:i386 (238-5+b1, 238-6), libgirepository-1.0-1:amd64 (1.82.0-3+b1, 1.82.0-4), gir1.2-girepository-2.0:amd64 (1.82.0-3+b1, 1.82.0-4), gir1.2-freedesktop-dev:amd64 (1.82.0-3+b1, 1.82.0-4), libgstreamer-plugins-bad1.0-0:amd64 (1.24.11-2, 1.24.11-3), wireshark-common:amd64 (4.4.2-1, 4.4.3-1), tdb-tools:amd64 (2.10.0+samba4.21.3+dfsg-1, 2.10.0+samba4.21.3+dfsg-1+b1), libuuid1:amd64 (2.40.2-14, 2.40.3-1), gstreamer1.0-plugins-good:amd64 (1.24.11-1, 1.24.11-2), gstreamer1.0-plugins-good:i386 (1.24.11-1, 1.24.11-2), uuid-runtime:amd64 (2.40.2-14, 2.40.3-1), liborcus-0.18-0:amd64 (0.19.2-6, 0.19.2-6+b1), libtdb1:amd64 (2.10.0+samba4.21.3+dfsg-1, 2.10.0+samba4.21.3+dfsg-1+b1), liballegro-physfs5.2t64:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), login:amd64 (1:4.16.0-2+really2.40.2-14, 1:4.16.0-2+really2.40.3-1), tcl8.6:amd64 (8.6.15+dfsg-2, 8.6.16+dfsg-1), uuid-dev:amd64 (2.40.2-14, 2.40
 .3-1), tshark:amd64 (4.4.2-1, 4.4.3-1), libwebp7:amd64 (1.4.0-!
 0.1+b1, 1.5.0-0.1), libwebp7:i386 (1.4.0-0.1+b1, 1.5.0-0.1), task-german:amd64 (3.78, 3.79), liballegro-ttf5.2t64:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), liballegro-image5.2t64:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), libtevent0t64:amd64 (2.10.0+samba4.21.3+dfsg-1, 2.10.0+samba4.21.3+dfsg-1+b1), rfkill:amd64 (2.40.2-14, 2.40.3-1), mount:amd64 (2.40.2-14, 2.40.3-1), liballegro-audio5-dev:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), libblkid1:amd64 (2.40.2-14, 2.40.3-1), libblkid1:i386 (2.40.2-14, 2.40.3-1), gstreamer1.0-plugins-bad:amd64 (1.24.11-2, 1.24.11-3), tk8.6:amd64 (8.6.15-1, 8.6.16-1), liballegro-image5-dev:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), xserver-xorg-video-all:amd64 (1:7.7+23.1, 1:7.7+23.2), liballegro-video5-dev:amd64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), libtalloc2:amd64 (2.10.0+samba4.21.3+dfsg-1, 2.10.0+samba4.21.3+dfsg-1+b1), wireshark:amd64 (4.4.2-1, 4.4.3-1), libsharpyuv-dev:amd64 (1.4.0-0.1+b1, 1.5.0-0.1), liballegro-ttf5-dev:amd!
 64 (2:5.2.10.0+dfsg-1, 2:5.2.10.1+dfsg-1), bsdutils:amd64 (1:2.40.2-14, 1:2.40.3-1), bsdextrautils:amd64 (2.40.2-14, 2.40.3-1), libexif12:amd64 (0.6.24-1+b2, 0.6.24-2), libexif12:i386 (0.6.24-1+b2, 0.6.24-2), linux-libc-dev:amd64 (6.12.8-1, 6.12.9-1)
End-Date: 2025-01-10  19:38:32

Start-Date: 2025-01-11  11:20:31
Commandline: apt upgrade
Requested-By: m (1000)
Upgrade: vlc-plugin-qt:amd64 (3.0.21-2, 3.0.21-3), libvlc5:amd64 (3.0.21-2, 3.0.21-3), ruby-sdbm:amd64 (1.0.0-5+b5, 1.0.0-5+b6), ruby-ffi:amd64 (1.17.0+dfsg-1+b1, 1.17.0+dfsg-1+b2), libreoffice-sdbc-postgresql:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), uno-libs-private:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), manpages-de:amd64 (4.25.0-1, 4.25.1-1), vlc-data:amd64 (3.0.21-2, 3.0.21-3), osc:amd64 (1.10.1-1, 1.11.1-1), libvlccore9:amd64 (3.0.21-2, 3.0.21-3), libuno-sal3t64:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), libreoffice-report-builder-bin:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), ure:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), vim:amd64 (2:9.1.0967-1+b1, 2:9.1.0967-2), vlc:amd64 (3.0.21-2, 3.0.21-3), xxd:amd64 (2:9.1.0967-1+b1, 2:9.1.0967-2), vlc-bin:amd64 (3.0.21-2, 3.0.21-3), vim-common:amd64 (2:9.1.0967-1, 2:9.1.0967-2), linux-cpupower:amd64 (6.12.8-1, 6.12.9-1), libruby:amd64 (1:3.1+support3.3~0, 1:3.1+support3.3), libprotoc32t64:amd64 (3.21.12-10+b2, 3.21.12-10+b3), ruby-ed25519:amd64 (1.3.0+ds-1+b6, 1.!
 3.0+ds-1+b7), vlc-plugin-samba:amd64 (3.0.21-2, 3.0.21-3), libprotobuf-lite32t64:amd64 (3.21.12-10+b2, 3.21.12-10+b3), vim-tiny:amd64 (2:9.1.0967-1+b1, 2:9.1.0967-2), vlc-plugin-notify:amd64 (3.0.21-2, 3.0.21-3), ruby:amd64 (1:3.1+support3.3~0, 1:3.1+support3.3), libreoffice-sdbc-mysql:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), libreoffice-sdbc-firebird:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), libprotobuf32t64:amd64 (3.21.12-10+b2, 3.21.12-10+b3), vim-runtime:amd64 (2:9.1.0967-1, 2:9.1.0967-2), libreoffice-sdbc-hsqldb:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), vlc-plugin-access-extra:amd64 (3.0.21-2, 3.0.21-3), ruby-oj:amd64 (3.16.3-1+b3, 3.16.3-1+b4), vlc-plugin-skins2:amd64 (3.0.21-2, 3.0.21-3), vlc-plugin-video-splitter:amd64 (3.0.21-2, 3.0.21-3), vlc-plugin-video-output:amd64 (3.0.21-2, 3.0.21-3), libical3t64:amd64 (3.0.19-1, 3.0.19-3), libcpupower1:amd64 (6.12.8-1, 6.12.9-1), ruby-libvirt:amd64 (0.8.4-1, 0.8.4-1+b1), libuno-cppu3t64:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), ure-java:amd64 (4:24.8.!
 4-1, 4:24.8.4-1+b1), libuno-cppuhelpergcc3-3t64:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), at-spi2-common:amd64 (2.54.0-1, 2.55.0-1), libuno-purpenvhelpergcc3-3t64:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), libuno-salhelpergcc3-3t64:amd64 (4:24.8.4-1, 4:24.8.4-1+b1), libvlc-bin:amd64 (3.0.21-2, 3.0.21-3), vlc-plugin-base:amd64 (3.0.21-2, 3.0.21-3), ruby-bcrypt-pbkdf:amd64 (1.1.1-1+b1, 1.1.1-1+b2), vlc-plugin-visualization:amd64 (3.0.21-2, 3.0.21-3), ruby-nokogiri:amd64 (1.16.4+dfsg-1, 1.16.4+dfsg-1+b1)
End-Date: 2025-01-11  11:20:47

Start-Date: 2025-01-11  16:27:34
Commandline: apt upgrade
Requested-By: m (1000)
Install: libtag2:amd64 (2.0.2-1, automatic), libtag2:i386 (2.0.2-1, automatic)
Upgrade: vlc-plugin-qt:amd64 (3.0.21-3, 3.0.21-5), libvlc5:amd64 (3.0.21-3, 3.0.21-5), libnet-dns-perl:amd64 (1.48-1, 1.49-1), libxs-parse-sublike-perl:amd64 (0.33-1, 0.35-1), libatk-bridge2.0-dev:amd64 (2.54.0-1, 2.55.0-1), vlc-data:amd64 (3.0.21-3, 3.0.21-5), libvlccore9:amd64 (3.0.21-3, 3.0.21-5), vlc:amd64 (3.0.21-3, 3.0.21-5), vlc-bin:amd64 (3.0.21-3, 3.0.21-5), at-spi2-core:amd64 (2.54.0-1, 2.55.0-1), libatspi2.0-dev:amd64 (2.54.0-1, 2.55.0-1), kio-extras:amd64 (4:24.12.0-1, 4:24.12.0-2), libwbclient0:amd64 (2:4.21.3+dfsg-1+b1, 2:4.21.3+dfsg-4), libatspi2.0-0t64:amd64 (2.54.0-1, 2.55.0-1), vlc-plugin-samba:amd64 (3.0.21-3, 3.0.21-5), tdb-tools:amd64 (2.10.0+samba4.21.3+dfsg-1+b1, 2.10.0+samba4.21.3+dfsg-4), libatk1.0-dev:amd64 (2.54.0-1, 2.55.0-1), gstreamer1.0-plugins-good:amd64 (1.24.11-2, 1.24.11-2+b1), gstreamer1.0-plugins-good:i386 (1.24.11-2, 1.24.11-2+b1), vlc-plugin-notify:amd64 (3.0.21-3, 3.0.21-5), libtdb1:amd64 (2.10.0+samba4.21.3+dfsg-1+b1, 2.10.0+samba4.21!
 .3+dfsg-4), libatk1.0-0t64:amd64 (2.54.0-1, 2.55.0-1), gir1.2-atk-1.0:amd64 (2.54.0-1, 2.55.0-1), libtevent0t64:amd64 (2.10.0+samba4.21.3+dfsg-1+b1, 2.10.0+samba4.21.3+dfsg-4), vlc-plugin-access-extra:amd64 (3.0.21-3, 3.0.21-5), vlc-plugin-skins2:amd64 (3.0.21-3, 3.0.21-5), vlc-plugin-video-splitter:amd64 (3.0.21-3, 3.0.21-5), vlc-plugin-video-output:amd64 (3.0.21-3, 3.0.21-5), kio-extras-data:amd64 (4:24.12.0-1, 4:24.12.0-2), libatk-bridge2.0-0t64:amd64 (2.54.0-1, 2.55.0-1), libtalloc2:amd64 (2.10.0+samba4.21.3+dfsg-1+b1, 2.10.0+samba4.21.3+dfsg-4), libcpanel-json-xs-perl:amd64 (4.38-1+b1, 4.39-1), libvlc-bin:amd64 (3.0.21-3, 3.0.21-5), gir1.2-atspi-2.0:amd64 (2.54.0-1, 2.55.0-1), vlc-plugin-base:amd64 (3.0.21-3, 3.0.21-5), vlc-plugin-visualization:amd64 (3.0.21-3, 3.0.21-5)
End-Date: 2025-01-11  16:27:49

Start-Date: 2025-01-12  11:58:35
Commandline: apt upgrade
Requested-By: m (1000)
Install: libmupdf25.1:amd64 (1.25.1+ds1-5, automatic), libruby3.3:amd64 (3.3.6-1, automatic), libkf6i18nqml6:amd64 (6.10.0-1, automatic)
Upgrade: libkirigamidelegates6:amd64 (6.8.0-2, 6.10.0-1), libkf6wallet-data:amd64 (6.8.0-2, 6.10.0-1), libgomp1:amd64 (14.2.0-12, 14.2.0-13), libgomp1:i386 (14.2.0-12, 14.2.0-13), libkf6authcore6:amd64 (6.8.0-1, 6.10.0-1), libkf6widgetsaddons6:amd64 (6.8.0-1, 6.10.0-1), libkf6coreaddons6:amd64 (6.8.0-1, 6.10.0-1), python3.12:amd64 (3.12.8-4, 3.12.8-5), libgcc-14-dev:amd64 (14.2.0-12, 14.2.0-13), libstdc++-14-dev:amd64 (14.2.0-12, 14.2.0-13), libkf6solid-data:amd64 (6.8.0-1, 6.10.0-1), g++-14:amd64 (14.2.0-12, 14.2.0-13), libkf6service6:amd64 (6.8.0-1, 6.10.0-1), libkf6textwidgets-data:amd64 (6.8.0-1, 6.10.0-1), gcc-14:amd64 (14.2.0-12, 14.2.0-13), python3.12-tk:amd64 (3.12.8-4, 3.12.8-5), libkf6kcmutils6:amd64 (6.8.0-1, 6.10.0-1), libkf6bookmarkswidgets6:amd64 (6.8.0-1, 6.10.0-1), libkf6itemviews6:amd64 (6.8.0-1, 6.10.0-1), libtsan2:amd64 (14.2.0-12, 14.2.0-13), libkf6sonnetcore6:amd64 (6.8.0-1, 6.10.0-1), libkf6syntaxhighlighting-data:amd64 (6.8.0-1, 6.10.0-1), libkf6dbusad!
 dons6:amd64 (6.8.0-1, 6.10.0-1), libkf6wallet6:amd64 (6.8.0-2, 6.10.0-1), libkirigamilayouts6:amd64 (6.8.0-2, 6.10.0-1), libkf6i18n-data:amd64 (6.8.0-2, 6.10.0-1), libkf6kiogui6:amd64 (6.8.0-1, 6.10.0-1), libkf6kcmutils-data:amd64 (6.8.0-1, 6.10.0-1), libkirigamiprivate6:amd64 (6.8.0-2, 6.10.0-1), libkf6configwidgets-data:amd64 (6.8.0-1, 6.10.0-1), g++-14-x86-64-linux-gnu:amd64 (14.2.0-12, 14.2.0-13), libkf6windowsystem-data:amd64 (6.8.0-2, 6.10.0-1), libkf6kiowidgets6:amd64 (6.8.0-1, 6.10.0-1), libkf6kcmutils-bin:amd64 (6.8.0-1, 6.10.0-1), libkf6configwidgets6:amd64 (6.8.0-1, 6.10.0-1), libkf6doctools6:amd64 (6.8.0-1, 6.10.0-1), libkf6auth-data:amd64 (6.8.0-1, 6.10.0-1), kwallet6:amd64 (6.8.0-2, 6.10.0-1), libkf6config-bin:amd64 (6.8.0-1, 6.10.0-1), libhwasan0:amd64 (14.2.0-12, 14.2.0-13), libxcursor1:amd64 (1:1.2.2-1+b1, 1:1.2.3-1), libxcursor1:i386 (1:1.2.2-1+b1, 1:1.2.3-1), libkf6colorscheme6:amd64 (6.8.0-1, 6.10.0-1), libkf6codecs-data:amd64 (6.8.0-1, 6.10.0-1), libkf6!
 guiaddons-data:amd64 (6.8.0-1, 6.10.0-1), kio6:amd64 (6.8.0-1, 6.10.0-1), remmina-plugin-rdp:amd64 (1.4.37+dfsg-1, 1.4.39+dfsg-1), libpython3.12-minimal:amd64 (3.12.8-4, 3.12.8-5), remmina-plugin-vnc:amd64 (1.4.37+dfsg-1, 1.4.39+dfsg-1), libkf6coreaddons-data:amd64 (6.8.0-1, 6.10.0-1), libkf6colorscheme-data:amd64 (6.8.0-1, 6.10.0-1), libkf6sonnet-data:amd64 (6.8.0-1, 6.10.0-1), libgfortran5:amd64 (14.2.0-12, 14.2.0-13), libkf6windowsystem6:amd64 (6.8.0-2, 6.10.0-1), libkf6syntaxhighlighting6:amd64 (6.8.0-1, 6.10.0-1), libkf6parts-data:amd64 (6.8.0-1, 6.10.0-1), gcc-14-x86-64-linux-gnu:amd64 (14.2.0-12, 14.2.0-13), libwbclient0:amd64 (2:4.21.3+dfsg-4, 2:4.21.3+dfsg-5), libkf6completion-data:amd64 (6.8.0-1, 6.10.0-1), libkf6i18n6:amd64 (6.8.0-2, 6.10.0-1), libkirigami6:amd64 (6.8.0-2, 6.10.0-1), libkf6codecs6:amd64 (6.8.0-1, 6.10.0-1), libcc1-0:amd64 (14.2.0-12, 14.2.0-13), libgrpc29t64:amd64 (1.51.1-5+b1, 1.51.1-5+b2), libkf6jobwidgets6:amd64 (6.8.0-1, 6.10.0-1), libkf6solid6:amd64 
 (6.8.0-1, 6.10.0-1), python3.12-venv:amd64 (3.12.8-4, 3.12.8-5!
 ), libkf6bookmarks-data:amd64 (6.8.0-1, 6.10.0-1), libkf6kcmutilsquick6:amd64 (6.8.0-1, 6.10.0-1), remmina-plugin-secret:amd64 (1.4.37+dfsg-1, 1.4.39+dfsg-1), libkf6runner6:amd64 (6.8.0-1, 6.10.0-1), remmina:amd64 (1.4.37+dfsg-1, 1.4.39+dfsg-1), libkf6globalaccel6:amd64 (6.8.0-1, 6.10.0-1), libkf6dbusaddons-bin:amd64 (6.8.0-1, 6.10.0-1), libpython3.12t64:amd64 (3.12.8-4, 3.12.8-5), libkirigamidialogs6:amd64 (6.8.0-2, 6.10.0-1), libkf6iconwidgets6:amd64 (6.8.0-1, 6.10.0-1), libtext-markdown-discount-perl:amd64 (0.16-1+b3, 0.17-1), libkirigamiprimitives6:amd64 (6.8.0-2, 6.10.0-1), libasan8:amd64 (14.2.0-12, 14.2.0-13), libkf6notifications6:amd64 (6.8.0-1, 6.10.0-1), libkf6itemmodels6:amd64 (6.8.0-1, 6.10.0-1), libkf6service-data:amd64 (6.8.0-1, 6.10.0-1), libkf6notifications-data:amd64 (6.8.0-1, 6.10.0-1), libkirigamiplatform6:amd64 (6.8.0-2, 6.10.0-1), tdb-tools:amd64 (2.10.0+samba4.21.3+dfsg-4, 2:1.4.12+samba4.21.3+dfsg-5), libkf6configcore6:amd64 (6.8.0-1, 6.10.0-1), kded6!
 :amd64 (6.8.0-1, 6.10.0-1), libkf6sonnetui6:amd64 (6.8.0-1, 6.10.0-1), libtag2:amd64 (2.0.2-1, 2.0.2-2), libtag2:i386 (2.0.2-1, 2.0.2-2), libkf6xmlgui-data:amd64 (6.8.0-1, 6.10.0-1), libkf6jobwidgets-data:amd64 (6.8.0-1, 6.10.0-1), libkf6breezeicons6:amd64 (6.8.0-2, 6.10.0-1), libtdb1:amd64 (2.10.0+samba4.21.3+dfsg-4, 2:1.4.12+samba4.21.3+dfsg-5), libxcursor-dev:amd64 (1:1.2.2-1+b1, 1:1.2.3-1), libkf6service-bin:amd64 (6.8.0-1, 6.10.0-1), python3.12-gdbm:amd64 (3.12.8-4, 3.12.8-5), kf6-breeze-icon-theme:amd64 (6.8.0-2, 6.10.0-1), cpp-14:amd64 (14.2.0-12, 14.2.0-13), libitm1:amd64 (14.2.0-12, 14.2.0-13), libkf6iconthemes-data:amd64 (6.8.0-1, 6.10.0-1), libkf6xmlgui6:amd64 (6.8.0-1, 6.10.0-1), libkf6bookmarks6:amd64 (6.8.0-1, 6.10.0-1), libtevent0t64:amd64 (2.10.0+samba4.21.3+dfsg-4, 2:0.16.1+samba4.21.3+dfsg-5), libkf6kiocore6:amd64 (6.8.0-1, 6.10.0-1), libkf6guiaddons6:amd64 (6.8.0-1, 6.10.0-1), libkf6dbusaddons-data:amd64 (6.8.0-1, 6.10.0-1), libkf6config-data:amd64 (6.8.0-1, 6.10.
 0-1), bash-completion:amd64 (1:2.16.0-1, 1:2.16.0-2), libpytho!
 n3.12-dev:amd64 (3.12.8-4, 3.12.8-5), libkf6walletbackend6:amd64 (6.8.0-2, 6.10.0-1), intel-gpu-tools:amd64 (1.29-1, 1.30-1), qml6-module-org-kde-kirigami:amd64 (6.8.0-2, 6.10.0-1), libkf6archive-data:amd64 (6.8.0-1, 6.10.0-1), libkf6crash6:amd64 (6.8.0-1, 6.10.0-1), cpp-14-x86-64-linux-gnu:amd64 (14.2.0-12, 14.2.0-13), python3.12-dev:amd64 (3.12.8-4, 3.12.8-5), libkf6guiaddons-bin:amd64 (6.8.0-1, 6.10.0-1), libquadmath0:amd64 (14.2.0-12, 14.2.0-13), libtext-csv-xs-perl:amd64 (1.57-1, 1.59-1), libkf6globalaccel-data:amd64 (6.8.0-1, 6.10.0-1), libkf6kiofilewidgets6:amd64 (6.8.0-1, 6.10.0-1), libubsan1:amd64 (14.2.0-12, 14.2.0-13), liblsan0:amd64 (14.2.0-12, 14.2.0-13), mupdf-tools:amd64 (1.24.10+ds1-1, 1.25.1+ds1-5), libkf6textwidgets6:amd64 (6.8.0-1, 6.10.0-1), remmina-common:amd64 (1.4.37+dfsg-1, 1.4.39+dfsg-1), python3.12-minimal:amd64 (3.12.8-4, 3.12.8-5), libcgi-pm-perl:amd64 (4.66-1, 4.67-1), libkf6widgetsaddons-data:amd64 (6.8.0-1, 6.10.0-1), libobjc4:amd64 (14.2.0-12!
 , 14.2.0-13), libkf6iconthemes6:amd64 (6.8.0-1, 6.10.0-1), libkf6archive6:amd64 (6.8.0-1, 6.10.0-1), ruby-grpc:amd64 (1.51.1-5+b1, 1.51.1-5+b2), libkf6completion6:amd64 (6.8.0-1, 6.10.0-1), libtalloc2:amd64 (2.10.0+samba4.21.3+dfsg-4, 2:2.4.2+samba4.21.3+dfsg-5), libkf6configgui6:amd64 (6.8.0-1, 6.10.0-1), libpython3.12-stdlib:amd64 (3.12.8-4, 3.12.8-5), libkf6parts6:amd64 (6.8.0-1, 6.10.0-1), libstdc++6:amd64 (14.2.0-12, 14.2.0-13), libstdc++6:i386 (14.2.0-12, 14.2.0-13), libatomic1:amd64 (14.2.0-12, 14.2.0-13), libatomic1:i386 (14.2.0-12, 14.2.0-13), libkirigami-data:amd64 (6.8.0-2, 6.10.0-1), libkf6itemviews-data:amd64 (6.8.0-1, 6.10.0-1), gcc-14-base:amd64 (14.2.0-12, 14.2.0-13), gcc-14-base:i386 (14.2.0-12, 14.2.0-13), libgcc-s1:amd64 (14.2.0-12, 14.2.0-13), libgcc-s1:i386 (14.2.0-12, 14.2.0-13), libkf6kcmutilscore6:amd64 (6.8.0-1, 6.10.0-1)
End-Date: 2025-01-12  11:59:17

Start-Date: 2025-01-13  11:13:43
Commandline: apt upgrade
Requested-By: m (1000)
Install: linux-headers-6.12.9-common:amd64 (6.12.9-1, automatic), linux-headers-6.12.9-amd64:amd64 (6.12.9-1, automatic), linux-kbuild-6.12.9:amd64 (6.12.9-1, automatic), linux-image-6.12.9-amd64:amd64 (6.12.9-1, automatic)
Upgrade: qemu-system-x86:amd64 (1:9.2.0+ds-4, 1:9.2.0+ds-5), qemu-system-modules-opengl:amd64 (1:9.2.0+ds-4, 1:9.2.0+ds-5), qemu-system-modules-spice:amd64 (1:9.2.0+ds-4, 1:9.2.0+ds-5), libclutter-gtk-1.0-0:amd64 (1.8.4-4+b3, 1.8.4-5), libxs-parse-keyword-perl:amd64 (0.47-1, 0.48-1), linux-headers-amd64:amd64 (6.12.8-1, 6.12.9-1), qemu-utils:amd64 (1:9.2.0+ds-4, 1:9.2.0+ds-5), linux-image-amd64:amd64 (6.12.8-1, 6.12.9-1), python3-dns:amd64 (4.0.2-2, 4.0.2-3), mariadb-common:amd64 (1:11.4.4-2, 1:11.4.4-3), qemu-system-common:amd64 (1:9.2.0+ds-4, 1:9.2.0+ds-5), bash-completion:amd64 (1:2.16.0-2, 1:2.16.0-4), qemu-block-extra:amd64 (1:9.2.0+ds-4, 1:9.2.0+ds-5), libmariadb3:amd64 (1:11.4.4-2, 1:11.4.4-3), qemu-system-data:amd64 (1:9.2.0+ds-4, 1:9.2.0+ds-5), qemu-system-gui:amd64 (1:9.2.0+ds-4, 1:9.2.0+ds-5)
End-Date: 2025-01-13  11:14:49

Start-Date: 2025-01-13  14:31:48
Commandline: apt autopurge
Requested-By: m (1000)
Purge: python3-setuptools-scm:amd64 (8.1.0-1), python3-colorama:amd64 (0.4.6-4), libcapstone4:amd64 (4.0.2-5.1+b1), libxcb-dri2-0:i386 (1.17.0-2+b1), linux-headers-6.12.6-common:amd64 (6.12.6-1), libtag1v5:amd64 (1.13.1-2), libtag1v5:i386 (1.13.1-2), libdirectfb-1.7-7t64:amd64 (1.7.7-13), usrmerge:amd64 (39+nmu2), linux-headers-6.12.6-amd64:amd64 (6.12.6-1), linux-kbuild-6.12.6:amd64 (6.12.6-1), linux-image-6.12.6-amd64:amd64 (6.12.6-1), libtag1v5-vanilla:amd64 (1.13.1-2), libtag1v5-vanilla:i386 (1.13.1-2)
End-Date: 2025-01-13  14:32:02

Start-Date: 2025-01-14  16:32:50
Commandline: apt upgrade
Requested-By: m (1000)
Install: libtheoraenc1:amd64 (1.2.0~alpha1+dfsg-2, automatic), libtheoraenc1:i386 (1.2.0~alpha1+dfsg-2, automatic), libtheoradec1:amd64 (1.2.0~alpha1+dfsg-2, automatic), libtheoradec1:i386 (1.2.0~alpha1+dfsg-2, automatic)
Upgrade: libblkid-dev:amd64 (2.40.3-1, 2.40.4-1), libpolkit-agent-1-0:amd64 (125-2, 126-1), libsmartcols1:amd64 (2.40.3-1, 2.40.4-1), libmount-dev:amd64 (2.40.3-1, 2.40.4-1), polkitd:amd64 (125-2, 126-1), tzdata:amd64 (2024b-5, 2024b-6), libpango-1.0-0:amd64 (1.55.0+ds-3, 1.56.0-3), libpango-1.0-0:i386 (1.55.0+ds-3, 1.56.0-3), yt-dlp:amd64 (2024.12.23-1, 2025.01.12-1), libmount1:amd64 (2.40.3-1, 2.40.4-1), libmount1:i386 (2.40.3-1, 2.40.4-1), libwbclient0:amd64 (2:4.21.3+dfsg-5, 2:4.21.3+dfsg-6), python3-zeroconf:amd64 (0.136.2-1, 0.139.0-4), util-linux:amd64 (2.40.3-1, 2.40.4-1), libdconf1:amd64 (0.40.0-4+b3, 0.40.0-5), util-linux-extra:amd64 (2.40.3-1, 2.40.4-1), rubygems-integration:amd64 (1.18, 1.19), fdisk:amd64 (2.40.3-1, 2.40.4-1), libruby3.3:amd64 (3.3.6-1, 3.3.6-1.1), ipxe-qemu:amd64 (1.21.1+git20220113.fbbdc3926+dfsg-1, 1.21.1+git20220113.fbbdc3926+dfsg-2), libobject-pad-perl:amd64 (0.816-1, 0.819-1), libfdisk1:amd64 (2.40.3-1, 2.40.4-1), python3-fonttools:amd64 (4!
 .55.0-3, 4.55.3-1), devscripts:amd64 (2.24.10, 2.25.1), libonnxruntime1.19.2:amd64 (1.19.2+dfsg-2, 1.19.2+dfsg-4), eject:amd64 (2.40.3-1, 2.40.4-1), gnome-2048:amd64 (3.38.2-3+b2, 3.38.2-4), libpangocairo-1.0-0:amd64 (1.55.0+ds-3, 1.56.0-3), libpangocairo-1.0-0:i386 (1.55.0+ds-3, 1.56.0-3), tdb-tools:amd64 (2:1.4.12+samba4.21.3+dfsg-5, 2:1.4.12+samba4.21.3+dfsg-6), libuuid1:amd64 (2.40.3-1, 2.40.4-1), uuid-runtime:amd64 (2.40.3-1, 2.40.4-1), python3-numpy:amd64 (1:1.26.4+ds-12, 1:1.26.4+ds-13), libfreerdp3-3:amd64 (3.10.2+dfsg-1, 3.10.3+dfsg-1), libpangoft2-1.0-0:amd64 (1.55.0+ds-3, 1.56.0-3), libpangoft2-1.0-0:i386 (1.55.0+ds-3, 1.56.0-3), libtheora0:amd64 (1.1.1+dfsg.1-17, 1.2.0~alpha1+dfsg-2), libtheora0:i386 (1.1.1+dfsg.1-17, 1.2.0~alpha1+dfsg-2), libpolkit-gobject-1-0:amd64 (125-2, 126-1), libtdb1:amd64 (2:1.4.12+samba4.21.3+dfsg-5, 2:1.4.12+samba4.21.3+dfsg-6), mdadm:amd64 (4.3+20241202-1.1, 4.4-1), pango1.0-tools:amd64 (1.55.0+ds-3, 1.56.0-3), login:amd64 (1:4.16.0-2!
 +really2.40.3-1, 1:4.16.0-2+really2.40.4-1), gir1.2-polkit-1.0:amd64 (125-2, 126-1), uuid-dev:amd64 (2.40.3-1, 2.40.4-1), libwinpr3-3:amd64 (3.10.2+dfsg-1, 3.10.3+dfsg-1), libtevent0t64:amd64 (2:0.16.1+samba4.21.3+dfsg-5, 2:0.16.1+samba4.21.3+dfsg-6), tzdata-legacy:amd64 (2024b-5, 2024b-6), gir1.2-pango-1.0:amd64 (1.55.0+ds-3, 1.56.0-3), rfkill:amd64 (2.40.3-1, 2.40.4-1), ruby3.1:amd64 (3.1.2-8.4, 3.1.2-8.5), libruby3.1t64:amd64 (3.1.2-8.4, 3.1.2-8.5), mount:amd64 (2.40.3-1, 2.40.4-1), dconf-gsettings-backend:amd64 (0.40.0-4+b3, 0.40.0-5), pkexec:amd64 (125-2, 126-1), libfreerdp-client3-3:amd64 (3.10.2+dfsg-1, 3.10.3+dfsg-1), libtheora-dev:amd64 (1.1.1+dfsg.1-17, 1.2.0~alpha1+dfsg-2), python3-pygments:amd64 (2.18.0+dfsg-1, 2.18.0+dfsg-2), libblkid1:amd64 (2.40.3-1, 2.40.4-1), libblkid1:i386 (2.40.3-1, 2.40.4-1), python3-chardet:amd64 (5.2.0+dfsg-1, 5.2.0+dfsg-2), libpangoxft-1.0-0:amd64 (1.55.0+ds-3, 1.56.0-3), dconf-service:amd64 (0.40.0-4+b3, 0.40.0-5), google-earth-pro-stable:amd
 64 (7.3.6.10155-r0, 7.3.6.10201-r0), libopenmpt0t64:amd64 (0.7!
 .12-1, 0.7.13-1), libtalloc2:amd64 (2:2.4.2+samba4.21.3+dfsg-5, 2:2.4.2+samba4.21.3+dfsg-6), bsdutils:amd64 (1:2.40.3-1, 1:2.40.4-1), libpango1.0-dev:amd64 (1.55.0+ds-3, 1.56.0-3), bsdextrautils:amd64 (2.40.3-1, 2.40.4-1)
End-Date: 2025-01-14  16:34:00

Start-Date: 2025-01-14  20:47:22
Commandline: apt upgrade
Requested-By: m (1000)
Upgrade: microsoft-edge-stable:amd64 (131.0.2903.112-1, 131.0.2903.147-1)
End-Date: 2025-01-14  20:47:34

--MP_/.hlhHp+T9GvqNyhPt6vYIOp--
