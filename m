Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CC2C61DD6
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 12:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7C910E546;
	Fri,  4 Sep 2026 12:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vITyTwAq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFE010F8F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 12:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq66L8gbFWdmVfSV63KGQ8GUC7fcHAe6rjwTeKG4WxMxEfqSMunkcu6Q3Zn9Msucwq85cGMN8YFLTaakP9dHI/r2hpeVMfuFFEEHzpyfH9zNttzhfyu7xNdX7D3J95wBhds87loPMpMpWU/fDLqPTq+4leR+NsXfdXTkS3R6FIP4cQ7hLGgThGNZoxLvhGXM559CeXCQtGZIYmL1WEM1FEonKqI/8yIh+DrU384tL6FIl/aTat6nTahTKbTRev5jjfqfFpo5vCx115PnCVWIbADevWbQiGTeyQtgII4N+mzuV+A4Z9y2hFkliCZLOiZgLq07OzlCXEQ7teplDTCvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXrGE5A1/gjr2jKba9790+m+9j5TxY+23tXuw8JrzIA=;
 b=dd+g4l97+yosmf8J80+IsAk1lMr0ve+sxi7DFKD05kqqJJqg5ZxUCRQ/Z82PNgsEjzjjJWq+Bn/zUf5v6Rfj9+mIcnETt+046iEMjIwWTf5LBktHLv2xO9hGou2+9wThH7JcmlZf49UOGxFInfEd0nbEoxVF7mJnVUIpR4FNVZXSH9+amg3RNjNaTvrsDeTW6VdKG6p3vZf8SlWqS27F/FERruMjOaL6zb8ZjiMAkwCSOwNWVyTUYOPAptFPpCq+0bIkbdtvAt1+g891otxLt0gl/klXaAI/7BZaIaZSnPXiSvLOQdAXuWpQ3sdmqe/SBF7Ez0pcswyhKVNceJ2+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXrGE5A1/gjr2jKba9790+m+9j5TxY+23tXuw8JrzIA=;
 b=vITyTwAqQzs9iQ4YH+Z96xGRnx4FeDYgfWsbg9AkddFLUWyasouv2gxl6xgdbGAi6xaYfR7nTYrkrFsADgdHvTAKEz3xctwFcMi8tcfHRABMSpHJ0BCZMQ3FQA7ivXal9tZoIbLEAIKeya9sadx59/fUA/kw8PH5rT7vncnOk0Y=
Received: from PH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::14)
 by DS5PPFF2923D4C1.namprd12.prod.outlook.com (2603:10b6:f:fc00::669)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:59:45 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:34a:cafe::8e) by PH5P220CA0009.outlook.office365.com
 (2603:10b6:510:34a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 12:59:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Fri, 4 Sep 2026 12:59:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 07:59:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, Natalie Vock <natalie.vock@gmx.de>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add VM ioctl handlers for second-level trap
 handler
Date: Fri, 4 Sep 2026 18:29:22 +0530
Message-ID: <20260904125923.321117-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904125923.321117-1-srinivasan.shanmugam@amd.com>
References: <20260904125923.321117-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS5PPFF2923D4C1:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d1c231-e91b-4b06-6de0-08df0a8464de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|6133799003|18002099003|22082099003|56012099006|3023799007|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: /u6VAo5gF6wDGlCp4hJefGgrQz953HcJaMrBzwhKU8olq/CAyUXHaT0p4V5f31oF5brNPk1bjr3qr6lTKVcInwobTTNWQr2A1WbEnwr+zF+Pg7C1QsIzmrtuVeAiGnXAgrApyWEI86lEB3Nwi0Z7RsQPEJd60C9fHgJXYeUp7hVE5e3nX/hf92SWqygicBUOiNOkcNpGE68gT7JGhkkRTWrse/LRNGaNA/9YwAFrFaY2Y1J6jhzqlBLylRvWxlcAjDQnL50h+yASt04uLMZ8gYyQf1S33W9n5cHam1TeXwzvCTuk9sFYAVWuKIeLF8HstWnZF3FEahgNr9kb7r214oLOXmWvUii2t46u+cugq5D3XuN9UsHuMqbWhsXrY6NGxmwIQdlSqoYzWSJZu9vun6Ew6SjIVGWeAUBP7uosydCY5ONi5z6b6hFeq9nJ3SJDGvOtK9gM8SYqrUDxxV/SDoeMj2Sn7xYiNl0b86yridTW6vMfIj+XXm4Xagw8W/wDl2FW57cdZpANjgGcX1omHgkfZ37/ojX9dyyx4gj0u5dLZ5fE1gfYtxzSyorUdJZfUaG5iqnrXlTmN45g9xmbWxiYHBWehTdGrlIzrIfTP9MNSujEVnB6Q5TeldkhD6+JCxMoLtrQsqZ/H9cfOpFcB9udb8mwrXbLvnhL3OVt/4Z7BHPlnCuzE5j1Wkl8I84DJlTHDhqWLQKWejiHtpirHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wBbadZD7oa1FjesVpwX2MknqiLO2nKJvqi2/rd/MWjFSSOQDFe0KTIQTU7zJ0rMArlx/mGQDT5d3mFHGA4CfbMdudiE1sHvYNGpkxgUPAKHAKddU/voDYjbmkKJv/XWb3mIebMg6skfHl1GzESRd5Rol0Q8TMwQn2brbrYJ7k/JcBqPZvHPmfQBf2iwbZq01rdwbSpPGYg3Hp8ZcZD6X4hQMJuMw90dMIAhGDcyDwA5a+wCCHlOVQdZ/gIrYkXQwEaOQ6HmvWsnDMw8uac6m/qe30OiTY3KcpZTnFKUtw6KcSFwmDhRUt6cAg7bnJKx7/q+Q9J8X8k9gYf4GzyKgIMGqGq3NwPmlS/YlcN3HaiX7SkoLkVIZpFOoYL68w5M5pWegBccpnbMdlBRUlhi2OJywJ8NCV/RM58DQHGNoNAzwonVG+GKmy5AU9uUHIOpI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:59:45.2890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d1c231-e91b-4b06-6de0-08df0a8464de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF2923D4C1
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
Add it via the VM ioctl and fix several correctness issues in the CWSR
TMA access path.

On dGPUs the CWSR TMA buffer is placed in VRAM and accessed via MMIO
(PCI BAR). Raw CPU pointer dereferences are unsafe on platforms that
lack full load/store support for MMIO. Replace void *tma_cpu_addr with
struct iosys_map tma_map and use iosys_map_wr() for all TMA writes.

Writing TBA and TMA as two separate stores creates a race where a
trapping wave can observe a mismatched pair. Evict all user queues and
flush the GPU TLB before writing, then restore queues after.

Evict user queues in amdgpu_trap_free() at file close. Without eviction
a freed TMA BO can be accessed via a stale TBA, causing a GPU page fault.

Export amdgpu_userq_restore_all() for immediate queue restore after
SET/CLEAR without waiting for the eviction fence.

Add VM_ALWAYS_VALID validation in amdgpu_trap_validate_user_addr().
SET_L2_TRAP returns -EINVAL if TBA or TMA BO does not have this flag.

SET_L2_TRAP is per-VM (per-process). Each process has its own TMA buffer
allocated in amdgpu_trap_alloc(). There is no conflict between processes
on user queue VMIDs.

v2:
  - Add VM_ALWAYS_VALID validation in amdgpu_trap_validate_user_addr()
    (Natalie Vock).
  - Clarify per-VM exclusivity in kdoc (Lijo Lazar).
  - Remove lock/unlock from amdgpu_trap_validate_user_addr(); caller
    holds the VM root BO reservation.
  - Keep iosys_map for TMA writes (dGPU VRAM MMIO safety).
  - Keep evict-flush-write-restore sequence (race fix).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c      | 269 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h      |  61 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  25 ++
 7 files changed, 341 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 5ae477c49a53..cfd929a77ed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
+#include "amdgpu_userq.h"
 
 static const char *
 amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 47e4680db797..6cac465deb8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -646,8 +646,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
  * by disabling preemption and interrupts during the sampling.
  * Returns 0 on success.
  */
-static int amgpu_get_cpu_gpu_counters(struct amdgpu_device *adev,
-                               struct drm_amdgpu_info_clock_counters *args)
+static int amdgpu_get_cpu_gpu_counters(struct amdgpu_device *adev,
+				       struct drm_amdgpu_info_clock_counters *args)
 {
 	unsigned long flags;
 
@@ -820,7 +820,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		struct drm_amdgpu_info_clock_counters counters;
 
 		memset(&counters, 0, sizeof(counters));
-		amgpu_get_cpu_gpu_counters(adev, &counters);
+		amdgpu_get_cpu_gpu_counters(adev, &counters);
 		return copy_to_user(out, &counters, min(size, sizeof(counters))) ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_FW_VERSION: {
@@ -1716,7 +1716,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
-	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
+	/* VM root BO reservation released before this call. */
+	amdgpu_trap_free(adev, &fpriv->vm,
+			 &fpriv->userq_mgr, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 804b4b4f65bb..623cac6781be 100644
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
@@ -118,8 +129,6 @@ static void amdgpu_trap_cwsr_init_isa_details(struct amdgpu_device *adev,
 		trap_info->isa_buf = cwsr_trap_gfx10_hex;
 		trap_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
 	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
-		/* The gfx11 cwsr trap handler must fit inside a single
-			   page. */
 		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
 		trap_info->isa_buf = cwsr_trap_gfx11_hex;
 		trap_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
@@ -142,10 +151,10 @@ static uint32_t amdgpu_trap_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev
 	uint32_t vgpr_size;
 
 	switch (gc_ver) {
-	case IP_VERSION(9, 4, 1): /* GFX_VERSION_ARCTURUS */
-	case IP_VERSION(9, 4, 2): /* GFX_VERSION_ALDEBARAN */
-	case IP_VERSION(9, 4, 3): /* GFX_VERSION_AQUA_VANJARAM */
-	case IP_VERSION(9, 4, 4): /* GFX_VERSION_AQUA_VANJARAM */
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
 		vgpr_size = 0x80000;
 		break;
@@ -204,7 +213,7 @@ static void amdgpu_trap_cwsr_init_save_area_info(struct amdgpu_device *adev,
 	array_count = gfx_info->max_shader_engines * gfx_info->max_sh_per_se;
 
 	cu_num = adev->gfx.cu_info.number / NUM_XCC(adev->gfx.xcc_mask);
-	wave_num = (gc_ver < IP_VERSION(10, 1, 0)) ? /* GFX_VERSION_NAVI10 */
+	wave_num = (gc_ver < IP_VERSION(10, 1, 0)) ?
 			   min(cu_num * 40,
 			       array_count / gfx_info->max_sh_per_se * 512) :
 			   cu_num * 32;
@@ -218,11 +227,7 @@ static void amdgpu_trap_cwsr_init_save_area_info(struct amdgpu_device *adev,
 		      PAGE_SIZE);
 	dbg_mem_size =
 		ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
-	/*
-	* HW design limits control stack size to 0x7000.
-	* This is insufficient for theoretical PM4 cases
-	* but sufficient for AQL, limited by SPI events.
-	*/
+
 	if (IP_VERSION_MAJ(gc_ver) == 10)
 		ctl_stack_size = min(ctl_stack_size, 0x7000);
 
@@ -272,12 +277,6 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
 	adev->trap_info = NULL;
 }
 
-/*
- * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
- * it maps virtual address amdgpu_trap_tba_vaddr() to this VM, and each
- * compute queue can use this virtual address for wave save/restore
- * operations to support compute preemption.
- */
 static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
 				  struct amdgpu_trap_obj *cwsr,
@@ -380,6 +379,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_trap_obj *cwsr;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
+	void *cpu_addr;
 	int r;
 
 	if (!amdgpu_trap_is_enabled(adev))
@@ -407,10 +407,21 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
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
@@ -433,6 +444,29 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -447,11 +481,7 @@ int amdgpu_trap_validate_params(struct amdgpu_device *adev,
 
 	min_size = amdgpu_trap_size_needed(adev, num_xcc);
 	max_size = 2 * min_size;
-	/*
-	 * Only save area size details checked. Address validation needs to be
-	 * carried out separately. User is expected to pass a cwsr buffer area
-	 * with size >= ctl stack size + wg data size + debug memory size
-	 */
+
 	if (trap_params->cwsr_sz < min_size ||
 	    trap_params->cwsr_sz > max_size) {
 		dev_dbg(adev->dev,
@@ -464,6 +494,7 @@ int amdgpu_trap_validate_params(struct amdgpu_device *adev,
 }
 
 void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_trap_obj **trap_obj)
 {
 	struct amdgpu_bo *tba_bo;
@@ -473,53 +504,219 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
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
 	*trap_obj = NULL;
 }
 
+static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
+					  struct amdgpu_vm *vm,
+					  struct amdgpu_trap_usr_addr *usr_addr)
+{
+	struct amdgpu_bo *bo;
+	struct amdgpu_bo_va_mapping *va_map;
+	u64 addr;
+	u32 size;
+
+	/*
+	 * Caller holds the VM root BO reservation — assert rather than
+	 * taking it again.
+	 */
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
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
+	}
+
+	if (addr >= va_map->start && va_map->last - addr + 1 >= size)
+		return 0;
+
+	return -EINVAL;
+}
+
+int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
+			       struct amdgpu_userq_mgr *uq_mgr,
+			       struct amdgpu_trap_obj *trap_obj,
+			       u64 tba_va, uint32_t tba_sz,
+			       u64 tma_va, uint32_t tma_sz)
+{
+	struct amdgpu_trap_usr_addr tba = { .addr = tba_va, .size = tba_sz };
+	struct amdgpu_trap_usr_addr tma = { .addr = tma_va, .size = tma_sz };
+	int r;
+
+	if (!amdgpu_trap_is_enabled(adev))
+		return -EOPNOTSUPP;
+	if (!trap_obj || iosys_map_is_null(&trap_obj->tma_map))
+		return -EINVAL;
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
+	if (r)
+		return r;
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
+	if (r)
+		return r;
+
+	amdgpu_trap_clear_l2_handler(vm, trap_obj);
+	trap_obj->l2_trap_removed = false;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	amdgpu_userq_restore_all(uq_mgr);
+	return 0;
+}
+
+void amdgpu_trap_handle_l2_unmap(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct amdgpu_userq_mgr *uq_mgr,
+				 struct amdgpu_trap_obj *trap_obj,
+				 u64 addr, u64 size)
+{
+	bool tba_overlap, tma_overlap;
+
+	if (!trap_obj || !size || !uq_mgr)
+		return;
+
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	tba_overlap = trap_obj->l2_tba_size &&
+		      addr < trap_obj->l2_tba_addr + trap_obj->l2_tba_size &&
+		      trap_obj->l2_tba_addr < addr + size;
+	tma_overlap = trap_obj->l2_tma_size &&
+		      addr < trap_obj->l2_tma_addr + trap_obj->l2_tma_size &&
+		      trap_obj->l2_tma_addr < addr + size;
+
+	if (!tba_overlap && !tma_overlap)
+		return;
+
+	amdgpu_vm_wait_idle(vm, MAX_SCHEDULE_TIMEOUT);
+	amdgpu_userq_evict(uq_mgr);
+	amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
+	amdgpu_trap_clear_l2_handler(vm, trap_obj);
+	trap_obj->l2_trap_removed = true;
+}
 
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
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 495ffd3f1dd8..7f83174a4742 100644
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
@@ -75,7 +93,48 @@ void amdgpu_trap_fini(struct amdgpu_device *adev);
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj);
 void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_trap_obj **trap_obj);
+
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
 static inline bool amdgpu_trap_is_enabled(struct amdgpu_device *adev)
 {
 	return adev->trap_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index db09e879b85e..cf8e69aa917b 100644
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
@@ -1016,6 +1017,19 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 			continue;
 		}
 
+		/*
+		 * If the second-level trap handler TBA or TMA was forcibly
+		 * removed by GEM_VA UNMAP without CLEAR_L2_TRAP, do not
+		 * restart the queue. A queue must not run without a valid
+		 * resident trap handler if one was previously configured.
+		 */
+		if (amdgpu_trap_l2_was_removed(fpriv->trap_obj)) {
+			trace_amdgpu_userq_state_changed(queue,
+							 AMDGPU_USERQ_STATE_INVALID_VA);
+			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+			continue;
+		}
+
 		r = amdgpu_userq_map_helper(queue);
 		if (r)
 			ret = r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 3e19bc6103a0..bfab84ab8e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -162,8 +162,8 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
 void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
-
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
+int amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 930b744c5f5f..de3ef9ce2234 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -36,6 +36,7 @@
 #include <drm/ttm/ttm_tt.h>
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
@@ -2893,6 +2894,30 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
+	case AMDGPU_VM_OP_SET_L2_TRAP:
+		/*
+		 * Install or replace the per-VM second-level trap handler.
+		 * Applies to all shader waves under this VMID.
+		 */
+		if (!fpriv->trap_obj)
+			return -EOPNOTSUPP;
+		return amdgpu_trap_vm_set_l2_trap(adev, vm,
+						  &fpriv->userq_mgr,
+						  fpriv->trap_obj,
+						  args->in.l2trap.tba_va,
+						  args->in.l2trap.tba_sz,
+						  args->in.l2trap.tma_va,
+						  args->in.l2trap.tma_sz);
+	case AMDGPU_VM_OP_CLEAR_L2_TRAP:
+		/*
+		 * Disable the per-VM second-level trap handler.
+		 * Waits for VM idle, evicts queues, flushes TLB, clears handler.
+		 */
+		if (!fpriv->trap_obj)
+			return -EOPNOTSUPP;
+		return amdgpu_trap_vm_clear_l2_trap(adev, vm,
+						    &fpriv->userq_mgr,
+						    fpriv->trap_obj);
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1

