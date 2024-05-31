Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53A5C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8217510E6A8;
	Fri, 31 May 2024 16:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iAU/2MXn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B261010E61F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKYY5+xR6B8gaDvCg57KkJhb1221qwj+t/WqTWGU39IEg7rSKCzrOPqaz7aGigVQ8O4QtiTSBcrKZK3dxCI04aeMLSEVyE/DhWkBkWPC3RGL6CB41sKvF6t+V9O3jaXof+A657e8+t8GXzIXStkJxYlwxz76Kii06sEISYzYXJHWzkRyD70xNKHJ/7YWsu1tplBoxtAzgsNR1m3mpPJ+5s2AZcYvtLH1uvjoL7joRVUC4RJus4c3Pi9Vzb63uxH5G3t8Llo6h8IBA+gv1F9436C8OETnNv0fJycXRjxuOKllBq2TlI+cy7Z0/HYuV+eaDjqqvWfL4D0GnXZThkoLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkBVMWZ2kLyXXkR9bwqNg+vKY+tKX8jgJgl7TzJZKEs=;
 b=RUgHqCYvDKudSCePIvLqaTX7H/GPL6UUMtRM1wd8sIO36fdwNb5dxZIoRGOb9vwMbSNRToahTJIgOgSJijU4a7PM/D8+fC1D861ryyiccbNBk3vhE8JX73f36TQj3yuAb60FwWT8STODtNb+Gjed7NrMU6Z7uMsikHnQSGjv4hRNJlRmClYVBErH57RCsIhkuqDoCzcJ8bdtBygUPdbt7I2k3cw8t9ryDdOu3Pqqu9FLpql2YyCdjso2wZPqEOku1jzk+YCplT6zgcuwQF9aEMiI2l+RuWKZuXvZJbQ5SxknKuVpHTOPIKfNx/8bEPaP3NgMlLPJXyDenNwXBzRQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkBVMWZ2kLyXXkR9bwqNg+vKY+tKX8jgJgl7TzJZKEs=;
 b=iAU/2MXnBBXnmjvf140FblztQP45cZ0XLYuJ2PZi91H4I+QThcbcrkKXmL9lMFuTkRcF6gNHieRVMdd22MRjuwL5CXk3KIZLIQR3A/+bkFCoDdlu/qOvrbN6qTRoxM5n1i8j9zEOl26M8HVyXBRuFOlVh7KUP0yYtsb0lpmEIqo=
Received: from PH7PR10CA0006.namprd10.prod.outlook.com (2603:10b6:510:23d::25)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 16:52:41 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::43) by PH7PR10CA0006.outlook.office365.com
 (2603:10b6:510:23d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:40 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:36 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Daniel Sa <daniel.sa@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 16/32] drm/amd/display: Fetch Mall caps from DC
Date: Fri, 31 May 2024 12:51:29 -0400
Message-ID: <20240531165145.1874966-17-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1490bc-22ee-4f42-13f9-08dc819215ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zzkbkwe+2AfuOexdutj4TFmpfbr/XtLnqo3Al9In7SIoEMXHQlaWN5msigJ4?=
 =?us-ascii?Q?Psef+3uO6UCmRMdki694yXkNi1AW89+S45CjX+ub1eWw+cJXzz8D40nAXFmr?=
 =?us-ascii?Q?PvAXd+rY1wpQP7MySTNo2Lma71m1K8jBGXfbwFfgQgwgBPlDciAPX0Jet82X?=
 =?us-ascii?Q?D2yvsBo91zg6VKixyUCt8rOW/R8YGFJXux/ms8AjHXc5aNsLA224JuzGtqI7?=
 =?us-ascii?Q?AN7agqXQCipyqs75eIsdDpiQ9w9jGeTYpyeUHoFn4jhPb3TJccD6EMkQGaMw?=
 =?us-ascii?Q?BnANRgwptg504ih6VExnlFdghbSgV3wI6DpB0sfWTSlJ8V+1jDDBD3R7lxK9?=
 =?us-ascii?Q?s5ncvGbmeEnlDNr5Gb7HVAQY/bqONmf/7dKmUaIwkR8eX11dKsY/RkozvFbV?=
 =?us-ascii?Q?DjboIQ101/ic2kJRSUsXj4aXcCWiI2KnS1WnuklUq0YdlnGo/lLQNv6PbWjK?=
 =?us-ascii?Q?QbzUnSdcnRPdtqy2vh2aFKAOmnng3U3HUraczhPYKe9I13/3eo+tp2soMxhH?=
 =?us-ascii?Q?nInU0fPb4ZksZ5KW45xTqFYUmWPyLXCfIZSHf78DsLC1ksfNN+AwhQjnpMY2?=
 =?us-ascii?Q?iYaK0qL6U2SIObnSkmDhF73pwOcDKYuT1X4ix3dBqZELDV0rqDBd/tQi3UM3?=
 =?us-ascii?Q?xrPzIAgPXOglK7AB3XQAtk54w3yW8hz/TjUUvOaKp7V2M/EHbi53CxJSx+JE?=
 =?us-ascii?Q?IYbfgRkJEI6UQD42VbKVBmCVF1KKijMPEzOus/jYGUcDpqflWVGFAUGmZzL6?=
 =?us-ascii?Q?mwGcWk4FofwrnqBuF2T5ujKMtLMkxtoy44SpoiVoFejjUHZQnx3rZU9oVohE?=
 =?us-ascii?Q?5U2OwcXiQ4kbYuDVQRoSWK0bkju8Plri4v2d3SVUga65qlqPljZLhVpbryDQ?=
 =?us-ascii?Q?QPezkFjchN/UfnSSdao5NDGT4SOaegvfethFWl8cOFTn24sUsLg0O1pKQsHY?=
 =?us-ascii?Q?TgnkX++hoz67uz69HaEfl7JPHQ7N5BF7tSmuRWoOt5wV5A60Dxc4IFl/mTkh?=
 =?us-ascii?Q?SDgdAR8t1DYa7GzxiFew8caEPsa7/i6tnluBE2fO+EpuHEOmgHgpayoLOK3L?=
 =?us-ascii?Q?eN6Pl26SfaRKHweoV9vGB26oGm1ZbUKv5RgZ7Rz/ILkcGkQyDbj+ap9PtZ8T?=
 =?us-ascii?Q?6+PgpBaalLwYbPPWDiea4AX9+posR4cbgo2KwEQLn2tFY8t0pPeMqvqxJ+SQ?=
 =?us-ascii?Q?kO9HoIegihd6Y8JpeYFYm1Um4yolhXrmuQmMDee9t4JUXHyp71dxayX3BwA9?=
 =?us-ascii?Q?g/KyW63gEpYZKZcvWTxsaUOm1FqAqgLwY3Pa5lZsoPLDr+/9I0fEVwZov03L?=
 =?us-ascii?Q?EaAFYnG9x71PrUlU9Ma6kSxUrvebUHQB+81/ZmHjDyqL6cR8ZyJU7sRvB4bd?=
 =?us-ascii?Q?K6eWBYxtozP5taS0oZHRZ5URiImU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:40.8554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1490bc-22ee-4f42-13f9-08dc819215ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
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

From: Daniel Sa <daniel.sa@amd.com>

[Why]
When performing P-State switching with Subvp on 8k (downscaled to 4k).
corruption can be seen on the screen. MALL data was not being fetched
from DC, and the system things there is more MALL space then what is
actually available.

[How]
Read MALL size from dc caps.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Daniel Sa <daniel.sa@amd.com>
---
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 9f641ffdc924..a7d02da16bb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -306,7 +306,7 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 
 	if (in_dc->ctx->dc_bios->vram_info.num_chans) {
 		dml_clk_table->dram_config.channel_count = in_dc->ctx->dc_bios->vram_info.num_chans;
-		//dml_soc_bb->mall_allocated_for_dcn_mbytes = TODO;
+		dml_soc_bb->mall_allocated_for_dcn_mbytes = in_dc->caps.mall_size_total / 1048576;
 	}
 
 	if (in_dc->ctx->dc_bios->vram_info.dram_channel_width_bytes) {
-- 
2.34.1

