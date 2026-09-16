Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2DDC88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 05:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DDE10E2DB;
	Wed, 16 Sep 2026 05:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gghhT9TS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D5EF10E277
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 05:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loAFggnuvdZJ0WgCkAQwdtI28ewdj3Fo7ytBe1hagxGhrI6cQVGu+n8V76LfKaLDNEKIXd16hEoBIn0cq4ZtZBEs/28J00uQWHdP1K0LH6QD/o7iy60lou7v/DvhPaU9BqJEHMh3nNUxlrPcnoHzlYBWyc35cAd3WHMUYgDqUy8724/J/ErrYoSsA+lCu9cAKt9gTH9u/14VPgH3s1bePtfw1v+g/ESzL8UVikgTaCQkFJ0D2Y/9CY+tHIReRcZq6iDoaGFc0ZsDQvCXmX9EB4795odJ6lSSmqfPJfMNeUcppVkrpyhlZXTGJUFFnuh7gyL5eoO58ZnKCAgqQXG9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktQGOdeuhGNy0b59PG4SESpfefbBDeu7WU2KnRdTr1g=;
 b=BgKuqjx7GlPwPSZgCmfpZ5ayqwMIsFUpSO7CQ5HuIRsRsPjYYgx+AQ8yPR2FyRkJkEo7Lr+AjZXzfsaH/MPIGPRv6yH2lBGmgGGc6XoJ3YwL/aZA6CZygaoG0GBdvuFlu76jixLVdhi3OgvK9jOgjELWBaBegvb655RdrgRQoPf/lbhx6dyfUf8WMGFrkXIZKYFVp6KOiGNPfThXy3l7Nyff9L+sWgRBEV9kkeQguFsjPlUB3yy3iVIouuqBpLn+Ly745VK0WGiS9OAFW5TQRcJ4elQkCV9IQKLCg4snnu06EklFbP7kZr0vPF637cwKjM7MFpK/H//UMT91aBUkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktQGOdeuhGNy0b59PG4SESpfefbBDeu7WU2KnRdTr1g=;
 b=gghhT9TS6MSH2YDZiyO+mH0L1NINh+OtfNMPAfu6/gLv6ogO+2keZC7mvLqYjzqOiusAS6eBZpX6sYCl9SOgc64f/9+LDuEod5v55Jwtgvzq+vziJcssUh7zImuZii3A9PYUXYSr6Wk3uuG0zdAjuaPyhK2YwawqKRTxtGELOF0=
Received: from PH8P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::17)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 05:37:44 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:510:348:cafe::5c) by PH8P220CA0034.outlook.office365.com
 (2603:10b6:510:348::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 05:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:37:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 00:37:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 "Lijo Lazar" <lijo.lazar@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Make first-level trap state GPUVM-owned
Date: Wed, 16 Sep 2026 11:07:20 +0530
Message-ID: <20260916053722.601067-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 21257ce9-8cef-4f89-cfb8-08df13b4a219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: yJ13GuUVCLUiusmRAegTlR3thj3IxQa2Lh/TRdnvaR1ZnTI6DSguvclPeGdSyrKqPMKzWOT0fK57iDgMdILya0aVtzNq/k0tA+ZHCCTOQ/dM1KO2KGR8Y+dTMO24J0mcYqEJMGiav/lMTWb+W5N8aS+JjphOyt5ibKEvFsq5DSaay/fYLMxtN5pYxl6SiCSaLk3Vq7A/3a8ImB8gCehmTLaV2Qe63rgL5u71G9pbTpw7OXvq5EIL5m9Pl0LN0+8aQMxDYl0ZnFbGIPL9Jm1BIdyOfeGnAOHtT6GfwOIxwaxRbPYQYz4cfKzAlfSwsYeM7Ki6BoW8IYAOp0S46/OZLwLlBPptj416sarb+4ogYZtsHs3bEnkXmQQnRgVSLeofxr5vnTWdKkFW3tEA/eLKlNAoH02wwBPTqJOnHorafVEqgpQlgwaLiKyxKB9MRr8D/EPs5mrH40M2e2QQ+XHKhPSaYWv5yI6vK1hMcfIZ6ZM6Rr6RMBOmvHsMm35F3rrKNjvspE0NDnMxW5tEzwvngqpdfN6OGc4fa9VAwJVOiHmRN2uV7SX2oZ4+pDjYz38x/fAxDucsIQAMWymkLiMrEcuRi8Gh/Tlu8cgyvL+esuLucpKYQkMMa/0huUh7IvuCBeNWlY2btI4epDsrFDdiQCxbiByrjpM9uFzLwJV548saOxdaCgx2sOiy5k1WVls3dPBahOjU1LrDqE1Gw/3GuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zXMcLiyyIZoo4G28Zq9oz2CnSUVFF0avn6lvfYNWU0U1YN6N+zWodEsqQW2vNV3fZEHtnRSjkVN5x4VVx67Ut0LnVdfo6ny0d4wt0S54Ey486L3i/8b5eNVTRQ/iuVxF/2TYUadcVpjjbePOekYpf5vMpop+kKdvJJBGwrinaLo2aRnD4gwC09/P+c/ygiGowIJlh1VhkE/OV1N9Wa49+Cu0e45aXqbcarD0Wj4bkWQ0j8EmdgBbOGMO6FvFGthYc9+liRIer0ohBB3lFB28lQZz3cAHlKT2thdMKv1Cl+/kMBiPqiIyPKeFp1356bE9qDfy8wioimqLtP6VKkSHgsIuI2klh4Yy6BtYC0UHE5Xxeh5AynhbLgPC+XNt7dnZ7XHtkf2IFh8yZacgBw1cv6w9a3uTLf7QD0E47O8D3ivDzBZ130cbUApUT6o3Rgnk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:37:44.3275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21257ce9-8cef-4f89-cfb8-08df13b4a219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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

The first-level trap mapping is a property of a GPU virtual address
space, not of a queue type. User queues and kernel queues executing in
the same GPUVM read the same TMA, so both paths must not carry separate
trap allocations.

Move ownership of the trap object to struct amdgpu_vm and create it
during VM initialization. Keep fpriv->trap_obj as a read-only alias so
the existing render-node ioctl paths do not need changes.  This also
establishes the trap mapping before a GPUVM can be used by any queue
type, which allows the gfxhub setup code in the following patch to
enable TRAP_EN without a deferred allocation.

The first-level ISA binary is identical across VMs for the same hardware
generation. It is copied once into adev->trap_info->isa_bo at device
init and mapped into each GPUVM at vm_init rather than duplicated
per-VM.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  8 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 +++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 559c9222fc48..5ff3e62671b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1641,11 +1641,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 
-	if (amdgpu_trap_is_enabled(adev)) {
-		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
-		if (r)
-			dev_dbg(adev->dev, "trap handler not enabled");
-	}
+	/* The trap object is owned by the GPUVM; expose it as an alias. */
+	fpriv->trap_obj = fpriv->vm.trap_obj;
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
@@ -1716,7 +1713,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
-	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 930b744c5f5f..d981915ac2f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -44,6 +44,7 @@
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
 #include "kfd_svm.h"
+#include "amdgpu_trap.h"
 
 /**
  * DOC: GPUVM
@@ -2639,6 +2640,14 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
+	if (amdgpu_trap_is_enabled(adev)) {
+		r = amdgpu_trap_alloc(adev, vm, &vm->trap_obj);
+		if (r) {
+			amdgpu_vm_fini(adev, vm);
+			return r;
+		}
+	}
+
 	r = amdgpu_vm_create_task_info(vm);
 	if (r)
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
@@ -2753,6 +2762,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	/*
+	 * Free trap state before reserving root. amdgpu_trap_free()
+	 * uses drm_exec to lock the page directory internally; calling
+	 * it after amdgpu_bo_reserve(root) would deadlock on the same
+	 * ww_mutex.
+	 */
+	if (vm->trap_obj)
+		amdgpu_trap_free(adev, vm, NULL, &vm->trap_obj);
+
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	dma_fence_wait(vm->last_unlocked, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index dd825e179979..8707618c199e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -488,6 +488,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* First-level trap state shared by all queue paths using this GPUVM. */
+	struct amdgpu_trap_obj *trap_obj;
 };
 
 struct amdgpu_vm_manager {
-- 
2.34.1

