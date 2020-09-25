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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C30C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343AB2399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqxqgDCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343AB2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9A66ED64;
	Fri, 25 Sep 2020 20:11:19 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8008C6ED64
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:18 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id ef16so2034260qvb.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a9A6YTGDambbtKkfwUmP87soqqrjgXK81BKTgB2AdJs=;
 b=eqxqgDCXTZNWcKMIWQsU075tspEZ+br4xw5oo17jjbC5lAm4ReG6rf9LB94K4fwQiP
 NlGI6xtiofhKdrxIb6TsQL3IzKPUo+jxW9AZCwgYcxV9Q7T8IOl7srJfAzsuxYtTjxgP
 wEZvgtfPZsq4miS1Lan3iAm7JuNLr/riT78OVpIxEiA+IY2aUGbb2niBVpAKFnhoC21d
 ch8TuDTqlNvH4wbEd3a524jsBEAJ91PA9QomFlqmPbDMSjvaxo4Qh7PyIFv1nKkjqWLd
 AP26yS6tEyfr6pqWLBw0MV7H4LhkxD8RgPA0EQznzU8EQFT8+ig0crijnFTivz72AJ89
 pFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a9A6YTGDambbtKkfwUmP87soqqrjgXK81BKTgB2AdJs=;
 b=XCc6yyfIJvc5IcAbmjsKlIolHXJ9y1WobTk8fZ9zJp9JsQoVer+MNh1A+C8911j0ki
 +rm/XigRpEtif7cEHrVltAYOT4fYjb7OpqmF4Mg5eVGqE0aONpJhgVFNYzKLWE8wsIcw
 pcekCdT5lqZIXgupiHFoVViGUXGIQF72ltyMYNC+jcswHw66la+fRyi5/NOhe0M9PVID
 n0KsxYPJlS5sICLsHbNSvJrYUjzl1lQNCdhFTzsiCApZutNm3/rOHtyr/nWiJER3uPPn
 YnWj/H9FASVUjSx85hPxAMijWaQV/U1BHyQPWzAuIMpQ5H6mPLb1uhBfpkUfVmEPfkvL
 lKwQ==
X-Gm-Message-State: AOAM532UooJb4VJqIcjqgK0XpajrPiTGFiynmQXzRP1jA0+FfUJKJM0T
 bJFISVn3c/JvAVTg7MCOMiLNRbXg2NM=
X-Google-Smtp-Source: ABdhPJw2ugzfyLHZ9EEFJNWSAHjvPKnGNAsfZW/zMZ+j1Rgqi11N8PO9eD2zRVaHgTK7B5WbRsPO8g==
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr347024qvw.26.1601064677382;
 Fri, 25 Sep 2020 13:11:17 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:16 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/45] drm/amdgpu: add gfx golden settings for vangogh (v3)
Date: Fri, 25 Sep 2020 16:10:01 -0400
Message-Id: <20200925201029.1738724-17-alexander.deucher@amd.com>
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

This patch is to add gfx golden settings for vangogh post si.

v2: squash in updates
v3: fix SPI register offset

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 36 +++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 19ab5783214c..6999228cd6c0 100755
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -99,6 +99,9 @@
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid			0x1580
 #define mmGCR_GENERAL_CNTL_Sienna_Cichlid_BASE_IDX	0
 
+#define mmSPI_CONFIG_CNTL_1_Vangogh		0x2441
+#define mmSPI_CONFIG_CNTL_1_Vangogh_BASE_IDX	1
+
 #define mmCP_HYP_PFP_UCODE_ADDR			0x5814
 #define mmCP_HYP_PFP_UCODE_ADDR_BASE_IDX	1
 #define mmCP_HYP_PFP_UCODE_DATA			0x5815
@@ -3170,6 +3173,33 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000003ff)
 };
 
+static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
+{
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xff7f0fff, 0x30000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0xff7f0fff, 0x7e000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_PIPE_STEER, 0x000000ff, 0x000000e4),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000142),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x00f80988),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1_Vangogh, 0xffffffff, 0x00070103),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x00001000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00400000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000000ff),
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -3377,7 +3407,11 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_10_3_2,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_2));
 		break;
-
+	case CHIP_VANGOGH:
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_10_3_vangogh,
+						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_vangogh));
+		break;
 	default:
 		break;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
