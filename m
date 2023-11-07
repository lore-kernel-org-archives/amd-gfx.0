Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCDAC00141
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 16:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B436410E62F;
	Tue,  7 Nov 2023 16:58:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A21510E630
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 16:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNScNoXvLus6NJHriLYz88d3TmLRFmcsctD4kqLOGCoNMnn40dJyaN8ZotGRJ4ccLTdmcWe9xxylbZRlDUxtzhNYO9X6mmyfp/q/ZF1kbPmFUNggzbA3Iws21N786ZE8KYdEd+oEGMmH3JmeZvynopSrislGnLRd+SWJBHWay+sCjt/PgHMECPpLaX2ndmgHtrmf4mBIF66Dh7U0VT8lTkxHyM5YyuNqBFLjZYY3PV7Yfl05c73REE3Z7L9xM92wF5ePQcspPGxa7HovWzwmOcJMqbcTjuPTwuq2oued1NtudVbs/bJ/4Vc82dcuban2XEyKm2vhCUERXqpkqgTIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+2oznMHIhZfSt00MUMFTkxyobaIGeG/XJ9ZqRMEJPA=;
 b=A0hDbZ4i9p7x4r1cZT12kPokhOGh8elDuiMXW34OOifETbyYzBkhBhrh8JKoU5/mEuk/HzspH+yC8pqCJt+d5kE1RQFTSOLprFf71l0rSLKG7wD8zUXn3+PjQ2iRFB8BjsqVeBl5sgaZ0whkxLzM2qoNyzAHNnobvNzr4EyEXyheCFBU6YdhaGqfwXW6FMOiVh69uYEq3oAMvrYxM/23NLxJ39E6XI+fPlIR0yG6GyBQxI18jwZqSARzYhUktJWJPvgxPDHTwp6BTFjvmdge8Ozm0EtP5tPlJysbgV5MxJnEW82Rtcl2jf9CNqf35ofjzm0m6rK1rL8bXts+ugBAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+2oznMHIhZfSt00MUMFTkxyobaIGeG/XJ9ZqRMEJPA=;
 b=StarCVC2s3BAZ7Xj4yN4krzfPrTqZA7XAer/t1kfPUAlcaHxN+FqDaqp85U1XNUxXaDEM63Wv5CH8EIJSMBb6KiW83+Ccc2TCgJAcW8BOUo13f7iRF3PMHU+u/omSahWoyUGNc9dJGPfvswLviZKvCzl22heP0GiIuzKgJoT6Os=
Received: from CH2PR18CA0013.namprd18.prod.outlook.com (2603:10b6:610:4f::23)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 16:58:35 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::c6) by CH2PR18CA0013.outlook.office365.com
 (2603:10b6:610:4f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 16:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 16:58:35 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 10:58:32 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdkfd: Import DMABufs for interop through DRM
Date: Tue, 7 Nov 2023 11:58:13 -0500
Message-ID: <20231107165814.3628510-5-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM6PR12MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: b01a6ab0-e19a-4020-3e83-08dbdfb2c817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6nyaDKsCR5+1pptp8aHn7RQasecJUyTEQUPS3ewzTr535NAvRkz+6qDqEzCv40RnRc1Jyck1xCsuD/AnVMU+xpwIexKdPXWdlRf6L2yWp8v71RpF5aAitA03SoowROVt05YS2fE+niXUGMmtkq6ZESjqL1GI+HbwytYfZJzfi08X1nOmKgty2r3V0dMeuTVR5uU7wdMdYKxR2w4Iz0Qg9GqbASymYCKyoH4/ti1o2+KUlmqoKSeYX++gm4GNgmeHuvx91jRoBPQyjqdQ7wzTGfV+nntjFDnsZBX/LgNUS1E5Y2XPJX1hbiBkj5HAqXTEkVrkEz1ZNzlnCykoc8iaIX47j2O7cGcgNCokNGeCSrmKfqeUqYCm58DR8O8uTvFi6oRdSz1E/xLnzXultJ6Wb2q3DpOUnFfj8JljXhCDVLL/cdv8SYNUW8iW4KDaLeZpnstGZ6H3dew9O4B4uOzwxHAr4iUnNhuLC15HZ6dmyUX5Ks1Gk2mwwQSE8deF8q2u44RjvEF3UpdFcOyMLQJrNzSTACKdl1lXMn5FlINKUrBExyxDxPleyiVavqGPyPlJJDFFgC2NVaUNST69gVZQ3DS524au+0trF4VrUAt8aR14QyT80Ad28cRAPGwe2y5XQxonZoRurWR2PFyyB9vzBV2KLNaEz2SeGhcfsnv/7NJhptaKGqXfFIpZA/RjNdMJTZ88AVb2K91FyB1KDdaAKQwJvHNp7gSumv6A/+IMsikRMee+XtA8iMTgKV/4Ff4yGSBnZMixaOEDWEOjv64Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(8676002)(8936002)(4326008)(40460700003)(6916009)(316002)(70586007)(70206006)(54906003)(41300700001)(2906002)(86362001)(5660300002)(83380400001)(81166007)(426003)(336012)(356005)(47076005)(2616005)(1076003)(26005)(16526019)(82740400003)(36860700001)(40480700001)(36756003)(7696005)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 16:58:35.6102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01a6ab0-e19a-4020-3e83-08dbdfb2c817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use drm_gem_prime_fd_to_handle to import DMABufs for interop. This
ensures that a GEM handle is created on import and that obj->dma_buf
will be set and remain set as long as the object is imported into KFD.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  9 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 64 +++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 15 ++---
 3 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4caf8cece028..88a0e0734270 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -318,11 +318,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					      struct kfd_vm_fault_info *info);
-int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
-				      struct dma_buf *dmabuf,
-				      uint64_t va, void *drm_priv,
-				      struct kgd_mem **mem, uint64_t *size,
-				      uint64_t *mmap_offset);
+int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
+					 uint64_t va, void *drm_priv,
+					 struct kgd_mem **mem, uint64_t *size,
+					 uint64_t *mmap_offset);
 int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
 				      struct dma_buf **dmabuf);
 void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4bb8b5fd7598..1077de8bced2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2006,8 +2006,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 
 	/* Free the BO*/
 	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
-	if (!mem->is_imported)
-		drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
+	drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
 	if (mem->dmabuf) {
 		dma_buf_put(mem->dmabuf);
 		mem->dmabuf = NULL;
@@ -2363,34 +2362,26 @@ int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 	return 0;
 }
 
-int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
-				      struct dma_buf *dma_buf,
-				      uint64_t va, void *drm_priv,
-				      struct kgd_mem **mem, uint64_t *size,
-				      uint64_t *mmap_offset)
+static int import_obj_create(struct amdgpu_device *adev,
+			     struct dma_buf *dma_buf,
+			     struct drm_gem_object *obj,
+			     uint64_t va, void *drm_priv,
+			     struct kgd_mem **mem, uint64_t *size,
+			     uint64_t *mmap_offset)
 {
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
-	struct drm_gem_object *obj;
 	struct amdgpu_bo *bo;
 	int ret;
 
-	obj = amdgpu_gem_prime_import(adev_to_drm(adev), dma_buf);
-	if (IS_ERR(obj))
-		return PTR_ERR(obj);
-
 	bo = gem_to_amdgpu_bo(obj);
 	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
-				    AMDGPU_GEM_DOMAIN_GTT))) {
+				    AMDGPU_GEM_DOMAIN_GTT)))
 		/* Only VRAM and GTT BOs are supported */
-		ret = -EINVAL;
-		goto err_put_obj;
-	}
+		return -EINVAL;
 
 	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
-	if (!*mem) {
-		ret = -ENOMEM;
-		goto err_put_obj;
-	}
+	if (!*mem)
+		return -ENOMEM;
 
 	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
 	if (ret)
@@ -2440,8 +2431,41 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
 	drm_vma_node_revoke(&obj->vma_node, drm_priv);
 err_free_mem:
 	kfree(*mem);
+	return ret;
+}
+
+int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
+					 uint64_t va, void *drm_priv,
+					 struct kgd_mem **mem, uint64_t *size,
+					 uint64_t *mmap_offset)
+{
+	struct drm_gem_object *obj;
+	uint32_t handle;
+	int ret;
+
+	ret = drm_gem_prime_fd_to_handle(&adev->ddev, adev->kfd.client.file, fd,
+					 &handle);
+	if (ret)
+		return ret;
+	obj = drm_gem_object_lookup(adev->kfd.client.file, handle);
+	if (!obj) {
+		ret = -EINVAL;
+		goto err_release_handle;
+	}
+
+	ret = import_obj_create(adev, obj->dma_buf, obj, va, drm_priv, mem, size,
+				mmap_offset);
+	if (ret)
+		goto err_put_obj;
+
+	(*mem)->gem_handle = handle;
+
+	return 0;
+
 err_put_obj:
 	drm_gem_object_put(obj);
+err_release_handle:
+	drm_gem_handle_delete(adev->kfd.client.file, handle);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 4417a9863cd0..1a2e9f564b7f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1564,16 +1564,11 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 {
 	struct kfd_ioctl_import_dmabuf_args *args = data;
 	struct kfd_process_device *pdd;
-	struct dma_buf *dmabuf;
 	int idr_handle;
 	uint64_t size;
 	void *mem;
 	int r;
 
-	dmabuf = dma_buf_get(args->dmabuf_fd);
-	if (IS_ERR(dmabuf))
-		return PTR_ERR(dmabuf);
-
 	mutex_lock(&p->mutex);
 	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
 	if (!pdd) {
@@ -1587,10 +1582,10 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 		goto err_unlock;
 	}
 
-	r = amdgpu_amdkfd_gpuvm_import_dmabuf(pdd->dev->adev, dmabuf,
-					      args->va_addr, pdd->drm_priv,
-					      (struct kgd_mem **)&mem, &size,
-					      NULL);
+	r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, args->dmabuf_fd,
+						 args->va_addr, pdd->drm_priv,
+						 (struct kgd_mem **)&mem, &size,
+						 NULL);
 	if (r)
 		goto err_unlock;
 
@@ -1601,7 +1596,6 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	}
 
 	mutex_unlock(&p->mutex);
-	dma_buf_put(dmabuf);
 
 	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
 
@@ -1612,7 +1606,6 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 					       pdd->drm_priv, NULL);
 err_unlock:
 	mutex_unlock(&p->mutex);
-	dma_buf_put(dmabuf);
 	return r;
 }
 
-- 
2.34.1

