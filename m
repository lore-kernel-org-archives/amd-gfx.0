Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C872CE8E68
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2563310E912;
	Thu, 24 Oct 2024 12:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GSV1/4lB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD3810E912
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 12:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGg2k+OWyuFMVCeRGUeLodQzBc0hMhjjk3HA5uvjG1b7FIMyZep01NM5G4nX93Q4DOyouOMoVLzEbFreLHO7lRS9745F2PhGmtzGtMr+2bdtqqqZvKxYTVXJGEBaxTgfGcdJdnXKbmHF3sdl51lGTzU/O0K2ZpW+MrDZTuWhB81QoTg2u/WvXsRa8PfDHOEFaXeeEPMVH5F1/Lf8aZqlMYan870dMCyYrM+R/GFjHOGyMMUocbs5YYnUqSnHoUQPOMNSocUGWOAuavTPW2tjJ47D4Ni3yo9x5j9d6w99Lx2uvikV/fUQEFxlhy9JoLiMLTNUYyOYQFmD5F+drmr8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN3UgHewwPIcY74KHHqIVdl6xnEyQ69c5YUN71cO0rw=;
 b=OffEWZiioVVyM+b3iF6fFXHtUgKuQI1BJY53PTP8eIAAU+JSy+O+o6ZQyThQRk8Ntf1c4LWwVh6GjcLK4aVjBmovtFT6WZ6STkr6XDGEg0m2ANiOSBnAHCCAxUUSo48IesOPkp3o4QNGN99AmGHC+gALQlYEwfii2AFURQVMEJWI0xTW3qZbRxbfqtKKTXQMec3Fxjb3W26P1m8xM+2ZkNWByPhmideqcOo6s7iiSOJJsJnJ+joha/GXSdU3ulskMEWqWH5l9m0huJ3aQllLf2Afa67Inu/m8Kbk042mu0SbTHDsarrl2twAU8Emeerx5RME8SJEW1/XIXjehnqO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN3UgHewwPIcY74KHHqIVdl6xnEyQ69c5YUN71cO0rw=;
 b=GSV1/4lBcFytmRBsCL8dJ7p+K73OBi0czEQDnLxe3wEzgPn8Xx6maSkXZq8qz7oWW08E55DlgFLX3n3/ccrq3wT5IDo0sxRK7jzNsQuPKHNVzFbUETytDveLC5eYRaPZRAMSL9UuV/vRkLHHQq5l0nUI+n218EN7Gr6jgX6/QeU=
Received: from SN7PR04CA0072.namprd04.prod.outlook.com (2603:10b6:806:121::17)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 12:11:07 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::7e) by SN7PR04CA0072.outlook.office365.com
 (2603:10b6:806:121::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 12:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 12:11:06 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 07:11:03 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add gpu_addr support to seq64 allocation
Date: Thu, 24 Oct 2024 17:40:27 +0530
Message-ID: <20241024121027.3397-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024121027.3397-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241024121027.3397-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 25256cbe-f9fa-44e3-0d2f-08dcf424f075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCSy662DX5R2EoYUzLHh1p9mzBZ8aAtkuTJUc8ILRk0hGPGjlb6g2XQXGGFc?=
 =?us-ascii?Q?ipeSQxglX+VRmS5SnY6fLWAIAYLTuAm+2tDtHURSoe+2o92OXY2O7Og0onGc?=
 =?us-ascii?Q?CPGmFRc54cd+4t8hegUXxd3Q/K3FndFMKsq1MeRNPA8QQLnLPVyltqO93gM/?=
 =?us-ascii?Q?oOf9+J1+jZFxIMAMIneIiHffUPI5MxdZiXdDk7waFufWl5aJewh6f7rpsrT2?=
 =?us-ascii?Q?YDTC+/pYnargvRtmY51PDVUQQuyg9DG6PyHHuGq40rmhSPuVc6SUZjkCuG/2?=
 =?us-ascii?Q?7buWTa2/fEu/Xaz1SWV8tZDODwyHu8tEzntr6PaonB6yrhiqA4//hFl3J7U9?=
 =?us-ascii?Q?jhJ8nwsPufHBqphAEnDpls26r8jX8ekaaesRLSHBi3df/FYPxv1soFuQ1VIX?=
 =?us-ascii?Q?IUmSRf6EdtuiXBdGoK270ULABnt5QIhO96bh/JhTJWfcw/RpT4cgJ2WP1ki2?=
 =?us-ascii?Q?VcbB+wBhmJ2/mfwhqHKeAYWSLXUVE1fkhghoJuKDPFxNj2p1dmSPhvV0uPkW?=
 =?us-ascii?Q?3/ak3ilrVENHIIwHN6ec+MIB5bVLNFvqHYaggsPdYL2x+x/Fhm7BYeeYh/lm?=
 =?us-ascii?Q?10nnDZSB3JCLpkY7f5mnTIFTmIBBLu33RJ33EzeUOAVrRvdODP3aU2kIBoHj?=
 =?us-ascii?Q?FVBNeOzGmg2kZSD8M7sypluSYqukLAjRO4v3zD5RF/xSvvccmxeBI1pbrxyY?=
 =?us-ascii?Q?pnm9eTV2XBlt+o0AOGxuCLDBC+waW+GSiQne5v/Pr9qqUYW7f1GEPa1QAsme?=
 =?us-ascii?Q?g9zeXMoxdFPabrA7nd1OyNOLDgjEz1Mtf2Qv8SdhnzJBVoRyUIZipJ/2ZkIs?=
 =?us-ascii?Q?zHYf7nmvgwpDy1pOUQBzWtGXOUdaaGGpboRLuLNRnbCoqN4MhbsjrUbLOYIk?=
 =?us-ascii?Q?s4Y4lo1kS4clQOJTT/y+7soC0K+xZn6VOtut+fBPtlpM22Mh+JKvjpMLjh5p?=
 =?us-ascii?Q?Bla9cpq9SIHEhaEPEY4p3yU6sBuuaTebpBEDYZ+HeAwA1Dx/Pnzu5n8/6Fhl?=
 =?us-ascii?Q?2dFKHB0Ch8ydCP2tDqauaJ7ckLBAgc82eofaJj+DSao9PYz6PRsoYMsux/fu?=
 =?us-ascii?Q?M6AKZEmCf/VOUK7Sv14l/a83/SQcA/FlrZKMdDQqpxmZdtUOq6NU3g3FHNqA?=
 =?us-ascii?Q?q5Se/50WLQrVls/mSEuBTUfr3+ZcOUCBzJ6iMCyzYdLMOR17tseo27XiZwTZ?=
 =?us-ascii?Q?a3l8avho6Je1rH2PWvoQOFArnaEIunwTlj7iaguwl/SVVkCZqZv2PfbkEN3+?=
 =?us-ascii?Q?wJuewJhmvnVh86tl/yRwN6ZXW3rnuyIwieTUMlr5COjDoPk3tdqHILcFdstA?=
 =?us-ascii?Q?ev7pUwb68ADyFQwvNaKK6s3SjEgzcZwPBnZbiri0T2+SKy8HfAw/WHOSXpx3?=
 =?us-ascii?Q?9yi2aiN3Jn98B4Iqs66eH6T9hB21L7qgegOVUwbtIv9NvMwfdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 12:11:06.9189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25256cbe-f9fa-44e3-0d2f-08dcf424f075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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

Add gpu address support to seq64 alloc function.

v1:(Christian)
  - Add the user of this new interface change to the same
    patch.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c       | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h |  1 +
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 12cad4424fc0..2f01a209ec3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -166,7 +166,8 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
  * Returns:
  * 0 on success or a negative error code on failure
  */
-int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
+int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
+		       u64 *gpu_addr, u64 **cpu_addr)
 {
 	unsigned long bit_pos;
 
@@ -175,7 +176,12 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
 		return -ENOSPC;
 
 	__set_bit(bit_pos, adev->seq64.used);
+
 	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
+
+	if (gpu_addr)
+		*gpu_addr = bit_pos * sizeof(u64) + adev->seq64.gpu_addr;
+
 	*cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
 
 	return 0;
@@ -236,7 +242,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
 	 */
 	r = amdgpu_bo_create_kernel(adev, AMDGPU_VA_RESERVED_SEQ64_SIZE,
 				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-				    &adev->seq64.sbo, NULL,
+				    &adev->seq64.sbo, &adev->seq64.gpu_addr,
 				    (void **)&adev->seq64.cpu_base_addr);
 	if (r) {
 		dev_warn(adev->dev, "(%d) create seq64 failed\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
index 4203b2ab318d..26a249aaaee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
@@ -32,13 +32,14 @@
 struct amdgpu_seq64 {
 	struct amdgpu_bo *sbo;
 	u32 num_sem;
+	u64 gpu_addr;
 	u64 *cpu_base_addr;
 	DECLARE_BITMAP(used, AMDGPU_MAX_SEQ64_SLOTS);
 };
 
 void amdgpu_seq64_fini(struct amdgpu_device *adev);
 int amdgpu_seq64_init(struct amdgpu_device *adev);
-int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr, u64 **cpu_addr);
+int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 *gpu_addr, u64 **cpu_addr);
 void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_bo_va **bo_va);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index bec53776fe5f..8cf169e7e893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -82,7 +82,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	}
 
 	/* Acquire seq64 memory */
-	r = amdgpu_seq64_alloc(adev, &fence_drv->gpu_addr,
+	r = amdgpu_seq64_alloc(adev, &fence_drv->va, &fence_drv->gpu_addr,
 			       &fence_drv->cpu_addr);
 	if (r) {
 		kfree(fence_drv);
@@ -113,7 +113,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	return 0;
 
 free_seq64:
-	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
+	amdgpu_seq64_free(adev, fence_drv->va);
 free_fence_drv:
 	kfree(fence_drv);
 
@@ -183,7 +183,7 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	xa_unlock_irqrestore(xa, flags);
 
 	/* Free seq64 memory */
-	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
+	amdgpu_seq64_free(adev, fence_drv->va);
 	kfree(fence_drv);
 }
 
@@ -751,7 +751,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			}
 
 			/* Store drm syncobj's gpu va address and value */
-			fence_info[cnt].va = fence_drv->gpu_addr;
+			fence_info[cnt].va = fence_drv->va;
 			fence_info[cnt].value = fences[i]->seqno;
 
 			dma_fence_put(fences[i]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 89c82ba38b50..f1a90840ac1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -44,6 +44,7 @@ struct amdgpu_userq_fence {
 
 struct amdgpu_userq_fence_driver {
 	struct kref refcount;
+	u64 va;
 	u64 gpu_addr;
 	u64 *cpu_addr;
 	u64 context;
-- 
2.34.1

