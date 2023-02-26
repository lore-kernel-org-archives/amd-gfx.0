Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C66C64ED6
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Feb 2023 16:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD1610E13D;
	Sun, 26 Feb 2023 16:55:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BABA910E13D
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Feb 2023 16:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBTEC8/5yUGHU7h9fUKGHLgclqIJjwD1M1wF8sEhEpyMTrfg2imSkTsJaVcdasSCARYJOH/dIQKCI0AbxXVqWGvqCtXL1Be/20okl62ToexeGyjfPAVJIXfit05gi8Qos+njaKN9qPPrgGWtVqhx0O8JzoCd1mU7XdUQoI76SPASeQ4N6+Uuh104e+O/6PJMnLLLs3orFtM2XqZv/GE0Ok6mqz+vpqr91H3eH5YrH0B9OCR5xHUWcuV3psUvdXxn+764DN8FcbyuiGUVFs150/WuPKzVqlB+rMAfzOb3KM/1WyegnqCmte52UYtNihvnA6ue9SYhvbLbLlQrLzrDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdQktWllSN9lrTIFAw5vg/IY/Z0yWQOpA/ArlFfmaNs=;
 b=ALD6rxivT9g4InU4CGYXEiRTN3xePKjK4y0AKnArYaLFglo+7zU89j/JL4hS33KGtqF5weONGSl87anlY0vpPihypC5AYtIWdcKNviHi/mZIw+vnYw/ksdKvkTZ3fpjwwQYBd63RI1IwJl7/8SSdhLA2wpFWJUCmk4kEkHbzAVHqxgA3R5N6BuIDkxZc0kvvdpfTG5MJKQnUeXbUt7pZAI9btSl1oy/JyYoOOO7Vui2EkE/0Wz+lkg8khQzSY8CDBSo0Ppz5KLSC/k1gHvuBZ6ApzJ7R8y5VIcThg3XTVGYrCn0cdD7o/fpBEdeNYjd6KX/RXwF1xu91MQUscUGlEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdQktWllSN9lrTIFAw5vg/IY/Z0yWQOpA/ArlFfmaNs=;
 b=0T9zS33Pylg9Ghd/p2M+B/1Otb6xSAb/oA7z1SQESSQ4y0CXxHh+tAoGeJN0pLKV6lS/pTcIrkIyiMZFb7jqjfVlNaBxNiIteR3TbTEXtkqQfKEBtj/2482FhfGuCkJL0HpX0LPVREJDHO3R5CusfoPH1i63dem/qxQ4Ynv3ipE=
Received: from BN8PR15CA0019.namprd15.prod.outlook.com (2603:10b6:408:c0::32)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 16:55:21 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::4b) by BN8PR15CA0019.outlook.office365.com
 (2603:10b6:408:c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27 via Frontend
 Transport; Sun, 26 Feb 2023 16:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.15 via Frontend Transport; Sun, 26 Feb 2023 16:55:20 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 26 Feb 2023 10:55:17 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
 functions
Date: Sun, 26 Feb 2023 08:54:34 -0800
Message-ID: <20230226165435.41641-6-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d1f39c-07ed-461b-60a8-08db181a3e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKFupW0B7wDsAfzfu/ta9U/OezndUwUhltb21oiYOQ2HBNT1sFUBR9Xyz4Jx5sYCeRHbc12raLXzgbluO8GvxbblVfuqnjrkknZ9NmwLfV+bIte4zO4vKnFHA7X/gxRzaA+9CMGAh0YEgfhLStBTsA2eyD1z1HjhxDosU1hDhMDxYnOTrtdSh2Mqrp9Nr8bcPFNa8vM+s3T4w8hhAl5tLFsFk9AtbjqcFQpLecKb/sVs7LDZF5ZWb0CGnNlUmvDsSPXGTpe50h8NcWFK6YHLeBQXL0ZCi2M+d8qcHNnzmyFKXMcsmd3YBPgAc+QEm3ZItZmypgyWnKVJ0kZaucvmNZH7qYNvdPohsOVLolTy91xoSJs13fJrkQ487b83zi8k1KTjCPcLPd0bLBqM8UDzOfhaxk27LO3qansHEJIHTqBYGytBDYRkm6O00wIHSeICaaHs4txF0k9xOLACZiMy2f5WvcCwzZLflwUo3DKJOsjImR+F1/tYKtZDaXQYB5exGck0cY2UBuufFk98tuVN11LmWXdZXoIKxJqc8y3i/5IGdCV6UUnZTVAHbsohx5/uLmOx+uaMMmtpCT5MLjPSvH4Aw0V2fx5e6yt/cHfk026F/jBcR/jW9vBoaPo2VtC7BSR8S9Eo1dMP460vsryy+mW8L8IlweBmkwUAlA5CiptM12KZGmBjh4MkVDzqH/B9D1sHU40P3kUDYWdBATAITcymmNHGOQcl/I9sFwlgJlc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(6666004)(1076003)(2616005)(336012)(186003)(26005)(16526019)(70586007)(316002)(41300700001)(54906003)(4326008)(6916009)(70206006)(7696005)(2906002)(30864003)(8936002)(81166007)(82740400003)(36860700001)(86362001)(82310400005)(478600001)(40480700001)(356005)(5660300002)(426003)(47076005)(83380400001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 16:55:20.0585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d1f39c-07ed-461b-60a8-08db181a3e92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   3 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 258 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   1 +
 5 files changed, 270 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1c3eba2d0390..255d73795493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -964,6 +964,8 @@ struct amdgpu_device {
 	struct amdgpu_mes               mes;
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 
+	struct amdgpu_userq_mgr         *userq_mgr;
+
 	/* df */
 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6b7ac1ebd04c..66a7304fabe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2752,6 +2752,9 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_DOORBELL_RING, amdgpu_userq_doorbell_ring_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 609a7328e9a6..26fd1d4f758a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -249,3 +249,261 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
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
+	u64 *ptr;
+	int r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, queue->wptr_gpu_addr >> PAGE_SHIFT);
+	if (!mapping)
+		return -EINVAL;
+
+	bo = mapping->bo_va->base.bo;
+	r = amdgpu_bo_kmap(bo, (void **)&ptr);
+	if (r) {
+		DRM_ERROR("Failed mapping the userqueue wptr bo");
+		return r;
+	}
+
+	*wptr = le64_to_cpu(*ptr);
+
+	return 0;
+}
+
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct drm_amdgpu_userq_signal *args = data;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_userq_mgr *userq_mgr = adev->userq_mgr;
+	struct amdgpu_usermode_queue *queue;
+	struct drm_syncobj *syncobj = NULL;
+	struct drm_gem_object **gobj;
+	u64 num_bo_handles, wptr;
+	struct dma_fence *fence;
+	u32 *bo_handles;
+	bool shared;
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
+	syncobj = drm_syncobj_find(filp, args->handle);
+
+	/* Array of bo handles */
+	num_bo_handles = args->num_bo_handles;
+	bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), GFP_KERNEL);
+	if (bo_handles == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(bo_handles, u64_to_user_ptr(args->bo_handles_array),
+			   sizeof(u32) * num_bo_handles)) {
+		r = -EFAULT;
+		goto err_free_handles;
+	}
+
+	/* Array of GEM object handles */
+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (gobj == NULL) {
+		r = -ENOMEM;
+		goto err_free_handles;
+	}
+
+	for (i = 0; i < num_bo_handles; i++) {
+		/* Retrieve GEM object */
+		gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
+		if (!gobj[i]) {
+			r = -ENOENT;
+			goto err_put_gobj;
+		}
+
+		dma_resv_lock(gobj[i]->resv, NULL);
+		r = dma_resv_reserve_fences(gobj[i]->resv, 1);
+		if (r) {
+			dma_resv_unlock(gobj[i]->resv);
+			goto err_put_gobj;
+		}
+		dma_resv_unlock(gobj[i]->resv);
+	}
+
+	/* Create a new fence */
+	r = amdgpu_userq_fence_create(queue, wptr, &fence);
+	if (!fence)
+		goto err_put_gobj;
+
+	/* Add the created fence to syncobj/BO's */
+	if (syncobj)
+		drm_syncobj_replace_fence(syncobj, fence);
+
+	shared = args->bo_flags & AMDGPU_USERQ_BO_READ;
+	for (i = 0; i < num_bo_handles; i++) {
+		dma_resv_lock(gobj[i]->resv, NULL);
+		dma_resv_add_fence(gobj[i]->resv, fence, shared ?
+				   DMA_RESV_USAGE_READ :
+				   DMA_RESV_USAGE_WRITE);
+		dma_resv_unlock(gobj[i]->resv);
+	}
+
+	for (i = 0; i < num_bo_handles; i++)
+		drm_gem_object_put(gobj[i]);
+
+	dma_fence_put(fence);
+
+	/* Free all handles */
+	kfree(bo_handles);
+	kfree(gobj);
+
+	return 0;
+
+err_put_gobj:
+	while (i-- > 0)
+		drm_gem_object_put(gobj[i]);
+	kfree(gobj);
+err_free_handles:
+	kfree(bo_handles);
+
+	return r;
+}
+
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
+	struct drm_amdgpu_userq_wait *args = data;
+	struct amdgpu_userq_fence *userq_fence;
+	u32 *syncobj_handles, *bo_handles;
+	u64 num_syncobj, num_bo_handles;
+	struct drm_gem_object **gobj;
+	struct dma_fence *fence;
+	bool wait_flag;
+	int r, i, tmp;
+
+	/* Array of Syncobj handles */
+	num_syncobj = args->count_handles;
+	syncobj_handles = kmalloc_array(num_syncobj, sizeof(*syncobj_handles), GFP_KERNEL);
+	if (!syncobj_handles)
+		return -ENOMEM;
+
+	if (copy_from_user(syncobj_handles, u64_to_user_ptr(args->handles),
+			   sizeof(u32) * num_syncobj)) {
+		r = -EFAULT;
+		goto err_free_syncobj_handles;
+	}
+
+	/* Array of bo handles */
+	num_bo_handles = args->num_bo_handles;
+	bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), GFP_KERNEL);
+	if (!bo_handles)
+		goto err_free_syncobj_handles;
+
+	if (copy_from_user(bo_handles, u64_to_user_ptr(args->bo_handles_array),
+			   sizeof(u32) * num_bo_handles)) {
+		r = -EFAULT;
+		goto err_free_bo_handles;
+	}
+
+	/* Array of fence gpu address */
+	fence_info = kmalloc_array(num_syncobj + num_bo_handles, sizeof(*fence_info), GFP_KERNEL);
+	if (!fence_info) {
+		r = -ENOMEM;
+		goto err_free_bo_handles;
+	}
+
+	/* Retrieve syncobj's fence */
+	for (i = 0; i < num_syncobj; i++) {
+		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0, 0, &fence);
+		if (r) {
+			DRM_ERROR("syncobj %u failed to find the fence!\n", syncobj_handles[i]);
+			r = -ENOENT;
+			goto err_free_fence_info;
+		}
+
+		/* Store drm syncobj's gpu va address and value */
+		userq_fence = to_amdgpu_userq_fence(fence);
+		fence_info[i].va = userq_fence->fence_drv->gpu_addr;
+		fence_info[i].value = fence->seqno;
+		dma_fence_put(fence);
+	}
+
+	tmp = i;
+
+	/* Array of GEM object handles */
+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (gobj == NULL) {
+		r = -ENOMEM;
+		goto err_free_fence_info;
+	}
+
+	/* Retrieve GEM objects's fence */
+	wait_flag = args->bo_wait_flags & AMDGPU_USERQ_BO_READ;
+	for (i = 0; i < num_bo_handles; i++, tmp++) {
+		struct dma_fence *bo_fence;
+
+		gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
+		if (!gobj[i]) {
+			r = -ENOENT;
+			goto err_put_gobj;
+		}
+
+		dma_resv_lock(gobj[i]->resv, NULL);
+		r = dma_resv_get_singleton(gobj[i]->resv,
+					   wait_flag ?
+					   DMA_RESV_USAGE_READ :
+					   DMA_RESV_USAGE_WRITE,
+					   &bo_fence);
+		if (r) {
+			dma_resv_unlock(gobj[i]->resv);
+			goto err_put_gobj;
+		}
+		dma_resv_unlock(gobj[i]->resv);
+		drm_gem_object_put(gobj[i]);
+
+		/* Store GEM objects's gpu va address and value */
+		userq_fence = to_amdgpu_userq_fence(bo_fence);
+		fence_info[tmp].va = userq_fence->fence_drv->gpu_addr;
+		fence_info[tmp].value = bo_fence->seqno;
+		dma_fence_put(bo_fence);
+	}
+
+	if (copy_to_user(u64_to_user_ptr(args->userq_fence_info),
+	    fence_info, sizeof(fence_info))) {
+		r = -EFAULT;
+		goto err_free_gobj;
+	}
+
+	/* Free all handles */
+	kfree(syncobj_handles);
+	kfree(bo_handles);
+	kfree(fence_info);
+	kfree(gobj);
+
+	return 0;
+
+err_put_gobj:
+	while (i-- > 0)
+		drm_gem_object_put(gobj[i]);
+err_free_gobj:
+	kfree(gobj);
+err_free_fence_info:
+	kfree(fence_info);
+err_free_bo_handles:
+	kfree(bo_handles);
+err_free_syncobj_handles:
+	kfree(syncobj_handles);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 230dd54b4cd3..999d1e2baff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -27,6 +27,8 @@
 
 #include <linux/types.h>
 
+#define AMDGPU_USERQ_BO_READ	0x1
+
 struct amdgpu_userq_fence {
 	struct dma_fence base;
 	/* userq fence lock */
@@ -57,5 +59,9 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 			      u64 seq, struct dma_fence **f);
 bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index d4317b0f6487..4d3d6777a178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -457,6 +457,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
     idr_init_base(&userq_mgr->userq_idr, 1);
     INIT_LIST_HEAD(&userq_mgr->userq_list);
     userq_mgr->adev = adev;
+    adev->userq_mgr = userq_mgr;
 
     r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
     if (r) {
-- 
2.25.1

