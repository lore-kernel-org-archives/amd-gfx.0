Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51110C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D0F10E3C5;
	Wed,  5 Feb 2025 18:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MndjJw7p";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50A110E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KT8UfVc850EKcg6LalGGlzVLwKNZqcEGP3FhN6zAgA8uoVqhRkVLCem1AObH7ibmWhDfP/QeYgId71n1xuX2RGALzw33p3Pbdxt47LdFzQu63uspXqAVe+sEd5MUbp+OAiAmQ4HZ8um0mRKrJIfU2W3Uy6tvIK5WDNAPXvJxmyz20XXHbY41aTGvwvr5lyHJ7dnWsRsmR0PcM6qStF0VutAuq3429dbG9iQtIlpEz/cQ8c/lbzh7Yjh6A9gPyxbAmAHn/ByQ15NqQGPtzAUlC9mDc/o8iY83wJx965pzvqG87PHZ37NA1cnbshYOgBStZw3KsL2hB5gTgLfJD1lA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoPcD+VBEjX/9UIXxCDHVT8lDBsXD1LKhgoR+m8k2eI=;
 b=LZPLd3s+mW9cNnWSyqCFJqiUScO6FtQVnfbCEkPELEEiUAheBdlpgUzrbz3ZEElFeEgGONXiI4JvpooqaATdqqlj9m6cHDU8mQ0kEllgWV/cNeFbGSgX9TfrxITNa2q3OsdQeuUSLDllvEXHiLGOI4JsAKvvzyHUNd4DIxkvm99KaaCr8tFKLEpEZzLBZ8MMGRZ4qz4fZT6aJztylH22j//H4TDDT76uvKkdlwzYeKFJ4R9x6S49C3Ns8ZMszK11OnnqVgK1rkXlb3+gwdxNKhGvBZEdVWsr9cyytjUob8ufRj9L6W3Nu/E+4M6QI/jXOGWwAo3VIrJalbyTf2aSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoPcD+VBEjX/9UIXxCDHVT8lDBsXD1LKhgoR+m8k2eI=;
 b=MndjJw7pnOE1lAlmi2YCnxi8OJSAdRz3tpTLysCw0T68Hj5O/cvL5iZXMpIZQOQgW0iyU/Iu/Hd6f4KNXHlhv8TPUuN6J1bRpfmxcibRaJxXgoZ/a1qbcew2piRbfnSp+zhpSCsv8+2TLIc+AQ8vG6kUT5WEkFZKF2L1RY2PAUk=
Received: from MW2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:907:1::20)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 18:41:16 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::4c) by MW2PR16CA0043.outlook.office365.com
 (2603:10b6:907:1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend Transport; Wed,
 5 Feb 2025 18:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:41:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:10 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:41:05 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 11/14] drm/amd/display: pass calculated dram_speed_mts to dml2
Date: Wed, 5 Feb 2025 13:39:26 -0500
Message-ID: <20250205184036.2371098-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: f903784e-1f72-438a-a91c-08dd4614ac17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kkft+D3PTO2TJt/sZa541OblKOL8MXo8gZiT1ONPjXppRyVw1/EjtRYmtAq9?=
 =?us-ascii?Q?JC//vQ4RDwbMLXQpIocqMGDyx136Xk/Jcv9QFgTVeoqMWnoiV8U0CR3PsnVd?=
 =?us-ascii?Q?xArUKgqfmSplQHUdaSaNnDkprbxngGnz6KcvZjzlpsGVno9DRekNURjnItSz?=
 =?us-ascii?Q?rKVJ9yHtho4+jut4B8goM994hxRZL8qFTYLE1GuQntJhVt2bdYyn905m5yfu?=
 =?us-ascii?Q?4BBWtyTHqnBkWsL+rhX26kLcdSdHI92J4tuK7G3ZoIN67J+aOYP5uXxOotZF?=
 =?us-ascii?Q?rHAkzc1kcVZgQ1zXc8eVTQF+/REhKbra46fGga1A0MD5sZnkBDzf1FQhaj6j?=
 =?us-ascii?Q?eIt0BfKVFY7zgG6f+oC4VBpiX7yGG2mJ/RHj5G3aCr3N3WiI9A6b1WpizkkH?=
 =?us-ascii?Q?3uCnXvjldawlpWX68CPnl/VIf2ktQURzGJkZ6jkO9J8eAZHKwkuSkUEQz1zg?=
 =?us-ascii?Q?ZeuYTdbPTpvpoSi9CCoy3SA2TiH7xsISW0KtQyqwqG9sKxv00MrlTOI00YKo?=
 =?us-ascii?Q?ph0HQCzalS5Qt+aStiWTEdupad1FRHNRhH9XLIbQhaokNGI1T7RFdw4BFqj5?=
 =?us-ascii?Q?qZUy8wdsHRM0rFE4mrKCJ9btjfkQUBF2ClT4m6Gp0quqIm8Fhs++G+2r07+r?=
 =?us-ascii?Q?VTZN4VnzkG6BY/um0jBbjXrtekWoT42dZ62kkZoICojt3QUKm+SXqc7g60kt?=
 =?us-ascii?Q?KTJIqPK9laZAs+Xjr6lUSH24Cq/PODnESrmRxGFrd840lzDqCjR2Q1vDqJGX?=
 =?us-ascii?Q?7WmozFjsp7Qnf1UlqxmjPYKjRFfy7IOjnHkoqsS7I25brbll93AV9v1zs24I?=
 =?us-ascii?Q?SmwXXkk+ChktpqOhsIuN6lEuhDmSApRj6sW345oxn85sMj4Mg66Ucqw/zBlR?=
 =?us-ascii?Q?xUVpEB1rtzUaqfUf/lGV1xJNPcP9x30wqxZ4HHAQyvOU50YAD/xeq9cUhsTG?=
 =?us-ascii?Q?RKZMqunmQ1wIrLZLUoLiibEYdNyWLmRmSvY2xHSSdCNl6SSLGb/N6/ZtNzej?=
 =?us-ascii?Q?Pk6F7p+J4eIdcc4spFDQAYYg+rdzsMeq/zUzdZ8VSTqNVi78krplgNaeVzJA?=
 =?us-ascii?Q?ctaIHAqQfUrHtJ08vtaOjAwkHjNBXhQD0Rymg8argKefBeEcvbiocS+ZmfHB?=
 =?us-ascii?Q?hYj5xQuTZvnGywM72aoJFcQhkswGYvcx4Clkc7XJOsxN3jO5XtThsX3neM0M?=
 =?us-ascii?Q?SgIX4/KgmXBC7n7C3EvkXBTxAPoibQtuDx8dM3/Qk50F9o20A5sboaCbY07D?=
 =?us-ascii?Q?hWpHJxuIRZSgP7fMk2IDAWdTdf1RtRq3C5fwwTQELQ9r9vO9JqihKONaoasX?=
 =?us-ascii?Q?ECP1OPwQ1n33AJFJWej0eJ9o8k3HRuBgi0COZj8b5eHLVDw+mZmRtFoVf3Ex?=
 =?us-ascii?Q?Lrorbvb+iIuNkiqshTlZ2NAXn14lZaGWO0HxE6IVzNQchOl/2Lc8n/U56I6C?=
 =?us-ascii?Q?+CfCVXKr6iX6YjqPTwbODhMoglyl/J49l18JMR5lgNXPtCunW2TTPIpbgvW9?=
 =?us-ascii?Q?0KgwJcRqCabSj3Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:41:15.5437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f903784e-1f72-438a-a91c-08dd4614ac17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
currently dml2 is using a hard coded 16 to convert memclk to dram_speed_mts.
for apu, this depends on wck_ratio.

change to pass the already calculated dram_speed_mts from fpu to dml2.

v2: use existing calculation of dram_speed_mts for now to avoid regression

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c | 1 +
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h     | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 47d785204f29..e8efffcc69a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -367,6 +367,8 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 				clock_limits[i].socclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].memclk_mhz =
 				clk_table->entries[i].memclk_mhz * clk_table->entries[i].wck_ratio;
+
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dram_speed_mts = clock_limits[i].dram_speed_mts;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz =
 				clock_limits[i].dtbclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels =
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index d9e63c4fdd95..17d0b4923b0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -401,6 +401,7 @@ void dcn351_update_bw_bounding_box_fpu(struct dc *dc,
 				clock_limits[i].socclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].memclk_mhz =
 				clk_table->entries[i].memclk_mhz * clk_table->entries[i].wck_ratio;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dram_speed_mts = clock_limits[i].dram_speed_mts;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz =
 				clock_limits[i].dtbclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels =
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 0f944fcfd5a5..785226945699 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -159,6 +159,7 @@ struct dml2_clks_table_entry {
 	unsigned int dtbclk_mhz;
 	unsigned int dispclk_mhz;
 	unsigned int dppclk_mhz;
+	unsigned int dram_speed_mts; /*which is based on wck_ratio*/
 };
 
 struct dml2_clks_num_entries {
-- 
2.48.1

