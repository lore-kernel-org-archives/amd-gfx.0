Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0D0ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A69D10E806;
	Wed, 14 Sep 2022 03:51:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C7110E805
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mfk525xbxjMB9YLFjD8v9jisM1TM1740eswUe6ofLwxBKVRrUFLsLwSSTRe8IdCD6l67kELvQca2V5lGDmmZVJ+0wBH7jb9xaHbM3eIuN+JIL+l+MlpzjQcDHlBbk2+yk4z2mY7LpQHpm0EhFAnNJvRAl2usaMzm3fy3PHrAUVgmrnFm/bryOKyXykobZS2xouI9FNhIaYJ17eG5/xPcNXvrSDy7FnaWXt9B3eVEwqCR6CqrX1ve2GcjGy0i2Lrk6MjCJEV4nPS8puLJq7O6myh3silL0R3wwBY9/Hhu5fNz56quKQBW40Phud6je+iFIIOtsqm5QO8R5Ka3uzP5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlMBzCpKyJ37E99iEJJB4ZHNH31RV+ninyq9XTQFskU=;
 b=Y+klWeiU+JiIv1zCYZEtBDkECocUfgf+e+lDWpf0lDqreZX8RtXVYT98veCRJc5mICN+InP3cRejUHQ6qTGnfUknfZKAsXNz8iIuf1tQVdPd7QMC0F5yiA89fJnmh7zzWPsj1d1FeDCfToOW21KrCR0Dur09jMJdbgxiUFMgG2fu7jbtTz+rKpwFs6AoCKn8E3OFuKJzr1WBbKYFunptYbbjZxPL6Xu3JV5AxmHlZt/VkQWeGzV2s44v+JdUSC7/rZQGKnQR1sch70VEESx6R5RO524JZZs+upBgO7pcOdTqswVTuVqUTUlNLVPlcF3hE7FNtaTK/5b8aVjYHH7JJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlMBzCpKyJ37E99iEJJB4ZHNH31RV+ninyq9XTQFskU=;
 b=yuPBffdAQf119PkIr3Akkq8JqyZrKpwA/wsNti+KHJrZwxMnSoutyY5zJgDSyxuF43a/s5cYUBcnU6Y23okz6HmL2rcJaUOSRo8uUxH2vYZ4fikDdMFcY//S5Ps61HzuepRjEnDxaKV12S6ZlPrlLk/O4TSKD2tgOGvif51ZsV0=
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Wed, 14 Sep
 2022 03:50:58 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::41) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Wed, 14 Sep 2022 03:50:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:50:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:50:56 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:50:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 13/47] drm/amd/display: Add debug option for allocating
 extra way for cursor
Date: Wed, 14 Sep 2022 11:47:34 +0800
Message-ID: <20220914034808.1093521-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 1034d0cc-be6e-4485-b557-08da96045526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LkIZP98tkd0Gu4Gbf7KGymLvFZ5oCY/3VlU1ju2eqml+gV1/QuHA1O2jtXKSlbOrgEDUJ4ViqQ1xdHWBs8diOA9AJ4ed+9oMXineBpEHkRNkK5j5kO6Kktj87frWEU4GaIeLHblQD8r5GwO5kzK3ilws74YAPKSfXJ0tZm8SvJZGrXGU7/JEbcgFVQRWhZY+lfu0hi3amPrHrl3qQAnAbkOtauvLOlYC+EBlbHcuZQjYFU9/F4N7119s+0EjQL2MRUi3t2H0v2P3r/KzNjg/9aLJRneISambrjaKkQe0rCN2qXDa+5+IPKaHQgPuKb9wNq89Zin9r8UUFAV3x5G6jxYU9ejGM083V4zsa+iX0pRGduacL9KwBB88ES6VZH8pojzr3pn7uIH3pwzSBxO+rxIsRzZlKpufTaFBtSQzYD0YBAQmML7CWGk27ndEIk0dsiJOP+GDdWDdShGpmqmw4mFA5Lhq+LhlxkPUKqt0nASTR91Hi+v42z0frbdDP5Xttpgqqb3GvQxPpmvDelTubXOCAcn7F5W/OYRelfnrG+aXeB3TJAYeYrYFYFoi8Z3stZen1O3jqxzyHM7kt9JD3uDspmDl1nQKyY5I9VbBu1VFeC95TxsjCIC2dk8Cz28nBb/O7UB9gcy9iyZqC4p11NVmpAHgJbZm1nZs5kC/teuy9Ri0Fz7JvIE28LzuCls64o2digNl2nuW0p67cWbE5vxF4QGAt2roOoWUgXq8xFl7FZaqui+aHUYs0irwBk1/e+AUyshojKL/HprLdo/Vx9K/Xg0xtYeTw16TdbHEFC5sgtGE5o3eXGJ28EL1Se6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(2616005)(82740400003)(40460700003)(8676002)(2906002)(36756003)(86362001)(47076005)(54906003)(186003)(40480700001)(82310400005)(356005)(1076003)(83380400001)(8936002)(336012)(7696005)(5660300002)(426003)(36860700001)(6916009)(6666004)(81166007)(70586007)(316002)(70206006)(41300700001)(26005)(478600001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:50:57.8044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1034d0cc-be6e-4485-b557-08da96045526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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

