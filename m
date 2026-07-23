Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C202C531FA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12DB10F1E8;
	Thu, 23 Jul 2026 20:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQ3vUvmu";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A90D10F1DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/zeE3uxQxQlkyJe6TsjCXHS6M4C7S9PmJhzdr5TSsHEn7Wz2PThm/1XYPZYTWb+quAe5mPv/oqkZpnzOjy0I0pdTIq+laWqZ4TqpShf2h53xCu4g+SbJiu3iWOQWD4fUAmeK9yOnTE4CF2tmv6t9P7pejKJAUCvZneBWuj+3+ESEJRYd2V8lkNySZK4uCJCFTlsgpU3UMOQVupr1R8kADrtebsMl/GzIAFGkHH2r7904yPzFKH7LeCfx0/pL0enw1Ms2Nlthw2ZSi7vPw7vZI062cI9ECXY6V7jzUHKuYAyh5Yt9gIrEw+70dOVpbSBNn8xzDiKkceyJxwEj0Ya2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVCQMgeVxHpGLJnnozfBdY/Nq7ZEnQPg9UTOPUXEkhc=;
 b=DwbgG8tFYxoq1nj4kQDjJ+oEsu8BWyvbpV8T04c5zA5GnAJuchXgDXZfmZOF23x1YzP+F6jtk4lG7yzHipPL98xwyxPAy02OX+yFmSRJZQ6y0w0KWF/KYpTXpVj+m7XJg7s9fhtlzhR4Pg3KlL9Bzrb+SQW9m0QArK1Eev1uH4jXWq9xK0/SuF7Yo8pMCIB28G9CGc8yDMP3HMHvpbDfeFUi5UtXY4+Gn/ct7gf0cjsMXad+1Xq+nqZgtbS3jKS9bEgMV53uLWacmoSPvC6CdQA4fA57at1A/FpvNHV2HRqEVOXlh4MJHEY97nurpTDev+1u/jiLRP36O8mzrZSZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVCQMgeVxHpGLJnnozfBdY/Nq7ZEnQPg9UTOPUXEkhc=;
 b=BQ3vUvmum7N5y+eBVjwKbVQkFUJyUXVlahYw6MB5kpBR+laavFG9XoW0dscbW0wIwSH9KZIUWQtvqcj4btX5YTRI2gM7ULnJcpgwtbUIaPy/2fDIKCfYK5zQsNDsmHEYt0cLgOXJeTrmFM+9UtGgMoOzx7AkJJNblc9kVbWy/Pc=
Received: from BN1PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:e1::8)
 by SAWPR12MB999293.namprd12.prod.outlook.com (2603:10b6:806:560::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:34 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::28) by BN1PR12CA0003.outlook.office365.com
 (2603:10b6:408:e1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:33 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:15 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Clay King <clayking@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 36/49] drm/amd/display: adjust floating point format for gamut
 remap when needed
Date: Thu, 23 Jul 2026 16:13:44 -0400
Message-ID: <20260723201908.373300-37-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SAWPR12MB999293:EE_
X-MS-Office365-Filtering-Correlation-Id: 8283b596-9080-4f9d-f276-08dee8f7b5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: or8aShXWv4FIEN8fXQZg/lwoKeiy1QrqzYwMOEBFPC0YauwSy4NAvEHgT8GFnhERS7J2cHCmzbmOZG5ujZxTwVZPGzBX9IIPDTvs6ZCJUnaTRyRBFhNMNzGTbSoYfTDVcw+N3ajltF2E8JFROJTJRUONeJxNT/+PZ6OHFwUudDD9HS0ZRNzfzSmnv1FR9aQXgypVoP3BzGdOU+EAp+y87I7PFQhGr13XhGIguTXOana+Q8B5SyjNJM9tSxPsWRdcARMayhglI5WLRqTgBp5cXZx+sTbTlRfzOXB3c1qIAbI9LH77Tme5WGe4YD+KsdnakjVSTey4jyN3m8dmGx37pNe1CuHWBwWdgOKZGE1D1LkNKR5jj65130bn3pFRXK+EtHVksHvGjRp6tmgtXhs5ofujaf+Hd+JyF9GOQ4xevSBemxvhFUb2HqDu9EFs2yp0zLor3ysbvbSrbFKfSqzk3EwYlutQoqwF6Pe8NzxygXgBiIjQXJstIwAGjdj6zbT4YI9WQGPKNp3klCqp6PTWN0T5AhHskaHAVNiX5tKKIfX9Adn9gCB9gVEDrcc8DzrZ2R3vv8Ff70kpLNYM2PX4EBAaGSTuSMA9PlNC3vEgejO8FZyYfD8fiz05QxEenRUu3s9WF3vI55X1sLBwXZvYk/EIKPNu7SaRXzolNvEYGEZvvCIJpECKdzz7kdMN+DJUfwUlkZX0+N+weAIQZFDLxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3qe0lIqJ//3wGFpVjRygNsY3Im+hZ/2TuLmr0hvMsEQk66s6EIJ/hsBHLVX+sgZLYXMWeOMgQCnK2sUAfvW/zIAnvIenUM8vZZ2NNhZKqw4dUaCJHT7CZT4xJTpjvg8kVccvJYqvwpddyI8jHiK0ebPDEHuvDDN5wpPLKiFaKd8gs5P9AYPgK8gjWD85f4euhciFVKXK4iUX4f2x8PSCBT2DN4Vz7teqqO8drqwKF3JpICbz//JnUqfYZR6xbgDjv9lkoVFfz+OOFsSoWCjXX3ZpSIUf+hvODuz9DBOi5r3LCVncCD6agp0MfIRKeXFejVWoHwWdABajMRoju3qH1lyS7CPiiJY8YchOyBooE3nk7hT3TjKDeqqVM90Kgs3uD7HO0jNeX+XM/C5qgIVyFAnhOKm8g6fhsJ5YIXL64GfwHquZO4valC8UkprXkp5B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:33.7817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8283b596-9080-4f9d-f276-08dee8f7b5d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999293
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

From: Clay King <clayking@amd.com>

[Why]
The MPCCs different gamut remap matrices allow for S2D13 and S3D12 floating
point formats, but only S2D13 is used. There may be cases where more
integer bits are required.

[How]
Switch to S3D12 if any entries in the remap matrix cannot fit in S2D13.
Otherwise, prefer the extra precision of S2D13. Communicate the max value
that hw can support to dm via dc color caps.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/basics/conversion.c    | 61 +++++++++++-----
 .../drm/amd/display/dc/basics/conversion.h    | 12 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dce/dce_transform.c    |  4 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |  8 +--
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   |  8 +--
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |  8 +--
 .../amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c   |  3 +-
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  | 44 ++++++++----
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    | 69 +++++++++++++------
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  6 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  2 +
 .../dc/resource/dcn301/dcn301_resource.c      |  2 +
 .../dc/resource/dcn302/dcn302_resource.c      |  2 +
 .../dc/resource/dcn303/dcn303_resource.c      |  2 +
 .../dc/resource/dcn31/dcn31_resource.c        |  2 +
 .../dc/resource/dcn314/dcn314_resource.c      |  2 +
 .../dc/resource/dcn315/dcn315_resource.c      |  2 +
 .../dc/resource/dcn316/dcn316_resource.c      |  2 +
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +
 .../dc/resource/dcn351/dcn351_resource.c      |  2 +
 .../dc/resource/dcn36/dcn36_resource.c        |  2 +
 .../dc/resource/dcn401/dcn401_resource.c      |  2 +
 .../dc/resource/dcn42/dcn42_resource.c        |  2 +
 .../dc/resource/dcn42b/dcn42b_resource.c      |  2 +
 27 files changed, 186 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
index a1f2350388e2..1c8d4907245a 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
@@ -26,11 +26,7 @@
 #include "dm_services.h"
 #include "basics/conversion.h"
 
-#define DIVIDER 10000
 
-/* S2D13 value in [-3.00...0.9999] */
-#define S2D13_MIN (-3 * DIVIDER)
-#define S2D13_MAX (3 * DIVIDER)
 
 uint16_t fixed_point_to_int_frac(
 	struct fixed31_32 arg,
@@ -74,28 +70,44 @@ uint16_t fixed_point_to_int_frac(
 	return result;
 }
 /*
- * convert_float_matrix - This converts a double into HW register spec defined format S2D13.
+ * convert_float_matrix - This converts a double into HW register spec defined format S2D13 / S3D12.
  */
 void convert_float_matrix(
 	uint16_t *matrix,
-	struct fixed31_32 *flt,
+	const struct fixed31_32 *flt,
+	enum cm_gamut_coef_format format,
 	uint32_t buffer_size)
 {
-	const struct fixed31_32 min_2_13 =
-		dc_fixpt_from_fraction(S2D13_MIN, DIVIDER);
-	const struct fixed31_32 max_2_13 =
-		dc_fixpt_from_fraction(S2D13_MAX, DIVIDER);
+	struct fixed31_32 min;
+	struct fixed31_32 max;
+	uint8_t num_int_bits;
+	uint8_t num_dec_bits;
 	uint32_t i;
 
+	if (format == CM_GAMUT_REMAP_COEF_FORMAT_S2_13) {
+		min = dc_fixpt_from_fraction(S2D13_MIN, DIVIDER);
+		max = dc_fixpt_from_fraction(S2D13_MAX, DIVIDER);
+		num_int_bits = 2;
+		num_dec_bits = 13;
+	} else if (format == CM_GAMUT_REMAP_COEF_FORMAT_S3_12) {
+		min = dc_fixpt_from_fraction(S3D12_MIN, DIVIDER);
+		max = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
+		num_int_bits = 3;
+		num_dec_bits = 12;
+	} else {
+		ASSERT(false);
+		return;
+	}
+
 	for (i = 0; i < buffer_size; ++i) {
 		uint32_t reg_value =
 				fixed_point_to_int_frac(
 					dc_fixpt_clamp(
 						flt[i],
-						min_2_13,
-						max_2_13),
-						2,
-						13);
+						min,
+						max),
+						num_int_bits,
+						num_dec_bits);
 
 		matrix[i] = (uint16_t)reg_value;
 	}
@@ -129,10 +141,27 @@ static struct fixed31_32 int_frac_to_fixed_point(uint16_t arg,
  */
 void convert_hw_matrix(struct fixed31_32 *matrix,
 		       uint16_t *reg,
+			   enum cm_gamut_coef_format format,
 		       uint32_t buffer_size)
 {
-	for (uint32_t i = 0; i < buffer_size; ++i)
-		matrix[i] = int_frac_to_fixed_point(reg[i], 2, 13);
+	uint8_t num_int_bits;
+	uint8_t num_dec_bits;
+	uint32_t i;
+
+	if (format == CM_GAMUT_REMAP_COEF_FORMAT_S2_13) {
+		num_int_bits = 2;
+		num_dec_bits = 13;
+	} else if (format == CM_GAMUT_REMAP_COEF_FORMAT_S3_12) {
+		num_int_bits = 3;
+		num_dec_bits = 12;
+	} else {
+		ASSERT(false);
+		return;
+	}
+
+	for (i = 0; i < buffer_size; ++i)
+		matrix[i] = int_frac_to_fixed_point(reg[i],
+							num_int_bits, num_dec_bits);
 }
 
 static uint32_t find_gcd(uint32_t a, uint32_t b)
diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.h b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
index a433cef78496..c7bed2539fa8 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.h
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
@@ -28,6 +28,14 @@
 
 #include "include/fixed31_32.h"
 
+#define DIVIDER 10000
+
+#define S2D13_MIN (-4 * DIVIDER)
+#define S2D13_MAX (39999)
+
+#define S3D12_MIN (-8 * DIVIDER)
+#define S3D12_MAX (79998)
+
 uint16_t fixed_point_to_int_frac(
 	struct fixed31_32 arg,
 	uint8_t integer_bits,
@@ -35,7 +43,8 @@ uint16_t fixed_point_to_int_frac(
 
 void convert_float_matrix(
 	uint16_t *matrix,
-	struct fixed31_32 *flt,
+	const struct fixed31_32 *flt,
+	enum cm_gamut_coef_format format,
 	uint32_t buffer_size);
 
 void reduce_fraction(uint32_t num, uint32_t den,
@@ -43,6 +52,7 @@ void reduce_fraction(uint32_t num, uint32_t den,
 
 void convert_hw_matrix(struct fixed31_32 *matrix,
 		       uint16_t *reg,
+			   enum cm_gamut_coef_format format,
 		       uint32_t buffer_size);
 
 static inline unsigned int log_2(unsigned int num)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 75c06a1752b5..07ebd98f0d3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -315,6 +315,7 @@ struct mpc_color_caps {
 	struct lut3d_caps mcm_3d_lut_caps;
 	struct lut3d_caps rmcm_3d_lut_caps;
 	bool preblend;
+	struct fixed31_32 max_gamut_remap_coeff;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 12c85c3afd6a..864491bfd7f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -1145,8 +1145,8 @@ static void dce_transform_set_gamut_remap(
 		for (i = 0; i < GAMUT_MATRIX_SIZE; i++)
 			arr_matrix[i] = adjust->temperature_matrix[i];
 
-		convert_float_matrix(
-			arr_reg_val, arr_matrix, GAMUT_MATRIX_SIZE);
+		convert_float_matrix(arr_reg_val, arr_matrix,
+			CM_GAMUT_REMAP_COEF_FORMAT_S2_13, GAMUT_MATRIX_SIZE);
 
 		program_gamut_remap(xfm_dce, arr_reg_val);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index 9788628cf0ad..ff17a9c9eed0 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -171,8 +171,8 @@ void dpp1_cm_set_gamut_remap(
 		for (i = 0; i < 12; i++)
 			arr_matrix[i] = adjust->temperature_matrix[i];
 
-		convert_float_matrix(
-			arr_reg_val, arr_matrix, 12);
+		convert_float_matrix(arr_reg_val, arr_matrix,
+			CM_GAMUT_REMAP_COEF_FORMAT_S2_13, 12);
 
 		program_gamut_remap(dpp, arr_reg_val, GAMUT_REMAP_COEFF);
 	}
@@ -242,8 +242,8 @@ void dpp1_cm_get_gamut_remap(struct dpp *dpp_base,
 	}
 
 	adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
-	convert_hw_matrix(adjust->temperature_matrix,
-			  arr_reg_val, ARRAY_SIZE(arr_reg_val));
+	convert_hw_matrix(adjust->temperature_matrix, arr_reg_val,
+			CM_GAMUT_REMAP_COEF_FORMAT_S2_13, ARRAY_SIZE(arr_reg_val));
 }
 
 static void dpp1_cm_program_color_matrix(
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
index 26f9485f165d..74cc176d9437 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
@@ -227,8 +227,8 @@ void dpp2_cm_set_gamut_remap(
 		for (i = 0; i < 12; i++)
 			arr_matrix[i] = adjust->temperature_matrix[i];
 
-		convert_float_matrix(
-			arr_reg_val, arr_matrix, 12);
+		convert_float_matrix(arr_reg_val, arr_matrix,
+			CM_GAMUT_REMAP_COEF_FORMAT_S2_13, 12);
 
 		program_gamut_remap(dpp, arr_reg_val, DCN2_GAMUT_REMAP_COEF_A);
 	}
@@ -285,8 +285,8 @@ void dpp2_cm_get_gamut_remap(struct dpp *dpp_base,
 	}
 
 	adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
-	convert_hw_matrix(adjust->temperature_matrix,
-			  arr_reg_val, ARRAY_SIZE(arr_reg_val));
+	convert_hw_matrix(adjust->temperature_matrix, arr_reg_val,
+			CM_GAMUT_REMAP_COEF_FORMAT_S2_13, ARRAY_SIZE(arr_reg_val));
 }
 
 void dpp2_program_input_csc(
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
index e01d8e9672fc..8fe3474411b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
@@ -392,8 +392,8 @@ void dpp3_cm_set_gamut_remap(
 		for (i = 0; i < 12; i++)
 			arr_matrix[i] = adjust->temperature_matrix[i];
 
-		convert_float_matrix(
-			arr_reg_val, arr_matrix, 12);
+		convert_float_matrix(arr_reg_val, arr_matrix,
+				CM_GAMUT_REMAP_COEF_FORMAT_S2_13, 12);
 
 		//current coefficient set in use
 		REG_GET(CM_GAMUT_REMAP_CONTROL, CM_GAMUT_REMAP_MODE_CURRENT, &gamut_mode);
@@ -460,6 +460,6 @@ void dpp3_cm_get_gamut_remap(struct dpp *dpp_base,
 	}
 
 	adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
-	convert_hw_matrix(adjust->temperature_matrix,
-			  arr_reg_val, ARRAY_SIZE(arr_reg_val));
+	convert_hw_matrix(adjust->temperature_matrix, arr_reg_val,
+			CM_GAMUT_REMAP_COEF_FORMAT_S2_13, ARRAY_SIZE(arr_reg_val));
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c
index 37adf0e6a166..5a611dd14581 100644
--- a/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c
@@ -371,7 +371,8 @@ void dwb3_set_gamut_remap(
 		for (i = 0; i < 12; i++)
 			arr_matrix[i] = adjust.temperature_matrix[i];
 
-		convert_float_matrix(arr_reg_val, arr_matrix, 12);
+		convert_float_matrix(arr_reg_val, arr_matrix,
+			CM_GAMUT_REMAP_COEF_FORMAT_S2_13, 12);
 
 		REG_GET(DWB_GAMUT_REMAP_MODE, DWB_GAMUT_REMAP_MODE_CURRENT, &current_mode);
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
index d7a07e29d23a..9cc6fd38da19 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
@@ -1067,7 +1067,8 @@ static void program_gamut_remap(
 		struct dcn30_mpc *mpc30,
 		int mpcc_id,
 		const uint16_t *regval,
-		uint32_t select)
+		uint32_t select,
+		enum cm_gamut_coef_format coef_format)
 {
 	uint16_t selection = 0;
 	struct color_matrices_reg gam_regs;
@@ -1117,9 +1118,11 @@ static void program_gamut_remap(
 				&gam_regs);
 
 	}
-	//select coefficient set to use
+	// select coefficient set + format to use
 	REG_SET(MPCC_GAMUT_REMAP_MODE[mpcc_id], 0,
 					MPCC_GAMUT_REMAP_MODE, selection);
+	REG_SET(MPCC_GAMUT_REMAP_COEF_FORMAT[mpcc_id], 0,
+					MPCC_GAMUT_REMAP_COEF_FORMAT, coef_format);
 }
 
 void mpc3_set_gamut_remap(
@@ -1130,18 +1133,26 @@ void mpc3_set_gamut_remap(
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 	int i = 0;
 	uint32_t gamut_mode;
+	uint16_t hw_matrix[12];
+	enum cm_gamut_coef_format coef_format = CM_GAMUT_REMAP_COEF_FORMAT_S2_13;
+	struct fixed31_32 abs_max_coef = {0};
 
 	if (adjust->gamut_adjust_type != GRAPHICS_GAMUT_ADJUST_TYPE_SW)
-		program_gamut_remap(mpc30, mpcc_id, NULL, GAMUT_REMAP_BYPASS);
+		program_gamut_remap(mpc30, mpcc_id, NULL, GAMUT_REMAP_BYPASS, coef_format);
 	else {
-		struct fixed31_32 arr_matrix[12];
-		uint16_t arr_reg_val[12];
+		// take largest absolute value of coefficient in temperature matrix
+		// if S2D13 cannot fit value, use S3D12
+		for (i = 0; i < 12; i++) {
+			if (dc_fixpt_le(abs_max_coef, dc_fixpt_abs(adjust->temperature_matrix[i])))
+				abs_max_coef = dc_fixpt_abs(adjust->temperature_matrix[i]);
+		}
 
-		for (i = 0; i < 12; i++)
-			arr_matrix[i] = adjust->temperature_matrix[i];
+		if (dc_fixpt_le(abs_max_coef, dc_fixpt_from_fraction(S2D13_MAX, DIVIDER)))
+			coef_format = CM_GAMUT_REMAP_COEF_FORMAT_S2_13;
+		else
+			coef_format = CM_GAMUT_REMAP_COEF_FORMAT_S3_12;
 
-		convert_float_matrix(
-			arr_reg_val, arr_matrix, 12);
+		convert_float_matrix(hw_matrix, adjust->temperature_matrix, coef_format, 12);
 
 		//current coefficient set in use
 		REG_GET(MPCC_GAMUT_REMAP_MODE[mpcc_id], MPCC_GAMUT_REMAP_MODE_CURRENT, &gamut_mode);
@@ -1153,19 +1164,21 @@ void mpc3_set_gamut_remap(
 		else
 			gamut_mode = 1;
 
-		program_gamut_remap(mpc30, mpcc_id, arr_reg_val, gamut_mode);
+		program_gamut_remap(mpc30, mpcc_id, hw_matrix, gamut_mode, coef_format);
 	}
 }
 
 static void read_gamut_remap(struct dcn30_mpc *mpc30,
 			     int mpcc_id,
 			     uint16_t *regval,
-			     uint32_t *select)
+			     uint32_t *select,
+				 enum cm_gamut_coef_format *coef_format)
 {
 	struct color_matrices_reg gam_regs;
 
-	//current coefficient set in use
+	//current coefficient set in use + format
 	REG_GET(MPCC_GAMUT_REMAP_MODE[mpcc_id], MPCC_GAMUT_REMAP_MODE_CURRENT, select);
+	REG_GET(MPCC_GAMUT_REMAP_COEF_FORMAT[mpcc_id], MPCC_GAMUT_REMAP_COEF_FORMAT, coef_format);
 
 	gam_regs.shifts.csc_c11 = mpc30->mpc_shift->MPCC_GAMUT_REMAP_C11_A;
 	gam_regs.masks.csc_c11  = mpc30->mpc_mask->MPCC_GAMUT_REMAP_C11_A;
@@ -1202,8 +1215,9 @@ void mpc3_get_gamut_remap(struct mpc *mpc,
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 	uint16_t arr_reg_val[12] = {0};
 	uint32_t select;
+	enum cm_gamut_coef_format coef_format = CM_GAMUT_REMAP_COEF_FORMAT_S2_13;
 
-	read_gamut_remap(mpc30, mpcc_id, arr_reg_val, &select);
+	read_gamut_remap(mpc30, mpcc_id, arr_reg_val, &select, &coef_format);
 
 	if (select == GAMUT_REMAP_BYPASS) {
 		adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
@@ -1211,8 +1225,8 @@ void mpc3_get_gamut_remap(struct mpc *mpc,
 	}
 
 	adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
-	convert_hw_matrix(adjust->temperature_matrix,
-			  arr_reg_val, ARRAY_SIZE(arr_reg_val));
+	convert_hw_matrix(adjust->temperature_matrix, arr_reg_val,
+			coef_format, ARRAY_SIZE(arr_reg_val));
 }
 
 bool mpc3_program_3dlut(
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index ce1ee2062e41..d8a4e604a34e 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -302,7 +302,8 @@ void mpc_program_gamut_remap(
 	unsigned int mpcc_id,
 	const uint16_t *regval,
 	enum mpcc_gamut_remap_id gamut_remap_block_id,
-	enum mpcc_gamut_remap_mode_select mode_select)
+	enum mpcc_gamut_remap_mode_select mode_select,
+	enum cm_gamut_coef_format coef_format)
 {
 	struct color_matrices_reg gamut_regs;
 	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
@@ -339,8 +340,11 @@ void mpc_program_gamut_remap(
 			regval,
 			&gamut_regs);
 
-		//select coefficient set to use, set A (MODE_1) or set B (MODE_2)
-		REG_SET(MPCC_GAMUT_REMAP_MODE[mpcc_id], 0, MPCC_GAMUT_REMAP_MODE, mode_select);
+		//select coefficient set to use, set A (MODE_1) or set B (MODE_2) + format
+		REG_SET(MPCC_GAMUT_REMAP_MODE[mpcc_id], 0,
+			MPCC_GAMUT_REMAP_MODE, mode_select);
+		REG_SET(MPCC_GAMUT_REMAP_COEF_FORMAT[mpcc_id], 0,
+			MPCC_GAMUT_REMAP_COEF_FORMAT, coef_format);
 		break;
 
 	case MPCC_MCM_FIRST_GAMUT_REMAP:
@@ -373,9 +377,11 @@ void mpc_program_gamut_remap(
 			regval,
 			&gamut_regs);
 
-		//select coefficient set to use, set A (MODE_1) or set B (MODE_2)
+		//select coefficient set to use, set A (MODE_1) or set B (MODE_2) + format
 		REG_SET(MPCC_MCM_FIRST_GAMUT_REMAP_MODE[mpcc_id], 0,
 			MPCC_MCM_FIRST_GAMUT_REMAP_MODE, mode_select);
+		REG_SET(MPCC_MCM_FIRST_GAMUT_REMAP_COEF_FORMAT[mpcc_id], 0,
+			MPCC_MCM_FIRST_GAMUT_REMAP_COEF_FORMAT, coef_format);
 		break;
 
 	case MPCC_MCM_SECOND_GAMUT_REMAP:
@@ -408,9 +414,11 @@ void mpc_program_gamut_remap(
 			regval,
 			&gamut_regs);
 
-		//select coefficient set to use, set A (MODE_1) or set B (MODE_2)
+		//select coefficient set to use, set A (MODE_1) or set B (MODE_2) + format
 		REG_SET(MPCC_MCM_SECOND_GAMUT_REMAP_MODE[mpcc_id], 0,
 			MPCC_MCM_SECOND_GAMUT_REMAP_MODE, mode_select);
+		REG_SET(MPCC_MCM_SECOND_GAMUT_REMAP_COEF_FORMAT[mpcc_id], 0,
+			MPCC_MCM_SECOND_GAMUT_REMAP_COEF_FORMAT, coef_format);
 		break;
 
 	default:
@@ -426,19 +434,28 @@ void mpc401_set_gamut_remap(
 	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
 	unsigned int i = 0;
 	uint32_t mode_select = 0;
+	uint16_t hw_matrix[12];
+	enum cm_gamut_coef_format coef_format = CM_GAMUT_REMAP_COEF_FORMAT_S2_13;
+	struct fixed31_32 abs_max_coef = {0};
 
 	if (adjust->gamut_adjust_type != GRAPHICS_GAMUT_ADJUST_TYPE_SW) {
 		/* Bypass / Disable if type is bypass or hw */
-		mpc_program_gamut_remap(mpc, mpcc_id, NULL,
-			adjust->mpcc_gamut_remap_block_id, MPCC_GAMUT_REMAP_MODE_SELECT_0);
+		mpc_program_gamut_remap(mpc, mpcc_id, NULL, adjust->mpcc_gamut_remap_block_id,
+			MPCC_GAMUT_REMAP_MODE_SELECT_0, coef_format);
 	} else {
-		struct fixed31_32 arr_matrix[12];
-		uint16_t arr_reg_val[12];
+		// take largest absolute value of coefficient in temperature matrix
+		// if S2D13 cannot fit value, use S3D12
+		for (i = 0; i < 12; i++) {
+			if (dc_fixpt_le(abs_max_coef, dc_fixpt_abs(adjust->temperature_matrix[i])))
+				abs_max_coef = dc_fixpt_abs(adjust->temperature_matrix[i]);
+		}
 
-		for (i = 0; i < 12; i++)
-			arr_matrix[i] = adjust->temperature_matrix[i];
+		if (dc_fixpt_le(abs_max_coef, dc_fixpt_from_fraction(S2D13_MAX, DIVIDER)))
+			coef_format = CM_GAMUT_REMAP_COEF_FORMAT_S2_13;
+		else
+			coef_format = CM_GAMUT_REMAP_COEF_FORMAT_S3_12;
 
-		convert_float_matrix(arr_reg_val, arr_matrix, 12);
+		convert_float_matrix(hw_matrix, adjust->temperature_matrix, coef_format, 12);
 
 		switch (adjust->mpcc_gamut_remap_block_id) {
 		case MPCC_OGAM_GAMUT_REMAP:
@@ -463,8 +480,8 @@ void mpc401_set_gamut_remap(
 		else
 			mode_select = MPCC_GAMUT_REMAP_MODE_SELECT_2;
 
-		mpc_program_gamut_remap(mpc, mpcc_id, arr_reg_val,
-			adjust->mpcc_gamut_remap_block_id, mode_select);
+		mpc_program_gamut_remap(mpc, mpcc_id, hw_matrix,
+			adjust->mpcc_gamut_remap_block_id, mode_select, coef_format);
 	}
 }
 
@@ -472,7 +489,8 @@ void mpc_read_gamut_remap(struct mpc *mpc,
 	int mpcc_id,
 	uint16_t *regval,
 	enum mpcc_gamut_remap_id gamut_remap_block_id,
-	uint32_t *mode_select)
+	uint32_t *mode_select,
+	enum cm_gamut_coef_format *coef_format)
 {
 	struct color_matrices_reg gamut_regs = {0};
 	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
@@ -480,7 +498,10 @@ void mpc_read_gamut_remap(struct mpc *mpc,
 	switch (gamut_remap_block_id) {
 	case MPCC_OGAM_GAMUT_REMAP:
 		//current coefficient set in use
-		REG_GET(MPCC_GAMUT_REMAP_MODE[mpcc_id], MPCC_GAMUT_REMAP_MODE_CURRENT, mode_select);
+		REG_GET(MPCC_GAMUT_REMAP_MODE[mpcc_id],
+			MPCC_GAMUT_REMAP_MODE_CURRENT, mode_select);
+		REG_GET(MPCC_GAMUT_REMAP_COEF_FORMAT[mpcc_id],
+			MPCC_GAMUT_REMAP_COEF_FORMAT, coef_format);
 
 		gamut_regs.shifts.csc_c11 = mpc401->mpc_shift->MPCC_GAMUT_REMAP_C11_A;
 		gamut_regs.masks.csc_c11 = mpc401->mpc_mask->MPCC_GAMUT_REMAP_C11_A;
@@ -503,7 +524,9 @@ void mpc_read_gamut_remap(struct mpc *mpc,
 
 	case MPCC_MCM_FIRST_GAMUT_REMAP:
 		REG_GET(MPCC_MCM_FIRST_GAMUT_REMAP_MODE[mpcc_id],
-				MPCC_MCM_FIRST_GAMUT_REMAP_MODE_CURRENT, mode_select);
+			MPCC_MCM_FIRST_GAMUT_REMAP_MODE_CURRENT, mode_select);
+		REG_GET(MPCC_MCM_FIRST_GAMUT_REMAP_COEF_FORMAT[mpcc_id],
+			MPCC_MCM_FIRST_GAMUT_REMAP_COEF_FORMAT, coef_format);
 
 		gamut_regs.shifts.csc_c11 = mpc401->mpc_shift->MPCC_MCM_FIRST_GAMUT_REMAP_C11_A;
 		gamut_regs.masks.csc_c11 = mpc401->mpc_mask->MPCC_MCM_FIRST_GAMUT_REMAP_C11_A;
@@ -526,7 +549,9 @@ void mpc_read_gamut_remap(struct mpc *mpc,
 
 	case MPCC_MCM_SECOND_GAMUT_REMAP:
 		REG_GET(MPCC_MCM_SECOND_GAMUT_REMAP_MODE[mpcc_id],
-				MPCC_MCM_SECOND_GAMUT_REMAP_MODE_CURRENT, mode_select);
+			MPCC_MCM_SECOND_GAMUT_REMAP_MODE_CURRENT, mode_select);
+		REG_GET(MPCC_MCM_SECOND_GAMUT_REMAP_COEF_FORMAT[mpcc_id],
+			MPCC_MCM_SECOND_GAMUT_REMAP_COEF_FORMAT, coef_format);
 
 		gamut_regs.shifts.csc_c11 = mpc401->mpc_shift->MPCC_MCM_SECOND_GAMUT_REMAP_C11_A;
 		gamut_regs.masks.csc_c11 = mpc401->mpc_mask->MPCC_MCM_SECOND_GAMUT_REMAP_C11_A;
@@ -565,8 +590,10 @@ void mpc401_get_gamut_remap(struct mpc *mpc,
 {
 	uint16_t arr_reg_val[12] = {0};
 	uint32_t mode_select = MPCC_GAMUT_REMAP_MODE_SELECT_0;
+	enum cm_gamut_coef_format coef_format = CM_GAMUT_REMAP_COEF_FORMAT_S2_13;
 
-	mpc_read_gamut_remap(mpc, mpcc_id, arr_reg_val, adjust->mpcc_gamut_remap_block_id, &mode_select);
+	mpc_read_gamut_remap(mpc, mpcc_id, arr_reg_val,
+			adjust->mpcc_gamut_remap_block_id, &mode_select, &coef_format);
 
 	if (mode_select == MPCC_GAMUT_REMAP_MODE_SELECT_0) {
 		adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
@@ -574,8 +601,8 @@ void mpc401_get_gamut_remap(struct mpc *mpc,
 	}
 
 	adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
-	convert_hw_matrix(adjust->temperature_matrix,
-		arr_reg_val, ARRAY_SIZE(arr_reg_val));
+	convert_hw_matrix(adjust->temperature_matrix, arr_reg_val,
+			coef_format, ARRAY_SIZE(arr_reg_val));
 }
 
 static const struct mpc_funcs dcn401_mpc_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
index 6d842d7b95c7..3d00d9497ed2 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
@@ -242,13 +242,15 @@ void mpc_program_gamut_remap(
 	unsigned int mpcc_id,
 	const uint16_t *regval,
 	enum mpcc_gamut_remap_id gamut_remap_block_id,
-	enum mpcc_gamut_remap_mode_select mode_select);
+	enum mpcc_gamut_remap_mode_select mode_select,
+	enum cm_gamut_coef_format coef_format);
 
 void mpc_read_gamut_remap(struct mpc *mpc,
 	int mpcc_id,
 	uint16_t *regval,
 	enum mpcc_gamut_remap_id gamut_remap_block_id,
-	uint32_t *mode_select);
+	uint32_t *mode_select,
+	enum cm_gamut_coef_format *coef_format);
 
 void mpc401_get_3dlut_fast_load_status(
 	struct mpc *mpc,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index d11ab57afcdd..40fc66e64c1b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -31,6 +31,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn20/dcn20_resource.h"
 
 #include "dcn30_resource.h"
@@ -2515,6 +2516,7 @@ static bool dcn30_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 4ecf448d15b6..551565ae9ef2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -31,6 +31,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn30/dcn30_resource.h"
 #include "dcn301_resource.h"
 
@@ -1516,6 +1517,7 @@ static bool dcn301_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.dp_hdmi21_pcon_support = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index ae8918a4ad3e..2574e706631d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -27,6 +27,7 @@
 #include "dcn302_resource.h"
 #include "dcn302/dcn302_dccg.h"
 #include "irq/dcn302/irq_service_dcn302.h"
+#include "basics/conversion.h"
 
 #include "dcn30/dcn30_dio_link_encoder.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
@@ -1416,6 +1417,7 @@ static bool dcn302_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.dp_hdmi21_pcon_support = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 75e6f4e46f60..8b24628e3e14 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -27,6 +27,7 @@
 #include "dcn303_resource.h"
 #include "dcn303/dcn303_dccg.h"
 #include "irq/dcn303/irq_service_dcn303.h"
+#include "basics/conversion.h"
 
 #include "dcn30/dcn30_dio_link_encoder.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
@@ -1360,6 +1361,7 @@ static bool dcn303_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.dp_hdmi21_pcon_support = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index e29efa452c87..8bb2b8b29cbf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -31,6 +31,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn31_resource.h"
 
 #include "dcn20/dcn20_resource.h"
@@ -2123,6 +2124,7 @@ static bool dcn31_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index f50b3250dcba..372e05487847 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -33,6 +33,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn314_resource.h"
 
 #include "dcn20/dcn20_resource.h"
@@ -2051,6 +2052,7 @@ static bool dcn314_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.max_disp_clock_khz_at_vmin = 650000;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 8297f2f04c16..6e112ef0a49a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -31,6 +31,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn315_resource.h"
 
 #include "dcn20/dcn20_resource.h"
@@ -2095,6 +2096,7 @@ static bool dcn315_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->config.no_native422_support = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 046566ad1afe..b9d2567a4180 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -31,6 +31,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn316_resource.h"
 
 #include "dcn20/dcn20_resource.h"
@@ -1969,6 +1970,7 @@ static bool dcn316_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	/* read VBIOS LTTPR caps */
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 004c5690f876..cd9d2087d14e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -32,6 +32,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn32_resource.h"
 
 #include "dcn20/dcn20_resource.h"
@@ -2448,6 +2449,7 @@ static bool dcn32_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 53fd32249310..ff9c1379896e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -31,6 +31,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn32/dcn32_resource.h"
 #include "dcn321_resource.h"
 
@@ -1939,6 +1940,7 @@ static bool dcn321_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 	/* HACK: Force FRL support until BIOS is ready. */
 	dc->config.force_hdmi21_frl_enc_enable = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 5541b89b1350..1b9b6eb8b322 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -32,6 +32,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn35_resource.h"
 #include "dml2_0/dml2_wrapper.h"
 
@@ -2078,6 +2079,7 @@ static bool dcn35_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 053b4380f57e..2268ced16969 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -10,6 +10,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn351_resource.h"
 
 #include "dcn20/dcn20_resource.h"
@@ -2051,6 +2052,7 @@ static bool dcn351_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 592000cf9250..b1323e76801e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -10,6 +10,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn36_resource.h"
 #include "dml2_0/dml2_wrapper.h"
 
@@ -2048,6 +2049,7 @@ static bool dcn36_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index f7ba0509e6bd..181cb7135dfb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -10,6 +10,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 #include "dcn401_resource.h"
 
 #include "dcn20/dcn20_resource.h"
@@ -2131,6 +2132,7 @@ static bool dcn401_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 	/* HACK: Force FRL support until BIOS is ready. */
 	dc->config.force_hdmi21_frl_enc_enable = true;
 	dc->config.use_spl = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 67673a9e5155..dba1b69137f9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -9,6 +9,7 @@
 #include "dcn42/dcn42_init.h"
 
 #include "resource.h"
+#include "basics/conversion.h"
 #include "include/irq_service_interface.h"
 
 #include "dcn42_resource.h"
@@ -2110,6 +2111,7 @@ static bool dcn42_resource_construct(
 	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_format_support.float_fp1_5_10 = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_pixel_order_support.order_rgba = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_pixel_order_support.order_bgra = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.num_of_host_routers = 3;
 	dc->caps.num_of_dpias_per_host_router = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 2334bc5b75b8..dbd6267340ac 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -13,6 +13,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
+#include "basics/conversion.h"
 
 #include "dcn42b_resource.h"
 #include "dcn20/dcn20_resource.h"
@@ -2080,6 +2081,7 @@ static bool dcn42b_resource_construct(
 	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_format_support.float_fp1_5_10 = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_pixel_order_support.order_rgba = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_pixel_order_support.order_bgra = 1;
+	dc->caps.color.mpc.max_gamut_remap_coeff = dc_fixpt_from_fraction(S3D12_MAX, DIVIDER);
 
 	dc->caps.num_of_host_routers = 0;
 	dc->caps.num_of_dpias_per_host_router = 0;
-- 
2.53.0

