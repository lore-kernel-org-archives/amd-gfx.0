Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C28CD5BD5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E791910E457;
	Tue, 26 May 2026 07:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pz2tL4nm";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010064.outbound.protection.outlook.com
 [52.101.193.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CF810E457
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huVYHfUfZjGnieyDw2cG1ZVVOOB6vlY7dbvxZ5EyF6qlQxz+xTtQTOy/LlBBl+Nec+kGvNH50dcW2vpM+h9AQZ7we3TnXwS6sKXw76heGpzopLfxH8yHeVjOq/z8ZIMFD1V9s/1+DhlXz5qXInZhbUOj1EMk4izxAGgv5kR0w8YklxOwxgPlW0D8zvh8RcsRclY4L7f0/AUXsr4RuzZ2bumzp6Q6jnYbkP/DSZRgSLgcpit3R3vN49vKFhWJJYJcWpI8HdmKllO4omlZmamujza7ij+f7sEB6V+7MoaunxYZT+qWmVvy3JX1nIgX1tPXu9xknLjvUnUKny/4TjhntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS46AgnUomurYTmFO0xn6T2VsIJULlGW9SF11gnow1I=;
 b=BUuU6+TEAzL9uY3ogmeBfTLrw7d26oDaqCSps/q/9qjATUyEdMfHH+9C10/DfcP7nHgpgvL8BUktxi8SfKTN31pRJfK1jIu48MkwX+C8tDo5/LUf/lSmpbCUtRyO/ZpBQhhdwaBKCm8VUpWHv4gef0hOGWBvVe/KNQw56rD3JrVNOw51BruLDqtceZgpxMjwsSAXDS8SResNRulpHCGcA3YnX8Lzv9C8UkEmVYwlc3RV3rDwciyoTJgjHxwGleFu3BstPCnmzIp08bHTox6nqQgD3RBw+1jFHktUxo3PFEOyHnsUZEZoUGMVW3ViR1ylHM7ZTeCXEb5/PvNytCUYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS46AgnUomurYTmFO0xn6T2VsIJULlGW9SF11gnow1I=;
 b=pz2tL4nmgsz0DvyV5c7FgBBSJzoAcr8Hf2hxUepBrhsH1EvNi8SzX5P5f7mkZ60lSUI0vi7eLXljGo5V/e1ummmWoW6CVg+ZL5MV03WeTytfH932eZbk0fY1vZCE9yNRcZO+9D61VumdQOu0duRGbin5KKe7rnFQfoPA/gl50Bg=
Received: from CYZPR10CA0010.namprd10.prod.outlook.com (2603:10b6:930:8a::23)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:14:54 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::45) by CYZPR10CA0010.outlook.office365.com
 (2603:10b6:930:8a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:14:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:14:52 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:14:43 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chuntao Tso <chuntao.tso@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 04/41] drm/amd/display: Enable frame skipping in 0x37B
Date: Tue, 26 May 2026 15:01:27 +0800
Message-ID: <20260526071413.2181251-5-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: d25e1359-4928-4048-79a2-08debaf67ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|22082099003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: xGYyYZFwKHhN+33BWlc804itWn741W5NVU+YJKnQSDRVY21Pbh4pTTqyVJ0sulFESMYcImg7xOFCukoFrpItN2FSzNrkpW2GK/H5gVuic5uSMj2jJ3ZJpMICOkTU04Z6vbsuUHlXIWC5vMEjFbO8qyI7ho5f8LJ2RnEwkQkoNQ8hKbsirYVhAH0g23v1yF+fT35P0vFnXTZilyLmpLH5VRC4HwQDlQUSwr1RNVx2Eu8U6waDB8QEYQMnvVafxZQ5351xoaXa0IbnLxyew/3KG8p1e3iBB3ItRtsyR40sGOGKpCkrMvOvee9Tz9VOOtyYoKfeG+2B6GvfxyOgpqimfA9KnCXW24NpEKh9p/WWYQ4CTlhPxFIfgGRQCPa/RQdfeQCTOO5UNhKXMws4Sqg+RJk/aklDTtFoJknkTsq+5b77Bhk8Ch/v027Jd7s/VKV/dkSug7w4R5z3LutQeJlPPejwow79HC4Fetm4Y8QdWOn+FJa6qUcsibGB4xYl/cevvgVtHFjlfcTGnBBvz8P2KATRjKc1BQcRNshTJfD78l+oOwWZ9tsxFa7eihBhaZTc1tOH8MW1Q5Tr+KRL+2zMM43zt3W+rDMbk5xZ5OyjLAPoaPqE86rb4icsbHsjJbwtZpd6utFxTa8jro7K/XmQivxu7VmRUFO8gqq17iMMB75mIe1BeAm4lABb27s5aJrDHmocb+CTci82GO2Mk4mCb2lXFiMl+qebM+S/LPlnKbY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003)(6133799003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mZhIlxdSqxWzpU3SHJUE2Bb6jtqgtHjpP8/D4X/uiXPrNCgxstmtSmdh9eKsfVETgEwWjO61EOgnHpNc4jVjPnuO3DatsW+Cq3lHj3rUW4vYmut6b+XpNrEhamgnMg5aV1sJYRHTdOiNfYV67EPaA2NQ9Kz0FPTTEbKDdNh6Zgd8LAE8JLgQX5PoRmkuUrKK4EpUADfs3WVRxZz4SbwM1kMgCbFgy45csCkihnTQ0cgtEfl27txaTte41IMh2jOUtNEO0ZZhvQ/nBgh0Te8GiTcToZ6WAJ3IRDo26KSl8mzXtklZXmQuGrMhFHcA9BsYa4H+kkYlXYXq281HNqfIDyONKWEnlWrUm3KSX5cQY8blr4Jw/k4S1gUFhHJdGm6W/ODEDWmzBL9tftZgg9Gqkvh04VRs9cri6M2G4Nkxv2zQhoEyroY2EPe7PDuZhtMV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:14:53.1412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25e1359-4928-4048-79a2-08debaf67ba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
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

From: Chuntao Tso <chuntao.tso@amd.com>

[Why & How]
Enable frame skipping in 0x37B

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Chuntao Tso <chuntao.tso@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                 | 5 ++++-
 .../amd/display/dc/link/protocols/link_edp_panel_control.c   | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 7fa336bf1115..7e5c118b2f20 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1363,7 +1363,10 @@ union replay_enable_and_configuration {
 		unsigned char FREESYNC_PANEL_REPLAY_MODE              :1;
 		unsigned char TIMING_DESYNC_ERROR_VERIFICATION        :1;
 		unsigned char STATE_TRANSITION_ERROR_DETECTION        :1;
-		unsigned char RESERVED                                :5;
+		unsigned char FSFT_ENABLED                            :1;
+		unsigned char FRAME_SKIPPING_ERROR_DETECTION          :1;
+		unsigned char FRAME_SKIPPING_ENABLE                   :1;
+		unsigned char RESERVED                                :2;
 	} bits;
 	unsigned char raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index e06a9ac65286..3db4f10d1654 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1052,6 +1052,8 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 		replay_config.bits.FREESYNC_PANEL_REPLAY_MODE = 1;
 		replay_config.bits.TIMING_DESYNC_ERROR_VERIFICATION = 0;
 		replay_config.bits.STATE_TRANSITION_ERROR_DETECTION = 1;
+		replay_config.bits.FRAME_SKIPPING_ERROR_DETECTION = 1;
+		replay_config.bits.FRAME_SKIPPING_ENABLE = 1;
 		dm_helpers_dp_write_dpcd(link->ctx, link,
 			DP_SINK_PR_ENABLE_AND_CONFIGURATION,
 			(uint8_t *)&(replay_config.raw), sizeof(uint8_t));
-- 
2.43.0

