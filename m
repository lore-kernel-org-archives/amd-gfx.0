Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA23CC64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B60110E6DB;
	Fri,  3 Mar 2023 15:49:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC4610E6DB
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W41FHrzCfjfIXjXuu+Fj8DHZzFsVZnlS9+mal2UWWVI6bhB4NEuLgbIqvcTDyRIVu5R42Ceb6g9dTGX9WB7G3KLTISILsRNf0aySnhrfD8uaL1k+DaytPgnLrO7p+oL7APIarJkCCrnMDPyo6upTrZ4kWxSHUpusU8cI0Re3lVI1SxY3WPb8fwiEM536yI5h0lMXZfCFiclO4CbeBm97TvMKgpJ6l9tw+ik5v+5VIS8p8HmHkon3BItwEZLQtDafgJW8Ub2pa05oeNj0H4EPdoMOKhUqPcoSFqjwS59QKv7FEJXcgd8SddPffN6eIL+q4132X/5GJJmkge6Za6NNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSFqevbXv4J4lgVfw9ibvIwzndR57eWeevACQp6c8gU=;
 b=jWED5zb0QB/NrnVszYYg5whXLJKQ/Us4e1wDWujk5tLqC+JxcE935J5HlNRovxTr/fYeLZvvS+XwiT2ofDqBSfHmKocpm26uGgJbAm7U+tN0uWDXyPyUAoCf7+6Ayr9MdjSy3ydS8dcbLBl62p/saVRgHfLKvqDA8GOQ37orZQ+GU/lhaeGhj20+FP7iqVCX92+DOg+brQz0FpIrGjHDzllAij2/Zvg9trB+NHOtLj2gS+6u06HeOsqsuOoRI0ZqcpSCN3U9QO1FbHjoDGOXYIufHyzjn9bsmMO/d867CZljTnDOZzz7pr7QPjH5+5bMMm/2k72m+BPAXmonHwxbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSFqevbXv4J4lgVfw9ibvIwzndR57eWeevACQp6c8gU=;
 b=E447qH80kFWBLt2KbLsU08PjjBN0oQX3oZLoSIt+ydgu4SZpHVcPDHJ/FgUs/KnUfcyTDk5bJ4Y4Gijmts7L31/jyWJVEqvd1idPB4/4EZAI/8BcN5du7DUNbl6OlPDY0gGR3QuaxGFW+lhFvR22ilmq7s8PqW/YuW2jVaAWGmU=
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 15:49:35 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::34) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6 via Frontend
 Transport; Fri, 3 Mar 2023 15:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Fri, 3 Mar 2023 15:49:35 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:49:22 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/33] drm/amd/display: Simplify register offsets
Date: Fri, 3 Mar 2023 10:40:07 -0500
Message-ID: <20230303154022.2667-19-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4118b3-3985-4d38-9955-08db1bfee382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQwtCBvS06KeZ/hJNzYmSsoMZId4olP45TqqXK5k5Hms9vp6UuoVziIz/mTqu7tfVtzpbWI75t//bvHKkg3MTaXFogvXdYpNG2ZFyJPIB/vp0FfdJzKi8URIMTlkv3o3hF9q8LbNgDNQ5iRBTyM5tMtNjdYKmza8wXtLRn3FApX2T6e4MDZ/dcNRtwvtnNbweUPbt/IylKY1e5ZZkN+dd/pInjpvO/vyn8cjUsRPe5DHgrIPCr+Nl7x6MpxJq2bKEul5qIKP6gp95mG5yKRpz489PQWrRHMcOKcUtSzUv+0fK2uWkiv2r9HjuaRY3jhd1NqpULsTCndqXPB8+KiCs5wSnkWkC68IsaV/PNHuNArRPnwwDrjMd50lp7lSYT/lzilGz42whTJEVIiHus7UX2wqj7SOnna4keiRx3h4Cy3WfCohbUFF+Zm1NL3vkRiAxlPica5BpM1nP0RhNRGICq/nRrchLfE3I0msB9z9pr/BcwIUO1/bX2FLZqnpoATiwUEpHYvoEwu4XibBKV+kpgGPvBmMv3FmpKRvsVn2rkIgN1yFXI4H1uXzU+X2/Cblyi7LGZbH/TF+vBUmH0PA58YQgGqO6B3iFoxShdc9cLDWxiX+YnWdcV4oAccyr6T2FvI5AUTngkqZ13irIPowJEpOUSE3x09lwXPFMLPhEochaNOf4UNwEkJkiQqB6zmY8nVdLIkhssLpmtuqppGSdqLVi7NSP7r6gOuXZasJMMk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(86362001)(2616005)(36756003)(82310400005)(40460700003)(41300700001)(40480700001)(16526019)(2906002)(4326008)(70206006)(186003)(336012)(6916009)(70586007)(8936002)(54906003)(1076003)(478600001)(8676002)(44832011)(6666004)(26005)(316002)(81166007)(82740400003)(356005)(426003)(5660300002)(47076005)(36860700001)(83380400001)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:49:35.4906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4118b3-3985-4d38-9955-08db1bfee382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
Runtime initialization of register addresses define
duplicate register offsets in resource file, and makes
register offsets in sub-block defined for compile
time initialization obsolete.

[How]
Remove obsolete sub block register offsets that is
no longer referenced.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h | 36 ----------
 .../dc/dcn32/dcn32_dio_stream_encoder.h       | 64 -----------------
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   | 62 ----------------
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |  6 --
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h | 71 -------------------
 5 files changed, 239 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
index 1c46fad0977b..271c163e4844 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
@@ -31,42 +31,6 @@
 #define DCCG_SFII(block, reg_name, field_prefix, field_name, inst, post_fix)\
 	.field_prefix ## _ ## field_name[inst] = block ## inst ## _ ## reg_name ## __ ## field_prefix ## inst ## _ ## field_name ## post_fix
 
-
-#define DCCG_REG_LIST_DCN32() \
-	SR(DPPCLK_DTO_CTRL),\
-	DCCG_SRII(DTO_PARAM, DPPCLK, 0),\
-	DCCG_SRII(DTO_PARAM, DPPCLK, 1),\
-	DCCG_SRII(DTO_PARAM, DPPCLK, 2),\
-	DCCG_SRII(DTO_PARAM, DPPCLK, 3),\
-	DCCG_SRII(CLOCK_CNTL, HDMICHARCLK, 0),\
-	SR(PHYASYMCLK_CLOCK_CNTL),\
-	SR(PHYBSYMCLK_CLOCK_CNTL),\
-	SR(PHYCSYMCLK_CLOCK_CNTL),\
-	SR(PHYDSYMCLK_CLOCK_CNTL),\
-	SR(PHYESYMCLK_CLOCK_CNTL),\
-	SR(DPSTREAMCLK_CNTL),\
-	SR(HDMISTREAMCLK_CNTL),\
-	SR(SYMCLK32_SE_CNTL),\
-	SR(SYMCLK32_LE_CNTL),\
-	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0),\
-	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 1),\
-	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 2),\
-	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 3),\
-	DCCG_SRII(MODULO, DTBCLK_DTO, 0),\
-	DCCG_SRII(MODULO, DTBCLK_DTO, 1),\
-	DCCG_SRII(MODULO, DTBCLK_DTO, 2),\
-	DCCG_SRII(MODULO, DTBCLK_DTO, 3),\
-	DCCG_SRII(PHASE, DTBCLK_DTO, 0),\
-	DCCG_SRII(PHASE, DTBCLK_DTO, 1),\
-	DCCG_SRII(PHASE, DTBCLK_DTO, 2),\
-	DCCG_SRII(PHASE, DTBCLK_DTO, 3),\
-	SR(DCCG_AUDIO_DTBCLK_DTO_MODULO),\
-	SR(DCCG_AUDIO_DTBCLK_DTO_PHASE),\
-	SR(OTG_PIXEL_RATE_DIV),\
-	SR(DTBCLK_P_CNTL),\
-	SR(DCCG_AUDIO_DTO_SOURCE)
-
-
 #define DCCG_MASK_SH_LIST_DCN32(mask_sh) \
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 0, mask_sh),\
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 0, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
index ecd041a446d2..875b1cd46056 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
@@ -31,70 +31,6 @@
 #include "stream_encoder.h"
 #include "dcn20/dcn20_stream_encoder.h"
 
-#define SE_DCN32_REG_LIST(id)\
-	SRI(AFMT_CNTL, DIG, id), \
-	SRI(DIG_FE_CNTL, DIG, id), \
-	SRI(HDMI_CONTROL, DIG, id), \
-	SRI(HDMI_DB_CONTROL, DIG, id), \
-	SRI(HDMI_GC, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL0, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL1, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL2, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL3, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL4, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL5, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL6, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL7, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL8, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL9, DIG, id), \
-	SRI(HDMI_GENERIC_PACKET_CONTROL10, DIG, id), \
-	SRI(HDMI_INFOFRAME_CONTROL0, DIG, id), \
-	SRI(HDMI_INFOFRAME_CONTROL1, DIG, id), \
-	SRI(HDMI_VBI_PACKET_CONTROL, DIG, id), \
-	SRI(HDMI_AUDIO_PACKET_CONTROL, DIG, id),\
-	SRI(HDMI_ACR_PACKET_CONTROL, DIG, id),\
-	SRI(HDMI_ACR_32_0, DIG, id),\
-	SRI(HDMI_ACR_32_1, DIG, id),\
-	SRI(HDMI_ACR_44_0, DIG, id),\
-	SRI(HDMI_ACR_44_1, DIG, id),\
-	SRI(HDMI_ACR_48_0, DIG, id),\
-	SRI(HDMI_ACR_48_1, DIG, id),\
-	SRI(DP_DB_CNTL, DP, id), \
-	SRI(DP_MSA_MISC, DP, id), \
-	SRI(DP_MSA_VBID_MISC, DP, id), \
-	SRI(DP_MSA_COLORIMETRY, DP, id), \
-	SRI(DP_MSA_TIMING_PARAM1, DP, id), \
-	SRI(DP_MSA_TIMING_PARAM2, DP, id), \
-	SRI(DP_MSA_TIMING_PARAM3, DP, id), \
-	SRI(DP_MSA_TIMING_PARAM4, DP, id), \
-	SRI(DP_MSE_RATE_CNTL, DP, id), \
-	SRI(DP_MSE_RATE_UPDATE, DP, id), \
-	SRI(DP_PIXEL_FORMAT, DP, id), \
-	SRI(DP_SEC_CNTL, DP, id), \
-	SRI(DP_SEC_CNTL1, DP, id), \
-	SRI(DP_SEC_CNTL2, DP, id), \
-	SRI(DP_SEC_CNTL5, DP, id), \
-	SRI(DP_SEC_CNTL6, DP, id), \
-	SRI(DP_STEER_FIFO, DP, id), \
-	SRI(DP_VID_M, DP, id), \
-	SRI(DP_VID_N, DP, id), \
-	SRI(DP_VID_STREAM_CNTL, DP, id), \
-	SRI(DP_VID_TIMING, DP, id), \
-	SRI(DP_SEC_AUD_N, DP, id), \
-	SRI(DP_SEC_TIMESTAMP, DP, id), \
-	SRI(DP_DSC_CNTL, DP, id), \
-	SRI(DP_SEC_METADATA_TRANSMISSION, DP, id), \
-	SRI(HDMI_METADATA_PACKET_CONTROL, DIG, id), \
-	SRI(DP_SEC_FRAMING4, DP, id), \
-	SRI(DP_GSP11_CNTL, DP, id), \
-	SRI(DME_CONTROL, DME, id),\
-	SRI(DP_SEC_METADATA_TRANSMISSION, DP, id), \
-	SRI(HDMI_METADATA_PACKET_CONTROL, DIG, id), \
-	SRI(DIG_FE_CNTL, DIG, id), \
-	SRI(DIG_CLOCK_PATTERN, DIG, id), \
-	SRI(DIG_FIFO_CTRL0, DIG, id)
-
-
 #define SE_COMMON_MASK_SH_LIST_DCN32(mask_sh)\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_ENCODING, mask_sh),\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_COMPONENT_DEPTH, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
index b20eb04724bb..ad33427192c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
@@ -28,68 +28,6 @@
 
 #include "dcn21/dcn21_hubbub.h"
 
-#define HUBBUB_REG_LIST_DCN32(id)\
-	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A),\
-	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B),\
-	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C),\
-	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D),\
-	SR(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL),\
-	SR(DCHUBBUB_ARB_DRAM_STATE_CNTL),\
-	SR(DCHUBBUB_ARB_SAT_LEVEL),\
-	SR(DCHUBBUB_ARB_DF_REQ_OUTSTAND),\
-	SR(DCHUBBUB_GLOBAL_TIMER_CNTL), \
-	SR(DCHUBBUB_SOFT_RESET),\
-	SR(DCHUBBUB_CRC_CTRL), \
-	SR(DCN_VM_FB_LOCATION_BASE),\
-	SR(DCN_VM_FB_LOCATION_TOP),\
-	SR(DCN_VM_FB_OFFSET),\
-	SR(DCN_VM_AGP_BOT),\
-	SR(DCN_VM_AGP_TOP),\
-	SR(DCN_VM_AGP_BASE),\
-	HUBBUB_SR_WATERMARK_REG_LIST(), \
-	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_A),\
-	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_B),\
-	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_C),\
-	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_D),\
-	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A),\
-	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B),\
-	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C),\
-	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D),\
-	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A),\
-	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B),\
-	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C),\
-	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D),\
-	SR(DCHUBBUB_DET0_CTRL),\
-	SR(DCHUBBUB_DET1_CTRL),\
-	SR(DCHUBBUB_DET2_CTRL),\
-	SR(DCHUBBUB_DET3_CTRL),\
-	SR(DCHUBBUB_COMPBUF_CTRL),\
-	SR(COMPBUF_RESERVED_SPACE),\
-	SR(DCHUBBUB_DEBUG_CTRL_0),\
-	SR(DCHUBBUB_ARB_USR_RETRAINING_CNTL),\
-	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A),\
-	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B),\
-	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C),\
-	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D),\
-	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A),\
-	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B),\
-	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C),\
-	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D),\
-	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A),\
-	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B),\
-	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C),\
-	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D),\
-	SR(DCN_VM_FAULT_ADDR_MSB),\
-	SR(DCN_VM_FAULT_ADDR_LSB),\
-	SR(DCN_VM_FAULT_CNTL),\
-	SR(DCN_VM_FAULT_STATUS),\
-	SR(SDPIF_REQUEST_RATE_LIMIT),\
-	SR(DCHUBBUB_CLOCK_CNTL),\
-	SR(DCHUBBUB_SDPIF_CFG0),\
-	SR(DCHUBBUB_SDPIF_CFG1),\
-	SR(DCHUBBUB_MEM_PWR_MODE_CTRL)
-
-
 #define HUBBUB_MASK_SH_LIST_DCN32(mask_sh)\
 	HUBBUB_SF(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_SOFT_RESET, DCHUBBUB_GLOBAL_SOFT_RESET, mask_sh), \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
index 4cdbf63c952b..d5e5ed8ab869 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
@@ -31,12 +31,6 @@
 #include "dcn30/dcn30_hubp.h"
 #include "dcn31/dcn31_hubp.h"
 
-#define HUBP_REG_LIST_DCN32(id)\
-	HUBP_REG_LIST_DCN30(id),\
-	SRI(DCHUBP_MALL_CONFIG, HUBP, id),\
-	SRI(DCHUBP_VMPG_CONFIG, HUBP, id),\
-	SRI(UCLK_PSTATE_FORCE, HUBPREQ, id)
-
 #define HUBP_MASK_SH_LIST_DCN32(mask_sh)\
 	HUBP_MASK_SH_LIST_DCN31(mask_sh),\
 	HUBP_SF(HUBP0_DCHUBP_MALL_CONFIG, USE_MALL_SEL, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
index 5e57c39235fa..b92ba8c75694 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
@@ -28,77 +28,6 @@
 
 #include "dcn10/dcn10_optc.h"
 
-#define OPTC_COMMON_REG_LIST_DCN3_2(inst) \
-	SRI(OTG_VSTARTUP_PARAM, OTG, inst),\
-	SRI(OTG_VUPDATE_PARAM, OTG, inst),\
-	SRI(OTG_VREADY_PARAM, OTG, inst),\
-	SRI(OTG_MASTER_UPDATE_LOCK, OTG, inst),\
-	SRI(OTG_GLOBAL_CONTROL0, OTG, inst),\
-	SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
-	SRI(OTG_GLOBAL_CONTROL2, OTG, inst),\
-	SRI(OTG_GLOBAL_CONTROL4, OTG, inst),\
-	SRI(OTG_DOUBLE_BUFFER_CONTROL, OTG, inst),\
-	SRI(OTG_H_TOTAL, OTG, inst),\
-	SRI(OTG_H_BLANK_START_END, OTG, inst),\
-	SRI(OTG_H_SYNC_A, OTG, inst),\
-	SRI(OTG_H_SYNC_A_CNTL, OTG, inst),\
-	SRI(OTG_H_TIMING_CNTL, OTG, inst),\
-	SRI(OTG_V_TOTAL, OTG, inst),\
-	SRI(OTG_V_BLANK_START_END, OTG, inst),\
-	SRI(OTG_V_SYNC_A, OTG, inst),\
-	SRI(OTG_V_SYNC_A_CNTL, OTG, inst),\
-	SRI(OTG_CONTROL, OTG, inst),\
-	SRI(OTG_STEREO_CONTROL, OTG, inst),\
-	SRI(OTG_3D_STRUCTURE_CONTROL, OTG, inst),\
-	SRI(OTG_STEREO_STATUS, OTG, inst),\
-	SRI(OTG_V_TOTAL_MAX, OTG, inst),\
-	SRI(OTG_V_TOTAL_MIN, OTG, inst),\
-	SRI(OTG_V_TOTAL_CONTROL, OTG, inst),\
-	SRI(OTG_TRIGA_CNTL, OTG, inst),\
-	SRI(OTG_FORCE_COUNT_NOW_CNTL, OTG, inst),\
-	SRI(OTG_STATIC_SCREEN_CONTROL, OTG, inst),\
-	SRI(OTG_STATUS_FRAME_COUNT, OTG, inst),\
-	SRI(OTG_STATUS, OTG, inst),\
-	SRI(OTG_STATUS_POSITION, OTG, inst),\
-	SRI(OTG_NOM_VERT_POSITION, OTG, inst),\
-	SRI(OTG_M_CONST_DTO0, OTG, inst),\
-	SRI(OTG_M_CONST_DTO1, OTG, inst),\
-	SRI(OTG_CLOCK_CONTROL, OTG, inst),\
-	SRI(OTG_VERTICAL_INTERRUPT0_CONTROL, OTG, inst),\
-	SRI(OTG_VERTICAL_INTERRUPT0_POSITION, OTG, inst),\
-	SRI(OTG_VERTICAL_INTERRUPT1_CONTROL, OTG, inst),\
-	SRI(OTG_VERTICAL_INTERRUPT1_POSITION, OTG, inst),\
-	SRI(OTG_VERTICAL_INTERRUPT2_CONTROL, OTG, inst),\
-	SRI(OTG_VERTICAL_INTERRUPT2_POSITION, OTG, inst),\
-	SRI(OPTC_INPUT_CLOCK_CONTROL, ODM, inst),\
-	SRI(OPTC_DATA_SOURCE_SELECT, ODM, inst),\
-	SRI(OPTC_INPUT_GLOBAL_CONTROL, ODM, inst),\
-	SRI(CONTROL, VTG, inst),\
-	SRI(OTG_VERT_SYNC_CONTROL, OTG, inst),\
-	SRI(OTG_GSL_CONTROL, OTG, inst),\
-	SRI(OTG_CRC_CNTL, OTG, inst),\
-	SRI(OTG_CRC0_DATA_RG, OTG, inst),\
-	SRI(OTG_CRC0_DATA_B, OTG, inst),\
-	SRI(OTG_CRC0_WINDOWA_X_CONTROL, OTG, inst),\
-	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
-	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
-	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
-	SR(GSL_SOURCE_SELECT),\
-	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
-	SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
-	SRI(OTG_GLOBAL_CONTROL2, OTG, inst),\
-	SRI(OTG_GSL_WINDOW_X, OTG, inst),\
-	SRI(OTG_GSL_WINDOW_Y, OTG, inst),\
-	SRI(OTG_VUPDATE_KEEPOUT, OTG, inst),\
-	SRI(OTG_DSC_START_POSITION, OTG, inst),\
-	SRI(OTG_DRR_TRIGGER_WINDOW, OTG, inst),\
-	SRI(OTG_DRR_V_TOTAL_CHANGE, OTG, inst),\
-	SRI(OPTC_DATA_FORMAT_CONTROL, ODM, inst),\
-	SRI(OPTC_BYTES_PER_PIXEL, ODM, inst),\
-	SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
-	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
-	SRI(OTG_DRR_CONTROL, OTG, inst)
-
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_2(mask_sh)\
 	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
 	SF(OTG0_OTG_VUPDATE_PARAM, VUPDATE_OFFSET, mask_sh),\
-- 
2.34.1

