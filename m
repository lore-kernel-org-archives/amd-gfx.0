Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BAFC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 16:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18FD10E738;
	Wed,  1 Nov 2023 16:26:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280E910E738
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 16:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcdLt39tfip/6/R/GHk7DGUPftthTl1lWk8tndGaCfSNe5LJ3T7oQVbx1LgEpYKrK1eeKUAs/pTt7/zzOtgmoUXsH+7OIanIg7vIfUaixr3QWepcMsOxPKOdf/0Nsy6M8MQMsxJa64OUzeilgMhZjqxQU6fWSdf2pmf6lVMREkDcgO+zA2V+XTemR/jCMWZQ+0mvZEVDqTolx/5ggMNkOMMx0Uv5isQa1S4yLlCwZvM6k3G/snb2M4l3v3LiWxQQbbQmLMQXN6GMgymKJS+h6OKxlO3htwKG26TN6mA1O0BkJvpX26RxjtCUeHiyd5LdWE2q7Z8nokkf/8aJIyjtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uapx4uMS8WK8EAz1hRLK9kmca5aq1uXDmBMgGPyId2s=;
 b=M0EKUHWc69CwRQ4ywjTatMO03KgBl177LPP8yNThWxxooFTZBHIuikegl08au0WNep+dVB4IM0VV2j/+eWJLlDTf4Iy91N3qnEXj93AVBC/zL19jYEhY/5TxHWbuzdDec9Aox3QH/nixK/fAVjygoXQoNFABFuOqi6ZztnHRmhRR+7nTwQlG6NZRRB3IqMytTWrdnXXBbz+xJmrPGTmbaeMgdnIEVMFMPFAg718xB7Ey2sdgFHrVFeiuHNn8Znqxf3HJC382vZNOR3Ggfe19bGbUeRzM7l4Xj32z4WBIesVkG3ROLSIqPlNzVOPcGer1VXQeGNVOd2JG2lOuKXfFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uapx4uMS8WK8EAz1hRLK9kmca5aq1uXDmBMgGPyId2s=;
 b=bQP5inQe1T00eM7zp5Hlk5KO197bFzpJVn7BtggsmnT+d6tlqWoT5hAg0YbkrVsfn+nRH2vhH1FrwHjxQ4XLVpgBXMbsz0pFLf2sVD2qm9ZcjqY3vNmXnlUt/6vG1mWmN4p4j4B4mGXb/m8PFAI9gwsYpxiiGpyhwGw9YlomZHQ=
Received: from MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 16:26:53 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::33) by MN2PR15CA0023.outlook.office365.com
 (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 16:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 16:26:52 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 1 Nov 2023 11:26:48 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Enable seq64 manager and fix bugs
Date: Wed, 1 Nov 2023 09:26:01 -0700
Message-ID: <20231101162602.4122-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: c85e3754-3186-4eb0-7f4f-08dbdaf75b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrQzrFI8SX5YmZsHuTC2V/5J81lQ7qpCQRTT+DS4W0trLdqXs09czkFrCiRgdvSqUOejXicgvGwg3HtbC2IG8OngxO5H8MpQtjoONodwfwx5GH3Txv7w4VUJ/BCUGqc/wWDV9PSO7JZ2SKJgsW+RBGAekp3tXeKjHOAxERWomqdXR5+fYdKNHWhIQ8RUnYiWnAKvjCLJJ6MTUUo31r/GgrCYZvW1pzlAR3VUxQv4MNFCJTgQLevqpSRaSjicn/mklW8+p4GJWKzyOW41q3boPNTL60I5vgMBRhpWLavavSLt8GdcQdE4B3OdgQWQjbOZ5RyDq7KNzs/bte1fxSXfd4hpL+GJIbVtCpmBsqOKOEp7FSTOwD2hlCnP24KHdZj/LwLezhm6E229SMDgiT26URHEIZ/dsBUavxkvsQvejLym9lqAftAcxFKn2z4+E1DvQh+DW/r8Nc0WAg27XU9o9wYV+RCuOtSHk+ZvjcMvU26AsBSVmKULARxw6HhpR3fM1S0ksMTooRU4cwF5Kl4l4mJkIPEEEeGP0L7xysVxdwNcr4SvpwZcCl78OO5AoWURSEt8t+W8/4xyXzc/TCqiRA/tTQaH/plNYW5wtSUaBmsKar7V+s1uU0xq+ihp+AF8OdWc4kABI8QhaM5R0vuc9CjFCHUTLkcvoCT0nL1UaJUCfGitZ72KetVWDhjJDR/1HbdmCuYAYORhxlueuOBZmBlvWeIIifz5Itv8BNnDzB9ac20q8ou+NAvmswlhN/3ZYgXmdawWmnwQfc2x+wWiyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(26005)(1076003)(16526019)(2616005)(7696005)(40460700003)(356005)(36756003)(82740400003)(81166007)(47076005)(86362001)(36860700001)(66574015)(426003)(336012)(83380400001)(6916009)(5660300002)(8676002)(70206006)(2906002)(70586007)(316002)(54906003)(30864003)(8936002)(6666004)(4326008)(40480700001)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 16:26:52.8923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c85e3754-3186-4eb0-7f4f-08dbdaf75b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Enable the seq64 mapping sequence.
- Fix wflinfo va conflict and other bugs.

v1:
  - The seq64 area needs to be included in the AMDGPU_VA_RESERVED_SIZE
    otherwise the areas will conflict with user space allocations (Alex)

  - It needs to be mapped read only in the user VM (Alex)

v2:
  - Instead of just one define for TOP/BOTTOM
    reserved space separate them into two (Christian)

  - Fix the CPU and VA calculations and while at it
    also cleanup error handling and kerneldoc (Christian)

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c      |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    | 69 +++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c        |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c        |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c        |  5 +-
 11 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 23d054526e7c..c7622efdafee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -28,7 +28,7 @@ uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
 {
 	uint64_t addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
 
-	addr -= AMDGPU_VA_RESERVED_SIZE;
+	addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
 	addr = amdgpu_gmc_sign_extend(addr);
 
 	return addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 849fffbb367d..f4455ed78e72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -687,10 +687,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	uint64_t vm_size;
 	int r = 0;
 
-	if (args->va_address < AMDGPU_VA_RESERVED_SIZE) {
+	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
 		dev_dbg(dev->dev,
 			"va_address 0x%llx is in reserved area 0x%llx\n",
-			args->va_address, AMDGPU_VA_RESERVED_SIZE);
+			args->va_address, AMDGPU_VA_RESERVED_BOTTOM);
 		return -EINVAL;
 	}
 
@@ -706,7 +706,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	args->va_address &= AMDGPU_GMC_HOLE_MASK;
 
 	vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
-	vm_size -= AMDGPU_VA_RESERVED_SIZE;
+	vm_size -= AMDGPU_VA_RESERVED_TOP;
 	if (args->va_address + args->map_size > vm_size) {
 		dev_dbg(dev->dev,
 			"va_address 0x%llx is in top reserved area 0x%llx\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b5ebafd4a3ad..bb4aa14b868c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -894,14 +894,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
 
 		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
-		vm_size -= AMDGPU_VA_RESERVED_SIZE;
+		vm_size -= AMDGPU_VA_RESERVED_TOP;
 
 		/* Older VCE FW versions are buggy and can handle only 40bits */
 		if (adev->vce.fw_version &&
 		    adev->vce.fw_version < AMDGPU_VCE_FW_53_45)
 			vm_size = min(vm_size, 1ULL << 40);
 
-		dev_info->virtual_address_offset = AMDGPU_VA_RESERVED_SIZE;
+		dev_info->virtual_address_offset = AMDGPU_VA_RESERVED_BOTTOM;
 		dev_info->virtual_address_max =
 			min(vm_size, AMDGPU_GMC_HOLE_START);
 
@@ -1365,6 +1365,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			goto error_vm;
 	}
 
+	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va);
+	if (r)
+		goto error_vm;
+
 	mutex_init(&fpriv->bo_list_lock);
 	idr_init_base(&fpriv->bo_list_handles, 1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 70fe3b39c004..108908a10b92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1325,7 +1325,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 		goto error_fini;
 	}
 
-	ctx_data.meta_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
+	ctx_data.meta_data_gpu_addr = AMDGPU_VA_RESERVED_BOTTOM;
 	r = amdgpu_mes_ctx_map_meta_data(adev, vm, &ctx_data);
 	if (r) {
 		DRM_ERROR("failed to map ctx meta data\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 64d4914001e0..63d8b68023be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -47,15 +47,33 @@
  * Returns:
  * 0 on success or a negative error code on failure
  */
+
+/**
+ * amdgpu_seq64_get_va_base - Get the seq64 va base address
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Returns:
+ * va base address on success
+ */
+static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
+{
+	u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
+
+	addr -= AMDGPU_VA_RESERVED_TOP;
+
+	return addr;
+}
+
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		     struct amdgpu_bo_va **bo_va, u64 seq64_addr,
-		     uint32_t size)
+		     struct amdgpu_bo_va **bo_va)
 {
 	struct ttm_validate_buffer seq64_tv;
 	struct amdgpu_bo_list_entry pd;
 	struct ww_acquire_ctx ticket;
 	struct list_head list;
 	struct amdgpu_bo *bo;
+	u64 seq64_addr;
 	int r;
 
 	bo = adev->seq64.sbo;
@@ -81,9 +99,9 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error_vm;
 	}
 
-	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, size,
-			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
-			     AMDGPU_PTE_EXECUTABLE);
+	seq64_addr = amdgpu_seq64_get_va_base(adev);
+	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
+			     AMDGPU_PTE_READABLE);
 	if (r) {
 		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
 		goto error_map;
@@ -151,31 +169,25 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
  * amdgpu_seq64_alloc - Allocate a 64 bit memory
  *
  * @adev: amdgpu_device pointer
- * @gpu_addr: allocated gpu VA start address
- * @cpu_addr: allocated cpu VA start address
+ * @va: VA to access the seq in process address space
+ * @cpu_addr: CPU address to access the seq
  *
  * Alloc a 64 bit memory from seq64 pool.
  *
  * Returns:
  * 0 on success or a negative error code on failure
  */
-int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr,
-		       u64 **cpu_addr)
+int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
 {
 	unsigned long bit_pos;
-	u32 offset;
 
 	bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
+	if (bit_pos >= adev->seq64.num_sem)
+		return -ENOSPC;
 
-	if (bit_pos < adev->seq64.num_sem) {
-		__set_bit(bit_pos, adev->seq64.used);
-		offset = bit_pos << 6; /* convert to qw offset */
-	} else {
-		return -EINVAL;
-	}
-
-	*gpu_addr = offset + AMDGPU_SEQ64_VADDR_START;
-	*cpu_addr = offset + adev->seq64.cpu_base_addr;
+	__set_bit(bit_pos, adev->seq64.used);
+	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
+	*cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
 
 	return 0;
 }
@@ -184,20 +196,17 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr,
  * amdgpu_seq64_free - Free the given 64 bit memory
  *
  * @adev: amdgpu_device pointer
- * @gpu_addr: gpu start address to be freed
+ * @va: gpu start address to be freed
  *
  * Free the given 64 bit memory from seq64 pool.
- *
  */
-void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr)
+void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
 {
-	u32 offset;
-
-	offset = gpu_addr - AMDGPU_SEQ64_VADDR_START;
+	unsigned long bit_pos;
 
-	offset >>= 6;
-	if (offset < adev->seq64.num_sem)
-		__clear_bit(offset, adev->seq64.used);
+	bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
+	if (bit_pos < adev->seq64.num_sem)
+		__clear_bit(bit_pos, adev->seq64.used);
 }
 
 /**
@@ -236,7 +245,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
 	 * AMDGPU_MAX_SEQ64_SLOTS * sizeof(u64) * 8 = AMDGPU_MAX_SEQ64_SLOTS
 	 * 64bit slots
 	 */
-	r = amdgpu_bo_create_kernel(adev, AMDGPU_SEQ64_SIZE,
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_VA_RESERVED_SEQ64_SIZE,
 				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
 				    &adev->seq64.sbo, NULL,
 				    (void **)&adev->seq64.cpu_base_addr);
@@ -245,7 +254,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	memset(adev->seq64.cpu_base_addr, 0, AMDGPU_SEQ64_SIZE);
+	memset(adev->seq64.cpu_base_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE);
 
 	adev->seq64.num_sem = AMDGPU_MAX_SEQ64_SLOTS;
 	memset(&adev->seq64.used, 0, sizeof(adev->seq64.used));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
index 2196e72be508..4203b2ab318d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
@@ -25,10 +25,9 @@
 #ifndef __AMDGPU_SEQ64_H__
 #define __AMDGPU_SEQ64_H__
 
-#define AMDGPU_SEQ64_SIZE		(2ULL << 20)
-#define AMDGPU_MAX_SEQ64_SLOTS		(AMDGPU_SEQ64_SIZE / (sizeof(u64) * 8))
-#define AMDGPU_SEQ64_VADDR_OFFSET	0x50000
-#define AMDGPU_SEQ64_VADDR_START	(AMDGPU_VA_RESERVED_SIZE + AMDGPU_SEQ64_VADDR_OFFSET)
+#include "amdgpu_vm.h"
+
+#define AMDGPU_MAX_SEQ64_SLOTS         (AMDGPU_VA_RESERVED_SEQ64_SIZE / sizeof(u64))
 
 struct amdgpu_seq64 {
 	struct amdgpu_bo *sbo;
@@ -42,7 +41,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev);
 int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr, u64 **cpu_addr);
 void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		     struct amdgpu_bo_va **bo_va, u64 seq64_addr, uint32_t size);
+		     struct amdgpu_bo_va **bo_va);
 void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index f5fdde5181f7..a6ddced833ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -359,7 +359,7 @@ static int setup_umsch_mm_test(struct amdgpu_device *adev,
 
 	memset(test->ring_data_cpu_addr, 0, sizeof(struct umsch_mm_test_ring_data));
 
-	test->ring_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
+	test->ring_data_gpu_addr = AMDGPU_VA_RESERVED_BOTTOM;
 	r = map_ring_data(adev, test->vm, test->ring_data_obj, &test->bo_va,
 			  test->ring_data_gpu_addr, sizeof(struct umsch_mm_test_ring_data));
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9ea8b5b644e3..ed95f01a62e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -134,7 +134,10 @@ struct amdgpu_mem_stats;
 #define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
 
 /* Reserve 2MB at top/bottom of address space for kernel use */
-#define AMDGPU_VA_RESERVED_SIZE			(2ULL << 20)
+#define AMDGPU_VA_RESERVED_BOTTOM		(2ULL << 20)
+#define AMDGPU_VA_RESERVED_TOP			(4ULL << 20)
+#define AMDGPU_VA_RESERVED_CSA_SIZE		(2ULL << 20)
+#define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
 
 /* See vm_update_mode */
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 7f66954fd302..f8711998e762 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -434,9 +434,10 @@ static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)
 	WREG32(mmVM_PRT_CNTL, tmp);
 
 	if (enable) {
-		uint32_t low = AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
+		uint32_t low = AMDGPU_VA_RESERVED_BOTTOM >>
+			AMDGPU_GPU_PAGE_SHIFT;
 		uint32_t high = adev->vm_manager.max_pfn -
-			(AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT);
+			(AMDGPU_VA_RESERVED_TOP >> AMDGPU_GPU_PAGE_SHIFT);
 
 		WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, low);
 		WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, low);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 61ca1a82b651..f86ed37cad6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -562,9 +562,10 @@ static void gmc_v7_0_set_prt(struct amdgpu_device *adev, bool enable)
 	WREG32(mmVM_PRT_CNTL, tmp);
 
 	if (enable) {
-		uint32_t low = AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
+		uint32_t low = AMDGPU_VA_RESERVED_BOTTOM >>
+			AMDGPU_GPU_PAGE_SHIFT;
 		uint32_t high = adev->vm_manager.max_pfn -
-			(AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT);
+			(AMDGPU_VA_RESERVED_TOP >> AMDGPU_GPU_PAGE_SHIFT);
 
 		WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, low);
 		WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, low);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index fa59749c2aef..eab26db0f398 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -776,9 +776,10 @@ static void gmc_v8_0_set_prt(struct amdgpu_device *adev, bool enable)
 	WREG32(mmVM_PRT_CNTL, tmp);
 
 	if (enable) {
-		uint32_t low = AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
+		uint32_t low = AMDGPU_VA_RESERVED_BOTTOM >>
+			AMDGPU_GPU_PAGE_SHIFT;
 		uint32_t high = adev->vm_manager.max_pfn -
-			(AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE_SHIFT);
+			(AMDGPU_VA_RESERVED_TOP >> AMDGPU_GPU_PAGE_SHIFT);
 
 		WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, low);
 		WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, low);
-- 
2.25.1

