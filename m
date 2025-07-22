Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCAEC83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B6310E720;
	Tue, 22 Jul 2025 22:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xtc4o9iX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A5D10E720
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwGxZFq32OQlbhojMGxhPyuW2QGiyV4aFQvFyrvuuX0EI9DiJceDjxh1fHMkXUprlhUog/c0nrOqcD4giBTEl+aOSQIiS6tV0OGXWH8b2PD7Uq3E28FYsGxhpuGyjdZ9/aCfpMTI0g4UmdmTmoDeRCkU8OqDMFImGwpoZD/p5vmoBEVBc3wsV+iz6yIOjfJbBUy0hIrH1y+TeS4DCOwtAo7IRIVqCZU+Jc0WnIHE6fWFRmryEolfnEvKPQPg2VwXuIUGlUA66mD5tXhl7NNJvFbbB8sV2lEbd8HNqIdn6STIO5JWDmhPVJLD7i+5NHEwfUS1ZHgKWThW4lhV3wDH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlI25edCJMrwI5i/xYN1GyFQWtWDQ2bzm0XzJxP+xMU=;
 b=POu+eYcmz5O8VNxUiyjEn0/iDF8ybZig4Hl4njv1XqmTZOyZQL58JVGFozUKmgTTBXiDJ2jjto4UzHgMRTwt8Y6ACHGBzTZB5KzYHJrVskLbdCAnpP7pdLXtXk2AY5foBWn/3dYFp9tzALcAHdFu9xF46G5hYEqjgMOQMu3lM/dPSYfL9Kj+3PAoO1+Hgu5OeGHeKe5+bHdixF7s5nMl6tD9r047wZJZGvK2p3vX0Wb1e0klGfW0hd545FVIL3Vwr01Jlz1rNbanehysjLuv0SHY3cni5yIjbzckUDIhDf3vJts/S8RK7Oazne1QS7ayN+Umj2sezvlJGU0GUYSr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlI25edCJMrwI5i/xYN1GyFQWtWDQ2bzm0XzJxP+xMU=;
 b=Xtc4o9iXwIxxvEdqwaUPeSSIyN9xe/+sAVhtR5jHQtpJnCMTdguXm017/pbQpFpRq4WBew3n8fL4/5XSEuNyy3vqKdKkfuCq2YYG7kciZQzkeR92llM3SqY6e8kJuLxmmK0G5I8KQJdfwQ6svjS4tih0404dpHtssFokdGyM4XU=
Received: from MN2PR05CA0032.namprd05.prod.outlook.com (2603:10b6:208:c0::45)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Tue, 22 Jul
 2025 22:39:23 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::48) by MN2PR05CA0032.outlook.office365.com
 (2603:10b6:208:c0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:17 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:17 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 04/25] drm/amd/display: Move setup_stream_attribute
Date: Tue, 22 Jul 2025 18:36:10 -0400
Message-ID: <20250722223911.2655505-5-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 62691532-6e99-4d0e-c93b-08ddc9709ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2UnwmC2gyI1Dog3nqMyiYdPHXhH9UTlh6U/o0wXj70rbwRlzMChc0RCfJxI8?=
 =?us-ascii?Q?K2RdPstt42RlQIkfMjsotEU8JMv5cJF5J3aXH91So0QGww3GjdjXJZtAXgCg?=
 =?us-ascii?Q?j7tePfYqVrVZrkYpvvAPDvSb2Qqs+L3qc/GbDWXfdRhyG3ugORuawWFBWpuU?=
 =?us-ascii?Q?e7X4+YpOloCYFQbdPYdJmRJaeGN7CBYpeQK8ErqAT9XVLLNgQonlyXWw53yy?=
 =?us-ascii?Q?rZflqILgpLIb/1nrBanlYf2l2r8gnfVF7hBHhRK3G82bLwmrHhR0XjnbtNxz?=
 =?us-ascii?Q?RQ7uy9IVTbor7977XJfKSnMAu0DdYnknoz7m366RIaEolRnl5g5hAlHYaSqV?=
 =?us-ascii?Q?yOJL0E/kUtDHPMAh9Ws0JlcUDkmtU+lZMbJI7HERcSbv2PTo35oIy7mzvqBL?=
 =?us-ascii?Q?OmGZIasQYEuwZ3KDapUIRJIR21H+tHeQoIxzYX1t01GFzgl4axVtHZlz4OsB?=
 =?us-ascii?Q?AJllaGUntNDfGPJWMovogzM5pRAW+0A5us2TDeWTPycBXFlg/G/kc2Dn+EKk?=
 =?us-ascii?Q?o1j2DEK3v5dKJN6FJM464727do46GxFfQVDaMQiTLuoDvdqrb13sqM5Wf9/+?=
 =?us-ascii?Q?zVOkw03uR3A4oujr7g1EF32sVc+H1RPq0Aqa9aOD5DMD96cDm+Tn1JenyVf+?=
 =?us-ascii?Q?+7Jq1V3cobeXQX2mkG35LgY8GkM43aTO2slDzpMHsJbtIFlny+rvZs4unHn/?=
 =?us-ascii?Q?sGdVtajpSrbrevw5v74X60OVXwdQK1ESWbsvYrx9V3grRji1dg6WO2V7HFPl?=
 =?us-ascii?Q?EbNy64eFN9cX4yDg/OIw2Igqu+Y1iMOo4eqFj+JQOKqbosR2TR8VJIkS+6RT?=
 =?us-ascii?Q?cCB318yDuapHKsvu//FhZlvo0SWwMYyTBf1cjbxbT7N7UoXOsVujp0PViKlj?=
 =?us-ascii?Q?a6PfaT/l1SVZSwUeyvKUhoc/4thOrHTwEQXcN0X2ParuusBAj0jeNcz8XwDl?=
 =?us-ascii?Q?eJp34IDD2xpHUY6ca4FdCNku7455B8KQ0aiVlspA0oaod+sfxOkndHsBk1hJ?=
 =?us-ascii?Q?Fe+ytzdT4XpeTT7fZKR4wEmmWSftpV7ElTZ+LqXkMX566GasUAU/ZDENcBiI?=
 =?us-ascii?Q?gOEp950Rh1d6WOjMb+lxUd5gX1/BgHYjiPZ6Pu7p9m2c4pqHwELUZoWdNNU/?=
 =?us-ascii?Q?bPzQzLJspyzx+vDS8qxU+P9lCmaaoFg7o0fffLBPYr8zweC+15LU7Rg+i4y+?=
 =?us-ascii?Q?x7DrgdE7s5csbSzFfZnKW6ZOgj4F5g5kR67ExMmLbno34oHo0SwVNByZOyEl?=
 =?us-ascii?Q?SpUufCilXnYoIg9YlNdTIiZAF7xNjsuWZ6xEd8VixgkjyL8WCl1Q/mGHNqa/?=
 =?us-ascii?Q?ZmABTH7moynxmHaWF0+QysQsoC2Rn3yzsrdBDnyj81xxRHM3Y+NfRlUTZIVC?=
 =?us-ascii?Q?/1mDl4J4mCiXktmUQ80KjGIKoTt27n0jCzmHTsxNt1hosp8NRn4qsSZdKDwV?=
 =?us-ascii?Q?17hrW6uNkCIKCOUlOj9b8dYcfkEZ3pvfdBOmZ8VXn58mZzC5N1sSE2iVg24s?=
 =?us-ascii?Q?QLhM0KrfHu1I3Hfr7rZffNgJEEmwJZTkvnRC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:22.8504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62691532-6e99-4d0e-c93b-08ddc9709ae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
If symclk RCO is enabled, stream encoder may not be receiving an ungated
clock by the time we attempt to set stream attributes when setting dpms
on. Since the clock is gated, register writes to the stream encoder fail.

[HOW]
Move set_stream_attribute call into enable_stream, just after the point
where symclk32_se is ungated.
Logically there is no need to set stream attributes as early as is
currently done in link_set_dpms_on, so this should have no impact beyond
the RCO fix.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c            | 3 ---
 .../drm/amd/display/dc/virtual/virtual_stream_encoder.c    | 7 +++++++
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4ea13d0bf815..62cdfee82956 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -671,6 +671,7 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 	uint32_t early_control = 0;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
 	dc->hwss.update_info_frame(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 3207addbd4eb..7d24fa1517bf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3054,6 +3054,8 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
+
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index cc9f40d97af2..fb949aeb1244 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -965,6 +965,8 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
+
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 8c8682f743d6..cb80b4599936 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2458,7 +2458,6 @@ void link_set_dpms_on(
 	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
-	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	bool apply_edp_fast_boot_optimization =
 		pipe_ctx->stream->apply_edp_fast_boot_optimization;
 
@@ -2502,8 +2501,6 @@ void link_set_dpms_on(
 		pipe_ctx->stream_res.tg->funcs->set_out_mux(pipe_ctx->stream_res.tg, otg_out_dest);
 	}
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
-
 	pipe_ctx->stream->apply_edp_fast_boot_optimization = false;
 
 	// Enable VPG before building infoframe
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index ad088d70e189..6ffc74fc9dcd 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -44,6 +44,11 @@ static void virtual_stream_encoder_dvi_set_stream_attribute(
 	struct dc_crtc_timing *crtc_timing,
 	bool is_dual_link) {}
 
+static void virtual_stream_encoder_lvds_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing)
+{}
+
 static void virtual_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
 	struct fixed31_32 avg_time_slots_per_mtp)
@@ -115,6 +120,8 @@ static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 		virtual_stream_encoder_hdmi_set_stream_attribute,
 	.dvi_set_stream_attribute =
 		virtual_stream_encoder_dvi_set_stream_attribute,
+	.lvds_set_stream_attribute =
+		virtual_stream_encoder_lvds_set_stream_attribute,
 	.set_throttled_vcp_size =
 		virtual_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
-- 
2.43.0

