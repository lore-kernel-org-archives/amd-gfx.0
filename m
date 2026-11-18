Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CEE606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2w1mjuIr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E12710E7B1;
	Wed, 18 Nov 2026 08:05:57 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED9A10E77C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 08:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hwh50LeKvCeg6TCBirS2s3aVnPqkLtCQQRrlZZVneAIWPdi6oYAqk951buSlVe+63XVxMIA/MUYlWpVjTVg6nyW2S6htfjNqMWEBIi5O6CNN+AjD+dJCSbSLC+QGQU4SZm4gw+rb/6+zoPJ3oNyqCR8kiYwpDAFtVP/8t53yXa0oR4ugoveBH2b28PU8ahEzKmSE4pHPu18JbVrRjQGz8r2kbMx9+K1EKr/gwyWpl805spBrBNUZ64jkyPED6FG7fNPwI9Z1DnLAP67vvRBFPtN0iyo183UCseqCkQVweOeVFQBvdlUbbxb/14kct6gF9cgm3J675JybkPqHqNyKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JU6Qwsb7UqDghTjIqMf2GwoNU5R43nGKMD/nvSJ7k0=;
 b=UNCJ3udMqT9flQyYwVrTFd6SIr5PQvwZ4puIr+W2uzrDTsfCAAK9wOcf9qCTdsvRyNRRHo7L2PA/QMVwuT6zeevs4pw7W46c8VI2UNwq+1UkP1UD7sLA4V7rznEc1rrLQmdLe1U5h1ZwmvFyJ98K80rtDBXpUvs90tKPFEYT3gKTPl53tyOLXgpEDG+10aSk0xdrxYPsR1WboHFlR1Lg1KDw49WONRlcM7Cr3EyIsFvoaYOfnyJvef4YY+XhVEMrG3q6y6KYxta/YjL5YodCFtjOuj0H6UKYw5u6Hn6V6yEy9zw0np+G4ojkf/pv635E7Ur2QrN+6FN9dCap3CQqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JU6Qwsb7UqDghTjIqMf2GwoNU5R43nGKMD/nvSJ7k0=;
 b=2w1mjuIrmV+sc1mdCuPqHe0NzC6ezWBXjUytycpJVpE8RniW++VXui1O1tDajPKMEw3wDQkmH5AQ5EFpt5okSA4RqqWIK5XJSkn07pgyIYtlrhQ8PiTPSF0V8+pEcjYFsmR57MTkuCDmVvVgHWfmPbPWjSnShBC8cKkQsB52N5M=
Received: from BY3PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:39b::19)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:05:45 +0000
Received: from CO1PEPF0001886A.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::80) by BY3PR05CA0044.outlook.office365.com
 (2603:10b6:a03:39b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.4 via Frontend Transport; Wed, 18
 Nov 2026 08:05:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001886A.mail.protection.outlook.com (10.167.249.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 08:05:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 18 Nov 2026 02:05:41 -0600
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
Subject: [PATCH v6 4/4] drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl
Date: Wed, 18 Nov 2026 13:35:13 +0530
Message-ID: <20261118080513.1677783-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118080513.1677783-1-srinivasan.shanmugam@amd.com>
References: <20261118080513.1677783-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001886A:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be6819b-88aa-4315-9ffe-08df454abf3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|261009223027099003|18002099003|260925022911599003|260925021911599003|260925021311599003|22082099003|261026140227099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: IHhK9biYhPu/zrxE9yLcbC/aHg/OMTsJZnj3HMfsnWqbfYCTVh6agOZ1SDZA42u26kXxGmkXhW1MzcC3StXyrZnLEcCrs/13exN0M1Y+65A0a9rPAnNNpWLEVV1FTYop0xl3+QzuIkrvuljkSkRe3fYsoH90gmg6jNotBMdGgDoVCJ1Iepbd9+z8gqkd08E6AfBpmLitFioZqxCytGMz1Zhgi4BII+GWgTGA2cQ44pLEayQUPL9qvKugeROZkODWp7ntOHg4EKbhD/+73d05UKBXvyC4p7b9YMGg8086BlJ7BGGh0kCga6pBu7jMbE8UgS3T6ir7leZU+qG6qSzIpvQdn65GJW8ftn4CS75CLyapR6hBKaEKOWH+FEiSRIb95nffRHHRvU0XWa6kAw9BcXfRINHUmmzuinansiAggqU8OAIFD6uDVTq2MnQzCxznIdEdYWyiiVUhshw7h5Bgnp76ies1zaMPj6BPWx+AooyeidLVSsUS9Yf8aau0K3WiY2GfBaptNLlK95oApTEEyZ00K/kyJatJhLTxendo9kN7SRUUSLmQRo5+N1SgICoRF9aH2RWxj31QjsFtpOv/i45DIEb6Edfd6QvOWHLuraenjPH2bNvyEBoWeIhiVpDPwteKy/L3zuYlOOfq2AYCl4xAQlr5cuUuQ7XIAyoGtpKVzqsUlXp2gIBzc7h+GB5f2mc9lM9IoSISoLPE09vq4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(261009223027099003)(18002099003)(260925022911599003)(260925021911599003)(260925021311599003)(22082099003)(261026140227099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FMRYgJohOQJhUp+lpFbf/CPKy2H4Cdm/aebU7G7QdiFHIIjN6qPQ1kSR8hXDTmnj2p/6mrdhSF+B62R8lPl1rPbWgUXAVuG2miFxrw5NqJTdUC4iWm7pdh5/+IFVLA7dlTc3fgO2edwXswsQAC9vgggkhpZ0Yjb6chI/sfU7QCd6ZUjM72enj7G5Wasgbc9MgBXCohVRxx9VqkCQK3mGUeQn1nq7RcvNktnH4yLMIprp42SeBnPKpFZMotVLk3DiQNSXNSNva3LIQuamlm/lgz7eGJSwyFnjx1CthTkfURftI7rgvbnJR8kH5iSwqZHeS8Zl6kCYDbss7ztae0R6EFswUzWBjCbDsg0/b3Wzkzd3vDLk8tbvcwc5AxPiqeV+Dqgh7KnjzzImf2vAQkUxwTZmRWGle6nJi/eECBmMYcOlnlgC3ogQmwEad28umMSG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:05:44.7046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be6819b-88aa-4315-9ffe-08df454abf3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001886A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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
index eafd4367d3b1..df3a8dda606a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3064,19 +3064,53 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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

