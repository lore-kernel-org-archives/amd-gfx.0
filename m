Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C54C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5751C10EAAE;
	Thu,  6 Jun 2024 21:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wszymCyh";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9375410EAA9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8So+3tGedfeSUdUaCoScKlPgkCP67cwSEj5nrv/sqsGAHvzPO850YHIcIVK8x0XZgzfuZU81PCntDFPGPZNMhFXSC+mVaHUuGLZt6GWz1oU+xpCHA4X9qyX0tm8ewPZN374EUNmd2hTxbu5Q3HlJgAgGTHcMJ/eJWG8+GwI3h0SZfMAiyBCjHSGbkKdZkhRAIMED4V0pG4ijcmsqYtI/Y79seI0/ZxGTHZoS4xVcNHPLa/hUl5+8JPcil/mq89rxmQOSGUr/a4TZgJOI57Z4VhilO8N7hsn0snUSNCzSUXmp0rh91nVutX5TJtsqNP1w4L1xBKazg/oLMvEcxC6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhwieTqQQkSY+rUh4k9d+8+zY5klkmYNm9LBwG+mQSw=;
 b=HbmgrMZ5lATiEkKk878CIxLhlzCNH0wm7rjbFmMzFGUUSw2/lh9KqFsVPuXDgU8PK1277PL76wIMg1JZQ6T4TPFKvSa07YTgdCUsrAYoNmEjY1CcwrJMCS7w0iTrfjd4ovd3iMJGkfQAmyn8rPkgtApCzlLtQLa9hEOUaqMwJiCY3d8mkJHIMPESobGpOJVZz8XmhmyScVmyCPaoH0q38RjRRAVL2Froxb/XIhc2RWtXjQhQxBdv+xMwm4LuZSq0yzqg9foR1MumDjlId3toc6IRLP0fEJ0nVv0wuUrEW5r8pFm3RylnCxHkLH+7sapyv72BkMJG0lH51oHDJqyc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhwieTqQQkSY+rUh4k9d+8+zY5klkmYNm9LBwG+mQSw=;
 b=wszymCyhTvrQg+es1hN06cLLs8Rtk57P1H0ObG3jaqhys7oaAghfdMF9FM24i11J3ackz1HeB9jH2w0YbXevDjg6N9nfp8fq3na0oYt5me+lGxeh+Fd/fos714PmgVYqVc433z8Yvlxq0bh9YIyURs3S1sbl8Hxs1fHXW5aNeCI=
Received: from SN7PR04CA0036.namprd04.prod.outlook.com (2603:10b6:806:120::11)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 6 Jun
 2024 21:02:04 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::5e) by SN7PR04CA0036.outlook.office365.com
 (2603:10b6:806:120::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:04 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:01:59 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 07/67] drm/amd/display: add odm_slice_rect parameter in spl_in
Date: Thu, 6 Jun 2024 16:58:28 -0400
Message-ID: <20240606205928.4050859-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe70969-59d1-490c-cdc9-08dc866beb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MyOx9H2KrleCVq8jWmihMX0F1DT6zoChzTamftjQ1Bs42nxUJWxcLDjKemz7?=
 =?us-ascii?Q?leve8n8MYAnNi920V+Dzv9GzaGPJ75hjCWPzguTPmviSkFdShatihapgYKfG?=
 =?us-ascii?Q?KWMGE5nt8ZU9jBBnkpFmnAGfiSUxLHGpn9yAPP96aU0eSB4ZGseaFEjoOFqX?=
 =?us-ascii?Q?wredpuySAhVMlpV/hn2yBwk5DCqdDAQ/CdFvCmGzmaFjm5+f9e9rw5XizJgA?=
 =?us-ascii?Q?pDD8rcImj29Uu2tqXDEI0j0ixoFo1b/UfBukkBChX//5QZcWUha+Rcp80zhI?=
 =?us-ascii?Q?CJLdq4X0f4BNVWACym4r/v3ELGkgPVsR7opXUPl4cx7QevUBICQrOE7cFFWn?=
 =?us-ascii?Q?0FBWF0m/lrgPZBXvTMcZxoss+qBG+Q+a/bZesjuu1mQxZSjJCwUfNvo+vKCY?=
 =?us-ascii?Q?LWcjfqnRseSIDr4eXna6Xz/ZyhqIVwooJ0KNTMrwrzImXAYMJ0d2sjP9ocD6?=
 =?us-ascii?Q?lHqLVZEkPWiiE3TU6OqWbahn3NG9abh0nJdusIcmiuOrJihfGaGTShhgwS2g?=
 =?us-ascii?Q?+hLh4JhAJojqtPLGv9ZytXm2/CAzWxLHt4/g6jMEeZE4JuAQciPrpiCJTodq?=
 =?us-ascii?Q?XoFbM46GNxkPjSy2MyQ7Kh7BN0uhxzJ/t9jbfIbOfTJBuogBj93bT+8oH+er?=
 =?us-ascii?Q?gQA2AW9kIUq07qLNmTJr1K9vUJFjcxKkLUBYn3vg8OlsA0doTsD4OloIdJJ8?=
 =?us-ascii?Q?DkUwv79ELls0s7pdcjMJXlncgcNQ3uWn9N/CO70J/YD6tQDFNPCFRs2/kILm?=
 =?us-ascii?Q?87GmiBZWKI9z1f6PZsVrFgshlL71v0hIG9Z6wL2HrTCSQfnpd1b9BCR6NY6Y?=
 =?us-ascii?Q?MUm3/JpBZzHpC3kzlZrX0oKyOr1qiL0IGLCjhFBCVMuZ6Npt231OZDomzzVp?=
 =?us-ascii?Q?USmdjQ8FINsprkvM/SZ4qFIL8eIr3B+qZKlU+WesrHzI/k83qFGsRyUONnqx?=
 =?us-ascii?Q?pdhIDWH1edqLP0PDElfY8/KUz2vXqH2l4mIU92ym3hL9vRvdGjNScszo89JM?=
 =?us-ascii?Q?0pBaewKUmYXLWLEia1Lq4G3btE3tpPD7mGcIEPVNCNX2Abulj7sR5l+u4IxO?=
 =?us-ascii?Q?/798vuNVlz7i02poxPx6X0wjfyG/FPQiHA3tzea1iK6AtuYSwhBph4fecfGl?=
 =?us-ascii?Q?UdQTz1I3secL4Nsco4ZKzQMip5F/4hDc6Yu50K1k3m1OlVqmRNc+6lx1jXK2?=
 =?us-ascii?Q?SFhHyWQdghJf87NjJXkA+kD4qcWeO9f53Ah15gwxA6B/DcY48zMyjIGcJL4r?=
 =?us-ascii?Q?PcfurNxJy2RRLxMtG/CPLL6mN1f3TPYx2SzuaXdVwzlO0L7NaP5m3mg18djQ?=
 =?us-ascii?Q?bP4iVpyD9ZqfvOGQySFA1Uc9unf+DxWsO0rJGVRwSB9xmNsZGKC3atHlr8U0?=
 =?us-ascii?Q?71zRUzmjj6iyGsSLoJtl0S5/CqIGP//giGmzySrtsb62keNnnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:04.3903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe70969-59d1-490c-cdc9-08dc866beb2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
OPP input rect aka odm slice rect is a hardware dependent parameter that
can't be determined by SPL software logic. Therefore we need to
explicitly pass odm slice rect in. So ODM slice rect calculation is
moved out of SPL.

[how]
add odm_slice_rect parameter in spl_in

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  5 ++-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 35 ++++++++++++-------
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  3 +-
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index bc760448a378..582606319764 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -70,6 +70,8 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	const struct dc_stream_state *stream = pipe_ctx->stream;
+	struct rect odm_slice_src = resource_get_odm_slice_src_rect(pipe_ctx);
+
 	// Assign the function to calculate the number of partitions in the line buffer
 	// This is used to determine the vtap support
 	switch (plane_state->ctx->dce_version)	{
@@ -112,7 +114,8 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	else
 		spl_in->basic_in.mpc_combine_v = resource_get_mpc_slice_index(pipe_ctx);
 
-	spl_in->basic_out.odm_combine_factor = resource_get_odm_slice_count(pipe_ctx);
+	populate_splrect_from_rect(&spl_in->basic_out.odm_slice_rect, &odm_slice_src);
+	spl_in->basic_out.odm_combine_factor = 0;
 	spl_in->odm_slice_index = resource_get_odm_slice_index(pipe_ctx);
 	// Make spl input basic out info output_size width point to stream h active
 	spl_in->basic_out.output_size.width =
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 9c6171e90163..ac58991eebbc 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -170,22 +170,31 @@ static struct spl_rect calculate_odm_slice_in_timing_active(struct spl_in *spl_i
 	bool is_last_odm_slice = (odm_slice_idx + 1) == odm_slice_count;
 	int h_active = spl_in->basic_out.output_size.width;
 	int v_active = spl_in->basic_out.output_size.height;
-	int odm_slice_width = h_active / odm_slice_count;
+	int odm_slice_width;
 	struct spl_rect odm_rec;
 
-	if (spl_in->basic_out.use_two_pixels_per_container && (odm_slice_width % 2))
-		odm_slice_width++;
-
-	odm_rec.x = odm_slice_width * odm_slice_idx;
-	odm_rec.width = is_last_odm_slice ?
-			/* last slice width is the reminder of h_active */
-			h_active - odm_slice_width * (odm_slice_count - 1) :
-			/* odm slice width is the floor of h_active / count */
-			odm_slice_width;
-	odm_rec.y = 0;
-	odm_rec.height = v_active;
+	if (spl_in->basic_out.odm_combine_factor > 0) {
+		odm_slice_width = h_active / odm_slice_count;
+		/*
+		 * deprecated, caller must pass in odm slice rect i.e OPP input
+		 * rect in timing active for the new interface.
+		 */
+		if (spl_in->basic_out.use_two_pixels_per_container && (odm_slice_width % 2))
+			odm_slice_width++;
+
+		odm_rec.x = odm_slice_width * odm_slice_idx;
+		odm_rec.width = is_last_odm_slice ?
+				/* last slice width is the reminder of h_active */
+				h_active - odm_slice_width * (odm_slice_count - 1) :
+				/* odm slice width is the floor of h_active / count */
+				odm_slice_width;
+		odm_rec.y = 0;
+		odm_rec.height = v_active;
+
+		return odm_rec;
+	}
 
-	return odm_rec;
+	return spl_in->basic_out.odm_slice_rect;
 }
 
 static void spl_calculate_recout(struct spl_in *spl_in, struct spl_out *spl_out)
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 49c866a558f6..201201d3f55b 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -436,7 +436,8 @@ struct basic_out {
 	struct spl_size output_size; // Output Size
 	struct spl_rect dst_rect;	// Destination Rect
 	struct spl_rect src_rect;	// Source rect
-	int odm_combine_factor;	// ODM Combine Factor determine by get_odm_splits
+	int odm_combine_factor;	// deprecated
+	struct spl_rect odm_slice_rect; // OPP input rect in timing active
 	enum spl_view_3d view_format;	// TODO: View format Check if it is chroma subsampling
 	bool always_scale;	// Is always scale enabled? Required for getting SCL_MODE
 	int max_downscale_src_width; // Required to get optimal no of taps
-- 
2.34.1

