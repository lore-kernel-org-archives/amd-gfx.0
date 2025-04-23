Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A1BC369D1
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 13:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437E510E69F;
	Wed, 23 Apr 2025 13:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a4sWprQ5";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50AF10E69F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 13:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8agdLdZszkz4Gc4Kd3rLQOKQNifFeTo1luT5c8gJ/yKHhpUtVyzdtKRQlnlr4CvLqN8ounNahOoKMzsniyHjDwCnlXuH1RkqosULAR6fqbNnGPBa3hybaLG6yjE4nfcsTqeSArzX7fhLTc2mprgwi75dIQ8e+cTfK5tpxCzbcxMUy2/OsHkRvZYaM5uT1vPCplEvFUx2ODq7DhzWkkneLg7LbIsmfXGwSi29Lb9Uyw9obIo1l2d/TEbcHYeexV6UGvCW3GuMDcHMzdELfQtlQEELmGfkpA0a+YH5QE5RkDRZgfVR9xWgM370YLkEv352Glsjh9flkC1R5nAtoMfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOEYBed5bjjyXvkYjxfd52UDluoYG0IhsAT68zEy7gs=;
 b=YOD51kBHWnzh1N4B0ZvUSt2gvhSqsKNbOD6RSAREaykLyuUjcPAs0PvqkvJnl4/lKK4loYr7qX4zSc2cWiAaq/eOR2+nvvi5X7V088lfakI5aKgsWRs6Q+a5WHSGI7X5dH5sjB+81HLO8oQCMJEUP+F57oQlvlfAQIhUksNZXf6Sfijt3YJXa+S89wgfndIao9IcKZNCKT78n5NYx+GHdi8iqtCp1E984B69eeZMKxGJ3mbyIxRZYBc3t38QF4xBg8YlWgJ8nbTPOte4nS+EnYNh9BoL5tVGb/8uI+yBO9kS/3XzVjOLRE2AhKz9F/S5IwRNl51YMvPOkxMWS+Kh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOEYBed5bjjyXvkYjxfd52UDluoYG0IhsAT68zEy7gs=;
 b=a4sWprQ51NfNqEc5JUUliyGPGpaXDlqtdXSOPmqxep6XxsnZpEVgADBr/jYhHLd3i3Yv/hmyA47cVWaqStRE7nyOv491cGIQ7FZXFnISvogTULpDZ6T9IwNY8oLJfFXZyh81Q485f/CpvbIt2ruiDpCuR9+WoQVDZ15S1tlxc3U=
Received: from BN9PR03CA0268.namprd03.prod.outlook.com (2603:10b6:408:ff::33)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.37; Wed, 23 Apr
 2025 13:26:18 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::ec) by BN9PR03CA0268.outlook.office365.com
 (2603:10b6:408:ff::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 13:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 13:26:18 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 08:26:14 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: properly release the eviction fences
Date: Wed, 23 Apr 2025 21:26:04 +0800
Message-ID: <20250423132604.4002242-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423132604.4002242-1-Prike.Liang@amd.com>
References: <20250423132604.4002242-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 72df844e-ebcb-48e4-3ca4-08dd826a6e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/e4yGBQ8ykBc2FMJSZzSjlfV1KMpVJgy3OPoF/xBcbRREbDzpKrs71OWuXDU?=
 =?us-ascii?Q?xu/aweMfYJiJ4yX7VV/8167PeKEWeUxCIOI1GYA8ZqV7vnHof2/Pa5I/RmDp?=
 =?us-ascii?Q?vuBza5T3eEfMeyboq/3MX0QglwciNdLmlKA+LhQtkSpZJULZU4iIrb9rBiFx?=
 =?us-ascii?Q?rrHElNJHEMHR6IRhs0BjTHUrBppv9wVdzAF8SZikhi322YauNjsdBIe6u+PV?=
 =?us-ascii?Q?DZitz3ZwElJmUhdyqwLrywFWMR25HiJRL0rRlGGwci/OPWM/wsoZOnidnypO?=
 =?us-ascii?Q?b4SZd4HVcmln6UqfLFE942nT0YqzYMWSkZR3GmdI6TpupFOf2LsPzJUvG9oC?=
 =?us-ascii?Q?3c5oM22jzyt++S1GdnfmteC9P1vI+JZsyWGXC7kVdxzAmvJ0wb+3tz40Joji?=
 =?us-ascii?Q?8vWlxO8tcFh1zT34nlJ73jq6ZJC6aSwFknTso5KAwQ5jDp5PcTqG8tJ+Ku1U?=
 =?us-ascii?Q?V131pkXimwvIrLc5GEfacimKkZxA3gpavvaN48J+REeHD2CGq8h+b0bgycZJ?=
 =?us-ascii?Q?zMk8fuHiLncnGXvltnMUkdVcbx3GAPHPxZhWXr5iCKIzRjxlTy49UFymoN+v?=
 =?us-ascii?Q?Uf9ZmC/Mn/ZkqVn4rbJd8TrvNXCLdJMT9rzzwI+oKu75DmMbNpN//6mUFrYQ?=
 =?us-ascii?Q?tomEqebaRPH+CHoa1E2V9xiSfuygh/MVGlyg55PT6iRjzTrQ82g6bHpdF3Up?=
 =?us-ascii?Q?KmuXqGKM+cUeDUG9zN3T4xk+Sh7WfCvqFcQR6CkfpWw5RnELywMtlpIu4v0O?=
 =?us-ascii?Q?mWFw0RKao+vLR4tLY4Vn0R3dX8UlfZ3Zd3cVwj5t2PzUeeUNsZBeZhEiUykK?=
 =?us-ascii?Q?7tJOUimaXYuCn4pXiTkmlkmYrSAir6I+8r/tijUGKGhalVjylmU5RVIFphBG?=
 =?us-ascii?Q?FqZyXBYydQQaDmv9K9YeLRl9l+7/5pgKSHPFbPB6jERgkJ7UnlL0J1ZYoMFt?=
 =?us-ascii?Q?qUHHw9WiuNLbZyS1Tkzn413ReEYXOhGAjgJjf36/ouggesuQEnvquooiR94Y?=
 =?us-ascii?Q?jCxR1zev5xfEtmdJWf5+sfaloscMjSEZ4hG2kdMVVc8p7v/ozRkP3d/9DUH1?=
 =?us-ascii?Q?fO9iNJbNi5Y4lnIJQz2prS33LX/GziLmchFQcBIZTVm4k5CIvdfBjHzQSFWq?=
 =?us-ascii?Q?jc6B9BGXdR/lUmvQxQpfl+fMPQ1QaHrrPha+tfpUBGAd4ir/9TM3l/nRmbzH?=
 =?us-ascii?Q?9El1U33kj5LIuEWRR0i+bsXWhqD0i+28crG9F74JiXdKJfXfe4S//LQ8Bgpk?=
 =?us-ascii?Q?GZfR7wDObZgalA9jZZ/yY2hk41EzX052ECFedoVQIgxowtjN+VgW0KdM/HvZ?=
 =?us-ascii?Q?Izi/kCiup2PQrf98EDC2qsZsNNrxBlmhEOsY+ZFFAyXJvSPrS/6yarmXy32T?=
 =?us-ascii?Q?NGZmHtrQ3BLzC/Yi7PxqyrRGODn0lF9bda5nEpsWOMR2i+e3GIELDk03Us0/?=
 =?us-ascii?Q?d2FwD+DERNb89JG2yqUdp5PwYL3g0h7Wtlz7II1t7wlkco8L5MiIaQ3mpGGw?=
 =?us-ascii?Q?p0FYZ+EXcdakkPB1uxly4AQFd5fOLeiI5s1P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:26:18.0187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72df844e-ebcb-48e4-3ca4-08dd826a6e08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

The following cases require releasing and deferring the
eviction fences properly

1) Detach the old eviction fences before attaching a new one.
2) Drop the eviction fence init reference.
3) Correct the attached eviction fence reference.
4) Free the eviction fence when the attached BOs are released.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 53 +++++++++++++++----
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  1 +
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index d86e611a9ff4..a47db865c530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -70,11 +70,6 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 		return -ENOMEM;
 	}
 
-	/* Update the eviction fence now */
-	spin_lock(&evf_mgr->ev_fence_lock);
-	old_ef = evf_mgr->ev_fence;
-	evf_mgr->ev_fence = new_ef;
-	spin_unlock(&evf_mgr->ev_fence_lock);
 
 	/* Attach the new fence */
 	drm_exec_for_each_locked_object(exec, index, obj) {
@@ -82,6 +77,16 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 
 		if (!bo)
 			continue;
+
+		/*detach the old eviction fence first*/
+		amdgpu_eviction_fence_detach(evf_mgr, bo);
+
+		/* Update the eviction fence now */
+		spin_lock(&evf_mgr->ev_fence_lock);
+		old_ef = evf_mgr->ev_fence;
+		evf_mgr->ev_fence = new_ef;
+		spin_unlock(&evf_mgr->ev_fence_lock);
+
 		ret = amdgpu_eviction_fence_attach(evf_mgr, bo);
 		if (ret) {
 			DRM_ERROR("Failed to attch new eviction fence\n");
@@ -89,9 +94,10 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 		}
 	}
 
-	/* Free old fence */
+	/* Free the init eviction fence which was referred by the dma_init*/
 	if (old_ef)
 		dma_fence_put(&old_ef->base);
+
 	return 0;
 
 free_err:
@@ -189,7 +195,6 @@ void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
 int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 				 struct amdgpu_bo *bo)
 {
-	struct dma_fence *ef;
 	struct amdgpu_eviction_fence *ev_fence;
 	struct dma_resv *resv = bo->tbo.base.resv;
 	int ret;
@@ -205,10 +210,12 @@ int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 
 	spin_lock(&evf_mgr->ev_fence_lock);
 	ev_fence = evf_mgr->ev_fence;
-	if (ev_fence) {
-		ef = dma_fence_get(&ev_fence->base);
-		dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
-	}
+	/*
+	 * The dma_resv_add_fence() already refer to the added fence, hence in this
+	 * placement needn't refer to the armed fence anymore.
+	 */
+	if (ev_fence)
+		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
 	spin_unlock(&evf_mgr->ev_fence_lock);
 
 	return 0;
@@ -224,6 +231,30 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	dma_fence_put(stub);
 }
 
+void amdgpu_remove_all_eviction_fences(struct amdgpu_bo *bo)
+{
+	struct dma_resv *resv = &bo->tbo.base._resv;
+	struct dma_fence *fence, *stub;
+	struct dma_resv_iter cursor;
+
+	dma_resv_assert_held(resv);
+
+	stub = dma_fence_get_stub();
+	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, fence) {
+		struct amdgpu_eviction_fence *ev_fence;
+
+		ev_fence = fence_to_evf(fence);
+		if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
+			continue;
+
+		dma_resv_replace_fences(resv, fence->context, stub,
+				DMA_RESV_USAGE_BOOKKEEP);
+
+	}
+
+	dma_fence_put(stub);
+}
+
 int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	/* This needs to be done one time per open */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index fcd867b7147d..7e6c55a334e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -42,6 +42,7 @@ struct amdgpu_eviction_fence_mgr {
 };
 
 /* Eviction fence helper functions */
+#define fence_to_evf(f)  container_of(f, struct amdgpu_eviction_fence, base)
 struct amdgpu_eviction_fence *
 amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
 
@@ -66,4 +67,5 @@ amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
 int
 amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 				    struct drm_exec *exec);
+void amdgpu_remove_all_eviction_fences(struct amdgpu_bo *bo);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index dbe57996a481..6d3eacffbcb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1322,6 +1322,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	amdgpu_vram_mgr_set_cleared(bo->resource);
 	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
 	dma_fence_put(fence);
+	amdgpu_remove_all_eviction_fences(abo);
 
 out:
 	dma_resv_unlock(&bo->base._resv);
-- 
2.34.1

