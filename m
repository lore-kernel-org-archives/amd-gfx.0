Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE30AE77183
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 20:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2C910E473;
	Fri, 13 Dec 2024 20:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pX1XpIwv";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1632110E1C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 20:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVKTrgF5nR/jMI2uUYY4pWyxtlmq7a5GlDMelRAjE6jba++9yXIwFbrgH3WMU3wuqiXaTlbhc8WWPobodVWrGFUEaCtA44nzVh67ZB08DgYFKCzBU4FWj1rvGYqZnvhVWsnE9gO40cyCqlwOja04ZNMOiJHBz6jQfI/97/3B4on6n5OokEpuUkDIv79pItwooVJJ6W9oBw4YOC4SRhF/b6RJE4PUS+v9gYN+XPjweaRNN9ix3t/yxNRg+2eb8PhKO48RCn+3lwV3JUIw1HO04xt/ITO2ulV/udMbsAiIyoKFuqMjkMHRVBIh/N5HJ+nfs7pMIp6V8J6oD86OeTvFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G7+2Up/3nTiLgLLEk9OLPnJC+PviPGuU0tkVV4SPu0=;
 b=L0/Dpn8Tgw6WAlgLcUFH/lu+AoLdvkPE71sji44aKzMfXucAjXTqa1ReHPv34QkPDQ3nIfGlFSKphefEsmf+i1Dg7CHb+orf3BNUb5ea2geE7FaG/BggalWEGIZsSrHI87KlBuZE6OF5j1NZN3jZ8XjFwUX8XUOfA1P/xeyUJtZ1wJEavRNrZ3eB9kLX+rrkgvcZn4fc35vlQIGmkVKLKtBS+esjrEqJk9jvVyNVkCk1l24SUegZIjJFGLTBOKeVMGUGUMhLA9XDfwGjG7PqoKpwqYgIe0G5O55kT63PN4hElrMwxUzbjEZp/nZvtrEmfwZu7ghsULuSXT60h+Gf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G7+2Up/3nTiLgLLEk9OLPnJC+PviPGuU0tkVV4SPu0=;
 b=pX1XpIwveHKKx5QrYGf7QcgnosRg3+lOq767xrHQbejH9psYMmvQ+zgagw0/bkWN5wl/2on22HmVWejocm6Hj/JcAvQuXhpaUz7rb+au8fjfzaYRHk4sM1IPwEhwGpvESrZTDXevc1OC8KwN4ANlC/iTzc3JPW/A4o8plGCrdmw=
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 13 Dec
 2024 20:34:05 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::a0) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 20:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Fri, 13 Dec 2024 20:34:05 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 14:34:04 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <jay.cornwall@amd.com>, <Hawking.Zhang@amd.com>, <flora.cui@amd.com>, "Philip
 Yang" <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 2/6] drm/amdkfd: KFD interrupt access ih_fifo data in-place
Date: Fri, 13 Dec 2024 15:33:27 -0500
Message-ID: <20241213203332.18165-2-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 72845722-01c5-49dc-d3c3-08dd1bb57d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V2snGZ1o0TN7mpUQJWqJNqSu4m1ZftdjLqBYPNhnfOpURh1OMSWTqa3+S2xO?=
 =?us-ascii?Q?4RWEDGQab9uxSK10md7B4fQcYxdVzxWImvj2VeiFY1gxgMNO577EnN6ufMOj?=
 =?us-ascii?Q?VYFK0CC2umJGU6lo/HngWwdqYwJVP9u19DUiiQsbpIoBKeWu1Sj7m0u3G4nv?=
 =?us-ascii?Q?OlCsUlIHvbywX3VNwH17tFhK1DdfHeOTZ8CcTiPp5fINx55U1kfROwQXdoN5?=
 =?us-ascii?Q?fsLVwWAikE0sn+f8UubcQaEcJx+DvhhlJ5DYnZzHhphaaOa4miKfVvorHrEY?=
 =?us-ascii?Q?7cF7qFQeOGTUqFt6I3DnMRNfBufuwCb4E+51NNgU9NgpgNyVjt3OYN5JDTR7?=
 =?us-ascii?Q?6m96Nh0mJhZQ2o6R+BxX2hiQDip8E1Wj8RquXVGJxJ+ubhiDy82W8iBxpQ1r?=
 =?us-ascii?Q?agReRd+wlBd5vVHkDYt8pCyNwqh22XY8vUNo72TRX6mgurNYm5p6eUEkrVf/?=
 =?us-ascii?Q?M7krWcBGYxDD6E3CnGFmqdDEMmHKcW6Trleydu+Zqu12SzSvpbGdX7Y2RMFh?=
 =?us-ascii?Q?eh5RUAJCBnZGPu7XHGRDN2Wg3s6+uO1Xzq1B4q6IlyqPvPAfROdKhNbD9qcy?=
 =?us-ascii?Q?vh1vmU4cM7DQOrIO/92YIKaBC8vlJ35pTwWaBz6yv36uFdNzOvvJfnflQDcE?=
 =?us-ascii?Q?ZtDScguv63VB+QVmrF4r0BBBre1bu3B3LyS8oR5DDy8qpNLZRNMW+cPQOCqz?=
 =?us-ascii?Q?pn20miJ/CZje3l/sm/hOuWKVcHQjbkh0SM69VVFT3z4iLC11Iz6JPhwhEs2o?=
 =?us-ascii?Q?xoXOiJ/Whc3QAgcRxfc7LMuiDR7cJYwKQ3Oxdea7S7+JE5VNPAON1GDqK/A0?=
 =?us-ascii?Q?ayQq+EUy1ANjKXrzV7j0NNZ3gJ7Pbm8zGbfOopG8EBjvQvJHrLx0Lo1pjMWf?=
 =?us-ascii?Q?v8v4ePKbRV225ySh0P+tsNXG/4w+J/9KDtU798040hwsKw6nSHaP1UTjhQXl?=
 =?us-ascii?Q?Dk/r+n3jJWTRtQV/tDh8q5U0UaGgcXG/XY1Nofh6O2SKjEYoer/Vlli/qs7s?=
 =?us-ascii?Q?IbQQdk1V6hhzRdffPNulP4WEK7Zhenytf6ZrZ70uXs0+eAyTy2dC3YAicPoO?=
 =?us-ascii?Q?WWdLMFkNMtru1J9hs+hhcYIDSMcZ5f1E0lb4GMEIbkoUkwfo/4nSZxAN1g8d?=
 =?us-ascii?Q?NQOdT/Qc1dyQ3F5/8NKrAM2KEMmgTl/4ubAhGpoRvJ50M58YsBfauPf11inp?=
 =?us-ascii?Q?ZUpezMc7oU8aZunRnyxkyBzpdpkJTngIXBhuflrDNCkZDCrqHvBYIwfQH/Sv?=
 =?us-ascii?Q?GmpJorWXa90b4hMhMe85OZCxfTLiSxf5qtUVz+GQUOzMopMu/ofZrB7IIA0p?=
 =?us-ascii?Q?P0M9B+TE5mMnaIPEYbb8CPFNtkjvmZOr31K+DWfG3C1iqA05g6bjdaKw+XCi?=
 =?us-ascii?Q?F3IZQWCGPFOh3xcm/IkG7jFxCisPInY1T2FG9GQnAqeRLM2HFYEVdgnCpSsB?=
 =?us-ascii?Q?cIeqpmsgzUJqvmb8nPLdGrTYRFxhT03D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:34:05.7663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72845722-01c5-49dc-d3c3-08dd1bb57d18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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

To handle 40000 to 80000 interrupts per second running CPX mode with 4
streams/queues per KFD node, KFD interrupt handler becomes the
performance bottleneck.

Remove the kfifo_out memcpy overhead by accessing ih_fifo data in-place
and updating rptr with kfifo_skip_count.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 35 +++++++++-------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 9b6b6e882593..e7412de9a0ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -114,50 +114,43 @@ void kfd_interrupt_exit(struct kfd_node *node)
  */
 bool enqueue_ih_ring_entry(struct kfd_node *node, const void *ih_ring_entry)
 {
-	int count;
-
-	count = kfifo_in(&node->ih_fifo, ih_ring_entry,
-				node->kfd->device_info.ih_ring_entry_size);
-	if (count != node->kfd->device_info.ih_ring_entry_size) {
+	if (kfifo_is_full(&node->ih_fifo)) {
 		dev_dbg_ratelimited(node->adev->dev,
-			"Interrupt ring overflow, dropping interrupt %d\n",
-			count);
+				    "Interrupt ring overflow, dropping interrupt\n");
 		return false;
 	}
 
+	kfifo_in(&node->ih_fifo, ih_ring_entry, node->kfd->device_info.ih_ring_entry_size);
 	return true;
 }
 
 /*
  * Assumption: single reader/writer. This function is not re-entrant
  */
-static bool dequeue_ih_ring_entry(struct kfd_node *node, void *ih_ring_entry)
+static bool dequeue_ih_ring_entry(struct kfd_node *node, u32 **ih_ring_entry)
 {
 	int count;
 
-	count = kfifo_out(&node->ih_fifo, ih_ring_entry,
-				node->kfd->device_info.ih_ring_entry_size);
-
-	WARN_ON(count && count != node->kfd->device_info.ih_ring_entry_size);
+	if (kfifo_is_empty(&node->ih_fifo))
+		return false;
 
+	count = kfifo_out_linear_ptr(&node->ih_fifo, ih_ring_entry,
+				     node->kfd->device_info.ih_ring_entry_size);
+	WARN_ON(count != node->kfd->device_info.ih_ring_entry_size);
 	return count == node->kfd->device_info.ih_ring_entry_size;
 }
 
 static void interrupt_wq(struct work_struct *work)
 {
-	struct kfd_node *dev = container_of(work, struct kfd_node,
-						interrupt_work);
-	uint32_t ih_ring_entry[KFD_MAX_RING_ENTRY_SIZE];
+	struct kfd_node *dev = container_of(work, struct kfd_node, interrupt_work);
+	uint32_t *ih_ring_entry;
 	unsigned long start_jiffies = jiffies;
 
-	if (dev->kfd->device_info.ih_ring_entry_size > sizeof(ih_ring_entry)) {
-		dev_err_once(dev->adev->dev, "Ring entry too small\n");
-		return;
-	}
-
-	while (dequeue_ih_ring_entry(dev, ih_ring_entry)) {
+	while (dequeue_ih_ring_entry(dev, &ih_ring_entry)) {
 		dev->kfd->device_info.event_interrupt_class->interrupt_wq(dev,
 								ih_ring_entry);
+		kfifo_skip_count(&dev->ih_fifo, dev->kfd->device_info.ih_ring_entry_size);
+
 		if (time_is_before_jiffies(start_jiffies + HZ)) {
 			/* If we spent more than a second processing signals,
 			 * reschedule the worker to avoid soft-lockup warnings
-- 
2.47.1

