Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56403C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E859410E9FF;
	Fri, 11 Feb 2022 07:52:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5A610EA05
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFfefz8Fcbu4qus1jbY5Cm7YvrdmPlEycjHs76qXn7aegG3nU9VN1QiA3UjJMpmaE/VvSGlLP3UWWox7BMMcV806Yy0uWIX5qEtP/GFIm7QAJcjS1nPB/6EhQ7sLvMrf+NDxkxodC697OTJsVC3xUQDQG6VTIoPmPdc4oXkYjT+hYIf33gVnCy2l8Op6ibc8KCImDrJ7LM7pyIL9IXBuphXkZvm04I6eXAwdngL8F41XdX5m4neO5Zfh8T2/ejRo2qE+oe/v4jJoQu7VS+CbNFqaYmwqG5gCeu2afJNfla84IGF4Tk1ZI+/uv1BU7Rim35UAsgE1utAF3mLIfLTvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S0C2ay71AZWWSuLLMSQpbDfiuc4b0MIAUyqiLTL+64=;
 b=Y5sONiZON4XAxXac4SVnGTMETuhdF7o1SRja28msMmrbLll4+pjyt90FGBCja8WKy8tk06Hh21Pn1F7TKaL1ed4DPlnhTT5mRs/b6btrddgwq52a54FBo019cJIKdPZZIvY1XgaTFmhZIdoovlNL8tch32pXj50GX3D5bI0SWN8oB7ksYQkPMZ2LdCVVYB53LaIcaMngqMeoXnK2iswpIgbmA1JDmyWP4bhTILalW1w9tPlX2Wo7dPN5BVYFSHMxn/YHI1XOZ/ClF0ZgTPI4lHc2f/Qhx5hNvCpECJk5gy4w1B2/6pbL9p8yyR6JyjM5WRdPf8OhLS9OgVA2yKkRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S0C2ay71AZWWSuLLMSQpbDfiuc4b0MIAUyqiLTL+64=;
 b=IzsRsLkU/11B+yWsFLF+AiqrVjayOdIG9L7SqeNIlEF9cVCca/Gm/Ld4yMrRmTxoKjTm+zUyHYIeODrS2uaSu/tkFtTvvSQqZRqCIDVmPMsytBOBr+/uy/l2FlSYszaNyzLfz+2vKJ2W7wVzZtGIs4/RbfdgJ3kTPqO1u8aCM7g=
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Fri, 11 Feb 2022 07:52:45 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::f9) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 07:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:52:44 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:52:42 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/pm: use adev->pm.dpm_enabled for dpm enablement
 check
Date: Fri, 11 Feb 2022 15:52:01 +0800
Message-ID: <20220211075209.894833-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220211075209.894833-1-evan.quan@amd.com>
References: <20220211075209.894833-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bda32da-8669-43d6-dc35-08d9ed337d18
X-MS-TrafficTypeDiagnostic: CH0PR12MB5251:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5251B49712770E8221EC4AB4E4309@CH0PR12MB5251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0bBTVBhbQBo5WK1nuedIld6B8ybiPRVwRwVnHNxI9BwmY3HdhsaHzhf8XbMNdBxKl/i/UArQXGKmykuWH35Po2Q/SXbmQ3055eI1XhB342ckW5zISKlXyECdwpH3Hp8tzEaGyqPRAOAyXYOmjDhI0N0gXykLMHfedDGXkCyE41K6KHfzNKOa+Mq0GKpeuq8ty3tjFHNPN2GR73e3RssRQN99XLkTZzMMT/5C8NUwrJ8sJNwSLputlSpasgDiENV7ydzXo5Vqhxe0WL6UebdWfJyQ2/ciadtRzgDCxl80908M+zNx0QNB21OSyFBbqup8Mu0VszWmefP04sBp3SocDYrtkEnEda20+ENbVKctTK9+H25BA/lozgXqr6zKtVf3MKf1o9hSrFs59p3vteOxr43J/9y0l0029jIj/jF5FjWeWmOUMk2jyo5hTfQ6dRl1TZgNKVs5azhtmJ6fiXkrTSuyyHSAoGoNsCVgfNKgK3c+aah9NrhzglVbSzwhRua43VrXImB3n+HKNf8zSQcLzIipW/XohMx3k/gps0SpdUXJWNpEIe7mJZhLHbiqjcm4L5tH6H/MuCNfeA9gh7w1RDUM9XNrY2lwN9sIfsup1poZLv3GrpAxl9+PD+vByDUtaasTM9FI2AkqczM5XdERUh/EsZHnujY13ud+33Mo6eCk6kNo3SRrkXD/VVPQgfo7DpQe3yVspMkGHMoTsd9sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(81166007)(30864003)(5660300002)(7696005)(44832011)(54906003)(6916009)(316002)(36860700001)(36756003)(47076005)(508600001)(70206006)(8676002)(1076003)(26005)(16526019)(6666004)(2616005)(8936002)(4326008)(40460700003)(70586007)(82310400004)(336012)(426003)(186003)(86362001)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:52:44.6438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bda32da-8669-43d6-dc35-08d9ed337d18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

adev->pm.dpm_enabled instead of hwmgr->pm_en can better reflect
whether the dpm features are actually enabled.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I6896dcee19bb473d26115cdcb12b6efd554b30f9
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  39 +++---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  39 +++---
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 116 +++++++++---------
 .../gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c    |   6 +
 4 files changed, 104 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 8b23cc9f098a..19e75a3c8bb1 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3079,8 +3079,9 @@ static int kv_dpm_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled)
-		kv_dpm_disable(adev);
+	adev->pm.dpm_enabled = false;
+
+	kv_dpm_disable(adev);
 
 	return 0;
 }
@@ -3089,12 +3090,13 @@ static int kv_dpm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
-		/* disable dpm */
-		kv_dpm_disable(adev);
-		/* reset the power state */
-		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
-	}
+	adev->pm.dpm_enabled = false;
+
+	/* disable dpm */
+	kv_dpm_disable(adev);
+	/* reset the power state */
+	adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+
 	return 0;
 }
 
@@ -3103,17 +3105,16 @@ static int kv_dpm_resume(void *handle)
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
-		/* asic init will reset to the boot state */
-		kv_dpm_setup_asic(adev);
-		ret = kv_dpm_enable(adev);
-		if (ret)
-			adev->pm.dpm_enabled = false;
-		else
-			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
-			amdgpu_legacy_dpm_compute_clocks(adev);
-	}
+	/* asic init will reset to the boot state */
+	kv_dpm_setup_asic(adev);
+	ret = kv_dpm_enable(adev);
+	if (ret)
+		adev->pm.dpm_enabled = false;
+	else
+		adev->pm.dpm_enabled = true;
+	if (adev->pm.dpm_enabled)
+		amdgpu_legacy_dpm_compute_clocks(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index caae54487f9c..c6a294af8de8 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7847,8 +7847,9 @@ static int si_dpm_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled)
-		si_dpm_disable(adev);
+	adev->pm.dpm_enabled = false;
+
+	si_dpm_disable(adev);
 
 	return 0;
 }
@@ -7857,12 +7858,13 @@ static int si_dpm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
-		/* disable dpm */
-		si_dpm_disable(adev);
-		/* reset the power state */
-		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
-	}
+	adev->pm.dpm_enabled = false;
+
+	/* disable dpm */
+	si_dpm_disable(adev);
+	/* reset the power state */
+	adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+
 	return 0;
 }
 
@@ -7871,17 +7873,16 @@ static int si_dpm_resume(void *handle)
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
-		/* asic init will reset to the boot state */
-		si_dpm_setup_asic(adev);
-		ret = si_dpm_enable(adev);
-		if (ret)
-			adev->pm.dpm_enabled = false;
-		else
-			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
-			amdgpu_legacy_dpm_compute_clocks(adev);
-	}
+	/* asic init will reset to the boot state */
+	si_dpm_setup_asic(adev);
+	ret = si_dpm_enable(adev);
+	if (ret)
+		adev->pm.dpm_enabled = false;
+	else
+		adev->pm.dpm_enabled = true;
+	if (adev->pm.dpm_enabled)
+		amdgpu_legacy_dpm_compute_clocks(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index a2da46bf3985..991ac4adb263 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -295,7 +295,7 @@ static int pp_set_clockgating_by_smu(void *handle, uint32_t msg_id)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->update_clock_gatings == NULL) {
@@ -335,7 +335,7 @@ static int pp_dpm_force_performance_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (level == hwmgr->dpm_level)
@@ -353,7 +353,7 @@ static enum amd_dpm_forced_level pp_dpm_get_performance_level(
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	return hwmgr->dpm_level;
@@ -363,7 +363,7 @@ static uint32_t pp_dpm_get_sclk(void *handle, bool low)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return 0;
 
 	if (hwmgr->hwmgr_func->get_sclk == NULL) {
@@ -377,7 +377,7 @@ static uint32_t pp_dpm_get_mclk(void *handle, bool low)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return 0;
 
 	if (hwmgr->hwmgr_func->get_mclk == NULL) {
@@ -391,7 +391,7 @@ static void pp_dpm_powergate_vce(void *handle, bool gate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return;
 
 	if (hwmgr->hwmgr_func->powergate_vce == NULL) {
@@ -405,7 +405,7 @@ static void pp_dpm_powergate_uvd(void *handle, bool gate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return;
 
 	if (hwmgr->hwmgr_func->powergate_uvd == NULL) {
@@ -420,7 +420,7 @@ static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_id,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	return hwmgr_handle_task(hwmgr, task_id, user_state);
@@ -432,7 +432,7 @@ static enum amd_pm_state_type pp_dpm_get_current_power_state(void *handle)
 	struct pp_power_state *state;
 	enum amd_pm_state_type pm_type;
 
-	if (!hwmgr || !hwmgr->pm_en || !hwmgr->current_ps)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !hwmgr->current_ps)
 		return -EINVAL;
 
 	state = hwmgr->current_ps;
@@ -462,7 +462,7 @@ static int pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL)
@@ -480,7 +480,7 @@ static int pp_dpm_get_fan_control_mode(void *handle, uint32_t *fan_mode)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL)
@@ -497,7 +497,7 @@ static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL)
@@ -513,7 +513,7 @@ static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL)
@@ -529,7 +529,7 @@ static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
@@ -545,7 +545,7 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL)
@@ -565,7 +565,7 @@ static int pp_dpm_get_pp_num_states(void *handle,
 
 	memset(data, 0, sizeof(*data));
 
-	if (!hwmgr || !hwmgr->pm_en ||!hwmgr->ps)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!hwmgr->ps)
 		return -EINVAL;
 
 	data->nums = hwmgr->num_ps;
@@ -597,7 +597,7 @@ static int pp_dpm_get_pp_table(void *handle, char **table)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!hwmgr->soft_pp_table)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!hwmgr->soft_pp_table)
 		return -EINVAL;
 
 	*table = (char *)hwmgr->soft_pp_table;
@@ -625,7 +625,7 @@ static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t size)
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = -ENOMEM;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (!hwmgr->hardcode_pp_table) {
@@ -655,7 +655,7 @@ static int pp_dpm_force_clock_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->force_clock_level == NULL) {
@@ -676,7 +676,7 @@ static int pp_dpm_print_clock_levels(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->print_clock_levels == NULL) {
@@ -690,7 +690,7 @@ static int pp_dpm_get_sclk_od(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->get_sclk_od == NULL) {
@@ -704,7 +704,7 @@ static int pp_dpm_set_sclk_od(void *handle, uint32_t value)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_sclk_od == NULL) {
@@ -719,7 +719,7 @@ static int pp_dpm_get_mclk_od(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->get_mclk_od == NULL) {
@@ -733,7 +733,7 @@ static int pp_dpm_set_mclk_od(void *handle, uint32_t value)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_mclk_od == NULL) {
@@ -748,7 +748,7 @@ static int pp_dpm_read_sensor(void *handle, int idx,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en || !value)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !value)
 		return -EINVAL;
 
 	switch (idx) {
@@ -774,7 +774,7 @@ pp_dpm_get_vce_clock_state(void *handle, unsigned idx)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return NULL;
 
 	if (idx < hwmgr->num_vce_state_tables)
@@ -786,7 +786,7 @@ static int pp_get_power_profile_mode(void *handle, char *buf)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func->get_power_profile_mode)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !hwmgr->hwmgr_func->get_power_profile_mode)
 		return -EOPNOTSUPP;
 	if (!buf)
 		return -EINVAL;
@@ -798,7 +798,7 @@ static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func->set_power_profile_mode)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !hwmgr->hwmgr_func->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
@@ -813,7 +813,7 @@ static int pp_set_fine_grain_clk_vol(void *handle, uint32_t type, long *input, u
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_fine_grain_clk_vol == NULL)
@@ -826,7 +826,7 @@ static int pp_odn_edit_dpm_table(void *handle, uint32_t type, long *input, uint3
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->odn_edit_dpm_table == NULL) {
@@ -860,7 +860,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 	long workload;
 	uint32_t index;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_power_profile_mode == NULL) {
@@ -900,7 +900,7 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 	struct pp_hwmgr *hwmgr = handle;
 	uint32_t max_power_limit;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_power_limit == NULL) {
@@ -932,7 +932,7 @@ static int pp_get_power_limit(void *handle, uint32_t *limit,
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
 
-	if (!hwmgr || !hwmgr->pm_en ||!limit)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!limit)
 		return -EINVAL;
 
 	if (power_type != PP_PWR_TYPE_SUSTAINED)
@@ -965,7 +965,7 @@ static int pp_display_configuration_change(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	phm_store_dal_configuration_data(hwmgr, display_config);
@@ -977,7 +977,7 @@ static int pp_get_display_power_level(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!output)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!output)
 		return -EINVAL;
 
 	return phm_get_dal_power_level(hwmgr, output);
@@ -991,7 +991,7 @@ static int pp_get_current_clocks(void *handle,
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	phm_get_dal_power_level(hwmgr, &simple_clocks);
@@ -1035,7 +1035,7 @@ static int pp_get_clock_by_type(void *handle, enum amd_pp_clock_type type, struc
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (clocks == NULL)
@@ -1050,7 +1050,7 @@ static int pp_get_clock_by_type_with_latency(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!clocks)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!clocks)
 		return -EINVAL;
 
 	return phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
@@ -1062,7 +1062,7 @@ static int pp_get_clock_by_type_with_voltage(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!clocks)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!clocks)
 		return -EINVAL;
 
 	return phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
@@ -1073,7 +1073,7 @@ static int pp_set_watermarks_for_clocks_ranges(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en || !clock_ranges)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !clock_ranges)
 		return -EINVAL;
 
 	return phm_set_watermarks_for_clocks_ranges(hwmgr,
@@ -1085,7 +1085,7 @@ static int pp_display_clock_voltage_request(void *handle,
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en ||!clock)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!clock)
 		return -EINVAL;
 
 	return phm_display_clock_voltage_request(hwmgr, clock);
@@ -1097,7 +1097,7 @@ static int pp_get_display_mode_validation_clocks(void *handle,
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
 
-	if (!hwmgr || !hwmgr->pm_en ||!clocks)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||!clocks)
 		return -EINVAL;
 
 	clocks->level = PP_DAL_POWERLEVEL_7;
@@ -1112,7 +1112,7 @@ static int pp_dpm_powergate_mmhub(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->powergate_mmhub == NULL) {
@@ -1127,7 +1127,7 @@ static int pp_dpm_powergate_gfx(void *handle, bool gate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return 0;
 
 	if (hwmgr->hwmgr_func->powergate_gfx == NULL) {
@@ -1142,7 +1142,7 @@ static void pp_dpm_powergate_acp(void *handle, bool gate)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return;
 
 	if (hwmgr->hwmgr_func->powergate_acp == NULL) {
@@ -1208,7 +1208,7 @@ static int pp_notify_smu_enable_pwe(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->smus_notify_pwe == NULL) {
@@ -1228,7 +1228,7 @@ static int pp_enable_mgpu_fan_boost(void *handle)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en ||
+	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled ||
 	     hwmgr->hwmgr_func->enable_mgpu_fan_boost == NULL)
 		return 0;
 
@@ -1241,7 +1241,7 @@ static int pp_set_min_deep_sleep_dcefclk(void *handle, uint32_t clock)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk == NULL) {
@@ -1258,7 +1258,7 @@ static int pp_set_hard_min_dcefclk_by_freq(void *handle, uint32_t clock)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq == NULL) {
@@ -1275,7 +1275,7 @@ static int pp_set_hard_min_fclk_by_freq(void *handle, uint32_t clock)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_hard_min_fclk_by_freq == NULL) {
@@ -1292,7 +1292,7 @@ static int pp_set_active_display_count(void *handle, uint32_t count)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	return phm_set_active_display_count(hwmgr, count);
@@ -1350,7 +1350,7 @@ static int pp_get_ppfeature_status(void *handle, char *buf)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en || !buf)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !buf)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->get_ppfeature_status == NULL) {
@@ -1365,7 +1365,7 @@ static int pp_set_ppfeature_status(void *handle, uint64_t ppfeature_masks)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->set_ppfeature_status == NULL) {
@@ -1395,7 +1395,7 @@ static int pp_smu_i2c_bus_access(void *handle, bool acquire)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->smu_i2c_bus_access == NULL) {
@@ -1413,7 +1413,7 @@ static int pp_set_df_cstate(void *handle, enum pp_df_cstate state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_df_cstate)
+	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !hwmgr->hwmgr_func->set_df_cstate)
 		return 0;
 
 	hwmgr->hwmgr_func->set_df_cstate(hwmgr, state);
@@ -1428,7 +1428,7 @@ static int pp_set_xgmi_pstate(void *handle, uint32_t pstate)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_xgmi_pstate)
+	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !hwmgr->hwmgr_func->set_xgmi_pstate)
 		return 0;
 
 	hwmgr->hwmgr_func->set_xgmi_pstate(hwmgr, pstate);
@@ -1443,7 +1443,7 @@ static ssize_t pp_get_gpu_metrics(void *handle, void **table)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_gpu_metrics)
+	if (!((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled || !hwmgr->hwmgr_func->get_gpu_metrics)
 		return -EOPNOTSUPP;
 
 	return hwmgr->hwmgr_func->get_gpu_metrics(hwmgr, table);
@@ -1453,7 +1453,7 @@ static int pp_gfx_state_change_set(void *handle, uint32_t state)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled)
 		return -EINVAL;
 
 	if (hwmgr->hwmgr_func->gfx_state_change == NULL) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index f2cef0930aa9..4fd61d7f6c70 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -281,6 +281,8 @@ int hwmgr_hw_fini(struct pp_hwmgr *hwmgr)
 	if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
 		return 0;
 
+	((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled = false;
+
 	phm_stop_thermal_controller(hwmgr);
 	psm_set_boot_states(hwmgr);
 	psm_adjust_power_state_dynamic(hwmgr, true, NULL);
@@ -301,6 +303,8 @@ int hwmgr_suspend(struct pp_hwmgr *hwmgr)
 	if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
 		return 0;
 
+	((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled = false;
+
 	phm_disable_smc_firmware_ctf(hwmgr);
 	ret = psm_set_boot_states(hwmgr);
 	if (ret)
@@ -336,6 +340,8 @@ int hwmgr_resume(struct pp_hwmgr *hwmgr)
 		return ret;
 
 	ret = psm_adjust_power_state_dynamic(hwmgr, false, NULL);
+	if (!ret)
+		((struct amdgpu_device *)hwmgr->adev)->pm.dpm_enabled = true;
 
 	return ret;
 }
-- 
2.29.0

