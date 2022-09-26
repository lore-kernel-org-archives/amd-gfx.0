Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEB4C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 05:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07F910E34E;
	Mon, 26 Sep 2022 05:26:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BE310E34E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 05:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5048p9al4HTmm8BWSq3pf3rtdtrqe70YmWpq2mXZMcithlqAtFzR6D4EJHhPm2sLl2O3ZdeT8ZP+jFRO6zCL9KZaGLAKNuJpVGwcyxzUUjuUFnyksJ9uSa3xn8BySedRJKuKU0seY2y2/7dK488ZuUVGQIAzALanr+uY2Rku3az8cnrKSFoNABQrvKfinfEg/eD73l10qSePjXWRqfKtFPA4SVO8GORCYyyjS81d4XFMTJwpP+rU+LrDiethuN7Z/Cv3xAni81ZyssdpeCZxnRL+e9mfEo/+aS9Pz+5l8EpX3pgp+BG6cEu15/gjjsjmnXgroJ9+flojt+CSxfAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqzPlOQQISwrHVrRxo856ZS4rzWl2SVG3VVHl5B3NP8=;
 b=G7VZQgnfik2CLsypIx7z4sjEMoCU6nmaX7vLMjfC2b9LDamKipz48cZYy3Wjb3SKQ1yl98zNQytroZps2bpRCq63cKvqE5CuNt30tX/uLLrXaij6FuD0AkLmOcAXD6xlnS47j9uWfo2UF+wtGoghFlDSGpm7TzM0z3iQoVdS9edkD6ByXcxVzJ/Q0Nv/3KOKgGAZm9rvQethykkCyk2qkwjaPQm6ZhxvqSi6TYpgJ78uaPcRxMld6SjAsX0KAMmzn0i8C7ZELaRiOtarbV5DwNrgYyNd+ErKZCv9g6i1/VkpSh9mxu79HVtxqjhBPhldowKCVT5sfVZec+iyht7GNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqzPlOQQISwrHVrRxo856ZS4rzWl2SVG3VVHl5B3NP8=;
 b=jl/urWxcP/fjKD0GMdx8eixgWFlbQzGSCijdRTjY2L6NPY0ItJDcte8IEdHWOM+9D5h+8WQugXw0BmH6kkstkmdyEEQtP8lsaXBAGDnLZ5gG5XBPfzn+bFhKmTM2p1oMMdhT0WoFXsjEIyiyczkRdxsgechuCz/9hghS9HMqAtM=
Received: from BN8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:408:ac::45)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Mon, 26 Sep
 2022 05:26:10 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::e7) by BN8PR07CA0032.outlook.office365.com
 (2603:10b6:408:ac::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 05:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 05:26:10 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 26 Sep 2022 00:25:44 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Fix VRAM BO swap issue
Date: Sun, 25 Sep 2022 22:25:29 -0700
Message-ID: <20220926052529.2586-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 337017e9-9dd6-4021-e237-08da9f7f9f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWihhnm0OR41efO5zOFuTCKxzORL7RkKSPVnQoCQ2u1G45p15s/U/aa6LdAikCHvXid7nfj9pE+IHZwJZ5wMAmm+f1Ysuz/tUPXhsa5W5hJJPWAj7EZZE8pLBZWf2ilJvo+q6K4u6kESL9VPXgdN8Zq41H8vaHmWBeP+73Kx6v1Z9X0IyPXeCLLei1d1BKv2u+xC7SRTKDD8iYnjgVWJDBoIBt77xe760hIErPoDhRzFxbP5SKRkTra0npqLZkwfDlyeVy/VTfAfORfkP4WDAE5+jKgMinwWnK3fVFXJrEIeBbqVxAKQq7v+iy25p6Em5sw8YogLVrtbF/a+8RaiBf9h6bPsnh48r/NH6fZWY9S/Nf+tNjV2YqlkKO28lR4fj633pi3y7VZjTm5W23zoqObVuPX3/+zP8CpiOJpHIAAEyWFCG0WicD4MfT5g+dYxvHqTwiu4dDpyvLRHkBfVLjK4qckoKId2i9l2z+Q8P3L4yLdKOtJJmma5Ei/c5qRYBSoVSv5T51IPkfNtBXIkGenpNm+MwV8s+ARq05tYBdqZ/8MW4n57p3OcPlA3YtXMJ3fB+HxGQTXblCEJJmL2Vu81Na1OE1K9zHCmEA35IsHQxFFqq9CTwyUz+kSJyJcugL47Cpvx3aNl0RmcLC9T1Nwj2T7I6hMd743GyxzyYStA0mFY7/V69HcKs9LYkhapqL7PLwDE/zg34tb8P70jCoPhJEKP9WaQ6aOgFVNQAWVFvZLZgwb/XzFDQ/kbMJRIDntuQN/+r3Z1YhFvM98ErqbCNGrQIWbAiCjzzFsLDHBEI689dbGAExqaH/u2yMGg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(478600001)(70586007)(5660300002)(6666004)(82740400003)(2906002)(6916009)(316002)(8676002)(54906003)(4326008)(70206006)(86362001)(81166007)(41300700001)(36756003)(7696005)(336012)(1076003)(83380400001)(40460700003)(356005)(82310400005)(40480700001)(186003)(47076005)(16526019)(426003)(36860700001)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 05:26:10.5475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 337017e9-9dd6-4021-e237-08da9f7f9f2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com, christian.koenig@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DRM buddy manager allocates the contiguous memory requests in
a single block or multiple blocks. So for the ttm move operation
(incase of low vram memory) we should consider all the blocks to
compute the total memory size which compared with the struct
ttm_resource num_pages in order to verify that the blocks are
contiguous for the eviction process.

v2: Added a Fixes tag
v3: Rewrite the code to save a bit of calculations and
    variables (Christian)

Fixes: c9cad937c0c5 ("drm/amdgpu: add drm buddy support to amdgpu")
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b1c455329023..dc262d2c2925 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -424,8 +424,9 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 static bool amdgpu_mem_visible(struct amdgpu_device *adev,
 			       struct ttm_resource *mem)
 {
-	uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
+	u64 mem_size = (u64)mem->num_pages << PAGE_SHIFT;
 	struct amdgpu_res_cursor cursor;
+	u64 end;
 
 	if (mem->mem_type == TTM_PL_SYSTEM ||
 	    mem->mem_type == TTM_PL_TT)
@@ -434,12 +435,18 @@ static bool amdgpu_mem_visible(struct amdgpu_device *adev,
 		return false;
 
 	amdgpu_res_first(mem, 0, mem_size, &cursor);
+	end = cursor.start + cursor.size;
+	while (cursor.remaining) {
+		amdgpu_res_next(&cursor, cursor.size);
 
-	/* ttm_resource_ioremap only supports contiguous memory */
-	if (cursor.size != mem_size)
-		return false;
+		/* ttm_resource_ioremap only supports contiguous memory */
+		if (end != cursor.start)
+			return false;
+
+		end = cursor.start + cursor.size;
+	}
 
-	return cursor.start + cursor.size <= adev->gmc.visible_vram_size;
+	return end <= adev->gmc.visible_vram_size;
 }
 
 /*
-- 
2.25.1

