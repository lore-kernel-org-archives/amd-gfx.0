Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D87C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A5610E626;
	Tue, 21 Jan 2025 19:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vCyCoECc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F3C10E636
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOLwVmSZC5GGRCHOsTDJMWXNsHPhNKcYey+ODuVxShP9jl1CNr/Qvy98DF/f8+h9+Th9jfNMUGynMjRM++r/9E/oViNe8ReBbMcKWXCILr5WvdLCsfLlfYHvADu5RF4d1kSK6YmSWW8c42BDqsjHIo74NpGMiDWs/bsPeCaItP8Iql96xjrrd3aI28Pk4s4o00H+frJWVfblrlz1dt4x/HqFRcELYEGiJ9sNqFSdkBOfEy4Zh2ff3b+H2d5hnw2bBcMjERpKm+8q3ctqX1jQJngkfn6The5JFhMpAzFjvcIye2oDi4U9DH/xErGErM4ke2krYIKhKjf1aPrlqTeW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMKMXJNMytVwazyXivDvcbbSBZlHtJwyqHYmsyQmupE=;
 b=cFG061YRgSbc8AKiLXvTd8Ov7fYd19Nudr3r+D+kD/j+w/LwfoX1kF8Jg2lidVMaCfakv+nmNhOnMVpymOB8c+68wA7SyNq5fxS+izlae4aEfvtcCKaNR0SAZfJeY4bhb89sgEr87F8WLBuSfBxR2/1wpDRMESwzy+g4dMbVKcfzfeersDxzU4UnsoEA/xCkllq6vS9HJZV10yTn+HzKJVKY2HPN4+B+TILf7Lw5xIy1S8KUo9phCVnluSDVcNTAcrg8U3I98ZnUfPPFh4JY/3cFe3VDHwJu3zumcikbtZu9TqtLdpATKW/PaBwdLNgzRCymehszZW3YzEFiny44Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMKMXJNMytVwazyXivDvcbbSBZlHtJwyqHYmsyQmupE=;
 b=vCyCoECc3JoolmjE3RSJw7nW2DZCq5bAp8Ri/Rv6G39lacc3u7Ip325h+/NOfjQtQYkG62p37Xavb42QZj78EHBe4usr8VFV9FgvNjED2akx/IHsHP4Iczpt8LqEguIdJbaD3g1GPTbLjPTH8dn9DYrFchpePhIG1Q5uzjILUL4=
Received: from MN2PR22CA0028.namprd22.prod.outlook.com (2603:10b6:208:238::33)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 19:40:01 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::54) by MN2PR22CA0028.outlook.office365.com
 (2603:10b6:208:238::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Tue,
 21 Jan 2025 19:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:00 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:39:58 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Natanel Roizenman <natanel.roizenman@amd.com>
Subject: [PATCH 04/14] drm/amd/display: pass calculated dram_speed_mts to dml2
Date: Tue, 21 Jan 2025 14:39:09 -0500
Message-ID: <20250121193919.3342348-5-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e562975-a796-4bef-7bc5-08dd3a536520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NX5tSyatFUR8IGbfz4THk3mu12LA6v6pRPktQpNiOiLi1juXKOO2MmjJ97wH?=
 =?us-ascii?Q?33wZmZ/XY3rbtZl61u39nsUkGafhY1hcpuWrDBVr9aMActmXR6R+4elnc0tZ?=
 =?us-ascii?Q?83pLvhnm/gJOjrYUAddSyoLELj3jUDgni639wGJ1Wc7HhGRSmXg5MzR0aMFe?=
 =?us-ascii?Q?PhdrpSw+5D4rueHlT3oeicxMAhRLbxrQJ5AWFBhor7mes9QJNWHNSOf0TnWj?=
 =?us-ascii?Q?F12347LExlVeHL4gIjl1dcsAR4ImIxaOJGj3Qi9yzhcnMG3OJRS0cvXwdgoE?=
 =?us-ascii?Q?OA/f+bTTOTzsEM9TzUoZ4MybHII0Sj3CE/KQp9JllMz3uCYq1iOMQGGC7ZYk?=
 =?us-ascii?Q?dE0yhg8yZhdTs6lh21Xm7cz+DYS1NBurAbKQWygbu4u6GLNeIqaWLB10dhk0?=
 =?us-ascii?Q?XIJLnT4XBB0+UN5kBhkYWtTUhnu8lKV9qInwHI6YxRlBHmrQxgiWz9DMoGfn?=
 =?us-ascii?Q?XPIJyLwG9VH5us9MoJ85B0wyY/GwgGtbbVRepkNRBn8BQGRdMR4CO627ayvy?=
 =?us-ascii?Q?/OUX/JDRhjh+Oq3/fQBy8sZ8WT2lnNWdzC8kYgJA8eQGfpEqiR8hWLq5oARJ?=
 =?us-ascii?Q?dq7l/+wIqGUEPTjjTixY5ZHERJWt+WkcOzICf9oTWrEJaxy9U3dP1LRWmwdZ?=
 =?us-ascii?Q?vGgLOFMTL8h9LfJ8SuEUa5AlRZ4cp0ZPSJu4EhDKOt25hIaQe8DyZCB3QZrV?=
 =?us-ascii?Q?JI+Eg1Tqj7k3093aEcn/v2ppzUuOedez0DlqmopI1ampv3YWkv+jLJ66r6v1?=
 =?us-ascii?Q?P1kdszU6bfKUe/UoHzhbnb+beRYtfGfEZdQ4+a7AyMjEjxQ0nxO//gvrLdSD?=
 =?us-ascii?Q?37lQQtlq4TnFjBB2+SVzZ0rzlYCo3TKc4668kH3Nh++VXhB5xfa9f3xpHwBP?=
 =?us-ascii?Q?24bC0KiARnprAQ6zHXJl3wQIi2auLmQUM0KxmO1iAUmIDbEi1JPmYH46G5e+?=
 =?us-ascii?Q?9ujLzU99Z0wNNTEjS1wWsVAYKGOdJ+1c0jL/CWEMgcMXo7RRE1NUjA2krSqK?=
 =?us-ascii?Q?rjQe/TlFmNB3J6sdeHCcOWpgIKVOTcQbSd6HFvnL3Z0reFHqPyqnImKQue3B?=
 =?us-ascii?Q?Xw6e/DFD//YNNYCgB1EWNY0Dz5/i4FeSgzsh5iwy/zhKRQkDLUdyUUZZwjPW?=
 =?us-ascii?Q?c4cQhseccjSxs5kh00T8gnmuiIAL9jpHKJ0/oZHZH+Fw5gtaBpSh2Pjw7eHn?=
 =?us-ascii?Q?xlQW/Mq2Hmq86yZ8hOqrfr+coreiUpjzJbVc/GF6Fkr8gZJUPMnm3ofc/CEY?=
 =?us-ascii?Q?ZHx2QQL4DegYJKZp6ycsNSijj5YxTbEL6Ew5xJB5uu7/CFQH3RO+VhifFUUC?=
 =?us-ascii?Q?+RVasYxDxZS3liX+uLUJaNgcItWUSXFmoz0E65/ZSJIRq7hOWpJZTnVEctp2?=
 =?us-ascii?Q?kOsA+RpajxqogGdf3NcV+nLK+oG1HZRfVMs/i+DkoOswpXrjBvwmPMp8iwDp?=
 =?us-ascii?Q?btH1WSiYo9pp7v1a+itiPgN32c2V1adFJLe5rvSt7PEYKU/bEyWDh6hy+5RK?=
 =?us-ascii?Q?9kSH1mZDX+yNTzI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:00.9021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e562975-a796-4bef-7bc5-08dd3a536520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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

Reviewed-by: Natanel Roizenman <natanel.roizenman@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c     | 2 ++
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c   | 1 +
 .../drm/amd/display/dc/dml2/dml2_translation_helper.c    | 9 ++++++---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h       | 1 +
 4 files changed, 10 insertions(+), 3 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index b416320873e1..220b2bb910c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -528,10 +528,13 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 			p->in_states->state_array[i].fabricclk_mhz =
 				dml2->config.bbox_overrides.clks_table.clk_entries[i].fclk_mhz;
 		}
-
 		for (i = 0; i < dml2->config.bbox_overrides.clks_table.num_entries_per_clk.num_memclk_levels; i++) {
-			p->in_states->state_array[i].dram_speed_mts =
-				dml2->config.bbox_overrides.clks_table.clk_entries[i].memclk_mhz * transactions_per_mem_clock;
+			if (dml2->config.bbox_overrides.clks_table.clk_entries[i].dram_speed_mts)
+				p->in_states->state_array[i].dram_speed_mts =
+					dml2->config.bbox_overrides.clks_table.clk_entries[i].dram_speed_mts;
+			else
+				p->in_states->state_array[i].dram_speed_mts =
+					dml2->config.bbox_overrides.clks_table.clk_entries[i].memclk_mhz * transactions_per_mem_clock;
 		}
 
 		for (i = 0; i < dml2->config.bbox_overrides.clks_table.num_entries_per_clk.num_socclk_levels; i++) {
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
2.34.1

