Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436C7C55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1F510F40A;
	Fri, 31 Jul 2026 21:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WhdDLMPR";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6558A10F408
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCG1YvzAYOfGyf6+15EEEC/Xpn5L2oRs1y4gmQE7YP0ftpYTTFlJsY8DGIjMILVys3XgNLtEwWdz/hLX7ASrpcIQz68Qu2BvVGMjCmFx6dSnILeLoxpKKcQM8d8rZtGR7N6EJvh/3z2L1qakCFjj/Acpks3fGigcGJbEBpWaShhycQXDRsfEgWMw/oMUKX3AiotVVj1ZbJ+M8OsZSI4r04XcE00hbuNWM4zifrppn+LTR/iOvbXuLAGrDi+KhwXETzhdlmKmMofxT7VPzO5qBz9GBte67BDV7e6kiiiW5//j30AJo6jVWfd4eZOrE9cqtRLc8Z8uE23nWhvGIfxemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhoi3Q5Tto1lUR8zax1REPelsvw0CnqNPVEqRsa/GlI=;
 b=y05ak4eck1tQldPUNb364aCOtrhZVbPkcFSjerQqEZ743toWQvpZhDBDjDhz4I22T5bX3xDbIt/bS8dRZyRe8U6hXpt18BkJiezoyFOO7gaMDNHXq4+uMXPZA2eQ7dW67dNXNExHkc3owmr6pt+h8o99AWXk68A/478ghXkv+g0wByk61s2CKMzwS/7KIikoYBk2WuQkTX2yNVA/wueWtfwqgVaey39BgrrQ3lggPK2OHeE5yucCx4kse7RytlAnlnW+KlvL8hWaVpfZ5whbsph8GB8je6l091Kyvh3I7k/2qIOGoZylT5oYajOKkvDtdomV/xCgCIcGGnGrs+fJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhoi3Q5Tto1lUR8zax1REPelsvw0CnqNPVEqRsa/GlI=;
 b=WhdDLMPR2PxZSZyyg6NWST5V4XURFG3lCadzYiFpFL/NR187LeAx6xsY0lXXoUU8lfujk22LWeOd7bwsnYi29Dtljs3W63ATS0usM11zGCbMCyVdb2sFowo5LXyjtLTxT1HxK9ScfoDufyf47leRsQQt1CNx85ClAMtekLNz8ak=
Received: from CH0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:610:e7::7)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:59 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::77) by CH0PR03CA0212.outlook.office365.com
 (2603:10b6:610:e7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:59 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:58 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Ovidiu
 Bunea" <ovidiu.bunea@amd.com>
Subject: [PATCH 31/41] drm/amd/display: Add missing DCN42B register defines
Date: Fri, 31 Jul 2026 17:12:52 -0400
Message-ID: <20260731211302.3040343-32-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 429a9e3f-2250-4aa4-c74c-08deef48eb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lvST42T4V12/vLjuZfyqqDPde17hzogK3zBbWF7+mTtsC/08xKynLvs61dzAWpeynlXRH9BbB1An6KqKTUoR5qag9fKACcdL4kWZD9ucPsqCKPk2XKAZp1nQeEiHhrdjOZaX8tv4fFBhS7XAcxgskRcIGqzDSQhCZ3vjlOHpd6lS3z8yOsNBNVnTgEgT4hhPEVAJ5BvnMBwKYJWveOQrwQbGIy9eMypD8WdohYMVI1Rl9WPHQIEu93MNnWB5gct56fcBQAWBkgLAOlCK4z+fxPWGdLdwY7Y7VEz3wMr1slEmbR4DLNjXysuMs+mNQ8WXCJ7Qda2uZ5BWopMaSyR54VDBxlpfZ2H6bY5Iqmde09efArNbX/MgcgfYy+AM6stLoYIH9nmH3lHMtCK8J3U2ZD3bQ2HgYLOf30MOqsETHD/R9w15gkQJqoSHTX7bABa5mx1W3pI9XI7LZYMmzw1Iot3cVKdG6cYItZ9g7TbFRfG0edkfKZgJp6SAtvV0iszKHqI1itCe7IOMsL9YpCBgA6XDlg5YTTlH66FgkR114+od6ioIdl2xxLGAVl/S0y5qO3EDQnc+YanmeRTjjebKTb1N6rBBD1pkL/5LlU5zz+wCC5A/WcP7xHpg/FeIyVBqqTwwAje3qz5D1jBto6iDQEnfDZjsqlxHGECrht8XDVYf3L0TPySC5263BJsuFhGkE7jmiEjdFSQMP6sLB/q5ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EKoZMy6zgPhCiJwjcNeknGIYxXvAkl4+UT8Uh1Pn/QVd7k/kEUge9arTOYUbnoRqijLOUB+MhnxrJrtGC7fPOaDb6FYwM2CziUGwlx/VjJe2TTqL8qOdB2k4ujpIGVOpA2rSNkD7qpBRbNWmTZMNC0dxe+I/dJVjVz0UINZAlf9JwFpt2bGpF4laMZSaNe3Efil+h1/kWbgoKh/xBuVYQQFqPlDz3xMvib4CszDLxRnAbb81AHPUE0wgJ4nejUJqJa1ihL+noYhvm1QY+ekpcWRru27xDs9k5fP0358jxV5kRjgAWMp73qHQMrfcyjjYy6vV4QWCsq7U5CimZHOzUVYKqQwaii0p+nHKblhfQSuw2zZJQizA1i+4wQUXi9biu2y1tXLVvl5nvo1ZtjWn0MaRBwG+S2c2a/IW2BtxlDCukq2m93J7bSXG+SpxWFB+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:59.4825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 429a9e3f-2250-4aa4-c74c-08deef48eb2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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

These registers are used, but were missing from their corresponding lists.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.h   | 47 -------------------
 .../dc/resource/dcn42b/dcn42b_resource.c      | 19 +++++++-
 2 files changed, 17 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
index 66739c643e2f..d96fcc59cc0e 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
@@ -165,53 +165,6 @@
 	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_CONT_MODE_ENABLE, mask_sh),\
 	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL, HBLANK_MINIMUM_SYMBOL_WIDTH, mask_sh)
 
-/* Not in DCN42B:
- * SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_ENABLE, mask_sh),
- * SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL, CRC_CONT_MODE_ENABLE, mask_sh),
- * SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL, HBLANK_MINIMUM_SYMBOL_WIDTH, mask_sh),
- */
-#define DCN4_2B_HPO_DP_STREAM_ENC_MASK_SH_LIST(mask_sh)\
-	SE_SF(DP_STREAM_MAPPER_CONTROL0, DP_STREAM_LINK_TARGET, mask_sh),\
-	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_CLOCK_CONTROL, DP_STREAM_ENC_CLOCK_EN, mask_sh),\
-	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_INPUT_MUX_CONTROL, DP_STREAM_ENC_INPUT_MUX_PIXEL_STREAM_SOURCE_SEL, mask_sh),\
-	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_AUDIO_CONTROL, DP_STREAM_ENC_INPUT_MUX_AUDIO_STREAM_SOURCE_SEL, mask_sh),\
-	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_AUDIO_CONTROL, DP_STREAM_ENC_APG_CLOCK_EN, mask_sh),\
-	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET, mask_sh),\
-	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_RESET_DONE, mask_sh),\
-	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, FIFO_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_CONTROL, DP_SYM32_ENC_RESET, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_CONTROL, DP_SYM32_ENC_RESET_DONE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_CONTROL, DP_SYM32_ENC_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_PIXEL_FORMAT, PIXEL_ENCODING_TYPE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_PIXEL_FORMAT, UNCOMPRESSED_PIXEL_ENCODING, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_PIXEL_FORMAT, UNCOMPRESSED_COMPONENT_DEPTH, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_PIXEL_FORMAT_DOUBLE_BUFFER_CONTROL, PIXEL_FORMAT_DOUBLE_BUFFER_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_MSA_DOUBLE_BUFFER_CONTROL, MSA_DOUBLE_BUFFER_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC_VID_MSA, MSA_DATA_LANE_0, mask_sh),\
-	SE_SF(DP_SYM32_ENC_VID_MSA, MSA_DATA_LANE_1, mask_sh),\
-	SE_SF(DP_SYM32_ENC_VID_MSA, MSA_DATA_LANE_2, mask_sh),\
-	SE_SF(DP_SYM32_ENC_VID_MSA, MSA_DATA_LANE_3, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_FIFO_CONTROL, PIXEL_TO_SYMBOL_FIFO_RESET, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_FIFO_CONTROL, PIXEL_TO_SYMBOL_FIFO_RESET_DONE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_FIFO_CONTROL, PIXEL_TO_SYMBOL_FIFO_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_STREAM_CONTROL, VID_STREAM_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_STREAM_CONTROL, VID_STREAM_STATUS, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_VBID_CONTROL, VBID_6_COMPRESSEDSTREAM_FLAG_SOF_REFERENCE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_VID_VBID_CONTROL, VBID_6_COMPRESSEDSTREAM_FLAG_LINE_NUMBER, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_CONTROL, SDP_STREAM_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL0, GSP_VIDEO_CONTINUOUS_TRANSMISSION_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL0, GSP_PAYLOAD_SIZE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL0, GSP_TRANSMISSION_LINE_NUMBER, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL5, GSP_VIDEO_CONTINUOUS_TRANSMISSION_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL5, GSP_TRANSMISSION_LINE_NUMBER, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_GSP_CONTROL5, GSP_SOF_REFERENCE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL, METADATA_PACKET_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, AUDIO_MUTE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, ASP_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, ATP_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, AIP_ENABLE, mask_sh),\
-	SE_SF(DP_SYM32_ENC0_DP_SYM32_ENC_SDP_AUDIO_CONTROL0, ACM_ENABLE, mask_sh)
-
 
 #define DCN3_1_HPO_DP_STREAM_ENC_REG_FIELD_LIST(type) \
 	type DP_STREAM_LINK_TARGET;\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index dbd6267340ac..7b14d67314d5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -148,6 +148,21 @@
 #define regDP_SYM32_ENC2_DP_SYM32_ENC_HBLANK_CONTROL                                                    0x3813
 #define regDP_SYM32_ENC2_DP_SYM32_ENC_HBLANK_CONTROL_BASE_IDX                                           2
 
+#define DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_ENABLE__SHIFT                                         0x0
+#define DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_CONT_MODE_ENABLE__SHIFT                               0x4
+#define DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_ENABLE_MASK                                           0x00000001L
+#define DP_SYM32_ENC0_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_CONT_MODE_ENABLE_MASK                                 0x00000010L
+#define DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL__HBLANK_MINIMUM_SYMBOL_WIDTH__SHIFT                         0x0
+#define DP_SYM32_ENC0_DP_SYM32_ENC_HBLANK_CONTROL__HBLANK_MINIMUM_SYMBOL_WIDTH_MASK                           0x0000FFFFL
+
+
+#define DP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_ENABLE__SHIFT                                         0x0
+#define DP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_CONT_MODE_ENABLE__SHIFT                               0x4
+#define DP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_ENABLE_MASK                                           0x00000001L
+#define DP_SYM32_ENC1_DP_SYM32_ENC_VID_CRC_CONTROL__CRC_CONT_MODE_ENABLE_MASK                                 0x00000010L
+#define DP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL__HBLANK_MINIMUM_SYMBOL_WIDTH__SHIFT                         0x0
+#define DP_SYM32_ENC1_DP_SYM32_ENC_HBLANK_CONTROL__HBLANK_MINIMUM_SYMBOL_WIDTH_MASK                           0x0000FFFFL
+
 enum dcn401_clk_src_array_id {
 	DCN401_CLK_SRC_PLL0,
 	DCN401_CLK_SRC_PLL1,
@@ -370,10 +385,10 @@ static const struct dcn10_link_enc_mask le_mask = {
 static struct dcn31_hpo_dp_stream_encoder_registers hpo_dp_stream_enc_regs[4];
 
 static const struct dcn31_hpo_dp_stream_encoder_shift hpo_dp_se_shift = {
-	DCN4_2B_HPO_DP_STREAM_ENC_MASK_SH_LIST(__SHIFT)};
+	DCN4_2_HPO_DP_STREAM_ENC_MASK_SH_LIST(__SHIFT)};
 
 static const struct dcn31_hpo_dp_stream_encoder_mask hpo_dp_se_mask = {
-	DCN4_2B_HPO_DP_STREAM_ENC_MASK_SH_LIST(_MASK)};
+	DCN4_2_HPO_DP_STREAM_ENC_MASK_SH_LIST(_MASK)};
 
 #define hpo_dp_link_encoder_reg_init(id) \
 	DCN42B_HPO_DP_LINK_ENC_REG_LIST_RI(id)
-- 
2.34.1

