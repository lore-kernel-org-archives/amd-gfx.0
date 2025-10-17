Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE081CCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 487A710EB6C;
	Fri, 17 Oct 2025 08:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QLS/NCze";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3D0E10EB6D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwNcKTouoHzCgnxHh+CAFJdv6rFL8rHMv94dLTTVZx8yyQF2RQ2fOyjcGYmuv3bAvh+WpSwgoozftNNuIG7ZfsUdwbofhDi1GsrCRyMA6vmpN5iWSD9n/gzN9zZ/qLlyPlE8EmX35Jp2EwNV5tAHP+N4DqibzGxq4yQAxeDPfwmDS24yrDQe71zfPwbM2calk8oO4MdgYmGrrfQeuAf11vMZZ+cGDNI3clX756ZoNKS8vC7C26MnvAsPBOXKq7jjjxVKNUG2URqoaypgGTSmxrWGZaL5RAm/Tv0SitbNNP5/PjI3LfF3NSxPYebnkTeNaQLjfUMFWPVv5t39WkEa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnOLtOzncWmzzTudHfuFLkQvHwUNXc5Jri9EZ7zkp68=;
 b=JGiaXOB1ypJ6rdsW1+vdwG6x6tMHCXIPekgCsSQOLqVTWtOlQ852mgyul7a0OB8zwor8p/F0lmh3Rp3rNbbR24jDr6Gu+Y0bMArkX75n2ztbZus1p6oetTgQ0g5g4qjoMG/e1AYCqhh7SPKzILg//hL6fZplatSPgsjhPey0L4I3yEWNq5ZPo8tCfq26NGyDSjO9uEAxmKQmkncqkU8NjduDZoGpUCQl8LOop0ulJqIb1tSAF/5q0eAoqW7TXn5q2f1uvEbbdh4M/zzPYLCVkCXsgP3GKeJBnobVcnnE9znKImNegJCeKOTYeIeyPGQHgOKcwf/P89h8FU0OaL+UwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnOLtOzncWmzzTudHfuFLkQvHwUNXc5Jri9EZ7zkp68=;
 b=QLS/NCzeWUJ2ocwunGmQ+fZ/3/f3zOtSGr92SvF2lqkYrKAUE/n+KzFafpUQvTNQYXuPgr8S2voifRMGXaRRXAdXPaA0yDCAir3DErscIqgXCcz1gK97Y9hmLwRondPvIx3rkZQCIWlHN06TKh0MK+4op8PKZ11nIu50s+Tmuaw=
Received: from DM6PR01CA0009.prod.exchangelabs.com (2603:10b6:5:296::14) by
 MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 08:43:26 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::9e) by DM6PR01CA0009.outlook.office365.com
 (2603:10b6:5:296::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 08:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:26 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:23 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 10/18] amdkfd: remove DIQ support
Date: Fri, 17 Oct 2025 16:42:14 +0800
Message-ID: <20251017084222.54721-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5e38f9-3147-4b7a-7f8b-08de0d593d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NT7HNZP2bf0TbkENoHcHGnAHGbirps+6YIINuLmWQRomFPzpRUKCuYue5Qb1?=
 =?us-ascii?Q?1ZSRcFO6mcnyVecfkDWUD9cb0bZfOs32+SVxz9OSMG2LfyDA3BiCvQn1jSHQ?=
 =?us-ascii?Q?BvJwzH+e3tga9gNbZg6S9xOdQixLCzWh1U3B1KJqv/JcaiKvhIjbqZ6OzTOu?=
 =?us-ascii?Q?pHCV/BXpP+t45YH+9AvmUQDU0kd0hgjJGRI46cFEG65TpYvKOpQI0g27wwns?=
 =?us-ascii?Q?Fv/k6DBlnQM5HECC9s+mDL1893pl3nlKIeSXoMDE0lBjetJVOf/UQ/WeLdYc?=
 =?us-ascii?Q?tjZHo9dN76kaDTGtSgBNi2gqs+1nPHvums6F3WEbZJ9QwHTEjnyYS5ZvR47J?=
 =?us-ascii?Q?uXS1Oa5Gfkgk/xqWYBLLqY8RNTxlX+3SyHN9Lt2cHM86u6kL9CDe/RB4gKAB?=
 =?us-ascii?Q?qz4gimIwSFBWQhZaNiVKAYpvN8j6qCgr9JUkSKF98DpDZw/k0/nYcMdoz6ZM?=
 =?us-ascii?Q?SrPGyPZvalSPU/bq67GAKWZDPdkgG+ZOfsH1CJhbHpasgUOgJT/EVrK1AziX?=
 =?us-ascii?Q?ndQmbrARzM+wkqUqeU8Q9BecPB6yMvOMNd+MwlVGKqwplI2holOc3PRxuc+a?=
 =?us-ascii?Q?JZSG9ERB/XAfXp4gHUYbxaEd42mYSUdAmpiZ2S7+j+lRbuVz8gljbRLQ9xL9?=
 =?us-ascii?Q?DHuaVmAuuBUiXWhSwpNURZKSdRhoanqLY2lZH4xLvicbAulcF8YQP381xjCn?=
 =?us-ascii?Q?lcr9A/lnGsg+KsiPMP5I8LenQaufzdo3gYbVpJ74ZJdWuNmYnLY5fvy6/ktB?=
 =?us-ascii?Q?+9N6CblzwN/+ZiipmKHruXnFQFNFc9hkNCo7xnlhJesp2chZ02oKzWrCAzog?=
 =?us-ascii?Q?gIUhvN+cwW9WycAIQJYbIMm6PUzquDv3i1gHM1vuHlSG0nG8TTiecl83Bhgt?=
 =?us-ascii?Q?9qFXhFRYf5gmp5CaXVC34eRuLpwswt1Gw6OqIqATF1GNZL3LehgXMg2tm8Fz?=
 =?us-ascii?Q?qQRgYzWaWYHUNhmY56ZyRaqZSV1xEfZAO6gVlIRXg9MYmMayF+XSpDXQoQnh?=
 =?us-ascii?Q?IOqEmoGTW6m+w5dOUUWo6IPruSGc9zhfVOCJs0OhYxtLZav3Spqw9TdyDYIY?=
 =?us-ascii?Q?kNnvTW/bazPHaOl5J3ncy06ygu8t7TeVW3l8e+41QrW2PQdFFrgHAOh0n3vq?=
 =?us-ascii?Q?YoJysZxODVbNeAeqaVIRDfZ1iCCgzYefPZf7ITFeMp2Ljwr8N6UcpMC5GBry?=
 =?us-ascii?Q?ssRHgclUIuCPGpeL5BFklVQXLIKUWQWDZ7YE2/Vy1wQ8e7S0Aoowo79c+78p?=
 =?us-ascii?Q?6NQYqB4JUtJI1mt+1MkKWgs0c8cUysQFWz/P0jYG4D0Ho9flbhIu4Gu2uIvH?=
 =?us-ascii?Q?ijRIMkVnt+JJ8vDln4pU6ot/5D6vwKO9RmnLQGfdXajScpTFrXXX6eq3NN0c?=
 =?us-ascii?Q?xg1D/YtUVVa7FSfP0ylLDxCXyjgsQb6kwMbQZ3dPoDRlwlKl2de5zVG1gOvx?=
 =?us-ascii?Q?AqxGaphsivX1lYYupUiLiof9WCCoJrxynhFn1fOFBrC4CGwVLRthe2ddvTjU?=
 =?us-ascii?Q?08KxHkAzDizgFdiloQzbjfixlU2Ug8vRQ/iY+k1Xqt77pTRqrcVa3v6X98B4?=
 =?us-ascii?Q?zR/kVRwBTrWNAQh41VU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:26.1436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5e38f9-3147-4b7a-7f8b-08de0d593d22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
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
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 29 +-------------
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 .../amd/amdkfd/kfd_process_queue_manager.c    | 39 +------------------
 6 files changed, 5 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6c5c7c1bf5ed..ac6052d7a4cb 100644
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
index 9de658119cd9..71c0cefb87ea 100644
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

