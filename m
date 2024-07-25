Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F506C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC7B10E8B1;
	Thu, 25 Jul 2024 18:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s9pey9xY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C2510E8AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDI8WLPrRzHRvL4FewvJ/3U2xR+OqNni1sI5ekTxGByCaLSnChnZpvMs7GXB0MhbanA7uf62OubNwnxbQe+FoV13mNmFvN13LtQCvnVwB4VLqq1WfRCqwleJCeBThWuttZV6gMivTzawoHCW51hd0xyRkkO9uMNNxa9oY+YK9f17ljjbGDLWbYhK07H96mxoVFmluKWdchR5l7snTJO8sGMh2izhYhdGe+G84hH0tmvA8XcwMQso7viO3X7Xia7vnWnr01MSrj19S4mXxWIITJHhVn56hhncaBpav5tpYbV1/QJ+8a0HTn5itPgRTUA7Zea6rKbOhSb+fXNoaAvyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSTdY0DtqlNsHd6ym+aXqHxAh4SX3uBJlXRcDyl9p2Y=;
 b=uX1UepVH6nYHdeAmlFIAnPALapeHzymK0FJeHa1Eonar1adI/jLOyOLjvdNkzJk0r4F1lw7MJD/idv2sN6yVruorYPe3guqjQQbMOpq1DMOkh4Vv7dRsdVsXwdpNWWFQZlK+PbT7LRKhozf2amiraLeI9fVPoFvubMV9eNNiIXbp2XVp7K7WYjeMf1gdozmN7bSt5+hRDz/kNriE4iywblYL5bNzsjirreLQs9trj2IvyP0sBF+DYSuXxnjC+wO+DXw83g4lamI2LYkJVwFq3hVcqaqv0yX4XnSR64w47MFS4RHHJ8dSIr9wfmGcpb9nqaiShvefBLktEBzYFswhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSTdY0DtqlNsHd6ym+aXqHxAh4SX3uBJlXRcDyl9p2Y=;
 b=s9pey9xYrg3y453m539Tv+oYzDiIzYuMV5dSJthbsIrz9yvjwq2aO+tDFD0tFQOX0RiwqgpEEgjSTZsxapPF+EZwW2OAzZwgEShT2kFvddxyF2l924BA6xpZMb7SH9ayJc8IAFNGOb60AMPDo32BBMRbguyUfXgR1bixydU4/fY=
Received: from CH0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:610:e4::32)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 18:04:22 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::35) by CH0PR03CA0207.outlook.office365.com
 (2603:10b6:610:e4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:22 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:15 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Eric Yang <eric.yang@amd.com>,
 "Rodrigo Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 24/39] drm/amd/display: Enable aux transfer path via dmub for
 dp tunneling
Date: Thu, 25 Jul 2024 12:01:08 -0600
Message-ID: <20240725180309.105968-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5ac932-9ecd-4fb2-7e9e-08dcacd43656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Qqg1jAYGDVxwucSmZ6FZovARsmkadBi1h7zZF427OPegQIj0heDpGd9udFl?=
 =?us-ascii?Q?9/5nxx/gNd60GTIFDNcEz2RcrEBco8yWctRHKGwkpVgw7bkYZs6wt4c3ZNsi?=
 =?us-ascii?Q?dsnyfagwG8brkSHFQi2vytOTiRNn/J+wfI+WoMwCSiMVspkqIlXKkA48ubmo?=
 =?us-ascii?Q?kZ1tiy6WiWDjeymwMXsmN97g5SZJx4O0eJGmS0Bt7+aIjjOtQW+hf2ZJSGTl?=
 =?us-ascii?Q?EOif2uzddYQq3Bqk+8jT1DUesRyRtFVZf+IrrrNFG9rK+zln5jwvk1sTO0So?=
 =?us-ascii?Q?51WGFAJ2ZQNQJxZT87wBpomdYukR302N6sinyZixQYGSSO91bFkwIHv1WBYo?=
 =?us-ascii?Q?6FRdIIXY92TEHHG+DOmWSZ9CKblCIr1FJD83PEJsNe+/sS/OqMwCz+iqzYXn?=
 =?us-ascii?Q?KxoRzjiXRRP5StbenfqSHGmyk2iEZHxprSNbhiqdUm4il8OcNUNzKg5j6PXd?=
 =?us-ascii?Q?hqNISWys7jJEBucYiePRQG8oFnfT3mp0rMdNQCxNiTYz27osmxVv4/2W0tD7?=
 =?us-ascii?Q?nuY+eqRJ8w1RcqvWh1fhdygZbkXdO5M7vMaZqzPnAYt3z+WVusZqflbKEf35?=
 =?us-ascii?Q?OKBqff++ovFug7XqmDhWvSvLO6k/tX5lt3BC4empKgNcxTHianwqlEn38O1v?=
 =?us-ascii?Q?tLQgOewkMNPfCg4EA89ZB/4+yHi+T91/RGKk5qeVjHEz3HsZTV7MIh4Ynzp+?=
 =?us-ascii?Q?iX6NLvRm6GsSGrurObyLFiWPeQT2F85VHUBt+oLCd4sx880SleWOIAKlwK++?=
 =?us-ascii?Q?OUumbXRynWmmOD2Tn33SeM9ruw0nkv4kB8ndNbQmG3THFvR++iwBSzmBDIGO?=
 =?us-ascii?Q?b+eRmJA9JU/D+3bVHynNuvdIJJfJyi50wcw0PmjhUArUYDuLxodvG8HUtZfX?=
 =?us-ascii?Q?4R1xwuQhWg3MdnPLo0TfVgDHI0nzB4MOjTe0hXvCD1fiNgB0EoVslCwAXDEh?=
 =?us-ascii?Q?od5HZ3esGKw+o5xKlfFdF1i6J6fuVpgyhbg3eDWW7J60eRfbktlWGBHwzfW0?=
 =?us-ascii?Q?b1B4b16FIsgJCWg6BVCKclKCwEq0oNE4IhcV7wTigz5yTDlt/33KzD3uXzfj?=
 =?us-ascii?Q?NLaxY2xu9NkcHJ8DTPDZohGpivD4lNbbINlcNeydTjjmzYzP6FAO0aHiJ7RX?=
 =?us-ascii?Q?CmEU91Oa7TDr+GySqsYGEthn+xll9BDP4yiDAhgwgTp+YtZJaP198Gk3Ik/O?=
 =?us-ascii?Q?qSYsnlxbxleRvg4YjbK+BqcOUrMdM/RJgX93erTpLfPFrShGLleYpqtUAiWM?=
 =?us-ascii?Q?pL8ecXyx9S09Zizj5KHhQYd326GuqjWlAonFpaWJd+NXuufix+HeuHgU69r7?=
 =?us-ascii?Q?i0q1tYOWRaXzr/2/PSWlfMtziHjtrpKPh2BUNhk5Ce0wGtKx3xR+4PgEB+qO?=
 =?us-ascii?Q?1DiXHYO1zwZzxW5a+19Onjv1YDmprBx7xy6JRHajTsIOJg4i/F7JqB1YHLOZ?=
 =?us-ascii?Q?JVFGRG95YkLyDidhVvwWFrDsp3+D3kOa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:22.2106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5ac932-9ecd-4fb2-7e9e-08dcacd43656
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Aux transfer retries path does not support dp tunneling.

[How]
Based on ddc pin check, aux will be issued in legacy path or dmub.

Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: Eric Yang <eric.yang@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index b8996d285f00..bb4ac5042c80 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -735,7 +735,15 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 					(unsigned int) payload->mot);
 		if (payload->write)
 			dce_aux_log_payload("  write", payload->data, payload->length, 16);
-		ret = dce_aux_transfer_raw(ddc, payload, &operation_result);
+
+		/* Check whether aux to be processed via dmub or dcn directly */
+		if (ddc->ctx->dc->debug.enable_dmub_aux_for_legacy_ddc
+			|| ddc->ddc_pin == NULL) {
+			ret = dce_aux_transfer_dmub_raw(ddc, payload, &operation_result);
+		} else {
+			ret = dce_aux_transfer_raw(ddc, payload, &operation_result);
+		}
+
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
 					LOG_FLAG_I2cAux_DceAux,
 					"dce_aux_transfer_with_retries: link_index=%u: END: retry %d of %d: address=0x%04x length=%u write=%d mot=%d: ret=%d operation_result=%d payload->reply=%u",
-- 
2.43.0

