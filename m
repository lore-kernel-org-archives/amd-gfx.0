Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11290C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 03:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E1910E2E7;
	Wed,  6 Aug 2025 03:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a85wyzZb";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFAD10E70F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 03:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIN7j3NDM/iN/KK9U/brLyTazXXAAKEzrJFj7smfgntYXDWeX6N7yrR/CvKjpYnwxQmsh7TUzMMXfwJgXAgFNbUrnCydEPGYZgtbrsZiN2+28UoCi14fNkNejyl/6UFjwvLhJOgTnzc3CiDpfyvh10GBPIgS/CT9B9df/ZXTjuNmpNHvTs1StLjmIgY8FUeNys25eUOyVZwQOHVSIffFSWFH/jumZJ1poGTIO/bktnaqotDs9cZ9U4i80g8UqATrdKimc0y2B8Q+RCW3GhF7B1q5LPmNuhnK3J++KDplCDDRHQ/KmtK6J4XLsF58bXwZ94wv7IvJp4YuZLnUhU1qsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlPWeldVV1s+sCxmzq7W6kEyKODKiCxYBJvnI+Sh8aU=;
 b=RIdn55uWFYET2MbcItEk6aefJLrQwGon3W7QAWYE389Sj1pVo/TvKW6LszpwCkMk5HLonmYJ9zwdmAx0SQICTszmfB5Iq1PgV5MFnjPpWPml4CKQuWx+tZvYWpCh4xOR02zfp0gTo3QprNLaDBwsaFQJLjQOaL8j+3wcaf9c8UJKG4UiFISj4vtekTVdbwqzBgNs1mrd0y5at0G2iBXuhX7C1R9SfSbUD7Q7kooYKY2sQK9IaFAXW1XlY7U2Q534GYQPc414J36HzI5W418KmCpvY5xAQqN26CXDz3ZRNMhT9ZrTQ7ixtPRHsnlIj+t/qxr9JMqbQnSt9yOGMLLaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlPWeldVV1s+sCxmzq7W6kEyKODKiCxYBJvnI+Sh8aU=;
 b=a85wyzZbudL26iy69/HV4MXZT+47MRbZup3hoqZjg+7OfHNG55pOQCMWBMXOrGKOjAGE1AUAZicXeQfs01C4roLeGYfz+fcKVlSYjgB+6rl/XAoz79f8LovLIglh2dXiH+rSTJeHUJCMUWPDG+HS/va3FQax2JmbemjhqYC2X2c=
Received: from SJ0PR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:334::23)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 03:02:50 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::cf) by SJ0PR05CA0108.outlook.office365.com
 (2603:10b6:a03:334::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Wed,
 6 Aug 2025 03:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 03:02:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 22:02:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 22:02:48 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 5 Aug 2025 22:02:45 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 3/4] drm/amd/display: [FW Promotion] Release 0.1.22.0
Date: Wed, 6 Aug 2025 10:57:12 +0800
Message-ID: <20250806030216.21096-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806030216.21096-1-chiahsuan.chung@amd.com>
References: <20250806030216.21096-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: ade91bd3-ac5c-45c9-7a0b-08ddd495ba11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ouvCJV3fLeTy05hSfJAHCB8dmMdG4vFMgzCtTuxiVa9Z+m/2CHG24uZsOU7E?=
 =?us-ascii?Q?Rzru7MGsNj2Gs1QZ8hwBO5MqmTwawhR5qaJvlelVDNf8wRD4fYxFKOanRjok?=
 =?us-ascii?Q?lz4uSkLEgHLFgYqSyu/Qtr2tRHyYL6eAYkFQBWOeV4SSwBFq10/Z8fz2dH8r?=
 =?us-ascii?Q?qqZPvNgL9S6i01PPTtMxFOkgu+vnCG46aolJUNpdb4SUaESHMyPkMvfmXQ+y?=
 =?us-ascii?Q?XtJdsA4P7vD/Kx7a6SjynHslFWhwsRnbftDvAj/5kjsTEXTUxNsYc/N6jLCU?=
 =?us-ascii?Q?gTBKN2CKAdz3xYWnpDWBQMTt9Om0Zjwb249F19eeOW1lJnFlbKhq8rWkC3dt?=
 =?us-ascii?Q?n3nHTKUMUH2FLScQeBho+zF4Bs/93g7098i+fflzOmQbkAVdiiXD8PoHCvNl?=
 =?us-ascii?Q?fLQRLQeslR4nu1ElTvq4hRQVxDd6DP3yFUiF8lzPX4E5eoqdOi4KANH02bkI?=
 =?us-ascii?Q?U8W6a9V6QMj4KZRzrSdNtPdqDrUaPtnR0fz7RFgzHppvTzqefsnGTMK4iFEs?=
 =?us-ascii?Q?Rv3+fspGJpzac2cbcZOdwCR0zv/nwH7pbaFSb4BufBscF4pi1VbpAzwwA6nT?=
 =?us-ascii?Q?lcnLWzc425V+5T/tAUIQs+7OY5EEB7fWkj5y9EhPTK9cJmkT/VhnuLJroNvI?=
 =?us-ascii?Q?wgQWkxa5QOJBwOMAMCDuaYOMRx9m8/GppIUMwCDmAdqJRsGMZyOExIodKfcF?=
 =?us-ascii?Q?TS4ef3Wb/xis0Uz3F9UnwbgXLgoU3n9Z4aSONyjJyG7t7XryyXr/8VcG7Qd+?=
 =?us-ascii?Q?EhRGxXyT/qjCS2xlOiWfWWzp7ZyeekBcp/tmnWzjNjgeLZcy4VU/w5UH6D0o?=
 =?us-ascii?Q?PsBICC22w8rcotYKW7jNxlQAkwmZ4wv0Qi6bk5GW/dHXctj1PzqvXDAFbXWh?=
 =?us-ascii?Q?upwUWf4FBSPaDoKcK/9NfBuP4se2Q9Whc5YvfjRSGvcM6yJOSG+f3WY1K6QH?=
 =?us-ascii?Q?OU/aJ1cqB9eB6ebMaG0DCAonzMaGFcg9FrWkyd2jhUz1cJa9sXNm4sZI5Wit?=
 =?us-ascii?Q?C2SxIzNuZIEUhgiTtaFlS4lmHQ8ClLa++fF07FZ3EMfJnLednR/WvMeaEj0K?=
 =?us-ascii?Q?Y8gzQpfuFETb1IBxrGvcZTf6+Cr1N+FhYnZMSTtcIJDCQqfiurAz8O5O7acC?=
 =?us-ascii?Q?NvzTfxnJopCuGTfM5oi+aH0FMqee+3JLPcMTiY7m+kW3jWGR66KMxy9Sfckz?=
 =?us-ascii?Q?UNuxl9cAu+2qKQenyjW8cEpoMyGwXY+5ts2Rko8ZEzRT7dhZHtFj1Peh/SR7?=
 =?us-ascii?Q?OCUo7nZBetuLUj9orUSJ3RJietwjN5s1ZILxNI7JSBKmRAyu3wPIoLAABlOH?=
 =?us-ascii?Q?f+p/NN1dmyLxrzrolDZ64h+VDJYc7D73Xm3XoOeXHiWpeBZ8jzzIUqtlNEYo?=
 =?us-ascii?Q?jJoC5f4TbH/Hs7sNVW6YrbksL3jToz2LK2xe6ZxSob6B5k5IcN3MgOUQTVKU?=
 =?us-ascii?Q?AncPwXYjzb2ftxJRAOuWdbh+tE1PAVrZZRbKObMwJ/Yx0TFkIQgDelelmm/4?=
 =?us-ascii?Q?WfGEyzazgSrTHNV/mDqs7uvxx4Dk5NGTHnUM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:02:49.2051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ade91bd3-ac5c-45c9-7a0b-08ddd495ba11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803
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

Add a new command for Panel Replay.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 79b5b1bb9b93..52295efdba63 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4019,6 +4019,10 @@ enum dmub_cmd_replay_type {
 	 * Set adaptive sync sdp enabled
 	 */
 	DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP = 8,
+	/**
+	 * Set version
+	 */
+	DMUB_CMD__REPLAY_SET_VERSION = 9,
 	/**
 	 * Set Replay General command.
 	 */
@@ -4143,6 +4147,63 @@ struct dmub_cmd_replay_copy_settings_data {
 	uint8_t pad[2];
 };
 
+
+/**
+ * Replay versions.
+ */
+enum replay_version {
+	/**
+	 * FreeSync Replay
+	 */
+	REPLAY_VERSION_FREESYNC_REPLAY	= 0,
+	/**
+	 * Panel Replay
+	 */
+	REPLAY_VERSION_PANEL_REPLAY		= 1,
+	/**
+	 * Replay not supported.
+	 */
+	REPLAY_VERSION_UNSUPPORTED		= 0xFF,
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD___SET_REPLAY_VERSION command.
+ */
+struct dmub_cmd_replay_set_version_data {
+	/**
+	 * PSR version that FW should implement.
+	 */
+	enum replay_version version;
+	/**
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel instance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__REPLAY_SET_VERSION command.
+ */
+struct dmub_rb_cmd_replay_set_version {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__REPLAY_SET_VERSION command.
+	 */
+	struct dmub_cmd_replay_set_version_data replay_set_version_data;
+};
+
 /**
  * Definition of a DMUB_CMD__REPLAY_COPY_SETTINGS command.
  */
@@ -4506,6 +4567,10 @@ union dmub_replay_cmd_set {
 	 * Definition of DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP command data.
 	 */
 	struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data disabled_adaptive_sync_sdp_data;
+	/**
+	 * Definition of DMUB_CMD__REPLAY_SET_VERSION command data.
+	 */
+	struct dmub_cmd_replay_set_version_data version_data;
 	/**
 	 * Definition of DMUB_CMD__REPLAY_SET_GENERAL_CMD command data.
 	 */
@@ -6265,6 +6330,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE command.
 	 */
 	struct dmub_rb_cmd_idle_opt_set_dc_power_state idle_opt_set_dc_power_state;
+	/**
+	 * Definition of a DMUB_CMD__REPLAY_SET_VERSION command.
+	 */
+	struct dmub_rb_cmd_replay_set_version replay_set_version;
 	/*
 	 * Definition of a DMUB_CMD__REPLAY_COPY_SETTINGS command.
 	 */
-- 
2.43.0

