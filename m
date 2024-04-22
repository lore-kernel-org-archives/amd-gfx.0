Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D0EC07C79
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D0E112BF0;
	Mon, 22 Apr 2024 15:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y0m1ajpJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A773F112BF0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SavO08MaDPl/5u9t4p9+ZotW2Icjz6Ow75iW4vajjsfwV26pnvWXW3rVgEaBexBy+4M0m/cPo17OM6k1EhAZdWrRnpOeUIqrnKGg01v1JDExfKDZH3noUIzlNhiorZzLVCb1ZxFpazbVzHvi2eeR02P5ZWTiYeWkhhrxTQJWv+k2djmCwwkwbh0aCZnCA9LCj7Ed6iJOnCUFdMd3nFjFBm9WugDZTTt4WN8I9d0ELUWCTFqL9qQcDi9DTvy9jWMEXXRMHh6u3+xc0iV+vR718FJl3jSRM54WqTHyslOIy9ZiQqPZuYK4isPb1pQAtHBHNzkAb5qcfglxsFdZml5THQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTWgvfqEq+YcviQTaFOcItGnsdlcTm6L40t9p3Y0qgM=;
 b=UnIuxh70hvMWXVMxbrKwHdhlXaFYGLLGAnbHczfgCwIu6vbUhYaNNiCPVtVJ9dPctMg8hMESnpay2hd4327gCAQNrufj7eFtm73TAa4dMhikW8WEsYQyaW7xnKK925EiDsC36nmSVehzMc/QPc5sLPCJymg6G3t3fN6ARx63gFQf4KgQ6pWg470LFX58jTh6twLgFsD6T6HeaBmHEFlE8bo5E6Om1/UvlvUCKmyF1MZGZgc/tyfPeDWUHoUPJcT0gQPOV41BHjZTuqJmVQ6JHbj6l90vS+9ap9vOgU3uT4670ASn7LrQ7I9Y//wMoUgkXXK7taOAts7toUysh2yPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTWgvfqEq+YcviQTaFOcItGnsdlcTm6L40t9p3Y0qgM=;
 b=Y0m1ajpJpMxRyuePXDg6PoFHKV/3tLr1xPgPEL0L5aG6eN8vNlU8lxYM1FL3AHnZdBkmRW7KZDpDcpCHhZMIbggCPyyjfdWo00b11LZg97GtoVjCCiobDwJJukOJYGcMr0/s6yU8ynzE5dq49l8HS++4vaFUXe3aFVVzKAA7RVk=
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.39; Mon, 22 Apr 2024 15:29:56 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::4a) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.32 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:55 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:29:49 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Swapnil Patel
 <swapnil.patel@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 17/37] drm/amd/display: Add dtbclk access to dcn315
Date: Mon, 22 Apr 2024 11:27:26 -0400
Message-ID: <20240422152817.2765349-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: d99b889e-f3a0-43dd-5fa3-08dc62e11035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5yDicy/o7IB63NTiI+zNtjKWM6RlvDx+Ys18NQMPCq8sly1NFrhEdqKHlcl9?=
 =?us-ascii?Q?ZvquxYQ1/ZcCLJgPXBrjyEShHyDXBM0DmK3kveRf9RIvOjuV37vEsSV+QJzr?=
 =?us-ascii?Q?BcWRkSGjhIvLLNJj+xeDTbXkwFz4bsd9UfEsABIxwuj3iAwS7SOyNSZAYC1M?=
 =?us-ascii?Q?PEBe4DjnGcqGWuhLNHga5gAvIayUVGxWA1cdNAZL+Qq0Td19KqAVkjcO0ScJ?=
 =?us-ascii?Q?vnSKTRzei6BuvEgPwHQQAoewxoxTDxXZySgXri9l7h+K9l6moArxnb80xJ4l?=
 =?us-ascii?Q?SXPAptt5uCeRbZciFl1rSUVbUP4SaJ/xNr0XMCLPYJjsLEY5avzCBphP1ZQs?=
 =?us-ascii?Q?Am1vX5lbhZSHBxCwEJ/Hj6L+w4UFOlM1N8Qj160f4J4KTgVZo765Ye/oI3Yv?=
 =?us-ascii?Q?3no8Nm3ZNCjdHK/Ff2OKVJHNaUp1L894UuGPnk/aK3g8yhTVWJHZ7PEG2BKe?=
 =?us-ascii?Q?igVLB1vet0G4PNCFCMciOdCf1n5U/LMCeJLltNvgcB7sJO5izb+sNcVirsbf?=
 =?us-ascii?Q?OcefA+FXG2sIxEo8uQ5nuUer/bfhbddjYhcC+xQovgpSh+mEMUG1TuXAzP3z?=
 =?us-ascii?Q?beb3nolh0bRJkP2IQYd0ELZ4Vb8z74Rc1aV/IjCl7gg56FoQy2+tbdqXlMA+?=
 =?us-ascii?Q?EEL5KSNB2H4sHeG2se60zp0U3wT+AiEGmAFwGo5Lcx2wpX0OxrF0uHPiZYb+?=
 =?us-ascii?Q?iuazAXxCvSoWAbeuSsg887+KVTZ73JfoPe++H249WTembjWxino/MHSISlyN?=
 =?us-ascii?Q?4fruCLn7vYJ0MolwQ/8448ishO+zxkajIAhOiJSupE3Kyf0cCg5uO3IG0Qs+?=
 =?us-ascii?Q?7eqf2ODRpiQVjIg8Zep/HHgm01S7Qkh9Uu99s9NBUW5Bfa2iIishuVdx9hT+?=
 =?us-ascii?Q?cH68CiKvh/GpFQZjX+9UltosgYh90Wmnu9LwhTq5WiHLpwot24jaoZiw1frv?=
 =?us-ascii?Q?10rAOfQaIE1rcykCjdXV8erFBtBDUxUH+DBUjb/cB4b82sc1s1QBGmlRWTr8?=
 =?us-ascii?Q?psdK+8RnVaIWOtgOoHWvzYxSME7kNBlIxYf1nfcwQYSfloZL1J3gyIIqDZGk?=
 =?us-ascii?Q?PGRcYfNsNCrGScEMQkVIn81PIM3XvNaSIJfysGtXrI/igb+P7rNJYlTVmNLV?=
 =?us-ascii?Q?HpzNXPqHOJ13cJr6IiTOXAoPCmHpZLihNzSK8opBu7lPyN2ZarP2MFlzSukc?=
 =?us-ascii?Q?LIKcGln6tiaVnR1Lb/0KWw8GYYlVkgd/tiTpd5Ao8QZjGD9w7bS0Ov9TTZ/S?=
 =?us-ascii?Q?VEaBg+h3WoOCFtlYRN2/hzblSaZiZEtAeT1ycd4ID6ldahRYlH3PAcckd5kF?=
 =?us-ascii?Q?xPS7m0CPH/MRynbJMFYeAF4uqKJnRxEbkk+nRHawX+pjBUwagUim7XLqVmy5?=
 =?us-ascii?Q?heSWmGTv3OPDBk4FZBSlq9okVPzL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:55.7458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99b889e-f3a0-43dd-5fa3-08dc62e11035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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

From: Swapnil Patel <swapnil.patel@amd.com>

[Why & How]

Currently DCN315 clk manager is missing code to enable/disable dtbclk.
Because of this, "optimized_required" flag is constantly set
and this prevents FreeSync from engaging for certain high bandwidth
display Modes which require DTBCLK.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 644da4637320..5506cf9b3672 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -145,6 +145,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	 */
 	clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 	if (safe_to_lower) {
+		if (clk_mgr_base->clks.dtbclk_en && !new_clocks->dtbclk_en) {
+			dcn315_smu_set_dtbclk(clk_mgr, false);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
 			display_count = dcn315_get_active_display_cnt_wa(dc, context);
@@ -160,6 +164,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 			}
 		}
 	} else {
+		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
+			dcn315_smu_set_dtbclk(clk_mgr, true);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
 		/* check that we're not already in D0 */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_MISSION_MODE) {
 			union display_idle_optimization_u idle_info = { 0 };
-- 
2.44.0

