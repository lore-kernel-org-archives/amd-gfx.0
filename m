Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0D6C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB1510E9D9;
	Wed, 28 Sep 2022 19:42:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B61C10E9BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEduwgf14uzaZEQxnzX41yNBgbCIdf8oLel3oFJAmL4jY4fPmyWRT13/EtmqZjl2OdA0TYAWiVkI+oR8OVT3y4uUCxcYK2ERoTdLnb1XCezP69gqsCo8WiPEFrhhpYOxWkvIclW3cMxAZXBYIr5La+GRavWfsXGxnNl+QEcNgODJ/k0mJZDSn921wa1D7y4rwZ6tv/kooYCCfd5IyogAb6457H/gPAbbenvsF+RyDJnlrbRhLak94M72x57Piz0iYuU19fCexaM9P1IlXONu9vS9m4FDIOEnCld0eavNAk7jlRl6zd2grc3jqWVZ3I7ZXZK+aM8nfdAFdfyT94L4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK1CyI8l8bzaSCMFCxn6f4HpFd1to/F5zFct37lqnrI=;
 b=ny2iqbJbMbBhmcgsjTSVwdrcZsFc2jDk+6EgNkakSBu4osgHbCfJOZ5UEJaju7CTrmE/0+OaCWFsXtYJZBaPkctHg5at6ENIsy5Ow4VsvDjVqRv2TlvP27y+bUE2/MTg/JMQj/9zMe2GrVsGroBvXxb4nu2CPcxRgt+heVV9Y2wVr0T041DhEnDnTrJSqLeuiHfwfPTgLzpYMSQ0ACHGPTqT7C7DsglFLS839/WAHTiNzb8qUDQP0dhCphGPayufVu61Sny8O3epFfQStkNDc4kTQTF9F6rvH335uJJk3dcl3CmRVoAU15opCC/eH8cyIZJ2D7HGoexg8aZpn20ASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK1CyI8l8bzaSCMFCxn6f4HpFd1to/F5zFct37lqnrI=;
 b=z9qAW4J3+bSPOgkkZJojF6VZZ/olQPJvyuNS4x9WvFJmWCN0SrJfH+0Q5OUZ3bvo9VrbTbivEnZtZHsRts8jR/GJvI/oc1ydCzmwD5ljV9u9X3ibOn4FkwWIBSvne42fgWxuvm4D4sI70e7PfqToqU0G3kONqiKKYrO8tTE3jic=
Received: from BN9PR03CA0739.namprd03.prod.outlook.com (2603:10b6:408:110::24)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:41:28 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::50) by BN9PR03CA0739.outlook.office365.com
 (2603:10b6:408:110::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:27 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:25 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/36] drm/amd/display: Drop unused code for DCN32/321
Date: Wed, 28 Sep 2022 15:40:15 -0400
Message-ID: <20220928194028.144879-24-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|DM6PR12MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 832eb1c8-53e9-42c4-1573-08daa1896f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYB2t0MrG14pbCqg4kZM+wYTOFL+UV0lzoi5l/1pMZPvaIzw7fAK15rDJfVejqMkFnUJcJTa0ggrZYkXbuzv2cYoQeDTEwMPABrOm1CToo9Hk0jtsUoF2UjTcQa14De8FG+/HlGlI1xTLTFmDNLCelz0tSCXpbcZaUk5ATzXmi8hnfXJpxtXAx3b4WqFnn9xHwie4duZRzZ6q2DIxs59svaIEFG9XC8UOpZ7WSJcjUUimXthCXl4ODvjFmujdUOIzdSutW8M8oBSQpBdEEAlMNeJJaO2VxtnlA+ZQpWXboVU++Dgdt+AnpoNPbv6f9U+1ETHo4mNVdu0ao2skuXPKXEUe+5LtFhSXgm5EZOwbuxGZawjzvf75UodhWJYth88IVpT9zBfr5u5zQDW+qYLTmEOskvJhc0Y8K4U33HxZAjbLHhZN++RSPwe91KpitICnJ+uuBsThzfouDo/xpOcQy/l9c3P7/GJzfRrXIQ0FValRXTznfVY8yh03Vf3k9SePFF+je0pSKjiH2jDLg3F5+y31Adx1a5hxTbZ5VqU9WML9wFZiT01lNdYS5ekoVgHwQC50AYe7pDR1M7Vyguebhw1nDEmd09rkfG1jgC1KM49kRhsA8zJISFfw0fXUdzFjJE3oz2zsCM67cCCfapplo759I62LpLQZYetXiTYk2AC4BYOpkYP1adM3gTosiE/pBTiLkFP+1rgHv8URwy/RzBSKvl4GTd67IGx3qTsCsRFdk1xzmQYg/2W+VN2wgozVX5wjtZclekkF+S5gABZYbstdrpfR+nSafYeqc1ZjJ1UlhwVW4DbQ249FkqAZl0b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(70586007)(5660300002)(8676002)(356005)(36756003)(26005)(47076005)(426003)(81166007)(2906002)(44832011)(2616005)(4326008)(41300700001)(1076003)(186003)(70206006)(16526019)(86362001)(336012)(6666004)(478600001)(36860700001)(82310400005)(316002)(40460700003)(82740400003)(6916009)(40480700001)(83380400001)(8936002)(7696005)(54906003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:27.8887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832eb1c8-53e9-42c4-1573-08daa1896f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Under DCN32/321 we identified some code paths that DC never executes.
This commit removes those unused codes to avoid distractions when
debugging issues.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |  7 -------
 .../display/dc/dcn32/dcn32_dio_link_encoder.h |  4 ----
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 20 -------------------
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |  3 +--
 .../dc/dcn321/dcn321_dio_link_encoder.c       |  1 -
 .../amd/display/dc/dcn321/dcn321_resource.c   |  2 --
 6 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index fdae6aa89908..076969d928af 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -150,12 +150,6 @@ static void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
 
 }
 
-void enc32_set_dig_output_mode(struct link_encoder *enc, uint8_t pix_per_container)
-{
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, pix_per_container);
-}
- 
 static const struct link_encoder_funcs dcn32_link_enc_funcs = {
 	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
@@ -186,7 +180,6 @@ static const struct link_encoder_funcs dcn32_link_enc_funcs = {
 	.is_in_alt_mode = dcn32_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn32_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
-	.set_dig_output_mode = enc32_set_dig_output_mode,
 };
 
 void dcn32_link_encoder_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
index 749a1e8cb811..bbcfce06bec0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
@@ -53,8 +53,4 @@ void dcn32_link_encoder_enable_dp_output(
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source);
 
-void enc32_set_dig_output_mode(
-		struct link_encoder *enc,
-		uint8_t pix_per_container);
-
 #endif /* __DC_LINK_ENCODER__DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 3195be9d38f5..40e713c4e172 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -411,24 +411,6 @@ static void enc32_read_state(struct stream_encoder *enc, struct enc_state *s)
 	}
 }
 
-static void enc32_stream_encoder_reset_fifo(struct stream_encoder *enc)
-{
-	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	uint32_t fifo_enabled;
-
-	REG_GET(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, &fifo_enabled);
-
-	if (fifo_enabled == 0) {
-		/* reset DIG resync FIFO */
-		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 1);
-		/* TODO: fix timeout when wait for DIG_FIFO_RESET_DONE */
-		//REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 1, 1, 100);
-		udelay(1);
-		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 0);
-		REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 0, 1, 100);
-	}
-}
-
 static void enc32_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
@@ -458,8 +440,6 @@ static const struct stream_encoder_funcs dcn32_str_enc_funcs = {
 		enc3_stream_encoder_update_dp_info_packets,
 	.stop_dp_info_packets =
 		enc1_stream_encoder_stop_dp_info_packets,
-	.reset_fifo =
-		enc32_stream_encoder_reset_fifo,
 	.dp_blank =
 		enc1_stream_encoder_dp_blank,
 	.dp_unblank =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
index 830562f4139d..f4b901d393eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
@@ -185,8 +185,7 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_update_force_pstate_disallow = hubp32_update_force_pstate_disallow,
 	.phantom_hubp_post_enable = hubp32_phantom_hubp_post_enable,
 	.hubp_update_mall_sel = hubp32_update_mall_sel,
-	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering,
-	.hubp_set_flip_int = hubp1_set_flip_int
+	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering
 };
 
 bool hubp32_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
index 49682a31ecbd..fa9b6603cfd3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
@@ -91,7 +91,6 @@ static const struct link_encoder_funcs dcn321_link_enc_funcs = {
 	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
-	.set_dig_output_mode = enc32_set_dig_output_mode,
 };
 
 void dcn321_link_encoder_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index aed0f689cbbf..910b63d874d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -94,8 +94,6 @@
 #include "dcn20/dcn20_vmid.h"
 
 #define DC_LOGGER_INIT(logger)
-#define fixed16_to_double(x) (((double)x) / ((double) (1 << 16)))
-#define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
 
 enum dcn321_clk_src_array_id {
 	DCN321_CLK_SRC_PLL0,
-- 
2.37.2

