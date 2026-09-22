Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D11BC982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 05:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E37010EB6B;
	Tue, 22 Sep 2026 05:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dU3Yk4cl";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3978A10E73E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 05:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6TgWAuA0zQFTB4+HheoYYvTkrePHryeCtIZKrJWpxlZqu4s3oN4j9Jxy0EiOnfXcuZswVKuGw2aUC8HB+TptMT5SKFwuKO0u0bUkTkS2deE7+N7WwTrrvvdLur9L6M8Q+yELYqmIYpl+MA8GdnHEcKChbmCkT/hBUQj+GsWyG65sxcF0nUXkkGy97sOl4FEYnSkJwhWkdCVM3qtHVJwQVkZXCpQA4ptM+SM9Af14sTSkgEGTMeibCSLKyCjW1SQgUNhCDHOmZzyUZeEjK8rN+C0wuyaZsw2mXXELDDAS3yfTiVtRxG1KZTJto/B8e0+wiPG5b31hU3s0k0ayL2k4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaG8OLpEnjZTd0/qjjopEEgOStOELn5C3tpNz+R/NOI=;
 b=bhzOfW49ueGTi1V+sub8IimXsnHjMYvZGblMtRt6HD9K/9bLvg+76xKGYSG6zAcS01ky+2ne6H6Vd6IMf60PP9GxyHXnnWiJINtOcgk3v5lJ+tndUGzY+0klG632YEZIRn6v4OD23brrMlQv1BzbxuxMqrdHBAQCxh4EQMfqVAeNVtlDpvGuxk5iI0pGcKNHTrM4uq5v2FVfXgpF5K2SKCcqXFnbzKWDwTUS6sKtFlqmYusMqrqBkE+QS7BOvaMpcY2pqwGf2xsTmTVoF4fMsqo6/urzCWX/0PLNUkJUqAVXx729KLvl6m1j3isWeZXVGVjF4CQR5j2f8iT+6e+MDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaG8OLpEnjZTd0/qjjopEEgOStOELn5C3tpNz+R/NOI=;
 b=dU3Yk4clA5/8fggIswnuczH1r9SOuBV5WmW4IOVi6b4nO5RZfHyOX6Sw5nYEDfd5/0I0wPBUehGoUlzQ3nVSo4i5sAzAgN0FNOs9+0SvKbZnpR1zY2sitSj6ssyXSRlqxgBWN60jqKHsIO1/DS8sCBGspQKbM7EwoyIB1XZE15M=
Received: from SA9P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::34)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 05:20:01 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::ae) by SA9P221CA0029.outlook.office365.com
 (2603:10b6:806:25::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.15 via Frontend Transport; Tue,
 22 Sep 2026 05:20:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 05:20:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 22 Sep 2026 00:19:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Add second-level trap handler
 infrastructure
Date: Tue, 22 Sep 2026 10:49:30 +0530
Message-ID: <20260922051933.772319-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922051933.772319-1-srinivasan.shanmugam@amd.com>
References: <20260922051933.772319-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: c934bef1-d74f-40b2-7d69-08df18692634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: N9qnrROTT0ZIGaa9RD8zdzpBw5ymMaONk2ulVhZoNBJcUIsNj3ydJqrxPQ+KaUjYgoCKvib+QiAOUd4pV7TSgFiK2eIITDFENk8fLvtDZyt2grGyVw9IJtvtlmtxV9ODUaJz5wKQfalUZBFcRCN0EE/9Gxo4lzYlq85s8Tx8iADqL3GRmlCJ9i9lt5BbtFP4z60vakWAky6KuDujHCXEvAPR4RwiN48KrkFVBpPfV1hoL3uAsc25u1UKaZ3fRwuMvAO/J7m6QnhpEF1/ZHRlPX4Rwo6rdtoWosMoX64nWg2Dd6bu+R/RjvQi/gaJeydtm17f/O5XK4hcH3h5ffalSWfXjImkki7sWqYrehb8cZv5KT4yqniw0DxXWS43jqBkuW4R5hxI7fSPQIzi3EO7o+/mzg0y7MvUKbeVFO+xDss7hvMgte6i2ukoanRv748Y7+QXlVAvFwHi5j8OrxBmtmEK/qNcMnrgr4ndqKtEJonpAPzGvZIX/h5/3XejPjI9JYSeueGWqoxESjAF+ipL3vQ6zsKFCNtdpmPI1Wlf/gBPNqQnGU2hB4KWvK12fRjif0ACc+fy8l2KZ/OhnCTHUDvsO1vzJxqnpkwmT1r4WXce2agU3wxXYxevVBWD5PMQW4QdgbCp21R3Cl1GwV3ijJ7eMbJxP2bd6NiYnmkFruxrYXzIv1cWqOsyiOe9OftnyeC+Rt5nOghrX9qcoFAqVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DUdbgBUOC6pTngf4jvU8KND8uQ9Tv/LmYI4vfr5q50VfP6MNdZPJczgDq1amSTDv4p0E0VD8lGp2Tlzw/HUtQ2AqKbi0oPb/stUqO5HKB2tmuSVvSMUSgZ7PlE+tcH1/0fVKI2sHbXjSYFBlMR8r1t2I2aZ0U09W+kiWXVGR4d/asM4YH0392Df7dpGjAL8JSlmwCtrZZ4BWR9jV07uFI4zG50a561PBkMCvdK+ztCXkXnPwrxD8EcSGi6f6JCt7EdOxPyjOwPxeLqIGZEMB5CPpVO7vh3KvTDLMZk8fnDYz9cct4yNhI4rQ4ErQLbwQj6EE7fimbLBtWlT2Pjv+uY6cdydKMfpjbHfEMFevALSxSVQR3HFCfjeOqk5UOdkfBw/lDqCQ4bLAiQwhpAqj4elMX06lhMxoS6w/7vYu9GOXt7fuMpjHh9oEbrKzZykg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 05:20:00.0834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c934bef1-d74f-40b2-7d69-08df18692634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

The first-level TMA BO is unpinned and movable, so a persistent CPU
mapping can become stale if the BO migrates. Map the TMA only while
accessing its contents with ttm_bo_vmap(), use iosys_map helpers for
CPU accesses, and unmap it before releasing the VM root reservation.

Writing TBA and TMA as two separate stores creates a race where a
trapping wave can observe a mismatched pair. Evict user queues and wait
for outstanding work tracked by the GPUVM reservation before updating
the descriptor, then restore the queues afterwards.

Evict user queues in amdgpu_trap_free() at file close. Without eviction
a freed TMA BO can be accessed via a stale TBA, causing a GPU page
fault.

Export amdgpu_userq_restore_all() for immediate queue restore after
SET/CLEAR without waiting for the eviction fence.

The old TRAP ioctl and its internal handler are removed. The new
SET/CLEAR path is exposed via the VM ioctl in a later patch.

SET_L2_TRAP is per-GPUVM. Each GPUVM has its own first-level TMA buffer
allocated in amdgpu_trap_alloc(), so the second-level handler descriptor
is private to that GPUVM.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c  | 391 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h  |  68 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
 include/uapi/drm/amdgpu_drm.h             |   2 -
 7 files changed, 353 insertions(+), 124 deletions(-)

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
index 29eba2968350..05d8f48e06cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -19,12 +19,24 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
+#include <linux/iosys-map.h>
+
+#include <drm/ttm/ttm_bo.h>
 #include <drm/drm_exec.h>
 
 #include "amdgpu.h"
+#include "amdgpu_userq.h"
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
@@ -378,6 +390,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj)
 {
 	struct amdgpu_bo_param bp;
+	struct iosys_map map;
 	struct amdgpu_trap_obj *cwsr;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
@@ -385,6 +398,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
+
 	if (!vm || !trap_obj)
 		return -EINVAL;
 
@@ -393,72 +407,145 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -ENOMEM;
 
 	bo = adev->trap_info->isa_bo;
+
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
-		if (likely(!r))
-			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r)) {
 			dev_err(adev->dev,
-				"failed to reserve for CWSR allocs: err=%d\n",
+				"failed to reserve VM PD for CWSR allocs: err=%d\n",
+				r);
+			goto err_exec;
+		}
+
+		r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r)) {
+			dev_err(adev->dev,
+				"failed to reserve CWSR TBA BO: err=%d\n",
 				r);
 			goto err_exec;
 		}
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
@@ -490,41 +577,54 @@ int amdgpu_trap_validate_params(struct amdgpu_device *adev,
 }
 
 void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_trap_obj **trap_obj)
 {
 	struct amdgpu_bo *tba_bo;
-	struct amdgpu_bo *tma_bo;
 	struct drm_exec exec;
 	int r;
 
 	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
 		return;
 
-	tba_bo = adev->trap_info->isa_bo;
-	tma_bo = (*trap_obj)->tma_bo;
+	/*
+	 * Evict all user queues before freeing. At file-close time waves
+	 * may still be active; without eviction a wave can trap into the
+	 * handler after the TMA BO is freed.
+	 */
+	if (uq_mgr)
+		amdgpu_userq_evict(uq_mgr);
 
-	if (!tba_bo || !tma_bo)
+	tba_bo = adev->trap_info->isa_bo;
+	if (!tba_bo)
 		return;
 
-	drm_exec_init(&exec, 0, 0);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
-		if (likely(!r))
-			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto out;
+
+		r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r)) {
 			dev_err(adev->dev,
 				"failed to reserve CWSR BOs: err=%d\n", r);
-			goto err;
+			goto out;
 		}
 	}
 
+	r = amdgpu_trap_clear_l2_handler(adev, vm, *trap_obj);
+	if (r)
+		dev_dbg(adev->dev,
+			"failed to clear L2 trap handler: %d\n", r);
+
 	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TBA);
 	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
-err:
+
+out:
 	drm_exec_fini(&exec);
-	/* TMA BO not pinned — release CPU mapping and free */
-	amdgpu_bo_kunmap((*trap_obj)->tma_bo);
 	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
 	kfree(*trap_obj);
 	*trap_obj = NULL;
@@ -535,119 +635,198 @@ static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
 					  struct amdgpu_trap_usr_addr *usr_addr)
 {
 	struct amdgpu_bo_va_mapping *va_map;
-	uint64_t addr;
-	uint32_t size;
-	int r;
+	u64 addr, last, size;
 
-	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
-	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
+	if (!usr_addr || !usr_addr->size)
+		return -EINVAL;
 
-	r = amdgpu_bo_reserve(vm->root.bo, false);
-	if (r)
-		return r;
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >>
+	       AMDGPU_GPU_PAGE_SHIFT;
+	size = DIV_ROUND_UP_ULL(usr_addr->size, AMDGPU_GPU_PAGE_SIZE);
+
+	if (check_add_overflow(addr, size - 1, &last))
+		return -EINVAL;
 
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
+			       struct amdgpu_userq_mgr *uq_mgr,
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
+	int restore_r;
 	int r;
 
 	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
-	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
+	if (!vm || !trap_obj || !trap_obj->tma_bo || !uq_mgr)
 		return -EINVAL;
-	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
+
+	amdgpu_userq_evict(uq_mgr);
+
+	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					DMA_RESV_USAGE_BOOKKEEP,
+					false, MAX_SCHEDULE_TIMEOUT);
+	if (timeout <= 0) {
+		r = timeout < 0 ? timeout : -ETIMEDOUT;
+		goto restore;
+	}
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
 	if (r)
-		return r;
-	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
+		goto restore;
+
+	r = amdgpu_trap_validate_user_addr(adev, vm, &tba);
 	if (r)
-		return r;
+		goto restore_reserved;
 
-	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
-	l1tma[0] = tma->addr;
-	l1tma[1] = tba->addr;
+	r = amdgpu_trap_validate_user_addr(adev, vm, &tma);
+	if (r)
+		goto restore_reserved;
 
-	return 0;
+	r = amdgpu_trap_update_l2_handler(adev, trap_obj,
+					  tba_va, tma_va);
+
+restore_reserved:
+	restore_r = amdgpu_userq_restore_all(uq_mgr);
+	if (!r && restore_r)
+		r = restore_r;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+
+restore:
+	/*
+	 * User queues were already evicted, but restore_all() requires the
+	 * VM root reservation for its VA mapping checks.
+	 */
+	restore_r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (!restore_r) {
+		restore_r = amdgpu_userq_restore_all(uq_mgr);
+		amdgpu_bo_unreserve(vm->root.bo);
+	}
+
+	if (restore_r)
+		dev_dbg(adev->dev,
+			"failed to restore user queues: %d\n", restore_r);
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
+				 struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_trap_obj *trap_obj)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	union drm_amdgpu_trap *cwsr = data;
-	struct amdgpu_fpriv *fpriv;
+	long timeout;
+	int restore_r;
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
+	if (!vm || !trap_obj || !trap_obj->tma_bo || !uq_mgr)
 		return -EINVAL;
+
+	amdgpu_userq_evict(uq_mgr);
+
+	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					DMA_RESV_USAGE_BOOKKEEP,
+					false, MAX_SCHEDULE_TIMEOUT);
+	if (timeout <= 0) {
+		r = timeout < 0 ? timeout : -ETIMEDOUT;
+		goto restore;
 	}
 
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		goto restore;
+
+	r = amdgpu_trap_clear_l2_handler(adev, vm, trap_obj);
+
+	restore_r = amdgpu_userq_restore_all(uq_mgr);
+	if (!r && restore_r)
+		r = restore_r;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+
+restore:
+	/*
+	 * User queues were already evicted, but restore_all() requires the
+	 * VM root reservation for its VA mapping checks.
+	 */
+	restore_r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (!restore_r) {
+		restore_r = amdgpu_userq_restore_all(uq_mgr);
+		amdgpu_bo_unreserve(vm->root.bo);
+	}
+
+	if (restore_r)
+		dev_dbg(adev->dev,
+			"failed to restore user queues: %d\n", restore_r);
+
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
index 6d4664469bad..323c49a53dad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -28,12 +28,16 @@
 struct amdgpu_bo;
 struct amdgpu_bo_va;
 struct amdgpu_device;
+struct amdgpu_userq_mgr;
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
@@ -42,7 +46,6 @@ struct amdgpu_trap_obj {
 	struct amdgpu_bo *tma_bo;
 	struct amdgpu_bo_va *tba_va;
 	struct amdgpu_bo_va *tma_va;
-	void *tma_cpu_addr;
 };
 
 struct amdgpu_trap_info {
@@ -50,7 +53,8 @@ struct amdgpu_trap_info {
 	struct amdgpu_bo *isa_bo;
 	const void *isa_buf;
 	uint32_t isa_sz;
-	/* cwsr size info per XCC*/
+
+	/* cwsr size info per XCC */
 	struct {
 		uint32_t xcc_ctl_stack_sz;
 		uint32_t xcc_dbg_mem_sz;
@@ -60,6 +64,7 @@ struct amdgpu_trap_info {
 
 struct amdgpu_trap_params {
 	uint64_t ctx_save_area_address;
+
 	/* cwsr size info */
 	uint32_t cwsr_sz;
 };
@@ -74,28 +79,71 @@ void amdgpu_trap_fini(struct amdgpu_device *adev);
 
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj);
-void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+
+void amdgpu_trap_free(struct amdgpu_device *adev,
+		      struct amdgpu_vm *vm,
+		      struct amdgpu_userq_mgr *uq_mgr,
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
+ * @uq_mgr: user queue manager for the process
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
+			       struct amdgpu_userq_mgr *uq_mgr,
+			       struct amdgpu_trap_obj *trap_obj,
+			       u64 tba_va, uint32_t tba_sz,
+			       u64 tma_va, uint32_t tma_sz);
+
+/**
+ * amdgpu_trap_vm_clear_l2_trap - clear the second-level trap handler
+ * @adev: AMDGPU device
+ * @vm: GPUVM owning the first-level trap state
+ * @uq_mgr: user queue manager for the process
+ * @trap_obj: first-level trap object
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_trap_obj *trap_obj);
+
 int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
-				    struct amdgpu_trap_obj *cwsr_obj,
+				    struct amdgpu_vm *vm,
+				    struct amdgpu_trap_obj *trap_obj,
 				    bool enabled);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index db09e879b85e..98f18c027b65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -997,7 +997,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
-static int
+int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
@@ -1005,13 +1005,14 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	int ret = 0, r;
 
 	mutex_lock(&uq_mgr->userq_mutex);
+
 	/* Resume all the queues for this process */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
-			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
+			trace_amdgpu_userq_state_changed(queue,
+							 AMDGPU_USERQ_STATE_INVALID_VA);
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
 			continue;
 		}
@@ -1020,11 +1021,14 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 		if (r)
 			ret = r;
 	}
+
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	if (ret)
 		drm_file_err(uq_mgr->file,
-			     "Failed to map all the queues, restore failed ret=%d\n", ret);
+			     "Failed to map all the queues, restore failed ret=%d\n",
+			     ret);
+
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
index 9e5fa6f53e59..42b2b09d05dd 100644
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

