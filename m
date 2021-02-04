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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083CEC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77A964E3F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77A964E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BAC6EE19;
	Thu,  4 Feb 2021 18:47:19 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0663989F55
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 18:47:19 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id l14so2228193qvp.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GVR21d61Wyd732ar7PbASShYNL5wc7RxJ73yhaJfXZA=;
 b=EbhNOTzSOqM5sI3vuSlgJavfnNVZ3JM8mEsAtgilVeY1twXJc99eob234KOWNF72fn
 BCnZ9BJRtTCK2OIUHd9h/fCQX0jprOp3/pTmuv2QqjPgD+L2SPzlcWGRnG8KvRLsnQ+m
 Xl97ofJwaFJup1ZMEYl1CjEg9FMbwycaQhLeZB/JjNrmoAcVX9c8LI7/W+qYnmKpwrnW
 aJAA+Rlu6nr1MSfscyVdD8ejdzdAKApgbD/mAw+uQrQN9cMZ/132LOURVYvcx1InGF52
 h9uw9uo6R/ZxpeHNh+cAsoEez3qEctW3sJ5gYdIxCREe05SkVbASzy1bRNhkj0a0jyiI
 QzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GVR21d61Wyd732ar7PbASShYNL5wc7RxJ73yhaJfXZA=;
 b=e5P44BCNLbxWWuOSdEX8efinNlHk16Gdf7Cw2XH8FfMbw1pQxrL32EDeDPZBJ2iwpi
 7HFlmPwgjtGbaO7t6hHDor0RJFzGQZS8nCF6B8oofUq3SXUihFKjAE+IARjzwn2WrKOY
 uyAhu5Ic5IGTTf9qwBcg+fu9Cw5o+slFYOK0b7UMAvdI7pKrci0Tj1AhAtPWA+/T/AGn
 mmbzQPDZt5bFp7YvFCPJR3kM6acgyfXdelmZmlLfdXTeI/FJirnVbCImVGkyP3jsOIr6
 1ygsa3O3W1hWU7d1k/lUrnMv/Zmvxd7/daK1ptI+8MhKcSHIBmwMyp3v2eLSitt2n6pi
 4y+Q==
X-Gm-Message-State: AOAM5332OWz2NCkCyUIcClVXgXucpMl88jtjoiUD6rt6fsCREEosjSf0
 HJIfyHrnAHRuWElVXkjItkehXrNIAWM=
X-Google-Smtp-Source: ABdhPJxREIto6YCwteaW7zWIfv7C6qh2J6733zHnx3EQcgQWQTQqT33MG6fWeI/F7n/sJycHu/RkSA==
X-Received: by 2002:a05:6214:b2c:: with SMTP id
 w12mr604336qvj.54.1612464438011; 
 Thu, 04 Feb 2021 10:47:18 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id j188sm5833644qke.67.2021.02.04.10.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 10:47:17 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu/si: add PCI reset support
Date: Thu,  4 Feb 2021 13:47:04 -0500
Message-Id: <20210204184706.168934-5-alexander.deucher@amd.com>
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

Use generic PCI reset for GPU reset if the user specifies
PCI reset as the reset mechanism.  This should in general
only be used for validation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 37 ++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 668dd6dfe6a3..7cbc2bb03bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1409,17 +1409,6 @@ static int si_gpu_pci_config_reset(struct amdgpu_device *adev)
 	return r;
 }
 
-static int si_asic_reset(struct amdgpu_device *adev)
-{
-	int r;
-
-	dev_info(adev->dev, "PCI CONFIG reset\n");
-
-	r = si_gpu_pci_config_reset(adev);
-
-	return r;
-}
-
 static bool si_asic_supports_baco(struct amdgpu_device *adev)
 {
 	return false;
@@ -1428,14 +1417,34 @@ static bool si_asic_supports_baco(struct amdgpu_device *adev)
 static enum amd_reset_method
 si_asic_reset_method(struct amdgpu_device *adev)
 {
-	if (amdgpu_reset_method != AMD_RESET_METHOD_LEGACY &&
-	    amdgpu_reset_method != -1)
+	if (amdgpu_reset_method == AMD_RESET_METHOD_PCI)
+		return amdgpu_reset_method;
+	else if (amdgpu_reset_method != AMD_RESET_METHOD_LEGACY &&
+		 amdgpu_reset_method != -1)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
-				  amdgpu_reset_method);
+			 amdgpu_reset_method);
 
 	return AMD_RESET_METHOD_LEGACY;
 }
 
+static int si_asic_reset(struct amdgpu_device *adev)
+{
+	int r;
+
+	switch (si_asic_reset_method(adev)) {
+	case AMD_RESET_METHOD_PCI:
+		dev_info(adev->dev, "PCI reset\n");
+		r = amdgpu_device_pci_reset(adev);
+		break;
+	default:
+		dev_info(adev->dev, "PCI CONFIG reset\n");
+		r = si_gpu_pci_config_reset(adev);
+		break;
+	}
+
+	return r;
+}
+
 static u32 si_get_config_memsize(struct amdgpu_device *adev)
 {
 	return RREG32(mmCONFIG_MEMSIZE);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
