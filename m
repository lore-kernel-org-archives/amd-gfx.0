Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91044D6ED2F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F47D10E94F;
	Thu, 21 Nov 2024 13:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="No9KCAXP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D111810E94C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caqEjEsHmkmV3z+bOfTUJ/OzRzKKbX2k8k/BwfiwfSvN0E7uvrvub4+KM+od4qtjXvBmSMhLSmcRKLeBoowcNvM0cPvXtvDH5rojlr/yZWXQU4/HMAvrbQUOWT//m7ns2XJYn4aVquyl+DW2MZ9sg9byunrtjdcOv9u5DDcgDtVhlolLMbfLhqKYHlipSZm6Wn30HzUtDWgzkARVxJ73fafMwUO1val/scO8+/nnAJjMBbXMWww1ilZw4CzKthKbsAmqif/HLUF9H/6Pzj/f24KLPrxoc2pr6pBRS0qu1cHvQ69egZqOxJh7jq1ENNq+2y7s0WUeZfU7wkALzTVugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0ooIdYkBKi/p3fDvH2MyVAL8Fr5SxkpFmsSP9ebkVo=;
 b=GraRfTl46tbTO3+OGJCr4vwxAnbS+n2CwfxY10hRA4Y5McMuoBRtn80jwNSlaep5IlDI0hCAy8vJCh/4z3dNGcOvHMzObo00Di2rYZ6z2+/CqqJ8zIGlCE6A0lAhsFJv1bS4XfEMF1eGd+KGLQqTPhc2UQRkgTGmBW2XaPpvPazJ6IK3mVmhKiFFFy9HaHNxOeH7zAMolBRRR6ftvv0soIAHqdPrm2i4mjpIgEvUOjfcO2a13DzqfNRQkJaVC3WgHrqEVwPnxa1q1TM+BFiSLq69SQW2zHIOIfgsJ3uEuEuU+6WgxIc661uq/SmaaTE4MoxO0nw6GTfwyGmihOu3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0ooIdYkBKi/p3fDvH2MyVAL8Fr5SxkpFmsSP9ebkVo=;
 b=No9KCAXPce0kI4tTrfNQ4xKowQzjFXl0b6igoI/xEcH6tr9mPq8oz0xy/TsQCewZNSOtSJYOx3oDVw5xyfm246XzsgK6PTo523NbkKFXulR1aMb4IcBbtRfoUksIAvxjF02+hb/tL80bOTtTT2huRXBEHwBs4iHTBNp/t9iYBJA=
Received: from BN0PR08CA0026.namprd08.prod.outlook.com (2603:10b6:408:142::28)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 13:33:40 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::11) by BN0PR08CA0026.outlook.office365.com
 (2603:10b6:408:142::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Thu, 21 Nov 2024 13:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:33:39 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:33:38 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH 6/9] drm/amdgpu/uq: remove gfx11 specifics from UQ setup
Date: Thu, 21 Nov 2024 14:33:04 +0100
Message-ID: <20241121133307.594-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121133307.594-1-shashank.sharma@amd.com>
References: <20241121133307.594-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 999d18b1-234d-4199-6e45-08dd0a311c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YtnUa36R7wyIz9mcARvSfnGec7qUu8hBQ7U/ubaMqWmfP/2Ty5Ztwrch38QO?=
 =?us-ascii?Q?snpViDT1IqZJB8/EnLpo1N7kvy54khAkgyxqEgjEfUlyOMuoUbQt+ixbtOqu?=
 =?us-ascii?Q?yCCYYoWZCfEBuSRl6kjmodpzawilXsA7e37KTcXIaRYCfIt/2VuDJxGfuFdm?=
 =?us-ascii?Q?a0nPEFeOV1YHZGXpsQF8wVvWnFqdv3stj8lc4ATvrWVbuqoUZX4TqAiSGn9I?=
 =?us-ascii?Q?iyrQssDXGiFa5KItyz8t647dQ0iRqNOOAQ54gOAXus6cOfbiptugLJD0KX1U?=
 =?us-ascii?Q?7RtZwxmSl+ec1hJLyBxEfd5OOie9OlbJgofwzoydI2i4qes8yi96TF7PPHGK?=
 =?us-ascii?Q?r+MK+qGqMuq1yAyrg3QlDKw4kmWO4B5wGKF5zitpLqwCvqB+N2gFZ1Fd0LWG?=
 =?us-ascii?Q?4VCII3JQ9y1q1NyCB41P8XQeN+cNehYngAJxy2ke2ToRagXMpLPaOtsWGifA?=
 =?us-ascii?Q?s+62h790lb/FWt12VgmHf3iGNyfwTol8J13rJJNYWHPIV9h5GISTTzHEvZMQ?=
 =?us-ascii?Q?/IR/zKvImS4sMuqiAzilXYGge9lmym1czqmQlZy4GJCHfT+F++xV+dY7vGW4?=
 =?us-ascii?Q?Zecl9BKOIeH19SJ3LvZR3QH66wBuFeNxiysddeZPgMlHc2Y/OzwRxYvlcj9S?=
 =?us-ascii?Q?OLSfjhGZZW3ZuiwAYeUmeLS1Ni4XJVT/7ye67q0pU0HChMBQqjNHaHy5GQ3k?=
 =?us-ascii?Q?DtFC/RHrMN0eayCVtuKxEiRqcZaAPm/Stj5C3h53k1cDU7kBz5NQBihtr+YG?=
 =?us-ascii?Q?zKEcY99HWPzU5WsLBKBjug0vPIg+tH2RiTIrmJVweTHZirPTTcoTz3D3WkOY?=
 =?us-ascii?Q?/+qSapU4Et9r58F+S743qeoDEaa5jDi58qB5lgXkX6vFb3JJVCXc4WUjxdp0?=
 =?us-ascii?Q?IevCBNDFQkrxvIF9WfFzUD3F4ls/Ap7dui+7/9V4WovygN9SwhxsaDuoDgZF?=
 =?us-ascii?Q?qjAfC1lBo9x7LdGHTYw27s/PrC3fb9uKXTJCu+cB74DTRZquknt5f0c9i+kr?=
 =?us-ascii?Q?YD2/m4ZZddBrqPSZTZLODqPF/TJjDybbSaun4T+R6sh6MKWKBkiTuIABgyUL?=
 =?us-ascii?Q?hsIdROOewWBI7d1IMRIpZ01pDqSfucKO7U5Pn2hCSeDvsTvMonW2p1F62QCg?=
 =?us-ascii?Q?5IIIqDjxJYTqPCLGDKro6wXFncKSyJpDQQS1q+pDia/LnhsQpFqo/G6TCsCR?=
 =?us-ascii?Q?l5rQjmA7x61HA6WHtNIfNArSBthCHNhQijSTzXOi3opZVkSyWQx5okshNsCi?=
 =?us-ascii?Q?fBFpVYQUub55+2IXVWnTxJKKEePsguiy/qi7sZ4H3VLSJGP0mi45iXU7fqUT?=
 =?us-ascii?Q?j/aNh3BLZNcbmwMnKTRC1nhXYS9JLePOXokZRzJD1Ui/uGmNkkuBg6L5kjhD?=
 =?us-ascii?Q?3KcWoqEdty6LYeGsK28V6ToqdDZxbfc0izhfejgE5xe9yVHA5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:39.9881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999d18b1-234d-4199-6e45-08dd0a311c48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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

From: Alex Deucher <alexander.deucher@amd.com>

This can all be handled by in the IP specific mpd init
code.

V2: Removed setting of gds_va, which was removed during UAPI
    review (Shashank)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 83 ++++++++-----------
 1 file changed, 35 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index fe4efe5ba6ac..45c57a8dfd90 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -23,8 +23,6 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
-#include "v11_structs.h"
-#include "mes_v11_0.h"
 #include "mes_v11_0_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
@@ -181,52 +179,6 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 		return r;
 	}
 
-	/* Shadow, GDS and CSA objects come directly from userspace */
-	if (mqd_user->ip_type == AMDGPU_HW_IP_GFX) {
-		struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
-		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
-
-		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
-			DRM_ERROR("Invalid GFX MQD\n");
-			return -EINVAL;
-		}
-
-		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
-		if (IS_ERR(mqd_gfx_v11)) {
-			DRM_ERROR("Failed to read user MQD\n");
-			amdgpu_userqueue_destroy_object(uq_mgr, ctx);
-			return -ENOMEM;
-		}
-
-		mqd->shadow_base_lo = mqd_gfx_v11->shadow_va & 0xFFFFFFFC;
-		mqd->shadow_base_hi = upper_32_bits(mqd_gfx_v11->shadow_va);
-
-		mqd->gds_bkup_base_lo = 0;
-		mqd->gds_bkup_base_hi = 0;
-
-		mqd->fw_work_area_base_lo = mqd_gfx_v11->csa_va & 0xFFFFFFFC;
-		mqd->fw_work_area_base_hi = upper_32_bits(mqd_gfx_v11->csa_va);
-		kfree(mqd_gfx_v11);
-	} else if (mqd_user->ip_type == AMDGPU_HW_IP_DMA) {
-		struct v11_sdma_mqd *mqd = queue->mqd.cpu_ptr;
-		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
-
-		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
-			DRM_ERROR("Invalid SDMA MQD\n");
-			return -EINVAL;
-		}
-
-		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
-		if (IS_ERR(mqd_sdma_v11)) {
-			DRM_ERROR("Failed to read sdma user MQD\n");
-			amdgpu_userqueue_destroy_object(uq_mgr, ctx);
-			return -ENOMEM;
-		}
-
-		mqd->sdmax_rlcx_csa_addr_lo = mqd_sdma_v11->csa_va & 0xFFFFFFFC;
-		mqd->sdmax_rlcx_csa_addr_hi = upper_32_bits(mqd_sdma_v11->csa_va);
-	}
-
 	return 0;
 }
 
@@ -298,6 +250,41 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
 		userq_props->hqd_active = false;
 		kfree(compute_mqd);
+	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
+		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
+
+		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
+			DRM_ERROR("Invalid GFX MQD\n");
+			return -EINVAL;
+		}
+
+		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		if (IS_ERR(mqd_gfx_v11)) {
+			DRM_ERROR("Failed to read user MQD\n");
+			amdgpu_userqueue_destroy_object(uq_mgr, ctx);
+			return -ENOMEM;
+		}
+
+		userq_props->shadow_addr = mqd_gfx_v11->shadow_va;
+		userq_props->csa_addr = mqd_gfx_v11->csa_va;
+		kfree(mqd_gfx_v11);
+	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
+		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
+
+		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
+			DRM_ERROR("Invalid SDMA MQD\n");
+			return -EINVAL;
+		}
+
+		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		if (IS_ERR(mqd_sdma_v11)) {
+			DRM_ERROR("Failed to read sdma user MQD\n");
+			amdgpu_userqueue_destroy_object(uq_mgr, ctx);
+			return -ENOMEM;
+		}
+
+		userq_props->csa_addr = mqd_sdma_v11->csa_va;
+		kfree(mqd_sdma_v11);
 	}
 
 	queue->userq_prop = userq_props;
-- 
2.46.2

