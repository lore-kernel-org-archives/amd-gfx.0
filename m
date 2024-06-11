Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8456AC27C7B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768B610E6E5;
	Tue, 11 Jun 2024 16:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KKGNwXro";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF0E10E6DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+ofozW5afiLHuvjMNSu5YbwdRZ7EnSHDRYWACLfU4orsjv/EN45rruxqlAP/8Rds1G+04WIHKMeGnvgo2vVB3nHhPZe8sDmgPBZArpNlqAd9CPo+ShDvGoUEOEO0DpXSU+t0+2bwZhQhsh4WOhoCmgc0aTLGmshXhnJ/oAddmu1skI1lGCVsdXy3iTWtGsRCaC433CWY23C36JaLU0FYLRnoUNXe14pGQnaMyVyo18+cdgeYMqVwMTxXNVUR1dlDl/jq8GdbE5LKFcII2pHvQEUIrL+P+AGuZLDv60SjbHPGDJ6ZBCcKaWtAdnFeAa47Q1pmIDPvw2Umg3rfEAArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9b+L3XG+Ar05k/5BRZCS/CAUMfyDSbbrehHUQwJ+/Y=;
 b=Zp89QPxRaQ3vRP1ujMkF+7sQXQgUfoYrlqUt5hJUP+y2ElyjdHGFva0yzpmZabUPi4i9QDW38HX8zK5bCA47oXOO3krbGCncooYITSoFNsz+Whe+LgAgInGWW0CUKJWBsY+rja1oUfJoMqUtR8HT8ylFhK83fhxGptIq5gO87yUNb70QZ9+avgjNbtO6KZrhSXMPwB2295e0C2QQJbpexVCqMLJTzCU4RertOA5CIYUS313ddTo5xyLxpOASYVNmN6My7cSqtI9Z71Wk6sCj0EZ4TAfdUEPx8305oPZnko26oqpZth4dAm48NAuz2+aDbPeBbxU5xl1FmWZ+0HAyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9b+L3XG+Ar05k/5BRZCS/CAUMfyDSbbrehHUQwJ+/Y=;
 b=KKGNwXroWRzIsP7Ti3XnijJhozIv6V9fzndckUMLybvc0/Nop6g7EbTIfpvE4zWazpEIEXbwk3olaXWN3Q8F+E8AqAjeLy+NnFn6NegMGZleG/F598WtmXpTmlURKvYgc0FQqmTGYcuXsfkYdX0zgME5QsCM8OESmCGnuIQOf7k=
Received: from BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::21)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:44 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::ee) by BLAP220CA0016.outlook.office365.com
 (2603:10b6:208:32c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:44 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:38 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 21/36] drm/amd/display: Make sure to reprogram ODM when resync
 fifo
Date: Tue, 11 Jun 2024 12:51:24 -0400
Message-ID: <20240611165204.195093-22-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c2f07e-1820-46ec-8175-08dc8a36ea26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yX92jw4Mh/z3B5ysr8DCh4hnq2DxAuY908uEbL7njpggQA5gKFDOQX7bkK7C?=
 =?us-ascii?Q?G1X0c3NiWSrg6RKjSEQvOgVTmr1IUg3AFvQ7F9Hfo6w3YcnJXGu0C/BrJPDi?=
 =?us-ascii?Q?eJF0Ic1Yt+6VcXaLxRvvgNTYZh04I9Z6gTCLjqtVti+U0PYD6XAPRYceFvY+?=
 =?us-ascii?Q?PbAMlQ2FwulnGNGPV3ZTp7NblThyceGktQDPbhbL3ebJEqOCI88OMUia9x7G?=
 =?us-ascii?Q?Iw2voKtAQoklNU780jGxMHOIaVktF+ZLejhSFFp19oUYcqlIYa8rXZoLOw0r?=
 =?us-ascii?Q?F8zvW5+eze//R7b7VwP3VQGrsgxhTqPhDz50c5xLtXpmQP6ltQKcIJ57HEti?=
 =?us-ascii?Q?GR2lAk+X9oVZ3bBEisGs/wdPxCaWIk+y8eSgIvCUkPdBZSKhWaqdY9cCIEtb?=
 =?us-ascii?Q?4xOC5trLvXbjsfMYhnBVH5e2cEG//Qp0UkxPeTamLkwyT9sVrG6eYSkfLawO?=
 =?us-ascii?Q?2SMWA13OQnorujssTsdq+t0OgJb3zh9sxW4DiHXVqToZaEmEmxHBYfcUhU81?=
 =?us-ascii?Q?LHk1hLWW6FsB03MHVnszmvVZGe+t7zE64TLZDYyKLzgRrdZReRlyxH1xKZtz?=
 =?us-ascii?Q?9wanxJGRXlKU6EtBc22LayI1H1djSm9a+bXjd6blquBlxDToJiuCBMaN5kxp?=
 =?us-ascii?Q?18XdOyD749wvpflmhFS8kuYaEAd7zkvjNWAztnVOyL733zjOC7MKLCpt2wX+?=
 =?us-ascii?Q?gT2+/799xq2Yy78HWHV/nrzuheJnNT021vQlgtpWdDsX+JdafxVVZRvUjtp7?=
 =?us-ascii?Q?y7ql3EQ1z2XYoZhvXIyLgT4jO8HM0r3uonC2RUvY6mk4UcA8NENptUGXooe6?=
 =?us-ascii?Q?S6YkQWzJBG4ijVdNofggyRG3G4SvhD48+7+s9LzqtxXIInw2IDnKdvMd5jQJ?=
 =?us-ascii?Q?xxJpovo12MWZuoUSbdy5tMqXSIHkQytp2J6dw3XBgZhmxGsw/VJaHgTNOrba?=
 =?us-ascii?Q?Q4Of880nZyr/XZAkQD7AK8aDkKLf/DtCGJSTc0X+5+wUgKHYYqOo3GPbGtXx?=
 =?us-ascii?Q?rIL3YJzkqYEUya7tKqMid7EcFYsxcnN12WVQAhnuAhe1Yjd/YTu5KvupUgqx?=
 =?us-ascii?Q?Y4dzO27fRXvE2u/R0zAyadl4MXZiBFDv7B0iRyJ2BgtY8F0ny0xomlfynGiZ?=
 =?us-ascii?Q?34oFMbUo+2G50dukYtvIWF3Jx3BDU7gUBnoN/2Y5lY9dE/UCw94Y/yuHfhqf?=
 =?us-ascii?Q?FyndbvhkL5OgT26GNxQGUerf0oQuZYZ8wIk1QPEn4BP754wm0B+S79V2G194?=
 =?us-ascii?Q?pHDLwYQ585jatXinMil9CyS/4IeWeItK0hXUhPhVgqf1OQ8C822V14AAA4ha?=
 =?us-ascii?Q?l+8OhUazekPz8OucfFvToXl8uON8CZxRTNugc9GkBpQWJIkn2O1C5OgseLJ9?=
 =?us-ascii?Q?YWzjMzKCEyNmQNfolhRef1Gsvsv+leD1n5OpNomaD1ssO0yATg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:44.0401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c2f07e-1820-46ec-8175-08dc8a36ea26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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

From: Alvin Lee <alvin.lee2@amd.com>

Need to reconfigure ODM when resyncing FIFO because on OTG disable we
clear all ODM programming

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 19 ++++++++++++++++++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 19 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 8e68e05e3b72..388404cdeeaa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -379,8 +379,25 @@ void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
-		if (otg_disabled[i])
+		if (otg_disabled[i]) {
+			int opp_inst[MAX_PIPES] = { pipe->stream_res.opp->inst };
+			int opp_cnt = 1;
+			int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe, true);
+			int odm_slice_width = resource_get_odm_slice_dst_width(pipe, false);
+			struct pipe_ctx *odm_pipe;
+
+			for (odm_pipe = pipe->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+				opp_inst[opp_cnt] = odm_pipe->stream_res.opp->inst;
+				opp_cnt++;
+			}
+			if (opp_cnt > 1)
+				pipe->stream_res.tg->funcs->set_odm_combine(
+						pipe->stream_res.tg,
+						opp_inst, opp_cnt,
+						odm_slice_width,
+						last_odm_slice_width);
 			pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 732da5e5c1ba..33b8df995869 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1237,8 +1237,25 @@ void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
-		if (otg_disabled[i])
+		if (otg_disabled[i]) {
+			int opp_inst[MAX_PIPES] = { pipe->stream_res.opp->inst };
+			int opp_cnt = 1;
+			int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe, true);
+			int odm_slice_width = resource_get_odm_slice_dst_width(pipe, false);
+			struct pipe_ctx *odm_pipe;
+
+			for (odm_pipe = pipe->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+				opp_inst[opp_cnt] = odm_pipe->stream_res.opp->inst;
+				opp_cnt++;
+			}
+			if (opp_cnt > 1)
+				pipe->stream_res.tg->funcs->set_odm_combine(
+						pipe->stream_res.tg,
+						opp_inst, opp_cnt,
+						odm_slice_width,
+						last_odm_slice_width);
 			pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+		}
 	}
 }
 
-- 
2.45.1

