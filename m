Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4892C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D79512A8F1;
	Thu, 30 Jun 2022 19:14:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2797212A696
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwo0g9E5VtSJUui2SrXnVnpXDft5OGRTWjVQ8DrznePRciB0TxPKnFkSWHccB2uFjMc+WbrZCZRgtuhnQ+0MTQMlaprs21U3vhfBha77rYHjBAeKw77O5CeGaPDHTWeH622fabkVfjdfZiscu/2uri3ZGVaefShiTwkTsmYiaE3ry2Jjere7KHBXiBlyCjAaY7GcHxBQ95Ft9T+rPZI+bdCNwR4BI61qVaJv4O/5TEXVU0+HOMDnY9M1lFbzcumnNul+l1ZgN5UK0e+A/lmOaEndV5dXecZVquL65CNF+Q5/C8YuK2dd0yPYs50y7Rz5kCaJDCVBFvpTUWpq1HwtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r1UtFPDt7qOEWr9VFc22U8jRqWMTsnzOirGdItyJ84=;
 b=d11RQM+E3btXBKabU0bM8mO5IejrXKker+yJ5snRcBVfIVxLgHw72Uq1148dfrdrBhsvPsszyMdcfB7tgGYEwAzq3xT9b6vz/UXAghWMncx0dtsigvdrNBfJ4yPoObnSWZTmTL02COzyExgiBC5hhieU6BFlJuD9cPt+t71EiQ3ENBYsTr6FRkZxyWh5dXXcy3nVocIonhw+bdZCTGp7q920EdrLu/UP8xqhFosGdwQzsmZ8EaLvuGclhARsRttaSHoIsV/Y4b1ZXkicqjmuUI2syHwMLroiBibRNpilhkA7OE/yUrphBQ+4syJ5SG8g+P5zhZfALYcPLNr5tGe/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r1UtFPDt7qOEWr9VFc22U8jRqWMTsnzOirGdItyJ84=;
 b=4Z9JRo0zUM00G8I0Lk3IjkoHARpPVem4oyAunSjJ1+012fcoDNZZjWvpUmaR2vWuphtF9/ZlWKi+uH3qgH28ykq6Jf7OQivWzq/nMGjzr5QttY/GLyKNu3aB2s3gYYknjuwTIP2Kl2XkE2aeE5bbpyiMiJA/kWdM3lmAO2y9I+w=
Received: from BN0PR04CA0180.namprd04.prod.outlook.com (2603:10b6:408:eb::35)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 19:14:12 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::d8) by BN0PR04CA0180.outlook.office365.com
 (2603:10b6:408:eb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:11 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/40] drm/amd/display: Program ACP related register
Date: Thu, 30 Jun 2022 15:13:03 -0400
Message-ID: <20220630191322.909650-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beea5332-5b66-40ff-b289-08da5accb711
X-MS-TrafficTypeDiagnostic: MW3PR12MB4346:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kw/Q2LtRYFJhL4Fl5V9B7Iy+8Y/YKjZ2sdsMbZWnGwLGWbtjtp7/tVkvlqIC8skp0BhoIEI7qPiCxSiZNKwhOuFLZ/e7u5YMwcTVCOlQw7ERy18d0TVGh5kQglhyiTuVbPLHylzkT434V0En9vzBduTtYKHDarawlTFeEmbWcprE/W1wjGj/1w3y6opsv1KmncPk7nlG1ZlmfFYOx612enea7OPNcfwY5RwFlORz0+K9UMJPK0Q/xOS8IXzleQuiiWuIh+HBTDJUOjCpgVpbO21k8se+QX+1WuxRkqFONec17l+TsxZfx0SSAuWvG5dgkSuVc0z1F70q3z3DXEqla+S5Pf/Rw08M/rS7SMb21W2JI+CoGEl2Z2titERAVqF7GH+3nPZw5b6Hf3+akQ7QE29O0s2HqaRyyL8wlyc7RH4f1GNkQ96JVQEC1Wl62f/qTYBA4VDX+2ehqYm0/Ja+x9x+9A+S1igwQwh9wTSlrSxmzwj+qCcqEnVJ5JnDtX498oWWjjQz7lRKzqmTTAYUgxTSR22U3kz4NjGdEchLjaH5p4wAG0AZnKoub6LTY5kCiSRGCwJqePOhF/AfkAsfC2DblXx8chp4rbgSycG/BmNMBCleItS/MAOjHBKQQdu8J7sxfHcDCH0BYygN6tsSi+bx2bYiqxiHAq1tz1lFz1xfkA5gwckLwturoxggOrl6ycQivfVYfglrJBtmgXL9Lp4zebRHnw6Meyk6pv9b9mFQIlWWsxzizKVLeDQVbQIQWYu/qcBwdIAJ2trkpoj8LS6/Gz4soCL6rQ24pRg0dbs8pqt3Kx60GrBg8PstNoRaRec/fI30TIbtpbpQ6LkKZ3hGzv2nYNtTjCKurWTP3uw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(46966006)(40470700004)(1076003)(6666004)(30864003)(40480700001)(54906003)(2616005)(4326008)(186003)(36860700001)(6916009)(356005)(36756003)(81166007)(316002)(82310400005)(82740400003)(40460700003)(41300700001)(70206006)(47076005)(83380400001)(70586007)(26005)(8676002)(86362001)(5660300002)(7696005)(8936002)(478600001)(336012)(16526019)(426003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:11.6783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beea5332-5b66-40ff-b289-08da5accb711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alan Liu <HaoPing.Liu@amd.com>

- Setup the shift and mask of HDMI_ACP_SEND register
- Program the register in hdmi stream encoder
- Also update ACP register in azalia configuration

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c   | 11 +++++++++++
 .../drm/amd/display/dc/dce/dce_stream_encoder.c  |  3 ++-
 .../drm/amd/display/dc/dce/dce_stream_encoder.h  | 14 ++++++--------
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c  |  3 ++-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h  | 16 ++--------------
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c  |  1 -
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c  |  4 +++-
 .../display/dc/dcn30/dcn30_dio_stream_encoder.h  |  6 ++----
 .../drm/amd/display/dc/inc/hw/stream_encoder.h   |  1 +
 .../amd/include/asic_reg/dce/dce_6_0_sh_mask.h   |  2 ++
 10 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 70eaac017624..c06888add4a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -486,6 +486,17 @@ void dce_aud_az_configure(
 
 	AZ_REG_WRITE(AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER, value);
 
+	/*  ACP Data - Supports AI  */
+	value = AZ_REG_READ(AZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA);
+
+	set_reg_field_value(
+		value,
+		audio_info->flags.info.SUPPORT_AI,
+		AZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA,
+		SUPPORTS_AI);
+
+	AZ_REG_WRITE(AZALIA_F0_CODEC_PIN_CONTROL_ACP_DATA, value);
+
 	/*  Audio Descriptors   */
 	/* pass through all formats */
 	for (format_index = 0; format_index < AUDIO_FORMAT_CODE_COUNT;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index a8c92b517df1..f7e1027d4b3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -33,7 +33,6 @@
 #define DC_LOGGER \
 		enc110->base.ctx->logger
 
-
 #define REG(reg)\
 	(enc110->regs->reg)
 
@@ -635,6 +634,8 @@ static void dce110_stream_encoder_hdmi_set_stream_attribute(
 		HDMI_GC_SEND, 1,
 		HDMI_NULL_SEND, 1);
 
+	REG_UPDATE(HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, 0);
+
 	/* following belongs to audio */
 	REG_UPDATE(HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, 1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
index f9cdf2b5242c..cc5020a8e1e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
@@ -115,7 +115,7 @@
 #define SE_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
 
-#define SE_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(mask_sh)\
+#define SE_COMMON_MASK_SH_LIST_DCE_COMMON(mask_sh)\
 	SE_SF(AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC_INDEX, mask_sh),\
 	SE_SF(AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC0_UPDATE, mask_sh),\
 	SE_SF(AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC2_UPDATE, mask_sh),\
@@ -140,6 +140,7 @@
 	SE_SF(HDMI_VBI_PACKET_CONTROL, HDMI_GC_CONT, mask_sh),\
 	SE_SF(HDMI_VBI_PACKET_CONTROL, HDMI_GC_SEND, mask_sh),\
 	SE_SF(HDMI_VBI_PACKET_CONTROL, HDMI_NULL_SEND, mask_sh),\
+	SE_SF(HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, mask_sh),\
 	SE_SF(HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, mask_sh),\
 	SE_SF(AFMT_INFOFRAME_CONTROL0, AFMT_AUDIO_INFO_UPDATE, mask_sh),\
 	SE_SF(HDMI_INFOFRAME_CONTROL1, HDMI_AUDIO_INFO_LINE, mask_sh),\
@@ -202,10 +203,7 @@
 	SE_SF(AFMT_AUDIO_PACKET_CONTROL, AFMT_AUDIO_SAMPLE_SEND, mask_sh),\
 	SE_SF(DIG_FE_CNTL, DIG_SOURCE_SELECT, mask_sh)
 
-#define SE_COMMON_MASK_SH_LIST_DCE_COMMON(mask_sh)\
-	SE_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(mask_sh)
-
-#define SE_COMMON_MASK_SH_LIST_SOC_BASE(mask_sh)\
+#define SE_COMMON_MASK_SH_LIST_SOC(mask_sh)\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC_INDEX, mask_sh),\
 	SE_SF(DIG0_AFMT_GENERIC_HDR, AFMT_GENERIC_HB0, mask_sh),\
 	SE_SF(DIG0_AFMT_GENERIC_HDR, AFMT_GENERIC_HB1, mask_sh),\
@@ -227,6 +225,7 @@
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_CONT, mask_sh),\
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_NULL_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, mask_sh),\
 	SE_SF(DIG0_AFMT_INFOFRAME_CONTROL0, AFMT_AUDIO_INFO_UPDATE, mask_sh),\
 	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL1, HDMI_AUDIO_INFO_LINE, mask_sh),\
@@ -288,9 +287,6 @@
 	SE_SF(DIG0_DIG_FE_CNTL, DIG_STEREOSYNC_GATE_EN, mask_sh),\
 	SE_SF(DIG0_DIG_FE_CNTL, DIG_SOURCE_SELECT, mask_sh)
 
-#define SE_COMMON_MASK_SH_LIST_SOC(mask_sh)\
-	SE_COMMON_MASK_SH_LIST_SOC_BASE(mask_sh)
-
 #define SE_COMMON_MASK_SH_LIST_DCE80_100(mask_sh)\
 	SE_COMMON_MASK_SH_LIST_DCE_COMMON(mask_sh),\
 	SE_SF(TMDS_CNTL, TMDS_PIXEL_ENCODING, mask_sh),\
@@ -414,6 +410,7 @@ struct dce_stream_encoder_shift {
 	uint8_t HDMI_GC_SEND;
 	uint8_t HDMI_NULL_SEND;
 	uint8_t HDMI_DATA_SCRAMBLE_EN;
+	uint8_t HDMI_ACP_SEND;
 	uint8_t HDMI_AUDIO_INFO_SEND;
 	uint8_t AFMT_AUDIO_INFO_UPDATE;
 	uint8_t HDMI_AUDIO_INFO_LINE;
@@ -545,6 +542,7 @@ struct dce_stream_encoder_mask {
 	uint32_t HDMI_GC_SEND;
 	uint32_t HDMI_NULL_SEND;
 	uint32_t HDMI_DATA_SCRAMBLE_EN;
+	uint32_t HDMI_ACP_SEND;
 	uint32_t HDMI_AUDIO_INFO_SEND;
 	uint32_t AFMT_AUDIO_INFO_UPDATE;
 	uint32_t HDMI_AUDIO_INFO_LINE;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 92f474e6a96b..64640c6b1c45 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -37,7 +37,6 @@
 #define DC_LOGGER \
 		enc1->base.ctx->logger
 
-
 #define REG(reg)\
 	(enc1->regs->reg)
 
@@ -597,6 +596,8 @@ void enc1_stream_encoder_hdmi_set_stream_attribute(
 		HDMI_GC_SEND, 1,
 		HDMI_NULL_SEND, 1);
 
+	REG_UPDATE(HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, 0);
+
 	/* following belongs to audio */
 	REG_UPDATE(HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, 1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index aa4f41745be4..9d5e2a7848dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -194,7 +194,7 @@ struct dcn10_stream_enc_registers {
 #define SE_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
 
-#define SE_COMMON_MASK_SH_LIST_SOC_BASE(mask_sh)\
+#define SE_COMMON_MASK_SH_LIST_SOC(mask_sh)\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC_INDEX, mask_sh),\
 	SE_SF(DIG0_AFMT_GENERIC_HDR, AFMT_GENERIC_HB0, mask_sh),\
 	SE_SF(DIG0_AFMT_GENERIC_HDR, AFMT_GENERIC_HB1, mask_sh),\
@@ -211,6 +211,7 @@ struct dcn10_stream_enc_registers {
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_CONT, mask_sh),\
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_NULL_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, mask_sh),\
 	SE_SF(DIG0_AFMT_INFOFRAME_CONTROL0, AFMT_AUDIO_INFO_UPDATE, mask_sh),\
 	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL1, HDMI_AUDIO_INFO_LINE, mask_sh),\
@@ -339,15 +340,6 @@ struct dcn10_stream_enc_registers {
 	SE_SF(DIG0_DIG_FE_CNTL, DIG_SOURCE_SELECT, mask_sh),\
 	SE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
-#define SE_COMMON_MASK_SH_LIST_SOC(mask_sh)\
-	SE_COMMON_MASK_SH_LIST_SOC_BASE(mask_sh),\
-	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, mask_sh)
-#else
-#define SE_COMMON_MASK_SH_LIST_SOC(mask_sh)\
-	SE_COMMON_MASK_SH_LIST_SOC_BASE(mask_sh)
-#endif
-
 #define SE_COMMON_MASK_SH_LIST_DCN10(mask_sh)\
 	SE_COMMON_MASK_SH_LIST_SOC(mask_sh),\
 	SE_SF(DIG0_HDMI_GENERIC_PACKET_CONTROL0, HDMI_GENERIC0_CONT, mask_sh),\
@@ -586,9 +578,7 @@ struct dcn10_stream_enc_registers {
 
 struct dcn10_stream_encoder_shift {
 	SE_REG_FIELD_LIST_DCN1_0(uint8_t);
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 	uint8_t HDMI_ACP_SEND;
-#endif
 	SE_REG_FIELD_LIST_DCN2_0(uint8_t);
 	SE_REG_FIELD_LIST_DCN3_0(uint8_t);
 	SE_REG_FIELD_LIST_DCN3_2(uint8_t);
@@ -597,9 +587,7 @@ struct dcn10_stream_encoder_shift {
 
 struct dcn10_stream_encoder_mask {
 	SE_REG_FIELD_LIST_DCN1_0(uint32_t);
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
 	uint32_t HDMI_ACP_SEND;
-#endif
 	SE_REG_FIELD_LIST_DCN2_0(uint32_t);
 	SE_REG_FIELD_LIST_DCN3_0(uint32_t);
 	SE_REG_FIELD_LIST_DCN3_2(uint32_t);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index e8f5c01688ec..b40489e678f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -35,7 +35,6 @@
 #define DC_LOGGER \
 		enc1->base.ctx->logger
 
-
 #define REG(reg)\
 	(enc1->regs->reg)
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 25e5c3bc1be9..17df53793c92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -35,7 +35,6 @@
 #define DC_LOGGER \
 		enc1->base.ctx->logger
 
-
 #define REG(reg)\
 	(enc1->regs->reg)
 
@@ -652,6 +651,9 @@ static void enc3_stream_encoder_hdmi_set_stream_attribute(
 		HDMI_GC_SEND, 1,
 		HDMI_NULL_SEND, 1);
 
+	/* Disable Audio Content Protection packet transmission */
+	REG_UPDATE(HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, 0);
+
 	/* following belongs to audio */
 	/* Enable Audio InfoFrame packet transmission. */
 	REG_UPDATE(HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, 1);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
index d2207b35f15f..54ee230e7f98 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
@@ -112,7 +112,7 @@
 	SRI(DIG_CLOCK_PATTERN, DIG, id)
 
 
-#define SE_COMMON_MASK_SH_LIST_DCN30_BASE(mask_sh)\
+#define SE_COMMON_MASK_SH_LIST_DCN30(mask_sh)\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_ENCODING, mask_sh),\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_COMPONENT_DEPTH, mask_sh),\
 	SE_SF(DIG0_HDMI_CONTROL, HDMI_PACKET_GEN_VERSION, mask_sh),\
@@ -124,6 +124,7 @@
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_CONT, mask_sh),\
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_NULL_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL1, HDMI_AUDIO_INFO_LINE, mask_sh),\
 	SE_SF(DIG0_HDMI_GC, HDMI_GC_AVMUTE, mask_sh),\
@@ -273,9 +274,6 @@
 	SE_SF(DP0_DP_SEC_FRAMING4, DP_SST_SDP_SPLITTING, mask_sh),\
 	SE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh)
 
-#define SE_COMMON_MASK_SH_LIST_DCN30(mask_sh)\
-	SE_COMMON_MASK_SH_LIST_DCN30_BASE(mask_sh)
-
 void dcn30_dio_stream_encoder_construct(
 	struct dcn10_stream_encoder *enc1,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index e04a51a57c93..456dbe9f2264 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -30,6 +30,7 @@
 
 #include "audio_types.h"
 #include "hw_shared.h"
+#include "dc_link.h"
 
 struct dc_bios;
 struct dc_context;
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
index 41c4a46ce357..bd8085ec54ed 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
@@ -7486,6 +7486,8 @@
 #define HDMI_VBI_PACKET_CONTROL__HDMI_GC_SEND__SHIFT 0x00000004
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT_MASK 0x00000200L
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_CONT__SHIFT 0x00000009
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND_MASK 0x1000
+#define HDMI_VBI_PACKET_CONTROL__HDMI_ACP_SEND__SHIFT 0xc
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE_MASK 0x003f0000L
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_LINE__SHIFT 0x00000010
 #define HDMI_VBI_PACKET_CONTROL__HDMI_ISRC_SEND_MASK 0x00000100L
-- 
2.25.1

