Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63155E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 20:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EAFF10F0D8;
	Fri, 13 Dec 2024 20:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OhPZxq4E";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE08C10F0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 20:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx62n6rt1sTP8RH0UB5aAwppYMgEScxs0zUzDckIl63r6wg+gE8MvxoQMd3csN/kZ+MdLMQGCtI7H0+Io7cV/488CkaBUVf2ljGYmW/wMAMOplkRLGav4vODA4szZ7u6bPBqZ6g8cvJpTGbBLxR8eybqCjKNtyhaCjRDFosUMt0QCUjolxybrc6zjNQ95LhVGsuFLhkLzVwKRbN5bMW7Y9hwOhOP/7GNascJcyoZgQ+EWkO4gpNSOwjK1EXwIbu72yJKRxt5UkwWgMzqVgGU5MxiPwAaZ0sSv3gx9zBY46/xM2Yw8VUfndCMj3gBCHY1pNupsGX/ESAD8GneWD0ynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ornrJmQ7oAe3P4qTKLJxhr4qkTMJU3kwGLiQo6O6kvs=;
 b=Ksdc7oO6s1Z2DWTE6BE6Kddz1NUnJTB5ZeYoduYGSQXrZflENaRE20c0G25xo29KCgROmoddqjNVw7T2rFt8acDLQs+3eFl8q8XppUWSuLkd6w16eaqe6yiDrnYeqHf6tab0xAbhO0E7MFjtxY11dxCz+vGDeL3r6hp6Rf4NOEGhNsq/tamFPtxySREtycVawQcIWDtU++VNqFNso/vxmrZICNE8tIixDCszthKH5LeiWFHBm/A2Y79nb/DfHeAypod5RA64BeR/zsDixPKmbHJyDwZQAztMoc3h8s5Hnskr+N+r/Ma3xliGk0/VnAzu7ie77DaH2EYGhhuoUOyZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ornrJmQ7oAe3P4qTKLJxhr4qkTMJU3kwGLiQo6O6kvs=;
 b=OhPZxq4EUG1GSAlxRBVTrzbk1/0XDZKgtM8onLvNulzoydq+T1bUkLu0idQxMjdcO5xlRZOTyXaPoY5/5jr7nJFN/Rcq8cmJQjE6HbPi/4AHkmbooaFSkeu2CAFK54y/0y5E/9VK80hxOKAVKgOMbyatRvT6yIHPni+s5sPf99U=
Received: from BN0PR04CA0182.namprd04.prod.outlook.com (2603:10b6:408:e9::7)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 20:34:07 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::87) by BN0PR04CA0182.outlook.office365.com
 (2603:10b6:408:e9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 20:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Fri, 13 Dec 2024 20:34:07 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 14:34:05 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <jay.cornwall@amd.com>, <Hawking.Zhang@amd.com>, <flora.cui@amd.com>, "Philip
 Yang" <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 4/6] drm/amdkfd: Queue interrupt work to different CPU
Date: Fri, 13 Dec 2024 15:33:29 -0500
Message-ID: <20241213203332.18165-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213203332.18165-1-Philip.Yang@amd.com>
References: <20241213203332.18165-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd79328-451e-4025-034d-08dd1bb57e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qZ5mwyOum0pkapqFColszGIE08az2jQfF4LAnz3Iynsb0P1XNH1VLAE7hKTu?=
 =?us-ascii?Q?YQx+qclPCniByO5xYXlcu9ZP6WeMYJwASeGqdXQKtJJYT6Toa16Y0EG+FiV/?=
 =?us-ascii?Q?jBdTu9eCGH5FAqfaeEY5aRLeEwJyPfwLDD0fhW+CiTboZaW3NSs417bv2GCv?=
 =?us-ascii?Q?q2tqcbTJK/gN6M/4JnO6elTsJdwrniDRq9HvmbEOL8uXgZdES8Sm3tdrGyMd?=
 =?us-ascii?Q?F5VhNpWxs5WOioahmp5mKirAlc2mEzHGC76PscTrBGrTSXy9wMBkm/ZqmIj5?=
 =?us-ascii?Q?3gFzd/+OvZEninQf+ZW5ZTvMThhRhWTtkw/Blq1PoTjx7gTEvp/pj6E6BG7t?=
 =?us-ascii?Q?R5RnvrUHW3Um4173qAT1MWgt9sFXF6LYediCKhxRHNgPKRkW5M/4f87jX1QA?=
 =?us-ascii?Q?o/lUBdcK+N8W5c0zT6oiMJy9KNZ4V4BD/GT3nlU28LfU+oeL55HGVDfU8VCF?=
 =?us-ascii?Q?VaMWhb4C6/JtZusIgDRzO1MuNzE0HLPpWorXSCci4G+jZ5FGOZ9tcNukz49y?=
 =?us-ascii?Q?d5r1TY7rGk1A6u0oCaIE+bMmQy6Uuy86MxfxwEPenn94dlO9PAm89dM6Uma7?=
 =?us-ascii?Q?Tv4Plo81jud8znJXaQvS7hgRWysPXj6Gy3sM7UE0C5lzkttzvZg3v//ib1di?=
 =?us-ascii?Q?xxMzBjZ+MAAXoX/euJLxKaCZLFo5DbXMEz2tXFhhP1CA922/riW/9tXyn+kd?=
 =?us-ascii?Q?lV7fWv5giMVVnqm6tg3wEdKw+V/omIhD5ia4uGXyN6rTiA0tJ49vH2lNHWyb?=
 =?us-ascii?Q?WoicvXeEdui9xch2uJxNz83hYi57JIggrabAj7ja5Oa6ua43tYSsaNbmvk93?=
 =?us-ascii?Q?/5EMKBLYxGuDiIR/C3CjHPGX1cx35RVRgZNr+DL6xGeCWk//X9SYAGBEf6kr?=
 =?us-ascii?Q?DGymjvEFTICg9igTOhlkRP45K2YpryIg5J+TxJ+rMoi3pzXCWOjC0q1xT6oH?=
 =?us-ascii?Q?uSwPCFODfzpXWvh6DC1xWSCmyTw1vhMhk8JNFHGz6Yw+QbD1GgY1JKyx0jfK?=
 =?us-ascii?Q?D5KRYvJGV2vt6RD6C7CcE56KPltusTtDpyDqaF0CIubYUWIU2zcJ6KrTLamI?=
 =?us-ascii?Q?NQaPmny7eHDuglSg1TDakfjV+7zqheSzxK1Z3lR4vNX0+SDlWe1jF2+dazz+?=
 =?us-ascii?Q?zFc3jXWqQO9EDh5OoWPUuKS946wrnz6NLZl/2gmsty8kmmwZCCElseYEydhI?=
 =?us-ascii?Q?rf5ZtGc/Mq4SkY2vR9SWaBB0joJTxBYoFhBJwQMp++bGQWSwC61AjZmH1WFv?=
 =?us-ascii?Q?a1XiRZGbyTQ+lSwRFxEE1F/xsgE4/iF/OoGVyZsc93vTwWEWOKUarmwQq5L/?=
 =?us-ascii?Q?oJubntCboOpi0eCTVAIwKkcOVI42KIihhF7wNGSPxMbO2cOReE/J0t+xbJYr?=
 =?us-ascii?Q?2axQDCsJ9ZFRYSUGbdg5QvzDrrbOyL0dTvLAe+DJERTaf0mK1zBhLN801hz6?=
 =?us-ascii?Q?4GKJRbX9b9bQzNZ7SeNCirqXRjeWxSZT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:34:07.3600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd79328-451e-4025-034d-08dd1bb57e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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

For CPX mode, each KFD node has interrupt worker to process ih_fifo to
send events to user space. Currently all interrupt workers of same adev
queue to same CPU, all workers execution are actually serialized and
this cause KFD ih_fifo overflow when CPU usage is high.

Use per-GPU unbounded highpri queue with number of workers equals to
number of partitions, let queue_work select the next CPU round robin
among the local CPUs of same NUMA.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 25 ++++++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 25 ++++++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  3 ++-
 3 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9b49563f2c42..a29374c86405 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -649,6 +649,14 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 	struct kfd_node *knode;
 	unsigned int i;
 
+	/*
+	 * flush_work ensures that there are no outstanding
+	 * work-queue items that will access interrupt_ring. New work items
+	 * can't be created because we stopped interrupt handling above.
+	 */
+	flush_workqueue(kfd->ih_wq);
+	destroy_workqueue(kfd->ih_wq);
+
 	for (i = 0; i < num_nodes; i++) {
 		knode = kfd->nodes[i];
 		device_queue_manager_uninit(knode->dqm);
@@ -1066,21 +1074,6 @@ static int kfd_resume(struct kfd_node *node)
 	return err;
 }
 
-static inline void kfd_queue_work(struct workqueue_struct *wq,
-				  struct work_struct *work)
-{
-	int cpu, new_cpu;
-
-	cpu = new_cpu = smp_processor_id();
-	do {
-		new_cpu = cpumask_next(new_cpu, cpu_online_mask) % nr_cpu_ids;
-		if (cpu_to_node(new_cpu) == numa_node_id())
-			break;
-	} while (cpu != new_cpu);
-
-	queue_work_on(new_cpu, wq, work);
-}
-
 /* This is called directly from KGD at ISR. */
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 {
@@ -1106,7 +1099,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 			    	patched_ihre, &is_patched)
 		    && enqueue_ih_ring_entry(node,
 			    	is_patched ? patched_ihre : ih_ring_entry)) {
-			kfd_queue_work(node->ih_wq, &node->interrupt_work);
+			queue_work(node->kfd->ih_wq, &node->interrupt_work);
 			spin_unlock_irqrestore(&node->interrupt_lock, flags);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 8e00800f3207..6beb786c582a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -62,11 +62,14 @@ int kfd_interrupt_init(struct kfd_node *node)
 		return r;
 	}
 
-	node->ih_wq = alloc_workqueue("KFD IH", WQ_HIGHPRI, 1);
-	if (unlikely(!node->ih_wq)) {
-		kfifo_free(&node->ih_fifo);
-		dev_err(node->adev->dev, "Failed to allocate KFD IH workqueue\n");
-		return -ENOMEM;
+	if (!node->kfd->ih_wq) {
+		node->kfd->ih_wq = alloc_workqueue("KFD IH", WQ_HIGHPRI | WQ_UNBOUND,
+						   node->kfd->num_nodes);
+		if (unlikely(!node->kfd->ih_wq)) {
+			kfifo_free(&node->ih_fifo);
+			dev_err(node->adev->dev, "Failed to allocate KFD IH workqueue\n");
+			return -ENOMEM;
+		}
 	}
 	spin_lock_init(&node->interrupt_lock);
 
@@ -96,16 +99,6 @@ void kfd_interrupt_exit(struct kfd_node *node)
 	spin_lock_irqsave(&node->interrupt_lock, flags);
 	node->interrupts_active = false;
 	spin_unlock_irqrestore(&node->interrupt_lock, flags);
-
-	/*
-	 * flush_work ensures that there are no outstanding
-	 * work-queue items that will access interrupt_ring. New work items
-	 * can't be created because we stopped interrupt handling above.
-	 */
-	flush_workqueue(node->ih_wq);
-
-	destroy_workqueue(node->ih_wq);
-
 	kfifo_free(&node->ih_fifo);
 }
 
@@ -155,7 +148,7 @@ static void interrupt_wq(struct work_struct *work)
 			/* If we spent more than a second processing signals,
 			 * reschedule the worker to avoid soft-lockup warnings
 			 */
-			queue_work(dev->ih_wq, &dev->interrupt_work);
+			queue_work(dev->kfd->ih_wq, &dev->interrupt_work);
 			break;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e529fdc1b422..c32b255c0eb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -274,7 +274,6 @@ struct kfd_node {
 
 	/* Interrupts */
 	struct kfifo ih_fifo;
-	struct workqueue_struct *ih_wq;
 	struct work_struct interrupt_work;
 	spinlock_t interrupt_lock;
 
@@ -367,6 +366,8 @@ struct kfd_dev {
 	struct kfd_node *nodes[MAX_KFD_NODES];
 	unsigned int num_nodes;
 
+	struct workqueue_struct *ih_wq;
+
 	/* Kernel doorbells for KFD device */
 	struct amdgpu_bo *doorbells;
 
-- 
2.47.1

