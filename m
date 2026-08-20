Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B037FC5DF85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 07:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F8610EF1D;
	Thu, 20 Aug 2026 07:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wjKOv0+H";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3903310E164
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 07:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsGlMANFA49aT6J2tcZB4C15CoFzK1fdv+DwxB8CKwc4XiVCFmO1Eiipqypo8ZWVWI7tFczgZuyIOVgpCaFQwxqhIho2X2H55bZBi9IDaOSIHiAMpCd0uIkLDs5t4U0enrxzl9hrhM0QkiOWl+TF8D9D7JjLJ9iJVutpR5BIBr/I+iXiejS+UaOB2t3xg8KemDbWkKAl95902aujB0igYY8KImTpH21lXhrIiGnFOLBnh5Y8+f8ZEi+8LvcxUeip4XLKvX88OxQPDys5Lu6PzCg91Fuu1gqV+76qsf1WI0IpMs5blwDpjn7DOtp97nwRwIrAWkT2AewgYe2be5/yMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVlinUlC+sU10AAbPFmZkqS64LyYdpHVxu8yi8oeVa8=;
 b=HaBWvpGxWbnjIyKBOkomFwniqA3ZQLBg6ZsJ+rJn88RUgb06skCH549ipRyPI0qUG5PLerhq08sYcRhUQcjPUr2IMdO4pTC7ghMZPEHEQ/LC56Ypb+5os/ELJq1klJLfX8oYIEzW1Zeyc/DU9yNS4W/4j7E8vUZk2pZBpkiF9si0dhlV7H9DG2WqBdA/j7JhPA2+RguaX67WRUKV0XCmKpeM4ZoUz1SSm3Hy4D5zkUFCz3yokfqiiXv5WpweCFUA/FvaNQn6fV8UJX6ZTeA+g45XPz6fZaQ+fDrbXhUSq2kBfmJSUsNU6GqBYkG6wlm1zUQN37uaH+b8B8cuKd1bkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVlinUlC+sU10AAbPFmZkqS64LyYdpHVxu8yi8oeVa8=;
 b=wjKOv0+HrRJnV7AduCBGtmy8fWP9+uJrnm153Xucol0jDAN0UmEDb5Yl8pUxStumBPK34x5G0gxtMNdnKlepyknZ31sA0G01p16j2tfn7SVG0qtG9On9Jl1qgVrtIilH2PZkVmCmJB3GN3l73TSQmK4e1VY6arAG9XiCPtdTBmA=
Received: from BY3PR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:217::28)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 07:02:47 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::49) by BY3PR04CA0023.outlook.office365.com
 (2603:10b6:a03:217::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 07:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 07:02:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 02:02:46 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 02:02:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>
Subject: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler ops to
 VM ioctl
Date: Thu, 20 Aug 2026 12:31:41 +0530
Message-ID: <20260820070143.3916329-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 3912c43d-a86a-46dc-8bb6-08defe890a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IIKojC2Hs9UNHr7AiXjX5nHIFB6CHHlG7G7gV44DpC85f/h54sA+Y5LI0EtIgT/T7agkcy9FJoAsDyvylnRCMyOJ0lcU8Nzhr8272uzrViJP/1ONqAPHoj2FLCbOPI1qSzmJJeneMJEgsBbLZorzu8rNQ5jYZnISaXv8fQds9okX3HJmYJ3Kslx+AZXgLLwJcYkFKgUqf7hoctG0v7U0j/RrgJlFuuVqjb0sHoA19nA7gbc1/st7x5XiFVZmvCtcqmMNHHnnbClrMgcr0vXkOOozPr0CZVZbruVt3Z2uoYK0W9mtMYwDjMNWBxzGwKw7n6yZWAa/YvqO9Zp3YKkvq0pthli8ev1Jq9a7uMSYYJi6yM0LqwbufgxM3EtPJwLIgHU2nYu1Tv8VLKFlSnHeThgqJFFIlR6yxylkwHnMHyh3CU8P+Rv9Hf9Wvio1I5qyyZbGC1J8qsNKA0GAZv7Ec297UHDTBe7uQ2PknOedrBMi2Ob+SY2SbQ92UXbVrNjGsQ2HDjr+tR7ZQNUo1R44aCxRpfk2IA+hz6XYOqxdgBdNOn04gjAAipy4riFqjkx5oBFhj9eUJsa2YCak3dr4DLj6zJXOmG0WjivZ09Q/ApMUGuuHPhVmrRIZec8SqAO687Q8O4h0eMw4VOgtsBkNxQYM686XWP8PYZbc9IcO+q4EdMccOQuGCfflDi58pOL48o6RK2YyKSa722f78ZFLKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BAbKE8Yc4pryskvdy02XPFLqMozaiZSzKFOdeMMSNL83I8p3Eai3pDfwEcM+LMmYXjYpcTkzbRoovd6VVgR7y+5/w0k/2woCaxdrglRc7gLXO33F04aDch7lKH5xC7OvvG8H6W831HnDWE60uYM91hkpeg1e8qVM7FUPJPnIfuEkhsXvcCB7PWYwG/4fVbbw0pmaWvPDuzc/Vx+o+4Q+CICw6VZ/apJ+tfIfJ1zYWXbk7ejuoz5aEMGSttElP/WpzOrz1DuZ9sfQ1aFN2J0BV8BJw+lk/91iPaos2o2U7+P+xiIgNDvvNJKNZmtsrNhlcgNHpr1Wzny8T/OXV+CBRGR+9+QEsHkCoIIHYObrG3N5bPUuCXluBI00P5bDpuP0eNQ4YlEfLZ7YU12SiFrCdwDXt8LTeSLQJach4lYzYimti/HUzF3NvgZRngJCIlKs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 07:02:46.5521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3912c43d-a86a-46dc-8bb6-08defe890a13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
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

When a GPU shader hits an exception, memory fault, or debug breakpoint,
the hardware jumps to the first-level trap handler. The first-level
handler (managed by the kernel via CWSR) checks the TMA buffer for a
second-level handler address. If one is installed, it forwards the trap
to that userspace handler, allowing the runtime or debugger to handle
shader exceptions without modifying the kernel trap handler.

KFD already supports this for compute workloads. Render-node user queues
had no equivalent mechanism. Add it.

The second-level handler is a per-VM setting — it applies to all shader
waves executing under that VMID regardless of queue type. GFX and
compute queues from the same process share the same VMID, so one
SET_L2_TRAP call covers all queue types for that process. This
configuration is not CWSR-specific; CWSR is only the first-level handler
mechanism. The correct home for this setting is the VM ioctl
(DRM_AMDGPU_VM), following the same pattern as
AMDGPU_VM_OP_RESERVE_VMID.

Add two new VM ioctl operations:
  AMDGPU_VM_OP_SET_L2_TRAP   (op = 3) — install second-level handler
  AMDGPU_VM_OP_CLEAR_L2_TRAP (op = 4) — remove second-level handler

Extend drm_amdgpu_vm_in with a 32-byte union for op-specific data. The
l2trap member carries the GPU virtual addresses and sizes of the TBA
(handler code) and TMA (handler scratch memory). Existing ops only use
the first 8 bytes (op + flags); the union is zero-initialized for those
ops. The DRM framework zero-extends when userspace passes a smaller
struct, so existing userspace is unaffected.

Explicit padding is used at every natural alignment boundary so the
layout is identical for native and 32-bit compat userspace.

If the TBA or TMA mapping is removed via GEM_VA UNMAP/CLEAR while the
handler is active, the kernel waits for the VM to be idle, evicts all
user queues, flushes the GPU TLB, clears the handler, and allows the
unmap to proceed. UNMAP never returns an error for this condition.
Queues whose trap handler VA was removed are not restarted.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: Ie039e496c75092c91c13719a16d541c5f06c3257
---
 include/uapi/drm/amdgpu_drm.h | 67 +++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9222be9a6d2a..872ff9d1d1ff 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -634,10 +634,77 @@ struct drm_amdgpu_userq_wait {
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
 
+/**
+ * AMDGPU_VM_OP_SET_L2_TRAP - install or replace the second-level trap
+ *   handler for all GFX and compute user queues belonging to this VM.
+ *
+ * The second-level trap handler is a per-VM setting. All shader waves
+ * executing under this VMID share the same handler regardless of queue
+ * type. GFX and compute queues from the same process share the same VMID
+ * so one SET_L2_TRAP covers all queue types for this DRM file.
+ *
+ * The TBA range must contain the handler executable code.
+ * The TMA range is the handler scratch memory buffer.
+ * Both ranges must be non-empty and fully mapped in the GPU virtual
+ * address space of this DRM file descriptor.
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
+ *  -EINVAL       for an invalid or incompletely mapped range;
+ *  negative errno if the VM reservation fails.
+ */
+#define AMDGPU_VM_OP_SET_L2_TRAP	3
+/**
+ * AMDGPU_VM_OP_CLEAR_L2_TRAP - disable the second-level trap handler.
+ *
+ * All active user queues are evicted and the GPU TLB is flushed before
+ * TBA is zeroed to ensure no wave is executing inside the handler at the
+ * time of the clear and no stale TBA/TMA values remain cached.
+ * The l2trap input members are ignored.
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
+			/** Second-level trap handler code base address (GPU VA) */
+			__u64 tba_va;
+			/** TBA buffer size in bytes */
+			__u32 tba_sz;
+			/** Explicit padding; tma_va starts at offset 24 */
+			__u32 _pad;
+			/** Second-level trap handler scratch memory address (GPU VA) */
+			__u64 tma_va;
+			/** TMA buffer size in bytes */
+			__u32 tma_sz;
+			/** Padding to fix total union size at 32 bytes */
+			__u32 _pad2;
+		} l2trap;
+		/**
+		 * Padding — keeps the union at a fixed 32-byte size for
+		 * future ops. Zero-initialise for RESERVE/UNRESERVE_VMID.
+		 */
+		__u64 _pad[4];
+	};
 };
 
 struct drm_amdgpu_vm_out {
-- 
2.34.1

