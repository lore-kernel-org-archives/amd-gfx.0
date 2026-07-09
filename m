Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89526C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB0710F6CA;
	Thu,  9 Jul 2026 21:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uodpb5ZJ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013058.outbound.protection.outlook.com
 [40.93.196.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39EBD10F6C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKlDcF7w7I/dsp0Gh1CU+xva49HUkfhbh+g9sbNQhP0Y5ROwwtSmD9D02F/3x/BIGxXh2jNLPAtl7vu76GN99SZjr+dTFBAX920CgsdUpJRLrt5j7cuzXlm3zZJtI+hj1aDC9gPEOSdgJq/w1Uk84goJaq+FuYwnZl3GMAZ/uVhak1mzVKjAM/5Q++2Hg+rC+qcFsxAOwglEiOFR5TzBQuNorOI6TK9+mxFtffnCHyVPcNzQoPddJ2lh+qZ1Z6j6vfpYaXoLKkETp3GMF1EJBEFdM1wsFkryXb/G+pCjzLBXmBXTsIbLCij5N3cHIXQjdRJp1qsxWJR2rg0jX/N6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbnZqobqx7wDI9NbL4XjabPm11W84ChG/98hMhmogk8=;
 b=jT7n0l8b/X/sJBonXgAKJWoBoG1O2Pvj3BO1BUpEIU62T+WxR5dEPNju0O1LHS7pVAfWiurzdF916E2azNhg2x0gAL+O7HrJaTitwrU1tfgQwU9ld+335mu1oLhF6jLCJObWjEOKLmGMGcAvCCLA3TEWABwTbXxuzjhO6WpysjAE+lWKjoDc51+sTOVKvyXMqjOoKRD6AykDExWhScqaQ+b0Rl3Ls+syWyW+t5GhZ7lHTQLcWQaFPPCGEfmrWCMB5oNEPhaFcpwti3/gL9IUKQpO7ZKNuo0nBpZ0Fw/TTn01jZAFbVAz20yORmTnoP6p5d6MZYJZ4Lk/FA0CXbMUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbnZqobqx7wDI9NbL4XjabPm11W84ChG/98hMhmogk8=;
 b=Uodpb5ZJ/+22qAnqNcNjOKC267ta0iV6tH4J190nOoDvV6Mxhd3Op6GhcPpSpnmk8IeiClVAcDAE39gyNCXrxL3j6oxqjise+9YkKP35q2uIyQh+bl/7H3ef0LrwnNLsksTi2dKLALbN9EedRIJeup6TRZqNpGq7Pos0oNbbPe0=
Received: from MN2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:208:1a0::21)
 by LV1PR12MB999280.namprd12.prod.outlook.com (2603:10b6:408:3f5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:12 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::78) by MN2PR07CA0011.outlook.office365.com
 (2603:10b6:208:1a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:12 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:50 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "George
 Zhang" <george.zhang@amd.com>
Subject: [PATCH 19/80] drm/amd/display: Add DCN42B VID_CRC_CONTROL and
 HBLANK_CONTROL registers
Date: Thu, 9 Jul 2026 16:47:47 -0400
Message-ID: <20260709205936.5719-20-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|LV1PR12MB999280:EE_
X-MS-Office365-Filtering-Correlation-Id: ee424ecf-6046-4123-df8d-08deddfd595d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XqCQByx1a+9YdkBO6azwf4sDieAeXalnD4wqlQqG9kYsJfxtHgfeKxJHc3lZY4hOFUTCoTKFXawTY/ujx4JsCKgzrwCzzvi216VgW4weji/P7x9HGjTwUgp41DAqNjRCTAwdeYBQFjlBSOgic3cF74HLSff2RT3Fwav6RMdxvfAH1x8eBo3mANbNc3h4q4yYkGAQtohDgI6HlGcGw+ba5WcYUOvFPUhhPnvgBE6QAcKf948jb8jhg+rYhv4Hys8j5wDyyinMYoqofKXuD0xoeI4klnJr9vMmcLTfsgWV4VXJV9qEPweTwf626bA9VlncUTEkrxD7eqvcMGSa3rqGnltxcTFYQk538wvWuhGwR0uoQj1OPMNTCAS7Pz2zgv61FDI2X4tp5HSXTOo84aptqGDZ8xxW2AF3nL6Jbf9lZhn1GO6T1pGLdKTmEMfvikAnGp7OtB2cGLyENmJJK7W0O5NWivWDPdnbDiQAI/ruQD4zj5gV0MhJ2EEdB03ecz8NWQ1/hKi65ZPk7dZl7B8VOz2sLv8UHraTK8pgEs/Df+T7Z41fYBG0KLas8XRSZf26nI4bayUnK9EtUDBzbQ2pEY/4dMb9uEdY6vok8Yw9OeKaQ4XyfFQxkjGnTaNEDUU/juPTCOOtFytoLkghRKnyFSieAdmsDHnKNfyER4qLJLR0sqoLWJbG/sbcqTMYbVt8+r3OJUxQY9iLNB5F7oTP3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PLSKTd4Mh4P276Pb3Mc2PgCTB0X2cAMYebeN0aHdlpj6NcvRGEcCTbWUTN1QtEQ3IT9/+H4OBI3QXXt80Li0gIY+qZp8aM6Z1fbXY+baEyax5oPLs1x3AfhkXZ6uEkFv/1Q4scA/I6GtJm0pKRxGlXgvP/mqeXvqNBu8GVtEGks3M9ywKA4fI86RNxxQllC1oDmUovahyhYdPKmUUOtTIe4BQuzSt1yFERckZZH3dAKJMN5cykFyIs7cMI3P4KrlpbSKdqqXmkEW0FV3Jxo0sGpcnSkCkE6OF75MT+im39eKEHbfxnJ0EOTeUwdgXWextCKqLfHonDiDshzvi1saW2g0Qmn4cFpzj6PgX/2X7sSf3U936BStCHmhxr7VkJ1NzMLcNsrKP3YGRKNfN80BCMJ4WhAnEJoDr48yLsuRBIcLfL1XT7DR0rWdB5ikBf6V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:12.8544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee424ecf-6046-4123-df8d-08deddfd595d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999280
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why]

These registers are needed by our existing code.

[how]

Add the missing register defines to dcn42b_resource.c.

Remove DCN42B variant of HP_DP_STREAM_ENC_REG_LIST_RI as it is now the
same as the DCN42B one, when these registers are included.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../dc/resource/dcn42b/dcn42b_resource.c      | 15 ++++++-
 .../dc/resource/dcn42b/dcn42b_resource.h      | 40 -------------------
 2 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 172836dfd679..c555be6e541d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -134,6 +134,19 @@
 #define regHUBP3_HUBPREQ_DEBUG                0x088d
 #define regHUBP3_HUBPREQ_DEBUG_BASE_IDX       2

+#define regDP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL                                                   0x3687
+#define regDP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL_BASE_IDX                                          2
+#define regDP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL                                                   0x375b
+#define regDP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL_BASE_IDX                                          2
+#define regDP_SYM32_ENC2_DP_SYM32_ENC_VID_CRC_CONTROL                                                   0x382f
+#define regDP_SYM32_ENC2_DP_SYM32_ENC_VID_CRC_CONTROL_BASE_IDX                                          2
+#define regDP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL                                                    0x366b
+#define regDP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX                                           2
+#define regDP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL                                                    0x373f
+#define regDP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX                                           2
+#define regDP_SYM32_ENC2_DP_SYM32_ENC_HBLANK_CONTROL                                                    0x3813
+#define regDP_SYM32_ENC2_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX                                           2
+
 enum dcn401_clk_src_array_id {
 	DCN401_CLK_SRC_PLL0,
 	DCN401_CLK_SRC_PLL1,
@@ -351,7 +364,7 @@ static const struct dcn10_link_enc_mask le_mask = {
 	LINK_ENCODER_MASK_SH_LIST_DCN42B(_MASK)};

 #define hpo_dp_stream_encoder_reg_init(id) \
-	DCN42B_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
+	DCN42_HPO_DP_STREAM_ENC_REG_LIST_RI(id)

 static struct dcn31_hpo_dp_stream_encoder_registers hpo_dp_stream_enc_regs[4];

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
index 1a6e0e7be0fa..484ba1455468 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
@@ -254,46 +254,6 @@
 		SRI_ARR(STREAM_MAPPER_CONTROL, DIG, id),\
 		SRI_ARR(DIG_FE_AUDIO_CNTL, DIG, id)

-/* HPO DP stream encoder */
-/* Not in DCN42B:
- * SRI_ARR(DP_SYM32_ENC_VID_CRC_CONTROL, DP_SYM32_ENC, id),
- * SRI_ARR(DP_SYM32_ENC_HBLANK_CONTROL, DP_SYM32_ENC, id),
- */
-#define DCN42B_HPO_DP_STREAM_ENC_REG_LIST_RI(id)                                             \
-	SR_ARR(DP_STREAM_MAPPER_CONTROL0, id),                                                  \
-		SR_ARR(DP_STREAM_MAPPER_CONTROL1, id),                                              \
-		SR_ARR(DP_STREAM_MAPPER_CONTROL2, id),                                              \
-		SR_ARR(DP_STREAM_MAPPER_CONTROL3, id),                                              \
-		SRI_ARR(DP_STREAM_ENC_CLOCK_CONTROL, DP_STREAM_ENC, id),                            \
-		SRI_ARR(DP_STREAM_ENC_INPUT_MUX_CONTROL, DP_STREAM_ENC, id),                        \
-		SRI_ARR(DP_STREAM_ENC_AUDIO_CONTROL, DP_STREAM_ENC, id),                            \
-		SRI_ARR(DP_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, DP_STREAM_ENC, id), \
-		SRI_ARR(DP_SYM32_ENC_CONTROL, DP_SYM32_ENC, id),                                    \
-		SRI_ARR(DP_SYM32_ENC_VID_PIXEL_FORMAT, DP_SYM32_ENC, id),                           \
-		SRI_ARR(DP_SYM32_ENC_VID_PIXEL_FORMAT_DOUBLE_BUFFER_CONTROL, DP_SYM32_ENC, id),     \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA0, DP_SYM32_ENC, id),                                   \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA1, DP_SYM32_ENC, id),                                   \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA2, DP_SYM32_ENC, id),                                   \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA3, DP_SYM32_ENC, id),                                   \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA4, DP_SYM32_ENC, id),                                   \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA5, DP_SYM32_ENC, id),                                   \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA6, DP_SYM32_ENC, id),                                   \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA7, DP_SYM32_ENC, id),                                   \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA8, DP_SYM32_ENC, id),                                   \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA_CONTROL, DP_SYM32_ENC, id),                            \
-		SRI_ARR(DP_SYM32_ENC_VID_MSA_DOUBLE_BUFFER_CONTROL, DP_SYM32_ENC, id),              \
-		SRI_ARR(DP_SYM32_ENC_VID_FIFO_CONTROL, DP_SYM32_ENC, id),                           \
-		SRI_ARR(DP_SYM32_ENC_VID_STREAM_CONTROL, DP_SYM32_ENC, id),                         \
-		SRI_ARR(DP_SYM32_ENC_VID_VBID_CONTROL, DP_SYM32_ENC, id),                           \
-		SRI_ARR(DP_SYM32_ENC_SDP_CONTROL, DP_SYM32_ENC, id),                                \
-		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL0, DP_SYM32_ENC, id),                           \
-		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL2, DP_SYM32_ENC, id),                           \
-		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL3, DP_SYM32_ENC, id),                           \
-		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL5, DP_SYM32_ENC, id),                           \
-		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL11, DP_SYM32_ENC, id),                          \
-		SRI_ARR(DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL, DP_SYM32_ENC, id),                \
-		SRI_ARR(DP_SYM32_ENC_SDP_AUDIO_CONTROL0, DP_SYM32_ENC, id)
-
 /*HPO DP link encoder regs */
 #define DCN42B_HPO_DP_LINK_ENC_REG_LIST_RI(id)                    \
 	SRI_ARR(DP_LINK_ENC_CLOCK_CONTROL, DP_LINK_ENC, id),         \
--
2.55.0

