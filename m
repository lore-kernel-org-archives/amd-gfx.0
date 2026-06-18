Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37B2CD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 03:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DB210EBCC;
	Thu, 18 Jun 2026 03:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BS4skLNv";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC87710EBCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 03:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VN+t0zIlTJThD4y3eWQEvm/t4Y/FllbIyv4IrORS7RSo3IWphZY+FN9dP7wqMxhYovei7MvEdDBiHE55tUV88uVYUfViBsRclwsKHx5+Im68fdHFd6mD2qHmoLqFhgIIettEJ3c3wO7n9PnXuucWfqfZsIiPyYhydjRp+N6CnUqKe290gUvM+Vs4b2RSEE2qcESP0M74I3dIQickY0pjK3sE/LnGhypZlLou0ULoR28WAHVTXBoPF+RE60rucEUxrtXMrhHuAyXcSKr8CK0feDMbJoPOs0UxXT4dTZUk5elvasy1OKr7WmSGx/r7dFILATvIN145JMLQtU+SqgaeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV2rMVQgmM0X3Tmc8QgmzrZzVne8U3xHmQGT6nNbLbE=;
 b=pH2h4cWz3HXWLMuic7VAkBGhSvjZdai//OCkillni3cYmtnoPlCsfd1RdIW6vGE8S1CFrUKnFX36hvsEVuRp4JoU07h3RWHntCJdkPF8NgZ5Dk3nV3Y3SWAIW8vJUKczzRu2ZUTIHPF836i7TqiKKGXtigRnatsCPI6cljssx7OCQ+29b5W9BkrPkL46wfuAQycrX6TRBsTpmZty2GKv1ZNKqI4fgQsc28djDifToC+jtuskT53tbM+PiCox03Psnld2AksaFp6yFz9KaUPnbi9Jax7ww2kaCRRFXvAYKm0YyTFOgZezvDCgLW9iM/+1mUmWwuHqhnR+R1+33iEtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV2rMVQgmM0X3Tmc8QgmzrZzVne8U3xHmQGT6nNbLbE=;
 b=BS4skLNvjlxVD95/AvzVWZmpMmSXEZygYGY4wA/w+48vxF2pSOZJnoYFy6I1/cIstcFzZc4GKhAP/6BFBZbKm0Kvl4q7urAHkLyVZ9nE87bjz/U82qFkfTNsNh6W0avRL2mrQ6dJuS/bANucb1KZIJzjJtW65Hil9jjzXuzVRos=
Received: from DS7PR03CA0233.namprd03.prod.outlook.com (2603:10b6:5:3ba::28)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 03:59:09 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::7d) by DS7PR03CA0233.outlook.office365.com
 (2603:10b6:5:3ba::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 03:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 03:59:09 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 22:59:08 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jesse.zhang@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix mes remove_hw_queue lock
Date: Wed, 17 Jun 2026 23:58:47 -0400
Message-ID: <20260618035848.147403-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 0074048a-de84-4926-a1cc-08deccedf32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: M4E9zH7CqrCbCtzpFl9j0fdAoWRcYhyLpwzfDpOUtqEMForIiOp1upPhuAMred3Z+dG4Bv66DeYkFER2Og7qRi3qZ2e2h1wIkBrSrM3Nmh0D0Y+9NAgDRoc/gFgujNGZpC3nyEFLQus8DN06T5kxGEl/YWms1dkKFKND0gLT4RIXDdV3q0A+mdSxBHIED/HIXAFe2rgy+ny/Q/wffi49+d38WjvONyuri3DTbLMHJxPGBU8l2b+xY1IMqXHQTBLcSqEAx/y1YP4Bcg3m1ZuucU39zZrHEoUIxX0j1ENCfCo5N1MGklXtYwnHk5pX4nAPhDQA0KLANzvl2pXT6DYFDH0zmAN1Jv3yh6QXLfyNkv4BLctDoQrOVEucxBhcdUbZ27S5tNhjPizbD6HZPc39uRtxEbYF8bPRKBNS9Y7pESzZBqfI+RL74bZbvGVtFHrB7g8WKesr+fKguApM59+BvuOhnNJETPW8p7BT1r/VWTBXx5wb3YNPnct20A8xUEXl8uxQbPgUJ+vX+6S4Rj/wjW7HdNLlCDA63ChF5BspmN8UtW8hGQVqO5VXiPr2MbYmU6D4YPBIGyV0F0BmNWpl4VTRYNldPKmnqk5V0fV4R26lDvJf5A/Dz+IARSQh3wpJ4wZOfc9RGMzpSvs9i2v0Vh/r5VPkzMEcrJ1XrpDf9puGYZKF3+WlXBM65SDacLI0K8fDXWGpF0T2AsIreEZOmKn9fjXjYwCK77V96iuXO44=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JhRBh++ajGiaLYELHn3V7Z7OOxCf8dJDnzarTNZnLYVdP0CasBz4blJshQfPHH1D+7OCciY1pXi6iQch69J0ny093Js42DcRj9qrgAyc7n3c6Ioz6o3Un/Iu7smFSwVzHnvnss2HKP9BAKHnGVIQ/LoJUzxthdzHezLmVgo/Sb0fZK4nHFcqWQhxd06qiKhxlzt0t+6n33VqXAYjDyKXg2BVKQGa6rOZjeKQyhOeZXdfAnwF3DPLuNaClJ6nENvnCTho9M/lyW2X84eSr9W0es+zFlSC+jXM/GlfiD3bZU5LUXiCmTX0tMhAAo/yNqDLmF3aOIflc+C8D/eWUYQxLs0KQ4HnsTNzPPAZVDKtXAQByuJ8LSxZnIFbKd2uFE60e8UiDxVKdvj8w6Ny5ip7ZBGuNSRF36GG/JEcq00YwDdD76bhI2Sf1NhLuxmRZBdc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 03:59:09.1594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0074048a-de84-4926-a1cc-08deccedf32d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

down_read/up_read adev->reset_domain semaphore should be placed around
remove queue.

v2: remove the empty function, recover_bad_queue_mes to avoid compile
error on rhel

Fixes: f5587b4740c0 ("drm/amdgpu: Remove faulty queue before resume")
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  5 ++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 23 ++++---------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0506b90f318e..982b41606d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2358,9 +2358,14 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		 * preempted successfuly. Remove it before resume all so it
 		 * doesn't get mapped back
 		 */
+		if (!down_read_trylock(&adev->reset_domain->sem)) {
+			r = -EIO;
+			goto out;
+		}
 		amdgpu_mes_lock(&adev->mes);
 		r = adev->mes.funcs->remove_hw_queue(&adev->mes, queue_input);
 		amdgpu_mes_unlock(&adev->mes);
+		up_read(&adev->reset_domain->sem);
 	}
 
 out:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index fc1d179148c0..83be54372b18 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -72,11 +72,11 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q, const uint32_t *restore_sdma_id);
 
 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
-static int recover_bad_queue_mes(struct device_queue_manager *dqm, struct queue *q);
 static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
 						   u32 doorbell_offset);
 static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
 			       struct qcm_process_device *qpd);
+static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
 
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
@@ -333,11 +333,12 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	amdgpu_mes_unlock(&adev->mes);
 	up_read(&adev->reset_domain->sem);
 
+	/* If is_for_reset set, it is a mes internal cleanup */
 	if (!r || is_for_reset)
 		return r;
 
-	/* remove_hw_queue failed. try to recover */
-	r = recover_bad_queue_mes(dqm, q);
+	/* remove_hw_queue failure indicates a queue hang. reset the queue */
+	r = reset_queues_mes(dqm, q);
 	if (r && amdgpu_gpu_recovery) {
 		dev_err(adev->dev, "failed to remove queue from MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
@@ -488,20 +489,6 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	return r;
 }
 
-static int recover_bad_queue_mes(struct device_queue_manager *dqm, struct queue *q)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
-	int r = 0;
-
-	if (!down_read_trylock(&adev->reset_domain->sem))
-		return -EIO;
-
-	r = reset_queues_mes(dqm, q);
-
-	up_read(&adev->reset_domain->sem);
-	return r;
-}
-
 static void increment_queue_count(struct device_queue_manager *dqm,
 				  struct qcm_process_device *qpd,
 				  struct queue *q)
@@ -3273,7 +3260,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 
 		list_for_each_entry(q, &qpd->queues_list, list) {
 			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
-				recover_bad_queue_mes(dqm, q);
+				reset_queues_mes(dqm, q);
 				q->properties.is_evicted = true;
 				q->properties.is_active = false;
 				decrement_queue_count(dqm, qpd, q);
-- 
2.43.0

