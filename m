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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D59C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAE32073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfEBvDaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAE32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 652F86E34D;
	Mon,  1 Jun 2020 18:22:25 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C39F6E34C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:23 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id g7so470074qvx.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vcCZZI7Fx/fouPF1vAwaYuX2eO7FGNDq1t/0H72iI0M=;
 b=EfEBvDaFTzktRravByStp7mc0W2HCHim8iEh4mxAad98jWHipGggq4m3MrHAciBQ1s
 r+72JZNL442UUjZD4L7g3U5QPwONlWE1WsB1YXuYNONQSgh08XudFWXGAKMm2BAiKoPg
 l6ve6Q2C8Zc/OJSI7fsWVbsTP4HUvlYeV9qrJk8GumntEONKuVWBFVdn0fmigevgbUZY
 8HZ5aKVzU6o2yUBJaJWT3VAW0+w6tUYWc3TBN4Dt9aOhYJDPJMrZ7FspUzZexli8mdve
 tTR1zS2Dm6cBq3ahCP4cGcNeIqFsXp83XDpd7NugadDEp9Oy06trtjbs850gyQI8sGWV
 5nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vcCZZI7Fx/fouPF1vAwaYuX2eO7FGNDq1t/0H72iI0M=;
 b=XcYNXcLQkHyK7ImssfCWhVDhVNza5UAE8kf6z5BRJcUpmU4I25gFaRFRPopauAkvoj
 um5+MR055/TZHbq2N5uMO+tk9AtwnDCA1G/ku617dvitEfvXzuxsRBL0yExpcjVM5vL9
 d0oJkNG6vH670bYQKKJXgvw7qNTNStsb6vSek1Ea9uUmCFH375aCW0vFO7TXFnXwE5Gm
 hQJmEIHBEH1XR/t58fYQimFuYvJ5XoBFBn+QWS+Wi4pJY2isnADoWwXKC6jtID7NwYXr
 8x9ceqcwPvMDTDgCgccba8/0wRTKEVKD+Kard8uxr/pt40v9oMwWVnftqG0V2wb8zXsR
 /DPg==
X-Gm-Message-State: AOAM530i7ehDJhCp/ff90inWQA/VokaEccDNAHaA2PKOCaENtrbGLVJO
 SzjA+tOI0k98/YiyMfA4T0DcZPQs
X-Google-Smtp-Source: ABdhPJyCaJmF7I1q/YiRz+zDvryWFzPVQhAIfTLo2hDf0YintY9qOcWwrmr1SkPoPNNhxO4EV0JtgQ==
X-Received: by 2002:a0c:b44c:: with SMTP id e12mr21609909qvf.30.1591035742615; 
 Mon, 01 Jun 2020 11:22:22 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:22 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 150/207] drm/amdgpu: enable DPG mode for VCN3.0
Date: Mon,  1 Jun 2020 14:19:57 -0400
Message-Id: <20200601182054.1267858-61-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, James Zhu <james.zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Enable DPG mode for VCN3.0 by updating related flag.

V2: update description.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 936950fbafda..ef3f07dc89cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -726,6 +726,7 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_MC_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_ATHUB;
 		adev->external_rev_id = adev->rev_id + 0x28;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 98ba6ddde823..875bdc877c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -254,7 +254,8 @@ static int vcn_v3_0_hw_init(void *handle)
 
 done:
 	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully.\n");
+		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
+			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
 	return r;
 }
@@ -278,7 +279,9 @@ static int vcn_v3_0_hw_fini(void *handle)
 
 		ring = &adev->vcn.inst[i].ring_dec;
 
-		if (RREG32_SOC15(VCN, i, mmUVD_STATUS))
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+			(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+			RREG32_SOC15(VCN, i, mmUVD_STATUS)))
 			vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
 		ring->sched.ready = false;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
