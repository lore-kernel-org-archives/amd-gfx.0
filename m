Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B410C4320E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F74760EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F74760EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5AB6E9DC;
	Fri, 27 Aug 2021 20:45:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C896E9DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvTs1+HF8TGBrJSlSg9yw5NjA6+1a4sr4OkLrkwozoLdHQLSjQpVNDA80xA9N6u8knauiCci9B8erLnkdTzeiqsO4mbzf27acJ7My/4ikMGF4yKTithNGbLg/U3NOq8lzHlNYpIC3TUSjvCRrPHHPC/+yz+fiIIJ3xuiJxzVkfe7IrBpBmbQlrVw323/jbWBW5ncERWRL+nioycaeyyvPBqOgftEe1mdIWZNtnWJxgRGxZoe+JD+m+Bmxl68Ki5q5tC5czuVZ4q9p0kf0ok/FMruz0rn+GfsRSuPmCxlfYJDcBH5aKM5lqUDINQpc5IqbA5KozIyDpfjQpRn8GkXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dg1OWqCTX63cdvfzVljkQ4gD3y6NZ+OikAcA3sw5D8=;
 b=UtU1Y2E0SgAziv0YJh+m7kALdkK2oGy0mMzDklXPcR4HH1CZUtRrGEfj/pSvv5D3jfZYs6U56HHZqarPf0X/OOLd0rLQ5fKZy62vJGI4lbjm0rxUDEm+JE0ZgUWAoAPIa4n7bhwfs/zhveViEFsPztHcmsOYhLNO52iTyXc/BHa4oCEDwjJbZGoAQ6GZdZSuNwqZ6TjWRsBGshcK20P/thTmDUWFONLC7q0q9LoYzkq1e+JvO4yMZkhwd5l8bOSSfU2+4ouwcxxUXfP6E4t7KiWZS+fvT645JNhS1nYWspj1m5Rit311mVd8SSGIsnQS66/q3zjYfkJUjnBvk8Ccew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dg1OWqCTX63cdvfzVljkQ4gD3y6NZ+OikAcA3sw5D8=;
 b=ad8LAkPib7CRvR2yYNI5DvB0stcaPM7mxo33nry9IEVa35mOHBNUC+oj8qHABlBQGea54i9bFeTtnigKnqvDfD3lR/cFJCELkZtuPbtqJrOkbGenm5Zgi7F/8rsnq2FfgdX8vNgampTSo+y1Cg7c53rt2bD/hMbwmz1tv3o85WE=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 20:29:30 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::2a) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:29 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:28 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, George Shen
 <George.Shen@amd.com>
Subject: [PATCH 06/19] drm/amd/display: expose dsc overhead bw in dc dsc header
Date: Fri, 27 Aug 2021 16:28:57 -0400
Message-ID: <20210827202910.20864-7-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64d49252-fb32-44da-438b-08d969995f60
X-MS-TrafficTypeDiagnostic: BN8PR12MB3540:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3540E503F7453FB18A6E5F56E4C89@BN8PR12MB3540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyhD2TIkB7TtR4BGRJCKPWSHfJCIUlpala2GjxQaT4JV6kwaF9Q4DYgOaYPPYgQx8up6jNJtOKyaaoVEdQ+DhwZB7WxjoP9Zp5WiTbd+MahZJQt5yaWJKkKt3cHBKpxcXUlTXJU5Nr1ohXh+h+8/sLYt27ldfhNsjATfsJ2XBSQV4G5xuj5UdvjOA5M7rNkyzMKkBq2KN+CgJU0wFgKQmsjyHmhXd95riWAXJh0d8smHMSXldxXwY/Letzcn8kun2d+LXx5aT6FvKin1PAZxI17zHyTYs6NocrHDSMD7119oDlfSqbLNJGny6lVdan2nB8yf8QxmuvXp8vKuhZneoYsS4Je1STaRy+2d0HIyIwOSbhtmky1b2phV9uvXw/KegrzSrKOVD2+iYvzuKL4vmWJBCJtD0SM/h1dVs4A0FpFdBoMMZVkDZGWJPQf6tbzA+8OGsjuXQBoaPbcBYKnLXZz0ZeiZ1W5TdnNsbUi3ANdgF5VTOPXpJ8HRv5HQnM90oxQBHMafKv2g5ai3y/DhlsiBF8XgKZngaIKSK8tf8KkALPXB+VBwy2oT87SqRzTGsgGwFW/aPj05zAp5jyAl50g/L/RbGttNR2i9dUnDsAFUqcZsIhNxDPfonSwy/K0WRNn/Rkp07fGSXN2OlBs/zu2Fjq7il77wnYd/bBQwmb2Odd43gbBVFH6UhmInXUQV0uegWcV/AIVE0bFIV2RPCvZ+c3O6V3tLSVNjdNCXCys=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(46966006)(478600001)(82310400003)(44832011)(2906002)(4326008)(81166007)(8676002)(8936002)(36756003)(356005)(70206006)(426003)(83380400001)(70586007)(6666004)(54906003)(316002)(336012)(82740400003)(2616005)(26005)(5660300002)(186003)(1076003)(16526019)(36860700001)(47076005)(6916009)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:29.9113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d49252-fb32-44da-438b-08d969995f60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3540
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
DM needs to know how much overhead is added to DSC as result
of AMD internal DSC limitation.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dsc.h     |  5 ++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 64 ++++++++++-----------
 2 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 16cc76ce3739..c8cc6a448c36 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -81,6 +81,11 @@ bool dc_dsc_compute_config(
 uint32_t dc_dsc_stream_bandwidth_in_kbps(const struct dc_crtc_timing *timing,
 		uint32_t bpp_x16, uint32_t num_slices_h, bool is_dp);
 
+uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
+		const struct dc_crtc_timing *timing,
+		const int num_slices_h,
+		const bool is_dp);
+
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		uint32_t max_target_bpp_limit_override_x16,
 		struct dc_dsc_policy *policy);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index f403d8e84a8c..8c04f9f42a3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -261,32 +261,6 @@ static inline uint32_t dsc_div_by_10_round_up(uint32_t value)
 	return (value + 9) / 10;
 }
 
-static struct fixed31_32 compute_dsc_max_bandwidth_overhead(
-		const struct dc_crtc_timing *timing,
-		const int num_slices_h,
-		const bool is_dp)
-{
-	struct fixed31_32 max_dsc_overhead;
-	struct fixed31_32 refresh_rate;
-
-	if (dsc_policy_disable_dsc_stream_overhead || !is_dp)
-		return dc_fixpt_from_int(0);
-
-	/* use target bpp that can take entire target bandwidth */
-	refresh_rate = dc_fixpt_from_int(timing->pix_clk_100hz);
-	refresh_rate = dc_fixpt_div_int(refresh_rate, timing->h_total);
-	refresh_rate = dc_fixpt_div_int(refresh_rate, timing->v_total);
-	refresh_rate = dc_fixpt_mul_int(refresh_rate, 100);
-
-	max_dsc_overhead = dc_fixpt_from_int(num_slices_h);
-	max_dsc_overhead = dc_fixpt_mul_int(max_dsc_overhead, timing->v_total);
-	max_dsc_overhead = dc_fixpt_mul_int(max_dsc_overhead, 256);
-	max_dsc_overhead = dc_fixpt_div_int(max_dsc_overhead, 1000);
-	max_dsc_overhead = dc_fixpt_mul(max_dsc_overhead, refresh_rate);
-
-	return max_dsc_overhead;
-}
-
 static uint32_t compute_bpp_x16_from_target_bandwidth(
 		const uint32_t bandwidth_in_kbps,
 		const struct dc_crtc_timing *timing,
@@ -294,14 +268,14 @@ static uint32_t compute_bpp_x16_from_target_bandwidth(
 		const uint32_t bpp_increment_div,
 		const bool is_dp)
 {
-	struct fixed31_32 overhead_in_kbps;
+	uint32_t overhead_in_kbps;
 	struct fixed31_32 effective_bandwidth_in_kbps;
 	struct fixed31_32 bpp_x16;
 
-	overhead_in_kbps = compute_dsc_max_bandwidth_overhead(
+	overhead_in_kbps = dc_dsc_stream_bandwidth_overhead_in_kbps(
 				timing, num_slices_h, is_dp);
 	effective_bandwidth_in_kbps = dc_fixpt_from_int(bandwidth_in_kbps);
-	effective_bandwidth_in_kbps = dc_fixpt_sub(effective_bandwidth_in_kbps,
+	effective_bandwidth_in_kbps = dc_fixpt_sub_int(effective_bandwidth_in_kbps,
 			overhead_in_kbps);
 	bpp_x16 = dc_fixpt_mul_int(effective_bandwidth_in_kbps, 10);
 	bpp_x16 = dc_fixpt_div_int(bpp_x16, timing->pix_clk_100hz);
@@ -933,19 +907,45 @@ bool dc_dsc_compute_config(
 uint32_t dc_dsc_stream_bandwidth_in_kbps(const struct dc_crtc_timing *timing,
 		uint32_t bpp_x16, uint32_t num_slices_h, bool is_dp)
 {
-	struct fixed31_32 overhead_in_kbps;
+	uint32_t overhead_in_kbps;
 	struct fixed31_32 bpp;
 	struct fixed31_32 actual_bandwidth_in_kbps;
 
-	overhead_in_kbps = compute_dsc_max_bandwidth_overhead(
+	overhead_in_kbps = dc_dsc_stream_bandwidth_overhead_in_kbps(
 			timing, num_slices_h, is_dp);
 	bpp = dc_fixpt_from_fraction(bpp_x16, 16);
 	actual_bandwidth_in_kbps = dc_fixpt_from_fraction(timing->pix_clk_100hz, 10);
 	actual_bandwidth_in_kbps = dc_fixpt_mul(actual_bandwidth_in_kbps, bpp);
-	actual_bandwidth_in_kbps = dc_fixpt_add(actual_bandwidth_in_kbps, overhead_in_kbps);
+	actual_bandwidth_in_kbps = dc_fixpt_add_int(actual_bandwidth_in_kbps, overhead_in_kbps);
 	return dc_fixpt_ceil(actual_bandwidth_in_kbps);
 }
 
+uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
+		const struct dc_crtc_timing *timing,
+		const int num_slices_h,
+		const bool is_dp)
+{
+	struct fixed31_32 max_dsc_overhead;
+	struct fixed31_32 refresh_rate;
+
+	if (dsc_policy_disable_dsc_stream_overhead || !is_dp)
+		return 0;
+
+	/* use target bpp that can take entire target bandwidth */
+	refresh_rate = dc_fixpt_from_int(timing->pix_clk_100hz);
+	refresh_rate = dc_fixpt_div_int(refresh_rate, timing->h_total);
+	refresh_rate = dc_fixpt_div_int(refresh_rate, timing->v_total);
+	refresh_rate = dc_fixpt_mul_int(refresh_rate, 100);
+
+	max_dsc_overhead = dc_fixpt_from_int(num_slices_h);
+	max_dsc_overhead = dc_fixpt_mul_int(max_dsc_overhead, timing->v_total);
+	max_dsc_overhead = dc_fixpt_mul_int(max_dsc_overhead, 256);
+	max_dsc_overhead = dc_fixpt_div_int(max_dsc_overhead, 1000);
+	max_dsc_overhead = dc_fixpt_mul(max_dsc_overhead, refresh_rate);
+
+	return dc_fixpt_ceil(max_dsc_overhead);
+}
+
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t max_target_bpp_limit_override_x16, struct dc_dsc_policy *policy)
 {
 	uint32_t bpc = 0;
-- 
2.25.1

