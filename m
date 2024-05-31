Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2992BC27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 679FE10E1D8;
	Fri, 31 May 2024 16:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hpvhtWs0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693C510E111
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6awGIvOehtK/NQNZ7V/iQREZ03QQREopIk/99HE0TxBFQatxNVlMlz+vVmQGAkZXenw3IyOmnb9C2WMImcZcJNx9gqQYlyG4FEx+vxxb2UXHyjzIUug+/HDmIECy66a6HsOfAICRecx4103hpOTMqIGvrKKgSU+jAshkpMt/RlMsurCTRP3QAKe2dMptv9XKfIi7xxZr8eYlTZZcktMqCsryqulc1AsUStdaQSjENm71lGTEHzVDTu8PJtWFqcywhz6vWukYNYVYc6DjOVjZdlTvd7/Rdq0CnF01GbkcZSOlF4nyeQkiOKXYtBcHAF24b1kI4eLM8PXTkw9eS3+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD1YX0jjJalRJyCrKb8k33rZGdeRAamQMzuhL664S0w=;
 b=ijYeOkuvd8XUWY2OAFe9nH8Cy8VkEv2w3+UziOpIv3vxCj/2UFRs+ngcTM5LusOibFWdEmiLXApWztOT68itDyBqbIvwZxVPniglhxyiOklWtex0ndxJ0RIhqxdqtZqHMw0grUnkJUpSJBuZbXlryNm76wrHvYZpgS0dKqaTqbfzHSnFySvyEbiE/Dy7Pc+q0QRDTMo4TjmQRb93sTTUx2+aYXSTOk1x38lKaklYCveayc7DB50Tnlh02xy3T9PQob9q09GB27yECXmAXVw9iMkcyhfxHqfVsNdxejmNoBZDkSJFxbh/Uz2xBte9Qt/r1tcj9ZAv6WVTTm0cbXJr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD1YX0jjJalRJyCrKb8k33rZGdeRAamQMzuhL664S0w=;
 b=hpvhtWs0URlT8fNbt2oeO4/QVI1m221Zy3nm4Js61msvqgCPhb63J/O5HFv9BnW+hSH+rRltuZHvhTBLo6vyRlOANoAutnVKl7S3HI/oA7wsXxPSrbiMlLhld5A5RjshZMR6AfhvkNbd0BSpC6+zDFVRwfVkCl9s0NECEdPdJhs=
Received: from PH7PR10CA0005.namprd10.prod.outlook.com (2603:10b6:510:23d::11)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 16:52:24 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::1a) by PH7PR10CA0005.outlook.office365.com
 (2603:10b6:510:23d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:23 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:21 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, yi-lchen <yi-lchen@amd.com>, Jun Lei <jun.lei@amd.com>,
 Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 01/32] drm/amd/display: Keep VBios pixel rate div setting
 until next mode set
Date: Fri, 31 May 2024 12:51:14 -0400
Message-ID: <20240531165145.1874966-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2c6486-3609-4a50-f35d-08dc81920b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?La/q4Ewj4EnXRPNH0onxu07W3KwXu03p4YXax3uDMfWs+XATlXlcNDBo/eqf?=
 =?us-ascii?Q?pRwtqnvuRb8oadRt0GvFyxDst4e3/kb2PtquFoUcq1ifMYqVnGn+Qu/gECUc?=
 =?us-ascii?Q?mE8bHeyMRYWwfJeezLy5RtaKZ7cQTDFoNoQhcmp75BATgKLOBGXocaurf/yk?=
 =?us-ascii?Q?WolCp5O+Gv5DktTHvaqtYPU70H8neTTgaMlbB9ZUPlqmdavyhKna59v+2Yh2?=
 =?us-ascii?Q?cgEjKdgflK9/HiKu7Mx0W+pGfPr+AQhdoK2vWSYlv2H43vv3z9nfjkiFLFji?=
 =?us-ascii?Q?uzBIZcIMZYP54XC00ot6aAR+LL8L2s4O1vOsOmRaN5iUE50OBKULKHGyGk1T?=
 =?us-ascii?Q?TVeqE7wjL1kIZ184FtYNl7mG04NfboQ2yNcifNmhLD6uJ1EI4og0Jc83WsLl?=
 =?us-ascii?Q?2LtoRMTyYDgEHosimwqw9cDOh5lGo9ObkWkW89x8cCbHiiT8VB0u0kCGMbHr?=
 =?us-ascii?Q?iyfdF3CksHR2inALfQkmN1Oe6Bia9aUJHyrm9FLzIgFMASM3q0sLby/+uySO?=
 =?us-ascii?Q?xut1EfU+cPfUOYEY/AgF5I6Tdo8+v728Vh893d5ms9VeGe1h3x/IK8rcByRU?=
 =?us-ascii?Q?r2pA1DWWeBeNq9EpsCrdnq96Xx2u05ngzLkkKkEruKHY7i0yklAcINCHu0RP?=
 =?us-ascii?Q?VDR3BHUJ1usWpHBBXO/T08qs/L9iOdKQI3l53BKaivGmd/EXbMjeerYslWzc?=
 =?us-ascii?Q?ZgU/W0QmxA6QFZKnvDURSURBu+pYG1zMceBWeyZWIwiEGDnGKOs9q+cZP8C3?=
 =?us-ascii?Q?RW2Z4kfqT9qReOQw19L5MpF8R4AO9rg1EUixb6g3PfHuD4r7702hVIzPjkgY?=
 =?us-ascii?Q?UC7uFtfYgrlWTPiLOON5r5nQDkTv1v/3tCuFfabTOSUgjjYyycN8JULdiG8u?=
 =?us-ascii?Q?/g4nQUFAVhN7b+YOvHCQ91PdAgPa05WIcqtomkrZQDjbSvUpV/u813qqZxiU?=
 =?us-ascii?Q?2poSn6OQeDLJlW0I/agY7tUgHGhyHOdA6bpswrPt2cEv52r4pPgRBkoSSKGv?=
 =?us-ascii?Q?xdQAvDqup+WdKR+TeYZlDb7ASRZLDCPsSwUp1w5tS9Imr9BI+ew+K2+yWqYD?=
 =?us-ascii?Q?OJ5pqcHq1rQ2r4EjoN303KLw2g0Wp+OQSk11ktSuFT6kPQ3zmNcyFTycPhIN?=
 =?us-ascii?Q?DdrrimA81W83737YlHgqxDazgbRtqkZGwjjgFovKIi3ZQE4r4BXmmtKb9F9O?=
 =?us-ascii?Q?wYufdd7rE24bKUXQUYlElBNzlJg2+wj2UnFQtX7jRPBGgnYurgc4L0zxMYwn?=
 =?us-ascii?Q?G4KLigJNYCf9RAQYwAVXdIQNJrVishEI/iXGyWMnvP3CINw3uro5MU0TZfSW?=
 =?us-ascii?Q?maNE4J4MpMIc1p000eWqEks5YK5TQgUd1EjA6DUEKtH4zvUZyPEJNtnYtA2G?=
 =?us-ascii?Q?bjQE9y0if4h8q9mEYxCoDj8EBpI/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:23.6055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2c6486-3609-4a50-f35d-08dc81920b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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

From: yi-lchen <yi-lchen@amd.com>

[why]
Vbios & Driver have difference pixel rate div policy.
When enabling fast boot & performing blank & unblank w/o timing setting,
pixel clock & pixel rate dividor are not match.
It would cause too high pixel reate and eDP would be black screen.

[How]
We would keep pixel rate div setting by Vbios until next timing setting.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: yi-lchen <yi-lchen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  6 +++
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  | 12 +++---
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    | 12 +++---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 13 +++---
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  5 ++-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 40 ++-----------------
 .../dc/dcn35/dcn35_dio_stream_encoder.c       | 36 +----------------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 24 +++++++++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 23 +++++------
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 21 ++++++++++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |  2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 33 ++++++++++++---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  3 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  6 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  5 +++
 20 files changed, 136 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index beca40f8694f..dc236264d9b3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3969,6 +3969,12 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 
 	res = dc_validate_global_state(dc, context, fast_validate);
 
+	/* calculate pixel rate divider after deciding pxiel clock & odm combine  */
+	if ((dc->hwss.calculate_pix_rate_divider) && (res == DC_OK)) {
+		for (i = 0; i < add_streams_count; i++)
+			dc->hwss.calculate_pix_rate_divider(dc, context, add_streams[i]);
+	}
+
 fail:
 	if (res != DC_OK)
 		DC_LOG_WARNING("%s:resource validation failed, dc_status:%d\n",
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
index 17a1174b8d80..8f6edd8e9beb 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
@@ -58,8 +58,8 @@ static void dccg314_trigger_dio_fifo_resync(
 static void dccg314_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		enum pixel_rate_div *k1,
-		enum pixel_rate_div *k2)
+		uint32_t *k1,
+		uint32_t *k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
@@ -93,8 +93,8 @@ static void dccg314_get_pixel_rate_div(
 		return;
 	}
 
-	*k1 = (enum pixel_rate_div)val_k1;
-	*k2 = (enum pixel_rate_div)val_k2;
+	*k1 = val_k1;
+	*k2 = val_k2;
 }
 
 static void dccg314_set_pixel_rate_div(
@@ -104,7 +104,8 @@ static void dccg314_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k1 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k2 = PIXEL_RATE_DIV_NA;
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
@@ -373,6 +374,7 @@ static const struct dccg_funcs dccg314_funcs = {
 	.disable_dsc = dccg31_disable_dscclk,
 	.enable_dsc = dccg31_enable_dscclk,
 	.set_pixel_rate_div = dccg314_set_pixel_rate_div,
+	.get_pixel_rate_div = dccg314_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg314_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg314_set_valid_pixel_rate,
 	.set_dtbclk_p_src = dccg314_set_dtbclk_p_src
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
index 56385cede113..21a6ca5ca192 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
@@ -58,8 +58,8 @@ static void dccg32_trigger_dio_fifo_resync(
 static void dccg32_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		enum pixel_rate_div *k1,
-		enum pixel_rate_div *k2)
+		uint32_t *k1,
+		uint32_t *k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
@@ -93,8 +93,8 @@ static void dccg32_get_pixel_rate_div(
 		return;
 	}
 
-	*k1 = (enum pixel_rate_div)val_k1;
-	*k2 = (enum pixel_rate_div)val_k2;
+	*k1 = val_k1;
+	*k2 = val_k2;
 }
 
 static void dccg32_set_pixel_rate_div(
@@ -104,7 +104,8 @@ static void dccg32_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k1 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k2 = PIXEL_RATE_DIV_NA;
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
@@ -343,6 +344,7 @@ static const struct dccg_funcs dccg32_funcs = {
 	.otg_add_pixel = dccg32_otg_add_pixel,
 	.otg_drop_pixel = dccg32_otg_drop_pixel,
 	.set_pixel_rate_div = dccg32_set_pixel_rate_div,
+	.get_pixel_rate_div = dccg32_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg32_trigger_dio_fifo_resync,
 	.set_dtbclk_p_src = dccg32_set_dtbclk_p_src,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 1fc3aa2b507b..68cd3258f4a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -146,8 +146,8 @@ static void dccg35_set_dppclk_root_clock_gating(struct dccg *dccg,
 static void dccg35_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		enum pixel_rate_div *k1,
-		enum pixel_rate_div *k2)
+		uint32_t *k1,
+		uint32_t *k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
@@ -181,8 +181,8 @@ static void dccg35_get_pixel_rate_div(
 		return;
 	}
 
-	*k1 = (enum pixel_rate_div)val_k1;
-	*k2 = (enum pixel_rate_div)val_k2;
+	*k1 = val_k1;
+	*k2 = val_k2;
 }
 
 static void dccg35_set_pixel_rate_div(
@@ -192,7 +192,9 @@ static void dccg35_set_pixel_rate_div(
 		enum pixel_rate_div k2)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k1 = PIXEL_RATE_DIV_NA;
+	uint32_t cur_k2 = PIXEL_RATE_DIV_NA;
+
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
@@ -1018,6 +1020,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.disable_dsc = dccg35_disable_dscclk,
 	.enable_dsc = dccg35_enable_dscclk,
 	.set_pixel_rate_div = dccg35_set_pixel_rate_div,
+	.get_pixel_rate_div = dccg35_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg35_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg35_set_valid_pixel_rate,
 	.enable_symclk_se = dccg35_enable_symclk_se,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index a496a250f892..3538e190f217 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -119,7 +119,7 @@ static void dccg401_wait_for_dentist_change_done(
 static void dccg401_get_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
-		enum pixel_rate_div *tmds_div,
+		uint32_t *tmds_div,
 		uint32_t *dp_dto_int)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -161,7 +161,7 @@ static void dccg401_set_pixel_rate_div(
 		enum pixel_rate_div unused)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	enum pixel_rate_div cur_tmds_div = PIXEL_RATE_DIV_NA;
+	uint32_t cur_tmds_div = PIXEL_RATE_DIV_NA;
 	uint32_t dp_dto_int;
 	uint32_t reg_val;
 
@@ -962,6 +962,7 @@ static const struct dccg_funcs dccg401_funcs = {
 	.otg_add_pixel = dccg401_otg_add_pixel,
 	.otg_drop_pixel = dccg401_otg_drop_pixel,
 	.set_pixel_rate_div = dccg401_set_pixel_rate_div,
+	.get_pixel_rate_div = dccg401_get_pixel_rate_div,
 	.set_dp_dto = dccg401_set_dp_dto,
 	.enable_symclk_se = dccg401_enable_symclk_se,
 	.disable_symclk_se = dccg401_disable_symclk_se,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 2fef1419ae91..1a9bb614c41e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -52,11 +52,11 @@
 
 static void enc32_dp_set_odm_combine(
 	struct stream_encoder *enc,
-	bool odm_combine)
+	bool two_pixel_per_cyle)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	REG_UPDATE(DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, odm_combine ? 1 : 0);
+	REG_UPDATE(DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, two_pixel_per_cyle ? 1 : 0);
 }
 
 /* setup stream encoder in dvi mode */
@@ -241,46 +241,12 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
-static bool is_h_timing_divisible_by_2(const struct dc_crtc_timing *timing)
-{
-	/* math borrowed from function of same name in inc/resource
-	 * checks if h_timing is divisible by 2
-	 */
-
-	bool divisible = false;
-	uint16_t h_blank_start = 0;
-	uint16_t h_blank_end = 0;
-
-	if (timing) {
-		h_blank_start = timing->h_total - timing->h_front_porch;
-		h_blank_end = h_blank_start - timing->h_addressable;
-
-		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
-		 * divisible by 2 in order for the horizontal timing params
-		 * to be considered divisible by 2. Hsync start is always 0.
-		 */
-		divisible = (timing->h_total % 2 == 0) &&
-				(h_blank_start % 2 == 0) &&
-				(h_blank_end % 2 == 0) &&
-				(timing->h_sync_width % 2 == 0);
-	}
-	return divisible;
-}
-
-static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_timing *timing)
-{
-	/* should be functionally the same as dcn32_is_dp_dig_pixel_rate_div_policy for DP encoders*/
-	return is_h_timing_divisible_by_2(timing) &&
-		dc->debug.enable_dp_dig_pixel_rate_div_policy;
-}
-
 void enc32_stream_encoder_dp_unblank(
 	struct dc_link *link,
 	struct stream_encoder *enc,
 	const struct encoder_unblank_param *param)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	struct dc *dc = enc->ctx->dc;
 
 	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
 		uint32_t n_vid = 0x8000;
@@ -291,7 +257,7 @@ void enc32_stream_encoder_dp_unblank(
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
 		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
-			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
+			|| param->pix_per_cycle > 1) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
 			pix_per_cycle = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
index 62a8f0b56006..2595cbef5942 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
@@ -273,46 +273,12 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
-static bool is_h_timing_divisible_by_2(const struct dc_crtc_timing *timing)
-{
-	/* math borrowed from function of same name in inc/resource
-	 * checks if h_timing is divisible by 2
-	 */
-
-	bool divisible = false;
-	uint16_t h_blank_start = 0;
-	uint16_t h_blank_end = 0;
-
-	if (timing) {
-		h_blank_start = timing->h_total - timing->h_front_porch;
-		h_blank_end = h_blank_start - timing->h_addressable;
-
-		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
-		 * divisible by 2 in order for the horizontal timing params
-		 * to be considered divisible by 2. Hsync start is always 0.
-		 */
-		divisible = (timing->h_total % 2 == 0) &&
-				(h_blank_start % 2 == 0) &&
-				(h_blank_end % 2 == 0) &&
-				(timing->h_sync_width % 2 == 0);
-	}
-	return divisible;
-}
-
-static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_timing *timing)
-{
-	/* should be functionally the same as dcn32_is_dp_dig_pixel_rate_div_policy for DP encoders*/
-	return is_h_timing_divisible_by_2(timing) &&
-		dc->debug.enable_dp_dig_pixel_rate_div_policy;
-}
-
 static void enc35_stream_encoder_dp_unblank(
 		struct dc_link *link,
 		struct stream_encoder *enc,
 		const struct encoder_unblank_param *param)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	struct dc *dc = enc->ctx->dc;
 
 	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
 		uint32_t n_vid = 0x8000;
@@ -323,7 +289,7 @@ static void enc35_stream_encoder_dp_unblank(
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
 		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
-			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
+			|| param->pix_per_cycle > 1) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
 			pix_per_cycle = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index da6507f5f202..f489371a3bc6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1779,6 +1779,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	struct dc_stream_state *edp_streams[MAX_NUM_EDP];
 	struct dc_link *edp_link_with_sink = NULL;
 	struct dc_link *edp_link = NULL;
+	struct pipe_ctx *pipe_ctx = NULL;
 	struct dce_hwseq *hws = dc->hwseq;
 	int edp_with_sink_num;
 	int edp_num;
@@ -1815,9 +1816,26 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 				can_apply_edp_fast_boot = dc_validate_boot_timing(dc,
 					edp_stream->sink, &edp_stream->timing);
 				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
-				if (can_apply_edp_fast_boot)
-					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot disabled to optimize link rate\n");
-
+				if (can_apply_edp_fast_boot) {
+					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot Enable\n");
+
+					// Vbios & Driver support different pixel rate div policy.
+					pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, edp_stream);
+					if (pipe_ctx &&
+						hws->funcs.is_dp_dig_pixel_rate_div_policy &&
+						hws->funcs.is_dp_dig_pixel_rate_div_policy(pipe_ctx)) {
+						// Get Vbios div factor from register
+						dc->res_pool->dccg->funcs->get_pixel_rate_div(
+							dc->res_pool->dccg,
+							pipe_ctx->stream_res.tg->inst,
+							&pipe_ctx->pixel_rate_divider.div_factor1,
+							&pipe_ctx->pixel_rate_divider.div_factor2);
+
+						// VBios doesn't support pixel rate div, so force it.
+						// If VBios supports it, we check it from reigster or other flags.
+						pipe_ctx->stream_res.pix_clk_params.dio_se_pix_per_cycle = 1;
+					}
+				}
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 42c3c440ed89..0d58c9d439c6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -829,20 +829,17 @@ enum dc_status dcn20_enable_stream_timing(
 	bool is_two_pixels_per_container =
 			pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing);
 	bool rate_control_2x_pclk = (interlace || is_two_pixels_per_container);
-	unsigned int k1_div = PIXEL_RATE_DIV_NA;
-	unsigned int k2_div = PIXEL_RATE_DIV_NA;
 	int odm_slice_width;
 	int last_odm_slice_width;
 	struct pipe_ctx *opp_heads[MAX_PIPES];
 
-	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
-		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
-
+	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
 			pipe_ctx->stream_res.tg->inst,
-			k1_div, k2_div);
-	}
+			pipe_ctx->pixel_rate_divider.div_factor1,
+			pipe_ctx->pixel_rate_divider.div_factor2);
+
 	/* by upper caller loop, pipe0 is parent pipe and be called first.
 	 * back end is set up by for pipe0. Other children pipe share back end
 	 * with pipe 0. No program is needed.
@@ -2685,6 +2682,7 @@ void dcn20_unblank_stream(struct pipe_ctx *pipe_ctx,
 			pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing);
 
 	params.opp_cnt = 1;
+
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		params.opp_cnt++;
 	}
@@ -2940,9 +2938,7 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	struct dccg *dccg = dc->res_pool->dccg;
 	enum phyd32clk_clock_source phyd32clk;
 	int dp_hpo_inst;
-	struct dce_hwseq *hws = dc->hwseq;
-	unsigned int k1_div = PIXEL_RATE_DIV_NA;
-	unsigned int k2_div = PIXEL_RATE_DIV_NA;
+
 	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
@@ -2963,14 +2959,13 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
 						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
-	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
-		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
 
+	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
 			pipe_ctx->stream_res.tg->inst,
-			k1_div, k2_div);
-	}
+			pipe_ctx->pixel_rate_divider.div_factor1,
+			pipe_ctx->pixel_rate_divider.div_factor2);
 
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 1d853241ca32..8e68e05e3b72 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -334,6 +334,27 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 	return odm_combine_factor;
 }
 
+void dcn314_calculate_pix_rate_divider(
+		struct dc *dc,
+		struct dc_state *context,
+		const struct dc_stream_state *stream)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	struct pipe_ctx *pipe_ctx = NULL;
+	unsigned int k1_div = PIXEL_RATE_DIV_NA;
+	unsigned int k2_div = PIXEL_RATE_DIV_NA;
+
+	pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+
+	if (pipe_ctx) {
+		if (hws->funcs.calculate_dccg_k1_k2_values)
+			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
+
+		pipe_ctx->pixel_rate_divider.div_factor1 = k1_div;
+		pipe_ctx->pixel_rate_divider.div_factor2 = k2_div;
+	}
+}
+
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
 {
 	unsigned int i;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index f4613d96e013..fb4f90f61b22 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -39,6 +39,8 @@ void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
 unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
+void dcn314_calculate_pix_rate_divider(struct dc *dc, struct dc_state *context, const struct dc_stream_state *stream);
+
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
 
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 9c46b6a7b4dc..7a8db4b81471 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -114,6 +114,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
+	.calculate_pix_rate_divider = dcn314_calculate_pix_rate_divider,
 };
 
 static const struct hwseq_private_funcs dcn314_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 7aaef3709baa..7330f9d79600 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1164,6 +1164,28 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	return odm_combine_factor;
 }
 
+void dcn32_calculate_pix_rate_divider(
+		struct dc *dc,
+		struct dc_state *context,
+		const struct dc_stream_state *stream)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	struct pipe_ctx *pipe_ctx = NULL;
+	unsigned int k1_div = PIXEL_RATE_DIV_NA;
+	unsigned int k2_div = PIXEL_RATE_DIV_NA;
+
+	pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+
+	if (pipe_ctx) {
+
+		if (hws->funcs.calculate_dccg_k1_k2_values)
+			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
+
+		pipe_ctx->pixel_rate_divider.div_factor1 = k1_div;
+		pipe_ctx->pixel_rate_divider.div_factor2 = k2_div;
+	}
+}
+
 void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
 {
 	unsigned int i;
@@ -1202,9 +1224,10 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 	struct dc_link *link = stream->link;
 	struct dce_hwseq *hws = link->dc->hwseq;
 	struct pipe_ctx *odm_pipe;
-	uint32_t pix_per_cycle = 1;
 
 	params.opp_cnt = 1;
+	params.pix_per_cycle = pipe_ctx->stream_res.pix_clk_params.dio_se_pix_per_cycle;
+
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		params.opp_cnt++;
 
@@ -1219,13 +1242,13 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 				pipe_ctx->stream_res.hpo_dp_stream_enc,
 				pipe_ctx->stream_res.tg->inst);
 	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
-		if (pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing) || params.opp_cnt > 1
-			|| dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx)) {
+		if (pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing) ||
+			params.opp_cnt > 1) {
 			params.timing.pix_clk_100hz /= 2;
-			pix_per_cycle = 2;
+			params.pix_per_cycle = 2;
 		}
 		pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
-				pipe_ctx->stream_res.stream_enc, pix_per_cycle > 1);
+				pipe_ctx->stream_res.stream_enc, params.pix_per_cycle > 1);
 		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index 4621163b4b98..db562e45d6ff 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -91,6 +91,8 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 
 bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 
+void dcn32_calculate_pix_rate_divider(struct dc *dc, struct dc_state *context, const struct dc_stream_state *stream);
+
 void dcn32_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 10d2ae99c118..5c50458b12cb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -119,6 +119,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
 	.blank_phantom = dcn32_blank_phantom,
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
+	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 663bacd1fafd..30e6a6398839 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -123,6 +123,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.hw_block_power_down = dcn35_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
 	.set_long_vtotal = dcn35_set_long_vblank,
+	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index d8de1c6a84e8..55e791552bca 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -122,6 +122,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.hw_block_power_down = dcn351_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
 	.set_long_vtotal = dcn35_set_long_vblank,
+	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index a9f2b7ee9dd8..e9b85884edce 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -339,6 +339,9 @@ struct hw_sequencer_funcs {
 			struct dc_state *context);
 	void (*exit_optimized_pwr_state)(const struct dc *dc,
 			struct dc_state *context);
+	void (*calculate_pix_rate_divider)(struct dc *dc,
+			struct dc_state *context,
+			const struct dc_stream_state *stream);
 
 	/* Audio Related */
 	void (*enable_audio_stream)(struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 286f3219b77e..f58c27ad8b3e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -399,6 +399,11 @@ union pipe_update_flags {
 	uint32_t raw;
 };
 
+struct pixel_rate_divider {
+	uint32_t div_factor1;
+	uint32_t div_factor2;
+};
+
 enum p_state_switch_method {
 	P_STATE_UNKNOWN						= 0,
 	P_STATE_V_BLANK						= 1,
@@ -464,6 +469,7 @@ struct pipe_ctx {
 	bool has_vactive_margin;
 	/* subvp_index: only valid if the pipe is a SUBVP_MAIN*/
 	uint8_t subvp_index;
+	struct pixel_rate_divider pixel_rate_divider;
 };
 
 /* Data used for dynamic link encoder assignment.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 867bc67aabfa..4fb1aacee894 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -176,6 +176,11 @@ struct dccg_funcs {
 			enum pixel_rate_div k1,
 			enum pixel_rate_div k2);
 
+	void (*get_pixel_rate_div)(struct dccg *dccg,
+			uint32_t otg_inst,
+			uint32_t *div_factor1,
+			uint32_t *div_factor2);
+
 	void (*set_valid_pixel_rate)(
 			struct dccg *dccg,
 			int ref_dtbclk_khz,
-- 
2.34.1

