Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B4FC982D6
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 15:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0516410E72F;
	Thu, 17 Sep 2026 15:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vA175b4a";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B57710E71E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 15:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQUQtVFPcgsirnOMhIidi5ncPjJ1fRXrGQYmsFbao5DBQri3x9Py7nex5wB2IgDMtYcnBdfSnQuif7Mq2/A5QcEJgu5tbs5deaEOb7oFmdrkhbw+bRwz6zfAn3K/nnvPZIL/9Z96fEAiEVp9koSe91nBgMZVnsfsS9ChSHWoMGyL4KkgT9kOipkjEmaO/QFh84CyA1/dFpquD/VAonLtdMpziiFNMk1Ydblmc5rTs90wg+ec6MuKyLFgNL6Pv9BXnDYCZV5izoO3r8Cfmn+1QfctV3cvd68lBrrrAIWdMbnQV41HTtxfZNSQ1cTAjrjVbT4qUAvEqAx/zl9Dkl0Ysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onxKUC4dUa55ECJ0V/l41zdbCV3safLb0pk2ap6lRis=;
 b=un46BKG5CVM8g7J+nrqIFR9BsUSj0Gi7e7PYcAzmwfZ9ho5Unvhfk5+ZGZR+0MkezIaolX9eNOlAPTF2jv6wVhcshwYv71XAAJxRXLcaAMc92RbpIgbd2BM/bMByDwvQ6dJEo8jy2nvWVncaAnfrLCkA0Pil5tlLq64mJXOMvjUliTeZMrtNM3veAmduCMVkYUD7cL88DnmZaOqOnJgcJzpv/25guEeLZAfquGR2+/M6l0AOcmuEZjBlWFW98skvLNSyxiRGySr5G/6QOZ8pzgqHwnjWN/UV0iTYgQG/8GerTZgiYaI8VJUYdI4GJzHrejYKQM/LtiD41YNGGhob3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onxKUC4dUa55ECJ0V/l41zdbCV3safLb0pk2ap6lRis=;
 b=vA175b4amRqGPqCaBRk/S0PdAK+wXPkxPCWx8D698r5j0nU09jiv7PdmPwfhIpHIqo/p4ykvIKUYpJgrcgiOtMffSJa08HFVVfyKkpeeldoxvVEelT/7k99d+KCjyhPgahQbVNUa8PMX0d/chHjgGgJYEMqauRXmrnipw5zRayY=
Received: from BY3PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:39b::19)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Thu, 17 Sep
 2026 15:34:17 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::7d) by BY3PR05CA0044.outlook.office365.com
 (2603:10b6:a03:39b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 15:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 15:34:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 10:34:11 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 10:34:10 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Reserve eviction fence slot during userq rearm
Date: Thu, 17 Sep 2026 11:32:06 -0400
Message-ID: <20260917153404.17610-4-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917153404.17610-1-vitaly.prosyak@amd.com>
References: <20260917153404.17610-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5bf33f-361c-4577-add1-08df14d12293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7ARnryTwooAcjInxn7YDQWSGvSxNrZzzu+gbqzQpiEZWcGS+45YhUkq5Ubotttgok9DB7851ScJLU9QzUxxrPl6nvGkYCDieIuh7/6AxKSjWovy1yfBUkWEfxGk/xZaBHvIPd1Hyg0/25skEwMF7UMSRQapKdqlD9kd9B6NlndcsAHE3Kn59J2/SQOXw5srTIYuek253Azf32xF3ClUinhklJM3AFxiNmNyJBipxybTJsc+N/b/SzxqBuS2uT3AxoXFplULY3mEk/N16y3p3IIcuNJcdwlRM77UaMQUXHH6zgkFX30GvT6jhCM819cMv1LijewibEFlADarEKn3NVYOEx+36b3DPrCPVDpu/66xrXxDPux4SWKpl+vOMroi0d+VsUQnbwADAcPY2z933vToKINmFOFRBMp/9d82CGBfjcPj3ZTDVxv+7mTFzZlsZAH4D0zLyWdylPBSt+xsjnbTSw00ybwmPs2VSRPhkBeqahgwKrxJOarxwFGQeCbVV2FPa5rWrIV+LHF3gokbGm+E8ViatZi8JZAU2gmKXMx6sTOp1Y9qMdj/rXKyFUooVcR6uHfvD18Rs8W9uwZKjQAseBIpt6PtHBWWQcTbPYcLWspSpzsPayLQMoinWuVQxHD5m543KLl9OGXN7WPsy2GZcn6CEG7bGL1sRsJ0N83CCl5/IRU9vk+sreSDeiFe3GXCJ6MkDgj3x2DAoJVdXbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uJQfGtHI+mHROZPSD8dO+3A8P0/EVd4xoumrRFvfF2lCXiMR3wuivhW1AcEOELpCjPXa9uPXM1lcvZgeDBLWEm5+AU1PI5OT8M/+Vm7V8cS1o9MxPDhpBUfTCV7+eCVEmwvaSCcwWTMTN8V1bpA9JkK7HssDmi7iG8aE1Iy4MwF2DdxBqnlIaly+q/wFn7qkEWvquurFiFz1zXJzYGupcNls1JP63qpcejU+kOO1zkKPPz3h1j5EHpJfgEHNu/OPTeJVM5zax5TFgp+GNEZ0FRPNBsah3h9O/fzagC0Czgo1LXfPOEX0bgIYAnAD5s43i+kbnuQ9PDt0HV/yhCi2uCAXD5iXOCDFhR8rMTqtPTcxjG+YpyM8/FENzXTSBP5A+Ee8dszKEeUBi/KFHneAEt7dAqE8p6QU5zCocukIYJyOwuS0FxKIyFnS2wkjAJTk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:34:16.9355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5bf33f-361c-4577-add1-08df14d12293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

A user queue restore can rearm an eviction fence after the BO reservation has been unlocked.
Since dma_resv_unlock() discards unused pre-reserved capacity, a BO with no remaining fences
can reach rearm with max_fences equal to zero. Reserve one fence slot immediately before
attaching the replacement BOOKKEEP eviction fence. The BO is already held by the drm_exec
context at this point, so the reservation remains valid for dma_resv_add_fence(). Keep the
reservation in the rearm path rather than hiding it in amdgpu_evf_mgr_attach_fence(), so
the caller-side accounting remains explicit.
This fixes the dma-resv BUG_ON at dma-resv.c:319 and the resulting crash in
amdgpu_userq_restore_worker. The earlier root-PD and WPTR-caller reservations are reverted
by the preceding commits because they do not cover this reservation lifetime. Validated with
repeated amd_deadlock runs, including the userqueue restore reproducer.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: Id156389c1b2193fc3e1354acd5194f756faf39c9
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index a0802012de49..6c1f994ea78b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -125,6 +125,7 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	struct amdgpu_eviction_fence *ev_fence;
 	struct drm_gem_object *obj;
 	unsigned long index;
+	int ret;
 
 	/* Create and initialize a new eviction fence */
 	ev_fence = kzalloc_obj(*ev_fence);
@@ -146,6 +147,13 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	drm_exec_for_each_locked_object(exec, index, obj) {
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
+		ret = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
+		if (ret) {
+                    pr_err("userq evf rearm attach failed index=%lu bo=%p ret=%d\n",
+                           index, bo, ret);
+                    return ret;
+                }
+
 		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
 	}
 	return 0;
-- 
2.55.0

