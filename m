Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD763E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F32410E720;
	Tue,  7 Jan 2025 15:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u4YMNAUO";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6829D10E720
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBnU65n3NhrKmMlgQqnnt5gYWgv6gsgvAGC3nDmJDujIfMoGSKtTj+DhhwL6mYbIz9S9BZlH7epYd0MRwJ7J2m45RFq5QppfCGRgG2vv/m8J+hIXh6BWMGOvlKPwChhCPY4zUEy06W71h0jIPMrj+5iYkHC+K/xV2UiX+eLY3Yzv2YgboTzk9QFwXV3cWVU/VfNZ1Cx7SOPS9X7pGsHtwCoL4jRG6rB19t1+mjAgMGT7yGkDPMVPrXzOtdsCwnn77V9LzTPIfY92FtrGTKjiub14WiZhTg0r4svq8TjXTWOP28KJrLMbqf8WP2kgYbLYXnogMLHKHpEdt5X5kwSGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNeUZH0N02hnPQ0Nnfw/JYufLhu+N8HrBrsZ9k27oU8=;
 b=lMWBdzFv07Wmqs//r9BMR2C1J6aZPt+2OrOZeiUOk4c9wewcul4ktG6/CWmvowYBI1OaUnBtn8jbMJZb4mnwG6UmfnSHbbsj6xdjhdTD1qJkkxjMt3bd64CFS4CSuOxbgGkl71DT0DoLnZXQ5iZ+uMbyDGkwMgMVUvWlkbUqx/pMItLzttoQVX4TP8W412bdJEw6jMgRtJ6pnMmlO2L3D6ltNKAnwPIjcn0D6CuivY3xwk5A5aQ7OPtsKCQzTk6FKZvwziI77SN6Ohhk/GlIJkK4ajC3dfRNf1b7mtB+iWQf7GscoX3HRHQipnWoadwErCBV3oqZixJ8UZqzPrROBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNeUZH0N02hnPQ0Nnfw/JYufLhu+N8HrBrsZ9k27oU8=;
 b=u4YMNAUOdUngfthSzGp7JrG5SfJ8INhlxbISwfXl0yJasfzmt083qo7alF8F/c0jAafEDW2CMGQUI690QEYLSrTeigP7KdOp2uG4y63H/z8NlICZZS3kwcA007vjk63M8RYHKYJ6yeScerVX2j89ptRKBR1rHsp96gjhnSvZqIY=
Received: from BYAPR07CA0072.namprd07.prod.outlook.com (2603:10b6:a03:60::49)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:29:55 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::61) by BYAPR07CA0072.outlook.office365.com
 (2603:10b6:a03:60::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.16 via Frontend Transport; Tue,
 7 Jan 2025 15:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:29:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:53 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:29:45 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, HaoPing Liu <haoping.liu@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Add support to configure CRC window on
 specific CRC instance
Date: Tue, 7 Jan 2025 23:28:40 +0800
Message-ID: <20250107152855.2953302-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 259d4bcb-e5e0-42c6-4e32-08dd2f302302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TN0nnwZQplju5WusNCZJKk6vZX+boN8YVlk+wt5d8xOMZpSxFd1Bo5DxiQjP?=
 =?us-ascii?Q?409lacqlRvvp3naUpuExZ3zYR2vVloSan6FxysQ/t1X77dKzm5URn7Lmf5ng?=
 =?us-ascii?Q?XvRHJC7AIgGv645aQYSWEUa21u1NJOEoiKmUgbCts5lPh8nWPxEyrHoFxjsb?=
 =?us-ascii?Q?8LmO5C+swQH5U5y6c0Ky0PVozV8ufnJpLHLDHLjOlLgWbmDMPSTO+DVB5Fyj?=
 =?us-ascii?Q?nqKtvRSP87EizGsNCvs+558vv5lfOnwimsIqvMoU+CzBPCefumTSnMmFzemY?=
 =?us-ascii?Q?liCDEJXmge3YIlwEyeww9QDtgteVjHqWk6mfavuIW3ChRbnxsd0YqPVtuU70?=
 =?us-ascii?Q?CUXW3jQHZxMZaEK4N7EqVTC1TTSJaEAhC5rs4wnFNlAdUkrhLVgGEWlN3tYR?=
 =?us-ascii?Q?VyYHpewYJyC130PxeMNYrQZzhJtkiyyqnvdu358is6d76oz6JOvDSGu8lDHQ?=
 =?us-ascii?Q?5pzmEv4OikeIfDDusPNdqzvIy3gvW4IzNIL2bL0Obtp/GzTZqmKVVDX60Iu5?=
 =?us-ascii?Q?HEKUpPGbOlFdW5yeNnh187EGsMmiwsOtdtAvJIOliQMceLLMqA7jfluuVuPW?=
 =?us-ascii?Q?An57KIjuixuYokpu+COSe5wBeXay0IvSaH5jN0PDQkeHc7DRgu5gnJULRk9V?=
 =?us-ascii?Q?5GAT0ZWfuNH9AvkxVij7BZTHL9rALh5bi1fQZX8cS79kGWtu1XsUKC3DmUtL?=
 =?us-ascii?Q?4aaOEWCNO6IG8/e2QmD1IQq+T4q5vR+3cComlBDc7g3MMQzvuPKFunle3ugA?=
 =?us-ascii?Q?ZmTlCgns9ZSVZ3ZVMkqFhUCdosanLbpQA0h157XEHzR+USZcSNTF4PzaptXf?=
 =?us-ascii?Q?ue/0OOaEzBVQeqQHjMZfnokhs+0Snug7TaR7WYO1wBZrJY6eK6hnEcjbljNY?=
 =?us-ascii?Q?1MHX7oO78nzBDuyRxmdTQQapcgoCuVSUDpGpumEnqxRq+IHbayp6y7Z6hHvB?=
 =?us-ascii?Q?63Ln3UMgVj7vwIS9pBH8aeCohUQBZyFJlPg7b/I5RfAQQ0ZjEdBN3K6oJ6wR?=
 =?us-ascii?Q?qnUknjB5K433B6yKqVqXe50ZnmGikM9VNfn3LN/dbXPXvniVEuZJZdP7ZpRF?=
 =?us-ascii?Q?mjjXgixtudI2dlKywyyhcYkn9GqCee2ZYPuK1h5Pko9dMF9Jjwxa2YDjMlDe?=
 =?us-ascii?Q?x/HuC607Wus1ekITM5y4A0mqE1jbfML21DPU/o7ygkd9vAYKVHx3swo9C40a?=
 =?us-ascii?Q?Rr8wuPzr2XugMsIavNhFKVy4AYOLB84vHGOgUsTWrZnv6tItDr0AGzY4T2SF?=
 =?us-ascii?Q?dCqItS4zWzT4CG2Sq3lWpvt15WD+mQxMzgHLhsUujgv9VdviQfV40hcY6qe5?=
 =?us-ascii?Q?6NyN1xKWThQ62snnZPhQ8mJVZBPP1GbnwEKvG5zZcoTqlD8kxa9vW6qxCB0c?=
 =?us-ascii?Q?u6VlrbiOAtvMCmuJZltWFPamSA4J9g2x78CYDifRe3XlT2QxxcpI4/qHj9P8?=
 =?us-ascii?Q?glLdS+JsGO8GrTKfBd6VoSvekuXPUEuO7Ts/lJvmtiq9HB1FLpEUyBci9Fm/?=
 =?us-ascii?Q?9I0PqlmjKrNbKB0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:29:54.7986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259d4bcb-e5e0-42c6-4e32-08dd2f302302
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Have the need to specify the CRC window on specific CRC engine.
dc_stream_configure_crc() today calculates CRC on crc engine 0 only and always
resets CRC engine at first.

[How]
Add index parameter to dc_stream_configure_crc() for selecting the desired crc
engine. Additionally, add another parameter to specify whether to skip the
default reset of crc engine.

Reviewed-by: HaoPing Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +-
 .../dc/dce110/dce110_timing_generator.c       | 169 ++++++++++++------
 .../dc/dce120/dce120_timing_generator.c       |  90 +++++++---
 .../amd/display/dc/inc/hw/timing_generator.h  |   3 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  86 ++++++---
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 101 ++++++++---
 8 files changed, 329 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 7c15082c92ed..a2e36b882a4f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -510,7 +510,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	/* Enable or disable CRTC CRC generation */
 	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
 		if (!dc_stream_configure_crc(stream_state->ctx->dc,
-					     stream_state, NULL, enable, enable)) {
+					     stream_state, NULL, enable, enable, 0, true)) {
 			ret = -EINVAL;
 			goto unlock;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cb6293d8ba77..cecaadf741ad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -687,15 +687,17 @@ dc_stream_forward_multiple_crc_window(struct dc_stream_state *stream,
  * @enable: Enable CRC if true, disable otherwise.
  * @continuous: Capture CRC on every frame if true. Otherwise, only capture
  *              once.
+ * @idx: Capture CRC on which CRC engine instance
+ * @reset: Reset CRC engine before the configuration
  *
- * By default, only CRC0 is configured, and the entire frame is used to
- * calculate the CRC.
+ * By default, the entire frame is used to calculate the CRC.
  *
  * Return: %false if the stream is not found or CRC capture is not supported;
  *         %true if the stream has been configured.
  */
 bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
-			     struct crc_params *crc_window, bool enable, bool continuous)
+			     struct crc_params *crc_window, bool enable, bool continuous,
+			     uint8_t idx, bool reset)
 {
 	struct pipe_ctx *pipe;
 	struct crc_params param;
@@ -739,6 +741,9 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 	param.continuous_mode = continuous;
 	param.enable = enable;
 
+	param.crc_eng_inst = idx;
+	param.reset = reset;
+
 	tg = pipe->stream_res.tg;
 
 	/* Only call if supported */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index dbf0832eb706..3e303c7808fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -550,7 +550,9 @@ bool dc_stream_configure_crc(struct dc *dc,
 			     struct dc_stream_state *stream,
 			     struct crc_params *crc_window,
 			     bool enable,
-			     bool continuous);
+			     bool continuous,
+			     uint8_t idx,
+			     bool reset);
 
 bool dc_stream_get_crc(struct dc *dc,
 		       struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index e32dd96a99cb..61b0807693fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -2127,65 +2127,126 @@ bool dce110_configure_crc(struct timing_generator *tg,
 
 	cntl_addr = CRTC_REG(mmCRTC_CRC_CNTL);
 
-	/* First, disable CRC before we configure it. */
-	dm_write_reg(tg->ctx, cntl_addr, 0);
+	if (!params->enable || params->reset)
+		/* First, disable CRC before we configure it. */
+		dm_write_reg(tg->ctx, cntl_addr, 0);
 
 	if (!params->enable)
 		return true;
 
 	/* Program frame boundaries */
-	/* Window A x axis start and end. */
-	value = 0;
-	addr = CRTC_REG(mmCRTC_CRC0_WINDOWA_X_CONTROL);
-	set_reg_field_value(value, params->windowa_x_start,
-			    CRTC_CRC0_WINDOWA_X_CONTROL,
-			    CRTC_CRC0_WINDOWA_X_START);
-	set_reg_field_value(value, params->windowa_x_end,
-			    CRTC_CRC0_WINDOWA_X_CONTROL,
-			    CRTC_CRC0_WINDOWA_X_END);
-	dm_write_reg(tg->ctx, addr, value);
-
-	/* Window A y axis start and end. */
-	value = 0;
-	addr = CRTC_REG(mmCRTC_CRC0_WINDOWA_Y_CONTROL);
-	set_reg_field_value(value, params->windowa_y_start,
-			    CRTC_CRC0_WINDOWA_Y_CONTROL,
-			    CRTC_CRC0_WINDOWA_Y_START);
-	set_reg_field_value(value, params->windowa_y_end,
-			    CRTC_CRC0_WINDOWA_Y_CONTROL,
-			    CRTC_CRC0_WINDOWA_Y_END);
-	dm_write_reg(tg->ctx, addr, value);
-
-	/* Window B x axis start and end. */
-	value = 0;
-	addr = CRTC_REG(mmCRTC_CRC0_WINDOWB_X_CONTROL);
-	set_reg_field_value(value, params->windowb_x_start,
-			    CRTC_CRC0_WINDOWB_X_CONTROL,
-			    CRTC_CRC0_WINDOWB_X_START);
-	set_reg_field_value(value, params->windowb_x_end,
-			    CRTC_CRC0_WINDOWB_X_CONTROL,
-			    CRTC_CRC0_WINDOWB_X_END);
-	dm_write_reg(tg->ctx, addr, value);
-
-	/* Window B y axis start and end. */
-	value = 0;
-	addr = CRTC_REG(mmCRTC_CRC0_WINDOWB_Y_CONTROL);
-	set_reg_field_value(value, params->windowb_y_start,
-			    CRTC_CRC0_WINDOWB_Y_CONTROL,
-			    CRTC_CRC0_WINDOWB_Y_START);
-	set_reg_field_value(value, params->windowb_y_end,
-			    CRTC_CRC0_WINDOWB_Y_CONTROL,
-			    CRTC_CRC0_WINDOWB_Y_END);
-	dm_write_reg(tg->ctx, addr, value);
-
-	/* Set crc mode and selection, and enable. Only using CRC0*/
-	value = 0;
-	set_reg_field_value(value, params->continuous_mode ? 1 : 0,
-			    CRTC_CRC_CNTL, CRTC_CRC_CONT_EN);
-	set_reg_field_value(value, params->selection,
-			    CRTC_CRC_CNTL, CRTC_CRC0_SELECT);
-	set_reg_field_value(value, 1, CRTC_CRC_CNTL, CRTC_CRC_EN);
-	dm_write_reg(tg->ctx, cntl_addr, value);
+	switch (params->crc_eng_inst) {
+	case 0:
+		/* Window A x axis start and end. */
+		value = 0;
+		addr = CRTC_REG(mmCRTC_CRC0_WINDOWA_X_CONTROL);
+		set_reg_field_value(value, params->windowa_x_start,
+				    CRTC_CRC0_WINDOWA_X_CONTROL,
+				    CRTC_CRC0_WINDOWA_X_START);
+		set_reg_field_value(value, params->windowa_x_end,
+				    CRTC_CRC0_WINDOWA_X_CONTROL,
+				    CRTC_CRC0_WINDOWA_X_END);
+		dm_write_reg(tg->ctx, addr, value);
+
+		/* Window A y axis start and end. */
+		value = 0;
+		addr = CRTC_REG(mmCRTC_CRC0_WINDOWA_Y_CONTROL);
+		set_reg_field_value(value, params->windowa_y_start,
+				    CRTC_CRC0_WINDOWA_Y_CONTROL,
+				    CRTC_CRC0_WINDOWA_Y_START);
+		set_reg_field_value(value, params->windowa_y_end,
+				    CRTC_CRC0_WINDOWA_Y_CONTROL,
+				    CRTC_CRC0_WINDOWA_Y_END);
+		dm_write_reg(tg->ctx, addr, value);
+
+		/* Window B x axis start and end. */
+		value = 0;
+		addr = CRTC_REG(mmCRTC_CRC0_WINDOWB_X_CONTROL);
+		set_reg_field_value(value, params->windowb_x_start,
+				    CRTC_CRC0_WINDOWB_X_CONTROL,
+				    CRTC_CRC0_WINDOWB_X_START);
+		set_reg_field_value(value, params->windowb_x_end,
+				    CRTC_CRC0_WINDOWB_X_CONTROL,
+				    CRTC_CRC0_WINDOWB_X_END);
+		dm_write_reg(tg->ctx, addr, value);
+
+		/* Window B y axis start and end. */
+		value = 0;
+		addr = CRTC_REG(mmCRTC_CRC0_WINDOWB_Y_CONTROL);
+		set_reg_field_value(value, params->windowb_y_start,
+				    CRTC_CRC0_WINDOWB_Y_CONTROL,
+				    CRTC_CRC0_WINDOWB_Y_START);
+		set_reg_field_value(value, params->windowb_y_end,
+				    CRTC_CRC0_WINDOWB_Y_CONTROL,
+				    CRTC_CRC0_WINDOWB_Y_END);
+		dm_write_reg(tg->ctx, addr, value);
+
+		/* Set crc mode and selection, and enable.*/
+		value = 0;
+		set_reg_field_value(value, params->continuous_mode ? 1 : 0,
+				    CRTC_CRC_CNTL, CRTC_CRC_CONT_EN);
+		set_reg_field_value(value, params->selection,
+				    CRTC_CRC_CNTL, CRTC_CRC0_SELECT);
+		set_reg_field_value(value, 1, CRTC_CRC_CNTL, CRTC_CRC_EN);
+		dm_write_reg(tg->ctx, cntl_addr, value);
+		break;
+	case 1:
+		/* Window A x axis start and end. */
+		value = 0;
+		addr = CRTC_REG(mmCRTC_CRC1_WINDOWA_X_CONTROL);
+		set_reg_field_value(value, params->windowa_x_start,
+				    CRTC_CRC1_WINDOWA_X_CONTROL,
+				    CRTC_CRC1_WINDOWA_X_START);
+		set_reg_field_value(value, params->windowa_x_end,
+				    CRTC_CRC1_WINDOWA_X_CONTROL,
+				    CRTC_CRC1_WINDOWA_X_END);
+		dm_write_reg(tg->ctx, addr, value);
+
+		/* Window A y axis start and end. */
+		value = 0;
+		addr = CRTC_REG(mmCRTC_CRC1_WINDOWA_Y_CONTROL);
+		set_reg_field_value(value, params->windowa_y_start,
+				    CRTC_CRC1_WINDOWA_Y_CONTROL,
+				    CRTC_CRC1_WINDOWA_Y_START);
+		set_reg_field_value(value, params->windowa_y_end,
+				    CRTC_CRC1_WINDOWA_Y_CONTROL,
+				    CRTC_CRC1_WINDOWA_Y_END);
+		dm_write_reg(tg->ctx, addr, value);
+
+		/* Window B x axis start and end. */
+		value = 0;
+		addr = CRTC_REG(mmCRTC_CRC1_WINDOWB_X_CONTROL);
+		set_reg_field_value(value, params->windowb_x_start,
+				    CRTC_CRC1_WINDOWB_X_CONTROL,
+				    CRTC_CRC1_WINDOWB_X_START);
+		set_reg_field_value(value, params->windowb_x_end,
+				    CRTC_CRC1_WINDOWB_X_CONTROL,
+				    CRTC_CRC1_WINDOWB_X_END);
+		dm_write_reg(tg->ctx, addr, value);
+
+		/* Window B y axis start and end. */
+		value = 0;
+		addr = CRTC_REG(mmCRTC_CRC1_WINDOWB_Y_CONTROL);
+		set_reg_field_value(value, params->windowb_y_start,
+				    CRTC_CRC1_WINDOWB_Y_CONTROL,
+				    CRTC_CRC1_WINDOWB_Y_START);
+		set_reg_field_value(value, params->windowb_y_end,
+				    CRTC_CRC1_WINDOWB_Y_CONTROL,
+				    CRTC_CRC1_WINDOWB_Y_END);
+		dm_write_reg(tg->ctx, addr, value);
+
+		/* Set crc mode and selection, and enable.*/
+		value = 0;
+		set_reg_field_value(value, params->continuous_mode ? 1 : 0,
+				    CRTC_CRC_CNTL, CRTC_CRC_CONT_EN);
+		set_reg_field_value(value, params->selection,
+				    CRTC_CRC_CNTL, CRTC_CRC1_SELECT);
+		set_reg_field_value(value, 1, CRTC_CRC_CNTL, CRTC_CRC_EN);
+		dm_write_reg(tg->ctx, cntl_addr, value);
+		break;
+	default:
+		return false;
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index 4984adce077e..31c4f44ceaac 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -1100,39 +1100,73 @@ static bool dce120_configure_crc(struct timing_generator *tg,
 	if (!dce120_is_tg_enabled(tg))
 		return false;
 
-	/* First, disable CRC before we configure it. */
-	dm_write_reg_soc15(tg->ctx, mmCRTC0_CRTC_CRC_CNTL,
-			   tg110->offsets.crtc, 0);
+	if (!params->enable || params->reset)
+		/* First, disable CRC before we configure it. */
+		dm_write_reg_soc15(tg->ctx, mmCRTC0_CRTC_CRC_CNTL,
+				   tg110->offsets.crtc, 0);
 
 	if (!params->enable)
 		return true;
 
 	/* Program frame boundaries */
-	/* Window A x axis start and end. */
-	CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC0_WINDOWA_X_CONTROL,
-			  CRTC_CRC0_WINDOWA_X_START, params->windowa_x_start,
-			  CRTC_CRC0_WINDOWA_X_END, params->windowa_x_end);
-
-	/* Window A y axis start and end. */
-	CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC0_WINDOWA_Y_CONTROL,
-			  CRTC_CRC0_WINDOWA_Y_START, params->windowa_y_start,
-			  CRTC_CRC0_WINDOWA_Y_END, params->windowa_y_end);
-
-	/* Window B x axis start and end. */
-	CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC0_WINDOWB_X_CONTROL,
-			  CRTC_CRC0_WINDOWB_X_START, params->windowb_x_start,
-			  CRTC_CRC0_WINDOWB_X_END, params->windowb_x_end);
-
-	/* Window B y axis start and end. */
-	CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC0_WINDOWB_Y_CONTROL,
-			  CRTC_CRC0_WINDOWB_Y_START, params->windowb_y_start,
-			  CRTC_CRC0_WINDOWB_Y_END, params->windowb_y_end);
-
-	/* Set crc mode and selection, and enable. Only using CRC0*/
-	CRTC_REG_UPDATE_3(CRTC0_CRTC_CRC_CNTL,
-			  CRTC_CRC_EN, params->continuous_mode ? 1 : 0,
-			  CRTC_CRC0_SELECT, params->selection,
-			  CRTC_CRC_EN, 1);
+	switch (params->crc_eng_inst) {
+	case 0:
+		/* Window A x axis start and end. */
+		CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC0_WINDOWA_X_CONTROL,
+				  CRTC_CRC0_WINDOWA_X_START, params->windowa_x_start,
+				  CRTC_CRC0_WINDOWA_X_END, params->windowa_x_end);
+
+		/* Window A y axis start and end. */
+		CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC0_WINDOWA_Y_CONTROL,
+				  CRTC_CRC0_WINDOWA_Y_START, params->windowa_y_start,
+				  CRTC_CRC0_WINDOWA_Y_END, params->windowa_y_end);
+
+		/* Window B x axis start and end. */
+		CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC0_WINDOWB_X_CONTROL,
+				  CRTC_CRC0_WINDOWB_X_START, params->windowb_x_start,
+				  CRTC_CRC0_WINDOWB_X_END, params->windowb_x_end);
+
+		/* Window B y axis start and end. */
+		CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC0_WINDOWB_Y_CONTROL,
+				  CRTC_CRC0_WINDOWB_Y_START, params->windowb_y_start,
+				  CRTC_CRC0_WINDOWB_Y_END, params->windowb_y_end);
+
+		/* Set crc mode and selection, and enable.*/
+		CRTC_REG_UPDATE_3(CRTC0_CRTC_CRC_CNTL,
+				  CRTC_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+				  CRTC_CRC0_SELECT, params->selection,
+				  CRTC_CRC_EN, 1);
+		break;
+	case 1:
+		/* Window A x axis start and end. */
+		CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC1_WINDOWA_X_CONTROL,
+				  CRTC_CRC1_WINDOWA_X_START, params->windowa_x_start,
+				  CRTC_CRC1_WINDOWA_X_END, params->windowa_x_end);
+
+		/* Window A y axis start and end. */
+		CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC1_WINDOWA_Y_CONTROL,
+				  CRTC_CRC1_WINDOWA_Y_START, params->windowa_y_start,
+				  CRTC_CRC1_WINDOWA_Y_END, params->windowa_y_end);
+
+		/* Window B x axis start and end. */
+		CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC1_WINDOWB_X_CONTROL,
+				  CRTC_CRC1_WINDOWB_X_START, params->windowb_x_start,
+				  CRTC_CRC1_WINDOWB_X_END, params->windowb_x_end);
+
+		/* Window B y axis start and end. */
+		CRTC_REG_UPDATE_2(CRTC0_CRTC_CRC1_WINDOWB_Y_CONTROL,
+				  CRTC_CRC1_WINDOWB_Y_START, params->windowb_y_start,
+				  CRTC_CRC1_WINDOWB_Y_END, params->windowb_y_end);
+
+		/* Set crc mode and selection, and enable */
+		CRTC_REG_UPDATE_3(CRTC0_CRTC_CRC_CNTL,
+				  CRTC_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+				  CRTC_CRC1_SELECT, params->selection,
+				  CRTC_CRC_EN, 1);
+		break;
+	default:
+		return false;
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 4807b9f9f5a5..9885cb3c310f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -141,6 +141,9 @@ struct crc_params {
 
 	bool continuous_mode;
 	bool enable;
+
+	uint8_t crc_eng_inst;
+	bool reset;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index a296bb89b106..19d5ebc6763c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -1470,37 +1470,71 @@ bool optc1_configure_crc(struct timing_generator *optc,
 	if (!optc1_is_tg_enabled(optc))
 		return false;
 
-	REG_WRITE(OTG_CRC_CNTL, 0);
+	if (!params->enable || params->reset)
+		REG_WRITE(OTG_CRC_CNTL, 0);
 
 	if (!params->enable)
 		return true;
 
 	/* Program frame boundaries */
-	/* Window A x axis start and end. */
-	REG_UPDATE_2(OTG_CRC0_WINDOWA_X_CONTROL,
-			OTG_CRC0_WINDOWA_X_START, params->windowa_x_start,
-			OTG_CRC0_WINDOWA_X_END, params->windowa_x_end);
-
-	/* Window A y axis start and end. */
-	REG_UPDATE_2(OTG_CRC0_WINDOWA_Y_CONTROL,
-			OTG_CRC0_WINDOWA_Y_START, params->windowa_y_start,
-			OTG_CRC0_WINDOWA_Y_END, params->windowa_y_end);
-
-	/* Window B x axis start and end. */
-	REG_UPDATE_2(OTG_CRC0_WINDOWB_X_CONTROL,
-			OTG_CRC0_WINDOWB_X_START, params->windowb_x_start,
-			OTG_CRC0_WINDOWB_X_END, params->windowb_x_end);
-
-	/* Window B y axis start and end. */
-	REG_UPDATE_2(OTG_CRC0_WINDOWB_Y_CONTROL,
-			OTG_CRC0_WINDOWB_Y_START, params->windowb_y_start,
-			OTG_CRC0_WINDOWB_Y_END, params->windowb_y_end);
-
-	/* Set crc mode and selection, and enable. Only using CRC0*/
-	REG_UPDATE_3(OTG_CRC_CNTL,
-			OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
-			OTG_CRC0_SELECT, params->selection,
-			OTG_CRC_EN, 1);
+	switch (params->crc_eng_inst) {
+	case 0:
+		/* Window A x axis start and end. */
+		REG_UPDATE_2(OTG_CRC0_WINDOWA_X_CONTROL,
+				OTG_CRC0_WINDOWA_X_START, params->windowa_x_start,
+				OTG_CRC0_WINDOWA_X_END, params->windowa_x_end);
+
+		/* Window A y axis start and end. */
+		REG_UPDATE_2(OTG_CRC0_WINDOWA_Y_CONTROL,
+				OTG_CRC0_WINDOWA_Y_START, params->windowa_y_start,
+				OTG_CRC0_WINDOWA_Y_END, params->windowa_y_end);
+
+		/* Window B x axis start and end. */
+		REG_UPDATE_2(OTG_CRC0_WINDOWB_X_CONTROL,
+				OTG_CRC0_WINDOWB_X_START, params->windowb_x_start,
+				OTG_CRC0_WINDOWB_X_END, params->windowb_x_end);
+
+		/* Window B y axis start and end. */
+		REG_UPDATE_2(OTG_CRC0_WINDOWB_Y_CONTROL,
+				OTG_CRC0_WINDOWB_Y_START, params->windowb_y_start,
+				OTG_CRC0_WINDOWB_Y_END, params->windowb_y_end);
+
+		/* Set crc mode and selection, and enable.*/
+		REG_UPDATE_3(OTG_CRC_CNTL,
+				OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+				OTG_CRC0_SELECT, params->selection,
+				OTG_CRC_EN, 1);
+		break;
+	case 1:
+		/* Window A x axis start and end. */
+		REG_UPDATE_2(OTG_CRC1_WINDOWA_X_CONTROL,
+				OTG_CRC1_WINDOWA_X_START, params->windowa_x_start,
+				OTG_CRC1_WINDOWA_X_END, params->windowa_x_end);
+
+		/* Window A y axis start and end. */
+		REG_UPDATE_2(OTG_CRC1_WINDOWA_Y_CONTROL,
+				OTG_CRC1_WINDOWA_Y_START, params->windowa_y_start,
+				OTG_CRC1_WINDOWA_Y_END, params->windowa_y_end);
+
+		/* Window B x axis start and end. */
+		REG_UPDATE_2(OTG_CRC1_WINDOWB_X_CONTROL,
+				OTG_CRC1_WINDOWB_X_START, params->windowb_x_start,
+				OTG_CRC1_WINDOWB_X_END, params->windowb_x_end);
+
+		/* Window B y axis start and end. */
+		REG_UPDATE_2(OTG_CRC1_WINDOWB_Y_CONTROL,
+				OTG_CRC1_WINDOWB_Y_START, params->windowb_y_start,
+				OTG_CRC1_WINDOWB_Y_END, params->windowb_y_end);
+
+		/* Set crc mode and selection, and enable.*/
+		REG_UPDATE_3(OTG_CRC_CNTL,
+				OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+				OTG_CRC1_SELECT, params->selection,
+				OTG_CRC_EN, 1);
+		break;
+	default:
+		return false;
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index dfa9364fe5a6..d21e82b927d0 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -183,34 +183,87 @@ static bool optc35_configure_crc(struct timing_generator *optc,
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
+	/* Cannot configure crc on a CRTC that is disabled */
 	if (!optc1_is_tg_enabled(optc))
 		return false;
-	REG_WRITE(OTG_CRC_CNTL, 0);
+
+	if (!params->enable || params->reset)
+		REG_WRITE(OTG_CRC_CNTL, 0);
+
 	if (!params->enable)
 		return true;
-	REG_UPDATE_2(OTG_CRC0_WINDOWA_X_CONTROL,
-			OTG_CRC0_WINDOWA_X_START, params->windowa_x_start,
-			OTG_CRC0_WINDOWA_X_END, params->windowa_x_end);
-	REG_UPDATE_2(OTG_CRC0_WINDOWA_Y_CONTROL,
-			OTG_CRC0_WINDOWA_Y_START, params->windowa_y_start,
-			OTG_CRC0_WINDOWA_Y_END, params->windowa_y_end);
-	REG_UPDATE_2(OTG_CRC0_WINDOWB_X_CONTROL,
-			OTG_CRC0_WINDOWB_X_START, params->windowb_x_start,
-			OTG_CRC0_WINDOWB_X_END, params->windowb_x_end);
-	REG_UPDATE_2(OTG_CRC0_WINDOWB_Y_CONTROL,
-			OTG_CRC0_WINDOWB_Y_START, params->windowb_y_start,
-			OTG_CRC0_WINDOWB_Y_END, params->windowb_y_end);
-	if (optc1->base.ctx->dc->debug.otg_crc_db && optc1->tg_mask->OTG_CRC_WINDOW_DB_EN != 0) {
-		REG_UPDATE_4(OTG_CRC_CNTL,
-				OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
-				OTG_CRC0_SELECT, params->selection,
-				OTG_CRC_EN, 1,
-				OTG_CRC_WINDOW_DB_EN, 1);
-	} else
-		REG_UPDATE_3(OTG_CRC_CNTL,
-				OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
-				OTG_CRC0_SELECT, params->selection,
-				OTG_CRC_EN, 1);
+
+	/* Program frame boundaries */
+	switch (params->crc_eng_inst) {
+	case 0:
+		/* Window A x axis start and end. */
+		REG_UPDATE_2(OTG_CRC0_WINDOWA_X_CONTROL,
+				OTG_CRC0_WINDOWA_X_START, params->windowa_x_start,
+				OTG_CRC0_WINDOWA_X_END, params->windowa_x_end);
+
+		/* Window A y axis start and end. */
+		REG_UPDATE_2(OTG_CRC0_WINDOWA_Y_CONTROL,
+				OTG_CRC0_WINDOWA_Y_START, params->windowa_y_start,
+				OTG_CRC0_WINDOWA_Y_END, params->windowa_y_end);
+
+		/* Window B x axis start and end. */
+		REG_UPDATE_2(OTG_CRC0_WINDOWB_X_CONTROL,
+				OTG_CRC0_WINDOWB_X_START, params->windowb_x_start,
+				OTG_CRC0_WINDOWB_X_END, params->windowb_x_end);
+
+		/* Window B y axis start and end. */
+		REG_UPDATE_2(OTG_CRC0_WINDOWB_Y_CONTROL,
+				OTG_CRC0_WINDOWB_Y_START, params->windowb_y_start,
+				OTG_CRC0_WINDOWB_Y_END, params->windowb_y_end);
+
+		if (optc1->base.ctx->dc->debug.otg_crc_db && optc1->tg_mask->OTG_CRC_WINDOW_DB_EN != 0)
+			REG_UPDATE_4(OTG_CRC_CNTL,
+					OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+					OTG_CRC0_SELECT, params->selection,
+					OTG_CRC_EN, 1,
+					OTG_CRC_WINDOW_DB_EN, 1);
+		else
+			REG_UPDATE_3(OTG_CRC_CNTL,
+					OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+					OTG_CRC0_SELECT, params->selection,
+					OTG_CRC_EN, 1);
+		break;
+	case 1:
+		/* Window A x axis start and end. */
+		REG_UPDATE_2(OTG_CRC1_WINDOWA_X_CONTROL,
+				OTG_CRC1_WINDOWA_X_START, params->windowa_x_start,
+				OTG_CRC1_WINDOWA_X_END, params->windowa_x_end);
+
+		/* Window A y axis start and end. */
+		REG_UPDATE_2(OTG_CRC1_WINDOWA_Y_CONTROL,
+				OTG_CRC1_WINDOWA_Y_START, params->windowa_y_start,
+				OTG_CRC1_WINDOWA_Y_END, params->windowa_y_end);
+
+		/* Window B x axis start and end. */
+		REG_UPDATE_2(OTG_CRC1_WINDOWB_X_CONTROL,
+				OTG_CRC1_WINDOWB_X_START, params->windowb_x_start,
+				OTG_CRC1_WINDOWB_X_END, params->windowb_x_end);
+
+		/* Window B y axis start and end. */
+		REG_UPDATE_2(OTG_CRC1_WINDOWB_Y_CONTROL,
+				OTG_CRC1_WINDOWB_Y_START, params->windowb_y_start,
+				OTG_CRC1_WINDOWB_Y_END, params->windowb_y_end);
+
+		if (optc1->base.ctx->dc->debug.otg_crc_db && optc1->tg_mask->OTG_CRC_WINDOW_DB_EN != 0)
+			REG_UPDATE_4(OTG_CRC_CNTL,
+					OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+					OTG_CRC1_SELECT, params->selection,
+					OTG_CRC_EN, 1,
+					OTG_CRC_WINDOW_DB_EN, 1);
+		else
+			REG_UPDATE_3(OTG_CRC_CNTL,
+					OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+					OTG_CRC1_SELECT, params->selection,
+					OTG_CRC_EN, 1);
+		break;
+	default:
+		return false;
+	}
 	return true;
 }
 
-- 
2.34.1

