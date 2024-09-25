Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C49ACCF9EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B56810E863;
	Wed, 25 Sep 2024 20:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zhz0uAFZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E69210E85B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9zLe0rKw5VsjwfjNki9BC4S06UUPxSs/d8pj3wazIYu9uTfl1cYj7yFI/vuadh+yoG0tDTGS174HlCP1l8Zd9Lh0TGAvsH3StjxzCKnllFa/1ds8tN1KCasrFb4cxy9lPEvIrvLfC2Xs0x5NqroPlC1QZPsCfROm8KeksfVQ3hCMI0ZbtXBoCBqYjcgL67CImVVHoKwPBAfs2pFWLOulPKPUVLB9GHnIt4qpa5t9ZOXaaw2k0gEUPpkFMgKILtESeJlQSOWgeHmeIy0jeXxPzoG5G7rmaswxkjEv3iNBMfMBKE3PEDNqQbG6rsOqPYdYh3Vtaa4fVa6ZrZ3kbpKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCfIK1Ja79N4gRuxf80Acg7z/rfrUOWCvZk09lLCcDM=;
 b=nHUHm7FND2pQuRAOc4TUxhNQXXSpwFMzsrANpVGdi7PDDDzGGromfoXvBoMgfj5GdcdkvGEbfZLkolIH0BoeGxojUim6QSJ/X9MqgNCqXiE/J7/sGUHjaPWKMjeZTlzyltfNw7P7TNZVKaYBn0wCN9XM10wTzWUVZqCtA7MiYO0m3VL1OkSybRadhy8hW+x24yx9E5SAe3q4K/+Qlfq6Ap/j5lVBS2bLyVh2WZSjLitaf0Y/zIdWqup8K8ZEdZtIK3bMUcGAplQi0JNU3gyuIL++dbt2tRFDf6YVkTN0aZTlJ5nicRYiw3PAEXV9CRUFiUGzLMyLc2oP78MrTrYqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCfIK1Ja79N4gRuxf80Acg7z/rfrUOWCvZk09lLCcDM=;
 b=zhz0uAFZ5/KTx6+qX0CI9SlnFECBDVdNgwQ14Y/IIT8g+xuWfk60iVSIJoLwrmLnCTtWDomNz/ah7wS01gqaybwa1/qU1ZdCwLMfQ6Q6qUGBG6EcQqozO1k7r4763WiyY9ZWfeYw5bZDLXMPl0oTBEFOEecUAWcZvsqIdG+2sTc=
Received: from SJ0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:a03:2ef::19)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Wed, 25 Sep 2024 20:00:07 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::cb) by SJ0PR03CA0194.outlook.office365.com
 (2603:10b6:a03:2ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Wed, 25 Sep 2024 20:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 20:00:07 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 15:00:05 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 04/08] drm/amdgpu: Enable userq fence interrupt support
Date: Thu, 26 Sep 2024 01:29:24 +0530
Message-ID: <20240925195928.142001-4-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: e44862b4-88ba-4fc9-3697-08dcdd9ca78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFl6WFN6ZXZ4RE9lTFh6N1dhUjUyUjlnZnFRRTZ2YmtoOXVxemUyUStvdzlj?=
 =?utf-8?B?YVZTYWNGQlZjOHpPcWRvNzQ1ZGhEY3E5TnhaVE5zaWtZTnhNTmVxbVllUFh1?=
 =?utf-8?B?amJMaUM0WUtGdUxwc2pHMHlTQlJnZUdsK1BLckk1QmJuYVU4UytVVFlMdEQ2?=
 =?utf-8?B?R0F3VjdaUXRURzFTZ1BjTTF3dVZ6S0krOS8rRUZzanJjNTRhVWFNbGtRTEZK?=
 =?utf-8?B?dnhicFphbXI0SE8zMG5obCtnTTk0bmNObWtUVHJiYis1eUF5N3d5UTM0Q3dm?=
 =?utf-8?B?ZVRZbGVCZWRmaWEwWnRrdWp6S1VDQitsZ3lLd2ZlQTNQQkMwZVEwY1B4elIw?=
 =?utf-8?B?OHJPWmNEekVqZHBMbG5sdlJOZ0RMWExIRlYwYkxMM2Fxa2g3eTFOZUN3OGM5?=
 =?utf-8?B?T1lSdnJyVFVWcGhiR0l2SzBFTzhzaTVFZWltWmo2QjE3aHdDRUVwVW9hbnVz?=
 =?utf-8?B?OGlsakc1eThGQnptbWdtQVRQZGJ0Z0NTdWpXelQrU25TWVpqTVI4QU5mMVcz?=
 =?utf-8?B?dmJablZYclV2ckRYY2ZFanNsSjlabWdEZ2JadUpwcDdFeERTYzQrKzZSbFNY?=
 =?utf-8?B?RndXQWRKOGxiWThFOGllUzdYWC9QdkNSV0l4MnNWNEdXbmh4N0tOV09hVUs3?=
 =?utf-8?B?dGFybDZQRGd3WGJudEZwcWRkaGVKOXUyYThTM2N5SEQ0V3paWitzUWc3bVhJ?=
 =?utf-8?B?elE2enJQV0VNa2ZoYmgwa3dvbFVaTmN3alViOVN2dHgxWkdIU0ovS0JvZ2lP?=
 =?utf-8?B?YWZ4UVVqbTd6bFliUy9QMVBWOUtxNWoyMjliek9abVJoalpIRE96Rm9xbEJ2?=
 =?utf-8?B?ekZlOWpPTW03bGlXT2t0c3grM2VQVUhTT1gwb3RBZDlBSERKTWdOa0dpVWIy?=
 =?utf-8?B?NmFoMlh1RFFYRENPazg3YXhqdTM0am5YaTV0ajRLY0d4eXBTNC9EN2NTUW5s?=
 =?utf-8?B?M2pETG5mQjl2VFI4MkIyT094QVJaakFmMmVIckdsQkFtNkI4c1ZOaEF0SDMz?=
 =?utf-8?B?OVE2V0M2aGluUk8xSkF3SjlYbmozLzlDanJ4UWRCWmpnZGlVWko4bHRCaTdI?=
 =?utf-8?B?YjJ0b3gzT213N210WTZ0b3YrbmRKSDllOVdlNkhQTFMwRE1TSldWOEQrMUJn?=
 =?utf-8?B?WGdia1J4US9iLzZZVlFWTVViMEY3TDl0UHhRNkhkSDRZVzFmM25nK0xvRG9K?=
 =?utf-8?B?YUtUUS9LcTNrdnZxZlg4TDJROXJHbld2R1VTUnVRS1J2UE85UktoT3B5dWdH?=
 =?utf-8?B?dDR2QWtrOEVlem9pdWJZdkpFbHZNU0g3Z3ZmWm9KcFJqRm5TdUlSRVVIRXZz?=
 =?utf-8?B?Qyt3YTJPbUV3WkRYSWNSMlEvcmU5N0VUQ1dFVU42ajJpT3ZrYVJWdEduTlJI?=
 =?utf-8?B?WUpTcnJ5T2xUazFLamRuVTdmMlZEQ0NBSVNyRHBLL1d3Q2VoWnQ2cEI4ZWho?=
 =?utf-8?B?SjNUSU1XMFQvQ2xHZ1B4ajZpbmgwV1dHRUVVak51SGpUUEZpSW12anpsRmY2?=
 =?utf-8?B?VDV2Y0RjUjBkcWhaU0JNeElJMTI1cGdoSjV6RUNEbFVoZ0tFRVh1RTZickcv?=
 =?utf-8?B?L1IraTg3d1M4ZEwwaFE4MmNvdDhITW5maTVWYTgvdDZBb0hKRWt1SWlXQVBG?=
 =?utf-8?B?UWppc2dweUg1WFBwQklyRXgrdXZKazIrZ0U0T0Nad2dDSzl2aXcvOVpiK1Jw?=
 =?utf-8?B?WDNwVTNVV3pJSmdVNXJCaFJjZ1ZLQ01TYjNkQmZRZE1JUmV5ZUpvS0gwTDI2?=
 =?utf-8?B?K2V3NXBOamNxVDBSV0xwSWR2Ym56a3hDRkxibUo1b3VmL0hHMEpLV3FVR0NU?=
 =?utf-8?Q?FB57FKV8nygGmR3f59bL62RkSPPObRJiDv2ns=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:00:07.4319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44862b4-88ba-4fc9-3697-08dcdd9ca78a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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
Acked-by: Christian König <christian.koenig@amd.com>
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
index 2465ca307644..f1689a8b5723 100644
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

