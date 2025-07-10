Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F66C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D23510E96D;
	Thu, 10 Jul 2025 21:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IaO8r32C";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDF110E96D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjpaR4QMHj2AWbQnSSXHM5WnT2rNlkmbsiTIxU5NrbbCFY/4AS9aBJaGY0IbkMzp0tYHaQYNVn0SH9Jug4tbSnB7kqZ0GHUR/Gu92IWbH60LSGJMMWXZeDzjHKJSUIn1z59l5DXz2fh33pigCW/51DwdFG3Se7nE1nS/AXphDm98O0JjsRehsWstx4uBzWWiNv/prcOY3Q6kMOwy7AAyU8h3G8L5kJlZ7gi200HHy5rXyjwUcZz7FymtaP1B3GBo2PSy+PMUc9/1fEuyPZx8fQA0zkK6q3DSL7E8/En28HczA5NuRFM5itSetITx58xqmDq1W8QrKULQamwrXlIfbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH/k84R2U+MjpQG0/vi6+oecCHhBTFhH+tB20g1ZSto=;
 b=P9GLG2l8kRggvazT1XxwY45imDBlBTXjEdoztS/aFMAbXdcEd800tqDU+WLYFhnK60LPq0Z7uMImuYiz48vFsueFrAJjq3wiQSF4K1vad8WFIo/1fRMxzed+LvYVumrSBTbKLPpnUKwg2OaUJQtFLioBDDDD8pWsZj63we/66TX/NCg26nz3kmaMmI6j4tnsbr1HjCsQCWZJiOIez8KI7NcRjzyzelTAyyTV44WV6jimBd+nbM4vyT4BUZpT9+LJ29n7vfa7F9HGagkrJqQm58QhbEip1pld9ZeqF1YyC2OqvdL2JXqXPLQxeMtwfrgEFi9pluV2fbqfWxjvqwzang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH/k84R2U+MjpQG0/vi6+oecCHhBTFhH+tB20g1ZSto=;
 b=IaO8r32C7Xl7wWub6Q+zWqn8cO1DGILAODMtWJYfypfxB+PazrJKFbL4PsoVNeViOoXPZjsvK6fMfnPpjQkObjo4g6XMTd6R+3PCOxJPYv1SJjtpTWdWJHTzNUWWZydfNY+JkLfha++YlFi076Aaa0anrs60rZfs/PU1c+xWcHI=
Received: from CH0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:b0::9)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 10 Jul
 2025 21:31:17 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::e6) by CH0PR03CA0004.outlook.office365.com
 (2603:10b6:610:b0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 21:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:03 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:31:03 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Leo Chen <leo.chen@amd.com>, 
 Duncan Ma <duncan.ma@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 10/18] drm/amd/display: Add static pg implementations for
 future use
Date: Thu, 10 Jul 2025 17:25:43 -0400
Message-ID: <20250710212941.630259-11-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b0d623-cf31-4240-1d98-08ddbff91adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PYlw3XKcR+smvzARmbo4litQlrOP0N9+7PGO6u1/bZ7A+zQyF+gxd/ka2w41?=
 =?us-ascii?Q?TNCyo7lrOqVppH2Cn9uDzAl9jwS+s76KthNyKQ00iqowsCz7gkYhdM/98J/M?=
 =?us-ascii?Q?oWyTGWRpoNToXoDYttCMLKHuBvMR0zaSaVxJ/sRkRybA0Wf3EHQ7AxvCit/u?=
 =?us-ascii?Q?oEGv7DvoNE87pI7KwB784dPu5Pu+KyEnayHtlVQKGT465IwaU3Y5zj0P2FAw?=
 =?us-ascii?Q?IQy0TMhuws0a6hkUqsi+ojc3NrMahPx5525VMljkBzHSXrK9hz/aH6ozahjN?=
 =?us-ascii?Q?/xQiMXfuOF/88rjmAhlmqeg9ow2Yuus+AuFsVmch+p+ri4fP3Vji4stMSKcF?=
 =?us-ascii?Q?t3jcy3pOrX0Z+VsGOINeKlUWpkvTwvJVxYnWYfBd3hVP4BRJbVyl2RMe7TZ3?=
 =?us-ascii?Q?eoC3b26u0QFXZeTgBZWXqmvZRitkWNv57sOrrh7hym9U86GTaSqoPLaF57+6?=
 =?us-ascii?Q?8lvTS+OR+rDxCPt2nkJwgn5E0uOL87Yl/YWk+rZai4/k/mSK+b3QQGSSp5Rl?=
 =?us-ascii?Q?WYgVOgKZM5+2xnGCNgRND7wxxYSMcp4fMX2pIjLsEuHGdhqCyJ/KiDl7Igwj?=
 =?us-ascii?Q?/GmhouoUpWk5uiEsGSQhyp/M9vX19+RNP0WuESBcyaC240Uag4GVtMRtyBwE?=
 =?us-ascii?Q?rn9HRGsvQdj4ycCmFGGDFYHvtf9E1rFe36ijvwIKyECLSs1VKx3Uu+VtkKLk?=
 =?us-ascii?Q?O7TAU2/HNwzZ4RE4GzNjFG+qHlgS1AGqAfRdaULwa7mfMTTEw5Lkg2b8iTE6?=
 =?us-ascii?Q?slbt5Zi8BycZ5wyX4GTz7PbZQaZQxMa5qIB0tPQ6rdBwlxoF8iLu2nqaLqIF?=
 =?us-ascii?Q?Cm7DIFSfMvm15PwenQ4zwojvrKiF0K8TsT+BcXeL0u6q1EzCYpZiXLroZaDo?=
 =?us-ascii?Q?30uHxSbQaYF9ryyuMBih2bIvd+IVcJ5bmtMO7H7saL+/p+E84gry/upKcwzt?=
 =?us-ascii?Q?NwIp3FwXe5ZECVpzRPg40mJPXBHzlMfDaYzQtZsLbG9z5U/R0AbRrN8zAhJ9?=
 =?us-ascii?Q?9sKdgFBGge8ChmlQWxLPwdwPGImYmOwIm+VnGx/b1D3mguuXg95BFq98qSky?=
 =?us-ascii?Q?1pPMV7GgN6CyqTOPyYiTIwcdJzZu036Mts+2xRC+Of/l43crFreP8Fy00c8v?=
 =?us-ascii?Q?ipzPkg3UECltdQnaCRNJs+vIpex8uQO1X4/6K43xwtyJ3nJUZ1t+uFJqJ4jZ?=
 =?us-ascii?Q?K0jlcaV9BsKbxYsT/t75GGp+gmbJsh9ZZ7qwnATF1eChFV15NKuA0aoYFAQ1?=
 =?us-ascii?Q?BA8RPnX7D5S5JFgHTaWnG9i8cS9FtAwLcd7s6UkH94+P22q53ZY5/xOtWVKI?=
 =?us-ascii?Q?H6+xtMP+Km5neph7G2SCSSBfkGK7u0IIflt3wkAlfkK2rfxLGTetyutOsqVS?=
 =?us-ascii?Q?+7syEDYahWUBaDFy2uuUW+gSlJHBQBIprci9Gvmp2RPdMLSjZVO8iyO+P2t4?=
 =?us-ascii?Q?vO16eq5jH5lVeSxhJf719vmRLVb9/Zpky2P44XCfxicdS4GtdM+PJKJqVWXN?=
 =?us-ascii?Q?C0g6WAzgHbbgbLO3uqi8KJx671oi144H45wr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:17.4254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b0d623-cf31-4240-1d98-08ddbff91adb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
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

From: Leo Chen <leo.chen@amd.com>

[Why & How]
Add static pg implementations and debug flags for future use.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h             | 4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8a09c5f487d3..b4fe5859fa5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -819,6 +819,7 @@ enum pg_hw_resources {
 	PG_DCHVM,
 	PG_DWB,
 	PG_HPO,
+	PG_DCOH,
 	PG_HW_RESOURCES_NUM_ELEMENT
 };
 
@@ -962,6 +963,9 @@ struct dc_debug_options {
 	bool disable_dsc_power_gate;
 	bool disable_optc_power_gate;
 	bool disable_hpo_power_gate;
+	bool disable_io_clk_power_gate;
+	bool disable_mem_power_gate;
+	bool disable_dio_power_gate;
 	int dsc_min_slice_height_override;
 	int dsc_bpp_increment_div;
 	bool disable_pplib_wm_range;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
index 00ea3864dd4d..44f86cc2d1d6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
@@ -46,6 +46,8 @@ struct pg_cntl_funcs {
 	void (*opp_pg_control)(struct pg_cntl *pg_cntl, unsigned int opp_inst, bool power_on);
 	void (*optc_pg_control)(struct pg_cntl *pg_cntl, unsigned int optc_inst, bool power_on);
 	void (*dwb_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
+	void (*mem_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
+	void (*dio_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
 	void (*init_pg_status)(struct pg_cntl *pg_cntl);
 };
 
-- 
2.43.0

