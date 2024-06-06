Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D22C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCFBA10EACD;
	Thu,  6 Jun 2024 21:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ef/LO3OR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF41410EACA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7KJXP/xtbPL+Z5X3LfoivsvTi2hE8UDq7+dC9q30qa/daO0vtwJ0fn19zWkaI8TDpjp965Gu6YOznd+nF22ttlBu2pXMfq9DJT1ZbyINMEQbrIcLcoP4YZOEVDvqfHGhNdP6HbrneEaon9+BOTOnzgLAeVM18HjuS1Bk672YiXJ5ZThqKBY41FF3ZQflx+T0XhwfZwbqDUSryFzIPk5pjH/2JmTQx7ozDIHzxXvvwkXS1TGKqnJl6h1goDDvz4lnEAGd+yRNiCDQIR0ciyRjbpA0nhebjd3zGe50SfJtIv8cgObV1QLFvLE8yEC54W7qNQqtAkc8BworS+NMyyk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhwieTqQQkSY+rUh4k9d+8+zY5klkmYNm9LBwG+mQSw=;
 b=gpZS1/P4uY37FO0KhVSci67td11w2xZNHm5dQmJae9qUV4AGgyU92i+cJTTwlAd7m/+uEo1/QnyWzTPxVAZ7k+AfjcNsHbpnYcCMvt26af4akV8/f5ZoHfQsvAW4Y/gRWIJxsepWOqsxNwuVEbYweHOPRF1o0wT9Ma//5w5qderf5QpqK9Ywudv3HmLAhgvDl+1NQHDsrcOvWzxN3Wj7bSfC6F3ejRhSC5f1N/ua+j9EePUPK7Cac1088dMJd8pj3OXHupApbtrrGJ94iePtOB+efzC92DPbpb38hZQjoz3e5k8jthvRe9S+FZLlRgJ6TevWFCEApR48Rk7Gn7uKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhwieTqQQkSY+rUh4k9d+8+zY5klkmYNm9LBwG+mQSw=;
 b=Ef/LO3ORObD7/J+VnkOYi/6HA5vRNAWe1fIWuSW1O19HXpt2VZr4kXiSHTTvVwFC2wQYjJ29MXRc1O90ma6B8hIhO2QyXPl3y+svcB49rZaxKAyazgXNzz5oOTODsNqRQ6ya8ARvVqeTxxt5oeH92hINhdS08AKndMHaI/iOf6k=
Received: from MN2PR15CA0054.namprd15.prod.outlook.com (2603:10b6:208:237::23)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 21:56:59 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::55) by MN2PR15CA0054.outlook.office365.com
 (2603:10b6:208:237::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.19 via Frontend
 Transport; Thu, 6 Jun 2024 21:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:56:59 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:56:58 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 07/67] drm/amd/display: add odm_slice_rect parameter in spl_in
Date: Thu, 6 Jun 2024 17:55:32 -0400
Message-ID: <20240606215632.4061204-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e485189-aa9e-41c3-0ef6-08dc8673972c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jQMfEQo6dvsfFy93/KI0Mlp/sTab9XuPI3rYLNSkKaQrtKHK3YcLfMr7GMGT?=
 =?us-ascii?Q?Zq4l/h+ValCZwDrYZxOGXPas7WDQ0jwi7xcjm534SkhEDQnhPAn1sDI1/1rV?=
 =?us-ascii?Q?Dekg5x/jBceczUJoefTNou4qBSrbPGsOJp/tnm6zryEGZW6M2elcZxuK6N+W?=
 =?us-ascii?Q?YNYDyXAStn7Kp0h4ZtRelLhDPzo3rsoGSNQbH8rQhdC6blHqo0dVod4q7lU0?=
 =?us-ascii?Q?BERMZEv0wB15Gje7aRnCBVdNnMsGgEpvPUSmE/ycubg41pv0gBrcqBtMpEu+?=
 =?us-ascii?Q?L2mK4JS62s5lWGrd2Rcp6s4VcO4etKObVWwMXkKWe6Yi7c/2dF6dBbt5zhNE?=
 =?us-ascii?Q?eZhpZmip+Xm2FzK7+zQYX74PGzj2yLIk8m8I7Cbwz/OYhba4B6fMjW/WhBdH?=
 =?us-ascii?Q?trPU6ew5/DM0AHzSbGTm7MXBjhWGe+LwXIeUVgAOqooaAvqfujZyYK9R1DDo?=
 =?us-ascii?Q?yn6xSbbhmdw+QwguS9Lni8WOvHoBwErwKgzu9BQpMDYcscEnvC4YPQsoflrQ?=
 =?us-ascii?Q?JA2EURwaHx6CVp8RmD9RUsczCUuVz3dH2IxN9k8KPXzNOZoc+ZF3+W1oFSbR?=
 =?us-ascii?Q?D61sWQZb0EOvQA1R9w4LM9tKtERCIZD0DVhI4/oWC8UknAKhlpK6gyKhv9GN?=
 =?us-ascii?Q?0qswEyee9nhoE8gRdFcuhHJAQ/SBO7J0d1Nl5kUClmyRX/eGV4T4u9Ec5jFN?=
 =?us-ascii?Q?q7QUxT6989akd23yXi+0pew6ZrfQ7X3jWikOuC3TJFA9okZSGcXHny//K63j?=
 =?us-ascii?Q?e6G3e+rUy/br9I+onWFQG15jifVMmvUA4MIV6Ss0DLkGwuIdGBoQJpCF+Jbf?=
 =?us-ascii?Q?wDdMzFT6bqnklZJDjLPmNwgMP/ujpnc8fzVfQ+zMKdeNnjh0j/k21AZ4b74R?=
 =?us-ascii?Q?9t+Bgf1fBnEaiwn7I9kZssbqfcRy0N4YYgmPwBGIcr6J5dquvYynI9czyExz?=
 =?us-ascii?Q?FAwNvaPUcMTrqWgNz9zWxzbfcTHoQbmx7lGN/gx1bqNOU5RxnmJZS1Ip0Det?=
 =?us-ascii?Q?88eBf82S+QfAjyY/u5D7czpzhPt1qOxC5kwEOEJDdq9z9ct9fm7MfCW0469e?=
 =?us-ascii?Q?4lyULwMld1FQ5RkLkKBYQyL16Rn70YaSXsnCY8drRKmwJit6ltWESLSjxsso?=
 =?us-ascii?Q?sWzj/wA3siFt+xOl/2umYHIeyFIDbG69DuQiWhTUkB1XpfRunw8hJEr08sFK?=
 =?us-ascii?Q?M9/4i0SymS27YQJroR1bolDa8TuahtH7/rXzfMSAcZEBvEbk2TOsTrRrbiWL?=
 =?us-ascii?Q?WPsKgQ0Ofk+VWJvlvQ1MVi47kXJfJRue6WM1zUwRewpUPS0qSUxnQ5E1uljL?=
 =?us-ascii?Q?q55N2YpLHXlb/3yKmaZQ6w7xIWLwybEPeo8poHGggyA9B0VN4K+pzuhHJhTB?=
 =?us-ascii?Q?WEK9rgSsfCj6CR7RNz+POAZMlKtv+zDkLMXQpNNEm8B6SBYOaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:56:59.4750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e485189-aa9e-41c3-0ef6-08dc8673972c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
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

