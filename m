Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81938C18E00
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 19:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57577206F4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 19:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlUbYOWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57577206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B3D6EC8A;
	Wed, 19 Feb 2020 19:20:00 +0000 (UTC)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4C06EC87
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 19:19:58 +0000 (UTC)
Received: by mail-io1-xd44.google.com with SMTP id z193so1855839iof.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e9yV+C6Zr8YkBJnuS6OM2I9isLylAfU4H+eyE687QRc=;
 b=HlUbYOWTeLhRo2/4s8pPjixVnWUniIzlQqEzP9lxT+bdh+uOOfUQtyxo0qdCRIJRCl
 +eb8M+LIOgmaJlFBGd0sYoBgkJ+lTPotpq4p60epRIRXj7I6rWRiTjX0IHyqs5vy0WDP
 /ZbUHKOFdK1oSIK7j9kUvBULVkqQpGDDohu55ILdedImQ3OdJsNHAAd7m21l64QJ44Oq
 WI9YeVQoHMjGDo3lQ7yoUw5ZFktf3KvXyX9R9xbqrXASARqFW0Wjzhr+rj7z0f5w4VTa
 ZNl0esTkcsb9my9g/4Yhuw2Jw37DSKZZ7+HrENXTVR/uvxD++Pfsz4BfkTwm8m9KqajP
 haOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e9yV+C6Zr8YkBJnuS6OM2I9isLylAfU4H+eyE687QRc=;
 b=uQyI8lB1wE4Q58b0o7+4yiUwyKJhoUWpkTOIq8DlR5Jddaff/OMRRVTtJgPlHfwrX9
 Frt24epYzOrAd1jVzDy7cnSH32uBVIxF2SpFGMeOmJ4tMLoD9eCT0xQn4p/zxeAVxI08
 F3kTK29nnA2ouV7rC6Ho8K6dSmKygZbRilNlLDkJ6a2+UoxGJyiSIosGhYH04ZqJk8qG
 4Eu9ZI6p5W42Hoqlz1Z1VNEUduJ3Bbr4HtOTSgOAw28cEgW+eu+GtBAEId4fIODb3bqR
 00nQ91efXtDtMrObyzZXvgmbHeSFy04vouInqUf/DG/zezkLujrw3ZrGALMXYYojgNrJ
 h7BA==
X-Gm-Message-State: APjAAAW6NYE7R4FlLhlnzEEOXW/sab4jP14FbveM20Tk+Dt9BFQgUU5t
 Xyx8FK/hwBoF3mzOhA6igvtD6PLeyfo=
X-Google-Smtp-Source: APXvYqz0WQj/8RFE60Bh+FkLyFFQpPNHSzkzADyuHloRt67A5ciltHjqHXgM+0oQ6/IlNuMvY0g/Kg==
X-Received: by 2002:a5d:8856:: with SMTP id t22mr20117819ios.217.1582139996870; 
 Wed, 19 Feb 2020 11:19:56 -0800 (PST)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id h19sm245706ild.76.2020.02.19.11.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 11:19:56 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: alexdeucher@gmail.com
Subject: [PATCH 1/2] drm/amdgpu/powerplay: Refactor SMU message handling for
 safety
Date: Wed, 19 Feb 2020 12:19:40 -0700
Message-Id: <20200219191941.67724-2-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <5d301d58-49c7-6c3c-0652-6e051514d1ff@amd.com>
References: <5d301d58-49c7-6c3c-0652-6e051514d1ff@amd.com>
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
Cc: Matt Coffin <mcoffin13@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the responsibility for reading argument registers into the
smu_send_smc_msg* implementations, so that adding a message-sending lock
to protect the SMU registers will result in the lock still being held
when the argument is read.

For code compatibility on hardware I don't have the funds to buy, I kept
the old interface around with `_unsafe` suffixes.
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  47 +++-----
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  18 +--
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   3 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   7 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |   3 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  76 +++++++-----
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  22 ++--
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  15 ++-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 114 +++++++++---------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  65 ++++++----
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  42 +++----
 11 files changed, 213 insertions(+), 199 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4720aa58a150..759f7446529f 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -121,20 +121,20 @@ static int smu_feature_update_enable_state(struct smu_context *smu,
 
 	if (enabled) {
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeaturesLow,
-						  feature_low);
+						  feature_low, NULL);
 		if (ret)
 			return ret;
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeaturesHigh,
-						  feature_high);
+						  feature_high, NULL);
 		if (ret)
 			return ret;
 	} else {
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeaturesLow,
-						  feature_low);
+						  feature_low, NULL);
 		if (ret)
 			return ret;
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeaturesHigh,
-						  feature_high);
+						  feature_high, NULL);
 		if (ret)
 			return ret;
 	}
@@ -195,21 +195,13 @@ int smu_get_smc_version(struct smu_context *smu, uint32_t *if_version, uint32_t
 		return -EINVAL;
 
 	if (if_version) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetDriverIfVersion);
-		if (ret)
-			return ret;
-
-		ret = smu_read_smc_arg(smu, if_version);
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetDriverIfVersion, if_version);
 		if (ret)
 			return ret;
 	}
 
 	if (smu_version) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetSmuVersion);
-		if (ret)
-			return ret;
-
-		ret = smu_read_smc_arg(smu, smu_version);
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetSmuVersion, smu_version);
 		if (ret)
 			return ret;
 	}
@@ -251,7 +243,7 @@ int smu_set_hard_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMaxByFreq,
-						  param);
+						  param, NULL);
 		if (ret)
 			return ret;
 	}
@@ -259,7 +251,7 @@ int smu_set_hard_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 	if (min > 0) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinByFreq,
-						  param);
+						  param, NULL);
 		if (ret)
 			return ret;
 	}
@@ -335,12 +327,8 @@ int smu_get_dpm_freq_by_index(struct smu_context *smu, enum smu_clk_type clk_typ
 
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
 
-	ret = smu_send_smc_msg_with_param(smu,SMU_MSG_GetDpmFreqByIndex,
-					  param);
-	if (ret)
-		return ret;
-
-	ret = smu_read_smc_arg(smu, &param);
+	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmFreqByIndex,
+					  param, &param);
 	if (ret)
 		return ret;
 
@@ -542,7 +530,8 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 	ret = smu_send_smc_msg_with_param(smu, drv2smu ?
 					  SMU_MSG_TransferTableDram2Smu :
 					  SMU_MSG_TransferTableSmu2Dram,
-					  table_id | ((argument & 0xFFFF) << 16));
+					  table_id | ((argument & 0xFFFF) << 16),
+					  NULL);
 	if (ret)
 		return ret;
 
@@ -900,6 +889,7 @@ static int smu_sw_init(void *handle)
 
 	mutex_init(&smu->sensor_lock);
 	mutex_init(&smu->metrics_lock);
+	mutex_init(&smu->message_lock);
 
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
@@ -1981,7 +1971,7 @@ int smu_set_mp1_state(struct smu_context *smu,
 		return 0;
 	}
 
-	ret = smu_send_smc_msg(smu, msg);
+	ret = smu_send_smc_msg(smu, msg, NULL);
 	if (ret)
 		pr_err("[PrepareMp1] Failed!\n");
 
@@ -2656,12 +2646,3 @@ uint32_t smu_get_pptable_power_limit(struct smu_context *smu)
 
 	return ret;
 }
-
-int smu_send_smc_msg(struct smu_context *smu,
-		     enum smu_message_type msg)
-{
-	int ret;
-
-	ret = smu_send_smc_msg_with_param(smu, msg, 0);
-	return ret;
-}
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 14ba6aa876e2..4babc04ed5a6 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -371,7 +371,7 @@ arcturus_set_single_dpm_table(struct smu_context *smu,
 	int ret = 0;
 	uint32_t i, num_of_levels = 0, clk;
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_send_smc_msg_with_param_unsafe(smu,
 			SMU_MSG_GetDpmFreqByIndex,
 			(clk_id << 16 | 0xFF));
 	if (ret) {
@@ -387,7 +387,7 @@ arcturus_set_single_dpm_table(struct smu_context *smu,
 
 	single_dpm_table->count = num_of_levels;
 	for (i = 0; i < num_of_levels; i++) {
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 				SMU_MSG_GetDpmFreqByIndex,
 				(clk_id << 16 | i));
 		if (ret) {
@@ -552,13 +552,13 @@ static int arcturus_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_RunAfllBtc);
+	ret = smu_send_smc_msg(smu, SMU_MSG_RunAfllBtc, NULL);
 	if (ret) {
 		pr_err("RunAfllBtc failed!\n");
 		return ret;
 	}
 
-	return smu_send_smc_msg(smu, SMU_MSG_RunDcBtc);
+	return smu_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
 }
 
 static int arcturus_populate_umd_state_clk(struct smu_context *smu)
@@ -741,7 +741,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
 		single_dpm_table = &(dpm_table->gfx_table);
 		freq = max ? single_dpm_table->dpm_state.soft_max_level :
 			single_dpm_table->dpm_state.soft_min_level;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_GFXCLK << 16) | (freq & 0xffff));
 		if (ret) {
@@ -756,7 +756,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
 		single_dpm_table = &(dpm_table->mem_table);
 		freq = max ? single_dpm_table->dpm_state.soft_max_level :
 			single_dpm_table->dpm_state.soft_min_level;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_UCLK << 16) | (freq & 0xffff));
 		if (ret) {
@@ -771,7 +771,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
 		single_dpm_table = &(dpm_table->soc_table);
 		freq = max ? single_dpm_table->dpm_state.soft_max_level :
 			single_dpm_table->dpm_state.soft_min_level;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_SOCCLK << 16) | (freq & 0xffff));
 		if (ret) {
@@ -1287,7 +1287,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 			if (power_src < 0)
 				return -EINVAL;
 
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetPptLimit,
+			ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_GetPptLimit,
 				power_src << 16);
 			if (ret) {
 				pr_err("[%s] get PPT limit failed!", __func__);
@@ -1495,7 +1495,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_send_smc_msg_with_param_unsafe(smu,
 					  SMU_MSG_SetWorkloadMask,
 					  1 << workload_type);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 97b6714e83e6..2db343915d9d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -362,6 +362,7 @@ struct smu_context
 	struct mutex			mutex;
 	struct mutex			sensor_lock;
 	struct mutex			metrics_lock;
+	struct mutex			message_lock;
 	uint64_t pool_size;
 
 	struct smu_table_context	smu_table;
@@ -514,7 +515,7 @@ struct pptable_funcs {
 	int (*set_last_dcef_min_deep_sleep_clk)(struct smu_context *smu);
 	int (*system_features_control)(struct smu_context *smu, bool en);
 	int (*send_smc_msg_with_param)(struct smu_context *smu,
-				       enum smu_message_type msg, uint32_t param);
+				       enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
 	int (*read_smc_arg)(struct smu_context *smu, uint32_t *arg);
 	int (*init_display_count)(struct smu_context *smu, uint32_t count);
 	int (*set_allowed_mask)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index acccdf621b4e..0b789386b5a6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -138,6 +138,8 @@ enum smu_v11_0_baco_seq {
 	BACO_SEQ_COUNT,
 };
 
+int smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg);
+
 int smu_v11_0_init_microcode(struct smu_context *smu);
 
 int smu_v11_0_load_microcode(struct smu_context *smu);
@@ -182,9 +184,8 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 int
 smu_v11_0_send_msg_with_param(struct smu_context *smu,
 			      enum smu_message_type msg,
-			      uint32_t param);
-
-int smu_v11_0_read_arg(struct smu_context *smu, uint32_t *arg);
+			      uint32_t param,
+			      uint32_t *read_arg);
 
 int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count);
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index d79e54b5ebf6..bb17730d1707 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -47,7 +47,8 @@ int smu_v12_0_wait_for_response(struct smu_context *smu);
 int
 smu_v12_0_send_msg_with_param(struct smu_context *smu,
 			      enum smu_message_type msg,
-			      uint32_t param);
+			      uint32_t param,
+			      uint32_t *read_arg);
 
 int smu_v12_0_check_fw_status(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 0d73a49166af..de500df4ac7c 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -661,14 +661,14 @@ static int navi10_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 1);
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 1, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->vcn_gated = false;
 	} else {
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn);
+			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
 		}
@@ -686,14 +686,14 @@ static int navi10_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_send_smc_msg(smu, SMU_MSG_PowerUpJpeg);
+			ret = smu_send_smc_msg(smu, SMU_MSG_PowerUpJpeg, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownJpeg);
+			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownJpeg, NULL);
 			if (ret)
 				return ret;
 		}
@@ -751,6 +751,33 @@ static void navi10_od_setting_get_range(struct smu_11_0_overdrive_table *od_tabl
 		*max = od_table->max[setting];
 }
 
+static int navi10_overdrive_get_gfx_clk_base_voltage_od(struct smu_context *smu,
+						     uint16_t *voltage,
+						     uint32_t freq,
+						     bool is_overdrive)
+{
+	uint32_t param = (freq & 0xFFFF) | (PPCLK_GFXCLK << 16);
+	uint32_t value = 0;
+	int ret;
+
+	if (is_overdrive) {
+		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetVoltageByDpmOverdrive, param, &value);
+	} else {
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_GetVoltageByDpm,
+						  param,
+						  &value);
+	}
+	if (ret) {
+		pr_err("[GetBaseVoltage] failed to get GFXCLK AVFS voltage from SMU!");
+		return ret;
+	}
+
+	*voltage = (uint16_t)value;
+
+	return 0;
+}
+
 static int navi10_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
@@ -1042,7 +1069,7 @@ static int navi10_pre_display_config_changed(struct smu_context *smu)
 	int ret = 0;
 	uint32_t max_freq = 0;
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, 0);
+	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, 0, NULL);
 	if (ret)
 		return ret;
 
@@ -1075,7 +1102,8 @@ static int navi10_display_config_changed(struct smu_context *smu)
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
-						  smu->display_config->num_display);
+						  smu->display_config->num_display,
+						  NULL);
 		if (ret)
 			return ret;
 	}
@@ -1400,7 +1428,7 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 	if (workload_type < 0)
 		return -EINVAL;
 	smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type);
+				    1 << workload_type, NULL);
 
 	return ret;
 }
@@ -1465,7 +1493,8 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 			if (smu_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
 				ret = smu_send_smc_msg_with_param(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
-								  min_clocks.dcef_clock_in_sr/100);
+								  min_clocks.dcef_clock_in_sr/100,
+								  NULL);
 				if (ret) {
 					pr_err("Attempt to set divider for DCEFCLK Failed!");
 					return ret;
@@ -1855,12 +1884,11 @@ static int navi10_get_power_limit(struct smu_context *smu,
 				return -EINVAL;
 
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetPptLimit,
-				power_src << 16);
+				power_src << 16, &asic_default_power_limit);
 			if (ret) {
 				pr_err("[%s] get PPT limit failed!", __func__);
 				return ret;
 			}
-			smu_read_smc_arg(smu, &asic_default_power_limit);
 		} else {
 			/* the last hope to figure out the ppt limit */
 			if (!pptable) {
@@ -1900,7 +1928,8 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 					pptable->PcieLaneCount[i] : pcie_width_cap);
 		ret = smu_send_smc_msg_with_param(smu,
 					  SMU_MSG_OverridePcieParameters,
-					  smu_pcie_arg);
+					  smu_pcie_arg,
+					  NULL);
 
 		if (ret)
 			return ret;
@@ -1936,26 +1965,11 @@ static int navi10_od_setting_check_range(struct smu_11_0_overdrive_table *od_tab
 	return 0;
 }
 
-static int navi10_overdrive_get_gfx_clk_base_voltage(struct smu_context *smu,
+static inline int navi10_overdrive_get_gfx_clk_base_voltage(struct smu_context *smu,
 						     uint16_t *voltage,
 						     uint32_t freq)
 {
-	uint32_t param = (freq & 0xFFFF) | (PPCLK_GFXCLK << 16);
-	uint32_t value = 0;
-	int ret;
-
-	ret = smu_send_smc_msg_with_param(smu,
-					  SMU_MSG_GetVoltageByDpm,
-					  param);
-	if (ret) {
-		pr_err("[GetBaseVoltage] failed to get GFXCLK AVFS voltage from SMU!");
-		return ret;
-	}
-
-	smu_read_smc_arg(smu, &value);
-	*voltage = (uint16_t)value;
-
-	return 0;
+	return navi10_overdrive_get_gfx_clk_base_voltage_od(smu, voltage, freq, false);
 }
 
 static int navi10_setup_od_limits(struct smu_context *smu) {
@@ -2209,7 +2223,7 @@ static int navi10_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_RunBtc);
+	ret = smu_send_smc_msg(smu, SMU_MSG_RunBtc, NULL);
 	if (ret)
 		pr_err("RunBtc failed!\n");
 
@@ -2221,9 +2235,9 @@ static int navi10_dummy_pstate_control(struct smu_context *smu, bool enable)
 	int result = 0;
 
 	if (!enable)
-		result = smu_send_smc_msg(smu, SMU_MSG_DAL_DISABLE_DUMMY_PSTATE_CHANGE);
+		result = smu_send_smc_msg(smu, SMU_MSG_DAL_DISABLE_DUMMY_PSTATE_CHANGE, NULL);
 	else
-		result = smu_send_smc_msg(smu, SMU_MSG_DAL_ENABLE_DUMMY_PSTATE_CHANGE);
+		result = smu_send_smc_msg(smu, SMU_MSG_DAL_ENABLE_DUMMY_PSTATE_CHANGE, NULL);
 
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 810994017f49..5c71822249a5 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -342,14 +342,14 @@ static int renoir_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0);
+			ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_PowerUpVcn, 0);
 			if (ret)
 				return ret;
 		}
 		power_gate->vcn_gated = false;
 	} else {
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn);
+			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
 		}
@@ -367,14 +367,14 @@ static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0);
+			ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_PowerUpJpeg, 0);
 			if (ret)
 				return ret;
 		}
 		power_gate->jpeg_gated = false;
 	} else {
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0);
+			ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_PowerDownJpeg, 0);
 			if (ret)
 				return ret;
 		}
@@ -620,12 +620,12 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 		ret = smu_get_dpm_freq_range(smu, SMU_GFXCLK, &min_freq, &max_freq, false);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetSoftMaxGfxClk,
 					soft_max_level == 0 ? min_freq :
 					soft_max_level == 1 ? RENOIR_UMD_PSTATE_GFXCLK : max_freq);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetHardMinGfxClk,
 					soft_min_level == 2 ? max_freq :
 					soft_min_level == 1 ? RENOIR_UMD_PSTATE_GFXCLK : min_freq);
 		if (ret)
@@ -634,10 +634,10 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 	case SMU_SOCCLK:
 		GET_DPM_CUR_FREQ(clk_table, clk_type, soft_min_level, min_freq);
 		GET_DPM_CUR_FREQ(clk_table, clk_type, soft_max_level, max_freq);
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max_freq);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max_freq);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min_freq);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetHardMinSocclkByFreq, min_freq);
 		if (ret)
 			return ret;
 		break;
@@ -645,10 +645,10 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 	case SMU_FCLK:
 		GET_DPM_CUR_FREQ(clk_table, clk_type, soft_min_level, min_freq);
 		GET_DPM_CUR_FREQ(clk_table, clk_type, soft_max_level, max_freq);
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max_freq);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetSoftMaxFclkByFreq, max_freq);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min_freq);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetHardMinFclkByFreq, min_freq);
 		if (ret)
 			return ret;
 		break;
@@ -680,7 +680,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 		return -EINVAL;
 	}
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+	ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type);
 	if (ret) {
 		pr_err_once("Fail to set workload type %d\n", workload_type);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 7bd200ffcda8..cf5c0595a5d3 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -79,10 +79,19 @@
 #define smu_set_default_od_settings(smu, initialize) \
 	((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu), (initialize)) : 0)
 
-int smu_send_smc_msg(struct smu_context *smu, enum smu_message_type msg);
+#define smu_send_smc_msg_with_param(smu, msg, param, read_arg) \
+	((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send_smc_msg_with_param((smu), (msg), (param), (read_arg)) : 0)
+
+#define smu_send_smc_msg_with_param_unsafe(smu, msg, param) \
+	smu_send_smc_msg_with_param((smu), (msg), (param), NULL)
+
+#define smu_send_smc_msg_unsafe(smu, msg) \
+	smu_send_smc_msg_with_param_unsafe((smu), (msg), 0)
+
+static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_type msg, uint32_t *read_arg) {
+	return smu_send_smc_msg_with_param(smu, msg, 0, read_arg);
+}
 
-#define smu_send_smc_msg_with_param(smu, msg, param) \
-	((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send_smc_msg_with_param((smu), (msg), (param)) : 0)
 #define smu_read_smc_arg(smu, arg) \
 	((smu)->ppt_funcs->read_smc_arg? (smu)->ppt_funcs->read_smc_arg((smu), (arg)) : 0)
 #define smu_alloc_dpm_context(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index b06c057a9002..220bf0b10971 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -92,7 +92,8 @@ static int smu_v11_0_wait_for_response(struct smu_context *smu)
 int
 smu_v11_0_send_msg_with_param(struct smu_context *smu,
 			      enum smu_message_type msg,
-			      uint32_t param)
+			      uint32_t param,
+			      uint32_t *read_arg)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
@@ -115,11 +116,21 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 	smu_v11_0_send_msg_without_waiting(smu, (uint16_t)index);
 
 	ret = smu_v11_0_wait_for_response(smu);
-	if (ret)
+	if (ret) {
 		pr_err("failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
 		       smu_get_message_name(smu, msg), index, param, ret);
+		return ret;
+	}
+	if (read_arg) {
+		ret = smu_v11_0_read_arg(smu, read_arg);
+		if (ret) {
+			pr_err("failed to read message arg: %10s (%d) \tparam: 0x%08x response %#x\n",
+			       smu_get_message_name(smu, msg), index, param, ret);
+			return ret;
+		}
+	}
 
-	return ret;
+	return 0;
 }
 
 int smu_v11_0_init_microcode(struct smu_context *smu)
@@ -671,12 +682,14 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 
 	ret = smu_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetSystemVirtualDramAddrHigh,
-					  address_high);
+					  address_high,
+					  NULL);
 	if (ret)
 		return ret;
 	ret = smu_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetSystemVirtualDramAddrLow,
-					  address_low);
+					  address_low,
+					  NULL);
 	if (ret)
 		return ret;
 
@@ -685,15 +698,15 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 	address_low  = (uint32_t)lower_32_bits(address);
 
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrHigh,
-					  address_high);
+					  address_high, NULL);
 	if (ret)
 		return ret;
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrLow,
-					  address_low);
+					  address_low, NULL);
 	if (ret)
 		return ret;
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					  (uint32_t)memory_pool->size);
+					  (uint32_t)memory_pool->size, NULL);
 	if (ret)
 		return ret;
 
@@ -757,7 +770,7 @@ int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
 	int ret;
 
 	ret = smu_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetMinDeepSleepDcefclk, clk);
+					  SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);
 	if (ret)
 		pr_err("SMU11 attempt to set divider for DCEFCLK Failed!");
 
@@ -784,11 +797,13 @@ int smu_v11_0_set_driver_table_location(struct smu_context *smu)
 	if (driver_table->mc_address) {
 		ret = smu_send_smc_msg_with_param(smu,
 				SMU_MSG_SetDriverDramAddrHigh,
-				upper_32_bits(driver_table->mc_address));
+				upper_32_bits(driver_table->mc_address),
+				NULL);
 		if (!ret)
 			ret = smu_send_smc_msg_with_param(smu,
 				SMU_MSG_SetDriverDramAddrLow,
-				lower_32_bits(driver_table->mc_address));
+				lower_32_bits(driver_table->mc_address),
+				NULL);
 	}
 
 	return ret;
@@ -802,11 +817,13 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 	if (tool_table->mc_address) {
 		ret = smu_send_smc_msg_with_param(smu,
 				SMU_MSG_SetToolsDramAddrHigh,
-				upper_32_bits(tool_table->mc_address));
+				upper_32_bits(tool_table->mc_address),
+				NULL);
 		if (!ret)
 			ret = smu_send_smc_msg_with_param(smu,
 				SMU_MSG_SetToolsDramAddrLow,
-				lower_32_bits(tool_table->mc_address));
+				lower_32_bits(tool_table->mc_address),
+				NULL);
 	}
 
 	return ret;
@@ -819,7 +836,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 	if (!smu->pm_enabled)
 		return ret;
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count);
+	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
 	return ret;
 }
 
@@ -837,12 +854,12 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	bitmap_copy((unsigned long *)feature_mask, feature->allowed, 64);
 
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
-					  feature_mask[1]);
+					  feature_mask[1], NULL);
 	if (ret)
 		goto failed;
 
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskLow,
-					  feature_mask[0]);
+					  feature_mask[0], NULL);
 	if (ret)
 		goto failed;
 
@@ -862,17 +879,11 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,
 		return -EINVAL;
 
 	if (bitmap_empty(feature->enabled, feature->feature_num)) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh);
-		if (ret)
-			return ret;
-		ret = smu_read_smc_arg(smu, &feature_mask_high);
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &feature_mask_high);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow);
-		if (ret)
-			return ret;
-		ret = smu_read_smc_arg(smu, &feature_mask_low);
+		ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow, &feature_mask_low);
 		if (ret)
 			return ret;
 
@@ -894,7 +905,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	int ret = 0;
 
 	ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-				     SMU_MSG_DisableAllSmuFeatures));
+				     SMU_MSG_DisableAllSmuFeatures), NULL);
 	if (ret)
 		return ret;
 
@@ -923,7 +934,7 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 		return ret;
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1);
+		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
 
 	return ret;
 }
@@ -947,30 +958,24 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 		return -EINVAL;
 
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDcModeMaxDpmFreq,
-					  clk_id << 16);
+					  clk_id << 16, clock);
 	if (ret) {
 		pr_err("[GetMaxSustainableClock] Failed to get max DC clock from SMC!");
 		return ret;
 	}
 
-	ret = smu_read_smc_arg(smu, clock);
-	if (ret)
-		return ret;
-
 	if (*clock != 0)
 		return 0;
 
 	/* if DC limit is zero, return AC limit */
 	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq,
-					  clk_id << 16);
+					  clk_id << 16, clock);
 	if (ret) {
 		pr_err("[GetMaxSustainableClock] failed to get max AC clock from SMC!");
 		return ret;
 	}
 
-	ret = smu_read_smc_arg(smu, clock);
-
-	return ret;
+	return 0;
 }
 
 int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
@@ -1102,7 +1107,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 		return -EOPNOTSUPP;
 	}
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n);
+	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n, NULL);
 	if (ret) {
 		pr_err("[%s] Set power limit Failed!\n", __func__);
 		return ret;
@@ -1132,11 +1137,7 @@ int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
 		ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
 	else {
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmClockFreq,
-						  (asic_clk_id << 16));
-		if (ret)
-			return ret;
-
-		ret = smu_read_smc_arg(smu, &freq);
+						  (asic_clk_id << 16), &freq);
 		if (ret)
 			return ret;
 	}
@@ -1371,9 +1372,9 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-			ret = smu_send_smc_msg(smu, SMU_MSG_AllowGfxOff);
+			ret = smu_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
 		else
-			ret = smu_send_smc_msg(smu, SMU_MSG_DisallowGfxOff);
+			ret = smu_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
 		break;
 	default:
 		break;
@@ -1511,7 +1512,8 @@ int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 	int ret = 0;
 	ret = smu_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetXgmiMode,
-					  pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3);
+					  pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
+					  NULL);
 	return ret;
 }
 
@@ -1624,14 +1626,14 @@ int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME);
+	ret = smu_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
 
 	return ret;
 }
 
 static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v11_0_baco_seq baco_seq)
 {
-	return smu_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq);
+	return smu_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
 }
 
 bool smu_v11_0_baco_is_support(struct smu_context *smu)
@@ -1700,12 +1702,12 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 			data |= 0x80000000;
 			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
 
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0);
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
 		} else {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1);
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
 		}
 	} else {
-		ret = smu_send_smc_msg(smu, SMU_MSG_ExitBaco);
+		ret = smu_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
 		if (ret)
 			goto out;
 
@@ -1773,19 +1775,13 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 	param = (clk_id & 0xffff) << 16;
 
 	if (max) {
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq, param);
-		if (ret)
-			goto failed;
-		ret = smu_read_smc_arg(smu, max);
+		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq, param, max);
 		if (ret)
 			goto failed;
 	}
 
 	if (min) {
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpmFreq, param);
-		if (ret)
-			goto failed;
-		ret = smu_read_smc_arg(smu, min);
+		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpmFreq, param, min);
 		if (ret)
 			goto failed;
 	}
@@ -1807,7 +1803,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
-						  param);
+						  param, NULL);
 		if (ret)
 			return ret;
 	}
@@ -1815,7 +1811,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 	if (min > 0) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
-						  param);
+						  param, NULL);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 870e6db2907e..613b273ade38 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -78,7 +78,8 @@ int smu_v12_0_wait_for_response(struct smu_context *smu)
 int
 smu_v12_0_send_msg_with_param(struct smu_context *smu,
 			      enum smu_message_type msg,
-			      uint32_t param)
+			      uint32_t param,
+			      uint32_t *read_arg)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
@@ -101,9 +102,19 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu,
 	smu_v12_0_send_msg_without_waiting(smu, (uint16_t)index);
 
 	ret = smu_v12_0_wait_for_response(smu);
-	if (ret)
+	if (ret) {
 		pr_err("Failed to send message 0x%x, response 0x%x param 0x%x\n",
 		       index, ret, param);
+		return ret;
+	}
+	if (read_arg) {
+		ret = smu_v12_0_read_arg(smu, read_arg);
+		if (ret) {
+			pr_err("Failed to read message arg 0x%x, response 0x%x param 0x%x\n",
+			       index, ret, param);
+			return ret;
+		}
+	}
 
 	return ret;
 }
@@ -163,9 +174,9 @@ int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
 		return 0;
 
 	if (gate)
-		return smu_send_smc_msg(smu, SMU_MSG_PowerDownSdma);
+		return smu_send_smc_msg_unsafe(smu, SMU_MSG_PowerDownSdma);
 	else
-		return smu_send_smc_msg(smu, SMU_MSG_PowerUpSdma);
+		return smu_send_smc_msg_unsafe(smu, SMU_MSG_PowerUpSdma);
 }
 
 int smu_v12_0_powergate_vcn(struct smu_context *smu, bool gate)
@@ -174,9 +185,9 @@ int smu_v12_0_powergate_vcn(struct smu_context *smu, bool gate)
 		return 0;
 
 	if (gate)
-		return smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn);
+		return smu_send_smc_msg_unsafe(smu, SMU_MSG_PowerDownVcn);
 	else
-		return smu_send_smc_msg(smu, SMU_MSG_PowerUpVcn);
+		return smu_send_smc_msg_unsafe(smu, SMU_MSG_PowerUpVcn);
 }
 
 int smu_v12_0_powergate_jpeg(struct smu_context *smu, bool gate)
@@ -185,9 +196,9 @@ int smu_v12_0_powergate_jpeg(struct smu_context *smu, bool gate)
 		return 0;
 
 	if (gate)
-		return smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0);
+		return smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_PowerDownJpeg, 0);
 	else
-		return smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0);
+		return smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_PowerUpJpeg, 0);
 }
 
 int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
@@ -196,7 +207,9 @@ int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
 		return 0;
 
 	return smu_v12_0_send_msg_with_param(smu,
-		SMU_MSG_SetGfxCGPG, enable ? 1 : 0);
+		SMU_MSG_SetGfxCGPG,
+		enable ? 1 : 0,
+		NULL);
 }
 
 int smu_v12_0_read_sensor(struct smu_context *smu,
@@ -262,10 +275,10 @@ int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable)
 	int ret = 0, timeout = 500;
 
 	if (enable) {
-		ret = smu_send_smc_msg(smu, SMU_MSG_AllowGfxOff);
+		ret = smu_send_smc_msg_unsafe(smu, SMU_MSG_AllowGfxOff);
 
 	} else {
-		ret = smu_send_smc_msg(smu, SMU_MSG_DisallowGfxOff);
+		ret = smu_send_smc_msg_unsafe(smu, SMU_MSG_DisallowGfxOff);
 
 		/* confirm gfx is back to "on" state, timeout is 0.5 second */
 		while (!(smu_v12_0_get_gfxoff_status(smu) == 2)) {
@@ -331,14 +344,14 @@ int smu_v12_0_get_enabled_mask(struct smu_context *smu,
 	if (!feature_mask || num < 2)
 		return -EINVAL;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesHigh);
+	ret = smu_send_smc_msg_unsafe(smu, SMU_MSG_GetEnabledSmuFeaturesHigh);
 	if (ret)
 		return ret;
 	ret = smu_read_smc_arg(smu, &feature_mask_high);
 	if (ret)
 		return ret;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_GetEnabledSmuFeaturesLow);
+	ret = smu_send_smc_msg_unsafe(smu, SMU_MSG_GetEnabledSmuFeaturesLow);
 	if (ret)
 		return ret;
 	ret = smu_read_smc_arg(smu, &feature_mask_low);
@@ -388,7 +401,7 @@ int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 		switch (clk_type) {
 		case SMU_GFXCLK:
 		case SMU_SCLK:
-			ret = smu_send_smc_msg(smu, SMU_MSG_GetMaxGfxclkFrequency);
+			ret = smu_send_smc_msg_unsafe(smu, SMU_MSG_GetMaxGfxclkFrequency);
 			if (ret) {
 				pr_err("Attempt to get max GX frequency from SMC Failed !\n");
 				goto failed;
@@ -419,7 +432,7 @@ int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 		switch (clk_type) {
 		case SMU_GFXCLK:
 		case SMU_SCLK:
-			ret = smu_send_smc_msg(smu, SMU_MSG_GetMinGfxclkFrequency);
+			ret = smu_send_smc_msg_unsafe(smu, SMU_MSG_GetMinGfxclkFrequency);
 			if (ret) {
 				pr_err("Attempt to get min GX frequency from SMC Failed !\n");
 				goto failed;
@@ -450,7 +463,7 @@ int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 }
 
 int smu_v12_0_mode2_reset(struct smu_context *smu){
-	return smu_v12_0_send_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2);
+	return smu_v12_0_send_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
 }
 
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
@@ -464,39 +477,39 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk, min);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetHardMinGfxClk, min);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk, max);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetSoftMaxGfxClk, max);
 		if (ret)
 			return ret;
 	break;
 	case SMU_FCLK:
 	case SMU_MCLK:
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetHardMinFclkByFreq, min);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetSoftMaxFclkByFreq, max);
 		if (ret)
 			return ret;
 	break;
 	case SMU_SOCCLK:
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetHardMinSocclkByFreq, min);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max);
 		if (ret)
 			return ret;
 	break;
 	case SMU_VCLK:
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinVcn, min);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetHardMinVcn, min);
 		if (ret)
 			return ret;
 
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxVcn, max);
+		ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetSoftMaxVcn, max);
 		if (ret)
 			return ret;
 	break;
@@ -513,11 +526,11 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu)
 	int ret = 0;
 
 	if (driver_table->mc_address) {
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 				SMU_MSG_SetDriverDramAddrHigh,
 				upper_32_bits(driver_table->mc_address));
 		if (!ret)
-			ret = smu_send_smc_msg_with_param(smu,
+			ret = smu_send_smc_msg_with_param_unsafe(smu,
 				SMU_MSG_SetDriverDramAddrLow,
 				lower_32_bits(driver_table->mc_address));
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 4ad8d6c14ee5..52a6702afe0f 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -587,7 +587,7 @@ static int vega20_check_powerplay_table(struct smu_context *smu)
 
 static int vega20_run_btc_afll(struct smu_context *smu)
 {
-	return smu_send_smc_msg(smu, SMU_MSG_RunAfllBtc);
+	return smu_send_smc_msg(smu, SMU_MSG_RunAfllBtc, NULL);
 }
 
 #define FEATURE_MASK(feature) (1ULL << feature)
@@ -668,7 +668,7 @@ vega20_set_single_dpm_table(struct smu_context *smu,
 	int ret = 0;
 	uint32_t i, num_of_levels = 0, clk;
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_send_smc_msg_with_param_unsafe(smu,
 			SMU_MSG_GetDpmFreqByIndex,
 			(clk_id << 16 | 0xFF));
 	if (ret) {
@@ -685,7 +685,7 @@ vega20_set_single_dpm_table(struct smu_context *smu,
 	single_dpm_table->count = num_of_levels;
 
 	for (i = 0; i < num_of_levels; i++) {
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 				SMU_MSG_GetDpmFreqByIndex,
 				(clk_id << 16 | i));
 		if (ret) {
@@ -1198,7 +1198,7 @@ static int vega20_upload_dpm_level(struct smu_context *smu, bool max,
 		single_dpm_table = &(dpm_table->gfx_table);
 		freq = max ? single_dpm_table->dpm_state.soft_max_level :
 			single_dpm_table->dpm_state.soft_min_level;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_GFXCLK << 16) | (freq & 0xffff));
 		if (ret) {
@@ -1213,7 +1213,7 @@ static int vega20_upload_dpm_level(struct smu_context *smu, bool max,
 		single_dpm_table = &(dpm_table->mem_table);
 		freq = max ? single_dpm_table->dpm_state.soft_max_level :
 			single_dpm_table->dpm_state.soft_min_level;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_UCLK << 16) | (freq & 0xffff));
 		if (ret) {
@@ -1228,7 +1228,7 @@ static int vega20_upload_dpm_level(struct smu_context *smu, bool max,
 		single_dpm_table = &(dpm_table->soc_table);
 		freq = max ? single_dpm_table->dpm_state.soft_max_level :
 			single_dpm_table->dpm_state.soft_min_level;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_SOCCLK << 16) | (freq & 0xffff));
 		if (ret) {
@@ -1243,7 +1243,7 @@ static int vega20_upload_dpm_level(struct smu_context *smu, bool max,
 		single_dpm_table = &(dpm_table->fclk_table);
 		freq = max ? single_dpm_table->dpm_state.soft_max_level :
 			single_dpm_table->dpm_state.soft_min_level;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_FCLK << 16) | (freq & 0xffff));
 		if (ret) {
@@ -1258,7 +1258,7 @@ static int vega20_upload_dpm_level(struct smu_context *smu, bool max,
 		single_dpm_table = &(dpm_table->dcef_table);
 		freq = single_dpm_table->dpm_state.hard_min_level;
 		if (!max) {
-			ret = smu_send_smc_msg_with_param(smu,
+			ret = smu_send_smc_msg_with_param_unsafe(smu,
 				SMU_MSG_SetHardMinByFreq,
 				(PPCLK_DCEFCLK << 16) | (freq & 0xffff));
 			if (ret) {
@@ -1420,7 +1420,7 @@ static int vega20_force_clk_levels(struct smu_context *smu,
 			break;
 		}
 
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 				SMU_MSG_SetMinLinkDpmByIndex, soft_min_level);
 		if (ret)
 			pr_err("Failed to set min link dpm level!\n");
@@ -1475,7 +1475,7 @@ static int vega20_overdrive_get_gfx_clk_base_voltage(struct smu_context *smu,
 {
 	int ret;
 
-	ret = smu_send_smc_msg_with_param(smu,
+	ret = smu_send_smc_msg_with_param_unsafe(smu,
 			SMU_MSG_GetAVFSVoltageByDpm,
 			((AVFS_CURVE << 24) | (OD8_HOTCURVE_TEMPERATURE << 16) | freq));
 	if (ret) {
@@ -1956,7 +1956,7 @@ static int vega20_set_power_profile_mode(struct smu_context *smu, long *input, u
 	workload_type = smu_workload_get_type(smu, smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-	smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+	smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type);
 
 	return ret;
@@ -2027,7 +2027,7 @@ vega20_set_uclk_to_highest_dpm_level(struct smu_context *smu,
 		}
 
 		dpm_table->dpm_state.hard_min_level = dpm_table->dpm_levels[dpm_table->count - 1].value;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 				SMU_MSG_SetHardMinByFreq,
 				(PPCLK_UCLK << 16) | dpm_table->dpm_state.hard_min_level);
 		if (ret) {
@@ -2047,7 +2047,7 @@ static int vega20_pre_display_config_changed(struct smu_context *smu)
 	if (!smu->smu_dpm.dpm_context)
 		return -EINVAL;
 
-	smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, 0);
+	smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_NumOfDisplays, 0);
 	ret = vega20_set_uclk_to_highest_dpm_level(smu,
 						   &dpm_table->mem_table);
 	if (ret)
@@ -2072,7 +2072,7 @@ static int vega20_display_config_changed(struct smu_context *smu)
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
-		smu_send_smc_msg_with_param(smu,
+		smu_send_smc_msg_with_param_unsafe(smu,
 					    SMU_MSG_NumOfDisplays,
 					    smu->display_config->num_display);
 	}
@@ -2245,7 +2245,7 @@ vega20_notify_smc_display_config(struct smu_context *smu)
 		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
 		if (!smu_v11_0_display_clock_voltage_request(smu, &clock_req)) {
 			if (smu_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
-				ret = smu_send_smc_msg_with_param(smu,
+				ret = smu_send_smc_msg_with_param_unsafe(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100);
 				if (ret) {
@@ -2260,7 +2260,7 @@ vega20_notify_smc_display_config(struct smu_context *smu)
 
 	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		memtable->dpm_state.hard_min_level = min_clocks.memory_clock/100;
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 						  SMU_MSG_SetHardMinByFreq,
 						  (PPCLK_UCLK << 16) | memtable->dpm_state.hard_min_level);
 		if (ret) {
@@ -2853,7 +2853,7 @@ static int vega20_set_thermal_fan_table(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetFanTemperatureTarget,
+	ret = smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_SetFanTemperatureTarget,
 			(uint32_t)pptable->FanTargetTemperature);
 
 	return ret;
@@ -2864,15 +2864,13 @@ static int vega20_get_fan_speed_rpm(struct smu_context *smu,
 {
 	int ret;
 
-	ret = smu_send_smc_msg(smu, SMU_MSG_GetCurrentRpm);
+	ret = smu_send_smc_msg(smu, SMU_MSG_GetCurrentRpm, speed);
 
 	if (ret) {
 		pr_err("Attempt to get current RPM from SMC Failed!\n");
 		return ret;
 	}
 
-	smu_read_smc_arg(smu, speed);
-
 	return 0;
 }
 
@@ -3137,7 +3135,7 @@ static int vega20_set_df_cstate(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	return smu_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state);
+	return smu_send_smc_msg_with_param_unsafe(smu, SMU_MSG_DFCstateControl, state);
 }
 
 static int vega20_update_pcie_parameters(struct smu_context *smu,
@@ -3153,7 +3151,7 @@ static int vega20_update_pcie_parameters(struct smu_context *smu,
 			((pptable->PcieGenSpeed[i] <= pcie_gen_cap) ? (pptable->PcieGenSpeed[i] << 8) :
 				(pcie_gen_cap << 8)) | ((pptable->PcieLaneCount[i] <= pcie_width_cap) ?
 					pptable->PcieLaneCount[i] : pcie_width_cap);
-		ret = smu_send_smc_msg_with_param(smu,
+		ret = smu_send_smc_msg_with_param_unsafe(smu,
 					  SMU_MSG_OverridePcieParameters,
 					  smu_pcie_arg);
 	}
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
