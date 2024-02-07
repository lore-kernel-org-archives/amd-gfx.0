Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D27C4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 13:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014FF113277;
	Wed,  7 Feb 2024 13:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y8GF8YKa";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBFC11326F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 13:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILasxm6f+XOjvqgDtiUhLE6U9Dh63UTk8VGS5b2GBaetaZvJ7Z1Wu6UZ/lrHkq+VMUyNzNR1zctAIX0hv6UvdqCly9PsgnqP6KBNXNIi2xtG4eZF4H0gJw1u6j3ve/ZDOPVm4rUWQVvOYY9DPy+DJdad9aNUppl30IxBAtmv8pM+LCXVWOZSC5j7gBnBbA3SJncM6AQc+0WFVN7jO1yNexH660ygDGL8uibp4rLwjKkzLxz8k0WME7SPVtIkme+kAa+kd46AHXAwRcME3HmqAh70nY1ON9nDa14LfUOUu/oo/iS6Swai5fJyC64Bn9Q+XjJW5pX/ZJHr1WRgP+XYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qy8k3yueLps1NlttHYq9rrxFk4XF626J6LYDrWlMB4=;
 b=K50q6+xmeuVaX8eori0D5FPC2ic4wC9Gp6j/PjOhWQjAUE3VtXkn4A7ex9WQEaVIRQcemExIDmwdF8xEWdzUnT1W08RKrNBA2h/LyLiIE2BYsEVkVH0mCkuY3tHSBsdQ5R5IF0noyIKJxPKY5gZ4YfKv9uiB37/h0izLEHNZHWXfVGXdVRKPdKPpR9getUjV0uuH4wPAAXxPCakc7oOCIj8hVw3h/YDXJxeeU4DTma3nkq5WQvWNnJwcUDSYOVKRpSgAJQijh3ncc5VkEN5RBGlJgBZeewM46GYwlzLULjn5eR7qQ2/7b2GcNMhZNIIBUJ9IH+kFCxXJy+HFgyk2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qy8k3yueLps1NlttHYq9rrxFk4XF626J6LYDrWlMB4=;
 b=y8GF8YKanuVOc9am91e8zcI7lYEYX/YSuFCVNZXARqrY/jVLk8ZEcE9NScNNs2/fworlxENcLS3Jh+vmVwTC8TRzYkjL2NyIZ7YR/TWFi6L05mjUOACHShwD7XqK/te/WJV2gdTw0jhgcX9smBxvt2kVYhgVliol50e3c0qcUPQ=
Received: from BN8PR15CA0055.namprd15.prod.outlook.com (2603:10b6:408:80::32)
 by BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Wed, 7 Feb
 2024 13:54:57 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::83) by BN8PR15CA0055.outlook.office365.com
 (2603:10b6:408:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 13:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 13:54:57 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 07:54:51 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <lijo.lazar@amd.com>, "Yang
 Wang" <kevinyang.wang@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: implement smu send rma reason for smu
 v13.0.6
Date: Wed, 7 Feb 2024 21:54:17 +0800
Message-ID: <20240207135418.693925-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|BL3PR12MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: f684d428-03d5-4cb2-a709-08dc27e45e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWpF1X5VFC5lcrlBfOiSPalB5tM1vA7PLH3MXEoPb3Dtr8/mcpgqm3AeqJMzKLBeWPUAO/oDgyEWTlrBAU5jXN0etAkPg+/Y1yvPmEFh9fP51zv+3TDW7QvCC/ZzqpYUsHa9NiB/9Gn913AkhrBlTYHzkYRG/NA9OCsjgng/w+9VpYOODniGTeoEMr01H7bsL5PMFeuX3VINgn+cnBqvpk5GA6CwISgNMZ4NZXKNCGxyDeG44WDpqmX9fFaEP2IzZFf8vBBfxOqsJj45Lzn8dKDA/iP5+rYrTD/IG386Tug3p4eSNs6BYSG8MAtuMne14lxVzEBsW8lAoSRP2uNGLKU2hNnwzQ08wzQp9khu7ugoV/kTXJ4Z5QctdoiWyDvQqyMu7NPxa3HDnH4flcmTb/I7NIUUYr+It3fkhDmgd5VRUtQ+x2DjnYqglKTtdlZNSAbhqM/VZU5ix/lO+aqYfeuzkCEfN4SNBVgjyV+lv64+GeUbDyPhlhRWjNYXZQwP5Go4Ey4v+BWKOGcIIMnp6pO6OGYIQ4GULvPV2jW7SAN46SGXawRqrAuL42KUhmW1ztpBfe4IkNxJ2dNfi/sagTH7e4WhV9DLPgtb0KIVMFBbF6SsbVZ/bvzaShuTXPy2145XEQOK3qQN+W8b4tOIC7GKnEC0CfjVkgC+YOtn/KACJVnyOBKmAzizRVGKx4CU/3+oUeK43aubcwRosz7bZHWoG3Or90m2zWJ3p/w0vv1IvjH7Si6hvaD65hTlU6EoIWIuQzA4iHJcqyavrFNt7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(478600001)(41300700001)(82740400003)(40480700001)(40460700003)(36860700001)(83380400001)(356005)(81166007)(47076005)(7696005)(16526019)(336012)(6666004)(8676002)(2616005)(5660300002)(54906003)(36756003)(86362001)(316002)(8936002)(26005)(4326008)(426003)(2906002)(6916009)(70206006)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 13:54:57.0266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f684d428-03d5-4cb2-a709-08dc27e45e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050
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

implement smu send rma reason function for smu v13.0.6

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 15 ++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 ++++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 20 +++++++++++++++++++
 7 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6627ee07d52d..f84bfed50681 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -693,6 +693,21 @@ int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t si
 	return ret;
 }
 
+int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
+
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_send_rma_reason(smu);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 3047ffe7f244..621200e0823f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -450,6 +450,7 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool enable);
 int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size);
 int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t size);
+int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev);
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				       enum pp_clock_type type,
 				       uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0ad947df777a..138dcb8724b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3669,3 +3669,13 @@ int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size)
 
 	return ret;
 }
+
+int smu_send_rma_reason(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->send_rma_reason)
+		ret = smu->ppt_funcs->send_rma_reason(smu);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 66e84defd0b6..a870bdd49a4e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1341,6 +1341,11 @@ struct pptable_funcs {
 	 */
 	int (*send_hbm_bad_pages_num)(struct smu_context *smu, uint32_t size);
 
+	/**
+	 * @send_rma_reason: message rma reason event to SMU.
+	 */
+	int (*send_rma_reason)(struct smu_context *smu);
+
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
 	 */
@@ -1588,5 +1593,6 @@ int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
 void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
+int smu_send_rma_reason(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 509e3cd483fb..86758051cb93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -91,7 +91,8 @@
 #define PPSMC_MSG_QueryValidMcaCeCount              0x3A
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
-#define PPSMC_Message_Count                         0x41
+#define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
+#define PPSMC_Message_Count                         0x44
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 953a767613b1..efd97408b667 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -261,7 +261,8 @@
 	__SMU_DUMMY_MAP(SetSoftMaxVpe),	\
 	__SMU_DUMMY_MAP(SetSoftMinVpe), \
 	__SMU_DUMMY_MAP(GetMetricsVersion), \
-	__SMU_DUMMY_MAP(EnableUCLKShadow),
+	__SMU_DUMMY_MAP(EnableUCLKShadow), \
+	__SMU_DUMMY_MAP(BadPageThreshold),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 40ce3f780847..f2311138e8fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -172,6 +172,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpDW,                   0),
 	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 0),
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
+	MSG_MAP(BadPageThreshold,                    PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 };
 
 // clang-format on
@@ -2381,6 +2382,24 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
+
+	/* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and above */
+	if ((adev->flags & AMD_IS_APU) || smu->smc_fw_version < 0x00555a00)
+		return 0;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BadPageThreshold, NULL);
+	if (ret)
+		dev_err(smu->adev->dev,
+			"[%s] failed to send BadPageThreshold event to SMU\n",
+			__func__);
+
+	return ret;
+}
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3095,6 +3114,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_init = smu_v13_0_6_i2c_control_init,
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
+	.send_rma_reason = smu_v13_0_6_send_rma_reason,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

