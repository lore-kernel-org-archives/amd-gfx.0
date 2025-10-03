Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1181ECAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 20:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA6110E04E;
	Fri,  3 Oct 2025 20:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BDsvER2A";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798BB10E04E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 20:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDsZ8Y72oCOZGX6BwO0IfBt+oKg8BAxtsi2HO1fFwEIoZhy/SmuoPutJftVmZ2vaMTzehoVx1z3J1lfjm28o5++cl6zDwO7Qs/pu5FjMsdWToyaxusTcAVMO1fRVCosL7I7FVp/C91jpnauiw38rmcOil57G0dNSYs6fL0Sa9TQ5xwPuNIPQDlC1bDjxB/A2WkI/ex5e1x+u4ms05T03d3oVBA+nXpMXdftcg8uJFHl1tL1IpFH4SXH90V5zZX7EBiLhDdnaA/RZSmat5j+uO7i4QYQlqnSFTKEPNfUrF5Y1XP44YcPRRY40KwCofa//zB2SmP+glBxocZnEg3rcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9RzXr9HYy7+3KbiRsBn++Xg0GSC9Bm5KkB4rXQ6Zzo=;
 b=QznyNpVP/4pNgqQ8c3H8V+lg3T5YUM6HPbgB3exXOiRugpZfj54M9+Dp4fv0b+UuGDmuZn8hzesMuXNxxtl3Ku/BOiufDWPZZ2laW6mdagXxcZnjnT7Fm1R0Z1IYdnyfA/fUg+/6ObP/kwqBucQmPaL96eVc9LyKzY1jUG36QdOkPRk4V8oaBSc03Kkk/ir33I8RjS/+9XrPUXNNYfpNgMbDFl1STz43dqu2rLMdqcLdwrEv1tWGtVBDlJqIt8FVFcpCLY0EcXxDZ4jEIUE/TWKFMx4ssbgj/rhGXrj/QllklHDjp06QKDzYXLPI4K9Loeq+Stq4jeVMUMySpNKyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9RzXr9HYy7+3KbiRsBn++Xg0GSC9Bm5KkB4rXQ6Zzo=;
 b=BDsvER2AJasyr+pJuJF8WMkGsu6zm1dPuDJwRZzgv083orBpZ7Pf+ODA6cyzUx+soKyHMWIWGdZbVp0vplh4JQzhSaYvyrGELGBf4u2L1VFKZ6g9AqEnTU05gW05fSVVo/UTx3hs46kvz6sNrvDKB++X7Rehlj9SFdV7gVOGY7Q=
Received: from BYAPR21CA0002.namprd21.prod.outlook.com (2603:10b6:a03:114::12)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Fri, 3 Oct
 2025 20:37:32 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::e1) by BYAPR21CA0002.outlook.office365.com
 (2603:10b6:a03:114::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.7 via Frontend Transport; Fri, 3
 Oct 2025 20:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:37:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:37:29 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: revert to old status lock handling v3"
Date: Fri, 3 Oct 2025 16:37:09 -0400
Message-ID: <20251003203710.39747-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e582f0-7c97-45de-aff8-08de02bcad2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1drVEUydFFnNzNkZElSMFZsZnk5RFZsNktRalJ1bmVtS0ZnL1NFbDQxa3Z5?=
 =?utf-8?B?dWpFVEQ3TlNmM3l4VG1uRzFSZGV6QW10YWcwM0NaRThOVVBvY1hmRWdXVmZo?=
 =?utf-8?B?Y2ZzMmh2cWI0VE02UmRRdUdiblEwd0hJdFZmS0JxU1N2U1N2cE14VjQ2cnpl?=
 =?utf-8?B?Rm5vZURHZUd0TXRGV05ReU1CbWpUVjhtZ2tqZ2M1ZjFRZmZTU0RUUFlQRTZ1?=
 =?utf-8?B?QVVvSVUyQTVDK2tRbWYyT0ozRllYNmJvS0Rkd1E1MkhON1hnWkk4UU8rdmZI?=
 =?utf-8?B?NGYvNSt2Rk5CR05DUllqQWZDdjVKUTdudVlYa2JZU0daTUUwWnk1dEg5ZzFN?=
 =?utf-8?B?K0JaSHd3NVU2MFQ5RjNka0tpZkw3WWRtOER0SHB5L21DWS9ER2ZwQ0p5a1BQ?=
 =?utf-8?B?eDg4MmFFUkdnSlEvMjgyU3ozaHNlcERQU1c1YlU4WUNhUUxQMW13T0MwZEdk?=
 =?utf-8?B?QmxXYjAwK0NPTmwwYTBlbnNPdmgxTDdUZnpEaG54b2RFWTBGYjl2NUZ3eVlV?=
 =?utf-8?B?UjYrTENadXpINHZ4dDdkZDc2MjVSc01XUG1NRnhCM3N3Z2ZaTnBZKzVtVm1j?=
 =?utf-8?B?UENzSW5sa3FqOEpFYkhOd3AvNDBrNTM2ZlAxV2podVMwWDNZZVhieUpBQnRm?=
 =?utf-8?B?Nm9LYllnR2l4WU03NUZsbFJ2WFdCV2kxMTdVWUFNSjhRM01hS29aMEZVT0Vq?=
 =?utf-8?B?SVBGQXFFT21Qa0pBUzlURkpWVmw2enFpVXRWelcxeXhoTVI3TG4wSEtydFhH?=
 =?utf-8?B?eW4yWjQ5bDdBaWhtRm5VL0FFS1Q4dzFPUnVGYm1GYjNkNk5adDJ3NkRGMlll?=
 =?utf-8?B?WkNMZWZTZVZyb3lVdkVNc1JBelpXRWxjazRHWkRCTTgvdllFTU1CQXFtbnBE?=
 =?utf-8?B?Q2JtQnl6azN3YVNSa2JnSFJVbzlaWFQwSUdSQWthNnRieG14SGpWZE5DL1Nt?=
 =?utf-8?B?Nm5ZdjJhRnY4M0pINE1IM2h3YWFBSjVpaCs5T1cyUUxDLzNkOU5ZUW5oM0dN?=
 =?utf-8?B?UkFmU3BMcWFWQzZ6d0ZXanJMWDRqcHljK2pablN5SEtNMzdxR2FBR3NnTmNm?=
 =?utf-8?B?R3lzM0NpU2hqMkZFb214ZC9EV3VZN1lsWmp2cUZ6WXprbVd3UlU3YnR2Tmhu?=
 =?utf-8?B?MUt1OEQxV1pkUDZBYm9ycU5qaHBnL1Y4Y1dUVlc0ZnpLaDNUb09icWNUb21Q?=
 =?utf-8?B?VFYvVjRPUEp5UDBoMTVXb3kvQ05nMXhBRGVhLzYrQ1JUNFkrVlFBblVvbUFD?=
 =?utf-8?B?QUxRUTZIUlRvWWRHQWtnR3Fid2c2aVRYblIrMnZHTE9ZSnRUYURrd3pVTWtV?=
 =?utf-8?B?Nm9RSDJPUDRkUUtKQ203NnpwUGZxbTE1M0xtQ1J5QklBc2pISDEyTEdmcHBD?=
 =?utf-8?B?TmtyMnhwVzlwM0lqNXhlL0NSUm10UjdnSHhuZjFCU0JTUmFSWERncDRHMlJX?=
 =?utf-8?B?RkVHOWpqNWVIMWJMblpkMUFKVmp4UzA1c0xxQ0t0NUE0UXo0Qzk4MFhxS00x?=
 =?utf-8?B?Vk55YjV1RUorK3NNSFFUdFNtOG5OZk55T3Y1QmtDakoxOU1FUXc1OHY0SDUz?=
 =?utf-8?B?WEs4TFptVW1xc0drZHAxTllCUlllbld2VkZlUHhJcnBaRGFWY3FBY2VUMFhI?=
 =?utf-8?B?RStmcXZycDBvaFRvOUV6RGNseCt6UlJqL3Urd1BSa1M0Q2x4cGIwOXRNNVNN?=
 =?utf-8?B?eDNoZDNOZ1NrdHJYbmxQVjhhS1VORXMrOExIOVZTa1AvYzdPd20rRThLbTdT?=
 =?utf-8?B?NlN4SEM0L0ZxZ3RDYzFlN2pHdkNaZWhsN0hZK01NcC9kcjNpYjdXZ3Bwd1Uv?=
 =?utf-8?B?U1gxbHVvQkdQZGJzbFpLbkZROG4xZlFvOC9vejhtQW9BVS8vWjhYeDZscVlF?=
 =?utf-8?B?ZWdtdHRCd2RkMW83ZVJPU0IwRTZGbFp5TTJmUlhiVCtkSUFTa253c0RLY0tq?=
 =?utf-8?B?Nlo1cWxta1pMOTdWd1phOUdyNGNMazh4VjJpV2tPdUR5SXBEUU81OThpbEVW?=
 =?utf-8?B?eXpCWWZ1YW5xTk9Ub0wyTnA5SGtkanlrSHc4YS8ya2YzTFBmTFljQ0VGdlJt?=
 =?utf-8?B?allobTlMWm1MUG5OcEltY1VSdWo2K1hnQkd2L0dMWEtRK2t1dXNjVUIwNWtN?=
 =?utf-8?Q?vPb8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:37:31.4207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e582f0-7c97-45de-aff8-08de02bcad2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286
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

This reverts commit 59e4405e9ee2b318342d252422a82dd863b89ef4.

This results in various warnings.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4614
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 166 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 +
 4 files changed, 102 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3bbe1001fda18..8dc12064da495 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -724,12 +724,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	struct amdgpu_bo *bo;
 	int ret;
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
-		spin_unlock(&vm->invalidated_lock);
+		spin_unlock(&vm->status_lock);
 
 		bo = bo_va->base.bo;
 		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
@@ -746,9 +746,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 		if (ret)
 			return ret;
 
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->status_lock);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 563cad9c6cbce..1dd318b90141a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -127,17 +127,6 @@ struct amdgpu_vm_tlb_seq_struct {
 	struct dma_fence_cb cb;
 };
 
-/**
- * amdgpu_vm_assert_locked - check if VM is correctly locked
- * @vm: the VM which schould be tested
- *
- * Asserts that the VM root PD is locked.
- */
-static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
-{
-	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
-}
-
 /**
  * amdgpu_vm_bo_evicted - vm_bo is evicted
  *
@@ -152,11 +141,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 	struct amdgpu_bo *bo = vm_bo->bo;
 
 	vm_bo->moved = true;
-	amdgpu_vm_assert_locked(vm);
+	spin_lock(&vm_bo->vm->status_lock);
 	if (bo->tbo.type == ttm_bo_type_kernel)
 		list_move(&vm_bo->vm_status, &vm->evicted);
 	else
 		list_move_tail(&vm_bo->vm_status, &vm->evicted);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 /**
  * amdgpu_vm_bo_moved - vm_bo is moved
@@ -168,8 +158,9 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -182,8 +173,9 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
+	spin_unlock(&vm_bo->vm->status_lock);
 	vm_bo->moved = false;
 }
 
@@ -197,9 +189,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->invalidated_lock);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
-	spin_unlock(&vm_bo->vm->invalidated_lock);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -212,9 +204,10 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
 	vm_bo->moved = true;
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -227,11 +220,13 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	if (vm_bo->bo->parent)
+	if (vm_bo->bo->parent) {
+		spin_lock(&vm_bo->vm->status_lock);
 		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-	else
+		spin_unlock(&vm_bo->vm->status_lock);
+	} else {
 		amdgpu_vm_bo_idle(vm_bo);
+	}
 }
 
 /**
@@ -244,8 +239,9 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -259,13 +255,10 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
 	struct amdgpu_vm_bo_base *vm_bo, *tmp;
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	list_splice_init(&vm->done, &vm->invalidated);
 	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
 		vm_bo->moved = true;
-	spin_unlock(&vm->invalidated_lock);
-
-	amdgpu_vm_assert_locked(vm_bo->vm);
 	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
 		struct amdgpu_bo *bo = vm_bo->bo;
 
@@ -275,13 +268,14 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 		else if (bo->parent)
 			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
 	}
+	spin_unlock(&vm->status_lock);
 }
 
 /**
  * amdgpu_vm_update_shared - helper to update shared memory stat
  * @base: base structure for tracking BO usage in a VM
  *
- * Takes the vm stats_lock and updates the shared memory stat. If the basic
+ * Takes the vm status_lock and updates the shared memory stat. If the basic
  * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
  * as well.
  */
@@ -293,8 +287,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
 	bool shared;
 
-	dma_resv_assert_held(bo->tbo.base.resv);
-	spin_lock(&vm->stats_lock);
+	spin_lock(&vm->status_lock);
 	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	if (base->shared != shared) {
 		base->shared = shared;
@@ -306,7 +299,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 			vm->stats[bo_memtype].drm.private += size;
 		}
 	}
-	spin_unlock(&vm->stats_lock);
+	spin_unlock(&vm->status_lock);
 }
 
 /**
@@ -331,11 +324,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
  *        be bo->tbo.resource
  * @sign: if we should add (+1) or subtract (-1) from the stat
  *
- * Caller need to have the vm stats_lock held. Useful for when multiple update
+ * Caller need to have the vm status_lock held. Useful for when multiple update
  * need to happen at the same time.
  */
 static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
-					  struct ttm_resource *res, int sign)
+			    struct ttm_resource *res, int sign)
 {
 	struct amdgpu_vm *vm = base->vm;
 	struct amdgpu_bo *bo = base->bo;
@@ -359,8 +352,7 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
 		 */
 		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
 			vm->stats[res_memtype].drm.purgeable += size;
-		if (!(bo->preferred_domains &
-		      amdgpu_mem_type_to_domain(res_memtype)))
+		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
 			vm->stats[bo_memtype].evicted += size;
 	}
 }
@@ -379,9 +371,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
 {
 	struct amdgpu_vm *vm = base->vm;
 
-	spin_lock(&vm->stats_lock);
+	spin_lock(&vm->status_lock);
 	amdgpu_vm_update_stats_locked(base, res, sign);
-	spin_unlock(&vm->stats_lock);
+	spin_unlock(&vm->status_lock);
 }
 
 /**
@@ -407,10 +399,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
-	spin_lock(&vm->stats_lock);
+	spin_lock(&vm->status_lock);
 	base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
-	spin_unlock(&vm->stats_lock);
+	spin_unlock(&vm->status_lock);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -469,10 +461,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 	int ret;
 
 	/* We can only trust prev->next while holding the lock */
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	while (!list_is_head(prev->next, &vm->done)) {
 		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
-		spin_unlock(&vm->invalidated_lock);
+		spin_unlock(&vm->status_lock);
 
 		bo = bo_va->base.bo;
 		if (bo) {
@@ -480,10 +472,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 			if (unlikely(ret))
 				return ret;
 		}
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->status_lock);
 		prev = prev->next;
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	return 0;
 }
@@ -579,7 +571,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       void *param)
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
-	struct amdgpu_vm_bo_base *bo_base, *tmp;
+	struct amdgpu_vm_bo_base *bo_base;
 	struct amdgpu_bo *bo;
 	int r;
 
@@ -592,7 +584,13 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			return r;
 	}
 
-	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->evicted)) {
+		bo_base = list_first_entry(&vm->evicted,
+					   struct amdgpu_vm_bo_base,
+					   vm_status);
+		spin_unlock(&vm->status_lock);
+
 		bo = bo_base->bo;
 
 		r = validate(param, bo);
@@ -605,21 +603,26 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
 			amdgpu_vm_bo_relocated(bo_base);
 		}
+		spin_lock(&vm->status_lock);
 	}
+	while (ticket && !list_empty(&vm->evicted_user)) {
+		bo_base = list_first_entry(&vm->evicted_user,
+					   struct amdgpu_vm_bo_base,
+					   vm_status);
+		spin_unlock(&vm->status_lock);
 
-	if (ticket) {
-		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
-					 vm_status) {
-			bo = bo_base->bo;
-			dma_resv_assert_held(bo->tbo.base.resv);
+		bo = bo_base->bo;
+		dma_resv_assert_held(bo->tbo.base.resv);
 
-			r = validate(param, bo);
-			if (r)
-				return r;
+		r = validate(param, bo);
+		if (r)
+			return r;
 
-			amdgpu_vm_bo_invalidated(bo_base);
-		}
+		amdgpu_vm_bo_invalidated(bo_base);
+
+		spin_lock(&vm->status_lock);
 	}
+	spin_unlock(&vm->status_lock);
 
 	amdgpu_vm_eviction_lock(vm);
 	vm->evicting = false;
@@ -642,13 +645,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 {
 	bool ret;
 
-	amdgpu_vm_assert_locked(vm);
-
 	amdgpu_vm_eviction_lock(vm);
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
+	spin_lock(&vm->status_lock);
 	ret &= list_empty(&vm->evicted);
+	spin_unlock(&vm->status_lock);
 
 	spin_lock(&vm->immediate.lock);
 	ret &= !vm->immediate.stopped;
@@ -939,13 +942,16 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate)
 {
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_vm_bo_base *entry, *tmp;
+	struct amdgpu_vm_bo_base *entry;
 	bool flush_tlb_needed = false;
+	LIST_HEAD(relocated);
 	int r, idx;
 
-	amdgpu_vm_assert_locked(vm);
+	spin_lock(&vm->status_lock);
+	list_splice_init(&vm->relocated, &relocated);
+	spin_unlock(&vm->status_lock);
 
-	if (list_empty(&vm->relocated))
+	if (list_empty(&relocated))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -960,7 +966,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &vm->relocated, vm_status) {
+	list_for_each_entry(entry, &relocated, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -976,7 +982,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
+	while (!list_empty(&relocated)) {
+		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
+					 vm_status);
 		amdgpu_vm_bo_idle(entry);
 	}
 
@@ -1202,9 +1210,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
 {
-	spin_lock(&vm->stats_lock);
+	spin_lock(&vm->status_lock);
 	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
-	spin_unlock(&vm->stats_lock);
+	spin_unlock(&vm->status_lock);
 }
 
 /**
@@ -1571,24 +1579,29 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
 			   struct ww_acquire_ctx *ticket)
 {
-	struct amdgpu_bo_va *bo_va, *tmp;
+	struct amdgpu_bo_va *bo_va;
 	struct dma_resv *resv;
 	bool clear, unlock;
 	int r;
 
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->moved)) {
+		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
+					 base.vm_status);
+		spin_unlock(&vm->status_lock);
+
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
+		spin_lock(&vm->status_lock);
 	}
 
-	spin_lock(&vm->invalidated_lock);
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
 		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->invalidated_lock);
+		spin_unlock(&vm->status_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
 		if (!adev->debug_vm && dma_resv_trylock(resv)) {
@@ -1620,9 +1633,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
 			amdgpu_vm_bo_evicted_user(&bo_va->base);
 
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->status_lock);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	return 0;
 }
@@ -2151,9 +2164,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2261,10 +2274,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
-		spin_lock(&vm->stats_lock);
+		spin_lock(&vm->status_lock);
 		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
 		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
-		spin_unlock(&vm->stats_lock);
+		spin_unlock(&vm->status_lock);
 	}
 
 	amdgpu_vm_bo_invalidate(bo, evicted);
@@ -2532,12 +2545,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	INIT_LIST_HEAD(&vm->relocated);
 	INIT_LIST_HEAD(&vm->moved);
 	INIT_LIST_HEAD(&vm->idle);
-	spin_lock_init(&vm->invalidated_lock);
 	INIT_LIST_HEAD(&vm->invalidated);
+	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
 	INIT_KFIFO(vm->faults);
-	spin_lock_init(&vm->stats_lock);
 
 	r = amdgpu_vm_init_entities(adev, vm);
 	if (r)
@@ -3011,8 +3023,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	unsigned int total_done_objs = 0;
 	unsigned int id = 0;
 
-	amdgpu_vm_assert_locked(vm);
-
+	spin_lock(&vm->status_lock);
 	seq_puts(m, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
@@ -3050,13 +3061,11 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	id = 0;
 
 	seq_puts(m, "\tInvalidated BOs:\n");
-	spin_lock(&vm->invalidated_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
 		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
 	}
-	spin_unlock(&vm->invalidated_lock);
 	total_invalidated_objs = id;
 	id = 0;
 
@@ -3066,6 +3075,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 			continue;
 		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
 	}
+	spin_unlock(&vm->status_lock);
 	total_done_objs = id;
 
 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 556d0483c6bcd..77207f4e448ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
 	/* protected by bo being reserved */
 	struct amdgpu_vm_bo_base	*next;
 
-	/* protected by vm reservation and invalidated_lock */
+	/* protected by vm status_lock */
 	struct list_head		vm_status;
 
 	/* if the bo is counted as shared in mem stats
-	 * protected by vm BO being reserved */
+	 * protected by vm status_lock */
 	bool				shared;
 
 	/* protected by the BO being reserved */
@@ -343,8 +343,10 @@ struct amdgpu_vm {
 	bool			evicting;
 	unsigned int		saved_flags;
 
-	/* Memory statistics for this vm, protected by stats_lock */
-	spinlock_t		stats_lock;
+	/* Lock to protect vm_bo add/del/move on all lists of vm */
+	spinlock_t		status_lock;
+
+	/* Memory statistics for this vm, protected by status_lock */
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 
 	/*
@@ -352,8 +354,6 @@ struct amdgpu_vm {
 	 * PDs, PTs or per VM BOs. The state transits are:
 	 *
 	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
-	 *
-	 * Lists are protected by the root PD dma_resv lock.
 	 */
 
 	/* Per-VM and PT BOs who needs a validation */
@@ -374,10 +374,7 @@ struct amdgpu_vm {
 	 * state transits are:
 	 *
 	 * evicted_user or invalidated -> done
-	 *
-	 * Lists are protected by the invalidated_lock.
 	 */
-	spinlock_t		invalidated_lock;
 
 	/* BOs for user mode queues that need a validation */
 	struct list_head	evicted_user;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f57c48b742740..30022123b0bf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -541,7 +541,9 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
+	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
+	spin_unlock(&entry->vm->status_lock);
 	amdgpu_bo_unref(&entry->bo);
 }
 
@@ -585,6 +587,7 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 	struct amdgpu_vm_pt_cursor seek;
 	struct amdgpu_vm_bo_base *entry;
 
+	spin_lock(&params->vm->status_lock);
 	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
 		if (entry && entry->bo)
 			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
@@ -592,6 +595,7 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 
 	/* enter start node now */
 	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
+	spin_unlock(&params->vm->status_lock);
 }
 
 /**
-- 
2.51.0

