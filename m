Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42BEC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A1710F85A;
	Fri, 22 Jul 2022 20:41:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6732C12A1FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm6jVfpB3Fvvr3ToXgsL5Rwxtt59VjXOa6XtKSpSMSLX1S77IDm2g+s08aE17805oJfkLYUFs7vioXUKDl7880KlcnqugKQDwOctsPYxjK7912gh1MC4FKUGFu6TErmAsrfFxs7OLwrwbK9h733wUtWg5XnD9xpc7/fVoo98HHOQtuXgHO6ecasUAcEuobAqrhfEvOxGVSWXglnrWicacLmC6YdSEqdwNxlgTHJtw5WRNWvxi5Hhg4dzuWiGk+hJBXI5gONTBRGHURWYKf6KrX4HMQtau3O5X9bfaQ5+iYA97mAtJsMEG3dby9d+LNFR7OB9iGegdFFxoOpGMHkmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGbPM8I4uuaC3OK8+GFCm5eKC/OOGItLKtSck918v74=;
 b=GJ1wZQfau3kSfC0ZS8I32uJuKSGjw/+tVgtAKub9/1fimweUZzp/NCZif8l3mdE2+rqZrlikzzpOM/pqbhuCIYPgw3dew6R0Brajai8eajB6pOCFb5ixnh51bHcQgdbdx7gYf83UMrj/Nfk0rcdwRXvPS+q+AJ1w3/HDxQ2LD9umBpdXGVRImimrZqxMoN+Pk/9ugGL6C/PhaVeg7IR+EJvD0Uz0zKD/0Ujj+VrrO0qzDur355TBTbfbSiGqAoi9pJX2mGxHwYvAwh+oGH4JEbt5l0e+jo+tI53SlNmxfdBvmtdjnTS3GnCTo5Zk1+oco87RYH6Zh91zeqWLx0MZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGbPM8I4uuaC3OK8+GFCm5eKC/OOGItLKtSck918v74=;
 b=mGJdILrBw6+q8p6lXlDyrb5z39wFUpQhs34WPvLNK7csF58/d0Gr//dGQOQt3pNaIFKer3A2z99PLWiSxhxsEAudFtqOGk9ImLGdqi+TFvtpERaMfUlcZeW5ARk5hCDvUmdJvlVVSgqY3LGYna3PZbRJsEX/8H1K4UMwBHGthNY=
Received: from MW4PR03CA0234.namprd03.prod.outlook.com (2603:10b6:303:b9::29)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:41:17 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::f) by MW4PR03CA0234.outlook.office365.com
 (2603:10b6:303:b9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21 via Frontend
 Transport; Fri, 22 Jul 2022 20:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:41:16 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:40:58 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/31] drm/amd/display: Add pixel rate div calcs and
 programming
Date: Fri, 22 Jul 2022 14:31:22 -0600
Message-ID: <20220722203137.4043516-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9dac135-bcbc-426b-1129-08da6c22868b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4291:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpFJeEssTgeX/zAc+/YLJxrw+qUe9s03H2dK3zghTUQeQW0YT9bhzOzfCb0EopYTqA+PdtkHYo9IBlwv3OvWpjqMzkJXtHlnvmyN16/4KHiIjHM9Buvky5c2ud9dMegiY2UHx1b4KFwLGWJxDufxmjcSQfAhQprrs8vmv3RHCWdcoaI9DWHTCn6z4ZCz7fFz0GPFvUhtE2W5XF6Exucoq7f3VcOxwMTe3OOOeL0gl6Ee8y8L05nLwMpqWzjvFmZqB8P55fQxAF2/AmVJHof3Pp6BePPINY3XlcgK2J3s2kvnazZ17DmsVEtsFbfCo480/RGDQmvV5zQx92rONFefIKs1P5E15CWO8y4KjayZLizL4OZSfXuFshdTpjiatK3fTVQZ0NEDwnXuoF+rdGG4FtdRiwGy+8Cfqi7GEgKsTQyLTYjtF87RcrpmLPz28guJAu3MExpCDLQNEqv6VrMYgzyVSgpFyL6RtmzoPpgvxSGlbTAtJkyuERQCTuhT9XusC6j9coOI2TNNjyiyYSnTqYtYgHZziBOsFf10+pmhprWr8UAXAAUXckMttTExKmk4ATnBH3Q5OUrtbnuwsALmIK1fDfxhFK7esHF0n2uDgdNvviBf3QHKMeU468DJKvdswhkeyU3ptDXXnYAvPs3XZzOR6UfzV6BZAScYc4kEL0ziPAm1s1NKv2syq1+TFaQAtQBToUfCu315HTgenMnd3gLpFMhbCLeyVbxUBfXffgjeY+EzrFBxQRBbQDuXIix6wIxfL3bOACg2FkboHK8A3KF6VZj3OzYX+JacFkL+VrpwEG+P0J2Sgw795CcDWYzHmiIEi6ZbfQQhmaorA3zw2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(6916009)(1076003)(36756003)(70586007)(70206006)(54906003)(4326008)(8676002)(5660300002)(44832011)(36860700001)(478600001)(316002)(86362001)(8936002)(83380400001)(41300700001)(2616005)(2906002)(16526019)(6666004)(81166007)(356005)(47076005)(186003)(82740400003)(336012)(426003)(26005)(82310400005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:41:16.6420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dac135-bcbc-426b-1129-08da6c22868b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY/HOW]
Need to calculate and set some pixel rate divisors on correct otg_inst

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   | 17 +++++++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 36 +++++++++++++++++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  2 ++
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  1 +
 4 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index ea78da9c6f8b..3852a6d59b97 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -219,6 +219,21 @@ void dccg314_set_dpstreamclk(
 	}
 }
 
+void dccg314_set_valid_pixel_rate(
+		struct dccg *dccg,
+		int ref_dtbclk_khz,
+		int otg_inst,
+		int pixclk_khz)
+{
+	struct dtbclk_dto_params dto_params = {0};
+
+	dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
+	dto_params.otg_inst = otg_inst;
+	dto_params.pixclk_khz = pixclk_khz;
+
+	dccg314_set_dtbclk_dto(dccg, &dto_params);
+}
+
 static const struct dccg_funcs dccg314_funcs = {
 	.update_dpp_dto = dccg31_update_dpp_dto,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
@@ -237,6 +252,8 @@ static const struct dccg_funcs dccg314_funcs = {
 	.set_dispclk_change_mode = dccg31_set_dispclk_change_mode,
 	.disable_dsc = dccg31_disable_dscclk,
 	.enable_dsc = dccg31_enable_dscclk,
+	.set_pixel_rate_div = dccg314_set_pixel_rate_div,
+	.set_valid_pixel_rate = dccg314_set_valid_pixel_rate,
 };
 
 struct dccg *dccg314_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 90ec76487264..755c715ad8dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -338,3 +338,39 @@ void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable)
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
 }
+
+unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	unsigned int odm_combine_factor = 0;
+
+	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
+
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		*k2_div = PIXEL_RATE_DIV_BY_1;
+	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
+		*k1_div = PIXEL_RATE_DIV_BY_1;
+		if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+			*k2_div = PIXEL_RATE_DIV_BY_2;
+		else
+			*k2_div = PIXEL_RATE_DIV_BY_4;
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+		if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+			*k1_div = PIXEL_RATE_DIV_BY_1;
+			*k2_div = PIXEL_RATE_DIV_BY_2;
+		} else if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			*k1_div = PIXEL_RATE_DIV_BY_2;
+			*k2_div = PIXEL_RATE_DIV_BY_2;
+		} else {
+			if (odm_combine_factor == 1)
+				*k2_div = PIXEL_RATE_DIV_BY_4;
+			else if (odm_combine_factor == 2)
+				*k2_div = PIXEL_RATE_DIV_BY_2;
+		}
+	}
+
+	if ((*k1_div == PIXEL_RATE_DIV_NA) && (*k2_div == PIXEL_RATE_DIV_NA))
+		ASSERT(false);
+
+	return odm_combine_factor;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
index dfdd0b792a52..be0f5e4d48e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
@@ -37,4 +37,6 @@ void dcn314_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool po
 
 void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
+unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
+
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index c87b1979b2cc..b9debeb081fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -144,6 +144,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.set_blend_lut = dcn30_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
+	.calculate_dccg_k1_k2_values = dcn314_calculate_dccg_k1_k2_values,
 };
 
 void dcn314_hw_sequencer_construct(struct dc *dc)
-- 
2.37.1

