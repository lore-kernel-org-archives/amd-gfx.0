Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15049C02180
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD76610E83E;
	Tue, 14 Jan 2025 02:09:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mC9hgGbI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24CC10E83C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSAKEgFE1MbObi8gd4n3HkPKc9swrPheCwuJC8GX9a9G/fyZtpOu2/VjAbfrnOFlg6GiAy8KgcdK9gxwl7AZ4oAHTC55h9p2K5gDKKCfdBVRwBxjMGZrYGIpppm852KCZqwBqXeSofSBXS3auO42drnIkrm8ohWn+PLvcForAkygHS9EAEa09oXGoZapIAJ555YlmH3s+7USPbCpofcKzXkVqS1ry5ZT7iKZ3OLjo3NCDXHM8N0aWkBJEuAb630xTSpjuuxa+ucQj6sAuwcxb11D2AKHLSz+ePg4Iz8nalaVNQRKVYCKM4tExYC1dzndeZk2gGVVu/URhipyxIyeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eccEFtDA9rU/GqkRYYMsR+G4Svzv6uyTEGwcZs364sM=;
 b=TsgR4aAfbWpz+AFRLifn1mucCok0KYVl0YrPLsmIIlVhu8S+rZicGEm4K0cGHfHQAl0cgkdTqgV+j2jJrbq84CK0YpqvXbUtQGnOM8wM+QMHNUnI2YH03XeMjfMjeWAqpi4B020vzkV8Ixo0JgzRWuT0l2+aAFuQGdO3rqtDshrSpTZ6+5uYf+Unje+0OWnPttoIMOAGwKljh5ohLXI+Wa7XYY4wV4dyulNkfEHir9lpBujaImcY51jbWYI/OiJFZZLcesIrxB5/RAVuHkcgdLWjRWjtUSisJUcK6rtBaDC6nqJ5JrBnJmn1rBEY+YyWJgsct5F75mtbLqeUBGLpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eccEFtDA9rU/GqkRYYMsR+G4Svzv6uyTEGwcZs364sM=;
 b=mC9hgGbItj+ch3BqLuRUhSnbTi30/MspnZNQB/YZjLw7Lw1AgdQgwRosre5zo594b8yWmovIzocOUHqmOdZa/b4PrfnbuOERIDvpl+Z300y3WDOnJd3k3WHY4blsjr8UPLVaZc9UZ2jTr1YRHpySk5GdIrgH6RX5ybxtYYxqDiU=
Received: from BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) by MN0PR12MB6029.namprd12.prod.outlook.com
 (2603:10b6:208:3cf::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 02:09:34 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::59) by BL0PR1501CA0018.outlook.office365.com
 (2603:10b6:207:17::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.14 via Frontend Transport; Tue,
 14 Jan 2025 02:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:09:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:09:33 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:09:28 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Josip Pavic
 <Josip.Pavic@amd.com>, Sung Lee <sung.lee@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 02/11] drm/amd/display: log destination of vertical interrupt
Date: Tue, 14 Jan 2025 10:08:51 +0800
Message-ID: <20250114020900.3804152-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 168f9f54-f2e6-4009-dbf1-08dd34407d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JTkprdSq/IK244bNg8DpT+juzH+AZs+CTFgLdbsD1vqTjxiaVBTE2QBIn5U2?=
 =?us-ascii?Q?EUGhCb2Caq/9gszFLUsHQynEWR96bbSb2nGEO2pZPmnj6gHQSbkKtsyqG9jI?=
 =?us-ascii?Q?TMUq3HrcTeNbTwpP5BSn4+A6Lx/Weurnadb1SfnbWJrGGfQ6wo32qUe9ZnhE?=
 =?us-ascii?Q?LG0dVbbvhLtbgsQuKQSyU2sG6k6PHgyMmi8wf6Tun0IqsLS3jW8nzgEAfYmc?=
 =?us-ascii?Q?v4JLicsmEW9Ur1+E4c0aAEng2FF0jDIZAOerNJSZ5nhh4AvKr8thk6JPRgE5?=
 =?us-ascii?Q?Ie7bUGkTEekYt8+3WdldSc7POTmB6+qCTKDVEpoCWDE7MxOOdL6n23zoaoek?=
 =?us-ascii?Q?GOEPTH1PhBD5MjwWiVelZkwSwGp48ycIpq9/EzlXoCgikScQxexQTf+nT9Bj?=
 =?us-ascii?Q?P/LcFhvn1hDEJc7CgKvk1u3k6zFSLEnm1oFZzJUnAUo3sMyRvcxmUq41OYzi?=
 =?us-ascii?Q?8RQDnPq315cRRdaHdjen+NiEFZctve6jF0W5ETxOHOLLhaGdfxmE1DjTQ8ys?=
 =?us-ascii?Q?+Occj770LhxxpTo090Tayufz53ntDPuHLZqMk1ZWccy977bt2JYt+9w/yRst?=
 =?us-ascii?Q?8emYOOZQ0jASbo961il71cFu5GjG81Rr9Cv+2+uOiV/9vUeUl2SWpC2nGWDF?=
 =?us-ascii?Q?evMm3yc2UQrSCPS4BNb5hMRpUk5jWDtk1KKvZX2zX2kGlQa3kdRKA2g/Az3Z?=
 =?us-ascii?Q?K+zA4CvOfbKFqHXATMvwpEZB0+oSq7BxUlBNe0v0aVoA45k/wZ5QrNIRtqS2?=
 =?us-ascii?Q?CuihAcgV9dNGbTuZ/LsT+UeM8i8BKjfaBCMi+FurxK+idZCv11eRTu0ATPSi?=
 =?us-ascii?Q?FeuyIi/CCTwOgHr5dq8lxt5q9NKBUY1rd7+eokY3kkFnyv/e1y5qTTIqaLU/?=
 =?us-ascii?Q?oy5sDrtDkuBkSD+nx07L71Q7r90XUn8ZCmpcPwzfrI+WI/1HqI/O+U2eSXdr?=
 =?us-ascii?Q?Ra9OmcwYEBDrniHMiiwulefW8W/a2P6s1MZYSCZc38fTuKMv21Yr3QUumKsA?=
 =?us-ascii?Q?1KklPDB6eIl3CZZ4QK6dRXrYceXDRYKdksd+8haPOp9iHIJZ7y+3rwvpr7Hk?=
 =?us-ascii?Q?xkG1M/r10KgGQ7cY4uiW6Z33otenovCLfYLAzX0eE7+IEesWhqIhfQjrRKdz?=
 =?us-ascii?Q?OsIY5gyQFEU6cYDiSHg1YN/FZ5dFnovIfCu3Qo/dFAN+2eUKL3O5pGlxt8a1?=
 =?us-ascii?Q?ekbsI7oRhJJbHa6kISTZ7FVmA0tQnu4jiP5Ml2jUItsleSgbPmwWf59yrQ/f?=
 =?us-ascii?Q?Uvbbt6qV9ltZc9oNQ3GODoVGv9T9bMCSe9XjIt/g8gz4JVdQ6Or0W9wYxljc?=
 =?us-ascii?Q?QmMlM7KOX4Qqa94ieWRLYbY6nKe2IombqgSJ9X5XAUW+vZqUVRqxjf+WvZwi?=
 =?us-ascii?Q?FD3XH6CArFjIGopkw9UR46hH9F2Vy1S04R8f43+3hxrBI8/JzENOxUFrsHhX?=
 =?us-ascii?Q?9eRoeWRZFkU5as+eQ+5budsbR2LG1qWZKBYQ4cJk3dHXYoycD03bJNKXUfS7?=
 =?us-ascii?Q?C48L/cdN8b6Eqw8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:09:34.3714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168f9f54-f2e6-4009-dbf1-08dd34407d7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
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

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
Knowing the destination of OTG's vertical interrupt 2 is useful for
debugging, but it is not currently included in the OTG state readback
logic

[How]
Read the OTG interrupt destination register to get the vertical interrupt
2 destination on ASICs that have this register when reading back the OTG
state from hardware

Reviewed-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  | 30 +-------
 .../amd/display/dc/inc/hw/timing_generator.h  | 30 ++++++++
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  7 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  2 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |  1 +
 .../amd/display/dc/optc/dcn201/dcn201_optc.c  |  1 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |  1 +
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |  1 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    | 71 +++++++++++++++++++
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  7 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |  1 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |  4 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  3 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |  3 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  3 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 .../dc/resource/dcn35/dcn35_resource.h        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  3 +-
 23 files changed, 145 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 88cf47a5ea75..baf663b661c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -429,7 +429,9 @@ static unsigned int dcn10_get_otg_states(struct dc *dc, char *pBuf, unsigned int
 		struct dcn_otg_state s = {0};
 		int pix_clk = 0;
 
-		optc1_read_otg_state(DCN10TG_FROM_TG(tg), &s);
+		if (tg->funcs->read_otg_state)
+			tg->funcs->read_otg_state(tg, &s);
+
 		pix_clk = dc->current_state->res_ctx.pipe_ctx[i].stream_res.pix_clk_params.requested_pix_clk_100hz / 10;
 
 		//only print if OTG master is enabled
@@ -495,7 +497,8 @@ static void dcn10_clear_otpc_underflow(struct dc *dc)
 		struct timing_generator *tg = pool->timing_generators[i];
 		struct dcn_otg_state s = {0};
 
-		optc1_read_otg_state(DCN10TG_FROM_TG(tg), &s);
+		if (tg->funcs->read_otg_state)
+			tg->funcs->read_otg_state(tg, &s);
 
 		if (s.otg_enabled & 1)
 			tg->funcs->clear_optc_underflow(tg);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 681bb92c6069..65d67095918f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -415,7 +415,8 @@ void dcn10_log_hw_state(struct dc *dc,
 		struct timing_generator *tg = pool->timing_generators[i];
 		struct dcn_otg_state s = {0};
 		/* Read shared OTG state registers for all DCNx */
-		optc1_read_otg_state(DCN10TG_FROM_TG(tg), &s);
+		if (tg->funcs->read_otg_state)
+			tg->funcs->read_otg_state(tg, &s);
 
 		/*
 		 * For DCN2 and greater, a register on the OPP is used to
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
index 6fdc9809280c..7f371cbb35cd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
@@ -70,35 +70,7 @@ struct optc {
 	enum signal_type signal;
 };
 
-struct dcn_otg_state {
-	uint32_t v_blank_start;
-	uint32_t v_blank_end;
-	uint32_t v_sync_a_pol;
-	uint32_t v_total;
-	uint32_t v_total_max;
-	uint32_t v_total_min;
-	uint32_t v_total_min_sel;
-	uint32_t v_total_max_sel;
-	uint32_t v_sync_a_start;
-	uint32_t v_sync_a_end;
-	uint32_t h_blank_start;
-	uint32_t h_blank_end;
-	uint32_t h_sync_a_start;
-	uint32_t h_sync_a_end;
-	uint32_t h_sync_a_pol;
-	uint32_t h_total;
-	uint32_t underflow_occurred_status;
-	uint32_t otg_enabled;
-	uint32_t blank_enabled;
-	uint32_t vertical_interrupt1_en;
-	uint32_t vertical_interrupt1_line;
-	uint32_t vertical_interrupt2_en;
-	uint32_t vertical_interrupt2_line;
-	uint32_t otg_master_update_lock;
-	uint32_t otg_double_buffer_control;
-};
-
-void optc1_read_otg_state(struct optc *optc1, struct dcn_otg_state *s);
+void optc1_read_otg_state(struct timing_generator *optc, struct dcn_otg_state *s);
 
 bool optc1_get_hw_timing(struct timing_generator *tg, struct dc_crtc_timing *hw_crtc_timing);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 9885cb3c310f..267ace4eef8a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -146,6 +146,35 @@ struct crc_params {
 	bool reset;
 };
 
+struct dcn_otg_state {
+	uint32_t v_blank_start;
+	uint32_t v_blank_end;
+	uint32_t v_sync_a_pol;
+	uint32_t v_total;
+	uint32_t v_total_max;
+	uint32_t v_total_min;
+	uint32_t v_total_min_sel;
+	uint32_t v_total_max_sel;
+	uint32_t v_sync_a_start;
+	uint32_t v_sync_a_end;
+	uint32_t h_blank_start;
+	uint32_t h_blank_end;
+	uint32_t h_sync_a_start;
+	uint32_t h_sync_a_end;
+	uint32_t h_sync_a_pol;
+	uint32_t h_total;
+	uint32_t underflow_occurred_status;
+	uint32_t otg_enabled;
+	uint32_t blank_enabled;
+	uint32_t vertical_interrupt1_en;
+	uint32_t vertical_interrupt1_line;
+	uint32_t vertical_interrupt2_en;
+	uint32_t vertical_interrupt2_line;
+	uint32_t vertical_interrupt2_dest;
+	uint32_t otg_master_update_lock;
+	uint32_t otg_double_buffer_control;
+};
+
 /**
  * struct timing_generator - Entry point to Output Timing Generator feature.
  */
@@ -350,6 +379,7 @@ struct timing_generator_funcs {
 	bool (*get_pipe_update_pending)(struct timing_generator *tg);
 	void (*set_vupdate_keepout)(struct timing_generator *tg, bool enable);
 	bool (*wait_update_lock_status)(struct timing_generator *tg, bool locked);
+	void (*read_otg_state)(struct timing_generator *tg, struct dcn_otg_state *s);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index 19d5ebc6763c..6f7b0f816f2a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -1312,7 +1312,7 @@ bool optc1_get_hw_timing(struct timing_generator *tg,
 	if (tg == NULL || hw_crtc_timing == NULL)
 		return false;
 
-	optc1_read_otg_state(DCN10TG_FROM_TG(tg), &s);
+	optc1_read_otg_state(tg, &s);
 
 	hw_crtc_timing->h_total = s.h_total + 1;
 	hw_crtc_timing->h_addressable = s.h_total - ((s.h_total - s.h_blank_start) + s.h_blank_end);
@@ -1328,9 +1328,11 @@ bool optc1_get_hw_timing(struct timing_generator *tg,
 }
 
 
-void optc1_read_otg_state(struct optc *optc1,
+void optc1_read_otg_state(struct timing_generator *optc,
 		struct dcn_otg_state *s)
 {
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
 	REG_GET(OTG_CONTROL,
 			OTG_MASTER_EN, &s->otg_enabled);
 
@@ -1663,6 +1665,7 @@ static const struct timing_generator_funcs dcn10_tg_funcs = {
 		.setup_manual_trigger = optc1_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.read_otg_state = optc1_read_otg_state,
 };
 
 void dcn10_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 159172178d51..82b91b9bc9c2 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -209,6 +209,7 @@ struct dcn_optc_registers {
 	uint32_t OPTC_WIDTH_CONTROL2;
 	uint32_t OTG_PSTATE_REGISTER;
 	uint32_t OTG_PIPE_UPDATE_STATUS;
+	uint32_t INTERRUPT_DEST;
 };
 
 #define TG_COMMON_MASK_SH_LIST_DCN(mask_sh)\
@@ -591,6 +592,7 @@ struct dcn_optc_registers {
 	type OTG_DC_REG_UPDATE_PENDING;\
 	type OTG_CURSOR_UPDATE_PENDING;\
 	type OTG_VUPDATE_KEEPOUT_STATUS;\
+	type OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST;
 
 #define TG_REG_FIELD_LIST_DCN3_2(type) \
 	type OTG_H_TIMING_DIV_MODE_MANUAL;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
index b4694985a40a..81857ce6d68d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
@@ -562,6 +562,7 @@ static struct timing_generator_funcs dcn20_tg_funcs = {
 		.get_hw_timing = optc1_get_hw_timing,
 		.align_vblanks = optc2_align_vblanks,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.read_otg_state = optc1_read_otg_state,
 };
 
 void dcn20_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn201/dcn201_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn201/dcn201_optc.c
index 49c2efdfa403..f2415eebdc09 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn201/dcn201_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn201/dcn201_optc.c
@@ -180,6 +180,7 @@ static struct timing_generator_funcs dcn201_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.read_otg_state = optc1_read_otg_state,
 };
 
 void dcn201_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
index 4c95c0958612..78b58a449fa4 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
@@ -420,6 +420,7 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
 		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
 		.get_pipe_update_pending = optc3_get_pipe_update_pending,
+		.read_otg_state = optc1_read_otg_state,
 };
 
 void dcn30_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
index d7a45ef2d01b..65e9089b7f31 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
@@ -172,6 +172,7 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
 		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
 		.get_pipe_update_pending = optc3_get_pipe_update_pending,
+		.read_otg_state = optc1_read_otg_state,
 };
 
 void dcn301_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index 4b6446ed4ce4..ef536f37b4ed 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -245,6 +245,76 @@ void optc3_init_odm(struct timing_generator *optc)
 	optc1->opp_count = 1;
 }
 
+void optc31_read_otg_state(struct timing_generator *optc,
+		struct dcn_otg_state *s)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_GET(OTG_CONTROL,
+			OTG_MASTER_EN, &s->otg_enabled);
+
+	REG_GET_2(OTG_V_BLANK_START_END,
+			OTG_V_BLANK_START, &s->v_blank_start,
+			OTG_V_BLANK_END, &s->v_blank_end);
+
+	REG_GET(OTG_V_SYNC_A_CNTL,
+			OTG_V_SYNC_A_POL, &s->v_sync_a_pol);
+
+	REG_GET(OTG_V_TOTAL,
+			OTG_V_TOTAL, &s->v_total);
+
+	REG_GET(OTG_V_TOTAL_MAX,
+			OTG_V_TOTAL_MAX, &s->v_total_max);
+
+	REG_GET(OTG_V_TOTAL_MIN,
+			OTG_V_TOTAL_MIN, &s->v_total_min);
+
+	REG_GET(OTG_V_TOTAL_CONTROL,
+			OTG_V_TOTAL_MAX_SEL, &s->v_total_max_sel);
+
+	REG_GET(OTG_V_TOTAL_CONTROL,
+			OTG_V_TOTAL_MIN_SEL, &s->v_total_min_sel);
+
+	REG_GET_2(OTG_V_SYNC_A,
+			OTG_V_SYNC_A_START, &s->v_sync_a_start,
+			OTG_V_SYNC_A_END, &s->v_sync_a_end);
+
+	REG_GET_2(OTG_H_BLANK_START_END,
+			OTG_H_BLANK_START, &s->h_blank_start,
+			OTG_H_BLANK_END, &s->h_blank_end);
+
+	REG_GET_2(OTG_H_SYNC_A,
+			OTG_H_SYNC_A_START, &s->h_sync_a_start,
+			OTG_H_SYNC_A_END, &s->h_sync_a_end);
+
+	REG_GET(OTG_H_SYNC_A_CNTL,
+			OTG_H_SYNC_A_POL, &s->h_sync_a_pol);
+
+	REG_GET(OTG_H_TOTAL,
+			OTG_H_TOTAL, &s->h_total);
+
+	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
+			OPTC_UNDERFLOW_OCCURRED_STATUS, &s->underflow_occurred_status);
+
+	REG_GET(OTG_VERTICAL_INTERRUPT1_CONTROL,
+			OTG_VERTICAL_INTERRUPT1_INT_ENABLE, &s->vertical_interrupt1_en);
+
+	REG_GET(OTG_VERTICAL_INTERRUPT1_POSITION,
+				OTG_VERTICAL_INTERRUPT1_LINE_START, &s->vertical_interrupt1_line);
+
+	REG_GET(OTG_VERTICAL_INTERRUPT2_CONTROL,
+			OTG_VERTICAL_INTERRUPT2_INT_ENABLE, &s->vertical_interrupt2_en);
+
+	REG_GET(OTG_VERTICAL_INTERRUPT2_POSITION,
+			OTG_VERTICAL_INTERRUPT2_LINE_START, &s->vertical_interrupt2_line);
+
+	REG_GET(INTERRUPT_DEST,
+			OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, &s->vertical_interrupt2_dest);
+
+	s->otg_master_update_lock = REG_READ(OTG_MASTER_UPDATE_LOCK);
+	s->otg_double_buffer_control = REG_READ(OTG_DOUBLE_BUFFER_CONTROL);
+}
+
 static struct timing_generator_funcs dcn31_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -306,6 +376,7 @@ static struct timing_generator_funcs dcn31_tg_funcs = {
 		.get_hw_timing = optc1_get_hw_timing,
 		.init_odm = optc3_init_odm,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.read_otg_state = optc31_read_otg_state,
 };
 
 void dcn31_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index fbbe86d00c2e..0f72c274f40b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -100,7 +100,8 @@
 	SRI(OTG_CRC_CNTL2, OTG, inst),\
 	SR(DWB_SOURCE_SELECT),\
 	SRI(OTG_DRR_CONTROL, OTG, inst),\
-	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst),\
+	SRI(INTERRUPT_DEST, OTG, inst)
 
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_1(mask_sh)\
 	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
@@ -260,6 +261,7 @@
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
+	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
 
 void dcn31_timing_generator_init(struct optc *optc1);
 
@@ -269,4 +271,7 @@ void optc31_set_drr(struct timing_generator *optc, const struct drr_params *para
 
 void optc3_init_odm(struct timing_generator *optc);
 
+void optc31_read_otg_state(struct timing_generator *optc,
+		struct dcn_otg_state *s);
+
 #endif /* __DC_OPTC_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
index 633d62addd4d..0e603bad0d12 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
@@ -255,6 +255,7 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
 		.set_odm_combine = optc314_set_odm_combine,
 		.set_h_timing_div_manual_mode = optc314_set_h_timing_div_manual_mode,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.read_otg_state = optc31_read_otg_state,
 };
 
 void dcn314_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
index 0ff72b97b465..6bfdee3fcf5f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
@@ -99,7 +99,8 @@
 	SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
 	SRI(OTG_DRR_CONTROL, OTG, inst),\
-	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst),\
+	SRI(INTERRUPT_DEST, OTG, inst)
 
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_14(mask_sh)\
 	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
@@ -254,6 +255,7 @@
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
+	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
 
 void dcn314_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index c217f653b3c8..2cdd19ba634b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -364,6 +364,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
 		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
 		.get_pipe_update_pending = optc3_get_pipe_update_pending,
+		.read_otg_state = optc31_read_otg_state,
 };
 
 void dcn32_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 0b0964a9da74..d159e3ed3bb3 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -181,7 +181,8 @@
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh)
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
+	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
 
 void dcn32_timing_generator_init(struct optc *optc1);
 void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index d21e82b927d0..b86fe2b094f8 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -492,6 +492,7 @@ static struct timing_generator_funcs dcn35_tg_funcs = {
 		.init_odm = optc3_init_odm,
 		.set_long_vtotal = optc35_set_long_vtotal,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
+		.read_otg_state = optc31_read_otg_state,
 };
 
 void dcn35_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
index be749ab41dce..733a2f149d9a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
@@ -71,7 +71,8 @@
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh)
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
+	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
 
 void dcn35_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 338a0cad23a5..bf921d1f500b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -527,6 +527,7 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.get_pipe_update_pending = optc3_get_pipe_update_pending,
 		.set_vupdate_keepout = optc401_set_vupdate_keepout,
 		.wait_update_lock_status = optc401_wait_update_lock_status,
+		.read_otg_state = optc31_read_otg_state,
 };
 
 void dcn401_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index 1be89571986f..69ad21084fbb 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -163,7 +163,8 @@
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh)
+	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
+	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
 
 void dcn401_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 86c6e5e8c42e..1aa4ced29291 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1055,7 +1055,8 @@ unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned
       SRI_ARR(OPTC_WIDTH_CONTROL, ODM, inst),                                  \
       SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),                                  \
       SRI_ARR(OTG_DRR_CONTROL, OTG, inst),                                     \
-	  SRI_ARR(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+      SRI_ARR(OTG_PIPE_UPDATE_STATUS, OTG, inst),                              \
+      SRI_ARR(INTERRUPT_DEST, OTG, inst)
 
 /* HUBP */
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
index 9d03a55d90cf..9c56ae76e0c7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
@@ -305,7 +305,8 @@ struct resource_pool *dcn35_create_resource_pool(
 	SRI_ARR(OPTC_WIDTH_CONTROL, ODM, inst),\
 	SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),\
 	SRI_ARR(OTG_DRR_CONTROL, OTG, inst),\
-	SRI2_ARR(OPTC_CLOCK_CONTROL, OPTC, inst)
+	SRI2_ARR(OPTC_CLOCK_CONTROL, OPTC, inst),\
+	SRI_ARR(INTERRUPT_DEST, OTG, inst)
 
 /* DPP */
 #define DPP_REG_LIST_DCN35_RI(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 19568c359669..4c259745d519 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -538,7 +538,8 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),                                  \
 	SRI_ARR(OTG_DRR_CONTROL, OTG, inst),                                     \
 	SRI_ARR(OTG_PSTATE_REGISTER, OTG, inst),                                 \
-	SRI_ARR(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+	SRI_ARR(OTG_PIPE_UPDATE_STATUS, OTG, inst),                              \
+	SRI_ARR(INTERRUPT_DEST, OTG, inst)
 
 /* HUBBUB */
 #define HUBBUB_REG_LIST_DCN4_01_RI(id)                                       \
-- 
2.37.3

