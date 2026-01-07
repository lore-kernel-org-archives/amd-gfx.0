Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81B5CFD647
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6882A10E62C;
	Wed,  7 Jan 2026 15:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="25SevJdE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4B010E624
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLPngIsibgrvWtiEUXBR7fWa2gzn7xclr3awJTktZP6QWIyoCzdLdx11l0HeVR/7KapQ9gYRAJDc5pi3oqbyig303suo4625dSOrKoeK60UAEXz9w2Gnoj14I/DNx+QnHWiFJlXKJPJfE80y3nLBJazpg2+BQl+D8F3vFodJwa436vvKapUtBsJm5NBchn9V7v21IRvJU/e4Im3QRWC2BPOl3/31KtWIr1jIHYpCbli+i9BZD/9/umN8jp5O7PkyKXoVkNZOYFAuL52Uq9wsl3iscawV0sF6FBbaaQ5nbpxBygUy5BtCoBF7t7ZWPnCOo70CPChSns6uPThNp02nxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LKPF7k8pdCjoqAiKrNCMtN0HvgA0cWS6dsc38fhfgs=;
 b=eJCGMWR4h0EoFjxjffDtbIeJGcRyicCbVnn3KVD6VkLyMbvHo0qP+9ZiNYCidpvDCnKc4uev9R6uePvocpKgRmhJ4AcZiJTB+wYlh4RI3Ju94IGbr6Q4RdhKEUA/IUI1RApaCOK5Z+0maguaM83Cm1d/WuJBBFMxNkq2/us+qgSB/vpEa7r5ANbpZHyFZEdo5HOMTGfq2Bz+HJO7500gfOBJsi9qFfTFL0Ql+ECOZqzYDLzvlCSLzuWXGF3rjFxpxlNRgrWDCKsxM+H5l0vNzNKotog33K1cwu92YptO5VH9Z/IiFl3POOAcXKD/+8hSp4UhgNhc2srcGH/0wajAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LKPF7k8pdCjoqAiKrNCMtN0HvgA0cWS6dsc38fhfgs=;
 b=25SevJdEDYECXBK36r81W070r7gFqNE4iHrURFxzAUKtYt18QkH48bP8KpT/rQNSDc8nWzXwqENCiSTPzpoEiDKb/7+ej90YpFxdQVa/4xOrBQOF6+sNge0LeQySiCAb+8L+U71LMjqeeiWvTM6LHm+Hg4yfSdGgks1PxSuGa5o=
Received: from SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 15:57:58 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::7c) by SJ0PR03CA0202.outlook.office365.com
 (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:57:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:57 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:56 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 06/21] drm/amd/display: DPCD for Selective Update
Date: Wed, 7 Jan 2026 10:47:58 -0500
Message-ID: <20260107155421.1999951-7-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7f73bb-3711-4d9f-7862-08de4e05871c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pI+YQ0sWen8765XoHjcWflCXbGuR78W3YBd6TgnqoK909j7BWWHgc0A/O1f9?=
 =?us-ascii?Q?ZcrZW7V0zRPSoQdIisjmjStBfVR+4M52iXSLh4sg/9ak7uNKmzqgIxoq1wq7?=
 =?us-ascii?Q?LWKmIMxhc7htwZHKUOFKex03kA8y/QMft+V8FrKrpj+E25Un/hbmYiuUskEx?=
 =?us-ascii?Q?A4gLvxZOIXaaK0t32ZEUWkRKFVGIg7pp9cG3mYx4yU7kDtfJpnobV9eTe5jr?=
 =?us-ascii?Q?nlT7Jr822GagFsepR33hjtXQthyLpmj7ewgLxrJkXIwlRTyYakdhY2H7msCu?=
 =?us-ascii?Q?oVIn3vbUvcxXdzB7TsBiYZ7/WKuw/oU5Qh2vExIvTMxpbRK6rjIs93H03Thl?=
 =?us-ascii?Q?bLOFRtTkRRkC3hPPZKcoIgOZb1MYeWCJP2Cvk4G15F2q7/jFndeeN2LiA79P?=
 =?us-ascii?Q?D9Y0yP2ceLJgJKj5Dkju1o8zTGK0gxNojDvqOotWvswtFMEeX0aJWtR77jfK?=
 =?us-ascii?Q?LV6h5Oc4vL++0mZ/mMxzPMYGfym2gbFSTXTsg+tVQPxjxpe82qJwvno6G2QF?=
 =?us-ascii?Q?CpXs+JHFaaW6hO+xVwv7BVrllTaK4zd0UcZURTsQUkFZQwJ0lV+dkGnzQAh5?=
 =?us-ascii?Q?ZbCcOgFzrz1EDeA4zOtNh8ib5vhv0CsLIam0pgJJdcJXKMTqeibzG5LHjR1p?=
 =?us-ascii?Q?Q91on+ehsVHklymhjaOep7aX+Zktkh0DQnaR4ca+uxz2E+9t9m8/ZeRY/ZRl?=
 =?us-ascii?Q?41Cm9klhX2uafHXkWjEUySHyi1UzFjLQ2DnP3SBneMHB7gGEnKTHErBiIDw1?=
 =?us-ascii?Q?HCs6M2mE1MfZLLlFI2bTiI90NJZzygI/gtVz6uFCib/H/6aI4Na1Dan1im7B?=
 =?us-ascii?Q?yQBEkkRoxQArlb53ON6m1Q6dSsUa5AE4apQX9T5EmK1HAx0Dc6bIfwMswldJ?=
 =?us-ascii?Q?UBB0YGrbcble3qOyqmJK9R/WFCb1bAm5oqR5ErYZhFnUsgsKr5twQEp5q+Ab?=
 =?us-ascii?Q?UKEFwi6ZsNpcJ9/0rodfBmoQ1ojtOjYfwGBMURpTohtybLd2cbzrHT0/GEJh?=
 =?us-ascii?Q?T/ImmX6pYW4yLbOK6mwT7nOToZ3JjXQI+NdPhVYhaxUMx44gAfWbFCxYNPRl?=
 =?us-ascii?Q?UXIZ+Fmvx9OK1cLaljt776T+N7M84jFKXHOPENBNkE2ROkSmseazIJZrSYcr?=
 =?us-ascii?Q?C55S5VMpcMgwWZEpeCaF1Wz0WjUXC8mj0OJ97avR8iz1xQG396kkF+nH+7cy?=
 =?us-ascii?Q?aovjR/Ia8S/vhP9XfiB85iAO0P6xAJ8HT5tgIX+a59CX42I7UGCBLn7VxUu4?=
 =?us-ascii?Q?FV5reUWdmGWdfsYUYzBkrpg1oZaB2lzFUQfWTnf3YAnDWwkO9zjbRE1QF1cs?=
 =?us-ascii?Q?87e9oKE2/BTd+9Fpw+s2soyMcVTbo3tV4p8vl0g4uNcwEFWOQVSTty9mc1Hz?=
 =?us-ascii?Q?IjfLZwgG0IMSDFPuZu6hu9mF/fn414C/9soGzH9keaCS5FBhCLtP2U2gxCGx?=
 =?us-ascii?Q?ohyd2WukikB3MCb769jPvsMzuxOGJsqmy8TVCO35aFo5AmqWEt+xjQsvqP1S?=
 =?us-ascii?Q?sZtp0ONH01mdEMbxpov4bbcYWlXtlqYq4ECLUSRiNUg3oJVAN6ZXINa5RCq4?=
 =?us-ascii?Q?cm7561SwrvU0dr4COOY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:57:58.0416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7f73bb-3711-4d9f-7862-08de4e05871c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470
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

From: Jack Chang <jack.chang@amd.com>

[Why&How]
Add flow to read selective update related info from DPCD,
and pass the info to DMUB.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 23 ++++++++-
 .../dc/link/protocols/link_dp_capability.c    | 47 ++++++++++++++++++-
 .../dc/link/protocols/link_dp_panel_replay.c  | 16 ++++++-
 .../gpu/drm/amd/display/include/dpcd_defs.h   | 15 ++++++
 4 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 273610d85438..d0d9297ccac0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1167,6 +1167,25 @@ union dpcd_panel_replay_capability_supported {
 	unsigned char raw;
 };
 
+union dpcd_panel_replay_capability {
+	struct {
+		unsigned char RESERVED								:2;
+		unsigned char DSC_DECODE_NOT_SUPPORTED				:1;
+		unsigned char ASYNC_VIDEO_TIMING_NOT_SUPPORTED		:1;
+		unsigned char DSC_CRC_OF_MULTI_SU_SUPPORTED			:1;
+		unsigned char PR_SU_GRANULARITY_NEEDED				:1;
+		unsigned char SU_Y_GRANULARITY_EXT_CAP_SUPPORTED	:1;
+		unsigned char LINK_OFF_SUPPORTED_IN_PR_ACTIVE		:1;
+	} bits;
+	unsigned char raw;
+};
+
+struct dpcd_panel_replay_selective_update_info {
+	uint16_t pr_su_x_granularity;
+	uint8_t pr_su_y_granularity;
+	uint16_t pr_su_y_granularity_extended_caps;
+};
+
 enum dpcd_downstream_port_max_bpc {
 	DOWN_STREAM_MAX_8BPC = 0,
 	DOWN_STREAM_MAX_10BPC,
@@ -1290,7 +1309,9 @@ struct dpcd_caps {
 	struct edp_psr_info psr_info;
 
 	struct replay_info pr_info;
-	union dpcd_panel_replay_capability_supported pr_caps_supported;
+	union dpcd_panel_replay_capability_supported vesa_replay_caps_supported;
+	union dpcd_panel_replay_capability vesa_replay_caps;
+	struct dpcd_panel_replay_selective_update_info vesa_replay_su_info;
 	uint16_t edp_oled_emission_rate;
 	union dp_receive_port0_cap receive_port0_cap;
 	/* Indicates the number of SST links supported by MSO (Multi-Stream Output) */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 54c417928b61..8bbf5637b166 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1593,6 +1593,41 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 	return true;
 }
 
+static void retrieve_vesa_replay_su_info(struct dc_link *link)
+{
+	uint8_t dpcd_data = 0;
+
+	core_link_read_dpcd(link,
+		DP_PR_SU_X_GRANULARITY_LOW,
+		&dpcd_data,
+		sizeof(dpcd_data));
+	link->dpcd_caps.vesa_replay_su_info.pr_su_x_granularity = dpcd_data;
+
+	core_link_read_dpcd(link,
+		DP_PR_SU_X_GRANULARITY_HIGH,
+		&dpcd_data,
+		sizeof(dpcd_data));
+	link->dpcd_caps.vesa_replay_su_info.pr_su_x_granularity |= (dpcd_data << 8);
+
+	core_link_read_dpcd(link,
+		DP_PR_SU_Y_GRANULARITY,
+		&dpcd_data,
+		sizeof(dpcd_data));
+	link->dpcd_caps.vesa_replay_su_info.pr_su_y_granularity = dpcd_data;
+
+	core_link_read_dpcd(link,
+		DP_PR_SU_Y_GRANULARITY_EXTENDED_CAP_LOW,
+		&dpcd_data,
+		sizeof(dpcd_data));
+	link->dpcd_caps.vesa_replay_su_info.pr_su_y_granularity_extended_caps = dpcd_data;
+
+	core_link_read_dpcd(link,
+		DP_PR_SU_Y_GRANULARITY_EXTENDED_CAP_HIGH,
+		&dpcd_data,
+		sizeof(dpcd_data));
+	link->dpcd_caps.vesa_replay_su_info.pr_su_y_granularity_extended_caps |= (dpcd_data << 8);
+}
+
 enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 {
 	uint8_t lttpr_dpcd_data[10] = {0};
@@ -2094,8 +2129,16 @@ static bool retrieve_link_cap(struct dc_link *link)
 
 	core_link_read_dpcd(link,
 			DP_PANEL_REPLAY_CAPABILITY_SUPPORT,
-			&link->dpcd_caps.pr_caps_supported.raw,
-			sizeof(link->dpcd_caps.pr_caps_supported.raw));
+			&link->dpcd_caps.vesa_replay_caps_supported.raw,
+			sizeof(link->dpcd_caps.vesa_replay_caps_supported.raw));
+
+	core_link_read_dpcd(link,
+			DP_PANEL_REPLAY_CAPABILITY,
+			&link->dpcd_caps.vesa_replay_caps.raw,
+			sizeof(link->dpcd_caps.vesa_replay_caps.raw));
+
+	/* Read VESA Panel Replay Selective Update caps */
+	retrieve_vesa_replay_su_info(link);
 
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index 3168c42d662c..fdbfa5103183 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -113,7 +113,10 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 		pr_config_1.bits.PANEL_REPLAY_EARLY_TRANSPORT_ENABLE = 1;
 
 		pr_config_2.bits.SINK_REFRESH_RATE_UNLOCK_GRANTED = 0;
-		pr_config_2.bits.SU_Y_GRANULARITY_EXT_VALUE_ENABLED = 0;
+
+		if (link->dpcd_caps.vesa_replay_caps.bits.SU_Y_GRANULARITY_EXT_CAP_SUPPORTED)
+			pr_config_2.bits.SU_Y_GRANULARITY_EXT_VALUE_ENABLED = 1;
+
 		pr_config_2.bits.SU_REGION_SCAN_LINE_CAPTURE_INDICATION = 0;
 
 		dm_helpers_dp_write_dpcd(link->ctx, link,
@@ -231,6 +234,17 @@ bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_con
 	cmd.pr_copy_settings.data.flags.bitfields.dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
 	cmd.pr_copy_settings.data.debug.u32All = link->replay_settings.config.debug_flags;
 
+	cmd.pr_copy_settings.data.su_granularity_needed = link->dpcd_caps.vesa_replay_caps.bits.PR_SU_GRANULARITY_NEEDED;
+	cmd.pr_copy_settings.data.su_x_granularity = link->dpcd_caps.vesa_replay_su_info.pr_su_x_granularity;
+	cmd.pr_copy_settings.data.su_y_granularity = link->dpcd_caps.vesa_replay_su_info.pr_su_y_granularity;
+	cmd.pr_copy_settings.data.su_y_granularity_extended_caps =
+		link->dpcd_caps.vesa_replay_su_info.pr_su_y_granularity_extended_caps;
+
+	if (pipe_ctx->stream->timing.dsc_cfg.num_slices_v > 0)
+		cmd.pr_copy_settings.data.dsc_slice_height = (pipe_ctx->stream->timing.v_addressable +
+			pipe_ctx->stream->timing.v_border_top + pipe_ctx->stream->timing.v_border_bottom) /
+			pipe_ctx->stream->timing.dsc_cfg.num_slices_v;
+
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index 8445c540f042..43d58df67bab 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -37,6 +37,21 @@
 #ifndef DP_PANEL_REPLAY_CAPABILITY // can remove this once the define gets into linux drm_dp_helper.h
 #define DP_PANEL_REPLAY_CAPABILITY 0x0b1
 #endif /* DP_PANEL_REPLAY_CAPABILITY */
+#ifndef DP_PR_SU_X_GRANULARITY_LOW         // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_SU_X_GRANULARITY_LOW			0x0b2
+#endif /* DP_PR_SU_X_GRANULARITY_LOW */
+#ifndef DP_PR_SU_X_GRANULARITY_HIGH        // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_SU_X_GRANULARITY_HIGH			0x0b3
+#endif /* DP_PR_SU_X_GRANULARITY_HIGH */
+#ifndef DP_PR_SU_Y_GRANULARITY             // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_SU_Y_GRANULARITY				0x0b4
+#endif /* DP_PR_SU_Y_GRANULARITY */
+#ifndef DP_PR_SU_Y_GRANULARITY_EXTENDED_CAP_LOW // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_SU_Y_GRANULARITY_EXTENDED_CAP_LOW		0x0b5
+#endif /* DP_PR_SU_Y_GRANULARITY_EXTENDED_CAP_LOW */
+#ifndef DP_PR_SU_Y_GRANULARITY_EXTENDED_CAP_HIGH // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_SU_Y_GRANULARITY_EXTENDED_CAP_HIGH	0x0b6
+#endif /* DP_PR_SU_Y_GRANULARITY_EXTENDED_CAP_HIGH */
 #ifndef DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1  // can remove this once the define gets into linux drm_dp_helper.h
 #define DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1  0x1b0
 #endif /* DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1 */
-- 
2.52.0

