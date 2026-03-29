Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18833F3D605
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06E110E15B;
	Sun, 29 Mar 2026 16:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZMebswyD";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57CB710E0DB
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 16:03:13 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486fb439299so33256615e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774800192; x=1775404992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A77HKSyVEvzIhfDcYJuYg2owQlydsunwVbhThmPmy6s=;
 b=ZMebswyDQO6fG8bgtALuc9qeRH11gFwv9Fwp5uXBuXcVW32vQWNgGMErFMyjWdozVb
 brouS2jJhxfxV4mAKMRmUhi5BzzKjUnqgwsi3xxb2bOs/ASKLQhzPVxEOVoBWT++G7Uv
 D58ddpZV4r0BQPcuw76fGGImTjw/CQlT9e9QWrJ9R/hml5gJnhegGN55PBBfw2Ba8DkE
 d4YEa29Ow0auJ86b/Zk0EEF+Jt4rG9m/u+YfyPUHckqhQ5D4D6rYluSk+CnL7FB7DFxl
 jJSGJy9oHXH2rAoJG2gSFkm5R49ZrjO31G1rz/O1cPfEUk4qxTpTYy3ROIigk09EkfP5
 hrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774800192; x=1775404992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A77HKSyVEvzIhfDcYJuYg2owQlydsunwVbhThmPmy6s=;
 b=s0uuc4E3R/9WB03UX5HcokscXeFs8FvCOs9NZGIJelPaS6Z9tWjKRjfk4idYsen9wW
 pS/cjVpJocQ/wztm0bX0/Un35x8Yl/Hn6nz8NztwPsW9Y5iWpb+z5WyS5C+BnZrQVn6d
 QCwpTxwvFMmO2ezQHXr0q2z0z7w+QVTy1VEmrqRCr8wkAdrV9fkwnDi+XGPUx+s3yJuH
 lMwxwBx4Y5SdpHdfM7rAAdG3lrIr3mJUlcavUZRTzPYsy7JaDXAOdttIyvJ03pOSQsIV
 ZOaJab3QKBxj8IkwkqN/KKwt+dMD8tu9l/VpZG1kX2pd33iiS0M447BDmlW5CB1zwyTN
 sCjQ==
X-Gm-Message-State: AOJu0YzMgj7ZInwgC0O7i8AJ+4YNUX9Lz+sS8xvzXotGBNQ0ujsHuded
 hxZVFIGntQ4iNkIyJkSJe6rBNY6QpYGSvTS9ql3tmEUjEGrSxvhcqQWsQIdj0g==
X-Gm-Gg: ATEYQzyg2fLGb1e6gHx5daSJOQNDtvte1Hkbw9P+WSd0UAVWbfHTNsko0Cm44XWVMO0
 NEBiAgNz5wml0QLEzeKZF8tIEUZxn55koS+FWKxlGKD1qqvkdeW0UpHgxveo592lGsnslLmUtlu
 D73v5P3V14U5HMkQI4hnysKRiFtL3IiKf01j5XdeoeP2OxYnbmpDHMVF6vD4rZzzg6fCdP6iihW
 q4lej7CZ4+AJFtgPlGO5+3J4K7SqzC15tKAEZ+RWbDPC3Ka7UReNacLdEMj9dYRplOECAwGEtV9
 SVGPFcRGA+HrL22pczUJzvxGHm2Y8ShyCfIjKAXxRYdQCv3QL5aHQVZ2SS0zbJewR942MnX5mAU
 sC5I08S+1GJEMmhgGvOOaFSEvUdx0uNHFBdTv1Ur4wphkKvVD0U2uqlOyGXDZmJOknuD2LuKj7E
 wJHX3XVqogoQRT8U4OjEtOaE2HToMjAzu47LZanaiFxZ7Q9tfVqUoBUJzcYepQN6ed48c=
X-Received: by 2002:a05:600c:1d1e:b0:486:fc95:1a91 with SMTP id
 5b1f17b1804b1-48727f2373dmr158005365e9.12.1774800191753; 
 Sun, 29 Mar 2026 09:03:11 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm217428915e9.12.2026.03.29.09.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 09:03:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/9] drm/amd/pm/smu7: Fix SMU7 voltage dependency on display
 clock
Date: Sun, 29 Mar 2026 18:03:00 +0200
Message-ID: <20260329160306.3417458-4-timur.kristof@gmail.com>
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

The DCE (display controller engine) requires a minimum voltage
in order to function correctly, depending on which clock level
it currently uses.

Add a new table that contains display clock frequency levels
and the corresponding required voltages. The clock frequency
levels are taken from DC (and the old radeon driver's voltage
dependency table for CI in cases where its values were lower).
The voltage levels are taken from the following function:
phm_initializa_dynamic_state_adjustment_rule_settings().
Furthermore, in case of CI, call smu7_patch_vddc() on the new
table to account for leakage voltage (like in radeon).

Use the display clock value from amd_pp_display_configuration
to look up the voltage level needed by the DCE. Send the
voltage to the SMU via the PPSMC_MSG_VddC_Request command.

The previous implementation of this feature was non-functional
because it relied on a "dal_power_level" field which was never
assigned; and it was not at all implemented for CI ASICs.

I verified this on a Radeon R9 M380 which previously booted to
a black screen with DC enabled (default since Linux 6.19), but
now works correctly.

Fixes: 599a7e9fe1b6 ("drm/amd/powerplay: implement smu7 hwmgr to manager asics with smu ip version 7.")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 88 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  1 +
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 2be584aefd0ad..338d651bca4dd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2802,6 +2802,10 @@ static int smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *hwmgr)
 	if (tmp)
 		return -EINVAL;
 
+	tmp = smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_display_clock);
+	if (tmp)
+		return -EINVAL;
+
 	tmp = smu7_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_voltage_dependency_table);
 	if (tmp)
 		return -EINVAL;
@@ -2885,6 +2889,8 @@ static int smu7_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
 {
 	kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
 	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
+	kfree(hwmgr->dyn_state.vddc_dependency_on_display_clock);
+	hwmgr->dyn_state.vddc_dependency_on_display_clock = NULL;
 	kfree(hwmgr->backend);
 	hwmgr->backend = NULL;
 
@@ -2955,6 +2961,51 @@ static int smu7_update_edc_leakage_table(struct pp_hwmgr *hwmgr)
 	return ret;
 }
 
+static int smu7_init_voltage_dependency_on_display_clock_table(struct pp_hwmgr *hwmgr)
+{
+	struct phm_clock_voltage_dependency_table *table;
+
+	if (!amdgpu_device_ip_get_ip_block(hwmgr->adev, AMD_IP_BLOCK_TYPE_DCE))
+		return 0;
+
+	table = kzalloc(struct_size(table, entries, 4), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	if (hwmgr->chip_id >= CHIP_POLARIS10) {
+		table->entries[0].clk = 38918;
+		table->entries[1].clk = 45900;
+		table->entries[2].clk = 66700;
+		table->entries[3].clk = 113200;
+
+		table->entries[0].v = 700;
+		table->entries[1].v = 740;
+		table->entries[2].v = 800;
+		table->entries[3].v = 900;
+	} else {
+		if (hwmgr->chip_family == AMDGPU_FAMILY_CZ) {
+			table->entries[0].clk = 35200;
+			table->entries[1].clk = 35200;
+			table->entries[2].clk = 46700;
+			table->entries[3].clk = 64300;
+		} else {
+			table->entries[0].clk = 0;
+			table->entries[1].clk = 35200;
+			table->entries[2].clk = 54000;
+			table->entries[3].clk = 62500;
+		}
+
+		table->entries[0].v = 0;
+		table->entries[1].v = 720;
+		table->entries[2].v = 810;
+		table->entries[3].v = 900;
+	}
+
+	table->count = 4;
+	hwmgr->dyn_state.vddc_dependency_on_display_clock = table;
+	return 0;
+}
+
 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -2983,6 +3034,10 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 		smu7_get_elb_voltages(hwmgr);
 	}
 
+	result = smu7_init_voltage_dependency_on_display_clock_table(hwmgr);
+	if (result)
+		goto fail;
+
 	if (hwmgr->pp_table_version == PP_TABLE_V1) {
 		smu7_complete_dependency_tables(hwmgr);
 		smu7_set_private_data_based_on_pptable_v1(hwmgr);
@@ -3079,13 +3134,40 @@ static int smu7_force_dpm_highest(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
+static uint32_t smu7_lookup_vddc_from_dispclk(struct pp_hwmgr *hwmgr)
+{
+	const struct amd_pp_display_configuration *cfg = hwmgr->display_config;
+	const struct phm_clock_voltage_dependency_table *vddc_dep_on_dispclk =
+			hwmgr->dyn_state.vddc_dependency_on_display_clock;
+	uint32_t i;
+
+	if (!vddc_dep_on_dispclk || !vddc_dep_on_dispclk->count ||
+	    !cfg || !cfg->num_display || !cfg->display_clk)
+		return 0;
+
+	/* Start from 1 because ClocksStateUltraLow should not be used according to DC. */
+	for (i = 1; i < vddc_dep_on_dispclk->count; ++i)
+		if (vddc_dep_on_dispclk->entries[i].clk >= cfg->display_clk)
+			return vddc_dep_on_dispclk->entries[i].v;
+
+	return vddc_dep_on_dispclk->entries[vddc_dep_on_dispclk->count - 1].v;
+}
+
+static void smu7_apply_minimum_dce_voltage_request(struct pp_hwmgr *hwmgr)
+{
+	uint32_t req_vddc = smu7_lookup_vddc_from_dispclk(hwmgr);
+
+	smum_send_msg_to_smc_with_parameter(hwmgr,
+			PPSMC_MSG_VddC_Request,
+			req_vddc * VOLTAGE_SCALE,
+			NULL);
+}
+
 static int smu7_upload_dpm_level_enable_mask(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
-	if (hwmgr->pp_table_version == PP_TABLE_V1)
-		phm_apply_dal_min_voltage_request(hwmgr);
-/* TO DO  for v0 iceland and Ci*/
+	smu7_apply_minimum_dce_voltage_request(hwmgr);
 
 	if (!data->sclk_dpm_key_disabled) {
 		if (data->dpm_level_enable_mask.sclk_dpm_enable_mask)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index c661185753b42..2f49c95342a14 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -631,6 +631,7 @@ struct phm_dynamic_state_info {
 	struct phm_clock_voltage_dependency_table *vddci_dependency_on_mclk;
 	struct phm_clock_voltage_dependency_table *vddc_dependency_on_mclk;
 	struct phm_clock_voltage_dependency_table *mvdd_dependency_on_mclk;
+	struct phm_clock_voltage_dependency_table *vddc_dependency_on_display_clock;
 	struct phm_clock_voltage_dependency_table *vddc_dep_on_dal_pwrl;
 	struct phm_clock_array                    *valid_sclk_values;
 	struct phm_clock_array                    *valid_mclk_values;
-- 
2.53.0

