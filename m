Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A70C5AD4E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 09:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B5710E21F;
	Mon, 10 Aug 2026 09:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ThSR03Hq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E5710E21F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 09:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfmzCF7O33vRIfuu1oB5+lX7QP1gdcsLrxeRAF6umsvdFEBd6VFrEhWx6D+D1sRY5Z+LpAYSlj78RB01O0JJYrV66geHdTmzwU8m+UwVxc7SZrz24S00FtZOzY32WdZWB5t7DXQsgHvPy4+1RduIQBd9c5zIcR9UtKXC+ixADny0awqPIKDXEMx2banNu2MaiFyE20UeC/jvyHBHwzwZFngcIr8ZRZUwDEUZaM+KsKDfjAmtU+/ulrABurL0NB1Ah23HNx/pTmCJ98ZJMFrjqTVsKL4j/PL8cE5e8M427UiXdiJigSmIADKUbMMICjUryPdc4WFwYqBO3PbPkfYKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqeMv7kBBbT7jmbaLAcLpra10Iy9+FqQTCush/+SZRU=;
 b=WI+rAUbhAIcZeSA1rT/BtF8Rfr6a8kqtnpOGgMegE++BVvER3OHKFqr59YntvDWgUd+MD1SDGE+GprxIEzcXErVWMqZTccdPn4HLypo6UH61RudjY2DpgHnX29E0bkm4z4iYl4yOoFRp5xWem6268o3jwSgcjC1WcMYGx0GtcYxAR9RnBWnQ4CXhA/IsBfCzThRlicCFjWMwcEFk2qeUeBzx7EEdpcyKvDsDs+jsSoRA380UfrQ1A48Z3a31a5rrDtHyXGAdvaUPle6jDr9Jp/IoMzhXYbV/YF5Jkdd0zcno7zdGA+FsASLO5Qoraod+YwDyAKIq/UV8IlxJJMPXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqeMv7kBBbT7jmbaLAcLpra10Iy9+FqQTCush/+SZRU=;
 b=ThSR03Hq8DNfs3dnjdjiqYDtq0qgOiKiZKx1TB5jvNHdnDbloBAUKpLvJVpPGyr+HYdnmSjE7fYdvxXidagNVSJRaKPf5Pherc9+8uB9GL/cJYgQag502jZttTQVpnCVXJc2p9mBUHfHB2SxsBhlEXc5wqn7w4UcfThjyPOxDyU=
Received: from SJ0PR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:332::22)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Mon, 10 Aug
 2026 09:18:06 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::53) by SJ0PR05CA0077.outlook.office365.com
 (2603:10b6:a03:332::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Mon,
 10 Aug 2026 09:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 09:18:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 04:18:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 02:18:04 -0700
Received: from dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 10 Aug 2026 04:18:03 -0500
From: Bob Zhou <bobzhou2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Bob Zhou <bobzhou2@amd.com>
Subject: [PATCH] drm/amdgpu: avoid building unused VM update fences
Date: Mon, 10 Aug 2026 17:18:03 +0800
Message-ID: <20260810091803.777940-1-bobzhou2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccacaad-3f3c-48b3-3008-08def6c04939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|56012099006|3023799007|18002099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 0w1sbHmginytcocEi2qLAdO8BNF/CIhk3rCnizobc/n4MLOnJz+YfDzzmAN0od1r+NIXTxE0QcM0MXwEPauSLOImgyg9JrtwPrhxwJA7R1S/sPd/i/97MUGK1UJiAHmJJJ7Agt0EGGKJ6kg/5Q21N+c+5VDEXvfgdkT4Z91BnedvuqcAmAVtyquhW8wAV5zyghpATogtQUmbD7e29FzWKifFtYgFbVCtMBCKf/JEidsW1ffiUXReIWvpTkwWTM0J3Wd6dsPZ5Bxvc1bhcQ+sBjWjUIJTEMBpz3EUH1Fe9/VqKmlQr8NQ0HdkMJEVlSNu1zKFaLe1+dzg56lpHsvAXdAk0Ox1MAB1I+1+tGhXbAiNxdOPgSu/VdeGNltptNEk1guCUKtgkeIylod3vFvF7tJkKdfHBSdcSrEQiFwzu+St2v/y5j702I5Hb4jyHYGqjuVwacQ90qRREbppkwdwkAkr55AE+QeStuuGlD8gfs8kq1OEniHgNyQ96dS+MfyV6+/HGa57Vya9e4+VhT4jr5F2TwEoZU05AYv/0GU76HyqLaWltKErCYYMaj02ByNW9PBieNckG34cazxO0xrMZ6JMsoXr35yfuPn7iruk/AYeoWQOrLHigY0PWk0uXm1ScgqrR2Yds3vpC9NXzfCe6gI0OAon6JhzpSSvM4Pofrcj3NYVHpITxZf5/O8ka/chTS/P32CYubn71pI7ArOotw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(56012099006)(3023799007)(18002099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GrmAqPe4inUyzr9hlkdGmCY8JJvIgu+gVKd9Ei3yuuU2BhWxR/wWNjGRyrIOeDtVVpSkrnbJThzuY7rnYCOi1Hvo//ADZoNUJq1VYR0gBxQpyFcJ+YFoqdTOSMyfN1bDNyRY+btCD2z/+PCTcICY5J8ib/RBZNr9IFgi5gR0L63x7mFpKlI3HrmrPnaUbjHy9UboArBF/AxTAxybCCd0XxHh7bVFS9rZLVhr0ciRFSf72wqwgYQ61W0HRsqvOlgoibRtvrGgnICLiZPzXaAwPGvSxO6xYZcFwkRMJTjDvevCJeQLLHnGu3yw5jgvIYOVh8Z8LwaHbO3BkKayxaBXt8UZ3L4UTtnzLWGjaT5WouVVTggykwtwoYs2ppyijwtIbs+j4bOv2H93jncTn7qQi8TFtEU8OUefMiK3FcVD0e/cRQXWJCOWMcRR5KKzJ0dw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:18:05.5092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccacaad-3f3c-48b3-3008-08def6c04939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

amdgpu_gem_va_update_vm() returns a fence for every immediate VA
update, but the ioctl caller only consumes that fence when userspace
requests a VM timeline syncobj. Without a timeline syncobj, the helper
may take fence references or allocate a merged fence that is
immediately released.

Pass the timeline syncobj into the helper and skip fence construction
when no output fence is requested. Preserve the existing stub,
merged-fence and error behavior for callers that do request a timeline
update.

Signed-off-by: Bob Zhou <bobzhou2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f754a4a3a1c22..2837553e4f58a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -754,6 +754,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
  * @vm: vm to update
  * @bo_va: bo_va to update
  * @operation: map, unmap or clear
+ * @timeline_syncobj: VM timeline syncobj the fence gets attached to, or NULL
  *
  * Update the bo_va directly after setting its address. Errors are not
  * vital here, so they are not reported back to userspace.
@@ -765,15 +766,15 @@ static struct dma_fence *
 amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 			struct amdgpu_vm *vm,
 			struct amdgpu_bo_va *bo_va,
-			uint32_t operation)
+			uint32_t operation,
+			struct drm_syncobj *timeline_syncobj)
 {
 	struct dma_fence *fence;
 	int r = 0;
 
 	/* If the VM is not ready return only a stub. */
 	if (!amdgpu_vm_ready(vm))
-		return dma_fence_get_stub();
-
+		return timeline_syncobj ? dma_fence_get_stub() : NULL;
 
 	/*
 	 * First clean up any freed mappings in the VM.
@@ -799,6 +800,14 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
+	/*
+	 * The VM update work above is already committed. If the caller does
+	 * not need a fence (no VM timeline syncobj was requested) skip building
+	 * the otherwise-unused merged/last-update fence.
+	 */
+	if (!timeline_syncobj)
+		return NULL;
+
 	if ((operation == AMDGPU_VA_OP_MAP ||
 	     operation == AMDGPU_VA_OP_REPLACE) &&
 	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
@@ -826,7 +835,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r && r != -ERESTARTSYS)
 		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
 
-	return dma_fence_get(vm->last_update);
+	return timeline_syncobj ? dma_fence_get(vm->last_update) : NULL;
 }
 
 int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
@@ -996,7 +1005,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		struct dma_fence *fence;
 
 		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
-						args->operation);
+						args->operation,
+						timeline_syncobj);
 		if (timeline_syncobj) {
 			if (!args->vm_timeline_point) {
 				/* Replace the existing fence when no point is given. */
-- 
2.34.1

