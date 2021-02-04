Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A03FC433E6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E936564E3F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E936564E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C3F6E12D;
	Thu,  4 Feb 2021 18:47:19 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA45A89F41
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 18:47:17 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id l27so4338373qki.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X7ZZTDtmx447K8qmGVuOeuXsnJYtBKKjS+paHGa10XM=;
 b=CRQPdjqaYKp2onGZqrC6B1T8LKMWwldJgK6G1JmyoeC7NpdJoHUC4FgBJ58oXvaqhc
 Q30vEm42RmCtD9vDATYkKoiqzzQhJAHlfPDcFEnKzXOjHlfe+bzEqC2FfPHyOcDWiHe4
 B7V7EerI6A3PUh/iNPFMPZGjeZEOjnDjay53NpsI/jzBUW01O9xyYymY0+Obr//bc8Tu
 HoM/vJyw8CsJ+Me7owzNaTOjemj8sRdWi9MgGTmXR9uvO+IFpN0UFNesqDnt3oCTawPO
 fgGYsnMLmQWwaBenBwUMYr0+opRdVjpmTeThY55v+UQFGaK8CBdxcz3V+cOnQhfO5UHD
 Huhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X7ZZTDtmx447K8qmGVuOeuXsnJYtBKKjS+paHGa10XM=;
 b=IvJ/5neOoJlJpnLAPp/JiwdIYnkPOrEEE26v/nv4OwIiTTFrPQKKaDV+N0O8M02dkB
 nl8jDOY+V9rIWZ1VSDpzBTRF5FbjXLb5PdtIAF6TRWria00IBAI7KEimK6sF/nwGhJFe
 yg9mEcGKvbcQHY9kBRzCHU3kCHKpvdSRIhNymHiH178ivoC10h4Ecxe+gkdpTvkXlvlh
 MTqRsVxcq+hbO7AN6wLJdJfAOg4dtIs8cg5tSZjmw1GNbPhm9+clHJz7yCbT/72BuUMs
 QINi3X94LYS9EhciSw279aOZLYK6+MWCAUPnhSN+n6qp0TIRD/0CuSwnus+GW60UqYXp
 SPRA==
X-Gm-Message-State: AOAM530+AIhuUabwk5bvrY4mDGwZ9PuBwRGN2x0x4KHziyDSxl+uRI4E
 QDLYLcZ+JVF7JcVTA2mDYOfT/5oTd70=
X-Google-Smtp-Source: ABdhPJwkm0YOlZdtkeZdGjCyhQTe+iNS1Q5ddzbWSeAkAAJsdEWviatCty8vK8t6yA0U3btHjQA3vQ==
X-Received: by 2002:a37:b802:: with SMTP id i2mr583494qkf.76.1612464436937;
 Thu, 04 Feb 2021 10:47:16 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id j188sm5833644qke.67.2021.02.04.10.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 10:47:16 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: add generic pci reset as an option
Date: Thu,  4 Feb 2021 13:47:03 -0500
Message-Id: <20210204184706.168934-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204184706.168934-1-alexander.deucher@amd.com>
References: <20210204184706.168934-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows us to use generic PCI reset mechanisms (FLR, SBR) as
a reset mechanism to verify that the generic PCI reset mechanisms
are working properly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 ++--
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fdfa88c7b171..c031d1a69fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -579,7 +579,8 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_MODE0,
 	AMD_RESET_METHOD_MODE1,
 	AMD_RESET_METHOD_MODE2,
-	AMD_RESET_METHOD_BACO
+	AMD_RESET_METHOD_BACO,
+	AMD_RESET_METHOD_PCI,
 };
 
 struct amdgpu_video_codec_info {
@@ -1244,6 +1245,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job* job);
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
+int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
 
 void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 053e134b1245..b1957b5114e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -929,6 +929,18 @@ void amdgpu_device_pci_config_reset(struct amdgpu_device *adev)
 	pci_write_config_dword(adev->pdev, 0x7c, AMDGPU_ASIC_RESET_DATA);
 }
 
+/**
+ * amdgpu_device_pci_reset - reset the GPU using generic PCI means
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Resets the GPU using generic pci reset interfaces (FLR, SBR, etc.).
+ */
+int amdgpu_device_pci_reset(struct amdgpu_device *adev)
+{
+	return pci_reset_function(adev->pdev);
+}
+
 /*
  * GPU doorbell aperture helpers function.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e5c2377a54f8..b1de139e883b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -791,9 +791,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
 
 /**
  * DOC: reset_method (int)
- * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
+ * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco, 5 = pci)
  */
-MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
+MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco, 5 = pci)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
 /**
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
