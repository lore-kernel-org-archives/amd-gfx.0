Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DE2D5B858
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA5910E601;
	Mon, 15 Dec 2025 16:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="is3NP0Zu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E9410E5F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVU0zt4Jjjl/ifriaj/iFCh4f4jtDKkmdIf+28xejTBmOFZk5aem8G1D21t/ISXp2v42vJXvy4VEERiafVIwNfG7m6b/PLugep8wfE1Jb/igiT32YA9zA/11cv1kxk+xOK5ijXzHjeqpJa2IZwAcoIIpAlCfaOV9aY7wfUU3HhTK33KXNAGOK3CpIKscubdHduQTvLePbIMqsDhDsaACj818fqp3UA8aaNyEk9ImfNcoeP5MPl29csesWp4Vz695ZPjGZiYZoETjWSKGzoawM1X1JGxQaUweTFejQo8xzkZ4SMs8XibmvHzEEfj/5r+CHakj1WtL/TKTlJTQkzy57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIWekGUhpjPwzHSJYXoKfscFs/0j+dJnDJJ8altfvSI=;
 b=LOzVpOcgdyIpwxuc6tSE2uLpZ92RBggsOuSpuCm0Ti+hq7Ph8TZ6fiaEW22e5w9NZDavKZTK37i2+bvFwwCr5q7FGXxnoofA50MqwLGNBXLVYkGPEWrr/DoaZDPaUHRfSukUiI1FusNAelc067ySZttij3uDj2MnZouC/JsN4IEOlt44SidDPAl/rwVsByQRSNkO/OK+Vh2zsfQ8XAExTnFR1fFYwanVzbtCES3LBrdtDTD4BQdaF//hU4IXycRMT5o0yhSKOdnHF9ol8bwuLTDXxh7U2getxL5J/VPtwLkyaBgAxEVXTj+6aBrrclTmwZBLq39V2LLhT1cZZlARZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIWekGUhpjPwzHSJYXoKfscFs/0j+dJnDJJ8altfvSI=;
 b=is3NP0ZuUMwJOxB3nYmDT9nvtQPqGyiY/uKcVIGVkrgOWG3nUzBM0etUFvHFH4hdNRaGxpORmWH1AF+1q0rcqIIh9Lla1LxCoOKNlxHogZiJ75A6WQmTL8Kh58jxGXEOW7PJViiC57UIh617uHLbC0LCDwluIIel0rBaGXZuPG0=
Received: from DM6PR06CA0043.namprd06.prod.outlook.com (2603:10b6:5:54::20) by
 DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Mon, 15 Dec 2025 16:57:11 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::2d) by DM6PR06CA0043.outlook.office365.com
 (2603:10b6:5:54::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:57:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:56:51 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 6/6] drm/amdkfd: Map VRAM MQD on GART
Date: Mon, 15 Dec 2025 11:56:30 -0500
Message-ID: <20251215165630.1172383-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215165630.1172383-1-Philip.Yang@amd.com>
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d0fb96-40d8-4078-04ea-08de3bfafd8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L1xl5hNDmZBRCCR3vzHf8aGqh6gk/iDodCZRCpcggkFYbnp31TEoJvddpFla?=
 =?us-ascii?Q?+0EQGq/Fpqb05POkKA36sF97L3sOj0SBcdccicJlTRLoZ30qFE8U/Pdk7pFT?=
 =?us-ascii?Q?/eNIYEVQz87q/1LdI8bi8k6kUPuVJnmkkwaqByWRSn1pkbinBY2y5Vl5a1M4?=
 =?us-ascii?Q?4tkp8/M3yLEeCBbqNIcUimg94O1S4U30waAPVh4TH4X8EmvnzFwZE6+cdl/F?=
 =?us-ascii?Q?qvDh5CoUHJgoRtXLOcHltQ8KD5MmvYcTkAOMEp5VMkgsdZace8zmxdosK931?=
 =?us-ascii?Q?dTf3XvkFt24D4nYS5/H7oHGdN2CbpyfYytJm2LZe3TXMdbhiBhl5do8BX0it?=
 =?us-ascii?Q?AoF9QCY7EizlYMBRFL+qfFgxglsECt5xxYM5WvfQG4K2DKzQf13mOclbywlv?=
 =?us-ascii?Q?bLFcKIzKFuqhVqN0UMM1EXtgH4CYDJUmvXGdNLtEjhrJlwqJk1v+lqdQRi9D?=
 =?us-ascii?Q?XpCmlAb/4WUdSTJvvzrU5EfWQ10XJTPSPSAyibLyFAoXZSFN+XV62dCXoRT0?=
 =?us-ascii?Q?M+4VaOAqAKDGASztVF+eTQQJ24+rqwVYG91pd3KOWBSGkNg0roa2p7mafEae?=
 =?us-ascii?Q?kXhgM3cZwMDFXK7auZeM8iDq9BP4/QN8qfPjyFQp+JCKloLc4eJxwKlYArLm?=
 =?us-ascii?Q?8aC+Psyx9BkVW2uRrQHYNSOnFHCOdJZce8qdO+P3jjdvg0GK9ZIxiHxk8mFH?=
 =?us-ascii?Q?lpS8PuIuu21iiNLF3mCkVEhslmAMcywlftot53oMgXxSV0vj/m/aSgZgOmfs?=
 =?us-ascii?Q?gAwJsgNIoRv6q9Q/v0kjI+OMgiBPhVsH5HVWNB3LTtWAPceDRKXigjXu7jzF?=
 =?us-ascii?Q?3dUEP/ke8tOtASsNaZ3qj2dDnHm65kufx7MA/Fk6gwmPIVXJLlWkLIjU241+?=
 =?us-ascii?Q?CEkCMRtmn0bTgnDvt40Q4M6n24p7YTcEsMtjGhsmUCEFDKCk8Mntb7z3UkGn?=
 =?us-ascii?Q?rHLPZXpl98r6LvK+/D4Clc5RsthRKm01dQfmGVpCoAaWBOppLiWY9EMWmGM1?=
 =?us-ascii?Q?p8Z4KPZe9/6rLWTs9RjLmjP7hze0Rs+IJm3BawTXNMVtJTJyZ8AIvFAFYAq9?=
 =?us-ascii?Q?9wxorOGx06sIbhS6K0ToBTdxqWiCozErU9dN6nRHd23+tzOdibSMcLpNCwNL?=
 =?us-ascii?Q?uWpdHrw7XDrSAkqJjZx1rK03k1AwAHHD43uTzq5d5LetDxd4mVwWMZapHUrH?=
 =?us-ascii?Q?V1dnJLv5fMdxBj1TBBXRugj9vhX0wzvO5uMnq/uOVXxNgbKhIHXtU3bfMyvg?=
 =?us-ascii?Q?IA5jaBcRZB6St2ISnY6Vl6xkOb6JTWa0EoSYCpubFzzkyzCMxvx/DZUzrT7U?=
 =?us-ascii?Q?zIOy6JV8D2k0QVrDoHepGRRUCKGj1CtLaNVw4DK7RoKWn01UrU2nz5WUcl22?=
 =?us-ascii?Q?bv66xDcUf+LMeq0YAFW7EC+O6gdjpaLgNGaM3ulFj2R1pEIV/DD2GG7xL2QX?=
 =?us-ascii?Q?Xk0VcUjZw8fOsGvC4LXii9w12//EAtTJZmPMI4b3FSt91zL4lxpKLLA+MCMk?=
 =?us-ascii?Q?FVAuFD0aSMBhE6GutGhEwflQoVRVs5v3KOt3mhf0DZJBiCBmvRssLra76Bby?=
 =?us-ascii?Q?f+pKljETwru4To1z0g8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:57:11.4078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d0fb96-40d8-4078-04ea-08de3bfafd8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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
to GART as mtype RW caching, to reduce queue switch latency

Add GART mm_node to kfd mem obj to free the GART entries after
MQD mem obj is freed.

Use resource cursor to handle VRAM resource which maybe on multiple
blocks and use cursor_gart to handle GART entries.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 94 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 5 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4f8bc7f35cdc..d7bf96a7b6b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -880,6 +880,67 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	}
 }
 
+/*
+ * Same function and MQD description from amdgpu_ttm_gart_bind_gfx9_mqd,
+ * except this is for MQD on VRAM BO and use dynamic alloc GART entries.
+ */
+static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
+				struct ttm_buffer_object *tbo,
+				struct drm_mm_node *mm_node,
+				uint64_t flags)
+{
+	uint64_t total_pages;
+	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
+	uint64_t page_idx, pages_per_xcc;
+	struct amdgpu_res_cursor cursor_gart;
+	struct amdgpu_res_cursor cursor;
+	uint64_t ctrl_flags = flags;
+	int i;
+
+	total_pages = tbo->base.size >> PAGE_SHIFT;
+
+	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
+		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
+
+	pages_per_xcc = total_pages;
+	do_div(pages_per_xcc, num_xcc);
+
+	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
+	amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
+
+	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
+		u64 start_page;
+		u64 npages, n;
+		u64 pa;
+
+		start_page = cursor_gart.start;
+		pa = cursor.start + adev->vm_manager.vram_base_offset;
+		n = 1;
+		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
+					   flags, NULL);
+
+		npages = pages_per_xcc - 1;
+		while (npages) {
+			amdgpu_res_next(&cursor_gart, n);
+			amdgpu_res_next(&cursor, n * PAGE_SIZE);
+
+			start_page = cursor_gart.start;
+			pa = cursor.start + adev->vm_manager.vram_base_offset;
+			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
+
+			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
+						   ctrl_flags, NULL);
+
+			npages -= n;
+		}
+
+		amdgpu_res_next(&cursor_gart, n);
+		amdgpu_res_next(&cursor, n * PAGE_SIZE);
+	}
+}
+
 static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 				 struct ttm_buffer_object *tbo,
 				 uint64_t flags)
@@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
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
+	if (amdgpu_mem_type_to_domain(bo->resource->mem_type) !=
+	    AMDGPU_GEM_DOMAIN_VRAM)
+		return 0;
+
+	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
+					 amdgpu_bo_ngpu_pages(abo), 0);
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
index 25640bed7dc9..9f07856433fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
-
 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 				 struct drm_mm_node *node,
 				 u64 num_pages,
@@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
 		       u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
+				  struct drm_mm_node *mm_node,
+				  u64 *gpu_addr);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index f78b249e1a41..edb72f4ef82d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
 	if (mqd_mem_obj->mem) {
+		amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
+					    &mqd_mem_obj->mm_node);
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
index 06cd675c9e74..55738b30c2ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -253,6 +253,7 @@ struct kfd_mem_obj {
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
 	void *mem;
+	struct drm_mm_node mm_node;
 };
 
 struct kfd_vmid_info {
-- 
2.50.1

