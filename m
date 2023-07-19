Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656E3C001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E716610E4E1;
	Wed, 19 Jul 2023 18:34:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A2A510E4E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIadnIKLSWl6FvXCfpByeJj7LfIQk/UlLcEK1Zjio/j02cE2c7p+GeoQBBOmIs7GuND/PMdQ3GD5dhS4VX/oJJJldAyUbFZ0wN+6beXZOS/w25jMxskg1NeQCJNN56R5EolxRLXD3qQPdZkXf0XC0KHd5ZQfWsAeScTlUM7m1mbrmdNGka4Pljt6l8p3Dc+yaxtW4O0X1Q04Ova/dSIQjqcI0PR/+iZI3B0CoqbZFw2TJz/WKVPsCn/L0qG6hIv9ekZ3WXoDI64GMyaV85aiXkxys2E+QSu+M8HFU+7+GJ3cBPw63r5LIOu8vgCm4wrd8yRDmkMGHPgUkO3u/PBVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/nVJy4IcMcmMfFyHV+LW3f1n7B02OdDS9MTW++9Tno=;
 b=k2zvUE8WT1BdcFqmhYoLSmAKK7hn6WU3FXWOgy8CBkG/sDsuAQLCp9o76RoirLyNW4i3mOfhHLWOCdL6aBup8molgtIBUreUGhLgypUuggCafEmJ3BankY+UkUAbAynwSW/lBFsLQqwIOTyZHCO1sCU7fevWLDsf8blRsuatXjsvjmC4sUiZZVKaS++ayQWsDQhO69OHabdSOtLCQvTwHUwqdWVWDMYOwAN5TyyoBvWAohCOyUPSIFYN2gUEStzEGwpRY1nfyQH7DaCghmZvY+K2Zgat00hy0kz6k9ecABzkbR01ckvtlaFBqSF2rORyC0eq0YQDqEUA5uC6NJAbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/nVJy4IcMcmMfFyHV+LW3f1n7B02OdDS9MTW++9Tno=;
 b=hEvcKMjIQxxz0AuXZ9RmDrIq9XchfuKv+O2k27yZoXVjon92k385B2gmJRLa9OJvCZj2hOfhRVoZecCxlxsYU2V9gpQ0+aPo3qyGsMTe1V10ScXInolq+26CL5joT4xwEz8NZOvmnJxL/fvVpVTdPJgmzeiPTYGOGLBMztLHOb0=
Received: from BN9PR03CA0178.namprd03.prod.outlook.com (2603:10b6:408:f4::33)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 18:34:15 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::dc) by BN9PR03CA0178.outlook.office365.com
 (2603:10b6:408:f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 18:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 18:34:15 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:34:11 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: Read down-spread percentage from lut
 to adjust dprefclk.
Date: Wed, 19 Jul 2023 12:27:56 -0600
Message-ID: <20230719183211.153690-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 30201511-a6a5-4b0b-c922-08db8886c132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6mzcAwVihhm95bpTz/j9Oepw4B/RHOraQwR5hUfrNJqTq+X3LZBr48osTrCyVYjEoU6zdZRbR3FgT8ztSnomzW6RMhE+lUr0UmWvh16YY3IfdJZO74oytJnXMoaA5SA2xzFwnGMKiDwZvUm2iPjjzIvZ4NpWusLgpN0rd5Ow46OB5tO350kwDS/aJIKI84HkUEQNWRZ2CMLg7u/RzAxUZ+NrEiXs4D2WpSFtshuVvRCwogDnorDBFq7qO3WL+H+pXPLiFWCSN9ZkJA5KUt0/0pPlr86h7oUqQFmfneU2NfCRY9A500dfXH/I2lFBHjagKlM7XXoGXx10BJi03V4QzEeOzVQ30/lXgsDwb1WFXwHs/rJoE9AYAqzQNK1LaaddVmx5f4Y+xMPPMdrGYE4ugpyWd7KHf17GtGYSOPU6g5y13Ig86wqDtmZU5r9++3g/S4NbiPiwp41AXlG0AEUU3Asl/SzWuGCJ3I1kwacfER+6zHyj64vvLvxSmVW4HYTfa2G0WByRiu4BmKP17MltcaS14r6x3VqZ2UYwk31VaYQJxYPhiB2Pq6pbfIzhj0S54LadKxqHh6UlcOFEmXZ/lsh+dViLcty9/FCP7Ll/5iMvHn3Qd7H00CX+iwCWrktUNA7I44YXZuO1pBgGnuW+2MrNpNlwqma0sV3gFDYG1SQ1GUkR53XHwKQNk9JjQZa6YXT6nWnS46B9h5eYJohrA+2j/Kfh+dZIY7g9VViHJr95rj4RIwzurwZ+cRZwCMtO3gNl+sWTaemKktyrKqn6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(70206006)(40460700003)(44832011)(7696005)(6666004)(81166007)(2906002)(356005)(316002)(6916009)(8676002)(8936002)(4326008)(36756003)(5660300002)(47076005)(82740400003)(16526019)(70586007)(426003)(2616005)(186003)(1076003)(336012)(40480700001)(26005)(41300700001)(86362001)(478600001)(83380400001)(19627235002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:34:15.0914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30201511-a6a5-4b0b-c922-08db8886c132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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
Cc: stylon.wang@amd.com, Martin Tsai <martin.tsai@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[Why]
Panels show corruption with high refresh rate timings when
ss is enabled.

[How]
Read down-spread percentage from lut to adjust dprefclk.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 33 +++++++++++++++++--
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |  7 ++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 2f7c8996b19d..3ba2e13d691d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -87,6 +87,14 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
 #define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
 
+#define regCLK1_CLK2_BYPASS_CNTL			0x029c
+#define regCLK1_CLK2_BYPASS_CNTL_BASE_IDX	0
+
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
+#define CLK1_CLK2_BYPASS_CNTL__LK2_BYPASS_DIV__SHIFT	0x10
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
+#define CLK1_CLK2_BYPASS_CNTL__LK2_BYPASS_DIV_MASK		0x000F0000L
+
 #define REG(reg_name) \
 	(CLK_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
 
@@ -436,6 +444,11 @@ static DpmClocks314_t dummy_clocks;
 
 static struct dcn314_watermarks dummy_wms = { 0 };
 
+static struct dcn314_ss_info_table ss_info_table = {
+	.ss_divider = 1000,
+	.ss_percentage = {0, 0, 375, 375, 375}
+};
+
 static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn314_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -715,6 +728,20 @@ static struct clk_mgr_funcs dcn314_funcs = {
 };
 extern struct clk_mgr_funcs dcn3_fpga_funcs;
 
+static void dcn314_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
+{
+	uint32_t clock_source;
+
+	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
+
+	clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
+
+	if (clk_mgr->dprefclk_ss_percentage != 0) {
+		clk_mgr->ss_on_dprefclk = true;
+		clk_mgr->dprefclk_ss_divider = ss_info_table.ss_divider;
+	}
+}
+
 void dcn314_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn314 *clk_mgr,
@@ -781,9 +808,11 @@ void dcn314_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
-	dce_clock_read_ss_info(&clk_mgr->base);
+
+	dcn314_read_ss_info_from_lut(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
-	//clk_mgr->base.dccg->ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(clk_mgr_internal, clk_mgr->base.base.dprefclk_khz);
+	clk_mgr->base.base.dprefclk_khz =
+		dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn314_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
index 171f84340eb2..e0670dafe260 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
@@ -28,6 +28,8 @@
 #define __DCN314_CLK_MGR_H__
 #include "clk_mgr_internal.h"
 
+#define NUM_CLOCK_SOURCES   5
+
 struct dcn314_watermarks;
 
 struct dcn314_smu_watermark_set {
@@ -40,6 +42,11 @@ struct clk_mgr_dcn314 {
 	struct dcn314_smu_watermark_set smu_wm_set;
 };
 
+struct dcn314_ss_info_table {
+	uint32_t ss_divider;
+	uint32_t ss_percentage[NUM_CLOCK_SOURCES];
+};
+
 bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b);
 
-- 
2.41.0

