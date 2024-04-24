Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691A1C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E988911395E;
	Wed, 24 Apr 2024 08:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TsTO9JjW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CD8113979
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGxGWauUeYPckhRgWqBWdEhbHF1oMi3asHgbTgH775tReZrlQ+JF2KdMNPYeM7PE7G8yeUPUiAYAhdwr78BIclXJPJBH12cCv3LTzHMtbi5L+OoSXAOgi5dstUn0NfMCjx1aHXhxSI7/LbqbBcsMdADVIolIn32JFNQYiZ6aPU5pA1zPGQAGZzMLxNoo8+LVugUJJa58AWJhUyzOlJ4ZEkpf9Sknhwbs7PDtkHdg4XzhnruRYEaHYLIJpHai3Bs5BpUOvTm32WuSmcP9orPiFYOmJotWASP7Z6AZnwyEnclYdh4pXdNy06yHwHflsDPjGR85C3fiDMMY6TjTfICs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XC9kK6sXiuRS3m05DOb6wfqc2CqQdKrIjA3T7lGCTxM=;
 b=kdy307zGyGGB8PvqYUYd3QvtkAsiPn4ZPBLhKFWLArS8Skb2dukJ7KgWdhfxzpF6lH8xmVgGuEOLoJQAYKqKPYQp6roXw24IOwT9zD4pfuFTOOuqKf+JT8LPOWjIAq1O/ZYpJSxM7zr5WofvaWigv/fjV9sQxSgRqW4eSLz2UXUDyEjR0cKtiYWY0fzC2Vmnb81ONwIHiSKkv56GWLGGKgMes3WVTwqMIjwTnh4ZpIJKpWq3qGUm8/rPjdWfljS+HXCWEKgUuRzXGhnhZJhw9R67OnFcTtnQM3tiN5k47zFqUPj1MQ0uhk6ng9GuI6YxkZRZYGXRP9mz5y9VkDJITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC9kK6sXiuRS3m05DOb6wfqc2CqQdKrIjA3T7lGCTxM=;
 b=TsTO9JjWNOWZYxK5iCpvDcPcf0Z8K8qZAYyupBF+AskBhVm1AnRgN6OufEM5b8fu4zZzEFx84DYlQ7TGSHvJVPzqPmkwcSV+FJHMZiZvxx5n/j5FYpKVTaLEE+ra3rRTtU9mly8fMGlUka4mlEiRwFCbO1tKozi5FIpmrxM3j/E=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:51:52 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::22) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Wed, 24 Apr 2024 08:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:51:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:51:50 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:51:46 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 14/46] drm/amd/display: Add VCO speed parameter for DCN31 FPU
Date: Wed, 24 Apr 2024 16:48:59 +0800
Message-ID: <20240424084931.2656128-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e31232-f79e-4e65-a3b0-08dc643bc933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?luXWFf1pF4ZnW7XFYm/MxwH8rwA4czSssc7DLIF0e9fvRZocylh2BZgylnMa?=
 =?us-ascii?Q?su6vhpuIZsP4s6P3C1hz9LhEZmzjT3kGD4SfpsUAhyoGicR9tlwbwQiJN7XT?=
 =?us-ascii?Q?mGqlz+sT5DAhYjZPnC+8mR4t5auVKVCi95d8Txs+PBGywkBruRLY/Sj31QIb?=
 =?us-ascii?Q?JPqJx2h8bw/hFwiJX+oVNmaSjBmQVcx/d7BbDGdyaAtrYyGrSKEh1l0KWYJI?=
 =?us-ascii?Q?XQsLiRmioDA1sNWAh8mOwbwWja1X6uJK7yqKmsXfppn6Sn92XTmpSfH4yKQj?=
 =?us-ascii?Q?o+az0bQCmMRxH7MUTpVcJWjz4cSuQrH8JisAOvdLTrTzykwoc2SHLUHZCk0W?=
 =?us-ascii?Q?WdYQqbI4/Ygmln166nm86gKXLrOFMAKXUZXWKVJ3m0rcLifH1rTrNH3ay5gC?=
 =?us-ascii?Q?207cWYaRdsaarQyxiD1OQLq2ifEcUXzj0MU4+i215zBCOIHtXzHzq9DENOzX?=
 =?us-ascii?Q?i3qPQgZr01r5KXNBogBCdYAdoVW6OgTDl2fzgJmh9eRI9Mqi6dhH76r2svl9?=
 =?us-ascii?Q?UMySvvAW5mwV/ChlVBMixhhJ1n9HCVi3QtvJqBUmI9JQsyH+vjSw8Zix8qFn?=
 =?us-ascii?Q?a+Qkl3VzDezeKqRzJSzCSVNt/CgxVvf/KguD9UpiHGThqG84dWa2IYNFcPtt?=
 =?us-ascii?Q?HV+kQLcHoIVHo1x3+yf/4BF3qPA16HOJ0EIHxoHADofe7M25g8tlFv18WXgk?=
 =?us-ascii?Q?U3tGBDS9Zs89IwuJ6uTAOm8xxYC8iYsi/2V8tJ9zybuJqWkvH2OOwCQDt0Jr?=
 =?us-ascii?Q?PhBu8Jjv/HvZAn2gQzGyg8gj6/x1XJRiUpAIpcRbhLauC/V3EuXmtluXaGoB?=
 =?us-ascii?Q?XMcmX/8zwj3HVaKFPlA8Istaad8sHZhSz605keuI3n5VDrvvKASMLeqr4jp+?=
 =?us-ascii?Q?kU6vxfkqojmQOH9gD+qtEUnKe1ygLKMz8PZ2Tb/smXeMRn8RWV3O6Oag5AvK?=
 =?us-ascii?Q?SrCIEv+aMJeMWSzRviX2pZb5t35xJfotbAQk3yN4G6dxIEk5kA7uMS+UmPGd?=
 =?us-ascii?Q?wjBqsmMpHRZmuQdNLp/f2etZb5vMqzOpwB5AKNk7jXgj5DFWEY3UDzKA3tFU?=
 =?us-ascii?Q?fiDfLo705lCe9PXlof39cYTPi78hHl1qDoSsYfpTtLhR2o6F1h4Hs05V27gs?=
 =?us-ascii?Q?OHFFKWjaYoQOKz5aXZCINcg+FAcOyq3VXuw+JqItchzvT9WIBFJYw/IexfnW?=
 =?us-ascii?Q?DvHJZie72VjzcKuQ+c/ADdyMxNBxVcUODSBN96cClJIxesieYDxNXgcE+iQH?=
 =?us-ascii?Q?dF38w0iVogj9jJ0l4DNBEPL4W4HONeHO39UNeWkp7p7qkga/eQDhBW2bnRt7?=
 =?us-ascii?Q?tZTGe24SbMkIgii7w04KaHBnj0/rQIfOKll5MzyaScNwCtNLlFg3L/vRvpEL?=
 =?us-ascii?Q?w17WF5c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:51:51.9501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e31232-f79e-4e65-a3b0-08dc643bc933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Add VCO speed parameters in the bounding box array.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 4407640c5f87..bfc042209007 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -291,6 +291,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
 	.do_urgent_latency_adjustment = false,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.dispclk_dppclk_vco_speed_mhz = 2400.0,
 	.num_chans = 4,
 	.dummy_pstate_latency_us = 10.0
 };
@@ -438,6 +439,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc = {
 	.do_urgent_latency_adjustment = false,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.dispclk_dppclk_vco_speed_mhz = 2500.0,
 };
 
 void dcn31_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
-- 
2.37.3

