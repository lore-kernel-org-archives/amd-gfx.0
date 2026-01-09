Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4967FD1A63C
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 14:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE21E10E338;
	Fri,  9 Jan 2026 14:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l8Skf6Ho";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE22310E338
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 14:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8pdvcDeqVjX3Ml0OM38UFU2qmtKjZ4c/JGozjvsMN2VZDeODhA/dBzMrk86PrtpGBtrKP+YMMRbulYlNjjk/kfCr7P1wIPR99UMoJofyOSkVx7MC3POlTDa9OaWbzQqXbt+cMJbW0S+bAhJ8HmQp2e9qSjOOXPJi0pdBvfse1WLFtCpDS54+sBONBpC4S6oa3ngT545AHAlGFAvKNB7eo5pOZk0rk44IPA58EYWm10S67+lLouq+hYld9pGkwtZMwz0sFExwpLfhMgdWvAoArI21QofoYA71aY08KpwnWLJ+IHqajx20+xE9ULFrjjOvUHK88Exy0wtPc7dTGifGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiXJzFHPUWMo7/foe1K2T1ubfzpUdDG36gn876GDQyU=;
 b=rHsmT1NsOLO0m1FdWmwEibKRRtRvh/JQnsKKUxbofKc7vSUttOaqfd5ftHyBbzi3u7Jv0Yv2h4R1A6tAhr358W3r1bYuUI7DsgKz2OVQS5OqGtjfAz4qYCGrShVq6dByYZEoGoc6gj2LRnmKChqXUGGD490fOYJLXoZmBGSFzQg5HJyLtD5aEHD8/f9c3D+iwVEloxKWaJIlhrcUYdRCfZlNfly2rmIknQJ9NLRqNpIVW/RdE33ssGzpwEJnEufjgtRuECOL13KlEhzbfa5gOtqwzQJGWY+ui+ds3Ul7jEQ3kRTuGOHcLDy7agl7DCs039rW1Xp6JtzGpk7oOE4PCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiXJzFHPUWMo7/foe1K2T1ubfzpUdDG36gn876GDQyU=;
 b=l8Skf6Hor5KCnqVHkXlNYvZ6zVt8S8sTdkgh+jW586XGw0NfCypbF2TbcAtdpG5dgvN+lWKm0K8/0eZ6UR7apK0QootvqzLxqjIdZSMmcH/IP0qCEoeOqcRhJoDNZwU2SvVZ+OEpGLmO8lZAx5tWFdXA5jkhlXx4Utyygd0FBWs=
Received: from BN9PR03CA0922.namprd03.prod.outlook.com (2603:10b6:408:107::27)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.3; Fri, 9 Jan 2026 14:41:59 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::2) by BN9PR03CA0922.outlook.office365.com
 (2603:10b6:408:107::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 14:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 14:41:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 9 Jan 2026 08:41:57 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last
 Fence Update and Timeline Management v6
Date: Fri, 9 Jan 2026 20:11:41 +0530
Message-ID: <20260109144141.103695-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: b527ee37-e5d5-4335-8680-08de4f8d3e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk10RHVyVGVOVXZiOUJIMmROYm02aHl6SHpiM2RCQ2J2MHUzRE9ITGNxWldo?=
 =?utf-8?B?VnhFbkxZRDhWRzB6ZEFCTHJqQlg4WFFmWkx0M3pZMDhtMCtFR0ZGVDBTZVpM?=
 =?utf-8?B?NGM2VGlmKzlSR21oT0dxS29nR2szUHBpM0tEWVMxR2xyWURxNlJ1aklWQkJs?=
 =?utf-8?B?Y2VCekhqZDhTRjkvb1J5VHJJbnpyY3BvekV1WUpXcWp2TzlGeUNSNk5BSUcx?=
 =?utf-8?B?ZmJ1M25Pa09vc09GYVl5R0owTnArYkc0cUM3ODNwUWtXUkJFTytxMStmL1VG?=
 =?utf-8?B?UlFTVGxSY3pYcUlHbktUaDg1bDJZcXlMdElpVXJvcmdZM2swTjJvV1pWcG5x?=
 =?utf-8?B?N0VPT2RiNXRPWUc3Nm12OEE0VitDcEREaW5aQkRmVWZSY1ZrV2doM1VCRXNq?=
 =?utf-8?B?TTMzWEh2NXVVK2VpMlhmZk8vWVZKdyt5d3cybkpOUlIzaHdvM1p3cldoelZQ?=
 =?utf-8?B?TVc1K0dPbERJS0V6K2I5QWtPV09HM29ickV6U3pLdG05Sy8wcTdneHJualp1?=
 =?utf-8?B?N21xbkxEb0ZML0x3aURUNXUveWN2NGtYWXpIMkxUajJFOXFlNnNmSFFDZVVB?=
 =?utf-8?B?bndPVHVLRDh1RmlTZWJ5anN5NGJuT3FXS1U2Z2t4VjJaZDE2aVU2RFlBTFl5?=
 =?utf-8?B?WjJzaUd0M1Z6T2dGaUNuelJXcVNKaUJuMWpqSEtzQnJpQlZOdnc1TjdkdURl?=
 =?utf-8?B?QWRXMVVsc09XeGJEY0krWExaUkxrMzN4UFhYVXFOdGNKdUhZaDJBbzRNTEZW?=
 =?utf-8?B?MkJFMTN0T2FXN05Tazl3RDhSUk1GWERoMVhpcHMzZWVXZVptclpwZHo1TTRp?=
 =?utf-8?B?Si9OeTBiMjhNTnYwSXB5SWNYYkRFY2YrekVIcWhFYzk0MnRwVm5KbENlQUtR?=
 =?utf-8?B?WU5vNVhhVDZ0d0pZd1VlM0lSTEN5Y01QRHJGdC9uT0xFR3V4RG9TanFGdW9x?=
 =?utf-8?B?d3VmZ3ZITUkzNjFiQnpBaVNGRXZTV1NNVjhFeHBkWGx6bUVBVis2c1RWcGJT?=
 =?utf-8?B?WDhDVVI4bDduNEhnQktEVU9RNmxETnZpS0puVjY0b2EwQkFSUjN3Z05oeDJN?=
 =?utf-8?B?ZmJhTUNrRDVURTluL0ZKMzNsd3NrKzRkRzRnbnZpbXRoVHdrbTdOb0kxdTdB?=
 =?utf-8?B?aEFkMjE0OXV5UzcvOTFHaC9seXJrY002WFVrT3Z6V210QVhUaEkvalpWY0h3?=
 =?utf-8?B?am5TUkFoQzdDVnliMzdSd1NFWEViN3loKzV0RVpqT25IbmpNMmx3Sm1TVWJT?=
 =?utf-8?B?cHNhS0dXcnNBa08rVW9iMWFORlUyK3l3aE16TDRNK3JKcUVUNHIyQkdjZVpt?=
 =?utf-8?B?cjU4NE4zQ1ZGTG5NSk8yaWJrVVlJQi9KcXg1bGcweURFNEJjVGo1eVdVMFZM?=
 =?utf-8?B?RThnWHZ5bm14UVo3ek0vc3UzUVVCMEFtMjM0c1VCczZGSEhDSm5zNHhTemQy?=
 =?utf-8?B?SlBSZ1lld1E3azZzNDRzaHNtdiszTVg1VDV1L0NldElJNVRvamdPME1CQmNF?=
 =?utf-8?B?aUpRT1RvdzZ0TDlKeWN3YStTUDVWc2tlRkJoMkQ2dUNhMzArUG8rOGNIR0xk?=
 =?utf-8?B?dkFMNVowVjZnZzFUdHgwTzJyTnMzdVVwcDkrb09BK0swMElqbjBSRXBjemRh?=
 =?utf-8?B?dnBXZEZPM2JGaU5uekFjZ3FxeUhZT24xbGJsT2U0Qzd1bXV4VElLajRieDVL?=
 =?utf-8?B?MllscTlDTkZvSStPOHhPRTZROVIwR3VNT3Y2a1Budlkxei9FWXZRd0J1MndY?=
 =?utf-8?B?ZGJ2R1dMWnlscE5DSHpmenpOZU95d1d6RllVcDE5M0tnYnhzcWc0TjJHVlF5?=
 =?utf-8?B?endzenhHN1FUT1NROE5PbWU0WUF0cnlka1FtVERJVFlLdlY0Zm56dGpQaU1G?=
 =?utf-8?B?d3U1dk5reitteHU3b1BJT2dXUlVjZU9qL0R3YkxvT0N3SjdjYWY0OGFwUkE1?=
 =?utf-8?B?MkhxOUF1M2cxL2JxazRrMkpGT2dmVFFvTFk5Zmx4RVk5dmlPaDlqYkRYbW5Z?=
 =?utf-8?B?WDVjY1J2MitIemt4UkVJdWRRWTFJSWs4a2dtUHBpUUMxNnYyYUszcGh1L2dm?=
 =?utf-8?B?Tmk1UE9rUWVPKzYwZnpueG9zSERsaVMvUGRGN215TUdTeEZETkJueHNwTDhv?=
 =?utf-8?Q?4Im0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:41:58.7549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b527ee37-e5d5-4335-8680-08de4f8d3e55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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

When GPU memory mappings are updated, the driver returns a fence so
userspace knows when the update is finished.

The previous refactor could pick the wrong fence or rely on checks that
are not safe for GPU mappings that stay valid even when memory is
missing. In some cases this could return an invalid fence or cause fence
reference counting problems.

Fix this by (v6, per Christian):
- Starting from the VM’s existing last update fence, so a valid and
  meaningful fence is always returned even when no new work is required.
- Selecting the VM-level fence only for always-valid / PRT mappings using
  the required combined bo_va + bo guard.
- Using the per-BO page table update fence for normal MAP and REPLACE
  operations.
- For UNMAP and CLEAR, returning the fence provided by
  amdgpu_vm_clear_freed(), which may remain unchanged when nothing needs
  clearing.
- Keeping fence reference counting balanced.

This makes VM timeline fences correct and prevents crashes caused by
incorrect fence handling.

Fixes: 463b33e780ae ("drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last Fence Update and Timeline Management v4")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 75 +++++++++++++------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e5fb8f5346b6..c1dc0cae0cfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -732,15 +732,23 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			uint32_t operation)
 {
-	struct dma_fence *clear_fence = dma_fence_get_stub();
-	struct dma_fence *last_update = NULL;
-	int r;
+	struct dma_fence *fence;
+	int r = 0;
+
+	/* Always start from the VM's existing last update fence. */
+	fence = dma_fence_get(vm->last_update);
 
 	if (!amdgpu_vm_ready(vm))
-		return clear_fence;
+		return fence;
 
-	/* First clear freed BOs and get a fence for that work, if any. */
-	r = amdgpu_vm_clear_freed(adev, vm, &clear_fence);
+	/*
+	 * First clean up any freed mappings in the VM.
+	 *
+	 * amdgpu_vm_clear_freed() may replace @fence with a new fence if it
+	 * schedules GPU work. If nothing needs clearing, @fence can remain as
+	 * the original vm->last_update.
+	 */
+	r = amdgpu_vm_clear_freed(adev, vm, &fence);
 	if (r)
 		goto error;
 
@@ -758,35 +766,40 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 		goto error;
 
 	/*
-	 * Decide which fence represents the "last update" for this VM/BO:
+	 * Decide which fence best represents the last update:
+	 *
+	 * MAP/REPLACE:
+	 *   - For always-valid / PRT mappings, export vm->last_update.
+	 *   - Otherwise, export bo_va->last_pt_update.
 	 *
-	 * - For MAP/REPLACE we want the PT update fence, which is tracked as
-	 *   either vm->last_update (for always-valid BOs) or bo_va->last_pt_update
-	 *   (for per-BO updates).
+	 * UNMAP/CLEAR:
+	 *   Keep the fence returned by amdgpu_vm_clear_freed(). If no work was
+	 *   needed, it can remain as vm->last_pt_update.
 	 *
-	 * - For UNMAP/CLEAR we rely on the fence returned by
-	 *   amdgpu_vm_clear_freed(), which already covers the page table work
-	 *   for the removed mappings.
+	 * The VM and BO update fences are always initialized to a valid value.
+	 * vm->last_update and bo_va->last_pt_update always start as valid fences.
+	 * and are never expected to be NULL.
 	 */
 	switch (operation) {
 	case AMDGPU_VA_OP_MAP:
 	case AMDGPU_VA_OP_REPLACE:
-		if (bo_va && bo_va->base.bo) {
-			if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
-				if (vm->last_update)
-					last_update = dma_fence_get(vm->last_update);
-			} else {
-				if (bo_va->last_pt_update)
-					last_update = dma_fence_get(bo_va->last_pt_update);
-			}
-		}
+		/*
+		 * For MAP/REPLACE, return the page table update fence for the
+		 * mapping we just modified. bo_va is expected to be valid here.
+		 */
+		dma_fence_put(fence);
+
+		/* Combined guard required for always-valid / PRT correctness */
+		if (bo_va && bo_va->base.bo &&
+		    amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
+			fence = dma_fence_get(vm->last_update);
+		else
+			fence = dma_fence_get(bo_va->last_pt_update);
 		break;
 	case AMDGPU_VA_OP_UNMAP:
 	case AMDGPU_VA_OP_CLEAR:
-		if (clear_fence)
-			last_update = dma_fence_get(clear_fence);
-		break;
 	default:
+		/* keep @fence as returned by amdgpu_vm_clear_freed() */
 		break;
 	}
 
@@ -794,17 +807,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r && r != -ERESTARTSYS)
 		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
 
-	/*
-	 * If we managed to pick a more specific last-update fence, prefer it
-	 * over the generic clear_fence and drop the extra reference to the
-	 * latter.
-	 */
-	if (last_update) {
-		dma_fence_put(clear_fence);
-		return last_update;
-	}
-
-	return clear_fence;
+	return fence;
 }
 
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1

