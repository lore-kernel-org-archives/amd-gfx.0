Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6C2C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 17:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5713C10E6E2;
	Tue, 22 Jul 2025 17:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CIv/zqMx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF1010E6E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 17:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSyI4HaoAZi6KIT1Fjv7mUsJFcTGkXYl7WWEopHH2Y+1uF57d6Gc02/9f0Y0KPYnz4GvSB0no3K6HnZvhYU9ypbHCKaswy2Z1FjCOm2kyIy9Tj3qou1/N/dJfnwb002IYNh/tayT8MLvwx1u9vspVbK9b4XKk7Cb0RMjG8NOl0AMUt+wG/Vr0n/HEU780AcAmiKiPht4KGJt/fhwwJmSUtDMY+wThXXzWUq7PF8/ZgmtTFOfGC0CpQPQdLcXbi0fgWoMsQmXAmJrPLXW3oDsigVXjYNfMc9pihms+cal8n4MmX2M+wgVoYW/PlASxXGNUA2WCWe4ttdW7iNS91qeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkWa/O3SQ5A6xxlHzQGWDmxFB/4XVBC0p+UBrCdtfkU=;
 b=VGdc7dB1jwGSCUtNCgLcb5QJCF/tYlIaO6JmLEFgb3AkcOP1ylA2lDc40TricoGf/kGam+1fkLnscpvlcsP9neFUA6BTBGS69CHorvHQd348qdogZd2jPBU/zMafdHbQmrQ3q/tqNYfdNH8s942nT5WexuC+ldEFjYOL8zEMaq3rjKBQzIS1XQM42MryGSrGwCqxbdDoQslMAZqB5l9f+lhitBtUSDmZwRQv5xDSopp5/UTrYStwmLS8waHusFcmGS1SU/IA4qvnT9PjN1vmgEUNwf3Sw2sYVyqml8UImKtz303YGtXUX0lyWWUXOQVTZn44l9ZEWahi9JJ2n228ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkWa/O3SQ5A6xxlHzQGWDmxFB/4XVBC0p+UBrCdtfkU=;
 b=CIv/zqMxerLGcDBYAMs5c5fTICez31gswGuWSdiXIXE6GqwmeQ7VNaqLU5/x+qXMrPm+8GnXOQ2M2mRYb6rssV10669oCdM98iKClg+t3BXDyyqZb/mKnoybW5fq6Uy2WpiHlQkTIfhgr90VKVadPULpIr2gpGYc4y2evj0X5fM=
Received: from SJ0PR05CA0194.namprd05.prod.outlook.com (2603:10b6:a03:330::19)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 17:32:10 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::46) by SJ0PR05CA0194.outlook.office365.com
 (2603:10b6:a03:330::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 17:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 17:32:10 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 12:32:09 -0500
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Rajneesh.Bhardwaj@amd.com>,
 <david.yatsin@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Fix checkpoint-restore on multi-xcc
Date: Tue, 22 Jul 2025 13:31:15 -0400
Message-ID: <20250722173115.436932-2-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722173115.436932-1-David.YatSin@amd.com>
References: <20250722173115.436932-1-David.YatSin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: aee5a553-8031-4a7c-7134-08ddc945b039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZWORU3nH1+XCOjAzjHWBeXvQeJhT7LiqxlatiEW9uutzgGrpaADEMcCyxQrq?=
 =?us-ascii?Q?p3TTq7qUfxDCTrqq186PAcdGevKCQhzrUpUN9WqYqUj/++/PcmiVGYM4BnnR?=
 =?us-ascii?Q?vcDJmS6ve4WKYFIy6lL3Qg7itg06la3+IoVwMyGQNLK1vLv9tEUYr4aUhN58?=
 =?us-ascii?Q?MUoWAGxPIEFaRsPAYl7QJmBEhRfB3rrqhTUzNh195P3QrUoyOPFXw2CT8vC7?=
 =?us-ascii?Q?pY0fPp3roJavVIUgGgTG3DuFFlhvZTF/wp67Eq6ncL1w7h84f89zirqExmDA?=
 =?us-ascii?Q?1gp+vfkIQDgsYl6CNM6V++MGuzdgVLU46+GwtC6X0fKEyrImTy+EgDf/3HOO?=
 =?us-ascii?Q?l8C8XnomXt4oHUDoQ7djslEUbuBqxbCzHVImyjaS96L5s9au1cHJS8EcNJeK?=
 =?us-ascii?Q?BvojRJ5wjV2zd33kJszNksjwd/0ppgYeRrcRD4+7xgJtvtYVBRDTpItEagp9?=
 =?us-ascii?Q?Bx5mi0pUNWRfpFBrbbmiSq5xqssxPidspNpTXrxj8usunIXKr2hP9Gzp9Eiu?=
 =?us-ascii?Q?Vue2PkyL+t0K003JB+Hlj0Tnh3LxWXYMpOSuGsOl3oB9yzqJzjqHq3mxCnuF?=
 =?us-ascii?Q?PKTABM7VHa8bZwo4P14VSa1SIBF8MIuDdWZkZN72dqc0bFKAAV24/yGfALkc?=
 =?us-ascii?Q?sNhRBMYvZ+5LzXTvLOy3ekL21DMdLKJRk9RcW87/4ieGxwobtHlgK+VvMd6f?=
 =?us-ascii?Q?wxehnpbV5EwlmkXWZVM35MWMxbMItiVJJAfVcqawKNod57aJuCapYhwNhMzz?=
 =?us-ascii?Q?0JTdV1EBMsimfKD2fMydn0WxQ0/C5XfyfVf6Zm8d+NWS8k+gPEbVaasVgFys?=
 =?us-ascii?Q?NRXKT+sTg1WSUcbabCQv9TIzAlW9ER9HvKAvSPcNoHYL+YGj51V4v/bJqd6K?=
 =?us-ascii?Q?WkMWuhpzY41gtIHjvGLxQiBRSzg3STkHXp9z3Kzj7iRDQ22LtppQzz5FGcQl?=
 =?us-ascii?Q?Pd+G5vaQcp8uUGXy44GkRua/KGFyehenblpsbSSD+X3+ElUHEJi54ksY6Wz1?=
 =?us-ascii?Q?9dEf/RkkcTlxYPqbfoj84/mhLr4r/99B2Dh3Y/1Pp36DLTYtxVlOqmbFWWDp?=
 =?us-ascii?Q?IlUS+Y+YKAnsw4uoAdQolHRxa1N+HjgVnFL9Mf+5k5aoRJHb4Eu2cImAcKUB?=
 =?us-ascii?Q?KSWwICG7vtTCJB6YGACgvcqWPpyotFeu2MIBM1Mul4nDSjyaVkZg+uIWwzLA?=
 =?us-ascii?Q?O4uZDtoffySdYCljxda20NzMc8gDn0pd9k2Gjb7sFUuD4BfrXM9UP2+24Ppb?=
 =?us-ascii?Q?ADBoVDyFCSsa95PBT5EZ3X0ATQAaXRiAEQcEsdK5mwPQFXV3ItW6YntSDRdL?=
 =?us-ascii?Q?NooQYKibqRWe6gExYJFBKxc/YQSJkDj9kd4TSWmVfPU3BGooXGvwQfgkefOW?=
 =?us-ascii?Q?FhPzA5aChSuZvk9gOek+i7X7qmHL6ibW63CayyAaSmfrQZ3uP0EgDTL7w96z?=
 =?us-ascii?Q?9z4zHf2ZL6tI0zDgiig+/EB7fiD1Kj8h0/UPg2wKhTfOk2v3DRf6BkyVeHLl?=
 =?us-ascii?Q?ldfGNyTQ5WNycIkhgL4DJ3zcteAmqDeqdXrN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:32:10.1603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee5a553-8031-4a7c-7134-08ddc945b039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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
 .../amd/amdkfd/kfd_process_queue_manager.c    | 21 +++++--
 3 files changed, 68 insertions(+), 16 deletions(-)

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
index b64bc47748f1..bae200035ff4 100644
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
@@ -980,11 +983,16 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->queue_size = q_data->q_size;
 	qp->read_ptr = (uint32_t *) q_data->read_ptr_addr;
 	qp->write_ptr = (uint32_t *) q_data->write_ptr_addr;
+	qp->sdma_engine_id = q_data->sdma_engine_id;
 	qp->eop_ring_buffer_address = q_data->eop_ring_buffer_address;
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
@@ -1044,12 +1052,15 @@ int kfd_criu_restore_queue(struct kfd_process *p,
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

