Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7498ED1A616
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 12:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012E610E053;
	Fri,  9 Jan 2026 12:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qKJn2r8l";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5D810E053
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 12:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXK+AO10NZ6OuuFjk3AumD241a0I5GdruS4xiyU2nPit4wLrJG+akL6OJunpLkRfr/zqBmOWYMk8TmcxnFbp/4NI3uW8yut/a89KAF4s1IrCtWXZ0va5+U4YupFZZUiWSQmrZAUFhtOOpuU0F+4XkzLgPgcAvSuiXGtqbsbGUvWPG91OEqkJQPVF3nVMg3lc/++vJESMTcu5mEdElBdTDq1JrbX/OVyYgZapAtRKoRzlfJogZ2G4V048t7mu++eGeNhy+B27KZ21Wzd4nMVmfiKhhy0RCUQWywiJElIkSZKIsAY1RoUnMzKlHj57J4WahzuAGuAZmWck85cuNZoymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yHsOrS7aNJGIdWGbd3WVKmUm3HPXtGQlS5KHN56Xao=;
 b=hti7lP0oftB4k2KMCnDR/EDHSDY3IjsIBd5HJxcgTEHz6Sj44ZC0KOxjaLLzimEUIk72yr1uBsBLJQBUESc+gidJfQR7w+C0mZLXRpx8OM5cFzKoBoa0ogFsLmT/eXcqUpHfJ2xpODT8m9LIPgp1KEugwzUJj8TBob7b6UW8wS7YuW2DM4uvr7Nl0ckpghZfry7Ly1ZQ4x3f7LjSV0Kv7VQDZtN0TmSOKxwQSzCdOUijM6rqHAX2NULtk82hQznKhsx15ba6MAoT7RldPl+ndnievNKbvfj+nAmehPWBtIH9zYdpBPYAi4lHQC7kx38RwvAW5hAZRhj5g5c0curNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yHsOrS7aNJGIdWGbd3WVKmUm3HPXtGQlS5KHN56Xao=;
 b=qKJn2r8leNkhORFCk71C2scHeD1uHVZHTHwC7yJyTZksexbIgLai9aImWFHkIRJrwlLrRoBwOMtDMuxIsg+uCwpHQE5r7Nvfnrt/OFBrvZ1Azs67QVPnNgaBZ+WhoZ/+ZV9hVfLnu2pe6w1iBctqLW12Hdo7S70gxUbUQ4dG2YM=
Received: from SJ0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:33a::10)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 12:34:51 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::a5) by SJ0PR03CA0005.outlook.office365.com
 (2603:10b6:a03:33a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 12:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 12:34:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 9 Jan 2026 06:34:47 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last
 Fence Update and Timeline Management v5
Date: Fri, 9 Jan 2026 18:04:25 +0530
Message-ID: <20260109123425.95712-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f66c95a-1257-4ce3-bcf3-08de4f7b7b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmVLby82TUg5VERvZE5pODkxSlZISVN6aVFLclN5OXRyVHpEaE1nKzJPRnVL?=
 =?utf-8?B?OUY1N2s2V25GWFBuYWhpUFNoWmlsUk05QWk3Z3NacE9vVXpFWS9ZVmcxWDdB?=
 =?utf-8?B?bXhnR0dUWjYvYUpWdXRrZ3k5Z05tcktFV2hQRmFLb25vNTdTTVByNmQrbEdF?=
 =?utf-8?B?MzZENSs0ajczd0tXZ1BKVVNadVExZFFSTnpISlZ3cVV3R2U0STk4U3Zvc3ov?=
 =?utf-8?B?MzRhZHJoMjgyRnl6bWVoRUxMTXlMajQ5bXhRMVhHWi9TaStDV1FGS1JsVm0v?=
 =?utf-8?B?RFU5OEcyOEltLzVST1pScmZPc012TFBMUFU1b1loZFNkTEZ3R2lFRXFsa05L?=
 =?utf-8?B?YkVKdEVXMGtzMFQrT0kzYkVMSU4wRm55VjBGRzNxYTNYOS9EaGJFajAxaVlK?=
 =?utf-8?B?dkJwbDM3WUtPMTI1aGIvZGY0V0YyalVpVmRPRUJHV0t5TEV1K1ZEMXJhOHQ3?=
 =?utf-8?B?cHhnOVpObVpIUmVFTGVMQWpNTTd5SFg4MEN5TTY3UGtkMWJyaG5FTXcrZmZI?=
 =?utf-8?B?bVpLQmEwcjFtSU83b0NPc0hTVmJDZloraTlPWE4wQUJjVy9WNm9nN1ZxUlI1?=
 =?utf-8?B?SytHZzBtaHNkOE1oZ2plTlM1QzMxZnhUR3gyM3V6K1J0dGx1KzUwRm10TkVn?=
 =?utf-8?B?eHBxUEVub3dFdTdQU2F5M1ltTnBuUWxnMnAycFVZT0dOVzdMTnZTUHZqMWsy?=
 =?utf-8?B?cnVyOG1VZ2M3K1JEc3JlR3lYL1hxbTV4UjZGbGx6ZzY2T1NhQ2lpN1BmcFZ5?=
 =?utf-8?B?U1Y5U0laMXdDMUtDSFpPNjFzbzhkVE5sTys1czZDVmY4YzJTenFOYWYzSG1L?=
 =?utf-8?B?eXp5Q3QxUnBHWGZLRkpWTEZkSmhzcitFNnlEeGgrTEpYWXArdkJMam5PcmF6?=
 =?utf-8?B?eHJLd2xURVl5VVBjcUYyWjJOQ2FweEUvTGM3ajBBN1duQitndGlKQUwwd2U4?=
 =?utf-8?B?amNKd3JxcWticTB6d3FJTVoraXVEd0N3R2ZsQytoUUdiQTRBRGxkMEhCdnZN?=
 =?utf-8?B?VDJsaitFaEZ3Uks3WXVmYU1sSFR0b2hJakEvOTJaZS9ncDUwUnBnbkxOUklW?=
 =?utf-8?B?eGQrSk9zbGd4VUpSdFRrMG9TekdjT00zVjAvdWgvZGxXTS9VOGcvNloyTmtj?=
 =?utf-8?B?SlE1QzdrN3RhUjdCYUxFaEtHd214aHRjZnNVdFQxdXZRL2FxcTBURkU1UmMx?=
 =?utf-8?B?QVNJcmcrcWVYWnNvS1RjL015Yy9QVWt2bDA5eXVZRE9JS28wNTFKbFg0NDVO?=
 =?utf-8?B?eDJiZXNpaEljOUJ0UWl6d0JYR040ZkV0Y09Db1N1NC9QeUlDMVI5TGtyNTM3?=
 =?utf-8?B?N0FnbUxIZERSb0ZDdXdhdGo3UXF6bGdKdHRXR3RVclU2R2xDamhsQVVVcDhy?=
 =?utf-8?B?ZXNxR2V2NWtObXdQbXVZWkMxbFA2N3hXc3FlZmI2TWRKdmVMaG0wVGREaXVn?=
 =?utf-8?B?c3krVjVvazRRSEZhQWYwQXFiWVEzVkpua2JKRkhXcDg0bEhoTFhvVWRmZ1Jz?=
 =?utf-8?B?dXpKL3hUMEo3bUpGMnJOL1duMlJRZkdqL2hYKzJDakVuK1J3NGg4Q2RpYWFa?=
 =?utf-8?B?Yk1DODNYOTdtZittTW9hb1k4ZUJ0VUlnM1oySHJxaTVod3RuWVFQY3NVci8w?=
 =?utf-8?B?R1lWd2RSZnF5enNkWWYrdEhOcXBPS3F0YU5CL0c5NFNLY3ZuNy9IQThNM2lC?=
 =?utf-8?B?K3BqeXN3K1dqSTk2RmZjcXJiU1E1dFRGdVYzN3Vyd2N3K0Exb1pnVUpxbjRJ?=
 =?utf-8?B?M2RDMzJmb0Zqem5hTlpVNDhnV3lEd3g4aWMwYkxTaWcwd3Q3Z0hwK0ZkN0NN?=
 =?utf-8?B?WmEvUHg4bXNvRVRBVndRdFpyZGdjV0JFWnFiYWpVMW1EdnlLRzNwMEl0akdX?=
 =?utf-8?B?UGJwMlNLbVVrZGs3OUhvNEU4ZU5FbWFMQkRKVmhpYkcrMHNucGpzMW1tV2JN?=
 =?utf-8?B?QnpoM1k1a0RXZ29QaXI4bjljWXRrWmJrRnExWDhnY0dKT2FXejBJeVpxeXNt?=
 =?utf-8?B?eS9ROXVzMUtkQjRNMWdqM1VYNWM1K0J6eUVWYkhjSEo1Y0xWbTMrVHlJSzM4?=
 =?utf-8?B?SEsrRVNGTzV2bHUwNmw1SGpJMTZHSkVPM2VkSzZUckh6cGJBbmowVXNkQSs0?=
 =?utf-8?Q?cEBk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:34:49.9211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f66c95a-1257-4ce3-bcf3-08de4f7b7b37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
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

Fix this by:
- Always returning a valid fence (using a stub fence if no real work ran).
- Using the VM-level fence for always-valid / PRT mappings.
- Using the per-BO fence for normal MAP and REPLACE operations.
- Using the clear-freed fence for UNMAP and CLEAR operations.
- Making sure fence references are always properly released.

This makes VM timeline fences correct and prevents crashes caused by
incorrect fence handling.

Fixes: 463b33e780ae ("drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last Fence Update and Timeline Management v4")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 84 ++++++++++++++++---------
 1 file changed, 55 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f387e47541fc..2a685db91b7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -730,13 +730,28 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			uint32_t operation)
 {
 	struct dma_fence *clear_fence = dma_fence_get_stub();
-	struct dma_fence *last_update = NULL;
-	int r;
+	struct dma_fence *last_update;
+	int r = 0;
+
+	/*
+	 * Always return a valid fence.
+	 *
+	 * A fence signals completion of VM work. If no real GPU work was needed,
+	 * return a stub fence instead of NULL.
+	 *
+	 * This prevents callers from seeing an invalid or uninitialized fence.
+	 */
+	last_update = dma_fence_get(clear_fence);
 
 	if (!amdgpu_vm_ready(vm))
-		return clear_fence;
+		goto out;
 
-	/* First clear freed BOs and get a fence for that work, if any. */
+	/*
+	 * First clean up any freed GPU mappings.
+	 *
+	 * This may return a real fence if GPU work was scheduled.
+	 * If there is nothing to do, it stays as a stub fence.
+	 */
 	r = amdgpu_vm_clear_freed(adev, vm, &clear_fence);
 	if (r)
 		goto error;
@@ -757,33 +772,42 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	/*
 	 * Decide which fence represents the "last update" for this VM/BO:
 	 *
-	 * - For MAP/REPLACE we want the PT update fence, which is tracked as
-	 *   either vm->last_update (for always-valid BOs) or bo_va->last_pt_update
-	 *   (for per-BO updates).
+	 * UNMAP/CLEAR:
+	 *   The fence returned by amdgpu_vm_clear_freed() covers the page table
+	 *   work for removing mappings.
+	 *
+	 * MAP/REPLACE:
+	 *   - For always-valid / PRT mappings, vm->last_update is the correct
+	 *     fence to export.
+	 *   - Otherwise, bo_va->last_pt_update is the correct per-BO fence.
 	 *
-	 * - For UNMAP/CLEAR we rely on the fence returned by
-	 *   amdgpu_vm_clear_freed(), which already covers the page table work
-	 *   for the removed mappings.
+	 * Note (review): vm->last_update and bo_va->last_pt_update are
+	 * stub-initialized and not expected to be NULL. We avoid redundant
+	 * NULL checks and ensure last_update is never NULL by construction.
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
+		/* MAP/REPLACE should return the page table update fence. */
+		dma_fence_put(last_update);
+
+		/*
+		 * Only treat this as always-valid when bo_va and bo both exist.
+		 * This is required for correct PRT and always-valid mappings.
+		 */
+		if (bo_va && bo_va->base.bo &&
+		    amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
+			last_update = dma_fence_get(vm->last_update);
+		else if (bo_va)
+			last_update = dma_fence_get(bo_va->last_pt_update);
+		else
+			/* Defensive fallback: keep last_update valid. */
+			last_update = dma_fence_get(vm->last_update);
 		break;
 	case AMDGPU_VA_OP_UNMAP:
 	case AMDGPU_VA_OP_CLEAR:
-		if (clear_fence)
-			last_update = dma_fence_get(clear_fence);
-		break;
 	default:
+		/* keep default last_update = clear_fence */
 		break;
 	}
 
@@ -791,17 +815,19 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r && r != -ERESTARTSYS)
 		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
 
+out:
 	/*
-	 * If we managed to pick a more specific last-update fence, prefer it
-	 * over the generic clear_fence and drop the extra reference to the
-	 * latter.
+	 * For UNMAP/CLEAR we return the fence from amdgpu_vm_clear_freed().
+	 * That function may replace the stub fence with a real one, so refresh
+	 * last_update to the final clear_fence before returning.
 	 */
-	if (last_update) {
-		dma_fence_put(clear_fence);
-		return last_update;
+	if (operation != AMDGPU_VA_OP_MAP && operation != AMDGPU_VA_OP_REPLACE) {
+		dma_fence_put(last_update);
+		last_update = dma_fence_get(clear_fence);
 	}
 
-	return clear_fence;
+	dma_fence_put(clear_fence);
+	return last_update;
 }
 
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1

