Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372F3CD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C35A010F5EC;
	Fri, 19 Jun 2026 13:32:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dc6Zue4F";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012014.outbound.protection.outlook.com
 [40.93.195.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6750610F5EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkF7fZ78dIk4kFjvOwiVhJYrLQalpE6rFSNTS6U2XmzGU2K9M4Uvs878eki5IZHoZqMZURHXLGKdxfgIOu0uIvLSbsh3JdCbdbIR7olA/peiC5GkP/yld54mvGhlxqdSFVBPgnIobmZCeoLOMWklfpbJO8YJQB7P49yq8WcZ+2ZsQCs0tLNUeOil1sf6n3C1BVFP/1Cu4ZpAtfa0qqztF7jP0QdO5ocpEplfmqDQ1CgTV0J84zLEJ8ERnocYp4B2eiu3MTyglhE7z0kUB6AA2qGEPy5dYq5rN3asE64iIaFej1Ot8peYu1etbbub4FglJvfQkzZU5nigRGZs9yFJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wqIPl5THUVSmwydFCX9eqncjDANdQp8UlfZKhoS3P8=;
 b=pe48kCzh4mG9gKJijPLDpZtcYMjyX2G1edwpO54JgBPChNgSttDLDsWLUoYz5dwZBRrDK2uMOHeSmGsAOFANWC6CaZ4TAzy3R8lHIyymyfD9kSxwo+zVCsvZ9zvqKfYmZIdvi2sU14rZPXl0rGWQXBXgexFjT37fcWCDGTy+uikV7LD1bTWucwiMn5dO5K4HlNOaUuUlPRgNpU+q1hDHc19mFDQDyy6YiSInkMMqKcLF7uG8LaP23L+YqKJzP+3Ioy4RnXfgfvUum3cOTwPcbRjrCDufws77DgGnFZlAnR9ZYOKyaeYErKd9i1Y3/c5eG9R/t1VEHDzg//hQJZg6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wqIPl5THUVSmwydFCX9eqncjDANdQp8UlfZKhoS3P8=;
 b=Dc6Zue4FFtFWVe3AYpf0MqHWDs9BtWDYvqWPy0ENBgygWhjuYKdpDeokgoaNm0p9EQq6iyIZYtRXUhFPUTdWrPkdT9lceF8FeT8Hxl9b+c+yWIqtizAyM56Ka/3DO1DRN8WUhGwkPOK5QaQGKDmQLKopp3kI6K5kejz4XRtvnkM=
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:37 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::6c) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Fri,
 19 Jun 2026 13:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:37 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:34 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 22/24] drm/amd/display: [FW Promotion] Release 0.1.64.0
Date: Fri, 19 Jun 2026 09:21:37 -0400
Message-ID: <20260619133154.116746-23-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: a28c36dd-e721-4d78-f32e-08dece073ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|18002099003|22082099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: U6iUljWDPeZVA5Q6iN5o8cJj1gxenFv3kMGHO1R+5R1iPgp049hYuElpeHNhJnzgF9l9IQ4ZMrR51CTGwahvJ5g72Ii5wMerF/P4hzkYiK+l7uVh7A27wmT999JmpwZ8Vnjc6Xlvb0JdAgJVXStRA4ICs6f+Xn9jSgUqIPdZATOzxmbqk2gLvhOQYJ25VwsBfi5cu4M2Lo+w9zrwE6fJAxhbAlU5P4eocTtksByJL4i9mY1FV4QwNMTnHdF3/TldDX6VNrM4Ci0JhW5eYDLeC5vFKy3depiLn7K2qSKIjbNVZYYrJuaYFImXV506FSBrrIfeJHlmitwVKM+8y67LvnEvT8Gy/1xFaRg8TZ1uD7azj/oJiypxn6yi/XNYA9mfmBYTEyMUuF6P8mYymSV3jYaKiAmJq/Qr5uF64lWTZa5Ug+sTu8CtScC3e5NeqUV98fqECrxnrvNz1jikyoaeJKZWu71WHCC+TicYpaExKOsVBd7b+Y2BU8VhbQtXgumNZjrZ/ql+YF9cq4f3AeUTMb4USuXNvZ2m0G1XHZwi20dXVanU/XF+BWJiclDp2oiVHCUtnQS+YOQ889GlrGaMyHpTERcynVMMkyC4NaP833ZldasXSRXy8sesvF2TM97mDfn6uI2mAUHK8dkCIcqc6sTe3dJlvzBFMK8NXNOqAfLaBCL+am4ZoVV6x26MM/vp5bJ7IeYMO7Z58jjwThtsOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eWuS2IZnKuLg+iRb9nwDsEA+dVJkA7XWmb9cUcQGcXeuYaPaVi7YCB5kvhxqJJkasd6D7l+rvRoIbpWMt45KZS/TltTcMWJoWO2DKSOS7bF48J8wTzDu3ZNX4twDzWLZiEZdKQXsv3LFpRI0v2Z/BjA+5+fI/bkU3RfgIi0ZprxqDOqnABjKRO0xD8nR2aH9B6fQFxa1qXtVGwExgKlEB5hvCt+aaTVP8XBk6pnjibSasEoY0f0GBYl3Ifax8RI6RbjzI1KxNOX3seatA1+LZFA4Tyb286aGVsuAHKAGklqosvEKYV0CMbJCoJeUkNbXTbuYzg2M3X7KXWGCab9uvDf33/DQ0wQrNJqG47sLK6CsEl3fAz91CeMIl4fJ3qhcKHpb0WcDqrG9cAnGSAAkMSFdDNGMg5og7IzzgRlCjty3MUA3IWXbKBZLhz5+nuIJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:37.8087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28c36dd-e721-4d78-f32e-08dece073ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 111 +++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 57f30be6bc9c..fb249328c4b2 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -246,14 +246,14 @@
  * OS/FW agnostic memcpy
  */
 #ifndef dmub_memcpy
-#define dmub_memcpy(dest, source, bytes) memcpy((dest), (source), (bytes))
+#define dmub_memcpy(dest, source, bytes) (void)memcpy((dest), (source), (bytes))
 #endif

 /**
  * OS/FW agnostic memset
  */
 #ifndef dmub_memset
-#define dmub_memset(dest, val, bytes) memset((dest), (val), (bytes))
+#define dmub_memset(dest, val, bytes) (void)memset((dest), (val), (bytes))
 #endif

 /**
@@ -1702,6 +1702,17 @@ enum dmub_gpint_command {
 	 * ARGS: 1 - Power off
 	 */
 	DMUB_GPINT__PANEL_POWER_OFF_SEQ = 138,
+	/**
+	 * DESC: Gets panel polarity bias.
+	 * ARGS: 0 - Get panel polarity bias
+	 */
+	DMUB_GPINT__PANEL_POLARITY_GET_BIAS = 139,
+	/**
+	 * DESC: Enables panel polarity.
+	 * ARGS: 0 - Disable panel polarity
+	 *       1 - Enable panel polarity
+	 */
+	DMUB_GPINT__PANEL_POLARITY_DEBUG_ENABLE = 140,
 };

 /**
@@ -1956,6 +1967,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__BOOT_TIME_CRC = 96,

+	/**
+	 * Command type use for all Panel Polarity commands.
+	 */
+	DMUB_CMD__PANEL_POLARITY = 97,
+
 	/**
 	 * Command type use for VBIOS shared commands.
 	 */
@@ -4365,6 +4381,15 @@ enum dmub_cmd_replay_type {
 	DMUB_CMD__REPLAY_SET_GENERAL_CMD = 16,
 };

+/*
+ * Panel Polarity sub-types
+ */
+enum dmub_cmd_panel_polarity_type {
+	DMUB_CMD__PANEL_POLARITY_ENABLE = 0,
+	DMUB_CMD__PANEL_POLARITY_GET_BIAS = 1,
+	DMUB_CMD__PANEL_POLARITY_RESET = 2,
+};
+
 /*
  * Panel Replay sub-types
  */
@@ -7031,6 +7056,80 @@ struct dmub_cmd_pr_enable_data {
 	uint8_t pad[2];
 };

+struct dmub_cmd_panel_polarity_enable_data {
+	/**
+	 * Panel Polarity enable or disable.
+	 */
+	uint8_t enable;
+	/**
+	 * OTG instance
+	 */
+	uint8_t otg_inst;
+	/**
+	 * @pad: Align structure to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
+struct dmub_cmd_panel_polarity_reset_data {
+	/**
+	 * OTG instance
+	 */
+	uint8_t otg_inst;
+	/**
+	 * @pad: Align structure to 4 byte boundary.
+	 */
+	uint8_t pad[3];
+};
+
+struct dmub_cmd_panel_polarity_get_bias_input {
+	/**
+	 * OTG instance
+	 */
+	uint8_t otg_inst;
+	uint8_t pad[3];
+};
+
+struct dmub_cmd_panel_polarity_get_bias_output {
+	/**
+	 * Accumulated Polarity Bias
+	 */
+	int32_t accumulated_bias;
+};
+
+struct dmub_rb_cmd_panel_polarity_enable {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	struct dmub_cmd_panel_polarity_enable_data data;
+};
+
+
+struct dmub_rb_cmd_panel_polarity_get_bias {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	union dmub_cmd_panel_polarity_get_bias_data {
+		struct dmub_cmd_panel_polarity_get_bias_input input; /**< Input */
+		struct dmub_cmd_panel_polarity_get_bias_output output; /**< Output */
+		uint32_t output_raw; /**< Raw data output */
+	} data;
+};
+
+struct dmub_rb_cmd_panel_polarity_reset {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	struct dmub_cmd_panel_polarity_reset_data data;
+};
+
+
 /**
  * Definition of a DMUB_CMD__PR_ENABLE command.
  * Panel Replay enable/disable is controlled using action in data.
@@ -7646,6 +7745,7 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_pr_update_state pr_update_state;

 	struct dmub_rb_cmd_pr_general_cmd pr_general_cmd;
+
 	/**
 	 * Definition of a DMUB_CMD__IHC command.
 	 */
@@ -7654,6 +7754,13 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__BOOT_TIME_CRC_INIT command.
 	 */
 	struct dmub_rb_cmd_boot_time_crc_init boot_time_crc_init;
+
+	/**
+	 * Definition of a DMUB_CMD__PANEL_POLARITY_ENABLE command.
+	 */
+	struct dmub_rb_cmd_panel_polarity_enable panel_polarity_enable;
+	struct dmub_rb_cmd_panel_polarity_get_bias panel_polarity_get_bias;
+	struct dmub_rb_cmd_panel_polarity_reset panel_polarity_reset;
 };

 /**
--
2.54.0

