Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5BF606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CWPcY/Ys
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E060910EBA1;
	Tue, 17 Nov 2026 17:00:11 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A92110F7EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCUB8rgUI62e6Xn5zsv7xkb73rppwuhml8QhbCO93TELP4ffop5Bet/fVWhmUEjBF3dX+kqgBqbL1XX1JoW81yzSyD0HVibqAVrFYnUbE3V6v3pxHcP8RsMdH0qJslLi1F0KZlvonfp3+IpXSBaUW8/us/LB19jR18GRmDtniO0MMcrsW9Y9pnvxCIba7qY6AT1tlnzGWSpPyaD6MXIKFaIfb2rEynMKvCG2uFrwj2B7iyl/LoRlGiHbIyeVfrcsAzmnts/EdEMIU5jJmmQ4ufqC9qR5GZBUJ9WQB6TrWRWrC8oijh5Uoix5Ki6FFNEL73T22xGP4aXiJQW4BnTSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lARpOZeVmraL+6Gbek+h1tZLNCn5jPknw+/NSZyEcy8=;
 b=gr3woug1eXUhW5knxx7D1sUsEVSwC7cs3qX9AoTA6M4+lFiM1jtEmzlIEuDSBVMeueGcU79mf1mWu3nnNeFsitEgLTOr/i6a7exdNfu9icOKgSgGdCi8YdKR7Vi7Ax/l9E6P8Zdcb3F4vPAp+FrvVB14dAbbc43GOdDFqtJgWYZxNoPSlShI1sVe2ZyzCSws2ZsfwlDOela1fNQFn/0b32U99pNmTWNYMOIh7mmEE4ARCH6CX0lScPjfz5EXnAT8uq2eKfMWxmNyptXClg/ff4IWc7DZzgF47eTV9ARBoVgYkU3xOIzt+ek+j3Ac4iRFiYorcInXpXhXkeHjgORLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lARpOZeVmraL+6Gbek+h1tZLNCn5jPknw+/NSZyEcy8=;
 b=CWPcY/YsWjNyWErnab+fM/Ia3K2mjFvBYe3oYizEhpDyMDsVr/MuIq0KRi6HR8zUGvhZE9ufG32YfN4vvjaM0HKaS45uNS2+lDRkVAw4cTZdQypUHm9zdfX4iT5g59v8R6mnJ/3l653qWaxSKbQCDg5MnTbCZQ4PsVgK0oIDQLU=
Received: from MW4PR04CA0358.namprd04.prod.outlook.com (2603:10b6:303:8a::33)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:00:01 +0000
Received: from MWH0EPF000DD30B.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::24) by MW4PR04CA0358.outlook.office365.com
 (2603:10b6:303:8a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:00:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000DD30B.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:00:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 10:59:58 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 10:59:58 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH 2/3] drm/amdgpu: reserve and bind the SPM VMID on every
 GFXHUB instance
Date: Tue, 17 Nov 2026 11:59:51 -0500
Message-ID: <20261117165952.3558762-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117165952.3558762-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30B:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b0d92b-10f5-4fa1-f1ce-08df44cc37f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|261009223027099003|5023799004|56012099006|11063799006|261021123027099003|261022075727099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: y051J7WrrHK8fEIDbdFzj7Pc9uoFJ5t2qqjQY7evF2N9mf9PVFRsksGuVSNjnRCDF5tkM5NuoutD6o74N2oGSbCBagkjW727ODYn5bOeEEF/yA99qHEYlmvOcpIx+wHv9LjTVaUc64DLEXHKsT5tEOe1xSCtGTsfHvmYUE1XWwLJWnIYutU6CFpD+YS8LXzeWW8lcq3k5XFGtZ6EjiOgpBy32T00Ts3SofcZ/5ssIkPhHxZMPwg2+Q+wJpWKBWUhHrbgcP6URLK490g6hdkqqv2Zi8y6PeQOIOosdiaCs3ethrzFGDChTNcKBxFMX8WgQffZ296SAWqONkxwqVLCYnF2V0OOmFCdO+AmuE+s2U8IJGksH3mtSI21VPF3NGDkZBDqFwpTgfcrjCVoHiaQXMWMxkGjBs3nv9QFVAXCGMgI7/fyWtl7VEwlvuwPS2ZyA/LxReVjpDm0YdU6eMSQ2B6cJ20qkA3RIoxMXjFVm6NOUcOka92qO0Hcgj6NtO4QNENCOVW3kprpb5n9ixheZ2lrBFpgXerzLLDeSye/RnSUZJoNjPXTOPnQ+T4C6bdFQbM9VDDU6q5ix0h8+9yjciihQvZwEJ3awtrxXa03zmxtVqfz/dwRkkYFSfbKSMiwuiUiexgg5wVMxYUdWCL/EiqcT+4LPqEvciRm5lThDuuAt6g4b00D81BXFZ4G/1QX0sLTEgH446WcvNRcf/y1pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(5023799004)(56012099006)(11063799006)(261021123027099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R0n+hSG6WXUNPOB6+JmrC0uMBLKQ6aMFE+UKpryLXDWxzU2Fpn9rNgZrCvCbQ9c9qfdlcbdcVDD8IrjAjxpyavXq9Itsk/69jobYOkx4y6ELGxHFFODuHs1fG45bxTeBVFhmcMEZ+xc5ImfyNGHfVvS7z+bsBQMqGMd3TMsRpHmleJQs4Lj1P4Fbxzt9GzdjSasFZQtSINiTBRuvGsEHiJCsGj1V+B8iuD1DdF95L73UxVSWGJxvkXX+gTiESjA2rAi+8TdWyKkrQcQvC8JLazKDwvyYmGmPKUZBCZUy+nAqZXKNpjDXWPtF8QbJaFzTFCXjtnMCBCvyvhKDbwBynoo4AlHL1YtCuKuwYTSMrLBWuHUikDicAiO2CwdYXxJOj6eYIgP+QCJc54j4MiMHiwRBWOK6jTlg2au6BKTx5En/e1x/kHdG1xpxHI/0R1CL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:00:00.9869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b0d92b-10f5-4fa1-f1ce-08df44cc37f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
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

The SPM VMID reservation made through AMDGPU_VM_OP_RESERVE_VMID is
recorded on AMDGPU_GFXHUB(0) only, while gfxhub v1.2's
setup_vm_pt_regs broadcasts the page table base to every XCC. On
multi-XCC parts the two disagree, in both directions:

- the reservation only takes effect for jobs running on XCC 0, since
  the VMID grab path checks vm->reserved_vmid[ring->vm_hub] and the
  rings of XCC i use AMDGPU_GFXHUB(i);
- the page table base is physically programmed on all XCCs anyway,
  and conflicting reservations are only detected on hub 0's id_mgr.

Make the hub argument real end to end: amdgpu_gmc_bind_vmid() programs
only the given hub, through the XCC-masked gfxhub callback where one
exists, and amdgpu_vmid_free_spm() unbinds the hub it frees instead of
hub 0. amdgpu_vm_spm_update() binds every GFXHUB on which @vm holds
the reservation. The VM ioctl reserves the VMID on every GFXHUB
instance through the new amdgpu_vmid_alloc_spm_gfxhubs() helper, so
the reservation now takes effect, is bound and is flushed on every XCC
the VM's jobs can run on, and a conflicting reservation shows up on
whichever hub two VMs share.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 49 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 40 +++++++++++++-------
 4 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 08d3ff61edcc..704a30ad388a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -797,6 +797,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  *
  * For VMIDs that are bound directly to a VM's page table outside the
  * normal per-job VM flush path, e.g. a dedicated out-of-pool VMID.
+ * Only @vmhub is programmed and flushed, other hubs keep their binding.
  */
 void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
 			  unsigned int vmid, uint64_t pd_addr)
@@ -805,6 +806,9 @@ void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
 
 	if (is_mmhub)
 		adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
+	else if (adev->gfxhub.funcs->setup_vm_pt_regs_xcc)
+		adev->gfxhub.funcs->setup_vm_pt_regs_xcc(adev, vmid, pd_addr,
+				BIT(vmhub - AMDGPU_GFXHUB_START));
 	else
 		adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9c879ac68352..41f3dba530e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -651,12 +651,59 @@ void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		id_mgr->reserved_vmid = false;
 
 		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
-			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
+			amdgpu_gmc_bind_vmid(adev, vmhub,
 					     adev->vm_manager.spm_vmid, 0);
 	}
 	mutex_unlock(&id_mgr->lock);
 }
 
+/*
+ * amdgpu_vmid_alloc_spm_gfxhubs - reserve the SPM VMID on a set of GFXHUBs
+ * @adev: amdgpu device structure
+ * @vm: the VM to reserve the ID for
+ * @xcc_mask: XCC instances on whose GFXHUBs to reserve
+ *
+ * Reserve the SPM VMID on the GFXHUB of every XCC in @xcc_mask, so that
+ * the reservation covers every hub the VM's jobs can run on.
+ *
+ * Returns: 0 for success, the first per-hub error otherwise. On an error
+ * the reservation is released on every hub in @xcc_mask again.
+ */
+int amdgpu_vmid_alloc_spm_gfxhubs(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, uint32_t xcc_mask)
+{
+	int i, r;
+
+	for_each_inst(i, xcc_mask) {
+		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(i));
+		if (r) {
+			amdgpu_vmid_free_spm_gfxhubs(adev, vm, xcc_mask);
+			return r;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * amdgpu_vmid_free_spm_gfxhubs - undo amdgpu_vmid_alloc_spm_gfxhubs
+ * @adev: amdgpu device structure
+ * @vm: the VM with the reserved ID
+ * @xcc_mask: XCC instances on whose GFXHUBs to free the reservation
+ *
+ * Free the SPM VMID on every GFXHUB in @xcc_mask @vm holds it on, hubs
+ * without a reservation are skipped. The same wait requirement as for
+ * amdgpu_vmid_free_spm() applies.
+ */
+void amdgpu_vmid_free_spm_gfxhubs(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, uint32_t xcc_mask)
+{
+	int i;
+
+	for_each_inst(i, xcc_mask)
+		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(i));
+}
+
 /**
  * amdgpu_vmid_reset - reset VMID to zero
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index c134000eecfd..d2b225d0aa38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -129,6 +129,10 @@ int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub);
 void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub);
+int amdgpu_vmid_alloc_spm_gfxhubs(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, uint32_t xcc_mask);
+void amdgpu_vmid_free_spm_gfxhubs(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm, uint32_t xcc_mask);
 int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		     struct amdgpu_job *job, struct dma_fence **fence);
 void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6b4dc0276e27..bd9aa35933dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -589,30 +589,36 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
  * The SPM VMID is fixed (adev->vm_manager.spm_vmid), so its page-table-base
  * register must track whichever VM currently holds the reservation instead
  * of being set per-job like a normal VMID. Bind it to @vm's real root PD
- * address if @vm holds the reservation; otherwise do nothing, since @vm is
- * not the one that could legitimately change the current binding.
+ * address on every GFXHUB @vm holds the reservation on; hubs reserved by
+ * other VMs or not reserved at all are left alone, since @vm is not the
+ * one that could legitimately change their binding.
  *
  * @vm's root PD must be locked by the caller.
  */
 void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	struct amdgpu_kq_vmid_mgr *id_mgr =
-		&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
 	uint64_t pd_addr;
+	int i;
 
 	if (!adev->vm_manager.spm_vmid || !adev->gfxhub.funcs)
 		return;
 
-	mutex_lock(&id_mgr->lock);
-	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)] !=
-	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !amdgpu_vm_ready(vm)) {
-		mutex_unlock(&id_mgr->lock);
+	if (!amdgpu_vm_ready(vm))
 		return;
-	}
 
 	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
-	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid, pd_addr);
-	mutex_unlock(&id_mgr->lock);
+	for_each_inst(i, adev->gfx.xcc_mask) {
+		struct amdgpu_kq_vmid_mgr *id_mgr =
+			&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(i)];
+
+		mutex_lock(&id_mgr->lock);
+		if (vm->reserved_vmid[AMDGPU_GFXHUB(i)] ==
+		    &id_mgr->ids[adev->vm_manager.spm_vmid])
+			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(i),
+					     adev->vm_manager.spm_vmid,
+					     pd_addr);
+		mutex_unlock(&id_mgr->lock);
+	}
 }
 
 /**
@@ -3018,7 +3024,8 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		int r;
 
 		/* We only have requirement to reserve vmid from gfxhub */
-		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(0));
+		r = amdgpu_vmid_alloc_spm_gfxhubs(adev, vm,
+						  adev->gfx.xcc_mask);
 		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
 			amdgpu_vm_spm_update(adev, vm);
 			amdgpu_bo_unreserve(vm->root.bo);
@@ -3027,14 +3034,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	}
 	case AMDGPU_VM_OP_UNRESERVE_VMID: {
 		struct amdgpu_bo *root = vm->root.bo;
+		bool reserved = false;
+		int i;
 
 		amdgpu_bo_reserve(root, true);
+		for_each_inst(i, adev->gfx.xcc_mask)
+			reserved |= amdgpu_vmid_uses_reserved(vm,
+							AMDGPU_GFXHUB(i));
 		/* Wait for the jobs which might still use the reserved VMID */
-		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
+		if (reserved)
 			dma_resv_wait_timeout(root->tbo.base.resv,
 					      DMA_RESV_USAGE_READ, false,
 					      MAX_SCHEDULE_TIMEOUT);
-		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
+		amdgpu_vmid_free_spm_gfxhubs(adev, vm, adev->gfx.xcc_mask);
 		amdgpu_bo_unreserve(root);
 		break;
 	}
-- 
2.34.1

