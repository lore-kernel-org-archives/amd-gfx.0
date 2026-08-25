Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C570C5DF94
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 07:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BDE10E14E;
	Tue, 25 Aug 2026 07:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kvb1wOKf";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88E9710E14E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 07:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6dgwXtEyg2oO+Q+oIC/CCEeGubNz5XpkwHLmDgiUZzcL6o6cRZHgLkPl1OKGgBfwvmI7N072PoAoloImssXIH8DIoQihPVYtVMdvybtDudb+tJdwzrV/wDQmS/D52rM5B892KZfydHX1B2jFHiW9b6ZwHcWdGl1UOd3WJy7k5niK+ojIq9cej6uhMo669wsIwUuhCr31L+VdKO6laJpSugJbuZU8OY1wvCx9vSFsr9Ti2vkKhEY30bZVgvv3oC29tBgzztMjxLXW0aRUmezvzQd3D6VX6wmbEOk1Vmc+T+HDTpgJ7yK2bncL3+i2Q22osWab5H8mtalrGguYg8s0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvdSgT3sbcBsJYlWyCFxmGxI7f/Aix/Vmv/VIXGagh8=;
 b=J+uZoxmqxh40xQa3iHKLMM85lQVdbCfYPXP9f7N5KZpy6cPR1Yir0AQZI6aKX7uZQhrVELd8wq/lNAlH/S03M4tVQC9QuKYCmen2IEXSaus1rn5qmVjxMOHCEmo+kIqfueO9QDJ4XzFItsAavXWrac2Cfm92HaWWj5kGShUNr2kZi0tBBWGMq502lqs9VKt/o1fGiO7kZiv9qqQBzaXWiIRx5YX9C6jI9/b7V79R+RQkF3R1tMaDvWzgei84ynMCtU3xwXcn/w0mO5gdPD5b8Dy8fnaAJMy/t9gMg/y99hU8HQN1RLbKXojSCSWvhGyV1tkCI1OEmxXjlnNVjhX/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvdSgT3sbcBsJYlWyCFxmGxI7f/Aix/Vmv/VIXGagh8=;
 b=Kvb1wOKfkPmio+12QX0gYmP9DrkVYJNb71WmHuIZLulE4Mla1Vvw36bUQHWIho8XDLH8dOoHiX70QcmeziNX1/+s3uL39+s4IysXgx/ltTD7ouTNmpz47zZKzA/+/fn/QSsm71OMEGIXyx008d2OTdcg7cQAh/LyDiu4i0MeTck=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 07:54:17 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::4a) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 07:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 07:54:16 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 02:54:07 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Perry.Yuan@amd.com>, Prerona Ghosh <Prerona.Ghosh@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v5] drm/amdgpu: bind BOs when the eviction fence is attached
Date: Tue, 25 Aug 2026 15:53:46 +0800
Message-ID: <20260825075346.536983-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 566184bb-ecdf-49a7-0e36-08df027e0ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: 466n2SoRDTvl7pMc5ytGosZNFFlp9notQFsrBBxJ+lzcbngyOECYUM+1zYDy5AZKrSa+vOI+a4EvlfgeIsSHH1gK6MEkUsCsa9+ENDjDLsXuajF+PLLZDefzRvA7wTuMQ0i2TPOiLs4H5fmPSjwdMPgORvaEnlBOkcK2lulu270VT/QrVLxVeKp2bx14EFdH7xqjv/GcpL5DupSmOgPc1qYwyhZIfl1UrT+OhxbkBvGNJQTEN4aUkyHnYk8NbsSwJvA5jS0KK/Wo1z4Iz50ePP/JNkAihbqOAF/qZnUfVwoktj/VB/luQuRciejBRtT3V7OS8ir9zJHiUTMF95X8aY/ap9h2BpUMZ0o9r9BOyj9vF31GLZC2SDeXhIfwEHih9qCRSqquvms7BI5d+w25AMYIfoZevcf350PilsbEc+yg9y7xI9tkp3zFN/0DXzLIey4ug5Qlf/DmaDyqA4+aeGeBWHxVMUO5+9Dy1PL4aUQCYjRqbSS9KhG1MWML9Z0+Q3xvkx/ZWikqjInbypE13JUboh1RdgVCrxdHpUXO4s1f2m5tkbUiElSyHlwhN7ehD2MGoIFjlLWlGRL/rXR1lE6y0uJSqljYjikrXULnvHidBlwVggi6e6GLdkTzEUgOFYagcyaNfFQ5X70Wgg6ku76ljKVGb0PWNsRNHl2kZPpwaXdMLkx5dWjfxUKyNP9TgUEB/NlT59D4JGshK/tAwg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dXhPdK68r9brE62dHaKukogBVyeaiL4vN1Ae730rjBRpXXpiglZt7lwLl1msJ89XolVP06yBeeTxcuKLivfgpd81Ik+SbVz6ZDbt2AVuO96FsNMspXZkZ4ynxswEYejrUTU0p9ZEd6RAEM1Qd6uU3dceoq96f5u7tmM+/Cr5zOofONaiJR7rfj3BQKJ5wFI1bGzorY5SGc0KJO2X8+nKeBNwap4OFEF/ec6BJawMqLx5UUqWBWYL9x09oQ8uCe0xclLg+aiKUP8zWXQZknoDuHY3RetnKHCFYyDY58X8bvN0PXe/W+PCoxiW6Hg51o1yx06r9quezXRzKLLeL9SbyT+SyqDltb4q0JibPuvXnkctTrJoQqaRrG6tLLQnmm5sRanJlfXAQ1mgVT54eys+iTVwgQffiQ4F1p7V7lPDiKdSKivobP5B74wcN6TlZ/yy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:54:16.5718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566184bb-ecdf-49a7-0e36-08df027e0ffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
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

From: Prerona Ghosh <Prerona.Ghosh@amd.com>

DMA-buf imports are created in TTM_PL_SYSTEM and land on the VM idle
list, so nothing binds them for a VM using user queues: amdgpu_vm_validate()
and amdgpu_userq_bo_validate() skip idle BOs, and amdgpu_cs never runs.
AMDGPU_GEM_VA then programs PTEs without AMDGPU_PTE_VALID and the first
GPU access faults.

amdgpu_evf_mgr_attach_fence() is the right place to fix this, but it only
validated while the eviction fence was unsignaled. At amdgpu_gem_object_open()
time the fence is still the permanently signaled stub installed by
amdgpu_evf_mgr_init(); a real fence only appears after amdgpu_evf_mgr_rearm().
Natively created BOs hide the bug because amdgpu_bo_create() already
validated them.

Validate imported BOs even when the fence is signaled, and unwind the
bo_va if that fails.

v3: validate inside amdgpu_gem_object_open (Christian)
v4: fix amdgpu_evf_mgr_attach_fence itself instead (Christian)
v5: restrict the extra validation to imports so that resident and pinned
    BOs are not migrated or failed on every GEM open

Signed-off-by: Prerona Ghosh <Prerona.Ghosh@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Assisted-by: Claude:claude-opus-5.0
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  9 ++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 4c5e38dea4c2..c2f9380511a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -101,11 +101,16 @@ int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	struct dma_resv *resv = bo->tbo.base.resv;
 	int ret;
 
-	if (!dma_fence_is_signaled(ev_fence)) {
-
+	/*
+	 * Imports are created in TTM_PL_SYSTEM and this is the only place a VM
+	 * using user queues binds them, so validate those even when the fence
+	 * is already signaled.
+	 */
+	if (!dma_fence_is_signaled(ev_fence) ||
+	    drm_gem_is_imported(&bo->tbo.base)) {
 		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-		if (!ret)
+		if (!ret && !dma_fence_is_signaled(ev_fence))
 			dma_resv_add_fence(resv, ev_fence,
 					   DMA_RESV_USAGE_BOOKKEEP);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f754a4a3a1c2..3118b3036564 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -264,9 +264,16 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	bo_va = amdgpu_vm_bo_find(vm, abo);
 	if (!bo_va) {
 		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
+		if (!bo_va) {
+			r = -ENOMEM;
+			goto out_unlock;
+		}
+
 		r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
-		if (r)
+		if (r) {
+			amdgpu_vm_bo_del(adev, bo_va);
 			goto out_unlock;
+		}
 	} else {
 		++bo_va->ref_count;
 	}
-- 
2.43.0

