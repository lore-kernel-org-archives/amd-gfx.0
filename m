Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F30C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E2C6F5D1;
	Tue, 30 Nov 2021 07:44:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E866F3C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5oALD3MVNwLcn9ylpzVDGatY4VDxUdwBKNjaD3Qi+GdKY++nckWs+lsNDi/8WVUXn4JXWmIoCHyIQVlAJ+/XKcoG/qWDUGmNw6YOXUQRHiNxZTpxIAFk+GuORivaVuMpvwDE8Oo8du+JYuvLpetxQYkgQQTWeZ7JI2PqjT4luJMk9ioSUxwZCKoHe7AVLW3e6jxRvWfdqVgbcSeUmTFSgcwqJ5nUmdqZw6Iu/KCo5X4yi68Ra82cP2e2vlnm0LkauJPj2pQ2q5M4X1ZneWG2Z3M738vdWZJkOiDtn4m44Vsqt0mCwCAYCrSqF8geBar5F3uynOQ4KTVuLWfV4lnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/Rxi9cXwbv083F90DHfPqBf9paYjOGPtGjrGhfCVgo=;
 b=Nnd1B9R7i5EqWE+SWwBBp27HVpl7FPF2s2oId82V2PNvL+xrPGJCfwJ53qH9EzNSHPLYWtR1myhwlY7aGY3esYal/i488e01W/5sjcT2llbvDto7qRt61v0c6qezi0OVx6Y/HeqPXOxIVQhFiFn+016sH4/BPCAkPw3JAsfL5dNaKqP0leV4gFlCyX7HREb3TWVGv3MV/+LOKWjpXR9g7EYX6t0pAcuFtwfFxepLEIdVm5a/H2jcVf2MH6/2WzP+aeiLaR+IQZQ8cZR3KZK88tPdeSDE7uxYg3wG1zsW3abbuJIDjhWw0PeQ8kC6rgTZHQPdXtJ4AF910GZa+VAgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/Rxi9cXwbv083F90DHfPqBf9paYjOGPtGjrGhfCVgo=;
 b=GU7vmXanzREGjBo2JYJGrcM/rAuLvpyz1zMy1j0iTi7DL2evPwzp8JWUnYWUTMIN8BovVMBHhUUTG+5AjOzmEJNThLncMD6onzWK7ePARS7igrpP9vHfvSwJyVcHKPUWpFmL3EsYBj7pQRUg71XRJFX0fXclN73lUkIG9K3k1ds=
Received: from BN9PR03CA0624.namprd03.prod.outlook.com (2603:10b6:408:106::29)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 30 Nov
 2021 07:43:56 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::2d) by BN9PR03CA0624.outlook.office365.com
 (2603:10b6:408:106::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:56 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:54 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 16/17] drm/amd/pm: revise the performance level setting APIs
Date: Tue, 30 Nov 2021 15:42:58 +0800
Message-ID: <20211130074259.1271965-17-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 934b953e-026d-45d2-272d-08d9b3d52a44
X-MS-TrafficTypeDiagnostic: BN9PR12MB5049:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5049EF1E62A7564ABB382CC4E4679@BN9PR12MB5049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PC2ZHmTiQ1oYPUh8hntVHbsZtFHwPqAbAP1aNwEwUqZ9uYNuiujoszlm/DRNL4yhNSb9O2fB8xZeZWMXcs6RaWkdQO2M4fLTKN0hLZfAfL2IO1Vd8YVKyL8YQHBo1fWkYS6CFwEccwVL42NTq+irVYaIpWD3DRAwrzZCE9F3zNPFIGiy0/+d3oIuJ/G81XuI9c0Rw/09f3D+ab4nL9XLwMgQpGFcyW8MJHkK/icL04V4DNK/aazZBAaRJfomR0vwywpDZedyBQ+Esk8T187YexRlkI3BaRtyeCAAJ3PpMUXhc5vdwHA5RCYCZ1anqMF+flQ/wUcQhLv6uWahi9cJ82Bmcqg1WqmF+v4qBnfw7o1CdfTiFjWNWTuGPzc2r7AtmEpp+9iXRWQNvjwFzndP3oOt483/eAyOAkToxB7vmfS/69U+X/JfaBq6h9OH/xsqMH4b/p1NbmVxQBhdmiIsMVDcj49y7r3FJI9lt3nXI37Dqw7ij1A7TEIutI91J/kEqaEuuwWh3nx5NsaKfFqPtXR2m+UDuA3mBkb+5JxphIhMfh8hYtwbQni41f/vISiFUV8arlwbiwAq4DNfqePEyvST212J9m8+oe2I7DZlML/lUCy3tAZtG1ieoHdjukt3/juo6fMbdxn3s2CpBg99bkluJdiPt1bz6CZHWsk6fQalYebCMnUKSJbvd9t8VZxCcMLwy5o0iuAnjt8lr4npflzztLwCpwciXumTNKpu7Tcz1FLL0cYmmOb8dv00ulBGqCwXMzNAyapPCMiHHZHMWfwaWPXBfzfm4G5FEyT1XEM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(6916009)(70586007)(26005)(83380400001)(44832011)(5660300002)(47076005)(7696005)(36860700001)(356005)(8936002)(8676002)(4326008)(70206006)(1076003)(86362001)(336012)(81166007)(36756003)(2616005)(54906003)(16526019)(186003)(2906002)(508600001)(316002)(426003)(82310400004)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:56.7711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934b953e-026d-45d2-272d-08d9b3d52a44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid cross callings which make lock protection enforcement
on amdgpu_dpm_force_performance_level() impossible.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ie658140f40ab906ce2ec47576a086062b61076a6
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 29 ++++++++++++++++---
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 17 ++++++-----
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 --------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 --------
 4 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 89e1134d660f..28150267832c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -305,6 +305,10 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level;
 	enum amd_dpm_forced_level current_level;
 	int ret = 0;
+	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -358,10 +362,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	}
 
 	/* profile_exit setting is valid only when current mode is in profile mode */
-	if (!(current_level & (AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
-	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
-	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
-	    AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)) &&
+	if (!(current_level & profile_mode_mask) &&
 	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
 		pr_err("Currently not in any profile mode!\n");
 		pm_runtime_mark_last_busy(ddev->dev);
@@ -369,6 +370,26 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return -EINVAL;
 	}
 
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
 	if (amdgpu_dpm_force_performance_level(adev, level)) {
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 9e6bc562fc5a..8d5916087861 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -1382,6 +1382,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
 
 static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 {
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct amdgpu_ps *ps;
 	enum amd_pm_state_type dpm_state;
 	int ret;
@@ -1405,7 +1406,7 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 	else
 		return -EINVAL;
 
-	if (amdgpu_dpm == 1 && adev->powerplay.pp_funcs->print_power_state) {
+	if (amdgpu_dpm == 1 && pp_funcs->print_power_state) {
 		printk("switching from power state:\n");
 		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
 		printk("switching to power state:\n");
@@ -1414,14 +1415,14 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 
 	/* update whether vce is active */
 	ps->vce_active = adev->pm.dpm.vce_active;
-	if (adev->powerplay.pp_funcs->display_configuration_changed)
+	if (pp_funcs->display_configuration_changed)
 		amdgpu_dpm_display_configuration_changed(adev);
 
 	ret = amdgpu_dpm_pre_set_power_state(adev);
 	if (ret)
 		return ret;
 
-	if (adev->powerplay.pp_funcs->check_state_equal) {
+	if (pp_funcs->check_state_equal) {
 		if (0 != amdgpu_dpm_check_state_equal(adev, adev->pm.dpm.current_ps, adev->pm.dpm.requested_ps, &equal))
 			equal = false;
 	}
@@ -1429,24 +1430,24 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 	if (equal)
 		return 0;
 
-	if (adev->powerplay.pp_funcs->set_power_state)
-		adev->powerplay.pp_funcs->set_power_state(adev->powerplay.pp_handle);
+	if (pp_funcs->set_power_state)
+		pp_funcs->set_power_state(adev->powerplay.pp_handle);
 
 	amdgpu_dpm_post_set_power_state(adev);
 
 	adev->pm.dpm.current_active_crtcs = adev->pm.dpm.new_active_crtcs;
 	adev->pm.dpm.current_active_crtc_count = adev->pm.dpm.new_active_crtc_count;
 
-	if (adev->powerplay.pp_funcs->force_performance_level) {
+	if (pp_funcs->force_performance_level) {
 		if (adev->pm.dpm.thermal_active) {
 			enum amd_dpm_forced_level level = adev->pm.dpm.forced_level;
 			/* force low perf level for thermal */
-			amdgpu_dpm_force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
+			pp_funcs->force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
 			/* save the user's level */
 			adev->pm.dpm.forced_level = level;
 		} else {
 			/* otherwise, user selected level */
-			amdgpu_dpm_force_performance_level(adev, adev->pm.dpm.forced_level);
+			pp_funcs->force_performance_level(adev, adev->pm.dpm.forced_level);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index d57d5c28c013..5a14ddd3ef05 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -323,12 +323,6 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
 		if (*level & profile_mode_mask) {
 			hwmgr->saved_dpm_level = hwmgr->dpm_level;
 			hwmgr->en_umd_pstate = true;
-			amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_GFX,
-					AMD_PG_STATE_UNGATE);
-			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-						AMD_IP_BLOCK_TYPE_GFX,
-						AMD_CG_STATE_UNGATE);
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
@@ -336,12 +330,6 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
 			if (*level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
 				*level = hwmgr->saved_dpm_level;
 			hwmgr->en_umd_pstate = false;
-			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_GFX,
-					AMD_CG_STATE_GATE);
-			amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_GFX,
-					AMD_PG_STATE_GATE);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6f5a6886d3cc..241eebef9939 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1681,12 +1681,6 @@ static int smu_enable_umd_pstate(void *handle,
 			smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
 			smu_dpm_ctx->enable_umd_pstate = true;
 			smu_gpo_control(smu, false);
-			amdgpu_device_ip_set_powergating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_PG_STATE_UNGATE);
-			amdgpu_device_ip_set_clockgating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_CG_STATE_UNGATE);
 			smu_gfx_ulv_control(smu, false);
 			smu_deep_sleep_control(smu, false);
 			amdgpu_asic_update_umd_stable_pstate(smu->adev, true);
@@ -1700,12 +1694,6 @@ static int smu_enable_umd_pstate(void *handle,
 			amdgpu_asic_update_umd_stable_pstate(smu->adev, false);
 			smu_deep_sleep_control(smu, true);
 			smu_gfx_ulv_control(smu, true);
-			amdgpu_device_ip_set_clockgating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_CG_STATE_GATE);
-			amdgpu_device_ip_set_powergating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_PG_STATE_GATE);
 			smu_gpo_control(smu, true);
 		}
 	}
-- 
2.29.0

