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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9130C433E6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6FD64E3F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6FD64E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC4F89F07;
	Thu,  4 Feb 2021 18:47:17 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D3A89F07
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 18:47:16 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id l27so4338275qki.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 10:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EBv9ys5W2Q2ZjEwPhiOrnAgmdHc5A1JT8Zr6+0xXPH0=;
 b=TBBhfbD+rUxwHDjevvxVnZLOijZEWQ1eN99gyi4xatAQVQbfl48FWiGd8z6eUugegK
 hsG36Pamnq/G7cdNXLW1wlK2zCwDZSY2JjVgM35bRyqxdMPJavAsoxd4rtOyyW9PDTth
 Je0C/NXczOJBcMjg8cgWdNS0/yLct4VpyQa3wNAK2Ur6Uj/VD7saeXcHC1QLjQk5YNS6
 wUROY/dXrVtbErA5Vnu8TiCYxgrm1NN1eVAS/C2Q/JzGU5iHIGQDvTP7CGL3e+WyF3ig
 j85bboLa+huPZM1HIEyyuBzCTYW8xOyb52ObuuU5kY1GPG3ZAyiQ3icrgFHEt2Se5sb9
 Csng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBv9ys5W2Q2ZjEwPhiOrnAgmdHc5A1JT8Zr6+0xXPH0=;
 b=tVi1iosxVF41gSdB/q053rBkMbqyilTVVTT36zPhR/p+VqzE20jQs+QBQJWUywiCQV
 6i78JBGEq88iHZ9DaxHhCr0Sxo2DvrcJqcNMuilBFyc8x7n5Xm9JRjK5q9V9fx/TOPkA
 j5XNbKS4jS7MrKR2LHMqq84GTGJ25FaXg5h0DNhDeFdtzjEvfXf6ZwHrH3kBAli5+8AE
 O1NnyRYNEtug8TmNpmSj9LYfygCekrETWqBJ0BiRWJFP0hVToiPKFLaWou49hg3bxjAF
 sUomfZCIk0AxnpyvdhC0QCoJUdR8/ky9R0iOfrhJt1vas3+7QDcicBhTzNiRNRF3naaS
 Hg0g==
X-Gm-Message-State: AOAM532Y2avSLdF7uP3saBrfT/uWUK4AQT+rfk4hLl3dMCLp3R44X1i9
 mlWM+gpD0wjrae5jV+xQPBFWxTiuEIU=
X-Google-Smtp-Source: ABdhPJxK7sEX6+JLXNSzLj5BkPfHAyiNVCi4549jprAzldmS00GIHkocdbhalR8794Rxi0rnUNB2Rw==
X-Received: by 2002:a05:620a:64d:: with SMTP id
 a13mr515618qka.383.1612464435502; 
 Thu, 04 Feb 2021 10:47:15 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id j188sm5833644qke.67.2021.02.04.10.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 10:47:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amdgpu/cik: minor clean up of reset code
Date: Thu,  4 Feb 2021 13:47:01 -0500
Message-Id: <20210204184706.168934-2-alexander.deucher@amd.com>
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

Drop duplicate reset method logging, whitespace changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 33 +++++++++++---------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 6ee2c0e3ea50..c0fcc41ee574 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1327,13 +1327,22 @@ static void kv_restore_regs_for_reset(struct amdgpu_device *adev,
 	WREG32(mmGMCON_RENG_EXECUTE, save->gmcon_reng_execute);
 }
 
-static int cik_gpu_pci_config_reset(struct amdgpu_device *adev)
+/**
+ * cik_asic_pci_config_reset - soft reset GPU
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Use PCI Config method to reset the GPU.
+ *
+ * Returns 0 for success.
+ */
+static int cik_asic_pci_config_reset(struct amdgpu_device *adev)
 {
 	struct kv_reset_save_regs kv_save = { 0 };
 	u32 i;
 	int r = -EINVAL;
 
-	dev_info(adev->dev, "GPU pci config reset\n");
+	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
 	if (adev->flags & AMD_IS_APU)
 		kv_save_regs_for_reset(adev, &kv_save);
@@ -1361,26 +1370,6 @@ static int cik_gpu_pci_config_reset(struct amdgpu_device *adev)
 	if (adev->flags & AMD_IS_APU)
 		kv_restore_regs_for_reset(adev, &kv_save);
 
-	return r;
-}
-
-/**
- * cik_asic_pci_config_reset - soft reset GPU
- *
- * @adev: amdgpu_device pointer
- *
- * Use PCI Config method to reset the GPU.
- *
- * Returns 0 for success.
- */
-static int cik_asic_pci_config_reset(struct amdgpu_device *adev)
-{
-	int r;
-
-	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
-
-	r = cik_gpu_pci_config_reset(adev);
-
 	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
 
 	return r;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
