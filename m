Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045CAECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400F310E835;
	Wed, 14 Sep 2022 05:13:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3206210E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk4btSLEj1q+02lMv7QGanYIozPC89WeINiipC7bABq9R7ihTiJJxE35fhtgRsAq0RITy5EkrdicJnETf4PKeMaPnvWLux9OOPHBIjQrZ1Wins6hd561x26ShjSqkWNAKWBw0Lt8bqFLNNTVcD9ZWyK6dp2vGBdEpNtWn87v3FrjVf/EsFNch5YGPCFAoNI3+XsAVdJjkg0AoveZ4WWK4xVyz1LEPmw6E6YaxlQLwmt0e0qWhgZ2MlsRw6eiKKiruHbmIEpvbUnKq0OPIpDlgJ8Qsy/q5D8QOajtlYHmQbQKHwcOo1abZNdLorUJUEXgAIOFsl6nRsJ4c8MXjCBZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlMBzCpKyJ37E99iEJJB4ZHNH31RV+ninyq9XTQFskU=;
 b=Iko6rriKJRagene+U74WbCNq1bJrLP2PnaM3BhB7g5Lco+/JcJG1Oyt6nqeKD4eICflYbTxQ6tJ2ShqnuJ9dCJOXXFBrmgmeY6D3FvJU7E3EccEaHqkAH3n+sN0iCAUQQYEY9077pM3fozCFbD89L6AMPXsfr3abYWaWSf7OrE28DSbSRQ98gmqaOqihZQbJEkBIxOlx2k2jKhgynA03hp8HXhnDEyKk/3329ouM4IRHaq+ckCMg5/EbM1Z6UkfHKmzxbkYq2REf5zYWkX4L+q/z3ntNQT20+kn82cQhuuFpm4bH+GUsi4psuvk2nvdHLh2TS+mqljCF/TKzj5RAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlMBzCpKyJ37E99iEJJB4ZHNH31RV+ninyq9XTQFskU=;
 b=BfOsIx9armyVzF/6ZuDnTeezaYyS2m8IXy+HVpF3lNm17QnCbECCp70+RaQ8tfIQt/NbszRNXmDE68lSX+1aA7XqTUNndnezHG0APF7EYQVRTGL/5jitPSCI2u2Q1Jnd8hfTdzKVn+Zk3oFREBj3R05Dm+0H7fWryzakSfS1Njc=
Received: from DM6PR11CA0030.namprd11.prod.outlook.com (2603:10b6:5:190::43)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 05:13:33 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::9f) by DM6PR11CA0030.outlook.office365.com
 (2603:10b6:5:190::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:13:32 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:13:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 13/47] drm/amd/display: Add debug option for allocating
 extra way for cursor
Date: Wed, 14 Sep 2022 13:10:12 +0800
Message-ID: <20220914051046.1131186-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6e7ce8-28b7-405c-ce02-08da960fdefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cz50PJe4a75lOGbhdGxpPwK8KBpX+eV8KbpCG+vkg0sbVZoH2NBJ2YyVD/hMcDAXjhMulotyZjeO9xUj5Z14IOAgIf5lx5up/JJgpAaHlCRmKEJY0/QvJNAiYsv6C95FC2zQSf3GdUNJdekKsZhkMSOmAB1u00bosh60Z2XXPzduT0KRy+N+wf38ssZUreTkmh22NMcrR4mxArA4TGDROIjj2Xn4BhReGSHg6D3OjO6pzA5B5+E9bgaUKN2XkOyC6NiwYR3QaOTya6qtcny83Wu633uGBh4Pq8/97VWcIg6Xc3hfNCSuCyXbmP+X0y0gL7poBBoG1ef6gBNvwwcfJFoC87+bXVlfzo7APsbrv0zktIV+Gt64oTHGgrA9SRXJZ+CCJm6fRXkYYeD1cZ9ZqCLf02EVlOLDdCUgnS04eGwYV2r9zGRPqg0SbYkYaVDqsMbTdRyEuD1DkOX3NyoVsrJtw69u+knyMxj+s7+tLh7QY6HKj1vX1TFtdZVOApm69aSpJyu6u4Wv8LMDjLHcjG5tzMNFxBfQXRb2XP7zpW/koHDau2Br0QPkjKNHnOBJ5CDpevBQ+8yNyagyxaFhJmAuYoJLNgoR6CY5nUXlGuYfK2wUyzxy6VPe1SyVFi7py2Xf9pFmW0V0x0v6/UatOW359U+dp3OLAtb3+V8wOX0Qk6V5hNjgzEMc5g68eP1n0qMnvpuqaZbffz4ZylJLni5I2GVLYRRPLNdbdVT9iV/HRSCHPqDWatK9EhthkuWgq4e5CtTTZHfJ9xR3X4rL96Q6dirJB/isBkqMfK2huyHbN+O2CurFSB6vts4gkvl4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(41300700001)(7696005)(478600001)(54906003)(6916009)(316002)(82310400005)(86362001)(83380400001)(36860700001)(356005)(81166007)(26005)(2616005)(47076005)(82740400003)(426003)(1076003)(186003)(336012)(36756003)(2906002)(40480700001)(8676002)(4326008)(70586007)(70206006)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:33.5103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6e7ce8-28b7-405c-ce02-08da960fdefd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
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
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why and How]
- Add a debug option for allocating extra way for cursor
- Remove usage of cache_cursor_addr since it's not gaurenteed
  to be populated
- Include cursor size in MALL calculation if it exceeds the
  DCN cursor buffer size (and don't need extra way for cursor)

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                    |  1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c     | 10 ++++++----
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn321/dcn321_resource.c    |  1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 53b13beff0b2..af726ffeb0d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -832,6 +832,7 @@ struct dc_debug_options {
 	bool force_subvp_mclk_switch;
 	bool allow_sw_cursor_fallback;
 	unsigned int force_subvp_num_ways;
+	bool alloc_extra_way_for_cursor;
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
 	bool disable_dtb_ref_clk_switch;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index c6d2a05ded3d..931dcf3e5ada 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -304,7 +304,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 				 * using the max for calculation
 				 */
 				if (hubp->curs_attr.width > 0) {
-					cursor_size = hubp->curs_attr.width * hubp->curs_attr.height;
+					// Round cursor width to next multiple of 64
+					cursor_size = (((hubp->curs_attr.width + 63) / 64) * 64) * hubp->curs_attr.height;
 					break;
 				}
 		}
@@ -325,7 +326,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 			break;
 		}
 
-		if (stream->cursor_position.enable && plane->address.grph.cursor_cache_addr.quad_part) {
+		if (stream->cursor_position.enable && !dc->debug.alloc_extra_way_for_cursor &&
+				cursor_size > 16384) {
 			cache_lines_used += dcn32_cache_lines_for_surface(dc, cursor_size,
 					plane->address.grph.cursor_cache_addr.quad_part);
 		}
@@ -345,8 +347,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 			plane = ctx->stream_status[i].plane_states[j];
 
 			if (stream->cursor_position.enable && plane &&
-				!plane->address.grph.cursor_cache_addr.quad_part &&
-				cursor_size > 16384) {
+					dc->debug.alloc_extra_way_for_cursor &&
+					cursor_size > 16384) {
 				/* Cursor caching is not supported since it won't be on the same line.
 				 * So we need an extra line to accommodate it. With large cursors and a single 4k monitor
 				 * this case triggers corruption. If we're at the edge, then dont trigger display refresh
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index d757d1638fa7..dad174a52449 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -720,6 +720,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.allow_sw_cursor_fallback = false,
+	.alloc_extra_way_for_cursor = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 60bf6e1b2972..1068230f16ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -720,6 +720,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.allow_sw_cursor_fallback = false,
+	.alloc_extra_way_for_cursor = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.37.3

