Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E13D65C52
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C320310ECD7;
	Wed, 17 Dec 2025 13:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="brdkXATh";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D47EA10ECD0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHnQV8vm1lJwkdmn2qSM9ZZ+HiIN4yrIZtbOHSKHHdLp1HrNVr5k8xhieuIpXpephm5MISm4+Z7j0/SSx6UjZEBGvPkhgTyFYAYUmpRCkMVfbqWaEGREwTn4CvgRUtn3hLva29RU/lKHayKBcUCTWLE1WFPP/OD2/ECUwza+UdBCcXTlapGyYzUZ5s1o3OPPctpKwI+Vs1dhIWBFB7ZMtpPkAy5P3TeiX8ueyS9a/Jvwd6dejLRL2wyLxeAqg95PR8SUB4lFPUJvTfPBiB3t1x9GahKEKi6IGH9Sv6/O8mPRnniSjK9Tm/22I15ao68jkAdrHxyX2MNTEW+HwTsmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LChAEQnQvP97JYfmoI3EFnYHLoqA59neccdaTJftWU=;
 b=Ds7LSns1pxiOpOGv5uipz4JTm8uja549rw3xVw0lTHZaxK6pZzN7OcnY5QL1vjf5EavblpN4zhqffOFI0m3YbjQA/ozyqw923XE7t7jqzaNvRZ8wHHQ4e1VeJZTs0NDGJT84FRNmGCiLmJVCaONO44Fe+S2aRwm1vjkCFzpo6W/uhg5tixI1Kek/ZHLizVm2Hguhih8WNI5GETZoB1UQPRsAVJvJ/jKOXBbB3FbiTiiiq3Ld6LxtzBNUAQZHHElq6ytsHMjIuhQA5LimugoUSW55HamOefRK1dNjDRb8PRQNSMxzlEWqoULI7c5Gu5GPChvrT8mixIjiguZ8R99e/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LChAEQnQvP97JYfmoI3EFnYHLoqA59neccdaTJftWU=;
 b=brdkXATh7HKNMK48Fc7nPqn6QfyTF3vyf5mrbMCJDXzTbnrbozshF7e243KTwZ1CUENcCR5lJxusw84TBtkcDwQFM/pj4Hz4zaYDX+Ig4DUz5QjqL+eHTypnSHdqV36joaug3GBsHNJv0cdxuIEzscgMeerv+tj80vv7ZuwNILo=
Received: from CH2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:59::23)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:08 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::30) by CH2PR03CA0013.outlook.office365.com
 (2603:10b6:610:59::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 13:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:05 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 08/21] drm/amd/pm: Replace without wait with async calls
Date: Wed, 17 Dec 2025 19:18:01 +0530
Message-ID: <20251217135431.2943441-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 143817c5-22c4-42a3-a3bf-08de3d73e399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2LRk/lnU8fu0RIjgEFTKE1s70Y+4+xDl/h4xQIaXf8CmPYAzNLtjfZn+a2Wi?=
 =?us-ascii?Q?54JJMIPD+RhSyrehdgm6+0myCKwYegAsQdUxjZf9ac89iJi0lO45vBM7soHQ?=
 =?us-ascii?Q?QCuc5+gK5mVXbtU0pGeZyeDzpEIidrxZKYWcYxhgzcCxJFp+S+tgTOWO3Ak0?=
 =?us-ascii?Q?H7doqefGvqLsEdeXAHtKpH3/7k5NN1yaxDlIaCfXnFdWvvy9WW2J1QsvxHfk?=
 =?us-ascii?Q?yt2HRj9bE46Xl0GHLqlNmL281bbzazfQ4XRNmp62PTyoind81s2V6mHOdmqH?=
 =?us-ascii?Q?AMAMzXIfU6eyVa3mXqoG0wTGP7VC9L2JJ/OvpSIDfrzfxGqv90qFYQL7u/U1?=
 =?us-ascii?Q?nLLhbqVaPRnEhifNwA4pErawDyY0PMqmLpwqvV7X5hjN2IOGrFavMvvfM5bh?=
 =?us-ascii?Q?M0gBRsQvy8lKJJENh6vm3HOc3y0r1bLrhGRZQ3BCo5tFDMOqlqav8LeAWm3f?=
 =?us-ascii?Q?AnZYzuatowIrMsXwISCs9HbexV2iTWuPKPMPr7b6sp1HdEr6jOZwwABP60ft?=
 =?us-ascii?Q?7SvJaUEtl9x8mfT14Gu7b3mdyTcLlvrQgw231hwUaCeO4NP2BLVa5XoWNhGI?=
 =?us-ascii?Q?wvC3YGBB0lD8dF6yN0gN9KgQFvmZZGatfq1rnQSWaliPuEXmO9ykhDQcSmmS?=
 =?us-ascii?Q?Vi3XkGnez6rW3tnvNFQiBdX9u3kpK30BErVsWH3k/J3uvMaS3CEBYl85Nlzb?=
 =?us-ascii?Q?6TdX8Cz9PxJk+Hf+jfHmQ5mnPrHKigUU5n+ovD0Dpu/HSgbiS7xXTI8t3hip?=
 =?us-ascii?Q?pSVKpU59qAbRt0EC1VV+s1WQZyv1iA0TKyP/GT5rB3ilmpP1w51baGJ9TkbD?=
 =?us-ascii?Q?AhLQDAFAsUnoPzQuZQycxRnyXhcd+aka9pwRl5UVpYUH+iu8ziMswO1NwZGl?=
 =?us-ascii?Q?vECzJHVio7uwPa+6HGkpvc9WK/BKFajfyX0RjUm6yJhRq/vNg95nc+4J3BHs?=
 =?us-ascii?Q?nHeFg+WQLc8Q9n4C27+dHT+CHZXmQMIJHwiitb5X/8A9zGZ9eQrn27dy+h2D?=
 =?us-ascii?Q?Lh9AjYLwOUueAx1y5mc3rj6zC7iglO3APd5YlW7qfLiaz+qyaqj037t+lsBQ?=
 =?us-ascii?Q?mTb4Lt0O6lYt3G0GvrR5dxdSWMckFbScd1FFtZNRB8WL1sezE2NNZ0Waq3lB?=
 =?us-ascii?Q?hNRyNTfPVZqXn0L9ufG/XTAE9MPIIVT2PlG/7zegoNw82SxH+A454x+nZlNf?=
 =?us-ascii?Q?43MMe20NwqhNYq4A4t1ys9r0gHgYxL+kOy5LpyBiCvW32dz7KXSxIXHXL0IF?=
 =?us-ascii?Q?HYKzlSrUgD7UQWNGhsS6xLNrXErSS2amZ5bavqMiR9I5L5AGwt188xf1V/Mv?=
 =?us-ascii?Q?cp1M/d3pUR2nn7ofuzXjWvamf7uLFgWfhpCCVZ6OM8f5u60wLu/jW68eGTTZ?=
 =?us-ascii?Q?BrMjfZDjaQVq6wzFQ7yynC8bQsI/CyAevunC0h4q/IwaI7n/gxEvsz6vxm+b?=
 =?us-ascii?Q?G+fTm/2CBx5Pl+UEmxk6HfpipD38+Kh0Ibb5sbzDmxyxbs4IFR7Geg8gLhnK?=
 =?us-ascii?Q?SSYsN2IxCjo0NpHxFs/sZ5lkLCszZZouAYqD6aN+LOYJT6eEFqI2gxBysk73?=
 =?us-ascii?Q?vbihHcG7naTw3LAXEQI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:08.1983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143817c5-22c4-42a3-a3bf-08de3d73e399
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
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

Use the new async locked message function instead of without_waiting
messaging function.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 ++++++++---------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 16 ++++---------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 24 ++++++++++---------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 ++++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 24 +++++++++----------
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 12 ++++++----
 6 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9ea6b0d1954b..087b4b6ce857 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3043,21 +3043,21 @@ static int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
 
 static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 	int timeout = 100;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-						SMU_MSG_DriverMode2Reset);
-
-	mutex_lock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
 
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
-					       SMU_RESET_MODE_2);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_DriverMode2Reset,
+					SMU_RESET_MODE_2);
+	if (ret)
+		goto out;
 
-	ret = smu_cmn_wait_for_response(smu);
+	ret = smu_msg_wait_response(ctl, 0);
 	while (ret != 0 && timeout) {
-		ret = smu_cmn_wait_for_response(smu);
+		ret = smu_msg_wait_response(ctl, 0);
 		/* Wait a bit more time for getting ACK */
 		if (ret != 0) {
 			--timeout;
@@ -3075,11 +3075,11 @@ static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 		goto out;
 	}
 
-	dev_info(smu->adev->dev, "restore config space...\n");
+	dev_info(adev->dev, "restore config space...\n");
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 out:
-	mutex_unlock(&smu->message_lock);
+	mutex_unlock(&ctl->lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index a645094b029b..fe1924289040 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2272,18 +2272,12 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 
 static int vangogh_mode_reset(struct smu_context *smu, int type)
 {
-	int ret = 0, index = 0;
-
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index == -EACCES ? 0 : index;
-
-	mutex_lock(&smu->message_lock);
-
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, type);
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	int ret;
 
-	mutex_unlock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset, type);
+	mutex_unlock(&ctl->lock);
 
 	mdelay(10);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a3f4b25ac474..76edb54972dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1828,26 +1828,28 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-						SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0 )
-		return -EINVAL;
-	mutex_lock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
+
 	if (smu->smc_fw_version >= 0x00441400) {
-		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
+		ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset,
+						SMU_RESET_MODE_2);
+		if (ret)
+			goto out;
+
 		/* This is similar to FLR, wait till max FLR timeout */
 		msleep(100);
-		dev_dbg(smu->adev->dev, "restore config space...\n");
+		dev_dbg(adev->dev, "restore config space...\n");
 		/* Restore the config space saved during init */
 		amdgpu_device_load_pci_state(adev->pdev);
 
-		dev_dbg(smu->adev->dev, "wait for reset ack\n");
+		dev_dbg(adev->dev, "wait for reset ack\n");
 		while (ret == -ETIME && timeout)  {
-			ret = smu_cmn_wait_for_response(smu);
+			ret = smu_msg_wait_response(ctl, 0);
 			/* Wait a bit more time for getting ACK */
 			if (ret == -ETIME) {
 				--timeout;
@@ -1870,7 +1872,7 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 	if (ret == 1)
 		ret = 0;
 out:
-	mutex_unlock(&smu->message_lock);
+	mutex_unlock(&ctl->lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e5996162fd5c..b941ab24f823 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2244,18 +2244,21 @@ int smu_v13_0_baco_exit(struct smu_context *smu)
 
 int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	uint16_t index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
 						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_EnableGfxImu);
-	return smu_cmn_send_msg_without_waiting(smu, index,
-						ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_unlock(&ctl->lock);
+
+	return ret;
 }
 
 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a9789f3a23b0..cf011fc3bb61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2897,24 +2897,22 @@ static void smu_v13_0_6_restore_pci_config(struct smu_context *smu)
 
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index;
-
-	mutex_lock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
 
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
-					       SMU_RESET_MODE_2);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset,
+					SMU_RESET_MODE_2);
+	if (ret)
+		goto out;
 
 	/* Reset takes a bit longer, wait for 200ms. */
 	msleep(200);
 
-	dev_dbg(smu->adev->dev, "restore config space...\n");
+	dev_dbg(adev->dev, "restore config space...\n");
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 
@@ -2932,9 +2930,9 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	if (!(adev->flags & AMD_IS_APU))
 		smu_v13_0_6_restore_pci_config(smu);
 
-	dev_dbg(smu->adev->dev, "wait for reset ack\n");
+	dev_dbg(adev->dev, "wait for reset ack\n");
 	do {
-		ret = smu_cmn_wait_for_response(smu);
+		ret = smu_msg_wait_response(ctl, 0);
 		/* Wait a bit more time for getting ACK */
 		if (ret == -ETIME) {
 			--timeout;
@@ -2948,7 +2946,7 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	} while (ret == -ETIME && timeout);
 
 out:
-	mutex_unlock(&smu->message_lock);
+	mutex_unlock(&ctl->lock);
 
 	if (ret)
 		dev_err(adev->dev, "failed to send mode2 reset, error code %d",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 8f7f293de3d8..f85ba23f9d99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1834,17 +1834,21 @@ int smu_v14_0_baco_exit(struct smu_context *smu)
 
 int smu_v14_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	uint16_t index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
 						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_EnableGfxImu);
-	return smu_cmn_send_msg_without_waiting(smu, index, ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_unlock(&ctl->lock);
+
+	return ret;
 }
 
 int smu_v14_0_set_default_dpm_tables(struct smu_context *smu)
-- 
2.49.0

