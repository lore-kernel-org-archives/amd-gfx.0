Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F649C7EE24
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFB810E53B;
	Wed, 10 May 2023 21:24:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DAE10E52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOELjg6z9jPlQdV6OQ/4YZVohmu4Sn++ld9PV1uavj3YmPI4NrjcwQZToq4s7QQtFDMLQp9WH51oRzvgf99GSApgYb3d92SIIQVjLshUfktlusxNU8eeTrQmh0O8lC7t2dHaD4Qc0BAmzdcGKUCn5XcW1q6a1jocHzCU9no7h6O23F/N4F3sxaOLqocRGQjZv/uv6N8G8r2z0q53i/kZ9JayXts/9bYgrRubQfPLROGQjvNb7+wYUNTTGbpq16bacbwX8UC9JH44ymLVo3q3PyJyVBQOTIJQzR9o3Pr75ru09ggWxmbY26vZxhrsO81F/iDMRWjwyiI3nVLoumXzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj96sqvQv4B9ygL/UD6Pkuul4R6eqhIb3mGUDyodRx4=;
 b=IyDXlB9BEJuOhE6VX4oRK346G/54lc1EI8foRux33Doaea6NjrRXDfrTD/5E5zvXL+FtlfhafM6C57TheDPLe/qoAwRT4i3ySPw+t0hB3hWsrnN0RweckZJKjgqj3NQMZJZhNonVMSsWgJEpwKrViTotSZqMqzpN8BQ3oOPf1rZjcyfujTUb+BAA9cJ60jF9YNHi7rpk01v1nansVZIRysrVYFE/U+1nxGSAXS0PmmAiqhr5Vd3UdPoSkOk6nao7eF7yRg2HSs1w4Yx5PMem029cPkVx6a0ifr98zMSMkjCanXE0YdPNUGqH+eII2zpcD6E4u2LEJpsKk9+nJ81Gsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj96sqvQv4B9ygL/UD6Pkuul4R6eqhIb3mGUDyodRx4=;
 b=FRax58QZTeex6bMd4zZFXsxnjbDqeWXcDe3Qhtwt9LvSotgjevQXGCAtjxdHcbMJ1ujnoMhau3U5HqYNvnei+o0Y0kOSJtGrNE3iHg74XL2rOTqsUr3uWlxrNPReOCogbSjpXcq9KqhGdbq9PUBv4U9uACwTsQoZpLcfSD5AXd8=
Received: from MW4PR03CA0069.namprd03.prod.outlook.com (2603:10b6:303:b6::14)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:23:57 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::d0) by MW4PR03CA0069.outlook.office365.com
 (2603:10b6:303:b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/29] drm/amdgpu: Add memory partition mem_id to amdgpu_bo
Date: Wed, 10 May 2023 17:23:18 -0400
Message-ID: <20230510212333.2071373-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bccc95b-7198-43d0-8fab-08db519cdd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJVSbnhYDwOCCUrYEpYEglzLD1eEsTvYCCaLgJHf93gjNWhyiJTlIUqTDOWnjl3Wbx01wS1sFOfNIJv5DDaMBffJKVfHU35X5Z/llXtqBY52hPG3fR9kLJju4xu3VXK/2hc3atCF8/eXuX59oOWw3s6kqmzkhQGh9pB04BXHxA9vc0Z8Dh/wIkus1bvWSUKCVjpnTRSXC4AdYq9tV1oJm1ezqLH4LdZOxk3PJRN+aHChn2uZ/FWwQCc8l4DN6Q7cH9MzjwRjpppXU5irj1UYvnxWLlSGybwvPhm02aLnx4BEyzPQ/wXTH40x4QDY8/U8M4cv46cPzN2qFmQdpxcimOqWZBFfmhosqfnpslyQ6xeK/WjT3mra2mow2Zqee85pfBBo/3RLwWtCIIGwzD0VezoFwALr0hpcGCscKlsY3kY3qTw2rjfdljebPjqzuJZP66baBAQy2RnWFI+5YDkL3JY/Zc3ThnNzwgvG3foUHR2KjG0F+nhSZAfGaGchS31U6KJosf3dZDqRQBytTUjycsU5jI991T5pAphQLtNtyGAcEcL+IfDRyK9vdCjKT60+qoJt7t4PdmSfGitVj7HZEX0ANhRf+8bhNYO+950cMBPXkqxbD4zCA8iThboRMEXjPidIFGfOhHJ1Tv/LWy774/dlMkMFDrXUeL4wkBytge6vVoSKXFMGJ7U4jw6VJpRDfXJUsQoq7xip+BIsDMhUtgZjYnuv05MeIcviKI4HYUs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(47076005)(81166007)(26005)(356005)(1076003)(86362001)(70206006)(70586007)(40480700001)(2906002)(40460700003)(336012)(4326008)(316002)(6916009)(8676002)(5660300002)(8936002)(41300700001)(478600001)(82310400005)(54906003)(83380400001)(82740400003)(426003)(7696005)(6666004)(2616005)(36756003)(36860700001)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:57.1786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bccc95b-7198-43d0-8fab-08db519cdd5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Add mem_id_plus1 parameter to amdgpu_gem_object_create and pass it to
amdgpu_bo_create. For dGPU mode allocation, mem_id is used by VRAM
manager to get the memory partition fpfn, lpfn from xcp manager. For APU
native mode allocation, mem_id is used to get NUMA node id from xcp
manager, then pass to TTM as numa pool id to alloc memory from the
specific NUMA node. mem_id -1 means for entire VRAM or any NUMA nodes.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h          | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h       | 5 +++++
 6 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 12149b317b88..6d0c25e34af1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -289,7 +289,7 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
 
 	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, 1,
 			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
-			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj);
+			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0);
 
 	amdgpu_bo_unreserve(mem->bo);
 
@@ -1720,7 +1720,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			va, (*mem)->aql_queue ? size << 1 : size, domain_string(alloc_domain));
 
 	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
-				       bo_type, NULL, &gobj);
+				       bo_type, NULL, &gobj, 0);
 	if (ret) {
 		pr_debug("Failed to create BO on domain %s. ret %d\n",
 			 domain_string(alloc_domain), ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e97b1eef2c9d..8b162f05d1fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -335,7 +335,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 
 	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
 				       AMDGPU_GEM_DOMAIN_CPU, flags,
-				       ttm_bo_type_sg, resv, &gobj);
+				       ttm_bo_type_sg, resv, &gobj, 0);
 	if (ret)
 		goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6936cd63df42..01029b495f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -97,7 +97,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     int alignment, u32 initial_domain,
 			     u64 flags, enum ttm_bo_type type,
 			     struct dma_resv *resv,
-			     struct drm_gem_object **obj)
+			     struct drm_gem_object **obj, int8_t mem_id_plus1)
 {
 	struct amdgpu_bo *bo;
 	struct amdgpu_bo_user *ubo;
@@ -115,6 +115,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 	bp.flags = flags;
 	bp.domain = initial_domain;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.mem_id_plus1 = mem_id_plus1;
 
 	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r)
@@ -335,7 +336,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 retry:
 	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
 				     initial_domain,
-				     flags, ttm_bo_type_device, resv, &gobj);
+				     flags, ttm_bo_type_device, resv, &gobj, 0);
 	if (r && r != -ERESTARTSYS) {
 		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
 			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
@@ -404,7 +405,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 
 	/* create a gem object to contain this object in */
 	r = amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOMAIN_CPU,
-				     0, ttm_bo_type_device, NULL, &gobj);
+				     0, ttm_bo_type_device, NULL, &gobj, 0);
 	if (r)
 		return r;
 
@@ -930,7 +931,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 	domain = amdgpu_bo_get_preferred_domain(adev,
 				amdgpu_display_supported_domains(adev, flags));
 	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
-				     ttm_bo_type_device, NULL, &gobj);
+				     ttm_bo_type_device, NULL, &gobj, 0);
 	if (r)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index 637bf51dbf06..646c4fcc8e40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -43,8 +43,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     int alignment, u32 initial_domain,
 			     u64 flags, enum ttm_bo_type type,
 			     struct dma_resv *resv,
-			     struct drm_gem_object **obj);
-
+			     struct drm_gem_object **obj, int8_t mem_id_plus1);
 int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c6214db42bda..155b62971a33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -574,6 +574,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 
 	bo->flags = bp->flags;
 
+	/* bo->mem_id -1 means any partition */
+	bo->mem_id = bp->mem_id_plus1 - 1;
+
 	if (!amdgpu_bo_support_uswc(bo->flags))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8fdfa739a4f2..521a432348a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -56,6 +56,8 @@ struct amdgpu_bo_param {
 	bool				no_wait_gpu;
 	struct dma_resv			*resv;
 	void				(*destroy)(struct ttm_buffer_object *bo);
+	/* memory partition number plus 1, 0 means any partition */
+	int8_t				mem_id_plus1;
 };
 
 /* bo virtual addresses in a vm */
@@ -108,6 +110,9 @@ struct amdgpu_bo {
 	struct mmu_interval_notifier	notifier;
 #endif
 	struct kgd_mem                  *kfd_bo;
+
+	/* memory partition number, -1 means any partition */
+	int8_t				mem_id;
 };
 
 struct amdgpu_bo_user {
-- 
2.40.1

