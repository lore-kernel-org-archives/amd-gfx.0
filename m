Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8C5C02183
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1E910E847;
	Tue, 14 Jan 2025 02:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kYnCEPzn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EED810E846
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+7dwvU/Vu1idsXcKbRJfGbYNN4rGXpDKCXXfvHDn8J90RNdeU/cNHw/Cf9vLqH6JIasgFo4cOJgoo58zExvmuAhD/9VYdmgxQuqmNw9OceU7qW4WaIgucLS0EQ05W2oxuVjsIStlYU6IyZ2kGfyEgIVNcEnpDp2X5sZ20u5eP/83Od4ssqhrXXXFzgjHsOJ5saK8NxAzFGuH1rU2sb5xFUfRJF63G86J5t77PI8dYDXqlBWh8GsiXMhwzOceGfMPQ3JXGpcZs5IY8KUzot2UAxYTEiz9QCPV2qU+dOkwQFRUwdvKsR4XJcjKZ7haOoxO/UThvQbHAzrBp/dfhi3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn5LgbjHimbUBI4mfQ/NfIEvJ9r864ujiHtmJ0OnlKA=;
 b=T+gH6uuF7FCW7JIBjEovzr7bveduQXKbdmwjUwocdTATQBI+4gPz6G16DHgZYOFMLmCQb9pbNZnxi6J6g1r9M7Zm7sHsCDtDGXrQxdIhxaMDEVu8Zie+gk6jDZuexZ1zZuQMasoePRVyhI90cfSnoxY8DHBuz26gpbicwz2y43xLagZ7ab42vo1METw+8wywBu7QVx/NudS0aPHZXnKjnlnlm58seoHK0I0P4nbNi2db3bTHGDe8oY4fPABQzzS3nbdtbwyxw1W/tda8kCbf3Bg5vy1Ivluyx0RpZR5Rdpzzg/rwsnDlHdKl6tAphvw+bjrhL2N0A0SgZf9MF4jKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn5LgbjHimbUBI4mfQ/NfIEvJ9r864ujiHtmJ0OnlKA=;
 b=kYnCEPzniqog46rXKQVEhYw0AWzLXRq8zroHXqFdwmJyA0VoqAqnQhe1BtbYUYKo3gYKI/8PjeqhUgxc915u4OI3QgLYfkl7rfDP3zySqQhldb3GbQIusL5ExV7atLkVnMpwxhZnTWbw58L7vcmI/zmnZsgKthZOHNDAdORiPlk=
Received: from BL0PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:207:17::24) by PH7PR12MB5735.namprd12.prod.outlook.com
 (2603:10b6:510:1e2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:11:16 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::40) by BL0PR1501CA0011.outlook.office365.com
 (2603:10b6:207:17::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.17 via Frontend Transport; Tue,
 14 Jan 2025 02:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:11:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:11:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:11:04 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:10:59 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Syed Hassan <syed.hassan@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 09/11] drm/amd/display: Exclude clkoffset and ips setting for
 dcn351 specific
Date: Tue, 14 Jan 2025 10:08:58 +0800
Message-ID: <20250114020900.3804152-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 3526f73f-84cc-4c06-45ae-08dd3440ba3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RLw+qyiHLDU1SVKS86HolTOAJcOBYDlqBWnv9MlhajgnJ0bIr4XpUxqrr3Qy?=
 =?us-ascii?Q?HyX05nIH9O1ZA5j8WTiEBOqXGsJT2yr8rU8Ar10tB7OfuwEclXwQqnLwfQXZ?=
 =?us-ascii?Q?gyfrtJmTDe/9ZyQrmrTdEE0yxqhM7jgE6+l2T7jpPNPiqp+0Og60Gyj4+1Bx?=
 =?us-ascii?Q?JMlFSOEB/jaTQu/ZL93AYesvhzKnSTdr8n5oOoHoD9tcWLclc0wR+vLSLlvH?=
 =?us-ascii?Q?Po/Gp/f9Htdg5PW0Mh8UTokheFH/QkzzELJ6e2YZyhxMF/r/M+X6a2K/QDpE?=
 =?us-ascii?Q?7hWEoWq3xEKNA+GoViTeVueVRJR54DK1ByRrGtwjhuKe1B6lc7n4faY2CoKz?=
 =?us-ascii?Q?SgytMayBRFyCXlKD4Vtp2VC8dIeEDofDeP45bS/lr+BCUzI4l3NsN7gID9CW?=
 =?us-ascii?Q?vMFBOJp/rHgrDzO7/cIy8f1evLH2rhMK4fzU8/fiNCu1sBLQWRtb7G4zWOaT?=
 =?us-ascii?Q?+/5cu5dy4OpV17FYQ5uJJEgcfySoNPgfTBLsrtgEF+0HWq+YVPXbGZUOk8Xv?=
 =?us-ascii?Q?W66R4xjdWaCZnR6YsXPMs6VRFkhrEoTb9Ih2qYFG+TG43S10b6peTuW5kiM6?=
 =?us-ascii?Q?4iUOYUs0hzca9b6kDVCbb45FI0bTaYEaBUgnnLCmGVk/eyrCzHmHLOSuENMI?=
 =?us-ascii?Q?S68wcRgX6trtY+W251qGFgwedg4yXBOY3BACA8AL0z662qpv4H1jSwUhUO4K?=
 =?us-ascii?Q?Yam6JRDxOg+B9fKpyOmTG65QsyLK8+Jd0UjeHmbSs3/y7UqoG4Uv8Z1Nz/GQ?=
 =?us-ascii?Q?TzvQicUyMMTgzBEizsbS4FxSuA1rp9d58eWqhwoj2wir5hgZo3s0zhm78s8A?=
 =?us-ascii?Q?OZwVnqnHliouTL6Ew+aYCL6GLRT+ZYJO04rMov1VdTUje/2D+24OCxCvLX17?=
 =?us-ascii?Q?POVmYs2DQNtBB7nxBTi02rxx2qnMGFjAR07L548nsh5BS9u3qPQ5QaCbzYUf?=
 =?us-ascii?Q?jUpDUsYQEDGtdvlW5Yis8mqrhRygmbzvkucQdjM/iWsVpLcURn8T6esI+j3b?=
 =?us-ascii?Q?KCKKaEVluvysJfyhCIJWBfmKepWpWIUXVy02ZwUZy+A24oLlfm19t1HnE/R+?=
 =?us-ascii?Q?Cu0HCmAqyXdxLSDjEAssthQGNgS/rGkSuKC1jpQQU/tNAm+rss5KixeNVBjK?=
 =?us-ascii?Q?m/K+kDDtGShFelK6EgafguSY/xM6C3fvzRMsUKs+v3wUxNg71fgmvz1/Zcuz?=
 =?us-ascii?Q?vt2YWcJV+9PmFnZlbXQ51RM7Yd5kCd/CW6MFb/12g5eF6PDHLjHOUN+w868O?=
 =?us-ascii?Q?fT9p5hMTqkduwR7RG9almSQWYzatP7RbhvaCB8VNj1uVfg5KC0T4J8vn63dD?=
 =?us-ascii?Q?1S9qdc+Ypl4y66u1ycaTWH1KiIQphW/IdLuXne2QrKxK3SO3ANnS3bIZaW1b?=
 =?us-ascii?Q?jCO7xfjMzxs+9IsKo7Y0pVrC6BVCZ36SvNkJxzwfg4tfq89yzrwLKqK1A+oi?=
 =?us-ascii?Q?1pjPI9AtVIDNfaDISJlbGd65fIS5msgxWE7bsRRZSlCIcB0fnQQblK5QCDLX?=
 =?us-ascii?Q?NLhMzEsxW/lvlN8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:11:16.2785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3526f73f-84cc-4c06-45ae-08dd3440ba3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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

From: Charlene Liu <Charlene.Liu@amd.com>

Exclude clock offset and IPS setting for dcn351 specific only.

Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 1f974ea3b0c6..684a51e1cc48 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1249,7 +1249,7 @@ void dcn35_clk_mgr_construct(
 	clk_mgr->base.dprefclk_ss_divider = 1000;
 	clk_mgr->base.ss_on_dprefclk = false;
 	clk_mgr->base.dfs_ref_freq_khz = 48000;
-	if (ctx->dce_version == DCN_VERSION_3_5) {
+	if (ctx->dce_version != DCN_VERSION_3_51) {
 		clk_mgr->base.regs = &clk_mgr_regs_dcn35;
 		clk_mgr->base.clk_mgr_shift = &clk_mgr_shift_dcn35;
 		clk_mgr->base.clk_mgr_mask = &clk_mgr_mask_dcn35;
@@ -1401,7 +1401,7 @@ void dcn35_clk_mgr_construct(
 
 			/* Disable dynamic IPS2 in older PMFW (93.12) for Z8 interop. */
 			if (ctx->dc->config.disable_ips == DMUB_IPS_ENABLE &&
-			    ctx->dce_version == DCN_VERSION_3_5 &&
+			    ctx->dce_version != DCN_VERSION_3_51 &&
 			    ((clk_mgr->base.smu_ver & 0x00FFFFFF) <= 0x005d0c00))
 				ctx->dc->config.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		} else {
-- 
2.37.3

