Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17F0C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536598E616;
	Fri, 22 Jul 2022 20:42:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC6D8E8C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5uEV5nivYwZ+1zwMqv/HGNOO9WT4/FC4DQOeXiZ23FMogUaaOqYkG4D9UyKB1sqBOJHo5ALqkVoI/xYmx1i+/K/VB002F0rZzW56Zi6FZxFX+kxt6+VFfZ8VrNiSq9bLfmCcqG7qSh5mhUWeEoxi+pSUTG/rLye7eHctrx4g5/nmn88L1Rj6SrPJLI/SbPyZ+4oM1Uy/snHnb5fx3znIVyqzJnTXj8zqC3zu0T/TAO1HDxkc8r3REcNXiNPWSr9rXHlBf+xQE5S5fYpzCD7V2TCJkh5VCicse0WaI1ZyahDEdgzo53mcL1FT6YEjySJ+A3ykhdUD8EG9IyxJZdqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mDFmxVGIIi/Jp9fXC4xvjOs0eSXcm2Xmg7MmnNlOmQ=;
 b=mLjD6PdLfxIJibZiP8bJk9Axe0/nqciPXqQcbfMppxq99IvW/VcodDLUz515MG/vjjvUnD/jtzTs/eoz8CfB2LhMth+wDJ7f0KoeM6qwJNBz5dBfokV7hx+2oINWTan0oCr2uIS4yF0G65/VVepTbg0Jvh1ElAvZJEnhLPwp1HwME/NWH26WzuAU756BMt8UmQhwo+qjUCySVd3SAoVubblGLrDhcj51BdjEpffqAL6v42At2WlEbm6cvikYE7Ev89lE65sHyUym/nQO4LiFqO43c4lH478viRShbfdKbU0E/wInduM2Ls9Q+ZFKfvN3e0MXJqKHoqlE+A8g6PGlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mDFmxVGIIi/Jp9fXC4xvjOs0eSXcm2Xmg7MmnNlOmQ=;
 b=qeXvqyl4xvyr1R+UjqAs7msP5Q621kQIoPFTepXIxs3zCP9iaPD4WfOAWrfbioGifnfoHah//MQH9oJq5ILAvdahVO484X93MSKJN5y8cZip5Z2SjZagTPuOk/SrbkhcIGMfEP41sEIokgJYcjofDoVOEJPpdwFtua8I7yFIl/Y=
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:42:37 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::2a) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.0 via Frontend
 Transport; Fri, 22 Jul 2022 20:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:39:01 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:38:58 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/31] drm/amd/display: Calculate MALL cache lines based on
 Mblks required
Date: Fri, 22 Jul 2022 14:31:13 -0600
Message-ID: <20220722203137.4043516-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f1a9a3-4611-4a99-be11-08da6c2235bf
X-MS-TrafficTypeDiagnostic: BN9PR12MB5129:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obN+pLpxCd4+U2IgIgKuIU18n1kWojETFBIWHVLwVQjbmvRK616RPKZunBcZml8nmo8Uu/l2up/140mOY+g/hvR15a1COMH+gk7G6thjBAodrV5PHTKDXHaLwMSg17vn0O7iDRpOEvVqtcaSEqdncnP6s5TzVHH3RxpQdXObv2BV58hcwbNkRmXikMnAwOFT2BpWigPnpMNrAz9E5QPyxMXNzvx8nxzeOxaxzkUXGoar3A7TkYdw7xpP0KpmEvGYzX96ItgaEBSv30c8c52Uf8W/5cWnhuY+ZIJETrM7xcAavncPXaX/gaLyb4sahT3bz6SuUG20vhAZVQ+U2B6EWtRFHvoiK5X8NVXkDw/SqrAaU/cFJ8dP8wSHWPslpzxFaA8Ex2LoVivTSDTveZUS4BGI1r7HRetjNPvteUQX0wPX0WMfjV0i/+CQSd962HyOlVR5qnzljJlY4cTMk0EiYg8MPt9N9M7qikkjWBI5k0z3xu7Vw2ENU+OUDlLRmLeqUlXCmPx4cSh7LeJPRU0Tkl38k8fyToTRLBAwoaUYjRGLnFOR0QHIemhpFxyCFQKjpOAdHRo7TZElQ/nqguObLjutbPm/hDPVy8st9vwnABdVTGpCiApqOqcaCPUJZhekLBmPriWNbq0qTDx/PtRz6DOq9L/SRs4RopOya7R5RcTVvHEF+BfONM+oqZx00xkwSMCPoHKXCA2Ln47ZQ35SswhF6WUAnQUWb9yF527OCBUGIGni1KfzxP5dC9RKhO5ZuWZ1Guv3i+FqabdSZrLS5URjQcBQ/V2LqSDWkykphrpW874RCeiNdafA20+zSw/2RxzHP9J96rrOkxRGbFPvQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(40470700004)(36840700001)(6666004)(44832011)(7696005)(26005)(336012)(47076005)(70206006)(2906002)(426003)(54906003)(8936002)(36756003)(36860700001)(1076003)(5660300002)(186003)(82310400005)(41300700001)(2616005)(478600001)(16526019)(81166007)(4326008)(86362001)(83380400001)(6916009)(316002)(82740400003)(40460700003)(70586007)(356005)(8676002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:39:01.0917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f1a9a3-4611-4a99-be11-08da6c2235bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Calculation for NumWays in MALL should be based on
number of MBlks

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.h |  1 +
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index efd449804d7b..1e7e6201c880 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -29,6 +29,7 @@
 #include "core_types.h"
 
 #define DCN3_2_DET_SEG_SIZE 64
+#define DCN3_2_MALL_MBLK_SIZE_BYTES 65536 // 64 * 1024
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 47caa2c6d5b4..266c49884f04 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -51,6 +51,9 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 	uint32_t cache_lines_used = 0;
 	uint32_t lines_per_way = 0;
 	uint32_t total_cache_lines = 0;
+	uint32_t bytes_in_mall = 0;
+	uint32_t num_mblks = 0;
+	uint32_t cache_lines_per_plane = 0;
 	uint32_t i = 0;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -61,9 +64,19 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			bytes_per_pixel = pipe->plane_state->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4;
 			mall_region_pixels = pipe->stream->timing.h_addressable * pipe->stream->timing.v_addressable;
+
+			// For bytes required in MALL, calculate based on number of MBlks required
+			num_mblks = (mall_region_pixels * bytes_per_pixel +
+					DCN3_2_MALL_MBLK_SIZE_BYTES - 1) / DCN3_2_MALL_MBLK_SIZE_BYTES;
+			bytes_in_mall = num_mblks * DCN3_2_MALL_MBLK_SIZE_BYTES;
 			// cache lines used is total bytes / cache_line size. Add +2 for worst case alignment
 			// (MALL is 64-byte aligned)
-			cache_lines_used += (bytes_per_pixel * mall_region_pixels) / dc->caps.cache_line_size + 2;
+			cache_lines_per_plane = bytes_in_mall / dc->caps.cache_line_size + 2;
+
+			// For DCC we must cache the meat surface, so double cache lines required
+			if (pipe->plane_state->dcc.enable)
+				cache_lines_per_plane *= 2;
+			cache_lines_used += cache_lines_per_plane;
 		}
 	}
 
-- 
2.37.1

