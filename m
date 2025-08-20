Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60D0CA0FE1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92B410E7EB;
	Wed, 20 Aug 2025 20:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ad3Vqm2n";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3801410E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdbbwAPycMvkiONq7BN25tF7V//FpdESGnrs+tIeFkhPlcCBXX4k+3uarHWc5oduGpLRMCXPVv9Q+s4n44k82Hor+Vm550qIc3n6DRYlr/1LjwzhoXKhKweYYRxIR/2R9QLJNaqbmNsFvaa68cKQCZr76FYMBPua6DYH/kKhLWHnnhx55Sk3afDctW5K9Pf0dyxV5SDGcv0Vh4p7cjXT7vCOixJTuU/OnlidgoESmxk2xuqf3XdalcJ9zLjfPGrKOhc5Dl6p5tWmG4hqUjME/nkwBj++ODtAWFXuWKkyfyAIvWPxruIM/2uKq05UiMxsAcTJeRU9uh9CO7MSoEGRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGl/gjNsSYlb49NduGoNScn25tq/iCGfon/4wYAet+0=;
 b=pZ4cIWmSjvxZOvXvIL5n3LQVSBbJ6w7GtMa5S7FZDXHW9e8M3VJKt5IxqWtpbmUl6ZLDs91JiuLJjDlrav20VV/unMgs6UNgTHn/3vf0jqe3hd0pWAUz9o//0GoHQOM61AEM4tuW8uDo6ztky+YonUlkid7e5UyLBLmS7Eh9yWt/KBDZakitX3sQeDj9SfWDrAqq5VP+qSjzJy3sRTtRJmlzkGg2nsnprBI7YyaNqms/b+vaVO8TDcvUfiVylXy+YU9VgrLo9HCWAHikNj+BoBOmXpiR0LZWk3cHIW/F/cPO2pshuK1Cw2xmx6ZtPVLdkE4QMthXvIjnOonh49wrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGl/gjNsSYlb49NduGoNScn25tq/iCGfon/4wYAet+0=;
 b=Ad3Vqm2nm+a/9Sf9mObg1h5+z/5ISognc2RRaksQOePuh/Mc0RHcxUFISF4eYhQiWfaTNez9RYxU9pig2nbetGmaYdZLt0Nq5nim5F02zvluaKJKkklQwersPVPZGevbFYBr+M0O+Fx/tKfQDGQK2Kz85EyOJsAQkuMmUu8kqU4=
Received: from DM6PR06CA0065.namprd06.prod.outlook.com (2603:10b6:5:54::42) by
 SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 20:21:11 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::3b) by DM6PR06CA0065.outlook.office365.com
 (2603:10b6:5:54::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 13:21:05 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 02/12] drm/amd/display: Reserve instance index notified by DMUB
Date: Wed, 20 Aug 2025 16:19:52 -0400
Message-ID: <20250820202103.1122706-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d7e82c-8492-4f5e-e5cf-08dde0271a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BYKBCgdgJcjpAHO2RMqjfqjnZ2VcQ0QshhiA+2PaRAOFvKu92u3ldqway907?=
 =?us-ascii?Q?TG4IPS0PTrBecmtL8Q5d9DIIAw02ZpSfurfDpewA1Ith+Q8lLdtBWI+bBZDD?=
 =?us-ascii?Q?pfPIqt/LeBYtcfUm8grGqB7QUSk1czCsGVRGwWZMFsTEHQT5iVgZa2m+fN3X?=
 =?us-ascii?Q?K9t1W54fkr+w2VfA3ZzZF3OL0aw9wYz5rsnuoPFhTGkH/kl+Yqn/PZ0wLNcJ?=
 =?us-ascii?Q?KU3tJAkcs8AnNvq0JksVhRj3wYNnNS57e3lMu8zdmUK2yGW1uaFJOvbENZSM?=
 =?us-ascii?Q?Tp2JWY47JXkodCiBn4ZfE8UTEZ3uHHpletD0NJnaMoAwDUpRCKXTcnZEhb0d?=
 =?us-ascii?Q?D/kHNp5wES/M1kasF4h2axvZkNl8Y4h4ZqRrZPkZREysWsx58moQRbrUQc7b?=
 =?us-ascii?Q?KxFM/9x64neW1azh+xo1yARhJufIND7PHHViu8O49AF7rgORlhkkjFWfJNH1?=
 =?us-ascii?Q?47iEW3PVb0aWGThVS5yTDshgQwmZvUquz9Xmgxurw5IPF/AbzqcUYtzYvmZV?=
 =?us-ascii?Q?WB5gWjTaQ77q82q2a2hMguwvzfbT/sND9NTVHBJSbz7EzzCPuVjm5XrAeJq9?=
 =?us-ascii?Q?Es4h8UYg+CEBMbc49pcW1TLQ+kPJSd9wqQnhdrHuCeymRziK94f6aLJHI1oo?=
 =?us-ascii?Q?smX3XQwaGLOiDO8HnhvNWuoZYxYm5PGF5YA3dDe7Z97ObGXc69fPFlL+WXEG?=
 =?us-ascii?Q?E6zHM5H4ci4fjnApKRR7kF9dD34KUiasmx+4Ps2kUbE1dzG+RVvvajr2Mvos?=
 =?us-ascii?Q?ZKTMD0IVNuvLco8bDWKSe0fd6GHI0NF5xHkV8ZkZJeAfJZVb6nQd3mMrOPSe?=
 =?us-ascii?Q?2o6H1Jzfty47BaEJ46gYEQAuGZMp6a0pdqfXlYWKYdBGLYWBuPsDJbiVWeyZ?=
 =?us-ascii?Q?QR+sW2u6MEfQczQC+2lxkw+9EXheD6Tyi4mc3rBTsA69wFQuyn9sTzlO26R2?=
 =?us-ascii?Q?x4WDgMs2CEEwg2En3lZ3LheRgEYlHxj7VXRlQoh4of2SgJ6DiOwxfc6NbXEJ?=
 =?us-ascii?Q?GPUyK3TgbCF0DeqdfWxFLWz2Gb7UnmCjCevjsGEcUhjW+3TxH3fFlvHy1yhI?=
 =?us-ascii?Q?nKvqWH5HmadzXP1EnscaNUlYWFAdfkZkAe63WtyXFyqwoJ7cskbZb9Im5VxW?=
 =?us-ascii?Q?MGJWFg3TvBWVWmO9LJUcciZPQQ4B3wkWw53GMeVlPVC/X5X0MR8CynZ1qfy6?=
 =?us-ascii?Q?PigOiNwVF63HOTdkbYL1eVzOa0eyJ+X1qZv2ynWZUoO/J3MGkgI87C0DUwXW?=
 =?us-ascii?Q?i9LrqSULZl802eGqIDIDrYL50/KuvYRKCF8dxQKHNTFP90R8F35UQk4Yws9M?=
 =?us-ascii?Q?hjiJ+xAgNIvGx+wV7Q6R+zWPVo/EvxHlUNxaOBwYRS2AiMHPW7x8Ip01pjX4?=
 =?us-ascii?Q?pQ/Ne0wQELdUqBefa4lU+kjNQid/1mF25y2HwD7hXo38tHMyiKK9Q6L3o5hj?=
 =?us-ascii?Q?crhMomxjWBvT6ig1Xb+oZ5R4XFHNO9EeaRN7ijzQbjCW474DWb5lAZ1NVJPd?=
 =?us-ascii?Q?UfUCUVLFwOIHsEm25mMm4ZOXJ3rNJ9RgsXba?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:10.5963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d7e82c-8492-4f5e-e5cf-08dde0271a58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238
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

From: Cruise Hung <Cruise.Hung@amd.com>

[Why]
Reserve instance index notified by DMUB.

[How]
Add new variable for instance index.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c        | 2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h          | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c | 8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
index fe9f99f1bdf9..f976ffd6d466 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
@@ -65,7 +65,7 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
 	    notify->type == DMUB_NOTIFICATION_DPIA_NOTIFICATION ||
 	    notify->type == DMUB_NOTIFICATION_SET_CONFIG_REPLY) {
 		notify->link_index =
-			get_link_index_from_dpia_port_index(dc, notify->link_index);
+			get_link_index_from_dpia_port_index(dc, notify->instance);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 87b761ac3135..7abf7d0fd02b 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -598,6 +598,8 @@ struct dmub_notification {
 	enum dmub_notification_type type;
 	uint8_t link_index;
 	uint8_t result;
+	/* notify instance from DMUB */
+	uint8_t instance;
 	bool pending_notification;
 	union {
 		struct aux_reply_data aux_reply;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index 567c5b1aeb7a..e7a58b140388 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -71,7 +71,7 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 	switch (cmd.cmd_common.header.type) {
 	case DMUB_OUT_CMD__DP_AUX_REPLY:
 		notify->type = DMUB_NOTIFICATION_AUX_REPLY;
-		notify->link_index = cmd.dp_aux_reply.control.instance;
+		notify->instance = cmd.dp_aux_reply.control.instance;
 		notify->result = cmd.dp_aux_reply.control.result;
 		dmub_memcpy((void *)&notify->aux_reply,
 			(void *)&cmd.dp_aux_reply.reply_data, sizeof(struct aux_reply_data));
@@ -84,17 +84,17 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 			notify->type = DMUB_NOTIFICATION_HPD_IRQ;
 		}
 
-		notify->link_index = cmd.dp_hpd_notify.hpd_data.instance;
+		notify->instance = cmd.dp_hpd_notify.hpd_data.instance;
 		notify->result = AUX_RET_SUCCESS;
 		break;
 	case DMUB_OUT_CMD__SET_CONFIG_REPLY:
 		notify->type = DMUB_NOTIFICATION_SET_CONFIG_REPLY;
-		notify->link_index = cmd.set_config_reply.set_config_reply_control.instance;
+		notify->instance = cmd.set_config_reply.set_config_reply_control.instance;
 		notify->sc_status = cmd.set_config_reply.set_config_reply_control.status;
 		break;
 	case DMUB_OUT_CMD__DPIA_NOTIFICATION:
 		notify->type = DMUB_NOTIFICATION_DPIA_NOTIFICATION;
-		notify->link_index = cmd.dpia_notification.payload.header.instance;
+		notify->instance = cmd.dpia_notification.payload.header.instance;
 		break;
 	case DMUB_OUT_CMD__HPD_SENSE_NOTIFY:
 		notify->type = DMUB_NOTIFICATION_HPD_SENSE_NOTIFY;
-- 
2.50.1

