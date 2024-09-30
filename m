Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC2DCF6497
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7034410E401;
	Mon, 30 Sep 2024 12:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRSch8sk";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B034510E3FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEYSe9FlAQRPlMnIM5uDDqOOJFCv4Ee6vIDziXW2AC+a1kqyTj7uwB/B9b8BhV5q5Fi/Dp29CTK2hjyY07msUIlAvQmuV74j5WtajLJMlt9PVuU1Yipq8RGoisTWBrmM6ObNqrWIbjr9d3I9jAMexxa3eiTwYM+T4O0uE6FYbl63/DB5tYmGqPwUWyFxko1oWL9Mp/6MbwldhCHadQcF8pJNK8c/dS2x1HFF3cbmcRIWFiWJvUX306RNzylZs3ReC+9ObgCGKeJxyG7yKHF53phRDkNNm8G+imtc+AzKvWGc4yHoCBHtkMlhkmRgHV0Lhv7yFyrCjo4Llqq760q6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwjefuIcVAInWApaLd1buS/72i2CsnipLdEq+HNf/G4=;
 b=c1ffWwxLB+4Vu8WmXkofxxoFYedUUa1gtUF6lBjUtnEk1sby74sRWdD7zOeLjCMzG3sV22sW84kntl4ZFocLZ1d03/79Cc8SSM/dv+NG8fbMVI6ueXsrBANDMGBkdKWvlvUuXkI+O3r5G8AxbcU9GVMwLqSz1Q63NMMo/qBT75ql4g4ZS3j0uobKsZugBzBIrwD2rLxb8pLZE4WB89wJxGNLI7lSM5gOWoK+Cc6aHec0+mkqjYta+oh6LP914ddfsiqOEKlSLG9FhiLnrAgz2FyX6n9IkwvFxtAZzvNmJOuMBhNxLyDcl1Op1BLGLhU9JjBhUGnWRfuf6+FGb7ZKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwjefuIcVAInWApaLd1buS/72i2CsnipLdEq+HNf/G4=;
 b=gRSch8sksEBhfbffr16AkUSFU/METNmshtlylNcnkIU8FxXTnCiWdoIN3+eG2DVNS1jGd6xxAG+AX4LxYrJ58BZjOu0W4/RH9P+taUHsTYvTQQ4EKtHISY9JKNXZK+QaTR3l1eQCoXGTB0zxs6B30ceEpdxIQIUyRL4TfcOSSS8=
Received: from SA1PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:2d3::26)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 12:00:23 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::bb) by SA1PR03CA0010.outlook.office365.com
 (2603:10b6:806:2d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 12:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:00:23 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 07:00:21 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 04/09] drm/amdgpu: Enable userq fence interrupt support
Date: Mon, 30 Sep 2024 17:29:01 +0530
Message-ID: <20240930115906.191060-4-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 824c5cad-4230-45e2-d364-08dce14776d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OS9SQmFFUkJpOVc1RHBnenBEQ2E2TVZSZkNFQ1Zobm5pUFJ3cE9ZWEhTT2pD?=
 =?utf-8?B?eW00NXFpY0ZIdWdwV2JWTXdvcCswMGhjTXpidTNUYTFPU3NwbDlQemk4Q2ll?=
 =?utf-8?B?Q2NaZlJkNmNIU2VweW1WYk9KWVFqVVhQSi9YY01ENVB3UE51eTYzUVMzcWl0?=
 =?utf-8?B?Rm53Z0x2clR5bmllRHRWdkZIWlA2SDdJVlVCaDE5a3k2aVNlOFlnTFBOQ2o2?=
 =?utf-8?B?Wnkwb2lseFpBTDZ0NUFSY0JQUDJseXc5RGJHTmJtRFZCc0V4QU1hczdCWWt1?=
 =?utf-8?B?WGo2a2RqTHlBdXlYU0tvOG1LQWdvZWp5MDI4VmFUY3hubnp3bEF1NE9xTVRU?=
 =?utf-8?B?bEtPWGpLUTVoTmgwejl3dkd0WlhUZ0dvWExXbmFsMFhxajl4Sm0xQU45N2Ez?=
 =?utf-8?B?amNUVXFUcFhZK3JySjNKUk1YenRsVUdIclNvdWl5R3RseHFoZ2ZGL28zRHdi?=
 =?utf-8?B?TmxzSng5ZTZrQjUxOG5jR1M3MGdrZzhOaVZvbktTSUo1ZFRlWk5ud1g0aVhJ?=
 =?utf-8?B?a0F3VnJodGEvMzdyM1N1MHBTUVZMZ3NyQ3lQOFRNVDNlWmR6L1ZEYXhXUXNP?=
 =?utf-8?B?TzdBbFBvbTkrUjNLS0ZFTHZ5QXlFTEhOVG1YNXgyWjhYeGFJKzhaYy96dnla?=
 =?utf-8?B?Y3FpTTd1alZycXJWbFRaRWNveUIvMUxUQWVEbU5uSkd6TG5Wa1N2MlFlcnpL?=
 =?utf-8?B?WlQ4Yy94dEZZYWg1OThpYVlXenBwNmpYQ2xBNFF5R1VkZHlsd1NJV3pvaFJt?=
 =?utf-8?B?TTJETE52TmRRdDNxV04zK2ovSW5GaGp6aHNORThVWnVqektmMjB6R2dTVUVi?=
 =?utf-8?B?S1NvellIbElVSEQwZGZVR2hoSC8xc0d2VmN2UUdaVFJPV3A2NU9PMktrNGF2?=
 =?utf-8?B?SUthNXpFN3lscjh6MW9iOGFGRC8rU01LSEI3cEJPYUdSdUpLeEpWT2JkR1I2?=
 =?utf-8?B?U0xYZXhJQWtYclRnRndKZVUxR2g3eTUrbUdOSVdSaUFsdUFIdGs0TnRnTHJq?=
 =?utf-8?B?dlROQ21OV3hvUS9jSHB1a1dmZ2FCME0waUpRYVZ3R1lQMDAzSmZrM1lKTWZB?=
 =?utf-8?B?amtUV2t6NVV1WkVlbkg4UlMzUmoybUQ1VklFd3pmdVdZYVM1OVh6ejhlN05I?=
 =?utf-8?B?UzlJWTdxR1k3bEhSNFJ4aElkYVVFampBeHN2Q09wVWk1ejdRcGRqNEtFQjg4?=
 =?utf-8?B?YXdrcUxMdDA5SytCT3dCdExQRVJuWC9RVnJIUFhtUlRDUjBmeThUdzFqald1?=
 =?utf-8?B?U21hNzlYMW1qejRTQ1VsSnhvK2tRZHMyVTNkaEtDUERhbnNtNDJhUmx3eHF3?=
 =?utf-8?B?allhWnplTEdOQlNCWHZnaUdwNDRRZVlUeVdCdE9XZVhPa3JCRnZ3ZUVFTkNX?=
 =?utf-8?B?a3hJdFpuRTkyQWV3WUQ0SDYzaTdjTUFOSzBVMG5yT0xkbUNFSlJpc3VHNEEr?=
 =?utf-8?B?OEUxSjB0Y2tlTFZZWUZZemMvc1NWY0pDU0lISTh2YUYxN3Z6SzJpQnJCWGRq?=
 =?utf-8?B?ZVVnT3U0bEJBVDExMllwbzB3dVNtU1YxZkM4U0lMRjVtWEhkblU4SE45V0tz?=
 =?utf-8?B?dFpHcFNhTkVvMlFTRlUyUjA2Wk5EaWtKUlljM3BpUHpITDduSEtsUC9lSXpr?=
 =?utf-8?B?K3c1MzlSaDM5ejBxSUtPMElCVnJCcGp1V1lGYVBQVEpTbnMyaitwdDd5WTRK?=
 =?utf-8?B?ZzVuWWsxYmptK29DazdTeFZ4Y0ppbTdwMURGakR5WFdUR0did1NxVU56djcx?=
 =?utf-8?B?dzJuVWJGckRKbVlCdkFsRHBONnNyQ0lrcUdFUW5YTHhZK2F5eUV3V0IyQzlU?=
 =?utf-8?B?SGtkZXQyTERyQUk4T2VKQXZrMWQ4SVkvaHgwUUprS25STldidVRNUXN2T3Rh?=
 =?utf-8?B?Y3NsSTc4ejFIdmxzcmhzekFUYlBBN2hlQ0xJTE00d0p4VXNqeEZEMGV0aTNt?=
 =?utf-8?Q?HGK+l8BkyjE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:00:23.1311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 824c5cad-4230-45e2-d364-08dce14776d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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
index 76552eed6d86..dad26165df4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -71,6 +71,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long flags;
 	int r;
 
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
@@ -98,6 +99,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
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

