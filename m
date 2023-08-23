Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EE2EE49B0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02FB10E442;
	Wed, 23 Aug 2023 15:51:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D71010E43C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLI9ZU3r52f8ANssUdHpKoxljUA8EpoDZ+ALUlZJOJEc2j8hHZFUSp3sPxT/Bt69tpldhDRhP6QsgSQ4k21gItyrcOysNh2gSPg+edoq/WNNhzDnIubsef7roN6GFTJa7ZkC77vtetYizUGF+tS3/5O5+RFdnYwKJafjwoboGywLBGWrjKIf5kScegE1wbnKO6f278mTau3eKyLD/+i/hCs5Gt57WYZYwoY0JcwBs6owzne+c7hRQzq88MUDCSGjlQ9Hh4LtrRzrSm7LPc9EsVWkO/OLFlHyUK9MUUIai/AWNZiG8bFVP9MPuARSqnxLrrPugbbfp+LtLyHbeSFo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh9liOWBgxsSOigaN2pYoouYrJusvsuIS7g8Lm6YHl8=;
 b=UV98f5h1dG4zzYgdl5RUNb5m81UjHvm1ZIDM5qWiWvsAFKwGX9odA1MXhby4iTonbNRU2czrl9giLdXGkeNII8Bhsymbvb8/95eQPo0avMTyJhqlRToEfsIcdtchognFuwta49zAb43ofgfTd1t4HtMF1y7H4mwOSlVH2cFjl+50Amgq/TW9MCX+NgZ0VvhmX8gZQA7dUxYogfZY2cLK2hz7K850+RNOj8z2sSfDJId8auJzVpclAkBk+lmgW2SnWg8S60LWHfxtYsiUy/nMvRzRvfNhjyymMNAfteLXxgd0zNajFhH8Y9/8//8AaD0kLfIQh+FvWwJZ4mp4iQz5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh9liOWBgxsSOigaN2pYoouYrJusvsuIS7g8Lm6YHl8=;
 b=l4uN+ob/rRN3VD8IyDHs8XuX+qiQxoqUyczUhHszmCHHkCfvk/7wWgCPl4pMi6oTyZtE/HR950baX2ZOm6WYM6zp2Dd4F831+dk00F6qY/0c/Qh7OpreEPJnOU90t/RLb89h27HhiZyp9r6Hmy78eYp16F035pr7B+G6+/hUWsA=
Received: from DM6PR21CA0023.namprd21.prod.outlook.com (2603:10b6:5:174::33)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 15:51:12 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::61) by DM6PR21CA0023.outlook.office365.com
 (2603:10b6:5:174::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/35] drm/amd/display: Update DCN314 for DCN35 support
Date: Wed, 23 Aug 2023 11:50:22 -0400
Message-ID: <20230823155048.2526343-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: a6929236-2b3b-415f-9ec0-08dba3f0c6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rb60a2EwelrjYu/MEFxGn73G65LX9ACuUzsKCrLRnPDAJMTSbbRkX3lIVyOuSapY+GJcH+9Xt+1TMQYd0gmXyK3K31zxlM92QMTAoyNliw3+RawiVGiOMi9L+5iob3Ww+Pq5hI+NPGvjPvkwbUyVRFi1eEqaiJOiZZAq26eRQzwN98uEQ25FkpkL1ATrwkqbHxKrqmya3YFeUv5WGELPrsJbp3t0VDnWJdPqb8HMpyFOgspQ9Eg7lQRqA6LfoTjVkx4DGdPEO/28NMgwOrwgi9o5gyeXkMqcdehz+U6B14doek6xWARppSS/5UO9jgAP8ur+bo17TJs/Ms2FcU61IispCRgSp9bxaril1bOhxhx9T1tPETRehP5Hvo1efp8kBmw3hyhdn/zUJOnl/SYhl9o9ImLGhLeVApe6vlZEXqj8nNgfEfe16xD2RR740+TdLOrltZq7FKr006tDC9EMFb7zCbOj0r5/cxilPhSBTR/5exYp/SsYYL5y4S21nJ+yF27BvT0fNOUYLIKxNGuHz/Sf4wQ774TkdaRqmAw3U7Y8YfTzCLh+cGQVGvlCWMBoCvUHiXkF9esTveuWNQJ4CopMKVa8crrrYrMB20HdhJE26SoKtNsRkCVygQW2+k2/Oqgq8J45XWScbTHLzMpaIwtkN51vlZIQ6igUPyCCwBFniZqWPYjpmttTJ8N46WAiLJ6X3eYTSUD0A+sylBAIrE0B+g/r6hnp5a7GR4pQZH9moedukazTpqq5KqPx0mbfpXom7fNUsnVdmhu7gNQlAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(82310400011)(451199024)(186009)(1800799009)(40470700004)(36840700001)(46966006)(356005)(5660300002)(81166007)(40460700003)(2616005)(336012)(426003)(16526019)(7696005)(6666004)(26005)(36860700001)(15650500001)(8676002)(47076005)(83380400001)(4326008)(2906002)(1076003)(8936002)(6916009)(316002)(70586007)(478600001)(54906003)(82740400003)(70206006)(41300700001)(40480700001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:12.4372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6929236-2b3b-415f-9ec0-08dba3f0c6c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Update DCN314 files for DCN35 usage.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  2 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |  6 +++
 .../dc/dcn314/dcn314_dio_stream_encoder.c     | 22 +++++-----
 .../dc/dcn314/dcn314_dio_stream_encoder.h     | 40 +++++++++++++++++++
 4 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index ad3f019a784f..173837bbc941 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -245,7 +245,7 @@ static void dccg314_set_dtbclk_dto(
 	}
 }
 
-static void dccg314_set_dpstreamclk(
+void dccg314_set_dpstreamclk(
 		struct dccg *dccg,
 		enum streamclk_source src,
 		int otg_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
index 8e07d3151f91..60ea1d248deb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
@@ -203,4 +203,10 @@ struct dccg *dccg314_create(
 	const struct dccg_shift *dccg_shift,
 	const struct dccg_mask *dccg_mask);
 
+void dccg314_set_dpstreamclk(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		int otg_inst,
+		int dp_hpo_inst);
+
 #endif //__DCN314_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index 467509a65fa7..5b343f745cf3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -49,7 +49,7 @@
 #define CTX \
 	enc1->base.ctx
 
-static void enc314_reset_fifo(struct stream_encoder *enc, bool reset)
+void enc314_reset_fifo(struct stream_encoder *enc, bool reset)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 	uint32_t reset_val = reset ? 1 : 0;
@@ -64,7 +64,7 @@ static void enc314_reset_fifo(struct stream_encoder *enc, bool reset)
 		udelay(10);
 }
 
-static void enc314_enable_fifo(struct stream_encoder *enc)
+void enc314_enable_fifo(struct stream_encoder *enc)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
@@ -76,14 +76,14 @@ static void enc314_enable_fifo(struct stream_encoder *enc)
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 1);
 }
 
-static void enc314_disable_fifo(struct stream_encoder *enc)
+void enc314_disable_fifo(struct stream_encoder *enc)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 0);
 }
 
-static void enc314_dp_set_odm_combine(
+void enc314_dp_set_odm_combine(
 	struct stream_encoder *enc,
 	bool odm_combine)
 {
@@ -93,7 +93,7 @@ static void enc314_dp_set_odm_combine(
 }
 
 /* setup stream encoder in dvi mode */
-static void enc314_stream_encoder_dvi_set_stream_attribute(
+void enc314_stream_encoder_dvi_set_stream_attribute(
 	struct stream_encoder *enc,
 	struct dc_crtc_timing *crtc_timing,
 	bool is_dual_link)
@@ -133,7 +133,7 @@ static void enc314_stream_encoder_dvi_set_stream_attribute(
 }
 
 /* setup stream encoder in hdmi mode */
-static void enc314_stream_encoder_hdmi_set_stream_attribute(
+void enc314_stream_encoder_hdmi_set_stream_attribute(
 	struct stream_encoder *enc,
 	struct dc_crtc_timing *crtc_timing,
 	int actual_pix_clk_khz,
@@ -274,7 +274,7 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
-static void enc314_stream_encoder_dp_blank(
+void enc314_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc)
 {
@@ -285,7 +285,7 @@ static void enc314_stream_encoder_dp_blank(
 		enc314_disable_fifo(enc);
 }
 
-static void enc314_stream_encoder_dp_unblank(
+void enc314_stream_encoder_dp_unblank(
 		struct dc_link *link,
 		struct stream_encoder *enc,
 		const struct encoder_unblank_param *param)
@@ -380,7 +380,7 @@ static void enc314_stream_encoder_dp_unblank(
  *   sc_bytes_per_pixel: DP_DSC_BYTES_PER_PIXEL removed in DCN32
  *   dsc_slice_width: DP_DSC_SLICE_WIDTH removed in DCN32
  */
-static void enc314_dp_set_dsc_config(struct stream_encoder *enc,
+void enc314_dp_set_dsc_config(struct stream_encoder *enc,
 					enum optc_dsc_mode dsc_mode,
 					uint32_t dsc_bytes_per_pixel,
 					uint32_t dsc_slice_width)
@@ -393,7 +393,7 @@ static void enc314_dp_set_dsc_config(struct stream_encoder *enc,
 /* this function read dsc related register fields to be logged later in dcn10_log_hw_state
  * into a dcn_dsc_state struct.
  */
-static void enc314_read_state(struct stream_encoder *enc, struct enc_state *s)
+void enc314_read_state(struct stream_encoder *enc, struct enc_state *s)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
@@ -410,7 +410,7 @@ static void enc314_read_state(struct stream_encoder *enc, struct enc_state *s)
 	}
 }
 
-static void enc314_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container)
+void enc314_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.h
index ed0772387903..86548be591be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.h
@@ -312,4 +312,44 @@ void enc3_dp_set_dsc_pps_info_packet(
 	uint8_t *dsc_packed_pps,
 	bool immediate_update);
 
+void enc314_stream_encoder_dvi_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing,
+	bool is_dual_link);
+
+void enc314_stream_encoder_hdmi_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing,
+	int actual_pix_clk_khz,
+	bool enable_audio);
+
+void enc314_stream_encoder_dp_blank(
+	struct dc_link *link,
+	struct stream_encoder *enc);
+
+void enc314_stream_encoder_dp_unblank(
+		struct dc_link *link,
+		struct stream_encoder *enc,
+		const struct encoder_unblank_param *param);
+
+void enc314_reset_fifo(struct stream_encoder *enc, bool reset);
+
+void enc314_enable_fifo(struct stream_encoder *enc);
+
+void enc314_disable_fifo(struct stream_encoder *enc);
+
+void enc314_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container);
+
+void enc314_read_state(struct stream_encoder *enc, struct enc_state *s);
+
+void enc314_dp_set_odm_combine(
+	struct stream_encoder *enc,
+	bool odm_combine);
+
+void enc314_dp_set_dsc_config(
+	struct stream_encoder *enc,
+	enum optc_dsc_mode dsc_mode,
+	uint32_t dsc_bytes_per_pixel,
+	uint32_t dsc_slice_width);
+
 #endif /* __DC_DIO_STREAM_ENCODER_DCN314_H__ */
-- 
2.41.0

