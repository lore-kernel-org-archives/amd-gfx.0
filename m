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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49865C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BD22073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maS7d2o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BD22073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD816E35D;
	Mon,  1 Jun 2020 18:22:33 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B686E357
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:32 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id g18so8452609qtu.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ooTmEIOLCn6ykc7KkzQlvOiog1LLVRRbNISBj+x/Khw=;
 b=maS7d2o2NU0xgPJMvySR44YZjuKVLScYUUl6ZJ3h2D8ERLhmzDaU3nH30JnmNkz2xo
 u1fJaDHK8T8FFKq4+gYvZcNn+eHKyNPF7tP3ekSyn0X/lwBYPaMDwp25DdXpYDqZWIrg
 oEcgOi6cIyIgCC70gZbzg7TUBrojZ4J1JuopRRvBvmETFuD53nlHvbCvWhEZ3XZnSPaH
 rYBGQB0/cOgl1ufoBmFVgd7cBjYcCT+t+8tCDdkmEml90lJp0WZnA/bQa8tPU1m/KcL/
 1V9ZCS5vM3zoV/vrZmN7Yi6tazr3QHn0aV9WI7W4sJyyNZ8s2TyjoL+BBQlvJnBq1mjX
 ksbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ooTmEIOLCn6ykc7KkzQlvOiog1LLVRRbNISBj+x/Khw=;
 b=sQTT2Gb2juQzdzdewkRd21PH34hSHYGBMnK7RuBvNNfLDcQnomrmrXiTZqa6MKwwqv
 TRGya2CtQbr+lYxT53peVNBru/UumtIMB6z5TZ3rKOtAf35WMBRr8qkF1FVb3WEVwDpo
 w5WmIUz0CDNd/a8PRGp7uxfjb3iURXGA0TOcRZS9Hxh8mqc7iSn1vyDo0XRxBp9T4hjZ
 UTUNnbap8zeMtDVeNi7/liKhzSTtgujEk6aBISNJxSgOLX734cWwU1EeDpQfR+eJ4ydf
 Svv7tNhJGScAaMFIeBgXuPddtEg3r/8NELPBjF0rYMUaCqBN4q38EkVBTLnRQXoNXibe
 0+bA==
X-Gm-Message-State: AOAM530/q7pyYsmZ/9ri8YyEB6xsp4PevZUqF0kchxA51oZ6PIpUklOc
 ZRP/fPVojQMe7eTMToob6phh7pyO
X-Google-Smtp-Source: ABdhPJxnDaZ3i7Sdrn8VjDjHgVCuL4Xyy7NB//1CJhbvzUYsT6oj16uVhG8pvXWoGU4k14iSYARTpQ==
X-Received: by 2002:aed:35af:: with SMTP id c44mr23530886qte.349.1591035751665; 
 Mon, 01 Jun 2020 11:22:31 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:31 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 157/207] drm/amd/powerplay: enable VDDCI and MVDD for
 sienna_cichlid
Date: Mon,  1 Jun 2020 14:20:04 -0400
Message-Id: <20200601182054.1267858-68-alexander.deucher@amd.com>
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

From: Likun Gao <Likun.Gao@amd.com>

Enable VDDCI and MVDD if PP_MCLK_DPM_MASK was enable for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 5589838a2238..6223ecf3c11b 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -321,7 +321,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	}
 
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
+					| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
+					| FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
 
 	if (adev->pm.pp_feature & PP_PCIE_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
