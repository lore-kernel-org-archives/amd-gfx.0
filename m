Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66375C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF2410E8C6;
	Wed, 10 Jul 2024 19:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q6crOJsf";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08CA10E8C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAOLUACAKIKuFamZ/6OPrV4Jo0cypIgl2DeMr/fNAFlvT+l9rxqEBssa84rvR7vgEenrtAoy+PAlpq+RgW/i1/spunb4ZqDI+LH4/u5PJodp+4O2sqn5lygu60Tdr1/5VHPSW8DiVSs6eY4unl33wyrfGAhII/8JBnke9XT2oyzBBQWqEBFEqDC2uBail4jNXXKXwIarIcP+Wb2oEZVYM8cat1KIU2K9yiVPjVzsebCZG/JgpJZQmG+xh97rxkjFNv87a4qLgLy7o5imlMXLZ737lS4FHNaiFg4hNTS5YG4R/7rGoQHpKEXF93v4u3zcIfsjG53RZJKGGQJqiHTxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRJzOdUi7sPaHGbsPD4onUAyTfxQvhbmlcQMyAm0tRk=;
 b=h6UApVjtxhaM3pSbbRaqGHAyb5Ndjlq3kuDTGUHQh3ZoVDdGsSRKf7fpJQWbTY9xMxHKWda5GVCwKaGZGqAPf/mWRxhrl5Hv2DW7JsrdB0KV41Jin4UkPrAqGFiMme0YBPVWw29XbkLYyIY+GYtDXxh9S/O8qBG/jc69jzljNB+CM62C1CxbwxhPfU68Ie6S5uceC+gk9l88QwwKKwVbrQY3xzVxR9OOXLZUmMf3fjMDKILAPePy1tKnACAYeHNOZMVy1Ua8BVpdVSNbs9kVvHsKj/xQNW4P9tdh31kWxk0SEhP6ii0y762pkp5kzSCoOMcjcYsftkxiRr1991iZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRJzOdUi7sPaHGbsPD4onUAyTfxQvhbmlcQMyAm0tRk=;
 b=Q6crOJsfW+S12qxF0BeekFUGmn6hfoK6l9xt4i7HcUd69YRWXhMrdNEy/1MsAxKeFpUFCn3eQbOU4FgaRMKHHs9IZWgkWIMXUpTNzKwe/kTyJQgtWIESHBu1p67VLs1gaNipNACUoAdV44rSw1IhPlxGqqdi4BCWcfP03qMHhTU=
Received: from MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:40:21 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::43) by MN2PR06CA0008.outlook.office365.com
 (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:17 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:17 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sung Joon Kim <sungjoon.kim@amd.com>, Gabe Teeger
 <gabe.teeger@amd.com>
Subject: [PATCH 42/50] drm/amd/display: Check stream pointer is initialized
 before accessing
Date: Wed, 10 Jul 2024 15:36:59 -0400
Message-ID: <20240710193707.43754-43-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 090b4a60-58a0-4cf4-4d3f-08dca1182283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DkTY2AUtRxXRvWP9Gx9Fwden1eIYaPv83I3BRzQDwVfPYg5gkIxkVEZc+7Wa?=
 =?us-ascii?Q?JR0NH0s1qM92TitfqittFeB4GDqRrDGcf/gPz8XSXYWQmBy7VGa0ZZd/7GWr?=
 =?us-ascii?Q?1bAEV0qhk22qA/EtY0zYYY1M+UHSaLdX3y8nN49nmwTTVLNxDqvUMXzhJcxf?=
 =?us-ascii?Q?W7frqeAER/fGpVyQKyHvQPl1IaIFqxKXr6pjnVRS7fYbVAkFq4VGixelRL4/?=
 =?us-ascii?Q?NmYyKQZuOWjZdssZ5Fs+XaHltzsY0sgYy0imlwT5Ux/DFQKGfa7zxJXh1RhY?=
 =?us-ascii?Q?756370whQGjgbuObNIsMRkIKt9G1bsko6fHFZV6TY8jp4dSW71utqNP0581/?=
 =?us-ascii?Q?o1wjMAGhcasfC29TILxDZHT9M7OGUX095kegUvFMyl2s4MCQ0nfshOEta4eN?=
 =?us-ascii?Q?Hd+LJEXrmTI8vGwyURglnbPn2knN7YzrXZraVMurFCwNDSaFjFZdeLgaRCr7?=
 =?us-ascii?Q?T67BZTx01HPwbS2jr5CwzwfqxqOvChfsSA7RCDDZ4vanFKiMQRhgVA+Qak5P?=
 =?us-ascii?Q?9DZbLtSQ8qPZrQCllComlfhY3y6Kn67X+1aiN3hrURanuhEFQgVYHKBvMdo/?=
 =?us-ascii?Q?ahiy5cUYb3+cPxrX3+h6UyQFWNFwvky6WkbLtQDLxQQwOia6PfteKSYOaBZI?=
 =?us-ascii?Q?d1jZQoeOhDUDyG2RqwTxNcPfas8a1AwkuGYUInvno6XdeQMRy3vuxEckPx1q?=
 =?us-ascii?Q?OIAmEn3xhamfWdF3qbY2FOoPbAP4qcs9gTkfYENeXBP6oHwqDyb5d4l+VA+i?=
 =?us-ascii?Q?YkCrWCgy6oG3orZB1LbmLCQX6D1B2Apq+WFFvVB+3UPNBV7z8H1FOtY8UWVD?=
 =?us-ascii?Q?G4MjUyc9+XgXujp5aY2ZuQkHxyqIk2OENXLrfjiSoquAAHHvHnKGK3i2hz36?=
 =?us-ascii?Q?3DrfE613MMf9lXtnPxro2wldw5ppqfV0Tj/NKLmwm8Du/PcYFjjtTFeTQQfY?=
 =?us-ascii?Q?SNi6djpQE3bYdH9WZLPa1SeEzk8T803C6/nwvf/RX2DU7VMrj/P6cjZ6M4Bd?=
 =?us-ascii?Q?K+T0B9EHZJ/REkZFe/8aB03SFlCV61CDmSzdChODthbb5Alo/VH5fcKzIJtO?=
 =?us-ascii?Q?Q8rLaacA3YIE1b3Jza006O7LpXLIlCmA4XrbjtdrctcHk2MVz0FGALXEypoD?=
 =?us-ascii?Q?5yk/CQzc4i0IvbJeJ2FHFacjSWn/OtJL7iMZqV+SAhT+TBz9aBFXp8X7+jWb?=
 =?us-ascii?Q?kUkzbtv6NPdtAjAUq2ccQ1alnxO0LU1yEq/VfKoxSfSZOroUsrjCp+XTrPuv?=
 =?us-ascii?Q?btR+lOxkFX8UDVxCxttPZxO9QUPRC246b8rn1rI2sKUnoTQDy+9CTIQP2ynu?=
 =?us-ascii?Q?+gDYXhc9gVZs8fcOo0VqypiicYlvtYJburrf1Zp7FLceImNKwVIGRqgYtYrb?=
 =?us-ascii?Q?NUJsVRlfc8/gRksD9YqmU00FrO2NaNPactgvJa8mQwJy5+c38CSlz5UCSXMC?=
 =?us-ascii?Q?48zoDvFk4fkIacDDUq7thPklOVUmFlji?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:20.8053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090b4a60-58a0-4cf4-4d3f-08dca1182283
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why & how]
We calculate static screen wait frames based
on the current timing info in the active stream.
If stream is not initialized, then we should skip
the calculation and go with the default values.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index ddf0807db627..ac1e3331a77c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1461,10 +1461,9 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 
 	for (i = 0; i < num_pipes; i++) {
 		if ((pipe_ctx[i]->stream_res.tg != NULL) && pipe_ctx[i]->stream_res.tg->funcs) {
-			struct dc_crtc_timing *timing = &pipe_ctx[i]->stream->timing;
-			struct dc *dc = pipe_ctx[i]->stream->ctx->dc;
-
-			if (dc->debug.static_screen_wait_frames) {
+			if (pipe_ctx[i]->stream && pipe_ctx[i]->stream->ctx->dc->debug.static_screen_wait_frames) {
+				struct dc_crtc_timing *timing = &pipe_ctx[i]->stream->timing;
+				struct dc *dc = pipe_ctx[i]->stream->ctx->dc;
 				unsigned int frame_rate = timing->pix_clk_100hz / (timing->h_total * timing->v_total);
 
 				if (frame_rate >= 120 && dc->caps.ips_support &&
-- 
2.34.1

