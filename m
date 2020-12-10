Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DBDC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C50523DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C50523DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24666EB71;
	Thu, 10 Dec 2020 21:45:38 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F456EB6C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 21:45:37 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id bd6so3220896qvb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kgmqPb7ccl8GHqnVsmfAZPP9ktePnHechaUnV+DC0Sk=;
 b=cfI4gbbPNGPm3qKpxDhOCFyB92w/GfxJRsfuFDpb43kNBGxP+8f5U1T/+DHK72rFRD
 NrGLSg9EPzBnwpt1uNVyM2kcjqOQqYuQOJsg/v9iJtm9HW68g22CSIIOBJqxzbKuUdb7
 jeKW+5CZZdOwOH9FQo67m4BtsUTASivyp4+LO4PGPrD7I5mzGMccRKkw9no2SaO5NQsS
 87uFbZvtnNKfwRcAeVQ/Cm6O9bb92AlhSfETwX08oUfjsUPxfIZQrwKpvb/xtCOQThC5
 L1U+5fZHIEsAJ/Oy8oPGhT6jWKSEIwT+Ywc5R7YiGF73rzL9kl+iK0ZSfFCIg7J409j5
 5aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kgmqPb7ccl8GHqnVsmfAZPP9ktePnHechaUnV+DC0Sk=;
 b=c5pUF/X+7/J68UJZeesoTUqrnabOwyVuls1CPNqXmrHDUZ/wIabU5WBx02LK8VuAKV
 meASuK8b1/45V1SHFbAOUP/6Xpzw4wF7ItMB48RSw5rTBdFFm4ZKs8zmLJlK6WqTZVqw
 ml/nEtzlUmiWGVl9gUpSqiUiLpFlMGCQu/cmLIffCsaxBqv2/DCoqlGVb18lGMwbzkDi
 LC2NkcOxIwpaXUISYw0mVo3yYTt9wz259yKDmJr855r4HKqIm9q8TUhzXNM+VEsbEnmV
 +OASdjydQ7ZSaex4Qmw4OrMbMld/rNR3pcU/pFq6Kz7zpEHKfgxfGLv0Cxtay1izuvGD
 SNEA==
X-Gm-Message-State: AOAM532gjcTX9JpmOEgnpYKCBiQOdzdABkschguGH6IyPZnTGHwHdkHy
 xgEv4D8upxdV2wNYnGPOeemYisjXJG8=
X-Google-Smtp-Source: ABdhPJyj8gO3aCvbuSGHxOs87DY4w5u71dyzySGFPDRWmvPa54ta8sCBY/Efqik9Qzgz6TE8ar6DdQ==
X-Received: by 2002:a05:6214:98d:: with SMTP id
 dt13mr7928959qvb.37.1607636736999; 
 Thu, 10 Dec 2020 13:45:36 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y9sm4776989qtm.96.2020.12.10.13.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 13:45:36 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amdgpu: add check for ACPI power resources
Date: Thu, 10 Dec 2020 16:45:13 -0500
Message-Id: <20201210214518.704305-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201210214518.704305-1-alexander.deucher@amd.com>
References: <20201210214518.704305-1-alexander.deucher@amd.com>
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

Check if the device has ACPI power resources so we can
enable runtime pm if so.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 38c029af60c7..c228e7470d51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1024,6 +1024,7 @@ struct amdgpu_device {
 	/* enable runtime pm on the device */
 	bool                            runpm;
 	bool                            in_runpm;
+	bool                            has_pr3;
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 38fb903338a4..ec8fff7839ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -133,6 +133,7 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 {
 	struct drm_device *dev;
+	struct pci_dev *parent;
 	int r, acpi_status;
 
 	dev = adev_to_drm(adev);
@@ -144,6 +145,9 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	    !pci_is_thunderbolt_attached(dev->pdev))
 		flags |= AMD_IS_PX;
 
+	parent = pci_upstream_bridge(adev->pdev);
+	adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+
 	/* amdgpu_device_init should report only fatal error
 	 * like memory allocation failure or iomapping failure,
 	 * or memory manager initialization failure, it must
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
