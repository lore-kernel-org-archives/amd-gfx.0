Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8201C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 13:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DE010E13F;
	Mon, 17 Mar 2025 13:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J5z/+SG5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FCDD10E13F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 13:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQzDGCD4DWCrIncH4IItLtDs4ICzbBffkzwBXKzWsmcbRaoBdcNpLY4rPMydYXoeRLUQAH9xNULzvnhCmd4AFWVp4kCWlC15TnKQz+Tc7UgBWy+MqNxqahdjMtGJV22cf/Qcn1gxZ+l9JDwFXKxZHtvWHAcWYqY1bvBz2HRZky8aExsgoml3TAMTW3Sy65j+uRo+jEpMvbkne1WOB0xBzzlOw4/JoiVK+PSJ5rAz5k6XbST88sKXyJ08Ty/dUsWpu2jHX4sHd53BtC4ofV7v5rxXbcZGwFzXVmc/aIDM6E/2yTgP7Hi9q1zt6s1E/0nuXAJtx1f/gpm2wR4UvKgZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlAvFPXxy1Uoe5lgamwulwkzquzWfABNWpFrwZG5mNk=;
 b=wQoqWb9qdXQ9A1JfhrYPGcySkAuDhD63UM5OEllO61DcuxVJiXqUY4+Xi9amvHSLqiUSSq0VfSlMWMGeqSa4jvtITdAzkmodwWy72aPDhjgtQjCgtef/ooLBfE6eOcAihTrO/vUSsyFh8x4dK1Se8IfcRKrJhBuSjMvrAC5XEauuCW9GDZcNI1sof6TCBP4B09FHG4eqVMRM0Thnah6CS/bWAm9Bw7HicV74P5E8brlyywDr9VHFKkh9CNOBUreWOmcHLophcAFMDPlMTB7a+zgfmRqhk7xqWseL7ULMqMUThl4L0Qv1HBijhN58Zfag1pBRBE2gh/GHYdij0nImyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlAvFPXxy1Uoe5lgamwulwkzquzWfABNWpFrwZG5mNk=;
 b=J5z/+SG5gQ5tvhr3BKhdDn1RqBot0/vYRtVZeRcrx6Uh3UyudHzqL2LtPc9Sj8qMHyl+kgFifIVe7/WnXqXtlapQs6BkKeYNiKlMmj9qVIktZf1BJVvC8VFo/8cHNUMvgCDhgWkjIBy3F+0PilmiNeh5XwjQFwlvT7AoVc4zUvk=
Received: from MN0P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::31)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:47:25 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::27) by MN0P223CA0024.outlook.office365.com
 (2603:10b6:208:52b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 13:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 13:47:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 08:47:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/sdma: fix engine reset handling
Date: Mon, 17 Mar 2025 09:47:09 -0400
Message-ID: <20250317134710.764906-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f010c91-7e52-4fd5-24cc-08dd655a3edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dcEXVlWvLaYZ8Tse6ta1Qm2yhdmkJJBcEs2XzNaLLENG/dxPjH4i9a1LCXAh?=
 =?us-ascii?Q?YULhdjSxYmeOnxB+JzlJXSN+jQnb4PlzknHYsTiBYo4rw137rDEGlZps0LNM?=
 =?us-ascii?Q?JLzqAY47SzphJNYjkqv4zBUmsQzK1zUwYJTYib3sOWeqizP00EaKqqJU8HwA?=
 =?us-ascii?Q?CG+u18yi/OyAiXu1nfNiqh/a1CqF0BCygxsuAQbYMnJuXZu20ckRAGIaIcd+?=
 =?us-ascii?Q?yBmiSriu1DKFAfNmVBg9yt2z8jb6DoqHGPRrYOCd/ePe/ZtoC5l00k7WquFd?=
 =?us-ascii?Q?nPzKGjsmMauO7FO08PHlJgEMDjl9DnTjDhApN7sHYiiK6Da6iEh9MjvNNGQ0?=
 =?us-ascii?Q?zuGUIH9KaVnSUl3npEJIlwRZKnI/x+QLgclC3cGHkNNhM3eKW9uLuFmcDHvC?=
 =?us-ascii?Q?Zt+RqcuDOIMCgSbhEOzBLdJ+pGRsUqQ7NptQxck/NW8J8ZqByD37MzF4YLQ4?=
 =?us-ascii?Q?qmVBT0zmo9M/V/zyP3NqvEdpObWbqYEO1nBrlC+swaMw+eOl5WpkkYrmB3gl?=
 =?us-ascii?Q?iEwLq6K5aHLvHIQVMtW5hzZW1Wqio3snKTOrouJEQHRDEcrUPUG9n4hqlUBa?=
 =?us-ascii?Q?+p/B55nQdlmeMwyoKHvh8Ahq75Itw7cHJ9nKR7rEaGvg5MAoWLe/5HZbZYvt?=
 =?us-ascii?Q?wHkGle2zXkk/QFzHJCD5pYnVJvNq0iHE6brVy1ZmlLfdUYRVbKVV6Zr/JX4Q?=
 =?us-ascii?Q?Zi0VY+ArOTwA8KS0Wr0rcnQ8lyFZ/1gKCIQhHVZaXnLHe/po8kxGhQWXlUJJ?=
 =?us-ascii?Q?2usEmA5rIItqgBqnQLlulPs7dkm7fljSpB40FSRPNbM+JdUvcSTc2yRmG7L8?=
 =?us-ascii?Q?SJpYM0R3g2ZCW1u/gmcTWgwNypmkiI1qVO6yOBstxjoK+e1nldzsGhsHx8oS?=
 =?us-ascii?Q?4SRlL62Wfo10Q1bd3mHvCebmnv07igev9MoiEjGf4uAS5qQUDSXFlOv+Pdut?=
 =?us-ascii?Q?DpmtI3j7vBAVYKO1VtBtukNJoqeBR2QOdC66NUXDGc4BmkW4xowRoAFlrZft?=
 =?us-ascii?Q?uI/b9ugvRQy0s0Vs41qK7j0ppLJWOt7+aJhQZ4nGAV7KEXxSHtVG8+nX2Rld?=
 =?us-ascii?Q?ein6Vh1spsaZ5B6I8rZo+r5VDqxgxQL8IBmkIBzZpMwxXMcpgI0Ol3ZO25y4?=
 =?us-ascii?Q?34xkIaiwH4HErlm8Hyepub4exB+GSjLkaO2VRJ1Nv5MlNKU1mO6D4+CnC9Eg?=
 =?us-ascii?Q?Xy4400AFL6P0QGc2O6F39F44EqqXz77jmLUdXoalWrVxpIFnsHgKczpcdal9?=
 =?us-ascii?Q?/EWup2YrOmnaR5ZiPYOP5doDuCRjLb1wvh3l+hNGBtkltwM/9MEQC3zY0DaV?=
 =?us-ascii?Q?uMfo2C4NoN21gCwC4aPB88lBDSV2hc17Sj0cPV36t4Bg20FueGGbhxz2i2Gr?=
 =?us-ascii?Q?5G4jMHK40RrnXNCcr6PStL++s5rfbr4m6tqAMBqecEIlXB/qB8G6hTlxkoho?=
 =?us-ascii?Q?VBLHBrYt6z4hFFg6VQVQQ0HSvi25E/Jfqm9VMFC0LFOkaXpBvVNr98zg3dsx?=
 =?us-ascii?Q?NhlMk6jLDU66LfU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:47:23.2283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f010c91-7e52-4fd5-24cc-08dd655a3edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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

