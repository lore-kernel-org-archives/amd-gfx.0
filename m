Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08A5C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5C010E440;
	Wed,  7 Aug 2024 07:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T4qScsyK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BB310E441
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyRrntF0yAeohRfFuNh2z//4vUGYyeOVVFFohzKGbtBsXmClA+Ub0iT7Zm4bAU02D+On55vk4SzYRXDBDenu7bVMoDDnaDmMS6pzO8iQjZoQIYXfis4js90idTjwb+vM4qcl6s7+VOqoqwX7IN4BxiR+FDY9GdpvPOWnUU92uWagnF5rlAd6b0BwovlXMMnIT8m5shCUTvhqXAMdnoBjclXSgTX/GeJLhgziAWhQKtR7DP6lo9lh+hKaECZ4rN9gu+67IjtWzewFerDRLXtdE9A+VWIZXl9HEhGzMtE98XM77SohRIBepZliEgo2Omc6DN5XT2xxtlwQURW86/qZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYs401uDFpFcHK65gUMphvcGkyVcSMQLdoRjy3xu8qg=;
 b=pflElxfHbmNtBb6xWWMe1JD6nL3cayLqj7gIlatfjHixNzntprKWeWdli2U107vUfGw6wrVqbu+ICc55LEjQNgk7xLZh/CD1o7wTdqzJ9PSjFnYtcSe91KQfuRpFv3Z3fz/LvHKmYGlJGhSAJR93F6sUshxNMacmYk6L5jv/waoIrVsoNhfma00jETAgsYtkX7L7E/UUDIt8s9dsnyE4qeI6xeqxFVNrY1AxnyHQKfWxQo3ctd1FwWqVs5v25AA+aIjFtDkvSUVn2B6IHSzZT6hDu9OrOMg+ddn34yIlfMByp4axeFNSTXav8Jc4qCrEg39y9pxDk+0VqOJDU8icUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYs401uDFpFcHK65gUMphvcGkyVcSMQLdoRjy3xu8qg=;
 b=T4qScsyKOmOOn9/yJzjyLkKHWmcOc2RPVlWKRxuV4u+KGbTTV23HLqe1aXJuvVL6WXDoEJG/uCOk7LwwBpHGdve0DSvC5JOVEMBk9+We5ddXgT+7QRogqrmZN/O1+4F0Yv9aj+YBfw+ydzjHcgeFj8nS5vhaoHlrZj3rE+mvWgk=
Received: from BN9PR03CA0785.namprd03.prod.outlook.com (2603:10b6:408:13f::10)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 07:56:46 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::72) by BN9PR03CA0785.outlook.office365.com
 (2603:10b6:408:13f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:45 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:37 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Hung <alex.hung@amd.com>
Subject: [PATCH 10/24] drm/amd/display: Check null pointer before try to
 access it
Date: Wed, 7 Aug 2024 15:55:32 +0800
Message-ID: <20240807075546.831208-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4755c6-d94d-4845-1406-08dcb6b67c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TL9LBAK69apDHeUQ2kYcQVEvjccMzHzperwsA7UjEMffg7fnBCVoYvvGmjVs?=
 =?us-ascii?Q?MNK/SJPmC5r/OfQzKfqDdGP0DU12PihyncsZba9pNkO9INfXCGMqxX9yfoH2?=
 =?us-ascii?Q?U9GQhWpZV2In/XG+VfmruBbQn88ZDkIgteumCboLoMkQ0NUues+SQ6nw2Ebi?=
 =?us-ascii?Q?UbijpxeWtO5X40nun3JiHBXjhoiwmxtlaXaBQrUBDHSckZmIPOc08kuhkdd5?=
 =?us-ascii?Q?H96D89vGH2WRvNo5+tRTYOiCqq4CWxD5ju3fLz0/nLupvtMBHeDr3hIlYDEH?=
 =?us-ascii?Q?tqipvQDftNDvipPIXqgrIViDZc8VXEw/spHGDv29ZfBSp+Y2gyG+TFrT++S/?=
 =?us-ascii?Q?cdtVbuV7xmPXmrnSJlgCXaHGcrYhw8GNLE/ei54TEPYIBl1wYDdTD3V6ny+2?=
 =?us-ascii?Q?b/nIV2iSwKO8gyJM2/lMHwrKe+aBNR6irlk01XTZjupXOx7OvsGvf0R8qT7y?=
 =?us-ascii?Q?sicJXT89ar+4eCbuSbfTD2cCEbYgWbPPZl8dZMZRGtvFl3QTXTRtKkxrxUkP?=
 =?us-ascii?Q?qyf9i4uzJyCS7slM5iE5vXKM5SixqpgTfPA4B87m+EwK1n6jqJ1/mBChFpt2?=
 =?us-ascii?Q?XsNqIdghNg2kO4QawXsIxSZhu6/b/QgSGZZnjxXOg7Hv2hyUWeUW9K2IsFG0?=
 =?us-ascii?Q?/j6NH4S+Ow2xPQAsUEwSqBapdLjwPTs8lFM0dn17Fp5xA5fqDyXZ+fY8L30S?=
 =?us-ascii?Q?WfE9zYYJ3qsTLlj9dJNqECMbtH9qkxH1lwxxvz2cb+BsV/1itt59vcbZ0s+R?=
 =?us-ascii?Q?92trVyZY8/xOPt6OhJXjIX4g/sFjl+boo8s3pdxk4RIXUGveEY3v+1ajEVgh?=
 =?us-ascii?Q?Mb0il6cdj13j/iSjSMB/5iDgKQDNx0by5LF2OSeh1ZbgV/PrE6+48kRwmJGo?=
 =?us-ascii?Q?6OWD90qgL9nMkj1AAM6ha75jxFUxYQUQLT68vTC/EmDJ4zFRf2evVFP3pBEi?=
 =?us-ascii?Q?6PWYuTYQB55k6dfLa+DrMnSL7sIeZ7tswM618bbvvmLa8dZtCGwXs1P9ftdJ?=
 =?us-ascii?Q?E/LUEVx9+dl6Cj+UkXQDcGg+hnD8eSlx3+PI0ghSGTxySgQubEmzOTZSmvxX?=
 =?us-ascii?Q?JlymwnArYvbYpEKg+Xk0GGAvNDn3W20VaJAHTcJGnccwwgu1XuKSiHhWP+oE?=
 =?us-ascii?Q?sVx02l75poCoAlo0e9cy1YsA/5dgdYChpZ7QnnBpPlFYNeGVjpcOhWXHCbe+?=
 =?us-ascii?Q?EJgQLnti/6E8HovKZj8pgNmfMMteXWsRtkhpk9NmUgvp1GxBVb3WN8MpllJ6?=
 =?us-ascii?Q?hxuZfDbef67Ce81pTQr3gmYjCLB983KIQjo6HBaQ58lvzokUF9dYtC7SwZX2?=
 =?us-ascii?Q?3SRjHtkYlFObGbdlUkiKWFpmIlD/Ef2Qc9C4xjly4+4lFawsrqyohDhHfhYy?=
 =?us-ascii?Q?IzjCrq+3wKRdpNfoyWI1370bX9FTeOSa5eZ21I2a9+no7Ejwl6xkIhWMam53?=
 =?us-ascii?Q?/sU1nsBB2p+4zxeZoMgSAGKNPV/4rIUz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:46.1660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4755c6-d94d-4845-1406-08dcb6b67c1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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

From: Wayne Lin <Wayne.Lin@amd.com>

[why & how]
Make sure plane_state is not null before calling a function
that dereferences it. Besides, remove redundant codes.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a68da1a7092d..a80c08582932 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1928,15 +1928,10 @@ static void dcn20_program_pipe(
 	    pipe_ctx->stream->update_flags.raw)
 		dcn20_update_dchubp_dpp(dc, pipe_ctx, context);
 
-	if (pipe_ctx->update_flags.bits.enable ||
-	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult))
-		hws->funcs.set_hdr_multiplier(pipe_ctx);
-
-	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult) ||
-	    pipe_ctx->update_flags.bits.enable)
+	if (pipe_ctx->plane_state && (pipe_ctx->update_flags.bits.enable ||
+	    pipe_ctx->plane_state->update_flags.bits.hdr_mult))
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
-
 	if (hws->funcs.populate_mcm_luts) {
 		if (pipe_ctx->plane_state) {
 			hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
@@ -1944,13 +1939,12 @@ static void dcn20_program_pipe(
 			pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
 		}
 	}
-	if ((pipe_ctx->plane_state &&
-	     pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change) ||
-	    (pipe_ctx->plane_state &&
-	     pipe_ctx->plane_state->update_flags.bits.gamma_change) ||
-	    (pipe_ctx->plane_state &&
-	     pipe_ctx->plane_state->update_flags.bits.lut_3d) ||
-	     pipe_ctx->update_flags.bits.enable)
+
+	if (pipe_ctx->plane_state &&
+	    (pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
+	    pipe_ctx->plane_state->update_flags.bits.gamma_change ||
+	    pipe_ctx->plane_state->update_flags.bits.lut_3d ||
+	    pipe_ctx->update_flags.bits.enable))
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
-- 
2.34.1

