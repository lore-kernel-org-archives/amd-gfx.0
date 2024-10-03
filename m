Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B45CF34D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73DA10E9A3;
	Thu,  3 Oct 2024 23:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OEzHWWJz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5661110E99C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXBAiKxsBFSlzFv+U3PjyBEYBoYmbCuvwAs5SVINp3ktZWtz8M30kUTXBJ1L8fGEf1WRq+Bk6dSAZ7MiLyW81SgNcRWeYQQm8nXicrgyO/2XjXZI8kMbkNBPPyaGy28iE7UyQxvvy79zNQY61ZpxKfLGQyM1dYI+cKvZE83fa5mh1i1oXogC8R3EWLUlek3FveJ8S0V6X75uWHeoq7ocLHntsXiXejmol7Ck7Hvl4j+RjQXScCipRnP2K+xiwAfOE5eGnjfOaXgmA1IDtMmVMiNBgEcBNY9D7DeObMzFY3w/r9D1U+6l8WEN7fJhzsWquDXD5DCJWsCNVMbnrU8gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p50v1y9k8BoPVskU02ToigYALFP83tx+CB+sTgC7Dk=;
 b=sdY5pkznW6n0PabkkJ2+7uqyRNHWRhrg/3Kjg11PMuwFqQZRUWqfg9mo3Y8AUWGzCf3itqGOqP+oPoAH+7FrM48Tv3Z39orvNucALrG85FLQWXbp6n2dJ/uWZJhmUfPecm+D/y0AhQwit8qzQmF3B/k+Xsuw8UIoAboYOUiwINC1Qdi1XHDZG4huPN0zxHwWDvxDmbKFmjhap5Fezn6AvRa8ZoBZGURgZMQtBvuN+qpwS65hbKD7AnGofa0fDX+DJ3IzGLJbGHFQqPKHsJ/DTrVqUGxJBFyF0C8E+G8KkZzhUePc3OP/pqyyPdhYhOrmIgevcrD9+5Cvc2ItgXaMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p50v1y9k8BoPVskU02ToigYALFP83tx+CB+sTgC7Dk=;
 b=OEzHWWJzL1Bz7eN6Tz1RwwWSoW+97NlAsf1XM1PKKAyVe0fyTS6elbzZgW/dv6bRCZN4QEYENuxB/TCYsSB2N0OfO0giwzgkOskVzIoCfv9gpYprrHPtt3qxSk9n2Rtslw/xtHXqaSipGZRlMHuLqZ+b9eIN96PQ4JfknNgEWkU=
Received: from DS7PR03CA0271.namprd03.prod.outlook.com (2603:10b6:5:3ad::6) by
 SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 23:35:49 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::68) by DS7PR03CA0271.outlook.office365.com
 (2603:10b6:5:3ad::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:49 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:46 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Zhongwei <Zhongwei.Zhang@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 07/26] drm/amd/display: Fix garbage or black screen when
 resetting otg
Date: Thu, 3 Oct 2024 17:33:25 -0600
Message-ID: <20241003233509.210919-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2caac7-93ff-4cd1-d024-08dce4041ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gh4T4ZofGD7ltZqzTnSw3WFDY0wUuIJDS76tDJeRXfy5edDec6WFiCyjfbU7?=
 =?us-ascii?Q?IO/cEdJEhjeOeXqeG9j8snQ/d6NMCL127lfWUSU3cqQb/HxADenHqga5ZXJN?=
 =?us-ascii?Q?V9hAiXBLJ+Wauf/g1NeLgwa1fLJuYKkW0Yo3LXmDC2fmA7D+ifR9gJbMbGSC?=
 =?us-ascii?Q?rWf/ytA9Sr8qXhAYAK7Lz/QssEv1ybKD23TCWx+E6tAkpJ4y/5LOsoe6hPhJ?=
 =?us-ascii?Q?U/DtsBs69OOaFJhJdGtOz7rBQDmSWwMVaHc5w6F6Zkc0Nw3xufI2BoL3/I4O?=
 =?us-ascii?Q?5SnzQSBuP3ezCdOw/5cNtteaVGQOd+1FYePRtlg4l0PYSSj/B+M52zTkZRCj?=
 =?us-ascii?Q?faixMyqA0wdTGn8w3euSX72HDFd+oRVc/9wB1XICt3G5clZONux0gkXchfeU?=
 =?us-ascii?Q?5cGfASIPg6TM3XXP2SFzKJ0iBSHqWXdy+RVV9IBRDXEb5t3hgGVQm4FVfcH2?=
 =?us-ascii?Q?pERjecjMMXGpdj1YWtkwrgPbVsqQHQD830yRpo2jJ1pniTnvuxWPTGrlwlp9?=
 =?us-ascii?Q?fC1pxAwr2ANCVLyf9hXbGUlm9F5iZM7lCNcGZNvA9UmmFg126GMuIbKnxOV4?=
 =?us-ascii?Q?eEG9C/4WCf0jGUounNZ3mHTgB0uOcsC1R84gNhbk1NGtKv0TkK2lX0xU6lfh?=
 =?us-ascii?Q?sYKUi1W29PBFHMvaCwUu/2YXldmKtX9RKEZPmKeWq5ny28dfznsVwfDbvJF7?=
 =?us-ascii?Q?xa9uTmWJiZ+W3h7oENcXzWqxR99FJwucH5h2061oPyQ+1uV/bB1TIjshZBaU?=
 =?us-ascii?Q?5AY+S3OI4OJ6rebJCrV554h6OwfpY0pENqL7/IBO+TdgiwIHKGT7k1qHWl7I?=
 =?us-ascii?Q?/CdTLXa0il6uwYt2RHul5lbx8WrCi2364U3B0iZbgo9j337NJ+Fo4U0jtkPr?=
 =?us-ascii?Q?vvJO+UFl5RhM/XFAtXq9M1sPfTBg3mAjpdfFsGbcZSs/zHkERz0QdQhUOUWs?=
 =?us-ascii?Q?HaZWYruUBk8skouRJg3FOgOkdRCOPcQLCpqOJ4he943jReXzQZOPRdF8WHmM?=
 =?us-ascii?Q?eMGrY66zPkV/RuhiupYT8V6Zc/krUKe6s26LBl665BXeaJg+PKXE1Ylft1DF?=
 =?us-ascii?Q?3Hntz9Lzq8mob/JGLIwSw5mNR52aEfl3kJLhBAqxmaqFJ67OvE1Uie8at6ae?=
 =?us-ascii?Q?7CbLMJXdCDaiwp/0vrwgcBEO/4jbsiXYNQD+QgUrrBVzTE36Gy1Mf2THfc0G?=
 =?us-ascii?Q?ZeYKidvtB+6DdgiLPFkXm/Hsk6CpPnQM6A0LaRQQxH56YxAP9F2j7SNQPLP5?=
 =?us-ascii?Q?W3VkrcUQEqhG/6GWZXnFa/cEjZ/5CkAMsTYgzzsTtWurTpdhs6KfpOukQl48?=
 =?us-ascii?Q?/PDMPYnn02lFeDSBah8XFBRHxtsnv8qkFz4/t1V7zXMleTb96gEqfxvRZ2bv?=
 =?us-ascii?Q?GLDj9nnh2yZuTQxjnn0iJkz/5KNl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:49.3546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2caac7-93ff-4cd1-d024-08dce4041ce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
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

From: Zhongwei <Zhongwei.Zhang@amd.com>

[Why]
For some EDP to MIPI panel, disabling OTG when link is alive like boot
case, the converter might output garbage or show no display because our
GPU is not sending required pixel data.
Alos Dig fifo underflow was found which might cause garbage, when
resetting otg for other types of EDP panels.

[How]
Skipping resetting OTG if the dig fifo is on. Make sure that the otg for
the pipe is the one that the dig fifo is selecting via the FE mask.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Zhongwei <Zhongwei.Zhang@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c    | 10 ++++++++++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c    | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
index 5b343f745cf3..ae81451a3a72 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
@@ -83,6 +83,15 @@ void enc314_disable_fifo(struct stream_encoder *enc)
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 0);
 }
 
+static bool enc314_is_fifo_enabled(struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	uint32_t reset_val;
+
+	REG_GET(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, &reset_val);
+	return (reset_val != 0);
+}
+
 void enc314_dp_set_odm_combine(
 	struct stream_encoder *enc,
 	bool odm_combine)
@@ -468,6 +477,7 @@ static const struct stream_encoder_funcs dcn314_str_enc_funcs = {
 
 	.enable_fifo = enc314_enable_fifo,
 	.disable_fifo = enc314_disable_fifo,
+	.is_fifo_enabled = enc314_is_fifo_enabled,
 	.set_input_mode = enc314_set_dig_input_mode,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index e0054e654db6..9b88eb72086d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -355,6 +355,20 @@ void dcn314_calculate_pix_rate_divider(
 	}
 }
 
+static bool dcn314_is_pipe_dig_fifo_on(struct pipe_ctx *pipe)
+{
+	return pipe && pipe->stream
+		// Check dig's otg instance.
+		&& pipe->stream_res.stream_enc
+		&& pipe->stream_res.stream_enc->funcs->dig_source_otg
+		&& pipe->stream_res.tg->inst == pipe->stream_res.stream_enc->funcs->dig_source_otg(pipe->stream_res.stream_enc)
+		&& pipe->stream->link && pipe->stream->link->link_enc
+		&& pipe->stream->link->link_enc->funcs->is_dig_enabled
+		&& pipe->stream->link->link_enc->funcs->is_dig_enabled(pipe->stream->link->link_enc)
+		&& pipe->stream_res.stream_enc->funcs->is_fifo_enabled
+		&& pipe->stream_res.stream_enc->funcs->is_fifo_enabled(pipe->stream_res.stream_enc);
+}
+
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context, unsigned int current_pipe_idx)
 {
 	unsigned int i;
@@ -374,6 +388,8 @@ void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc
 		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal)) &&
 			!pipe->stream->apply_seamless_boot_optimization &&
 			!pipe->stream->apply_edp_fast_boot_optimization) {
+			if (dcn314_is_pipe_dig_fifo_on(pipe))
+				continue;
 			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
 			reset_sync_context_for_pipe(dc, context, i);
 			otg_disabled[i] = true;
-- 
2.45.2

