Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D421C25B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5DE10F2AE;
	Thu, 23 May 2024 19:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JnonN7LG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324EE10F2A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R80P5+nJ7LQnRWvtEd/qIjyoxUcbx8X01JIKJglA4t7vUsNSk8x6bGw2m3jWSEP1WmQlA0jm0qMz+LyxDwjiu+ZQAUsbbBWCmT4AeYYysVLT0q1Aow2hvurm0RW48Iu2AIxlBgFrf6JlMJfVUMkTrsfbAvfz6pDzTrywgKNu+z7kaXXEuCeFZdn8/HSYdswB0e+q4j/ukBgVXrRGI2RR4PHc4mwXpYlWgTTfZ7yXdBcE6x94kRLkr3y6EcP8yPTjqTky4+YaRL4ZEXKKcpoDPMbbsv5eNgsB5vCFQTylDkdPvOfjYZwXFrYTPA93G1jT/d0CqAZBiCTInvPAKVlKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXlGecfiTRrSG5ZfCEVB1yLjLXvQ6dOBBx+8XKtGQ+g=;
 b=D61X8Oy3B6yi4CP4N3nk73JNoBEao6h69I1OckYamR+QRjS/KQKULctVZAhzUKaXxG3PTMRN39jnotWQ6Jq8sryR99EI840pmVBNgBQLZvhLbJqoeB+Sw4GhlVXGNdorztaOO+V1EKVjQgcNvjNQmDsm3vVx7tIaj584+/j6qTZtt7jXFJujGIkXc2hrq4x9SwkYL161+/cFkiXa6YniEDJYJXZAUQKqOw/TfeenUxpKffzYTrPDXlkAzBMfyQkZVMMtRw4PlljwLTQCHyyeTFOQB5LIg+it2Yr/v8YRJ/snbf9VBffixo3o5z3/atlb68BmzM22p0NQZQd1hwHF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXlGecfiTRrSG5ZfCEVB1yLjLXvQ6dOBBx+8XKtGQ+g=;
 b=JnonN7LGpZSZHGU2NpCMltZRMULKNMoC6g/oZtKFnMsMx+nI5C3nF68PLX+bFyAecj4FMRhMRk/B9+IBrzEMMJRwNxo+XCqxhpskqFgBgR907OGEkVtNDcjZYsYqxJLpel0WRL9HEPPpZ1pBtC//UGdaHQ8Y1T5l9cbOd9Pi4EA=
Received: from BN1PR13CA0017.namprd13.prod.outlook.com (2603:10b6:408:e2::22)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 19:21:13 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::cf) by BN1PR13CA0017.outlook.office365.com
 (2603:10b6:408:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Thu, 23 May 2024 19:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:21:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:12 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:21:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 08/13] drm/amd/display: Remove incorrect FP context start
Date: Thu, 23 May 2024 19:20:22 +0000
Message-ID: <20240523192027.50630-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 89aac6be-1964-4d4b-29c4-08dc7b5d8282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BIa4vE1l9rJdCZ/jl07eL7ohK6NuQ/Kuav8SkHbhF5o/5cSoBfA29mcgwSqs?=
 =?us-ascii?Q?5toNEQ4p1VsWJZnjLjFW4vH2pOOCYPIxsooi+ma9vwBw1TBhiWFpJybLQaXP?=
 =?us-ascii?Q?NpCaIzQf3PuLorBsfg5ojgzEoEfBRJDEip4lrvc6RjVvNY+wJxBienjOILUE?=
 =?us-ascii?Q?JMItpOrWtBr8B8alyr6Mci0MwJs3uDrq1J5LDw1CBhvP5oVdMcZew5O/wD8A?=
 =?us-ascii?Q?TvsZO2a0PCUm6//Q3A8hTqy1Rwdow1tkrQVBfOWDqSHlGd1SZd0vmW/O7CUr?=
 =?us-ascii?Q?ZwyCSdbWkZDEjaH4FhJFj3J3SCbEa+HxK1YmWYU7etgXYJ35fMfgJT19XlnH?=
 =?us-ascii?Q?YTuJk6WIJRA7q9H4XdrUEVl1r7MVCw6qhECO+VwSwvBoeQBTJDzMU0TSra5+?=
 =?us-ascii?Q?AX10c2ppZEdKLMLamrbZPXYMFuMRsOlB1XFhLgvILlBx9oGl110wpFWWD2OT?=
 =?us-ascii?Q?dAORpDzhBrII5zG9NTmV8YvaZvCVdAsR1dunQImK97YYerlR8BuraEU1jSll?=
 =?us-ascii?Q?l6Rjmsoa6YGFp/HuTfkAtIQ+wL+I2EkVN/w2PNmTxZQ1MQ2tHb9iAXTGNaNo?=
 =?us-ascii?Q?U3/3E/nSzrGeBTD5XS3xyss4WOu236mkbX+O1uB7kvOu6v5Hg8oermDELf8Y?=
 =?us-ascii?Q?KGcQWn5c3sKGRHBKX4IGBhWU3KIlx+ykutjtZqujwLGWDLdJD5XJFNKss7aK?=
 =?us-ascii?Q?ynAotu2T5BHwrsQcmM3stMWehzKrbQSu1OLtNSVupIKdWCVlusVLIvjKUKTp?=
 =?us-ascii?Q?uesYL3La1DsQ3ldlin4y9AVso1OZ8KrxqTuy68Jh3YkFQlQo+0u3g9/98PEy?=
 =?us-ascii?Q?bqs3z0x9rLdDq7Kh8GpKHHJGz8lRAvarMIVZiSThbOIldULdijdBf54amuw6?=
 =?us-ascii?Q?XxAcKTa5270kK7E7ixqMCAAHSED2KmWWXilnXeKfAG95JTzMSQJO+g42TpXr?=
 =?us-ascii?Q?jFe0ImUhI53N8B/5R8USra4KyQZqBHKk7N5B+NTcUuRZCale0e8i+5vFLTZN?=
 =?us-ascii?Q?f01CQvYslyT6dbZeNEQ/tVgLpxg7XhLVrKZyPgJLwbkvGyB9XeahGPWjXRbX?=
 =?us-ascii?Q?LqimpMSb5AmC+CMqoGggndsebolox6O65kcedu8S1hGowRQvnkE8rtiVnrEn?=
 =?us-ascii?Q?3v3N+5gRK1XrNuEYYdVuuTxQveII2EHO/EjBfk1T+TldY1mTjBgLyPU7AXQu?=
 =?us-ascii?Q?3va9eiYvoeGdK+0IvZ9WRkBBGq4PgIZnsg6CkzurwXIMfnS9CKrjjCiXoLz/?=
 =?us-ascii?Q?ZYojgTVUCMXRDm+1M+P8I8HTUWynnjunBIT3YFPQHnuW3po3gUOJ/tj42h2F?=
 =?us-ascii?Q?fnGfJ5GNU+us9TC+VMig1nba+UmdKYXWAQVQ+VqQJ2EG+d+8/Z7CKdoyGZ6g?=
 =?us-ascii?Q?Td/SPXRCWoQBa0AWDsIob/QjhxjW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:21:13.1042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89aac6be-1964-4d4b-29c4-08dc7b5d8282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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

All the DC_FP_START/END should be used before call anything from DML2,
for this reason, the use of those guards inside DML it is not correct.
This commit removes two unnecessary DC_FP_START/END from a dml2
function.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 22f6a59d8ed2..5fe1110c4816 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -759,7 +759,6 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
 {
-	DC_FP_START();
 	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
 	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version == DCN_VERSION_4_01 || in_dc->ctx->dce_version == DCN_VERSION_3_2)) {
 		return dml21_create(in_dc, dml2, config);
@@ -773,7 +772,6 @@ bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options
 
 	dml2_init(in_dc, config, dml2);
 
-	DC_FP_END();
 	return true;
 }
 
-- 
2.39.2

