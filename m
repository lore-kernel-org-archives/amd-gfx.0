Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9184CC41513
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 12:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5D910E382;
	Mon,  3 Jun 2024 12:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=glanzmann.de header.i=@glanzmann.de header.b="bE1ym42U";
	dkim-atps=neutral
X-Greylist: delayed 505 seconds by postgrey-1.36 at gabe;
 Sun, 02 Jun 2024 06:39:21 UTC
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC11E10E034
 for <amd-gfx@lists.freedesktop.org>; Sun,  2 Jun 2024 06:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
 s=infra26101010; t=1717309852;
 bh=uBLGC5duCr1hk7fGatA5LsiE6Hp7izxnvxjLxg9lAwk=;
 h=Date:From:To:Subject:From;
 b=bE1ym42UaEFVXqaVtImyYXY1WKLtXqkvnyJqu2qSVJfoWRk29LsKmoqOtMUy+RCH3
 cCjiXROrtmKwA/Da6uK94fGRzEqNJzYJXo8gThUJ6gpAjnHFACq8YiJPUiXdHTSu4p
 mZxWuBgLMqz3h65V8pTKD2fUKe6ehqNx7ybNW80CASJPGEoptOMbLiPGDSPmaAOce0
 eMH95yZh5ub8SxLToJhuSLNq0I5y0NI4zXZQ4Lq4qzskQ3dEeE+8FMV0cQtuNqRWIp
 RsCXT7qpMr8lJnrOBqOWGgFkSpGdOHMqXCGmSh3jJkfO+SPvQxE/WfWTmPSfWYXA4I
 4I8oRCKcP2qm/cmEaxZdXBYGFlC9En527oIkyHGFDaliGdyufWqGYq7cbwPczp3gn0
 EFPKBOMsVFbFh98Y2+goQ2N9kMApBbRbUJchYfXLDcpHqGO1R9SROmhkMBb5c/LAVs
 YbfKJmkdwW6iXu4VuHDzs82HwVUs5vfd0aMAZbJ73uge473trUmOZEqJQzC9UXVZaZ
 6Ja7icB0+JT+2Rp8QKAnAPhiG+kwUoQXR0lP371IiK/BGxg/QBPokhyKJ7+rXs/C2y
 fliZxfoaf5qUEPCH9Y5jnPXAnVg7+71VNMCycKPsE6wXmb+JtL84VDpuaQ9RL9/K32
 cmOM21zhuvM7ge1EpWryhSuQ=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
 id 002F37A80095; Sun,  2 Jun 2024 08:30:52 +0200 (CEST)
Date: Sun, 2 Jun 2024 08:30:52 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: amd-gfx@lists.freedesktop.org
Subject: WARNING: CPU: 29 PID: 673 at
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382
 amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
Message-ID: <ZlwRnGJL0B1HGMnQ@glanzmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 03 Jun 2024 12:52:59 +0000
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

Hello,
with 6.10.0-rc1, I noticed the following in dmesg:

[   10.967791] amdgpu 0000:0b:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[   10.973672] amdgpu 0000:0b:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[   10.973674] amdgpu 0000:0b:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[   10.974841] amdgpu 0000:0b:00.0: amdgpu: SMU is initialized successfully!
[   10.974843] [drm] Seamless boot condition check passed
[   10.975510] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear me=
mory with ring turned off.
[   10.975602] ------------[ cut here ]------------
[   10.975603] WARNING: CPU: 29 PID: 673 at drivers/gpu/drm/amd/amdgpu/amdg=
pu_object.c:1382 amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
[   10.975678] Modules linked in: fmpm(-) amd_atl intel_rapl_msr intel_rapl=
_common edac_mce_amd kvm_amd amdgpu(+) kvm ghash_clmulni_intel sha512_ssse3=
 snd_hda_codec_realtek sha256_ssse3 snd_hda_codec_generic sha1_ssse3 snd_hd=
a_scodec_component snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_in=
tel_sdw_acpi drm_exec snd_hda_codec amdxcp eeepc_wmi drm_buddy asus_wmi gpu=
_sched aesni_intel battery snd_hda_core drm_suballoc_helper sparse_keymap c=
rypto_simd snd_hwdep drm_display_helper joydev platform_profile cryptd drm_=
ttm_helper snd_pcm rfkill rapl ttm snd_timer sp5100_tco wmi_bmof drm_kms_he=
lper ccp snd k10temp watchdog pcspkr soundcore i2c_algo_bit rng_core button=
 evdev nfsd auth_rpcgss nfs_acl parport_pc lockd ppdev grace lp parport drm=
 loop fuse dm_mod efi_pstore configfs sunrpc ip_tables x_tables autofs4 ext=
4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_ra=
id6_recov async_memcpy async_pq async_xor async_tx raid1 raid0 md_mod hid_l=
enovo hid_generic usbhid hid nvme ahci nvme_core xhci_pci
[   10.975702]  libahci mpt3sas t10_pi xhci_hcd libata r8169 raid_class scs=
i_transport_sas realtek crc64_rocksoft crc32_pclmul mdio_devres crc_t10dif =
usbcore scsi_mod crc32c_intel crct10dif_generic video libphy i2c_piix4 crct=
10dif_pclmul usb_common scsi_common crct10dif_common wmi gpio_amdpt gpio_ge=
neric
[   10.975717] CPU: 29 PID: 673 Comm: (udev-worker) Not tainted 6.10.0-rc1 =
#6
[   10.975719] Hardware name: ASUS System Product Name/TUF GAMING B650M-PLU=
S, BIOS 2412 01/26/2024
[   10.975720] RIP: 0010:amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
[   10.975785] Code: 0b e9 b3 fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 =
4c 89 e7 e8 bb 50 92 c4 eb 98 e8 44 4a 92 c4 eb b2 0f 0b e9 60 fe ff ff <0f=
> 0b eb a7 be 03 00 00 00 e8 dd 4f 6a c4 eb 9b e8 46 40 c1 c4 66
[   10.975787] RSP: 0018:ffffa5f2c26d3560 EFLAGS: 00010282
[   10.975788] RAX: 00000000ffffffea RBX: ffff8be251cb6c48 RCX: 00000000000=
00000
[   10.975790] RDX: 0000000000000000 RSI: ffffffff86828d16 RDI: 00000000fff=
fffff
[   10.975791] RBP: ffff8be24ff8ef58 R08: 0000000000000000 R09: 00000000000=
00003
[   10.975791] R10: ffffa5f2c26d32e0 R11: ffff8bf19de35fe8 R12: ffff8be251c=
b6c00
[   10.975793] R13: ffff8be251cb6d48 R14: ffff8be24ff8ef58 R15: 00000000000=
00258
[   10.975793] FS:  00007f0b752898c0(0000) GS:ffff8bf15e480000(0000) knlGS:=
0000000000000000
[   10.975795] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.975796] CR2: 00007f0b74cf7a2d CR3: 0000000108b0f000 CR4: 00000000007=
50ef0
[   10.975797] PKRU: 55555554
[   10.975797] Call Trace:
[   10.975799]  <TASK>
[   10.975800]  ? __warn+0x7c/0x120
[   10.975804]  ? amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
[   10.975867]  ? report_bug+0x189/0x1c0
[   10.975869]  ? handle_bug+0x41/0x70
[   10.975872]  ? exc_invalid_op+0x13/0x60
[   10.975873]  ? asm_exc_invalid_op+0x16/0x20
[   10.975876]  ? amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
[   10.975938]  ttm_bo_release+0xfb/0x2e0 [ttm]
[   10.975941]  ? amdgpu_ttm_debugfs_init+0xf0/0xf0 [amdgpu]
[   10.976005]  ? ttm_resource_move_to_lru_tail+0x138/0x1d0 [ttm]
[   10.976008]  amdgpu_bo_free_kernel+0xc7/0x120 [amdgpu]
[   10.976071]  dm_helpers_free_gpu_mem+0x3d/0x80 [amdgpu]
[   10.976171]  dcn315_clk_mgr_construct+0x190/0x7e0 [amdgpu]
[   10.976265]  dc_clk_mgr_create+0x31c/0x500 [amdgpu]
[   10.976351]  dc_create+0x286/0x630 [amdgpu]
[   10.976454]  amdgpu_dm_init.isra.0+0x2e9/0x1f10 [amdgpu]
[   10.976537]  ? console_unlock+0x74/0x110
[   10.976540]  ? irq_work_queue+0xa/0x50
[   10.976543]  ? vprintk_emit+0x17f/0x2b0
[   10.976544]  ? dev_printk_emit+0xa1/0xd0
[   10.976548]  dm_hw_init+0xe/0x20 [amdgpu]
[   10.976614]  amdgpu_device_init+0x1ede/0x26c0 [amdgpu]
[   10.976686]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[   10.976688]  amdgpu_driver_load_kms+0x15/0xa0 [amdgpu]
[   10.976754]  amdgpu_pci_probe+0x183/0x4f0 [amdgpu]
[   10.976820]  local_pci_probe+0x3c/0x80
[   10.976823]  pci_device_probe+0xc3/0x240
[   10.976824]  really_probe+0xcd/0x370
[   10.976826]  ? __device_attach_driver+0xf0/0xf0
[   10.976827]  __driver_probe_device+0x78/0x150
[   10.976828]  driver_probe_device+0x1f/0x90
[   10.976829]  __driver_attach+0xbf/0x1b0
[   10.976830]  bus_for_each_dev+0x81/0xd0
[   10.976832]  bus_add_driver+0x10a/0x230
[   10.976833]  driver_register+0x55/0xf0
[   10.976835]  ? 0xffffffffc0af3000
[   10.976836]  do_one_initcall+0x54/0x310
[   10.976839]  do_init_module+0x60/0x230
[   10.976841]  init_module_from_file+0x86/0xc0
[   10.976843]  idempotent_init_module+0x120/0x2a0
[   10.976845]  __x64_sys_finit_module+0x5a/0xb0
[   10.976847]  do_syscall_64+0x80/0x190
[   10.976849]  ? __do_sys_newfstatat+0x4e/0x80
[   10.976852]  ? fpregs_assert_state_consistent+0x1d/0x40
[   10.976855]  ? syscall_exit_to_user_mode+0x76/0x1f0
[   10.976856]  ? do_syscall_64+0x8c/0x190
[   10.976857]  ? fpregs_restore_userregs+0x51/0xc0
[   10.976859]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   10.976860] RIP: 0033:0x7f0b7547a719
[   10.976862] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
[   10.976864] RSP: 002b:00007ffd88b042c8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   10.976865] RAX: ffffffffffffffda RBX: 0000558b764654a0 RCX: 00007f0b754=
7a719
[   10.976866] RDX: 0000000000000000 RSI: 00007f0b7560defd RDI: 00000000000=
00019
[   10.976867] RBP: 00007f0b7560defd R08: 0000000000000000 R09: 0000558b763=
5b730
[   10.976868] R10: 0000000000000019 R11: 0000000000000246 R12: 00000000000=
20000
[   10.976869] R13: 0000000000000000 R14: 0000558b76467a60 R15: 0000558b62c=
1cec1
[   10.976870]  </TASK>
[   10.976871] ---[ end trace 0000000000000000 ]---

Full dmesg here: https://tg.st/u/9896842a47c420e9f233231b31990b6a0fecc70b8e=
60ec8295e79162982ab443.txt

Cheers,
        Thomas
