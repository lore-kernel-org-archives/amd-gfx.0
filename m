Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A61CE8B39C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B445E10E33E;
	Wed,  4 Feb 2026 04:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c9YRkiyD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8988710E33E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoSaxKhEexf3yweZqv6exFO9Zo2qOM3+NtAo7vKTcbYDQreLrgU0Wj4QeslqG28Q6jq/0JS6VtiK6Y8+hmwNpvv9Xa+LyR0MVas3RZUvE4iz1JFTIWMNweGd922tKO3VWrWbwfj9sYf/4bmL3moCS0XaWO1u8koQhlZCHDnShRnXePRxsQ1sjko7msYc5ZVXLONKbfhrOUGYT+m3h6wSWUaKrfnvsHYw/PkRG8tKPGC+1WB2v+RN/lR34x83X4UG22KhK9JXB6GkRNawPuylCQYEUltEtXv4zUPjpyXTabTtzfpkxunzpWxqMH5NYqICPXcJpbHnwK1hN/UMl4G18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnqr2Pvhbt+DkoNqDbgreq9+0WO3nbnaRWdoxESDFG8=;
 b=moZvD2lQF/N5keQUyPTe1NXxuq91LkfkjF3pEoEkOSg6t27UEh3estIe9IlMvWxzce9eumLtNDp00+2wAy3pu/Nbpb6QHHR0sbMdWZJKidWnS1WudxgPlmJkLTlQK2WsUoABHq5wXRCSPYI2vmG4YCVwum3mNfPOPOOLA3nSTXpV04AfrtckIlL7Fa/etswpbBVUNLZ0QL1ec6xhAhM23UGk04V/BNN7r6yQqMH9uhvafbby/9EO1Ns/GD6BV50rErUQg40iLbGA12GmxRNxKSv6Pd6EZqhSLg17MiNfonHrnCrgTvyWpMMg4Q2rLYgfQcz6jwyjAG/VJ6yn6JNrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnqr2Pvhbt+DkoNqDbgreq9+0WO3nbnaRWdoxESDFG8=;
 b=c9YRkiyDI436yXzA14Y4OxPR9dVELGjlHqc84KljvQuBS05dbofb8fc/Ooixr76lagri1JK6KLXHnAfIt8u+2VvCsOcSwX/cF0Db/CmgZRNA+BU7pfd+ly8DN2mpiSqv/ZAJ4UyT90R6GXFiPIRwTM4I/RuN43muKZYIu/f6NPU=
Received: from BN0PR04CA0121.namprd04.prod.outlook.com (2603:10b6:408:ed::6)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 04:44:03 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::54) by BN0PR04CA0121.outlook.office365.com
 (2603:10b6:408:ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 04:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:44:03 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:44:01 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 05/11] drm/amdgpu: Fix set_default_dpm_tables
Date: Wed, 4 Feb 2026 04:43:32 +0000
Message-ID: <20260204044338.96093-5-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba160fa-a868-4fc7-2f22-08de63a805cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VeASZcUrAi3gFxSgAfOKGWUxtlx4vJPQZFXJkZolOxahhcu2FD8rRmR/haoH?=
 =?us-ascii?Q?t1URQzPXneNbXE94BN4Rvrrqabpl2FkDxUd3KWDimqLq2LFvzmAAMFHwg+tO?=
 =?us-ascii?Q?08TziqH+Mok41Wt/I2Xs3GF+8qkSmrVpacxZ0wcXFUIRa2rTbhzwBETZnsNA?=
 =?us-ascii?Q?9dmXQfoh5NnByyh8BFNsEXSuEp1sczylwe/j8+SHJZ1Lvgv0o3CT5695xrky?=
 =?us-ascii?Q?Owb+gPq65OdpCJjSWq0ZVUQC7IGGpIR3K1lu9OIOzbwnUjNM7CyuIvrngXTZ?=
 =?us-ascii?Q?yZ3HXu3D8R3WDZPPaoYYl09Sa7ueJKhrCRUHgfYRMuO3QIFjppUV4dhNHvVZ?=
 =?us-ascii?Q?gKe0+4C7ZSUVPuN70y7XHv4cYamPzuka+YdgLr81gTdYTf0clVHym9zFEKI9?=
 =?us-ascii?Q?qXxSwNGVCtDbJ3jVfEJiIUDbkJ/JS9v5E1pPoqnPo0jggcMTZGSMVncnvOF5?=
 =?us-ascii?Q?Yp2FfKJ+hZaKZ1iS/JeohZml7ZXiMClIbRhYEWaqL0JP09C6sRGaEmkYlNqG?=
 =?us-ascii?Q?U/5bXTn07bBmFIZ2lnXLChoTsosHYHNjgaW5LAJ+Z/cO+tZs7G0ktERiYECY?=
 =?us-ascii?Q?ZQW91yiJAmVwgOVkyQgaGqn44gzISyTyrJs4ob+/B3ndNnELaT7lZoxLSvtW?=
 =?us-ascii?Q?KSYvEqsYTprLw3Kbb9A4YppnDdeK63nJvBb3hCk4yJDRnuC6K6avB/HSl6QH?=
 =?us-ascii?Q?d7+CN1iefa8JLEEyYgp3QJgpoDMh+xmX+i+xJLCw4yR1Gbdopa5bR2xzGYUT?=
 =?us-ascii?Q?9k++JyAWHcdRvC1jApH+fuSx0vAlJDA1MDetNXjSnKY2FJfatygT5kT/XeFY?=
 =?us-ascii?Q?mKiiflX0xYc2FYASSuuPjxnKLIQm/Fq/69dN/PlKOxy4PPtNOlC9aZt8oZDC?=
 =?us-ascii?Q?wMVevWIKyvSCiIQGJ7FQDeHSzr+YGoWm4TbXLuGMo7W0XLWfJDR50akDlgaf?=
 =?us-ascii?Q?tfZfprBIcC7udbQ7TgZ7bm9p4ib4eXESOop6rGAhpj1l3LfOqQIkP3L98KFk?=
 =?us-ascii?Q?XWKSIayoYyPhGpjPHT1fMZfvCz+MVQSRnxADDLVdOwWmhH4YVhesUjsY67kz?=
 =?us-ascii?Q?mffG7BTMrvjEeRvTbJsEjNk6NsjjddZZBSE72Wch91XjznwGEu76VNtd74V0?=
 =?us-ascii?Q?VM5Z34BnhOFN5TdsrnJEetQaX/pDttppRbbI8OkcPYzlsg+ELaCfKAEboY0D?=
 =?us-ascii?Q?3/wA81UWj6RJsGMnNrfKDMFgkovdsp031QhNY/Tz3C/NN1zAOqbRVrZiYMWw?=
 =?us-ascii?Q?+NPOXWtbJ04mh1GeqVxgXF2oxcdbuY7ZihUyRRDxdZ3TJvSXHbuBmKRZfWSn?=
 =?us-ascii?Q?8/bgR7NYPR8SJMPSOBpRwtaBbW3Gm5RyykGziATJOKnSznCvNy+jIYDie3nd?=
 =?us-ascii?Q?7iXE4+Z1LTKPVTsOtg4Qi5s1JHH73WfpsCKbl6IJXZFbuOIl3uZfNFRJ3GAy?=
 =?us-ascii?Q?ISkLgJEH7GvpyVSDyMFv5sMKvpaOVer9q3P17giFAr1w08Za2UXVAaMSz0kz?=
 =?us-ascii?Q?sfvf5F1KGqntdPKzqzoStMAlaXoo5RPe/2l7OEiyyfwv8oEbI4P+MwovCtaG?=
 =?us-ascii?Q?PChOiEW7ZElClUsLAoH33x4ghJD9ZK1p9IE1T/p9R3MEpCvasFo7XvYLMx7O?=
 =?us-ascii?Q?woKww9QttXWoNuHC87UAHDVcea+GodMpIERRpC8kMhEtlgHVqT6XQIiMoNkr?=
 =?us-ascii?Q?QLQCaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3WSRhX47KZRrA9yQ6s9Zkbmf+URMw/6j38Tog1QuKWcU2jg6/buQyMMShOOKbuO5uYHXCgNJaJ8YdzOOD1rTf8UYUDJqjQWzuEsKqkiKNflWBV2GV8X1ggAPTw+XhFtUlbTtRHsZfgpVpX+ZF/QTKjGq/qjC1XfPWhSyyPFo3THsblmcYAr3Pvvt4QohfwVJ0qHw9va04Z5JwYeGK5r5Fvi0EESnV1yJyAEUxO7VNugZCVtADfsQF9ySjOKVTYVBtGoBzhkRZqkKtmlYeLD/dtEubmGX7TE4n9djrtjJSgL7tCzH4PhQ/hKRgJEWp/cSRG+y7QfizKr5MZV/KNUVVr9HfZWdfyvzvZ/WL1i7ZtRbCTYK4m3NpaFikP0fyW0BHSbnfVqw5+5/dnXEgfFeLj+3B2OGiSEoDf/iS7j3yst8uXq8EphCcWZh99Bu/DcH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:44:03.5694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba160fa-a868-4fc7-2f22-08de63a805cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191
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

Use smu_v15_0_0_update_table instead of common api

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index d3dc7583ce4d..e8dbf3d6009d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1798,7 +1798,7 @@ int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
 				    smu_table->clocks_table, false);
 }
 
-- 
2.43.0

