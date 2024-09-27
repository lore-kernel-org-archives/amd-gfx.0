Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F08CDD1CD
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0023310ECF9;
	Fri, 27 Sep 2024 17:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DuMjMz/9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A516510ECF9
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exzmMINAwadiGi18stBXP3tXQPlMNmvUJ2oak9X4PuzbipPIvaFC18EVW4amJ2KBZ413TNTszxBnlWnlAF3ehXVrRGoxZrROF0e9QLBn9b+4N8iaP4FBONQDmCjVU7ShgYM8Z4PUPtzuPWtLm512WiTGpl/To4gc5Azavq4rJ12jnYxLnkMf5wVieLwsV6BAushx8Mmph82nekvrK2XcuOb5/ipAbAcs9tg/2wbNuurlNGOzN3IJan9cQVJCtciHrPratb48yVkDiPEEvpY48ONiukMDCxFA20S2GGtK93shh7fHLUwjoRc1z+O/Rwx88Bf6oXJ7OuY9089t7OKXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fcn9IfHe3UHFlFxNRPL95FBwF86TjCYT5gvwzAag+8s=;
 b=gSx8VCUQMSyDLyE0jhqgilcpN8C643S20z8ASf/Sl2hM47wp0JausU5pC4fKdojRAD8JzYrZPVGIJJLmZYEz5gDB/eQ5cHAYmYOCiR1IJVm608JmU/sXxAiv+tbYoH1fe3CROPVO3Had19aW5cnSjryHn51GEgr54G63oVKz23EtO23wDzXQTHkJbWoy6UonBiY5Bw/r45baKdUBuzmQI3/WpJn6IC1qz3jU/FAIuK6J4D5tvH3dc4vBWN3VTp3saYs79fVFNt0uSFWDUXcYxWVeU6Au5bQRC3iLuagWC2zek4/gM0PEoku6EBgevYU90KiSlj3ti3TIK9dLQ7merA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcn9IfHe3UHFlFxNRPL95FBwF86TjCYT5gvwzAag+8s=;
 b=DuMjMz/9O+UsQJlNcFLxR1kaLqw8S6LIoJscnalNEP39eeSucUxOFSgXGT57eL3XZ02RcUq7wFKjg1YtFDnzaY6xA16joFOkFhPfE+Aw14HrGBDVB3+ZOabLDBmnPnt9C9Dv4w3I33KvlmkPVCwOoIrTWPzg8PVHSSHzlUOYaZk=
Received: from PH0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::31)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 17:01:47 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::71) by PH0P220CA0007.outlook.office365.com
 (2603:10b6:510:d3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:44 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:43 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Muyuan Yang <muyuan.yang@amd.com>, Anthony Koo
 <anthony.koo@amd.com>
Subject: [PATCH 06/13] drm/amd/display: Introduce New ABC Framework for
 Brightness Control
Date: Fri, 27 Sep 2024 13:00:56 -0400
Message-ID: <20240927170103.102180-7-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 52325f68-ffd6-42b1-4dba-08dcdf161287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h4mt8FHDw8797E7n439A3t/Eo2hxmy+qFHYs5KQWca/Tmyc1JXr5qInFXXxc?=
 =?us-ascii?Q?WNJEr0Nta70pnV34cg9rFdIfnMXAcznxoW+q218xvOV48DLW1mfN6cc3okjR?=
 =?us-ascii?Q?Oh8YOagdANdkavkhJbXb0N3Zx9ema2Pn3Hm6Zjix6ldnIbCoRQvK45UtjDEU?=
 =?us-ascii?Q?s7buz5Wv42wkzdf3LASNPWFItzjum/3BWKYZzo+aq0H1Hte4kQ43X3O8tcJW?=
 =?us-ascii?Q?nyeJyTbaN4HFyYkAtAFmfUpL9vG26akFkEZQ5151qw8J8KvwL2AcCQUue/Cv?=
 =?us-ascii?Q?UlW3fjkv3LUfqTe4t1EiKHtxj3IE+7t5n6rx+wyQ/CyPWyKouQf9uk4KJvEC?=
 =?us-ascii?Q?g7aGFfPpw2E8NWUFsPjUD0DW/xuz3qfwY6bb9RVEVvSsuvG0cwAyL2jxqui/?=
 =?us-ascii?Q?7OBHoxS7GIcXXJwPnvYa+yP7QUFvlA+stqsf0IG6eNlIe5F0RWgjkts2ikpv?=
 =?us-ascii?Q?BEYHqw3GXbMMgzZ6r9dGGE/FCcNwTRTAvhspAi4gN76mVEcFf9Ht+8J2T5VB?=
 =?us-ascii?Q?K96Fx8UWYsSOU771Y3yPCbzBD3u4n/kGVSgCLn2bKRnMgf7fJhQYKOPUetDJ?=
 =?us-ascii?Q?E1IGGAq59/HBw07TsWP7yInk6HhnisOphtvfMNMcNrNmsK4w4CsZeIiYzd8q?=
 =?us-ascii?Q?fWpcq0B4wWsgSAbXThEv9b4BWhlB3LRvDK+ZyD4Sl8Ip7GMBzXD4IKCwYlgt?=
 =?us-ascii?Q?RB/LkX2GPeaVlnR/+WANL7abmNw7VVOvxN5ovHuGHa5abfzz3lPCi8FdDfPB?=
 =?us-ascii?Q?+893FNx2fpHwaFVHEyYQUqVi9xr29G5xR5ZZ3o7g9FM5QJK3t+sqqwbtmt3C?=
 =?us-ascii?Q?T+XM4Xblz+gXMO3qxR7hXXLrEAwo6oeGF8Im4bpP7My29cOrcbSyl5iS22lk?=
 =?us-ascii?Q?uxEnwH4UnMLbGxw05eRzSvvR/1ZgGX7n+7NYfl3unxs5QsUndw5q+iwtIRF0?=
 =?us-ascii?Q?F5E5f8QrJHMSFWIPGllC5p+p/hdDQx1OVERiVJ91GAyKko8DoV5g9wD2ZbA7?=
 =?us-ascii?Q?2/n85gO8LQwYOQGpjBUDfwiGo4iKDH7iD1Fst1ydBwNvH4SEFhHQ/+7JeKEn?=
 =?us-ascii?Q?RykYJEOJ9u2/WIYOmMQ+3xAJ38JsHMLO3woppCDGv5P1rgXvaLGnW/ALnPeT?=
 =?us-ascii?Q?vjIgT2z5CkQUXkRs6bEhYMJ7AjdRa803ouKF86q9wl7nUpQ+U76o8Psk8QQ5?=
 =?us-ascii?Q?yz8WXsKutKiSsJHhuc9FKKPjOgXzZhr0PRHoodE+5Si5x+YYx6dPqCQObm98?=
 =?us-ascii?Q?J/aKeeJGoZdddzQgN70vxDdlEdp9QTXoEWjfEjSe++YyAL4USbFpz9gM3kk9?=
 =?us-ascii?Q?qvdJfQ2TwL2KuU4C2/BUjclK+rJ7MVhgEVaZIVv5BfdlQ26es1rOQ50mKfzZ?=
 =?us-ascii?Q?u+GPCEYYZ7Nb2MROPOVVo4svnXNh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:47.1024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52325f68-ffd6-42b1-4dba-08dcdf161287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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

From: Muyuan Yang <muyuan.yang@amd.com>

Adjust the existing brightness control functions to use the new
ABC Framework and prioritize Aux-based brightness control.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Muyuan Yang <muyuan.yang@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../link/protocols/link_edp_panel_control.c   | 40 +++++++++----------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 070b6c8c1aef..7680bc8845d4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -157,31 +157,11 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 		uint32_t backlight_millinits,
 		uint32_t transition_time_in_ms)
 {
-	struct dpcd_source_backlight_set dpcd_backlight_set;
-	uint8_t backlight_control = isHDR ? 1 : 0;
-
 	if (!link || (link->connector_signal != SIGNAL_TYPE_EDP &&
 			link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
-	// OLEDs have no PWM, they can only use AUX
-	if (link->dpcd_sink_ext_caps.bits.oled == 1)
-		backlight_control = 1;
-
-	*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits;
-	*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
-
-
-	if (!link->dpcd_caps.panel_luminance_control) {
-		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
-			(uint8_t *)(&dpcd_backlight_set),
-			sizeof(dpcd_backlight_set)) != DC_OK)
-			return false;
-
-		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_CONTROL,
-			&backlight_control, 1) != DC_OK)
-			return false;
-	} else {
+	if (link->backlight_control_type == BACKLIGHT_CONTROL_VESA_AUX) {
 		uint8_t backlight_enable = 0;
 		struct target_luminance_value *target_luminance = NULL;
 
@@ -205,6 +185,24 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 			(uint8_t *)(target_luminance),
 			sizeof(struct target_luminance_value)) != DC_OK)
 			return false;
+	} else {
+		struct dpcd_source_backlight_set dpcd_backlight_set;
+		*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits;
+		*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
+
+		uint8_t backlight_control = isHDR ? 1 : 0;
+		// OLEDs have no PWM, they can only use AUX
+		if (link->dpcd_sink_ext_caps.bits.oled == 1)
+			backlight_control = 1;
+
+		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
+			(uint8_t *)(&dpcd_backlight_set),
+			sizeof(dpcd_backlight_set)) != DC_OK)
+			return false;
+
+		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_CONTROL,
+			&backlight_control, 1) != DC_OK)
+			return false;
 	}
 
 	return true;
-- 
2.34.1

