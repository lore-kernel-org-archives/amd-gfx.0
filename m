Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1292AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5982AFAE;
	Fri, 22 Jul 2022 20:37:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E982A5EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDi4irpXOsDMQrPVcQiHv0M4bDqX3g8qRJcUzxQYQLagLmce8M91vmxPdHrT+Ucswq6Ko538v2woFJ2qo834Qy9EDTydeu6h3xg30oDrpRCmVoC4UV1ns8tYyRxvzmAdlxaNtMRut4hrsaackd4fxEO8P6ZDSVth6nPp79WPw67pkKEUNm3p0KbQ9hWyNvr00VDvTVKOHNgQz71tYBBtm5dfZ4WLIAwjbJja4Lax2BwQHjh5B9DpQhebTuhIgfjAXcnBrZZpq57I5Ny6CtFiJ2ESnRCgFaAvB1HFDiDJUHVMzFyy1m5a851AapilN3vQexrZtLsZnNExReFKg5ogpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEEJe6MQwaYR3A0MTxp3o0bdSbEEk80RknQZxiMnkNw=;
 b=S/VWz5uHPEfC+TgjAZpuOH2yJ5myqO8x/KzCd+WAerRszz9QqZ7HBQrmKi62q7QTdbaYdog4/UIqZYUXdavRBOE+92dyHLSqW1FM39Titp3GCynYY02GNQsDAmq5UxP50hL50WLp0kOEy9HSr3mhVmU3pNhS6v8VBJG3TbTX1MsrNIwD7m5yJdExqkh0F49GfsO+i5+0I0bQTpY32REBlUzRGqUt/xOgs9DIhbKElGrrSfDG0MxLFJfcU13lVsFP85NjXjD/SYj6cex8+mXvW+28k/37Ye0xgQ49lA/6jg4xcbFCY88OVLBzGv9ll++0XwfpSCKPD3EjvtJcl/Et8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEEJe6MQwaYR3A0MTxp3o0bdSbEEk80RknQZxiMnkNw=;
 b=I4KwKQbeyXwhsDDUJVSSnctvNHccWW+v2sAb6mPqYl4LGvzCE3WD90in7oTb6d8Vcs6ZPvkNEkgtYChHD4iRZOOChP9rhYD+Z9Dh/OwOHav8cFWueTnZyS+pQXaqyZAvleUrWwe+5Gb3nya2d8g9M1HVgKSioyHxAsOgbmK/ttE=
Received: from MW4PR03CA0197.namprd03.prod.outlook.com (2603:10b6:303:b8::22)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:37:53 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::6) by MW4PR03CA0197.outlook.office365.com
 (2603:10b6:303:b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 20:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:37:53 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:37:49 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/31] drm/amd/display: Add enable/disable FIFO callbacks to
 stream setup
Date: Fri, 22 Jul 2022 14:31:08 -0600
Message-ID: <20220722203137.4043516-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d86916f9-9aad-43cd-6f81-08da6c220d3d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5132:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9v5hzitg1ns4l3ql/Sv6HZLqzwDQdLQoR1AhV5osQD/vPO1kT0W5iP4+3jrL/qx6K0m8qVHcUiESFCV+iEbs6yIeZNJRufO4bmJFaTZ1YVXjQjDELAc66c4fqAaX8oBv1+Ow8QmEsulG5iCD2aDq0v4ad1YKSgX+EkLnoODwk3w/5TM09c2TFPQ+ILW9ipWicaRAyxaCNgvCIaEy5Ua63aCa9dtu0m3qHHnrcxXs+oUqOGMj5hjZYHuJP5qxWHBtWcosiBHd+GhG5qf7M9Lz673nRjKhxKbPM4dKiWqj6JRHpJCFltd7uZR4ON4KZXdRbT6gKqXKj9tg663ebwxI/d3v9bm6yS+S5MequlDzuiNqekLx4ioMcP2i/lY4pUxy21i5H5pns/PaspodoROYXhk93L34mZTBxsf/hN4USVHPoXOsE9lzaC8rna3/W12nnw6Dg3Pfo8PovW5RirNgUWCc3kIHo2nkHukjFW2Ap7WU+WbB0RdcPoNQKuknXt/FUQ1NjRtB1ycR4Xnjn46m7WRmgvrc7pDblGbhcsirBBnM30RM9WOdUBlsDaUXSmEY0zNbYsYN/kKK/7MgGqbl/0ZuQnSwRmg2wVYuUSYaXAuST0/v6FSXHREWEfHk+VpsPNPKSNqMFkW9D0MVYWTnvz8uspbHi0IN1piBXcHdEGs9tai7FheluhHxVumjG5IIRKIKnnHtqkwIcxsmWBFTjw+e57eDUlWK4BwTxV+DMwdo6JcSpuI6d/9r0B8YAiCM5PT4V/kzkImdLRPFCBLLcu8OHXU0dv+PmpWyQtz6tlSwn9ltTUEhr1D6SRla2uk9YVjt6BDlJAzbcIcZwACJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(40470700004)(44832011)(5660300002)(8936002)(2906002)(36860700001)(41300700001)(82740400003)(356005)(47076005)(81166007)(336012)(4326008)(426003)(54906003)(70586007)(26005)(36756003)(6916009)(16526019)(316002)(1076003)(186003)(70206006)(40480700001)(478600001)(86362001)(6666004)(7696005)(2616005)(40460700003)(8676002)(83380400001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:37:53.1289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86916f9-9aad-43cd-6f81-08da6c220d3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <Michael.Strauss@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We don't write out attributes after disabling and re-enabling the link
on some monitors, causing some, but not all, HDMI displays to fail to
lightup on DCN314.

[How]
Firmware used to do this after DIG link setup.

Since firmware is no longer doing this to support USB4 and dynamic link
remapping we'll need to add this to driver in the equivalent paths.

New optional callbacks were created in the stream encoder interface and
implementations were added for DCN314.

Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../dc/dcn314/dcn314_dio_stream_encoder.c     | 38 +++++++++++++------
 .../amd/display/dc/inc/hw/stream_encoder.h    |  2 +
 .../drm/amd/display/dc/link/link_hwss_dio.c   |  7 ++++
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index 2dbfa1c234dd..b384f30395d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -50,6 +50,26 @@
 	enc1->base.ctx
 
 
+static void enc314_enable_fifo(struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	/* TODO: Confirm if we need to wait for DIG_SYMCLK_FE_ON */
+	REG_WAIT(DIG_FE_CNTL, DIG_SYMCLK_FE_ON, 1, 10, 5000);
+	REG_UPDATE_2(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 1, DIG_FIFO_READ_START_LEVEL, 0x7);
+	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 1, 10, 5000);
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 0);
+	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 0, 10, 5000);
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 1);
+}
+
+static void enc314_disable_fifo(struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	REG_UPDATE_2(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 0,
+		     DIG_FIFO_READ_START_LEVEL, 0);
+}
 
 static void enc314_dp_set_odm_combine(
 	struct stream_encoder *enc,
@@ -92,7 +112,7 @@ void enc314_stream_encoder_dvi_set_stream_attribute(
 
 		//DIG_SOURCE_SELECT is already set in dig_connect_to_otg
 
-		/* DIG_START is removed from the register spec */
+		enc314_enable_fifo(enc);
 	}
 
 	ASSERT(crtc_timing->pixel_encoding == PIXEL_ENCODING_RGB);
@@ -132,7 +152,7 @@ static void enc314_stream_encoder_hdmi_set_stream_attribute(
 
 		//DIG_SOURCE_SELECT is already set in dig_connect_to_otg
 
-		/* DIG_START is removed from the register spec */
+		enc314_enable_fifo(enc);
 	}
 
 	/* Configure pixel encoding */
@@ -302,16 +322,8 @@ static void enc314_stream_encoder_dp_unblank(
 
 	REG_UPDATE(DP_STEER_FIFO, DP_STEER_FIFO_RESET, 0);
 
-	/*
-	 * DIG Resync FIFO now needs to be explicitly enabled.
-	 * TODO: Confirm if we need to wait for DIG_SYMCLK_FE_ON
-	 */
-	REG_WAIT(DIG_FE_CNTL, DIG_SYMCLK_FE_ON, 1, 10, 5000);
-	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 1);
-	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 1, 10, 5000);
-	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 0);
-	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 0, 10, 5000);
-	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 1);
+	/* DIG Resync FIFO now needs to be explicitly enabled. */
+	enc314_enable_fifo(enc);
 
 	/* wait 100us for DIG/DP logic to prime
 	 * (i.e. a few video lines)
@@ -420,6 +432,8 @@ static const struct stream_encoder_funcs dcn314_str_enc_funcs = {
 	.set_dynamic_metadata = enc2_set_dynamic_metadata,
 	.hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
 
+	.enable_fifo = enc314_enable_fifo,
+	.disable_fifo = enc314_disable_fifo,
 	.set_input_mode = enc314_set_dig_input_mode,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 456dbe9f2264..42afa1952890 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -252,6 +252,8 @@ struct stream_encoder_funcs {
 
 	void (*set_input_mode)(
 		struct stream_encoder *enc, unsigned int pix_per_container);
+	void (*enable_fifo)(struct stream_encoder *enc);
+	void (*disable_fifo)(struct stream_encoder *enc);
 };
 
 struct hpo_dp_stream_encoder_state {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
index 776e822abcbb..5e92019539c8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
@@ -40,17 +40,24 @@ void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
 	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
 	link_enc->funcs->connect_dig_be_to_fe(link_enc,
 			pipe_ctx->stream_res.stream_enc->id, true);
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(pipe_ctx->stream->link,
 				DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
+	if (stream_enc->funcs->enable_fifo)
+		stream_enc->funcs->enable_fifo(stream_enc);
 }
 
 void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
 	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
+
+	if (stream_enc && stream_enc->funcs->disable_fifo)
+		stream_enc->funcs->disable_fifo(stream_enc);
 
 	link_enc->funcs->connect_dig_be_to_fe(
 			link_enc,
-- 
2.37.1

