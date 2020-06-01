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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5C2C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34722077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9lidEHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34722077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C48D6E2CC;
	Mon,  1 Jun 2020 18:04:44 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A9E6E2D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:42 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id ec10so460517qvb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yvd6z3CFUpj/qRf2OvcSwSdbafk3ZEWGgsrE8ZiD5jo=;
 b=K9lidEHpi18E98LPsfmat5KqMhfMuTu+F8rFzuaJQST674wQiUm0ZtKdgKDooVGUs8
 tn/Tz29llIsXa/W9g+YyxcXm6d97ZSyIrVJipiUqMWH1xQS6+Os+5jnTf1XfhCsyUzy6
 +jIvrqAnktT9Jo9Eau1xSK35CBXCgMIKfVNwoiK6dYHMfifCve59yfVhEIJbMLbiU5cA
 8uRMck/XxPTrs83bfYKHJ+Ol7gfTA5/G2s3CcBv7L/QPYeJhxzYLn2Vg8YKEQFj5L4uD
 z1Z3JWoYZIFTOq3TtlEU8g0wN3yndwR01Zi1CMaLpJAro0VLcKgeX0Xg0rD7t6N+Nyy2
 tnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yvd6z3CFUpj/qRf2OvcSwSdbafk3ZEWGgsrE8ZiD5jo=;
 b=Kvuswv8Aws+6mMKR2Pgp2KH17PEn5Dc7CcWe1cv7HQqCJ5Vkmn6yGrEqX95CB9gpnY
 BiaXwnVC1mye0/JGexf3wFysXZEPtKzQrcG2PV9ls6TtRqv3SFX2FB94wyOvzrIafB6S
 UJIqh0m0/dtcthbaRQjQM2aAfJVaaTfYLriJo+yYx4iSX5J2kZNbVnQfFN6cyZy0ASRN
 ZJmanDsrTMwxDeQl3ijFujJsOOlXj/QJ64alp1nmeWXK8N2r6A5ncZwUpWqLbsSGNMZd
 8lIzfy5RUCMP6G8sSUsdB/7EIz43NgM9aPR8GyVP6ZPDrwNeB4Vdczg0L9IhsucuRdNI
 d4fg==
X-Gm-Message-State: AOAM532ocZoPx4o4zOK7OSn1nfoFDmgbO2oZZ1xwA5KaGTX0iEHdO0Ah
 4qgyRPLcxkuXwANTeCYbgbMsqHMR
X-Google-Smtp-Source: ABdhPJzZHb2B8tHOcu6Xi4aDiltlKWLjapvLHOJ7u4ubzGJswDh8Nhmw58l4KqG8ZSGepYjsf1mTVQ==
X-Received: by 2002:ad4:4baa:: with SMTP id i10mr7164156qvw.163.1591034681865; 
 Mon, 01 Jun 2020 11:04:41 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 081/207] drm/amdgpu/mes: correct register offset for
 sienna_cichlid
Date: Mon,  1 Jun 2020 14:00:33 -0400
Message-Id: <20200601180239.1267430-78-alexander.deucher@amd.com>
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
 Jack Xiao <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Correct CP_MES_IC_OP_CNTL register address for sienna_cichlid on mes v10.1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 39 +++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 8d2469fe2174..447bee159089 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -31,6 +31,9 @@
 #include "v10_structs.h"
 #include "mes_api_def.h"
 
+#define mmCP_MES_IC_OP_CNTL_Sienna_Cichlid               0x2820
+#define mmCP_MES_IC_OP_CNTL_Sienna_Cichlid_BASE_IDX      1
+
 MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_mes.bin");
 
@@ -490,15 +493,43 @@ static int mes_v10_1_load_microcode(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmCP_MES_MDBOUND_LO, 0x3FFFF);
 
 	/* invalidate ICACHE */
-	data = RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		data = RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid);
+		break;
+	default:
+		data = RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL);
+		break;
+	}
 	data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
 	data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
-	WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL, data);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid, data);
+		break;
+	default:
+		WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL, data);
+		break;
+	}
 
 	/* prime the ICACHE. */
-	data = RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		data = RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid);
+		break;
+	default:
+		data = RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL);
+		break;
+	}
 	data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-	WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL, data);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid, data);
+		break;
+	default:
+		WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL, data);
+		break;
+	}
 
 	nv_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
