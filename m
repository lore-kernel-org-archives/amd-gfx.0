Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA518C001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9B310E5B3;
	Wed, 12 Jul 2023 17:13:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D0D610E5B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAdLdCZ3zjzmpPzbh0aifgumy8nGg/ADWCGCy/NTpQLW6oJxMbXSrAA3Ss67/4NoX3VeCNzkDxwsrPJIzBikD6k86T6AIzxlNDB1r52PX3mXfkE4nRWxX3x1lwbpfsRhixmbSY0nsN3xgM24zxbGZGXar3vO0wdHg8PgZSEJxx2jyY6tfMyY7HxZzjP8lA9IOSJFQWiiuE9h43uNFOrp4Z/Bn4Z4/ba530GDCDA5vA5HGnXcSUYSLIGyTowq50zaQ5j1ZfgDyW64EcSg3/YhsFtwRko//HXPqyvQf/vlzudTw655olt6LTPoM1lyzOSaDlogtmA14L/ENiY6ArOfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs/MnCzJqcN3eJzYJ3mIO3rgiW2eN+0tHjgr4WMRCXM=;
 b=MskkObWK7MD3MKWigBpguP5xV4zKN5dcI+/n2eyVxDoDiyQ8LTB0leFEAgpMaPeZ7T7P5kKiwA/Ir1z4KOPLO4Eedeke2muNVYCQSeArVwz/T8CjBcXXMjeVApMb8m80+an4VYuyjz24ilnqKYXA2e9HSRW1gpo08XrqvUl6ZnVlcEerws1Jb3tc8ok064KLDdM2XouyNCsnPR6XBVuRTiyLaidZbjIUQMPh592l/RlkSyRQrA0TKik8BeyETMcSaGUc+3Aip+TMlzqUBi2jYIDmtz277ciFGETliKSN1mTKfgzuqeSlZQpqdV3nvQxqvkZXZjXRBQjx5wAlNPN10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs/MnCzJqcN3eJzYJ3mIO3rgiW2eN+0tHjgr4WMRCXM=;
 b=0K/4x8aVUkIQKdSFwyHmSvG4C45JrAq/0rdiR4SG0yzFmCpvmxnYBwAacN9JtsJHyGn9gtfLKxodU5mQjXgkaWQV2s4YqHF3X6x/5BR2JvH9k7kOl2J8NACdzKEwY/ZRDu1ZPDV3JwV9DhLV0Fa9zpsxAcFNlF+gFdeOkbUMv9Q=
Received: from BN9PR03CA0692.namprd03.prod.outlook.com (2603:10b6:408:ef::7)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:13:38 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::31) by BN9PR03CA0692.outlook.office365.com
 (2603:10b6:408:ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 17:13:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:13:38 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:34 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/33] drm/amd/display: Initialize necessary uninitialized
 variables
Date: Thu, 13 Jul 2023 01:11:21 +0800
Message-ID: <20230712171137.3398344-18-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: f993c490-353a-48cb-8b1f-08db82fb5593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 389ii09FXpAJO+G/kHxezn8xiPi/tS3Jkko8fP1UWvZFkS1HeD4aeO9Z/h+24wxN+ULrK7ytODlJT7qS/La62RfxWcjjaaS0o8ctUlFCeEFEwNknzwpOIYUIrsCDCYKnY9jUpb3LdzLCj9DWxfvBnVazLdpKe8Taya5go5NLMEKJlB9rsqC+uE0VuSrVbt1zTod6Q/OXfzdF/37dz8XZ1YCKvI4V3CPZ1FS2fsURhKITDkbvwlg7/WcI94oCp4mcsMrNsLOKoRfgDWz1979gj/ummg2VS0Ml4JoKFOzZcRdnZDMGT7lY9Lq4lWzhvOFF/fowZ7kTJU6rBgRUHJg6foS3mpnpLUIYb8s3mj9LPInWNKHpdLqAxqn4NDfzBVZTYanuKQNMeISZwPp2jZ8aCuSiSOCNM6oW35HnuLMf5ypo/3j0msTer7LrmBzYM9a6x3Ppk+uSqlDYYX0HG7Ngw/Kpl7NtiCVtYreU2YTN89TW3qv+edzd3mExtFETnKXBSoNFkfKUpGkQyZOEFKkiPNgor6cFwj++7blQ8S5slYgvGOr0lsi+WfiU2kLbBdCUCfdyBJvCmmvh1xjZyfz5sIrRowjPfLB6z3Q4Y82jesanLD4n0vnFXpcxCIFqpXF1fuA52B/StgaY81Mbpc/LthXUWRuUtTeZmUiaFDwEpx9KM0okvqM3siE2tDn4pLnETCWn7RkV1R+W2KJ7x8S/Rfs6P3qViLATXb/sOBD7J9eafSwA9+Of4ZMbrvZBTqeA9ug0kH+RnYTIBnyDgXrjpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(478600001)(82740400003)(356005)(81166007)(6916009)(4326008)(86362001)(6666004)(54906003)(7696005)(70586007)(70206006)(316002)(83380400001)(41300700001)(36860700001)(47076005)(426003)(336012)(2906002)(36756003)(2616005)(8936002)(8676002)(40460700003)(26005)(1076003)(40480700001)(5660300002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:38.6723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f993c490-353a-48cb-8b1f-08db82fb5593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Meera Patel <meera.patel@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meera Patel <meera.patel@amd.com>

This commit initializes uninitialized variables.
For some compilers uninitialized variable warnings are treated as Error.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Meera Patel <meera.patel@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c               | 10 +++++-----
 .../gpu/drm/amd/display/dc/dcn315/dcn315_resource.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |  2 +-
 .../drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c |  2 +-
 .../drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c |  2 +-
 .../amd/display/dc/dml/dcn314/display_mode_vba_314.c   |  2 +-
 .../display/dc/dml/dcn32/display_mode_vba_util_32.c    |  2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 402340f17a3a..ccd60aff19e7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -297,7 +297,7 @@ void dcn32_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 
 	clk_mgr->dccg->ref_dppclk = clk_mgr->base.clks.dppclk_khz;
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
-		int dpp_inst, dppclk_khz, prev_dppclk_khz;
+		int dpp_inst = 0, dppclk_khz, prev_dppclk_khz;
 
 		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2d8a8c8ff47d..4284a3609e98 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4090,9 +4090,9 @@ static bool commit_minimal_transition_state(struct dc *dc,
 		struct dc_state *transition_base_context)
 {
 	struct dc_state *transition_context = dc_create_state(dc);
-	enum pipe_split_policy tmp_mpc_policy;
-	bool temp_dynamic_odm_policy;
-	bool temp_subvp_policy;
+	enum pipe_split_policy tmp_mpc_policy = 0;
+	bool temp_dynamic_odm_policy = 0;
+	bool temp_subvp_policy = 0;
 	enum dc_status ret = DC_ERROR_UNEXPECTED;
 	unsigned int i, j;
 	unsigned int pipe_in_use = 0;
@@ -4372,8 +4372,8 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	 * cause underflow. Apply stream configuration with minimal pipe
 	 * split first to avoid unsupported transitions for active pipes.
 	 */
-	bool force_minimal_pipe_splitting;
-	bool is_plane_addition;
+	bool force_minimal_pipe_splitting = 0;
+	bool is_plane_addition = 0;
 
 	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index df3a438abda8..2e3fa0fb8bd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1659,7 +1659,7 @@ static int dcn315_populate_dml_pipes_from_context(
 {
 	int i, pipe_cnt, crb_idx, crb_pipes;
 	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *pipe;
+	struct pipe_ctx *pipe = NULL;
 	const int max_usable_det = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB;
 	int remaining_det_segs = max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB;
 	bool pixel_rate_crb = allow_pixel_rate_crb(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 1cc09799f92d..0d1f18f8348e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1892,7 +1892,7 @@ int dcn32_populate_dml_pipes_from_context(
 {
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *pipe;
+	struct pipe_ctx *pipe = NULL;
 	bool subvp_in_use = false;
 	struct dc_crtc_timing *timing;
 	bool vsr_odm_support = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index f294f2f8c75b..57cf0358cc43 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -3194,7 +3194,7 @@ static void CalculateFlipSchedule(
 	unsigned int HostVMDynamicLevels;
 	double TimeForFetchingMetaPTEImmediateFlip;
 	double TimeForFetchingRowInVBlankImmediateFlip;
-	double ImmediateFlipBW;
+	double ImmediateFlipBW = 1.0;
 	double HostVMInefficiencyFactor;
 	double VRatioClamped;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 43016c462251..eba51144fee7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -3505,7 +3505,7 @@ static void CalculateFlipSchedule(
 	unsigned int HostVMDynamicLevelsTrips;
 	double TimeForFetchingMetaPTEImmediateFlip;
 	double TimeForFetchingRowInVBlankImmediateFlip;
-	double ImmediateFlipBW;
+	double ImmediateFlipBW = 1.0;
 	double LineTime = v->HTotal[k] / v->PixelClock[k];
 
 	if (v->GPUVMEnable == true && v->HostVMEnable == true) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 9010c47476e9..32251af76935 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -3613,7 +3613,7 @@ static void CalculateFlipSchedule(
 	unsigned int HostVMDynamicLevelsTrips;
 	double TimeForFetchingMetaPTEImmediateFlip;
 	double TimeForFetchingRowInVBlankImmediateFlip;
-	double ImmediateFlipBW;
+	double ImmediateFlipBW = 1.0;
 	double LineTime = v->HTotal[k] / v->PixelClock[k];
 
 	if (v->GPUVMEnable == true && v->HostVMEnable == true) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index a50e7f4dce42..890797ecf0f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4124,7 +4124,7 @@ void dml32_CalculateFlipSchedule(
 	unsigned int HostVMDynamicLevelsTrips;
 	double TimeForFetchingMetaPTEImmediateFlip;
 	double TimeForFetchingRowInVBlankImmediateFlip;
-	double ImmediateFlipBW;
+	double ImmediateFlipBW = 1.0;
 
 	if (GPUVMEnable == true && HostVMEnable == true)
 		HostVMDynamicLevelsTrips = HostVMMaxNonCachedPageTableLevels;
-- 
2.34.1

