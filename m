Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01847606A31B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 04:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vvnMy3Tm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0E110E1F2;
	Fri,  6 Nov 2026 04:51:47 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E9710E1F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 04:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9KPGc2SicsBjXRVe5/Z9UNDFbxpqDomNjXBXyn0Mt0cZFH4hO8430ufHcVIKIzuqbDGek5Km49p7+fuLLMD0etXcwhEoPWABTYZYXbfnOF+vPHEXCW2UDhwttv0Py5nRzLbWpQ3xPp1+k4BgLuF6UkpBO8gGo4m61K3dRI8yjeAoRy0d24omNAV/SfON5uhYxfbsLM70v+CB3Uu93obae7QeQr+QupqdSwagXhmmpgm/wE/VlRtZVHpK1JJXB5hWdN/A0/HugvY6T3WnvbV5yYY+XKxbWNd1MjA/J1ugGf0gCndSXZhHp+eh9QPKfKJXU6rweuMMkcEjhljGxzBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JU6Qwsb7UqDghTjIqMf2GwoNU5R43nGKMD/nvSJ7k0=;
 b=rsiOh2o84CmDlOhnHmP7cx/g7dskkThAr5qu1t6VhhhfCvlAidz2R8YSHf1htsKXkzKUDvbrlezV9t7RRFA6GvnwSn+o85mbzOdvyPfJ5UGClFdEP9x+QCNnyQ3OLUOKClNGYL9BvSZny/BosSOqjvgmhI4WT8y77kSOgvevkPyXyb+TvfljgqiK4McxhagGvB0BC2cJNZJDeYRVBlTN/7FNEa4sPERw/0kna2zrb2jLSMknl83x/Io1+pK82SaabtqBKmPXqlCKYjbx22SGc3a34ZUtXe/QanBbobsxs/BeHipCo1tDaF/x9w8jnuoRro01Nq4HO03m12ayF9VCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JU6Qwsb7UqDghTjIqMf2GwoNU5R43nGKMD/nvSJ7k0=;
 b=vvnMy3Tmf71UOYYhoQXTiB3UiTzAad9VTZ0FmujO5ntPOeNcUgiHNmYOzbt9ynqR7Oh7yE35V6VS3D3uZNyQcP6NnnAGKS8UJE5DDg5XDuiuO167At98icXvJXPNWR9p/wTX5xz9iAjOmOnmz0DuyIKr1WEaZ1K/FXNNnsZRxn0=
Received: from CH2PR18CA0037.namprd18.prod.outlook.com (2603:10b6:610:55::17)
 by CH3PR12MB647349.namprd12.prod.outlook.com (2603:10b6:610:365::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 04:51:38 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::1b) by CH2PR18CA0037.outlook.office365.com
 (2603:10b6:610:55::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:51:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:51:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 5 Nov 2026 22:51:35 -0600
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
Subject: [PATCH v4 7/7] drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl
Date: Fri, 6 Nov 2026 10:21:01 +0530
Message-ID: <20261106045101.1562366-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106045101.1562366-1-srinivasan.shanmugam@amd.com>
References: <20261106045101.1562366-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|CH3PR12MB647349:EE_
X-MS-Office365-Filtering-Correlation-Id: 20675477-cedf-4719-b964-08df3bc1a4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|11063799006|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|56012099006|261022075727099003|261009223027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: nnVw+zQa6eDCtoUWjogg2OJ+yoBa96bgQpGNdiQld7drpsYm1DP8VGlc4nzm3PR8TdSFR4imbh7sQ7EbBL2d0AVsuQNtsTnu7tU41uxcCcFtQ9nI1pOfCT/iXDXm1grWrlo8oz7Bp9GffebpBFWtQeJsoO/b289ChvxSUbuAtvgqKHZ7avdQ1N0034kH0xt5+VrWA9vXcS1yZRPcI3Ne9YE3BqMviF47hes0WKbh+nebm6MPvjvKYhrxxXYwpSXSXMEvnln66Xr4dwdIi+PhsHu39iE5qT/S0Fp1bq5adZej1ooeOkoyvIED4rwAq1WhoXL0IOFmLOEbRF3JUQxuiHfWJZdC/xJynA4SfvlfHyk6kR6tfrXQAqkzBNC684aS1KZBhHG/KpVET2wNK0Wq/Vp/JYCE/yW6rkxMK43DWxAijvOjZCgw6Y+K6t0GoVCZfUywi4dDPlUDRIRuH1UZV23Tljn6SSIAQNsw6D3TxK41JG0PunlZpciv9lCTvIyluzRtBGgTlSqc0//Rnkx1SUPJOgKgJ0opT68eUioWFKYkgeFIdAXGbz144A+ufJlrSkvlZE8qDIhpKnwHsA690jb+1g+ueIEAJ6e8b6d9XL7EjU2FDo0glW9IkbXAMbJ+Ovd3HEQvIQMWkr7PZ4Y9iDzsofnJ2uQ/iWZkzJIRxQGwFwuOXT4MiTuKiSXcKfgQuMIMfmzBNI2oC716r5tk/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261022075727099003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vGO65YAgi1Vish2HgAm+J9hW35vGlLJ50qly2R8Ttdzm6mpEzyVqsSLJIDs4CfALIRVkLZdJ7b8HMTU7dePBFi+vDKE1uPw5psPwMwPSeNVQGJfW5ie7rc+m338HCN8qhePXQWLD1emwSmnhoxCnzXmeOIzr+XFbv/tVdvBuZoAoEqHA26+vUsWhomS68fOzhZUMrHQP1+0MivR/edyfnR7lA1ssUqPfEY48GtZ8BHLBgblAEdutCs0F2Dc4I7Hemxj9G2/z7yV4P8yRKARfRbJ5xNUnKBSHtnMupVju13fnbaCXs1nJOHhnvr7e6uthZu8cgtOsQavblk0elSZsgSpKEkpnxvM3GdFtrG0Wg+0kdTvAt/EIxcd/FZ9W0ko/G2tejNaRWFOINXukvO12vjKPLT9V33STNRXDUgOggn3qedJK+IQszyckAOEttFL7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:51:38.8330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20675477-cedf-4719-b964-08df3bc1a4c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB647349
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

