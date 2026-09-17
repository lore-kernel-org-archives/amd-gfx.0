Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7865EC88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 19:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED88310F0CF;
	Thu, 17 Sep 2026 19:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yOTiiqxb";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0664A10F0CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNFCmXBN7mzCUzBHC6grHd4AN0+6ukd1m77pny6eSBMZWdG9oq6+9gWutFVvNmNLKe0rpPjlR+OUoknZl/SQN5hSlV3ytHn1z+GwtBOYMwJBYlNzQcPIHlJq/eyXPBupnWuwZI29ZWVZAyrs0eIpvmb8jvq82j19VbQmIVftuA8mK/ttis5QyUJvpQGgUSCsIcbFBonti8AueiA3k5CYzfMrPTmWWuQPQW4DgZ2k0is/2BpaesnZ+pMCLYv0dtbthFmlSsazwDqItB2h3VyG1E9+Vdsx1bL6MJj0zJG9QUfNEcoKPw0C69RYDIFY9EZJuLwvaJ72q3mpbdzTRrfUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/iTx/3DoabaM3AJMpqKZKSXdIZ4fZQcyHh8oVILZps=;
 b=oFvmXim3kr5mcS8Aok6Yb8vSkOh/5Py4P/gNAbuYdjbrT065rF1Mbfal1WpujLL1KzEnpdCevzXWHTBwvuBlgsG2+fo2wxdooJ117TvcaXZ0EBcz1OsecozvWNR7ttj9Lu9VD1bSboG1KVHFiD9/NYKozsCIlVCCmAnT0U2d8zNEZQUv4tlq+dEJslr/JKoublvs7eKhOi+0Sxm3VMRBk4wqcPkDi8rfLd8HeYGBtrt8I5s9aXlfggzMMppFOCZ/gjwYusjhihr9tBpdd0v1nSbjVlLz0F4pJGotxpOgpnjBHvQZqPrKabXJszfODr65FMzSo7x+AxuQgDmROwGl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/iTx/3DoabaM3AJMpqKZKSXdIZ4fZQcyHh8oVILZps=;
 b=yOTiiqxbxWtS8HHYdjvkz/scnG8hh9YXwUKBiAazJet08xSa2C9Z7nrQ5/YnRqbLOA+7Q0U1/o2VBZjetZtJDZ5FFFVBhFgg8Pj/b6ip2F0ngC2pOHb7Uk3mW6banx7SUzAdULibQndJWbfDNVhb7jzxNFdtbHQuSqBl96+5SBA=
Received: from MN0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:208:52d::14)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 19:58:35 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::2b) by MN0PR04CA0024.outlook.office365.com
 (2603:10b6:208:52d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 19:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 19:58:35 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 14:58:25 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v2 8/8] drm/amdgpu: defer GPU resume from open/close to first
 use
Date: Thu, 17 Sep 2026 15:58:09 -0400
Message-ID: <20260917195812.72917-9-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917195812.72917-1-shahyan.soltani@amd.com>
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3fbea5-4c80-452c-1379-08df14f60ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iUHGr8N0epkpx1ywmr3z8BndYNSKPi46Hrj2MSRNfEA6PAK5BFoHjDRza+eqioQjBGHZtlP46Z7nbZ+VgkqWm1oRdzDwUoXF09G2/Q+0rMhoKf/8FpFSWrijNV/p4OFPcjee+FmeTnCwVT9SJSUijC0aFFBFIVARAXqVjRTtuqXEZSz33+gMxQuUwqgXNIfuEHU3Cw9z/tAwHDGkicvUXJXUj03S7CxGkOQogHncRqNV/14YSNcKDsdFtOjJ+UydBMxClBNFMoGN4lgg+4n7om80y/rgJIvZj+PUydgGKAVH23bJBS9pxjPZJy9bvnWlm78Big3DPmE1QnPkeiavCYFigkMogHJdXq3/wxT+XukghMlFi/TQW2xOIjWObvP9c0sj6sxVwaDDxL6IN7gsaWoPWyJY2S6wNS1S9J4jb/ieMh3f8E/mRksWUgLHwbBv74XmaAx5rPstKc5Yt4fU4WxMh1oQXY+T3/X2tZdy0F4LmhjMgv5ds+/wrtuAatiKLPmb0KJMTbguHy25jOZXQ8B07Dx5EmxW7TEVJGC23ifMbSzWQ3Ob3VZP3tGQVDEMvc5tdiXwCunIERwGNDR1tP2gZ3dQkbuAC/bzA9YLNBjQbmHApRXsfMt+1gD9AdWwAMoipuwUxpPgTI61aoMSYf5QdX5xo/k8Y08qPcjqJPluf9UgWSKGxLfrmT4zDhVknldiGZ7VQEoHn+k1/rslVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XLDlMHYvelp4MirNvDWO4IOJ3zybwIp6nDxgnFOdAv66uWeuQQxtDQdfotJJKYbceVeI3S6PbaiZ4F08pdw5JZ+vKDN8s97JULZjBzYFcMCJNd5dBYL17yJ2ISXZsKFtKACI1u9uwWO3bDlM/Q1u3/hWBUQmXRKGkL8v6Y/1DRK0NBQgiC6KqMH9zsaUehjk6nQH2HOK5ZoJbZjRmIN3kGuawycXHiXSEO6V8EotarwPvYe+qq13rnMf8PJwIIlHaNCHBvRcIi11SU63cRAd5hWqKm2EhOOW+dzA0R86wIudg2qGnoMmaBNU3dFB2MKzLisPTjtluTrd1thmoGbuqJBIierbLphjOZzt5sDdI/Nx6iRZD7lMNcSDBQZcKr9wWhNn8OvkRO1Qkm9uRz5mSDg99eAS8rCzCn3GVyafHWkHt3skpfDvM1OMrzYfu3dS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:58:35.2588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3fbea5-4c80-452c-1379-08df14f60ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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
powered_init flag to skip page table setup if the GPU is suspended.

If the GPU is suspended, pagetables will instead be initialized upon
first use, such as when a cs_ioctl is called.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c  | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  8 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  2 +-
 6 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f2f179421c4d..f40d864ca64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1483,9 +1483,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	file_priv->driver_priv = NULL;
 
-	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
-		goto pm_put;
+	int pm_ref = pm_runtime_get_if_active(dev->dev);
 
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 	if (unlikely(!fpriv)) {
@@ -1499,7 +1497,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_debugfs_vm_init(file_priv);
 
-	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
+	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pm_ref);
 	if (r)
 		goto error_pasid;
 
@@ -1564,9 +1562,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	kfree(fpriv);
 
 out_suspend:
-pm_put:
-	pm_runtime_put_autosuspend(dev->dev);
-
+	if (pm_ref > 0)
+		pm_runtime_put_autosuspend(dev->dev);
 	return r;
 }
 
@@ -1591,7 +1588,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
-	pm_runtime_get_sync(dev->dev);
+	int pm_ref = pm_runtime_get_if_active(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
 		amdgpu_uvd_free_handles(adev, file_priv);
@@ -1630,7 +1627,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	kfree(fpriv);
 	file_priv->driver_priv = NULL;
 
-	pm_runtime_put_autosuspend(dev->dev);
+	if (pm_ref > 0)
+		pm_runtime_put_autosuspend(dev->dev);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 21a225b0116a..7193d853df91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -103,11 +103,13 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error;
 	}
 
-	r = amdgpu_vm_bo_update(adev, *bo_va, false);
-	if (r) {
-		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
-		amdgpu_vm_bo_del(adev, *bo_va);
-		goto error;
+	if (vm->powered_init) {
+		r = amdgpu_vm_bo_update(adev, *bo_va, false);
+		if (r) {
+			DRM_ERROR("failed to do vm_bo_update on userq sem\n");
+			amdgpu_vm_bo_del(adev, *bo_va);
+			goto error;
+		}
 	}
 
 error:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ab564202f550..6022ec6cf1b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4071,7 +4071,7 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0);
+	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0, true);
 	if (r)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 47cde5459469..a03000db3c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2596,7 +2596,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * 0 for success, error for failure.
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int32_t xcp_id)
+		   int32_t xcp_id, int device_active)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
@@ -2620,6 +2620,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
+	vm->powered_init = device_active;
 	vm->is_compute_context = false;
 	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
 
@@ -2640,7 +2641,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
-	vm->generation = amdgpu_vm_generation(adev, NULL);
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
@@ -2663,10 +2663,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
index 0f6634b74974..b422a5f394a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -373,6 +373,8 @@ struct amdgpu_vm {
 	bool			is_npa;
 	/* Flag to indicate if VM needs a TLB fence (KFD or KGD) */
 	bool			need_tlb_fence;
+	/* Flag to indicate if VM during initialization holds a runtime reference */
+	bool			powered_init;
 
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
@@ -429,7 +431,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id,
+		   int device_active);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 1cdf2b854f26..a29127f27329 100644
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
-- 
2.55.0

