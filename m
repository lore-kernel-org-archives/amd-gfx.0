Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A0CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A5310EE7E;
	Fri, 28 Jan 2022 14:05:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DE510EF87
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg5cyC6O6/FWkW3rVxucUyes5R2zQk6eLQnGsSv+aDnoCJlT8KklHnAh12LjcxWl036PiR/VnJxVu7jPIfR6xpD3u4ic1Eh1tVkd2bp/tR6M616wnRT4/pGv9D+6jfmKlUZd/4BiEZzn+ZIy4/3kWia2QvuVfWxCUZZZOqkSNM2GdIGu7DNbmqDPdO9NibEw8mhc7+E92lWaIK0s7va+yCB8/ceptJlzp2AK1bo76uZa9g91WQ/OMqxJ0qlBpYA1/o3EbHk50jux6/dbDuOP35tQpSddCLN9gOTRiiCOu1+FqJbGUwnINsGU0Blp3lH2iddQID5Y/pjfB9pqpac7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLH7rjucaVKZdF0HCI7IDatodV+w4QvUI6Ef8ryEY/A=;
 b=j/hoHcaSTRg0sxsnhfBW+4InSbYLdRu1xMUj3jQ7EAtUunmMbVSE+8jQQVtkU+j1pxs6nHQZSoezBob1h9OyXwiMoC1y5RncG8lqkVUHKXKLtdAHvpH5xNGKL8aAy93GhZ7VI0UgjS2VKgoKN6T/YvWyl1BzI5kRCAj6LdacO0t0szptXHIYyUXcZ2k0AfPSUSODMdgAzgitr44MRE661UC7X+evLV9o27q39qit8L0nJ34hx4aGD3ztvks18NWD2q338q5UW1+XFbQY7pFvV4H+p6myoJsNE5ZoTcXsctuNcQ6GnFVZJ0oe6GiyQ5Cv7FcGVC2AcSa4dHHNS8E7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLH7rjucaVKZdF0HCI7IDatodV+w4QvUI6Ef8ryEY/A=;
 b=rN4QsHA5dWnJCZp/JFfCtfaBSUwm5JvReZO41wjsuxYVLCaxpncgMdJgLzsM/W7ebqMBUjio61mE1A11E8S7Y2ePyYPExRamjg4T2hcE3puP7hLKV2TCTdqbqWwsGeeHqMCHBbQrImlbOlyMyPfvGc0vbbdcou0rXuw1HLcF7io=
Received: from DM6PR11CA0057.namprd11.prod.outlook.com (2603:10b6:5:14c::34)
 by MWHPR12MB1759.namprd12.prod.outlook.com (2603:10b6:300:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 14:05:37 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::59) by DM6PR11CA0057.outlook.office365.com
 (2603:10b6:5:14c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:36 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:31 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/17] drm/amd/display: add set dp link test pattern to
 link_hwss
Date: Fri, 28 Jan 2022 22:04:03 +0800
Message-ID: <20220128140411.3683309-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0eb75b2-ba11-41c2-18e2-08d9e2674243
X-MS-TrafficTypeDiagnostic: MWHPR12MB1759:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB175985DE401389023DD9D7E4FF229@MWHPR12MB1759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlrRQrdyhXrunxS1ncc40febxraO5paAYzAlp3NPaobUZCNf7AGzGC10RI4XJ1SdCRY9HLBVd903smChWl7gAL3NirVh6vAtoe+a2wWWyMAC9nNxUlrakflAJbw3KUuM2DXVZmUXPkoaolBlky8zV9ZC3dGZwHSdxqHzhum0d/JKLVX8R/cHxfqf7Hcml3G9ZdAFg/FPg4A7Wb2cPHeWIG7DS7/mt8y+M4+8BfkVShe/6xVj7aSdnP/Iz2VZ1ed5g4D8LYb2Jzz0K+h1MjdDz7au/a7RVudtHVw49a/gUQQuQQlxdAMIfIhYnpg0cQXZKUvTZfW55OLiav0EURuz4vxZ+9Rk8YiNeTpWTCQtDm6WlByBrn7WGi24oBKAxYTC8E4hH4Lz+gXY3H45eSFz0IhCuKdLRij9LgMGm7rOeRpy3eAzsN97BvKltR5kwpwKlxzrQkTxVygbsRI9Wiqw8NY9X5/ZOph6USjedOaFg6zwiGV2sq/mYgaLk0xGLOB0c8oVVGZBJqQaexQNXY37ZZG7A4I8DbEY+bem+THZ+6aX+imtK1+EWUhzJgiuyvurHl0pz84coZEiuhBjw+dQjA2bsK2RXYHm8BCXja6ovug9wCbvUFS/SaT9Q7M80V6oil2G7Q0XrtGXtuRcrXTT2a6W1YBT2MxGN3/pOkFjt/npxLxFrEip5cERo8SVGBnnYslrcZJ/y9lNu3kwkA5JLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(40460700003)(508600001)(356005)(6666004)(47076005)(81166007)(86362001)(7696005)(36756003)(2616005)(336012)(70586007)(16526019)(1076003)(5660300002)(8676002)(26005)(70206006)(426003)(8936002)(36860700001)(4326008)(83380400001)(186003)(44832011)(6916009)(54906003)(316002)(2906002)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:36.9588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0eb75b2-ba11-41c2-18e2-08d9e2674243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1759
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Factor set dp link test pattern to link_hwss.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 46 +++++++++++--------
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  3 ++
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 364fa77b85f0..d5670d3b1a4b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -323,33 +323,16 @@ void dp_set_hw_test_pattern(
 	uint8_t *custom_pattern,
 	uint32_t custom_pattern_size)
 {
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
 	struct encoder_set_dp_phy_pattern_param pattern_param = {0};
-	struct link_encoder *encoder;
-	enum dp_link_encoding link_encoding_format = dp_get_link_encoding_format(&link->cur_link_settings);
-
-	encoder = link_enc_cfg_get_link_enc(link);
-	ASSERT(encoder);
 
 	pattern_param.dp_phy_pattern = test_pattern;
 	pattern_param.custom_pattern = custom_pattern;
 	pattern_param.custom_pattern_size = custom_pattern_size;
 	pattern_param.dp_panel_mode = dp_get_panel_mode(link);
 
-	switch (link_encoding_format) {
-	case DP_128b_132b_ENCODING:
-		link_res->hpo_dp_link_enc->funcs->set_link_test_pattern(
-				link_res->hpo_dp_link_enc, &pattern_param);
-		break;
-	case DP_8b_10b_ENCODING:
-		ASSERT(encoder);
-		encoder->funcs->dp_set_phy_pattern(encoder, &pattern_param);
-		break;
-	default:
-		DC_LOG_ERROR("%s: Unknown link encoding format.", __func__);
-		break;
-	}
-
-	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
+	if (link_hwss->ext.set_dp_link_test_pattern)
+		link_hwss->ext.set_dp_link_test_pattern(link, link_res, &pattern_param);
 }
 #undef DC_LOGGER
 
@@ -754,6 +737,17 @@ static void disable_dio_dp_link_output(struct dc_link *link,
 	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
 
+static void set_dio_dp_link_test_pattern(struct dc_link *link,
+		const struct link_resource *link_res,
+		struct encoder_set_dp_phy_pattern_param *tp_params)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	ASSERT(link_enc);
+	link_enc->funcs->dp_set_phy_pattern(link_enc, tp_params);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
+}
+
 static const struct link_hwss dio_link_hwss = {
 	.setup_stream_encoder = setup_dio_stream_encoder,
 	.reset_stream_encoder = reset_dio_stream_encoder,
@@ -761,6 +755,7 @@ static const struct link_hwss dio_link_hwss = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 		.enable_dp_link_output = enable_dio_dp_link_output,
 		.disable_dp_link_output = disable_dio_dp_link_output,
+		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
 	},
 };
 
@@ -927,6 +922,15 @@ static void disable_hpo_dp_link_output(struct dc_link *link,
 	}
 }
 
+static void set_hpo_dp_link_test_pattern(struct dc_link *link,
+		const struct link_resource *link_res,
+		struct encoder_set_dp_phy_pattern_param *tp_params)
+{
+	link_res->hpo_dp_link_enc->funcs->set_link_test_pattern(
+			link_res->hpo_dp_link_enc, tp_params);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
+}
+
 static const struct link_hwss hpo_dp_link_hwss = {
 	.setup_stream_encoder = setup_hpo_dp_stream_encoder,
 	.reset_stream_encoder = reset_hpo_dp_stream_encoder,
@@ -935,6 +939,7 @@ static const struct link_hwss hpo_dp_link_hwss = {
 		.set_hblank_min_symbol_width = set_dp_hpo_hblank_min_symbol_width,
 		.enable_dp_link_output = enable_hpo_dp_link_output,
 		.disable_dp_link_output = disable_hpo_dp_link_output,
+		.set_dp_link_test_pattern  = set_hpo_dp_link_test_pattern,
 	},
 };
 /*********************** below goes to dpia_link_hwss *************************/
@@ -952,6 +957,7 @@ static const struct link_hwss dpia_link_hwss = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 		.enable_dp_link_output = enable_dio_dp_link_output,
 		.disable_dp_link_output = disable_dio_dp_link_output,
+		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
 	},
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 8fe20ee02d9e..ce9762aa58c9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -94,6 +94,9 @@ struct link_hwss_ext {
 	void (*disable_dp_link_output)(struct dc_link *link,
 			const struct link_resource *link_res,
 			enum signal_type signal);
+	void (*set_dp_link_test_pattern)(struct dc_link *link,
+			const struct link_resource *link_res,
+			struct encoder_set_dp_phy_pattern_param *tp_params);
 };
 
 struct link_hwss {
-- 
2.34.1

