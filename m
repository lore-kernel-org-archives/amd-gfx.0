Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6022EECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C79A10E7F1;
	Wed, 14 Sep 2022 03:31:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB81210E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cioVHnfIWV1digAWJKWpUIxUHTiwnMrUo0rMcJqNZhD40/KyU1woxlfwGvETJKZy9fK0rmBhCSCVKiS+6U/ia52C1gVrkHH36WhNloCqmt6JERSTaD1tx35+zrCL3x/n7XEdysyz/WICmnZbyzjPCloqqHhw2qQGJc/RgCN4yDIdlOE5Nmn08GJWaFtga/3doKJDr3W/iiEcDuhd9sfvBpin2UmoQQzytrvQGaRh/iSY9fLt53ewHVz+UTkgXQ3FR5L2TCDuwINOUQ2ZoH67pz5hrg6PJho7hngOwELnVRPZ1dCbQVqcbmqjOLY3JjcVW4RewswMr22Zi3xEjDiOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOhRbySf138h7l8a++kqxKUjWUYsB4r8XnJQ/PR6BuI=;
 b=Zs7tK3Hr8ocHjFUYzRAFx7uEuWWWe927PqHlJ4P2Viyvd3NoOjJW97S0MRLxVhT1vQ4rCY4sTy88puvHqh0X8ZgNLMGIVxysT1Dug0DpoaB+xWcw4/jPmvho2epIjGODFNBaEm5XJ2Kzd8oBVQhBx9L2Phnlw3PC7e8rmS5MpMrEYmumepvXppHsoosi0p3l8Xpfwza0qix6ySq5IlH8KKjT+xdggP72XXQfqNLZRItJRFoqL6VEaTVqbDEpBZcmRH/DgmzYPI14d0wme08HAGIOkz1fTxVHF9FZUhLmce0wv3OyKPQ+eVwjGvf4eiaY0+s30OBSEEUVjw2IgRrTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOhRbySf138h7l8a++kqxKUjWUYsB4r8XnJQ/PR6BuI=;
 b=wYVmz8SGzdztU4t2gBMolDIzkGUYCzC/5frGk1wtvR3RMF7aCdw9Q2uOfK3rL7p4W/axabvXcEXmqfSwJyLtlYuUue2sTg9BiWWTIEIut2+nMV4wOmbtDx9MCffm2TUc57KjhRI4aArr49OzTzV5nxBAEdt9E/RtCkPlio3OzNs=
Received: from BN9PR03CA0942.namprd03.prod.outlook.com (2603:10b6:408:108::17)
 by CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:31:02 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::1f) by BN9PR03CA0942.outlook.office365.com
 (2603:10b6:408:108::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:31:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:31:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:30:41 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:30:36 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/47] drm/amd/display: Fix SubVP way calculation
Date: Wed, 14 Sep 2022 11:24:10 +0800
Message-ID: <20220914032441.1075031-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|CH0PR12MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fdd272-1338-44a3-c0db-08da96018c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1A1/xVIdwO5uW7DgwnthonFl/CMdKSapw6R993NNFyVZE8vLnQSusgVBh7rJkJM4wmcOxPW+lPQGT79wVLisu5gSQsaeWVClTnXvoIjgsZSU4xN0Fub+DaLBMVIvtHR18fLB2bruKUd3zdbEr0RHCQsJIcNzOhHOL1blJKHJlGLonoiDb+MJ9i1DMN4ONaqF+mODGxka+tqHcUFROMPgrXUxhmaVs7LDFOp/o8OhghnpMJiBYgaDt9p/f8s65f5g+Fv64Rq/Kasq8zmek2LuZbagTVkD3MkibwbPTWkBquBXiVlWBhRFIfy4Mp2FCnJ+DE5AW/vlipcAsRtoESFJ5nJYDclMO8lA8aiZsFTF5IUbEv8azLUqimnksWQ1ts4plelWZiJUu+ms813xqPoVkkRYqb2w97ihp1yHi2PD2jTaHs5Mfks8eoegYah96BtVPiqA530Oh7wQUygPfKuaLmQJVFYUy7yJnD2G3z9GFpgdxSXO6Zz2busDC/9GOd5CFLQjTUT083WR4NlF+knnTdwoDM/JNikL1jACftZk6JZVYbnPOdsiS7OJs1ts6XBXV02JlTLlTn7kf5B0RFTAqVjq3eTvovvNoJyvXKcxjuAHI+xE2BBeKdSMpqsiFn/8EbLKykrXpxc2coJT9s3XcWDnq/YJu0oUJblLNPmw+EFCHkIoP/Oqe4bkwuGCVIcBKV3Cp5GmU31IPWzP0r955A7ZIcQI+kgyb8MIGa1/FwucaeQcG4tDXoi5nLnhU1FM5ofio6rUuIm2F3K2IC0eoMo/TtsrtHjjlbHcLJyqpUE+qeoSlutDc79XGqyqvB5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(36860700001)(8936002)(40480700001)(1076003)(82310400005)(2616005)(6666004)(2906002)(8676002)(356005)(36756003)(81166007)(426003)(82740400003)(336012)(316002)(6916009)(40460700003)(41300700001)(70586007)(86362001)(54906003)(47076005)(70206006)(186003)(83380400001)(26005)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:31:01.9653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fdd272-1338-44a3-c0db-08da96018c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why and How]
- Don't skip bottom and next odm pipe when calculating
  num ways for subvp
- Don't need to double cache lines for DCC (divide by 256)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 237f71d9304e..14787e0f0b6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -66,8 +66,11 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		// Find the phantom pipes
-		if (pipe->stream && pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe &&
+		/* Find the phantom pipes.
+		 * - For pipe split case we need to loop through the bottom and next ODM
+		 *   pipes or only half the viewport size is counted
+		 */
+		if (pipe->stream && pipe->plane_state &&
 				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			struct pipe_ctx *main_pipe = NULL;
 
@@ -118,9 +121,9 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 			// (MALL is 64-byte aligned)
 			cache_lines_per_plane = bytes_in_mall / dc->caps.cache_line_size + 2;
 
-			// For DCC we must cache the meat surface, so double cache lines required
+			/* For DCC divide by 256 */
 			if (pipe->plane_state->dcc.enable)
-				cache_lines_per_plane *= 2;
+				cache_lines_per_plane = cache_lines_per_plane + (cache_lines_per_plane / 256) + 1;
 			cache_lines_used += cache_lines_per_plane;
 		}
 	}
-- 
2.37.3

