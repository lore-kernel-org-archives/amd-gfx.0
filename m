Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E638CD4F57
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC5BA10EC06;
	Tue, 19 May 2026 10:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hITe/o/q";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7940F10EC06
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:35 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488b150559bso25914345e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186094; x=1779790894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISuzfLzxod04mW64mPswgOenYamaSA5mZi+LgMASUEU=;
 b=hITe/o/qUGTl3JzKJeTpZATj12b85TGnbwZe+Z4OGbkRbJDpDM6EIhZ+7kAu5KZCBZ
 5y7txlFJ/4S4y6Six2z3lrRQ3xZAutgg3nZT6vvm3h4It6LGbISzM808uYWorkMSPcQi
 dtAgzzIIM5GgOjehLQcrILjaMNHYw7JUTmbmogm6n3LgcVTmrOUmSaLZInJSm2R0480r
 3kCKfen3Fapbag4HRxAhQyEd991HYPegb3laLsdUEWmKWLEx/usL8eUTUSvZGZg+VfZS
 h11ChpIyo6zsr7hf70msiPfbmL3/ZcAcwdR+pkUZ/p2rF9XnYMAKf5w3fIC/t5kpsSF/
 cLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186094; x=1779790894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ISuzfLzxod04mW64mPswgOenYamaSA5mZi+LgMASUEU=;
 b=g+7AQprtBdkDZSmIisl1xcAaLNXXzv0Wnq7QDWbxx89dTy5Jl9/PrDPdhy0rtRHoOp
 +P7+5bpoR92jGDh1e2+35srVtnqRHhfhLtIr2+UJsyA9Ted8B/DHZFZP83tQTSubbv3k
 f8AxUM/6i9z5KLx7ubqDoBvTOKzZELz1YwSY9HOWWmSl8+j2f0LvxHfRdiYYUgoOhpTc
 q/40CH8Kckkm25JTN7cnNmBD2Q13PiyynVbyTRIw4Wjuq2I+5VWjZOO+JVB1KuxgVial
 JN9fx+G9eWo8dOU0RDRnju7EMzf+fKsxx3z79PBCvpn5fcnrokwwQP+evOqFFhpS+a9y
 mnuA==
X-Gm-Message-State: AOJu0Yxr+ers9tdvPB8+SmlIenxpcDkn6aOlqDavn+poa/4MlYJW/cTI
 mrxwBi/1+vGvl5hoqNeHfLdxlujOmSufDODoefBuMflnuTn1+iCPZ3J+herKjBA0
X-Gm-Gg: Acq92OEbYttEtkOpWWNVSM5JcSYqrXo3OzzKegjtXMxq9a30nbqfhyhJx+HPQtXEs44
 RuOj5vlC1tdpb16ic+NPHl0bHn8cUVktFyZjgQmRvxMFE2p5QcFzi+DkEvOD6Zi4n7djPAN2n/J
 STl2gXOlU3LfHJJmJaWgJ6b5SIszr9EmYVaqj6Qx/FnzvdpfauqEhYeqJ3rBfehepka/MKajbNV
 ykSwKbQSq5AmDyQLOa0KOgMdSVcgVmAff8m/UoTVbKx4Hd3H8SS8g/TQoT6kvPRNt+tOf06/2Y4
 B8UUYgGllJt3MGoGumhjyDszIJvqsidO2Cc4wHzVqWrn72snuYEADcILgGuVNYwwisgcvfOyx26
 lZwegV/AZwaoNP+j6eZ84KMNcg/eKOxkSoXPAyX59PfZg9jvWYUZA7rflmyfAfM90EJt0UydR6w
 ilTIx2hZk6Pf1HaYywP5TfR+gP94wSv6KmXyqxuhVWbI9ladEgarh/Aqi9gzMVOpG9
X-Received: by 2002:a05:600c:4e46:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-48fe632243cmr311389425e9.22.1779186093947; 
 Tue, 19 May 2026 03:21:33 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 12/14] drm/amd/pm: Delete vddc_dep_on_dal_pwrl
Date: Tue, 19 May 2026 12:21:16 +0200
Message-ID: <20260519102118.246466-13-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519102118.246466-1-timur.kristof@gmail.com>
References: <20260519102118.246466-1-timur.kristof@gmail.com>
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
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/pm/powerplay/hwmgr/processpptables.c  |  1 -
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 41 ------------------
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 42 -------------------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  3 --
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 -
 5 files changed, 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index f06b29e33ba4..00e8f1be87e7 100644
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
index 5be6f82ecc6f..f5c1f483dec8 100644
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
index 8a37c745cb11..63a1e3748e5c 100644
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
index 12f47ec87997..8b8c4e899878 100644
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
index 3ae45eac0c5c..1ee7e3044272 100644
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
2.54.0

