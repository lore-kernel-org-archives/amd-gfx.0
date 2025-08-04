Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF773C87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A9C10E441;
	Mon,  4 Aug 2025 11:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G03IAQV9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0ED10E441
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=potJNzZkTtQnZZ9H+ZalTmMLcXmM6Zt/i7lQM4y/YWUZOrC112EjuFE7dfVW4zb7PR12fUui3dO7Cc90rqpC2lCEeZvrHFRDz8R0kNMaE8an8g+yglqaYZYZqheo74KLqUU4rujF4em8jz4hf9+wZ4Bo4mo2oOJaZlB4lNbaVTiUC8S4MLeByAkuOAUOH2abk0sGXKpb4GAZrrcxETqMInpCQxw14F7HtVOwOzgexWyc8DOPGkI2lKkmpz7Jp9OoNSNC3r00a5FPgDsPWOx9Viug25PI2xLzqWytqfrE0ADVAmW5lJReI8ZlVvE6fJGqs1RN/iYWZTRrXecJTx6YbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xornx2r4E5vIdys6vBkb76d/Co3SM683iom9hjvp2CE=;
 b=ly6e8GmbebmGUDze9ov3s1Hv/0yvoKlV22yG/5ZJ49Mt43M8WkT6bQfZH9ESKvhHr9iXFXsIvExlgRcxJTqLD6ZdgcRApznyV4HLtDFIRkE9UJzkXq/uPyxjsgA2e1UBJhp1rggEmUwcK1W0UzPMNL7/03PyMPxvl4WEWGybUxkh8v8Y7SHX400eN0hIqYHi/cLBdNEDHsI0l8qNQIaYR2OQE0CwbieXWhzmfTZBJ4u/IHS47W0ItUyM7uiKsIpxbbfk6yqBHfxUyrqVNlJ+dCPMHMEz8wnvxi2g3FWu+6vfjj1Q0NOZTiTyMJvs9TVNrdY8Q0UtxQTtuVHJQIidMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xornx2r4E5vIdys6vBkb76d/Co3SM683iom9hjvp2CE=;
 b=G03IAQV98jrVjPolPAqT3nTK02NcNkPSF0HeHDNyLkIbEHxTUGtMjAHtacBF8mdch+t7/6vnzYbaabLmoFqbIDOK29TdtNBgE/FpsfWaNC64to1MocSPvwZ2ETIZnu/7/vKqYMxlZlnjzKJJCDUhsfs4QT7UjwC6cUSzFoIUdqM=
Received: from BY5PR16CA0036.namprd16.prod.outlook.com (2603:10b6:a03:1a0::49)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Mon, 4 Aug
 2025 11:06:49 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::6c) by BY5PR16CA0036.outlook.office365.com
 (2603:10b6:a03:1a0::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 11:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:48 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:45 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 11/13] amdkfd: remove DIQ support
Date: Mon, 4 Aug 2025 19:05:48 +0800
Message-ID: <20250804110550.261311-12-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 13cc5fc9-4795-46f4-2563-08ddd347020f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aS1ltIE+xIC/Ls/BRDUx+IRLO1Esaa3KVJ+MnrCPrRJQBB7WepClrRSQZNrr?=
 =?us-ascii?Q?qTSaBQg1kslfVzdrPya1Fk81LWgMmuTiv8X/60Y+dsmzgiZmTK5yxFxsL0DC?=
 =?us-ascii?Q?HDBhCGmjf2AXTbMdMfSpMRBXNH5I9vPV835rFNxuhX2yk62P//YQteMpA7po?=
 =?us-ascii?Q?kJTHGcE8Itz+ebdTtuwQXEdhZ48ZqwI70/kr6yVCEtcVWRq8wdaFVv/6tpig?=
 =?us-ascii?Q?FDeK6Vz2l2G8E/DSp/42eYl3FppdWLcA51YpSEUPLrhuu1y9foqS429Nsm1h?=
 =?us-ascii?Q?rnO21XH1TxJ6z39DndL+ezfLd6naYItsscCFS/TmrNH5Nm1QR9E6Kvo8IPs0?=
 =?us-ascii?Q?0QgFPZ5pBUI4JaKxuuAk+oGda1RrhePJ2mjlknwY2CWuDHF9gzB+DrL3hzaK?=
 =?us-ascii?Q?4mbCS0Pybk34XCiD9kNMxQ9NAoC17lv2XdoiDmzFPjZOj4OyzMXraiXTeqa7?=
 =?us-ascii?Q?F+tMS+rvBvkcbapuS8jI+4lDPNLIUnQqnFM50jta7AExgdyDJH/42u0Z1vcW?=
 =?us-ascii?Q?5Llzyyx5eUTSFGoGH7L4z2UOFR5U8u6MJNw5hiuv7E0oQ38SQnu74N1+GG5c?=
 =?us-ascii?Q?7ClHNu33PLp+E7Tm9Za9dbSQOcQxSwIn3pvs3QYs5vtizk+hEXuA2JcRZ/uM?=
 =?us-ascii?Q?Q0W92t/pnXmH3yaf2/CI8iDVcWhx7tHIFlM7gfcM1801IOyn2q0syGwqP/rn?=
 =?us-ascii?Q?xuK/m93KkUnY8tl5YIMWwLCnUjyMyUBBD1tpn5lmzWRivvIcS9LysMwUbZed?=
 =?us-ascii?Q?fSryN6nUVQ4a+eL4b0gd9AJuEUIfshcwN13SumZOC9tlEZCA/D6ah4p4WJgB?=
 =?us-ascii?Q?r2P6+PHOGULcnyU3gyy2Lz2iK5RyYXL4GsKOTWvZJGpjtG/JpX5lDrByNOY8?=
 =?us-ascii?Q?1CKPulQfVpyc6Y3naTZNJFi8EMaTbziR0eNNqSaMoq8rpAM67qsDwY7m+QCT?=
 =?us-ascii?Q?nsxFsz3SPzVoxg0Mso499JGs2JpyNzeHTca8iL4SCUZM/YndfOWclUINtla9?=
 =?us-ascii?Q?dz5mSSKCZbccigQCL9+4kM6U3+degOW+Swh4FZCWwpFS9rwQRCiAAjxs8j1n?=
 =?us-ascii?Q?fpqunskt2dIjIviq+1xULsooziKa8/e68f4U5Rwv742hQ9BkYzXSnr4wBQ0F?=
 =?us-ascii?Q?3nai6wN4r7bEPP5SPEEqgc818rQDCKV8vKSMKRVlnbz3BDJ8ruM58quv7CmW?=
 =?us-ascii?Q?YFy8wgyP5cDvseZ2fLdGPh+gLbC0R17wGgUeadzGE6rvBFghTa3jQ3dQ40jd?=
 =?us-ascii?Q?j7zgHyDrtgJx0CbNwt2kD4dbGyGZHWRpVjGroAfwAWxY80YUbzBi+bHVpfga?=
 =?us-ascii?Q?ggqtcEeCSUtQpvdXfAVDCGB5CJkaOMJ3ev6KRkpl94tf2xC9qNjcQt5EAGu0?=
 =?us-ascii?Q?0OE1Vq9S61P6jYLX7JbHapsCBInQCqvhjtIJl2CzYKp3Z3Ff9/gNvoQz+HG2?=
 =?us-ascii?Q?tSoBEQfmZx4gQet0snIylbBqe9Q3v7tgBuPSFqC14wP/zV1GRbO7yvXNxF1p?=
 =?us-ascii?Q?gOc+OuypwN2E8iJ2WtkHd+8H0dj0ZWTqxE34?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:48.5824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cc5fc9-4795-46f4-2563-08ddd347020f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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

This commit remove DIQ support because it has been
marked as DEPRECATED since 2022 in commit 5bdd3eb2

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +--
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 26 ++-----------
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
 .../amd/amdkfd/kfd_process_queue_manager.c    | 39 +------------------
 5 files changed, 7 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2d91027e2a74..58e47e14cf07 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -399,8 +399,7 @@ static void increment_queue_count(struct device_queue_manager *dqm,
 				  struct queue *q)
 {
 	dqm->active_queue_count++;
-	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		dqm->active_cp_queue_count++;
 
 	if (q->properties.is_gws) {
@@ -414,8 +413,7 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
 				  struct queue *q)
 {
 	dqm->active_queue_count--;
-	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		dqm->active_cp_queue_count--;
 
 	if (q->properties.is_gws) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index ebee37937783..f676b7419984 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 	int retval;
 	union PM4_MES_TYPE_3_HEADER nop;
 
-	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
+	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
 		return false;
 
 	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
@@ -61,14 +61,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 
 	kq->dev = dev;
 	kq->nop_packet = nop.u32all;
-	switch (type) {
-	case KFD_QUEUE_TYPE_DIQ:
-		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_DIQ];
-		break;
-	case KFD_QUEUE_TYPE_HIQ:
+	if (type == KFD_QUEUE_TYPE_HIQ)
 		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
-		break;
-	default:
+	else {
 		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
 		return false;
 	}
@@ -163,24 +158,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		kq->mqd_mgr->load_mqd(kq->mqd_mgr, kq->queue->mqd,
 				kq->queue->pipe, kq->queue->queue,
 				&kq->queue->properties, NULL);
-	} else {
-		/* allocate fence for DIQ */
-
-		retval = kfd_gtt_sa_allocate(dev, sizeof(uint32_t),
-						&kq->fence_mem_obj);
-
-		if (retval != 0)
-			goto err_alloc_fence;
-
-		kq->fence_kernel_address = kq->fence_mem_obj->cpu_ptr;
-		kq->fence_gpu_addr = kq->fence_mem_obj->gpu_addr;
 	}
 
 	print_queue(kq->queue);
 
 	return true;
-err_alloc_fence:
-	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd, kq->queue->mqd_mem_obj);
 err_allocate_mqd:
 	uninit_queue(kq->queue);
 err_init_queue:
@@ -210,8 +192,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
 					kq->queue->queue);
 		up_read(&kq->dev->adev->reset_domain->sem);
 	}
-	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
-		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
 
 	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd,
 				kq->queue->mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 505036968a77..3d2375817c3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -252,10 +252,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 			packet->bitfields2.queue_type =
 		queue_type__mes_map_queues__normal_latency_static_queue_vi;
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		packet->bitfields2.queue_type =
-			queue_type__mes_map_queues__debug_interface_queue_vi;
-		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		if (q->properties.sdma_engine_id < 2 &&
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index a1de5d7e173a..60086e7cc258 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -166,10 +166,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 			packet->bitfields2.queue_type =
 		queue_type__mes_map_queues__normal_latency_static_queue_vi;
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		packet->bitfields2.queue_type =
-			queue_type__mes_map_queues__debug_interface_queue_vi;
-		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c643e0ccec52..e36950e7e14f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -345,7 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	 * If we are just about to create DIQ, the is_debug flag is not set yet
 	 * Hence we also check the type as well
 	 */
-	if ((pdd->qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
+	if ((pdd->qpd.is_debug))
 		max_queues = dev->kfd->device_info.max_no_of_hqd/2;
 
 	if (pdd->qpd.queue_count >= max_queues)
@@ -426,22 +426,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 						    restore_mqd, restore_ctl_stack);
 		print_queue(q);
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_DIQ);
-		if (!kq) {
-			retval = -ENOMEM;
-			goto err_create_queue;
-		}
-		kq->queue->properties.queue_id = *qid;
-		pqn->kq = kq;
-		pqn->q = NULL;
-		retval = kfd_process_drain_interrupts(pdd);
-		if (retval)
-			break;
-
-		retval = dev->dqm->ops.create_kernel_queue(dev->dqm,
-							kq, &pdd->qpd);
-		break;
 	default:
 		WARN(1, "Invalid queue type %d", type);
 		retval = -EINVAL;
@@ -1121,32 +1105,13 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 				break;
 			default:
 				seq_printf(m,
-				"  Bad user queue type %d on device %x\n",
+				"  Qeueu node with bad user queue type %d on device %x\n",
 					   q->properties.type, q->device->id);
 				continue;
 			}
 			mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
 			size = mqd_mgr->mqd_stride(mqd_mgr,
 							&q->properties);
-		} else if (pqn->kq) {
-			q = pqn->kq->queue;
-			mqd_mgr = pqn->kq->mqd_mgr;
-			switch (q->properties.type) {
-			case KFD_QUEUE_TYPE_DIQ:
-				seq_printf(m, "  DIQ on device %x\n",
-					   pqn->kq->dev->id);
-				break;
-			default:
-				seq_printf(m,
-				"  Bad kernel queue type %d on device %x\n",
-					   q->properties.type,
-					   pqn->kq->dev->id);
-				continue;
-			}
-		} else {
-			seq_printf(m,
-		"  Weird: Queue node with neither kernel nor user queue\n");
-			continue;
 		}
 
 		for (xcc = 0; xcc < num_xccs; xcc++) {
-- 
2.47.1

