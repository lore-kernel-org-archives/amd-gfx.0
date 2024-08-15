Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58686C531DE
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F9710E556;
	Thu, 15 Aug 2024 22:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SXmShbCX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C32010E545
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNoDgVPXVqY6zngTkxkY/6ZuuiUFCcNZHJLfr7GePoe6KJMzDKR+n9q50zy6zDZbhmwEm7/mO4FYU45zC8sHCy76iG6IaMRTap49T+Ad9rLxl9vDFwYVvBvNey7MsO0j3u/khbOT5sAvdNVRvnjDMVE6yppG8hUZEnJ+gq0j8RJnREmiPH1TSz3UaR7GejaSPm5hyzEJP+jJIUA2hkwuykWoM/KdGexY2WmyhtArQSK1zr14wrZLP17rbLjK3hZpvbM7VERTSmx7iVC/bjKAc5OA0ssEOqiZWz3dQprnKhLgybJT0eb4LrwrTwoOOrRtiwHSi+HcI0begvjmP2vIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo9AZ5h+Lgye4J7p9RARBj6MRPjORQVj/Q7c8xKV7AQ=;
 b=Yy6fDojK0svoKaRHtyCm7VrnTbHwmceqy0XBYAcJZrWan1AkesB58zecRaCpVfEONNAo4HRCdKt/1O8ZqK6j4jLj5FmqPmSBoxdDhMdzkojMAO6TN2B2pER5v08I4ippFRM7gdW1kTsY9E6YIeBEBFrQbwub4GcMCjZocdVWRL7oJExAifSkef9KJkcQSdj0/Tc9+3alKe3agYzDT+5SHccdSAB/9oWAi9PSskruYCujMJVQ9VzTIKKKGz9dpEBjRtwDTtE4Ll0dBS41r7xcbGg7FRuUF2p2JSxp4rhlAB+3BDYGq4mmGVFUQcZvmywWvjPrMw0mmtqb2ntJ4cu1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo9AZ5h+Lgye4J7p9RARBj6MRPjORQVj/Q7c8xKV7AQ=;
 b=SXmShbCXvwEJkhEH90ab8WsuCL4tk89235Mla2pKn7QOoD2J74pFKqDfNtb7yQOwlXUXcm7Gg3p5xnx6Q/28fM5qgdNrCud/EqsTn0q/QEhQLMXMenf9xTbI/iOnSxftXyuyp4o45Fjh1o2jRaBwo0IxZqL6qFesgsfqArwFw7w=
Received: from BN0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:e7::22)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 22:45:41 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::7) by BN0PR03CA0047.outlook.office365.com
 (2603:10b6:408:e7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:40 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:40 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Nicholas Susanto
 <Nicholas.Susanto@amd.com>, Hansen Dsouza <Hansen.Dsouza@amd.com>
Subject: [PATCH 04/13] drm/amd/display: Remove redundant check in DCN35 hwseq
Date: Thu, 15 Aug 2024 18:45:16 -0400
Message-ID: <20240815224525.3077505-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fd7b0f-c0e6-4665-3974-08dcbd7bfd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k8w0Xxd6jS4dnKhqR6Y3CySXsbPQFK7Im84ECm2IMTV/jocP8WEa6qaaoFAp?=
 =?us-ascii?Q?neWJjJ42CibKEtT2ZVGBIfTG5dMKJbP971lm4Rr5PdNNsciChP5wecMKreNO?=
 =?us-ascii?Q?ac6zrbwFn/5DSeZrlYvvbhS4fZdpivajj9fCnhFODr5sXQ5LDOHKkUqaz5kN?=
 =?us-ascii?Q?/OyRQbuuoyw7aDCbQsUyvsNUsV6LBzSTuNqD8iBDeFIGqyDtwz568SYHLU3P?=
 =?us-ascii?Q?s17kw0SwZw8eJvdw9c22DlsDCQWtyFX1VdoHcBAHlHK66rNgHoMJbQoOmBdC?=
 =?us-ascii?Q?+hcntMEptFlQz/yQ5OwMmUJpvLR/q2QIMIKw37Kp5UTMIRwa/cH8x1p/jD/w?=
 =?us-ascii?Q?aczc3tdABxvxpiZQTW4w/OLFMoIOJbwOzVwK7l7WygO0pYLTfzjd/LDkwufF?=
 =?us-ascii?Q?g9KG3PvYuV/jerloKVuNYWqc3R2PdKHU/sqiFM+bJM4xqU0FFgnnTL80bSTU?=
 =?us-ascii?Q?H50svNuSzqiRSqs7Xado4B0oJQQE5biYF11bNIhAGBnVzqutRH9t6oVjV52+?=
 =?us-ascii?Q?EG5pkzEwOlx/oFvSe9WGT4Vh9FXWe35SMM+KDpzEEZJVUHW9R0K/2fOOgTng?=
 =?us-ascii?Q?Q8A9uxyDp+XVBIW78iSDsmdRaeVIaADIw/EGb2KesCRLf+jb1HkWtgnBvoYK?=
 =?us-ascii?Q?CVXvUCgWIKfHuWgRjHWTi79w2jqs80H/icYDnVeA9wkLx5/exx1Yow/eMygH?=
 =?us-ascii?Q?e4KQ1wSK474LcEGHr1Hl0b6GODkn3fqsI1z+3atIyELDBstOK+M/7E30+MmH?=
 =?us-ascii?Q?BXywTwveWfqf6xsvlR9jqIw5xBPM9h97C3CTju6Qwc/tK2Uk4btLwZUWGt5O?=
 =?us-ascii?Q?b/Djgvv53lTTCmCpmyxGVcEWZoLGtS8gjNGx94Oob/Md1AGsMPNVstW6Jd7W?=
 =?us-ascii?Q?khQTXKHtCbkN0M95ygMrNvf1fhb2rnb1ddORgaYuNmYcdDhYMathKO13TAvh?=
 =?us-ascii?Q?W+exwr3a30ovi6IUkSsGuXJnKWn2RqvlUpQwj20OXt5qXTuqhGCy7F7jbDLA?=
 =?us-ascii?Q?XYpYCPBfC9J5HPeHQBj6mUMEuzgaVOhvhQHlQ1CB38rbh4Bw6b7eSKhd6Lm3?=
 =?us-ascii?Q?42/HWLvt4hC0iEqTDX9ez6d4UxrbWRiuyR0tV6X4dg9MKjovF5buf5ajI6Xy?=
 =?us-ascii?Q?IHDFpMUBLILXx5KdHyhIWQB/1Eh1gu8eEtcIAPi9APoK3Q5IbNtPYl43WxYV?=
 =?us-ascii?Q?ABl6YhPOG+45ZouzsCxtrW/Y8JrwdN6sfeWFRRi8oJIZ6XKzaolQia9YYBj0?=
 =?us-ascii?Q?PcpJd8bUlaDnCXozrAbUVuWeFwiPJ73c6oB3K09vGRw/9A14LYEpYrTN9UND?=
 =?us-ascii?Q?hBcJZr+PwIgVjb6qxbWnEHOUZaDCzRwk1xVKFTn/53vHkVfzphwzpjHAL48I?=
 =?us-ascii?Q?igxmHfqU4kSBwHIyRWxIXHfdsKE4gdAaiEnqoSezl6PCBz8pF1L+Sc6sq6uJ?=
 =?us-ascii?Q?N4f0CqnoYiXSjPoYrbdcLvxyJ/da5f+Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:41.0087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fd7b0f-c0e6-4665-3974-08dcbd7bfd75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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

From: Nicholas Susanto <Nicholas.Susanto@amd.com>

Removing redundant condition.

Reviewed-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Nicholas Susanto <Nicholas.Susanto@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 899e239352aa..fbbb20b9dbee 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1024,9 +1024,6 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 	if (!hpo_frl_stream_enc_acquired && !hpo_dp_stream_enc_acquired)
 		update_state->pg_res_update[PG_HPO] = true;
 
-	if (hpo_frl_stream_enc_acquired)
-		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = true;
-
 	update_state->pg_res_update[PG_DWB] = true;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-- 
2.34.1

