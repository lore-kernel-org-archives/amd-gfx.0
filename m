Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C3C4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91AF23A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf7LrNMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91AF23A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA636ED80;
	Fri, 25 Sep 2020 20:11:56 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00EEA6ED80
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:53 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id d1so3082490qtr.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WHOZ9gQWsiI7JvkfIQegXoauQluPixctieLSKxa7ZP0=;
 b=Vf7LrNModTcgwRtwDYMdP8HW4PfftM9YlTNrm9cyzJAlUjcpdwxEOcN61F1VZLB7GU
 GmwSi2KXu2A4WP3jj+eBsMaQkFH14htHIjvup1hWjcPNw2o8W4BswUOLO1v6Pj4Xmztm
 LaUIBrwrQIu4OtOpU5q8wsBk4YPjZoqGHkw4JpDZobfXWLg4NochRjAhFZVDSzXe4wKH
 NrQedqtU/n4ax5+7804obOzbE1J4YEjkR+6O1PZX6abO2cUYv22xauWkeKG6IcjTKLp5
 4Sok6yZR/ZJB2jAPFoXMJljuoKTFHsxw/cB8xfG1uSqcgZH0vQ3db5rv9ZCFpjh0Kv5k
 VlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WHOZ9gQWsiI7JvkfIQegXoauQluPixctieLSKxa7ZP0=;
 b=hmmFJRempCrNPVZNFugie9BibrPNccuR+CvvF0c9kURxbQKwc4+DgTBl+MKbiN/Dko
 NLeNIw1F0yD7Ga2Rb0W7sneFEWsMcGXeK4jV5obPmD0xiIjuQylwNmaDtq6oZ76GzvjZ
 dc7QSZXhTKteYd47cokDNAkn/FnvH4sbyKvhlT8J76RGlZ38t0tbNLVtsoZ+u7w+gxOZ
 Jq1Ja9Yo9Fe10WdDMDnp6QRHTteOCGBIlBOpaxyrhZdPXF3rcsqLhjrZxDA4p2ZFtPv+
 dXphykWhwr6RS9X7Zte1FXNncrT3KHlvyf9ucEsp+B8CoNwYVX6uJDRm9GPVqqjj6OJY
 i4rw==
X-Gm-Message-State: AOAM531NgynksPedKtHU23xKoJvPoKDXu526glPlk3HOlhPLqaxdLHSs
 eB210zTajbkRNBjiJ+My+hU3SEqmMHM=
X-Google-Smtp-Source: ABdhPJxEaRjM3DugOthlYWVGm2D0p02vHv/vlB09ltPdznJl3k8m/xKeXBm3ctNZdatXAJS7/b8KJQ==
X-Received: by 2002:ac8:4e0b:: with SMTP id c11mr1498092qtw.37.1601064713037; 
 Fri, 25 Sep 2020 13:11:53 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 42/45] drm/amdgpu: enable gfx clock gating and power gating
 for vangogh
Date: Fri, 25 Sep 2020 16:10:26 -0400
Message-Id: <20200925201029.1738724-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch is to enable the gfx cg and pg for vangogh.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4bd2e2f35fa4..67b6067f2bd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -919,8 +919,11 @@ static int nv_common_early_init(void *handle)
 		break;
 
 	case CHIP_VANGOGH:
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS;
+		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
