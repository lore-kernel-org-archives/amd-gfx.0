Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB46C4742C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 14:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027A720679
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 14:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027A720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toad.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F03C16EB81;
	Mon,  2 Nov 2020 14:20:06 +0000 (UTC)
X-Greylist: delayed 388 seconds by postgrey-1.36 at gabe;
 Mon, 02 Nov 2020 12:15:25 UTC
Received: from hop.toad.com (75-101-100-43.dsl.static.fusionbroadband.com
 [75.101.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21446E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 12:15:25 +0000 (UTC)
Received: from hop.toad.com (localhost [127.0.0.1])
 by hop.toad.com (8.12.9/8.12.9) with ESMTP id 0A2C8sSb002765;
 Mon, 2 Nov 2020 04:08:54 -0800
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6n?= =?utf-8?Q?ig?= <christian.koenig@amd.com>,
 John Gilmore <gnu@toad.com>
Subject: amdgpu kernel stacktrace on 5.10-rc2 on Ryzen 5 4500U
MIME-Version: 1.0
Date: Mon, 02 Nov 2020 04:08:54 -0800
Message-ID: <2764.1604318934@hop.toad.com>
From: John Gilmore <gnu@toad.com>
X-Mailman-Approved-At: Mon, 02 Nov 2020 14:20:05 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I'm testing the mainline 5.10-rc2 kernel on my Lenovo Ideapad Flex 5 14"
(AMD Ryzen 5 4500U).  There have been bugs in Linux support for changing
the screen brightness even in the stock Ubuntu kernels.  There are still
bugs in -rc2, but I also noticed a stack trace in dmesg, so I thought I
would let you-all know.

The first trace occurred during suspend (another system feature that
worked very poorly in stock kernels but seems to be working on 5.10-rc2).
Then there's another trace that occurs during resume from suspend.

FYI.

	John Gilmore

[  219.330914] ------------[ cut here ]------------
[  219.331095] WARNING: CPU: 0 PID: 3397 at drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2548 dc_link_set_backlight_level+0x92/0xf0 [amdgpu]
[  219.331097] Modules linked in: rpcsec_gss_krb5 nfsv4 nfs nfs_ssc fscache ccm ip6table_filter ip6_tables iptable_filter bpfilter bnep uvcvideo btusb btrtl videobuf2_vmalloc btbcm videobuf2_memops btintel videobuf2_v4l2 videobuf2_common bluetooth videodev ecdh_generic mc ecc snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core rtw88_8822ce snd_hwdep rtw88_8822c snd_pcm input_leds rtw88_pci snd_seq_midi snd_seq_midi_event rtw88_core snd_rawmidi edac_mce_amd snd_seq kvm_amd mac80211 nls_iso8859_1 kvm snd_seq_device snd_timer snd joydev ucsi_acpi hid_multitouch serio_raw rapl cfg80211 typec_ucsi typec efi_pstore wmi_bmof ccp k10temp snd_rn_pci_acp3x soundcore libarc4 snd_pci_acp3x soc_button_array ideapad_laptop sparse_keymap mac_hid sch_fq_codel nfsd parport_pc ppdev auth_rpcgss lp nfs_acl lockd grace parport sunrpc ip_tables x_tables autofs4 dm_crypt dm_mirror dm_region_hash dm_log wacom usbhid hid_gene
 ric
[  219.331154]  amdgpu rtsx_pci_sdmmc iommu_v2 gpu_sched i2c_algo_bit ttm crct10dif_pclmul drm_kms_helper crc32_pclmul syscopyarea sysfillrect sysimgblt fb_sys_fops ghash_clmulni_intel cec aesni_intel crypto_simd cryptd rc_core glue_helper drm nvme xhci_pci xhci_pci_renesas ahci libahci i2c_piix4 nvme_core rtsx_pci wmi video i2c_hid hid
[  219.331181] CPU: 0 PID: 3397 Comm: systemd-sleep Not tainted 5.10.0-051000rc2-generic #202011012330
[  219.331183] Hardware name: LENOVO 81X2/LNVNB161216, BIOS EECN20WW 04/08/2020
[  219.331352] RIP: 0010:dc_link_set_backlight_level+0x92/0xf0 [amdgpu]
[  219.331355] Code: 70 03 00 00 31 c0 48 8d 96 c0 01 00 00 48 8b 0a 48 85 c9 74 06 4c 3b 61 08 74 22 83 c0 01 48 81 c2 d8 04 00 00 83 f8 06 75 e3 <0f> 0b 45 31 ff 5b 44 89 f8 41 5c 41 5d 41 5e 41 5f 5d c3 48 98 48
[  219.331357] RSP: 0018:ffffaa7441697c70 EFLAGS: 00010246
[  219.331359] RAX: 0000000000000006 RBX: ffff985894830000 RCX: 0000000000000000
[  219.331360] RDX: ffff98588ec61ed0 RSI: ffff98588ec60000 RDI: 0000000000000000
[  219.331361] RBP: ffffaa7441697c98 R08: 00000000000000ff R09: 0000000000000000
[  219.331362] R10: 0000000000000000 R11: ffff985880402fea R12: ffff985893d37800
[  219.331363] R13: 0000000000000000 R14: 000000000000ffff R15: 000000000000ff01
[  219.331366] FS:  00007f4c9bca7980(0000) GS:ffff985b7f600000(0000) knlGS:0000000000000000
[  219.331367] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  219.331368] CR2: 00005587f27212f8 CR3: 0000000104a78000 CR4: 0000000000350ef0
[  219.331370] Call Trace:
[  219.331541]  amdgpu_dm_backlight_update_status+0xbb/0xd0 [amdgpu]
[  219.331546]  backlight_suspend+0x71/0x80
[  219.331548]  ? brightness_store+0x80/0x80
[  219.331551]  dpm_run_callback+0x50/0x110
[  219.331553]  __device_suspend+0x128/0x3b0
[  219.331555]  dpm_suspend+0xf9/0x220
[  219.331557]  dpm_suspend_start+0x82/0x90
[  219.331561]  suspend_devices_and_enter+0x100/0x230
[  219.331564]  enter_state+0x131/0x184
[  219.331567]  pm_suspend.cold+0x22/0x6d
[  219.331569]  state_store+0x2b/0x60
[  219.331572]  kobj_attr_store+0x12/0x20
[  219.331574]  sysfs_kf_write+0x3f/0x50
[  219.331575]  kernfs_fop_write+0xda/0x1b0
[  219.331579]  vfs_write+0xc6/0x230
[  219.331581]  ksys_write+0x67/0xe0
[  219.331584]  __x64_sys_write+0x1a/0x20
[  219.331586]  do_syscall_64+0x38/0x90
[  219.331589]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  219.331591] RIP: 0033:0x7f4c9cb4e1e7
[  219.331594] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  219.331595] RSP: 002b:00007fffe6a7d108 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  219.331597] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f4c9cb4e1e7
[  219.331597] RDX: 0000000000000004 RSI: 00007fffe6a7d1c0 RDI: 0000000000000004
[  219.331598] RBP: 00007fffe6a7d1c0 R08: 0000000000000004 R09: 000000000000000d
[  219.331599] R10: 00005587f1f1c128 R11: 0000000000000246 R12: 0000000000000004
[  219.331600] R13: 00005587f271c2d0 R14: 0000000000000004 R15: 00007f4c9cc298a0
[  219.331604] CPU: 0 PID: 3397 Comm: systemd-sleep Not tainted 5.10.0-051000rc2-generic #202011012330
[  219.331605] Hardware name: LENOVO 81X2/LNVNB161216, BIOS EECN20WW 04/08/2020
[  219.331605] Call Trace:
[  219.331608]  show_stack+0x52/0x58
[  219.331610]  dump_stack+0x70/0x8b
[  219.331745]  ? dc_link_set_backlight_level+0x92/0xf0 [amdgpu]
[  219.331748]  __warn.cold+0x24/0x77
[  219.331880]  ? dc_link_set_backlight_level+0x92/0xf0 [amdgpu]
[  219.331883]  report_bug+0xa1/0xc0
[  219.331885]  handle_bug+0x3e/0xa0
[  219.331886]  exc_invalid_op+0x19/0x70
[  219.331888]  asm_exc_invalid_op+0x12/0x20
[  219.332017] RIP: 0010:dc_link_set_backlight_level+0x92/0xf0 [amdgpu]
[  219.332018] Code: 70 03 00 00 31 c0 48 8d 96 c0 01 00 00 48 8b 0a 48 85 c9 74 06 4c 3b 61 08 74 22 83 c0 01 48 81 c2 d8 04 00 00 83 f8 06 75 e3 <0f> 0b 45 31 ff 5b 44 89 f8 41 5c 41 5d 41 5e 41 5f 5d c3 48 98 48
[  219.332019] RSP: 0018:ffffaa7441697c70 EFLAGS: 00010246
[  219.332021] RAX: 0000000000000006 RBX: ffff985894830000 RCX: 0000000000000000
[  219.332021] RDX: ffff98588ec61ed0 RSI: ffff98588ec60000 RDI: 0000000000000000
[  219.332022] RBP: ffffaa7441697c98 R08: 00000000000000ff R09: 0000000000000000
[  219.332023] R10: 0000000000000000 R11: ffff985880402fea R12: ffff985893d37800
[  219.332024] R13: 0000000000000000 R14: 000000000000ffff R15: 000000000000ff01
[  219.332164]  amdgpu_dm_backlight_update_status+0xbb/0xd0 [amdgpu]
[  219.332166]  backlight_suspend+0x71/0x80
[  219.332168]  ? brightness_store+0x80/0x80
[  219.332170]  dpm_run_callback+0x50/0x110
[  219.332172]  __device_suspend+0x128/0x3b0
[  219.332174]  dpm_suspend+0xf9/0x220
[  219.332176]  dpm_suspend_start+0x82/0x90
[  219.332178]  suspend_devices_and_enter+0x100/0x230
[  219.332180]  enter_state+0x131/0x184
[  219.332182]  pm_suspend.cold+0x22/0x6d
[  219.332184]  state_store+0x2b/0x60
[  219.332186]  kobj_attr_store+0x12/0x20
[  219.332187]  sysfs_kf_write+0x3f/0x50
[  219.332189]  kernfs_fop_write+0xda/0x1b0
[  219.332191]  vfs_write+0xc6/0x230
[  219.332194]  ksys_write+0x67/0xe0
[  219.332196]  __x64_sys_write+0x1a/0x20
[  219.332198]  do_syscall_64+0x38/0x90
[  219.332200]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  219.332201] RIP: 0033:0x7f4c9cb4e1e7
[  219.332203] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  219.332204] RSP: 002b:00007fffe6a7d108 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  219.332205] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f4c9cb4e1e7
[  219.332206] RDX: 0000000000000004 RSI: 00007fffe6a7d1c0 RDI: 0000000000000004
[  219.332207] RBP: 00007fffe6a7d1c0 R08: 0000000000000004 R09: 000000000000000d
[  219.332208] R10: 00005587f1f1c128 R11: 0000000000000246 R12: 0000000000000004
[  219.332209] R13: 00005587f271c2d0 R14: 0000000000000004 R15: 00007f4c9cc298a0
[  219.332246] ---[ end trace 41c9461e9d2379e4 ]---

   ....

[  220.821873] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
[  220.827135] nvme nvme0: 16/0/0 default/read/poll queues
[  221.000075] amdgpu 0000:04:00.0: amdgpu: SMU is resuming...
[  221.000090] amdgpu 0000:04:00.0: amdgpu: smu driver if version = 0x0000000e, smu fw if version = 0x0000000c, smu fw version = 0x00373100 (55.49.0)
[  221.000092] amdgpu 0000:04:00.0: amdgpu: SMU driver if version not matched
[  221.000227] amdgpu 0000:04:00.0: amdgpu: dpm has been disabled
[  221.002287] amdgpu 0000:04:00.0: amdgpu: SMU is resumed successfully!
[  221.003637] [drm] kiq ring mec 2 pipe 1 q 0
[  221.007091] [drm] DMUB hardware initialized: version=0x00000001
[  221.041702] usb 1-4: reset high-speed USB device number 2 using xhci_hcd
[  221.042925] rtw_8822ce 0000:02:00.0: start vif ...
[  221.089551] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[  221.089632] [drm] JPEG decode initialized successfully.
[  221.089831] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[  221.089832] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  221.089833] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  221.089834] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[  221.089834] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[  221.089835] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[  221.089835] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[  221.089836] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[  221.089837] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[  221.089838] amdgpu 0000:04:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[  221.089838] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[  221.089839] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[  221.089839] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[  221.089840] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[  221.089841] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[  221.092165] usb 3-3: reset high-speed USB device number 2 using xhci_hcd
[  221.120749] ata2: SATA link down (SStatus 0 SControl 300)
[  221.120760] ata1: SATA link down (SStatus 0 SControl 300)
[  221.370120] usb 3-4: reset full-speed USB device number 3 using xhci_hcd
[  221.535187] acpi LNXPOWER:04: Turning OFF
[  221.535205] acpi LNXPOWER:03: Turning OFF
[  221.535221] acpi LNXPOWER:01: Turning OFF
[  221.535272] OOM killer enabled.
[  221.535273] Restarting tasks ... 
[  221.535442] pci_bus 0000:01: Allocating resources
[  221.535464] pcieport 0000:00:01.2: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[  221.535466] pcieport 0000:00:01.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[  221.535486] pcieport 0000:00:01.2: BAR 15: assigned [mem 0x430000000-0x4301fffff 64bit pref]
[  221.535494] pcieport 0000:00:01.2: BAR 13: assigned [io  0x3000-0x3fff]
[  221.536963] done.
[  221.537774] PM: suspend exit
[  221.540640] pci_bus 0000:02: Allocating resources
[  221.540970] pcieport 0000:00:02.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[  221.540977] pci_bus 0000:03: Allocating resources
[  221.540993] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c lmp_ver=0a lmp_subver=8822
[  221.541007] pcieport 0000:00:02.4: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[  221.541010] pcieport 0000:00:02.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[  221.541038] pcieport 0000:00:02.2: BAR 15: assigned [mem 0x430200000-0x4303fffff 64bit pref]
[  221.541053] pcieport 0000:00:02.4: BAR 15: assigned [mem 0x430400000-0x4305fffff 64bit pref]
[  221.541061] pcieport 0000:00:02.4: BAR 13: assigned [io  0x4000-0x4fff]
[  221.541400] pci_bus 0000:04: Allocating resources
[  221.541421] pci_bus 0000:05: Allocating resources
[  221.541428] pcieport 0000:00:08.2: bridge window [io  0x1000-0x0fff] to [bus 05] add_size 1000
[  221.541430] pcieport 0000:00:08.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 05] add_size 200000 add_align 100000
[  221.541450] pcieport 0000:00:08.2: BAR 15: assigned [mem 0x430600000-0x4307fffff 64bit pref]
[  221.541455] pcieport 0000:00:08.2: BAR 13: assigned [io  0x5000-0x5fff]
[  221.542880] ------------[ cut here ]------------
[  221.543117] WARNING: CPU: 4 PID: 2222 at drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:483 dcn10_get_dig_frontend+0x91/0xc0 [amdgpu]
[  221.543122] Modules linked in: rpcsec_gss_krb5 nfsv4 nfs nfs_ssc fscache ccm ip6table_filter ip6_tables iptable_filter bpfilter bnep uvcvideo btusb btrtl videobuf2_vmalloc btbcm videobuf2_memops btintel videobuf2_v4l2 videobuf2_common bluetooth videodev ecdh_generic mc ecc snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core rtw88_8822ce snd_hwdep rtw88_8822c snd_pcm input_leds rtw88_pci snd_seq_midi snd_seq_midi_event rtw88_core snd_rawmidi edac_mce_amd snd_seq kvm_amd mac80211 nls_iso8859_1 kvm snd_seq_device snd_timer snd joydev ucsi_acpi hid_multitouch serio_raw rapl cfg80211 typec_ucsi typec efi_pstore wmi_bmof ccp k10temp snd_rn_pci_acp3x soundcore libarc4 snd_pci_acp3x soc_button_array ideapad_laptop sparse_keymap mac_hid sch_fq_codel nfsd parport_pc ppdev auth_rpcgss lp nfs_acl lockd grace parport sunrpc ip_tables x_tables autofs4 dm_crypt dm_mirror dm_region_hash dm_log wacom usbhid hid_gene
 ric
[  221.543201]  amdgpu rtsx_pci_sdmmc iommu_v2 gpu_sched i2c_algo_bit ttm crct10dif_pclmul drm_kms_helper crc32_pclmul syscopyarea sysfillrect sysimgblt fb_sys_fops ghash_clmulni_intel cec aesni_intel crypto_simd cryptd rc_core glue_helper drm nvme xhci_pci xhci_pci_renesas ahci libahci i2c_piix4 nvme_core rtsx_pci wmi video i2c_hid hid
[  221.543243] CPU: 4 PID: 2222 Comm: Xorg Tainted: G        W         5.10.0-051000rc2-generic #202011012330
[  221.543246] Hardware name: LENOVO 81X2/LNVNB161216, BIOS EECN20WW 04/08/2020
[  221.543423] RIP: 0010:dcn10_get_dig_frontend+0x91/0xc0 [amdgpu]
[  221.543429] Code: 00 00 75 42 c9 44 89 c0 c3 41 b8 05 00 00 00 83 f8 20 74 e1 41 b8 06 00 00 00 83 f8 40 74 d6 41 b8 04 00 00 00 83 f8 10 74 cb <0f> 0b 41 b8 ff ff ff ff eb c1 45 31 c0 83 f8 01 74 b9 eb ec 41 b8
[  221.543432] RSP: 0018:ffffaa74425ff820 EFLAGS: 00010297
[  221.543435] RAX: 0000000000000000 RBX: ffff9859233001b8 RCX: 0000000000000008
[  221.543437] RDX: 0000000000000000 RSI: 000000000000556f RDI: ffff985893e80000
[  221.543438] RBP: ffffaa74425ff830 R08: 0000000000000000 R09: 0000000000000001
[  221.543439] R10: 0000000000fe502a R11: 0000000000000004 R12: 0000000000000000
[  221.543441] R13: ffff985893d37800 R14: ffff985894830000 R15: ffff985923300000
[  221.543444] FS:  00007fafb72bba80(0000) GS:ffff985b7f700000(0000) knlGS:0000000000000000
[  221.543445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  221.543447] CR2: 00007f924ede6070 CR3: 00000001112ee000 CR4: 0000000000350ee0
[  221.543448] Call Trace:
[  221.543627]  disable_vbios_mode_if_required+0xae/0x160 [amdgpu]
[  221.543888]  dc_commit_state_no_check+0x501/0x5b0 [amdgpu]
[  221.544052]  dc_commit_state+0x9a/0xc0 [amdgpu]
[  221.544224]  amdgpu_dm_atomic_commit_tail+0x557/0x1170 [amdgpu]
[  221.544348]  ? amdgpu_bo_move+0xa4/0x2b0 [amdgpu]
[  221.544358]  ? ttm_bo_handle_move_mem+0xba/0x4a0 [ttm]
[  221.544366]  ? ttm_bo_validate+0x137/0x150 [ttm]
[  221.544372]  ? _cond_resched+0x1a/0x50
[  221.544493]  ? amdgpu_bo_pin_restricted+0x64/0x2c0 [amdgpu]
[  221.544500]  ? ttm_bo_move_to_lru_tail+0x17/0x1a0 [ttm]
[  221.544622]  ? amdgpu_bo_gpu_offset+0x6f/0xc0 [amdgpu]
[  221.544789]  ? dm_plane_helper_prepare_fb+0x11a/0x250 [amdgpu]
[  221.544796]  ? _cond_resched+0x1a/0x50
[  221.544799]  ? __wait_for_common+0x3d/0x150
[  221.544801]  ? __wait_for_common+0x3d/0x150
[  221.544820]  commit_tail+0x99/0x130 [drm_kms_helper]
[  221.544833]  drm_atomic_helper_commit+0x123/0x150 [drm_kms_helper]
[  221.544987]  amdgpu_dm_atomic_commit+0x11/0x20 [amdgpu]
[  221.545012]  drm_atomic_commit+0x4a/0x50 [drm]
[  221.545025]  drm_atomic_helper_set_config+0x7c/0xc0 [drm_kms_helper]
[  221.545043]  drm_mode_setcrtc+0x20b/0x7e0 [drm]
[  221.545061]  ? drm_mode_getcrtc+0x190/0x190 [drm]
[  221.545078]  drm_ioctl_kernel+0xae/0xf0 [drm]
[  221.545096]  drm_ioctl+0x245/0x400 [drm]
[  221.545112]  ? drm_mode_getcrtc+0x190/0x190 [drm]
[  221.545206]  amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
[  221.545211]  __x64_sys_ioctl+0x91/0xc0
[  221.545214]  do_syscall_64+0x38/0x90
[  221.545217]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  221.545219] RIP: 0033:0x7fafb761b50b
[  221.545222] Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 89 01 48
[  221.545223] RSP: 002b:00007ffcc4129ac8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  221.545225] RAX: ffffffffffffffda RBX: 00007ffcc4129b00 RCX: 00007fafb761b50b
[  221.545226] RDX: 00007ffcc4129b00 RSI: 00000000c06864a2 RDI: 000000000000000c
[  221.545228] RBP: 00000000c06864a2 R08: 0000000000000000 R09: 0000555e011da2f0
[  221.545229] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  221.545230] R13: 000000000000000c R14: 0000555e00abde10 R15: 0000000000000000
[  221.545234] CPU: 4 PID: 2222 Comm: Xorg Tainted: G        W         5.10.0-051000rc2-generic #202011012330
[  221.545235] Hardware name: LENOVO 81X2/LNVNB161216, BIOS EECN20WW 04/08/2020
[  221.545236] Call Trace:
[  221.545240]  show_stack+0x52/0x58
[  221.545244]  dump_stack+0x70/0x8b
[  221.545378]  ? dcn10_get_dig_frontend+0x91/0xc0 [amdgpu]
[  221.545383]  __warn.cold+0x24/0x77
[  221.545515]  ? dcn10_get_dig_frontend+0x91/0xc0 [amdgpu]
[  221.545519]  report_bug+0xa1/0xc0
[  221.545521]  handle_bug+0x3e/0xa0
[  221.545522]  exc_invalid_op+0x19/0x70
[  221.545526]  asm_exc_invalid_op+0x12/0x20
[  221.545654] RIP: 0010:dcn10_get_dig_frontend+0x91/0xc0 [amdgpu]
[  221.545656] Code: 00 00 75 42 c9 44 89 c0 c3 41 b8 05 00 00 00 83 f8 20 74 e1 41 b8 06 00 00 00 83 f8 40 74 d6 41 b8 04 00 00 00 83 f8 10 74 cb <0f> 0b 41 b8 ff ff ff ff eb c1 45 31 c0 83 f8 01 74 b9 eb ec 41 b8
[  221.545658] RSP: 0018:ffffaa74425ff820 EFLAGS: 00010297
[  221.545659] RAX: 0000000000000000 RBX: ffff9859233001b8 RCX: 0000000000000008
[  221.545660] RDX: 0000000000000000 RSI: 000000000000556f RDI: ffff985893e80000
[  221.545661] RBP: ffffaa74425ff830 R08: 0000000000000000 R09: 0000000000000001
[  221.545663] R10: 0000000000fe502a R11: 0000000000000004 R12: 0000000000000000
[  221.545665] R13: ffff985893d37800 R14: ffff985894830000 R15: ffff985923300000
[  221.545793]  disable_vbios_mode_if_required+0xae/0x160 [amdgpu]
[  221.545920]  dc_commit_state_no_check+0x501/0x5b0 [amdgpu]
[  221.546045]  dc_commit_state+0x9a/0xc0 [amdgpu]
[  221.546177]  amdgpu_dm_atomic_commit_tail+0x557/0x1170 [amdgpu]
[  221.546274]  ? amdgpu_bo_move+0xa4/0x2b0 [amdgpu]
[  221.546281]  ? ttm_bo_handle_move_mem+0xba/0x4a0 [ttm]
[  221.546286]  ? ttm_bo_validate+0x137/0x150 [ttm]
[  221.546291]  ? _cond_resched+0x1a/0x50
[  221.546385]  ? amdgpu_bo_pin_restricted+0x64/0x2c0 [amdgpu]
[  221.546391]  ? ttm_bo_move_to_lru_tail+0x17/0x1a0 [ttm]
[  221.546485]  ? amdgpu_bo_gpu_offset+0x6f/0xc0 [amdgpu]
[  221.546616]  ? dm_plane_helper_prepare_fb+0x11a/0x250 [amdgpu]
[  221.546619]  ? _cond_resched+0x1a/0x50
[  221.546620]  ? __wait_for_common+0x3d/0x150
[  221.546622]  ? __wait_for_common+0x3d/0x150
[  221.546635]  commit_tail+0x99/0x130 [drm_kms_helper]
[  221.546647]  drm_atomic_helper_commit+0x123/0x150 [drm_kms_helper]
[  221.546776]  amdgpu_dm_atomic_commit+0x11/0x20 [amdgpu]
[  221.546801]  drm_atomic_commit+0x4a/0x50 [drm]
[  221.546814]  drm_atomic_helper_set_config+0x7c/0xc0 [drm_kms_helper]
[  221.546832]  drm_mode_setcrtc+0x20b/0x7e0 [drm]
[  221.546850]  ? drm_mode_getcrtc+0x190/0x190 [drm]
[  221.546867]  drm_ioctl_kernel+0xae/0xf0 [drm]
[  221.546887]  drm_ioctl+0x245/0x400 [drm]
[  221.546903]  ? drm_mode_getcrtc+0x190/0x190 [drm]
[  221.546997]  amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
[  221.547003]  __x64_sys_ioctl+0x91/0xc0
[  221.547005]  do_syscall_64+0x38/0x90
[  221.547008]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  221.547011] RIP: 0033:0x7fafb761b50b
[  221.547013] Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 89 01 48
[  221.547015] RSP: 002b:00007ffcc4129ac8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  221.547018] RAX: ffffffffffffffda RBX: 00007ffcc4129b00 RCX: 00007fafb761b50b
[  221.547019] RDX: 00007ffcc4129b00 RSI: 00000000c06864a2 RDI: 000000000000000c
[  221.547020] RBP: 00000000c06864a2 R08: 0000000000000000 R09: 0000555e011da2f0
[  221.547021] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  221.547022] R13: 000000000000000c R14: 0000555e00abde10 R15: 0000000000000000
[  221.547025] ---[ end trace 41c9461e9d2379e6 ]---
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
