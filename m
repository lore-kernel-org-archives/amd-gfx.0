Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562CBC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B87A10E8B8;
	Thu, 25 Jul 2024 18:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="txOMv/i2";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D5210E8B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnPLWwQvEijEfaMIcNEeP3ESUEWiF9Gvt0A3e7klQhauRTlJcRaAVBsOOXQBOHuBZqXaFIOvjpdzP/k0ov79o+Y1Ea+WNZ+cataLgKjszoSVg1/gYrWbZMOsVs36kOUyu/BXq3f0RW1SHXCOQ5f6T76ZM8+70XfztrGthsr9nuFnT9K+vtShNag2WbPCTRRDbpfl4KmivR6AkJIpbsb5e5hQCvB1SaRnlNNLu8K9d+RS46vArEYtRClAeEEF+cG//aBp/5QHhkeit33R/ZerPwX+Thar9DyefsbFFynAtynJZN4uDiz7RXfYwU9BbebQfByZ3d8QcOpQFmTnLvLXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWxuHUO8pGurdRbG0SjRyM0hKkizU+sDowN0yuJSFnY=;
 b=KAIqJiKKiYgl46e6BSOZiAR5Vg4MOVEfELX54RuwO0WJ/3btlpQCHleqxWSCUoSaHrJy2373CFH9RmbWfsopTMqRJLlG2Kq7pXdqViOgNoqDDeGzO8LjkgcCMMFno889tCT8nwfoVq3q2k3i5WQ0kAMxCqTyv4bFM/ORqRZ11/p53Dt6653BroQzdDLxCKDZ1nzLeqF5tCNE7tPStP/5zlRSvZELfR/Mjdy6myFOwUxlHSDPQ70MdHl9vwM2oX5+m+U5JVrOI/x9JyNXEf4pMc3XDpIuLfJ6AV7YDu0KmgMAEzjlZy5oNM/kgfGrjf7TmId64+9iSQI1V4jkkpEwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWxuHUO8pGurdRbG0SjRyM0hKkizU+sDowN0yuJSFnY=;
 b=txOMv/i2Q9Onlw5ovUeFEmodO3/7koQn8CgwS5wSNAaVTBsghkZUc4Ehh3F3cbae6wgEQqcNjuyU/fSWAqtnzJ5TbK4u9PIhtUU1seghUmS6/PuzyyTpWu8hQ/6iqxZwNXvXvqGifCIPQpq8gCYCl2K/7GZsWIgEGXUMQ2QEV+I=
Received: from CH0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:610:e4::27)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 18:04:25 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::f0) by CH0PR03CA0202.outlook.office365.com
 (2603:10b6:610:e4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:23 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:19 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 26/39] drm/amd/display: Check UnboundedRequestEnabled's value
Date: Thu, 25 Jul 2024 12:01:10 -0600
Message-ID: <20240725180309.105968-27-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da2b056-6afd-4c4b-8c72-08dcacd436e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g1iDCQ83ceUvnTkOPlQQjMhHhY3cDl9SMWchQI4w6bqYfuXlzgwNZ+3F8TL3?=
 =?us-ascii?Q?tKrqEYz5DzlDr+7sC+n44CqO7aiin2vRdFuXgeutFiFcFFfRVuBiNVpcSkQm?=
 =?us-ascii?Q?U1Z38dLNM4IP9t5c7UPE3KyF7Nn9k5eR/1+KXpf7Jcp5etLRpbVvB/L6e/Cn?=
 =?us-ascii?Q?5epwrqDEdQmVmQqRJkvCNMwbKBSpHSnLZylOZSS+5m6QVXGvZ2ArEDMwC712?=
 =?us-ascii?Q?vLAl1MAIcGijcWjEagBoNK9sw5ReFwVc/af05Fy1GR8lKaliCU42T5PhvRQP?=
 =?us-ascii?Q?l6XVA3mZJ23ODakxrFXVCgNlUc47MtM9uKjlr8PBQkz9Vv2kEV8WIxbiCENt?=
 =?us-ascii?Q?85kTo6CTJctpxECS06syEMTmgDv6C87WoSJjqnke0PUK+2+UPpnSL1FhSu5f?=
 =?us-ascii?Q?gfQMLNyq0IJML4f8/T3iAggRTHUNPz7befM7hKCgVdVlFbIKG2HNU+F3lZ+Z?=
 =?us-ascii?Q?JaiJk62zzJMcZwfFGLdrfc1wPiDcD5tc7dLPnEzr814baa9vl/SKOnDIafDu?=
 =?us-ascii?Q?apfuk3i771WpulpjxaSzZOeWKqhA56D7SgNnCCfHXIoFzqoBelkZEoJUTm3T?=
 =?us-ascii?Q?A93PbuEXxDFPJ6OSvbbw6fqz9p/vq96Xe7dD2D9kXcZHkigu5JfU85xc/is3?=
 =?us-ascii?Q?84TxrlKzvUcQxYAp/rzmBgBlKA2rLDFuo7YZ6X31lHzMNtgZ9v/S9J3dsuGe?=
 =?us-ascii?Q?D8SiForCGY3huBPEoXPgMj8SBJKOqDSWE/9h5Db2DklasaHtbtio+Ct4atj7?=
 =?us-ascii?Q?Av/S8hozTfwiMFkUAcWNTwGRsnkexoAuVUp65s0llvUUV3oUh7VL18fSHeTJ?=
 =?us-ascii?Q?KbojYASMgQNtHYdsjsklLRNeiQn/S/6i6oXXzPJFLbvmvfhaHJ0URPNH021a?=
 =?us-ascii?Q?lRgtneysQSbxr2Z8kCJu4mMZbRIl1mlV85KMwVmZyZZL2keV9SpqkuskIB2j?=
 =?us-ascii?Q?1NFMYReDstMnF1FO+fy8VeIkwCxBdcEqV0ONH1tDRAA33LCvfYWdZOWJB9SF?=
 =?us-ascii?Q?rI3Bzv1EAGwkMzTwhftc6XYqo6RJjS90S3+I+faWGfNg8YMpVZrFbpGYQHkq?=
 =?us-ascii?Q?3l5E6sUABG215C+vcW9JiVTzFMYizJkBr5Vo4gOlf6zGhJ7XSgWcg4Mm5r6T?=
 =?us-ascii?Q?ULd3P3WI3pTX6ajjtlTRohsEbQMylM/9fOkJ89NIIMAW5BGvQdOiNFbyyhrx?=
 =?us-ascii?Q?sS6WPwmc5qhH2FJKQYHUf/ei9oe5u7toDF/ya6qL968GsZXhwfR5whxMBCg6?=
 =?us-ascii?Q?r9XEhgFtuYgDUmK4qaMtlkPXhp5O3DLhI2d1pajHg2vVIcoFmL5i7t+vCmxR?=
 =?us-ascii?Q?0UMt2Je9aSFqN0d2ZqE8uEZmSfom7yBTNVqvOs0OSJBlErh2JPpcf/GEIdQ9?=
 =?us-ascii?Q?paML0i1QX5lsZ0hHbASjU7mcevFiZ2F8aF9k22eqGYTqZ03f3Ra7Gz5UJ65K?=
 =?us-ascii?Q?0D7qQa9oilfx9Yr9L3jch3Xq/d2JnOUb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:23.1012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da2b056-6afd-4c4b-8c72-08dcacd436e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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

From: Alex Hung <alex.hung@amd.com>

CalculateSwathAndDETConfiguration_params_st's UnboundedRequestEnabled is
a pointer (i.e. dml_bool_t *UnboundedRequestEnabled), and thus
p->UnboundedRequestEnabled checks its address, not bool value.

To check value, *p->UnboundedRequestEnabled is used instead.

This fixes 1 REVERSE_INULL issue reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 5ba38d51382f..df0911aa251d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -3851,7 +3851,7 @@ static void CalculateSwathAndDETConfiguration(struct dml2_core_internal_scratch
 
 	*p->hw_debug5 = false;
 	for (unsigned int k = 0; k < p->NumberOfActiveSurfaces; ++k) {
-		if (!(p->mrq_present) && (!p->UnboundedRequestEnabled) && (TotalActiveDPP == 1)
+		if (!(p->mrq_present) && (!(*p->UnboundedRequestEnabled)) && (TotalActiveDPP == 1)
 			&& p->display_cfg->plane_descriptors[k].surface.dcc.enable
 			&& ((p->rob_buffer_size_kbytes * 1024 * (p->mrq_present ? MAXIMUMCOMPRESSION : 1)
 				+ *p->CompressedBufferSizeInkByte * MAXIMUMCOMPRESSION * 1024) > TTUFIFODEPTH * (RoundedUpSwathSizeBytesY[k] + RoundedUpSwathSizeBytesC[k])))
-- 
2.43.0

