Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601A3C77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 14:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23E310EC7E;
	Thu, 20 Apr 2023 14:48:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF6110EC75
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 14:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPUqaNzyJgNxdzymdxp8T7GKNXBNXuFmjrVtGhrgP/aa395yd6AaMtpPTZ5brREyS+kN8QCpGzFddh9cH9MgHG5QQ7TPrcBeNkIRqsTesNGLiyCDDeq31voNylbRLWqz8TmLlcY9jM66Km9CNJM+KC2zfMtt4G7l9Aa4HilNaMyaUjgOLy4vN9HxDZQo4R78KnRN4zRevpFQh8lkyMoM59lTPhPIDV5Oz58r7A8mrvQQR+8EvRXLapLOBE/fHTskJeupjgSjuXn0nGELiO4VCBRhDKq5HVfq7Fva4RIpHFK1lqH/0PYMYlL5LKx/+XTQSM7NfDdvr5DJjpqoCEmwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQVd2qfjd5FV4OgeqRBYqdh7cjEUkAAnv16P/JeJOHo=;
 b=nbAE9H8/pU6zWjGubk/Yue+byW8yDDyCAKcnw/1iwufy1nANirlP7Gxr5FMmSadKE4G8LZ+nkXMvrpQz+SeYmABa/lEPD0AeDY8z4YsKh6dbPXfPkebBsBg5IhCkbiK9eAMfdplVL4e89/pysdQOFTjKaGXgZwzZQESWIE9BFk3oBEaLVjXZCKwlBS8p3gqnWG3rOxTCGMSRKHp+s5i0hPN4KfNykKpxFvgZQzFQq4PU9eMQJNTEdnSPJ3Y9MNUqJcdrJXzNg4g7Z6qlUFWnNeEVsnORVXdyNMh7zJKxHaPLSZ4TiHPZwYb/v1FJm0oYpO1SVBxkOurzHo1nLq7M3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQVd2qfjd5FV4OgeqRBYqdh7cjEUkAAnv16P/JeJOHo=;
 b=ypCdH5ytW4pL5Imnx2Fvx3ELPa1/vJhiG5EG/aNgMZmvAzmuRgSd61WhfvCLCMQNHj6oNnR90Q5EJO+i29O38s6/1np72N4JcutMWsy8SFP8hNJBlL1Jpb6oGwIW6OMeoO8pqIOfIdZ2sf/rkqTOAK9FB2qedTCgk4pWTN1VVHI=
Received: from DS7PR05CA0015.namprd05.prod.outlook.com (2603:10b6:5:3b9::20)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 14:48:02 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::87) by DS7PR05CA0015.outlook.office365.com
 (2603:10b6:5:3b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 14:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.24 via Frontend Transport; Thu, 20 Apr 2023 14:48:00 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 20 Apr 2023 09:47:58 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
 functions
Date: Thu, 20 Apr 2023 07:47:13 -0700
Message-ID: <20230420144714.124377-6-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: f8663784-d56b-414e-2116-08db41ae3d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaqGK5X/hutUfQNE9fPtNy5/RAlgVgYklENL4h8UpdFduss+JQOSYIVAuFh/LsatF4VFZyDUFpE777EMZdqkYIXcRInkhYA3pqBJWCzG6mBiGLKRFtimvug8vak7aVNzHMjLEWLc/7C2z9DX0okyX9djf4gtT9yxpAJIJt6RrRWYVYiLTlYvWtACtMgV7gmYoLRlV/LpKOhh43su1WlCttt6PXj8Zuj/gXPKIgWKrmOY0okdwCOFaZXeTm3/Vei0u9X/xZC3Hfnsjn6v+F8G+aIB+B4578wDzv80qhUg+aNMOLd/uBNJWMenV4aKzM0XWr1fbzJP2x96LWmkbMSBSEcsKyjLkPjHW/itWEOS8AfCXfCToL/1KoaOg7a79EXl98trS5QK7kdoQKU/9joCn/GWwWX0omFe2P9DHydFlUE7+YdjnKXbzcrfqtIIjvofSOAuDyCg8kZs6mGfaB8wXZ+FCV6v8mF0djlQo/XC2NNZyIQGJG5S0p7TLSljlQVC728UhGxoCEAJpX2D1zCcmJNrs0abCitoTH8F0V8KcZb0JKyuhklbWQWM6uKj8zhC9Jo3giF040fBfcv5Hyqtc7kkNGLMSj1dQPYK1uqk92HCccdr1cXjih1FcBapLEAr3cY8/mvFAGkpjufOa921RRRqS3ANb/h8S+7bwHNsB794riPxCsbYLsvO0/mEAdFzXQM87FIHOSZDRJoZErNY1ctMv17+SMkN+OjaDMSG+v8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(83380400001)(47076005)(478600001)(2616005)(36860700001)(40480700001)(86362001)(1076003)(26005)(7696005)(6666004)(4326008)(316002)(70206006)(70586007)(6916009)(82740400003)(186003)(426003)(336012)(16526019)(8676002)(8936002)(2906002)(30864003)(81166007)(356005)(41300700001)(5660300002)(40460700003)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:48:00.6268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8663784-d56b-414e-2116-08db41ae3d07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch introduces new IOCTL for userqueue secure semaphore.

The signal IOCTL called from userspace application creates a drm
syncobj and array of bo GEM handles and passed in as parameter to
the driver to install the fence into it.

The wait IOCTL gets an array of drm syncobjs, finds the fences
attached to the drm syncobjs and obtain the array of
memory_address/fence_value combintion which are returned to
userspace.

v2: Worked on review comments from Christian for the following
    modifications

    - Install fence into GEM BO object.
    - Lock all BO's using the dma resv subsystem
    - Reorder the sequence in signal IOCTL function.
    - Get write pointer from the shadow wptr
    - use userq_fence to fetch the va/value in wait IOCTL.

v3: Worked on review comments from Christian
    - Use drm_exec helper for the proper BO drm reserve and avoid BO
      lock/unlock issues.
    - fence/fence driver reference count logic for signal/wait IOCTLs.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 312 +++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   1 +
 5 files changed, 315 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3bc8a2d35bb3..1d8a762f43c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -970,6 +970,8 @@ struct amdgpu_device {
 	struct amdgpu_mes               mes;
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 
+	struct amdgpu_userq_mgr         *userq_mgr;
+
 	/* df */
 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e9c5047087d0..b59e31845568 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2751,6 +2751,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a03d12f83147..1c455b7ebcd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -25,6 +25,7 @@
 #include <linux/kref.h>
 #include <linux/slab.h>
 
+#include <drm/drm_exec.h>
 #include <drm/drm_syncobj.h>
 
 #include "amdgpu.h"
@@ -84,7 +85,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 			     &fence_drv->cpu_addr);
 	if (r)
 		return -ENOMEM;
-	
+
 	kref_init(&fence_drv->refcount);
 	INIT_LIST_HEAD(&fence_drv->fences);
 	spin_lock_init(&fence_drv->fence_list_lock);
@@ -124,28 +125,27 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 {
 	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
-					 struct amdgpu_userq_fence_driver,
-					 refcount);
+					struct amdgpu_userq_fence_driver,
+					refcount);
 	struct amdgpu_device *adev = fence_drv->adev;
 	struct amdgpu_userq_fence *fence, *tmp;
 	struct dma_fence *f;
-	
+
 	spin_lock(&fence_drv->fence_list_lock);
 	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
 		f = &fence->base;
-		
+
 		if (!dma_fence_is_signaled(f)) {
 			dma_fence_set_error(f, -ECANCELED);
 			dma_fence_signal(f);
 		}
-		
+
 		list_del(&fence->link);
 		dma_fence_put(f);
 	}
-	
+
 	WARN_ON_ONCE(!list_empty(&fence_drv->fences));
 	spin_unlock(&fence_drv->fence_list_lock);
-	
 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
 	kfree(fence_drv);
@@ -161,6 +161,11 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
 	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
 }
 
+static inline bool amdgpu_userq_fence_test_signaled(struct dma_fence *fence)
+{
+	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
+}
+
 int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 			      u64 seq, struct dma_fence **f)
 {
@@ -251,3 +256,294 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.signaled = amdgpu_userq_fence_signaled,
 	.release = amdgpu_userq_fence_release,
 };
+
+static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
+					struct amdgpu_usermode_queue *queue,
+					u64 *wptr)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_bo *bo;
+	u64 addr, *ptr;
+	int r;
+
+	addr = queue->userq_prop.wptr_gpu_addr >> PAGE_SHIFT;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
+	if (!mapping)
+		return -EINVAL;
+
+	bo = mapping->bo_va->base.bo;
+	r = amdgpu_bo_reserve(bo, true);
+	if (r) {
+		DRM_ERROR("Failed to reserve userqueue wptr bo");
+		return r;
+	}
+
+	r = amdgpu_bo_kmap(bo, (void **)&ptr);
+	if (r) {
+		DRM_ERROR("Failed mapping the userqueue wptr bo");
+		goto map_error;
+	}
+
+	*wptr = le64_to_cpu(*ptr);
+
+	amdgpu_bo_kunmap(bo);
+	amdgpu_bo_unreserve(bo);
+
+	return 0;
+
+map_error:
+	amdgpu_bo_unreserve(bo);
+	return r;
+}
+
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct drm_amdgpu_userq_signal *args = data;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_userq_mgr *userq_mgr = adev->userq_mgr;
+	struct amdgpu_usermode_queue *queue;
+	struct drm_gem_object **gobj = NULL;
+	struct drm_syncobj *syncobj = NULL;
+	u32 *bo_handles, num_bo_handles;
+	struct dma_fence *fence;
+	struct drm_exec exec;
+	u64 wptr;
+	int r, i;
+
+	/* Retrieve the user queue */
+	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
+	if (!queue)
+		return -ENOENT;
+
+	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
+	if (r)
+		return -EINVAL;
+
+	/* Find Syncobj if any */
+	syncobj = drm_syncobj_find(filp, args->syncobj_handle);
+
+	/* Array of bo handles */
+	num_bo_handles = args->num_bo_handles;
+	bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), GFP_KERNEL);
+	if (!bo_handles)
+		return -ENOMEM;
+
+	if (copy_from_user(bo_handles, u64_to_user_ptr(args->bo_handles_array),
+			   sizeof(u32) * num_bo_handles)) {
+		r = -EFAULT;
+		goto cleanup_bo_handles;
+	}
+
+	/* Create a new fence */
+	r = amdgpu_userq_fence_create(queue, wptr, &fence);
+	if (!fence)
+		goto cleanup_bo_handles;
+
+	if (amdgpu_userq_fence_test_signaled(fence))
+		goto signaled;
+
+	/* Add the created fence to syncobj/BO's */
+	if (syncobj) {
+		drm_syncobj_replace_fence(syncobj, fence);
+		dma_fence_put(fence);
+	}
+
+	/* Array of GEM object handles */
+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (!gobj) {
+		r = -ENOMEM;
+		goto cleanup_bo_handles;
+	}
+
+	drm_exec_init(&exec, true);
+	drm_exec_while_not_all_locked(&exec) {
+		for (i = 0; i < num_bo_handles; i++) {
+			/* Retrieve GEM object */
+			gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
+			if (!gobj[i]) {
+				r = -ENOENT;
+				goto exec_fini;
+			}
+
+			r = drm_exec_prepare_obj(&exec, gobj[i], 1);
+			drm_exec_continue_on_contention(&exec);
+			if (unlikely(r))
+				goto exec_fini;
+
+			dma_resv_add_fence(gobj[i]->resv, fence,
+					   args->bo_flags & AMDGPU_USERQ_BO_READ ?
+					   DMA_RESV_USAGE_READ :
+					   DMA_RESV_USAGE_WRITE);
+		}
+	}
+
+exec_fini:
+	drm_exec_fini(&exec);
+signaled:
+	dma_fence_put(fence);
+	kfree(gobj);
+cleanup_bo_handles:
+	kfree(bo_handles);
+
+	return r;
+}
+
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
+	struct drm_amdgpu_userq_wait *wait_info = data;
+	u32 *syncobj_handles, *bo_handles;
+	struct dma_resv_iter resv_cursor;
+	u32 num_syncobj, num_bo_handles;
+	struct drm_gem_object **gobj;
+	u64 num_fences = 0;
+	int i, j, r, cur;
+	bool bo_flag;
+
+	num_bo_handles = wait_info->num_bo_handles;
+	/* Array of GEM BO handles */
+	bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), GFP_KERNEL);
+	if (!bo_handles)
+		return -ENOMEM;
+
+	if (copy_from_user(bo_handles, u64_to_user_ptr(wait_info->bo_handles_array),
+			   sizeof(u32) * num_bo_handles)) {
+		r = -EFAULT;
+		goto err_free_bo_handles;
+	}
+
+	/* Array of GEM object handles */
+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (!gobj) {
+		r = -ENOMEM;
+		goto err_free_fence_info;
+	}
+
+	if (wait_info->num_fences) {
+		/* Array of fence gpu address */
+		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
+		if (!fence_info) {
+			r = -ENOMEM;
+			goto err_free_bo_handles;
+		}
+	}
+
+	/* Track fence_info index value */
+	cur = num_fences;
+
+	/* Retrieve GEM objects's fence */
+	bo_flag = wait_info->bo_wait_flags & AMDGPU_USERQ_BO_READ;
+	for (i = 0; i < num_bo_handles; i++) {
+		struct dma_fence *bo_fence;
+
+		gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
+		if (!gobj[i]) {
+			r = -ENOENT;
+			goto err_put_gobj;
+		}
+
+		dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
+					bo_flag ?
+					DMA_RESV_USAGE_READ :
+					DMA_RESV_USAGE_WRITE,
+					bo_fence) {
+			if (!wait_info->num_fences) {
+				++num_fences;
+				dma_fence_get(bo_fence);
+				continue;
+			}
+
+			/* Store drm syncobj's gpu va address and value */
+			fence_info[num_fences - cur].va =
+				to_amdgpu_userq_fence(bo_fence)->fence_drv->gpu_addr;
+			fence_info[num_fences - cur].value = bo_fence->seqno;
+
+			cur--;
+			dma_fence_put(bo_fence);
+		}
+
+		drm_gem_object_put(gobj[i]);
+	}
+
+	num_syncobj = wait_info->num_syncobj_handles;
+	/* Array of Syncobj handles */
+	syncobj_handles = kmalloc_array(num_syncobj, sizeof(*syncobj_handles), GFP_KERNEL);
+	if (!syncobj_handles)
+		goto err_put_gobj;
+
+	if (copy_from_user(syncobj_handles, u64_to_user_ptr(wait_info->syncobj_handles_array),
+				sizeof(u32) * num_syncobj)) {
+		r = -EFAULT;
+		goto err_free_syncobj_handles;
+	}
+
+	/* Retrieve syncobj's fence */
+	for (j = 0; j < num_syncobj; j++) {
+		struct dma_fence *fence = NULL;
+		struct drm_syncobj *syncobj;
+
+		syncobj = drm_syncobj_find(filp, syncobj_handles[j]);
+		fence = drm_syncobj_fence_get(syncobj);
+		if (!fence)
+			continue;
+
+		if (!wait_info->num_fences) {
+			++num_fences;
+			continue;
+		}
+
+		/* Store drm syncobj's gpu va address and value */
+		fence_info[num_fences - cur].va = to_amdgpu_userq_fence(fence)->fence_drv->gpu_addr;
+		fence_info[num_fences - cur].value = fence->seqno;
+		dma_fence_put(fence);
+
+		cur--;
+		dma_fence_put(fence);
+	}
+
+	/*
+	 * Passing num_fences = 0 means that userspace doen't want to
+	 * retrieve userq_fence_info. If num_fences = 0 we skip filling
+	 * userq_fence_info and return the actual number of fences on
+	 * args->num_fences.
+	 */
+
+	if (!wait_info->num_fences)
+		goto no_fences;
+
+	if (copy_to_user(u64_to_user_ptr(wait_info->userq_fence_info),
+			 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
+		r = -EFAULT;
+		goto err_free_gobj;
+	}
+
+	/* Free all handles */
+	kfree(syncobj_handles);
+	kfree(gobj);
+	kfree(fence_info);
+	kfree(bo_handles);
+
+	return 0;
+
+err_free_syncobj_handles:
+	kfree(syncobj_handles);
+err_put_gobj:
+	while (i-- > 0)
+		drm_gem_object_put(gobj[i]);
+no_fences:
+	if (!wait_info->num_fences)
+		wait_info->num_fences = num_fences;
+err_free_gobj:
+	kfree(gobj);
+err_free_fence_info:
+	kfree(fence_info);
+err_free_bo_handles:
+	kfree(bo_handles);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 7329b4e5dd30..2b2f52296d76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -29,6 +29,8 @@
 
 #include "amdgpu_userqueue.h"
 
+#define AMDGPU_USERQ_BO_READ	0x1
+
 struct amdgpu_userq_fence {
 	struct dma_fence base;
 	/* userq fence lock */
@@ -60,5 +62,9 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev, struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 8918b176fdcb..7022afc17d8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -305,6 +305,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
     mutex_init(&userq_mgr->userq_mutex);
     idr_init_base(&userq_mgr->userq_idr, 1);
     userq_mgr->adev = adev;
+    adev->userq_mgr = userq_mgr;
 
     amdgpu_userqueue_setup_ip_funcs(userq_mgr);
     return 0;
-- 
2.25.1

