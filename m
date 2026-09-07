Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A40BC79FA7
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 01:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B45310E26E;
	Mon,  7 Sep 2026 01:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HtTaVqj4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010070.outbound.protection.outlook.com
 [40.93.198.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1622210E26E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 01:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUKG6/2WTjqWgQ2cRApeoQJEcKOtf59IchgtKVoLWlVZy0CKBDHt4wkuwCziLxiOZJUS9A5XB0AljlUzSuQ1CsyCu0wXmaarRfT+D8NkRGr9PSGDahBFxCCNDPcREPYcQXPsGEKnjMDVXDueUgqSAv2CApdAZnbACxa9nX4fkq4sbtYXhJN2ASYkZpzM4tVbAjW01VEWbTXYKvmT67ek42+LxL0pnOf3jv6ciCtOFKuDCCURM7iC4mP8d7m4aoiDClB11BxgeAYbYvrKCkomrpdtW3MYH5r6T7QuiT+eXe4gSC+Eoi0ZYOzwx9vOdWoXtRuO9QW/rixraayOnBV6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvl2T6o8KYwVAIlVlpQLbgENRI/S4Ww06MWUwYX7dgI=;
 b=FoERyck3L5AfARJI48hwcxmsq0QnFXUreNh1mNNHvmkgVBQPN1g485tEUZoATK6m45nTPbnLeOluJPJebTTVezlqCbeEl5WFijX09Yp/EQXmMq+C6laBs/GkCPX0RWzJDrfqG8AOlu5X+zwYSb2h0cfAPPyTOWXMQ1M4nAMQPa+bzCSqvBBvX3DvzkiF2/ujoDIUp/Lg0DhduIj1tt7p3CLbjB4m4maaPgeLEZ06DAaGZFxSe1KU5Bn5n7RP9MCK+9So9WI83JObvs8ELFUa6eKjfyPlAuaP7UVH5k1HkWD00Asef4YFqJsR9wnC2uSKeJdll1GB8AVX/KpQtiG9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvl2T6o8KYwVAIlVlpQLbgENRI/S4Ww06MWUwYX7dgI=;
 b=HtTaVqj4afcM4TWj3kPZ+wHzS/DmtilqCJlZbY2Xd2x1+IskCM2B/Pjn6YJB8YrNY7UCe3OpR40IpEiNjMnY/q4tmpxnNEsdi9x9HduJD4OzKRXWyMVH89C6PQUiWaqubGOrL8395dVhpbq7ESCJMEu7ggP0rQhMgXR9m/lfW+8=
Received: from BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:46:50 +0000
Received: from BY1PEPF0002695A.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::26) by BY3PR04CA0009.outlook.office365.com
 (2603:10b6:a03:217::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 01:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695A.mail.protection.outlook.com (10.167.244.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 01:46:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:48 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 20:46:47 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 8/8] drm/amdgpu/mes_userqueue: add SDMA MODIFY support
Date: Mon, 7 Sep 2026 09:45:35 +0800
Message-ID: <20260907014629.2186163-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
References: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695A:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: abc5efa4-3cb9-4509-7177-08df0c81e20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|3023799007|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: r4pghQKQPz/vRycuD6EXMv/YKBLiPJTI0bSZjF5a6YJQtHssvJRr9eTPnDMyJt20MxLBDX8W9MgsHgNmO/98o0nFv3RPppJogSzURnxJVHgBwrS5j/s3uhth/bSYai4SVVFgBSKEgbikf+gNs9iKoESBXSXXwQt2FNnTTVZrzk+3T2jRu5pNwCBVDmyqLCNphO2mAtdviQxR9P/B7Z5bugMbDGGHo7RVHAxhB8sF6LFU2peWm2clQ05GHxGYJjUgAYXCVx0zEARxByajX836qON1QeQgPpPGnV6RhNCA0z4VHldmjpWMi+2EpNZjH/SxID0XuGTe/oGHqv8aKD+Fr4pxpQLSWFs7Q4j1o6u9+dl4AQE23+EGzPQsLivRbNfjVMvo08wEPy8iCwvjRAXCv8pgYTfZBIaP6EEtq90JFBIC6PSx2dCGL1uatiRepict10jar+ZFwldNWCRgzdCEfp8uGx6f57grKmPrjUtUQzriQgrrIkS0MqVjikq76KO6wPYWCtiLXs6/6eFHNW8Kdk1+Vi4kIFjuIOHt18CKAmoBHlK/jBnQ37TuFBedaEKXOg76Ky+GZ4qmWCc5+xyutaoWFwu0tvqkY/3G0fThzCkEEu09+6aK2eaeB1enS+n4cE2cyDnMalRpWb/fXLtaQmfodK198dktQZwNMQy+xlso4FO0O99OY1+iNBf8xAv/HhupsINwS2MMsebe1JdfAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6fUwk8MOYsFBVetyyaNCGmw/6M5RhVeL5vVkpbu3nhIjHtyobZRS5WOby8eoTjpdTMJrHu8YawQ2Ofz2KIcPBdRX3vHzYg271RKxzvvktxKVulk+oGG0/qh281pzBp0FcP6kpv77VJ37w77jgumJJcSsNN/gkV31xzHNpClaVuNxyiIs1BTn4qHVSlkCDmFkpi7ty1pmeDqFZXT5uzD5K+AFMSZ5sC2liOiS6HDXzL8mUYpzo197Z/Jh5Ce9Xy4qU6Y/KTA2N959uKeLf4OHCaLmr5tyx+QxVjpBg05r94FnU0se1wFUir14zJMU+BMphj85DUOaT2jG2p419Y3DYDFUWP9O0eAkFOwEvTYaAumAOj3ioYzPsawFTuklpSOvAR/HCaHvbi8qezxZHVy2ck7PaW3KbLyv0xL0FMR57Zn8ZBqa9TC76sw4aw5E33My
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:46:49.1388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc5efa4-3cb9-4509-7177-08df0c81e20c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
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

Add mes_userq_sdma_mqd_update() to update an SDMA queue's MQD from a
drm_amdgpu_userq_mqd_sdma_gfx11 (csa address, queue size, ring base),
re-init it in place via prop->modify, and wire it into the queue_type
dispatcher. This aligns KGD user queues with KFD's update_mqd_sdma.

v3: re-init the MQD via the mqd_prop modify flag instead of a separate
    update_mqd callback, per review.
v4: keep the context-saved wptr instead of forwarding a user_wptr, per
    review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 104 ++++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h              |  12 +++
 3 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 686c92e96025..5210ec381be7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -840,6 +840,7 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
 	prop->use_doorbell = ring->use_doorbell;
 	prop->doorbell_index = ring->doorbell_index;
 	prop->kernel_queue = true;
+	prop->modify = false;
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 82bb4369451e..5b53e6ec8897 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -479,6 +479,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	userq_props->use_doorbell = true;
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
+	userq_props->modify = false;
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
@@ -573,8 +574,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
+		if (mqd_gfx_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+			DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+			r = -EINVAL;
+			kfree(mqd_gfx_v11);
+			goto free_mqd;
+		}
+
 		userq_props->shadow_addr = mqd_gfx_v11->shadow_va;
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
+		userq_props->queue_percentage = mqd_gfx_v11->queue_percentage;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
@@ -618,6 +627,13 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
+		if (mqd_sdma_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+			DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+			r = -EINVAL;
+			kfree(mqd_sdma_v11);
+			goto free_mqd;
+		}
+
 		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
 		if (r) {
 			kfree(mqd_sdma_v11);
@@ -633,6 +649,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
+		userq_props->queue_percentage = mqd_sdma_v11->queue_percentage;
 		kfree(mqd_sdma_v11);
 	}
 
@@ -681,6 +698,85 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+static int mes_userq_sdma_mqd_update(struct amdgpu_usermode_queue *queue,
+				     struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_sdma_gfx11 *sdma_mqd_v11;
+
+	if (args_in->mqd_size != sizeof(*sdma_mqd_v11)) {
+		DRM_ERROR("Invalid SDMA IP MQD size\n");
+		return -EINVAL;
+	}
+
+	sdma_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(sdma_mqd_v11)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -ENOMEM;
+	}
+
+	if (sdma_mqd_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+		DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+		kfree(sdma_mqd_v11);
+		return -EINVAL;
+	}
+
+	userq_props->csa_addr = sdma_mqd_v11->csa_va;
+	userq_props->queue_size = args_in->queue_size;
+	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+	userq_props->queue_percentage = sdma_mqd_v11->queue_percentage;
+	userq_props->modify = true;
+
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					 userq_props);
+
+	kfree(sdma_mqd_v11);
+	return retval;
+}
+
+static int mes_userq_gfx_mqd_update(struct amdgpu_usermode_queue *queue,
+				    struct drm_amdgpu_userq_in *args_in)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd_gfx11 *gfx_mqd_v11;
+
+	if (args_in->mqd_size != sizeof(*gfx_mqd_v11)) {
+		DRM_ERROR("Invalid GFX IP MQD size\n");
+		return -EINVAL;
+	}
+
+	gfx_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(gfx_mqd_v11)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		return -ENOMEM;
+	}
+
+	if (gfx_mqd_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
+		DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
+		kfree(gfx_mqd_v11);
+		return -EINVAL;
+	}
+
+	userq_props->shadow_addr = gfx_mqd_v11->shadow_va;
+	userq_props->csa_addr = gfx_mqd_v11->csa_va;
+	userq_props->queue_size = args_in->queue_size;
+	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+	userq_props->queue_percentage = gfx_mqd_v11->queue_percentage;
+	userq_props->modify = true;
+
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					 userq_props);
+
+	kfree(gfx_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 					struct drm_amdgpu_userq_in *args_in)
 {
@@ -707,8 +803,10 @@ static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 
 	userq_props->queue_size = args_in->queue_size;
 	userq_props->hqd_base_gpu_addr = args_in->queue_va;
+	userq_props->modify = true;
 
-	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					 userq_props);
 
 free:
 	kfree(compute_mqd_v11);
@@ -723,6 +821,10 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	switch (queue->queue_type) {
 	case AMDGPU_HW_IP_COMPUTE:
 		return mes_userq_compute_mqd_update(queue, args_in);
+	case AMDGPU_HW_IP_GFX:
+		return mes_userq_gfx_mqd_update(queue, args_in);
+	case AMDGPU_HW_IP_DMA:
+		return mes_userq_sdma_mqd_update(queue, args_in);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2de47ff7c4d0..94497d1217b8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -449,6 +449,12 @@ struct drm_amdgpu_userq_mqd_gfx11 {
 	 * Use AMDGPU_INFO_IOCTL to find the exact size of the object.
 	 */
 	__u64   csa_va;
+	/**
+	 * @queue_percentage: Queue resource allocation percentage (0-100)
+	 * Defines the percentage of GPU resources allocated to this queue.
+	 * A value of 0 marks the queue inactive and it will not be mapped.
+	 */
+	__u32   queue_percentage;
 };
 
 /* GFX V11 SDMA IP specific MQD parameters */
@@ -459,6 +465,12 @@ struct drm_amdgpu_userq_mqd_sdma_gfx11 {
 	 * to get the size.
 	 */
 	__u64   csa_va;
+	/**
+	 * @queue_percentage: Queue resource allocation percentage (0-100)
+	 * Defines the percentage of GPU resources allocated to this queue.
+	 * A value of 0 marks the queue inactive and it will not be mapped.
+	 */
+	__u32   queue_percentage;
 };
 
 /* GFX V11 Compute IP specific MQD parameters */
-- 
2.49.0

