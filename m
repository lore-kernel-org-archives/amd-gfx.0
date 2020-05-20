Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80049C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 07:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BFF2075F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 07:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=preining.info header.i=@preining.info header.b="K4+TUIf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BFF2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=preining.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AFA6E59B;
	Wed, 20 May 2020 07:35:49 +0000 (UTC)
X-Greylist: delayed 1581 seconds by postgrey-1.36 at gabe;
 Wed, 20 May 2020 05:58:17 UTC
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DAD89CFA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 05:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=preining.info; s=201909; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hF17WuO3U+Kh7Jk6FbET2W0ULdnEPArlrE14jqZtdLE=; b=K4+TUIf3f7xWajmmS5z4PoC59k
 lqFIGyER7RuuoyjRXkx6NYdM0WmmLO/LwX9sfvzzlr4TcXXfB4PtN1vnkX4OrNEkA6mOivpI8e/uO
 8FghZMnGa3dkzan1ewy9oXE2xS9x5L6WCXpmnTFqNnRw9Ma8VoaGxEWcMfYEcdjdes6C4WKVNBTeO
 doXzAGHvYnahE5MTVq0vqb/nGI96hdYMakfdJu9PKFs/KuVIPSHyLpsjnN2zI3fMr5psKtHvKeKyT
 JAvZukWKiT3O7Y/t5U+7YFRHePKJvuZSZZmRPsbhrRc5WG079RCjfT13CPw/Fw1yON9I3n/jBj6Gn
 omhXOLQQ==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
 by hz.preining.info with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <norbert@preining.info>) id 1jbHKc-0007y0-HO
 for amd-gfx@lists.freedesktop.org; Wed, 20 May 2020 05:31:55 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
 id CAAD38FD5B45; Wed, 20 May 2020 14:31:50 +0900 (JST)
Date: Wed, 20 May 2020 14:31:50 +0900
From: Norbert Preining <norbert@preining.info>
To: amd-gfx@lists.freedesktop.org
Subject: WARNINGs in amdgpu dcn20_hwseq.c:127 dcn20_setup_gsl_group_as_lock
Message-ID: <20200520053150.GB118502@bulldog.preining.info>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 20 May 2020 07:35:49 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear all

(please cc)

Hardware: Radeon RX 5700 XT, i7-6700K CPU
Software:
- kernel 5.7.0-rc5+ commit 12bf0b632ed09
- Debian/sid

boot log lines
kernel: [drm] initializing kernel modesetting (NAVI10 0x1002:0x731F 0x1462:0x3810 0xC1).
kernel: [drm] register mmio base: 0xDFC00000
kernel: [drm] register mmio size: 524288
kernel: [drm] add ip block number 0 <nv_common>
kernel: [drm] add ip block number 1 <gmc_v10_0>
kernel: [drm] add ip block number 2 <navi10_ih>
kernel: [drm] add ip block number 3 <psp>
kernel: [drm] add ip block number 4 <smu>
kernel: [drm] add ip block number 5 <dm>
kernel: [drm] add ip block number 6 <gfx_v10_0>
kernel: [drm] add ip block number 7 <sdma_v5_0>
kernel: [drm] add ip block number 8 <vcn_v2_0>
kernel: [drm] add ip block number 9 <jpeg_v2_0>
kernel: amdgpu 0000:03:00.0: No more image in the PCI ROM
kernel: [drm] VCN decode is enabled in VM mode
kernel: [drm] VCN encode is enabled in VM mode
kernel: [drm] JPEG decode is enabled in VM mode
kernel: [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
kernel: amdgpu 0000:03:00.0: VRAM: 8176M 0x0000008000000000 - 0x00000081FEFFFFFF (8176M used)
kernel: amdgpu 0000:03:00.0: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
kernel: [drm] Detected VRAM RAM=8176M, BAR=256M
kernel: [drm] RAM width 256bits GDDR6
kernel: [TTM] Zone  kernel: Available graphics memory: 16424728 KiB
kernel: [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
kernel: [TTM] Initializing pool allocator
kernel: [TTM] Initializing DMA pool allocator
kernel: [drm] amdgpu: 8176M of VRAM memory ready
kernel: [drm] amdgpu: 8176M of GTT memory ready.
kernel: [drm] GART: num cpu pages 131072, num gpu pages 131072
kernel: [drm] PCIE GART of 512M enabled (table at 0x0000008000300000).
kernel: [drm] use_doorbell being set to: [true]
kernel: [drm] use_doorbell being set to: [true]
kernel: [drm] Found VCN firmware Version ENC: 1.7 DEC: 4 VEP: 0 Revision: 17
kernel: [drm] PSP loading VCN firmware
...
kernel: [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
kernel: [drm] kiq ring mec 2 pipe 1 q 0
kernel: [drm] VCN decode and encode initialized successfully(under DPG Mode).
kernel: [drm] JPEG decode initialized successfully.
kernel: kfd kfd: Allocated 3969056 bytes on gart
kernel: Virtual CRAT table created for GPU
kernel: Parsing CRAT table with 1 nodes
kernel: Creating topology SYSFS entries
kernel: Topology: Add dGPU node [0x731f:0x1002]
kernel: kfd kfd: added device 1002:731f
kernel: [drm] fb mappable at 0xC04C9000
kernel: [drm] vram apper at 0xC0000000
kernel: [drm] size 8294400
kernel: [drm] fb depth is 24
kernel: [drm]    pitch is 7680
kernel: fbcon: amdgpudrmfb (fb0) is primary device
kernel: Console: switching to colour frame buffer device 240x67
kernel: amdgpu 0000:03:00.0: fb0: amdgpudrmfb frame buffer device
kernel: amdgpu 0000:03:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
kernel: amdgpu 0000:03:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
kernel: amdgpu 0000:03:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
kernel: amdgpu 0000:03:00.0: ring comp_1.2.0 uses VM inv eng 5 on hub 0
kernel: amdgpu 0000:03:00.0: ring comp_1.3.0 uses VM inv eng 6 on hub 0
kernel: amdgpu 0000:03:00.0: ring comp_1.0.1 uses VM inv eng 7 on hub 0
kernel: amdgpu 0000:03:00.0: ring comp_1.1.1 uses VM inv eng 8 on hub 0
kernel: amdgpu 0000:03:00.0: ring comp_1.2.1 uses VM inv eng 9 on hub 0
kernel: amdgpu 0000:03:00.0: ring comp_1.3.1 uses VM inv eng 10 on hub 0
kernel: amdgpu 0000:03:00.0: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
kernel: amdgpu 0000:03:00.0: ring sdma0 uses VM inv eng 12 on hub 0
kernel: amdgpu 0000:03:00.0: ring sdma1 uses VM inv eng 13 on hub 0
kernel: amdgpu 0000:03:00.0: ring vcn_dec uses VM inv eng 0 on hub 1
kernel: amdgpu 0000:03:00.0: ring vcn_enc0 uses VM inv eng 1 on hub 1
kernel: amdgpu 0000:03:00.0: ring vcn_enc1 uses VM inv eng 4 on hub 1
kernel: amdgpu 0000:03:00.0: ring jpeg_dec uses VM inv eng 5 on hub 1
kernel: [drm] Initialized amdgpu 3.37.0 20150101 for 0000:03:00.0 on minor 0


When playing The Long Dark, again and again the graphic update freezes
for a few seconds (3-5) before continuing.

The kernel log shows WARNINGS regarding amdcpu:

*****
kernel: WARNING: CPU: 7 PID: 128773 at drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:127 dcn20_setup_gsl_group_as_lock+0x82/0x1f0 [amdgpu]
kernel: Modules linked in: vhost_net vhost tap vhost_iotlb xt_CHECKSUM ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 tun nf_tables nfnetlink br_netfilter bridge stp llc nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache scsi_transport_iscsi rfkill overlay binfmt_misc x86_pkg_temp_thermal kvm_intel kvm irqbypass crct10dif_pclmul uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 ghash_clmulni_intel videobuf2_common aesni_intel snd_usb_audio crypto_simd snd_usbmidi_lib cryptd videodev glue_helper snd_rawmidi mc joydev serio_raw mei_me iTCO_wdt pcspkr mei iTCO_vendor_support sg intel_pch_thermal acpi_pad evdev ext4 crc16 mbcache jbd2 i2c_dev loop parport_pc parport sunrpc ip_tables x_tables autofs4 uas usb_storage wacom hid_generic usbhid hid raid10 raid456 async_raid6_recov async_memcpy
kernel:  async_pq async_xor async_tx raid1 raid0 multipath linear md_mod crc32_pclmul amdgpu crc32c_intel psmouse mxm_wmi gpu_sched i2c_algo_bit ttm xhci_pci drm_kms_helper cec xhci_hcd i2c_designware_platform drm i2c_designware_core usbcore
kernel: CPU: 7 PID: 128773 Comm: kworker/u16:12 Tainted: G        W         5.7.0-rc5+ #48
kernel: Hardware name: MSI MS-7A16/Z170A MPOWER GAMING TITANIUM(MS-7A16), BIOS 1.10 07/22/2016
kernel: Workqueue: events_unbound commit_work [drm_kms_helper]
kernel: RIP: 0010:dcn20_setup_gsl_group_as_lock+0x82/0x1f0 [amdgpu]
kernel: Code: 74 47 84 c0 75 26 48 8b 87 30 03 00 00 0f b6 80 70 02 00 00 a8 01 0f 84 d8 00 00 00 a8 02 74 53 a8 04 0f 84 f2 00 00 00 0f 0b <0f> 0b 48 8b 44 24 28 65 48 33 04 25 28 00 00 00 0f 85 53 01 00 00
kernel: RSP: 0018:ffffb3cc44bdfa48 EFLAGS: 00010202
kernel: RAX: 0000000000000007 RBX: ffff9d4ef07a01b8 RCX: 0000000000000000
kernel: RDX: 0000000000000001 RSI: ffff9d4ef07a01b8 RDI: ffff9d56bea90000
kernel: RBP: 00000000000186a0 R08: ffffb3cc44bdfa44 R09: 0000000000000000
kernel: R10: ffff9d508c83ec00 R11: ffffb3cc44bdfa6c R12: 0000000000000001
kernel: R13: ffff9d56bea90000 R14: 0000000000000000 R15: 000000009787e801
kernel: FS:  0000000000000000(0000) GS:ffff9d56cedc0000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 000012b68e3c2000 CR3: 00000002e020a001 CR4: 00000000003606e0
kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kernel: Call Trace:
kernel:  dcn20_pipe_control_lock+0x1ac/0x1c0 [amdgpu]
kernel:  dc_commit_updates_for_stream+0xb81/0x1890 [amdgpu]
kernel:  amdgpu_dm_atomic_commit_tail+0xaf4/0x1eb0 [amdgpu]
kernel:  ? load_balance+0x172/0xc70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? _cond_resched+0x15/0x30
kernel:  ? wait_for_completion_timeout+0x36/0x100
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? __switch_to_asm+0x40/0x70
kernel:  commit_tail+0x94/0x130 [drm_kms_helper]
kernel:  process_one_work+0x1ae/0x370
kernel:  worker_thread+0x50/0x3c0
kernel:  ? process_one_work+0x370/0x370
kernel:  kthread+0x118/0x130
kernel:  ? kthread_destroy_worker+0x50/0x50
kernel:  ret_from_fork+0x35/0x40
kernel: ---[ end trace 6e0271383cfd46db ]---
*****

If there is anything else I can provide, please let me know.

Best

Norbert

--
PREINING Norbert                              https://www.preining.info
Accelia Inc. + IFMGA ProGuide + TU Wien + JAIST + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
