Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D2EC2D0E0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B3E205F4
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJQ4K0VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B3E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F556E8DB;
	Tue, 15 Sep 2020 18:24:21 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB9E6E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 18:24:20 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id g72so5275581qke.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u5weu28YcQl+FmqawHOtjd2Vu4W79A3GBJsbDfl43vs=;
 b=nJQ4K0VE2Bno+yu0ixuH3rGyYs44V7gxgj2o2UgDzrlc6ukRjAv1lfZo8Hla6ECUoY
 BMu/T8CmnbtJEonctUGsWm6UvvFx3Ve7HkA9UPRPB4h5RZNcjVbAQrouz5pm4c3s/OiL
 vIl+C15BrHLTfj6cFPA5ZIFL88qqsZtiK12N1Vps4yi8y8YsnanAjcygl0Ixqz05sHZT
 OSoB++aoznJmcTrO9SYCfkrV+LaCZxy2QyNfOuIIeLfmRMXDdYsVJXsOaS4DkdkMKmKU
 u8PR0vyI877enev52cZN2CJWsW9D42BFVfZL9F584uhPlFd3kzu7JhPj1lCJF6Z8UMGv
 1p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u5weu28YcQl+FmqawHOtjd2Vu4W79A3GBJsbDfl43vs=;
 b=OIuGgRZ01KwpjpKPtdBLjGqMle1c9VrzVqWaFsJCxIovKxunlc8adhxne2IcrOpqVg
 9q+OKSC+6bhvX2WO0BXRZ2fAR8t5N6re4zeoVXhflIQ8la1hg2gATPQ2o+LzMbKVphcO
 f7pPKvIch+JkD3tD3nPu9UTomHosZhT8rJQos8Nungvand6z9zuZcPEIURWNZEBSdz+q
 n4W+mxBBip/Q2b/NLLMFNPdRSTN9MWZak5oOVC48PiI0halqDwVKBsx9j6ZKbKNyn4UL
 Q9MSD+XjjAgj7q0Ehlwa6gip5lHpzv5vOwAGiOXbYyENyiRVhLs9uStXPHs5NbLjH7zp
 ufoA==
X-Gm-Message-State: AOAM531yq70H5yRgs6GSbYNMomsADw00VnoUrxVTSKA1T+CrtPXUBafL
 ocZLSyp3T51iLfZK9MtqVIO859xxh5E=
X-Google-Smtp-Source: ABdhPJx/6BRiHLwexnAsW0gMbGpn2fd/nP3iIP/XCP0DNaeqw/mR6I1WAjJgpUaLWkwXQueWrZTlVQ==
X-Received: by 2002:a37:e504:: with SMTP id e4mr18705804qkg.290.1600194259109; 
 Tue, 15 Sep 2020 11:24:19 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id x126sm17318009qkb.101.2020.09.15.11.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 11:24:18 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: use the AV1 defines for VCN 3.0
Date: Tue, 15 Sep 2020 14:24:08 -0400
Message-Id: <20200915182409.68727-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200915182409.68727-1-alexander.deucher@amd.com>
References: <20200915182409.68727-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch from magic numbers to defines for AV1 clockgating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 589d6cd8adec..e074f7ed388c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -746,18 +746,18 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 		| UVD_SUVD_CGC_GATE__IME_HEVC_MASK
 		| UVD_SUVD_CGC_GATE__EFC_MASK
 		| UVD_SUVD_CGC_GATE__SAOE_MASK
-		| 0x08000000
+		| UVD_SUVD_CGC_GATE__SRE_AV1_MASK
 		| UVD_SUVD_CGC_GATE__FBC_PCLK_MASK
 		| UVD_SUVD_CGC_GATE__FBC_CCLK_MASK
-		| 0x40000000
+		| UVD_SUVD_CGC_GATE__SCM_AV1_MASK
 		| UVD_SUVD_CGC_GATE__SMPA_MASK);
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE, data);
 
 	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE2);
 	data |= (UVD_SUVD_CGC_GATE2__MPBE0_MASK
 		| UVD_SUVD_CGC_GATE2__MPBE1_MASK
-		| 0x00000004
-		| 0x00000008
+		| UVD_SUVD_CGC_GATE2__SIT_AV1_MASK
+		| UVD_SUVD_CGC_GATE2__SDB_AV1_MASK
 		| UVD_SUVD_CGC_GATE2__MPC1_MASK);
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE2, data);
 
@@ -776,8 +776,8 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 		| UVD_SUVD_CGC_CTRL__SMPA_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPBE0_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPBE1_MODE_MASK
-		| 0x00008000
-		| 0x00010000
+		| UVD_SUVD_CGC_CTRL__SIT_AV1_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_AV1_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPC1_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__FBC_PCLK_MASK
 		| UVD_SUVD_CGC_CTRL__FBC_CCLK_MASK);
@@ -892,8 +892,8 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 		| UVD_SUVD_CGC_CTRL__SMPA_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPBE0_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPBE1_MODE_MASK
-		| 0x00008000
-		| 0x00010000
+		| UVD_SUVD_CGC_CTRL__SIT_AV1_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_AV1_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__MPC1_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__FBC_PCLK_MASK
 		| UVD_SUVD_CGC_CTRL__FBC_CCLK_MASK);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
