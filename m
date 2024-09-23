Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5982ECF9C5B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 08:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF4C10E37E;
	Mon, 23 Sep 2024 08:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hs5QoLYu";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6CC10E37E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 08:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWKZkC33DrrEfzc+leJZCfHD5pK1hYpYgVZ+5ApFoj/3WsvUBa1ZuxGQUuHMZWQXGHzIuL40lpAiTz7hEylIqsdM8ggFNNtf4SMj1t7wbfVWnuZqQiTRXLmNDUbl2F8EZI3FVhzIM1ntlaZ+s4E7dXYozBGg2GtwkhjhCOSbrZW8hmm3mLgtsrIoR2NGWQWokYD/17zWpPEoylmeal70iT0sDvOG2DXGmBPu6JYWwR86EOrpA/gVDf/36EqUVYzJs0Zag+BdygneTiwIIHoyjoefATGHkPetZ8LaXGi6y0+xwxZ7CgjwIdA+zi3IoS7E+hr0nrIxAvrWEiDhCFyTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Sxon0OQRWo2TRKk0EYCgGlViotegaEMgj2WvaBITJo=;
 b=T/iUzdXJMF78zWSVWgvtH7iFshgMe7BBoHNUQnmIWkicPUl5YQxF+1v+h5JEapy9TWmPr8Qy0TMeE5+6hnGV4Nkied1v67xXYzO0XwlaaeOE2nh74n7Y4uo7dF7R7KJd8XJh1NApFIBxFvtMehoVXpRSrs3nQPjeamBPAcR9iQn8QFYvjlIP/N1wZWEpjQZrC5ii72e0+JOzm5z9LRDPez36FV94KYISIQGPN+xF2Qu0eSEFcINnuTQuYGx9a60eYjlZkMV6wBEuxOYn7OCJ8TqgVfxQPsTW9GYhxvCy/UsDsHJC6GrhL8+5mfLHmU0Us6ncMuXMdmCfOP4bP/oGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Sxon0OQRWo2TRKk0EYCgGlViotegaEMgj2WvaBITJo=;
 b=Hs5QoLYucMjv393DcfeAkQkUrZqPUDkY/Cl/SJrw67LIKxsQuih/Y0pZFfiBcSc/LvKik6WpEaa3HS8Vc5g33Q3vVl9FfhfheBFfixO4V5Ob004a3FbS/Ab8zaS0bur8W+iKDIgWe9T2cemE4BMifdVMUnKs4nzdFZwaHyvQcFY=
Received: from PH7P220CA0154.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::35)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:19:58 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::be) by PH7P220CA0154.outlook.office365.com
 (2603:10b6:510:33b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Mon, 23 Sep 2024 08:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 08:19:57 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 03:19:56 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, <Felix.Kuehling@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB limitation
 removed
Date: Mon, 23 Sep 2024 16:19:31 +0800
Message-ID: <20240923081931.2126969-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 00563b15-33a6-4631-45d2-08dcdba88310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tTL0+nl1qLMFSvN+e1ww9Q59k4ni+64YueZn/Wj+DhQq2umw7TkK5W9gTTq3?=
 =?us-ascii?Q?j+dq6brraaIUcy0WHHFFyawY74gx1qghhHSvCa+u6oLfx6CW2oKUniG9pOrm?=
 =?us-ascii?Q?x8tFfhVoPYPQedi0st983k+lS27kBfULB6kmkv58vn5V9Nt1ee19+c6OBRU3?=
 =?us-ascii?Q?pWQEe0lLrC3Vg4455wN9U9KNErFpnfWEziySpaRw7mdxPCYNMXWTVRa7NowK?=
 =?us-ascii?Q?X7PxBOszhWkvBlemPtJZnTs+TuNvhBZ8fZVERE55V5908rxhG9AVzKCS566C?=
 =?us-ascii?Q?kPBSeD0/gNGuvMZOYn9Bu2/o6eszXMxvKkoIdK21b2zJmf6qO4IuUk8/Xy8L?=
 =?us-ascii?Q?srB4/60NrLXsMPijhNy7INhBOLueh5oTuLVTbL5pJxZUaX8TW5GJ4+vIRTns?=
 =?us-ascii?Q?noI/mmlzaWZzYAbDN7G3l7+MM37DN2XhZVqOO0SAwo4LcA2oSDCYJ7ZeBAfP?=
 =?us-ascii?Q?JXbKC0fFdzg6SD7QwpvsAkcb04+//ZzILQGKLcOxU2c9bJvq2jnEp0e7lCgW?=
 =?us-ascii?Q?kMp/srcgZ0Z7ulRiveKFq3+IZ0jebE6AlNhtfi0S39aDdACH8QryTRwj6hd7?=
 =?us-ascii?Q?UchR5tB5mZWQvjJt2hpWiwo2/KTO5HUvWojRpwqAvwgR5VzfF+G0U6WL8y36?=
 =?us-ascii?Q?pwTFjfJk99Sta6Lif/cYChHTStEsgwa9i7s8pxQuci8hmO38btBWFlkAjDT2?=
 =?us-ascii?Q?m9JR9o3mqy4F/LZjxXofnAGZCAoX4El1kvXj//uv/ruLLjqHOCjLJwgVBUS+?=
 =?us-ascii?Q?bccBVRt43FG6CD1j6KdzfzwNw9+Yv3aphjl5sIeVoWHzDlFKuoobrEegtrxc?=
 =?us-ascii?Q?nVlszQ8MVOxEOVYVwcD6+cRlD/aHf/fxEcFDm3UHR3gbC6dt7OLUHdN9iKDi?=
 =?us-ascii?Q?SwTg1OUgd+vQnxiJMZyCxl0/2QqAH0shrU2tr1XkACTYMl8XV2vMDrFzhjLU?=
 =?us-ascii?Q?I7hCS07RbxrCRCpiUTeAuom+fhAKZVq5z2MUcDMwWpshZPzWMsliNIPQhGhR?=
 =?us-ascii?Q?QS9P3Iit+hd7agFHWBLEr+0B7Se/+jM1P/N4JusiFz94KF4cU07ilfIO3fHJ?=
 =?us-ascii?Q?K6H47S/dodwvrz9xGTnd015Bmj0y1PaVqvIu+jvF4xU5frsNbXqIlYsYJFcs?=
 =?us-ascii?Q?vverPgDLgtBY7CzKf+9l+GNPi1KfZXxJ3HYocIjBUS1P9gEl/yM1p9f4wNUf?=
 =?us-ascii?Q?B8dzjHa8ArCcC6oM1pc7qLhQm/InwBOLt/998mH2Ga//wAgGCI1iRNVyyx/q?=
 =?us-ascii?Q?4xxxulnAOQyFIeM/w1sYztYF/3dY44R/3mU/bC9lcKieQ39XVAR/cX9+zD92?=
 =?us-ascii?Q?mOk4qdyMO8v6ErI8JFTAioVrPqahQJTzVvHeLw/56oJx+9DQK6a2i4NIbSSf?=
 =?us-ascii?Q?8DTV8vgXo8OPwl+EL0XRXcylAwbz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:19:57.8700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00563b15-33a6-4631-45d2-08dcdba88310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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

Make vram alloc loop simpler after 2GB limitation removed.

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

