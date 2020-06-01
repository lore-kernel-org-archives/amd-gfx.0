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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA04EC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8300B2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3lLxkjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8300B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391266E353;
	Mon,  1 Jun 2020 18:22:28 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5082C6E353
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:27 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id c12so8439083qtq.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ttmm9kd8I+fAsn55k+vXUvCTbAB1UzEsbreuorLlCJ8=;
 b=m3lLxkjN9Xm3qvi3vyJHpRuKxmpV2GX3Ppy1SdEfy/I4gTx7TBnTuEdoKIJ6MIF/+K
 1z1eA65jO8eKgm71zNXjJqccO1favMUZ6g8pmj0ftDV1BTBpgvEw+pquFqyWA+sqc22a
 jynlOMCYh4E6XcGD3fx9W97283QLej/LfhsshS0rzXic7gJdiwlpyO42OaglvriDv9UV
 7NM73loVW0Qr9krPu9289M7Ra+1/6zlou2jVv4Bq3aOONKPOpcEqHQMTG3jJai0SnuwV
 dDGP0IAFjxb0k2WIhWXzJyNXG5HflZIhwnp/T5XR6JfZueO5PyBc8cRilXyCI3OF6eox
 DkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ttmm9kd8I+fAsn55k+vXUvCTbAB1UzEsbreuorLlCJ8=;
 b=hjo3mcq81dpt0qtH70PeqZUBEW/WRbm6UNhWslPeXKifGLG4Mh0zKuVeiCB467jROs
 iaRxzflmGAkTtBnJquEImkdsRS7R6AdUg45wvZrG1VZHSQBdjc+1bBkUor59lDZeaieT
 er1ajsFT1aB9zcsbNBctAtpvVGWuFFb2tdAF6nrLoAL0u5Ol4Pe/mIYEngb8RwvEMZBP
 5ChUestJja0Y+S/teXH7D1u5zOPwWuD3QzdSIJOO2oeEsfQ1rIdvxzDFEsZkQPMfUF+d
 nRSfQ/BsfuuVTnEO9leHGVGSHBMw7mlwKsw2CPgNEdytyYcvqyOIelNS5FjfGaxilQr5
 tD5Q==
X-Gm-Message-State: AOAM530UzimUUbNs+w9nAhJLkIubmnswC+s9bQm3Sr2NQBhTbqHglYop
 fvNuSVcSKLk0TzJzyOCOZfjTxDZx
X-Google-Smtp-Source: ABdhPJy9l/66TY4vjjPg9ZZoVZuEDlkntIlIYrbQJfCVHoAsf1qhw6dcwcDlM0YbuQc+s7fVna2ATQ==
X-Received: by 2002:ac8:2a3a:: with SMTP id k55mr23045036qtk.294.1591035746332; 
 Mon, 01 Jun 2020 11:22:26 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:25 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 153/207] drm/amd/powerplay: enable ULCK DS for sienna_cichlid
Date: Mon,  1 Jun 2020 14:20:00 -0400
Message-Id: <20200601182054.1267858-64-alexander.deucher@amd.com>
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

Enable uclk deep sleep for sienna_cichlid.
Df cstate kicks in first, then df triggers uclk ds with the sideband.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 545b4efc2bfa..8e3fe192e50a 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -301,6 +301,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_FCLK_BIT)
+				| FEATURE_MASK(FEATURE_DS_UCLK_BIT)
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 				| FEATURE_MASK(FEATURE_RSMU_SMN_CG_BIT)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
