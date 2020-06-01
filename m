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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7816C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04C32073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXmcrs6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04C32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DCF6E33E;
	Mon,  1 Jun 2020 18:22:07 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043756E338
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:06 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id z9so467355qvi.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LnJEfJKJnwkjPnAkQScVa+m68af+3X6JXf9EvPPto+A=;
 b=dXmcrs6conW/qRMOpMwgmh4atFeV1O/MvXTl6OZcAWNxIlFNcLNwiQgDXr7r33f0yj
 ar7C0bUUBl7ka3xKac2fkHovCZheR+eX9Ae6lS8eNWuZsrg0cEg4DdrAlULQmrr6fAQE
 Wq6e9ReT3f7LTGMDmn7ZKewe4kXnkZJuWzAal5t1CO9XPq/mhxdTuZkgZL/KOLoRdjsM
 wfYHijGGPD9/BQh4osXqQuN5X51AGAMddXDuflV7yU4TWfTWvwWvUWBdGBCPhki5MDIY
 NJLxpVf7iKHTeRpVWLPqUXl3e4bat7j4M0PKVbWiiWacL/DgUCo2admpJhRa6OcXji+P
 n/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LnJEfJKJnwkjPnAkQScVa+m68af+3X6JXf9EvPPto+A=;
 b=nqPL1LeLAiyc63WW2V14T83jST3QWHvJ2RcOR4bM74ODAdz3zaHoVxBxrQWTtUfxl4
 DQWpH8U66+EwrKg5n4lkEVW1JCnFH8qqrxz1kA7e4RzAny6iYC8NEWSJYx1qvOg4zcHE
 GBT0//bjlS41aSCVZAgUFSAUlEEvjrR8WmHm7Khg+ZPRgX//ZLITgrkRKKOAM2Uwxoq1
 uHN4GD0Jvw5NE0uoqIGL449nRCojPc60zVCOv43waOWJEmOTcpd4YQfpWgYptUW9bgvJ
 M0aGfjGKrKVl/Cs9U59WKpgpncdC+uRFBc8B+ZmT4SpNuzerWozp6cCbxxqlwrRzg5k6
 JS7g==
X-Gm-Message-State: AOAM532/KbFET4oV2rxQbZaOu/GYG+GpBcYE0Pf5AOn9fIt7lQZXeS3U
 QUIzJfZwgaQ9Q7DvpA9zxOeaaqBj
X-Google-Smtp-Source: ABdhPJzFGdG0PDk1GhSoSP97cvATewht0JJat2r3VQHh6aauixjWJ6cPMmtuBpCT+tsght8V2DRUfA==
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr5639310qvo.136.1591035725006; 
 Mon, 01 Jun 2020 11:22:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 136/207] drm/amd/powerplay: bundle GPO with gfx DPM
Date: Mon,  1 Jun 2020 14:19:43 -0400
Message-Id: <20200601182054.1267858-47-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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

From: Kenneth Feng <kenneth.feng@amd.com>

Bundle GPO with gfx DPM and enable it since gfxclk dpm
should work first then GPO works.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 9dbf29e96312..45707772e755 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -312,8 +312,10 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_FAN_CONTROL_BIT)
 				| FEATURE_MASK(FEATURE_THERMAL_BIT);
 
-	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
+	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
+	}
 
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
