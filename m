Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95111C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8809C10E81E;
	Wed,  7 Sep 2022 18:12:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E2710E80F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxZfWMJwgJ7NWo6Xg4VjP2xMNtwZF+e7MFajhQ7sWL8s+nbX9sX0pZRSRP3T6zQqQgGDH1LWylgPexNNgoLhh/SVB+C2QciNArTUCQ8nCsO0tN+iQzYn19BYhVP+j6pQWLHyJCZ9ywIwWduui3jRsZYD5WyKbjb3PFwUn3AIvnzawzptCZk0W0sEDPowAa6lkfzS0UgRDazfSamCx95t2EWFbQnM0yR/3CaUlrqu1d3bh/Q/B0JPYPaJ66XO+Wj55a70WkeBUOaDggqVVwWFI1lCV9IcGqeMCpIxCtJ5hPcoLonBWC1r9eMW7Xy4RugMlPrW+W9CuNCyxibc6yQxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yfFWQZACoeUIlHQeYNeYOIRrPM162fLZqp9bgbHbbc=;
 b=cG+K4Sy/+VYlOJzEiUsa27STrFozYKmt6yaixTJjhWE0aofRHtQX3AgYEuAQaT18JO2f83AhaEEappqxNwvdfMGoy3LT5jqOur2GZ2UqiOWPbfWSyRuEq8rnBuA40vC6cAWF4sV8c+vN1s9sqMTI3U0YcR43NomvWRiNtgUpMobppQolXtjoDHze8z9rG2Bjox37CM3p+SDq93ErGiV+MCE+LYPHvivT3DK1uxuR+hq2ojjdqAEYwQkiiw+b62plUvkX9MWf56zFtV7OvFDaBz+SX9GqsXu7D9mUbUOK7R2HsBthXkX7HOMpbjKrtILlRutkDPa1py/zafU8+hDO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yfFWQZACoeUIlHQeYNeYOIRrPM162fLZqp9bgbHbbc=;
 b=moMUMOCf+PU45KFdmoPya9xfnkMY4V7+bNoo8Te1Y8izIG3OddHNbslmXzm0u4TE+z3sokytes5fy9Yk+IpOTZxMHFU2o4/hKvw5Q0ZEsSo1q0LZwVoB9h0ixej7twDwd6gDZk/HJZSasPQ/pC81xridJp67j0BNkvRBPsS/yqA=
Received: from DS7PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:3b5::11)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 18:12:33 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::54) by DS7PR03CA0036.outlook.office365.com
 (2603:10b6:5:3b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:33 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:29 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/21] drm/amd/display: Added debug option for forcing subvp
 num ways
Date: Wed, 7 Sep 2022 14:11:52 -0400
Message-ID: <20220907181200.54726-13-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|CO6PR12MB5425:EE_
X-MS-Office365-Filtering-Correlation-Id: e901c8b6-99ea-46d3-c1a7-08da90fc893b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfELVlJ3xaKOzAXrj/zcgzvCkgPbX5j5WeewbAHNnKN8eiFv8M3KxGunVXJqU1SAFtPxB3o9oyQHfut7zIuYSuEw39nsmnlnN8VojA19jd6pugm3+nXA2/OmxKSwFtZk2R+ObKAlbjye1BzuMd7NNf40JayKAwTygcaSszgi+KIChmdZNLrWIK2pX4FIsVI38c7slXNZQXTQLpQT6bR17d6VoYngboFO8NUX36fv4Lv3QvVWqgPlqIZdOF0pokhBZ3ue8ckDVbBI9g/YwE8QDHWcXS14bRA1rb3UP2tkBPWfBe48OT/9ixk/XoSAzyE0poeg5P8LMhe9dbnOz6aB/kkF9FfXleFu2++YjNYlS+jcyIOx8jJdO+G7n/rOtPjGpHFZ7xyMpCkydg0DZb504LWhFYM/sQymZCo8unRISStWjR5WaJ3rw8Ruk0/dC4RF06cpskIBF6QJIMewdmLsb/eexgIq7tjkkJQsSJxr6Dr4yT0ymqV4AkBjEzQbZY/IP/hF5Ts2A2gko6j8+/D/rIoTky8GurOU5MckMDS3UgVWl+qXyoyk0T+2MWy65t/uxNlm6NikTKnhT29DQm/ycSoJ2uZDRQuLt8O7QdesR69D8hLwbRRAokC5x3yD7zdi8DRU5u9JIUkAYwBL8/TyA7fidX6DBN7uFgefZXgdrwA0ikO4JfScewlbyhnTr8vN0Co0KeUJVGBdJc3sekwWSFJpH40GY00YSAYjVB/71eHap+Qm/mGNiLGW0VbAIczBOiEf5Z9sfp+b2QZFIA87tPm3NPRT7GCKiBs2UljIiO/25IQLbofW4KqI4kw/Y6K5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(40470700004)(46966006)(36840700001)(1076003)(36860700001)(426003)(47076005)(54906003)(82740400003)(16526019)(356005)(6916009)(82310400005)(40480700001)(336012)(186003)(83380400001)(316002)(2616005)(26005)(2906002)(40460700003)(5660300002)(41300700001)(36756003)(4326008)(81166007)(7696005)(8676002)(8936002)(44832011)(86362001)(70206006)(6666004)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:33.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e901c8b6-99ea-46d3-c1a7-08da90fc893b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Description]
Regkey option for forcing num ways for
subvp for debug purposes

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c48403d49f2e..e8e8e031b9d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -831,6 +831,7 @@ struct dc_debug_options {
 	bool force_disable_subvp;
 	bool force_subvp_mclk_switch;
 	bool allow_sw_cursor_fallback;
+	unsigned int force_subvp_num_ways;
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
 	bool disable_dtb_ref_clk_switch;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 13cd1f2e50ca..7c37575d69c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -54,13 +54,14 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 	uint32_t num_mblks = 0;
 	uint32_t cache_lines_per_plane = 0;
 	uint32_t i = 0, j = 0;
-	uint32_t mblk_width = 0;
-	uint32_t mblk_height = 0;
+	uint16_t mblk_width = 0;
+	uint16_t mblk_height = 0;
 	uint32_t full_vp_width_blk_aligned = 0;
 	uint32_t full_vp_height_blk_aligned = 0;
 	uint32_t mall_alloc_width_blk_aligned = 0;
 	uint32_t mall_alloc_height_blk_aligned = 0;
-	uint32_t full_vp_height = 0;
+	uint16_t full_vp_height = 0;
+	bool subvp_in_use = false;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -70,6 +71,7 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			struct pipe_ctx *main_pipe = NULL;
 
+			subvp_in_use = true;
 			/* Get full viewport height from main pipe (required for MBLK calculation) */
 			for (j = 0; j < dc->res_pool->pipe_count; j++) {
 				main_pipe = &context->res_ctx.pipe_ctx[j];
@@ -129,6 +131,9 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 	if (cache_lines_used % lines_per_way > 0)
 		num_ways++;
 
+	if (subvp_in_use && dc->debug.force_subvp_num_ways > 0)
+		num_ways = dc->debug.force_subvp_num_ways;
+
 	return num_ways;
 }
 
-- 
2.34.1

