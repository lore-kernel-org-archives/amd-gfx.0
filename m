Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A552C624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66FF10E5DB;
	Mon, 31 Aug 2026 05:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pj7vXE99";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899B610E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4H4sioERfbEKft6xBg6nxexFcNENYryfFZucGAvaPaz5YeutyswYnkHJVaX5pyYfO/DeEuD34q1oZNYtJTUNX24NdnX+EhFc7PXBEhtfv5UpChGL/ar9Z5j9V/MVqeScmnTBMZg9V8pY2WgshGdQu9zoGxPTqmzPNmZ2g9a0WK/0+9T4ptKr2ezoaOxRrBNdoTDBb9INVRpus70/wvBxHzP6YbFbU7SAlcXi5i9K1Uuhgo5KzwYdpOEqBVsY15ys8f63qPR6351Xdn02Mbui/sVTTf9D81wngppZSpOKqTewhPIG1HJgWNV5ap6LgG9locpzHwa754mA35bkKnvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UL5RMH/JNWivePNKdKn/H2UOTqBbBzTjlEt6THe/ss=;
 b=Wg1JJRYWtvUvb/gU/AZFWag/a8vDPZe+IdNXlFTHKO/NQ8xjtZ6d06X2TuOXU2mUAKCb0wbbiHnRFkqvwfkYsSoRf0GST+uv5WlWb/R56DDYMYG52znwcdEMiPUtjiFFI6hAWdzbbq1Ay9wEfpLKyfC8NgKx39CjtzfSemOf85NM6x4p7T7Al4JSWja+2IA9Fhm0blZdwV4hWIO/djEjOThoCI2kGJyvaUoyNktD30efyEPdjyZtDwRec0+WD8xrbmcAJ1LfVR1UVaO3F7VTcoCBinHiZ01CmDN4Ip4s/zjFgo3kzgVCh1CaFFOiy48GCqndkQFa3CNt6o+jc8hw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UL5RMH/JNWivePNKdKn/H2UOTqBbBzTjlEt6THe/ss=;
 b=pj7vXE99iDy6yadER6QVOzJaSP3HRAEPM44D2SzzDZFjBn5hViXP7l4gJkE2/sYFyewYC/bZoStt/AShY/t0VFit27sUzafcUaIzSWmAQ3rE+ZkIacwhz24XW8iFdPdFTdS29A1mP0vFVy5w0F+czG2S124dgSHZsLx4KSnh5Kw=
Received: from BN1PR12CA0008.namprd12.prod.outlook.com (2603:10b6:408:e1::13)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:31 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::ae) by BN1PR12CA0008.outlook.office365.com
 (2603:10b6:408:e1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:30 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:29 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 10/10] drm/amdgpu/mes_userqueue: add SDMA MODIFY support
Date: Mon, 31 Aug 2026 13:24:22 +0800
Message-ID: <20260831052513.1518180-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: afa5a040-e988-4a0e-e8c4-08df07204626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 5N6WtVQZEtpbQqlmUL9zqbzub5e794X6MaEmncFqxpRhfIaQ5ld6mhMTvVc3PkrkAv/YVJivZ6SAJ5VbYdxiKUwTpGf5nnAJRUqzmhpVfl6RiHpkBMokfW4byzHT11ghPJDRmPs62hOH8Ax6/1hPswflwHSgLIeMTxTuHeILeWHfIlWJVOLQGGJMo8vu9lIuqPRujRA392Bgh0xmvXPgPWYsSe177nFaU1R6QdUeKhGaGU+NH5dgi92JMAo40PfjmVr7961+eIj2tiYwmTBbhgrnjQz3ply96HPCkPiYLZdQJS0ApWvWhCrvok74YGU6Z1r0e0AdsZka7KNjDTZ+n+4mQLKoXT1I0laKpNheMTRDibTsPu0RHpfuRFykt8hYqVJ2bVQ0xZiWRP6wvzewtji3bER+CIhxpD/SS9vm13ofHqpmpMBzaMz/JLYZ7WchmMBKeqp5n6b7Az9CyIer2J/qFf3NBs278z15rvqNg+XQTcGEQ8FUiObOLIkT+3BBgIc7XHrIOq4jHfZNwGRLYO0yj2CL1dRa3XUPBmU1E085FEgpq8Hug0Lcon/Hu3S5w9oEtD+ZrNVU00Pyxi04WHoJAntmNEHkX9u65QQjKLkya2wZgE7pShiTJyv80PEa41B4OWJdL/6dgentjF0x2tj9e4gRfMfHH6vWz4hWsAEEm16CZfCMY1WU5UwmNF0VvBOTfo50RfZ7gwqbnIpCOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LnNlcBXIY+Twa6joSQpJWe7gSDvdJJcbKcNoQLOHlM8eX+F/3a1VUig3FYQaJUjJqJwNoCwDOfeyRQ8tHC0EwtogIRJPv1qF2dqo8vANsjZGWd5w/sNivC/sD3kD2PmVJp/4Bq552UdGEZHl2Fs9P3R1Y39Bn/0bQHZJ2CGa40RKqigESE51mmfnu1NcWut+EUZyl37KXDuoN5gi8ARtfPq9lGa3pfFbj18qrP7uPr9qLXVHCaCy/8eQfFiWf77gJA9P6BlRAoYP0uw1YUaqBlsC7XTB7Ofp0XrWVKPlY/6wp9P867ouWW/ZB7o2t03CrFskuKaRfdPJTn391a0LBUgTVgyrvdHbcKExu1HGR954Y5t7AUnMR9wlcTuCg7Zmcx6ZBmIHcGQjs5310whe9+YTu6HfGY0JY2b2ZdBoOel2QdsbPqpTrZzpvWi1Tnxm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:30.6789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa5a040-e988-4a0e-e8c4-08df07204626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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
re-init it in place via prop->modify + prop->user_wptr, and wire it into
the queue_type dispatcher. This aligns KGD user queues with KFD's
update_mqd_sdma.

v3: re-init the MQD via the mqd_prop modify flag instead of a separate
    update_mqd callback, per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 50 ++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h              |  6 +++
 2 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 99da719ecffb..6bc6984b8e95 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -627,6 +627,13 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
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
@@ -642,6 +649,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
+		userq_props->queue_percentage = mqd_sdma_v11->queue_percentage;
 		kfree(mqd_sdma_v11);
 	}
 
@@ -704,6 +712,46 @@ static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
 	return user_wptr;
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
+	userq_props->user_wptr = mes_userq_read_user_wptr(queue);
+
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					 userq_props);
+
+	kfree(sdma_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_gfx_mqd_update(struct amdgpu_usermode_queue *queue,
 				    struct drm_amdgpu_userq_in *args_in)
 {
@@ -792,6 +840,8 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 		return mes_userq_compute_mqd_update(queue, args_in);
 	case AMDGPU_HW_IP_GFX:
 		return mes_userq_gfx_mqd_update(queue, args_in);
+	case AMDGPU_HW_IP_DMA:
+		return mes_userq_sdma_mqd_update(queue, args_in);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index da2016f42a2e..94497d1217b8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -465,6 +465,12 @@ struct drm_amdgpu_userq_mqd_sdma_gfx11 {
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

