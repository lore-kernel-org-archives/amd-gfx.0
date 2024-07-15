Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62D1C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383B610E38E;
	Mon, 15 Jul 2024 12:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o/VdDCOQ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD6710E37C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwVVpTDtyrBWvR3n23LIY1AOGR8zjTObFBBlaCTzEJKsGEViuVmRkkbYbkSrt61mAXvLkZruOzlvx0yqBwu8OXBS9oYjThbUio55ZAapEdW6WI4xsfv5sY29dmh7/Rb043ez4sLA11b5aW0NKgmlc4LLvnyoH9afwAZtIC932BF3jsVVcAydgC1zY8Pro5Z6y+P/TzAP+jHYh7US2BhtS1AQgz+qn9UtfTStlTFCDzlLgCvTE5EDn/bCMncSd1D/9yz8LvmJvw1A+rf3yBxCj4cTG5qlvDsjd+KauGbmV8xW4/gVX5plZ8tfBuqUaEDt2OIIFPaH1+OlWy+wCPR1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAy9KYBPbKFnfadRMEGFtH+a5Toti8/IIKA7wy2OxWI=;
 b=YYoW1MNws5j3A0BbVrtm10VWmB9FM1HSj19iQLcBXlhB0FutWXXzWsxwta3edFts1Rvm/ruYgeWDkleYO+CO75Nv1WGm5uAy4/QSQIugXWuBN2Zf/BULQgtDYCg2+vPiTqWMf5+Owso0Hts2vTAI/kMw68Mq0Hvs6PUm3fSoMBWQhYrCm078h/iu9CstLRHInEZgAfhLbfYQtCuOQMWXb7q6kpmtyMttSsIiRBZU+spDZJ7L8IUQDSQv8p71ITx+WccMauWEG98QSbGbcl9VLgoDNclfFQJHPCMhFQx6rvR8Eq0Pqtz2oMGbJ2yQWe01Ze79xh6lpPYJw5VxRx0ayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAy9KYBPbKFnfadRMEGFtH+a5Toti8/IIKA7wy2OxWI=;
 b=o/VdDCOQ9W+ArINWwKRkcK4L4ic9AKGCuXP0nf7+YwvKTFqWSDD5GgaQbEerJp1j83Ip/URk4xF1gWNVXKDHnxRjcBx/kLvUg6XzQc6b5X2pRI63laylifeA6xgpri5Fz2eaql/aYh33zxk3RdfijJJOuj9TvfItfmAvO+B65sE=
Received: from BL1PR13CA0327.namprd13.prod.outlook.com (2603:10b6:208:2c1::32)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Mon, 15 Jul 2024 12:36:32 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::33) by BL1PR13CA0327.outlook.office365.com
 (2603:10b6:208:2c1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.12 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:32 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:29 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 9/9] drm/amdkfd: Validate queue cwsr area and eop buffer size
Date: Mon, 15 Jul 2024 08:35:02 -0400
Message-ID: <20240715123502.7013-10-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715123502.7013-1-Philip.Yang@amd.com>
References: <20240715123502.7013-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: cef8bd8b-5a8f-4910-b6fe-08dca4cac208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t8jeF1tlWPs4Akxk6dFheCpZ+y/ENYhpqs/4Pd2Q9NkpdswrbkC30w38rPKg?=
 =?us-ascii?Q?NYYizDGIxCwojq96/clrxbkOOjel/R6tOG2mPafZ0MThXuOJ6YecrCM9D2/t?=
 =?us-ascii?Q?5r6J+96U41xgt8db6NM+jpT8eLTI4k3s3ETEw5ZEN2svFs8L+TXfE/Zi8Fsr?=
 =?us-ascii?Q?HOceEN11yui+PfYwC1JttWTLw+yLlh7XfNRDrrRJe67rNz2Njg2hLmRMD7qC?=
 =?us-ascii?Q?O8HdpfMGTZuKwFMxV+t3LWrxBZUfpN8+aS+2tmqgkjsESG6uzgOmTb8LsttI?=
 =?us-ascii?Q?b+1QkGQ2YgAiMuGb05UUPvPrrEzajycrIZWd8gqabrzOUPlH1b282u3ktMwo?=
 =?us-ascii?Q?e/e60Fd/mGpBQVp7tWtOJiXxXEdlKGa3UZ9ftLTja/6K4fS1i+YYlItNdHfK?=
 =?us-ascii?Q?DGoOptAEZwSKADK0RGMcvmcbBzBUm/zySsdTREHznzvs1+5Kwl3CnxQZIa3g?=
 =?us-ascii?Q?6apWbByAp7cSpCS+3gWMIzypc6TU0L1yUNHNh/TIxMGFt0/95g+95mcmgg7P?=
 =?us-ascii?Q?L3ExcGUJAQUcgqdRjs2Q10gMltIbGlsjJT9EggzEI7SMeEPv4EOKJI/8rn0z?=
 =?us-ascii?Q?AVL6jbJWboNnjSxgnqjQsIQDEokZHhw9QUSstiLyMf9WHptW1JmTMUdhRKX6?=
 =?us-ascii?Q?k3gTfP8H64oJZyfdVPdhUFs12igjxZ3VHoaio8XL6GYdCVgbgeePV9H4/uRz?=
 =?us-ascii?Q?M3ROmOsf2ja09elKS2/s8iypzpk0DeZ7g+SHoQb6IYbymkVJh2IuXN6fvvHn?=
 =?us-ascii?Q?7EVzmr1KrBOICQkLd53WmNNxZUyMdp4BfxiLj5iDjRoNDju/Lann+A2Gckoo?=
 =?us-ascii?Q?N1IfOigzxQ1twjo5HqOqmjEesSVUXa+E55jNewEHEfh7cMFgtRPKM2ilqGLX?=
 =?us-ascii?Q?X3gYygvkW5+XpGTAbPpclTQPIjWWeNiGeOKdoRzBws7GMoL07oo9uIHDd4pf?=
 =?us-ascii?Q?IFxPdrNNQuPYu4NRIwaakWHljfCk8h4oKwZtURh1kiY74aTsB4wdUHV5qudZ?=
 =?us-ascii?Q?6cH4OLKezRSAZv8CQ9iLFc6fbCUolpYHkRHG9D3wqarYejGrKptcW0HHCuRJ?=
 =?us-ascii?Q?9iWMEljpGBEqcgUCkIEkuM5DBybr0I0/yykcIjkrzrFhM3CuoOWpEsfbf15U?=
 =?us-ascii?Q?7BnIRU2SF1H/009n91LfAJtxhjuk+BZRowWvjVOQo8FusnjSzKy9fLZkNXzD?=
 =?us-ascii?Q?gPiD1jbxkEf1T1oxZSgOh8sNvtjQInXgCCtX5iytQVUGDjMpIUu138EQC7AK?=
 =?us-ascii?Q?nzztJ+QcyaeMPG0iWzzaxyS+odG8HHpYHQaCm3U8fBhf119cpNoxMBufYGN4?=
 =?us-ascii?Q?RnfVydX7QmmRangQVLfnpY8/yWWVHJpr0BNYRGyGCdSyOhq/D0XDVmwN/gKR?=
 =?us-ascii?Q?zUcXvCnEE/+G2Utrh9TTEMIdPILlwDGlPvpRdKIql6TiaNflkwAuKSVLOtBL?=
 =?us-ascii?Q?PQTWy4QwdxaS+e0lF+fAKmO0TIr5Rmsn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:32.4530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef8bd8b-5a8f-4910-b6fe-08dca4cac208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
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

When creating KFD user compute queue, check if queue eop buffer size,
cwsr area size, ctl stack size equal to the size of KFD node
properities.

Check the entire cwsr area which may split into multiple svm ranges
aligned to gramularity boundary.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 46 +++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index adcda9730c9f..9807e8adf77d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -225,9 +225,15 @@ void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo)
 
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
+	struct kfd_topology_device *topo_dev;
 	struct amdgpu_vm *vm;
+	u32 total_cwsr_size;
 	int err;
 
+	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+	if (!topo_dev)
+		return -EINVAL;
+
 	vm = drm_priv_to_vm(pdd->drm_priv);
 	err = amdgpu_bo_reserve(vm->root.bo, false);
 	if (err)
@@ -252,6 +258,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	/* EOP buffer is not required for all ASICs */
 	if (properties->eop_ring_buffer_address) {
+		if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
+			pr_debug("queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n",
+				properties->eop_buf_bo->tbo.base.size,
+				topo_dev->node_props.eop_buffer_size);
+			goto out_err_unreserve;
+		}
 		err = kfd_queue_buffer_get(vm, (void *)properties->eop_ring_buffer_address,
 					   &properties->eop_buf_bo,
 					   properties->eop_ring_buffer_size);
@@ -259,15 +271,33 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 			goto out_err_unreserve;
 	}
 
+	if (properties->ctl_stack_size != topo_dev->node_props.ctl_stack_size) {
+		pr_debug("queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n",
+			properties->ctl_stack_size,
+			topo_dev->node_props.ctl_stack_size);
+		goto out_err_unreserve;
+	}
+
+	if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
+		pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
+			properties->ctx_save_restore_area_size,
+			topo_dev->node_props.cwsr_size);
+		goto out_err_unreserve;
+	}
+
+	total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
+			  * NUM_XCC(pdd->dev->xcc_mask);
+	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+
 	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
-				   &properties->cwsr_bo, 0);
+				   &properties->cwsr_bo, total_cwsr_size);
 	if (!err)
 		goto out_unreserve;
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
 	err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
-				       properties->ctx_save_restore_area_size);
+				       total_cwsr_size);
 	if (err)
 		goto out_err_release;
 
@@ -286,7 +316,9 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
+	struct kfd_topology_device *topo_dev;
 	struct amdgpu_vm *vm;
+	u32 total_cwsr_size;
 	int err;
 
 	vm = drm_priv_to_vm(pdd->drm_priv);
@@ -302,8 +334,14 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
-	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address,
-				 properties->ctx_save_restore_area_size);
+	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+	if (!topo_dev)
+		return -EINVAL;
+	total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
+			  * NUM_XCC(pdd->dev->xcc_mask);
+	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+
+	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);
 	return 0;
 }
 
-- 
2.43.2

