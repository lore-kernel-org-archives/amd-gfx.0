Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC10D148A0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6477710E683;
	Thu,  8 Jan 2026 04:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ryIPBJ+Z";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F126910E685
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKGBiw2TAoX9gsPVnrZ+iLO3diYx8OEc3OLzXU7Pjji8ostok+/4KcNtZklir7QQKV5BzJeSUspd/zw/N+s8sWLzk3LTjRMnyAt1UwFwGmWvB/3VwwkOD7OvxXZGgA3eBqtGd9UQgr/DaWDo9DivwCr6ucSdsUIu7pN4HqwHT6J1bP2QQjkZw8rGPUjJ9x4mGsdgpOWRYwIeYNrOYpThv/hfLlQ2VSh2S7+NLJKm+zwjaBZEeyVxDKELmxodTn+0EchhmVB6iFVIO6JdCL0xXqveNzcmDFr2jPfLlqn88v1GC00wkdl/RX7ytLkIYoSgIclREu54ZFwi4S31mE/VQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVOrOAsuvdB9aEF5RI1zxnMSNQ8Xe/dptt8sSL7mWlY=;
 b=OZfeXgi3pvQjJJ7YbOwbIxkJTud5prOLElmuRYba3w3mDh9xt9SU4Kj0VzEllPP1QBrQOFOTTJevKHOuyGCVOEYo5a0ZdM/0kx2t5OhPofTnFAN3QFdS+X8DJ3m81RhQAMGfIwJMnROYzqz7JEWZmHj3UZOp9i0LNU8gVF421FckVvHrOlkkVmL7i2ud7SyfBzbX/Ed83LE/pZTfcj1LEo+afyIPaiF0nA2VNg8uD7+MgdkVsFE+mt1H76jG13u9v5EYCdkU8CGNjm+sEOtgapkMzpGqZ7f+92z8FDfJ3pCjR8ebMJkh/Yxzy8EkVH3gEV9cXS3kMcQzbAA6qf0cBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVOrOAsuvdB9aEF5RI1zxnMSNQ8Xe/dptt8sSL7mWlY=;
 b=ryIPBJ+Zr/sV8pO74lHTkf3ZlOix/F7koRAwt4QQ/KsrfgeI0AtbEnJtce9lkTNhNDCrr9i5dTXkdbi1BhxSFtbVKcB5xRrs/V8hnKYOcWpaGcZZap/mOZVf8XbSlXkxyzf9NpkzTpkqVtwtHszLJ3xL77hcUbm+jC6uoI5bAOk=
Received: from DM6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:5:190::37)
 by BN5PR12MB9540.namprd12.prod.outlook.com (2603:10b6:408:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:48 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::aa) by DM6PR11CA0024.outlook.office365.com
 (2603:10b6:5:190::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:45 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 15/24] drm/amd/pm: Drop legacy message fields from SMUv15
Date: Thu, 8 Jan 2026 10:17:31 +0530
Message-ID: <20260108044839.4084279-16-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|BN5PR12MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: 250a59a3-e533-40af-562e-08de4e7159e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?goyurZXOVLRiRflITaQHc4t+qQ5zYnDHnySG6DQLEp6M5NkCABWWt+/HkmES?=
 =?us-ascii?Q?W5FuU1f7kaIPKDM35MAk3uCly7EI6vVn6hefzAcnDM83oeyomIOvar4DkMmO?=
 =?us-ascii?Q?GiBXLmmc8kWJtSVm6TQsk1Qn/qT96M8keMqaOBs2PXGqOTpGsM8KYpUKWWUA?=
 =?us-ascii?Q?J+OYDC6U+q/5dwo9UhClUFQL1nfQUyPtUZ/pHRNcmZ/mk03L/NQNImue13vr?=
 =?us-ascii?Q?XRO+KfUeN6Ge4uLwt5KLiO64fU6YE+Q2I42kaq7EprtSMNQI6SYTixhYlPL7?=
 =?us-ascii?Q?iNcheqxebSVWVJ63B0n1ry8qR41B9MHxjPB8eSy9SSPAzpUNexD0mcTgOQwD?=
 =?us-ascii?Q?GZUpAhoeHQ8zFxV4DN4p73VOFKNpU3aM7U7nx/kr9f3ZkaZjoMBtdFnRPyXe?=
 =?us-ascii?Q?R9lnSzOfNH0/Cmn4rrzK8XDzRXCuqwk5MFIhKE0d+RfIetEhIlyTOfp/e5Pt?=
 =?us-ascii?Q?JOkKY4MTpu2TXQU2fapNaKBUIbHlYmkul6+3+t3pXTdePwh95lcgYahsTR1o?=
 =?us-ascii?Q?8lbMFykFv04jSIKmUTaNg1fR+CEGczSax/G5ndAL0FarHh4N5C/BndAxp1pY?=
 =?us-ascii?Q?6BUeqWuLFkhEP/EVjaT3WHjKIxwq0Wb3mrFiOvbCmGnhtv27uXGe3Hnh2mV9?=
 =?us-ascii?Q?6fqcX2bFWoMAXkqy8HYXlfc3ZysvpRPLexI9tF3KKf92DlujCFGAGyqviAE2?=
 =?us-ascii?Q?EmZX1jyiTepEhASNlvw7h/gAE+iik4k67wRnAGZv49p2SyW/R3nbJl6fjYfw?=
 =?us-ascii?Q?CHRsuF36Tal6YG64GY2KVqtYFIlwmAThCihSDY1AX0Ioi4X67wdsh2q6BSQf?=
 =?us-ascii?Q?fXdU/S46SQWg9zA/beItLPGTIQ4OqxPU0ZeXbr7EF/xPr7ATZ9C8AXX4SMes?=
 =?us-ascii?Q?yoyIJsG31+aniIKbvh53sdes9GKD1PxfnoSl/Ghrerv1ROOwDOhRc1tc/KtT?=
 =?us-ascii?Q?z2VLRaV2LE4Hy3eSJvm4lbYfoyWlDp540pRLy2DP1Kicu7X3YxcyRpC67Zh8?=
 =?us-ascii?Q?ONpKYgfQ9MsNZVzoYHidmzYSPcB5WCEqUsAfjHbM15DIf+ylC7Y/zlaXNunF?=
 =?us-ascii?Q?+W5QcygYHA0r8h0wJC6W1CJJArzWpqeju/xNsCNfVBmSpRsCl30Ol8NGc3JB?=
 =?us-ascii?Q?wZPoVvI8RjS5ezmvzPikh6YNh6StbYHwHWFRb6KATlgQaKv6sHyQduuRzdAT?=
 =?us-ascii?Q?9Oc5+6SiZAkopyj8My1Ym+o8Lip0vHz48433xm0Ml0ox19VEb2y4jipPCCHN?=
 =?us-ascii?Q?78gKufa+2r8A4WQZkoajEnOXZQEj8PUiVVIoU7o6JLTZmA4oh71p0yDjw1Lz?=
 =?us-ascii?Q?FZ6g4BBTLqMbYTqNJzxWsrJA0aLwTaSag9fXLBKwGk7j3PA2uz9yVcB6wbLo?=
 =?us-ascii?Q?YhQNmJv3kCgOqulfb+wlqYgIymGEFYMtlH1feXO6TIa1Cd9MkkJkuVvtAy6H?=
 =?us-ascii?Q?8u8DX6RO9euF8ccZBtOZcPYcCyDcK8JuNxvCae7hIYkqiPM6dNqU9Ccrqdkr?=
 =?us-ascii?Q?A1bzUigBQZqlQdiMObmGCeQbCp0P414yFu89hdSpM0V8IjjvtaKYrhY4X3+R?=
 =?us-ascii?Q?34OZvOws3/zXPaKc4aM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:47.9018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 250a59a3-e533-40af-562e-08de4e7159e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9540
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

Remove usage of legacy message related fields from SMUv15 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h         |  2 --
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 12 ------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 9020317ffd69..14e8d8c7a80a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -237,8 +237,6 @@ int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
 				enum PP_OD_DPM_TABLE_COMMAND type,
 				long input[], uint32_t size);
 
-void smu_v15_0_set_smu_mailbox_registers(struct smu_context *smu);
-
 int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
 
 int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index bbde9ade02ac..61387d2a65ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1333,15 +1333,6 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.get_dpm_clock_table = smu_v15_0_common_get_dpm_table,
 };
 
-static void smu_v15_0_0_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_32);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_30);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_31);
-}
-
 static void smu_v15_0_0_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1360,13 +1351,10 @@ static void smu_v15_0_0_init_msg_ctl(struct smu_context *smu)
 
 void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu)
 {
-
 	smu->ppt_funcs = &smu_v15_0_0_ppt_funcs;
-	smu->message_map = smu_v15_0_0_message_map;
 	smu->feature_map = smu_v15_0_0_feature_mask_map;
 	smu->table_map = smu_v15_0_0_table_map;
 	smu->is_apu = true;
 
-	smu_v15_0_0_set_smu_mailbox_registers(smu);
 	smu_v15_0_0_init_msg_ctl(smu);
 }
-- 
2.49.0

