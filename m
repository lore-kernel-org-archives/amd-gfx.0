Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463D6D6ED2A
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E877710E939;
	Thu, 21 Nov 2024 13:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSKcu/Ep";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5D810E939
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuBM2vw3phF0pz3yuZU59Mb5D4oE82LUYDyvoQ7qVqrAiNjGoNB2u7n2nlPaddtrSByR8oGAnccTSifqmbDQio8qN6kLqCpWotfXXqmoDL7iIVVXeZFSMRvxtPsfSq3cDWy2I5hcYDbs5Zj/OW209bQR2U0kbXTcwDcBlypuh9Rfotlkrhz2f8cw6Vnl4vJXgvtqZkexc31B/SLXdowOdvKT/BN7opQKAM8kVgtRv1seN8Lb91XQlJs878mYDaNtlgz2zBz8yw0nglif4cSHK5//j1xZ1WJHXEu1WQAviOwmVth/rMFg3XKUN/CBnc/+3lbomcQce/HQM3Nezs5AXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dHih005IReCvJidmSe2ycWtaHDf0uQHN9ktrrdmzWM=;
 b=Gpg/59fK4a5FQyFAT7Nscwy1b5XeKC2YrI8GwfnUt+btE3A9N2Ox13Z9A2tC8uZy2f6N/l6NcbO4ohpES0qgSRLg9qRteH6k3Nqqjfh9IqrbEYT3foqt3KB8IAcfvZNCKeuw1vX8zA4emZx9ghn30t2DAara3nJVIk8wxR0F92DxyZD9TQHjdR4193fzqV5Yt6/ZvnyU0kxij4MBCeAIkpx/Ceffj0geImujqC/0+kRGHa1xlLLxP+1sJduBt66hOMKLlLxdqhAzU/8A7j+Ld4EATq/ufrCo1HWePQDmn1gaslLWt7xe8hOtbPziY+UNelmpYaSOh1Y9/A/NvpmBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dHih005IReCvJidmSe2ycWtaHDf0uQHN9ktrrdmzWM=;
 b=LSKcu/EpE4XcS6PoZddxkR2Sns50/76W5uylHNokgfLYVCva0s58cGbY3YqELABZ8F5tkiPUqUReW7Vb9+5QnOwaXjoXIaPvwYw8CPJVeLYWzRnT4NT6e0s9u8k3lc0l0RSVDtqZgReJp+q7rKWu+TUThEAjccVIYkDK7Q4TCOg=
Received: from SJ0PR13CA0232.namprd13.prod.outlook.com (2603:10b6:a03:2c1::27)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 13:11:35 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::7f) by SJ0PR13CA0232.outlook.office365.com
 (2603:10b6:a03:2c1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:34 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:28 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/uq: make MES UQ setup generic
Date: Thu, 21 Nov 2024 14:10:53 +0100
Message-ID: <20241121131055.535-8-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bacd521-e2ea-4e74-6ba9-08dd0a2e0671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mRAHA1iFmnU0BDYc9CmNaj6qKdPTc8R8jiCI5gSh8mtxtl1j9VdXgWOe41QM?=
 =?us-ascii?Q?6y3i5Gt+5VwVP4qhFG6cM9NbbKwgSTncG/tSLS74wats83ncw8GkvQq7vgnl?=
 =?us-ascii?Q?8LM8LeEKSmj4hjz0ZZPXaYQyZvDp0nNSEgW6/Y09WFmmFDnPuenC6zts1tKp?=
 =?us-ascii?Q?phhFboPVaqDq3y2WcF8mv08tLKj3ZKPYKkGzaUcsYgVEGn+cSNwiy+YehiJz?=
 =?us-ascii?Q?w59fAKnLfwXpU6P1c703BxxXejtX9TDu4vNu0jq0hgu6xKP+wtU3y252lBP1?=
 =?us-ascii?Q?mYNjom1ZRg5srGNNnAV2oeJjXkrw6T072OBVIqaaZ4BXMWk819Y0g+khtLCw?=
 =?us-ascii?Q?636ArpwN9dQxHUyGmlPrbc24kFHpZCsgb5yoIXX+uiJHc8lwRYPrMM8bqsC6?=
 =?us-ascii?Q?31i3fHG3ydKz/GT/YWc9wXnVR1/4kVHg7wwt9m/QuhZ/hQKtHRRcly10sSNr?=
 =?us-ascii?Q?1+fzdeunXxvSsULOOoVMNtG+0HU+ade27NfjuHzl5nKSicXvzYs5u3ntz2mX?=
 =?us-ascii?Q?UsZ3bQr2kX/15cikHD/AbnzrDaIZv27U22GFEbXbsmJCELicxkDXXW4TipDy?=
 =?us-ascii?Q?jFQarV9Px399d+oNtxepum/5bPz/t7e1ODhnBXEsm86P2AcLr5bpK7nmeogJ?=
 =?us-ascii?Q?psdcMAshmgC+uNVYPARNxe5pdMkMG3xCjDmVSFQM74iJNeLH7srN6Ndtziwm?=
 =?us-ascii?Q?TeKNqCDrecs+fZwDuC5eiByItO+44DFAa3WHvwqv2NNagve/KHItXmjViGOd?=
 =?us-ascii?Q?saIaN3rxb/94u3aGp8NwXRwMFmjTzf/yM5VWYYXwsW/SRsZD2geQttnWPIym?=
 =?us-ascii?Q?bPBs664ddNWh2iDpigTe7gG9bQNzi5IOx7X+m1H+6InxnvSYqKSeOslGExul?=
 =?us-ascii?Q?P3XygkI5pEL+jeicIGy37sR0BhETs5qAymjtBHVU9fp6PVn3+hgnTp5QLMBR?=
 =?us-ascii?Q?mY53XnUs/FXPCNtruWLnOaErW6/5wXZ86gf2niUvWHmbWLB2cfThT1BN69E9?=
 =?us-ascii?Q?uNtG2+9Ivnhvthqwog9rRZ4CtAjWYEp1jNBZkxglYpFzkQQkWwrwjR9L5nnH?=
 =?us-ascii?Q?6oD5sOfDlQBOvBuA9SXSVg07ddA8410N7tAJdQ6mO6AzXBNDwKSA9SJDGPOr?=
 =?us-ascii?Q?PtSt2Zg944RjrClTR23GSUK9Nv97z66kqoLreg5pJdzsnoc3s8ke9D6yaxn4?=
 =?us-ascii?Q?oU5RfYKt0OBZQRAeJA8tUi43nkTZ2GuiiFp4srYiDCv+DK/zwbDtTFukE7jF?=
 =?us-ascii?Q?812/eGZcp4Bgsg6Ep+ArfQLyhCDU5uatdITMSn9l/dEk+sYgMgsXQeD7e4D7?=
 =?us-ascii?Q?o577xUb7SeKaA77mIVJqjK7Nx0EBn+FnvHtq5pNIAiu5fw9St0Ngh38ESjx/?=
 =?us-ascii?Q?90/xp6RR0aCMfYhNbaZtVKSGI4Hj09IetWlwjTA2Fghlaj+DUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:34.7317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bacd521-e2ea-4e74-6ba9-08dd0a2e0671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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

