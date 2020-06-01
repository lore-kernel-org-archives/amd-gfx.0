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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589ACC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5C820878
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/unJmQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5C820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25A46E27F;
	Mon,  1 Jun 2020 18:03:43 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6AA6E26F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:42 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id 205so9960112qkg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rj2ES2h39/WboDC0K/3zHc4FAKcnxguaIkEYmaYKAX4=;
 b=a/unJmQD3qZlmKmmo90I+LH0g02bapAQi4bJYqMHaHxN+ETSIdJ9oPjXiJ52UP1n5w
 mHjwUTA0ZulVdJhRGPIpKW/pB7V1Xp4gLsXQktdgJhqzPl3j8jOIImPp1Ul0DBqeCc8D
 mpawoVGqVcyGujNPb/pZUXpZeO4GMvpNijUWRu/LPc87cv+UGZ1E2lTprrlAcWeH08oU
 GqAtvh7IV+8HSu4qkuvvRmVC8fN/3InORvp/gukRV/Q4kYo5J6j/FRvGb9CXkCKV7Nni
 3HsnT0rJj0DhIIExPTimF6iCruqpGDYuod8OMIay1sfcibvj48UFk1jPaBbgyElwYSz+
 5FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rj2ES2h39/WboDC0K/3zHc4FAKcnxguaIkEYmaYKAX4=;
 b=aBQT66uNb2IJodjG4b0yt/jDfpdBYn1pvinyVMuKACaAfx9ybn47HIVwtXiOKL0aYj
 MNcquzwXFYjNnAhDsohlQq6T30oJBb4r6PGomPAzNEAMvMEhu1sFrf8GoNabweLn9EnZ
 uDF8F9LLJVwbUBqPWEtscJXowsltxkJBNXVB/jb6XlwRb6EGWnnd0KWbcA+rqag0dJt6
 NPW5ceMPRJ1I4VOKlkm1Y43Sc+htOTlGJG4VBKEq+IAG2JjMDUgHfJypIXwU7tUVdZES
 2BQkdb34TcyG7y+6okOMScFnnev7N6KRDK1hHQ3H6IQ5C6HmdnMbW6oBy74fI+pOC9DW
 aoAw==
X-Gm-Message-State: AOAM533k9/um0ci5d5gu2vY6zXFnyte66B609oNLKPvAHPu4urSqgHl0
 ooVuWdUO45emS6hBWefcNWck0vNy
X-Google-Smtp-Source: ABdhPJx8x/jajxUjQ99pB3DWHqpoQQriTqdLZEsz9jwdV/PQITgoAAcUvD9SfE8v2yrmbB+EZuCmNw==
X-Received: by 2002:a05:620a:1388:: with SMTP id
 k8mr21135513qki.216.1591034621365; 
 Mon, 01 Jun 2020 11:03:41 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:40 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 038/207] drm/amd/powerplay: support to print pcie levels for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:50 -0400
Message-Id: <20200601180239.1267430-35-alexander.deucher@amd.com>
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

Support to print PCIE clk levels for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 31 +++++++++++++++++++
 .../drm/amd/powerplay/sienna_cichlid_ppt.h    |  3 ++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 5b4319b0da6c..662a95585c27 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -37,6 +37,7 @@
 #include "smu_v11_0_pptable.h"
 #include "smu_v11_0_7_ppsmc.h"
 
+#include "nbio/nbio_2_3_sh_mask.h"
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
 
 #define FEATURE_MASK(feature) (1ULL << feature)
@@ -508,10 +509,16 @@ static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu,
 static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	PPTable_t *pptable = (PPTable_t *)table_context->driver_pptable;
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
+	uint32_t gen_speed, lane_width;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
@@ -562,6 +569,30 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 
 		}
 		break;
+	case SMU_PCIE:
+		gen_speed = (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
+			     PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
+			>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
+		lane_width = (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
+			      PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
+			>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+		for (i = 0; i < NUM_LINK_LEVELS; i++)
+			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 1) ? "5.0GT/s," :
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 2) ? "8.0GT/s," :
+					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 3) ? "16.0GT/s," : "",
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 1) ? "x1" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 2) ? "x2" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 3) ? "x4" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 4) ? "x8" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 5) ? "x12" :
+					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 6) ? "x16" : "",
+					pptable->LclkFreq[i],
+					(gen_speed == dpm_context->dpm_tables.pcie_table.pcie_gen[i]) &&
+					(lane_width == dpm_context->dpm_tables.pcie_table.pcie_lane[i]) ?
+					"*" : "");
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
index ce4e4fe43806..bc04ae326990 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
@@ -25,4 +25,7 @@
 
 extern void sienna_cichlid_set_ppt_funcs(struct smu_context *smu);
 
+#define smnPCIE_LC_SPEED_CNTL                   0x11140290
+#define smnPCIE_LC_LINK_WIDTH_CNTL              0x11140288
+
 #endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
