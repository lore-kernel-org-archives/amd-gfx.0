Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AAEC47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 19:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2FA410FDF8;
	Fri, 26 Jan 2024 19:48:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F94510FDAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 19:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqVoWm7ZXbhubiefAz/uNrOMXUilqWAJ04FFXa1dHt4Zmn2LscxZ0PJevkzIXhGvw0DcPxNtxDxHyVBbEhVsv+EWApUx+8jHfR+U2JPd2EoJH6s7djDda0cNavmxsA6dvk/R6ggpnr6sXaVZnCcSizrpe0H16YIv5B+IYoczKeWUbEuS47nn4DEz9biQncyv2ULqFSbSHCzNYuliOr39vWZP8fw+p+FCDsJOqMuL3He/mVRWi2IYliTg0Pcplt5jFqqMUr07Uc6mzGVosAnHVvVJD3qGGZqL4w2RmAlHhCat0ox9heHJsPPEIu+VWpXE/4NNELunOxdZJRMvThpesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY2dTjExL9udG+DycARyKAnPnCdbTYJb9wggcMrC+jQ=;
 b=ZJTvtn7rumJ/M/qmzpa+pS+VWpgEAxlhMDcqy1e7n48Cr2sXfNmKu2SDIUP/wxbdqJ4lKmeNMBW2aio0fvrP0bvm5GI6J1THnA/GJGOAj6pUkiAleJuFCoABPWpu2mkKy+TWqbCX58N3aAhfnwbf2dBHaTg5kjePOkentcxds+wFH27Cdy5tu6XnVRs0GbC08/Ce6NWfCQ4aUgZ6M7YynTBlg2jaqjJtW4OnmWnuUmXQungYxPdNSjbv4g9Kokue+wIN6X2DJt+AXdOJNquA0j3wyDeUbQyrOfQKa4+AGgBeGHCYjwbeHdQdACCySyjQhiuoVHkLxj6i+6XM3rkfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY2dTjExL9udG+DycARyKAnPnCdbTYJb9wggcMrC+jQ=;
 b=Ur1lKYsgbOy3nPNWIn5uYEQBbhgaal0A7kSJ1jc7vTR9wy6B6DqdPGHSy+ooZrpVy2ptOJGetTIkDO/ftZQN7Qe5CaUyQzwD1EeyHnDL36Tp/l+xmBVegO0DJ/lGWX6X6M6hwZztBDueS7Zzzv7jjMYAZjo7lSYoSwJrHLdHsts=
Received: from CH0PR03CA0425.namprd03.prod.outlook.com (2603:10b6:610:10e::27)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 19:48:03 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::76) by CH0PR03CA0425.outlook.office365.com
 (2603:10b6:610:10e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 19:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 19:48:00 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 13:47:59 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Support >=4GB GTT memory mapping
Date: Fri, 26 Jan 2024 14:47:21 -0500
Message-ID: <20240126194721.18853-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d45f4d-1b6a-4dd8-5beb-08dc1ea7b429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6DFWiudGIlvzcYYsZ9XDw6CK+kDHSC6NJX/pkUx3TIt1Llzbdn+gz1x9+SyPmcNuC8LNx3twfhbpioY4zH2+EOUOdp81ULa77sF6iAIL3oRkqPfQU/mkLaxrPM1psPp8svNazq+3olMG/HK/TN7Wrq0ElVciYVQJZkb/s97/VEOtwoXM26wtwGUwvX9P79FAURN7Omb9s6iyoFiqLzrEejxIAizfBAqN3B+T4u2zqBtfjocpv9Q5/zmv8Hq2g6aZ+M00UG9qK47ZkcypSIHcBMYpLucMjHdPY5CKQ7Wm8lcpzsqh3DHVPty/+EhoyYmj4RMQ7BoT4QWRlVjz07Q0sdtowKz/d/CuPqktuKeACNMTuR+vZHJO90dqPqoSjSiPrZTMmrJJa6AVK74QIYicg7cpRhX1ESPp/cEz9NSqFSU2Ce4j2DRjLZx25hjo8P7cpsLkUJOBUO43GYFQsQuP1W5q7tBCQ4TcV5QEOYrXgrn94BcXk8xBXW2nS6CUqsLHeE1Gx5QztF+P9pWQAbhtmfs3HaasPJwBUe4ur2zVSGGeXkKbPYW8D46NT+622VlqvxoC23N0/O36o9kTv+QtutlFox0K/rkjjcatfj81g97DQd0xZQZ13eP8+z+X67wk5Gr/hahf3f4UHxcF1t3BJOzcAQ0AsIhCMLpgDwZ0OK8Ijc4P/NnxlFmvAzt6SC+vGeW/09eT8V++tLgMWthGGoNTrTiU6rFfq1soUgGyRYHlyHK89z1XX/zjcNk5YYRV3uhAG35piqXMta36o3Rvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(82740400003)(16526019)(26005)(8676002)(36860700001)(36756003)(336012)(7696005)(6666004)(2616005)(426003)(4326008)(41300700001)(478600001)(54906003)(316002)(70206006)(70586007)(6916009)(8936002)(5660300002)(86362001)(2906002)(81166007)(356005)(1076003)(83380400001)(40480700001)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 19:48:00.8248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d45f4d-1b6a-4dd8-5beb-08dc1ea7b429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is to work around a bug in function drm_prime_pages_to_sg if length
of nr_pages >= 4GB, by doing the same check for max_segment and then
calling sg_alloc_table_from_pages_segment directly instead.

This issue shows up on APU because VRAM is allocated as GTT memory. It
also fixes >=4GB GTT memory mapping for mGPUs with IOMMU isolation mode.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 50 ++++++++++++++-------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 055ba2ea4c12..a203633fd629 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -171,18 +171,41 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 	}
 
 	switch (bo->tbo.resource->mem_type) {
-	case TTM_PL_TT:
-		sgt = drm_prime_pages_to_sg(obj->dev,
-					    bo->tbo.ttm->pages,
-					    bo->tbo.ttm->num_pages);
-		if (IS_ERR(sgt))
-			return sgt;
-
-		if (dma_map_sgtable(attach->dev, sgt, dir,
-				    DMA_ATTR_SKIP_CPU_SYNC))
-			goto error_free;
-		break;
+	case TTM_PL_TT: {
+		size_t max_segment = 0;
+		u64 num_pages;
+		int err;
+
+		sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
+		if (!sgt)
+			return ERR_PTR(-ENOMEM);
+
+		if (obj->dev)
+			max_segment = dma_max_mapping_size(obj->dev->dev);
+		if (max_segment == 0)
+			max_segment = UINT_MAX;
+
+		/*
+		 * Use u64, otherwise if length of num_pages >= 4GB then size
+		 * (num_pages << PAGE_SHIFT) becomes 0
+		 */
+		num_pages = bo->tbo.ttm->num_pages;
+		err = sg_alloc_table_from_pages_segment(sgt, bo->tbo.ttm->pages,
+							num_pages, 0,
+							num_pages << PAGE_SHIFT,
+							max_segment, GFP_KERNEL);
+		if (err) {
+			kfree(sgt);
+			return ERR_PTR(err);
+		}
 
+		if (dma_map_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC)) {
+			sg_free_table(sgt);
+			kfree(sgt);
+			return ERR_PTR(-EBUSY);
+		}
+		break;
+	}
 	case TTM_PL_VRAM:
 		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
 					      bo->tbo.base.size, attach->dev,
@@ -195,11 +218,6 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 	}
 
 	return sgt;
-
-error_free:
-	sg_free_table(sgt);
-	kfree(sgt);
-	return ERR_PTR(-EBUSY);
 }
 
 /**
-- 
2.35.1

