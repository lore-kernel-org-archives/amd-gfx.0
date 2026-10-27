Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C3606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hyc1Vl3A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B09F10F8BD;
	Tue, 27 Oct 2026 23:26:34 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 021CC10F8BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTmv8nH2sItXv0tFHSnqIHFgqHRuh9a9YH+ALOHPd3i61y8cLumpmaK5iWXXwaj/u9Vp+db94cg2AKq1Gp/mF6fU/1bMsKak1NQ59PA6x6DR0W9p6yOuJT/6APjKh+gv3W1F63yIRUyQiTVOM3Sx7xECXfD/ZKTYLfxmCLWIq42bt4W545lSPN3+Uiaq1uRXeFlmnsTJNIyfCgHkR9xHzL3FR4kSa1cKdh+6e2Sb00MTny9OleSYFoTYOKJp8MIYQ9scHD6BSI6hG1xNGDG9/MD9EhFkUuM9gM6SEfV7tt/GBFWmeU6CCRfDanyjjk+dvmvIQImAvjeOw6m4hFSOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D94qWpgoQjSqISkMGU8Dvk/asgABNX0bYDs40MJllc=;
 b=mXGirYDO/47jYxLFZgI8zXvbEK1doa1oJ4SX+k0FjXW0OrnCLVRyBjAogch2ofgpQItJ4evdnVMiugil/6H+viAzUqMkcROo8P/hR8o9Ag5cQQsEYbR+L05ag5Wozbrfa2FDFsJk6QZ7+8YCjMbIZh+yYTMl0sXpqqfsQH1V85zha8fYBtAlu68EluqZDZMP9iWN5+rYNePrzqeDg85aHT2HLaA0qXSty7zf4HyRClkZZBeA4Gosjt3TwBTHfDV9VwyPLdqLbYSsV8dJqsZOYylIvG3vYpZhAJS/6AD2KdrtUDZQbpAoJUZcX6+6PfoW1TMVfRgJdm0px/SHqZsIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D94qWpgoQjSqISkMGU8Dvk/asgABNX0bYDs40MJllc=;
 b=hyc1Vl3At/Zu+331OFM949d5GK8auPYx7Lp7hroZGFiKC63Y7cfuKZ/WACpvnnLxW7qivXbMDKZRWC3DgPIN+2JRfBeXcNgYIeN8PeWTWh0+ti5bSs0DDiRn8jciBCRk5Ln+wSJ5t1upmQQQ8WAoQckkuFFAfHT7m+fNHDqu+SQ=
Received: from CH0PR03CA0328.namprd03.prod.outlook.com (2603:10b6:610:118::14)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:26:24 +0000
Received: from CH01EPF000BE941.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::4d) by CH0PR03CA0328.outlook.office365.com
 (2603:10b6:610:118::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:26:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE941.mail.protection.outlook.com (10.167.244.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:26:24 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:26:22 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 27/28] drm/amd/display: [FW Promotion] Release 0.1.82.0
Date: Tue, 27 Oct 2026 17:17:23 -0600
Message-ID: <20261027232005.2879750-28-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE941:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e12c3a4-2b77-4789-6775-08df3481b76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|22082099003|261026121527099003|10067099003|3023799007|261022105027099003|56012099006|5023799004|11063799006|261021123027099003|261009223027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 1V2g3bSWk8W/teo1GIJoll08WAV7CO1rlpq7wGkU777dN0k8UGgmDbJOAV9ZT3ypoUnZcTA1SE9vOgd09JXEQmuHe7/Z0g2JllARTy9sq/d0MHfDiwdCLDX7vhWeA/z6C60HquEJVJczhBdQE9Nd/hjnOwgsEocTTY6F98xVfkWv/M/0bZBfHeUYbEOSzQbkm/2y1n83STFPZeRIFKEuAqevsdV6Vxy+ZqtlkjcEcF6NN7tbQbJMkMrUjqqHaP3Slm0xJMaDPOJGRKSM68Oreh9EGgXNvrPKJwrPm44waycOl9POQ2PPJSY9ODB0AFF1S3TxNEQIPfpd8rM85gCzn6+XlrPs5bP56GfgyOCUTx5RsfqewxZP9B+4rVwOv7iobFwcDgtJzP8/64LgrbxOvYKZI8K/KidHdbH99jbL3mRvxD15YaRQPvROzSG4I6dTT4Oc3s8F8f3oB5EBTHYFITY5r1Y/CdCAKB+jwUa9kjR+sxTosLjNMkGmnsmamdXl8N6mjB4wwxTfNT+eOR0H/EHY0jB815jiYK82I7vBpC7hPJTeLPWsw9hhSLjGG+6808yDYtveYItLfQjmdnTFzy1XBzxFzf7TNnyegNO2qQ23Ruus95SvX3KBTXu1DlRkZJMCFcX4LXdYTfOAHHuJbvbujfltizKPh9JPpteegE25JkwiLve4qIskaA333qqxxM1aW5PMm/ENR3SRwkBbTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(261026121527099003)(10067099003)(3023799007)(261022105027099003)(56012099006)(5023799004)(11063799006)(261021123027099003)(261009223027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zRms4LedLX0o9QuwZhcsQXJKPx1MPnaGgqQy3hSciYQg0uYg7nBHtBAv+EMMURIvLjBa77UEQdTHBIrldOnwNb4utTzrBVCSx46roHSvIdCw84bPIEN03zyPs+f65nMP8f7WGX+9Ya7l8xCmrhmWs9JXF9EAGG1kMsM3bQCM9SdcaGjcjSugjWPPTV63uBBORJrZJk5i94fKCxNs5PCtF8TsYpqFW326DGNt4z0G6AasylvBr6ZRxS99TLko5QrQ5lbXklZ34mUFg5R2joddcWtME3AG89zbNPSmAjCKpvgkAMsvl3bTmE2nOJbT5kKMeQI3t0T8cOOUB1zJYBgEhQ2YsstiRzfQZS3Iqo+I3LSgwKceLklKGasOfF6Gl+8lxKWW831Bczitu8Ddi76U9EyknooaX7gM864Zvyh8yLdgS4pH77/bOsQF9HbVdCue
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:26:24.2308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e12c3a4-2b77-4789-6775-08df3481b76f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

Updated DMUB interface
- Add per-plane TMZ ID to FAMS2 alternate stream dynamic state and
  drop the TMZ bit from the static state config
- Add IDLE_OPT_SET_Z8_ALLOW command to allow or disallow Z8

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 27723ccec6ac..8684b1398d4e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2627,6 +2627,8 @@ struct dmub_fams2_alternate_stream_dynamic_state {
 	uint8_t cursor_size[3]; //  Cursor array per plane for now - if we assume a single cursor, then we don't need an array
 	uint8_t disabled_pipe_mask; // bitmask of pipes with RECOUT_HEIGHT == 0 (disabled)
 	struct plane_pipe_rect pipe_viewports[4];
+	uint8_t tmz_id[3]; // TMZ ID per plane
+	uint8_t pad; // to maintain alignment
 	/* outputs: */
 	uint16_t subvp_start_line_a[3];
 	uint16_t subvp_height_a[3];
@@ -2697,7 +2699,6 @@ struct dmub_fams2_cmd_alternate_stream_static_state {
 			uint8_t vertical_access : 1; // vertical_access = 1 means 90 or 270 rotation
 			uint8_t access_direction : 1; // access_direction = 1 means bigger to smaller coordinations (e.g., scan from 2160 to 0 as opposed to regular 0 to 2160)
 			uint8_t dcc : 1;
-			uint8_t tmz : 1; // TODO: Need to assign outside of DML (DML not aware of TMZ)
 		} bits;
 		uint8_t all;
 	} config[3];
@@ -2986,6 +2987,11 @@ enum dmub_cmd_idle_opt_type {
 	 * DCN notify to release HW.
 	 */
 	 DMUB_CMD__IDLE_OPT_RELEASE_HW = 4,
+
+	/**
+	 * DCN allow or disallow Z8.
+	 */
+	DMUB_CMD__IDLE_OPT_SET_Z8_ALLOW = 5,
 };
 
 /**
@@ -3039,6 +3045,25 @@ struct dmub_rb_cmd_idle_opt_set_dc_power_state {
 	struct dmub_idle_opt_set_dc_power_state_data data;
 };
 
+/**
+ * union dmub_idle_opt_set_z8_allow_data - Data passed to FW in a DMUB_CMD__IDLE_OPT_SET_Z8_ALLOW command.
+ */
+union dmub_idle_opt_set_z8_allow_data {
+	struct {
+		uint32_t allow: 1; /**< 0: disallow Z8, 1: allow Z8 */
+		uint32_t reserved: 31; /**< Reserved for expansion; sender zeroes */
+	} bits; /**< bitfields */
+	uint32_t all; /**< union of all bitfields */
+};
+
+/**
+ * struct dmub_rb_cmd_idle_opt_set_z8_allow - Data passed to FW in a DMUB_CMD__IDLE_OPT_SET_Z8_ALLOW command.
+ */
+struct dmub_rb_cmd_idle_opt_set_z8_allow {
+	struct dmub_cmd_header header; /**< header */
+	union dmub_idle_opt_set_z8_allow_data data; /**< Z8 allow policy */
+};
+
 /**
  * struct dmub_clocks - Clock update notification.
  */
@@ -8017,6 +8042,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE command.
 	 */
 	struct dmub_rb_cmd_idle_opt_set_dc_power_state idle_opt_set_dc_power_state;
+	/**
+	 * Definition of a DMUB_CMD__IDLE_OPT_SET_Z8_ALLOW command.
+	 */
+	struct dmub_rb_cmd_idle_opt_set_z8_allow idle_opt_set_z8_allow;
 	/*
 	 * Definition of a DMUB_CMD__REPLAY_COPY_SETTINGS command.
 	 */
-- 
2.53.0

