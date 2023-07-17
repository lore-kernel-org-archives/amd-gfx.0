Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C94C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 02:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A96F10E123;
	Mon, 17 Jul 2023 02:26:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D925B10E123
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 02:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTun7NAJLRIUXUt4dt09qEgniJGD9ixsAnH7M1Yma7SZ+njLWopG8UyGdRFZZmVLQYwGUi22E22wo0Dz22RjGL1CZBEmSfxzvKaAjyPXc1Ps8XcHvKfTeHhx3JSu4eQM6g3eJguMsljaoL5WaUHmIGvAlSVgFJjL5o/SjPXXfw0SxS7UQd4GmlbsWYc7HOaMRghk5YOf+P5NytjStXQktGAR/QczNN9sFs6R1q0l2K2Ml9drxHlj7Zs/+gmSMy5abF3XnpdEPFNN6nDLBPI9GXqKjSN5DR+BJoTOg5nkUdmuCmoZIvlHD/iKNu99f0BoTzZF81vw0RYESeNSAI/Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgtqlLI97KgwmrpMt3If4VbAAt4FMS5eCXZafGjqtmg=;
 b=aqdlMHkgFZCKkGoMImZYGAgLngWeKuw11daR3UW2XGReolw2yV8QFreJ+8nrb4Bk9r34GVKdM6KgYe3aHIZkEdu7IlpWsuPEjbjBFe84n9TCMRl+UFQy8ratq0RHk3VeeO1oGlfBpAKxzTryfKa9Ofn9rgM5ciihjfKoE1o3wro5DLdweVGIZwocwbxXbN9IbRIhfFNBzzd5g8gjNYh98oRGpcKzBPMXgQudyt+DXum1RK5t6JDv2Gda1dl4xMQIh53ocLIiFwndbmdtND0MosyAROTXCPMCkpW/LzK8Bzl7dXDJ3TCooPuA2AWMfNmCpPY1y5GwFB7NLSjG5M4bpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgtqlLI97KgwmrpMt3If4VbAAt4FMS5eCXZafGjqtmg=;
 b=gJaygy5SieglOTNBgn1PUVnF8XGLmzTHY9sqk1/jwbRX2xSxA0bhT2tQlt0L5jn14cKhOAdo/khHLZL9L9bLJc1DZyJCKLYkGRI2sA6UlpqBUE5JnwEZ9yYH7OXYeq2Ode2cWFjFmnwxd4wfZ1llvj9xXWFGsp8mJ2/pS92fTUU=
Received: from BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 02:26:44 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::99) by BN9PR03CA0083.outlook.office365.com
 (2603:10b6:408:fc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 02:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 02:26:44 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 16 Jul 2023 21:26:41 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: fix slab-out-of-bounds issue in
 amdgpu_vm_pt_create
Date: Mon, 17 Jul 2023 10:26:17 +0800
Message-ID: <20230717022619.3833601-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717022619.3833601-1-guchun.chen@amd.com>
References: <20230717022619.3833601-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: deb8a3f3-6472-4042-bbdf-08db866d435d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VeH2i3vnXsQR7jQwbn+sYwL98PtRNMtRD2Ku5xT+JW69+FbIqhnvPtTyKHQWV92ptUfHbC/5wRtg3ktyEyZDQwv9lmarmIEMy/UxvlNsE71nCWgJmoTZjzhL1oZWeLuJitIT9zqReYEEtOPder7nv8U5k3kgzvArKH4vEDgJ0HbLf5lVOLygxI8zt6bbLAhxHnfhuSfjoDMjmb4yYhMm46KH6HO5XYVPc2ahrlBM/hzaVqjplBJIEDrSU/ZAdtA10npl0i8F2a1C/jaPBJ9bjMjwmjkkVOLDZLxt/diphcGpnP44BuVcD3aZv9bkvBjq4gzB/h3Ex8fWgmkVOVqXM6hp15b5avtqnSDYREBiWrGSzcYm7u4Y/ZeJH/tiQu5CYvvhxXceL+HuP6436v95Ax6rUzWMVpYGbzkioXWJcqrrvciteSPGgnAYROxNFs1CVPMUNUo7/MH1tejEizr3w9/D06jDqCjzrxoScVtUsrJ/bH2dccj8vko51IEy3g9bDMp8hZ95ytXdTwz1pfNPgO3kmdiG4eyd0W5i5vnRQ+7FjnTq8ZvrE9uhPJQtLlVegI67m05JvkTqZlkYjoN/5B8sT2DLbO9rJPb3xsGrezRNX+9CQwghyBjEns3WrOd7FCNB7PTFJz2qrTeWnjiuHmBsdUZRWyEO27Ca54xgME4WDdfnGW32VN4Vw9eufiL2oT+voW0CJP2i5QXl/28eaXlK2wDK7LpQ2iM1pQEiqG2gfTpwX/td1mT0IU04KJm/a2scJM60VrDg9ORJm5vo9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(54906003)(6666004)(110136005)(82740400003)(356005)(81166007)(7696005)(478600001)(41300700001)(5660300002)(8936002)(8676002)(316002)(6636002)(70586007)(4326008)(70206006)(2616005)(16526019)(336012)(426003)(36860700001)(186003)(83380400001)(47076005)(966005)(1076003)(26005)(86362001)(36756003)(44832011)(2906002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 02:26:44.2518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb8a3f3-6472-4042-bbdf-08db866d435d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recent code set xcp_id stored from file private data when opening
device to amdgpu bo for accounting memory usage etc, but not all
VMs are attached to this fpriv structure like the vm cases in
amdgpu_mes_self_test, otherwise, KASAN will complain below out
of bound access. And more importantly, VM code should not touch
fpriv structure, so drop fpriv code handling from amdgpu_vm_pt.

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

v2: without specifying xcp partition for PD/PT bo, the xcp id is -1.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2686
Fixes: ffc6deb773f7 ("drm/amdkfd: Store xcp partition id to amdgpu bo")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 11 ++++++-----
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 53a024cf0544..cab2fdd5b76a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1236,7 +1236,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (r)
 		goto error_pasid;
 
-	r = amdgpu_vm_init(adev, &fpriv->vm);
+	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
 	if (r)
 		goto error_pasid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e9091ebfe230..f808841310fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1382,7 +1382,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 		goto error_pasid;
 	}
 
-	r = amdgpu_vm_init(adev, vm);
+	r = amdgpu_vm_init(adev, vm, -1);
 	if (r) {
 		DRM_ERROR("failed to initialize vm\n");
 		goto error_pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 32adc31c093d..74380b21e7a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2121,13 +2121,14 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
+ * @xcp_id: GPU partition selection id
  *
  * Init @vm fields.
  *
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
@@ -2177,7 +2178,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->evicting = false;
 
 	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
-				false, &root);
+				false, &root, xcp_id);
 	if (r)
 		goto error_free_delayed;
 	root_bo = &root->bo;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 88ee4507f6b6..bca258c38919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -398,7 +398,7 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			u32 pasid);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
@@ -481,7 +481,8 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct amdgpu_bo_vm *vmbo, bool immediate);
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			int level, bool immediate, struct amdgpu_bo_vm **vmbo);
+			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
+			int32_t xcp_id);
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 bool amdgpu_vm_pt_is_root_clean(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 70fc5856a5b9..eb52dfe64948 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -498,11 +498,12 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @level: the page table level
  * @immediate: use a immediate update
  * @vmbo: pointer to the buffer object pointer
+ * @xcp_id: GPU partition id
  */
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			int level, bool immediate, struct amdgpu_bo_vm **vmbo)
+			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
+			int32_t xcp_id)
 {
-	struct amdgpu_fpriv *fpriv = container_of(vm, struct amdgpu_fpriv, vm);
 	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *bo;
 	struct dma_resv *resv;
@@ -535,7 +536,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	bp.type = ttm_bo_type_kernel;
 	bp.no_wait_gpu = immediate;
-	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
+	bp.xcp_id_plus1 = xcp_id + 1;
 
 	if (vm->root.bo)
 		bp.resv = vm->root.bo->tbo.base.resv;
@@ -561,7 +562,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
+	bp.xcp_id_plus1 = xcp_id + 1;
 
 	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
 
@@ -606,7 +607,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 		return 0;
 
 	amdgpu_vm_eviction_unlock(vm);
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
+	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt, 0);
 	amdgpu_vm_eviction_lock(vm);
 	if (r)
 		return r;
-- 
2.25.1

