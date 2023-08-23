Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF0CEE49A3
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC46110E474;
	Wed, 23 Aug 2023 16:05:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A1010E472
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Drq28Go3CP+OrwOTjEXZqy6pus4woFYqWU1BcFSNAHef7xUNIcQ1T7T4I5OgHwB9Euuj3jnnl1W5118kXBiDhoB/GD4RIBLeE+kxOrJPlWsprzjVuWh/TSXPcyAIKaCq8mvXw/HHIqiLQVG4mTvpN5oc3FymQbDPABkIxKn2h644Jzbq07elJH4ovj9baG0FCKVo8V58UfFAhdsxO0sQt4yi8D+RuJ122udrhMatuMAB6Nz0u9gpHE8Y8LA+SKNtVUaVq1/DAXafkSHTzDGevWK3oO8ni82hhNdSGmV9Od1xadcUNF9Wp7MdnbCK1A9n3KNVw12fk1zHKsD0rtn1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWYCzaaEh+shcTGLRgffucl3aFSt+iEwgV0jCCjUaig=;
 b=MmbAmyuMklQdF+b+n2boiXdaImOncaVIpTpx0+51S97+RVGT/iXpvquEp5AUMnFQrrrpA3mqvztM0ASiWLKd4pYAVThgLFhrk8zeEcUeuYrVwCMsdEwxwKYCJMcFHy9Y/rWseyaiy+3EQkIYQAn6PodoL3d+nYGNl0QsFIcxBZUg4ALsZ1xPRy00LuVyQYcLTFfBfFKqwxamYNi1IN94ER3xm8Kb5spOuPzZy1QwTDTwbjbPgZjG2EWCtipTSjDTAYUH82oiSN5iQnHW0E2OYnJIcYVfZVRc1w+XWtAQSKLJbUWqdVSCNTB2EqDsKrXXg7iukYow9znoTREUqKD6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWYCzaaEh+shcTGLRgffucl3aFSt+iEwgV0jCCjUaig=;
 b=Ue99bDTzes2lVYOsdG2ee8V5isJAqfP2fx5ddKzGWftYewdhIAF1pARM2tYYmltiB9gmYsFCQh1ANHLIDF2cZrf8sftql/Lb7xioS8uD18115hmwHYZXatirR8ZoHDuSKKMKz1IH1OOMU4wbVjIEJgVxNXTPdSp048NL8Fj86mk=
Received: from PA7P264CA0116.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::7)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 16:04:55 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::34) by PA7P264CA0116.outlook.office365.com
 (2603:10a6:102:34c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:54 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:42 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/21] drm/amd/display: Add debugfs interface for ODM combine
 info
Date: Wed, 23 Aug 2023 11:58:21 -0400
Message-ID: <20230823160347.176991-20-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 057595c5-40af-4c91-7cf5-08dba3f2b0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTxDMpHZlbIfRGSs+TFYc9JCKm3/jVjJiclpt+0sktEyjchhfl4VdHGdfS25ROmdoLUS8JE7HTBNA3gFu49jyQDjUlig8DwzwHeWVtEhqj1nn9k87Q5ke1germrwRy2UFoRDQoPgSjtzi0fZVgq0vOiyk3DPzLpnbQkedn8Tcs3nJfp2pXUgF81bWwejdxWvfk1CeQX3RLzeYkFPyGu/IcO1lcsYA3CwMF5M1nFTH/YszA9db5oFcjyiBAKUILmQsXEyqhdMb+8bHP9op60C4J5zfv+ee69EhIKcZezdixnlGte1Ql75Ll74dWLd977q2BzWDr8SVLb8WvBq6hY6qDbzTqgOtc6w3C0sUR2TTLm3KYzO1+PfWMdywfdSGs3V/XY/D2GNyIdpGFPMxXUBn4CRijQanOvA4PqpWWzS4HK5cZFUuf/FJySexvYcjTh1JSwTlj4ZBqEqyjOCaI2XEqU8z9DXxFretMDFN0pmubLQ/8PdbRbCCgAvi+ZpL+V+Brb51zItDhzYkNrI1z0OxVSlfW/0CEBsmXYCd8jajaajkSlX/xWvP7vy5i2el3Y4+3LGIOIrO8JWz+gHNOkQev9jIkPtF0jxHyj5pf5AgYi/g8KDR3zqC2T0lbPEIsY1kdCJQlnSrNtVLkxSMcaf5iHELqQPWBKS56fD08OHWUoZUumyBQ26hWKoUijvhqBy3xoSNob+ZKwn8Xl1FdqT9R3q6MfaXcWnMz5cVMcci+8mMzaZ95xQjsVrNZF1JrlNw+7turf4Cd25qrTtBdCqWIZWiQHRUoRtBQ+NLh0aY2RIQI4pz5tfccaSo0o7yQbS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(70206006)(70586007)(54906003)(6666004)(8676002)(4326008)(8936002)(36860700001)(26005)(16526019)(2616005)(478600001)(316002)(41300700001)(5660300002)(1076003)(6916009)(44832011)(426003)(336012)(83380400001)(40460700003)(2906002)(36756003)(40480700001)(47076005)(81166007)(356005)(82740400003)(86362001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:54.3965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057595c5-40af-4c91-7cf5-08dba3f2b0aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
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
 Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why]
For use with IGT tests in userspace, the number of ODM segments in use
is required to be exposed to userspace to verify that ODM Combine is
working as expected when special timings are committed.

[How]
Add a connector specific debugfs entry that prints the number of ODM
segments in use.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 33 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 25 ++++++++++++++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 0c4dd922cfaf..17d1990ea832 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1201,6 +1201,35 @@ static int internal_display_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+/*
+ * Returns the number of segments used if ODM Combine mode is enabled.
+ * Example usage: cat /sys/kernel/debug/dri/0/DP-1/odm_combine_segments
+ */
+static int odm_combine_segments_show(struct seq_file *m, void *unused)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct dc_link *link = aconnector->dc_link;
+	struct pipe_ctx *pipe_ctx = NULL;
+	int i, segments = 0;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx->stream &&
+		    pipe_ctx->stream->link == link)
+			break;
+	}
+
+	if (connector->status != connector_status_connected)
+		return -ENODEV;
+
+	if (pipe_ctx != NULL && pipe_ctx->stream_res.tg->funcs->get_odm_combine_segments)
+		pipe_ctx->stream_res.tg->funcs->get_odm_combine_segments(pipe_ctx->stream_res.tg, &segments);
+
+	seq_printf(m, "%d\n", segments);
+	return 0;
+}
+
 /* function description
  *
  * generic SDP message access for testing
@@ -2713,6 +2742,7 @@ DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(dp_lttpr_status);
 DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 DEFINE_SHOW_ATTRIBUTE(internal_display);
+DEFINE_SHOW_ATTRIBUTE(odm_combine_segments);
 DEFINE_SHOW_ATTRIBUTE(psr_capability);
 DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
 DEFINE_SHOW_ATTRIBUTE(dp_mst_progress_status);
@@ -2991,7 +3021,8 @@ static const struct {
 } connector_debugfs_entries[] = {
 		{"force_yuv420_output", &force_yuv420_output_fops},
 		{"trigger_hotplug", &trigger_hotplug_debugfs_fops},
-		{"internal_display", &internal_display_fops}
+		{"internal_display", &internal_display_fops},
+		{"odm_combine_segments", &odm_combine_segments_fops}
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 8abb94f60078..e7e25c58c692 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -98,6 +98,30 @@ static void optc32_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 	optc1->opp_count = opp_cnt;
 }
 
+void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combine_segments)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(tg);
+	int segments;
+
+	REG_GET(OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, &segments);
+
+	switch (segments) {
+	case 0:
+		*odm_combine_segments = 1;
+		break;
+	case 1:
+		*odm_combine_segments = 2;
+		break;
+	case 3:
+		*odm_combine_segments = 4;
+		break;
+	/* 2 is reserved */
+	case 2:
+	default:
+		*odm_combine_segments = -1;
+	}
+}
+
 void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -303,6 +327,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.set_dwb_source = NULL,
 		.set_odm_bypass = optc32_set_odm_bypass,
 		.set_odm_combine = optc32_set_odm_combine,
+		.get_odm_combine_segments = optc32_get_odm_combine_segments,
 		.set_h_timing_div_manual_mode = optc32_set_h_timing_div_manual_mode,
 		.get_optc_source = optc2_get_optc_source,
 		.set_out_mux = optc3_set_out_mux,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
index abf0121a1006..93cc7fc8472c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
@@ -180,5 +180,6 @@
 
 void dcn32_timing_generator_init(struct optc *optc1);
 void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode);
+void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combine_segments);
 
 #endif /* __DC_OPTC_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index c21e7ffd5bd0..9a00a99317b2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -309,6 +309,7 @@ struct timing_generator_funcs {
 	 */
 	void (*set_odm_combine)(struct timing_generator *optc, int *opp_id, int opp_cnt,
 			struct dc_crtc_timing *timing);
+	void (*get_odm_combine_segments)(struct timing_generator *tg, int *odm_segments);
 	void (*set_h_timing_div_manual_mode)(struct timing_generator *optc, bool manual_mode);
 	void (*set_gsl)(struct timing_generator *optc, const struct gsl_params *params);
 	void (*set_gsl_source_select)(struct timing_generator *optc,
-- 
2.41.0

