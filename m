Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F26AD3B7E2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 01:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30CE10E472;
	Tue,  9 Dec 2025 01:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w7u28855";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FABF10E45E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 01:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEsxiYfxojmgg0WZXV+RIDNvYSs0bqXFkEawupgmb9ZighS4uSKMICNkPhRG1FGiVBePfif9fA0IjdLRN/y9U/naZ5MGSWlZwxYHe16fMVwWiSql1TjR4jpC0k70tckbsMkqluMuX68IS+9KAnRuzrSC1cC9O5kAN9aGgTlukOHclTgnMmXZoiA+rJ3jh0yI7qgJN11qbrEejzYyezBx32cobhxAE3i8qgMOzfLhWigJhpr2gK29o+UJLWhADT8eERRb55xYiyEywC4VtGoj3frAx/1SL99dyr8eKZC1DagJsQ9OqU64x13+aja9bjdbCynoo+Gyh7FBPiT0L0lBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiePvT/a++E6DWe1OHEmMaDNGVPr/gpjlbxj0aRlUD8=;
 b=Perq8+tePE6pYjMdz6o8Wy6PGXGJsbdRAx5IyYdrgtLNtAZ+0O1Tecccyg+kPP6faOzmEprFn9gbNDQ0yRa71TSCbbeajRZsXNN5ZSTdVGmUfvahfNijN77UpexoUZkLJnNitBhz93m60XWSdNafKMbar0elrpgDG6bQEcj13/4vE1qVgj8NbY08ydf3z1oebEp/Vru/eiV6N84I2USq57FzBFv8XMvyBn+Hs8HomQl3QUUVhpxkI4E269TL58zmKPj7jIQA75RtCYMNXIBj7odtcshkSPWi80Ts7hTizVxINv9fngLNMc9S8BguztMyRmP9vJoyNVJBQ5zTIyarIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiePvT/a++E6DWe1OHEmMaDNGVPr/gpjlbxj0aRlUD8=;
 b=w7u28855XMgxRH/Ea2BO3xsXL4b8JLW7ug4C+JGE2LfQZKEJ8az/k95c9uxY7IZU9n2F78dgGiATEiOz/09DcpYdSmS8bRGd8Pj3ZO7rmaTnuAReGIfVKtyhdABT3Z1gTXCAh1hzxf6Ku+w1XWabQUF3gVimaphBVICnuZnTPho=
Received: from DM6PR04CA0006.namprd04.prod.outlook.com (2603:10b6:5:334::11)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 01:26:15 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::49) by DM6PR04CA0006.outlook.office365.com
 (2603:10b6:5:334::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 01:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 01:26:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 19:26:08 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v4 5/6] drm/amdkfd: Map VRAM MQD on GART
Date: Mon, 8 Dec 2025 20:25:36 -0500
Message-ID: <20251209012538.3882774-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209012538.3882774-1-Philip.Yang@amd.com>
References: <20251209012538.3882774-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 386ffb38-bd3a-4220-8653-08de36c1f263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BJnkO33LIjpm7JM/mPwX2nNYYHuCipBRg6gbpyDHPEOVOw0WhrhC9YHkJWiE?=
 =?us-ascii?Q?2gPB5GEFRP9ROhcxF1ts3CvnHeU2acJjnQqDK5PeCQ13OLIeHRFaug3jK+8+?=
 =?us-ascii?Q?hRbfJw+iKIy1F7K5PPUHsUFURKg4GKGncsGVBQNIf5Mxli4fwmv4gWORUZhA?=
 =?us-ascii?Q?LvOS9SAMNGcNCtALqsk7p2NWS2CLGQJgH069WonmRVaAoy2OakjGL1AnerhU?=
 =?us-ascii?Q?jjSmibm1Zwhblg2UVB+3f/sAPXwenRagqeWYHzPokdkXpa6FQ6/RTpq4vsU4?=
 =?us-ascii?Q?WVfPTlbOk2vLwegq+vkfbPOLhvV3ZJ3JLfYZpB+Ie05Q4AsVucOv+BNxqazj?=
 =?us-ascii?Q?BdyrEiri1/n61KB4foS+s4ss8LWJCo/M+s6DXH4zHcpT3BDCJMRhXHcSH5Tk?=
 =?us-ascii?Q?UAYutp3XPlwef2KEIjvTnBPsrj07bHyhZdvKEM9jHZoTn0vOptnYSKEvj3dA?=
 =?us-ascii?Q?qYMj86YMLo7HDzSpB+Z8AL31MW82ebTg6lI65kOP+AO6eT3u8IWbQJGFumNu?=
 =?us-ascii?Q?Z6vImRpAW0LMhxEAiIp1rOmRLfqLI9rtRY6LRqkD9Sq2ZWgyJyX2sPQ501Cy?=
 =?us-ascii?Q?eNiyQvtqIZ69MGZOCOThbZA1xDro+4D6pAsa/AQSdP+PFlc3XneZTyfZLk44?=
 =?us-ascii?Q?GG9j/k57lSEQ3WB+9iR4cfNad3o4xSuRSyf0s+MCqBt6SUavpYXsV+IIrObK?=
 =?us-ascii?Q?PbXVX93Y7Al3ELxpRr8ZLDkVxheDhb9kOeBvQAdYK/6Fl/P1IpPjw6mrZdTR?=
 =?us-ascii?Q?5tElDi/yPlKEhbpVMDbmakJJwgUBGYkGmsKuQYimsK1bOM/A/UYWcuVocO8Y?=
 =?us-ascii?Q?NSy1fB9PWfO+DRrd8YLO6OuehvEmsqp5hbGrQ3qrM8xqLtgGBwa2UTg2Yv46?=
 =?us-ascii?Q?tHj8okq5VKCr/gEfhysnD0hunldifQMgvSBUncVjtbQ/ro9Qo8D6iTScLZDl?=
 =?us-ascii?Q?j4kp8dutNhnURrIYaDqI0Pw0VcDZxPN7l9o9tIvFd8fVbFSXnm7zlOWcb0uc?=
 =?us-ascii?Q?Pc2xWbvGM72d7cjg8okt3R1qWOboq48pVRps38fkvY0PZqwf3O6z3RnB/2H7?=
 =?us-ascii?Q?jt1L91YWAsJ8nkvQzBMBj3oFxxqUMNKtGWgaUViyZjYCcYpxKXzTK/i5GN/4?=
 =?us-ascii?Q?y1GK23lc0hLXy59Hvy5UZRMKMxZQWsfDArZkQEnNwew5SF2FxI34QOh8l9aw?=
 =?us-ascii?Q?heVUXA/qNf54EBr7Ghshl5LJzwpq5cFQ0ingdWjj8LeSmS4o7gX8kvyrv9o9?=
 =?us-ascii?Q?XX0fGjBScONiZoVnmIGiuI9RzRLnlnw8USFJDwaEQNATPmZn0k+vKgnhvY+k?=
 =?us-ascii?Q?uWAqCwXFrZQtL8hidYU8blN6aTZckk4x2NEak+ocmMo0okbsaABRrLEvkHQ2?=
 =?us-ascii?Q?lpolVwItXLUZuSNesmdZiRWEn5H6bJs6raf5THAa0DmTQ10nblunUmX7ulQW?=
 =?us-ascii?Q?s3Tikn1N4wg5kpJiUanZ5ExcLhAHDuh3WDOzcBDYDkQfqF6wHGgfBWToMtX0?=
 =?us-ascii?Q?ROd1LEuYrb2sDbntPgRB8bybIjZBhC6+3CbF4a4CRnwUtAu14LSfeMRcn8G7?=
 =?us-ascii?Q?0fNatYgV6/OcszR7s/s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:26:15.5892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 386ffb38-bd3a-4220-8653-08de36c1f263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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

MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
to GART as mtype RW caching, to reduce queue switch latency.

Add helper amdgpu_gtt_mgr_alloc/free_entries.
Add helper amdgpu_ttm_gart_bind_gfx9_mqd_vram to bind VRAM pages
to GART entries.

Add GART mm_node to kfd mem obj to free the GART entries after
MQD mem obj is freed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   | 37 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 71 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 10 +++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 6 files changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 895c1e4c6747..c83e1cf1f02d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -321,3 +321,40 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
 	ttm_resource_manager_cleanup(man);
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
 }
+
+int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_device *adev,
+				 struct drm_mm_node *mm_node,
+				 u64 num_pages, u64 alignment,
+				 unsigned long color, u64 range_start,
+				 u64 range_end, enum drm_mm_insert_mode mode)
+{
+	struct ttm_resource_manager *man;
+	struct amdgpu_gtt_mgr *mgr;
+	int r;
+
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
+	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
+
+	spin_lock(&mgr->lock);
+	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
+					alignment, color, range_start,
+					adev->gmc.gart_size >> PAGE_SHIFT,
+					mode);
+	spin_unlock(&mgr->lock);
+	return r;
+}
+
+void amdgpu_gtt_mgr_free_entries(struct amdgpu_device *adev,
+				 struct drm_mm_node *mm_node)
+{
+	struct ttm_resource_manager *man;
+	struct amdgpu_gtt_mgr *mgr;
+
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
+	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
+
+	spin_lock(&mgr->lock);
+	if (drm_mm_node_allocated(mm_node))
+		drm_mm_remove_node(mm_node);
+	spin_unlock(&mgr->lock);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4f8bc7f35cdc..43009d3809b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -880,6 +880,42 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	}
 }
 
+static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
+				struct ttm_buffer_object *tbo,
+				struct drm_mm_node *mm_node,
+				uint64_t flags)
+{
+	uint64_t total_pages;
+	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
+	uint64_t page_idx, pages_per_xcc;
+	uint64_t ctrl_flags = flags;
+	int i;
+
+	total_pages = tbo->resource->size >> PAGE_SHIFT;
+
+	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
+		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
+
+	pages_per_xcc = total_pages;
+	do_div(pages_per_xcc, num_xcc);
+
+	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
+		u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
+		u64 start_page = mm_node->start + page_idx;
+
+		pa += adev->vm_manager.vram_base_offset;
+		amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
+					   flags, NULL);
+
+		amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
+					   start_page + 1,
+					   pages_per_xcc - 1,
+					   ctrl_flags, NULL);
+	}
+}
+
 static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 				 struct ttm_buffer_object *tbo,
 				 uint64_t flags)
@@ -1017,6 +1053,41 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 	return 0;
 }
 
+/*
+ * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
+ *
+ * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
+ */
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
+				  struct drm_mm_node *mm_node,
+				  u64 *gpu_addr)
+{
+	struct ttm_buffer_object *bo = &abo->tbo;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
+	uint64_t flags;
+	int r;
+
+	/* Only for valid VRAM bo resource */
+	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
+		return 0;
+
+	r = amdgpu_gtt_mgr_alloc_entries(adev, mm_node,
+					 amdgpu_bo_ngpu_pages(abo),
+					 0, 0, 0,
+					 adev->gmc.gart_size >> PAGE_SHIFT,
+					 0);
+	if (r)
+		return r;
+
+	/* compute PTE flags for this buffer object */
+	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
+	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
+	amdgpu_gart_invalidate_tlb(adev);
+
+	*gpu_addr = mm_node->start << PAGE_SHIFT;
+	return 0;
+}
+
 /*
  * amdgpu_ttm_recover_gart - Rebind GTT pages
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 72488124aa59..eff536f12cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -140,6 +140,13 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
+int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_device *adev,
+				 struct drm_mm_node *mm_node,
+				 u64 num_pages, u64 alignment,
+				 unsigned long color, u64 range_start,
+				 u64 range_end, enum drm_mm_insert_mode mode);
+void amdgpu_gtt_mgr_free_entries(struct amdgpu_device *adev,
+				 struct drm_mm_node *mm_node);
 
 uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
 
@@ -185,6 +192,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
 		       u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
+				  struct drm_mm_node *mm_node,
+				  u64 *gpu_addr);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index f78b249e1a41..0bf9c35112fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -225,6 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
 	if (mqd_mem_obj->mem) {
+		amdgpu_gtt_mgr_free_entries(mm->dev->adev, &mqd_mem_obj->mm_node);
 		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
 		kfree(mqd_mem_obj);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 14123e1a9716..5828220056bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			kfree(mqd_mem_obj);
 			return NULL;
 		}
+
+		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
+						       &mqd_mem_obj->mm_node,
+						       &(mqd_mem_obj->gpu_addr));
+		if (retval) {
+			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
+			kfree(mqd_mem_obj);
+			return NULL;
+		}
 	} else {
 		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
 				&mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 29419b3249cf..fdde907836fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -252,6 +252,7 @@ struct kfd_mem_obj {
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
 	void *mem;
+	struct drm_mm_node mm_node;
 };
 
 struct kfd_vmid_info {
-- 
2.50.1

