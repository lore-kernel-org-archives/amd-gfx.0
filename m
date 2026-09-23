Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBD3C9830E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289A510F15A;
	Wed, 23 Sep 2026 19:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pvsPpPMw";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012068.outbound.protection.outlook.com
 [40.107.200.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2458810F156
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiJrBfZIyZH30Hhm1FnzJELNmzwqqUg1D5sVZr2sPW0bQ0CUGSyfpyD2JM+5OnQsHZB4MTAkRJ9AkOfUpi1spRiztjuia3u3pPVQMxWVqCUPktKqC+NNzjnX2vPkNDAvktifx5LHUOecmtTRuyWYApAwkLkeyBROuL/ZDM3uGiViYM92VehIf7C6Altd4WM9N9NRcjKxeS7mQF3rr9JFii3vD1srqX7e2rvePvgaGSqpZojxkO2qn4rwqMo9/0Kuqxq6zHDRownP2VmcGCciqRYeaoe5E5WG63dSy1IpxvTHaxkFvhGbCNtRIPFm6j+LVjJe+tEURzVF0YZ4jGxezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6tpl/OEDb0l/yQ++yvF51XuILc2ZtyUbBgfmTA5IbI=;
 b=Mr+KwXpCEEm1yN8g5QAN4mt9Yq8c0EJz9R8w/V5M8XyWz3GEcKneAQNXNWz9TAT6GRE25SdAuKsdp1ekqpKR85agoJsDjOi8tDzB+yTLAbc4Dct1c4a4b2jQm6bwbTcePPUANhcrzGEIf+DWFDjGRCnBKT/3qiNpDEmAzPMniTxhWx38G36e0K5o5JCAG0ExHRDUXbYsegRPRh5rytC0x2BHKmUqiBi1tybuQN/bwatF/WHRyXn73rO3sy5sA1zbq/XUIZuvOGfSNhcz8olgKPutTpW0qus5Deip7tPyHBZoKgb2nNNFwz17ff9nKYprIJx+PIFQBzMC6biqtIQqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6tpl/OEDb0l/yQ++yvF51XuILc2ZtyUbBgfmTA5IbI=;
 b=pvsPpPMwh5EiMPoYwHLD2DGutIidgtrCejPRhoi3kTKnbfTJVZRLfNb9vX7NboZEaQpEEPvJ7cWhxNMExFLnkeZlxQ78VujGZ39M27Xrn9ZzTe9cyv2/lvI2IKBL9q0Gl/qaUDTSoymobgeKIGHT2jbiEdAyXrvYeD3GdFoYP3M=
Received: from SA9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::12)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 19:34:30 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::24) by SA9P223CA0007.outlook.office365.com
 (2603:10b6:806:26::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Wed,
 23 Sep 2026 19:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:29 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:23 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 10/10] drm/amdgpu: defer GPU resume from open/close to
 first use
Date: Wed, 23 Sep 2026 15:33:46 -0400
Message-ID: <20260923193346.2292597-11-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2f9fe6-f8b5-444d-fb35-08df19a9af4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: FWQn2TSkmQ96DEQoSPBX94iy3nFZP4imPXKe6LHXpOC/Sj0WWss+teDQoeamgN/GImZgI3cYmssfCcsFpR0c3tKuVxT0bc2k6KOCHzRvfbRtlgh6tDSVAUVtV8IDkKt7gUfiDogAB8iDOdwW4MwYMQl64FZu7SnyCXMn8XpmS5TIz3AZbON47TRA2fckGoC/XwKCMlnAfrx3CO0kRqo/NuvnLzj2Q/64TNPJTp6yDX8/YtCdjJZLjUl25JkG/NZvVivIbyiBpvUwYflhS+CbN99/wl2tytVI5xbL5zDX2w3hwn3EBksfqC8WByuccwanWN9Q7xW0j6MbEHHhGUuR97sS6xXHBZK92frWPjtIb/eK0f7K0TEuliS9zxbI9H0gNork+5tXS0nKTuo5wAk8j3Xtu8udN4f+8nLn8IPLPT9aox1gliECNC8hEdN+awGBJ8pS08+lJosXnOEYtcPoAk1vIGEey+vA1NY3cbynQoFeRYPx+OBBmIgfU/N/8Am682Jy+A7u/sDZRjlEkE99+MZU/ml/KtiQz2hHS4rENW1mHnzST5cbWLeYHTO/4oIZRYfKdeeWdiRcIlnQZ9+jhZg9YRdIHBD0DesqAivT5jY0mcBKM6VPgSeAuPc1ZLiwyRoWT8MdWRe4K7LDRP7kABNE76N1RfpEC1pcjqHJfpbaayCXke+bfQKvgG8zakzNfvzSCu0hxExO9vfvPN3BIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l4oJNqkrbqAgGqPO6zs1NQiHdjDqKZOOVoSrUIsDt9bHokfOlrs50zBvfCfWUflQfUUAqJgWZnaE6NKOHSagkSxSv0NWWVh9k1dLX4WjXGw4YFfs3SIX6LG9a3vRkus1hpvg0AQj9JfKr0sfeDOsr3M4Ex64D9bOs/MOMSW98bs9ntEzA2oe/6d78qkAAiIbx7jstC8vGe3YqZHN3kQ74ZHYgLmvsiabRPgL9YMljkrn9UtKoCF2+hBYAYaZBe1NrM6CpgGHw+x+E2IJr8ZElEsaG2rPB2nClGMjTkhHA99EWIbmomlO9uu4fjuIkU8paFATMQDi9JO9HSXgA9bWv7GKysAOWPpEBmX3D9w7kGCv0gTMN+J4AARwFySXuhrtrpJNsy05/+mt6Jhi4DlIGOtIqHz6Rj7zY8iOfAHXQggN+tyvptK/ouOP5psylpnm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:29.0645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f9fe6-f8b5-444d-fb35-08df19a9af4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  7 ++++++-
 5 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f2f179421c4d..202e7313c8df 100644
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
+	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, !!pm_ref);
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
index 1c3d3603af60..a03000db3c36 100644
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
index 1cdf2b854f26..7afc6887b8e6 100644
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

