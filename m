Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5C3E69E95
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EA010E869;
	Mon,  2 Dec 2024 21:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IT4S3jkc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5435A10E860
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9CUoaPaY46EPEy9cBPV3OwXqkzmTEmaHdvTU7B0hCnsljL76uJVy1fiQmTM/Sjoq9v3UviucMsH0wI98NrgcBWUC4OzPjrv1Hz5cFtPEw72HbIkivJIGyUNpLkIV809yMa5QYQZQi/N9RGjVjQQah6slZ1HlUwcM8Mp/yXH1JOYVZD0UpwO+pKcALi6A7ix+PDxRPaLfa1T076CVu27pwwPgtweRV6zQYt1AYSOMtVfLD9lIyaBhyVLJtv2f7OkofoKdOJ17IMYfI/yGPkwqEjILkm1YO72jNIz3H1lTO2Nce5VdIAvjAylh0PQeV8t+rTtaSLs+17CdFRXlyYejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOPUwGo2Xb4IbBQutkyKsa9rZ8GodfpFEvdxhtmCr8k=;
 b=duYoU3yHbac+C/gKsxtp+672vDG+eqLHEuC1EgkrDRbj4nTnz3bGCJGXO/Jfu++sFQFMT5t5YEO7MZDxlhwVWLvFNtjf/LwOSgG57GNhVwjTvPcVwsQ2vgJ2bcbneb62tbqbDyHNegiKAlA5eBBf2DD9KPwezaRzIbvRLutZCIZzMaz7+bHJDv1v52WYHG8OkwuVSDkXOOHKXQzUmxXxVBjmsEcNhHBve/vycHZF5im14N1wYl27sMBoX292vCoQm4c4ERphiIgRraDJPtmp1a5XJJJvFJuoXXG/T5m4cKZJYqAgNJIaIh6o34ReXazSC0beJBmmXddpkE0X5f/BRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOPUwGo2Xb4IbBQutkyKsa9rZ8GodfpFEvdxhtmCr8k=;
 b=IT4S3jkcOf5py/tXKX/z3SoHPpe8NBZQul1mvxRhd/IiunNnazUqmEKB4NKMLoOlWQkGEa4cSGBU8qkA9rPGIekxREhG5fv9kC92JiAXHYqC2Nw7qaQyAxAvoq34KYNsUP9DW55WYR4n84cYykNrdVhmvr56cWbI6x0wSvvRarI=
Received: from MN2PR15CA0059.namprd15.prod.outlook.com (2603:10b6:208:237::28)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.17; Mon, 2 Dec 2024 21:50:12 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::dc) by MN2PR15CA0059.outlook.office365.com
 (2603:10b6:208:237::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 21:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Harish Kasiviswanathan
 <harish.kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/11] drm/amd: define gc ip version local variable
Date: Mon, 2 Dec 2024 16:49:42 -0500
Message-ID: <20241202214952.1125211-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: e87f4cdd-0a11-4386-dad1-08dd131b4c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V8AVZRaUcdkJqjXKWI/0CHCcVfyJc3g1zosCUwan8qN//LiEIXgzbfbSs7tM?=
 =?us-ascii?Q?rGSRH+sm+9YrD8L2R9oMUgOaAgwzSYHeqX+qPTRrMAtWb5U3TvkOtvOGfyKX?=
 =?us-ascii?Q?VfraiyZwHmFiUMuBPnFrO4FZT0e7PQayCgnjB1vNpTv8HqCGNEgSd1t9/RVY?=
 =?us-ascii?Q?DC5ahAVQdSlfwc0coQ1oDQ08NK/pPrPW3SfgSKuLBVg4YbBUr2m+uGckstK5?=
 =?us-ascii?Q?McBfqZyJ4qC2UQ4F6vJGv3fcv3XyJOkKmHWZrkdqkCdi9nDrAfvJoTJ3gxxB?=
 =?us-ascii?Q?uKROPQVR6A7aT3gJyx/57j5Axt4FvmFMfrheSrEhrgnzNXCZrRobP4wQPSR0?=
 =?us-ascii?Q?ZLUPqrrYTZXUrkUqab345IAcp51DAlU1xaYm2RWcSNENPplioUxLGc1TNJBQ?=
 =?us-ascii?Q?tv/Pe0jtPzcGtKNJuaFN03dzPvnK6YRGvZQLAJRz6FteX6NesxVa2G3qrhni?=
 =?us-ascii?Q?6dqGatL4wopYuAxVyvtnlkE97Av2CoxuwUK1DsrwGwlexRMvedPhR8QaGcHZ?=
 =?us-ascii?Q?TtPKumPGCK7LUaCmZj0nsbqaoQdUka5R2/v34epYtZRnfOFpyDcXxWiHPtKs?=
 =?us-ascii?Q?TJkya1l6FnsV1DBf2JIu5OuxRMKciODFPdQHTRYkO2H2OR+ZGcV4drDpKzmx?=
 =?us-ascii?Q?0okSB2314yjrQcq25VdtlY2iBLcpo9cT+wfQ34L9fk8dsfpRDnVy1+7wcys/?=
 =?us-ascii?Q?90b9wXFCmqVlkE5sbVUTYtvYWLHndWS2/a71suorVXLZrQilqkpHoSmiq65Y?=
 =?us-ascii?Q?cH/im/hIVXQMSQafu0p4aZepVFIfE21VOgoHwDOYO/ZUWJzjV8gKm+B9WJNx?=
 =?us-ascii?Q?JoWg6CQZKXszPFVkc/1H0t5kLAqD4PZR+Tf2z+5ovcloB2rng6bAk3a0LSZn?=
 =?us-ascii?Q?CoFqcr49Epimm/mkioIB6AoC1QMD7gfdVY4Uw01csOmBGnVx1wNGgPFOM4tf?=
 =?us-ascii?Q?CW0hmmpjaSXQdeUsN8NHea1LOaeMTgG2LB5B4fIR3bwH5pmUAVBX9PEPEbBz?=
 =?us-ascii?Q?35DO8TGVO4NFxD1SbD53YPx2F7QpbZMORr8w7HhnnvNvtM/7FVdWCecutccv?=
 =?us-ascii?Q?MJ3HGgTM88dlGFpaK+ifn1VsIXZG9Zgrmf9WXumfoxMWjw19CPyU4LEEtQQI?=
 =?us-ascii?Q?n3EmK+cJjGO9umjXof/V0REnTsj+jFy8ekvf8Sw0a7KZ+ZsgGG9W7k6Q6U4Y?=
 =?us-ascii?Q?8uHsn7yHPH7k+6LbFlzsEeL5Wy05usOAXmSAe1CxqJrMvLWpbaAtzHObtaXQ?=
 =?us-ascii?Q?wRRESq4wCz05r/MsNQm0V8bNXpLCqD8+HXALl2Cyw1t2743dE2ngOWqh6u3y?=
 =?us-ascii?Q?wYRpkYQKhUuBaZhWnev7l2LNSZcJYmt3D7rD2Mkl2qP7mtXc5gBGZD7Lu0ZG?=
 =?us-ascii?Q?j5twARh8dk4AAhIBzVLwMpYv5C3DG95dLGTJGwGX5LzaOTN4UlRHq/WoEwff?=
 =?us-ascii?Q?KzBTUHx6LSwmyGcmk40dpiNeLCbAyJ+Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:11.9354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87f4cdd-0a11-4386-dad1-08dd131b4c3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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

From: Alex Sierra <alex.sierra@amd.com>

For better readability. Also leftover orphaned code.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 +++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 5 +++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index dc670cf836664..1475d03ebb057 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1138,12 +1138,13 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
 	unsigned int mtype_local, mtype;
+	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
 	bool snoop = false;
 	bool is_local;
 
 	dma_resv_assert_held(bo->tbo.base.resv);
 
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	switch (gc_ip_version) {
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
 		if (is_vram) {
@@ -1157,10 +1158,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 				/* FIXME: is this still needed? Or does
 				 * amdgpu_ttm_tt_pde_flags already handle this?
 				 */
-				if ((amdgpu_ip_version(adev, GC_HWIP, 0) ==
-					     IP_VERSION(9, 4, 2) ||
-				     amdgpu_ip_version(adev, GC_HWIP, 0) ==
-					     IP_VERSION(9, 4, 3)) &&
+				if (gc_ip_version == IP_VERSION(9, 4, 2) &&
 				    adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3e2911895c740..c096caf314c0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1195,6 +1195,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	struct kfd_node *bo_node;
 	uint32_t flags = prange->flags;
 	uint32_t mapping_flags = 0;
+	uint32_t gc_ip_version = KFD_GC_VERSION(node);
 	uint64_t pte_flags;
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
 	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
@@ -1204,7 +1205,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_node = prange->svm_bo->node;
 
-	switch (amdgpu_ip_version(node->adev, GC_HWIP, 0)) {
+	switch (gc_ip_version) {
 	case IP_VERSION(9, 4, 1):
 		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			if (bo_node == node) {
@@ -1299,7 +1300,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	pte_flags = AMDGPU_PTE_VALID;
 	pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
 	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
-	if (KFD_GC_VERSION(node) >= IP_VERSION(12, 0, 0))
+	if (gc_ip_version >= IP_VERSION(12, 0, 0))
 		pte_flags |= AMDGPU_PTE_IS_PTE;
 
 	pte_flags |= amdgpu_gem_va_map_flags(node->adev, mapping_flags);
-- 
2.47.0

