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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CCEC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7176020825
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II8roNOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7176020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7906E283;
	Mon,  1 Jun 2020 18:03:39 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78316E27F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:37 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c185so9945063qke.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o6WvT4iyqG9/vq2pdXN9/ZFz61VOnzwa6nQ7RIAV8y0=;
 b=II8roNOftHh00NrKMym1to5ru23AOD/iSogBNoaf1SSuHj20PNyenb8kVyO2Wcp7m2
 Csx5np80d+4a8QR7NQcbwh2raTEhaEARio0fefkHuFhMWIDTXIoIwHJejhJZ+mHtLxqL
 RdQdS/0EqRsga5KkNC/yGvArn0pNSpNc2uU1yXh+Yi5/0IgIk6r5f4QQ5er38wHTrNAP
 IipqC3JK8mpvcFiilnsu4BuXtHl7GWu9y/iYRHGSAW7YOAXzVuUSNDTdzZMC7jIlUJt+
 br3VDxFX8t9BGEjz/o1zjx3SPCBbaA7VOubSr8TBrWdxtGW6L62p1vhXzA9Fi4vrOz0C
 dong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o6WvT4iyqG9/vq2pdXN9/ZFz61VOnzwa6nQ7RIAV8y0=;
 b=sFsuqEus3DslkccDA82Wr1U0KZV1TRZ2x2o7ZygpYticxfjT9jss2YiASYksP5BJMF
 Q8gKthKScT8ePBtQhR0oa1oyxJaJUTUvGtSzTaJ3+4ia6aCIYUC/+lHUCHDGGrm0Lqwe
 qnoX3baLwyISgqkAJoV0MGuhCiYAn/NRwKDx7oZD0iyoMk0i8gwPfl9q9SxfAt398HrM
 zXy+/xxH6t8PlRQkAwWh43k502fdjld4yJ3cr84aG6yu/Oa9tRBCAA+CDrQPvseIgMNU
 nDtCkH8qulnEuKbLuv3OTGdAJYTdSTBgvPC2LIpt8fvH8vLJn0TnLYB8OVQEnwOdwgF3
 MsHw==
X-Gm-Message-State: AOAM530pewgcYgxd9KMGYMAqdwaotX29YmrAAPN1fbIeb/tbFZOSxCY3
 81r+xBl77hpVWQzlFvx6rydIw9L3
X-Google-Smtp-Source: ABdhPJy38yvJjbTvyk+ew/vbPLqcstbYqQXpRCnBBC+unGSRzvT8dFenHzYXHSXijUbcVMqrYx8mlw==
X-Received: by 2002:a37:5283:: with SMTP id g125mr2689707qkb.157.1591034616719; 
 Mon, 01 Jun 2020 11:03:36 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 034/207] drm/amd/powerplay: make gfx ds can be configure for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:46 -0400
Message-Id: <20200601180239.1267430-31-alexander.deucher@amd.com>
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

Make GFX deep sleep can be configure for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 75c31597a478..49e157f2b39f 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -271,7 +271,6 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
 				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT)
-				| FEATURE_MASK(FEATURE_DS_GFXCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
 				| FEATURE_MASK(FEATURE_THERMAL_BIT);
 
@@ -287,6 +286,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_ULV_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
 
+	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
