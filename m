Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63274CD37B9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 11:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17DB10E19E;
	Mon, 11 May 2026 11:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wxQoW51s";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BED10E19E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 11:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX3PX0J/8/JD5fowip2cIZL9DdSSD/tUDCcWh777Zh4UDnJCRNsW0YRaY7jOixModoKvlVN8kC3tLgvS8fxubO0ofwVz74Ptd4CwYRaZReuJy/diSt/MECkkfFW3OuPkldAJ/Z0f66ao42AL0sPEQW2HyGo4nnS1XItBKLbpOIrf5x6aUIr8mF9jS480e9/wsVIteLDdqNSWg+1LEFdX3U6VfGgFDtb90835mUvUupddz/fQ1xDo6q9mlg2hVRmXubzEahm5C/7TjsMyBStHJZURUyH2mHv3BGsAvE1L/lwp5Cx8keeFS/7XkrzZbhnqrrwz+HTCbthQFRPGUlI0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9zXLLV5H46vXsjjFOuC4uMp7VSYygbQATBl9AgnyyI=;
 b=M0THRq19bTx4kbAIkkW93MwMfFhag99R3SL/eO51wdAFuGAxgujIqfAKC3Q0ArbjwhTs1xYn84Q7T39a5VVmjqRQI1ltYsQwEwruL9dfh1b1GukFWZnBzdb2iy9W+8nSX8rq42w/t3v4tVDLKtv4ceMobpo7vzK6eQffZJ93zsuRBMDx0GUkcjixJ+18u7qgz4on7qW2CvEhSCJbsVK1FYxRYdzGrS/Jew7u+gFKNxtYRTfdI5r8ISQfnCWoOgOs6NCn/gKDtDtvjvEPbQDoJmX+gpcMAe0sX3XQxK6i6weWEtvVD6tyJ7p/R84QjfMawmf4rb5oyvzp02m7hoZGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9zXLLV5H46vXsjjFOuC4uMp7VSYygbQATBl9AgnyyI=;
 b=wxQoW51sAHcOIBDBixrpqOIlqCRVpa9VWRcwF5dwXl9Mz8WgUTPyUAogREvR/mceXVOIg/BkOrT9su+pL3jS/19pF8H0uAeTPQS/cDG/OD79IbfSgdPZcWjHcc/YI5JllnWwbxg4yo6o3njD3S8Z+mpIey4+ffVOVLgEjpIZB6E=
Received: from MW4PR03CA0037.namprd03.prod.outlook.com (2603:10b6:303:8e::12)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 11:12:40 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::60) by MW4PR03CA0037.outlook.office365.com
 (2603:10b6:303:8e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 11:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 11:12:40 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 06:12:37 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <HaiJun.Chang@amd.com>, chong li
 <chongli2@amd.com>
Subject: [PATCH v3] drm/amdgpu: Add guest driver CUID support
Date: Mon, 11 May 2026 19:07:26 +0800
Message-ID: <20260511111224.634472-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: f141b8a1-8105-4f45-ba0a-08deaf4e374e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: AkbJMxzCS/aI0Wdx4hEalgdu7I5cbZhtQpEn07hQGIDXXHFLFIzyj3hifbbLSz7mKXH+3dY3iZ85GwQOZ3+eP5RWWKNIh8SYQA+O9P41Lk8N5/sOGOh1IIsTi9Ga3NciXlkB2RRKm5gxMIcIPPaDpecOSoG6GoGMjbagd2F7cn0a2tc7CdTd6y2gTwJPfMNXgRaY4Yfv97/kIsKVZIg0Df1Fcsn0Cf1XAUybNZTgXE0C6BF1UZ9+isYk5iILZOdYosdysnpQBkElwmXNvBvGqaUXYPz93WQxhhw61hVR21zcSKtRGL6IApdSFxedrzU0XmJGrmsFAcoiicsqMjir0VvwqEfcLMCSD9XHU/mR/5vBbkQxMzyZbyV7GtMEtl57lPfKSAUyS6fPdP+qkle3HFHPgJQxeGG80klAyO1wG35G4njFs+F5QtTG/oVeHjeh4qgM76q4iUBD8ai37VD1cMZTlIHipzGImw5VDNMQpe8V99HUS+JdiOsUuqXrhS+G7YVULcGvh1xxDE9eMSet5lwxAimbCB/LRTEi351N2ttjf5+6LlLBT0cQ4rVZiDRHE04yCKiOM8Y4jNyVcaCrs1G3g77+le0OqVfy/HRHjWAqmYc6/7QWUic4fcyIIw1IVT3I8c/POXTRP8nibQMrS8q5g1QUZmEiI8nXTTY+eyALpYN8otCH3ySGDTdJ1cVLNFSSqfpGCZ0HdT9mIqJ9oDY2PT3DEo2YPvPEBzVcBUU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: viICJoD3gPJi9B7H+KM6cGYEn8jvya8qlcA9olKTbMRb2OSKW4XyEflVHzFUotQKflB/7SfEtz40ur8db6TZ6R1y1gJV5/yCEzVECE1flsK4g+SRy/EtotkPu/zf/BMF7Nlg/QYUr3Q9oE5V8Qsm9WM58NWAAU2YL+6ojaO5mziAzAohR3684VVeoTyyeWJUF7gd1Cah3pCiyn4ZwhyDah+Q0szRstiJ8tRN7qtuZXIHSzy6J8wdZxLOEp+eGiQYJyAqNMeM4hHG0lp0cI10WTfjMEiCnRq8W+QnXr6SkrpVJHhRfBwey2dUZH2z0pMmmLkymh9rqTVs+bk3tHYIbrlKLzs798AQn3sgKMt2k/YrmzYUPTI4DKQvTw55yLGMuiRio/yl9j4obFid0oX13hVVxJ4t5ih4/NdjxdNoXVzFX9ilS5/La1Fu3ZRxXJv4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 11:12:40.2592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f141b8a1-8105-4f45-ba0a-08deaf4e374e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627
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

v3:
improve the coding style.

v2:
use debugfs_create_x64 and debugfs_create_x8 to create node.

v1:
1. Add guest driver CUID support
2. Do not expose vf index(variable "fcn_idx") to customers,
   replace the fcn_idx with pad.
   Only expose the unitid to customers.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 40 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  2 +-
 4 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 80b18bbd7f3a..98549a148695 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1074,6 +1074,7 @@ struct amdgpu_device {
 	long				psp_timeout;
 
 	uint64_t			unique_id;
+	uint8_t				unitid;
 	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
 
 	/* enable runtime pm on the device */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 979032ecaf79..7e88dbd2a7e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2126,6 +2126,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
 			   &adev->pm.smu_debug_mask);
 
+	debugfs_create_x64("unique_id", 0444, root, &adev->unique_id);
+	debugfs_create_x8("unitid", 0444, root, &adev->unitid);
+
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6974b1c5b56c..2666551f0119 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -463,6 +463,9 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
+	struct amdgim_pf2vf_info_v1 *pf2vf_v1;
+	struct amd_sriov_msg_pf2vf_info *pf2vf;
+
 	uint32_t checksum;
 	uint32_t checkval;
 
@@ -479,7 +482,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 
 	switch (pf2vf_info->version) {
 	case 1:
-		checksum = ((struct amdgim_pf2vf_info_v1 *)pf2vf_info)->checksum;
+		pf2vf_v1 = (struct amdgim_pf2vf_info_v1 *)pf2vf_info;
+		checksum = pf2vf_v1->checksum;
 		checkval = amd_sriov_msg_checksum(
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			adev->virt.fw_reserve.checksum_key, checksum);
@@ -490,12 +494,12 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			return -EINVAL;
 		}
 
-		adev->virt.gim_feature =
-			((struct amdgim_pf2vf_info_v1 *)pf2vf_info)->feature_flags;
+		adev->virt.gim_feature = pf2vf_v1->feature_flags;
 		break;
 	case 2:
 		/* TODO: missing key, need to add it later */
-		checksum = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->checksum;
+		pf2vf = (struct amd_sriov_msg_pf2vf_info *)pf2vf_info;
+		checksum = pf2vf->checksum;
 		checkval = amd_sriov_msg_checksum(
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			0, checksum);
@@ -507,11 +511,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		}
 
 		adev->virt.vf2pf_update_interval_ms =
-			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->vf2pf_update_interval_ms;
-		adev->virt.gim_feature =
-			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
-		adev->virt.reg_access =
-			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
+			pf2vf->vf2pf_update_interval_ms;
+		adev->virt.gim_feature = pf2vf->feature_flags.all;
+		adev->virt.reg_access = pf2vf->reg_access_flags.all;
 
 		adev->virt.decode_max_dimension_pixels = 0;
 		adev->virt.decode_max_frame_pixels = 0;
@@ -519,26 +521,30 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		adev->virt.encode_max_frame_pixels = 0;
 		adev->virt.is_mm_bw_enabled = false;
 		for (i = 0; i < AMD_SRIOV_MSG_RESERVE_VCN_INST; i++) {
-			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].decode_max_dimension_pixels;
+			tmp = pf2vf->mm_bw_management[i].decode_max_dimension_pixels;
 			adev->virt.decode_max_dimension_pixels = max(tmp, adev->virt.decode_max_dimension_pixels);
 
-			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].decode_max_frame_pixels;
+			tmp = pf2vf->mm_bw_management[i].decode_max_frame_pixels;
 			adev->virt.decode_max_frame_pixels = max(tmp, adev->virt.decode_max_frame_pixels);
 
-			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].encode_max_dimension_pixels;
+			tmp = pf2vf->mm_bw_management[i].encode_max_dimension_pixels;
 			adev->virt.encode_max_dimension_pixels = max(tmp, adev->virt.encode_max_dimension_pixels);
 
-			tmp = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->mm_bw_management[i].encode_max_frame_pixels;
+			tmp = pf2vf->mm_bw_management[i].encode_max_frame_pixels;
 			adev->virt.encode_max_frame_pixels = max(tmp, adev->virt.encode_max_frame_pixels);
 		}
 		if ((adev->virt.decode_max_dimension_pixels > 0) || (adev->virt.encode_max_dimension_pixels > 0))
 			adev->virt.is_mm_bw_enabled = true;
 
-		adev->unique_id =
-			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
-		adev->virt.ras_en_caps.all = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_en_caps.all;
+		adev->unique_id = pf2vf->uuid;
+
+		adev->unitid = 0;
+		if (amdgpu_sriov_is_unitid_support(adev))
+			adev->unitid = pf2vf->unitid;
+
+		adev->virt.ras_en_caps.all = pf2vf->ras_en_caps.all;
 		adev->virt.ras_telemetry_en_caps.all =
-			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_telemetry_en_caps.all;
+			pf2vf->ras_telemetry_en_caps.all;
 		break;
 	default:
 		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 9dcf0b07d513..d80f01c0e754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -295,7 +295,7 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t vf2pf_update_interval_ms;
 	/* identification in ROCm SMI */
 	uint64_t uuid;
-	uint32_t fcn_idx;
+	uint32_t pad;
 	/* flags to indicate which register access method VF should use */
 	union amd_sriov_reg_access_flags reg_access_flags;
 	/* MM BW management */
-- 
2.48.1


Hi, Christian.

Let me explain the background for you.

The variable fcn_idx currently contains the VF index. 
However, we do not want to expose the real VF index to customers. 
Therefore, I submitted another patch to the host GIM driver to set fcn_idx (now pad) to 0.

If customers need the VF index, they can use unitid instead. 
unitid is a mapping of the VF index, it is set by the host GIM driver, 
and the guest driver get it from the pf2vf message. 
Customers can then read unitid from the debugfs node and map unitid back to the VF index on their side.

For this reason, this patch changes fcn_idx to pad.

Thanks,
Chong.
