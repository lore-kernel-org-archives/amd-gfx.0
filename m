Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAEED68BE5
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2024 04:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3551410E15A;
	Sat, 16 Nov 2024 04:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rysxms9A";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1C210E15A
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2024 04:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3xNPWvLxe4Y55eTMxBkobici1klGR/Kn/E8pSYHfOPGzWXZYJ89IY3K7IZ4ksnpQO/EA0xhTwFh8U+BC6qP324RYpakJuPBVdy0zJO6H0jK+ip5/DQgNNmos9hVV+5SzHhLSRVFmTep/xSJVgO7Rm84fp34HwP0F8bQWlLs584BcojX75xV6Vw68RqQWcS9sdiPKc6Tu8xoIMIX30oZSPc/HqL87MJ33TY9rvPFgmkXaB5NqcDP6Tf7Ah5o7F/C4DppPEXBJr0281Bq52Ia2VH/SP3kChm9u8GgG+T9BRGMGQxQbEy12N9JhYxpp6UvqYbRd7LSVDDS76VF3n4ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CiVVPdTwg6ep/hqCHv0ooIhUzptDOiq5DTBQlWTroA=;
 b=AbJ+3oIrqvt6k0lNjNKBxERs9TnabHleCDnnDH7hYP2SpLm6Id4pvJZXMOpxWoZ4gD9SfYLKZUG/QS69b5A9UzAQNKuZ4ILFvGp9YezmfNit4oFG0LuSkXR6FtpgljeCfJxcxdr4CwH89tu5hZ/fuepLjGg1R26lJYyaudTrMJcYpUgt9wOTh1EeRb2jV4NXAjukOu2C/SFAlmd7tJRZdCVAFAeCsnItSg+DXjG9rdk0YTiseXteJ1B1u67bx8uoS7qZBswqFRQqaMFDqySJf8jkC8vfQy8eW9Z6DdHMUs/aHObe5SXak1b7+CeYJ1ypogCwQ++v7HMsQ8ASGxCNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CiVVPdTwg6ep/hqCHv0ooIhUzptDOiq5DTBQlWTroA=;
 b=Rysxms9AxruE4bzpY5BCrgtbAtIYgQNvw4/vqpvLuGcyGy62Pc7pv6XDPIsyCEfe5eOu82q94nTUkHYfNOqUpUh2bd3FD3hQ5J4DkuKg6+bTKuGRrkXjH3b8Gz9l4CKBKXXy3fIck3XqRvb9CEPKZnbLmCT+z2Wy7i/WQMyusiE=
Received: from MW4PR03CA0128.namprd03.prod.outlook.com (2603:10b6:303:8c::13)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Sat, 16 Nov
 2024 04:45:15 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::9) by MW4PR03CA0128.outlook.office365.com
 (2603:10b6:303:8c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Sat, 16 Nov 2024 04:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Sat, 16 Nov 2024 04:45:15 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 22:45:12 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v8 4/5] drm/amdgpu: remove unused function parameter
Date: Fri, 15 Nov 2024 23:44:51 -0500
Message-ID: <20241116044452.5925-5-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241116044452.5925-1-Yunxiang.Li@amd.com>
References: <20241116044452.5925-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ac5f42-3582-4ec1-342c-08dd05f976b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGNoTEd1blR0SGFkTHh1YlFpUUc1QVJadzVXblJaRDMxRnJmdDh6cWxvRFdS?=
 =?utf-8?B?WUdkSXhQdEphdUM1QXpkTjQxSnYydXhrL0xNUFVteFlvdnFsd0NaY2NLTGxF?=
 =?utf-8?B?TUNEY3JEakVRR3lMR1Vla2RycnBVQnl2aTkrYmNUb2l3QXJqQlpvV0NDeWlu?=
 =?utf-8?B?YmxzeXovNUN4T3VLdk1lbG5Cd3BUdmhERXhBSFVTUnhzZVc5VDRYWVBLVVpZ?=
 =?utf-8?B?TjhHOFg4KzZlNXFpMCtLZVBxMXBxVUp2RlpWTFllOGlkU01iS2N3RFN4YXUw?=
 =?utf-8?B?OFlPRUFYN3lsUEhacGVhaTlLYjJvZDlUMlFSTUlRNlpKSTQ3UUVUdkdOMTJu?=
 =?utf-8?B?b0xMcndWTVNXbm02Mzc5U3VJblVJTmFONThsdWFZbm41VW9wRStqd1UyMjBS?=
 =?utf-8?B?SUx6OHBoMmhHc0ZuN1Z1UTJzUFZSUURCTmFwQlhrQTNjNmx6QVozb0YzdUd6?=
 =?utf-8?B?ZXpudDFUMEdJTGdRaXZPOWUvMjdQTGpiWldmeXdwbnR4WFV0TjNueEk0cFJy?=
 =?utf-8?B?Z2hkSndvMHFvaGlxMmtQdlZzTzZyajdSTXkzYTVSZWh0cXFpN3NBenNXL3Jn?=
 =?utf-8?B?ZHprWXViMkR0YlQrWFpGME9YSHFzZW1LTjZIWU9jQkpyc1JiLy95cDlLejNG?=
 =?utf-8?B?aHNteVNDdEZxRFdPVFZ0cG80Z0F2YVdMQkNJWTFUWGJTWW1hQWtzdHY5djBQ?=
 =?utf-8?B?RHp5dkhuNDdWWXRJUnVqRXBJem13NW5ZVGZYMGhUQTIzV1BXWVJKbDJ1d0t5?=
 =?utf-8?B?eEVQd0ZWNU5OQXJJbE10bWNPOUJvQ1lzc3N4WEUxWE1jMldJeStsK2VTUTll?=
 =?utf-8?B?QnpkMENSd1JTV3ZxemdxK1VVZmRJMDZUcEVvVlVqYm5aNnhVVTNqYkhiNWhK?=
 =?utf-8?B?MmR4SjlsbWFRMHZUcDZtL1owMkNkTlVTbSt4dXNlOUJkT0F0dnBnU0s2dHJP?=
 =?utf-8?B?c1MrTXBWcnNFVnp0YlhjdjRZNnJrWElVZmVBYkJmVnpmcWZmOVZVd3VENXJI?=
 =?utf-8?B?Zk9RUHZBOU9JWms4dmJ3cElVTjVoMXUyMkdXZnFCOStzRWZqalhUYjVNYWlw?=
 =?utf-8?B?cmhkbDlMWk9pQ2pnS2tETVgvcWJYb0lWbHIvanZXOVVGc0xsWnZUdjFZRkVF?=
 =?utf-8?B?dVhodFBsaHYwSk9pS0Z3bFZVSHBlRml0UFVET2YyN25kajRDVnQyL013R0NB?=
 =?utf-8?B?NmJ5YXliVzM3RlRjVGl0clFSL3ZNam1tUFhRRTJmMFd3SHN6dCtjRnRjQ1By?=
 =?utf-8?B?RDlXOGw4d3MwY1ZSeVJuQmxGWEpBRk15SzdodmNwSGNGVVZIa2FkU2FLckhu?=
 =?utf-8?B?aklZOHU0N2cxd1dUUXh3RHFLT2RMeTkvbWRMOWRWdUhra2ZPRlpGTmI3NUxJ?=
 =?utf-8?B?UEFzL0t5ZjVoL0hzWGUxV09FcHlxc2tWMitCMzd5NkZEVWNrVGs2ZXNMVEVG?=
 =?utf-8?B?Q3JVaWhZcFA1elRUTnFFQnlDOGVSdGhYc2VZV3NQK3RzNW1RaEF3azZoUnlC?=
 =?utf-8?B?dUFSYXYydXZDRVY1Y3Zoc2J3bVZJeE83Z1huWVMyVTlvOFdqczV5M2diVDlG?=
 =?utf-8?B?MDhSSjJhV0NzV0o2c3RFTGxUVEJHRldFUjhQY1pGNFFhVjViY3RyWnlOWWta?=
 =?utf-8?B?My9nNzUrZkh6b3I3bVFVUHRDSG16eTdHOGlTU1NUUHJlYlQyb2ZXaFpjaFJm?=
 =?utf-8?B?QTdDVGYzTk1tNVg4b2NXL2tEN2REYmJUVWRkSXZVenhKRVZzSzVzaVhrb0pp?=
 =?utf-8?B?UktZcG5BZXEvMWNXTzBoVlBsWnBFV28xNW5QeUsyRUh4V3g0TkZNSzZ4VmVH?=
 =?utf-8?B?QnpxWUxZQ0IrU0xOdWJ1cVNNQjZmSEtabVAzNkNVWXZ0T0tmamxLQUYzVlRW?=
 =?utf-8?B?c20xRFdmVVNjQlo0OTBJSGJVbHFXa1lYYUxIa3Q3am5hRWc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 04:45:15.1342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ac5f42-3582-4ec1-342c-08dd05f976b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
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

amdgpu_vm_bo_invalidate doesn't use the adev parameter and not all
callers have a reference to adev handy, so remove it for cleanliness.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 3 +--
 6 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d891ab779ca7f..471f3dc81e8db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1105,7 +1105,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	 * We can't use gang submit on with reserved VMIDs when the VM changes
 	 * can't be invalidated by more than one engine at the same time.
 	 */
-	if (p->gang_size > 1 && !p->adev->vm_manager.concurrent_flush) {
+	if (p->gang_size > 1 && !adev->vm_manager.concurrent_flush) {
 		for (i = 0; i < p->gang_size; ++i) {
 			struct drm_sched_entity *entity = p->entities[i];
 			struct drm_gpu_scheduler *sched = entity->rq->sched;
@@ -1189,7 +1189,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			if (!bo)
 				continue;
 
-			amdgpu_vm_bo_invalidate(adev, bo, false);
+			amdgpu_vm_bo_invalidate(bo, false);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 8e81a83d37d84..b144404902255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -345,7 +345,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	/* FIXME: This should be after the "if", but needs a fix to make sure
 	 * DMABuf imports are initialized in the right VM list.
 	 */
-	amdgpu_vm_bo_invalidate(adev, bo, false);
+	amdgpu_vm_bo_invalidate(bo, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d1bcf7194a25e..1012905c1d417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -976,7 +976,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -1036,7 +1035,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
 
 		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
-			amdgpu_vm_bo_invalidate(adev, robj, true);
+			amdgpu_vm_bo_invalidate(robj, true);
 
 		amdgpu_bo_unreserve(robj);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6852d50caa89a..a9aaf8f7cb4f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1150,7 +1150,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   bool evict,
 			   struct ttm_resource *new_mem)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_resource *old_mem = bo->resource;
 	struct amdgpu_bo *abo;
 
@@ -1158,7 +1157,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(adev, abo, evict);
+	amdgpu_vm_bo_invalidate(abo, evict);
 
 	amdgpu_bo_kunmap(abo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 68dd4130b5ad9..d0db155a9ab7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2143,14 +2143,12 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 /**
  * amdgpu_vm_bo_invalidate - mark the bo as invalid
  *
- * @adev: amdgpu_device pointer
  * @bo: amdgpu buffer object
  * @evicted: is the BO evicted
  *
  * Mark @bo as invalid.
  */
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted)
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 {
 	struct amdgpu_vm_bo_base *bo_base;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 5d119ac26c4fe..6a1b344e15e1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -524,8 +524,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
-- 
2.34.1

