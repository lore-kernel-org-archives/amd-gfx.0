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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2E1C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5EE2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQdnWc2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5EE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF416E366;
	Mon,  1 Jun 2020 18:22:44 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19EE36E366
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:44 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id n141so10044443qke.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oV6eG/KGhV0unkqd7Ey+Hjdzo4Na52gtO/Q2si1hiXQ=;
 b=qQdnWc2zuCqIHEcYqzkxSQ+aolffI0osiYriykDjcFoJlYWAWTKQxl1T0ETB5kUbfW
 so4yqi+6ivWYE97WeCErZqAUAWM7qSNjrOj46IGThrLdjTyaqe3DUN+LhH1vgLcX8UYb
 A+Ibi0d97Szf5xO/d/+e4d8oNyvuE2wsjxQrMUQdabiMijNbekwxC9YlUSsBIz2Qg168
 L7cj0tCzMhrT+o1qoRpSi8/KRoymopFR4QlkR1Yo9LvDwrzqp9Nc7rr26caNliA53QxV
 opgK3cQWhmTxBVbyT+Ywri6+chvdbM/2k5Qfn49oKrze0erdfi11L2nx/fH66HrvS8x+
 NxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oV6eG/KGhV0unkqd7Ey+Hjdzo4Na52gtO/Q2si1hiXQ=;
 b=hyXmL9/Qd5Oyf7Xsqh5m9mFcYhy0LSshz9MUujQ2Xw1iJ0rmjZfA6io9JgQCOcdvun
 IMhZILbx+nyBtWsRyJ63s8Mug9kP/lEmg4N3eOaMjuJ7SP3qzlDqQVkF9g7yT5V8mjlM
 vJylTS2cJikt4amo7P+oMot5YDfsvElum1PBvkPwud0jbaTmmkImxLCEPRC5L+Nl0pIq
 Z3mvuPolrtRxFuEzu6hk9WnllzGtbRJgfnJc3I0Zgg1EjFWtDhxJSwpo+kgfQhGGWDKO
 3IvbGCP6XDrLH9T7sb2gonDcWTpjjqkUgaAPkvGmUpO/e7aF7D2PtszKI4YcJlztlrb1
 wPdA==
X-Gm-Message-State: AOAM531CpV0+oiCdllxK7jPw3wfVDBb0Q5NV9xU6cPyTkU3hQUzR7JCK
 Ego2kVv0htgQ8+dwWYdkmZhiANDH
X-Google-Smtp-Source: ABdhPJwnK/Eo2hgEdSFx21XTuwb4CDhjbarl9vJbCmlZG8o8U+LWnlUEPibp7OkJaPn0ObJcgQOUfw==
X-Received: by 2002:a37:8a42:: with SMTP id m63mr20776539qkd.230.1591035762991; 
 Mon, 01 Jun 2020 11:22:42 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:42 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 165/207] drm/amd/amdgpu: disable gfxoff to retrieve gfxclk
Date: Mon,  1 Jun 2020 14:20:12 -0400
Message-Id: <20200601182054.1267858-76-alexander.deucher@amd.com>
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

For Sienna_Cichlid, GFXOFF state puts gfx dpm into standby mode, then the
gfxclk can't be retireved.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 71 ++++++++++++++++---
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index ef8532ff8e30..2ac30d2ddf5e 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -706,6 +706,9 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 
+	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -716,20 +719,20 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	case SMU_DCEFCLK:
 		ret = smu_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			return size;
+			goto print_clk_out;
 
 		/* 10KHz -> MHz */
 		cur_value = cur_value / 100;
 
 		ret = smu_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
-			return size;
+			goto print_clk_out;
 
 		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
-					return size;
+					goto print_clk_out;
 
 				size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 						cur_value == value ? "*" : "");
@@ -737,10 +740,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		} else {
 			ret = smu_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
 			if (ret)
-				return size;
+				goto print_clk_out;
 			ret = smu_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
 			if (ret)
-				return size;
+				goto print_clk_out;
 
 			freq_values[1] = cur_value;
 			mark_index = cur_value == freq_values[0] ? 0 :
@@ -783,19 +786,26 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
+print_clk_out:
+	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	return size;
 }
 
 static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type, uint32_t mask)
 {
-
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, size = 0;
 	uint32_t soft_min_level = 0, soft_max_level = 0, min_freq = 0, max_freq = 0;
 
 	soft_min_level = mask ? (ffs(mask) - 1) : 0;
 	soft_max_level = mask ? (fls(mask) - 1) : 0;
 
+	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -812,20 +822,24 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 
 		ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
 		if (ret)
-			return size;
+			goto forec_level_out;
 
 		ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
-			return size;
+			goto forec_level_out;
 
 		ret = smu_set_soft_freq_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
-			return size;
+			goto forec_level_out;
 		break;
 	default:
 		break;
 	}
 
+forec_level_out:
+	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	return size;
 }
 
@@ -1265,6 +1279,7 @@ static int sienna_cichlid_get_profiling_clk_mask(struct smu_context *smu,
 					 uint32_t *mclk_mask,
 					 uint32_t *soc_mask)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	uint32_t level_count = 0;
 
@@ -1276,7 +1291,9 @@ static int sienna_cichlid_get_profiling_clk_mask(struct smu_context *smu,
 			*mclk_mask = 0;
 	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
 		if(sclk_mask) {
+			amdgpu_gfx_off_ctrl(adev, false);
 			ret = smu_get_dpm_level_count(smu, SMU_SCLK, &level_count);
+			amdgpu_gfx_off_ctrl(adev, true);
 			if (ret)
 				return ret;
 			*sclk_mask = level_count - 1;
@@ -1698,6 +1715,38 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 	return 0;
 }
 
+int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
+				enum smu_clk_type clk_type,
+				uint32_t *min, uint32_t *max)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
+
+	if (clk_type == SMU_GFXCLK)
+		amdgpu_gfx_off_ctrl(adev, false);
+	ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
+	if (clk_type == SMU_GFXCLK)
+		amdgpu_gfx_off_ctrl(adev, true);
+
+	return ret;
+}
+
+int sienna_cichlid_set_soft_freq_limited_range(struct smu_context *smu,
+				      enum smu_clk_type clk_type,
+				      uint32_t min, uint32_t max)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
+
+	if (clk_type == SMU_GFXCLK)
+		amdgpu_gfx_off_ctrl(adev, false);
+	ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min, max);
+	if (clk_type == SMU_GFXCLK)
+		amdgpu_gfx_off_ctrl(adev, true);
+
+	return ret;
+}
+
 static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -2452,8 +2501,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = smu_v11_0_baco_enter,
 	.baco_exit = smu_v11_0_baco_exit,
-	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
-	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
+	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
+	.set_soft_freq_limited_range = sienna_cichlid_set_soft_freq_limited_range,
 	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
 	.get_pptable_power_limit = sienna_cichlid_get_pptable_power_limit,
 };
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
