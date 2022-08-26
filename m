Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75EAECAAD4
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 23:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6008110EA75;
	Fri, 26 Aug 2022 23:17:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18AFC10EA75
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 23:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goGA8gGNq5fFdENwThy9WjOqLQ8gj4JSC3Ct8VMTY8V1298jgAXD5EDPbJ/Tiz8sOTMgSERT+1yy24KkJ2nMV9UE7rRhOhB4OpVEhUyYMYh9AyPYvtApdtjpruxPYjtzoYnsvow1uiq6HbQe/vNBJ0zkSHlyNnLZ9F4EeBmNqEvKeRB8QwdHiCp940WiJgVlQ76tccqg4QBRn6qGZ8f7g4ya/8fwE94x/jy3HRDdAE2vSI4FZA2bUg+GavBI19U29ERVxA2nmff7/TlvxEkbPJXU/ezjpx2FruSoExEK9r06Hv1gne1138bLstHdjt2C+liCvwxMsXeuPmw5FbU3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+MFpvIq52miufIdDzq67jNXAxNx3gJTdTt4DWa4mcg=;
 b=jihrJLSs5uxAQDdX+1uazaxMI+QDurFXbEMEmb46Kq7VRZnVXlVcK5P0UXcV5cxtS/OGTpuyekw2ylmmGHgE1t0goXrQNbLsuEIYpQrId4xo7TF9gm6GKRSyCRDqS/4xc5+etezM4tQVdJn02zWy4O4c4sbbcWVIIEM+X71s8WsbrDMBCoOSueCV8E9GHu8p5U1HTDRgVqL7JwaV+OmnEnjnxBPMqF6UqzEAppE6msNIKNfcmoz98MJ6YEbYNyff6hP8PkbP2QjzT2Dmo1x+Dp66P4ycoknBwJ97uRM/SMXRtmq2XsKDXHuNx0c32pLti6n7PYp8EIJoJpc9bNt/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+MFpvIq52miufIdDzq67jNXAxNx3gJTdTt4DWa4mcg=;
 b=zOHjIBDo97uz2atPH+D8WECB5IBcC7Fg3yM5P3JtGXTTApOCMH28eDC5Vk00cfH7NOOve8nFXmC0VTN31YNlWXlDir71AEx9jEiJYm+oQgY5nStzyCiARGhnpPL9ls1HyEg3rw3XP6A+aj2Ul6TVy0eIOqfbSFttV8gNVSll0Jc=
Received: from DM6PR01CA0003.prod.exchangelabs.com (2603:10b6:5:296::8) by
 BN6PR12MB1938.namprd12.prod.outlook.com (2603:10b6:404:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.18; Fri, 26 Aug 2022 23:17:21 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::95) by DM6PR01CA0003.outlook.office365.com
 (2603:10b6:5:296::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 23:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 23:17:21 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 18:17:20 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Set pte_flags for actual BO location
Date: Fri, 26 Aug 2022 19:16:54 -0400
Message-ID: <20220826231654.335169-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a92c3fd9-ffbe-4fdf-c9b3-08da87b920db
X-MS-TrafficTypeDiagnostic: BN6PR12MB1938:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mk9P2xuP+8+r5WHYCmszPoWXyM8j1XVM+NMknZtuRZ/GWf7mUPw40o89D021cnDgwu+XMfiTsNwszDyA4WuNEGrDpC3nbP8GyXzsmYGlxQhbGbJv25OXO8n9E0z4tLw/xALto6yqvBaHvBahW0w+5Awps14JvbToqb1bL0UICoaOLkhOj5y8A3/p+hxSikM49/IDmQQxQEIFig3y1e91EZ7i2a3SI/7uTZIu3Nv/AEAxBF4whcfmZBbmkt5BxATsnHPJZDUwg9CMbUCWw78+VogTGZAPnlLIks9C24nnONxlf2ayQp5u/2PW7wTVVfnQaUbxRggLGN2uwS3H9UbcqH2eDtNgmJN9nWFIBFAmAA3hkGVEDE7bjXWRbQCpSbMC1/1JxBVpwebZMLXPvpk5QkhUXlmNS6fi8UGNmPpC/8d9FPLrQcVRgucAhB3tX6vvGtqrlY9JhSbgEDdAYI7Y2Pz6ezhBmjIpaRvOTcw0JMmOg2b6D3tWsmwWqpHYMrWZEASidJWzKPHspBGRYxUrgXcKgNZMParu15KgujqVCXZt8PuC99g8kQ23kBGaE6zzGTr0m+Cd3GJYWJ9iaZYluv/j13EIPksjqvmjZBY/GGXvkAEb1dM9adA6nLgP3xGi3CnOnjmXuVkoJ6MR4nvduje/Ao8mxNoROZvk3DGRIv6G7C9lQqltT1m8fjJAK3y8TToW3uJVPN6vtjLGCw6NZakh2xNc+WsMVapA/76H+ZnQpULK71MTcjiDpTl53Wi7q8FC4rdWWVDbbhxwZIjyQkuSJf+GDikm9F9zsM2OGywQmIVpfZDxG6hWv6XPAexP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(40470700004)(36840700001)(2906002)(16526019)(186003)(47076005)(336012)(426003)(83380400001)(40480700001)(36756003)(81166007)(6916009)(5660300002)(8936002)(36860700001)(1076003)(82310400005)(2616005)(82740400003)(26005)(70206006)(6666004)(70586007)(7696005)(8676002)(316002)(86362001)(41300700001)(356005)(478600001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 23:17:21.5227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92c3fd9-ffbe-4fdf-c9b3-08da87b920db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1938
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

BOs can be in a different location than was intended at allocation time,
for example when restoring fails after an eviction or BOs get pinned in
system memory. On some GPUs the MTYPE for coherent mappings depends on
the actual memory location.

Use the actual location to determine the pte_flags every time the page
tables are updated.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 +
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cbd593f7d553..5dd89f5a032f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -405,6 +405,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
+	bool is_vram = mem->bo->tbo.resource->mem_type == TTM_PL_VRAM;
 	bool coherent = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
 	bool uncached = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED;
 	uint32_t mapping_flags;
@@ -420,7 +421,7 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 	switch (adev->asic_type) {
 	case CHIP_ARCTURUS:
 	case CHIP_ALDEBARAN:
-		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+		if (is_vram) {
 			if (bo_adev == adev) {
 				if (uncached)
 					mapping_flags |= AMDGPU_VM_MTYPE_UC;
@@ -1236,12 +1237,18 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 {
 	struct amdgpu_bo_va *bo_va = entry->bo_va;
 	struct amdgpu_device *adev = entry->adev;
+	uint64_t pte_flags = get_pte_flags(adev, mem);
 	int ret;
 
 	ret = kfd_mem_dmamap_attachment(mem, entry);
 	if (ret)
 		return ret;
 
+	if (unlikely(entry->pte_flags != pte_flags)) {
+		amdgpu_vm_bo_update_flags(bo_va, pte_flags);
+		entry->pte_flags = pte_flags;
+	}
+
 	/* Update the page tables  */
 	ret = amdgpu_vm_bo_update(adev, bo_va, false);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 59cac347baa3..954a40d5d828 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1862,6 +1862,25 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	}
 }
 
+/**
+ * amdgpu_vm_bo_update_flags - Update mapping flags of invalid mappings
+ *
+ * @bo_va: identifies the BO and VM
+ * @flags: new mapping flags
+ *
+ * The update is only applied to invalid mappings. This allows updating the
+ * mapping flags after a migration to maintain the desired coherence. The next
+ * call to amdgpu_vm_bo_update() will apply the new @flags to the page table.
+ */
+void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va,
+			       uint64_t flags)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+
+	list_for_each_entry(mapping, &bo_va->invalids, list)
+		mapping->flags = flags;
+}
+
 /**
  * amdgpu_vm_get_block_size - calculate VM page table size as power of two
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9ecb7f663e19..11793716cd8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -413,6 +413,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 			     struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va, uint64_t flags);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
-- 
2.32.0

