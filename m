Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5924FC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 15:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBBF110F180;
	Wed,  8 Jul 2026 15:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iG+aZYa3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233F110F171
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 15:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFKEVgn28TenXht5Ao7gT7Bw/1ji52bIdN6xvzWVMSa0ACsq/AyI+NI8fsrvQAnWoz6ilwt4xub6WWum5wEUwE8UJZxx7LQ/9CO0MhL2QXUE8wALHP5NwLUAsSI51GwiWVnkPtppt6iMuog7m0XFTmqeQGfz2esg7eRzXIZ1qKjcARGDeTrrDpDJTLHL7ZCnFJJXFrOz2dkfTehJJwjEBJZsztU89rg8hwiDt9S7Ks47uEQ226GlR1TH3LZmXtJDR4rJyiwGPExOZBHZ2cd32VTu9rdDKsErulqkTvJPSeEi972hho6hIVzK3G/vV+LHepG7T1y14uov6cZIf35lUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFOYTGAeZnw3Xq5cuHHdgE5rhhwnNybeznuslq+7Pho=;
 b=dLXRqpGZfm3e28108ukmDvF1O0foFS+ryZw4G0ujX21eMvGnMlIShDH0iG+F8TKi00NObbu59XzjOAOuAvVxfVomZmAEb+uXOVdvUCL9bE+rc6YbbORptev0TCW0pmL2vNFZ08CyUnKa/Uhnz0KV8FnerNQ+4ucIGaj7rqJ+3EkhiAUjEv+t8fx7traQ3WaVEPqZWM56gYkWQsk3lsbQaTes8AIWUsP/HD6qOgaASZqEZM8c1q/XMq+R/ID1nisMI4Trm3cHDZDRwvRAAM6qOAf9iFLqx8YpBigp4NHU4BriqPo2IcE5D5d6da0C2ZJ1P1AcBPRYY6p3h/j7RA9Jdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFOYTGAeZnw3Xq5cuHHdgE5rhhwnNybeznuslq+7Pho=;
 b=iG+aZYa3FFWgNFWcPNaoYJJUkeoXkrIwQ4WYksplm9/sPElObN4Zo1MzRkzRkHpGF5SDsb+Aqx5bNh3MnKPm6f+5/yTF5XroiIQ3RFLCfP6gg/forJO/VVeZZaH6FoQBD7Cii2Dk+fb/Fn9iq0sMxyZ5Imfr4JPcLPwROzIVFvU=
Received: from BN9PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:fb::27)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 15:27:51 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::10) by BN9PR03CA0052.outlook.office365.com
 (2603:10b6:408:fb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 15:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 15:27:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 8 Jul 2026 10:27:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 3/3] drm/amdgpu: Drop vm_manager PASID to VM mapping
Date: Wed, 8 Jul 2026 20:57:29 +0530
Message-ID: <20260708152729.3209550-4-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ecdb0f-d362-4651-268f-08dedd057928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YrdYyKK7tKuN+F0vP2YXUjwfAWzMf5Cm2nEm8KHaDNliS0LanEnHOU/O/hglOSQ/FcgedilPKo2VpeVNffAOUoxEJTpsK71OMjbmCBLN0J48iSK+8P8a043V6DjBkHkgB9aLB1X6Az2U/D/kdj9xoOQEUpBl2hCTXGIjOFxf4sac/Mb4HCAHRz/Cq8Vjn1e+C5tbFMoQ7tZ66NZUm0lgz0GyDgBjMyp7bGuMDsvU3zRyMUWbmTbZPJgIqxQZgL9UHqrcjia5gwAhNdPNI/HJSqFGZSZtCeZ4N359L1q8+wzy5ZHXpk1XQ6Ulbj2uTcV8hLd5dXOHzro8q0oTy+3B9M9wt3b2ohNh0rfnngWzxb12ttRYVNa4GyXNcyMUkheXxlVjST1+Q3byikrsXOk4b9VbKe4St2tDeekdhPZBf59CbPhmeu8AXpAk00nKetv8EjcOflII4l2JCUaaDwitVEXG4/xqYE9YxXRoTkO74shzYEraMH8zmoIw6cjsxJ6OqgSczZOZNO85PDWEw5BpwSjjEAe45KMwb9DfmDinUUCjKpKIeVhcW4iEp1vc2KjlMWHpFMh7eFe/qvZXj+YX7v+Fu+5h28Z1SgtkZCMKOWZlmeKe/jq8gMsprP31xV0iH74aS6DLFr4tSQNDeXHPDk4pLwqK+xsWpK9N6MWQeAwbtU1dRnN46E/6IF6po5OwtqXOITdCx9r1rV+hTaRyDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GQ746Ezyam5wbJC49U9+W955950IpSDiX6DktfOlHvfb8xqwo0NYPB5K+QYikiIFubeQlEAndJeEZ/zDPYNZfPqU8KVn4+wfwJGtIsEvzQtsGnUZZ9ZxGIvyfWwgUQRAAMc0qH6W/0rJUS4mfxx4nVdJZmcsuuzpt13vxDBHibIDH3jyk2VyUFEOZysAguX36nCWE+s3+gNJh0OKGa/mEFAP9pvjfmBRTPeCoZL2Jm3blU5tjOI5SRolQUQDUfOYJa13dbFSonAEa/Nb70XRDqlyv6MD9VHC/XZJLOglA/YBy7xD/6ATv5D+2Vo0n/ZACuW4E1nn3H8kEm7GXHdJUqej0MYTc8kDQmfzrleLiG2LSPCoEVyuotRRjJMS9Me4tCU2X04iBcwQu1ReCdPWpQCWHJDc9R32wmtwjySIDakkg9ZPWBi0ltXg0M+97LK9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:27:50.9987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ecdb0f-d362-4651-268f-08dedd057928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
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

VM lookup users now resolve DRM PASIDs through the global PASID xarray:

	PASID -> fpriv -> VM

The per-device vm_manager.pasids xarray is no longer needed.

Remove PASID registration and removal from the VM init/fini paths, drop
vm_manager PASID initialization/cleanup, and remove the xarray from
struct amdgpu_vm_manager.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ----
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 11822bf832f8..579dbceecdc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2642,14 +2642,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
 
-	/* Store new PASID in XArray (if non-zero) */
-	if (pasid != 0) {
-		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm, GFP_KERNEL));
-		if (r < 0)
-			goto error_free_root;
-
-		vm->pasid = pasid;
-	}
+	vm->pasid = pasid;
 
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
@@ -2657,11 +2650,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return 0;
 
 error_free_root:
-	/* If PASID was partially set, erase it from XArray before failing */
-	if (vm->pasid != 0) {
-		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
-		vm->pasid = 0;
-	}
+	vm->pasid = 0;
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
@@ -2768,11 +2757,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	/* Remove PASID mapping before destroying VM */
-	if (vm->pasid != 0) {
-		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
-		vm->pasid = 0;
-	}
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 	dma_fence_wait(vm->last_tlb_flush, false);
@@ -2868,8 +2852,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #else
 	adev->vm_manager.vm_update_mode = 0;
 #endif
-
-	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -2881,9 +2863,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
-	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
-	xa_destroy(&adev->vm_manager.pasids);
-
 	amdgpu_vmid_mgr_fini(adev);
 	amdgpu_pasid_mgr_cleanup();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 939f639cd8bf..f63364f128bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -481,10 +481,6 @@ struct amdgpu_vm_manager {
 	 */
 	int					vm_update_mode;
 
-	/* PASID to VM mapping, will be used in interrupt context to
-	 * look up VM of a page fault
-	 */
-	struct xarray				pasids;
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info	fault_info;
 };
-- 
2.34.1

