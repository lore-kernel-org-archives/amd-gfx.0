Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D4BFDEE49
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1168810F28E;
	Thu, 23 Apr 2026 19:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I7bFMAdI";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AB310F277
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:36 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so5671762f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971735; x=1777576535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkt+meR35qOpfmv/XBiGbtdlB8qrG4AV25OoEGjFrN0=;
 b=I7bFMAdIPjemnE9EmNmbu+sQVB+XGIbmLxusBcpcW4QYJckADIjTWu0oodOieCGh6R
 jMwnf12cs6eb4XuXSZneS8QgCaurpdVXFiSeZ+czBmX2yHWlYORxMgkrSHqOQJyoXJMO
 HIkf6fVj2aYkMCCsuUQb+7nrR2DXr/fNV9RJXaqEGNQtQhhcQ+xu88TZpXb7OroEJGlG
 CMnkQVvL7Fyuy9etEeXFzzO1+tdIBRSFJcTQV/tUbN6uEY3emlSlhZSBxTZp/FgCEhX0
 ewV/qhHFz+7Qw9dEuV4QO0x+vYtotZaMJMNubHIxAIgTBWWbFdD7UDcy3D7QYC3IWJ0n
 5kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971735; x=1777576535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kkt+meR35qOpfmv/XBiGbtdlB8qrG4AV25OoEGjFrN0=;
 b=D5mBIkTIDhtQxMC0e7wzc8MDxdRDLIm2pPTWK8WhaXp+Xrxlhf4pyMIdBlftyoklBs
 avLHOH1iFcwXjYCuZqNE0VlQNTYc3tX4UZ3Om5fE5hrS5exFeMOS34uA5KBnWXO5/B/w
 MFxhkZfdTpS+6RBRcplkrXhT6FKM2OiKQT/cZs6tgDfyy9x7qE+bkz0uDlL3coZcqOt1
 rY+Qma254FTEOoMzApQabPRTROxX0NkkKz25gu1eqyUgbxgKxEvSgnV2EeMdNiJq1sqL
 bLQ2Y8n21y+6HGCXixhhk5HuoPkLhL5QaGnEMyNVkD/tZ0NsHlVwim9AcnE/Q03zDlvY
 Q6wg==
X-Gm-Message-State: AOJu0YzhCaSDSCbXZqjQ5vWjfKCPsupo8IZ7DhLQ83Bt1aphxu+t0CGc
 gtusjsVGJY4iBIDebmQzbRgkWNdOGkyFGdZxqSjVTKKtDbf68hhBvl/n1GogdWlU
X-Gm-Gg: AeBDiesLliUaW0xJsC+q1W+FXMiy+coBP1gxs5Ns0wYogFHqh79ny13F/9WBO8IQTd7
 BkYo1FPb9IGbUs+kAlJxzaFkeOe6pYDeNCy5xF86AWsyQlxOP5RqtrJlUvLVNvsyLfkXGEhxrMK
 JQjyVz/cnDtqUlPv7hqQbvmAF2Ju17lbArOo5sizdhVH8vOcRHqbtCQfwrL18Q1bU7/dS0EYl9j
 IhUPtWZRO+qLNyRVKXwhB9584IthIV3IAmiV/+eREzg3wDxRvlz2DtdKmHLSHa6qKdzytUT8ncG
 nVJtsZwE5wR5dAo5+4aGg++MlFUir+4RbMuDzdbsYJ7lds/ufmVmHb/ME/XirqTOaSZW3ptkL+B
 1pqqhfZisQpFhMFq64Iq9aQSqqGbBAoZMsBOxcMCBOtI86SCjGUfkpd73gCDUpdgdOxg/gUYwsJ
 2xmBVcUxlwjAu5dS/GHZ18PrPjWHuQy5yVWngsT/B3uO1KrJDfk8UNKtK2zZBrH9L+n9u6JpfC6
 iKOqg==
X-Received: by 2002:a5d:5d0e:0:b0:43d:7883:87c4 with SMTP id
 ffacd0b85a97d-43fe3e17215mr45064555f8f.41.1776971735003; 
 Thu, 23 Apr 2026 12:15:35 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:34 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 12/14] drm/amd/pm: Delete vddc_dep_on_dal_pwrl
Date: Thu, 23 Apr 2026 21:15:17 +0200
Message-ID: <20260423191519.73127-13-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423191519.73127-1-timur.kristof@gmail.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It was not used by anything anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/pm/powerplay/hwmgr/processpptables.c  |  1 -
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 41 ------------------
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 42 -------------------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  3 --
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 -
 5 files changed, 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index f06b29e33ba45..00e8f1be87e76 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1324,7 +1324,6 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
 	hwmgr->dyn_state.vddc_dependency_on_sclk = NULL;
 	hwmgr->dyn_state.vddci_dependency_on_mclk = NULL;
 	hwmgr->dyn_state.vddc_dependency_on_mclk = NULL;
-	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
 	hwmgr->dyn_state.mvdd_dependency_on_mclk = NULL;
 	hwmgr->dyn_state.vce_clock_voltage_dependency_table = NULL;
 	hwmgr->dyn_state.uvd_clock_voltage_dependency_table = NULL;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 5be6f82ecc6f5..f5c1f483dec87 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -127,42 +127,6 @@ static int smu10_construct_max_power_limits_table(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-static int smu10_init_dynamic_state_adjustment_rule_settings(
-							struct pp_hwmgr *hwmgr)
-{
-	int count = 8;
-	struct phm_clock_voltage_dependency_table *table_clk_vlt;
-
-	table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, count),
-				GFP_KERNEL);
-
-	if (NULL == table_clk_vlt) {
-		pr_err("Can not allocate memory!\n");
-		return -ENOMEM;
-	}
-
-	table_clk_vlt->count = count;
-	table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_0;
-	table_clk_vlt->entries[0].v = 0;
-	table_clk_vlt->entries[1].clk = PP_DAL_POWERLEVEL_1;
-	table_clk_vlt->entries[1].v = 1;
-	table_clk_vlt->entries[2].clk = PP_DAL_POWERLEVEL_2;
-	table_clk_vlt->entries[2].v = 2;
-	table_clk_vlt->entries[3].clk = PP_DAL_POWERLEVEL_3;
-	table_clk_vlt->entries[3].v = 3;
-	table_clk_vlt->entries[4].clk = PP_DAL_POWERLEVEL_4;
-	table_clk_vlt->entries[4].v = 4;
-	table_clk_vlt->entries[5].clk = PP_DAL_POWERLEVEL_5;
-	table_clk_vlt->entries[5].v = 5;
-	table_clk_vlt->entries[6].clk = PP_DAL_POWERLEVEL_6;
-	table_clk_vlt->entries[6].v = 6;
-	table_clk_vlt->entries[7].clk = PP_DAL_POWERLEVEL_7;
-	table_clk_vlt->entries[7].v = 7;
-	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = table_clk_vlt;
-
-	return 0;
-}
-
 static int smu10_get_system_info_data(struct pp_hwmgr *hwmgr)
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)hwmgr->backend;
@@ -176,8 +140,6 @@ static int smu10_get_system_info_data(struct pp_hwmgr *hwmgr)
 	smu10_construct_max_power_limits_table (hwmgr,
 				    &hwmgr->dyn_state.max_clock_voltage_on_ac);
 
-	smu10_init_dynamic_state_adjustment_rule_settings(hwmgr);
-
 	return 0;
 }
 
@@ -612,9 +574,6 @@ static int smu10_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
 	kfree(pinfo->vdd_dep_on_phyclk);
 	pinfo->vdd_dep_on_phyclk = NULL;
 
-	kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
-	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
-
 	kfree(hwmgr->backend);
 	hwmgr->backend = NULL;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 8a37c745cb117..63a1e3748e5cd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -270,42 +270,6 @@ static int smu8_construct_max_power_limits_table(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-static int smu8_init_dynamic_state_adjustment_rule_settings(
-			struct pp_hwmgr *hwmgr,
-			ATOM_CLK_VOLT_CAPABILITY *disp_voltage_table)
-{
-	struct phm_clock_voltage_dependency_table *table_clk_vlt;
-
-	table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, 8),
-				GFP_KERNEL);
-
-	if (NULL == table_clk_vlt) {
-		pr_err("Can not allocate memory!\n");
-		return -ENOMEM;
-	}
-
-	table_clk_vlt->count = 8;
-	table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_0;
-	table_clk_vlt->entries[0].v = 0;
-	table_clk_vlt->entries[1].clk = PP_DAL_POWERLEVEL_1;
-	table_clk_vlt->entries[1].v = 1;
-	table_clk_vlt->entries[2].clk = PP_DAL_POWERLEVEL_2;
-	table_clk_vlt->entries[2].v = 2;
-	table_clk_vlt->entries[3].clk = PP_DAL_POWERLEVEL_3;
-	table_clk_vlt->entries[3].v = 3;
-	table_clk_vlt->entries[4].clk = PP_DAL_POWERLEVEL_4;
-	table_clk_vlt->entries[4].v = 4;
-	table_clk_vlt->entries[5].clk = PP_DAL_POWERLEVEL_5;
-	table_clk_vlt->entries[5].v = 5;
-	table_clk_vlt->entries[6].clk = PP_DAL_POWERLEVEL_6;
-	table_clk_vlt->entries[6].v = 6;
-	table_clk_vlt->entries[7].clk = PP_DAL_POWERLEVEL_7;
-	table_clk_vlt->entries[7].v = 7;
-	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = table_clk_vlt;
-
-	return 0;
-}
-
 static int smu8_get_system_info_data(struct pp_hwmgr *hwmgr)
 {
 	struct smu8_hwmgr *data = hwmgr->backend;
@@ -404,9 +368,6 @@ static int smu8_get_system_info_data(struct pp_hwmgr *hwmgr)
 	smu8_construct_max_power_limits_table (hwmgr,
 				    &hwmgr->dyn_state.max_clock_voltage_on_ac);
 
-	smu8_init_dynamic_state_adjustment_rule_settings(hwmgr,
-				    &info->sDISPCLK_Voltage[0]);
-
 	return result;
 }
 
@@ -1150,9 +1111,6 @@ static int smu8_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 static int smu8_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
 {
 	if (hwmgr != NULL) {
-		kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
-		hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
-
 		kfree(hwmgr->backend);
 		hwmgr->backend = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 12f47ec87997d..8b8c4e8998784 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -814,9 +814,6 @@ static int vega10_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr)
 
 static int vega10_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
 {
-	kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
-	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
-
 	kfree(hwmgr->backend);
 	hwmgr->backend = NULL;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 3ae45eac0c5ca..1ee7e3044272d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -540,7 +540,6 @@ struct phm_ppt_v1_information {
 	struct phm_clock_array *valid_dcefclk_values;
 	struct phm_clock_and_voltage_limits max_clock_voltage_on_dc;
 	struct phm_clock_and_voltage_limits max_clock_voltage_on_ac;
-	struct phm_clock_voltage_dependency_table *vddc_dep_on_dal_pwrl;
 	struct phm_ppm_table *ppm_parameter_table;
 	struct phm_cac_tdp_table *cac_dtp_table;
 	struct phm_tdp_table *tdp_table;
@@ -632,7 +631,6 @@ struct phm_dynamic_state_info {
 	struct phm_clock_voltage_dependency_table *vddc_dependency_on_mclk;
 	struct phm_clock_voltage_dependency_table *mvdd_dependency_on_mclk;
 	struct phm_clock_voltage_dependency_table *vddc_dependency_on_display_clock;
-	struct phm_clock_voltage_dependency_table *vddc_dep_on_dal_pwrl;
 	struct phm_clock_array                    *valid_sclk_values;
 	struct phm_clock_array                    *valid_mclk_values;
 	struct phm_clock_and_voltage_limits       max_clock_voltage_on_dc;
-- 
2.53.0

