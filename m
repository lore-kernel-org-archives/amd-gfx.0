Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DE8C54F30
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2435910E144;
	Wed, 28 May 2025 02:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RBFb/LUP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5AB10E114
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imO8XdatHToxBoL3e4JJ5i6tGy2lP+j31bXE9hrWupAaNaG4UKFq+RkZweH1KCJOrI389+x8Mw0eQDjk1Dp10fwiAK6FcEA2Ni/Kt3ZFy5In7O76ndZSy6xc1SJoiR9Y6ypwDAawsqvRyfl3gbhs3t278MWiVJ/gXsknU8hvJd79XqyQFyWuSnkAsI8N5epExUDZ7uTwWFmrIrdhFgtL3sjSkIzCufiWxJzlO5Cr8cD8IkmknzB+2sLnM2rj02SPTXY2YIyk0aamTUiS6dpCCfTW1VsMzeL1YDyOqtqn8yk8HgTf5NiWmaMkzt4FZc27/xS9kn8DwKpamt1Xk6A5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01URGGwaXQrePs1FD7Wbxcr/KDo0d/ixIoZ3hLkP25E=;
 b=EBuhzOQP+OkmBjkph8CfaNnF+t0S3I8k1VcxDgp+U42Ijz/HykYrnjZ4Q8Hijojx7/IV5wEFtHvUPgwBydpsgSmxB0ak555KkMwl42AbhH7nNHb1XjCf6Ood/LvWRzKJy4RAe0i8am1CZyHyLLOiC/Tgx2SvE4Bu7W6BctI/Av1J//K7K2zTYYYmkQDMuIwhpzqIZyGlB5c1r2WEkqWhgoRkVsznZBBMMykSPHYHg7eWEbbe42ME27fLgoouwj3SKdeMy78eGritIPu8e3nO6YtV944DzwOqmDMxN9OePrmnXICrOAC7PjSp+9V9TtwDBhSkYckIWG1jrHMzLvkbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01URGGwaXQrePs1FD7Wbxcr/KDo0d/ixIoZ3hLkP25E=;
 b=RBFb/LUPpV7Y1UXd5VVK3Rbtbsg+rUQd6THQqpR6zmFeMAFZOepY8dNcjaZ+lfj6M3ovfW5S+vsHS8rtyl2YhH5WIjMYaA6BRYDfX2tbV0HtC20EUxL7YzQY/2wanRuyoASGK0SkwIO+zOY4g+iZ/bw93pJMQW+u5H2FH2pSB/Y=
Received: from BN8PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:70::18)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:52:37 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::51) by BN8PR04CA0005.outlook.office365.com
 (2603:10b6:408:70::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Wed,
 28 May 2025 02:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:52:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:36 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Camille Cho
 <Camille.Cho@amd.com>, Krunoslav Kovac <krunoslav.kovac@amd.com>
Subject: [PATCH 04/24] drm/amd/display: Support OLED SDR with AMD ABC
Date: Wed, 28 May 2025 10:48:59 +0800
Message-ID: <20250528025204.79578-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b9cc26-0633-46f4-8b47-08dd9d92b423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f75CrSE5D5FZamxBFLKAJVqxFUyqbb5cU/Cr5xYA06B+sm5kqtY9arjLAO3o?=
 =?us-ascii?Q?u6Q0bxE0H40cpl/EtKiXX33tu2BQhhPSZFRC1D5Q9B36mAMI06TonezvefzR?=
 =?us-ascii?Q?52Fh0BQMMDDRFdJRf2CJS7oWyPV+XWha383Q2COw6weeE9ToPH7oJ/6bLWEo?=
 =?us-ascii?Q?DDxu0xAvhxlr9biYNlWrFZG8V47h/c4SQGBKJVWOzk7mejMkBeuEIlG7EeK4?=
 =?us-ascii?Q?sTB9kVGfC0mzSTMXgE3VF990Fp0NKPIiUqWgA3wundQZsb56Z71Y2sZ6VAmD?=
 =?us-ascii?Q?XH/E98XCfd3wK7zAduAabP7QrtqG79wLVHl4SbAJSHLpP7j9jTHpXTLKXORO?=
 =?us-ascii?Q?fzeveJOnhcagLXtzk3NKxLph7+OCPnHlHIwP9EZkh7TaOmwkoTrpoxubinON?=
 =?us-ascii?Q?8lOELHC+09RAbMxQI6MGyOLIyUJzM+QzWI8z9VxYdyTwInKr9faEer2vFef/?=
 =?us-ascii?Q?MZluaFkzjfioNoD5ODsrjblwIK2Zw1/IN3bMMFxs9E0FWDtlxdNZRcf/ea7u?=
 =?us-ascii?Q?yJTo5zIF1sv/Y/QkmSPQtX1byXSk88rFcMDwC96UVY0941vlUMxEvi3e9GpU?=
 =?us-ascii?Q?/ezo7GVKJRNCe7QZVtz839aS0jrJ5cojOUxu1nAOuwEosjmc4qSnbrylKJS+?=
 =?us-ascii?Q?UD003Wr6Mk8lCKR5ayMw562CJozb8iCzdkURy1X3xYGZiErNovvraTkFB1E2?=
 =?us-ascii?Q?ptdPzMObI0VtUqlqsSiOsfg1K3AwqMp2Sll+6mox/X8O5kyHn/rJeE26Bblm?=
 =?us-ascii?Q?pzol6IKfK2DNSK0xDI9uJTUm//R09SsYt5trYxP4SGYNviD/+HknNjkRJTlS?=
 =?us-ascii?Q?db5lUiYWZwdLtSiNXJMpw+eIkqcBIqq/GfZUGHfakutagh5E4c3Xwilm+tVe?=
 =?us-ascii?Q?bWnsbZ49n3vX76aY86my3/j8TZqEklvCh4ZnP5e4fJOV4kz2XxBL1KkXfI7Q?=
 =?us-ascii?Q?2WLyndBK8YnCy7C5mEYXXixOzM7l/TVMuWAc+kTAiyUtAwUJFX817rM0wfvM?=
 =?us-ascii?Q?ZD1CRRDHT3zeSMdA7dlJDgUMOvp63+ZVKf3yjvNHd18q5b8qBIG4TlDzfinT?=
 =?us-ascii?Q?RRLpjuSL6BM6sFaDFIA+4xVO20fMLmZpP2JHKPsBg6olFw2oTtW+uVFQcX2F?=
 =?us-ascii?Q?p6q09aRtqbIfycE96WP2Vj0yeYq21H0NxqZ9WJ8htW1h8jKQNEFCBZ9X0VKb?=
 =?us-ascii?Q?Khg7+OJRJ8jct0WZ1CYsy5Pe7Nm4iK96cXTbpZPdBqaMBzHqI+5rZBGMDyt7?=
 =?us-ascii?Q?WbjG/HPfRoMZBGnLXdxKuKLD9FpVQp/26fRdkDOuwJhc9YmL36D9A/00Q3KN?=
 =?us-ascii?Q?alLa1Hl/4Va3ExR3cqnVhS8yxJ2tQKeP/5bFcpjxmNi/c40cOmE7/G3IREh7?=
 =?us-ascii?Q?U+vdYZU7oiNuIJyQXOrM8M2PKfvDyi4ecRYTwWQF4IkNjGfXFZmt4nZtlEtH?=
 =?us-ascii?Q?fYC63qKuh77/PhCMMEGsXDG+f9fpNgz2YlZQXj4hJjem489O4Ovw8Rw3kJN1?=
 =?us-ascii?Q?OKNnA7/TaacY89uwQnjswEf2oj6KuW5pJqhk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:52:36.9053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b9cc26-0633-46f4-8b47-08dd9d92b423
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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

From: Camille Cho <Camille.Cho@amd.com>

[Why]
Nits programming for SDR panel is only supported by VESA ABC.

[How]
1. Loose nits programming for OLED SDR panel with AMD ABC.
2. We support two ABC methods. Disable one before we program the other
   in case panel freaks out.
3. Update HDR judgement in setBR with a solider condition.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Signed-off-by: Camille Cho <Camille.Cho@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../link/protocols/link_edp_panel_control.c   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index da74c2b5854f..035795042a01 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -173,6 +173,15 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 
 		target_luminance = (struct target_luminance_value *)&backlight_millinits;
 
+		//make sure we disable AMD ABC first.
+		core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_CONTROL,
+			&backlight_enable, sizeof(uint8_t));
+		if (backlight_enable) {
+			backlight_enable = 0;
+			core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_CONTROL,
+					&backlight_enable, 1);
+		}
+
 		core_link_read_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
 			&backlight_enable, sizeof(uint8_t));
 
@@ -193,10 +202,22 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 		*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
 
 		uint8_t backlight_control = isHDR ? 1 : 0;
+		uint8_t backlight_enable = 0;
+
 		// OLEDs have no PWM, they can only use AUX
 		if (link->dpcd_sink_ext_caps.bits.oled == 1)
 			backlight_control = 1;
 
+		//make sure we disable VESA ABC first.
+		core_link_read_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+			&backlight_enable, sizeof(uint8_t));
+
+		if (backlight_enable & DP_EDP_PANEL_LUMINANCE_CONTROL_ENABLE) {
+			backlight_enable &= ~DP_EDP_PANEL_LUMINANCE_CONTROL_ENABLE;
+			core_link_write_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+					&backlight_enable, sizeof(backlight_enable));
+		}
+
 		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
 			(uint8_t *)(&dpcd_backlight_set),
 			sizeof(dpcd_backlight_set)) != DC_OK)
-- 
2.43.0

