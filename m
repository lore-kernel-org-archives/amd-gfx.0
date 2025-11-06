Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9868CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D9E10E80C;
	Thu,  6 Nov 2025 06:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YGA3vvlP";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3462810E80A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogkUaefWGQ2fzXZRBMf/c7sgsG/WagLVHOBnn2Z4yEy2gvFqZ7YL6X3cTzTNoYh7oNKPdSFpEW82bm3OZIhBIKIxGDJ/ROJlPuh6tyKcqDuBUeVSMkUhgc6ti9NiGiLf0ADC2uhS9DVOzzEa74ZotPbV5WfzyINGPce8QSfOIqekIEqKAjc5YjUEL4/OCrq2y5EkM3kJoU8l3CoBzq04EhJOvZStfeILR1mUoW/p0/xPrgHxVhu9H1biIa/tLKXqwUIduPYbl0SViuTFBj4QUP5RBhvaE3PQdks7hux64DaBG7eWnlfE6lqtjCxZ+xNhn0Jn4nef7SC0n6MFIADI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=670vEX4caph5o7mX9GYwkDCXQCxxj9jMdDICGt7ASdw=;
 b=T78Yu6S+tLSBDTGxZV9pn28vtPW6ENU/Qz7+92NzNM3XXmeYSYbiZmAIrqOkMSM26xo6vkYLuV28NwRZc+wO6nh10OfZxFLNsehysFdq1mV0eIWgvy6DutbvdqYmFcmT2GgTrHsGuZfw54xJqX+EXOBACyyYmBfIXufgVPLj0+15Ij/uYHmHLW9sMXoQo4xmb3+6aS5FAPJVvrma4FjE7+riqn42LgZAdSfnvMJ3GuNa38IQpe66+0pBu3PQX9pG+XLm9iw5k8Uuoo2yZxKaSmoh+ItMUlcURwdxRWEMOuntlvg/xj2hMu5Pc4PtPpnSsABf0IdXlq+V7IqkfzO2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=670vEX4caph5o7mX9GYwkDCXQCxxj9jMdDICGt7ASdw=;
 b=YGA3vvlPt6xGX6uvj8TChBeW86ssNy+MatNwwHIjKNjBCODNqTQGqEh+9c0Gtr6anHKly5cRZKk/fcaj29RzvlCgjKQAee2UJjz2/SDiBF5DhLGQgqwvK4shfqFmocexTAOrtGb/JlkwWNcpZQg5xcHsZ0Ol/St2ZYH+4/iTlQE=
Received: from MW4PR03CA0199.namprd03.prod.outlook.com (2603:10b6:303:b8::24)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 06:08:22 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::af) by MW4PR03CA0199.outlook.office365.com
 (2603:10b6:303:b8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 06:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:22 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:20 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 10/18] amdkfd: remove DIQ support
Date: Thu, 6 Nov 2025 14:07:31 +0800
Message-ID: <20251106060739.2281-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cb1900-560a-4793-3db9-08de1cfae409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Yh8sKNUsPoUk0y+DWGfuNZ/aMo8KYXY0UgDDzyAA92e96jsuHgXhCgS997/?=
 =?us-ascii?Q?UUiMe5nbPLW5lYioKZyOw7tDz229x9EaY7AzpuVKDTqVQJxk08LXOWh5cnkh?=
 =?us-ascii?Q?dn3ia7SXBPDojQftLtZvzu+0IsylSykmM18tPZIuipfinozjzvO6jGMc66ap?=
 =?us-ascii?Q?iTbxp5LtymDqEoXVLmFcDtPTRAGVOAr3Vd6Pb5am8Kbp0bVOhltSjHtOe1GM?=
 =?us-ascii?Q?LSvrr7qW708GkUkI6kA8H6Nmqx5k0N8QdvoDyBrUwISLg+rF/Omi6g+5yRnA?=
 =?us-ascii?Q?PDg1C7TBKUA8cHfCTWb+0x6z3VW49+V2sM0qvKkwaukYivVeQ42/3gsyJyEQ?=
 =?us-ascii?Q?eWSL+2At6/MZiFx3UyxeImwfRBQHGTu5EcNH2fHPfgzyJyPE3kjS7Q6at0Nc?=
 =?us-ascii?Q?SwjFYfeceCyQrC7iNdu+bwrLg/wGATMTjX3NwbD7JpfhoHc3sqHXfLxyeEQL?=
 =?us-ascii?Q?AbqjXuJN6SHSZUipF6gjhsMPZlHiXUlKpSapKxw+1hwbMThVJdzFhABME19l?=
 =?us-ascii?Q?MRZKRKPFuNKZpK9ZaUZOvl/TlFLiO1U1dWCvuL9Vc9nJ6QKLQfzGJcU+9XES?=
 =?us-ascii?Q?CXUJHr7KTkERzl+DMNiZKYZIcfi2kfLY0YLaa6ZRqHBtGBhVhvYp2pwgutoK?=
 =?us-ascii?Q?31pcX5/FgnM3txl9vDLFVtqIYTZdCGBlO3vGa7IyfXMfLKheesNuUzWyvWcs?=
 =?us-ascii?Q?FYp/dtT74+MObYW7DBiOj05WglENM7VM/ITxuVQzql5Usst12WP7g4zLlWR8?=
 =?us-ascii?Q?cGUkhjR5YKQHFogtb67Aoq+mD/ewoEkx1s5dYDqv5BiBpEycBfy1yPlBBb05?=
 =?us-ascii?Q?nW/6f0qXFkHcTlNaFwemKdPF/9wh8/YozpVecl6mZ++6MTOcFilZC7Cp3j2O?=
 =?us-ascii?Q?ATyhWCDS45M3SNjhrZPGkhe7VTgF47FaOHFK5dE7H4pRTQrFJpvENc2ONgVJ?=
 =?us-ascii?Q?stmPT2s0kIRbKKc1jY/g5pYmRqGhRD9rlSs4euwSEzDEcL0F0VyVwLR+LkKe?=
 =?us-ascii?Q?rPU0CE0LHr2OVR/ucktOA/jNVZL5pwoH+pTl6dLJOJRp3HvE/ONJzRFOCVFk?=
 =?us-ascii?Q?HrowXQPfC2jNZuPvs7nBk3NaGBxncxZWa9wRZzoCI+FKdwcbNrr72X4rHFDh?=
 =?us-ascii?Q?XD0q3/Sm2QSjWtj/8woEUn+wF5AbvfvnoV9i0SAZ4P7ync+Y75Cyg4LzW0/i?=
 =?us-ascii?Q?Jy2dMz34OFCsFPK0CvFRPCB3cQwh/Bc15T1wRnEap9x5HyuFQXhDIHbSpSnO?=
 =?us-ascii?Q?SQQqF2Q+1G79yhDfhbvUP7Wic2Te3RgFmgrJceJGkDQoUU7lih/5rp4aojws?=
 =?us-ascii?Q?gXJvRLcl8XeXM6e1oMJQJApAfssaYvhGJ4LiPxz7ArQV68Kegejfwsw0A1o4?=
 =?us-ascii?Q?CTqrhpjGBrFHaz9BU3Go6hb+ryTfRiny+842AP4b3v/oQSj+9DQoegBAQvKG?=
 =?us-ascii?Q?IR6wO5KzPXrRs0B3WToDR/kXMWrtA1fnTor5CKis2lrHog8ZBUhGOt7AqKun?=
 =?us-ascii?Q?UIbQb/fyWvZa/LxgjGFM/XprBrp7FFJ8lvN3Ht9fetz2qXQmOz0uy+Vxt7BG?=
 =?us-ascii?Q?ComW7xB+C+cyxrio4Ps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:22.5070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cb1900-560a-4793-3db9-08de1cfae409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
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
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +--
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 29 +-------------
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 .../amd/amdkfd/kfd_process_queue_manager.c    | 39 +------------------
 6 files changed, 5 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6e7bc983fc0b..9d606c4cf403 100644
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
index fb3129883a4c..7ce4531ec3bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -57,19 +57,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 
 	kq->dev = dev;
 	kq->nop_packet = nop.u32all;
-	switch (type) {
-	case KFD_QUEUE_TYPE_DIQ:
-		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_DIQ];
-		break;
-	case KFD_QUEUE_TYPE_HIQ:
-		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
-		break;
-	default:
-		WARN(1, "Invalid queue type %d\n", type);
-		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
-		return false;
-	}
-
+	kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 	if (!kq->mqd_mgr)
 		return false;
 
@@ -159,24 +147,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
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
@@ -206,8 +181,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 30b0b45bcc8d..8c9d02d9d437 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -434,7 +434,6 @@ enum kfd_queue_type  {
 	KFD_QUEUE_TYPE_COMPUTE,
 	KFD_QUEUE_TYPE_SDMA,
 	KFD_QUEUE_TYPE_HIQ,
-	KFD_QUEUE_TYPE_DIQ,
 	KFD_QUEUE_TYPE_SDMA_XGMI,
 	KFD_QUEUE_TYPE_SDMA_BY_ENG_ID
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 7fbb5c274ccc..8ddc33abf230 100644
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
@@ -1131,32 +1115,13 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
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
2.51.0

