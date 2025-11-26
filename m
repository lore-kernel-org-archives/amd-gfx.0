Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A153AD111B6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3958110E72F;
	Wed, 26 Nov 2025 23:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uJ6sP31R";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDFD310E730
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7H67VJzC3lPl+a61iN0bIf/I4ja2CWL3SXv9k3c3NWWQi0/KD5KG1b8Y6Q5ENJGcRlgQQ/+ClC6p+Y1MDtxIfvBeGT0zeBFMMEzkagHL93/nUuG1/XeTQmk/7QYaE3KiWrBsnR/4TWmYHws8Ltj18sSPbmOT0ZQPm2bDbPjQuKqmK96zissUi9K98TeD5uFNBk8/jqLo4vMo2vQh09ayWr/uvh7TswwMmS4BWKp7sJej/wJL/KrGZqKDQZ4rSC8um/i1fdDqj3eqDrAHMj5gDnujn+Or2+Uyy6XRcXA1+T7iZrVXQVsBnJ5NutXCUnaUMkSUDJjjeD+cU/gPhQPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnFSsA6dcovuExufjezJI9CoMfKfNeC8hDr8jVl+qZQ=;
 b=Xhjuo8bYBmSJS7igKQyB1+elB5QTQJJsN4OoWOCHZ6K6u3Mu/HlStaexzcNLk4+O6Le9k+RQgrdSrAcGd8eY66sH0+Mk2p+Em6uuEkTOom+iRkMOI9WUmKOJ/l1dOKenHj2URlYmJKgLeTKREeBltUvZt4Dtw+I5UL57MUV/DMmlstcRBWEcRP/3omi7VoADFlW2mCJHNM2lfEnxqImcDUEspRCwz/RgAJj3dW8TUk40IX9LnVG5CaxDzrNYTlsqbIqdOx9WmhrKmZXNIcxIY+kXV+t5AlxIQi0/pBIgPgVqa8Gx3ZVNydkQeeu/jdQU51sbH16oO2JLhWU7r79/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnFSsA6dcovuExufjezJI9CoMfKfNeC8hDr8jVl+qZQ=;
 b=uJ6sP31R6TYXthazI/uFC8blkFT/u6RGcanU3yDQXf6b5ljmChm6h4Wz8P/Gv8TtEug4k+SDpCFKSz2jXlfaZmCwq/VnhM5blOxs8RgL37fgQ17w0KzzINpwoQT+nh2hHm0T85aFCMQViCt8SDXwy6GUxZ5cmrjOVmBFNLcui5Y=
Received: from BL1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::24)
 by IA1PR12MB9523.namprd12.prod.outlook.com (2603:10b6:208:595::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:06:38 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::8f) by BL1P222CA0019.outlook.office365.com
 (2603:10b6:208:2c7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 23:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:35 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Nov
 2025 17:06:35 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:34 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 03/14] drm/amd/display: Move RGB-type check for audio sync to
 DCE HW sequence
Date: Wed, 26 Nov 2025 18:06:03 -0500
Message-ID: <20251126230614.13409-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA1PR12MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9dfdb6-7a33-4dfc-687a-08de2d407429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iSo7Uw4Be49leraM9wHR0Il9mriZ62OrqNKWn+ND//i4xKkaUkCSKSSJAp8e?=
 =?us-ascii?Q?29/1sAq5F1+UzNmZXAgG/muSzcXPtlFF7DHjsmU1pexJrTRV25+Qp85MXNbG?=
 =?us-ascii?Q?DkSJG9nEi0bT+rPMtldNCzd5oUu3LROa867vIZmNXUKEKmV1NyZE1Vt6RALs?=
 =?us-ascii?Q?2H8B2Fqn25d62GdosbWIpAr62bvOywaclZSeay9sWJymD75QPpemKD2RRLrv?=
 =?us-ascii?Q?OYapKHfMPQJuMfKXN+XOEJbBa+RX5ro9cAGTOUYFDt+6pkPWttw8TK+6D0a2?=
 =?us-ascii?Q?rRPSNpNowLzlr6Eydb5qyvJx8I0RkfoTIO1GAFaS0oZ20xN2VGpeQEIpaB2z?=
 =?us-ascii?Q?5BlrX+6qBZbQdoYdtA+BQ+ulK3Tg8VTP3tl1in6rxSzUTpiwBWqGRahKtFEd?=
 =?us-ascii?Q?wKC6pf9E/QoOb/0HQFIrLE/j40Avl76IxAvpZjriKul2KPbE5Aeu3Ne8uIfq?=
 =?us-ascii?Q?JagCqPgr9uxu407DBtkr4UtCFXwDXQjvQFc6adAbPiftz8zYFNJwrVrVJLND?=
 =?us-ascii?Q?C3zGD0tf/3jpRSIv3R0NIrKev7OaxSFWtGTu+SmGnV3jooTnYXo36YucgUaR?=
 =?us-ascii?Q?nLaet4lIboAmq1Jg+MY3SqrSch1BEOkVGvAbVcDT4L5cki+HlISJsdGK/J1I?=
 =?us-ascii?Q?sPDQ12bWnjCtcUfgA582Cvo4eBq6fbPI2JQx+SBTmCzoHkV9v7NH0zqLiCbv?=
 =?us-ascii?Q?q6D5x5bFbjAXxcZGqYvhgl5cd8imZx5QwvT9kya/q1iHvTbUBSnyucIVCW1b?=
 =?us-ascii?Q?pMe4FeO6cVt7Jzo9tMFaD+wtkDwDNTcJebGItrDCFIURbIVpIcGITN/TCqhL?=
 =?us-ascii?Q?EaYvdKGXPrX4RW2mNb3fIYSuPhx0gYzKMZ0YkaCSTUFfQImHBBH18v3+B4gH?=
 =?us-ascii?Q?+9OGEZG8jkw6rgexwYkNyZDsxgTgvudwutoMKjlvmKiDLLVPFCaJ3xEzovbE?=
 =?us-ascii?Q?rXQ5GilkIgPYvJUvqD1cNXr6Fm4wQ1CwPymPY1mS42bu90HNZN09AehuDRC0?=
 =?us-ascii?Q?l0zz+ptP3riw0etJq0VQNJHFvTutCotEm146L/mwYIwE4ghflXqiVuNY6eXp?=
 =?us-ascii?Q?MvxIusiVxr0yoxBAXHnjt17rWUve4R+HtJXAPP4Ly2IFVyUvvXeX07UepFGI?=
 =?us-ascii?Q?fbC4asW7csG2hIf8aILiM+MRjWQt2L7oqD+61/NOlDIzEwKIWUAlco5RviNf?=
 =?us-ascii?Q?7T0A8QcA/EC6rM+6SC+IF4rIMwVVekm743jAi06h4IaPKJpBr2OqXAz9jqGY?=
 =?us-ascii?Q?WcRr6b/AlrWwJmMvBfBZADWF7Ai7/T6D42P99CqbDhnWFwMbPpXzLh2bsva6?=
 =?us-ascii?Q?L/nN9uB+E36VCBckmYELcldImNiyKUwOEIFsXMkqogPunakDnLAb+MqQ/Bgj?=
 =?us-ascii?Q?/KxS5CKrI4ppEVzBb1kmmE1j5n+mJkdc5Vnax40g3GEjll1B/2BFF+VgAIMz?=
 =?us-ascii?Q?MTi93p0m34akSUK3uRMBoezXaZWSiHhvRWX9MyaMT3X63AoFBd3lAtgLwJTn?=
 =?us-ascii?Q?G9QYIXiPj+XRZWYjNn76U7vVWRj7XPdPuZBRRbs5ZzYCdpM1oMv/4JUBfgFC?=
 =?us-ascii?Q?W8v38W486hyx3b/LSSs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:38.2769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9dfdb6-7a33-4dfc-687a-08de2d407429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9523
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
DVI-A & VGA connectors are applicable to DCE ASICs, so move them to
dce110_hwseq.c to block audio sync on SIGNAL_TYPE_RGB for DCE ASICs.

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 3 +++
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c           | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 94e66d96c403..21cee49c128f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1103,6 +1103,9 @@ void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
 	if (!pipe_ctx->stream)
 		return;
 
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		return;
+
 	dc = pipe_ctx->stream->ctx->dc;
 	clk_mgr = dc->clk_mgr;
 	link_hwss = get_link_hwss(pipe_ctx->stream->link, &pipe_ctx->link_res);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 77e049917c4d..302addaff480 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2664,8 +2664,7 @@ void link_set_dpms_on(
 		enable_stream_features(pipe_ctx);
 	update_psp_stream_config(pipe_ctx, false);
 
-	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
-		dc->hwss.enable_audio_stream(pipe_ctx);
+	dc->hwss.enable_audio_stream(pipe_ctx);
 
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		set_avmute(pipe_ctx, false);
-- 
2.34.1

