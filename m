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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EBBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B719E2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9GIH3zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B719E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7694A6E32A;
	Mon,  1 Jun 2020 18:22:03 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A056E32A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:02 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id v79so9969976qkb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/vEMzFgFwes2fGZ2pwyF3M9SooXNMyKa+YsyT0FwLKw=;
 b=D9GIH3zcDH0ZQi/ptpmG6PdTEv9FEqaVQrSq8Rmr/wjv7Zj76xZGS2bdOuzXPn+ZvA
 v3EnGXNwzSBQC17vUFgu8f+kJb/LVVQC3TXzw1A287L5qE6Dwefqz+02KwTE8qbEa9jI
 fNFUWn84cWskWdO+i8xo3dQJ8oepRuaYIxoqaJ4A6/YtYnFc6VPiEbTgR8XpTVEQ5yXG
 T65pUBIzacLAY3b6sbh+4wanfAhaIGCUxtkwzxuajWuv6S/Fd2mpxyTrTs4FMpbrfZa+
 FqBueOmgOrxtqkh7gLJDOrQ92kO8pdj8IevnnvihTv8fT5CMGUHt5xX70yG24Mqbyq7D
 lQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/vEMzFgFwes2fGZ2pwyF3M9SooXNMyKa+YsyT0FwLKw=;
 b=ebOSlBYzzYQhJLDMGKs3Z0bqvhQ3/+uEDGijMixElSq+0PzUkY1ol27JdakPkVcQ3r
 4emr0QGTStCtX/t1RqK4PDGXnjjJg4F02/Uxpfx0nNpUq1ZfG6+YFUwhMebBFWCt3qu0
 UFSGQnxKPnl1cqcVBix0y7tC0312TpJTESpN6UYTvhLD5Gt30fEVo38c7upOdoQggLZa
 JREQgOYSoPG/jyPibh4b5LNaetnj/ImzJUR54BTntgfCNNCANhXuNCLaTgVJAV7s+SSR
 /zIENpeHIZUGSHd1D3EYGkWAvyGk2I/Skxzw2smvfMkDSIVqCftTMAGido8/5RfsSgcL
 2Mew==
X-Gm-Message-State: AOAM5339LkbplnVcZrnBF2hC1JLyGnkCiFpmR6sGoiDNCbbEPcG5a9Is
 CfaOJtYnn1Mx4uHkEGV9VbVUaf84
X-Google-Smtp-Source: ABdhPJwK5zzLR95rV5gme8JeT7FEZRyruWsllecPnsEkryMtngZDpZpytxkIXxxID1F2IwUcfPgONA==
X-Received: by 2002:a37:607:: with SMTP id 7mr19876066qkg.385.1591035721653;
 Mon, 01 Jun 2020 11:22:01 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 134/207] drm/amd/powerplay: enable mmhub pg
Date: Mon,  1 Jun 2020 14:19:41 -0400
Message-Id: <20200601182054.1267858-45-alexander.deucher@amd.com>
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

mmhub pg can be obvserved from PCTL_CTRL

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c                    | 3 ++-
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 6ca4c6f043c6..936950fbafda 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -704,7 +704,8 @@ static int nv_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-			AMD_PG_SUPPORT_ATHUB;
+			AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
 		/* guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
 		 * as a consequence, the rev_id and external_rev_id are wrong.
 		 * workaround it by hardcoding rev_id to 0 (default value).
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index f7e67c446ae0..8fb08cae5c24 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -335,6 +335,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_ATHUB)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_PG_BIT);
 
+	if (smu->adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MMHUB_PG_BIT);
+
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_VCN ||
 	    smu->adev->pg_flags & AMD_PG_SUPPORT_JPEG)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_PG_BIT);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
