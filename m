Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06561CA0FE8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 02:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B90710E270;
	Mon,  1 Sep 2025 02:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2jFl7NyP";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C0710E270
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 02:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddwgGMyAgzr+BXRODeyAiXaLhf2bAeo4rm61TX6nWj1aOTTtvLIizwllXBA48F2075kIIjGX9mLjuyuasbaks/0jHnK5rRU8d1eX+fc98qm1oWZNXtZlppIFPjn2UJ/I1kiWuhWKpSvjeplfffnkigt1mXYdHPfotgM8S6HtHR6hdM7+Nm7armKp/M5kicd1OVNJtfCF5+pcYeu3Hx3NSXVEeLjZzfXQLZDgd/wcC+hgCaUzGgBdVAFf/WSpAkIN/yBlBB4Aym0lUnqxd9BN9KZeLOpWc0r2KlBmMkaq2CQsn6VWDMr7c5NS9PqnuAvnEHQT6l/gdTaiEMA8yiiliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzLJLRsv96OIJQnHqQbWILS7dub+PsQBE1ogq8scJTE=;
 b=aSYzHvgRpRwH7y+WSzBpQS3ypj+2qj/PWT6waAPUdpwllyV/eRs0LMVoXrFqE4wtDPyl5P9R/Ktu8a5vKpFjZGldxunV7cdoxKCUlv8TDsXi7GdH6G1kw1AnNBvNi7NKwPAvxRgG9cV22/m7BTuiOeP/wchaOVqdTeoPOOY9yrpey5of8ltLOCMal3HdcOIrRqxaM6UBGF+frK3zMYw22NnfcMVE/66iZdZL9IVBQJGyTjmWW8w6tMbsy4WBtqozkbeYcZfJdzE9I4Ebfr2Sc3fUk/kAYwKFYK0OSPYR6nVZIivv1DNvxON8F6d9wow+nwRyS9/SNgcHK6I329NSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzLJLRsv96OIJQnHqQbWILS7dub+PsQBE1ogq8scJTE=;
 b=2jFl7NyPxyMcsuqVnHAB5ASrFNmt157POWfA4P+oKyJYQgdv50y8wLoMcMoaiF+P+BrvwZX64N6+J2mhsi0kcLVMku2ZmfA11bYFtvD6e5f2RX8EZnkiV+3nF07PQiWfBxxTHYJqHLUC73N3NJbuJyR5pluq+bGRP1pwWpcjN64=
Received: from CH2PR14CA0049.namprd14.prod.outlook.com (2603:10b6:610:56::29)
 by IA1PR12MB9740.namprd12.prod.outlook.com (2603:10b6:208:465::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 02:27:36 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::21) by CH2PR14CA0049.outlook.office365.com
 (2603:10b6:610:56::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 02:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 02:27:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 31 Aug
 2025 21:27:35 -0500
Received: from yifan.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Sun, 31 Aug
 2025 19:27:33 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Mario.Limonciello@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] amd/amdkfd: correct mem limit calculation for small APUs
Date: Mon, 1 Sep 2025 10:27:16 +0800
Message-ID: <20250901022716.283793-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA1PR12MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: cfea086d-b445-4664-704e-08dde8ff1d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NjS44RQDJF3iMCgvu8FPasQyydo8FgkzpkZiBS7bnn8qSWerOp5JR3gRzbvy?=
 =?us-ascii?Q?1OAhQLpwbK3k4MST5aPYdOTtUIYABF3pK+8DlmPfkN/orWYtVU1E298GQdBo?=
 =?us-ascii?Q?46I/SAmnNfxcUqoaebJ6sdIDM9FnQ30PwMc82PilBWrPfZyAF4/wZbOTh8tc?=
 =?us-ascii?Q?+UtIuxkC/JvZ4pBGg+Y4CXSrh3ps5kLKy/FYnFpnWZ5uL8qs7QSoo4r02cp1?=
 =?us-ascii?Q?QrtoLOojaJ7HOvBnz0Y/bgxc4/LqXgQ99Tbz7OtTc0Rcm/4Rr3R3oabDAcG5?=
 =?us-ascii?Q?NVr7ZhNLpkX3hVWPjs7rp9OXHpHwiwZnroFOjqEz4/xGX4nDfkXst3mW6ufu?=
 =?us-ascii?Q?5UESGAAnAPX52TS+7T/cnOW95XjS11r3OzdOoLGLQmcSfJrZAmjRHhPjEPmp?=
 =?us-ascii?Q?CWJL0q7Tnw/5o3ud1oX9DollCrDeiKsOCcCml7wjiCbCWcaCCquAIDEX3Yui?=
 =?us-ascii?Q?xtCViOlsuQMa3FO9HDAyLzmPaWU1fB+Kpe1vRhuQ3W53YdZGSd13s8mli8tn?=
 =?us-ascii?Q?gTzh6URU0GK/O98YwdeGVx2hTpy1DDSmRNQaQZR7T16oLm2MtgGG+HX3jg6q?=
 =?us-ascii?Q?dDrgi7udJyOOdgVGc3MrKrPXkUIyjCIUEsQXZTbv/lDMB7y+14dUNdm9JJUO?=
 =?us-ascii?Q?JrGkHwXvwx3Ucok33oOQvJEdz4VHRy94EuhOi+jKmEPWQDOg/EmjgKz2jXCC?=
 =?us-ascii?Q?smMNELWWwIybC4vg5Na8pGmMjQq29ZzBKwJAa5t6c2CKo6tJb7/UzdLGEA36?=
 =?us-ascii?Q?VIvxjLM1BhatMMAvg113GSdmHe0fn9De5VW28AivFOiAGu8QuzONC8URECCz?=
 =?us-ascii?Q?HyVPjtcSp/Q3XFQuh42kqzHneBKue++2XOahetWfP14ceOHh4aUqCKbsjfIf?=
 =?us-ascii?Q?Ttyw/cGHNtS56eiw+AGkgDAMDLHDz4BaFiOdOQvqpR11qPxnL7C1c0M0l+Q5?=
 =?us-ascii?Q?X8pWpdQEvEeIj+8SrECDHSADNhDMCIzob+pHpkCsUb0em2n3ZeGYprjsDEbp?=
 =?us-ascii?Q?fXyRbTNHbGl0sKp/N0UXWEXC2m2HkzBJvi7zUQvIfR1Db/019SfnWN2YYF49?=
 =?us-ascii?Q?2ag0D2UJEQoTDpoT9PHezaQLoHCt4ObD2rwY/Wpgk6n2Rfa7769IVQsyZCZW?=
 =?us-ascii?Q?QvfocTfs1ayI+NzoVwRjgX8w5rj0mn5x1DQCmtLxe1pJQU9WdSHjwEMjk+Oj?=
 =?us-ascii?Q?80fkA449zQZKV4AFyUmjOh4S1lp0AkUS7NrM0ISpgOFKoh7ukqofazM4YAfu?=
 =?us-ascii?Q?81gOZLbezzuAMBaIOc2AiXVRnxVMdozCN5KWfHBpD0ciK2RjjUdA/WWpAemI?=
 =?us-ascii?Q?x2EPWhqcMtbDI/RCoRYJtUzsJwTccOBv+M/XnfYNcHoQh8dmEc5fWRF9YW3k?=
 =?us-ascii?Q?CcHXEtQLiFmp0wsmUaNvxhZDGkfVJkV2fRXGMhk7esO7yEBk9/uatSXwn9aj?=
 =?us-ascii?Q?fOTh9ueKm7D2dI24cnrEh+nGkqsPsTabNE3z6ZsQnfI/sAvCZG2BGsQ0bN1M?=
 =?us-ascii?Q?0LvLWj2ISXs/FplcRdTFhm7DP3CQwSmvcx54?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 02:27:36.0988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfea086d-b445-4664-704e-08dde8ff1d44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9740
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

Current mem limit check leaks some GTT memory (reserved_for_pt
reserved_for_ras + adev->vram_pin_size) for small APUs.

Since carveout VRAM is tunable on APUs, there are three case
regarding the carveout VRAM size relative to GTT:

1. 0 < carveout < gtt
   apu_prefer_gtt = true, is_app_apu = false

2. carveout > gtt / 2
   apu_prefer_gtt = false, is_app_apu = false

3. 0 = carveout
   apu_prefer_gtt = true, is_app_apu = true

It doesn't make sense to check below limitation in case 1
(default case, small carveout) because the values in the below
expression are mixed with carveout and gtt.

adev->kfd.vram_used[xcp_id] + vram_needed >
    vram_size - reserved_for_pt - reserved_for_ras -
    atomic64_read(&adev->vram_pin_size)

gtt: kfd.vram_used, vram_needed, vram_size
carveout: reserved_for_pt, reserved_for_ras, adev->vram_pin_size

In case 1, vram allocation will go to gtt domain, skip vram check
since ttm_mem_limit check already cover this allocation.

v2: simplify judgement logic (Mario)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 44 ++++++++++++++-----
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d478acb4568a..c3b34a410375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -213,19 +213,35 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 
 	if (kfd_mem_limit.system_mem_used + system_mem_needed >
-	    kfd_mem_limit.max_system_mem_limit)
+	    kfd_mem_limit.max_system_mem_limit) {
 		pr_debug("Set no_system_mem_limit=1 if using shared memory\n");
+		if (!no_system_mem_limit) {
+			ret = -ENOMEM;
+			goto release;
+		}
+	}
 
-	if ((kfd_mem_limit.system_mem_used + system_mem_needed >
-	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
-	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
-	     kfd_mem_limit.max_ttm_mem_limit) ||
-	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
-	     vram_size - reserved_for_pt - reserved_for_ras - atomic64_read(&adev->vram_pin_size))) {
+	if (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
+		kfd_mem_limit.max_ttm_mem_limit) {
 		ret = -ENOMEM;
 		goto release;
 	}
 
+	/*if is_app_apu is false and apu_prefer_gtt is true, it is an APU with
+	 * carve out < gtt. In that case, VRAM allocation will go to gtt domain, skip
+	 * VRAM check since ttm_mem_limit check already cover this allocation
+	 */
+
+	if (adev && xcp_id >= 0 && (!adev->apu_prefer_gtt || adev->gmc.is_app_apu)) {
+		uint64_t vram_available =
+			vram_size - reserved_for_pt - reserved_for_ras -
+			atomic64_read(&adev->vram_pin_size);
+		if (adev->kfd.vram_used[xcp_id] + vram_needed > vram_available) {
+			ret = -ENOMEM;
+			goto release;
+		}
+	}
+
 	/* Update memory accounting by decreasing available system
 	 * memory, TTM memory and GPU memory as computed above
 	 */
@@ -1627,11 +1643,15 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 	uint64_t vram_available, system_mem_available, ttm_mem_available;
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
-	vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
-		- adev->kfd.vram_used_aligned[xcp_id]
-		- atomic64_read(&adev->vram_pin_size)
-		- reserved_for_pt
-		- reserved_for_ras;
+	if (adev->apu_prefer_gtt && !adev->gmc.is_app_apu)
+		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
+			- adev->kfd.vram_used_aligned[xcp_id];
+	else
+		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
+			- adev->kfd.vram_used_aligned[xcp_id]
+			- atomic64_read(&adev->vram_pin_size)
+			- reserved_for_pt
+			- reserved_for_ras;
 
 	if (adev->apu_prefer_gtt) {
 		system_mem_available = no_system_mem_limit ?
-- 
2.43.0

