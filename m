Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB9ACD3444
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 15:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9438010F1E6;
	Thu,  7 May 2026 15:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yPpxl2Gy";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21A110F1E4
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 15:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIs+rPxxxoADJh0PkQAsNHvU6AaNjUsZ3tBJtAg329+ed1hIsWJ1nyzeoKt4fuNtMqbMbDgg2+2dALG7EpwxvIwkQ/i7ecZS4U6w0KYWTtLCAazMUN7Nl24DmdGWFSNRdbciBx6YOA1uN6G4JVFRlVWarA1GoX9J30MN+lea4u2oWlOdLHaMyGAweGOaNQtPfbFGQAFJ1nuk9RcjzT4FgV0YhHtvF20L3cm0yhj5w99sAjR1sXZCi+f8IP186HGyR9wH79yn373k5Uvhd0/HuhB5VgEHIlBR9gH8wywHs7mydfJ971freHmQaKSHb/AmTGQy9I2hdzpgMX8Jis/Z8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNwg1b0g+e6qw7SC6RIS4u3RVHs0fSARRzeeh2OjVwA=;
 b=d0xpoH7PdG8nbzuAvp3aBjDQ4giHPhWAJQXuEdsYu2gpGmA9lNIcgRwQ0jnA0BKisZ6ji8yorZFKUB7TsTqceovuuSwJZfSCilPxYfwrD6+fM3qz+hQDcL2fhr3HkM9QW1TGbNwLLRcg2KUZA7MOc0sXxiDn3+aBk1Yk0UYqmBnvTMSvBTI3xb/5DEytIQ6okWUFA7drayjWGMcZcOnmyH9KlWDjHlGV10OhCcNc4TgNxQfHbV8m8GRYb2HCqXoGPTV/fPrxuZUTE2C9hr6ynpoUdjNCtDQdnh55Yd3AyObsJBEMUT0YpqHj8Q0cDMo3qx7D6oMTrpzL0pf3dbRQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNwg1b0g+e6qw7SC6RIS4u3RVHs0fSARRzeeh2OjVwA=;
 b=yPpxl2Gyop+AEm4PhOLk1AtNKX5c5DcuDZ0MhXDYC8vLVZ7gJpMG9qq7YyXu1xUd2RBDPWIdDhkwNKxjq+OF7/lHcuQleqSMEOlFCV2qgiPLWsBEAeW0rGfiDbRHf6Jdrfj45QflGqTSo00E1x90hYueGx8jd9W8KUNuTjOt/lE=
Received: from PH7PR17CA0068.namprd17.prod.outlook.com (2603:10b6:510:325::12)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 15:51:56 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::43) by PH7PR17CA0068.outlook.office365.com
 (2603:10b6:510:325::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 15:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:51:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 10:51:54 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 10:51:54 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH v2 08/22] drm/amd/display: Add FRL register for DCN303
Date: Thu, 7 May 2026 11:51:30 -0400
Message-ID: <20260507155147.182540-9-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155147.182540-1-harry.wentland@amd.com>
References: <20260507155147.182540-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 252cdd77-4828-4cd0-13bf-08deac509098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: wHldOHg00EBbh04++RuxWwGHa1FJrnA45f815bDsVVzRdGOv5JGryitTn7UHrpgCOFH5RbvLCOmtgmY0ItUuE1IcJUrC4JesG+dOGBd3Xgz/gNGzF3BuCnwlaI1HeVH7O+DgCQJC0Voc37YdxMvinLDpEl7fErqsJPegcQVOs48SkcCETa4KNIbon5HFez6qxhCrX1BPQ1o3FCsYD4RH4PWKZaIvc2Jb//ueEUuKpuO5l7IP+paskUJIyEaruH0TsCEakODgJbwAbaAmK09zwWfrBnyrDbAhBcl2b0+nCaEP4QJ3QG1nuk+BUpzK0fHlnL7JJHQkdnJY/cnkGJR9+wMl3ibY4HKQrB/pCe4HsnX/5AIRvyKCHdkVyK5jy9hbCCtY9YrHZmcLHCr7FWLan3M3l5PG4duQF4GGiXxpAZ/hDmbmnXmRRffSIbdEDBe8hk6MsguSQ7ob/LKtlDq4McXeON7StUUoft+YY0v/75SE4lt8dRJTwbhpIOosrlZsXf0jfIRz4EwWbGUSmGK5FOaBHcr9/s7HNvvUcAJMO8ZAQ8kvm2joLAeoAKQfvazHWbGw7QadqYgJ+a2sCTGxmy2QFwL0WyJIUIi9yyvU7JKfKC2dDphecZGxOcr/7welaQFcfR1+TWf1Tg3d5HAPns2PI0tvdVIWc1rwx7gyxjB3np81oLlHv3DBvKoGrBKgeYgfqgRvZavXHwhSbAMJLL73ym6pbQ2p9MXVylZw0aI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tnoZUjVHXZA1vitY8NIh9FqxAR8yjqSYLfXaR2NqqEmphRh+vHWD2RwKWSTPOKJx/da+rAL0qT3LoBECG7Ldm8schl+T3GJyJD1oL5aYyQ256AHakkYXZIRrJ0cRRQKfA3JKmNlPVPm8iY2cwjs3FDBe1CQ4kKRYHDQK6YJl9QNO1YU1vQQBeyjDRbyYHd8wImnYEGgy/avfhffMCl/eZFSuMrZEVr1uW5r2MwUlNouzrBk87ufXFUjTcizor8NsDAAEEuanzeCNCDLZyLl4fEHcm+CnxZs/ZtoSrEHJ6nFoOmJrM5ZfOxzCyq+VKcq6S7ZIElxupbtdXlT74/7VMILrhxuZJJ26QE09KZSrZuaHIeGVCiN7N6BzMvHpZ5jxOG3Tn6sbSqLD3vF8M8rclZhHr/JUvIF7fB4YKLG2R5ZeET5QFJntgAHjHiFaPiwU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:51:55.5506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 252cdd77-4828-4cd0-13bf-08deac509098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

Add all the required registers to support FRL on DCN303.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../include/asic_reg/dcn/dcn_3_0_3_offset.h   | 111 +++
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  | 941 ++++++++++++++++++
 2 files changed, 1052 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
index a3373d1e1736..9b1132bbab07 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
@@ -6838,6 +6838,98 @@
 #define mmDC_PERFMON15_PERFMON_LOW                                                                     0x08cf
 #define mmDC_PERFMON15_PERFMON_LOW_BASE_IDX                                                            3
 
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
 
 // addressBlock: dce_dc_hpo_hdmi_stream_enc0_afmt_afmt_dispdec
 // base address: 0x2646c
@@ -6882,6 +6974,25 @@
 #define mmDME2_DME_MEMORY_CONTROL                                                                      0x093d
 #define mmDME2_DME_MEMORY_CONTROL_BASE_IDX                                                             3
 
+// addressBlock: dce_dc_hpo_hdmi_link_enc0_dispdec
+// base address: 0x2656c
+#define mmHDMI_LINK_ENC_CONTROL                                                                        0x095b
+#define mmHDMI_LINK_ENC_CONTROL_BASE_IDX                                                               3
+#define mmHDMI_LINK_ENC_CLK_CTRL                                                                       0x095c
+#define mmHDMI_LINK_ENC_CLK_CTRL_BASE_IDX                                                              3
+
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
 
 // addressBlock: dce_dc_hpo_hpo_top_dispdec
 // base address: 0x0
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
index 9549494b65b5..0326604ea9a7 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
@@ -26316,6 +26316,947 @@
 #define DC_PERFMON15_PERFMON_LOW__PERFMON_LOW__SHIFT                                                          0x0
 #define DC_PERFMON15_PERFMON_LOW__PERFMON_LOW_MASK                                                            0xFFFFFFFFL
 
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
+//AFMT2_AFMT_ACP
+#define AFMT2_AFMT_ACP__AFMT_ACP_TYPE__SHIFT                                                                  0x0
+#define AFMT2_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE0__SHIFT                                                  0x8
+#define AFMT2_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE1__SHIFT                                                  0x10
+#define AFMT2_AFMT_ACP__AFMT_ACP_TYPE_MASK                                                                    0x00000003L
+#define AFMT2_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE0_MASK                                                    0x0000FF00L
+#define AFMT2_AFMT_ACP__AFMT_ACP_TYPE_DEPENDENT_BYTE1_MASK                                                    0x00FF0000L
+//AFMT2_AFMT_VBI_PACKET_CONTROL
+#define AFMT2_AFMT_VBI_PACKET_CONTROL__AFMT_ACP_SOURCE__SHIFT                                                 0xd
+#define AFMT2_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_PACKETS_PER_LINE__SHIFT                                0x10
+#define AFMT2_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_SEND_MAX_PACKETS__SHIFT                                0x18
+#define AFMT2_AFMT_VBI_PACKET_CONTROL__AFMT_ACP_SOURCE_MASK                                                   0x00002000L
+#define AFMT2_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_PACKETS_PER_LINE_MASK                                  0x001F0000L
+#define AFMT2_AFMT_VBI_PACKET_CONTROL__AFMT_HDMI_AUDIO_SEND_MAX_PACKETS_MASK                                  0x01000000L
+//AFMT2_AFMT_AUDIO_PACKET_CONTROL2
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_OVRD__SHIFT                                       0x0
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_SELECT__SHIFT                                     0x1
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_CHANNEL_ENABLE__SHIFT                                    0x8
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_DP_AUDIO_STREAM_ID__SHIFT                                      0x10
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_HBR_ENABLE_OVRD__SHIFT                                         0x18
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_60958_OSF_OVRD__SHIFT                                          0x1c
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_OVRD_MASK                                         0x00000001L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_LAYOUT_SELECT_MASK                                       0x00000002L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_CHANNEL_ENABLE_MASK                                      0x0000FF00L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_DP_AUDIO_STREAM_ID_MASK                                        0x00FF0000L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_HBR_ENABLE_OVRD_MASK                                           0x01000000L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL2__AFMT_60958_OSF_OVRD_MASK                                            0x10000000L
+//AFMT2_AFMT_AUDIO_INFO0
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM__SHIFT                                               0x0
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CC__SHIFT                                                     0x8
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CT__SHIFT                                                     0xb
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM_OFFSET__SHIFT                                        0x10
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CXT__SHIFT                                                    0x18
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM_MASK                                                 0x000000FFL
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CC_MASK                                                       0x00000700L
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CT_MASK                                                       0x00007800L
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CHECKSUM_OFFSET_MASK                                          0x00FF0000L
+#define AFMT2_AFMT_AUDIO_INFO0__AFMT_AUDIO_INFO_CXT_MASK                                                      0x1F000000L
+//AFMT2_AFMT_AUDIO_INFO1
+#define AFMT2_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_CA__SHIFT                                                     0x0
+#define AFMT2_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LSV__SHIFT                                                    0xb
+#define AFMT2_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_DM_INH__SHIFT                                                 0xf
+#define AFMT2_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LFEPBL__SHIFT                                                 0x10
+#define AFMT2_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_CA_MASK                                                       0x000000FFL
+#define AFMT2_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LSV_MASK                                                      0x00007800L
+#define AFMT2_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_DM_INH_MASK                                                   0x00008000L
+#define AFMT2_AFMT_AUDIO_INFO1__AFMT_AUDIO_INFO_LFEPBL_MASK                                                   0x00030000L
+//AFMT2_AFMT_60958_0
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_A__SHIFT                                                            0x0
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_B__SHIFT                                                            0x1
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_C__SHIFT                                                            0x2
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_D__SHIFT                                                            0x3
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_MODE__SHIFT                                                         0x6
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_CATEGORY_CODE__SHIFT                                                0x8
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_SOURCE_NUMBER__SHIFT                                                0x10
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_CHANNEL_NUMBER_L__SHIFT                                             0x14
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_SAMPLING_FREQUENCY__SHIFT                                           0x18
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_CLOCK_ACCURACY__SHIFT                                               0x1c
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_A_MASK                                                              0x00000001L
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_B_MASK                                                              0x00000002L
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_C_MASK                                                              0x00000004L
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_D_MASK                                                              0x00000038L
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_MODE_MASK                                                           0x000000C0L
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_CATEGORY_CODE_MASK                                                  0x0000FF00L
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_SOURCE_NUMBER_MASK                                                  0x000F0000L
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_CHANNEL_NUMBER_L_MASK                                               0x00F00000L
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_SAMPLING_FREQUENCY_MASK                                             0x0F000000L
+#define AFMT2_AFMT_60958_0__AFMT_60958_CS_CLOCK_ACCURACY_MASK                                                 0x30000000L
+//AFMT2_AFMT_60958_1
+#define AFMT2_AFMT_60958_1__AFMT_60958_CS_WORD_LENGTH__SHIFT                                                  0x0
+#define AFMT2_AFMT_60958_1__AFMT_60958_CS_ORIGINAL_SAMPLING_FREQUENCY__SHIFT                                  0x4
+#define AFMT2_AFMT_60958_1__AFMT_60958_VALID_L__SHIFT                                                         0x10
+#define AFMT2_AFMT_60958_1__AFMT_60958_VALID_R__SHIFT                                                         0x12
+#define AFMT2_AFMT_60958_1__AFMT_60958_CS_CHANNEL_NUMBER_R__SHIFT                                             0x14
+#define AFMT2_AFMT_60958_1__AFMT_60958_CS_WORD_LENGTH_MASK                                                    0x0000000FL
+#define AFMT2_AFMT_60958_1__AFMT_60958_CS_ORIGINAL_SAMPLING_FREQUENCY_MASK                                    0x000000F0L
+#define AFMT2_AFMT_60958_1__AFMT_60958_VALID_L_MASK                                                           0x00010000L
+#define AFMT2_AFMT_60958_1__AFMT_60958_VALID_R_MASK                                                           0x00040000L
+#define AFMT2_AFMT_60958_1__AFMT_60958_CS_CHANNEL_NUMBER_R_MASK                                               0x00F00000L
+//AFMT2_AFMT_AUDIO_CRC_CONTROL
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_EN__SHIFT                                                0x0
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CONT__SHIFT                                              0x4
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_SOURCE__SHIFT                                            0x8
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CH_SEL__SHIFT                                            0xc
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_COUNT__SHIFT                                             0x10
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_EN_MASK                                                  0x00000001L
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CONT_MASK                                                0x00000010L
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_SOURCE_MASK                                              0x00000100L
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_CH_SEL_MASK                                              0x0000F000L
+#define AFMT2_AFMT_AUDIO_CRC_CONTROL__AFMT_AUDIO_CRC_COUNT_MASK                                               0xFFFF0000L
+//AFMT2_AFMT_RAMP_CONTROL0
+#define AFMT2_AFMT_RAMP_CONTROL0__AFMT_RAMP_MAX_COUNT__SHIFT                                                  0x0
+#define AFMT2_AFMT_RAMP_CONTROL0__AFMT_RAMP_DATA_SIGN__SHIFT                                                  0x1f
+#define AFMT2_AFMT_RAMP_CONTROL0__AFMT_RAMP_MAX_COUNT_MASK                                                    0x00FFFFFFL
+#define AFMT2_AFMT_RAMP_CONTROL0__AFMT_RAMP_DATA_SIGN_MASK                                                    0x80000000L
+//AFMT2_AFMT_RAMP_CONTROL1
+#define AFMT2_AFMT_RAMP_CONTROL1__AFMT_RAMP_MIN_COUNT__SHIFT                                                  0x0
+#define AFMT2_AFMT_RAMP_CONTROL1__AFMT_AUDIO_TEST_CH_DISABLE__SHIFT                                           0x18
+#define AFMT2_AFMT_RAMP_CONTROL1__AFMT_RAMP_MIN_COUNT_MASK                                                    0x00FFFFFFL
+#define AFMT2_AFMT_RAMP_CONTROL1__AFMT_AUDIO_TEST_CH_DISABLE_MASK                                             0xFF000000L
+//AFMT2_AFMT_RAMP_CONTROL2
+#define AFMT2_AFMT_RAMP_CONTROL2__AFMT_RAMP_INC_COUNT__SHIFT                                                  0x0
+#define AFMT2_AFMT_RAMP_CONTROL2__AFMT_RAMP_INC_COUNT_MASK                                                    0x00FFFFFFL
+//AFMT2_AFMT_RAMP_CONTROL3
+#define AFMT2_AFMT_RAMP_CONTROL3__AFMT_RAMP_DEC_COUNT__SHIFT                                                  0x0
+#define AFMT2_AFMT_RAMP_CONTROL3__AFMT_RAMP_DEC_COUNT_MASK                                                    0x00FFFFFFL
+//AFMT2_AFMT_60958_2
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_2__SHIFT                                             0x0
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_3__SHIFT                                             0x4
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_4__SHIFT                                             0x8
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_5__SHIFT                                             0xc
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_6__SHIFT                                             0x10
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_7__SHIFT                                             0x14
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_2_MASK                                               0x0000000FL
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_3_MASK                                               0x000000F0L
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_4_MASK                                               0x00000F00L
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_5_MASK                                               0x0000F000L
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_6_MASK                                               0x000F0000L
+#define AFMT2_AFMT_60958_2__AFMT_60958_CS_CHANNEL_NUMBER_7_MASK                                               0x00F00000L
+//AFMT2_AFMT_AUDIO_CRC_RESULT
+#define AFMT2_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC_DONE__SHIFT                                               0x0
+#define AFMT2_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC__SHIFT                                                    0x8
+#define AFMT2_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC_DONE_MASK                                                 0x00000001L
+#define AFMT2_AFMT_AUDIO_CRC_RESULT__AFMT_AUDIO_CRC_MASK                                                      0xFFFFFF00L
+//AFMT2_AFMT_STATUS
+#define AFMT2_AFMT_STATUS__AFMT_AUDIO_ENABLE__SHIFT                                                           0x4
+#define AFMT2_AFMT_STATUS__AFMT_AZ_HBR_ENABLE__SHIFT                                                          0x8
+#define AFMT2_AFMT_STATUS__AFMT_AUDIO_FIFO_OVERFLOW__SHIFT                                                    0x18
+#define AFMT2_AFMT_STATUS__AFMT_AZ_AUDIO_ENABLE_CHG__SHIFT                                                    0x1e
+#define AFMT2_AFMT_STATUS__AFMT_AUDIO_ENABLE_MASK                                                             0x00000010L
+#define AFMT2_AFMT_STATUS__AFMT_AZ_HBR_ENABLE_MASK                                                            0x00000100L
+#define AFMT2_AFMT_STATUS__AFMT_AUDIO_FIFO_OVERFLOW_MASK                                                      0x01000000L
+#define AFMT2_AFMT_STATUS__AFMT_AZ_AUDIO_ENABLE_CHG_MASK                                                      0x40000000L
+//AFMT2_AFMT_AUDIO_PACKET_CONTROL
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND__SHIFT                                        0x0
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_DOUBLE_BUFFER_ENABLE__SHIFT                   0x4
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_RESET_FIFO_WHEN_AUDIO_DIS__SHIFT                                0xb
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_EN__SHIFT                                            0xc
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_MODE__SHIFT                                          0xe
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_FIFO_OVERFLOW_ACK__SHIFT                                  0x17
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_CHANNEL_SWAP__SHIFT                                       0x18
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_60958_CS_UPDATE__SHIFT                                          0x1a
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AZ_AUDIO_ENABLE_CHG_ACK__SHIFT                                  0x1e
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_BLANK_TEST_DATA_ON_ENC_ENB__SHIFT                               0x1f
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_MASK                                          0x00000001L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_DOUBLE_BUFFER_ENABLE_MASK                     0x00000010L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_RESET_FIFO_WHEN_AUDIO_DIS_MASK                                  0x00000800L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_EN_MASK                                              0x00001000L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_TEST_MODE_MASK                                            0x00004000L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_FIFO_OVERFLOW_ACK_MASK                                    0x00800000L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_CHANNEL_SWAP_MASK                                         0x01000000L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_60958_CS_UPDATE_MASK                                            0x04000000L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_AZ_AUDIO_ENABLE_CHG_ACK_MASK                                    0x40000000L
+#define AFMT2_AFMT_AUDIO_PACKET_CONTROL__AFMT_BLANK_TEST_DATA_ON_ENC_ENB_MASK                                 0x80000000L
+//AFMT2_AFMT_INFOFRAME_CONTROL0
+#define AFMT2_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_SOURCE__SHIFT                                          0x6
+#define AFMT2_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_UPDATE__SHIFT                                          0x7
+#define AFMT2_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_SOURCE_MASK                                            0x00000040L
+#define AFMT2_AFMT_INFOFRAME_CONTROL0__AFMT_AUDIO_INFO_UPDATE_MASK                                            0x00000080L
+//AFMT2_AFMT_AUDIO_SRC_CONTROL
+#define AFMT2_AFMT_AUDIO_SRC_CONTROL__AFMT_AUDIO_SRC_SELECT__SHIFT                                            0x0
+#define AFMT2_AFMT_AUDIO_SRC_CONTROL__AFMT_AUDIO_SRC_SELECT_MASK                                              0x00000007L
+//AFMT2_AFMT_AUDIO_DBG_DTO_CNTL
+#define AFMT2_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_FS_DIV_SEL__SHIFT                                       0x0
+#define AFMT2_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_BASE__SHIFT                                         0x8
+#define AFMT2_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_MULTI__SHIFT                                        0xc
+#define AFMT2_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_DIV__SHIFT                                          0x10
+#define AFMT2_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_FS_DIV_SEL_MASK                                         0x00000007L
+#define AFMT2_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_BASE_MASK                                           0x00000100L
+#define AFMT2_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_MULTI_MASK                                          0x00007000L
+#define AFMT2_AFMT_AUDIO_DBG_DTO_CNTL__AFMT_AUDIO_DTO_DBG_DIV_MASK                                            0x00070000L
+//AFMT2_AFMT_MEM_PWR
+#define AFMT2_AFMT_MEM_PWR__AFMT_MEM_PWR_DIS__SHIFT                                                           0x0
+#define AFMT2_AFMT_MEM_PWR__AFMT_MEM_PWR_FORCE__SHIFT                                                         0x4
+#define AFMT2_AFMT_MEM_PWR__AFMT_MEM_PWR_STATE__SHIFT                                                         0x8
+#define AFMT2_AFMT_MEM_PWR__AFMT_MEM_PWR_DIS_MASK                                                             0x00000001L
+#define AFMT2_AFMT_MEM_PWR__AFMT_MEM_PWR_FORCE_MASK                                                           0x00000030L
+#define AFMT2_AFMT_MEM_PWR__AFMT_MEM_PWR_STATE_MASK                                                           0x00000300L
+
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_vpg_vpg_dispdec
+//VPG2_VPG_GENERIC_PACKET_ACCESS_CTRL
+#define VPG2_VPG_GENERIC_PACKET_ACCESS_CTRL__VPG_GENERIC_DATA_INDEX__SHIFT                                    0x0
+#define VPG2_VPG_GENERIC_PACKET_ACCESS_CTRL__VPG_GENERIC_DATA_INDEX_MASK                                      0x000000FFL
+//VPG2_VPG_GENERIC_PACKET_DATA
+#define VPG2_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE0__SHIFT                                           0x0
+#define VPG2_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE1__SHIFT                                           0x8
+#define VPG2_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE2__SHIFT                                           0x10
+#define VPG2_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE3__SHIFT                                           0x18
+#define VPG2_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE0_MASK                                             0x000000FFL
+#define VPG2_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE1_MASK                                             0x0000FF00L
+#define VPG2_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE2_MASK                                             0x00FF0000L
+#define VPG2_VPG_GENERIC_PACKET_DATA__VPG_GENERIC_DATA_BYTE3_MASK                                             0xFF000000L
+//VPG2_VPG_GSP_FRAME_UPDATE_CTRL
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE__SHIFT                                      0x0
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE__SHIFT                                      0x1
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE__SHIFT                                      0x2
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE__SHIFT                                      0x3
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE__SHIFT                                      0x4
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE__SHIFT                                      0x5
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE__SHIFT                                      0x6
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE__SHIFT                                      0x7
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE__SHIFT                                      0x8
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE__SHIFT                                      0x9
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE__SHIFT                                     0xa
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE__SHIFT                                     0xb
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE__SHIFT                                     0xc
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE__SHIFT                                     0xd
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE__SHIFT                                     0xe
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE_PENDING__SHIFT                              0x10
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE_PENDING__SHIFT                              0x11
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE_PENDING__SHIFT                              0x12
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE_PENDING__SHIFT                              0x13
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE_PENDING__SHIFT                              0x14
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE_PENDING__SHIFT                              0x15
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE_PENDING__SHIFT                              0x16
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE_PENDING__SHIFT                              0x17
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE_PENDING__SHIFT                              0x18
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE_PENDING__SHIFT                              0x19
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE_PENDING__SHIFT                             0x1a
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE_PENDING__SHIFT                             0x1b
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE_PENDING__SHIFT                             0x1c
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE_PENDING__SHIFT                             0x1d
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE_PENDING__SHIFT                             0x1e
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE_MASK                                        0x00000001L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE_MASK                                        0x00000002L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE_MASK                                        0x00000004L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE_MASK                                        0x00000008L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE_MASK                                        0x00000010L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE_MASK                                        0x00000020L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE_MASK                                        0x00000040L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE_MASK                                        0x00000080L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE_MASK                                        0x00000100L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE_MASK                                        0x00000200L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE_MASK                                       0x00000400L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE_MASK                                       0x00000800L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE_MASK                                       0x00001000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE_MASK                                       0x00002000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE_MASK                                       0x00004000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC0_FRAME_UPDATE_PENDING_MASK                                0x00010000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC1_FRAME_UPDATE_PENDING_MASK                                0x00020000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC2_FRAME_UPDATE_PENDING_MASK                                0x00040000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC3_FRAME_UPDATE_PENDING_MASK                                0x00080000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC4_FRAME_UPDATE_PENDING_MASK                                0x00100000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC5_FRAME_UPDATE_PENDING_MASK                                0x00200000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC6_FRAME_UPDATE_PENDING_MASK                                0x00400000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC7_FRAME_UPDATE_PENDING_MASK                                0x00800000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC8_FRAME_UPDATE_PENDING_MASK                                0x01000000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC9_FRAME_UPDATE_PENDING_MASK                                0x02000000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC10_FRAME_UPDATE_PENDING_MASK                               0x04000000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC11_FRAME_UPDATE_PENDING_MASK                               0x08000000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC12_FRAME_UPDATE_PENDING_MASK                               0x10000000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC13_FRAME_UPDATE_PENDING_MASK                               0x20000000L
+#define VPG2_VPG_GSP_FRAME_UPDATE_CTRL__VPG_GENERIC14_FRAME_UPDATE_PENDING_MASK                               0x40000000L
+//VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE__SHIFT                              0x0
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE__SHIFT                              0x1
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE__SHIFT                              0x2
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE__SHIFT                              0x3
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE__SHIFT                              0x4
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE__SHIFT                              0x5
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE__SHIFT                              0x6
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE__SHIFT                              0x7
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE__SHIFT                              0x8
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE__SHIFT                              0x9
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE__SHIFT                             0xa
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE__SHIFT                             0xb
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE__SHIFT                             0xc
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE__SHIFT                             0xd
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE__SHIFT                             0xe
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x10
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x11
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x12
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x13
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x14
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x15
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x16
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x17
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x18
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE_PENDING__SHIFT                      0x19
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1a
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1b
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1c
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1d
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE_PENDING__SHIFT                     0x1e
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE_MASK                                0x00000001L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE_MASK                                0x00000002L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE_MASK                                0x00000004L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE_MASK                                0x00000008L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE_MASK                                0x00000010L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE_MASK                                0x00000020L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE_MASK                                0x00000040L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE_MASK                                0x00000080L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE_MASK                                0x00000100L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE_MASK                                0x00000200L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE_MASK                               0x00000400L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE_MASK                               0x00000800L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE_MASK                               0x00001000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE_MASK                               0x00002000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE_MASK                               0x00004000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC0_IMMEDIATE_UPDATE_PENDING_MASK                        0x00010000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC1_IMMEDIATE_UPDATE_PENDING_MASK                        0x00020000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC2_IMMEDIATE_UPDATE_PENDING_MASK                        0x00040000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC3_IMMEDIATE_UPDATE_PENDING_MASK                        0x00080000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC4_IMMEDIATE_UPDATE_PENDING_MASK                        0x00100000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC5_IMMEDIATE_UPDATE_PENDING_MASK                        0x00200000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC6_IMMEDIATE_UPDATE_PENDING_MASK                        0x00400000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC7_IMMEDIATE_UPDATE_PENDING_MASK                        0x00800000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC8_IMMEDIATE_UPDATE_PENDING_MASK                        0x01000000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC9_IMMEDIATE_UPDATE_PENDING_MASK                        0x02000000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC10_IMMEDIATE_UPDATE_PENDING_MASK                       0x04000000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC11_IMMEDIATE_UPDATE_PENDING_MASK                       0x08000000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC12_IMMEDIATE_UPDATE_PENDING_MASK                       0x10000000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC13_IMMEDIATE_UPDATE_PENDING_MASK                       0x20000000L
+#define VPG2_VPG_GSP_IMMEDIATE_UPDATE_CTRL__VPG_GENERIC14_IMMEDIATE_UPDATE_PENDING_MASK                       0x40000000L
+//VPG2_VPG_GENERIC_STATUS
+#define VPG2_VPG_GENERIC_STATUS__VPG_GENERIC_LOCK_STATUS__SHIFT                                               0x0
+#define VPG2_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_OCCURED__SHIFT                                          0x1
+#define VPG2_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_CLR__SHIFT                                              0x4
+#define VPG2_VPG_GENERIC_STATUS__VPG_GENERIC_LOCK_STATUS_MASK                                                 0x00000001L
+#define VPG2_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_OCCURED_MASK                                            0x00000002L
+#define VPG2_VPG_GENERIC_STATUS__VPG_GENERIC_CONFLICT_CLR_MASK                                                0x00000010L
+//VPG2_VPG_MEM_PWR
+#define VPG2_VPG_MEM_PWR__VPG_GSP_MEM_LIGHT_SLEEP_DIS__SHIFT                                                  0x0
+#define VPG2_VPG_MEM_PWR__VPG_GSP_LIGHT_SLEEP_FORCE__SHIFT                                                    0x4
+#define VPG2_VPG_MEM_PWR__VPG_GSP_MEM_PWR_STATE__SHIFT                                                        0x8
+#define VPG2_VPG_MEM_PWR__VPG_GSP_MEM_LIGHT_SLEEP_DIS_MASK                                                    0x00000001L
+#define VPG2_VPG_MEM_PWR__VPG_GSP_LIGHT_SLEEP_FORCE_MASK                                                      0x00000010L
+#define VPG2_VPG_MEM_PWR__VPG_GSP_MEM_PWR_STATE_MASK                                                          0x00000100L
+//VPG2_VPG_ISRC1_2_ACCESS_CTRL
+#define VPG2_VPG_ISRC1_2_ACCESS_CTRL__VPG_ISRC1_2_DATA_INDEX__SHIFT                                           0x0
+#define VPG2_VPG_ISRC1_2_ACCESS_CTRL__VPG_ISRC1_2_DATA_INDEX_MASK                                             0x0000000FL
+//VPG2_VPG_ISRC1_2_DATA
+#define VPG2_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE0__SHIFT                                                     0x0
+#define VPG2_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE1__SHIFT                                                     0x8
+#define VPG2_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE2__SHIFT                                                     0x10
+#define VPG2_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE3__SHIFT                                                     0x18
+#define VPG2_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE0_MASK                                                       0x000000FFL
+#define VPG2_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE1_MASK                                                       0x0000FF00L
+#define VPG2_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE2_MASK                                                       0x00FF0000L
+#define VPG2_VPG_ISRC1_2_DATA__VPG_ISRC_DATA_BYTE3_MASK                                                       0xFF000000L
+//VPG2_VPG_MPEG_INFO0
+#define VPG2_VPG_MPEG_INFO0__VPG_MPEG_INFO_CHECKSUM__SHIFT                                                    0x0
+#define VPG2_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB0__SHIFT                                                         0x8
+#define VPG2_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB1__SHIFT                                                         0x10
+#define VPG2_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB2__SHIFT                                                         0x18
+#define VPG2_VPG_MPEG_INFO0__VPG_MPEG_INFO_CHECKSUM_MASK                                                      0x000000FFL
+#define VPG2_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB0_MASK                                                           0x0000FF00L
+#define VPG2_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB1_MASK                                                           0x00FF0000L
+#define VPG2_VPG_MPEG_INFO0__VPG_MPEG_INFO_MB2_MASK                                                           0xFF000000L
+//VPG2_VPG_MPEG_INFO1
+#define VPG2_VPG_MPEG_INFO1__VPG_MPEG_INFO_MB3__SHIFT                                                         0x0
+#define VPG2_VPG_MPEG_INFO1__VPG_MPEG_INFO_MF__SHIFT                                                          0x8
+#define VPG2_VPG_MPEG_INFO1__VPG_MPEG_INFO_FR__SHIFT                                                          0xc
+#define VPG2_VPG_MPEG_INFO1__VPG_MPEG_INFO_UPDATE__SHIFT                                                      0x10
+#define VPG2_VPG_MPEG_INFO1__VPG_MPEG_INFO_MB3_MASK                                                           0x000000FFL
+#define VPG2_VPG_MPEG_INFO1__VPG_MPEG_INFO_MF_MASK                                                            0x00000300L
+#define VPG2_VPG_MPEG_INFO1__VPG_MPEG_INFO_FR_MASK                                                            0x00001000L
+#define VPG2_VPG_MPEG_INFO1__VPG_MPEG_INFO_UPDATE_MASK                                                        0x00010000L
+
+
+// addressBlock: dce_dc_hpo_hdmi_stream_enc0_dme_dme_dispdec
+//DME2_DME_CONTROL
+#define DME2_DME_CONTROL__METADATA_HUBP_REQUESTOR_ID__SHIFT                                                   0x0
+#define DME2_DME_CONTROL__METADATA_ENGINE_EN__SHIFT                                                           0x4
+#define DME2_DME_CONTROL__METADATA_STREAM_TYPE__SHIFT                                                         0x8
+#define DME2_DME_CONTROL__METADATA_DB_PENDING__SHIFT                                                          0xc
+#define DME2_DME_CONTROL__METADATA_DB_TAKEN__SHIFT                                                            0xd
+#define DME2_DME_CONTROL__METADATA_DB_TAKEN_CLR__SHIFT                                                        0x10
+#define DME2_DME_CONTROL__METADATA_DB_DISABLE__SHIFT                                                          0x14
+#define DME2_DME_CONTROL__METADATA_HUBP_REQUESTOR_ID_MASK                                                     0x00000007L
+#define DME2_DME_CONTROL__METADATA_ENGINE_EN_MASK                                                             0x00000010L
+#define DME2_DME_CONTROL__METADATA_STREAM_TYPE_MASK                                                           0x00000100L
+#define DME2_DME_CONTROL__METADATA_DB_PENDING_MASK                                                            0x00001000L
+#define DME2_DME_CONTROL__METADATA_DB_TAKEN_MASK                                                              0x00002000L
+#define DME2_DME_CONTROL__METADATA_DB_TAKEN_CLR_MASK                                                          0x00010000L
+#define DME2_DME_CONTROL__METADATA_DB_DISABLE_MASK                                                            0x00100000L
+//DME2_DME_MEMORY_CONTROL
+#define DME2_DME_MEMORY_CONTROL__DME_MEM_PWR_FORCE__SHIFT                                                     0x0
+#define DME2_DME_MEMORY_CONTROL__DME_MEM_PWR_DIS__SHIFT                                                       0x4
+#define DME2_DME_MEMORY_CONTROL__DME_MEM_PWR_STATE__SHIFT                                                     0x8
+#define DME2_DME_MEMORY_CONTROL__DME_MEM_DEFAULT_MEM_LOW_POWER_STATE__SHIFT                                   0xc
+#define DME2_DME_MEMORY_CONTROL__DME_MEM_PWR_FORCE_MASK                                                       0x00000003L
+#define DME2_DME_MEMORY_CONTROL__DME_MEM_PWR_DIS_MASK                                                         0x00000010L
+#define DME2_DME_MEMORY_CONTROL__DME_MEM_PWR_STATE_MASK                                                       0x00000300L
+#define DME2_DME_MEMORY_CONTROL__DME_MEM_DEFAULT_MEM_LOW_POWER_STATE_MASK                                     0x00003000L
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
 
 // addressBlock: dce_dc_hpo_hpo_top_dispdec
 //HPO_TOP_CLOCK_CONTROL
-- 
2.54.0

