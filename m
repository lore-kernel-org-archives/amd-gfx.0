Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3C3C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816DA10ED56;
	Mon, 13 Dec 2021 03:53:13 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A29D10ED56
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPXm6mfqEYYsc5aPw7HcL5mQ5QA93Ge59YINbYtF8zcFBsJU3U4tzCB2ua1Wh1yoKrDASdnhTJ4i9IZb424wTVugk3Qk/9T9tUZ0mU/OQpWpvJm/uA3vi7BFow2zQ4mhgb/v33Gfgt9RdTed6IPyeXnQBkZryugii4bm1kVl1HAw4PT9/KPqHPqCgU9KD7e2kKarH5FAvAk1P2xYr8AZ9Jvb0yiXNmTXFtR55PB3Q3f0NeHDAEnI2Z3bxeynxHRpUkIorb4AxAmSkrElTl1KcRyo2D0mbfWIaUPiQW99z5jiDxfi2OlPPGE9IsqJvWHkKfC37xoPERTNjbPV8+WJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Fu8jEZ5Y8SupjfKlYJ5TdCJzGB4pLvkWxByO7T/O8o=;
 b=YPHFlx61+aj8m/MObUzJo3eR8XRsANm/e71ZuK2oTUwyXwdWi02pvNshkwu0x/DwUB+1J6jvkTgwYZ+9L1gaBukIaqGpYou4OaVfg9mi8fbpsUVOAXq7yS+MAtx0GbQTLjyzlN2xuG0GObftQCANn89GeAI6u837pALd21dPK10rph+8xh0DcFMLO6uJjiiMS3qnRjQxriX4vSk/YKOzaIr/orjAq3nhlM87/hYlcO4ahxWXoS6gEW6GVM4RJuVrirPKDmm2a6EV0aHodBA51r+TFCtpv+I+nGz29gDUoRTNUkNIqVIRbdnh9S6bTK2d31RgduA0tanueOVgFH5Ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fu8jEZ5Y8SupjfKlYJ5TdCJzGB4pLvkWxByO7T/O8o=;
 b=sBzRgX6S/Ry8mjCgXYUeapg17D3k/KlC3z2uMGUW18T4TPjjLr4B8KQXpfpHSAC2zkOYax3oa+GFRXcbyNT52X8yzxb9ENDmWXnmxv78jqSVfxaZ8I11SFYm+dgwQACaCxkd+sru6bA4+En3IC9cham/6MdvaK0MwiN5Ai7sttI=
Received: from DM6PR10CA0011.namprd10.prod.outlook.com (2603:10b6:5:60::24) by
 SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 03:53:08 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::30) by DM6PR10CA0011.outlook.office365.com
 (2603:10b6:5:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Mon, 13 Dec 2021 03:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:53:08 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:53:05 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 15/16] drm/amd/pm: revise the performance level setting APIs
Date: Mon, 13 Dec 2021 11:52:22 +0800
Message-ID: <20211213035223.772700-16-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e112f80-6af3-47ab-5b45-08d9bdec1332
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5488:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5488C284B9B682A9BCA76551E4749@SJ0PR12MB5488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qc37pn4GL0ZEDB1iyXukMRHytE4ijT4fjAtShI5xUYXzbipP+U1zWhZTIC8l0lLxbkFR7srbYFBhoNfSIMm3bdWbb3eMU8zqX0SthZn0VH1M4xm+9tSQrowtco4Fzw29SaEfT62ZCqJjssVDJdDRGB/ypEIjLxU4g+sTrR/iRmv5ubmBTbJ+tcQNc2p977+8Y9Oujz9PFQfdCoSMD8Gou+lfXJmTBAnaf2PkuTJ2y6SIWCXiTlcsKXmsVfdq7BOHOtKRJI+50DxerrMv4DoyGiHNZtvt2DO5eApqsuWO/NDFTFS320AdVv7sZONFTlRToLrQToFttIwtvP2c4adjdC62xKjpoHryJFXI+Rfxl7llATe4euA+t7c/lmt5yRA7m7MP6y+xXLg5CXS7AUFeGW9Yh0Sf5br6ooyjubUiLovlDkQS2kM3W5xcHaynkxsgQaJD9iXpJzPuayHalj1BGB6YGUFKn0bBKWS9mkIuHEwHeBIalq1YgPhLUt9Jw6swY+2Sacj8texikhf79TK9gioJ2BGZICmFV4wbi+7CsJ83nznIDPYcFL3Xir3UbTv5QZODLwzMacJVNj/TumcRu6kPWZ16+nzb5mtU1DKHJ0Di6Fe/u9BfspQo4LGxudvHjfghn5z2xbkS/tgNOaEbxy5qf6proEFuia3gMswpawbba5qOx+ljl53Gty1jGKcBQKJ3FMj3mLt+D/MxJOfwpWwA6/ZelX9u46cwxviX8b+WQQmCE0zNc1sqB4ztY1x//W0PQdamcM+cZgA0t773vRuKSkzye/yDg+N6EJ9gX5o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(426003)(8676002)(86362001)(26005)(44832011)(16526019)(6666004)(8936002)(186003)(336012)(6916009)(316002)(1076003)(2616005)(47076005)(54906003)(2906002)(36860700001)(40460700001)(70206006)(7696005)(83380400001)(36756003)(356005)(508600001)(70586007)(5660300002)(81166007)(82310400004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:53:08.0831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e112f80-6af3-47ab-5b45-08d9bdec1332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid cross callings which make lock protection enforcement
on amdgpu_dpm_force_performance_level() impossible.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ie658140f40ab906ce2ec47576a086062b61076a6
--
v1->v2:
  - drop unused enable_umd_pstate callback(Lijo)
---
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 29 ++++++++++++++++---
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 17 ++++++-----
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 --------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 15 ----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 6 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f57a1478f0fe..fb6ad56ad6f1 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -268,7 +268,6 @@ enum amd_dpm_forced_level;
  * @set_clockgating_state: enable/disable cg for the IP block
  * @set_powergating_state: enable/disable pg for the IP block
  * @get_clockgating_state: get current clockgating status
- * @enable_umd_pstate: enable UMD powerstate
  *
  * These hooks provide an interface for controlling the operational state
  * of IP blocks. After acquiring a list of IP blocks for the GPU in use,
@@ -299,7 +298,6 @@ struct amd_ip_funcs {
 	int (*set_powergating_state)(void *handle,
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u32 *flags);
-	int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
 };
 
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ce80430c0eb6..106f6ee955f4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -301,6 +301,10 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level;
 	enum amd_dpm_forced_level current_level;
 	int ret = 0;
+	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -354,10 +358,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
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
@@ -365,6 +366,26 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
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
index 3c6ee493e410..9613c6181c17 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -953,6 +953,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
 
 static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 {
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct amdgpu_ps *ps;
 	enum amd_pm_state_type dpm_state;
 	int ret;
@@ -976,7 +977,7 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 	else
 		return -EINVAL;
 
-	if (amdgpu_dpm == 1 && adev->powerplay.pp_funcs->print_power_state) {
+	if (amdgpu_dpm == 1 && pp_funcs->print_power_state) {
 		printk("switching from power state:\n");
 		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
 		printk("switching to power state:\n");
@@ -985,14 +986,14 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 
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
@@ -1000,24 +1001,24 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
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
index b5fbad92738b..29f521854796 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1674,14 +1674,7 @@ static int smu_enable_umd_pstate(void *handle,
 		/* enter umd pstate, save current level, disable gfx cg*/
 		if (*level & profile_mode_mask) {
 			smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
-			smu_dpm_ctx->enable_umd_pstate = true;
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
@@ -1691,16 +1684,9 @@ static int smu_enable_umd_pstate(void *handle,
 		if (!(*level & profile_mode_mask)) {
 			if (*level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
 				*level = smu_dpm_ctx->saved_dpm_level;
-			smu_dpm_ctx->enable_umd_pstate = false;
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
@@ -2146,7 +2132,6 @@ const struct amd_ip_funcs smu_ip_funcs = {
 	.soft_reset = NULL,
 	.set_clockgating_state = smu_set_clockgating_state,
 	.set_powergating_state = smu_set_powergating_state,
-	.enable_umd_pstate = smu_enable_umd_pstate,
 };
 
 const struct amdgpu_ip_block_version smu_v11_0_ip_block =
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 9d4a85c39ad2..778196167de2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -363,7 +363,6 @@ struct smu_dpm_context {
 	uint32_t dpm_context_size;
 	void *dpm_context;
 	void *golden_dpm_context;
-	bool enable_umd_pstate;
 	enum amd_dpm_forced_level dpm_level;
 	enum amd_dpm_forced_level saved_dpm_level;
 	enum amd_dpm_forced_level requested_dpm_level;
-- 
2.29.0

