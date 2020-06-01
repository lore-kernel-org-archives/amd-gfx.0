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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B5EC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA472077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIFHz/Qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA472077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30DF26E266;
	Mon,  1 Jun 2020 18:03:29 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 401C56E261
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:28 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id k22so8417482qtm.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aXyqX0TZVggpo7+1Pb0/rI8fucdijUc799RX+sD+iTM=;
 b=mIFHz/QjEfTCWKhuKl1l/K2nrEFFvFQEyb9/tXKx9E//4IFMnMwa13X+23zT6WU5qN
 Y30xD0JXzAPiSrLTHprIXy72Dfc6TP74iBQ23yawK3oAoLUvwSOH2szvyZrkia6oTSFk
 I3pHlDjd7rvoshHrzyBwD8khGFKw3CfKOdOODhirabxojKazYZsnN2oFGsOWSgtrzFta
 +AE08rQm3NnKe68/R6JrUQC9aY1/gUjDDO5tZlCU9600a22ZfoxCI41S3YU1hpjISUjc
 JXZoV48ck8gs056BV7KfUASeZTqVb8iC9DU8wM76NVdvuCWpnvK/KmxxatI6x5IhaWWC
 foPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aXyqX0TZVggpo7+1Pb0/rI8fucdijUc799RX+sD+iTM=;
 b=cNE0mwZJl/nJisxkM20bUPM/r6q3+kz5wlp02s1JiSB+Ibowci6OBJjr0sP7L6iIUM
 pO536HBftKq94UNpV6OhO0AfsG/2RGph9tl+nO8A2B9RupaWMnKwcfKmsAkSNylkEqGi
 k8U3MUlvsY/xOfTk/aePL0YBJwWDATd059AWiCWAVDKa95synaN05HpYHvq6hKFSz/GC
 LAK3OaH/BJnlgBcBt9wE0grFkBwLer8I4cyBJZKiom4u1K7fRTtQgO7A3jVPUjnTc27Q
 PE9XNyERGi/5+/ymTloaTxhkqZ/D/397kqz30moeommL5Y2FrdnkhwHn7LxTSFdyx/Wu
 ujqg==
X-Gm-Message-State: AOAM533q1XW3TxCiIOzVHaq1PaK4ZM+gXWbEXn5q+2ZXUJlDgH5qxy0g
 hwm9qv8I2s1zD38ysAt/HZJoO90g
X-Google-Smtp-Source: ABdhPJyRBgmlkg/+sb3idkKgBnLXvEMCJ796VArJdKAdtke+Zf/yS2m7QYskne2LP1FszpsGOGGonA==
X-Received: by 2002:ac8:4c89:: with SMTP id j9mr23220325qtv.326.1591034607150; 
 Mon, 01 Jun 2020 11:03:27 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:26 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 026/207] drm/amd/powerplay: add support to set performance
 level for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:38 -0400
Message-Id: <20200601180239.1267430-23-alexander.deucher@amd.com>
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

Support for performance level set for sienna_cichlid.
Set standard performance level not fully support, will set to auto
performance level.
Set peak performance level not fully support, will do nothing with it.
Force clk level only support for 2 level for fine grained DPM.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index e034dcd25c70..4aa174117af3 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -552,6 +552,12 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_DCEFCLK:
 	case SMU_FCLK:
+		/* There is only 2 levels for fine grained DPM */
+		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
+			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
+			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
+		}
+
 		ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
 		if (ret)
 			return size;
@@ -1238,6 +1244,82 @@ static int sienna_cichlid_get_uclk_dpm_states(struct smu_context *smu, uint32_t
 	return 0;
 }
 
+static int sienna_cichlid_set_performance_level(struct smu_context *smu,
+					enum amd_dpm_forced_level level);
+
+static int sienna_cichlid_set_standard_performance_level(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+	uint32_t sclk_freq = 0, uclk_freq = 0;
+
+	switch (adev->asic_type) {
+	/* TODO: need to set specify clk value by asic type, not support yet*/
+	default:
+		/* by default, this is same as auto performance level */
+		return sienna_cichlid_set_performance_level(smu, AMD_DPM_FORCED_LEVEL_AUTO);
+	}
+
+	ret = smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq, sclk_freq, false);
+	if (ret)
+		return ret;
+	ret = smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq, uclk_freq, false);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int sienna_cichlid_set_peak_performance_level(struct smu_context *smu)
+{
+	int ret = 0;
+
+	/* TODO: not support yet*/
+	return ret;
+}
+
+static int sienna_cichlid_set_performance_level(struct smu_context *smu,
+					enum amd_dpm_forced_level level)
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
+		ret = smu_unforce_dpm_levels(smu);
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+		ret = sienna_cichlid_set_standard_performance_level(smu);
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
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		ret = sienna_cichlid_set_peak_performance_level(smu);
+		break;
+	case AMD_DPM_FORCED_LEVEL_MANUAL:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
+	default:
+		break;
+	}
+	return ret;
+}
+
 static int sienna_cichlid_get_thermal_temperature_range(struct smu_context *smu,
 						struct smu_temperature_range *range)
 {
@@ -2019,6 +2101,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_watermarks_table = sienna_cichlid_set_watermarks_table,
 	.read_sensor = sienna_cichlid_read_sensor,
 	.get_uclk_dpm_states = sienna_cichlid_get_uclk_dpm_states,
+	.set_performance_level = sienna_cichlid_set_performance_level,
 	.get_thermal_temperature_range = sienna_cichlid_get_thermal_temperature_range,
 	.display_disable_memory_clock_switch = sienna_cichlid_display_disable_memory_clock_switch,
 	.get_power_limit = sienna_cichlid_get_power_limit,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
