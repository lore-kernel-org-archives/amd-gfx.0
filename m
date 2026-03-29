Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EACF3D612
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E939110E1BF;
	Sun, 29 Mar 2026 16:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iRD6Mb3r";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221E710E0DB
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 16:03:14 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48374014a77so43415495e9.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774800193; x=1775404993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWeSV6r0TaMGrtf8bKjfDUHOPvV4EqXmbN0hE+lwTxg=;
 b=iRD6Mb3rTy2+wAmrXfzCvGvCOPJIlqbcVF8Y3K6KAJSZZDiSpvFoUspMM+caByx3Z1
 9LXFj1h0Zgjd7hYdOMacWcvLS68UnI4HrDY7MyXl9YjqJocgxgFfEDfhuPdvrrhPyY6m
 fPmOdXHAfxz6dPKqldijthDw5PmCZBndsQnQNcs57OFpAQJrBNf95JRU+5LxkaDd26Ek
 OfLpqGE+ySUYFoVKC8jmYbT96tjT3PCrFsTmXIhh0PZ4JzM2FcSHgreIjfHelwV3u/Lp
 3XLte8ob5Rhyul8dg+rVLVtIqkoQ9OXo0n+r59Lq34VnTsh2Q3y+AoUU1PYpUCsDXFEt
 NQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774800193; x=1775404993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qWeSV6r0TaMGrtf8bKjfDUHOPvV4EqXmbN0hE+lwTxg=;
 b=L/FP9unQVWYTivK4Yz85htNivmV9SO6aZouW8OVUAqD0x2f9615rUL63x/wXQknIjz
 e2NzAHeGIZmGuQCY/RCNy6/ve/Eh8MrUAGUTBPptMIoxTrAmFfWE1Ux+U4zl5N8aNLyd
 FGAv8HJOn+N5oMzHh9UkJ8+qm2JukyyoVSnlCEvd/iz2be8uLjTwTjZTzwzvRSl45ik8
 w2PUUS6A6II4cseI07lNsQWeoGYenUAA5rTLGQu42f+oxdebUVa4JgzdR1L5WmbqEnei
 YoGNdAXYGfrgyVvtq2sDZrjtoIdivFkdfCgYcvw8yGhYyFKi9vFhmueB/An+YQ+ILZEl
 wAzQ==
X-Gm-Message-State: AOJu0Yw7VXbSwuXMsCB9ORtkEsv0eeNutOZwykeH0w2HOctYuntwt8gT
 Ns9z1+vtjW5hIVA3dg7zfTT0dTECULEYJUFiHQ0cirDtG9otDXM0lJKVLF0b5Q==
X-Gm-Gg: ATEYQzwpSWOBPj/M8TZTM6ZbuWyJPl0SIIv44/j/FMWDw5gNpyzrHfGRHz7+umXKds9
 cNaluiSLFG6SXZfhi1voXD9p7bPP6C1fc3u7UTRLu8Mb9inkoYroRu9SzMogxQ+pN44ef2XP4+o
 sIk6kW7e8LTkAUXiim6JB4f6Fr3bJ4s6GWcDTbRIbJC7/TtolGeWAR7vklgkYwgArLwZcePJs56
 et6KvecebZaLiB3L9BNeKJNGY/0TaYyD5uZLkD8yQLkhTlOA1Qjkc8MkBQaB/cnAR8QvUnfdFuO
 zw0o6aBRx95xhs5hRJHRwPpJnVzBM8dTUijgfST0yC0He7Pd7DOJBANeHkP+YA3++XRr4sFBGJm
 vIPNQvkWCLl3WRXZwqCHbDnoRunoBSJc0MkqVSuBGJj1t27MX/elT3rntvJ1il+5dbct59nL48u
 X4FbPruzTh82a9yfYO3V3D0fktk+vGRHmyakmcYUAEWr3B4iIl3tvDzxQwZ2jELW6cFzs=
X-Received: by 2002:a05:600c:3145:b0:485:ae14:8173 with SMTP id
 5b1f17b1804b1-48727d4593amr164168955e9.1.1774800192542; 
 Sun, 29 Mar 2026 09:03:12 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm217428915e9.12.2026.03.29.09.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 09:03:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/9] drm/amd/pm/smu7: Remove non-functional SMU7 voltage
 dependency on DAL
Date: Sun, 29 Mar 2026 18:03:01 +0200
Message-ID: <20260329160306.3417458-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329160306.3417458-1-timur.kristof@gmail.com>
References: <20260329160306.3417458-1-timur.kristof@gmail.com>
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

It looks like this was written for an old version of DC (DAL)
and was never adapted afterwards. This was non-functional
because it relied on the "dal_power_level" field which was
never assigned anywhere in the code base.

Also, it was not implemented for CI ASICs.

Now superseded by the newer voltage dependency on display
clock table added by the previous commit, let's remove.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  9 --
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 84 -------------------
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.h   |  2 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  1 -
 4 files changed, 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 338d651bca4dd..c357b1f638cfb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2794,10 +2794,6 @@ static int smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *hwmgr)
 	if (tmp)
 		return -EINVAL;
 
-	tmp = smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
-	if (tmp)
-		return -EINVAL;
-
 	tmp = smu7_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency_on_mclk);
 	if (tmp)
 		return -EINVAL;
@@ -2887,8 +2883,6 @@ static int smu7_set_private_data_based_on_pptable_v0(struct pp_hwmgr *hwmgr)
 
 static int smu7_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
 {
-	kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
-	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
 	kfree(hwmgr->dyn_state.vddc_dependency_on_display_clock);
 	hwmgr->dyn_state.vddc_dependency_on_display_clock = NULL;
 	kfree(hwmgr->backend);
@@ -3046,9 +3040,6 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 		smu7_set_private_data_based_on_pptable_v0(hwmgr);
 	}
 
-	/* Initalize Dynamic State Adjustment Rule Settings */
-	result = phm_initializa_dynamic_state_adjustment_rule_settings(hwmgr);
-
 	if (result)
 		goto fail;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index c305ea4ec17d2..5d454b18905ce 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -485,53 +485,6 @@ int phm_get_sclk_for_voltage_evv(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-/**
- * phm_initializa_dynamic_state_adjustment_rule_settings - Initialize Dynamic State Adjustment Rule Settings
- *
- * @hwmgr:  the address of the powerplay hardware manager.
- */
-int phm_initializa_dynamic_state_adjustment_rule_settings(struct pp_hwmgr *hwmgr)
-{
-	struct phm_clock_voltage_dependency_table *table_clk_vlt;
-	struct phm_ppt_v1_information *pptable_info = (struct phm_ppt_v1_information *)(hwmgr->pptable);
-
-	/* initialize vddc_dep_on_dal_pwrl table */
-	table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, 4),
-				GFP_KERNEL);
-
-	if (NULL == table_clk_vlt) {
-		pr_err("Can not allocate space for vddc_dep_on_dal_pwrl! \n");
-		return -ENOMEM;
-	} else {
-		table_clk_vlt->count = 4;
-		table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_ULTRALOW;
-		if (hwmgr->chip_id >= CHIP_POLARIS10 &&
-		    hwmgr->chip_id <= CHIP_VEGAM)
-			table_clk_vlt->entries[0].v = 700;
-		else
-			table_clk_vlt->entries[0].v = 0;
-		table_clk_vlt->entries[1].clk = PP_DAL_POWERLEVEL_LOW;
-		if (hwmgr->chip_id >= CHIP_POLARIS10 &&
-		    hwmgr->chip_id <= CHIP_VEGAM)
-			table_clk_vlt->entries[1].v = 740;
-		else
-			table_clk_vlt->entries[1].v = 720;
-		table_clk_vlt->entries[2].clk = PP_DAL_POWERLEVEL_NOMINAL;
-		if (hwmgr->chip_id >= CHIP_POLARIS10 &&
-		    hwmgr->chip_id <= CHIP_VEGAM)
-			table_clk_vlt->entries[2].v = 800;
-		else
-			table_clk_vlt->entries[2].v = 810;
-		table_clk_vlt->entries[3].clk = PP_DAL_POWERLEVEL_PERFORMANCE;
-		table_clk_vlt->entries[3].v = 900;
-		if (pptable_info != NULL)
-			pptable_info->vddc_dep_on_dal_pwrl = table_clk_vlt;
-		hwmgr->dyn_state.vddc_dep_on_dal_pwrl = table_clk_vlt;
-	}
-
-	return 0;
-}
-
 uint32_t phm_get_lowest_enabled_level(struct pp_hwmgr *hwmgr, uint32_t mask)
 {
 	uint32_t level = 0;
@@ -542,43 +495,6 @@ uint32_t phm_get_lowest_enabled_level(struct pp_hwmgr *hwmgr, uint32_t mask)
 	return level;
 }
 
-void phm_apply_dal_min_voltage_request(struct pp_hwmgr *hwmgr)
-{
-	struct phm_ppt_v1_information *table_info =
-			(struct phm_ppt_v1_information *)hwmgr->pptable;
-	struct phm_clock_voltage_dependency_table *table =
-				table_info->vddc_dep_on_dal_pwrl;
-	struct phm_ppt_v1_clock_voltage_dependency_table *vddc_table;
-	enum PP_DAL_POWERLEVEL dal_power_level = hwmgr->dal_power_level;
-	uint32_t req_vddc = 0, req_volt, i;
-
-	if (!table || table->count <= 0
-		|| dal_power_level < PP_DAL_POWERLEVEL_ULTRALOW
-		|| dal_power_level > PP_DAL_POWERLEVEL_PERFORMANCE)
-		return;
-
-	for (i = 0; i < table->count; i++) {
-		if (dal_power_level == table->entries[i].clk) {
-			req_vddc = table->entries[i].v;
-			break;
-		}
-	}
-
-	vddc_table = table_info->vdd_dep_on_sclk;
-	for (i = 0; i < vddc_table->count; i++) {
-		if (req_vddc <= vddc_table->entries[i].vddc) {
-			req_volt = (((uint32_t)vddc_table->entries[i].vddc) * VOLTAGE_SCALE);
-			smum_send_msg_to_smc_with_parameter(hwmgr,
-					PPSMC_MSG_VddC_Request,
-					req_volt,
-					NULL);
-			return;
-		}
-	}
-	pr_err("DAL requested level can not"
-			" found a available voltage in VDDC DPM Table \n");
-}
-
 int phm_get_voltage_evv_on_sclk(struct pp_hwmgr *hwmgr, uint8_t voltage_type,
 				uint32_t sclk, uint16_t id, uint16_t *voltage)
 {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
index 83b3c9315143e..d370bfd0764d8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
@@ -87,9 +87,7 @@ extern uint16_t phm_find_closest_vddci(struct pp_atomctrl_voltage_table *vddci_t
 extern int phm_find_boot_level(void *table, uint32_t value, uint32_t *boot_level);
 extern int phm_get_sclk_for_voltage_evv(struct pp_hwmgr *hwmgr, phm_ppt_v1_voltage_lookup_table *lookup_table,
 								uint16_t virtual_voltage_id, int32_t *sclk);
-extern int phm_initializa_dynamic_state_adjustment_rule_settings(struct pp_hwmgr *hwmgr);
 extern uint32_t phm_get_lowest_enabled_level(struct pp_hwmgr *hwmgr, uint32_t mask);
-extern void phm_apply_dal_min_voltage_request(struct pp_hwmgr *hwmgr);
 
 extern int phm_get_voltage_evv_on_sclk(struct pp_hwmgr *hwmgr, uint8_t voltage_type,
 				uint32_t sclk, uint16_t id, uint16_t *voltage);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 2f49c95342a14..3ae45eac0c5ca 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -773,7 +773,6 @@ struct pp_hwmgr {
 	const struct pp_smumgr_func *smumgr_funcs;
 	bool is_kicker;
 
-	enum PP_DAL_POWERLEVEL dal_power_level;
 	struct phm_dynamic_state_info dyn_state;
 	const struct pp_hwmgr_func *hwmgr_func;
 	const struct pp_table_func *pptable_func;
-- 
2.53.0

