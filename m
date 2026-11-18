Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5960A260A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uJpdKQbJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2220D10FE63;
	Wed, 18 Nov 2026 16:24:53 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012035.outbound.protection.outlook.com
 [40.107.200.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59D210FD85
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 16:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qaa0SEfm2H6Wz6f1NKIO0ARvQeW5AjhCCyA0LXRxs2+XKTbpKCC0O7bbYy8mAIIZGfmf6ThPCqINXXeGkr6GpR6BSMiptPBhXdAVehDVr14y/p5+gQHD6URLSkj/aCPD6SXhRq7yWZPUxPlfxSp2UOsrvY2/e+T5fm2z3gpOZzzXf6/OyDeeRzRiNcleuWvOCRMpE3rlcLjucL6AP+dhX8XM/7yFcwOJkvZm9h2Lr78LCSMZPWEzbAOXFTurx8kZv516pcYoRXLbmANL5PvgZHmOwKPZOHqj2cVYP8n2mRVtb8KOanxGfyJ5nsNuhOiDjrkmXich6fZkuP8joSc68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ishtDhXl19bB7zLJcvptjHe5vneHbr+hYjE1/L5fVVY=;
 b=IhtLDNV0ljgU7Ip3OMJDSaxuu8KockTBIp1HSZWQsRKvIdJ6IfEKfyjMNVNIL5Ru3FWeHIdBxC6/P3vZ3bu8KEbOqIbwvAG2JD+flD+k4zQ9C9lx38MSJlvPTO0UYPaBcagYBXtPkJU6Li3orQBcW6XXtLirjAF5RSMMBkLTSo3swlj7jDl2YUz0o1Jpn7gyRWZiG1ne7hUf9FZrfDCQjhuz0aB9YTeautlZ34sYrtdimYn13jnxNfFCF7+PpHYaI66ayDg4V5KiLCB86LhVXIeOgkGN8RwHFywoNYSL9rX0iPc+1WaLCxvOQ06PNRWSY5KtfxMKs0KzA8AHDLpVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ishtDhXl19bB7zLJcvptjHe5vneHbr+hYjE1/L5fVVY=;
 b=uJpdKQbJpXL7wtUFpgg9OjVh+D2ME48KjL4bIadGFUpncT0MwkS3p/vOlaNcGCAJbaVufSU9yswAWe1PfV953ZN2puMaQBnQnZ8ZY7FVvWoal4VZm4l/bU9qjDDT5KKIgNhs6B8jxeTIYxB/xVG05Qyklh56JEA94dq73L2SR4g=
Received: from CY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:930:1e::9)
 by SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 16:24:37 +0000
Received: from CY5PEPF00000E82.namprd05.prod.outlook.com (2603:10b6:930:1e::4)
 by CY5PR04CA0015.outlook.office365.com (2603:10b6:930:1e::9) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13
 via Frontend Transport; Wed, 18 Nov 2026 16:24:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY5PEPF00000E82.mail.protection.outlook.com (10.167.247.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 16:24:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 10:24:33 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 10:24:32 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH v3 2/3] drm/amdgpu: reserve and bind the SPM VMID on every
 GFXHUB instance
Date: Wed, 18 Nov 2026 11:24:25 -0500
Message-ID: <20261118162426.1642532-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118162426.1642532-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261118162426.1642532-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E82:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 374b8ab1-2a52-47e2-3338-08df4590706e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|5023799004|261026140227099003|261022105027099003|261026121527099003|261028144727099003|4143699003|56012099006|261021123027099003|11063799006|261021121427099003|10067099003|261009223027099003|261022075727099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: mxdDdsuk+eWCfG34xd9N8Mn7OSfNESdm1CaKkzcEDh5GmyaXYgvTUI1Fka1yeA81jL2RxRZDaIQf7iKi81GuZAGBSqxE6z1aOo+wc29ky/UBSZIann8eV4NfZdKdlB7W57kdhNKklgHK/PZ1SBZW56Yu23g/LB4l4rz9E7w5PlINdlwwNrvKqA8XMDqxR2KEzzY92Xx5VPLxi0dEWrDHAYjsCTQm2ZVwMGt1zg/ROMP0blOMIX04yTFpTBPX9mRyGpinB+aTK1ZxxrScZmB0rDOLBd1/0yAK8jN4Ca4rL1d+C+Oe0o3DL3mBYQa06vpagE76Ym6bP8A9rBGGTp/n+GQpIaVCIArDXcsG0HZV0f/ZnhsyPQ1kVS+UT83HBSgoh1SJsYVilXETSEXGnp0TkfqXFMEQAjZwd+gZk2VDgL3LAekfYuFe93rx0okMgcJuuqwhloOa7+7H3gODVtSDNtVN9Vesf3CgU5jkDCLffhnCcqaGtwYqY9VNzsBv12tE9h7ZPlAzE6ipRBpF/KGp0cKg+8/FPpzjWwMGY+qrVHncW588NIaWy2GHyL1tFuGD7IFsBmlLG9uj4W9Af75VWTTxt6akFtPMw9ORQOi9foRg+jdQODynVq3vOHC3iVw9am7zhHOc49Re7NFr6l8ZhyqgqrfuykxsADhzF5+Rhqyy60J8IJnaISBPsbUBsSeqLz+Hlil2jOvBr65GdxjaWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(5023799004)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(4143699003)(56012099006)(261021123027099003)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Huwypqd5RDXP/TKfr4hwol8+jucsdJa4K3r+mDmFZBUsyFXyZwADZS8x7oLqyymgNNSDo7mXWSi2CnR72VI7atkThKzbBp5F5NRqax5n/VPl91FUIBL4m977b0SZnJTy4hlOw5tMdjykIDwC/HlIKUx38Ex0gS+lYC/QOkMInPiyGSlJ2lr4xMThpAAtCbV9xqu9hSX4Kxldl3/j7GwISlhEau4oBVQNrUJDQuWp2DX3mF5VSYnQqMTnZXOWnfgr96C6vv2Qbf5QEkLdljv9tfsBpRe9VI1NgO8fdAxhvaB7bxMKjwHme2Peqs5+HoNrEkSWDA/yJ7yVANmueGkbivcVPQ04IQ4WmBM+jZ6e48NRzh0u/GGmRfcyVIeDg5G10/LLm12MqMDs4xf/qOk+zweUmIkFMAxdxoEYH5k6pvis2jYVyXdumkCJ5nhm8Km9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:24:37.2884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374b8ab1-2a52-47e2-3338-08df4590706e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E82.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697
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
and flushes only the given hub, and amdgpu_vmid_alloc_spm() and
amdgpu_vmid_free_spm() take the set of GFXHUBs directly, reserving the
VMID on every hub the VM's jobs can run on. The hub loops use a logical
XCC mask (GENMASK(NUM_XCC() - 1, 0)): the GFXHUBs are indexed by
logical XCC, while adev->gfx.xcc_mask holds physical instances and can
be sparse when an XCC is harvested.

On a partial reservation failure only the hubs the call newly reserved
are released again, after waiting for jobs which might have grabbed the
VMID in the meantime. Both functions require the root PD reservation as
a documented, asserted lock contract; AMDGPU_VM_OP_RESERVE_VMID takes
it before reserving, which also serializes the per-VM reservation state
against concurrent RESERVE/UNRESERVE calls and makes a failed root PD
reservation an ioctl error instead of silently skipping the bind.
amdgpu_vm_fini() gives the reservation up while the root PD is still
held and checks every hub, not just hub 0, before waiting for jobs.
amdgpu_vm_spm_update() binds every GFXHUB on which @vm holds the
reservation, so a conflicting reservation shows up on whichever hub two
VMs share.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 102 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  87 +++++++++++++-------
 4 files changed, 150 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c0efb90e1d2e..97068471e7a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -797,6 +797,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  *
  * For VMIDs that are bound directly to a VM's page table outside the
  * normal per-job VM flush path, e.g. a dedicated out-of-pool VMID.
+ * Only @vmhub is flushed, and for a GFXHUB only @vmhub is programmed;
+ * the MMHUB callback still programs every AID's MMHUB on IPs with
+ * more than one.
  */
 void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
 			  unsigned int vmid, uint64_t pd_addr)
@@ -807,7 +810,7 @@ void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
 		adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
 	else
 		adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr,
-				amdgpu_gfx_logical_xcc_mask(adev));
+				BIT(vmhub - AMDGPU_GFXHUB_START));
 
 	amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, TLB_FLUSH_LEGACY);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9c879ac68352..cf4cc798912d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -589,17 +589,15 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
 }
 
 /*
- * amdgpu_vmid_alloc_spm - reserve a specific VMID for this vm
+ * amdgpu_vmid_alloc_spm_hub - reserve the SPM VMID on one VMHUB
  * @adev: amdgpu device structure
  * @vm: the VM to reserve an ID for
  * @vmhub: the VMHUB which should be used
  *
- * Mostly used to have a reserved VMID for debugging and SPM.
- *
  * Returns: 0 for success, -ENOENT if an ID is already reserved.
  */
-int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			       unsigned vmhub)
+static int amdgpu_vmid_alloc_spm_hub(struct amdgpu_device *adev,
+				     struct amdgpu_vm *vm, unsigned int vmhub)
 {
 	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id;
@@ -628,18 +626,8 @@ int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
-/*
- * amdgpu_vmid_free_spm - free up a reserved VMID again
- * @adev: amdgpu device structure
- * @vm: the VM with the reserved ID
- * @vmhub: the VMHUB which should be used
- *
- * The caller must wait for all work that used the reserved VMID to finish
- * before, so submissions still in flight don't suddenly fault when its page
- * table gets unbound.
- */
-void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			       unsigned vmhub)
+static void amdgpu_vmid_free_spm_hub(struct amdgpu_device *adev,
+				     struct amdgpu_vm *vm, unsigned int vmhub)
 {
 	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id;
@@ -651,12 +639,90 @@ void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		id_mgr->reserved_vmid = false;
 
 		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
-			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
+			amdgpu_gmc_bind_vmid(adev, vmhub,
 					     adev->vm_manager.spm_vmid, 0);
 	}
 	mutex_unlock(&id_mgr->lock);
 }
 
+/*
+ * amdgpu_vmid_free_spm - free up a reserved VMID again
+ * @adev: amdgpu device structure
+ * @vm: the VM with the reserved ID
+ * @gfxhub_mask: logical XCCs on whose GFXHUBs to free the reservation
+ *
+ * Free the SPM VMID on every GFXHUB in @gfxhub_mask @vm holds it on, hubs
+ * without a reservation are skipped. The caller must hold @vm's root PD
+ * reservation, and must wait for all work that used the reserved VMID to
+ * finish before, so submissions still in flight don't suddenly fault when
+ * its page table gets unbound.
+ */
+void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			       uint32_t gfxhub_mask)
+{
+	int i;
+
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	for_each_inst(i, gfxhub_mask)
+		amdgpu_vmid_free_spm_hub(adev, vm, AMDGPU_GFXHUB(i));
+}
+
+/*
+ * amdgpu_vmid_alloc_spm - reserve the SPM VMID for this vm
+ * @adev: amdgpu device structure
+ * @vm: the VM to reserve the ID for
+ * @gfxhub_mask: logical XCCs on whose GFXHUBs to reserve
+ *
+ * Mostly used to have a reserved VMID for debugging and SPM, reserved on
+ * the GFXHUB of every XCC in @gfxhub_mask so that the reservation covers
+ * every hub the VM's jobs can run on.
+ *
+ * The caller must hold @vm's root PD reservation: it serializes the
+ * per-VM reservation state and keeps new jobs of @vm from grabbing a
+ * freshly reserved VMID while the error path unbinds it again.
+ *
+ * Returns: 0 for success, the first per-hub error otherwise (-ENOENT if
+ * the ID is already reserved). On an error only the hubs this call
+ * reserved are released again, after waiting for the jobs which might
+ * have grabbed the reserved VMID in the meantime; hubs @vm already held
+ * before the call stay reserved.
+ */
+int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			       uint32_t gfxhub_mask)
+{
+	uint32_t allocated = 0;
+	int i, r;
+
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
+	for_each_inst(i, gfxhub_mask) {
+		bool held = amdgpu_vmid_uses_reserved(vm, AMDGPU_GFXHUB(i));
+
+		r = amdgpu_vmid_alloc_spm_hub(adev, vm, AMDGPU_GFXHUB(i));
+		if (r)
+			goto error_free;
+		if (!held)
+			allocated |= BIT(i);
+	}
+
+	return 0;
+
+error_free:
+	/*
+	 * A job may already have grabbed a freshly reserved VMID, give it
+	 * the wait amdgpu_vmid_free_spm() demands before the rollback
+	 * unbinds the VMID again.
+	 */
+	if (allocated) {
+		dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+				      DMA_RESV_USAGE_READ, false,
+				      MAX_SCHEDULE_TIMEOUT);
+		amdgpu_vmid_free_spm(adev, vm, allocated);
+	}
+	return r;
+}
+
 /**
  * amdgpu_vmid_reset - reset VMID to zero
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index c134000eecfd..f2a721c836af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -126,9 +126,9 @@ bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
 bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
 int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			       unsigned vmhub);
+			       uint32_t gfxhub_mask);
 void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			       unsigned vmhub);
+			       uint32_t gfxhub_mask);
 int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		     struct amdgpu_job *job, struct dma_fence **fence);
 void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6b4dc0276e27..e81fbe32e3c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -589,30 +589,45 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
-	uint64_t pd_addr;
+	uint32_t gfxhub_mask = amdgpu_gfx_logical_xcc_mask(adev);
+	uint64_t pd_addr = 0;
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
 
-	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
-	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid, pd_addr);
-	mutex_unlock(&id_mgr->lock);
+	for_each_inst(i, gfxhub_mask) {
+		struct amdgpu_kq_vmid_mgr *id_mgr =
+			&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(i)];
+
+		/*
+		 * reserved_vmid[] only changes under the root PD reservation
+		 * the caller holds, so the common case - a VM not holding
+		 * the SPM VMID - gets away without taking any lock.
+		 */
+		if (vm->reserved_vmid[AMDGPU_GFXHUB(i)] !=
+		    &id_mgr->ids[adev->vm_manager.spm_vmid])
+			continue;
+
+		if (!pd_addr)
+			pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
+
+		mutex_lock(&id_mgr->lock);
+		amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(i),
+				     adev->vm_manager.spm_vmid, pd_addr);
+		mutex_unlock(&id_mgr->lock);
+	}
 }
 
 /**
@@ -2871,9 +2886,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	/* Wait for the jobs which might still use the reserved VMID */
-	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
-		dma_resv_wait_timeout(root->tbo.base.resv, DMA_RESV_USAGE_READ,
-				      false, MAX_SCHEDULE_TIMEOUT);
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+		if (vm->reserved_vmid[i]) {
+			dma_resv_wait_timeout(root->tbo.base.resv,
+					      DMA_RESV_USAGE_READ,
+					      false, MAX_SCHEDULE_TIMEOUT);
+			break;
+		}
+	}
+	amdgpu_vmid_free_spm(adev, vm, amdgpu_gfx_logical_xcc_mask(adev));
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 	dma_fence_wait(vm->last_seq_flush, false);
@@ -2914,10 +2935,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	dma_fence_put(vm->last_update);
 
-	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
-		amdgpu_vmid_free_spm(adev, vm, i);
-	}
-
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
 
 	if (!amdgpu_vm_stats_is_zero(vm)) {
@@ -3015,26 +3032,42 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID: {
+		uint32_t gfxhub_mask = amdgpu_gfx_logical_xcc_mask(adev);
 		int r;
 
+		/*
+		 * The root PD reservation serializes the per-VM reservation
+		 * state and keeps new jobs of this VM from grabbing a freshly
+		 * reserved VMID while an error path would unbind it again.
+		 */
+		r = amdgpu_bo_reserve(vm->root.bo, true);
+		if (r)
+			return r;
 		/* We only have requirement to reserve vmid from gfxhub */
-		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(0));
-		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
+		r = amdgpu_vmid_alloc_spm(adev, vm, gfxhub_mask);
+		if (!r)
 			amdgpu_vm_spm_update(adev, vm);
-			amdgpu_bo_unreserve(vm->root.bo);
-		}
+		amdgpu_bo_unreserve(vm->root.bo);
 		return r;
 	}
 	case AMDGPU_VM_OP_UNRESERVE_VMID: {
+		uint32_t gfxhub_mask = amdgpu_gfx_logical_xcc_mask(adev);
 		struct amdgpu_bo *root = vm->root.bo;
+		bool reserved = false;
+		int i, r;
 
-		amdgpu_bo_reserve(root, true);
+		r = amdgpu_bo_reserve(root, true);
+		if (r)
+			return r;
+		for_each_inst(i, gfxhub_mask)
+			reserved |= amdgpu_vmid_uses_reserved(vm,
+							AMDGPU_GFXHUB(i));
 		/* Wait for the jobs which might still use the reserved VMID */
-		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
+		if (reserved)
 			dma_resv_wait_timeout(root->tbo.base.resv,
 					      DMA_RESV_USAGE_READ, false,
 					      MAX_SCHEDULE_TIMEOUT);
-		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
+		amdgpu_vmid_free_spm(adev, vm, gfxhub_mask);
 		amdgpu_bo_unreserve(root);
 		break;
 	}
-- 
2.34.1

