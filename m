Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A298C4727D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 01:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5A720B1F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 01:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DTXVEnVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5A720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923C16E4B0;
	Wed, 30 Sep 2020 01:15:28 +0000 (UTC)
Received: from sonic302-19.consmr.mail.sg3.yahoo.com
 (sonic302-19.consmr.mail.sg3.yahoo.com [106.10.242.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB246E4AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 01:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1601428523; bh=Xf5SI/+6kA1O+VgmJTsMiACrAb6GOPOJCPlHcdKB+TY=;
 h=Subject:To:References:From:Date:In-Reply-To:From:Subject;
 b=DTXVEnVSnVP4fmfUdbb1XVd2IYGLiG6MJcaL9b3y/1+RxG74bkVOw2ZP/YA8HynTkcx1bJPvCJ6O/wobo5xAlSOddxoJqW1D+s4FPzmRuM9cEnD9nAk1DjfKtpM5wCOYpvguoJrR4L/wAH+Wt2X7bz7qaodiHk3qThnyAdQYDAr4+UilTWYFEbfldci+ClzgYZaL8jkc84K+nLhUUNOGjtUHNT0KbWHlz8Hba5ql8vLpyJL7F7Nm4sM8zMeHhyM0qMKo1TAsHv4ChB4uugup0eIrLhPsz9YQuihUeaQ0tvQzMMBomqRFuLpOY0Eulo+jL69PWmeH980Vp7JRwGSD/Q==
X-YMail-OSG: as5yLgYVM1la_6lNyVWQ8Zgjn4G87KxzMt6gmLodxy6ikCrU5bpSuXN1W49QsDp
 INEZkijn87WAhtjwUg2RQZepvS.o.miFrE856w9zxnRiTyP_bgeHNv2vg0y0XTFky81wRVzvdh.r
 _KXIqkTQEMLlgjMJya8fCmPKGOF_u56t2U5zNwFhl1pfJMLTKkdI18I5DYOFX2dMAkaG.epl6kRh
 4SpKdIB3ZMXv4SuF3fS6Ac4X1Ed0VFupu0XhD7urrz_5mWP8PtmmFmQit4tHda7ERUME89ycDkwW
 cFIuR_1HWhs3MHPsoTdfd3SQQ9pQkpe5I8t8Xdr8iEdBtL68px4h5S3c4vOCEHD5EX.4LuXibCKE
 JZ5LqvpP.3gFlidlSOVAp2Cz64oIVWkuyCJrl4RMC16fgZVv2XS98xqwZxrb5gfAL36dWxX91c2q
 HXmafK6lo0vcWGyhHHn13UY2fGw0uzZBMCwH72ENofVCMKNdETjfCHIaFJQVItDeb5Q5_9.636Cg
 jpOv1gJKmqiUmLCv3o8svKQHjs6PLGkVSunCge6emfUPCMPmoiIqV2Qd0d8XPMADYSLoneS_b.IT
 ta6aE8QFAZuV9T_Tt7YoOpXCUqyztiWPNufkQWzg26QofpP44SQ8Q8B2UqUHALpwpvuQXQrkrNI.
 9LmcFiqaKGtvdkzeXVy5FxJld47QH_XJvPkl.mgJ3vvybpU3R89A3Ln7_BsJowH0foVtPan_Fojx
 3kF0Yy_QGN3PhQKcURStR0lhDH1E3S_XAi0h4kswiavHxZJgdm6wB39R1Cb_1dZG3FJnVr3Hvyfj
 LzTfr9zYV4EuuNwb_Gs2EVARPw2LOxlhdUBb5er.Sljot4Z4Q1POrhCZ3OUqg_CuXYb02.DND8JB
 yonULAqqy6O81C54m5uF2p72OSjzu_iBhdjSofjRU4AKDiY1KLxywAcPl8xRuv3vdQhZY4Wbf6re
 ANejOCHGytlRqhnVLr8ft42L8NDpvG7suSUgQufqqI4Ua0Wlaji4qxyTFFJuyv1XjKgRHQytZO7V
 QmgIEG8mhCXeM__5XIYaDeAjgUwCul33JsPQu_MHbWF.VI2KyW9K.dV8BX0yut0TBH1uBLBg9EBa
 _XrXb3NJtxYwylZx.mNCv6ccvAtDgNBOI8ilprn0TxcSl.Sg533GUvJPCfQjRYPi5I8nRR0mOkWG
 nogOUMaMZHs463pFvCgHzmg0vwVed__cudBRECI7noqDMNjBdgUVFxhtmLv3ZeQoD87idJTD7PyY
 X3moV2r3xlaCKYEpO0N2ZC52hqSbYz7MBP4qrk3G3n_As29bQuRSSk6tKPEzdkOlIA.WmQXbL8BK
 n1fXmJOs70NyzZ83kec2zP4qWG.NxQb3cwhqrwNAy6Ug8vxr1Oil997Tq4qUP.Vwn3wsjhUHW4YA
 D0xnN2H9v5g_H0wJyVhhL8QXplycvVPBzGegkXqh6UAqVsXy.GtkoYQVBT4EQddqA
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.sg3.yahoo.com with HTTP; Wed, 30 Sep 2020 01:15:23 +0000
Received: by smtp415.mail.sg3.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 1c85e5304e0adfc5672c60c2f8085055; 
 Wed, 30 Sep 2020 01:15:18 +0000 (UTC)
Subject: gfx timeout and GPU reset while hundreds apps run on AMD GPU
To: amd-gfx@lists.freedesktop.org
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-36-alexander.deucher@amd.com>
 <535ea0cc-67e5-a81f-47d5-87b51ee47a82@amd.com>
 <CADnq5_Op9sobQ18HDjQ9TKwcQdhGYQP28CbFQEVCcMLFMZhuyQ@mail.gmail.com>
 <fe68afee-d9c6-e320-882e-d8d2dd8aacca@amd.com>
From: wales wang <wormwang@yahoo.com>
Message-ID: <ce0f0381-81f5-2e0d-c588-b837f9c7f7d5@yahoo.com>
Date: Wed, 30 Sep 2020 09:15:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <fe68afee-d9c6-e320-882e-d8d2dd8aacca@amd.com>
X-Mailer: WebService/1.1.16718
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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

gfx timeout  and GPU reset while hundreds apps run on AMD GPU, the error happen about weekly.

Env:

Linux version 5.3.15-050315.2020063001-generic (root@k8snode) (gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)) #appstream SMP PREEMPT Sat Jul 4 10:28:24 CST 2020
vainfo: VA-API version: 1.5 (libva 2.5.0)
vainfo: Driver version: Mesa Gallium driver 19.0.5 for AMD Radeon (TM) RX 480 Graphics (POLARIS10, DRM 3.33.0, 5.3.15-050315.2020063001-generic, LLVM 7.0.0)
vainfo: Supported profile and entrypoints
ii  libdrm-dev                                           2.4.97-1ubuntu1~18.04.1                      Userspace interface to kernel DRM services -- development files

log:

Sep 29 17:42:25 k8snode244 kernel: [952607.136002] amdgpu 0005:01:00.0: GPU fault detected: 146 0x0000480c for process Media42797 pid 637190 thread appstream:cs0 pid 637206
Sep 29 17:42:25 k8snode244 kernel: [952607.136007] amdgpu 0005:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00000000
Sep 29 17:42:25 k8snode244 kernel: [952607.136009] amdgpu 0005:01:00.0:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0E04800C
Sep 29 17:42:25 k8snode244 kernel: [952607.136013] amdgpu 0005:01:00.0: VM fault (0x0c, vmid 7, pasid 32774) at page 0, read from 'TC4' (0x54433400) (72)
Sep 29 17:42:35 k8snode244 kernel: [952617.235478] [drm:amdgpu_job_timedout [amdgpu]]*ERROR*  ring gfx timeout, signaled seq=313011137, emitted seq=313011140
Sep 29 17:42:35 k8snode244 kernel: [952617.235560] [drm:amdgpu_job_timedout [amdgpu]]*ERROR*  Process information: process Media42797 pid 637190 thread appstream:cs0 pid 637206
Sep 29 17:42:35 k8snode244 kernel: [952617.235578] amdgpu 0005:01:00.0: GPU reset begin!
Sep 29 17:42:35 k8snode244 kernel: [952617.236276] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]]*ERROR*  suspend of IP block <vce_v3_0> failed -22
Sep 29 17:42:36 k8snode244 kernel: [952617.842417] amdgpu 0005:01:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]*ERROR*  ring kiq_2.1.0 test failed (-110)
Sep 29 17:42:36 k8snode244 kernel: [952617.842500] [drm:gfx_v8_0_hw_fini [amdgpu]]*ERROR*  KCQ disable failed
Sep 29 17:42:36 k8snode244 kernel: [952618.098569] cp is busy, skip halt cp
Sep 29 17:42:36 k8snode244 kernel: [952618.356730] rlc is busy, skip halt rlc
Sep 29 17:42:36 k8snode244 kernel: [952618.357783] amdgpu 0005:01:00.0: GPU pci config reset
Sep 29 17:42:36 k8snode244 kernel: [952618.476296] amdgpu 0005:01:00.0: GPU reset succeeded, trying to resume
Sep 29 17:42:36 k8snode244 kernel: [952618.478750] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
Sep 29 17:42:36 k8snode244 kernel: [952618.478770] [drm] VRAM is lost due to GPU reset!
Sep 29 17:42:37 k8snode244 kernel: [952618.610145] [drm] UVD and UVD ENC initialized successfully.
Sep 29 17:42:37 k8snode244 kernel: [952618.765301] [drm] VCE initialized successfully.
Sep 29 17:42:37 k8snode244 kernel: [952618.785034] [drm] recover vram bo from shadow start
Sep 29 17:42:37 k8snode244 kernel: [952618.849311] [drm] recover vram bo from shadow done
Sep 29 17:42:37 k8snode244 kernel: [952618.849319] [drm] Skip scheduling IBs!
Sep 29 17:42:37 k8snode244 kernel: [952618.849321] ------------[ cut here ]------------
Sep 29 17:42:37 k8snode244 kernel: [952618.849386] WARNING: CPU: 14 PID: 681455 at /home/lwj/build/kernel/include/linux/dma-fence.h:513 drm_sched_resubmit_jobs+0x188/0x1a8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849387] Modules linked in: sch_tbf veth xt_recent br_netfilter bridge stp llc xt_addrtype bpfilter ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs overlay nls_iso8859_1 ipmi_ssif snd_hda_intel snd_hda_codec joydev snd_hda_core input_leds snd_hwdep snd_pcm snd_timer snd ipmi_si soundcore ipmi_devintf ipmi_msghandler tcp_bbr sch_fq binder_dkms(OE) autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq raid1 raid0 multipath linear ses enclosure hibmc_drm hid_generic usbhid hid marvell aes_ce_blk aes_ce_cipher amdgpu i2c_algo_bit crct10dif_ce gpu_sched drm_vram_helper ttm ghash_ce sha2_ce drm_kms_helper syscopyarea sha256_arm64 sysfillrect sysimgblt fb_sys_fops sha1_ce drm hisi_sas_v2_hw hisi_sas_main libsas ehci_platform scsi_transport_sas hns_dsaf hns_enet_drv hns_mdio hnae aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
Sep 29 17:42:37 k8snode244 kernel: [952618.849440] CPU: 14 PID: 681455 Comm: kworker/14:0 Kdump: loaded Tainted: G        W  OE     5.3.15-050315.2020063001-generic #appstream
Sep 29 17:42:37 k8snode244 kernel: [952618.849442] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.63 09/19/2019
Sep 29 17:42:37 k8snode244 kernel: [952618.849450] Workqueue: events drm_sched_job_timedout [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849454] pstate: 40400005 (nZcv daif +PAN -UAO)
Sep 29 17:42:37 k8snode244 kernel: [952618.849458] pc : drm_sched_resubmit_jobs+0x188/0x1a8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849461] lr : drm_sched_resubmit_jobs+0x188/0x1a8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849462] sp : ffff00009c873c20
Sep 29 17:42:37 k8snode244 kernel: [952618.849464] x29: ffff00009c873c20 x28: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.849466] x27: ffff808e72af2300 x26: 00000000ffffff83
Sep 29 17:42:37 k8snode244 kernel: [952618.849469] x25: ffff0000094c66b8 x24: 00000000001fb320
Sep 29 17:42:37 k8snode244 kernel: [952618.849471] x23: 0000000000000001 x22: ffff801fd37a6bb8
Sep 29 17:42:37 k8snode244 kernel: [952618.849473] x21: ffff801fd37a6a30 x20: ffff80188be5ec00
Sep 29 17:42:37 k8snode244 kernel: [952618.849476] x19: ffff801f7dcc9400 x18: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.849478] x17: 0000000000000001 x16: 0000000000000007
Sep 29 17:42:37 k8snode244 kernel: [952618.849480] x15: 0000000000000000 x14: 0000000000002400
Sep 29 17:42:37 k8snode244 kernel: [952618.849481] x13: 0000000000000000 x12: ffff000011ba7000
Sep 29 17:42:37 k8snode244 kernel: [952618.849484] x11: 0000000000078918 x10: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.849486] x9 : 0000000000000001 x8 : 000000000001a8ff
Sep 29 17:42:37 k8snode244 kernel: [952618.849488] x7 : ffff000011ba7000 x6 : 00002b369e3d3bcd
Sep 29 17:42:37 k8snode244 kernel: [952618.849490] x5 : 0000000000000001 x4 : ffff8017dbbc2248
Sep 29 17:42:37 k8snode244 kernel: [952618.849492] x3 : ffff8017dbbc2248 x2 : b5be5ef7ef51a000
Sep 29 17:42:37 k8snode244 kernel: [952618.849494] x1 : 0000000000000000 x0 : 0000000000000024
Sep 29 17:42:37 k8snode244 kernel: [952618.849496] Call trace:
Sep 29 17:42:37 k8snode244 kernel: [952618.849500]  drm_sched_resubmit_jobs+0x188/0x1a8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849591]  amdgpu_device_gpu_recover+0x460/0xb58 [amdgpu]
Sep 29 17:42:37 k8snode244 kernel: [952618.849671]  amdgpu_job_timedout+0xe4/0x108 [amdgpu]
Sep 29 17:42:37 k8snode244 kernel: [952618.849676]  drm_sched_job_timedout+0x84/0xf8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849682]  process_one_work+0x1ec/0x470
Sep 29 17:42:37 k8snode244 kernel: [952618.849684]  worker_thread+0x48/0x458
Sep 29 17:42:37 k8snode244 kernel: [952618.849687]  kthread+0x110/0x118
Sep 29 17:42:37 k8snode244 kernel: [952618.849691]  ret_from_fork+0x10/0x18
Sep 29 17:42:37 k8snode244 kernel: [952618.849692] ---[ end trace 5b779f1dd4a6e6cf ]---
Sep 29 17:42:37 k8snode244 kernel: [952618.849697] [drm] Skip scheduling IBs!
Sep 29 17:42:37 k8snode244 kernel: [952618.849698] ------------[ cut here ]------------
Sep 29 17:42:37 k8snode244 kernel: [952618.849723] WARNING: CPU: 14 PID: 681455 at /home/lwj/build/kernel/include/linux/dma-fence.h:513 drm_sched_resubmit_jobs+0x188/0x1a8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849724] Modules linked in: sch_tbf veth xt_recent br_netfilter bridge stp llc xt_addrtype bpfilter ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs overlay nls_iso8859_1 ipmi_ssif snd_hda_intel snd_hda_codec joydev snd_hda_core input_leds snd_hwdep snd_pcm snd_timer snd ipmi_si soundcore ipmi_devintf ipmi_msghandler tcp_bbr sch_fq binder_dkms(OE) autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq raid1 raid0 multipath linear ses enclosure hibmc_drm hid_generic usbhid hid marvell aes_ce_blk aes_ce_cipher amdgpu i2c_algo_bit crct10dif_ce gpu_sched drm_vram_helper ttm ghash_ce sha2_ce drm_kms_helper syscopyarea sha256_arm64 sysfillrect sysimgblt fb_sys_fops sha1_ce drm hisi_sas_v2_hw hisi_sas_main libsas ehci_platform scsi_transport_sas hns_dsaf hns_enet_drv hns_mdio hnae aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
Sep 29 17:42:37 k8snode244 kernel: [952618.849759] CPU: 14 PID: 681455 Comm: kworker/14:0 Kdump: loaded Tainted: G        W  OE     5.3.15-050315.2020063001-generic #appstream
Sep 29 17:42:37 k8snode244 kernel: [952618.849760] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.63 09/19/2019
Sep 29 17:42:37 k8snode244 kernel: [952618.849767] Workqueue: events drm_sched_job_timedout [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849770] pstate: 40400005 (nZcv daif +PAN -UAO)
Sep 29 17:42:37 k8snode244 kernel: [952618.849774] pc : drm_sched_resubmit_jobs+0x188/0x1a8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849777] lr : drm_sched_resubmit_jobs+0x188/0x1a8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849778] sp : ffff00009c873c20
Sep 29 17:42:37 k8snode244 kernel: [952618.849779] x29: ffff00009c873c20 x28: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.849782] x27: ffff80901dc28000 x26: 00000000ffffff83
Sep 29 17:42:37 k8snode244 kernel: [952618.849784] x25: ffff0000094c66b8 x24: 00000000001fb320
Sep 29 17:42:37 k8snode244 kernel: [952618.849786] x23: 0000000000000001 x22: ffff801fd37a6bb8
Sep 29 17:42:37 k8snode244 kernel: [952618.849788] x21: ffff801fd37a6a30 x20: ffff801fd37a6b88
Sep 29 17:42:37 k8snode244 kernel: [952618.849790] x19: ffff80188be5ec00 x18: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.849792] x17: 0000000000000001 x16: 0000000000000007
Sep 29 17:42:37 k8snode244 kernel: [952618.849794] x15: 0000000000000000 x14: 0000000000002400
Sep 29 17:42:37 k8snode244 kernel: [952618.849796] x13: 0000000000000000 x12: ffff000011ba7000
Sep 29 17:42:37 k8snode244 kernel: [952618.849798] x11: 00000000000794fc x10: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.849800] x9 : 0000000000000001 x8 : 000000000001a923
Sep 29 17:42:37 k8snode244 kernel: [952618.849802] x7 : ffff000011ba7000 x6 : 00002b369e3d3bcd
Sep 29 17:42:37 k8snode244 kernel: [952618.849804] x5 : 0000000000000001 x4 : ffff8017dbbc2248
Sep 29 17:42:37 k8snode244 kernel: [952618.849806] x3 : ffff8017dbbc2248 x2 : b5be5ef7ef51a000
Sep 29 17:42:37 k8snode244 kernel: [952618.849808] x1 : 0000000000000000 x0 : 0000000000000024
Sep 29 17:42:37 k8snode244 kernel: [952618.849810] Call trace:
Sep 29 17:42:37 k8snode244 kernel: [952618.849813]  drm_sched_resubmit_jobs+0x188/0x1a8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849894]  amdgpu_device_gpu_recover+0x460/0xb58 [amdgpu]
Sep 29 17:42:37 k8snode244 kernel: [952618.849973]  amdgpu_job_timedout+0xe4/0x108 [amdgpu]
Sep 29 17:42:37 k8snode244 kernel: [952618.849977]  drm_sched_job_timedout+0x84/0xf8 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.849980]  process_one_work+0x1ec/0x470
Sep 29 17:42:37 k8snode244 kernel: [952618.849982]  worker_thread+0x48/0x458
Sep 29 17:42:37 k8snode244 kernel: [952618.849984]  kthread+0x110/0x118
Sep 29 17:42:37 k8snode244 kernel: [952618.849986]  ret_from_fork+0x10/0x18
Sep 29 17:42:37 k8snode244 kernel: [952618.849988] ---[ end trace 5b779f1dd4a6e6d0 ]---
Sep 29 17:42:37 k8snode244 kernel: [952618.850034] [drm] Skip scheduling IBs!
Sep 29 17:42:37 k8snode244 kernel: [952618.850036] ------------[ cut here ]------------
Sep 29 17:42:37 k8snode244 kernel: [952618.850061] WARNING: CPU: 14 PID: 903 at /home/lwj/build/kernel/include/linux/dma-fence.h:513 drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850063] Modules linked in: sch_tbf veth xt_recent br_netfilter bridge stp llc xt_addrtype bpfilter ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs overlay nls_iso8859_1 ipmi_ssif snd_hda_intel snd_hda_codec joydev snd_hda_core input_leds snd_hwdep snd_pcm snd_timer snd ipmi_si soundcore ipmi_devintf ipmi_msghandler tcp_bbr sch_fq binder_dkms(OE) autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq raid1 raid0 multipath linear ses enclosure hibmc_drm hid_generic usbhid hid marvell aes_ce_blk aes_ce_cipher amdgpu i2c_algo_bit crct10dif_ce gpu_sched drm_vram_helper ttm ghash_ce sha2_ce drm_kms_helper syscopyarea sha256_arm64 sysfillrect sysimgblt fb_sys_fops sha1_ce drm hisi_sas_v2_hw hisi_sas_main libsas ehci_platform scsi_transport_sas hns_dsaf hns_enet_drv hns_mdio hnae aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
Sep 29 17:42:37 k8snode244 kernel: [952618.850098] CPU: 14 PID: 903 Comm: gfx Kdump: loaded Tainted: G        W  OE     5.3.15-050315.2020063001-generic #appstream
Sep 29 17:42:37 k8snode244 kernel: [952618.850099] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.63 09/19/2019
Sep 29 17:42:37 k8snode244 kernel: [952618.850101] pstate: 40400005 (nZcv daif +PAN -UAO)
Sep 29 17:42:37 k8snode244 kernel: [952618.850104] pc : drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850107] lr : drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850108] sp : ffff00001c883dd0
Sep 29 17:42:37 k8snode244 kernel: [952618.850109] x29: ffff00001c883dd0 x28: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850111] x27: 0000000000000000 x26: ffff801fd37a6bc8
Sep 29 17:42:37 k8snode244 kernel: [952618.850113] x25: ffff000011b79000 x24: ffff8019e70e0858
Sep 29 17:42:37 k8snode244 kernel: [952618.850115] x23: ffff801fd37a6b18 x22: ffff801f14a45000
Sep 29 17:42:37 k8snode244 kernel: [952618.850116] x21: 0000000000000000 x20: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850118] x19: ffff801fd37a6a30 x18: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850120] x17: 0000000000000001 x16: 0000000000000007
Sep 29 17:42:37 k8snode244 kernel: [952618.850122] x15: 0000000000000000 x14: 0000000000002400
Sep 29 17:42:37 k8snode244 kernel: [952618.850123] x13: 0000000000000000 x12: ffff000011ba7000
Sep 29 17:42:37 k8snode244 kernel: [952618.850125] x11: 000000000007a0e4 x10: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850127] x9 : 0000000000000001 x8 : 000000000001a947
Sep 29 17:42:37 k8snode244 kernel: [952618.850129] x7 : ffff000011ba7000 x6 : 00002b369e3d3bcd
Sep 29 17:42:37 k8snode244 kernel: [952618.850131] x5 : 0000000000000001 x4 : ffff8017dbbc2248
Sep 29 17:42:37 k8snode244 kernel: [952618.850133] x3 : ffff8017dbbc2248 x2 : b5be5ef7ef51a000
Sep 29 17:42:37 k8snode244 kernel: [952618.850135] x1 : 0000000000000000 x0 : 0000000000000024
Sep 29 17:42:37 k8snode244 kernel: [952618.850138] Call trace:
Sep 29 17:42:37 k8snode244 kernel: [952618.850142]  drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850144]  kthread+0x110/0x118
Sep 29 17:42:37 k8snode244 kernel: [952618.850146]  ret_from_fork+0x10/0x18
Sep 29 17:42:37 k8snode244 kernel: [952618.850149] ---[ end trace 5b779f1dd4a6e6d1 ]---
Sep 29 17:42:37 k8snode244 kernel: [952618.850168] [drm] Skip scheduling IBs!
Sep 29 17:42:37 k8snode244 kernel: [952618.850170] ------------[ cut here ]------------
Sep 29 17:42:37 k8snode244 kernel: [952618.850190] WARNING: CPU: 14 PID: 903 at /home/lwj/build/kernel/include/linux/dma-fence.h:513 drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850191] Modules linked in: sch_tbf veth xt_recent br_netfilter bridge stp llc xt_addrtype bpfilter ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs overlay nls_iso8859_1 ipmi_ssif snd_hda_intel snd_hda_codec joydev snd_hda_core input_leds snd_hwdep snd_pcm snd_timer snd ipmi_si soundcore ipmi_devintf ipmi_msghandler tcp_bbr sch_fq binder_dkms(OE) autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq raid1 raid0 multipath linear ses enclosure hibmc_drm hid_generic usbhid hid marvell aes_ce_blk aes_ce_cipher amdgpu i2c_algo_bit crct10dif_ce gpu_sched drm_vram_helper ttm ghash_ce sha2_ce drm_kms_helper syscopyarea sha256_arm64 sysfillrect sysimgblt fb_sys_fops sha1_ce drm hisi_sas_v2_hw hisi_sas_main libsas ehci_platform scsi_transport_sas hns_dsaf hns_enet_drv hns_mdio hnae aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
Sep 29 17:42:37 k8snode244 kernel: [952618.850224] CPU: 14 PID: 903 Comm: gfx Kdump: loaded Tainted: G        W  OE     5.3.15-050315.2020063001-generic #appstream
Sep 29 17:42:37 k8snode244 kernel: [952618.850226] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.63 09/19/2019
Sep 29 17:42:37 k8snode244 kernel: [952618.850228] pstate: 40400005 (nZcv daif +PAN -UAO)
Sep 29 17:42:37 k8snode244 kernel: [952618.850231] pc : drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850234] lr : drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850235] sp : ffff00001c883dd0
Sep 29 17:42:37 k8snode244 kernel: [952618.850237] x29: ffff00001c883dd0 x28: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850239] x27: 0000000000000000 x26: ffff801fd37a6bc8
Sep 29 17:42:37 k8snode244 kernel: [952618.850241] x25: ffff000011b79000 x24: ffff8017d1ae2c58
Sep 29 17:42:37 k8snode244 kernel: [952618.850243] x23: ffff801fd37a6b18 x22: ffff8011c9bcea00
Sep 29 17:42:37 k8snode244 kernel: [952618.850245] x21: 0000000000000000 x20: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850247] x19: ffff801fd37a6a30 x18: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850248] x17: 0000000000000001 x16: 0000000000000007
Sep 29 17:42:37 k8snode244 kernel: [952618.850250] x15: 0000000000000000 x14: 0000000000002400
Sep 29 17:42:37 k8snode244 kernel: [952618.850252] x13: 0000000000000000 x12: ffff000011ba7000
Sep 29 17:42:37 k8snode244 kernel: [952618.850253] x11: 000000000007ab84 x10: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850255] x9 : 0000000000000001 x8 : 000000000001a965
Sep 29 17:42:37 k8snode244 kernel: [952618.850257] x7 : ffff000011ba7000 x6 : 00002b369e3d3bcd
Sep 29 17:42:37 k8snode244 kernel: [952618.850259] x5 : 0000000000000001 x4 : ffff8017dbbc2248
Sep 29 17:42:37 k8snode244 kernel: [952618.850261] x3 : ffff8017dbbc2248 x2 : b5be5ef7ef51a000
Sep 29 17:42:37 k8snode244 kernel: [952618.850263] x1 : 0000000000000000 x0 : 0000000000000024
Sep 29 17:42:37 k8snode244 kernel: [952618.850265] Call trace:
Sep 29 17:42:37 k8snode244 kernel: [952618.850269]  drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850271]  kthread+0x110/0x118
Sep 29 17:42:37 k8snode244 kernel: [952618.850274]  ret_from_fork+0x10/0x18
Sep 29 17:42:37 k8snode244 kernel: [952618.850275] ---[ end trace 5b779f1dd4a6e6d2 ]---
Sep 29 17:42:37 k8snode244 kernel: [952618.850298] [drm] Skip scheduling IBs!
Sep 29 17:42:37 k8snode244 kernel: [952618.850299] ------------[ cut here ]------------
Sep 29 17:42:37 k8snode244 kernel: [952618.850320] WARNING: CPU: 14 PID: 903 at /home/lwj/build/kernel/include/linux/dma-fence.h:513 drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850321] Modules linked in: sch_tbf veth xt_recent br_netfilter bridge stp llc xt_addrtype bpfilter ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs overlay nls_iso8859_1 ipmi_ssif snd_hda_intel snd_hda_codec joydev snd_hda_core input_leds snd_hwdep snd_pcm snd_timer snd ipmi_si soundcore ipmi_devintf ipmi_msghandler tcp_bbr sch_fq binder_dkms(OE) autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq raid1 raid0 multipath linear ses enclosure hibmc_drm hid_generic usbhid hid marvell aes_ce_blk aes_ce_cipher amdgpu i2c_algo_bit crct10dif_ce gpu_sched drm_vram_helper ttm ghash_ce sha2_ce drm_kms_helper syscopyarea sha256_arm64 sysfillrect sysimgblt fb_sys_fops sha1_ce drm hisi_sas_v2_hw hisi_sas_main libsas ehci_platform scsi_transport_sas hns_dsaf hns_enet_drv hns_mdio hnae aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
Sep 29 17:42:37 k8snode244 kernel: [952618.850355] CPU: 14 PID: 903 Comm: gfx Kdump: loaded Tainted: G        W  OE     5.3.15-050315.2020063001-generic #appstream
Sep 29 17:42:37 k8snode244 kernel: [952618.850356] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.63 09/19/2019
Sep 29 17:42:37 k8snode244 kernel: [952618.850358] pstate: 40400005 (nZcv daif +PAN -UAO)
Sep 29 17:42:37 k8snode244 kernel: [952618.850361] pc : drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850364] lr : drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850366] sp : ffff00001c883dd0
Sep 29 17:42:37 k8snode244 kernel: [952618.850367] x29: ffff00001c883dd0 x28: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850369] x27: 0000000000000000 x26: ffff801fd37a6bc8
Sep 29 17:42:37 k8snode244 kernel: [952618.850371] x25: ffff000011b79000 x24: ffff80196cad9c58
Sep 29 17:42:37 k8snode244 kernel: [952618.850373] x23: ffff801fd37a6b18 x22: ffff8017cb683900
Sep 29 17:42:37 k8snode244 kernel: [952618.850375] x21: 0000000000000000 x20: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850377] x19: ffff801fd37a6a30 x18: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850379] x17: 0000000000000001 x16: 0000000000000007
Sep 29 17:42:37 k8snode244 kernel: [952618.850380] x15: 0000000000000000 x14: 0000000000002400
Sep 29 17:42:37 k8snode244 kernel: [952618.850382] x13: 0000000000000000 x12: ffff000011ba7000
Sep 29 17:42:37 k8snode244 kernel: [952618.850384] x11: 000000000007b5d0 x10: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850386] x9 : 0000000000000001 x8 : 000000000001a983
Sep 29 17:42:37 k8snode244 kernel: [952618.850388] x7 : ffff000011ba7000 x6 : 00002b369e3d3bcd
Sep 29 17:42:37 k8snode244 kernel: [952618.850390] x5 : 0000000000000001 x4 : ffff8017dbbc2248
Sep 29 17:42:37 k8snode244 kernel: [952618.850392] x3 : ffff8017dbbc2248 x2 : b5be5ef7ef51a000
Sep 29 17:42:37 k8snode244 kernel: [952618.850395] x1 : 0000000000000000 x0 : 0000000000000024
Sep 29 17:42:37 k8snode244 kernel: [952618.850397] Call trace:
Sep 29 17:42:37 k8snode244 kernel: [952618.850400]  drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850403]  kthread+0x110/0x118
Sep 29 17:42:37 k8snode244 kernel: [952618.850405]  ret_from_fork+0x10/0x18
Sep 29 17:42:37 k8snode244 kernel: [952618.850406] ---[ end trace 5b779f1dd4a6e6d3 ]---
Sep 29 17:42:37 k8snode244 kernel: [952618.850461] [drm] Skip scheduling IBs!
Sep 29 17:42:37 k8snode244 kernel: [952618.850463] ------------[ cut here ]------------
Sep 29 17:42:37 k8snode244 kernel: [952618.850483] WARNING: CPU: 14 PID: 903 at /home/lwj/build/kernel/include/linux/dma-fence.h:513 drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850484] Modules linked in: sch_tbf veth xt_recent br_netfilter bridge stp llc xt_addrtype bpfilter ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs overlay nls_iso8859_1 ipmi_ssif snd_hda_intel snd_hda_codec joydev snd_hda_core input_leds snd_hwdep snd_pcm snd_timer snd ipmi_si soundcore ipmi_devintf ipmi_msghandler tcp_bbr sch_fq binder_dkms(OE) autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq raid1 raid0 multipath linear ses enclosure hibmc_drm hid_generic usbhid hid marvell aes_ce_blk aes_ce_cipher amdgpu i2c_algo_bit crct10dif_ce gpu_sched drm_vram_helper ttm ghash_ce sha2_ce drm_kms_helper syscopyarea sha256_arm64 sysfillrect sysimgblt fb_sys_fops sha1_ce drm hisi_sas_v2_hw hisi_sas_main libsas ehci_platform scsi_transport_sas hns_dsaf hns_enet_drv hns_mdio hnae aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
Sep 29 17:42:37 k8snode244 kernel: [952618.850519] CPU: 14 PID: 903 Comm: gfx Kdump: loaded Tainted: G        W  OE     5.3.15-050315.2020063001-generic #appstream
Sep 29 17:42:37 k8snode244 kernel: [952618.850520] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.63 09/19/2019
Sep 29 17:42:37 k8snode244 kernel: [952618.850522] pstate: 40400005 (nZcv daif +PAN -UAO)
Sep 29 17:42:37 k8snode244 kernel: [952618.850525] pc : drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850528] lr : drm_sched_main+0x2d4/0x2e0 [gpu_sched]
Sep 29 17:42:37 k8snode244 kernel: [952618.850529] sp : ffff00001c883dd0
Sep 29 17:42:37 k8snode244 kernel: [952618.850530] x29: ffff00001c883dd0 x28: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850531] x27: 0000000000000000 x26: ffff801fd37a6bc8
Sep 29 17:42:37 k8snode244 kernel: [952618.850533] x25: ffff000011b79000 x24: ffff808ca5534458
Sep 29 17:42:37 k8snode244 kernel: [952618.850535] x23: ffff801fd37a6b18 x22: ffff80161a411200
Sep 29 17:42:37 k8snode244 kernel: [952618.850536] x21: 0000000000000000 x20: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850538] x19: ffff801fd37a6a30 x18: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850540] x17: 0000000000000001 x16: 0000000000000007
Sep 29 17:42:37 k8snode244 kernel: [952618.850541] x15: 0000000000000000 x14: 0000000000002400
Sep 29 17:42:37 k8snode244 kernel: [952618.850543] x13: 0000000000000000 x12: ffff000011ba7000
Sep 29 17:42:37 k8snode244 kernel: [952618.850546] x11: 000000000007c018 x10: 0000000000000000
Sep 29 17:42:37 k8snode244 kernel: [952618.850548] x9 : 0000000000000001 x8 : 000000000001a9a1
Sep 29 17:42:37 k8snode244 kernel: [952618.850550] x7 : ffff000011ba7000 x6 : 00002b369e3d3bcd
Sep 29 17:42:37 k8snode244 kernel: [952618.850552] x5 : 0000000000000001 x4 : ffff8017dbbc2248
Sep 29 17:42:37 k8snode244 kernel: [952618.850553] x3 : ffff8017dbbc2248 x2 : b5be5ef7ef51a000
Sep 29 17:42:37 k8snode244 kernel: [952618.850555] x1 : 0000000000000000 x0 : 0000000000000024


+++++++++++keylog++++++++++++++++++
Sep 29 17:42:35 k8snode244 kernel: [952617.235578] amdgpu 0005:01:00.0: GPU reset begin!
Sep 29 17:42:35 k8snode244 kernel: [952617.236276] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]]*ERROR*  suspend of IP block <vce_v3_0> failed -22
Sep 29 17:42:36 k8snode244 kernel: [952617.842417] amdgpu 0005:01:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]*ERROR*  ring kiq_2.1.0 test failed (-110)
Sep 29 17:42:36 k8snode244 kernel: [952617.842500] [drm:gfx_v8_0_hw_fini [amdgpu]]*ERROR*  KCQ disable failed
Sep 29 17:42:36 k8snode244 kernel: [952618.098569] cp is busy, skip halt cp
Sep 29 17:42:36 k8snode244 kernel: [952618.356730] rlc is busy, skip halt rlc
Sep 29 17:42:36 k8snode244 kernel: [952618.357783] amdgpu 0005:01:00.0: GPU pci config reset
Sep 29 17:42:36 k8snode244 kernel: [952618.476296] amdgpu 0005:01:00.0: GPU reset succeeded, trying to resume

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
