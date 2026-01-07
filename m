Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ECDD0D16E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 19:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B83810E607;
	Wed,  7 Jan 2026 19:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l6Bu0mV1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB20B10E606
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 19:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSKi/7Vd/p1oyPrWhZISmb3eI031xvKWpDaA9e1N/hl0+DSw0ccJ6Tiubg4DcNQKIfhCMBIDCYVx3lZlXUYYBBPRpQ+mJ02wmNGTWiXGxPxg9xQZG27JLFymPf/ZF+Yf338rRgd6So4/rig884a6GIuFJrkFI6r6Cjl2hCxB1vIACRuLPPMLUKNNLJkZ2ofkFmMa1gaMA9v+bR0QRNjuS0aJVUYl7wHZHMMF+1sleTBqQdo3zQuEWailvUU7bRaA9WqtYMA9Tv9Qtzr9SfW4pR7csuzdSqwLi9RzXkipyFLMjT5d2w/Gc+qzCtTtY7wvM6a5QarnySDdUU1dNZsXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnjBCggJX9x3B7DgHOf8+nnk7Qspk1+SPbm212KdJiA=;
 b=i70BOYlh1N0Lc40+BkRW/W0LuOiUOAv0nV98pkPWVZxFC558hkSAm1E85PlcLMjeD3diJJUVf8FMyAUBG/cpU8gOalRGxgk3nDJLLEsce7RPIjL4e4OjAgcExN/igh5gOq7sK/Zgt85zxgf7dx+bgbph8j9FLq3UpHAG8bCtzo6WeXjKKXt/y14VPRYpWGaxPq9GNDDy9jkBarSrcgVmsBXlW0p5MJyMuPfeumKHfu5CvvnN/Y65xufjeRspS7zg94YawuM+ob6rWcguWsSCrV/bFWmUDW7hDXD+K2i9jrwFywG5kAXtdViPdjsHFNBBNIpLeDfJJTEFIIp+AH2bAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnjBCggJX9x3B7DgHOf8+nnk7Qspk1+SPbm212KdJiA=;
 b=l6Bu0mV1GuBomADZ9ATcNKDvfO7k94ZpTyu1+eV674AV9ccS4Vv3AjXpsEBSJ6yU4IEzg1CCqp6wA6tJNTcXkk6CYJCkSJmV18tCsCH3KSY2B1QGutCCu9xFOEbAwHp5GMZz9MZNhOCR/XuGadENLQeSEoMSe4uR0HcfKI6Bq5E=
Received: from BL1PR13CA0358.namprd13.prod.outlook.com (2603:10b6:208:2c6::33)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 19:25:50 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::e7) by BL1PR13CA0358.outlook.office365.com
 (2603:10b6:208:2c6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 19:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 19:25:49 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 13:25:47 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <kent.russell@amd.com>, <jay.cornwall@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v1 1/3] drm/amdkfd: Add domain parameter to alloc kernel BO
Date: Wed, 7 Jan 2026 14:23:38 -0500
Message-ID: <20260107192341.3521748-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107192341.3521748-1-Philip.Yang@amd.com>
References: <20260107192341.3521748-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 46549219-e824-48ce-f5a4-08de4e229082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2qZigTQZUVuLwVHjTo6mgd4Ukt2GECyK48tuxmCbIvTl17homZgcib6Yz7+S?=
 =?us-ascii?Q?ijFXme28VGqYZDFeTe4WBE6fRnHzlHyASq7nOz6VEAFaTgu4MYaXmQAx8hAU?=
 =?us-ascii?Q?gb9cq97srQtuJydivTAIhxgqepdn5icxDxTORF8kn5uAuCrBnb93hz//Ki77?=
 =?us-ascii?Q?ZDxaSUHd3yXVP2FghPyyRbqEkDt0uF89uNrVFBQw94233KwXRLFv70kzHVHw?=
 =?us-ascii?Q?4su1oT1BGSQo80lKc/GKPvxBNfovits2OwsV9kKC2AaFCDs1l+yg3BBZHY1N?=
 =?us-ascii?Q?dEjQOB+E+8i9FmpqOqSAFyUmgAA1Qtxq68Sh8EMFola4NPu4nLNt6RBdpqCR?=
 =?us-ascii?Q?CsAMOH2vM5oQjGutRdPToi89ITfiSg/RUCM6iebDAOF5zKu2dpTUMH6h012s?=
 =?us-ascii?Q?KFUK7bkH86+s/WjMsoFn+fagrBeKrQ0nxIqufoo5MjtP5UW1HAuR91L71ghy?=
 =?us-ascii?Q?dodsnxyJAeA3wW8N2OQp0zNr8/fZOhW2Rpf8vxdg1XWq/1BG77is/03AL2fP?=
 =?us-ascii?Q?C9q3lDkHv+MeHN40ASmA3RegRCsZQJQDFKm9bfXHAuG4B3PIbzFI70JyYaVC?=
 =?us-ascii?Q?NTapX5UJKGslMCiySytr7WLrKrbW8jAkAuuplFO+brRd5ycqHA9rf5Dm8R5e?=
 =?us-ascii?Q?mmK/20xxYdWKvMR2+IoraDq73stSes3vnPYFtBwznAfU9SBQKQoFbUXaSnUZ?=
 =?us-ascii?Q?cfA3w+yFuLQ/Eglj53pmsmDpdCvlyW0jl/NxwBYxNwYboTuzGHPqZAXzWwes?=
 =?us-ascii?Q?quldWh9+YKJ0id1afmKeOjb5W7bZQriFTAnBJ+ehj1MDAqBrwYOf7SDaOCK7?=
 =?us-ascii?Q?vPkDsESAwz5DWhmAmUD5fHEeeewtjIxXRVShiN6UZfU2XIWh/lICKWgBsl9b?=
 =?us-ascii?Q?5NX48pzZvmia3+F7oeiLJYNbELRBry4g+Z6uc9YKc46017msOR88uR4cKMr0?=
 =?us-ascii?Q?XflLpSQNJ72N5VZvaiPpCItw+pDuV1JiEfYgAkz7Kyd/MvVZ+uUJLgTQ0IJ9?=
 =?us-ascii?Q?B+ytNlCV42w8iJF/ItPVSjDdqoynMLpOgF+Cfj9ilZE4SiUuprVJYhNbhjtY?=
 =?us-ascii?Q?gLkeuKkjOmJxp2JtvhSnEYfrDQbjGxXDrxOJnYlrKl3bWmQ4YJ42zFdx/tmq?=
 =?us-ascii?Q?K5KBnufyJrEDjKl8XhH1vwWIiI657tWbOM6ZWijw78NlIBfthq6IzeY8LE68?=
 =?us-ascii?Q?rNB+1FBplTiY2ZfdA3G6EZEiYyG5L/3hKx01H3dQY5MlTwmsLH5b6aB+YWUA?=
 =?us-ascii?Q?T2ARbQLQguHGQz1fSEmswE0EMy/BWVuXhMAs8s/tesAJIRG5AsrvFjaZHok1?=
 =?us-ascii?Q?ktiVhGQdNKOpmEPMXNnxpTpAil60z6SuBJttRc/fH3W7fYd/6HqfllTLJaqL?=
 =?us-ascii?Q?ixGbek5Tcz5ukdlOOf/skz/hEMWHliWllWjYnFWP5il5cLjQgvVedhzmBxeG?=
 =?us-ascii?Q?6Jrqp0zO77zX5exD4F3iGi4ql852IaRAReb7EBBvIQzvSgKOzIW6mrgcLy1l?=
 =?us-ascii?Q?FTd95NxR8cSXl8Cm99MhlmIm2IJ9hHFAJ8SwydQXOHm4BFlCC8U9uNQWWT2o?=
 =?us-ascii?Q?OvpKsdDCWoOqG85bGlg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 19:25:49.3099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46549219-e824-48ce-f5a4-08de4e229082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
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

To allocate kernel BO from VRAM domain for MQD in the following patch.
No functional change because kernel BO allocate all from GTT domain.

Rename amdgpu_amdkfd_alloc_gtt_mem to amdgpu_amdkfd_alloc_kernel_mem
Rename amdgpu_amdkfd_free_gtt_mem to amdgpu_amdkfd_free_kernel_mem
Rename mem_kfd_mem_obj gtt_mem to mem

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c             |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 13 +++++++------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       | 14 +++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  9 +++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 12 +++++++-----
 12 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 67a01c4f3885..39c0b5a385c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -316,8 +316,8 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 					     &adev->kfd.reset_work);
 }
 
-int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
-				void **mem_obj, uint64_t *gpu_addr,
+int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
+				u32 domain, void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool cp_mqd_gfx9)
 {
 	struct amdgpu_bo *bo = NULL;
@@ -328,7 +328,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.byte_align = PAGE_SIZE;
-	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.domain = domain;
 	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
@@ -351,7 +351,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 		goto allocate_mem_reserve_bo_failed;
 	}
 
-	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	r = amdgpu_bo_pin(bo, domain);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to pin bo for amdkfd\n", r);
 		goto allocate_mem_pin_bo_failed;
@@ -388,7 +388,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	return r;
 }
 
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
+void amdgpu_amdkfd_free_kernel_mem(struct amdgpu_device *adev, void **mem_obj)
 {
 	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index da4575676335..274a99eb6d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -240,10 +240,10 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 }
 #endif
 /* Shared API */
-int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
-				void **mem_obj, uint64_t *gpu_addr,
+int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
+				u32 domain, void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool mqd_gfx9);
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
+void amdgpu_amdkfd_free_kernel_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 				void **mem_obj);
 void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 88fc430b9425..768998c82b43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2215,7 +2215,7 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
  * @bo_gart: Return bo reference
  *
  * Before return, bo reference count is incremented. To release the reference and unpin/
- * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
+ * unmap the BO, call amdgpu_amdkfd_free_kernel_mem.
  */
 int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index cd5a0b58c7d1..27176b2dc714 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -357,8 +357,9 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 		return 0;
 
 	if (!pdd->proc_ctx_cpu_ptr) {
-		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
+		r = amdgpu_amdkfd_alloc_kernel_mem(adev,
 			AMDGPU_MES_PROC_CTX_SIZE,
+			AMDGPU_GEM_DOMAIN_GTT,
 			&pdd->proc_ctx_bo,
 			&pdd->proc_ctx_gpu_addr,
 			&pdd->proc_ctx_cpu_ptr,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index db37c2949d19..6814316ef220 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -820,12 +820,13 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	/* add another 512KB for all other allocations on gart (HPD, fences) */
 	size += 512 * 1024;
 
-	if (amdgpu_amdkfd_alloc_gtt_mem(
-			kfd->adev, size, &kfd->gtt_mem,
+	if (amdgpu_amdkfd_alloc_kernel_mem(
+			kfd->adev, size, AMDGPU_GEM_DOMAIN_GTT,
+			&kfd->gtt_mem,
 			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
 			false)) {
 		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
-		goto alloc_gtt_mem_failure;
+		goto alloc_kernel_mem_failure;
 	}
 
 	dev_info(kfd_device, "Allocated %d bytes on gart\n", size);
@@ -951,8 +952,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_doorbell_error:
 	kfd_gtt_sa_fini(kfd);
 kfd_gtt_sa_init_error:
-	amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
-alloc_gtt_mem_failure:
+	amdgpu_amdkfd_free_kernel_mem(kfd->adev, &kfd->gtt_mem);
+alloc_kernel_mem_failure:
 	dev_err(kfd_device,
 		"device %x:%x NOT added due to errors\n",
 		kfd->adev->pdev->vendor, kfd->adev->pdev->device);
@@ -969,7 +970,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
+		amdgpu_amdkfd_free_kernel_mem(kfd->adev, &kfd->gtt_mem);
 	}
 
 	kfree(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 9bc80f8ba7dc..23889f84086c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2909,8 +2909,9 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 		(dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size *
 		NUM_XCC(dqm->dev->xcc_mask));
 
-	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
-		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
+	retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev, size,
+		AMDGPU_GEM_DOMAIN_GTT,
+		&(mem_obj->mem), &(mem_obj->gpu_addr),
 		(void *)&(mem_obj->cpu_ptr), false);
 
 	return retval;
@@ -3051,7 +3052,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 {
 	WARN(!mqd, "No hiq sdma mqd trunk to free");
 
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
+	amdgpu_amdkfd_free_kernel_mem(dev->adev, &mqd->mem);
 }
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index d9ae854b6908..f78b249e1a41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -54,7 +54,7 @@ struct kfd_mem_obj *allocate_hiq_mqd(struct kfd_node *dev, struct queue_properti
 	if (!mqd_mem_obj)
 		return NULL;
 
-	mqd_mem_obj->gtt_mem = dev->dqm->hiq_sdma_mqd.gtt_mem;
+	mqd_mem_obj->mem = dev->dqm->hiq_sdma_mqd.mem;
 	mqd_mem_obj->gpu_addr = dev->dqm->hiq_sdma_mqd.gpu_addr;
 	mqd_mem_obj->cpu_ptr = dev->dqm->hiq_sdma_mqd.cpu_ptr;
 
@@ -79,7 +79,7 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_node *dev,
 	offset += dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size *
 		  NUM_XCC(dev->xcc_mask);
 
-	mqd_mem_obj->gtt_mem = (void *)((uint64_t)dev->dqm->hiq_sdma_mqd.gtt_mem
+	mqd_mem_obj->mem = (void *)((uint64_t)dev->dqm->hiq_sdma_mqd.mem
 				+ offset);
 	mqd_mem_obj->gpu_addr = dev->dqm->hiq_sdma_mqd.gpu_addr + offset;
 	mqd_mem_obj->cpu_ptr = (uint32_t *)((uint64_t)
@@ -91,7 +91,7 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_node *dev,
 void free_mqd_hiq_sdma(struct mqd_manager *mm, void *mqd,
 			struct kfd_mem_obj *mqd_mem_obj)
 {
-	WARN_ON(!mqd_mem_obj->gtt_mem);
+	WARN_ON(!mqd_mem_obj->mem);
 	kfree(mqd_mem_obj);
 }
 
@@ -224,8 +224,8 @@ int kfd_destroy_mqd_cp(struct mqd_manager *mm, void *mqd,
 void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
-	if (mqd_mem_obj->gtt_mem) {
-		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, &mqd_mem_obj->gtt_mem);
+	if (mqd_mem_obj->mem) {
+		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
 		kfree(mqd_mem_obj);
 	} else {
 		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
@@ -280,8 +280,8 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev, struct kfd_mem_obj *mqd_mem_obj,
 
 	offset = kfd_hiq_mqd_stride(dev) * virtual_xcc_id;
 
-	mqd_mem_obj->gtt_mem = (virtual_xcc_id == 0) ?
-			dev->dqm->hiq_sdma_mqd.gtt_mem : NULL;
+	mqd_mem_obj->mem = (virtual_xcc_id == 0) ?
+			dev->dqm->hiq_sdma_mqd.mem : NULL;
 	mqd_mem_obj->gpu_addr = dev->dqm->hiq_sdma_mqd.gpu_addr + offset;
 	mqd_mem_obj->cpu_ptr = (uint32_t *)((uintptr_t)
 				dev->dqm->hiq_sdma_mqd.cpu_ptr + offset);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index a06b4e89af8a..558216395a4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -454,8 +454,8 @@ static void get_xcc_mqd(struct kfd_mem_obj *mqd_mem_obj,
 			       struct kfd_mem_obj *xcc_mqd_mem_obj,
 			       uint64_t offset)
 {
-	xcc_mqd_mem_obj->gtt_mem = (offset == 0) ?
-					mqd_mem_obj->gtt_mem : NULL;
+	xcc_mqd_mem_obj->mem = (offset == 0) ?
+					mqd_mem_obj->mem : NULL;
 	xcc_mqd_mem_obj->gpu_addr = mqd_mem_obj->gpu_addr + offset;
 	xcc_mqd_mem_obj->cpu_ptr = (uint32_t *)((uintptr_t)mqd_mem_obj->cpu_ptr
 						+ offset);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 2e9b6bcf2704..d234db138182 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -135,11 +135,12 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 		mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
 		if (!mqd_mem_obj)
 			return NULL;
-		retval = amdgpu_amdkfd_alloc_gtt_mem(node->adev,
+		retval = amdgpu_amdkfd_alloc_kernel_mem(node->adev,
 			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
-			&(mqd_mem_obj->gtt_mem),
+			AMDGPU_GEM_DOMAIN_GTT,
+			&(mqd_mem_obj->mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
 
@@ -665,8 +666,8 @@ static void get_xcc_mqd(struct kfd_mem_obj *mqd_mem_obj,
 			       struct kfd_mem_obj *xcc_mqd_mem_obj,
 			       uint64_t offset)
 {
-	xcc_mqd_mem_obj->gtt_mem = (offset == 0) ?
-					mqd_mem_obj->gtt_mem : NULL;
+	xcc_mqd_mem_obj->mem = (offset == 0) ?
+					mqd_mem_obj->mem : NULL;
 	xcc_mqd_mem_obj->gpu_addr = mqd_mem_obj->gpu_addr + offset;
 	xcc_mqd_mem_obj->cpu_ptr = (uint32_t *)((uintptr_t)mqd_mem_obj->cpu_ptr
 						+ offset);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d798baa7e52e..042b8e747b5b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -252,7 +252,7 @@ struct kfd_mem_obj {
 	uint32_t range_end;
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
-	void *gtt_mem;
+	void *mem;
 };
 
 struct kfd_vmid_info {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 82109f939c13..33153760d48e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1131,7 +1131,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 		if (pdd->dev->kfd->shared_resources.enable_mes &&
 			pdd->proc_ctx_cpu_ptr)
-			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
+			amdgpu_amdkfd_free_kernel_mem(pdd->dev->adev,
 						   &pdd->proc_ctx_bo);
 		/*
 		 * before destroying pdd, make sure to report availability
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a399770aa411..449be58e884c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -210,8 +210,8 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 	}
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart);
+		amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx_bo);
+		amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart);
 	}
 }
 
@@ -265,8 +265,9 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	(*q)->process = pqm->process;
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
+		retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
 						AMDGPU_MES_GANG_CTX_SIZE,
+						AMDGPU_GEM_DOMAIN_GTT,
 						&(*q)->gang_ctx_bo,
 						&(*q)->gang_ctx_gpu_addr,
 						&(*q)->gang_ctx_cpu_ptr,
@@ -298,7 +299,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	return 0;
 
 free_gang_ctx_bo:
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, &(*q)->gang_ctx_bo);
+	amdgpu_amdkfd_free_kernel_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
 	uninit_queue(*q);
 	*q = NULL;
@@ -368,8 +369,9 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 
 	/* Allocate proc_ctx_bo only if MES is enabled and this is the first queue */
 	if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
-		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
+		retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
 						     AMDGPU_MES_PROC_CTX_SIZE,
+						     AMDGPU_GEM_DOMAIN_GTT,
 						     &pdd->proc_ctx_bo,
 						     &pdd->proc_ctx_gpu_addr,
 						     &pdd->proc_ctx_cpu_ptr,
-- 
2.50.1

