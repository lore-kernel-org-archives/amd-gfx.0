Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA65DC43602
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 15:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468B810F175;
	Wed,  8 Jul 2026 15:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IwSiRIVQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C252C10F175
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 15:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUMGf5HKXgtdQ0WEv4A1/jlzJG3BAq1tdRdaDe4hYfMu8/JnxOD78SCeMYMid209gA5dej1M3Pd9w9Q1cQPy7tdboGgi6eWdKSDfv84ctZaCIZyq7vlWwkiET8j+A8g6xDf9rxh781y/ZI0wqKq1I4sC9VByTmryme6/FLleZIeQ0+TBRrLtmrjnZWlBd2Qv7+HdyWWQCBchz40Gv02UlGrWbgANbYCjx+E7UxRZdSEjvKkcrR9NP13jfvPg9FaRJwAE+81UvyvY1jKr0Dtot0+M5INRazXrKo8132O9v66H+GWWA/tmwGyAJbjr9v7RO5lCC1kZs877TMDU+/8BgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsHaE3oG0M7HVQDVrFZhporbUeVQNIDjGI3qwjehrMs=;
 b=J2w6O/CGnTK5jiD62impovwDi9OUwFqRMIHgaMX8xLjp3xpZHkclF74GxlfCP/Uz2565A/lMt94Yxm+mc53SIYyTf9dALb0gXfj8k9Ja/Ru18UxuCjK5UGXkr/FBF9hMMF+3KqR2pkRcc5FW/AlprPtvgQNh/40jhz9arub15JpBPZHmw8AoF0rOS4dIahYPQ91oQjpvubR6z/uA7KI6r+2SToLABZEPGQ8ICh6H+9BQf/6oLIjxcCke4ZZSddfeJE60QjZ5BgHYS9/un5EiUO5XaiGQDym2ivInuZmx1TUIHYK9fik0DaTuW0lqpb59M9if/QsESYoTiFNWgR1Z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsHaE3oG0M7HVQDVrFZhporbUeVQNIDjGI3qwjehrMs=;
 b=IwSiRIVQFgGDEYpaICQJvR3O3YmtqadU5a3EvQUIZmg+Ukgg4fiUbESdtIPW4ro10Fptuukc5MYy+Vr6r3B2yLKZqRE4O6QHgUcS2uVCFwOfAjWOPjvxHXAC8jmnIWHbasuWeppkcR6WOxN9in/v/1UqZtt++KREylp+BAB2738=
Received: from BN0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:e6::7)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 15:27:50 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::33) by BN0PR03CA0002.outlook.office365.com
 (2603:10b6:408:e6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 8
 Jul 2026 15:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 15:27:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 8 Jul 2026 10:27:47 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 2/3] drm/amdgpu: Resolve VM through DRM PASID ownership
Date: Wed, 8 Jul 2026 20:57:28 +0530
Message-ID: <20260708152729.3209550-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708152729.3209550-1-srinivasan.shanmugam@amd.com>
References: <20260708152729.3209550-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efb92ed-4a05-4714-7e1e-08dedd05781c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ClYWU8ER6RE9NDat0qWhgCj+p+2vmw0ln878IKwWG8VplqxXOgJXq5JR+u2OZlurum/tWPZ0iOgODtjZ9brOTT2vA9N60vMD5Jr+IBSqNdu4tShZhzViJbGt3CVVMdODpf8vuqwvxHXclX39YAjAM9Lg10V4J4R9i8ePQVJ2VlNfmNR8XGuMoWusIdexKhxWhf0GAimW1LnroMVKObdY1lbODWoakr3UmTejhSPLvdXy4CZ97O8wQ1ChwQk5h1QPNqhYb8/nt5cWGJNX9nVmCDtEPp9CXALvEb07QpyYJDsNotmwQF7e3taLB/u69MIRNW/gmONwUJVI+0qBWges58OMr47qFtBLm++nyhrgDrin5YSBtC+kjBuoIIt4jUny6UgbASOOBv7OHrs2cvLB2hqtVXAeV5gmyYvmmIDgKrHX5exQm8E4G56ZKKcEKe0hHWWMQOICFUmrwhdiWxp+N4kExwTd+tzcg491tGnjOTRt7/pWRM3yj/45KiuL7FrQ7Nhn1J3595AQuUuHLT4U/FdaBD8imT+kMAylxIVRhZgcEka3NewAgwE1dq1/X0wNEAbotOQDkS7zZgPD4B+ge3z/j5915Q8UqaFr1lwRMPF+S5jR6TcEeHVIZhoqE+at1Q4CxM+fn9J20yxB8Jcaa99MFBbDgZzY3Xd9SvgeKnEp5h23w1IOCGxk54e4E4zHp4IiMfCm86cohW1PVzHHTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wmg/fz0rEHXcBKY5IgicF11IDrDh0v/KKcNyPOUmUfXk6esSK93d3dvQlkfvwpdcoYg9oasgvVUlqPTa5gOJZAdKoZrSpYG0rm2+iNSf5/CP21VcDhBXDSCThtfRVnqydJP0c1fuBl+8+Vwwpk3+wLo8DkKFC1JpNJyjgqNa0IUrZlY1LaUkNNyJ5sUr7O8ErnTuBrRrb+nWG/kVwJFfFKEfKGKd6F1xcqUzqMgHck2tJC589w0e3VkyIveirWsqcoy4upyIIu0PaIuqPtSJr5E0CCH1wuFiRp5VgOchu9fVYxdEljHjWnCfPgFdoKF+MN1OfgiXVSAJRHOyIzr9yy5Vl97TVSpVAXtSQBCL6ZftfooRRaa05cwijDRXnGNB1tX6LBfWlOGmNQccG+1dsqVaWlqdTtBm/8tk74dsBZWq0nav+K2ab5ASoLCC6VSP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:27:49.2457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efb92ed-4a05-4714-7e1e-08dedd05781c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
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

Allocate DRM PASIDs with fpriv and resolve VM lookup users through:

	PASID -> fpriv -> VM

This preserves the root BO reference and revalidation flow in
amdgpu_vm_lock_by_pasid().

v5:
- Delay DRM PASID allocation until after VM initialization so that the
  PASID is not published before the VM is fully initialized.

v4:
- Allocate DRM PASIDs with fpriv directly.
- Squash ownership registration and PASID lookup conversion.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 40 ++++++++++++++++---------
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0c973a3c73fa..43396c44e868 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1376,11 +1376,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
 
-		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+		amdgpu_pasid_lock(&flags);
 		gpuvm_fault.addr = vm->fault_info.addr;
 		gpuvm_fault.status = vm->fault_info.status;
 		gpuvm_fault.vmhub = vm->fault_info.vmhub;
-		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+		amdgpu_pasid_unlock(flags);
 
 		return copy_to_user(out, &gpuvm_fault,
 				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
@@ -1465,7 +1465,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv;
 	struct drm_exec exec;
-	int r, pasid;
+	int r, pasid = 0;
 
 	/* Ensure IB tests are run on ring */
 	flush_delayed_work(&adev->delayed_init_work);
@@ -1488,22 +1488,23 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
-	pasid = amdgpu_pasid_alloc(16, NULL);
-	if (pasid < 0) {
-		dev_warn(adev->dev, "No more PASIDs available!");
-		pasid = 0;
-	}
-
 	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
 	if (r)
 		goto error_pasid;
 
 	amdgpu_debugfs_vm_init(file_priv);
 
-	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pasid);
+	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, 0);
 	if (r)
 		goto error_pasid;
 
+	pasid = amdgpu_pasid_alloc(16, fpriv);
+	if (pasid < 0) {
+		dev_warn(adev->dev, "No more PASIDs available!");
+		pasid = 0;
+	}
+	fpriv->vm.pasid = pasid;
+
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 180d694323e8..11822bf832f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2506,14 +2506,16 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
 struct amdgpu_task_info *
 amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
 {
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_task_info *ti;
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	amdgpu_pasid_lock(&flags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
 	ti = amdgpu_vm_get_task_info_vm(vm);
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	amdgpu_pasid_unlock(flags);
 
 	return ti;
 }
@@ -2938,14 +2940,16 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 					  u32 pasid, struct drm_exec *exec)
 {
 	unsigned long irqflags;
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_bo *root;
 	struct amdgpu_vm *vm;
 	int r;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	amdgpu_pasid_lock(&irqflags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
+	root = vm && vm->root.bo ? amdgpu_bo_ref(vm->root.bo) : NULL;
+	amdgpu_pasid_unlock(irqflags);
 
 	if (!root)
 		return NULL;
@@ -2957,11 +2961,17 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 	}
 
 	/* Double check that the VM still exists */
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm && vm->root.bo != root)
+	amdgpu_pasid_lock(&irqflags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	if (!fpriv) {
 		vm = NULL;
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	} else {
+		vm = &fpriv->vm;
+		if (vm->root.bo != root)
+			vm = NULL;
+	}
+	amdgpu_pasid_unlock(irqflags);
+
 	if (!vm) {
 		drm_exec_unlock_obj(exec, &root->tbo.base);
 		amdgpu_bo_unref(&root);
@@ -3158,12 +3168,14 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint32_t status,
 				  unsigned int vmhub)
 {
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	amdgpu_pasid_lock(&flags);
 
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
 	/* Don't update the fault cache if status is 0.  In the multiple
 	 * fault case, subsequent faults will return a 0 status which is
 	 * useless for userspace and replaces the useful fault status, so
@@ -3196,7 +3208,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
 		}
 	}
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	amdgpu_pasid_unlock(flags);
 }
 
 void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
-- 
2.34.1

