Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D017EC43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 06:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA0910F643;
	Fri,  3 Jul 2026 06:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WJZRcPm9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E04410F627
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 06:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rorQTQ1WBjaVH0NadGnmTQXOzrvamr2bEYZuBvDmwucP9EeJKkr1pJo8Le1+LVG6lINT6bZe1hS9+g+/mUMf/Ihbb28SraUsxdTkGGk9gHjitAo76j2wxCle4noU3t7+HSZlRftpvcPtnprr73ks1I5vSuOJuR8Kj5n4jjo18fyl36pdxYY7picFFWYxxd2stiW49YWZkIgvRRkC0QbOxJtt5c9AGkRCvp/xKzFisXRKSb9TMMfalThgBhNFRIRhac9jex38qsfCH1E9N3/YM+uOeADOr5kQgL/qkmolGe8rV9aEl1Wi1zLE8iUOLa2sv/9lVLM1R2LVIkwkhioMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUreB5WoIh2c+Q5g36aObh62MbWxwOerk3OIaphJnbk=;
 b=ZzLW8TgHckpDmX5wNPnFgyMynvUty5sUEOKKMIr/llsy4XFKSHtdNbLSLG3aOy4Lxh1eN2JqbhJ6t7Mk0rdz+TmC3FbOhlagS5jAj59n9KqETIssYrto3I6wVa3N7/4vuJ26OdwXK3I62iypuMZXmkJ2H/wcQCe2C0+azRThbRjGgRFhpJlkNiWS2RbVHqy9vUnGGhb0l+92fS6hXRi6QNVuh0u78oDP1UOgVwvxb3UjEmSfcx4yBZU8M9Xmmn6SwvJ1u8n3i2ioZh1Ug4/erzsRiQir1lIwB9yW2zJQoqI55UUlQk+Ng+gpbcbjuBfHr0KlexsAbnFtVujhDtO5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUreB5WoIh2c+Q5g36aObh62MbWxwOerk3OIaphJnbk=;
 b=WJZRcPm97ZBVrKNO93pDsXnpEClP8wb/7j556yOiqNicO2Xp5ZxSx944x461xK6lAy005IpIzcESIDiVvaR6O7hq44A+1MFQjZAYLdPsr76IMvhybQK8BvyQvTG0q3LV4U2xh2bwz1s4fAG1LhCQ6atJxWHAknGRW5iqOHrf/cQ=
Received: from BL1P223CA0034.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::16)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:19:00 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::92) by BL1P223CA0034.outlook.office365.com
 (2603:10b6:208:5b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 06:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 06:18:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 3 Jul 2026 01:18:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 3/3] drm/amdgpu: Drop vm_manager PASID to VM mapping
Date: Fri, 3 Jul 2026 11:48:33 +0530
Message-ID: <20260703061833.3163913-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
References: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: d610dcd1-c85b-4b66-b68b-08ded8caf866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ld1BETfX5O0NCO5KMQkEISdtObtdjgz2EQXhPqNnAwjMmZLrCgOjmXHyHrZXFIzOwmONsmUt2akOBRjFkveZwuFeBtauWKeVxz2pVxp0XVUOPjAWquJ7P5bZUSRV2CWnVJDsdumtjRkGdZcbgSA2ozp/8r+R0Xg5Gvd3ISDhT9jjie0ryAOvyLox5NSzQzS8m/qARDQ1lAimSAROYO7nR2F9M1EcmduwqmqVaDVtZGkBaU+WKoiaBRiCy1GlK40MP8dD098JJDOwGjUW97AIurO+BTk0VGrM3DMq9V+EvNEB7RCuUztSIUkFYsmw60P+iYCjZqPb/xJlmcSxz9Zg4h2O08FKD+CUtedfftQzVqivBllBPyWm/r5WVw1hrM6xzi3Wl3xlI2Jhb2zGbE6M8MZnOKZOBM9iAk7XjZqXlF4iiDsF2WtkrMBNAfoEAKi5VNwZLw4/ELt/X1fO4J7CGGenBnCrU8hPUubq8rXztc9u6beXgGym/KVm30ZmHrJZe7G2klkStl7wloud7h2kKxx3gbl535kavM8eThU+GZBOEjzouBuykvgEwpLm3Rhn8Idtmjz7Alm4iErjyxIIau+Z30dS/fTKZ3gSNuCBRNSxI4Aoea0EVRZgW6gKuJ7bC1REDiYjDvq5S59Pv1b4mYG1RRVbLIKTwVPFJLBcQwKfhfobsD0Zds066K1y09ip9m52TVdBgnHi+Ur6M2W/fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fjj5/XNcTLT63k9u7/7a9YwEcTu7NWpcTrKBpMff3aiyMEwa+pHReDk3v3Vslb21TMCjIFa6VVGHmz4yGbImJXtd8h5gRuHw9ZxxzcLi5G5BQvLti6sbyFixUp4HPJTyexhrr6c++CIwnzvBNIWGRr9GD7mx2wjZer9tReH5MaKWcqr6+rjTLwgvvA/2uLbz9HXvKcZFKBruNLc18DrzvagiJg3eEXZzn8jFF9H2zWn1AbtR301x/PdoQgpX/cmbvXvpw1H3MgsVtlTBvn/ClFhe4BAYXKF0lzcohufc1FjIss+M3eSXbM8Y3aWksZPwUN1x68JIn3FcXppbTOmghGEDcCj9ittgsZgL1tGxBGXlh6RFCKQ3VLyKyjjU/KuV/cGsU9grPunJzTpAolKoiVIV/vV3ECGp3kjTyzXDOa/GT4mgVharDpwF3pMoHDrT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:18:59.5267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d610dcd1-c85b-4b66-b68b-08ded8caf866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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

Remove PASID registration and teardown from VM init/fini paths, drop
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
index 9092ff227a55..74836240edbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2647,14 +2647,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -2662,11 +2655,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -2773,11 +2762,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
@@ -2873,8 +2857,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #else
 	adev->vm_manager.vm_update_mode = 0;
 #endif
-
-	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -2886,9 +2868,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
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

