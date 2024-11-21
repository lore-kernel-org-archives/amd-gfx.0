Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2BCD6ED31
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CFBB10E955;
	Thu, 21 Nov 2024 13:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w4Gu/53+";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF7410E954
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDc/5vfz4Eb1KTFWSXuhPdJLjEXVT1rRSisHhvQKAWBDgbDs1qovD6RpbnV5XwooN2oEcgaU/IQBEO9nU/0QhvPsBAQBeJhNfcjVoQObJyParDBnUQoW+02H4kz2s7qLWCid3GUdWCdYw65/cLPZja2mAtVnprc5m6Ou84jqmg9butaJl63XafefyPtZwl20KtJMfYlJmyx01ERh69Kxrr79xHnMwvz7cxBq1iOXpyHC5mVg11R9G19WGVfdYXJulMzjRTpdDs+2Jjhpe5kBUzsBgu8zrp2BkGBAbQKQzEbYMzSNss3P+ITj94RI/RAywIWcyz98ac5UHKMZWWxndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dHih005IReCvJidmSe2ycWtaHDf0uQHN9ktrrdmzWM=;
 b=OH9MZdSfPddHLUPkd6mZbMbLzbCc9AYrxxfnJhtXk4K9hLGO1J46i0FYa2DMXKmCZzhMSliqycsC27QlSm4R2a1deqHUSsBVyFhM+W0/rvfnrRVwRHTVoWgiPgn7rnMgGRlRxH8pjbf2E/VP2uHIzat+FHOjvN6kP5jJzH/eBeM++b59Zx6BNErmqlobcVbiHvOU14f7fFVMO4GPkRGLHKkjuQak92cs+gw41eRadrc4TWWJoeuTTzW1PWnA5UnPg5Wz2lzdYzEq0lwlTjD0/v4stbQQRF7d2ccqKjaYtN+Zvyy014CBO+Zgv+wuBAcSXHC9FmtIHpR76CIb/da/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dHih005IReCvJidmSe2ycWtaHDf0uQHN9ktrrdmzWM=;
 b=w4Gu/53++SRrcQPr6eSK2izChjjj5IRRrCyhUf/6yFdp5QcOH/PVcmjRO7Y2LuCyqL4bCsbgb8+nVGi6srT/mPyCSi4kg1G9F8OI8IeOR4bsVXUSamqw3fmgucogf1KAF28zeAf4IR3k60NFHyHZOcv4zSjPUGVBPdVcFXWh9KM=
Received: from BN0PR04CA0146.namprd04.prod.outlook.com (2603:10b6:408:ed::31)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 13:33:42 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::30) by BN0PR04CA0146.outlook.office365.com
 (2603:10b6:408:ed::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Thu, 21 Nov 2024 13:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:33:42 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:33:39 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/uq: make MES UQ setup generic
Date: Thu, 21 Nov 2024 14:33:05 +0100
Message-ID: <20241121133307.594-8-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: abda67d6-71bc-4b79-4415-08dd0a311d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jFo4tJg6NVwS/D/DU9s+MkpmMEzr6kYyFxg7m1Ex+kR0NDTMwCkTEoRYCvQS?=
 =?us-ascii?Q?4Fjb5Z2wGr77+uxspeseAcNkJthNoBmVgwZxVi5cmGsfAlkuUF3H7SisHABb?=
 =?us-ascii?Q?bBsV0LrTb44O6Jhdo+5lO5biLtR6/zIVEyX3iI9tg5N/+b6oEbQfG1Q2JbyF?=
 =?us-ascii?Q?jTQh4cTmlYF7YDnyUr5TPUKQTtUT/WsV2I7qpZAO9zx+09xUAXGzDNU+UYzp?=
 =?us-ascii?Q?MtZbo2lQTNc7xsgynMuX8MPCLydas6Q+1/g5b3quiy1vBVfy72kEFkyoP6lI?=
 =?us-ascii?Q?bfXpuX601CFF6nxouHPhGMqRtG/JYLD0cDg0S+qYaisdIHDx2V+ta9SVPn19?=
 =?us-ascii?Q?XlUeD4wrILR25ETgTRdyBTYwzvTljjFUxjLoM5VpYyeEZONuNkE1gl3+IQSC?=
 =?us-ascii?Q?6oEtq4txIBqb+HEZKjr5WT5OndyzoH2q1FBKY8CcmiueFHj0DlyRnfX05qMv?=
 =?us-ascii?Q?ioONKfAHHM7eR8m2FQOCwOgA3UXZTBN8LogKm25jXVFTWeX0FMJabnNRo15n?=
 =?us-ascii?Q?ZpPTCD4ZynYdX9vITyKJobV2w4SOIHYsPLODIerFThKw4hjNZgEtaIPB2ZjE?=
 =?us-ascii?Q?KUM71u2sZVR0VFZFMTTd7rIwKQIH7reGw3/1Cf5KQ8ue1a5Fk0sBx50XBrsi?=
 =?us-ascii?Q?34na8kCaNx6tWkYCICl+4Ls7nh51Ttm0yCspei7HgMN4oaXFIHL1IqciMvp8?=
 =?us-ascii?Q?XuMZhF332gXBlHd7yjqz+7qWn6MVU/17e/Gkcf1XkHbrb7NWdNG3I3b+O7bu?=
 =?us-ascii?Q?uLJjt2UiBBR7O8fI/JkIfcINeS/eDvfgR5EvYycQ7yqE9Sa0x6zn9C9m4zPu?=
 =?us-ascii?Q?R9ryYe2aH1bNjVVOhHKJ/0uOkJU2X32nrvyU4NYmV75wLNQ+HVteza8Haog0?=
 =?us-ascii?Q?k90goSkqBNqxb/Vb9JStNinsgGgRozTdqehOH0+uiwiCmVbjOSW1ec7ku6Kb?=
 =?us-ascii?Q?KEc7H98fatitMZdli3DXlyw4yIGHu/RVJFwWOv6kbdwQtnB0EPzr7wqhspIA?=
 =?us-ascii?Q?NBxzbtV7/972HMPIoKpLhtuJh/6mD2P+JgZ4EYbXJJ2qfl0KMyWjIv+xyIea?=
 =?us-ascii?Q?0woct81g0TZ97dMJmUi4yobCOLuIokHDdBmpkT+3/XbypeYZI1DqfKmjRg1h?=
 =?us-ascii?Q?2SKGUUtH6QMieIMtRO/JiX76rRxTUYVAOYIWbnTb5Q+MG3yaP7ctBJlhSmt9?=
 =?us-ascii?Q?j97ELQozkJ9kIMmvUUx5UMrb9zudOAIRL1udl8ioEWgP5gPWUlMLflYvmM8h?=
 =?us-ascii?Q?SqOvmanP4zQpeN09uZfPdN42Uu/KhCSPkWHU+PDa5ReBRhAPIiXH0R8/FMRh?=
 =?us-ascii?Q?pZ74AsHkSidwAW0FvUdbQM/efeU60bVtBvwUl/LqnRSXQ+VbcQVXp91qGUHV?=
 =?us-ascii?Q?PR+jtngolx0+u5RAzcE6Phmo8494Ux6jyw1JyEYH/X70g50kKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:42.1364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abda67d6-71bc-4b79-4415-08dd0a311d90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
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

Now that all of the IP specific code has been moved into
the IP specific functions, we can make this code generic.

V2: Fixed build errors and porting logics (Shashank)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 10 +--
 ...{mes_v11_0_userqueue.c => mes_userqueue.c} | 65 ++++++++++---------
 ...{mes_v11_0_userqueue.h => mes_userqueue.h} |  6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  4 +-
 5 files changed, 45 insertions(+), 42 deletions(-)
 rename drivers/gpu/drm/amd/amdgpu/{mes_v11_0_userqueue.c => mes_userqueue.c} (85%)
 rename drivers/gpu/drm/amd/amdgpu/{mes_v11_0_userqueue.h => mes_userqueue.h} (91%)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c05183223cd5..21b926b16ad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -177,7 +177,7 @@ amdgpu-y += \
 	mes_v12_0.o \
 
 # add GFX userqueue support
-amdgpu-$(CONFIG_DRM_AMDGPU_NAVI3X_USERQ) += mes_v11_0_userqueue.o
+amdgpu-$(CONFIG_DRM_AMDGPU_NAVI3X_USERQ) += mes_userqueue.o
 
 # add UVD block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5b9005e39b92..0e5732795891 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -50,7 +50,7 @@
 #include "gfx_v11_0_3.h"
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
-#include "mes_v11_0_userqueue.h"
+#include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
 #define GFX11_NUM_GFX_RINGS		1
@@ -1566,8 +1566,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
-		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 #endif
 		break;
 	case IP_VERSION(11, 0, 1):
@@ -1582,8 +1582,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 #ifdef CONFIG_DRM_AMD_USERQ_GFX
-		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
-		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 #endif
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
similarity index 85%
rename from drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
rename to drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 45c57a8dfd90..fe50c85fb2ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -23,14 +23,15 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
-#include "mes_v11_0_userqueue.h"
+#include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "v11_structs.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 
 static int
-mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
+mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
 {
 	int ret;
 
@@ -58,7 +59,7 @@ mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
 }
 
 static int
-mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
+mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
 			      struct amdgpu_usermode_queue *queue,
 			      uint64_t wptr)
 {
@@ -86,7 +87,7 @@ mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
 		return -EINVAL;
 	}
 
-	ret = mes_v11_0_map_gtt_bo_to_gart(wptr_obj->obj);
+	ret = mes_userq_map_gtt_bo_to_gart(wptr_obj->obj);
 	if (ret) {
 		DRM_ERROR("Failed to map wptr bo to GART\n");
 		return ret;
@@ -96,9 +97,9 @@ mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
-static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
-			       struct amdgpu_usermode_queue *queue,
-			       struct amdgpu_mqd_prop *userq_props)
+static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
+			 struct amdgpu_usermode_queue *queue,
+			 struct amdgpu_mqd_prop *userq_props)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
@@ -141,8 +142,8 @@ static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
-static void mes_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
-				  struct amdgpu_usermode_queue *queue)
+static void mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
+			    struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_remove_queue_input queue_input;
@@ -160,9 +161,9 @@ static void mes_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
 		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
 }
 
-static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
-					    struct amdgpu_usermode_queue *queue,
-					    struct drm_amdgpu_userq_in *mqd_user)
+static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+				      struct amdgpu_usermode_queue *queue,
+				      struct drm_amdgpu_userq_in *mqd_user)
 {
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	int r, size;
@@ -182,7 +183,7 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
-static void mes_v11_0_userq_set_fence_space(struct amdgpu_usermode_queue *queue)
+static void mes_userq_set_fence_space(struct amdgpu_usermode_queue *queue)
 {
 	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
 
@@ -190,9 +191,9 @@ static void mes_v11_0_userq_set_fence_space(struct amdgpu_usermode_queue *queue)
 	mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
 }
 
-static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
-				      struct drm_amdgpu_userq_in *args_in,
-				      struct amdgpu_usermode_queue *queue)
+static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
+				struct drm_amdgpu_userq_in *args_in,
+				struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
@@ -255,14 +256,15 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
 			DRM_ERROR("Invalid GFX MQD\n");
-			return -EINVAL;
+			r = -EINVAL;
+			goto free_mqd;
 		}
 
 		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
 		if (IS_ERR(mqd_gfx_v11)) {
 			DRM_ERROR("Failed to read user MQD\n");
-			amdgpu_userqueue_destroy_object(uq_mgr, ctx);
-			return -ENOMEM;
+			r = -ENOMEM;
+			goto free_mqd;
 		}
 
 		userq_props->shadow_addr = mqd_gfx_v11->shadow_va;
@@ -273,14 +275,15 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
 			DRM_ERROR("Invalid SDMA MQD\n");
-			return -EINVAL;
+			r = -EINVAL;
+			goto free_mqd;
 		}
 
 		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
 		if (IS_ERR(mqd_sdma_v11)) {
 			DRM_ERROR("Failed to read sdma user MQD\n");
-			amdgpu_userqueue_destroy_object(uq_mgr, ctx);
-			return -ENOMEM;
+			r = -ENOMEM;
+			goto free_mqd;
 		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
@@ -296,23 +299,23 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	/* Create BO for FW operations */
-	r = mes_v11_0_userq_create_ctx_space(uq_mgr, queue, mqd_user);
+	r = mes_userq_create_ctx_space(uq_mgr, queue, mqd_user);
 	if (r) {
 		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
 		goto free_mqd;
 	}
 
-	mes_v11_0_userq_set_fence_space(queue);
+	mes_userq_set_fence_space(queue);
 
 	/* FW expects WPTR BOs to be mapped into GART */
-	r = mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
+	r = mes_userq_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
 	if (r) {
 		DRM_ERROR("Failed to create WPTR mapping\n");
 		goto free_ctx;
 	}
 
 	/* Map userqueue into FW using MES */
-	r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
+	r = mes_userq_map(uq_mgr, queue, userq_props);
 	if (r) {
 		DRM_ERROR("Failed to init MQD\n");
 		goto free_ctx;
@@ -333,17 +336,17 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static void
-mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
+mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *queue)
 {
-	mes_v11_0_userq_unmap(uq_mgr, queue);
+	mes_userq_unmap(uq_mgr, queue);
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 }
 
-const struct amdgpu_userq_funcs userq_mes_v11_0_funcs = {
-	.mqd_create = mes_v11_0_userq_mqd_create,
-	.mqd_destroy = mes_v11_0_userq_mqd_destroy,
+const struct amdgpu_userq_funcs userq_mes_funcs = 
+	.mqd_create = mes_userq_mqd_create,
+	.mqd_destroy = mes_userq_mqd_destroy,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
similarity index 91%
rename from drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h
rename to drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
index 2c102361ca82..d0a521312ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
@@ -22,9 +22,9 @@
  *
  */
 
-#ifndef MES_V11_0_USERQ_H
-#define MES_V11_0_USERQ_H
+#ifndef MES_USERQ_H
+#define MES_USERQ_H
 #include "amdgpu_userqueue.h"
 
-extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
+extern const struct amdgpu_userq_funcs userq_mes_funcs;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 9af6aeeca063..4406e8ab4ff4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -43,7 +43,7 @@
 #include "sdma_common.h"
 #include "sdma_v6_0.h"
 #include "v11_structs.h"
-#include "mes_v11_0_userqueue.h"
+#include "mes_userqueue.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_6_0_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_1.bin");
@@ -1380,7 +1380,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
+	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 #endif
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
-- 
2.46.2

