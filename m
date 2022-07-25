Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313E9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 10:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CCC2BDA9;
	Mon, 25 Jul 2022 10:32:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 531432BABE
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 10:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vcf3BTAjXF625TMSP3WjUCdy8h8KefZgQ2cOGQEnpNr5N+iQXZcylxAhn/IuVOp6myb9N4q+gSRQwW9vSx4qZH8AIpXPVrZnqfRjGoTx/kDcz1i86E/bmn8790CP9eHN8CGuJ7A9m4wE6AZW+F3k2tAgQSpBfOngpKDU812/HaLVz0Dblj0jUYOdw/Ftl9yetuV4emQ+KehexOVOStE80QWHV6Xy11Om9cfD5qNOq98/JtMDLmPnOqkPoIGbd/m7rrycPJ8RtGqoZwQlpppG4iUw8sOovHMT7qAlDHs4z8mEOdYRt/lNzKoIdJkySRJuucidjlL94/zG8+eS/Uy7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5jxkiIzvFd0EDrQzqXsDpFYO2C2+ePmuL19REaW0X4=;
 b=aQfKvOiZhi78hmXB628N656Jsr3/RZ1JNpIoNDATbIdhhKbfIs32rbnDUr0FIs3s8uWAclrXgFDkURK4cnAVh8pLoBcgopweTlIW2Mt1MzQzwgDPNpSm6X4xJo9MiNtoFPbTBMt2cigpi67cdZgsKkD+Crv7wPA/U2WE9h1N06kP+bhDj5Q0Nlc46xXaeceXS+80YaqURfKrViYBUL1eU/daVwNp9o1vPdYYzOIhyadTgdimKXcf7MB+eSBp+FnAs1IQsMaMZVAIF0egJlX/Sy83h8Pxj6k2jLUMVGzs6yLqRjZxk/4hL1sCAkY2pkaicKwMibnyEvl9DXs7rifoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5jxkiIzvFd0EDrQzqXsDpFYO2C2+ePmuL19REaW0X4=;
 b=AyFYn8xRApJsBhkV+QQrNeNhowiGumcL4LufrkaSGGc2mXPyuStwfPmRnr9tg4A6iaOZ6HzIurzn+XIsiLLoy4Mj7aQJ3oM4is5YW1/Q3JeUHSPYLWtB/V+YMJVFAnNfH2D4CSnUJnmKnq5yvhBDJ83377mGDaq9YtkIhI0aEZc=
Received: from MW4PR03CA0178.namprd03.prod.outlook.com (2603:10b6:303:8d::33)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 10:32:24 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::aa) by MW4PR03CA0178.outlook.office365.com
 (2603:10b6:303:8d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20 via Frontend
 Transport; Mon, 25 Jul 2022 10:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 10:32:24 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 05:32:20 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: refine the gfx BO based dmabuf handling
Date: Mon, 25 Jul 2022 18:32:04 +0800
Message-ID: <20220725103205.2085630-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725103205.2085630-1-Lang.Yu@amd.com>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a57dcbf-b92f-4c8b-bebf-08da6e28f6b2
X-MS-TrafficTypeDiagnostic: DM8PR12MB5480:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ng1JWNWZECPtRN+/XMxtVVLZ2zGPSkohKOfOJzOo/HlCwmq2S9RkChECTcYI6WGmVVYZwBxDs9ZdScuOCMHXzksJ0oRbHQeo8IPd1NIMScnOQlGi4UlGnGNzhJQjBaYZ4zpjTFutinovOTk2uah5H2KnGjq9oqgmc/Opr25dFImrMIydA2xT8uyxdt4wVENfFR3wdfg1rtGxB/cLalrHapWGTv4SMDLXRBdTRQ2M4/aQYNCBQ4FN0Ry0yEASlOZdwIZ/BRhyiIC4patXf65V7gL5nj5s09N7e2EUGMrNKw+/EYEE3LBUwBhClIuYg3igvEVUv9eo/4+8tQ1ilua0uSCdCrLx2+3wFx1ZBWl7n9rmTQrPBjS2Q9UclenIadIdi4Z2g9VUqzm/04YCaFLeRCwTXcIMBL821UGeFznt3rUssrBrOF5ENmeZL2dKRcU+kOcVHbjeM719AEuB2HspI8F1jAWmcTTB4iwlL917g724sJKDB4AGyaP6c6dl9HY4Zss/S7FeDNNEPSoCbDCbnq+K1XeMBCHvhdaMDCyPM3nHguQ5TTSSeArtFOL7puZPT0KFyYynVdLh6xFsBkr0HDWRT4T1pwcfq9PSMftgHkRGiuUWlrXl92FH+MoFUd2bGmiFCIUEFHHTCwDmfUjO2iJRzSDZNpmkRFNY7qwcNT39VzyCgtlXj5MHQExXl2UhpGTGVnwCQJKDl/JrcPovNYRifcwMXVSZG4gRMx5nwwIOIKo89kFx4fZI8VtTqaCy3/+v78ErrQDwGXcRppLUKeu1R8X0PrLWN5JYW7GJGoXpLPKWaXm2kQEXHwGMmsV9GGCapKlcMJVwnXEFzdiw9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(40470700004)(336012)(426003)(5660300002)(47076005)(26005)(2616005)(1076003)(478600001)(4326008)(8936002)(186003)(16526019)(40480700001)(36756003)(86362001)(6666004)(7696005)(41300700001)(81166007)(356005)(82740400003)(83380400001)(70586007)(70206006)(2906002)(40460700003)(54906003)(8676002)(82310400005)(6916009)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 10:32:24.0971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a57dcbf-b92f-4c8b-bebf-08da6e28f6b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
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
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We have memory leak issue in current implenmention, i.e.,
the allocated struct kgd_mem memory is not handled properly.

The idea is always creating a buffer object when importing
a gfx BO based dmabuf.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 99 +++++++++++++------
 1 file changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b3806ebe5ef7..c1855b72a3f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -225,7 +225,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo->kfd_bo->alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	unreserve_mem_limit(adev, size, alloc_flags);
+	if (!bo->kfd_bo->is_imported)
+		unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo->kfd_bo);
 }
@@ -784,6 +785,24 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
 	}
 }
 
+static struct drm_gem_object*
+amdgpu_amdkfd_import(struct drm_device *dev, struct dma_buf *dma_buf)
+{
+	struct drm_gem_object *gobj;
+	struct amdgpu_bo *abo;
+
+	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
+		gobj = dma_buf->priv;
+		abo = gem_to_amdgpu_bo(gobj);
+		if (gobj->dev == dev && abo->kfd_bo) {
+			drm_gem_object_get(gobj);
+			return gobj;
+		}
+	}
+
+	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
+}
+
 static int
 kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
 		      struct amdgpu_bo **bo)
@@ -802,7 +821,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
 		}
 	}
 
-	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
+	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), mem->dmabuf);
 	if (IS_ERR(gobj))
 		return PTR_ERR(gobj);
 
@@ -1805,12 +1824,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
 	unsigned long bo_size = mem->bo->tbo.base.size;
+	bool is_imported = false;
+	struct drm_gem_object *imported_gobj;
 	struct kfd_mem_attachment *entry, *tmp;
 	struct bo_vm_reservation_context ctx;
 	struct ttm_validate_buffer *bo_list_entry;
 	unsigned int mapped_to_gpu_memory;
 	int ret;
-	bool is_imported = false;
 
 	mutex_lock(&mem->lock);
 
@@ -1885,7 +1905,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	}
 
 	/* Free the BO*/
-	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
+	if (!is_imported) {
+		drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
+	} else {
+		imported_gobj = mem->dmabuf->priv;
+		drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
+	}
+
 	if (mem->dmabuf)
 		dma_buf_put(mem->dmabuf);
 	mutex_destroy(&mem->lock);
@@ -2249,62 +2275,77 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
 				      uint64_t *mmap_offset)
 {
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
-	struct drm_gem_object *obj;
-	struct amdgpu_bo *bo;
+	struct drm_gem_object *imported_gobj, *gobj;
+	struct amdgpu_bo *imported_bo, *bo;
 	int ret;
 
-	if (dma_buf->ops != &amdgpu_dmabuf_ops)
-		/* Can't handle non-graphics buffers */
+	/*
+	 * Can't handle non-graphics buffers and
+	 * buffers from other devices
+	 */
+	imported_gobj = dma_buf->priv;
+	if (dma_buf->ops != &amdgpu_dmabuf_ops ||
+	    drm_to_adev(imported_gobj->dev) != adev)
 		return -EINVAL;
 
-	obj = dma_buf->priv;
-	if (drm_to_adev(obj->dev) != adev)
-		/* Can't handle buffers from other devices */
+	/* Only VRAM and GTT BOs are supported */
+	imported_bo = gem_to_amdgpu_bo(imported_gobj);
+	if (!(imported_bo->preferred_domains &
+	    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)))
 		return -EINVAL;
 
-	bo = gem_to_amdgpu_bo(obj);
-	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
-				    AMDGPU_GEM_DOMAIN_GTT)))
-		/* Only VRAM and GTT BOs are supported */
-		return -EINVAL;
+	ret = drm_vma_node_allow(&imported_gobj->vma_node, drm_priv);
+	if (ret)
+		return ret;
 
-	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
-	if (!*mem)
-		return -ENOMEM;
+	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), dma_buf);
+	if (IS_ERR(gobj)) {
+		ret = PTR_ERR(gobj);
+		goto err_import;
+	}
 
-	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
-	if (ret) {
-		kfree(mem);
-		return ret;
+	bo = gem_to_amdgpu_bo(gobj);
+	bo->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
+
+	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
+	if (!*mem) {
+		ret = -ENOMEM;
+		goto err_alloc_mem;
 	}
 
 	if (size)
-		*size = amdgpu_bo_size(bo);
+		*size = amdgpu_bo_size(imported_bo);
 
 	if (mmap_offset)
-		*mmap_offset = amdgpu_bo_mmap_offset(bo);
+		*mmap_offset = amdgpu_bo_mmap_offset(imported_bo);
 
 	INIT_LIST_HEAD(&(*mem)->attachments);
 	mutex_init(&(*mem)->lock);
 
 	(*mem)->alloc_flags =
-		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
+		((imported_bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
 		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
 		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
 		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
 
-	drm_gem_object_get(&bo->tbo.base);
+	get_dma_buf(dma_buf);
+	(*mem)->dmabuf = dma_buf;
 	(*mem)->bo = bo;
 	(*mem)->va = va;
-	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
-		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
+	(*mem)->domain = AMDGPU_GEM_DOMAIN_GTT;
 	(*mem)->mapped_to_gpu_memory = 0;
 	(*mem)->process_info = avm->process_info;
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
 	amdgpu_sync_create(&(*mem)->sync);
 	(*mem)->is_imported = true;
+	bo->kfd_bo = *mem;
 
 	return 0;
+err_import:
+	drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
+err_alloc_mem:
+	drm_gem_object_put(gobj);
+	return ret;
 }
 
 /* Evict a userptr BO by stopping the queues if necessary
-- 
2.25.1

