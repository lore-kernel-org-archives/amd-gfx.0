Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB37C0218C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673F910E62B;
	Tue, 21 Jan 2025 19:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gujJmlBQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B3510E62B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzxJWDptWYXihfe7uDlMOBmGkc12H7rG+p91AOArhlQ+1Mrn1rpgw+Ezh/6XK2cZEEEm6v1wG3aYBrpR4KqD7NTr862pmcWhYWoeo/yH/DN7+4yRobVwMfLlQpBwtOos5bsl/TktEf9VY+60FEQVk7LJM+Uodu1EFyt3xo59odVvW62zAj/KD3Bp6sykk0r1CeC4pb0zLv4EhODcFkb4qjrf5gyH70FCnHwrkuCuqR6m7eNC/M3JLq+J91MPMJ7KtcB0DuQjtQhTaG0GGxTv3MnrzG9jgdtUQ6pJcQJ8CE+m4kWSFOt4wpSClfYlrvNzxgoaruQ7YwDGs+x9TtGzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVtEghRUEUKeN+CgUxiNXlMQcuKyERz/Q4tWOVTPkaY=;
 b=BpmmzDgmlMh354hDlK8vvPCBcy/TeN9zojXZn2NF4t4Eo6rvdFGNtKgE825T9fJVvIFKhFLdVo7xWszPIHcPIKq+1Lf6Pg+lkzqKsBSLoFLkxo60BOVjm9i+xasx8BXwgEVNwk4qIc+D4+dEju9+GICvTR80ZQsKegor0dzTuCHipYL2X7KrKZ7iKLoLGe1N07hF9RPNBmYdQp1lt1VsJg3oe8EhhtSkahs3FfDPcd46jwp2qGsu1imECKzh58sbKQI+pUpZJ7a1BR9+it4GGWq5lvOgwNenzMzuVV68Jz+m4XcIEF7Wa/GJQttDKskopU696Tg+dxfB0eul7op8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVtEghRUEUKeN+CgUxiNXlMQcuKyERz/Q4tWOVTPkaY=;
 b=gujJmlBQtkp8Lo8SZoTU7r+2KnQb/M6XTW761aGlWyTkcJJcbLjKabIo7PuK4zzvftMvU4/KKcN+94AaI5jyC1vtM/QSC/OTX8nJL7panGhI3nZK7krsEMMZrOggvAC3wAP+63tBMENIHijH2PI7u2qdwGYO8VcBSW59agC9fSU=
Received: from MN2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:208:23e::21)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 19:39:58 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::2c) by MN2PR14CA0016.outlook.office365.com
 (2603:10b6:208:23e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 19:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:39:58 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:39:56 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Zhikai Zhai
 <zhikai.zhai@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 03/14] drm/amd/display: Update Cursor request mode to the
 beginning prefetch always
Date: Tue, 21 Jan 2025 14:39:08 -0500
Message-ID: <20250121193919.3342348-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e532e95-14c7-41ca-2a94-08dd3a5363c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BsGSJW0BGAjUEayAwYGEireRw4WZ5q29DN/1fmt89Hud14bYfq62+FI7SnnF?=
 =?us-ascii?Q?2M3BVB1CVZXrBY5D2Gm+tujuVaxifIDb7VLzuQrun5EBjrQZuMImydnO84jr?=
 =?us-ascii?Q?AnI5Wywm7js9ss3giaXLqosgjaFxp2bFc3Ihe5mSm11pjuO8ZfCkBPo0yUmQ?=
 =?us-ascii?Q?n01rvSh4vSYrqvSKBRG9ytGGZd2uMpdPY/8nZHLKqIot4JwLoGX0DULVoVhS?=
 =?us-ascii?Q?paxkWS7ZxzaZkSK49hl+OWMhNzthjv8zvLIAdp5XG+zIlVacbGFNyZ9tfZoA?=
 =?us-ascii?Q?kB9P0RYE36JileeZtM7NpDz1Ksm0ihuQNc2k5ytR9YJL9QVuM23ili6tSTDr?=
 =?us-ascii?Q?0DkYhOfB8qOMNqfCKZPssg0tKHjfDkVCuN8YsiELjIdYhIaG0JLIgP7iuWFm?=
 =?us-ascii?Q?Udc+jBxF7gZWngSC/l5jra6+GRRCVzpYNIFsz4Lz+xnnz751ZeG5Ukdg2iTN?=
 =?us-ascii?Q?bq4b0xrjk4Eb38si5yYNFgE5taqtv8zefgJnTEPyTboZGB2pdOQ1W5T+WWJn?=
 =?us-ascii?Q?eTRr618ETZA27jt0KFQ5+0eulr33qMJdBCZAp2yYImt8ftg3TeWS1G4nKca2?=
 =?us-ascii?Q?hEPLkfLWzefAg9Xl83oVlZwzyfrWHJBp8RYwYemyJuBY1mspObDA5+MGnS0H?=
 =?us-ascii?Q?Swj/LWzNLGF9dtKJzbJcGxMA7VE84UVZszvk98c7rEntIkdA8xYPQlgywd+L?=
 =?us-ascii?Q?QAusellVPojnNBmuXJKmZEdViq5rZsJb9/7Jl6aH8hc6Xgo75ycMSuma/ihC?=
 =?us-ascii?Q?LB63KQJurgF+cnLOpDabPwSsjIjgYEKiZoP7o4RcWmnTvA1T1RGZT5At5iFa?=
 =?us-ascii?Q?Gl9QQsGBXFLC/5QPIdwrTFsxJEoCumM63QnOIKrAsqoDfV4aZYlhaz+qFnaF?=
 =?us-ascii?Q?mIrozvOgxEILkkyUJgu1HYY/fM7blb9LLLLtJ8sXK9//VsNeFsXuzOxoJeZk?=
 =?us-ascii?Q?FbOP/QZ1fU7QZr7967kyMkso6OnnVOBpIk3qsk0Je1v5N/DYIh5LXuadR+yu?=
 =?us-ascii?Q?Pj7HJFSFWLtta2duFo9bH1SCkyEIJLAIIPTCtUlb9clfPymrEhdMKtrfrFJ8?=
 =?us-ascii?Q?tKqypVuwdb9ajfUf8qYrhXfWXSaxTbKox46GZvP2wC95bn7j3cDSbPIQmXPF?=
 =?us-ascii?Q?ZHay38rMf0Zzm71N9lpM6lPGtu2eFGiW2/uNbemm9VgXXK36RmSZ0ZYeWs9z?=
 =?us-ascii?Q?upI+ohDOf0uZlMbty1PFTIUPgk786fsfgVz2QGQ+L8bvkzmuEXVwSY5shsSX?=
 =?us-ascii?Q?FXmQMl4sx/0Sk6HxgPu9rHi3xKgdNNMOzEb/Y1a7oMAI3L+VQ/W13ThjMWt/?=
 =?us-ascii?Q?7Nz50dm8ToixoWzHB5CYnho7Dt9Uvo68QHE/7v158SQmQJir9N12zPr8mjXA?=
 =?us-ascii?Q?D63/e+gLZvcGLfgKWRrhcKSJXXGobcgnCwFcLIvWXrU917U1RqjJS3zhkbTf?=
 =?us-ascii?Q?IgWa1SBKeKTew5zhldPkU+4dz+C+UaJ4AOqk9a1O8ink148DVaOB23Z88RDf?=
 =?us-ascii?Q?y4/x2LmK35xnSVM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:39:58.6481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e532e95-14c7-41ca-2a94-08dd3a5363c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
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

From: Zhikai Zhai <zhikai.zhai@amd.com>

[Why]
The double buffer cursor registers is updated by the cursor
vupdate event. There is a gap between vupdate and cursor data
fetch if cursor fetch data reletive to cursor position.
Cursor corruption will happen if we update the cursor surface
in this gap.

[How]
Modify the cursor request mode to the beginning prefetch always
and avoid wraparound calculation issues.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 22 ++++++++-----------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index c2900c79a2d3..7fd582a8a4ba 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -44,7 +44,7 @@ void hubp31_set_unbounded_requesting(struct hubp *hubp, bool enable)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	REG_UPDATE(DCHUBP_CNTL, HUBP_UNBOUNDED_REQ_MODE, enable);
-	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, enable);
+	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, 1);
 }
 
 void hubp31_soft_reset(struct hubp *hubp, bool reset)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 906934128912..35c0d101d7c8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1993,20 +1993,11 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	dc->hwss.get_position(&pipe_ctx, 1, &position);
 	vpos = position.vertical_count;
 
-	/* Avoid wraparound calculation issues */
-	vupdate_start += stream->timing.v_total;
-	vupdate_end += stream->timing.v_total;
-	vpos += stream->timing.v_total;
-
 	if (vpos <= vupdate_start) {
 		/* VPOS is in VACTIVE or back porch. */
 		lines_to_vupdate = vupdate_start - vpos;
-	} else if (vpos > vupdate_end) {
-		/* VPOS is in the front porch. */
-		return;
 	} else {
-		/* VPOS is in VUPDATE. */
-		lines_to_vupdate = 0;
+		lines_to_vupdate = stream->timing.v_total - vpos + vupdate_start;
 	}
 
 	/* Calculate time until VUPDATE in microseconds. */
@@ -2014,13 +2005,18 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz;
 	us_to_vupdate = lines_to_vupdate * us_per_line;
 
+	/* Stall out until the cursor update completes. */
+	if (vupdate_end < vupdate_start)
+		vupdate_end += stream->timing.v_total;
+
+	/* Position is in the range of vupdate start and end*/
+	if (lines_to_vupdate > stream->timing.v_total - vupdate_end + vupdate_start)
+		us_to_vupdate = 0;
+
 	/* 70 us is a conservative estimate of cursor update time*/
 	if (us_to_vupdate > 70)
 		return;
 
-	/* Stall out until the cursor update completes. */
-	if (vupdate_end < vupdate_start)
-		vupdate_end += stream->timing.v_total;
 	us_vupdate = (vupdate_end - vupdate_start + 1) * us_per_line;
 	udelay(us_to_vupdate + us_vupdate);
 }
-- 
2.34.1

