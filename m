Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDA6C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 19:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E6120702
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvIwp30b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E6120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B77086E426;
	Wed, 24 Jun 2020 19:05:40 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0006E426
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 19:05:38 +0000 (UTC)
Received: by mail-pf1-x443.google.com with SMTP id h185so1598514pfg.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c4B2fKTdEQqw24OG5iy5WHw4s1OgDRRBw1JghG1FSN8=;
 b=lvIwp30bhmUHIl2/SfRMuy+ooqGVWH3RQb2uq2O4rXic9+wuEu2kd+0FH+e2dONk1H
 8qJAncFWyZXvy94iBkEjbOfq1MQXEE4lexdLSOgFxGC3VC+FDnOj16F/7jR4C5FGmeUr
 i9iG0r/m6gp/swvNb+MUEOQFJg33QAgWEtwviTSsDAbadBqvAHIRIe2EBvBZUD4nxRrw
 +jwI2BB4F/2TRM0JgHod5iFH10DLM8VMHDxQOnS85H4JFEAZCCAGCmk9I0h56dYeinzt
 Bkfvrm4e0Qd7qtzknR5VCT1tKTklD13rqsWP4OPFKt88gP8iaCkrXuo0FGn6z8ksaIr4
 iluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c4B2fKTdEQqw24OG5iy5WHw4s1OgDRRBw1JghG1FSN8=;
 b=fuj09Ojd6RrOhvd59llD738dGaHEkC815RAEA0aKYSM8X3lEdnQxidkkCKdu3giSgx
 gBrgIhexoA1L1t2BXh9hApOxDrSYc5TfNx848VoX/ttzKcp+DRPHnLcw5rEirwyeqhAj
 sc4WZgpEpJr38sub5QqsMDtKZLVEVWFHzadGWb3EIJu0jy2KeykqPpPbJlTIr2iQUiZf
 ux8tj/JwJ1fbqTcKkSlLmfiv+DvJTF+fr6GENSPOtEHzAIlfhv+PnvRzqGW1MPn30LZa
 ExYVu4CqwZgAPWlIBx3zRTaOyL7UeC4cYmYg1tY7/QIoztAehL3h87xoL78hncu9fmLx
 oBHw==
X-Gm-Message-State: AOAM531VVa7/aSJh2Ezk0SH/xfKl1XtTgK4SktnCQ9W/G91rgGDFAE4b
 a4AzuXLStK9tYeJ1n4X/Ar5wCqG2
X-Google-Smtp-Source: ABdhPJy1QU4+m4nu3ied7RjRnkdYUJiLY5TMLzLeTSFJBzbiMdd/7NJ/jIaDbje+Hz0Tz7k/OEHPqA==
X-Received: by 2002:aa7:952a:: with SMTP id c10mr32428326pfp.252.1593025537822; 
 Wed, 24 Jun 2020 12:05:37 -0700 (PDT)
Received: from localhost.localdomain ([71.219.51.205])
 by smtp.gmail.com with ESMTPSA id v9sm20662377pfe.198.2020.06.24.12.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 12:05:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: enable runtime pm on vega10 when noretry=0
Date: Wed, 24 Jun 2020 15:05:19 -0400
Message-Id: <20200624190519.2378793-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200624190519.2378793-1-alexander.deucher@amd.com>
References: <20200624190519.2378793-1-alexander.deucher@amd.com>
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

The failures with ROCm only happen with noretry=1, so
enable runtime pm when noretry=0 (the current default).

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0fec39eed164..341d072edd95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -176,7 +176,6 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 		case CHIP_BONAIRE:
 		case CHIP_HAWAII:
 #endif
-		case CHIP_VEGA10:
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
 		case CHIP_SIENNA_CICHLID:
@@ -184,6 +183,11 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 			if (amdgpu_runtime_pm > 0)
 				adev->runpm = true;
 			break;
+		case CHIP_VEGA10:
+			/* turn runpm on if noretry=0 */
+			if (!amdgpu_noretry)
+				adev->runpm = true;
+			break;
 		default:
 			/* enable runpm on VI+ */
 			adev->runpm = true;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
