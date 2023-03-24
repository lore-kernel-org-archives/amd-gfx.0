Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D68C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638DB10E4E3;
	Fri, 24 Mar 2023 06:52:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5041010E4E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALXhWMoUBEA6Qk8sMhk1I+uKtBHZCyZBTZPaewJ8YjdDfdZYERPUUqJMm8E/85eTWwZBvwCh1lMi19ffOtT2jUAoMDYmqchU2O8mDkPTOPFEuwtJaSpjN4lyXV1TnDuwYbBsACyC+5lhrX2iPhnZCQDNKEb42xTleRzC2m+1JJhB0c90xsaI8DfAa0ewd8KUISetJBtyrI0SCG2lFl9KskpVC6zGuGSQibwb9f+3v0XzNbVipcAC30MhLAKfku7Bnd+zlIueP0baVC5ReXKwobjMie4D8vOMd6a0m1KVNUhZx5QYcP7E9isEFHjEEYC1kLyLtYkqk6mF/sp6AFzzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByurUBZsUqWySedGn7WEftT26yNWh4WY4ouNkQthYC8=;
 b=JHhfRhvy2Ty69dYA7n1t2Yal7qTCWEjqxPIVkP6C3ZLY7hWfNWxoh4G8t5/52M8BjaW4tX6WdiE+2hqx2BD3ogaEQpalL3O1PUvZa+YJmRvy8/7aMPAodE6sHlw7IS1ThZ2frSMe6MTVSpfzu9Zpp+bMG0GBwBI8nnkTExofRKT96SnSW14hXBXH5NsRXSVa94cHsIuJc3POdo3Ouc1nvhPpuKkElLs+TuKwNHrghp8+SgSdKVHamc4bMQ2iq+le7rKd+wV/02FD93BqZdgarvNfLxo6/Shs2iMky3hPgnxwcfLDRwXIpo7FsJFKBhO5YlODUAdqCBE8i5LeImBLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByurUBZsUqWySedGn7WEftT26yNWh4WY4ouNkQthYC8=;
 b=EgEH+tDqXGwCWumFhFANTGJaHKICMpsAHqJjcr8QU6K3pj1yV/DHBPJ0q8rEsrQmZqoOJBxHDudi0P8JIAV9F0Wn43XdWVvYAY4Gs/as5W87Qan0+vCrxlzWe7g9xFHLnMVb+fgyW2Uv20VYp27XTh3LxZ3Tu75KW7guZIEBvts=
Received: from MW4PR03CA0153.namprd03.prod.outlook.com (2603:10b6:303:8d::8)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:52:26 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::2a) by MW4PR03CA0153.outlook.office365.com
 (2603:10b6:303:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39 via Frontend
 Transport; Fri, 24 Mar 2023 06:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Fri, 24 Mar 2023 06:52:17 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:52:11 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/19] drm/amd/display: update dig enable sequence
Date: Fri, 24 Mar 2023 02:50:58 -0400
Message-ID: <20230324065111.2782-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: b09a64a5-7091-4878-0906-08db2c345429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzZ2i4KNpH8HjDrPxi+jtBh7I6DX9jA8zWbyE8oFYayYwG9gFYCNbIf6PBc5qnieC6E8m/2xnefLsW6IP8k5NFraC4R4MZvFp/PNqFWxSB3D2VBsZa29/7y7JZ+1nGe42cpLK0BREi3xnVHyQrCfiZd1Zrz199vmy8p1l6oeebx9Oo3HwTHqo85H3pj4lxWoOA93HGLuyMvAqdcQuCzYowMUiXWnCT7izAAz0E5+u1eiKX5dcE51u7hYAfo3ZWkd+CRu0I4Zci8cp4j4IMP7Ij6WV0Ft5+6Ipto7mR/A+SEE3UvySrN0ECsNYs9A2qxsIaEbalPkiCExy31fk8MCXBAaPXfyof7OIQ9CnAtVjhEXDRCa9PkO6ydhREJKfrtJv3/EPPKEjk6vKywDRcglPttYLr0+lf1apVowHmOncOaVEJDYWe4TmqN8zQ0Z8cZInopOfKYEdF71akkhbnNSrTFKgqkHEG2ZcKSZt2Em6hpMwJTWYb1L2lUxv/VlBh/HYlo12xjXNlPeDAaKIaFEzaOtdaMLV44FBvTJmlK5N4WuY34Bg7dUuR6TQKYGWzuVnYfU6SuHiaax4kA9r/UnQgsNk4MoTwelF4m84RvauEIiTuqsZxLbIs+sHovvUI64jOMLzViduUe1CrS4Z++VkaQJ0xWJ0K60XM94r7ZAsAsvGDCAiO1Z9Lxp5uSdySEAjQASr77Td4B7wVsRJG1XpfvPImNvSBWF6Eb+XgysdMg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(70586007)(36860700001)(4326008)(6916009)(70206006)(8676002)(54906003)(41300700001)(44832011)(5660300002)(82740400003)(8936002)(47076005)(26005)(1076003)(81166007)(426003)(6666004)(316002)(186003)(336012)(16526019)(2616005)(83380400001)(36756003)(82310400005)(478600001)(40480700001)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:52:17.3865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09a64a5-7091-4878-0906-08db2c345429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
HW delta follow up

Reviewed-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../amd/display/dc/dcn32/dcn32_dio_stream_encoder.c   | 10 +++++-----
 .../amd/display/dc/dcn32/dcn32_dio_stream_encoder.h   |  8 ++++++++
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c       | 11 ++++++-----
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index d05e7655f603..2fef1419ae91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -274,10 +274,10 @@ static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_
 		dc->debug.enable_dp_dig_pixel_rate_div_policy;
 }
 
-static void enc32_stream_encoder_dp_unblank(
-        struct dc_link *link,
-		struct stream_encoder *enc,
-		const struct encoder_unblank_param *param)
+void enc32_stream_encoder_dp_unblank(
+	struct dc_link *link,
+	struct stream_encoder *enc,
+	const struct encoder_unblank_param *param)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 	struct dc *dc = enc->ctx->dc;
@@ -440,7 +440,7 @@ static void enc32_reset_fifo(struct stream_encoder *enc, bool reset)
 		udelay(10);
 }
 
-static void enc32_enable_fifo(struct stream_encoder *enc)
+void enc32_enable_fifo(struct stream_encoder *enc)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
index 875b1cd46056..1be5410cce97 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
@@ -194,4 +194,12 @@ void dcn32_dio_stream_encoder_construct(
 	const struct dcn10_stream_encoder_shift *se_shift,
 	const struct dcn10_stream_encoder_mask *se_mask);
 
+
+void enc32_enable_fifo(struct stream_encoder *enc);
+
+void enc32_stream_encoder_dp_unblank(
+		struct dc_link *link,
+		struct stream_encoder *enc,
+		const struct encoder_unblank_param *param);
+
 #endif /* __DC_DIO_STREAM_ENCODER_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 020d668ce09e..aa08925d54c9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2477,11 +2477,12 @@ void link_set_dpms_on(
 		 * from transmitter control.
 		 */
 		if (!(dc_is_virtual_signal(pipe_ctx->stream->signal) ||
-				dp_is_128b_132b_signal(pipe_ctx)))
-			if (link_enc)
-				link_enc->funcs->setup(
-					link_enc,
-					pipe_ctx->stream->signal);
+				dp_is_128b_132b_signal(pipe_ctx))) {
+				if (link_enc)
+					link_enc->funcs->setup(
+						link_enc,
+						pipe_ctx->stream->signal);
+			}
 
 		dc->hwss.enable_stream(pipe_ctx);
 
-- 
2.34.1

