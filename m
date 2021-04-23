Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084BEC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9914361425
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9914361425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D4B6EB2C;
	Fri, 23 Apr 2021 02:40:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92866EB2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJnDNjXgvOGlIrM9LmqBdAYtTMreTwq569umzfZguaiVA9p4LVhhzLL0GpWEOyIyCsHfGf8RA7YDs0ICYYvBIqwwRH5WwED6OPL89RObYHS3+AX298xK3B05gdtYfewZpr2Hpx9I+1udOfpm0NbaI3MrhhlGPY9muQjbTJHqKHsd2PfJAm1kIIKKKuFx7EW3Ba9lW0c0EmwX2SGZiTKjNrafyUasKllVUrKZJbbNF0rQfTg1ImdPCasqbIehMbxwWLqQoQFr3ubO7eQdO9J331H/f2z3SQCiW904hznFBpi84ok81sEEFAwT0sJUFCkpG85+ThhN6/3BfI2dGszSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p79oyBx8Fa3fwNIeK6CL8XivtH/VxQzxzKok8z8jnE=;
 b=f4lsx4+4vv1MmYl6fRH6HzToIeFC5JKyKMhHEvdF0vnaINoT7V9HoiPtPGHat06k2Edd3+9vOC44vhPDJav0uSlMKTLTxxkyP+gZR2hl+exQZbydT3hrTrURIX1ml1X4vFuvB6QJ5UcDLe9/5KbtQgrupEXDCzy/6mjWPBAhaJPJJKVtrFgsx2U9jdfYwC70AcTFEJ0uzgRzrxZtuUdZd2pf190U4CoGutlS1w7Y31BegJoAGAcqyF2gfKjujjDnwh9H7Gbew23kOd6wRdY34mqvTMvczntHTdRDytuxwoOKITobYoVnReU/u5kYIcg31+GyX88iguvg54wD04+otA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p79oyBx8Fa3fwNIeK6CL8XivtH/VxQzxzKok8z8jnE=;
 b=i8lbDOXWMr1X2l+2abuEFlil+BBncK6uykrNU57m9pWEdYaHXC4FQxR3+i3Yh8ko9Q7qg1kWpilAJhIDIXApyetwoNqHn/oCnFYFwb1n76OatOInQ4NjssJOOLFRkNubPOfkSgLBa6wsRAzSGbm7e8yCFr02QV5FAH9MRD4TLrU=
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by CY4PR12MB1255.namprd12.prod.outlook.com (2603:10b6:903:36::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 23 Apr
 2021 02:40:39 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::d2) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:38 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: take max dsc stream bandwidth overhead
 into account
Date: Fri, 23 Apr 2021 10:37:10 +0800
Message-ID: <20210423023714.22044-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29eeb8dd-9a47-4d7d-b34c-08d906012e9f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1255:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12558CCAEBBEADF2091D87DDFC459@CY4PR12MB1255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yk9y0jQUl24avkJ2eawy5KclD2WJ9UdZLZXtcScaApQGEdWsqFjpJQ2+Xusv01Xb9IpbHLe2ISwk8fcQ/Y+4oNoeQOXZqzB1Hb2lBa0I/+iMXiiKg1FgswhjncExIvy5rHQCer1BpZxheajvHM/lrzU+ZuAGIlgPHVwJ5sxt55Rdy6O3NhfCOOtqkAp+w0Ogddf1A6C2mwpi5Ygm38ptatu+CVHJILup1aIcwBZ1pHMx96ep906kFIUiEm1l16nAdFWF96R7dph+IfLhzFIleoIxgTWlShg6UR7TuU7L8B/FBfxr789GvzXPeR1A1j6xwdNEpY7hkROgIe+6GlckfOhrwUl/coqhUQYAUZk8uem6sciTfG9z1gKkxamrRUnJ8W4VVeJRZQQ4eN6NOtdl2/DVXLMhiLEbT0LnRGlzBeXaCY4S+OYB0b/ijlIaldy8gl+WQvGh/i5zIXJskC8cU6mOt6p9G5D7Yvu6KgYa/k6ScS6qA9njllmKgr6AVybcWDafILuw9j3zIW5rBLwkw59s8BxnHha37aSIoEvAMsvUMx+Ngx3zzPAJOqfzlMp3YJpLVG2QMqAFHmdjxyozv3Gf7K7tNRsCaCr4LZuz/bWKxGcvaYF/dqo2De0xyfsNpgyQ/aqBbSxMdKz8Pkw0hiCtGgtq6TlNCC04J6BSWueQlOsBpr8wuF0CyJKCadzH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(316002)(8936002)(36756003)(82310400003)(186003)(7696005)(54906003)(336012)(83380400001)(82740400003)(5660300002)(8676002)(26005)(6916009)(426003)(478600001)(36860700001)(356005)(2906002)(30864003)(4326008)(6666004)(70586007)(15650500001)(2616005)(86362001)(1076003)(70206006)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:39.5058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29eeb8dd-9a47-4d7d-b34c-08d906012e9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1255
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
As hardware team suggested that we need to add a max dsc bw overhead
into existing stream bandwidth when DSC is used.
The formula as below:

max_dsc_bw_overhead =
v_addressable * slice_count * 256 bit * pixel clock / v_total / h_total

effective stream bandwidth = pixel clock * bpp

stream bandwidth = effective stream bandwidth + dsc stream overhead

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   5 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 113 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  |  43 -------
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |   2 -
 5 files changed, 94 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 931fbb4d6169..8bbed9c90c5d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3486,9 +3486,10 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 	uint32_t kbps;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (timing->flags.DSC) {
-		return dc_dsc_stream_bandwidth_in_kbps(timing->pix_clk_100hz, timing->dsc_cfg.bits_per_pixel);
-	}
+	if (timing->flags.DSC)
+		return dc_dsc_stream_bandwidth_in_kbps(timing,
+				timing->dsc_cfg.bits_per_pixel,
+				timing->dsc_cfg.num_slices_h);
 #endif
 
 	switch (timing->display_color_depth) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index c51d2d961b7a..afddb8b7d3e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -78,7 +78,8 @@ bool dc_dsc_compute_config(
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_config *dsc_cfg);
 
-uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
+uint32_t dc_dsc_stream_bandwidth_in_kbps(const struct dc_crtc_timing *timing,
+		uint32_t bpp_x16, uint32_t num_slices_h);
 
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		uint32_t max_target_bpp_limit_override_x16,
@@ -88,6 +89,4 @@ void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
 
 void dc_dsc_policy_set_enable_dsc_when_not_needed(bool enable);
 
-uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
-
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index be57088d185d..bfe3ad58070a 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -258,12 +258,58 @@ static inline uint32_t dsc_div_by_10_round_up(uint32_t value)
 	return (value + 9) / 10;
 }
 
+static struct fixed31_32 compute_dsc_max_bandwidth_overhead(
+		const struct dc_crtc_timing *timing,
+		const int num_slices_h)
+{
+	struct fixed31_32 max_dsc_overhead;
+	struct fixed31_32 refresh_rate;
+
+	/* use target bpp that can take entire target bandwidth */
+	refresh_rate = dc_fixpt_from_int(timing->pix_clk_100hz);
+	refresh_rate = dc_fixpt_div_int(refresh_rate, timing->h_total);
+	refresh_rate = dc_fixpt_div_int(refresh_rate, timing->v_total);
+	refresh_rate = dc_fixpt_mul_int(refresh_rate, 100);
+
+	max_dsc_overhead = dc_fixpt_from_int(num_slices_h);
+	max_dsc_overhead = dc_fixpt_mul_int(max_dsc_overhead, timing->v_addressable);
+	max_dsc_overhead = dc_fixpt_mul_int(max_dsc_overhead, 256);
+	max_dsc_overhead = dc_fixpt_div_int(max_dsc_overhead, 1000);
+	max_dsc_overhead = dc_fixpt_mul(max_dsc_overhead, refresh_rate);
+
+	return max_dsc_overhead;
+}
+
+static uint32_t compute_bpp_x16_from_target_bandwidth(
+		const uint32_t bandwidth_in_kbps,
+		const struct dc_crtc_timing *timing,
+		const uint32_t num_slices_h,
+		const uint32_t bpp_increment_div)
+{
+	struct fixed31_32 overhead_in_kbps;
+	struct fixed31_32 effective_bandwidth_in_kbps;
+	struct fixed31_32 bpp_x16;
+
+	overhead_in_kbps = compute_dsc_max_bandwidth_overhead(
+				timing, num_slices_h);
+	effective_bandwidth_in_kbps = dc_fixpt_from_int(bandwidth_in_kbps);
+	effective_bandwidth_in_kbps = dc_fixpt_sub(effective_bandwidth_in_kbps,
+			overhead_in_kbps);
+	bpp_x16 = dc_fixpt_mul_int(effective_bandwidth_in_kbps, 10);
+	bpp_x16 = dc_fixpt_div_int(bpp_x16, timing->pix_clk_100hz);
+	bpp_x16 = dc_fixpt_from_int(dc_fixpt_floor(dc_fixpt_mul_int(bpp_x16, bpp_increment_div)));
+	bpp_x16 = dc_fixpt_div_int(bpp_x16, bpp_increment_div);
+	bpp_x16 = dc_fixpt_mul_int(bpp_x16, 16);
+	return dc_fixpt_floor(bpp_x16);
+}
+
 /* Get DSC bandwidth range based on [min_bpp, max_bpp] target bitrate range, and timing's pixel clock
  * and uncompressed bandwidth.
  */
 static void get_dsc_bandwidth_range(
 		const uint32_t min_bpp_x16,
 		const uint32_t max_bpp_x16,
+		const uint32_t num_slices_h,
 		const struct dsc_enc_caps *dsc_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range)
@@ -272,16 +318,20 @@ static void get_dsc_bandwidth_range(
 	range->stream_kbps = dc_bandwidth_in_kbps_from_timing(timing);
 
 	/* max dsc target bpp */
-	range->max_kbps = dc_dsc_stream_bandwidth_in_kbps(timing->pix_clk_100hz, max_bpp_x16);
+	range->max_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
+			max_bpp_x16, num_slices_h);
 	range->max_target_bpp_x16 = max_bpp_x16;
 	if (range->max_kbps > range->stream_kbps) {
 		/* max dsc target bpp is capped to native bandwidth */
 		range->max_kbps = range->stream_kbps;
-		range->max_target_bpp_x16 = calc_dsc_bpp_x16(range->stream_kbps, timing->pix_clk_100hz, dsc_caps->bpp_increment_div);
+		range->max_target_bpp_x16 = compute_bpp_x16_from_target_bandwidth(
+				range->max_kbps, timing, num_slices_h,
+				dsc_caps->bpp_increment_div);
 	}
 
 	/* min dsc target bpp */
-	range->min_kbps = dc_dsc_stream_bandwidth_in_kbps(timing->pix_clk_100hz, min_bpp_x16);
+	range->min_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
+			min_bpp_x16, num_slices_h);
 	range->min_target_bpp_x16 = min_bpp_x16;
 	if (range->min_kbps > range->max_kbps) {
 		/* min dsc target bpp is capped to max dsc bandwidth*/
@@ -290,7 +340,6 @@ static void get_dsc_bandwidth_range(
 	}
 }
 
-
 /* Decides if DSC should be used and calculates target bpp if it should, applying DSC policy.
  *
  * Returns:
@@ -303,6 +352,7 @@ static bool decide_dsc_target_bpp_x16(
 		const struct dsc_enc_caps *dsc_common_caps,
 		const int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
+		const int num_slices_h,
 		int *target_bpp_x16)
 {
 	bool should_use_dsc = false;
@@ -311,7 +361,7 @@ static bool decide_dsc_target_bpp_x16(
 	memset(&range, 0, sizeof(range));
 
 	get_dsc_bandwidth_range(policy->min_target_bpp * 16, policy->max_target_bpp * 16,
-			dsc_common_caps, timing, &range);
+			num_slices_h, dsc_common_caps, timing, &range);
 	if (!policy->enable_dsc_when_not_needed && target_bandwidth_kbps >= range.stream_kbps) {
 		/* enough bandwidth without dsc */
 		*target_bpp_x16 = 0;
@@ -327,7 +377,11 @@ static bool decide_dsc_target_bpp_x16(
 		should_use_dsc = true;
 	} else if (target_bandwidth_kbps >= range.min_kbps) {
 		/* use target bpp that can take entire target bandwidth */
-		*target_bpp_x16 = calc_dsc_bpp_x16(target_bandwidth_kbps, timing->pix_clk_100hz, dsc_common_caps->bpp_increment_div);
+		*target_bpp_x16 = compute_bpp_x16_from_target_bandwidth(
+				range.max_kbps, timing, num_slices_h,
+				dsc_common_caps->bpp_increment_div);
+		if (*target_bpp_x16 < range.min_kbps)
+			*target_bpp_x16 = range.min_kbps;
 		should_use_dsc = true;
 	} else {
 		/* not enough bandwidth to fulfill minimum requirement */
@@ -531,18 +585,6 @@ static bool setup_dsc_config(
 	if (!is_dsc_possible)
 		goto done;
 
-	if (target_bandwidth_kbps > 0) {
-		is_dsc_possible = decide_dsc_target_bpp_x16(
-				&policy,
-				&dsc_common_caps,
-				target_bandwidth_kbps,
-				timing,
-				&target_bpp);
-		dsc_cfg->bits_per_pixel = target_bpp;
-	}
-	if (!is_dsc_possible)
-		goto done;
-
 	sink_per_slice_throughput_mps = 0;
 
 	// Validate available DSC settings against the mode timing
@@ -690,6 +732,19 @@ static bool setup_dsc_config(
 
 	dsc_cfg->num_slices_v = pic_height/slice_height;
 
+	if (target_bandwidth_kbps > 0) {
+		is_dsc_possible = decide_dsc_target_bpp_x16(
+				&policy,
+				&dsc_common_caps,
+				target_bandwidth_kbps,
+				timing,
+				num_slices_h,
+				&target_bpp);
+		dsc_cfg->bits_per_pixel = target_bpp;
+	}
+	if (!is_dsc_possible)
+		goto done;
+
 	// Final decission: can we do DSC or not?
 	if (is_dsc_possible) {
 		// Fill out the rest of DSC settings
@@ -838,7 +893,8 @@ bool dc_dsc_compute_bandwidth_range(
 				dsc_min_slice_height_override, max_bpp_x16, &config);
 
 	if (is_dsc_possible)
-		get_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16, &dsc_common_caps, timing, range);
+		get_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
+				config.num_slices_h, &dsc_common_caps, timing, range);
 
 	return is_dsc_possible;
 }
@@ -864,13 +920,20 @@ bool dc_dsc_compute_config(
 	return is_dsc_possible;
 }
 
-uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16)
+uint32_t dc_dsc_stream_bandwidth_in_kbps(const struct dc_crtc_timing *timing,
+		uint32_t bpp_x16, uint32_t num_slices_h)
 {
-	struct fixed31_32 link_bw_kbps;
-	link_bw_kbps = dc_fixpt_from_int(pix_clk_100hz);
-	link_bw_kbps = dc_fixpt_div_int(link_bw_kbps, 160);
-	link_bw_kbps = dc_fixpt_mul_int(link_bw_kbps, bpp_x16);
-	return dc_fixpt_ceil(link_bw_kbps);
+	struct fixed31_32 overhead_in_kbps;
+	struct fixed31_32 bpp;
+	struct fixed31_32 actual_bandwidth_in_kbps;
+
+	overhead_in_kbps = compute_dsc_max_bandwidth_overhead(
+			timing, num_slices_h);
+	bpp = dc_fixpt_from_fraction(bpp_x16, 16);
+	actual_bandwidth_in_kbps = dc_fixpt_from_fraction(timing->pix_clk_100hz, 10);
+	actual_bandwidth_in_kbps = dc_fixpt_mul(actual_bandwidth_in_kbps, bpp);
+	actual_bandwidth_in_kbps = dc_fixpt_add(actual_bandwidth_in_kbps, overhead_in_kbps);
+	return dc_fixpt_ceil(actual_bandwidth_in_kbps);
 }
 
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t max_target_bpp_limit_override_x16, struct dc_dsc_policy *policy)
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index c6a1cd80aeae..7b294f637881 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -284,26 +284,6 @@ static u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
 	return bytes_per_pixel;
 }
 
-static u32 _do_calc_dsc_bpp_x16(u32 stream_bandwidth_kbps, u32 pix_clk_100hz,
-				u32 bpp_increment_div)
-{
-	u32 dsc_target_bpp_x16;
-	float f_dsc_target_bpp;
-	float f_stream_bandwidth_100bps;
-	// bpp_increment_div is actually precision
-	u32 precision = bpp_increment_div;
-
-	f_stream_bandwidth_100bps = stream_bandwidth_kbps * 10.0f;
-	f_dsc_target_bpp = f_stream_bandwidth_100bps / pix_clk_100hz;
-
-	// Round down to the nearest precision stop to bring it into DSC spec
-	// range
-	dsc_target_bpp_x16 = (u32)(f_dsc_target_bpp * precision);
-	dsc_target_bpp_x16 = (dsc_target_bpp_x16 * 16) / precision;
-
-	return dsc_target_bpp_x16;
-}
-
 /**
  * calc_rc_params - reads the user's cmdline mode
  * @rc: DC internal DSC parameters
@@ -367,26 +347,3 @@ u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps)
 	DC_FP_END();
 	return ret;
 }
-
-/**
- * calc_dsc_bpp_x16 - retrieve the dsc bits per pixel
- * @stream_bandwidth_kbps:
- * @pix_clk_100hz:
- * @bpp_increment_div:
- *
- * Calculate the total of bits per pixel for DSC configuration.
- *
- * @note This calculation requires float point operation, most of it executes
- * under kernel_fpu_{begin,end}.
- */
-u32 calc_dsc_bpp_x16(u32 stream_bandwidth_kbps, u32 pix_clk_100hz,
-		     u32 bpp_increment_div)
-{
-	u32 dsc_bpp;
-
-	DC_FP_START();
-	dsc_bpp =  _do_calc_dsc_bpp_x16(stream_bandwidth_kbps, pix_clk_100hz,
-					bpp_increment_div);
-	DC_FP_END();
-	return dsc_bpp;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
index 8123827840c5..262f06afcbf9 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
@@ -79,8 +79,6 @@ typedef struct qp_entry qp_table[];
 
 void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps);
 u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps);
-u32 calc_dsc_bpp_x16(u32 stream_bandwidth_kbps, u32 pix_clk_100hz,
-		     u32 bpp_increment_div);
 
 #endif
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
