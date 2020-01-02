Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31912C3F68F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 09:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C10217F4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 09:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TceQ3yUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C10217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC5B892FB;
	Thu,  2 Jan 2020 09:08:12 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4841A892FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 09:08:11 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id u2so5024285wmc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jan 2020 01:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=BjOQztRs3btmaBTGuuE9lqE7rbGEUbft1qsTmk/rmVc=;
 b=TceQ3yUji1pQYahsFweWM5n+XKJzayp2pUulDNG+0ZyvOmPiNbyjq0Y3G2N32mxmeh
 Ex/nOIxH2HICFvF6jWnfamNOruL4eCwB9CjJk4unbqZMQjDDBFGfJFwGt2o9V0HBPeJk
 YVo39NIVg7Vr1GCb7zV9Lnm1UvxXJNnn1jJv85BIYqYZo/GFN22j/bPqADOiPzUs0bc0
 iKh6DMaqWD+GksNDhizQRNkqPg5OS0K1r/OrcJa5QLubLAmGfiA37Gs45i9Hmg65aVYX
 RGMuLm9LmV77BB46BQODLxD0jJ3V7LgiE1YPTr7vrBqXtFYs9lSis4ZthUvULGgG52XR
 3w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=BjOQztRs3btmaBTGuuE9lqE7rbGEUbft1qsTmk/rmVc=;
 b=OPoAJEVThASuRq91Im3C+soVIDk6Gvghlibvz2VGeMThvuCu5M3hShfwBwIJHR8MX9
 A4ARYnBf1+21Q5o4ypIJm/T96K2LwHz39xjEFv45IN0xdV7Mu/WXuz0Xdhrj00k2LYjl
 teEn0+sq8TCY1rtHbb1D1NG50H9hGujw7FFB6tAmfOdVe7/wJZy6hqrFO+8ERQUqSNQk
 EyfMTyu7QANvbRynxy/65wPft6J7Vq5MuKzKgHiKpm4H+M19RxwQiHvQ0B8kYtpLfJ6g
 5CPhWNoQHQKzPzAE35RkKWOSsjvfMhVua4YK+adkkIe6ccuvQkILGu76k2+M+wG3GSZ6
 1bjQ==
X-Gm-Message-State: APjAAAWyQ/2RB7EYxEnEgMznhUDHoJHYgD9FwF9lTLywz25UNw4Cu0q9
 Va0e1jV5bEmCykrVZGlMGtZboxGr
X-Google-Smtp-Source: APXvYqyGdyzVtMZQO23KF0qeTsfJwEmX1NPrrWp+7QCuMnk5Ru3Rfx1TkYhK1o4E36gyyb42euYZ8A==
X-Received: by 2002:a7b:c949:: with SMTP id i9mr13436574wml.131.1577956089648; 
 Thu, 02 Jan 2020 01:08:09 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b10sm57406947wrt.90.2020.01.02.01.08.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jan 2020 01:08:09 -0800 (PST)
Subject: Re: eGPU failed to initialize
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, amd-gfx@lists.freedesktop.org
References: <5cf8e6e2-7ec5-1412-f82d-462e9e15a8aa@gmx.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <21dc05e1-815c-6e7e-b6ed-adf225bb6234@gmail.com>
Date: Thu, 2 Jan 2020 10:08:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5cf8e6e2-7ec5-1412-f82d-462e9e15a8aa@gmx.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============0345459259=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0345459259==
Content-Type: multipart/alternative;
 boundary="------------69E5CA3C0A4920E5C4DDBF01"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------69E5CA3C0A4920E5C4DDBF01
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Qu,

that problem is completely unrelated to amdgpu. See you thunderbold 
bridge fails to assign the necessary I/O resources to the PCI device 
long before amdgpu even loads:

 From your dmesg:
>
> Jan 01 07:22:22 thinkpad kernel: pci_bus 0000:06: Allocating resources
> Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: bridge window [io  
> 0x1000-0x0fff] to [bus 0b-3a] add_size 1000
> Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: bridge window [io  
> 0x1000-0x1fff] to [bus 09-3a] add_size 1000
> Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: BAR 13: no space 
> for [io  size 0x2000]
> Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: BAR 13: failed to 
> assign [io  size 0x2000]
> Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: BAR 13: assigned 
> [io  0x2000-0x2fff]
> Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: BAR 13: [io 
> 0x2000-0x2fff] (failed to expand by 0x1000)
> Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: failed to add 1000 
> res[13]=[io  0x2000-0x2fff]
> Jan 01 07:22:22 thinkpad kernel: pci 0000:09:01.0: BAR 13: assigned 
> [io  0x2000-0x2fff]
> Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: BAR 13: no space 
> for [io  size 0x1000]
> Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: BAR 13: failed to 
> assign [io  size 0x1000]
> Jan 01 07:22:22 thinkpad kernel: pci 0000:09:01.0: BAR 13: assigned 
> [io  0x2000-0x2fff]
> Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: BAR 13: no space 
> for [io  size 0x1000]
> Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: BAR 13: failed to 
> assign [io  size 0x1000]

This is a rather unusual problem and I have no idea how you ended up 
with that. But with this setup it is impossible for the driver to access 
the device.

Regards,
Christian.

Am 01.01.20 um 10:31 schrieb Qu Wenruo:
> Hi,
>
> Not sure if this is reported before, but amdgpu is initialized for an
> external GPU (thunderbolt 3), which is not accessible at boot, only
> after boltctl initialized the tb3 subsystem.
>
> Then amdgpu will report an timeout, and failed to really initialize the GPU.
> At this stage, one my of monitors (U2414H, DP) reports unsupported
> framerate, while the other monitor (HP 24mh, HDMI) just reports no signal
>
> The involved GPU is RX580. The tb3 enclosure is AORUS GAMING BOX.
>
> And obviously, this eGPU works pretty fine under Windows.
> So my normal boot routine needs to boot into windows, then reboot into
> Linux without unplug the tb3 connector, to make the eGPU work under Linux.
>
> The kernel warning is:
> Jan 01 07:22:25 thinkpad kernel: [drm] REG_WAIT timeout 10us * 3500
> tries - dce_mi_free_dmif line:634
> Jan 01 07:22:25 thinkpad kernel: ------------[ cut here ]------------
> Jan 01 07:22:25 thinkpad kernel: WARNING: CPU: 6 PID: 804 at
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332
> generic_reg_wait.cold+0x25/0x2c [amdgpu]
> Jan 01 07:22:25 thinkpad kernel: Modules linked in: xt_CHECKSUM
> xt_MASQUERADE xt_conntrack ipt_REJECT tun bridge stp llc nf_tables_set
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct amdgpu nft_chain_nat msr
> nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
> ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle
> gpu_sched iptable_raw ttm iptable_security nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 xt_tcpudp ip_set nfnetlink ebtable_filter ebtables
> ip6table_filter ip6_tables iptable_filter cmac algif_hash algif_skcipher
> af_alg bnep joydev mousedev btrfs xor rmi_smbus rmi_core
> snd_hda_codec_hdmi iTCO_wdt mei_wdt mei_hdcp iTCO_vendor_support
> snd_hda_codec_realtek intel_rapl_msr wmi_bmof raid6_pq
> intel_wmi_thunderbolt iwlmvm snd_hda_codec_generic x86_pkg_temp_thermal
> intel_powerclamp snd_hda_intel coretemp snd_intel_nhlt mac80211
> kvm_intel snd_hda_codec nls_iso8859_1 libarc4 uvcvideo nls_cp437
> intel_cstate btusb snd_hda_core
> Jan 01 07:22:25 thinkpad kernel:  vfat videobuf2_vmalloc intel_uncore
> btrtl snd_hwdep btbcm iwlwifi videobuf2_memops intel_rapl_perf fat
> videobuf2_v4l2 btintel snd_pcm pcspkr psmouse input_leds
> videobuf2_common mei_me e1000e i2c_i801 snd_timer thunderbolt bluetooth
> cfg80211 videodev mei thinkpad_acpi intel_xhci_usb_role_switch
> processor_thermal_device ucsi_acpi ecdh_generic mc nvram ecc
> intel_rapl_common intel_soc_dts_iosf crc16 intel_pch_thermal roles
> typec_ucsi ledtrig_audio rfkill typec snd int3403_thermal wmi soundcore
> battery ac int340x_thermal_zone i2c_hid hid evdev int3400_thermal
> mac_hid acpi_thermal_rel crypto_user acpi_call(OE) kvmgt i915 vfio_mdev
> mdev vfio_iommu_type1 vfio i2c_algo_bit drm_kms_helper drm intel_gtt
> agpgart syscopyarea sysfillrect sysimgblt fb_sys_fops kvm irqbypass
> ip_tables x_tables xfs libcrc32c crc32c_generic sd_mod uas usb_storage
> scsi_mod dm_crypt crct10dif_pclmul crc32_pclmul crc32c_intel
> ghash_clmulni_intel dm_mod serio_raw atkbd libps2 aesni_intel
> crypto_simd xhci_pci cryptd
> Jan 01 07:22:25 thinkpad kernel:  glue_helper xhci_hcd i8042 serio
> Jan 01 07:22:25 thinkpad kernel: CPU: 6 PID: 804 Comm: Xorg Tainted: G
>    U     OE     5.4.6-arch3-1 #1
> Jan 01 07:22:25 thinkpad kernel: Hardware name: LENOVO
> 20KHCTO1WW/20KHCTO1WW, BIOS N23ET68W (1.43 ) 10/16/2019
> Jan 01 07:22:25 thinkpad kernel: RIP:
> 0010:generic_reg_wait.cold+0x25/0x2c [amdgpu]
> Jan 01 07:22:25 thinkpad kernel: Code: e9 82 23 fe ff 44 8b 44 24 24 48
> 8b 4c 24 18 44 89 fa 89 ee 48 c7 c7 50 73 ab c1 e8 96 5d 92 ef 83 7b 20
> 01 0f 84 48 31 fe ff <0f> 0b e9 41 31 fe ff e8 b2 16 e7 ff 48 c7 c7 00
> 50 b7 c1 e8 e6 8e
> Jan 01 07:22:25 thinkpad kernel: RSP: 0018:ffff9e61c147b5c8 EFLAGS: 00010297
> Jan 01 07:22:25 thinkpad kernel: RAX: 0000000000000044 RBX:
> ffff95854881e200 RCX: 0000000000000000
> Jan 01 07:22:25 thinkpad kernel: RDX: 0000000000000000 RSI:
> ffff95854e397708 RDI: 00000000ffffffff
> Jan 01 07:22:25 thinkpad kernel: RBP: 000000000000000a R08:
> 0000000000000507 R09: 0000000000000004
> Jan 01 07:22:25 thinkpad kernel: R10: 0000000000000000 R11:
> 0000000000000001 R12: 0000000000000322
> Jan 01 07:22:25 thinkpad kernel: R13: 0000000000000dad R14:
> 0000000000000001 R15: 0000000000000dac
> Jan 01 07:22:25 thinkpad kernel: FS:  00007f9e87acbdc0(0000)
> GS:ffff95854e380000(0000) knlGS:0000000000000000
> Jan 01 07:22:25 thinkpad kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan 01 07:22:25 thinkpad kernel: CR2: 00007f9e831de5b0 CR3:
> 00000004893f4006 CR4: 00000000003606e0
> Jan 01 07:22:25 thinkpad kernel: DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000
> Jan 01 07:22:25 thinkpad kernel: DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400
> Jan 01 07:22:25 thinkpad kernel: Call Trace:
> Jan 01 07:22:25 thinkpad kernel:  dce_mi_free_dmif+0xf7/0x160 [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:  dce110_reset_hw_ctx_wrap+0x193/0x260
> [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:  dce110_apply_ctx_to_hw+0x51/0x5d0 [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:  ?
> dce110_apply_ctx_for_surface+0x22e/0x2c0 [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:  dc_commit_state+0x280/0x5e0 [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:
> amdgpu_dm_atomic_commit_tail+0x1151/0x1da0 [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:  ? __mod_zone_page_state+0x66/0xa0
> Jan 01 07:22:25 thinkpad kernel:  ? dm_read_reg_func+0x1f/0x90 [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:  ?
> dce110_timing_generator_get_position+0x55/0x60 [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:  ? dm_crtc_get_scanoutpos+0x85/0xe0
> [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:  ? commit_tail+0x94/0x110 [drm_kms_helper]
> Jan 01 07:22:25 thinkpad kernel:  commit_tail+0x94/0x110 [drm_kms_helper]
> Jan 01 07:22:25 thinkpad kernel:  drm_atomic_helper_commit+0x108/0x110
> [drm_kms_helper]
> Jan 01 07:22:25 thinkpad kernel:  drm_atomic_helper_set_config+0x81/0x90
> [drm_kms_helper]
> Jan 01 07:22:25 thinkpad kernel:  drm_mode_setcrtc+0x1f0/0x730 [drm]
> Jan 01 07:22:25 thinkpad kernel:  ? dma_fence_default_wait+0x23a/0x2c0
> Jan 01 07:22:25 thinkpad kernel:  ? drm_mode_getcrtc+0x180/0x180 [drm]
> Jan 01 07:22:25 thinkpad kernel:  drm_ioctl_kernel+0xb2/0x100 [drm]
> Jan 01 07:22:25 thinkpad kernel:  drm_ioctl+0x209/0x360 [drm]
> Jan 01 07:22:25 thinkpad kernel:  ? drm_mode_getcrtc+0x180/0x180 [drm]
> Jan 01 07:22:25 thinkpad kernel:  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> Jan 01 07:22:25 thinkpad kernel:  do_vfs_ioctl+0x43d/0x6c0
> Jan 01 07:22:25 thinkpad kernel:  ksys_ioctl+0x5e/0x90
> Jan 01 07:22:25 thinkpad kernel:  ? switch_fpu_return+0x2d/0x140
> Jan 01 07:22:25 thinkpad kernel:  __x64_sys_ioctl+0x16/0x20
> Jan 01 07:22:25 thinkpad kernel:  do_syscall_64+0x4e/0x140
> Jan 01 07:22:25 thinkpad kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jan 01 07:22:25 thinkpad kernel: RIP: 0033:0x7f9e8891225b
> Jan 01 07:22:25 thinkpad kernel: Code: 0f 1e fa 48 8b 05 25 9c 0c 00 64
> c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa
> b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 9b 0c 00
> f7 d8 64 89 01 48
> Jan 01 07:22:25 thinkpad kernel: RSP: 002b:00007fff7908d8f8 EFLAGS:
> 00003246 ORIG_RAX: 0000000000000010
> Jan 01 07:22:25 thinkpad kernel: RAX: ffffffffffffffda RBX:
> 00007fff7908d930 RCX: 00007f9e8891225b
> Jan 01 07:22:25 thinkpad kernel: RDX: 00007fff7908d930 RSI:
> 00000000c06864a2 RDI: 000000000000000d
> Jan 01 07:22:25 thinkpad kernel: RBP: 00000000c06864a2 R08:
> 0000000000000000 R09: 0000000000000000
> Jan 01 07:22:25 thinkpad kernel: R10: 0000000000000000 R11:
> 0000000000003246 R12: 000056450439de20
> Jan 01 07:22:25 thinkpad kernel: R13: 000000000000000d R14:
> 00007fff7908dbc8 R15: 00005645043996e0
> Jan 01 07:22:25 thinkpad kernel: ---[ end trace 2b805e0326fe3e37 ]---
>
> The full dmesg can be found here:
> https://gist.github.com/adam900710/ada1566160e61be1efa5d789b124bc80
>
> Hopes one day eGPU can work better under Linux.
>
> Thanks,
> Qu
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------69E5CA3C0A4920E5C4DDBF01
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Qu,<br>
      <br>
      that problem is completely unrelated to amdgpu. See you
      thunderbold bridge fails to assign the necessary I/O resources to
      the PCI device long before amdgpu even loads:<br>
      <br>
      From your dmesg:<br>
      <blockquote type="cite"><br>
        Jan 01 07:22:22 thinkpad kernel: pci_bus 0000:06: Allocating
        resources<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: bridge window
        [io  0x1000-0x0fff] to [bus 0b-3a] add_size 1000<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: bridge window
        [io  0x1000-0x1fff] to [bus 09-3a] add_size 1000<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: BAR 13: no
        space for [io  size 0x2000]<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: BAR 13:
        failed to assign [io  size 0x2000]<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: BAR 13:
        assigned [io  0x2000-0x2fff]<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: BAR 13: [io 
        0x2000-0x2fff] (failed to expand by 0x1000)<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:08:00.0: failed to add
        1000 res[13]=[io  0x2000-0x2fff]<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:09:01.0: BAR 13:
        assigned [io  0x2000-0x2fff]<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: BAR 13: no
        space for [io  size 0x1000]<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: BAR 13:
        failed to assign [io  size 0x1000]<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:09:01.0: BAR 13:
        assigned [io  0x2000-0x2fff]<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: BAR 13: no
        space for [io  size 0x1000]<br>
        Jan 01 07:22:22 thinkpad kernel: pci 0000:09:04.0: BAR 13:
        failed to assign [io  size 0x1000]<br>
      </blockquote>
      <br>
      This is a rather unusual problem and I have no idea how you ended
      up with that. But with this setup it is impossible for the driver
      to access the device.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 01.01.20 um 10:31 schrieb Qu Wenruo:<br>
    </div>
    <blockquote type="cite"
      cite="mid:5cf8e6e2-7ec5-1412-f82d-462e9e15a8aa@gmx.com">
      <pre class="moz-quote-pre" wrap="">Hi,

Not sure if this is reported before, but amdgpu is initialized for an
external GPU (thunderbolt 3), which is not accessible at boot, only
after boltctl initialized the tb3 subsystem.

Then amdgpu will report an timeout, and failed to really initialize the GPU.
At this stage, one my of monitors (U2414H, DP) reports unsupported
framerate, while the other monitor (HP 24mh, HDMI) just reports no signal

The involved GPU is RX580. The tb3 enclosure is AORUS GAMING BOX.

And obviously, this eGPU works pretty fine under Windows.
So my normal boot routine needs to boot into windows, then reboot into
Linux without unplug the tb3 connector, to make the eGPU work under Linux.

The kernel warning is:
Jan 01 07:22:25 thinkpad kernel: [drm] REG_WAIT timeout 10us * 3500
tries - dce_mi_free_dmif line:634
Jan 01 07:22:25 thinkpad kernel: ------------[ cut here ]------------
Jan 01 07:22:25 thinkpad kernel: WARNING: CPU: 6 PID: 804 at
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332
generic_reg_wait.cold+0x25/0x2c [amdgpu]
Jan 01 07:22:25 thinkpad kernel: Modules linked in: xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT tun bridge stp llc nf_tables_set
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct amdgpu nft_chain_nat msr
nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle
gpu_sched iptable_raw ttm iptable_security nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 xt_tcpudp ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter cmac algif_hash algif_skcipher
af_alg bnep joydev mousedev btrfs xor rmi_smbus rmi_core
snd_hda_codec_hdmi iTCO_wdt mei_wdt mei_hdcp iTCO_vendor_support
snd_hda_codec_realtek intel_rapl_msr wmi_bmof raid6_pq
intel_wmi_thunderbolt iwlmvm snd_hda_codec_generic x86_pkg_temp_thermal
intel_powerclamp snd_hda_intel coretemp snd_intel_nhlt mac80211
kvm_intel snd_hda_codec nls_iso8859_1 libarc4 uvcvideo nls_cp437
intel_cstate btusb snd_hda_core
Jan 01 07:22:25 thinkpad kernel:  vfat videobuf2_vmalloc intel_uncore
btrtl snd_hwdep btbcm iwlwifi videobuf2_memops intel_rapl_perf fat
videobuf2_v4l2 btintel snd_pcm pcspkr psmouse input_leds
videobuf2_common mei_me e1000e i2c_i801 snd_timer thunderbolt bluetooth
cfg80211 videodev mei thinkpad_acpi intel_xhci_usb_role_switch
processor_thermal_device ucsi_acpi ecdh_generic mc nvram ecc
intel_rapl_common intel_soc_dts_iosf crc16 intel_pch_thermal roles
typec_ucsi ledtrig_audio rfkill typec snd int3403_thermal wmi soundcore
battery ac int340x_thermal_zone i2c_hid hid evdev int3400_thermal
mac_hid acpi_thermal_rel crypto_user acpi_call(OE) kvmgt i915 vfio_mdev
mdev vfio_iommu_type1 vfio i2c_algo_bit drm_kms_helper drm intel_gtt
agpgart syscopyarea sysfillrect sysimgblt fb_sys_fops kvm irqbypass
ip_tables x_tables xfs libcrc32c crc32c_generic sd_mod uas usb_storage
scsi_mod dm_crypt crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel dm_mod serio_raw atkbd libps2 aesni_intel
crypto_simd xhci_pci cryptd
Jan 01 07:22:25 thinkpad kernel:  glue_helper xhci_hcd i8042 serio
Jan 01 07:22:25 thinkpad kernel: CPU: 6 PID: 804 Comm: Xorg Tainted: G
  U     OE     5.4.6-arch3-1 #1
Jan 01 07:22:25 thinkpad kernel: Hardware name: LENOVO
20KHCTO1WW/20KHCTO1WW, BIOS N23ET68W (1.43 ) 10/16/2019
Jan 01 07:22:25 thinkpad kernel: RIP:
0010:generic_reg_wait.cold+0x25/0x2c [amdgpu]
Jan 01 07:22:25 thinkpad kernel: Code: e9 82 23 fe ff 44 8b 44 24 24 48
8b 4c 24 18 44 89 fa 89 ee 48 c7 c7 50 73 ab c1 e8 96 5d 92 ef 83 7b 20
01 0f 84 48 31 fe ff &lt;0f&gt; 0b e9 41 31 fe ff e8 b2 16 e7 ff 48 c7 c7 00
50 b7 c1 e8 e6 8e
Jan 01 07:22:25 thinkpad kernel: RSP: 0018:ffff9e61c147b5c8 EFLAGS: 00010297
Jan 01 07:22:25 thinkpad kernel: RAX: 0000000000000044 RBX:
ffff95854881e200 RCX: 0000000000000000
Jan 01 07:22:25 thinkpad kernel: RDX: 0000000000000000 RSI:
ffff95854e397708 RDI: 00000000ffffffff
Jan 01 07:22:25 thinkpad kernel: RBP: 000000000000000a R08:
0000000000000507 R09: 0000000000000004
Jan 01 07:22:25 thinkpad kernel: R10: 0000000000000000 R11:
0000000000000001 R12: 0000000000000322
Jan 01 07:22:25 thinkpad kernel: R13: 0000000000000dad R14:
0000000000000001 R15: 0000000000000dac
Jan 01 07:22:25 thinkpad kernel: FS:  00007f9e87acbdc0(0000)
GS:ffff95854e380000(0000) knlGS:0000000000000000
Jan 01 07:22:25 thinkpad kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jan 01 07:22:25 thinkpad kernel: CR2: 00007f9e831de5b0 CR3:
00000004893f4006 CR4: 00000000003606e0
Jan 01 07:22:25 thinkpad kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Jan 01 07:22:25 thinkpad kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Jan 01 07:22:25 thinkpad kernel: Call Trace:
Jan 01 07:22:25 thinkpad kernel:  dce_mi_free_dmif+0xf7/0x160 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  dce110_reset_hw_ctx_wrap+0x193/0x260
[amdgpu]
Jan 01 07:22:25 thinkpad kernel:  dce110_apply_ctx_to_hw+0x51/0x5d0 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  ?
dce110_apply_ctx_for_surface+0x22e/0x2c0 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  dc_commit_state+0x280/0x5e0 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:
amdgpu_dm_atomic_commit_tail+0x1151/0x1da0 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  ? __mod_zone_page_state+0x66/0xa0
Jan 01 07:22:25 thinkpad kernel:  ? dm_read_reg_func+0x1f/0x90 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  ?
dce110_timing_generator_get_position+0x55/0x60 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  ? dm_crtc_get_scanoutpos+0x85/0xe0
[amdgpu]
Jan 01 07:22:25 thinkpad kernel:  ? commit_tail+0x94/0x110 [drm_kms_helper]
Jan 01 07:22:25 thinkpad kernel:  commit_tail+0x94/0x110 [drm_kms_helper]
Jan 01 07:22:25 thinkpad kernel:  drm_atomic_helper_commit+0x108/0x110
[drm_kms_helper]
Jan 01 07:22:25 thinkpad kernel:  drm_atomic_helper_set_config+0x81/0x90
[drm_kms_helper]
Jan 01 07:22:25 thinkpad kernel:  drm_mode_setcrtc+0x1f0/0x730 [drm]
Jan 01 07:22:25 thinkpad kernel:  ? dma_fence_default_wait+0x23a/0x2c0
Jan 01 07:22:25 thinkpad kernel:  ? drm_mode_getcrtc+0x180/0x180 [drm]
Jan 01 07:22:25 thinkpad kernel:  drm_ioctl_kernel+0xb2/0x100 [drm]
Jan 01 07:22:25 thinkpad kernel:  drm_ioctl+0x209/0x360 [drm]
Jan 01 07:22:25 thinkpad kernel:  ? drm_mode_getcrtc+0x180/0x180 [drm]
Jan 01 07:22:25 thinkpad kernel:  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  do_vfs_ioctl+0x43d/0x6c0
Jan 01 07:22:25 thinkpad kernel:  ksys_ioctl+0x5e/0x90
Jan 01 07:22:25 thinkpad kernel:  ? switch_fpu_return+0x2d/0x140
Jan 01 07:22:25 thinkpad kernel:  __x64_sys_ioctl+0x16/0x20
Jan 01 07:22:25 thinkpad kernel:  do_syscall_64+0x4e/0x140
Jan 01 07:22:25 thinkpad kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan 01 07:22:25 thinkpad kernel: RIP: 0033:0x7f9e8891225b
Jan 01 07:22:25 thinkpad kernel: Code: 0f 1e fa 48 8b 05 25 9c 0c 00 64
c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa
b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 9b 0c 00
f7 d8 64 89 01 48
Jan 01 07:22:25 thinkpad kernel: RSP: 002b:00007fff7908d8f8 EFLAGS:
00003246 ORIG_RAX: 0000000000000010
Jan 01 07:22:25 thinkpad kernel: RAX: ffffffffffffffda RBX:
00007fff7908d930 RCX: 00007f9e8891225b
Jan 01 07:22:25 thinkpad kernel: RDX: 00007fff7908d930 RSI:
00000000c06864a2 RDI: 000000000000000d
Jan 01 07:22:25 thinkpad kernel: RBP: 00000000c06864a2 R08:
0000000000000000 R09: 0000000000000000
Jan 01 07:22:25 thinkpad kernel: R10: 0000000000000000 R11:
0000000000003246 R12: 000056450439de20
Jan 01 07:22:25 thinkpad kernel: R13: 000000000000000d R14:
00007fff7908dbc8 R15: 00005645043996e0
Jan 01 07:22:25 thinkpad kernel: ---[ end trace 2b805e0326fe3e37 ]---

The full dmesg can be found here:
<a class="moz-txt-link-freetext" href="https://gist.github.com/adam900710/ada1566160e61be1efa5d789b124bc80">https://gist.github.com/adam900710/ada1566160e61be1efa5d789b124bc80</a>

Hopes one day eGPU can work better under Linux.

Thanks,
Qu

</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------69E5CA3C0A4920E5C4DDBF01--

--===============0345459259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0345459259==--
