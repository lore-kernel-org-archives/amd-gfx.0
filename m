Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3C5CEBF63
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 00:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F1810EBEC;
	Fri, 27 Sep 2024 00:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wcbjWZEJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B0510EBEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 00:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRp5+nPw65WqJpGEr7D8udVBvoJgTU/tuXWlS9e/s8jXJL0ZvhozZnXq/eRYM45PBxevS8iPoxRX3hANJ82SW9KlwvTXDOeYsHgNw9YB+lqpb5xmdDxzGIokLkgn4zBf5PJ7dt3C8dGobr3O38Aqj4978E18tu4V73FfqKhqsLJ4kimYIEIV3oKuwTnk8r1yUXcoMNfFX4e7Th5LifgThI31OLDpoO2mzD3aLt2HWmWG3Ip3Cf++lReyiLTaVWvTOMS6J9kMj3iPDKFP1ulkXNZFzl0ry9jgt+JaOJ2YV3ZY4GcvRjrwocjYxejetcj3So8VqUv3MmT08eI6C2b3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ov5VsIiPrlYnMnOsSYbKUK674lwhl7QK9OyHiPoX58=;
 b=zJTY5mWQG8fchNAS6qfh0r0VaIdtCCkUBLBIeFx1XiD1q5WrNSId2Cg7UikjJOIJCfWrAINg2KrX+/FsWm7ifUGnjZqCI6968XUMsQJysSDVHex/Vfd9wBrDKuFVJdteYE1yL28ljdQlh9r40k2FwyBXJF2mtTmrY+cIXqWfixN9sxpnntnix5L6KNC/miS90SaBqUwKCOOZvLXYdsxTlqwTBbrW9/r1H9pXneD25PKJ6GwpBcIGYfX6sdZiBZdpk5sKmgW05VbX86X83d2rykWOqtK99CmAQz74PG0rUzD0HzsC1jkTNph6/gzsT/4HVkVlUAR6jxmULxwBJBaGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ov5VsIiPrlYnMnOsSYbKUK674lwhl7QK9OyHiPoX58=;
 b=wcbjWZEJjFOl4UzkAUQw7w01aXSpzRxrJLf7MpO5jfz7v5254CoImXM39fnGTQ/Fhb/k1V3ugiMRylzQ2sUtyMXdYSp8RIIg5f9xXQSBHJc8GEleDxrnW2I4Zm5ruzxDijIkYq1UedEaX+783ncS0DDOzsNXJ9jYIAoMhSl4tdg=
Received: from CH0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:610:32::28)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.31; Fri, 27 Sep
 2024 00:35:10 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::2b) by CH0PR07CA0023.outlook.office365.com
 (2603:10b6:610:32::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 00:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 00:35:07 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 19:35:03 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, <Felix.Kuehling@amd.com>,
 <Alexander.Deucher@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: simplify vram alloc logic since 2GB limitation
 removed
Date: Fri, 27 Sep 2024 08:33:40 +0800
Message-ID: <20240927003340.2188824-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 225c230a-689e-4af5-a29d-08dcde8c3ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lO67FoaUsGgvrnRMGZOUWlLOYvzlyXGoOcEapnk6c6qGC3fw9meZi3lbYmS/?=
 =?us-ascii?Q?ffkBA+Px27juxkihrEbxjr60z5VtqzvLvebQdKfK/aJkqzTSp82cJC751K5z?=
 =?us-ascii?Q?L+G4odBiXa/oHuW4y1TzDo43Fk/xYqoMc2Bm5il+z00EohWk80yH94Fru/K0?=
 =?us-ascii?Q?dtwb3D60phtTVfWGn+gaif2qd1+4YmgsVgcGmyPtzmMWwpNAGrN8ezG8S7uQ?=
 =?us-ascii?Q?BC7WdFw2P6q6tORbEDrQ66w+8NkjvqpuMV0xTDVps74ywDj5AudxSYc8J8hc?=
 =?us-ascii?Q?321Lc9aVooJUqKUtCTYP2oB1If1awwcQgXKyab1lmvYk3Yd2W/IVsmez/D5P?=
 =?us-ascii?Q?DgPrZG566TiM6lnDxygSep9QqsQVjP8+Ds2Wbv3xr+zOAwrkYRm/Ug5dr1Wf?=
 =?us-ascii?Q?7lr+g9+H2ih8SNNZFzVY0tB3oHh49b8+FAajUtygK7JxkyB6oT8oZr6iSp8L?=
 =?us-ascii?Q?Xpczz6x+UKDXpLTX6lGcqmefd/KKmk06jdhhH8g21NQtnTLBHP3uIzt2Jjt0?=
 =?us-ascii?Q?osUJ7DL/IvqPNoA3d5VYsJyoLGsaRHzVuO63DZcDaPFybQf0Zr754e4h/FOZ?=
 =?us-ascii?Q?u/d3OMlXvMb2YjYLRh3vyvTJ5DmvW3FfYdxjcRtyBSXRQJ4BosJQFekjub2A?=
 =?us-ascii?Q?qMDK6pC0n9hv2XAuk5ThU0oVF4jo9xGAFEqa+v/nDTWFapeBjiy0N/NJ+YtM?=
 =?us-ascii?Q?UuE1Hd/RwnLR68xA3z2W0mL2J7uD/GmAYB/2dnaXkBKtIketvDYFvIOheMZP?=
 =?us-ascii?Q?Cf/Z8p9hyBICpwJm+Pm3UkDWmGd2JnLO+xPOX0HMFjDmJrykLu1c3HTvrOQ/?=
 =?us-ascii?Q?N7wew52a4gsrnYxS1yyzlE3uajPfKaBEPkGpr0uvsJ+vad45EyyJ/PKnbBlh?=
 =?us-ascii?Q?8GgZtZhbbnM0McgPfFwvBgDLAP3z6ze+SHsJ8pB6NAgrAwDDn3FuTO9WLiAE?=
 =?us-ascii?Q?nghCeDkGXFLqkH8rkkzAC2HR3BF8SZdk7sHPqE4s1h1bCnV8WF/X0tpxMzvc?=
 =?us-ascii?Q?HqkOI7sYIh9fqozMnvKiup8boLVqHWOF/NY2FqzCELWecmxb2VY030HzO1z2?=
 =?us-ascii?Q?HVSt9prTe7o1mcPppPH4rePbCrWtj1jiamAK3J+bwoKldzcVAne5Z5xDP5Ua?=
 =?us-ascii?Q?4SwcIDBgY61u6tuMkAsDTb6W6bHmatOanwnpOoWm5L+ZQ5xJM7D5SOuawaRY?=
 =?us-ascii?Q?P7mfsCI0MV1wc2N/Yhp0mQ/9Gu6Jcoki97XGtQLICTHL6LfHTPEudGSjXz8s?=
 =?us-ascii?Q?F1dEVAnyDwau0Izx3w27Fx0oawKUMVfphjybJXQmjoPiiyA0TPa7pDWTZAfk?=
 =?us-ascii?Q?FgPtHXcIKCFjtlIEm2UanoYr2pMkmubEyZMpTRW8xNaBQdFZm1unUtYPb96u?=
 =?us-ascii?Q?gStjnhUS4JtbA3ZY/eksn4L3358dRIYq+OCJnmtTPSpn7+EeoEqlDRcd8O68?=
 =?us-ascii?Q?RIk+dotHiPYU4Ug/sF554BdQ1FeYbZ6f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 00:35:07.7431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225c230a-689e-4af5-a29d-08dcde8c3ce7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970
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

This is a followup of commit b2dba064c9bd ("drm/amdgpu: Handle
sg size limit for contiguous allocation").

2GB limitation in VRAM allocation is removed in above commit.
The remaing_size calculation was to address the 2GB limitation
in contiguous VRAM allocation, thus no longer needed. Simplify
vram alloc logic.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7d26a962f811..3d129fd61fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -455,7 +455,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 	u64 vis_usage = 0, max_bytes, min_block_size;
 	struct amdgpu_vram_mgr_resource *vres;
-	u64 size, remaining_size, lpfn, fpfn;
+	u64 size, lpfn, fpfn;
 	unsigned int adjust_dcc_size = 0;
 	struct drm_buddy *mm = &mgr->mm;
 	struct drm_buddy_block *block;
@@ -516,25 +516,23 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	    adev->gmc.gmc_funcs->get_dcc_alignment)
 		adjust_dcc_size = amdgpu_gmc_get_dcc_alignment(adev);
 
-	remaining_size = (u64)vres->base.size;
+	size = (u64)vres->base.size;
 	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc_size) {
 		unsigned int dcc_size;
 
 		dcc_size = roundup_pow_of_two(vres->base.size + adjust_dcc_size);
-		remaining_size = (u64)dcc_size;
+		size = (u64)dcc_size;
 
 		vres->flags |= DRM_BUDDY_TRIM_DISABLE;
 	}
 
 	mutex_lock(&mgr->lock);
-	while (remaining_size) {
+	while (true) {
 		if (tbo->page_alignment)
 			min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
 		else
 			min_block_size = mgr->default_page_size;
 
-		size = remaining_size;
-
 		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc_size)
 			min_block_size = size;
 		else if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
@@ -562,10 +560,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 		if (unlikely(r))
 			goto error_free_blocks;
 
-		if (size > remaining_size)
-			remaining_size = 0;
-		else
-			remaining_size -= size;
+		break;
 	}
 	mutex_unlock(&mgr->lock);
 
-- 
2.43.0

