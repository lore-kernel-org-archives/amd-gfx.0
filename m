Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D94C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0582A10ECD0;
	Fri, 14 Feb 2025 15:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2z1dFVF/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF0E10ECC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/jtsB3SajckuEDB7kf7iEdVzw1TO9iVxTvW1d95/i12aXMCXpMqnG1rC3gHzOtEHTCiWvSyFMtY3ZRprUsBHFLqdjfM62j9BVP2/qlS5tk9rhnl+n/DVyIjMZAoWdq3Arha9iKOjJL40wWdkHZDZsGEbbdnUvgtQ+Qp47urep6yubG6UPwzi3eS9c/UaCkB+UC6Q2p+eeLRNOaSr+Nv0SEzHcTimyS6rGGcogeanRvhkmuJXlXY7PVy4DH356HrMTp3+x3m6Fs9l3dBVdWlCH85Qx7OoL+s8zCIclNlmqK0dXAlxTB1PyJK+qDa1gJC6ioz3oH7afm9VJSxQYaPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg3E1YMUcD1mB/TzDGpK1cwSj7avkbIv7rUGig28VI0=;
 b=IRIgFkFNxV/0cwJgzih24fUSEmc5EU7SkNIML4rYzda0sOqzcdOxSTtNpFoYN0FIg/gIT6wZglYrF8RI7/1cBnOajGmSvfIJ78hgvAXXUuE51NLUst3UHcZ0xo32DlUJuuAgDSKh3fNy9lm+yssqryY8YRILiFbzvTveEEclLFeg9FNqqkqRBt03WSbPIm3tH6dAG6HP4XbF+5yM/9mp64mnePdxax1uELaXQ/7F89+M0J+ACHUXkRtu9umupUp/0wA88U8h68MRI4gx25CzCvPLN+uiBVHRCT1mYSPFwhuiEaIb4DJs6G8VKEHgnrEpdSM5CmFV+Yum/WEK2NenQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg3E1YMUcD1mB/TzDGpK1cwSj7avkbIv7rUGig28VI0=;
 b=2z1dFVF/tRsq8WG1x8/fovDwUoqZC1gfF2VrAhL9QZyzQrNBYVZ3E9t8b17xj/K7HpGewvYwCMRIMnmN6BqCrY1AnXkkWKe3sR7tiZEM2uPRassNmZhKcIbbGbVSgXiaWZDGzyFfBPqr8piQ18C/obKLPn5Au8gvKg1y3ud3qjo=
Received: from CH2PR17CA0017.namprd17.prod.outlook.com (2603:10b6:610:53::27)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 15:01:42 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::20) by CH2PR17CA0017.outlook.office365.com
 (2603:10b6:610:53::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:39 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:39 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, 
 Leo Chen <leo.chen@amd.com>, Syed Hassan <syed.hassan@amd.com>
Subject: [PATCH 13/16] drm/amd/display: Guard against setting dispclk low when
 active
Date: Fri, 14 Feb 2025 10:00:30 -0500
Message-ID: <20250214150033.767978-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 69921aaa-206e-4cc8-3603-08dd4d087de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CHmDU84wKqu4EV4U3/90GaAx9nzGHLgkMhb/ZJFEXWe6tsI604tz8SlLmEAn?=
 =?us-ascii?Q?lUfNNC0Ug7n4k3MKBJ9B9Wlwgt0M8XMXxx4Wt6mTwAmUOtwN/95x2EIN/Uvo?=
 =?us-ascii?Q?C8aZkITdnV0nelbNgGfFBKtNyQckMkXGh8dYl8lKUXCH4/n4Nr6sGY/9m4RX?=
 =?us-ascii?Q?Ma5bq3bGSa7fd+5ZRRiV79H+zh7WSZG0qdRmXaU14tU3iKsd90M4RCMkzgaF?=
 =?us-ascii?Q?PmDH47atiGOnffwpD7jmKEWxkrfQKoOnR6MsPk8DThkEhfT1glKTpU+Kf7lF?=
 =?us-ascii?Q?cMg8lj/P8B4xtiqqg+J85bsDJd05wXGzdTWUxUY+mJ2IO4Ss9+ogZ/jTPCp+?=
 =?us-ascii?Q?Rx2OZ4t/tqvulmGFB6NlciJeqC+3ASBb9XSsYdveokm+9CtVZcEeNF6Cg7zm?=
 =?us-ascii?Q?Wr26raPWZXHeHdaxatrjqpF+Qr9C5W8n8UIG7X4tMeQ/etiRB27nrY+Fg/CK?=
 =?us-ascii?Q?3EWgVMWZ9FcaoBMgEwjL+61v5oxYb727mQEF9kzhF4NFMHFyTF8ndCMVbz3C?=
 =?us-ascii?Q?w7lflYJ0EFudFH/Tc0fkB5p973uvEu86GchmVW2tsUri0QbZbqijHh3/4/tc?=
 =?us-ascii?Q?OgtCxMzhEtfLpzBxLAFhR92hfcIMJdcL1Na201SCZ4qGzDCw5yr/rpsFf1HS?=
 =?us-ascii?Q?3waeHwqQ/mfMdEpkGdsLbU9NynL8UC4inmL17kdoKhJHoAIuo+wIY8lzs7Yy?=
 =?us-ascii?Q?GR0GsNir2bh/xknapH6UCXMl5xO/h5+y63GS21+bPeywDwDKtN2xuuum5n38?=
 =?us-ascii?Q?22Cg0TlrxPIVHtIh1I88zclu+2aI+3WLUxgSNbR5vgh9aC4XuP3uQuE2jT3L?=
 =?us-ascii?Q?tL/272TpOfYg0mfbOlLAmArnEahrHTcsYX9DiuYscHPWf9pV2jt6crx1wzJV?=
 =?us-ascii?Q?hZlV7F5Wcy21kmQFkX8nhsYDbmP/tX98LnXwuJ4YaPt+SEFAB5eOvWsK3mCp?=
 =?us-ascii?Q?3N6EBaEvXjfKB2DuB+/tcf4HJBRDA/E75otvFFzKrmuR3a+plS1sPs8uL9d2?=
 =?us-ascii?Q?w0zsW/4mau5QGB7Qs5LFOchhq7vHkMMctNEBXdrWi6bTPQIeDoG2+7LzkdS0?=
 =?us-ascii?Q?UaLnugllDWF77dqo6XYpNkYFybvxU7LbEZeNnaA+9+VlqRuFik7h+gv6NHwp?=
 =?us-ascii?Q?AE99RNKMlTxf2L55HXe6VzV9vwgbE82cTtuJn7Jnx06DeBXSb+9wot+8J8J2?=
 =?us-ascii?Q?LrgIkLrUFR/oNOEyJpm70wjDjNKl5pdRRf2RVrD1KdyjXegBBaqUjAy9IfJf?=
 =?us-ascii?Q?aIxKQhAdg1HlsVdlCMWrb38pWUhwSChRmkvj84+xhmRngne2z6iGwze2Pmvh?=
 =?us-ascii?Q?Iy0p7k0kY1IPEEQhz8GjD8gDl6z/DJ3/2nJDBGVxWnIKU2WbfXfpGKgP/O7H?=
 =?us-ascii?Q?/8gsaiRZEzbjq9M4ENGg0pi4tdbNJ7LkuOBaYXdXEDnlQfYA16t3OV4dWRz7?=
 =?us-ascii?Q?DRumODiiVJIP3riHcwwxiGWWL3CLP4nZMyVjUcC35S8brdeQ4K44i6fESzqn?=
 =?us-ascii?Q?SjK6cDD8xE5pkL4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:42.2947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69921aaa-206e-4cc8-3603-08dd4d087de5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
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

[Why]
We should never apply a minimum dispclk value while in prepare_bandwidth
or while displays are active. This is always an optimization for when
all displays are disabled.

[How]
Defer dispclk optimization until safe_to_lower = true and display_count
reaches 0.

Since 0 has a special value in this logic (ie. no dispclk required)
we also need adjust the logic that clamps it for the actual request
to PMFW.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Reviewed-by: Leo Chen <leo.chen@amd.com>
Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 56800c573a71..df29d28d89c9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -467,14 +467,19 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dppclk = true;
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		int requested_dispclk_khz = new_clocks->dispclk_khz;
+
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
-		if (dc->debug.min_disp_clk_khz > 0 && new_clocks->dispclk_khz < dc->debug.min_disp_clk_khz)
-			new_clocks->dispclk_khz = dc->debug.min_disp_clk_khz;
+		/* Clamp the requested clock to PMFW based on their limit. */
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
 
+		dcn35_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
+
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
-- 
2.34.1

