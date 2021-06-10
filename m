Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E750C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 07:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B54F613F1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 07:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B54F613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=stz-bg.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9C06E83B;
	Thu, 10 Jun 2021 07:30:52 +0000 (UTC)
X-Greylist: delayed 436 seconds by postgrey-1.36 at gabe;
 Thu, 10 Jun 2021 04:57:43 UTC
Received: from mail.stzbg.com (stz-bg.com [IPv6:2a02:6800:0:99::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BEF6E45D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 04:57:43 +0000 (UTC)
Received: from www.stz-bg.com (stz-bg.com [IPv6:2a02:6800:0:99::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 (Authenticated sender: condor@stz-bg.com)
 by mail.stzbg.com (Postfix) with ESMTPSA id 083782E0FAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 07:50:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stz-bg.com; s=mail;
 t=1623300624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ayt21v/tbCLZ2rmf0ZHsZRID1r/DV5nwyUbga19Sc1E=;
 b=YldAJdVYkWiO7DFInUvkJekrf+p24OnIBTnYlOIXCxQS8HraRhODwQzu6hkz2ohnEEGJXz
 zZa/8jdck7Bn90tLeTaiI73DgrxpMQcLb2D7vnSRxKiocjN2gS4LCP79TG7KlRDUfpyMYa
 PLSYQLpf1pE8DoRCUIFJlquUTAmFNN4=
MIME-Version: 1.0
Date: Thu, 10 Jun 2021 07:50:21 +0300
From: Condor <condor@stz-bg.com>
To: amd-gfx@lists.freedesktop.org
Subject: amdgpu warning/crash on kernel 5.12.9
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <0323989d9331d25779ec6a2c140450f9@stz-bg.com>
X-Sender: condor@stz-bg.com
X-Mailman-Approved-At: Thu, 10 Jun 2021 07:30:51 +0000
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

I receive warning/crash on kernel 5.12.9 on amdgpu. I paste the error 
below, did you ppl need detailed information described 
Documentation/admin-guide/reporting-bugs.rst or this is enought ?


<6>[    6.591737] [drm] fb depth is 24
<6>[    6.591738] [drm]    pitch is 10240
<6>[    6.591780] fbcon: amdgpudrmfb (fb0) is primary device
<4>[    6.831292] [drm] REG_WAIT timeout 1us * 100000 tries - 
mpc2_assert_idle_mpcc line:480
<4>[    6.831315] ------------[ cut here ]------------
<4>[    6.831315] WARNING: CPU: 0 PID: 732 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:959 
dcn30_set_hubp_blank+0x214/0x220 [amdgpu]
<4>[    6.831444] Modules linked in: joydev btusb btrtl btbcm 
hid_generic btintel bluetooth usbhid uas iwlmvm ecdh_generic ecc hid 
usb_storage usblp mac80211 snd_hda_codec_realtek intel_rapl_msr 
snd_hda_codec_generic intel_rapl_common iwlwifi amdgpu(+) ledtrig_audio 
snd_hda_codec_hdmi iommu_v2 gpu_sched drm_ttm_helper edac_mce_amd 
snd_hda_intel ttm snd_intel_dspcfg drm_kms_helper snd_intel_sdw_acpi 
snd_hda_codec kvm_amd snd_hda_core evdev wmi_bmof drm snd_hwdep kvm 
agpgart igb irqbypass snd_pcm fb_sys_fops crct10dif_pclmul crc32_pclmul 
xhci_pci cfg80211 syscopyarea dca snd_timer ghash_clmulni_intel 
sysfillrect xhci_pci_renesas i2c_piix4 snd i2c_algo_bit sysimgblt rapl 
soundcore ccp rfkill k10temp i2c_core xhci_hcd tpm_crb tpm_tis 
tpm_tis_core wmi button acpi_cpufreq loop
<4>[    6.831463] CPU: 0 PID: 732 Comm: udevd Not tainted 5.12.9 #1
<4>[    6.831465] Hardware name: To Be Filled By O.E.M. To Be Filled By 
O.E.M./X570 Phantom Gaming 4, BIOS P4.00 04/15/2021
<4>[    6.831465] RIP: 0010:dcn30_set_hubp_blank+0x214/0x220 [amdgpu]
<4>[    6.831587] Code: 31 f6 48 8b 07 48 8b 40 50 e8 18 b4 77 f6 48 8b 
9b d0 02 00 00 48 85 db 75 df eb 8c 0f 0b e9 46 ff ff ff 0f 0b e9 be fe 
ff ff <0f> 0b e9 42 fe ff ff 0f 1f 44 00 00 0f 1f 44 00 00 41 57 41 56 
45
<4>[    6.831588] RSP: 0018:ffffa90780cc7338 EFLAGS: 00010246
<4>[    6.831590] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 
0000000000000003
<4>[    6.831590] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffff9bdfd2ea0000
<4>[    6.831591] RBP: ffff9bdfd3d801e8 R08: ffffa90780cc7324 R09: 
ffffa90780cc7280
<4>[    6.831591] R10: 0000000000000002 R11: 343a656e696c2063 R12: 
ffff9bdfd3d801e8
<4>[    6.831592] R13: ffff9bdfd07f0000 R14: 0000000000000000 R15: 
ffff9bdfd3d801e8
<4>[    6.831593] FS:  00007fa55e27f140(0000) GS:ffff9be6dea00000(0000) 
knlGS:0000000000000000
<4>[    6.831594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[    6.831594] CR2: 00007fa55d9d6eb3 CR3: 00000001097bc000 CR4: 
0000000000350ef0
<4>[    6.831595] Call Trace:
<4>[    6.831597]  dcn10_wait_for_mpcc_disconnect+0x116/0x190 [amdgpu]
<4>[    6.831727]  dcn20_plane_atomic_disable+0x3e/0x150 [amdgpu]
<4>[    6.831858]  dcn20_disable_plane+0x24/0x40 [amdgpu]
<4>[    6.831985]  dcn10_init_pipes+0x307/0x3f0 [amdgpu]
<4>[    6.832112]  dce110_enable_accelerated_mode+0x9c/0x260 [amdgpu]
<4>[    6.832237]  dc_commit_state+0x97f/0xa80 [amdgpu]
<4>[    6.832359]  amdgpu_dm_atomic_commit_tail+0x576/0x25e0 [amdgpu]
<4>[    6.832489]  ? dcn30_validate_bandwidth+0x11f/0x270 [amdgpu]
<4>[    6.832621]  ? kfree+0xba/0x3f0
<4>[    6.832623]  ? dcn30_validate_bandwidth+0x11f/0x270 [amdgpu]
<4>[    6.832743]  ? fill_dc_plane_info_and_addr+0x3b0/0x3b0 [amdgpu]
<4>[    6.832870]  ? dm_plane_helper_prepare_fb+0x1db/0x240 [amdgpu]
<4>[    6.832995]  ? drm_atomic_helper_setup_commit+0x74b/0x810 
[drm_kms_helper]
<4>[    6.833005]  commit_tail+0x94/0x130 [drm_kms_helper]
<4>[    6.833014]  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
<4>[    6.833023]  drm_client_modeset_commit_atomic+0x1e4/0x220 [drm]
<4>[    6.833043]  drm_client_modeset_commit_locked+0x56/0x150 [drm]
<4>[    6.833059]  drm_client_modeset_commit+0x24/0x40 [drm]
<4>[    6.833075]  drm_fb_helper_set_par+0xa5/0xd0 [drm_kms_helper]
<4>[    6.833084]  fbcon_init+0x264/0x4f0
<4>[    6.833086]  visual_init+0xce/0x130
<4>[    6.833089]  do_bind_con_driver.isra.0+0x1db/0x2e0
<4>[    6.833091]  do_take_over_console+0x116/0x180
<4>[    6.833092]  do_fbcon_takeover+0x5c/0xc0
<4>[    6.833094]  register_framebuffer+0x1e4/0x300
<4>[    6.833096]  __drm_fb_helper_initial_config_and_unlock+0x321/0x4a0 
[drm_kms_helper]
<4>[    6.833105]  amdgpu_fbdev_init+0xb9/0xf0 [amdgpu]
<4>[    6.833207]  amdgpu_device_init.cold+0x1626/0x1ad6 [amdgpu]
<4>[    6.833335]  ? is_acpi_device_node+0x21/0x30
<4>[    6.833337]  amdgpu_driver_load_kms+0x64/0x230 [amdgpu]
<4>[    6.833437]  amdgpu_pci_probe+0x11f/0x1b0 [amdgpu]
<4>[    6.833533]  local_pci_probe+0x42/0x80
<4>[    6.833536]  ? __cond_resched+0x16/0x40
<4>[    6.833537]  pci_device_probe+0xfa/0x1b0
<4>[    6.833539]  really_probe+0xed/0x430
<4>[    6.833541]  driver_probe_device+0x4f/0xb0
<4>[    6.833542]  device_driver_attach+0xa1/0xb0
<4>[    6.833543]  __driver_attach+0x74/0x110
<4>[    6.833545]  ? device_driver_attach+0xb0/0xb0
<4>[    6.833546]  bus_for_each_dev+0x78/0xc0
<4>[    6.833547]  bus_add_driver+0x10b/0x1c0
<4>[    6.833548]  driver_register+0x8f/0xe0
<4>[    6.833549]  ? 0xffffffffc07ec000
<4>[    6.833550]  do_one_initcall+0x44/0x1d0
<4>[    6.833552]  ? do_init_module+0x23/0x260
<4>[    6.833554]  ? kmem_cache_alloc_trace+0xfd/0x210
<4>[    6.833555]  do_init_module+0x5c/0x260
<4>[    6.833557]  __do_sys_finit_module+0xa0/0xe0
<4>[    6.833559]  do_syscall_64+0x33/0x80
<4>[    6.833560]  entry_SYSCALL_64_after_hwframe+0x44/0xae
<4>[    6.833562] RIP: 0033:0x7fa55e7af189
<4>[    6.833563] Code: 48 8d 3d ca 19 0d 00 0f 05 eb a5 66 0f 1f 44 00 
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d af dc 0c 00 f7 d8 64 89 01 
48
<4>[    6.833564] RSP: 002b:00007ffe8012a018 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
<4>[    6.833565] RAX: ffffffffffffffda RBX: 00000000012758d0 RCX: 
00007fa55e7af189
<4>[    6.833566] RDX: 0000000000000000 RSI: 00007fa55e89ba9d RDI: 
0000000000000015
<4>[    6.833566] RBP: 0000000000020000 R08: 0000000000000000 R09: 
00007ffe8012a128
<4>[    6.833567] R10: 0000000000000015 R11: 0000000000000246 R12: 
00007fa55e89ba9d
<4>[    6.833567] R13: 0000000000000000 R14: 00000000012699f0 R15: 
00000000012758d0
<4>[    6.833568] ---[ end trace 2b43039a34e51706 ]---


Kind Regards,
HS
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
