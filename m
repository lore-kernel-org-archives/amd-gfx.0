Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D3CC00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1455B4B10;
	Sat, 13 Aug 2022 02:14:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08578B4AD2
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKCGt5nvdSS/IO6oKCwfBLMEQJOH+UvBMRKP96c72JJ/ZE3pjPLICEXtXnx4DfAc3SfD1noPNmdMbyQPqjKzV7BZYwKjLRRNUIic5NKC9YUNdb0qP8i1aD0KdV435u9g3h8ore3OySZhwWlONn44cHELHOeT7GKYrsTiKhingYKrPUUi7NGe9CA1Bm1IqL+oSXVLYeIQpj4dPLOV04kPrI9MLlpjUOh3tR6WtDOkmStZzSqGD18qJsm5LdERuqd7t9WIVCgz1U/rFD2yKJsqHRNOfbHhczU0A65wWfo5LBacC8ex8L5oz9Sq8H/hwIljm/HvfplBi/70sb/FbmlgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOA8hZBJIjruywEvtkhnwxq3/ECysblDilMyr2fLGD8=;
 b=P/jdvVdNHFyZVLx2PHHM8C4/W1dhTNzZE+kd8jmTsUxgfh/wgdqvEU5xrlcPhC2jkHKyA43SQ92x9SYwvWqbj6p9dx3EMYkkErU5Wrf87kJXvOD+yuP7myy1iYrGuJv4XWacsy/EkiiScLdIyFhF9aOPbZozwfAO4D/inA/1SrWdEB0IKjwXoGG3OvCcBkdHMttUkMLqJ3hHKwbDGk8XeYavm2L5z35BHTlupXWwKzg6YOrJfmBnqKa1ymdIiwtPhjqo+a4fdkSMy1v1Ap1xRUqyVeiHV/S3CMEMw06v8RfBf6Ph3DCw7zrXrRddqqahPD/kqFRZFBuiNg0vRDWj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOA8hZBJIjruywEvtkhnwxq3/ECysblDilMyr2fLGD8=;
 b=frRSXIamFHKs2B5vo0VZusR2z49xl6AQodnMW5kTFVKzd5txr8V6poostIuJ0e4mBGC6sI+8mKFL0n2TF4LtBliJyd3jKbjd4x7DUHhG5AYrrABCC+yPb9853HNV+ajI7P0upsI/790IIzOd8hElxkQDlhTp/TMK5OT31mQEltk=
Received: from DS7PR03CA0320.namprd03.prod.outlook.com (2603:10b6:8:2b::15) by
 MWHPR1201MB2508.namprd12.prod.outlook.com (2603:10b6:300:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sat, 13 Aug
 2022 02:13:37 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::50) by DS7PR03CA0320.outlook.office365.com
 (2603:10b6:8:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Sat, 13 Aug 2022 02:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:13:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:13:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:13:09 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:13:05
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: Include scaling factor for SubVP
 command
Date: Sat, 13 Aug 2022 06:12:17 +0800
Message-ID: <20220812221222.1700948-10-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c0408ef-6b9a-488c-430d-08da7cd16ea7
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2508:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8blr7dm5NGyE5Cdf/4C9xS6oCN6UZsuEu2QGrCXx7uy+hjQNQVJ/RdDbrF3Zex/DZ4SQ0aPLs+9b5ffBQ/NzcIqjttl1iDkBN5vsfyM9IzaBElQH6XPWdSS49C62y80pxQicsVEzeJD3ZNa9P7OLnR04VIBBophbsrnKX2k398xyDRWYuvi2wCPVJpIv5nrRCxljccHQvAha9vfSXYuU3h/ypkL6mszQ3C2jfOr8DbFoCpWTiR13ReD90cHMreNlQ+jM4uPlyzEr+cpClJrAyiCnCYZipKukDe7FMorq0twcETzE2ch+bLxlLGAZLsG2F+U8oSgJHbLYidnLjGjA+2ml/x0Qb7V4EkFmyT5Nlws67SrOEy+7w6FSMIPWBAUzmt54hfaA7iipZk2n1dJnPA8n/joXufih8ID8Q4vdbZNBXF9LLNS+YsgI19qbAnMVqSV48lvWgI+gssleq9O7K0EimzCF/BBOFHu0uPSmPbZ35yaWKU8WhGvG0IBttoRr6xNYWRGHzgxZS0bPjV1AprKabSAhICtq/ODN49mCXQWUptXyNBjmND6mP5NgiaLt73PNh4Sl6OU2KLPOaghHjmAHazAP3e6xE0G4N/ZvR3SapcfpRY5iJgia75JVcnr1/TfgAVU2FNECHrjwPMMG7ek0WfKaNENtUbJAHi5l7EHhmJt9G1bXagIB70TPEXSxR5RK3sHEuFrLkrEmjBkPFBKCZFiM+KTjzQdWcWG86i2m+wyYz8K22X2AJzTdW+Iic1aCHOMK9ln/s62vWVsCNLtjBrhCBHIPldy5QGLKMtg4JfFzCrc3ui/2drEAwQIGtVJIzt0XBOjMVIloqRtN9uhlOU8JY+1V67CzNNCmAdM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(40470700004)(46966006)(336012)(426003)(478600001)(83380400001)(40460700003)(5660300002)(186003)(1076003)(47076005)(36756003)(2616005)(86362001)(36860700001)(40480700001)(54906003)(8936002)(6916009)(41300700001)(356005)(316002)(81166007)(82310400005)(2906002)(82740400003)(70206006)(70586007)(7696005)(26005)(4326008)(8676002)(6666004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:13:37.1717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0408ef-6b9a-488c-430d-08da7cd16ea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2508
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
For SubVP scaling cases, we must include the scaling
info as part of the cmd. This is required when converting
OTG line to HUBP line for the MALL_START_LINE programming.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/basics/conversion.c    | 21 +++++++++++++++++++
 .../drm/amd/display/dc/basics/conversion.h    |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 11 ++++++++++
 .../amd/display/dc/dcn321/dcn321_resource.c   |  3 ++-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
index 6767fab55c26..352e9afb85c6 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
@@ -100,3 +100,24 @@ void convert_float_matrix(
 		matrix[i] = (uint16_t)reg_value;
 	}
 }
+
+static uint32_t find_gcd(uint32_t a, uint32_t b)
+{
+	uint32_t remainder = 0;
+	while (b != 0) {
+		remainder = a % b;
+		a = b;
+		b = remainder;
+	}
+	return a;
+}
+
+void reduce_fraction(uint32_t num, uint32_t den,
+		uint32_t *out_num, uint32_t *out_den)
+{
+	uint32_t gcd = 0;
+
+	gcd = find_gcd(num, den);
+	*out_num = num / gcd;
+	*out_den = den / gcd;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.h b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
index ade785c4fdc7..81da4e6f7a1a 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.h
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
@@ -38,6 +38,9 @@ void convert_float_matrix(
 	struct fixed31_32 *flt,
 	uint32_t buffer_size);
 
+void reduce_fraction(uint32_t num, uint32_t den,
+		uint32_t *out_num, uint32_t *out_den);
+
 static inline unsigned int log_2(unsigned int num)
 {
 	return ilog2(num);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c8059c28ac49..09b304507bad 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -29,6 +29,7 @@
 #include "dm_helpers.h"
 #include "dc_hw_types.h"
 #include "core_types.h"
+#include "../basics/conversion.h"
 
 #define CTX dc_dmub_srv->ctx
 #define DC_LOGGER CTX->logger
@@ -600,6 +601,7 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			&cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[cmd_pipe_index];
 	struct dc_crtc_timing *main_timing = &subvp_pipe->stream->timing;
 	struct dc_crtc_timing *phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
+	uint32_t out_num, out_den;
 
 	pipe_data->mode = SUBVP;
 	pipe_data->pipe_config.subvp_data.pix_clk_100hz = subvp_pipe->stream->timing.pix_clk_100hz;
@@ -613,6 +615,15 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	pipe_data->pipe_config.subvp_data.main_pipe_index = subvp_pipe->pipe_idx;
 	pipe_data->pipe_config.subvp_data.is_drr = subvp_pipe->stream->ignore_msa_timing_param;
 
+	/* Calculate the scaling factor from the src and dst height.
+	 * e.g. If 3840x2160 being downscaled to 1920x1080, the scaling factor is 1/2.
+	 * Reduce the fraction 1080/2160 = 1/2 for the "scaling factor"
+	 */
+	reduce_fraction(subvp_pipe->stream->src.height, subvp_pipe->stream->dst.height, &out_num, &out_den);
+	// TODO: Uncomment below lines once DMCUB include headers are promoted
+	//pipe_data->pipe_config.subvp_data.scale_factor_numerator = out_num;
+	//pipe_data->pipe_config.subvp_data.scale_factor_denominator = out_den;
+
 	// Prefetch lines is equal to VACTIVE + BP + VSYNC
 	pipe_data->pipe_config.subvp_data.prefetch_lines =
 			phantom_timing->v_total - phantom_timing->v_front_porch;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index e9db5f8b6fdc..b9317d31e282 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1664,7 +1664,8 @@ static bool dcn321_resource_construct(
 	dc->caps.subvp_prefetch_end_to_mall_start_us = 15;
 	dc->caps.subvp_swath_height_margin_lines = 16;
 	dc->caps.subvp_pstate_allow_width_us = 20;
-
+	dc->caps.subvp_vertical_int_margin_us = 30;
+	
 	dc->caps.max_slave_planes = 1;
 	dc->caps.max_slave_yuv_planes = 1;
 	dc->caps.max_slave_rgb_planes = 1;
-- 
2.25.1

