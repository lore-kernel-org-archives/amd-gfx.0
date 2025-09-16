Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C582CAC592
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028E210E7A7;
	Tue, 16 Sep 2025 19:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="otKqxgXP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2226010E563
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBP/5GSHeHLbS/WGICUj/QQVTjBClfpjKrnyX0yl14sCy6La9hwsxDSTfr8X+3RKDvHInTrSzEP8Av8Y1xFfMLELl2EdqTBbD5qJm9Eiqfx+ODcDQq+jJHG1lBBS7uBEStd1738dS6IIfJEjYBCaqejG5FZHmr3u6KRZV2LOQ6RwFwaxxhRPivU+hYYR6KYYAIf30EqTGaWCX8rf9WjZQmtP9eCVQpRVbL87AAZSkASJTO/nn1Jpwk67zv2BX6rfPiIRgStJO5eHA8sCdGqU5RbbVl3vPB2m6PUdV66nr9BbS2W8Op2MyTrxkafgvNUThz/Y5zv4YGgrJRHjMVGGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIgCBAjWXk2lkZRvhxifB9wl4mJvVzF5hAO2GI10BMU=;
 b=GSk2HT0/ZJOL+2KG4D8ZrXAHsyFOsX8kc+MeLVRzs6nfMWd5ywvhbepqRTcNBDBqGoUhEGZsDLQzFXnvPrtmpYKQzhs+eo4rbzUfO87474QT/bqIDTRRLJG9Xavq3+IZn1S9avEElT+toP4z/tCo9qpMZTIktl+ufxqO7v1BVo3et+8eXtxSmsNQdle52Hdrq4tJxzAwclD1r29wR3xcjoqWS/HW73mwqafjTo5cp53KtR8IMyveLKR77G6daHySNJilkSdCP1viSi/IGpYxdAvsPL56DXGn+V4fzM/koB+n/tK99WnrUtPXA2Eu8rTJbKfzhZwU03p9m1q6CUINIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIgCBAjWXk2lkZRvhxifB9wl4mJvVzF5hAO2GI10BMU=;
 b=otKqxgXPTpd5V1ZrED7UiBgyzCj2vb1ISJRu/7LSQg5eV1JYjApgDakbZNIPfe8PlaZcwaGa5Tg8HRToHEEGgIuHED1yT5P90mYSsVNXSc0v1b2L7PXaEdxHacVyECgj6vmTVj3ptLF1AnuxGagsdmNTnbELlv+X0wikyPIuBWc=
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:19 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com (2603:10b6:408:fe::4)
 by BN9PR03CA0124.outlook.office365.com (2603:10b6:408:fe::9) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13
 via Frontend Transport; Tue, 16 Sep 2025 19:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:13 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 14:12:12 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:12 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Allen Li <wei-guang.li@amd.com>, Robin Chen
 <robin.chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 10/20] drm/amd/display: Add fast sync field in ultra sleep
 more for DMUB
Date: Tue, 16 Sep 2025 15:09:30 -0400
Message-ID: <20250916191142.3504643-11-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 84420524-bb81-4a38-fbb4-08ddf554f4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pHRtMMyaGLFF2cs4o5m7xp+AT1Ad7gVpEZo66kWcCbclYqX3yK03j4IfjgdS?=
 =?us-ascii?Q?6aD8QU0iC2S15kC/BNY/nmVW3mLrH2/dwEWKmTywWxIMwAAPV8QOrLf1e5X7?=
 =?us-ascii?Q?jrOF65yTneb1kHaDK4K9rGyEh88ad+4+UD+/s4U3pgwJHebUPPcU5BAPGCsc?=
 =?us-ascii?Q?wh1yI6cKji/n5l7Hzh2tCHK8HotG4PfOQ43YNWNshK+dvboyN93wVzqesSdo?=
 =?us-ascii?Q?ctmj8Wb4WPakx8iUOi+kzz8XWixYq1vmQlXvO7KJ8eHhy9fptxcK4n5ajEYd?=
 =?us-ascii?Q?B8VOleis2XtMahGcH7mCv/ikoxNayLmDf4gt8tLYa5Kp0dEP2h2m7+OkAMXu?=
 =?us-ascii?Q?Aif2swkWliIrh1zVKyHSqL8H9dTCn0ADdB0u/YCNWFKeyVP3t6Q+XAgPg/2o?=
 =?us-ascii?Q?j48xhEbRJJCDvTX5ba/ABaj4J8dhnJSV8XE7D8vkK0+oD3nDw+M/z9i/8m7G?=
 =?us-ascii?Q?hHs1g/2j4Ir/be+xrvxkq36cRetzVq0l8ZOlvifRj+8kZEfI/KBUjV4eP2og?=
 =?us-ascii?Q?pdWSupP6w7Ly78QLtbqRLKIrxRwbAElNRuuqYXaegMChsvwIrSUvSFrPbQCL?=
 =?us-ascii?Q?um0Jl53XFOh3jfvxEk0qTcSuKZnqXZ7xDNgQsjbNPlggb0qAqMd5Ohekizgt?=
 =?us-ascii?Q?H7Ts/eRDPJrKe3feTITGKBXgYRHC8z1zDupdgK4aI+uf7re7zajb8IzJahZ8?=
 =?us-ascii?Q?h5gBansR8ch/nq555BSBeVzNuTvXs7UCKVZJ5QUDguni2CKJ1nOvx1caWZy/?=
 =?us-ascii?Q?qD/vl3cRFcxL+9OmYTOdpC1t1AIttMuho10o7YYgLpjITWN9SYNRSrS0uRy4?=
 =?us-ascii?Q?HuvwU3m2+aYHJ618lp1r3kAcetOqMMtzpgBM1uOvlpwvK8qIH7jlsLfd9vRM?=
 =?us-ascii?Q?mgK2kUsfix8DdaRYQq1WMh2gZ9t3h7bVrJFxatF8lTX69BAKwlYaw3GWayE/?=
 =?us-ascii?Q?yE3UcUWRqjxQMPj7rnPvIdGnnFl24RYGxgI1DDpj5eS9pvl6PnF9S0bg1Cj+?=
 =?us-ascii?Q?DiGbzyousM/lPlZTsUbGrjBxABmXey8vv2Y4rQ7UY4ILwWSkabD+oFmbyah1?=
 =?us-ascii?Q?BCOcOJ//hauA1vnIR3dsmBcu3ejH024E0dLS9QOnP6Q5cCsp8eEs6KBFizp1?=
 =?us-ascii?Q?YqxG8wZb8i+UzRYX33tIvBftPz1T2DIEisaApT0w6HsO2n/kBAn6tVPapKgo?=
 =?us-ascii?Q?s/or5uciIbNRGvl4zKUYiVS7wdZOqmTiS2peP+/VfD/tRHi94EQjaV/Gpyjl?=
 =?us-ascii?Q?0PogqI6iKJa9JM/h4xbXWBAPlvELmrL9en9ySMkAyzSMNNRYIV8AGg1q+73f?=
 =?us-ascii?Q?emfA/I1Da25wgZ1v+gYZMdoFnNuP5N1ixkzD1FygJYd0RBhU2Omi7XF94xfI?=
 =?us-ascii?Q?jVwH8VXhF8+aOuoZ2UMn0D2HaqlkVWfgGhyfU9vf4ZmQotVYXnEpU1/qhl7/?=
 =?us-ascii?Q?HRqjkAAWWvT6I8SGwPoJYE+V6vVXVj+Ft9Nt/pd6rSjgOXucwnRm4KZvhM0W?=
 =?us-ascii?Q?kAjlkPCibVxaAmOE5MkrgonmQZ7Arj69BT1O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:18.9684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84420524-bb81-4a38-fbb4-08ddf554f4d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
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

From: Allen Li <wei-guang.li@amd.com>

[Why&How]
We need to inform DMUB whether fast sync in ultra sleep mode is supported,
so that it can disable desync error detection when the it is not enabled.
This helps prevent unexpected desync errors when transitioning out of
ultra sleep mode.

Add fast sync in ultra sleep mode field in replay copy setting command.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Allen Li <wei-guang.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h  | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 9e2a473a8852..f9542edff14b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -169,6 +169,7 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 	copy_settings_data->max_deviation_line			= link->dpcd_caps.pr_info.max_deviation_line;
 	copy_settings_data->smu_optimizations_en		= link->replay_settings.replay_smu_opt_enable;
 	copy_settings_data->replay_timing_sync_supported = link->replay_settings.config.replay_timing_sync_supported;
+	copy_settings_data->replay_support_fast_resync_in_ultra_sleep_mode = link->replay_settings.config.replay_support_fast_resync_in_ultra_sleep_mode;
 
 	copy_settings_data->debug.bitfields.enable_ips_visual_confirm = dc->dc->debug.enable_ips_visual_confirm;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 02a4a20e3560..ef8510bab32c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4142,10 +4142,14 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * @hpo_link_enc_inst: HPO link encoder instance
 	 */
 	uint8_t hpo_link_enc_inst;
+	/**
+	 * Determines if fast sync in ultra sleep mode is enabled/disabled.
+	 */
+	uint8_t replay_support_fast_resync_in_ultra_sleep_mode;
 	/**
 	 * @pad: Align structure to 4 byte boundary.
 	 */
-	uint8_t pad[2];
+	uint8_t pad[1];
 };
 
 
-- 
2.43.0

