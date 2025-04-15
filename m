Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295E7C369BE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF8310E7D9;
	Tue, 15 Apr 2025 15:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nCrT8p2G";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885C610E7D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0UyD5UKzUu6ZD3cqMF8jq1xTYvBEsDfTy0y+DwMnX0A//r10dqR9EtpDdYhNkRsMAmaBiLYRPbxLFwvkSJpiHCgO4V67y1GXsXhKtIwdbNYI30tG7MC3TXOmaKRL9eSktD3qj6T4W9sU2zzGOpnH+7wv6LqWCkA1fLnLPrTa8kQyjcWkpWuLiHr5pQ7dkzXXQIzmdQAO4XuxnKTInlT1z5fz7zDbS9KNCilWvRUzRdULyhGLqwci7uaqk4UmJHOEg1S0RRK9Cyxl6zIFIYICj5muTpkqzzNwVlZBPX4AMVwSCM8qU0NPmwmjSO1SsxIPhVN7t66bPLFY82gArDE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBtuMuVXpoE3TEaymHnjd78muxKJQGRNySzpzag2fvo=;
 b=Wx0OZgr0et3rgoU1lSckC6FRXYWURjyehRd34F7EQgX0KBcmeQHFZxWu3//yTHjQuZ2dv6nXGwWtEfrTMIjp8UtXQnuSSE8O4x93ovLGgZ3hcAtZtHCNyzRbSQ1PtPcbGnO9muNK+Hx4BCqa3Q6nbxp9ZnzRH5aigRoyXhrtZwrmgGX3tWXqLUzIHERrtV/JkBJFOcUa0Dh+CVI2PJJI77yG6cfjvm1mKtHALZpI2gRhMJhSRzCCnOM4l6MxeVxYMvOUSNSVxHFi8EIWPN9L6dGmB9Fi0BtDrTzM9CoqSwHA4Tfr7k7/BY2WNh3h3c03Q7ILwkE/lCi8+j5NiREK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBtuMuVXpoE3TEaymHnjd78muxKJQGRNySzpzag2fvo=;
 b=nCrT8p2GtSerN9+lgdTSCjqBgQJCvS+ZLI3Ceb9RSkeA6Oj+xAPGZQnD8vodh2hePb5N/h99YJCashopztJtaP2iAx943dMRJVolobw0i30QdgFzhmYAK3Ts53lauF+JEUMDQF58XhYSfLePGGgeevTueNiptkI+RTGnuBf04TQ=
Received: from SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25) by
 SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 15:00:04 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::97) by SN6PR01CA0012.outlook.office365.com
 (2603:10b6:805:b6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 14:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 15:00:04 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 10:00:02 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>, "Michael
 Strauss" <michael.strauss@amd.com>
Subject: [PATCH 19/22] drm/amd/display: Fix pixel rate divider policy for 1
 pixel per cycle config
Date: Tue, 15 Apr 2025 10:59:05 -0400
Message-ID: <20250415145908.3790253-20-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2e2080-dd2e-4ea5-5efc-08dd7c2e3470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qq1lDDRWtMVW78IKp3vaQ78RxMEmoZJdKXuEgoG9ej8xh9CiZRIsMyVEZJqy?=
 =?us-ascii?Q?q6Y1JKgUpwAFcrl3d+eCYy+n3q5G/Ej3Kg6tNT7ziWtcU2XkI+qAjoxvyAsK?=
 =?us-ascii?Q?V6JBqT+EsQXyHaki8DdAlbGzLY2n6kvegUBJYYxZP81JQ7qTMy3XyIjAa8zF?=
 =?us-ascii?Q?aHZqhhmRbV2dCpIuHenjcpndmJTnhgWQ9C+z6BXr6sINYQMtBFzNzVdrQDl/?=
 =?us-ascii?Q?UwSgRDHb4hOlWgqWgR6a5G7cZcOdz4rgKfxRUXC8zqOMrHnSiVRGdxk305JS?=
 =?us-ascii?Q?+Ru8rjUjH3jct8p54utt6d7Ad6sL+tKkOV1/TFlrNC5AeQHZOy82QcZqb0ky?=
 =?us-ascii?Q?u87TGPvBbTUl+YPKhBUKz0nBWnBISStS5eR2I4tZw4V0ewXSpHL+sV4ZdJ0s?=
 =?us-ascii?Q?7YlSj5hQtyd/bhyJsCRHvaHT9G/fTPP/Vzcidc+uvUBxPBfi1d2nBkk+hLUn?=
 =?us-ascii?Q?8T1lYNpYYQXitDlJ4oq/2ae/FcA1sIM4sHgXj3f9t5JTHu8wjUYIEAotsCY+?=
 =?us-ascii?Q?VMclgkmMLbzzgECoIvJDWsMXcxfhBgR9fHeQL3E3xqaSANXk6nlKiLLwQ1lg?=
 =?us-ascii?Q?1EXoT442irbIfqK9uCHW5wfcgUxHzBsZkWi5vCTRo6Ioag6NlCRcbaX3MPnz?=
 =?us-ascii?Q?Uj5vamHZctDe2Hle/QS1uBMJ2Ljt918g6auiLJwslhnWALCbNEVBBL6tRVpe?=
 =?us-ascii?Q?aj53RopHHPvZPDAdqgywzpnhcyyUrNzz2p4/+9vr+ZnPE+kK6vty72TQ9alP?=
 =?us-ascii?Q?o0w9rkCbitQ1VsQtc7bWBfG1chIEhDLK7qUV89YpvYtP2Qs3lbAWoE4ov/hw?=
 =?us-ascii?Q?pinld4l3uQIZCOThqj1iRiOC3p+hTksBOGo7NuymR3GIodD1iZWLAP5cS5IW?=
 =?us-ascii?Q?2W/lfpgSPFAfdyIVsKC4/wNA5aDjmsJGSRQ2DpZ3xWXAkiGBWOGirdBcVvYU?=
 =?us-ascii?Q?MIy8Q3gkH2uLIZllo/fsTkhrcX+hrkrb3s89FacjRk+W2i/N4RrbHV5oSVSR?=
 =?us-ascii?Q?975VbMTFulua0X+4/ND5dsjbJ8vYOksEYDQDE8WwbMjbwv+Sg8e99V9iZg1t?=
 =?us-ascii?Q?DKS9mipnkS09WTPMC1T62l7ij3W6HQ+ePzcbg8R/syFUUnJNASCqC8ZV//qj?=
 =?us-ascii?Q?LehkAW3L94unFLXxBpKg9vp/CqaPPxb9MYlMRGG2ic1/eaKUPijHEwSaJFz5?=
 =?us-ascii?Q?iXqC78iLERLaIDW/Tl7Lh1FcY8dtDYGfSITEKOJu3QO5MBIchbfiYvz1YCy5?=
 =?us-ascii?Q?pREX5e70kAMpwV0eTL1zW7sZmTEHgtDut3hg6DjwSVQIrbJGy6nHrhbA7/JP?=
 =?us-ascii?Q?T69qQmJO6GqbmbmUCTalWkduxO2Zgj6IDKvBZMPk5bMp07MaBV1hNuVVnXE7?=
 =?us-ascii?Q?XvFb50cx8C9XIpM0+4T+5OZYUyE2E5Wr0Ejyh6Y4TgsQMMjQw/jY5DnZHZfU?=
 =?us-ascii?Q?ZOsH33DMDcllKjnJf1GF3xlbvn88+mAvBaS+bsVpsxqutQ9CFYVTi+Vs/2d9?=
 =?us-ascii?Q?3OnXrPma9PzuUWCnLj8qyQLi/YkeMGoxfULM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:00:04.5819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2e2080-dd2e-4ea5-5efc-08dd7c2e3470
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Pixel rate dividor was not programmed correctly for 1 pixel per cycle
configuration for empty tu case.

[How]
Included check for empty tu when pixel rate dividor values were selected.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c  | 4 +++-
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index cd0adf72b223..a0b05b9ef660 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1181,6 +1181,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
+	struct dce_hwseq *hws = stream->ctx->dc->hwseq;
 
 	two_pix_per_container = pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
@@ -1201,7 +1202,8 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 		} else {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-			if ((odm_combine_factor == 2) || dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
+			if ((odm_combine_factor == 2) || (hws->funcs.is_dp_dig_pixel_rate_div_policy &&
+				hws->funcs.is_dp_dig_pixel_rate_div_policy(pipe_ctx)))
 				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index a4e6b6479983..58f2be2a326b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -158,7 +158,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.set_mcm_luts = dcn32_set_mcm_luts,
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
-	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.is_dp_dig_pixel_rate_div_policy = dcn35_is_dp_dig_pixel_rate_div_policy,
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,
-- 
2.34.1

