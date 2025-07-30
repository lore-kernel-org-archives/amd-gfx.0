Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD860C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747A810E6CB;
	Wed, 30 Jul 2025 19:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OHKMMHwA";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5797610E6CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSKehi/9HXQy4OoGMtccpD/M7eW8pSddhqX+dPE4vj4hKe/2Ru9sqSCAms3qD823Yv+oU5jwewZOPAmDMptugQ/jSqIq3jdawl7dM3SEwaRj6JJLrBfNlpOqYl4Izl9LBBGjJlJ4DB/By37wtGBeH+KokC59nJkhU9IW0L7GpXX3akmEeo6DZ/2UHsD/uMG2xpsLwHkbgsT1VvI3u2EvS/z4vHREDeok2bYiUdO90Lkwo/xsrdbYnoWMcb1kXFb9yg9iJNAs8DMmC0XPSO1L5+maYKhP9znlqjyPT/MOdL+qhjc5sZRQ/75zsQPfysnBZYO6WobYzkRz4YWYa4M9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpzluhwZOM8hIrOfEOm00SR1g+qy4KW3kiORnbw2TCo=;
 b=ApaCvWsMNWpeJiJm0oYLIMOvFscJas5vlRtLjt+vd6QdTFkP0mmes3W/oFa4Sv95DT0FBWllbmyUn90tCNn+vyP0FRzNKKSlUeiZPVO0pql5QfuY9rm2R67MleDO+UZP7g9UoqjQEOiiyTUWKkxEjeNJdMribsnE55u8HgNXtVTcj4L2g01d3DCQoZDnwcM+/jv2kriHL/+YHIeFMEO8ufjXsXGNHcbOuQX8MeGQc+6gD/RsSeLwjnCT4D03QxOoFjagLmIP/sYABy5Jdn+oSXVrfVPL3Z3YzsQ1JlVj28soGm5rL0iBjjYw+cu/rwbwra8mXgWrDWDf5kkbZZM/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpzluhwZOM8hIrOfEOm00SR1g+qy4KW3kiORnbw2TCo=;
 b=OHKMMHwA5DJpkizatPg4wSTpbn+ulX6Y4qHTnAm0acl52MfNNedLV1gM0L2vh4JOrZEzirNVqtB4bMOFZGreHyH0Rj1mTp8wfnbbqxJBK/re2LRLuXJofCebJgmH0Yr+4f0FQqFEI7xXg49Kq/0nH7yWe9VwpaH+zWgpS7Q9c64=
Received: from BN9PR03CA0776.namprd03.prod.outlook.com (2603:10b6:408:13a::31)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 19:02:27 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::6b) by BN9PR03CA0776.outlook.office365.com
 (2603:10b6:408:13a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 19:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:02:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:03 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:01:02 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ryan Seto <ryanseto@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 10/12] drm/amd/display: Toggle for Disable Force Pstate Allow
 on Disable
Date: Wed, 30 Jul 2025 14:59:01 -0400
Message-ID: <20250730185903.1023256-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: bd788a99-2e8f-4cfe-fc23-08ddcf9ba00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hd4pm2nCUFc8oHHRpd0GXRLkNfQ+4pk1vWrMUHVMl/rjOI9zv9qgGVagi5pB?=
 =?us-ascii?Q?wNbGZd1G4UEU1nNVa19BjaIJ8TNDGXLvyRVJ8Zk8GUiGonun/Po4Je0zneZL?=
 =?us-ascii?Q?IPAceLcg0jlmVeGJJDTLEaAUOTAkQjnUyvo/9/wSqPvBdnT/iLAwHO9jEOnf?=
 =?us-ascii?Q?U5Ky53+ZPhY+2TIigog9RhlkWhw6497VB6r6lMT0gAFOhC0XmtXEz0OF7DhK?=
 =?us-ascii?Q?FxISmi1mrwO/Xl2w3bv5ouxtohSN2S2gqzBqESxIGg3hqIEsGajDCkHER1G4?=
 =?us-ascii?Q?oWHblEsgaIMSt2DbK/7zMR0r5Om83zfi9gef8WG56u23zKTgs21EMnKOl2NJ?=
 =?us-ascii?Q?B7qAnOITAGVP7I9xwezfs1PAlahQIJewAKn8cGOuShgQU0ZckPdV/nmOZtu8?=
 =?us-ascii?Q?7RTRqhHu3aVUg7vNpHTiskcKAt7nLezhnrsEe5Z2EbGJsX/4o6zrJN8gLbGm?=
 =?us-ascii?Q?wtFo/6NepZpU4NipKvGXMt0L2lvksqUU1zXTOkBLwzreq7I0wreiR3jeLe1Z?=
 =?us-ascii?Q?oAl16pWKjYLljltAdafmpe6Wke2YXxi8ejyyAh/Chq6SEfEpdO9eQVQZmcQe?=
 =?us-ascii?Q?CqvsGeGhhBp+dP7smEdxqPpBL5ifkjht3h38IoD5UKJYSq0wZ4T4xfGLtW2T?=
 =?us-ascii?Q?CAq147GoXjnB8W3vseDnCCI4d+xY7CsbQqVKsSdHy3fqA10XmHZOoAVQQu5p?=
 =?us-ascii?Q?lk/+IvVmpExHmFFFhhuNXBkskNWkds2s/d1a6OMo1dkUP5S88jVrBDUaiwjR?=
 =?us-ascii?Q?2IER1CooG+pzVHHF3EXgisSRzMKk+WtTVZEE/2/OlOJSWolefLlOOfeeYrSm?=
 =?us-ascii?Q?FGpmHwu/SYFE2iqC78ONY9j5f1pfSK55ZTMBvZQNpkbuysi+ZL2koElSRkvU?=
 =?us-ascii?Q?4reaVLOv2sXip3yr/UTyllPxWnJxaZeRshWXhOy50t3nF/OhZrebwddwQBIl?=
 =?us-ascii?Q?VsE5s9vZ+fmNz7KYoKIoLzVbo2gG+NqjsiiE12kTeVYZVuQQfuMyR4H30i4B?=
 =?us-ascii?Q?63NSUjmZKDgOcTzAZJsoxlvAFPP/FXjeHaNqcWi67Bkatjj9Lpmslh8xcFKO?=
 =?us-ascii?Q?7wDoldaz0G7uR2b8X/ZTJlC/Ea1hkRo793b5AfkSohPRFZccY/BEXBGk9qCw?=
 =?us-ascii?Q?B0PsNrQtPXO7yFZUAZZ5/YqseKHDKlWdr9PUGHbrk5HSKPjuxu2teF2J8aZD?=
 =?us-ascii?Q?eOLnCwVQsC1RDEJcAye5OmLHJw/ZZ8fCr7KjWqPyKnboeZGOC+YgekkEepYk?=
 =?us-ascii?Q?Dg8WV0NNlKjO3yt4yEsT/BE+jbpFSkXvR1juDPvVMSg5iOl8RCIRy35LDnlS?=
 =?us-ascii?Q?8JgLL4cR+7VjnCIs2Zs6p2GUCwd9bN6ysub3LdvLjXFQDD295qnESDyxHxGV?=
 =?us-ascii?Q?r9byhXBJw7Nf+lT18eYwePfbN1iLpCuqnXMXg6LerueM0A4cN6HapLYSswiF?=
 =?us-ascii?Q?eyjU+fRYyFy1qS5I3GlDCcIqb7/hCVCrFhosWZqG51HXnLCbde60L4oI35/O?=
 =?us-ascii?Q?OIBz/MKGaG+bMGxX9D9dHWFEhTdarcymnKid?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:02:26.8139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd788a99-2e8f-4cfe-fc23-08ddcf9ba00c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587
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

From: Ryan Seto <ryanseto@amd.com>

[Why & How]
In theory, driver should be able to support disabling force pstate allow
after hardware release however this behavior is not tested yet.
Introducing a new toggle to disable the force on the fly.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 36 +++++++++++--------
 .../dc/resource/dcn401/dcn401_resource.c      |  1 +
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c013b28207a1..a83227f6bb14 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1073,6 +1073,7 @@ struct dc_debug_options {
 	unsigned int force_mall_ss_num_ways;
 	bool alloc_extra_way_for_cursor;
 	uint32_t subvp_extra_lines;
+	bool disable_force_pstate_allow_on_hw_release;
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
 	bool disable_dtb_ref_clk_switch;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index fb949aeb1244..d5b5e2ce6ff6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1621,20 +1621,28 @@ void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
 
 void dcn401_hardware_release(struct dc *dc)
 {
-	dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
-
-	/* If pstate unsupported, or still supported
-	 * by firmware, force it supported by dcn
-	 */
-	if (dc->current_state) {
-		if ((!dc->clk_mgr->clks.p_state_change_support ||
-				dc->current_state->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable) &&
-				dc->res_pool->hubbub->funcs->force_pstate_change_control)
-			dc->res_pool->hubbub->funcs->force_pstate_change_control(
-					dc->res_pool->hubbub, true, true);
-
-		dc->current_state->bw_ctx.bw.dcn.clk.p_state_change_support = true;
-		dc->clk_mgr->funcs->update_clocks(dc->clk_mgr, dc->current_state, true);
+	if (!dc->debug.disable_force_pstate_allow_on_hw_release) {
+		dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
+
+		/* If pstate unsupported, or still supported
+		* by firmware, force it supported by dcn
+		*/
+		if (dc->current_state) {
+			if ((!dc->clk_mgr->clks.p_state_change_support ||
+					dc->current_state->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable) &&
+					dc->res_pool->hubbub->funcs->force_pstate_change_control)
+				dc->res_pool->hubbub->funcs->force_pstate_change_control(
+						dc->res_pool->hubbub, true, true);
+
+			dc->current_state->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+			dc->clk_mgr->funcs->update_clocks(dc->clk_mgr, dc->current_state, true);
+		}
+	} else {
+		if (dc->current_state) {
+			dc->clk_mgr->clks.p_state_change_support = false;
+			dc->clk_mgr->funcs->update_clocks(dc->clk_mgr, dc->current_state, true);
+		}
+		dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index b3988e38d0a6..068c123ea8a8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -708,6 +708,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.use_max_lb = true,
 	.force_disable_subvp = false,
+	.disable_force_pstate_allow_on_hw_release = false,
 	.exit_idle_opt_for_cursor_updates = true,
 	.using_dml2 = true,
 	.using_dml21 = true,
-- 
2.34.1

