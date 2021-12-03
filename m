Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9F4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 03:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006AE6EC11;
	Fri,  3 Dec 2021 03:06:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EAE6EC08
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 03:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKuviACjL4uxmID7ecGDCNCkYXmYHDtu1Pon1lL26zUDN8ZFpQeEvlB8hhAalWLu5RXV3we9JmdUG2D72aO8G2g6RiUfFt88CRWb2kJR3KGYrjZllWmKmv1dsaGUvPKwYh1s+4nMYEDJn3xuekeMs/GUqypEe/FLkWXb9d0iTKY0B1EB3+m77YuEcvkbgh1CxMxOlKACWpKWVgSJH5yu/73tQ2MygAICcEn6CT9ce2HT/QVK7oC0F0kiQMR21Tmk6pMl0q2XTlUYbgpgRDDiAVqEoo3GQiiEQe2wGslhm4ceNP9RgwzwMoU3ugpiBhU9DwWDTyzrTB5u29uhzujXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQuT+NRXHj7IvJI4NEcPhK35KCLsoqlLjXmXUWfi7pg=;
 b=Zwu0it/DCvwUWlSOO4Ouaplmg5lTbq91bA267ht7GbwxMbI3SFEGr+dHXNczKisW/q0+m4XGUmjlsiQ955s6w02fhix3QY6vLJLHR4z6blEeK+R0JFZohcpiu+aLEJuwxbNv6jIldIqZzJS2/m3zzSP2hW6eEsMimejHzE6RyF+skunqWDAdNYKntKC8Jt3177yehh0pdb/+HgXRlc9T64gn1RXAGsorWQ42iGN5SW3uRE/nXf+MUMI5LAuuQb53cKq1gc0u/wLZHRekjoOCYQcfWdXZ5aUUCs7V97Dsij3V4oWl4RnB5hjoK86L7YiacYynChOO6Ejywvhytjh3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQuT+NRXHj7IvJI4NEcPhK35KCLsoqlLjXmXUWfi7pg=;
 b=zWpO45Zr6RNt4ukQqAcr2jkqg5o04eXrI6C1TGq13sGaQMIiA3O2GdcwY08REdTnfDElM53j6g140xiwBYRss+avJnqd78KSRhQn6HoZ+Si4zvS6N74OWZUPZN/GsZszi/S+ukn7LhF/xL4nrbTEJwOrsIPqPBQllHKElPing88=
Received: from MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 03:06:34 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::9f) by MW4PR03CA0071.outlook.office365.com
 (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 03:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 03:06:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 21:06:30 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 16/17] drm/amd/pm: revise the performance level setting APIs
Date: Fri, 3 Dec 2021 11:05:39 +0800
Message-ID: <20211203030540.1710564-16-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211203030540.1710564-1-evan.quan@amd.com>
References: <20211203030540.1710564-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15918b73-8756-4cbf-e6f8-08d9b609e95f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-Microsoft-Antispam-PRVS: <MN2PR12MB479813C250E00D59F356B855E46A9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRyE6zYFptkzPnh4+Rp1wCgY1jK2ED7EJg9GORiclX+ACYwOFW9k+IYpwx33d2dUUzdibgZBOWhp9Y9LgwVZTon3H1+5RTXPiF2joxPsvBwwoPqRjHGNxgwmBh6OLohTGkZ5gqOxa059O+p5RztmCI3hm2ou44SbgFFu3SvFM1FmE1qNMf74hrl9q3A4+LTfWxCQyOr8FsXbpoTZH22YwLV+O5DKWqf85558cyzAwS0Mx5fSMti1gbXSMf8GnblgF//6iZ0OuIGduqtT3c9PtBZN6s9rDZ767RZxKOPA56gqPeyp+ggqp3A1Yi1Pmv5nxhI9VR9p9CpBlkpdmuKJJpdsoMdA+nfWANjas4waLj5wwVwDKZ2w2b+LCyPb60EBLqVaja45kswR4cr4x4KXtV6MokTI+hHLn9MuUhxbk2HLwmi0D16rTIJMwkqJrZiGwTj7fE+Dm4VmKlGU4WwY6f9bM/DDughGatk/j8Lw15zbkO/tldlQegkgyqhVoZcGZfl2VNemShCdugMPlWyi+yNtPj9kD4IWj2ZmbjOKK2BMupp3ujHQeoM2FCGAe//FOOrxIPalteTPso+4/QOHz2Iubo8/MjMrjDhS7hGwWLTIIQ2EwmV4d9/qjuj6V94H7FyP01Wd7Zy0U5NNkP3CbAPcaD099bRde3HHlCadEoEhCWhAofEkZooCmIOm9kkCJko2QBeDmFP7uMdLPWOjmuWwbFgY6jUQ7G7J4J4RKXuRfSY5E/NkVmtT9LTHouGLgQlHOJZ2MLPG+DChcODUSmZEiHZ320yj67yEYVUODLU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(86362001)(1076003)(16526019)(70206006)(316002)(8676002)(54906003)(26005)(4326008)(336012)(83380400001)(7696005)(6916009)(70586007)(2906002)(82310400004)(44832011)(508600001)(8936002)(36860700001)(426003)(5660300002)(36756003)(2616005)(47076005)(186003)(40460700001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:06:33.4410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15918b73-8756-4cbf-e6f8-08d9b609e95f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
index 4b9e68a79f06..7165e7e449d7 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -266,7 +266,6 @@ enum amd_dpm_forced_level;
  * @set_clockgating_state: enable/disable cg for the IP block
  * @set_powergating_state: enable/disable pg for the IP block
  * @get_clockgating_state: get current clockgating status
- * @enable_umd_pstate: enable UMD powerstate
  *
  * These hooks provide an interface for controlling the operational state
  * of IP blocks. After acquiring a list of IP blocks for the GPU in use,
@@ -297,7 +296,6 @@ struct amd_ip_funcs {
 	int (*set_powergating_state)(void *handle,
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u32 *flags);
-	int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
 };
 
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f5c0ae032954..5e5006af6b75 100644
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
index 1edc71dde3e4..b06229adee6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1679,14 +1679,7 @@ static int smu_enable_umd_pstate(void *handle,
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
@@ -1696,16 +1689,9 @@ static int smu_enable_umd_pstate(void *handle,
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
@@ -2151,7 +2137,6 @@ const struct amd_ip_funcs smu_ip_funcs = {
 	.soft_reset = NULL,
 	.set_clockgating_state = smu_set_clockgating_state,
 	.set_powergating_state = smu_set_powergating_state,
-	.enable_umd_pstate = smu_enable_umd_pstate,
 };
 
 const struct amdgpu_ip_block_version smu_v11_0_ip_block =
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index bb6d4b79c087..b36f18546f8f 100644
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

