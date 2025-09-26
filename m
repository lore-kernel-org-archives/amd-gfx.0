Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC98CAC5AC
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 08:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5970410E9E9;
	Fri, 26 Sep 2025 08:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aOrGxyuD";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8889210E9E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 08:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjgE86oGWbJwnLEe60jpD0br1/TEQ+BrTO6xhw52Gamzx3BaFkNDGiZ302M/SuIeKHSfg5BmTBQnoHoqTv3IZfeb55nmhY65xlTYrSsdXz08zzWJ9p8g03eV5rwCw65Fw8G+Z7f+m3VxDPKeBWeTradpdf91GP1iF5kQKjf8tkhw98ZHF+1Sd0dU/LdwGzMhN9k3yOUfTk875evgHeyUbzSDdbXvBGBzCiH6nLz/h9XHp4ld0zrZe2npUMnjX3X/sDNNfw9qRoz6VlyYthU+lDg/BpwHvu+3BzYIZ29spoqETyegcyDQuhrx+OfKaT0z10SgOMiqj6qGEmDJP18Law==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR0W4tkxyCKVW32eAssSkOiFFdFM/fKbJdGdgbVPfhk=;
 b=wZqiLABPvHlSKKL5gSD2JYryMj+jydb0Ds50OKSLPhzEhz4oKnBYl7uTi91w1ZnoG+JPTq+y+tWLvmvSk+rPZTFuKeoj3ZYIzzlZgem4xPIM0tyok1zEhBeMe41uYdLuiGO6wfqG21S/gk2meKO76PJ2foA/7QBpUH1hQeOmOKrN55b0pfZad+eG7pSZVufTy15aUAtS1BsCjW//eda1+IK76ER0HOysoKkFeisX/cuDxQTB7GOvYfTVH5cPnGlDtD2PLAwv8wzCQb7uyWx31K5VjFLX/iqCapIJP4TWpyEv4sjP4Z2ZcCq06+2dQ/myPr+6nl+lWBYhTx1+balP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR0W4tkxyCKVW32eAssSkOiFFdFM/fKbJdGdgbVPfhk=;
 b=aOrGxyuDqNmhzwjrFEukGMz1F7560xr6H8q/PV99GbZ7LtaNvnAVtOfkCWXWVWF2oP8AIf3uH9/Ugb6tn9kKbyBDVcURMz0oAspu8j1d5+VF5HFS4WTOJz93k1yoSd/jgMidDf7aTNnhB0OU8GlWTSMivgi1ui/qHeDDDZg9Ydk=
Received: from PH8P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::33)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Fri, 26 Sep 2025 08:03:51 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:2d7:cafe::5d) by PH8P222CA0022.outlook.office365.com
 (2603:10b6:510:2d7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Fri,
 26 Sep 2025 08:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Fri, 26 Sep 2025 08:03:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 01:03:50 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 01:03:49 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [v2] drm/amdgpu: Merge amdgpu_vm_set_pasid into amdgpu_vm_init
Date: Fri, 26 Sep 2025 15:58:13 +0800
Message-ID: <20250926080348.2935967-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: b06ca5ee-4c93-4385-2de3-08ddfcd33ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWxUejYvdmo5aUpUdlVLcFdMamJqNkNuVGJZWGdyN0lGejZmV2hOT2V4L2JB?=
 =?utf-8?B?RGxhU1AySzhja2l2Z3NCcnNvVk14ZjVqWmxCT3VPYUhhZ3lQb1hjaVFTRDgz?=
 =?utf-8?B?dlhVUHFJdlMxemRTZTlhb0svUmdIaFY4WW9JUEFYcENQdlgvaGMvTkVudjhS?=
 =?utf-8?B?WDR2V2I2WnlpVDNjUHRmMlBKS2tKZ1ErdTFrSDZwMHp2ZngyeWhlTk9iTnJj?=
 =?utf-8?B?Mll5Z2krRUgrc1FURnNucHZFUnJSQ3crM2M4VjF2OGhhaEZpTlBUd3YrWmk3?=
 =?utf-8?B?bVk5OG9pQmhFV3BpZlB6UzNvU1g5Q0QwR0RLVlhEb2VpNjZqcGtaTW5DTGtL?=
 =?utf-8?B?VHVjMzNUazc5VTYweUU4TzBEMFpDVnJHWkhSZEhXM1ljUWZjekZGam53b2hL?=
 =?utf-8?B?OStodENQMmxWKzVWOHUzdm0yRXQ1QjZhaU5SMGQwZDFMUkFuR2dJNjM1N09n?=
 =?utf-8?B?OUJjNlpoSEtyUjJaS0JiRkRaUkhPTnlWSnI5RTkvdHRoRURtN2pFdWFBeDd6?=
 =?utf-8?B?VDBWRERsUk16MTVDVEhQTXRad2tYMmY4QktVTkY5UFBQQnRzakRERUtHNkk0?=
 =?utf-8?B?U1VMZjk3R2dRck15NHdHU3NCZlRLM1pwd3c3YmV5R0ZIeGU0bkE4UkdYNzF0?=
 =?utf-8?B?T3ZXbGZMT2IyVkgyM0pUa2JoZWQzMm9VbkNhcHM3TU1EaVZCQTU1WXV2T1U3?=
 =?utf-8?B?eUNnS1dKVzVkWWNZU3phWjZ6LzJJdWZhOHhkR1dqMWVnOTA3ZEdSdkVROFhL?=
 =?utf-8?B?NlhaY0lhdzVkNW9Sdm9PSmIrd0ZUb0NJUWJzcUE1NWNoMEFGcXIxeVhTLzdt?=
 =?utf-8?B?cnhYUUxJVllodkVPYVVXeTdYbURnNzFDMUtXQmdVTlgzWXh4MEpIWkw5V3l0?=
 =?utf-8?B?Rkwxc2M5Ny9iaDZjU1BZQ2F3L1dBNWQrNkYrRWtQcWM4V2JWamlHVDU1aHBh?=
 =?utf-8?B?ZVRTRGpVNFJqVkErU3phemZDQzB1a01LOHl5VFQwbW5qa0dPekRhRlVvV21O?=
 =?utf-8?B?K1ZsejRGNHIrSVBZQTFjRE43NG9mMlVtNzU1RzlhMHl0N0JIQWNvZUFxWjZr?=
 =?utf-8?B?eU1XRDVXQlBMem1POExkcnQ2Z24yVzY2NE5hTGkwZ3RWeU91ejVtdjU4OTdk?=
 =?utf-8?B?SFlBQy9NMDdSYlNTUE5WQ0Y5WlRzWG93WThFanpyTEVKeEFaQldwR1NZYmR3?=
 =?utf-8?B?Ni9WWEdmaUZGa25pUlN4NnhPZVczVjVrZDhmR3lGalozM3JHSmF4Z2s0WGpS?=
 =?utf-8?B?eTd1eUtzcDB0QzZxNXF1T1pqeEl2bzJwaDVaR1lLSTJZSW9PamxYQ3orckdo?=
 =?utf-8?B?QmZsT3ZZUTBISzduVXVDaFJOV3c2anZlNDFmdXNUdDlLZUl3aU4wUHdONy9X?=
 =?utf-8?B?K21ReWNOZjBzR2NOeGd4d21SZzZnNVZ1VFZKNGkvVHp3NG0zTk9mM20zYlA1?=
 =?utf-8?B?aWdXRUNlZTR0YmFXUm1yZjdjcm9JWWJRUUdyNzVKUDV4WDlUN0JUY3VBMnBw?=
 =?utf-8?B?bnNLY29JaGJoM1RiSTI4cDY3OHNDV2ZpZytML1o1OTBlay9PVFJUSE51dTFa?=
 =?utf-8?B?NWxtOUJpcldEVnVOM09GMURJcnpGV25oM1NYL2xCa1hJei9EbkFVbnpmQjR0?=
 =?utf-8?B?V3hqNG51N3lWbHVXOXhpSm42ZWhjTzJlYVJFemIyemVwV1lyaTRCSHJWYkZh?=
 =?utf-8?B?UnNSZ1pKTG82R2laY2R5S1IrV3kwaENxUVNyT3JHU1hZZDkrY3B4ajY5eXJa?=
 =?utf-8?B?VGNMQjJoSEpINHZud1NpNmhFTFpIT3A2VkZneVlIWTBJZ0FBdnQrT3B6Wk9x?=
 =?utf-8?B?WnEyNGdhZFJZWFdqZGZId3hINEY2dmhBS1Q5UnFTWVAzdlMxNFBDUmhnREdO?=
 =?utf-8?B?MWgreURBZnhEczB2ZDhNZ05Mdm04UVd2Ty84QytGb2ZtSFVpTHl6M2Jvckpo?=
 =?utf-8?B?Y0FJcmxoOWk5NE11NjFMSkhwVjJ6ZHhiQ3dnQWJwc1h2MGVlZFpYR1lyaGNR?=
 =?utf-8?B?aWYzcmxPQ0NVcHFqQTZrRy90YnAvWEVHOHk0UlFJU3p0dDIrZm1FN0dyam5x?=
 =?utf-8?B?dU53czVlRlN2bHhEWDV2MmdsQ0xxT29LNS9rSnpzV2djL25BK0t2NXV1U1VD?=
 =?utf-8?Q?b1iM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 08:03:50.8444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06ca5ee-4c93-4385-2de3-08ddfcd33ab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
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

As KFD no longer uses a separate PASID, the global amdgpu_vm_set_pasid()function is no longer necessary.
Merge its functionality directly intoamdgpu_vm_init() to simplify code flow and eliminate redundant locking.

v2: remove superflous check
  adjust amdgpu_vm_fin and remove amdgpu_vm_set_pasid (Chritian)

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 66 +++++++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 +-
 3 files changed, 25 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8676400834fc..a9327472c651 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1421,14 +1421,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_debugfs_vm_init(file_priv);
 
-	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
+	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pasid);
 	if (r)
 		goto error_pasid;
 
-	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
-	if (r)
-		goto error_vm;
-
 	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
 	if (!fpriv->prt_va) {
 		r = -ENOMEM;
@@ -1468,10 +1464,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
 error_pasid:
-	if (pasid) {
+	if (pasid)
 		amdgpu_pasid_free(pasid);
-		amdgpu_vm_set_pasid(adev, &fpriv->vm, 0);
-	}
 
 	kfree(fpriv);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 108d2a838ef0..f78fce37b5a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -138,48 +138,6 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 }
 
-/**
- * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
- *
- * @adev: amdgpu_device pointer
- * @vm: amdgpu_vm pointer
- * @pasid: the pasid the VM is using on this GPU
- *
- * Set the pasid this VM is using on this GPU, can also be used to remove the
- * pasid by passing in zero.
- *
- */
-int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			u32 pasid)
-{
-	int r;
-
-	amdgpu_vm_assert_locked(vm);
-
-	if (vm->pasid == pasid)
-		return 0;
-
-	if (vm->pasid) {
-		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
-		if (r < 0)
-			return r;
-
-		vm->pasid = 0;
-	}
-
-	if (pasid) {
-		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
-					GFP_KERNEL));
-		if (r < 0)
-			return r;
-
-		vm->pasid = pasid;
-	}
-
-
-	return 0;
-}
-
 /**
  * amdgpu_vm_bo_evicted - vm_bo is evicted
  *
@@ -2552,6 +2510,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * @adev: amdgpu_device pointer
  * @vm: requested vm
  * @xcp_id: GPU partition selection id
+ * @pasid: the pasid the VM is using on this GPU
  *
  * Init @vm fields.
  *
@@ -2559,7 +2518,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
  * 0 for success, error for failure.
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int32_t xcp_id)
+		   int32_t xcp_id, uint32_t pasid)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
@@ -2636,12 +2595,26 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
 
+	/* Store new PASID in XArray (if non-zero) */
+	if (pasid != 0) {
+		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm, GFP_KERNEL));
+		if (r < 0)
+			goto error_free_root;
+
+		vm->pasid = pasid;
+	}
+
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
 
 	return 0;
 
 error_free_root:
+	/* If PASID was partially set, erase it from XArray before failing */
+	if (vm->pasid != 0) {
+		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
+		vm->pasid = 0;
+	}
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
@@ -2747,7 +2720,12 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	amdgpu_vm_set_pasid(adev, vm, 0);
+	/* Remove PASID mapping before destroying VM */
+	if (vm->pasid != 0) {
+		amdgpu_vm_assert_locked(vm);
+		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
+		vm->pasid = 0;
+	}
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 	dma_fence_wait(vm->last_tlb_flush, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 3b9d583358b0..556d0483c6bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -503,11 +503,8 @@ extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
 void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
-int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			u32 pasid);
-
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id, uint32_t pasid);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
-- 
2.49.0

