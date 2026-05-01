Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2C9CD3424
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 14:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179D710F545;
	Fri,  1 May 2026 14:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ey8To6pJ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF31510F545
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 14:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eevWBYMumC9Ff1KqkSvUD4EUvn+CaPuXLUqLoT9I8z0wKQuioL0ejO0pNOspJLHWsrEJ8AkB69e5qujl5G70elX94PTLlvcr32mvbPGRVh2llLn4YoEyn8QhkczFPzbfwvDwdVU9oezOiPj2360rQ9QWi1eJEhIv9meOv34LP/2R+gTKf2/O36gaV8U4sLau7DX/csZgdnB0PuslcwGBFv7XngRsxq9hORRWY+3HwIDfvquhdBam9V+QiQFHEIzx4pGKWKIrMAU5MnqSrgWhtv8mt3UxEL1f4hE/eWyrVlfhbG/qPP0sdrvfnIsJHmlD38v3xNJcmtdWDMpvyg0OXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87nnvSKK+M0L5Oo+tuQVefk96MlyiW6daarfJMav6vU=;
 b=UULHfAvx8OSh0TRiA+L8OHzM1+YWqyuq9YAYOW2I19RMw2MT+7hBl0LUMmpbVgyFUgMHnv2NdfJs91S2ZkL2Y1GDW80cvAnGAJH7AU74n95dpsoZQ1yStYH4QxpCZ9GzpeoiDppai9gIzFge96e0kG/ACpOYJtKxRNo69h7Vdy6IDsu61k5N2MNQiP8SFt1ZeDiXEQqB317b7jqV/yi+JcwSiaUuuP1ddyG5koYHfQcyTPLwrbC1X4Tgu2ECrB20pEGK/1ENiYP/BdJ8vCZ+MqyLPZKiwl0K2REhuMCRZmFnQVDFosIK0WYcW095+fEe9yLDf6TMhBYLtJ+24lBI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87nnvSKK+M0L5Oo+tuQVefk96MlyiW6daarfJMav6vU=;
 b=ey8To6pJH42N+mjRbQyiPkUeqqsjXLNTz9vDOyohH7sR3G0/3tMq/L42B2dxWIa/ToTQzyQqXm56booDfU7AUIiMFtGEk1vq2p3jCgV+JleX0xabQjZkCGU2k2BI+/6PyGUEHVm3D+dioO+VqL0O7nd301qSESTAJ/TEpMkHcM4=
Received: from CYZPR17CA0017.namprd17.prod.outlook.com (2603:10b6:930:8c::11)
 by CH1PPFF9270C127.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Fri, 1 May
 2026 14:05:02 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:930:8c:cafe::3) by CYZPR17CA0017.outlook.office365.com
 (2603:10b6:930:8c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Fri,
 1 May 2026 14:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 14:05:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 1 May
 2026 09:04:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 May
 2026 09:04:54 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 1 May 2026 09:04:54 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 07/21] drm/amd/display: Add FRL register for DCN302
Date: Fri, 1 May 2026 10:04:23 -0400
Message-ID: <20260501140441.41068-8-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501140441.41068-1-harry.wentland@amd.com>
References: <20260501140441.41068-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b5084c-daec-4b09-4801-08dea78aa3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZOwnqC4w5qxb1qccwP5ArbhZk6PXYnEShnB0GSpkKn8BVkQRCumO3TOezBYZY6Y+Zu40m1Fp5JYYAS8lJ7Kq3GiA/LuvcVi7nehlAUgVAWTpqazJ50ax8BuGdllvhwMGGWMQ5mjq964O9zYuZiHLoib+82hTdcQ7IK5X4/JWqXHA5WBTGkBllHolDDOtYrTHBMxilSB8+tvvYE/WnafNOMzP/1CD2m/USFoMhkooxLAvf4lgY+OmTKcNrtZ8j+LBix+DptfPBgWC4+U9l/sox7DhrmEVdBLddrqzGMa1xY8v00S+gVXpXgYDEW36wH1yhYh9geRRiGLLz8dP37uQJFXxR6TqBaX6yHBKpHys5Pi4LeWFHFSHj/2Ck7MlMn6de8HA1M6TgHUO7Th8tmdZm3wDRc532J/Us4WfHFAG0SyxSiSH3yt0E2pW3q5S2BaTHPY5lB8GmrUSB+tglhbw15BBNs5xJrpEJnBhjRhQk9/w5r6nVsRz/CIjfihZGQJ/ZmPPH3RpSGh+a4yy60R2up52kRcyXA+DVP6CVxy/mV6ru9SxkplnRxQKHhvta9GF8d00Wg9GIDe496+0I/2WjJBSSKgKCKw4cZEcSW6ZRYINz62mx1Rt0MGVt2g3G5T2jvvJ1aHMMY/OOwxjUETNhXf5lFuy3PG9AVa/zQXhR62wDratE2BPjVwPv+Vmv+n20MjRgHLFW1jjPSDLse4lndK4HpPE7uMbTfM4C8cqEXE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aObU0VLL5lTfUuxcifhnNf5qwnOqCIJ/bb383U1GdtFf6BIb0oR6MN8VzLNf+yfKZaPCanKT+y2ozE9IP13WpKCesKveXmxPWq/3jVaSXFB2/9+rteb5Y7i0/cNWtAqqNjAIvsk1MgoO5qgGnhAQ+DQnB6qS6gMhL26VKcuS0UijomwGvTgQ3kx7WVCLoWhrfBWXGJgIA93HkhhHDuNWeRNocJtp+zEWysh3Ruif6QsLGMQLRm4QItTTyjj5TDUf6gdZvEkhpZ6mRuHUcc5+V0zxX9EGIhb/t+cIYPxzPGz4p9bVr7szq9CK0/gePv3y/7ekLpCjckFkqV6cjpqG9+ctkVS32lRkQwp1TDHyS1g/7l2hVC8JJEzU+tNK+/YGKl48FUXHVO67kEgnf0u1hpSTvCAUzGVoa2yFtWwCvdJ/8eJnkk6ARXYyjHQyn53n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 14:05:02.6069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b5084c-daec-4b09-4801-08dea78aa3aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Add the required FRL registers for DCN302.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../include/asic_reg/dcn/dcn_3_0_2_offset.h   |  112 +
 .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  | 1907 +++++++++++++++++
 2 files changed, 2019 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
index b2962b5ce31e..47f09e233f47 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
@@ -14303,12 +14303,124 @@
 #define mmDC_PERFMON25_PERFMON_HI_BASE_IDX                                                             3
 #define mmDC_PERFMON25_PERFMON_LOW                                                                     0x08cf
 #define mmDC_PERFMON25_PERFMON_LOW_BASE_IDX                                                            3
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_dispdec
+// base address: 0x2634c
+#define mmHDMI_STREAM_ENC_CLOCK_CONTROL                                                                0x08d3
+#define mmHDMI_STREAM_ENC_CLOCK_CONTROL_BASE_IDX                                                       3
+#define mmHDMI_STREAM_ENC_HDMISTREAMCLK_CONTROL                                                        0x08d4
+#define mmHDMI_STREAM_ENC_HDMISTREAMCLK_CONTROL_BASE_IDX                                               3
+#define mmHDMI_STREAM_ENC_INPUT_MUX_CONTROL                                                            0x08d5
+#define mmHDMI_STREAM_ENC_INPUT_MUX_CONTROL_BASE_IDX                                                   3
+#define mmHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0                                     0x08d6
+#define mmHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0_BASE_IDX                            3
+#define mmHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1                                     0x08d7
+#define mmHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1_BASE_IDX                            3
+#define mmHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2                                     0x08d8
+#define mmHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2_BASE_IDX                            3
+
+// addressBlock: dce_dc_hpo_hdmi_tb_enc0_dispdec
+// base address: 0x2637c
+#define mmHDMI_TB_ENC_CONTROL                                                                          0x08df
+#define mmHDMI_TB_ENC_CONTROL_BASE_IDX                                                                 3
+#define mmHDMI_TB_ENC_PIXEL_FORMAT                                                                     0x08e0
+#define mmHDMI_TB_ENC_PIXEL_FORMAT_BASE_IDX                                                            3
+#define mmHDMI_TB_ENC_PACKET_CONTROL                                                                   0x08e1
+#define mmHDMI_TB_ENC_PACKET_CONTROL_BASE_IDX                                                          3
+#define mmHDMI_TB_ENC_ACR_PACKET_CONTROL                                                               0x08e2
+#define mmHDMI_TB_ENC_ACR_PACKET_CONTROL_BASE_IDX                                                      3
+#define mmHDMI_TB_ENC_VBI_PACKET_CONTROL1                                                              0x08e3
+#define mmHDMI_TB_ENC_VBI_PACKET_CONTROL1_BASE_IDX                                                     3
+#define mmHDMI_TB_ENC_VBI_PACKET_CONTROL2                                                              0x08e4
+#define mmHDMI_TB_ENC_VBI_PACKET_CONTROL2_BASE_IDX                                                     3
+#define mmHDMI_TB_ENC_GC_CONTROL                                                                       0x08e5
+#define mmHDMI_TB_ENC_GC_CONTROL_BASE_IDX                                                              3
+#define mmHDMI_TB_ENC_GENERIC_PACKET_CONTROL0                                                          0x08e6
+#define mmHDMI_TB_ENC_GENERIC_PACKET_CONTROL0_BASE_IDX                                                 3
+#define mmHDMI_TB_ENC_GENERIC_PACKET_CONTROL1                                                          0x08e7
+#define mmHDMI_TB_ENC_GENERIC_PACKET_CONTROL1_BASE_IDX                                                 3
+#define mmHDMI_TB_ENC_GENERIC_PACKET_CONTROL2                                                          0x08e8
+#define mmHDMI_TB_ENC_GENERIC_PACKET_CONTROL2_BASE_IDX                                                 3
+#define mmHDMI_TB_ENC_GENERIC_PACKET0_1_LINE                                                           0x08e9
+#define mmHDMI_TB_ENC_GENERIC_PACKET0_1_LINE_BASE_IDX                                                  3
+#define mmHDMI_TB_ENC_GENERIC_PACKET2_3_LINE                                                           0x08ea
+#define mmHDMI_TB_ENC_GENERIC_PACKET2_3_LINE_BASE_IDX                                                  3
+#define mmHDMI_TB_ENC_GENERIC_PACKET4_5_LINE                                                           0x08eb
+#define mmHDMI_TB_ENC_GENERIC_PACKET4_5_LINE_BASE_IDX                                                  3
+#define mmHDMI_TB_ENC_GENERIC_PACKET6_7_LINE                                                           0x08ec
+#define mmHDMI_TB_ENC_GENERIC_PACKET6_7_LINE_BASE_IDX                                                  3
+#define mmHDMI_TB_ENC_GENERIC_PACKET8_9_LINE                                                           0x08ed
+#define mmHDMI_TB_ENC_GENERIC_PACKET8_9_LINE_BASE_IDX                                                  3
+#define mmHDMI_TB_ENC_GENERIC_PACKET10_11_LINE                                                         0x08ee
+#define mmHDMI_TB_ENC_GENERIC_PACKET10_11_LINE_BASE_IDX                                                3
+#define mmHDMI_TB_ENC_GENERIC_PACKET12_13_LINE                                                         0x08ef
+#define mmHDMI_TB_ENC_GENERIC_PACKET12_13_LINE_BASE_IDX                                                3
+#define mmHDMI_TB_ENC_GENERIC_PACKET14_LINE                                                            0x08f0
+#define mmHDMI_TB_ENC_GENERIC_PACKET14_LINE_BASE_IDX                                                   3
+#define mmHDMI_TB_ENC_DB_CONTROL                                                                       0x08f1
+#define mmHDMI_TB_ENC_DB_CONTROL_BASE_IDX                                                              3
+#define mmHDMI_TB_ENC_ACR_32_0                                                                         0x08f2
+#define mmHDMI_TB_ENC_ACR_32_0_BASE_IDX                                                                3
+#define mmHDMI_TB_ENC_ACR_32_1                                                                         0x08f3
+#define mmHDMI_TB_ENC_ACR_32_1_BASE_IDX                                                                3
+#define mmHDMI_TB_ENC_ACR_44_0                                                                         0x08f4
+#define mmHDMI_TB_ENC_ACR_44_0_BASE_IDX                                                                3
+#define mmHDMI_TB_ENC_ACR_44_1                                                                         0x08f5
+#define mmHDMI_TB_ENC_ACR_44_1_BASE_IDX                                                                3
+#define mmHDMI_TB_ENC_ACR_48_0                                                                         0x08f6
+#define mmHDMI_TB_ENC_ACR_48_0_BASE_IDX                                                                3
+#define mmHDMI_TB_ENC_ACR_48_1                                                                         0x08f7
+#define mmHDMI_TB_ENC_ACR_48_1_BASE_IDX                                                                3
+#define mmHDMI_TB_ENC_ACR_STATUS_0                                                                     0x08f8
+#define mmHDMI_TB_ENC_ACR_STATUS_0_BASE_IDX                                                            3
+#define mmHDMI_TB_ENC_ACR_STATUS_1                                                                     0x08f9
+#define mmHDMI_TB_ENC_ACR_STATUS_1_BASE_IDX                                                            3
+#define mmHDMI_TB_ENC_BUFFER_CONTROL                                                                   0x08fb
+#define mmHDMI_TB_ENC_BUFFER_CONTROL_BASE_IDX                                                          3
+#define mmHDMI_TB_ENC_MEM_CTRL                                                                         0x08fe
+#define mmHDMI_TB_ENC_MEM_CTRL_BASE_IDX                                                                3
+#define mmHDMI_TB_ENC_METADATA_PACKET_CONTROL                                                          0x08ff
+#define mmHDMI_TB_ENC_METADATA_PACKET_CONTROL_BASE_IDX                                                 3
+#define mmHDMI_TB_ENC_H_ACTIVE_BLANK                                                                   0x0900
+#define mmHDMI_TB_ENC_H_ACTIVE_BLANK_BASE_IDX                                                          3
+#define mmHDMI_TB_ENC_HC_ACTIVE_BLANK                                                                  0x0901
+#define mmHDMI_TB_ENC_HC_ACTIVE_BLANK_BASE_IDX                                                         3
+#define mmHDMI_TB_ENC_CRC_CNTL                                                                         0x0903
+#define mmHDMI_TB_ENC_CRC_CNTL_BASE_IDX                                                                3
+#define mmHDMI_TB_ENC_CRC_RESULT_0                                                                     0x0904
+#define mmHDMI_TB_ENC_CRC_RESULT_0_BASE_IDX                                                            3
+#define mmHDMI_TB_ENC_MODE                                                                             0x0908
+#define mmHDMI_TB_ENC_MODE_BASE_IDX                                                                    3
+#define mmHDMI_TB_ENC_INPUT_FIFO_STATUS                                                                0x0909
+#define mmHDMI_TB_ENC_INPUT_FIFO_STATUS_BASE_IDX                                                       3
+#define mmHDMI_TB_ENC_CRC_RESULT_1                                                                     0x090a
+#define mmHDMI_TB_ENC_CRC_RESULT_1_BASE_IDX                                                            3
+
+
 // base address: 0x264f0
 #define mmDME5_DME_CONTROL                                                                             0x093c
 #define mmDME5_DME_CONTROL_BASE_IDX                                                                    3
 #define mmDME5_DME_MEMORY_CONTROL                                                                      0x093d
 #define mmDME5_DME_MEMORY_CONTROL_BASE_IDX                                                             3
 
+// addressBlock: dce_dc_hpo_hdmi_link_enc0_dispdec
+// base address: 0x2656c
+#define mmHDMI_LINK_ENC_CONTROL                                                                        0x095b
+#define mmHDMI_LINK_ENC_CONTROL_BASE_IDX                                                               3
+#define mmHDMI_LINK_ENC_CLK_CTRL                                                                       0x095c
+#define mmHDMI_LINK_ENC_CLK_CTRL_BASE_IDX                                                              3
+
+// addressBlock: dce_dc_hpo_hdmi_frl_enc0_dispdec
+// base address: 0x26594
+#define mmHDMI_FRL_ENC_CONFIG                                                                          0x0965
+#define mmHDMI_FRL_ENC_CONFIG_BASE_IDX                                                                 3
+#define mmHDMI_FRL_ENC_CONFIG2                                                                         0x0966
+#define mmHDMI_FRL_ENC_CONFIG2_BASE_IDX                                                                3
+#define mmHDMI_FRL_ENC_METER_BUFFER_STATUS                                                             0x0967
+#define mmHDMI_FRL_ENC_METER_BUFFER_STATUS_BASE_IDX                                                    3
+#define mmHDMI_FRL_ENC_MEM_CTRL                                                                        0x0968
+#define mmHDMI_FRL_ENC_MEM_CTRL_BASE_IDX                                                               3
+
 
 // addressBlock: dce_dc_hpo_hdmi_stream_enc0_hdcp2_hdcp2_dispdec
 // base address: 0x264f8
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
index 7f8f0a646422..e6e0d1bb9614 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
@@ -52453,10 +52453,1917 @@
 #define DC_PERFMON25_PERFMON_LOW__PERFMON_LOW__SHIFT                                                          0x0
 #define DC_PERFMON25_PERFMON_LOW__PERFMON_LOW_MASK                                                            0xFFFFFFFFL
 
+//HDMI_STREAM_ENC_INPUT_MUX_CONTROL
+#define HDMI_STREAM_ENC_INPUT_MUX_CONTROL__HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL__SHIFT                        0x0
+#define HDMI_STREAM_ENC_INPUT_MUX_CONTROL__HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL_MASK                          0x00000007L
+//HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ENABLE__SHIFT                          0x0
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_RESET__SHIFT                           0x4
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_PIXEL_ENCODING__SHIFT                  0x8
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ODM_COMBINE_MODE__SHIFT                0xc
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_DSC_MODE__SHIFT                        0x10
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_RESET_DONE__SHIFT                      0x14
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_VIDEO_STREAM_ACTIVE__SHIFT             0x18
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ERROR__SHIFT                           0x1c
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ENABLE_MASK                            0x00000001L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_RESET_MASK                             0x00000010L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_PIXEL_ENCODING_MASK                    0x00000300L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ODM_COMBINE_MODE_MASK                  0x00003000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_DSC_MODE_MASK                          0x00030000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_RESET_DONE_MASK                        0x00100000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_VIDEO_STREAM_ACTIVE_MASK               0x01000000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ERROR_MASK                             0x30000000L
+//HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_USE_OVERWRITE_LEVEL__SHIFT             0x0
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_FORCE_RECAL_AVERAGE__SHIFT             0x1
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_FORCE_RECOMP_MINMAX__SHIFT             0x2
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_OVERWRITE_LEVEL__SHIFT                 0x4
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_MINIMUM_LEVEL__SHIFT                   0xc
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_MAXIMUM_LEVEL__SHIFT                   0x10
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_CAL_AVERAGE_LEVEL__SHIFT               0x18
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_CALIBRATED__SHIFT                      0x1f
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_USE_OVERWRITE_LEVEL_MASK               0x00000001L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_FORCE_RECAL_AVERAGE_MASK               0x00000002L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_FORCE_RECOMP_MINMAX_MASK               0x00000004L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_OVERWRITE_LEVEL_MASK                   0x000003F0L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_MINIMUM_LEVEL_MASK                     0x0000F000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_MAXIMUM_LEVEL_MASK                     0x001F0000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_CAL_AVERAGE_LEVEL_MASK                 0x3F000000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_CALIBRATED_MASK                        0x80000000L
+//HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_READ_START_LEVEL__SHIFT                0x0
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_READ_CLOCK_SRC__SHIFT                  0x5
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_DB_PENDING__SHIFT                      0x8
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_DB_DISABLE__SHIFT                      0xc
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_READ_START_LEVEL_MASK                  0x0000001FL
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_READ_CLOCK_SRC_MASK                    0x00000020L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_DB_PENDING_MASK                        0x00000100L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_DB_DISABLE_MASK                        0x00001000L
+
+
+// addressBlock: dce_dc_hpo_hdmi_tb_enc0_dispdec
+//HDMI_TB_ENC_CONTROL
+#define HDMI_TB_ENC_CONTROL__HDMI_TB_ENC_EN__SHIFT                                                            0x0
+#define HDMI_TB_ENC_CONTROL__HDMI_RESET__SHIFT                                                                0x4
+#define HDMI_TB_ENC_CONTROL__HDMI_RESET_DONE__SHIFT                                                           0x8
+#define HDMI_TB_ENC_CONTROL__HDMI_TB_ENC_EN_MASK                                                              0x00000001L
+#define HDMI_TB_ENC_CONTROL__HDMI_RESET_MASK                                                                  0x00000010L
+#define HDMI_TB_ENC_CONTROL__HDMI_RESET_DONE_MASK                                                             0x00000100L
+//HDMI_TB_ENC_PIXEL_FORMAT
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DEEP_COLOR_ENABLE__SHIFT                                               0x0
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DEEP_COLOR_DEPTH__SHIFT                                                0x8
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_PIXEL_ENCODING__SHIFT                                                  0x10
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DSC_MODE__SHIFT                                                        0x18
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DEEP_COLOR_ENABLE_MASK                                                 0x00000001L
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DEEP_COLOR_DEPTH_MASK                                                  0x00000300L
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_PIXEL_ENCODING_MASK                                                    0x00030000L
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DSC_MODE_MASK                                                          0x03000000L
+//HDMI_TB_ENC_PACKET_CONTROL
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_MAX_PACKETS_PER_LINE__SHIFT                                          0x0
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_MAX_ISLANDS_PER_LINE__SHIFT                                          0x8
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_ACR_AUTO_SEND_OVERFLOW__SHIFT                                        0xc
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_TB_ENC_PACKET_ERROR_CLEAR__SHIFT                                     0x10
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_MAX_PACKETS_PER_LINE_MASK                                            0x0000001FL
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_MAX_ISLANDS_PER_LINE_MASK                                            0x00000300L
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_ACR_AUTO_SEND_OVERFLOW_MASK                                          0x00001000L
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_TB_ENC_PACKET_ERROR_CLEAR_MASK                                       0x00010000L
+//HDMI_TB_ENC_ACR_PACKET_CONTROL
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SEND__SHIFT                                                  0x0
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_CONT__SHIFT                                                  0x1
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SELECT__SHIFT                                                0x4
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SOURCE__SHIFT                                                0x8
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_AUTO_SEND__SHIFT                                             0xc
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_N_MULTIPLE__SHIFT                                            0x10
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_AUDIO_PRIORITY__SHIFT                                        0x1f
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SEND_MASK                                                    0x00000001L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_CONT_MASK                                                    0x00000002L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SELECT_MASK                                                  0x00000030L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SOURCE_MASK                                                  0x00000100L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_AUTO_SEND_MASK                                               0x00001000L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_N_MULTIPLE_MASK                                              0x00070000L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_AUDIO_PRIORITY_MASK                                          0x80000000L
+//HDMI_TB_ENC_VBI_PACKET_CONTROL1
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_GC_SEND__SHIFT                                                  0x0
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_GC_CONT__SHIFT                                                  0x1
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_SEND__SHIFT                                                0x4
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_CONT__SHIFT                                                0x5
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_LINE_REFERENCE__SHIFT                                      0x6
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ACP_SEND__SHIFT                                                 0x8
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ACP_LINE_REFERENCE__SHIFT                                       0x9
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_SEND__SHIFT                                          0xc
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_CONT__SHIFT                                          0xd
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_LINE_REFERENCE__SHIFT                                0xe
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_LINE__SHIFT                                          0x10
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_GC_SEND_MASK                                                    0x00000001L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_GC_CONT_MASK                                                    0x00000002L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_SEND_MASK                                                  0x00000010L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_CONT_MASK                                                  0x00000020L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_LINE_REFERENCE_MASK                                        0x00000040L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ACP_SEND_MASK                                                   0x00000100L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ACP_LINE_REFERENCE_MASK                                         0x00000200L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_SEND_MASK                                            0x00001000L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_CONT_MASK                                            0x00002000L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_LINE_REFERENCE_MASK                                  0x00004000L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_LINE_MASK                                            0x7FFF0000L
+//HDMI_TB_ENC_VBI_PACKET_CONTROL2
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL2__HDMI_ISRC_LINE__SHIFT                                                0x0
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL2__HDMI_ACP_LINE__SHIFT                                                 0x10
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL2__HDMI_ISRC_LINE_MASK                                                  0x00007FFFL
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL2__HDMI_ACP_LINE_MASK                                                   0x7FFF0000L
+//HDMI_TB_ENC_GC_CONTROL
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_GC_AVMUTE__SHIFT                                                         0x0
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_GC_AVMUTE_CONT__SHIFT                                                    0x2
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_DEFAULT_PHASE__SHIFT                                                     0x4
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_GC_AVMUTE_MASK                                                           0x00000001L
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_GC_AVMUTE_CONT_MASK                                                      0x00000004L
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_DEFAULT_PHASE_MASK                                                       0x00000010L
+//HDMI_TB_ENC_GENERIC_PACKET_CONTROL0
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_SEND__SHIFT                                        0x0
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_CONT__SHIFT                                        0x1
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_LOCK_EN__SHIFT                                     0x2
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_LINE_REFERENCE__SHIFT                              0x3
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_SEND__SHIFT                                        0x4
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_CONT__SHIFT                                        0x5
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_LOCK_EN__SHIFT                                     0x6
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_LINE_REFERENCE__SHIFT                              0x7
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_SEND__SHIFT                                        0x8
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_CONT__SHIFT                                        0x9
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_LOCK_EN__SHIFT                                     0xa
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_LINE_REFERENCE__SHIFT                              0xb
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_SEND__SHIFT                                        0xc
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_CONT__SHIFT                                        0xd
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_LOCK_EN__SHIFT                                     0xe
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_LINE_REFERENCE__SHIFT                              0xf
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_SEND__SHIFT                                        0x10
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_CONT__SHIFT                                        0x11
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_LOCK_EN__SHIFT                                     0x12
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_LINE_REFERENCE__SHIFT                              0x13
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_SEND__SHIFT                                        0x14
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_CONT__SHIFT                                        0x15
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_LOCK_EN__SHIFT                                     0x16
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_LINE_REFERENCE__SHIFT                              0x17
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_SEND__SHIFT                                        0x18
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_CONT__SHIFT                                        0x19
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_LOCK_EN__SHIFT                                     0x1a
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_LINE_REFERENCE__SHIFT                              0x1b
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_SEND__SHIFT                                        0x1c
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_CONT__SHIFT                                        0x1d
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_LOCK_EN__SHIFT                                     0x1e
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_LINE_REFERENCE__SHIFT                              0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_SEND_MASK                                          0x00000001L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_CONT_MASK                                          0x00000002L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_LOCK_EN_MASK                                       0x00000004L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_LINE_REFERENCE_MASK                                0x00000008L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_SEND_MASK                                          0x00000010L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_CONT_MASK                                          0x00000020L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_LOCK_EN_MASK                                       0x00000040L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_LINE_REFERENCE_MASK                                0x00000080L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_SEND_MASK                                          0x00000100L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_CONT_MASK                                          0x00000200L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_LOCK_EN_MASK                                       0x00000400L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_LINE_REFERENCE_MASK                                0x00000800L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_SEND_MASK                                          0x00001000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_CONT_MASK                                          0x00002000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_LOCK_EN_MASK                                       0x00004000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_LINE_REFERENCE_MASK                                0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_SEND_MASK                                          0x00010000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_CONT_MASK                                          0x00020000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_LOCK_EN_MASK                                       0x00040000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_LINE_REFERENCE_MASK                                0x00080000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_SEND_MASK                                          0x00100000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_CONT_MASK                                          0x00200000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_LOCK_EN_MASK                                       0x00400000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_LINE_REFERENCE_MASK                                0x00800000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_SEND_MASK                                          0x01000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_CONT_MASK                                          0x02000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_LOCK_EN_MASK                                       0x04000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_LINE_REFERENCE_MASK                                0x08000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_SEND_MASK                                          0x10000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_CONT_MASK                                          0x20000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_LOCK_EN_MASK                                       0x40000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_LINE_REFERENCE_MASK                                0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET_CONTROL1
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_SEND__SHIFT                                        0x0
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_CONT__SHIFT                                        0x1
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_LOCK_EN__SHIFT                                     0x2
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_LINE_REFERENCE__SHIFT                              0x3
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_SEND__SHIFT                                        0x4
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_CONT__SHIFT                                        0x5
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_LOCK_EN__SHIFT                                     0x6
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_LINE_REFERENCE__SHIFT                              0x7
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_SEND__SHIFT                                       0x8
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_CONT__SHIFT                                       0x9
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_LOCK_EN__SHIFT                                    0xa
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_LINE_REFERENCE__SHIFT                             0xb
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_SEND__SHIFT                                       0xc
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_CONT__SHIFT                                       0xd
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_LOCK_EN__SHIFT                                    0xe
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_LINE_REFERENCE__SHIFT                             0xf
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_SEND__SHIFT                                       0x10
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_CONT__SHIFT                                       0x11
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_LOCK_EN__SHIFT                                    0x12
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_LINE_REFERENCE__SHIFT                             0x13
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_SEND__SHIFT                                       0x14
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_CONT__SHIFT                                       0x15
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_LOCK_EN__SHIFT                                    0x16
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_LINE_REFERENCE__SHIFT                             0x17
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_SEND__SHIFT                                       0x18
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_CONT__SHIFT                                       0x19
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_LOCK_EN__SHIFT                                    0x1a
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_LINE_REFERENCE__SHIFT                             0x1b
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_SEND_MASK                                          0x00000001L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_CONT_MASK                                          0x00000002L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_LOCK_EN_MASK                                       0x00000004L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_LINE_REFERENCE_MASK                                0x00000008L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_SEND_MASK                                          0x00000010L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_CONT_MASK                                          0x00000020L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_LOCK_EN_MASK                                       0x00000040L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_LINE_REFERENCE_MASK                                0x00000080L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_SEND_MASK                                         0x00000100L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_CONT_MASK                                         0x00000200L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_LOCK_EN_MASK                                      0x00000400L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_LINE_REFERENCE_MASK                               0x00000800L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_SEND_MASK                                         0x00001000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_CONT_MASK                                         0x00002000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_LOCK_EN_MASK                                      0x00004000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_LINE_REFERENCE_MASK                               0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_SEND_MASK                                         0x00010000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_CONT_MASK                                         0x00020000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_LOCK_EN_MASK                                      0x00040000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_LINE_REFERENCE_MASK                               0x00080000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_SEND_MASK                                         0x00100000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_CONT_MASK                                         0x00200000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_LOCK_EN_MASK                                      0x00400000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_LINE_REFERENCE_MASK                               0x00800000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_SEND_MASK                                         0x01000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_CONT_MASK                                         0x02000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_LOCK_EN_MASK                                      0x04000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_LINE_REFERENCE_MASK                               0x08000000L
+//HDMI_TB_ENC_GENERIC_PACKET_CONTROL2
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC0_IMMEDIATE_SEND__SHIFT                              0x0
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC0_IMMEDIATE_SEND_PENDING__SHIFT                      0x1
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC1_IMMEDIATE_SEND__SHIFT                              0x2
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC1_IMMEDIATE_SEND_PENDING__SHIFT                      0x3
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC2_IMMEDIATE_SEND__SHIFT                              0x4
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC2_IMMEDIATE_SEND_PENDING__SHIFT                      0x5
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC3_IMMEDIATE_SEND__SHIFT                              0x6
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC3_IMMEDIATE_SEND_PENDING__SHIFT                      0x7
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC4_IMMEDIATE_SEND__SHIFT                              0x8
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC4_IMMEDIATE_SEND_PENDING__SHIFT                      0x9
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC5_IMMEDIATE_SEND__SHIFT                              0xa
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC5_IMMEDIATE_SEND_PENDING__SHIFT                      0xb
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC6_IMMEDIATE_SEND__SHIFT                              0xc
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC6_IMMEDIATE_SEND_PENDING__SHIFT                      0xd
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC7_IMMEDIATE_SEND__SHIFT                              0xe
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC7_IMMEDIATE_SEND_PENDING__SHIFT                      0xf
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC8_IMMEDIATE_SEND__SHIFT                              0x10
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC8_IMMEDIATE_SEND_PENDING__SHIFT                      0x11
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC9_IMMEDIATE_SEND__SHIFT                              0x12
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC9_IMMEDIATE_SEND_PENDING__SHIFT                      0x13
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC10_IMMEDIATE_SEND__SHIFT                             0x14
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC10_IMMEDIATE_SEND_PENDING__SHIFT                     0x15
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC11_IMMEDIATE_SEND__SHIFT                             0x16
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC11_IMMEDIATE_SEND_PENDING__SHIFT                     0x17
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC12_IMMEDIATE_SEND__SHIFT                             0x18
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC12_IMMEDIATE_SEND_PENDING__SHIFT                     0x19
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC13_IMMEDIATE_SEND__SHIFT                             0x1a
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC13_IMMEDIATE_SEND_PENDING__SHIFT                     0x1b
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC14_IMMEDIATE_SEND__SHIFT                             0x1c
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC14_IMMEDIATE_SEND_PENDING__SHIFT                     0x1d
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC0_IMMEDIATE_SEND_MASK                                0x00000001L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC0_IMMEDIATE_SEND_PENDING_MASK                        0x00000002L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC1_IMMEDIATE_SEND_MASK                                0x00000004L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC1_IMMEDIATE_SEND_PENDING_MASK                        0x00000008L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC2_IMMEDIATE_SEND_MASK                                0x00000010L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC2_IMMEDIATE_SEND_PENDING_MASK                        0x00000020L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC3_IMMEDIATE_SEND_MASK                                0x00000040L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC3_IMMEDIATE_SEND_PENDING_MASK                        0x00000080L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC4_IMMEDIATE_SEND_MASK                                0x00000100L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC4_IMMEDIATE_SEND_PENDING_MASK                        0x00000200L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC5_IMMEDIATE_SEND_MASK                                0x00000400L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC5_IMMEDIATE_SEND_PENDING_MASK                        0x00000800L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC6_IMMEDIATE_SEND_MASK                                0x00001000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC6_IMMEDIATE_SEND_PENDING_MASK                        0x00002000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC7_IMMEDIATE_SEND_MASK                                0x00004000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC7_IMMEDIATE_SEND_PENDING_MASK                        0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC8_IMMEDIATE_SEND_MASK                                0x00010000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC8_IMMEDIATE_SEND_PENDING_MASK                        0x00020000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC9_IMMEDIATE_SEND_MASK                                0x00040000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC9_IMMEDIATE_SEND_PENDING_MASK                        0x00080000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC10_IMMEDIATE_SEND_MASK                               0x00100000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC10_IMMEDIATE_SEND_PENDING_MASK                       0x00200000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC11_IMMEDIATE_SEND_MASK                               0x00400000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC11_IMMEDIATE_SEND_PENDING_MASK                       0x00800000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC12_IMMEDIATE_SEND_MASK                               0x01000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC12_IMMEDIATE_SEND_PENDING_MASK                       0x02000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC13_IMMEDIATE_SEND_MASK                               0x04000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC13_IMMEDIATE_SEND_PENDING_MASK                       0x08000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC14_IMMEDIATE_SEND_MASK                               0x10000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC14_IMMEDIATE_SEND_PENDING_MASK                       0x20000000L
+//HDMI_TB_ENC_GENERIC_PACKET0_1_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC0_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC0_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC1_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC1_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC0_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC0_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC1_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC1_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET2_3_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC2_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC2_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC3_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC3_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC2_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC2_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC3_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC3_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET4_5_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC4_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC4_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC5_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC5_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC4_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC4_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC5_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC5_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET6_7_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC6_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC6_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC7_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC7_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC6_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC6_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC7_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC7_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET8_9_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC8_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC8_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC9_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC9_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC8_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC8_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC9_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC9_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET10_11_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC10_LINE__SHIFT                                      0x0
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC10_EMP__SHIFT                                       0xf
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC11_LINE__SHIFT                                      0x10
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC11_EMP__SHIFT                                       0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC10_LINE_MASK                                        0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC10_EMP_MASK                                         0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC11_LINE_MASK                                        0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC11_EMP_MASK                                         0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET12_13_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC12_LINE__SHIFT                                      0x0
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC12_EMP__SHIFT                                       0xf
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC13_LINE__SHIFT                                      0x10
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC13_EMP__SHIFT                                       0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC12_LINE_MASK                                        0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC12_EMP_MASK                                         0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC13_LINE_MASK                                        0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC13_EMP_MASK                                         0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET14_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET14_LINE__HDMI_GENERIC14_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET14_LINE__HDMI_GENERIC14_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET14_LINE__HDMI_GENERIC14_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET14_LINE__HDMI_GENERIC14_EMP_MASK                                            0x00008000L
+//HDMI_TB_ENC_DB_CONTROL
+#define HDMI_TB_ENC_DB_CONTROL__HDMI_DB_PENDING__SHIFT                                                        0x0
+#define HDMI_TB_ENC_DB_CONTROL__HDMI_DB_DISABLE__SHIFT                                                        0xc
+#define HDMI_TB_ENC_DB_CONTROL__VUPDATE_DB_PENDING__SHIFT                                                     0xf
+#define HDMI_TB_ENC_DB_CONTROL__HDMI_DB_PENDING_MASK                                                          0x00000001L
+#define HDMI_TB_ENC_DB_CONTROL__HDMI_DB_DISABLE_MASK                                                          0x00001000L
+#define HDMI_TB_ENC_DB_CONTROL__VUPDATE_DB_PENDING_MASK                                                       0x00008000L
+//HDMI_TB_ENC_ACR_32_0
+#define HDMI_TB_ENC_ACR_32_0__HDMI_ACR_CTS_32__SHIFT                                                          0xc
+#define HDMI_TB_ENC_ACR_32_0__HDMI_ACR_CTS_32_MASK                                                            0xFFFFF000L
+//HDMI_TB_ENC_ACR_32_1
+#define HDMI_TB_ENC_ACR_32_1__HDMI_ACR_N_32__SHIFT                                                            0x0
+#define HDMI_TB_ENC_ACR_32_1__HDMI_ACR_N_32_MASK                                                              0x000FFFFFL
+//HDMI_TB_ENC_ACR_44_0
+#define HDMI_TB_ENC_ACR_44_0__HDMI_ACR_CTS_44__SHIFT                                                          0xc
+#define HDMI_TB_ENC_ACR_44_0__HDMI_ACR_CTS_44_MASK                                                            0xFFFFF000L
+//HDMI_TB_ENC_ACR_44_1
+#define HDMI_TB_ENC_ACR_44_1__HDMI_ACR_N_44__SHIFT                                                            0x0
+#define HDMI_TB_ENC_ACR_44_1__HDMI_ACR_N_44_MASK                                                              0x000FFFFFL
+//HDMI_TB_ENC_ACR_48_0
+#define HDMI_TB_ENC_ACR_48_0__HDMI_ACR_CTS_48__SHIFT                                                          0xc
+#define HDMI_TB_ENC_ACR_48_0__HDMI_ACR_CTS_48_MASK                                                            0xFFFFF000L
+//HDMI_TB_ENC_ACR_48_1
+#define HDMI_TB_ENC_ACR_48_1__HDMI_ACR_N_48__SHIFT                                                            0x0
+#define HDMI_TB_ENC_ACR_48_1__HDMI_ACR_N_48_MASK                                                              0x000FFFFFL
+//HDMI_TB_ENC_ACR_STATUS_0
+#define HDMI_TB_ENC_ACR_STATUS_0__HDMI_ACR_CTS__SHIFT                                                         0xc
+#define HDMI_TB_ENC_ACR_STATUS_0__HDMI_ACR_CTS_MASK                                                           0xFFFFF000L
+//HDMI_TB_ENC_ACR_STATUS_1
+#define HDMI_TB_ENC_ACR_STATUS_1__HDMI_ACR_N__SHIFT                                                           0x0
+#define HDMI_TB_ENC_ACR_STATUS_1__HDMI_ACR_N_MASK                                                             0x000FFFFFL
+//HDMI_TB_ENC_BUFFER_CONTROL
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_PREFILL_OVERRIDE_EN__SHIFT                              0x0
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_RATE_BUFFER_PREFILL_OVERRIDE_EN__SHIFT                               0x1
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_MAX_MIN_LEVEL_RESET__SHIFT                              0x4
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_PREFILL_OVERRIDE_LEVEL__SHIFT                           0x8
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_RATE_BUFFER_PREFILL_OVERRIDE_LEVEL__SHIFT                            0x18
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_PREFILL_OVERRIDE_EN_MASK                                0x00000001L
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_RATE_BUFFER_PREFILL_OVERRIDE_EN_MASK                                 0x00000002L
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_MAX_MIN_LEVEL_RESET_MASK                                0x00000010L
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_PREFILL_OVERRIDE_LEVEL_MASK                             0x0000FF00L
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_RATE_BUFFER_PREFILL_OVERRIDE_LEVEL_MASK                              0x1F000000L
+//HDMI_TB_ENC_MEM_CTRL
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_DIS__SHIFT                                                 0x0
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_FORCE__SHIFT                                               0x1
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_STATE__SHIFT                                               0x4
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE__SHIFT                             0x8
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_DIS_MASK                                                   0x00000001L
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_FORCE_MASK                                                 0x00000006L
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_STATE_MASK                                                 0x00000030L
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE_MASK                               0x00000300L
+//HDMI_TB_ENC_METADATA_PACKET_CONTROL
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_ENABLE__SHIFT                               0x0
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_LINE_REFERENCE__SHIFT                       0x4
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_MISSED__SHIFT                               0x8
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_LINE__SHIFT                                 0x10
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_ENABLE_MASK                                 0x00000001L
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_LINE_REFERENCE_MASK                         0x00000010L
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_MISSED_MASK                                 0x00000100L
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_LINE_MASK                                   0xFFFF0000L
+//HDMI_TB_ENC_H_ACTIVE_BLANK
+#define HDMI_TB_ENC_H_ACTIVE_BLANK__HDMI_H_ACTIVE__SHIFT                                                      0x0
+#define HDMI_TB_ENC_H_ACTIVE_BLANK__HDMI_H_BLANK__SHIFT                                                       0x10
+#define HDMI_TB_ENC_H_ACTIVE_BLANK__HDMI_H_ACTIVE_MASK                                                        0x00007FFFL
+#define HDMI_TB_ENC_H_ACTIVE_BLANK__HDMI_H_BLANK_MASK                                                         0x7FFF0000L
+//HDMI_TB_ENC_HC_ACTIVE_BLANK
+#define HDMI_TB_ENC_HC_ACTIVE_BLANK__HDMI_HC_ACTIVE__SHIFT                                                    0x0
+#define HDMI_TB_ENC_HC_ACTIVE_BLANK__HDMI_HC_BLANK__SHIFT                                                     0x10
+#define HDMI_TB_ENC_HC_ACTIVE_BLANK__HDMI_HC_ACTIVE_MASK                                                      0x00007FFFL
+#define HDMI_TB_ENC_HC_ACTIVE_BLANK__HDMI_HC_BLANK_MASK                                                       0x7FFF0000L
+//HDMI_TB_ENC_CRC_CNTL
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_EN__SHIFT                                                              0x0
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_CONT_EN__SHIFT                                                         0x1
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_TYPE__SHIFT                                                            0x8
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_SRC_SEL__SHIFT                                                         0xa
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_INTERLACE_EN__SHIFT                                                    0x10
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_INTERLACE_MODE__SHIFT                                                  0x11
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_EN_MASK                                                                0x00000001L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_CONT_EN_MASK                                                           0x00000002L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_TYPE_MASK                                                              0x00000300L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_SRC_SEL_MASK                                                           0x00000C00L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_INTERLACE_EN_MASK                                                      0x00010000L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_INTERLACE_MODE_MASK                                                    0x00060000L
+//HDMI_TB_ENC_CRC_RESULT_0
+#define HDMI_TB_ENC_CRC_RESULT_0__CRC_TRIBYTE0__SHIFT                                                         0x0
+#define HDMI_TB_ENC_CRC_RESULT_0__CRC_TRIBYTE1__SHIFT                                                         0x10
+#define HDMI_TB_ENC_CRC_RESULT_0__CRC_TRIBYTE0_MASK                                                           0x0000FFFFL
+#define HDMI_TB_ENC_CRC_RESULT_0__CRC_TRIBYTE1_MASK                                                           0xFFFF0000L
+//HDMI_TB_ENC_MODE
+#define HDMI_TB_ENC_MODE__HDMI_BORROW_MODE__SHIFT                                                             0x0
+#define HDMI_TB_ENC_MODE__HDMI_SKIP_FIRST_HBLANK__SHIFT                                                       0x8
+#define HDMI_TB_ENC_MODE__HDMI_BORROW_MODE_MASK                                                               0x00000003L
+#define HDMI_TB_ENC_MODE__HDMI_SKIP_FIRST_HBLANK_MASK                                                         0x00000100L
+//HDMI_TB_ENC_INPUT_FIFO_STATUS
+#define HDMI_TB_ENC_INPUT_FIFO_STATUS__INPUT_FIFO_ERROR__SHIFT                                                0x0
+#define HDMI_TB_ENC_INPUT_FIFO_STATUS__INPUT_FIFO_ERROR_MASK                                                  0x00000001L
+//HDMI_TB_ENC_CRC_RESULT_1
+#define HDMI_TB_ENC_CRC_RESULT_1__CRC_TRIBYTE2__SHIFT                                                         0x0
+#define HDMI_TB_ENC_CRC_RESULT_1__CRC_TRIBYTE2_MASK                                                           0x0000FFFFL
+
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_afmt_afmt_dispdec
+//AFMT5_AFMT_ACP
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE__SHIFT                                                                  0x0
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE0__SHIFT                                                  0x8
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE1__SHIFT                                                  0x10
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_MASK                                                                    0x00000003L
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE0_MASK                                                    0x0000FF00L
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE1_MASK                                                    0x00FF0000L
+//AFMT5_AFMT_VBI_PACKET_CONTROL
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_ACP_SOURCE__SHIFT                                                 0xd
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_PACKETS_PER_LINE__SHIFT                                0x10
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_SEND_MAX_PACKETS__SHIFT                                0x18
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_ACP_SOURCE_MASK                                                   0x00002000L
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_PACKETS_PER_LINE_MASK                                  0x001F0000L
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_SEND_MAX_PACKETS_MASK                                  0x01000000L
+//AFMT5_AFMT_AUDIO_PACKET_CONTROL2
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_OVRD__SHIFT                                       0x0
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_SELECT__SHIFT                                     0x1
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_CHANNEL_ENABLE__SHIFT                                    0x8
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_DP_AUDIO_STREAM_ID__SHIFT                                      0x10
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_HBR_ENABLE_OVRD__SHIFT                                         0x18
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_60958_OSF_OVRD__SHIFT                                          0x1c
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_OVRD_MASK                                         0x00000001L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_SELECT_MASK                                       0x00000002L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_CHANNEL_ENABLE_MASK                                      0x0000FF00L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_DP_AUDIO_STREAM_ID_MASK                                        0x00FF0000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_HBR_ENABLE_OVRD_MASK                                           0x01000000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_60958_OSF_OVRD_MASK                                            0x10000000L
+//AFMT5_AFMT_AUDIO_INFO0
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM__SHIFT                                               0x0
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CC__SHIFT                                                     0x8
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CT__SHIFT                                                     0xb
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM_OFFSET__SHIFT                                        0x10
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CXT__SHIFT                                                    0x18
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM_MASK                                                 0x000000FFL
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CC_MASK                                                       0x00000700L
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CT_MASK                                                       0x00007800L
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM_OFFSET_MASK                                          0x00FF0000L
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CXT_MASK                                                      0x1F000000L
+//AFMT5_AFMT_AUDIO_INFO1
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_CA__SHIFT                                                     0x0
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LSV__SHIFT                                                    0xb
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_DM_INH__SHIFT                                                 0xf
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LFEPBL__SHIFT                                                 0x10
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_CA_MASK                                                       0x000000FFL
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LSV_MASK                                                      0x00007800L
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_DM_INH_MASK                                                   0x00008000L
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LFEPBL_MASK                                                   0x00030000L
+//AFMT5_AFMT_60958_0
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_A__SHIFT                                                            0x0
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_B__SHIFT                                                            0x1
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_C__SHIFT                                                            0x2
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_D__SHIFT                                                            0x3
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_MODE__SHIFT                                                         0x6
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CATEGORY_CODE__SHIFT                                                0x8
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_SOURCE_NUMBER__SHIFT                                                0x10
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CHANNEL_NUMBER_L__SHIFT                                             0x14
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_SAMPLING_FREQUENCY__SHIFT                                           0x18
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CLOCK_ACCURACY__SHIFT                                               0x1c
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_A_MASK                                                              0x00000001L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_B_MASK                                                              0x00000002L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_C_MASK                                                              0x00000004L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_D_MASK                                                              0x00000038L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_MODE_MASK                                                           0x000000C0L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CATEGORY_CODE_MASK                                                  0x0000FF00L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_SOURCE_NUMBER_MASK                                                  0x000F0000L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CHANNEL_NUMBER_L_MASK                                               0x00F00000L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_SAMPLING_FREQUENCY_MASK                                             0x0F000000L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CLOCK_ACCURACY_MASK                                                 0x30000000L
+//AFMT5_AFMT_60958_1
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_WORD_LENGTH__SHIFT                                                  0x0
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_ORIGINAL_SAMPLING_FREQUENCY__SHIFT                                  0x4
+#define AFMT5_AFMT_60958_1__AFMT_60958_VALID_L__SHIFT                                                         0x10
+#define AFMT5_AFMT_60958_1__AFMT_60958_VALID_R__SHIFT                                                         0x12
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_CHANNEL_NUMBER_R__SHIFT                                             0x14
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_WORD_LENGTH_MASK                                                    0x0000000FL
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_ORIGINAL_SAMPLING_FREQUENCY_MASK                                    0x000000F0L
+#define AFMT5_AFMT_60958_1__AFMT_60958_VALID_L_MASK                                                           0x00010000L
+#define AFMT5_AFMT_60958_1__AFMT_60958_VALID_R_MASK                                                           0x00040000L
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_CHANNEL_NUMBER_R_MASK                                               0x00F00000L
+//AFMT5_AFMT_AUDIO_CRC_CONTROL
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_EN__SHIFT                                                0x0
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CONT__SHIFT                                              0x4
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_SOURCE__SHIFT                                            0x8
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CH_SEL__SHIFT                                            0xc
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_COUNT__SHIFT                                             0x10
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_EN_MASK                                                  0x00000001L
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CONT_MASK                                                0x00000010L
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_SOURCE_MASK                                              0x00000100L
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CH_SEL_MASK                                              0x0000F000L
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_COUNT_MASK                                               0xFFFF0000L
+//AFMT5_AFMT_RAMP_CONTROL0
+#define AFMT5_AFMT_RAMP_CONTROL0__AFMT_RAMP_MAX_COUNT__SHIFT                                                  0x0
+#define AFMT5_AFMT_RAMP_CONTROL0__AFMT_RAMP_DATA_SIGN__SHIFT                                                  0x1f
+#define AFMT5_AFMT_RAMP_CONTROL0__AFMT_RAMP_MAX_COUNT_MASK                                                    0x00FFFFFFL
+#define AFMT5_AFMT_RAMP_CONTROL0__AFMT_RAMP_DATA_SIGN_MASK                                                    0x80000000L
+//AFMT5_AFMT_RAMP_CONTROL1
+#define AFMT5_AFMT_RAMP_CONTROL1__AFMT_RAMP_MIN_COUNT__SHIFT                                                  0x0
+#define AFMT5_AFMT_RAMP_CONTROL1__AFMT_AUDIO_TEST_CH_DISABLE__SHIFT                                           0x18
+#define AFMT5_AFMT_RAMP_CONTROL1__AFMT_RAMP_MIN_COUNT_MASK                                                    0x00FFFFFFL
+#define AFMT5_AFMT_RAMP_CONTROL1__AFMT_AUDIO_TEST_CH_DISABLE_MASK                                             0xFF000000L
+//AFMT5_AFMT_RAMP_CONTROL2
+#define AFMT5_AFMT_RAMP_CONTROL2__AFMT_RAMP_INC_COUNT__SHIFT                                                  0x0
+#define AFMT5_AFMT_RAMP_CONTROL2__AFMT_RAMP_INC_COUNT_MASK                                                    0x00FFFFFFL
+//AFMT5_AFMT_RAMP_CONTROL3
+#define AFMT5_AFMT_RAMP_CONTROL3__AFMT_RAMP_DEC_COUNT__SHIFT                                                  0x0
+#define AFMT5_AFMT_RAMP_CONTROL3__AFMT_RAMP_DEC_COUNT_MASK                                                    0x00FFFFFFL
+//AFMT5_AFMT_60958_2
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_2__SHIFT                                             0x0
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_3__SHIFT                                             0x4
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_4__SHIFT                                             0x8
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_5__SHIFT                                             0xc
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_6__SHIFT                                             0x10
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_7__SHIFT                                             0x14
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_2_MASK                                               0x0000000FL
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_3_MASK                                               0x000000F0L
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_4_MASK                                               0x00000F00L
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_5_MASK                                               0x0000F000L
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_6_MASK                                               0x000F0000L
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_7_MASK                                               0x00F00000L
+//AFMT5_AFMT_AUDIO_CRC_RESULT
+#define AFMT5_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC_DONE__SHIFT                                               0x0
+#define AFMT5_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC__SHIFT                                                    0x8
+#define AFMT5_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC_DONE_MASK                                                 0x00000001L
+#define AFMT5_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC_MASK                                                      0xFFFFFF00L
+//AFMT5_AFMT_STATUS
+#define AFMT5_AFMT_STATUS__AFMT_AUDIO_ENABLE__SHIFT                                                           0x4
+#define AFMT5_AFMT_STATUS__AFMT_AZ_HBR_ENABLE__SHIFT                                                          0x8
+#define AFMT5_AFMT_STATUS__AFMT_AUDIO_FIFO_OVERFLOW__SHIFT                                                    0x18
+#define AFMT5_AFMT_STATUS__AFMT_AZ_AUDIO_ENABLE_CHG__SHIFT                                                    0x1e
+#define AFMT5_AFMT_STATUS__AFMT_AUDIO_ENABLE_MASK                                                             0x00000010L
+#define AFMT5_AFMT_STATUS__AFMT_AZ_HBR_ENABLE_MASK                                                            0x00000100L
+#define AFMT5_AFMT_STATUS__AFMT_AUDIO_FIFO_OVERFLOW_MASK                                                      0x01000000L
+#define AFMT5_AFMT_STATUS__AFMT_AZ_AUDIO_ENABLE_CHG_MASK                                                      0x40000000L
+//AFMT5_AFMT_AUDIO_PACKET_CONTROL
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND__SHIFT                                        0x0
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_DOUBLE_BUFFER_ENABLE__SHIFT                   0x4
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_RESET_FIFO_WHEN_AUDIO_DIS__SHIFT                                0xb
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_EN__SHIFT                                            0xc
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_MODE__SHIFT                                          0xe
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_FIFO_OVERFLOW_ACK__SHIFT                                  0x17
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_CHANNEL_SWAP__SHIFT                                       0x18
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_60958_CS_UPDATE__SHIFT                                          0x1a
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AZ_AUDIO_ENABLE_CHG_ACK__SHIFT                                  0x1e
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_BLANK_TEST_DATA_ON_ENC_ENB__SHIFT                               0x1f
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_MASK                                          0x00000001L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_DOUBLE_BUFFER_ENABLE_MASK                     0x00000010L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_RESET_FIFO_WHEN_AUDIO_DIS_MASK                                  0x00000800L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_EN_MASK                                              0x00001000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_MODE_MASK                                            0x00004000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_FIFO_OVERFLOW_ACK_MASK                                    0x00800000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_CHANNEL_SWAP_MASK                                         0x01000000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_60958_CS_UPDATE_MASK                                            0x04000000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AZ_AUDIO_ENABLE_CHG_ACK_MASK                                    0x40000000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_BLANK_TEST_DATA_ON_ENC_ENB_MASK                                 0x80000000L
+//AFMT5_AFMT_INFOFRAME_CONTROL0
+#define AFMT5_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_SOURCE__SHIFT                                          0x6
+#define AFMT5_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_UPDATE__SHIFT                                          0x7
+#define AFMT5_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_SOURCE_MASK                                            0x00000040L
+#define AFMT5_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_UPDATE_MASK                                            0x00000080L
+//AFMT5_AFMT_AUDIO_SRC_CONTROL
+#define AFMT5_AFMT_AUDIO_SRC_CONTROL__AFMT_AUDIO_SRC_SELECT__SHIFT                                            0x0
+#define AFMT5_AFMT_AUDIO_SRC_CONTROL__AFMT_AUDIO_SRC_SELECT_MASK                                              0x00000007L
+//AFMT5_AFMT_AUDIO_DBG_DTO_CNTL
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_FS_DIV_SEL__SHIFT                                       0x0
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_BASE__SHIFT                                         0x8
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_MULTI__SHIFT                                        0xc
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_DIV__SHIFT                                          0x10
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_FS_DIV_SEL_MASK                                         0x00000007L
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_BASE_MASK                                           0x00000100L
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_MULTI_MASK                                          0x00007000L
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_DIV_MASK                                            0x00070000L
+//AFMT5_AFMT_MEM_PWR
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_DIS__SHIFT                                                           0x0
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_FORCE__SHIFT                                                         0x4
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_STATE__SHIFT                                                         0x8
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_DIS_MASK                                                             0x00000001L
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_FORCE_MASK                                                           0x00000030L
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_STATE_MASK                                                           0x00000300L
+
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_vpg_vpg_dispdec
+//VPG5_VPG_GENERIC_PACKET_ACCESS_CTRL
+#define VPG5_VPG_GENERIC_PACKET_ACCESS_CTRL__VPG_GENERIC_DATA_INDEX__SHIFT                                    0x0
+#define VPG5_VPG_GENERIC_PACKET_ACCESS_CTRL__VPG_GENERIC_DATA_INDEX_MASK                                      0x000000FFL
+//VPG5_VPG_GENERIC_PACKET_DATA
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE0__SHIFT                                           0x0
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE1__SHIFT                                           0x8
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE2__SHIFT                                           0x10
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE3__SHIFT                                           0x18
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE0_MASK                                             0x000000FFL
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE1_MASK                                             0x0000FF00L
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE2_MASK                                             0x00FF0000L
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE3_MASK                                             0xFF000000L
+//VPG5_VPG_GSP_FRAME_UPDATE_CTRL
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE__SHIFT                                      0x0
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE__SHIFT                                      0x1
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE__SHIFT                                      0x2
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE__SHIFT                                      0x3
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE__SHIFT                                      0x4
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE__SHIFT                                      0x5
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE__SHIFT                                      0x6
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE__SHIFT                                      0x7
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE__SHIFT                                      0x8
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE__SHIFT                                      0x9
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE__SHIFT                                     0xa
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE__SHIFT                                     0xb
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE__SHIFT                                     0xc
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE__SHIFT                                     0xd
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE__SHIFT                                     0xe
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE_PENDING__SHIFT                              0x10
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE_PENDING__SHIFT                              0x11
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE_PENDING__SHIFT                              0x12
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE_PENDING__SHIFT                              0x13
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE_PENDING__SHIFT                              0x14
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE_PENDING__SHIFT                              0x15
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE_PENDING__SHIFT                              0x16
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE_PENDING__SHIFT                              0x17
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE_PENDING__SHIFT                              0x18
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE_PENDING__SHIFT                              0x19
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE_PENDING__SHIFT                             0x1a
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE_PENDING__SHIFT                             0x1b
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE_PENDING__SHIFT                             0x1c
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE_PENDING__SHIFT                             0x1d
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE_PENDING__SHIFT                             0x1e
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE_MASK                                        0x00000001L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE_MASK                                        0x00000002L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE_MASK                                        0x00000004L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE_MASK                                        0x00000008L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE_MASK                                        0x00000010L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE_MASK                                        0x00000020L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE_MASK                                        0x00000040L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE_MASK                                        0x00000080L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE_MASK                                        0x00000100L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE_MASK                                        0x00000200L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE_MASK                                       0x00000400L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE_MASK                                       0x00000800L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE_MASK                                       0x00001000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE_MASK                                       0x00002000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE_MASK                                       0x00004000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE_PENDING_MASK                                0x00010000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE_PENDING_MASK                                0x00020000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE_PENDING_MASK                                0x00040000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE_PENDING_MASK                                0x00080000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE_PENDING_MASK                                0x00100000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE_PENDING_MASK                                0x00200000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE_PENDING_MASK                                0x00400000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE_PENDING_MASK                                0x00800000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE_PENDING_MASK                                0x01000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE_PENDING_MASK                                0x02000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE_PENDING_MASK                               0x04000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE_PENDING_MASK                               0x08000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE_PENDING_MASK                               0x10000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE_PENDING_MASK                               0x20000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE_PENDING_MASK                               0x40000000L
+//VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE__SHIFT                              0x0
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE__SHIFT                              0x1
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE__SHIFT                              0x2
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE__SHIFT                              0x3
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE__SHIFT                              0x4
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE__SHIFT                              0x5
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE__SHIFT                              0x6
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE__SHIFT                              0x7
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE__SHIFT                              0x8
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE__SHIFT                              0x9
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE__SHIFT                             0xa
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE__SHIFT                             0xb
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE__SHIFT                             0xc
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE__SHIFT                             0xd
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE__SHIFT                             0xe
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x10
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x11
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x12
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x13
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x14
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x15
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x16
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x17
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x18
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x19
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1a
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1b
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1c
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1d
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1e
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE_MASK                                0x00000001L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE_MASK                                0x00000002L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE_MASK                                0x00000004L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE_MASK                                0x00000008L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE_MASK                                0x00000010L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE_MASK                                0x00000020L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE_MASK                                0x00000040L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE_MASK                                0x00000080L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE_MASK                                0x00000100L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE_MASK                                0x00000200L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE_MASK                               0x00000400L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE_MASK                               0x00000800L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE_MASK                               0x00001000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE_MASK                               0x00002000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE_MASK                               0x00004000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE_PENDING_MASK                        0x00010000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE_PENDING_MASK                        0x00020000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE_PENDING_MASK                        0x00040000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE_PENDING_MASK                        0x00080000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE_PENDING_MASK                        0x00100000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE_PENDING_MASK                        0x00200000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE_PENDING_MASK                        0x00400000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE_PENDING_MASK                        0x00800000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE_PENDING_MASK                        0x01000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE_PENDING_MASK                        0x02000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE_PENDING_MASK                       0x04000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE_PENDING_MASK                       0x08000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE_PENDING_MASK                       0x10000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE_PENDING_MASK                       0x20000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE_PENDING_MASK                       0x40000000L
+//VPG5_VPG_GENERIC_STATUS
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_LOCK_STATUS__SHIFT                                               0x0
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_OCCURED__SHIFT                                          0x1
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_CLR__SHIFT                                              0x4
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_LOCK_STATUS_MASK                                                 0x00000001L
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_OCCURED_MASK                                            0x00000002L
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_CLR_MASK                                                0x00000010L
+//VPG5_VPG_MEM_PWR
+#define VPG5_VPG_MEM_PWR__VPG_GSP_MEM_LIGHT_SLEEP_DIS__SHIFT                                                  0x0
+#define VPG5_VPG_MEM_PWR__VPG_GSP_LIGHT_SLEEP_FORCE__SHIFT                                                    0x4
+#define VPG5_VPG_MEM_PWR__VPG_GSP_MEM_PWR_STATE__SHIFT                                                        0x8
+#define VPG5_VPG_MEM_PWR__VPG_GSP_MEM_LIGHT_SLEEP_DIS_MASK                                                    0x00000001L
+#define VPG5_VPG_MEM_PWR__VPG_GSP_LIGHT_SLEEP_FORCE_MASK                                                      0x00000010L
+#define VPG5_VPG_MEM_PWR__VPG_GSP_MEM_PWR_STATE_MASK                                                          0x00000100L
+//VPG5_VPG_ISRC1_2_ACCESS_CTRL
+#define VPG5_VPG_ISRC1_2_ACCESS_CTRL__VPG_ISRC1_2_DATA_INDEX__SHIFT                                           0x0
+#define VPG5_VPG_ISRC1_2_ACCESS_CTRL__VPG_ISRC1_2_DATA_INDEX_MASK                                             0x0000000FL
+//VPG5_VPG_ISRC1_2_DATA
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE0__SHIFT                                                     0x0
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE1__SHIFT                                                     0x8
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE2__SHIFT                                                     0x10
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE3__SHIFT                                                     0x18
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE0_MASK                                                       0x000000FFL
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE1_MASK                                                       0x0000FF00L
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE2_MASK                                                       0x00FF0000L
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE3_MASK                                                       0xFF000000L
+//VPG5_VPG_MPEG_INFO0
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_CHECKSUM__SHIFT                                                    0x0
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB0__SHIFT                                                         0x8
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB1__SHIFT                                                         0x10
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB2__SHIFT                                                         0x18
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_CHECKSUM_MASK                                                      0x000000FFL
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB0_MASK                                                           0x0000FF00L
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB1_MASK                                                           0x00FF0000L
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB2_MASK                                                           0xFF000000L
+//VPG5_VPG_MPEG_INFO1
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_MB3__SHIFT                                                         0x0
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_MF__SHIFT                                                          0x8
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_FR__SHIFT                                                          0xc
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_UPDATE__SHIFT                                                      0x10
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_MB3_MASK                                                           0x000000FFL
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_MF_MASK                                                            0x00000300L
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_FR_MASK                                                            0x00001000L
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_UPDATE_MASK                                                        0x00010000L
+
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_dme_dme_dispdec
+//DME5_DME_CONTROL
+#define DME5_DME_CONTROL__METADATA_HUBP_REQUESTOR_ID__SHIFT                                                   0x0
+#define DME5_DME_CONTROL__METADATA_ENGINE_EN__SHIFT                                                           0x4
+#define DME5_DME_CONTROL__METADATA_STREAM_TYPE__SHIFT                                                         0x8
+#define DME5_DME_CONTROL__METADATA_DB_PENDING__SHIFT                                                          0xc
+#define DME5_DME_CONTROL__METADATA_DB_TAKEN__SHIFT                                                            0xd
+#define DME5_DME_CONTROL__METADATA_DB_TAKEN_CLR__SHIFT                                                        0x10
+#define DME5_DME_CONTROL__METADATA_DB_DISABLE__SHIFT                                                          0x14
+#define DME5_DME_CONTROL__METADATA_HUBP_REQUESTOR_ID_MASK                                                     0x00000007L
+#define DME5_DME_CONTROL__METADATA_ENGINE_EN_MASK                                                             0x00000010L
+#define DME5_DME_CONTROL__METADATA_STREAM_TYPE_MASK                                                           0x00000100L
+#define DME5_DME_CONTROL__METADATA_DB_PENDING_MASK                                                            0x00001000L
+#define DME5_DME_CONTROL__METADATA_DB_TAKEN_MASK                                                              0x00002000L
+#define DME5_DME_CONTROL__METADATA_DB_TAKEN_CLR_MASK                                                          0x00010000L
+#define DME5_DME_CONTROL__METADATA_DB_DISABLE_MASK                                                            0x00100000L
+//DME5_DME_MEMORY_CONTROL
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_FORCE__SHIFT                                                     0x0
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_DIS__SHIFT                                                       0x4
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_STATE__SHIFT                                                     0x8
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_DEFAULT_MEM_LOW_POWER_STATE__SHIFT                                   0xc
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_FORCE_MASK                                                       0x00000003L
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_DIS_MASK                                                         0x00000010L
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_STATE_MASK                                                       0x00000300L
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_DEFAULT_MEM_LOW_POWER_STATE_MASK                                     0x00003000L
+
+
+// addressBlock: dce_dc_hpo_hdmi_link_enc0_dispdec
+//HDMI_LINK_ENC_CONTROL
+#define HDMI_LINK_ENC_CONTROL__HDMI_LINK_ENC_ENABLE__SHIFT                                                    0x0
+#define HDMI_LINK_ENC_CONTROL__HDMI_LINK_ENC_SOFT_RESET__SHIFT                                                0x4
+#define HDMI_LINK_ENC_CONTROL__HDMI_LINK_ENC_ENABLE_MASK                                                      0x00000001L
+#define HDMI_LINK_ENC_CONTROL__HDMI_LINK_ENC_SOFT_RESET_MASK                                                  0x00000010L
+//HDMI_LINK_ENC_CLK_CTRL
+#define HDMI_LINK_ENC_CLK_CTRL__HDMI_LINK_ENC_CLOCK_EN__SHIFT                                                 0x0
+#define HDMI_LINK_ENC_CLK_CTRL__HDMI_LINK_ENC_CLOCK_ON_HDMICHARCLK__SHIFT                                     0x1
+#define HDMI_LINK_ENC_CLK_CTRL__HDMI_LINK_ENC_CLOCK_EN_MASK                                                   0x00000001L
+#define HDMI_LINK_ENC_CLK_CTRL__HDMI_LINK_ENC_CLOCK_ON_HDMICHARCLK_MASK                                       0x00000002L
+
+
+// addressBlock: dce_dc_hpo_hdmi_frl_enc0_dispdec
+//HDMI_FRL_ENC_CONFIG
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE_COUNT__SHIFT                                                      0x0
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_TRAINING_ENABLE__SHIFT                                                 0x1
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_SCRAMBLER_DISABLE__SHIFT                                               0x2
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE0_TRAINING_PATTERN__SHIFT                                          0x10
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE1_TRAINING_PATTERN__SHIFT                                          0x14
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE2_TRAINING_PATTERN__SHIFT                                          0x18
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE3_TRAINING_PATTERN__SHIFT                                          0x1c
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE_COUNT_MASK                                                        0x00000001L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_TRAINING_ENABLE_MASK                                                   0x00000002L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_SCRAMBLER_DISABLE_MASK                                                 0x00000004L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE0_TRAINING_PATTERN_MASK                                            0x000F0000L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE1_TRAINING_PATTERN_MASK                                            0x00F00000L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE2_TRAINING_PATTERN_MASK                                            0x0F000000L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE3_TRAINING_PATTERN_MASK                                            0xF0000000L
+//HDMI_FRL_ENC_CONFIG2
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_MAX_JITTER_VALUE__SHIFT                                               0x0
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_THRESHOLD__SHIFT                                               0xc
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_CAL_EN__SHIFT                                                  0x18
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_RC_COMPRESS_DISABLE__SHIFT                                            0x19
+#define HDMI_FRL_ENC_CONFIG2__HDMI_FRL_HDMISTREAMCLK_DB_SEL__SHIFT                                            0x1a
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_MAX_JITTER_VALUE_RESET__SHIFT                                         0x1c
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_EXCEED_STATUS__SHIFT                                           0x1d
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_METER_BUFFER_OVERFLOW_STATUS__SHIFT                                   0x1e
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_MAX_JITTER_VALUE_MASK                                                 0x000001FFL
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_THRESHOLD_MASK                                                 0x001FF000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_CAL_EN_MASK                                                    0x01000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_RC_COMPRESS_DISABLE_MASK                                              0x02000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_FRL_HDMISTREAMCLK_DB_SEL_MASK                                              0x0C000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_MAX_JITTER_VALUE_RESET_MASK                                           0x10000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_EXCEED_STATUS_MASK                                             0x20000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_METER_BUFFER_OVERFLOW_STATUS_MASK                                     0x40000000L
+//HDMI_FRL_ENC_METER_BUFFER_STATUS
+#define HDMI_FRL_ENC_METER_BUFFER_STATUS__HDMI_LINK_MAX_METER_BUFFER_LEVEL__SHIFT                             0x0
+#define HDMI_FRL_ENC_METER_BUFFER_STATUS__HDMI_LINK_METER_BUFFER_MAX_LEVEL_RESET__SHIFT                       0x1f
+#define HDMI_FRL_ENC_METER_BUFFER_STATUS__HDMI_LINK_MAX_METER_BUFFER_LEVEL_MASK                               0x0000007FL
+#define HDMI_FRL_ENC_METER_BUFFER_STATUS__HDMI_LINK_METER_BUFFER_MAX_LEVEL_RESET_MASK                         0x80000000L
+//HDMI_FRL_ENC_MEM_CTRL
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_DIS__SHIFT                                                 0x0
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_FORCE__SHIFT                                               0x1
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_STATE__SHIFT                                               0x4
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE__SHIFT                             0x8
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_DIS_MASK                                                   0x00000001L
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_FORCE_MASK                                                 0x00000006L
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_STATE_MASK                                                 0x00000030L
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE_MASK                               0x00000300L
+
+
 // addressBlock: dce_dc_hpo_hpo_top_dispdec
 //HPO_TOP_CLOCK_CONTROL
+#define HPO_TOP_CLOCK_CONTROL__HPO_DISPCLK_R_GATE_DIS__SHIFT                                                  0x0
+#define HPO_TOP_CLOCK_CONTROL__HPO_DISPCLK_GATE_DIS__SHIFT                                                    0x1
+#define HPO_TOP_CLOCK_CONTROL__HPO_SOCCLK_R_GATE_DIS__SHIFT                                                   0x4
+#define HPO_TOP_CLOCK_CONTROL__HPO_SOCCLK_GATE_DIS__SHIFT                                                     0x5
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_R_GATE_DIS__SHIFT                                            0x8
 #define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS__SHIFT                                              0x9
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMICHARCLK_R_GATE_DIS__SHIFT                                              0xc
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMICHARCLK_GATE_DIS__SHIFT                                                0xd
+#define HPO_TOP_CLOCK_CONTROL__HPO_TEST_CLK_SEL__SHIFT                                                        0x10
+#define HPO_TOP_CLOCK_CONTROL__HPO_DISPCLK_R_GATE_DIS_MASK                                                    0x00000001L
+#define HPO_TOP_CLOCK_CONTROL__HPO_DISPCLK_GATE_DIS_MASK                                                      0x00000002L
+#define HPO_TOP_CLOCK_CONTROL__HPO_SOCCLK_R_GATE_DIS_MASK                                                     0x00000010L
+#define HPO_TOP_CLOCK_CONTROL__HPO_SOCCLK_GATE_DIS_MASK                                                       0x00000020L
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_R_GATE_DIS_MASK                                              0x00000100L
 #define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS_MASK                                                0x00000200L
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMICHARCLK_R_GATE_DIS_MASK                                                0x00001000L
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMICHARCLK_GATE_DIS_MASK                                                  0x00002000L
+#define HPO_TOP_CLOCK_CONTROL__HPO_TEST_CLK_SEL_MASK                                                          0x003F0000L
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_dispdec
+//HDMI_STREAM_ENC_CLOCK_CONTROL
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_EN__SHIFT                                        0x0
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_DISPCLK__SHIFT                                0x4
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_SOCCLK__SHIFT                                 0x8
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_HDMISTREAMCLK__SHIFT                          0xc
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_EN_MASK                                          0x00000001L
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_DISPCLK_MASK                                  0x00000010L
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_SOCCLK_MASK                                   0x00000100L
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_HDMISTREAMCLK_MASK                            0x00001000L
+//HDMI_STREAM_ENC_HDMISTREAMCLK_CONTROL
+#define HDMI_STREAM_ENC_HDMISTREAMCLK_CONTROL__HDMI_STREAM_ENC_HDMISTREAMCLK_INCREMENT__SHIFT                 0x0
+#define HDMI_STREAM_ENC_HDMISTREAMCLK_CONTROL__HDMI_STREAM_ENC_HDMISTREAMCLK_MODULO__SHIFT                    0x8
+#define HDMI_STREAM_ENC_HDMISTREAMCLK_CONTROL__HDMI_STREAM_ENC_HDMISTREAMCLK_INCREMENT_MASK                   0x000000FFL
+#define HDMI_STREAM_ENC_HDMISTREAMCLK_CONTROL__HDMI_STREAM_ENC_HDMISTREAMCLK_MODULO_MASK                      0x0000FF00L
+//HDMI_STREAM_ENC_INPUT_MUX_CONTROL
+#define HDMI_STREAM_ENC_INPUT_MUX_CONTROL__HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL__SHIFT                        0x0
+#define HDMI_STREAM_ENC_INPUT_MUX_CONTROL__HDMI_STREAM_ENC_INPUT_MUX_SOURCE_SEL_MASK                          0x00000007L
+//HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ENABLE__SHIFT                          0x0
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_RESET__SHIFT                           0x4
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_PIXEL_ENCODING__SHIFT                  0x8
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ODM_COMBINE_MODE__SHIFT                0xc
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_DSC_MODE__SHIFT                        0x10
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_RESET_DONE__SHIFT                      0x14
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_VIDEO_STREAM_ACTIVE__SHIFT             0x18
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ERROR__SHIFT                           0x1c
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ENABLE_MASK                            0x00000001L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_RESET_MASK                             0x00000010L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_PIXEL_ENCODING_MASK                    0x00000300L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ODM_COMBINE_MODE_MASK                  0x00003000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_DSC_MODE_MASK                          0x00030000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_RESET_DONE_MASK                        0x00100000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_VIDEO_STREAM_ACTIVE_MASK               0x01000000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0__FIFO_ERROR_MASK                             0x30000000L
+//HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_USE_OVERWRITE_LEVEL__SHIFT             0x0
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_FORCE_RECAL_AVERAGE__SHIFT             0x1
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_FORCE_RECOMP_MINMAX__SHIFT             0x2
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_OVERWRITE_LEVEL__SHIFT                 0x4
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_MINIMUM_LEVEL__SHIFT                   0xc
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_MAXIMUM_LEVEL__SHIFT                   0x10
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_CAL_AVERAGE_LEVEL__SHIFT               0x18
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_CALIBRATED__SHIFT                      0x1f
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_USE_OVERWRITE_LEVEL_MASK               0x00000001L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_FORCE_RECAL_AVERAGE_MASK               0x00000002L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_FORCE_RECOMP_MINMAX_MASK               0x00000004L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_OVERWRITE_LEVEL_MASK                   0x000003F0L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_MINIMUM_LEVEL_MASK                     0x0000F000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_MAXIMUM_LEVEL_MASK                     0x001F0000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_CAL_AVERAGE_LEVEL_MASK                 0x3F000000L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1__FIFO_CALIBRATED_MASK                        0x80000000L
+//HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_READ_START_LEVEL__SHIFT                0x0
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_READ_CLOCK_SRC__SHIFT                  0x5
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_DB_PENDING__SHIFT                      0x8
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_DB_DISABLE__SHIFT                      0xc
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_READ_START_LEVEL_MASK                  0x0000001FL
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_READ_CLOCK_SRC_MASK                    0x00000020L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_DB_PENDING_MASK                        0x00000100L
+#define HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2__FIFO_DB_DISABLE_MASK                        0x00001000L
+
+
+// addressBlock: dce_dc_hpo_hdmi_tb_enc0_dispdec
+//HDMI_TB_ENC_CONTROL
+#define HDMI_TB_ENC_CONTROL__HDMI_TB_ENC_EN__SHIFT                                                            0x0
+#define HDMI_TB_ENC_CONTROL__HDMI_RESET__SHIFT                                                                0x4
+#define HDMI_TB_ENC_CONTROL__HDMI_RESET_DONE__SHIFT                                                           0x8
+#define HDMI_TB_ENC_CONTROL__HDMI_TB_ENC_EN_MASK                                                              0x00000001L
+#define HDMI_TB_ENC_CONTROL__HDMI_RESET_MASK                                                                  0x00000010L
+#define HDMI_TB_ENC_CONTROL__HDMI_RESET_DONE_MASK                                                             0x00000100L
+//HDMI_TB_ENC_PIXEL_FORMAT
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DEEP_COLOR_ENABLE__SHIFT                                               0x0
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DEEP_COLOR_DEPTH__SHIFT                                                0x8
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_PIXEL_ENCODING__SHIFT                                                  0x10
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DSC_MODE__SHIFT                                                        0x18
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DEEP_COLOR_ENABLE_MASK                                                 0x00000001L
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DEEP_COLOR_DEPTH_MASK                                                  0x00000300L
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_PIXEL_ENCODING_MASK                                                    0x00030000L
+#define HDMI_TB_ENC_PIXEL_FORMAT__HDMI_DSC_MODE_MASK                                                          0x03000000L
+//HDMI_TB_ENC_PACKET_CONTROL
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_MAX_PACKETS_PER_LINE__SHIFT                                          0x0
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_MAX_ISLANDS_PER_LINE__SHIFT                                          0x8
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_ACR_AUTO_SEND_OVERFLOW__SHIFT                                        0xc
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_TB_ENC_PACKET_ERROR_CLEAR__SHIFT                                     0x10
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_MAX_PACKETS_PER_LINE_MASK                                            0x0000001FL
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_MAX_ISLANDS_PER_LINE_MASK                                            0x00000300L
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_ACR_AUTO_SEND_OVERFLOW_MASK                                          0x00001000L
+#define HDMI_TB_ENC_PACKET_CONTROL__HDMI_TB_ENC_PACKET_ERROR_CLEAR_MASK                                       0x00010000L
+//HDMI_TB_ENC_ACR_PACKET_CONTROL
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SEND__SHIFT                                                  0x0
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_CONT__SHIFT                                                  0x1
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SELECT__SHIFT                                                0x4
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SOURCE__SHIFT                                                0x8
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_AUTO_SEND__SHIFT                                             0xc
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_N_MULTIPLE__SHIFT                                            0x10
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_AUDIO_PRIORITY__SHIFT                                        0x1f
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SEND_MASK                                                    0x00000001L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_CONT_MASK                                                    0x00000002L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SELECT_MASK                                                  0x00000030L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_SOURCE_MASK                                                  0x00000100L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_AUTO_SEND_MASK                                               0x00001000L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_N_MULTIPLE_MASK                                              0x00070000L
+#define HDMI_TB_ENC_ACR_PACKET_CONTROL__HDMI_ACR_AUDIO_PRIORITY_MASK                                          0x80000000L
+//HDMI_TB_ENC_VBI_PACKET_CONTROL1
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_GC_SEND__SHIFT                                                  0x0
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_GC_CONT__SHIFT                                                  0x1
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_SEND__SHIFT                                                0x4
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_CONT__SHIFT                                                0x5
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_LINE_REFERENCE__SHIFT                                      0x6
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ACP_SEND__SHIFT                                                 0x8
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ACP_LINE_REFERENCE__SHIFT                                       0x9
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_SEND__SHIFT                                          0xc
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_CONT__SHIFT                                          0xd
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_LINE_REFERENCE__SHIFT                                0xe
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_LINE__SHIFT                                          0x10
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_GC_SEND_MASK                                                    0x00000001L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_GC_CONT_MASK                                                    0x00000002L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_SEND_MASK                                                  0x00000010L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_CONT_MASK                                                  0x00000020L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ISRC_LINE_REFERENCE_MASK                                        0x00000040L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ACP_SEND_MASK                                                   0x00000100L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_ACP_LINE_REFERENCE_MASK                                         0x00000200L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_SEND_MASK                                            0x00001000L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_CONT_MASK                                            0x00002000L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_LINE_REFERENCE_MASK                                  0x00004000L
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL1__HDMI_AUDIO_INFO_LINE_MASK                                            0x7FFF0000L
+//HDMI_TB_ENC_VBI_PACKET_CONTROL2
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL2__HDMI_ISRC_LINE__SHIFT                                                0x0
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL2__HDMI_ACP_LINE__SHIFT                                                 0x10
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL2__HDMI_ISRC_LINE_MASK                                                  0x00007FFFL
+#define HDMI_TB_ENC_VBI_PACKET_CONTROL2__HDMI_ACP_LINE_MASK                                                   0x7FFF0000L
+//HDMI_TB_ENC_GC_CONTROL
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_GC_AVMUTE__SHIFT                                                         0x0
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_GC_AVMUTE_CONT__SHIFT                                                    0x2
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_DEFAULT_PHASE__SHIFT                                                     0x4
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_GC_AVMUTE_MASK                                                           0x00000001L
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_GC_AVMUTE_CONT_MASK                                                      0x00000004L
+#define HDMI_TB_ENC_GC_CONTROL__HDMI_DEFAULT_PHASE_MASK                                                       0x00000010L
+//HDMI_TB_ENC_GENERIC_PACKET_CONTROL0
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_SEND__SHIFT                                        0x0
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_CONT__SHIFT                                        0x1
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_LOCK_EN__SHIFT                                     0x2
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_LINE_REFERENCE__SHIFT                              0x3
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_SEND__SHIFT                                        0x4
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_CONT__SHIFT                                        0x5
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_LOCK_EN__SHIFT                                     0x6
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_LINE_REFERENCE__SHIFT                              0x7
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_SEND__SHIFT                                        0x8
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_CONT__SHIFT                                        0x9
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_LOCK_EN__SHIFT                                     0xa
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_LINE_REFERENCE__SHIFT                              0xb
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_SEND__SHIFT                                        0xc
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_CONT__SHIFT                                        0xd
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_LOCK_EN__SHIFT                                     0xe
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_LINE_REFERENCE__SHIFT                              0xf
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_SEND__SHIFT                                        0x10
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_CONT__SHIFT                                        0x11
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_LOCK_EN__SHIFT                                     0x12
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_LINE_REFERENCE__SHIFT                              0x13
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_SEND__SHIFT                                        0x14
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_CONT__SHIFT                                        0x15
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_LOCK_EN__SHIFT                                     0x16
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_LINE_REFERENCE__SHIFT                              0x17
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_SEND__SHIFT                                        0x18
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_CONT__SHIFT                                        0x19
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_LOCK_EN__SHIFT                                     0x1a
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_LINE_REFERENCE__SHIFT                              0x1b
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_SEND__SHIFT                                        0x1c
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_CONT__SHIFT                                        0x1d
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_LOCK_EN__SHIFT                                     0x1e
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_LINE_REFERENCE__SHIFT                              0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_SEND_MASK                                          0x00000001L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_CONT_MASK                                          0x00000002L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_LOCK_EN_MASK                                       0x00000004L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC0_LINE_REFERENCE_MASK                                0x00000008L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_SEND_MASK                                          0x00000010L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_CONT_MASK                                          0x00000020L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_LOCK_EN_MASK                                       0x00000040L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC1_LINE_REFERENCE_MASK                                0x00000080L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_SEND_MASK                                          0x00000100L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_CONT_MASK                                          0x00000200L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_LOCK_EN_MASK                                       0x00000400L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC2_LINE_REFERENCE_MASK                                0x00000800L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_SEND_MASK                                          0x00001000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_CONT_MASK                                          0x00002000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_LOCK_EN_MASK                                       0x00004000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC3_LINE_REFERENCE_MASK                                0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_SEND_MASK                                          0x00010000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_CONT_MASK                                          0x00020000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_LOCK_EN_MASK                                       0x00040000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC4_LINE_REFERENCE_MASK                                0x00080000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_SEND_MASK                                          0x00100000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_CONT_MASK                                          0x00200000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_LOCK_EN_MASK                                       0x00400000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC5_LINE_REFERENCE_MASK                                0x00800000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_SEND_MASK                                          0x01000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_CONT_MASK                                          0x02000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_LOCK_EN_MASK                                       0x04000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC6_LINE_REFERENCE_MASK                                0x08000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_SEND_MASK                                          0x10000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_CONT_MASK                                          0x20000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_LOCK_EN_MASK                                       0x40000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL0__HDMI_GENERIC7_LINE_REFERENCE_MASK                                0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET_CONTROL1
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_SEND__SHIFT                                        0x0
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_CONT__SHIFT                                        0x1
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_LOCK_EN__SHIFT                                     0x2
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_LINE_REFERENCE__SHIFT                              0x3
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_SEND__SHIFT                                        0x4
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_CONT__SHIFT                                        0x5
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_LOCK_EN__SHIFT                                     0x6
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_LINE_REFERENCE__SHIFT                              0x7
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_SEND__SHIFT                                       0x8
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_CONT__SHIFT                                       0x9
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_LOCK_EN__SHIFT                                    0xa
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_LINE_REFERENCE__SHIFT                             0xb
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_SEND__SHIFT                                       0xc
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_CONT__SHIFT                                       0xd
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_LOCK_EN__SHIFT                                    0xe
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_LINE_REFERENCE__SHIFT                             0xf
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_SEND__SHIFT                                       0x10
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_CONT__SHIFT                                       0x11
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_LOCK_EN__SHIFT                                    0x12
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_LINE_REFERENCE__SHIFT                             0x13
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_SEND__SHIFT                                       0x14
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_CONT__SHIFT                                       0x15
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_LOCK_EN__SHIFT                                    0x16
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_LINE_REFERENCE__SHIFT                             0x17
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_SEND__SHIFT                                       0x18
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_CONT__SHIFT                                       0x19
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_LOCK_EN__SHIFT                                    0x1a
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_LINE_REFERENCE__SHIFT                             0x1b
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_SEND_MASK                                          0x00000001L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_CONT_MASK                                          0x00000002L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_LOCK_EN_MASK                                       0x00000004L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC8_LINE_REFERENCE_MASK                                0x00000008L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_SEND_MASK                                          0x00000010L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_CONT_MASK                                          0x00000020L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_LOCK_EN_MASK                                       0x00000040L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC9_LINE_REFERENCE_MASK                                0x00000080L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_SEND_MASK                                         0x00000100L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_CONT_MASK                                         0x00000200L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_LOCK_EN_MASK                                      0x00000400L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC10_LINE_REFERENCE_MASK                               0x00000800L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_SEND_MASK                                         0x00001000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_CONT_MASK                                         0x00002000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_LOCK_EN_MASK                                      0x00004000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC11_LINE_REFERENCE_MASK                               0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_SEND_MASK                                         0x00010000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_CONT_MASK                                         0x00020000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_LOCK_EN_MASK                                      0x00040000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC12_LINE_REFERENCE_MASK                               0x00080000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_SEND_MASK                                         0x00100000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_CONT_MASK                                         0x00200000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_LOCK_EN_MASK                                      0x00400000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC13_LINE_REFERENCE_MASK                               0x00800000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_SEND_MASK                                         0x01000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_CONT_MASK                                         0x02000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_LOCK_EN_MASK                                      0x04000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL1__HDMI_GENERIC14_LINE_REFERENCE_MASK                               0x08000000L
+//HDMI_TB_ENC_GENERIC_PACKET_CONTROL2
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC0_IMMEDIATE_SEND__SHIFT                              0x0
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC0_IMMEDIATE_SEND_PENDING__SHIFT                      0x1
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC1_IMMEDIATE_SEND__SHIFT                              0x2
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC1_IMMEDIATE_SEND_PENDING__SHIFT                      0x3
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC2_IMMEDIATE_SEND__SHIFT                              0x4
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC2_IMMEDIATE_SEND_PENDING__SHIFT                      0x5
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC3_IMMEDIATE_SEND__SHIFT                              0x6
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC3_IMMEDIATE_SEND_PENDING__SHIFT                      0x7
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC4_IMMEDIATE_SEND__SHIFT                              0x8
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC4_IMMEDIATE_SEND_PENDING__SHIFT                      0x9
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC5_IMMEDIATE_SEND__SHIFT                              0xa
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC5_IMMEDIATE_SEND_PENDING__SHIFT                      0xb
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC6_IMMEDIATE_SEND__SHIFT                              0xc
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC6_IMMEDIATE_SEND_PENDING__SHIFT                      0xd
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC7_IMMEDIATE_SEND__SHIFT                              0xe
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC7_IMMEDIATE_SEND_PENDING__SHIFT                      0xf
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC8_IMMEDIATE_SEND__SHIFT                              0x10
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC8_IMMEDIATE_SEND_PENDING__SHIFT                      0x11
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC9_IMMEDIATE_SEND__SHIFT                              0x12
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC9_IMMEDIATE_SEND_PENDING__SHIFT                      0x13
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC10_IMMEDIATE_SEND__SHIFT                             0x14
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC10_IMMEDIATE_SEND_PENDING__SHIFT                     0x15
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC11_IMMEDIATE_SEND__SHIFT                             0x16
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC11_IMMEDIATE_SEND_PENDING__SHIFT                     0x17
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC12_IMMEDIATE_SEND__SHIFT                             0x18
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC12_IMMEDIATE_SEND_PENDING__SHIFT                     0x19
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC13_IMMEDIATE_SEND__SHIFT                             0x1a
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC13_IMMEDIATE_SEND_PENDING__SHIFT                     0x1b
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC14_IMMEDIATE_SEND__SHIFT                             0x1c
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC14_IMMEDIATE_SEND_PENDING__SHIFT                     0x1d
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC0_IMMEDIATE_SEND_MASK                                0x00000001L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC0_IMMEDIATE_SEND_PENDING_MASK                        0x00000002L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC1_IMMEDIATE_SEND_MASK                                0x00000004L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC1_IMMEDIATE_SEND_PENDING_MASK                        0x00000008L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC2_IMMEDIATE_SEND_MASK                                0x00000010L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC2_IMMEDIATE_SEND_PENDING_MASK                        0x00000020L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC3_IMMEDIATE_SEND_MASK                                0x00000040L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC3_IMMEDIATE_SEND_PENDING_MASK                        0x00000080L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC4_IMMEDIATE_SEND_MASK                                0x00000100L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC4_IMMEDIATE_SEND_PENDING_MASK                        0x00000200L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC5_IMMEDIATE_SEND_MASK                                0x00000400L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC5_IMMEDIATE_SEND_PENDING_MASK                        0x00000800L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC6_IMMEDIATE_SEND_MASK                                0x00001000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC6_IMMEDIATE_SEND_PENDING_MASK                        0x00002000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC7_IMMEDIATE_SEND_MASK                                0x00004000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC7_IMMEDIATE_SEND_PENDING_MASK                        0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC8_IMMEDIATE_SEND_MASK                                0x00010000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC8_IMMEDIATE_SEND_PENDING_MASK                        0x00020000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC9_IMMEDIATE_SEND_MASK                                0x00040000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC9_IMMEDIATE_SEND_PENDING_MASK                        0x00080000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC10_IMMEDIATE_SEND_MASK                               0x00100000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC10_IMMEDIATE_SEND_PENDING_MASK                       0x00200000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC11_IMMEDIATE_SEND_MASK                               0x00400000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC11_IMMEDIATE_SEND_PENDING_MASK                       0x00800000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC12_IMMEDIATE_SEND_MASK                               0x01000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC12_IMMEDIATE_SEND_PENDING_MASK                       0x02000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC13_IMMEDIATE_SEND_MASK                               0x04000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC13_IMMEDIATE_SEND_PENDING_MASK                       0x08000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC14_IMMEDIATE_SEND_MASK                               0x10000000L
+#define HDMI_TB_ENC_GENERIC_PACKET_CONTROL2__HDMI_GENERIC14_IMMEDIATE_SEND_PENDING_MASK                       0x20000000L
+//HDMI_TB_ENC_GENERIC_PACKET0_1_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC0_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC0_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC1_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC1_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC0_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC0_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC1_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET0_1_LINE__HDMI_GENERIC1_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET2_3_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC2_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC2_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC3_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC3_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC2_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC2_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC3_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET2_3_LINE__HDMI_GENERIC3_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET4_5_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC4_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC4_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC5_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC5_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC4_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC4_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC5_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET4_5_LINE__HDMI_GENERIC5_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET6_7_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC6_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC6_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC7_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC7_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC6_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC6_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC7_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET6_7_LINE__HDMI_GENERIC7_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET8_9_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC8_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC8_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC9_LINE__SHIFT                                         0x10
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC9_EMP__SHIFT                                          0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC8_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC8_EMP_MASK                                            0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC9_LINE_MASK                                           0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET8_9_LINE__HDMI_GENERIC9_EMP_MASK                                            0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET10_11_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC10_LINE__SHIFT                                      0x0
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC10_EMP__SHIFT                                       0xf
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC11_LINE__SHIFT                                      0x10
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC11_EMP__SHIFT                                       0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC10_LINE_MASK                                        0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC10_EMP_MASK                                         0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC11_LINE_MASK                                        0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET10_11_LINE__HDMI_GENERIC11_EMP_MASK                                         0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET12_13_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC12_LINE__SHIFT                                      0x0
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC12_EMP__SHIFT                                       0xf
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC13_LINE__SHIFT                                      0x10
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC13_EMP__SHIFT                                       0x1f
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC12_LINE_MASK                                        0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC12_EMP_MASK                                         0x00008000L
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC13_LINE_MASK                                        0x7FFF0000L
+#define HDMI_TB_ENC_GENERIC_PACKET12_13_LINE__HDMI_GENERIC13_EMP_MASK                                         0x80000000L
+//HDMI_TB_ENC_GENERIC_PACKET14_LINE
+#define HDMI_TB_ENC_GENERIC_PACKET14_LINE__HDMI_GENERIC14_LINE__SHIFT                                         0x0
+#define HDMI_TB_ENC_GENERIC_PACKET14_LINE__HDMI_GENERIC14_EMP__SHIFT                                          0xf
+#define HDMI_TB_ENC_GENERIC_PACKET14_LINE__HDMI_GENERIC14_LINE_MASK                                           0x00007FFFL
+#define HDMI_TB_ENC_GENERIC_PACKET14_LINE__HDMI_GENERIC14_EMP_MASK                                            0x00008000L
+//HDMI_TB_ENC_DB_CONTROL
+#define HDMI_TB_ENC_DB_CONTROL__HDMI_DB_PENDING__SHIFT                                                        0x0
+#define HDMI_TB_ENC_DB_CONTROL__HDMI_DB_DISABLE__SHIFT                                                        0xc
+#define HDMI_TB_ENC_DB_CONTROL__VUPDATE_DB_PENDING__SHIFT                                                     0xf
+#define HDMI_TB_ENC_DB_CONTROL__HDMI_DB_PENDING_MASK                                                          0x00000001L
+#define HDMI_TB_ENC_DB_CONTROL__HDMI_DB_DISABLE_MASK                                                          0x00001000L
+#define HDMI_TB_ENC_DB_CONTROL__VUPDATE_DB_PENDING_MASK                                                       0x00008000L
+//HDMI_TB_ENC_ACR_32_0
+#define HDMI_TB_ENC_ACR_32_0__HDMI_ACR_CTS_32__SHIFT                                                          0xc
+#define HDMI_TB_ENC_ACR_32_0__HDMI_ACR_CTS_32_MASK                                                            0xFFFFF000L
+//HDMI_TB_ENC_ACR_32_1
+#define HDMI_TB_ENC_ACR_32_1__HDMI_ACR_N_32__SHIFT                                                            0x0
+#define HDMI_TB_ENC_ACR_32_1__HDMI_ACR_N_32_MASK                                                              0x000FFFFFL
+//HDMI_TB_ENC_ACR_44_0
+#define HDMI_TB_ENC_ACR_44_0__HDMI_ACR_CTS_44__SHIFT                                                          0xc
+#define HDMI_TB_ENC_ACR_44_0__HDMI_ACR_CTS_44_MASK                                                            0xFFFFF000L
+//HDMI_TB_ENC_ACR_44_1
+#define HDMI_TB_ENC_ACR_44_1__HDMI_ACR_N_44__SHIFT                                                            0x0
+#define HDMI_TB_ENC_ACR_44_1__HDMI_ACR_N_44_MASK                                                              0x000FFFFFL
+//HDMI_TB_ENC_ACR_48_0
+#define HDMI_TB_ENC_ACR_48_0__HDMI_ACR_CTS_48__SHIFT                                                          0xc
+#define HDMI_TB_ENC_ACR_48_0__HDMI_ACR_CTS_48_MASK                                                            0xFFFFF000L
+//HDMI_TB_ENC_ACR_48_1
+#define HDMI_TB_ENC_ACR_48_1__HDMI_ACR_N_48__SHIFT                                                            0x0
+#define HDMI_TB_ENC_ACR_48_1__HDMI_ACR_N_48_MASK                                                              0x000FFFFFL
+//HDMI_TB_ENC_ACR_STATUS_0
+#define HDMI_TB_ENC_ACR_STATUS_0__HDMI_ACR_CTS__SHIFT                                                         0xc
+#define HDMI_TB_ENC_ACR_STATUS_0__HDMI_ACR_CTS_MASK                                                           0xFFFFF000L
+//HDMI_TB_ENC_ACR_STATUS_1
+#define HDMI_TB_ENC_ACR_STATUS_1__HDMI_ACR_N__SHIFT                                                           0x0
+#define HDMI_TB_ENC_ACR_STATUS_1__HDMI_ACR_N_MASK                                                             0x000FFFFFL
+//HDMI_TB_ENC_BUFFER_CONTROL
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_PREFILL_OVERRIDE_EN__SHIFT                              0x0
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_RATE_BUFFER_PREFILL_OVERRIDE_EN__SHIFT                               0x1
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_MAX_MIN_LEVEL_RESET__SHIFT                              0x4
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_PREFILL_OVERRIDE_LEVEL__SHIFT                           0x8
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_RATE_BUFFER_PREFILL_OVERRIDE_LEVEL__SHIFT                            0x18
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_PREFILL_OVERRIDE_EN_MASK                                0x00000001L
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_RATE_BUFFER_PREFILL_OVERRIDE_EN_MASK                                 0x00000002L
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_MAX_MIN_LEVEL_RESET_MASK                                0x00000010L
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_BORROWBUFFER_PREFILL_OVERRIDE_LEVEL_MASK                             0x0000FF00L
+#define HDMI_TB_ENC_BUFFER_CONTROL__HDMI_RATE_BUFFER_PREFILL_OVERRIDE_LEVEL_MASK                              0x1F000000L
+//HDMI_TB_ENC_MEM_CTRL
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_DIS__SHIFT                                                 0x0
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_FORCE__SHIFT                                               0x1
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_STATE__SHIFT                                               0x4
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE__SHIFT                             0x8
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_DIS_MASK                                                   0x00000001L
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_FORCE_MASK                                                 0x00000006L
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_PWR_STATE_MASK                                                 0x00000030L
+#define HDMI_TB_ENC_MEM_CTRL__BORROWBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE_MASK                               0x00000300L
+//HDMI_TB_ENC_METADATA_PACKET_CONTROL
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_ENABLE__SHIFT                               0x0
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_LINE_REFERENCE__SHIFT                       0x4
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_MISSED__SHIFT                               0x8
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_LINE__SHIFT                                 0x10
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_ENABLE_MASK                                 0x00000001L
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_LINE_REFERENCE_MASK                         0x00000010L
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_MISSED_MASK                                 0x00000100L
+#define HDMI_TB_ENC_METADATA_PACKET_CONTROL__HDMI_METADATA_PACKET_LINE_MASK                                   0xFFFF0000L
+//HDMI_TB_ENC_H_ACTIVE_BLANK
+#define HDMI_TB_ENC_H_ACTIVE_BLANK__HDMI_H_ACTIVE__SHIFT                                                      0x0
+#define HDMI_TB_ENC_H_ACTIVE_BLANK__HDMI_H_BLANK__SHIFT                                                       0x10
+#define HDMI_TB_ENC_H_ACTIVE_BLANK__HDMI_H_ACTIVE_MASK                                                        0x00007FFFL
+#define HDMI_TB_ENC_H_ACTIVE_BLANK__HDMI_H_BLANK_MASK                                                         0x7FFF0000L
+//HDMI_TB_ENC_HC_ACTIVE_BLANK
+#define HDMI_TB_ENC_HC_ACTIVE_BLANK__HDMI_HC_ACTIVE__SHIFT                                                    0x0
+#define HDMI_TB_ENC_HC_ACTIVE_BLANK__HDMI_HC_BLANK__SHIFT                                                     0x10
+#define HDMI_TB_ENC_HC_ACTIVE_BLANK__HDMI_HC_ACTIVE_MASK                                                      0x00007FFFL
+#define HDMI_TB_ENC_HC_ACTIVE_BLANK__HDMI_HC_BLANK_MASK                                                       0x7FFF0000L
+//HDMI_TB_ENC_CRC_CNTL
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_EN__SHIFT                                                              0x0
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_CONT_EN__SHIFT                                                         0x1
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_TYPE__SHIFT                                                            0x8
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_SRC_SEL__SHIFT                                                         0xa
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_INTERLACE_EN__SHIFT                                                    0x10
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_INTERLACE_MODE__SHIFT                                                  0x11
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_EN_MASK                                                                0x00000001L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_CONT_EN_MASK                                                           0x00000002L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_TYPE_MASK                                                              0x00000300L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_SRC_SEL_MASK                                                           0x00000C00L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_INTERLACE_EN_MASK                                                      0x00010000L
+#define HDMI_TB_ENC_CRC_CNTL__HDMI_CRC_INTERLACE_MODE_MASK                                                    0x00060000L
+//HDMI_TB_ENC_CRC_RESULT_0
+#define HDMI_TB_ENC_CRC_RESULT_0__CRC_TRIBYTE0__SHIFT                                                         0x0
+#define HDMI_TB_ENC_CRC_RESULT_0__CRC_TRIBYTE1__SHIFT                                                         0x10
+#define HDMI_TB_ENC_CRC_RESULT_0__CRC_TRIBYTE0_MASK                                                           0x0000FFFFL
+#define HDMI_TB_ENC_CRC_RESULT_0__CRC_TRIBYTE1_MASK                                                           0xFFFF0000L
+//HDMI_TB_ENC_MODE
+#define HDMI_TB_ENC_MODE__HDMI_BORROW_MODE__SHIFT                                                             0x0
+#define HDMI_TB_ENC_MODE__HDMI_SKIP_FIRST_HBLANK__SHIFT                                                       0x8
+#define HDMI_TB_ENC_MODE__HDMI_BORROW_MODE_MASK                                                               0x00000003L
+#define HDMI_TB_ENC_MODE__HDMI_SKIP_FIRST_HBLANK_MASK                                                         0x00000100L
+//HDMI_TB_ENC_INPUT_FIFO_STATUS
+#define HDMI_TB_ENC_INPUT_FIFO_STATUS__INPUT_FIFO_ERROR__SHIFT                                                0x0
+#define HDMI_TB_ENC_INPUT_FIFO_STATUS__INPUT_FIFO_ERROR_MASK                                                  0x00000001L
+//HDMI_TB_ENC_CRC_RESULT_1
+#define HDMI_TB_ENC_CRC_RESULT_1__CRC_TRIBYTE2__SHIFT                                                         0x0
+#define HDMI_TB_ENC_CRC_RESULT_1__CRC_TRIBYTE2_MASK                                                           0x0000FFFFL
+
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_afmt_afmt_dispdec
+//AFMT5_AFMT_ACP
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE__SHIFT                                                                  0x0
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE0__SHIFT                                                  0x8
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE1__SHIFT                                                  0x10
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_MASK                                                                    0x00000003L
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE0_MASK                                                    0x0000FF00L
+#define AFMT5_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE1_MASK                                                    0x00FF0000L
+//AFMT5_AFMT_VBI_PACKET_CONTROL
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_ACP_SOURCE__SHIFT                                                 0xd
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_PACKETS_PER_LINE__SHIFT                                0x10
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_SEND_MAX_PACKETS__SHIFT                                0x18
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_ACP_SOURCE_MASK                                                   0x00002000L
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_PACKETS_PER_LINE_MASK                                  0x001F0000L
+#define AFMT5_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_SEND_MAX_PACKETS_MASK                                  0x01000000L
+//AFMT5_AFMT_AUDIO_PACKET_CONTROL2
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_OVRD__SHIFT                                       0x0
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_SELECT__SHIFT                                     0x1
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_CHANNEL_ENABLE__SHIFT                                    0x8
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_DP_AUDIO_STREAM_ID__SHIFT                                      0x10
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_HBR_ENABLE_OVRD__SHIFT                                         0x18
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_60958_OSF_OVRD__SHIFT                                          0x1c
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_OVRD_MASK                                         0x00000001L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_SELECT_MASK                                       0x00000002L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_CHANNEL_ENABLE_MASK                                      0x0000FF00L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_DP_AUDIO_STREAM_ID_MASK                                        0x00FF0000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_HBR_ENABLE_OVRD_MASK                                           0x01000000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL2__AFMT_60958_OSF_OVRD_MASK                                            0x10000000L
+//AFMT5_AFMT_AUDIO_INFO0
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM__SHIFT                                               0x0
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CC__SHIFT                                                     0x8
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CT__SHIFT                                                     0xb
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM_OFFSET__SHIFT                                        0x10
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CXT__SHIFT                                                    0x18
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM_MASK                                                 0x000000FFL
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CC_MASK                                                       0x00000700L
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CT_MASK                                                       0x00007800L
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM_OFFSET_MASK                                          0x00FF0000L
+#define AFMT5_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CXT_MASK                                                      0x1F000000L
+//AFMT5_AFMT_AUDIO_INFO1
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_CA__SHIFT                                                     0x0
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LSV__SHIFT                                                    0xb
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_DM_INH__SHIFT                                                 0xf
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LFEPBL__SHIFT                                                 0x10
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_CA_MASK                                                       0x000000FFL
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LSV_MASK                                                      0x00007800L
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_DM_INH_MASK                                                   0x00008000L
+#define AFMT5_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LFEPBL_MASK                                                   0x00030000L
+//AFMT5_AFMT_60958_0
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_A__SHIFT                                                            0x0
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_B__SHIFT                                                            0x1
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_C__SHIFT                                                            0x2
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_D__SHIFT                                                            0x3
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_MODE__SHIFT                                                         0x6
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CATEGORY_CODE__SHIFT                                                0x8
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_SOURCE_NUMBER__SHIFT                                                0x10
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CHANNEL_NUMBER_L__SHIFT                                             0x14
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_SAMPLING_FREQUENCY__SHIFT                                           0x18
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CLOCK_ACCURACY__SHIFT                                               0x1c
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_A_MASK                                                              0x00000001L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_B_MASK                                                              0x00000002L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_C_MASK                                                              0x00000004L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_D_MASK                                                              0x00000038L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_MODE_MASK                                                           0x000000C0L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CATEGORY_CODE_MASK                                                  0x0000FF00L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_SOURCE_NUMBER_MASK                                                  0x000F0000L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CHANNEL_NUMBER_L_MASK                                               0x00F00000L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_SAMPLING_FREQUENCY_MASK                                             0x0F000000L
+#define AFMT5_AFMT_60958_0__AFMT_60958_CS_CLOCK_ACCURACY_MASK                                                 0x30000000L
+//AFMT5_AFMT_60958_1
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_WORD_LENGTH__SHIFT                                                  0x0
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_ORIGINAL_SAMPLING_FREQUENCY__SHIFT                                  0x4
+#define AFMT5_AFMT_60958_1__AFMT_60958_VALID_L__SHIFT                                                         0x10
+#define AFMT5_AFMT_60958_1__AFMT_60958_VALID_R__SHIFT                                                         0x12
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_CHANNEL_NUMBER_R__SHIFT                                             0x14
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_WORD_LENGTH_MASK                                                    0x0000000FL
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_ORIGINAL_SAMPLING_FREQUENCY_MASK                                    0x000000F0L
+#define AFMT5_AFMT_60958_1__AFMT_60958_VALID_L_MASK                                                           0x00010000L
+#define AFMT5_AFMT_60958_1__AFMT_60958_VALID_R_MASK                                                           0x00040000L
+#define AFMT5_AFMT_60958_1__AFMT_60958_CS_CHANNEL_NUMBER_R_MASK                                               0x00F00000L
+//AFMT5_AFMT_AUDIO_CRC_CONTROL
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_EN__SHIFT                                                0x0
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CONT__SHIFT                                              0x4
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_SOURCE__SHIFT                                            0x8
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CH_SEL__SHIFT                                            0xc
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_COUNT__SHIFT                                             0x10
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_EN_MASK                                                  0x00000001L
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CONT_MASK                                                0x00000010L
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_SOURCE_MASK                                              0x00000100L
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CH_SEL_MASK                                              0x0000F000L
+#define AFMT5_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_COUNT_MASK                                               0xFFFF0000L
+//AFMT5_AFMT_RAMP_CONTROL0
+#define AFMT5_AFMT_RAMP_CONTROL0__AFMT_RAMP_MAX_COUNT__SHIFT                                                  0x0
+#define AFMT5_AFMT_RAMP_CONTROL0__AFMT_RAMP_DATA_SIGN__SHIFT                                                  0x1f
+#define AFMT5_AFMT_RAMP_CONTROL0__AFMT_RAMP_MAX_COUNT_MASK                                                    0x00FFFFFFL
+#define AFMT5_AFMT_RAMP_CONTROL0__AFMT_RAMP_DATA_SIGN_MASK                                                    0x80000000L
+//AFMT5_AFMT_RAMP_CONTROL1
+#define AFMT5_AFMT_RAMP_CONTROL1__AFMT_RAMP_MIN_COUNT__SHIFT                                                  0x0
+#define AFMT5_AFMT_RAMP_CONTROL1__AFMT_AUDIO_TEST_CH_DISABLE__SHIFT                                           0x18
+#define AFMT5_AFMT_RAMP_CONTROL1__AFMT_RAMP_MIN_COUNT_MASK                                                    0x00FFFFFFL
+#define AFMT5_AFMT_RAMP_CONTROL1__AFMT_AUDIO_TEST_CH_DISABLE_MASK                                             0xFF000000L
+//AFMT5_AFMT_RAMP_CONTROL2
+#define AFMT5_AFMT_RAMP_CONTROL2__AFMT_RAMP_INC_COUNT__SHIFT                                                  0x0
+#define AFMT5_AFMT_RAMP_CONTROL2__AFMT_RAMP_INC_COUNT_MASK                                                    0x00FFFFFFL
+//AFMT5_AFMT_RAMP_CONTROL3
+#define AFMT5_AFMT_RAMP_CONTROL3__AFMT_RAMP_DEC_COUNT__SHIFT                                                  0x0
+#define AFMT5_AFMT_RAMP_CONTROL3__AFMT_RAMP_DEC_COUNT_MASK                                                    0x00FFFFFFL
+//AFMT5_AFMT_60958_2
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_2__SHIFT                                             0x0
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_3__SHIFT                                             0x4
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_4__SHIFT                                             0x8
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_5__SHIFT                                             0xc
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_6__SHIFT                                             0x10
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_7__SHIFT                                             0x14
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_2_MASK                                               0x0000000FL
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_3_MASK                                               0x000000F0L
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_4_MASK                                               0x00000F00L
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_5_MASK                                               0x0000F000L
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_6_MASK                                               0x000F0000L
+#define AFMT5_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_7_MASK                                               0x00F00000L
+//AFMT5_AFMT_AUDIO_CRC_RESULT
+#define AFMT5_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC_DONE__SHIFT                                               0x0
+#define AFMT5_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC__SHIFT                                                    0x8
+#define AFMT5_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC_DONE_MASK                                                 0x00000001L
+#define AFMT5_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC_MASK                                                      0xFFFFFF00L
+//AFMT5_AFMT_STATUS
+#define AFMT5_AFMT_STATUS__AFMT_AUDIO_ENABLE__SHIFT                                                           0x4
+#define AFMT5_AFMT_STATUS__AFMT_AZ_HBR_ENABLE__SHIFT                                                          0x8
+#define AFMT5_AFMT_STATUS__AFMT_AUDIO_FIFO_OVERFLOW__SHIFT                                                    0x18
+#define AFMT5_AFMT_STATUS__AFMT_AZ_AUDIO_ENABLE_CHG__SHIFT                                                    0x1e
+#define AFMT5_AFMT_STATUS__AFMT_AUDIO_ENABLE_MASK                                                             0x00000010L
+#define AFMT5_AFMT_STATUS__AFMT_AZ_HBR_ENABLE_MASK                                                            0x00000100L
+#define AFMT5_AFMT_STATUS__AFMT_AUDIO_FIFO_OVERFLOW_MASK                                                      0x01000000L
+#define AFMT5_AFMT_STATUS__AFMT_AZ_AUDIO_ENABLE_CHG_MASK                                                      0x40000000L
+//AFMT5_AFMT_AUDIO_PACKET_CONTROL
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND__SHIFT                                        0x0
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_DOUBLE_BUFFER_ENABLE__SHIFT                   0x4
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_RESET_FIFO_WHEN_AUDIO_DIS__SHIFT                                0xb
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_EN__SHIFT                                            0xc
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_MODE__SHIFT                                          0xe
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_FIFO_OVERFLOW_ACK__SHIFT                                  0x17
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_CHANNEL_SWAP__SHIFT                                       0x18
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_60958_CS_UPDATE__SHIFT                                          0x1a
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AZ_AUDIO_ENABLE_CHG_ACK__SHIFT                                  0x1e
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_BLANK_TEST_DATA_ON_ENC_ENB__SHIFT                               0x1f
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_MASK                                          0x00000001L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_DOUBLE_BUFFER_ENABLE_MASK                     0x00000010L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_RESET_FIFO_WHEN_AUDIO_DIS_MASK                                  0x00000800L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_EN_MASK                                              0x00001000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_MODE_MASK                                            0x00004000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_FIFO_OVERFLOW_ACK_MASK                                    0x00800000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_CHANNEL_SWAP_MASK                                         0x01000000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_60958_CS_UPDATE_MASK                                            0x04000000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_AZ_AUDIO_ENABLE_CHG_ACK_MASK                                    0x40000000L
+#define AFMT5_AFMT_AUDIO_PACKET_CONTROL__AFMT_BLANK_TEST_DATA_ON_ENC_ENB_MASK                                 0x80000000L
+//AFMT5_AFMT_INFOFRAME_CONTROL0
+#define AFMT5_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_SOURCE__SHIFT                                          0x6
+#define AFMT5_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_UPDATE__SHIFT                                          0x7
+#define AFMT5_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_SOURCE_MASK                                            0x00000040L
+#define AFMT5_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_UPDATE_MASK                                            0x00000080L
+//AFMT5_AFMT_AUDIO_SRC_CONTROL
+#define AFMT5_AFMT_AUDIO_SRC_CONTROL__AFMT_AUDIO_SRC_SELECT__SHIFT                                            0x0
+#define AFMT5_AFMT_AUDIO_SRC_CONTROL__AFMT_AUDIO_SRC_SELECT_MASK                                              0x00000007L
+//AFMT5_AFMT_AUDIO_DBG_DTO_CNTL
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_FS_DIV_SEL__SHIFT                                       0x0
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_BASE__SHIFT                                         0x8
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_MULTI__SHIFT                                        0xc
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_DIV__SHIFT                                          0x10
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_FS_DIV_SEL_MASK                                         0x00000007L
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_BASE_MASK                                           0x00000100L
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_MULTI_MASK                                          0x00007000L
+#define AFMT5_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_DIV_MASK                                            0x00070000L
+//AFMT5_AFMT_MEM_PWR
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_DIS__SHIFT                                                           0x0
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_FORCE__SHIFT                                                         0x4
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_STATE__SHIFT                                                         0x8
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_DIS_MASK                                                             0x00000001L
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_FORCE_MASK                                                           0x00000030L
+#define AFMT5_AFMT_MEM_PWR__AFMT_MEM_PWR_STATE_MASK                                                           0x00000300L
+
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_vpg_vpg_dispdec
+//VPG5_VPG_GENERIC_PACKET_ACCESS_CTRL
+#define VPG5_VPG_GENERIC_PACKET_ACCESS_CTRL__VPG_GENERIC_DATA_INDEX__SHIFT                                    0x0
+#define VPG5_VPG_GENERIC_PACKET_ACCESS_CTRL__VPG_GENERIC_DATA_INDEX_MASK                                      0x000000FFL
+//VPG5_VPG_GENERIC_PACKET_DATA
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE0__SHIFT                                           0x0
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE1__SHIFT                                           0x8
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE2__SHIFT                                           0x10
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE3__SHIFT                                           0x18
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE0_MASK                                             0x000000FFL
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE1_MASK                                             0x0000FF00L
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE2_MASK                                             0x00FF0000L
+#define VPG5_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE3_MASK                                             0xFF000000L
+//VPG5_VPG_GSP_FRAME_UPDATE_CTRL
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE__SHIFT                                      0x0
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE__SHIFT                                      0x1
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE__SHIFT                                      0x2
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE__SHIFT                                      0x3
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE__SHIFT                                      0x4
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE__SHIFT                                      0x5
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE__SHIFT                                      0x6
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE__SHIFT                                      0x7
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE__SHIFT                                      0x8
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE__SHIFT                                      0x9
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE__SHIFT                                     0xa
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE__SHIFT                                     0xb
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE__SHIFT                                     0xc
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE__SHIFT                                     0xd
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE__SHIFT                                     0xe
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE_PENDING__SHIFT                              0x10
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE_PENDING__SHIFT                              0x11
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE_PENDING__SHIFT                              0x12
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE_PENDING__SHIFT                              0x13
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE_PENDING__SHIFT                              0x14
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE_PENDING__SHIFT                              0x15
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE_PENDING__SHIFT                              0x16
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE_PENDING__SHIFT                              0x17
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE_PENDING__SHIFT                              0x18
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE_PENDING__SHIFT                              0x19
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE_PENDING__SHIFT                             0x1a
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE_PENDING__SHIFT                             0x1b
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE_PENDING__SHIFT                             0x1c
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE_PENDING__SHIFT                             0x1d
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE_PENDING__SHIFT                             0x1e
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE_MASK                                        0x00000001L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE_MASK                                        0x00000002L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE_MASK                                        0x00000004L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE_MASK                                        0x00000008L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE_MASK                                        0x00000010L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE_MASK                                        0x00000020L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE_MASK                                        0x00000040L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE_MASK                                        0x00000080L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE_MASK                                        0x00000100L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE_MASK                                        0x00000200L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE_MASK                                       0x00000400L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE_MASK                                       0x00000800L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE_MASK                                       0x00001000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE_MASK                                       0x00002000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE_MASK                                       0x00004000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE_PENDING_MASK                                0x00010000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE_PENDING_MASK                                0x00020000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE_PENDING_MASK                                0x00040000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE_PENDING_MASK                                0x00080000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE_PENDING_MASK                                0x00100000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE_PENDING_MASK                                0x00200000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE_PENDING_MASK                                0x00400000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE_PENDING_MASK                                0x00800000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE_PENDING_MASK                                0x01000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE_PENDING_MASK                                0x02000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE_PENDING_MASK                               0x04000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE_PENDING_MASK                               0x08000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE_PENDING_MASK                               0x10000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE_PENDING_MASK                               0x20000000L
+#define VPG5_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE_PENDING_MASK                               0x40000000L
+//VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE__SHIFT                              0x0
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE__SHIFT                              0x1
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE__SHIFT                              0x2
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE__SHIFT                              0x3
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE__SHIFT                              0x4
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE__SHIFT                              0x5
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE__SHIFT                              0x6
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE__SHIFT                              0x7
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE__SHIFT                              0x8
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE__SHIFT                              0x9
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE__SHIFT                             0xa
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE__SHIFT                             0xb
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE__SHIFT                             0xc
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE__SHIFT                             0xd
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE__SHIFT                             0xe
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x10
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x11
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x12
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x13
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x14
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x15
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x16
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x17
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x18
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x19
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1a
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1b
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1c
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1d
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1e
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE_MASK                                0x00000001L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE_MASK                                0x00000002L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE_MASK                                0x00000004L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE_MASK                                0x00000008L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE_MASK                                0x00000010L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE_MASK                                0x00000020L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE_MASK                                0x00000040L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE_MASK                                0x00000080L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE_MASK                                0x00000100L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE_MASK                                0x00000200L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE_MASK                               0x00000400L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE_MASK                               0x00000800L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE_MASK                               0x00001000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE_MASK                               0x00002000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE_MASK                               0x00004000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE_PENDING_MASK                        0x00010000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE_PENDING_MASK                        0x00020000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE_PENDING_MASK                        0x00040000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE_PENDING_MASK                        0x00080000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE_PENDING_MASK                        0x00100000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE_PENDING_MASK                        0x00200000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE_PENDING_MASK                        0x00400000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE_PENDING_MASK                        0x00800000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE_PENDING_MASK                        0x01000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE_PENDING_MASK                        0x02000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE_PENDING_MASK                       0x04000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE_PENDING_MASK                       0x08000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE_PENDING_MASK                       0x10000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE_PENDING_MASK                       0x20000000L
+#define VPG5_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE_PENDING_MASK                       0x40000000L
+//VPG5_VPG_GENERIC_STATUS
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_LOCK_STATUS__SHIFT                                               0x0
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_OCCURED__SHIFT                                          0x1
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_CLR__SHIFT                                              0x4
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_LOCK_STATUS_MASK                                                 0x00000001L
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_OCCURED_MASK                                            0x00000002L
+#define VPG5_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_CLR_MASK                                                0x00000010L
+//VPG5_VPG_MEM_PWR
+#define VPG5_VPG_MEM_PWR__VPG_GSP_MEM_LIGHT_SLEEP_DIS__SHIFT                                                  0x0
+#define VPG5_VPG_MEM_PWR__VPG_GSP_LIGHT_SLEEP_FORCE__SHIFT                                                    0x4
+#define VPG5_VPG_MEM_PWR__VPG_GSP_MEM_PWR_STATE__SHIFT                                                        0x8
+#define VPG5_VPG_MEM_PWR__VPG_GSP_MEM_LIGHT_SLEEP_DIS_MASK                                                    0x00000001L
+#define VPG5_VPG_MEM_PWR__VPG_GSP_LIGHT_SLEEP_FORCE_MASK                                                      0x00000010L
+#define VPG5_VPG_MEM_PWR__VPG_GSP_MEM_PWR_STATE_MASK                                                          0x00000100L
+//VPG5_VPG_ISRC1_2_ACCESS_CTRL
+#define VPG5_VPG_ISRC1_2_ACCESS_CTRL__VPG_ISRC1_2_DATA_INDEX__SHIFT                                           0x0
+#define VPG5_VPG_ISRC1_2_ACCESS_CTRL__VPG_ISRC1_2_DATA_INDEX_MASK                                             0x0000000FL
+//VPG5_VPG_ISRC1_2_DATA
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE0__SHIFT                                                     0x0
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE1__SHIFT                                                     0x8
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE2__SHIFT                                                     0x10
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE3__SHIFT                                                     0x18
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE0_MASK                                                       0x000000FFL
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE1_MASK                                                       0x0000FF00L
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE2_MASK                                                       0x00FF0000L
+#define VPG5_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE3_MASK                                                       0xFF000000L
+//VPG5_VPG_MPEG_INFO0
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_CHECKSUM__SHIFT                                                    0x0
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB0__SHIFT                                                         0x8
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB1__SHIFT                                                         0x10
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB2__SHIFT                                                         0x18
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_CHECKSUM_MASK                                                      0x000000FFL
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB0_MASK                                                           0x0000FF00L
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB1_MASK                                                           0x00FF0000L
+#define VPG5_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB2_MASK                                                           0xFF000000L
+//VPG5_VPG_MPEG_INFO1
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_MB3__SHIFT                                                         0x0
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_MF__SHIFT                                                          0x8
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_FR__SHIFT                                                          0xc
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_UPDATE__SHIFT                                                      0x10
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_MB3_MASK                                                           0x000000FFL
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_MF_MASK                                                            0x00000300L
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_FR_MASK                                                            0x00001000L
+#define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_UPDATE_MASK                                                        0x00010000L
+
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_dme_dme_dispdec
+//DME5_DME_CONTROL
+#define DME5_DME_CONTROL__METADATA_HUBP_REQUESTOR_ID__SHIFT                                                   0x0
+#define DME5_DME_CONTROL__METADATA_ENGINE_EN__SHIFT                                                           0x4
+#define DME5_DME_CONTROL__METADATA_STREAM_TYPE__SHIFT                                                         0x8
+#define DME5_DME_CONTROL__METADATA_DB_PENDING__SHIFT                                                          0xc
+#define DME5_DME_CONTROL__METADATA_DB_TAKEN__SHIFT                                                            0xd
+#define DME5_DME_CONTROL__METADATA_DB_TAKEN_CLR__SHIFT                                                        0x10
+#define DME5_DME_CONTROL__METADATA_DB_DISABLE__SHIFT                                                          0x14
+#define DME5_DME_CONTROL__METADATA_HUBP_REQUESTOR_ID_MASK                                                     0x00000007L
+#define DME5_DME_CONTROL__METADATA_ENGINE_EN_MASK                                                             0x00000010L
+#define DME5_DME_CONTROL__METADATA_STREAM_TYPE_MASK                                                           0x00000100L
+#define DME5_DME_CONTROL__METADATA_DB_PENDING_MASK                                                            0x00001000L
+#define DME5_DME_CONTROL__METADATA_DB_TAKEN_MASK                                                              0x00002000L
+#define DME5_DME_CONTROL__METADATA_DB_TAKEN_CLR_MASK                                                          0x00010000L
+#define DME5_DME_CONTROL__METADATA_DB_DISABLE_MASK                                                            0x00100000L
+//DME5_DME_MEMORY_CONTROL
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_FORCE__SHIFT                                                     0x0
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_DIS__SHIFT                                                       0x4
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_STATE__SHIFT                                                     0x8
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_DEFAULT_MEM_LOW_POWER_STATE__SHIFT                                   0xc
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_FORCE_MASK                                                       0x00000003L
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_DIS_MASK                                                         0x00000010L
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_PWR_STATE_MASK                                                       0x00000300L
+#define DME5_DME_MEMORY_CONTROL__DME_MEM_DEFAULT_MEM_LOW_POWER_STATE_MASK                                     0x00003000L
+
+
+// addressBlock: dce_dc_hpo_hdmi_link_enc0_dispdec
+//HDMI_LINK_ENC_CONTROL
+#define HDMI_LINK_ENC_CONTROL__HDMI_LINK_ENC_ENABLE__SHIFT                                                    0x0
+#define HDMI_LINK_ENC_CONTROL__HDMI_LINK_ENC_SOFT_RESET__SHIFT                                                0x4
+#define HDMI_LINK_ENC_CONTROL__HDMI_LINK_ENC_ENABLE_MASK                                                      0x00000001L
+#define HDMI_LINK_ENC_CONTROL__HDMI_LINK_ENC_SOFT_RESET_MASK                                                  0x00000010L
+//HDMI_LINK_ENC_CLK_CTRL
+#define HDMI_LINK_ENC_CLK_CTRL__HDMI_LINK_ENC_CLOCK_EN__SHIFT                                                 0x0
+#define HDMI_LINK_ENC_CLK_CTRL__HDMI_LINK_ENC_CLOCK_ON_HDMICHARCLK__SHIFT                                     0x1
+#define HDMI_LINK_ENC_CLK_CTRL__HDMI_LINK_ENC_CLOCK_EN_MASK                                                   0x00000001L
+#define HDMI_LINK_ENC_CLK_CTRL__HDMI_LINK_ENC_CLOCK_ON_HDMICHARCLK_MASK                                       0x00000002L
+
+
+// addressBlock: dce_dc_hpo_hdmi_frl_enc0_dispdec
+//HDMI_FRL_ENC_CONFIG
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE_COUNT__SHIFT                                                      0x0
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_TRAINING_ENABLE__SHIFT                                                 0x1
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_SCRAMBLER_DISABLE__SHIFT                                               0x2
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE0_TRAINING_PATTERN__SHIFT                                          0x10
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE1_TRAINING_PATTERN__SHIFT                                          0x14
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE2_TRAINING_PATTERN__SHIFT                                          0x18
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE3_TRAINING_PATTERN__SHIFT                                          0x1c
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE_COUNT_MASK                                                        0x00000001L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_TRAINING_ENABLE_MASK                                                   0x00000002L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_SCRAMBLER_DISABLE_MASK                                                 0x00000004L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE0_TRAINING_PATTERN_MASK                                            0x000F0000L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE1_TRAINING_PATTERN_MASK                                            0x00F00000L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE2_TRAINING_PATTERN_MASK                                            0x0F000000L
+#define HDMI_FRL_ENC_CONFIG__HDMI_LINK_LANE3_TRAINING_PATTERN_MASK                                            0xF0000000L
+//HDMI_FRL_ENC_CONFIG2
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_MAX_JITTER_VALUE__SHIFT                                               0x0
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_THRESHOLD__SHIFT                                               0xc
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_CAL_EN__SHIFT                                                  0x18
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_RC_COMPRESS_DISABLE__SHIFT                                            0x19
+#define HDMI_FRL_ENC_CONFIG2__HDMI_FRL_HDMISTREAMCLK_DB_SEL__SHIFT                                            0x1a
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_MAX_JITTER_VALUE_RESET__SHIFT                                         0x1c
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_EXCEED_STATUS__SHIFT                                           0x1d
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_METER_BUFFER_OVERFLOW_STATUS__SHIFT                                   0x1e
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_MAX_JITTER_VALUE_MASK                                                 0x000001FFL
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_THRESHOLD_MASK                                                 0x001FF000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_CAL_EN_MASK                                                    0x01000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_RC_COMPRESS_DISABLE_MASK                                              0x02000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_FRL_HDMISTREAMCLK_DB_SEL_MASK                                              0x0C000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_MAX_JITTER_VALUE_RESET_MASK                                           0x10000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_JITTER_EXCEED_STATUS_MASK                                             0x20000000L
+#define HDMI_FRL_ENC_CONFIG2__HDMI_LINK_METER_BUFFER_OVERFLOW_STATUS_MASK                                     0x40000000L
+//HDMI_FRL_ENC_METER_BUFFER_STATUS
+#define HDMI_FRL_ENC_METER_BUFFER_STATUS__HDMI_LINK_MAX_METER_BUFFER_LEVEL__SHIFT                             0x0
+#define HDMI_FRL_ENC_METER_BUFFER_STATUS__HDMI_LINK_METER_BUFFER_MAX_LEVEL_RESET__SHIFT                       0x1f
+#define HDMI_FRL_ENC_METER_BUFFER_STATUS__HDMI_LINK_MAX_METER_BUFFER_LEVEL_MASK                               0x0000007FL
+#define HDMI_FRL_ENC_METER_BUFFER_STATUS__HDMI_LINK_METER_BUFFER_MAX_LEVEL_RESET_MASK                         0x80000000L
+//HDMI_FRL_ENC_MEM_CTRL
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_DIS__SHIFT                                                 0x0
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_FORCE__SHIFT                                               0x1
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_STATE__SHIFT                                               0x4
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE__SHIFT                             0x8
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_DIS_MASK                                                   0x00000001L
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_FORCE_MASK                                                 0x00000006L
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_PWR_STATE_MASK                                                 0x00000030L
+#define HDMI_FRL_ENC_MEM_CTRL__METERBUFFER_MEM_DEFAULT_MEM_LOW_POWER_STATE_MASK                               0x00000300L
+
+
+// addressBlock: dce_dc_hpo_hpo_top_dispdec
+//HPO_TOP_CLOCK_CONTROL
+#define HPO_TOP_CLOCK_CONTROL__HPO_DISPCLK_R_GATE_DIS__SHIFT                                                  0x0
+#define HPO_TOP_CLOCK_CONTROL__HPO_DISPCLK_GATE_DIS__SHIFT                                                    0x1
+#define HPO_TOP_CLOCK_CONTROL__HPO_SOCCLK_R_GATE_DIS__SHIFT                                                   0x4
+#define HPO_TOP_CLOCK_CONTROL__HPO_SOCCLK_GATE_DIS__SHIFT                                                     0x5
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_R_GATE_DIS__SHIFT                                            0x8
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS__SHIFT                                              0x9
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMICHARCLK_R_GATE_DIS__SHIFT                                              0xc
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMICHARCLK_GATE_DIS__SHIFT                                                0xd
+#define HPO_TOP_CLOCK_CONTROL__HPO_TEST_CLK_SEL__SHIFT                                                        0x10
+#define HPO_TOP_CLOCK_CONTROL__HPO_DISPCLK_R_GATE_DIS_MASK                                                    0x00000001L
+#define HPO_TOP_CLOCK_CONTROL__HPO_DISPCLK_GATE_DIS_MASK                                                      0x00000002L
+#define HPO_TOP_CLOCK_CONTROL__HPO_SOCCLK_R_GATE_DIS_MASK                                                     0x00000010L
+#define HPO_TOP_CLOCK_CONTROL__HPO_SOCCLK_GATE_DIS_MASK                                                       0x00000020L
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_R_GATE_DIS_MASK                                              0x00000100L
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS_MASK                                                0x00000200L
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMICHARCLK_R_GATE_DIS_MASK                                                0x00001000L
+#define HPO_TOP_CLOCK_CONTROL__HPO_HDMICHARCLK_GATE_DIS_MASK                                                  0x00002000L
+#define HPO_TOP_CLOCK_CONTROL__HPO_TEST_CLK_SEL_MASK                                                          0x003F0000L
+
 
 // addressBlock: dce_dc_hpo_hpo_dcperfmon_dc_perfmon_dispdec
 //DC_PERFMON26_PERFCOUNTER_CNTL
-- 
2.54.0

