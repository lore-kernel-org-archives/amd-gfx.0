Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB13C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 18:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19BF10EA66;
	Fri, 28 Mar 2025 18:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DyBSSuHA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E2410EA66
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 18:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmFe3/9T5m7Lw4bFLx0k/R/aeh2nb61z0hE1ENDKS2Tmk/m91vjFW5NKkDM6DSeKT2Z5L3ZtlzDPAhujtUOFCZQain6pyqH1e0zUnvJq6LeEEJXjWVPMD7UP4WHuE9VLUfBGO+3wPZ6X8Vy7R2HyGWspOOiaJGD4okxT+RT35LQW05ZyIdplj2vq1sctgwNvaVem8bemG29gcwydSR8Iwyz9dsZcbvzHhgIML/R4ZlUVqahGJQQU2LqyDUCvd1tH91MshFs/wyCJEXcmGJCPdY8ekPCR4hXGEfzZ8/jIS/C+YzK5FoOQhRD75/h2E+nfM2/JUVmU35d7oPQDfVi0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GdVvz3Q1a4lNGmSCN9aoIJEF3ODbpNqpXPF98XtwQo=;
 b=Kq0HHEttBXTDSAGC0vcAFt6GddUtoBXukyoW6Kj/DQui1npidT9KzrGfjmmw/8pviHZVU47MsMq8GS2j0kq5tjc7WM8KXr3c7i8vKgVK0hkaowl+2syY+g8MD/RnlheKFg6Pn4VZTYB7qQDVSlajz4zvqzPzJyrU+ur6g3M5FzuqTNwnKhx57r9yMfuznodfDZuimFx3RZCRMFmBqDXNgB+FRK7IJCyE0y6iLHdm/32fbu+q8M59iMJ7QW/51qfljTbb8TfHYgGPgGkqEVOtQmrNO+C4pH2dOF7BIVUcBYu2eBj2Cm69fiN3AtgBOFgc1InnBmtw7tvwNZW3EvP3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GdVvz3Q1a4lNGmSCN9aoIJEF3ODbpNqpXPF98XtwQo=;
 b=DyBSSuHAFwhy0fa7MgqirKkUZ28SJUk1GURQwwngEBz6/fdHtRghHiWGYcDwzTmBmP7woIIGJSzdaXDKvlzIN6PSWuKcyV8wgOiNak0JbAokzHjBTltLjf+AXmMw0vOUbRafj803pjPvtTIPMLK3rYS/6iAGi6KESNVnz/uz0Oo=
Received: from CH2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:610:4f::24)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 18:07:11 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::81) by CH2PR18CA0014.outlook.office365.com
 (2603:10b6:610:4f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.47 via Frontend Transport; Fri,
 28 Mar 2025 18:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 18:07:10 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 13:07:10 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>,
 <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>, <dcostantino@meta.com>, <sruffell@meta.com>,
 David Francis <David.Francis@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: Adding amdgpu CRIU ioctl
Date: Fri, 28 Mar 2025 14:06:51 -0400
Message-ID: <20250328180652.2108029-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328180652.2108029-1-David.Francis@amd.com>
References: <20250328180652.2108029-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e20193e-9e7a-43da-f517-08dd6e235c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OdaQSSe53XRAdCGbKf+QJxpbByDEt7TpVCHaV9YDX/d3ZOIFhyHF6+Ws7mRi?=
 =?us-ascii?Q?T6tAK/U6UPp68iQYdH0X5fPMYN8HiXEP7jmHC/uSlxrXM6NElwP1xa0iOO/K?=
 =?us-ascii?Q?+xP+dDXzYRz7PyAUdWCt/wgVCrySZebgEl60QN8pPTOCS1V1TNa82z+6I7oN?=
 =?us-ascii?Q?pcTTuueEd5+iSHEF7yh30pttc9aGF3IZDxHwiWXLcfIZSox7owjqrgodz1Hu?=
 =?us-ascii?Q?Hz+Sh3HQPjOwbrg2A+l0znlrWScaxoraQi3DDFMpcGkoowBVBFE+Bd0/z88X?=
 =?us-ascii?Q?H6srzAP2d4riwKHrmNUl96o3qxvQrv4BKitJUJWR2/rAfhQ+rcOKTWOBsHZw?=
 =?us-ascii?Q?qF+ZdH+j2J24WYGeShWXj00F3IuY4P7Md/twvr/FGpUikf0TnakcKkdEH35u?=
 =?us-ascii?Q?kyd9BJDbl223aU/IKIxT+sJtgqMYZ7pgYyeQoVuv3Sci0OPR9P0xN7vA5haw?=
 =?us-ascii?Q?kxT2EhBi8zffuSv1+M5h+e4TDUdGK13KEMoKpzwkzq/VO77YdeP/EPOjELhs?=
 =?us-ascii?Q?pyMsgjyXn4yMp+j8HLzEjB63htSFS5LlkDBzlpht8yMpslOQ5DQkpdvobSRT?=
 =?us-ascii?Q?+Pcd2GSUGpe6Z2ZHwf8GAxyhKmpL7x2l//+Kvm13r6gwNbfrb7Obx3RH4OG4?=
 =?us-ascii?Q?w69jqoizyTHoXHx6yULBl+mAW0xP9b4FhEU/kfnzz8EKSuvsxA7EA0sUU0Lv?=
 =?us-ascii?Q?alQNhYyd0QQgK0SSAV+xQEmszUecKBTKdu1AwXOoCqvtZWXGOKsqDyoPQIut?=
 =?us-ascii?Q?p8+Jau5CeiVewdZ8sEizo8OcWLuOSTEROE7EL4+gKufiLNoRBJl9akJxyGEM?=
 =?us-ascii?Q?Dpic2OBnlus5uTTNWV6hf1xonBDBX0ChOZGcjlNJlmvsh5hKZ9tyt/SYpzb7?=
 =?us-ascii?Q?/bA26GylSzQKD2Pza5IGAtN5sDlkjc3KL2khLDrSuB5ezPDSKz4sQ4iW7oR9?=
 =?us-ascii?Q?emTLISMdhO/MKnNpE4OxM7ZCvBPdFlu+9ABCzbnAIyU1S2ecp8DvfRfpidE/?=
 =?us-ascii?Q?P8kqEYLD4XMvp3v3j/RaufnmbNDE6RLCYBuJP04Li/BDydasFDfdIZ+NFbh6?=
 =?us-ascii?Q?bLr24J0mkQiJK81rd0XyaR/pFglcmSSVj2d7lbfvrXSxj3e74+zwdwBy7kVf?=
 =?us-ascii?Q?+qqJmRkZA4A9Y55Szibs902ezWvQhLdTS140c+85jnEWBFDxylkjU2ALhcJ+?=
 =?us-ascii?Q?dEjSQrVpVbrJpwenH2ESkcfEAWJkJPE4shcuavYaXYoL9ZcRxrxzXl+kBzSi?=
 =?us-ascii?Q?f7dpcpuz2HGyA8yJTk7KmNwlRVSUgfE2UfQQT39R9mkZ//jMi1eu4QkGbqEe?=
 =?us-ascii?Q?b6GMervfNaYl1WxuI93jJ0wvJekxuDXEMEdyxhxh4LQjKJ6P6RFb4R/wFPTU?=
 =?us-ascii?Q?EgdOhdmt8siJ8eGHsZpnEJm12TdGF3FFPNntrWOuK55Oi+GV873NKEr5WTIr?=
 =?us-ascii?Q?aKl8+7IXMgFWNS6G6Eii+UwupK5rDFpKi5LooVw85RD8laTsL2GjWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:07:10.9212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e20193e-9e7a-43da-f517-08dd6e235c69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810
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

amdgpu CRIU requires an amdgpu CRIU ioctl. This ioctl
has a similar interface to the amdkfd CRIU ioctl.

The objects that can be checkpointed and restored are bos and vm
mappings. Because a single amdgpu bo can have multiple mappings.
they must be a separate object.

Includes handling of restore retries and skips. Because some of the
buffer objects restored by amdgpu may be imported from amdkfd,
the work may need to be done in multiple stages. The skip
field identifies bos that should not be restored in the
current stage.

The new ioctls live in a new file amdgpu_criu.c with its own
header amdgpu_criu.h

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c | 462 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h |  47 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   2 +
 include/uapi/drm/amdgpu_drm.h            |  48 +++
 6 files changed, 562 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6cb3a2b2725a..eac5a455e6de 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -63,7 +63,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
-	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
+	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_criu.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_userq_fence.o amdgpu_eviction_fence.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
new file mode 100644
index 000000000000..234c29c1b2a1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
@@ -0,0 +1,462 @@
+/* SPDX-License-Identifier: MIT */
+/*
+* Copyright 2025 Advanced Micro Devices, Inc.
+*
+* Permission is hereby granted, free of charge, to any person obtaining a
+* copy of this software and associated documentation files (the "Software"),
+* to deal in the Software without restriction, including without limitation
+* the rights to use, copy, modify, merge, publish, distribute, sublicense,
+* and/or sell copies of the Software, and to permit persons to whom the
+* Software is furnished to do so, subject to the following conditions:
+*
+* The above copyright notice and this permission notice shall be included in
+* all copies or substantial portions of the Software.
+*
+* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+* THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+* OTHER DEALINGS IN THE SOFTWARE.
+*/
+
+#include <linux/dma-buf.h>
+#include <linux/hashtable.h>
+#include <linux/mutex.h>
+#include <linux/random.h>
+
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+
+#include "amdgpu_criu.h"
+
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_exec.h>
+#include <drm/drm_gem_ttm_helper.h>
+#include <drm/ttm/ttm_tt.h>
+
+#include "amdgpu.h"
+#include "amdgpu_display.h"
+#include "amdgpu_dma_buf.h"
+#include "amdgpu_hmm.h"
+#include "amdgpu_xgmi.h"
+
+static bool is_import(struct amdgpu_bo *bo)
+{
+	if (bo->tbo.base.import_attach)
+		return &bo->tbo.base != (struct drm_gem_object *)bo->tbo.base.import_attach->dmabuf->priv;
+	return false;
+}
+
+static int reserve_bo_and_vm(struct amdgpu_bo *bo,
+			      struct amdgpu_vm *vm,
+			      struct drm_exec *exec)
+{
+	int ret;
+
+	WARN_ON(!vm);
+
+	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(exec) {
+		ret = amdgpu_vm_lock_pd(vm, exec, 2);
+		drm_exec_retry_on_contention(exec);
+		if (unlikely(ret))
+			goto error;
+
+		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
+		drm_exec_retry_on_contention(exec);
+		if (unlikely(ret))
+			goto error;
+	}
+	return 0;
+
+error:
+	pr_err("Failed to reserve buffers in ttm.\n");
+	drm_exec_fini(exec);
+	return ret;
+}
+
+static void unreserve_bo_and_vm(struct drm_exec *exec)
+{
+	drm_exec_fini(exec);
+}
+
+static int amdgpu_criu_process_info(struct drm_device *dev, struct drm_file *data,
+			    struct drm_amdgpu_criu_args *args)
+{
+	struct drm_gem_object *gobj;
+	int id;
+	int num_bos = 0;
+	int num_vm_mappings = 0;
+	struct amdgpu_vm *avm = &((struct amdgpu_fpriv *)data->driver_priv)->vm;
+
+	spin_lock(&data->table_lock);
+	idr_for_each_entry(&data->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		struct amdgpu_vm_bo_base *vm_bo_base;
+
+		num_bos += 1;
+
+		vm_bo_base = bo->vm_bo;
+
+		while (vm_bo_base) {
+			struct amdgpu_bo_va *bo_va = container_of(vm_bo_base, struct amdgpu_bo_va, base);
+			struct amdgpu_bo_va_mapping *mapping;
+
+			if (vm_bo_base->vm == avm) {
+
+				list_for_each_entry(mapping, &bo_va->invalids, list) {
+					num_vm_mappings += 1;
+				}
+				list_for_each_entry(mapping, &bo_va->valids, list) {
+					num_vm_mappings += 1;
+				}
+			}
+
+			vm_bo_base = vm_bo_base->next;
+		}
+	}
+	spin_unlock(&data->table_lock);
+
+	args->num_bos = num_bos;
+	args->priv_data_size = sizeof(struct drm_amdgpu_criu_bo_priv_data) * num_bos + sizeof(struct drm_amdgpu_criu_vm_mapping_priv_data) * num_vm_mappings;
+	args->num_objs = num_vm_mappings;
+	args->pid = avm->task_info->pid;
+
+	return 0;
+}
+
+static int amdgpu_criu_checkpoint(struct drm_device *dev, struct drm_file *data,
+			    struct drm_amdgpu_criu_args *args)
+{
+
+	struct amdgpu_vm *avm = &((struct amdgpu_fpriv *)data->driver_priv)->vm;
+	struct drm_amdgpu_criu_bo_bucket *bo_buckets;
+	struct drm_amdgpu_criu_bo_priv_data *bo_privs;
+	struct drm_amdgpu_criu_vm_mapping_priv_data *vm_privs;
+	struct drm_gem_object *gobj;
+	int vm_priv_index = 0;
+	int bo_index = 0;
+	int num_bos = 0;
+	int fd, id, ret;
+
+	spin_lock(&data->table_lock);
+	idr_for_each_entry(&data->object_idr, gobj, id)
+		num_bos += 1;
+	spin_unlock(&data->table_lock);
+
+	if (args->num_bos != num_bos) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	bo_buckets = kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL);
+	if (!bo_buckets) {
+		ret = -ENOMEM;
+		goto free_buckets;
+	}
+
+	bo_privs = kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
+	if (!bo_privs) {
+		ret = -ENOMEM;
+		goto free_privs;
+	}
+
+	vm_privs = kvzalloc(args->num_objs * sizeof(*vm_privs), GFP_KERNEL);
+	if (!vm_privs) {
+		ret = -ENOMEM;
+		goto free_vms;
+	}
+
+	idr_for_each_entry(&data->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		struct drm_amdgpu_criu_bo_bucket *bo_bucket;
+		struct drm_amdgpu_criu_bo_priv_data *bo_priv;
+		struct amdgpu_vm_bo_base *vm_bo_base;
+
+		bo_bucket = &bo_buckets[bo_index];
+		bo_priv = &bo_privs[bo_index];
+
+		bo_bucket->size = amdgpu_bo_size(bo);
+		bo_bucket->offset = amdgpu_bo_mmap_offset(bo);
+		bo_bucket->alloc_flags = bo->flags;
+		bo_bucket->preferred_domains = bo->preferred_domains;
+
+		bo_priv->idr_handle = id;
+
+		if (is_import(bo))
+			bo_bucket->flags |= AMDGPU_CRIU_BO_FLAG_IS_IMPORT;
+
+		drm_gem_prime_handle_to_fd(dev, data, id, 0, &fd);
+		if (fd)
+			bo_bucket->dmabuf_fd = fd;
+
+		vm_bo_base = bo->vm_bo;
+
+		while (vm_bo_base) {
+			struct amdgpu_bo_va *bo_va = container_of(vm_bo_base, struct amdgpu_bo_va, base);
+			struct amdgpu_bo_va_mapping *mapping;
+
+			if (vm_bo_base->vm == avm) {
+				list_for_each_entry(mapping, &bo_va->invalids, list) {
+					vm_privs[vm_priv_index].start = mapping->start;
+					vm_privs[vm_priv_index].last = mapping->last;
+					vm_privs[vm_priv_index].offset = mapping->offset;
+					vm_privs[vm_priv_index].flags = mapping->flags;
+					vm_privs[vm_priv_index].idr_handle = id;
+					vm_priv_index += 1;
+
+					bo_bucket->addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+				}
+				list_for_each_entry(mapping, &bo_va->valids, list) {
+					vm_privs[vm_priv_index].start = mapping->start;
+					vm_privs[vm_priv_index].last = mapping->last;
+					vm_privs[vm_priv_index].offset = mapping->offset;
+					vm_privs[vm_priv_index].flags = mapping->flags;
+					vm_privs[vm_priv_index].idr_handle = id;
+					vm_priv_index += 1;
+
+					bo_bucket->addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+				}
+			}
+
+			vm_bo_base = vm_bo_base->next;
+		}
+
+		bo_index += 1;
+	}
+
+	ret = copy_to_user((void __user *)args->bos, bo_buckets, num_bos * sizeof(*bo_buckets));
+	if (ret) {
+		pr_debug("Failed to copy BO information to user\n");
+		ret = -EFAULT;
+		goto free_vms;
+	}
+
+	ret = copy_to_user((void __user *)args->priv_data, bo_privs, num_bos * sizeof(*bo_privs));
+	if (ret) {
+		pr_debug("Failed to copy BO PRIV information to user\n");
+		ret = -EFAULT;
+		goto free_vms;
+	}
+	ret = copy_to_user((void __user *)(args->priv_data + sizeof(struct drm_amdgpu_criu_bo_priv_data) * num_bos), vm_privs, args->num_objs * sizeof(*vm_privs));
+	if (ret) {
+		pr_debug("Failed to copy VM PRIV information to user\n");
+		ret = -EFAULT;
+		goto free_vms;
+	}
+
+free_vms:
+	kvfree(vm_privs);
+free_privs:
+	kvfree(bo_privs);
+free_buckets:
+	kvfree(bo_buckets);
+exit:
+
+	return ret;
+}
+
+static int amdgpu_criu_unpause(struct drm_device *dev, struct drm_file *data,
+			    struct drm_amdgpu_criu_args *args)
+{
+	return 0;
+}
+
+static int amdgpu_criu_restore(struct drm_device *dev, struct drm_file *data,
+			    struct drm_amdgpu_criu_args *args)
+{
+	struct amdgpu_vm *avm = &((struct amdgpu_fpriv *)data->driver_priv)->vm;
+	struct drm_amdgpu_criu_bo_bucket *bo_buckets;
+	struct drm_amdgpu_criu_bo_priv_data *bo_privs;
+	struct drm_amdgpu_criu_vm_mapping_priv_data *vm_privs;
+	struct amdgpu_fpriv *fpriv = (struct amdgpu_fpriv *)data->driver_priv;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_bo *restored_bo;
+	int ret, i, j;
+
+	bo_buckets = kvzalloc(args->num_bos * sizeof(*bo_buckets), GFP_KERNEL);
+	if (!bo_buckets) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+	ret = copy_from_user(bo_buckets, (void *)args->bos, args->num_bos * sizeof(*bo_buckets));
+	if (ret) {
+		ret = -EINVAL;
+		goto free_buckets;
+	}
+
+	bo_privs = kvzalloc(args->num_bos * sizeof(*bo_privs), GFP_KERNEL);
+	if (!bo_privs) {
+		ret = -ENOMEM;
+		goto free_buckets;
+	}
+	ret = copy_from_user(bo_privs, (void *)args->priv_data, args->num_bos * sizeof(*bo_privs));
+	if (ret) {
+		ret = -EINVAL;
+		goto free_privs;
+	}
+
+	vm_privs = kvzalloc(args->num_objs * sizeof(*vm_privs), GFP_KERNEL);
+	if (!vm_privs) {
+		ret = -ENOMEM;
+		goto free_privs;
+	}
+
+	ret = copy_from_user(vm_privs, (void *)(args->priv_data + sizeof(struct drm_amdgpu_criu_bo_priv_data) * args->num_bos), args->num_objs * sizeof(*vm_privs));
+	if (ret) {
+		ret = -EINVAL;
+		goto free_vms;
+	}
+
+	for (i = 0; i < args->num_bos; i++) {
+		struct drm_amdgpu_criu_bo_bucket *bo_bucket = &bo_buckets[i];
+		struct drm_amdgpu_criu_bo_priv_data *bo_priv = &bo_privs[i];
+		struct amdgpu_bo *bo;
+
+		/* Either this bo is waiting for a dmabuf_fd to be restored or it has already been restored */
+		if (bo_bucket->flags & AMDGPU_CRIU_BO_FLAG_SKIP)
+			continue;
+
+		if (!(bo_bucket->flags & AMDGPU_CRIU_BO_FLAG_IS_IMPORT)) {
+			struct drm_gem_object *obj;
+			enum ttm_bo_type type = ttm_bo_type_device;
+			int xcp_id = -1;
+			int prime_fd, handle;
+
+			if (bo_bucket->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM) {
+				xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
+							0 : fpriv->xcp_id;
+			}
+			ret = amdgpu_gem_object_create(adev, bo_bucket->size, 1, bo_bucket->preferred_domains,
+				bo_bucket->alloc_flags, type, NULL, &obj, xcp_id + 1);
+			if (ret)
+				goto free_vms;
+
+			restored_bo = gem_to_amdgpu_bo(obj);
+
+			drm_gem_handle_create(data, obj, &handle);
+			drm_prime_change_buf_handle(data, obj, bo_priv->idr_handle);
+
+			bo_bucket->restored_offset = amdgpu_bo_mmap_offset(restored_bo);
+
+			ret = drm_gem_prime_handle_to_fd(dev,
+			       data, bo_priv->idr_handle,
+			       DRM_RDWR,
+			       &prime_fd);
+
+			bo_bucket->dmabuf_fd = prime_fd;
+		} else {
+			struct drm_gem_object *obj;
+			int ret, handle = -1;
+
+			bo = gem_to_amdgpu_bo(obj);
+
+			if (bo->kfd_bo) {
+				ret = drm_gem_prime_fd_to_handle(dev, data, bo_bucket->dmabuf_fd, &handle);
+
+				if (ret < 0)
+					goto free_vms;
+
+				obj = idr_find(&data->object_idr, handle);
+				if (!obj)
+					goto free_vms;
+
+				ret = drm_prime_change_buf_handle(data, obj, bo_priv->idr_handle);
+				if (ret < 0)
+					goto free_vms;
+
+				if (obj != &bo->tbo.base)
+					restored_bo = gem_to_amdgpu_bo(obj);
+				else
+					restored_bo = bo;
+
+				bo_bucket->restored_offset = amdgpu_bo_mmap_offset(restored_bo);
+			}
+		}
+
+
+		for (j = 0; j < args->num_objs; j++) {
+			struct drm_amdgpu_criu_vm_mapping_priv_data *vm_priv = &vm_privs[j];
+			struct amdgpu_bo_va *bo_va;
+			struct drm_exec exec;
+
+			if (vm_priv->idr_handle != bo_priv->idr_handle)
+				continue;
+
+			reserve_bo_and_vm(restored_bo, avm, &exec);
+
+			bo_va = amdgpu_vm_bo_find(avm, restored_bo);
+			if (!bo_va)
+				bo_va = amdgpu_vm_bo_add(adev, avm, restored_bo);
+
+			amdgpu_vm_bo_map(adev,
+			     bo_va,
+			     vm_priv->start * AMDGPU_GPU_PAGE_SIZE, vm_priv->offset,
+			     (vm_priv->last - vm_priv->start + 1) * AMDGPU_GPU_PAGE_SIZE, vm_priv->flags);
+
+			ret = amdgpu_vm_bo_update(adev, bo_va, false);
+
+			ret = amdgpu_vm_update_pdes(adev, avm, false);
+
+			unreserve_bo_and_vm(&exec);
+
+		}
+	}
+
+	ret = copy_to_user((void *)args->bos, bo_buckets, args->num_bos * sizeof(*bo_buckets));
+	if (ret) {
+		pr_debug("Failed to copy BO information to user\n");
+		ret = -EFAULT;
+		goto free_vms;
+	}
+
+free_vms:
+	kvfree(vm_privs);
+free_privs:
+	kvfree(bo_privs);
+free_buckets:
+	kvfree(bo_buckets);
+exit:
+
+	return ret;
+}
+
+static int amdgpu_criu_resume(struct drm_device *dev, struct drm_file *data,
+			    struct drm_amdgpu_criu_args *args)
+{
+	return 0;
+}
+
+int amdgpu_criu_op_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	struct drm_amdgpu_criu_args *args = data;
+	int ret;
+
+	switch (args->op) {
+	case AMDGPU_CRIU_OP_PROCESS_INFO:
+		ret = amdgpu_criu_process_info(dev, filp, args);
+		break;
+	case AMDGPU_CRIU_OP_CHECKPOINT:
+		ret = amdgpu_criu_checkpoint(dev, filp, args);
+		break;
+	case AMDGPU_CRIU_OP_UNPAUSE:
+		ret = amdgpu_criu_unpause(dev, filp, args);
+		break;
+	case AMDGPU_CRIU_OP_RESTORE:
+		ret = amdgpu_criu_restore(dev, filp, args);
+		break;
+	case AMDGPU_CRIU_OP_RESUME:
+		ret = amdgpu_criu_resume(dev, filp, args);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
new file mode 100644
index 000000000000..e1d22d14a23a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: MIT */
+/*
+* Copyright 2025 Advanced Micro Devices, Inc.
+*
+* Permission is hereby granted, free of charge, to any person obtaining a
+* copy of this software and associated documentation files (the "Software"),
+* to deal in the Software without restriction, including without limitation
+* the rights to use, copy, modify, merge, publish, distribute, sublicense,
+* and/or sell copies of the Software, and to permit persons to whom the
+* Software is furnished to do so, subject to the following conditions:
+*
+* The above copyright notice and this permission notice shall be included in
+* all copies or substantial portions of the Software.
+*
+* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+* THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+* OTHER DEALINGS IN THE SOFTWARE.
+*/
+
+#ifndef __AMDGPU_CRIU_H__
+#define __AMDGPU_CRIU_H__
+
+#include <drm/amdgpu_drm.h>
+
+int amdgpu_criu_op_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp);
+
+struct amdgpu_bo *bo_from_criu_global_handle(uint8_t *handle);
+int insert_bo_at_criu_global_handle(struct amdgpu_bo *bo, uint8_t *handle);
+
+struct drm_amdgpu_criu_bo_priv_data {
+	uint32_t idr_handle; // IDR for drm gem idr
+};
+
+struct drm_amdgpu_criu_vm_mapping_priv_data {
+	uint64_t start;
+	uint64_t last;
+	uint64_t offset;
+	uint64_t flags;
+	uint32_t idr_handle;
+};
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index acb9dc3705ac..12d844598efc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -53,6 +53,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_criu.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
 /*
@@ -2909,6 +2910,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_CRIU_OP, amdgpu_criu_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 065d87841459..9c1e4c2ba110 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -45,6 +45,8 @@
 #include "amdgpu_dma_buf.h"
 #include "kfd_debug.h"
 
+#include "amdgpu_criu.h"
+
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
 static int kfd_release(struct inode *, struct file *);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8191d0bd0c00..d0a46b27e1a8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -57,6 +57,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ		0x16
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
+#define DRM_AMDGPU_CRIU_OP		0x19
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -77,6 +78,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
+#define DRM_IOCTL_AMDGPU_CRIU_OP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CRIU_OP, struct drm_amdgpu_criu_args)
 
 /**
  * DOC: memory domains
@@ -1585,6 +1587,52 @@ struct drm_color_ctm_3x4 {
 	__u64 matrix[12];
 };
 
+/* CRIU ioctl
+ *
+ * When checkpointing a process, the CRIU amdgpu plugin will perform:
+ * 1. INFO op to get information about state that needs to be saved. This
+ *    pauses execution until the checkpoint is done.
+ * 2. CHECKPOINT op to save state (BOs for now, TODO: CS contexts)
+ * 3. UNPAUSE op to resume execution when the checkpoint is done.
+ *
+ * When restoring a process, the CRIU amdgpu plugin will perform:
+ *
+ * 1. RESTORE op to restore state
+ * 2. RESUME op to restore userptr mappings (TODO)
+ */
+enum drm_amdgpu_criu_op {
+	AMDGPU_CRIU_OP_PROCESS_INFO,
+	AMDGPU_CRIU_OP_CHECKPOINT,
+	AMDGPU_CRIU_OP_UNPAUSE,
+	AMDGPU_CRIU_OP_RESTORE,
+	AMDGPU_CRIU_OP_RESTORE_RETRY,
+	AMDGPU_CRIU_OP_RESUME,
+};
+
+struct drm_amdgpu_criu_args {
+	__u64 bos; /* user pointer to bos array */
+	__u64 priv_data; /* user pointer to private data */
+	__u64 priv_data_size;
+	__u32 num_bos;
+	__u32 num_objs;
+	__u32 pid;
+	__u32 op;
+};
+
+#define AMDGPU_CRIU_BO_FLAG_IS_IMPORT	(1 << 0)
+#define AMDGPU_CRIU_BO_FLAG_SKIP	(1 << 1)
+
+struct drm_amdgpu_criu_bo_bucket {
+	__u64 addr;
+	__u64 size;
+	__u64 offset;
+	__u64 restored_offset;    /* During restore, updated offset for BO */
+	__u64 alloc_flags;
+	__u32 preferred_domains;
+	__u32 dmabuf_fd;
+	__u32 flags;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

