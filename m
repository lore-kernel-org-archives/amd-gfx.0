Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACB7C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC08F10EA2B;
	Fri, 27 Jun 2025 14:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="URYbBPpg";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B4F10EA46
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:34:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4C53F5C6984;
 Fri, 27 Jun 2025 14:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97034C4CEE3;
 Fri, 27 Jun 2025 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751034878;
 bh=TFfXfbGGeKlnoO7bjPLlVC9fvAMdMeEQnxQNp4YvYsY=;
 h=From:To:Cc:Subject:Date:From;
 b=URYbBPpgI7z22EFs7yUmePMlQc9SzCBbHneFw6LkRKLfjH/Bn9SZCRq8tBeHbdvja
 lNfsc7VZ20fp9+y4bfN9hlgbw/FbG/WYx6jbRR34b2uclM6w9luw7KojBtodAbnTEv
 N938Px9UwnbWTO+8JQXJ6UdF4opEW1v6NnuFXfgRg9tlEoWnpGnh5TiZmyYj+MraR/
 ECSuJULYtv7BYBX6CKsMuobcVAU45zewReYw10KLS92zeXRdwWuQ0MCPUaNKF/hwb9
 zKSc3jRCvzPriJrL3JCocJg0ThMPh+m4reIcuG3gFb5B7UAKNleOe3O/Q9+nudziK0
 K6Eela0XLXeyg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
Subject: [PATCH v3 1/3] drm/amd: Decrease message level for legacy-pm,
 kv-dpm and si-dpm
Date: Fri, 27 Jun 2025 09:34:30 -0500
Message-ID: <20250627143432.3222843-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

legacy-pm, kv-dpm and si-dpm have prints while changing power states
that don't have a level and thus are printed by default. These are
not useful at runtime for most people, so decrease them to debug.

Reported-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4322
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Rename functions to include 'dbg' in the name (Lijo)
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 16 ++--
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 92 +++++++------------
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h    |  7 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 10 +-
 4 files changed, 50 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 34e71727b27d7..5d0b18062b8c1 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -2886,16 +2886,18 @@ kv_dpm_print_power_state(void *handle, void *request_ps)
 	struct kv_ps *ps = kv_get_ps(rps);
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_dpm_print_class_info(rps->class, rps->class2);
-	amdgpu_dpm_print_cap_info(rps->caps);
-	printk("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
+	amdgpu_dpm_dbg_print_class_info(adev, rps->class, rps->class2);
+	amdgpu_dpm_dbg_print_cap_info(adev, rps->caps);
+	drm_dbg(adev_to_drm(adev), "vclk: %d, dclk: %d\n",
+		rps->vclk, rps->dclk);
 	for (i = 0; i < ps->num_levels; i++) {
 		struct kv_pl *pl = &ps->levels[i];
-		printk("\t\tpower level %d    sclk: %u vddc: %u\n",
-		       i, pl->sclk,
-		       kv_convert_8bit_index_to_voltage(adev, pl->vddc_index));
+		drm_dbg(adev_to_drm(adev),
+			"power level %d    sclk: %u vddc: %u\n",
+			i, pl->sclk,
+			kv_convert_8bit_index_to_voltage(adev, pl->vddc_index));
 	}
-	amdgpu_dpm_print_ps_status(adev, rps);
+	amdgpu_dpm_dbg_print_ps_status(adev, rps);
 }
 
 static void kv_dpm_fini(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index c7518b13e7879..2492d9a31bdfa 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -47,7 +47,7 @@
 #define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
 		((adev)->powerplay.pp_funcs->check_state_equal((adev)->powerplay.pp_handle, (cps), (rps), (equal)))
 
-void amdgpu_dpm_print_class_info(u32 class, u32 class2)
+void amdgpu_dpm_dbg_print_class_info(struct amdgpu_device *adev, u32 class, u32 class2)
 {
 	const char *s;
 
@@ -66,71 +66,45 @@ void amdgpu_dpm_print_class_info(u32 class, u32 class2)
 		s = "performance";
 		break;
 	}
-	printk("\tui class: %s\n", s);
-	printk("\tinternal class:");
+	drm_dbg(adev_to_drm(adev), "\tui class: %s\n", s);
 	if (((class & ~ATOM_PPLIB_CLASSIFICATION_UI_MASK) == 0) &&
 	    (class2 == 0))
-		pr_cont(" none");
-	else {
-		if (class & ATOM_PPLIB_CLASSIFICATION_BOOT)
-			pr_cont(" boot");
-		if (class & ATOM_PPLIB_CLASSIFICATION_THERMAL)
-			pr_cont(" thermal");
-		if (class & ATOM_PPLIB_CLASSIFICATION_LIMITEDPOWERSOURCE)
-			pr_cont(" limited_pwr");
-		if (class & ATOM_PPLIB_CLASSIFICATION_REST)
-			pr_cont(" rest");
-		if (class & ATOM_PPLIB_CLASSIFICATION_FORCED)
-			pr_cont(" forced");
-		if (class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE)
-			pr_cont(" 3d_perf");
-		if (class & ATOM_PPLIB_CLASSIFICATION_OVERDRIVETEMPLATE)
-			pr_cont(" ovrdrv");
-		if (class & ATOM_PPLIB_CLASSIFICATION_UVDSTATE)
-			pr_cont(" uvd");
-		if (class & ATOM_PPLIB_CLASSIFICATION_3DLOW)
-			pr_cont(" 3d_low");
-		if (class & ATOM_PPLIB_CLASSIFICATION_ACPI)
-			pr_cont(" acpi");
-		if (class & ATOM_PPLIB_CLASSIFICATION_HD2STATE)
-			pr_cont(" uvd_hd2");
-		if (class & ATOM_PPLIB_CLASSIFICATION_HDSTATE)
-			pr_cont(" uvd_hd");
-		if (class & ATOM_PPLIB_CLASSIFICATION_SDSTATE)
-			pr_cont(" uvd_sd");
-		if (class2 & ATOM_PPLIB_CLASSIFICATION2_LIMITEDPOWERSOURCE_2)
-			pr_cont(" limited_pwr2");
-		if (class2 & ATOM_PPLIB_CLASSIFICATION2_ULV)
-			pr_cont(" ulv");
-		if (class2 & ATOM_PPLIB_CLASSIFICATION2_MVC)
-			pr_cont(" uvd_mvc");
-	}
-	pr_cont("\n");
+		drm_dbg(adev_to_drm(adev), "\tinternal class: none\n");
+	else
+		drm_dbg(adev_to_drm(adev), "\tinternal class: %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+			(class & ATOM_PPLIB_CLASSIFICATION_BOOT) ? " boot" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_THERMAL) ? " thermal" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_LIMITEDPOWERSOURCE) ? " limited_pwr" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_REST) ? " rest" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_FORCED) ? " forced" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE) ? " 3d_perf" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_OVERDRIVETEMPLATE) ? " ovrdrv" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_UVDSTATE) ? " uvd" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_3DLOW) ? " 3d_low" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_ACPI) ? " acpi" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_HD2STATE) ? " uvd_hd2" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_HDSTATE) ? " uvd_hd" : "",
+			(class & ATOM_PPLIB_CLASSIFICATION_SDSTATE) ? " uvd_sd" : "",
+			(class2 & ATOM_PPLIB_CLASSIFICATION2_LIMITEDPOWERSOURCE_2) ? " limited_pwr2" : "",
+			(class2 & ATOM_PPLIB_CLASSIFICATION2_ULV) ? " ulv" : "",
+			(class2 & ATOM_PPLIB_CLASSIFICATION2_MVC) ? " uvd_mvc" : "");
 }
 
-void amdgpu_dpm_print_cap_info(u32 caps)
+void amdgpu_dpm_dbg_print_cap_info(struct amdgpu_device *adev, u32 caps)
 {
-	printk("\tcaps:");
-	if (caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY)
-		pr_cont(" single_disp");
-	if (caps & ATOM_PPLIB_SUPPORTS_VIDEO_PLAYBACK)
-		pr_cont(" video");
-	if (caps & ATOM_PPLIB_DISALLOW_ON_DC)
-		pr_cont(" no_dc");
-	pr_cont("\n");
+	drm_dbg(adev_to_drm(adev), "\tcaps: %s%s%s\n",
+		(caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) ? " single_disp" : "",
+		(caps & ATOM_PPLIB_SUPPORTS_VIDEO_PLAYBACK) ? " video" : "",
+		(caps & ATOM_PPLIB_DISALLOW_ON_DC) ? " no_dc" : "");
 }
 
-void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
+void amdgpu_dpm_dbg_print_ps_status(struct amdgpu_device *adev,
 				struct amdgpu_ps *rps)
 {
-	printk("\tstatus:");
-	if (rps == adev->pm.dpm.current_ps)
-		pr_cont(" c");
-	if (rps == adev->pm.dpm.requested_ps)
-		pr_cont(" r");
-	if (rps == adev->pm.dpm.boot_ps)
-		pr_cont(" b");
-	pr_cont("\n");
+	drm_dbg(adev_to_drm(adev), "\tstatus:%s%s%s\n",
+		rps == adev->pm.dpm.current_ps ? " c" : "",
+		rps == adev->pm.dpm.requested_ps ? " r" : "",
+		rps == adev->pm.dpm.boot_ps ? " b" : "");
 }
 
 void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
@@ -943,9 +917,9 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	if (amdgpu_dpm == 1 && pp_funcs->print_power_state) {
-		printk("switching from power state:\n");
+		drm_dbg(adev_to_drm(adev), "switching from power state\n");
 		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
-		printk("switching to power state:\n");
+		drm_dbg(adev_to_drm(adev), "switching to power state\n");
 		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.requested_ps);
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
index 93bd3973330cd..7120eef305092 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
@@ -23,10 +23,9 @@
 #ifndef __LEGACY_DPM_H__
 #define __LEGACY_DPM_H__
 
-void amdgpu_dpm_print_class_info(u32 class, u32 class2);
-void amdgpu_dpm_print_cap_info(u32 caps);
-void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
-				struct amdgpu_ps *rps);
+void amdgpu_dpm_dbg_print_class_info(struct amdgpu_device *adev, u32 class, u32 class2);
+void amdgpu_dpm_dbg_print_cap_info(struct amdgpu_device *adev, u32 caps);
+void amdgpu_dpm_dbg_print_ps_status(struct amdgpu_device *adev, struct amdgpu_ps *rps);
 int amdgpu_get_platform_caps(struct amdgpu_device *adev);
 int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
 void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 4c0e976004ba4..52e732be59e36 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7951,15 +7951,15 @@ static void si_dpm_print_power_state(void *handle,
 	struct rv7xx_pl *pl;
 	int i;
 
-	amdgpu_dpm_print_class_info(rps->class, rps->class2);
-	amdgpu_dpm_print_cap_info(rps->caps);
-	DRM_INFO("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
+	amdgpu_dpm_dbg_print_class_info(adev, rps->class, rps->class2);
+	amdgpu_dpm_dbg_print_cap_info(adev, rps->caps);
+	drm_dbg(adev_to_drm(adev), "\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
 	for (i = 0; i < ps->performance_level_count; i++) {
 		pl = &ps->performance_levels[i];
-		DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
+		drm_dbg(adev_to_drm(adev), "\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
 			 i, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
 	}
-	amdgpu_dpm_print_ps_status(adev, rps);
+	amdgpu_dpm_dbg_print_ps_status(adev, rps);
 }
 
 static int si_dpm_early_init(struct amdgpu_ip_block *ip_block)
-- 
2.43.0

