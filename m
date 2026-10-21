Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA7606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AY48OC8y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A4510EC4D;
	Wed, 21 Oct 2026 06:56:53 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010030.outbound.protection.outlook.com
 [40.93.198.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8486110E1A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDujb0UX/aeqVJn4rnh/qXidSNJ+bksdT5OUha9xRBGuawFNKLduRr6hX1oZdvEwsHv5d6lBYaxtwAqiBYKpitROWivHrvctaVjPYFhqzshArrkoxU5jUTeSzRwDLbKvodsT/qqDssWgcavfpWANWuA1d2/CeSw6G4EZaTwS3B1tsAenkA+24uftO3J0zy2TNWFJj2Gbg5xWl/n0cYy0wx+JGHEbrbw3hx/u9UBUW1Io91lxHjazYpS/zalvfozdkMVhApyJo6Q49L/DRrQZGzL70w2qZxyCTx3U/L0oAB2eEh1nsSAQ0b6aDQ4VXaWtUXc4PryOrzUGdmLgP/lStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Os54mVdY5JsYbOjAWr/gNZ8ZsTMDkq8S4fsNdqFHb3g=;
 b=eGTt/PKPkRD9JsKhSOhUDll2Bs31NRdgzp9NUUMQIYNP1Dh2oAmuLpFaB44ivuGDfNQDQLa7jgKRsCKYH1tt7LxcxjqYx2iWL5LfhBfhTD9saX5KDDc6TS/g7OuvZ5ResBjn9QV5eTRFY30p0dpDoNjhaEKVBjumHkEWAqkQaz0MG85ahvIQLBQ+Jgk1RXWoYxJSktbDnJd/yKki+1MVaLIEpyGrsmvHH5OhoOcZ835Yu0nTZCbFEyX8ZuzCTkOuIq8MHCTg9ksLXfiTZStPjn85uPEg1bVuGO+HM+uO0PVDZg5iTYgobjDkUdS2Xve5WHHzoBxlDsb0Aw2P4zYLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os54mVdY5JsYbOjAWr/gNZ8ZsTMDkq8S4fsNdqFHb3g=;
 b=AY48OC8y+dzgvEEMlc8olmqzUp9mNuJY4W6ypvfZdpGPnPiodhrrtvLHYjoAKPArHmk+glcMohH3DdQ0sU6c/olMgKtQOY2XRgb6K90cG3w02I3KVnIt9dKKrMgfkGpNtuDJu+GrtnumOoau7lgscOKh8DTePjP49nHDn27jwCk=
Received: from BY5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:1d0::23)
 by LV1PR12MB999327.namprd12.prod.outlook.com (2603:10b6:408:3f8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:56:41 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::9d) by BY5PR04CA0013.outlook.office365.com
 (2603:10b6:a03:1d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:56:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:56:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 01:56:37 -0500
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
Subject: [PATCH v2 7/7] drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl
Date: Wed, 21 Oct 2026 12:26:03 +0530
Message-ID: <20261021065603.1329111-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
References: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|LV1PR12MB999327:EE_
X-MS-Office365-Filtering-Correlation-Id: 9243d0c9-c471-4157-c497-08df2f407605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|260925021911599003|260925022911599003|260925021311599003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4zyK4s2WIiZax9115omLf1G8lLW+epQUJD9j4Uu9027kq5BAUf9WpVXcRFr7B/GyVh4aZaE5rA6YsEiYcultWfBInbaXIuF0jnxP9I1eRiAqQHe2Z3SSxwi1v0gaeMh5Q7QJoTyiVfaaLBG9lAUv0g7Wzoul/8Gy1g2sv2nodwWCtML5xkO7LLCkN4+MPX8kDKSPbVrirmdvcRqgu0t2UctBsCKXHK2wWBEgjP64A9T02PvQi49phvNKDwq66nVRCfNt7nSXqtIgqYh6yyOKtvq/LcTVQAwSv9DgyM15lY53JY+OxbQGv3LwqOwPQFNXG+Enosp9q3fK3DlsVa3hWhLwJ3YLMx6oYHDe0DVFNXbn/nIOapq0ixSF7B0x4WJ6e9BVq3kF73/KpwUPTmRb9KRrcYFyxsXpJUurrLw5oBBy9wcTk70rCQ0V3QJw/ZcuYj7KEGjKxS6xZNnl2pJYBGc4LjZnwMPqtx3FhSMaKEs4pQZjW1Z5TALFs3YdwOPVTZ+u0nUSknvRkpl7nHJ6kjYo/q6qG+FywpdZugaiXNLot9EncxTvY2b0aCjLSKnlEUAW7Pz68D6O1hY4N5MVwFwtxFPoIoN8oB+i/iF0h9aa+oHvt0V/4+ccB1EFn5ijPxJhyfknKahPlDAPpWqfGCifDbyLVtF8OSTCali6SEYIgZzqY2i8Vxj0saEjZiYzQowd+U91xYwZdWpXamLsYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RrT6lTVKxSl6icPU6/IXEmVCRONovjbA8vZuEx3vBYGPqMDKcTm6eaGlfdhPr+Ho8PLX3QHwjfkMtNSapZKGPXgz2LrFc8DjwRupX6hi1rFbUuNmHjBUD8sokCzPTqwztwyTN2/+Gaa4olwei2bxYsUiJxPho8wp70NX6ZaABGdK0lfCAtQJibiyxowUx6bXLiufU8ti244UG+jur6OCZKDxNCxA0CDR6qFsV0Q75cphx4wKZXbC+0HOM7NPoqHsJQ5jAFaT7S+gL1L/FP2rldMkZ7u5XeacBljgLRfKFIuO167uCDXgqsfJpkU7+XZOJammsWNccPMrfrJUzL/as62TfTx9xQcSj0x2Gty+HWHDySdZbAy0MDeEFcY7+6+2VXenA6qrlZdocXCnSFdKCW5GLbpF8H2O7mJV1TwBNjt9EB/yedXB89jdEOEnFCn0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:56:41.3138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9243d0c9-c471-4157-c497-08df2f407605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999327
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Change-Id: I0aa209620c2d4a8f9d006a8b120a26f055ceabc1
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 29 ++++++++++++
 include/uapi/drm/amdgpu_drm.h          | 64 ++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6fafd29ae25e..925b2e399ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3036,6 +3036,35 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
 		break;
+	case AMDGPU_VM_OP_SET_L2_TRAP:
+		if (args->in.l2trap._pad || args->in.l2trap._pad2)
+			return -EINVAL;
+
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
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9317018330ec..6c86d5731ca5 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -614,10 +614,74 @@ struct drm_amdgpu_userq_wait {
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
+		 * Reserved; keeps the union at a fixed 32-byte size for
+		 * future operations.
+		 */
+		__u64 reserved[4];
+	};
 };
 
 struct drm_amdgpu_vm_out {
-- 
2.34.1

