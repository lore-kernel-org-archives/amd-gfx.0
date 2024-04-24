Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42231C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46FE113932;
	Wed, 24 Apr 2024 08:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dW8KOqo2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B5911392E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSi5U5sU/F/bANTFeQLpngnG7luypeq+fPhg+olXnYCkgPgOj96AsMenup4Hdk3ssq6PpXpS4oEmg7dwYiaLz52/5uvQXKu/VuOoFRz7QHgA4c8B+u8U6ryvMYLi4nc/9H5ZaKtHPDw9Az0OsEIWVfs2Mc4teYsuym/K0mnUGD6ZfeXtcard+FQYqyl/x8hBsNPxUq96rfu5SSw69SyN8N9u3O4aenCclKqg7dTGTzI2u4ss+K8QQ5agNlOEx1hOv08ZCw/yCVhrjhH9+JEyn1KwgstgVWLYhJ+Klpv3unCbCAGhDW6U1I9Xmfj3qRL6yQimPM/iFwV7FFeIga5I4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XC9kK6sXiuRS3m05DOb6wfqc2CqQdKrIjA3T7lGCTxM=;
 b=j5R4+j3e/BxegT6/x6NL2ZAtL+b63FOOjMubzGFmjFVGjaZ80yy5wVZfQUEegKh79j7Pf2tEgEPa6wiLihvKvA1AW81bRR2g5P5P5I/dOdbvJSixtLxVzYy7wKfbz8Wg4B9mFd5W+LY1rqINcU5Q03OqtdD3KISKsKYxBYwLGXzEi36F+1BehKkSBc1PrDBcy0z7qBsjwKiTUl69l94PL87xD7sytaxHbxbt5eCkfWFvKm5X1EdAnvvMUU3UZgL/eSjv7chlxu7Wq222GCHLmVpf1vyQ87cWFTvoug6PkiF5AySAq3wgFCGi0YWH5kOxaSlfz+U1LyMyMErJX4NaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC9kK6sXiuRS3m05DOb6wfqc2CqQdKrIjA3T7lGCTxM=;
 b=dW8KOqo2cAvXs5yjF1pbkmAARVx6qNG6MDcboo27Q615UDmzior1XxmZZV2RcGLpZ181xDIVpZhpjmr9ewhTAv8Yd/OfCPqdlao5CxZ7icAoie6STkqm4Zoe31TuAZq7meVh7XpJFU50hjTzD8dzWwFO1I7W/U47EHj7yBqJfCk=
Received: from CY8PR19CA0021.namprd19.prod.outlook.com (2603:10b6:930:44::20)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:42:00 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:44:cafe::22) by CY8PR19CA0021.outlook.office365.com
 (2603:10b6:930:44::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:42:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:41:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:41:58 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:41:54 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 14/46] drm/amd/display: Add VCO speed parameter for DCN31 FPU
Date: Wed, 24 Apr 2024 16:31:30 +0800
Message-ID: <20240424083202.2647227-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: d3deb310-393d-4eed-9153-08dc643a686c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?96VKr+9H9pdqY9b/e8ajSp5rJcYirBVybRjEKi/oTdMP1AKYlRXro5SuOkgB?=
 =?us-ascii?Q?YCSk4bC+rdBDSs49lpiLhhf17f1EPraSIQRsgJgH7k5G/OkLcc5WI5PisV8a?=
 =?us-ascii?Q?iqTVIX4ADTsZVQTgeoZYV9w7hGTdcD61M2dF90Ip/DfugAdFvN5GUTQ6ccSo?=
 =?us-ascii?Q?lOLIhI4qoivhLs073Iyyhbnt68Z70at7LzDPbTtMQ6ATHy4pAELys4q4GYtm?=
 =?us-ascii?Q?4JXZLzOeQTMO9W8/Oj8jvJIQV64U+tEE5RJQaGlpoS5acnbsSD3ybCDGUfyA?=
 =?us-ascii?Q?qIunoWmDkkC1k4IPgOje81GZHYAVEi9nxXic6JRc1Bmq9NhsEXZppUDk/na5?=
 =?us-ascii?Q?2GNnA32h5Ts511W7QEO0ewstRMj2AP5kJj5unnGv6YTl7y8wUhM5bUzLUJaU?=
 =?us-ascii?Q?Yje8SGlQtWlnGYmcaGLj3ERWs+dM3CANMxDqcCE0MXC01/Q6DSbfp8UZjkT7?=
 =?us-ascii?Q?DqWqB83sW2yisYdkUMEIjtHW/sBWidmWfC/KLxeEZvBTYsf22jzZp2DUQ/RB?=
 =?us-ascii?Q?m96r3dPrvTDAyhQ2yuzpmp7Tw/jbnwRrVI0NVDs46bzxEIvkUikFGQPxGCUP?=
 =?us-ascii?Q?IxHLvrKDR9ATY9hNgCPpMzoIQVf3m5YaLe0KjbgPQRQfaklqnFTleU4z3GFG?=
 =?us-ascii?Q?zXAbx7Rx8oC2586wzeHSl3yRNlZxcH0N12GOgAHSaErk86hxgpcLXIsLR2ou?=
 =?us-ascii?Q?tviFj1kG5b06W4N/gvyAWdaFMPAEgXISDyLElLHLM1pOK9qABhv8Xkx+Lg+7?=
 =?us-ascii?Q?gWe0Bqr+Raf5aoQCctzpIDXhIUeIc2R2knOq4yJ0Ku9o+xLMXiswwMvjKF7J?=
 =?us-ascii?Q?L3W1lJD4ZkDy7w2OsWI1DfP4moklwDjF/1e3qAwYncg54Wdb5edWoPEPtX1h?=
 =?us-ascii?Q?+Ow+RVJ0QQnWGiCVfrahxjyeZlsNEkQdQJ7QDACwvTgYAhfTCj+zIujOs1W4?=
 =?us-ascii?Q?8AQZzYOyOxJ4y0rAS8Y2wmH/TgW/imkLlgP1io5zFG5iENltgrCUagh4lcvg?=
 =?us-ascii?Q?79RWfj0apuEgR5mnpH4n28gLewBUcxWfjsb9N6HTVIsuxUDkff7FnFPqAmgY?=
 =?us-ascii?Q?7tvd3fzluONvVuseAH95NNiTiRVc9OvU7KRrBNGyQg/aYLxbL1n7enY9w2ZQ?=
 =?us-ascii?Q?qb9I7qixOm2gCJNBRJRm9NKeEflRhHR2ufmiAhjDERK8FOz28yx2XmC+skpt?=
 =?us-ascii?Q?Ygrcp10peMMDsEKFr0VJv5Eh+wN/U2tvsjSWQdLce3wXDj1IciDL7dZZnFRA?=
 =?us-ascii?Q?BHA448HoBUa4OSln+a15L300se5lasbvCIefkbm3auyVezpdtPiwgP5hEYIO?=
 =?us-ascii?Q?qM7geL/eOIa1utlxNBdPXa4dkY9Q3nkVCpUJgsWc7LuIoehMR2ifKiNFjbcy?=
 =?us-ascii?Q?fZ6P90I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:42:00.1656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3deb310-393d-4eed-9153-08dc643a686c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109
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

