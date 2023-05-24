Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B796C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 09:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FAC110E58F;
	Wed, 24 May 2023 09:23:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701CB10E58F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 09:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDQB6K3WbPJkX5qY723CCmMdpvhJQMvTbZpYnGR4JD4J0gJGu3GJvxNyy1V2lk8gdyMCUPNvzVTksxAUnF47WYcRaW7DsznldbYgK/4cC/Ds+h7u3wRushbEEdnB+H/BbiRRb7skktVKChzb06X+pY6DpI9w+IumnzOCNGHPRw/Tm+DLQfT5tA2IdvlUvToZHbv5EFpk4RIiYfkllIEZNdfbg7mcBQGIJvHhcXmNaGfcY7tFogLWkrSYfZ7rtE+yKMXdrhW0Z0V+/tdt6aGAhTSEI2nwPCwZBID/nvmkpTmO2fG7z+qxjaqOf0rQbJa4RIsa03QSFlb8Vy+fwI5LBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1xOoXIoz4JNeUf/0/mgdJVNHMloRpdiS+bGV6pQIcM=;
 b=jnZrHvoj4oITudMra73MtlQoSxHcsYz0/3SX7aFfVKNjYSHm723z2ObnkTHm9T2AoyqA60JkyPDF+ZSfDWZBhixd8MeU+OA4zc0ZKFpGLFjth3bYgCldTvSXRBn34HqSbdmkEXJbL6HAVGBIVaEl6iXSmZ0iw5GN+NSqVXtBWZ2HE/4tuRBN2MZvILSklUacHELd5TA8/Nx30uLtBqN3ti/2toV6rqzp3iloKfgimRkVZFnsHZtmYtznrbOgZmHrb2437xATw0o6vLVUWHvmKHUsBEu0iAgHGQAGeTMZWcuJvSj6Nj7Y/CKTn4RnLFFz0H41v+VnbvCARbf92MK9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1xOoXIoz4JNeUf/0/mgdJVNHMloRpdiS+bGV6pQIcM=;
 b=US2D3OnReCCJhuXyo6n0rrLIrTI7ALKgjHSRrT/Dq56JUmr+zntfHV8k3jPTQ/k3Vq09BvUdUYoBj9ncZ+Y9S1ce67/MVDQz2n393Z49irAwR6F/iqGCMVxBE9FSbC2VkCu9kGZHz7f4X9Mgiahu8Kac/2z9GnuRemohCmHBSrQ=
Received: from MW3PR06CA0007.namprd06.prod.outlook.com (2603:10b6:303:2a::12)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 09:23:43 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::ac) by MW3PR06CA0007.outlook.office365.com
 (2603:10b6:303:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 09:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 09:23:42 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 24 May 2023 04:23:39 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: add a flag to indicate if a VM is attached to
 fpriv
Date: Wed, 24 May 2023 17:23:26 +0800
Message-ID: <20230524092326.1941139-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 194a9e35-aa60-43e3-9587-08db5c389147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQQ3wzzawNwp+gai4BC6yuHgAGfvSP4XRDtORTfHrqMCibvUfPCR1/kfHSZS2AA10K5DO29mgXpnR7oUi8vTPRPBmRPwEvx4etUYXLSLbcq12vkY55GFhAkxihlSxtQ5peWkRpC6a2DCdVCUc3DwTEwvQRimhqTBkp4ao9uEvYQTidkEaAIOMVkWwa1OiLUq56ZPdQclkD0t+b5xXer8s+rMbGZAQcBABu79ZIxSwnV4EwyRLq2YuQErTtn/fjL7hi2qDTrWsseBe4YK204sAbgU8dAmD7skn4b4av0z7Tq5u2bdFFx1EVgkKmK9nXRha+OQrxX/U3TARtQ2KprkbRMGenW8S4XlIZxNO1r99fYCJhEqeUIpIjQTW2wGrbdBSAacHi56FKSgpXFsfzyMUnK+4nNWSFf2WiQ8r/pDppkGnRHvCaK2vLG7/BSjHwlHZPUjj4fuZtV+LvADX7H7aRFqWtGC4QY6bohGYswMkUYkBv/5YABRCkKT0mf4azsOzoLo0QyNyB59w3gkQOMygsO2P7wzZppqGjkwaU3RNkPcWZ2Ngtxd7QJ00yviszYH4qygX33dF/EWiIcDWG/4dlGTImAuLmZ/bsSqCK8UV3H1xx/fBqZQ8CB73tVdh6l7RJA52hKb3zPky8i2Q+MhlXWLXJyg/DNc3MlgGIJRmrm1L8eTo5KEc3gMpOpawohSSHZfcLCL5avC8fZJiC+7IymcFBlD9aywmJsJ5zPTkKwXaqTh49JZjb9lGJ9eO/c6bbt3H3aUIkg8ivBwX6BnE3tXCipJPdqKKqE6SPqZSrM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(47076005)(426003)(336012)(2616005)(44832011)(8676002)(5660300002)(41300700001)(8936002)(81166007)(40460700003)(356005)(2906002)(36756003)(40480700001)(478600001)(82310400005)(86362001)(110136005)(82740400003)(26005)(1076003)(186003)(16526019)(7696005)(70206006)(316002)(6666004)(6636002)(70586007)(4326008)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 09:23:42.6962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194a9e35-aa60-43e3-9587-08db5c389147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recent code stores xcp_id to amdgpu bo for accounting memory
usage or find correct KFD node, and this xcp_id is from file
private data after opening device. However, not all VMs are
attached to this fpriv structure like the case in amdgpu_mes_self_test.
So add a flag to differentiate the cases. Otherwise, KASAN will
complain out of bound access.

[   77.292314] BUG: KASAN: slab-out-of-bounds in amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
[   77.293845] Read of size 4 at addr ffff888102c48a48 by task modprobe/1069
[   77.294146] Call Trace:
[   77.294178]  <TASK>
[   77.294208]  dump_stack_lvl+0x49/0x63
[   77.294260]  print_report+0x16f/0x4a6
[   77.294307]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
[   77.295979]  ? kasan_complete_mode_report_info+0x3c/0x200
[   77.296057]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
[   77.297556]  kasan_report+0xb4/0x130
[   77.297609]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
[   77.299202]  __asan_load4+0x6f/0x90
[   77.299272]  amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
[   77.300796]  ? amdgpu_init+0x6e/0x1000 [amdgpu]
[   77.302222]  ? amdgpu_vm_pt_clear+0x750/0x750 [amdgpu]
[   77.303721]  ? preempt_count_sub+0x18/0xc0
[   77.303786]  amdgpu_vm_init+0x39e/0x870 [amdgpu]
[   77.305186]  ? amdgpu_vm_wait_idle+0x90/0x90 [amdgpu]
[   77.306683]  ? kasan_set_track+0x25/0x30
[   77.306737]  ? kasan_save_alloc_info+0x1b/0x30
[   77.306795]  ? __kasan_kmalloc+0x87/0xa0
[   77.306852]  amdgpu_mes_self_test+0x169/0x620 [amdgpu]

Fixes: ffc6deb773f7("drm/amdkfd: Store xcp partition id to amdgpu bo")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 12 +++++++++---
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 41d047e5de69..79b80f9233db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1229,7 +1229,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		pasid = 0;
 	}
 
-	r = amdgpu_vm_init(adev, &fpriv->vm);
+	r = amdgpu_vm_init(adev, &fpriv->vm, true);
 	if (r)
 		goto error_pasid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 49bb6c03d606..3be5219edf88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1345,7 +1345,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 		goto error_pasid;
 	}
 
-	r = amdgpu_vm_init(adev, vm);
+	r = amdgpu_vm_init(adev, vm, false);
 	if (r) {
 		DRM_ERROR("failed to initialize vm\n");
 		goto error_pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 37b9d8a8dbec..47ffaa1526a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2099,13 +2099,15 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
+ * @vm_attach_to_fpriv: flag to tell if vm is attached to file private data
  *
  * Init @vm fields.
  *
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		   bool vm_attach_to_fpriv)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
@@ -2131,6 +2133,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	vm->pte_support_ats = false;
 	vm->is_compute_context = false;
+	vm->vm_attach_to_fpriv = vm_attach_to_fpriv;
 
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d551fca1780e..62ed14b1fc16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -333,6 +333,9 @@ struct amdgpu_vm {
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
 
+	/* Flag to tell if VM is attached to file private data */
+	bool vm_attach_to_fpriv;
+
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
 };
@@ -392,7 +395,7 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			u32 pasid);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, bool vm_attach_to_fpriv);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index cc3b1b596e56..16b3350aa896 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -502,7 +502,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			int level, bool immediate, struct amdgpu_bo_vm **vmbo)
 {
-	struct amdgpu_fpriv *fpriv = container_of(vm, struct amdgpu_fpriv, vm);
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *bo;
 	struct dma_resv *resv;
@@ -535,7 +535,10 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	bp.type = ttm_bo_type_kernel;
 	bp.no_wait_gpu = immediate;
-	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
+	if (vm->vm_attach_to_fpriv) {
+		fpriv = container_of(vm, struct amdgpu_fpriv, vm);
+		bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
+	}
 
 	if (vm->root.bo)
 		bp.resv = vm->root.bo->tbo.base.resv;
@@ -561,7 +564,10 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
+	if (vm->vm_attach_to_fpriv) {
+		fpriv = container_of(vm, struct amdgpu_fpriv, vm);
+		bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
+	}
 
 	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
 
-- 
2.25.1

