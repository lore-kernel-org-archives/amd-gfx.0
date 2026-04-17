Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57F2F99C63
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 20:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4502910E0AA;
	Fri, 17 Apr 2026 20:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vKoEfVph";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A561D10E0AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 20:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7rVHkt6epYL2Pn+a8lq6OfNNhTZxrp9nhzroUsbUdgvXyio1fWcbcbrT2ivFwGKd1+DjS0lWcWb1/zQpPsIwQcUK+Ov85nh2en+U9esyhLzIDRNpL8g06efpHlDO66oXmRf0i2X42N4DEic2JwDdOqyE1Tw6hYPLjg+w7YFJY39dv5a9NVB6ewoIpHjZeZ/Wzazr4R4qQnc8IfzCab+KBJKoDyOSmYYRkK+Kd+PmB24NuqC+pTQzLh225MKxSloDx2TbbUhUh6wotISny+3RtWIXFOYtEMZmgto0vj88TrS6fSqDAwdemRKyFCTGQeF6HhOKuNglQk8Zo0JsGKEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQMZzjjh7NptyDtuImDuYwksDEB6YhfKV2qtC1/TW1Q=;
 b=ADoOewveIJSePt8uX/E6w5yjUjYI9EIsGpVt/4vMqK1DxqiqfODQ/mQbypGn+hsrtFi0AtMsRhagYDbT86+lGHcx9wzt4DkxV/eEiFxqxz3ys++9w/QNqCSS+QkTgbZpJqbOo26yWAwgD15B+lRXC3wslSBCNzrjx56g34r7p10mHWqLF+DbfweiJrmFgXvlI9l1GCZTn9skPBc7tMGmQfPQBfPA/NRubwQuC9vFjgWJK6ER9BCkeC3ZUO8gU6TXlEukr9SWjzTXVSnJ6i5x9IHeq1HT4ekeSFIJAwr1KOAEU+SIA64BinZAVRCxuLm/Gw2VjehvJEEU1XskQXhyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQMZzjjh7NptyDtuImDuYwksDEB6YhfKV2qtC1/TW1Q=;
 b=vKoEfVphKmiTNCGsvB9+HkVD7EfO8P1Xw2KeYesRk5eZyXwwltKud9w4Tegve97ZgSoe30/PqrNmYReofAD/hV9PQtMMQiCdj4XRuvJ5y+v+hSZlDC5BgP35375JAs7WDFHUW5DeXMITKVgVfONpGH5I3EPdz2k9fUu/Thpsv6s=
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 20:55:15 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::7a) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 20:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 20:55:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 15:55:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 13:55:10 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 17 Apr 2026 15:55:10 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Aurabindo.Pillai@amd.com>, <alex.hung@amd.com>, "Roman
 Li" <Roman.Li@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH v2] drm/amd/display: Restore analog connector support
Date: Fri, 17 Apr 2026 16:55:07 -0400
Message-ID: <20260417205507.1844039-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 1282f52e-9415-4f6d-7fa9-08de9cc39f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BYlw3uxwrzbRMIm6hnjEZ8/4obSIf6ZO45GcKNBhfBZxK9uWAWOts/JU0L369MdECAVAVyLqJfbiroPwiUNQw+fZSUm1zJQc/ETLCVF87Vc7jWVZR6VR7d1+xve/75wrrZNBCADE3qcoauy+mdzKinhMZbx3nuWKq7nMK6SyC75crl7rHQKBRr8/dK4gaxu15brnSpFeglLmLUvFZxrOmSR5ddUzKQwoes1IF0Jb7H3TvSkdfKwmoVxf2UBZHLdKsNcjzbAr2wBhLi8eaCzw9WEW8ia9cvdfuifqPUTQkID0kcO0ZL8qf8CjSNBfo7hooIUoe1/AUyj161eaEvXwxBtWLqd4ir5aGhAs89mCbpd1r5s4jmrNNzjkqVPQ0dMpy90d5d/De5UgSjtJMMquWRZMhCKi0H7an1x25KDu4k0vFg2cLA/XJpOfHCslAaeKJePDiDGUAw0O7adeK6YGbLQCkZ9TeHIQ00/VGS1RyctzBDW/GVnvMvoDEqCEHRjldPWoJsJtDtfn07k3faR5Qmx1znWiLnQl5+xNCUlHwZTPvcjQ5kty57Q+nPGjsR4XZC5jOjsMeqwEnbjBg/JQiB7URp+3HG8qTfGYlGyCI7lBOa+Xy30aIZpfMU+vvsL0bMgLloj1iQ3xA4FxlMyADdDbv+sHYxD/ATk8ktKn+9rUbv3n9tGrE7UXKj+Ac9N5b9WpiToRraLuVzTHHenz2g9rFUy5AvDI/V5UN/cRXghztR1b78KvVZ2DIsH6hLNud9S3+iQDRwtX6zM9ggIqBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /RY96nwL3h7vLv6A3i5FIog44JcVfFTnbREkpf6kii+bekwQVkkn46aFGgail5z8MnqSgB37DtEedwscdybC1tyceykgG4vMnSW2A0YponT/GHIXWKLMwxzll12F5h8Iy4XdDKx79PP0OxUPdxa7AIBPWEWVUVZjVlpq/+jl/rR8P7G6NPF8PI1p/o/UlhuFLcMEkUBkK+mjxxtFNftbSyxOeqySPNwThStD57XvE+4HzkSIBeOGYOw6sHKv8jvPE/iZMJeuACLBkvif4THFpugFG+pRY9gKNWNUPvyfuaw7DNNa9fkYMmpRUuTj41+lTcqU7QDas2jKYMBHYAVrvNozRI7PNSd7gLOKGHCFeCZCXhdYURwqBFQ/Sffnh3R00T9CDzC6uG/pOOGQHZ6vrvo0ZG5UhvSytebM3yU5P1HrbjQ/UgPme5QNbRkcEM4Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:55:13.6195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1282f52e-9415-4f6d-7fa9-08de9cc39f40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
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

From: Roman Li <Roman.Li@amd.com>

[Why]
The analog connector support was accidentally removed,
causing a crash when connecting an analog monitor.

[How]
This patch restores the functions and pointers required for proper analog
and DP bridge encoder support on legacy GPUs.

V2: Restore the external encoder control functions.

Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")

Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5273ca09fe12..73fb808dc016 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -677,6 +677,48 @@ dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
 	bios->funcs->encoder_control(bios, &encoder_control);
 }
 
+static void
+dce110_external_encoder_control(enum bp_external_encoder_control_action action,
+				struct dc_link *link,
+				struct dc_crtc_timing *timing)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dc_bios *bios = link->ctx->dc_bios;
+	const struct dc_link_settings *link_settings = &link->cur_link_settings;
+	enum bp_result bp_result = BP_RESULT_OK;
+	struct bp_external_encoder_control ext_cntl = {
+		.action = action,
+		.connector_obj_id = link->link_enc->connector,
+		.encoder_id = link->ext_enc_id,
+		.lanes_number = link_settings->lane_count,
+		.link_rate = link_settings->link_rate,
+
+		/* Use signal type of the real link encoder, ie. DP */
+		.signal = link->connector_signal,
+
+		/* We don't know the timing yet when executing the SETUP action,
+		 * so use a reasonably high default value. It seems that ENABLE
+		 * can change the actual pixel clock but doesn't work with higher
+		 * pixel clocks than what SETUP was called with.
+		 */
+		.pixel_clock = timing ? timing->pix_clk_100hz / 10 : 300000,
+		.color_depth = timing ? timing->display_color_depth : COLOR_DEPTH_888,
+	};
+	DC_LOGGER_INIT(dc->ctx);
+
+	bp_result = bios->funcs->external_encoder_control(bios, &ext_cntl);
+
+	if (bp_result != BP_RESULT_OK)
+		DC_LOG_ERROR("Failed to execute external encoder action: 0x%x\n", action);
+}
+
+static void
+dce110_prepare_ddc(struct dc_link *link)
+{
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DDC_SETUP, link, NULL);
+}
+
 static bool
 dce110_dac_load_detect(struct dc_link *link)
 {
@@ -721,6 +763,9 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
 		dce110_dac_encoder_control(pipe_ctx, true);
+
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_ENABLE, link, timing);
 }
 
 static enum bp_result link_transmitter_control(
@@ -1221,6 +1266,9 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 
 	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
 		dce110_dac_encoder_control(pipe_ctx, false);
+
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DISABLE, link, NULL);
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
@@ -3376,6 +3424,15 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
 	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
 }
 
+static void dce110_enable_analog_link_output(
+		struct dc_link *link,
+		uint32_t pix_clk_100hz)
+{
+	link->link_enc->funcs->enable_analog_output(
+			link->link_enc,
+			pix_clk_100hz);
+}
+
 void dce110_enable_dp_link_output(
 		struct dc_link *link,
 		const struct link_resource *link_res,
@@ -3423,6 +3480,11 @@ void dce110_enable_dp_link_output(
 		}
 	}
 
+	if (link->ext_enc_id.id) {
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_INIT, link, NULL);
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_SETUP, link, NULL);
+	}
+
 	if (dc->link_srv->dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
 		if (dc->clk_mgr->funcs->notify_link_rate_change)
 			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
@@ -3513,8 +3575,10 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_analog_link_output = dce110_enable_analog_link_output,
 	.disable_link_output = dce110_disable_link_output,
 	.dac_load_detect = dce110_dac_load_detect,
+	.prepare_ddc = dce110_prepare_ddc,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
-- 
2.34.1

