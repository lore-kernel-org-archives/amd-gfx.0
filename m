Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E07C3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8272710E8BD;
	Wed, 10 Jul 2024 19:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E5r6nsAN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B6510E8BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njQvXf4lGChBrF9dkFf2+KaZIr4Ed5tvAY2bQHK5yBCWaNkgAe3eWECHJTa3yLOQEBjiV9uZo2eMati4xzZCo71uzjrHswhdhWrXHlFl4CyvJojnBWh1bgPXYnjy7W5TzeZdeeF24pICpWybBWwPQM5EnXhl62EsFaS37bCXRJbC2iFuo9N37lXjvZDEEqFrKqYhgf0mperBrDa41TyybRSRZ+D0UAb+g7aUngxUrtV8UwOBjUNaWoTrcT7O+NNLng++OKKP7WpEzmagAIlgk1+tXMQvyRsBLo1Uvwm66nxAepOmyGM0pphW7Ps9MDF7GLiMUP/dg0R74nCJ1sUa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bPhpCMAgrpt++OCg/v/LvQ19dA/y27XFglpV8KpnpI=;
 b=lbQOatEnIAfUf2sNaDmMQ+6tYKtrDQXFLXYfFBGyuM+5cP7vn831c8rGuGy9cf6lHNTe5oQdEqaPr2DjZZpXtQw2DqNTlhd/z/gO9OJa9jvUWZh64sFR+TqeKRXmjhWF9YdQzHBtuUDVkepSY9qkPXpXgtuKg8ToDTUN1jrhA0ZkVNgDrBcMhJ+2bKvXDOuEK1W8ROhZVfJjQ4TQvKP25Rp+lj1Dedr/Nc4xVaLSoMQmpMpWrOwEvE1SVVICR7fKq1ByKx3mqYHKBy+oltpAJhy7HlmLzhSawVulRFkxAzGSLW0uRG9mMN9uAy7R/ddWftamlAvM2DUO/FxGhRvQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bPhpCMAgrpt++OCg/v/LvQ19dA/y27XFglpV8KpnpI=;
 b=E5r6nsANh4LCA0YBksrelQtkYntOvF7sKRmmBKufbNb3ScH1EN8L+o4od7NMss11U60vCWGQEGBTLecxD+yqqOvva1xYse2keTiQ9vFDd14Z1a/7Sk229lYAWc27wexON7XAnXIFsDXrz/wDzpF7t7BRw5HDHDWO7gQfpsvmn7U=
Received: from SJ0PR13CA0112.namprd13.prod.outlook.com (2603:10b6:a03:2c5::27)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:39:43 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::1b) by SJ0PR13CA0112.outlook.office365.com
 (2603:10b6:a03:2c5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:41 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:40 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 34/50] drm/amd/display: Add P-State Keepout to dcn401 Global
 Sync
Date: Wed, 10 Jul 2024 15:36:51 -0400
Message-ID: <20240710193707.43754-35-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf55d3a-1f77-44b5-effc-08dca1180bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DuMquP+bRE5Tf7u20mIa72jxKmYbRvwF84PKNjp3y/1NN0wo0x96gOCeTpAU?=
 =?us-ascii?Q?9vdqO4MjNFyN6K4mErI7ByT8921dGg2zhwk8l10YMQqCshNmIZ/6936wombY?=
 =?us-ascii?Q?hjYGRVl7kl4QT/YY+zSstPDd57FgZWO14j+L5YlM1YoYwj3i9LPllht23/5Y?=
 =?us-ascii?Q?f1aWfjxHeqITnbQYEIcErNVAybbASc0XvozDzKKONyaOIO07QyF2fARtGhMK?=
 =?us-ascii?Q?xLUvHB8xQtyBR+Seo1LOByJZ3Fg4sUajuhhDTYQ53JJOWR/xARJQwINWc9f/?=
 =?us-ascii?Q?dcq5qf3GHcJRjVImNvgLl53rN31piiV6XsliYSssdwUma/ezziU1y3ceUTnu?=
 =?us-ascii?Q?w86ADdZno/X7m4iuMq5fhkgOpzgfEedE8oQzKWKr0yqhpU1oy32UXrar/ByN?=
 =?us-ascii?Q?ji02f7FNdYsmHSKEGK//MElhSnSPvHBB466WN6os6o2vd0517DZOM0hbh3BH?=
 =?us-ascii?Q?e02O13SCKQ+Hc67DLhzbFTOWcrxLV55E+Ra3voUfKiOm3zcUu4YRbHje5zRA?=
 =?us-ascii?Q?su+yEbNOz9hmFhJI/NPyDKB7e4EOp2F9XszgSMc8+V5ThOvbSicq5yMXIvXY?=
 =?us-ascii?Q?0FUg7SNXkwxqwEmVMA00QJeuLfmFFq3/gXoJMiJ9pZnjrT82fHmqmQLMzdLh?=
 =?us-ascii?Q?M4UDRL/qiGFRWGb1ekNpnyKgwc8LQsN0HP7EQxHTqpiuE+p/bKCAqm5feAsa?=
 =?us-ascii?Q?upZGIr0NO92IT/4o3OLvqYQ+hSKZUO2OnOsArGTWbdNzZogMvS5Z7D3tLnkQ?=
 =?us-ascii?Q?I2otsqC/yY7m5A6LY3+hLPhGmbdFcln7R3iUZ8TGWt16BH0Xbe1enk7uuKQW?=
 =?us-ascii?Q?pw+iKINONnw51vZ8o7ui0dS/WdYdIwd1ruB7mkXP2snDorZaBCA8kXcVdgjB?=
 =?us-ascii?Q?QdLlXgYUKCNvkne85tm6J2xWze4AKR+/CrV+I58Z5HjZGnKMtDMRCDj5K+lL?=
 =?us-ascii?Q?IB8m2liS0mfSYzsFhBnbjetsOO9bLRGNPffNbuCYE+lmw+gYn61fFrOxGo2a?=
 =?us-ascii?Q?xHKB9soUVeMhmkeEE0RN5KHnWiXbjE4r+e1SrVtP9d1IvZ+E4Wt2dP2j9g26?=
 =?us-ascii?Q?6pIQpI2ly9iMYDjwwHJssDukuvLtdG+fof5VQfaYFEAfW9oqpZ7RQsKH7+c5?=
 =?us-ascii?Q?Ie9/g712+0NcVoivW2ASJIWfOKNfO21RtTxV8DHYIiQt0LvS05VdQBKjL1zA?=
 =?us-ascii?Q?6jqQL3Vy8RpwZwqkeQELAHfdGjPIu41qgZVuIHHqep/CHZBT0Os0p3occk+X?=
 =?us-ascii?Q?Ml2X9T1EVXlV50WEyT65ieBxAPKmQ4XS9uBGRwemI0kXYAy/eDPqxPU4kJVC?=
 =?us-ascii?Q?16iL6N2d+Oi/0Z0PFk7Qpu79NIAQmWZis/3e8xZn/rYGRwGIwx4pBWTc+E0e?=
 =?us-ascii?Q?EJvB2z071oXK24Q2nv68RPiUcb6R014Tk3rIijh4R8Z1JpyDIFZVHbPJZrWZ?=
 =?us-ascii?Q?cMcsP+KJiv1V/0/JUpPkLteFGbIx0nsu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:42.5254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf55d3a-1f77-44b5-effc-08dca1180bc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
OTG has new functionality to allow P-State relative to VStartup. Keepout region
for this should be configured based on DML outputs same as other global sync
params.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../dc/dce110/dce110_timing_generator.c       |  1 +
 .../dc/dce110/dce110_timing_generator.h       |  1 +
 .../dc/dce110/dce110_timing_generator_v.c     |  1 +
 .../dc/dce120/dce120_timing_generator.c       |  1 +
 .../display/dc/dce60/dce60_timing_generator.c |  3 +-
 .../display/dc/dce80/dce80_timing_generator.c |  3 +-
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  |  1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  1 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  4 ++-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  7 ++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |  5 ++-
 .../amd/display/dc/inc/hw/timing_generator.h  |  4 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  9 +++--
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  7 +++-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 36 ++++++++++++++++++-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  6 +++-
 .../dc/resource/dce110/dce110_resource.c      |  1 +
 .../dc/resource/dcn401/dcn401_resource.h      |  3 +-
 20 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index 49bcfe6ec999..fa422a8cbced 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -1955,6 +1955,7 @@ void dce110_tg_program_timing(struct timing_generator *tg,
 	int vstartup_start,
 	int vupdate_offset,
 	int vupdate_width,
+	int pstate_keepout,
 	const enum signal_type signal,
 	bool use_vbios)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h
index 28c58f1dff2d..ee4de740aceb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h
@@ -261,6 +261,7 @@ void dce110_tg_program_timing(struct timing_generator *tg,
 	int vstartup_start,
 	int vupdate_offset,
 	int vupdate_width,
+	int pstate_keepout,
 	const enum signal_type signal,
 	bool use_vbios);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
index bf35dc65ca29..9837dec837ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
@@ -438,6 +438,7 @@ static void dce110_timing_generator_v_program_timing(struct timing_generator *tg
 	int vstartup_start,
 	int vupdate_offset,
 	int vupdate_width,
+	int pstate_keepout,
 	const enum signal_type signal,
 	bool use_vbios)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index eb3557965781..fcf59348eb62 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -697,6 +697,7 @@ static void dce120_tg_program_timing(struct timing_generator *tg,
 	int vstartup_start,
 	int vupdate_offset,
 	int vupdate_width,
+	int pstate_keepout,
 	const enum signal_type signal,
 	bool use_vbios)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
index c1a85ee374d9..e5fb0e8333e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
@@ -111,13 +111,14 @@ static void program_timing(struct timing_generator *tg,
 	int vstartup_start,
 	int vupdate_offset,
 	int vupdate_width,
+	int pstate_keepout,
 	const enum signal_type signal,
 	bool use_vbios)
 {
 	if (!use_vbios)
 		program_pix_dur(tg, timing->pix_clk_100hz);
 
-	dce110_tg_program_timing(tg, timing, 0, 0, 0, 0, 0, use_vbios);
+	dce110_tg_program_timing(tg, timing, 0, 0, 0, 0, 0, 0, use_vbios);
 }
 
 static void dce60_timing_generator_enable_advanced_request(
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
index 2df4654858be..003a9330c286 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
@@ -111,13 +111,14 @@ static void program_timing(struct timing_generator *tg,
 	int vstartup_start,
 	int vupdate_offset,
 	int vupdate_width,
+	int pstate_keepout,
 	const enum signal_type signal,
 	bool use_vbios)
 {
 	if (!use_vbios)
 		program_pix_dur(tg, timing->pix_clk_100hz);
 
-	dce110_tg_program_timing(tg, timing, 0, 0, 0, 0, 0, use_vbios);
+	dce110_tg_program_timing(tg, timing, 0, 0, 0, 0, 0, 0, use_vbios);
 }
 
 static void dce80_timing_generator_enable_advanced_request(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 410e4b671228..641a8cd019cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -523,6 +523,7 @@ struct _vcs_dpi_display_pipe_dest_params_st {
 	unsigned int vupdate_offset;
 	unsigned int vupdate_width;
 	unsigned int vready_offset;
+	unsigned int pstate_keepout;
 	unsigned char interlaced;
 	double pixel_rate_mhz;
 	unsigned char synchronized_vblank_all_planes;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index e9647f068ee4..1fce61323201 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -1129,6 +1129,7 @@ void dml21_populate_pipe_ctx_dlg_params(struct dml2_context *dml_ctx, struct dc_
 	pipe_ctx->pipe_dlg_param.vupdate_offset = global_sync->dcn4.vupdate_offset_pixels;
 	pipe_ctx->pipe_dlg_param.vupdate_width = global_sync->dcn4.vupdate_vupdate_width_pixels;
 	pipe_ctx->pipe_dlg_param.vready_offset = global_sync->dcn4.vready_offset_pixels;
+	pipe_ctx->pipe_dlg_param.pstate_keepout = global_sync->dcn4.pstate_keepout_start_lines;
 
 	pipe_ctx->pipe_dlg_param.otg_inst = pipe_ctx->stream_res.tg->inst;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 982b2d5bfb5f..849b41f886d3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1549,6 +1549,7 @@ static enum dc_status dce110_enable_stream_timing(
 				0,
 				0,
 				0,
+				0,
 				pipe_ctx->stream->signal,
 				true);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index e06fc370267b..4846601c612d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1005,6 +1005,7 @@ enum dc_status dcn10_enable_stream_timing(
 			pipe_ctx->pipe_dlg_param.vstartup_start,
 			pipe_ctx->pipe_dlg_param.vupdate_offset,
 			pipe_ctx->pipe_dlg_param.vupdate_width,
+			pipe_ctx->pipe_dlg_param.pstate_keepout,
 			pipe_ctx->stream->signal,
 			true);
 
@@ -2995,7 +2996,8 @@ void dcn10_program_pipe(
 				calculate_vready_offset_for_group(pipe_ctx),
 				pipe_ctx->pipe_dlg_param.vstartup_start,
 				pipe_ctx->pipe_dlg_param.vupdate_offset,
-				pipe_ctx->pipe_dlg_param.vupdate_width);
+				pipe_ctx->pipe_dlg_param.vupdate_width,
+				pipe_ctx->pipe_dlg_param.pstate_keepout);
 
 		pipe_ctx->stream_res.tg->funcs->set_vtg_params(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, true);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 9a00479f0417..dd652436a539 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -909,6 +909,7 @@ enum dc_status dcn20_enable_stream_timing(
 			pipe_ctx->pipe_dlg_param.vstartup_start,
 			pipe_ctx->pipe_dlg_param.vupdate_offset,
 			pipe_ctx->pipe_dlg_param.vupdate_width,
+			pipe_ctx->pipe_dlg_param.pstate_keepout,
 			pipe_ctx->stream->signal,
 			true);
 
@@ -1885,7 +1886,8 @@ static void dcn20_program_pipe(
 				calculate_vready_offset_for_group(pipe_ctx),
 				pipe_ctx->pipe_dlg_param.vstartup_start,
 				pipe_ctx->pipe_dlg_param.vupdate_offset,
-				pipe_ctx->pipe_dlg_param.vupdate_width);
+				pipe_ctx->pipe_dlg_param.vupdate_width,
+				pipe_ctx->pipe_dlg_param.pstate_keepout);
 
 		if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM)
 			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
@@ -2458,7 +2460,8 @@ bool dcn20_update_bandwidth(
 					calculate_vready_offset_for_group(pipe_ctx),
 					pipe_ctx->pipe_dlg_param.vstartup_start,
 					pipe_ctx->pipe_dlg_param.vupdate_offset,
-					pipe_ctx->pipe_dlg_param.vupdate_width);
+					pipe_ctx->pipe_dlg_param.vupdate_width,
+					pipe_ctx->pipe_dlg_param.pstate_keepout);
 
 			pipe_ctx->stream_res.tg->funcs->set_vtg_params(
 					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 31e0e9210dd7..d0b4308dca96 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -871,6 +871,7 @@ enum dc_status dcn401_enable_stream_timing(
 			pipe_ctx->pipe_dlg_param.vstartup_start,
 			pipe_ctx->pipe_dlg_param.vupdate_offset,
 			pipe_ctx->pipe_dlg_param.vupdate_width,
+			pipe_ctx->pipe_dlg_param.pstate_keepout,
 			pipe_ctx->stream->signal,
 			true);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
index 287bf8a90ff6..03cbcbb36f1c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
@@ -65,6 +65,7 @@ struct optc {
 	int vupdate_offset;
 	int vupdate_width;
 	int vready_offset;
+	int pstate_keepout;
 	struct dc_crtc_timing orginal_patched_timing;
 	enum signal_type signal;
 };
@@ -110,6 +111,7 @@ void optc1_program_timing(struct timing_generator *optc,
 			  int vstartup_start,
 			  int vupdate_offset,
 			  int vupdate_width,
+			  int pstate_keepout,
 			  const enum signal_type signal,
 			  bool use_vbios);
 
@@ -127,7 +129,8 @@ void optc1_program_global_sync(struct timing_generator *optc,
 			       int vready_offset,
 			       int vstartup_start,
 			       int vupdate_offset,
-			       int vupdate_width);
+			       int vupdate_width,
+				   int pstate_keepout);
 
 bool optc1_disable_crtc(struct timing_generator *optc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 0f453452234c..3d4c8bd42b49 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -172,6 +172,7 @@ struct timing_generator_funcs {
 							int vstartup_start,
 							int vupdate_offset,
 							int vupdate_width,
+							int pstate_keepout,
 							const enum signal_type signal,
 							bool use_vbios
 	);
@@ -256,7 +257,8 @@ struct timing_generator_funcs {
 			int vready_offset,
 			int vstartup_start,
 			int vupdate_offset,
-			int vupdate_width);
+			int vupdate_width,
+			int pstate_keepout);
 	void (*enable_optc_clock)(struct timing_generator *tg, bool enable);
 	void (*program_stereo)(struct timing_generator *tg,
 		const struct dc_crtc_timing *timing, struct crtc_stereo_flags *flags);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index 336488c0574e..4f82146d94b1 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -65,7 +65,8 @@ void optc1_program_global_sync(
 		int vready_offset,
 		int vstartup_start,
 		int vupdate_offset,
-		int vupdate_width)
+		int vupdate_width,
+		int pstate_keepout)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -73,6 +74,7 @@ void optc1_program_global_sync(
 	optc1->vstartup_start = vstartup_start;
 	optc1->vupdate_offset = vupdate_offset;
 	optc1->vupdate_width = vupdate_width;
+	optc1->pstate_keepout = pstate_keepout;
 
 	if (optc1->vstartup_start == 0) {
 		BREAK_TO_DEBUGGER();
@@ -157,6 +159,7 @@ void optc1_program_timing(
 	int vstartup_start,
 	int vupdate_offset,
 	int vupdate_width,
+	int pstate_keepout,
 	const enum signal_type signal,
 	bool use_vbios)
 {
@@ -177,6 +180,7 @@ void optc1_program_timing(
 	optc1->vstartup_start = vstartup_start;
 	optc1->vupdate_offset = vupdate_offset;
 	optc1->vupdate_width = vupdate_width;
+	optc1->pstate_keepout = pstate_keepout;
 	patched_crtc_timing = *dc_crtc_timing;
 	apply_front_porch_workaround(&patched_crtc_timing);
 	optc1->orginal_patched_timing = patched_crtc_timing;
@@ -282,7 +286,8 @@ void optc1_program_timing(
 			vready_offset,
 			vstartup_start,
 			vupdate_offset,
-			vupdate_width);
+			vupdate_width,
+			pstate_keepout);
 
 	optc->funcs->set_vtg_params(optc, dc_crtc_timing, true);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 369a13244e5e..b7a57f98553d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -201,6 +201,7 @@ struct dcn_optc_registers {
 	uint32_t OTG_CRC1_WINDOWB_Y_CONTROL_READBACK;
 	uint32_t OPTC_CLOCK_CONTROL;
 	uint32_t OPTC_WIDTH_CONTROL2;
+	uint32_t OTG_PSTATE_REGISTER;
 };
 
 #define TG_COMMON_MASK_SH_LIST_DCN(mask_sh)\
@@ -590,7 +591,11 @@ struct dcn_optc_registers {
 	type OTG_V_COUNT_STOP_TIMER;
 
 #define TG_REG_FIELD_LIST_DCN401(type) \
-	type OPTC_SEGMENT_WIDTH_LAST;
+	type OPTC_SEGMENT_WIDTH_LAST;\
+	type OTG_PSTATE_KEEPOUT_START;\
+	type OTG_PSTATE_EXTEND;\
+	type OTG_UNBLANK;\
+	type OTG_PSTATE_ALLOW_WIDTH_MIN;
 
 
 struct dcn_optc_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 9f5c2efa7560..a5d6a7dca554 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -396,13 +396,47 @@ void optc401_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, i
 	}
 }
 
+static void optc401_program_global_sync(
+		struct timing_generator *optc,
+		int vready_offset,
+		int vstartup_start,
+		int vupdate_offset,
+		int vupdate_width,
+		int pstate_keepout)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	optc1->vready_offset = vready_offset;
+	optc1->vstartup_start = vstartup_start;
+	optc1->vupdate_offset = vupdate_offset;
+	optc1->vupdate_width = vupdate_width;
+	optc1->pstate_keepout = pstate_keepout;
+
+	if (optc1->vstartup_start == 0) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	REG_SET(OTG_VSTARTUP_PARAM, 0,
+		VSTARTUP_START, optc1->vstartup_start);
+
+	REG_SET_2(OTG_VUPDATE_PARAM, 0,
+			VUPDATE_OFFSET, optc1->vupdate_offset,
+			VUPDATE_WIDTH, optc1->vupdate_width);
+
+	REG_SET(OTG_VREADY_PARAM, 0,
+			VREADY_OFFSET, optc1->vready_offset);
+
+	REG_UPDATE(OTG_PSTATE_REGISTER, OTG_PSTATE_KEEPOUT_START, pstate_keepout);
+}
+
 static struct timing_generator_funcs dcn401_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
 		.setup_vertical_interrupt0 = optc1_setup_vertical_interrupt0,
 		.setup_vertical_interrupt1 = optc1_setup_vertical_interrupt1,
 		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
-		.program_global_sync = optc1_program_global_sync,
+		.program_global_sync = optc401_program_global_sync,
 		.enable_crtc = optc401_enable_crtc,
 		.disable_crtc = optc401_disable_crtc,
 		.phantom_crtc_post_enable = optc401_phantom_crtc_post_enable,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index 3114ecef332a..bb13a645802d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -155,7 +155,11 @@
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE_MANUAL, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
-	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_KEEPOUT_START, mask_sh),\
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_EXTEND, mask_sh),\
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_UNBLANK, mask_sh),\
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_ALLOW_WIDTH_MIN, mask_sh)
 
 void dcn401_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index fe518fd27b08..91da5cf85b69 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -1163,6 +1163,7 @@ static struct pipe_ctx *dce110_acquire_underlay(
 				0,
 				0,
 				0,
+				0,
 				pipe_ctx->stream->signal,
 				false);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 26efeada4f41..106008593464 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -534,7 +534,8 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SRI_ARR(OPTC_WIDTH_CONTROL, ODM, inst),                                  \
 	SRI_ARR(OPTC_WIDTH_CONTROL2, ODM, inst),                                 \
 	SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),                                  \
-	SRI_ARR(OTG_DRR_CONTROL, OTG, inst)
+	SRI_ARR(OTG_DRR_CONTROL, OTG, inst),										 \
+	SRI_ARR(OTG_PSTATE_REGISTER, OTG, inst)
 
 /* HUBBUB */
 #define HUBBUB_REG_LIST_DCN4_01_RI(id)                                       \
-- 
2.34.1

