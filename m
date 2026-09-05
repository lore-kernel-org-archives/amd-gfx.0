Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FABAC624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 08:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9876910E5C8;
	Sat,  5 Sep 2026 08:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n0+Bqkfw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A590710E5C8
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 08:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru9HVFSbkl7O/r2LKvLh5mjLX5/bMAns1/TXSaTTJNz+/gt5G0YNbc6Yl6UEpnl272tyJNMxHhhywKYkM3MBf5PZzuwSR5WbKhryqooPYRMxeGqJW3OfhYucrnfJ4qgR/RPFqes+ONhGIw7GgiCaIFOhMqTsWANxafUkwU/ee0fwYxInGAas6InctaivSZsOXH4eAKcb2XrkT/FoEW/DpZIDA4rY6CAXM4SntWeCI9opOI7+MxJwyff3DIJNgqamnV3a629oVgcZIPdVna20wEGmq82BwfqbhISlbNVui4wl4u42Lk15PwDGQjbTxhahP8oFu2czrcfT2oxvin+IbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orhYzPNf2uyJwPmju98Xvy1l4yTOvqP3vgwmqbs9Kzo=;
 b=zMEOm6hFRICT4dGG0asbxddzqmtCsvYfwG7JMpBv4Y9Cs1X4cp2Yt2eNyMLTPog9JwcXfi0CG+xmFQtMkzqF0ClklG/zy+gZufNEUoyRJjwo5J5UhFeIRFBCRCE4OWt6pgYojLxuNAJyc5dvq3FMqqbPVGdbDXZOfHcRCcsGDMk2w7H1f/xtwUCQR2YLItCfYdv2X7wPoM8Uh1TEwn5xaeIE9sfjMvBJaaTBB7lXqD2Ffpr6/cuxRT4P+hAAoo4+bvadLGLHZLhQKUsv81Worbzke2r7sm8AFdbDHZiDQDtDN0cM9hmzrIZkWG5IYikuBXpprzZVXdr0WCD5oxWttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orhYzPNf2uyJwPmju98Xvy1l4yTOvqP3vgwmqbs9Kzo=;
 b=n0+BqkfwYHKcv6VxsX5VYRfNmBYK/lAGbxrk5glrJwP9Zo2Z80iSxAxKTJk+CgpTsr3FJDqAwvm1s9LScgcFW5GVULeynls5bHYprYQApCJwcrXM1Z9b60GilnyDUiVcW8FUkyiyIMLYaXZNEP3AQq0AXeOBsYuEWGzKWB/fVoc=
Received: from SJ0PR05CA0134.namprd05.prod.outlook.com (2603:10b6:a03:33d::19)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 08:20:02 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::31) by SJ0PR05CA0134.outlook.office365.com
 (2603:10b6:a03:33d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Sat, 5
 Sep 2026 08:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 5 Sep 2026 08:19:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 03:19:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>, Samuel Pitoiset
 <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
Date: Sat, 5 Sep 2026 13:49:33 +0530
Message-ID: <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9827604e-3f12-4a30-fb2e-08df0b267a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K0mMR/IMebF60ZAY3fIbpd1l/ToDA9DbbA2eFbGTSnqIdV3eyhNeibBt8VPLe7vBag6WsxT3hCd1Wf5jINHvLf8CKrMFK/fJQbKHj8hUWJzlLMm8qw92KCCKBfP7owawWIUAne1poOuYPtAMvIAownOynhm44LRRd0ZdHtEoRC153N6jYBqSsgWWYI1Bgqz5IoxORJv2Qp3pWza0r/NttZ3Hl4cLJibFIIilCuXyQs5R946na3oX8uf5ZUngIHvv/VI9Jy7xlmgGkkNgmQMHSJ5rZMYri21AGVB2xmWGprvqzKJQLzkjCpWoqEuV77n6NPEK06BEJBKNB5+1Gxmw5vzuoRd1PPG7GYX9KrCyBCdUovstyacsZp1Ihv2HKpQT0g9CzchDd8llzX3EkosSbAt2MqwtyBeWcIH1zqT0hDqZUtJkM5ooMT9u1u0MsXyT0/kjzqUoZxUTtFPiKvJWIg0OjzGZ5lBp2fyxMiNeiSpMEuTU856FSiGm19DW9GHVEDi5eNwAWJtO19Wlc/Oz08ZQuB/AE4pvYZFRR1C6/D/kKdcOZpQ/Es5bbkTNxh5sFjD53OSUjhJEoDPC9HwclvH7hG0freLDoPya6VDyEDzpEbidIPRA5/Gf3if34J45OEgxYjdFnTg3tlurMGspPpjhLDvXTrZwucKdUzx+oi6Mw6F7jtwnxHPHxK5mbLxO9CjTbziwR0TIwkhFldtLqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5c8cbNcvy5EGLTX7EnFYeRZNTbSXAIyNodAjl9wViOvJLsThJHohvFoF127DrjoP06EUZTBjJ5oGVbxWJerBUnfJhoKw4NLscNk+rWGb6AnR9U2GGPqGKTLdz30U/0K7CytvxxQW9uKrMHBqtkcfxAmFQKKjWU5Yp3kRx+EZ8VDWg52svYZLC7wJiha4UdcDusMoO3rIaCgt7o31M86UI7f9t4LG9zaZqs/jI8GFXi3wLFVxLzYCMiaSh43VC9jfWKtEGv6grfokVkm0BBzWbZDzWOPvj2kxs1lWymnHnMn/jz5euU1JfMAfvxkHZUGIfaBmrTz6Z0W/lV4LQHRXBFsWVbXkcKSga2OLHLaF9mafwM2gHlGWn+7GLR3bZIG2uMrUZcBrO3DJVpaxljiQ94enWm79SrdziZvfvRHz2GpI0dQbcSW/1Su2/xvnm0Mt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 08:19:59.7280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9827604e-3f12-4a30-fb2e-08df0b267a4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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

MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler state.
On GFX10 and earlier HWS-based hardware, the driver programs trap
registers via SRBM select for KFD queues but no equivalent exists for
driver-managed kernel queue VMIDs.

Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own kq_tma_bo
there, so per-VM isolation is handled entirely by page tables without
needing to reprogram the register per job or per submission.

The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
(parallel to page table allocation) and mapped read-only into the GPU VM
at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-level
handler address into it via kq_tma_map when userspace calls SET_L2_TRAP.
The first-level CWSR handler reads this address to chain to the
second-level handler when a shader exception fires.

This design is:
  - Per-VM BO (not device-level) — same model as page tables
  - Fixed VA in each VM's address space — same VA, different physical BO
  - Read-only from GPU — kernel CPU updates it via CPU mapping
  - Treat allocation/free lifecycle identical to page tables

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
 5 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 3ca187f5ade8..5624a5ab5c62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
 	void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
 						 uint32_t status);
 	uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
+	void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_vmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 623cac6781be..e913488ca3fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
 
 	amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
 	adev->trap_info = no_free_ptr(trap_info);
+	amdgpu_trap_program_kernel_vmids(adev);
 
 	return 0;
 }
@@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
 	adev->trap_info = NULL;
 }
 
+void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+
+	if (!amdgpu_trap_is_enabled(adev))
+		return;
+	if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_vmids)
+		return;
+
+	hub->vmhub_funcs->program_kernel_trap_vmids(adev);
+}
+
+int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
+				struct amdgpu_vm *vm)
+{
+	void *cpu_addr;
+	uint64_t va;
+	int r;
+
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
+				    NULL, &cpu_addr);
+	if (r)
+		return r;
+
+	if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
+		iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
+					  (void __iomem *)cpu_addr);
+	else
+		iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
+
+	vm->kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
+	if (!vm->kq_tma_va) {
+		r = -ENOMEM;
+		goto err_free_bo;
+	}
+
+	va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
+	r = amdgpu_vm_bo_map(adev, vm->kq_tma_va, va, 0,
+			     AMDGPU_GPU_PAGE_SIZE,
+			     AMDGPU_VM_PAGE_READABLE);
+	if (r)
+		goto err_del_va;
+
+	r = amdgpu_vm_bo_update(adev, vm->kq_tma_va, false);
+	if (r)
+		goto err_del_va;
+
+	return 0;
+
+err_del_va:
+	amdgpu_vm_bo_del(adev, vm->kq_tma_va);
+	vm->kq_tma_va = NULL;
+err_free_bo:
+	amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
+	return r;
+}
+
+void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
+				struct amdgpu_vm *vm)
+{
+	uint64_t va;
+
+	if (!vm->kq_tma_bo)
+		return;
+
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	if (vm->kq_tma_va) {
+		va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
+		amdgpu_vm_bo_unmap(adev, vm->kq_tma_va, va);
+		amdgpu_vm_bo_del(adev, vm->kq_tma_va);
+		vm->kq_tma_va = NULL;
+	}
+	amdgpu_bo_free_kernel(&vm->kq_tma_bo, NULL, NULL);
+}
+
 static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
 				  struct amdgpu_trap_obj *cwsr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 7f83174a4742..9be5035abd1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -155,4 +155,11 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
 				    struct amdgpu_trap_obj *cwsr_obj,
 				    bool enabled);
 
+/* Kernel queue trap handler — per-VM TMA and register programming */
+void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
+int  amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm);
+void amdgpu_trap_vm_kq_tma_free(struct amdgpu_device *adev,
+				struct amdgpu_vm *vm);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index de3ef9ce2234..f5e228d4bfb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2640,6 +2640,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
+	if (amdgpu_trap_is_enabled(adev)) {
+		r = amdgpu_trap_vm_kq_tma_alloc(adev, vm);
+		if (r)
+			goto error_free_root;
+	}
+
 	r = amdgpu_vm_create_task_info(vm);
 	if (r)
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
@@ -2774,6 +2780,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
 	}
 
+	if (vm->kq_tma_bo)
+		amdgpu_trap_vm_kq_tma_free(adev, vm);
+
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index dd825e179979..064f95a83790 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -25,6 +25,7 @@
 #define __AMDGPU_VM_H__
 
 #include <linux/idr.h>
+#include <linux/iosys-map.h>
 #include <linux/kfifo.h>
 #include <linux/rbtree.h>
 #include <drm/gpu_scheduler.h>
@@ -488,6 +489,18 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/*
+	 * Per-VM kernel queue first-level TMA BO.
+	 * Allocated at VM init, freed at VM fini — same lifecycle as page tables.
+	 * Mapped read-only at AMDGPU_VA_RESERVED_TRAP_START in the GPU VM.
+	 * SQ_SHADER_TMA for all kernel VMIDs points to this fixed VA; per-VM
+	 * isolation is via page tables mapping different physical BOs there.
+	 * CPU kernel writes second-level handler address via kq_tma_map.
+	 */
+	struct amdgpu_bo	*kq_tma_bo;
+	struct amdgpu_bo_va	*kq_tma_va;
+	struct iosys_map	 kq_tma_map;
 };
 
 struct amdgpu_vm_manager {
-- 
2.34.1

