Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BFEC3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1952410E4CA;
	Tue, 30 Jul 2024 07:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f2LJh3d7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F19C10E4CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+YRy5Fu6B+KIqyVObnRBWtN+DCJfLDeW6t03ZwmKNu0DyZ/uEVVrmJavBC2Oaaow7MVMLj3s7vgjv2LvY8mVxwjHF6wXeZ0hVMq/4GySQrc5RIQ8apPYZILyqkPmd8pEodGcHdyIWVDjKH6v3AnpmA0dq8OEGrpSqJVuPtaK/tm6/xQG4A/5GxEoXoFCXrG8ZIHTu8rZA7GEg9Okh2yARoiKABB9q11n3oFNwugvN0oS6r0ofl+dHN7FxnQGst8qV+jeTdiR62uHaGPZaoniK+TERK3yoDEh/Tcc7S96/W9HFeMXnCEwQS04WWq4yCjGPnaZU080GLmhJ7YktgQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqOLXgHmkyJ6mQomf4q9gtRuMLiJWW7XwXiN4TR+9RE=;
 b=DoUhSTr7aXyKF8jwHi44F0YSnxGgObdLdXuy/F0jUmfq6uuNyERz29TfeNGT1Pp9GGarWJZGmWSKCDs15/uLdZix9RxSuWnInMsrVPgP53KSjr/fSen08DmjWtOExJH1cOEYqF97un1+hjOw4TODQSamUCVby05mzM56Blk0hr7/AkI3TjW88wkMMz5ELjncs7dAwT4vtElOz1kR7BJhCUQauydhQz3TKZmZZtRIJA/XPY2RrCeqcAxXswMifJ+4PzrTBVHkwF9231nFo7YXhrGn7ETlB7LFXFgYKWxF1JpMHEynYEGja0tHrzpa5XGIf5XdPpO/A2rcRxZ8LMI6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqOLXgHmkyJ6mQomf4q9gtRuMLiJWW7XwXiN4TR+9RE=;
 b=f2LJh3d7Y/NmA8NcVFjqUc03fMYhOGUCzZl8nACxZd5vbNzWQap9LTFMlL2jSD0wVneeDzQkrokH80ldxZLUEUMObC3DO6C2dQwgp9LVzPOH9dk1IavoHlbfw84RmvwuQEyYcDiQYU4v8s2rKHphy32P84/6rxf30wz6zouZjUg=
Received: from CH0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:610:75::8)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Tue, 30 Jul
 2024 07:22:12 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::fb) by CH0PR04CA0093.outlook.office365.com
 (2603:10b6:610:75::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 07:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:22:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:22:11 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:22:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <Hansen.Dsouza@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>
Subject: [PATCH 19/22] drm/amd/display: Add clock control callbacks
Date: Tue, 30 Jul 2024 15:18:40 +0800
Message-ID: <20240730071843.880430-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdc46fb-ea21-4189-8879-08dcb0685491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OYlRwHUc4jvh5+leEDjGYuJupAslMAMEE9WkOiKWuus9zjXeUqpzwPR3zt5H?=
 =?us-ascii?Q?JRpxUZsSUxH5WZq/K/djAKAApEaCpVcoE2I/Zl53mKxAAfTYG4Louyk0aH9Z?=
 =?us-ascii?Q?KpyFgrrjg4OF1V9cJ0lvx0fEo9XNQGBpP2qdfTMgCtrmFjPaUnYf+02/m5To?=
 =?us-ascii?Q?6zFTYS+yfRWwSlIcjInfSSkXml8yEtayKWtERvHoJIKzKrCGZnWMhWHn3YLQ?=
 =?us-ascii?Q?gXi/ZUYxxdt4kEzBlvmU9Yy/6Ib+MrImo99c/H4cp+TjmgjxSXAaCqBnzywf?=
 =?us-ascii?Q?z6zz5MLeguWJ7ekpSQJTmzP3hQ7sj2QkxoVsGSIkSwMKIDdxAgRjqsnDzMT4?=
 =?us-ascii?Q?IVlnb7WdnjN42AHe2VG+UGUfHAnL7AJcMY+ntlb5R74bh5G43ycfscDxo1Pg?=
 =?us-ascii?Q?CG3kJxDzOOT7MlxQ03uPRv2snbW2qupcg0HQYwrTyR2RIa5dE8x+GbqtmK9O?=
 =?us-ascii?Q?GyikVbdN6TTdHhgp0YP1E3ElSNgXP4jbk1NSRPJ4KWxEAnD+SU1O8C+hXWDP?=
 =?us-ascii?Q?sCkCKMGXuNafU1rmPVHOAF3+z0dRlHfZXYS6Xq67UHJ8+Dd1mHn1NadMY4un?=
 =?us-ascii?Q?mrhapFp1nGny5VRkDga5+N+Z1/NQy6jEPDSkuh7GBjM9SPGhM+GZ+GMqTWNg?=
 =?us-ascii?Q?pHIn71SFDuLZgWghXUYDqL4FfrND692pSBcbh6PPgqb7U4P75vbdOjKn5AgK?=
 =?us-ascii?Q?tirYv7Z8RXz9YwjJeAfNjhP5oaiYdATcRMx0QeJiczptLdkLGRFfJ2Bzjcol?=
 =?us-ascii?Q?aWe9BBb93bOCNlMbCu7YY3/UVGnh4wllN2Hj1xXfSZX12bEL8ThlDMBmT1Q7?=
 =?us-ascii?Q?pEV5UIzHbE3K35AlLsQNQWplRQbw6I5ZPFhzPbcKFFCpRCpnq3NDC1lAlWQS?=
 =?us-ascii?Q?vQ2KPJt02HrUsBiF7j1p/Mg2qAkqFyqUOBUjFfGdvG1vwT3HM1+sciATfZNo?=
 =?us-ascii?Q?S1pkMh9OuJyhyDYNF4mZUi+nlyee2AMV22Tk21uMCgueq6tk0DeC0Xcxpjlh?=
 =?us-ascii?Q?KssguOLAX0ZrBhxRq9impIpc2p5UkKC+LavSW7dDatjJePCMtH4ptV8X+cME?=
 =?us-ascii?Q?WioPLU/L4iLoLCIi1EOXux0GqGiGyvj4JHqt4yhqIBOBhl9UM5qjYfrnVNZL?=
 =?us-ascii?Q?Fiwkjx76JfPgvzfR08iuWr+qkxrVVmALkkh+bXgt2JypMkRpSz5GTH5LjOf6?=
 =?us-ascii?Q?dtBDnylEdfd4YGgvWd2474cEhTxNlrSGyYyZqPFNoqwZCRktEbsrULw+cef4?=
 =?us-ascii?Q?sIAQJy+Hk7tkc5pS+dMxaquW66sgSOEqlY0QHhR6+CLFyRWa3yjMbdrxsq7s?=
 =?us-ascii?Q?Qhw9qAXIez00OpnVe2dQh7IYHhbFPE7ZVw9Eiwtn/f4FGcUj299wDLNkzhW/?=
 =?us-ascii?Q?c8oQS/O39827MVtLs8z61DC/KBMqOgIO+5d3Vg8xAoTwC1pRQ8Rwlt9n7QQ9?=
 =?us-ascii?Q?OQipWNg6TCFl1CBoJgVP9wwNRcRY9Wmq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:22:12.0897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdc46fb-ea21-4189-8879-08dcb0685491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[why & how]
Add clock source selection control functions based on spec

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 153 +++++++++++-------
 1 file changed, 99 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index b4f441c405bb..7f91e48902e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -980,6 +980,21 @@ static void dccg35_disable_symclk32_le_new(
 	dccg35_set_symclk32_le_rcg(dccg, inst, true);
 }
 
+static void dccg35_enable_physymclk_new(struct dccg *dccg,
+					int inst,
+					enum physymclk_source src)
+{
+	dccg35_set_physymclk_rcg(dccg, inst, false);
+	dccg35_set_physymclk_src_new(dccg, src, inst);
+}
+
+static void dccg35_disable_physymclk_new(struct dccg *dccg,
+										 int inst)
+{
+	dccg35_set_physymclk_src_new(dccg, PHYSYMCLK_REFCLK, inst);
+	dccg35_set_physymclk_rcg(dccg, inst, true);
+}
+
 static void dccg35_enable_dpp_clk_new(
 	struct dccg *dccg,
 	int inst,
@@ -2138,11 +2153,62 @@ static void dccg35_disable_symclk32_se_cb(struct dccg *dccg, int inst)
 	dccg35_disable_symclk32_se_new(dccg, inst);
 }
 
+static void dccg35_enable_symclk32_le_cb(
+			struct dccg *dccg,
+			int inst,
+			enum phyd32clk_clock_source src)
+{
+	dccg35_enable_symclk32_le_new(dccg, inst, (enum symclk32_le_clk_source) src);
+}
+
 static void dccg35_disable_symclk32_le_cb(struct dccg *dccg, int inst)
 {
 	dccg35_disable_symclk32_le_new(dccg, inst);
 }
 
+static void dccg35_set_symclk32_le_root_clock_gating_cb(
+	struct dccg *dccg,
+	int inst,
+	bool power_on)
+{
+	/* power_on set indicates we need to ungate
+	 * Currently called from optimize_bandwidth and prepare_bandwidth calls
+	 * Since clock source is not passed restore to refclock on ungate
+	 * Redundant as gating when enabled is acheived through disable_symclk32_le
+	 */
+	if (power_on)
+		dccg35_enable_symclk32_le_new(dccg, inst, SYMCLK32_LE_REFCLK);
+	else
+		dccg35_disable_symclk32_le_new(dccg, inst);
+}
+
+static void dccg35_set_physymclk_cb(
+	struct dccg *dccg,
+	int inst,
+	enum physymclk_clock_source clk_src,
+	bool force_enable)
+{
+	/* force_enable = 0 indicates we can switch to ref clock */
+	if (force_enable)
+		dccg35_enable_physymclk_new(dccg, inst, (enum physymclk_source)clk_src);
+	else
+		dccg35_disable_physymclk_new(dccg, inst);
+}
+
+static void dccg35_set_physymclk_root_clock_gating_cb(
+	struct dccg *dccg,
+	int inst,
+	bool power_on)
+{
+	/* Redundant RCG already done in disable_physymclk
+	 * power_on = 1 indicates we need to ungate
+	 */
+	if (power_on)
+		dccg35_enable_physymclk_new(dccg, inst, PHYSYMCLK_REFCLK);
+	else
+		dccg35_disable_physymclk_new(dccg, inst);
+}
+
 static void dccg35_set_symclk32_le_root_clock_gating(
 	struct dccg *dccg,
 	int inst,
@@ -2251,6 +2317,37 @@ static void dccg35_disable_symclk_se_cb(
 	/* DMU PHY sequence switches SYMCLK_BE (link_enc_inst) to ref clock once PHY is turned off */
 }
 
+static const struct dccg_funcs dccg35_funcs_new = {
+	.update_dpp_dto = dccg35_update_dpp_dto_cb,
+	.dpp_root_clock_control = dccg35_dpp_root_clock_control_cb,
+	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
+	.dccg_init = dccg35_init,
+	.set_dpstreamclk = dccg35_set_dpstreamclk_cb,
+	.set_dpstreamclk_root_clock_gating = dccg35_set_dpstreamclk_root_clock_gating_cb,
+	.enable_symclk32_se = dccg35_enable_symclk32_se_cb,
+	.disable_symclk32_se = dccg35_disable_symclk32_se_cb,
+	.enable_symclk32_le = dccg35_enable_symclk32_le_cb,
+	.disable_symclk32_le = dccg35_disable_symclk32_le_cb,
+	.set_symclk32_le_root_clock_gating = dccg35_set_symclk32_le_root_clock_gating_cb,
+	.set_physymclk = dccg35_set_physymclk_cb,
+	.set_physymclk_root_clock_gating = dccg35_set_physymclk_root_clock_gating_cb,
+	.set_dtbclk_dto = dccg35_set_dtbclk_dto_cb,
+	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
+	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
+	.otg_add_pixel = dccg31_otg_add_pixel,
+	.otg_drop_pixel = dccg31_otg_drop_pixel,
+	.set_dispclk_change_mode = dccg31_set_dispclk_change_mode,
+	.disable_dsc = dccg35_disable_dscclk_cb,
+	.enable_dsc = dccg35_enable_dscclk_cb,
+	.set_pixel_rate_div = dccg35_set_pixel_rate_div,
+	.get_pixel_rate_div = dccg35_get_pixel_rate_div,
+	.trigger_dio_fifo_resync = dccg35_trigger_dio_fifo_resync,
+	.set_valid_pixel_rate = dccg35_set_valid_pixel_rate,
+	.enable_symclk_se = dccg35_enable_symclk_se_cb,
+	.disable_symclk_se = dccg35_disable_symclk_se_cb,
+	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src_cb,
+};
+
 static const struct dccg_funcs dccg35_funcs = {
 	.update_dpp_dto = dccg35_update_dpp_dto,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
@@ -2296,62 +2393,10 @@ struct dccg *dccg35_create(
 		BREAK_TO_DEBUGGER();
 		return NULL;
 	}
-
-	/* Temporary declaration to handle unused static functions */
-	(void)&dccg35_set_dsc_clk_rcg;
-	(void)&dccg35_set_symclk32_se_rcg;
-	(void)&dccg35_set_symclk32_le_rcg;
-	(void)&dccg35_set_physymclk_rcg;
-	(void)&dccg35_set_symclk_fe_rcg;
-	(void)&dccg35_set_dtbclk_p_rcg;
-	(void)&dccg35_set_dppclk_rcg;
-	(void)&dccg35_set_dpstreamclk_rcg;
-	(void)&dccg35_set_smclk32_se_rcg;
-	(void)&dccg35_set_dsc_clk_src_new;
-	(void)&dccg35_set_symclk32_se_src_new;
-	(void)&dccg35_is_symclk32_se_src_functional_le_new;
-	(void)&dccg35_set_symclk32_le_src_new;
-	(void)&dcn35_set_dppclk_src_new;
-	(void)&dccg35_set_dtbclk_p_src_new;
-	(void)&dccg35_set_dpstreamclk_src_new;
-	(void)&dccg35_set_physymclk_src_new;
-	(void)&dccg35_is_symclk_fe_src_functional_be;
-	(void)&dccg35_set_symclk_fe_src_new;
-	(void)&dccg35_is_fe_rcg;
-	(void)&dccg35_is_symclk32_se_rcg;
-	(void)&dccg35_enable_symclk_fe_new;
-	(void)&dccg35_disable_symclk_fe_new;
-	(void)&dccg35_enable_symclk_be_new;
 	(void)&dccg35_disable_symclk_be_new;
-	(void)&dccg35_enable_symclk32_se_new;
-	(void)&dccg35_disable_symclk32_se_new;
-	(void)&dccg35_enable_symclk32_le_new;
-	(void)&dccg35_disable_symclk32_le_new;
-	(void)&dccg35_enable_dpp_clk_new;
-	(void)&dccg35_enable_dpp_clk_new;
-	(void)&dccg35_disable_dscclk_new;
-	(void)&dccg35_enable_dscclk_new;
-	(void)&dccg35_enable_dtbclk_p_new;
-	(void)&dccg35_disable_dtbclk_p_new;
-	(void)&dccg35_enable_dpstreamclk_new;
-	(void)&dccg35_disable_dpstreamclk_new;
-	(void)&dccg35_set_dpstreamclk_cb;
-	(void)&dccg35_dpp_root_clock_control_cb;
-	(void)&dccg35_set_dpstreamclk_root_clock_gating_cb;
-	(void)&dccg35_update_dpp_dto_cb;
-	(void)&dccg35_dpp_root_clock_control_cb;
-	(void)&dccg35_disable_symclk_se_cb;
-	(void)&dccg35_enable_symclk_se_cb;
-	(void)&dccg35_enable_dscclk_cb;
-	(void)&dccg35_disable_dscclk_cb;
-	(void)&dccg35_set_dtbclk_dto_cb;
-	(void)&dccg35_set_dtbclk_p_src_cb;
 	(void)&dccg35_set_symclk32_le_root_clock_gating;
-	(void)&dccg35_disable_symclk32_le_cb;
-	(void)&dccg35_set_symclk_be_src_new;
-	(void)&dccg35_set_symclk_be_rcg;
-	(void)&dccg35_enable_symclk32_se_cb;
-	(void)&dccg35_disable_symclk32_se_cb;
+	(void)&dccg35_set_smclk32_se_rcg;
+	(void)&dccg35_funcs_new;
 
 	base = &dccg_dcn->base;
 	base->ctx = ctx;
-- 
2.37.3

