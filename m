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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289ECC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028AD2077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f27YRB/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028AD2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04CA6E261;
	Mon,  1 Jun 2020 18:03:30 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E006E26C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:29 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id j32so8405555qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MfcDTUxVs6FWuzY6EfjyC+ILR/T2NneMQjcqHtL18HI=;
 b=f27YRB/hQhW98+PkBr5oHsdkNhzcjVbTu4hB/9RDi9CjUWJnk0Dbqzf6XMy/CGRIWA
 EV9WnUGaNiLitbwWDWq/N4goOgrq31z8UXRKXd3VpywckZ0x6iLp3UdlOLt1UaGC2Lzj
 LJqVqf0peqzK+TTlHkFIMlljvnyzFpv7OiZMecn1Tai27BSJ20lkvCafWfpUQQzmoxgk
 wtI+94aL4KQZ1yqI2wX3B9Fp4Qn6A9WSBmb7kF6XCJoZPPQYP6e36pvhOzDj00Cu/y/n
 GT/GZE3G33uO12b689zR+jiL/hgMLbw5pxUdfXUywdIc71L8R0/COgZb2N9HdME5S4vR
 B6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MfcDTUxVs6FWuzY6EfjyC+ILR/T2NneMQjcqHtL18HI=;
 b=QGilYey5/3DsBecPU7QUHLV2xNG+KIofotKqrvz7i8w8ijAMittv4CS6UYFlEGGXtQ
 EwgCQ39nsJWqMJOgW8qTrOPnhmeFczCjrtFOyp2NQT2D3orNaUjRdOlJdh8yyi4iuRt5
 et62lbfY4VnpfLZcAU9h9sthCKC6dPut82Lyc6fcQZpNTftTHubDl89zUE+gF02jljh7
 /U6EIu4nsZTN8c5CZz8Dl6m5myXqNgVaGm4aMNNafqHiZF8RCiQxi9HUkLs/PPtPqbef
 jVjg5SfYvk6kFiVCZrovE1T2hXSQa8FXaQpLHhlOqVdkknHRbbRAzOJqlGS2A6Ozs+Y1
 99wA==
X-Gm-Message-State: AOAM532WShj3ABBBIMTj+6BvKWKXmecTHikDa27nijtD6qBoHUlmKrA5
 mIX3MyjTIhMh9yZm1gJSy1hBmY29
X-Google-Smtp-Source: ABdhPJxRBXtnIE5GeYZL/ypxMF4FBlqHNy3z7dJ+55jub4cSrbhqLNJrzLcA6udQT4CmTck8y8MOiw==
X-Received: by 2002:ac8:6bc6:: with SMTP id b6mr23405190qtt.101.1591034608385; 
 Mon, 01 Jun 2020 11:03:28 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:27 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 027/207] drm/amd/powerplay: set SOCCLK DPM for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:39 -0400
Message-Id: <20200601180239.1267430-24-alexander.deucher@amd.com>
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

Support for SOCCLK DPM for sienna_cichlid.
Use feature mask to control DPM for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 4aa174117af3..4a60b688d3c3 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -42,7 +42,8 @@
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
-	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT))
+	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
+	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT))
 
 #define MSG_MAP(msg, index) \
 	[SMU_MSG_##msg] = {1, (index)}
@@ -259,13 +260,20 @@ static int
 sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	if (num > 2)
 		return -EINVAL;
 
 	memset(feature_mask, 0, sizeof(uint32_t) * num);
 
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
-				| FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT);
+
+	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
+
+	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
 
 	return 0;
 }
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
