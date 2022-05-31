Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC85C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 17:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8B710FF19;
	Tue, 31 May 2022 17:02:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4E510FF19
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 17:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBsCIrVpSHd38tSuiqOMVYhhxkwkbZ+HWRML2uxA8t2WV/2U8Rss/4xvyOXvpdt8QRQrE1+BueDlJB8G+VbYNRlOTp+U8J7h4kJQLRPpj58DfEAY+ECZyGRfeuVzOEwNko24s4WYa1qrrWVvd+juV4gq1t8X9gLC8m+2Iv3inKTH4e0BJw4kTbWUAbi1DwOWmGv9k95u/TtsEga6b9hUZKsP4j1v6D14YKQiaFUd3opISnHae/EY5JHwY6R6wMaAYeKgBJAHCseh2/O64jpyrzaXqjaWW02BUalLkzMOys5yNxGxdBwV2LxLrgbsNtPNhYJLLXj7iVnVpZQGuI8F6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTJ9uryvZ1qe6UkY7pAw4W50vP/Ktk2P1GGqOkzkFwc=;
 b=MYeE4WX06AmWA1GV5y/hLrMeFec6bIuCmRon1lwQkGb+wC+KV1IB+0O1X7C1bwXgkx6FTzP5Wv20IbCHHmvQYg66hRVM4OS5EqCHIO9eX94sokPBaWwC6y+Mqt8FwhGj7GYLKpCsQlK+qjw8IHusXhGxyjUJ6IoyiXOsxE64dRgnZyBe/E6E058MbxSMMwsXFzhNlva+etqMDxyNyJQoAKHvvhj6LK4UxhdkbP60J1ctS8mHdz1bJYPtiY/t+7Zzl0/xBLupA8QaTgs5J5dA/gwqdtdLnWTePB6mRjGSWvA+NmEt72u+Ds8SbiuX3p9/rl01o26fL1WJs/J9Al9Y5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTJ9uryvZ1qe6UkY7pAw4W50vP/Ktk2P1GGqOkzkFwc=;
 b=tSz5qJtBGT45dU+hb/jOkjQylJSFi1z3Tny80r+0qRjpaJhSAp7K9yzBAQharVdo4RTnZSCrwm7/UK+v1ultz52QwaAW2vQIZ4x2NtcNcN5WmoJWIwjuh0hFDCDeXtM1eOPxhS+WylD2vFN6Opir+4EfiM+gBPS+mT1St8ffFqc=
Received: from MWHPR1201CA0006.namprd12.prod.outlook.com
 (2603:10b6:301:4a::16) by MN2PR12MB3517.namprd12.prod.outlook.com
 (2603:10b6:208:ab::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 17:02:07 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::e9) by MWHPR1201CA0006.outlook.office365.com
 (2603:10b6:301:4a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 31 May 2022 17:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 17:02:06 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 12:02:02 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Add peer-to-peer support among PCIe connected
 AMD GPUs
Date: Tue, 31 May 2022 12:01:41 -0500
Message-ID: <20220531170141.788526-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f99bf0-7e8b-4a50-5f7b-08da43274b00
X-MS-TrafficTypeDiagnostic: MN2PR12MB3517:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3517A2445D365DB4882F4103E3DC9@MN2PR12MB3517.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLSotSHzyUCNfRME0OB4+mN1eVwmj5YDhr4txFdv/lkhXZsFHvS1C0oO7GnVDMjnIN2PsRndq+VCvD6qHJ/2OoHqOt9wcadxhJSzndJ4tLlzWwtKx6qVq6UNMZLE5g0XKBuYOuLBgcPyf0HDTA5K+BxmyKLw30rbOhsImJoSVAnSgPlRY21tdN9Nu3HonUdCT5ayHoJOWpevs/nPvIK1Wyd9WtM9pFPUKSYBhX5jMaLSM6FG000WXOM7idylLt12GDC3zwX1O3nOOqROvW/sO1LjdI41KpODUKNVlX9esMcvYoA3qSAA6xtPDI7iPaWCHL8QFmUUnX1ZQBT7qVWqFuHH50sV7j3PWgHbXtRqbnCyTOOZISirsSxO5eOrBq8ZVmCxEo3OAkpbpuzdsMW9x2GcI/7Iq/dgAJNvxFXl+A0/45H13QXhym2DD0UasJ2EQ/87qdJ9vzNZYz5sJubDCJSb6S6mipnBlG4WP3UqabABwOJ2eZsySMQqiGljWKikdlgUHrvFnAhzxKTvWgPiXKy950KUj8iUvmUsCObRuNoes66M+6bchbYKxF5vIhNO48JKFXs9cDTN1osIC+v+Je5+JvCjo5EQjg/nTNXhPcewtQz0s2cPgGuvTp1WvVQ69hl1z/l38PRLDCbnjs9NqwUChWmf7FC18meuMyFWbUGtplbl29wj8L8vf0Ae7I60LkBEHr5cHq7G6DAF4L75SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(40460700003)(7696005)(6666004)(2906002)(70586007)(70206006)(508600001)(30864003)(8936002)(86362001)(5660300002)(81166007)(4326008)(8676002)(82310400005)(83380400001)(26005)(2616005)(186003)(426003)(1076003)(16526019)(47076005)(336012)(36756003)(6916009)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 17:02:06.5572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f99bf0-7e8b-4a50-5f7b-08da43274b00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3517
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for peer-to-peer communication, in both data and control
planes, among AMD GPUs that are connected PCIe and have large BAR vBIOS.
Support REQUIRES enablement of config HSA_AMD_P2P.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 328 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  30 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   8 +
 4 files changed, 307 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..5c00ea1df21c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -48,6 +48,7 @@ enum kfd_mem_attachment_type {
 	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
 	KFD_MEM_ATT_USERPTR,	/* SG bo to DMA map pages from a userptr bo */
 	KFD_MEM_ATT_DMABUF,	/* DMAbuf to DMA map TTM BOs */
+	KFD_MEM_ATT_SG		/* Tag to DMA map SG BOs */
 };
 
 struct kfd_mem_attachment {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 34ba9e776521..c2af82317a03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -241,6 +241,42 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	kfree(bo->kfd_bo);
 }
 
+/**
+ * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information
+ * about USERPTR or DOOREBELL or MMIO BO.
+ * @adev: Device for which dmamap BO is being created
+ * @mem: BO of peer device that is being DMA mapped. Provides parameters
+ *	 in building the dmamap BO
+ * @bo_out: Output parameter updated with handle of dmamap BO
+ */
+static int
+create_dmamap_sg_bo(struct amdgpu_device *adev,
+		 struct kgd_mem *mem, struct amdgpu_bo **bo_out)
+{
+	struct drm_gem_object *gem_obj;
+	int ret, align;
+
+	ret = amdgpu_bo_reserve(mem->bo, false);
+	if (ret)
+		return ret;
+
+	align = 1;
+	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, align,
+			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE,
+			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj);
+
+	amdgpu_bo_unreserve(mem->bo);
+
+	if (ret) {
+		pr_err("Error in creating DMA mappable SG BO on domain: %d\n", ret);
+		return -EINVAL;
+	}
+
+	*bo_out = gem_to_amdgpu_bo(gem_obj);
+	(*bo_out)->parent = amdgpu_bo_ref(mem->bo);
+	return ret;
+}
+
 /* amdgpu_amdkfd_remove_eviction_fence - Removes eviction fence from BO's
  *  reservation object.
  *
@@ -481,6 +517,38 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 	return pte_flags;
 }
 
+/**
+ * create_sg_table() - Create an sg_table for a contiguous DMA addr range
+ * @addr: The starting address to point to
+ * @size: Size of memory area in bytes being pointed to
+ *
+ * Allocates an instance of sg_table and initializes it to point to memory
+ * area specified by input parameters. The address used to build is assumed
+ * to be DMA mapped, if needed.
+ *
+ * DOORBELL or MMIO BOs use only one scatterlist node in their sg_table
+ * because they are physically contiguous.
+ *
+ * Return: Initialized instance of SG Table or NULL
+ */
+static struct sg_table *create_sg_table(uint64_t addr, uint32_t size)
+{
+	struct sg_table *sg = kmalloc(sizeof(*sg), GFP_KERNEL);
+
+	if (!sg)
+		return NULL;
+	if (sg_alloc_table(sg, 1, GFP_KERNEL)) {
+		kfree(sg);
+		return NULL;
+	}
+	sg_dma_address(sg->sgl) = addr;
+	sg->sgl->length = size;
+#ifdef CONFIG_NEED_SG_DMA_LENGTH
+	sg->sgl->dma_length = size;
+#endif
+	return sg;
+}
+
 static int
 kfd_mem_dmamap_userptr(struct kgd_mem *mem,
 		       struct kfd_mem_attachment *attachment)
@@ -545,6 +613,87 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
 	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 }
 
+/**
+ * kfd_mem_dmamap_sg_bo() - Create DMA mapped sg_table to access DOORBELL or MMIO BO
+ * @mem: SG BO of the DOORBELL or MMIO resource on the owning device
+ * @attachment: Virtual address attachment of the BO on accessing device
+ *
+ * An access request from the device that owns DOORBELL does not require DMA mapping.
+ * This is because the request doesn't go through PCIe root complex i.e. it instead
+ * loops back. The need to DMA map arises only when accessing peer device's DOORBELL
+ *
+ * In contrast, all access requests for MMIO need to be DMA mapped without regard to
+ * device ownership. This is because access requests for MMIO go through PCIe root
+ * complex.
+ *
+ * This is accomplished in two steps:
+ *   - Obtain DMA mapped address of DOORBELL or MMIO memory that could be used
+ *         in updating requesting device's page table
+ *   - Signal TTM to mark memory pointed to by requesting device's BO as GPU
+ *         accessible. This allows an update of requesting device's page table
+ *         with entries associated with DOOREBELL or MMIO memory
+ *
+ * This method is invoked in the following contexts:
+ *   - Mapping of DOORBELL or MMIO BO of same or peer device
+ *   - Validating an evicted DOOREBELL or MMIO BO on device seeking access
+ *
+ * Return: ZERO if successful, NON-ZERO otherwise
+ */
+static int
+kfd_mem_dmamap_sg_bo(struct kgd_mem *mem,
+		     struct kfd_mem_attachment *attachment)
+{
+	struct ttm_operation_ctx ctx = {.interruptible = true};
+	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
+	struct amdgpu_device *adev = attachment->adev;
+	struct ttm_tt *ttm = bo->tbo.ttm;
+	enum dma_data_direction dir;
+	dma_addr_t dma_addr;
+	bool mmio;
+	int ret;
+
+	/* Expect SG Table of dmapmap BO to be NULL */
+	mmio = (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP);
+	if (unlikely(ttm->sg)) {
+		pr_err("SG Table of %d BO for peer device is UNEXPECTEDLY NON-NULL", mmio);
+		return -EINVAL;
+	}
+
+	dir = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
+			DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
+	dma_addr = mem->bo->tbo.sg->sgl->dma_address;
+	pr_debug("%d BO size: %d\n", mmio, mem->bo->tbo.sg->sgl->length);
+	pr_debug("%d BO address before DMA mapping: %llx\n", mmio, dma_addr);
+	dma_addr = dma_map_resource(adev->dev, dma_addr,
+			mem->bo->tbo.sg->sgl->length, dir, DMA_ATTR_SKIP_CPU_SYNC);
+	ret = dma_mapping_error(adev->dev, dma_addr);
+	if (unlikely(ret))
+		return ret;
+	pr_debug("%d BO address after DMA mapping: %llx\n", mmio, dma_addr);
+
+	ttm->sg = create_sg_table(dma_addr, mem->bo->tbo.sg->sgl->length);
+	if (unlikely(!ttm->sg)) {
+		ret = -ENOMEM;
+		goto unmap_sg;
+	}
+
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
+	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (unlikely(ret))
+		goto free_sg;
+
+	return ret;
+
+free_sg:
+	sg_free_table(ttm->sg);
+	kfree(ttm->sg);
+	ttm->sg = NULL;
+unmap_sg:
+	dma_unmap_resource(adev->dev, dma_addr, mem->bo->tbo.sg->sgl->length,
+			   dir, DMA_ATTR_SKIP_CPU_SYNC);
+	return ret;
+}
+
 static int
 kfd_mem_dmamap_attachment(struct kgd_mem *mem,
 			  struct kfd_mem_attachment *attachment)
@@ -556,6 +705,8 @@ kfd_mem_dmamap_attachment(struct kgd_mem *mem,
 		return kfd_mem_dmamap_userptr(mem, attachment);
 	case KFD_MEM_ATT_DMABUF:
 		return kfd_mem_dmamap_dmabuf(attachment);
+	case KFD_MEM_ATT_SG:
+		return kfd_mem_dmamap_sg_bo(mem, attachment);
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -596,6 +747,50 @@ kfd_mem_dmaunmap_dmabuf(struct kfd_mem_attachment *attachment)
 	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 }
 
+/**
+ * kfd_mem_dmaunmap_sg_bo() - Free DMA mapped sg_table of DOORBELL or MMIO BO
+ * @mem: SG BO of the DOORBELL or MMIO resource on the owning device
+ * @attachment: Virtual address attachment of the BO on accessing device
+ *
+ * The method performs following steps:
+ *   - Signal TTM to mark memory pointed to by BO as GPU inaccessible
+ *   - Free SG Table that is used to encapsulate DMA mapped memory of
+ *          peer device's DOORBELL or MMIO memory
+ *
+ * This method is invoked in the following contexts:
+ *     UNMapping of DOORBELL or MMIO BO on a device having access to its memory
+ *     Eviction of DOOREBELL or MMIO BO on device having access to its memory
+ *
+ * Return: void
+ */
+static void
+kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
+		       struct kfd_mem_attachment *attachment)
+{
+	struct ttm_operation_ctx ctx = {.interruptible = true};
+	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
+	struct amdgpu_device *adev = attachment->adev;
+	struct ttm_tt *ttm = bo->tbo.ttm;
+	enum dma_data_direction dir;
+
+	if (unlikely(!ttm->sg)) {
+		pr_err("SG Table of BO is UNEXPECTEDLY NULL");
+		return;
+	}
+
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+
+	dir = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
+				DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
+	dma_unmap_resource(adev->dev, ttm->sg->sgl->dma_address,
+			ttm->sg->sgl->length, dir, DMA_ATTR_SKIP_CPU_SYNC);
+	sg_free_table(ttm->sg);
+	kfree(ttm->sg);
+	ttm->sg = NULL;
+	bo->tbo.sg = NULL;
+}
+
 static void
 kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
 			    struct kfd_mem_attachment *attachment)
@@ -609,38 +804,14 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
 	case KFD_MEM_ATT_DMABUF:
 		kfd_mem_dmaunmap_dmabuf(attachment);
 		break;
+	case KFD_MEM_ATT_SG:
+		kfd_mem_dmaunmap_sg_bo(mem, attachment);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
 }
 
-static int
-kfd_mem_attach_userptr(struct amdgpu_device *adev, struct kgd_mem *mem,
-		       struct amdgpu_bo **bo)
-{
-	unsigned long bo_size = mem->bo->tbo.base.size;
-	struct drm_gem_object *gobj;
-	int ret;
-
-	ret = amdgpu_bo_reserve(mem->bo, false);
-	if (ret)
-		return ret;
-
-	ret = amdgpu_gem_object_create(adev, bo_size, 1,
-				       AMDGPU_GEM_DOMAIN_CPU,
-				       AMDGPU_GEM_CREATE_PREEMPTIBLE,
-				       ttm_bo_type_sg, mem->bo->tbo.base.resv,
-				       &gobj);
-	amdgpu_bo_unreserve(mem->bo);
-	if (ret)
-		return ret;
-
-	*bo = gem_to_amdgpu_bo(gobj);
-	(*bo)->parent = amdgpu_bo_ref(mem->bo);
-
-	return 0;
-}
-
 static int
 kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
 		      struct amdgpu_bo **bo)
@@ -670,6 +841,38 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
 	return 0;
 }
 
+/**
+ * @kfd_mem_attach_vram_bo: Acquires the handle of a VRAM BO that could
+ * be used to enable a peer GPU access it
+ *
+ * Implementation determines if access to VRAM BO would employ DMABUF
+ * or Shared BO mechanism. Employ DMABUF mechanism if kernel has config
+ * option HSA_AMD_P2P enabled. Employ Shared BO mechanism if above
+ * config option is not set. It is important to note that a Shared BO
+ * cannot be used to enable peer acces if system has IOMMU enabled
+ *
+ * @TODO: ADD Check to ensure IOMMU is not enabled. Should this check
+ * be somewhere as this is information could be useful in other places
+ */
+static int kfd_mem_attach_vram_bo(struct amdgpu_device *adev,
+			struct kgd_mem *mem, struct amdgpu_bo **bo,
+			struct kfd_mem_attachment *attachment)
+{
+	int ret =  0;
+
+#if defined(CONFIG_HSA_AMD_P2P)
+	attachment->type = KFD_MEM_ATT_DMABUF;
+	ret = kfd_mem_attach_dmabuf(adev, mem, bo);
+	pr_debug("Employ DMABUF mechanim to enable peer GPU access\n");
+#else
+	*bo = mem->bo;
+	attachment->type = KFD_MEM_ATT_SHARED;
+	drm_gem_object_get(&(*bo)->tbo.base);
+	pr_debug("Employ Shared BO mechanim to enable peer GPU access\n");
+#endif
+	return ret;
+}
+
 /* kfd_mem_attach - Add a BO to a VM
  *
  * Everything that needs to bo done only once when a BO is first added
@@ -691,6 +894,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	uint64_t va = mem->va;
 	struct kfd_mem_attachment *attachment[2] = {NULL, NULL};
 	struct amdgpu_bo *bo[2] = {NULL, NULL};
+	bool same_hive = false;
 	int i, ret;
 
 	if (!va) {
@@ -698,6 +902,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		return -EINVAL;
 	}
 
+	/* Determine if the mapping of VRAM BO to a peer device is valid
+	 * It is possible that the peer device is connected via PCIe or
+	 * xGMI link. Access over PCIe is allowed if device owning VRAM BO
+	 * has large BAR. In contrast, access over xGMI is allowed for both
+	 * small and large BAR configurations of device owning the VRAM BO
+	 */
+	if (adev != bo_adev && mem->domain == AMDGPU_GEM_DOMAIN_VRAM) {
+		same_hive = amdgpu_xgmi_same_hive(adev, bo_adev);
+		if (!same_hive &&
+		    !amdgpu_device_is_peer_accessible(bo_adev, adev))
+			return -EINVAL;
+	}
+
 	for (i = 0; i <= is_aql; i++) {
 		attachment[i] = kzalloc(sizeof(*attachment[i]), GFP_KERNEL);
 		if (unlikely(!attachment[i])) {
@@ -708,9 +925,9 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
 			 va + bo_size, vm);
 
-		if (adev == bo_adev ||
-		   (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
-		   (mem->domain == AMDGPU_GEM_DOMAIN_VRAM && amdgpu_xgmi_same_hive(adev, bo_adev))) {
+		if ((adev == bo_adev && !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
+		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
+		    same_hive) {
 			/* Mappings on the local GPU, or VRAM mappings in the
 			 * local hive, or userptr mapping IOMMU direct map mode
 			 * share the original BO
@@ -726,26 +943,35 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		} else if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
 			/* Create an SG BO to DMA-map userptrs on other GPUs */
 			attachment[i]->type = KFD_MEM_ATT_USERPTR;
-			ret = kfd_mem_attach_userptr(adev, mem, &bo[i]);
+			ret = create_dmamap_sg_bo(adev, mem, &bo[i]);
 			if (ret)
 				goto unwind;
 		} else if (mem->domain == AMDGPU_GEM_DOMAIN_GTT &&
 			   mem->bo->tbo.type != ttm_bo_type_sg) {
-			/* GTT BOs use DMA-mapping ability of dynamic-attach
-			 * DMA bufs. TODO: The same should work for VRAM on
-			 * large-BAR GPUs.
-			 */
+			/* GTT BOs use DMA-mapping ability of dynamic-attach DMA bufs */
 			attachment[i]->type = KFD_MEM_ATT_DMABUF;
 			ret = kfd_mem_attach_dmabuf(adev, mem, &bo[i]);
 			if (ret)
 				goto unwind;
+		/* Enable acces to VRAM BOs of peer devices */
+		} else if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
+			   mem->bo->tbo.type == ttm_bo_type_device) {
+			ret = kfd_mem_attach_vram_bo(adev, mem,
+						&bo[i], attachment[i]);
+			if (ret)
+				goto unwind;
+		/* Handle DOORBELL BOs of peer devices and MMIO BOs of local and peer devices */
+		} else if ((mem->bo->tbo.type == ttm_bo_type_sg) &&
+			   ((mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
+			    (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
+			attachment[i]->type = KFD_MEM_ATT_SG;
+			ret = create_dmamap_sg_bo(adev, mem, &bo[i]);
+			if (ret)
+				goto unwind;
 		} else {
-			/* FIXME: Need to DMA-map other BO types:
-			 * large-BAR VRAM, doorbells, MMIO remap
-			 */
-			attachment[i]->type = KFD_MEM_ATT_SHARED;
-			bo[i] = mem->bo;
-			drm_gem_object_get(&bo[i]->tbo.base);
+			WARN_ONCE(true, "Handling invalid ATTACH request");
+			ret = -EINVAL;
+			goto unwind;
 		}
 
 		/* Add BO to VM internal data structures */
@@ -1146,24 +1372,6 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 	return ret;
 }
 
-static struct sg_table *create_doorbell_sg(uint64_t addr, uint32_t size)
-{
-	struct sg_table *sg = kmalloc(sizeof(*sg), GFP_KERNEL);
-
-	if (!sg)
-		return NULL;
-	if (sg_alloc_table(sg, 1, GFP_KERNEL)) {
-		kfree(sg);
-		return NULL;
-	}
-	sg->sgl->dma_address = addr;
-	sg->sgl->length = size;
-#ifdef CONFIG_NEED_SG_DMA_LENGTH
-	sg->sgl->dma_length = size;
-#endif
-	return sg;
-}
-
 static int process_validate_vms(struct amdkfd_process_info *process_info)
 {
 	struct amdgpu_vm *peer_vm;
@@ -1532,7 +1740,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			bo_type = ttm_bo_type_sg;
 			if (size > UINT_MAX)
 				return -EINVAL;
-			sg = create_doorbell_sg(*offset, size);
+			sg = create_sg_table(*offset, size);
 			if (!sg)
 				return -ENOMEM;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f16f105a737b..3dfac07cf37c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -127,6 +127,8 @@ const char *amdgpu_asic_name[] = {
 	"LAST",
 };
 
+extern bool pcie_p2p;
+
 /**
  * DOC: pcie_replay_count
  *
@@ -5463,6 +5465,34 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
 	}
 }
 
+/**
+ * amdgpu_device_is_peer_accessible - Check peer access through PCIe BAR
+ *
+ * @adev: amdgpu_device pointer
+ * @peer_adev: amdgpu_device pointer for peer device trying to access @adev
+ *
+ * Return true if @peer_adev can access (DMA) @adev through the PCIe
+ * BAR, i.e. @adev is "large BAR" and the BAR matches the DMA mask of
+ * @peer_adev.
+ */
+bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
+				      struct amdgpu_device *peer_adev)
+{
+#ifdef CONFIG_HSA_AMD_P2P
+	uint64_t address_mask = peer_adev->dev->dma_mask ?
+		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
+	resource_size_t aper_limit =
+		adev->gmc.aper_base + adev->gmc.aper_size - 1;
+
+	return pcie_p2p && (adev->gmc.visible_vram_size &&
+		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
+		!(adev->gmc.aper_base & address_mask ||
+		  aper_limit & address_mask));
+#else
+	return false;
+#endif
+}
+
 int amdgpu_device_baco_enter(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bed4ed88951f..d1c82a9e8569 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -802,6 +802,14 @@ MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (
 module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
 #endif
 
+/**
+ * DOC: pcie_p2p (bool)
+ * Enable PCIe P2P (requires large-BAR). Default value: true (on)
+ */
+bool pcie_p2p = true;
+module_param(pcie_p2p, bool, 0444);
+MODULE_PARM_DESC(pcie_p2p, "Enable PCIe P2P (requires large-BAR). (N = off, Y = on(default))");
+
 /**
  * DOC: dcfeaturemask (uint)
  * Override display features enabled. See enum DC_FEATURE_MASK in drivers/gpu/drm/amd/include/amd_shared.h.
-- 
2.35.1

