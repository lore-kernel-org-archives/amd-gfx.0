Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31EFC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90BF21501
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHZcoFtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90BF21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799076E287;
	Mon,  1 Jun 2020 18:03:37 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920736E27C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:36 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id i68so8438585qtb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KkQUSzwJecR7AXBftG7WDc/wmDexUeW2DLTuXi9iXVQ=;
 b=aHZcoFtcgbw1EgOllxhSotINQ9LhetHrCRW8lp5L35D2EpaKjmh/37lxre3kaUOQLE
 z0ItItjxcbpkl5/5jW6LkYuB/5Yv01HK2i5/16LxwzTEHo3nZnVRU46KGq/bIZ6G/lRc
 Fsc07H3v9LS1VfqqiovPsE3548MHl0iRyeOR8eaiu/c77vKu6s93LzggeT0UFGOiODIb
 kEoTHZGletcOpnHsnuV1KEoBxMHl/wm68Ew3i3Z7Ejn4vVM6d/Y6ojkjm31W455wzrC2
 b1/Qgb3jcfLVQhBFJMYp2BsBMrGU+b/8NoBDLvLCGGpKw/BcDSGjCgnIChNiUoGTRfEj
 vX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KkQUSzwJecR7AXBftG7WDc/wmDexUeW2DLTuXi9iXVQ=;
 b=nnGnHL21LWKrqVGKh6+QRil2D6xMJyHozedevQC/VyHunzvy80nBJ6CZLNr2se4zfn
 BUr3U49swOSD+RENdY7BDRiGRqKKfyYSttzHVh0RM4VSdQxOCI7TW1JfmWfPcQmvqKNM
 BM5ZdF9IC/+WEsx6Ni8Ol2R5jAV2VhU4FYv/OlYuVsku130xevPUwQpX5x3Tdqlsjd0+
 JV1OHkFjis5V/DJHQjU+PlbJACrPa7VzPgLKmw3altm+YcjW2iqmawI8Xf0DEO4ain0K
 ieCpA4CZBNPHAfzi+iLZ9SI5QHvY+bvrMIbwM0zNOmCNOa4wyMRNVSpbCgzNSfcw5xUM
 1lUA==
X-Gm-Message-State: AOAM531e2uiVTX9oqoULAxptXH5rDFx5a3H/Edkwvi0SSbpnxmqo2n2b
 G+5kRrHNGtP7sPj5aSi0AM8oUpxM
X-Google-Smtp-Source: ABdhPJx5W5BoBCU8Z/AdYP0no7baDuAWmykeXyv/R/osDAjW3ml3sEpyr6to3mvA5bwJykqOQ5ozUw==
X-Received: by 2002:ac8:754f:: with SMTP id b15mr22361326qtr.375.1591034615576; 
 Mon, 01 Jun 2020 11:03:35 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:35 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 033/207] drm/amdgpu/powerplay: set UCLK DPM for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:45 -0400
Message-Id: <20200601180239.1267430-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable uclk dpm for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index a96de546c19b..75c31597a478 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -43,6 +43,7 @@
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
 	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
+	FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	 | \
 	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)     | \
 	FEATURE_MASK(FEATURE_DPM_FCLK_BIT))
 
@@ -277,6 +278,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
 
+	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
+
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
