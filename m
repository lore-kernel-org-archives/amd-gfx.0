Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97559D3B980
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 16:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E627010E522;
	Tue,  9 Dec 2025 16:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MpkowNCu";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F283110E522
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 16:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spZHjvtQD1PCQAnd5O2VDur1dhJZtZzXceWb3DeJTyMaAF8uaWU4Ok4TC+JuHz3495zlttO3fKg3XrVgSvNeLpNfrGXsvXmE60+71JKO+edBqiQ6tBvV3nsLfJco7xdyXROBdUm85BJ5RSNHDYh+9UjUbeHcauVgoDiUmw3WOv3KHXq+IuuKX8qqsu8eNphN1Mng8GyqH/wD4yIMc6wNasZgCgv1MrNu96k2tBypbZKjcV3bhog9CNvvRaCAL5OklDfPs/UCh8WLHjfol4LBFDLiXwh2nW7dTaD5Vu62cKV09Rb6HcSuyzT9K7Ec9cDBDOWhnCB1LsMJA8mOlOofvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVGB4GcyWhCaIzg6YoFCZMI1OjwlSG8ePaOx4lymOLQ=;
 b=diY4WBW6j7v9gSEnBbu4TSK4ibAqJ440TbS/zKQrgs+kD5emoU1HuOi72NPqUFEjZCUqG0MXKyJ073yigMCgcKv569amdQ2grq4PMpeyLuFyDyut+1wxru0D3MUDI0r4mRs8GnsVSXk7tX4bI4T7OQoR5v6fa/sjpnLpQKYfEV217UIRsxlb0ISVG+HYrL6OpABpc1I9+OS3TKeXwJi5rKrxW2ygxRc1JfFUrAobGzoljLbsv5buuJ1/IGj28OS9gZfEgE359nyq+2i6BGCqbDKEbUDw9rp7QlbCMTKe0Y7v5kzXBw6KiFqsVSJLBFa1HNliffL8fqCSIGagNifxyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVGB4GcyWhCaIzg6YoFCZMI1OjwlSG8ePaOx4lymOLQ=;
 b=MpkowNCuXd6WhIG78t2V5IXBitfc3vxWbwzd1DJFcS1gdJ5ySr+HhPQBAcNUNxZpdSXvW+tDDqmP3wLvfyE9klh/8qdg8Qmw0JRNa5RbT6euY0i1CKMVYssW3gMZ7ozdkoS+31/C5MGuis6t9ybABl4bd5MLUgQX3wGyF7xIwzQ=
Received: from PH7P220CA0150.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::13)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Tue, 9 Dec
 2025 16:23:02 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:327:cafe::64) by PH7P220CA0150.outlook.office365.com
 (2603:10b6:510:327::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Tue, 9
 Dec 2025 16:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Tue, 9 Dec 2025 16:23:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 10:23:00 -0600
Received: from drvdevbldsrv2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 08:22:59 -0800
From: mythilam <mythilam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: mythilam <mythilam@amd.com>
Subject: [PATCH v2] drm/amd/pm: restore SCLK settings after S0ix resume
Date: Tue, 9 Dec 2025 21:52:59 +0530
Message-ID: <20251209162259.1604207-1-mythilam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 447baf3d-84d5-418b-3dd2-08de373f3972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?quy1vDOQ5GPsty3MYcejo0k1GcqkWV6sRYfzxErtcn//bE2fjQvt1bPMbkYX?=
 =?us-ascii?Q?ho3bNHzbk4J7hm+UZrIRUbqnQ7GFLOcvMXiYnYUpWjzh+2d4qt6qyZ/HF581?=
 =?us-ascii?Q?EWd9xapnEtzb/P9nfSRFYl33kMRBO1QZq/0R2haClOkSZ/cLZTEzgl55ddBv?=
 =?us-ascii?Q?97sGekPT8FUnsdS3IKWlUsnxc1oVa4ve0R21L3MtSHB7v1/IOPbg973J9E0W?=
 =?us-ascii?Q?61Kb6bjFH7Lnv+4pIJdCTL0rnTk5NRY9TAQTbHfGqGq9PMHn0Q9xrT5TAgDA?=
 =?us-ascii?Q?Xfm11fh79c+Tmf/SLE7osZZcd8A1+t+yMjJlK9wKeAxlSb1HnrjJhjxGkt51?=
 =?us-ascii?Q?ZG0QObsYuvWZfmqVU0GgI0R/e60RIJmUZQcXQgsqFeiRpEhpjf3FYDyngN5E?=
 =?us-ascii?Q?LeY3p9Rx0ZDGBaFpLHDm2V5P0F4QWSD5RTUsKPaEsjcfumyFBbIY7JeENIeA?=
 =?us-ascii?Q?EfQBf/nBUXNIbG5PwI3CC1H+UTp8I5w1VhFOLooJKmAeqR1FnrL0an0mxaL7?=
 =?us-ascii?Q?UScL4SCgo+/7hAmhQ29J4R1UQTOafqhiz9MFRRLy3ckQ3LZ6Nqwds/dxeH1Q?=
 =?us-ascii?Q?gxbnMqpEGjWPIZY0R8Bxzjgwx/+Bhv1suybP1x0cldZyEgcPayNdN/EuPMHn?=
 =?us-ascii?Q?I8vmh7qjP1WJKAZpsS3aZMIZ/ttsbalCo4UjkFAIAafhdziIW3S/9LwP16v3?=
 =?us-ascii?Q?qi4B1I99ZZ4pC8w1lOiTHm3zGhUVi/TdMV5yZlbbJVFXjpFEC2Ec5mpBfcoK?=
 =?us-ascii?Q?TlH2t00i1hKi98kmlMPcKIMdA+KVl9zLew9S5Ci+DaEdyyRbBuv52Kvocgeb?=
 =?us-ascii?Q?I4DFfCc1bvvcGY/drHDrfRDMUjIoQQr4AD4ZwFFrFDCYXqLbLB8BEAvFffCB?=
 =?us-ascii?Q?tEunljnP4Sa/Lf0K30H0TJtYBov1yY/kn6ubBxSoElW5d0JtjJx+jkqqsY1a?=
 =?us-ascii?Q?k2dj/Hz3Jkz9h+hVxD13iyHfA3JMN0A+OPrm55aNOIooxT2oEJg8ZDM6SYwo?=
 =?us-ascii?Q?NukvkBxtrlOwTcFNdQPMvEJobQ+d5YMg2wKBqnD8sWgEAnR9/LHK1vAXLzRc?=
 =?us-ascii?Q?5Xw0QTrJpzLq03XpNAAyc32BBBcWhIbdLpvdnw/0LDsNAlAWMvwbr9oEGOaY?=
 =?us-ascii?Q?5vIpGy9BkVLVf2NXvYQYLNvtGs4gqKUEL2XKnZ/jjzFxj2ShxUh0TQnW4mmk?=
 =?us-ascii?Q?iK+XGUSqqJxXweuJjwmWn4yJDUNDSGuYW03l68DL1ugiEXWTyDjxR0FiN2kb?=
 =?us-ascii?Q?0k3t29W0SLdsKvT14Z0El9yQzvNivAaRYZtPCTVe2I5xfoiF3YYNQSUe6Ieo?=
 =?us-ascii?Q?C7AdbQm7mb80E793+c5MKfrI8oDyHVuIVkNU1KkQh1WKD13UoMBLdExieC1a?=
 =?us-ascii?Q?pr9SV2yxsaXntxVAHxLl7s9NGjnY4SSt921en4bdFIZj7HZbgIb0AJ37J0Ne?=
 =?us-ascii?Q?4+sh0wT9IOm3o1d/bEXwJmLZ5R8kweYCJrS9XUUF8nWIcdy1xoQrdkrEOY8g?=
 =?us-ascii?Q?bfgjxHU44njPIkn1FIvwpbJKByNBmkMIXp3arxVBXMUP0ebb5s01/TMheejE?=
 =?us-ascii?Q?I7FNx8BLUUiRzJFvrbk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 16:23:01.8777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447baf3d-84d5-418b-3dd2-08de373f3972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
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

User-configured SCLK (GPU core clock) frequencies were not persisting
across S0ix suspend/resume cycles on smu v14 hardware.
The issue occurred because of the code resetting clock frequency
to zero during resume.

This patch addresses the problem by:
- Preserving user-configured values in driver and sets the
  clock frequency across resume
- Preserved settings are sent to the hardware during resume

Signed-off-by: mythilam <mythilam@amd.com>

---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  5 +++
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 37 ++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index f9b0938c57ea..f2a16dfee599 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1939,6 +1939,11 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
 			dev_err(smu->adev->dev, "Set soft max sclk failed!");
 			return ret;
 		}
+		if (smu->gfx_actual_hard_min_freq != smu->gfx_default_hard_min_freq ||
+		    smu->gfx_actual_soft_max_freq != smu->gfx_default_soft_max_freq)
+			smu->user_dpm_profile.user_od = true;
+		else
+			smu->user_dpm_profile.user_od = false;
 		break;
 	default:
 		return -ENOSYS;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index b1bd946d8e30..97414bc39764 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1514,9 +1514,10 @@ static int smu_v14_0_1_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 
 	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
 	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
-	smu->gfx_actual_hard_min_freq = 0;
-	smu->gfx_actual_soft_max_freq = 0;
-
+	if (smu->gfx_actual_hard_min_freq == 0)
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+	if (smu->gfx_actual_soft_max_freq == 0)
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 	return 0;
 }
 
@@ -1526,8 +1527,10 @@ static int smu_v14_0_0_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 
 	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
 	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
-	smu->gfx_actual_hard_min_freq = 0;
-	smu->gfx_actual_soft_max_freq = 0;
+	if (smu->gfx_actual_hard_min_freq == 0)
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+	if (smu->gfx_actual_soft_max_freq == 0)
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
 	return 0;
 }
@@ -1665,6 +1668,29 @@ static int smu_v14_0_common_set_mall_enable(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v14_0_0_restore_user_od_settings(struct smu_context *smu)
+{
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+					      smu->gfx_actual_hard_min_freq,
+					      NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to restore hard min sclk!\n");
+		return ret;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+					      smu->gfx_actual_soft_max_freq,
+					      NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to restore soft max sclk!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.check_fw_version = smu_v14_0_check_fw_version,
@@ -1688,6 +1714,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.mode2_reset = smu_v14_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v14_0_common_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v14_0_0_set_soft_freq_limited_range,
+	.restore_user_od_settings = smu_v14_0_0_restore_user_od_settings,
 	.od_edit_dpm_table = smu_v14_0_od_edit_dpm_table,
 	.print_clk_levels = smu_v14_0_0_print_clk_levels,
 	.force_clk_levels = smu_v14_0_0_force_clk_levels,
-- 
2.17.1

