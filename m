Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F030BCAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E51010E57C;
	Tue, 23 Sep 2025 07:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="18O0AbC4";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9AAC10E57C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YW7hLbUwjHhLDopip6wWQ9GDxz9k69e3s8Ocu5rtkj1d2uY6bWxIrCEYk90kAc3JxND+PFqI5ldx5FRjV4qZTk0p6wu6BS9MZTVhDRMqH+Eo7kzhJcYwsl5/X0Lfez3Nfdw4zv8IsFFHIj3Ouw66tyKDUki8Gu09hvQKtiRpEeEQ4P95KGPTVZNnrlNVsB/klIcAMiqABPYympokCl0QebH3wV8b5l61xsKngXBQfF8EzHMd938FsQC1yJLpwHnHOxpKVmzTZOYMRJ9abeflsRfQ76wp1C3PU+9yQfTV2DmOgyuPlT7fP5Z1IfNhjcwAFn1ivU5Oaw8MAG/nIWvJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezyUgL00CWxC5HIrKhNs2E01Jsi2m/wMNqqQAyTCkVI=;
 b=WQ8JTT345r8fda8SbJMSA6ilwCvLzZ2MfhSPYXiWqmdZxcycpQy5O1NaSrLMVHrjTcurxcJUvc2Xy4JZDx2cxgivXeJVm7mu9BJmNq2R2kf8ZIXCZSqRZchj1Va8p2LMnwycviIod/A5RrPvy8lMlxXZV2tiC1/Shivuy+2oItUQ3YT1zLNQlAmyvAa105Ld81jrbmfnj+M1fV4FXU6qURppt3n9unJsy/zCUsslIntBq9M56EdMSYQljgUyNjwJ1K+bAiT0lX339qxNbN2GUhrfDNsDU71RAm0TOCkSoql+isz/82U1EF/UKr87hx0W5IwDhd7RMe02fHnMAdg2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezyUgL00CWxC5HIrKhNs2E01Jsi2m/wMNqqQAyTCkVI=;
 b=18O0AbC49q7AOnFF7jnBZscE5dDVem2t4TtE0xWNopgD5TLYgjGPpgWNE19GboszUhSgbHssK7J1R/aCX414YUAFAE2d8rLq8JUuvH+GE/TYh8JQfcBRoOuDI3+MUwtK+XdayVVaKl+D99Kgt4eYYa7hHLTDaVpt3D0+GFFCysY=
Received: from SJ0PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:33f::16)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 07:26:52 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::96) by SJ0PR05CA0041.outlook.office365.com
 (2603:10b6:a03:33f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.18 via Frontend Transport; Tue,
 23 Sep 2025 07:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:52 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:47 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 10/18] amdkfd: remove DIQ support
Date: Tue, 23 Sep 2025 15:26:00 +0800
Message-ID: <20250923072608.252345-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 6660edac-4cc0-4769-5524-08ddfa729104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zPC/hZselPkrtOMhcbPCUQH/jSsvQiqUFhpSD1wBKHbnB4jDXljVvuA5iRbH?=
 =?us-ascii?Q?eO3RHZtTZyPCtxpqZ/c/cn1RTY+Q6logEuanKc61ItDjVcBG4Mt64NbuEmHr?=
 =?us-ascii?Q?78x7m0hkS5+68yLStXNA9KQdWWRMIbs05FHgUUckaksZB2fj3GpXcvL1EkH7?=
 =?us-ascii?Q?iXLi5Q6W17zcpog0cIF2EzPeDd1BtZOSbwdlAPaxsqqNmq/m9yyYkc21iN7d?=
 =?us-ascii?Q?BPaTgXmZS67rOBL9ThpdLRS7kEO3m1xkU3YVLKcxDueugbG7yHHkB4cv2m1f?=
 =?us-ascii?Q?bhlsXL0zpmKzHJ7r0qmzvRjnLJ4/4qtGUd7NNclvCrBl65fW5vHWeb0rPOYq?=
 =?us-ascii?Q?ihSNtNHoHnN00oo8mkndfS4fllwd+XAilz4IrdmFxfpqoKKIvlDPmVpvHyLs?=
 =?us-ascii?Q?c2pvPdrpct3b5hwZyZrsK/qCdWyE5yEnKHaWXmrLRP9f4FYyLG+7dGi+335e?=
 =?us-ascii?Q?oUl2xuVmy5IjWoAM8iZ8QLKo5VqF7eLeOQqaL0H7s63eZVOdBl5QB2gLcMpM?=
 =?us-ascii?Q?urXjO3xuo067piQwPl7K3NLotJYnOMx8A2m3k5eGN8SGSWFHd3uXpE9z400Y?=
 =?us-ascii?Q?KPK+BOR/vQh58GWq1jb0fn//U8drHtX8JdMGXwaQ582LaDYkeB3RQ3qnZywH?=
 =?us-ascii?Q?72zowruW/O+XYUQzwrVO5IX3ti+gti2NZD/iO7K0BIt6R3mE7uowVtX5Y40Y?=
 =?us-ascii?Q?8U7mrSH3NogU9MxmStooRWnt7iqnY2vVHf5Mu6D3jht9Wsk18k9gYeHCPItz?=
 =?us-ascii?Q?4OL8hpCo1sg69E0Vb9h9wvyVfeJegoWO7nDXs3Y3t+aWf8LcrJTXlJ87IGar?=
 =?us-ascii?Q?2P8RSp1IjeRt1S1KpnaHEYkAtGI340+zkvm7qaE+vhX2F5bDm0bGKi748Sem?=
 =?us-ascii?Q?FBYwt6F06ShNF3/Gz/gI3fSBG0O0GktT6QotEMv7CLqhITMexmkTn7EyqfeJ?=
 =?us-ascii?Q?DurTeu8pUgShIi/zuGucsvuE/2SgJa9mHCu5xCrM/EvwXLyefio0FihG1lIO?=
 =?us-ascii?Q?6hOejy5ndhK2I4ix0UmeTAC5cktvwjc4r5s1kMCfsCJFBeh2wQZaVBlZzCFC?=
 =?us-ascii?Q?0y2upFvZ6haoOr3MwvZ6NhDCeOU0Yuxq8gJoxgE/8IHXYPOFGc6h3dIKVmb5?=
 =?us-ascii?Q?+8UICK9TX2ao76lnfv3LCXMzLQOdjyuCtos9F84ZsUYCqNFvlCTDfZ8g+ZQ2?=
 =?us-ascii?Q?OYifDlbcLa4+ugcXspPJ421pjfj0uvDEu5bK5YhKKHZd/BirRtZ6goE0aIoL?=
 =?us-ascii?Q?lkKk3mte5vzV+XiniaUD1/7WiIu6vVpIsziuwD41W4AjfbsuLUyWFumoL5B6?=
 =?us-ascii?Q?ABta+x/4P8BRwxcObqSHpr6U1WeTwzY7R4Q901p9p3eOVb2wdrZxd+eZnJyb?=
 =?us-ascii?Q?XTIlfdNplmBR9/CZzaXNLdjv0WykI+MCp5kNIiu2ilpYjdzJQJ1FuWUzZCPQ?=
 =?us-ascii?Q?Sp22v91UzfB4q9/HHfDnxL3UOR0GceNePnR8QnNcEhHDwTwcyRKAyZD6nqAr?=
 =?us-ascii?Q?hZ8YCf3GzjCxbeU+GCwZHw7cobBi2SRDh80j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:52.1333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6660edac-4cc0-4769-5524-08ddfa729104
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
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
 6 files changed, 6 insertions(+), 77 deletions(-)

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
index 2b0a830f5b29..4c7ab7a711be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 	int retval;
 	union PM4_MES_TYPE_3_HEADER nop;
 
-	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
+	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
 		return false;
 
 	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
@@ -61,17 +61,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 
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
-		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
-		return false;
-	}
+	kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
 
 	if (!kq->mqd_mgr)
 		return false;
@@ -162,24 +152,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
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
@@ -209,8 +186,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
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
index d140463e221b..a2f8b1c24fc3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -425,7 +425,6 @@ enum kfd_queue_type  {
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

