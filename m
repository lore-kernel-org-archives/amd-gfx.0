Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8D7EA811B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C619510E57D;
	Tue, 10 Feb 2026 13:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rwidWnfw";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC0610E57D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sf4/tCXZsPiOHRXkAr4KHH7RRBT6VCB0Hgd3UWYLU8kZuPKL5+7eAp1Gz2tzaL/qCXWSO2mMu+bsgb4usmnTgtT8h77esVe8e8C4U4qLlDiB38A79FYPlhWHYbdCL2Ytfo8CK+QDvDuynGNj+c4eSbJ5jelvdeKUbP3X2ZWYDGX/IdwTJvTDJDUV3SLlquzRHyxOWHWpbOqUrB1i93+HParVBnMR8ymmboTcYnFv3WuyihnkUZlefPXYW+zNASyaxMGcSGRIniuetCqC/f8q3ZTbar3H1rwWX3vskzJ/6M42gutWKDffY4MhAi0lVsglhyOExT9O4E85J6Xruu6bQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8+NR1FRBDZaKwZJz8ofmlOFW2u3cwqBARoAvnTYMI4=;
 b=Jy+7FsvmO+Dng00uCuQgcpF9M5Vbva+bKX4TcUJEoAyaMef+YzKWU/R0QoqKGvi86wqkuEVE4rY3NlUFkdQfJv+hd0V2mL7QPjDPj1DAjRkcFwMpBgNo/x6JMr4CwiKZK4Mtqikb2GJsoT6u1MAu78xx9zlODlxBo9FUueYolLy16iVQaKvzm6qOix8KYm1aPHoK0rfMq1niyN5G4aIgTDiWVgEywDxiKlrwhykIfAKCOo7EqnAzfW5H0c6zL7dRnz8pYdt/8I+fNz2oGhRVy68Ewm1zwfSOSAOaDMiHp3xnHKa6jfxg8JW6G7fcaR0NqncX2TyWahYxdb+Ai40n4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8+NR1FRBDZaKwZJz8ofmlOFW2u3cwqBARoAvnTYMI4=;
 b=rwidWnfwQUfpZfLDu6EZ34B81pYoGEjgriVf0wZQdXIb2o21qBLkhG1Oif6PRPJVBTd2FYX/i2Q3nbPsJAGS4w5qNnJGaBimdu7qOW3Z6eTAm0Eb99CxNvse/BzlKzSD9NrzsN/r4Dau+Fxcs47Tj/snG6cbZXAyyFFloKcNXfM=
Received: from DM6PR01CA0016.prod.exchangelabs.com (2603:10b6:5:296::21) by
 PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.15; Tue, 10 Feb 2026 13:54:43 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::a9) by DM6PR01CA0016.outlook.office365.com
 (2603:10b6:5:296::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 13:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:54:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:54:42 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:54:33 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 03/18] drm/amd/display: Add gpuvm and hvm params to dml21
Date: Tue, 10 Feb 2026 21:49:56 +0800
Message-ID: <20260210135353.848421-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ca1d88-ff88-4b43-0dfe-08de68abf13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?djzkGRJJZkzihu2YwhTO7iksPvSE+xFfIWLKd8zmJ7+pe8oBUI1hVYKY+L9h?=
 =?us-ascii?Q?ukm4wkQ/cLyoEw9w8uBRNt8SbKLyFzIlWZj0vUGDLuKOU5DTUCGAP73fmFUa?=
 =?us-ascii?Q?W2mfDhsjGRUd6UOGODtxSPI3M2HehXUHNx910m29emUbVKO1C3OErmtLljnX?=
 =?us-ascii?Q?gC10HV+ZGfW7vavlUl7HZ51ODO7s7cyK+pCpijbQ2h3mtlciagk9cPtkgYLT?=
 =?us-ascii?Q?sLpUw13Ko8QeJn0a94uZEVhM3sbdzInfPJoOjIQxaXK15AB5iCYjKksG7UkH?=
 =?us-ascii?Q?WH3LrXyOD6unNlIYQWSTGc2nW8A0sY/O/VutstsifUYAsOlRX9dYkHAB+SRo?=
 =?us-ascii?Q?fNrlNR1+2lmBk6vcpbDlLpRtjfkAAqSk5Y9HNotlacIPE7KQGLf9MWjgyuPK?=
 =?us-ascii?Q?qNWOEI3pQBuz49fJrXs8zysYawpHm3faelphHzKgYML4MOVkLnLWr1+hpuVm?=
 =?us-ascii?Q?Q8WqogtPpYzjVYNYWkrIwUy2VjFmCbUxS6HmUqmnXJGN5AL6ymU1zok0jDfZ?=
 =?us-ascii?Q?+JHHHqBVOq/B9DB4B7abRQcp3bNXUDw/SLP/I37bb4rZ8AIdXZEQgu/C3PUl?=
 =?us-ascii?Q?UXwGl8EorFfnlTjW1GPvRnLahhmmktAcKC9VkF5pz99T5LXtLfrRY+dGKM1n?=
 =?us-ascii?Q?mRnd1IFFEn8O/HYcFawtFrQI1OhWidRKjHpIOrsO/J14gWTH8gvViEAVyebb?=
 =?us-ascii?Q?9MsqpCuoiJBDFbB7wvxw6wdRi6ag6hiSUNh1XJ2CC/NtxoOgZ2NVCDOjt/2n?=
 =?us-ascii?Q?zzc5opcvoNvqirA9VaCquYjCdaXJ+JvsqbuSTWNd6vNBgZmgslZO5PNXZuIt?=
 =?us-ascii?Q?rLkWvJZ4uc+uNLggFSwIUCvE4NCwX4tDSJzU2q2sGdVoxYbodyFMtLogpaSi?=
 =?us-ascii?Q?wVYj5i/EngE0ylCDbEOo9z3P2D5nJSRU1K1y+oz0uoIAAGBBxP3EeEVNvDeY?=
 =?us-ascii?Q?KlEWLmtfxWFZMQP4sesjEXgJndLsGKkus3MhxCkdA34xrgyHwFnJCo4VfDPt?=
 =?us-ascii?Q?TKl14STEOujcMN/WwygFZ+c7/r7mu5AiKeL32g9lKz2cttmIqbS7QP8reBoH?=
 =?us-ascii?Q?Fy5Fg2/Ae59VX1shNPs9kELWIxWTwdOsMoKB5HSbq2y+GNsppdrgqgosrGIN?=
 =?us-ascii?Q?8SMcrwW0UM1Ctqjib2GTlp3sH+DvMuJsHtFqenOHzPfxi9k1HhIbDieafpm+?=
 =?us-ascii?Q?vpNxRzPIXrQfwpUdhgl0kzejz+V+Z/x5GaH2UHNyKS+CFAYym7rfb9TskwoT?=
 =?us-ascii?Q?x/WlbPKS3CvXgghmcaW6y6HadnxpeBTmKg/lrNcFuvfoXm4+mW58fcxZPQwa?=
 =?us-ascii?Q?ChtypMee299WPIF6MIYBUqo8n68wYTPKdP0BjmUNOu7cW9R4U5mg2XXN087A?=
 =?us-ascii?Q?bZia6KbIBSfIZT+IcRRldVPh1gk+Q/A6GhQM1wP3/VBOfMJKk6zpZm6+zKFc?=
 =?us-ascii?Q?4ZRuMXiAVIwa3w2rnFIcuiMDF/HhEBZ/2NHYSEdh5asjy7go3RVmmgooiia9?=
 =?us-ascii?Q?D1scKl3wABuEqx8f0hG2DU8WFyXCzGZjuxizrpd3ZPLFTDDunI45+s21vK4w?=
 =?us-ascii?Q?bub0KeEdmM1CXMjL7F94tu2rdtJP+VPA+hmsBbLjKgouWPYjikBDB3FGIJ28?=
 =?us-ascii?Q?Kfb5SViAl2eIrAbcjC1zwWuqtq/95VQoN2EMdsGw9l1ttVPi0yuzyh9V5Y1u?=
 =?us-ascii?Q?YlMDrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mFYfWEP4etwZHDF9/08HgTHfcH9Gcyy0pWZ4d/ta96opmLZyI/0GOTIIQddQXTwx0cVJLiVZpAvJ539QxwgLbZcHbFSDbcHm2aEJypBMsbFHfyrzofe2EGnTJGfV2tiKUwiQMRwQe5IGJIOT9YFvM6UcFKowy4DeWGoC4col+JyEhijdVkK+NXnrsD1QycPeVRiLz6NzyF6+eBd/Lkqg+m7crqr7Rn+2k5RrtAPy4dSy+QpFcBfdBRAFuS9alMWttNpe3M8e3SbUOWBVS602mS+avAm117oA+1HHGqQn2nRMWgPgSy8wncqt37Em1ZM72KPI5pHdy/oF/X13CZKtoBYlFo+uhL7a6mzBrtkag2bhdT3QOEhRd9K6nkfezCwdU+n531r6uVSWu2oMf5+dZxeEqtgqPsSkzi3nzWyIIZgJG4gBGub2+W5E1A0yor8/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:54:42.8546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ca1d88-ff88-4b43-0dfe-08de68abf13f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[Why & How]
Add missing params to display configuration for dml21

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/dc/dml2_0/dml21/dml21_translation_helper.c    | 8 ++++++--
 .../dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h     | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h      | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 3f4963ce3a00..f4bcebd7ec7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -737,8 +737,12 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
 
 	dml_dispcfg->gpuvm_enable = dml_ctx->config.gpuvm_enable;
-	dml_dispcfg->gpuvm_max_page_table_levels = 4;
-	dml_dispcfg->hostvm_enable = false;
+	if (dml_ctx->v21.dml_init.soc_bb.gpuvm_max_page_table_levels)
+		dml_dispcfg->gpuvm_max_page_table_levels = dml_ctx->v21.dml_init.soc_bb.gpuvm_max_page_table_levels;
+	else
+		dml_dispcfg->gpuvm_max_page_table_levels = 4;
+	dml_dispcfg->hostvm_enable = dml_ctx->config.hostvm_enable;
+	dml_dispcfg->hostvm_max_non_cached_page_table_levels = dml_ctx->v21.dml_init.soc_bb.hostvm_max_non_cached_page_table_levels;
 	dml_dispcfg->minimize_det_reallocation = true;
 	dml_dispcfg->overrides.enable_subvp_implicit_pmo = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index c4cce870877a..ddbb8dfa9ff8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -160,6 +160,8 @@ struct dml2_soc_bb {
 	unsigned long return_bus_width_bytes;
 	unsigned long hostvm_min_page_size_kbytes;
 	unsigned long gpuvm_min_page_size_kbytes;
+	unsigned int hostvm_max_non_cached_page_table_levels;
+	unsigned int gpuvm_max_page_table_levels;
 	double phy_downspread_percent;
 	double dcn_downspread_percent;
 	double dispclk_dppclk_vco_speed_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
index 9a9c27962f68..5ee489682f2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
@@ -239,6 +239,7 @@ struct dml2_configuration_options {
 
 	bool use_clock_dc_limits;
 	bool gpuvm_enable;
+	bool hostvm_enable;
 	bool force_tdlut_enable;
 	void *bb_from_dmub;
 };
-- 
2.43.0

