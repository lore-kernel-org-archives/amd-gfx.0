Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA890C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 03:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA2510E719;
	Thu, 24 Apr 2025 03:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4oxOz3N";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97B510E719
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 03:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFR0mwCOHlhii8sXrDnGTqOVyjAgVEwNK8gKhpkyK93/N7218G7H8KSXk1C4OjrzJv58cDwox4ccGLnjw4Kgc9iL7Y/73Dyj92SSu0Ndvg4ZG0qrd0Ep3Jnk6VKJyfrBKEtH/ih2PuTqn3fWzKQg5DCJ8/4CSJuPpFXUQG+e6trmYSvXxhzvCKuM/inzV2/hO8wgE+RYeNzK57IDIZXXVAmFI5DTqQt+eYkqZmQ8HF3XIKtC/HYQDwRUe11FSo/HNMBo39M4GkqWE10BTf5GMhMOYyvlE/NZ7mfu+0HynUHje2atptvbhgwejLAHMnEemfBQX5zpmWARYTtcnjzS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e9Y0MgEcD91oea2l+wYiBa6er1UNAcSNTh8tjtAVmk=;
 b=C1b+4BJJck4iS24SgWdNse0fMgM6lFbhFH/UfaXSG+dFQzR22rVMH3cetFpXnj/hFxqMePrg0tGpM0S5moAsW1YTJDngM9rUhn14DYjKxCFjA7RuTryV0Yaw0mWZttxHZyKgn+r6hHKGdIZW2AaL3KSI15wQBTNmQfs7+ugN8vs1O2n1wdCnVH0ilkGSWYBPMnx/V+vHF5QjZPvQdq4Un8PYFZLoQm00+j97cB9wWAerf3jMOWHuuz4Vdcg+FTAWV3SYsvl9G4kvWAo4QZt78mPtrEIeunHGbhV92iW6SzV3V7rIw827uDhfAgDA8IuLGJ6W8c3MJFRTBoaPqW0OkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e9Y0MgEcD91oea2l+wYiBa6er1UNAcSNTh8tjtAVmk=;
 b=P4oxOz3NCwW3XFl7BG/mfU3bdrzVNlcy9O+x4pEWzk8vLKNb26zIi4U4TtDerGDaQOJg2cEluk7bO9dsBU6dNCdkCAttaNA7uee6ZGsTr5/oNP/Ec9BKzCiaZYeNHUE8hp/lXC+MvbKB4l7C6Oq4L1aSptwGHx4erxkUL2WzwcQ=
Received: from DS7PR03CA0266.namprd03.prod.outlook.com (2603:10b6:5:3b3::31)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 03:21:39 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::7d) by DS7PR03CA0266.outlook.office365.com
 (2603:10b6:5:3b3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 03:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 03:21:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Apr 2025 22:21:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last
 Fence Update and Timeline Management
Date: Thu, 24 Apr 2025 08:51:23 +0530
Message-ID: <20250424032123.3888361-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 12208059-350e-4618-f7ec-08dd82df207c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlN5ZlIreVJDNGFMNEh6dEgvNmhwVkpWeUFBUldUczVpbjdNeGU0bUdXYVZw?=
 =?utf-8?B?bGlFQjhHZmJXa0U4aFg3akhFdDB0QUJWZXA1VW9sa3pXeWVSbCtYS1k4QVV6?=
 =?utf-8?B?bS9yWUFFMytSemVPb2xYNFdnZjJEa09qMVg4WTJUc1FmWXRGWjBwaXdUekI2?=
 =?utf-8?B?UzdzWVlyblIvRzVzbjMxbExUd08wcG9pNEtsdmIyMWpsaER0VVliZUJVWkJu?=
 =?utf-8?B?T0EwSjNPb3RyYm1oRlVjZDkvbnQ3YzgyK2pRbEx4SXkycHp1b05UeUdJckhm?=
 =?utf-8?B?cEJta0JiSW9JMVdqZTdsMG9sbThBck4yVEdRUk85YVpLeGxjd014bDh3eUNv?=
 =?utf-8?B?U3U5VjhldVZIR2NjVEtSZy9zLzR3WWtxaFFIeTZJZmRhQ3hPWlVpZCs5VG1M?=
 =?utf-8?B?ZXBRYXd2YkZLYXhsT3FBb2MrUE9DdXRlRFc3T0NlanhOVEdxVG82OHY2eVg5?=
 =?utf-8?B?N0ZPSlcrV3BnSWdSSjlRVDZJVVE2cjJLWWl5TWg0TnFmYjByYWtSeWYyTkl4?=
 =?utf-8?B?OWdWODJ0MDRTVm5LWU8yNnFjZUhENWFJb1ZQYVhNaFp4SGJNakwxd3NvRUZB?=
 =?utf-8?B?RmhyRjVZZ2wzZGV4M3ZYZ28rV04vV3VaSzBSZWxwcGxsejNSV3ZOODU3Qjhv?=
 =?utf-8?B?RHFFN3lPU1l2Y2pGYmJ6c3VPT0tTVHkwdnZkZzBwTjNjS3JLb3hIL0Q4WS9w?=
 =?utf-8?B?b1MrS053ZFgvdGRxMlFwQkhVQWw1azJYSnFORHhhcHhUTC9ibHk2d2J4S3Vy?=
 =?utf-8?B?bStXTHlEUDdJakhYRFh6dElFSzNjTzd5ZTN6dGd1UGQwaFQ1ZnZRT0w5Qmc4?=
 =?utf-8?B?RGpLUU8yRXpRK2V3OGY0c0NoRXBEMmYybUN2YXpEdWI0L3ovQ1Ryc1F4S0Nt?=
 =?utf-8?B?K0xMSERseVZSU3pWRlE2U1hlU0JpOHRIa3pHN1lqQlVZWElzajBNTC9XSG1x?=
 =?utf-8?B?K1NCaThDQXhIYjVlRVNCeFBrSUJDTmZwWUZKNlcxMkVlZHl2SXJNTUlacnRi?=
 =?utf-8?B?ZU9XZ2tteEFBeDdXUCtOdkQ2YWJjUStUUCtnVEQzSkV6bmZadzVEV1hBME9j?=
 =?utf-8?B?eDhjTXE0M2FjYmxCUmw3REluU0NHVDlBdlYreEx4cFFPMFZ0ZzEyNEUrSGYz?=
 =?utf-8?B?eTJtTkJnNDMrbVE5eDVSYXdkTkhSczFGbVVrZjErZldWaytuV1MvUmw2bzcx?=
 =?utf-8?B?Q0RzUEVuakhEVEtEajZLSTROdjYxMmo5a1h1d1FYYmJoRUU1MldOZVRkbGFy?=
 =?utf-8?B?Q3VGckJGUUxVamhzcTB3ZUlkVWs5YUU4NU8vVUxBVnF1SStFa1lsSy92a1BZ?=
 =?utf-8?B?KzJVdGJMa0o4Y240Z0hkUTdLNzVvZWF1MTVMa1Y3UXJmN2Q0V1dObEJ1ck1i?=
 =?utf-8?B?d0NWQ2h5cm5IdldoaEJiM3JuNW9Ub2wybDBWc0N2WEtuRWVrSXYxODJmS1hn?=
 =?utf-8?B?amZPL00yVjNYSEdNeXcwQjVsWVNlZERiYVBGM0pOSCsvbnA3WWdVeDd0emk2?=
 =?utf-8?B?a0xMWFlJeWpVNWh6RVh2M1hZRWovSm5jenZtOXhDT0R0N2gxUGFMTENTZWl1?=
 =?utf-8?B?cEMrbFlIbFhLWEEvNGpaWTVsTHR4QWZtb1AxK3p0eTd2ei9HT3RmQUhYL2J5?=
 =?utf-8?B?eDBSNUJUV0czeE1kZWtZUnQwenc0ZFMxYUJjVHNSVGlkWjZvelVpWGlJaG5E?=
 =?utf-8?B?bjBjcjlhbmFMWitjTm92SE1Fd3hpS1dXUFBydENXNm90eUkwNFBUeVYxUVE1?=
 =?utf-8?B?Y0ZlNDJ4ZlVEL21hdWcxRmcrMjkrZm5HTWZDNDJoaVVJVjhMcHFMTlRPMEZp?=
 =?utf-8?B?dEQvRTlsTkx2SlUyUWkwUGVTTXdDWDNBNHBHd2dUSjFsblY1T2d0R2l2cm5T?=
 =?utf-8?B?UXJpUWtxdzVOVGhlYVBjTG1oUEtrMlB4bmliYzBKWVRTZWVEak53OXRVTlIz?=
 =?utf-8?B?MS8xa0pPU0FRSXRJKzVCb1VQRUtrQ1NoV2o0Q3ZiTlNXWkdaeVYvRmJKNWdQ?=
 =?utf-8?B?WGhlMHFFTXNJMUFHblJLTStaYmVXSEtPKzVLSHArazEycTEzQ2lzYUwzSlky?=
 =?utf-8?Q?YG7tW4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 03:21:39.0075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12208059-350e-4618-f7ec-08dd82df207c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 96 +++++++++++--------------
 1 file changed, 41 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f03fc3cf4d50..c83947c0269b 100644
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
@@ -751,6 +710,8 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
  * @vm: vm to update
  * @bo_va: bo_va to update
  * @operation: map, unmap or clear
+ * @last_update: a pointer to a pointer where the last update fence will
+ * be stored, reflecting the most recent mapping or update operation.
  *
  * Update the bo_va directly after setting its address. Errors are not
  * vital here, so they are not reported back to userspace.
@@ -762,9 +723,11 @@ static struct dma_fence *
 amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			struct amdgpu_vm *vm,
 			struct amdgpu_bo_va *bo_va,
-			uint32_t operation)
+			u32 operation,
+			struct dma_fence **last_update)
 {
 	struct dma_fence *fence = dma_fence_get_stub();
+	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
 	int r;
 
 	if (!amdgpu_vm_ready(vm))
@@ -774,11 +737,22 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	if (operation == AMDGPU_VA_OP_MAP ||
-	    operation == AMDGPU_VA_OP_REPLACE) {
+	if (operation == AMDGPU_VA_OP_MAP || operation == AMDGPU_VA_OP_REPLACE) {
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			goto error;
+
+		/* Set the last_update fence based on the operation */
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
+			/* Use VM's last update fence */
+			*last_update = vm->last_update;
+		else
+			/* Use buffer object's last update fence */
+			*last_update = bo_va->last_pt_update;
+
+	} else if (operation == AMDGPU_VA_OP_UNMAP || operation == AMDGPU_VA_OP_CLEAR) {
+		/* Assigning the temporary fence for unmap/clear */
+		*last_update = fence;
 	}
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
@@ -839,6 +813,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct drm_syncobj *timeline_syncobj = NULL;
 	struct dma_fence_chain *timeline_chain = NULL;
 	struct dma_fence *fence;
+	struct dma_fence *last_update_fence = NULL;
 	struct drm_exec exec;
 	uint64_t va_flags;
 	uint64_t vm_size;
@@ -934,6 +909,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
+	/* Update timeline node for synchronization */
 	r = amdgpu_gem_update_timeline_node(filp,
 					    args->vm_timeline_syncobj_out,
 					    args->vm_timeline_point,
@@ -942,6 +918,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto error;
 
+	/* Call to update VM and retrieve the resulting fence */
+	fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
+					args->operation, &last_update_fence);
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
@@ -967,19 +947,25 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
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
+			if (last_update_fence) {
+				if (!args->vm_timeline_point) {
+					/* Replace the existing fence if point is not set */
+					drm_syncobj_replace_fence(timeline_syncobj,
+								  last_update_fence);
+				} else {
+					/* Add last_update_fence at a specific point */
+					drm_syncobj_add_point(timeline_syncobj,
+							      timeline_chain,
+							      last_update_fence,
+							      args->vm_timeline_point);
+				}
+			}
+		} else {
 			dma_fence_put(fence);
-
+		}
 	}
 
 error:
-- 
2.34.1

