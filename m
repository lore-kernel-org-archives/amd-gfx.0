Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BA0C35FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A1C10E412;
	Mon, 17 Mar 2025 14:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QYNV4BsF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E269D10E08C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uV2pfHV7e+ZYK1wXUO0RvM+4Tx28CN8cj82MzHXLr/IRxmhOqo2L77tPPcSUzDB7QRsIlpwsLN5OK5bOpf0BvMPE0RwrltrLii9zHxfVS6LTraLNn/gQwh5nEaKlfHwQRAxm7wNEsVygRgt9EYJtaxa7ykLP8poO8J+nHWaiYmbT8TXcOW7DKfS032yhRxPLcMVM72fu+XIHqZasZOOpr57oU7sfdp5nkP0iuOtaoWTpIwkHtNQ8aBlzLBWLmhdP5Werd61KXJxEsycOHSwe7HZsBISBkNhobzIP+icE33vxOJUquFTqEO9z9J9JwZd5HugkoHHQVqBBtllEOuUZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlAvFPXxy1Uoe5lgamwulwkzquzWfABNWpFrwZG5mNk=;
 b=Ye5/TsMtj2ZzmdI7lVOZIanMNMyEnrIuQoYugmoueOnv75WInC2TWO5eV8CIs6krfSjjXPXdEgP4IApfoP9BBmF2Yu4HRL7zLPtjaDuEK/VAYBPD4c+/jALdhQ5b9kky294JH0U5bwM9m2s6wepwLp8+DEr9YYVoSZ5ZXq8yG0u1BdS2ucM+XAbbKUk7vPopWo1YDlyIbVV/DmPTgqTZlJlV0JOJkFSmL5YLgw/OURYqc9tnJoYv7WfrdBs+fo3ZMD6Y6RW0NW8CwHmEMx5fz03SG4Kbz8xnjNkBVH2I3E6UcLjwQrdG+rRitDdko6BOJtLlV8BzcExrmXLw9cYbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlAvFPXxy1Uoe5lgamwulwkzquzWfABNWpFrwZG5mNk=;
 b=QYNV4BsF2Po8cFS7TsVRErWrDwziJf8s1QkqCPyAWi0xmaYnYKfQAYyc1rIa6BjjG/NLdYN6vPj21RuYK2ZXaqD8mJzaeIv+kkIeWAwUFEjbsV04uh9BKgjtJYjXsvX/Ulru2CMLiGjktXEcqzROLXxasfdtaIGsintqnADIrzU=
Received: from BY3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:39a::15)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:46:19 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::fe) by BY3PR03CA0010.outlook.office365.com
 (2603:10b6:a03:39a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 14:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 14:46:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 09:46:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/sdma: fix engine reset handling
Date: Mon, 17 Mar 2025 10:46:02 -0400
Message-ID: <20250317144603.809849-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 22216f06-9067-46c3-1eb9-08dd65627a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dF9JpS0xGXptd0AZht3P0Tx5+a2SV4136nzak56ixddcS6DceP6pazgcFeVp?=
 =?us-ascii?Q?JmR3okUWo2uyrWWy7Rw3v8IlAz1a6BfXbBZGsh+7CvkydkTHX4TcVjib/5d2?=
 =?us-ascii?Q?oULa49FIWC+ouMIryPuYYFTLgxerHea3yJFYZ0fH9/xeXgzd8tPt94SAAAiJ?=
 =?us-ascii?Q?hnXDKLLAB1QaezVYxIk3zJDE+g+6Xprnqdg761ZErd57Z77V6G3vprHS9PO8?=
 =?us-ascii?Q?c0Blse1lUOEwBtMCydSp80EaLNGpfElDl06HCKK4apQw3TDL7ogSwxlz96Cm?=
 =?us-ascii?Q?23LItp6Ctj/QVpTkB/nPjJvjAFBA2xRejmgvzx82Y35MCiH9WxMWK9ux4NLH?=
 =?us-ascii?Q?Xsm8pCFH38JOk9b1mrgUUqKLebnhqJEdAf9ZmaHG4cAXAI4bUuw7bl/cJO1K?=
 =?us-ascii?Q?S3i90LuGd48/HeRVpo66zTB35joDRI18WNLIgLg9j4ACdzfcEeUN72P8Y2gT?=
 =?us-ascii?Q?fjhohXrZhlQlnP5KdiHG+aXQM6Z4w20q6P+gjarIRzFYGyMunuMcmLWkKjhx?=
 =?us-ascii?Q?DBmwoM19vCUkjuFGe2YzGXtxgHZ1mrDYtOcRAxkccFrLcM4NpQgEW1vwXnSL?=
 =?us-ascii?Q?FsjKhRMKTb8w3//6FJ8vn3qS+UMkIebaO3cGPcLFsyfnPtV024rewRL47kQJ?=
 =?us-ascii?Q?onPfJ9/MyerDqm/y/FY6DUoyxVikTbpDSjp+nCGW0EoQaTcZApypj2lq6YIS?=
 =?us-ascii?Q?4HtnblA+C/8xWzoCNEmG6y9zJDt8Io/9BxJcch51W/xu+Sg0uuovzHCGTbPo?=
 =?us-ascii?Q?aCpxB6YRZ54CvPWntb21+FYSmjQ57lee//VVIQkPsfYTxBoXzh5C81p1OAyn?=
 =?us-ascii?Q?9O3WaQhHHRZuBjEf1JMPe+tkt3FP16uR3LSVNi5DRHUDZ57n1rLFkbhv9Tow?=
 =?us-ascii?Q?/rZzo6hSRPpeWby1OvaDWQBdmyrmHb/kKEIkYaAmcsJ4sLEW1ZvybFNQpO27?=
 =?us-ascii?Q?g6elIxy/42w2UmwtQTeUllUspSz/vvSsv2e8Szml4AWgLguxpm1ApGh4qig7?=
 =?us-ascii?Q?3GVpSNJFT9QhlqmWxv/bDiqeLQ5rcjabIk4+OFgViq2/FT1xJq8CdoHGKwn/?=
 =?us-ascii?Q?U3Kg4FFqmGBxEtsiRWHvVeDBa0WCDJBtzSK3RHSw/bpXeo8fCYPG4R3Inbd/?=
 =?us-ascii?Q?okxlqe5xV4rKlOssFz+UCgDvVivpexdq8/EqF77EnWLDn/IQjcjHF/PPuJ/9?=
 =?us-ascii?Q?CrGK8AAbtEl9Mxp8azNISHpe+Zlu+oeeRz1qmzX7cagmeWwTLCqDW9mUasez?=
 =?us-ascii?Q?Iy2tfwJFk3DyRlUf0o1hDb1GOR7hwqUO49DodYMIIWxaN8AE6c66MuTUIka6?=
 =?us-ascii?Q?hKipQfYXkpPLsbIYoQyQfeQ5MZyR1u6rWLZ6FjyQrj82EA2P3QwiQ2sP1TA9?=
 =?us-ascii?Q?PyWreH5ey5twYZvNid3QJCkK32rdE+3Z2lhKXS7lJyD7nvfqBf3cNMTQvi2e?=
 =?us-ascii?Q?SfbziO5idlA++ZIybZAH6toikJ2NLOEw1huqBdVJ2ZuwSEd3UU9B54h53JDR?=
 =?us-ascii?Q?Tf+p8ysUHm6ozJ4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:46:18.3342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22216f06-9067-46c3-1eb9-08dd65627a12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
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

Move the kfd suspend/resume code into the caller.  That
is where the KFD is likely to detect a reset so on the KFD
side there is no need to call them.  Also add a mutex to
lock the actual reset sequence.

v2: make the locking per instance

Fixes: bac38ca8c475 ("drm/amdkfd: implement per queue sdma reset for gfx 9.4+")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c          | 15 +++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  9 ++++++++-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 03c4c012a1508..1b0b2598a90a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -524,7 +524,6 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
  * @instance_id: ID of the SDMA engine instance to reset
- * @suspend_user_queues: check if suspend user queue.
  *
  * This function performs the following steps:
  * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
@@ -533,7 +532,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues)
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 {
 	struct sdma_on_reset_funcs *funcs;
 	int ret = 0;
@@ -542,13 +541,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
 	bool gfx_sched_stopped = false, page_sched_stopped = false;
 
-	/* Suspend KFD if suspend_user_queues is true.
-	 * prevent the destruction of in-flight healthy user queue packets and
-	 * avoid race conditions between KFD and KGD during the reset process.
-	 */
-	if (suspend_user_queues)
-		amdgpu_amdkfd_suspend(adev, false);
-
+	mutex_lock(&sdma_instance->engine_reset_mutex);
 	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
 	* This ensures that no new tasks are submitted to the queues while
 	* the reset is in progress.
@@ -609,9 +602,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 			drm_sched_wqueue_start(&page_ring->sched);
 		}
 	}
-
-	if (suspend_user_queues)
-		amdgpu_amdkfd_resume(adev, false);
+	mutex_unlock(&sdma_instance->engine_reset_mutex);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 9651693200655..8e7e794ff136f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -64,6 +64,7 @@ struct amdgpu_sdma_instance {
 	struct amdgpu_bo	*sdma_fw_obj;
 	uint64_t		sdma_fw_gpu_addr;
 	uint32_t		*sdma_fw_ptr;
+	struct mutex		engine_reset_mutex;
 };
 
 enum amdgpu_sdma_ras_memory_id {
@@ -169,7 +170,7 @@ struct amdgpu_buffer_funcs {
 };
 
 void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues);
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc1380811..927db7a080f0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1445,6 +1445,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
@@ -1666,7 +1667,13 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = GET_INST(SDMA0, ring->me);
-	return amdgpu_sdma_reset_engine(adev, id, true);
+	int r;
+
+	amdgpu_amdkfd_suspend(adev, false);
+	r = amdgpu_sdma_reset_engine(adev, id);
+	amdgpu_amdkfd_resume(adev, false);
+
+	return r;
 }
 
 static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2ed003d3ff0e0..c610e172a2b83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2310,7 +2310,7 @@ static int reset_hung_queues_sdma(struct device_queue_manager *dqm)
 				continue;
 
 			/* Reset engine and check. */
-			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, false) ||
+			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i) ||
 			    dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
 			    !set_sdma_queue_as_reset(dqm, doorbell_off)) {
 				r = -ENOTRECOVERABLE;
-- 
2.48.1

