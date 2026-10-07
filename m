Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA68CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CE510F501;
	Wed,  7 Oct 2026 11:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cAYxqZhU";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC10C10F501
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 11:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oudFLcxiXnjnt+Sp285V5o99g0vqSgl/zPBQ8lIbd1OcnkS2UMe0ecW/y+OmtNYjMcl11RbCpEQHibu5GiODT1Bts07R1OFsometH/1WjOKGqGiUCAWzQqAkQ/fAmuKYHY5L7Bn7w05rAAkHytppd+61HQAiIM9Vpev7sz9TQiJQG3kji/QVMXb3zTtw1luJ4S1bbvYh+9CsyCf28gKBF/h4P0zHVdmN8N3KwLNYc74C0wZIkTQP+J+y5F85MWAiuDlduarBW2x7fomz9fwv1lJffFcvpB2a4DDl7gXyGQuxI3GEgu3kezkeIcXVY8Z6Z4/Mrh87JXrp5IN0Az22wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSA7zrsDlr7uud9XHfSNGrjex6amfszDlWmRpivh5SA=;
 b=a30l+HU81grfRkKmw+wGtAh5CfHYnyAG2EIE68p2S4PMzYSmQIuscnaQ63sNNSujl/HkzvAajNQlAkzTleRE/lhK6knvPT8ENQcdZd7KSQLzXaA1hJU+a8MbzkKkNlEzylO548xKHCl97euRXuXniE2XmqdX1+IMqfYEeh7x83VXp5skogWWl5PQ9ppAEifMaySG4PCSjtk7PT7IB32RshOROpeGTDqXLsoHW1W4dJTzQgQzjG/hOHnJPyGd85sZ2kdzOL4H3qAdppiTGASXiATW99Lf5sQg+CJkLzOs0xigQ4E/iqW3HBtbMwyJBB037n7AgZkumkZz28S989cKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSA7zrsDlr7uud9XHfSNGrjex6amfszDlWmRpivh5SA=;
 b=cAYxqZhUdHG3oY5wYkwqbbVzhfA1QIcRNkQpVZdIlMlg4RE2VCLKgBvGHG1A4JR6y0WvRmkMpTZgz2yRsW4Kjm6nORFaTmJq//ksPmqBISCaQCZpNvPEq0vop8aPAqLS/m2+yk5gCF/xLv0ZhvdpXqEzVlQv/d234HVCekaiXyc=
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 7 Oct
 2026 11:05:40 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::b) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 11:05:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 11:05:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:05:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: Rename amdgpu_cwsr to amdgpu_trap
Date: Wed, 7 Oct 2026 16:35:06 +0530
Message-ID: <20261007110506.1065076-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
References: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 8126e7cb-bc31-459a-fff5-08df2462ecd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|56012099006|6133799003|11063799006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nCvrU5GwyEh1t2m5eZaw6pxOsT5c7MiOr0xTQZQy5gMGV0Rz7VrHUWSFPR/UMfpfouAWMy8X//Nos6n8qwocgOqnZe2IJttOSOZ1KGwr5rN8zR4AiHlpH/VDNZmJYQTtpcjlaICl2QhJ0QcLqcq73lQHnQR+OIKv4jq6uqlAecMPJvDEWWxhDmKpLafu/Ee0+Dxjtr0osrABMyJ8I5zFqwJOS9EsvUAyLRn7cyGxcMF5eRzAaJuqIpoNDY6I6dBufHpxNcwVADzOT01qgtgPNSXwFg41RK/PVxEQ8b0mtBp86cwe6QdEVsmMNxyp569sEdKcrWz8cHryQw5JLJseLBXSI9FjQWA8d208gM7hafdT5dzm3uapa3kdLU4GK76IuwAzRK7S2A5LtJUuNebbC6HcggEJdcPVfVKQlns9vVpX87gvkzN+DtQ7Y5d5F0NiHgtslWvZPvi5fd/cB7RipHsDxp2f4R2nOQlmWQFUmqBWR9+A2PFGVmCVvzsRijr2UMr1WsIWj6Qpuc998/HpduJh/IY4N73oLsd8BOFnivajp6k2bb0ztOHPF4hlLTnx0iUzz1MZgqFOSRMe0j0YYJQ/T2BN2VHj8CtBCUSx0ZzJCQaJWfOKrexDC0JcdNVmzKAMcd2U2f9tJDK6SASZqwqIbFkqgvbGXKnZece6BdxCiEhdNnMFouIaUCqkDl+/AAbHTsfGyragy5mu9LvsyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(56012099006)(6133799003)(11063799006)(10067099003)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0b3M6duSs6hMS9w7lN1SJnyNWtyL7tLY3HCtnpCoDvsL38u43BenETcKp3JbZyJr1Uc/DdhUtHU3S8f6PSbDz9Ce2PR6GaC/zh9UWmY1OGYY7UCs9AhskVTkDUUHPno/KNURggF/305MPjHcTb4qKd18ecyq3svzumuZssYvsnUCs1tyoG6J5nJfd29dz3dcKHDLDkwcH0QqNnoBuFyeVrYxK9wTE1veUmrK3G0y59GmNn305rbt+PuSQuZ0bwNXnTBeBQqBQNZ1gstmCoLpoqpdbSI9+/6x8nGN+ixY+Cn2S3N4K6YHCzoZmYXaOmtKSCeIIu7rIrm5chUVMITENi09fnQT9ML8dkOvvuazoxYkp4ZEtnFAHA3WMQyt251k2tklHlnOphCT+Mo/Zxy++MtlxO1YNmf1N9N823IDjv94QB6uGlQ8urAKRe6FdVXW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:05:40.7574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8126e7cb-bc31-459a-fff5-08df2462ecd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
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

CWSR (Compute Wave Save Restore) is only the context save/restore
feature. The level 1 trap handler manages CWSR as well as the
second-level userspace trap handler added for render-node user queues.
Keeping the file and ioctl named after CWSR is misleading now that the
code manages both levels of trap handling.

Rename files and ioctl to reflect the broader trap handler scope so
future trap handler features have a natural home without further naming
confusion.

  amdgpu_cwsr.c         → amdgpu_trap.c
  amdgpu_cwsr.h         → amdgpu_trap.h
  AMDGPU_CWSR ioctl     → AMDGPU_TRAP ioctl
  amdgpu_cwsr_* symbols → amdgpu_trap_* symbols

The cwsr_enable module parameter and cwsr_trap_handler.h ISA binaries
are not renamed — they are specific to the CWSR context save feature.

v2 (Alex):
- Group the CWSR save area size fields into a nested 'cwsr' struct
  inside amdgpu_trap_info. This keeps CWSR-specific data visually
  separated from the broader trap handler infrastructure and makes
  it clear which fields belong to CWSR vs future trap features.
- Keep the local variable name 'cwsr_info' in amdgpu_kms.c since
  that code only deals with CWSR save area sizes. Renaming it
  'trap_info' was misleading as it has nothing to do with trap
  handlers in general.
- Rename cwsr_params to trap_params and rename the function
  amdgpu_userq_input_cwsr_params_validate() to
  amdgpu_userq_input_trap_params_validate(). The parameter type was
  already renamed to amdgpu_trap_params but the variable name was
  still cwsr_params, causing a mismatch.
- Rename static CWSR-specific helper functions to include 'cwsr' in
  the name: amdgpu_trap_cwsr_get_vgpr_size_per_cu(),
  amdgpu_trap_cwsr_get_wg_ctxt_size_per_cu(), and
  amdgpu_trap_cwsr_init_save_area_info() to make clear they are
  CWSR-specific and not generic trap handler helpers.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Change-Id: Id10a09f339c4ca06b70246afa22754f9547a30dc
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  18 +-
 .../amdgpu/{amdgpu_cwsr.c => amdgpu_trap.c}   | 271 +++++++++---------
 .../amdgpu/{amdgpu_cwsr.h => amdgpu_trap.h}   |  52 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   7 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  24 +-
 include/uapi/drm/amdgpu_drm.h                 |  14 +-
 11 files changed, 209 insertions(+), 210 deletions(-)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.c => amdgpu_trap.c} (63%)
 rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.h => amdgpu_trap.h} (63%)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 5086a482daf1..28bd81f0f720 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o amdgpu_cwsr.o
+	amdgpu_wb.o amdgpu_trap.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bdd55ac5b06e..e55496f5ecdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -332,8 +332,8 @@ struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
-struct amdgpu_cwsr_isa;
-struct amdgpu_cwsr_trap_obj;
+struct amdgpu_trap_isa;
+struct amdgpu_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -422,7 +422,7 @@ struct amdgpu_fpriv {
 	struct xarray		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
-	struct amdgpu_cwsr_trap_obj *cwsr_trap;
+	struct amdgpu_trap_obj *trap_obj;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
@@ -978,7 +978,7 @@ struct amdgpu_device {
 	 */
 	struct amdgpu_kfd_dev		kfd;
 
-	struct amdgpu_cwsr_info *cwsr_info;
+	struct amdgpu_trap_info *trap_info;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5a7f111763bf..6bac724fc73f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,7 +81,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
-#include "amdgpu_cwsr.h"
+#include "amdgpu_trap.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -2551,7 +2551,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	r = amdgpu_cper_init(adev);
 
 	if (!r) {
-		r = amdgpu_cwsr_init(adev);
+		r = amdgpu_trap_init(adev);
 		if (r == -EOPNOTSUPP)
 			r = 0;
 	}
@@ -2953,7 +2953,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	amdgpu_cwsr_fini(adev);
+	amdgpu_trap_fini(adev);
 	amdgpu_cper_fini(adev);
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7a2b97d9f51a..e8231ef463a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -52,7 +52,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userq.h"
-#include "amdgpu_cwsr.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 #include "amdgpu_ualink.h"
@@ -3123,7 +3123,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
 	/* KMS */
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 147c0bd02731..6839d92b9730 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -50,7 +50,7 @@
 #include "amdgpu_video_codecs.h"
 #include "amdgpu_ras_mgr.h"
 #include "amdgpu_vm.h"
-#include "amdgpu_cwsr.h"
+#include "amdgpu_trap.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1434,15 +1434,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		int num_xcc, r;
 
 		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
-		if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
+		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
 			return -EOPNOTSUPP;
 		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
 		cwsr_info.ctl_stack_size =
-			adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+			adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
 		cwsr_info.dbg_mem_size =
-			adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
+			adev->trap_info->cwsr.xcc_dbg_mem_sz * num_xcc;
 		cwsr_info.min_save_area_size =
-			amdgpu_cwsr_size_needed(adev, num_xcc);
+			amdgpu_trap_size_needed(adev, num_xcc);
 		r = copy_to_user(out, &cwsr_info,
 				 min((size_t)size, sizeof(cwsr_info))) ?
 			    -EFAULT :
@@ -1576,10 +1576,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 
-	if (amdgpu_cwsr_is_enabled(adev)) {
-		r = amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap);
+	if (amdgpu_trap_is_enabled(adev)) {
+		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
 		if (r)
-			dev_dbg(adev->dev, "cwsr trap not enabled");
+			dev_dbg(adev->dev, "trap handler not enabled");
 	}
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
@@ -1651,7 +1651,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
-	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
+	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
similarity index 63%
rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 836bb5e314af..4948d967db47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -23,13 +23,13 @@
 
 #include "amdgpu.h"
 #include "cwsr_trap_handler.h"
-#include "amdgpu_cwsr.h"
+#include "amdgpu_trap.h"
 
 extern int cwsr_enable;
 
-#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
-#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
-#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
+#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
 
 #define SGPR_SIZE_PER_CU 0x4000
 #define LDS_SIZE_PER_CU 0x10000
@@ -38,12 +38,12 @@ extern int cwsr_enable;
 #define DEBUGGER_BYTES_PER_WAVE 32
 #define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
 
-enum amdgpu_cwsr_region {
-	AMDGPU_CWSR_TBA,
-	AMDGPU_CWSR_TMA,
+enum amdgpu_trap_region {
+	AMDGPU_TRAP_TBA,
+	AMDGPU_TRAP_TMA,
 };
 
-static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
+static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
 {
 	uint64_t addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
 
@@ -52,7 +52,7 @@ static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
 	return addr;
 }
 
-static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
+static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 
@@ -63,80 +63,80 @@ static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
 	return true;
 }
 
-uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
+uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc)
 {
-	if (!amdgpu_cwsr_is_enabled(adev))
+	if (!amdgpu_trap_is_enabled(adev))
 		return 0;
 
 	return num_xcc *
-	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
+	       (adev->trap_info->cwsr.xcc_cwsr_sz + adev->trap_info->cwsr.xcc_dbg_mem_sz);
 }
 
-static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
-					 struct amdgpu_cwsr_info *cwsr_info)
+static void amdgpu_trap_cwsr_init_isa_details(struct amdgpu_device *adev,
+					      struct amdgpu_trap_info *trap_info)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 
 	if (gc_ver < IP_VERSION(9, 0, 1)) {
 		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
-			     AMDGPU_CWSR_TBA_MAX_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_gfx8_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx8_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
 	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
 		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
-			     AMDGPU_CWSR_TBA_MAX_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_arcturus_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_arcturus_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
 	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
 		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
-			     AMDGPU_CWSR_TBA_MAX_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_aldebaran_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_aldebaran_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
 	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
 		   gc_ver == IP_VERSION(9, 4, 4)) {
 		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
-			     AMDGPU_CWSR_TBA_MAX_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
 	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
 		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
+		trap_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
 	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
 		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
-			     AMDGPU_CWSR_TBA_MAX_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_gfx9_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx9_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
 	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
 		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
-			     AMDGPU_CWSR_TBA_MAX_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_nv1x_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_nv1x_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
 	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
 		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
-			     AMDGPU_CWSR_TBA_MAX_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_gfx10_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx10_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
 	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
 		/* The gfx11 cwsr trap handler must fit inside a single
 			   page. */
 		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
+		trap_info->isa_buf = cwsr_trap_gfx11_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
 	} else if (gc_ver < IP_VERSION(12, 1, 0)) {
 		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
-			     AMDGPU_CWSR_TBA_MAX_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx12_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
 	} else {
 		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
-			     AMDGPU_CWSR_TBA_MAX_SIZE);
-		cwsr_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
-		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
+			     AMDGPU_TRAP_TBA_MAX_SIZE);
+		trap_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
+		trap_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
 	}
 }
 
-static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
+static uint32_t amdgpu_trap_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 	uint32_t vgpr_size;
@@ -164,7 +164,7 @@ static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
 	return vgpr_size;
 }
 
-static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
+static uint32_t amdgpu_trap_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
 {
 	uint32_t lds_sz_per_cu;
 
@@ -173,11 +173,11 @@ static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
 			(adev->gfx.cu_info.lds_size << 10) :
 			LDS_SIZE_PER_CU;
 
-	return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
+	return amdgpu_trap_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
 	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
 }
 
-static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
+static uint32_t amdgpu_trap_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
 {
 	uint32_t sz;
 
@@ -188,8 +188,8 @@ static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
 	return sz;
 }
 
-static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
-					    struct amdgpu_cwsr_info *cwsr_info)
+static void amdgpu_trap_cwsr_init_save_area_info(struct amdgpu_device *adev,
+						 struct amdgpu_trap_info *trap_info)
 {
 	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
@@ -209,10 +209,10 @@ static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
 			       array_count / gfx_info->max_sh_per_se * 512) :
 			   cu_num * 32;
 
-	wg_data_size = ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_cu(adev),
+	wg_data_size = ALIGN(cu_num * amdgpu_trap_cwsr_get_wg_ctxt_size_per_cu(adev),
 			     PAGE_SIZE);
 	ctl_stack_size =
-		wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
+		wave_num * amdgpu_trap_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
 	ctl_stack_size =
 		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
 		      PAGE_SIZE);
@@ -226,62 +226,62 @@ static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
 	if (IP_VERSION_MAJ(gc_ver) == 10)
 		ctl_stack_size = min(ctl_stack_size, 0x7000);
 
-	cwsr_info->xcc_ctl_stack_sz = ctl_stack_size;
-	cwsr_info->xcc_cwsr_sz = ctl_stack_size + wg_data_size;
-	cwsr_info->xcc_dbg_mem_sz = dbg_mem_size;
+	trap_info->cwsr.xcc_ctl_stack_sz = ctl_stack_size;
+	trap_info->cwsr.xcc_cwsr_sz = ctl_stack_size + wg_data_size;
+	trap_info->cwsr.xcc_dbg_mem_sz = dbg_mem_size;
 }
 
-int amdgpu_cwsr_init(struct amdgpu_device *adev)
+int amdgpu_trap_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_cwsr_info *cwsr_info __free(kfree) =
-		kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
+	struct amdgpu_trap_info *trap_info __free(kfree) =
+		kzalloc(sizeof(*trap_info), GFP_KERNEL);
 	void *ptr;
 	int r;
 
-	if (!amdgpu_cwsr_is_supported(adev))
+	if (!amdgpu_trap_is_supported(adev))
 		return -EOPNOTSUPP;
 
-	if (!cwsr_info)
+	if (!trap_info)
 		return -ENOMEM;
-	amdgpu_cwsr_init_isa_details(adev, cwsr_info);
+	amdgpu_trap_cwsr_init_isa_details(adev, trap_info);
 
-	if (!cwsr_info->isa_sz)
+	if (!trap_info->isa_sz)
 		return -EOPNOTSUPP;
 
-	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->isa_bo,
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TBA_MAX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &trap_info->isa_bo,
 				    NULL, &ptr);
 	if (r)
 		return r;
 
-	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
+	memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
 
-	amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
-	adev->cwsr_info = no_free_ptr(cwsr_info);
+	amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
+	adev->trap_info = no_free_ptr(trap_info);
 
 	return 0;
 }
 
-void amdgpu_cwsr_fini(struct amdgpu_device *adev)
+void amdgpu_trap_fini(struct amdgpu_device *adev)
 {
-	if (!amdgpu_cwsr_is_enabled(adev))
+	if (!amdgpu_trap_is_enabled(adev))
 		return;
 
-	amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
-	kfree(adev->cwsr_info);
-	adev->cwsr_info = NULL;
+	amdgpu_bo_free_kernel(&adev->trap_info->isa_bo, NULL, NULL);
+	kfree(adev->trap_info);
+	adev->trap_info = NULL;
 }
 
 /*
  * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
- * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, and each
+ * it maps virtual address amdgpu_trap_tba_vaddr() to this VM, and each
  * compute queue can use this virtual address for wave save/restore
  * operations to support compute preemption.
  */
-static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
+static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
-				  struct amdgpu_cwsr_trap_obj *cwsr,
-				  enum amdgpu_cwsr_region region)
+				  struct amdgpu_trap_obj *cwsr,
+				  enum amdgpu_trap_region region)
 {
 	uint64_t cwsr_addr, va_flags, va;
 	struct amdgpu_bo_va **bo_va;
@@ -292,20 +292,20 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
 	if (!cwsr || !vm)
 		return -EINVAL;
 
-	cwsr_addr = amdgpu_cwsr_tba_vaddr(adev);
+	cwsr_addr = amdgpu_trap_tba_vaddr(adev);
 
-	if (region == AMDGPU_CWSR_TBA) {
-		size = AMDGPU_CWSR_TBA_MAX_SIZE;
+	if (region == AMDGPU_TRAP_TBA) {
+		size = AMDGPU_TRAP_TBA_MAX_SIZE;
 		bo_va = &cwsr->tba_va;
-		bo = adev->cwsr_info->isa_bo;
+		bo = adev->trap_info->isa_bo;
 		va = cwsr_addr;
 		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
 			    AMDGPU_VM_PAGE_EXECUTABLE);
 	} else {
-		size = AMDGPU_CWSR_TMA_MAX_SIZE;
+		size = AMDGPU_TRAP_TMA_MAX_SIZE;
 		bo_va = &cwsr->tma_va;
 		bo = cwsr->tma_bo;
-		va = cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
+		va = cwsr_addr + AMDGPU_TRAP_TMA_OFFSET;
 		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
 	}
 
@@ -317,7 +317,7 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
 	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
-			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
+			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		*bo_va = NULL;
 		return r;
@@ -327,13 +327,13 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
 	if (r) {
 		dev_err(adev->dev,
 			"failed to do page table update of %s region, err=%d\n",
-			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
+			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		*bo_va = NULL;
 		return r;
 	}
 
-	if (region == AMDGPU_CWSR_TBA)
+	if (region == AMDGPU_TRAP_TBA)
 		cwsr->tba_gpu_va_addr = va;
 	else
 		cwsr->tma_gpu_va_addr = va;
@@ -341,9 +341,9 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
-				    struct amdgpu_cwsr_trap_obj *cwsr,
-				    enum amdgpu_cwsr_region region)
+static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
+				    struct amdgpu_trap_obj *cwsr,
+				    enum amdgpu_trap_region region)
 {
 	struct amdgpu_bo_va **bo_va;
 	uint64_t va;
@@ -352,7 +352,7 @@ static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
 	if (!cwsr)
 		return -EINVAL;
 
-	if (region == AMDGPU_CWSR_TBA) {
+	if (region == AMDGPU_TRAP_TBA) {
 		bo_va = &cwsr->tba_va;
 		va = cwsr->tba_gpu_va_addr;
 	} else {
@@ -374,16 +374,16 @@ static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
 	return r;
 }
 
-int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		      struct amdgpu_cwsr_trap_obj **trap_obj)
+int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_trap_obj **trap_obj)
 {
 	struct amdgpu_bo_param bp;
-	struct amdgpu_cwsr_trap_obj *cwsr;
+	struct amdgpu_trap_obj *cwsr;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
 	int r;
 
-	if (!amdgpu_cwsr_is_enabled(adev))
+	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 	if (!vm || !trap_obj)
 		return -EINVAL;
@@ -392,7 +392,7 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!cwsr)
 		return -ENOMEM;
 
-	bo = adev->cwsr_info->isa_bo;
+	bo = adev->trap_info->isa_bo;
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
@@ -411,10 +411,10 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 * Create TMA BO using the VM's already-locked resv so no new
 	 * reservation_ww_class_mutex acquisition is needed, avoiding the
 	 * recursive ww_mutex deadlock. Unpinned; eviction is handled via
-	 * amdgpu_vm_bo_add() inside amdgpu_cwsr_map_region().
+	 * amdgpu_vm_bo_add() inside amdgpu_trap_map_region().
 	 */
 	memset(&bp, 0, sizeof(bp));
-	bp.size = AMDGPU_CWSR_TMA_MAX_SIZE;
+	bp.size = AMDGPU_TRAP_TMA_MAX_SIZE;
 	bp.byte_align = PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
 	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
@@ -432,15 +432,15 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto err_tma;
 
-	memset(cwsr->tma_cpu_addr, 0, AMDGPU_CWSR_TMA_MAX_SIZE);
+	memset(cwsr->tma_cpu_addr, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
 
-	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
+	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
 	if (r)
 		goto err_kmap;
 
-	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
+	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
 	if (r) {
-		amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
+		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
 		goto err_kmap;
 	}
 
@@ -459,38 +459,38 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
-int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
-				struct amdgpu_cwsr_params *cwsr_params,
+int amdgpu_trap_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_trap_params *trap_params,
 				int num_xcc)
 {
 	uint32_t min_size, max_size;
 
-	if (!amdgpu_cwsr_is_enabled(adev))
+	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
-	if (!cwsr_params)
+	if (!trap_params)
 		return -EINVAL;
 
-	min_size = amdgpu_cwsr_size_needed(adev, num_xcc);
+	min_size = amdgpu_trap_size_needed(adev, num_xcc);
 	max_size = 2 * min_size;
 	/*
 	 * Only save area size details checked. Address validation needs to be
 	 * carried out separately. User is expected to pass a cwsr buffer area
 	 * with size >= ctl stack size + wg data size + debug memory size
 	 */
-	if (cwsr_params->cwsr_sz < min_size ||
-	    cwsr_params->cwsr_sz > max_size) {
+	if (trap_params->cwsr_sz < min_size ||
+	    trap_params->cwsr_sz > max_size) {
 		dev_dbg(adev->dev,
 			"queue cwsr size 0x%x should be within min %u : max %u\n",
-			cwsr_params->cwsr_sz, min_size, max_size);
+			trap_params->cwsr_sz, min_size, max_size);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		      struct amdgpu_cwsr_trap_obj **trap_obj)
+void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_trap_obj **trap_obj)
 {
 	struct amdgpu_bo *tba_bo;
 	struct amdgpu_bo *tma_bo;
@@ -500,7 +500,7 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
 		return;
 
-	tba_bo = adev->cwsr_info->isa_bo;
+	tba_bo = adev->trap_info->isa_bo;
 	tma_bo = (*trap_obj)->tma_bo;
 
 	if (!tba_bo || !tma_bo)
@@ -519,8 +519,8 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		}
 	}
 
-	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
-	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
+	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TBA);
+	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
 
 err:
 	drm_exec_fini(&exec);
@@ -532,9 +532,9 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	*trap_obj = NULL;
 }
 
-static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
+static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
 					  struct amdgpu_vm *vm,
-					  struct amdgpu_cwsr_usr_addr *usr_addr)
+					  struct amdgpu_trap_usr_addr *usr_addr)
 {
 	struct amdgpu_bo_va_mapping *va_map;
 	uint64_t addr;
@@ -566,23 +566,23 @@ static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
 	return r;
 }
 
-static int amdgpu_cwsr_set_l2_trap_handler(
-	struct amdgpu_device *adev, struct amdgpu_vm *vm,
-	struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_addr *tma,
-	struct amdgpu_cwsr_usr_addr *tba)
+static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+					   struct amdgpu_trap_obj *cwsr_obj,
+					   struct amdgpu_trap_usr_addr *tma,
+					   struct amdgpu_trap_usr_addr *tba)
 {
 	uint64_t *l1tma;
 	int r;
 
-	if (!amdgpu_cwsr_is_enabled(adev))
+	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
 	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
 		return -EINVAL;
-	r = amdgpu_cwsr_validate_user_addr(adev, vm, tma);
+	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
 	if (r)
 		return r;
-	r = amdgpu_cwsr_validate_user_addr(adev, vm, tba);
+	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
 	if (r)
 		return r;
 
@@ -594,10 +594,10 @@ static int amdgpu_cwsr_set_l2_trap_handler(
 }
 
 /*
- * Userspace cwsr related ioctl
+ * Userspace trap handler related ioctl
  */
 /**
- * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
+ * amdgpu_trap_ioctl - Handle trap handler specific requests.
  *
  * @dev: drm device pointer
  * @data: request object
@@ -606,29 +606,28 @@ static int amdgpu_cwsr_set_l2_trap_handler(
  * This function is used to perform cwsr and trap handler related operations
  * Returns 0 on success, error code on failure.
  */
-int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+int amdgpu_trap_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	union drm_amdgpu_cwsr *cwsr = data;
+	union drm_amdgpu_trap *cwsr = data;
 	struct amdgpu_fpriv *fpriv;
 	int r;
 
 	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
 
-	if (!fpriv->cwsr_trap)
+	if (!fpriv->trap_obj)
 		return -EOPNOTSUPP;
 
 	switch (cwsr->in.op) {
-	case AMDGPU_CWSR_OP_SET_L2_TRAP: {
-		struct amdgpu_cwsr_usr_addr tba;
-		struct amdgpu_cwsr_usr_addr tma;
+	case AMDGPU_TRAP_OP_SET_L2_TRAP: {
+		struct amdgpu_trap_usr_addr tba;
+		struct amdgpu_trap_usr_addr tma;
 
 		tba.addr = cwsr->in.l2trap.tba_va;
 		tba.size = cwsr->in.l2trap.tba_sz;
 		tma.addr = cwsr->in.l2trap.tma_va;
 		tma.size = cwsr->in.l2trap.tma_sz;
-		r = amdgpu_cwsr_set_l2_trap_handler(
-			adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
+		r = amdgpu_trap_set_l2_trap_handler(adev, &fpriv->vm, fpriv->trap_obj, &tma, &tba);
 	} break;
 	default:
 		return -EINVAL;
@@ -637,13 +636,13 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return r;
 }
 
-int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
-				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
+int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
+				    struct amdgpu_trap_obj *cwsr_obj,
 				    bool enabled)
 {
 	uint64_t *l1tma;
 
-	if (!amdgpu_cwsr_is_enabled(adev))
+	if (!amdgpu_trap_is_enabled(adev))
 		return -EOPNOTSUPP;
 
 	if (!cwsr_obj)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
similarity index 63%
rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 06036954627e..6d4664469bad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -20,8 +20,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#ifndef AMDGPU_CWSR_H
-#define AMDGPU_CWSR_H
+#ifndef AMDGPU_TRAP_H
+#define AMDGPU_TRAP_H
 
 #include <linux/types.h>
 
@@ -31,11 +31,11 @@ struct amdgpu_device;
 struct amdgpu_vm;
 
 /**
- * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
+ * struct amdgpu_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
  * @bo: Buffer object for CWSR area
  * @bo_va: Buffer object virtual address mapping
  */
-struct amdgpu_cwsr_trap_obj {
+struct amdgpu_trap_obj {
 	uint64_t tma_gpu_va_addr;
 	uint64_t tba_gpu_va_addr;
 
@@ -45,55 +45,57 @@ struct amdgpu_cwsr_trap_obj {
 	void *tma_cpu_addr;
 };
 
-struct amdgpu_cwsr_info {
+struct amdgpu_trap_info {
 	/* cwsr isa */
 	struct amdgpu_bo *isa_bo;
 	const void *isa_buf;
 	uint32_t isa_sz;
 	/* cwsr size info per XCC*/
-	uint32_t xcc_ctl_stack_sz;
-	uint32_t xcc_dbg_mem_sz;
-	uint32_t xcc_cwsr_sz;
+	struct {
+		uint32_t xcc_ctl_stack_sz;
+		uint32_t xcc_dbg_mem_sz;
+		uint32_t xcc_cwsr_sz;
+	} cwsr;
 };
 
-struct amdgpu_cwsr_params {
+struct amdgpu_trap_params {
 	uint64_t ctx_save_area_address;
 	/* cwsr size info */
 	uint32_t cwsr_sz;
 };
 
-struct amdgpu_cwsr_usr_addr {
+struct amdgpu_trap_usr_addr {
 	uint64_t addr;
 	uint32_t size;
 };
 
-int amdgpu_cwsr_init(struct amdgpu_device *adev);
-void amdgpu_cwsr_fini(struct amdgpu_device *adev);
+int amdgpu_trap_init(struct amdgpu_device *adev);
+void amdgpu_trap_fini(struct amdgpu_device *adev);
 
-int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
-void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
-static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
+int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_trap_obj **trap_obj);
+void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_trap_obj **trap_obj);
+static inline bool amdgpu_trap_is_enabled(struct amdgpu_device *adev)
 {
-	return adev->cwsr_info != NULL;
+	return adev->trap_info;
 }
 
-uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
-int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
-				struct amdgpu_cwsr_params *cwsr_params,
+uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc);
+int amdgpu_trap_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_trap_params *trap_params,
 				int num_xcc);
-static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
+static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 
 	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
 }
 
-int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
+int amdgpu_trap_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
-int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
-				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
+int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
+				    struct amdgpu_trap_obj *cwsr_obj,
 				    bool enabled);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6eea0ca40556..b4c91e8cd37e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -35,7 +35,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
-#include "amdgpu_cwsr.h"
+#include "amdgpu_trap.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -267,9 +267,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
-int amdgpu_userq_input_cwsr_params_validate(
-	struct amdgpu_usermode_queue *queue,
-	struct amdgpu_cwsr_params *cwsr_params)
+int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
+					    struct amdgpu_trap_params *trap_params)
 {
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
 	struct amdgpu_device *adev = queue->userq_mgr->adev;
@@ -278,16 +277,16 @@ int amdgpu_userq_input_cwsr_params_validate(
 	int r;
 
 	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
-	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
+	r = amdgpu_trap_validate_params(queue->userq_mgr->adev, trap_params,
 					num_xcc);
 	if (r)
 		return r;
-	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
+	cwsr_size = amdgpu_trap_size_needed(queue->userq_mgr->adev, num_xcc);
 	if (!cwsr_size)
 		return -EOPNOTSUPP;
 
 	return amdgpu_userq_input_va_validate(
-		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size,
+		adev, queue, trap_params->ctx_save_area_address, cwsr_size,
 		&queue->userq_vas.va.cwsr);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 727f60c40bbf..5eb0f3ee9b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -41,7 +41,7 @@ enum amdgpu_userq_state {
 };
 
 struct amdgpu_mqd_prop;
-struct amdgpu_cwsr_params;
+struct amdgpu_trap_params;
 
 struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
@@ -202,8 +202,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 
 void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 					struct amdgpu_bo_va_mapping *mapping);
-int amdgpu_userq_input_cwsr_params_validate(
-	struct amdgpu_usermode_queue *queue,
-	struct amdgpu_cwsr_params *cwsr_params);
+int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
+					    struct amdgpu_trap_params *trap_params);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 5311e1ad0201..07b653909943 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -27,7 +27,7 @@
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
-#include "amdgpu_cwsr.h"
+#include "amdgpu_trap.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -148,10 +148,10 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
-	if (fpriv->cwsr_trap) {
-		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
-		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
-		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
+	if (fpriv->trap_obj) {
+		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
+		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
+		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
 	}
 
 	if (mes->use_rs64mem) {
@@ -415,7 +415,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
-		struct amdgpu_cwsr_params cwsr_params;
+		struct amdgpu_trap_params trap_params;
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -453,16 +453,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
-		if (amdgpu_cwsr_is_enabled(adev)) {
+		if (amdgpu_trap_is_enabled(adev)) {
 			struct amdgpu_fpriv *fpriv =
 				uq_mgr_to_fpriv(queue->userq_mgr);
 			int num_xcc;
 
 			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
 							 fpriv->xcp_id);
-			cwsr_params.ctx_save_area_address =
+			trap_params.ctx_save_area_address =
 				compute_mqd->ctx_save_area_va;
-			cwsr_params.cwsr_sz =
+			trap_params.cwsr_sz =
 				compute_mqd->ctx_save_area_size;
 
 			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
@@ -471,8 +471,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				goto free_mqd;
 			}
 
-			r = amdgpu_userq_input_cwsr_params_validate(
-				queue, &cwsr_params);
+			r = amdgpu_userq_input_trap_params_validate(
+				queue, &trap_params);
 			amdgpu_bo_unreserve(queue->vm->root.bo);
 			if (r) {
 				kfree(compute_mqd);
@@ -484,7 +484,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			userq_props->ctx_save_area_size =
 				compute_mqd->ctx_save_area_size;
 			userq_props->ctl_stack_size =
-				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+				adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
 		}
 
 		kfree(compute_mqd);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index eed8a7f7e88b..1b0abed672b9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,7 +60,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_UALINK_HANDLE	0x1B
-#define DRM_AMDGPU_CWSR			0x1C
+#define DRM_AMDGPU_TRAP			0x1C
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -84,7 +84,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
-#define DRM_IOCTL_AMDGPU_CWSR		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
+#define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
 
 /**
  * DOC: memory domains
@@ -1698,10 +1698,10 @@ struct drm_amdgpu_info_cwsr {
 };
 
 /* cwsr ioctl */
-#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
+#define AMDGPU_TRAP_OP_SET_L2_TRAP 1
 
-struct drm_amdgpu_cwsr_in {
-	/* AMDGPU_CWSR_OP_* */
+struct drm_amdgpu_trap_in {
+	/* AMDGPU_TRAP_OP_* */
 	__u32 op;
 	struct {
 		/* Level 2 trap handler base address */
@@ -1715,8 +1715,8 @@ struct drm_amdgpu_cwsr_in {
 	} l2trap;
 };
 
-union drm_amdgpu_cwsr {
-	struct drm_amdgpu_cwsr_in in;
+union drm_amdgpu_trap {
+	struct drm_amdgpu_trap_in in;
 };
 /*
  * Supported GPU families
-- 
2.34.1

