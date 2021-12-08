Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484BCC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58E76E0CF;
	Wed,  8 Dec 2021 02:37:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6104D6E0CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECLAC6vSD8tm6esUnLhLFFKsjVBUrRUA6mN9Unq+XyLDKPfmBZaDMK06matHrreqcllbF+watNb/74E/0tKq+Uji4iHIh3RfHAhqlcNZXDQDUnrujqgd05ITb4o2RdcjSYT0obvm9CtQGUrDBkxr46bsCl7WX6MMmkNsxJ31P632GEkQXdpsaaUfi4fDgekU2hYxQ0viIL1JeNfS5l/3SRzHb7qtLcV1TigiBNlfyu8h+/f2dvNta7Q6avHaR9LPAtZ6q1rgFqY/gaxau6XMGqcFhOpe7pW+wLN9yw94HRi8jNOhXeGZ6ifCtyuU7nv4qYyrDgVXONq1iz7tySLr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4Iy5rGMTSuHeQ9/ykdw+v4BlCTPq3lQKPTNlMC8sxs=;
 b=RKfLLNYZ9oz31HgjgQj9oB/KQshpc9CWsgPeeHj+iq3BL6f1iNhDjxgK6XPB2hk/4rGGNaK29m9rO/Dawg5VRblC295nLmR4DKZFLYCPMjWwVGelq3ZmId70V8izsI3Slk1EcqQxx5K2pxvJ/RNevqNe8tRSadqZYODSpHPO2pX89YNKam40vDZiTDf5YluOXtX6QyZY5PgutLqxLPFAm4CpdwJs26SGGkIEVHZPEZ00jA+OmoxTAw5LwBAhdrutW8TUUpIE7z8JR7H6Xo3PSoeBkVHmz8MkS8XoZaqbD3PJ8Or1Y0MUiIOI3O5lVjc5CHsLIeIYzOV2bGJhlF3+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4Iy5rGMTSuHeQ9/ykdw+v4BlCTPq3lQKPTNlMC8sxs=;
 b=jGqWQdwtCUxq/fiCmV8HP2vxh8GOClfVq+TtlX3jynZijUlVuMBQpY1M0LBt+9ZH7RLNhIyWug0+RG4RytGi4Ffk7PVUYc8JzMT5foxZ5nMGp63EKXK+JnrOGpiYTTmt6seqhwq3GOPQZWj2ahMB6NJ1HAOLZhCnqc2fwpX1uJw=
Received: from MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 02:37:46 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ce) by MW4PR04CA0214.outlook.office365.com
 (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Wed, 8 Dec 2021 02:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:37:46 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:37:44 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amd/pm: drop unneeded hwmgr->smu_lock
Date: Wed, 8 Dec 2021 10:37:07 +0800
Message-ID: <20211208023707.1814122-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211208023707.1814122-1-evan.quan@amd.com>
References: <20211208023707.1814122-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddd8d133-52af-4638-ede6-08d9b9f3b830
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB441607CD5DDADCF510943B8FE46F9@SA0PR12MB4416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IE6fMlbJv8TW74Gca+Iv6CQVB9eB+nUyFH8/viZmOrx9w9wToPBx41IEZD215S1iVs1KwPV3CNNJ79buNLr2sfZDSyFftaQvRf5hBC9fJ5isH0KJDggCsxKe3607YebRaEWxcQn4ZR0oSnrdI0lVAXAl8kBiQO805tXosVyFTTmRy+QcNaQFYIkxs9GpyTCGcqEvVmHGzsVDqfHfPN9n+F2G4DbiHFRr/9Ohu5hLa4yzV8kiZnpAtqrnK+mNNgb24RtE/PTHFom9a1OAmHBYiZ6JgtshQBILdKZr5IMyM+jbZpqneBvtaD3/7Qg0xctYL4jo++kOIdrZt2dzpXBLFBPGILSa5BUaL+M9YQkmqe9g/H6v3umRkO6D6ytYq17O9GC/BoRThYiJLsBoTQQCbvB4VImYNqkeeBoBVODSfMVzgIGULttz/0/8ZOfGQbZCvbykERtGZSk3dCZ/NJ6jt8yb8vBo9bHC95fRzCAhjbwI1mW6x2trc/qgXz7CsL4baG8r7ewlFVOjPiAwuiuYgB8PsgNDuBDTLck+OprXNPwEVSKDkRFChkSKF9GQdK8VH9HpM276XvvBztd/bsh+gxFjbwWR/6zIl73vNlQ/lM6WCDxQiAYe94kJ5uRdGvjoBkTNbyMZIr/Ihrdk23qfwz5zW+GH+D1JHjJBPdMO+DjVrDUwmrHj9C9fcGZsXmw9TDqbMsWIvMTRK2EI17sxeXG6CxFCRUgEFR/57YR5hcKNmw140UbyMdtdkZ8Yi5KjzAK24tpdcGartTgZoNPaoImasO2eyRfsfsv7+GrNCHY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(83380400001)(40460700001)(508600001)(316002)(7696005)(26005)(356005)(36756003)(82310400004)(5660300002)(1076003)(30864003)(81166007)(8676002)(47076005)(70206006)(86362001)(426003)(54906003)(8936002)(6916009)(4326008)(36860700001)(336012)(70586007)(186003)(16526019)(2616005)(6666004)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:37:46.6275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd8d133-52af-4638-ede6-08d9b9f3b830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

As all those related APIs are already well protected by adev->pm.mutex.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I36426791d3bbc9d84a6ae437da26a892682eb0cb
---
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 282 +++---------------
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   1 -
 2 files changed, 39 insertions(+), 244 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 5a14ddd3ef05..3656a77baea4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -50,7 +50,6 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
 	hwmgr->device = amdgpu_cgs_create_device(adev);
-	mutex_init(&hwmgr->smu_lock);
 	mutex_init(&hwmgr->msg_lock);
 	hwmgr->chip_family = adev->family;
 	hwmgr->chip_id = adev->asic_type;
@@ -178,12 +177,9 @@ static int pp_late_init(void *handle)
 	struct amdgpu_device *adev = handle;
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 
-	if (hwmgr && hwmgr->pm_en) {
-		mutex_lock(&hwmgr->smu_lock);
+	if (hwmgr && hwmgr->pm_en)
 		hwmgr_handle_task(hwmgr,
 					AMD_PP_TASK_COMPLETE_INIT, NULL);
-		mutex_unlock(&hwmgr->smu_lock);
-	}
 	if (adev->pm.smu_prv_buffer_size != 0)
 		pp_reserve_vram_for_smu(adev);
 
@@ -345,11 +341,9 @@ static int pp_dpm_force_performance_level(void *handle,
 	if (level == hwmgr->dpm_level)
 		return 0;
 
-	mutex_lock(&hwmgr->smu_lock);
 	pp_dpm_en_umd_pstate(hwmgr, &level);
 	hwmgr->request_dpm_level = level;
 	hwmgr_handle_task(hwmgr, AMD_PP_TASK_READJUST_POWER_STATE, NULL);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -358,21 +352,16 @@ static enum amd_dpm_forced_level pp_dpm_get_performance_level(
 								void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	enum amd_dpm_forced_level level;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	level = hwmgr->dpm_level;
-	mutex_unlock(&hwmgr->smu_lock);
-	return level;
+	return hwmgr->dpm_level;
 }
 
 static uint32_t pp_dpm_get_sclk(void *handle, bool low)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	uint32_t clk = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return 0;
@@ -381,16 +370,12 @@ static uint32_t pp_dpm_get_sclk(void *handle, bool low)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
-	mutex_lock(&hwmgr->smu_lock);
-	clk = hwmgr->hwmgr_func->get_sclk(hwmgr, low);
-	mutex_unlock(&hwmgr->smu_lock);
-	return clk;
+	return hwmgr->hwmgr_func->get_sclk(hwmgr, low);
 }
 
 static uint32_t pp_dpm_get_mclk(void *handle, bool low)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	uint32_t clk = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return 0;
@@ -399,10 +384,7 @@ static uint32_t pp_dpm_get_mclk(void *handle, bool low)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
-	mutex_lock(&hwmgr->smu_lock);
-	clk = hwmgr->hwmgr_func->get_mclk(hwmgr, low);
-	mutex_unlock(&hwmgr->smu_lock);
-	return clk;
+	return hwmgr->hwmgr_func->get_mclk(hwmgr, low);
 }
 
 static void pp_dpm_powergate_vce(void *handle, bool gate)
@@ -416,9 +398,7 @@ static void pp_dpm_powergate_vce(void *handle, bool gate)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
 	}
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->powergate_vce(hwmgr, gate);
-	mutex_unlock(&hwmgr->smu_lock);
 }
 
 static void pp_dpm_powergate_uvd(void *handle, bool gate)
@@ -432,25 +412,18 @@ static void pp_dpm_powergate_uvd(void *handle, bool gate)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
 	}
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->powergate_uvd(hwmgr, gate);
-	mutex_unlock(&hwmgr->smu_lock);
 }
 
 static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_id,
 		enum amd_pm_state_type *user_state)
 {
-	int ret = 0;
 	struct pp_hwmgr *hwmgr = handle;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr_handle_task(hwmgr, task_id, user_state);
-	mutex_unlock(&hwmgr->smu_lock);
-
-	return ret;
+	return hwmgr_handle_task(hwmgr, task_id, user_state);
 }
 
 static enum amd_pm_state_type pp_dpm_get_current_power_state(void *handle)
@@ -462,8 +435,6 @@ static enum amd_pm_state_type pp_dpm_get_current_power_state(void *handle)
 	if (!hwmgr || !hwmgr->pm_en || !hwmgr->current_ps)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-
 	state = hwmgr->current_ps;
 
 	switch (state->classification.ui_label) {
@@ -483,7 +454,6 @@ static enum amd_pm_state_type pp_dpm_get_current_power_state(void *handle)
 			pm_type = POWER_STATE_TYPE_DEFAULT;
 		break;
 	}
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return pm_type;
 }
@@ -499,15 +469,12 @@ static void pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return;
 	}
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->set_fan_control_mode(hwmgr, mode);
-	mutex_unlock(&hwmgr->smu_lock);
 }
 
 static uint32_t pp_dpm_get_fan_control_mode(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	uint32_t mode = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return 0;
@@ -516,16 +483,12 @@ static uint32_t pp_dpm_get_fan_control_mode(void *handle)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
-	mutex_lock(&hwmgr->smu_lock);
-	mode = hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
-	mutex_unlock(&hwmgr->smu_lock);
-	return mode;
+	return hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
 }
 
 static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -534,16 +497,12 @@ static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
 }
 
 static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -553,16 +512,12 @@ static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)
 		return 0;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
 }
 
 static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -570,16 +525,12 @@ static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)
 	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->get_fan_speed_rpm(hwmgr, rpm);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->get_fan_speed_rpm(hwmgr, rpm);
 }
 
 static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -588,10 +539,7 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
 }
 
 static int pp_dpm_get_pp_num_states(void *handle,
@@ -605,8 +553,6 @@ static int pp_dpm_get_pp_num_states(void *handle,
 	if (!hwmgr || !hwmgr->pm_en ||!hwmgr->ps)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-
 	data->nums = hwmgr->num_ps;
 
 	for (i = 0; i < hwmgr->num_ps; i++) {
@@ -629,23 +575,18 @@ static int pp_dpm_get_pp_num_states(void *handle,
 				data->states[i] = POWER_STATE_TYPE_DEFAULT;
 		}
 	}
-	mutex_unlock(&hwmgr->smu_lock);
 	return 0;
 }
 
 static int pp_dpm_get_pp_table(void *handle, char **table)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int size = 0;
 
 	if (!hwmgr || !hwmgr->pm_en ||!hwmgr->soft_pp_table)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
 	*table = (char *)hwmgr->soft_pp_table;
-	size = hwmgr->soft_pp_table_size;
-	mutex_unlock(&hwmgr->smu_lock);
-	return size;
+	return hwmgr->soft_pp_table_size;
 }
 
 static int amd_powerplay_reset(void *handle)
@@ -672,13 +613,12 @@ static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t size)
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
 	if (!hwmgr->hardcode_pp_table) {
 		hwmgr->hardcode_pp_table = kmemdup(hwmgr->soft_pp_table,
 						   hwmgr->soft_pp_table_size,
 						   GFP_KERNEL);
 		if (!hwmgr->hardcode_pp_table)
-			goto err;
+			return ret;
 	}
 
 	memcpy(hwmgr->hardcode_pp_table, buf, size);
@@ -687,17 +627,11 @@ static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t size)
 
 	ret = amd_powerplay_reset(handle);
 	if (ret)
-		goto err;
+		return ret;
 
-	if (hwmgr->hwmgr_func->avfs_control) {
+	if (hwmgr->hwmgr_func->avfs_control)
 		ret = hwmgr->hwmgr_func->avfs_control(hwmgr, false);
-		if (ret)
-			goto err;
-	}
-	mutex_unlock(&hwmgr->smu_lock);
-	return 0;
-err:
-	mutex_unlock(&hwmgr->smu_lock);
+
 	return ret;
 }
 
@@ -705,7 +639,6 @@ static int pp_dpm_force_clock_level(void *handle,
 		enum pp_clock_type type, uint32_t mask)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -720,17 +653,13 @@ static int pp_dpm_force_clock_level(void *handle,
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->force_clock_level(hwmgr, type, mask);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->force_clock_level(hwmgr, type, mask);
 }
 
 static int pp_dpm_print_clock_levels(void *handle,
 		enum pp_clock_type type, char *buf)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -739,16 +668,12 @@ static int pp_dpm_print_clock_levels(void *handle,
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->print_clock_levels(hwmgr, type, buf);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->print_clock_levels(hwmgr, type, buf);
 }
 
 static int pp_dpm_get_sclk_od(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -757,16 +682,12 @@ static int pp_dpm_get_sclk_od(void *handle)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->get_sclk_od(hwmgr);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->get_sclk_od(hwmgr);
 }
 
 static int pp_dpm_set_sclk_od(void *handle, uint32_t value)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -776,16 +697,12 @@ static int pp_dpm_set_sclk_od(void *handle, uint32_t value)
 		return 0;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->set_sclk_od(hwmgr, value);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->set_sclk_od(hwmgr, value);
 }
 
 static int pp_dpm_get_mclk_od(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -794,16 +711,12 @@ static int pp_dpm_get_mclk_od(void *handle)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->get_mclk_od(hwmgr);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->get_mclk_od(hwmgr);
 }
 
 static int pp_dpm_set_mclk_od(void *handle, uint32_t value)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -812,17 +725,13 @@ static int pp_dpm_set_mclk_od(void *handle, uint32_t value)
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
 		return 0;
 	}
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->set_mclk_od(hwmgr, value);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->set_mclk_od(hwmgr, value);
 }
 
 static int pp_dpm_read_sensor(void *handle, int idx,
 			      void *value, int *size)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en || !value)
 		return -EINVAL;
@@ -841,10 +750,7 @@ static int pp_dpm_read_sensor(void *handle, int idx,
 		*((uint32_t *)value) = hwmgr->thermal_controller.fanInfo.ulMaxRPM;
 		return 0;
 	default:
-		mutex_lock(&hwmgr->smu_lock);
-		ret = hwmgr->hwmgr_func->read_sensor(hwmgr, idx, value, size);
-		mutex_unlock(&hwmgr->smu_lock);
-		return ret;
+		return hwmgr->hwmgr_func->read_sensor(hwmgr, idx, value, size);
 	}
 }
 
@@ -864,36 +770,28 @@ pp_dpm_get_vce_clock_state(void *handle, unsigned idx)
 static int pp_get_power_profile_mode(void *handle, char *buf)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret;
 
 	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func->get_power_profile_mode)
 		return -EOPNOTSUPP;
 	if (!buf)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->get_power_profile_mode(hwmgr, buf);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->get_power_profile_mode(hwmgr, buf);
 }
 
 static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = -EOPNOTSUPP;
 
 	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func->set_power_profile_mode)
-		return ret;
+		return -EOPNOTSUPP;
 
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
 		pr_debug("power profile setting is for manual dpm mode only.\n");
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, input, size);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, input, size);
 }
 
 static int pp_set_fine_grain_clk_vol(void *handle, uint32_t type, long *input, uint32_t size)
@@ -958,8 +856,6 @@ static int pp_dpm_switch_power_profile(void *handle,
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-
 	if (!en) {
 		hwmgr->workload_mask &= ~(1 << hwmgr->workload_prority[type]);
 		index = fls(hwmgr->workload_mask);
@@ -974,15 +870,12 @@ static int pp_dpm_switch_power_profile(void *handle,
 
 	if (type == PP_SMC_POWER_PROFILE_COMPUTE &&
 		hwmgr->hwmgr_func->disable_power_features_for_compute_performance) {
-			if (hwmgr->hwmgr_func->disable_power_features_for_compute_performance(hwmgr, en)) {
-				mutex_unlock(&hwmgr->smu_lock);
+			if (hwmgr->hwmgr_func->disable_power_features_for_compute_performance(hwmgr, en))
 				return -EINVAL;
-			}
 	}
 
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
 		hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1012,10 +905,8 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 	if (limit > max_power_limit)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->set_power_limit(hwmgr, limit);
 	hwmgr->power_limit = limit;
-	mutex_unlock(&hwmgr->smu_lock);
 	return 0;
 }
 
@@ -1032,8 +923,6 @@ static int pp_get_power_limit(void *handle, uint32_t *limit,
 	if (power_type != PP_PWR_TYPE_SUSTAINED)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&hwmgr->smu_lock);
-
 	switch (pp_limit_level) {
 		case PP_PWR_LIMIT_CURRENT:
 			*limit = hwmgr->power_limit;
@@ -1053,8 +942,6 @@ static int pp_get_power_limit(void *handle, uint32_t *limit,
 			break;
 	}
 
-	mutex_unlock(&hwmgr->smu_lock);
-
 	return ret;
 }
 
@@ -1066,9 +953,7 @@ static int pp_display_configuration_change(void *handle,
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
 	phm_store_dal_configuration_data(hwmgr, display_config);
-	mutex_unlock(&hwmgr->smu_lock);
 	return 0;
 }
 
@@ -1076,15 +961,11 @@ static int pp_get_display_power_level(void *handle,
 		struct amd_pp_simple_clock_info *output)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en ||!output)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = phm_get_dal_power_level(hwmgr, output);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return phm_get_dal_power_level(hwmgr, output);
 }
 
 static int pp_get_current_clocks(void *handle,
@@ -1098,8 +979,6 @@ static int pp_get_current_clocks(void *handle,
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-
 	phm_get_dal_power_level(hwmgr, &simple_clocks);
 
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
@@ -1112,7 +991,6 @@ static int pp_get_current_clocks(void *handle,
 
 	if (ret) {
 		pr_debug("Error in phm_get_clock_info \n");
-		mutex_unlock(&hwmgr->smu_lock);
 		return -EINVAL;
 	}
 
@@ -1135,14 +1013,12 @@ static int pp_get_current_clocks(void *handle,
 		clocks->max_engine_clock_in_sr = hw_clocks.max_eng_clk;
 		clocks->min_engine_clock_in_sr = hw_clocks.min_eng_clk;
 	}
-	mutex_unlock(&hwmgr->smu_lock);
 	return 0;
 }
 
 static int pp_get_clock_by_type(void *handle, enum amd_pp_clock_type type, struct amd_pp_clocks *clocks)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -1150,10 +1026,7 @@ static int pp_get_clock_by_type(void *handle, enum amd_pp_clock_type type, struc
 	if (clocks == NULL)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = phm_get_clock_by_type(hwmgr, type, clocks);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return phm_get_clock_by_type(hwmgr, type, clocks);
 }
 
 static int pp_get_clock_by_type_with_latency(void *handle,
@@ -1161,15 +1034,11 @@ static int pp_get_clock_by_type_with_latency(void *handle,
 		struct pp_clock_levels_with_latency *clocks)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en ||!clocks)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
 }
 
 static int pp_get_clock_by_type_with_voltage(void *handle,
@@ -1177,50 +1046,34 @@ static int pp_get_clock_by_type_with_voltage(void *handle,
 		struct pp_clock_levels_with_voltage *clocks)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en ||!clocks)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-
-	ret = phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
-
-	mutex_unlock(&hwmgr->smu_lock);
-	return ret;
+	return phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
 }
 
 static int pp_set_watermarks_for_clocks_ranges(void *handle,
 		void *clock_ranges)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en || !clock_ranges)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = phm_set_watermarks_for_clocks_ranges(hwmgr,
-			clock_ranges);
-	mutex_unlock(&hwmgr->smu_lock);
-
-	return ret;
+	return phm_set_watermarks_for_clocks_ranges(hwmgr,
+						    clock_ranges);
 }
 
 static int pp_display_clock_voltage_request(void *handle,
 		struct pp_display_clock_request *clock)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en ||!clock)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = phm_display_clock_voltage_request(hwmgr, clock);
-	mutex_unlock(&hwmgr->smu_lock);
-
-	return ret;
+	return phm_display_clock_voltage_request(hwmgr, clock);
 }
 
 static int pp_get_display_mode_validation_clocks(void *handle,
@@ -1234,12 +1087,9 @@ static int pp_get_display_mode_validation_clocks(void *handle,
 
 	clocks->level = PP_DAL_POWERLEVEL_7;
 
-	mutex_lock(&hwmgr->smu_lock);
-
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_DynamicPatchPowerState))
 		ret = phm_get_max_high_clocks(hwmgr, clocks);
 
-	mutex_unlock(&hwmgr->smu_lock);
 	return ret;
 }
 
@@ -1346,9 +1196,7 @@ static int pp_notify_smu_enable_pwe(void *handle)
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->smus_notify_pwe(hwmgr);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1364,9 +1212,7 @@ static int pp_enable_mgpu_fan_boost(void *handle)
 	     hwmgr->hwmgr_func->enable_mgpu_fan_boost == NULL)
 		return 0;
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->enable_mgpu_fan_boost(hwmgr);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1383,9 +1229,7 @@ static int pp_set_min_deep_sleep_dcefclk(void *handle, uint32_t clock)
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk(hwmgr, clock);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1402,9 +1246,7 @@ static int pp_set_hard_min_dcefclk_by_freq(void *handle, uint32_t clock)
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq(hwmgr, clock);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1421,9 +1263,7 @@ static int pp_set_hard_min_fclk_by_freq(void *handle, uint32_t clock)
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->set_hard_min_fclk_by_freq(hwmgr, clock);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1431,16 +1271,11 @@ static int pp_set_hard_min_fclk_by_freq(void *handle, uint32_t clock)
 static int pp_set_active_display_count(void *handle, uint32_t count)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = phm_set_active_display_count(hwmgr, count);
-	mutex_unlock(&hwmgr->smu_lock);
-
-	return ret;
+	return phm_set_active_display_count(hwmgr, count);
 }
 
 static int pp_get_asic_baco_capability(void *handle, bool *cap)
@@ -1455,9 +1290,7 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 		!hwmgr->hwmgr_func->get_asic_baco_capability)
 		return 0;
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1472,9 +1305,7 @@ static int pp_get_asic_baco_state(void *handle, int *state)
 	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
 		return 0;
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->get_asic_baco_state(hwmgr, (enum BACO_STATE *)state);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1490,9 +1321,7 @@ static int pp_set_asic_baco_state(void *handle, int state)
 		!hwmgr->hwmgr_func->set_asic_baco_state)
 		return 0;
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->set_asic_baco_state(hwmgr, (enum BACO_STATE)state);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1500,7 +1329,6 @@ static int pp_set_asic_baco_state(void *handle, int state)
 static int pp_get_ppfeature_status(void *handle, char *buf)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en || !buf)
 		return -EINVAL;
@@ -1510,17 +1338,12 @@ static int pp_get_ppfeature_status(void *handle, char *buf)
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->get_ppfeature_status(hwmgr, buf);
-	mutex_unlock(&hwmgr->smu_lock);
-
-	return ret;
+	return hwmgr->hwmgr_func->get_ppfeature_status(hwmgr, buf);
 }
 
 static int pp_set_ppfeature_status(void *handle, uint64_t ppfeature_masks)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -1530,17 +1353,12 @@ static int pp_set_ppfeature_status(void *handle, uint64_t ppfeature_masks)
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->set_ppfeature_status(hwmgr, ppfeature_masks);
-	mutex_unlock(&hwmgr->smu_lock);
-
-	return ret;
+	return hwmgr->hwmgr_func->set_ppfeature_status(hwmgr, ppfeature_masks);
 }
 
 static int pp_asic_reset_mode_2(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -1550,17 +1368,12 @@ static int pp_asic_reset_mode_2(void *handle)
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->asic_reset(hwmgr, SMU_ASIC_RESET_MODE_2);
-	mutex_unlock(&hwmgr->smu_lock);
-
-	return ret;
+	return hwmgr->hwmgr_func->asic_reset(hwmgr, SMU_ASIC_RESET_MODE_2);
 }
 
 static int pp_smu_i2c_bus_access(void *handle, bool acquire)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
@@ -1570,11 +1383,7 @@ static int pp_smu_i2c_bus_access(void *handle, bool acquire)
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
-	ret = hwmgr->hwmgr_func->smu_i2c_bus_access(hwmgr, acquire);
-	mutex_unlock(&hwmgr->smu_lock);
-
-	return ret;
+	return hwmgr->hwmgr_func->smu_i2c_bus_access(hwmgr, acquire);
 }
 
 static int pp_set_df_cstate(void *handle, enum pp_df_cstate state)
@@ -1587,9 +1396,7 @@ static int pp_set_df_cstate(void *handle, enum pp_df_cstate state)
 	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_df_cstate)
 		return 0;
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->set_df_cstate(hwmgr, state);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1604,9 +1411,7 @@ static int pp_set_xgmi_pstate(void *handle, uint32_t pstate)
 	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_xgmi_pstate)
 		return 0;
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->set_xgmi_pstate(hwmgr, pstate);
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
@@ -1614,7 +1419,6 @@ static int pp_set_xgmi_pstate(void *handle, uint32_t pstate)
 static ssize_t pp_get_gpu_metrics(void *handle, void **table)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	ssize_t size;
 
 	if (!hwmgr)
 		return -EINVAL;
@@ -1622,11 +1426,7 @@ static ssize_t pp_get_gpu_metrics(void *handle, void **table)
 	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_gpu_metrics)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&hwmgr->smu_lock);
-	size = hwmgr->hwmgr_func->get_gpu_metrics(hwmgr, table);
-	mutex_unlock(&hwmgr->smu_lock);
-
-	return size;
+	return hwmgr->hwmgr_func->get_gpu_metrics(hwmgr, table);
 }
 
 static int pp_gfx_state_change_set(void *handle, uint32_t state)
@@ -1641,9 +1441,7 @@ static int pp_gfx_state_change_set(void *handle, uint32_t state)
 		return -EINVAL;
 	}
 
-	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->gfx_state_change(hwmgr, state);
-	mutex_unlock(&hwmgr->smu_lock);
 	return 0;
 }
 
@@ -1657,12 +1455,10 @@ static int pp_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 
 	*addr = NULL;
 	*size = 0;
-	mutex_lock(&hwmgr->smu_lock);
 	if (adev->pm.smu_prv_buffer) {
 		amdgpu_bo_kmap(adev->pm.smu_prv_buffer, addr);
 		*size = adev->pm.smu_prv_buffer_size;
 	}
-	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 03226baea65e..4f7f2f455301 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -748,7 +748,6 @@ struct pp_hwmgr {
 	bool not_vf;
 	bool pm_en;
 	bool pp_one_vf;
-	struct mutex smu_lock;
 	struct mutex msg_lock;
 
 	uint32_t pp_table_version;
-- 
2.29.0

