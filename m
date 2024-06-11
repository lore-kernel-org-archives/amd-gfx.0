Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37E8C27C78
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A97C10E6DB;
	Tue, 11 Jun 2024 16:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ABDEsppu";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8083910E6D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7hqxYrePOFe5OnBbmp8xwis+T46ol+5NrktlBAsrowreVFSX7vpcMafiW/REVrFRsqoGsUTH0pqOdL/5HKPVIEQHR35zfkJ2NAJQod9FB4kdOg02uUCz8/roa6RkvL9JTy2CaJxiDDjE0sE41uRCRuntXTvIfUq97yuOEJSZnih5Sb8It5yae6nRVg7BQkuQhFNz7Ci/a6elKdvkcyjDr3tuxlUuUx3XBmo1QZcSVY2OVfa+UCmU9zoOc+XE1bbQ8/YUi7dNp5JnZBWlm4XCH+p1zFEGJCzoDcyEImxeJqiAeU0+swmj+HKM36i8H1xwLOcX1XLDSGrL7ITJSMrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZp/XV2w6LgPscb+08aWZmJSB8IXeO+3zPsN/Gryw4k=;
 b=CWePelnPuO0XZ5HEaQO3LR86ZsPATSZ1mvFvXCI9zdHSHaTzo9i6dEFoCvKJEOSgVDARJmO/CyMZmJjjryxIm6n0UiADOTCKRxyd6SdqqfDUEMvaSEjmzWvNx/2/VO1znl4xIXSLBag1J9Xzn+DRFc23L4RsNKAvRci3QzYZeEPdB73uUg/cj5199zktTv3zw7fMOi4X1vZC+8423qkeGnYZGRULTI5SjR3CnzVmdr4DbWzVpRO2uZn66LOa8P1dwP/jVxSDfvPxZ0pclbFrzi5qw/pKoFLeUAQIZ1ntVHv/tP9P3l3cs/iE2R0saLzYSwCrTVO+//GHgfG6j5sy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZp/XV2w6LgPscb+08aWZmJSB8IXeO+3zPsN/Gryw4k=;
 b=ABDEsppu7ahsoBFducz7rRpCvwaTdUE2QqDyHW5JEVE95kOGY/gXuq1+lCr5ogaaZFfADljNQf3XTc4Q7URjum7AijTkNwkrKwc86MMjZ26em+SHS5JF3bmwxKzh0JoSmkmhjNFsq++ktKT9BnzMrlJ1dRqjaKwmimSDEjVccBc=
Received: from BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::31)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:42 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::a2) by BLAP220CA0026.outlook.office365.com
 (2603:10b6:208:32c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:40 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:37 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 20/36] drm/amd/display: Remove duplicate HWSS interfaces
Date: Tue, 11 Jun 2024 12:51:23 -0400
Message-ID: <20240611165204.195093-21-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1b176a-1e55-4b05-9645-08dc8a36e855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zMrR/Lnby1w0+j3YpZWaYISXuGbmRRXifqLFt2LonoeJxz9p5CtHB9u3aisl?=
 =?us-ascii?Q?Mw90+pphRYjQGy/ZL4gWgpSHdbULlhHcChLCt6BwkI1xQmLbm+9A8SCWHpsi?=
 =?us-ascii?Q?2gP3pNiXozPF1R+7n1wYdjMBg17D+SNED1Pjya53VWRB4QvJGgPlHyL8SSW+?=
 =?us-ascii?Q?UJTtMYfvIjDCcK84ZvIDAzpxtLgSRTWlcDq4kkaD+lCRmX8UvZ6MMEuHU9m4?=
 =?us-ascii?Q?qEW9Mb4Lp2+utDuCzJTVsg669rgmOChE0MDsbQtKGZ5EtRiiDUS/8KXzepzI?=
 =?us-ascii?Q?rZp1J2/q4ro8yeOB7uy9VBDf4ooNIrztfIH2qrvoAxdHmfH+a0zDje76yAOV?=
 =?us-ascii?Q?5PrM2RgOfuC7VcII9oFBY6eLY1Dk+IYhlEdYAaor8OfW04f4q7DWwfx4hqEH?=
 =?us-ascii?Q?8/LVs1RuWH8j1t6VEjM5s1FOsq2aQUUaz3NRxhxzto5hX7mdHwFzgw3jBPnS?=
 =?us-ascii?Q?vNIVYl1SthRca+HaMKNgNXgiueks/m4Rw4YdteMc4XJh/alOtpRUcRQWhBF/?=
 =?us-ascii?Q?0ZcyUZCWlw5EHaF2lGPubFgdwvoGx6kB9NnWNUDg8FjqUayOaEezEDUKCnce?=
 =?us-ascii?Q?38xa/PXZb2tzQzObJEauQLLRzlGMv3f55IQmcYOM+O3hHdEJfS7Y6Kxs3h12?=
 =?us-ascii?Q?0kQlmCncG4QQBel5MaibNENwHZTSOT0otxUAoiRbquwlIhXqkI847IqlADuw?=
 =?us-ascii?Q?UjXmJgWWZc+4jk3s7laPmEGN1x5Y+diHFBwkF8kApIoAlTAsVSkOSLu4gDDh?=
 =?us-ascii?Q?O95XFXbpG+QGQYKwK/h6xiShjoiM5Yqukuw5RzE46q5cAyhUu8Y0qFpZQnoW?=
 =?us-ascii?Q?zGGUl+lDwgSr6CFK/yITh5HNiv79wqS4M5oVzQO05yu9O5hDa+CEZE574/gW?=
 =?us-ascii?Q?21fsPENVtPMF4IGE3HxiZ+mS0wX8WJIebDAd4f53hAp27urVqZFWkJpOhpE+?=
 =?us-ascii?Q?9I8w5rRcTb9965arwWnQ7y0l86C+suU7dTPilXp5zBDzW7g2PM4LLvkHm41Z?=
 =?us-ascii?Q?czDLIPVSarBhUDorQHyXPo1erwVjZUR/l7i8t0bZfmWdIAwjR7TltvNXG66W?=
 =?us-ascii?Q?Re4ql5WNTMaLffwgrSFHodaLE6qsPuAvjb1Xl6tEMFa8ZmLdAkea1oizTQOL?=
 =?us-ascii?Q?zs6hcANod3IHTjqUyIvHl8WZF7sYQ+73t4T0TeQ38WpLliwNFcvqx1r3JFk/?=
 =?us-ascii?Q?/RrjWpPEgOpIegpdp4rLegCRFRozpoqdoXmIHlp3ZdHwGmE4tPiml7JpwHUZ?=
 =?us-ascii?Q?tFUT62KhubAvNNDgnc5Nu3Kxf37MlcgW7WlGJyKXQFWJsw9q6iv/VWzLY1JW?=
 =?us-ascii?Q?te6EK1c+LRYdpZ4D0K+MzQJxvEXOcg0+y9n2wVWTRC/VS2QE44dIMk/jT6f7?=
 =?us-ascii?Q?Tk5VgDsooBdJ5KBdqH/lLs7Ezx4cVGEg6lONZnJfutArPB3SHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:40.9464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1b176a-1e55-4b05-9645-08dc8a36e855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Some interface functions are defined in both the public and private HWSS
interfaces, which can lead to confusion and runtime issues, therefore
the duplicates should be eliminated.

[How]
 - power_down should only be private, because it's only used within HWSS
 - update_plane_addr should only be public, as it's used outside HWSS

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  1 -
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c |  1 -
 .../gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c   |  1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |  8 ++++----
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c |  1 -
 .../gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c   |  1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |  8 ++++----
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |  1 -
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  8 ++++----
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  8 ++++----
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |  2 --
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h     |  1 -
 .../gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h |  2 --
 21 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index f489371a3bc6..871f1e1ca2e0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3262,7 +3262,6 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
 	.init_pipes = init_pipes,
-	.update_plane_addr = update_plane_addr,
 	.set_input_transfer_func = dce110_set_input_transfer_func,
 	.set_output_transfer_func = dce110_set_output_transfer_func,
 	.power_down = dce110_power_down,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 0bfab66b8038..85f014cae6be 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1712,10 +1712,10 @@ void dcn10_power_down_on_boot(struct dc *dc)
 	if (edp_link && edp_link->link_enc->funcs->is_dig_enabled &&
 			edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 			dc->hwseq->funcs.edp_backlight_control &&
-			dc->hwss.power_down &&
+			dc->hwseq->funcs.power_down &&
 			dc->hwss.edp_power_control) {
 		dc->hwseq->funcs.edp_backlight_control(edp_link, false);
-		dc->hwss.power_down(dc);
+		dc->hwseq->funcs.power_down(dc);
 		dc->hwss.edp_power_control(edp_link, false);
 	} else {
 		for (i = 0; i < dc->link_count; i++) {
@@ -1723,8 +1723,8 @@ void dcn10_power_down_on_boot(struct dc *dc)
 
 			if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
 					link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-					dc->hwss.power_down) {
-				dc->hwss.power_down(dc);
+					dc->hwseq->funcs.power_down) {
+				dc->hwseq->funcs.power_down(dc);
 				break;
 			}
 
@@ -2929,7 +2929,7 @@ static void dcn10_update_dchubp_dpp(
 
 	hubp->power_gated = false;
 
-	hws->funcs.update_plane_addr(dc, pipe_ctx);
+	dc->hwss.update_plane_addr(dc, pipe_ctx);
 
 	if (is_pipe_tree_visible(pipe_ctx))
 		hubp->funcs->set_blank(hubp, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
index a5bdac79a744..5e51e1761707 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
@@ -78,7 +78,6 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.get_clock = dcn10_get_clock,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
@@ -92,7 +91,6 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn10_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.program_pipe = dcn10_program_pipe,
 	.update_mpcc = dcn10_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index d60941495fd3..09376c367c14 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1821,7 +1821,7 @@ static void dcn20_update_dchubp_dpp(
 			params.subvp_save_surf_addr.subvp_index = pipe_ctx->subvp_index;
 			hwss_subvp_save_surf_addr(&params);
 		}
-		hws->funcs.update_plane_addr(dc, pipe_ctx);
+		dc->hwss.update_plane_addr(dc, pipe_ctx);
 	}
 
 	if (pipe_ctx->update_flags.bits.enable)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index ef6488165b8f..32707b344f0b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -105,7 +105,6 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn20_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
index a13bf6c9386e..78351408e864 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
@@ -96,7 +96,6 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 
 static const struct hwseq_private_funcs dcn201_private_funcs = {
 	.init_pipes = NULL,
-	.update_plane_addr = dcn201_update_plane_addr,
 	.plane_atomic_disconnect = dcn201_plane_atomic_disconnect,
 	.program_pipe = dcn10_program_pipe,
 	.update_mpcc = dcn201_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
index 3dfac372d165..e044e9e0a3a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
@@ -93,7 +93,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -109,7 +108,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn20_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 4c4706153305..9ef38a3759b1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -728,10 +728,10 @@ void dcn30_init_hw(struct dc *dc)
 		if (edp_link && edp_link->link_enc->funcs->is_dig_enabled &&
 				edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 				dc->hwss.edp_backlight_control &&
-				dc->hwss.power_down &&
+				hws->funcs.power_down &&
 				dc->hwss.edp_power_control) {
 			dc->hwss.edp_backlight_control(edp_link, false);
-			dc->hwss.power_down(dc);
+			hws->funcs.power_down(dc);
 			dc->hwss.edp_power_control(edp_link, false);
 		} else {
 			for (i = 0; i < dc->link_count; i++) {
@@ -739,8 +739,8 @@ void dcn30_init_hw(struct dc *dc)
 
 				if (link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-						dc->hwss.power_down) {
-					dc->hwss.power_down(dc);
+						hws->funcs.power_down) {
+					hws->funcs.power_down(dc);
 					break;
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index 4b32497c09d0..2a8dc40d2847 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -113,7 +113,6 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index 97e33eb7ac5a..93e49d87a67c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -111,7 +111,6 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 9cb7afe0e731..b57dd45611f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -116,7 +115,6 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 7a8db4b81471..fe5495a8e7a2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -100,7 +100,6 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -119,7 +118,6 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 
 static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 0d27eec724b4..732da5e5c1ba 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -901,10 +901,10 @@ void dcn32_init_hw(struct dc *dc)
 				if (edp_link->link_enc->funcs->is_dig_enabled &&
 						edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 						dc->hwss.edp_backlight_control &&
-						dc->hwss.power_down &&
+						hws->funcs.power_down &&
 						dc->hwss.edp_power_control) {
 					dc->hwss.edp_backlight_control(edp_link, false);
-					dc->hwss.power_down(dc);
+					hws->funcs.power_down(dc);
 					dc->hwss.edp_power_control(edp_link, false);
 				}
 			}
@@ -914,8 +914,8 @@ void dcn32_init_hw(struct dc *dc)
 
 				if (link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-						dc->hwss.power_down) {
-					dc->hwss.power_down(dc);
+						hws->funcs.power_down) {
+					hws->funcs.power_down(dc);
 					break;
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 5c50458b12cb..968b010971ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -124,7 +124,6 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 0602921399cd..d894c52bfdaf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -629,10 +629,10 @@ void dcn35_power_down_on_boot(struct dc *dc)
 	if (edp_link && edp_link->link_enc->funcs->is_dig_enabled &&
 			edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 			dc->hwseq->funcs.edp_backlight_control &&
-			dc->hwss.power_down &&
+			dc->hwseq->funcs.power_down &&
 			dc->hwss.edp_power_control) {
 		dc->hwseq->funcs.edp_backlight_control(edp_link, false);
-		dc->hwss.power_down(dc);
+		dc->hwseq->funcs.power_down(dc);
 		dc->hwss.edp_power_control(edp_link, false);
 	} else {
 		for (i = 0; i < dc->link_count; i++) {
@@ -640,8 +640,8 @@ void dcn35_power_down_on_boot(struct dc *dc)
 
 			if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
 					link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-					dc->hwss.power_down) {
-				dc->hwss.power_down(dc);
+					dc->hwseq->funcs.power_down) {
+				dc->hwseq->funcs.power_down(dc);
 				break;
 			}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 428912f37129..55dc5799e725 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -101,7 +101,6 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -128,7 +127,6 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.init_pipes = dcn35_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 55e791552bca..b1b2a58684e7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -100,7 +100,6 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -127,7 +126,6 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.init_pipes = dcn35_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ef0a42f2933d..0fafbec442b1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -354,10 +354,10 @@ void dcn401_init_hw(struct dc *dc)
 				if (edp_link->link_enc->funcs->is_dig_enabled &&
 						edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 						dc->hwss.edp_backlight_control &&
-						dc->hwss.power_down &&
+						hws->funcs.power_down &&
 						dc->hwss.edp_power_control) {
 					dc->hwss.edp_backlight_control(edp_link, false);
-					dc->hwss.power_down(dc);
+					hws->funcs.power_down(dc);
 					dc->hwss.edp_power_control(edp_link, false);
 				}
 			}
@@ -367,8 +367,8 @@ void dcn401_init_hw(struct dc *dc)
 
 				if (link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-						dc->hwss.power_down) {
-					dc->hwss.power_down(dc);
+						hws->funcs.power_down) {
+					hws->funcs.power_down(dc);
 					break;
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 1cf0608e1980..067cdd1f5f38 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -98,12 +98,10 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.fams2_global_control_lock = dcn401_fams2_global_control_lock,
 	.fams2_update_config = dcn401_fams2_update_config,
 	.fams2_global_control_lock_fast = dcn401_fams2_global_control_lock_fast,
-	.power_down = dce110_power_down,
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index e9b85884edce..91becbc8e862 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -233,7 +233,6 @@ struct hw_sequencer_funcs {
 	void (*program_triplebuffer)(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx, bool enableTripleBuffer);
 	void (*update_pending_status)(struct pipe_ctx *pipe_ctx);
-	void (*power_down)(struct dc *dc);
 	void (*update_dsc_pg)(struct dc *dc, struct dc_state *context, bool safe_to_disable);
 
 	/* Pipe Lock Related */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 7ac3f2a09487..87c75db10086 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -76,8 +76,6 @@ struct hwseq_private_funcs {
 	void (*enable_stream_gating)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*init_pipes)(struct dc *dc, struct dc_state *context);
 	void (*reset_hw_ctx_wrap)(struct dc *dc, struct dc_state *context);
-	void (*update_plane_addr)(const struct dc *dc,
-			struct pipe_ctx *pipe_ctx);
 	void (*plane_atomic_disconnect)(struct dc *dc,
 			struct dc_state *state,
 			struct pipe_ctx *pipe_ctx);
-- 
2.45.1

