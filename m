Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B05E936E6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2644810E3BB;
	Wed,  4 Oct 2023 21:21:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AABE10E3BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHO2E3SudC38o/GJA6p2uQccWSD1r+u1Yl5F5aU/9+wGG8AAR6L4cAl5s/B9LQfNCw1p9gPI9bvVcLferkBWyGqaKBegSxw8uR6ZHt/od9IWxY6bMrtd8lP8QxMEN6bGRtmSsgllKWGmX1QrXLbI/rX2KZAWwGqDtgInAskgktvV6lcaw7ElW4ZPSS8fcQLgDl1Cv1Vkpspifn2/qk1X38bdc2F5jhHrOQVhq01jypcFDRti5Oq5Vm5ji6jcKLm2YbZsDu8P99DadZu1PeSJmHk501Y+FZPjWwVPZBbgSGr5mCoJJ34QXpy7CPjDHkkApT5RqygEU5+k9vIpz3zY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwD4cfKHkWMAkXMUsdsBfR/hGkJLu5QxS66mL7/AMO8=;
 b=S4mnd/08wW1Qo7idYk29y3d2gf67O3UCFV2jywOBTkoNGkPXD7xpiwFPy+4ZJDhqWpKyravRqVGF9TBg+lptP+S5qAEcpmA1BBsJCYnF1PI2lq1bCI2wX3LMXeskvYh+adQdamtz7kOu2NAlGEcNHCMOitMhipuyeCFZIvUeuIQR8cAUYke5Rw24XmSpmAmyQLoD+64Ccev5pZfQ+x9PqW3XhcaGQUYPzbTP4941g4rz5AN6z1SAXwqCUMnyMabHSwuDrypqY5pbTaY41OFLeAJiosIj0a4T3Q1OGzxvhObufYGNP4N8k19FtStyWWwdeYtKlr4ZT0RIKMPgS4KZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwD4cfKHkWMAkXMUsdsBfR/hGkJLu5QxS66mL7/AMO8=;
 b=IVTF/6p/V2tTkuHD0vsmqoAnfStKOFcEuGlgnLNvkEA9ogpkfB8TkuKQouipkQoh8fdFJ11xs4N1LuEJzvyEBaxjmO/NHBm0wCdU1+K3YCgjH4xD4kjHLROXporx04tUp5zq4NqukwIUczS3CuK3kTGZFmIS77oViN7ErBAJlnk=
Received: from MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 4 Oct
 2023 21:21:39 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::70) by MN2PR11CA0009.outlook.office365.com
 (2603:10b6:208:23b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:21:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 02/16] drm/amd/display: Move custom_float outside DML
Date: Wed, 4 Oct 2023 15:20:56 -0600
Message-ID: <20231004212110.3753955-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 221dc5b9-14bf-43c1-749a-08dbc51fe600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBtaOwc5mhv4SsPCu6FDyt+IHhMFCQAU/v+lRLflUTVYict+rAA7e41IDTXm4nFMLuV7EcfB1yHeJ/pe0yitehy2sUC3qg61zpN3SH6vMfAYPLc6P2JSTJuZ6NpVCVa3PV1m/6nXdSaWh+i69mNi+07VI+nmgAAiBXxpye6NI0SSDMprImywR59Q3gZia/GCFyBRRH6FA3hyQE10uDFCRHKnbxeo0Zfbccirls7yHAuhKrMw8ru9UMf1UuK7+6AYqE9j2xQfvfZpoh99sl8BhQM7yGDqt+5PKJz9K6XFXdWZvOGrbiq4OMI2WRBxp7w+P8jIqbMPJiVDxgcZY1Wn1I4ynhCHd5p7rvt7mJ3mIUdNXsXUaaLgU41lbhOWFPmtAqk9PwItBhGOdafmf3dXT9KgXJTh67JH6jBUnlkS5FjrWZOENNJN1Lfs0WTvbQ2ylUKW9X4V3R07o7A3BiG0gU+cHkJT3p6J6UubxtjmPKLaq7x2ZSJzQJgqKZmoYhkKS8fDFXk1Xm30ez/6HCDums+McRgEv0sI7o8Zm2Gal9+hyK5TvItY904QL3CKvecrZn6cKtDNrjahRV0m3kdgVGEgjDGyXJnwdOvnqaQ8XFluQTks7sDx2fbxIblFYizQMjMGzG1Gi8t3W0eiCV+yC4xHDAsT8byUgcvqJhbGMpW72BzNbziM67IJKFRs+2vTgjVf15taSzB7Iqdn7rGFYXFxdaOcCFn3PuuvGfHg6c+zNv/bKLgL9jttU/SMZSkbZkfLbpo6WdK/WQKQ2BC0cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(47076005)(6666004)(478600001)(83380400001)(36860700001)(2616005)(16526019)(82740400003)(40460700003)(26005)(336012)(356005)(81166007)(86362001)(40480700001)(426003)(70206006)(316002)(2906002)(1076003)(54906003)(6916009)(5660300002)(36756003)(8936002)(41300700001)(70586007)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:21:39.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 221dc5b9-14bf-43c1-749a-08dbc51fe600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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
Cc: Sunpeng.Li@amd.com, richard.gong@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The custom_float file does not have any FPU operation, so it should be
inside DML. This commit moves the file to the basic folder.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/basics/Makefile    |  3 +-
 .../dc/{dml/calcs => basics}/custom_float.c   | 90 +++++++------------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |  2 +-
 3 files changed, 36 insertions(+), 59 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{dml/calcs => basics}/custom_float.c (66%)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/Makefile b/drivers/gpu/drm/amd/display/dc/basics/Makefile
index ee611b03dc48..65d713aff407 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/basics/Makefile
@@ -29,7 +29,8 @@ BASICS := \
 	fixpt31_32.o \
 	vector.o \
 	dc_common.o \
-	dce_calcs.o
+	dce_calcs.o \
+	custom_float.o
 
 AMD_DAL_BASICS = $(addprefix $(AMDDALPATH)/dc/basics/,$(BASICS))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c b/drivers/gpu/drm/amd/display/dc/basics/custom_float.c
similarity index 66%
rename from drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
rename to drivers/gpu/drm/amd/display/dc/basics/custom_float.c
index 31d167bc548f..ae05ded9a7f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/custom_float.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2017 Advanced Micro Devices, Inc.
+ * Copyright 2023 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -25,52 +26,41 @@
 #include "dm_services.h"
 #include "custom_float.h"
 
-
-static bool build_custom_float(
-	struct fixed31_32 value,
-	const struct custom_float_format *format,
-	bool *negative,
-	uint32_t *mantissa,
-	uint32_t *exponenta)
+static bool build_custom_float(struct fixed31_32 value,
+			       const struct custom_float_format *format,
+			       bool *negative,
+			       uint32_t *mantissa,
+			       uint32_t *exponenta)
 {
 	uint32_t exp_offset = (1 << (format->exponenta_bits - 1)) - 1;
 
 	const struct fixed31_32 mantissa_constant_plus_max_fraction =
-		dc_fixpt_from_fraction(
-			(1LL << (format->mantissa_bits + 1)) - 1,
-			1LL << format->mantissa_bits);
+		dc_fixpt_from_fraction((1LL << (format->mantissa_bits + 1)) - 1,
+				       1LL << format->mantissa_bits);
 
 	struct fixed31_32 mantiss;
 
-	if (dc_fixpt_eq(
-		value,
-		dc_fixpt_zero)) {
+	if (dc_fixpt_eq(value, dc_fixpt_zero)) {
 		*negative = false;
 		*mantissa = 0;
 		*exponenta = 0;
 		return true;
 	}
 
-	if (dc_fixpt_lt(
-		value,
-		dc_fixpt_zero)) {
+	if (dc_fixpt_lt(value, dc_fixpt_zero)) {
 		*negative = format->sign;
 		value = dc_fixpt_neg(value);
 	} else {
 		*negative = false;
 	}
 
-	if (dc_fixpt_lt(
-		value,
-		dc_fixpt_one)) {
+	if (dc_fixpt_lt(value, dc_fixpt_one)) {
 		uint32_t i = 1;
 
 		do {
 			value = dc_fixpt_shl(value, 1);
 			++i;
-		} while (dc_fixpt_lt(
-			value,
-			dc_fixpt_one));
+		} while (dc_fixpt_lt(value, dc_fixpt_one));
 
 		--i;
 
@@ -81,54 +71,40 @@ static bool build_custom_float(
 		}
 
 		*exponenta = exp_offset - i;
-	} else if (dc_fixpt_le(
-		mantissa_constant_plus_max_fraction,
-		value)) {
+	} else if (dc_fixpt_le(mantissa_constant_plus_max_fraction, value)) {
 		uint32_t i = 1;
 
 		do {
 			value = dc_fixpt_shr(value, 1);
 			++i;
-		} while (dc_fixpt_lt(
-			mantissa_constant_plus_max_fraction,
-			value));
+		} while (dc_fixpt_lt(mantissa_constant_plus_max_fraction, value));
 
 		*exponenta = exp_offset + i - 1;
 	} else {
 		*exponenta = exp_offset;
 	}
 
-	mantiss = dc_fixpt_sub(
-		value,
-		dc_fixpt_one);
+	mantiss = dc_fixpt_sub(value, dc_fixpt_one);
 
-	if (dc_fixpt_lt(
-			mantiss,
-			dc_fixpt_zero) ||
-		dc_fixpt_lt(
-			dc_fixpt_one,
-			mantiss))
+	if (dc_fixpt_lt(mantiss, dc_fixpt_zero) ||
+	    dc_fixpt_lt(dc_fixpt_one, mantiss))
 		mantiss = dc_fixpt_zero;
 	else
-		mantiss = dc_fixpt_shl(
-			mantiss,
-			format->mantissa_bits);
+		mantiss = dc_fixpt_shl(mantiss, format->mantissa_bits);
 
 	*mantissa = dc_fixpt_floor(mantiss);
 
 	return true;
 }
 
-static bool setup_custom_float(
-	const struct custom_float_format *format,
-	bool negative,
-	uint32_t mantissa,
-	uint32_t exponenta,
-	uint32_t *result)
+static bool setup_custom_float(const struct custom_float_format *format,
+			       bool negative,
+			       uint32_t mantissa,
+			       uint32_t exponenta,
+			       uint32_t *result)
 {
 	uint32_t i = 0;
 	uint32_t j = 0;
-
 	uint32_t value = 0;
 
 	/* verification code:
@@ -179,19 +155,19 @@ static bool setup_custom_float(
 	return true;
 }
 
-bool convert_to_custom_float_format(
-	struct fixed31_32 value,
-	const struct custom_float_format *format,
-	uint32_t *result)
+bool convert_to_custom_float_format(struct fixed31_32 value,
+				    const struct custom_float_format *format,
+				    uint32_t *result)
 {
 	uint32_t mantissa;
 	uint32_t exponenta;
 	bool negative;
 
-	return build_custom_float(
-		value, format, &negative, &mantissa, &exponenta) &&
-	setup_custom_float(
-		format, negative, mantissa, exponenta, result);
+	return build_custom_float(value, format, &negative, &mantissa, &exponenta) &&
+				  setup_custom_float(format,
+						     negative,
+						     mantissa,
+						     exponenta,
+						     result);
 }
 
-
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 8621dfe9a68c..2fe8588a070a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -134,7 +134,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
 
-DML = calcs/custom_float.o calcs/bw_fixed.o
+DML = calcs/bw_fixed.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
 DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
-- 
2.40.1

