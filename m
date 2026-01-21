Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF74C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2ECF10E892;
	Wed, 21 Jan 2026 22:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xoKrJTzk";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F35810E892
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIIPGhz3HGPe0uBdVsyEdPfJf5ujxkUVWR7YOhGMcWN6qwDPwlXxCK0WxMDm+55IguTd4+QOacVMO7rMPErEg/6L1Yxm5CeSlxY+hB7OH9iwjBTCZ3ZEmZ3bV42Pim4cDT5GMAU7FfUR+VPiIaVY0phQOnBC2oVVLCpy/l7eqax8PEuJMOh5P5ilNXcozq7GBZdlRxotk9cXJ6JWGko186trGY1q1B+aWVxnRXfGPkbclUOSuQq52OGbIH0IvCKVfC8kM5Al0UB7ZnHz40SQuo7bzg9SjDMeh23cvTklPfOAL7wfhkbaV6QYjCuq20zomcsyvrciscy2OGx3EmWcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziqfSomiVC37/2pxKocoK5vPtSCxdgKe4aqUfO9c63w=;
 b=HQMYo02gTvwpPkEyZvxLrN32sWIb5BLUyiW5lQk6mjGccYJohBni5ExfZwVrgRt4SmuVnsmEAk6QjGTTRR8GHwgPZm+A/zxFgaANDyMFlzBvMLRciW+zTzJbBugQlYH8gdrhy02UV0Pkc0BkeAVwgL6pf4FQ2qRTUc7VXMzO32GDiz5Z3JCxWPMk1cPortW/yXF7LlzKtwDxWd4Z6EulBpEnX43peRB75FrH/dvCIRVtcMw5cYctVDfiy6l2gPf4Zm0eEO7wOYhyhDvwNx9kpoosI9mEA3we+nnKh4B2cLnLaWdwjYviIrqL5rJv2PDlb/scLZe/GxBPM0kfHQ6wdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziqfSomiVC37/2pxKocoK5vPtSCxdgKe4aqUfO9c63w=;
 b=xoKrJTzkobZjYqXHsmInViIXNfYdV8UNYX8Iv3vNCviMubhHJrAoYEuv0q1ZmGQhwCPnRIqTJ7bjpd3KuKYfwzAKncyJNC524DqKhHIceqbpc10xjL6sWXaP4O/0KjYiqkWvYpFZTx1sikGD7GuoILbqv76hpHVfOAdmQGB5uUE=
Received: from SN7PR04CA0071.namprd04.prod.outlook.com (2603:10b6:806:121::16)
 by PH0PR12MB999087.namprd12.prod.outlook.com (2603:10b6:510:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 22:33:10 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::5d) by SN7PR04CA0071.outlook.office365.com
 (2603:10b6:806:121::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:02 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:33:01 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, "Ovidiu (Ovi)
 Bunea" <ovidiu.bunea@amd.com>
Subject: [PATCH 06/13] drm/amd/display: add setup_stereo for dcn4x or later
Date: Wed, 21 Jan 2026 17:31:42 -0500
Message-ID: <20260121223247.186241-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|PH0PR12MB999087:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcd5723-b858-4fdd-7e5d-08de593d0e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ov6BGUbslzXlwyZu0iJOHFgpIWt8Bg6JMyQ4FgJjnscmxQIZqZKqadnKb0h/?=
 =?us-ascii?Q?3WI+6D5oOAFn4Uxe3B66JfzcypLOWXhYfiQ0tMi9l7Z3jW+mUmLQYyCw02a2?=
 =?us-ascii?Q?nJcW3yiehh7b42Y8LHGHItG6i0ckdPN5WD7Qvf/PooVKu95fUzW+WYyOS3D3?=
 =?us-ascii?Q?mRdsl8xJ0Wn2M2KzYEVU8b4+Iaf72R1RCqCv3Pk2aoCm76X1BAcKPDzoKRxS?=
 =?us-ascii?Q?l3JzupjrZOeKlCAb11lfa1aUz86czHq8EGSaJ+Kb2x6eb/Rzpol5EX+VFC1g?=
 =?us-ascii?Q?m5rwt9XKQtjKwDW6lLP5h9JRtW8O5VPGvnPVKFRjCm1dSgSAZtuPP/QOwFp8?=
 =?us-ascii?Q?xVsJh1Aet7o7DyWmbW18zL8X7KDfGHsJ3uFcBOVkzfLHkHT82dbEpu9uN/Ff?=
 =?us-ascii?Q?8s9blT3UL2DwIO/mgORa6TqnlTKeK4IbpWr2AF7dbTmNSmXpQ6eTYCW0LDpw?=
 =?us-ascii?Q?OP9MCWRaD5hf3VJagxE59Qr19sxRKaJm74MuLhsw24u5Ou7b/murAxTJTO9v?=
 =?us-ascii?Q?sZ3Wv++kkI2ZKvpDB7sfC6IFkJYRJr6UVzi4LguRLG7HcvqnOZFQsIsnbww2?=
 =?us-ascii?Q?0mroYvytMlMUcvPUTJRjz3y0pyKdz5n36f8usM10fTtLiNojEQG5lCiQvnHq?=
 =?us-ascii?Q?sAJMdNLRQhPh+EcvVyEgg2NqtQCF6Mb8W8m+VltF/1dzhBGxOt14cklmUA5h?=
 =?us-ascii?Q?PuuSV5jjVk8AqT0pC4xdLIKqefWcY6gjp5cA3fzbnGCACCVnz2LYY5WDqBBw?=
 =?us-ascii?Q?jXVTBlMny4OS92ATz+0wGIdEA7jdOyokgmvg/0q4YFqw4En6/GYdioK5M0Ky?=
 =?us-ascii?Q?90OUJVCxwEr2Prj8W3+0Nm7kmR+tCij8amoPPskdI2k3q5U8ya7XyGsStfk4?=
 =?us-ascii?Q?NBr7yL9qjLDB5YTX8iUBTmwwYRE+uARBHfpkrBuCg3kzKkZ960YALTujFmMp?=
 =?us-ascii?Q?lLZcy0rFcys/V3KhqgG++fPezyqpzAH4C1KhMoEYLdjM1/ypb70sWNguEDeg?=
 =?us-ascii?Q?ugZpGN4R0x/BLnnNLnlWojJLEEGMffnFNVnufwr7AJJjzw0NLUI0RmFyhlZB?=
 =?us-ascii?Q?wHwLajESR9TCzeCXhGdxcHO6byuU3gLE878YFX/fskjoPFk/Z5BSxAxxPuLa?=
 =?us-ascii?Q?alETovRPr2JFdlUYi/pH0/qKSAGedAzkz/EULPeuppdqf2QHikziDUcD91SC?=
 =?us-ascii?Q?ULcKfOdvvJ6c4Zz/+x5/sr4844lU/FtzPnGhN7/5QjsYq3eGdgAVlqxb/52Z?=
 =?us-ascii?Q?WCKIAarWV6okW+Kgabeq4CeSsxcgAiuBLBs0unDBdM2R8hV8LPWihV8Flu/i?=
 =?us-ascii?Q?0edQDFy2n+Y2TYykYaDmD+FslPaf3gq8qNanbXGE66j5wB4+zd6BdYwtdoXV?=
 =?us-ascii?Q?cms2yVOJysQKZjG5CpbS01oz9UZvHFt3+3hTNw7Gd5qxbV36J26zW4V5Egjo?=
 =?us-ascii?Q?rpbYSeqq8HpM7xGM61PF0NzXvTkaM0Oub/G9x4eoAMpq9QLMtj1lBEEhxLh+?=
 =?us-ascii?Q?q9PZmjzg6h93/MvtDiNJK9Wg8zfakE29AGzAZP7QxUNIzIkRPyV2vW94CcVW?=
 =?us-ascii?Q?umkaXNgTlie6a9gp99HcVvlE3HC4o2V6/W7wVivvTeY5A0vS8dFNtnHI7UaA?=
 =?us-ascii?Q?cnJNosbHjSdTZrc0FhR4l+emCTAQKgbgcOboJy98HlOtg4xgRtMn4DXCIdNg?=
 =?us-ascii?Q?a6Rvgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:09.7911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcd5723-b858-4fdd-7e5d-08de593d0e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999087
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
stereo_sync pin is removed, but we still support display stereo

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 8a23763ca98e..73f469ce7cdd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3474,7 +3474,7 @@ void dcn10_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 					triggers, params->num_frames);
 }
 
-static void dcn10_config_stereo_parameters(
+void dcn10_config_stereo_parameters(
 		struct dc_stream_state *stream, struct crtc_stereo_flags *flags)
 {
 	enum view_3d_format view_format = stream->view_format;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 57d30ea225f2..476095c5dd0c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -217,5 +217,7 @@ void dcn10_update_visual_confirm_color(
 void dcn10_reset_surface_dcc_and_tiling(struct pipe_ctx *pipe_ctx,
 					struct dc_plane_state *plane_state,
 					bool clear_tiling);
+void dcn10_config_stereo_parameters(
+		struct dc_stream_state *stream, struct crtc_stereo_flags *flags);
 
 #endif /* __DC_HWSS_DCN10_H__ */
-- 
2.52.0

