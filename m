Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3A6D68BF0
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2024 14:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF0710E10F;
	Sat, 16 Nov 2024 14:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HpWW0oUo";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BAB10E10F
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2024 14:02:25 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6d4151971f9so551486d6.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2024 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731765744; x=1732370544; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qE5lu7jzEVnRN82uu+60eJKXmUO6b4KGKYJblEe3AyM=;
 b=HpWW0oUoP6xvZwDW57tAWbdUy2oDgWiqA1NUZQRdIFeAecHC7FhTW5rQPj/2p1nu5A
 MqKBjR064xE7mTeWmtEH0itwWrcTOL4gRlKCKk8D59u1ZiTjWQQBZ0hjY15lWqr2BaWj
 YBKf+rfJZXXVE4y6bPUIPji70OtF6FcfM2IJOO5/DmQqNYwBWsG7vCk7q4p+M8KMARyx
 e0T5H+Fzd57Mmd+q+tAK2k3WISHJAE1PW0H2y9i7eC+GfT8pM8TjBH5LCL5iBIkILiRx
 +ht0zsNL46jGjF+UN8/Y1HlFaMzUNoJy2kBInr+yqCrqlJvUN/Lz8ROd+i3XM6rpgKu7
 OIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731765744; x=1732370544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qE5lu7jzEVnRN82uu+60eJKXmUO6b4KGKYJblEe3AyM=;
 b=KCYqcjp1N/vbkscXTBK8BT9PZ23UbZA2Bk8V81YX1VKvpXPw3kD/vUfODjprfuJRfi
 KZ5tAyneLI3DXfUKH8LPnzRiteGSQTEiRp8TxGeRKV7maucLiUKlIWK05fZfHg/4Fai6
 sldSwEl6Xu0j4NyDJDhnFa963MiojhqQmRsSr77vNUI4Cnj51H8zZ+18U/yZtGMUvA80
 JhEnwKfrkeyLJbI7NDV0QMxyeVXzbKoEvHuD8+qyHmxswHjjIVu5g1USIjLOc0b1yddL
 /H9zAhb2yCUCoPc8aO7/09SkJMp+Bd+nEU2KkmbSCtXBRg0Ksc1xeWQ35pK60rn428Ox
 gXZA==
X-Gm-Message-State: AOJu0YxRdjTy4ngeEDK/FuqCGIJcYq+n6tB4MnHNH9lnpDeEJeIJ9mrM
 h7TvE+hG5Kv8mfhh/DbFJ+PrVtYSSOiPsGXEFBJv3M6Ciicec59tUBUQxUTi
X-Google-Smtp-Source: AGHT+IGWK/s6wvGZJaXXa98PdjzHgoU7J9a20IgXhLi5oow6enlN85cxT3idmf/ZJbz0NyJxEY1tfg==
X-Received: by 2002:a05:622a:12:b0:460:9acd:68be with SMTP id
 d75a77b69052e-46363e0f042mr34541501cf.5.1731765744080; 
 Sat, 16 Nov 2024 06:02:24 -0800 (PST)
Received: from tr4.amd.com (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9eafeesm31759161cf.31.2024.11.16.06.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 06:02:22 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd/pm: correct the workload setting"
Date: Sat, 16 Nov 2024 09:02:08 -0500
Message-ID: <20241116140209.2081056-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 8cc438be5d49b8326b2fcade0bdb7e6a97df9e0b.

The handling in smu_switch_power_profile() is broken for
navi3x which results in the last setting from that always
being set. Since a more extensive fix is available, revert.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3618
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 49 ++++++-------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 20 ++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  5 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  9 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  8 ---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 -
 12 files changed, 36 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c3a6b6f20455..eb1e2473b36a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1270,7 +1270,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->user_dpm_profile.user_workload_mask = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
@@ -1278,26 +1277,20 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
 	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
-		smu->driver_workload_mask =
-			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
-	} else {
-		smu->driver_workload_mask =
-			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
-		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	}
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
+		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+	else
+		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
 
-	smu->workload_mask = smu->driver_workload_mask |
-							smu->user_dpm_profile.user_workload_mask;
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
@@ -2375,20 +2368,17 @@ static int smu_switch_power_profile(void *handle,
 		return -EINVAL;
 
 	if (!en) {
-		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
+		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	} else {
-		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
+		smu->workload_mask |= (1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
 		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	}
 
-	smu->workload_mask = smu->driver_workload_mask |
-						 smu->user_dpm_profile.user_workload_mask;
-
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
 		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, workload, 0);
@@ -3090,23 +3080,12 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
-	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	if (smu->user_dpm_profile.user_workload_mask &
-	   (1 << smu->workload_priority[param[param_size]]))
-	   return 0;
-
-	smu->user_dpm_profile.user_workload_mask =
-		(1 << smu->workload_priority[param[param_size]]);
-	smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
-		smu->driver_workload_mask;
-	ret = smu_bump_power_profile_mode(smu, param, param_size);
-
-	return ret;
+	return smu_bump_power_profile_mode(smu, param, param_size);
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fa93a8879113..06d817fb84aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
-	uint32_t user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -558,8 +557,7 @@ struct smu_context {
 	bool disable_uclk_switch;
 
 	uint32_t workload_mask;
-	uint32_t driver_workload_mask;
-	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
+	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
 	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
 	uint32_t power_profile_mode;
 	uint32_t default_power_profile_mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4b36c230e43a..6c8e80f6b592 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1455,6 +1455,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
+
 	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
 	     (smu->smc_fw_version >= 0x360d00)) {
 		if (size != 10)
@@ -1522,14 +1523,14 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetWorkloadMask,
-					  smu->workload_mask,
+					  1 << workload_type,
 					  NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu_cmn_assign_power_profile(smu);
+	smu->power_profile_mode = profile_mode;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 211635dabed8..faa8e7d9c3c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2083,13 +2083,10 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    smu->workload_mask, NULL);
+				    1 << workload_type, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 844532a9b641..30d050a6e953 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1784,13 +1784,10 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    smu->workload_mask, NULL);
+				    1 << workload_type, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f89c487dce72..cd3e9ba3eff4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1081,7 +1081,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    smu->workload_mask,
+				    1 << workload_type,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
@@ -1089,7 +1089,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 		return ret;
 	}
 
-	smu_cmn_assign_power_profile(smu);
+	smu->power_profile_mode = profile_mode;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 75a9ea87f419..a34797f3576b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -892,14 +892,14 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    smu->workload_mask,
+				    1 << workload_type,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu_cmn_assign_power_profile(smu);
+	smu->power_profile_mode = profile_mode;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 80c6b1e523aa..199bdd9720d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2579,7 +2579,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-	u32 workload_mask;
+	u32 workload_mask, selected_workload_mask;
 
 	smu->power_profile_mode = input[size];
 
@@ -2646,7 +2646,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	workload_mask = 1 << workload_type;
+	selected_workload_mask = workload_mask = 1 << workload_type;
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2661,22 +2661,12 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			workload_mask |= 1 << workload_type;
 	}
 
-	smu->workload_mask |= workload_mask;
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       smu->workload_mask,
+					       workload_mask,
 					       NULL);
-	if (!ret) {
-		smu_cmn_assign_power_profile(smu);
-		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
-			workload_type = smu_cmn_to_asic_specific_index(smu,
-							       CMN2ASIC_MAPPING_WORKLOAD,
-							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
-			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
-										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
-										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-		}
-	}
+	if (!ret)
+		smu->workload_mask = selected_workload_mask;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4fd0354bd312..34c1e0c7e1e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2595,14 +2595,13 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    smu->workload_mask, NULL);
+				    1 << workload_type, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 	else
-		smu_cmn_assign_power_profile(smu);
+		smu->workload_mask = (1 << workload_type);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..884938d69fca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1795,11 +1795,12 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-										  smu->workload_mask, NULL);
-
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetWorkloadMask,
+					       1 << workload_type,
+					       NULL);
 	if (!ret)
-		smu_cmn_assign_power_profile(smu);
+		smu->workload_mask = 1 << workload_type;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a9e69d321f8c..007a81e108ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1144,14 +1144,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
-void smu_cmn_assign_power_profile(struct smu_context *smu)
-{
-	uint32_t index;
-	index = fls(smu->workload_mask);
-	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-	smu->power_profile_mode = smu->workload_setting[index];
-}
-
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 {
 	struct pci_dev *p = NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 8a801e389659..1de685defe85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
-void smu_cmn_assign_power_profile(struct smu_context *smu);
-
 /*
  * Helper function to make sysfs_emit_at() happy. Align buf to
  * the current page boundary and record the offset.
-- 
2.47.0

