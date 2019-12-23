Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4BDC2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8247B2053B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3Pb6QeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8247B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DAB56E0CB;
	Mon, 23 Dec 2019 19:54:34 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D622D6E0CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 19:54:33 +0000 (UTC)
Received: by mail-yb1-xb44.google.com with SMTP id x14so7451362ybr.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 11:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=azFWSATuiA0vL+6l/ES21ZDvrsGiY0YXc5YZixl/5Cw=;
 b=H3Pb6QeFbyqIobLIXnxG9acdzqLDVHQCmMubaKU/sGjsMIW6AYutIJiQPoYgg2JPwT
 xkPvXhYK4VdQdAwRDjtrtE1a34/dZRuSa5jnxZ9PFMUqYLWdt8zqUC2jqL6au78/+zCo
 dV1SH7YupqA7Tl2AKx/BYdbk7EjNbuJ8ukoBjFMRVWBSw9e7xqGXnXSmZ2U/TvJqwHys
 Pgtp4GHPd9G3SyEzp7WewqzfxccnLokUheGFd4yQi2DIv0OCHlMwdCz954YwDIOF0kgY
 +tXVVgdmXoBJ/asRM0l6lzJ66lR1BI9wY5rK8Gg2GKYhDZ5GLyDV9FV+OM2pRDO+tDkH
 /FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=azFWSATuiA0vL+6l/ES21ZDvrsGiY0YXc5YZixl/5Cw=;
 b=Vo/qN1w6WRGXw5dG3EwsXGHwVTusrsOawGLN3PBL9XNXBWAxGjh66RtxApe9T345rS
 3triInt3v0Dj86cwb0XEUXpvu6OIcEPik0T+bNb5QiDQtOvU8RHq0VS9eyeQGVtcTUqJ
 aYZSMefimp9qZF6UbEiqeDQYZewq+4HG5jtZXkpSesnRkZMxIGuH4ZniFPRZHz90xEMe
 4CeCBcdNpsOjCLrp5QwUrcOXNuF+uImGB64RX21uX2bPdUQg5yMu5+FhZgE8haNJ21e2
 pp+cJGPch22oTcP8nn0se+FfwxIdmbfSqdx7Yw0qj3owf1Q2ooi49CA1kc8OEscVCFiX
 nn3w==
X-Gm-Message-State: APjAAAX1YLjdKfRcQWdtYjHij6d20MFGj9HUJny1Ypiq3718Ln8mV6k+
 Sz2OEs6jnzVRrY5/qZTI2bF/fMSb
X-Google-Smtp-Source: APXvYqwmCH/50myb0uFzJ4ebwzlqRAf/M8smCgdLnpkFLnIg17ntKKxFDloLvei9PPLN++wvUsN5Lg==
X-Received: by 2002:a25:b90b:: with SMTP id x11mr21403773ybj.209.1577130872787; 
 Mon, 23 Dec 2019 11:54:32 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l200sm8644866ywl.106.2019.12.23.11.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 11:54:32 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/smu: make the set_performance_level logic easier
 to follow
Date: Mon, 23 Dec 2019 14:54:25 -0500
Message-Id: <20191223195425.2022741-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Have every asic provide a callback for this rather than a mix
of generic and asic specific code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 44 +------------------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  3 ++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 30 +++++++++++--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 30 +++++++++++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 39 ++++++++++++++++
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  1 +
 7 files changed, 100 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 936c68298786..d07c4f2ccee7 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1607,43 +1607,6 @@ static int smu_enable_umd_pstate(void *handle,
 	return 0;
 }
 
-static int smu_default_set_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
-{
-	int ret = 0;
-	uint32_t sclk_mask, mclk_mask, soc_mask;
-
-	switch (level) {
-	case AMD_DPM_FORCED_LEVEL_HIGH:
-		ret = smu_force_dpm_limit_value(smu, true);
-		break;
-	case AMD_DPM_FORCED_LEVEL_LOW:
-		ret = smu_force_dpm_limit_value(smu, false);
-		break;
-	case AMD_DPM_FORCED_LEVEL_AUTO:
-	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
-		ret = smu_unforce_dpm_levels(smu);
-		break;
-	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
-	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
-	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		ret = smu_get_profiling_clk_mask(smu, level,
-						 &sclk_mask,
-						 &mclk_mask,
-						 &soc_mask);
-		if (ret)
-			return ret;
-		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
-		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask, false);
-		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask, false);
-		break;
-	case AMD_DPM_FORCED_LEVEL_MANUAL:
-	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
-	default:
-		break;
-	}
-	return ret;
-}
-
 int smu_adjust_power_state_dynamic(struct smu_context *smu,
 				   enum amd_dpm_forced_level level,
 				   bool skip_display_settings)
@@ -1681,11 +1644,8 @@ int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	if (smu_dpm_ctx->dpm_level != level) {
 		ret = smu_asic_set_performance_level(smu, level);
 		if (ret) {
-			ret = smu_default_set_performance_level(smu, level);
-			if (ret) {
-				pr_err("Failed to set performance level!");
-				return ret;
-			}
+			pr_err("Failed to set performance level!");
+			return ret;
 		}
 
 		/* update the saved copy */
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index be4ae0aea9a0..dd575a1baeda 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2117,6 +2117,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_profiling_clk_mask = arcturus_get_profiling_clk_mask,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
+	.set_performance_level = smu_v11_0_set_performance_level,
 	/* debug (internal used) */
 	.dump_pptable = arcturus_dump_pptable,
 	.get_power_limit = arcturus_get_power_limit,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 786de7741990..db3f78676aeb 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -262,4 +262,7 @@ int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize,
 
 uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu);
 
+int smu_v11_0_set_performance_level(struct smu_context *smu,
+				    enum amd_dpm_forced_level level);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index bf87e93b26fc..a8ae5cd969a4 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1649,19 +1649,43 @@ static int navi10_set_peak_clock_by_device(struct smu_context *smu)
 	return ret;
 }
 
-static int navi10_set_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
+static int navi10_set_performance_level(struct smu_context *smu,
+					enum amd_dpm_forced_level level)
 {
 	int ret = 0;
+	uint32_t sclk_mask, mclk_mask, soc_mask;
 
 	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_HIGH:
+		ret = smu_force_dpm_limit_value(smu, true);
+		break;
+	case AMD_DPM_FORCED_LEVEL_LOW:
+		ret = smu_force_dpm_limit_value(smu, false);
+		break;
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+		ret = smu_unforce_dpm_levels(smu);
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+		ret = smu_get_profiling_clk_mask(smu, level,
+						 &sclk_mask,
+						 &mclk_mask,
+						 &soc_mask);
+		if (ret)
+			return ret;
+		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
+		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask, false);
+		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask, false);
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
 		ret = navi10_set_peak_clock_by_device(smu);
 		break;
+	case AMD_DPM_FORCED_LEVEL_MANUAL:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 	default:
-		ret = -EINVAL;
 		break;
 	}
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 979772dbe6a9..e73644beffd9 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -708,19 +708,43 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	return ret;
 }
 
-static int renoir_set_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
+static int renoir_set_performance_level(struct smu_context *smu,
+					enum amd_dpm_forced_level level)
 {
 	int ret = 0;
+	uint32_t sclk_mask, mclk_mask, soc_mask;
 
 	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_HIGH:
+		ret = smu_force_dpm_limit_value(smu, true);
+		break;
+	case AMD_DPM_FORCED_LEVEL_LOW:
+		ret = smu_force_dpm_limit_value(smu, false);
+		break;
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+		ret = smu_unforce_dpm_levels(smu);
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+		ret = smu_get_profiling_clk_mask(smu, level,
+						 &sclk_mask,
+						 &mclk_mask,
+						 &soc_mask);
+		if (ret)
+			return ret;
+		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
+		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask, false);
+		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask, false);
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
 		ret = renoir_set_peak_clock_by_device(smu);
 		break;
+	case AMD_DPM_FORCED_LEVEL_MANUAL:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 	default:
-		ret = -EINVAL;
 		break;
 	}
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 7781d245f8ef..73935cf7ff39 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1860,3 +1860,42 @@ int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize,
 	}
 	return ret;
 }
+
+int smu_v11_0_set_performance_level(struct smu_context *smu,
+				    enum amd_dpm_forced_level level)
+{
+	int ret = 0;
+	uint32_t sclk_mask, mclk_mask, soc_mask;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_HIGH:
+		ret = smu_force_dpm_limit_value(smu, true);
+		break;
+	case AMD_DPM_FORCED_LEVEL_LOW:
+		ret = smu_force_dpm_limit_value(smu, false);
+		break;
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+		ret = smu_unforce_dpm_levels(smu);
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		ret = smu_get_profiling_clk_mask(smu, level,
+						 &sclk_mask,
+						 &mclk_mask,
+						 &soc_mask);
+		if (ret)
+			return ret;
+		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
+		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask, false);
+		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask, false);
+		break;
+	case AMD_DPM_FORCED_LEVEL_MANUAL:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+	default:
+		break;
+	}
+	return ret;
+}
+
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 250ff5aa1305..534c46bc0146 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3194,6 +3194,7 @@ static const struct pptable_funcs vega20_ppt_funcs = {
 	.get_od_percentage = vega20_get_od_percentage,
 	.get_power_profile_mode = vega20_get_power_profile_mode,
 	.set_power_profile_mode = vega20_set_power_profile_mode,
+	.set_performance_level = smu_v11_0_set_performance_level,
 	.set_od_percentage = vega20_set_od_percentage,
 	.set_default_od_settings = vega20_set_default_od_settings,
 	.od_edit_dpm_table = vega20_odn_edit_dpm_table,
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
