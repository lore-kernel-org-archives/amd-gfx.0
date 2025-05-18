Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D3EC3ABC9
	for <amd-gfx@archiver.kernel.org>; Sun, 18 May 2025 06:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21C788EFE;
	Sun, 18 May 2025 06:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UwSpmEsD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100FA88EFE
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 May 2025 06:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJCDfIgZlZORIK3buaVxTMdiLFv4ydOvT+u0W3NcJKKLr+4QkU52jmH17xNI4nxQilqS9vz4ROXROwBbLhnU8Ad4YfLDyiIQuhdvGEfUSXVhs4XXWHqUJaFCFYpSeA4Cw0hsIzf5354CT2SKVe5ipDostg55d9PYewZcBAfwDttpWCalc58EevSq7z7iB6swMNaoClMGCFUGb4dcXlc8G14sTn4WGKO1+VXDEJuZhJYE7pJbn0jGslClghOx2jnXSuE8vLLrannfiGWKvtj1CYdAibErD4n9i7KhWlWsGTtfjtxNFIGx3/fDmAngHRxJ7Fl77jX9AqpKBEQj6NTgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lwrh6s/CJGGM0yv6YlTMIkX3l0XFQMJHCOMHTUZS744=;
 b=gyzs0qOIobXrLi6R0HhGo5B3M78RHDtbvAUuQwKm/ysJYXjehF/Q7695mPdRG7V5LFZj/1hQ1Ro4AX5LXeH9fETRia7mrSsLZMlm8RMJHJMTubkGOI26IN2+KP2GkL6VDEAcAa/dTSvIyemZxANAR04fGGGCNM/Q/tPrGk5BbLRDLqZssHU4FRm63l30lRlE6p/vh4zmkDSHlBuYwlCN7pcqBFwr4+efU3b8voi0uZNntWhox1vIz798J0vMGqCGTnJvhYzxbrTepZSpUwJyQn/3eRA7Ct5jag57/r6Mk8TJWPjVbmpcR7OZl7beuXiaRs4rMotD1DoIdNGanzJvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lwrh6s/CJGGM0yv6YlTMIkX3l0XFQMJHCOMHTUZS744=;
 b=UwSpmEsDmBs6PPZtEbq9fPATCT7n6ege4WURMvF50W9Jwa6DYQetihTXllu810dHOfLsb4pyRbq2S7oxHyuhk3AJtK6vJZu53f1e2p+2OEqn0sd+8HkiFSQTsnjFbQ/jCO0IE3IjIfTuUyasrVeWyOxKOlZ3/tX/NSfAeGahhsE=
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sun, 18 May
 2025 06:04:03 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::73) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Sun,
 18 May 2025 06:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 06:04:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 May 2025 01:03:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last
 Fence Update and Timeline Management v2
Date: Sun, 18 May 2025 11:33:24 +0530
Message-ID: <20250518060324.1384914-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424032123.3888361-1-srinivasan.shanmugam@amd.com>
References: <20250424032123.3888361-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 0562bea4-2d49-4f1a-c9f5-08dd95d1ca4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDNHb1d5eGFodG16cURBalZERVl6c1diM0RGbFFlUkdNQW1ISTRUYm42SFQ0?=
 =?utf-8?B?ZnZCWlEyd0R4ZkhLVmlzbFd2Y2E1UnVCQXdrajZYLzFGL3dHVmQ1ZlVPYWY3?=
 =?utf-8?B?RUlwbW9uSG5jUjhZYzBHTVNtREtkeUQvQXVPV0hZRk1HVTJOenpDa2xvbC9r?=
 =?utf-8?B?aGNqUmdjQkhHSVV0eFA2aEVmOTFVZkg0ZkMzL2VOakk5UkJFNWdmcWw1YXpO?=
 =?utf-8?B?bEg4MnhhR01NQVlZYWdQRllPeUJYUy9MejgyWFUrWmJTUGE2bzNlbkdJTEpP?=
 =?utf-8?B?bm5QMkYrVG1ySWFRbHIwUnF5K2pzMGZ4SW1oZ3BvUE84SVZyRkJTa0htMDBJ?=
 =?utf-8?B?a0VDdjgvWEZndWc0VXRPcWhFYXlWUjllSnVSbnE5SDB6anhvSExuNFYySEc3?=
 =?utf-8?B?TVAvWmFOeGdBSVFHdFNSVVd6VVBqM0E4S0pKajJoV0hEa2ZFVW9yUElwaloy?=
 =?utf-8?B?dFRoVlVkeFUzRHMyYUk0VnZlK1lybE1wZUhRbGpDV3hHMGNoaVM0UzcwOU9k?=
 =?utf-8?B?dHMrSHFreWQ0Mk81cEhEZlMrY1NMUTdLTzNUM3VIUzBQSzU0TEFGTnBYL1h6?=
 =?utf-8?B?cldSd2cvTHFSZkxmR0s2bFdkVUJyZ1VOTGNvVW5ubmE4UWV0Rk1wcy9YWXhU?=
 =?utf-8?B?Tkt6U2JoMkpZU2RqVFFlQnNuYWdZK2FvUXlrSjYvanJyMVV6R2JIaTBrQ1Fh?=
 =?utf-8?B?Vy9lNjIzaW5acUkvdGFHcHJkWFhxL0QvS1BvazdGVm1Ec2FSR1RSczRwQXg5?=
 =?utf-8?B?UEJLM2wvZmNsMmYrM1FRZG9JZlB0RGhicTRXN0lkOW1LQzlzQ05QVTkvNzk3?=
 =?utf-8?B?cEhBZXFab0JhV24zYUZoNUQ2RnV6SlBrcWkyT3ZYWDAxWVpaYURJd1VOU1ZX?=
 =?utf-8?B?eEt5Y1lKcTFtWmwzaFdYcURUOHREbjJjaGtYaS9XT2J2M2NaMFZmeXR5MUlZ?=
 =?utf-8?B?Q2pFVVpkQ3NmUTBSaERhNTJZeElRa1hjdEZqRTZaNXc1NE9PdmwweDF0dVFy?=
 =?utf-8?B?RUtWa2ZURnBjVWx5VUZHRnYxaXc4L1BvUnlQVjdUZzZ4WFBmemFxbm9kNzNB?=
 =?utf-8?B?RklQYTM3L3BMQm1VMlZUTDRuYVdIeEw2MitVdjZSb3cyL2pVSXVmaGduNWU5?=
 =?utf-8?B?S0ZnNElDbDAwSDZGNzhlUTl3RFdRT1MxNjBZMWNEOTZSSHZEVnYyamNZMmhv?=
 =?utf-8?B?aVduaVJSOENsdk1CeEZ2Tks3OEQwbTg5eUlBSld2UzBkaDkrRUxtNmR0bjJV?=
 =?utf-8?B?OE5PMGhMUU5TMDRQbmR4RjFqamNueUZKdzJPMXZTWjF1dzRmSG9adjJBVzVa?=
 =?utf-8?B?dGxEdVpPUlN5TFhXNGh6NVhsaEZwTS9RQ09QQVhucmxzSW9MM2FjSUhTMVpo?=
 =?utf-8?B?Sm1vdVFETWs1endjMVIvd0JyalZ1QjFuT1ArOHc1WmlLZlZPMklidUU4OElJ?=
 =?utf-8?B?WFlOdERsclJwZmdrTVVlUGprQ05DZHBzQjYwd1VFOThxdS9oRWlnUlA1ZG1C?=
 =?utf-8?B?WW45aVl0TG41L0wvczdwY1l1dFlNMGlwQ3FCMnFnVGVyTnVWVDB0VWMzdHVG?=
 =?utf-8?B?ejhOYkpaQisydnpXU3dZSGt0a0d3Smo2UGduSEJnYUdMd1RLK2ZXbVZCcjNJ?=
 =?utf-8?B?QUUweTBzVmRza25sY1VsOVJacjd3eE51YmtJR1UyTXVHR2d2SXJWN0p5VEt0?=
 =?utf-8?B?ZlJCaFF4MFFSNDJFN2ZoUzAwVEZ4SW42c0M0amtzMjZuTXBOYnNJMGhjb3BK?=
 =?utf-8?B?aURpZHIxaktkcjVoZnFTVW9UNjM0bThla2dwcEZZZi9WV3ArSmk0V2lrTk9i?=
 =?utf-8?B?QWlGUDJxbHpFbTE4ZThyV3poS3J3Sm4rWU5XWDVhYjd2RVU2QnlVVDVocW5O?=
 =?utf-8?B?c3BuTW9UTTVUUDIyZ3pxRHpoMTRJSFBFcHpMeDA5ZEZkM2JmN0k4Nzk5eVhM?=
 =?utf-8?B?TC9rclJsb29NTUpHQzV3RnJQSzJmaXVzK3N4d1kxczJYeEY2OGFlYUowUms0?=
 =?utf-8?B?QXc0VlNuQ3p0bkFGb0xjZXF6QWVudGVjb2RwR3hBVWJMUEl3dzFmblJJU2M3?=
 =?utf-8?Q?M0F+hA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 06:04:02.9953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0562bea4-2d49-4f1a-c9f5-08dd95d1ca4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
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

This commit simplifies the amdgpu_gem_va_ioctl function, key updates
include:
 - Moved the logic for managing the last update fence directly into
   amdgpu_gem_va_update_vm.
 - Introduced checks for the timeline point to enable conditional
   replacement or addition of fences.

v2: Addressed review comments from Christian.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 82 +++++++++----------------
 1 file changed, 30 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2c68118fe9fd..aea0c63e441a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -112,47 +112,6 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
 	return 0;
 }
 
-static void
-amdgpu_gem_update_bo_mapping(struct drm_file *filp,
-			     struct amdgpu_bo_va *bo_va,
-			     uint32_t operation,
-			     uint64_t point,
-			     struct dma_fence *fence,
-			     struct drm_syncobj *syncobj,
-			     struct dma_fence_chain *chain)
-{
-	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_vm *vm = &fpriv->vm;
-	struct dma_fence *last_update;
-
-	if (!syncobj)
-		return;
-
-	/* Find the last update fence */
-	switch (operation) {
-	case AMDGPU_VA_OP_MAP:
-	case AMDGPU_VA_OP_REPLACE:
-		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
-			last_update = vm->last_update;
-		else
-			last_update = bo_va->last_pt_update;
-		break;
-	case AMDGPU_VA_OP_UNMAP:
-	case AMDGPU_VA_OP_CLEAR:
-		last_update = fence;
-		break;
-	default:
-		return;
-	}
-
-	/* Add fence to timeline */
-	if (!point)
-		drm_syncobj_replace_fence(syncobj, last_update);
-	else
-		drm_syncobj_add_point(syncobj, chain, last_update, point);
-}
-
 static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
@@ -780,6 +739,12 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			goto error;
+
+		/* Set the last_update fence based on the operation */
+		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
+			fence = vm->last_update; /* Use VM's last update fence */
+		else
+			fence = bo_va->last_pt_update; /* Use buffer object's last update fence */
 	}
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
@@ -845,6 +810,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	uint64_t vm_size;
 	int r = 0;
 
+	/* Validate virtual address */
 	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
 		dev_dbg(dev->dev,
 			"va_address 0x%llx is in reserved area 0x%llx\n",
@@ -878,6 +844,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* Operational check */
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 	case AMDGPU_VA_OP_UNMAP:
@@ -901,6 +868,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		abo = NULL;
 	}
 
+	/* Add input fence for synchronization */
 	r = amdgpu_gem_add_input_fence(filp,
 				       args->input_fence_syncobj_handles,
 				       args->num_syncobj_handles);
@@ -923,6 +891,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			goto error;
 	}
 
+	/* Find buffer object virtual address */
 	if (abo) {
 		bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
 		if (!bo_va) {
@@ -935,6 +904,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	/* Update timeline node for synchronization */
 	r = amdgpu_gem_update_timeline_node(filp,
 					    args->vm_timeline_syncobj_out,
 					    args->vm_timeline_point,
@@ -943,6 +913,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto error;
 
+	/* Call to update VM and retrieve the resulting fence */
+	fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
+					args->operation);
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
@@ -968,19 +942,23 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	default:
 		break;
 	}
+
 	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
-		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
-						args->operation);
-
-		if (timeline_syncobj)
-			amdgpu_gem_update_bo_mapping(filp, bo_va,
-					     args->operation,
-					     args->vm_timeline_point,
-					     fence, timeline_syncobj,
-					     timeline_chain);
-		else
+		if (timeline_syncobj) {
+			if (!args->vm_timeline_point) {
+				/* Replace the existing fence if point is not set */
+				drm_syncobj_replace_fence(timeline_syncobj,
+							  fence);
+			} else {
+				/* Add last update fence at a specific timeline point */
+				drm_syncobj_add_point(timeline_syncobj,
+						      timeline_chain,
+						      fence,
+						      args->vm_timeline_point);
+			}
+		} else {
 			dma_fence_put(fence);
-
+		}
 	}
 
 error:
-- 
2.34.1

