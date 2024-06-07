Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC4BC27C5F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 13:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF41B10EC54;
	Fri,  7 Jun 2024 13:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=glanzmann.de header.i=@glanzmann.de header.b="FIoIchWy";
	dkim-atps=neutral
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB7F10E1C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 04:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
 s=infra26101010; t=1717735961;
 bh=+FuJeLNxvAvUOSq7BzH/igoaqKljMGs8NbGXOdNK33g=;
 h=Date:From:To:Cc:Subject:From;
 b=FIoIchWyqW3GGQHlj4AujHtiiPCsW+wxFixU+3WmCtL4RastiGxNXLeQR3hAQG5es
 IDHfbUBh3P6udcJSXYc1fLo+lyTdIFJc+30bADZMH5z+L6A1dobcImrLIItVOETz5A
 /JqL0XYo9XZdSeAK5LW/69VO9MYnS8p8zHo95wrrdsWVjguFP4Jt4VorAFDYp/TnGH
 Dv4KBFmUVGm8T6eyop8X0qPi5/gfCujZRiUykS+7UL4j3HiJY4nJ010jnyGU7QhvSy
 P2Ey9v8ws5Jox+0MhJ7Add9+yDJTqI4nEQLr0SXjodgzpDZCpJIpLvHri2lyF0h7Aa
 QUlhPtfX/7JOWorb1JfEVNYoVFTs7e31GgIh9oKGd/oiUKUDrfIU+6IYo7TEW4KVzY
 GX4RN5EBjX6XS/Xc89t1z0wQCaoguS83YZFsx59zMRtzEltllgPPR2DrV85gORjQKC
 RqNjoZy8LDD1mtDprNT6TRBA8twTsQPmjd6yPVKc4bJFsODlSRbothykF1WlEr+/IX
 2MlgT+v+FYOmzbpLdvGs++DfvG1GSHw12DGcsLGCLKb4drIDn27kcPY74sqPKGbVJn
 4ZgxWL7I7ZKI4Ra3GiAfRjpscSqeI/elqUm1Oq8tz5hChqmhl7Oo6suegXr9B0lJ/q
 KgonUJ6YO4Oo8mKfIjy3ZPr8=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
 id 24EB87A800C2; Fri,  7 Jun 2024 06:52:41 +0200 (CEST)
Date: Fri, 7 Jun 2024 06:52:41 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Pan@glanzmann.de, Xinhui <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory
 with ring turned off.
Message-ID: <ZmKSGSvm91qXzN_J@glanzmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 07 Jun 2024 13:46:34 +0000
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
starting with 6.10.0-rc1 I get the following in dmesg:

[   11.025935] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear me=
mory with ring turned off.
[   11.026037] ------------[ cut here ]------------
[   11.026038] WARNING: CPU: 10 PID: 659 at drivers/gpu/drm/amd/amdgpu/amdg=
pu_object.c:1382 amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
[   11.026114] Modules linked in: rtl2832_sdr videobuf2_vmalloc videobuf2_m=
emops videobuf2_v4l2 videodev videobuf2_common r820t intel_rapl_msr amd_atl=
 intel_rapl_common rtl2832 amdgpu(+) i2c_mux edac_mce_amd kvm_amd kvm ghash=
_clmulni_intel snd_hda_codec_realtek sha512_ssse3 snd_hda_codec_generic sha=
256_ssse3 snd_hda_scodec_component sha1_ssse3 snd_hda_codec_hdmi dvb_usb_rt=
l28xxu snd_hda_intel dvb_usb_v2 snd_intel_dspcfg snd_intel_sdw_acpi dvb_cor=
e snd_hda_codec drm_exec mc amdxcp eeepc_wmi drm_buddy asus_wmi rc_core snd=
_hda_core aesni_intel gpu_sched battery drm_suballoc_helper sparse_keymap s=
nd_hwdep platform_profile crypto_simd drm_display_helper cryptd snd_pcm rfk=
ill wmi_bmof drm_ttm_helper snd_timer joydev rapl ttm sp5100_tco snd pcspkr=
 watchdog drm_kms_helper k10temp ccp soundcore i2c_algo_bit rng_core button=
 evdev nfsd auth_rpcgss nfs_acl lockd parport_pc grace ppdev lp parport drm=
 fuse loop efi_pstore dm_mod configfs sunrpc ip_tables x_tables autofs4 ext=
4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10
[   11.026138]  raid456 async_raid6_recov async_memcpy async_pq async_xor a=
sync_tx raid1 raid0 md_mod hid_lenovo hid_generic usbhid hid ahci nvme liba=
hci xhci_pci mpt3sas nvme_core libata xhci_hcd t10_pi r8169 raid_class scsi=
_transport_sas realtek crc64_rocksoft mdio_devres crc32_pclmul scsi_mod usb=
core crc_t10dif crc32c_intel libphy crct10dif_generic i2c_piix4 video crct1=
0dif_pclmul usb_common scsi_common crct10dif_common gpio_amdpt wmi gpio_gen=
eric
[   11.026158] CPU: 10 PID: 659 Comm: (udev-worker) Not tainted 6.10.0-rc2 =
#7
[   11.026160] Hardware name: ASUS System Product Name/TUF GAMING B650M-PLU=
S, BIOS 2412 01/26/2024
[   11.026162] RIP: 0010:amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
[   11.026231] Code: 0b e9 b3 fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 =
4c 89 e7 e8 6b 72 3c fa eb 98 e8 f4 6b 3c fa eb b2 0f 0b e9 60 fe ff ff <0f=
> 0b eb a7 be 03 00 00 00 e8 8d 71 14 fa eb 9b e8 c6 5f 6b fa 66
[   11.026233] RSP: 0018:ffffbff4412ab370 EFLAGS: 00010282
[   11.026234] RAX: 00000000ffffffea RBX: ffff9e9dd60d4448 RCX: 00000000000=
00000
[   11.026236] RDX: 0000000000000000 RSI: ffffffffbc628da6 RDI: 00000000fff=
fffff
[   11.026237] RBP: ffff9e9dc9c0ef58 R08: 0000000000000000 R09: 00000000000=
00003
[   11.026238] R10: ffffbff4412ab0f0 R11: ffff9ead1de35fe8 R12: ffff9e9dd60=
d4400
[   11.026239] R13: ffff9e9dd60d4548 R14: ffff9e9dc9c0ef58 R15: 00000000000=
00258
[   11.026240] FS:  00007fc9121948c0(0000) GS:ffff9eacddb00000(0000) knlGS:=
0000000000000000
[   11.026241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.026242] CR2: 00007f11564d0790 CR3: 00000001072db000 CR4: 00000000007=
50ef0
[   11.026243] PKRU: 55555554
[   11.026244] Call Trace:
[   11.026246]  <TASK>
[   11.026247]  ? __warn+0x7c/0x120
[   11.026251]  ? amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
[   11.026329]  ? report_bug+0x189/0x1c0
[   11.026332]  ? handle_bug+0x41/0x70
[   11.026334]  ? exc_invalid_op+0x13/0x60
[   11.026336]  ? asm_exc_invalid_op+0x16/0x20
[   11.026338]  ? amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
[   11.026410]  ttm_bo_release+0xfb/0x2e0 [ttm]
[   11.026413]  ? amdgpu_ttm_debugfs_init+0xf0/0xf0 [amdgpu]
[   11.026484]  ? ttm_resource_move_to_lru_tail+0x138/0x1d0 [ttm]
[   11.026486]  amdgpu_bo_free_kernel+0xc7/0x120 [amdgpu]
[   11.026556]  dm_helpers_free_gpu_mem+0x3d/0x80 [amdgpu]
[   11.026663]  dcn315_clk_mgr_construct+0x190/0x7e0 [amdgpu]
[   11.026764]  dc_clk_mgr_create+0x31c/0x500 [amdgpu]
[   11.026843]  dc_create+0x286/0x630 [amdgpu]
[   11.026938]  amdgpu_dm_init.isra.0+0x2e9/0x1f10 [amdgpu]
[   11.027022]  ? __irq_work_queue_local+0x3c/0xe0
[   11.027025]  ? irq_work_queue+0x31/0x50
[   11.027027]  ? vprintk_emit+0x17f/0x2b0
[   11.027029]  ? dev_printk_emit+0xa1/0xd0
[   11.027033]  dm_hw_init+0xe/0x20 [amdgpu]
[   11.027104]  amdgpu_device_init+0x1f52/0x2740 [amdgpu]
[   11.027180]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[   11.027183]  amdgpu_driver_load_kms+0x15/0xa0 [amdgpu]
[   11.027253]  amdgpu_pci_probe+0x183/0x4f0 [amdgpu]
[   11.027324]  local_pci_probe+0x3c/0x80
[   11.027327]  pci_device_probe+0xc3/0x240
[   11.027328]  really_probe+0xcd/0x370
[   11.027330]  ? __device_attach_driver+0xf0/0xf0
[   11.027331]  __driver_probe_device+0x78/0x150
[   11.027332]  driver_probe_device+0x1f/0x90
[   11.027333]  __driver_attach+0xbf/0x1b0
[   11.027334]  bus_for_each_dev+0x81/0xd0
[   11.027336]  bus_add_driver+0x10a/0x230
[   11.027337]  driver_register+0x55/0xf0
[   11.027339]  ? 0xffffffffc0e17000
[   11.027340]  do_one_initcall+0x54/0x310
[   11.027342]  do_init_module+0x60/0x230
[   11.027345]  init_module_from_file+0x86/0xc0
[   11.027347]  idempotent_init_module+0x120/0x2a0
[   11.027349]  __x64_sys_finit_module+0x5a/0xb0
[   11.027351]  do_syscall_64+0x80/0x190
[   11.027353]  ? vm_mmap_pgoff+0x129/0x1c0
[   11.027356]  ? fpregs_assert_state_consistent+0x1d/0x40
[   11.027359]  ? syscall_exit_to_user_mode+0x76/0x1f0
[   11.027360]  ? do_syscall_64+0x8c/0x190
[   11.027361]  ? __do_sys_newfstatat+0x4e/0x80
[   11.027364]  ? fpregs_assert_state_consistent+0x1d/0x40
[   11.027366]  ? syscall_exit_to_user_mode+0x76/0x1f0
[   11.027367]  ? do_syscall_64+0x8c/0x190
[   11.027368]  ? fpregs_restore_userregs+0x11/0xc0
[   11.027370]  ? syscall_exit_to_user_mode+0x76/0x1f0
[   11.027371]  ? do_syscall_64+0x8c/0x190
[   11.027372]  ? do_syscall_64+0x8c/0x190
[   11.027373]  ? fpregs_assert_state_consistent+0x1d/0x40
[   11.027374]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   11.027376] RIP: 0033:0x7fc91241f719
[   11.027377] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
[   11.027379] RSP: 002b:00007fffc491bc48 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   11.027380] RAX: ffffffffffffffda RBX: 000055a3eb64ff10 RCX: 00007fc9124=
1f719
[   11.027381] RDX: 0000000000000000 RSI: 00007fc9125b2efd RDI: 00000000000=
00018
[   11.027382] RBP: 00007fc9125b2efd R08: 0000000000000000 R09: 000055a3eb5=
4d730
[   11.027383] R10: 0000000000000018 R11: 0000000000000246 R12: 00000000000=
20000
[   11.027384] R13: 0000000000000000 R14: 000055a3eb64c470 R15: 000055a3d00=
94ec1
[   11.027385]  </TASK>
[   11.027386] ---[ end trace 0000000000000000 ]---

Full dmesg: https://tg.st/u/9c7ed52e84c5a1fa8aa0943139b47f7312c66b70f6dec0d=
eb409ead1a635c8c5.txt

Cheers,
        Thomas
