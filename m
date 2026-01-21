Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77461C44500
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC6010E894;
	Wed, 21 Jan 2026 22:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UZ1DZ3uf";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AB010E894
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH0jJKSOuZP+0IM8j3SxOZbNGPlJl1jbG9j/y1TxoBjlN8S26VqcetwofPpgRhyMBWh3e+pWPMu4zAutPho92wF9H9XcWaUou6aE3IxM7tV4Ds9FgManc7lQCom8VYUMdfAeaovOHMDmGNp1qU/CNkK9k4g6r+XGSIrtdX67HA3PFYECLQ28Bp2dSyzZUp39sk1mFkOGCriSVMvPnZqRObOGOIWpzUkPkmQ500aAR/uffFzewfh7yPpX6pRw9E+TB8u/hX6hPDvtSZN+vOwoCfVBiIZZ2jKfte2tm2ohNxP7Ng9fsh58rZWg1jXt9H/+0z7Tl3HkZ+2HiNRKxpKFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RrYSj9ryG+Ss9th9E2m/zeWjxsgQWNugxwu+zKh7Q0=;
 b=dmcuKptxC1V3a5xlIIpuaL0pYIWMUlWbVzZQmhcX/ApMftrNuae6DMdxP2kI0K5j2ZoyONQojHXWQgstcntvrYtbOB+CpUmP3NbAXSEf6rwLrmVOrG9TBKef+H8owNDTUgLZW0RUSETzsTVlVvqYKZEyw+dYUFmjrmvUTtQTDtyf8HjS6a6KzpoH5XU62D62YN/nuTtIIVvyFiOIVxJlRkOlr/R6uD+tfej2lrAmWijAhvtuycgouWYU4h+oTAUdSOc7uJzPLuT+fSrSYdigyQstsUTI0ihey56op1yI9SxSEHlZapdA8cgnOhv1ZhSJO9lMdFtOIO4evlNS0a1puA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RrYSj9ryG+Ss9th9E2m/zeWjxsgQWNugxwu+zKh7Q0=;
 b=UZ1DZ3ufnzd05F/QGPYBRqIgm4ASsozr/L9/Cs0+bTzHhpwekKALkx2knhAI6OP9fpjCxvaciTC5rAfaZkpTwJYwGYsL/qfAr+E3AvQt0PqhzJIrDqVU/a+aOIcqZUKK2EN3XuQe5V3xNtjX9w8grdr5qDaJaEPi3nV8Q1M5KVI=
Received: from SA9PR03CA0021.namprd03.prod.outlook.com (2603:10b6:806:20::26)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:33:17 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::1d) by SA9PR03CA0021.outlook.office365.com
 (2603:10b6:806:20::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:11 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:33:10 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 12/13] drm/amd/display: [FW Promotion] Release 0.1.44.0
Date: Wed, 21 Jan 2026 17:31:48 -0500
Message-ID: <20260121223247.186241-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: befd6484-636a-4215-a2da-08de593d125a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x9WPlHxfRUMVBEcdYLW81FGff+4CtkTAmWBBxGSCIYOLa9Dtfu5QQgt7TmaU?=
 =?us-ascii?Q?7mWjwGt0xReF0TBYkFKbvMNcDwz5J/XP/CrY95sBrP1BZ8cthHOa8HX6ZyzQ?=
 =?us-ascii?Q?p+Wv3mo+jt6Re8Cwp/1Cw7Eu11tan95L150/p0/3imBDEYE3h72XFpViN4Au?=
 =?us-ascii?Q?0N8M6MIxePEr06++njDgIYRfqyIV50T7A4lHbyFCThjcn/VslxRD4xaQZIGt?=
 =?us-ascii?Q?t9Vb7Huty2h7rVW2KxHJMmvvLWWC7MUa7OIGpeMufC6b+N5m8HxCoOKj7SgR?=
 =?us-ascii?Q?56BqJDG7ZkBIdqFhGxd8G6mzScEwpv5L/rdfZI7i7BkzEQdvt4EbJlHz+byC?=
 =?us-ascii?Q?hIxCWv5tCFwQUQEJpg92pYSoE9m54rmkeDR+etyQR069GLLNfaLr6P3226qp?=
 =?us-ascii?Q?vnUOil+aVlau87BnDnEZjKVtCFE3cGRA+v4nEORoBqgRbzLvNhUAnlHMLjvs?=
 =?us-ascii?Q?blibauO7T2xmfP7q/5T8iiTAgrcME0+ka7RDVFGAciB0QYt117ZSjG3ple0j?=
 =?us-ascii?Q?WT8lnDzXpxDaqztwW9chlAhRH/MHmY8/Xjs4of2cdk2sn9JjJQxDtETDNDmC?=
 =?us-ascii?Q?v/XJik8lVc0Z0xnV9RiGlemu+QnCnh7MHdfz7vwC5zydTI/F/owjOSSJp7LN?=
 =?us-ascii?Q?wrn0IKEoUbpuOl5DPc4Mv5DoI6liACJjc0eDaJ8ZgMrHT+P3tj3VaeFSNYqB?=
 =?us-ascii?Q?+NbhKr32aNQlm73R9xF9YSPB4SEvUjevbdCnolN4WmVlZcttWIN3ctz2QgbY?=
 =?us-ascii?Q?rAZRS9pjp+N2gJBeaZEz5v+IFR60Jkr0QNQE6OIZ/eJgtc587EgomQ447dpn?=
 =?us-ascii?Q?soA+pFloULpoJw5V91udXZ0HtU7zCHzr6VgCLa1qAmR0edjz5lGHddF+D//A?=
 =?us-ascii?Q?I8pauaDivdPFDYYoG/CSlSu8hulLWclfZ5Mbhoc857sCCrNSwGvPYcPEtcrX?=
 =?us-ascii?Q?5G6q3YOElU9f75kS+AF+AR5LAa+TLxA7+36Yb5GGOEqCYowsjq/9Bkf/wejf?=
 =?us-ascii?Q?PUHCEHSqPgxN0p7TkdFobkNRMj0at03JtpF/eoKnOO/9G6LLulbUVONC/rR3?=
 =?us-ascii?Q?n/HWJG5Revn5xy/twTW5sOEYJbCHwbzj5h/MYXp78gnOQt3ycQy/voSPrNoD?=
 =?us-ascii?Q?9MVh/2VF6/C6kZQfZrv4Wiv9FofUD+hnR6Rse/cXZHLcbJPnM98NGGkfsXXt?=
 =?us-ascii?Q?xcH5NEenjngySH13Yc0hMLEYFPBm5jP8E5jHFKkDbHF4L8Kk0OPs/s5XfXFV?=
 =?us-ascii?Q?7h+s5lrkNeUyrUB/yeeutk2C6s90wq+rq6lCF5z3FvhDVBV373sif8MbJPqI?=
 =?us-ascii?Q?AgPOMI5KifvcXh9KrqpKeTP66QgmS7wyVU6halSViZM5AgWEw56pTx6Z4xGG?=
 =?us-ascii?Q?b8x2j3aSjKO4fgiQoYTeDFkjs/qAhV4ra0XL1mr0YcTkf5kBrLfAsZ5fCXUv?=
 =?us-ascii?Q?66y++3gpuhF2MZJJSgeRw2OhyQVMKb/+QaAZkwycQsOQKwy/tCLvJX+BPh/G?=
 =?us-ascii?Q?VWEmPSglyno4lOyZBJ5tWpsOotgMoSgMDPyQXKg7Gfk3EvTKLDqxlmRu4uD7?=
 =?us-ascii?Q?MSyZ4vcna+DRc+uJr+wViVK31D25bVOfsJTcZ4acldDPNZyUscz7d2Zjr0uE?=
 =?us-ascii?Q?04RpjaahQaELRrBKLBtGrPBmlJbBn9uspng/oxCVlWTYd9WCfqnu4YeZKX/T?=
 =?us-ascii?Q?1MYF7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:16.8608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: befd6484-636a-4215-a2da-08de593d125a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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

* Panel Replay related features/bugfixes
* BootCRC feature

Reviewed-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 55 +++++++++++++++++--
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 86a40ce9a269..87248c378bd4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -139,6 +139,33 @@
  */
 #define DMUB_CMD_PSR_CONTROL_VERSION_1 0x1
 
+/**
+ *
+ * dirty rect cmd version legacy
+ */
+#define DMUB_CMD_DIRTY_RECTS_VERSION_UNKNOWN 0x0
+/**
+ * dirty rect cmd version with multi edp support
+ */
+#define DMUB_CMD_DIRTY_RECTS_VERSION_1 0x1
+/**
+ * dirty rect cmd version with external monitor support
+ */
+#define DMUB_CMD_DIRTY_RECTS_VERSION_2 0x2
+
+/**
+ *
+ * Cursor update cmd version legacy
+ */
+#define DMUB_CMD_CURSOR_UPDATE_VERSION_UNKNOWN 0x0
+/**
+ * Cursor update cmd version with multi edp support
+ */
+#define DMUB_CMD_CURSOR_UPDATE_VERSION_1 0x1
+/**
+ * Cursor update cmd version with external monitor support
+ */
+#define DMUB_CMD_CURSOR_UPDATE_VERSION_2 0x2
 
 /**
  * ABM control version legacy
@@ -3929,7 +3956,7 @@ struct dmub_cmd_update_dirty_rect_data {
 	 */
 	union dmub_psr_su_debug_flags debug_flags;
 	/**
-	 * OTG HW instance.
+	 * Pipe index.
 	 */
 	uint8_t pipe_idx;
 	/**
@@ -3937,7 +3964,7 @@ struct dmub_cmd_update_dirty_rect_data {
 	 */
 	uint8_t dirty_rect_count;
 	/**
-	 * PSR control version.
+	 * dirty rects cmd version.
 	 */
 	uint8_t cmd_version;
 	/**
@@ -3946,6 +3973,14 @@ struct dmub_cmd_update_dirty_rect_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
+	/**
+	 * OTG HW instance
+	 */
+	uint8_t otg_inst;
+	/**
+	 * Padding for 4 byte alignment
+	 */
+	uint8_t padding[3];
 };
 
 /**
@@ -4071,11 +4106,11 @@ struct dmub_cmd_update_cursor_payload0 {
 	 */
 	uint8_t enable;
 	/**
-	 * OTG HW instance.
+	 * Pipe index.
 	 */
 	uint8_t pipe_idx;
 	/**
-	 * PSR control version.
+	 * Cursor update cmd version.
 	 */
 	uint8_t cmd_version;
 	/**
@@ -4089,6 +4124,14 @@ struct dmub_cmd_update_cursor_payload0 {
 	 * Registers contains Hubp & Dpp modules
 	 */
 	struct dmub_cursor_position_cfg position_cfg;
+	/**
+	 * OTG HW instance
+	 */
+	uint8_t otg_inst;
+	/**
+	 * Padding for 4 byte alignment
+	 */
+	uint8_t padding[3];
 };
 
 struct dmub_cmd_update_cursor_payload1 {
@@ -6641,9 +6684,9 @@ struct dmub_cmd_pr_copy_settings_data {
 	 */
 	uint8_t su_y_granularity;
 	/**
-	 * @pad: Align structure to 4 byte boundary.
+	 * @main_link_activity_option: Indicates main link activity option selected
 	 */
-	uint8_t pad;
+	uint8_t main_link_activity_option;
 };
 
 /**
-- 
2.52.0

