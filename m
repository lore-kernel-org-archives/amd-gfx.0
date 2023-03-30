Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E266C77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E7610EFFE;
	Thu, 30 Mar 2023 19:43:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E754C10EFED
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM3eHLlqstTiwzGNddcWw2EhgQwl5A8T5bgVyNy2M6UTTQJefogQIilovT+T2Np3tR8rvPdQbhkG7J/DYUORDbagDCiNaiyUup0cEH4XS5e/Q/3vzMAdltQRclgekA9nTiMUsAee6sQQBbCNfolkBRiXy+YHEg1bMn0iTlbefvgSL/X2A6zRCiV4JWqGFbtyWs3OP8N4qNOTKUldhI/JFNr4YeOyqsiBEru5kj8HAIEkG+S3SwYKGTiTCfbdUt4cMFuj676L1F3m+GJZXsqjJOxGp/yxTbYl+lfi5RqGkwUJ9+3lg2m5EZaYBxE1OoB1J/ZyJtuGvGHwwOE0QIvIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBE+zMlzRaMv5kC+dB4bEIp5QuN+xZpQB9W3GDV6X28=;
 b=IwJj8hICRqcgFaAWDOQiQrquqGhz8xgGHvrRcBn3hTwp5mS/CfHg4WIPUDl/W1Lfxk/yS4kDYWgJ0PXvFsFoQ8YDhp1tpsM9x4gIi3JNDjbE6VTQWwnhPYzYdqebfDHgtYUutKNFX+RbbHQl+TMAqDSwhSvog+HTjwph1PubY+8fe/8zhfDuyDADlQgeV3/CJ3IwWAn4BuCyuUqxRQjR+uD6MD4v1SrgenJtN5AVVHQvBSzL/drOzcCpuIctyApDqPsVwWAa1cOjrB/g4RKUd36G1I/LQaNgGx6aTEjZVzwgkdaL3CRykomsAL4Fhwa9qs3/Ha7eHl1FtFCE/hvCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBE+zMlzRaMv5kC+dB4bEIp5QuN+xZpQB9W3GDV6X28=;
 b=HKhiuIhFrib8wxKhhUTKfUWw13ERfFEz/NL+LTqRjtYEBRNyiTg2D2q2xnByMqwqS8OrT5RJbd9VTLjx4V7KEMs8F2M+crtqza/pR1VIQQfybv16SRKy/f0HgH42cvsd+3il+TE/JsiGpctsy9K1VWy3l+YiC+KYAuSG75ftF6U=
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:42:57 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::71) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/23] drm/amdgpu: Allocate GART table in RAM for AMD APU
Date: Thu, 30 Mar 2023 15:42:30 -0400
Message-ID: <20230330194234.1135527-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f07b96-181f-406e-45c4-08db3156f6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgJI5jNPiTV9ldusPrS2MoJHf9beqy+jGnVJkcBIOuY7g72pfr9KW7+nz+CTKIDZe9d/p3xHhm+WqGFGTfaih99K/26AJf0kERmgBEmj7azEBHlGYaAY17Xd3Cid8XIJMbG15nRYeXC9s9FMbiYEPfaslz/HE82Rhfdh4hy9iHv/xwcO5h1kCF6W4zIWsd3X8m9gb3gGB3arGgonbSCxxouETGoeu4AjyRRSVbixYBrWJVFbU5sDFLG/iAogoQaXczN/Bvn43kAXsBF43suH8LUH6yEsRldtF+Q+iXWmqQoinlOun60jpRz/KZrwdbIa6ACwkMj+9V85feiy+2UHoYQO16gPartH0zxXCp0i4tdy6KMkzb9jLizV/nL0SzET8l9JctcU/Sr9aIVKcxyJ3nh4anWDz7FXlqa5p10mvrdagiC0HACTLm3RmNW3BuAF4EUhaECGXVw0BGDB+FqVl7cwTV9g/1EGrKeagtHUVHPBYm/3vJIKXb/j4Vc/qKZsI+snrORNBY8fdgHnM60zr/Ww9IMqyAVGAoer8Q2DY3kZz/nRY66f4rEgstmXmV+wTkI9we5DOI84lI8y+fwnYE0AnJ0+6rOQuHRG/QlvKjWRv98lwll5ENNPI/zHTXiXVU2Qq9EqLjJLuyK2455Ur2A2wRYU/uM3pKEa91LvLYIimrZw8P3I9/pxSc3SzYc65aAKqQkRl97dzLkP73LE53GxWthAxTmDtNpZgO7k0f8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(2906002)(81166007)(4326008)(356005)(86362001)(40480700001)(36756003)(82310400005)(40460700003)(41300700001)(8936002)(5660300002)(6916009)(316002)(478600001)(54906003)(6666004)(7696005)(1076003)(26005)(70586007)(8676002)(186003)(83380400001)(2616005)(426003)(70206006)(336012)(16526019)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:57.7512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f07b96-181f-406e-45c4-08db3156f6a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felix Kuehling <Felix.Kuehling@amd.com>

[NOT FOR UPSTREAM]
Christian prefers to use another TTM based version for upstream so this
should be used on the NPI branch till the said patch lands on the
upstream list.

Some AMD APUs may not have a dedicated VRAM. On such platforms the GART
table should be allocated on the system memory. When real vram size is
zero, place the GART table in system memory and create an SG BO to make
it GPU accessible.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
(rajneesh: removed set_memory_wc workaround)
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 136 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  23 +++-
 3 files changed, 155 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 6b12f4a75fc3..aebc163ade69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -102,6 +102,142 @@ void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
 	adev->dummy_page_addr = 0;
 }
 
+/**
+ * amdgpu_gart_table_ram_alloc - allocate system ram for gart page table
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Allocate system memory for GART page table for ASICs that don't have
+ * dedicated VRAM.
+ * Returns 0 for success, error for failure.
+ */
+int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev)
+{
+	unsigned int order = get_order(adev->gart.table_size);
+	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
+	struct amdgpu_bo *bo = NULL;
+	struct sg_table *sg = NULL;
+	struct amdgpu_bo_param bp;
+	dma_addr_t dma_addr;
+	struct page *p;
+	int ret;
+
+	if (adev->gart.bo != NULL)
+		return 0;
+
+	p = alloc_pages(gfp_flags, order);
+	if (!p)
+		return -ENOMEM;
+
+	/* If the hardware does not support UTCL2 snooping of the CPU caches
+	 * then set_memory_wc() could be used as a workaround to mark the pages
+	 * as write combine memory.
+	 */
+	dma_addr = dma_map_page(&adev->pdev->dev, p, 0, adev->gart.table_size,
+				DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(&adev->pdev->dev, dma_addr)) {
+		dev_err(&adev->pdev->dev, "Failed to DMA MAP the GART BO page\n");
+		__free_pages(p, order);
+		p = NULL;
+		return -EFAULT;
+	}
+
+	dev_info(adev->dev, "%s dma_addr:%llx\n", __func__, dma_addr);
+	/* Create SG table */
+	sg = kmalloc(sizeof(*sg), GFP_KERNEL);
+	if (!sg) {
+		ret = -ENOMEM;
+		goto error;
+	}
+	ret = sg_alloc_table(sg, 1, GFP_KERNEL);
+	if (ret)
+		goto error;
+
+	sg_dma_address(sg->sgl) = dma_addr;
+	sg->sgl->length = adev->gart.table_size;
+#ifdef CONFIG_NEED_SG_DMA_LENGTH
+	sg->sgl->dma_length = adev->gart.table_size;
+#endif
+	/* Create SG BO */
+	memset(&bp, 0, sizeof(bp));
+	bp.size = adev->gart.table_size;
+	bp.byte_align = PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_CPU;
+	bp.type = ttm_bo_type_sg;
+	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.flags = 0;
+	ret = amdgpu_bo_create(adev, &bp, &bo);
+	if (ret)
+		goto error;
+
+	bo->tbo.sg = sg;
+	bo->tbo.ttm->sg = sg;
+	bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
+	bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
+
+	ret = amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		dev_err(adev->dev, "(%d) failed to reserve bo for GART system bo\n", ret);
+		goto error;
+	}
+
+	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	WARN(ret, "Pinning the GART table failed");
+	if (ret)
+		goto error_resv;
+
+	adev->gart.bo = bo;
+	adev->gart.ptr = page_to_virt(p);
+	/* Make GART table accessible in VMID0 */
+	ret = amdgpu_ttm_alloc_gart(&adev->gart.bo->tbo);
+	if (ret)
+		amdgpu_gart_table_ram_free(adev);
+	amdgpu_bo_unreserve(bo);
+
+	return 0;
+
+error_resv:
+	amdgpu_bo_unreserve(bo);
+error:
+	amdgpu_bo_unref(&bo);
+	if (sg) {
+		sg_free_table(sg);
+		kfree(sg);
+	}
+	__free_pages(p, order);
+	return ret;
+}
+
+/**
+ * amdgpu_gart_table_ram_free - free gart page table system ram
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Free the system memory used for the GART page tableon ASICs that don't
+ * have dedicated VRAM.
+ */
+void amdgpu_gart_table_ram_free(struct amdgpu_device *adev)
+{
+	unsigned int order = get_order(adev->gart.table_size);
+	struct sg_table *sg = adev->gart.bo->tbo.sg;
+	struct page *p;
+	int ret;
+
+	ret = amdgpu_bo_reserve(adev->gart.bo, false);
+	if (!ret) {
+		amdgpu_bo_unpin(adev->gart.bo);
+		amdgpu_bo_unreserve(adev->gart.bo);
+	}
+	amdgpu_bo_unref(&adev->gart.bo);
+	sg_free_table(sg);
+	kfree(sg);
+	p = virt_to_page(adev->gart.ptr);
+	__free_pages(p, order);
+
+	adev->gart.ptr = NULL;
+}
+
 /**
  * amdgpu_gart_table_vram_alloc - allocate vram for gart page table
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index 8fea3e04e411..8283d682f543 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -51,6 +51,8 @@ struct amdgpu_gart {
 	uint64_t			gart_pte_flags;
 };
 
+int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev);
+void amdgpu_gart_table_ram_free(struct amdgpu_device *adev);
 int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev);
 void amdgpu_gart_table_vram_free(struct amdgpu_device *adev);
 int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c42d6e4e28bb..53bd7506ff22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1670,12 +1670,18 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_VG10(MTYPE_UC) |
 				 AMDGPU_PTE_EXECUTABLE;
 
-	r = amdgpu_gart_table_vram_alloc(adev);
-	if (r)
-		return r;
+	if (!adev->gmc.real_vram_size) {
+		dev_info(adev->dev, "Put GART in system memory for APU\n");
+		r = amdgpu_gart_table_ram_alloc(adev);
+		if (r)
+			dev_err(adev->dev, "Failed to allocate GART in system memory\n");
+	} else {
+		r = amdgpu_gart_table_vram_alloc(adev);
+		if (r)
+			return r;
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
-		r = amdgpu_gmc_pdb0_alloc(adev);
+		if (adev->gmc.xgmi.connected_to_cpu)
+			r = amdgpu_gmc_pdb0_alloc(adev);
 	}
 
 	return r;
@@ -1884,7 +1890,12 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_gmc_ras_fini(adev);
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
-	amdgpu_gart_table_vram_free(adev);
+	if (!adev->gmc.real_vram_size) {
+		dev_info(adev->dev, "Put GART in system memory for APU free\n");
+		amdgpu_gart_table_ram_free(adev);
+	} else {
+		amdgpu_gart_table_vram_free(adev);
+	}
 	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
 	amdgpu_bo_fini(adev);
 
-- 
2.39.2

