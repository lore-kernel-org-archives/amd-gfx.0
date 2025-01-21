Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD5CC0218C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2D310E62D;
	Tue, 21 Jan 2025 19:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGxlAqfy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A2F10E629
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQhi7cG6zPR4NxUTDHx8q50CYEPn61IqL/JIEZs5dBrbpekqRIoy6WxcZ/8KfF9sDyzDDQskNyUHEqHpm8y8hNQFgoe4+vnokDZJh/wUJHuFUcoIr9ebfG/5fGccdZV+nNH0UBSrs71VAag9VN77JmWCapqH/XNW2ofVI1U9giRZxVbzHQs5Y9U07dCrPpvbFicxDxsHNhab2MTbSI+zuKtfLaJTajTGiqicb9HoEl7Z0GmhqoLN1Rbh3qHFyy9DQh9p1U4X9omsIPI1jZTLlxL1+6MinzuzyaS0W+bD603tLkBOoiE2AHAl8wbIqzg49IbBoSbiPGRwpIfP7tCXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIy+5nSTthQqw69D6zLwKY3wsYURpQC+xVm0RMprWcY=;
 b=zJCOQXiFbdaraVqYVin6Y7BEpeRBX4ES8cUYoygwAbhLYuuKBj8/GFX7jyXCHRSA7Xk0urHXEYZP0ULxtBAHlgQGsU8kjnRJNY7MJLVmpELW9+pP84Gm940usMH6g+73OfdrPHBxxg8+UrExC3sBiWwkQc9eTtZpa1k/YqASp7t9W3ZhNVWx69Iqx4VIhtTO8UgZ4jm044tcxYTJKJYvVFChvzKt0VFo1mwcFTJ2aIZDI872mZEYmXpxZzi+RI4GkT678swUI5eFqNkNVkYks42whe62EAkUI0l1RH7IngKxz5ww+1fAq3JHUgnIVpVl1LtKOObDxouEBPE+xHSILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIy+5nSTthQqw69D6zLwKY3wsYURpQC+xVm0RMprWcY=;
 b=ZGxlAqfyI/9OizG/htddYjgWF+Lf7kYfTxs33uNi1PPPkmVdxZ6L6qb5kqiVi+HocW9LmnDgH823xKpY11FkiQd0QmvWatIFEAe/lyjr1NcOhf+0uw4Cu/dkwr2VS3RfEgYMrnIsT5/2aEJVwEwxNRxYZBAWA+4reXYizPJOptw=
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 19:39:56 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::fd) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 19:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:39:56 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:39:54 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, George Shen
 <george.shen@amd.com>, Michael Strauss <michael.strauss@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 02/14] drm/amd/display: Update CR AUX RD interval
 interpretation
Date: Tue, 21 Jan 2025 14:39:07 -0500
Message-ID: <20250121193919.3342348-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d9250d-07d8-476c-7381-08dd3a53628e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?70mI7rqOEICfJt352OOiZ69xF4PtxOFSgdjL+5po/+hWKIUvwnTFeWjRRfB6?=
 =?us-ascii?Q?2GqZ9rx1qLKsyG2GJEMkHcxD3MgBkzfNDJAdzMJRYiVpl3daKnXU17tOVU6W?=
 =?us-ascii?Q?/Ze2i+FXcdzaQzUAdtmpwDdBdMSCYgA+lGnZSViFhuNl6O9p8C8ma0dyZ2YR?=
 =?us-ascii?Q?5VT0mSSNloc/PEE9rHesCqT2IXvi4WpNtqDij6UGvoji+pF1dV5zIMEmB0la?=
 =?us-ascii?Q?NMVFP63nyq2zfsdl0kRDrgXEPGy0JRzdJk7hAj+rIUl7/2fn4WB23/DaUJot?=
 =?us-ascii?Q?s6NVwUumbdAn6zASbohLL5lxv+piCBOAZ6R8qUZdq4FQC2dnFFQ/ZO9Xr8yE?=
 =?us-ascii?Q?6oAgMtxaPXVOSncbyNbgb4iRHO6v0VHWrSwaqq8rpxGZGe+FUGL3mizpYqAQ?=
 =?us-ascii?Q?xg+qDadB+h7BGUVQuqCrXuEJ407eZ+/onBWHewS7HAmpt5LgPnsBG2xtsU8O?=
 =?us-ascii?Q?DHb61u6d8DeE05+IhY8oYaP22TtgYPdKkKVP/unKFJduaoke6oaKxzxqzZaP?=
 =?us-ascii?Q?J1E+niLbmGrQEHXJ9Ib5Dd55PldxcvXjxRfjPFpL3yie0ThYl1wsmvIsPUh9?=
 =?us-ascii?Q?p7QmTLA35dDOF8PA/ZhnUzgUd9a9pLpM+6FuiO2/+AWI2M12E/44m3Vs6atx?=
 =?us-ascii?Q?gnDCX+oXlTC75YlzLVVcj/RE9HMejzk7VjzDjjJoWKExrWhd64v20kc3MqJF?=
 =?us-ascii?Q?Xhe8YSyxTr3fyO/2Hs/hecd9Ld8fqUxXQqim59xEMR3Uo7zi94/IDo05CBLn?=
 =?us-ascii?Q?OH8UF7mGxT+WGEcHhlfT5kB+bcPhIOAdohxKX2cTos7PVbFbfcYUwoAUoCCK?=
 =?us-ascii?Q?B1rH5IK+JLN3ASa0fBFeskIZ3VopPeQ3DegYCvUW5Y+HxAtC17DyJlBsof7z?=
 =?us-ascii?Q?8xFx1xyfnEZC/fjMhUhYEPvYc+OOA6ASAcyLT9MyJYrfYNRYZ6GoycQq1VxS?=
 =?us-ascii?Q?VaqVAmz6QH8rHT3hUBltHoRsNseXz1kcDbV2uBc6XzlSpte9EK/O40Qpl+O/?=
 =?us-ascii?Q?1ABATSmyYk0HcdEudPa2D2QpqrtygF7eE0DjomAgRTyihxlSSGkZrNxIvYS1?=
 =?us-ascii?Q?tHIyd0/oZZPSyja8/ctUW+yMzK/H6PBD6vMZqekfTTMyL9+/NcbKxm8ZzOUl?=
 =?us-ascii?Q?l03FR/zzlXnjUPgKdmlUhrk5LoOf1IyeGx2VLbGlHIg/uZlyqrdXskEEl75i?=
 =?us-ascii?Q?o+l6G136RLf3K+aFwsyOOFr271k1qrBf7CXk98+WqCcUn8c/PbTJSyEMksFf?=
 =?us-ascii?Q?QY2ykKN6/10+VDXHjzYGp5FXvcnXKijJwFLGYPu0I4dKhAMbI7qkNdYPulqx?=
 =?us-ascii?Q?pqyqCfht99Q+yYz7YFTtzxrOh9GxfBQFlW5oMSuHsu3Qi+DpM8kzz1DjrCdc?=
 =?us-ascii?Q?T9531wIPskKnPCC2fsu46lYCD6U1bWf53ePST7bk5oaB9tbhxDkoN0mzFxv3?=
 =?us-ascii?Q?1e0BRkPn4vapDcXqn4WOIC7bEyutH1BEo1yNGr1uyf3LE8Yownh7XT0NzQbV?=
 =?us-ascii?Q?SPbGg4Dpgu/7+cw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:39:56.5896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d9250d-07d8-476c-7381-08dd3a53628e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
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

From: George Shen <george.shen@amd.com>

[Why]
DP spec updated to have the CR AUX RD interval match the EQ AUX RD
interval interpretation of DPCD 0000Eh/0220Eh for 8b/10b non-LTTPR mode
and LTTPR transparent mode cases.

[How]
Update interpretation of DPCD 0000Eh/0220Eh for CR AUX RD interval
during 8b/10b link training.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../display/dc/link/protocols/link_dp_training_8b_10b.c    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 3bdce32a85e3..ae95ec48e572 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -36,7 +36,8 @@
 	link->ctx->logger
 
 static int32_t get_cr_training_aux_rd_interval(struct dc_link *link,
-		const struct dc_link_settings *link_settings)
+		const struct dc_link_settings *link_settings,
+		enum lttpr_mode lttpr_mode)
 {
 	union training_aux_rd_interval training_rd_interval;
 	uint32_t wait_in_micro_secs = 100;
@@ -49,6 +50,8 @@ static int32_t get_cr_training_aux_rd_interval(struct dc_link *link,
 				DP_TRAINING_AUX_RD_INTERVAL,
 				(uint8_t *)&training_rd_interval,
 				sizeof(training_rd_interval));
+		if (lttpr_mode != LTTPR_MODE_NON_TRANSPARENT)
+			wait_in_micro_secs = 400;
 		if (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL)
 			wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
 	}
@@ -110,7 +113,6 @@ void decide_8b_10b_training_settings(
 	 */
 	lt_settings->link_settings.link_spread = link->dp_ss_off ?
 			LINK_SPREAD_DISABLED : LINK_SPREAD_05_DOWNSPREAD_30KHZ;
-	lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting);
 	lt_settings->eq_pattern_time = get_eq_training_aux_rd_interval(link, link_setting);
 	lt_settings->pattern_for_cr = decide_cr_training_pattern(link_setting);
 	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
@@ -119,6 +121,7 @@ void decide_8b_10b_training_settings(
 	lt_settings->disallow_per_lane_settings = true;
 	lt_settings->always_match_dpcd_with_hw_lane_settings = true;
 	lt_settings->lttpr_mode = dp_decide_8b_10b_lttpr_mode(link);
+	lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting, lt_settings->lttpr_mode);
 	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
 
-- 
2.34.1

