Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A24606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RRlDhdzQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2F310E2FD;
	Wed, 21 Oct 2026 20:15:31 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D68410E2FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 20:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amJhn69ZO+ypQmlQPfCGvkcah4VGab3YG+NJCkBZXH4t/vdRCNryBeh0opZSxnsvO7+vDO+J8jKYCWK5gkTBwZXhv/sQz5SYY/scZnZROXA0WDfjaxBKL0kJ13wXOXsp6ZKCNVLvC2IlZSGc2+ikDfoKAoTXN7DJUSsBAL2ThkPp3ocZ1WpDILIqNucEIn7+QaaWyWKfU8E/yqFknM6w4467nDDaLiWVH3kvd86r2NRxtDx2Welgi+UE8T5GUpQyejFvYbtBnggNwfmDRcpMG3Oxz6oO0au7ae1fzAsmPjpA7MQFv/anEg/d+7TBa5rHHlLNk8IYadjupf1wKZsKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t06HK4BGMV9yGh6F4Nd41KUl4RdQorfqhKU4SSlFnq8=;
 b=a9eqFTlSj3/93jI0h+8Hd+B0erHAUH4bLAVgsmH3ci7OBWT++0vn3Dojo1Dz4bslB/sBlgJa9Rrti1IRN3NzanUfBN8JZMxGzUdK3RM9sJzur9q5qUR2dzj3BqsLQOyvs7N6yLMvltuSXeW6hQcGTKfBfESILfgtUMTukFU7lxcZ0/+BWSWpjUcq0ZU1m7drsT0BSVH9P6rw2msEgwh2BzhJ5ETsn9o6fpTxhqrMBmr1gY6rGt4ove4XTRETKxyfWs2r6Tdr2OBKr+gM2xHGG6fCZZICuqFhQyPbNAhzbFBy4gQNitnIpBiaCIKl5a5n8NFo6ueQWWKwEMAiUPhE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t06HK4BGMV9yGh6F4Nd41KUl4RdQorfqhKU4SSlFnq8=;
 b=RRlDhdzQ06ZmgRM77sxy7wzVQdq8My4S93AIctvAIKWhfYyJSPFoy3Bih2NVXAKdNQhOcyv6Xq4pS9xxOR/yCavwfkh5jt/+oWD2OsPzifXnP8hFVL/w9otka+zESm8KxBmc4qx/cCZ2j+OwCkz5fQhsW0D1jbxwL8oHJyxdVS8=
Received: from BL0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:91::32)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 20:15:14 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::13) by BL0PR05CA0022.outlook.office365.com
 (2603:10b6:208:91::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 21
 Oct 2026 20:15:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Wed, 21 Oct 2026 20:15:14 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 15:15:10 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: defer GPU resume from open/close to first
 use
Date: Wed, 21 Oct 2026 16:14:59 -0400
Message-ID: <20261021201459.715423-4-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021201459.715423-1-shahyan.soltani@amd.com>
References: <20261021201459.715423-1-shahyan.soltani@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b79ef69-f0be-405e-022b-08df2fb00482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|261021121427099003|11063799006|56012099006|261021123027099003|261009221227099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: VijUvyLMki45hoeBo/ETyQH0Q1NW2Zk5h2k0g14sSaH4xY9KfFJyng4ktJTu/xmyZDRH7oY6wf6XygaKnFYy+flFsGajxIHpmpLAWU19HHwI40EsHQBGDtyDvNYOpGmFyQnqoWZ/X+l9DXojGb+qefLNgMi81BMKpz5F++TNJMpyhyMfMhqoMEoEZn/01amdPwW9nVU2JA+vNeylv8wn7zSmG1FgIyZcnwrlkUYJd2RItjNUp9989nRzdZQJ+JcW+T3ewsbp6snkCXdQSF1G909WT4rgbUWL4JmBuopqMjHx+1Isr9uXvhh4uodjLtAD2JdEbcqefP5507OFvjoKQb21vUgoIaH78DOBiDicVhKsKjlGX9A9G+pQsLP9vAwMlbX7gDmKg9OBhVIrreXPusOGd/jfUm85szrZi+dXjRk5389vJrWG5eYHgUsGzeAIuymvyZwi0XhpT2ZaCBVM4lGIJhjEqoOOapfhdLdaR9C9goevf/6eIrbqr+SfgbE6Qcfff0J/M4zdY00koCe4EYWKaGj+tYNeD/g3Tw1FP/ikH9bs+YzyAIXxAlCdu1j2rAXRCqWl3UQ7nKyend5OMPmKB0ozEdGGXvr2oyd/Un6eIut78GLvWm4Zb0P02ypcirGD8hJVnser3+dE9VG60sZI/HETJ25gFt1NWYF41f4Prwup0rNBvrbTREi/4pSblTvzc3lUeWrMoVGfMoxygw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(261021121427099003)(11063799006)(56012099006)(261021123027099003)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eXrSW9HLU+hgWMLBMdj7hTXReppSyVGVP1sbvL7/Z9xydfZZD9qhgZG92sCanusyXyQotZtJnxjT8W3rVJMpFFrf5IEcuM+XhGcsfPwtgR93159IhsNEhckLIHnZi5h10I6Lq613dHXSuOWC3Prkcf+fZYtZw65L0POlNJwIQ0eMYbOPCsxRxsb/HLXEcPvh6ZJHYKIyvwmfU0LwT9DSULcQC54WixPMy60tHiPKTY1+lSnELfZu4pl/7NiRj4V2RBDXKH3oQRZC6Mda1od1m7f6OJEsTlq+KkJQdxazO0jm2aDPQsCF43/9U/bENiOvQP7j1AZmr/cx3nYpDs4SR48DbXt7UdUDyEbLK2fWv6tLWaX73bJcTCyInEQhIgjQL8/PhJo45Ebpoxw7ifckAgtEzZ3YEYPnxEZqPlc4ko2ksl2OJm6FxH65fsKCoBLC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 20:15:14.5708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b79ef69-f0be-405e-022b-08df2fb00482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Why]
Every open system call for an amdgpu device holds a runtime reference
and resumes the device from a BACO/BOCO sleep state even if direct
hardware access is not required.

[What]
Drop pm_runtime_get_sync() from open/close KMS to prevent unnecessary
resumes. Instead, the PM reference will only be held if the GPU is
currently awake.

Introduce delayed virtual memory hardware initialization through a
powered_init flag. The powered_init flag handles initializing the VM
domain in a GTT or VRAM domain depending on the init state of the GPU.

Remove the vm->generation assignment on amdgpu_vm_init() to force a
mismatch and proccess the amdgpu_vm_validate() logic. This path will
migrate GTT based page tables into VRAM upon a cs_ioctl, as well as
clear any garbage data within those page tables.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 18 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  7 ++++++-
 5 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..6ac0459f202c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1502,6 +1502,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	struct amdgpu_fpriv *fpriv;
 	struct drm_exec exec;
 	int r, pasid = 0;
+	int pm_ref;
 
 	/* Ensure IB tests are run on ring */
 	flush_delayed_work(&adev->delayed_init_work);
@@ -1514,9 +1515,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	file_priv->driver_priv = NULL;
 
-	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
-		goto pm_put;
+	pm_ref = pm_runtime_get_if_active(dev->dev);
 
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 	if (unlikely(!fpriv)) {
@@ -1530,7 +1529,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_debugfs_vm_init(file_priv);
 
-	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
+	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, !!pm_ref);
 	if (r)
 		goto error_pasid;
 
@@ -1597,9 +1596,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	kfree(fpriv);
 
 out_suspend:
-pm_put:
-	pm_runtime_put_autosuspend(dev->dev);
-
+	if (pm_ref > 0)
+		pm_runtime_put_autosuspend(dev->dev);
 	return r;
 }
 
@@ -1619,12 +1617,13 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	struct amdgpu_bo_list *list;
 	struct amdgpu_bo *pd;
 	unsigned long handle;
+	int pm_ref;
 	u32 pasid;
 
 	if (!fpriv)
 		return;
 
-	pm_runtime_get_sync(dev->dev);
+	pm_ref = pm_runtime_get_if_active(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
 		amdgpu_uvd_free_handles(adev, file_priv);
@@ -1663,7 +1662,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	kfree(fpriv);
 	file_priv->driver_priv = NULL;
 
-	pm_runtime_put_autosuspend(dev->dev);
+	if (pm_ref > 0)
+		pm_runtime_put_autosuspend(dev->dev);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6cd3927a7e82..c8d558d07d1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4169,7 +4169,7 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0);
+	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0, true);
 	if (r)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 961557997cd2..2cb194dea6d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2634,7 +2634,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * 0 for success, error for failure.
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int32_t xcp_id)
+		   int32_t xcp_id, bool device_active)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
@@ -2658,6 +2658,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
+	vm->powered_init = device_active;
 	vm->is_compute_context = false;
 	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
 
@@ -2678,7 +2679,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
-	vm->generation = amdgpu_vm_generation(adev, NULL);
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
@@ -2701,9 +2701,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);
-	if (r)
-		goto error_free_root;
+	if (device_active) {
+		r = amdgpu_vm_pt_clear(adev, vm, root, false);
+		if (r)
+			goto error_free_root;
+	}
 
 	r = amdgpu_vm_create_task_info(vm);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 06e0ddd60c7b..8ed9c88c4da3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -372,6 +372,8 @@ struct amdgpu_vm {
 	bool			is_npa;
 	/* Flag to indicate if VM needs a TLB fence (KFD or KGD) */
 	bool			need_tlb_fence;
+	/* Flag to indicate if VM during initialization holds a runtime reference */
+	bool			powered_init;
 
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
@@ -433,7 +435,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id,
+		   bool device_active);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e2..c22b3fc82a05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -456,7 +456,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.size = amdgpu_vm_pt_size(adev, level);
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
 
-	if (!adev->gmc.is_app_apu)
+	if (!adev->gmc.is_app_apu && (vm->powered_init || vm->root.bo))
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
2.56.0

