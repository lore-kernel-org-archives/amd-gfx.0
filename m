Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9301CE7F13D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F46D10E446;
	Tue, 26 Sep 2023 21:54:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C99510E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsHAuhpuLI8X3zMOF5uXR+8tXrFz189J0pKC5Vx4TMj22NzH3welazTOtW5iAdA3d7PdEFNl4vOJ7Z8th7ug/BtQX6j6f0ik+KXhX/bR05LQt1Hdrrv6sZdWBM9Jvi4qtmVTjZNb3xpI9ULV9+FtrdeKlPG3pfNWk3XlExDLPWR1I5jT2qgHyVcyhPqNXKqmwSwaVchMkoB2CV2R/eyl3UbXrEESmarMr3R5C9/u8L6bJQv+2XKRpj/Q0xIQnosMjmu+QWPqPEOD/kBvT83AlfLCWmlmSKiduo3CZ0ador7DzinIZxronQmmpx3sEiImLcVF56NKt5dm/60Ps6dSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWTmfOfyy2e6V/YXi5kiLzqyjdPsoZTNCJrGwRUynJI=;
 b=UFZay5ThRPP5h4kdd28Nt4PipXAFELWPhhfTIoZ8YmsLvMovv9z5vEaw7Ai0gFLmdrKLIe/DQbkv4/cBCAbKneFi5SzgXyitEZXCXZXzeMFyQbxa/CNl2j3qUb3bzZyUefx4zZkVuvTVPFVv9ywxikv4BSE7XaoKnntQJ8VYAAVj/piqO8mTmWLkxHTzZM8ES/zgGkNcdg7u+H7eW+JybfXkxN39ZNNhEn7p+fDi4queMFn0yyGwLtwqEgeMFvHwRhCdrZE6wxUC7SkZymd3aXsO9US/H1+EY9H8cSGDOCuTGtMnIRK+tTdzja0dlpOaw2MpghRFnPhSrr6oMqwbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWTmfOfyy2e6V/YXi5kiLzqyjdPsoZTNCJrGwRUynJI=;
 b=fsvTA1hM4TR65wK3Q1DQfQi6GFrJodBNyTwEihmQAfYU6MZyh8UC9u8JOkLhOHkMoU03rcT6Wq/FbMvJZXtEy1zeQMh8Jk5jYVOUYwGN80HdE8mDw54WDJXI5JZMLdOQWfz3Xb2ghIfqa58OH4asSvxKvQ6vnptPDAJaBd4WqNQ=
Received: from DS7PR05CA0039.namprd05.prod.outlook.com (2603:10b6:8:2f::16) by
 PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Tue, 26 Sep 2023 21:53:53 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::c6) by DS7PR05CA0039.outlook.office365.com
 (2603:10b6:8:2f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:51 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:51 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: use full update for clip size increase
 of large plane source
Date: Tue, 26 Sep 2023 17:47:00 -0400
Message-ID: <20230926215335.200765-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b85eb4b-9d3e-48b6-aef1-08dbbedb12da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wZGVLHv9A8WwVB9sN3Pp0c9TEKd8AvGlY+771RZF5hF0l2ZzOD7m88+myd8232KNXx+pnTUjcHfQ4NL6yGgcn/PvY6XQZE33oVLrkKqBakehMJFnc3LVlRTeMhSDjc1uQzVD9Zq6pmsEN4+EB5KOGb6+AXqPqNvH6N3FyqKkwWKYsqBAJ0KOg4Gu8BJ3HhQP+C3lGd0D2UvPyMaBT/Ba9BLMu4G4TJTA6to8gFk9qEQJJOuoc2i889YaaU2kIvl3eZIclhWMHQCsVI2RQt8F2Cxkf9LcbJmH+Wb0KHAH413jpH/flgp3wf4g0ttbma7d5haR+8cUV+IciVEaFRxw6Px2mGPzqux5uVqZCpuJTCMpsivmnQLfG4RO/Vm/p9Jy4ycbFu77xYCZmRE24bMyJdNmzJ99avmiA3wFiZnPvTA9WbliuvV6TP0BvIpmDKBL0eUfM6rbes7qRAqxLiJiNagjSrl+RlWgA9PnHwrI+IebxGNtBeD6eNu0a4kGrUQmtRKIRj2i6P22vNdNcpIWF19rXpp7MRA/PCXfiJCdysAhFQG+38jcqSNTMozyHsqaONM94dzfGu5M36xs22hdK/v3LFG/9+QsOUuUJ17bvHcsXxEYjHgBq8Q74tkTywq1mFc6h+lBBQm2gq0x3bTzV6yUGuwfEgWQWoDtuLqoi5IfJ0uNKyUbB9hrgKW3MMXMnE1NE1SsC5EeagrkGUX20NZ1ree+BB2yNFjosexC0bfK0HBp+S2ZslMgpHQI5ieU4URhXz3Fjnuuw+xY8LvUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(26005)(40480700001)(82740400003)(36756003)(6666004)(7696005)(8676002)(83380400001)(336012)(426003)(2616005)(2906002)(1076003)(15650500001)(478600001)(4326008)(5660300002)(6916009)(41300700001)(70586007)(316002)(8936002)(44832011)(70206006)(81166007)(40460700003)(86362001)(47076005)(356005)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:52.5712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b85eb4b-9d3e-48b6-aef1-08dbbedb12da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Clip size increase will increase viewport, which could cause us to
switch  to MPC combine.
If we skip full update, we are not able to change to MPC combine in
fast update. This will cause corruption showing on the video plane.

[how]
treat clip size increase of a surface larger than 5k as a full update.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 15 +++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h      |  5 +++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4508904bbca1..8beb7324c421 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1003,7 +1003,8 @@ static bool dc_construct(struct dc *dc,
 	/* set i2c speed if not done by the respective dcnxxx__resource.c */
 	if (dc->caps.i2c_speed_in_khz_hdcp == 0)
 		dc->caps.i2c_speed_in_khz_hdcp = dc->caps.i2c_speed_in_khz;
-
+	if (dc->caps.max_optimizable_video_width == 0)
+		dc->caps.max_optimizable_video_width = 5120;
 	dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc->res_pool->dccg);
 	if (!dc->clk_mgr)
 		goto fail;
@@ -2394,6 +2395,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 }
 
 static enum surface_update_type get_scaling_info_update_type(
+		const struct dc *dc,
 		const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
@@ -2426,6 +2428,15 @@ static enum surface_update_type get_scaling_info_update_type(
 			update_flags->bits.clock_change = 1;
 	}
 
+	if (u->scaling_info->src_rect.width > dc->caps.max_optimizable_video_width &&
+			(u->scaling_info->clip_rect.width > u->surface->clip_rect.width
+			|| u->scaling_info->clip_rect.height > u->surface->clip_rect.height))
+		/*
+		 * Changing clip size of a large surface may result in MPC slice
+		 * count change
+		 */
+		update_flags->bits.bandwidth_change = 1;
+
 	if (u->scaling_info->src_rect.x != u->surface->src_rect.x
 			|| u->scaling_info->src_rect.y != u->surface->src_rect.y
 			|| u->scaling_info->clip_rect.x != u->surface->clip_rect.x
@@ -2463,7 +2474,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	type = get_plane_info_update_type(u);
 	elevate_update_type(&overall_type, type);
 
-	type = get_scaling_info_update_type(u);
+	type = get_scaling_info_update_type(dc, u);
 	elevate_update_type(&overall_type, type);
 
 	if (u->flip_addr) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a907cd620e10..51272f895c24 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -231,6 +231,11 @@ struct dc_caps {
 	uint32_t dmdata_alloc_size;
 	unsigned int max_cursor_size;
 	unsigned int max_video_width;
+	/*
+	 * max video plane width that can be safely assumed to be always
+	 * supported by single DPP pipe.
+	 */
+	unsigned int max_optimizable_video_width;
 	unsigned int min_horizontal_blanking_period;
 	int linear_pitch_alignment;
 	bool dcc_const_color;
-- 
2.42.0

