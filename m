Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD93C44500
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59EFE10E895;
	Wed, 21 Jan 2026 22:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nhN6pqzE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5F010E894
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJSz8cCU217mztxN4nAjn5Npe0sazU84mYqi9G2m5m55iiSbRtA6g2a6Is0uXwDR+vcewmH7+fKCUtznsuIyl/D8UXseW5Ab36eR1JuxNdXe3JRgl3Nlw/DCqdGdlbQhpCdCY2nUZDjn8nhelVB4XUQgh2y8ClMIQhVuyrg/rCKZTku/zN+3rlo9hEi+443QpZv12LCiQq4wTrOhldxS85leVxJLmUKDcmH3xW6+nTx+dlEujxptdp0qM+iLUCVxhDgNXnJcj0OgjefXbKet1t4k9oiGGducdasq0UNed2juB+y7VHGMhKKpllag/a2YeC0oUd7rVBb1FSh3+6b0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzJAC2Otl+2tPBnSIwC7QSpzdi06hHhd4uJ5A91GU84=;
 b=ARVpwccHRG6rQ8Ce6HGfti+tVBx0DkxYickzYiianc16YrONXJwJOLXsnUJzBqyoqedWbZel22griVwKGQGGJ3aPJ/7axkUzNXAwxnIF5tb2RXAPow9PPB99slVjMSjRYTAnFApiMZvXbWXomGYWeC168wQk0Zu7ZzujJN708r0asP3En7HnS5RdY5d2US+afScAhavHlcc1jh8BP6RnPfCLGMHl349XcGo/LWiP6T8O7rZS4DncvvPDerGYO+9BRQORfWdn1GwsclKj4iYUB0FQqZnkOfzzClJf6tDPbiFd9/qmgRVUBfNqptlt1hxbMhF40Rgx4vpxEMxWoA3cgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzJAC2Otl+2tPBnSIwC7QSpzdi06hHhd4uJ5A91GU84=;
 b=nhN6pqzEBeB/Nn5LC7qntoHqJZYwrYvvkOoxbeX8vmUC/1Nfy0un38ladJFryYwGS3+TP6kfRPaQO0heMCcLICH+8qURfmuY2xWRO8AFvl4bBTf6dpQ7xh1oEwOrjXPdBHuOgaXxPkL4TzQBoXKYF7EYjo4vIvE7rFIgswJ79UI=
Received: from SA1PR02CA0015.namprd02.prod.outlook.com (2603:10b6:806:2cf::19)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 22:33:13 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::4c) by SA1PR02CA0015.outlook.office365.com
 (2603:10b6:806:2cf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:08 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:33:02 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 07/13] drm/amd/display: Remove unnecessary DC FP guard
Date: Wed, 21 Jan 2026 17:31:43 -0500
Message-ID: <20260121223247.186241-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 739130f3-c9f8-4228-4f48-08de593d1030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OlE7AT9BmiLHUw/SoDinLbpMh2L06tMdHy4veOXQLi2LBz1opJCkOIewb2LZ?=
 =?us-ascii?Q?DhBngqPhKpkXdO5Lh1IUVFVDkTvz3m5Yz70dvOpF1n8Spjpe/wKAWai1q3J5?=
 =?us-ascii?Q?DFNrb1/RzfnTA5dto/+XdJHu8fadcP3yhWDLmEu2RENbVM6WDHEw5kN+EfE1?=
 =?us-ascii?Q?AdfdSKbgnDQ/nnIDUpVXKv6S3mbkPnTCDI4Mz2PAn6BNkQgfoJXKY2LsU5dk?=
 =?us-ascii?Q?13RLuMSxuOvSU+4yJSr8IsHar27BK/dBbpfg6Whpmy0uM31zRHU9/CgVA8Tz?=
 =?us-ascii?Q?iwMcJ8hHq9DHXCsl3cOjRuAW6hcYfvd6qpLepdJRl8cz05qI+4F99/GFsf2M?=
 =?us-ascii?Q?H/jKEvVLMfXjLAjCNd7pU5wU4py02cIFUpjCLaIkH50wmHGs/4gLayoeDzS+?=
 =?us-ascii?Q?LceBeOkHRP16iZ2jkcCKXqEE+Kw8C5s3DLkX0zaO+0lNwFbGZg9VDnmKpkiH?=
 =?us-ascii?Q?wdyKtHZx+iEQSOJjUBPAbnfFTu5n4ZJ899fX9Un14gpD1upQxHhlpKGlFar+?=
 =?us-ascii?Q?6/L/aqhzqWF2rrjojACRZKed2HirtigrGT3C74yIfse7lQBd0vVF98QePpp1?=
 =?us-ascii?Q?594uwjFIZhXtOpiIS01vk9hEu85p+Kb8ri3ZX5txqCDDX6GcMrzDlyYYMvgf?=
 =?us-ascii?Q?5tolWv5GS9FbdkldyDH2kB9vkdOAzije0hrJOphNd6ovMG3W5JD/hHYTTL2E?=
 =?us-ascii?Q?VCQlSabRBbdQEAO4ZfhAYjGfhuxt4FWRcS2MLaYkdgZhdzRk5yWIrmSzQVqD?=
 =?us-ascii?Q?Buthvlhqj79ExlZn63axB7EXV7sRo4l2K8dgrO56raZGXZLImmXOnKBo6y5a?=
 =?us-ascii?Q?CumI+XDJhFsQFxCHJ1l/nQzbGtV9MwPPiFBnAKWpSXhBVViNaOACQ2+U2HNq?=
 =?us-ascii?Q?DEl5OyK165n+n3YygUpsb1oKkg4Htg2KOtNRg2sxgYs+8HM8rQyJXZJbVCMl?=
 =?us-ascii?Q?WnpPelNXbbw1cnXPp+pralN3E0WmY/pRe4T9LHqcPwslQ+cjWAdssg1mGf09?=
 =?us-ascii?Q?/U4eOggt0kv2ztwbLEYPK3j/HJNsjTLT0SwjfFkTjmFV4ES/gmZuyYhBdS7A?=
 =?us-ascii?Q?VrZa6OKf9diDiABKmEvUimH0ySsX2IVkpU2CMPimXDbtSEkQkeRGfcGdcQhB?=
 =?us-ascii?Q?ZtEReewmgQ6KQjfCIv4CcWsrGT4xty+0fNxRTGEmyJD9EL/UUPAuLMrFrlep?=
 =?us-ascii?Q?hbPiHGMRFjWp4v8TjRWWbmXh9IfP/cPjvtsKFcNVLWF9nfiR/H0Gt/MOP1Yu?=
 =?us-ascii?Q?NxyGE1aDsEiBpRe0GQIuCcgFOoZjTm/UnPAyOnd9hqE9MIO/YYNKnejup00+?=
 =?us-ascii?Q?e8k5LHsP09Upeg/0irouXcZNBM59WpWnfJMcKr6WwbuNbMiS+YcyIdU9wa7D?=
 =?us-ascii?Q?1wk2b0UKMf8GoBl9SqDFoJ/X5P2wDMXBdHxu7cCjaZoeXF+QOxidcVBQPgf6?=
 =?us-ascii?Q?elv33C27KOfxk/F+qEwwuan4ENpY8uWb0/TKgRNeCnmYOEoIJWBZg+63GlzQ?=
 =?us-ascii?Q?X8G7XtGB3trudJ9ElUNU0j9m+l04ROo2bIaxi9UvQVO6vXF6QFfGQNXmn8w0?=
 =?us-ascii?Q?Isbfk6dZd733Lz9c5lNxBNUVpLgPAM2tu7sY2eZoPqnaLJyH28XMgZE+EzgS?=
 =?us-ascii?Q?KhSlW+n0bG8DowKdJ1FPkwifKTm6JiLt2suoP4/5FxsgUdIRmqD9p1NomQQ0?=
 =?us-ascii?Q?Fi4Kvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:13.2341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 739130f3-c9f8-4228-4f48-08de593d1030
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
For dcn2x_fast_validate_bw(), not only populate_dml_pipes needs FP guard
but also dml_get_voltage_level().

Remove unnecessary DC_FP_START/DC_FP_END guard in dcn20_fast_validate_bw
and dcn21_fast_validate_bw. FP guard is already there before calling
dcn2x_validate_bandwidth_fp().

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 2 --
 drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 8d10aac9c510..46985eb2a623 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2022,9 +2022,7 @@ bool dcn20_fast_validate_bw(
 
 	dcn20_merge_pipes_for_validate(dc, context);
 
-	DC_FP_START();
 	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, validate_mode);
-	DC_FP_END();
 
 	*pipe_cnt_out = pipe_cnt;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 2060acd5ae09..967e813a45e5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -785,9 +785,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 
 	dcn20_merge_pipes_for_validate(dc, context);
 
-	DC_FP_START();
 	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, validate_mode);
-	DC_FP_END();
 
 	*pipe_cnt_out = pipe_cnt;
 
-- 
2.52.0

