Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A192DC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 18:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1C210E426;
	Thu, 26 May 2022 18:01:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42BD10E426
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 18:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjURyS/Vak70Vi1TfyysthTYtm6ayd2gsVH+K1BDxzrIVt+wlAJkLnF8RbjJI8iL1jguesQ7+jXn8UyM+uePa85ntRqmjIs1Ol6WB7lnsYY79ENa9jx7pWbxSRcQNJ98sS59wTUpTsBy9V09Z4XEciq+rZCMW7/BMPs6L7D4Wq3liJocPOnEx3536duznqxC0uow9MpXnfeZwq2oTzGjRyy9JGaeqOBNrkFmHLDhv9PgWBPJiBCTrl8v2Ak3KvrVs3NF3HyOoVibn/VEVEXOHnd3gO0RjFaVL7NwQn65M9Cde8C4mpJ+rxWYL3clOJfJEOZm1r+b6HVWpFRzq7n8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p7x0WAOPohxYxgEgzx/RblqOWEKgAOuFZFcJ6SywY8=;
 b=JMurxoOCHdSfCFo4OvNoggHqIMIUQ+zEHTQRK2bqfQ7grfY40YTKDmf4n6ynygA5hZGF7d3OWrvGJJ+lUObm73gjZR/eIX7l+pt9uhQ0b3ZDTuNqqrOMKkgqM8rcF+5cc7TrOBt9uWys+ftTh/1gMtCjBMdSHSogra27isIcfIHzW+xtE5mneFzJ2u6QhMrX5MKlDJGbnMAdLr7CKDipxvcByn1VUVbqYGYWuUhYI0wRq2wynM8XTaMzQL+rbbioFAoYTSOGHd5itb9AKD7EDxtYF8q9euhQYAQvvli+H0jYdI7vDZmPEFyZmkM17ystaEHOGyPzg5ITPImgCvQUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p7x0WAOPohxYxgEgzx/RblqOWEKgAOuFZFcJ6SywY8=;
 b=g78KbqiSp+Uu49Lwt4RkSXa5EiBxEDLbVsosrFPDDffJTWzcFORcFVUiG1mUSld1r0oQJcK4OYtla2CxD/1SfcCyhLs8lY5el/Rwk6+fLpsQF4d5a7vcgRRrIDvL+Magp1n2U1q+0SEpkzPH7Jg7eiPWLPB5ICChm8spoocgF0Q=
Received: from BN6PR19CA0114.namprd19.prod.outlook.com (2603:10b6:404:a0::28)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 18:01:42 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::36) by BN6PR19CA0114.outlook.office365.com
 (2603:10b6:404:a0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 18:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 18:01:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 13:01:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/pm: implement the SMU_MSG_EnableGfxImu function
Date: Thu, 26 May 2022 14:01:22 -0400
Message-ID: <20220526180123.3044888-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b20be28e-9169-49ba-ec8e-08da3f41ca4e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4248:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42488EBB4851D8EEC52766CAF7D99@CH2PR12MB4248.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpAN/UbdptE6tTKoGdzNWvPlVb5HBQRWj3uO/y6mrmXmMtfT5Q3C5o3XiWuO+6MzdMNiGnZNZutWWnV29eE9WbLn7E+2kKXPMSQQj6BU8RNp6sdiAna9IMmwhN2OEv6Nc1+0N3CtrjGVSVTpIZ/cbm1n88cRyLV8IwWMwRW54kS60JVTQbJ6uqS3je+HapXhx8lhxt/nt9JFsJ3I32ECcSiA7rXZV5a8DGOUmk7xuohZw4Ij7FuFQxiejdnUiptokEu1J5/kWAi/61ALyNFUlb2y3bJXu9gogHv1gV78mgrZ7NLMxheCYk0Pjkys8KnrPB3YsWOMCEmoJxmLyVcgRaABwdjTU8nO87V2ZWKUPZ1ZbhWuuyqCvYd5PoPeuieERjc6fSOrXnlXqqB0qeBHJIrMxOjcDIGWc+xIVRvALqPE2WExOFCX6aqsHPVLEV8qehCQYtBXPl3Iif/XMjGvlYOAJM56uIrvmDQ8KEJtLXnuwvBP8aMMPJ2z7jyo/CAUhDPLp4blaTy91iC/kJmte9bukAfCeikVxL4/GC9hDg2ql2SnPHgKgsCuUt/w8RMgbyYfqvNqDnV9ptoxsxH2YTWaSjVBroIgBgYZDAdTMUYGBZs81qRC406OERXYccyP6kea+18bQMegHL09IU6Risv8tZsLrrAdj4kfAPRKFWxzO+TGlM7+J0E9eBNoJmkvgw3/mnbu4YiW7VILR4+seg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(6916009)(54906003)(356005)(81166007)(86362001)(8676002)(40460700003)(4326008)(8936002)(70586007)(70206006)(316002)(508600001)(7696005)(2616005)(16526019)(186003)(1076003)(83380400001)(36756003)(426003)(47076005)(336012)(36860700001)(26005)(82310400005)(2906002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 18:01:42.5159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20be28e-9169-49ba-ec8e-08da3f41ca4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

GC v11_0_1 asic needs to issue the EnableGfxImu message after start IMU.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                | 14 ++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  9 ++++++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 10 ++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |  1 +
 7 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index d1bf073adf54..956b6ce81c84 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -107,6 +107,20 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	return ret;
 }
 
+int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_set_gfx_power_up_by_imu(smu);
+	mutex_unlock(&adev->pm.mutex);
+
+	msleep(10);
+
+	return ret;
+}
+
 int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 3e78b3057277..524fb09437e5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -386,6 +386,8 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
 int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 			     enum pp_mp1_state mp1_state);
 
+int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);
+
 int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
 
 int amdgpu_dpm_baco_enter(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a601024ba4de..ae595ee544dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -134,6 +134,14 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
+int smu_set_gfx_power_up_by_imu(struct smu_context *smu)
+{
+	if (!smu->ppt_funcs && !smu->ppt_funcs->set_gfx_power_up_by_imu)
+		return -EOPNOTSUPP;
+
+	return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
+}
+
 static u32 smu_get_mclk(void *handle, bool low)
 {
 	struct smu_context *smu = handle;
@@ -2467,7 +2475,6 @@ static int smu_set_power_profile_mode(void *handle,
 	return smu_bump_power_profile_mode(smu, param, param_size);
 }
 
-
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
 {
 	struct smu_context *smu = handle;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 36af1f417dcd..6d51e4340aad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -701,6 +701,11 @@ struct pptable_funcs {
 	 */
 	int (*dpm_set_jpeg_enable)(struct smu_context *smu, bool enable);
 
+	/**
+	 * @set_gfx_power_up_by_imu: Enable GFX engine with IMU
+	 */
+	int (*set_gfx_power_up_by_imu)(struct smu_context *smu);
+
 	/**
 	 * @read_sensor: Read data from a sensor.
 	 * &sensor: Sensor to read data from.
@@ -1442,6 +1447,8 @@ int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 
+int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
+
 int smu_set_ac_dc(struct smu_context *smu);
 
 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index f60dcc4f7e75..fe9c47c87abc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -292,6 +292,8 @@ int smu_v13_0_baco_enter(struct smu_context *smu);
 
 int smu_v13_0_baco_exit(struct smu_context *smu);
 
+int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu);
+
 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
 				enum PP_OD_DPM_TABLE_COMMAND type,
 				long input[],
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 6fd3216b91d0..6db10e49db7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2306,6 +2306,16 @@ int smu_v13_0_baco_exit(struct smu_context *smu)
 					SMU_BACO_STATE_EXIT);
 }
 
+int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
+{
+	uint16_t index;
+
+	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
+					       SMU_MSG_EnableGfxImu);
+
+	return smu_cmn_send_msg_without_waiting(smu, index, 0);
+}
+
 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
 				enum PP_OD_DPM_TABLE_COMMAND type,
 				long input[], uint32_t size)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 8ccda593fc50..196670345552 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1039,6 +1039,7 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 	.force_clk_levels = smu_v13_0_4_force_clk_levels,
 	.set_performance_level = smu_v13_0_4_set_performance_level,
 	.set_fine_grain_gfx_freq_parameters = smu_v13_0_4_set_fine_grain_gfx_freq_parameters,
+	.set_gfx_power_up_by_imu = smu_v13_0_set_gfx_power_up_by_imu,
 };
 
 void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.3

