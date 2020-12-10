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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E730BC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1EE223DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EE223DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D346C6EB74;
	Thu, 10 Dec 2020 21:45:42 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4536EB74
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 21:45:42 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id l14so3233996qvh.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 13:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GzY2E6p/B+PgOaBvnRwx3vE2JgoCIUoSDhWwIqLXn7c=;
 b=iCYeAS0qR7d+hL2DeI2FRKIZO48EwLSPTiFwkC7Mavl/KxhMuKMmeg/aeNrJ0zdbPv
 EZBxeFAxLsGhaWNjCwb/fhXei715ny4Xuq2aolQcGj532uINlcHjm7yxdo0LczMIT5Rh
 0Hhe8iHi6UgNEfxm1m/R9aI/6vRHP0Cw4nCDBFjLVLKT8nPUp5Sfmzmbd3l5hw0gGrml
 3xc+D0cV4v/8B9X7ACkH2zYxY7a7/hNofD298m3A1w63zrXxbmn58Ebb3WuQy1fK+JJS
 mlVTk1/J1UiIoS7F4NRbR9IASg7lIJsxDAFz0zTz2IEpgeQ1yaLg0Bg8134JweNkliVz
 Hcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GzY2E6p/B+PgOaBvnRwx3vE2JgoCIUoSDhWwIqLXn7c=;
 b=eOVZT7OvvARyr1V0AOHn9HHMy0iafX9HsWqiehJm8Sa/vNOraDcHHxr2VqLpqax2dd
 I/JYJETLZTqTiEI0qUmIUg1fygbJLUe5dx73/WKKDaUS1CStW2Kw9CRc0z/lCnHLfLKb
 NZo+BzDnhYbMtFMw2VqwCZ94moDotZilA5nI7s5oJ6gECav2oTaMAeCebM15xgYI2L2X
 nj3aFM4T3jzRHnGBHC/lYLPCIjfq+kyQcctEyfBRqCTVWpSAeW3HQcMpOWWwPSe5obFb
 3jCFuhF91WWVI5Hcy0ZtnbUKrQOQykbDJZ2l5I2Kqbk9AItLICXrRM0yjLvbjunKE3Og
 6Nlw==
X-Gm-Message-State: AOAM532AIBemgvhZ1F9UgCtpVFqqdBS+OFxmJOr3ha+Bury5TqzyMzG1
 +Op4iwxV374+LEGOLXR09pwL1IAfHzA=
X-Google-Smtp-Source: ABdhPJzI2+93hAM4CsI65V5eeKX/TU7x9FBag5bcu8vt8NqL/8PcoDA0I4iCGnNqCuvbtrrcamFKNg==
X-Received: by 2002:a0c:b415:: with SMTP id u21mr11607006qve.0.1607636741110; 
 Thu, 10 Dec 2020 13:45:41 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y9sm4776989qtm.96.2020.12.10.13.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 13:45:40 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amdgpu: print what method we are using for runtime pm
Date: Thu, 10 Dec 2020 16:45:18 -0500
Message-Id: <20201210214518.704305-7-alexander.deucher@amd.com>
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

So we know when it's enabled and what method we are using.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index af049041ea3f..b16b32797624 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -163,9 +163,11 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	if (amdgpu_device_supports_atpx(dev) &&
 	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
 		adev->runpm = true;
+		dev_info(adev->dev, "Using ATPX for runtime pm\n");
 	} else if (amdgpu_device_supports_boco(dev) &&
 		   (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
 		adev->runpm = true;
+		dev_info(adev->dev, "Using BOCO for runtime pm\n");
 	} else if (amdgpu_device_supports_baco(dev) &&
 		   (amdgpu_runtime_pm != 0)) {
 		switch (adev->asic_type) {
@@ -187,6 +189,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 			adev->runpm = true;
 			break;
 		}
+		if (adev->runpm)
+			dev_info(adev->dev, "Using BACO for runtime pm\n");
 	}
 
 	/* Call ACPI methods: require modeset init
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
