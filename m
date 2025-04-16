Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5837C369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 05:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC7A10E82D;
	Wed, 16 Apr 2025 05:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4UGgGc1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F86510E82B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBcRbdPR/VQXRtt4PrSaLL92pZDXAOpyF4Vqjlg8cP+T4wc9ZnZGIMvlrC0TrVkqmL6WiyTj2VHUs5aQDbi4lGJ9PukhtRheQgDoBggFor9488902u1dQlB2Fmq+Ggl5N9i5O2Lk27Qhn0ULVPRRD62PSVgaui8MHOkYbeApzSyoF1eSBhFlHOdvuZkk0HgaoxMXhRvqIAAZYbvqoRL7LHFSn/R/aKU941SaSF3RoXIxYCxxv2wKZFnpK/T10wuUhMcnUz3yg4F7DkXWij0bOXdesz69M77babcMrZUDKB+H7AsdaueJJGbiGeiYMcbHRGYpNedxp6Z6Y3ISSxKuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5nDY8tFdAI4Eq+RnvqkUkKcaZUCvYPzE/aft4tieXo=;
 b=iOvuA6NKOUIv6QYONqQhBQJS2p6YGBEc35PIF7pOG6Dn5JjrWgmT0QEawDUYP9VMo4u5BBtNiUxdJ62TnDQ8skGUp4LjS3qwq8hiKnKflgbj1AXddMfdtX1ZyrP5OO2ZCAuOwEhqQ9ShoCpK1Bciil9RQHeF2CjcaFzh3HB831IeVogVxHNabw4K4A1HT0B/UZzIg29gvlLE+4NspiXs/c94d8zMXEayxOQG7kp08QFnn7waxMXAxoca7yELxpRSxwiSzvkGPvfKlJ3GRL5NyTpH04/slbNM55XXWV7l/uZkzRrNbiWViT/39ytYUixZXWCcxEv5WNT0Gyu6EmCa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5nDY8tFdAI4Eq+RnvqkUkKcaZUCvYPzE/aft4tieXo=;
 b=N4UGgGc1BxRVFhoib0jpxYcprhnmdiKt9U8Yitw/sjfR4NBeAT3mh2yFY8wu5CtBl6BcI4ljYYDP1pHGXcyK4Jiy7JRlZYc9wFVGIqgLGe3Cazg6dgIP5O2Q2BK/J8c8O0PY2eLKt3LIoAa7FVgKUW54q4gqXwlLHnBVPYIbh4I=
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 05:31:51 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ba) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 16 Apr 2025 05:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 05:31:50 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 00:31:48 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 4/7] drm/amd/pm: Use common function to fetch static
 metrics table
Date: Wed, 16 Apr 2025 13:31:24 +0800
Message-ID: <20250416053127.377955-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250416053127.377955-1-asad.kamal@amd.com>
References: <20250416053127.377955-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e820eb0-14bb-4ec8-498d-08dd7ca7fd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VHwe2KzE/WH+cHJh2pU7fdW3YqUKHCDQiZvvt26SYpqAWVNf1JhU4TWkKc5R?=
 =?us-ascii?Q?7PSbAMvdo3kNLidkKTbjtwQ1pk8R4QlMMvQs3CCJrYuZyAVoQ+m6lHhE0gkV?=
 =?us-ascii?Q?//4vFxaV/IZJNyu8dx7sN/G6AnoD1EH3pS3TpWzppNFvxC44K3ZHP4PHZNzd?=
 =?us-ascii?Q?Lue1uUxU/M052od6HPqqbZV5a/1BxFvu34+rzW+6fCAk9o5KqLktmxlworVT?=
 =?us-ascii?Q?zizO3UeeGnYxhNTJQXnv6IYxaSCROPPTYQzrMdXAFYqph34YZTg1H5oJf53o?=
 =?us-ascii?Q?5ocEyKpKszMgoqpczbB/GZ9hYEAZMnRbcIuli5Tnpa7rGHoD5iaIVaaQdum0?=
 =?us-ascii?Q?Pbv1nxlVA63y2VyagU6fcmcx3fQGEmCNhUiUwGoMRPA/n5oDrL7/MhMGtQPf?=
 =?us-ascii?Q?lpiAjwwXNmuO3lxvVt6/lZS0sI8SNufJKbIpv4oDY8PXv40YzNQIjpnD38C/?=
 =?us-ascii?Q?DqsRLA1jAkCEDrUl5g8FhlxlHVDmlJfThXg6/aIIr1vjFQm8NQ1MVjzusAKZ?=
 =?us-ascii?Q?zAAXQ32IDAJrWG3c/tLN9HMC/M+ttDnO22ko5uRz5Ou+YcMSD6jwFVtNPjL2?=
 =?us-ascii?Q?wxHLJBo1RezmSAruTHPsNOEzHrSpmqddrrOpa3wGlTE10YbZ8RT0ilCliZbi?=
 =?us-ascii?Q?7ch15cEWBxQB6o0FZmVvHXGANAmiMAHna3+50K/wxEv0qPdglnSA7+DzgpYr?=
 =?us-ascii?Q?xQnuNb09kQvq8CcBBukHySQRLTY7DLy1NIV/BYrRZ6E4KfPvge/XByXFtr6M?=
 =?us-ascii?Q?lmzKz5hKzPfqMuyaGc78MxurHuryZHUdgJPWketR+n1s7q2hDGguRlmXGp1D?=
 =?us-ascii?Q?1H0oCLyAoIPt3Dq8WfERrasdptXJtc582UnutRRoeVfC8lliRwSNDeWxzGYF?=
 =?us-ascii?Q?jbGqYcg6lBWcOwjvsCWONR85WtZ5tIvriCUd7y39Rq/j+7vP/uVfsjdS5z5H?=
 =?us-ascii?Q?k05MKUvm3l41mgugFQPPzHH3moKeq1v8Ee6+nkKr0lCWZHYT6jMm2z4MXRB6?=
 =?us-ascii?Q?4thcKVEB0cuh5Cfn//AEPsF+AlgnIgh2UjMQ/ZbVaynJcgY2w4aQskAnaMyV?=
 =?us-ascii?Q?iVBHITrlNI3RW4enlgYg/iQp7Di8bHN8iOZKkAKLuknwt/8onpeOokloiaJT?=
 =?us-ascii?Q?l6R64FTbafP0FKihUm0YAlIDg0DIVxNfeQmPDhZSIGECs0cQ/yD2f0ZAh7ZS?=
 =?us-ascii?Q?tkRzPa3sxayBEodGXvH55mAgaw9HITyvmyFcPtQR4+37ag2CsnCLKZ5UK1od?=
 =?us-ascii?Q?H9AmOaD8hyjMSmwzF9WYt5AIW8uppyj4lrTa6+TWD29INlVTzzwdA50oTbmG?=
 =?us-ascii?Q?pmCQDiGtnyWPt0fy5fM7nAtzwVsKoER52/aa9uPWudfdKNyrFn/B+WfeRZUf?=
 =?us-ascii?Q?gXXQZiKe703RML4N0Zq3mKtgiYZ3mlDNeurPh7WobZkDMG8ljzPPxY7BSMdl?=
 =?us-ascii?Q?A4OSbAtwqkp+vTBsyaH6rAHO/C0RjCqPDS9VVk1z9cyvwSP3Z3ZPzcfDlTy4?=
 =?us-ascii?Q?RFqTDssMVgBw7gCGTKIm5z8ddWu/eRnKTpGu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 05:31:50.9432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e820eb0-14bb-4ec8-498d-08dd7ca7fd7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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

Use common function to fetch static metrics table for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 22 +------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  1 +
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 5d4437e413cc..533d58e57d05 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -187,26 +187,6 @@ int smu_v13_0_12_get_max_metrics_size(void)
 	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
 }
 
-static int smu_v13_0_12_get_static_metrics_table(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
-	struct smu_table *table = &smu_table->driver_table;
-	int ret;
-
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
-	if (ret) {
-		dev_info(smu->adev->dev,
-			 "Failed to export static metrics table!\n");
-		return ret;
-	}
-
-	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
-	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
-
-	return 0;
-}
-
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -217,7 +197,7 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 	int ret, i;
 
 	if (!pptable->Init) {
-		ret = smu_v13_0_12_get_static_metrics_table(smu);
+		ret = smu_v13_0_6_get_static_metrics_table(smu);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 94fa31fc5eba..3fef50df85e7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -739,7 +739,7 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 	return pm_metrics->common_header.structure_size;
 }
 
-static int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
+int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 2a8f42dbd9f5..c7a07aa5ef14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -71,5 +71,6 @@ enum smu_v13_0_6_caps {
 
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
+int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
 
 #endif
-- 
2.46.0

