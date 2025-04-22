Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE68EC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B97910E59C;
	Tue, 22 Apr 2025 13:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oS4Zk2+i";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7C010E59C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDVizjoIu24182lwELRFHszSL2WqbbP84Lq7reJQz5OhD36eJEF0uIZc55qqTnubafOJ7Nta/O9h7P56EWCmSYpmNMuKzw/Yto0rpcbQv72XJ4CgstxGss8rC0zeih6JI6sNUL54f5ohJFYifBTbujFcwOpB4NQ++HKDqNoRnoqhpJ3cYj1XC5B19nNNCgOMBHMMtrSuYlzuvoy9EgY5LRBror7LR9ZnZGp1XFEFLw009n5HzaqeYEh95Cxp7IkORSnoOsLc4zBB3Zu7lfCSlpU2IhbEmXS2qKEca7azoMc0mkK2BIgeDiQfYLt3bXmfe/n1bD5lz1VY3xsyu+GuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ieBj49SZQ+96qjAczVfxPtH3iP14hhXMzIlkkiA69g=;
 b=n6y0wOB5ebFhlELSSIUE93MgQ7j8pyG5GegiCeL4LkXtXT/eTh3EW+Sm1fo8jbaqXbqndpvY+bgwGcy6XPU1zjqenPQCbzDdWgzxHrGeXT+MkU8Fns5CyK4bv055BLAYd+FJUS5t2RHeZAF8wbVFa+QhNS9VKfVpJvtiTW0FDr2dIP7U/j25YU3qpE0jDYT24U25FzT6kq4byGsuuQlYfvu1ff+KziOWUuAXAaa4opi1H2mutH0RCQtH4eLUC9MOYPiHXiBLs/sDJJX685GGDVnPfqGZxxa1NIP9uhSx27SlEdDHCcL1uj8g0VpXyX/uZs4f0J4XC4mzo383SGSRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ieBj49SZQ+96qjAczVfxPtH3iP14hhXMzIlkkiA69g=;
 b=oS4Zk2+i0uPhKO9yANx6781dPuJOGMxCnLIBBSb5ivC0QlKltY6UA77cawt1II8lUKpLuIWX97Bq9KPUy2sntN/tkCE23TT8M2FBOKlxXbVZKPaoJ+KBtQHHrZE7jakUmiq3iXxn18aYeYg+g7IxDqspke8I+/YLBZvFQ/VMtuQ=
Received: from SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) by MW3PR12MB4474.namprd12.prod.outlook.com
 (2603:10b6:303:2e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 13:17:44 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::e8) by SN6PR2101CA0006.outlook.office365.com
 (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.6 via Frontend Transport; Tue,
 22 Apr 2025 13:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 13:17:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Apr 2025 08:17:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] drm/amdgpu: Add NULL check for 'bo_va' in
 update_bo_mapping v2
Date: Tue, 22 Apr 2025 18:47:26 +0530
Message-ID: <20250422131726.3873364-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411150052.3321230-1-srinivasan.shanmugam@amd.com>
References: <20250411150052.3321230-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be54e95-6ce8-4c87-a683-08dd81a010a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEFkTXJ2dGxNa0RJLzBjYzRwa1hDTHpFQ2pNRVNHWU44aXlwR2tMcWtRQ1lJ?=
 =?utf-8?B?QkkvUkVJQ01sOG9NZENtbUgxTkRiODFuaWh6czBodUdla1dFS3M5K0h2SXVr?=
 =?utf-8?B?a3JkeFNhbWJjN3JCMllpVlVJN3c2M3JyWW5rUVkwZjZEd1JFUDM4Sk5sV0Uv?=
 =?utf-8?B?WVhSYytXRUpvanVnWW12TTdpekFDR2JweW1VUklPM21lVEhPMDNSbkFJQWhw?=
 =?utf-8?B?VFRJcHVhZlBLSkxKL2xKTTczRmNFQXhFbGF2NkFOTXhrQmVJS2lPVzJnVjYv?=
 =?utf-8?B?SnMvL1YzTWdDNmxkck5wMVErZlo2TSt2WHN3SmdZSGQrd0dSVjhXaGpmYjc3?=
 =?utf-8?B?cG5KejhERURKS2Q3bDZMSHZ5YzF3a1h2ZERENndnVWFKa0c5cXpNSXZjY3FQ?=
 =?utf-8?B?R05JUnRKVVFJVm9nNExIVFpYZzh1Vmk5T3d5WEFDakZmK1Y2bjdLOW9hajlp?=
 =?utf-8?B?N0RZQ3RFYlEvNGEwSWhldFB1L0tIZ2NsS2JESFBtTkxaMzlxY2VtYU9aT0NP?=
 =?utf-8?B?Y2JvU0k0ajdDR1BZbUJyeGJwTDVVTTZiMUVhK1BzMkpxVTJxL0Q3NkJCYWRC?=
 =?utf-8?B?U3MwUkpqRWRMOE01SXlaMlF3NW05V3MyZURPZHNYS21QL0JjWGJsTXdJdHhI?=
 =?utf-8?B?dHVmSlFuaHJaUFlDRHNxOHNrRHZyVTE3U3V6V0o5MEgxRFVGM1hSd0ZCMlBi?=
 =?utf-8?B?RHpyM3l0VnpuUDZXREhRelorVHZSREZucm11d09Zb3hNODBiM0FHVkNIbk5u?=
 =?utf-8?B?YVB6UHg5bXNIZlBqSHExbHc4Sm1wNS9EUkxnZS9XMG1LMVRBNGYxYWJtdHJw?=
 =?utf-8?B?UVhXblRUaXN4VjJ6MmFFdXRKT1NOVk9iaFFuTFVSOGFHUEJRMFROWHI0WXcz?=
 =?utf-8?B?NGtvdFN6MWd0K0VZQ21XYUpobjE1WG9oQktkZEdvcFk0Ky9uT0VCNktrRVhm?=
 =?utf-8?B?S1ZGRzZUU3F3VS9GM2ZBTWJFTUFNOU1iOUpZV0lWNlN0TmlzOTdoc2tBRjdh?=
 =?utf-8?B?ZkhTMjVYZGNtWUZKT0xoM1BIbGZFbi8wSnBGZXptYmwvdDhNcG45WXNhVUxm?=
 =?utf-8?B?SkNiYUR3TEpsc1FIOG5scGRNN2JDMUFLaWF2WTJFVkI5V1Z0WHlpdTdyYW5B?=
 =?utf-8?B?QXIzemFFR2pRNFJvaDg3NzcwdDVoZC9hSDJPMTFwa3VxMzd6TEw2Z1lpbHBF?=
 =?utf-8?B?Wkw5NEZkeStuRkxsMkE5dzViMTRORkRZZVBLVmlKWlhteGdCNC9ucHR0QlRr?=
 =?utf-8?B?WWhPWFl5aWo2NFA1dlpJVExuUTFja1Jna2FGVDd6RnJxY3ZTK1ZEbnljQ2R3?=
 =?utf-8?B?WWliMjlZRTlMcVlmVXVNb2VjNVFKZUcyRDBzRHozRitYL3NCYnE3Mk9FNG9F?=
 =?utf-8?B?eHhKSFBXcy9KL0RKNTlBbk52dHJXM1RndWJjRTZSMGkvZ2NTWk8zZWoxVlpX?=
 =?utf-8?B?d3NLZ3FDdU1CWHp0anVBR3RQclBLWkNjZitOSlRZdTNkRWRIdFN1bjVqS3dO?=
 =?utf-8?B?UkZDUkdHL0lEcm5tMHh2a1l1YkZ0cEM2MVhlNVBlY1B1Q3NwT1FIR2xzV1NP?=
 =?utf-8?B?ZnhYUlVJYVFxTGJVRWxVNWJlNTh4R3JOUTJxUmNhaGxzVmV4OE9ySWdhVzlu?=
 =?utf-8?B?bDNNZG9jSFpiZnN0bDVUbi8vd2NCTHRIUHNzcnhjTUJmRzk2M21UZEE5SHBR?=
 =?utf-8?B?QUNzdVZsYzBka2FZaVlhYWJLV2daUG90ZWtyRWc2TlNqMGE4cW9MZmVwazlm?=
 =?utf-8?B?M0lGOGp1Ukt6TmpiZWtDWXE4WW0xckdrKzlxSjZyRjFwV0pxTGFnSk02eEsw?=
 =?utf-8?B?RTRqVkhkQkJpSjJ6YWpQWjJ0KzlDVmFnNmdMeW5XOXVGdWNVZjIrRk0zenF5?=
 =?utf-8?B?M1FjQy9CUlhGZUlvNDN0SHRkbmF3ZU45VnlPZXAraXhHRTl0REtyWFh3a0xO?=
 =?utf-8?B?UllyMjFKWVVZVkhoalo3ajJyQ3NucnRGT3BHY3ZuUnRFVHZ4MlhWWE5NSUN2?=
 =?utf-8?B?UGxqRG9PTjRkMDA2TFpVYnpQRUQyWTk1NEttbldCdjZhUUFGUVpZMmswcjEx?=
 =?utf-8?Q?xq5s4R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:17:42.9698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be54e95-6ce8-4c87-a683-08dd81a010a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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

This change adds a check to ensure that 'bo_va' is not null before
dereferencing it. If 'bo_va' is null, the function returns early,
preventing any potential crashes or undefined behavior

Fixes the below:
	drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:139 amdgpu_gem_update_bo_mapping()
	error: we previously assumed 'bo_va' could be null (see line 124)

drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
    115 static void
    116 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
    117                              struct amdgpu_bo_va *bo_va,
    118                              uint32_t operation,
    119                              uint64_t point,
    120                              struct dma_fence *fence,
    121                              struct drm_syncobj *syncobj,
    122                              struct dma_fence_chain *chain)
    123 {
    124         struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
                                  ^^^^^^^^^^ If bo_va is NULL then bo is also NULL

	...
    135         case AMDGPU_VA_OP_REPLACE:
    136                 if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
                            ^^

    137                         last_update = vm->last_update;
    138                 else
--> 139                         last_update = bo_va->last_pt_update;
                                              ^^^^^ This pointer is dereferenced without being checked.

    140                 break;

v2: Refactor `amdgpu_gem_update_bo_mapping()` to move the last update
    fence logic to `amdgpu_gem_va_update_vm()`. (Christian)

Fixes: 16856d135622 ("drm/amdgpu: update userqueue BOs and PDs")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 128 ++++++++++++------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f03fc3cf4d50..32d80acfe65a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -112,6 +112,63 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
 	return 0;
 }
 
+/**
+ * amdgpu_gem_va_update_vm -update the bo_va in its VM
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: vm to update
+ * @bo_va: bo_va to update
+ * @operation: map, unmap or clear
+ * @last_update: a pointer to a pointer where the last update fence will
+ * be stored, reflecting the most recent mapping or update operation.
+ *
+ * Update the bo_va directly after setting its address. Errors are not
+ * vital here, so they are not reported back to userspace.
+ *
+ * Returns resulting fence if freed BO(s) got cleared from the PT.
+ * otherwise stub fence in case of error.
+ */
+static struct dma_fence *
+amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
+			struct amdgpu_vm *vm,
+			struct amdgpu_bo_va *bo_va,
+			u32 operation,
+			struct dma_fence **last_update)
+{
+	struct dma_fence *fence = dma_fence_get_stub();
+	int r;
+
+	if (!amdgpu_vm_ready(vm))
+		return fence;
+
+	r = amdgpu_vm_clear_freed(adev, vm, &fence);
+	if (r)
+		goto error;
+
+	if (operation == AMDGPU_VA_OP_MAP || operation == AMDGPU_VA_OP_REPLACE) {
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		if (r)
+			goto error;
+
+		/* Set the last_update fence based on the operation */
+		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
+			last_update = &vm->last_update; /* Use VM's last update fence */
+		else
+			last_update = &bo_va->last_pt_update; /* Use buffer object's last update fence */
+
+	} else if (operation == AMDGPU_VA_OP_UNMAP || operation == AMDGPU_VA_OP_CLEAR) {
+		*last_update = fence; /* Assigning the temporary fence for unmap/clear */
+	}
+
+	r = amdgpu_vm_update_pdes(adev, vm, false);
+
+error:
+	if (r && r != -ERESTARTSYS)
+		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
+
+	return fence;
+}
+
 static void
 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
 			     struct amdgpu_bo_va *bo_va,
@@ -121,30 +178,17 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
 			     struct drm_syncobj *syncobj,
 			     struct dma_fence_chain *chain)
 {
-	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
-	struct dma_fence *last_update;
+	struct amdgpu_device *adev = drm_to_adev(filp->minor->dev);
+	struct dma_fence *last_update = NULL;
 
 	if (!syncobj)
 		return;
 
 	/* Find the last update fence */
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
+	/* Call to update the BO VA and retrieve the resulting fence */
+	(void)amdgpu_gem_va_update_vm(adev, vm, bo_va, operation, &last_update);
 
 	/* Add fence to timeline */
 	if (!point)
@@ -744,52 +788,6 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
-/**
- * amdgpu_gem_va_update_vm -update the bo_va in its VM
- *
- * @adev: amdgpu_device pointer
- * @vm: vm to update
- * @bo_va: bo_va to update
- * @operation: map, unmap or clear
- *
- * Update the bo_va directly after setting its address. Errors are not
- * vital here, so they are not reported back to userspace.
- *
- * Returns resulting fence if freed BO(s) got cleared from the PT.
- * otherwise stub fence in case of error.
- */
-static struct dma_fence *
-amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
-			struct amdgpu_vm *vm,
-			struct amdgpu_bo_va *bo_va,
-			uint32_t operation)
-{
-	struct dma_fence *fence = dma_fence_get_stub();
-	int r;
-
-	if (!amdgpu_vm_ready(vm))
-		return fence;
-
-	r = amdgpu_vm_clear_freed(adev, vm, &fence);
-	if (r)
-		goto error;
-
-	if (operation == AMDGPU_VA_OP_MAP ||
-	    operation == AMDGPU_VA_OP_REPLACE) {
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
-		if (r)
-			goto error;
-	}
-
-	r = amdgpu_vm_update_pdes(adev, vm, false);
-
-error:
-	if (r && r != -ERESTARTSYS)
-		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
-
-	return fence;
-}
-
 /**
  * amdgpu_gem_va_map_flags - map GEM UAPI flags into hardware flags
  *
@@ -839,6 +837,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct drm_syncobj *timeline_syncobj = NULL;
 	struct dma_fence_chain *timeline_chain = NULL;
 	struct dma_fence *fence;
+	struct dma_fence *last_update_fence = NULL;
 	struct drm_exec exec;
 	uint64_t va_flags;
 	uint64_t vm_size;
@@ -968,8 +967,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
+		/* Call to update VM and retrieve the resulting fence */
 		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
-						args->operation);
+						args->operation, &last_update_fence);
 
 		if (timeline_syncobj)
 			amdgpu_gem_update_bo_mapping(filp, bo_va,
-- 
2.34.1

