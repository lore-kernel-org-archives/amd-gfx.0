Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA9CC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17A910EB1D;
	Thu, 20 Jun 2024 16:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qoeD/uWv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFAF10EB1D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN36DNNeVE0nGzVIw0l9Vpsmb2grPxpmnKs6iTn7sj+Ay49Ht0QgFhkDIATvHOoTiRGt7YXp2SsKU+VaD94MKrdTfK8t+VXTu92MtgiPUxftYjrYH+qdz14kAspXgOC4d7zm3ycHzT8x5DnZBvvJ26CyXeXAP7q3yW4rQyfP/tP8J0BwZATurEUgnKNlifu+wUzvTWTzcJvuBWceOKlEzRG8FpQHhW/EmIyNIvam1Op8nxSriIFXVxWyp3LMya5VkDMRXQMwil9u7uefo/I/4DSVUGspojNaSYRJucX92PF4jecDe7Y2pWDqZadGFWzI7NXhatmMWAw8ZzqG/mwz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PR/Wa9ubYbHHJmFsav6lccDHHR6eaQSooP7p6V0zP4U=;
 b=hdPeiwiOAJcJuPEhMiokvoQnB71Ez30CI7BRd9xT9dFNTmul7fj8EEdLSoGpGZRuF6RpxEWxDMcYbRgX6mNUo2vttMNSh2un1eVhyw8vrX/djU7rcf3PNNg7Fyvp2Wk7veW9U8atrPXKY/Fc+nUCQ2obzEKt+HtJ5f8NKt1263l2FXhBV++g0um1QhOigMCwfD6olFp63HXxhNGf26wvF1uahVqyKFBrkRwauow3HrjZhZt7O64xxgS8GvYknWC8c0R4q94oUb4sb46XRWFePEUZ8jOoyEX6wd3DPlvAWxGxWWCXYffB1hayOz/8/9qN1gNPrvgQ1yd6PmB8esrIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR/Wa9ubYbHHJmFsav6lccDHHR6eaQSooP7p6V0zP4U=;
 b=qoeD/uWvg95iIJy4xxttXnr6sGArXM4tJoqGVnl2t8hXvAhzkft08SrleXLhxC6gd6m5jV8gk+7WFVIA4q97eGDzj/YYfG8BBsHBB8Qn+qyxcaIT7Erxq0o6arl80sjus2vwRZfplrXRMr9GwKJ2/p1VxdcZO+ZzInIbtk8i2NE=
Received: from CH0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:610:32::14)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 16:20:19 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::26) by CH0PR07CA0009.outlook.office365.com
 (2603:10b6:610:32::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Thu, 20 Jun 2024 16:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:20:18 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:20:16 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 34/39] drm/amd/display: Validate function returns
Date: Thu, 20 Jun 2024 10:11:40 -0600
Message-ID: <20240620161145.2489774-35-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 038289a3-5a7b-4479-f955-08dc9144e07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|36860700010|376011|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FgAt0V+qowMIAHk66U5bRZiWzUDtJsVlqayW8lU2mFRcwj59jN2bsq35tcIW?=
 =?us-ascii?Q?UjsEej83p0VoFFYn+GACARj90Ao47KigVDFHRShyjPFY3dGuaTdPpDdGYWNa?=
 =?us-ascii?Q?e1YyFG0VDy5qDVXBidg24mDPywxahmvzX68hLVwVi/Utp23m+Gk5kqIor4np?=
 =?us-ascii?Q?gyWPig9KBpORzg7u/+/vAZunCyqW97R07Mj3//p6ark6NV2o8jmbkUH5bAbA?=
 =?us-ascii?Q?sc/T3c+3nxCp5Iv9ac3AJtvEPO5kRXkzdpeblFa9wXNX898r0nRcaIXswXyR?=
 =?us-ascii?Q?SA/c2SXA6EamxkThs1T1NuVGr5nctQiVpMeoZBcPg8DjZ6YjFGFgK03nFCK/?=
 =?us-ascii?Q?HX4tuYHsK7iGrkty8GGGjeRFPDytVBohg/b6TaoyB+dcOXNdod2BklJ8Oh3p?=
 =?us-ascii?Q?5kn7zM6rGsInQFjhLpPHbI4Xz9VWcf0l+3pqSCexuCYu7VC3EvM2XbjFM74d?=
 =?us-ascii?Q?Rr9JiI/ArphixhUl3TFbNXEDaUGcb1H5o9Pj12v36Z7d7AFJIHPeAQwk6m6R?=
 =?us-ascii?Q?OpPjB3Wc5zLq8hSAbYhEJKfPvGnyiwp+wC7BCtZfAGD33sfSWB/6GlzSE8Mk?=
 =?us-ascii?Q?QFOo2Qz5CS2r1Ppu/kUYpWtSA6oGt+B281Ju7yxQEA5CpAy5FL2PWRyLpVrq?=
 =?us-ascii?Q?yQd57p0uUFNIiviloyx/++GycgvtCTTBM0zCqJCz2uMKM2wt8qFIi/pXX1cf?=
 =?us-ascii?Q?0elK3psdkv8782pOlodTUChAWxXd7HkdoGrixHwjdiYxdfHpCjsBN3t4oAdf?=
 =?us-ascii?Q?UqVanUF4VT5L/RecVnj1LsuFfRbuK50ZVFRXkhu78I90/pjuN9PTI7/GL8lW?=
 =?us-ascii?Q?ZBpd0Dv947KDCL+u6TKAL706S+gYnmql0di18Pc+04pvkzBW8Un3GqaFkIyM?=
 =?us-ascii?Q?bG87sL9KceTbmqlXqHtiohpnDP5p1/1rxoHsJ1XrwhtNaNrFdQ8QTufXg0XQ?=
 =?us-ascii?Q?zHluH3jgk5LfDrwIMJwAOkxsA7yIxSOznEO2GkQg+nPTULDYRkDDp1o1O+oP?=
 =?us-ascii?Q?B9oEdD5N3PvCrAk9K1ORlCpXxgE88jau3MGVkj7GGt/o9JgL56dgS2V0R7Oa?=
 =?us-ascii?Q?HLLIPFpWVc0SJTU4WUxFIq0AiVax6wCg0rqeh57BLxcLHyw3Ca6v1n+kXbsF?=
 =?us-ascii?Q?AJBoR4yndAfgnbfmr1eBzE7Ix29yIvMLSnWFCHTo4GwBEXEYSkxQkmgNwtbD?=
 =?us-ascii?Q?lQxYoTEq2izhdbpZ/4uHg5oJKBkDIttpcm2TsBAal0/SYv691yKBascEhE7Z?=
 =?us-ascii?Q?3l9BGazBdVeVZxMu7XvGDLl1ZpFeIkB4Ccpa7fCxmbjOcA5+u599vk/nV2Da?=
 =?us-ascii?Q?LQjdCeoQHlLKjNl/c2UkLABtZn4a2jQtv9x2BrysYOijtgthlJGxHQrEzmDQ?=
 =?us-ascii?Q?at0m10cTr6FVtoTG3Ron2Qk3dFF8DHhwVy+d2QtLusobc2KZhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(36860700010)(376011)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:20:18.8986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 038289a3-5a7b-4479-f955-08dc9144e07d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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

[WHAT & HOW]
Function return values must be checked before data can be used
in subsequent functions.

This fixes 4 CHECKED_RETURN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c               | 7 +++++--
 drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c | 3 ++-
 .../drm/amd/display/dc/link/protocols/link_dp_training.c   | 3 +--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b2051c4dd7b6..ded13026c8ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -245,7 +245,9 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 			if (status == DMUB_STATUS_POWER_STATE_D3)
 				return false;
 
-			dmub_srv_wait_for_idle(dmub, 100000);
+			status = dmub_srv_wait_for_idle(dmub, 100000);
+			if (status != DMUB_STATUS_OK)
+				return false;
 
 			/* Requeue the command. */
 			status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
@@ -517,7 +519,8 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	union dmub_rb_cmd cmd = { 0 };
 	unsigned int panel_inst = 0;
 
-	dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst);
+	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst))
+		return;
 
 	memset(&cmd, 0, sizeof(cmd));
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
index 8901bd80f7d1..5c6f7ddafd6b 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
@@ -616,7 +616,8 @@ static bool hubbub2_program_watermarks(
 		hubbub1->base.ctx->dc->clk_mgr->clks.p_state_change_support == false)
 		safe_to_lower = true;
 
-	hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
+	if (hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
 
 	REG_SET(DCHUBBUB_ARB_SAT_LEVEL, 0,
 			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 5a0f574056d4..988999c44475 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1663,8 +1663,7 @@ bool perform_link_training_with_retries(
 		if (status == LINK_TRAINING_ABORT) {
 			enum dc_connection_type type = dc_connection_none;
 
-			link_detect_connection_type(link, &type);
-			if (type == dc_connection_none) {
+			if (link_detect_connection_type(link, &type) && type == dc_connection_none) {
 				DC_LOG_HW_LINK_TRAINING("%s: Aborting training because sink unplugged\n", __func__);
 				break;
 			}
-- 
2.34.1

