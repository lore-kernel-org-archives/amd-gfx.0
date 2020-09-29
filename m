Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F5C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 07:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46154207F7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 07:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46154207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073A788F78;
	Tue, 29 Sep 2020 07:33:53 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C0D89D4F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 06:42:01 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1EF9CAA55;
 Tue, 29 Sep 2020 06:42:00 +0000 (UTC)
Date: Tue, 29 Sep 2020 08:41:58 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Regression in amdgpu driver / kernel v5.8.6
Message-ID: <20200929084118.1ff66f59@endymion>
In-Reply-To: <20200929081404.4d8df525@endymion>
References: <20200928111037.51ed4aeb@endymion>
 <CADnq5_OBSxK=Ds7X-e8xfHUDb0js7vtWbz-y7mabpFg0BhB5kw@mail.gmail.com>
 <20200929081404.4d8df525@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 29 Sep 2020 07:33:52 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Navid Emamdoost <navid.emamdoost@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 29 Sep 2020 08:14:04 +0200, Jean Delvare wrote:
> I'm not familiar enough with the amdgpu driver to efficiently continue
> debugging this issue on my own, so I'll do what I can, but some
> guidance would be welcome.

As an additional data point, here's what I found this morning in my
kernel logs after the bug happened (this is kernel v5.8.10 + my partial
revert):

[  849.877422] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[  850.001620] [drm] UVD and UVD ENC initialized successfully.
[  850.133559] [drm] VCE initialized successfully.
[  868.849448] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[  868.973664] [drm] UVD and UVD ENC initialized successfully.
[  869.105600] [drm] VCE initialized successfully.
[  909.889523] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[  910.013726] [drm] UVD and UVD ENC initialized successfully.
[  910.145661] [drm] VCE initialized successfully.
[  943.837573] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[  943.961773] [drm] UVD and UVD ENC initialized successfully.
[  944.093708] [drm] VCE initialized successfully.
[ 2008.410353] tun: Universal TUN/TAP device driver, 1.6
[ 2448.911371] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 2449.028562] [drm] UVD and UVD ENC initialized successfully.
[ 2449.167507] [drm] VCE initialized successfully.
[ 2449.583552] ------------[ cut here ]------------
[ 2449.583654] WARNING: CPU: 2 PID: 1935 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1005 amdgpu_bo_unpin.cold+0x0/0x3b [amdgpu]
[ 2449.583655] Modules linked in: tun fuse af_packet ip6t_REJECT
nf_reject_ipv6 ip6t_rpfilter xt_tcpudp ipt_REJECT nf_reject_ipv4
xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
iptable_security iscsi_ibft iscsi_boot_sysfs ip_set nfnetlink
ebtable_filter ebtables rfkill ip6table_filter ip6_tables
iptable_filter ip_tables x_tables bpfilter dmi_sysfs msr intel_rapl_msr
iTCO_wdt intel_pmc_bxt intel_rapl_common joydev ee1004
iTCO_vendor_support mei_hdcp ppdev x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm snd_usb_audio uvcvideo
videobuf2_vmalloc snd_hda_codec_realtek videobuf2_memops
snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio videobuf2_v4l2
irqbypass snd_usbmidi_lib videobuf2_common snd_rawmidi snd_hda_intel
snd_seq_device snd_intel_dspcfg videodev snd_hda_codec e1000e
efi_pstore pcspkr snd_hda_core i2c_i801 mc snd_hwdep [ 2449.583671]
hid_cherry i2c_smbus snd_pcm snd_timer snd mei_me parport_pc soundcore
mei tiny_power_button parport button acpi_pad squashfs nls_iso8859_1
nls_cp437 vfat fat loop hid_generic usbhid amdgpu iommu_v2 gpu_sched
i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops cec rc_core crct10dif_pclmul crc32_pclmul xhci_pci
crc32c_intel xhci_pci_renesas ghash_clmulni_intel xhci_hcd drm usbcore
aesni_intel glue_helper crypto_simd sr_mod cryptd cdrom video sg
dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
[ 2449.583685] CPU: 2 PID: 1935 Comm: X Not tainted 5.8.10-1-default #1 openSUSE Tumbleweed
[ 2449.583686] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H270M Pro4, BIOS P1.10 11/14/2016
[ 2449.583777] RIP: 0010:amdgpu_bo_unpin.cold+0x0/0x3b [amdgpu]
[ 2449.583779] Code: e9 41 e9 d5 ff 48 c7 c7 b8 d6 95 c0 41 89 c4 e8 31 3c 69 cc e9 bf ea d5 ff 48 c7 c7 f0 d6 95 c0 e8 20 3c 69 cc e9 15 ed d5 ff <0f> 0b 48 8b bb d0 b0 ff ff 4c 89 e2 48 c7 c6 b0 d7 95 c0 45 31 ed
[ 2449.583780] RSP: 0018:ffffa95b41f33870 EFLAGS: 00010246
[ 2449.583781] RAX: 0000000000000000 RBX: ffff891ccc404f30 RCX: 0000000000000000
[ 2449.583781] RDX: ffff891cb35ede80 RSI: 0000000000000000 RDI: ffff891be0051400
[ 2449.583782] RBP: ffff891ccc400000 R08: 0000000000000000 R09: 0000000000000000
[ 2449.583782] R10: 000000000548700e R11: 0000000000000000 R12: ffff891be0051400
[ 2449.583783] R13: ffff891ccc404f30 R14: ffff891be0051400 R15: 000000f47c000000
[ 2449.583784] FS:  00007f9426fc6940(0000) GS:ffff891cded00000(0000) knlGS:0000000000000000
[ 2449.583785] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2449.583786] CR2: 00003714b98d0000 CR3: 000000044f0ea005 CR4: 00000000003606e0
[ 2449.583786] Call Trace:
[ 2449.583846]  dce_v11_0_crtc_do_set_base+0x4a3/0x760 [amdgpu]
[ 2449.583902]  dce_v11_0_crtc_mode_set+0x72/0x1b0 [amdgpu]
[ 2449.583910]  drm_crtc_helper_set_mode+0x31e/0x450 [drm_kms_helper]
[ 2449.583917]  drm_crtc_helper_set_config+0x734/0x970 [drm_kms_helper]
[ 2449.583962]  amdgpu_display_crtc_set_config+0x4c/0x110 [amdgpu]
[ 2449.583977]  __drm_mode_set_config_internal+0x8f/0x130 [drm]
[ 2449.583987]  drm_mode_setcrtc+0x518/0x6f0 [drm]
[ 2449.584033]  ? amdgpu_cs_wait_ioctl+0xd2/0x160 [amdgpu]
[ 2449.584043]  ? drm_mode_getcrtc+0x180/0x180 [drm]
[ 2449.584051]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[ 2449.584059]  drm_ioctl+0x1f6/0x390 [drm]
[ 2449.584068]  ? drm_mode_getcrtc+0x180/0x180 [drm]
[ 2449.584110]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[ 2449.584114]  ksys_ioctl+0x82/0xc0
[ 2449.584116]  __x64_sys_ioctl+0x16/0x20
[ 2449.584118]  do_syscall_64+0x4d/0xd0
[ 2449.584120]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2449.584121] RIP: 0033:0x7f94273f3797
[ 2449.584123] Code: 00 00 00 48 8b 05 f9 96 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 96 0c 00 f7 d8 64 89 01 48
[ 2449.584123] RSP: 002b:00007ffc127a2688 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 2449.584124] RAX: ffffffffffffffda RBX: 00007ffc127a26c0 RCX: 00007f94273f3797
[ 2449.584125] RDX: 00007ffc127a26c0 RSI: 00000000c06864a2 RDI: 000000000000000d
[ 2449.584125] RBP: 00000000c06864a2 R08: 0000000000000000 R09: 00005595b333cae0
[ 2449.584126] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[ 2449.584127] R13: 000000000000000d R14: 00005595b333cae0 R15: 0000000000000000
[ 2449.584128] ---[ end trace a36c3045e99be6ba ]---
[ 2449.584131] amdgpu 0000:01:00.0: amdgpu: 0000000061406071 unpin not necessary
[ 2449.824003] amdgpu 0000:01:00.0: amdgpu: 0000000061406071 unpin not necessary
[ 2469.495402] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 2469.619600] [drm] UVD and UVD ENC initialized successfully.
[ 2469.751539] [drm] VCE initialized successfully.
[ 2470.148575] amdgpu 0000:01:00.0: amdgpu: 000000009785bfb8 unpin not necessary
[ 2470.383791] amdgpu 0000:01:00.0: amdgpu: 000000009785bfb8 unpin not necessary
[ 3245.012201] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 3245.136400] [drm] UVD and UVD ENC initialized successfully.
[ 3245.268338] [drm] VCE initialized successfully.
[ 3249.045528] amdgpu 0000:01:00.0: amdgpu: 0000000056989517 unpin not necessary
[ 3249.313774] amdgpu 0000:01:00.0: amdgpu: 0000000056989517 unpin not necessary
[ 3773.420824] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 3773.538022] [drm] UVD and UVD ENC initialized successfully.
[ 3773.676961] [drm] VCE initialized successfully.
[ 3774.143007] amdgpu 0000:01:00.0: amdgpu: 0000000036bd3a17 unpin not necessary
[ 3774.371396] amdgpu 0000:01:00.0: amdgpu: 0000000036bd3a17 unpin not necessary
[ 3908.876874] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 3909.001080] [drm] UVD and UVD ENC initialized successfully.
[ 3909.133013] [drm] VCE initialized successfully.
[ 3909.532184] amdgpu 0000:01:00.0: amdgpu: 000000000458519d unpin not necessary
[ 3909.778349] amdgpu 0000:01:00.0: amdgpu: 000000000458519d unpin not necessary
[ 6080.746984] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 6080.874179] [drm] UVD and UVD ENC initialized successfully.
[ 6081.003121] [drm] VCE initialized successfully.
[ 6081.411166] amdgpu 0000:01:00.0: amdgpu: 000000000d5c57b8 unpin not necessary
[ 6081.661361] amdgpu 0000:01:00.0: amdgpu: 000000000d5c57b8 unpin not necessary
[ 6092.286906] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 6092.411104] [drm] UVD and UVD ENC initialized successfully.
[ 6092.543045] [drm] VCE initialized successfully.
[ 6118.075052] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 6118.199250] [drm] UVD and UVD ENC initialized successfully.
[ 6118.331191] [drm] VCE initialized successfully.
[ 6126.742796] amdgpu 0000:01:00.0: amdgpu: 0000000052c9ac62 unpin not necessary
[ 6126.742876] amdgpu 0000:01:00.0: amdgpu: 0000000052c9ac62 unpin not necessary
[ 6129.882923] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 6130.007124] [drm] UVD and UVD ENC initialized successfully.
[ 6130.139061] [drm] VCE initialized successfully.
[ 6144.402143] amdgpu 0000:01:00.0: amdgpu: 0000000052c9ac62 unpin not necessary
[ 6144.402189] amdgpu 0000:01:00.0: amdgpu: 0000000052c9ac62 unpin not necessary
[ 6146.118917] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 6146.243115] [drm] UVD and UVD ENC initialized successfully.
[ 6146.375053] [drm] VCE initialized successfully.
[ 6199.891325] amdgpu 0000:01:00.0: amdgpu: 0000000052c9ac62 unpin not necessary
[ 6199.891373] amdgpu 0000:01:00.0: amdgpu: 0000000052c9ac62 unpin not necessary
[ 6200.759095] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[ 6200.883293] [drm] UVD and UVD ENC initialized successfully.
[ 6201.015234] [drm] VCE initialized successfully.
[ 6213.815047] amdgpu 0000:01:00.0: amdgpu: 0000000052c9ac62 unpin not necessary
[ 6214.064355] amdgpu 0000:01:00.0: amdgpu: 0000000052c9ac62 unpin not necessary

Hopefully this sets you guys on a useful track.

-- 
Jean Delvare
SUSE L3 Support
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
