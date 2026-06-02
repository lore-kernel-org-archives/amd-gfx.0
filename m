Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F05CCD6E6D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 08:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6968610FAE8;
	Wed,  3 Jun 2026 08:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="U2MK6Y/n";
	dkim-atps=neutral
X-Greylist: delayed 1384 seconds by postgrey-1.36 at gabe;
 Tue, 02 Jun 2026 10:29:11 UTC
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF7F10EE8E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1780396148; x=1780655348;
 bh=Ps3BeSaIN+cFaDTrCg33BpAK7kq/PwD0EyF9XARctp8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=U2MK6Y/nJG93usNNo+k3l6ticr9KDHJi581QUPvThrogqgl43MfjOKaJElfUMae8F
 SBpiipQiIAlrVcnyexDeBuj/Hv/8EHnSFOXZlQ4Rsr7NmNGOcI9uya9+S3AG6BJw3y
 9aoxnpHReYx+52jmf/ouTwZ0K4xVu/IBjr4YsuxvSclnn+CtiA/tYHoVrAPAMDWs74
 YsclOEqDnecgW6iGm8V8JJ4k4LrCAs7j0zquGNZajOHHRd1I6t9qapWaytGXyqz1m1
 gRVXN2YhTMBwquZjGZen3r7f+Nwv1RS0R6vULBFyixqpdWbZbnULEXA9un63O64cst
 DW+nkmTYTL+jg==
Date: Tue, 02 Jun 2026 10:29:01 +0000
To: Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev
From: Tj <tj.iam.tj@proton.me>
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?utf-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [REGRESSION] RIP: 0010:vce_v1_0_set_powergating_state+0x5b8/0x600
 [amdgpu]
Message-ID: <aa7b7f17-fcd4-44ba-b2a9-80001f31feb0@proton.me>
In-Reply-To: <59f38ae7-2d5a-4dcf-bff9-7e58c36f36d4@leemhuis.info>
References: <ah6q-k5wvRbW6k6e@mail.iam.tj>
 <59f38ae7-2d5a-4dcf-bff9-7e58c36f36d4@leemhuis.info>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: cc5ceb1ab9cfcb52adb25d3e186087c4911dfa87
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Thorsten, thanks for the almost instant pointer to the potential fix.=20
I've grabbed the patch and will do a build and test later today, once=20
I've also got a potential fix for the bluetooth/input regression that=20
hung my workstation.

On 02/06/2026 10:22, Thorsten Leemhuis wrote:
> On 6/2/26 12:06, Tj wrote:
>> Repeatedly hit this with 7.1-rc6. I haven't yet got time to do a bisect.
>>
>> $ lspci -nnk -d ::0300
>> 0a:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [=
AMD/ATI] Cape Verde GL [FirePro W4100] [1002:682c]
>>          Subsystem: Dell Device [1028:2b1e]
>>          Kernel driver in use: amdgpu
>>          Kernel modules: radeon, amdgpu
>>
>> $ journalctl --boot 5e39a2d49af2432c8f14f2a866a6b275 --priority=3Dwarnin=
g
>> ...
>> Jun 02 09:25:11 sunny kernel: Linux version 7.1.0-rc6+debian+tj (linux@i=
am.tj) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.4=
4) #446 SMP PREEMPT_DYNAMIC Mon Jun  1 07:32:2>
>> ...
>> Jun 02 09:25:11 sunny kernel: WARNING: drivers/gpu/drm/amd/amdgpu/vce_v1=
_0.c:329 at vce_v1_0_set_powergating_state+0x5b8/0x600 [amdgpu], CPU#8: (ud=
ev-worker)/251
> Thx for reporting this. This is not my area of expertise, but from a
> very quick look that seems to be the issue
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5336
> for which Timur sent a fix:
>
> drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on all SI
> https://lore.kernel.org/all/20260525112204.12604-1-timur.kristof@gmail.co=
m/
>
> According to Alex it's making it's way through the ranks. Consider
> testing it to ensure it really is the same problem.
>
> Ciao, Thorsten
>
>> Jun 02 09:25:11 sunny kernel: Modules linked in: evdev joydev hid_generi=
c dm_mod amdgpu(+) drm_buddy amdxcp drm_panel_backlight_quirks usbhid gpu_s=
ched hid drm_ttm_helper sd_mod ttm drm_client_>
>> Jun 02 09:25:11 sunny kernel: CPU: 8 UID: 0 PID: 251 Comm: (udev-worker)=
 Not tainted 7.1.0-rc6+debian+tj #446 PREEMPT(lazy)
>> Jun 02 09:25:11 sunny kernel: Hardware name: System manufacturer System =
Product Name/PRIME X370-PRO, BIOS 6254 01/05/2026
>> Jun 02 09:25:11 sunny kernel: RIP: 0010:vce_v1_0_set_powergating_state+0=
x5b8/0x600 [amdgpu]
>> Jun 02 09:25:11 sunny kernel: Code: c2 ad 47 d6 c1 48 c7 c7 a8 4e 87 c1 =
e8 a1 02 45 f3 f6 05 05 77 dc 00 40 0f 84 ac fe ff ff e9 52 0b 92 00 0f 0b =
e9 52 fe ff ff <0f> 0b 31 c9 be 0b 80 00 00 48>
>> Jun 02 09:25:11 sunny kernel: RSP: 0018:ffffceacc081b850 EFLAGS: 0001020=
6
>> Jun 02 09:25:11 sunny kernel: RAX: 0000000000000000 RBX: 000000000022600=
0 RCX: 0000000000000000
>> Jun 02 09:25:11 sunny kernel: RDX: 0000000000266000 RSI: 000000000000800=
a RDI: ffff8b47a3880000
>> Jun 02 09:25:11 sunny kernel: RBP: ffff8b47a3880000 R08: ffffceacc081b88=
8 R09: 0000000000000000
>> Jun 02 09:25:11 sunny kernel: R10: 0000000088b80000 R11: 000000000001117=
0 R12: 0000000000276000
>> Jun 02 09:25:11 sunny kernel: R13: ffff8b47a38d4d98 R14: 000000000000000=
9 R15: ffffffffc0aad220
>> Jun 02 09:25:11 sunny kernel: FS:  00007fae0d7059c0(0000) GS:ffff8b4ed8f=
10000(0000) knlGS:0000000000000000
>> Jun 02 09:25:11 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
>> Jun 02 09:25:11 sunny kernel: CR2: 000055d37be98f18 CR3: 000000010299b00=
0 CR4: 0000000000350ef0
>> Jun 02 09:25:11 sunny kernel: Call Trace:
>> Jun 02 09:25:11 sunny kernel:  <TASK>
>> Jun 02 09:25:11 sunny kernel:  amdgpu_device_ip_set_powergating_state+0x=
aa/0x1b0 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  si_dpm_set_power_state+0xd54/0x18e0 [amdg=
pu]
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? __pfx_vce_v1_0_hw_init+0x10/0x10 [amdgp=
u]
>> Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_change_power_state_locked.isra=
.0+0x2e0/0x570 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_compute_clocks+0xa5/0xf0 [amdg=
pu]
>> Jun 02 09:25:11 sunny kernel:  vce_v1_0_hw_init+0x97/0xb0 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  amdgpu_device_init.cold+0x1ca4/0x22a3 [am=
dgpu]
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? pci_conf1_read+0xab/0xf0
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? pci_bus_read_config_word+0x4c/0x80
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? do_pci_enable_device+0x121/0x190
>> Jun 02 09:25:11 sunny kernel:  amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  amdgpu_pci_probe+0x1e9/0x4d0 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  local_pci_probe+0x41/0x90
>> Jun 02 09:25:11 sunny kernel:  pci_device_probe+0xe4/0x2b0
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? sysfs_do_create_link_sd+0x6e/0xe0
>> Jun 02 09:25:11 sunny kernel:  really_probe+0xde/0x380
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? __pfx___driver_attach+0x10/0x10
>> Jun 02 09:25:11 sunny kernel:  __driver_probe_device+0x84/0x150
>> Jun 02 09:25:11 sunny kernel:  driver_probe_device+0x1f/0xa0
>> Jun 02 09:25:11 sunny kernel:  __driver_attach+0xba/0x1f0
>> Jun 02 09:25:11 sunny kernel:  bus_for_each_dev+0x8e/0xe0
>> Jun 02 09:25:11 sunny kernel:  bus_add_driver+0x11f/0x200
>> Jun 02 09:25:11 sunny kernel:  driver_register+0x72/0xd0
>> Jun 02 09:25:11 sunny kernel:  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  do_one_initcall+0x5c/0x320
>> Jun 02 09:25:11 sunny kernel:  do_init_module+0x60/0x250
>> Jun 02 09:25:11 sunny kernel:  init_module_from_file+0xd6/0x130
>> Jun 02 09:25:11 sunny kernel:  idempotent_init_module+0x114/0x310
>> Jun 02 09:25:11 sunny kernel:  __x64_sys_finit_module+0x71/0xe0
>> Jun 02 09:25:11 sunny kernel:  do_syscall_64+0xea/0x640
>> Jun 02 09:25:11 sunny kernel:  ? do_syscall_64+0x9f/0x640
>> Jun 02 09:25:11 sunny kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> Jun 02 09:25:11 sunny kernel: RIP: 0033:0x7fae0e2637b9
>> Jun 02 09:25:11 sunny kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 =
0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b =
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48>
>> Jun 02 09:25:11 sunny kernel: RSP: 002b:00007fff609daf68 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000139
>> Jun 02 09:25:11 sunny kernel: RAX: ffffffffffffffda RBX: 000055d37be9a7c=
0 RCX: 00007fae0e2637b9
>> Jun 02 09:25:11 sunny kernel: RDX: 0000000000000000 RSI: 000055d37be9c66=
0 RDI: 0000000000000020
>> Jun 02 09:25:11 sunny kernel: RBP: 0000000000000000 R08: 000000000000000=
0 R09: 0000000000000000
>> Jun 02 09:25:11 sunny kernel: R10: 0000000000000000 R11: 000000000000024=
6 R12: 000055d37be9c660
>> Jun 02 09:25:11 sunny kernel: R13: 0000000000020000 R14: 000055d37be96e9=
0 R15: 0000000000000000
>> Jun 02 09:25:11 sunny kernel:  </TASK>
>> Jun 02 09:25:11 sunny kernel: ---[ end trace 0000000000000000 ]---
>> Jun 02 09:25:11 sunny kernel: ------------[ cut here ]------------
>> un 02 09:25:11 sunny kernel: WARNING: drivers/gpu/drm/amd/amdgpu/vce_v1_=
0.c:336 at vce_v1_0_set_powergating_state+0x5ea/0x600 [amdgpu], CPU#8: (ude=
v-worker)/251
>> Jun 02 09:25:11 sunny kernel: Modules linked in: evdev joydev hid_generi=
c dm_mod amdgpu(+) drm_buddy amdxcp drm_panel_backlight_quirks usbhid gpu_s=
ched hid drm_ttm_helper sd_mod ttm drm_client_>
>> Jun 02 09:25:11 sunny kernel: CPU: 8 UID: 0 PID: 251 Comm: (udev-worker)=
 Tainted: G        W           7.1.0-rc6+debian+tj #446 PREEMPT(lazy)
>> Jun 02 09:25:11 sunny kernel: Tainted: [W]=3DWARN
>> Jun 02 09:25:11 sunny kernel: Hardware name: System manufacturer System =
Product Name/PRIME X370-PRO, BIOS 6254 01/05/2026
>> Jun 02 09:25:11 sunny kernel: RIP: 0010:vce_v1_0_set_powergating_state+0=
x5ea/0x600 [amdgpu]
>> Jun 02 09:25:11 sunny kernel: Code: 00 48 89 ef e8 87 ae f5 ff 31 c9 ba =
00 00 01 00 48 89 ef be 0c 80 00 00 e8 73 ae f5 ff 41 f7 c4 ff 7f 00 00 0f =
84 ff fd ff ff <0f> 0b e9 f8 fd ff ff 66 66 2e>
>> Jun 02 09:25:11 sunny kernel: RSP: 0018:ffffceacc081b850 EFLAGS: 0001020=
6
>> Jun 02 09:25:11 sunny kernel: RAX: 0000000000000000 RBX: 000000000022600=
0 RCX: 0000000000000000
>> Jun 02 09:25:11 sunny kernel: RDX: 0000000000010000 RSI: 000000000000800=
c RDI: ffff8b47a3880000
>> Jun 02 09:25:11 sunny kernel: RBP: ffff8b47a3880000 R08: ffffceacc081b88=
8 R09: 0000000000000000
>> Jun 02 09:25:11 sunny kernel: R10: 0000000088b80000 R11: 000000000001117=
0 R12: 0000000000276000
>> Jun 02 09:25:11 sunny kernel: R13: ffff8b47a38d4d98 R14: 000000000000000=
9 R15: ffffffffc0aad220
>> Jun 02 09:25:11 sunny kernel: FS:  00007fae0d7059c0(0000) GS:ffff8b4ed8f=
10000(0000) knlGS:0000000000000000
>> Jun 02 09:25:11 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
>> Jun 02 09:25:11 sunny kernel: CR2: 000055d37be98f18 CR3: 000000010299b00=
0 CR4: 0000000000350ef0
>> Jun 02 09:25:11 sunny kernel: Call Trace:
>> Jun 02 09:25:11 sunny kernel:  <TASK>
>> Jun 02 09:25:11 sunny kernel:  amdgpu_device_ip_set_powergating_state+0x=
aa/0x1b0 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  si_dpm_set_power_state+0xd54/0x18e0 [amdg=
pu]
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? __pfx_vce_v1_0_hw_init+0x10/0x10 [amdgp=
u]
>> Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_change_power_state_locked.isra=
.0+0x2e0/0x570 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_compute_clocks+0xa5/0xf0 [amdg=
pu]
>> Jun 02 09:25:11 sunny kernel:  vce_v1_0_hw_init+0x97/0xb0 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  amdgpu_device_init.cold+0x1ca4/0x22a3 [am=
dgpu]
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? pci_conf1_read+0xab/0xf0
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? pci_bus_read_config_word+0x4c/0x80
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? do_pci_enable_device+0x121/0x190
>> Jun 02 09:25:11 sunny kernel:  amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  amdgpu_pci_probe+0x1e9/0x4d0 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  local_pci_probe+0x41/0x90
>> Jun 02 09:25:11 sunny kernel:  pci_device_probe+0xe4/0x2b0
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? sysfs_do_create_link_sd+0x6e/0xe0
>> Jun 02 09:25:11 sunny kernel:  really_probe+0xde/0x380
>> Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:11 sunny kernel:  ? __pfx___driver_attach+0x10/0x10
>> Jun 02 09:25:11 sunny kernel:  __driver_probe_device+0x84/0x150
>> Jun 02 09:25:11 sunny kernel:  driver_probe_device+0x1f/0xa0
>> Jun 02 09:25:11 sunny kernel:  __driver_attach+0xba/0x1f0
>> Jun 02 09:25:11 sunny kernel:  bus_for_each_dev+0x8e/0xe0
>> Jun 02 09:25:11 sunny kernel:  bus_add_driver+0x11f/0x200
>> Jun 02 09:25:11 sunny kernel:  driver_register+0x72/0xd0
>> Jun 02 09:25:11 sunny kernel:  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
>> Jun 02 09:25:11 sunny kernel:  do_one_initcall+0x5c/0x320
>> Jun 02 09:25:11 sunny kernel:  do_init_module+0x60/0x250
>> Jun 02 09:25:11 sunny kernel:  init_module_from_file+0xd6/0x130
>> Jun 02 09:25:11 sunny kernel:  idempotent_init_module+0x114/0x310
>> Jun 02 09:25:11 sunny kernel:  __x64_sys_finit_module+0x71/0xe0
>> Jun 02 09:25:11 sunny kernel:  do_syscall_64+0xea/0x640
>> Jun 02 09:25:11 sunny kernel:  ? do_syscall_64+0x9f/0x640
>> Jun 02 09:25:11 sunny kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> Jun 02 09:25:11 sunny kernel: RIP: 0033:0x7fae0e2637b9
>> Jun 02 09:25:11 sunny kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 =
0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b =
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48>
>> Jun 02 09:25:11 sunny kernel: RSP: 002b:00007fff609daf68 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000139
>> Jun 02 09:25:11 sunny kernel: RAX: ffffffffffffffda RBX: 000055d37be9a7c=
0 RCX: 00007fae0e2637b9
>> Jun 02 09:25:11 sunny kernel: RDX: 0000000000000000 RSI: 000055d37be9c66=
0 RDI: 0000000000000020
>> Jun 02 09:25:11 sunny kernel: RBP: 0000000000000000 R08: 000000000000000=
0 R09: 0000000000000000
>> Jun 02 09:25:11 sunny kernel: R10: 0000000000000000 R11: 000000000000024=
6 R12: 000055d37be9c660
>> Jun 02 09:25:11 sunny kernel: R13: 0000000000020000 R14: 000055d37be96e9=
0 R15: 0000000000000000
>> Jun 02 09:25:11 sunny kernel:  </TASK>
>> Jun 02 09:25:11 sunny kernel: ---[ end trace 0000000000000000 ]---
>> Jun 02 09:25:11 sunny kernel: amdgpu 0000:0a:00.0: VCE busy: VCE_STATUS=
=3D0x100, SRBM_STATUS2=3D0x0
>>
>>
>> $ sudo lspci -vvnnk -d ::0300
>> 0a:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [=
AMD/ATI] Cape Verde GL [FirePro W4100] [1002:682c] (prog-if 00 [VGA control=
ler])
>>          Subsystem: Dell Device [1028:2b1e]
>>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
>>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>          Latency: 0, Cache Line Size: 64 bytes
>>          Interrupt: pin A routed to IRQ 86
>>          IOMMU group: 16
>>          Region 0: Memory at e0000000 (64-bit, prefetchable) [size=3D256=
M]
>>          Region 2: Memory at fce00000 (64-bit, non-prefetchable) [size=
=3D256K]
>>          Region 4: I/O ports at d000 [size=3D256]
>>          Expansion ROM at 000c0000 [disabled] [size=3D128K]
>>          Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
>>          Capabilities: [50] Power Management version 3
>>                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1=
+,D2+,D3hot+,D3cold-)
>>                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
>>          Capabilities: [58] Express (v2) Legacy Endpoint, IntMsgNum 0
>>                  DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s =
<4us, L1 unlimited
>>                          ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-=
 TEE-IO-
>>                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>                          MaxPayload 256 bytes, MaxReadReq 512 bytes
>>                  DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPw=
r- TransPend-
>>                  LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, E=
xit Latency L0s <64ns, L1 <1us
>>                          ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp=
+
>>                  LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommCl=
k+
>>                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                  LnkSta: Speed 8GT/s, Width x16
>>                          TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgm=
t-
>>                  DevCap2: Completion Timeout: Not Supported, TimeoutDis-=
 NROPrPrP- LTR-
>>                           10BitTagComp- 10BitTagReq- OBFF Not Supported,=
 ExtFmt- EETLPPrefix-
>>                           EmergencyPowerReduction Not Supported, Emergen=
cyPowerReductionInit-
>>                           FRS-
>>                           AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>>                           AtomicOpsCtl: ReqEn-
>>                           IDOReq- IDOCompl- LTR- EmergencyPowerReduction=
Req-
>>                           10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>>                  LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- R=
etimer- 2Retimers- DRS-
>>                  LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- Spe=
edDis-
>>                           Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
>>                           Compliance Preset/De-emphasis: -6dB de-emphasi=
s, 0dB preshoot
>>                  LnkSta2: Current De-emphasis Level: -3.5dB, Equalizatio=
nComplete+ EqualizationPhase1-
>>                           EqualizationPhase2- EqualizationPhase3- LinkEq=
ualizationRequest-
>>                           Retimer- 2Retimers- CrosslinkRes: unsupported
>>          Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>>                  Address: 00000000fee00000  Data: 0000
>>          Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 R=
ev=3D1 Len=3D010 <?>
>>          Capabilities: [150 v2] Advanced Error Reporting
>>                  UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP-
>>                          ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedT=
LP- AtomicOpBlocked- TLPBlockedErr-
>>                          PoisonTLPBlocked- DMWrReqBlocked- IDECheck- Mis=
IDETLP- PCRC_CHECK- TLPXlatBlocked-
>>                  UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP-
>>                          ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedT=
LP- AtomicOpBlocked- TLPBlockedErr-
>>                          PoisonTLPBlocked- DMWrReqBlocked- IDECheck- Mis=
IDETLP- PCRC_CHECK- TLPXlatBlocked-
>>                  UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF+ MalfTLP+
>>                          ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedT=
LP- AtomicOpBlocked- TLPBlockedErr-
>>                          PoisonTLPBlocked- DMWrReqBlocked- IDECheck- Mis=
IDETLP- PCRC_CHECK- TLPXlatBlocked-
>>                  CESta:  RxErr- BadTLP+ BadDLLP- Rollover- Timeout- AdvN=
onFatalErr- CorrIntErr- HeaderOF-
>>                  CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvN=
onFatalErr+ CorrIntErr- HeaderOF-
>>                  AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-=
 ECRCChkCap+ ECRCChkEn-
>>                          MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLog=
Cap-
>>                  HeaderLog: 00000000 00000000 00000000 00000000
>>          Capabilities: [200 v1] Physical Resizable BAR
>>                  BAR 0: current size: 256MB, supported: 256MB 512MB 1GB =
2GB 4GB
>>          Capabilities: [270 v1] Secondary PCI Express
>>                  LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>>                  LaneErrStat: LaneErr at lane: 6
>>          Kernel driver in use: amdgpu
>>          Kernel modules: radeon, amdgpu
>>
>>


