Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DB9C3ABA5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 02:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D76410E2C0;
	Wed, 30 Apr 2025 02:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umt9BjYZ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66E410E264
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 02:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMtC5gXsUgztPamOWLQsy1KMABnpigglm1alMv4rYZ8/d6MS9gJ0wyX23sGqn/fckdAiAETha+46NWCmCDklbbnqbgnWVbSPgZUIxbCqTexiE8q4uh8D12uM1ANXAcSCHs00Oaccpor+6hJFb8k8KrWXcSP+XDGaCCUYoQC5OeLeXGY4IfJ0jvEc3cOREKOV0qrsWOu72wX7fYQblwpFVw41z7bQF8YQ35B/mmXBzPKDt4RGh3YLOMwjCWVxc4F95OvAkX2XmmMRABOps0J+QOJsEfZSQuMc6Fv5Zc2xRzuw1lg4Cz8bGJn20oFB6kRfJwzs5dRyoIN4IY3zQg0p0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/asf+PjRC8p37zxJwz7ewwXegxG/e41I8ldWO1DA0Kg=;
 b=ug5d4qoFss7gCKf3cDEa6y0JsOhjcx8bnded0v4atSLroY7x+VvjkWKQur3xnLw+U8xCjfEXicjiG16jDe01o5s3TSQxZraq2fYs2O3y8gyLXS3CtXymAkbmGvhdRd415SAxERPnnMS21YligfRRpmertktQ2QrrQ5EGNUf7+QckzWJ93gn5RYtO4kE5eETjToTP3/Uy6xC6CBLm9EBUNB+PO82PTGg7tORKOEt9e3AQmRO7ZWvQlVQljlQ/2syTgiXCjFxkR8vnR8Rlki/ogSp6rwwtRn5cTyOEtFOqvN6jCuaqRP/qNbZAbuQB3tQIqiS9bFNzjki1xolXfhqldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/asf+PjRC8p37zxJwz7ewwXegxG/e41I8ldWO1DA0Kg=;
 b=umt9BjYZbvGKajjuhAlm+C0hB6TTrTFOGtOG46MNbpTfrf5pNe6H1hl7sSatyHk8JjLiNlBHfO2/VAkMunlYx+HjSCXcfHdUxxMGV9y7yzyWXwk33EQIS9lHaeg3hPxMq7zv/9CV1xuWeauyw5/lAH32GbIBnvy1aA3FaRK5K0g=
Received: from BN0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:408:e8::28)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 02:41:13 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::53) by BN0PR04CA0053.outlook.office365.com
 (2603:10b6:408:e8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 02:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 02:41:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 21:41:09 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 4/5] drm/amdgpu: validate the eviction fence before
 attaching/detaching
Date: Wed, 30 Apr 2025 10:40:53 +0800
Message-ID: <20250430024054.4093239-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430024054.4093239-1-Prike.Liang@amd.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b5cff6-6b99-4c94-5d3c-08dd87907842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?al5pQIeL5TLdL20LFzpJR6zm3Out5Fe9e0HPrG0JfnVYBws+lpCHJficzlwp?=
 =?us-ascii?Q?Bvv5SZ3WYx0W9g7m4YSaYFvT1ymbDnpVz8KEE1oZm7VmvJMtchTi9SPYt8ZW?=
 =?us-ascii?Q?Xr7pVektqzixFDMPtyS/sn1e21klZmK6lQH3j0cYOlm7xHqGPDawMdN9hW/R?=
 =?us-ascii?Q?yO7183YMCCseZnJXeRgFv4V+C+x56nIbc6m2CJGRRjneTwpSFiIEQ4kX2i/O?=
 =?us-ascii?Q?BU/9Yn8OkakEqfb/iaT/xMs6vLxTaMclQk2pfRqkNWbj4IJkyGPGJTqdO4Re?=
 =?us-ascii?Q?EY0XWlEzo6lQpfWAPTOQBrbjGhPhPCQLDj25pl5gAyUX68gnZHV4nuqIh189?=
 =?us-ascii?Q?+dW7HnfBNspMnmOUqExmgVK+y0rTgfvVcdPMXzd4mlKiHh5hdLB2uJaxlKGI?=
 =?us-ascii?Q?E1ZjVwd/lXe9xzxFikY6rTQEqciQzGQOTc0j2kYxKR0njZhPVf5oO+epIHYT?=
 =?us-ascii?Q?aB//4U3VrD4OUbN74xfLVoZoNXiN1r5vfUOVok5hGR5bY/yo+Hc4lbPjEsJu?=
 =?us-ascii?Q?XhyO0VmZzvDJbCP1WEQkc+TjWDHeaQN1mwKDssPxXhHti4e8agBZIDhDO2c8?=
 =?us-ascii?Q?UcIoGl4K8cQzR53KEo2MG1Y9h62swGiQwh/UpQ2U0G2dGDGc1A1hQVnCFltu?=
 =?us-ascii?Q?x/ccWNp/O/G7xwFdwXHT1JyOg0GB7T+jRmjwv0XpGSXJ5YRgSMQUbHEWwzhW?=
 =?us-ascii?Q?/kTBWB3BHAYffEndkB1vLas8E9vYsaHsxZPIaX74a/9Ziq8NZiG8Sp35RSMl?=
 =?us-ascii?Q?5/H3ly/mqnj6xsEOcCyyuabVTQCA5TuQh58UKJJZrD4Y41eqkphc8iN8wFNK?=
 =?us-ascii?Q?Z8SMvRByd6zabPgrX5PmjKrlBXJiGqUbIIK3ZpxR52wZinfNYfB2ECwz7+mw?=
 =?us-ascii?Q?9+jfL0MoC1anQpjOGRqDva66Cirj9fP61JqZr41XkZd1tgbABqlBvcQkAPlE?=
 =?us-ascii?Q?K/dmSqO5pi8lIuGJqhcvZVH9LjcsNZ9W85hcOshFhZi9bk4D5FwNjrR9cvZ4?=
 =?us-ascii?Q?E56gUvzcnDRmsBn4DwXcjpGbmyhkfCaOXGgn6vz8VmIGTnArVG7kTJCrKTvg?=
 =?us-ascii?Q?zAGk803S0YHY9gFKWY2pK8b4jleK6W2JyHPyA+ih/9s6ucgsVYl5O7Wg4+aa?=
 =?us-ascii?Q?EXCNILNOK9IVRpEr7+6W/ixS6sYP7eae+bmk4UHXbrHWdcw+ff7QMRjmbvTu?=
 =?us-ascii?Q?hI3XZwcwTNh50ui2vvJg2yZs4t04KDP7d9y5i+x7zXda+/LeIu+X+kYrIKDy?=
 =?us-ascii?Q?ZSqcUz08HEkVBxzlv6M0s3Cuuxaj009AcDkiL1pg3LZyWq603kdhDhyylskU?=
 =?us-ascii?Q?ljvbp5w/HU58mS/hbFOqt6VLvvCUsHTLA66k6mAr0JXPSGXaPuzVWVtEUZAp?=
 =?us-ascii?Q?MCEsaRpYKmO0RiFHjxz6bRIQc+IXhsxiR+RdjF4IG9jn3h+U9WRIJXfwtDeA?=
 =?us-ascii?Q?PCrRFmG3uTe1WuKIyeOAXAxiq14Zls1GyWosUlrkmBjhFp4LYED7qg72GB17?=
 =?us-ascii?Q?utgWfinjjlAZulIHDfa/Y81wUlo+uQuzmADy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:41:11.8705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b5cff6-6b99-4c94-5d3c-08dd87907842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
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

Before the user queue BOs resume workqueue is scheduled;
there's no valid eviction fence to attach the gem obj.
For this case, it doesn't need to attach/detach the eviction
fence. Also, it needs to unlock the bo first before returning
from the eviction fence attached error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 22 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  3 ++-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 7a5f02ef45a7..242bfb91c4f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -196,16 +196,22 @@ int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	if (!resv)
 		return 0;
 
+	/* Validate the eviction fence first */
+	spin_lock(&evf_mgr->ev_fence_lock);
+	ev_fence = evf_mgr->ev_fence;
+	if (!ev_fence ||
+			dma_fence_is_signaled(&evf_mgr->ev_fence->base)) {
+		spin_unlock(&evf_mgr->ev_fence_lock);
+		return 0;
+	}
+
 	ret = dma_resv_reserve_fences(resv, 1);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Failed to resv fence space\n");
 		return ret;
 	}
 
-	spin_lock(&evf_mgr->ev_fence_lock);
-	ev_fence = evf_mgr->ev_fence;
-	if (ev_fence)
-		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
+	dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
 	spin_unlock(&evf_mgr->ev_fence_lock);
 
 	return 0;
@@ -216,6 +222,14 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 {
 	struct dma_fence *stub = dma_fence_get_stub();
 
+	spin_lock(&evf_mgr->ev_fence_lock);
+	if (!evf_mgr->ev_fence ||
+			dma_fence_is_signaled(&evf_mgr->ev_fence->base)) {
+		spin_unlock(&evf_mgr->ev_fence_lock);
+		return;
+	}
+	spin_unlock(&evf_mgr->ev_fence_lock);
+
 	dma_resv_replace_fences(bo->tbo.base.resv, evf_mgr->ev_fence_ctx,
 				stub, DMA_RESV_USAGE_BOOKKEEP);
 	dma_fence_put(stub);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f03fc3cf4d50..86779dc817b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -294,10 +294,11 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 
-	/* attach gfx eviction fence */
+	/* attach gfx the validated eviction fence */
 	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
 	if (r) {
 		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
+		amdgpu_bo_unreserve(abo);
 		return r;
 	}
 
-- 
2.34.1

