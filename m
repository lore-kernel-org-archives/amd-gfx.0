Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C038AD36138
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E15610E61B;
	Tue,  5 Nov 2024 20:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="We04bl18";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E7710E61B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6eq31LBCLHTc2jBgQQbIXJ9LqTDHLvQabOfx5xraG5brSPHuVp+A/XP5S9emZRlRkaT1KAWZQv1ajx+UHgrG5YHNVdXOod95iRJsX/OdMnMfvq1ucSAD5w5flfzuDrXyJbuS4LV5cSLSlcPufy6NiGeBrPAe3IGLjQWuPI46CD3CyVD/rJEzB1JtYU2KwsbBSHJBm808VRiEjGeDgxlMoj064WQYQTHW7yVrgz8MU05L9Nrz3FFfazGjcd5eMKb+hnppuD0ccLtovDC2ml1hKuRC0ZK3X1PMFAOxhZfrRsgr0w/HgTW7kGeLi/mnrNXVfpVonBNDXF0VpXIvNKVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOfnw4fRTlkmkJZN19r9PNwXNV2jD++IrQMxssOPuQI=;
 b=T3TOXDpYHif5z2PFA6jhWuVnUabAmcW1b6qUYLpQItnDSd7Xi2PHtGMTemwvl+U73T3Bn30Rzmv8InwMPuBUETRJAYH5P0YCB4sCSrMs7Wa0uzkB62XL710uMoMiSxMdokAFqFYMOGDYBnGWZQEOFqlOHPrLLorSrE1u2cJCjPjsDS5t82ovIHlVcKKO/0a3wkglmaFBm5PNEWcQbVvswFPfop8sBAqARBdmw1ykBBj09/fXR5vrv9lpAlI4s3qYrr8DQ2pVLzzlhHTGlHWbfidtpIjRffJi2CN8xL7myFKrELyezBx2nHxjUvpAdgTXRSTJrqCG3TJI58JaMDGwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOfnw4fRTlkmkJZN19r9PNwXNV2jD++IrQMxssOPuQI=;
 b=We04bl18qlGZEZyX4y36BxfaD9CU7kN0GHHliBVrIvOqhbUO19r9d5V/9dHqZn0NXJMzb+NUTSYFvlDc5DuzloemcIu7M8TM7EYS7wTTZ/KybGipvrFNYQtuXdELf51bJQ0mEOyj8NAVObWNiZBKm5M+YY1OJAA1QRG5Wi3gT3k=
Received: from MN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:208:52d::29)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 20:25:04 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::5) by MN0PR04CA0030.outlook.office365.com
 (2603:10b6:208:52d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Tue, 5 Nov 2024 20:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:25:03 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:59 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 16/16] drm/amd/display: 3.2.309
Date: Tue, 5 Nov 2024 15:22:17 -0500
Message-ID: <20241105202341.154036-17-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bfbe04-f106-44ef-56a3-08dcfdd7ee5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uICJtBGU01/MwPRHoRXikNiSP3+0fjRnRJvUqA8pEsetyMHVV/939EkbfA4m?=
 =?us-ascii?Q?3rgHY67Yf3X9R7ubp/YeyNLkfnR/iVep6krgYxecC770snRcefLC8IbyZCMA?=
 =?us-ascii?Q?T/KDaSYAABbxb7kp7sVBK+uhPnoc7KEj9VrcMwuphCZUM+SzQugclOGHiWr4?=
 =?us-ascii?Q?bR4wmtg1W0LZFfjzmKGsFlN3BhmrFpPGewgI5gU3CgJ7JSZmB9YW56j+pOa2?=
 =?us-ascii?Q?jJecBrpd/giz3ioCG4L4m9qNQsK0/YIkGNUy63WVZ0BkO02HnPgGXD910WV1?=
 =?us-ascii?Q?+HAjv2w3ogtAY6rsCmWI4ThmfaoLFXWZoSWV7ou4QHiEN4qUBZa9sD6m/Npl?=
 =?us-ascii?Q?Yej1TYTKClwJNfGu/Mrrulv6DmSMaQ+Ba4apUQ9xiEGMrcfI3KXHn7Ni23wz?=
 =?us-ascii?Q?9SldyTfvb0LFmjF//I786aTB8ZdaDMn6ED08PFxQaZ5odr7osNL3kW02YC2Z?=
 =?us-ascii?Q?qbvsj/FE5RNUtAV1qtNo/w4cNWq5OwVQZ85eDfnZUS0b8kBYle1butWKP8B4?=
 =?us-ascii?Q?vErMbvYTuAFZuRDK91tIB9Qz0hhPnVzTyEmQd5XdYjbUz9FBbJH+jjU4kpa7?=
 =?us-ascii?Q?GPgMO6Ikb3PxTAJUBq2lM4enKQj3Vln4doh1WdTa4BQG954ofzjezYS4hOxR?=
 =?us-ascii?Q?mE5srmHeFX0u+2g6VV3/1WnR0Gjelv/4C76S2g3Qhd3AbiW9XEnJ4BJ7whAl?=
 =?us-ascii?Q?4XSMQCfTlK5PYiV4zjEGv4P8xIPbQSddY13TIJqEIA38jdkVJfOwZy/0fuYj?=
 =?us-ascii?Q?RX0We5VYMrOEqf5zrD94XYDRs0Ab88qwa7gFvjqHP4PFZAB4tdMcbKzKjfgK?=
 =?us-ascii?Q?/1AEHCHiOC3lweIOgkQkThJrVGJnD3joqJnaO2KbI57V3fo1in7iiRrFVRkW?=
 =?us-ascii?Q?iVlVY285lDYqJW+YQ3azX2+dsi28R+Vxez8l2G3sfOs0d1yvOeB9Fjk56g1u?=
 =?us-ascii?Q?623WSgfLpJSN/Vab4fT/kANRatFMrt2jn7TrDT7WPxz+iG1QmTIiuqKavBXy?=
 =?us-ascii?Q?t6GKY86TWg6sonRhk4b+q6CYEtchgL01i/Dur2bxDMinioQGNwtQy9asWJCo?=
 =?us-ascii?Q?zIiN3L5QQC8qXdAU0pOr75FJ2Ar4TOOSHmhlrs3XqAozxl4iWQudUZMeLfo7?=
 =?us-ascii?Q?Gjp26SsiCb4hmM8fIKfq2QcAFqWkXxlyAwETCJD1fUgKFLQp3F4FvmnxThVR?=
 =?us-ascii?Q?eF3PTT57r6VYKjKBBqIvfN/zhfVYvMKj2nkNATt2FzziNH8FhAZN0VIwmXnH?=
 =?us-ascii?Q?8NA23N9vPZKOyD1JR9tr4+hoVnM2htiF3fCwZdoVA4NuGMKr5rVJddMqVUTN?=
 =?us-ascii?Q?4IHudLTRbkSoxmhFxI0mjHFfzCOo5Xu1tkeztwoFB/V/4mZUK2yiqWaweQ6z?=
 =?us-ascii?Q?UtS9WfM7sikQhKVLwxhOnwHJFtCa61HXgkdWSVsMBazmaLpgGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:25:03.6561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bfbe04-f106-44ef-56a3-08dcfdd7ee5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- DML2 fixes
- DP fixes
- DPMS fix
- HPD fixes
- Misc cleanup
- ODM fix
- Replay fix
- SPL fix

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 35 +++++++++++++++----
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ad9ce3d0bfcf..e143fab00a86 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.308"
+#define DC_VER "3.2.309"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 59b2e87317e3..03ba01f4ace1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -653,7 +653,8 @@ static void dmub_abm_set_backlight(struct dc_context *dc,
 	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
 	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = backlight_level_params->frame_ramp;
 	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_level_params->backlight_pwm_u16_16;
-	cmd.abm_set_backlight.abm_set_backlight_data.backlight_control_type = backlight_level_params->control_type;
+	cmd.abm_set_backlight.abm_set_backlight_data.backlight_control_type =
+		(enum dmub_backlight_control_type) backlight_level_params->control_type;
 	cmd.abm_set_backlight.abm_set_backlight_data.min_luminance = backlight_level_params->min_luminance;
 	cmd.abm_set_backlight.abm_set_backlight_data.max_luminance = backlight_level_params->max_luminance;
 	cmd.abm_set_backlight.abm_set_backlight_data.min_backlight_pwm = backlight_level_params->min_backlight_pwm;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a9b90fa00b88..b800a507d1e0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4426,6 +4426,24 @@ struct dmub_rb_cmd_abm_set_pipe {
 	struct dmub_cmd_abm_set_pipe_data abm_set_pipe_data;
 };
 
+/**
+ * Type of backlight control method to be used by ABM module
+ */
+enum dmub_backlight_control_type {
+	/**
+	 * PWM Backlight control
+	 */
+	DMU_BACKLIGHT_CONTROL_PWM = 0,
+	/**
+	 * VESA Aux-based backlight control
+	 */
+	DMU_BACKLIGHT_CONTROL_VESA_AUX = 1,
+	/**
+	 * AMD DPCD Aux-based backlight control
+	 */
+	DMU_BACKLIGHT_CONTROL_AMD_AUX = 2,
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__ABM_SET_BACKLIGHT command.
  */
@@ -4452,18 +4470,23 @@ struct dmub_cmd_abm_set_backlight_data {
 	 */
 	uint8_t panel_mask;
 
+	/**
+	 * AUX HW Instance.
+	 */
+	uint8_t aux_inst;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[1];
+
 	/**
 	 * Backlight control type.
 	 * Value 0 is PWM backlight control.
 	 * Value 1 is VAUX backlight control.
 	 * Value 2 is AMD DPCD AUX backlight control.
 	 */
-	uint8_t backlight_control_type;
-
-	/**
-	 * AUX HW instance.
-	 */
-	uint8_t aux_inst;
+	enum dmub_backlight_control_type backlight_control_type;
 
 	/**
 	 * Minimum luminance in nits.
-- 
2.46.1

