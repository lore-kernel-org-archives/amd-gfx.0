Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EACFD6C2B9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 00:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214DE10E37F;
	Wed, 20 Nov 2024 00:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H6n5SwcQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926DA10E37F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 00:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/WHjHaWrxhBEc6B7jbrT7DcMGkRmgeQjUAM7/00aVdo0xVs2HFNDYAgVKYPKvhA6UhZYqz6MZFWGRaLztICqYiE1SgTV158aNNmwbwi4Hez0g2tnmQMqLopF31uEZuq19wNz9Xp8h6bdgKrD7Eflhsw65NyUyHN0ynTOhiwZYx6GWVzMfFsoiQIzDrCesbMYz5mZUI0XuJYy3bjcnIiV1/t+bi9c9NMiA09ph+/8GdOA9PaiSlrNddSsamEJKN3IKRwiflNe59wZ15derR79cXabwLxRemqdkvPZOxq7uRllMqPj46hZQKXmo9+6oH4KP3lJyXO9Js5lu/si2qAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3Jgn/Qq6WjNNRZ/SvCTVpNHFFKlK6dg6Iic7BAAQvY=;
 b=OrimYgZnZo329pSd/wWWtWcdB0UI5VacyRJVqECuzo+5QYCCUswfkLlSW2q92gkapkcMoLO7XYpicvTSba69+KH6HbIB7TQBg6HBMPVIg5Fk8G2YYC2mW2kpORtWJzwrAlYv5HR07SaOGkzTaRO7NnhaHSBVRadzpH1VMjj+BcGxK944Fx/IOexG8bOu/eDS7qVJSPGyUp+cc+FAtRlKMj9Lc6BMBgk2J0vIV9kWI5yPEXVukVTerd9bi/BVUDkItiHLo/Gd9YJDbVjMOfFzhGs97JG45LNKGynfM+icK64dYvWW8Q8/THQ0+ahyFUa+wB4xOYeOCfFNEPVlzsdO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3Jgn/Qq6WjNNRZ/SvCTVpNHFFKlK6dg6Iic7BAAQvY=;
 b=H6n5SwcQxWIJvUZTiFZWLgR30J2R9Xs4jFc7PvH68WU6sYb7vUaiuYUPHxMKRgIWF6sGxMe/MuTbTk9y4ik1g2UzKCDHLCUQ1JzvP1teiFaPB/R6tKGJKC/UAAUl+U7UfamFIKlUOZT7tjeIGd3znq/Hdzt3DPR43xFlJ1WDYp4=
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 00:33:19 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::b3) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 00:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 00:33:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 18:33:16 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 3/9] drm/amd/display: Add disable_ips_in_dpms_off flag for IPS
Date: Tue, 19 Nov 2024 17:28:31 -0700
Message-ID: <20241120003044.2160289-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120003044.2160289-1-alex.hung@amd.com>
References: <20241120003044.2160289-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: f95dee26-4de6-4660-4049-08dd08faeeaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OA7Pr9KIGt6/5Aznw+4Rm/UogIaNAqInRz9K7LZQLZP7WeT1PiWp2e4h/9bU?=
 =?us-ascii?Q?3rL3Dovb3WI2VEVz1iSmb9XDkTTaRRIPNyosm1NPTIVtbazkcBDOGyurrSGp?=
 =?us-ascii?Q?fKMDD04QS33srybNoxRnUIdyFujMb38N2QbcpdTdf6DTja7eoz1SXm20SO9o?=
 =?us-ascii?Q?tpr1U/hbasW8/apK8wsZNnSajoRao2YQFJ0QZZGZBOy+rQ8nIosiol49YaKk?=
 =?us-ascii?Q?UvhYg/SbbXpZi4gEwUpDusx47Y0kZHx3A1t5rDz7nt0YZj4+EMM0iapTfRtm?=
 =?us-ascii?Q?UkbLWtfQR5wIKnG2R5LsHX2AOfAGgEuKQTHWRwUoK4TvR4T761InVTHlB9zS?=
 =?us-ascii?Q?KpKYaNlSidVa2RV9Vl09JtAn4EfFGydFPk0rnkTuSd9VznvkWVa5sUxgW3RS?=
 =?us-ascii?Q?1H1K6v9PMJAOP296SnRh+SFRVo0x/ip1X4Df+bfDoVWsC/B7NFJ8s3g9cNr+?=
 =?us-ascii?Q?+wXAJ1vtLHygbsQFtmsKLPAFGzbPe87ggHFffzCOV7QDWDsDpwiBjCgbWs9C?=
 =?us-ascii?Q?htAt/jtYGzKHzu1CM1IXP1+bVPklr+kWmifouzje/KEJ7AH/YgucLzp/5/2D?=
 =?us-ascii?Q?+biLthANWs2zlKsLr0CzFUbEmvwYnc5z3oeKOvCWGn24/0MSGvXg1vxSAiYY?=
 =?us-ascii?Q?72L175yb7/KWGTQDyq28GqxhkgOEAwimNRtb7FKZwtNs44M1tXmydcInX1DO?=
 =?us-ascii?Q?AiGm1l/ynnQBopg78SQ2VbVBEGZsCe//l8A1FI5tMybk1fGRY1T0Un3epNzi?=
 =?us-ascii?Q?I/Rhldbg0F4YGEV6mAdlHFHtoEwHOm+YZOFWMTCW6BHbIWTLMCx0oCrHDX1W?=
 =?us-ascii?Q?wQEqzSSlN6HvZA82H1r5CS2irepk4Gj3Y3LL5vpJ3xj6Tze/NaZ0VcmgxAMV?=
 =?us-ascii?Q?yH/ihfbCmDH09vBKI8RxNIQskjuczzj2cGHjrZLDZ8s0bRN4gHJWUsMA0BVP?=
 =?us-ascii?Q?wLWGZ4sZ+kt0P+X3id1uKgXdUw8qhbpAsDyhH5FSelJ96kLPwjydBT/pfn7B?=
 =?us-ascii?Q?2fForak60HfUro6bM9E4FPaSimcXTML3vvZGwVE2htoCGK4JHllK3s2xvx5U?=
 =?us-ascii?Q?v83yEwJUobSlK+ryHc/5gFqzNBRmAcjTpwjaObH5CiYMCcsMYYxCStcUrGey?=
 =?us-ascii?Q?gOffjxyT4LQCjk5Qk8CEn5ymmlR2q5QBEjgK56HXVbu4fA4qc97EwAwG+AKe?=
 =?us-ascii?Q?GFT6tIkHkd4YN7TWdWM5LWp6pPwTUdDurF0LuzlGDCe4Cprgc1W9WoS3usgK?=
 =?us-ascii?Q?hISNreHZ6yIkNr7X2/SQd872rY11U21aeU7ShO7ym40Kp2NcNzm1BznEfRje?=
 =?us-ascii?Q?QZP7ez6q8gVBkXv6cBn4hA1/mHXXFG0mBYqFULq9gF/eCFaaGPl9/1v+xu5S?=
 =?us-ascii?Q?VB6xKdT3fIP1kUwFzCd0afGyFFsD8vIaIXX/j7L4Z4/hKBNKAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:33:19.3898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95dee26-4de6-4660-4049-08dd08faeeaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[WHY]
It's possible we still allow IPS2 when all streams are DPMS off but this
is unexpected.

[HOW]
Pass the DM config value into DC so it can use the pure stream count
to decide. We will be in 0 streams for S0i3 so this will still allow
it for D3.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h          | 1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 104051935884..b5613b71742f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -462,6 +462,7 @@ struct dc_config {
 	bool enable_auto_dpm_test_logs;
 	unsigned int disable_ips;
 	unsigned int disable_ips_in_vpb;
+	bool disable_ips_in_dpms_off;
 	bool usb4_bw_alloc_support;
 	bool allow_0_dtb_clk;
 	bool use_assr_psp_message;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index f90fc154549a..775c58637f46 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1245,7 +1245,7 @@ static int count_active_streams(const struct dc *dc)
 	for (i = 0; i < dc->current_state->stream_count; ++i) {
 		struct dc_stream_state *stream = dc->current_state->streams[i];
 
-		if (stream && !stream->dpms_off)
+		if (stream && (!stream->dpms_off || dc->config.disable_ips_in_dpms_off))
 			count += 1;
 	}
 
-- 
2.43.0

