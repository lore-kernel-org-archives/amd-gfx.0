Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CF1CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5687910E7B4;
	Wed, 24 Sep 2025 18:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T76f8Qse";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C51E10E7B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1MMS/u79abut9tut4s0tSJcbrCaMf2thWaBMd7dv1Cvn9C3XOydi+Kj6d/qDh3n6P1D70tKOhADgsQ2GbZY6MxXKOfAvs5nyUlOOWS1riA7iCqc9mAQ5NRH81LS9f+ePf0kj53//HYS1JDJhCOxMsD7KaTrplAQfkhwAHVh+XAmwTactFRJldppHnIJTw7OSs4YVVhBPOWQQnjfsQfp1MBVIc4fDcSKYJ8AlLkIrVa0qv5wV75HXNeNdIdNec+veLIiaRYH6g68p1hhW+ErG0R2D1KJPl9I/MSBX/R2shGl0rHqoDFBvUs1x444DML0dlj2HtLwhfZ9pEaJHCSZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akaKDFSQmFcMFxLVrCM9wY65oVrZBVLbW4FuX/cQEqE=;
 b=DI8PQET6AFKpCfdKWvVYspPhZdY1dzm4nFjhj8s7ubgx8SFRm1xWqZtQGiRk0/zoXrJLT6NftsG69APMHIzh9S29wmJjySU56B+u+t2kp/CZDhni60qEbqF9DS4aU4OJqkYDv4fkq07pCiS7KCy2GsMVZU13QerY4KPUaEHOZMCwA2x0SPMgLsJfXCyzPbkjzW9EZrm5r8z1R8m893dLy9FibasN5hrMuCSVeh9HA6MB/ElSyfPQz9jsFgGMOC+OKcRjNJ8RP47SuqaWo5rvYOhcGjKVDOkV5UzSHyq3vqjFfIXhQZMr4lDEzISW674y1a4sXDkQd4FJJIfHJsS0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akaKDFSQmFcMFxLVrCM9wY65oVrZBVLbW4FuX/cQEqE=;
 b=T76f8QseRTqViAOHbwKWcAdSpTMfYwjDLifYLg89ZXsDk5zoPntBUdoo+iIxxWKHjQUaUdR8ZUVft33iPvCnFlol2HvC8E0ZSfLRemWSwjF6a5/2cJ5rkeVDK8KX3/Od84kW0+XuYUKbF8FX88TzKLauQhlLGJvYmt9t8tRz9fE=
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:22:22 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::1b) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 18:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 18:22:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:21 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Sep
 2025 13:22:21 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 11:22:20 -0700
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Relja Vojvodic <rvojvodi@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 02/10] drm/amd/display: Correct slice width calculation for
 YCbCr420
Date: Wed, 24 Sep 2025 14:21:53 -0400
Message-ID: <20250924182201.1049389-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924182201.1049389-1-Roman.Li@amd.com>
References: <20250924182201.1049389-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: b32094ca-27bb-4759-ea58-08ddfb974dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mrBF4NtGQQOkymGQsOGrLwDatWZzLcqvmzaV4TsIbTocVm/uN/VA/sNnE8m9?=
 =?us-ascii?Q?Whllrlky+42GuMWlF6bh9f2A01CEHsaD6iHwghnIeBw7ioCHY9OdBR62ywF+?=
 =?us-ascii?Q?Q3SrvJzGjhRi+EovlcA4YhryIyHg0hN4NyEu2SzOlexqmvpp3a5TnjFq/uys?=
 =?us-ascii?Q?F12GAZWuYPkavalOkhI/8xKVjfo7tU9b3tT2p2f5MaFmAQaPC+hs/I7RiFtj?=
 =?us-ascii?Q?6+Fgz5Lj6lqUcgJM6PEy819Z+T0WGjELQy3vxqCm44aaKhqNWRkCRD5sYXQJ?=
 =?us-ascii?Q?mSpNwz56sAntEs3KWVpsBeFRr3M7ZLxz3lKD422BzKkzerpv97Djj+kxYyTJ?=
 =?us-ascii?Q?RLrdi2z8aNBh43uKRE2IINYDqnQcFMRmoVlVljd6jDj7lnUJ3VJ+q/Kd9Mau?=
 =?us-ascii?Q?hQPawtFyUqPd4EpqIVnKUUIZjJRsFC3Sc6xfY/inNvxstyB31ouY8n9Hcjg9?=
 =?us-ascii?Q?+6EnVT6CqrOQAPYMt2qcbu+N+8OhvKAzhqVhB3GAJ12Ns4S287wpURvGaOQe?=
 =?us-ascii?Q?JrKzn7d9jljZptDCgYlAtiFO3T38TUP4Jb8+35OZzQSgnN3k0WIEG+1Ehkdb?=
 =?us-ascii?Q?M2pk27z6MboUCpGoYNLvwcMPMif/nUKl/5FJAHBxDm7Pp/CNl974wMUKQ1tK?=
 =?us-ascii?Q?C8oYCywzT0O8aZeW2Tx32s4MBha9cKP/FRwxGE96WgWmKWQ7y/krBWROeRh7?=
 =?us-ascii?Q?pgFf/B3x497JXc2RZexTc5AOx3YlkGMuSro0Nz4XoU4r/BJVtBillUD9LBYH?=
 =?us-ascii?Q?NlKdvoXni/dS/WVwR5x/Lmc7c+EMUWYcHXgc9EajNmXZL+McB209LRLYYNIJ?=
 =?us-ascii?Q?CAP37XXYM9Alqh0Dm+oqME4q/m1I/R60rJdzujVLANOiaq68X7FhbXcMdpUG?=
 =?us-ascii?Q?JCgLhFG+i1iSZgQ1r1l02hfyN1rITB01pEGNQ3MFdeNn5anJ8FO4KTEAEhBU?=
 =?us-ascii?Q?fVbvoluKIRJHfej/pu81orozSYlD8+Bk/jaMyFVsaaflP+JzAwebkHgSgf4K?=
 =?us-ascii?Q?wLSJxtXa05oqybOcR+1XSwEcAyIs6Z+2uu7MD5LBPzIJgNocaEBdnO6rrZBU?=
 =?us-ascii?Q?FZqGe1mfIyVF3AsC429xL4Ba6+UD9/7Xt9/uuMNYmig+Dy5BSr+VNLQe7aBz?=
 =?us-ascii?Q?TmhG4OfLn9lf1rZMBAsh1JBkhmvys/cK8efFj8tc0m4F9r96gqf4JwlGRlLP?=
 =?us-ascii?Q?ySlRkELwRJm/v4uM8xbKHw8bEBpaQlosQ2dqG1RwwFaFMRue7jR1CvAIL7OR?=
 =?us-ascii?Q?48O9/I+rx5nXJfQSIxkZMZy/pvlQaN4xihp/d4mg6ypLvO12R4fLW2NIIBLE?=
 =?us-ascii?Q?zOHgkjudhROMb8OW1G2Ml95EiPR6pRa0am6pH81CiAHnMigaa7jHw58n28ll?=
 =?us-ascii?Q?+x18xo/xAinDG66rBYmLVDfiGAPDorK4VngnRd7Cm5UdREP6z5uBreZoPIeS?=
 =?us-ascii?Q?qnIJwU/TilJKbp3ZneLONlIpPO/vvWMRRXBIKEGccaBpsoT5TJ6K8Yd2/8AV?=
 =?us-ascii?Q?xA+SCKChr5EWronBFE8O8TguC+4wRvnykhct?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:22:21.9518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32094ca-27bb-4759-ea58-08ddfb974dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
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

From: Relja Vojvodic <rvojvodi@amd.com>

[Why]
-OVT compliance testing for 5120x2880p300Hz YCbCr420 was failing due to
incorrect slice width being calculated

[How]
-Ensure slice width is divisible by 2 for 420 to comply with spec

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h                       | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c      | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c        | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c        | 1 +
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                | 2 ++
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 1 +
 7 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index 89f0d999bf35..ee8c11e085cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -407,7 +407,7 @@ bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values
 	dsc_reg_vals->ich_reset_at_eol = (dsc_cfg->is_odm || dsc_reg_vals->num_slices_h > 1) ? 0xF : 0;
 
 	// Need to find the ceiling value for the slice width
-	dsc_reg_vals->pps.slice_width = (dsc_cfg->pic_width + dsc_cfg->dc_dsc_cfg.num_slices_h - 1) / dsc_cfg->dc_dsc_cfg.num_slices_h;
+	dsc_reg_vals->pps.slice_width = (dsc_cfg->pic_width + dsc_cfg->dsc_padding + dsc_cfg->dc_dsc_cfg.num_slices_h - 1) / dsc_cfg->dc_dsc_cfg.num_slices_h;
 	// TODO: in addition to validating slice height (pic height must be divisible by slice height),
 	// see what happens when the same condition doesn't apply for slice_width/pic_width.
 	dsc_reg_vals->pps.slice_height = dsc_cfg->pic_height / dsc_cfg->dc_dsc_cfg.num_slices_v;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index b0bd1f9425b5..b433e16842bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -41,6 +41,7 @@ struct dsc_config {
 	enum dc_color_depth color_depth;  /* Bits per component */
 	bool is_odm;
 	struct dc_dsc_config dc_dsc_cfg;
+	uint32_t dsc_padding;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index f925f669f2a4..4ee6ed610de0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -108,6 +108,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
+		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index f39292952702..bf19ba65d09a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1061,6 +1061,7 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
+		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 
 		if (should_use_dto_dscclk)
 			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 05011061822c..7ea3fe48b329 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -364,6 +364,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
+		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 83419e1a9036..dba8ec0988a1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -841,6 +841,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
+		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 
 		if (should_use_dto_dscclk)
 			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
@@ -970,6 +971,7 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx, bool enable, bool immedi
 		dsc_cfg.color_depth = stream->timing.display_color_depth;
 		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
+		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 
 		dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
 		memcpy(&stream->dsc_packed_pps[0], &dsc_packed_pps[0], sizeof(stream->dsc_packed_pps));
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 84b38d2d6967..f4d3ff79717f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1668,6 +1668,7 @@ bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx)
 		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
+		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 
 		if (!pipe_ctx->stream_res.dsc->funcs->dsc_validate_stream(pipe_ctx->stream_res.dsc, &dsc_cfg))
 			return false;
-- 
2.34.1

