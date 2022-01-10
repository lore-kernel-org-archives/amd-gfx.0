Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1ADC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 20:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E972B10E629;
	Mon, 10 Jan 2022 20:20:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057D210E629
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 20:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXHS5M6X6G4YNF01uWrVvq7P7803alUPL+BiIE/98DdsIFMld+c1qtUGteCis7XN/DhzeUfA1HSz8p8UAT2sU5FnZCYYp6p1K8AgQuNfbBgCwIcHObZ/YLcjuRPR2wqG628+Onm+2g+9yxtokkj4nNw4ZF9aDIQz1kFgdiNPYgFvPWjpe/HRhWbTDlRx/sSl9oh7fLTOOxJcAjBV58thljZAECS/wHKsFQDInAB0/zO4kSdDW17wJsK0qlcvr47ITH3q+DrE2L1XUEniU7rOMbFkEmBP5orKPOU+mnn7qpccBX0bNRgwYDDdK3un0L/IiAG/3+5tgYOfZQDsf57dGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSnWdWU7jhaNw1DM+XUWmd3q2qAgpyMiiqZxiBwt3wg=;
 b=nkff+H/pSmKiX+HLuSDeWqxVeKl6tow5QvTjMi3EImdAOKSmqTtZyM4C3CEsUCQwaibIwLjZh/zrKTbSBFqhT0qA9JD1trfSx5SX6u3JhyARxsmGnKhUOQv6R0sFXjugzbsoV4Y/SY6EOssL+z7WyfJMvrhaTgIbI7Cj1kRf2LridbRbfbcVmqhbYOyO7IBeKwoCD1qDLmixY0NngPTWUTb1yYTfQlhlUUeQbTdsJQmsB2dk6wxG3JFTmPA6yrNqG5FQ+4KqeMRqrSlQKlEcvcrXGlKT1Dy3SvrPyc7o94hYE0F73cDQ+tC0rTKcO2E0qia/kAM51ZDllDHMkz9njw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSnWdWU7jhaNw1DM+XUWmd3q2qAgpyMiiqZxiBwt3wg=;
 b=N/f+r6ADr+m99LUHla5gSGwk3yOJMgTX+A/pZ2NIA4DE+KcSEjcsmYsRQknaAg5X4aZvjZjBAFUQhplY8Qt/7RL28QLCYQINgBXw4SQjRrRodoV7sNFMYo+aqMokAzwJQ33LmCQg9lqTp1huve1HHrOE83eSUT7nNTbxj+jU0YU=
Received: from CO2PR04CA0177.namprd04.prod.outlook.com (2603:10b6:104:4::31)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 20:20:39 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::a8) by CO2PR04CA0177.outlook.office365.com
 (2603:10b6:104:4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Mon, 10 Jan 2022 20:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 20:20:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 14:20:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/pm: move additional logic into
 amdgpu_dpm_force_performance_level
Date: Mon, 10 Jan 2022 15:20:25 -0500
Message-ID: <20220110202027.1949684-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 237c2b8e-202f-40b2-18a2-08d9d476ab2d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52553005C5D24E42FC92D27BF7509@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYreluQG0IvnPwVosg+RxY0cMmVZNucsifKe+XPIzWIlEVHszYMDzEMGoZdEuTYbTsPgqJ3N2xKoib15U9d7RTE9mBioMRXVMfjVjyffFs2ZaBjWAfBseiuhhVBm0Q3NHpNEqq6UnmGEL30t7HPlYLfBozmbCr0SHGXDiidNVGb95/sxepY1tHFAWxSW6smKwB79fRj8wFYVVe2993H/dxnF/cToZN3LFQrjqie17Prj7S6sLDFe2DfoBQSqiyopz5Lv18pwoKRj8C6lHwESCCZwckfxgA9cRi9UEvM9SW60FVHKDjSBtaLJ1lYsaK57yTjqcCE2vggSWQoOi260dxVXC1vDRXJljmuxXLj6S9d5evB2+Eoe2y5aI4F1T6D+C1RNdAzgkQd40it1EUsnu4Zl/63v4cvZvdP/7D21a+NXTEAdrX9gMytK9h0iDT2mYyjrZpEMmejOkT2OlB7ZViKnNswap2pM7JZeZ3f1pJ3rJ9x94dOAjbKM0fuJEaGwG5eSndIzdThpIfuNEJ3AZk+uIG1IY7g/goz+/G3U9J53XdmsQeBdfK5f5UPIhFmtsoRbB22V+IZLDs4Y1nW2Qv+ATPoC2Bw/cxNoSyR2jv/ohi1QDgP/J+BbD4nsp8IUHQ4pAVvBANqt36gmRta8KkOzFSTmxOstHCcD502dPgXsJ4DQy3ivUoChbjYBkBisQSWz0JkbE7e6dVfcRURmc5IobB7z7VE1VQzOC6TI7/2AHhFG19CQ35sUlBgqi9HGFZss3zzPhMMzKmPXodDR187pYcwwJi5Zlt/KoRbAab8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(1076003)(86362001)(81166007)(5660300002)(83380400001)(36756003)(82310400004)(356005)(6666004)(316002)(508600001)(40460700001)(336012)(16526019)(26005)(8676002)(70586007)(36860700001)(426003)(2906002)(70206006)(186003)(8936002)(4326008)(6916009)(47076005)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 20:20:39.1162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 237c2b8e-202f-40b2-18a2-08d9d476ab2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is part of the forced performance level.  Move it from
the sysfs handler into amdgpu_dpm_force_performance_level.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 61 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 50 -----------------------
 2 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 68d2e80a673b..728b6e10f302 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -692,16 +692,25 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 		amdgpu_dpm_compute_clocks(adev);
 }
 
-enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
+static enum amd_dpm_forced_level amdgpu_dpm_get_performance_level_locked(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_dpm_forced_level level;
 
-	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->get_performance_level)
 		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
 	else
 		level = adev->pm.dpm.forced_level;
+
+	return level;
+}
+
+enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
+{
+	enum amd_dpm_forced_level level;
+
+	mutex_lock(&adev->pm.mutex);
+	level = amdgpu_dpm_get_performance_level_locked(adev);
 	mutex_unlock(&adev->pm.mutex);
 
 	return level;
@@ -711,6 +720,11 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 				       enum amd_dpm_forced_level level)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum amd_dpm_forced_level current_level;
+	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
 	int ret = 0;
 
 	if (!pp_funcs->force_performance_level)
@@ -723,6 +737,49 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 		goto out;
 	}
 
+	current_level = amdgpu_dpm_get_performance_level_locked(adev);
+	if (current_level == level) {
+		ret = 0;
+		goto out;
+	}
+
+	if (adev->asic_type == CHIP_RAVEN) {
+		if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
+			if (current_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
+			    level == AMD_DPM_FORCED_LEVEL_MANUAL)
+				amdgpu_gfx_off_ctrl(adev, false);
+			else if (current_level == AMD_DPM_FORCED_LEVEL_MANUAL &&
+				 level != AMD_DPM_FORCED_LEVEL_MANUAL)
+				amdgpu_gfx_off_ctrl(adev, true);
+		}
+	}
+
+	if (!(current_level & profile_mode_mask) &&
+	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!(current_level & profile_mode_mask) &&
+	      (level & profile_mode_mask)) {
+		/* enter UMD Pstate */
+		amdgpu_device_ip_set_powergating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_clockgating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_CG_STATE_UNGATE);
+	} else if ((current_level & profile_mode_mask) &&
+		    !(level & profile_mode_mask)) {
+		/* exit UMD Pstate */
+		amdgpu_device_ip_set_clockgating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_PG_STATE_GATE);
+	}
+
 	if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
 					      level))
 		ret = -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d3eab245e0fe..d2823aaeca09 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -299,11 +299,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	enum amd_dpm_forced_level level;
-	enum amd_dpm_forced_level current_level;
-	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
-					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
-					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
-					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
 	int ret = 0;
 
 	if (amdgpu_in_reset(adev))
@@ -341,51 +336,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return ret;
 	}
 
-	current_level = amdgpu_dpm_get_performance_level(adev);
-	if (current_level == level) {
-		pm_runtime_mark_last_busy(ddev->dev);
-		pm_runtime_put_autosuspend(ddev->dev);
-		return count;
-	}
-
-	if (adev->asic_type == CHIP_RAVEN) {
-		if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
-			if (current_level != AMD_DPM_FORCED_LEVEL_MANUAL && level == AMD_DPM_FORCED_LEVEL_MANUAL)
-				amdgpu_gfx_off_ctrl(adev, false);
-			else if (current_level == AMD_DPM_FORCED_LEVEL_MANUAL && level != AMD_DPM_FORCED_LEVEL_MANUAL)
-				amdgpu_gfx_off_ctrl(adev, true);
-		}
-	}
-
-	/* profile_exit setting is valid only when current mode is in profile mode */
-	if (!(current_level & profile_mode_mask) &&
-	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
-		pr_err("Currently not in any profile mode!\n");
-		pm_runtime_mark_last_busy(ddev->dev);
-		pm_runtime_put_autosuspend(ddev->dev);
-		return -EINVAL;
-	}
-
-	if (!(current_level & profile_mode_mask) &&
-	      (level & profile_mode_mask)) {
-		/* enter UMD Pstate */
-		amdgpu_device_ip_set_powergating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_UNGATE);
-		amdgpu_device_ip_set_clockgating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_CG_STATE_UNGATE);
-	} else if ((current_level & profile_mode_mask) &&
-		    !(level & profile_mode_mask)) {
-		/* exit UMD Pstate */
-		amdgpu_device_ip_set_clockgating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_CG_STATE_GATE);
-		amdgpu_device_ip_set_powergating_state(adev,
-						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_GATE);
-	}
-
 	if (amdgpu_dpm_force_performance_level(adev, level)) {
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
-- 
2.33.1

