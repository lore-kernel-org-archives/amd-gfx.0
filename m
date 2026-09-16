Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF6EC982D3
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73B110ECE1;
	Wed, 16 Sep 2026 17:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OWC1e2fy";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD3510ECD6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKokNtBEyloPxGiFZ829LkMnEQnH7JKqni94p75Gc/OeRtBha/hZdkSPaEIs6UNHww7/TaGgo99i3wMW9GfgYbKT8FHAoEKGyIQRueHg6t47Fk/b5++dkOMbd3IZGRJVXNzuMQ0KXU4x5x5wvXg/XDw64NgvsGHUHayaTJ4tu7rQc1L6Yybl5u8SwUXFhKYGssRkNHMwCm+D4rtG6650eEzut5hQ+0gIY3PA2qLRv3BK3PfrDa7nN7CTl97hBgEfvqHCpvfEEloJtSUPYOB82HCB6VZ/ch3sTwUsPL1q8Ts5tCMzj4l9ETOhilJTektpv/vFBfTxuSOmBMYxDjgmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC2SUC60ue8GZfExbU9ApwPWaqG6y4yRbCrQQVorSFw=;
 b=uIfMggbOqD+YsNmfC73Mv97LEqRKu9HDJ8LZZkal7MpTO6xcG3TMPDQwsVr3darvlCdxySlWwQ/Vi9Lt6b9VuclXLnmGkbFz/RviaIEcT0VMSklnzU7qtjWur4dJCYhbCKnxykWO7+WxF2FN0gXcJ/FEsPVA6uJbeg1aQ7OMU+wJly+dtrYFMBjWSxxq7uOFmyMeQM7EvXWdNcc0aNcFrvi4K/pn9j5Hnsl9LoSG0C7HGxCDSNUMWO3386m1j65jgkHDqFMbQcNjJk3OEL64IpPUvfwdx7fWTcIDRcpZ+18ZTZSmIh6YTj6TIsH+TE3XARBDvV5N8uBjf1pgLeI0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC2SUC60ue8GZfExbU9ApwPWaqG6y4yRbCrQQVorSFw=;
 b=OWC1e2fyj/dijxweX4oJpkZx/4942nmmGYZOMPuHuTyv5A9r+xWq226/jgN9j855Z0JCI7vsvziIl+EllG8A/pkXwxYml/Iz7MExxTDGj6w48v8nRNNt/eKacrr4BM/E43iko/Gts9P6KYjKW3uCkEOO6F95CP9JfTq/QUfMOPY=
Received: from CH5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::13)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:53:07 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::81) by CH5P220CA0007.outlook.office365.com
 (2603:10b6:610:1ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:07 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:57 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 56/64] drm/amd/display: fix cursor refactor fallout and sync
 UT headers
Date: Wed, 16 Sep 2026 13:52:11 -0400
Message-ID: <20260916175301.368306-57-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: 877e01da-23d3-426e-b59e-08df141b5d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qojNePJ3ln4wfYtt8IRJUpHX6yxTQY7hf7VS/Xr226H8Y/BG7vQ8Moe3By0Go8N0m1rfiwautZ89qf9GaSm2wPURWZE29ZOvvRj9E8hRMBWKIeijZyQpIp53MqnFsUYMNpaDnmQtecNmb+BUwKge9L4Y2lux7K5FP9xX66+b5VHtf8rY5l3M9z0RyYfQtZsk5uWJHYX+sma1WRl3+nOmF/2aFPlszT5bf6PGaF4xuwGTRz5VoEttGGfKoNYAupzmwAGsNOtgSdbQjow3xa02AFIxDDhsbuRl/ywOHHzOuo7Jq5QiPs2wZ6t42EKq33f4dM6G+Pcs2XJei9SWtZtDeaXLp+KFfDuuqWUXUX26IX66apT7KkFJijaUZuYWhO9KdcqkInRAxW/cAma0WN7LVmgOf/N8wNtGR49yN3o+NUmf15FfGUmfJ0Nu7JstvQn/PS8bJx3yNgxmFWTtl0EyI8JUPt7NK/BN8ECFryJ2tW9GfKK1N8Ko3FJQouRplx3FRR1mFLTO+ATh+NCSzQ8Iy1bc3UEEkXY5lGCypirFvSRUAayzRfmZk/jRyCQOu/zCVpEy+klufh0uUuClOBQxV4K/u8lpXAjmP2rvmis1/2fMQivdXwxqDu9xpc8tI/ovDTPDOWtK5UUhOAMVrmbE1tX8VNomVdi/tsakeN6Zl08jPUuXAmlQ1g6U0hsHzRIzvZh0Ml85ZOhtVGOiiimfng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2QELyLwfw2n2ik2pDTCfq9OBhrwrnyoFSgY8ZE2XZe4ILx08lJ7gJRLdN4+NPngFDBH9MyoAqwfU+EanOTBXy/Q7HAXeECKPuRdMVBibrshWmuYkeZo2ToPjZaY+sKDIcVitiyEOaCkKOSLMvoRlh0uMlwGXfUaPgtywMT92qLQfcNwE5rGk5KA2jCIjiZf1EGjWc+eeQCdK9VZrCBVditxGVdeSF5WYJJ3svJSEsl4P8Om4+Vvb1qSoMdNK+p9185gNcKQfJokfC8sd41O6SK4BepesDxSfbhXJdO1G8onWF6d09SaUrskk9kDenkXEuK5toMQeNdoY5KUFyPdSjME1oPoe4d8hzn2kAMs5GMNudCxhNX5WAiyHvuUeOaQQnGHvfpkbPpgJlSg8yXQr3/7f9n9gZkh1Wy54xSQmwK9hyt+Dgo/KRwL+UtSwXC3q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:07.5974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 877e01da-23d3-426e-b59e-08df141b5d93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
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

From: Piotr Maziarz <piotr.maziarz@amd.com>

[Why]
UT mirror headers still declared the old prototypes and hwss_gtest still
called the callback directly. Separately, the divide by
param.pixel_clk_khz used to sit after hubp401_cursor_set_position()'s
"curs_attr.address == 0" early return; hoisting the math into the
builder moved it ahead of that guard, so it now traps on streams with
no timing programmed.

[How]
Guard the dst_x_offset block with "if (param.pixel_clk_khz)"
Route the test through hwss_program_cursor_position().
Update dc_hwss_ut.h / dc_hwseq_ut.h and the BLS docs to the new signatures.
Move the pos/param declarations to the top of the loop body.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  6 ++---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 25 +++++++++++--------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 3bc0362d9dc0..0a7408692cbe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1396,6 +1396,9 @@ void hwss_build_fast_sequence(struct dc *dc,
 		struct pipe_ctx *cursor_pipe_to_program = NULL;
 
 		for (i = 0; i < MAX_PIPES; i++) {
+			struct dc_cursor_position pos;
+			struct dc_cursor_mi_param param;
+
 			current_pipe = &context->res_ctx.pipe_ctx[i];
 
 			if (current_pipe->stream != stream ||
@@ -1419,9 +1422,6 @@ void hwss_build_fast_sequence(struct dc *dc,
 				}
 			}
 
-			struct dc_cursor_position pos;
-			struct dc_cursor_mi_param param;
-
 			dc->hwseq->funcs.build_cursor_position(current_pipe, &pos, &param);
 
 			block_sequence[*num_steps].params.set_cursor_position_params.dc = dc;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8fd60ed7669b..37b699c69144 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1233,20 +1233,23 @@ void dcn401_build_cursor_position(struct pipe_ctx *pipe_ctx,
 		ASSERT(!pos_cpy.enable || pos_cpy.x_hotspot == 0);
 	}
 
-	dst_x_offset = x_pos_viewport - x_hot_viewport *
-			(1 + hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION);
-	dst_x_offset = (dst_x_offset >= 0) ? dst_x_offset : 0;
-	dst_x_offset *= param.ref_clk_khz;
-	dst_x_offset /= param.pixel_clk_khz;
+	/* pixel_clk_khz is 0 when no timing is programmed on the stream */
+	if (param.pixel_clk_khz) {
+		dst_x_offset = x_pos_viewport - x_hot_viewport *
+				(1 + hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION);
+		dst_x_offset = (dst_x_offset >= 0) ? dst_x_offset : 0;
+		dst_x_offset *= param.ref_clk_khz;
+		dst_x_offset /= param.pixel_clk_khz;
 
-	ASSERT(param.h_scale_ratio.value);
+		ASSERT(param.h_scale_ratio.value);
 
-	if (param.h_scale_ratio.value)
-		dst_x_offset = dc_fixpt_floor(dc_fixpt_div(
-			dc_fixpt_from_int(dst_x_offset),
-			param.h_scale_ratio));
+		if (param.h_scale_ratio.value)
+			dst_x_offset = dc_fixpt_floor(dc_fixpt_div(
+				dc_fixpt_from_int(dst_x_offset),
+				param.h_scale_ratio));
 
-	param.dst_x_offset = dst_x_offset;
+		param.dst_x_offset = dst_x_offset;
+	}
 
 	/* Cursor rectangle cache origin: derived from the final cursor position
 	 * minus hotspot, clamped to 0, offset by the recout origin. Precompute
-- 
2.55.0

