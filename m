Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED87ECCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8199810E6E0;
	Wed, 22 Oct 2025 07:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0LokxYMy";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 748D710E6DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMzD2cfK5rt1n8fk9U6yqwNbmw08gPHFy7MLTm/qmh+CMxzkLZtZaTIs3dmjKpm8gI5eXD6nRI9Yfb31QGWaQ6q6sHARAfUpzMFlzqZELtbIDLMiYvHZd5iNYQ1dUFSHdu/oNywtVJWac4UH4BqQ3hB5SqMD7D8lAZlCFIzYmphVoG26qb/A4nsX9whs+uUePsQD7HakTwADWat/hC+imXeP1JkL97N6wOwQhMdxyk3N7SqVnnotOwlm4c0nd2Vw+L6C5zmAwJspgGqm1sI8/ypaSmaOaQTrDzH+aJm5rdE2lPFr1zj0FWeTdCzLpsJ/MygmmR3CsykhJU6z4eiCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=670vEX4caph5o7mX9GYwkDCXQCxxj9jMdDICGt7ASdw=;
 b=p6PLXwmfoCmgcTN0KDZ2arpl73c1s5ENiXBDFEkMSFCwdsX1CO4dbioqkwmIB9oTo1Ucq/ZJjRYkTQ6r8r6v00sMlwmHqpX1+WBr8XhHg6enA6wRoE7O8LbKs4YbtAAdw/WQiNmSTG8RgTVcSoRJiX53zktpyVRoCai01AXJ0ZZRXV3eLBvO0uKgZk6w+vRrbm8LRetTfgTip9GnAj+ijU4Ue3IXSRwJ5hqg0+KtUwl027hGNsvG7jZzsAobG1BenQ4+jcwYSmJ2d753yGkxxl8A568jGP7NCfeiN0dsCttoRSzX3q7Ni617zWUuRIIs8zXIm0pCaORfuiJSpNQR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=670vEX4caph5o7mX9GYwkDCXQCxxj9jMdDICGt7ASdw=;
 b=0LokxYMy1TrAWuy31jS+5LHOU5QaGXVwpiuKvL1Lz77m2ONgRQikLunfL6PbVRxU47n1y35eaK7KpW8hj0rYKuDQmfK6GgztQgWzHXrkEJQElQbjIyrDdqfK2tvEjKH220+Am11PVS3LJ8OgummzE12YrlTLxnmJkUPtStoGnGk=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:31:27 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::4c) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:26 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:24 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 10/18] amdkfd: remove DIQ support
Date: Wed, 22 Oct 2025 15:30:35 +0800
Message-ID: <20251022073043.13009-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4a53aa-3e61-41f7-03ff-08de113d02a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z572losZkVIzV2ySrOfSQZrrc34YqF5JUw8HTc6BRNVNofyrWy8jgI+kGNZx?=
 =?us-ascii?Q?eNAwX34Po/0oetZP0XqpRkqO06+da/Fm7mVd2jKLdBQoWBbNDUve1Ws4COrb?=
 =?us-ascii?Q?vTTAYawGjtmwJr+s/Qu8Ekv1pe3mR/S7RMRwIb0hnokg6NHUZV9oYgJabktO?=
 =?us-ascii?Q?pKxSmB7AWI+Kp8ihR+c0bxiUx1G9jlGOgROcycXnseupIypiOmD4rhwlaDk8?=
 =?us-ascii?Q?2MiWft3v/2YPLTEmkLNCQPkaL5syTzcwyQiVuZabyhvQBobwc3DYEyFFPDA/?=
 =?us-ascii?Q?75d0mAkgHs7x7ohCMJQmhDOYCn05WJu79gc3JAqXikWnHOTMfkMGsvQIUE76?=
 =?us-ascii?Q?0LhUHulOaxXX959Y3wI2/3hvQcylF82HQpFLbhiNwo4c5jHr9ilNktm726DV?=
 =?us-ascii?Q?HFIboswBqUPGj1HFU2KDrUlwWOe1KXKJ6FxaBDg3FUXOtZj8/eP1NgIZgCxU?=
 =?us-ascii?Q?gdU3Ge6mWMKNTAT6gc13hXZ9iuFD9LsGI94oxWenRB7WTKc/8FXzdEkqTT3D?=
 =?us-ascii?Q?guFtaJ5l9HR0N5ZcElc0ozB6K4n0U3RQaGkcYk8Ao+dapQ3z5aFog1DoFZsE?=
 =?us-ascii?Q?O1cTl3q1YqV9kZ1P872pcp1DW65yyW+kTwl2bUUUcMaE/z/XtuEyarwxxAlW?=
 =?us-ascii?Q?xMN9yYIomM29gIRWj4ytU52yIQuVyUBSugBYxsIctHgV+U54j86SqljDixif?=
 =?us-ascii?Q?AArqVUpa0j4vUCZRvgwSIdLhQgtA1XU3JBJqmDtCktcJ8W7wQ52EfQ51+nD7?=
 =?us-ascii?Q?8dm/mktCtvXVVBARoCYQeF6PB9rcQ8H6pVyZix+Wa2XjnujVy/xkz0qRo6xp?=
 =?us-ascii?Q?8zYoTGf0/euIXSb4OBE4UQ6ikprm9ONZKCttwehKixqFRknqAC5rTstCPDnn?=
 =?us-ascii?Q?Pa7ysPlefRk4p2j/9r6YY3Y5Nu0SWByCLMCyj8i98IkFF6TXG9WB98bCrOtm?=
 =?us-ascii?Q?VoZp0VyAVQzqHIjcHTDrI28aqHQgD7rrdZN0fvUrKgfKalR+6ba6ENgYsl3f?=
 =?us-ascii?Q?d/8LOiW6H9ARCg9hTH9mrhjVv3nBnxy0EgqX9Ato95+a9fHvII5eq2aAO7lr?=
 =?us-ascii?Q?t1mPKdI+0sDq3r+45s+mVQ1BAS65Q+4vIsy4RCpTsDk47JvfNRBaEhTbZuCb?=
 =?us-ascii?Q?0oOtSq9pbCUNNxN1EZXnAeEk/ynaxDCTI2GKOGdaYw8l5Zq0r5LCxQQKdpy2?=
 =?us-ascii?Q?Nkrw/nQvxjW0F258qMND+4P8jAfCZoRtgGYWEaTgvcX2OZ9wnXOBypFQOEJu?=
 =?us-ascii?Q?LUkd1T9LQwLQvy9Wc/m4XxTIdQ3fLbigwm/ecNAZkDp9wuar/OkWQ46DiBaO?=
 =?us-ascii?Q?OOY4H7urPRS6BppprkBxbWThFjUxn7nXBv6o5idOJ4K1bEwokZ8ZKOcxkkb0?=
 =?us-ascii?Q?EOaXYAZNZgYJJELKqEI/vzxQ6HVi9Vh5RconbkZTe97+VJ1ZxAc+KNXUoCE1?=
 =?us-ascii?Q?qElCuq7Alov+bwLdqXMYfH79cT50Xcnyz5gKdZ4j2ufHCOuQb8fHd3bw8C4h?=
 =?us-ascii?Q?TndOgqnhZq9mu9po37eOO/BLOFW5V7M+0M8ET92q4l8ku9gRIEWNnpCq2b2P?=
 =?us-ascii?Q?ssPjo4Y9ryUAn6O+r58=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:26.6626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4a53aa-3e61-41f7-03ff-08de113d02a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
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

