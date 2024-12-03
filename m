Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECF2E74ADB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED27A10EB74;
	Tue,  3 Dec 2024 21:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KgdiIvZ5";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFCE10EB6F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbefPzyyie3l9rhD5ZqCnWFwt8WlIf19VGVmkrsyLQY3OcGGcY5U2C6HWZwm2pbPkjMg+WmZZiIrE1gLrjYMo6hkm+it1cRwitpGxQzIcLNMlhLdGhf6u0rwbQFpLUyn8iF09vsyn/dusWCx7Je1klW3BnZrQtfZLGE5yhXbhU+iP99vIw/0mZhfbBsJ+bVx5q9GThTwV4qTrQ1inL+9GIbXfqQ4vCg2cfXWHTWTOaQhfDJeuZ9bhwD7FBVTdPnnJr5p2ARLWc9wDV60cpp/2ngUGp3tuwlFG+6K30FeLeo6GQkX9PoAVVX94TSvdsKIGxZlRqlDq3cO0+jOP/TRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YymysgURSFikYFtQ6+rtG0S93WoDFkBjsMnUvQnoyVI=;
 b=L4xZyBNxaSPmd28WcfzQIgFJzV/kyMxcXl4Yt4z19BsUsj4ot9oQEUhtRGhy312W4UWDJ3pcu8GZfEwQjEDkdao/ijGD54YARFpNZ0aePMpOn1kTG/aHmnfqGUdEQwHIwafPppDGBRta5OWrVhXX5Y/BdOcf6Szruz1jYiuZxDHAduYKZ5zV5XdMuyXSSYtZ/OsMz/vhALN4Ko0mpO7DBh3zRb8apBv9d+MDGkNouy6yI6Zvm1XclHdYdoNz5WwDA9IPJD8tAOs/re1uLpKXOFz8rGF/LD1VDS5cG9Ay6rQA+XKZkum1RVo4C2SU1zOkt5XYvhf0aQY+0+MLFP6pOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YymysgURSFikYFtQ6+rtG0S93WoDFkBjsMnUvQnoyVI=;
 b=KgdiIvZ5F1BDwx1JouTcFMgKqZP73fev2Y3kSm4nvgoybDmLcxbcz88ngAinurcvfnyeK4yc14I+JRjEedUogzLMrII33Nz0KCjNE8unMire5eHANsolpq4OfcO78LjENMRD4GFGo+TMV8erbqM8BbtisnIcy8J7F6HgICcWwbM=
Received: from BN9PR03CA0359.namprd03.prod.outlook.com (2603:10b6:408:f6::34)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 21:41:47 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::cd) by BN9PR03CA0359.outlook.office365.com
 (2603:10b6:408:f6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:43 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:43 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Peterson
 <peterson.guo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 11/19] drm/amd/display: Use resource_build_scaling_params for
 dcn20
Date: Tue, 3 Dec 2024 16:39:49 -0500
Message-ID: <20241203214120.1161810-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3ceebf-0d81-4cfd-8011-08dd13e34963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mwuOTvAZBxU6T0pCRwTgRh6p//vbY2WSnCkdNfcGQY7qc8JbYkjlifeEc7ua?=
 =?us-ascii?Q?Pghe7+dgZkFk03vozYrgVSnomDN6hfMyIP2855ZW0PvX8AwAQ7j4bOPdiu8o?=
 =?us-ascii?Q?D+9Ii0ktHzpBarpcnUxSTitIqVa3QTN+u39T+y6yogykQK7jXBvBClOJBLVn?=
 =?us-ascii?Q?sXl3md1OlYNzmIRDMcEjomRG3E9S3wSGGwSFQ5KEM0S7LOFJl49lZaPFfh0o?=
 =?us-ascii?Q?rH0DnLZurx85cKisDvIm9vIO++0nJIFy2R8xXThh1bb2ICWKKF5K0TVpxaZB?=
 =?us-ascii?Q?8GRFylCB23ym9OzPFftuBJGZRlbWhS8C0G9RoFKeuobICAucMIanwDVnEkUF?=
 =?us-ascii?Q?xBksTR4TpZ66/RMzNkrfn0RDYO/lf/qdRIoiFDL2KrmFHMVXOyVpzITGaiBG?=
 =?us-ascii?Q?4hUV2RkbY3ldpGcbJcy3/o6CQKEHHvvUcXYpw0iQ1nEWnifrqt2bFL0xz+n/?=
 =?us-ascii?Q?cnpWYLsqsWTTxc0KJP8TM3Mz/6NnZJTtUM0wm5kyNlp/w/uNrxKcIwR04czO?=
 =?us-ascii?Q?qveKiW1hVkIoyv23ywUVbKG9Iej0KEQtf5X6A2Zj8j/UWIZe+C0+Lp8Q3DGZ?=
 =?us-ascii?Q?jkbxExBPVbHp8xP6Feay2sBM61tsqLtSPN9jkd9m2NYbrlBGrB/Cs9GchsQ8?=
 =?us-ascii?Q?/KOvWPkVgj/ErOIyqiNUUekY4SF5DNDG9xMrCVQR8d0241SqTMI1xEbZSXqo?=
 =?us-ascii?Q?/AAOtTEG3gWqJe/RY3BGJbIsSFyUtoit0xWb9SOZZLNZPsdkcXjQD+L8eQrm?=
 =?us-ascii?Q?tQgycTT+TDoBmxqFbKdztwT+q8wv5IV8f42on5ONCJxs4QyMpQzyqMTAjzcd?=
 =?us-ascii?Q?4w8g/qCYTw0CPm4Wlfr2LWiF7A/m3KppgNIA4bw96r7kZoFfUZwMEdt4/QZ7?=
 =?us-ascii?Q?JI1rLueHIU4tKPCu7X6JoVWH+o+FxeveG/2OCuv8vkfh0BqAWtb1T2w8xfvn?=
 =?us-ascii?Q?13O26UTziCHZ+eeD6Dmz1QUg0LTrr2IX8zfm82FiuSypYQ94fJpTcj91lhsA?=
 =?us-ascii?Q?lmA9+8EXKutpgrv6VAs6IdQT3opPM9oIoGMadbYsPBP308YVyXvNgaUgq4Vm?=
 =?us-ascii?Q?EOOkh6IlbREHE7eKCX25d5QLL3Rn6dex74dJ7yiApQdhe++a21gB2e05svom?=
 =?us-ascii?Q?oqWanQ2NDMIpxf5JWMGpZ2EJATYc4zvfNn/I+jqOVMNfLLh9moOnNBWjemet?=
 =?us-ascii?Q?4O4oGWU+zSVp45Kc0seJScPhzCPcIDwMfAAEGCcX3pTQiSheqOL260505pxo?=
 =?us-ascii?Q?uJDF+Q5PQoMDCv6WYGMutf5delNjfRSTyNTuFQbHyuZfzo8lRbAqn8v9uup/?=
 =?us-ascii?Q?O3VbKOY3axfXZ9yR9S0bSVz6IqmFJ911LW+eYdnR0S3d9tATC3B8NWdg+KgN?=
 =?us-ascii?Q?JClV4VK/dvMqOYwqynArK+g7tCOVNjvywEh05xzfyc0IA1qRODoAmSmYDwW2?=
 =?us-ascii?Q?WibCVDnMAaWDyKyjz5BYAReqE2qyrkBf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:46.5615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3ceebf-0d81-4cfd-8011-08dd13e34963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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

From: Peterson <peterson.guo@amd.com>

[WHY]
When using upscaling on certain gpus, some incorrect scaling
calculations would be made causing hangs.

[HOW]
This was fixed by using the resource_build_scaling_params function on these
gpus.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Peterson Guo <peterson.guo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../dc/resource/dcn20/dcn20_resource.c        | 57 +------------------
 1 file changed, 3 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 7a5b9aa5292c..5c616b1f7bf7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1509,60 +1509,9 @@ bool dcn20_split_stream_for_odm(
 	next_odm_pipe->prev_odm_pipe = prev_odm_pipe;
 
 	if (prev_odm_pipe->plane_state) {
-		struct scaler_data *sd = &prev_odm_pipe->plane_res.scl_data;
-		struct output_pixel_processor *opp = next_odm_pipe->stream_res.opp;
-		int new_width;
-
-		/* HACTIVE halved for odm combine */
-		sd->h_active /= 2;
-		/* Calculate new vp and recout for left pipe */
-		/* Need at least 16 pixels width per side */
-		if (sd->recout.x + 16 >= sd->h_active)
-			return false;
-		new_width = sd->h_active - sd->recout.x;
-		sd->viewport.width -= dc_fixpt_floor(dc_fixpt_mul_int(
-				sd->ratios.horz, sd->recout.width - new_width));
-		sd->viewport_c.width -= dc_fixpt_floor(dc_fixpt_mul_int(
-				sd->ratios.horz_c, sd->recout.width - new_width));
-		sd->recout.width = new_width;
-
-		/* Calculate new vp and recout for right pipe */
-		sd = &next_odm_pipe->plane_res.scl_data;
-		/* HACTIVE halved for odm combine */
-		sd->h_active /= 2;
-		/* Need at least 16 pixels width per side */
-		if (new_width <= 16)
-			return false;
-		new_width = sd->recout.width + sd->recout.x - sd->h_active;
-		sd->viewport.width -= dc_fixpt_floor(dc_fixpt_mul_int(
-				sd->ratios.horz, sd->recout.width - new_width));
-		sd->viewport_c.width -= dc_fixpt_floor(dc_fixpt_mul_int(
-				sd->ratios.horz_c, sd->recout.width - new_width));
-		sd->recout.width = new_width;
-		sd->viewport.x += dc_fixpt_floor(dc_fixpt_mul_int(
-				sd->ratios.horz, sd->h_active - sd->recout.x));
-		sd->viewport_c.x += dc_fixpt_floor(dc_fixpt_mul_int(
-				sd->ratios.horz_c, sd->h_active - sd->recout.x));
-		sd->recout.x = 0;
-
-		/*
-		 * When odm is used in YcbCr422 or 420 colour space, a split screen
-		 * will be seen with the previous calculations since the extra left
-		 *  edge pixel is accounted for in fmt but not in viewport.
-		 *
-		 * Below are calculations which fix the split by fixing the calculations
-		 * if there is an extra left edge pixel.
-		 */
-		if (opp && opp->funcs->opp_get_left_edge_extra_pixel_count
-				&& opp->funcs->opp_get_left_edge_extra_pixel_count(
-					opp, next_odm_pipe->stream->timing.pixel_encoding,
-					resource_is_pipe_type(next_odm_pipe, OTG_MASTER)) == 1) {
-			sd->h_active += 1;
-			sd->recout.width += 1;
-			sd->viewport.x -= dc_fixpt_ceil(dc_fixpt_mul_int(sd->ratios.horz, 1));
-			sd->viewport_c.x -= dc_fixpt_ceil(dc_fixpt_mul_int(sd->ratios.horz, 1));
-			sd->viewport_c.width += dc_fixpt_ceil(dc_fixpt_mul_int(sd->ratios.horz, 1));
-			sd->viewport.width += dc_fixpt_ceil(dc_fixpt_mul_int(sd->ratios.horz, 1));
+		if (!resource_build_scaling_params(prev_odm_pipe) ||
+			!resource_build_scaling_params(next_odm_pipe)) {
+				return false;
 		}
 	}
 
-- 
2.47.1

