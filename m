Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BE0C5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 07:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5F610E695;
	Mon, 17 Aug 2026 07:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5q5iNPc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E777B10E695
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 07:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eribGmfUnVkN4q2AyMUcuKNho3dPxa3uFQ7UGn+JRAs8uuqpQ0TSHo+7eg7Knl8SBAoC7rBHPUgyD9QyIjJncWub2H3vkhdmevtM9iZx85pxa/I4N/01E+oiT7ux0ZuRtdjSdJ2823RZov9ODCSsQFEuI6/k3j8GhW3M2dmV5X8jPBlRD8YLBaDmSK4XzjUrCvHhjuS253yTtNTI7QJ1Igx1LozrM0vmGLxTxwbAPRaplT+kN20auU3bgTdP9LEoMtDnD0XijjmNAXb9KDiX177yT/XVkBRWgEG9gVw2XKGE9fjq7uqVkZIF5gPe+whrfaXEJ9Jypv+2W4VQymjsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e37QdBGXl3H8ztzM5BSmxNKJSKDoz802OIqO14ydEcw=;
 b=rT+tlQo5vExxnbYH9AcOkwQjMLgiSBdaIWFahepOf+bo1IVyL6K+ABn/0qayr/6ScByhsiu1dt96/MjlWZXX6uoTPbG8rhNbZCvAyBasGaI9kfXBvfuD2XZAZRCXpprUrclDkCVrX9/ecSgpoFBe4RGZwSC1UU9dvjFfAm6h5JgIkFIJMS7L8tpC4Ti/5QCXSj6mxdQZHT/iAND4nnMlUfcCMFCAFvc844tOO5DdrL7Kkd0kq+Z8CKAUEwdXgwedr9vK0w+KdSbhagEjgQoUh89XFG9HpmEkhrhac5PG6w0kdUUnlOPC1BU2k0YVBXKEpFuBlT3XpoEGJToMmuaNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e37QdBGXl3H8ztzM5BSmxNKJSKDoz802OIqO14ydEcw=;
 b=F5q5iNPc9mIGmuwJOxgdAei/QzCRRDuRDQR43zl5Hfy8s49UImwB/rJR1gSf6BlZ3T0z26Q1k5s9KgaDl00tIdXYy9hltojtqP6NYGKsvO7ZAksnwS+WAgC3swBSwAEMa+jz1p/OPrd/4H+1YmOX8r/2NnxBFLClkRfSINOg6VY=
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 07:05:42 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::a8) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 07:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Mon, 17 Aug 2026 07:05:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 02:05:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 02:05:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 17 Aug 2026 02:05:39 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: lock and validate wptr BOs before reading
 their GPU offset on restore
Date: Mon, 17 Aug 2026 15:05:14 +0800
Message-ID: <20260817070538.2490815-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6f2f6f-f28c-4752-7693-08defc2df3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Hx0Ta2TvimXAPfD25to7fVIAHNVEjnh165AxUKgtZT8rzrewjgJE2TY7LaV/EslfDEL+vGrkCEYEa+crq/UPiEHxyv9GNzBuQaIk26KKYl6N3iqzmVwWscbmrIwEDRNpPZUMrSdyEUPqOFbytp5KBab9+GHrtJmwk37aUPbELzedZfq52lavjmbtITCZRmFG3UyhO9TZVKcLrGo6MOgw8ujTa7MqXPBWkfbxodhPKr9CgMN1KPbHd/GZT1yiUx9/gWJJDk6GJovDi4dnyalQxL9Z63qXD3nDukJjfJ2jZzoCyn/5JsW/zV/fmvmycDAWdgiVBnffv9TOLfeM459zRZRFqbFGREBt/KAfjZUcGVQTz5u0K1H9wEgxXNNJiGW6qwYgNTOa31W2UgbDKbZ6AQfVei1CLlmVcEouJE5Xd1Du2sou8EaOYHRiEXOAiqS7AJh+2vIHcvpdozBnhGrTMLhUFAOgxx8R6sOCMOkWyV3j7m3MBPGcWlgfGV41vP99hXrTRmvK3y3EfaWF2Q+638vOPDVHQC02N/byPzRFIqpr7hnTF2DSxRSpO5PEO3bRG+xV+HA/z5fpJ+xNwtS+GbamyUUaQH1Cxx90mfO8wLUl2wj05JI2jqQXC2CnM1NrVls9cC4c8g3cX3OIukJge91k41aULNPZSHtjcHulIT2HfbB0ojIZZT+uosZrj6bLrInsL/QjK+Rwjm7dd8t2Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YbMw3kmVeCC8PaEnE81FUPAx9DnaQpc5X92rWTdB4ubyCiONM/6QSeThVqM7ZOaWkrBzhcNIz+uicEdBwymmB8//vGiFN0vXWhr2onir00hROt1AiRLWEv3bp0HweuQZwg16zInWHvLMKLjBmAvunhEKb1mFYK8z9Ntn0hdK3uWp6sNgVhrHkPUXXCNPFrFPn8NXSLIM1a+0NU8+wZdSc9paKRqzI7WAbMWOgzvBVI5VxFF76O3QawwK2n+yHlH5691DQ5OeILPT5cKpBfjzllvr7CRNQtSg7V1F8whgFI6HMEXegTEc40GjcbdwFDdIM9Lu5YiyaQH7Uusgm6k1OtvTALxX01xpzUBux7L3zgAMH81DXUyk/VufZcZxLxd1b7Kfgw5/pyI/8peErl/WL+5eHGi/q6kcXV0NYzmPik4tHExnxfR0DOL80y/eIh5L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:05:42.7353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6f2f6f-f28c-4752-7693-08defc2df3d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

On resume, amdgpu_userq_vm_validate_and_restore_queue() updates each queue's
wptr GPU address via amdgpu_bo_gpu_offset().

WPTR BOs are VM-mapped, but each BO has its own reservation object and is not
implicitly covered by the VM validation path here. This can leave offset reads
without proper BO locking/placement state and trigger WARN_ONs.
  ------------[ cut here ]------------
  WARNING: amdgpu_object.c:1486 at amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu], CPU#3: kworker/3:1/116
  Workqueue: events amdgpu_userq_restore_worker [amdgpu]
  RIP: 0010:amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu]
  Call Trace:
   <TASK>
   amdgpu_userq_vm_validate_and_restore_queue+0x629/0x960 [amdgpu]
   amdgpu_userq_restore_worker+0xa6/0x180 [amdgpu]
   process_scheduled_works+0xa6/0x460
   worker_thread+0x13c/0x290
   kthread+0xfb/0x140
   ret_from_fork+0x1b6/0x2b0
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: amdgpu_object.c:1485 at amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu], CPU#2: kworker/2:1/127
  Workqueue: events amdgpu_userq_restore_worker [amdgpu]
  RIP: 0010:amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu]

Add each queue's WPTR BO to the drm_exec ww context and validate it to its
allowed placement before the later offset update.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 17cc48d87c4d..ab8fc14a235b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1054,6 +1054,30 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto unlock_all;
+
+		/*
+		 * WPTR BOs are VM-mapped, but each BO has its own reservation
+		 * object. Lock them into this drm_exec ww context so the later
+		 * amdgpu_bo_gpu_offset() reads are done with the BO resv locked.
+		 */
+		xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
+			struct ttm_operation_ctx wptr_ctx = { false, false };
+
+			bo = queue->wptr_obj.obj;
+			if (!bo)
+				continue;
+
+			ret = drm_exec_prepare_obj(&exec, &bo->tbo.base,
+						   TTM_NUM_MOVE_FENCES + 1);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(ret))
+				goto unlock_all;
+
+			amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &wptr_ctx);
+			if (unlikely(ret))
+				goto unlock_all;
+		}
 	}
 
 	if (invalidated) {
-- 
2.49.0

