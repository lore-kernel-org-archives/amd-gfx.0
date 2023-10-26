Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E446C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B4B10E80A;
	Thu, 26 Oct 2023 14:20:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7491D10E7F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESyn0HI6OuFmyGdz5pm/ltqAX0gOpgEEHwoT4/c2MYk9E+2o1TDevSs0H9roQTJILFPPW9tNW3sZIAvFcSZMW719LTJi7ZF3yqE0clrpCZdrr6cUfbs6qGhQmch+N+812b6UEGmS8we+LkA7L8kS51X6eVwQZlm6vsnpY4UqBKxcxDQVwl28z5g6xgNMyL9KSWI2CjidjYEYTQWZg2nvLwKslhND6EmJl5myz3l3WSL/K4Lj64NmOz7gAmpCPDN8XGzFyWVEMLabX7LgKdkubJ3WNOUKeooqlk2sqqG2+dIJwYLmcaJM9TYusVlYPxvBocplBVwJK84jGuR6Z6Oc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb4lDgc4xInmx9KUJ8PPVyZuavDSeNRWCZnEtkdJi6w=;
 b=c8LMzlbTP9uqJk/SxpaVXOYf1bEAgzw4nXtLYmLQ3S0yoLtOdsntwM6R0KMar/oTcMc7s981BzfQkQjJfIAADfap+R5JtGTOgYRclueq0i0NY0cm/k0STNMkb8BS64Tk4lVhSuvxBe+akdtgC+ckkhvwGuML3uoSYy2LgqE8Z8fv28z3/OIgPeAaiayHflKKYu4CG8FBhVcwC0JV0wYJugI+EjybRaSB/mggAFYglvzE4mvNVFTZLqiaUdWlMK9k8F73Xhpq61tUq66H1ACcsexIByu67WWbgDoG5nbKFcM0YxE41l2ZNWDHq0x8kTtLu3HUfxxBhKnlJ3fDOFO0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb4lDgc4xInmx9KUJ8PPVyZuavDSeNRWCZnEtkdJi6w=;
 b=nVxHF5L1DAYj4BVnY9HA8h1YQBYPLxc0C8ipMkufwK6uOhjb188jfsc7OEtuPfVopS0opSTXpAX0awU7P5up8IBeKOWpgseFDZ9k5+vgtcjN88R/CsjBXuhlwhWVhKIvrT1RXycTG0zLGxsn6reyetvL1FstYKE/WkHqnvmTtBU=
Received: from DM6PR13CA0040.namprd13.prod.outlook.com (2603:10b6:5:134::17)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 14:20:29 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::32) by DM6PR13CA0040.outlook.office365.com
 (2603:10b6:5:134::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:28 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:25 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/25] drm/amd/display: Program plane color setting correctly
Date: Thu, 26 Oct 2023 10:19:57 -0400
Message-ID: <20231026142020.67861-3-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: e0897845-0d47-49a2-aef6-08dbd62eb4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5ttGqNPSJayjapBeYQprDydcsabbaQRN4L2IQCDwM5l9EOPWOBydjTP09XWX22iahuJrJz9Lik5ZnlzAY2qznjeZHQYL8EPiXn0kRw1xqWEvfumBH0y3hwvD5SNmZQ5/PltM5++25RfECUG6iUNF4necma9kjyWO2ZzOGy9f2se6e9H+7s8Xp0snOCRU4AZRMOaZjLMnTMk2Q4CsEBYrvCcF6kYr99to2qtzJrJ4cG5RJI2nXLX68ikeNS78fw6oWK1KcnJHKKGIbmGlchQxL2dw66tgygurCY0yaZ7N6CKwRuv68NL4wqYzg23maOrn+LnP6m5yx6E0b8hfVtd3lztwzZtv4RWMGlb2R6onxpa7/Q1JsiE99GUUqKgdu1qmsiHoHzfzHlb2GSSjSN1VJsU9ly2Nn1wLnDu7LMkMXJumKgqr987kcq/gdGoRKIooN/cjexgd885dJy0lR/bt/kLFsaLbl2Di68I5B9j/sr9RpTW5ZvHjw05RoQ2Lcn5TkUCgs2Nj7ZY8Q1SddegyMaAGaowrfxmP5ioVvTujnIo4R/VVQOCbZ7Meb0gvm0utT3mjIsql3FJwR8oQF32IE7LbQi79ZsALA5RvpgZNsO4DHVJjvta2EqDUk8gAhHvYZX1+I7Gy4adx4syTW4ezYsvSbbiJWpl6BwGAkxvwhuPBnABfg2rSUn/uhRgB/R2OENMZJAEx4/9GcXr0doCvqSzVwcO7UxmD9p7CereY/wOxqZvyTfxszz9J8h3GoGik5G/R/YGUl1roOacTVQhng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(47076005)(6916009)(4326008)(83380400001)(36756003)(8676002)(8936002)(5660300002)(36860700001)(86362001)(2906002)(54906003)(40480700001)(70586007)(70206006)(82740400003)(356005)(81166007)(316002)(26005)(1076003)(2616005)(478600001)(40460700003)(426003)(6666004)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:29.0633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0897845-0d47-49a2-aef6-08dbd62eb4b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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
 Sung Joon Kim <sungkim@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Duncan Ma <duncan.ma@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
There are some registers for plane
color that are skipped programming
on resume. Need to add those as part
of the sequence.

[how]
Add new function hook for programming
plane color control.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h |   5 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c | 137 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |  14 ++
 4 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index 2861d974fcf6..75547ce86c09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -316,7 +316,7 @@ bool hubp3_program_surface_flip_and_addr(
 	return true;
 }
 
-static void hubp3_program_tiling(
+void hubp3_program_tiling(
 	struct dcn20_hubp *hubp2,
 	const union dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
index 8a32772d4e91..b010531a7fe8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h
@@ -278,6 +278,11 @@ void hubp3_setup(
 		struct _vcs_dpi_display_rq_regs_st *rq_regs,
 		struct _vcs_dpi_display_pipe_dest_params_st *pipe_dest);
 
+void hubp3_program_tiling(
+		struct dcn20_hubp *hubp2,
+		const union dc_tiling_info *info,
+		const enum surface_pixel_format pixel_format);
+
 void hubp3_dcc_control(struct hubp *hubp, bool enable,
 		enum hubp_ind_block_size blk_size);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
index 1ed58660779e..771fcd0d3b99 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
@@ -53,11 +53,146 @@ static void hubp35_init(struct hubp *hubp)
 
 	/*do nothing for now for dcn3.5 or later*/
 }
+
+void hubp35_program_pixel_format(
+	struct hubp *hubp,
+	enum surface_pixel_format format)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+	uint32_t green_bar = 1;
+	uint32_t red_bar = 3;
+	uint32_t blue_bar = 2;
+
+	/* swap for ABGR format */
+	if (format == SURFACE_PIXEL_FORMAT_GRPH_ABGR8888
+			|| format == SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010
+			|| format == SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS
+			|| format == SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616
+			|| format == SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F) {
+		red_bar = 2;
+		blue_bar = 3;
+	}
+
+	REG_UPDATE_3(HUBPRET_CONTROL,
+			CROSSBAR_SRC_Y_G, green_bar,
+			CROSSBAR_SRC_CB_B, blue_bar,
+			CROSSBAR_SRC_CR_R, red_bar);
+
+	/* Mapping is same as ipp programming (cnvc) */
+
+	switch (format)	{
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB1555:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 1);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGB565:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 3);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 8);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 10);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616: /* we use crossbar already */
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 26); /* ARGB16161616_UNORM */
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:/*we use crossbar already*/
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 24);
+		break;
+
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 65);
+		break;
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 64);
+		break;
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCbCr:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 67);
+		break;
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 66);
+		break;
+	case SURFACE_PIXEL_FORMAT_VIDEO_AYCrCb8888:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 12);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FIX:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 112);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FIX:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 113);
+		break;
+	case SURFACE_PIXEL_FORMAT_VIDEO_ACrYCb2101010:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 114);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FLOAT:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 118);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FLOAT:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 119);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBE:
+		REG_UPDATE_2(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 116,
+				ALPHA_PLANE_EN, 0);
+		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA:
+		REG_UPDATE_2(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 116,
+				ALPHA_PLANE_EN, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+
+	/* don't see the need of program the xbar in DCN 1.0 */
+}
+
+void hubp35_program_surface_config(
+	struct hubp *hubp,
+	enum surface_pixel_format format,
+	union dc_tiling_info *tiling_info,
+	struct plane_size *plane_size,
+	enum dc_rotation_angle rotation,
+	struct dc_plane_dcc_param *dcc,
+	bool horizontal_mirror,
+	unsigned int compat_level)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	hubp3_dcc_control_sienna_cichlid(hubp, dcc);
+	hubp3_program_tiling(hubp2, tiling_info, format);
+	hubp2_program_size(hubp, format, plane_size, dcc);
+	hubp2_program_rotation(hubp, rotation, horizontal_mirror);
+	hubp35_program_pixel_format(hubp, format);
+}
+
 struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
 	.hubp_program_surface_flip_and_addr = hubp3_program_surface_flip_and_addr,
-	.hubp_program_surface_config = hubp3_program_surface_config,
+	.hubp_program_surface_config = hubp35_program_surface_config,
 	.hubp_is_flip_pending = hubp2_is_flip_pending,
 	.hubp_setup = hubp3_setup,
 	.hubp_setup_interdependent = hubp2_setup_interdependent,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
index 3d830f93141e..586b43aa5834 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
@@ -58,4 +58,18 @@ bool hubp35_construct(
 
 void hubp35_set_fgcg(struct hubp *hubp, bool enable);
 
+void hubp35_program_pixel_format(
+	struct hubp *hubp,
+	enum surface_pixel_format format);
+
+void hubp35_program_surface_config(
+	struct hubp *hubp,
+	enum surface_pixel_format format,
+	union dc_tiling_info *tiling_info,
+	struct plane_size *plane_size,
+	enum dc_rotation_angle rotation,
+	struct dc_plane_dcc_param *dcc,
+	bool horizontal_mirror,
+	unsigned int compat_level);
+
 #endif /* __DC_HUBP_DCN35_H__ */
-- 
2.25.1

