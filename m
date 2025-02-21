Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F284C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1081710EAE0;
	Fri, 21 Feb 2025 16:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dyZ/L98R";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A60310EADD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXv+hwESf++ux++8kQKGAqofQZ1v7+Vl6SnEmdQEpVOUittfoRohPeeVI4WxSAyxWTzlacqwXrtcfDrcpgEFZZAWXsDpdl4SplSKXl4f/up2oKseVU9sFeJi+is+rsTQFJtUEM1liSHjx7KSJ8wWZ0SnrIQ8Yqiesml7yWyxNMwg2q/q8U/6o20F57pnfKCB6uujyYCyzSLLpbSOiZYjx/4n2VDp/klqLDLkppfM04kn9/H1PEYt1ujq1A+upZyaEfil9jrMvirbgr3so/h1Tv05RjVICW6N2iBkQZdAi3x4NOcuDHtM1IHZQYlR7k8HAcuLjiWPXTxVQJjuEkFQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjB9yZVEv7VcvpAIR7uRIINFsKrr9P+sYKLwuV8tkEY=;
 b=pVArnsauKg61bhovVsz/G7NkQl42DPjs1OZLl/GiQhhxJZN8E2lZUndpUYOA+87fhXHsDjBxolDFVyfJCgA6wIhRAH1YKKY8xXpx6ylu6Zs02gmSp8Y5Nl2Eg12Nz6E1QchDyKWj5a9BFOQYUmVsQISzWw7RDFmx1xNzfPC8e7XEV6zkDLJAkpXqr5yEhHQwcUIpKGPX5RZ6oYo5FR+F07MkHd7lOycQsYNN5Xk2Av2dhnHR7C++PM6wErqxYxkUD3e0tW/0PxlRf7ZVOVu8uUoUHrPFvAYZXCfpb836ab60SfjIzeVmjAEel9ptibV6Unwd/ju2H58OFG1K9KZ4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjB9yZVEv7VcvpAIR7uRIINFsKrr9P+sYKLwuV8tkEY=;
 b=dyZ/L98RtFpwkOXqDzho3P1hhg5KOyOPiZRqGS5CmnVaX28dkqVLBdAwEMkQxZYAxd+7Vgu1prbWk5KSrsHwc+FHJ0qvER8b94/oBr8p4yEtmXAHpeLTKXCqwZDO8yM9Ju2BfnOS5o3QZReiPr0QEcYWNtKPFDVyDNdalSY3GT0=
Received: from PH7P220CA0060.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::29)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:02:21 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::c9) by PH7P220CA0060.outlook.office365.com
 (2603:10b6:510:32b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:20 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:10 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 08/24] drm/amd/display: fix check for identity ratio
Date: Fri, 21 Feb 2025 11:01:29 -0500
Message-ID: <20250221160145.1730752-9-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: cf92893e-f09b-40bd-ff37-08dd52911f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9nkig3T/2hp4uX3SCciZz48Lgg2F+R8b4V495VjXR1JWwIWfzKkpzWSyEkfW?=
 =?us-ascii?Q?FfsInbGvKmWQtmrZVCR7wFGXUi08s0FFUM3l3PFslLEZ0IO6gsPXrZFduME1?=
 =?us-ascii?Q?PRllfz1y8Jr3BvsmXzKS3f3XH4foBt7aNQ9tFiAouOeaSEneviNdtUBvNhfr?=
 =?us-ascii?Q?zOZBSoE//Lm9FcyHMKKHMgp7Cv90JxdkKsT/RPi4tfgB3vEBDpe9joOAYE/p?=
 =?us-ascii?Q?PoCA6XO+k3rSIW4zMOSe+CJ+vDFAPLe+Br13/MwajqJ9hPsOim1I/H8R29OT?=
 =?us-ascii?Q?6wOyPADV7+VbbMnNfbxbg9jUAe1aol3zG2PZii+2a2XWQmtbXqZ5Osm6MMqa?=
 =?us-ascii?Q?cgTXJRuftRX88BKX0ZK/FkJX+SHS5NI/fgNTMw6FoC6dbC6GAotH3EOSbPG/?=
 =?us-ascii?Q?7xNjjyiVklji2Bv0A0lb1QcJ626bTTxLs42TStCEH8VFrKEV8+nTYqafWHJR?=
 =?us-ascii?Q?HUkkyZAfz9ObMlegvC7hZgxiSSKg2Way/JdvKwvOGOOFi7ZWEX/NO8wT/BZT?=
 =?us-ascii?Q?w2VdWxLq0FmOND12pXWeQrT4r7TthZJsviEFzeCsX8MNFT/AZ+CQLF1mMGpC?=
 =?us-ascii?Q?FQ6deMIGwJSWS6rpqWwiPh38+ZJ4XC2UKev1XKVWGpTRuBoh/NrhDfhBccY2?=
 =?us-ascii?Q?LoDgaxSvFHtBpLMdUt0aw+GgPcCb+QQIEN8OSsa12V5dzsfARGiFjkFFlKL9?=
 =?us-ascii?Q?XVA/vmrqLr1wsITT66rGL27+6boBbBGrvpRwXa2O2K6x+ho/DlOvHu54q+qV?=
 =?us-ascii?Q?UoMc59ubv/imfBFCTG+zpugjmtsKBfQNm3iCK9aJQl+Wllta/CaD+wqeMG6A?=
 =?us-ascii?Q?I9HlAUNUwJxrCIzAb8pMw+PU+KqQUnZDjJ4ZP4ENwWsWLVXbX2aCgM6lQLEb?=
 =?us-ascii?Q?CSLA1YSTKx5kq3xJ8/J4PnTd5rlg2nVNEqcYqCYtbAyuCRjP0RgabaggPMeb?=
 =?us-ascii?Q?LDEnQQRkC7wfebUr6syklmh1t5IzQ91PuMnYt+IOjl2pQvTE0KSJK3OLR1pO?=
 =?us-ascii?Q?XULZZKB40lGdpHzyVU3ys+IXkeJYX6ExOX2J1aqBij/zTAC3gzEl5TmWJSFv?=
 =?us-ascii?Q?ghb9jo/Pa3Dv5NRL+MCl1V7ExHDnSnAstLyciIe1fJ6pmcV6KrjFi7OD9Eaw?=
 =?us-ascii?Q?2fASowt2EcZsC5a3/zUW5htxORxZbhFxk9EwHvfORm/G+mlOkhonRUC6a4HE?=
 =?us-ascii?Q?2b1ovyg3dpPoGzyYxwbakr+kZPef38YO+nqG/rnroYPQxEv78qdKbkSrDwGM?=
 =?us-ascii?Q?190Ftd+U7lWpJTYT89oGYiMZep3x3rqjICcaMe1I/oUiscH1ASmiTFLkGLVf?=
 =?us-ascii?Q?Xt5vHqfHsQwXCSTOmCM2S+YQiLD7Jikdj8u98nXd2qzHDXdlIMFSrBgIsAak?=
 =?us-ascii?Q?RiV5V+AxEA7G+8tPIZXdmianKycWBbXPvbAWckOIMmKGTs1jFwero1ExSaO7?=
 =?us-ascii?Q?SVots9Ju0Gtu54geWAJi++NjOWUvslg5FoUgds02BQShzFrutAx6Jk7BDR4I?=
 =?us-ascii?Q?3JK0mz3m3AsQggg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:20.7395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf92893e-f09b-40bd-ff37-08dd52911f83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
IDENTITY_RATIO check uses 2 bits for integer, which only allows
 checking downscale ratios up to 3.  But we support up to 6x
 downscale

[How]
Update IDENTITY_RATIO to check 3 bits for integer
Add ASSERT to catch if we downscale more than 6x

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 21 +++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 3d85732cc0f5..047f05ab0181 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -8,7 +8,7 @@
 #include "dc_spl_isharp_filters.h"
 #include "spl_debug.h"
 
-#define IDENTITY_RATIO(ratio) (spl_fixpt_u2d19(ratio) == (1 << 19))
+#define IDENTITY_RATIO(ratio) (spl_fixpt_u3d19(ratio) == (1 << 19))
 #define MIN_VIEWPORT_SIZE 12
 
 static bool spl_is_yuv420(enum spl_pixel_format format)
@@ -887,6 +887,8 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 static void spl_get_taps_non_adaptive_scaler(
 	  struct spl_scratch *spl_scratch, const struct spl_taps *in_taps)
 {
+	bool check_max_downscale = false;
+
 	if (in_taps->h_taps == 0) {
 		if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz) > 1)
 			spl_scratch->scl_data.taps.h_taps = spl_min(2 * spl_fixpt_ceil(
@@ -926,6 +928,23 @@ static void spl_get_taps_non_adaptive_scaler(
 	else
 		spl_scratch->scl_data.taps.h_taps_c = in_taps->h_taps_c;
 
+
+	/*
+	 * Max downscale supported is 6.0x.  Add ASSERT to catch if go beyond that
+	 */
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz_c,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert_c,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+
 	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz))
 		spl_scratch->scl_data.taps.h_taps = 1;
 	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert))
-- 
2.34.1

