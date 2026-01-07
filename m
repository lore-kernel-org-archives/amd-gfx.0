Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493A3CFD65B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC57710E632;
	Wed,  7 Jan 2026 15:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEhSCoQK";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30EAE10E628
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6yxH9yGk9q3Yea33mm8f+fytauy42Ssfh9PTndtw7TjF4b0iVI4kDTz09c6+gWikaZbZwDLSCIl+oM7w93CINI+FNtQIsNEJqUuYefH0sn3IgImcKVFLI2H9DoEq4GhU7agiqEss5jYfvZxKq1ApnxP/LNw6GY7mvfb+ZyiGW6MPHfyX8hHj5h8NBz9TFFCgJu1pHoi6urZdMmAmSU14SeAYK78SFczHWnMuHlx6yme1tSy2PtUBp1hKqI/7ypd+5tK7QGmdBc6C5DkyT1eZb0kbL1xfP/O2byXE0Lgct8kCWaGyb/0AlsRTkM84xk6Eq8qyGska8PhacSXzIeQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDcPpDsIWONqjT8v8qY/3ml7Tp+f+QnqVuXh94wpIRU=;
 b=Cy8dEt2FRVoWun+OuBj9h1pLuQ7iu9+PB+pxMeoQTMxs0AHqWrp4UbadCjafan8m3FpwtqdKLA7OTNM7fLAHPxJwC/R5t3tC3Wb0ZIBqiT7kb6hJKoKMC1VBFAUxnj0V6K9gM/v5V7uotVeYrPU8H0X4dyOpE0vXw7anIFAQdQ0/z1krOl2GR1gfvP/t0a5FgMlRs41FUkbagt0MbeOHSF0XfZBJppnzwyXLN/Bs/2aoxVpEAvUKREcMy6bq2MBgnvxyNkB4GIzPgRvd4p5rWeuVYjJH3hEB+tv+Amck0VlX7MxFoWCXu/GTDzyX0Wfsg8vRrU07MaO2H0zjaebSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDcPpDsIWONqjT8v8qY/3ml7Tp+f+QnqVuXh94wpIRU=;
 b=mEhSCoQKLOkXdPph3whZqhzDhphWrdFC3HOwvmhKTKsGfT9Vg2JG5kiNQsjgzH5bXfwZtb+7cvueqpKj/ydJHyFrsVYS1FgvTJhK3S/nvtnjsI6kZhNyk2EriYWe00dnUaw+aHiPDLe8bOyMfPlasAbn9LKM9kiDRMRYEf/wqeQ=
Received: from BL1PR13CA0200.namprd13.prod.outlook.com (2603:10b6:208:2be::25)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 15:58:00 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::a0) by BL1PR13CA0200.outlook.office365.com
 (2603:10b6:208:2be::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 15:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Jan
 2026 09:57:59 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:59 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ausef Yousof <auyousof@amd.com>, "Ovidiu (Ovi) Bunea"
 <ovidiu.bunea@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 10/21] drm/amd/display: correct clip x assignment in cursor
 programming
Date: Wed, 7 Jan 2026 10:48:02 -0500
Message-ID: <20260107155421.1999951-11-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a46b0f-bda6-4e25-9a4f-08de4e05886f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ik/Hz10cQpcfh0V2sYzvHXfxeaMO6RYgC1/anDf1ev7WOxQriJS+pbHudE9c?=
 =?us-ascii?Q?QyH8tuxFY33+n621Arf1EsDoqzK59jnLufafe1d8OKm4EszgpYYmIHe+J8Rc?=
 =?us-ascii?Q?1XSLjks93WVRCH2FWnkLsFOViQFmoSDF4wgVG8EKF7FFbdEGji6lnteBggb2?=
 =?us-ascii?Q?tZfTMz59lUAKmOpmv8jQU93J04Izjc4tlk2RB3iI/rAwKS5Gcb/BBFVoNCdy?=
 =?us-ascii?Q?hbp4DZZqTNbDTN/O/j3d7MYfzOmzp8iz8Y9o5Zfo+L8YT0G0tNWeuq2kKXsZ?=
 =?us-ascii?Q?AY93Dc5UAkPgrV48IYvMbEi3O11gzkPnku1DIcjtAM4iHS37HxG4lUVmLXbL?=
 =?us-ascii?Q?BzyYVB8GCZ1dl1uXRmpT5JlWmdHyc4D6fvf2WVaHeEyIQKhxbHVzBKsvzv60?=
 =?us-ascii?Q?Z/KSTGyU1T5uTbj7nKGff32FZxR1HRohDFGgVAWWhNuAPMujWRLorxXpB58W?=
 =?us-ascii?Q?rZUS5d5LRwN9vuCxllRJ5nT9kJnqC9FwGX+R8T4sRFq2ZQ25UnpOlysuRDn+?=
 =?us-ascii?Q?FL/yVcYwMlW2oEz5jwY8OgDwak7MzSz1yXI81ZkkmmV8cT7Svgph20IVSF6K?=
 =?us-ascii?Q?YsiFOob/JbBZX22u4SmhMA4r6y+GKzxWmmCqKBfKHvb8gfr4yxMeByr4T8vK?=
 =?us-ascii?Q?rBeyaaqPHKL7Ls39Qo2IBjz5pppFaOrh3rhvrty9EOK4exYYsGj881ddJDhP?=
 =?us-ascii?Q?Sq13VolZ68H7ysIzVBtP+YjVX8fC37zGHv0ROTlA5RmA1BNKFM1x3t03eArK?=
 =?us-ascii?Q?j1wkwbM7WVqicymATNGK+HMuSeQJDEtu2qT/gsNkY1sw3d0P2jR/ht0ijZuf?=
 =?us-ascii?Q?WTdhENBcWtGBodNvObEwB4PLQv5G6gRQ2VWnQyL2iQT5qGgvy8DCElqI48fa?=
 =?us-ascii?Q?g34Vd2wKZXQjB/NAcl5g2+ZtFT5ViVDIuPa/lxHHfw6iP63L7GxjYOLNaQPr?=
 =?us-ascii?Q?D5pmD9mO/Sc08aS0D73qCaGJvAvPXJqmjSu4zITSB9PttscN4ECDHeWgjMX6?=
 =?us-ascii?Q?JqRfwQlI3V6zgBMAT+3MC2ZO9eDEdMTzjPoG8LfS06UTtGALQKALeQz4i3ck?=
 =?us-ascii?Q?VPe3+9aONU3AOcbXm+nsnxJX5DOTWlikcx6hJCL+pqROQO8P9ylDx4ztX62V?=
 =?us-ascii?Q?qnGLl6A8SPRjhPU+/gcUansn38OqAjFXoRcahN/T8BuTygEGvUTXgS3E4u7B?=
 =?us-ascii?Q?9oKVWsBApZtI3v5s7UZlkY5bpPg86OjbJe4kz4Dor7ouhmRHx4SH0cofqzFs?=
 =?us-ascii?Q?GwKsmgfdqMRHaOV7+WnFVfBLQfqS7qe7a9FNxneoSf2X97Ps+dlTUi6Tdj80?=
 =?us-ascii?Q?cGPj7YSsq97TW6L3AzdJQvx20FqUwlOEcEYboeEpRDkWyfUvyCkN1wwWxwd2?=
 =?us-ascii?Q?AGnPR91Vib+NqfxTyIaFMiuwqfmYnrFi8ViITx+B7GwZE76nJF/1ztxhF1kK?=
 =?us-ascii?Q?Jy/9Lnpwcg5omvQK3SLpXGiE8Na1J9tJ8TN7HEaPnESkfoLA/To3uspfSKGB?=
 =?us-ascii?Q?FKmxEQ5WDQnDH7wCtkGn9tW9drrbz9mE7Uw1F/bQpitgL194e4SfBmY8lQCY?=
 =?us-ascii?Q?Y7aAv4lGu+bbM0kKmZw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:00.3571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a46b0f-bda6-4e25-9a4f-08de4e05886f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
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

From: Ausef Yousof <auyousof@amd.com>

[why&how]
primary planes for external displays getting incorrect clip
values, detect such a scenario and pass correct parameters

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ausef Yousof <auyousof@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h            | 6 ++++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 667852517246..cfa569a7bff1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -491,6 +491,12 @@ struct dc_cursor_position {
 	 * for each plane.
 	 */
 	bool translate_by_source;
+
+	/**
+	 * @use_viewport_for_clip: Use viewport position for clip_x calculation
+	 * instead of clip_rect. Required to protect against clip being overwritten
+	 */
+	bool use_viewport_for_clip;
 };
 
 struct dc_cursor_mi_param {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index fa62e40a9858..8a23763ca98e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3666,7 +3666,11 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	int y_plane = pipe_ctx->plane_state->dst_rect.y;
 	int x_pos = pos_cpy.x;
 	int y_pos = pos_cpy.y;
-	int clip_x = pipe_ctx->plane_state->clip_rect.x;
+	bool is_primary_plane = (pipe_ctx->plane_state->layer_index == 0);
+
+	int clip_x = (pos_cpy.use_viewport_for_clip && is_primary_plane &&
+		!odm_combine_on && !pipe_split_on && param.viewport.x != 0)
+		? param.viewport.x : pipe_ctx->plane_state->clip_rect.x;
 	int clip_width = pipe_ctx->plane_state->clip_rect.width;
 
 	if ((pipe_ctx->top_pipe != NULL) || (pipe_ctx->bottom_pipe != NULL)) {
-- 
2.52.0

