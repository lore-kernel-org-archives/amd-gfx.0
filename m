Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEEBF3D613
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72D410E17C;
	Sun, 29 Mar 2026 16:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IV5d+7aC";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4645310E13D
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 16:03:18 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so30874115e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774800197; x=1775404997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJfZ7CCE5q2iTAhjxTP/T/7dBRGKxuiOWwq/v7Zqd2Y=;
 b=IV5d+7aCuvij4JmriLPVwqYgkOc0CVhOfmHxF2BRkzE2XXRr/kOMbX0PYCbglByHqT
 A4s79vuP1O7Pc0Pbn3O9xaP0uKsVEZ3Zv+Vylj7ZCY2v2Zsy0goFMRrw/H2zsHl/oOWv
 SOa9aqywbamnwhRiKP6gVkAblkR5H0oqd/jisa/XehkOJJCjZJ9enS8FHovShOrTSVYq
 WARoc5GB9fseKxDrGL9dkf8P8H9Ds0KJs7dQAt7mhMjPjO+QBwGTIuDdEOgfLdhpDQk2
 /n9ONmx3n7s2ytyG6gfgLvqatqsMhIU1iyI9q+N1DzMrPl/PaSCaKV/a3mIlWwJ7OFWJ
 OB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774800197; x=1775404997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jJfZ7CCE5q2iTAhjxTP/T/7dBRGKxuiOWwq/v7Zqd2Y=;
 b=NczEF+hWbZv1nxW9uTZOh+IVIErjB5kExO61VhOln9UAVnuSK9pMVDoWl9jGh92PMU
 +FDRF6TraQ9DLRhnMz7pgYN48EWBmn/tUYo+29SaA76ghBNScGjp1jBclkl9aSXDYs2E
 eg1hePnChE2Jb8JxumgrcSSaSDTroiH0UvJ210O/RmOeJq/yIJbtYFSI+GuvKuZi+56A
 O77uGriWYNsTmUTW+KxWeIPWELDD57vLpU79OW/xm6zy18/6YRuDGXnWQpwYN9VKn2zS
 M1y9tW4bxRORJz7VptY+6pKsbpEOMpaxhg/sL0hCso851T0X4x9FWw7Jn9lya3fFaSS/
 WhGw==
X-Gm-Message-State: AOJu0YxF5QLEyZGenA1c7e1RoUUjQdMxf2GjhpWza39Pq4nCgHOl1WrB
 qXLY2n8LerCQVNyszdFnHoS/etFK/KtsccgC2UTxVPVLZaF9ly59d069ccdD7g==
X-Gm-Gg: ATEYQzztIXlXKUP7JjjvGoYZ//3PdzYdrI3R4fvtvefIXXRjn7DQWpVRia6ID9KUhDI
 d5HNaIYvyPkn/3nMFoaI/20oaa0GkuiO9Mhy/EbN5unkZamyesSCVwdF4QpetjEXhfynbATM3Lo
 s+Yi+Lo8lUs/x/fsGJhYo0SLIirKCf293wtP9EErIkAzTWWdSrsGFIFSzRi9LGpTvB18EC377fd
 YoJkpbbA0pheDzZO7fWl2jOWI9U6t5M/k9ibpwbE7mA6tQ9LplVexJ/s6kYazK5I7Y8bJeYByo7
 sJ+bZEfJ3fqMnfsURXV6+6jf1a1ZV042EuwKafppNDVLcTvraDph2LSfB0WD0w+GP73urkj1N4U
 K8ejE5YIb2Dzef4A/RaHDgR5IGVPkqfDmEezLbLdr01MAEd+46p6djSXbl3MIjcmS6juX1I5dbb
 ssZ1tQ7DucAUyT5Ri1WdU8TCU3EHVHXGHkGO45GOT3A6y0SaRvmDx2wmxWTa6jnLoMmQE=
X-Received: by 2002:a05:600d:7:b0:485:439b:683f with SMTP id
 5b1f17b1804b1-48727f5fe73mr126077325e9.20.1774800196500; 
 Sun, 29 Mar 2026 09:03:16 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm217428915e9.12.2026.03.29.09.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 09:03:16 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 8/9] drm/amd/pm/smu7: Add SCLK cap for quirky Hawaii board
Date: Sun, 29 Mar 2026 18:03:05 +0200
Message-ID: <20260329160306.3417458-9-timur.kristof@gmail.com>
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

On a specific Radeon R9 390X board, the GPU can "randomly" hang
while gaming. Initially I thought this was a RADV bug and tried
to work around this in Mesa:
commit 8ea08747b86b ("radv: Mitigate GPU hang on Hawaii in Dota 2 and RotTR")

However, I got some feedback from other users who are reporting
that the above mitigation causes a significant performance
regression for them, and they didn't experience the hang on their
GPU in the first place.

After some further investigation, it turns out that the problem
is that the highest SCLK DPM level on this board isn't stable.
Lowering SCLK to 1040 MHz (from 1070 MHz) works around the issue,
and has a negligible impact on performance compared to the Mesa
patch. (Note that increasing the voltage can also work around it,
but we felt that lowering the SCLK is the safer option.)

To solve the above issue, add an "sclk_cap" field to smu7_hwmgr
and set this field for the affected board. The capped SCLK value
correctly appears on the sysfs interface and shows up in GUI
tools such as LACT.

Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (v3)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 30 ++++++++++++++++---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h   |  1 +
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index c357b1f638cfb..1381902547b8e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -787,7 +787,7 @@ static int smu7_setup_dpm_tables_v0(struct pp_hwmgr *hwmgr)
 		hwmgr->dyn_state.vddc_dependency_on_mclk;
 	struct phm_cac_leakage_table *std_voltage_table =
 		hwmgr->dyn_state.cac_leakage_table;
-	uint32_t i;
+	uint32_t i, clk;
 
 	PP_ASSERT_WITH_CODE(allowed_vdd_sclk_table != NULL,
 		"SCLK dependency table is missing. This table is mandatory", return -EINVAL);
@@ -804,10 +804,12 @@ static int smu7_setup_dpm_tables_v0(struct pp_hwmgr *hwmgr)
 	data->dpm_table.sclk_table.count = 0;
 
 	for (i = 0; i < allowed_vdd_sclk_table->count; i++) {
+		clk = min(allowed_vdd_sclk_table->entries[i].clk, data->sclk_cap);
+
 		if (i == 0 || data->dpm_table.sclk_table.dpm_levels[data->dpm_table.sclk_table.count-1].value !=
-				allowed_vdd_sclk_table->entries[i].clk) {
+				clk) {
 			data->dpm_table.sclk_table.dpm_levels[data->dpm_table.sclk_table.count].value =
-				allowed_vdd_sclk_table->entries[i].clk;
+				clk;
 			data->dpm_table.sclk_table.dpm_levels[data->dpm_table.sclk_table.count].enabled = (i == 0) ? 1 : 0;
 			data->dpm_table.sclk_table.count++;
 		}
@@ -3000,6 +3002,25 @@ static int smu7_init_voltage_dependency_on_display_clock_table(struct pp_hwmgr *
 	return 0;
 }
 
+static void smu7_set_sclk_cap(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+
+	data->sclk_cap = 0xffffffff;
+
+	if (hwmgr->od_enabled)
+		return;
+
+	/* R9 390X board: last sclk dpm level is unstable, use lower sclk */
+	if (adev->pdev->device == 0x67B0 &&
+	    adev->pdev->subsystem_vendor == 0x1043)
+		data->sclk_cap = 104000; /* 1040 MHz */
+
+	if (data->sclk_cap != 0xffffffff)
+		dev_info(adev->dev, "sclk cap: %u kHz on quirky ASIC\n", data->sclk_cap * 10);
+}
+
 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
@@ -3011,6 +3032,7 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 		return -ENOMEM;
 
 	hwmgr->backend = data;
+	smu7_set_sclk_cap(hwmgr);
 	smu7_patch_voltage_workaround(hwmgr);
 	smu7_init_dpm_defaults(hwmgr);
 
@@ -3894,7 +3916,7 @@ static int smu7_get_pp_table_entry_callback_func_v0(struct pp_hwmgr *hwmgr,
 
 	/* Performance levels are arranged from low to high. */
 	performance_level->memory_clock = memory_clock;
-	performance_level->engine_clock = engine_clock;
+	performance_level->engine_clock = min(engine_clock, data->sclk_cap);
 
 	pcie_gen_from_bios = visland_clk_info->ucPCIEGen;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
index d9e8b386bd4d3..66adabeab6a3a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
@@ -234,6 +234,7 @@ struct smu7_hwmgr {
 	uint32_t                       pcie_gen_cap;
 	uint32_t                       pcie_lane_cap;
 	uint32_t                       pcie_spc_cap;
+	uint32_t                       sclk_cap;
 	struct smu7_leakage_voltage          vddc_leakage;
 	struct smu7_leakage_voltage          vddci_leakage;
 	struct smu7_leakage_voltage          vddcgfx_leakage;
-- 
2.53.0

