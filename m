Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72FCC83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF9B10E963;
	Thu, 10 Jul 2025 21:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQ0/XHH/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6235710E96B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2612BYMeE4K6u61JzKdkxJ4UlozFlQMubELNOy4jmtsQLu4IXlwcTJV29BMk8YRvRhEFdMqCxJKEB87dDO/L/4gU6U8eorMRPOgE90IWBT74luuAzhig1zHWUiTSjwPOEc4FOsvyxHHaBD6aA+1TfTdtaQTgkNgTHuTVp5tTBWodc0taJcIvVAdwU/3a1C9Xyh2J9hOyrUggum5AFksajtDlSmVTs0K26vhtxZBj99yarZ6/DmIecHr3dCHXPdLHl5YU+PFdFglH9Ym0TMBA/X5Pp7ILpdLcyjUJP0Q/WTEkmUZ6gT4eKvCk1u3+mDO3tecnBjiaFg73M2DOX4qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bYI60Ergi3yAU4uM7TFWnC0wF5AIK/ljimBoL91d1A=;
 b=LvSkA1x+uxqw0SwLjEyjSemuCIvcNFqFMkqzHPrC0xKKr8aGmbfbHkH/1drykIIP0tzCAOovzuuQG/tMctCBSNVTYSJX+aF1HgI8CEfa5FdwLJ3/qhu9goYEd6/iB5ZToGvkpeRU1Ywl3wL2afgKL6JqDZL3kainSbhmgI0R7heTbWl3BFJuGth38buHMhmElAHknof71lttBUL3nuGAjShJmZHWlQYL7TJvOz6kmACT6WaGryuJdZA+oIbnlDLWDJtMAIhR5cGdsLA6zXNMtFHcB1ESm4deYke238vgic5ka1zQfYPmG6IQD5yI5F3X/vjwGHz6fqRRCpdoZHw1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bYI60Ergi3yAU4uM7TFWnC0wF5AIK/ljimBoL91d1A=;
 b=BQ0/XHH/h8TYJ+gpcYg+2Dg/Hq6pcxcMZTgqi7dP99kAvmjzqVnrcwqZ2zrNEaGsKCPz8r61Hi/wIyUCNEPw+CEa+TnJ7oP45nzOt+U0wiUCQ0XJZ90FqhwG6GhZiN2eocKD3O0PBdpvAT9ZDti4t0qJ4aOpfXsqJFGyJToEUPU=
Received: from SJ0PR13CA0205.namprd13.prod.outlook.com (2603:10b6:a03:2c3::30)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 10 Jul
 2025 21:30:59 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::7) by SJ0PR13CA0205.outlook.office365.com
 (2603:10b6:a03:2c3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Thu,
 10 Jul 2025 21:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:30:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:54 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:30:54 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Leo Chen <leo.chen@amd.com>, 
 Duncan Ma <duncan.ma@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 08/18] drm/amd/display: Adding missing driver code for IPSv2.0
Date: Thu, 10 Jul 2025 17:25:41 -0400
Message-ID: <20250710212941.630259-9-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d29b06c-22c5-461a-e797-08ddbff90fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8BChqhHz0s/PXKKrIr2mZHypHoYjiFb6FNxdDcolWrkzrQrAdIHAjsZMhOHn?=
 =?us-ascii?Q?l7Lc1beAtQ7u3sW3Cxb2RH6kg2IXkT7A/qmECrkIIeipvZuzJOS86kcCE4oa?=
 =?us-ascii?Q?mdmqPxoXqftPmDQeimrJGKcG5uDEP/7N3l7VllGJQiACgttAiG4GgitDMCLc?=
 =?us-ascii?Q?amOJZCJ642nTCfBKq9siNNZUIUN6ya0pmQ554SYYVbKhEUs7O27BXtWUmIPM?=
 =?us-ascii?Q?3q6YNLVS7D80slgPxpgtIWJxuKTMHZF45VkbhTfPzAMq0RVU7uF5hmSKUVCU?=
 =?us-ascii?Q?CuljBFRhIuhleF2RhsE21pJKpZbR359ZadBph6a/Noy7uK3pGMQ001h9Tqaf?=
 =?us-ascii?Q?zFLAf9AhCbkla52jO8WlPAB2VF7CINMk8dwgbAndUQMLTqX/kP6rRpoVYybG?=
 =?us-ascii?Q?rE5cBJEaSzuPkRP7VB1XqjzUDSKZyJSpazkhi/w12wGoOsByirWKoIGMh6JY?=
 =?us-ascii?Q?riSQOzW39NTwJXKUjtymii1h32veXNpCkGvT1saTJ61DYxdoTsVtEkqR/LdB?=
 =?us-ascii?Q?k957E58bNJLg7gg/6xvRtzS5AuiQOTImKv5TALy1va/zFfdQaa+v5/FvZQG3?=
 =?us-ascii?Q?nYqeGzQKJw6i81AFnVkgzgB1s7Wt1NOQX11vdBkLwDrLw6RYbaw6FVgwRDuQ?=
 =?us-ascii?Q?00oHKESVSnOb+mDtpBnhDMFewHQmz9Bneu7zwZIySIUsOWEymIpC2e90Tj/p?=
 =?us-ascii?Q?BNgJ2ILlcgChiuwy3HAMItc/M+04Z4uoJ4Wqc5JkNRsZOVsM/hQeyQvRTrBI?=
 =?us-ascii?Q?njpFIBCOSD731fszsgh08aw8XEgIhEcRKTF9H5MDblKyROpPYHo7x5f0QcBL?=
 =?us-ascii?Q?T3+nw7DcuYv0Xbw+i3n28QH7+UTRe8UDcvou3ca+Y/Lyso24oh6Ehweu8klo?=
 =?us-ascii?Q?WYhvK+1kalci17XHeSy8ieFXA7Uvhjgus/k+1ObkIFHs+pWoFAINCkQeI60u?=
 =?us-ascii?Q?/oUglC428kcox8gtT7omU4ztbffO8lYkMNI6o23yYoSq/ewSFrmGbJBikYFt?=
 =?us-ascii?Q?VUAw2yc7tzEQbJqo0ZKPXkLNDMAzySYPufLF/12DejWsBXzqEkydfVx45KZP?=
 =?us-ascii?Q?h2kRbVjJMytxwBlEGUqy4WIx2AamZ/jbpEHj1jVZ1I3C7ISS/d5S0XCQUnzi?=
 =?us-ascii?Q?hktuXyflCsupYR2CAIs9+tfeOdQ+7IOojbCvzzkweFa9OqQ1WenTRT8UkFs9?=
 =?us-ascii?Q?Jt+cXkUtfyC54XaHfpid/n1HejosuCU3cYMxWRPI4x4TCOBMZ2IQhc6JD55s?=
 =?us-ascii?Q?GjAW6xWmGNcUW0jGA9FC3nkyBKXfdz/xSONmVvY6XKCcn41/7mnxo50MSCq1?=
 =?us-ascii?Q?XBPhukwvagTv24rF0v7IOFKJT8IomeKQZZfGM+ylZhAZnvrSfJiwBvb4CBfM?=
 =?us-ascii?Q?V3odkWQGaH/eI9zulcc6d4teljw7qj95LbTKyUCQmdfE8dXqNFUxrBaNXtpd?=
 =?us-ascii?Q?jJGeWmOEk2WjjBWP93NKDQQjUSEk8OLNP0j0JKM6BJ1qYWlb16R3M21I0oZr?=
 =?us-ascii?Q?HnBQVncTjm6nUR84sfIFO/Z8DhUiGDeI1y0P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:30:58.6462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d29b06c-22c5-461a-e797-08ddbff90fb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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

From: Leo Chen <leo.chen@amd.com>

[Why & How]
Aligned IPS FW state with DMCUB IPS FW state
Added debug option disable_ips_rcg to modify RCG behaviour in IPS modes.
Updated existing debug option disable_ips to align with new changes introduced by IPSv2.0

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 51 ++++++++++++++-----
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +-
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index aa1b976cf40d..8a09c5f487d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -515,6 +515,7 @@ struct dc_config {
 	bool EnableMinDispClkODM;
 	bool enable_auto_dpm_test_logs;
 	unsigned int disable_ips;
+	unsigned int disable_ips_rcg;
 	unsigned int disable_ips_in_vpb;
 	bool disable_ips_in_dpms_off;
 	bool usb4_bw_alloc_support;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0a47d1a3515b..c10e603b54af 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1269,12 +1269,16 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 			new_signals.bits.allow_ips1 = 1;
 			new_signals.bits.allow_ips2 = 1;
 			new_signals.bits.allow_z10 = 1;
+			// New in IPSv2.0
+			new_signals.bits.allow_ips1z8 = 1;
 		} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
 			new_signals.bits.allow_ips1 = 1;
 		} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
+			// IPSv1.0 only
 			new_signals.bits.allow_pg = 1;
 			new_signals.bits.allow_ips1 = 1;
 		} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
+			// IPSv1.0 only
 			new_signals.bits.allow_pg = 1;
 			new_signals.bits.allow_ips1 = 1;
 			new_signals.bits.allow_ips2 = 1;
@@ -1286,6 +1290,8 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 				new_signals.bits.allow_ips1 = 1;
 				new_signals.bits.allow_ips2 = 1;
 				new_signals.bits.allow_z10 = 1;
+				// New in IPSv2.0
+				new_signals.bits.allow_ips1z8 = 1;
 			} else {
 				/* RCG only */
 				new_signals.bits.allow_pg = 0;
@@ -1293,8 +1299,21 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 				new_signals.bits.allow_ips2 = 0;
 				new_signals.bits.allow_z10 = 0;
 			}
+		} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_Z8_RETENTION) {
+			new_signals.bits.allow_pg = 1;
+			new_signals.bits.allow_ips1 = 1;
+			new_signals.bits.allow_ips2 = 1;
+			new_signals.bits.allow_z10 = 1;
+		}
+		// Setting RCG allow bits (IPSv2.0)
+		if (dc->config.disable_ips_rcg == DMUB_IPS_RCG_ENABLE) {
+			new_signals.bits.allow_ips0_rcg = 1;
+			new_signals.bits.allow_ips1_rcg = 1;
+		} else if (dc->config.disable_ips_rcg == DMUB_IPS0_RCG_DISABLE) {
+			new_signals.bits.allow_ips1_rcg = 1;
+		} else if (dc->config.disable_ips_rcg == DMUB_IPS1_RCG_DISABLE) {
+			new_signals.bits.allow_ips0_rcg = 1;
 		}
-
 		ips_driver->signals = new_signals;
 		dc_dmub_srv->driver_signals = ips_driver->signals;
 	}
@@ -1318,7 +1337,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
 	struct dc_dmub_srv *dc_dmub_srv;
-	uint32_t rcg_exit_count = 0, ips1_exit_count = 0, ips2_exit_count = 0;
+	uint32_t rcg_exit_count = 0, ips1_exit_count = 0, ips2_exit_count = 0, ips1z8_exit_count = 0;
 
 	if (dc->debug.dmcub_emulation)
 		return;
@@ -1338,31 +1357,34 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		rcg_exit_count = ips_fw->rcg_exit_count;
 		ips1_exit_count = ips_fw->ips1_exit_count;
 		ips2_exit_count = ips_fw->ips2_exit_count;
+		ips1z8_exit_count = ips_fw->ips1_z8ret_exit_count;
 
 		ips_driver->signals.all = 0;
 		dc_dmub_srv->driver_signals = ips_driver->signals;
 
 		DC_LOG_IPS(
-			"%s (allow ips1=%u ips2=%u) (commit ips1=%u ips2=%u) (count rcg=%u ips1=%u ips2=%u)",
+			"%s (allow ips1=%u ips2=%u) (commit ips1=%u ips2=%u ips1z8=%u) (count rcg=%u ips1=%u ips2=%u ips1_z8=%u)",
 			__func__,
 			ips_driver->signals.bits.allow_ips1,
 			ips_driver->signals.bits.allow_ips2,
 			ips_fw->signals.bits.ips1_commit,
 			ips_fw->signals.bits.ips2_commit,
+			ips_fw->signals.bits.ips1z8_commit,
 			ips_fw->rcg_entry_count,
 			ips_fw->ips1_entry_count,
-			ips_fw->ips2_entry_count);
+			ips_fw->ips2_entry_count,
+			ips_fw->ips1_z8ret_entry_count);
 
 		/* Note: register access has technically not resumed for DCN here, but we
 		 * need to be message PMFW through our standard register interface.
 		 */
 		dc_dmub_srv->needs_idle_wake = false;
 
-		if ((prev_driver_signals.bits.allow_ips2 || prev_driver_signals.all == 0) &&
+		if (!dc->caps.ips_v2_support && ((prev_driver_signals.bits.allow_ips2 || prev_driver_signals.all == 0) &&
 		    (!dc->debug.optimize_ips_handshake ||
-		     ips_fw->signals.bits.ips2_commit || !ips_fw->signals.bits.in_idle)) {
+		     ips_fw->signals.bits.ips2_commit || !ips_fw->signals.bits.in_idle))) {
 			DC_LOG_IPS(
-				"wait IPS2 eval (ips1_commit=%u ips2_commit=%u)",
+				"wait IPS2 eval (ips1_commit=%u ips2_commit=%u )",
 				ips_fw->signals.bits.ips1_commit,
 				ips_fw->signals.bits.ips2_commit);
 
@@ -1422,28 +1444,31 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		dc_dmub_srv_notify_idle(dc, false);
 		if (prev_driver_signals.bits.allow_ips1 || prev_driver_signals.all == 0) {
 			DC_LOG_IPS(
-				"wait for IPS1 commit clear (ips1_commit=%u ips2_commit=%u)",
+				"wait for IPS1 commit clear (ips1_commit=%u ips2_commit=%u ips1z8=%u)",
 				ips_fw->signals.bits.ips1_commit,
-				ips_fw->signals.bits.ips2_commit);
+				ips_fw->signals.bits.ips2_commit,
+				ips_fw->signals.bits.ips1z8_commit);
 
 			while (ips_fw->signals.bits.ips1_commit)
 				udelay(1);
 
 			DC_LOG_IPS(
-				"wait for IPS1 commit clear done (ips1_commit=%u ips2_commit=%u)",
+				"wait for IPS1 commit clear done (ips1_commit=%u ips2_commit=%u ips1z8=%u)",
 				ips_fw->signals.bits.ips1_commit,
-				ips_fw->signals.bits.ips2_commit);
+				ips_fw->signals.bits.ips2_commit,
+				ips_fw->signals.bits.ips1z8_commit);
 		}
 	}
 
 	if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
 		ASSERT(0);
 
-	DC_LOG_IPS("%s exit (count rcg=%u ips1=%u ips2=%u)",
+	DC_LOG_IPS("%s exit (count rcg=%u ips1=%u ips2=%u ips1z8=%u)",
 		__func__,
 		rcg_exit_count,
 		ips1_exit_count,
-		ips2_exit_count);
+		ips2_exit_count,
+		ips1z8_exit_count);
 }
 
 void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state power_state)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5cf5dd5831fc..938a07cdcfec 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -875,7 +875,7 @@ enum dmub_shared_state_feature_id {
 /**
  * struct dmub_shared_state_ips_fw - Firmware signals for IPS.
  */
-union dmub_shared_state_ips_fw_signals {
+ union dmub_shared_state_ips_fw_signals {
 	struct {
 		uint32_t ips1_commit : 1;  /**< 1 if in IPS1 or IPS0 RCG */
 		uint32_t ips2_commit : 1; /**< 1 if in IPS2 */
@@ -890,7 +890,7 @@ union dmub_shared_state_ips_fw_signals {
 /**
  * struct dmub_shared_state_ips_signals - Firmware signals for IPS.
  */
-union dmub_shared_state_ips_driver_signals {
+ union dmub_shared_state_ips_driver_signals {
 	struct {
 		uint32_t allow_pg : 1; /**< 1 if PG is allowed */
 		uint32_t allow_ips1 : 1; /**< 1 is IPS1 is allowed */
-- 
2.43.0

