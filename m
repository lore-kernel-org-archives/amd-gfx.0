Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3EBCC6B2F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8DE112170;
	Thu, 15 Oct 2026 08:01:37 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A03F112173
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 08:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnxxJvs2IPn82hy/xZaDb1e0vfr0Na9Ch+lZsRulyHhbSHP2PD/A1kGYzTsnVT19js0QynSSAEJoPCmWhsfeYvlK8S7G4D8B/+F5nVLwSVFCcetDDSKZPkV2L4xstGZ8TMBf/dcsax4XAB4RRwjvmgApWT1aFRK9ROyvrngHgFxtS98FnU1rPsi1FM/DdPN/myv+doOCDukgGFlqjlrL8l5hoMOZ76U1HYAL4OSZE39voBKhEohupwYs+cyecjSGS2KcIr32IohE+ETlxphci60r0WAxkxhomWT0rgpKDdsv4UMa1Kar3pDcNLeyOQm8K7LGWm2anI4QHnZ3k/neVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYsuzs/O+cHN7CxWP8tKV3pxy6rfL3Q6z9O2ezi5zOc=;
 b=r42o90ojI4nyFWfYCEZAZeM4IEbcYXUNb8YnbJi5ogaLnMzfzKOg2CcxOhnTiHkd1p95PqFvDJ9b9/ETq2scnl+Z1jMjhWkWpn4P47t9EG0L6r1WMqPw8k1sMNDdW+Veb2nLtsJE400qhJIEXNhv8Qu6TpTu114ensSMNl7/ZUcu999OVXPbKPwlSDYebI0GIF1udeqGH2+dk10hsdNlxttGsIKxGusPb4hvLgfoU9yTtP4czqW4xSLG1dZgPMQRVeYtzhw2FATEBf4x75GkLETbrMQAB+UHYYVLveKJg/tSrzw/lbP6GoPJ8BHVW8JxJwB7qGMQ9Qs7YAsmBIkcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYsuzs/O+cHN7CxWP8tKV3pxy6rfL3Q6z9O2ezi5zOc=;
 b=Z6DbF9TbONsMN51k+TSt5dLnkYlG/RYEXstaYylutlauOwlbE+XZfZAHiVB9DlFZwA69ZxIGxqunyL4ATj9aL1MoYXk6CjiCpgGyQLCJiNc6FA5ygItE8AiFHpJcl/a8Vccom4wwdLAmJCgpnBpH1zh5SC5Psiiapaw3avf84UQ=
Received: from CH0PR03CA0406.namprd03.prod.outlook.com (2603:10b6:610:11b::14)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Thu, 15 Oct
 2026 08:01:25 +0000
Received: from DS8PEPF000000E2.namprd05.prod.outlook.com
 (2603:10b6:610:11b:cafe::26) by CH0PR03CA0406.outlook.office365.com
 (2603:10b6:610:11b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 08:01:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E2.mail.protection.outlook.com (10.167.23.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 08:01:25 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 03:01:17 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: reapply umd profile state after recovery
Date: Thu, 15 Oct 2026 16:01:07 +0800
Message-ID: <20261015080107.2472690-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E2:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2bcfcb-a352-4221-9dfd-08df2a928281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|6133799003|18002099003|10067099003|11063799006|261009223027099003|261009221227099003|260925021911599003|260925022911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info: qETVkO84OQAID9DCU+M1sly4BIMcvKt2WBdy4o+d34wVaVte6CaMjyYd4jW7tMvkKXM4QJyZE95yZyihD83ivJcLS6SMUazUrhlfvfLCEsz9HUK9X1IrLlx4MkwU+Y1+PURgOhnGmRgWIgFQdyF99LI7um1N39naxCczB1GjwbqoJdYPAJp/96R5YevbEolCYrF4P8apsKYAjMLLp1RvyURNIWjB87N/2EmVa8PmkJXZFy2/IBlqovEeWkhCVCPF/I81g3dGGFE/xqiNeJDwMJTMY0Wg1LpqIs/S6O3/p/HKtN3O3uzJkgIM1kZBrJilekXpgt39hqYK/1u4iQITQ6O4RfdcX2xo6S54y+q3O74CSgr1kmVtfMMcS8T+UNJA5XGxUCFeH7b5PazvCejN2VISHN5H0aS0fpd1QucG0BgFB01JdAkEP5egsoOmaqPrbegg3VKZt9YvHnnwmyth9zWGDlfnvIMmgbbhsCEmXxcgDZiglbn1oglKyyXSLXO+LKw94RYFFVyTtXPFkwOGSRCcwfVjY893LXpmZU/NeV7hUnHfWnisOQKI0qVsgN+p54/bTIJhBhrfidaSFDAnq1S/+gjHJlv55w66tTS9rJW9nZW0J9yyrtg5Q44S6hmf9gaGSmjwVz0jYom2b1vKg57zJE2Gekb3QPgSCiT9pOSjJcc6eEUSPF9JMggBnq6VSnqKisHtrjqKmnMLAPgTmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(11063799006)(261009223027099003)(261009221227099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: thCmRGgafJKlNfgvqeWnjjaideSFezLMs7fXuoqh4EoqVH20RDYY+sAPWtnRvJs5nbfInLaqWtr3mW6VutIxUqgqzHz+w4HZIHQDBY6w/NM5Z+kZ4QpfxKCoXBX4Tyk0fJxmHYeUj9RieMlExMuyTQNrm209lfxhccxKKt3oLE0stborhdiboIDFFZBmn3UX97atwpF/a57sCmVIW5niY0KCwH0cf2F2rn8ZwnD+zPgya32SHyG3otwyNBLtBnwxMQ+wFBkJRJiLVQZO1OxeLJMrZ403ixRIKMx3+2Mx7zybUdlcKFUiACZ/727x8n6/bypD5VW7V/pQPrc2GbNatIiODDfbd13L2V9yY904wEo4soDSpKEdA6k6VrMS81a6uM2BOKzxJZQHKzVR2q6l3iZV/dnVY5UTrH0q7hE6A2s5NIiycfj8WTQp0IGvhFxD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:01:25.2289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2bcfcb-a352-4221-9dfd-08df2a928281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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

resume and full gpu reset retain the selected umd profile level in
driver state.

add a generic dpm reapply path after cg and pg restoration.
it restores the umd gfx state and asks the pm backend to replay the
retained level.

backend callbacks for swsmu and powerplay include swsmu gpo, gfx ulv,
and deep-sleep controls.

this covers:
- pci runtime resume
- full gpu reset recovery
- system resume, including s3 and s2idle

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 -----
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 63 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 15 +++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 61 +++++++++++++++---
 7 files changed, 138 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e0014611f039..c4f807ca7eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2776,6 +2776,12 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
+	r = amdgpu_dpm_reapply_umd_profile(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to restore UMD profile state: %d\n", r);
+		return r;
+	}
+
 	amdgpu_device_fill_reset_magic(adev);
 
 	r = amdgpu_device_enable_mgpu_fan_boost();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2712580a5663..d4267358156a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2987,19 +2987,6 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static void amdgpu_restore_umd_profile_pstate_after_runpm(struct amdgpu_device *adev)
-{
-	enum amd_dpm_forced_level level;
-	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
-		AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
-		AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
-		AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
-
-	level = amdgpu_dpm_get_performance_level(adev);
-	if (level & profile_mode_mask)
-		amdgpu_asic_update_umd_stable_pstate(adev, true);
-}
-
 static int amdgpu_pmops_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -3045,7 +3032,6 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 
-	amdgpu_restore_umd_profile_pstate_after_runpm(adev);
 	adev->in_runpm = false;
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index ca818965afe1..7db44fa24042 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -449,6 +449,8 @@ struct amd_pm_funcs {
 	int (*print_clock_levels)(void *handle, enum pp_clock_type type, char *buf);
 	int (*emit_clock_levels)(void *handle, enum pp_clock_type type, char *buf, int *offset);
 	int (*force_performance_level)(void *handle, enum amd_dpm_forced_level level);
+	int (*reapply_performance_level)(void *handle,
+					 enum amd_dpm_forced_level level);
 	int (*get_sclk_od)(void *handle);
 	int (*set_sclk_od)(void *handle, uint32_t value);
 	int (*get_mclk_od)(void *handle);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0394085a0328..01d2049d8224 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1082,6 +1082,69 @@ static void amdgpu_dpm_exit_umd_state(struct amdgpu_device *adev)
 					       AMD_PG_STATE_GATE);
 }
 
+/**
+ * amdgpu_dpm_reapply_umd_profile - Restore the active UMD profile
+ * @adev: amdgpu device
+ *
+ * Resume and reset retain the selected DPM level in software, but the
+ * underlying GFX and PMFW state is lost. Reapply a retained UMD profile
+ * after the common resume path has restored its default CG and PG state.
+ */
+int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum amd_dpm_forced_level level;
+	int ret;
+
+	if (!pp_funcs || !pp_funcs->reapply_performance_level)
+		return 0;
+
+	/* Serialize the retained level with the GFX and PMFW reprogramming. */
+	mutex_lock(&adev->pm.mutex);
+	if (adev->pm.dpm.thermal_active) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (pp_funcs->get_performance_level)
+		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
+	else
+		level = adev->pm.dpm.forced_level;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		break;
+	default:
+		ret = 0;
+		goto unlock;
+	}
+
+	amdgpu_dpm_enter_umd_state(adev);
+
+	ret = amdgpu_asic_update_umd_stable_pstate(adev, true);
+	if (ret)
+		goto exit_umd_state_unlock;
+
+	ret = pp_funcs->reapply_performance_level(adev->powerplay.pp_handle,
+						     level);
+	if (ret)
+		goto exit_umd_state_unlock;
+
+unlock:
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+
+exit_umd_state_unlock:
+	amdgpu_dpm_exit_umd_state(adev);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 72b13ece22ef..ba8624d28f28 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -484,6 +484,7 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev);
 int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level);
+int amdgpu_dpm_reapply_umd_profile(struct amdgpu_device *adev);
 int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
 				 struct pp_states_info *states);
 int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 239c64b8edca..bddf75dfbc22 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -376,6 +376,20 @@ static int pp_dpm_force_performance_level(void *handle,
 	return 0;
 }
 
+static int
+pp_dpm_reapply_performance_level(void *handle,
+				 enum amd_dpm_forced_level level)
+{
+	struct pp_hwmgr *hwmgr = handle;
+
+	if (!hwmgr || !hwmgr->pm_en || level != hwmgr->dpm_level)
+		return -EINVAL;
+
+	hwmgr->request_dpm_level = level;
+
+	return hwmgr_handle_task(hwmgr, AMD_PP_TASK_READJUST_POWER_STATE, NULL);
+}
+
 static enum amd_dpm_forced_level pp_dpm_get_performance_level(
 								void *handle)
 {
@@ -1536,6 +1550,7 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
 	.force_performance_level = pp_dpm_force_performance_level,
+	.reapply_performance_level = pp_dpm_reapply_performance_level,
 	.get_performance_level = pp_dpm_get_performance_level,
 	.get_current_power_state = pp_dpm_get_current_power_state,
 	.dispatch_tasks = pp_dpm_dispatch_tasks,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3cdf7d1e8d5b..b8057878a400 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2398,6 +2398,13 @@ static int smu_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static void smu_enter_umd_pstate(struct smu_context *smu)
+{
+	smu_gpo_control(smu, false);
+	smu_gfx_ulv_control(smu, false);
+	smu_deep_sleep_control(smu, false);
+}
+
 static int smu_enable_umd_pstate(void *handle,
 		      enum amd_dpm_forced_level *level)
 {
@@ -2416,9 +2423,7 @@ static int smu_enable_umd_pstate(void *handle,
 		/* enter umd pstate, save current level, disable gfx cg*/
 		if (*level & profile_mode_mask) {
 			smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
-			smu_gpo_control(smu, false);
-			smu_gfx_ulv_control(smu, false);
-			smu_deep_sleep_control(smu, false);
+			smu_enter_umd_pstate(smu);
 			amdgpu_asic_update_umd_stable_pstate(smu->adev, true);
 		}
 	} else {
@@ -2477,7 +2482,8 @@ static void smu_power_profile_mode_put(struct smu_context *smu,
 
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
-					  bool skip_display_settings)
+					  bool skip_display_settings,
+					  bool force_performance_level)
 {
 	int ret = 0;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
@@ -2504,7 +2510,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		}
 	}
 
-	if (smu_dpm_ctx->dpm_level != level) {
+	if (force_performance_level || smu_dpm_ctx->dpm_level != level) {
 		ret = smu_asic_set_performance_level(smu, level);
 		if (ret) {
 			if (ret == -EOPNOTSUPP)
@@ -2521,8 +2527,11 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	}
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-		smu_bump_power_profile_mode(smu, NULL, 0);
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+		ret = smu_bump_power_profile_mode(smu, NULL, 0);
+		if (ret)
+			return ret;
+	}
 
 	return ret;
 }
@@ -2541,13 +2550,13 @@ static int smu_handle_task(struct smu_context *smu,
 		ret = smu_pre_display_config_changed(smu);
 		if (ret)
 			return ret;
-		ret = smu_adjust_power_state_dynamic(smu, level, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
-		ret = smu_adjust_power_state_dynamic(smu, level, true);
+		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
 		break;
 	case AMD_PP_TASK_READJUST_POWER_STATE:
-		ret = smu_adjust_power_state_dynamic(smu, level, true);
+		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
 		break;
 	default:
 		break;
@@ -2676,6 +2685,37 @@ static int smu_force_performance_level(void *handle,
 	return ret;
 }
 
+static int
+smu_reapply_performance_level(void *handle,
+			      enum amd_dpm_forced_level level)
+{
+	struct smu_context *smu = handle;
+	struct smu_dpm_context *smu_dpm_ctx = &smu->smu_dpm;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
+		return -EINVAL;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (smu_dpm_ctx->dpm_level != level)
+		return -EINVAL;
+
+	smu_enter_umd_pstate(smu);
+
+	return smu_adjust_power_state_dynamic(smu, level, true, true);
+}
+
 static int smu_set_display_count(void *handle, uint32_t count)
 {
 	struct smu_context *smu = handle;
@@ -4062,6 +4102,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.force_clock_level       = smu_force_ppclk_levels,
 	.emit_clock_levels       = smu_emit_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
+	.reapply_performance_level = smu_reapply_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_apu_thermal_limit       = smu_get_apu_thermal_limit,
 	.set_apu_thermal_limit       = smu_set_apu_thermal_limit,
-- 
2.55.0

