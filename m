Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4F0C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B182083B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQHgJU4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B182083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65726EA2E;
	Thu,  7 May 2020 16:08:21 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3ADA6EA2E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 16:08:19 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id 59so2890477qva.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0uQg9IKweBBv7pvCLxRGSh8qmc8dAuF9FwYjtxpz8DQ=;
 b=ZQHgJU4c4LLD/gVpX5hKG4DM/FTN6LtwNFwbLmrZdSHpfC2r55kDwDub9RI8LMisIc
 aEDj6ElN/L6gIndDviQHhZADdOhGyl6sq7E3o+oIduvfCteDS881jRiCtcerrIDRhQSH
 TQsiYmCxUpa79xXiGL4PDBqCFLkIeK4TEjo2DgxF7QfxhOqscVGwaB/ULyYJ79P4mMV9
 QXqzW3qZ0p9NIbnlwiF9paQY8MWjlyZ8gLnjwPcMc733zKYAwR8tgWvnCzTGOjxMQTe7
 xbzNMoq47DD/XfNDjjQ8AZDHJg0OKvDsXfGGOTzZrQBeKrSLH0cnRVGm2i1iCEKF2a+g
 rLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0uQg9IKweBBv7pvCLxRGSh8qmc8dAuF9FwYjtxpz8DQ=;
 b=jycsFpmvirzEsG8Nu02ocKW62UvV3E5inJnxFUyqJ5bY6U6YdGEhU9VJaWgfPWwTNP
 v2auaFB2LXJ3PTf7wRAM4ElJqBa3BRGPXMoQ+NaNzE43J2dRoJlyI38i4w+Bp/fZdsVR
 DvnErqZnUjFbkRxYvgr1z08YrzUpdvEN4UO7tGHpbl67+Sg5+yEzw/NRxwcOcRSU6hqv
 Ga9Kl1caiDnrQX4Th5CpeVPq/J1Jo2GWfM3Djpvg+dvt4giC4AetOgzhcHZov+0qba8X
 F6DcBKL9RB8qrAFh31K8qwED/Wqq87mfEORv7FG9yD7sRdSNriTV4V6igPiPqLWqAUMB
 wrew==
X-Gm-Message-State: AGi0PuaZRUoBowmixtPu494bFIJAH0INrqxkZuSON32dR2sFOnXZRcdl
 IfEog4wkiH2BP2aFg3HWdqZSj8Re
X-Google-Smtp-Source: APiQypIUy0HIfUGipk8JvyAmSRhWMQPx8+OS7MuroR6kc7cXhJTZ2bV43PoKO2xp2WqLWzFaDt7KhQ==
X-Received: by 2002:a05:6214:192d:: with SMTP id
 es13mr2533584qvb.248.1588867698796; 
 Thu, 07 May 2020 09:08:18 -0700 (PDT)
Received: from localhost.localdomain ([71.219.37.167])
 by smtp.gmail.com with ESMTPSA id d6sm3186567qkj.72.2020.05.07.09.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 09:08:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: only set DPM_FLAG_NEVER_SKIP for legacy ATPX
 BOCO
Date: Thu,  7 May 2020 12:08:08 -0400
Message-Id: <20200507160808.4250-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200507160808.4250-1-alexander.deucher@amd.com>
References: <20200507160808.4250-1-alexander.deucher@amd.com>
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

We only need to set DPM_FLAG_NEVER_SKIP for the legacy ATPX
BOCO case.  D3cold and BACO work as expected.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 233d6c8c4ca3..4e4c9550dcf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -188,7 +188,10 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 		dev_dbg(&dev->pdev->dev, "Error during ACPI methods call\n");
 
 	if (adev->runpm) {
-		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
+		/* only need to skip on ATPX */
+		if (amdgpu_device_supports_boco(dev) &&
+		    !amdgpu_is_atpx_hybrid())
+			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_allow(dev->dev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
