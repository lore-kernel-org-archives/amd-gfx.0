Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD97C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 08:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9465F10E408;
	Fri, 10 May 2024 08:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mrpPb8M2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E1D10E408
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZUr/AnFBpMoyTmcJ+eip5TACn+ZLWc9Os4h3vPElx7xGsmRUV+cOwMN1tng2I6P4v6sPaYAgdQWHdCqbGmKRXsThoES1bu+o9miq0LpDw6/2YOeu/Zl1mH6RRZk0l4xElc9Wpna0OXmk0uKstkGa6/dVeIoTy30ZPNJ9JqmQvejSbg6uhDUeTrCrURdFfClArBfS/uJvKQhmd/wWqOhiw5EgnzpBNUTGNHt8Rb+Yr54jt1vKcENoo+VTFHodV9bK2/b2OJsgr3uoiBZ+9qUaPMSfM+3QclpyXt9LajsekOWCmuA/ahe289t1H6Iv4yJi0tsWLzuz7a5oKEA8bcFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HzyDUo2AOI88ZzAmHFgQmpf2dfdxAcY8mtQKBm4bck=;
 b=GktxNX1C5EcIZJk0rG+pnFZ2JQ7m4qHamkJ2fIeV/dzzjeghSKMae91h1Y7KH/NoLSF74nHX3Yi0jVqNeSX9+YaGO1ed4RT9diBadBFxCObri0gJVkeHaC5smA4WiZzhFv0LdOIXT2fyVXKsEWSM2BlF0Tu86DQhYap63cXE755JJXIq8sjaKO+X3mevFcM3U5RfIF6yFhbQBW7wx922e8Eh3/zimykPt6Vxo9kCqzAJ3yJqB0BN5O3ogJKDy5oGfbXIo1gcmcQG0XzE5H9CotimfSiJMfA8G8ND6gKZxi13NSYEksu/N+wFy1HVPGyMs5m595iuKZ22dJ54rfqKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HzyDUo2AOI88ZzAmHFgQmpf2dfdxAcY8mtQKBm4bck=;
 b=mrpPb8M2GJHiiMb4QSf3+pkSmivji9zjekUcLcmSZsRLzQDs+pZrkigynK7Zzx8J/Jdl5VQYBdGordfnZNLVBf65NgJLz8bK8p+bm1qbwUx0OQTRhAEsk/0uDfYGqnPuzIoHXU5spZaRE9/4cwugPP9Iz1+nCikhgiyhBiggz44=
Received: from CH5P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::21)
 by PH8PR12MB6866.namprd12.prod.outlook.com (2603:10b6:510:1c9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 08:51:27 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::9c) by CH5P223CA0016.outlook.office365.com
 (2603:10b6:610:1f3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51 via Frontend
 Transport; Fri, 10 May 2024 08:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 08:51:27 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 03:51:24 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v10 6/6] drm/amdgpu: Enable userq fence interrupt support
Date: Fri, 10 May 2024 14:20:46 +0530
Message-ID: <20240510085046.2718-6-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH8PR12MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ae67e3-ce86-4a10-6701-08dc70ce60f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SbjUKZXgYxksUCtP5qnvFWyms0zMkCFOqbaZVyJ4nxurF+01b3sXzbXJU94y?=
 =?us-ascii?Q?8ajBZENu5AwKh/GnCXSaUe9OAiuubrIR+AA/lDeDm1HHrhXK5Iq8hT26kPko?=
 =?us-ascii?Q?ObXB1NcNge4bg/OWDUchPdv9l0o0Y84Zo9WRb+te7kwlL0wckg2vCa6HQN/T?=
 =?us-ascii?Q?ellMykwPL7cMzaI00vJCeqZuYtFc4cyuTUjToCoVpm3czwjXj9t7foqyMelS?=
 =?us-ascii?Q?bES1TgrAitaI5fb70DckmTRJGPKZUhyJ0Vrq8qVrT2o7XcuB0+RsFOUntEO9?=
 =?us-ascii?Q?6/m8FPVyKuqX3XZ6INDkKjIcLJsYSBylj1yUm1QLZZ2Mbp3tQrQQyD07EEEx?=
 =?us-ascii?Q?EY5jSjBITvwY5qL3KB+bdhlHs2C62+ygniq2tROw5NC3NSKgxY0J9r4Orpc0?=
 =?us-ascii?Q?zEKUONoUws9g+WzbX2pvqk3IArK7s3/tjzvMblp126sjEQLlWOY5/mW8RHbc?=
 =?us-ascii?Q?r1Pa2qAtvHPKDQt8EDdkblf5zFd42oqwVjTqYVKzaRUx0RoQjL8ZcsmLfkZp?=
 =?us-ascii?Q?scDSS0Fycg19f1ZxLj1kwXebc3/ZAGgvhde+c2VVSpJyMDFnpr5Ow6ax1Dn1?=
 =?us-ascii?Q?KdIJSFf2vmjvr6v5GPPS375QVz1ypXpre7eVJ10kP5V/LbzdR3rmgex6HrTH?=
 =?us-ascii?Q?3tXPg68BoWk9JuoLGuIDekQ0fvIJduWIBneFBJkuPeSIzo08j0fj7AVnPkuW?=
 =?us-ascii?Q?ouImY4FEp+fD3FqalDBX/weraiRnFtXdPiK2KF+aqBsR9RtuAxX4w79fg2UZ?=
 =?us-ascii?Q?jTZesOy8kjBDssO+P3LHXiieAmdmXWI8KskGb6FU2SmfOwl8ghuuAqydNlad?=
 =?us-ascii?Q?EjjGFYmCe/JLK+KrEFfUKzcYRaCI2Y08Domc/oeTRrz0ObBcb3PkDTIUacBu?=
 =?us-ascii?Q?aAODUtSemEQJKMkfOFFQOYnd+SmPYFOWtLmOpu4waQcbCKD9SSl16cS8Yk3l?=
 =?us-ascii?Q?TbEerlV9ih+91MlBzltCbgxgo4aEYiQYXNpXStmUSeTxIc8iRXHxwjft3+hg?=
 =?us-ascii?Q?aTU1ZFAxz7WHrn96KjCgPVAeXnukeoN9CGMw0yfuHHqimILGhrs4h3hQfBVl?=
 =?us-ascii?Q?u4VlfUbtzHVS04bJ8EwQcBjPFgQjSZuzIBy9CqK+1Zdm/k50N0CZFUkoP8vs?=
 =?us-ascii?Q?XP3EmIn0MQHsJbA6vkLSnUFgj6CpAedrPqi26rBUM+gJPZV/rrswhqtBpBhm?=
 =?us-ascii?Q?x+lboWXf1f7nGP7HmyBlZNMJ2ID0myWJfPm+WhwQffd9f31H+vM3T3a55Ors?=
 =?us-ascii?Q?gQhSmHqHrfwzyPMoTJrI+/ds1BqUhKoWdsLvMEGKFS24tICUrldOUXmUjeBP?=
 =?us-ascii?Q?FQ/cFqB1KZvelYsYI8Hz5uCNe+y452vpLRIckqPjh58AfkDXRQq7A04ut2n8?=
 =?us-ascii?Q?fNqGK2s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:51:27.1084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ae67e3-ce86-4a10-6701-08dc70ce60f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6866
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

Add support to handle the userqueue protected fence signal hardware
interrupt.

Create a xarray which maps the doorbell index to the fence driver address.
This would help to retrieve the fence driver information when an userq fence
interrupt is triggered. Firmware sends the doorbell offset value and
this info is compared with the queue's mqd doorbell offset value.
If they are same, we process the userq fence interrupt.

v1:(Christian)
  - use xa_load() instead of going over all entries
  - keep the xa_lock until the fence driver process completes
  - create a separate patch to remove the MES self test function
    call.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 ++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 15 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 23 +++++++++----------
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4ca14b02668b..2d5ef2e74c71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1043,6 +1043,8 @@ struct amdgpu_device {
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
+	struct xarray			userq_xa;
+
 	/* df */
 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2d9fa3d0d4a4..fd919105a181 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3982,6 +3982,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
 
+	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
+
 	INIT_LIST_HEAD(&adev->shadow_list);
 	mutex_init(&adev->shadow_list_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 339d82d5808f..4cbc25595226 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -70,6 +70,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long flags;
 	int r;
 
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
@@ -97,6 +98,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
+	xa_lock_irqsave(&adev->userq_xa, flags);
+	__xa_store(&adev->userq_xa, userq->doorbell_index,
+		   fence_drv, GFP_KERNEL);
+	xa_unlock_irqrestore(&adev->userq_xa, flags);
+
 	userq->fence_drv = fence_drv;
 
 	return 0;
@@ -147,8 +153,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
 					 struct amdgpu_userq_fence_driver,
 					 refcount);
+	struct amdgpu_userq_fence_driver *xa_fence_drv;
 	struct amdgpu_device *adev = fence_drv->adev;
 	struct amdgpu_userq_fence *fence, *tmp;
+	struct xarray *xa = &adev->userq_xa;
+	unsigned long index;
 	struct dma_fence *f;
 
 	spin_lock(&fence_drv->fence_list_lock);
@@ -165,6 +174,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	}
 	spin_unlock(&fence_drv->fence_list_lock);
 
+	xa_lock(xa);
+	xa_for_each(xa, index, xa_fence_drv)
+		if (xa_fence_drv == fence_drv)
+			__xa_erase(xa, index);
+	xa_unlock(xa);
+
 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
 	kfree(fence_drv);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a786e25432ae..0a206f484240 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -49,6 +49,7 @@
 #include "gfx_v11_0_3.h"
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
+#include "amdgpu_userq_fence.h"
 
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
@@ -5939,25 +5940,23 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_irq_src *source,
 			     struct amdgpu_iv_entry *entry)
 {
-	int i;
+	u32 doorbell_offset = entry->src_data[0];
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
-	uint32_t mes_queue_id = entry->src_data[0];
+	int i;
 
 	DRM_DEBUG("IH: CP EOP\n");
 
-	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
-		struct amdgpu_mes_queue *queue;
+	if (adev->enable_mes && doorbell_offset) {
+		struct amdgpu_userq_fence_driver *fence_drv = NULL;
+		struct xarray *xa = &adev->userq_xa;
+		unsigned long flags;
 
-		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
+		xa_lock_irqsave(xa, flags);
 
-		spin_lock(&adev->mes.queue_id_lock);
-		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
-		if (queue) {
-			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
-			amdgpu_fence_process(queue->ring);
-		}
-		spin_unlock(&adev->mes.queue_id_lock);
+		fence_drv = xa_load(xa, doorbell_offset);
+		amdgpu_userq_fence_driver_process(fence_drv);
+		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
-- 
2.25.1

