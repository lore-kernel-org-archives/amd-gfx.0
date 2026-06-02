Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599B7CD6E6B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 08:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB31410FAD6;
	Wed,  3 Jun 2026 08:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="lt583SRU";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D0B210EE4D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=rtpvvnivrva35k4aqbhgxsta2y.protonmail; t=1780394765; x=1780653965;
 bh=FDH9b8FZ65vWOfBE9AvUzv3j4xBcvkFz7lZj+XMX9g8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=lt583SRUshhYkOKtwqZje5TXUym89WAQehdNIoFSjXnWTn1cPNb4gU8UkPeXx3PUx
 QWz0MKTKrTS44r8H4RSYue5nHd9u9gcyfGX1TUFE+GeKlBAQqZEG6FC+Mk7O5OHagh
 +5Klp3BQ29LVSBtD/iYScH3n+WLXqT6dCGxvbr53vMS+xAqL569GAlKrAH4RXCMzI4
 4WnTCPsu/oEyx92KEmUF8jUJhtE2aZLjIC26W9tKJXeWVgjfm/3zOT6XXB0+ijlyC8
 z9HAH9+jWc0FtaYfE3HnvPjZVBiE5gAQdm2pKpHdZZ46m59o+YD2ss3XUk1tEdhX+E
 UGECuiX+axnIA==
Date: Tue, 02 Jun 2026 10:06:01 +0000
To: regressions@lists.linux.dev
From: Tj <tj.iam.tj@proton.me>
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [REGRESSION] RIP: 0010:vce_v1_0_set_powergating_state+0x5b8/0x600
 [amdgpu]
Message-ID: <ah6q-k5wvRbW6k6e@mail.iam.tj>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 585f5e05c29b877fe01eee42caeae6ab6901a7e3
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

Repeatedly hit this with 7.1-rc6. I haven't yet got time to do a bisect.

$ lspci -nnk -d ::0300
0a:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD=
/ATI] Cape Verde GL [FirePro W4100] [1002:682c]
        Subsystem: Dell Device [1028:2b1e]
        Kernel driver in use: amdgpu
        Kernel modules: radeon, amdgpu

$ journalctl --boot 5e39a2d49af2432c8f14f2a866a6b275 --priority=3Dwarning
...
Jun 02 09:25:11 sunny kernel: Linux version 7.1.0-rc6+debian+tj (linux@iam.=
tj) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) =
#446 SMP PREEMPT_DYNAMIC Mon Jun  1 07:32:2>
...
Jun 02 09:25:11 sunny kernel: WARNING: drivers/gpu/drm/amd/amdgpu/vce_v1_0.=
c:329 at vce_v1_0_set_powergating_state+0x5b8/0x600 [amdgpu], CPU#8: (udev-=
worker)/251
Jun 02 09:25:11 sunny kernel: Modules linked in: evdev joydev hid_generic d=
m_mod amdgpu(+) drm_buddy amdxcp drm_panel_backlight_quirks usbhid gpu_sche=
d hid drm_ttm_helper sd_mod ttm drm_client_>
Jun 02 09:25:11 sunny kernel: CPU: 8 UID: 0 PID: 251 Comm: (udev-worker) No=
t tainted 7.1.0-rc6+debian+tj #446 PREEMPT(lazy)
Jun 02 09:25:11 sunny kernel: Hardware name: System manufacturer System Pro=
duct Name/PRIME X370-PRO, BIOS 6254 01/05/2026
Jun 02 09:25:11 sunny kernel: RIP: 0010:vce_v1_0_set_powergating_state+0x5b=
8/0x600 [amdgpu]
Jun 02 09:25:11 sunny kernel: Code: c2 ad 47 d6 c1 48 c7 c7 a8 4e 87 c1 e8 =
a1 02 45 f3 f6 05 05 77 dc 00 40 0f 84 ac fe ff ff e9 52 0b 92 00 0f 0b e9 =
52 fe ff ff <0f> 0b 31 c9 be 0b 80 00 00 48>
Jun 02 09:25:11 sunny kernel: RSP: 0018:ffffceacc081b850 EFLAGS: 00010206
Jun 02 09:25:11 sunny kernel: RAX: 0000000000000000 RBX: 0000000000226000 R=
CX: 0000000000000000
Jun 02 09:25:11 sunny kernel: RDX: 0000000000266000 RSI: 000000000000800a R=
DI: ffff8b47a3880000
Jun 02 09:25:11 sunny kernel: RBP: ffff8b47a3880000 R08: ffffceacc081b888 R=
09: 0000000000000000
Jun 02 09:25:11 sunny kernel: R10: 0000000088b80000 R11: 0000000000011170 R=
12: 0000000000276000
Jun 02 09:25:11 sunny kernel: R13: ffff8b47a38d4d98 R14: 0000000000000009 R=
15: ffffffffc0aad220
Jun 02 09:25:11 sunny kernel: FS:  00007fae0d7059c0(0000) GS:ffff8b4ed8f100=
00(0000) knlGS:0000000000000000
Jun 02 09:25:11 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
Jun 02 09:25:11 sunny kernel: CR2: 000055d37be98f18 CR3: 000000010299b000 C=
R4: 0000000000350ef0
Jun 02 09:25:11 sunny kernel: Call Trace:
Jun 02 09:25:11 sunny kernel:  <TASK>
Jun 02 09:25:11 sunny kernel:  amdgpu_device_ip_set_powergating_state+0xaa/=
0x1b0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  si_dpm_set_power_state+0xd54/0x18e0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? __pfx_vce_v1_0_hw_init+0x10/0x10 [amdgpu]
Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_change_power_state_locked.isra.0+=
0x2e0/0x570 [amdgpu]
Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_compute_clocks+0xa5/0xf0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  vce_v1_0_hw_init+0x97/0xb0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  amdgpu_device_init.cold+0x1ca4/0x22a3 [amdgp=
u]
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? pci_conf1_read+0xab/0xf0
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? pci_bus_read_config_word+0x4c/0x80
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? do_pci_enable_device+0x121/0x190
Jun 02 09:25:11 sunny kernel:  amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
Jun 02 09:25:11 sunny kernel:  amdgpu_pci_probe+0x1e9/0x4d0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  local_pci_probe+0x41/0x90
Jun 02 09:25:11 sunny kernel:  pci_device_probe+0xe4/0x2b0
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? sysfs_do_create_link_sd+0x6e/0xe0
Jun 02 09:25:11 sunny kernel:  really_probe+0xde/0x380
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? __pfx___driver_attach+0x10/0x10
Jun 02 09:25:11 sunny kernel:  __driver_probe_device+0x84/0x150
Jun 02 09:25:11 sunny kernel:  driver_probe_device+0x1f/0xa0
Jun 02 09:25:11 sunny kernel:  __driver_attach+0xba/0x1f0
Jun 02 09:25:11 sunny kernel:  bus_for_each_dev+0x8e/0xe0
Jun 02 09:25:11 sunny kernel:  bus_add_driver+0x11f/0x200
Jun 02 09:25:11 sunny kernel:  driver_register+0x72/0xd0
Jun 02 09:25:11 sunny kernel:  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
Jun 02 09:25:11 sunny kernel:  do_one_initcall+0x5c/0x320
Jun 02 09:25:11 sunny kernel:  do_init_module+0x60/0x250
Jun 02 09:25:11 sunny kernel:  init_module_from_file+0xd6/0x130
Jun 02 09:25:11 sunny kernel:  idempotent_init_module+0x114/0x310
Jun 02 09:25:11 sunny kernel:  __x64_sys_finit_module+0x71/0xe0
Jun 02 09:25:11 sunny kernel:  do_syscall_64+0xea/0x640
Jun 02 09:25:11 sunny kernel:  ? do_syscall_64+0x9f/0x640
Jun 02 09:25:11 sunny kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jun 02 09:25:11 sunny kernel: RIP: 0033:0x7fae0e2637b9
Jun 02 09:25:11 sunny kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f =
1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48>
Jun 02 09:25:11 sunny kernel: RSP: 002b:00007fff609daf68 EFLAGS: 00000246 O=
RIG_RAX: 0000000000000139
Jun 02 09:25:11 sunny kernel: RAX: ffffffffffffffda RBX: 000055d37be9a7c0 R=
CX: 00007fae0e2637b9
Jun 02 09:25:11 sunny kernel: RDX: 0000000000000000 RSI: 000055d37be9c660 R=
DI: 0000000000000020
Jun 02 09:25:11 sunny kernel: RBP: 0000000000000000 R08: 0000000000000000 R=
09: 0000000000000000
Jun 02 09:25:11 sunny kernel: R10: 0000000000000000 R11: 0000000000000246 R=
12: 000055d37be9c660
Jun 02 09:25:11 sunny kernel: R13: 0000000000020000 R14: 000055d37be96e90 R=
15: 0000000000000000
Jun 02 09:25:11 sunny kernel:  </TASK>
Jun 02 09:25:11 sunny kernel: ---[ end trace 0000000000000000 ]---
Jun 02 09:25:11 sunny kernel: ------------[ cut here ]------------
un 02 09:25:11 sunny kernel: WARNING: drivers/gpu/drm/amd/amdgpu/vce_v1_0.c=
:336 at vce_v1_0_set_powergating_state+0x5ea/0x600 [amdgpu], CPU#8: (udev-w=
orker)/251
Jun 02 09:25:11 sunny kernel: Modules linked in: evdev joydev hid_generic d=
m_mod amdgpu(+) drm_buddy amdxcp drm_panel_backlight_quirks usbhid gpu_sche=
d hid drm_ttm_helper sd_mod ttm drm_client_>
Jun 02 09:25:11 sunny kernel: CPU: 8 UID: 0 PID: 251 Comm: (udev-worker) Ta=
inted: G        W           7.1.0-rc6+debian+tj #446 PREEMPT(lazy)
Jun 02 09:25:11 sunny kernel: Tainted: [W]=3DWARN
Jun 02 09:25:11 sunny kernel: Hardware name: System manufacturer System Pro=
duct Name/PRIME X370-PRO, BIOS 6254 01/05/2026
Jun 02 09:25:11 sunny kernel: RIP: 0010:vce_v1_0_set_powergating_state+0x5e=
a/0x600 [amdgpu]
Jun 02 09:25:11 sunny kernel: Code: 00 48 89 ef e8 87 ae f5 ff 31 c9 ba 00 =
00 01 00 48 89 ef be 0c 80 00 00 e8 73 ae f5 ff 41 f7 c4 ff 7f 00 00 0f 84 =
ff fd ff ff <0f> 0b e9 f8 fd ff ff 66 66 2e>
Jun 02 09:25:11 sunny kernel: RSP: 0018:ffffceacc081b850 EFLAGS: 00010206
Jun 02 09:25:11 sunny kernel: RAX: 0000000000000000 RBX: 0000000000226000 R=
CX: 0000000000000000
Jun 02 09:25:11 sunny kernel: RDX: 0000000000010000 RSI: 000000000000800c R=
DI: ffff8b47a3880000
Jun 02 09:25:11 sunny kernel: RBP: ffff8b47a3880000 R08: ffffceacc081b888 R=
09: 0000000000000000
Jun 02 09:25:11 sunny kernel: R10: 0000000088b80000 R11: 0000000000011170 R=
12: 0000000000276000
Jun 02 09:25:11 sunny kernel: R13: ffff8b47a38d4d98 R14: 0000000000000009 R=
15: ffffffffc0aad220
Jun 02 09:25:11 sunny kernel: FS:  00007fae0d7059c0(0000) GS:ffff8b4ed8f100=
00(0000) knlGS:0000000000000000
Jun 02 09:25:11 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
Jun 02 09:25:11 sunny kernel: CR2: 000055d37be98f18 CR3: 000000010299b000 C=
R4: 0000000000350ef0
Jun 02 09:25:11 sunny kernel: Call Trace:
Jun 02 09:25:11 sunny kernel:  <TASK>
Jun 02 09:25:11 sunny kernel:  amdgpu_device_ip_set_powergating_state+0xaa/=
0x1b0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  si_dpm_set_power_state+0xd54/0x18e0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? __pfx_vce_v1_0_hw_init+0x10/0x10 [amdgpu]
Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_change_power_state_locked.isra.0+=
0x2e0/0x570 [amdgpu]
Jun 02 09:25:11 sunny kernel:  amdgpu_dpm_compute_clocks+0xa5/0xf0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  vce_v1_0_hw_init+0x97/0xb0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  amdgpu_device_init.cold+0x1ca4/0x22a3 [amdgp=
u]
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? pci_conf1_read+0xab/0xf0
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? pci_bus_read_config_word+0x4c/0x80
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? do_pci_enable_device+0x121/0x190
Jun 02 09:25:11 sunny kernel:  amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
Jun 02 09:25:11 sunny kernel:  amdgpu_pci_probe+0x1e9/0x4d0 [amdgpu]
Jun 02 09:25:11 sunny kernel:  local_pci_probe+0x41/0x90
Jun 02 09:25:11 sunny kernel:  pci_device_probe+0xe4/0x2b0
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? sysfs_do_create_link_sd+0x6e/0xe0
Jun 02 09:25:11 sunny kernel:  really_probe+0xde/0x380
Jun 02 09:25:11 sunny kernel:  ? srso_return_thunk+0x5/0x5f
Jun 02 09:25:11 sunny kernel:  ? __pfx___driver_attach+0x10/0x10
Jun 02 09:25:11 sunny kernel:  __driver_probe_device+0x84/0x150
Jun 02 09:25:11 sunny kernel:  driver_probe_device+0x1f/0xa0
Jun 02 09:25:11 sunny kernel:  __driver_attach+0xba/0x1f0
Jun 02 09:25:11 sunny kernel:  bus_for_each_dev+0x8e/0xe0
Jun 02 09:25:11 sunny kernel:  bus_add_driver+0x11f/0x200
Jun 02 09:25:11 sunny kernel:  driver_register+0x72/0xd0
Jun 02 09:25:11 sunny kernel:  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
Jun 02 09:25:11 sunny kernel:  do_one_initcall+0x5c/0x320
Jun 02 09:25:11 sunny kernel:  do_init_module+0x60/0x250
Jun 02 09:25:11 sunny kernel:  init_module_from_file+0xd6/0x130
Jun 02 09:25:11 sunny kernel:  idempotent_init_module+0x114/0x310
Jun 02 09:25:11 sunny kernel:  __x64_sys_finit_module+0x71/0xe0
Jun 02 09:25:11 sunny kernel:  do_syscall_64+0xea/0x640
Jun 02 09:25:11 sunny kernel:  ? do_syscall_64+0x9f/0x640
Jun 02 09:25:11 sunny kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jun 02 09:25:11 sunny kernel: RIP: 0033:0x7fae0e2637b9
Jun 02 09:25:11 sunny kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f =
1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48>
Jun 02 09:25:11 sunny kernel: RSP: 002b:00007fff609daf68 EFLAGS: 00000246 O=
RIG_RAX: 0000000000000139
Jun 02 09:25:11 sunny kernel: RAX: ffffffffffffffda RBX: 000055d37be9a7c0 R=
CX: 00007fae0e2637b9
Jun 02 09:25:11 sunny kernel: RDX: 0000000000000000 RSI: 000055d37be9c660 R=
DI: 0000000000000020
Jun 02 09:25:11 sunny kernel: RBP: 0000000000000000 R08: 0000000000000000 R=
09: 0000000000000000
Jun 02 09:25:11 sunny kernel: R10: 0000000000000000 R11: 0000000000000246 R=
12: 000055d37be9c660
Jun 02 09:25:11 sunny kernel: R13: 0000000000020000 R14: 000055d37be96e90 R=
15: 0000000000000000
Jun 02 09:25:11 sunny kernel:  </TASK>
Jun 02 09:25:11 sunny kernel: ---[ end trace 0000000000000000 ]---
Jun 02 09:25:11 sunny kernel: amdgpu 0000:0a:00.0: VCE busy: VCE_STATUS=3D0=
x100, SRBM_STATUS2=3D0x0


$ sudo lspci -vvnnk -d ::0300
0a:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD=
/ATI] Cape Verde GL [FirePro W4100] [1002:682c] (prog-if 00 [VGA controller=
])
        Subsystem: Dell Device [1028:2b1e]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 86
        IOMMU group: 16
        Region 0: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
        Region 2: Memory at fce00000 (64-bit, non-prefetchable) [size=3D256=
K]
        Region 4: I/O ports at d000 [size=3D256]
        Expansion ROM at 000c0000 [disabled] [size=3D128K]
        Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2=
+,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] Express (v2) Legacy Endpoint, IntMsgNum 0
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us=
, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE=
-IO-
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- T=
ransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit =
Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x16
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis- NRO=
PrPrP- LTR-
                         10BitTagComp- 10BitTagReq- OBFF Not Supported, Ext=
Fmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPo=
werReductionInit-
                         FRS-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                         AtomicOpsCtl: ReqEn-
                         IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retim=
er- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0=
dB preshoot
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationCom=
plete+ EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEquali=
zationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee00000  Data: 0000
        Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=
=3D1 Len=3D010 <?>
        Capabilities: [150 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- =
AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDET=
LP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- =
AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDET=
LP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- =
AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDET=
LP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr- BadTLP+ BadDLLP- Rollover- Timeout- AdvNonFa=
talErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr+ CorrIntErr- HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECR=
CChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [200 v1] Physical Resizable BAR
                BAR 0: current size: 256MB, supported: 256MB 512MB 1GB 2GB =
4GB
        Capabilities: [270 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: LaneErr at lane: 6
        Kernel driver in use: amdgpu
        Kernel modules: radeon, amdgpu

