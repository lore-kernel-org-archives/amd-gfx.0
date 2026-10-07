Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD673CA6009
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 22:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C66410E6B2;
	Wed,  7 Oct 2026 22:15:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ey2vJX4o";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9C010E6AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 22:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIkbrlZOZAXE26uyMLqCsd/2yot3vnswJrD0hFuy5/50oDLC5Ddad2AyIr+thYyIaKmjip9iuGkXMwcvpyPyuiecYMaF0A9T609y2afOfS5fj5mXFukfZ0yD587zHvWg79nvnro7dfkQaHEC+A3tWviQqDAH3tLqdUrL28jWYeDMqJ3hRd8PjHVZnszHM4LXGVQWei41Mu05b9r9SPckPnAfkbEGE7hRpP+d3AyC7EtLudAKTHmpdn1I8ShORLop71fmqPE/ILGBwy0yvIvuN0EeQRtRoOb25yJade7BQ9ZnZsE9jMgzCA/2oMNj+HGCYwQjCYJIDcsQdW4qWgc9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1pzGclHp0lGqvMxcgU4xqLCxjkdPqWtSaTfqaaN7SY=;
 b=KPMqxNxaTUo4K/ihBGPtV38WADW9Ewsyy2/0KMLa8aWxuMo0NZ4GsKiux7Pbl0UIozG9/3Zjr6sfsWrK9y2tT5BC6EsH80UFrtW7ACnotI55SaFrIbOmoWCRY0UlPBos3twC2eMi2QHPA8u6+MQrnrljNzMWH5nr0TTGFQGNyrZNC1jiIgT2txXGQowcErKhgyf2u861rK+LcYNsfVyU7MN8NPYEEqZ5+p9LL3EseDlz4JyWW59BqYoR9fqTDeb1cr9eKYfhYK9YLpIcIZc5dux18wbXpjAxycdMwDgk6E6rZoT3Q0pPq9a9EnxULBPYsVAdtytoYW/AOvkMwbV0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1pzGclHp0lGqvMxcgU4xqLCxjkdPqWtSaTfqaaN7SY=;
 b=Ey2vJX4oz0hD9FoDnmT7S0PF3lsNSA64Ddap2gVNPtt2d4IOm2KFvDPdyli/bRxtI32TBGdAREHuq9t2zghoZ+xnt8iHQ5PmWWhwHqcZLZH3CHjENkpPuktuoHH/FY7I/CiAbXLpnlutTmDiOwN7GnM2Uddsa414cDUCLssiPXs=
Received: from DS1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::8) by
 BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Wed, 7 Oct 2026 22:15:47 +0000
Received: from CY7PEPF000000F0.namprd05.prod.outlook.com
 (2603:10b6:8:455:cafe::51) by DS1P220CA0013.outlook.office365.com
 (2603:10b6:8:455::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 22:15:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F0.mail.protection.outlook.com (10.167.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 22:15:45 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 17:15:43 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: defer GPU resume from open/close to first use
Date: Wed, 7 Oct 2026 18:15:30 -0400
Message-ID: <20261007221530.389925-3-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007221530.389925-1-shahyan.soltani@amd.com>
References: <20261007221530.389925-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F0:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: e502161b-c0df-43ea-2487-08df24c088b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cM91p0Ty/8IOerLm5NGfM8vVLhyeTBRpw44U11gfyDKip9WNdsW9Scp6oMi3DnjYljFRGYuxwuqWGqpo/hiJUw8mpTQbpErys7vg8uIYCopZVQxLUjWNGZsv+CU1YFXbAWZPxN8jU7BU3oAOPjSy/WIED7Kbj/p5Ge8/8sksXzSbhjvdNVKYdKdmmRRGkKA93kVvotZ/RXhzRGZ+m/we2cTGvbJmysRINseEB7gfdMZfbQHz4rKp1Q883grVeyQ7FIf4GCU+mNOHCGUrWj5BFlW+yNIiebx2gfDeIhsAwQPY8/IpPZQ+ShtRNT6BPM/R5K8b1h5u8Pir2ECxWCzKWTW06Egaz63tI0swp4wu6QWNX4O2/ukvnIEPsXTDszEx+udmnRUfZGy1Lf0fMrZZDfMlurkHaV2VXyFfFzMgcooMgL6rnGdCcsCUnsVetJMN1X0DhtyUAKCfDTsqpw1/GxAsz/5oti3yoqJGe9JT3b8GLHz+us0UXITCA0SwefFFWQ8a7pC7OmceSsYmqpnfarZS7NtMdRpAj/nNIS8lMyvbxXkoEieJ8oS3Tm1rtwB162c/R8t8f3p+CtpxEwf+w4D/5zg+ANLAXSdGRoUl9eaVxybR3LTHFgBbgjRtrXV5nkAh/83igCHy6zfTI7EyTIaPgxCoFJpXjEoxShyhvm/BpXrn0pdTo73Mfb+hhEyyFrzhAxs45K8XEgN3CC2alQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yrlEEV0m+3rmelX336pIJyY8O+Iy2HS9QYKEiWnI2O+DpQS/MiuTSU0oL1cjK7iFMccMzNqSlE7VeveY2iqFk8bf9ut83llN7TIlvOAFmx1T3enEYR5W0//wbC7da+gISg5h/bDys0xjna9ueLc3AfgfkmImaLeYvF8A6puXrDNPSYnRmzkOouicuhAfabQz0ky+12c0/kr2lqQ7Va5/XEbm28UnEn1zpG4ZDJe21PLZC+W7cWpMgh1F9W+FldydTcPmuSk5kvr/xQCnAwpyixXD/ShoxM7IxtvSJfrBjS7HdE/lxLDXrcCK041//6XQegcX3vRFXDZHltYVVJtvGjQLRp97jqXkkDHFKoBAjLkh/PynaxEeQuERgqYBAyq4+RWnG9zxOsncnWK8zkum9IEm6RAOSGrRdyEIwCSeE9HkcLQpVRtzQxd8BHA2jrKE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 22:15:45.4902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e502161b-c0df-43ea-2487-08df24c088b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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

Drop pm_runtime_get_sync() from open/close KMS to prevent unnecessary
resumes. Instead, the PM reference will only be held if the GPU is
currently awake.

Introduce delayed virtual memory hardware initialization through a
powered_init and root_cleared flag. The powered_init flag handles
initializing the VM domain in GTT/VRAM and moving a GTT domain based VM
into a VRAM domain. The root_cleared flag handles the initial root PD
clearing.

Handling is done through the modified amdgpu_vm_validate() and
amdgpu_vm_pt_create() functions.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 19 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  7 ++++++-
 5 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f34150d20a2f..958d235abb11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1488,9 +1488,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	file_priv->driver_priv = NULL;
 
-	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
-		goto pm_put;
+	int pm_ref = pm_runtime_get_if_active(dev->dev);
 
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 	if (unlikely(!fpriv)) {
@@ -1504,7 +1502,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_debugfs_vm_init(file_priv);
 
-	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
+	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, !!pm_ref);
 	if (r)
 		goto error_pasid;
 
@@ -1569,9 +1567,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	kfree(fpriv);
 
 out_suspend:
-pm_put:
-	pm_runtime_put_autosuspend(dev->dev);
-
+	if (pm_ref > 0)
+		pm_runtime_put_autosuspend(dev->dev);
 	return r;
 }
 
@@ -1596,7 +1593,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
-	pm_runtime_get_sync(dev->dev);
+	int pm_ref = pm_runtime_get_if_active(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
 		amdgpu_uvd_free_handles(adev, file_priv);
@@ -1635,7 +1632,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	kfree(fpriv);
 	file_priv->driver_priv = NULL;
 
-	pm_runtime_put_autosuspend(dev->dev);
+	if (pm_ref > 0)
+		pm_runtime_put_autosuspend(dev->dev);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 17888cf54447..7b3851649d30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4163,7 +4163,7 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0);
+	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0, true);
 	if (r)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7d3659ef11e5..39c13a4b45fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -594,13 +594,14 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r;
 
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
-	if (vm->generation != new_vm_generation) {
+	if (vm->generation != new_vm_generation || !vm->powered_init) {
 		vm->generation = new_vm_generation;
 		amdgpu_vm_bo_reset_state_machine(vm);
 		amdgpu_vm_fini_entities(vm);
 		r = amdgpu_vm_init_entities(adev, vm);
 		if (r)
 			return r;
+		vm->powered_init = true;
 	}
 
 	list_for_each_entry_safe(bo_base, tmp, &vm->kernel.evicted, vm_status) {
@@ -620,6 +621,13 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	scoped_guard(mutex, &vm->eviction_lock)
 		vm->evicting = false;
 
+	if (!vm->root_cleared) {
+		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
+		if (r)
+			return r;
+		vm->root_cleared = true;
+	}
+
 	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
 				 vm_status) {
 		r = validate(param, bo_base->bo);
@@ -2604,7 +2612,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * 0 for success, error for failure.
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int32_t xcp_id)
+		   int32_t xcp_id, bool device_active)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
@@ -2628,6 +2636,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
+	vm->powered_init = device_active;
+	vm->root_cleared = false;
 	vm->is_compute_context = false;
 	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
 
@@ -2648,7 +2658,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
-	vm->generation = amdgpu_vm_generation(adev, NULL);
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
@@ -2671,10 +2680,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);
-	if (r)
-		goto error_free_root;
-
 	r = amdgpu_vm_create_task_info(vm);
 	if (r)
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e478d3bda1a..a40d57a1ae83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -372,6 +372,10 @@ struct amdgpu_vm {
 	bool			is_npa;
 	/* Flag to indicate if VM needs a TLB fence (KFD or KGD) */
 	bool			need_tlb_fence;
+	/* Flag to indicate if VM during initialization holds a runtime reference */
+	bool			powered_init;
+	/* Flag to indicate if VM has been cleared through SDMA at least once */
+	bool			root_cleared;
 
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
@@ -432,7 +436,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id,
+		   bool device_active);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c03327f1242d..54f0b62fde6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -456,7 +456,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.size = amdgpu_vm_pt_size(adev, level);
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
 
-	if (!adev->gmc.is_app_apu)
+	if (!adev->gmc.is_app_apu && vm->powered_init)
 		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	else
 		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
@@ -486,6 +486,11 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		return r;
 
+	if (bp.domain == AMDGPU_GEM_DOMAIN_GTT && !adev->gmc.is_app_apu) {
+		(*vmbo)->bo.preferred_domains = AMDGPU_GEM_DOMAIN_VRAM;
+		(*vmbo)->bo.allowed_domains = AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM;
+	}
+
 	/* Assumes that reservation is shared with the VM root and that the
 	 * reservation is locked
 	 */
-- 
2.55.0

