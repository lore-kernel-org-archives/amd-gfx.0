Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7F3CCA463
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 01:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A34A10E157;
	Fri, 16 Oct 2026 01:26:43 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB56410E157
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 01:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUEqlKP33UaOu9D/ubLIzRJuC+7NRCJ19QTHBws0RBW+PFy4os+QTaD4AuQeakWisD0C2vWZ+ko8CFieohslBnYaq44fZGmtiuOQTqD8nehrbIWRBKCSTUTFojeEdO7voQMqb5bsJOLEz2ep7zTahils7fM0vf7ocGhWq1WN4GeO6Jtg98b3TpqQ9N0Qp3loVX2pmx0jf37VDT2q1FJaIdJJHtbjXRougXf+u8wxNKpXRgypLkLqZVs6AuTMgfVwK+bczfU2pFkgYMVGS0EK8Tky/Uz1UJI40Zd+lSVmb1pYEeXvsIkE5MiHjPTaelSdvj21lU5i+FVYkFhbLVMgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84Hu5NVCkmYAiEc7ooD/FZCaZBi4vY6VbhloQ5jZznw=;
 b=j8e4/iaze4OKcIPK0BM3y2bG4mb75kGhu7ralpcPmMd9KG70xgsfEBnJAskkCqzk3fLuS6k+Z8uRwwV/nIzpnJTZOM0n6QTudGBzSciqaKQF9LXDraYQfkVMVcNI1+mUwwj8l8Q42ORCbCgkF+XyK6dh+R5Ywur2G62C/LdDFMpIKvkbt1A6UyyBpvOaOeyjQ07RIhWR96oBmv59q6mp3QonU6lSo8Gi0Qb32ahXC74M8kF85a9FBjaz4+BbEc5VJOZJQX5/oa0/GcEd1DoQK4n4mHTzyjkkncQIRTqAXhRiMKpbJviQkk9zYhEQeYthjy3dOUZA324H2dmnjIy9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84Hu5NVCkmYAiEc7ooD/FZCaZBi4vY6VbhloQ5jZznw=;
 b=VHAwgTAsJ15cQ020WzGJfdcFbjL5UCWYntM0wVp4FIOXn5xbVQSTuh9gusSV41FeMdmaqCUjULFOHEC71RwA0wsF6xVQWe6qa9mo4zuYqok1rgAmGRPYIP0HDojfF0i+dg8Y28oMBGu9NVwIWm71fioPTYnYkKUF28jP0IQrctk=
Received: from SJ0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:33b::15)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 01:26:32 +0000
Received: from MW3PEPF00001658.namprd21.prod.outlook.com
 (2603:10b6:a03:33b:cafe::46) by SJ0PR05CA0010.outlook.office365.com
 (2603:10b6:a03:33b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 01:26:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001658.mail.protection.outlook.com (10.167.249.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 16 Oct 2026 01:26:31 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 20:26:23 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <sstamenk@amd.com>
Subject: [PATCH v2] drm/amd/pm: reapply umd profile state after recovery
Date: Fri, 16 Oct 2026 09:26:14 +0800
Message-ID: <20261016012614.2812170-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001658:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b3642a-ab90-4eb2-6e35-08df2b24829b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|56012099006|260925022911599003|260925021311599003|260925021911599003|11063799006|261009223027099003|261009221227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5A88xFRr5lJSKoyDZwjHEwOwQEwUPWh6tIDmm0y2OjdUafsce2rOZKxdbTaKFWw97ogMfHBkg9lWcnKV+9oLMskIPoezgnodFuZ00X8ieWxW661qjPDwIQo92P8NdXjOj3Tpmpis5iGklGlaz1ddnXBCtpGZP02oYCCCNjWCqLp+v0GgoypUkpwkPLj0UYLqW7PRPVaSQIbYevvvvdDV2iGLl7eLebQrJWQONQVN/h6jF+RQkC0/rLlLR12nEiQtLpv6eww2ZlzFrDmP2QE70n7pjcdcu729yEOs6lIQsoUhu6F762Tzep77ZiG3HEkkDAwNC7dIHi84XAMRF9Kun8XJl8G+AnLAveir/pocJdSvre+rRPBcgXuPGeoUoR2zlVL0okaf//vKVIBfiSE1SK4ZAskFLFgZ1Ww2eR4M4T3PaISVZtAsFOohoFGiaz44fygOn+NU7gJvvg/b0K1p92Ido5nzazKl3OCY7zMXytgEkCRBL1fwIr0a/yq1+qyzaleSqjPwPUUwapCWvXN2pDA4NpQ8sIfYihwSBua/wcj8wLOdasJyOeG/jMbSOdcsahLvNm6lcy9l7irlovA/fQB138IzPbRbCM/W8wh2vXYAkPa3kjsbZOeTuE2dxsthgRZTMyKNU6gARey+b+k3tSma9ZjY4QIpu8u1LOIvTBgqk91V8Bg09fO1MyWikuhdYj4MvnbnKnWze1HynA4c0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2z6btcIdAC0IzkW8eb5/OoaQI4kBntfnDR9qqZ0HR6OUrAvqSywoMYa5Ykur6R1XUUmPJr/ctiaA/KSxcYYlHPW2mYmaF1cSC61wAzG+YVYfF/gUXEtfEuhEHT+JreHH/AjEq5uw2PIL4aUDAFCAcAs+abLdqEDdqArkDK/HsnpEVa6aAXzQsS5pecBsmgrxsaxngI5+L2SXVIVdpGA/NGoL6BiU4WdHbOcqKfrXmzNKsdH31YlqKZJjGiqzVbj17l0fDhU4g3loZ6FzNjNxq27NayvsLQAbrAcGXaYKfuzqIIeOxCindE8Z2Wpv8GfUZ+xBgU7jwGD7ERuLTXIqaOf08e0B5fHw9Mal2z+YeDS7903pgcI3sPej0Eiq4YbyMuSTVqEEivi+bq+gsTdBtkaxrKyZ1PwI4WhdFs6b7tG4Vjllqa3KqP1FWKotYy3H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 01:26:31.8598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b3642a-ab90-4eb2-6e35-08df2b24829b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001658.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

Resume and full GPU reset retain the selected UMD profile level in
driver state.
The GFX and PMFW state behind it is reinitialized.

Add a generic DPM reapply path after CG and PG restoration.
It restores the UMD GFX state and asks the PM backend to replay the
retained level.

v2:
- Reapply only GFX CG to preserve the profile-owned GFX PG reference.
- Fall back to AUTO when reapply fails without failing device recovery.
- Propagate PowerPlay DPM errors before accepting AUTO fallback.
- Limit workload-profile error reporting to the swSMU reapply path.

This covers:
- PCI runtime resume
- Full GPU reset recovery
- System resume, including S3 and s2idle

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 ---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 85 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 33 +++++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 87 +++++++++++++++++--
 7 files changed, 201 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 96cb4d34157e..b74f9136aa2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2774,6 +2774,12 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
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
index 0394085a0328..75d8bb4868e8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1082,6 +1082,91 @@ static void amdgpu_dpm_exit_umd_state(struct amdgpu_device *adev)
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
+	int ret, fallback_ret;
+
+	if (!pp_funcs || !pp_funcs->reapply_performance_level ||
+	    !pp_funcs->force_performance_level)
+		return 0;
+
+	/* Serialize the retained level with the GFX and PMFW reprogramming. */
+	mutex_lock(&adev->pm.mutex);
+	if (adev->pm.dpm.thermal_active) {
+		dev_warn(adev->dev,
+			 "Cannot restore UMD profile while thermal control is active\n");
+		ret = 0;
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
+	/* The active profile already owns the GFX PG reference. */
+	ret = amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					      AMD_CG_STATE_UNGATE);
+	if (ret)
+		goto fallback_auto;
+
+	ret = amdgpu_asic_update_umd_stable_pstate(adev, true);
+	if (ret)
+		goto fallback_auto;
+
+	ret = pp_funcs->reapply_performance_level(adev->powerplay.pp_handle,
+						     level);
+	if (ret)
+		goto fallback_auto;
+
+unlock:
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+
+fallback_auto:
+	dev_warn(adev->dev, "Failed to restore UMD profile state: %d\n", ret);
+
+	/* Restore normal CG before releasing the profile's PG reference. */
+	amdgpu_asic_update_umd_stable_pstate(adev, false);
+	amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GFX,
+					       AMD_CG_STATE_GATE);
+	mutex_unlock(&adev->pm.mutex);
+
+	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
+	fallback_ret = amdgpu_dpm_force_performance_level(adev,
+						   AMD_DPM_FORCED_LEVEL_AUTO);
+	if (fallback_ret)
+		dev_warn(adev->dev, "Failed to fall back to AUTO performance level: %d\n",
+			 fallback_ret);
+	else
+		adev->pm.stable_pstate_ctx = NULL;
+	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
+
+	return 0;
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
index 239c64b8edca..7b0ff5a0993e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -358,24 +358,46 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
 	}
 }
 
-static int pp_dpm_force_performance_level(void *handle,
-					enum amd_dpm_forced_level level)
+static int pp_dpm_apply_performance_level(struct pp_hwmgr *hwmgr,
+					  enum amd_dpm_forced_level level,
+					  bool reapply)
 {
-	struct pp_hwmgr *hwmgr = handle;
+	int ret;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	if (level == hwmgr->dpm_level)
+	if (!reapply && level == hwmgr->dpm_level)
 		return 0;
 
 	pp_dpm_en_umd_pstate(hwmgr, &level);
 	hwmgr->request_dpm_level = level;
-	hwmgr_handle_task(hwmgr, AMD_PP_TASK_READJUST_POWER_STATE, NULL);
+	ret = hwmgr_handle_task(hwmgr, AMD_PP_TASK_READJUST_POWER_STATE, NULL);
+	if (ret)
+		return ret;
+
+	ret = phm_force_dpm_levels(hwmgr, level);
+	if (ret)
+		return ret;
+
+	hwmgr->dpm_level = level;
 
 	return 0;
 }
 
+static int pp_dpm_force_performance_level(void *handle,
+					enum amd_dpm_forced_level level)
+{
+	return pp_dpm_apply_performance_level(handle, level, false);
+}
+
+static int
+pp_dpm_reapply_performance_level(void *handle,
+					 enum amd_dpm_forced_level level)
+{
+	return pp_dpm_apply_performance_level(handle, level, true);
+}
+
 static enum amd_dpm_forced_level pp_dpm_get_performance_level(
 								void *handle)
 {
@@ -1536,6 +1558,7 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
 	.force_performance_level = pp_dpm_force_performance_level,
+	.reapply_performance_level = pp_dpm_reapply_performance_level,
 	.get_performance_level = pp_dpm_get_performance_level,
 	.get_current_power_state = pp_dpm_get_current_power_state,
 	.dispatch_tasks = pp_dpm_dispatch_tasks,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3cdf7d1e8d5b..1915413ccac3 100644
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
@@ -2527,6 +2533,39 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	return ret;
 }
 
+static int
+smu_reapply_power_state_dynamic(struct smu_context *smu,
+				enum amd_dpm_forced_level level)
+{
+	struct smu_dpm_context *smu_dpm_ctx = &smu->smu_dpm;
+	int ret;
+
+	ret = smu_apply_clocks_adjust_rules(smu);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to apply clocks adjust rules!");
+		return ret;
+	}
+
+	ret = smu_asic_set_performance_level(smu, level);
+	if (ret) {
+		if (ret == -EOPNOTSUPP)
+			dev_info(smu->adev->dev, "set performance level %d not supported",
+				 level);
+		else
+			dev_err(smu->adev->dev, "Failed to set performance level %d",
+				level);
+		return ret;
+	}
+
+	smu_dpm_ctx->dpm_level = level;
+
+	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL ||
+	    smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+		return 0;
+
+	return smu_bump_power_profile_mode(smu, NULL, 0);
+}
+
 static int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
 			   enum amd_pp_task task_id)
@@ -2541,13 +2580,13 @@ static int smu_handle_task(struct smu_context *smu,
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
@@ -2676,6 +2715,37 @@ static int smu_force_performance_level(void *handle,
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
+	return smu_reapply_power_state_dynamic(smu, level);
+}
+
 static int smu_set_display_count(void *handle, uint32_t count)
 {
 	struct smu_context *smu = handle;
@@ -4062,6 +4132,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.force_clock_level       = smu_force_ppclk_levels,
 	.emit_clock_levels       = smu_emit_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
+	.reapply_performance_level = smu_reapply_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_apu_thermal_limit       = smu_get_apu_thermal_limit,
 	.set_apu_thermal_limit       = smu_set_apu_thermal_limit,
-- 
2.55.0

