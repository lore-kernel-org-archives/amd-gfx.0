Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772ADC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B8310EE37;
	Wed, 26 Aug 2026 23:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWB/ugGo";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D8C10EE37
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiwSpPw2L51nDIIFIhpv2VynvJHb0LSF1i3HOXwpsokvH1+PYePJpaEDfsIkAJvq627p8ZKGTyztvGKYH3fDbUd+S2w9XNHdYaoLafV24p6Avndw0eDD0QnQNUsJFYbcbIuSkf4RyK9y0epG0da1M65BNJ1udssYAbGiXK5zVcTXf0CojDO44ge3h6+CzpvmLXEBb2CfNdF203cWAsCvYYA6nNdq29EtSkI0f2ENuertJQNPLSXKo3NcrDgJtWQ/uPqbMqbhVjC9WN67FXoYB0fIWm/3tOxj178+zgCTFh7vHaHG4QHzyDiyCWrPRGbzDrcHqTiiNY64QzzTIoaHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRRd7L5YexTYYAcjcbPYzXSi0CD10tRsDpv0PENORYw=;
 b=F1XjGM2PFoJJb4vVxcYg+t20giYEBarNXV/vt2EHeDEwATEwXjUA6Y65+L3Yt59F3wBEON6+wNVrjukxNwHgLwqMobWBz3IXG5JbRIJQq+NpJKiv9oMmKNpl55OSM1K1GqjYtrxhs9DwJ3vJ80z9pntLY1+/6U8RGJ+6S3cPCFDIKYmgNkfPf5aMbufGdnuG+OY6OYwdt8T8hn4qo5DNCba8TExc2lN9Ycq7hgVTPvc3Ychbk8vGH6WgUBHsL4UwLxHpBZUrqAhjJxfFDaTMzCFsuFLWqQe+ZSQssG5czWI8qlIWprM5uuRDho8XudhmmGoVWHkaCQA5LkUMh3gSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRRd7L5YexTYYAcjcbPYzXSi0CD10tRsDpv0PENORYw=;
 b=WWB/ugGo1ZNt+Hp9LryGpksyHd4f1A4z3USPdF8su/Uz77MdQ3ACSLLSI1BaXNOGOVclpb49t6XnPLzlQAqOP8ocMkpp2Mh+9Ik3WEtCan+bQ2+zVGmy4DYP5EgKDjeEEDPswLIi9WHqCOOU/54B7aK8QjKKid0wlFJbjct7+ng=
Received: from PH7PR10CA0015.namprd10.prod.outlook.com (2603:10b6:510:23d::17)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:19:07 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::1b) by PH7PR10CA0015.outlook.office365.com
 (2603:10b6:510:23d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:19:06 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:18:59 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <Samson.Tam@amd.com>, Dave Airlie
 <airlied@redhat.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 10/59] drm/amd/display: Remove fixpt and custom float
 duplicated code
Date: Wed, 26 Aug 2026 17:04:41 -0600
Message-ID: <20260826231519.881949-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f29dbc-133c-4e9d-6a69-08df03c86ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: QlVNod3Wv0ZZzw9PTpvVsvnptQ7OWIC4BM23whXFDspU/3fp8VKGDx7I1ovs7EWbBY7Ec9+murwdeMkfXyHj8f++9ghlOID11IXcMJVWiOa7w0egP8bzyfKg+ypwXYv3u2Eknv0ukNyQR96bPnEC869QE+vy/NgCVKK3k36D2bPBqW+8JUxUaExbCN5y/eH0DkbOqi0zdAs9tDWAgSqtFTfHa8AqW6WWUpOa9UVywlfuxncdrvlJNT0EffPR/S/WtIjaxKwg529Nt4y88LcnOW1SWTwbC86kHok0yDkYb5ZQ+FMFEB/sQlMtCxVdFc2QqcQri91gRg5XNs8kjFT06536MHLZhOProFLsSAQa+2HtUMPzx98CUgyoP7kTdVxlxz8hwfEhXgj9YI9on1GwVI2p+iiTiejOtot0PobB6NAeoeZFtB0Gd5+dH4pgRweXKPfYjpQL+BBiHS+49YW7EvsueRrGUZRqCMX9kv3Ge8aDRjxkM26wKqpYSrR4cq42wEBFEcD0XvOUUc0SLmc0mkGJ4RYkq202cZIsnp3KLy88EsjYsHxH6ZJDeyN9iKkWqFyJ2anHcu9qwj7chJVfavQkaESAtF1+8/APiag2NNOsA4wD+nPw4TFPAroye6Vf6IiShIfz0hx+B/ptUkul/hfThVyEhP7Ktz1DI/YeoGIvL1xDAky8CBxSU7YMPKCdLRKVg6GSOcn6agXiXqUnMg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2kSoR6W0v4EXUR0mOzRvOUOK2pwb8Q+zefxbnH5NLM0CBB4YyMgHGARuf5Hu0HUQicUd3iw5UQSIOW9eBqtrNJiIyT55LyLY6uU7LUIrDUV1UwvZQV3WocKyhitdppaQEPiSeR+7UNC2Las3Jhuc6ip8MmjZgUv0BA6fGeEC2p0etg2I/MmfM5AmgOkh4BJ5+6sjf0kdwXA5xoEnYZeQ6eO1i4VebtNaoAgsSjqPFMdZfhO1KWmh9j8VP/F7Qhol4T/Bk0QEwSOQgQ94vOW5tBhlBpBiIdbC7cm5SYWGrxu0vwxHq2Po7DXdDR9a1EE4s4Xyg1fnZvIXO4Uetww5GhbgAkvo/oGGhWGvYc/Rsbuh7Wm3T36oqvNtuh5gQ+YaYElEuU5XwJyMvXRbH3SOsWYrGBZ6tp88u7i8etdJQZ7hEig0gFJEs+SMZJqNWUmh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:19:06.4130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f29dbc-133c-4e9d-6a69-08df03c86ce2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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

[WHY/HOW]
fixpt31_32 and custom_float code is duplicated in SPL
Remove duplicated code and refer back to dc
Cleaned up swap, div64_s64
Move namespace defines to spl_namespace.h

Suggested-by: Dave Airlie <airlied@redhat.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/Makefile  |   5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 130 +++--
 .../display/dc/sspl/dc_spl_isharp_filters.c   |  10 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.c |  88 +--
 .../amd/display/dc/sspl/dc_spl_scl_filters.c  |  24 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |  60 +-
 .../amd/display/dc/sspl/spl_custom_float.c    | 152 -----
 .../amd/display/dc/sspl/spl_custom_float.h    |  29 -
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  | 495 ----------------
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.h  | 526 ------------------
 .../drm/amd/display/dc/sspl/spl_namespace.h   |  17 +
 .../drm/amd/display/dc/sspl/spl_os_types.h    |  43 +-
 12 files changed, 213 insertions(+), 1366 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_namespace.h

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/Makefile b/drivers/gpu/drm/amd/display/dc/sspl/Makefile
index 5e3e4aa13820..fdf37a2408be 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/sspl/Makefile
@@ -23,7 +23,10 @@
 # Makefile for the 'spl' sub-component of DAL.
 # It provides the scaling library interface.
 
-SPL = dc_spl.o dc_spl_scl_filters.o dc_spl_scl_easf_filters.o dc_spl_isharp_filters.o dc_spl_filters.o spl_fixpt31_32.o spl_custom_float.o
+# spl_fixpt31_32 and spl_custom_float are now provided by the host driver
+# (dc_fixpt_* / convert_to_custom_float_format) via the shim headers
+# spl_fixpt31_32.h / spl_custom_float.h.
+SPL = dc_spl.o dc_spl_scl_filters.o dc_spl_scl_easf_filters.o dc_spl_isharp_filters.o dc_spl_filters.o
 
 AMD_DAL_SPL = $(addprefix $(AMDDALPATH)/dc/sspl/,$(SPL))
 
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 1f1318769d5b..f14e3069acfd 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -7,8 +7,22 @@
 #include "dc_spl_isharp_filters.h"
 #include "spl_debug.h"
 
-#define IDENTITY_RATIO(ratio) (SPL_NAMESPACE(spl_fixpt_u3d19(ratio)) == (1 << 19))
+/*
+ * Custom float is provided by the parent repo's custom_float.h. It is included
+ * here (after dc_spl.h -> dc_spl_types.h, which fully defines struct
+ * dscl_prog_data) so the opp.h -> transform.h -> dc_spl_types.h chain that
+ * custom_float.h drags in does not re-enter dc_spl_types.h before
+ * dscl_prog_data is complete.
+ */
+#define spl_div64_s64 div64_s64
+#define spl_swap      swap
+#include "custom_float.h"
+#define spl_custom_float_format custom_float_format
+#define spl_convert_to_custom_float_format convert_to_custom_float_format
+
+#define IDENTITY_RATIO(ratio) (spl_fixpt_u3d19(ratio) == (1 << 19))
 #define MIN_VIEWPORT_SIZE 12
+
 static bool spl_is_yuv420(enum spl_pixel_format format)
 {
 	if ((format >= SPL_PIXEL_FORMAT_420BPP8) &&
@@ -169,24 +183,24 @@ static struct spl_rect calculate_plane_rec_in_timing_active(
 	struct spl_fixed31_32 temp;
 
 
-	temp = SPL_NAMESPACE(spl_fixpt_from_fraction(
+	temp = spl_fixpt_from_fraction(
 			rec_in->x * (long long)stream_dst->width,
-			stream_src->width));
+			stream_src->width);
 	rec_out.x = stream_dst->x + spl_fixpt_round(temp);
 
-	temp = SPL_NAMESPACE(spl_fixpt_from_fraction(
+	temp = spl_fixpt_from_fraction(
 			(rec_in->x + rec_in->width) * (long long)stream_dst->width,
-			stream_src->width));
+			stream_src->width);
 	rec_out.width = stream_dst->x + spl_fixpt_round(temp) - rec_out.x;
 
-	temp = SPL_NAMESPACE(spl_fixpt_from_fraction(
+	temp = spl_fixpt_from_fraction(
 			rec_in->y * (long long)stream_dst->height,
-			stream_src->height));
+			stream_src->height);
 	rec_out.y = stream_dst->y + spl_fixpt_round(temp);
 
-	temp = SPL_NAMESPACE(spl_fixpt_from_fraction(
+	temp = spl_fixpt_from_fraction(
 			(rec_in->y + rec_in->height) * (long long)stream_dst->height,
-			stream_src->height));
+			stream_src->height);
 	rec_out.height = stream_dst->y + spl_fixpt_round(temp) - rec_out.y;
 
 	return rec_out;
@@ -453,12 +467,12 @@ static void spl_calculate_scaling_ratios(struct spl_in *spl_in,
 		spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_270)
 		spl_swap(surf_src.height, surf_src.width);
 
-	spl_scratch->scl_data.ratios.horz = SPL_NAMESPACE(spl_fixpt_from_fraction(
+	spl_scratch->scl_data.ratios.horz = spl_fixpt_from_fraction(
 					surf_src.width,
-					spl_in->basic_in.dst_rect.width));
-	spl_scratch->scl_data.ratios.vert = SPL_NAMESPACE(spl_fixpt_from_fraction(
+					spl_in->basic_in.dst_rect.width);
+	spl_scratch->scl_data.ratios.vert = spl_fixpt_from_fraction(
 					surf_src.height,
-					spl_in->basic_in.dst_rect.height));
+					spl_in->basic_in.dst_rect.height);
 
 	if (spl_in->basic_out.view_format == SPL_VIEW_3D_SIDE_BY_SIDE)
 		spl_scratch->scl_data.ratios.horz.value *= 2;
@@ -497,14 +511,14 @@ static void spl_calculate_scaling_ratios(struct spl_in *spl_in,
 	 * that is output/input.  Currently we calculate input/output
 	 * Store 1/ratio in recip_ratio for those lookups
 	 */
-	spl_scratch->scl_data.recip_ratios.horz = SPL_NAMESPACE(spl_fixpt_recip(
-			spl_scratch->scl_data.ratios.horz));
-	spl_scratch->scl_data.recip_ratios.vert = SPL_NAMESPACE(spl_fixpt_recip(
-			spl_scratch->scl_data.ratios.vert));
-	spl_scratch->scl_data.recip_ratios.horz_c = SPL_NAMESPACE(spl_fixpt_recip(
-			spl_scratch->scl_data.ratios.horz_c));
-	spl_scratch->scl_data.recip_ratios.vert_c = SPL_NAMESPACE(spl_fixpt_recip(
-			spl_scratch->scl_data.ratios.vert_c));
+	spl_scratch->scl_data.recip_ratios.horz = spl_fixpt_recip(
+			spl_scratch->scl_data.ratios.horz);
+	spl_scratch->scl_data.recip_ratios.vert = spl_fixpt_recip(
+			spl_scratch->scl_data.ratios.vert);
+	spl_scratch->scl_data.recip_ratios.horz_c = spl_fixpt_recip(
+			spl_scratch->scl_data.ratios.horz_c);
+	spl_scratch->scl_data.recip_ratios.vert_c = spl_fixpt_recip(
+			spl_scratch->scl_data.ratios.vert_c);
 }
 
 /* Calculate Viewport size */
@@ -664,11 +678,11 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 
 		switch (spl_in->basic_in.cositing) {
 		case CHROMA_COSITING_TOPLEFT:
-			init_adj_h = SPL_NAMESPACE(spl_fixpt_from_fraction(h_sign, 4));
-			init_adj_v = SPL_NAMESPACE(spl_fixpt_from_fraction(v_sign, 4));
+			init_adj_h = spl_fixpt_from_fraction(h_sign, 4);
+			init_adj_v = spl_fixpt_from_fraction(v_sign, 4);
 			break;
 		case CHROMA_COSITING_LEFT:
-			init_adj_h = SPL_NAMESPACE(spl_fixpt_from_fraction(h_sign, 4));
+			init_adj_h = spl_fixpt_from_fraction(h_sign, 4);
 			init_adj_v = spl_fixpt_zero;
 			break;
 		case CHROMA_COSITING_NONE:
@@ -961,16 +975,16 @@ static void spl_get_taps_non_adaptive_scaler(
 	 * Max downscale supported is 6.0x.  Add ASSERT to catch if go beyond that
 	 */
 	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz,
-		SPL_NAMESPACE(spl_fixpt_from_fraction(6, 1)));
+		spl_fixpt_from_fraction(6, 1));
 	SPL_ASSERT(check_max_downscale);
 	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert,
-		SPL_NAMESPACE(spl_fixpt_from_fraction(6, 1)));
+		spl_fixpt_from_fraction(6, 1));
 	SPL_ASSERT(check_max_downscale);
 	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz_c,
-		SPL_NAMESPACE(spl_fixpt_from_fraction(6, 1)));
+		spl_fixpt_from_fraction(6, 1));
 	SPL_ASSERT(check_max_downscale);
 	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert_c,
-		SPL_NAMESPACE(spl_fixpt_from_fraction(6, 1)));
+		spl_fixpt_from_fraction(6, 1));
 	SPL_ASSERT(check_max_downscale);
 
 
@@ -1216,39 +1230,39 @@ static void spl_set_manual_ratio_init_data(struct dscl_prog_data *dscl_prog_data
 {
 	struct spl_fixed31_32 bot;
 
-	dscl_prog_data->ratios.h_scale_ratio = SPL_NAMESPACE(spl_fixpt_u3d19(
-			scl_data->ratios.horz)) << 5;
-	dscl_prog_data->ratios.v_scale_ratio = SPL_NAMESPACE(spl_fixpt_u3d19(
-			scl_data->ratios.vert)) << 5;
-	dscl_prog_data->ratios.h_scale_ratio_c = SPL_NAMESPACE(spl_fixpt_u3d19(
-			scl_data->ratios.horz_c)) << 5;
-	dscl_prog_data->ratios.v_scale_ratio_c = SPL_NAMESPACE(spl_fixpt_u3d19(
-			scl_data->ratios.vert_c)) << 5;
+	dscl_prog_data->ratios.h_scale_ratio = spl_fixpt_u3d19(
+			scl_data->ratios.horz) << 5;
+	dscl_prog_data->ratios.v_scale_ratio = spl_fixpt_u3d19(
+			scl_data->ratios.vert) << 5;
+	dscl_prog_data->ratios.h_scale_ratio_c = spl_fixpt_u3d19(
+			scl_data->ratios.horz_c) << 5;
+	dscl_prog_data->ratios.v_scale_ratio_c = spl_fixpt_u3d19(
+			scl_data->ratios.vert_c) << 5;
 	/*
 	 * 0.24 format for fraction, first five bits zeroed
 	 */
 	dscl_prog_data->init.h_filter_init_frac =
-			SPL_NAMESPACE(spl_fixpt_u0d19(scl_data->inits.h)) << 5;
+			spl_fixpt_u0d19(scl_data->inits.h) << 5;
 	dscl_prog_data->init.h_filter_init_int =
 			spl_fixpt_floor(scl_data->inits.h);
 	dscl_prog_data->init.h_filter_init_frac_c =
-			SPL_NAMESPACE(spl_fixpt_u0d19(scl_data->inits.h_c)) << 5;
+			spl_fixpt_u0d19(scl_data->inits.h_c) << 5;
 	dscl_prog_data->init.h_filter_init_int_c =
 			spl_fixpt_floor(scl_data->inits.h_c);
 	dscl_prog_data->init.v_filter_init_frac =
-			SPL_NAMESPACE(spl_fixpt_u0d19(scl_data->inits.v)) << 5;
+			spl_fixpt_u0d19(scl_data->inits.v) << 5;
 	dscl_prog_data->init.v_filter_init_int =
 			spl_fixpt_floor(scl_data->inits.v);
 	dscl_prog_data->init.v_filter_init_frac_c =
-			SPL_NAMESPACE(spl_fixpt_u0d19(scl_data->inits.v_c)) << 5;
+			spl_fixpt_u0d19(scl_data->inits.v_c) << 5;
 	dscl_prog_data->init.v_filter_init_int_c =
 			spl_fixpt_floor(scl_data->inits.v_c);
 
 	bot = spl_fixpt_add(scl_data->inits.v, scl_data->ratios.vert);
-	dscl_prog_data->init.v_filter_init_bot_frac = SPL_NAMESPACE(spl_fixpt_u0d19(bot)) << 5;
+	dscl_prog_data->init.v_filter_init_bot_frac = spl_fixpt_u0d19(bot) << 5;
 	dscl_prog_data->init.v_filter_init_bot_int = spl_fixpt_floor(bot);
 	bot = spl_fixpt_add(scl_data->inits.v_c, scl_data->ratios.vert_c);
-	dscl_prog_data->init.v_filter_init_bot_frac_c = SPL_NAMESPACE(spl_fixpt_u0d19(bot)) << 5;
+	dscl_prog_data->init.v_filter_init_bot_frac_c = spl_fixpt_u0d19(bot) << 5;
 	dscl_prog_data->init.v_filter_init_bot_int_c = spl_fixpt_floor(bot);
 }
 
@@ -1312,31 +1326,31 @@ static void spl_calculate_c0_c3_hdr(struct dscl_prog_data *dscl_prog_data, uint3
 	else
 		hdr_multx100_int = 100; /* default for 80 nits otherwise */
 
-	hdr_mult = SPL_NAMESPACE(spl_fixpt_from_fraction((long long)hdr_multx100_int, 100LL));
-	c0_mult = SPL_NAMESPACE(spl_fixpt_from_fraction(2126LL, 10000LL));
-	c1_mult = SPL_NAMESPACE(spl_fixpt_from_fraction(7152LL, 10000LL));
-	c2_mult = SPL_NAMESPACE(spl_fixpt_from_fraction(722LL, 10000LL));
+	hdr_mult = spl_fixpt_from_fraction((long long)hdr_multx100_int, 100LL);
+	c0_mult = spl_fixpt_from_fraction(2126LL, 10000LL);
+	c1_mult = spl_fixpt_from_fraction(7152LL, 10000LL);
+	c2_mult = spl_fixpt_from_fraction(722LL, 10000LL);
 
-	c0_calc = SPL_NAMESPACE(spl_fixpt_mul(hdr_mult, SPL_NAMESPACE(spl_fixpt_mul(c0_mult,
-		SPL_NAMESPACE(spl_fixpt_from_fraction(16384LL, 125LL))))));
-	c1_calc = SPL_NAMESPACE(spl_fixpt_mul(hdr_mult, SPL_NAMESPACE(spl_fixpt_mul(c1_mult,
-		SPL_NAMESPACE(spl_fixpt_from_fraction(16384LL, 125LL))))));
-	c2_calc = SPL_NAMESPACE(spl_fixpt_mul(hdr_mult, SPL_NAMESPACE(spl_fixpt_mul(c2_mult,
-		SPL_NAMESPACE(spl_fixpt_from_fraction(16384LL, 125LL))))));
+	c0_calc = spl_fixpt_mul(hdr_mult, spl_fixpt_mul(c0_mult,
+		spl_fixpt_from_fraction(16384LL, 125LL)));
+	c1_calc = spl_fixpt_mul(hdr_mult, spl_fixpt_mul(c1_mult,
+		spl_fixpt_from_fraction(16384LL, 125LL)));
+	c2_calc = spl_fixpt_mul(hdr_mult, spl_fixpt_mul(c2_mult,
+		spl_fixpt_from_fraction(16384LL, 125LL)));
 
 	fmt.exponenta_bits = 5;
 	fmt.mantissa_bits = 10;
 	fmt.sign = true;
 
 	// fp1.5.10, C0 coefficient (LN_rec709:  HDR_MULT * 0.212600 * 2^14/125)
-	SPL_NAMESPACE(spl_convert_to_custom_float_format(c0_calc, &fmt,
-		&dscl_prog_data->easf_matrix_c0));
+	spl_convert_to_custom_float_format(c0_calc, &fmt,
+		&dscl_prog_data->easf_matrix_c0);
 	// fp1.5.10, C1 coefficient (LN_rec709:  HDR_MULT * 0.715200 * 2^14/125)
-	SPL_NAMESPACE(spl_convert_to_custom_float_format(c1_calc, &fmt,
-		&dscl_prog_data->easf_matrix_c1));
+	spl_convert_to_custom_float_format(c1_calc, &fmt,
+		&dscl_prog_data->easf_matrix_c1);
 	// fp1.5.10, C2 coefficient (LN_rec709:  HDR_MULT * 0.072200 * 2^14/125)
-	SPL_NAMESPACE(spl_convert_to_custom_float_format(c2_calc, &fmt,
-		&dscl_prog_data->easf_matrix_c2));
+	spl_convert_to_custom_float_format(c2_calc, &fmt,
+		&dscl_prog_data->easf_matrix_c2);
 	dscl_prog_data->easf_matrix_c3 = 0x0; // fp1.5.10, C3 coefficient
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
index a75ab23b0726..66f0e9d971be 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
@@ -367,8 +367,8 @@ static unsigned int spl_calculate_sharpness_level_adj(struct spl_fixed31_32 rati
 	sharpness_level_down_adj = 0;
 	lookup_ptr = sharpness_level_adj;
 	while (j < NUM_SHARPNESS_ADJ_LEVELS) {
-		ratio_level = SPL_NAMESPACE(spl_fixpt_from_fraction(lookup_ptr->ratio_numer,
-			lookup_ptr->ratio_denom));
+		ratio_level = spl_fixpt_from_fraction(lookup_ptr->ratio_numer,
+			lookup_ptr->ratio_denom);
 		if (ratio.value >= ratio_level.value) {
 			sharpness_level_down_adj = lookup_ptr->level_down_adj;
 			break;
@@ -462,7 +462,7 @@ void SPL_NAMESPACE(spl_build_isharp_1dlut_from_reference_curve(
 	unsigned int sharpnessX1000 = spl_calculate_sharpness_level(ratio,
 			sharpness.sharpness_level, setup,
 			sharpness.sharpness_range, scale_to_sharpness_policy);
-	sharp_level = SPL_NAMESPACE(spl_fixpt_from_fraction(sharpnessX1000, 1000));
+	sharp_level = spl_fixpt_from_fraction(sharpnessX1000, 1000);
 
 	/*
 	 * Check if pregen 1dlut table is already precalculated
@@ -487,11 +487,11 @@ void SPL_NAMESPACE(spl_build_isharp_1dlut_from_reference_curve(
 	memset(byte_ptr_1dlut_dst, 0, size_1dlut);
 	for (j = 0; j < size_1dlut; j++) {
 		sharp_base = spl_fixpt_from_int((int)*byte_ptr_1dlut_src);
-		sharp_calc = SPL_NAMESPACE(spl_fixpt_mul(sharp_base, sharp_level));
+		sharp_calc = spl_fixpt_mul(sharp_base, sharp_level);
 		sharp_calc = spl_fixpt_div(sharp_calc, spl_fixpt_from_int(3));
 		sharp_calc = spl_fixpt_min(spl_fixpt_from_int(255), sharp_calc);
 		sharp_calc = spl_fixpt_add(sharp_calc,
-			SPL_NAMESPACE(spl_fixpt_from_fraction(1, 2)));
+			spl_fixpt_from_fraction(1, 2));
 		sharp_calc_int = spl_fixpt_floor(sharp_calc);
 		/* Clamp it at 0x7F so it doesn't wrap */
 		if (sharp_calc_int > 127)
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
index de16ee586073..ffc35041d901 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
@@ -2194,19 +2194,19 @@ static struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt2_offset_lookup[]
 
 static const uint16_t *spl_get_easf_filter_3tap_64p(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
+	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
 		return easf_filter_3tap_64p_ratio_0_30_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
 		return easf_filter_3tap_64p_ratio_0_40_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
 		return easf_filter_3tap_64p_ratio_0_50_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
 		return easf_filter_3tap_64p_ratio_0_60_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
 		return easf_filter_3tap_64p_ratio_0_70_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
 		return easf_filter_3tap_64p_ratio_0_80_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
 		return easf_filter_3tap_64p_ratio_0_90_s1_12;
 	else
 		return easf_filter_3tap_64p_ratio_1_00_s1_12;
@@ -2214,19 +2214,19 @@ static const uint16_t *spl_get_easf_filter_3tap_64p(struct spl_fixed31_32 ratio)
 
 static const uint16_t *spl_get_easf_filter_4tap_64p(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
+	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
 		return easf_filter_4tap_64p_ratio_0_30_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
 		return easf_filter_4tap_64p_ratio_0_40_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
 		return easf_filter_4tap_64p_ratio_0_50_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
 		return easf_filter_4tap_64p_ratio_0_60_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
 		return easf_filter_4tap_64p_ratio_0_70_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
 		return easf_filter_4tap_64p_ratio_0_80_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
 		return easf_filter_4tap_64p_ratio_0_90_s1_12;
 	else
 		return easf_filter_4tap_64p_ratio_1_00_s1_12;
@@ -2234,19 +2234,19 @@ static const uint16_t *spl_get_easf_filter_4tap_64p(struct spl_fixed31_32 ratio)
 
 static const uint16_t *spl_get_easf_filter_6tap_64p(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
+	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
 		return easf_filter_6tap_64p_ratio_0_30_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
 		return easf_filter_6tap_64p_ratio_0_40_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
 		return easf_filter_6tap_64p_ratio_0_50_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
 		return easf_filter_6tap_64p_ratio_0_60_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
 		return easf_filter_6tap_64p_ratio_0_70_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
 		return easf_filter_6tap_64p_ratio_0_80_s1_12;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
 		return easf_filter_6tap_64p_ratio_0_90_s1_12;
 	else
 		return easf_filter_6tap_64p_ratio_1_00_s1_12;
@@ -2270,19 +2270,19 @@ const uint16_t *SPL_NAMESPACE(spl_dscl_get_easf_filter_coeffs_64p(
 
 static const uint16_t *spl_get_easf_filter_3tap_64p_s1_10(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
+	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
 		return easf_filter_3tap_64p_ratio_0_30;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
 		return easf_filter_3tap_64p_ratio_0_40;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
 		return easf_filter_3tap_64p_ratio_0_50;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
 		return easf_filter_3tap_64p_ratio_0_60;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
 		return easf_filter_3tap_64p_ratio_0_70;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
 		return easf_filter_3tap_64p_ratio_0_80;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
 		return easf_filter_3tap_64p_ratio_0_90;
 	else
 		return easf_filter_3tap_64p_ratio_1_00;
@@ -2290,19 +2290,19 @@ static const uint16_t *spl_get_easf_filter_3tap_64p_s1_10(struct spl_fixed31_32
 
 static const uint16_t *spl_get_easf_filter_4tap_64p_s1_10(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
+	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
 		return easf_filter_4tap_64p_ratio_0_30;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
 		return easf_filter_4tap_64p_ratio_0_40;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
 		return easf_filter_4tap_64p_ratio_0_50;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
 		return easf_filter_4tap_64p_ratio_0_60;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
 		return easf_filter_4tap_64p_ratio_0_70;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
 		return easf_filter_4tap_64p_ratio_0_80;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
 		return easf_filter_4tap_64p_ratio_0_90;
 	else
 		return easf_filter_4tap_64p_ratio_1_00;
@@ -2310,19 +2310,19 @@ static const uint16_t *spl_get_easf_filter_4tap_64p_s1_10(struct spl_fixed31_32
 
 static const uint16_t *spl_get_easf_filter_6tap_64p_s1_10(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
+	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
 		return easf_filter_6tap_64p_ratio_0_30;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
 		return easf_filter_6tap_64p_ratio_0_40;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
 		return easf_filter_6tap_64p_ratio_0_50;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
 		return easf_filter_6tap_64p_ratio_0_60;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
 		return easf_filter_6tap_64p_ratio_0_70;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
 		return easf_filter_6tap_64p_ratio_0_80;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
 		return easf_filter_6tap_64p_ratio_0_90;
 	else
 		return easf_filter_6tap_64p_ratio_1_00;
@@ -2397,9 +2397,9 @@ static uint32_t spl_easf_get_scale_ratio_to_reg_value(struct spl_fixed31_32 rati
 		if (lookup_table_index_ptr->numer < 0)
 			break;
 
-		if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(
+		if (ratio.value < spl_fixpt_from_fraction(
 			lookup_table_index_ptr->numer,
-			lookup_table_index_ptr->denom)).value) {
+			lookup_table_index_ptr->denom).value) {
 			value = lookup_table_index_ptr->reg_value;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
index 2d73d0dce5ff..b6306c33378a 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
@@ -1134,9 +1134,9 @@ static const uint16_t *spl_get_filter_3tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_3tap_64p_upscale;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
 		return filter_3tap_64p_116;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
 		return filter_3tap_64p_149;
 	else
 		return filter_3tap_64p_183;
@@ -1146,9 +1146,9 @@ static const uint16_t *spl_get_filter_4tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_4tap_64p_upscale;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
 		return filter_4tap_64p_116;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
 		return filter_4tap_64p_149;
 	else
 		return filter_4tap_64p_183;
@@ -1158,9 +1158,9 @@ static const uint16_t *spl_get_filter_5tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_5tap_64p_upscale;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
 		return filter_5tap_64p_116;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
 		return filter_5tap_64p_149;
 	else
 		return filter_5tap_64p_183;
@@ -1170,9 +1170,9 @@ static const uint16_t *spl_get_filter_6tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_6tap_64p_upscale;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
 		return filter_6tap_64p_116;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
 		return filter_6tap_64p_149;
 	else
 		return filter_6tap_64p_183;
@@ -1182,9 +1182,9 @@ static const uint16_t *spl_get_filter_7tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_7tap_64p_upscale;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
 		return filter_7tap_64p_116;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
 		return filter_7tap_64p_149;
 	else
 		return filter_7tap_64p_183;
@@ -1194,9 +1194,9 @@ static const uint16_t *spl_get_filter_8tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_8tap_64p_upscale;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
 		return filter_8tap_64p_116;
-	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
+	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
 		return filter_8tap_64p_149;
 	else
 		return filter_8tap_64p_183;
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index b24f1ef3fe17..1f14f1b6e084 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -7,8 +7,64 @@
 
 #include "spl_debug.h"
 #include "spl_os_types.h"   // swap
-#include "spl_fixpt31_32.h"	// fixed31_32 and related functions
-#include "spl_custom_float.h" // custom float and related functions
+
+/*
+ * Fixed-point (spl_fixpt_*) and custom-float (spl_custom_float_*) are provided
+ * by parent repo.  The spl_* API is aliased onto the parent repo's own
+ * fixed-point and custom-float implementation; both share the same
+ * "struct fixed31_32" / "struct custom_float_format".
+ */
+
+#include "os_types.h"   /* ASSERT, div64_u64_rem, div64_s64, swap */
+
+#include "fixed31_32.h"
+
+#define spl_fixed31_32          fixed31_32
+
+#define spl_fixpt_zero          dc_fixpt_zero
+#define spl_fixpt_epsilon       dc_fixpt_epsilon
+#define spl_fixpt_half          dc_fixpt_half
+#define spl_fixpt_one           dc_fixpt_one
+
+#define spl_fixpt_from_fraction dc_fixpt_from_fraction
+#define spl_fixpt_from_int      dc_fixpt_from_int
+#define spl_fixpt_neg           dc_fixpt_neg
+#define spl_fixpt_abs           dc_fixpt_abs
+#define spl_fixpt_lt            dc_fixpt_lt
+#define spl_fixpt_le            dc_fixpt_le
+#define spl_fixpt_eq            dc_fixpt_eq
+#define spl_fixpt_min           dc_fixpt_min
+#define spl_fixpt_max           dc_fixpt_max
+#define spl_fixpt_clamp         dc_fixpt_clamp
+#define spl_fixpt_shl           dc_fixpt_shl
+#define spl_fixpt_shr           dc_fixpt_shr
+#define spl_fixpt_add           dc_fixpt_add
+#define spl_fixpt_add_int       dc_fixpt_add_int
+#define spl_fixpt_sub           dc_fixpt_sub
+#define spl_fixpt_sub_int       dc_fixpt_sub_int
+#define spl_fixpt_mul           dc_fixpt_mul
+#define spl_fixpt_mul_int       dc_fixpt_mul_int
+#define spl_fixpt_sqr           dc_fixpt_sqr
+#define spl_fixpt_div_int       dc_fixpt_div_int
+#define spl_fixpt_div           dc_fixpt_div
+#define spl_fixpt_recip         dc_fixpt_recip
+#define spl_fixpt_sinc          dc_fixpt_sinc
+#define spl_fixpt_sin           dc_fixpt_sin
+#define spl_fixpt_cos           dc_fixpt_cos
+#define spl_fixpt_exp           dc_fixpt_exp
+#define spl_fixpt_log           dc_fixpt_log
+#define spl_fixpt_pow           dc_fixpt_pow
+#define spl_fixpt_floor         dc_fixpt_floor
+#define spl_fixpt_round         dc_fixpt_round
+#define spl_fixpt_ceil          dc_fixpt_ceil
+#define spl_fixpt_u4d19         dc_fixpt_u4d19
+#define spl_fixpt_u3d19         dc_fixpt_u3d19
+#define spl_fixpt_u2d19         dc_fixpt_u2d19
+#define spl_fixpt_u0d19         dc_fixpt_u0d19
+#define spl_fixpt_clamp_u0d14   dc_fixpt_clamp_u0d14
+#define spl_fixpt_clamp_u0d10   dc_fixpt_clamp_u0d10
+#define spl_fixpt_s4d19         dc_fixpt_s4d19
+#define spl_fixpt_truncate      dc_fixpt_truncate
 
 struct spl_size {
 	uint32_t width;
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
deleted file mode 100644
index 0700b3dbbda7..000000000000
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
+++ /dev/null
@@ -1,152 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
-
-#include "spl_debug.h"
-#include "spl_custom_float.h"
-
-static bool spl_build_custom_float(struct spl_fixed31_32 value,
-			       const struct spl_custom_float_format *format,
-			       bool *negative,
-			       uint32_t *mantissa,
-			       uint32_t *exponenta)
-{
-	uint32_t exp_offset = (1 << (format->exponenta_bits - 1)) - 1;
-
-	const struct spl_fixed31_32 mantissa_constant_plus_max_fraction =
-		SPL_NAMESPACE(spl_fixpt_from_fraction((1LL << (format->mantissa_bits + 1)) - 1,
-				       1LL << format->mantissa_bits));
-
-	struct spl_fixed31_32 mantiss;
-
-	if (spl_fixpt_eq(value, spl_fixpt_zero)) {
-		*negative = false;
-		*mantissa = 0;
-		*exponenta = 0;
-		return true;
-	}
-
-	if (spl_fixpt_lt(value, spl_fixpt_zero)) {
-		*negative = format->sign;
-		value = spl_fixpt_neg(value);
-	} else {
-		*negative = false;
-	}
-
-	if (spl_fixpt_lt(value, spl_fixpt_one)) {
-		uint32_t i = 1;
-
-		do {
-			value = spl_fixpt_shl(value, 1);
-			++i;
-		} while (spl_fixpt_lt(value, spl_fixpt_one));
-
-		--i;
-
-		if (exp_offset <= i) {
-			*mantissa = 0;
-			*exponenta = 0;
-			return true;
-		}
-
-		*exponenta = exp_offset - i;
-	} else if (spl_fixpt_le(mantissa_constant_plus_max_fraction, value)) {
-		uint32_t i = 1;
-
-		do {
-			value = spl_fixpt_shr(value, 1);
-			++i;
-		} while (spl_fixpt_lt(mantissa_constant_plus_max_fraction, value));
-
-		*exponenta = exp_offset + i - 1;
-	} else {
-		*exponenta = exp_offset;
-	}
-
-	mantiss = spl_fixpt_sub(value, spl_fixpt_one);
-
-	if (spl_fixpt_lt(mantiss, spl_fixpt_zero) ||
-	    spl_fixpt_lt(spl_fixpt_one, mantiss))
-		mantiss = spl_fixpt_zero;
-	else
-		mantiss = spl_fixpt_shl(mantiss, format->mantissa_bits);
-
-	*mantissa = spl_fixpt_floor(mantiss);
-
-	return true;
-}
-
-static bool spl_setup_custom_float(const struct spl_custom_float_format *format,
-			       bool negative,
-			       uint32_t mantissa,
-			       uint32_t exponenta,
-			       uint32_t *result)
-{
-	uint32_t i = 0;
-	uint32_t j = 0;
-	uint32_t value = 0;
-
-	/* verification code:
-	 * once calculation is ok we can remove it
-	 */
-
-	const uint32_t mantissa_mask =
-		(1 << (format->mantissa_bits + 1)) - 1;
-
-	const uint32_t exponenta_mask =
-		(1 << (format->exponenta_bits + 1)) - 1;
-
-	if (mantissa & ~mantissa_mask) {
-		SPL_BREAK_TO_DEBUGGER();
-		mantissa = mantissa_mask;
-	}
-
-	if (exponenta & ~exponenta_mask) {
-		SPL_BREAK_TO_DEBUGGER();
-		exponenta = exponenta_mask;
-	}
-
-	/* end of verification code */
-
-	while (i < format->mantissa_bits) {
-		uint32_t mask = 1 << i;
-
-		if (mantissa & mask)
-			value |= mask;
-
-		++i;
-	}
-
-	while (j < format->exponenta_bits) {
-		uint32_t mask = 1 << j;
-
-		if (exponenta & mask)
-			value |= mask << i;
-
-		++j;
-	}
-
-	if (negative && format->sign)
-		value |= 1 << (i + j);
-
-	*result = value;
-
-	return true;
-}
-
-bool SPL_NAMESPACE(spl_convert_to_custom_float_format(
-	struct spl_fixed31_32 value,
-	const struct spl_custom_float_format *format,
-	uint32_t *result))
-{
-	uint32_t mantissa;
-	uint32_t exponenta;
-	bool negative;
-
-	return spl_build_custom_float(value, format, &negative, &mantissa, &exponenta) &&
-				  spl_setup_custom_float(format,
-						     negative,
-						     mantissa,
-						     exponenta,
-						     result);
-}
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
deleted file mode 100644
index f3fd8d30e638..000000000000
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-
-/* Copyright 2024 Advanced Micro Devices, Inc. */
-
-#ifndef SPL_CUSTOM_FLOAT_H_
-#define SPL_CUSTOM_FLOAT_H_
-
-#include "spl_os_types.h"
-#include "spl_fixpt31_32.h"
-
-struct spl_custom_float_format {
-	uint32_t mantissa_bits;
-	uint32_t exponenta_bits;
-	bool sign;
-};
-
-struct spl_custom_float_value {
-	uint32_t mantissa;
-	uint32_t exponenta;
-	uint32_t value;
-	bool negative;
-};
-
-bool SPL_NAMESPACE(spl_convert_to_custom_float_format(
-	struct spl_fixed31_32 value,
-	const struct spl_custom_float_format *format,
-	uint32_t *result));
-
-#endif //SPL_CUSTOM_FLOAT_H_
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
deleted file mode 100644
index ff0bdc3c33c8..000000000000
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
+++ /dev/null
@@ -1,495 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
-
-#include "spl_fixpt31_32.h"
-
-static const struct spl_fixed31_32 spl_fixpt_two_pi = { 26986075409LL };
-static const struct spl_fixed31_32 spl_fixpt_ln2 = { 2977044471LL };
-static const struct spl_fixed31_32 spl_fixpt_ln2_div_2 = { 1488522236LL };
-
-static inline unsigned long long abs_i64(
-	long long arg)
-{
-	if (arg > 0)
-		return (unsigned long long)arg;
-	else
-		return (unsigned long long)(-arg);
-}
-
-/*
- * @brief
- * result = dividend / divisor
- * *remainder = dividend % divisor
- */
-static inline unsigned long long spl_complete_integer_division_u64(
-	unsigned long long dividend,
-	unsigned long long divisor,
-	unsigned long long *remainder)
-{
-	unsigned long long result;
-
-	result = spl_div64_u64_rem(dividend, divisor, remainder);
-
-	return result;
-}
-
-
-#define FRACTIONAL_PART_MASK \
-	((1ULL << FIXED31_32_BITS_PER_FRACTIONAL_PART) - 1)
-
-#define GET_INTEGER_PART(x) \
-	((x) >> FIXED31_32_BITS_PER_FRACTIONAL_PART)
-
-#define GET_FRACTIONAL_PART(x) \
-	(FRACTIONAL_PART_MASK & (x))
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_fraction(
-	long long numerator, long long denominator))
-{
-	struct spl_fixed31_32 res;
-
-	bool arg1_negative = numerator < 0;
-	bool arg2_negative = denominator < 0;
-
-	unsigned long long arg1_value = arg1_negative ? -numerator : numerator;
-	unsigned long long arg2_value = arg2_negative ? -denominator : denominator;
-
-	unsigned long long remainder;
-
-	/* determine integer part */
-
-	unsigned long long res_value = spl_complete_integer_division_u64(
-		arg1_value, arg2_value, &remainder);
-
-	SPL_ASSERT(res_value <= (unsigned long long)LONG_MAX);
-
-	/* determine fractional part */
-	{
-		unsigned int i = FIXED31_32_BITS_PER_FRACTIONAL_PART;
-
-		do {
-			remainder <<= 1;
-
-			res_value <<= 1;
-
-			if (remainder >= arg2_value) {
-				res_value |= 1;
-				remainder -= arg2_value;
-			}
-		} while (--i != 0);
-	}
-
-	/* round up LSB */
-	{
-		unsigned long long summand = (remainder << 1) >= arg2_value;
-
-		SPL_ASSERT(res_value <= (unsigned long long)LLONG_MAX - summand);
-
-		res_value += summand;
-	}
-
-	res.value = (long long)res_value;
-
-	if (arg1_negative ^ arg2_negative)
-		res.value = -res.value;
-
-	return res;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_mul(
-	struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2))
-{
-	struct spl_fixed31_32 res;
-
-	bool arg1_negative = arg1.value < 0;
-	bool arg2_negative = arg2.value < 0;
-
-	unsigned long long arg1_value = arg1_negative ? -arg1.value : arg1.value;
-	unsigned long long arg2_value = arg2_negative ? -arg2.value : arg2.value;
-
-	unsigned long long arg1_int = GET_INTEGER_PART(arg1_value);
-	unsigned long long arg2_int = GET_INTEGER_PART(arg2_value);
-
-	unsigned long long arg1_fra = GET_FRACTIONAL_PART(arg1_value);
-	unsigned long long arg2_fra = GET_FRACTIONAL_PART(arg2_value);
-
-	unsigned long long tmp;
-
-	res.value = arg1_int * arg2_int;
-
-	SPL_ASSERT(res.value <= (long long)LONG_MAX);
-
-	res.value <<= FIXED31_32_BITS_PER_FRACTIONAL_PART;
-
-	tmp = arg1_int * arg2_fra;
-
-	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
-
-	res.value += tmp;
-
-	tmp = arg2_int * arg1_fra;
-
-	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
-
-	res.value += tmp;
-
-	tmp = arg1_fra * arg2_fra;
-
-	tmp = (tmp >> FIXED31_32_BITS_PER_FRACTIONAL_PART) +
-		(tmp >= (unsigned long long)spl_fixpt_half.value);
-
-	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
-
-	res.value += tmp;
-
-	if (arg1_negative ^ arg2_negative)
-		res.value = -res.value;
-
-	return res;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sqr(struct spl_fixed31_32 arg))
-{
-	struct spl_fixed31_32 res;
-
-	unsigned long long arg_value = abs_i64(arg.value);
-
-	unsigned long long arg_int = GET_INTEGER_PART(arg_value);
-
-	unsigned long long arg_fra = GET_FRACTIONAL_PART(arg_value);
-
-	unsigned long long tmp;
-
-	res.value = arg_int * arg_int;
-
-	SPL_ASSERT(res.value <= (long long)LONG_MAX);
-
-	res.value <<= FIXED31_32_BITS_PER_FRACTIONAL_PART;
-
-	tmp = arg_int * arg_fra;
-
-	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
-
-	res.value += tmp;
-
-	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
-
-	res.value += tmp;
-
-	tmp = arg_fra * arg_fra;
-
-	tmp = (tmp >> FIXED31_32_BITS_PER_FRACTIONAL_PART) +
-		(tmp >= (unsigned long long)spl_fixpt_half.value);
-
-	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
-
-	res.value += tmp;
-
-	return res;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_recip(struct spl_fixed31_32 arg))
-{
-	/*
-	 * @note
-	 * Good idea to use Newton's method
-	 */
-
-	return SPL_NAMESPACE(spl_fixpt_from_fraction(
-		spl_fixpt_one.value,
-		arg.value));
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sinc(struct spl_fixed31_32 arg))
-{
-	struct spl_fixed31_32 square;
-
-	struct spl_fixed31_32 res = spl_fixpt_one;
-
-	int n = 27;
-
-	struct spl_fixed31_32 arg_norm = arg;
-
-	if (spl_fixpt_le(
-		spl_fixpt_two_pi,
-		spl_fixpt_abs(arg))) {
-		arg_norm = spl_fixpt_sub(
-			arg_norm,
-			spl_fixpt_mul_int(
-				spl_fixpt_two_pi,
-				(int)spl_div64_s64(
-					arg_norm.value,
-					spl_fixpt_two_pi.value)));
-	}
-
-	square = SPL_NAMESPACE(spl_fixpt_sqr(arg_norm));
-
-	do {
-		res = spl_fixpt_sub(
-			spl_fixpt_one,
-			spl_fixpt_div_int(
-				SPL_NAMESPACE(spl_fixpt_mul(
-					square,
-					res)),
-				n * (n - 1)));
-
-		n -= 2;
-	} while (n > 2);
-
-	if (arg.value != arg_norm.value)
-		res = spl_fixpt_div(
-			SPL_NAMESPACE(spl_fixpt_mul(res, arg_norm)),
-			arg);
-
-	return res;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sin(struct spl_fixed31_32 arg))
-{
-	return SPL_NAMESPACE(spl_fixpt_mul(
-		arg,
-		SPL_NAMESPACE(spl_fixpt_sinc(arg))));
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_cos(struct spl_fixed31_32 arg))
-{
-	/* TODO implement argument normalization */
-
-	const struct spl_fixed31_32 square = SPL_NAMESPACE(spl_fixpt_sqr(arg));
-
-	struct spl_fixed31_32 res = spl_fixpt_one;
-
-	int n = 26;
-
-	do {
-		res = spl_fixpt_sub(
-			spl_fixpt_one,
-			spl_fixpt_div_int(
-				SPL_NAMESPACE(spl_fixpt_mul(
-					square,
-					res)),
-				n * (n - 1)));
-
-		n -= 2;
-	} while (n != 0);
-
-	return res;
-}
-
-/*
- * @brief
- * result = exp(arg),
- * where abs(arg) < 1
- *
- * Calculated as Taylor series.
- */
-static struct spl_fixed31_32 spl_fixed31_32_exp_from_taylor_series(struct spl_fixed31_32 arg)
-{
-	unsigned int n = 9;
-
-	struct spl_fixed31_32 res = SPL_NAMESPACE(spl_fixpt_from_fraction(
-		n + 2,
-		n + 1));
-	/* TODO find correct res */
-
-	SPL_ASSERT(spl_fixpt_lt(arg, spl_fixpt_one));
-
-	do
-		res = spl_fixpt_add(
-			spl_fixpt_one,
-			spl_fixpt_div_int(
-				SPL_NAMESPACE(spl_fixpt_mul(
-					arg,
-					res)),
-				n));
-	while (--n != 1);
-
-	return spl_fixpt_add(
-		spl_fixpt_one,
-		SPL_NAMESPACE(spl_fixpt_mul(
-			arg,
-			res)));
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_exp(struct spl_fixed31_32 arg))
-{
-	/*
-	 * @brief
-	 * Main equation is:
-	 * exp(x) = exp(r + m * ln(2)) = (1 << m) * exp(r),
-	 * where m = round(x / ln(2)), r = x - m * ln(2)
-	 */
-
-	if (spl_fixpt_le(
-		spl_fixpt_ln2_div_2,
-		spl_fixpt_abs(arg))) {
-		int m = spl_fixpt_round(
-			spl_fixpt_div(
-				arg,
-				spl_fixpt_ln2));
-
-		struct spl_fixed31_32 r = spl_fixpt_sub(
-			arg,
-			spl_fixpt_mul_int(
-				spl_fixpt_ln2,
-				m));
-
-		SPL_ASSERT(m != 0);
-
-		SPL_ASSERT(spl_fixpt_lt(
-			spl_fixpt_abs(r),
-			spl_fixpt_one));
-
-		if (m > 0)
-			return spl_fixpt_shl(
-				spl_fixed31_32_exp_from_taylor_series(r),
-				(unsigned int)m);
-		else
-			return spl_fixpt_div_int(
-				spl_fixed31_32_exp_from_taylor_series(r),
-				1LL << -m);
-	} else if (arg.value != 0)
-		return spl_fixed31_32_exp_from_taylor_series(arg);
-	else
-		return spl_fixpt_one;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_log(struct spl_fixed31_32 arg))
-{
-	struct spl_fixed31_32 res = spl_fixpt_neg(spl_fixpt_one);
-	/* TODO improve 1st estimation */
-
-	struct spl_fixed31_32 error;
-
-	SPL_ASSERT(arg.value > 0);
-	/* TODO if arg is negative, return NaN */
-	/* TODO if arg is zero, return -INF */
-
-	do {
-		struct spl_fixed31_32 res1 = spl_fixpt_add(
-			spl_fixpt_sub(
-				res,
-				spl_fixpt_one),
-			spl_fixpt_div(
-				arg,
-				SPL_NAMESPACE(spl_fixpt_exp(res))));
-
-		error = spl_fixpt_sub(
-			res,
-			res1);
-
-		res = res1;
-		/* TODO determine max_allowed_error based on quality of exp() */
-	} while (abs_i64(error.value) > 100ULL);
-
-	return res;
-}
-
-
-/* this function is a generic helper to translate fixed point value to
- * specified integer format that will consist of integer_bits integer part and
- * fractional_bits fractional part. For example it is used in
- * spl_fixpt_u2d19 to receive 2 bits integer part and 19 bits fractional
- * part in 32 bits. It is used in hw programming (scaler)
- */
-
-static inline unsigned int spl_ux_dy(
-	long long value,
-	unsigned int integer_bits,
-	unsigned int fractional_bits)
-{
-	/* 1. create mask of integer part */
-	unsigned int result = (1 << integer_bits) - 1;
-	/* 2. mask out fractional part */
-	unsigned int fractional_part = FRACTIONAL_PART_MASK & value;
-	/* 3. shrink fixed point integer part to be of integer_bits width*/
-	result &= GET_INTEGER_PART(value);
-	/* 4. make space for fractional part to be filled in after integer */
-	result <<= fractional_bits;
-	/* 5. shrink fixed point fractional part to of fractional_bits width*/
-	fractional_part >>= FIXED31_32_BITS_PER_FRACTIONAL_PART - fractional_bits;
-	/* 6. merge the result */
-	return result | fractional_part;
-}
-
-static inline unsigned int spl_clamp_ux_dy(
-	long long value,
-	unsigned int integer_bits,
-	unsigned int fractional_bits,
-	unsigned int min_clamp)
-{
-	unsigned int truncated_val = spl_ux_dy(value, integer_bits, fractional_bits);
-
-	if (value >= (1LL << (integer_bits + FIXED31_32_BITS_PER_FRACTIONAL_PART)))
-		return (1 << (integer_bits + fractional_bits)) - 1;
-	else if (truncated_val > min_clamp)
-		return truncated_val;
-	else
-		return min_clamp;
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u4d19(struct spl_fixed31_32 arg))
-{
-	return spl_ux_dy(arg.value, 4, 19);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u3d19(struct spl_fixed31_32 arg))
-{
-	return spl_ux_dy(arg.value, 3, 19);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u2d19(struct spl_fixed31_32 arg))
-{
-	return spl_ux_dy(arg.value, 2, 19);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u0d19(struct spl_fixed31_32 arg))
-{
-	return spl_ux_dy(arg.value, 0, 19);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d14(struct spl_fixed31_32 arg))
-{
-	return spl_clamp_ux_dy(arg.value, 0, 14, 1);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d10(struct spl_fixed31_32 arg))
-{
-	return spl_clamp_ux_dy(arg.value, 0, 10, 1);
-}
-
-int SPL_NAMESPACE(spl_fixpt_s4d19(struct spl_fixed31_32 arg))
-{
-	if (arg.value < 0)
-		return -(int)spl_ux_dy(spl_fixpt_abs(arg).value, 4, 19);
-	else
-		return spl_ux_dy(arg.value, 4, 19);
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_ux_dy(unsigned int value,
-	unsigned int integer_bits,
-	unsigned int fractional_bits))
-{
-	struct spl_fixed31_32 fixpt_value = spl_fixpt_zero;
-	struct spl_fixed31_32 fixpt_int_value = spl_fixpt_zero;
-	long long frac_mask = ((long long)1 << (long long)integer_bits) - 1;
-
-	fixpt_value.value = (long long)value << (FIXED31_32_BITS_PER_FRACTIONAL_PART - fractional_bits);
-	frac_mask = frac_mask << fractional_bits;
-	fixpt_int_value.value = value & frac_mask;
-	fixpt_int_value.value <<= (FIXED31_32_BITS_PER_FRACTIONAL_PART - fractional_bits);
-	fixpt_value.value |= fixpt_int_value.value;
-	return fixpt_value;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_int_dy(unsigned int int_value,
-	unsigned int frac_value,
-	unsigned int integer_bits,
-	unsigned int fractional_bits))
-{
-	struct spl_fixed31_32 fixpt_value = spl_fixpt_from_int(int_value);
-
-	fixpt_value.value |= (long long)frac_value << (FIXED31_32_BITS_PER_FRACTIONAL_PART - fractional_bits);
-	return fixpt_value;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
deleted file mode 100644
index b0e639d6e97d..000000000000
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
+++ /dev/null
@@ -1,526 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-
-/* Copyright 2024 Advanced Micro Devices, Inc. */
-
-#ifndef __SPL_FIXED31_32_H__
-#define __SPL_FIXED31_32_H__
-
-#include "spl_debug.h"
-#include "spl_os_types.h"   // swap
-
-#ifndef LLONG_MAX
-#define LLONG_MAX 9223372036854775807ll
-#endif
-#ifndef LLONG_MIN
-#define LLONG_MIN (-LLONG_MAX - 1ll)
-#endif
-
-#define FIXED31_32_BITS_PER_FRACTIONAL_PART 32
-#ifndef LLONG_MIN
-#define LLONG_MIN (1LL<<63)
-#endif
-#ifndef LLONG_MAX
-#define LLONG_MAX (-1LL>>1)
-#endif
-
-/*
- * @brief
- * Arithmetic operations on real numbers
- * represented as fixed-point numbers.
- * There are: 1 bit for sign,
- * 31 bit for integer part,
- * 32 bits for fractional part.
- *
- * @note
- * Currently, overflows and underflows are asserted;
- * no special result returned.
- */
-
-struct spl_fixed31_32 {
-	long long value;
-};
-
-
-/*
- * @brief
- * Useful constants
- */
-
-static const struct spl_fixed31_32 spl_fixpt_zero = { 0 };
-static const struct spl_fixed31_32 spl_fixpt_epsilon = { 1LL };
-static const struct spl_fixed31_32 spl_fixpt_half = { 0x80000000LL };
-static const struct spl_fixed31_32 spl_fixpt_one = { 0x100000000LL };
-
-/*
- * @brief
- * Initialization routines
- */
-
-/*
- * @brief
- * result = numerator / denominator
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_fraction(
-	long long numerator, long long denominator));
-
-/*
- * @brief
- * result = arg
- */
-static inline struct spl_fixed31_32 spl_fixpt_from_int(int arg)
-{
-	struct spl_fixed31_32 res;
-
-	res.value = (long long) arg << FIXED31_32_BITS_PER_FRACTIONAL_PART;
-
-	return res;
-}
-
-/*
- * @brief
- * Unary operators
- */
-
-/*
- * @brief
- * result = -arg
- */
-static inline struct spl_fixed31_32 spl_fixpt_neg(struct spl_fixed31_32 arg)
-{
-	struct spl_fixed31_32 res;
-
-	res.value = -arg.value;
-
-	return res;
-}
-
-/*
- * @brief
- * result = abs(arg) := (arg >= 0) ? arg : -arg
- */
-static inline struct spl_fixed31_32 spl_fixpt_abs(struct spl_fixed31_32 arg)
-{
-	if (arg.value < 0)
-		return spl_fixpt_neg(arg);
-	else
-		return arg;
-}
-
-/*
- * @brief
- * Binary relational operators
- */
-
-/*
- * @brief
- * result = arg1 < arg2
- */
-static inline bool spl_fixpt_lt(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
-{
-	return arg1.value < arg2.value;
-}
-
-/*
- * @brief
- * result = arg1 <= arg2
- */
-static inline bool spl_fixpt_le(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
-{
-	return arg1.value <= arg2.value;
-}
-
-/*
- * @brief
- * result = arg1 == arg2
- */
-static inline bool spl_fixpt_eq(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
-{
-	return arg1.value == arg2.value;
-}
-
-/*
- * @brief
- * result = min(arg1, arg2) := (arg1 <= arg2) ? arg1 : arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_min(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
-{
-	if (arg1.value <= arg2.value)
-		return arg1;
-	else
-		return arg2;
-}
-
-/*
- * @brief
- * result = max(arg1, arg2) := (arg1 <= arg2) ? arg2 : arg1
- */
-static inline struct spl_fixed31_32 spl_fixpt_max(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
-{
-	if (arg1.value <= arg2.value)
-		return arg2;
-	else
-		return arg1;
-}
-
-/*
- * @brief
- *          | min_value, when arg <= min_value
- * result = | arg, when min_value < arg < max_value
- *          | max_value, when arg >= max_value
- */
-static inline struct spl_fixed31_32 spl_fixpt_clamp(
-	struct spl_fixed31_32 arg,
-	struct spl_fixed31_32 min_value,
-	struct spl_fixed31_32 max_value)
-{
-	if (spl_fixpt_le(arg, min_value))
-		return min_value;
-	else if (spl_fixpt_le(max_value, arg))
-		return max_value;
-	else
-		return arg;
-}
-
-/*
- * @brief
- * Binary shift operators
- */
-
-/*
- * @brief
- * result = arg << shift
- */
-static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned int shift)
-{
-	SPL_ASSERT(((arg.value >= 0) && (arg.value <= LLONG_MAX >> shift)) ||
-		((arg.value < 0) && (arg.value >= ~(LLONG_MAX >> shift))));
-
-	arg.value = arg.value << shift;
-
-	return arg;
-}
-
-/*
- * @brief
- * result = arg >> shift
- */
-static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 arg, unsigned int shift)
-{
-	bool negative = arg.value < 0;
-
-	if (negative)
-		arg.value = -arg.value;
-	arg.value = arg.value >> shift;
-	if (negative)
-		arg.value = -arg.value;
-	return arg;
-}
-
-/*
- * @brief
- * Binary additive operators
- */
-
-/*
- * @brief
- * result = arg1 + arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_add(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
-{
-	struct spl_fixed31_32 res;
-
-	SPL_ASSERT(((arg1.value >= 0) && (LLONG_MAX - arg1.value >= arg2.value)) ||
-		((arg1.value < 0) && (LLONG_MIN - arg1.value <= arg2.value)));
-
-	res.value = arg1.value + arg2.value;
-
-	return res;
-}
-
-/*
- * @brief
- * result = arg1 + arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_add_int(struct spl_fixed31_32 arg1, int arg2)
-{
-	return spl_fixpt_add(arg1, spl_fixpt_from_int(arg2));
-}
-
-/*
- * @brief
- * result = arg1 - arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_sub(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
-{
-	struct spl_fixed31_32 res;
-
-	SPL_ASSERT(((arg2.value >= 0) && (LLONG_MIN + arg2.value <= arg1.value)) ||
-		((arg2.value < 0) && (LLONG_MAX + arg2.value >= arg1.value)));
-
-	res.value = arg1.value - arg2.value;
-
-	return res;
-}
-
-/*
- * @brief
- * result = arg1 - arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_sub_int(struct spl_fixed31_32 arg1, int arg2)
-{
-	return spl_fixpt_sub(arg1, spl_fixpt_from_int(arg2));
-}
-
-
-/*
- * @brief
- * Binary multiplicative operators
- */
-
-/*
- * @brief
- * result = arg1 * arg2
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_mul(
-	struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2));
-
-
-/*
- * @brief
- * result = arg1 * arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_mul_int(struct spl_fixed31_32 arg1, int arg2)
-{
-	return SPL_NAMESPACE(spl_fixpt_mul(arg1, spl_fixpt_from_int(arg2)));
-}
-
-/*
- * @brief
- * result = square(arg) := arg * arg
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sqr(struct spl_fixed31_32 arg));
-
-/*
- * @brief
- * result = arg1 / arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_div_int(struct spl_fixed31_32 arg1, long long arg2)
-{
-	return SPL_NAMESPACE(spl_fixpt_from_fraction(arg1.value,
-		spl_fixpt_from_int((int)arg2).value));
-}
-
-/*
- * @brief
- * result = arg1 / arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_div(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
-{
-	return SPL_NAMESPACE(spl_fixpt_from_fraction(arg1.value, arg2.value));
-}
-
-/*
- * @brief
- * Reciprocal function
- */
-
-/*
- * @brief
- * result = reciprocal(arg) := 1 / arg
- *
- * @note
- * No special actions taken in case argument is zero.
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_recip(struct spl_fixed31_32 arg));
-
-/*
- * @brief
- * Trigonometric functions
- */
-
-/*
- * @brief
- * result = sinc(arg) := sin(arg) / arg
- *
- * @note
- * Argument specified in radians,
- * internally it's normalized to [-2pi...2pi] range.
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sinc(struct spl_fixed31_32 arg));
-
-/*
- * @brief
- * result = sin(arg)
- *
- * @note
- * Argument specified in radians,
- * internally it's normalized to [-2pi...2pi] range.
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sin(struct spl_fixed31_32 arg));
-
-/*
- * @brief
- * result = cos(arg)
- *
- * @note
- * Argument specified in radians
- * and should be in [-2pi...2pi] range -
- * passing arguments outside that range
- * will cause incorrect result!
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_cos(struct spl_fixed31_32 arg));
-
-/*
- * @brief
- * Transcendent functions
- */
-
-/*
- * @brief
- * result = exp(arg)
- *
- * @note
- * Currently, function is verified for abs(arg) <= 1.
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_exp(struct spl_fixed31_32 arg));
-
-/*
- * @brief
- * result = log(arg)
- *
- * @note
- * Currently, abs(arg) should be less than 1.
- * No normalization is done.
- * Currently, no special actions taken
- * in case of invalid argument(s). Take care!
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_log(struct spl_fixed31_32 arg));
-
-/*
- * @brief
- * Power function
- */
-
-/*
- * @brief
- * result = pow(arg1, arg2)
- *
- * @note
- * Currently, abs(arg1) should be less than 1. Take care!
- */
-static inline struct spl_fixed31_32 spl_fixpt_pow(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
-{
-	if (arg1.value == 0)
-		return arg2.value == 0 ? spl_fixpt_one : spl_fixpt_zero;
-
-	return SPL_NAMESPACE(spl_fixpt_exp(
-		SPL_NAMESPACE(spl_fixpt_mul(
-			SPL_NAMESPACE(spl_fixpt_log(arg1)),
-			arg2))));
-}
-
-/*
- * @brief
- * Rounding functions
- */
-
-/*
- * @brief
- * result = floor(arg) := greatest integer lower than or equal to arg
- */
-static inline int spl_fixpt_floor(struct spl_fixed31_32 arg)
-{
-	unsigned long long arg_value = arg.value > 0 ? arg.value : -arg.value;
-
-	if (arg.value >= 0)
-		return (int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-	else
-		return -(int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-}
-
-/*
- * @brief
- * result = round(arg) := integer nearest to arg
- */
-static inline int spl_fixpt_round(struct spl_fixed31_32 arg)
-{
-	unsigned long long arg_value = arg.value > 0 ? arg.value : -arg.value;
-
-	const long long summand = spl_fixpt_half.value;
-
-	SPL_ASSERT(LLONG_MAX - (long long)arg_value >= summand);
-
-	arg_value += summand;
-
-	if (arg.value >= 0)
-		return (int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-	else
-		return -(int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-}
-
-/*
- * @brief
- * result = ceil(arg) := lowest integer greater than or equal to arg
- */
-static inline int spl_fixpt_ceil(struct spl_fixed31_32 arg)
-{
-	unsigned long long arg_value = arg.value > 0 ? arg.value : -arg.value;
-
-	const long long summand = spl_fixpt_one.value -
-		spl_fixpt_epsilon.value;
-
-	SPL_ASSERT(LLONG_MAX - (long long)arg_value >= summand);
-
-	arg_value += summand;
-
-	if (arg.value >= 0)
-		return (int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-	else
-		return -(int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-}
-
-/* the following two function are used in scaler hw programming to convert fixed
- * point value to format 2 bits from integer part and 19 bits from fractional
- * part. The same applies for u0d19, 0 bits from integer part and 19 bits from
- * fractional
- */
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u4d19(struct spl_fixed31_32 arg));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u3d19(struct spl_fixed31_32 arg));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u2d19(struct spl_fixed31_32 arg));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u0d19(struct spl_fixed31_32 arg));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d14(struct spl_fixed31_32 arg));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d10(struct spl_fixed31_32 arg));
-
-int SPL_NAMESPACE(spl_fixpt_s4d19(struct spl_fixed31_32 arg));
-
-static inline struct spl_fixed31_32 spl_fixpt_truncate(struct spl_fixed31_32 arg, unsigned int frac_bits)
-{
-	bool negative = arg.value < 0;
-
-	if (frac_bits >= FIXED31_32_BITS_PER_FRACTIONAL_PART) {
-		SPL_ASSERT(frac_bits == FIXED31_32_BITS_PER_FRACTIONAL_PART);
-		return arg;
-	}
-
-	if (negative)
-		arg.value = -arg.value;
-	arg.value &= (~0ULL) << (FIXED31_32_BITS_PER_FRACTIONAL_PART - frac_bits);
-	if (negative)
-		arg.value = -arg.value;
-	return arg;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_ux_dy(unsigned int value,
-		unsigned int integer_bits, unsigned int fractional_bits));
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_int_dy(unsigned int int_value,
-		unsigned int frac_value,
-		unsigned int integer_bits,
-		unsigned int fractional_bits));
-
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_namespace.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_namespace.h
new file mode 100644
index 000000000000..5bea362f960e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_namespace.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+
+/* Copyright 2024 Advanced Micro Devices, Inc. */
+
+#ifndef _SPL_NAMESPACE_H_
+#define _SPL_NAMESPACE_H_
+
+/* SPL namespace macros */
+#ifndef SPL_PFX_
+#define SPL_PFX_
+#endif
+
+#define SPL_EXPAND2(a, b)         a##b
+#define SPL_EXPAND(a, b)          SPL_EXPAND2(a, b)
+#define SPL_NAMESPACE(symbol)     SPL_EXPAND(SPL_PFX_, symbol)
+
+#endif /* _SPL_NAMESPACE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
index ae2d24c856cf..26553cd6890f 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
@@ -15,51 +15,10 @@
 #include <linux/delay.h>
 #include <linux/mm.h>
 
-/*
- *
- * general debug capabilities
- *
- */
-
-static inline uint64_t spl_div_u64_rem(uint64_t dividend, uint32_t divisor, uint32_t *remainder)
-{
-	return div_u64_rem(dividend, divisor, remainder);
-}
-
-static inline uint64_t spl_div_u64(uint64_t dividend, uint32_t divisor)
-{
-	return div_u64(dividend, divisor);
-}
-
-static inline uint64_t spl_div64_u64(uint64_t dividend, uint64_t divisor)
-{
-	return div64_u64(dividend, divisor);
-}
-
-static inline uint64_t spl_div64_u64_rem(uint64_t dividend, uint64_t divisor, uint64_t *remainder)
-{
-	return div64_u64_rem(dividend, divisor, remainder);
-}
-
-static inline int64_t spl_div64_s64(int64_t dividend, int64_t divisor)
-{
-	return div64_s64(dividend, divisor);
-}
-
-#define spl_swap(a, b) \
-	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
-
 #ifndef spl_min
 #define spl_min(a, b)    (((a) < (b)) ? (a):(b))
 #endif
 
-/* SPL namespace macros */
-#ifndef SPL_PFX_
-#define SPL_PFX_
-#endif
-
-#define SPL_EXPAND2(a, b)         a##b
-#define SPL_EXPAND(a, b)          SPL_EXPAND2(a, b)
-#define SPL_NAMESPACE(symbol)     SPL_EXPAND(SPL_PFX_, symbol)
+#include "spl_namespace.h"
 
 #endif /* _SPL_OS_TYPES_H_ */
-- 
2.43.0

