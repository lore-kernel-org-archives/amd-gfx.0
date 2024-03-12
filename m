Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896F9C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D3F10EF5D;
	Tue, 12 Mar 2024 09:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y9h8XZID";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473BC10F30A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICm2jQ1ivqNhN6uKXRkWSQz+LRVt4DGMt83h8CJR7E9xIPo+AO6qtVfpVhV0mx9rvRufSUUNt84kI7UzKWrS9/kAkXkqv1HC5hiNsMAXrtCYgz7t0jEyvBJe0L0cpk2POXli14Ld8kQKtadXZ+dBNWSlWusTM7ypduvxEYN3492DYCSQoobl2fsmMYcw2UUHNcToMFLadfg2xszstu1tKcf6T7lDXWFwY39ekaFGN7ACepVvOn12gSjdfRfJHFhUWd3UBKIAfJR+T4ppXWmymnXRB00OY9Roj+Wm0/yDT4q5sefEWKjHUifPFCjkTQaYxA3xi+ERCy9PY5OaDR0fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoElKXAGacSZ+uPPSmOIgszUo7HPQPX8cr4M4stVWF8=;
 b=L8Ctb69/2639YR5iFP42kVR5g4+66no2IGYYw7sJI3YV7yENrgtn+Xnz+2Vwxuj4Gt0nzEzFPdRTCbx1jZwJ9QhBxrwnj7HF7xuUgZ/CzXF6ekWzupfzA62EqmjVjhFehqaFz7A/aNn/JOWB2wTu7Sv4F8FcT8jUrNf0WQZQhcOEcILtt5kgd07Hwy0AdVZJglKCndTu8hUVatBUyyoPZLaAdIW4/+kwvd9JHB7JRi1GUzuKU4yel5xXx6l4lIKLXqpuFRz8vIoCBxmH7Vt3cWlJu74VzTgcPxPPn6ZD5LMcSeUPUH9JIY8lzXkiLnlocOL6wL2Og/9L7b58dDkZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoElKXAGacSZ+uPPSmOIgszUo7HPQPX8cr4M4stVWF8=;
 b=Y9h8XZIDMxtpn1rPv6RCPzo3jbKA6yRYWUilcxzqtMnCk0bk1uOvM51ehsrpB3KLuEbtjoK2kwlynkGIYr3kDmCtvqJmJgLx8llncSi/fuA5qCf8ih7Wg2yGjvzS+bJbYXJefJzsZFbvaDsV7HIJS9WK8x78PAn6v7+N2cq8V4w=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:22:19 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::b3) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:16 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:11 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Leo Ma <hanghong.ma@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 13/43] drm/amd/display: Fix noise issue on HDMI AV mute
Date: Tue, 12 Mar 2024 17:20:06 +0800
Message-ID: <20240312092036.3283319-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0561cd60-569e-4ea3-f1ff-08dc4275eaa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPVwffFXu2MfUbBlJT3NHOErXOU7TLfMlt8SvhmtDqoIzhctw4UdyQdsA8U+y463Y0UwXezfxcmftmhtJhzO8iVWClGojFzpTMHmnHHpc4R1Oe69qbr5HEQ4fvfB0PlKnDyYNvNONIHbJxfngCkGQ+UDvdTh/B0V6+sLpC3VIE44LIYmteAkpX7zIujcy6PIa5mzFW0R8HxuKqcK9d9XFjEYPJ8yopWn/JYYckXGJ7GPBqn/0PauTLmvjs37KXg6d0HZGq5950e8n+USRto7IJJ8mlZd0FEDOR3KfqimJrzrkiU12wDekvqnsDQswcnRUFA+jkwoG9E2j6goK7bvonUSv1mmw2VUsOe4/QYNm6emCSeeN2FA3/VUi0w6vazJogsaHTnZHy3I15TdmoUE94kWddmakvhumDN4rO2oE6oXNGXV+754iK2IQkyI5eQyCpMTtERXnWrjj2k1wbg6n6UEb/e+zKjYARGo3IPjYE7x2NFLcrBbjgcGyZ+Io580YLVz9w+MwakJjzkyIEGricmMcdalftlwWcaQ0mhZPkUi5VQlHZRHchTUPcUz9iJeAaKbyGIbsO59xaIV6vQB4MNkuXn6/J/vrbZbhDwXOIq6FDzS1s4BVCepNCZ323ySw5zsi1MaX/PL5BaWsrIw2D6WFb22aATSlZ/4rYa16bLBHV+kwjqiSIJt34X6DrX2QcbknH50pzvVULNIe9qQqzK0bFJlMhg6MdIX1EsyL+FOV3TwjRoYI5qsL1DsnC7p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:19.3384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0561cd60-569e-4ea3-f1ff-08dc4275eaa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
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

From: Leo Ma <hanghong.ma@amd.com>

[Why]
When mode switching is triggered there is momentary noise visible on
some HDMI TV or displays.

[How]
Wait for 2 frames to make sure we have enough time to send out AV mute
and sink receives a full frame.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c  | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 7e6b7f2a6dc9..8bc3d01537bb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -812,10 +812,20 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 	if (pipe_ctx == NULL)
 		return;
 
-	if (dc_is_hdmi_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL)
+	if (dc_is_hdmi_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL) {
 		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(
 				pipe_ctx->stream_res.stream_enc,
 				enable);
+
+		/* Wait for two frame to make sure AV mute is sent out */
+		if (enable) {
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+		}
+	}
 }
 
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx)
-- 
2.37.3

