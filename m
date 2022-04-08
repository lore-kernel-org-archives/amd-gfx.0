Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BAAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 13:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A28010F227;
	Fri,  8 Apr 2022 13:50:32 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A56110F0FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 08:46:25 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id l9so887493plg.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gUmSI2pT+cbM0NstQ3OSyExRgB6KZEkemZ3py+nYtWQ=;
 b=Tg4ZPDthFPU13BtJpLpJ+GsktjOkCQYbVfup1NTPS7KLDPnOnA2M20gVLAwD+oYyom
 jKuHMQ0fevwP5cE6QIeER16ETuOnMRrJiL8hh3RDNciapSFESm5qUdRdU0FO1qMHmhSC
 y5gMXKDPa8IGWtIQyldIgIyahcOProYz1CdMB5f91uxgkRO691Fnv1pb6BX8/yHQi/yB
 KyeZRJCRZlMrCuPW2J2y8I125qxb4ZNfz4AweFUjM8lGfIopbg0oPDx4T1iq+Kl0SXtm
 ObvUIUw7I9yOMMPwTFTJOcFjDDlnqWwoD3tvnI/WkwPZkuEaZaGTLVaFK2CDnLVGt1Cn
 Gx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gUmSI2pT+cbM0NstQ3OSyExRgB6KZEkemZ3py+nYtWQ=;
 b=Rd56ksY6uvLHSynQdNsJ/8ezhMc0x07ldDUL0qXElFJLnyyhYcr0sNKX3WJQbuXCjS
 PVCwVqIUKpDnYvSx0qiQqRq+cLfOxn5z27tGPVJCTRaUXEHwI/ByCVKcq/E1sKGP+NmC
 FhmYdubvB7/chmj9ShgHXJNZ9r3PTFeqTABZ/of7AXscmeJZVX+y3NgbupAW8umvCY95
 Dp/AMJevNxVAEQdY/7tK+fbWyZYdaEFuf9r3NwWotpXBZimWdrj4kfpcTYJpVwSR0G63
 QeDjQV/8VbmFzJC+iBi2zp2/8LLvrX5LARBMRUDbFX0LzZ1WAvRQKJSrd1dOk8UDBjKz
 j2XQ==
X-Gm-Message-State: AOAM532uqR6rsQVbnqfTFj0XaDrPA2I570zc/7YMCr1gzl/JzAYmaQdJ
 MZqHFgvyESaa6pib8Z/KjZ4uvaulrJ67ZOOZZ1U=
X-Google-Smtp-Source: ABdhPJyNRhyMLXB+lwUZ49eF4/BjFvoSSeedJK8gs7M5z5DCaJG/VOCIFsUMsBcDqf7LbzV60+1Lew==
X-Received: by 2002:a17:903:186:b0:154:3606:7a73 with SMTP id
 z6-20020a170903018600b0015436067a73mr18240591plg.89.1649407584503; 
 Fri, 08 Apr 2022 01:46:24 -0700 (PDT)
Received: from netturing-04.corp.microsoft.com ([167.220.233.104])
 by smtp.gmail.com with ESMTPSA id
 t38-20020a634626000000b0039cc30b7c93sm4274053pga.82.2022.04.08.01.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Apr 2022 01:46:24 -0700 (PDT)
From: Shuotao Xu <xushuotao@gmail.com>
X-Google-Original-From: Shuotao Xu <shuotaoxu@microsoft.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for AMDKFD
Date: Fri,  8 Apr 2022 08:45:44 +0000
Message-Id: <20220408084544.9313-2-shuotaoxu@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408084544.9313-1-shuotaoxu@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Apr 2022 13:50:30 +0000
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
Cc: Mukul.Joshi@amd.com, Andrey.Grodzovsky@amd.com, Felix.Kuehling@amd.com,
 pengc@microsoft.com, Lei.Qu@microsoft.com,
 Shuotao Xu <shuotaoxu@microsoft.com>, Ran.Shu@microsoft.com,
 Ziyue.Yang@microsoft.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding PCIe Hotplug Support for AMDKFD: the support of hot-plug of GPU
devices can open doors for many advanced applications in data center
in the next few years, such as for GPU resource
disaggregation. Current AMDKFD does not support hotplug out b/o the
following reasons:

1. During PCIe removal, decrement KFD lock which was incremented at
   the beginning of hw fini; otherwise kfd_open later is going to
   fail.

2. Remove redudant p2p/io links in sysfs when device is hotplugged
   out.

3. New kfd node_id is not properly assigned after a new device is
   added after a gpu is hotplugged out in a system. libhsakmt will
   find this anomaly, (i.e. node_from != <dev node id> in iolinks),
   when taking a topology_snapshot, thus returns fault to the rocm
   stack.

-- This patch fixes issue 1; another patch by Mukul fixes issues 2&3.
-- Tested on a 4-GPU MI100 gpu nodes with kernel 5.13.0-kfd; kernel
   5.16.0-kfd is unstable out of box for MI100.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 13 +++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c18c4be1e4ac..d50011bdb5c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 	return r;
 }
 
+int amdgpu_amdkfd_resume_processes(void)
+{
+	return kgd2kfd_resume_processes();
+}
+
 int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
 {
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..803306e011c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
 int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
+int amdgpu_amdkfd_resume_processes(void);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
@@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
+int kgd2kfd_resume_processes(void);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
@@ -393,6 +395,11 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return 0;
 }
 
+static inline int kgd2kfd_resume_processes(void)
+{
+	return 0;
+}
+
 static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fa4a9f13c922..5827b65b7489 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4004,6 +4004,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	if (drm_dev_is_unplugged(adev_to_drm(adev)))
 		amdgpu_device_unmap_mmio(adev);
 
+	amdgpu_amdkfd_resume_processes();
 }
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 62aa6c9d5123..ef05aae9255e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return ret;
 }
 
+/* for non-runtime resume only */
+int kgd2kfd_resume_processes(void)
+{
+	int count;
+
+	count = atomic_dec_return(&kfd_locked);
+	WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
+	if (count == 0)
+		return kfd_resume_all_processes();
+
+	return 0;
+}
+
 int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
 {
 	int err = 0;
-- 
2.25.1

