Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679A6C5320E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA36110E54F;
	Thu, 15 Aug 2024 22:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RkEgKwkJ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB8B10E541
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rrmy2MTA5BQ4lyAapjOmqbd88MOYaA7T6lX2d9TlAmCVp9AyksUDEF9Bdgy00MdnigoIpq/NyCk8gBf7MnahaVX5QKh15iTmAXU0Xby6e+wJXYoA64BZCWy2UN9R8c14p+ZMUZBLuUsryxmuF9zLDbdj4urKf6j6USeb0eZ0dtO+7iGYVrkVFj4lQIdC/fgrdqS8vS74MFnGibLMeRyFnI1if8zXEQ6IrOxLQ4jpbt0r5gtcPcVP66ZeySSiMbbF5ez8fGu9OPgS9LsGqnA52mR7WgZQn12aAX4I73qgYVLOHUFEImQnjL/XB45BhcM0572oHTG4gwUWRufSOR8ftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99kzDV0iYTH8JgabDzL3w8zQa0H7sMYnMAGw50r63LU=;
 b=R5HGYjFYEeOUPB5f5/CndM1FzbAeCpy1dDTDR6SNqMtVme3kMSrmICQtVszTKVPJnomP2yiO9D9SdA3EV/V/zKYTAWMEeoj9yBbbKxhdmzRqORxorsnoh6BxYs9jVMa53i6F66sgWTq73StYJSm8EoNH0neHdI/Vr4dUHMwj5L3jIUgocKm43pPn+MOEHCZ7dAfbUsEpnruD1X+kURMGbB7cus40J/zmSM7D46MzkDlt+U1aPN12Uznu7nIK2UikmEcoFnH04iaVPZIWPGtD6h2Rm+zeo/DwuBtfq6HCzgb0z2VxUOcHJUx85WT11xJxwNYg9WxSIMhVAVbuKsUHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99kzDV0iYTH8JgabDzL3w8zQa0H7sMYnMAGw50r63LU=;
 b=RkEgKwkJDdAhkcm8mwSXXAcVcDocRodxSXvXaVd6dKbqivD2dRYdI8TbvlwV8qiYK673GG5P5nm+Ks/rtd2Gb2F5qA+jRCOaXAuEPhMu3kdAhpTPrhYRvQB5SZJTX8SrORWbyh7+pcQ2csGw9IlY4UkOzkcwpBFMDetOMM6AvaA=
Received: from BN0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:e7::9)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 22:45:42 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::c4) by BN0PR03CA0034.outlook.office365.com
 (2603:10b6:408:e7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:41 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:40 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 05/13] drm/amd/display: Allow UHBR Interop With eDP Supported
 Link Rates Table
Date: Thu, 15 Aug 2024 18:45:17 -0400
Message-ID: <20240815224525.3077505-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9f625f-1af0-4181-59d9-08dcbd7bfe17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LHBmSpCrTZWy64qXzXYSMyZ8xTprustl2lrAwwnDFVhbTluA0JWZJcPE1/Tm?=
 =?us-ascii?Q?IZE3OOEgw3x5vcLFjvGvx/icGX1+2bQO3NyHYT2HgejT66XmSWbQ/iz7bOJe?=
 =?us-ascii?Q?cnpjlzRK/OQ7CpgXlY6VtM40EhLmBTIcKbzMklZ8Dx4LeiWjW6tfjMIe326w?=
 =?us-ascii?Q?/XlalLaAHsAbketZW4JTpsnRFoSrnE1TurVZkszYJej0FlhSQnXRE+X+H4ZF?=
 =?us-ascii?Q?qb3KqejpHVT31prBh+RkxeThXbhUf5SC7xmQ5Zby9EcM19Lbat/87Nj1D1XR?=
 =?us-ascii?Q?DAkJi4DbhZLgWNYEZ8HXFyjfDhqIP02jKI7ZoeH6zYo/OrIcGjT+8FeSMbkc?=
 =?us-ascii?Q?0llVv++VOumeJY86u4jCIXcZOR+cWzWp3XFL5EYlw18FExjyF4rEa22W+uO3?=
 =?us-ascii?Q?1Sp2HWlPCYFORms1QQqiBfmLmK39vcNiKt+n7B4GhF3Zm0ba7GbKoocWMj6A?=
 =?us-ascii?Q?0FIp3bxi2y2tU09I0udf7muh1A6MoHLkKiIIvj5qj75kYXTcnexKa/CBe8Tz?=
 =?us-ascii?Q?ZEeCv7NXYebCvcpD6xTTxE0wQ7lomvY2B+ITZ5PUeyNO+oC22V8i9ckvH73q?=
 =?us-ascii?Q?v5fTf6upOylNTqAVA3uwm0PrkMAsqHZRQtLlJoGgwLB9ng/vWlTnwzfZF0p5?=
 =?us-ascii?Q?CGQlhLqEpw3CAuhNZLc8loF3p7Gj8ozsm7luAOflLWAMU6XrWc56IDd9kXIh?=
 =?us-ascii?Q?njnGRjTCaD6uPwXpmWPtkXyiCg0v3jIBZ0EvqkbQKWyl4EUAbuhslHXcT5JH?=
 =?us-ascii?Q?uK19OxctfffySQ6Bac7l3UqvSCq3M4bTao+WFzSGdn5A3/R5KiwJGT6auI/J?=
 =?us-ascii?Q?AEA399goLoCwKHTZJK47C86v7fg4dLfM4Ic+GRLJ0SJ1qJwowNAVpbP3jTUG?=
 =?us-ascii?Q?OLYgV3Spp4+9/stFArD2fi7bRDvo0N+K1rwGMLu08QqLBYM7ok74EialHXY3?=
 =?us-ascii?Q?FK0krWi6lFdu0/xYt1ysJ3gHzsobHKP6dpANY3WMlOZAYwoevf/xOSm2/j8U?=
 =?us-ascii?Q?FlL5f9LwfOuRrms0ba8PT+SEznFiNwdYVEyoJGp59TSVbNuGuNKXwmS6LdzI?=
 =?us-ascii?Q?DeQYP9NGCxLyfTZcsCNWhCdXzOfNAUAg2XydrbYemt2d7zRDybEeJiZZW7FT?=
 =?us-ascii?Q?lsoAxrqctLR2gYRdled3U1Rsd1UsN8kCU6SXKqXWZvxP/5QkYMm7Qa526PLi?=
 =?us-ascii?Q?PLXV5sAWOG/M67aK/DwCbDf+qp6MM70NWjKI9hLDQ+QHcXhMtZzC+a8m1rl7?=
 =?us-ascii?Q?+vgC7J9Y1URlIiep3lhU5VMXLqeagJ8NDZdxf+2zkak0k6kPBdG7YPrir/Kj?=
 =?us-ascii?Q?PbpX/efpQZ4HSOhvg78egAe+bkbEfNz+Si/SBrbr/844IIwZjimXKEtQdytr?=
 =?us-ascii?Q?3cq/2Vx8gPwUvdUXBUlxTCvJ3dGDSp4TYzWKFqi5meXUMS3fftpJUubCIVcC?=
 =?us-ascii?Q?SNvJQhEcf8azJaH23sIBRJVDnpBMxXj2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:42.0713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9f625f-1af0-4181-59d9-08dcbd7bfe17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
eDP 2.0 is introducing support for UHBR link rates, however current eDP ILR
link optimization does not account for UHBR capabilities.
Either UHBR capabilities will be provided via the same 128b/132b rate DPCD caps
that are currently used on DP2.1, or Table 4-13 may be updated to include UHBR
rates.

[HOW]
Add extra Supported Link Rates table translations for UHBR10/13.5/20.
Update eDP link setting optimization search to be aware of 128b/132b DPCD
rate caps in order to unblock UHBR on panels with Supported Link Rates table.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/link/link_detection.c  |  3 +-
 .../dc/link/protocols/link_dp_capability.c    | 59 ++++++++++---------
 .../link/protocols/link_edp_panel_control.c   | 11 ++--
 .../link/protocols/link_edp_panel_control.h   |  2 +-
 4 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 391dbe81534d..d21ee9d12d26 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1189,8 +1189,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			//sink only can use supported link rate table, we are foreced to enable it
 			if (link->reported_link_cap.link_rate == LINK_RATE_UNKNOWN)
 				link->panel_config.ilr.optimize_edp_link_rate = true;
-			if (edp_is_ilr_optimization_enabled(link))
-				link->reported_link_cap.link_rate = get_max_link_rate_from_ilr_table(link);
+			link->reported_link_cap.link_rate = get_max_edp_link_rate(link);
 		}
 
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 59c9dde10885..34a618a7278b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -212,6 +212,13 @@ static enum dc_link_rate linkRateInKHzToLinkRateMultiplier(uint32_t link_rate_in
 	case 10000000:
 		link_rate = LINK_RATE_UHBR10;	// UHBR10 - 10.0 Gbps/Lane
 		break;
+	case 13500000:
+		link_rate = LINK_RATE_UHBR13_5;	// UHBR13.5 - 13.5 Gbps/Lane
+		break;
+	case 20000000:
+		link_rate = LINK_RATE_UHBR20;	// UHBR20 - 20.0 Gbps/Lane
+		break;
+
 	default:
 		link_rate = LINK_RATE_UNKNOWN;
 		break;
@@ -541,6 +548,23 @@ static enum dc_link_rate increase_link_rate(struct dc_link *link,
 	}
 }
 
+static void increase_edp_link_rate(struct dc_link *link,
+		struct dc_link_settings *current_link_setting)
+{
+	if (current_link_setting->use_link_rate_set) {
+		if (current_link_setting->link_rate_set < link->dpcd_caps.edp_supported_link_rates_count) {
+			current_link_setting->link_rate_set++;
+			current_link_setting->link_rate =
+				link->dpcd_caps.edp_supported_link_rates[current_link_setting->link_rate_set];
+		} else {
+			current_link_setting->use_link_rate_set = false;
+			current_link_setting->link_rate = LINK_RATE_UHBR10;
+		}
+	} else {
+		current_link_setting->link_rate = increase_link_rate(link, current_link_setting->link_rate);
+	}
+}
+
 static bool decide_fallback_link_setting_max_bw_policy(
 		struct dc_link *link,
 		const struct dc_link_settings *max,
@@ -759,14 +783,7 @@ bool edp_decide_link_settings(struct dc_link *link,
 					increase_lane_count(
 							current_link_setting.lane_count);
 		} else {
-			if (current_link_setting.link_rate_set < link->dpcd_caps.edp_supported_link_rates_count) {
-				current_link_setting.link_rate_set++;
-				current_link_setting.link_rate =
-					link->dpcd_caps.edp_supported_link_rates[current_link_setting.link_rate_set];
-				current_link_setting.lane_count =
-									initial_link_setting.lane_count;
-			} else
-				break;
+			increase_edp_link_rate(link, &current_link_setting);
 		}
 	}
 	return false;
@@ -818,9 +835,7 @@ bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 			if (policy) {
 				/* minimize lane */
 				if (current_link_setting.link_rate < max_link_rate) {
-					current_link_setting.link_rate =
-							increase_link_rate(link,
-									current_link_setting.link_rate);
+					increase_edp_link_rate(link, &current_link_setting);
 				} else {
 					if (current_link_setting.lane_count <
 									link->verified_link_cap.lane_count) {
@@ -839,9 +854,7 @@ bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 							increase_lane_count(
 									current_link_setting.lane_count);
 				} else {
-					current_link_setting.link_rate =
-							increase_link_rate(link,
-									current_link_setting.link_rate);
+					increase_edp_link_rate(link, &current_link_setting);
 					current_link_setting.lane_count =
 							initial_link_setting.lane_count;
 				}
@@ -874,18 +887,15 @@ bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 		}
 		if (policy) {
 			/* minimize lane */
-			if (current_link_setting.link_rate_set <
-					link->dpcd_caps.edp_supported_link_rates_count
-					&& current_link_setting.link_rate < max_link_rate) {
-				current_link_setting.link_rate_set++;
-				current_link_setting.link_rate =
-					link->dpcd_caps.edp_supported_link_rates[current_link_setting.link_rate_set];
+			if (current_link_setting.link_rate < max_link_rate) {
+				increase_edp_link_rate(link, &current_link_setting);
 			} else {
 				if (current_link_setting.lane_count < link->verified_link_cap.lane_count) {
 					current_link_setting.lane_count =
 							increase_lane_count(
 									current_link_setting.lane_count);
 					current_link_setting.link_rate_set = initial_link_setting.link_rate_set;
+					current_link_setting.use_link_rate_set = initial_link_setting.use_link_rate_set;
 					current_link_setting.link_rate =
 						link->dpcd_caps.edp_supported_link_rates[current_link_setting.link_rate_set];
 				} else
@@ -899,13 +909,8 @@ bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 						increase_lane_count(
 								current_link_setting.lane_count);
 			} else {
-				if (current_link_setting.link_rate_set < link->dpcd_caps.edp_supported_link_rates_count) {
-					current_link_setting.link_rate_set++;
-					current_link_setting.link_rate =
-						link->dpcd_caps.edp_supported_link_rates[current_link_setting.link_rate_set];
-					current_link_setting.lane_count =
-						initial_link_setting.lane_count;
-				} else
+				increase_edp_link_rate(link, &current_link_setting);
+				if (current_link_setting.link_rate == LINK_RATE_UNKNOWN)
 					break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index bf820d2b4dc4..070b6c8c1aef 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -305,16 +305,17 @@ bool edp_is_ilr_optimization_enabled(struct dc_link *link)
 	return true;
 }
 
-enum dc_link_rate get_max_link_rate_from_ilr_table(struct dc_link *link)
+enum dc_link_rate get_max_edp_link_rate(struct dc_link *link)
 {
-	enum dc_link_rate link_rate = link->reported_link_cap.link_rate;
+	enum dc_link_rate max_ilr_rate = LINK_RATE_UNKNOWN;
+	enum dc_link_rate max_non_ilr_rate = dp_get_max_link_cap(link).link_rate;
 
 	for (int i = 0; i < link->dpcd_caps.edp_supported_link_rates_count; i++) {
-		if (link_rate < link->dpcd_caps.edp_supported_link_rates[i])
-			link_rate = link->dpcd_caps.edp_supported_link_rates[i];
+		if (max_ilr_rate < link->dpcd_caps.edp_supported_link_rates[i])
+			max_ilr_rate = link->dpcd_caps.edp_supported_link_rates[i];
 	}
 
-	return link_rate;
+	return (max_ilr_rate > max_non_ilr_rate ? max_ilr_rate : max_non_ilr_rate);
 }
 
 bool edp_is_ilr_optimization_required(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 8df8ac5bde5b..30dc8c24c008 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -69,7 +69,7 @@ bool edp_wait_for_t12(struct dc_link *link);
 bool edp_is_ilr_optimization_required(struct dc_link *link,
        struct dc_crtc_timing *crtc_timing);
 bool edp_is_ilr_optimization_enabled(struct dc_link *link);
-enum dc_link_rate get_max_link_rate_from_ilr_table(struct dc_link *link);
+enum dc_link_rate get_max_edp_link_rate(struct dc_link *link);
 bool edp_backlight_enable_aux(struct dc_link *link, bool enable);
 void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
-- 
2.34.1

