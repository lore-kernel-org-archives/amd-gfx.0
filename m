Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F83E6B27D
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 137EC10E9CF;
	Fri,  1 Nov 2024 13:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WV8+O87L";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D53D10E9D3
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpnW1eSgafQOKYGNHgoAX9SMNKjvGrQcdg7X799uvgzd0NlmICI5dVO9ZwSt8PcQMhLCxx/NypE3DxIt+ih/lOzsVmhqLB0nIujGkA5piBbVWMZazGKQ3l5tzlTLehaIBBsa2QDfDdDcqrOt93nm9+uczRyH+kMWsqAgmXUJt4DTiNzQcqfkbAhcedMkIaA+ie0dZ+WH9wL3bZ/2U6lFEYRGyQeo+ut7+MBkuygBJ82ea71IAgls6WuJTe3sQh0f0glQFDRkdoiGJqgT610V0u76yGnmbkNcIN2C7cMdDXKOWLccLqnw03JNNrHm4px12eaeb41tZqSLpRl921U0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez9MlPoZKBH9M1ELmDKZqqOh0WI2YhOFQF8Fue4MT4M=;
 b=Qwg/FVxsUoqxeL7NhdOb30FQzlVhp7hlYyJiooOwlavhz4h66tR0QULR+ssCNhk+xG7XwAKU9vXV+SdL9C8TrTtiX8sHwirDrZC+Vix/DsUaS06PG5BgqwFeJuuli2MT+Zr528AUeWb7ropGAqJVmzIkxMz3ewA6f3ORJJiEKg2kbdJOjAE8+oD4lvMFaTSVpgWDtE2U71HbR0EI/tj9WSwNGxQ6aIvlHhb2ig06wJgBnAz2lBAY10TDGDSpPetrSbHY7tHWUg1npVjM1sk1pmn12tRcTbByaMNulqyogTcbbl1T6Kjyijx0YQ31z5vywIjARCdThB+lUhVpxKSskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez9MlPoZKBH9M1ELmDKZqqOh0WI2YhOFQF8Fue4MT4M=;
 b=WV8+O87L/xjT4I7zp+3UaOuiHWDLqgfDoA/cNbmtfG1qN+jNxiln8k1N21gfGXfNaKDPSMkbKdl7PDIXr5H+s/wmmXLdXKbR0Pa9Cmxj8Apep7isnMcLo2rEnUqwSjYHtDbK2FALI4tWaJh3ImwwKhhxnnTLgAiX/qGcthg+ugw=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 13:50:28 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::6a) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:28 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:24 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Kaitlyn Tse <Kaitlyn.Tse@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 15/17] drm/amd/display: Implement new backlight_level_params
 structure
Date: Fri, 1 Nov 2024 09:49:38 -0400
Message-ID: <20241101134940.1426653-16-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3c1a66-6dc2-4464-8ee6-08dcfa7c24f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DqV4S9NGi91jsGrUJZMFeSsCdN0T4S/7oXdLIucA2B/+vJqgK4JEVaAdQkV/?=
 =?us-ascii?Q?ILMWzgZOaRN3gl2X5HGs9GMsqigXYZoMnuciixJ5VfHBhOiqtKN1+x2hxbYN?=
 =?us-ascii?Q?9WoyA9SVG+0cfxPWHhdWsMjT/PaiDhi9CO/V08GSQUIEJuvqaK5srlHPo+K4?=
 =?us-ascii?Q?EyWIw6VfwGoc84CZivjLmoWVNKKpTM9zqqHFftyFFG5UI2+w9ddtBGMj0l2G?=
 =?us-ascii?Q?/BdufxMYXGcDF/vBvyVOKoSsIdNGEbvOf1v5q4qyIvQmILA2Ds2LkkDzJViK?=
 =?us-ascii?Q?Xb1b71dKudVAcYfQhFiR56hr2lwm1qgVtL4/MRHnbFm7WAqRitrrB5uT206S?=
 =?us-ascii?Q?BgiZzYVjGJMCl8NXrC44u9QgMQoRXqTAYXcg6yMNaFZ7RpUVuQ3qmFW3g/w5?=
 =?us-ascii?Q?qUYkgmvezwzG2glNX1z6FmgUTIP0y32D4QQiexZS7r/bB9C2VcGwa8gSBVeA?=
 =?us-ascii?Q?I64jc8PODua82eekVGOSF99xJRUijbTV9KAkzHtf4s803zWPULcII5TeNlpn?=
 =?us-ascii?Q?A03H+DEhlqYAfJpv8GueVnAQI2E3j34HWdrNQtKZK+TYAxiBAUcR9q82EQzz?=
 =?us-ascii?Q?BUKO5F4l+aXT2eODgLy0AG5kGtLPwcB+UzpVvkwrDeoAAUqx0xYdovqsVQnu?=
 =?us-ascii?Q?WU3Yy8fK1WNHQCCpsqChgLAhXNTWX4rsLPS9vo5Z+cB7js+MlrggJj9EL5qr?=
 =?us-ascii?Q?SxHzXJX1wGDMrWivK5EgZWDIYpdJSzFkFiTjRc6Ii3qk2TluM5jmv73zM8Fy?=
 =?us-ascii?Q?uPCAHSE0U6tQEoiPWCtWU3CaovUG4+TuZVkU8AsFsLkS98wGnyDu09lLCF7i?=
 =?us-ascii?Q?vdrEBEYrFUarjIFy40pl9kMtbJV80BH4n2VGybbdV8sg4E69b9WfYTOyQw0/?=
 =?us-ascii?Q?XwfhincJWyG3WN6vQ/0j2isG51m3pIJZEFYQrSM/OJwX4qZBpUpIOK6k1r2w?=
 =?us-ascii?Q?s0kPKKhGRa5vXxbw7A+wPTPIrKBhHnat5ONQDOJamhSk7YeNHMwlE49Zay4G?=
 =?us-ascii?Q?BunxjptSa5jYI3Pkj3jc6SvyNDq9I6BC0+FOINpb1Nj3HHvRhc6agEQ4eqRa?=
 =?us-ascii?Q?N7q/Am4jbX3ULJ9E8k9avBKRJ4/23UlHfUoU62rvWzmm8mK0wj8lM8mufsko?=
 =?us-ascii?Q?dxcaCWkXSbATW1LgaqyJUO3gWvQ09RFZTLs6mhwxPLZDhyiHsJgSE+w6MCC9?=
 =?us-ascii?Q?ksoztf398y4ze9HOuz7pU8Pl34WqLRsggAdGO5aIjjtRvbIK8EZYThMo52Kd?=
 =?us-ascii?Q?ave9IFKSZvzW63a2DXKjFwApWPxWvY0dZ1D1m5l+EteWyFk2pLmKPnyDt3pi?=
 =?us-ascii?Q?6m7vts+OBxeuosrg44ztKepyi7L2W7rfb9Vz9KQVsOiGi244giDhGAPw9+TZ?=
 =?us-ascii?Q?Scp+6JBRp4/aaglkYeCKsX/+AMCtvcxBfCpjXYgXpywuy75FKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:28.2038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c1a66-6dc2-4464-8ee6-08dcfa7c24f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
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

From: Kaitlyn Tse <Kaitlyn.Tse@amd.com>

[Why]
Implement the new backlight_level_params structure as part of the VBAC
framework, the information in this structure is needed to be passed down
to the DMCUB to identify the backlight control type, to adjust the
backlight of the panel and to perform any required conversions from PWM
to nits or vice versa.

[How]
Modified existing functions to include the new backlight_level_params
structure.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Kaitlyn Tse <Kaitlyn.Tse@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 ++-
 .../drm/amd/display/dc/core/dc_link_exports.c |  5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 27 ++++++++++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 +--
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 16 +++---
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 49 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h   |  3 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  5 --
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  3 +-
 .../link/protocols/link_edp_panel_control.c   | 17 ++++---
 .../link/protocols/link_edp_panel_control.h   |  3 +-
 20 files changed, 119 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f3e8975cb2fa..00e0a10add86 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4640,7 +4640,12 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 		if (!rc)
 			DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", bl_idx);
 	} else {
-		rc = dc_link_set_backlight_level(link, brightness, 0);
+		struct set_backlight_level_params backlight_level_params = { 0 };
+
+		backlight_level_params.backlight_pwm_u16_16 = brightness;
+		backlight_level_params.transition_time_in_ms = 0;
+
+		rc = dc_link_set_backlight_level(link, &backlight_level_params);
 		if (!rc)
 			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index dfdfe22d9e85..457d60eeb486 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -430,11 +430,10 @@ bool dc_link_get_backlight_level_nits(struct dc_link *link,
 }
 
 bool dc_link_set_backlight_level(const struct dc_link *link,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp)
+		struct set_backlight_level_params *backlight_level_params)
 {
 	return link->dc->link_srv->edp_set_backlight_level(link,
-			backlight_pwm_u16_16, frame_ramp);
+			backlight_level_params);
 }
 
 bool dc_link_set_backlight_level_nits(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 76130bbf2fe4..5cb58ca77890 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -225,6 +225,7 @@ struct dc_dmub_caps {
 	bool subvp_psr;
 	bool gecc_enable;
 	uint8_t fams_ver;
+	bool aux_backlight_support;
 };
 
 struct dc_scl_caps {
@@ -2210,8 +2211,7 @@ void dc_link_edp_panel_backlight_power_on(struct dc_link *link,
  * and 16 bit fractional, where 1.0 is max backlight value.
  */
 bool dc_link_set_backlight_level(const struct dc_link *dc_link,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp);
+		struct set_backlight_level_params *backlight_level_params);
 
 /* Set/get nits-based backlight level of an embedded panel (eDP, LVDS). */
 bool dc_link_set_backlight_level_nits(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index f0776484abb7..1fd030e3f4be 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1303,4 +1303,31 @@ struct dc_commit_streams_params {
 	enum dc_power_source_type power_source;
 };
 
+struct set_backlight_level_params {
+	/* backlight in pwm */
+	uint32_t backlight_pwm_u16_16;
+	/* brightness ramping */
+	uint32_t frame_ramp;
+	/* backlight control type
+	 * 0: PWM backlight control
+	 * 1: VESA AUX backlight control
+	 * 2: AMD AUX backlight control
+	 */
+	enum backlight_control_type control_type;
+	/* backlight in millinits */
+	uint32_t backlight_millinits;
+	/* transition time in ms */
+	uint32_t transition_time_in_ms;
+	/* minimum luminance in nits */
+	uint32_t min_luminance;
+	/* maximum luminance in nits */
+	uint32_t max_luminance;
+	/* minimum backlight in pwm */
+	uint32_t min_backlight_pwm;
+	/* maximum backlight in pwm */
+	uint32_t max_backlight_pwm;
+	/* AUX HW instance */
+	uint8_t aux_inst;
+};
+
 #endif /* DC_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 427fd6ea062a..81f4c386c287 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3143,10 +3143,10 @@ static void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
 }
 
 bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
-	struct set_backlight_level_params *params)
+	struct set_backlight_level_params *backlight_level_params)
 {
-	uint32_t backlight_pwm_u16_16 = params->backlight_pwm_u16_16;
-	uint32_t frame_ramp = params->frame_ramp;
+	uint32_t backlight_pwm_u16_16 = backlight_level_params->backlight_pwm_u16_16;
+	uint32_t frame_ramp = backlight_level_params->frame_ramp;
 	struct dc_link *link = pipe_ctx->stream->link;
 	struct dc  *dc = link->ctx->dc;
 	struct abm *abm = pipe_ctx->stream_res.abm;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 630e05f32c80..61efb15572ff 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -137,7 +137,7 @@ void dcn21_PLAT_58856_wa(struct dc_state *context, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dpms_off = true;
 }
 
-static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
+bool dcn21_dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
 		uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst)
 {
 	union dmub_rb_cmd cmd;
@@ -199,7 +199,7 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
 					panel_cntl->inst, panel_cntl->pwrseq_inst);
 		} else {
-				dmub_abm_set_pipe(abm,
+			dcn21_dmub_abm_set_pipe(abm,
 						otg_inst,
 						SET_ABM_PIPE_IMMEDIATELY_DISABLE,
 						panel_cntl->inst,
@@ -234,7 +234,7 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 					panel_cntl->inst,
 					panel_cntl->pwrseq_inst);
 	} else {
-		dmub_abm_set_pipe(abm, otg_inst,
+			dcn21_dmub_abm_set_pipe(abm, otg_inst,
 				  SET_ABM_PIPE_NORMAL,
 				  panel_cntl->inst,
 				  panel_cntl->pwrseq_inst);
@@ -242,15 +242,15 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 }
 
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
-	struct set_backlight_level_params *params)
+	struct set_backlight_level_params *backlight_level_params)
 {
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	uint32_t otg_inst;
-	uint32_t backlight_pwm_u16_16 = params->backlight_pwm_u16_16;
-	uint32_t frame_ramp = params->frame_ramp;
+	uint32_t backlight_pwm_u16_16 = backlight_level_params->backlight_pwm_u16_16;
+	uint32_t frame_ramp = backlight_level_params->frame_ramp;
 
 	if (!abm || !tg || !panel_cntl)
 		return false;
@@ -258,7 +258,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	otg_inst = tg->inst;
 
 	if (dc->dc->res_pool->dmcu) {
-		dce110_set_backlight_level(pipe_ctx, params);
+		dce110_set_backlight_level(pipe_ctx, backlight_level_params);
 		return true;
 	}
 
@@ -269,7 +269,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 					panel_cntl->inst,
 					panel_cntl->pwrseq_inst);
 	} else {
-		dmub_abm_set_pipe(abm,
+			dcn21_dmub_abm_set_pipe(abm,
 				  otg_inst,
 				  SET_ABM_PIPE_NORMAL,
 				  panel_cntl->inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
index a7eaaa4596be..f72a27ac1bf1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
@@ -47,6 +47,8 @@ void dcn21_optimize_pwr_state(
 void dcn21_PLAT_58856_wa(struct dc_state *context,
 		struct pipe_ctx *pipe_ctx);
 
+bool dcn21_dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
+	uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst);
 void dcn21_set_pipe(struct pipe_ctx *pipe_ctx);
 void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index bfc78a42bc2a..036cb7e9b5bb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -47,9 +47,11 @@
 #include "dce/dmub_outbox.h"
 #include "link.h"
 #include "dcn10/dcn10_hwseq.h"
+#include "dcn21/dcn21_hwseq.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
 #include "dce/dce_i2c_hw.h"
+#include "dce/dmub_abm_lcd.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -638,3 +640,50 @@ void dcn31_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 		pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(pipe_ctx[i]->stream_res.tg,
 					triggers, params->num_frames);
 }
+
+static void dmub_abm_set_backlight(struct dc_context *dc,
+	struct set_backlight_level_params *backlight_level_params, uint32_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
+	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = backlight_level_params->frame_ramp;
+	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_level_params->backlight_pwm_u16_16;
+	cmd.abm_set_backlight.abm_set_backlight_data.backlight_control_type = backlight_level_params->control_type;
+	cmd.abm_set_backlight.abm_set_backlight_data.min_luminance = backlight_level_params->min_luminance;
+	cmd.abm_set_backlight.abm_set_backlight_data.max_luminance = backlight_level_params->max_luminance;
+	cmd.abm_set_backlight.abm_set_backlight_data.min_backlight_pwm = backlight_level_params->min_backlight_pwm;
+	cmd.abm_set_backlight.abm_set_backlight_data.max_backlight_pwm = backlight_level_params->max_backlight_pwm;
+	cmd.abm_set_backlight.abm_set_backlight_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_set_backlight.abm_set_backlight_data.panel_mask = (0x01 << panel_inst);
+	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
+bool dcn31_set_backlight_level(struct pipe_ctx *pipe_ctx,
+	struct set_backlight_level_params *backlight_level_params)
+{
+	struct dc_context *dc = pipe_ctx->stream->ctx;
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	uint32_t otg_inst;
+
+	if (!abm || !tg || !panel_cntl)
+		return false;
+
+	otg_inst = tg->inst;
+
+		dcn21_dmub_abm_set_pipe(abm,
+			otg_inst,
+			SET_ABM_PIPE_NORMAL,
+			panel_cntl->inst,
+			panel_cntl->pwrseq_inst);
+
+	dmub_abm_set_backlight(dc, backlight_level_params, panel_cntl->inst);
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
index b8bc939da155..0d09aa8cfb65 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
@@ -51,6 +51,8 @@ int dcn31_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_
 void dcn31_reset_hw_ctx_wrap(
 		struct dc *dc,
 		struct dc_state *context);
+bool dcn31_set_backlight_level(struct pipe_ctx *pipe_ctx,
+		struct set_backlight_level_params *params);
 bool dcn31_is_abm_supported(struct dc *dc,
 		struct dc_state *context, struct dc_stream_state *stream);
 void dcn31_init_pipes(struct dc *dc, struct dc_state *context);
@@ -59,5 +61,4 @@ void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable);
 void dcn31_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 		int num_pipes, const struct dc_static_screen_params *params);
 
-
 #endif /* __DC_HWSS_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 56f3c70d4b55..5f8f45b48720 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -98,7 +98,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.set_backlight_level = dcn21_set_backlight_level,
+	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 68e6de6b5758..6bdfbf22ce87 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -100,7 +100,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.set_backlight_level = dcn21_set_backlight_level,
+	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index dbcd2dfb19c1..5ecee7e320da 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -98,7 +98,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.apply_idle_power_optimizations = dcn32_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
-	.set_backlight_level = dcn21_set_backlight_level,
+	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn30_hardware_release,
 	.set_pipe = dcn21_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 3cb4e9907411..e599cdc465bf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -309,6 +309,7 @@ void dcn35_init_hw(struct dc *dc)
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
+		dc->caps.dmub_caps.aux_backlight_support = dc->ctx->dmub_srv->dmub->feature_caps.abm_aux_backlight_support;
 	}
 
 	if (dc->res_pool->pg_cntl) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 55dc5799e725..fd67779c27a9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -101,7 +101,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.set_backlight_level = dcn21_set_backlight_level,
+	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index a93864b63d48..3c275a1eff58 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -100,7 +100,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.set_backlight_level = dcn21_set_backlight_level,
+	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index c73305e57d39..23e4f208152e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -77,7 +77,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.apply_idle_power_optimizations = dcn401_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
-	.set_backlight_level = dcn21_set_backlight_level,
+	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn401_hardware_release,
 	.set_pipe = dcn21_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 1df17c54f3a9..66fdc5805d0a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -174,11 +174,6 @@ union block_sequence_params {
 	struct fams2_global_control_lock_fast_params fams2_global_control_lock_fast_params;
 };
 
-struct set_backlight_level_params {
-	uint32_t backlight_pwm_u16_16;
-	uint32_t frame_ramp;
-};
-
 enum block_sequence_func {
 	DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST = 0,
 	OPTC_PIPE_CONTROL_LOCK,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 72a8479e1f2d..f04292086c08 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -248,8 +248,7 @@ struct link_service {
 			uint32_t *backlight_millinits_avg,
 			uint32_t *backlight_millinits_peak);
 	bool (*edp_set_backlight_level)(const struct dc_link *link,
-			uint32_t backlight_pwm_u16_16,
-			uint32_t frame_ramp);
+			struct set_backlight_level_params *backlight_level_params);
 	bool (*edp_set_backlight_level_nits)(struct dc_link *link,
 			bool isHDR,
 			uint32_t backlight_millinits,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 43a467f6ce7b..e0e3bb865359 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -161,7 +161,9 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 			link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
-	if (link->backlight_control_type == BACKLIGHT_CONTROL_VESA_AUX) {
+	// use internal backlight control if dmub capabilities are not present
+	if (link->backlight_control_type == BACKLIGHT_CONTROL_VESA_AUX &&
+		!link->dc->caps.dmub_caps.aux_backlight_support) {
 		uint8_t backlight_enable = 0;
 		struct target_luminance_value *target_luminance = NULL;
 
@@ -185,7 +187,7 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 			(uint8_t *)(target_luminance),
 			sizeof(struct target_luminance_value)) != DC_OK)
 			return false;
-	} else {
+	} else if (link->backlight_control_type == BACKLIGHT_CONTROL_AMD_AUX) {
 		struct dpcd_source_backlight_set dpcd_backlight_set;
 		*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits;
 		*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
@@ -517,17 +519,17 @@ static struct pipe_ctx *get_pipe_from_link(const struct dc_link *link)
 }
 
 bool edp_set_backlight_level(const struct dc_link *link,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp)
+		struct set_backlight_level_params *backlight_level_params)
 {
 	struct dc  *dc = link->ctx->dc;
+	uint32_t backlight_pwm_u16_16 = backlight_level_params->backlight_pwm_u16_16;
+	uint32_t frame_ramp = backlight_level_params->frame_ramp;
 	DC_LOGGER_INIT(link->ctx->logger);
 	DC_LOG_BACKLIGHT("New Backlight level: %d (0x%X)\n",
 			backlight_pwm_u16_16, backlight_pwm_u16_16);
 
 	if (dc_is_embedded_signal(link->connector_signal)) {
 		struct pipe_ctx *pipe_ctx = get_pipe_from_link(link);
-		struct set_backlight_level_params backlight_level_param = { 0 };
 
 		if (link->panel_cntl)
 			link->panel_cntl->stored_backlight_registers.USER_LEVEL = backlight_pwm_u16_16;
@@ -542,12 +544,11 @@ bool edp_set_backlight_level(const struct dc_link *link,
 			return false;
 		}
 
-		backlight_level_param.backlight_pwm_u16_16 = backlight_pwm_u16_16;
-		backlight_level_param.frame_ramp = frame_ramp;
+		backlight_level_params->frame_ramp = frame_ramp;
 
 		dc->hwss.set_backlight_level(
 				pipe_ctx,
-				&backlight_level_param);
+				backlight_level_params);
 	}
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 30dc8c24c008..bcfa6ac5d4e7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -36,8 +36,7 @@ bool edp_get_backlight_level_nits(struct dc_link *link,
 		uint32_t *backlight_millinits_avg,
 		uint32_t *backlight_millinits_peak);
 bool edp_set_backlight_level(const struct dc_link *link,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp);
+		struct set_backlight_level_params *backlight_level_params);
 bool edp_set_backlight_level_nits(struct dc_link *link,
 		bool isHDR,
 		uint32_t backlight_millinits,
-- 
2.34.1

