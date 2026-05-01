Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76EFCD3424
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 14:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B2F110F543;
	Fri,  1 May 2026 14:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZohLWm62";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A48F10F543
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 14:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmQCbnbWKxS5wIaw+pfEXlqcvI2Bt8t2jtFGzwGnNaILgTppu1FR6D7GkUgwWIrxTJCf4vJPLnyPo39jMwxL5ohE61NDzlcHdzRITN24jQ3bjflupnVEc1SnvgBZl9TCzm7vOYoAtFktuJSf7nE3btz7NpT9SjFU0I/xW1XQEoE/lXImvCmasZhf6Gp8Wg10fu2tlVWFYgjnFowJNkKuUxN1NpYMf6GoceMnZdScGVl8MoSqXyE7k9d6QvtWGrSwsC8X4VPbyzZmVzUYiBdcz/gBOq/rdM6Xdbl3NHcX3ZnO4MRMA3z8zPrYoTCl72JCN+N+AiqcB1qkMs4KZ9tykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qQ5ZXEgTzGfxN4rLNhIv9WXzz5XcxhVvzs3K1BFtmc=;
 b=RPljSVkpzgWkyxPTfh2t29J46F4pehV+8vmYvvsmUfB23eQh7IlY6F4aflyq5sD+qis2hyogFKzVBqExwNm8JhiZm4vF7VNEjC+sRpoI8FoND3dvcSpj37NJo4RES07jekMeg0bIOKxQivmzGPFfgEQE6YYssBEqOI11tmTpre0Zv2SDekvXBE+XFUyN+r1wbxkq7xAvrsc50S0B++azJceXZKvBwC+D7xb7rJ0+HZ90avljM/78gB8DN0Rd1FjeBFEJb/Kb8WgC+MtlBwqsBN7tj9sc/wZPC5BC93Pi4ogE6+KysS9UmmgP86p4SFTIdXDEtUMA94lDK1b135MObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qQ5ZXEgTzGfxN4rLNhIv9WXzz5XcxhVvzs3K1BFtmc=;
 b=ZohLWm62Y76Ot2xwj3ILoavUJqmHBncIpTwvfodNYqVqehPeXRiH1CkAMPcqS4eoAWMOI3FpJpnVZIqN3Qpftx8eSO7DbMYeg93RFZ5pkK8B6VC51LFferdULWnVa7YLXWYn8OLALDbEvOloucsNVEnQDmp2Z5FsSsgworVdFMQ=
Received: from CH0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:610:e6::9)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 14:05:01 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::11) by CH0PR03CA0274.outlook.office365.com
 (2603:10b6:610:e6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Fri,
 1 May 2026 14:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 14:05:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 1 May
 2026 09:04:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 1 May
 2026 07:04:52 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 1 May 2026 09:04:52 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 05/21] drm/amd/display: Introduce FRL registers for DCN32
Date: Fri, 1 May 2026 10:04:21 -0400
Message-ID: <20260501140441.41068-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501140441.41068-1-harry.wentland@amd.com>
References: <20260501140441.41068-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 569577a0-4632-40fa-b0c6-08dea78aa285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dW1ryPoTloBaUEF9wE4Pv+pHjzs8zbcClT7oaGrEM/KPbr8VGqKWd25lzeNDXr7AMY0Rn58f1cTuvsqg1fKAiaC/m2UnQAGoTUKHZeca8GdgUQdQ/iBl1Gx7iQo+BAtEXaqrvt2SF/eg2KLaw+eykgHwe9SlMtjpzzvWsjnHdv3eZ8g/0rVA8dxSm2xnFtU7MF6AWFhq54U8N2WhP2YrnkmSK+I5i839xY14cshdE897HgACUryw/G+YjisxPLE5KqMmPbHc8bU/7cSclzjOhW1W9WfihTd/YLrOYawWQLY0oHj/pUyNQNAO0K6+qXpcTPO3BSZk6k9QHAI3DfAD5qrgsxtLjtnMf0Knl43cUTBQpWcM9XEYZQAmHVFt/M5oT1T2EoXpEgYx8bfJz0Me3hK/3ItyJSJO39de3K5kRFOUK4AnncWg/3wenVNqNPnYv4LLrLafESb+21Zawm7jnrf6M6Pa24xODq7Li7X+0ZNSLRiZyCDwHkqEqCVwuDEUdA+jWl3gPQuqqpVRBTh01V0LUXcX/3sE/O8hb2cGKUVHpjQZRvBZzyOAcmExPvaKt4uNzSeLgCU9+cXpgltH46pZpREm550Fj1HzRQ2ytBReoi0GwfHqDXB82L6fsJ9wbLTlR4YhKyFln8SoQqF01DlL2PqU4LcVg0H3cnlrJSa8r2JkUgf8bqqgseQz1P9gtyeRgMznobwV+8qkiPL1bpXM2X/lnQjBfqehlnX7pZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tsyOi2kvbpMxHw2ece2eUY+xREjcLnKsksMN/9C7ekuwtlhtoIAJIyVp7+SBr1W1K8nFtnoYAfwTy3GqNLPhn2neBYJBzusHiNH5PDyYBZ8TWl8glfuir+HFLSsM5Zpu9SjYRqkHiUDMdOBQJLmmZ+U5+I70rDcOFUJV4Cx4UB4lUYiNkR9l+1FbTHF2qgJ/ZmLh6pj2BvhumKQXYqDVdfwjwqAXV0UEFXQCYB7VhiTDEqSj71YPvk4cLYm6NmJ1QORQPg4rErlOrZ4iA/KWVCWm8bRm9f1FGXi2BjDFvLhb49bIIZDBcnZffJzlMTKp2O7leLbWHqxNoIyQfmJxyBsf4NJ1I6EvIlGrLXAL4bEJ5Qx3vRHuCfk2ZSpfWIsfGlKTTtCGVEJzJDn2eaPgKYxl+t5XR8EF5PNjMxy81GlcEULDNcdLl7GEAR9FulZC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 14:05:00.6562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569577a0-4632-40fa-b0c6-08dea78aa285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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

This commit add the basic set of FRL registers associated with DCN32.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../include/asic_reg/dcn/dcn_3_2_0_offset.h   | 109 ++++
 .../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h  | 544 ++++++++++++++++++
 2 files changed, 653 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
index 78cb61d5800a..bc4524f9b462 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
@@ -12201,6 +12201,38 @@
 #define regDP_STREAM_MAPPER_CONTROL3                                                                    0x0e59
 #define regDP_STREAM_MAPPER_CONTROL3_BASE_IDX                                                           3
 
+// addressBlock: dcn_dc_hpo_hdmi_link_enc0_dispdec
+// base address: 0x2656c
+#define regHDMI_LINK_ENC_CONTROL                                                                        0x095b
+#define regHDMI_LINK_ENC_CONTROL_BASE_IDX                                                               3
+#define regHDMI_LINK_ENC_CLK_CTRL                                                                       0x095c
+#define regHDMI_LINK_ENC_CLK_CTRL_BASE_IDX                                                              3
+
+
+// addressBlock: dcn_dc_hpo_hdmi_frl_enc0_dispdec
+// base address: 0x26594
+#define regHDMI_FRL_ENC_CONFIG                                                                          0x0965
+#define regHDMI_FRL_ENC_CONFIG_BASE_IDX                                                                 3
+#define regHDMI_FRL_ENC_CONFIG2                                                                         0x0966
+#define regHDMI_FRL_ENC_CONFIG2_BASE_IDX                                                                3
+#define regHDMI_FRL_ENC_METER_BUFFER_STATUS                                                             0x0967
+#define regHDMI_FRL_ENC_METER_BUFFER_STATUS_BASE_IDX                                                    3
+#define regHDMI_FRL_ENC_MEM_CTRL                                                                        0x0968
+#define regHDMI_FRL_ENC_MEM_CTRL_BASE_IDX                                                               3
+
+
+// addressBlock: dcn_dc_hpo_hdmi_stream_enc0_dispdec
+// base address: 0x2634c
+#define regHDMI_STREAM_ENC_CLOCK_CONTROL                                                                0x08d3
+#define regHDMI_STREAM_ENC_CLOCK_CONTROL_BASE_IDX                                                       3
+#define regHDMI_STREAM_ENC_INPUT_MUX_CONTROL                                                            0x08d5
+#define regHDMI_STREAM_ENC_INPUT_MUX_CONTROL_BASE_IDX                                                   3
+#define regHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0                                     0x08d6
+#define regHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0_BASE_IDX                            3
+#define regHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1                                     0x08d7
+#define regHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL1_BASE_IDX                            3
+#define regHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2                                     0x08d8
+#define regHDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL2_BASE_IDX                            3
 
 // addressBlock: dcn_dc_hpo_hdmi_stream_enc0_afmt_afmt_dispdec
 // base address: 0x2646c
@@ -12275,6 +12307,83 @@
 #define regVPG5_VPG_MPEG_INFO1                                                                          0x093a
 #define regVPG5_VPG_MPEG_INFO1_BASE_IDX                                                                 3
 
+// addressBlock: dcn_dc_hpo_hdmi_tb_enc0_dispdec
+// base address: 0x2637c
+#define regHDMI_TB_ENC_CONTROL                                                                          0x08df
+#define regHDMI_TB_ENC_CONTROL_BASE_IDX                                                                 3
+#define regHDMI_TB_ENC_PIXEL_FORMAT                                                                     0x08e0
+#define regHDMI_TB_ENC_PIXEL_FORMAT_BASE_IDX                                                            3
+#define regHDMI_TB_ENC_PACKET_CONTROL                                                                   0x08e1
+#define regHDMI_TB_ENC_PACKET_CONTROL_BASE_IDX                                                          3
+#define regHDMI_TB_ENC_ACR_PACKET_CONTROL                                                               0x08e2
+#define regHDMI_TB_ENC_ACR_PACKET_CONTROL_BASE_IDX                                                      3
+#define regHDMI_TB_ENC_VBI_PACKET_CONTROL1                                                              0x08e3
+#define regHDMI_TB_ENC_VBI_PACKET_CONTROL1_BASE_IDX                                                     3
+#define regHDMI_TB_ENC_VBI_PACKET_CONTROL2                                                              0x08e4
+#define regHDMI_TB_ENC_VBI_PACKET_CONTROL2_BASE_IDX                                                     3
+#define regHDMI_TB_ENC_GC_CONTROL                                                                       0x08e5
+#define regHDMI_TB_ENC_GC_CONTROL_BASE_IDX                                                              3
+#define regHDMI_TB_ENC_GENERIC_PACKET_CONTROL0                                                          0x08e6
+#define regHDMI_TB_ENC_GENERIC_PACKET_CONTROL0_BASE_IDX                                                 3
+#define regHDMI_TB_ENC_GENERIC_PACKET_CONTROL1                                                          0x08e7
+#define regHDMI_TB_ENC_GENERIC_PACKET_CONTROL1_BASE_IDX                                                 3
+#define regHDMI_TB_ENC_GENERIC_PACKET_CONTROL2                                                          0x08e8
+#define regHDMI_TB_ENC_GENERIC_PACKET_CONTROL2_BASE_IDX                                                 3
+#define regHDMI_TB_ENC_GENERIC_PACKET0_1_LINE                                                           0x08e9
+#define regHDMI_TB_ENC_GENERIC_PACKET0_1_LINE_BASE_IDX                                                  3
+#define regHDMI_TB_ENC_GENERIC_PACKET2_3_LINE                                                           0x08ea
+#define regHDMI_TB_ENC_GENERIC_PACKET2_3_LINE_BASE_IDX                                                  3
+#define regHDMI_TB_ENC_GENERIC_PACKET4_5_LINE                                                           0x08eb
+#define regHDMI_TB_ENC_GENERIC_PACKET4_5_LINE_BASE_IDX                                                  3
+#define regHDMI_TB_ENC_GENERIC_PACKET6_7_LINE                                                           0x08ec
+#define regHDMI_TB_ENC_GENERIC_PACKET6_7_LINE_BASE_IDX                                                  3
+#define regHDMI_TB_ENC_GENERIC_PACKET8_9_LINE                                                           0x08ed
+#define regHDMI_TB_ENC_GENERIC_PACKET8_9_LINE_BASE_IDX                                                  3
+#define regHDMI_TB_ENC_GENERIC_PACKET10_11_LINE                                                         0x08ee
+#define regHDMI_TB_ENC_GENERIC_PACKET10_11_LINE_BASE_IDX                                                3
+#define regHDMI_TB_ENC_GENERIC_PACKET12_13_LINE                                                         0x08ef
+#define regHDMI_TB_ENC_GENERIC_PACKET12_13_LINE_BASE_IDX                                                3
+#define regHDMI_TB_ENC_GENERIC_PACKET14_LINE                                                            0x08f0
+#define regHDMI_TB_ENC_GENERIC_PACKET14_LINE_BASE_IDX                                                   3
+#define regHDMI_TB_ENC_DB_CONTROL                                                                       0x08f1
+#define regHDMI_TB_ENC_DB_CONTROL_BASE_IDX                                                              3
+#define regHDMI_TB_ENC_ACR_32_0                                                                         0x08f2
+#define regHDMI_TB_ENC_ACR_32_0_BASE_IDX                                                                3
+#define regHDMI_TB_ENC_ACR_32_1                                                                         0x08f3
+#define regHDMI_TB_ENC_ACR_32_1_BASE_IDX                                                                3
+#define regHDMI_TB_ENC_ACR_44_0                                                                         0x08f4
+#define regHDMI_TB_ENC_ACR_44_0_BASE_IDX                                                                3
+#define regHDMI_TB_ENC_ACR_44_1                                                                         0x08f5
+#define regHDMI_TB_ENC_ACR_44_1_BASE_IDX                                                                3
+#define regHDMI_TB_ENC_ACR_48_0                                                                         0x08f6
+#define regHDMI_TB_ENC_ACR_48_0_BASE_IDX                                                                3
+#define regHDMI_TB_ENC_ACR_48_1                                                                         0x08f7
+#define regHDMI_TB_ENC_ACR_48_1_BASE_IDX                                                                3
+#define regHDMI_TB_ENC_ACR_STATUS_0                                                                     0x08f8
+#define regHDMI_TB_ENC_ACR_STATUS_0_BASE_IDX                                                            3
+#define regHDMI_TB_ENC_ACR_STATUS_1                                                                     0x08f9
+#define regHDMI_TB_ENC_ACR_STATUS_1_BASE_IDX                                                            3
+#define regHDMI_TB_ENC_BUFFER_CONTROL                                                                   0x08fb
+#define regHDMI_TB_ENC_BUFFER_CONTROL_BASE_IDX                                                          3
+#define regHDMI_TB_ENC_MEM_CTRL                                                                         0x08fe
+#define regHDMI_TB_ENC_MEM_CTRL_BASE_IDX                                                                3
+#define regHDMI_TB_ENC_METADATA_PACKET_CONTROL                                                          0x08ff
+#define regHDMI_TB_ENC_METADATA_PACKET_CONTROL_BASE_IDX                                                 3
+#define regHDMI_TB_ENC_H_ACTIVE_BLANK                                                                   0x0900
+#define regHDMI_TB_ENC_H_ACTIVE_BLANK_BASE_IDX                                                          3
+#define regHDMI_TB_ENC_HC_ACTIVE_BLANK                                                                  0x0901
+#define regHDMI_TB_ENC_HC_ACTIVE_BLANK_BASE_IDX                                                         3
+#define regHDMI_TB_ENC_CRC_CNTL                                                                         0x0903
+#define regHDMI_TB_ENC_CRC_CNTL_BASE_IDX                                                                3
+#define regHDMI_TB_ENC_CRC_RESULT_0                                                                     0x0904
+#define regHDMI_TB_ENC_CRC_RESULT_0_BASE_IDX                                                            3
+#define regHDMI_TB_ENC_MODE                                                                             0x0908
+#define regHDMI_TB_ENC_MODE_BASE_IDX                                                                    3
+#define regHDMI_TB_ENC_INPUT_FIFO_STATUS                                                                0x0909
+#define regHDMI_TB_ENC_INPUT_FIFO_STATUS_BASE_IDX                                                       3
+#define regHDMI_TB_ENC_CRC_RESULT_1                                                                     0x090a
+#define regHDMI_TB_ENC_CRC_RESULT_1_BASE_IDX                                                            3
+
 
 // addressBlock: dcn_dc_hpo_dp_stream_enc0_dispdec
 // base address: 0x1ab8c
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
index c20bf730dc55..a89fe19c4c84 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
@@ -43567,6 +43567,124 @@
 #define DP_STREAM_MAPPER_CONTROL3__DP_STREAM_LINK_TARGET__SHIFT                                               0x0
 #define DP_STREAM_MAPPER_CONTROL3__DP_STREAM_LINK_TARGET_MASK                                                 0x00000007L
 
+// addressBlock: dcn_dc_hpo_hdmi_link_enc0_dispdec
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
+// addressBlock: dcn_dc_hpo_hdmi_frl_enc0_dispdec
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
+// addressBlock: dcn_dc_hpo_hdmi_stream_enc0_dispdec
+//HDMI_STREAM_ENC_CLOCK_CONTROL
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_EN__SHIFT                                        0x0
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_DISPCLK__SHIFT                                0x4
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_SOCCLK__SHIFT                                 0x8
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_HDMISTREAMCLK__SHIFT                          0xc
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_EN_MASK                                          0x00000001L
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_DISPCLK_MASK                                  0x00000010L
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_SOCCLK_MASK                                   0x00000100L
+#define HDMI_STREAM_ENC_CLOCK_CONTROL__HDMI_STREAM_ENC_CLOCK_ON_HDMISTREAMCLK_MASK                            0x00001000L
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
 
 // addressBlock: dcn_dc_hpo_hdmi_stream_enc0_afmt_afmt_dispdec
 //AFMT5_AFMT_VBI_PACKET_CONTROL
@@ -43943,6 +44061,432 @@
 #define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_FR_MASK                                                            0x00001000L
 #define VPG5_VPG_MPEG_INFO1__VPG_MPEG_INFO_UPDATE_MASK                                                        0x00010000L
 
+// addressBlock: dcn_dc_hpo_hdmi_tb_enc0_dispdec
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
 
 // addressBlock: dcn_dc_hpo_dp_stream_enc0_dispdec
 //DP_STREAM_ENC0_DP_STREAM_ENC_CLOCK_CONTROL
-- 
2.54.0

