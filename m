Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9121BC07E8E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F1E112BF1;
	Mon, 22 Apr 2024 15:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iAUJldJn";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 506AE112BEF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieFcRq30bQVYUwPybzHRcMVGbApbMaPw3kN03dmy710XwmCLJhlLJWrKqX0jNmA4ogVcGeayEzd1qqpX0pw83NMbT9OTUqXqEcIUXU9pGOZnMNeDjQGZ84CzljWJETd1T0nq4NYwAosbafI30PCHPrNPzi4RD0Y7ec6Pj3QtDjbnAKRyJ3aIYX0vQ0SSeZg4wfTPWkULCWa5UsIMw3BDsJ7wpl9G9oC4I949RKlC9x15+U0/1roYKhEkN3Qt4ubxouv1vgVc0z4BdxpPkHDX55IEH3BGXo6DmcFc70PuZTTSjYgAOptMd6drd1VU7A+qKFa5pbYOPmqvOmi8jMb1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoIjE2akQsFQlk/MzF1yH5gXLjAk5gP3Hy7/Fgdaj6U=;
 b=AQT6RLF97/AwGFHSyAAcniEOscEHrfxRyJ3t4nsiqlw18fFPfkte+IqD8dyvjcHZ4U6SnAF1HdI6xG4xnzT4tJrk2lp1BULvjZlSbp0TdboegFx8HOhihTF+8NkOZfa9bj1jAfBYdjHy+SJRxhD3j7RUqeE0Ke8SMGD/GEwosCW4DKouZJ2iOax4aQ7zwC3uQ71rD9LrcAdMGb4LsTM9syxwWE3G0wgHO+hm6pvttAlLl7qRmFWZ6IzGsJDxU7ubjQjaECxDwCbTl7CRtkicZEi1EmzMIguYXA+nzNwhsXvBnZrFWKyOV1AGd8pzh8qvSZX9rFasCjrI9FSv28F8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoIjE2akQsFQlk/MzF1yH5gXLjAk5gP3Hy7/Fgdaj6U=;
 b=iAUJldJnFExI/dQ7m1mkTZk+9bgp9rPbflRVNgYGIPjcf8Wsqnb2VMg12vn+0ZKZtj1F91+vssBYFkVP1cPl7DdXeaJ5AUneOY9XTTxWyz5steW/mrDQRQw9+Mi0jDnmLkgyPmTUHhT/ktfnxy8Bmk158/uZdT7vm3W8uTQlORs=
Received: from PH7P220CA0104.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::26)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:16 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::95) by PH7P220CA0104.outlook.office365.com
 (2603:10b6:510:32d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:15 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:29:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 11/37] drm/amd/display: Update comments in DC
Date: Mon, 22 Apr 2024 11:27:20 -0400
Message-ID: <20240422152817.2765349-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b881ec-7aac-4aea-e09a-08dc62e0f885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Guwke/uYfmQtajj6yV8mMD9W0i4SRAyEX5Ubez+zqAC/+q5vkajOJLgC8ejH?=
 =?us-ascii?Q?j7y8mP6UXfzeGnbX8KGGBbxdiZRn8i/VSL5ksD41zoO2jM4N8ALHXjPqXpCh?=
 =?us-ascii?Q?9V/g/eillFgzOYG8sLFmtrzBNc3SMxyxavGREcEFaMYGI6U0kgEAWY5hF+YV?=
 =?us-ascii?Q?5TCAiPkS/UaPGtN5oSHrhwpPcjnHumtsnohtxeXYQdshMfawqYrkGoeuwWqV?=
 =?us-ascii?Q?Cu8639ogtPP6CVO57rVEiEFCK7y/b95A6wvLD9GtWMdtMWTVGDEE9oOZli4y?=
 =?us-ascii?Q?PMOWGxUS807JOm7vGFwC3NH9HalIbv73Fx3Cpr/NBYYB+hiJ0IUIR2wTe9/u?=
 =?us-ascii?Q?ggPrUnAg6zYRus45BTHo+d5O87XS1I3IUUjSMOBxpt5xtV9qy/r7SxS8SaF6?=
 =?us-ascii?Q?fN1rx9rjseWQgBbBjjH04bq/iaEYQ5hWwO1y6K6mr+Z99T6jPLlMFEkFgfCO?=
 =?us-ascii?Q?XpQSAc0aRR7CTPe4W39yGbm894Ap9Y4xkzMF0dFWkIH2UJB/wjN6IMGPWvFe?=
 =?us-ascii?Q?MeP4gG+yIm+ggsfCF8YqVSjO1UlSKCcj9nC6/xvZtklfKEVfxoZTx2D6aSVT?=
 =?us-ascii?Q?e3d/mGEAwlCCmSM+H/0rHFV21J0zyRvWoC8jv//sER+CBVW6aLalsAbiMRJl?=
 =?us-ascii?Q?M8lDtcnqoHvLGri9SZO7K6sfSVwRP9HEWQa7ULXO+wkqztgAJABHUhFaY29k?=
 =?us-ascii?Q?uuUwv3NOk3kL/C6CQUhE7Jl1WYBhQCn7+ZzYMYGLflcnqZ1j6MKPPaBdELqS?=
 =?us-ascii?Q?Cu0KhrYHy33nuUuVNKlov8nCLUvUEqqSZiEaQjjH5yovoKfEkibGLRFU0I1m?=
 =?us-ascii?Q?IA+MIUkCctXD72uTALSqAk+23dZkSNUYLJrBHBVKKRbJ/GVizXIZJeR7/y+T?=
 =?us-ascii?Q?mFWIuIFVDHk9plKP+kVL9tGMdVbdogwz1zOI+DIPJuWL88dPho8MfpIugSyF?=
 =?us-ascii?Q?RIMjUXrVPKMvwJ3eMVhaQLTMDgBoLeCLQdZ6tJogxXsHrFthDRBI/fqwnoRF?=
 =?us-ascii?Q?PxTCcU3brMTRKJf4JM8Q568aDt303dZKW9nosIxJRcfipSJzoeQEUM7teZiM?=
 =?us-ascii?Q?UEnkjAQ5gaJLC2OGcQSYGNm2oJIXupZKGkHad7KPlXqnuow3jh6XjmwyMcH5?=
 =?us-ascii?Q?YYauig6M9JdXtvfGNLuvPXbtT0abvcWtPPlCimH+sg7VKVdmG4t2UvE/5KNW?=
 =?us-ascii?Q?Fio5KsABFcrxClu5y1nhVx40KbwHVw9UUTlfv+OtI4m8bldDiCX0biHcHHPH?=
 =?us-ascii?Q?p0B8Y1TLy2tl56bPmxaPY4LAR3dGWhBxHGtLUfku/Gv7Q9P6bQRy3w46neQV?=
 =?us-ascii?Q?XWVHiJANT4oTT0Pl51gihVsTKhWKvOtnokwI2rJIB75N2jfXHtfe1FzWUx+K?=
 =?us-ascii?Q?28aPeKmXs4mkvExtqHgN7gOXcvWx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:16.0862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b881ec-7aac-4aea-e09a-08dc62e0f885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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

This commit adds, updates, and removes some of the comments used in the
DC code.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h    |  2 +-
 .../gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c  | 13 ++++++++++++-
 .../amd/display/dc/gpio/dcn21/hw_translate_dcn21.c  |  2 +-
 .../amd/display/dc/resource/dcn20/dcn20_resource.c  |  1 -
 .../amd/display/dc/resource/dcn30/dcn30_resource.c  |  2 +-
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
index 63219ecd8478..1bf6b12f5663 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
@@ -29,4 +29,4 @@
 
 void dcn10_resource_construct_fp(struct dc *dc);
 
-#endif /* __DCN20_FPU_H__ */
+#endif /* __DCN10_FPU_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
index 345202fee40f..d78ab3ffd95d 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
@@ -61,6 +61,13 @@ static void dpp201_cnv_setup(
 		CNVC_BYPASS, 0,
 		FORMAT_EXPANSION_MODE, mode);
 
+	/*
+	 * hardcode default
+	 * FORMAT_CONTROL. FORMAT_CNV16				default 0: U0.16/S.1.15;	1: U1.15/ S.1.14
+	 * FORMAT_CONTROL. CNVC_BYPASS_MSB_ALIGN		default 0: disabled			1: enabled
+	 * FORMAT_CONTROL. CLAMP_POSITIVE			default 0: disabled			1: enabled
+	 * FORMAT_CONTROL. CLAMP_POSITIVE_C			default 0: disabled			1: enabled
+	 */
 	REG_UPDATE(FORMAT_CONTROL, FORMAT_CNV16, 0);
 	REG_UPDATE(FORMAT_CONTROL, CNVC_BYPASS_MSB_ALIGN, 0);
 	REG_UPDATE(FORMAT_CONTROL, CLAMP_POSITIVE, 0);
@@ -185,6 +192,7 @@ static bool dpp201_get_optimal_number_of_taps(
 		struct scaler_data *scl_data,
 		const struct scaling_taps *in_taps)
 {
+	/* Some ASICs does not support  FP16 scaling, so we reject modes require this*/
 	if (scl_data->viewport.width  != scl_data->h_active &&
 		scl_data->viewport.height != scl_data->v_active &&
 		dpp->caps->dscl_data_proc_format == DSCL_DATA_PRCESSING_FIXED_FORMAT &&
@@ -196,6 +204,7 @@ static bool dpp201_get_optimal_number_of_taps(
 		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
 		return false;
 
+	/* No support for programming ratio of 8, drop to 7.99999.. */
 	if (scl_data->ratios.horz.value == (8ll << 32))
 		scl_data->ratios.horz.value--;
 	if (scl_data->ratios.vert.value == (8ll << 32))
@@ -205,6 +214,7 @@ static bool dpp201_get_optimal_number_of_taps(
 	if (scl_data->ratios.vert_c.value == (8ll << 32))
 		scl_data->ratios.vert_c.value--;
 
+	/* Set default taps if none are provided */
 	if (in_taps->h_taps == 0) {
 		if (dc_fixpt_ceil(scl_data->ratios.horz) > 4)
 			scl_data->taps.h_taps = 8;
@@ -233,6 +243,7 @@ static bool dpp201_get_optimal_number_of_taps(
 		else
 			scl_data->taps.h_taps_c = 2;
 	} else if ((in_taps->h_taps_c % 2) != 0 && in_taps->h_taps_c != 1)
+		/* Only 1 and even h_taps_c are supported by hw */
 		scl_data->taps.h_taps_c = in_taps->h_taps_c - 1;
 	else
 		scl_data->taps.h_taps_c = in_taps->h_taps_c;
@@ -307,7 +318,7 @@ bool dpp201_construct(
 		LB_PIXEL_DEPTH_30BPP;
 
 	dpp->lb_bits_per_entry = LB_BITS_PER_ENTRY;
-	dpp->lb_memory_size = LB_TOTAL_NUMBER_OF_ENTRIES;
+	dpp->lb_memory_size = LB_TOTAL_NUMBER_OF_ENTRIES; /*0x1404*/
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
index 2840ed5c57d8..e3b11b3c1daa 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
@@ -179,7 +179,7 @@ static bool offset_to_id(
  */
 	/* UNEXPECTED */
 	default:
-/*	case REG(DC_GPIO_SYNCA_A): not exista */
+/*	case REG(DC_GPIO_SYNCA_A): not exist */
 		ASSERT_CRITICAL(false);
 		return false;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 6406d31ceefe..a8173b7880eb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2340,7 +2340,6 @@ static struct _vcs_dpi_soc_bounding_box_st *get_asic_rev_soc_bb(
 static struct _vcs_dpi_ip_params_st *get_asic_rev_ip_params(
 	uint32_t hw_internal_rev)
 {
-	/* NV14 */
 	if (ASICREV_IS_NAVI14_M(hw_internal_rev))
 		return &dcn2_0_nv14_ip;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 237e00ea3e94..d9e98abb3640 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2567,7 +2567,7 @@ static bool dcn30_resource_construct(
 		pool->base.sw_i2cs[i] = NULL;
 	}
 
-	/* Audio, Stream Encoders including DIG and virtual, MPC 3D LUTs */
+	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
 			&res_create_funcs))
 		goto create_fail;
-- 
2.44.0

