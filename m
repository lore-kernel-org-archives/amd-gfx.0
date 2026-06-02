Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9108ACD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 08:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B3B10FACC;
	Wed,  3 Jun 2026 08:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="k5D4xum6";
	dkim-atps=neutral
X-Greylist: delayed 326 seconds by postgrey-1.36 at gabe;
 Tue, 02 Jun 2026 10:28:07 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [194.59.206.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 333EE10EE8B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 10:28:07 +0000 (UTC)
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gV6Mz0nPKz4GwW;
 Tue,  2 Jun 2026 12:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1780395759;
 bh=VYFhJ3VCcrIBuRdl3r/r1EM5IvJPKKXIzX/hIQ1d56k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k5D4xum6akIUIi3miuK3NAE9l+heKaYxwhD6k4JGoPeJAars48ej66kT1h5vuxC3d
 4VYLcSNhTEhXFyoodk1xPvtG3HrS+i/ZezB/OE3iGYTCxAtUAdmK4uxxBnN4PTRObC
 j4J3AjuJ4C5K8gQp5BiMciYJVf7raqphz0Ujar2sFYWYIqDhxqaNyf2Q4MUUaRJ2Ag
 ftb9guYkDg+wyAizoP7J0fX6Ut8jE/RJHKlMyBaHOnaXugkuI0EH+PM/aE5BtUz164
 4YT0HT5Y0Q/ce3xU2G/JFjh3K2/nVMxRROe2FSHPWk343sfBD3t8liq09O6d1GGAVp
 unEN2qjI1lMIw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gV6Mz053mz7yrb;
 Tue,  2 Jun 2026 12:22:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gV6Mw3BQPz8tdq;
 Tue,  2 Jun 2026 12:22:36 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id C73AC6031E;
 Tue,  2 Jun 2026 12:22:35 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <59f38ae7-2d5a-4dcf-bff9-7e58c36f36d4@leemhuis.info>
Date: Tue, 2 Jun 2026 12:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] RIP: 0010:vce_v1_0_set_powergating_state+0x5b8/0x600
 [amdgpu]
To: Tj <tj.iam.tj@proton.me>, regressions@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <ah6q-k5wvRbW6k6e@mail.iam.tj>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <ah6q-k5wvRbW6k6e@mail.iam.tj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178039575615.3965615.5598947623154553667@mxe9fb.netcup.net>
X-NC-CID: lyDu3goblGvLSHN3vEvDpAjnjT/QF6hkpZOMBqUgIo4boZWFu2M=
X-Mailman-Approved-At: Wed, 03 Jun 2026 08:57:50 +0000
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

On 6/2/26 12:06, Tj wrote:
> Repeatedly hit this with 7.1-rc6. I haven't yet got time to do a bisect.
> 
> $ lspci -nnk -d ::0300
> 0a:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde GL [FirePro W4100] [1002:682c]
>         Subsystem: Dell Device [1028:2b1e]
>         Kernel driver in use: amdgpu
>         Kernel modules: radeon, amdgpu
> 
> $ journalctl --boot 5e39a2d49af2432c8f14f2a866a6b275 --priority=warning
> ...
> Jun 02 09:25:11 sunny kernel: Linux version 7.1.0-rc6+debian+tj (linux@iam.tj) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #446 SMP PREEMPT_DYNAMIC Mon Jun  1 07:32:2>
> ...
> Jun 02 09:25:11 sunny kernel: WARNING: drivers/gpu/drm/amd/amdgpu/vce_v1_0.c:329 at vce_v1_0_set_powergating_state+0x5b8/0x600 [amdgpu], CPU#8: (udev-worker)/251

Thx for reporting this. This is not my area of expertise, but from a
very quick look that seems to be the issue
https://gitlab.freedesktop.org/drm/amd/-/work_items/5336
for which Timur sent a fix:

drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on all SI
https://lore.kernel.org/all/20260525112204.12604-1-timur.kristof@gmail.com/

According to Alex it's making it's way through the ranks. Consider
testing it to ensure it really is the same problem.

Ciao, Thorsten

> Jun 02 09:25:11 sunny kernel: Modules linked in: evdev joydev hid_generic dm_mod amdgpu(+) drm_buddy amdxcp drm_panel_backlight_quirks usbhid gpu_sched hid drm_ttm_helper sd_mod ttm drm_client_>
> Jun 02 09:25:11 sunny kernel: CPU: 8 UID: 0 PID: 251 Comm: (udev-worker) Not tainted 7.1.0-rc6+debian+tj #446 PREEMPT(lazy)
> Jun 02 09:25:11 sunny kernel: Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 6254 01/05/2026
> Jun 02 09:25:11 sunny kernel: RIP: 0010:vce_v1_0_set_powergating_state+0x5b8/0x600 [amdgpu]
> Jun 02 09:25:11 sunny kernel: Code: c2 ad 47 d6 c1 48 c7 c7 a8 4e 87 c1 e8 a1 02 45 f3 f6 05 05 77 dc 00 40 0f 84 ac fe ff ff e9 52 0b 92 00 0f 0b e9 52 fe ff ff <0f> 0b 31 c9 be 0b 80 00 00 48>
> Jun 02 09:25:11 sunny kernel: RSP: 0018:ffffceacc081b850 EFLAGS: 00010206
> Jun 02 09:25:11 sunny kernel: RAX: 0000000000000000 RBX: 0000000000226000 RCX: 0000000000000000
> Jun 02 09:25:11 sunny kernel: RDX: 0000000000266000 RSI: 000000000000800a RDI: ffff8b47a3880000
> Jun 02 09:25:11 sunny kernel: RBP: ffff8b47a3880000 R08: ffffceacc081b888 R09: 0000000000000000
> Jun 02 09:25:11 sunny kernel: R10: 0000000088b80000 R11: 0000000000011170 R12: 0000000000276000
> Jun 02 09:25:11 sunny kernel: R13: ffff8b47a38d4d98 R14: 0000000000000009 R15: ffffffffc0aad220
> Jun 02 09:25:11 sunny kernel: FS:  00007fae0d7059c0(0000) GS:ffff8b4ed8f10000(0000) knlGS:0000000000000000
> Jun 02 09:25:11 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 02 09:25:11 sunny kernel: CR2: 000055d37be98f18 CR3: 000000010299b000 CR4: 0000000000350ef0
> Jun 02 09:25:11 sunny kernel: Call Trace:
> Jun 02 09:25:11 sunny kernel:  <TASK>
> Jun 02 09:25:11 sunny kernel:  amdgpu_device_ip_set_powergating_state+0xaa/0x1b0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  si_dpm_set_power_state+0xd54/0x18e0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? __pfx_vce_v1_0_hw_init+0x10/0x10 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_change_power_state_locked.isra.0+0x2e0/0x570 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_compute_clocks+0xa5/0xf0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  vce_v1_0_hw_init+0x97/0xb0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  amdgpu_device_init.cold+0x1ca4/0x22a3 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? pci_conf1_read+0xab/0xf0
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? pci_bus_read_config_word+0x4c/0x80
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? do_pci_enable_device+0x121/0x190
> Jun 02 09:25:11 sunny kernel:  amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  amdgpu_pci_probe+0x1e9/0x4d0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  local_pci_probe+0x41/0x90
> Jun 02 09:25:11 sunny kernel:  pci_device_probe+0xe4/0x2b0
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? sysfs_do_create_link_sd+0x6e/0xe0
> Jun 02 09:25:11 sunny kernel:  really_probe+0xde/0x380
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? __pfx___driver_attach+0x10/0x10
> Jun 02 09:25:11 sunny kernel:  __driver_probe_device+0x84/0x150
> Jun 02 09:25:11 sunny kernel:  driver_probe_device+0x1f/0xa0
> Jun 02 09:25:11 sunny kernel:  __driver_attach+0xba/0x1f0
> Jun 02 09:25:11 sunny kernel:  bus_for_each_dev+0x8e/0xe0
> Jun 02 09:25:11 sunny kernel:  bus_add_driver+0x11f/0x200
> Jun 02 09:25:11 sunny kernel:  driver_register+0x72/0xd0
> Jun 02 09:25:11 sunny kernel:  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  do_one_initcall+0x5c/0x320
> Jun 02 09:25:11 sunny kernel:  do_init_module+0x60/0x250
> Jun 02 09:25:11 sunny kernel:  init_module_from_file+0xd6/0x130
> Jun 02 09:25:11 sunny kernel:  idempotent_init_module+0x114/0x310
> Jun 02 09:25:11 sunny kernel:  __x64_sys_finit_module+0x71/0xe0
> Jun 02 09:25:11 sunny kernel:  do_syscall_64+0xea/0x640
> Jun 02 09:25:11 sunny kernel:  ? do_syscall_64+0x9f/0x640
> Jun 02 09:25:11 sunny kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Jun 02 09:25:11 sunny kernel: RIP: 0033:0x7fae0e2637b9
> Jun 02 09:25:11 sunny kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48>
> Jun 02 09:25:11 sunny kernel: RSP: 002b:00007fff609daf68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> Jun 02 09:25:11 sunny kernel: RAX: ffffffffffffffda RBX: 000055d37be9a7c0 RCX: 00007fae0e2637b9
> Jun 02 09:25:11 sunny kernel: RDX: 0000000000000000 RSI: 000055d37be9c660 RDI: 0000000000000020
> Jun 02 09:25:11 sunny kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> Jun 02 09:25:11 sunny kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000055d37be9c660
> Jun 02 09:25:11 sunny kernel: R13: 0000000000020000 R14: 000055d37be96e90 R15: 0000000000000000
> Jun 02 09:25:11 sunny kernel:  </TASK>
> Jun 02 09:25:11 sunny kernel: ---[ end trace 0000000000000000 ]---
> Jun 02 09:25:11 sunny kernel: ------------[ cut here ]------------
> un 02 09:25:11 sunny kernel: WARNING: drivers/gpu/drm/amd/amdgpu/vce_v1_0.c:336 at vce_v1_0_set_powergating_state+0x5ea/0x600 [amdgpu], CPU#8: (udev-worker)/251
> Jun 02 09:25:11 sunny kernel: Modules linked in: evdev joydev hid_generic dm_mod amdgpu(+) drm_buddy amdxcp drm_panel_backlight_quirks usbhid gpu_sched hid drm_ttm_helper sd_mod ttm drm_client_>
> Jun 02 09:25:11 sunny kernel: CPU: 8 UID: 0 PID: 251 Comm: (udev-worker) Tainted: G        W           7.1.0-rc6+debian+tj #446 PREEMPT(lazy)
> Jun 02 09:25:11 sunny kernel: Tainted: [W]=WARN
> Jun 02 09:25:11 sunny kernel: Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 6254 01/05/2026
> Jun 02 09:25:11 sunny kernel: RIP: 0010:vce_v1_0_set_powergating_state+0x5ea/0x600 [amdgpu]
> Jun 02 09:25:11 sunny kernel: Code: 00 48 89 ef e8 87 ae f5 ff 31 c9 ba 00 00 01 00 48 89 ef be 0c 80 00 00 e8 73 ae f5 ff 41 f7 c4 ff 7f 00 00 0f 84 ff fd ff ff <0f> 0b e9 f8 fd ff ff 66 66 2e>
> Jun 02 09:25:11 sunny kernel: RSP: 0018:ffffceacc081b850 EFLAGS: 00010206
> Jun 02 09:25:11 sunny kernel: RAX: 0000000000000000 RBX: 0000000000226000 RCX: 0000000000000000
> Jun 02 09:25:11 sunny kernel: RDX: 0000000000010000 RSI: 000000000000800c RDI: ffff8b47a3880000
> Jun 02 09:25:11 sunny kernel: RBP: ffff8b47a3880000 R08: ffffceacc081b888 R09: 0000000000000000
> Jun 02 09:25:11 sunny kernel: R10: 0000000088b80000 R11: 0000000000011170 R12: 0000000000276000
> Jun 02 09:25:11 sunny kernel: R13: ffff8b47a38d4d98 R14: 0000000000000009 R15: ffffffffc0aad220
> Jun 02 09:25:11 sunny kernel: FS:  00007fae0d7059c0(0000) GS:ffff8b4ed8f10000(0000) knlGS:0000000000000000
> Jun 02 09:25:11 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 02 09:25:11 sunny kernel: CR2: 000055d37be98f18 CR3: 000000010299b000 CR4: 0000000000350ef0
> Jun 02 09:25:11 sunny kernel: Call Trace:
> Jun 02 09:25:11 sunny kernel:  <TASK>
> Jun 02 09:25:11 sunny kernel:  amdgpu_device_ip_set_powergating_state+0xaa/0x1b0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  si_dpm_set_power_state+0xd54/0x18e0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? __pfx_vce_v1_0_hw_init+0x10/0x10 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_change_power_state_locked.isra.0+0x2e0/0x570 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_compute_clocks+0xa5/0xf0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  vce_v1_0_hw_init+0x97/0xb0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  amdgpu_device_init.cold+0x1ca4/0x22a3 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? pci_conf1_read+0xab/0xf0
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? pci_bus_read_config_word+0x4c/0x80
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? do_pci_enable_device+0x121/0x190
> Jun 02 09:25:11 sunny kernel:  amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  amdgpu_pci_probe+0x1e9/0x4d0 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  local_pci_probe+0x41/0x90
> Jun 02 09:25:11 sunny kernel:  pci_device_probe+0xe4/0x2b0
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? sysfs_do_create_link_sd+0x6e/0xe0
> Jun 02 09:25:11 sunny kernel:  really_probe+0xde/0x380
> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:11 sunny kernel:  ? __pfx___driver_attach+0x10/0x10
> Jun 02 09:25:11 sunny kernel:  __driver_probe_device+0x84/0x150
> Jun 02 09:25:11 sunny kernel:  driver_probe_device+0x1f/0xa0
> Jun 02 09:25:11 sunny kernel:  __driver_attach+0xba/0x1f0
> Jun 02 09:25:11 sunny kernel:  bus_for_each_dev+0x8e/0xe0
> Jun 02 09:25:11 sunny kernel:  bus_add_driver+0x11f/0x200
> Jun 02 09:25:11 sunny kernel:  driver_register+0x72/0xd0
> Jun 02 09:25:11 sunny kernel:  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> Jun 02 09:25:11 sunny kernel:  do_one_initcall+0x5c/0x320
> Jun 02 09:25:11 sunny kernel:  do_init_module+0x60/0x250
> Jun 02 09:25:11 sunny kernel:  init_module_from_file+0xd6/0x130
> Jun 02 09:25:11 sunny kernel:  idempotent_init_module+0x114/0x310
> Jun 02 09:25:11 sunny kernel:  __x64_sys_finit_module+0x71/0xe0
> Jun 02 09:25:11 sunny kernel:  do_syscall_64+0xea/0x640
> Jun 02 09:25:11 sunny kernel:  ? do_syscall_64+0x9f/0x640
> Jun 02 09:25:11 sunny kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Jun 02 09:25:11 sunny kernel: RIP: 0033:0x7fae0e2637b9
> Jun 02 09:25:11 sunny kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48>
> Jun 02 09:25:11 sunny kernel: RSP: 002b:00007fff609daf68 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> Jun 02 09:25:11 sunny kernel: RAX: ffffffffffffffda RBX: 000055d37be9a7c0 RCX: 00007fae0e2637b9
> Jun 02 09:25:11 sunny kernel: RDX: 0000000000000000 RSI: 000055d37be9c660 RDI: 0000000000000020
> Jun 02 09:25:11 sunny kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> Jun 02 09:25:11 sunny kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000055d37be9c660
> Jun 02 09:25:11 sunny kernel: R13: 0000000000020000 R14: 000055d37be96e90 R15: 0000000000000000
> Jun 02 09:25:11 sunny kernel:  </TASK>
> Jun 02 09:25:11 sunny kernel: ---[ end trace 0000000000000000 ]---
> Jun 02 09:25:11 sunny kernel: amdgpu 0000:0a:00.0: VCE busy: VCE_STATUS=0x100, SRBM_STATUS2=0x0
> 
> 
> $ sudo lspci -vvnnk -d ::0300
> 0a:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde GL [FirePro W4100] [1002:682c] (prog-if 00 [VGA controller])
>         Subsystem: Dell Device [1028:2b1e]
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 86
>         IOMMU group: 16
>         Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
>         Region 2: Memory at fce00000 (64-bit, non-prefetchable) [size=256K]
>         Region 4: I/O ports at d000 [size=256]
>         Expansion ROM at 000c0000 [disabled] [size=128K]
>         Capabilities: [48] Vendor Specific Information: Len=08 <?>
>         Capabilities: [50] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [58] Express (v2) Legacy Endpoint, IntMsgNum 0
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 256 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 8GT/s, Width x16
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
>                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                          AtomicOpsCtl: ReqEn-
>                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee00000  Data: 0000
>         Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
>         Capabilities: [150 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 CESta:  RxErr- BadTLP+ BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [200 v1] Physical Resizable BAR
>                 BAR 0: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB
>         Capabilities: [270 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>                 LaneErrStat: LaneErr at lane: 6
>         Kernel driver in use: amdgpu
>         Kernel modules: radeon, amdgpu
> 
> 

