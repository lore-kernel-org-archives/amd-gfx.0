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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2F1C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D86164F42
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D86164F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295016ED9A;
	Thu,  4 Feb 2021 14:43:55 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851536ED9A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 14:43:53 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id v3so2512062qtw.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 06:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YWJHwVpnJVRsMd8IXhHR5vRQAi8Jzs5bhvOM79XPe8E=;
 b=e/RkJi54evFzN9NRdVpsOEz3UALoB3/TDZYEkD/lCJoa9pGTa0hlZ97WKnGnB0UzZF
 AXeRKIixLbFhCNVk9VQ6w0yU+nfW18pvWs1zOVdoLKtRNeouCpWmpI2hXNBp9ImsDuJv
 eJe2m/D6uqH31EjODeht8EHH9feKbC+Zluh0+g2fq5vDWylcGIjsywKd4GP7fJiaJkFh
 rPomaV8eQb+T6SH0mya4JJ/Q6NP1OzWEXxHWMuQAzeXcMfNTFG9AEvfrJP53VCMecxrd
 WMH945HZgT2qBPN8xq6kSNbbvCWbOuzfKZeYWKY5kXN+/AgcmGXf4lrYTna74Qg26NAT
 iiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YWJHwVpnJVRsMd8IXhHR5vRQAi8Jzs5bhvOM79XPe8E=;
 b=RCn8vdZ5V6oo8uk7CuUrbL3PEgyvWyCB5YKaZ1Vi1EJzaW0U+PI26pZmGkAkYbXeEA
 EE2s9f+OusBn35ZsQ+mpY0gtnqDju0LYbecwPGxCkUetXsIi1u81mmWNIKOxJ8YSlK+h
 fy3JNQQ7cFpd/fvYDCXXraL6c3uy1UKcLWNUUXbhu3xfnmc8aq6qqIwRdosx+1XV+Fhy
 tkwe3AH5ut8ArG8z6eDpTmP6VByc/Rus9fdZlJzfha8apRnWqQ4mGizZmlN3nzioAwsr
 ZvIwKyvTHRa/94x19IXmHriXfAoSE6vA274ZfzaFG2+RXwu9b0y0miJtixTDG1hjQcUO
 g+JQ==
X-Gm-Message-State: AOAM530M1ZLPt2Mv3y8cBLBedL6m+53+S/SdD8xG4DB2MKFuUBrPodJo
 QP7Rmfvtz0MGNE7/KBQcnQxWpAl9e0g=
X-Google-Smtp-Source: ABdhPJxTx0gAdbYpYx7H7TnROED6HmZgD5KyMnc0FHKuwGCj/4I62OJmPlKhicZumAuKlmQgf3LAcA==
X-Received: by 2002:ac8:550a:: with SMTP id j10mr7286932qtq.193.1612449832577; 
 Thu, 04 Feb 2021 06:43:52 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id q18sm4735488qtr.74.2021.02.04.06.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 06:43:52 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: reset runpm flag if device suspend fails
Date: Thu,  4 Feb 2021 09:43:29 -0500
Message-Id: <20210204144329.52506-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204144329.52506-1-alexander.deucher@amd.com>
References: <20210204144329.52506-1-alexander.deucher@amd.com>
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

If device suspend fails when we attempt to runtime suspend,
reset the runpm flag.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c9821f1dc357..e5c2377a54f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1369,8 +1369,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 	ret = amdgpu_device_suspend(drm_dev, false);
-	if (ret)
+	if (ret) {
+		adev->in_runpm = false;
 		return ret;
+	}
 
 	if (amdgpu_device_supports_atpx(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
