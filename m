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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD555C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FAF2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDiCZiXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FAF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9DF6E36F;
	Mon,  1 Jun 2020 18:22:47 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B39B6E36F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:45 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id y9so494296qvs.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6OLoO6Rbg646H4/ln2dqUF9zWIdi1I5Orwtq2X+51c0=;
 b=GDiCZiXrhyT0jCIbi/WTfD1Zaz6tX4rcdzI0nIvLQjuQeQf0hmyewVRJdVtCtga1eQ
 fbgtL6uC74yXMeh195Qw8D9z0tdEwR4cERXrhe1yzFnbGCPcdZ8XO62FIogNnay3asoS
 jED4QboEBiHU2ijBqjB2CMf3bSz+Mmq8zEKONNxUlX9nMww1VMizMETkdeQ0+fPxcIlV
 gNuKD5eiKGNMx33hHk7le4+wfLjGVz+u69HHERNOhAHy3w3JSTZVeBTLRsc/kspcYaiL
 PoG1GAIr9CEGB7vLBHkZcfd8REbP/iXRcGZuYDdlCybF6NsPASFfELLfSQ0dIA5+ZUWl
 4Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6OLoO6Rbg646H4/ln2dqUF9zWIdi1I5Orwtq2X+51c0=;
 b=Q9zHuaBUZC0Uk5kNbZdIg6HoFa5mbokjqe5sFqJAOSfX5BDtQ7GCbRFnkKg317kfoc
 QcfZ9VD7Zy3S4Vu1OdEYu/fgWppZiA0G6c+TyGxBSHE2ouHZJWv9Z8SHSJ9I3nmUApOm
 NSAhF6gksSHoRUr2pPKA6xRwYOD1YKWRwyGZPeE1Vd4PdTOi8Es/ICkxswCzO/wcA3RJ
 /3L99WrShIAoH51yesrD6ammsMvE23BfdtDql9S9Mm/ARxSI2S1Uf8nuylcm811QjmOx
 ntYb/3bZSDF5QzQ6mZ4CD2dMBnkv36gOAQz8EtJyEdzSu57Ez73SaD4hTNGQo1qYih5M
 QwhA==
X-Gm-Message-State: AOAM530Lm7T9Rev046zuP1doJWRWf5iAILs3mQea+ViDwa/gasP0FOqb
 ucxjUyEdAajmwY7loXkXyZY9t7+s
X-Google-Smtp-Source: ABdhPJyl9Hnq0vjcQeiooOfhIwwC5Ly/8pc7aaImpjlAyY7LJTa5HW0j6/Ry9QTdLdwaHf8SbYom6Q==
X-Received: by 2002:a0c:8b4a:: with SMTP id d10mr10647333qvc.242.1591035764100; 
 Mon, 01 Jun 2020 11:22:44 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:43 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 166/207] drm/amdgpu: enable gfxoff for sienna_cichlid
Date: Mon,  1 Jun 2020 14:20:13 -0400
Message-Id: <20200601182054.1267858-77-alexander.deucher@amd.com>
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

Enable GFXOFF for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 4 +---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 +++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index cc1835cd0c91..5ddce490247d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3537,9 +3537,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
-	case CHIP_SIENNA_CICHLID:
-		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		break;
 	default:
 		break;
 	}
@@ -7441,6 +7438,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 2ac30d2ddf5e..10114132fdd8 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -341,6 +341,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
 
+	if (adev->pm.pp_feature & PP_GFXOFF_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXOFF_BIT);
+
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_ATHUB)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_PG_BIT);
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index b9575f1c22a3..560f78a805b9 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1353,6 +1353,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
