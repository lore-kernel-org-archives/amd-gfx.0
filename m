Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052D6CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C0B10E7BB;
	Wed, 24 Sep 2025 18:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y93FFziZ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9F310E7B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9wS/1cD0kE60IT+OjlXoam63tMOjizJVcXp9PABN+jD8yreh8UlFgZVT0qgZ2mImE/0/rfHJyfGUb5NZLBEGwL/pV75ExtYmCuQWarVJ4NZaBb4FPHqLknyjklW8dyZI1sy5dGczx97AvMA5chOlUoRnKa61y8aOPHdhBJ1FzF++vxUZYeSUBHSIet8WqQE3QXfuXMf0r4cSFxc+LjFBYKtTALSuSSJUOa2oPU8Q8GzHWHllOQi/qRR5Pml8RaBWmM/SwNGI2LfSCjeMpauYkFB6pG3b7qGgjAomHRjsjO2+crBJwVKyR41y3nBgo5B3uSamhjc9dA9AeS1RSwh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZJTsNn8NAswBsK8LYzkB/nE1sQkXIRYhERU2+pAZM4=;
 b=F/BgdkFUCwuoj7C11yoYdA9IUdNfwOYTxde7c9hnYEXdj5y5ToU1EtpIDU2TyWvPvhLuRKcIBW7aI3m6Opmga97A6FnFLgKpq1UmMq/qKXQo4HlAJZuVe406NpmDKnPeDV4KbDd+68dqHMcTmE2urVDzXamN6gTQ3Fb/X+tp3/1KOIO9ogbZxV/lqEL3elXh2HJgXI9eQQzsbsa6C+W6QXhN6jLZigfot46rrgMl7wc9jqJcTG5/+vmPeRjDAJJgvjYVB0F/5EI+3vKIRQwUbJqXqB0C2K+VDyjugrL3apHeegIqt012qxYvE7rjGJNHPeHmwfchO2z/Ptj98LrWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZJTsNn8NAswBsK8LYzkB/nE1sQkXIRYhERU2+pAZM4=;
 b=Y93FFziZ3EkqnhlKxlJp7Gjj4msZwk9VC6ShyJe8ZJBDdu5Wg4uiHKKWNeGnHFnelUdfu9yzlUkjFaMljngMFfljOfzXdjNbTn8x/93CS2TPv5cV+ZQ3n19WMcRpLFr27MTa0Ku/M9GFANDpmxXkOXR8ptbnUru6p042GMyBCgc=
Received: from CH0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:610:b1::28)
 by IA0PPF002462CFE.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 24 Sep
 2025 18:22:58 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::d3) by CH0PR13CA0023.outlook.office365.com
 (2603:10b6:610:b1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 18:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 18:22:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:31 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Sep
 2025 13:22:31 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 11:22:30 -0700
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 09/10] drm/amd/display: [FW Promotion] Release 0.1.29.0
Date: Wed, 24 Sep 2025 14:22:00 -0400
Message-ID: <20250924182201.1049389-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924182201.1049389-1-Roman.Li@amd.com>
References: <20250924182201.1049389-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 390fe610-1b2c-46a5-5459-08ddfb976344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Inq57viDakPqWAT7RoTmFx0LgCX3C49hyLxbUe5NPmOoFZcCRpuy8Rv1Jb4k?=
 =?us-ascii?Q?+3MSnxw2m1FJyLyf+5vYzslr0NnqOTNQM3RpdBztgTTBH1tev6mR+WszuSKz?=
 =?us-ascii?Q?6bTAEt5sNahQ8jsw+Ew5sabSYMOwZMv46Ry+JZPLNmZa0PrGfffrDMbUniYd?=
 =?us-ascii?Q?e8iR8xfJbLXekYcQs5oSApH+pt0yRys/Op69og7nuh/4lkJorPK07QLEC4fr?=
 =?us-ascii?Q?/aeaJc8737dEBT+Ydp8CuNPpwDoqsVStr0z8c4saU138gpujdUf1NIZFwee7?=
 =?us-ascii?Q?utvIuG2qXoG68RDs+vQlGBU1j2Exfj8Q2ggxwgsXP68TkCFnZyNMz5M6es6T?=
 =?us-ascii?Q?YyY0LFr+gH6oUBxWMX6ibZ3PKRDyx4cr0KhfWByfvJGX66sJF4AmYJV6Lac/?=
 =?us-ascii?Q?WN8eh3MNzT9Zlwv7OrIlrOkExXHB6/zVhLCNisKW2pDnxMWdfR30hZPhMVr9?=
 =?us-ascii?Q?MrUUSAVZ1SdkgcVhrgifN0sCh7jEQ4ZCXrsc775h92UAi4CQKBe6+kdZbqn8?=
 =?us-ascii?Q?L4QYxk1j9NKTtCfrtXoQPDji3zAefj0sqRCgY2JWl4kQeLa3oVfy2qOp7geB?=
 =?us-ascii?Q?Oo6WoPHLJmrjUkNYexhOtuGw+4yeyiOBqydv0YqwT+xJflutymupDDAqPEx9?=
 =?us-ascii?Q?1sz48NK1E1ypPjxL8CU6l2+/17jkul6G9wFJ9MJJPzAAwBCFUyZaS4pKyr0T?=
 =?us-ascii?Q?qS+a2Pg1vB5d3Wb0Zq1wRuAOIvZ3IJcjxTV5HkqXiMVulsFvx8K6RfamoO3g?=
 =?us-ascii?Q?za/XXS81XdBRvhkYMqhKGrDV6GUTDXpQ8VrmYBzWpRJ1shKakiBCv9ir2SmN?=
 =?us-ascii?Q?KbPBPtCtZQLEZu7WaVuHGP/f08juUFXG61VHK7BZHA0A1qFCvcXXnrD3RQUK?=
 =?us-ascii?Q?5XHsn2wvDnObwIlTZfg6VXUfXjtP3BDRr1cqpZEfFFqsZwzTdGAfFygEXEPE?=
 =?us-ascii?Q?OAdfBoV3PPoEeEenIuKiExKSY5Iqj55BO6hZt4nF3bea6EOdFZhHjsAdRDhz?=
 =?us-ascii?Q?ful3zFCmd/YZ4eHyS0GaXBQM6edn0ZtZ/ec/IhiMOL8jVUvtxRrLzPFZChFF?=
 =?us-ascii?Q?W55dBYe1uAq1vx5VM0K7Amqet2Ge5TWL12Ok/tHr7uETUe8QHJDSD7R8IRPS?=
 =?us-ascii?Q?oxWsRmDYxqUOVsa/rYPDTF7nmthwwEhaisJ1i04OtV4cOt3nAUH3TweA5lMc?=
 =?us-ascii?Q?1XTna3ohHyFucBWlMbpBDpgaP8M3jpl7a2W5zGFerY5kutyfCnA0cZz6qhst?=
 =?us-ascii?Q?yu2gVf6bT0QxsVWqa7vtOYu3gay71DOP75cR4yr1I/whbE78dUkWOJ73jNZj?=
 =?us-ascii?Q?lR3bKV8BCQRvjkel5KvFsrmSybssKxea+l0Q3ElCCu+Wc1i39wxZe2okgoXX?=
 =?us-ascii?Q?2sAyjlJHZ70cisfPtv9w535C4OE0Xb+32flVK3tFdygXK3vhxQ5MgrE0iQDp?=
 =?us-ascii?Q?BmM7gUAGdEfVjJuLIra+G+TwYA4xGFMdSjwP+VEWs4d/VaBmvVz8njKkBJSu?=
 =?us-ascii?Q?mK9W4bbG0J+wtneiqSXwHVqAIvG8WsLpmn6C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:22:57.9795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390fe610-1b2c-46a5-5459-08ddfb976344
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE
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

Add new interface for offloading cursor programming to DMUB.

Acked-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 204 +++++++++++++++++-
 1 file changed, 203 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4e6290f19fe7..9d2a02bd00e2 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -629,6 +629,112 @@ struct dmub_visual_confirm_color {
 	uint16_t panel_inst;
 };
 
+/**
+ * struct dmub_cursor_offload_pipe_data_dcn30_v1 - DCN30+ per pipe data.
+ */
+struct dmub_cursor_offload_pipe_data_dcn30_v1 {
+	uint32_t CURSOR0_0_CURSOR_SURFACE_ADDRESS;
+	uint32_t CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH;
+	uint32_t CURSOR0_0_CURSOR_SIZE__CURSOR_WIDTH : 16;
+	uint32_t CURSOR0_0_CURSOR_SIZE__CURSOR_HEIGHT : 16;
+	uint32_t CURSOR0_0_CURSOR_POSITION__CURSOR_X_POSITION : 16;
+	uint32_t CURSOR0_0_CURSOR_POSITION__CURSOR_Y_POSITION : 16;
+	uint32_t CURSOR0_0_CURSOR_HOT_SPOT__CURSOR_HOT_SPOT_X : 16;
+	uint32_t CURSOR0_0_CURSOR_HOT_SPOT__CURSOR_HOT_SPOT_Y : 16;
+	uint32_t CURSOR0_0_CURSOR_DST_OFFSET__CURSOR_DST_X_OFFSET : 13;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_ENABLE : 1;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_MODE : 3;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY : 1;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_PITCH : 2;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_LINES_PER_CHUNK : 5;
+	uint32_t reserved0[4];
+	uint32_t CNVC_CUR0_CURSOR0_CONTROL__CUR0_ENABLE : 1;
+	uint32_t CNVC_CUR0_CURSOR0_CONTROL__CUR0_MODE : 3;
+	uint32_t CNVC_CUR0_CURSOR0_CONTROL__CUR0_EXPANSION_MODE : 1;
+	uint32_t CNVC_CUR0_CURSOR0_CONTROL__CUR0_ROM_EN : 1;
+	uint32_t CNVC_CUR0_CURSOR0_COLOR0__CUR0_COLOR0 : 24;
+	uint32_t CNVC_CUR0_CURSOR0_COLOR1__CUR0_COLOR1 : 24;
+	uint32_t CNVC_CUR0_CURSOR0_FP_SCALE_BIAS__CUR0_FP_BIAS : 16;
+	uint32_t CNVC_CUR0_CURSOR0_FP_SCALE_BIAS__CUR0_FP_SCALE, : 16;
+	uint32_t reserved1[5];
+	uint32_t HUBPREQ0_CURSOR_SETTINGS__CURSOR0_DST_Y_OFFSET : 8;
+	uint32_t HUBPREQ0_CURSOR_SETTINGS__CURSOR0_CHUNK_HDL_ADJUST : 8;
+	uint32_t reserved2[3];
+};
+
+/**
+ * struct dmub_cursor_offload_pipe_data_dcn401_v1 - DCN401 per pipe data.
+ */
+struct dmub_cursor_offload_pipe_data_dcn401_v1 {
+	uint32_t CURSOR0_0_CURSOR_SURFACE_ADDRESS;
+	uint32_t CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH;
+	uint32_t CURSOR0_0_CURSOR_SIZE__CURSOR_WIDTH : 16;
+	uint32_t CURSOR0_0_CURSOR_SIZE__CURSOR_HEIGHT : 16;
+	uint32_t CURSOR0_0_CURSOR_POSITION__CURSOR_X_POSITION : 16;
+	uint32_t CURSOR0_0_CURSOR_POSITION__CURSOR_Y_POSITION : 16;
+	uint32_t CURSOR0_0_CURSOR_HOT_SPOT__CURSOR_HOT_SPOT_X : 16;
+	uint32_t CURSOR0_0_CURSOR_HOT_SPOT__CURSOR_HOT_SPOT_Y : 16;
+	uint32_t CURSOR0_0_CURSOR_DST_OFFSET__CURSOR_DST_X_OFFSET : 13;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_ENABLE : 1;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_MODE : 3;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY : 1;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_PITCH : 2;
+	uint32_t CURSOR0_0_CURSOR_CONTROL__CURSOR_LINES_PER_CHUNK : 5;
+	uint32_t reserved0[4];
+	uint32_t CM_CUR0_CURSOR0_CONTROL__CUR0_ENABLE : 1;
+	uint32_t CM_CUR0_CURSOR0_CONTROL__CUR0_MODE : 3;
+	uint32_t CM_CUR0_CURSOR0_CONTROL__CUR0_EXPANSION_MODE : 1;
+	uint32_t CM_CUR0_CURSOR0_CONTROL__CUR0_ROM_EN : 1;
+	uint32_t CM_CUR0_CURSOR0_COLOR0__CUR0_COLOR0 : 24;
+	uint32_t CM_CUR0_CURSOR0_COLOR1__CUR0_COLOR1 : 24;
+	uint32_t CM_CUR0_CURSOR0_FP_SCALE_BIAS_G_Y__CUR0_FP_BIAS_G_Y : 16;
+	uint32_t CM_CUR0_CURSOR0_FP_SCALE_BIAS_G_Y__CUR0_FP_SCALE_G_Y, : 16;
+	uint32_t CM_CUR0_CURSOR0_FP_SCALE_BIAS_RB_CRCB__CUR0_FP_BIAS_RB_CRCB : 16;
+	uint32_t CM_CUR0_CURSOR0_FP_SCALE_BIAS_RB_CRCB__CUR0_FP_SCALE_RB_CRCB : 16;
+	uint32_t reserved1[4];
+	uint32_t HUBPREQ0_CURSOR_SETTINGS__CURSOR0_DST_Y_OFFSET : 8;
+	uint32_t HUBPREQ0_CURSOR_SETTINGS__CURSOR0_CHUNK_HDL_ADJUST : 8;
+	uint32_t HUBP0_DCHUBP_MALL_CONFIG__USE_MALL_FOR_CURSOR : 1;
+	uint32_t reserved2[3];
+};
+
+/**
+ * struct dmub_cursor_offload_pipe_data_v1 - Per pipe data for cursor offload.
+ */
+struct dmub_cursor_offload_pipe_data_v1 {
+	union {
+		struct dmub_cursor_offload_pipe_data_dcn30_v1 dcn30; /**< DCN30 cursor data. */
+		struct dmub_cursor_offload_pipe_data_dcn401_v1 dcn401; /**< DCN401 cursor data. */
+		uint8_t payload[96]; /**< Guarantees the cursor pipe data size per-pipe. */
+	};
+};
+
+/**
+ * struct dmub_cursor_offload_payload_data_v1 - A payload of stream data.
+ */
+struct dmub_cursor_offload_payload_data_v1 {
+	uint32_t write_idx_start; /**< Write index, updated before pipe_data is written. */
+	uint32_t write_idx_finish; /**< Write index, updated after pipe_data is written. */
+	uint32_t pipe_mask; /**< Mask of pipes to update. */
+	uint32_t reserved; /**< Reserved for future use. */
+	struct dmub_cursor_offload_pipe_data_v1 pipe_data[6]; /**< Per-pipe cursor data. */
+};
+
+/**
+ * struct dmub_cursor_offload_stream_v1 - Per-stream data for cursor offload.
+ */
+struct dmub_cursor_offload_stream_v1 {
+	struct dmub_cursor_offload_payload_data_v1 payloads[4]; /**< A small buffer of cursor payloads. */
+	uint32_t write_idx; /**< The index of the last written payload. */
+};
+
+/**
+ * struct dmub_cursor_offload_v1 - Cursor offload feature state.
+ */
+struct dmub_cursor_offload_v1 {
+	struct dmub_cursor_offload_stream_v1 offload_streams[6]; /**< Per-stream cursor offload data */
+};
+
 //==============================================================================
 //</DMUB_TYPES>=================================================================
 //==============================================================================
@@ -648,7 +754,8 @@ struct dmub_visual_confirm_color {
 union dmub_fw_meta_feature_bits {
 	struct {
 		uint32_t shared_state_link_detection : 1; /**< 1 supports link detection via shared state */
-		uint32_t reserved : 31;
+		uint32_t cursor_offload_v1_support: 1; /**< 1 supports cursor offload */
+		uint32_t reserved : 30;
 	} bits; /**< status bits */
 	uint32_t all; /**< 32-bit access to status bits */
 };
@@ -813,6 +920,28 @@ enum dmub_ips_comand_type {
 	DMUB_CMD__IPS_QUERY_RESIDENCY_INFO = 1,
 };
 
+/**
+ * enum dmub_cursor_offload_comand_type - Cursor offload subcommands.
+ */
+enum dmub_cursor_offload_comand_type {
+	/**
+	 * Initializes the cursor offload feature.
+	 */
+	DMUB_CMD__CURSOR_OFFLOAD_INIT = 0,
+	/**
+	 * Enables cursor offloading for a stream and updates the timing parameters.
+	 */
+	DMUB_CMD__CURSOR_OFFLOAD_STREAM_ENABLE = 1,
+	/**
+	 * Disables cursor offloading for a given stream.
+	 */
+	DMUB_CMD__CURSOR_OFFLOAD_STREAM_DISABLE = 2,
+	/**
+	 * Programs the latest data for a given stream.
+	 */
+	DMUB_CMD__CURSOR_OFFLOAD_STREAM_PROGRAM = 3,
+};
+
 /**
  * union dmub_fw_boot_options - Boot option definitions for SCRATCH14
  */
@@ -877,6 +1006,7 @@ enum dmub_shared_state_feature_id {
 	DMUB_SHARED_SHARE_FEATURE__IPS_FW = 1,
 	DMUB_SHARED_SHARE_FEATURE__IPS_DRIVER = 2,
 	DMUB_SHARED_SHARE_FEATURE__DEBUG_SETUP = 3,
+	DMUB_SHARED_STATE_FEATURE__CURSOR_OFFLOAD_V1 = 4,
 	DMUB_SHARED_STATE_FEATURE__LAST, /* Total number of features. */
 };
 
@@ -957,6 +1087,22 @@ struct dmub_shared_state_ips_driver {
 	uint32_t reserved[61]; /**< Reversed, to be updated when adding new fields. */
 }; /* 248-bytes, fixed */
 
+/**
+ * struct dmub_shared_state_cursor_offload_v1 - Header metadata for cursor offload.
+ */
+struct dmub_shared_state_cursor_offload_stream_v1 {
+	uint32_t last_write_idx; /**< Last write index */
+	uint8_t reserved[28]; /**< Reserved bytes. */
+}; /* 32-bytes, fixed */
+
+/**
+ * struct dmub_shared_state_cursor_offload_v1 - Header metadata for cursor offload.
+ */
+struct dmub_shared_state_cursor_offload_v1 {
+	struct dmub_shared_state_cursor_offload_stream_v1 offload_streams[6]; /**< stream state, 32-bytes each */
+	uint8_t reserved[56]; /**< reserved for future use */
+}; /* 248-bytes, fixed */
+
 /**
  * enum dmub_shared_state_feature_common - Generic payload.
  */
@@ -983,6 +1129,7 @@ struct dmub_shared_state_feature_block {
 		struct dmub_shared_state_ips_fw ips_fw; /**< IPS firmware state */
 		struct dmub_shared_state_ips_driver ips_driver; /**< IPS driver state */
 		struct dmub_shared_state_debug_setup debug_setup; /**< Debug setup */
+		struct dmub_shared_state_cursor_offload_v1 cursor_offload_v1; /**< Cursor offload */
 	} data; /**< Shared state data. */
 }; /* 256-bytes, fixed */
 
@@ -1572,6 +1719,14 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__IPS = 91,
 
+	/**
+	 * Command type use for Cursor offload.
+	 */
+	DMUB_CMD__CURSOR_OFFLOAD = 92,
+
+	/**
+	 * Command type use for VBIOS shared commands.
+	 */
 	DMUB_CMD__VBIOS = 128,
 };
 
@@ -4664,6 +4819,7 @@ enum hw_lock_client {
 	 */
 	HW_LOCK_CLIENT_REPLAY		= 4,
 	HW_LOCK_CLIENT_FAMS2 = 5,
+	HW_LOCK_CLIENT_CURSOR_OFFLOAD = 6,
 	/**
 	 * Invalid client.
 	 */
@@ -6075,6 +6231,40 @@ struct dmub_rb_cmd_ips_query_residency_info {
 	struct dmub_cmd_ips_query_residency_info_data info_data;
 };
 
+/**
+ * struct dmub_cmd_cursor_offload_init_data - Payload for cursor offload init command.
+ */
+struct dmub_cmd_cursor_offload_init_data {
+	union dmub_addr state_addr; /**< State address for dmub_cursor_offload */
+	uint32_t state_size; /**< State size for dmub_cursor_offload */
+};
+
+/**
+ * struct dmub_rb_cmd_cursor_offload_init - Data for initializing cursor offload.
+ */
+struct dmub_rb_cmd_cursor_offload_init {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_cursor_offload_init_data init_data;
+};
+
+/**
+ * struct dmub_cmd_cursor_offload_stream_data - Payload for cursor offload stream command.
+ */
+struct dmub_cmd_cursor_offload_stream_data {
+	uint32_t otg_inst: 4; /**< OTG instance to control  */
+	uint32_t reserved: 28; /**< Reserved for future use */
+	uint32_t line_time_in_ns; /**< Line time in ns for the OTG */
+	uint32_t v_total_max; /**< OTG v_total_max */
+};
+
+/**
+ * struct dmub_rb_cmd_cursor_offload_stream_cntl - Controls a stream for cursor offload.
+ */
+struct dmub_rb_cmd_cursor_offload_stream_cntl {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_cursor_offload_stream_data data;
+};
+
 /**
  * union dmub_rb_cmd - DMUB inbox command.
  */
@@ -6404,6 +6594,18 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_ips_residency_cntl ips_residency_cntl;
 
 	struct dmub_rb_cmd_ips_query_residency_info ips_query_residency_info;
+	/**
+	 * Definition of a DMUB_CMD__CURSOR_OFFLOAD_INIT command.
+	 */
+	struct dmub_rb_cmd_cursor_offload_init cursor_offload_init;
+	/**
+	 * Definition of a DMUB_CMD__CURSOR_OFFLOAD control commands.
+	 * - DMUB_CMD__CURSOR_OFFLOAD_STREAM_ENABLE
+	 * - DMUB_CMD__CURSOR_OFFLOAD_STREAM_DISABLE
+	 * - DMUB_CMD__CURSOR_OFFLOAD_STREAM_PROGRAM
+	 * - DMUB_CMD__CURSOR_OFFLOAD_STREAM_UPDATE_DRR
+	 */
+	struct dmub_rb_cmd_cursor_offload_stream_cntl cursor_offload_stream_ctnl;
 };
 
 /**
-- 
2.34.1

