Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319C5C88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 05:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62B310E30D;
	Wed, 16 Sep 2026 05:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NAUyBvhT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C7D10E30D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 05:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbA13egw9595DB7lawKestQje/UsLsd4P5uIl4hSxS2geNvwpkSP5JJDNvRWWikNeqzXfdXhKI3mlL/lntL6QVUtRfKIh//s1NMavHMtUMi0pv6prtC/1MmqMrrLJSUZUL2+sLeOSrSd4datIcEY7HR7UH5srXMlrFrF8Mhr73u02MKvmowW2q+8luIf6jGyu254MzAcUNuukYRjDVGnJxA4RCj+B7L8RE6gYdf4IXAHhsdV2VofGkpxwo3UdVXVjZdBHFngo9KaNHpk1uGdRtGymnz7G51RyITcih3PzeRMRSUrVgUOUWHCF1LPLo3IZMewFUEhk3NMye9/WCdpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I2//cqyr6P5thp2/qjuz/fuMWSU1Uh/f5wif0V25OU=;
 b=aoZRjNRtWRf573MSRv3SXpja3zBm+0Gm1IxCXqgjgoY58IRpXfJNf6zuF0CLq9wPxjqGp6IhWSPuWRUCLfR2W0mZuF10J/FpbHbQA9P7x1DrJ5/RxPKxVEtOh9nk9eSZFEpItW637u2RL0ylGPMdxlKui+TP1LytDZtfB35eBGYL3GOED9z3MBvuQ2MYbqJ99+SwIjilokvcYPxlW+vh69dJ9Kj4TimN8Ns6zfchHOqNFhSAlnt90PxeryxmTL8fj0MUXK8BCdYMPRD43c1B2DqAgKVuVzokN0SB5U1MC6AFHjV5vGhGkZLtPNs45SEXIjo6Bu1nUmyQkQ5Lol5DOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I2//cqyr6P5thp2/qjuz/fuMWSU1Uh/f5wif0V25OU=;
 b=NAUyBvhTfQx7PQbo8fWgDt4abwzIt9CRoeFUj8u9gS+SmYS2s3DdIOAKXuiV6qFmb1IWuQQQwxN/8GmuN+Ft/zw8r473vgX9DYvM1C0US2gHWNdism2ZOEJ6KrPociHH3ulSymu8h+3f8F3FtG8HcONhc+Crfx5r7JmZJx8xVwU=
Received: from PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::10)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 05:37:42 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:510:348:cafe::a3) by PH8P220CA0032.outlook.office365.com
 (2603:10b6:510:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 05:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:37:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 00:37:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 "Lijo Lazar" <lijo.lazar@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add second-level trap handler infrastructure
Date: Wed, 16 Sep 2026 11:07:19 +0530
Message-ID: <20260916053722.601067-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee9d766-5f58-4a6c-df91-08df13b4a09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZsNAsA9asZtijQBTdNheIfM+UTYOHyXWjvueVVweuhR0K2zAwnNctHCjhMunNryHxCrdXLvW+ySyvO6broRK+Lqr0WwBeTxgnU60XxXICzXgj09SC+4rr3Gj9Y2w1apUWNvfYeE5GeXZnIvpJzHfbRb5qUCpiE6apDFC+yaMLmI/hihCbIT3eWhX10JQPKN2GRkCjCemY0A3qGgiG9UziCwpOEz3tLu0vbQONP8tcYy+YtddkzUChMf/DC3C1T3ncqRpMdvzJLrp83UcCkfXfxA2vrmJN1fFUT7CNB3gBzEcHxEgqop6vz6mToFJuZKiXSQA+Dx095kAdAb4YQwWUJf8qMDcAzVPhjhhfyN6E4XvEZYsjPqE9GNZmaObedRxZAvbSPqefYtOWZNosnhBQri1N+FFNkhvNFKMqsxQeTUTLg30zHw8T7ovxvOxLrRP5ht6628y83CSO4W7SwpRmekq4nXDVMErrItvI69a7IT6v/M0XLcX1cydnUTeWxEV+yY69XW1lZev1GgxsP7pci0Wi9YrQ+yENVqShjduOzD9VpAY+Vlf9cdGvs2h1j2Fe1wDHM3Cb93fhS0/1Wii9H7SwM72nS6ecR/PXrbI5lqSriANFJ/M4U4lHTQHvlbenAqWgtJW+j5XmKWYtANYHQ3+DXBgGJl+xUo8MlwMNrRCAkQQV8UXGjkJD9E6k1vF4l0grFceO7SHbkzqnRNauw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YrYEWXVK78JBFBr458fjUc7Dl7WgfxYgkRbidQAUanEKYQwLW3as065lI1DaDTZCdj+8w4Pz2uFjsHcsaBeGWjSLdQMr+fUhnRET4gTTFArtQYLudyQNznm2R0QVm/FOYrXMlDLxndk1mZodM1Owo99mrb4gBd4DbwSvkeo8LyOaIDse5zmS5LsBp6kCGuYj4MQkV0ezR3IW6FwQ9r4YOw/ZWDscIx4L6C8KB7s7FPVPmv0v/3abJoW0Def8wPeSBVubs1DG2aqQp8WoxOaCv6VYJqGIb3Z2LrDQzcH2p2GADJPmJBTJzvRs2yCKVnMkHDsOPL1KrWuRNLLG79wKJpJKl3jLugrzD6vgw+lGsg4wLlN7N2DW+0HLqVUYaQ5lv6rpXMCXXkzFUuV2WDSfrP//x7IO3YZ6jWopH8S01d8VYP8pQgCbnk0URMIqvH59
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:37:41.8512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee9d766-5f58-4a6c-df91-08df13b4a09f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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

Render-node user queues had no mechanism to install a userspace
second-level trap handler equivalent to what KFD provides for compute.

On dGPUs the CWSR TMA buffer is placed in VRAM and accessed via MMIO
(PCI BAR). Raw CPU pointer dereferences are unsafe on platforms that
lack full load/store support for MMIO. Replace void *tma_cpu_addr with
struct iosys_map tma_map and use iosys_map_wr() for all TMA writes.

Writing TBA and TMA as two separate stores creates a race where a
trapping wave can observe a mismatched pair. For user queues, evict all
queues and flush the GPU TLB before writing, then restore queues after.
For kernel queues, wait for the VM to be idle via amdgpu_vm_wait_idle()
before eviction and the descriptor write.

Evict user queues in amdgpu_trap_free() at file close. Without eviction
a freed TMA BO can be accessed via a stale TBA, causing a GPU page
fault.

Export amdgpu_userq_restore_all() for immediate queue restore after
SET/CLEAR without waiting for the eviction fence.

Add VM_ALWAYS_VALID validation in amdgpu_trap_validate_user_addr().
SET_L2_TRAP returns -EINVAL if TBA or TMA BO does not have this flag.

The old TRAP ioctl and its internal handler are removed. The new
SET/CLEAR path is exposed via the VM ioctl in a later patch.

SET_L2_TRAP is per-VM (per-process). Each process has its own TMA buffer
allocated in amdgpu_trap_alloc(). There is no conflict between processes
on user queue VMIDs.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c  | 284 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h  |  64 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
 include/uapi/drm/amdgpu_drm.h             |   2 -
 7 files changed, 285 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a93ee106ab92..6473faf18d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3079,7 +3079,6 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
 	/* KMS */
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 47e4680db797..559c9222fc48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
-	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
+	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 31f653ec3fb1..3313bc099cf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -19,12 +19,23 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
+#include <linux/iosys-map.h>
+#include <drm/ttm/ttm_bo.h>
+
 #include <drm/drm_exec.h>
 
 #include "amdgpu.h"
+#include "amdgpu_gmc.h"
+#include "amdgpu_userq.h"
+#include "amdgpu_vm.h"
 #include "cwsr_trap_handler.h"
 #include "amdgpu_trap.h"
 
+/* First-level TMA layout shared with second-level trap handler ABI */
+#define AMDGPU_TRAP_L2_TBA_INDEX	0
+#define AMDGPU_TRAP_L2_TMA_INDEX	1
+#define AMDGPU_TRAP_DEBUG_FLAG_INDEX	2
+
 extern int cwsr_enable;
 
 #define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
@@ -380,6 +391,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_trap_obj *cwsr;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
+	void *cpu_addr;
 	int r;
 
 	if (!amdgpu_trap_is_enabled(adev))
@@ -407,10 +419,21 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
-				    &cwsr->tma_cpu_addr);
+				    &cpu_addr);
 	if (r)
 		goto err;
 
+	/*
+	 * Build an iosys_map for the TMA CPU mapping. On dGPUs the TMA BO
+	 * may be placed in VRAM and accessed via MMIO (PCI BAR). Check
+	 * TTM_BO_MAP_IOMEM_MASK to select the correct write accessor.
+	 */
+	if (cwsr->tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
+		iosys_map_set_vaddr_iomem(&cwsr->tma_map,
+					  (void __iomem *)cpu_addr);
+	else
+		iosys_map_set_vaddr(&cwsr->tma_map, cpu_addr);
+
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
 	if (r)
 		goto err;
@@ -433,6 +456,29 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
+void amdgpu_trap_clear_l2_handler(struct amdgpu_vm *vm,
+				  struct amdgpu_trap_obj *trap_obj)
+{
+	if (!trap_obj || iosys_map_is_null(&trap_obj->tma_map))
+		return;
+
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	/*
+	 * Zero TBA first to disable dispatch before clearing TMA.
+	 */
+	iosys_map_wr(&trap_obj->tma_map,
+		     AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, 0);
+	dma_wmb();
+	iosys_map_wr(&trap_obj->tma_map,
+		     AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64), u64, 0);
+
+	trap_obj->l2_tba_addr = 0;
+	trap_obj->l2_tba_size = 0;
+	trap_obj->l2_tma_addr = 0;
+	trap_obj->l2_tma_size = 0;
+}
+
 int amdgpu_trap_validate_params(struct amdgpu_device *adev,
 				struct amdgpu_trap_params *trap_params,
 				int num_xcc)
@@ -464,6 +510,7 @@ int amdgpu_trap_validate_params(struct amdgpu_device *adev,
 }
 
 void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_trap_obj **trap_obj)
 {
 	struct amdgpu_bo *tba_bo;
@@ -473,32 +520,41 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
 		return;
+
+	/*
+	 * Evict all user queues before freeing. At file-close time waves
+	 * may still be active; without eviction a wave can trap into the
+	 * handler after the TMA BO is freed, causing a GPU page fault.
+	 */
+	if (uq_mgr)
+		amdgpu_userq_evict(uq_mgr);
+
 	tba_bo = adev->trap_info->isa_bo;
 	tma_bo = (*trap_obj)->tma_bo;
 
 	if (!tba_bo || !tma_bo)
 		return;
 
-	drm_exec_init(&exec, 0, 0);
-	drm_exec_until_all_locked(&exec)
-	{
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
-		if (likely(!r))
-			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
-		drm_exec_retry_on_contention(&exec);
 		if (likely(!r))
 			r = drm_exec_lock_obj(&exec, &tma_bo->tbo.base);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r)) {
 			dev_err(adev->dev,
 				"failed to reserve CWSR BOs: err=%d\n", r);
-			goto err;
+			goto out;
 		}
 	}
 
+	amdgpu_trap_clear_l2_handler(vm, *trap_obj);
+
 	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TBA);
 	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
-err:
+out:
 	drm_exec_fini(&exec);
 	amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
 	kfree(*trap_obj);
@@ -509,120 +565,186 @@ static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
 					  struct amdgpu_vm *vm,
 					  struct amdgpu_trap_usr_addr *usr_addr)
 {
+	struct amdgpu_bo *bo;
 	struct amdgpu_bo_va_mapping *va_map;
-	uint64_t addr;
-	uint32_t size;
-	int r;
+	u64 addr;
+	u32 size;
+
+	/*
+	 * Caller holds the VM root BO reservation; assert rather than
+	 * taking it again.
+	 */
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 
 	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
 	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
 
-	r = amdgpu_bo_reserve(vm->root.bo, false);
-	if (r)
-		return r;
-
 	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
-	if (!va_map) {
-		r = -EINVAL;
-		goto err;
-	}
-	/* validate whether resident in the VM mapping range */
-	if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
-		amdgpu_bo_unreserve(vm->root.bo);
-		return 0;
+	if (!va_map)
+		return -EINVAL;
+
+	/*
+	 * TBA/TMA BOs must be VM_ALWAYS_VALID. The GPU jumps to TBA on
+	 * hardware exception without any software job submission, so the
+	 * kernel cannot add TBA/TMA to a job's used-buffer list to keep
+	 * page tables current. Without VM_ALWAYS_VALID the BO can be
+	 * evicted and the page table entry becomes stale, causing a GPU
+	 * page fault or memory corruption on the next shader exception.
+	 */
+	bo = va_map->bo_va->base.bo;
+	if (!(bo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)) {
+		dev_dbg(adev->dev,
+			"TBA/TMA BO at VA 0x%llx must use VM_ALWAYS_VALID\n",
+			usr_addr->addr);
+		return -EINVAL;
 	}
 
-	r = -EINVAL;
-err:
-	amdgpu_bo_unreserve(vm->root.bo);
+	if (addr >= va_map->start && va_map->last - addr + 1 >= size)
+		return 0;
 
-	return r;
+	return -EINVAL;
 }
 
-static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-					   struct amdgpu_trap_obj *cwsr_obj,
-					   struct amdgpu_trap_usr_addr *tma,
-					   struct amdgpu_trap_usr_addr *tba)
+int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
+			       struct amdgpu_userq_mgr *uq_mgr,
+			       struct amdgpu_trap_obj *trap_obj,
+			       u64 tba_va, uint32_t tba_sz,
+			       u64 tma_va, uint32_t tma_sz)
 {
-	uint64_t *l1tma;
+	struct amdgpu_trap_usr_addr tba = { .addr = tba_va, .size = tba_sz };
+	struct amdgpu_trap_usr_addr tma = { .addr = tma_va, .size = tma_sz };
+	long timeout;
 	int r;
 
 	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
-
-	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
+	if (!trap_obj || iosys_map_is_null(&trap_obj->tma_map))
 		return -EINVAL;
-	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
+
+	/*
+	 * Wait for any kernel-queue work using this VM to drain before
+	 * evicting user queues and writing the new descriptor. Without
+	 * this wait a kernel-queue wave can observe a partially-written
+	 * TBA/TMA pair during the update window. SET fails if the wait
+	 * is interrupted or times out so the caller can retry.
+	 */
+	timeout = amdgpu_vm_wait_idle(vm, MAX_SCHEDULE_TIMEOUT);
+	if (timeout <= 0)
+		return timeout < 0 ? timeout : -ETIMEDOUT;
+
+	/*
+	 * Evict all user queues before updating TBA/TMA. Writing TBA and
+	 * TMA as two separate stores creates a race: a wave that traps
+	 * between them reads a mismatched pair. Evicting first ensures no
+	 * wave is active during the update.
+	 */
+	amdgpu_userq_evict(uq_mgr);
+
+	/* Flush GPU TLB to remove stale cached TBA/TMA values */
+	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
 	if (r)
 		return r;
-	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
+
+	r = amdgpu_trap_validate_user_addr(adev, vm, &tba);
+	if (r)
+		goto out_unreserve;
+	r = amdgpu_trap_validate_user_addr(adev, vm, &tma);
+	if (r)
+		goto out_unreserve;
+
+	/* Zero TBA first to disable residual handler, then TMA, then TBA */
+	iosys_map_wr(&trap_obj->tma_map,
+		     AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, 0);
+	dma_wmb();
+	iosys_map_wr(&trap_obj->tma_map,
+		     AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64), u64, tma_va);
+	dma_wmb();
+	iosys_map_wr(&trap_obj->tma_map,
+		     AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64), u64, tba_va);
+
+	trap_obj->l2_tba_addr = tba_va;
+	trap_obj->l2_tba_size = tba_sz;
+	trap_obj->l2_tma_addr = tma_va;
+	trap_obj->l2_tma_size = tma_sz;
+
+out_unreserve:
+	amdgpu_bo_unreserve(vm->root.bo);
+	if (!r) {
+		trap_obj->l2_trap_removed = false;
+		amdgpu_userq_restore_all(uq_mgr);
+	}
+	return r;
+}
+
+int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_trap_obj *trap_obj)
+{
+	int r;
+
+	amdgpu_vm_wait_idle(vm, MAX_SCHEDULE_TIMEOUT);
+	amdgpu_userq_evict(uq_mgr);
+	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
 	if (r)
 		return r;
 
-	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
-	l1tma[0] = tma->addr;
-	l1tma[1] = tba->addr;
+	amdgpu_trap_clear_l2_handler(vm, trap_obj);
+	trap_obj->l2_trap_removed = false;
 
+	amdgpu_bo_unreserve(vm->root.bo);
+	amdgpu_userq_restore_all(uq_mgr);
 	return 0;
 }
 
-/*
- * Userspace trap handler related ioctl
- */
-/**
- * amdgpu_trap_ioctl - Handle trap handler specific requests.
- *
- * @dev: drm device pointer
- * @data: request object
- * @filp: drm filp
- *
- * This function is used to perform cwsr and trap handler related operations
- * Returns 0 on success, error code on failure.
- */
-int amdgpu_trap_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+void amdgpu_trap_handle_l2_unmap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_trap_obj *trap_obj,
+				 u64 addr, u64 size)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	union drm_amdgpu_trap *cwsr = data;
-	struct amdgpu_fpriv *fpriv;
-	int r;
+	bool tba_overlap, tma_overlap;
 
-	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+	if (!trap_obj || !size || !uq_mgr)
+		return;
 
-	if (!fpriv->trap_obj)
-		return -EOPNOTSUPP;
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 
-	switch (cwsr->in.op) {
-	case AMDGPU_TRAP_OP_SET_L2_TRAP: {
-		struct amdgpu_trap_usr_addr tba;
-		struct amdgpu_trap_usr_addr tma;
-
-		tba.addr = cwsr->in.l2trap.tba_va;
-		tba.size = cwsr->in.l2trap.tba_sz;
-		tma.addr = cwsr->in.l2trap.tma_va;
-		tma.size = cwsr->in.l2trap.tma_sz;
-		r = amdgpu_trap_set_l2_trap_handler(adev, &fpriv->vm, fpriv->trap_obj, &tma, &tba);
-	} break;
-	default:
-		return -EINVAL;
-	}
+	tba_overlap = trap_obj->l2_tba_size &&
+		      addr < trap_obj->l2_tba_addr + trap_obj->l2_tba_size &&
+		      trap_obj->l2_tba_addr < addr + size;
+	tma_overlap = trap_obj->l2_tma_size &&
+		      addr < trap_obj->l2_tma_addr + trap_obj->l2_tma_size &&
+		      trap_obj->l2_tma_addr < addr + size;
 
-	return r;
+	if (!tba_overlap && !tma_overlap)
+		return;
+
+	amdgpu_vm_wait_idle(vm, MAX_SCHEDULE_TIMEOUT);
+	amdgpu_userq_evict(uq_mgr);
+	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
+	amdgpu_trap_clear_l2_handler(vm, trap_obj);
+	trap_obj->l2_trap_removed = true;
 }
 
 int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
 				    struct amdgpu_trap_obj *cwsr_obj,
 				    bool enabled)
 {
-	uint64_t *l1tma;
-
 	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
 	if (!cwsr_obj)
 		return -EINVAL;
 
-	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
-	l1tma[2] = enabled;
+	iosys_map_wr(&cwsr_obj->tma_map,
+		     AMDGPU_TRAP_DEBUG_FLAG_INDEX * sizeof(u64), u64,
+		     (u64)enabled);
 
 	return 0;
-}
\ No newline at end of file
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 6d4664469bad..2d855433308a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -24,11 +24,13 @@
 #define AMDGPU_TRAP_H
 
 #include <linux/types.h>
+#include <linux/iosys-map.h>
 
 struct amdgpu_bo;
 struct amdgpu_bo_va;
 struct amdgpu_device;
 struct amdgpu_vm;
+struct amdgpu_userq_mgr;
 
 /**
  * struct amdgpu_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
@@ -42,7 +44,23 @@ struct amdgpu_trap_obj {
 	struct amdgpu_bo *tma_bo;
 	struct amdgpu_bo_va *tba_va;
 	struct amdgpu_bo_va *tma_va;
-	void *tma_cpu_addr;
+	struct iosys_map tma_map;  /* GTT or VRAM MMIO, set at alloc time */
+
+	/*
+	 * Active second-level trap-handler VA ranges.
+	 * Protected by the VM root BO reservation object.
+	 */
+	u64 l2_tba_addr;
+	u64 l2_tba_size;
+	u64 l2_tma_addr;
+	u64 l2_tma_size;
+
+	/*
+	 * Set when TBA or TMA was removed via GEM_VA UNMAP without calling
+	 * CLEAR_L2_TRAP first. Prevents queues restarting with a missing
+	 * trap handler. Cleared when SET_L2_TRAP or CLEAR_L2_TRAP is called.
+	 */
+	bool l2_trap_removed;
 };
 
 struct amdgpu_trap_info {
@@ -75,16 +93,31 @@ void amdgpu_trap_fini(struct amdgpu_device *adev);
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj);
 void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_trap_obj **trap_obj);
+
 static inline bool amdgpu_trap_is_enabled(struct amdgpu_device *adev)
 {
 	return adev->trap_info;
 }
 
+/**
+ * amdgpu_trap_l2_was_removed - check if TBA/TMA was forcibly removed.
+ *
+ * Returns true if the second-level trap handler TBA or TMA was removed
+ * via GEM_VA UNMAP without calling CLEAR_L2_TRAP first. Queues must
+ * not restart with a missing trap handler.
+ */
+static inline bool amdgpu_trap_l2_was_removed(struct amdgpu_trap_obj *obj)
+{
+	return obj && obj->l2_trap_removed;
+}
+
 uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc);
 int amdgpu_trap_validate_params(struct amdgpu_device *adev,
 				struct amdgpu_trap_params *trap_params,
 				int num_xcc);
+
 static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
@@ -92,8 +125,33 @@ static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
 	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
 }
 
-int amdgpu_trap_ioctl(struct drm_device *dev, void *data,
-		      struct drm_file *filp);
+void amdgpu_trap_clear_l2_handler(struct amdgpu_vm *vm,
+				  struct amdgpu_trap_obj *trap_obj);
+
+/**
+ * amdgpu_trap_vm_set_l2_trap - install the second-level trap handler.
+ *
+ * Exclusivity: SET_L2_TRAP is per-VM (per-process). Each process has its
+ * own per-process TMA buffer created in amdgpu_trap_alloc(). App A's
+ * handler address lives in App A's TMA; App B's in App B's TMA. There
+ * is no conflict between processes on user queue VMIDs.
+ */
+int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
+			       struct amdgpu_userq_mgr *uq_mgr,
+			       struct amdgpu_trap_obj *trap_obj,
+			       u64 tba_va, uint32_t tba_sz,
+			       u64 tma_va, uint32_t tma_sz);
+int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_trap_obj *trap_obj);
+void amdgpu_trap_handle_l2_unmap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_trap_obj *trap_obj,
+				 u64 addr, u64 size);
+
 int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
 				    struct amdgpu_trap_obj *cwsr_obj,
 				    bool enabled);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index db09e879b85e..aef11786e119 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -997,9 +997,10 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
-static int
+int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_usermode_queue *queue;
 	unsigned long queue_id;
 	int ret = 0, r;
@@ -1011,7 +1012,21 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
-			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
+			trace_amdgpu_userq_state_changed(queue,
+							 AMDGPU_USERQ_STATE_INVALID_VA);
+			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+			continue;
+		}
+
+		/*
+		 * If the second-level trap handler TBA or TMA was forcibly
+		 * removed by GEM_VA UNMAP without CLEAR_L2_TRAP, do not
+		 * restart the queue. A queue must not run without a valid
+		 * resident trap handler if one was previously configured.
+		 */
+		if (amdgpu_trap_l2_was_removed(fpriv->trap_obj)) {
+			trace_amdgpu_userq_state_changed(queue,
+							 AMDGPU_USERQ_STATE_INVALID_VA);
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
 			continue;
 		}
@@ -1024,7 +1039,8 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	if (ret)
 		drm_file_err(uq_mgr->file,
-			     "Failed to map all the queues, restore failed ret=%d\n", ret);
+			     "Failed to map all the queues, restore failed ret=%d\n",
+			     ret);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 3e19bc6103a0..d1569346bfae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -164,6 +164,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
+int amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 552cbf483543..4785cf48da17 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,7 +59,6 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
-#define DRM_AMDGPU_TRAP			0x1B
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -82,7 +81,6 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
-#define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
 
 /**
  * DOC: memory domains
-- 
2.34.1

