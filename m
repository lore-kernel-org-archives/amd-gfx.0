Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C02DC3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E6910E8AB;
	Thu, 25 Jul 2024 18:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qw+vsK3b";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7EF810E8AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOON405WkB0wb49bRsMKUz48p3meODQjfcmS8vwMAEMCG4mO1QZiuPDidVbXA2GnhtNfCRhL6vJra9Q0aW8cF6AM7ByL9v0Ng8i2aZ7cZi4D0UzMn1n6XGmoSi0cbyPeChDdf/W0UkRlBhianbHsJ0/oGvJB26OOjO1LqXQwnmjjJcvbuBciA8ncty38tLKX9Ytp4uwIW1Axvy18WQzRLeIRkkuNY5rKYyhEwwmWbkskJS/gabbeu+4f78b1hoVQ144d0+0rZlw7RBcnrYkMTKhqAm8MXAJevoiwJ4ena3k5Jhtps/APcXTjs4f/9q3evXAxImSD5qBFtDOp3uPXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGQ718x2Q6XlmajlftJL3EW6ICohEykdF223FtEQiNA=;
 b=VRYOU2yZ5WEdc9AU831BAo/gCRKMRWbXi0VsemisWEqYTSPJLdFgAvjj+Z8HR4RLMOzu38rnQWGHsvtN79KM5t0byIfCJ9Vpuf8gCHX7GYvyN7xIERexUyljNclctmrSdd6AL9DcqpRfwsYwkXGny0il9TYTHpaFAhtYtiD4iCGy5NNDUQHmoH3H9mfriWjrs85bPEtsgMhMiELRGpoUz5+YwkdSKK6cIRzCD+sZgC3x34O0Kfeq4TRuQ6O9UXziqVydUrjgI/7AsYXnVRTXHks/KTFQt4s9s9FQJ3tc8hIlJwo3VkaIwfp5jCQXl9v2E6/AAhFLuQSyNEMhDekoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGQ718x2Q6XlmajlftJL3EW6ICohEykdF223FtEQiNA=;
 b=Qw+vsK3bq3k+vbUpkJkO7SsnstTrVncE+jTVdFCDB0GJGkiDEfJgMRGhFlPZolMlmMJpyyF4JSWj1hRGled3bTWQVUeJiabaopl8Yva57emMdRQnjj5N9uqJ1e9ZOatmKPR8prVTbb7giauHT9Lyf/G5ZATrXO7Cr2KY3jUPouQ=
Received: from CH2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:610:4f::19)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Thu, 25 Jul 2024 18:04:06 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::c4) by CH2PR18CA0009.outlook.office365.com
 (2603:10b6:610:4f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 17/39] drm/amd/display: Avoid overflow assignment in
 link_dp_cts
Date: Thu, 25 Jul 2024 12:01:01 -0600
Message-ID: <20240725180309.105968-18-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 2580e059-a67f-451f-45d2-08dcacd42ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iFHA6WOmYjomFse5yHhMBesl21GvSRWzvbBqnCG+YDHJQ1WeaPewx/RveAWI?=
 =?us-ascii?Q?xjWg0g04Y+G0uFw3fBvMW5LYjLNF9pBM1k/Hwg49IGkl5lG4u29+bQmHjxND?=
 =?us-ascii?Q?fVQ4y0YY9jjFtziqQ/plH8v4tG74flzxpugswjiZMCKuZRUngT2Wdrg38M4Q?=
 =?us-ascii?Q?rvMLoID5z7pROdOLNuO3Ym48MNUajBuqvBBuuMPDEucCMddwrl5+I4K/tVgE?=
 =?us-ascii?Q?X5wCFWJ6YpAOeIRt2K24v+WCPLX+bJ/Fu5sZuqSSk009/3A/cZKthbr4PYnJ?=
 =?us-ascii?Q?5XRS9IKmxu54NN8kyGzAuIXP8Xy64iHjgpYaOuUUcys/xI7HaPnjxxFMfMTS?=
 =?us-ascii?Q?OQ1z6SMFd8wswUG5mgN1GtJ7SG1i9F0T66pvRt+IMaPrcwzZkpUtnRaM4tJF?=
 =?us-ascii?Q?Wzf6GiZFRHs9wMbsrosO7B+yFtw/P6+fdDf4JmAL5SRCulXvZJoqK5xrc73r?=
 =?us-ascii?Q?IaX69WtAZ8iAcyFCq8pfrNrzKopPzJiBFOZg/4L6Db7E07lYYSlIcj+ioNDJ?=
 =?us-ascii?Q?tJqMBoVxhwLEIAgU8pY0L/kcHc0ewOf/ru1DJah/0LUzvFqZrsSZJd2sJQYG?=
 =?us-ascii?Q?tuEZp0ud932Bzd6SkgptYMCfUw/tay8YkZ9NUomC/VuI5WFa5nk14a4vDOqg?=
 =?us-ascii?Q?fYlhSbshOEQxZKtAEvZ7L14xzqZspfBn1yEUnCu37srAZ2u69S2GdABVLuVI?=
 =?us-ascii?Q?zBH08qENC7xhKtqggH4uxF8//9KXwQvuKnzw/OyEW93ex4rvDTud25cxyzDF?=
 =?us-ascii?Q?tMKpeIZHDWwrDb5j98BzFdstDXGPpWrvLC3g76tV6qVYrgPuFOnhlZbPlLIr?=
 =?us-ascii?Q?40IY4Fm//4Irhy5IA/TGQn30txJgRmEbwKlOjmUejzFKi9WMuvDwJHpSZuu7?=
 =?us-ascii?Q?vnKhkggXynccUGXegHPPLIIFTstgtGMcI7fdgCBdezUB/35K+nGiRO5vgzt9?=
 =?us-ascii?Q?xn9HpyYLzYhdZ3PFX0ljl8fx8WuRyxoB6I+GLrpF7vB2Zo+UUMj1lqP3H5IY?=
 =?us-ascii?Q?u/1MLsA5rKw5s1IiFRmsEdyIE5Iq+tdfxjkV0qsS1qeiQsb3umlR6ykA/lRc?=
 =?us-ascii?Q?gpLWmMQjuHYQVWenFKJv56feESBASlAVFR0UVi2esHpHtmH5oHgWH5uZuj6k?=
 =?us-ascii?Q?Np3skhNYCl8zbfJevGGWF9axopeblOsV7gfkRHBWj+/mxA8jCmBo+E+/O0wE?=
 =?us-ascii?Q?BXZybC97enSQ/tmmUWZ7ykiiPI2vIy4xJUs8NJQCqJTLT8e/4tI75ZVLNRBe?=
 =?us-ascii?Q?JlQTJqh/7s9EcFawmnBCj13I3UaQ8vBBQ5IbzoRoQz+7g5IrTWRrATsIV9fm?=
 =?us-ascii?Q?RSeHKlkiGLm8bNg15Ssx0s+szo69nDhpIsQT/u0IjKjx+rgwyb5vd0URgIER?=
 =?us-ascii?Q?jA6SYBBKPGFTISgXgmkL9kBcuspiqJsxZAVo+G1oGYiczVge97cxwX8VCPLH?=
 =?us-ascii?Q?ARVetWZ1EPIWKsw1sA4mXFfhCx6pl6Bt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:05.8856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2580e059-a67f-451f-45d2-08dcacd42ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
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

sampling_rate is an uint8_t but is assigned an unsigned int, and thus it
can overflow. As a result, sampling_rate is changed to uint32_t.

Similarly, LINK_QUAL_PATTERN_SET has a size of 2 bits, and it should
only be assigned to a value less or equal than 4.

This fixes 2 INTEGER_OVERFLOW issues reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h                  | 2 +-
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c | 3 ++-
 drivers/gpu/drm/amd/display/include/dpcd_defs.h               | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 519c3df78ee5..95c275bf649b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -727,7 +727,7 @@ struct dp_audio_test_data_flags {
 struct dp_audio_test_data {
 
 	struct dp_audio_test_data_flags flags;
-	uint8_t sampling_rate;
+	uint32_t sampling_rate;
 	uint8_t channel_count;
 	uint8_t pattern_type;
 	uint8_t pattern_period[8];
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index df3781081da7..32d5a4b14333 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -775,7 +775,8 @@ bool dp_set_test_pattern(
 			core_link_read_dpcd(link, DP_TRAINING_PATTERN_SET,
 					    &training_pattern.raw,
 					    sizeof(training_pattern));
-			training_pattern.v1_3.LINK_QUAL_PATTERN_SET = pattern;
+			if (pattern <= PHY_TEST_PATTERN_END_DP11)
+				training_pattern.v1_3.LINK_QUAL_PATTERN_SET = pattern;
 			core_link_write_dpcd(link, DP_TRAINING_PATTERN_SET,
 					     &training_pattern.raw,
 					     sizeof(training_pattern));
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index aee5170f5fb2..c246235e4afe 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -76,6 +76,7 @@ enum dpcd_phy_test_patterns {
 	PHY_TEST_PATTERN_D10_2,
 	PHY_TEST_PATTERN_SYMBOL_ERROR,
 	PHY_TEST_PATTERN_PRBS7,
+	PHY_TEST_PATTERN_END_DP11 = PHY_TEST_PATTERN_PRBS7,
 	PHY_TEST_PATTERN_80BIT_CUSTOM,/* For DP1.2 only */
 	PHY_TEST_PATTERN_CP2520_1,
 	PHY_TEST_PATTERN_CP2520_2,
-- 
2.43.0

