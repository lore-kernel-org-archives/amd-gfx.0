Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7D7CA100D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Aug 2024 18:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0150910EAD7;
	Fri, 30 Aug 2024 18:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i9ypMjoL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3C610EAD4
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Aug 2024 18:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+umrhpyRIkMwZhvmBCEhuw4f/VO+PmBv7TzL924LH9+k8CxsSQOxsLGig43s1EM9jro+RPu54pUkFoHz/F6HTXBE83690v/iWOkCN3sQ5Ji85dMHy2twxtY5LHl4jrXC6SZtwlGneUS18+R+T2OFyVqFi56wQr9ZoTLz81M8/LKi/AguLizkdKT1zHLRS0v5wWvsUZNeugINMXlTmThcnFetCJtoB+vsACcfTFdlsFwiGlxgFTBvIWp5y73yZ86WZFcwOX/D1Vw1qD0VaPSEDbR7iufbHsGmqKI4kf0B10ri426wvpwEYE/ddQaOBZhPmLln7TrEBTXCXT9kpxx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flOHzH5Y5byDsuF7LNbiiaj630OWVOwSx+zC1XpYHeY=;
 b=Y+1Dp0g022KPvF8h6P9SHxbELvHR87zcqvDSv/8AwomVjhAsYdcXgOfwK7CeuY3uD6DrChVT10xNWw+fEkWYZBmVGdekyS2/vrQDNmIUx5SkRZEhgjmDYC/0AT4ymZp9CQEAWkYiDiAjHCK1PJ5bvEKRXYT2LkSdcDf203aSKVGrrHd5RZlrf1ofp0vgr6O2XxZexGU5qnsB/hyZpjkMr5uETT93UJo9hdaMu7u48mg+VmmNWtCc/VAMUFgbowvKiDEDPRN50TnPkW1QYykk/W1M8LQuc3ginc2IYrZTBPsJ0wE6bALN0MFDpxmQaNCyfEweZv+LBlKVp6aO1lkNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flOHzH5Y5byDsuF7LNbiiaj630OWVOwSx+zC1XpYHeY=;
 b=i9ypMjoLbwbrU2uzdWluHtJpGwI3nO9LXE9uS1C+aN0YUM03VVi8RAlMA0WMtlBhg5sEqn2e+Jnb5uMETcSYqUNEevDjwvh7DsAvmQXcvnkSFslaVY0UYBVpMsia/CpVKbBKvILqhz5sbP7lOwlwV74BkTnvrwKrTYrNt7T01Jg=
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:44:09 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::72) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21 via Frontend
 Transport; Fri, 30 Aug 2024 18:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 18:44:08 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 13:44:02 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: Enable userq fence interrupt support
Date: Sat, 31 Aug 2024 00:13:20 +0530
Message-ID: <20240830184322.1238767-4-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: a3278501-6fe1-49af-5aea-08dcc923bbc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+NsvQQgTf1rJ20m9OGKuczo4tJycLnGS/Vje2KxdfiqRlOjNQiT6GVkBsIK4?=
 =?us-ascii?Q?tptdHjm2skSrkJZ6KTs3ti5NSYNvUWXkSbxVq70wGQshTjGt7Ik+x82T37Hq?=
 =?us-ascii?Q?8ukpsYde3rMUlIgDAvCXCEChOQ6QVNJoAgX0QUHSBOlwMs2yuJA4VDUwtkY/?=
 =?us-ascii?Q?C42YYENC/Aw2lhvEY2EVV69oDgnjK1nDUlLspqu0H1wpkzpa84+LieB60eZ5?=
 =?us-ascii?Q?kR9MbE9QQni/TsGB2kmflPoHPoOW2fSbI6ZavjhjN2H5NUfkbeg9ah3eTnna?=
 =?us-ascii?Q?2YfwPAH7nIjb2JatSGQ37s7/EBMnXPG98nrzuA/GFm2mAMpHtSsj9QNmYeTz?=
 =?us-ascii?Q?0O71XuDlI2W8qeVRZKMPJRvwigqRu9jAb/7ZL5s9DI8TbEUkyllLXbC34E0H?=
 =?us-ascii?Q?EqtnfHi6MEdr2og3F+Jj3dOrTtjb5vffZ+9B6uOIDauDAgX1goAaTovpL9kk?=
 =?us-ascii?Q?cIR2yjZE532eZwEN1RhrU5uvAyDXxhgWb72QGmUXx6wfbxlZXs5cn9X0DDe+?=
 =?us-ascii?Q?Z0QXrJucor5QQ64ll78lqN6f0x4rsu69O/3HfcMlkgoAUvahnT0PTerSQQod?=
 =?us-ascii?Q?lhBoVWh5+mBaOiBRvTTfUlH8aFZicV8TdxdM5pbo5UjUAqieIjgTMvMNzh41?=
 =?us-ascii?Q?Wl00aO9SajcteG7Fm/O3T2TVLCAUObE6gzfvSDh8QCLFfQv47JePEImILaK3?=
 =?us-ascii?Q?LTpMPW9TA1gQIuHecY73pts7nHDz8m2Iz/6CQvnzMAzSvzOlnolnZyXxxz+q?=
 =?us-ascii?Q?u5XJ+jbrBgU5a4gR6wyEjKyS9S7Imn2P8CJ1swLvqbIEVyEDqdxstQU5nx+0?=
 =?us-ascii?Q?SbFPhKtAAGHbNnvPhC3rvWDxBINsVOEKej7F23ehYyOUMPkmDsfAJ996I3T6?=
 =?us-ascii?Q?9R8FCrm/qA1bUSn9xuiAwneNzhHNpuSHfzMK+/NKKBwi2yCZ0GZ8Sryyrl+p?=
 =?us-ascii?Q?p4oqrsnn7JrGR8PCXtP0wXTvftk/e0LRyYizm+J/kV04rYpXba9ANaHf+gCq?=
 =?us-ascii?Q?79inFOfzOqEXTN2QbCn0A6Om444ng8iF4a1OzwfGAzm3bTs27o+L+jJtZQEL?=
 =?us-ascii?Q?ihcMVVr3AmnD087PfXnwYWkWV8M1XyD6a35zjwg4YV775soEZCWpUZJ6F3uZ?=
 =?us-ascii?Q?MCH8hM4t6lpTurgi2RK5VFy+4eKZaWpVZWa3XKrjv9JweXq/xBLvbpdy2HPj?=
 =?us-ascii?Q?xD0fPQcQ0BUQGRw3VZ54cVQjz5Lxnr3ZAcFIO60BB1rg4S9g2ZHLn48P9gDf?=
 =?us-ascii?Q?mlzDL23pOJjik2KnjBAkL8H7jxNTYPsKyL5YX3VUgFT2PxYHtOo4h5257gNP?=
 =?us-ascii?Q?dIPnsZcnrCQP2/1ditn1ajyVXvUK5aflT3gz9j2UF1bUUUQQAs05DRGn0ymE?=
 =?us-ascii?Q?7kM3I/v2AjhCtusjOpimCLaZy0iGGXMmQ22oEc9Ke0ZNxx4L7ws/lmV1P9QN?=
 =?us-ascii?Q?jRwwS+6P6Cw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:44:08.5726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3278501-6fe1-49af-5aea-08dcc923bbc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

v1:(Christian):
  - use xa_load to extract the fence driver.
  - move the amdgpu_userq_fence_driver_process call within the xa_lock
    as there is a chance that fence_drv might be freed.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 ++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 25 +++++++++----------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 94bdb5fa6ebc..2da895f91e4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3967,6 +3967,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
 
+	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
+
 	INIT_LIST_HEAD(&adev->shadow_list);
 	mutex_init(&adev->shadow_list_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 8a3b5374cc1a..4c3c8901e155 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 508e0acebb0d..68f908cafb6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -50,6 +50,7 @@
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
 #include "mes_v11_0_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
@@ -5865,25 +5866,23 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
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
-
-		spin_lock(&adev->mes.queue_id_lock);
-		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
-		if (queue) {
-			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
-			amdgpu_fence_process(queue->ring);
-		}
-		spin_unlock(&adev->mes.queue_id_lock);
+		xa_lock_irqsave(xa, flags);
+		fence_drv = xa_load(xa, doorbell_offset);
+		if (fence_drv)
+			amdgpu_userq_fence_driver_process(fence_drv);
+		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
-- 
2.34.1

