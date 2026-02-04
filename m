Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38B5E8B364
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B4810E355;
	Wed,  4 Feb 2026 03:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BubELol5";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F7E710E355
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqEM9viYQWwJR86HoPbBfvw4M5EnAuZV8luoBOg7sdVqw8MRr9FKB/0zYbzthCQK28TQWSwzdPYNigd7RykB+2RcSxJd0l0nV8XXoQ8BrkDg7XA2WkgSrAA3geJjIJPNZLWP1zxjysBLjNNz1QbE/1iqb4JyjUnd9iPmk1d3acchYQqf/fAjxnJyJ38QdY9nwaZpxMR7tdLnoTaryPF4CcSxqTUry4WRBWzekEWs6MDEtZJxOX0zXockcnSzLSDLN0je2bo/1crvEKXUapP8uFXVrG3TAonhQHSL9OUnIJ6VUFOgs5vipyaioQLWTs3X0oeSMXnu79raMutvO/Y/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV1zPb7IcM4wSvzZ/uRNkiN4aZStSpOgeWZfiZfibNY=;
 b=hVLkmJxepiaQzgBdcJIGGXPrqSxyQu2O7EL/gd2Zi3M3tj+33P3OaHLoJFzPS7ejXLEkhqY5lUK6KDVTpUdcyhUMbieyMdz3Dy4hjqgqx1oOxIOBA9d8PK/GJVarlFauzxKTzF5/WdmjPQwQbdSdQ8w6hVcQ6QPjRaOkOs0w04AzxD40f7Weq0pRffetjibUeR5MC1HPKBfM130ew8DhyF4CoPi+5fWgKlHBiN0BdctoO/X2kSYDWpXQcdW0cvPQiLOBIWBk0dyKyv13ZV3N1eatC4ZwXCjckNe4TiKbalEiJA5NnXNzrD9F9MOTlhfYQfcJsKezLsZvYNxYkOpu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV1zPb7IcM4wSvzZ/uRNkiN4aZStSpOgeWZfiZfibNY=;
 b=BubELol5O3pShYy7ZIyDlyyzvGM1v9m8QmOPhTRITgjJqIq+qXBpvAoNb6g4D9latFyOFiFy6r56WTkBSVLmknSJqaysXOjCJU49gJY1X2/nx3euad6LuJB3dW2ohARyL1H5LTXhryA0T2xlFZMAXvwRuX9HiuDLOfmWDCcq98c=
Received: from CH2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:610:4f::39)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 03:06:55 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::e7) by CH2PR18CA0029.outlook.office365.com
 (2603:10b6:610:4f::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:06:54 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:52 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 06/13] drm/admgpu: Update metrics_table for SMU15
Date: Wed, 4 Feb 2026 03:06:13 +0000
Message-ID: <20260204030621.33369-6-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c73e04-bfcd-4ae8-f46b-08de639a7397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LQhDdBjzR8ChyNWe6sm7293lbTrAG9fz+F3Km6k0Yhiqd5fLSArbpAyUBBX6?=
 =?us-ascii?Q?nOPpaXS6gWIDYEXnoi1eShU4Y/hKyr+GRhGmihjfJ1frVb8ZLBQ5frqkZQJb?=
 =?us-ascii?Q?kkUUBhrFOKTjB0DPPRh0UYdHcwxegDfAwIoEWTPcFyyE6ufSRKCFXehIUkwC?=
 =?us-ascii?Q?xSGGvMtuyynnIoWT8Yn5XyWmAhYiqQ9XyZRgtoKBId8C0hzfh7G9GM55tSwA?=
 =?us-ascii?Q?vpyoM9FmnT7zdcc6TbVgOOOibwgtcLYdaBbTm4WX1Vadm1ogVW04hGk0N1dw?=
 =?us-ascii?Q?Dx0H+1rrviuBg4DX534037kweLCsY4SKQlFFnbAcY2/rs9aC7sVj513xIDjZ?=
 =?us-ascii?Q?RbS86sfuO8xrwqkT7ydskDvHo9HHHSmohANzD+eRws6TnM/JAaTx65zsmc4l?=
 =?us-ascii?Q?ASiA4V/Uhmyh/pAIRgDxeAS38Zoejg7t7PEJOI4kAysggw4menxbs/4ftVFU?=
 =?us-ascii?Q?onoksuXD4SJANrkXixMD/GxeM+nQn9mNFC9NcGnf6/xJ4cU8Xur8KI475wTS?=
 =?us-ascii?Q?MC1t/IwxGFf3rm2xhiVIEo93tYqNq9LXuo+mQj14ZiApgjBKnZtMNAmeuGmE?=
 =?us-ascii?Q?bQKWTzby6KsPVz2zA4bIGJzyv7nEcWwFXlmqWlR3BduXU76ONBxC/2K+ccx4?=
 =?us-ascii?Q?qZpiJ77uVRgGssH9yJpWjKtDwWm1AOThBZ1Y0+++MIn0NLBItafqgSj1NVge?=
 =?us-ascii?Q?VlS2CsBVP12TrvyafwV3BkpQ/QqnWCkM/dV648ZBuhECQmwetk9f7iR5Sl/l?=
 =?us-ascii?Q?v8/J8udrX4kVO37wEeJmcVCccQUMKsIIzt3lpM2aXSBu9R5UFjPqSN5oIw5K?=
 =?us-ascii?Q?70/TZQ+AF1WWqAzyunLxPWqe6446USA18YnoinZDqAhL+gnLlDFU737twGIV?=
 =?us-ascii?Q?1PjaRqpxWOcDtlQXN7EpqSWHThKWDbJIAs9/Fgkm0aw5npJqR9Cr7+oVmqIN?=
 =?us-ascii?Q?bvsl4ulxystNoxQs79RXfGVrkogQk8BAbjBsj/JN+7OqFXSeWAYQ9x0GSvDL?=
 =?us-ascii?Q?+cKdlGvQcDBYm+DmO72NZNYI7HxGWFXac20+yUJJNISPvEt4WSIG9/abQV6q?=
 =?us-ascii?Q?MJvTavuXJY5ZCT2E3YYqZIje6evbT2bdJA19oUPMOQCS8h6/4cwia9VMnH1g?=
 =?us-ascii?Q?dUQRf5mNBY+eR4a5q0Pv/sEu39+kgmLkTFjCUsKasfNqCDFzL4BwiUEfk5Hy?=
 =?us-ascii?Q?30EYV/Waj07JgvKslVn8CuTlTcnppHG4zDlXK49KvmwStjkPZBC8pLOvOqZU?=
 =?us-ascii?Q?C7yyK1Qy8lMpt7FwNcl5jUA8KJlvlA3JZw9OJ6AKZ8pWmFl8OInEzOqvIWHy?=
 =?us-ascii?Q?ABxXp3AHyHsloD+lcB2bpMcE9eJeHS/UjBrYlKf6Fh7oJfdMDixaXQIIaK7k?=
 =?us-ascii?Q?UPl38wcQYF6PM6UXwsRfloTxaoOKEUnNawhe/7AQD7JQC7IGPDPwe1DrCdYj?=
 =?us-ascii?Q?gf8mYfgzMdVSDatVgUzh2vg+/LgiT0tggd+vknXrTcYXcXOefm/UnpHqgVd4?=
 =?us-ascii?Q?TwcVVQvpMCX58iJiZybyB7Sxr8tbN/ri+weTHzE0HmgNoc1TzbI/uHBnUYT0?=
 =?us-ascii?Q?Z5MC/93elm+HcrXV5PA2L9pxP5Alf4mhbYbbkKW04uooFhO0rWWQJ+GNDOyU?=
 =?us-ascii?Q?6S6bKJPft8zbcdyje5T+G7vpjcGzN1ImgVJCbd37jtChNcgwQgy4WvjFptlS?=
 =?us-ascii?Q?cyhQ+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iuKBJjoOzVBXkwRAufkMyhFNPOQ+XSHeOKZKqwTkV2jFVWJkKjNpsGU7Fmi/hODN6SVvKOkGoiBJPg3ecII9hYd8tj1Bx4KWkC57jJ9e8zoK8A48eowzf0Qrmp7AbyhXNsd3puROBDzb2WhAoMM9VpqmwLDBo6UlnACen+a2hU9sO4rHkA7B8GYFhW3Xy17KQzLe+U8Yl4PCFmHSxwhYwsJEvmvKR35Cp13DCPk6oTvlo2m8SjpoWGDfeRyImcmnR1JD3OO5cQnOWEgT0NIGSAGgGF5keS2Dbogeh4HzQWvzZzIl3LMIkXNwkHq89KTIoFwtyjsJ6lDbX/4bLEz51F1hDFgcHttnC69ac3m0zMMhLZ0TpBDeB/L/7jqabdapL7kMoR3gHfF11ps7wL0ISC41TCH8xxq8liGZ+uemFFWdgfRGxzbgM3qtQSNaemCO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:06:54.8104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c73e04-bfcd-4ae8-f46b-08de639a7397
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002
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

Use multi param based get op for metrics_table

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index d58b0bc2bf78..2987ff1b13e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -246,6 +246,36 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
+static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+							void *metrics_table,
+							bool bypass_cache)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size =
+			smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	int ret = 0;
+
+	if (bypass_cache ||
+		!smu_table->metrics_time ||
+		time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+		ret = smu_v15_0_0_update_table(smu,
+						SMU_TABLE_SMU_METRICS,
+						0,
+						smu_table->metrics_table,
+						false);
+		if (ret) {
+			dev_info(smu->adev->dev, "Failed to export SMU15_0_0 metrics table!\n");
+			return ret;
+		}
+		smu_table->metrics_time = jiffies;
+	}
+
+	if (metrics_table)
+		memcpy(metrics_table, smu_table->metrics_table, table_size);
+
+	return 0;
+}
+
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
@@ -255,7 +285,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
 	if (ret)
 		return ret;
 
@@ -530,7 +560,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, true);
 	if (ret)
 		return ret;
 
-- 
2.43.0

