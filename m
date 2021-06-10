Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DD5C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349A961263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349A961263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F426EDA1;
	Thu, 10 Jun 2021 16:29:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A036EDA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er0kmGkUMWSjxQHeLuzgv28f1GmmAaSAljOM2iFIEt0vUiuWlcc1chGzk+lE4purwGThNndzoqf1T8zWdTDGR8RyohQrwjS35bh8g4R7rI7NUOijtJsPdoRJwNmiwPzdCKY8QUIleAsh5mYtfNiX5FknYsa3ED+eHDuHB+/nVttkkaRCdottTm5+Hxg6a+pgbFDXH+/v87NIGK1+9oOIThtQsrTDYJrh0zuAqcdTxPVwpiKsj+Z/BhCbFNshetcZTLYrzHzi/AbfSkKts4+cdfTnIEKiUGFkqeBN2af7yHXyaXD9QlX/m8zSF/rOz7wgpvoKOrWx+Zh71vL1cKJ0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/ZWvdhL4abechvpA4uDgBdOkBOBRVWDO31cNZXHD5o=;
 b=ACxbCgdUmuEnpzaeah/tOArimEUE29y/eJ1k0Zq5tDlK0u0gfd/FZBko2crxg7MIc7p+Mi8K9sW01H3vG/Ypt3c6xbc8hVwBYKIk89XrQEdt45jAlm6n5RsaG8Ls1lp1d3n9G94H9CbVf33TzUFujOH3UxcIFVvbSdKSPDR/GLzry0STLhQWiiqd5hOq2D+YtbNu5X9uGet/uVIOWYs+Onq/cf68XQ7MXHgvfkCF+U7FlTkHJhYDB9mlwwHgdMOhnP+x/EdrvLt/1UbR9QBUKCw5EDc5Zxu8wKrkvUz857UdPY1VCHOe2LaWKQQ5HB+HBuA0qjHZ5frwLVrFC0qgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/ZWvdhL4abechvpA4uDgBdOkBOBRVWDO31cNZXHD5o=;
 b=mSMMaWrekE+iWKSiqZ6z4ujmiag8EWhz1x26HcB44iDQBIRootc7xlRrDlI2UplAj+/uh4N7d2fg28oT2YorYfkUNJuKOa7w/ubzetbGDzTOWwHz3hKRyA0/S2LcQl+yALBYFvwwgFgdMsA+9AnSm6A6m95JKK2TA66q6FB6ZEY=
Received: from MWHPR15CA0058.namprd15.prod.outlook.com (2603:10b6:301:4c::20)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:43 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::79) by MWHPR15CA0058.outlook.office365.com
 (2603:10b6:301:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:41 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:40 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/24] drm/amd/display: Add interface to get Calibrated Avg
 Level from FIFO
Date: Thu, 10 Jun 2021 12:28:36 -0400
Message-ID: <20210610162838.287723-23-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 198f5819-9f25-4cc8-4844-08d92c2cf3ac
X-MS-TrafficTypeDiagnostic: DM4PR12MB5087:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5087948D0D1909484492AFD9EB359@DM4PR12MB5087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jjLTYx/kzlulHVH3ytr5tVfT/FSK6dFmZQELsHDTqkMzPISIoMOKO1Gd75HtH9OpFpabSLkszZ/PaU/7aKSlF8KTrS+kSHlvZ+3u6vl+a9qf3pNWHNnCrJdIgPXAYz1zUKbkJ492o/9mHoYqk9V4775sICSFE/7ALjVktigg1xZKgUBQKAlwgIbwyfT7deEHah8ZZB0GY1O5B7wyFoFEdM92dgMmP7+DYmHMutvRPqgwbSCQz5DG5uJctqY3wtAZONkpJYB1/rT3u5aHI8gED46Ql3txmG+nOUfaD3fyEjdvauTXOAZfz6p7a5AmpgFPqNEY91iNCECifBUZdhVX4bWvSe0bgqYoI7GFaGzCAmXimRCl8SfU/XueOW3r/xs07pp4iAu0iH4FB2SKSWIEvudQ4wlcieb/4DrN4udWQCs6Ur5rWAxOc9ln1yM7XsdBwnuLOS6OgDdWQrjRoR9IZFfz+iSxynnP9VnQe2JFc5246y6lorYfUxSoHr/1CobyV+2pcnn1vfzuaZVoFA+R3m9LUkIFpisNIWptGzvnuuUw50DGUPUwD/IMSpg/wBNQ6ZptyQRqfLlBhbltw6KwF6XnQvo5K/7XaSpwMmdVZMfHogoHSLs4jmovt2rRACPZkkeLEM2CYly4Ux6Ul/KGypYjZeGiZh7Tp0kJ5agEDaZHovAvaS9YYVKemrVnwoK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(36860700001)(26005)(81166007)(186003)(83380400001)(82310400003)(47076005)(70206006)(2906002)(70586007)(356005)(36756003)(7696005)(6916009)(30864003)(5660300002)(8936002)(54906003)(86362001)(336012)(1076003)(6666004)(426003)(2616005)(4326008)(82740400003)(316002)(8676002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:42.6424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198f5819-9f25-4cc8-4844-08d92c2cf3ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Hardware has handed down a new sequence requiring the value of this
register be read from clk_mgr.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../display/dc/dcn10/dcn10_stream_encoder.h   | 24 +++++++++++++++++++
 .../display/dc/dcn20/dcn20_stream_encoder.c   | 12 ++++++++++
 .../display/dc/dcn20/dcn20_stream_encoder.h   |  3 +++
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  2 ++
 .../dc/dcn30/dcn30_dio_stream_encoder.h       | 12 ++++++++++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  3 +++
 .../include/asic_reg/dcn/dcn_3_0_1_sh_mask.h  |  2 ++
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |  2 ++
 8 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 76b334644f9e..0d86df97878c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -52,6 +52,7 @@
 	SRI(AFMT_60958_1, DIG, id), \
 	SRI(AFMT_60958_2, DIG, id), \
 	SRI(DIG_FE_CNTL, DIG, id), \
+	SRI(DIG_FIFO_STATUS, DIG, id), \
 	SRI(HDMI_CONTROL, DIG, id), \
 	SRI(HDMI_DB_CONTROL, DIG, id), \
 	SRI(HDMI_GC, DIG, id), \
@@ -124,6 +125,7 @@ struct dcn10_stream_enc_registers {
 	uint32_t AFMT_60958_2;
 	uint32_t DIG_FE_CNTL;
 	uint32_t DIG_FE_CNTL2;
+	uint32_t DIG_FIFO_STATUS;
 	uint32_t DP_MSE_RATE_CNTL;
 	uint32_t DP_MSE_RATE_UPDATE;
 	uint32_t DP_PIXEL_FORMAT;
@@ -266,6 +268,17 @@ struct dcn10_stream_enc_registers {
 	SE_SF(DIG0_DIG_FE_CNTL, TMDS_COLOR_FORMAT, mask_sh),\
 	SE_SF(DIG0_DIG_FE_CNTL, DIG_STEREOSYNC_SELECT, mask_sh),\
 	SE_SF(DIG0_DIG_FE_CNTL, DIG_STEREOSYNC_GATE_EN, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_LEVEL_ERROR, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_USE_OVERWRITE_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_OVERWRITE_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_ERROR_ACK, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_CAL_AVERAGE_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_MAXIMUM_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_MINIMUM_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_READ_CLOCK_SRC, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_CALIBRATED, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_FORCE_RECAL_AVERAGE, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_FORCE_RECOMP_MINMAX, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC_LOCK_STATUS, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC_CONFLICT, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC_CONFLICT_CLR, mask_sh),\
@@ -488,6 +501,17 @@ struct dcn10_stream_enc_registers {
 	type DP_VID_N_MUL;\
 	type DP_VID_M_DOUBLE_VALUE_EN;\
 	type DIG_SOURCE_SELECT;\
+	type DIG_FIFO_LEVEL_ERROR;\
+	type DIG_FIFO_USE_OVERWRITE_LEVEL;\
+	type DIG_FIFO_OVERWRITE_LEVEL;\
+	type DIG_FIFO_ERROR_ACK;\
+	type DIG_FIFO_CAL_AVERAGE_LEVEL;\
+	type DIG_FIFO_MAXIMUM_LEVEL;\
+	type DIG_FIFO_MINIMUM_LEVEL;\
+	type DIG_FIFO_READ_CLOCK_SRC;\
+	type DIG_FIFO_CALIBRATED;\
+	type DIG_FIFO_FORCE_RECAL_AVERAGE;\
+	type DIG_FIFO_FORCE_RECOMP_MINMAX;\
 	type DIG_CLOCK_PATTERN
 
 #define SE_REG_FIELD_LIST_DCN2_0(type) \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index 4075ae111530..e6307397e0d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -552,6 +552,17 @@ void enc2_stream_encoder_dp_set_stream_attribute(
 		DP_SST_SDP_SPLITTING, enable_sdp_splitting);
 }
 
+uint32_t enc2_get_fifo_cal_average_level(
+		struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	uint32_t fifo_level;
+
+	REG_GET(DIG_FIFO_STATUS,
+			DIG_FIFO_CAL_AVERAGE_LEVEL, &fifo_level);
+	return fifo_level;
+}
+
 static const struct stream_encoder_funcs dcn20_str_enc_funcs = {
 	.dp_set_odm_combine =
 		enc2_dp_set_odm_combine,
@@ -598,6 +609,7 @@ static const struct stream_encoder_funcs dcn20_str_enc_funcs = {
 	.dp_set_dsc_pps_info_packet = enc2_dp_set_dsc_pps_info_packet,
 	.set_dynamic_metadata = enc2_set_dynamic_metadata,
 	.hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
+	.get_fifo_cal_average_level = enc2_get_fifo_cal_average_level,
 };
 
 void dcn20_stream_encoder_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
index 9a881e639709..f3d1a0237bda 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
@@ -112,4 +112,7 @@ void enc2_set_dynamic_metadata(struct stream_encoder *enc,
 		uint32_t hubp_requestor_id,
 		enum dynamic_metadata_mode dmdata_mode);
 
+uint32_t enc2_get_fifo_cal_average_level(
+		struct stream_encoder *enc);
+
 #endif /* __DC_STREAM_ENCODER_DCN20_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 72bee637c1e4..8487516819ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -823,6 +823,8 @@ static const struct stream_encoder_funcs dcn30_str_enc_funcs = {
 	.dp_set_dsc_pps_info_packet = enc3_dp_set_dsc_pps_info_packet,
 	.set_dynamic_metadata = enc2_set_dynamic_metadata,
 	.hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
+
+	.get_fifo_cal_average_level = enc2_get_fifo_cal_average_level,
 };
 
 void dcn30_dio_stream_encoder_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
index 9566b9037458..e2c264ecb20f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
@@ -106,6 +106,7 @@
 	SRI(DP_SEC_METADATA_TRANSMISSION, DP, id), \
 	SRI(HDMI_METADATA_PACKET_CONTROL, DIG, id), \
 	SRI(DIG_FE_CNTL, DIG, id), \
+	SRI(DIG_FIFO_STATUS, DIG, id), \
 	SRI(DIG_CLOCK_PATTERN, DIG, id)
 
 
@@ -167,6 +168,17 @@
 	SE_SF(DIG0_DIG_FE_CNTL, TMDS_COLOR_FORMAT, mask_sh),\
 	SE_SF(DIG0_DIG_FE_CNTL, DIG_STEREOSYNC_SELECT, mask_sh),\
 	SE_SF(DIG0_DIG_FE_CNTL, DIG_STEREOSYNC_GATE_EN, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_LEVEL_ERROR, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_USE_OVERWRITE_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_OVERWRITE_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_ERROR_ACK, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_CAL_AVERAGE_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_MAXIMUM_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_MINIMUM_LEVEL, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_READ_CLOCK_SRC, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_CALIBRATED, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_FORCE_RECAL_AVERAGE, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_STATUS, DIG_FIFO_FORCE_RECOMP_MINMAX, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP4_ENABLE, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP5_ENABLE, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_GSP6_ENABLE, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 47c7e4c3a51b..564ea6a727b0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -237,6 +237,9 @@ struct stream_encoder_funcs {
 	void (*dp_set_odm_combine)(
 		struct stream_encoder *enc,
 		bool odm_combine);
+
+	uint32_t (*get_fifo_cal_average_level)(
+		struct stream_encoder *enc);
 };
 
 #endif /* STREAM_ENCODER_H_ */
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h
index 2a622c13817b..59155007c186 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h
@@ -29292,6 +29292,7 @@
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_OVERWRITE_LEVEL_MASK                                                   0x000000FCL
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_ERROR_ACK_MASK                                                         0x00000100L
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_CAL_AVERAGE_LEVEL_MASK                                                 0x0000FC00L
+#define DIG0_DIG_FIFO_STATUS__DIG_FIFO_MAXIMUM_LEVEL_MASK                                                     0x001F0000L
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_MINIMUM_LEVEL_MASK                                                     0x03C00000L
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_READ_CLOCK_SRC_MASK                                                    0x04000000L
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_CALIBRATED_MASK                                                        0x20000000L
@@ -34431,6 +34432,7 @@
 #define DIG3_DIG_FIFO_STATUS__DIG_FIFO_OVERWRITE_LEVEL__SHIFT                                                 0x2
 #define DIG3_DIG_FIFO_STATUS__DIG_FIFO_ERROR_ACK__SHIFT                                                       0x8
 #define DIG3_DIG_FIFO_STATUS__DIG_FIFO_CAL_AVERAGE_LEVEL__SHIFT                                               0xa
+#define DIG0_DIG_FIFO_STATUS__DIG_FIFO_MAXIMUM_LEVEL__SHIFT                                                   0x10
 #define DIG3_DIG_FIFO_STATUS__DIG_FIFO_MINIMUM_LEVEL__SHIFT                                                   0x16
 #define DIG3_DIG_FIFO_STATUS__DIG_FIFO_READ_CLOCK_SRC__SHIFT                                                  0x1a
 #define DIG3_DIG_FIFO_STATUS__DIG_FIFO_CALIBRATED__SHIFT                                                      0x1d
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
index 7b2e5833e345..e5fd0121ceff 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
@@ -33869,6 +33869,7 @@
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_OVERWRITE_LEVEL__SHIFT                                                 0x2
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_ERROR_ACK__SHIFT                                                       0x8
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_CAL_AVERAGE_LEVEL__SHIFT                                               0xa
+#define DIG0_DIG_FIFO_STATUS__DIG_FIFO_MAXIMUM_LEVEL__SHIFT                                                   0x10
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_MINIMUM_LEVEL__SHIFT                                                   0x16
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_READ_CLOCK_SRC__SHIFT                                                  0x1a
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_CALIBRATED__SHIFT                                                      0x1d
@@ -33879,6 +33880,7 @@
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_OVERWRITE_LEVEL_MASK                                                   0x000000FCL
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_ERROR_ACK_MASK                                                         0x00000100L
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_CAL_AVERAGE_LEVEL_MASK                                                 0x0000FC00L
+#define DIG0_DIG_FIFO_STATUS__DIG_FIFO_MAXIMUM_LEVEL_MASK                                                     0x001F0000L
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_MINIMUM_LEVEL_MASK                                                     0x03C00000L
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_READ_CLOCK_SRC_MASK                                                    0x04000000L
 #define DIG0_DIG_FIFO_STATUS__DIG_FIFO_CALIBRATED_MASK                                                        0x20000000L
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
