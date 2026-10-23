Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACEF606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HYwRoEGk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA227112C66;
	Fri, 23 Oct 2026 17:13:13 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FCB10E496
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 14:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sehcv6co2jgXeNUAYKi7f2VyUGmK32cM04bu3TrbGf+EyBPdh36XJlH/caqDy7EKCu09iPuVy4B/WYgmXshuXwmQEUGsfiYyB0Z2FHb0m9M+93xsZMrGaKSy9VarEFPQ+Ou21tqSAjfM+asnlflBKAAaKr3lGx6IVRvIASnuCFbv2uiM5nTg7FS8GOFWH6k0nujrSycTTLf1ooA4Fdo8wmVRUguWnEJXDbif525dJ2BN6YZJ+jIW+uDEAqAuaBahStZKWuLQajqW6Zdt6xAcPJOn+TwinAE786LCAKkgJGeL8PdbimODrEjCBV3x5Lz4WTv/rS/d2rNeNNhTweo/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwTE3G+H7XueeeNdNdhmc5RgQ2VlFCD7fMXg3Z65+0g=;
 b=nL77nmmDs/hyZcRn/z2BukMZfMUcy14ZsgzCt1/bITRW/vAupniIx0hXNZW1zfemSyai3I56Hrd0XkX4xCl9hsYvBm0n+P+In1WFHR+ZUt07ZDospOiNUjfFCnXwZ6h5WS+t+VH7+OpDR5locpe5L8rVhttT3rtdL/wcNGIdD03K+MSZoEw6olL6iVHAKuxQNqbgscwrZpegKuPfxccmgHuGBBRzUc1FfCaKxc6FycMi4aAF5FqZq4UonjkxAj8dUSPoBIfDVJ3IVqRy1gH0vcR6DDOGjAIYl29cJavWLzl2BKfxEamJvdC8kM8rz1B7Ci/SjH2FnVN/dUzoTV83vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwTE3G+H7XueeeNdNdhmc5RgQ2VlFCD7fMXg3Z65+0g=;
 b=HYwRoEGkSv6M5oPfx2UdZbFnJhbZwC9mg/3DMV8bhCATg9cQZl1p/U9W/aHlMCJId0Bc4KW1mvpiFnv9NC8VRIOO5bu0tUYBn1HDj1JYoK9MHdRnOQ4SNw/8Y1uZPq/L4O4/T0a9geZbTr0I7GthIFE60elE3yeYTacYehe7F9U=
Received: from SJ0PR05CA0205.namprd05.prod.outlook.com (2603:10b6:a03:330::30)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 14:47:43 +0000
Received: from CO1PEPF00018867.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::ac) by SJ0PR05CA0205.outlook.office365.com
 (2603:10b6:a03:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Fri,
 23 Oct 2026 14:47:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00018867.mail.protection.outlook.com (10.167.249.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 14:47:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 09:47:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 09:47:38 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 23 Oct 2026 09:47:37 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Get foreign dma-buf info
Date: Fri, 23 Oct 2026 09:48:12 -0500
Message-ID: <20261023144813.1220394-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018867:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f15b80-3137-4f9d-9a2b-08df311497cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|261021121427099003|18002099003|10067099003|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: efvT99yvkT9deS90DdC8q+cff9yPRit88tv+WTCM7utHLoek0OBCPoviR252FM7HANW479bLVVFOb0N6FAd0L3bnSN6vLAZe6J+cLxcQGYLfAPeIyhNcdX3nyDsT2kS8mEZUBRNqtvAXqcXbj8Bng2QbYt7HulunynbnhJeceIdnNnpoe9+vXH6ENFzri+lzyqTk+FhQPBDOm6Bx4PUqxPicBdTRL3CpMBFOthTmBeCPx9s0OZH9Yq8B5Y2pkZrf/V8d6vtTQMVNICakuDxC1SRL//XvjYBmmsYXJPIDohbSUqRDWChARXEk82lQs5EY1Uwpo0cuRfgF2+k4rlpWQronJ2wMQ5VlUtrMtfvhrvt9WbbJSPPC3PT870Ovl76lChmEs42qpdqaHucVqFV8d0Bq1ze4ohGxmMK+22w3nOlkjircH+Do3bJ7vu3UVVPJja3xr7ZHzRioI0IOzgXLDUKu1QAjQrOiAEqAb87fuylpijs61hayIqNfrvFfP5uWJuRq3KxLd6AG2c8qyIu21c88mPjH3itYjhjZ44jy6SX6RQEYOLWzDBwnCUnktMl7KY72Kqcn424QIovHdXFtArmtf+tBZfhefUEVayWWJCAdeWCeOcuUkXjnSCyTKsp1/jQ7mAO+0Bx/Gs/i8bj2qGh/sSIN3D5RzzkiQ+J1wci8IYlheKwRImJwDM0g7QRtTdaJG0s3y6wjmZnkZ/2gfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(261021121427099003)(18002099003)(10067099003)(261021123027099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t3xr73+K+HA3fDe0yg3KM4MvvpRxQw7OGI5pvaH2z3TWQ2mMYisgGwAfh1b66g6J5BWDDkqeykwQXn3CQjDSEFEc0uu8pc8Eptahb10RMyUKqi2AHb7bBjnCjZQw6HzDydu+UIuD9UH9cWBMbBOpCx85+4sPDwQRHt9DMSoaVxLUiUA9DQvb6SqUXHnsC9M623eI/WN61r9J0cegO5W9m8VKnRzyiMp7u3SnPH48nW0dDsm7v5tWh2MSY7mZQBEbIBVL1ylC5QrihJe98GMG3fe1YuUoGpFXM2hYwrqr29RwajnRiAEpZd3MKQOgz6GrnR6Zw2KKY2nLQ9dptw1KG0sK4UrNCpEJ+aSndnfHusd7oHtsQ9sh+ov1w3kiDrteD4w7pr87DLVeDc3bGQVi+URrOZwhWjwMuKgW5FYipnW7IHEbhOSrBtrwX4bu6BFL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:47:42.4616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f15b80-3137-4f9d-9a2b-08df311497cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018867.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xiaogang Chen <xiaogang.chen@amd.com>

When import a dma-buf into kfd driver the dma-buf can be exported from amdgpu
driver or another driver/component(foreign).

Current kfd driver can't handle foreign dma-buf at AMDKFD_IOC_GET_DMABUF_INFO.
When a foreign dma-buf is imported into kfd driver(ex udmabuf) it becomes a
normal kfd buf that can be exported, then imported in same or another amdgpu
device. That requires kfd drive to get new exported dma-buf info before it is
imported.

Extend kfd_ioctl_get_dmabuf_info to handle args->dmabuf_fd that was originally
exported by foreign component.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 ++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 47 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 11 ++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e3da382ceb3c..170f0ea0b78a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -347,6 +347,9 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
 					 uint64_t va, void *drm_priv,
 					 struct kgd_mem **mem, uint64_t *size,
 					 uint64_t *mmap_offset);
+int amdgpu_amdkfd_gpuvm_imported_dmabuf_info(void *kgd_info, int fd,
+					     uint64_t *size, uint32_t *flags,
+					     uint32_t *gpu_id);
 int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
 				      struct dma_buf **dmabuf);
 void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a5d1d83ee5d3..b7fea3a2f5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2452,6 +2452,53 @@ static int import_obj_create(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_amdkfd_gpuvm_imported_dmabuf_info(void *kgd_info, int fd,
+					     uint64_t *size, uint32_t *flags,
+					     uint32_t *gpu_id)
+{
+	struct amdkfd_process_info *info = kgd_info;
+	struct dma_buf *dma_buf;
+	struct kgd_mem *mem;
+	int ret = -EINVAL;
+
+	if (!info)
+		return -EINVAL;
+
+	dma_buf = dma_buf_get(fd);
+	if (IS_ERR(dma_buf))
+		return PTR_ERR(dma_buf);
+
+	mutex_lock(&info->lock);
+	list_for_each_entry(mem, &info->kfd_bo_list, validate_list) {
+		struct amdgpu_device *bo_adev;
+		struct kfd_dev *kfd;
+		int8_t xcp_id;
+
+		if (!mem->is_imported || mem->dmabuf != dma_buf)
+			continue;
+
+		if (size)
+			*size = amdgpu_bo_size(mem->bo);
+		if (flags)
+			*flags = mem->alloc_flags;
+		if (gpu_id) {
+			bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
+			kfd = bo_adev->kfd.dev;
+			xcp_id = mem->bo->xcp_id;
+			if (kfd && xcp_id >= 0 && xcp_id < kfd->num_nodes &&
+			    kfd->nodes[xcp_id])
+				*gpu_id = kfd->nodes[xcp_id]->id;
+			else if (kfd && kfd->num_nodes && kfd->nodes[0])
+				*gpu_id = kfd->nodes[0]->id;
+		}
+		ret = 0;
+		break;
+	}
+	mutex_unlock(&info->lock);
+	dma_buf_put(dma_buf);
+	return ret;
+}
+
 int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
 					 uint64_t va, void *drm_priv,
 					 struct kgd_mem **mem, uint64_t *size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1d86ddfd6bde..9ca20331e815 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1595,8 +1595,17 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 					  &dmabuf_adev, &args->size,
 					  &metadata_buffer, args->metadata_size,
 					  &args->metadata_size, &flags, &xcp_id);
-	if (r)
+	if (r) {
+		/* Foreign dma-buf: report it when this process imported it. */
+		r = amdgpu_amdkfd_gpuvm_imported_dmabuf_info(p->kgd_process_info,
+							     args->dmabuf_fd,
+							     &args->size,
+							     &args->flags,
+							     &args->gpu_id);
+		if (!r)
+			args->metadata_size = 0;
 		goto exit;
+	}
 
 	if (xcp_id >= 0)
 		args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
-- 
2.34.1

