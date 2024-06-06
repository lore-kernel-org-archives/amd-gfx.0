Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C11C27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C75110EAB9;
	Thu,  6 Jun 2024 21:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y5JxMvsx";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E05010EAA9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWNtm151PwKcMLx6uCPOmMIe1LX8LC1qM+Seph7m+moQY08ndguQIt74yrO4ETwQAYmkVCbqqbFNfH753sxPiLqydin7nDLoorAcx3XCWG40m07TT3KJl+sStdR/gNtfg501xKBw3ZhEMo5ZVhEmb1z8v9HBbRRhqFUe+MUdduNZBUxT4H5Se1YMzshGCZXU1AF9/ZpEvylfP1BIS+RCsk7r/l/4xvAPUvtU3m3oehbQaXlQqDeicFqRq6f4/NG7sbP0qLRw0OEjUGnxZlweSgKEG07oWEdA9yoHtVEg9ZIUCg1ADpgZKos78YRjcXLZsPkjUq6UGnBTsqUQRfs+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRdIDBRb2SZfo2m0/ZfQJTIWZpNayzBy1HeQ273R85c=;
 b=aOkwFoI2TFfjyZY35OIpEqREvTdK82Ma3o+F0Ja2kiibFH74CuvrlfaVa9SjM6DfworEsmGr+Yx6EOxnXwSzcOPco+EfJ5YbTckNU+bpdLDw3akSHluzJzy1gtcq5gnQzPkTDtM0lAHPSFEkA33F29a0H70cffzFXRRaIJJ1zkG+93Br2Xq6pKdI27V/cJ7nV5085OSbB2FNaZa99b4fPlB/SminzPq3woG1I4Gn2ByRThU2dQHXg9Ct7YTkJClXiwrU1xnukstAPNYCpfoX5VqLlcG4Och0yhCjO11ciZJo41lDZNtoRJrL29gk1VMbRiMrnQskNNjuPzPnuCNtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRdIDBRb2SZfo2m0/ZfQJTIWZpNayzBy1HeQ273R85c=;
 b=Y5JxMvsxTtKnazFfAplf+37ntinRCl7+6LC5YJco0aR7WLDK/4zSfhkX11Bpez2NlzkWggmcB/+vCESGDyF7vzC/h70im8095zwIKPh5hRYijejB7Hu4bpYBUa7bINkrgJl/v2qYvGtey93w7bg7/9Ey0V5bdmLDIipu0PHKjiM=
Received: from SA9PR13CA0004.namprd13.prod.outlook.com (2603:10b6:806:21::9)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:02:24 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::91) by SA9PR13CA0004.outlook.office365.com
 (2603:10b6:806:21::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:24 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:17 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 19/67] drm/amd/display: Ignore phantom DTBCLK requirement
Date: Thu, 6 Jun 2024 16:58:40 -0400
Message-ID: <20240606205928.4050859-20-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 376b991e-1ecc-491d-907a-08dc866bf6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tdM2BA9yOjNItJrvhULWmQGvHPRAednCLpFheSxwgk/MpIsStTShCmPIpPrj?=
 =?us-ascii?Q?x8K67REELmeIJzb9vE5Pgq9czSBPVXXiGfEs7z23sg80RoH/B148fAfFyVrU?=
 =?us-ascii?Q?swvHPBiWhkOjmfWP3nF1bqhIsxYP6bqzkTh4/UEETW5YfHiqfoyQpvWzhMZj?=
 =?us-ascii?Q?VHMQJkOHHR54kOCDSgdlv6X7boiza7tq05EFjzOyXWxcNW7hE28N4FMOCkri?=
 =?us-ascii?Q?GIe4Cv1uXNXPHp5plIlI2DC0CNUo7l816Oy7/QfeMqyKAFPYVJNX+0gklPd9?=
 =?us-ascii?Q?7s/jQ2xYhaeFaHUcM0ErOVxaurBQsHEPL4imNSJyIu5B0xLxoW1XLwkN7nPH?=
 =?us-ascii?Q?jIKEeo1oZBZmq5XyGctXKjQIIhvotf2k+fDIQK8OYQX7pfQADva0A8ZeObj9?=
 =?us-ascii?Q?eRjRCFVIoH3oeyXbKWGVP6QxLd+aq9qvSWBR80j4xZGsrVQt9/SYy32vAEMR?=
 =?us-ascii?Q?o7a+OtyRvNCcCdGEnzrrHLyG2UBFyJAu0pzRJgTcOAxPxYnSo+EfgHMtx35R?=
 =?us-ascii?Q?wKD/KqNet9fBLi8LHtWRhxj5NU4kcj1Pb+Y/JYCGda8Q1cntz2UvFFrHWmRy?=
 =?us-ascii?Q?kkTDukDJ6noaWM0RgQSuj60/fo2yEoGbzBZjWdvF06YzWcTiXDKkPTy48XxV?=
 =?us-ascii?Q?rzaLl472IbdlU7AL1L4q4KewQBcQq6F3BgOp2jrXWaUbRcdm63cSfsGvKszz?=
 =?us-ascii?Q?kVWVv8cWHzgd3jAei/xUoWJWsoTR5N8GFX0TiNDrfuDxPpJW8N+MO9C1Tojn?=
 =?us-ascii?Q?tv7eB/xwVEwEfGWayd1e1x+XTXtVPV9WW0XjN6HF9ch+tWaM62pLmybuRv/R?=
 =?us-ascii?Q?OCOilZf3SkRfq/uxT19mZ6Ca2GOL5gyV2We+PbjSoZ4DGpy56Ez0KHa2n1bh?=
 =?us-ascii?Q?kbIP4rQp4RoC0wNuiAMzuL77ypjyhjkTP1IGMGDcO3Sj7ePi8IoC0caPY8C3?=
 =?us-ascii?Q?YBrUm7gzqvVQWTA1GpZNSlwNK5N9TR767yMsS5KT5XKL2ZGNrZ7gqIqOIFqd?=
 =?us-ascii?Q?L7tcCaSgxijoCs4vuahbU1bVsjz5v0rPWM5+CU3v8KqA3LdYnIdOaM55I9Cr?=
 =?us-ascii?Q?uuSmQGLv9EmmuaV9lWSG9eMO4g9UxDOcwbfSEH49pbnK4HcNCMTF+AOn6xSH?=
 =?us-ascii?Q?hZ14kfNcn6E3Is5HXPbbBJ3/jTHTB4y+PNUEJUHIxE1nnSvqvY8pZfmv9wMm?=
 =?us-ascii?Q?xaq0sDgfMAAbYe4/xl5gfRs6jA/J3MCX9ZamDfkLqezDLbgxMLvEQors+IKV?=
 =?us-ascii?Q?t0n8OuoCGnCu/TSAa2yPVflnTeT81/m55WcEkLd7ozJ4W7Y2AL954+IimPPO?=
 =?us-ascii?Q?C+Fl9o1WuL0y602H3HP+GK2PCdqxl5HH8LJ3SBQ1qqx9gtNnTmP7llJEPESw?=
 =?us-ascii?Q?W74xsLiTHWr8Ad/Tzp4XCn6yGnnNqFneWtd+MojfpGdOD5SBhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:24.0193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376b991e-1ecc-491d-907a-08dc866bf6db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Phantom DTBCLK can be calculated different from main because phantom
has no DSC and thus will have a different output BPP. Ignore phantom
DTBCLK requirement and only consider non-phantom DTBCLK requirements.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 85eee5ab5443..2b240a30d2ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7713,7 +7713,8 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 
 	mode_lib->ms.support.DTBCLKRequiredMoreThanSupported = false;
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
-		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_hdmifrl) {
+		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_hdmifrl &&
+				!dml_is_phantom_pipe(&display_cfg->plane_descriptors[k])) {
 			mode_lib->ms.RequiredDTBCLK[k] = RequiredDTBCLK(
 				mode_lib->ms.RequiresDSC[k],
 				s->PixelClockBackEnd[k],
@@ -7728,6 +7729,13 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			if (mode_lib->ms.RequiredDTBCLK[k] > ((double)min_clk_table->max_clocks_khz.dtbclk / 1000)) {
 				mode_lib->ms.support.DTBCLKRequiredMoreThanSupported = true;
 			}
+		} else {
+			/* Phantom DTBCLK can be calculated different from main because phantom has no DSC and thus
+			 * will have a different output BPP. Ignore phantom DTBCLK requirement and only consider
+			 * non-phantom DTBCLK requirements. In map_mode_to_soc_dpm we choose the highest DTBCLK
+			 * required - by setting phantom dtbclk to 0 we ignore it.
+			 */
+			mode_lib->ms.RequiredDTBCLK[k] = 0;
 		}
 	}
 
-- 
2.34.1

