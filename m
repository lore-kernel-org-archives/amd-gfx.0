Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E8DC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5993010F235;
	Fri, 28 Aug 2026 04:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rShXog+b";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A63D10F235
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRYf7GfCuQTnB/XQ9wKJrt/13pvKNspNZIIZzGrozg4JVBegNGZSypESLDwdxzJq26xHCiXtvkD8Aq65hx+CANvnrbsqtXAQGZ9EjrM39khP6+1fywXBYTFVYyImk1504Oq77IB6cRgaK8HdRsrlvc5a77so4oj7cwEgBaCrB1Ff6C8UKT9xH+QpmGTg2ciyNgwLcUQoptrn7/RnvnIN3dnWhxentNzahOvU5nZLMQEZR7i9ZCEy7/UPImxwFZSsP6Z3vRdS9BaDPhmRQlZiZmqt79Dp542OKzNnW8gV8Es/MXftyTbbE13mqJJ8z7JwWdWWJ4EpskCH2GpAgI7Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhfQfNM+zVE0rw9PM1NXLnabw4bm+g/AzaBXGEqM14c=;
 b=AgKmZPj4pgcztyGDD6YRkdIh8smVKj3elbhnSC/lc38EY4T2isLil+UuYsMN/Xgo+LMybXP7R5ohaVgZJZAS9syK/LK0XRzdKmlUv0Y3ivKgdKjh5biuXFVp9e+Y+X2cpY1bDpVAzQ3dFkPO4t7eCaRnZzGh3SaKrnw3n577aFSm2HUSCqkRVVRoEJFlH5HXE7HprO1y251WzwUmT4zVBjQo7ObPKRSl3jBmYPGLVL38Q3gcCR3Kim12xpvPllSRLiRp4KGTANVGZZeP/TkeQPbSEohELxZf7Cq2mZgBGyAoq80jhfvHybNYIjwjPzlp4nqU34xKfRx8U04ClO4w3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhfQfNM+zVE0rw9PM1NXLnabw4bm+g/AzaBXGEqM14c=;
 b=rShXog+bdLS5UvAO1aGCUbwmMPGvE1TKR5IK9EAiygSpvIIueQt5MhF8ah7CjIrCU00aRqSSqs1xrvBgNiGOfB8L6rfckgxVrVUm5Cssem7DegDKC7ROX6aI/jFl/DzplGEXcGGCpTrC1THcjRHT6QtKlXiFzLOtCE7chio8/t4=
Received: from BN9PR03CA0356.namprd03.prod.outlook.com (2603:10b6:408:f6::31)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 28 Aug
 2026 04:16:00 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::27) by BN9PR03CA0356.outlook.office365.com
 (2603:10b6:408:f6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Fri,
 28 Aug 2026 04:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:15:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:57 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 10/10] drm/amdgpu/mes_userqueue: add SDMA MODIFY support
Date: Fri, 28 Aug 2026 12:15:16 +0800
Message-ID: <20260828041537.3464782-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a62584f-dfc2-4668-651e-08df04bb10a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|3023799007|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: /0eYp32V/BO2fuGvShnWYwyfxkVUlZ6FOUSjC5vRjP8DNaq8XHvkc5FxiBsBG7LzT/z46NdpHg/umbyf39gVNXuTADVoigHb5vjKqdgWYBNvl0QLhSBrpQZNkuJE+GY9GmPkGtD3vv9U06wu7GOZFklKj3x0sb8HX4T8WYlKZSxgMM3WtWTUNCRz/G1sy/yh3tCYvdeKnSKiSB1wmKKXgI0AhoMsa6dKdkVLR2c8HzVRlzqo/ojiNNbdU1WTPK6O+SV6+jTySs4LzHnlizcz5aSRFbxnRuAH042E4AF+koqFXiNazrBFAV0MI2uWOTaUF3ny/JtsKoG9F9er3zFusgnsXVHVrxSSSZ2C2RWKzfDKnXDt5UjpJ1+6v4zrjKGVJLB42KO8ijIMJia/mxWvPGyohGHrbbRni2RSivE5WSD9Jok8b5ggJGfkPPg8Zt2Vd0X5+MdVaTZjT3X9wQTdbLmGQclYyKxP82eesh/1Ce4CMn9nBoJo5laeIvsakz0QoGsDF2lk4YgWlGeFRLE3aJdUF0gLiuqPl0l1jI8XuiXIgw6s/kMoZIcdJm2LspNf5kxGZi0xqbk+T+CRMgn8HorxvOUpPn8CahMnqz9f+kItY8dbrk+amYCdi2VLAkXZbhWEhZhSc7P7rEo+Zs+xQWVN4CA/aCyc12n2o0NgM9YrDMbIMHIexijK0gsijLqTjsFf0IISpNfRGT5HxZK7Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(3023799007)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z9VUBbn5p4Q3dWA1/0j/NUxcR4pIqYBegDTeZ+4HcXvMd8J7UWRuBvD1klxoWkvXJDr9Jw4a3ZCiIt8jCc8HF+yw+bpuIMOJIy4zd57bHuM8H/v+TD/Pgjx6g6Viem89E40IqK6tu/lmkHPeoY/BQSQv9m3n7Kc62/7f9QmlLpuYj/OaUmuBP6cMpcvoFxAcabSXOumaFG8bJxZ4/I2+hiKS9IY/oYAv9rvMDaz03kp4YeHJT0yn2dzDfROBetTrHm0Wg+cHaAOUkPpMaa5+jBhPS4vVIrB3uDA84eIHIbw5amchTQ3bmwLD/ow5Nw/2mpN8GJV5VM6Lvdi6QNr+y84a/ir+4zSPWHWp2eichAdD1GmZdp8GBHhkm/uV8YLammcjIFDHrLYXK5FV4IEdLxy34NwUdrn0m6j1Ux68yAHoLqn1XqVtRVnc39NTAl9U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:59.4129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a62584f-dfc2-4668-651e-08df04bb10a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952
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

Add the SDMA case to the mqd_update dispatcher, routing it through the
per-IP update_mqd callback like compute and GFX. Add a queue_percentage
field to drm_amdgpu_userq_mqd_sdma_gfx11 and plumb it through create; 0
marks the queue inactive so it is not remapped, aligning KGD SDMA user
queues with KFD (which controls activeness the same way via
update_mqd_sdma).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 54 ++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h              |  6 +++
 2 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3059224dd9ad..d9ddc0085d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -626,6 +626,13 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
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
@@ -641,6 +648,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
+		userq_props->queue_percentage = mqd_sdma_v11->queue_percentage;
 		kfree(mqd_sdma_v11);
 	}
 
@@ -708,6 +716,50 @@ static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
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
+	if (!mqd_hw_default->update_mqd) {
+		DRM_ERROR("SDMA MQD update not supported on this IP\n");
+		return -EOPNOTSUPP;
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
+
+	retval = mqd_hw_default->update_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					    userq_props,
+					    mes_userq_read_user_wptr(queue));
+
+	kfree(sdma_mqd_v11);
+	return retval;
+}
+
 static int mes_userq_gfx_mqd_update(struct amdgpu_usermode_queue *queue,
 				    struct drm_amdgpu_userq_in *args_in)
 {
@@ -804,6 +856,8 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
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

