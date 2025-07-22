Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87B7C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 17:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF3710E6E9;
	Tue, 22 Jul 2025 17:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GzAyYUVz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1356A10E6EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 17:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkMKQW3MYD22hXk8RdasneSB8rFZcUdXOXe2JJmeJcAQ/aZnKHWOM3B+MFsUAN4ETItfgg5WEonKFJjW8u4SBhH3HgR7gor55J+71r+Ca5QVvGQsEOZvx2d9pHqgMHlRNgvUw+pCp03u5BYlSte8MntECB9+1Xw7L1QpP7sXyeOwRqS4KTxgwT9xcrwbde1m2bzOtXgR5h242d+i24vsMR2mQgprB5SPloqtCDzPHBuL1eVnOZo5uL4GO/0bbYJIHoa5hMq+ly85kvdKITsd4QsOdoOszLalo/C0/+XnCopr2bnV3HApdeDdqY2xea1d3nEQZKHU80CaPD3TtivROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfbbGSViUVB+Hx86/WpVGAueO7jxgqEU2JTtKmI0/nU=;
 b=QnVYw/stCwaEnZw5ZYfS3PpGDhGrMHjQ5B8YK3ow7fwAQzBEzkg51HARc1kAyipdN9LELZM3PYEwPHtPI/AoYyWlQFURrSaF5l77wJxSAFXV6Eb4OpR9PSwSF3op2Xp0TqR9bdWIUNv7TyWHhvlHqDz8fLJcibKXx1WHVi2MiEa1wl7jw1jqdyvnVGWKw/K4ebBPh5mykFgWIvTIRbVDN+WIJPyFjGRB6hfn4HIj9SYi9wt3mxlRLAJ6oa0COc9VGyxgGh2FHbtotGphq+QQJ1lXH42veVV0awSeVgXrIqlqu4uCSMyL7t2rJLxBqpLaIJY+FN8259cMmOmUk//bZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfbbGSViUVB+Hx86/WpVGAueO7jxgqEU2JTtKmI0/nU=;
 b=GzAyYUVzuZmrwedWvfkNxXh9liKehUMeFeMIvTsJ7pJNUASRMAh6AA4hu1g6bbrJzfi7EvKICPWzAGAGPOgeS6NKQR6qdqps/pvyGQqcL8Skut2ArQnw9KKjrpU+agqORRYz1uedcQPoMNOZ+bf2vH+AYE2pRkwhojkc2LepTmg=
Received: from BN7PR02CA0009.namprd02.prod.outlook.com (2603:10b6:408:20::22)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 17:47:27 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:20:cafe::ef) by BN7PR02CA0009.outlook.office365.com
 (2603:10b6:408:20::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 17:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.1 via Frontend Transport; Tue, 22 Jul 2025 17:47:27 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 12:47:25 -0500
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Rajneesh.Bhardwaj@amd.com>,
 <david.yatsin@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: Fix checkpoint-restore on multi-xcc
Date: Tue, 22 Jul 2025 13:47:12 -0400
Message-ID: <20250722174712.450292-2-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722174712.450292-1-David.YatSin@amd.com>
References: <20250722174712.450292-1-David.YatSin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 87159b83-6c5a-42bc-7d0d-08ddc947d2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L5rEiRyi/q1W/+4HQWPQfUInkwdwwbmxElvIh2FQ7EMi1VH8igNT+n7jHuHK?=
 =?us-ascii?Q?m4NmRlUfbvXMNNEEs2MZ4x3MwPa0k2nEI1H2194Sf0BNtiW9z1MlStKhzV8R?=
 =?us-ascii?Q?oog3aOe7fLveLRjPB0WO7erLdYnnLW9XvvMcf/HntZ95V3ll9La2xRNjBpNj?=
 =?us-ascii?Q?1w57m989+ftZlMtjNHiezXijhDibVbMF26r8HvPhVldYDTvBhJctjQETT26H?=
 =?us-ascii?Q?gxq+Wf64StNnhu3meY8lJG0Zq3roL7FdeH9hvpMjWuDfhCGwHCdn4KpJDQNA?=
 =?us-ascii?Q?nfwMFcubm3bT3T/W4jwXk2zw0Q19Gr59Z+cPAfd2qUoooHpppFAkoAHJ+LDA?=
 =?us-ascii?Q?hfT1njyl8P9KWvpFWAIdmq4+8JgVjRJieIYdbsPrz9hQwCuo0c+ft2uCCoFg?=
 =?us-ascii?Q?QqrLfs+Jb1Ow9jHd3xM+nUPZB5ENH9MsBMxlpN/n/BsuG8Fqa8MfelAX40yd?=
 =?us-ascii?Q?7xGUrqloYSeAOArwdPOcnKu8Lv8iFWPDU9iBMSNP0N+FVefbhd/eLcMf0+kV?=
 =?us-ascii?Q?WF6xHuU2YO+iPHnEWVmJNXJqIpPu1+ji8Unh6C7REpP7Bs5G8ztaHid7kBYe?=
 =?us-ascii?Q?EygpuHRrBIKFUvdDRjLBoIimddm3ry/4hofQvdy/sdjRksGtySp/598bKH/C?=
 =?us-ascii?Q?D9QHYJx0sBMgTIF1cTUHKJR9L7r+FM3RxaD59hOlXDR3vuN0TUujRXUiCDnx?=
 =?us-ascii?Q?i2yiEXexJkMCpUkpImyxkIcqt85fiR1P0zQ0wPwQw5lfQYrrV2OMYux3PRtU?=
 =?us-ascii?Q?1WjXjRRyjAEbheYpeo/Q273WdbV74X0qm2P6nMpFxE2RTPOpZn81rLZCkq79?=
 =?us-ascii?Q?B2jD6uik3aMwBX7rHwDgus4DgyawOeRqtvgOkRPqFhw4ysOFhcrdmaXgoLcH?=
 =?us-ascii?Q?rIQ0QxpjvzmIdi/Z1RzVEalFgW6rfP8I9bAbSX53L1PybsZtcgniSyOKDneT?=
 =?us-ascii?Q?+4m7s1o2HLHJPuil9tmeDGIvq1qUXJPuXd+VWCw8y8In9OF4cVT1NgBYMKX1?=
 =?us-ascii?Q?CLO28J/hhvLV5uH36NBHczmBcnLiaW2OCk8/N/NI6DNzP7aSIpAz2TLqBV/x?=
 =?us-ascii?Q?pTJyT8Hee+Q+YQUaeiI+qf8iZ2HJ3Jz7vJI0quJiMrz85cEM9862EBS2pnAI?=
 =?us-ascii?Q?ChPIKOEVNlzWkdLfFJKHHIY05ppT7g99fjLx/AIqQWHuaD2HOY7nth40BI3K?=
 =?us-ascii?Q?Re/8hHiRkqLhzQTwBzr0WmpOEvlr4VY8SfbfCwJaKD6xObPvvOtldnTP805+?=
 =?us-ascii?Q?bGYXHAz9anTK7nk8Slw7pC6UUUWq3v2/OG+EaeyKP5CBrivVPKT7tRFOgjds?=
 =?us-ascii?Q?mLGlG2ieVU/tXkuTbyNHCwp/ZBIV5RliQy2OnkvmnT+ZDLgHdAAbvX3a90hW?=
 =?us-ascii?Q?bbvH8JK+8Z2diAgvOAK02855MhWCt0v8vYlwTvtse9tR/JBdogn+arxaNCXF?=
 =?us-ascii?Q?FE0W14cysoZomrKE6DNsOx736L/VmOWf4oPUztIuEmQS7z2ghqf+7LFD+Hup?=
 =?us-ascii?Q?levFWuXpWTwF0F6NSwlQ2XBaq8TZPaMleb8A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:47:27.1150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87159b83-6c5a-42bc-7d0d-08ddc947d2b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
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

GPUs with multi-xcc have multiple MQDs per queue. This patch saves and
restores all the MQDs within the partition.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 61 ++++++++++++++++---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 20 ++++--
 3 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2d91027e2a74..6c5c7c1bf5ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2725,7 +2725,7 @@ static void get_queue_checkpoint_info(struct device_queue_manager *dqm,
 
 	dqm_lock(dqm);
 	mqd_mgr = dqm->mqd_mgrs[mqd_type];
-	*mqd_size = mqd_mgr->mqd_size;
+	*mqd_size = mqd_mgr->mqd_size * NUM_XCC(mqd_mgr->dev->xcc_mask);
 	*ctl_stack_size = 0;
 
 	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE && mqd_mgr->get_checkpoint_info)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 97933d2a3803..f2dee320fada 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -373,7 +373,7 @@ static void get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stac
 {
 	struct v9_mqd *m = get_mqd(mqd);
 
-	*ctl_stack_size = m->cp_hqd_cntl_stack_size;
+	*ctl_stack_size = m->cp_hqd_cntl_stack_size * NUM_XCC(mm->dev->xcc_mask);
 }
 
 static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
@@ -388,6 +388,24 @@ static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, voi
 	memcpy(ctl_stack_dst, ctl_stack, m->cp_hqd_cntl_stack_size);
 }
 
+static void checkpoint_mqd_v9_4_3(struct mqd_manager *mm,
+								  void *mqd,
+								  void *mqd_dst,
+								  void *ctl_stack_dst)
+{
+	struct v9_mqd *m;
+	int xcc;
+	uint64_t size = get_mqd(mqd)->cp_mqd_stride_size;
+
+	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
+		m = get_mqd(mqd + size * xcc);
+
+		checkpoint_mqd(mm, m,
+				(uint8_t *)mqd_dst + sizeof(*m) * xcc,
+				(uint8_t *)ctl_stack_dst + m->cp_hqd_cntl_stack_size * xcc);
+	}
+}
+
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *qp,
@@ -764,13 +782,35 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 			const void *mqd_src,
 			const void *ctl_stack_src, u32 ctl_stack_size)
 {
-	restore_mqd(mm, mqd, mqd_mem_obj, gart_addr, qp, mqd_src, ctl_stack_src, ctl_stack_size);
-	if (amdgpu_sriov_multi_vf_mode(mm->dev->adev)) {
-		struct v9_mqd *m;
+	struct kfd_mem_obj xcc_mqd_mem_obj;
+	u32 mqd_ctl_stack_size;
+	struct v9_mqd *m;
+	u32 num_xcc;
+	int xcc;
 
-		m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
-		m->cp_hqd_pq_doorbell_control |= 1 <<
-				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
+	uint64_t offset = mm->mqd_stride(mm, qp);
+
+	mm->dev->dqm->current_logical_xcc_start++;
+
+	num_xcc = NUM_XCC(mm->dev->xcc_mask);
+	mqd_ctl_stack_size = ctl_stack_size / num_xcc;
+
+	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
+
+	/* Set the MQD pointer and gart address to XCC0 MQD */
+	*mqd = mqd_mem_obj->cpu_ptr;
+	if (gart_addr)
+		*gart_addr = mqd_mem_obj->gpu_addr;
+
+	for (xcc = 0; xcc < num_xcc; xcc++) {
+		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset * xcc);
+		restore_mqd(mm, (void **)&m,
+					&xcc_mqd_mem_obj,
+					NULL,
+					qp,
+					(uint8_t *)mqd_src + xcc * sizeof(*m),
+					(uint8_t *)ctl_stack_src + xcc *  mqd_ctl_stack_size,
+					mqd_ctl_stack_size);
 	}
 }
 static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
@@ -906,7 +946,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->free_mqd = kfd_free_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->get_checkpoint_info = get_checkpoint_info;
-		mqd->checkpoint_mqd = checkpoint_mqd;
 		mqd->mqd_size = sizeof(struct v9_mqd);
 		mqd->mqd_stride = mqd_stride_v9;
 #if defined(CONFIG_DEBUG_FS)
@@ -918,16 +957,18 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 			mqd->init_mqd = init_mqd_v9_4_3;
 			mqd->load_mqd = load_mqd_v9_4_3;
 			mqd->update_mqd = update_mqd_v9_4_3;
-			mqd->restore_mqd = restore_mqd_v9_4_3;
 			mqd->destroy_mqd = destroy_mqd_v9_4_3;
 			mqd->get_wave_state = get_wave_state_v9_4_3;
+			mqd->checkpoint_mqd = checkpoint_mqd_v9_4_3;
+			mqd->restore_mqd = restore_mqd_v9_4_3;
 		} else {
 			mqd->init_mqd = init_mqd;
 			mqd->load_mqd = load_mqd;
 			mqd->update_mqd = update_mqd;
-			mqd->restore_mqd = restore_mqd;
 			mqd->destroy_mqd = kfd_destroy_mqd_cp;
 			mqd->get_wave_state = get_wave_state;
+			mqd->checkpoint_mqd = checkpoint_mqd;
+			mqd->restore_mqd = restore_mqd;
 		}
 		break;
 	case KFD_MQD_TYPE_HIQ:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index fe4c48930aad..bae200035ff4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -922,7 +922,10 @@ static int criu_checkpoint_queues_device(struct kfd_process_device *pdd,
 
 		q_data = (struct kfd_criu_queue_priv_data *)q_private_data;
 
-		/* data stored in this order: priv_data, mqd, ctl_stack */
+		/*
+		 * data stored in this order:
+		 * priv_data, mqd[xcc0], mqd[xcc1],..., ctl_stack[xcc0], ctl_stack[xcc1]...
+		 */
 		q_data->mqd_size = mqd_size;
 		q_data->ctl_stack_size = ctl_stack_size;
 
@@ -971,7 +974,7 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
 }
 
 static void set_queue_properties_from_criu(struct queue_properties *qp,
-					  struct kfd_criu_queue_priv_data *q_data)
+					  struct kfd_criu_queue_priv_data *q_data, uint32_t num_xcc)
 {
 	qp->is_interop = false;
 	qp->queue_percent = q_data->q_percent;
@@ -985,7 +988,11 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
 	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
 	qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
-	qp->ctl_stack_size = q_data->ctl_stack_size;
+	if (q_data->type == KFD_QUEUE_TYPE_COMPUTE)
+		qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
+	else
+		qp->ctl_stack_size = q_data->ctl_stack_size;
+
 	qp->type = q_data->type;
 	qp->format = q_data->format;
 }
@@ -1045,12 +1052,15 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
-	/* data stored in this order: mqd, ctl_stack */
+	/*
+	 * data stored in this order:
+	 * mqd[xcc0], mqd[xcc1],..., ctl_stack[xcc0], ctl_stack[xcc1]...
+	 */
 	mqd = q_extra_data;
 	ctl_stack = mqd + q_data->mqd_size;
 
 	memset(&qp, 0, sizeof(qp));
-	set_queue_properties_from_criu(&qp, q_data);
+	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->adev->gfx.xcc_mask));
 
 	print_queue_properties(&qp);
 
-- 
2.34.1

