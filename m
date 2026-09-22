Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B77C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 05:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338AC10E92F;
	Tue, 22 Sep 2026 05:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WuSS5A1K";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A73310EB12
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 05:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idLqDTQjxx1Sl59a20x6E/7bdJLM3ceXCoWAJbcl8jwgPfPH7xehO25uDUNWQr0yps+dvNptTL6gRXXw/LP+3iV1M0Y/2Sn0RxXJCo+CATaJBTMpO9CJ6GIlFUY9EKbIhAlgspHmXmNtI3WQ1zYKUTtXyKNR5YugtlaDY5f3UrSmgtikRCTwjWxbDi7LwfWRvfFTlkR2xphCW72Hcj06mCXTXTt5Wjk/FNKv7SCGzi1DqkHD0Jt9fPoDSt4T2qNdfQoIxMUSTwZRmhcCHZ/Aq+rjACjR+vjWAU0qNye9VX9jfCiNC4rFxiu+pkEiW38DjFY4szalq22vGDRfJy/+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP37mYIfir8R6BcCix/XPX+rLpq1LtyuF7zOfSyQA18=;
 b=Apz8b9W/q84ePF3xhQzhFw48J2DZOGLTFQ4rhYLwhTMFMfR6bNyUVM7x/uluynXLnM8G8DZam2RObd27PsvztusGi2uCXm3kD5pqp8qQ80B3DMiOE36dYOQ6S7Uyp2oYd6zJK/Z4vNjvnxMZanGEhinwJSu/ImJcbI4wlu10i9N5EPvbo0nFjCD0Zwzsp/9zK60+q/JTGHanvlXZkgZDSawOrPZfgh4g1wncLtF8tPBH/CujbQMzcAXYnnzeKgA3HHwg58zbPoyieG+c46KsxOjsCA6HPr2EXFFcWivqWu2bfn0qzBgf0Z2P0gBxeBvsV7d//UAPR6hSC6n/vl2kBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP37mYIfir8R6BcCix/XPX+rLpq1LtyuF7zOfSyQA18=;
 b=WuSS5A1KA2zAhNkeXmfZxkG8ij2SLN0aqYqNltB3rfNKuzfC/zEXOhE67PvXB9txRFjWnw1OOC1f65H2gNxxehptr9WmQ8HO4gT+kysNS4uFGvvashx0w98AVz/M8Otz5Hp8gQPx7aTdeSnUsuorMYocjR9lm4SWQ8kLxwwiVwQ=
Received: from SN7PR04CA0153.namprd04.prod.outlook.com (2603:10b6:806:125::8)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 05:20:12 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::11) by SN7PR04CA0153.outlook.office365.com
 (2603:10b6:806:125::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 05:20:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 05:20:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 22 Sep 2026 00:20:07 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl
Date: Tue, 22 Sep 2026 10:49:33 +0530
Message-ID: <20260922051933.772319-5-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 7645e1c6-7d23-4381-c90b-08df18692d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4ibvVB/X+w+2vyq7CWka7JNh/+bERiqyUOTZfe6d+SJSTwhCTrgMei9E54zhEE9giFukLWO/g3/1QalwmTBb9Gh+wKrgjUmFQW42WkjrXj4YaF7Wc1Beb5RHMypUbyA2qkBB+ss337PCLrFxp3/acADeL5nbGsDXnIMnFn1t5Qt4ymHPqEueVHHOisQlMrkfNfR7sRqSlT9QmNuIcemIlWVf9qgcN78h2bzVdm7Juzh9yPFO2cxyVLOGVxHAaF5i5qnC+7IlipCffUjrzQ7gojlQEa46FkLQgcrJSC4Jv3Gk6+HPw8zZChd5uOKasJkYyq5tZiXYibQ31s5oYHF6DMadZKStqQOWkRl3FGv1Lgmb0CH+rsLlmYM/OwHjpwR3pHmBLrBwQnYIhby+xA5HeIfDGD6ReDSepNddhPmqdBK5oArDDgRSSMpxGq6Bs8nDHcUvJPfIwMcQLI36kfABfnWfnO67bWoj7+Yg4dP7ytf8VsryOOMO9yLiHZw0gzeHf3mmA+M5WuOMPVyZM23zlF/Jh4eqBwH4qhpVZf9cyV8zH93QkF+slcgzk+h+PNSxTTR99SaTQiJZ+BTmWbOc8Q6I5DPKlmi4V6FJj8Jdil2ht6XroksbYX+bN0z3IFlSg4lNQ8fuxVkCo0grabxSjT5c8cPxx+xMGPHLNW1J6K28/Ny88PF9nWEYSV0tii/5+LOIe/lZ2z967p2czyZx9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2gfzSmef5eagYnUh7iTTXLmRcgxoLSuGNuQqSFbIZVMU9rquwVJVO+4UuryyQVlZrZeEcVzoByIyE8kPGUWApRv1jaL9ENGpQkWJqRR3S1+QShCW4rfUuEDBbgTBBCFKJJKcxBvdbsztqvxQjnyucXVZYwehLKasdrKTAxzNOkUo2nzV34KDp8mNgRBjY1QyC1EKiod6+m1v54jjwtGdB9EjiUIHMAm7jcngGEXTPO3TUOfD/k/r0SYPEChVt1wZwGNg8X9/MrhnsYTnscblkH3YN2wIDDawmPdJMGdLKKfvdabUBq4jTTjjtsaZW21Djvc5widyu8U+QoamLPo0ogv1rsd0gsyBNZseKUtNaEvFTk3oIOqCwbXZZQP2HzgSUFuSqOf5V0oDJow4JzWTe6hLo8whE9gZoUZaDlpUSWlNVZJA49j54MT06s5Gn4WZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 05:20:11.9474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7645e1c6-7d23-4381-c90b-08df18692d46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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

The second-level trap handler is a per-GPUVM setting. All shader waves
using the GPUVM use the same handler regardless of queue type, so one
SET_L2_TRAP operation configures the handler for that GPUVM.

The TRAP ioctl and its associated structures are removed entirely; the
ioctl number was never part of a released kernel.

The TBA and TMA ranges must remain valid mappings in the GPUVM while the
second-level trap handler is installed.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 26 ++++++++
 include/uapi/drm/amdgpu_drm.h          | 92 ++++++++++++++++++++------
 2 files changed, 98 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 99a9605f8e15..342d0f174e8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2913,6 +2913,32 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
+	case AMDGPU_VM_OP_SET_L2_TRAP:
+		/*
+		 * Install or replace the per-VM second-level trap handler.
+		 * Applies to all shader waves using this GPUVM regardless of
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
+		 * Evicts user queues and waits for outstanding VM work before
+		 * clearing the handler descriptor.
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
index 42b2b09d05dd..8606d055b37e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -644,10 +644,82 @@ struct drm_amdgpu_userq_wait {
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
 
+/**
+ * AMDGPU_VM_OP_SET_L2_TRAP - install or replace the second-level trap
+ * handler for this GPUVM.
+ *
+ * The second-level trap handler is a per-GPUVM setting. All shader waves
+ * using this GPUVM use the same handler regardless of queue type.
+ *
+ * TBA is the GPU virtual address of the second-level trap handler code.
+ * TMA is the GPU virtual address of the second-level trap handler scratch
+ * memory. Both ranges must be non-empty and fully mapped in this GPUVM.
+ *
+ * Before updating the handler descriptor, active user queues are evicted
+ * and outstanding work tracked by the GPUVM reservation is allowed to
+ * complete. The GPUVM root is then reserved while the TBA and TMA mappings
+ * are validated and the descriptor is updated. User queues are restored
+ * afterwards.
+ *
+ * Userspace must keep the TBA and TMA mappings valid while the second-level
+ * trap handler is installed.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  -EINVAL       if TBA/TMA is invalid or not mapped in this GPUVM;
+ *  -ETIMEDOUT    if outstanding GPUVM work does not complete;
+ *  negative errno if the GPUVM reservation or queue restore fails.
+ */
+#define AMDGPU_VM_OP_SET_L2_TRAP	3
+
+/**
+ * AMDGPU_VM_OP_CLEAR_L2_TRAP - disable the second-level trap handler.
+ *
+ * Before clearing the handler descriptor, active user queues are evicted
+ * and outstanding work tracked by the GPUVM reservation is allowed to
+ * complete. The GPUVM root is then reserved while the descriptor is
+ * cleared. User queues are restored afterwards.
+ *
+ * The l2trap input members are ignored for this operation.
+ *
+ * After this operation succeeds, userspace may remove the second-level
+ * TBA and TMA mappings.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  -EINVAL       if the GPUVM trap state is invalid;
+ *  -ETIMEDOUT    if outstanding GPUVM work does not complete;
+ *  negative errno if the GPUVM reservation or queue restore fails.
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
@@ -1757,27 +1829,7 @@ struct drm_amdgpu_info_cwsr {
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

