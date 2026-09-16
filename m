Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28B4C88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 05:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E3510E32A;
	Wed, 16 Sep 2026 05:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kvPX/PlP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924AD10E329
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 05:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v96471VR8U1mxgc3BvswkrB7GTVQSjptiKcWkWda0AcCilgJFlLesyRu93M9UYtwpe+4cEsu2H2Fktq/CVYnkgBO9tKvN6dyBu3QsJIgrZHzCrR4H0O9AaWVpt/lFo2Dr0p7IAOM9idAsqSZBGljLIdwPNC+nsqkc5sHzJoLV2PKLBKpo8eijGniFS2Cs/9moSV4WVnVhrvqZI9Ww+2WnlF9a3cVFeilBDXsktP6h5ct7Z4FY0B/hCq/bLwkyPSaQ/UJuSd8AVub9p/F4K15gsGKlpG1YHxg+NJT8ssWoQvPndc/j5Q6gvxv6DKsXmR6XtMuWD0LboIaA2xU1rqq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+S+5/bo5QysJyDVdMOFHdJMKZSzlGWKqOZEX7I1QaU=;
 b=A7ypHKUzXl+2pSrm2n8UXGE+iS3q5qRL6ZXeZtQH60vPq7D1hmbKJxZlip7Dugvevq+6OCKwgjdN5BKm4BIRlY4VoGL/Fbj4CvjREuRc7g9KiPnENfrCxT5puXfXfcJ5b1XSOsDh+6vEZE/YsJcayPzChfb/L60QISMf+ApCA+h44RSQtyIG1OO1xvcesZl9w4nuwnhqWE6wN96M6lej30b3TsM2V0DzOR2Kqxs3lgGcOaerVcWuadi20fJm1QYrv7TQ4XTqOO/CiQoAWvFI8u1Jq8zDgvsPn5UmRN1K4ZTUjqQdbZQvuPM4+Z3v07QbHW8/o/8zQZp20s1yBilc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+S+5/bo5QysJyDVdMOFHdJMKZSzlGWKqOZEX7I1QaU=;
 b=kvPX/PlPJUHxfryQtGBvRK2SdNtVXgq5o0A1SDm5U8M5PTqckLq/a+5FsNSvvV0a6SglZMqfxNwWYjnEaTdMovpxd9Npp675Trh2DsBIbQhu1EqZc5un3Zi/WmsUsdyLBLnfLLevYy0VBJdocOM2VO1c2NU7/ws+8EZzr/O4W0s=
Received: from PH7P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::26)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 05:37:49 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:510:32b:cafe::43) by PH7P220CA0039.outlook.office365.com
 (2603:10b6:510:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Wed,
 16 Sep 2026 05:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:37:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 00:37:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 "Lijo Lazar" <lijo.lazar@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl
Date: Wed, 16 Sep 2026 11:07:22 +0530
Message-ID: <20260916053722.601067-5-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: c9247bd5-e327-43f2-b303-08df13b4a4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|18002099003|22082099003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: svk+IrbzpoRpnZ7zN+E8TupFvXpQOfJMmUp4f3eyQvmvBArP9kZx4Xkg0LCXn7das6inyUa0VBhCytPL/mYKD1ctUeM2WY4w/2UzIQkg8w2/iZlWDjppSIOpoDcB6kykx1j4Vq/cVI5fY4wUZnnWiHIKn31Z3CFmycm+LTYSDo5/a25P9JF4+PWit7/GXNHMj9jF82CL3b3mdXFg2ooftFg5sMWCfQb8ZSs5RcM+ZQZ2n7KQI1CL9C6ex9M/CNZVWreckp+NIjgBSC3WDXZRddezifFU/PyHQsefRPA5olZ6/u9A3qE8Nij5WmjjZqoXOhL+ums30iHmQsLU8k3G2FtaYRAC98i1i4qnnhToNO7++XXpTdWrfIFvW3JUGaFvRMVjzYSIIZIJyGi/D5oPmg5+kwRVHZML065FnX+M/YbE/vnWcW4MSlNnTa1BHaOQ9wEkhn0ZPCO1E7sWZFOLUNBexpQ++S++Tx962ziE/baCO+v3BsQCsVatfqAsU5uh7PooQQWDXBrLWmJyQ43mQSXnDSPjWgMbeH43IPQIdWcN3+BVzN08sAyhGndKkS4vdBPN9Ftlnsd5e+WTXCatjNGslpqY/M2g/v68UnYkWqvJOuBHEF3ugMzsixd7JuiA/2TS5UMzW4T66ImlkqIE8ny69GFAaqWlx1MKevG7QxqwL08PFMdKo/zsqlSRryVZeUDyOSwAOIgEFB5JncSi1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n9fdrA4aECBZSpue7r2CkF5iHcJIB7KeVv/ELw/7gi/jl6u+lKzYjje8zLUp4PPZhfjLuCvz5oJRC3uRAB8gEM5VwarzYt9xl+3i7iJsZRyI0hAQ/Xog0Cue3CwL37Meem+z1lxTuuTzQeJl55sYPZWOTOikrRcZ1n9WGCCiGoS3Yc0SJpvYzEcCfIJ0cbdg9STvBhNYsKLMMs2lVGrVdU4gOJ2XR8hz0y00J47/n1BUHi3eot2YnxRRxDv6yh4HgXu5qVujV2j/j98fad80z/1h9Dg99XsRvX2Ow7KDepJHPthF1Z/TyXgnQrZsNc/ovQbqis6kC4rVHwAz4N7vXrSem5Nee0z3nP8GMshXOl05nfZ8cFpFxkozpPpeTBlR4MHikhIZZvk9NLqXGn4YMcnFphcUUmlfjB6PCR503ViYqjltx1VcLOX6xtymLUjp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:37:49.1748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9247bd5-e327-43f2-b303-08df13b4a4f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
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

Add two new VM ioctl operations:
  AMDGPU_VM_OP_SET_L2_TRAP   (op = 3)
  AMDGPU_VM_OP_CLEAR_L2_TRAP (op = 4)

The second-level trap handler is a per-VM setting. All shader waves
executing under this VMID share the same handler regardless of queue
type. GFX and compute queues from the same process share the same VMID
so one SET_L2_TRAP covers all queue types for this DRM file.

The TRAP ioctl and its associated structures are removed entirely; the
ioctl number was never part of a released kernel.

Both TBA and TMA buffers MUST be allocated with
AMDGPU_GEM_CREATE_VM_ALWAYS_VALID. The GPU jumps to TBA automatically on
a hardware exception without any software job submission.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  26 ++++++
 include/uapi/drm/amdgpu_drm.h          | 112 ++++++++++++++++++++-----
 2 files changed, 118 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d981915ac2f4..562139dc23ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2911,6 +2911,32 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
+	case AMDGPU_VM_OP_SET_L2_TRAP:
+		/*
+		 * Install or replace the per-VM second-level trap handler.
+		 * Applies to all shader waves under this VMID regardless of
+		 * queue type.
+		 */
+		if (!vm->trap_obj)
+			return -EOPNOTSUPP;
+		return amdgpu_trap_vm_set_l2_trap(adev, vm,
+						  &fpriv->userq_mgr,
+						  vm->trap_obj,
+						  args->in.l2trap.tba_va,
+						  args->in.l2trap.tba_sz,
+						  args->in.l2trap.tma_va,
+						  args->in.l2trap.tma_sz);
+	case AMDGPU_VM_OP_CLEAR_L2_TRAP:
+		/*
+		 * Disable the per-VM second-level trap handler.
+		 * Waits for VM idle, evicts queues, flushes TLB, clears
+		 * the handler descriptor.
+		 */
+		if (!vm->trap_obj)
+			return -EOPNOTSUPP;
+		return amdgpu_trap_vm_clear_l2_trap(adev, vm,
+						    &fpriv->userq_mgr,
+						    vm->trap_obj);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 4785cf48da17..24a08e4f0f36 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -632,10 +632,102 @@ struct drm_amdgpu_userq_wait {
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
 
+/**
+ * AMDGPU_VM_OP_SET_L2_TRAP - install or replace the second-level trap
+ *   handler for all GFX and compute queues belonging to this VM.
+ *
+ * The second-level trap handler is a per-VM setting. All shader waves
+ * executing under this VMID share the same handler regardless of queue
+ * type. GFX and compute queues from the same process share the same VMID
+ * so one SET_L2_TRAP covers all queue types for this DRM file.
+ *
+ * IMPORTANT: Both TBA and TMA buffers MUST be allocated with the
+ * AMDGPU_GEM_CREATE_VM_ALWAYS_VALID flag. The GPU jumps to TBA
+ * automatically on a hardware exception without any software job
+ * submission, so the kernel cannot track TBA/TMA in a job's used-buffer
+ * list. Without VM_ALWAYS_VALID the BO can be evicted and the page
+ * table entry becomes stale, causing a GPU page fault or memory
+ * corruption when the next shader exception fires.
+ *
+ * The TBA range must contain the handler executable code.
+ * The TMA range is the handler scratch memory buffer.
+ * Both ranges must be non-empty and fully mapped in the GPU virtual
+ * address space of this DRM file descriptor.
+ *
+ * For user queues, all active queues are evicted and the GPU TLB is
+ * flushed before the descriptor is written, then queues are restored.
+ * This prevents a trapping wave from observing a partially-written
+ * TBA/TMA pair during the update window.
+ *
+ * For kernel queues, the VM is drained via amdgpu_vm_wait_idle() before
+ * eviction and the descriptor write. This ensures no kernel-queue wave
+ * is active while TBA and TMA are being updated.
+ *
+ * Userspace should keep both mappings alive until
+ * AMDGPU_VM_OP_CLEAR_L2_TRAP succeeds. If either mapping is removed
+ * while the handler is active, the kernel waits for the VM to be idle,
+ * evicts all user queues, flushes the GPU TLB, clears the handler, and
+ * allows the unmap to proceed. UNMAP never returns an error for this
+ * condition. Queues whose trap handler VA was removed are not restarted.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  -EINVAL       if TBA/TMA is invalid, not mapped, or not allocated
+ *                with AMDGPU_GEM_CREATE_VM_ALWAYS_VALID;
+ *  -ETIMEDOUT    if the VM did not become idle within the wait timeout;
+ *  negative errno if the VM reservation fails.
+ */
+#define AMDGPU_VM_OP_SET_L2_TRAP	3
+
+/**
+ * AMDGPU_VM_OP_CLEAR_L2_TRAP - disable the second-level trap handler.
+ *
+ * For user queues, all active queues are evicted and the GPU TLB is
+ * flushed before TBA is zeroed to ensure no wave is executing inside
+ * the handler at the time of the clear.
+ *
+ * For kernel queues, the VM is drained via amdgpu_vm_wait_idle() before
+ * eviction and the clear. This ensures no kernel-queue wave is active
+ * while the descriptor is being zeroed.
+ *
+ * The l2trap input members are ignored for this operation.
+ *
+ * After this operation succeeds userspace may safely remove the TBA
+ * and TMA mappings.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  negative errno if the VM reservation fails.
+ */
+#define AMDGPU_VM_OP_CLEAR_L2_TRAP	4
+
 struct drm_amdgpu_vm_in {
 	/** AMDGPU_VM_OP_* */
 	__u32	op;
 	__u32	flags;
+	union {
+		struct {
+			/** GPU VA of second-level trap handler code buffer */
+			__u64 tba_va;
+			/** TBA buffer size in bytes */
+			__u32 tba_sz;
+			/** Explicit padding; tma_va starts at offset 24 */
+			__u32 _pad;
+			/** GPU VA of second-level trap handler scratch buffer */
+			__u64 tma_va;
+			/** TMA buffer size in bytes */
+			__u32 tma_sz;
+			/** Padding to fix total union size at 32 bytes */
+			__u32 _pad2;
+		} l2trap;
+		/**
+		 * Padding; keeps the union at a fixed 32-byte size for
+		 * future ops. Zero-initialise for RESERVE/UNRESERVE_VMID.
+		 */
+		__u64 _pad[4];
+	};
 };
 
 struct drm_amdgpu_vm_out {
@@ -1745,27 +1837,7 @@ struct drm_amdgpu_info_cwsr {
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
 
-union drm_amdgpu_trap {
-	struct drm_amdgpu_trap_in in;
-};
 /*
  * Supported GPU families
  */
-- 
2.34.1

