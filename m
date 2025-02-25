Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DF2C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0291710E548;
	Tue, 25 Feb 2025 06:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVvGbTI2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF95510E548
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+MiGvXGxe3d7J90DwpuIHESe3apaGIE6oquuUsoaAgkcsL021jXKfjO7sbSFiVteiyhuFGHyEpdB31/5eiC61TI7ylsK1M3EEB5S1737q8czNlrHTCyy/8WbMH2Vowv47LVQNg8Q3CokucZrLPgGrjZjLj6qY4pYdoD+29xbgcVmE2PzuJbnBeS5VLKL+HlGHFVweSYc/WiYB/FZBBnOx9B5ozvNf1kZVEcgJwXvz35Ed8HOU5SxWXOJaqherNeX39GGSnoEmnjMFX5d7OtEct5bACIgYnUI3xP27SuIEWk+RMFXbJHaq2c2Yz4oeshaV/W/VaS3x0zrYn0pVoKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy+MrYJo1In6uAJIvhZ1/TJ+bK4Bwg4ZXEBzMGB+QsE=;
 b=iby8/MxY6ujoKWs2KRqNhcd+5e2nFCqLpkR7LH6fzed3jVvCdsV2jiYjVB9p3OXuA40z899oR/vle9H57NkGLg5Vz0w5UuX8GzOlQh9QRjLHVX0jfzvEllxLbKTWfBha3zFcUvnimGgPaUFQcTdSHGu4uRkgdkjVRh9ULbiZOGZwNnD+IZwTMjgoSV3A3ojCTrrur9OczuQaiD7MzZ3GMQwg/y6hDfQDJSoSpUOJ3f5obFyDqaA0Qz7JzOxex0uSlzVuqKf92RBk6kvcNn+OtmVZHg0HH7dGT9iu5JRvCuE2jGylqQ0EhwwkuylBNgpnPL8Jg865cxNmdcJk+ojHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy+MrYJo1In6uAJIvhZ1/TJ+bK4Bwg4ZXEBzMGB+QsE=;
 b=zVvGbTI2R6JhVJJ52x0HWkAtvHObnokmObIyXK6UxEhhnT0wJimsKhJ0shA/4Tc1XW3mqTyuZVyV7KoBQLRs3rx4BhL8NybnWr+05tdfPI/edAbw4To7JhoFChDigqbnqzxVFb5hy2mDVdD+g0p/05sFI6QMZA5S42gmNDOJl5Q=
Received: from BN9PR03CA0986.namprd03.prod.outlook.com (2603:10b6:408:109::31)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:36:35 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::1) by BN9PR03CA0986.outlook.office365.com
 (2603:10b6:408:109::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:36:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:36:34 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:36:24 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aric Cyr <Aric.Cyr@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 01/27] drm/amd/display: Request HW cursor on DCN3.2 with SubVP
Date: Tue, 25 Feb 2025 14:35:44 +0800
Message-ID: <20250225063610.631461-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c17137-54c3-42cf-b5e6-08dd5566bfbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wfXrWibJab1tMG+q7j0W3uvuS/1bOv0rB8zH0tSCvb4M+fzL8BNh5TIcPh+A?=
 =?us-ascii?Q?vnl+TsFkKj+TSgwom5wLsZLQn5gM0gK9dSreQZC2ztp6b9Bi0QpAL5h5sT25?=
 =?us-ascii?Q?0Gx0sZGA4gKyRkI6NkHcYmKN+pKhv3oyGi3Hooz+OPzKaH7N/JheGPcfW8em?=
 =?us-ascii?Q?PhqPht7FQOxkn6roEvfJlzz/X8hoMtmJN/XovTbWukDqzTJgF/BNSMKruZEx?=
 =?us-ascii?Q?ckloIHPjUbzBXnSVGrYZZ+Eavj2m0ni+LwQSZ2CNfNP9I8rS35hYHlW2avNS?=
 =?us-ascii?Q?4nK7D9HcUU70/b//hCdpxDAaOT5AGcxj0fgqtYo7EL9Wn7SoPAB0aPFp/TGg?=
 =?us-ascii?Q?Wp5xhHPgo0DPnd441Kb5xpPpr36FFFJS9MZySBm1XwIX2ga+GN4iPlRKQ+/C?=
 =?us-ascii?Q?IPnvFAoI/BrWXwYPvO0OaLppIz3114i6UBUc5WwJJmOYidHPR9MQjE6EvPQ9?=
 =?us-ascii?Q?kVycR+V8MA/+ooFO1Rjq9TW5WrRURIGh8JbfvcK8Iuy+GB6gPwKsBSWtrSJe?=
 =?us-ascii?Q?Tv/vlWn6XWcQpCepAUogCfsNReQjnhwuW87+uBcSesNd02NFHE7BUJKSsUw0?=
 =?us-ascii?Q?E9WUPlCsdvMi1aqlHsvqfmojr1peHUr8wUnT67Dd2cU7Zipag5k7VLcd2JVn?=
 =?us-ascii?Q?V7wge3inTrSppgLlBkHiz1ZlkUmOjb6+srvEnz0SjfB3IE93XIJzttBFa3CW?=
 =?us-ascii?Q?vW95d6OpIwNmzF7Pj9CVeCu2xh+vHeWNw+TvGN3wqMINur7eD9YiQwuYZC5S?=
 =?us-ascii?Q?22jSVhGK8cYHSJelYkMqNxbw+bBIU36v040FzqnSW8D6PdndTd2nKI85R6i6?=
 =?us-ascii?Q?Nc9mQB6N0z2mz9ZQ/e6O+wFntP2l5mAN79qF8ie6SXGUFlxcn7gmHaf8198L?=
 =?us-ascii?Q?Ova2M3+3gcVDKm3Q75OPx7iXyCuP0t+Z+jQ1YZJcO60HmXbvgVba55H+n8E4?=
 =?us-ascii?Q?E/55o+v/xd3T7kNakmNvmyXCzuaRxxSecHTDY6nWW8TlSPM6Wi9X65X6k+/V?=
 =?us-ascii?Q?Jo0ZpibkxT4ijI3QX70z6JnXhxkVTJvNTf7Ynwunf/Jqh4DTzaGjhobQq/l2?=
 =?us-ascii?Q?PsNCyPDj6ol20G+vLVgk+vzKMZKGGU8OjQj/UUSFS+SbJ2FgA/v3CCF8Co6r?=
 =?us-ascii?Q?H6+2JnZzceFlS2A1U8xW0A8unsskSpJOA2+g9eUxxc4JNiPE7LQ2b7vfmuxP?=
 =?us-ascii?Q?x1Qwf6TJfNf18GB3vLkfceSX1QUMcokdbyQxOyKU/E7n1QlwMNbJHTzyZq6A?=
 =?us-ascii?Q?yBRBQ6ZsGkqxmwx68NXuoDg+zqF8KhNqtAKPBju4TxPj4fYvriTb6PXO/6rM?=
 =?us-ascii?Q?Nz6PGC7K3tQc7pJjMBSrH1cIbvUoQ+65DZfxDpCxDbBXhWcHu1KAiVHg/+gz?=
 =?us-ascii?Q?WfSsbk6veTG7VUU+eZLup36v+6MCRb4/mNMZsFJ7Ceufwn4HNIZAgDQcmUu+?=
 =?us-ascii?Q?5gYRHjsfWudgU115qrI0Wzil+Qcvi8nU5wQJJ3jv+4sLNYAhsGD9L8w0/Rp2?=
 =?us-ascii?Q?3GUMV4VMEH4avgk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:36:34.8047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c17137-54c3-42cf-b5e6-08dd5566bfbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
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

From: Aric Cyr <Aric.Cyr@amd.com>

[why]
When SubVP is active the HW cursor size is limited to 64x64, and
anything larger will force composition which is bad for gaming on
DCN3.2 if the game uses a larger cursor.

[how]
If HW cursor is requested, typically by a fullscreen game, do not
enable SubVP so that up to 256x256 cursor sizes are available for
DCN3.2.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c             | 3 ++-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 05ad7a9af4ff..a99ce7c86781 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4937,7 +4937,8 @@ static bool full_update_required(struct dc *dc,
 			stream_update->lut3d_func ||
 			stream_update->pending_test_pattern ||
 			stream_update->crtc_timing_adjust ||
-			stream_update->scaler_sharpener_update))
+			stream_update->scaler_sharpener_update ||
+			stream_update->hw_cursor_req))
 		return true;
 
 	if (stream) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 6f490d8d7038..56dda686e299 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -626,6 +626,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe && !dcn32_is_center_timing(pipe) &&
+				!pipe->stream->hw_cursor_req &&
 				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
-- 
2.37.3

