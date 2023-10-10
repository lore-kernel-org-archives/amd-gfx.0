Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E295CD691F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F7B10E33A;
	Tue, 10 Oct 2023 10:18:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB67410E337
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geM2i7IoMryiu60OGY/v+V6Kr9ffV+aFzE+EMyJjpDrtIecuREhyo/PtBlNfx/kapWGJy4x6wZyOm6s2agdT4PX+hrfr10uVI1g0CKWTSBAlUoqnSwfANROpQbSWI3DFIJoOSU/mWfCO37PsltjiNAGr+yV9IBH3S+xvj2nRaI31ZDhI0B0lPJJAUq38CB+vQVKP2BuucuTE8UHn3gJaYTFUPwkLGbJiR4zMzl09slH3rvLgL+b46P+Xv7uLWU8PFDjMD3I1/Y7GmSTet3AwIRB0o/uCII/FJMLnbDQqsIu4hWqbxqNVMisApfNu91zSWYD52KAlMu23KDvBfKmi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5M4ZZWB3QmgyND8g38zaJl9BJUaC49aa8K18+xhCvx4=;
 b=L+DZLVHqgk5lWuHVHVpUQpyI/2J1XiI7a7dB3YYBkYCg4BTDQbtei/PUw/DGz/00OnJMDtJlaRrRY4GEJTokx8DZJrQwLyfJlwvISpZ3BdE1vSYg0WV7l6Nw8z50KbbIp7mkZ/olg8waQq6Xu13SilojlgnnJwROP5ZJU2nIfUrZ+uNU7n+tfiCRYi6JHzOF4IxgDRTBe8ZyKuABsNGwxWMiQllYsxV8u8CZt5+d/QrLv4iDYowEBJOl9CdFL7mulspez2jTw4KtDnBmI1qBeutuTvw+N6m1SHIWSpY5WIIekICQZa6yZGbcrHBEOU2dDI5814xCImTc7q/8bMIBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5M4ZZWB3QmgyND8g38zaJl9BJUaC49aa8K18+xhCvx4=;
 b=IajY54VHtacZpZ3T6LCLdR8B9H4aq47XYgTRESPYrU1fYrDTuPXfg8dMgQoHogx06Icy47o3HNrRu6o/E5YcUCdOfT7M9ViMG+G1FseNk2bjIUEQSkLSBpr3HJbUfFgpCzN+p1/VbgZaTO1m3ct6IvWW68nDmbmgkhos+KEji1g=
Received: from PH0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::18)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:18:49 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::18) by PH0P220CA0025.outlook.office365.com
 (2603:10b6:510:d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:48 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:46 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 11/12] drm/amdgpu: introduce userqueue eviction fence
Date: Tue, 10 Oct 2023 12:17:51 +0200
Message-ID: <20231010101752.1843-12-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20231010101752.1843-1-shashank.sharma@amd.com>
References: <20231010101752.1843-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH0PR12MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: 35479566-7f34-427d-99e7-08dbc97a4b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+YOlXovquoKNRMG18bih6UhlSY9f40w4IFtVjoX9NpUuegRwtGB40DbghONW5muuva8Fd12+Qufm92uHSHsYHu+W0+oeX/VJo9Oj95rMKVhvQlQ5fsBzhvOUKhe8KX+V3cTzhbAzzBPym6N3fE+nHqo1VMaPkBe11C6FRZzaX5vnmNwaSojs5movil24KKlOmWZNDAF5PXEdZhRmMoNFJpRqZi07odS9cnZ9EJwU5/GBT2nlvCgRgu79n8MQ+eEbVbGm7EXk6ahkxyvyHN0EcRQglvBRDPAv4ZmwI6M+iOZ9SBizAHliXyhS6242Z31661ZlfS/mV7Gp1d6mDxu3WkRAcKaxr+wrk6MbPrMPieG1sEm+69yI72afIjrT23XFFDHM5ttMxn+qH3W8mgGJDCaZDiAv+RRPA5axkQdod2zWYfkzPMAuPl90keoE9QqKYdUh+XNH/PvT9SVPLhEytdfNNvS/pPiO+SO7h92GnwlouqsqyItgJ2WbC7gt4U7T1egXwueFPuRx2gX3jK3eOouiop1q8dzAy+kPtpjdsG4Y9YElF/IZmk84rIe6vvhgtXt8v5Y14mqTHFKwk/QT06QHLZdkGrojXqGwWVPmWlmi+uXBkE1Kzt3LNBn1RyZQbzyQbu+QK/iuTNpsCQCXiV6DVkJDFYDgh6zdjy1nrIAbTmyczzxoKMz9z3KPTt/cHi+I1KddjPlonhtBJutkh9hxp50eJIf4Ub80kfqb6DZ4iDn+v1djDKQzDBk7gi0WkSAbWBeqNXe8GYgYO254w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(356005)(86362001)(36756003)(81166007)(66899024)(40480700001)(82740400003)(478600001)(2906002)(8936002)(44832011)(8676002)(7696005)(41300700001)(5660300002)(6666004)(4326008)(2616005)(1076003)(336012)(83380400001)(426003)(40460700003)(6916009)(70586007)(54906003)(70206006)(316002)(16526019)(36860700001)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:48.7691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35479566-7f34-427d-99e7-08dbc97a4b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds support for userqueue eviction fences. In general, when
a process wants to map VRAM memory but TTM can't find enough space, it
attempts to evict BOs from its LRU list. This fence will prevent the TTM
manager from evicting the process's BOs from VRAM.

The general idea behind this is:
- Eviction fence is initialized during the uq_mgr init and saved in
  fpriv->uq_mgr.
- This fence is attached to every userqueue object (MQD, ctx, doorbell
  and wptr) in a shared way, during the queue creation.
- The fence is signaled during the queue destruction.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 82 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  7 ++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 15 ++++
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 6bae014b248e..26cdd54acd74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -21,7 +21,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-
+#include <linux/atomic.h>
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
@@ -45,6 +45,66 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 	return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static const char *
+amdgpu_userqueue_fence_get_driver_name(struct dma_fence *fence)
+{
+	return "amdgpu";
+}
+
+static const char *
+amdgpu_userqueue_fence_get_timeline_name(struct dma_fence *f)
+{
+	struct amdgpu_userq_fence *ef = container_of(f, struct amdgpu_userq_fence, base);
+
+	return ef->timeline_name;
+}
+
+static const struct dma_fence_ops amdgpu_userqueue_eviction_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_userqueue_fence_get_driver_name,
+	.get_timeline_name = amdgpu_userqueue_fence_get_timeline_name,
+};
+
+static void
+amdgpu_userqueue_init_eviction_fence(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_userq_fence *fence = &uq_mgr->eviction_fence;
+	atomic_t seq = ATOMIC_INIT(0);
+
+	spin_lock_init(&fence->lock);
+	fence->fence_ctx = dma_fence_context_alloc(1);
+	fence->seq = seq;
+	get_task_comm(fence->timeline_name, current);
+	dma_fence_init(&fence->base, &amdgpu_userqueue_eviction_fence_ops,
+			&fence->lock, fence->fence_ctx,
+			atomic_inc_return(&fence->seq));
+}
+
+struct dma_fence *
+amdgpu_userqueue_attach_eviction_fence(struct amdgpu_userq_mgr *uq_mgr,
+				       struct amdgpu_bo *bo)
+{
+	struct dma_fence *ef = &uq_mgr->eviction_fence.base;
+	struct dma_resv *resv = bo->tbo.base.resv;
+	int ret;
+
+	ret = dma_resv_reserve_fences(resv, 1);
+	if (ret) {
+		dma_fence_wait(ef, false);
+		return NULL;
+	}
+
+	dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_READ);
+	return dma_fence_get(ef);
+}
+
+void
+amdgpu_userqueue_signal_eviction_fence(struct dma_fence *ef)
+{
+	dma_fence_signal(ef);
+	dma_fence_put(ef);
+}
+
 int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
 				   struct amdgpu_userq_obj *userq_obj,
 				   int size)
@@ -88,6 +148,13 @@ int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	userq_obj->gpu_addr = amdgpu_bo_gpu_offset(userq_obj->obj);
+	userq_obj->ev_fence = amdgpu_userqueue_attach_eviction_fence(uq_mgr, userq_obj->obj);
+	if (!userq_obj->ev_fence) {
+		DRM_ERROR("Failed to attach eviction fence to FW object\n");
+		r = -EFAULT;
+		goto unresv;
+	}
+
 	amdgpu_bo_unreserve(userq_obj->obj);
 	memset(userq_obj->cpu_ptr, 0, size);
 	return 0;
@@ -103,6 +170,7 @@ int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				   struct amdgpu_userq_obj *userq_obj)
 {
+	amdgpu_userqueue_signal_eviction_fence(userq_obj->ev_fence);
 	amdgpu_bo_kunmap(userq_obj->obj);
 	amdgpu_bo_unref(&userq_obj->obj);
 }
@@ -140,11 +208,21 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 		goto unpin_bo;
 	}
 
+	db_obj->ev_fence = amdgpu_userqueue_attach_eviction_fence(uq_mgr, db_obj->obj);
+	if (!db_obj->ev_fence) {
+		DRM_ERROR("[Usermode queues] Failed to attach eviction fence with db_bo\n");
+		r = -EFAULT;
+		goto unres_bo;
+	}
+
 	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj, doorbell_offset);
 	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
 	amdgpu_bo_unreserve(db_obj->obj);
 	return index;
 
+unres_bo:
+	amdgpu_bo_unreserve(db_obj->obj);
+
 unpin_bo:
 	amdgpu_bo_unpin(db_obj->obj);
 
@@ -171,6 +249,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
+	amdgpu_userqueue_signal_eviction_fence(queue->db_obj.ev_fence);
 	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
@@ -278,6 +357,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 	idr_init_base(&userq_mgr->userq_idr, 1);
 	userq_mgr->adev = adev;
 
+	amdgpu_userqueue_init_eviction_fence(userq_mgr);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 33de65a0d974..e68320b4c689 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6469,6 +6469,12 @@ gfx_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
 		return ret;
 	}
 
+	wptr_obj->ev_fence = amdgpu_userqueue_attach_eviction_fence(uq_mgr, wptr_obj->obj);
+	if (!wptr_obj->ev_fence) {
+		DRM_ERROR("Failed to attach eviction fence to wptr bo\n");
+		return -EFAULT;
+	}
+
 	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
 	return 0;
 }
@@ -6650,6 +6656,7 @@ static void
 gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
 	gfx_v11_0_userq_unmap(uq_mgr, queue);
+	amdgpu_userqueue_signal_eviction_fence(queue->wptr_obj.ev_fence);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 }
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index a653e31350c5..f1e3d311ae18 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -33,6 +33,7 @@ struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
 	uint64_t	 gpu_addr;
 	struct amdgpu_bo *obj;
+	struct dma_fence *ev_fence;
 };
 
 struct amdgpu_usermode_queue {
@@ -57,11 +58,20 @@ struct amdgpu_userq_funcs {
 			    struct amdgpu_usermode_queue *uq);
 };
 
+struct amdgpu_userq_fence {
+	u64		 fence_ctx;
+	atomic_t	 seq;
+	spinlock_t	 lock;
+	struct dma_fence base;
+	char		 timeline_name[TASK_COMM_LEN];
+};
+
 /* Usermode queues for gfx */
 struct amdgpu_userq_mgr {
 	struct idr			userq_idr;
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
+	struct amdgpu_userq_fence	eviction_fence;
 };
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
@@ -76,4 +86,9 @@ int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
 
 void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				     struct amdgpu_userq_obj *userq_obj);
+
+struct dma_fence *amdgpu_userqueue_attach_eviction_fence(struct amdgpu_userq_mgr *uq_mgr,
+							 struct amdgpu_bo *bo);
+
+void amdgpu_userqueue_signal_eviction_fence(struct dma_fence *ef);
 #endif
-- 
2.42.0

