Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C304606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E1K9HiQc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B269210F316;
	Tue,  3 Nov 2026 02:30:09 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960F510F316
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TludWESajL7bN+LNQ0M11hkkOSRCEftJGDROZ42ub3+8tx3kGM+DLPjnBWlSMMqODviaSE+4tvGvaY3hadnT01PW/38mVb3YUEa5rot6z2U9fq61Ziid7q8Czo/Ijeupv38VZ4LDGV/STfoz47Hun/ebCm52XM379L88NuEMveg+UFA/TIhEMw6RnA1i84x4zuyWO1nDueXVUEXDTEm271vTg2apJDzjtaX7v/sTF8t2pYI5LdicwX0MQZFhsRlpn9WtoiqmLsXIOWt20cnv1y6TCpppdx4cAU7DjIT6doYSmOrrjdN+YNFz4a3jaR5HoWNlTRT1LpSpHo7tVeeQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Min/jNoEs8yNGQyTos8wE2Wg8j1wHxycWia//kc3J28=;
 b=Tbjy8x7BsKWyww623tkvJUEJWtx9p6bVuG7pMzO1fZuRlcce/anrabI+3L2/mxFzOv6z5hO8R7AyUQkFo78V00asMxOjzORUgZ1axCuXrH0mChCOT/SEU+Rmrnx2mU+mwLVPZFpvASthZSeELjiwZJcZ2xCIA5wBUUxrhX0tPl6pu74ySPcFI+HySDDWPz7BX29w5GCabUhEYEtBwHZD2JIW4Kt++LlbhP4R895AwgEyIA2hq5KTapS56h6Cmtfd7FXtEAOtZrbAu8L1o3b073tLBavFewNKY2aXPf/EmAYjRosW94oQA/DCEaubcojS6l1GVW52fyn3mTOdid6PVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Min/jNoEs8yNGQyTos8wE2Wg8j1wHxycWia//kc3J28=;
 b=E1K9HiQc1xB168BMYl93CDokEvjozL4B2Sq2VCo2jqvQFnSm67e9vda7wnwbX2fDPvDqBjd5Sce3vmy28AxkNDIoU9CBLPqzamDjiU0TFtGa+v0uUIJr+pV12/XGYNi7vOdQ0m0QbLEZXNLEKhqyoYZpd/Z4s5bpYur1/PQzodY=
Received: from CH2PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:4e::20)
 by LY0PR12MB955947.namprd12.prod.outlook.com (2603:10b6:404:221::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:30:00 +0000
Received: from CH01EPF000BE943.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::91) by CH2PR02CA0010.outlook.office365.com
 (2603:10b6:610:4e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 02:30:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE943.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 02:29:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 2 Nov 2026 20:29:56 -0600
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
Subject: [PATCH v3 7/7] drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl
Date: Tue, 3 Nov 2026 07:59:24 +0530
Message-ID: <20261103022924.1495748-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103022924.1495748-1-srinivasan.shanmugam@amd.com>
References: <20261103022924.1495748-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE943:EE_|LY0PR12MB955947:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f04348-bb65-43d1-83e4-08df39525bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261102123227099003|56012099006|260925021311599003|260925021911599003|260925022911599003|11063799006|261021123027099003|261009223027099003|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: f14MKZkduIc1ZuHxa9GpaRZ3li1X7lOVGf6UB9RR7/WxlaED1v8MFQwxmKW8NEPKQZ8jFlnS3/jFsf9no7pxQQQAPjxJGYe4roZt7RtafYUVrOZY3IY/XJS41weilOqdSir18ZbujzGOL8xJ6RHLOcDcr2PoXD9XtlkHowSYHkRC43Sf0REGlOiEG3f7o3/94s1rJzaHeipt8jIkiPywoNTC881zLtqWN0QTYbJF04iKJhlcVFY7Y9OFSZUOHdzLNGuh+R13PDsyiyGdwoe6ELNANk9XvvM2f+8re1TxWiYuPd6M5ZcHHZSY4kTp9HbfsCLQjznoQ9/5/ucDgisVXjDoUB5OXhvO55kN75Bt0hUH0jfuAK3hi5Vl4Su95SYZoq3+GHdBl8b0/ii/bt7M90w7nyGwNZuDZavdjVZYXfOnNM8z4E6Iiu5fV7BNve+ACFQDd3AtxanlQ/uJymbTXQqVzXQnV7Vn8w1ZekQH56M9GGcJKb6xWJtEX9XXaJyx/nnVdvR/wdTB0wG+2cqsc4cQ7HiF7BPe/N+D25bZg/ePYa856touckVUxoCVH1jWXe+2I72gZ0a3xNd+y13D5GUWS7cNv+OXKowfkpkiWx+lHy9Vkg8EnYd9aJkRGCptIiQPS7QEV4iMw9B3JsyZdQAN+ePHxwzU4trkGrjvE2/W9VEICJFL15jRd7RFRvzFOXIQWhL4C24KfXRZ27bq5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261102123227099003)(56012099006)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(261021123027099003)(261009223027099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Hh5wsErwhWjFIXOZqas1ymu9uLo361+BruxugHkXaOrkqNKa7DY4l8C0TAGxNOfk1HIPpyHN2Xuf3+XBF9ZdPdO98B4bxHSoeOwe3slGluIDxMScVwvsFXfITMaUAKyEoCHe5lpn8sVtloqKErxyYSAi52C/NpfQjtRhYrnkoi833g5gJzR6DB6+diKQrrLm/bhgPsF+iIuBgKK8P6hYDCIQj7cxWq9G/aCJ2cYWfusW0n0PerowJRueuo4ZQeyy8O+Z+qz7gm11cfrcdUEzUZ8CTTmo9R1LHXznPE9SgjUTpVLKkC0kGrBVajyDYIJeGM6SiUUPCwK/6V1jl5GA1wruV4Lv0y2AJj2p2ZUAY0ItyXhzzmqb526H9MOATHq/TnIdwim083PX7vTKauB3FNJOqxZMr03Hdm81ZNaCZSolpIZHqxNvPqd3U6zfUPV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:29:59.7471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f04348-bb65-43d1-83e4-08df39525bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE943.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB955947
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add SET_L2_TRAP and CLEAR_L2_TRAP operations to the VM ioctl.

The second-level trap handler is set per GPUVM. All shader waves using
the same GPUVM use the same second-level trap handler, regardless of the
queue type.

SET_L2_TRAP sets the userspace TBA and TMA addresses for the GPUVM. The
kernel checks that both address ranges are mapped in the GPUVM before
using them.

CLEAR_L2_TRAP clears the second-level TBA and TMA addresses from the
first-level trap descriptor.

Userspace must keep the TBA and TMA mappings valid after SET_L2_TRAP.
The mappings can be removed after CLEAR_L2_TRAP completes successfully.

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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 36 ++++++++++++++-
 include/uapi/drm/amdgpu_drm.h          | 63 ++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 188b7ac347a0..c06e0ba4c299 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3056,19 +3056,53 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		}
 		return r;
 	}
+
 	case AMDGPU_VM_OP_UNRESERVE_VMID: {
 		struct amdgpu_bo *root = vm->root.bo;
 
 		amdgpu_bo_reserve(root, true);
+
 		/* Wait for the jobs which might still use the reserved VMID */
 		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
 			dma_resv_wait_timeout(root->tbo.base.resv,
-					      DMA_RESV_USAGE_READ, false,
+					      DMA_RESV_USAGE_READ,
+					      false,
 					      MAX_SCHEDULE_TIMEOUT);
+
 		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
 		amdgpu_bo_unreserve(root);
+
 		break;
 	}
+
+	case AMDGPU_VM_OP_SET_L2_TRAP:
+		/*
+		 * Install or replace the per-VM second-level trap handler.
+		 * Applies to all shader waves using this GPUVM regardless of
+		 * queue type.
+		 */
+		if (!vm->trap_obj)
+			return -EOPNOTSUPP;
+
+		return amdgpu_trap_vm_set_l2_trap(adev, vm,
+						  vm->trap_obj,
+						  args->in.l2trap.tba_va,
+						  args->in.l2trap.tba_sz,
+						  args->in.l2trap.tma_va,
+						  args->in.l2trap.tma_sz);
+
+	case AMDGPU_VM_OP_CLEAR_L2_TRAP:
+		if (memchr_inv(&args->in.l2trap, 0,
+			       sizeof(args->in.l2trap)))
+			return -EINVAL;
+
+		/* Disable the per-VM second-level trap handler. */
+		if (!vm->trap_obj)
+			return -EOPNOTSUPP;
+
+		return amdgpu_trap_vm_clear_l2_trap(adev, vm,
+						    vm->trap_obj);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9317018330ec..b576d62bcd87 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -614,10 +614,73 @@ struct drm_amdgpu_userq_wait {
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
+ * memory. Each range must be non-empty and contained within a single mapping
+ * in this GPUVM.
+ *
+ * This operation may block until outstanding GPUVM work completes.
+ *
+ * Userspace must keep the TBA and TMA mappings valid while the second-level
+ * trap handler is installed.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  -EINVAL       if TBA/TMA is invalid or not mapped in this GPUVM;
+ *  negative errno if waiting for GPUVM work or reserving the GPUVM fails.
+ */
+#define AMDGPU_VM_OP_SET_L2_TRAP	3
+
+/**
+ * AMDGPU_VM_OP_CLEAR_L2_TRAP - disable the second-level trap handler.
+ *
+ * This operation may block until outstanding GPUVM work completes.
+ *
+ * The l2trap input members must be zero for this operation.
+ *
+ * After this operation succeeds, userspace may remove the second-level
+ * TBA and TMA mappings.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  -EINVAL       if the GPUVM trap state is invalid;
+ *  negative errno if waiting for GPUVM work or reserving the GPUVM fails.
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
+
+			/** GPU VA of second-level trap handler scratch buffer */
+			__u64 tma_va;
+
+			/** TBA buffer size in bytes */
+			__u32 tba_sz;
+
+			/** TMA buffer size in bytes */
+			__u32 tma_sz;
+		} l2trap;
+		/**
+		 * Reserved; keeps the union at a fixed 32-byte size for
+		 * future operations.
+		 */
+		__u64 reserved[4];
+	};
 };
 
 struct drm_amdgpu_vm_out {
-- 
2.34.1

