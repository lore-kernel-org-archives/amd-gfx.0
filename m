Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88BBCD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ACD110E514;
	Tue, 26 May 2026 07:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ttXfutyK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B73D10E514
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpoDnqPJcSeG1TbuUhQyI0OvDM5GMxhZ7bXZUBfDwqn+1Ft/QtVAEpkkZRfOa0xm5zg0Jsc6aKHR0RD6aljiwqkynmYbkGuvrvH9kpteQy2SVGaBfdHHq8TK0qNiqZM43m50MkvSIp9hhEhdUWN0cp15crBZnhdwemyYlU4P3WFe8i745bnBMxXI1XU7DBkRhluLOEkHTAr4y2C3H0q0/bu4btHXJzjGtkkj2LMlBNH5ybG0d7j9EO+F7+uTSQHPFBSU2bgEpe6BroE2OovdFkLJS4EPe5wfKXWTxFGKGyHB+m8oHiLCgsORTNkH3GgOdazEhoP2gL0MBWWkMxNIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8LBxxwmZz9gmSm1M/zyW69umTUTh0HyrbCf1v5qF6M=;
 b=IHPoIkIRNXrC/VaKNmvrCvPye0A5Yw+ljvUQWMVIw/ewiWMzvR6EtlT6R8NPaabQ6RcvClYvZHIpZmw/rpg5UZBbPskluUXEfTpucvZ+tDxG7AZVWGJnsosPyJ4J/DMeIkoGbnJFx0hNf7PWJN0wATHRq+ZM8ped4f5AfDkFLJBENBoQCx58TWJqHqqDlsi4IsFZUVtifMLflPkh5Bk8AiIdD1jO4PHpi06tSxF0KLYfJFjpFNxfRg4oWizu47I/XnpTUkwnfqqHs43dSFnR9f4meDUD7XZ5jiSUjV3D/3N/eNkJKI5qzluKfs+fonub28tIxwYGC/T8xTQhatF99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8LBxxwmZz9gmSm1M/zyW69umTUTh0HyrbCf1v5qF6M=;
 b=ttXfutyKgTu7prfgGeAFJhYS27oWk8dX47b03BlqmqP1aY9+6VlGbgaCypGW4pHYSXaxQxvRL3jdiaH0ZRC2DLMVic3i03p/lhTY8HA4tMI0AEjv5WURxVETrpGpk2DvgfN6UnDYXp8AHHaqX2/9h1dpoMnfvgxRQGl13FMr7sQ=
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:20:49 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::af) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:20:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:20:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:20:47 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:20:38 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 40/41] ddrm/amd/display: [FW Promotion] Release 0.1.61.0
Date: Tue, 26 May 2026 15:02:03 +0800
Message-ID: <20260526071413.2181251-41-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 3164e294-f18c-4333-212c-08debaf74fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: XmwhkVKzPe27ICVFiPOU/JFjHEokEMirhGTyzokyWca5v8wvUGN+Vm+UBmOZ1csXnYvKwkPzLbfIsJ7q5KUz2c3FVSfGv3p/iNGlVzV/TRw5IyS0b6HdTQGOQX/rDt2VkeNUrD6H4rBYs+eK5vZARJinlAI4FLO+d40sH4Qzkn8+4EovjNQ8zrBg5aHP0V6pvJyvC3l2cpHxnK2FJjV8ZldftUKMhh6LSWIKsgUaezI/wo1qm//Xyc4M+QyEsk8rvHET0qSoaTri+931vbyi5C15o+BsHh5An9iGcpPvt4deavPe1ukPDrMbqHU1qqGOrrek6J/eKBeb+YFXGrWrNDCsLDPyFpbe/RiFUHuaE3/P9Zzpo/WLfJOuhAO9BLDPiSr/3OnS0pNna11lOncWBnt6VeQz8gEGXOBEeHgUcRyBvc74ZpKBQmS16rJK8n7zf6HqPInfwM85pbUeoqFvFWgZP6T4AT5MbzV9UVuc6u+k+H3FCIAoCQwk345mQHbZ9WBh+a0hbdmD9VfNe0tzoFuucDfz6/aQX0DAPNvZmT4oZg55LgDtYuisZads+OnjPgxOpD/CIdSE7OOR1FIHaOx2ocL9Csc2RkGcFMLErxGWR24nby3VRdM8kdA/3LcEtpTbCTf9cmv8Q4uYhnmbEey3VgweyaWdTOTQyX835GNcNJ3nDhFpE9rPV9tCZnE8zZW3pEfEsobxdAsiXCj5XqFoKCGxiTkySlhDE43mhgU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r4RF+Z0KtdT9MG5A9CmaeSjXxmhbovdXd9iAmt0RRajbty/p3bHz9pRVquTCjhnWHBUdBlKUMLm8irtS+xP8jP8J06hTWA0QW/tfAXQoa0moCTVkA5XiivTwMvvQ7hKY1cDXGj7Otl+HRZuXbP9DIeSofjxjGb5VoQiv+Fck3PgcCJTfXrhcQv4T3fU3LTYVxFzeNqBMSRLFlhH+TKMFhlVNQ8AgK/FdQKIRIzTqtxi/lqyffsZorWg01pf2nPyoCKALIDmjc5CcGOGFlUYTEFBfAtwp+NFeetbxIRtM+9J1CvoIlD5n79ZiAH+dU3yz3FJ2x9bnRbjSpFTbDZpwktXavsIHNMqnUKOiJanpjHG63lJetvshf2U2gesKWtCdMIhIL+BF2BI4dpj9noPS8Td5T5KLHsRFCs22x96qqBY2ZqLIKwN2u8yYjGO8+kdX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:20:48.7830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3164e294-f18c-4333-212c-08debaf74fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
Update DMUB related command structure.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 606 ++++++++++++++++--
 1 file changed, 561 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 2f68438000ea..6f0c4b602f89 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1,3 +1,12 @@
+/*
+ * Note: This header is the authoritative source for the DMUB firmware
+ * command interface. In the Linux kernel, it is maintained as an
+ * auto-generated copy from an AMD internal repository.
+ *
+ * This file follows Doxygen formatting for firmware standards and
+ * is NOT intended to be kernel-doc compliant.
+ */
+
 /*
  * Copyright 2019 Advanced Micro Devices, Inc.
  *
@@ -94,6 +103,35 @@
  */
 #define ABM_MAX_NUM_OF_HG_BINS              64
 
+/**
+ * Flag from driver to indicate that CACP should be disabled gradually
+ * by slowly reversing all programming and pixel compensation.
+ */
+#define SET_CACP_PIPE_GRADUALLY_DISABLE           0
+
+/**
+ * Flag from driver to indicate that CACP should be disabled immediately
+ * and undo all programming and pixel compensation.
+ */
+#define SET_CACP_PIPE_IMMEDIATELY_DISABLE         255
+
+/**
+ * Flag from driver to indicate that CACP should be disabled immediately
+ * and keep the current programming and pixel compensation.
+ */
+#define SET_CACP_PIPE_IMMEDIATE_KEEP_GAIN_DISABLE 254
+
+/**
+ * Flag from driver to indicate that CACP should be disabled immediately
+ * on the next abm vertical interrupt
+ */
+#define SET_CACP_PIPE_IMMEDIATE_ON_NEXT_DISABLE 253
+
+/**
+ * Flag from driver to set the current CACP pipe index or CACP operating level.
+ */
+#define SET_CACP_PIPE_NORMAL                      1
+
 /* Maximum number of SubVP streams */
 #define DMUB_MAX_SUBVP_STREAMS 2
 
@@ -177,6 +215,26 @@
  */
 #define DMUB_CMD_ABM_CONTROL_VERSION_1 0x1
 
+/**
+ * CACP control version legacy
+ */
+#define DMUB_CMD_CACP_CONTROL_VERSION_UNKNOWN 0x0
+
+/**
+ * CACP control version with multi edp support
+ */
+#define DMUB_CMD_CACP_CONTROL_VERSION_1 0x1
+
+/**
+ * CACP control mode with dynamic switch between v1 and v2
+ */
+#define DMUB_CMD_CACP_CONTROL_MODE_0 0x0
+
+/**
+ * CACP control version with forced configure to v1 on new ABM HW
+ */
+#define DMUB_CMD_CACP_CONTROL_MODE_1 0x1
+
 /**
  * Physical framebuffer address location, 64-bit.
  */
@@ -329,7 +387,7 @@ union dmub_addr {
 
 /* Flattened structure containing SOC BB parameters stored in the VBIOS
  * It is not practical to store the entire bounding box in VBIOS since the bounding box struct can gain new parameters.
- * This also prevents alignment issues when new parameters are added to the SoC BB.
+ * This also prevents alighment issues when new parameters are added to the SoC BB.
  * The following parameters should be added since these values can't be obtained elsewhere:
  * -dml2_soc_power_management_parameters
  * -dml2_soc_vmin_clock_limits
@@ -958,7 +1016,7 @@ union dmub_fw_meta {
 //==============================================================================
 #if !defined(TENSILICA) && !defined(DMUB_TRACE_ENTRY_DEFINED)
 /**
- * typedef dmub_trace_code_t - firmware trace code, 32-bits
+ * dmub_trace_code_t - firmware trace code, 32-bits
  */
 typedef uint32_t dmub_trace_code_t;
 
@@ -1170,7 +1228,7 @@ enum dmub_shared_state_feature_id {
 };
 
 /**
- * struct dmub_shared_state_ips_fw_signals - Firmware signals for IPS.
+ * struct dmub_shared_state_ips_fw - Firmware signals for IPS.
  */
 union dmub_shared_state_ips_fw_signals {
 	struct {
@@ -1185,7 +1243,7 @@ union dmub_shared_state_ips_fw_signals {
 };
 
 /**
- * struct dmub_shared_state_ips_driver_signals - Firmware signals for IPS.
+ * struct dmub_shared_state_ips_signals - Firmware signals for IPS.
  */
 union dmub_shared_state_ips_driver_signals {
 	struct {
@@ -1247,7 +1305,7 @@ struct dmub_shared_state_ips_driver {
 }; /* 248-bytes, fixed */
 
 /**
- * struct dmub_shared_state_cursor_offload_stream_v1 - Header metadata for cursor offload.
+ * struct dmub_shared_state_cursor_offload_v1 - Header metadata for cursor offload.
  */
 struct dmub_shared_state_cursor_offload_stream_v1 {
 	uint32_t last_write_idx; /**< Last write index */
@@ -1263,14 +1321,14 @@ struct dmub_shared_state_cursor_offload_v1 {
 }; /* 248-bytes, fixed */
 
 /**
- * struct dmub_shared_state_feature_common - Generic payload.
+ * enum dmub_shared_state_feature_common - Generic payload.
  */
 struct dmub_shared_state_feature_common {
 	uint32_t padding[62];
 }; /* 248-bytes, fixed */
 
 /**
- * struct dmub_shared_state_feature_header - Feature description.
+ * enum dmub_shared_state_feature_header - Feature description.
  */
 struct dmub_shared_state_feature_header {
 	uint16_t id; /**< Feature ID */
@@ -1444,6 +1502,11 @@ enum dmub_gpint_command {
 	 */
 	DMUB_GPINT__REPLAY_RESIDENCY = 14,
 
+	/**
+	 * DESC: Set CACP internal core configuration
+	 */
+	DMUB_GPINT__TRIGGER_CACP = 18,
+
 	/**
 	 * DESC: Copy bounding box to the host.
 	 * ARGS: Version of bounding box to copy
@@ -1858,6 +1921,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__DPIA_HPD_INT_ENABLE = 86,
 
+	/**
+	 * Command type used for all CACP commands.
+	 */
+	DMUB_CMD__CACP = 87,
+
 	/**
 	 * Command type used for all PSP commands.
 	 */
@@ -1996,7 +2064,7 @@ struct dmub_cmd_read_modify_write_sequence {
 #define DMUB_READ_MODIFY_WRITE_SEQ__MAX 5
 
 /**
- * struct dmub_rb_cmd_read_modify_write - Read modify write command.
+ * struct dmub_cmd_read_modify_write_sequence - Read modify write command.
  */
 struct dmub_rb_cmd_read_modify_write {
 	struct dmub_cmd_header header;  /**< command header */
@@ -2007,7 +2075,7 @@ struct dmub_rb_cmd_read_modify_write {
 };
 
 /*
- * Update a register with specified masks and values sequence
+ * Update a register with specified masks and values sequeunce
  *
  * 60 payload bytes can hold address + up to 7 sets of mask/value combo, each take 2 dword
  *
@@ -2382,8 +2450,13 @@ struct dmub_cmd_lsdma_data {
 			uint32_t tmz              : 4;
 			uint32_t cache_policy_src : 3;
 			uint32_t cache_policy_dst : 3;
-			uint32_t pad1             : 22;
-			// DCC fields not included because linear mode on display does not support DCC
+			uint32_t data_format      : 6;
+			uint32_t num_type         : 3;
+			uint32_t read_compress    : 2;
+			uint32_t write_compress   : 2;
+			uint32_t max_com          : 2;
+			uint32_t max_uncom        : 1;
+			uint32_t pad1             : 6;
 		} linear_copy_data;
 		struct lsdma_linear_sub_window_copy_data {
 			uint32_t src_lo;
@@ -2411,9 +2484,13 @@ struct dmub_cmd_lsdma_data {
 			uint32_t element_size     : 3;
 			uint32_t src_cache_policy : 3;
 			uint32_t dst_cache_policy : 3;
-			uint32_t reserved0        : 19;
-			// Linear mode on display does not support compression so DCC related fields are not included.
-			// The DCC fields in the command packet will be zero'd at the time of constructing the packet.
+			uint32_t data_format      : 6;
+			uint32_t num_type         : 3;
+			uint32_t read_compress    : 2;
+			uint32_t write_compress   : 2;
+			uint32_t max_com          : 2;
+			uint32_t max_uncom        : 1;
+			uint32_t reserved0        : 3;
 		} linear_sub_window_copy_data;
 		struct lsdma_reg_write_data {
 			uint32_t reg_addr;
@@ -2877,7 +2954,7 @@ struct dmub_cmd_set_pixel_clock_data {
 };
 
 /**
- * struct dmub_rb_cmd_set_pixel_clock - Set pixel clock command.
+ * struct dmub_cmd_set_pixel_clock_data - Set pixel clock command.
  */
 struct dmub_rb_cmd_set_pixel_clock {
 	struct dmub_cmd_header header; /**< header */
@@ -3393,7 +3470,7 @@ struct dpia_bw_allocation_notify_data {
 };
 
 /**
- * union dpia_notification_data - DPIA Notification in Outbox command
+ * union dpia_notify_data_type - DPIA Notification in Outbox command
  */
 union dpia_notification_data {
 	/**
@@ -3449,7 +3526,7 @@ struct dmub_rb_cmd_query_hpd_state {
 };
 
 /**
- * struct dmub_rb_cmd_hpd_sense_notify_data - HPD sense notification data.
+ * struct dmub_rb_cmd_hpd_sense_notify - HPD sense notification data.
  */
 struct dmub_rb_cmd_hpd_sense_notify_data {
 	uint32_t old_hpd_sense_mask; /**< Old HPD sense mask */
@@ -3493,7 +3570,7 @@ enum dmub_cmd_psr_type {
 
 	/**
 	 * Set PSR level.
-	 * PSR level is a 16-bit value dictated by driver that
+	 * PSR level is a 16-bit value dicated by driver that
 	 * will enable/disable different functionality.
 	 */
 	DMUB_CMD__PSR_SET_LEVEL			= 4,
@@ -3538,6 +3615,7 @@ enum dmub_cmd_fams_type {
 	DMUB_CMD__FAMS2_DRR_UPDATE = 5,
 	DMUB_CMD__FAMS2_FLIP = 6,
 	DMUB_CMD__FAMS2_IB_CONFIG = 7,
+	DMUB_CMD__FAMS2_IB_DEBUG_META = 8,
 };
 
 /**
@@ -3650,7 +3728,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	union dmub_psr_debug_flags debug;
 	/**
-	 * 16-bit value dictated by driver that will enable/disable different functionality.
+	 * 16-bit value dicated by driver that will enable/disable different functionality.
 	 */
 	uint16_t psr_level;
 	/**
@@ -3690,7 +3768,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	uint8_t aux_inst;
 	/**
-	 * Determines if SMU optimizations are enabled/disabled.
+	 * Determines if SMU optimzations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
 	/**
@@ -3807,7 +3885,7 @@ struct dmub_rb_cmd_psr_copy_settings {
  */
 struct dmub_cmd_psr_set_level_data {
 	/**
-	 * 16-bit value dictated by driver that will enable/disable different functionality.
+	 * 16-bit value dicated by driver that will enable/disable different functionality.
 	 */
 	uint16_t psr_level;
 	/**
@@ -4185,7 +4263,7 @@ struct dmub_rb_cmd_update_cursor_info {
  */
 struct dmub_cmd_psr_set_vtotal_data {
 	/**
-	 * 16-bit value dictated by driver that indicates the vtotal in PSR active requirement when screen idle..
+	 * 16-bit value dicated by driver that indicates the vtotal in PSR active requirement when screen idle..
 	 */
 	uint16_t psr_vtotal_idle;
 	/**
@@ -4199,7 +4277,7 @@ struct dmub_cmd_psr_set_vtotal_data {
 	 */
 	uint8_t panel_inst;
 	/*
-	 * 16-bit value dictated by driver that indicates the vtotal in PSR active requirement when doing SU/FFU.
+	 * 16-bit value dicated by driver that indicates the vtotal in PSR active requirement when doing SU/FFU.
 	 */
 	uint16_t psr_vtotal_su;
 	/**
@@ -4423,6 +4501,7 @@ enum dmub_cmd_panel_replay_state_update_subtype {
 	PR_STATE_UPDATE_COASTING_VTOTAL = 0x1,
 	PR_STATE_UPDATE_SYNC_MODE = 0x2,
 	PR_STATE_UPDATE_RUNTIME_FLAGS = 0x3,
+	PR_STATE_UPDATE_PSEUDO_VTOTAL = 0x4,
 };
 
 enum dmub_cmd_panel_replay_general_subtype {
@@ -4499,7 +4578,7 @@ struct dmub_cmd_replay_copy_settings_data {
 	uint8_t aux_inst;
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which psr_state to use
+	 * Panel isntance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4522,7 +4601,7 @@ struct dmub_cmd_replay_copy_settings_data {
 	 */
 	uint8_t dpphy_inst;
 	/**
-	 * Determines if SMU optimizations are enabled/disabled.
+	 * Determines if SMU optimzations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
 	/**
@@ -4612,7 +4691,7 @@ struct dmub_rb_cmd_smart_power_oled_enable_data {
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4651,7 +4730,7 @@ struct dmub_rb_cmd_replay_enable_data {
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4699,7 +4778,7 @@ struct dmub_rb_cmd_replay_enable {
 struct dmub_cmd_replay_set_power_opt_data {
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4719,7 +4798,7 @@ struct dmub_cmd_replay_set_power_opt_data {
 struct dmub_cmd_replay_set_timing_sync_data {
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4739,7 +4818,7 @@ struct dmub_cmd_replay_set_timing_sync_data {
 struct dmub_cmd_replay_set_pseudo_vtotal {
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4755,7 +4834,7 @@ struct dmub_cmd_replay_set_pseudo_vtotal {
 struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data {
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4769,7 +4848,7 @@ struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data {
 struct dmub_cmd_replay_set_general_cmd_data {
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4806,7 +4885,7 @@ struct dmub_rb_cmd_replay_set_power_opt {
  */
 struct dmub_cmd_replay_set_coasting_vtotal_data {
 	/**
-	 * 16-bit value dictated by driver that indicates the coasting vtotal.
+	 * 16-bit value dicated by driver that indicates the coasting vtotal.
 	 */
 	uint16_t coasting_vtotal;
 	/**
@@ -4815,12 +4894,12 @@ struct dmub_cmd_replay_set_coasting_vtotal_data {
 	uint8_t cmd_version;
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
 	/**
-	 * 16-bit value dictated by driver that indicates the coasting vtotal high byte part.
+	 * 16-bit value dicated by driver that indicates the coasting vtotal high byte part.
 	 */
 	uint16_t coasting_vtotal_high;
 	/**
@@ -4923,7 +5002,7 @@ struct dmub_rb_cmd_replay_set_general_cmd {
 struct dmub_cmd_replay_frameupdate_timer_data {
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4956,7 +5035,7 @@ struct dmub_rb_cmd_replay_set_frameupdate_timer {
 union dmub_replay_cmd_set {
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -5132,7 +5211,7 @@ struct dmub_hw_lock_inst_flags {
 	uint8_t opp_inst;
 	/**
 	 * OTG HW instance for global update lock.
-	 * TODO: Remove, and reuse otg_inst.
+	 * TODO: Remove, and re-use otg_inst.
 	 */
 	uint8_t dig_inst;
 	/**
@@ -6063,6 +6142,399 @@ struct dmub_rb_cmd_abm_set_event {
 	struct dmub_cmd_abm_set_event_data abm_set_event_data;
 };
 
+/**
+ * CACP command sub-types.
+ */
+enum dmub_cmd_cacp_type {
+	/**
+	 * Initialize parameters for CACP algorithm.
+	 * Data is passed through an indirect buffer.
+	 */
+	DMUB_CMD__CACP_INIT_CONFIG	= 0,
+	/**
+	 * Set OTG and panel HW instance.
+	 */
+	DMUB_CMD__CACP_SET_PIPE		= 1,
+	/**
+	 * Set CACP operating/aggression level.
+	 */
+	DMUB_CMD__CACP_SET_LEVEL	= 2,
+	/**
+	 * Set event: full-screen/video mode/Hdr mode
+	 */
+	DMUB_CMD__CACP_SET_EVENT	= 3,
+
+	/**
+	 * unregister vertical interrupt after steady state is reached
+	 */
+	DMUB_CMD__CACP_PAUSE	= 4,
+	/**
+	 * Set backlight: only for miniLED
+	 */
+	DMUB_CMD__CACP_SET_BACKLIGHT	= 5,
+	/**
+	 * Enable/disable fractional duty cycle for backlight PWM.
+	 */
+	DMUB_CMD__CACP_SET_PWM_FRAC	= 6,
+	/**
+	 * Get CACP Histogram
+	 */
+	DMUB_CMD__CACP_GET_HISTOGRAM = 7,
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__CACP_SET_PIPE command.
+ */
+struct dmub_cmd_cacp_set_pipe_data {
+	/**
+	 * OTG HW instance.
+	 */
+	uint8_t otg_inst;
+
+	/**
+	 * Panel Control HW instance.
+	 */
+	uint8_t panel_inst;
+
+	/**
+	 * Controls how CACP will interpret a set pipe or set level command.
+	 */
+	uint8_t set_pipe_option;
+
+	/**
+	 * PwrSeq HW Instance.
+	 */
+	uint8_t pwrseq_inst;
+};
+
+/**
+ * Definition of a DMUB_CMD__CACP_SET_PIPE command.
+ */
+struct dmub_rb_cmd_cacp_set_pipe {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__CACP_PIPE command.
+	 */
+	struct dmub_cmd_cacp_set_pipe_data cacp_set_pipe_data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__CACP_SET_LEVEL command.
+ */
+struct dmub_cmd_cacp_set_level_data {
+	/**
+	 * Set current cacp operating/aggression level.
+	 */
+	uint32_t level;
+
+	/**
+	 * CACP control version.
+	 */
+	uint8_t version;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__CACP_SET_LEVEL command.
+ */
+struct dmub_rb_cmd_cacp_set_level {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__CACP_SET_LEVEL command.
+	 */
+	struct dmub_cmd_cacp_set_level_data cacp_set_level_data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__CACP_SET_EVENT command.
+ */
+struct dmub_cmd_cacp_set_event_data {
+	/**
+	 * Full screen mode
+	 */
+	uint8_t full_screen_mode;
+
+	/**
+	 * VariBright Scaling Enable
+	 */
+	uint8_t vb_scaling_enable;
+
+	/**
+	 * HDR mode
+	 */
+	uint8_t hdr_mode;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Transition time info
+	 */
+	uint32_t trans_info;
+};
+
+/**
+ * Definition of a DMUB_CMD__CACP_SET_EVENT command.
+ */
+struct dmub_rb_cmd_cacp_set_event {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__CACP_SET_EVENT command.
+	 */
+	struct dmub_cmd_cacp_set_event_data cacp_set_event_data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__CACP_INIT_CONFIG command.
+ */
+struct dmub_cmd_cacp_init_config_data {
+	/**
+	 * Location of indirect buffer used to pass init data to CACP.
+	 */
+	union dmub_addr src;
+
+	/**
+	 * Indirect buffer length.
+	 */
+	uint16_t bytes;
+
+	/**
+	 * CACP control version.
+	 */
+	uint8_t mode;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * CACP visual_confirm debug
+	 */
+	uint32_t visual_confirm;
+
+	/**
+	 * CACP customized str_scl params
+	 */
+	uint8_t strscl_valid;
+	uint8_t pad[3];
+	uint8_t strscl_sdr[4];
+	uint8_t strscl_hdr[4];
+};
+
+/**
+ * Definition of a DMUB_CMD__CACP_INIT_CONFIG command.
+ */
+struct dmub_rb_cmd_cacp_init_config {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__CACP_INIT_CONFIG command.
+	 */
+	struct dmub_cmd_cacp_init_config_data cacp_init_config_data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__CACP_PAUSE command.
+ */
+
+struct dmub_cmd_cacp_pause_data {
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * OTG hw instance
+	 */
+	uint8_t otg_inst;
+
+	/**
+	 * Enable or disable CACP pause
+	 */
+	uint8_t enable;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad;
+};
+
+/**
+ * Definition of a DMUB_CMD__CACP_PAUSE command.
+ */
+struct dmub_rb_cmd_cacp_pause {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__CACP_PAUSE command.
+	 */
+	struct dmub_cmd_cacp_pause_data cacp_pause_data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__CACP_SET_BACKLIGHT command.
+ */
+struct dmub_cmd_cacp_set_backlight_data {
+	/**
+	 * Number of frames to ramp to backlight user level.
+	 */
+	uint32_t frame_ramp;
+
+	/**
+	 * Requested backlight level from user.
+	 */
+	uint32_t backlight_user_level;
+
+	/**
+	 * ABM control version.
+	 */
+	uint8_t version;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__CACP_SET_BACKLIGHT command.
+ */
+struct dmub_rb_cmd_cacp_set_backlight {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__CACP_SET_BACKLIGHT command.
+	 */
+	struct dmub_cmd_cacp_set_backlight_data cacp_set_backlight_data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__CACP_SET_PWM_FRAC command.
+ */
+struct dmub_cmd_cacp_set_pwm_frac_data {
+	/**
+	 * Enable/disable fractional duty cycle for backlight PWM.
+	 * TODO: Convert to uint8_t.
+	 */
+	uint32_t fractional_pwm;
+
+	/**
+	 * CACP control version.
+	 */
+	uint8_t version;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__CACP_SET_PWM_FRAC command.
+ */
+struct dmub_rb_cmd_cacp_set_pwm_frac {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__CACP_SET_PWM_FRAC command.
+	 */
+	struct dmub_cmd_cacp_set_pwm_frac_data cacp_set_pwm_frac_data;
+};
+
+/**
+ * Definition of a DMUB_CMD__CACP_GET_HISTOGRAM command.
+ */
+struct dmub_rb_cmd_cacp_get_histogram {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Address where Histogram should be copied.
+	 */
+	union dmub_addr dest;
+
+	/**
+	 * Type of Histogram being queried.
+	 */
+	enum dmub_abm_histogram_type histogram_type;
+
+	/**
+	 * Indirect buffer length.
+	 */
+	uint16_t bytes;
+
+	/**
+	 * eDP panel instance.
+	 */
+	uint8_t panel_inst;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad;
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__QUERY_FEATURE_CAPS command.
  */
@@ -6328,7 +6800,7 @@ struct dmub_cmd_cable_id_input {
 };
 
 /**
- * struct dmub_cmd_cable_id_output - Defines the output of DMUB_CMD_GET_USBC_CABLE_ID command.
+ * struct dmub_cmd_cable_id_input - Defines the output of DMUB_CMD_GET_USBC_CABLE_ID command.
  */
 struct dmub_cmd_cable_id_output {
 	uint8_t UHBR10_20_CAPABILITY	:2; /**< b'01 for UHBR10 support, b'10 for both UHBR10 and UHBR20 support */
@@ -6619,7 +7091,7 @@ struct dmub_cmd_pr_enable_data {
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which replay_state to use
+	 * Panel isntance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -6697,7 +7169,7 @@ struct dmub_cmd_pr_copy_settings_data {
 	uint8_t aux_inst;
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which psr_state to use
+	 * Panel isntance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -6706,7 +7178,7 @@ struct dmub_cmd_pr_copy_settings_data {
 	 */
 	uint8_t dpphy_inst;
 	/**
-	 * Determines if SMU optimizations are enabled/disabled.
+	 * Determines if SMU optimzations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
 	/**
@@ -6714,7 +7186,7 @@ struct dmub_cmd_pr_copy_settings_data {
 	 */
 	uint32_t line_time_in_ns;
 	/*
-	 * Use FSFT after pixel clk
+	 * Use FSFT afftet pixel clk
 	 */
 	uint32_t pix_clk_100hz;
 	/*
@@ -6787,7 +7259,7 @@ union dmub_pr_runtime_flags {
 struct dmub_cmd_pr_update_state_data {
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which psr_state to use
+	 * Panel isntance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -6802,6 +7274,7 @@ struct dmub_cmd_pr_update_state_data {
 	 */
 	uint32_t coasting_vtotal;
 	uint32_t sync_mode;
+	uint32_t pseudo_vtotal;
 
 	union dmub_pr_runtime_flags pr_runtime_flags;
 };
@@ -6809,7 +7282,7 @@ struct dmub_cmd_pr_update_state_data {
 struct dmub_cmd_pr_general_cmd_data {
 	/**
 	 * Panel Instance.
-	 * Panel instance to identify which psr_state to use
+	 * Panel isntance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -7134,6 +7607,47 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__DPIA_HPD_INT_ENABLE command.
 	 */
 	struct dmub_rb_cmd_dpia_hpd_int_enable dpia_hpd_int_enable;
+
+	/**
+	 * Definition of a DMUB_CMD__CACP_SET_PIPE command.
+	 */
+	struct dmub_rb_cmd_cacp_set_pipe cacp_set_pipe;
+
+	/**
+	 * Definition of a DMUB_CMD__CACP_SET_LEVEL command.
+	 */
+	struct dmub_rb_cmd_cacp_set_level cacp_set_level;
+
+	/**
+	 * Definition of a DMUB_CMD__CACP_SET_EVENT command.
+	 */
+	struct dmub_rb_cmd_cacp_set_event cacp_set_event;
+
+	/**
+	 * Definition of a DMUB_CMD__CACP_INIT_CONFIG command.
+	 */
+	struct dmub_rb_cmd_cacp_init_config cacp_init_config;
+
+	/**
+	 * Definition of a DMUB_CMD__CACP_PAUSE command.
+	 */
+	struct dmub_rb_cmd_cacp_pause cacp_pause;
+
+	/**
+	 * Definition of a DMUB_CMD__CACP_SET_BACKLIGHT command.
+	 */
+	struct dmub_rb_cmd_cacp_set_backlight cacp_set_backlight;
+
+	/**
+	 * Definition of a DMUB_CMD__CACP_SET_PWM_FRAC command.
+	 */
+	struct dmub_rb_cmd_cacp_set_pwm_frac cacp_set_pwm_frac;
+
+	/**
+	 * Definition of a DMUB_CMD__CACP_GET_HISTOGRAM command.
+	 */
+	struct dmub_rb_cmd_cacp_get_histogram cacp_get_histogram;
+
 	/**
 	 * Definition of a DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE command.
 	 */
@@ -7189,6 +7703,8 @@ union dmub_rb_cmd {
 
 	struct dmub_rb_cmd_ib ib_fams2_config;
 
+	struct dmub_rb_cmd_ib ib_fams2_debug_meta;
+
 	struct dmub_rb_cmd_fams2_drr_update fams2_drr_update;
 
 	struct dmub_rb_cmd_fams2_flip fams2_flip;
-- 
2.43.0

