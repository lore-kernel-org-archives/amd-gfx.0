Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095B7C25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 15:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A1410E537;
	Tue,  4 Jun 2024 15:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="deTsY+vA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3845610E537
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 15:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYC6Fl5Fh/bMs5hjj13wMoM/x/q6E8pevx03V2eb9XWTTmyw6TWVhXSEmVpu9zzx9ULF7cCwIsxzHedmArYIAojk+r9ctX2T+YYSaSNxum6L3q0/09WdNo8bh4VK4izPeSV9/CVxgAWRX42fZNga0lNo9eEkeZFjFU6+jxzBDdKtyBs7SmHlmqZCtOXfmyqedwwkhMoOw1wpQwhc3qMzFZhCJBP7Q1N6ai5W+2HwHIRnY2vG3g8mBlAF1z4DIFzGRwUwpGSm06dSfl+dX5i3zzFrhQ8Q4Z3ZPM6RCCg6YzPQWoiyGWofVPPfBOtvZssdJg9awJ/obFN5ImgGQyDIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NQ/WmwBO8tBlhisGNrDBqC3ROFazm8qMN5jHUCdZF8=;
 b=N4N7N4PdLiE7wL7A0UnZW/e6LHhlp2kMCIHMho2e0y1jufmWkmghXuJYw4f6zJfJ+biPGEeX+t+1fuIJ5w+RCUuMJhZ3txTabINO4Q5pYtw5rWFleeFICFH5POcSIgz2xXfH8EtXdC5xnCFLW5Kv/VtHQuVLRBfrh+7PfyuIh1E+GqWqxZcdUtZbgZAZdRRygD3JGN4Y0j1zdmuuxklNVTztQIdVUMf36VN69QakwEduw7nhj6FawHqlR+ZGktAki3/mUnlw22LdlI7hDf7PQ6BHiOWRsBpyfN+A4hXn429bM7OWhbTK3SLffs86YqXEQoyT817R6BKb2G0anK0OVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NQ/WmwBO8tBlhisGNrDBqC3ROFazm8qMN5jHUCdZF8=;
 b=deTsY+vAei8hbJvwtMwMsVmGpq5Z1Q3LmJwd/yHiu//91HLPHruEn1XYxZbjSMm5XMNPnrZSf493ckmyju9sK6y7klnu7ZRXknEzrc/oh75lVfGsbp/Vg5pSN+IBfte7zrcFyeWuLY58EuywZXK5zzddUr4GfExqSAJDVXwVSvU=
Received: from PH7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::31)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 15:50:44 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::c9) by PH7P222CA0029.outlook.office365.com
 (2603:10b6:510:33a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 15:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 15:50:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 10:50:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, George Zhang <george.zhang@amd.com>, Arnd Bergmann
 <arnd@arndb.de>, <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: use pre-allocated temp structure for
 bounding box
Date: Tue, 4 Jun 2024 11:50:27 -0400
Message-ID: <20240604155027.542271-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb123b1-724b-4031-9fc7-08dc84ae17b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TNHCuz95ZpiozmzvCXu8JfH6cA68Aozb0BjdW8lmlLW83o91fUUF+DuZDwww?=
 =?us-ascii?Q?Kqg+n9uM8bHA5c7afGMmy3F9ft9AppvV2qYcaTXzJXM25tQGiZvDhsPoa/+E?=
 =?us-ascii?Q?Wx0zJ0vlX3E+/RmnudRgFLhQecYsX3MvZXt2da4AreU4UaxOOuUKDLuaauaf?=
 =?us-ascii?Q?NPn5vPAnP9ygehuBAWT6XpBm9OMnPAVwt67sFClYrHJzm9/4bhLF/rxBdjvc?=
 =?us-ascii?Q?+yrrcDsSN+bsPhLWPjCznJNLcGljLOIqwIV672kN40NGQd2adzZJZzrDfkGU?=
 =?us-ascii?Q?vO8GqmtBIS9i6E4yg0KQfahRIgZo6C1cazXadcAcGGjBXAExkMyxHdyTrSvF?=
 =?us-ascii?Q?B9MMH9MZ0zQ8WSvVdNxrOwI7cR9OvEyeoSGb1Q7NrrbluTeaEP3lUCazQSX7?=
 =?us-ascii?Q?uMkgeIP56krQYwb+mkzDWc/PgAMFm0UBIkZtvhxj8B9/zkqmdcrjib/tXcMH?=
 =?us-ascii?Q?mo+AGR7kcL/XV04bjHtP0DVd/jDFIm7VsHQp/dQtplVyBZqFRCA3CCCwy6Tl?=
 =?us-ascii?Q?dlj8uilYDf4NXsoL029Ah5NUpEHW4dOD9f0zY033rk4UU1aYb5G/UGMCbL51?=
 =?us-ascii?Q?0c4qIpAjEqAMd62/ntYhhRissqZET/ZcECXiRseyMRUeGcMoLAPx3yljiwwU?=
 =?us-ascii?Q?1TEtw0Vs6MuomvkoXvAwoeYFmKsB4RvtL7WsuvtvBOgXyw0wrbkNTTl9iMXH?=
 =?us-ascii?Q?Y2KoE4CcpBe1na498A/mYUdqvHNGTnH3vUPCklh+SZzaUH8vD3JRtvFfp642?=
 =?us-ascii?Q?hBBIm9qp9xqe6stMYLii4kCu2w+57skXOuXALLLUQAUw7aZtK+n/yLjmgdDs?=
 =?us-ascii?Q?qfjTUzLqhQd8jLTe7BkXef3GlpRxdT86MpZChXM6j7Pk+X4+9ZDbvYVAJ3+d?=
 =?us-ascii?Q?rwnDsB2CIRmRh0epJckRC4F65cMF9ilp9zXRWnxnw2RovpW2LhIBpE45/oOO?=
 =?us-ascii?Q?7iIpRZDT8VVpns34I6/u7N4TugTkQI45jfCZ4aOxQbGF09YdXV0/cs60cP1u?=
 =?us-ascii?Q?7FqI9KjNmGIcjwxALoJ8hRdUGEFTy8kK7iaoc5D7Fcqj+YYvE76shEFvpW39?=
 =?us-ascii?Q?LhkgoQiNBFlaQ53p4ehmOrf9V6VHDqJnjG+jaIjHD4W6JRn0+SpJqcqMjAcV?=
 =?us-ascii?Q?KI/BZxyiltLamQdWVypCUKT8d9EwSGlLZJV3zmxph4Bs57GQ4LlqKZkdwvaV?=
 =?us-ascii?Q?eMIhqWnSOVM95ILqbS6yPwvSk772OnoGy1zsRKZaiGySZDJIdeIuFR04xxDs?=
 =?us-ascii?Q?cOfap77B2ctDlyqfPLT0H4eAn2fBkJEO4URrdOqzNBPiuR3IH4Sqe8q7e/ub?=
 =?us-ascii?Q?Vd9X0nHGbxTmYnqLgWpmaEIYt6jvT7FCkBKbVcXRznGK2Pgtek9XCREF5U1g?=
 =?us-ascii?Q?IffDXduhmdN07xavKIKtmO6TAG1R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 15:50:43.5759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb123b1-724b-4031-9fc7-08dc84ae17b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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

This mirrors what the driver does for older DCN generations.

Should fix:

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u64:8
preempt_count: 2, expected: 0
RCU nest depth: 0, expected: 0
Preemption disabled at:
ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAMING WIFI II, BIOS 4204 02/24/2022
Workqueue: events_unbound async_run_entry_fn

Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configuration_options structures")
Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: harry.wentland@amd.com
Cc: sunpeng.li@amd.com
Cc: Rodrigo.Siqueira@amd.com
---
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++-----
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 +++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d0ed01ac460d..d843933ad731 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1444,6 +1444,7 @@ struct dc {
 	} scratch;
 
 	struct dml2_configuration_options dml2_options;
+	struct dml2_configuration_options dml2_tmp;
 	enum dc_acpi_cm_power_state power_state;
 
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 0f11d7c8791c..7a8aa9396dea 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
 
 static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
+	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 
 	DC_FP_START();
 
@@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 
 	DC_FP_END();
 
-	kfree(dml2_opt);
+	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 }
 
 static struct resource_funcs dcn32_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 07ca6f58447d..ef30e8632607 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct dml2_configuration_options *dml2_opt;
+	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
-	if (!dml2_opt)
-		return;
+	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 
 	DC_FP_START();
 
@@ -1601,7 +1599,7 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 
 	DC_FP_END();
 
-	kfree(dml2_opt);
+	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
 }
 
 static struct resource_funcs dcn321_res_pool_funcs = {
-- 
2.45.1

