Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E873606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eeR/rDlL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E6411257C;
	Thu, 22 Oct 2026 12:32:27 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DDB11257C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 12:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxxsCEqxJ6EsIgNy3CbLKnumofKoBi+aCvVtNf1fuV21BwGGG9Bk3r4hBCP/n4RYoaj9OpqI1cMndoHua52fJ0/cQD7IN4/FC/HHAZhx3MKMppGpnjsCTJKS6/AWJ5DVkApvfhYtXwsXwL6yNWVQrH33kkdRYSoXvltha44ekjQy0iIHcsKJmi+XT/2X/2d1eZxg17QlW7z3VfzAUfX1WVZujLEHa2L6NtuaRi6k4A8d0WQBLGTi/zcvx4R6XmWu77o/jA8vmkCs8W0WgdJ+R4aLyeAG32Xewa2G3Him156bvhJisqR+nOQULlPWV+ZQIZMOt35DjgtzJF3jA7t7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edpuv8pyh1TgL5sbe64m+FudceLPZ6AT4jQoh7YczAQ=;
 b=EzKt/X/QOXya4tv+x9b7r0OYyUDx3ypSpZOFI2/L3poSf1RrtFLlzcp1otqmS6kQA476gWDXYKoMI2iQ6eZgDj8GbI1Wn5lYgeVLAwKzs/I8HCe4OPmOgurxTG3vqpA2xtWSVHf3cQCRyWw9G7S1kWfwbgEBSoiQ+Bhz/8qNRP+9zurPbLV0WWlvT3gDc3r4JMBbvCRU+3yluP1flxNF377N+xVej3acSdu0xIRiWLl/12iMpWyphXJe85kcDsP6ZeghGXs53b7xtPJvCyofjC7O3mq+uk93zrZnwXKf3bz8giZFxiYRivmXVanDZX9Mr3pSgPNgFquPE9FHz/4VjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edpuv8pyh1TgL5sbe64m+FudceLPZ6AT4jQoh7YczAQ=;
 b=eeR/rDlLefjLhU2LwBQlhw4uhPtKcsBL3vI7u8J4j1clzUmLQSIH4ADURPPcIllRgK4aHFSuHdAXV34gHDklXwivE37QU0ye7mA1oxkwd1cJsIzbP5gKQsaNV5Y6ofAhjLTq8lQmqrLbIC6e4Z1z1zMvSqLWv/fKCvawvIjoKuY=
Received: from BN9PR03CA0350.namprd03.prod.outlook.com (2603:10b6:408:f6::25)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 12:32:17 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::36) by BN9PR03CA0350.outlook.office365.com
 (2603:10b6:408:f6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 22
 Oct 2026 12:32:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 12:32:16 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 07:32:14 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Report SMU 15.0.8 XGMI bandwidth
Date: Thu, 22 Oct 2026 20:32:00 +0800
Message-ID: <20261022123200.2222192-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f69cc0a-90fc-4864-fb9f-08df303881eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|18002099003|11063799006|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: f/x3U1JGBxeI/B7YdjIDgNPQzt1BWZiTo64cx4hbx3V6Jvv3jwWTZN2UcTvkLptlgxYkDf9Mx8MDkUAVTGPArRm7TryyzmhgaNs5wUfA46AduawkwO2qJ8+fnvCgb9bJVPOcDyXa2sdeDpR7xCg+g9nq7gLJfs20T1flu69pjm/AmbMo7mLGU/qn+9zmmOC//n1ZnAhC7oUUBOscKl3tbMWvSZxe2laAm4lmzt2F/gKCyuqh64EGbuH5qXc40hlQaliG7Sjt3e2sopnXD5TeDQfK5gWkpJZK9WmblGdmLOV3C3VvY+eESUEVMnGURhM6YiMLvYsj6jmd9QdAcOW132rzQC1I/+4EYntNS38auRI+JOKLwozOLtsXsCJpj6xGVMZb/eSawMY5iDaCAHvj+F+LHd6GzjOiwlvBI3GCPFT1fqztqHSpLW5/mIeuu8HAjFxKgG3Fd9fl0WnDFrx7R8WdOuaw0IzM+W0dAW+8UtpHzHB2lj/rdLXsu/PLae19zC3W9wz2GVrK6NkKzgTZ9RyqGASCV5FD2ltXbvsAWcuY7SYhh0vqE/DXJ8K6qgFJMaybRnGwYwYC1p7k65WEsRetyeD/HUtmagefRSVBwBvVH60Z9PeHOTxuRpJdh6p5wxipPc7kaxohpNkwFfzNU3I/7NFolkNnDLpSrB1/lDrFlRL9pKLZ/o/sdu9m7y1ktDyBcommIUZpZlxnwnlxaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(18002099003)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7OF2T561/yKZKtuwOs6i2qEO1PjtciTWQS+HlGB6ZrXnu1cFSNyqKo77TBlZ/jp4qKTzwDQayJXJbPc3DjiFiJNWEsRsfnV1hyT5hQuUo9GDYfb2i8cLcKfWYHTXVZsTzhmWGk4MBRCk0O0enfC/iMs7iAtIelvfzyqUzQBKnQuYfz730R1BSSc056/TQYPI+3BYFyBzz093NCKoYm9mBaxwXsqURjiJPcya7pYXyrajUeUAINdZ5E61AKmxsS0lMoDhl7Uyb/0cG5xrfTfB5q4f+lFITf7f1wjv1MhIHqkIAHyw11kt3LmK16sBnSz5JMsWX7UCbbRTqH+dPbsNfHQRrCEqihtReUaOY/zxLVjgIXI2cbkIQiLf4lKZtPXvRu1AvmyFsy7B3XxGYUHtKf/Jt01wXCyLoo1bh6/dL9o3Jn5sGnjZlk5/yPOJQxi+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:32:16.5490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f69cc0a-90fc-4864-fb9f-08df303881eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SMU 15.0.8 firmware reports accumulated XGMI read and write bandwidth.
The driver publishes those counters as transferred data, in KB.

Publish them as xgmi_read_bandwidth_acc and xgmi_write_bandwidth_acc,
with unit GB/s.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h       | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h | 8 ++++----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index f92bccb8cb41..17f76071b514 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -685,6 +685,8 @@ enum amdgpu_metrics_attr_id {
 	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR,
 	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_IBC_HSC,
 	AMDGPU_METRICS_ATTR_ID_SYSTEM_TEMP_IBC,
+	AMDGPU_METRICS_ATTR_ID_XGMI_READ_BANDWIDTH_ACC,
+	AMDGPU_METRICS_ATTR_ID_XGMI_WRITE_BANDWIDTH_ACC,
 	AMDGPU_METRICS_ATTR_ID_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 2254c2d414d2..bacdc1a2dd38 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -2041,8 +2041,10 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
 			gpu_metrics->xgmi_link_status[j] = ret;
 	}
 
-	gpu_metrics->xgmi_read_data_acc = SMUQ10_ROUND(metrics->XgmiReadBandwidthAcc);
-	gpu_metrics->xgmi_write_data_acc = SMUQ10_ROUND(metrics->XgmiWriteBandwidthAcc);
+	gpu_metrics->xgmi_read_bandwidth_acc =
+		SMUQ10_ROUND(metrics->XgmiReadBandwidthAcc);
+	gpu_metrics->xgmi_write_bandwidth_acc =
+		SMUQ10_ROUND(metrics->XgmiWriteBandwidthAcc);
 
 	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
 		inst = GET_INST(GC, i);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index c3835c81d313..8c7e808aa8eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -146,10 +146,10 @@ typedef struct {
 	SMU_ARRAY(SMU_MATTR(XGMI_LINK_STATUS), SMU_MUNIT(NONE),                \
 		  SMU_MTYPE(U16), xgmi_link_status,                            \
 		  SMU_15_0_8_NUM_XGMI_LINKS);                                  \
-	SMU_SCALAR(SMU_MATTR(XGMI_READ_DATA_ACC), SMU_MUNIT(DATA_1),           \
-		   SMU_MTYPE(U64), xgmi_read_data_acc);                        \
-	SMU_SCALAR(SMU_MATTR(XGMI_WRITE_DATA_ACC), SMU_MUNIT(DATA_1),          \
-		   SMU_MTYPE(U64), xgmi_write_data_acc);                                  \
+	SMU_SCALAR(SMU_MATTR(XGMI_READ_BANDWIDTH_ACC), SMU_MUNIT(BW_1),        \
+		   SMU_MTYPE(U64), xgmi_read_bandwidth_acc);                   \
+	SMU_SCALAR(SMU_MATTR(XGMI_WRITE_BANDWIDTH_ACC), SMU_MUNIT(BW_1),       \
+		   SMU_MTYPE(U64), xgmi_write_bandwidth_acc);                  \
 	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
 		   SMU_MTYPE(U64), firmware_timestamp);                        \
 	SMU_ARRAY(SMU_MATTR(CURRENT_GFXCLK), SMU_MUNIT(CLOCK_1),               \
-- 
2.46.0

