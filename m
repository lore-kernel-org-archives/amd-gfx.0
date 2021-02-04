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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07ABC433E9
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B02564DD6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B02564DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3DE6EE21;
	Thu,  4 Feb 2021 18:47:23 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF3189F55
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 18:47:19 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id a1so2191289qvd.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lZwbJZeyzLrOgTgiYRox70ItrZURhKdHO2FuTS7Zpxw=;
 b=iZqMO6P/D/Pc7kshMvnp59kXQQk4uQi3ygODe0WRuosWfjGVdrzsq/sFk7f1nm8sHy
 qEF47l7EaCpKSexJP1LDOVtRlbaNIl3vNuDXLA4F8vVu/yrQP8JXenwLhD7XFezZCuCx
 ITTyXEZpdq4XF1k6mzG1/xZYcNDD8jxzIQECpdAi3ap1gWPhUki1Y5fq+R5IH9iJPMwu
 cpuzcwPP3Yl19xTmV9dDA3wQ/mgdsOf+GjbWWXbUW/HZ71Q2UFU+ijlL7uadWoiwio8G
 8kEVMvLamCjeXUl5KH6Uy01skCvOOgVVMKfjWXUYXwztUpMFkT7iAI9eKGsf5znOj7JY
 BUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lZwbJZeyzLrOgTgiYRox70ItrZURhKdHO2FuTS7Zpxw=;
 b=R6A4q/3M5rJxYdB6gpd2H+2TrEVvFNXP3u6J1scVqSKKWT2eHDrDyuwmw5ecxPChBB
 F3tTpI/a5oWFSdeMI+hJ4lmzs4LQGHAEnoSq2qhqAqmikjGghs0xrt+tmhb7ox4thmWu
 iT8ri4RUyOnsOjGZ5sKOnIuJlUg7GrUoZiPMUKvJueweijnymDHqGWxpQMOyIoJ4FELY
 +A01xhcrlzMr1Yl17dwD0ghHFo+6o+Jx6BT/7pxI3dgKL096JXQq7BYLkQKfzF1kEPig
 GphZw4lAVZRvk9rF9RiiOmmOGyqWf6D9gXTEqtmr00X6IIwgAh3kxODXNlyxcRA+hWSY
 LLSA==
X-Gm-Message-State: AOAM533z0HJvja2j5bf7X2wMUpL/Leep9iefxza49uRZF/VsbddOdmVl
 +4ahByYpNMchkvCnzdwEajctnUvwSHg=
X-Google-Smtp-Source: ABdhPJwkFxETipDgF/dERFgPCnnY+cAy3Fi4LJr/sZWf0fqlCPZsKs4AWVZ5dWGJaKHvS7+ad0mlQg==
X-Received: by 2002:ad4:40c5:: with SMTP id x5mr807942qvp.15.1612464438729;
 Thu, 04 Feb 2021 10:47:18 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id j188sm5833644qke.67.2021.02.04.10.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 10:47:18 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu/soc15: add PCI reset support
Date: Thu,  4 Feb 2021 13:47:05 -0500
Message-Id: <20210204184706.168934-6-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/soc15.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 5ef2e2707754..c7d0e0e98391 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -709,7 +709,8 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 
 	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
-		amdgpu_reset_method == AMD_RESET_METHOD_BACO)
+	    amdgpu_reset_method == AMD_RESET_METHOD_BACO ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_PCI)
 		return amdgpu_reset_method;
 
 	if (amdgpu_reset_method != -1)
@@ -754,15 +755,18 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 		return 0;
 
 	switch (soc15_asic_reset_method(adev)) {
-		case AMD_RESET_METHOD_BACO:
-			dev_info(adev->dev, "BACO reset\n");
-			return soc15_asic_baco_reset(adev);
-		case AMD_RESET_METHOD_MODE2:
-			dev_info(adev->dev, "MODE2 reset\n");
-			return amdgpu_dpm_mode2_reset(adev);
-		default:
-			dev_info(adev->dev, "MODE1 reset\n");
-			return soc15_asic_mode1_reset(adev);
+	case AMD_RESET_METHOD_PCI:
+		dev_info(adev->dev, "PCI reset\n");
+		return amdgpu_device_pci_reset(adev);
+	case AMD_RESET_METHOD_BACO:
+		dev_info(adev->dev, "BACO reset\n");
+		return soc15_asic_baco_reset(adev);
+	case AMD_RESET_METHOD_MODE2:
+		dev_info(adev->dev, "MODE2 reset\n");
+		return amdgpu_dpm_mode2_reset(adev);
+	default:
+		dev_info(adev->dev, "MODE1 reset\n");
+		return soc15_asic_mode1_reset(adev);
 	}
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
