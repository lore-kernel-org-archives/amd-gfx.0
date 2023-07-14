Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06078EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 11:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758BC10E864;
	Fri, 14 Jul 2023 11:06:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9132F10E09E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 11:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw9Bb6YNITDrrn+K+7rSe4iY5ijZcH1G4j3P1SMsT7EUXsRaTmxnYm5nThxutTIHqoiGB+rA/ratxXThxCncxnpH7d2uH/5mHhun31KFrkVo/+2+ZMr0OlWZJYIEfIN5a3sUx0H5/gI+gc+f0LOq/7XMbgAWK88NKPTisVjClv/UyZCLpgdxkWA071AeGM+zJHqnI3t+DttqE8G8iQ0RKgfmDfIYlPkJ7fBDLkgYU2nd5bEUkZ72jvJ3j2F7Rtr81V/ceKaJO+FgRCauH/rHaSbGCYrWjoMrlCDB6DbJi6qiz7qqvcL6ppB0fEu6Yr92segGTRVBg8ya982hbqPrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Yhotx56FQ75NcyLlAE8zPIvLS2ma64zJsA6pT7gVvI=;
 b=lgs2XfQw6Hz+HuOeWkimZMmkOU05SvOgTKMZi6Lr5gpiN7wxKitobxuCis/VCZnSLdSUot3AeO9WIWQEFoxU6HarfeufFrcyLnt8FPdtb1RTVZxF/jFZ8Wfgxkm4DroqyTLuqj4CANq34xK52jWf4+2ZEPcO+vkaAfGN8uc+CJqRuKvn1NyubKILvT+3zAl795jOiMOSXrCohWPS4Ihk+GyyeNKBZnvwkBijanajiUAIb+uP/x47fPiY4Df1JeM4gafOT0rKNp3OvqyIfnEfecCSfprxhQi9VVSubqXOkXjWoTgY7i35YkIEwZLJuR6/yqZ1Fg2/7cm0ZBSlKSeuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Yhotx56FQ75NcyLlAE8zPIvLS2ma64zJsA6pT7gVvI=;
 b=qr945y5N6smZ6dFp/+Sc73KRDrwLLr72/N/oPuvH/MT0s7yA3UF9WS/nCsrkQ6sh+4K5+27I+tHo/S1BLK07GuR7+JOlGTkvWPtJfe8LuiBD0xfaw9TuzGh/YOqnNTdpFurK9IZt6tQxpseXgZBdLKpH8fK5SbylHkCE1kOkzXs=
Received: from SJ0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:2c0::12)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 11:05:53 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c0:cafe::41) by SJ0PR13CA0007.outlook.office365.com
 (2603:10b6:a03:2c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.15 via Frontend
 Transport; Fri, 14 Jul 2023 11:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Fri, 14 Jul 2023 11:05:53 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Jul 2023 06:05:31 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix slab-out-of-bounds issue in
 amdgpu_vm_pt_create
Date: Fri, 14 Jul 2023 19:05:09 +0800
Message-ID: <20230714110510.3690246-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 484ea670-7a82-44cd-d6d5-08db845a4a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXXqSAsaHPVw780OqCKWYH62LrKBIUT/MXiPboDYdFbsp5M7ouhzgqiAGFqt5VUofko8xNCm8vrCIVjHcL2JmpNtVZ+kGWyoJOLXsrVt7Yl4JNwOXwPszaoWZXho13I3JhiweZuYgKjgSiBVf4n5LxFxC5YF8K2t/MfZL2JyM6YLNsJPJUcizAk4ttXoK3oSLThqZlPJXYviKMlmC2LfYoHMse8ChpKsfRhQRTPdLjtYH8G4Y8uFDoAwLXxEnDntjjeCygO+GUSaJ9ysx52ebyU8JGtvkpeKquoXApZRZ1iTmDWZ+yF2rkIPbyay38sHdF8wn8IO8djEUnY280p7KUT95Fh0GSxIqEgwOJ7J78nIO+PeOp5Q6qn1c6AFeX44yqXdOkCWCJ7hrBpV0MfeJSTiFfq3e9XSP3abYlcz4h9gpGxIiWINsSSIVqIl+rTS1eOuNHkmIm7VVZRxhNxXic8d/uPEUvR1D4N3iLNnzR0a2slTRMim6U1Rn+RCThtGEcOv9un+KRw9gZy3haH8K9umGSwjGnUyaGHWNf+i5YCGCAOklfo9ikMG1WyorRT+CYrOWRbUbggDCBWL9wIm9yHcK7U/ZeepLgoNrvC9nwm9NUCzdh4MegcQJzdcJknDBatJJdg94XT4wIIJp/Ixpjw9Ht2qWCAvgXu/DuAKvGL4QcQmkmv8gUC/L02Q8mQi9tlpPixd/58z+ovpo7zdldduK+AsnHm+arNwpvqyZ30cFmZxpdgItZ/aQOdZXVnIj2uY5eHe+fMe0VTijJDhigYZGdSul9cr/YB6LMyE5wo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(478600001)(7696005)(6666004)(110136005)(36756003)(8676002)(44832011)(8936002)(70206006)(41300700001)(6636002)(4326008)(316002)(70586007)(66574015)(82740400003)(83380400001)(426003)(47076005)(356005)(81166007)(5660300002)(86362001)(40460700003)(26005)(186003)(336012)(2616005)(1076003)(16526019)(36860700001)(40480700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 11:05:53.5860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484ea670-7a82-44cd-d6d5-08db845a4a9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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

Fixes: ffc6deb773f7 ("drm/amdkfd: Store xcp partition id to amdgpu bo")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 11 ++++++-----
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 85a0d5f419c8..9a5aa4318cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1232,7 +1232,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		pasid = 0;
 	}
 
-	r = amdgpu_vm_init(adev, &fpriv->vm);
+	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
 	if (r)
 		goto error_pasid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e9091ebfe230..cac1d1b227f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1382,7 +1382,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 		goto error_pasid;
 	}
 
-	r = amdgpu_vm_init(adev, vm);
+	r = amdgpu_vm_init(adev, vm, 0);
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

