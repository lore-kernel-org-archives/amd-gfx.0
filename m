Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5665EEB64DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 05:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C97A810E2C9;
	Tue, 18 Jul 2023 05:14:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D04D10E2C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 05:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7jgmoB5AXdmO3ET9Oem8xE5rpnB8cHmLmFnQcMf/W0JNLGciIvMXHylBLNwQEEqI5VWJvlIL85A5CvBtbdj+j6X+eQfaj/jJbJRkCepehvZVRUZtoJWnOe4hRyfGj68m3hJEKpj2zCdLuTuVuri33ps4M/1nq4L9bO6vFOl0oHXMt1oZxxoBiSxmmOIClHIdWPnzFaRHb2mokzbfwxH67GoUFfhcvVeVRtzxQ7a6W+mo21aN2MZ5zIN/JEMulDSUF2VPcVaWYDCLLI+4XHdBFsF9pc+noeTwRBxJtlhZ+dAh6WEyfMss7Fq218BQvnVpjlUKfSq0o6f9XAbjaANsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4mpsQUdS6AKx7pOzexQ3fRFcmWEZe7KM42m2WPm6BU=;
 b=Mu1hHeixZ4f4QJKL3yx3t65/QlW7JD5EHdYQn1HHmEikX4Yxg1bxPgI5apUGHx7TstL0AbrihDhaZ6kUURBrcYFROJ5dcp0E3Mh7iwn0PUYPrT6qluFDNRLmGSNHZ10h8EMc3dmF4synnr93jH5iwivn6riHcbPvdnOi8RPpiygtSQamyPsob6/K5JrsJog8c8g6MPoqriFNWFQbp7zjoKLDrpDmhY86zzdJjxZfI6TPVZbNLqO6zFIz7d5juwldUL5uSyb7IypOwt50m9vRApQh76SUcfU0a481wufy9JEJpAaozT3sWQKSQQFhJDKMOBOJw83NKJxyUe0DhG1x1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4mpsQUdS6AKx7pOzexQ3fRFcmWEZe7KM42m2WPm6BU=;
 b=i8LD9UuipDtMp0H/inIcNj2TNF5amW+oGLYcb/izlQgPloZDA96xNbrZXNyler6OlGzQxFaSIsnDdWgH6OHSn690h5lywFCwrhzsYPda+Tkxj55n38PnSz563ybQKQf/kqBJ/FCILUjZiA1hNSlPESgWY732x1RTx2KI1fa/M+Y=
Received: from BN9PR03CA0524.namprd03.prod.outlook.com (2603:10b6:408:131::19)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 05:14:08 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::ba) by BN9PR03CA0524.outlook.office365.com
 (2603:10b6:408:131::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 05:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 05:14:08 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Jul 2023 00:14:05 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: fix slab-out-of-bounds issue in
 amdgpu_vm_pt_create
Date: Tue, 18 Jul 2023 13:13:40 +0800
Message-ID: <20230718051342.217902-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718051342.217902-1-guchun.chen@amd.com>
References: <20230718051342.217902-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|DM4PR12MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 002d78e0-b601-4eb9-eeb5-08db874dd0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGRc4iPAxfj0t5uO09RzvNIb0mjlkKQ2fgzyTv0a7Kc8iCCsMiRtcNYlC+sO+XOOqcElrQBfmNjHXYRVEpvgnV1nGS51XSvTec0Qgg58zYqflzrd012KgVaA7oMBrWoyqM6CcVR90yGdmy5Y46isFHsyk1hEG3zeinhvzYUDYXOa8zscsecH5YGnlJA0C++SHiRHL0W4pMBZUOoOV41DQD3ogr/RsQFKkQmM5oRih/mu6FaRRjLD7EPOE11zUl+WyvynMokbciID4xrroZjuLN0e4skKQs94sIOucHaCLOO/C7O7B978FxMPJY70prPYwGVq6ww2mzSXeoLcbG89EP9S7vQ/RaA+s2xGb+mGAzv7/L6N3Pg0XbmpCM9u4bKzMEJcFegXlVnFyEyYCN+Sv5nrSfQ5br6GfOydFkmNDMRiYWf9oiNnqRrLNGtfvmajeThQEl581ycbxKMfIYLuTZKaJ/+bIb6buxUDi3msROOqW0SqxzbSnvVY7kgwWVM4Glusczp3KC8ImTbz4nmAncVpVeCz0jlbWza2KNsM8GLAfMU8AYns0C4nSct11ImAmVBbLAyVho8wNzgW/9t2KAV/bf9GsIWLd+8ig/QbDwhyQ8m0ITe3KCipUIYixgZxnT6DkeBCzlCY5FtgJWYohusyvHoPsWGXLkhzsF/K1dq7tzboYjAIGTOSeJJfJxVC7C8KoyYX90RwlOXyIF67Oh0VJvadw8giUZRmAezv7pJuUmDnPJAnnpgnbMNsoVeRZi3ITN6CccXttDc38nZFoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(86362001)(2906002)(36756003)(44832011)(70586007)(40460700003)(6636002)(40480700001)(47076005)(966005)(336012)(66574015)(36860700001)(83380400001)(186003)(426003)(1076003)(26005)(16526019)(356005)(82740400003)(81166007)(6666004)(7696005)(70206006)(54906003)(110136005)(316002)(4326008)(2616005)(5660300002)(478600001)(8936002)(8676002)(41300700001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 05:14:08.6363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002d78e0-b601-4eb9-eeb5-08db874dd0b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
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
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
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

