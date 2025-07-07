Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC35C71130
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B3DA10E55D;
	Mon,  7 Jul 2025 19:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zHu78mZ4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA70D10E55D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZB7yffAIXWW4L3ObtS9NrmBKx6c7vFca63s0TIIC4eO+cR4Rhfm1XP2+PQmmC/G5KF+scyS17C1V8JtEJajwYQjp9pByL+STNje2C6WZ5IAuOzNOws5cuI3NEIvkP1bjAu3aDDX2i321gtxmH1tJXgTYZNpUOQf8HF/+Cw2DsNGoW51kX7bUXHXp/dra21hD6bOJsvlwm+XMgDtjyxSAiD6nNkSOlOqfcURzVEi0XPJLvhRIRfEHriwL06doRytbDY0k9q237IK5eh+ILplmXnFEBTabStkE5yVhQdee9y/AV/G89aKrUfdN0utUcmq5eDzcLUffu8jY7PckW6fVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg+X7FCgoRyB3MKbuBIdkCsV1jN0bQ9NVd/0dCWOiJA=;
 b=xG8cMAio3TO6IIx2Ehxsg9qK/t5cjIVYbloOsZ29tzIYxHXqWW5YqYhdmrUiABtFT8ms65BZVgJ+rqkuqyYrdeW4hzOTZFMQ+DTUg36GAqxCP90DYvHaB5bTYG08J6z+9OJL3slYs/505abAHV/TThYnuoXcuarpVOdsR4SiNP/4/DGBkDiXx+jhM1itvYv+NGRKjEO3T8EhaYcWoz061SI9BYOjN9mxpiHgZMrTAa+iQYjLRObLIyR1RiCACZ8ifEWEYICHZlHh3QjlN2guW65/1BdIYcrKT0/obrbifBy1z4lueZFx4Zc2ZnSsn7BZGTBT0mcklJNVxSJOIcqa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg+X7FCgoRyB3MKbuBIdkCsV1jN0bQ9NVd/0dCWOiJA=;
 b=zHu78mZ4Dfc0gbXFvGnuKnMXdaMr75YMCupbEIhF2bcNuOnjxJ6xXr6nNy+YZ4rLTfwJvRaEGRkLV+F6xNolxqNF36gpZSIaxtxVL44rieRalsKgi1vd8hGw3K16/gCXTnhFlhnI3/pyM48pX6GMdFkHb5sCm3XNssF8E0VZZsg=
Received: from PH1PEPF00013308.namprd07.prod.outlook.com (2603:10b6:518:1::15)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Mon, 7 Jul
 2025 19:44:50 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH1PEPF00013308.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:44:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:48 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 14:44:47 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Fudongwang
 <Fudong.Wang@amd.com>, Charlene Liu <charlene.liu@amd.com>, Jun Lei
 <jun.lei@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 05/17] drm/amd/display: Monitor patch to ignore EDID audio SAB
 check
Date: Mon, 7 Jul 2025 15:41:25 -0400
Message-ID: <20250707194358.1185190-6-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
References: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: dd420976-b214-496c-cc4a-08ddbd8ebbf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lNtVAfVtA18IrWmY0bh9HmCldDq1RB0vxgjzOJ6jk6sa7weEUcsATkmnyH7J?=
 =?us-ascii?Q?vi2sOa+3m7uLnYxgRRhcyNCJi6Ie6Zv6XZDWJ7o6Cfm0Yby0mf9Qs0CFIRbZ?=
 =?us-ascii?Q?QnLHA4rUtpfAflyDi7I9XZKubiDAKnvcg9MXCeOApeXljUS7htwligqyoY7m?=
 =?us-ascii?Q?pr2E5Vb35Bj9ZkelORlYPb+o34myMPEddIp4BzSX2BNQTN3xVli1kc14JT8W?=
 =?us-ascii?Q?QcEf3tmKp+VH2eeaNgiJkE8OT0HQhou/0a75Vn9vE06QRqHbk/4YYzXeA4cv?=
 =?us-ascii?Q?TaiCrY8eCmgoJMQySpEkDQtH8dso4eOvGjvzSNDlrKm4pADwoFa5/VcX/qBe?=
 =?us-ascii?Q?qVsuSU6ELm3v2xfZLZ24IzSISXNO/aRtl8OI1Yc6LPum1cx+IxCvsYvM1rBf?=
 =?us-ascii?Q?3LAENulOlFWXe7QUMsurgJwwF9YRTcL3v68HPIxpIYzteB3nXk74e80KXzr3?=
 =?us-ascii?Q?q5W3QlCJTOwfxf7BdI8GMqv7hh9Sawl7S/P+XZbsNsLBNZLEbmj30IZ8qzUt?=
 =?us-ascii?Q?2LnwUFDG4x5zI2LSELyavITMMgqB1NTS9n6beIPzZOS1KJRerKhfXkIbKYwd?=
 =?us-ascii?Q?E5/JJP9VjVHmiLEDFJRrzG+zLTB1KSWZr2Iq9b3MatcnJmYhLGBBCk6oUXPT?=
 =?us-ascii?Q?Ud/NUCxvFiiVdVE6FxDj9UieMmpHlKMvA4WrTxKsGIVCdLyiUgEWwWm6JTAz?=
 =?us-ascii?Q?tf9iULhY5XwcNN38iGs969ysT3abrC14qGA8HxcbRUwFtL81mHWUd2omdflb?=
 =?us-ascii?Q?FtK73gg+Nlvva/1sH3rMrMnP043Sev/kyvqxEdqF1E5gp4fIgMiAAfsHZVSM?=
 =?us-ascii?Q?wvbNSJztoHl2VcdKDWZWC0CgN5c/AH3jrlKZsRaKcLpoaO2LiXLhwwRn9kNW?=
 =?us-ascii?Q?s4IEwrJW+YLL1CEzuq/s6ZD/JR9hj7AVCXXLPQ6vsg23+qDklQRX92TDchbQ?=
 =?us-ascii?Q?qfzRI9nRDcdOwRvAAj/8buc5es38sLPpJodP7i85P133wbDVyMyIZiLUajP7?=
 =?us-ascii?Q?TNy7GcukKUJgkMCch3MOXd6OsUL6XLla6T1FiVnyEocE0zauL9uxbHn51Lnh?=
 =?us-ascii?Q?FO1ZUG0ccBHewjrv3FgceR+4uetWOyUmo+SRGRI6KhQP2YcOTg9HgZ4w5O7D?=
 =?us-ascii?Q?1CL6Rto5nBFJBag/cyedpaGvfFEXms14Y8Wu7vTW18QArG5uGicf3lSdgTu4?=
 =?us-ascii?Q?+D36YuMKA1ck9LO93lKK46oQ/rMMl8G2b8PoB3uOssxabUM3UmTK41lwgPcW?=
 =?us-ascii?Q?WQ2fvR7Q31NwCL3u33yms7QRzO5lVoGeiM94PcggfluiEQoTFkjFiuTfPoNF?=
 =?us-ascii?Q?JH6vOlsSXpm1zjEuj4GkRYba67fW1hV+MvJblk0lZCfzIXC+XgyZJWuX767r?=
 =?us-ascii?Q?yNAdnfKdSA0s9o8ZnkvVSMpGLiv0EI2md4xE2SwPrc0Gin5/5tCzWlkpMZnT?=
 =?us-ascii?Q?A2NsY9Qw9FTRIX5uAkNrTiHmVT0J8uyY6L/iqNvAP7/2C1zGBrDTQ6JVtbTO?=
 =?us-ascii?Q?3CQyTVV4etrAhP1T1BnOVjdoJksdZKVcrM9o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:44:49.1772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd420976-b214-496c-cc4a-08ddbd8ebbf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
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

From: Fudongwang <Fudong.Wang@amd.com>

[Why & How]
Some monitor have audio output but SAB data is zero. Skip
check this in this case.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Fudongwang <Fudong.Wang@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dc_types.h         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 854fc51f159c..4d6181e7c612 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3940,7 +3940,9 @@ enum dc_status resource_map_pool_resources(
 	/* TODO: Add check if ASIC support and EDID audio */
 	if (!stream->converter_disable_audio &&
 	    dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
-	    stream->audio_info.mode_count && stream->audio_info.flags.all) {
+	    stream->audio_info.mode_count &&
+		(stream->audio_info.flags.all ||
+		(stream->sink && stream->sink->edid_caps.panel_patch.skip_audio_sab_check))) {
 		pipe_ctx->stream_res.audio = find_first_free_audio(
 		&context->res_ctx, pool, pipe_ctx->stream_res.stream_enc->id, dc_ctx->dce_version);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 229a754b7b6e..375ca2f13b7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -175,6 +175,7 @@ struct dc_panel_patch {
 	unsigned int embedded_tiled_slave;
 	unsigned int disable_fams;
 	unsigned int skip_avmute;
+	unsigned int skip_audio_sab_check;
 	unsigned int mst_start_top_delay;
 	unsigned int remove_sink_ext_caps;
 	unsigned int disable_colorimetry;
-- 
2.43.0

