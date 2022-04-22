Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AF0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2AD10E4A3;
	Fri, 22 Apr 2022 16:46:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B50A10E4A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7Ho/3U4kLt7qhFhxfDSLfBOfNcPCL9YuK+EmiDKwy4fhBhdV4GwI2WpKZWra0hdJzVZLF4OBldJz6NaFRRymH8uT89C1QJnMwiA+5g3eQ3FXhw8nuexcS87ZuhgTIhwZ+SUAzwTa1qr1xfh7V7/Mw19BXDpdf47EqMxOQkhBSP+ELh3bNIoJQ62ucplISmqbxvrv6HkqyaFT3q0an2Z1vFrC9bFDxKZA+cenB8bqLTBYY2yOjVoFiwCaKIQJye3bAbLIuFtBKbpSsHfEChiQ7cTnQpS+2LuVywuL2xl79sn9+h4rj6k0rXlOm/iTZxrmjJsr2PAEyGF1JlUDhACfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p9nPejcjBkLmjzA+ec4tq9mgW09qtxW4fpVDrv1NBA=;
 b=PolcgILT+i0TOLhpHdUlLZqsCufRu4jOrzjydas83rOZ2g/Hepx4a9KpivwBe2H9d5DSyN9r0ZkBdAXzP+hGThEHejlxM03OJk29NLwME96mwrIy3yDl+dZydhP0jzxx36mbljvfKHlhjKPvKzD/WSYWOlug4TkdhtJ3wFbHkovI1/c7ibKu8HMeMU3KUbvqRFhVXBqRZLJmzgfbcBQdjiL6hHFmsPQa7z1zQ+5OpztzubcbqnDzXsbdRc+qzkcXF3/Gkc3Uqi7RMYir5pFte8VIu59yfSiD3cW3jIXgwuO1WjfohI82LcdaIao1RC6LBsbk6Os4Qkep9aYACSXs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p9nPejcjBkLmjzA+ec4tq9mgW09qtxW4fpVDrv1NBA=;
 b=RTjii4IkUUwOIvJmZ/zayQ0HRBmOxhT8FOsjqlXblQWdrJOgj35vMSBMsO61Luip3or+/2x5m2jgZMFeIFNlgtGOu76m+UXp6y6ChpkZJRNug+kT2Uq5fyeEk0Wj9ZLFw6NRLUMnEcBZdKgDleKAkYTZDjow+bn+A0aFLFQ6FUE=
Received: from MW4PR03CA0034.namprd03.prod.outlook.com (2603:10b6:303:8e::9)
 by BYAPR12MB2853.namprd12.prod.outlook.com (2603:10b6:a03:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 16:46:33 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::63) by MW4PR03CA0034.outlook.office365.com
 (2603:10b6:303:8e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 16:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:46:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:31 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:46:26 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amd/display: Add Audio readback registers
Date: Sat, 23 Apr 2022 00:44:49 +0800
Message-ID: <20220422164457.1755751-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931e9f4c-20d1-42c5-4153-08da247fa823
X-MS-TrafficTypeDiagnostic: BYAPR12MB2853:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28537936E87C3124A8912AAAE6F79@BYAPR12MB2853.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgkVsX+8760GvOWuVKYnhEhiKfPz8jqLl/+kQ2pM81/h+nI//UMr3GWUcTsDLiCNFai3bLD04xtKAyH0LiP25SreuWJ0RxebRgtwyUu9THA5l9d6SRN3mrvIy4XpF7fgk3JKLcoAScj7WG/+nFaBpGHD5L4F+K/A7Dp8xzEmek32jisElZf7ihmdot+uyuKCIM+NRtT1cHlt2J6XvGMu+YFGujGYvYdDSPR2YALBRB5jVw7RkfQPolBRqBhL4i259lWyyvC2v4oBryyJYy66F8/b6d1eFN7wXsQH4JINe+mtS15w29w9ShsRmpN3R1vV7zA1XlwDM6F/bwGEJTnj9oXitVRNoeEiEb5zVit5YeGt2c4XuJVP4ePncac09XoiYNzK2mysQPwSjGXJ0AAO0ecCTnsGdf5eqBADvgZBEoKUijQgHUoK1HS4isgIpe8afOP+MH6/y0LI91iG16Vzmx13KB3X7aCe84tardniCTOifTIXSYWN2mRTf8AJTVlzyHw5sPC3C+yu5iIjtM3yd0fVT4ff0dpXT7dIgUd4GTyrBTcrcKEjZo463Ah9WRsN87tcRrDnVuuomGZIWlPFAOtBVs4bqs/neMZOHW4vq258X1/CyXerj03djjziOVZWQPKN0hrwjCQ5ES939okl9dCDqsLnNnAVUMqexahMzX1b3ASJZr2+SPJ+vY+1PocpShGt9EpS2NlSyYGiFccvWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(82310400005)(426003)(8676002)(1076003)(2616005)(336012)(186003)(356005)(81166007)(36860700001)(7696005)(316002)(54906003)(6916009)(8936002)(70206006)(70586007)(36756003)(83380400001)(508600001)(47076005)(5660300002)(2906002)(6666004)(4326008)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:46:32.4800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931e9f4c-20d1-42c5-4153-08da247fa823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2853
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
Cc: stylon.wang@amd.com, Ilya <Ilya.Bakoulin@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya <Ilya.Bakoulin@amd.com>

[Why]
Can be useful for verifying the correctness of audio output.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c   | 1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h   | 8 ++++++++
 .../drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h   | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index b0c08ee6bc2c..7608187751c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -25,6 +25,7 @@
 
 #include <linux/delay.h>
 
+#include "dm_services.h"
 #include "dc_bios_types.h"
 #include "dcn10_stream_encoder.h"
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 687d7e4bf7ca..293595a33982 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -92,6 +92,8 @@
 	SRI(DP_VID_STREAM_CNTL, DP, id), \
 	SRI(DP_VID_TIMING, DP, id), \
 	SRI(DP_SEC_AUD_N, DP, id), \
+	SRI(DP_SEC_AUD_N_READBACK, DP, id), \
+	SRI(DP_SEC_AUD_M_READBACK, DP, id), \
 	SRI(DP_SEC_TIMESTAMP, DP, id), \
 	SRI(DIG_CLOCK_PATTERN, DIG, id)
 
@@ -140,6 +142,8 @@ struct dcn10_stream_enc_registers {
 	uint32_t DP_VID_STREAM_CNTL;
 	uint32_t DP_VID_TIMING;
 	uint32_t DP_SEC_AUD_N;
+	uint32_t DP_SEC_AUD_N_READBACK;
+	uint32_t DP_SEC_AUD_M_READBACK;
 	uint32_t DP_SEC_TIMESTAMP;
 	uint32_t HDMI_CONTROL;
 	uint32_t HDMI_GC;
@@ -256,6 +260,8 @@ struct dcn10_stream_enc_registers {
 	SE_SF(DIG0_AFMT_60958_2, AFMT_60958_CS_CHANNEL_NUMBER_6, mask_sh),\
 	SE_SF(DIG0_AFMT_60958_2, AFMT_60958_CS_CHANNEL_NUMBER_7, mask_sh),\
 	SE_SF(DP0_DP_SEC_AUD_N, DP_SEC_AUD_N, mask_sh),\
+	SE_SF(DP0_DP_SEC_AUD_N_READBACK, DP_SEC_AUD_N_READBACK, mask_sh),\
+	SE_SF(DP0_DP_SEC_AUD_M_READBACK, DP_SEC_AUD_M_READBACK, mask_sh),\
 	SE_SF(DP0_DP_SEC_TIMESTAMP, DP_SEC_TIMESTAMP_MODE, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_ASP_ENABLE, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_ATP_ENABLE, mask_sh),\
@@ -473,6 +479,8 @@ struct dcn10_stream_enc_registers {
 	type AFMT_60958_CS_CHANNEL_NUMBER_6;\
 	type AFMT_60958_CS_CHANNEL_NUMBER_7;\
 	type DP_SEC_AUD_N;\
+	type DP_SEC_AUD_N_READBACK;\
+	type DP_SEC_AUD_M_READBACK;\
 	type DP_SEC_TIMESTAMP_MODE;\
 	type DP_SEC_ASP_ENABLE;\
 	type DP_SEC_ATP_ENABLE;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
index e2c264ecb20f..42140e73c3b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
@@ -95,6 +95,8 @@
 	SRI(DP_VID_STREAM_CNTL, DP, id), \
 	SRI(DP_VID_TIMING, DP, id), \
 	SRI(DP_SEC_AUD_N, DP, id), \
+	SRI(DP_SEC_AUD_N_READBACK, DP, id), \
+	SRI(DP_SEC_AUD_M_READBACK, DP, id), \
 	SRI(DP_SEC_TIMESTAMP, DP, id), \
 	SRI(DP_DSC_CNTL, DP, id), \
 	SRI(DP_DSC_BYTES_PER_PIXEL, DP, id), \
@@ -157,6 +159,8 @@
 	SE_SF(DIG0_HDMI_ACR_48_0, HDMI_ACR_CTS_48, mask_sh),\
 	SE_SF(DIG0_HDMI_ACR_48_1, HDMI_ACR_N_48, mask_sh),\
 	SE_SF(DP0_DP_SEC_AUD_N, DP_SEC_AUD_N, mask_sh),\
+	SE_SF(DP0_DP_SEC_AUD_N_READBACK, DP_SEC_AUD_N_READBACK, mask_sh),\
+	SE_SF(DP0_DP_SEC_AUD_M_READBACK, DP_SEC_AUD_M_READBACK, mask_sh),\
 	SE_SF(DP0_DP_SEC_TIMESTAMP, DP_SEC_TIMESTAMP_MODE, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_ASP_ENABLE, mask_sh),\
 	SE_SF(DP0_DP_SEC_CNTL, DP_SEC_ATP_ENABLE, mask_sh),\
-- 
2.25.1

