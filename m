Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E2FD6ED29
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E590A10E938;
	Thu, 21 Nov 2024 13:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2U6Ni/hQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCA210E937
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItsPmUJZ6FPuEZovSTIYO+6SL9PIny9CNiBES1iZv5VOg76pfN5FrQrOZCexSGdVpGwxZnr+4RSylPytEo0dKfvKgQz4HPb0F90c2CYUJVLmdtF6iTPS3LbaLSwU8kNJ+23Jf9R7YObHKKfD/V7Uc9AqB7jqGQ6uUsKyMg6YwW8TiJiLQx8cuYNsSX4VS+S4GkLHP+bPz6Sk5pyYvPPEjASbLohnU9bR53lYTZ8RRjjPjG5NJLlwzDZ9xA4mthkH/AdauyWK+IrCoNnHQx/QwNKGqnzeHjD8NKmP6TgNqnUIxSH/pBESLqEfkwgBpkgWzlxrf1N5LCCjJWK2MtNlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0ooIdYkBKi/p3fDvH2MyVAL8Fr5SxkpFmsSP9ebkVo=;
 b=zTdlD3UunWRpAfcO4KeQ1TLuwesI8U9SW7KpoDDLmjS90aPol9kxfgcnLOQqLHuVaNdlXsYGAgoXz3aUBuDY4/BSOMHpCn3pBmtwrDtcplW87NrPaKwxeitQE7kUE5dZRNdvbHkW9s4smVvpchxsNolhaQZwmG/07yaUM0BwJjpjPggIdM89NXbDc0zCmpXaD1LqWcCCw/EK4/j8bsuhz2wYFiWFOoFAnk1us3HydtUYT1/8bClKRleoFB2EYtzYfdRr3V241CYl+LZ8RyLJNehqR8DS2khN7Yq5R+8sWDTdjVUChyjkYtR8CInCEVmzF3Nq69y9kg7SiEZ4RI0dEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0ooIdYkBKi/p3fDvH2MyVAL8Fr5SxkpFmsSP9ebkVo=;
 b=2U6Ni/hQ5ZS66PIeeoBHPNKL/tIt/+KUwdqsy9YIytxqdqZdQtuaGZ5GnAeyzLTMOKndOh59x2BpWJewEZM37obg5izAAWMgJG4VD8b8lYOjj5qeBYI8VNY/BtX7J08n8SUkAFwKPEiZO/1umBptV7sNs52joCOu/zQc1IcFk0E=
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Thu, 21 Nov
 2024 13:11:34 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::7) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:33 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:27 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH 6/9] drm/amdgpu/uq: remove gfx11 specifics from UQ setup
Date: Thu, 21 Nov 2024 14:10:52 +0100
Message-ID: <20241121131055.535-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121131055.535-1-shashank.sharma@amd.com>
References: <20241121131055.535-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf3a737-fe41-44a9-61cb-08dd0a2e05a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UtQMbP+CJRsuyRvv+9XOj0butGjm7Zy6jZRhN1GkImz5d0ZzSRqzKfARC9Ww?=
 =?us-ascii?Q?zDd5Adjp7IBMsv01ybiPutaQ1j+bq4Aq3COoxCzZf2EXktBzHOwVUhz1daRL?=
 =?us-ascii?Q?XnfiRbewGUh6buld63sngp/GumA+swc+F7uxkCF+mmSHgq3NddrMC6wlIM7/?=
 =?us-ascii?Q?WlIJFUkhG2lMLe/44o/D7FiAvNMNm2+qxzGTnPM/Fh6Wvy8BiPPMSJ/YouNf?=
 =?us-ascii?Q?kcVOJhFxDMRmXpP+xUKGL0oBA7CyIx7VMvPaO8ZTlC3yuHW4HkkPWoMFz2uh?=
 =?us-ascii?Q?odr6DVmDDqi/BIaqRynmN0z5Hk2YFRDjtj8VY8x7i7xJkVYS7ltXVYS+tpOF?=
 =?us-ascii?Q?0CCQLrgr5NCd/DuCutOPko1lXq4x5279zn4OTnFNazIpl+NWgahQopmsij24?=
 =?us-ascii?Q?0ssIOSMTCLO/+C5ggjKpm1r4yU3CDJTigqlCZZ+wLAtCrBbjaNJLYNRghoDj?=
 =?us-ascii?Q?X7RIt8pDtVxjD8d8O/t2Va4ldYrbqyYFGuWaQf7c00HWCtbPM75h0aXYQMyB?=
 =?us-ascii?Q?H9g3g2mPzwtaptJRVAEpVy9mW9XXZkKaQn8YbZ85X/uQzWyr9/IzEonQ4ggi?=
 =?us-ascii?Q?5z+c1DWSYaedp/PSlc4q6BXzSjEKTtOAavNviAXtaV8/1RLKdR/84XaALcAi?=
 =?us-ascii?Q?D5+KZfTceNH1iTEWY40AGDoW66dOoh5sDdbtAZPdn6waepXCNDs1GPR9SYd1?=
 =?us-ascii?Q?9NMrYAvt9MQJshQXT6MmuzZNZrcmy39iLmc7VJWgkFflYjfc+Fu73Meq+Up5?=
 =?us-ascii?Q?dQRQiLC4J9rP+7V1Rj31InGKawTGQ9ts7JjdRMoveHXZwhQdmKBr3357bLOy?=
 =?us-ascii?Q?TApA5Z76iNfBfVPM/RgHpBWzYeKpniWFXx9E3X0/Emz8GFcjaE3T52pIHeaG?=
 =?us-ascii?Q?R0UC+aY0y5WCLXOpXSrD0uLULrL0k9ZHN+K5LXBqj9ka3TxLM2v/HtyKhCq7?=
 =?us-ascii?Q?TWEL9WxNiHDwa0JUaeGRCshk5NQjZJgXfb7mwCG/4VR4beS7CV1oHzaIBIhf?=
 =?us-ascii?Q?cYI1AS+3/Mv+Q5kGPTxEbTEOH1ESUnQxYD87cfczuy3mq9GDq0wpdk2qcX/k?=
 =?us-ascii?Q?YQYXWGDcViN/2RG5Cm+L0c7vzXmuend5lE4eVibSBb2c3aN1R1L2FkDpu4FM?=
 =?us-ascii?Q?KwE4d8YZBHDoWFYIg1jACM1b4ez5cL4yMPgBebSdOl9hSCfJrDRWCjrzwaED?=
 =?us-ascii?Q?uGhGsq6O4Vk9ajLMwJCXGSQQ2H3t1X4svAGVbMhu42LbOpGp05WEzSuni0C7?=
 =?us-ascii?Q?YcGomHxfXEG9/y3JKwk5DnFGfToqmKtQs+LY158v/k1SdGy+vUw5kmVcE9Ho?=
 =?us-ascii?Q?w72xJLNIa97wUq5BTkLjaoxQgkfrE/oY2XlqQum5rnvxcPDaaXqfVMe9Bc5h?=
 =?us-ascii?Q?u06zacP7gN33j4wz05JCm34Mfnj446uvF1yoBwWIOduCA9GJpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:33.4660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf3a737-fe41-44a9-61cb-08dd0a2e05a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
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

