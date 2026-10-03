Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF61FCA5FE4
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 04:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1636010E72F;
	Sat,  3 Oct 2026 04:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7c4WBj7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25DD10E73D
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 04:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkzGu/pSHMCGvpOp8xJpaYCyonecauVzXl7DRUUlPvcXbcQ2OADhLCdttQ/zXuI1p1GNMuQeEiineAzJPZKyYRGyDJf4VAAGMcRG3TgHcgrLLcDhlh5DaYNF/A7pjwKv2tC9oxidYoHxtU+MrhGuSq7CLjqYL3qpgSvveBvGJd9e5i6F6uC4iRVMyLtJqtlx+sjFaZrjMmRoZsvTXCMD+qCs2fJJKc6yYjs4Nsb5JwHUZaTMe4tjFmymVb2/RcvNu/fv00smrFgcdurfYGAdC0xNZKFMgbgBcknt6Fwf9H8JBwPOm7WKDlQDybSL23SvhiiJuoaUeiUT5cYSghlRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC+lM4mYFAqqq6BoPyB3z/fkAvNy2nQ/Z15VHeT3wNs=;
 b=QMR3yeoM80bGUXbDXCXpW/aTAYs4lgyf0Ii5zcoYhCAXXknuJnySFISPRNXJxTtpZL+fyET/cX6l+JHnr6LXVUQHXWG09b//svF7sclV/QuFXZhgw9Mlt24OXO4uUpHZwvdcAzivSK0G617y6VFukTXEvF+wdfAGTg5PMgK3mB43g7QskkQDhoSxJDjbCZwltZjbQMifk3PfVaXZNW0MnaORHEIljL/9B/WxzHKOu5xctk83zeJPU17fsRjxO8W/7WV8QYAB1hwlOnZl1/1ojiYFduQn6shBVGIJAzM+rY7axSJnYHs7l2xTJX9Q8+PvcnHWSCnnbomC8eR24R84IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC+lM4mYFAqqq6BoPyB3z/fkAvNy2nQ/Z15VHeT3wNs=;
 b=z7c4WBj7Js/Nm/bIippv9wAv0cP6p87/0FnZ1eq00Q8Yd41r6Lhhq8YQNt6vooSOaiaXY72zdJVyvCIiNE7C/ovQXeAmGZp7uwg/+Qos+J3R1FH9hAfjxgcGarh7ZXrmy6YdU3Ep0iy8KgdQSGVJCgS1/ID1njlKLf+XXAt+gDo=
Received: from DM6PR07CA0113.namprd07.prod.outlook.com (2603:10b6:5:330::16)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 3 Oct
 2026 04:40:18 +0000
Received: from CY8PEPF00000057.namprd21.prod.outlook.com
 (2603:10b6:5:330:cafe::88) by DM6PR07CA0113.outlook.office365.com
 (2603:10b6:5:330::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Sat, 3
 Oct 2026 04:40:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000057.mail.protection.outlook.com (10.167.247.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Sat, 3 Oct 2026 04:40:17 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 23:40:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie
 Vock <natalie.vock@gmx.de>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: Add second-level trap handler
 infrastructure
Date: Sat, 3 Oct 2026 10:09:50 +0530
Message-ID: <20261003043953.936202-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261003043953.936202-1-srinivasan.shanmugam@amd.com>
References: <20261003043953.936202-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000057:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2ddbbf-b3de-4359-4f95-08df21086cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0KMGGtGSJgL3cYZewVpuH923e3haP8bhZm19re46CeY0uGNiUi3WpJ/ScWSbp4uH4xvCea3QlX++VtsNqrvxnbNAQC1FuYZAVdFBidg5f+DuCF9YgZG7lG4F70uVAh7BRgdvd9JQcdIyK0QaUZI40B19utncKTQVw2alELWmPENk9v217jLI/sAMEic7zLn9qqd4Ifk0FCxzCTg8KdZ3EjyhjEhJHpPIJUFDB+gpGohxx2LlWjU64hswRE5KFxPeAnSeItJ1tq1bRSaGItFJqfMdqjcsOAj5gHv2FYeDzfSb0uZWpcir8HnAyv4eVvXPCVxGQTV+8c81XtRHODpVw+UibI0fASjDoQ8c7oOnqk3cGrsFe7QoH3wgUnIfVKf+UaFqIbv3p9AhbIPQ3rd8Vf5CwZ3h+CQxloiC6EkhM6xEWyFRpulFJDbDbSslcu3UyIAaBiqznDasWHN/JaWmZBPugtbEPNy372Gm9MVyXYzkoS2PPDPwLxqp/OgokIWN3lIlkD7nvXhpjuTfBpPS3Zv6nW1MR2KXMbAq4AFdRm2md12F07gZEAcH0hJea8/E9LKUCzRvkHiCM9z5H/5XULe4WwbNQwTG5ICMyXZrVSbkZG8v/UqmSdUdCwpHmIlgfx2fJp4ULVXLIC1fvic8Kpo4HKMreYoTGNAcc48rnjA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 60CsZooQsOlWSP5t5aD1/oiVShjao3SS0iUWUMIL6/SqGnsnaqf8YkLJbm+LyGQthnAPCxtxar8Yk7LGUFYKRD5GMJu9S2nkK9WvbHLyGiBh58PAJLMGlmfuMEhuTv33ZEhyuoyU5zX6YHnQ/LR8ih3M0R9LlnUMWk4yV2YDauwHgt/gKZe9KN+YGeBj+KeBOl+cNY+9z4jOE+5v3HePLfoRT0qKx3PETZqU8ivtgRQff/AvmOrpWcLWWPLvON6Lc8d9wTR4IhHg0krJmoj+9FjG/GLhoKHCCQGwVeiNiKy3GC7FOzwGwy+XbCJPeLQgQcgkPGukxr3WsynGdg/lUBVVhoto2NWaRUctM3ANYExN7er2vU7O0OP8CmniNwprknX88k9JPDnC+hU/eBOq7azFRELKyc4lzAGquXQNn/FvGyYvpcVRziHw+N2PgvK7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 04:40:17.6811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2ddbbf-b3de-4359-4f95-08df21086cbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000057.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
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

Add the basic support needed for a userspace second-level trap handler.

The first-level TMA buffer can move in memory, so do not keep it
permanently mapped on the CPU. Map it only when it needs to be accessed
and unmap it afterwards.

Store the second-level TBA and TMA addresses in the first-level TMA.
The TBA is stored first and the TMA is stored next, as expected by the
trap handler.

The second-level trap handler is set per GPUVM. Each GPUVM has its own
first-level TMA, so changing the L2 TBA and TMA only changes the trap
handler for that GPUVM.

Add helpers to set and clear the second-level TBA and TMA addresses.
Check that both address ranges are mapped in the GPUVM before using
them.

Wait for GPUVM work to stop before changing the addresses. Keep the VM
locked while checking and updating them so the queues cannot be resumed
until the update is complete.

Remove the old standalone TRAP ioctl. The new SET_L2_TRAP and
CLEAR_L2_TRAP operations are added through the VM ioctl in a later
patch.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
Changes in v3:
- Remove explicit user queue evict/restore handling from SET/CLEAR and
  use the existing GPUVM eviction-fence synchronization.
- Keep the VM root reserved while validating and updating the L2 trap
  descriptor so queue resume cannot race with the update.
- Remove the no-longer-needed amdgpu_userq_restore_all() export.
- Remove all remaining old standalone TRAP UAPI definitions.
- Keep reset-domain protection and dma_wmb() for TMA accesses.

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 348 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  62 +++-
 include/uapi/drm/amdgpu_drm.h            |  23 --
 4 files changed, 282 insertions(+), 152 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 29eba2968350..b55b5d016148 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -19,12 +19,23 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
+#include <linux/iosys-map.h>
+
+#include <drm/ttm/ttm_bo.h>
 #include <drm/drm_exec.h>
 
 #include "amdgpu.h"
 #include "cwsr_trap_handler.h"
 #include "amdgpu_trap.h"
 
+/*
+ * First-level TMA layout used by the second-level trap-handler ABI.
+ * The trap-handler ISA reads L2 TBA at offset 0 and L2 TMA at offset 8.
+ */
+#define AMDGPU_TRAP_L2_TBA_INDEX	0
+#define AMDGPU_TRAP_L2_TMA_INDEX	1
+#define AMDGPU_TRAP_DEBUG_FLAG_INDEX	2
+
 extern int cwsr_enable;
 
 #define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
@@ -378,6 +389,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj)
 {
 	struct amdgpu_bo_param bp;
+	struct iosys_map map;
 	struct amdgpu_trap_obj *cwsr;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
@@ -385,6 +397,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
+
 	if (!vm || !trap_obj)
 		return -EINVAL;
 
@@ -393,72 +406,137 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -ENOMEM;
 
 	bo = adev->trap_info->isa_bo;
+
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
-		if (likely(!r))
-			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r)) {
-			dev_err(adev->dev,
-				"failed to reserve for CWSR allocs: err=%d\n",
-				r);
+		if (unlikely(r))
+			goto err_exec;
+
+		r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
 			goto err_exec;
-		}
 	}
 
 	/*
-	 * Create TMA BO using the VM's already-locked resv so no new
-	 * reservation_ww_class_mutex acquisition is needed — avoiding the
-	 * recursive ww_mutex deadlock. Unpinned; eviction is handled via
-	 * amdgpu_vm_bo_add() inside amdgpu_trap_map_region().
+	 * Create the TMA BO with the VM root reservation. The reservation is
+	 * already held by drm_exec, so creating the BO doesn't recursively
+	 * acquire another reservation_ww_class_mutex. The TMA remains
+	 * unpinned and is covered by the VM root reservation.
 	 */
 	memset(&bp, 0, sizeof(bp));
-	bp.size        = AMDGPU_TRAP_TMA_MAX_SIZE;
-	bp.byte_align  = PAGE_SIZE;
-	bp.domain      = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags       = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
-			 AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	bp.type        = ttm_bo_type_kernel;
+	bp.size = AMDGPU_TRAP_TMA_MAX_SIZE;
+	bp.byte_align = PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
+		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	bp.type = ttm_bo_type_kernel;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-	bp.resv        = vm->root.bo->tbo.base.resv;
+	bp.resv = vm->root.bo->tbo.base.resv;
 
 	r = amdgpu_bo_create(adev, &bp, &cwsr->tma_bo);
 	if (r)
 		goto err_exec;
 
-	/* VM resv already held — kmap directly, no separate reserve needed */
-	r = amdgpu_bo_kmap(cwsr->tma_bo, &cwsr->tma_cpu_addr);
+	/*
+	 * The TMA BO is unpinned and movable. Map it only while accessing
+	 * its contents so that no CPU mapping can become stale across BO
+	 * migration. ttm_bo_vmap() and ttm_bo_vunmap() require the BO
+	 * reservation, which is the already held VM root reservation.
+	 */
+	r = ttm_bo_vmap(&cwsr->tma_bo->tbo, &map);
 	if (r)
 		goto err_tma;
 
-	memset(cwsr->tma_cpu_addr, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
+	/*
+	 * Protect CPU access to the TMA against GPU reset. Finish the
+	 * initialization with a DMA write barrier before allowing the GPU
+	 * to observe the contents.
+	 */
+	down_read(&adev->reset_domain->sem);
+	iosys_map_memset(&map, 0, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
+	dma_wmb();
+	up_read(&adev->reset_domain->sem);
+
+	ttm_bo_vunmap(&cwsr->tma_bo->tbo, &map);
 
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
 	if (r)
-		goto err_kmap;
+		goto err_tma;
 
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
 	if (r) {
 		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
-		goto err_kmap;
+		goto err_tma;
 	}
 
 	drm_exec_fini(&exec);
+
 	*trap_obj = cwsr;
+
 	return 0;
 
-err_kmap:
-	amdgpu_bo_kunmap(cwsr->tma_bo);
 err_tma:
 	amdgpu_bo_unref(&cwsr->tma_bo);
+
 err_exec:
 	drm_exec_fini(&exec);
 	kfree(cwsr);
 	*trap_obj = NULL;
+
 	return r;
 }
 
+static int amdgpu_trap_update_l2_handler(struct amdgpu_device *adev,
+					 struct amdgpu_trap_obj *trap_obj,
+					 u64 tba, u64 tma)
+{
+	struct iosys_map map;
+	int r;
+
+	if (!trap_obj || !trap_obj->tma_bo)
+		return -EINVAL;
+
+	dma_resv_assert_held(trap_obj->tma_bo->tbo.base.resv);
+
+	r = ttm_bo_vmap(&trap_obj->tma_bo->tbo, &map);
+	if (r)
+		return r;
+
+	/*
+	 * Protect CPU access to the TMA while a GPU reset is in progress.
+	 * Keep all descriptor writes and the ordering barrier under one
+	 * reset-domain read-side critical section.
+	 */
+	down_read(&adev->reset_domain->sem);
+
+	iosys_map_wr(&map, AMDGPU_TRAP_L2_TBA_INDEX * sizeof(u64),
+		     u64, tba);
+	iosys_map_wr(&map, AMDGPU_TRAP_L2_TMA_INDEX * sizeof(u64),
+		     u64, tma);
+	dma_wmb();
+
+	up_read(&adev->reset_domain->sem);
+
+	ttm_bo_vunmap(&trap_obj->tma_bo->tbo, &map);
+
+	return 0;
+}
+
+static int amdgpu_trap_clear_l2_handler(struct amdgpu_device *adev,
+					struct amdgpu_vm *vm,
+					struct amdgpu_trap_obj *trap_obj)
+{
+	if (!trap_obj || !trap_obj->tma_bo)
+		return -EINVAL;
+
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	return amdgpu_trap_update_l2_handler(adev, trap_obj, 0, 0);
+}
+
 int amdgpu_trap_validate_params(struct amdgpu_device *adev,
 				struct amdgpu_trap_params *trap_params,
 				int num_xcc)
@@ -493,161 +571,195 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj)
 {
 	struct amdgpu_bo *tba_bo;
-	struct amdgpu_bo *tma_bo;
 	struct drm_exec exec;
 	int r;
 
-	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
+	if (!trap_obj || !*trap_obj)
 		return;
 
 	tba_bo = adev->trap_info->isa_bo;
-	tma_bo = (*trap_obj)->tma_bo;
-
-	if (!tba_bo || !tma_bo)
-		return;
 
 	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
-		if (likely(!r))
-			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r)) {
-			dev_err(adev->dev,
-				"failed to reserve CWSR BOs: err=%d\n", r);
-			goto err;
+		if (unlikely(r))
+			goto out_exec;
+
+		if (tba_bo) {
+			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(r))
+				goto out_exec;
 		}
 	}
 
-	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TBA);
-	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
-err:
+	if ((*trap_obj)->tba_va) {
+		amdgpu_vm_bo_del(adev, (*trap_obj)->tba_va);
+		(*trap_obj)->tba_va = NULL;
+	}
+
+	if ((*trap_obj)->tma_va) {
+		amdgpu_vm_bo_del(adev, (*trap_obj)->tma_va);
+		(*trap_obj)->tma_va = NULL;
+	}
+
 	drm_exec_fini(&exec);
-	/* TMA BO not pinned — release CPU mapping and free */
-	amdgpu_bo_kunmap((*trap_obj)->tma_bo);
+
 	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
 	kfree(*trap_obj);
 	*trap_obj = NULL;
+
+	return;
+
+out_exec:
+	drm_exec_fini(&exec);
 }
 
 static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
-					  struct amdgpu_vm *vm,
-					  struct amdgpu_trap_usr_addr *usr_addr)
+					 struct amdgpu_vm *vm,
+					 struct amdgpu_trap_usr_addr *usr_addr)
 {
 	struct amdgpu_bo_va_mapping *va_map;
-	uint64_t addr;
-	uint32_t size;
-	int r;
+	u64 start, end, addr, last;
 
-	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
-	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
+	if (!usr_addr || !usr_addr->size)
+		return -EINVAL;
 
-	r = amdgpu_bo_reserve(vm->root.bo, false);
-	if (r)
-		return r;
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	start = usr_addr->addr & AMDGPU_GMC_HOLE_MASK;
+
+	if (check_add_overflow(start, (u64)usr_addr->size - 1, &end))
+		return -EINVAL;
+
+	addr = start >> AMDGPU_GPU_PAGE_SHIFT;
+	last = end >> AMDGPU_GPU_PAGE_SHIFT;
 
 	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
-	if (!va_map) {
-		r = -EINVAL;
-		goto err;
-	}
-	/* validate whether resident in the VM mapping range */
-	if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
-		amdgpu_bo_unreserve(vm->root.bo);
-		return 0;
-	}
+	if (!va_map)
+		return -EINVAL;
 
-	r = -EINVAL;
-err:
-	amdgpu_bo_unreserve(vm->root.bo);
+	if (addr < va_map->start || last > va_map->last)
+		return -EINVAL;
 
-	return r;
+	return 0;
 }
 
-static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-					   struct amdgpu_trap_obj *cwsr_obj,
-					   struct amdgpu_trap_usr_addr *tma,
-					   struct amdgpu_trap_usr_addr *tba)
+int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
+			       struct amdgpu_trap_obj *trap_obj,
+			       u64 tba_va, uint32_t tba_sz,
+			       u64 tma_va, uint32_t tma_sz)
 {
-	uint64_t *l1tma;
+	struct amdgpu_trap_usr_addr tba = {
+		.addr = tba_va,
+		.size = tba_sz,
+	};
+	struct amdgpu_trap_usr_addr tma = {
+		.addr = tma_va,
+		.size = tma_sz,
+	};
+	long timeout;
 	int r;
 
 	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
-	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
+	if (!vm || !trap_obj || !trap_obj->tma_bo)
 		return -EINVAL;
-	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
+
+	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					DMA_RESV_USAGE_BOOKKEEP,
+					false, MAX_SCHEDULE_TIMEOUT);
+	if (timeout <= 0)
+		return timeout < 0 ? timeout : -ETIMEDOUT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
 	if (r)
 		return r;
-	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
+
+	r = amdgpu_trap_validate_user_addr(adev, vm, &tba);
 	if (r)
-		return r;
+		goto out_unreserve;
 
-	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
-	l1tma[0] = tma->addr;
-	l1tma[1] = tba->addr;
+	r = amdgpu_trap_validate_user_addr(adev, vm, &tma);
+	if (r)
+		goto out_unreserve;
 
-	return 0;
+	r = amdgpu_trap_update_l2_handler(adev, trap_obj,
+					  tba_va, tma_va);
+
+out_unreserve:
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
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
+int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_trap_obj *trap_obj)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	union drm_amdgpu_trap *cwsr = data;
-	struct amdgpu_fpriv *fpriv;
+	long timeout;
 	int r;
 
-	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
-
-	if (!fpriv->trap_obj)
+	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
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
+	if (!vm || !trap_obj || !trap_obj->tma_bo)
 		return -EINVAL;
-	}
+
+	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					DMA_RESV_USAGE_BOOKKEEP,
+					false, MAX_SCHEDULE_TIMEOUT);
+	if (timeout <= 0)
+		return timeout < 0 ? timeout : -ETIMEDOUT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	r = amdgpu_trap_clear_l2_handler(adev, vm, trap_obj);
+
+	amdgpu_bo_unreserve(vm->root.bo);
 
 	return r;
 }
 
 int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
-				    struct amdgpu_trap_obj *cwsr_obj,
+				    struct amdgpu_vm *vm,
+				    struct amdgpu_trap_obj *trap_obj,
 				    bool enabled)
 {
-	uint64_t *l1tma;
+	struct iosys_map map;
+	int r;
 
 	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
-	if (!cwsr_obj)
+	if (!vm || !trap_obj || !trap_obj->tma_bo)
 		return -EINVAL;
 
-	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
-	l1tma[2] = enabled;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
 
-	return 0;
-}
\ No newline at end of file
+	r = ttm_bo_vmap(&trap_obj->tma_bo->tbo, &map);
+	if (r)
+		goto out_unreserve;
+
+	down_read(&adev->reset_domain->sem);
+
+	iosys_map_wr(&map, AMDGPU_TRAP_DEBUG_FLAG_INDEX * sizeof(u64),
+		     u64, (u64)enabled);
+	dma_wmb();
+
+	up_read(&adev->reset_domain->sem);
+
+	ttm_bo_vunmap(&trap_obj->tma_bo->tbo, &map);
+
+out_unreserve:
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 6d4664469bad..c78c60e3d18d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -31,9 +31,12 @@ struct amdgpu_device;
 struct amdgpu_vm;
 
 /**
- * struct amdgpu_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
- * @bo: Buffer object for CWSR area
- * @bo_va: Buffer object virtual address mapping
+ * struct amdgpu_trap_obj - per-GPUVM CWSR trap-handler state
+ * @tma_gpu_va_addr: GPU virtual address of the first-level TMA
+ * @tba_gpu_va_addr: GPU virtual address of the first-level TBA
+ * @tma_bo: buffer object backing the first-level TMA
+ * @tba_va: VM mapping of the first-level TBA
+ * @tma_va: VM mapping of the first-level TMA
  */
 struct amdgpu_trap_obj {
 	uint64_t tma_gpu_va_addr;
@@ -42,7 +45,6 @@ struct amdgpu_trap_obj {
 	struct amdgpu_bo *tma_bo;
 	struct amdgpu_bo_va *tba_va;
 	struct amdgpu_bo_va *tma_va;
-	void *tma_cpu_addr;
 };
 
 struct amdgpu_trap_info {
@@ -50,7 +52,8 @@ struct amdgpu_trap_info {
 	struct amdgpu_bo *isa_bo;
 	const void *isa_buf;
 	uint32_t isa_sz;
-	/* cwsr size info per XCC*/
+
+	/* cwsr size info per XCC */
 	struct {
 		uint32_t xcc_ctl_stack_sz;
 		uint32_t xcc_dbg_mem_sz;
@@ -60,6 +63,7 @@ struct amdgpu_trap_info {
 
 struct amdgpu_trap_params {
 	uint64_t ctx_save_area_address;
+
 	/* cwsr size info */
 	uint32_t cwsr_sz;
 };
@@ -74,28 +78,66 @@ void amdgpu_trap_fini(struct amdgpu_device *adev);
 
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj);
-void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+
+void amdgpu_trap_free(struct amdgpu_device *adev,
+		      struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj);
+
 static inline bool amdgpu_trap_is_enabled(struct amdgpu_device *adev)
 {
 	return adev->trap_info;
 }
 
 uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc);
+
 int amdgpu_trap_validate_params(struct amdgpu_device *adev,
 				struct amdgpu_trap_params *trap_params,
 				int num_xcc);
+
 static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 
-	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
+	return gc_ver >= IP_VERSION(11, 0, 0) &&
+	       gc_ver <= IP_VERSION(11, 0, 3);
 }
 
-int amdgpu_trap_ioctl(struct drm_device *dev, void *data,
-		      struct drm_file *filp);
+/**
+ * amdgpu_trap_vm_set_l2_trap - install the second-level trap handler
+ * @adev: AMDGPU device
+ * @vm: GPUVM owning the first-level trap state
+ * @trap_obj: first-level trap object
+ * @tba_va: GPU virtual address of the second-level TBA
+ * @tba_sz: size of the second-level TBA
+ * @tma_va: GPU virtual address of the second-level TMA
+ * @tma_sz: size of the second-level TMA
+ *
+ * The second-level trap handler is configured per GPUVM. The descriptor is
+ * stored in the per-GPUVM first-level TMA.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
+			       struct amdgpu_trap_obj *trap_obj,
+			       u64 tba_va, uint32_t tba_sz,
+			       u64 tma_va, uint32_t tma_sz);
+
+/**
+ * amdgpu_trap_vm_clear_l2_trap - clear the second-level trap handler
+ * @adev: AMDGPU device
+ * @vm: GPUVM owning the first-level trap state
+ * @trap_obj: first-level trap object
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_trap_obj *trap_obj);
+
 int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
-				    struct amdgpu_trap_obj *cwsr_obj,
+				    struct amdgpu_vm *vm,
+				    struct amdgpu_trap_obj *trap_obj,
 				    bool enabled);
 
 #endif
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9e5fa6f53e59..86f957d07f4c 100644
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
@@ -1759,27 +1757,6 @@ struct drm_amdgpu_info_cwsr {
 	__u32 min_save_area_size;
 };
 
-/* cwsr ioctl */
-#define AMDGPU_TRAP_OP_SET_L2_TRAP 1
-
-struct drm_amdgpu_trap_in {
-	/* AMDGPU_TRAP_OP_* */
-	__u32 op;
-	struct {
-		/* Level 2 trap handler base address */
-		__u64 tba_va;
-		/* Level 2 trap handler buffer size (in bytes) */
-		__u32 tba_sz;
-		/* Level 2 trap memory buffer address */
-		__u64 tma_va;
-		/* Level 2 trap memory buffer size (in bytes) */
-		__u32 tma_sz;
-	} l2trap;
-};
-
-union drm_amdgpu_trap {
-	struct drm_amdgpu_trap_in in;
-};
 /*
  * Supported GPU families
  */
-- 
2.34.1

