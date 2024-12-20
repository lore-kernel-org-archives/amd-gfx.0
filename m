Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D0E7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3302910F087;
	Fri, 20 Dec 2024 21:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4IwbrEbi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8872710F087
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzXQgRmj31bfnQ6yT4NHiXdorsxXiUTS0vzlV4SdkIPSCqOXHk6UOyvexV3orOpeciUVS+nH51PwMfOCkleErVoZ2zbXYyMMcAA0JQ9s4Jhs2Rod2bzFYebGMiWBTfFiqkbKPGhAWTmKX64g/a9lgvhj4XSXxWwnvGgPBFXBK2BVb+1Jkm0x/fEQAzXfpiEQu2H1dpSMQZh47RbhcEwEO9iV4Bxmr+ZMVC/01D7J67rgIrZ2URedGce0I526GL9U8sjQMp8lfvyuD4yFAPM78AKbc+bk0aIW0iccXuhcCA2TU357m9RFflzv2bUovAlcAFrgXwg7jDgy6iW6EMC9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nbt7QVS9+FkEho2sBGpPZ2qfA93KBMCfzrFx2PPwysU=;
 b=wQbNyvdHCml4aN89Qz0MX7OJw8K/7W44/PDjuPyQDOty4CvaEkhk44SDa/4RipKWGWvw/yEpdnn66Iha+R4DDeijZLbCl0+galX09UqrbkzGx3sqtLwh2pPE9h0dPoGdwiJFLac+LAdTHknJ8jCeP4Aj+EqQZ+uS7bo3YmZJPw20DI3i+9u91ryrOsyahdRpyuGLYfg5MnSBmzrAQB4AgzzqbwgAtqYK21ZB7qU0JNdh8jTe70gOgFI0Xdz+O+0ksPAbjnGX+cAC3sXloJQuaO5611NIPq96mk9fUMkydnymefpA6HyE+LFQz+cxxnt1jMRf33W/B60nzX6SEgJ/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbt7QVS9+FkEho2sBGpPZ2qfA93KBMCfzrFx2PPwysU=;
 b=4IwbrEbiFbJ+iQ66fCCLBkyYmxB4KFQZHKztc1nte1pXcwkUPS5qpMkLwT9B85y7KRJvmF/Eyf8CtCq02lrS5bPsnCfeNHhzfnwqDQ09qNpcTtElId4dHMzyjKVuZA5okWLQ0XXfBbH6N30V/1ya4mPMkfQGyAIblMPYV832Mp4=
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:30 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::f3) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.12 via Frontend Transport; Fri,
 20 Dec 2024 21:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:29 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:28 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Iswara
 Nagulendran" <Iswara.Nagulendran@amd.com>, Harry Vanzylldejong
 <harry.vanzylldejong@amd.com>
Subject: [PATCH 26/28] drm/amd/display: Add VC for VESA Aux Backlight Control
Date: Fri, 20 Dec 2024 16:48:53 -0500
Message-ID: <20241220214855.2608618-27-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea578ee-13fb-43fc-22b7-08dd2140766e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0evY0O9oEb3y+14zN2IQIMkXF/EpX8S/0J8m+9031O95rqlmQdtQPEW9pTXc?=
 =?us-ascii?Q?bBQexfQ+cHkuQ6lDN9cFJ1aXbhE8WtesQ0zX0ofzkoHtmOW03cYWahmmraJc?=
 =?us-ascii?Q?m7am4t3T2vjCNq/kEeI5GuxYxKp1oI8AHVBCPBF/ptA8hFxIOADkbtilH3tR?=
 =?us-ascii?Q?LFPMHL8QbLF31IhqubdYJMyxTFXzzUDdbkwPZqmmFNuVkpWyTZdxCNW3di6/?=
 =?us-ascii?Q?OrmwkBjHolElO5Al6KpoaZVVcbVNzU239O+UzDT3lHC2QF3cNjzg5Q2Ux9tq?=
 =?us-ascii?Q?ZS6G4ftPrVnSkA/wDpAKEpvQRX3ZWP2QCyoGvoO40xFoRwlltumBg3Go/1o8?=
 =?us-ascii?Q?WTc/wrWRFyL4TIt8Wjh73lVbmIWkRKcJozk20UY+ygk7j+VRV/j0QnGjLSjF?=
 =?us-ascii?Q?9Gpz30Yj7PJl1f8i1ntEywi5DJ73Vact6kHItNWRDPWZG2O39q++tRW6Pk0Q?=
 =?us-ascii?Q?8mYJKV2zxwmZFIsrt6v3sqS2/ZW/lozU5kwPakYBj42qV1UECtKZ3sQzJroS?=
 =?us-ascii?Q?FgpHvlGpOf3pHC75uL1y5fX2VH4rzLQgY+o6tInFFoYyN086Chzv3KwEJ3g+?=
 =?us-ascii?Q?HXTsago9+eun6iEpeEEXxto0fKDFZQZAWdp5zt34Yv7k5N1/jt9PdRkKKW09?=
 =?us-ascii?Q?0Hyb0mlt51miEG17H8NWMdYELbrVveDjYPpvZhVMweSrfUsYRT3o5T9JNLzd?=
 =?us-ascii?Q?YoF1pifKUWrv4CDuUn34YX9Yfu2dsi6IcgKc7O3M/QyYsnzhisEoNzC0Wcrk?=
 =?us-ascii?Q?gcBDX6NL5b7j85QYdctOMR+oRXq3SjNek3/XJl2XuK0VTohj8eD6n/q7a3H4?=
 =?us-ascii?Q?OET8T1sgnNTYPB0d5ZlRGOswdHVXR8GwafDT/YJ9v4ntZf5G/A6B39dU/S9n?=
 =?us-ascii?Q?VVBpW6dPSYHvxaxpI08GpPA6X83Yam99eU/+vYurmp0YlA6GTKjHrEGq0/Al?=
 =?us-ascii?Q?cXXR1FYmE0GMfqETElrf+d9bGma6p+HiGC6gLqqrwFObYZ7FmxwQfOXXC83k?=
 =?us-ascii?Q?DELe7rt6kEFZzpXLkf3fKik/3+PD8ZPHB70fLUrr/ZeMSAlv+jA+GVyTvgLC?=
 =?us-ascii?Q?oCShreL4UVytLvd9iaQU0JOSLc2W1uNWtpcyArw7reUP7d90FZ67VhqEZ30w?=
 =?us-ascii?Q?TkbkIo1A7l/XG/+qFwAdOnqDjm+jSkeHlcypSLvgGtO1/L2RmMbJn79DPmMl?=
 =?us-ascii?Q?qw/vD/tWeKMxX62NiNe0kl1LmkNwgkIXKr97zNxarkjZRioquulbNqUd2X3H?=
 =?us-ascii?Q?GoDa5YR/6BE/7quqKonDaWguUxJE5WdFOfQPBCwoLblpcbsEhK0otpWToiS1?=
 =?us-ascii?Q?4AReDtfOcXjClK1ij+C+gOkbV4zG8xh9XDtiPo68Ua7RqGXAcojEl3AOZknz?=
 =?us-ascii?Q?iEQL0k7IEGEZA2H5I5tsne8LMgvTSQ2Gnet95YLb3AyLA33+NSlwFNbxxyhN?=
 =?us-ascii?Q?gQo7bq5g99sCElW/oj+4yfhjkC7aVjzqqkZXRHX75+dY4sy5YsIUnmLehz4H?=
 =?us-ascii?Q?UaekaOA7z75jnv0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:30.3468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea578ee-13fb-43fc-22b7-08dd2140766e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

From: Iswara Nagulendran <Iswara.Nagulendran@amd.com>

[WHY]
There is no way to distinguish
the static backlight control type
being used and the VABC support
without the use of a debugger or
reading DPCD registers.

[HOW]
Add Visual Confirm support
for VESA Aux-based Backlight Control.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Signed-off-by: Iswara Nagulendran <Iswara.Nagulendran@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 38 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  6 +--
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4742a4ad19bd..12839fa3682d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1236,6 +1236,8 @@ static void dc_update_visual_confirm_color(struct dc *dc, struct dc_state *conte
 				get_mclk_switch_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 			else if (dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS2)
 				get_fams2_visual_confirm_color(dc, context, pipe_ctx, &(pipe_ctx->visual_confirm_color));
+			else if (dc->debug.visual_confirm == VISUAL_CONFIRM_VABC)
+				get_vabc_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 252af83e34a5..6eb9bae3af91 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -425,6 +425,44 @@ void get_hdr_visual_confirm_color(
 	}
 }
 
+/* Visual Confirm color definition for VABC */
+void get_vabc_visual_confirm_color(
+	struct pipe_ctx *pipe_ctx,
+	struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+	struct dc_link *edp_link = NULL;
+
+	if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link) {
+		if (pipe_ctx->stream->link->connector_signal == SIGNAL_TYPE_EDP)
+			edp_link = pipe_ctx->stream->link;
+	}
+
+	if (edp_link) {
+		switch (edp_link->backlight_control_type) {
+		case BACKLIGHT_CONTROL_PWM:
+			color->color_r_cr = color_value;
+			color->color_g_y = 0;
+			color->color_b_cb = 0;
+			break;
+		case BACKLIGHT_CONTROL_AMD_AUX:
+			color->color_r_cr = 0;
+			color->color_g_y = color_value;
+			color->color_b_cb = 0;
+			break;
+		case BACKLIGHT_CONTROL_VESA_AUX:
+			color->color_r_cr = 0;
+			color->color_g_y = 0;
+			color->color_b_cb = color_value;
+			break;
+		}
+	} else {
+		color->color_r_cr = 0;
+		color->color_g_y = 0;
+		color->color_b_cb = 0;
+	}
+}
+
 void get_subvp_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 063f853160d0..23a6d56d0798 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -489,6 +489,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_MCLK_SWITCH = 16,
 	VISUAL_CONFIRM_FAMS2 = 19,
 	VISUAL_CONFIRM_HW_CURSOR = 20,
+	VISUAL_CONFIRM_VABC = 21,
 };
 
 enum dc_psr_power_opts {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index a5bb10d7b160..98d85c7ab3fa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -194,7 +194,6 @@ enum block_sequence_func {
 	DMUB_SUBVP_SAVE_SURF_ADDR,
 	HUBP_WAIT_FOR_DCC_META_PROP,
 	DMUB_FAMS2_GLOBAL_CONTROL_LOCK_FAST,
-
 };
 
 struct block_sequence {
@@ -485,11 +484,12 @@ void get_hdr_visual_confirm_color(
 void get_mpctree_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
-
+void get_vabc_visual_confirm_color(
+	struct pipe_ctx *pipe_ctx,
+	struct tg_color *color);
 void get_subvp_visual_confirm_color(
 	struct pipe_ctx *pipe_ctx,
 	struct tg_color *color);
-
 void get_fams2_visual_confirm_color(
 	struct dc *dc,
 	struct dc_state *context,
-- 
2.34.1

