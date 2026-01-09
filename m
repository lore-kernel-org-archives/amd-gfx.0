Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691FDD26D75
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 16:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A5810E90B;
	Fri,  9 Jan 2026 16:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rpLblaRM";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B0510E907
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 16:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnqoE/RTyiswFpoR31MvL74kaW65cIbcJKy/qFChJ6dJyiR9RCOSs2mneT2RAxgRhWEU7YU0lUhkbnR9/KdJayIB+Eie9/0LkdRrD6Ch30mvlvIlzgv2efRrRo8RFUKQxgzbLZQnhtyZBFX3nd+gx92XAvS6pqgpRdYu+a0hcbF4pDIc/idPk51H34g/L1dTaMOoGADsyeCa+3dJ7x7p1VSGCLs4UoZZAFzm+bWo9PjCIIsj5Q+mMRvLSI8VSnHNGH4TY0LaugBaRLxeFczGsdhvP8J+g/xnqEloTnBQdPXbz9MUnrHSESkqOU4OP3rmuyY2j1ltraRtZP1CEyh0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0cTYppm60TiYGcKxcKFNWf4FUYge9sc3NUgfPBSRfA=;
 b=JsYbsxiaLa4Z2xfe40CiBoVX8SRjIcy5zKPMEDa9eH23dN0JjfutYfQHIVDuyAdzm3UvfwkwKsjZXVk5HK3Jy2l+nROpOfDZleW9mFxBO6TpxvBAabTzzPFr0qiJ5gBpHQn2bVZ2Hb7nQ0dwwqKDNKeUh2ji84fjanQ2ngw6Bf1eUFzDYSMFiUrvbaKaZeiID7xYxj8B4kj7cfV9pxFbCTxQvN2znyP+Ay8IAykKDPuWdSfxA1RC4d8ITtG0m40Pw2Kje99UR+0rMIl6I4vClzSdp5LxecPO9sEDORr6nEVtJ+5wgRADpK1v7MXe4MsaJQIcdKJQOXFDMY1N7KdZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0cTYppm60TiYGcKxcKFNWf4FUYge9sc3NUgfPBSRfA=;
 b=rpLblaRMlCjwGqqX9xtkIHFYubTwzSqj7rqchYo3TfkSwi7NTSTukKCo1L9fTeaiHPkooyzcbfQTdRkTqQQufOunZgx6DTcwLZvG0FQoZSiWMDAsN6Z3uNL5ei1ZZtN5nhNlFocJZvLR2do4Tt3BKfqQmQJx7bgc/mDBa0cxdcc=
Received: from SJ0PR05CA0209.namprd05.prod.outlook.com (2603:10b6:a03:330::34)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Fri, 9 Jan
 2026 16:40:54 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::6b) by SJ0PR05CA0209.outlook.office365.com
 (2603:10b6:a03:330::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Fri, 9
 Jan 2026 16:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 16:40:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 9 Jan 2026 10:40:51 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last
 Fence Update and Timeline Management v6
Date: Fri, 9 Jan 2026 22:10:37 +0530
Message-ID: <20260109164037.104927-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2a73fb-053d-43f2-6f97-08de4f9ddb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck1lM2FoeG0rSmV1dHM2QmxnN0Z5Z0duZlM5SFFLRTlLa1RCZjJWTi9TUHMw?=
 =?utf-8?B?WW5URUZNVlN2dDZ1RG1BZ0FibGo3WDBYTGNGUkJreUFCY1Q3c1ppdlhjSlh2?=
 =?utf-8?B?UXA2amQ2UG5ITXpURkhzbkhCRXFvZmZ6RW5YR1g5SGpnQ0J1ZTVXUmZaZXYr?=
 =?utf-8?B?eDNaT2pXb1Vod0YvMDBuUTRqdGpOajJLWXVHNklJQkxYOW5TOTlIVDFEOXQ5?=
 =?utf-8?B?ZHVMK1NIYVFhVlpXdEJqdFVrNDkxeTZuV2REYXVQY2EzMTZtZmdmaEtSL29I?=
 =?utf-8?B?aWRZRk9qYnVDOG82Qi9vV0xzRElSbWZzOUptRjB4T0ZRQTFEMnVvZGxMSGNP?=
 =?utf-8?B?VExYanRZQ3RDd3JlUnNIamtib3JGaE85TUNpV0lsSElEYnpoVHBOSGtqd0pa?=
 =?utf-8?B?N25NUS9mYk5LbGpmRnloUnJ4VTM4VFVBcmVJb2JsVTJoTTNNbW84bzlwTHoy?=
 =?utf-8?B?WitpZUI1M25rWVlZL2pOSGVBWHI1NkQyMUpHVnU0VGYvNTRzWUhJL3h6S3Vj?=
 =?utf-8?B?dmFGM2hPS25YQWVxTWlOYmkxQjF6WmZMN2tLd3NOV1YvSmhTZXFPblc2dGNp?=
 =?utf-8?B?TEt1Tk90VGJJY0tCSG43VTZDaDBBTzVxb0JPNDFaYTBsYWFBMTEybmIzck9n?=
 =?utf-8?B?VmVoQnVYVGFiR0E2WmI3UU1KRWNLRktYa0loQWV2cFgwQ3JISWNWaEdpL0d3?=
 =?utf-8?B?TU5qQ3pkSjIydnJQUk1EODhhTEVLOHd5bk81L21ZMnZPRjJRQlA3KzU1V0w5?=
 =?utf-8?B?aUo3Rk1yWk1CejMvdTM3U1VRc1B1Y04rVWVLSEhKaDNOSDBSUE9CVWZPSDMw?=
 =?utf-8?B?YndHcmxLYU01YVN6cW5wN1VjL3NndnpBTnZBRy94KzhMNEh0SE0xWGxVa2py?=
 =?utf-8?B?b0xhRU9RWUE5SzFmUlFLc1ZXVFc2Tm5qaWpGcHNpRTBCdjY3SmRuRW80R1pl?=
 =?utf-8?B?Vk5acUlWR1d4VGJxQ2hCVmtXMHRQSm5xdWM5Qytmb0FjcHVTSTN3TERWOTVN?=
 =?utf-8?B?UG95bHR4RVptQnd0ZzdualJlMjFpaVZRRW1ucHZBQzVoV0VYbzZpV01yYXpX?=
 =?utf-8?B?Y1gwVFIybnRmWmZpdW42QkhQSWllZTk0M2NIYVRhSGJSUzlPOEwrc1BJYmJN?=
 =?utf-8?B?dkVpUGtKRkI4ajl5Q3R5dkdiRXByQmxURUM1cFFybWFFUnN3S21lQWhyTUc1?=
 =?utf-8?B?R3ZzVXZDa1NDQnZUUUNTQXMwR1F4S214MW85VDgyaGFocFFZMGkzT2o4c2dN?=
 =?utf-8?B?bGVmd3dyV3ZacUhGcmJ6Tlp2SXRxNG9Jc09JOEtndnVHdmtpZzJHd2d0VFQz?=
 =?utf-8?B?UjNsLzB1NFhIdzZUTThrd1lCZ3p3WlhJOGJMcDBvSDJnVDVPbEZlWUh1WkR5?=
 =?utf-8?B?WWI2eVp2aG43NmE0OE9NR1BycTMvb1RYam02QTRLY0tjb1pXTGVjK1EzQVZa?=
 =?utf-8?B?WnJJSm5mcDJRejdUN1ZVOGY3VHN1VVFWNjhaS3E5L0xyZkZiU2kzRnVPNEdq?=
 =?utf-8?B?RmkzYndQWHBRbmxwcXAzYld0YzZrbGp5N1ViWlFLYXZmNGJyZytnOHpOZFFp?=
 =?utf-8?B?VTNIaDhUdHZ5dGRIVEdJbWhrb3JPRWtLa3FNc0lpd2d1S0N3emM3UEVoOXBP?=
 =?utf-8?B?TFZSMzZqa1Yxb1U4UXZKL2JOWE9mQkNycklXeGtjeEZDbXJBc1diOHAzQzNu?=
 =?utf-8?B?S0phRm5zbW9JblVlNUxzTW1Zd2ovRG1tUEYwckM3OVZQampyRStValplb2hh?=
 =?utf-8?B?RVB6NUIyTXpRb3BPZFNWMnE5azlXaW1QcHcrR2VsWEVaY0xtODlPSFhmQXhY?=
 =?utf-8?B?NkFleC9xQlZzRTFGdzVVaE8wamFGQVZkTWhnenp6UkRpTm10N09QWHJkREpO?=
 =?utf-8?B?Tm1UOHBUd2doUjIvYUFRelBOM1hEWnlwR3JEMFBGcEFaSDM3UWs1TXVSbFV6?=
 =?utf-8?B?L2RPcDNqQ0FwV3haMDF2RkhCR1BWVG41RWlYVmk3U0lhbFFFNEEyMWVDUy9O?=
 =?utf-8?B?K0xVTXc2Z3BuWE04K0hVU1FlR2hZNXJuaVNGYWhEekgyUTBUVjg1elhOZmty?=
 =?utf-8?B?VFVTakxiaWdORVRTaGplUXpDakdYakJrYm00UFl6WS9yc3lDTE42QjNMUDhK?=
 =?utf-8?Q?enpU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 16:40:53.7431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2a73fb-053d-43f2-6f97-08de4f9ddb2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

v7: Drop the extra bo_va/bo NULL guard since
    amdgpu_vm_is_bo_always_valid() handles NULL BOs correctly (including
    PRT). (Christian)

This makes VM timeline fences correct and prevents crashes caused by
incorrect fence handling.

Fixes: 463b33e780ae ("drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last Fence Update and Timeline Management v4")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 73 +++++++++++++------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e5fb8f5346b6..baa624717345 100644
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
 
@@ -758,35 +766,38 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 		goto error;
 
 	/*
-	 * Decide which fence represents the "last update" for this VM/BO:
+	 * Decide which fence best represents the last update:
+	 *
+	 * MAP/REPLACE:
+	 *   - For always-valid mappings, use vm->last_update.
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
+		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
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
 
@@ -794,17 +805,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
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

