Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB9AC25B4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 20:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA1D1131B7;
	Wed,  8 May 2024 20:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4+gTKzrc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B921011296B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 20:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLa+QYysJV/0qSBF+lGUJtl64GdxyBw54OjWnG1ufbuw6dxJGqi/vlRm173wAK4FUFFM0yso+tAwnbvravyw69Plyb8SKuHFkMXoGONmFZ/eF+pEus+3HT8z9Q1Jlv6rNP/jePI+tTRElyUsU7wVYzmEVK+wxr72YBIhPY9Qdsxnoaynjp0QCH9tnSF5bqr4+p6SGx+ewV3cmaW3i2X4LYyxxLcajjspygYJv4LsPxnUOOkkrmPkm3zwWjXDKiUoj952t6XVq5JIGhQs7Olj3CGfGh2qQvBwU7iXrmy6f2FB8GN748skSDNrzwjlakNVamuK0VJ2Tr1bj997rn+L5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/PF0h8MjNI2IMeqfVoJAp8jvPeFm4YqM3E4yyKesqc=;
 b=B8FpBTTZ+B4GxgZmGDFYz3/TGlDiOBAW0Io6y0/icOj5ToHlLswew4d31mYh3XM5U7Xkqcul2uLIrtLT1wufNCT2rfG9xyEOrIj//iAUuztIH40P3YeEXC1i9TliPgBkoeHnq4OKvS2uy/ylw5zX6VxCbhyzVGRxCIEPllDoryY6jSEIz+16u2s8sOCZJE0cz0gafnnb5dG9IFfCMHKfa3QkEn7LqlBFJ2GUPVhZE/Bfi77KB4o/rqvh2VpEkUqaIvVN73I3y5f1UJUCpFgUhiO9jmb+O6CeZiEPBxmQARJ9bH4u3XM+DATMeN5Zke9YcGx/A/7FhcLku6dRCAXEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/PF0h8MjNI2IMeqfVoJAp8jvPeFm4YqM3E4yyKesqc=;
 b=4+gTKzrcLwd/NWM9wiksd/moIxoohw9yx3Kvo90WQNqSonQNmtgc0jDs9WkvEaNeq5KVrO2GjCbyfxpufvKPsMqim7wS8TggHQvLLSneVR2XfL+Znzbj7RtXixgK8Q/6rAjGZ6iVhAKxUOdrRnQ6T3Sry7R6HTqyh7apcrW9Uj0=
Received: from DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 20:29:12 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::27) by DM6PR14CA0048.outlook.office365.com
 (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 20:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 20:29:11 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 15:29:10 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: suspend gfx userqueues
Date: Wed, 8 May 2024 22:28:36 +0200
Message-ID: <20240508202837.1411-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240508202837.1411-1-shashank.sharma@amd.com>
References: <20240508202837.1411-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 764064ba-8493-4dc9-db44-08dc6f9d858d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?txZYNAL6hLVQLvpQjcKaFV4x75X/sf2vbcOhGqvXnd69WiOhJ0KD+ozGHzyU?=
 =?us-ascii?Q?p35gUtUnwvPGiwdSkGlJzMmRK4z6iNCkCLpEXRYYG0SxbXcUmRaZrUSEU+km?=
 =?us-ascii?Q?JBtn9qz1ysoleJHoTZyeHmujmEkTAs6KIdQgDDxYQO9ms1Qfq34iYAVmgMg1?=
 =?us-ascii?Q?vATkPL2uXguR52HDLxekiK1F/AS+XZHSCrFGxrrMF9/gyAjEjWOXO0OQyJt/?=
 =?us-ascii?Q?zpQrYNzXbise8CbKBODbzUzwhCOVBAm0ShDtX7G0AVyc5GfE/wmP552PynBA?=
 =?us-ascii?Q?FfMColo51JwcUYUzL5W3AVokH/ZBj9clL35id6AVu2OPRin+LXIkX9FgDovt?=
 =?us-ascii?Q?oyyKncSPj2T7z3mAbOxAbVlYV9laAjG2a1xlsw9W133xQbjaCKhCFZ29JHFH?=
 =?us-ascii?Q?eQBjUDin9fSs52ehEUYGhDRwyLxbcIVuE9rsexs27zEBvSFoRpp2Kh4cvdSZ?=
 =?us-ascii?Q?W6PINI7x6Tqv97h/bSV5LXktgg/04LwAEf2pAZ2sOx4lpXoBWW3PNQkbzwKZ?=
 =?us-ascii?Q?SnxXitPHYvXfvi9OR4Q0zOQwSsJAEmcfzTlR1y5CA6XeD54am9H1H3A7ZYiF?=
 =?us-ascii?Q?mVT/e9OEh5ABtfRGWqVusdCsZSNLEmY9gFIHE3oHXqZvC/E0katt5dy2/HP5?=
 =?us-ascii?Q?8uWNuUpOsc6/KZzZApmAgoqKjYML9NLebRFHIIk2DwthZNtU0zKMy9cunahY?=
 =?us-ascii?Q?y6HSO/CCLC/E7hMAufzMfk2a0pELzMB4hHFK1kPtRnmgPXN0ZFWPZWvWvFty?=
 =?us-ascii?Q?0BsTRJ4Py2vYf1Ggf/f5ydc14q0BgPjx3Y106v25d6f25si86W74rrthkwEb?=
 =?us-ascii?Q?AJdY8SOl+uT6x4TNNNpCIKAbHHUliZFAwa/yX3vVX1c5RJk5BKT794jPrwS6?=
 =?us-ascii?Q?mGxc9nvEHPKUOYnJ7kpBXSN5NVXZSW979aGEChqK56uoR5hcgA8V3CCLUgpj?=
 =?us-ascii?Q?VAHuvMSlxvIsC3LG31BujsLMu9fqODHvB8qfMXUGjqrdVd/LB996cZjuvB3Q?=
 =?us-ascii?Q?Bgyuew1kmI4gEqYErcjX8vMhLzhCBufh3eYmsSJ//ndPYI4G9othyMNrxdcV?=
 =?us-ascii?Q?+eafeT4hp4CDF/gB3oA3Pvl837c7R8xrYtr2EKGhSCIWCiJkUgryvte+Xldu?=
 =?us-ascii?Q?UWSZrwV0QMAgGUxzJqqcC0wu5WcEDC0lbfZ7LGsD8U+7WbAYtK1sExrs8zqp?=
 =?us-ascii?Q?8qgCpUMzXrPF1cx41WdhZUAfstDHIBOnFRic8igIZ++ycbMdiLBLPfxhzTXa?=
 =?us-ascii?Q?ufjuuAsZNjF3HhU0rFoWIu6i8MXTFOEm/XvJ5e02lKfq6NEJMeEFJqdWUQcG?=
 =?us-ascii?Q?uejrOicGKbU+As9NleyU1KQeLj6d1Ka/wm2t9pol+vhbW5zN3cOZ8o2CRPA1?=
 =?us-ascii?Q?4sLrpI8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:29:11.9576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 764064ba-8493-4dc9-db44-08dc6f9d858d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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

This patch adds suspend support for gfx userqueues. It typically does
the following:
- adds an enable_signaling function for the eviction fence, so that it
  can trigger the userqueue suspend,
- adds a delayed function for suspending the userqueues, to suspend all
  the queues under this userq manager and signals the eviction fence,
- adds reference of userq manager in the eviction fence container so
  that it can be used in the suspend function.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 77 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  6 ++
 5 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a37193fc9ddc..1856fe11dd05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -469,6 +469,7 @@ struct amdgpu_eviction_fence {
 	struct dma_fence base;
 	spinlock_t	 lock;
 	char		 timeline_name[TASK_COMM_LEN];
+	struct amdgpu_userq_mgr *uq_mgr;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 1a03f040ccc8..3f806e44f614 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -39,10 +39,16 @@ amdgpu_ev_fence_get_timeline_name(struct dma_fence *f)
 	return ef->timeline_name;
 }
 
+static bool amdgpu_ev_fence_enable_signaling(struct dma_fence *f)
+{
+	return !amdgpu_userqueue_enable_signaling(f);
+}
+
 static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
 	.use_64bit_seqno = true,
 	.get_driver_name = amdgpu_ev_fence_get_driver_name,
 	.get_timeline_name = amdgpu_ev_fence_get_timeline_name,
+	.enable_signaling = amdgpu_ev_fence_enable_signaling,
 };
 
 struct amdgpu_eviction_fence *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index fa03d9e4874c..8c13de7f2a19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -111,6 +111,7 @@ struct amdgpu_bo {
 #endif
 	struct kgd_mem                  *kfd_bo;
 
+
 	/*
 	 * For GPUs with spatial partitioning, xcp partition number, -1 means
 	 * any partition. For other ASICs without spatial partition, always 0
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 7a89f378c97f..fdbd542e7f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -23,11 +23,16 @@
  */
 #include <linux/atomic.h>
 #include <drm/drm_syncobj.h>
+#include <drm/drm_exec.h>
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
 #include "amdgpu_userq_fence.h"
 
+#define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
+#define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
+
 static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
@@ -226,6 +231,7 @@ int amdgpu_userqueue_update_bo_mapping(struct drm_file *filp, struct amdgpu_bo *
 	}
 
 	drm_syncobj_add_point(syncobj, chain, bo_va->last_pt_update, (uint64_t)point);
+
 	return 0;
 }
 
@@ -392,12 +398,83 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static int
+amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id, ret;
+
+	userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
+
+	/* Suspend all the queues for this process */
+	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+		ret = userq_funcs->suspend(uq_mgr, queue);
+		if (ret)
+			DRM_ERROR("Failed to suspend queue\n");
+	}
+
+	return ret;
+}
+
+static void
+amdgpu_userqueue_suspend_worker(struct work_struct *work)
+{
+	int ret;
+	struct dma_fence *fence;
+	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, suspend_work.work);
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	ret = amdgpu_userqueue_suspend_all(uq_mgr);
+	if (ret) {
+		DRM_ERROR("Failed to evict userqueue\n");
+		goto unlock;
+	}
+
+	/* Signal current eviction fence */
+	fence = dma_fence_get(&fpriv->ev_fence->base);
+	ret = dma_fence_signal(fence);
+	dma_fence_put(fence);
+	if (ret) {
+		DRM_ERROR("Can't signal eviction fence to suspend");
+		return;
+	}
+
+unlock:
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
+int amdgpu_userqueue_enable_signaling(struct dma_fence *f)
+{
+	struct amdgpu_eviction_fence *ev_fence = to_ev_fence(f);
+	struct amdgpu_userq_mgr *uq_mgr = ev_fence->uq_mgr;
+
+	/* Schedule a suspend work in 1 ms */
+	schedule_delayed_work(&uq_mgr->suspend_work,
+			      msecs_to_jiffies(AMDGPU_USERQ_SUSPEND_TIME_MS));
+
+	return 0;
+}
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
+	struct amdgpu_fpriv *fpriv;
+
 	mutex_init(&userq_mgr->userq_mutex);
 	idr_init_base(&userq_mgr->userq_idr, 1);
 	userq_mgr->adev = adev;
 
+	fpriv = uq_mgr_to_fpriv(userq_mgr);
+	if (!fpriv->ev_fence) {
+		DRM_ERROR("Eviction fence not initialized yet\n");
+		return -EINVAL;
+	}
+
+	/* This reference is required for suspend work */
+	fpriv->ev_fence->uq_mgr = userq_mgr;
+	INIT_DELAYED_WORK(&userq_mgr->suspend_work, amdgpu_userqueue_suspend_worker);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index afaf93faa824..647e63bf03ab 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -26,6 +26,8 @@
 #define AMDGPU_USERQUEUE_H_
 
 #define AMDGPU_MAX_USERQ_COUNT 512
+#define AMDGPU_USERQ_SUSPEND_TIME_MS 1
+#define AMDGPU_USERQ_RESUME_TIME_MS 100
 
 struct amdgpu_mqd_prop;
 
@@ -69,6 +71,8 @@ struct amdgpu_userq_mgr {
 	struct idr			userq_idr;
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
+
+	struct delayed_work		suspend_work;
 };
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
@@ -86,4 +90,6 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 
 int amdgpu_userqueue_update_bo_mapping(struct drm_file *filp, struct amdgpu_bo *bo,
 				       uint32_t syncobj_handle, uint16_t point);
+
+int amdgpu_userqueue_enable_signaling(struct dma_fence *f);
 #endif
-- 
2.43.2

