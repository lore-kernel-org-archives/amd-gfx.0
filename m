Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E31C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC8F2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AhGLAaDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC8F2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80866EDB3;
	Wed, 21 Oct 2020 14:23:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7BE6EDB4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwiAdI9Yso+psynmXSEF+eF1FFGk90Bukul6N8SH9AmKzMKNQwoVyf8rC1Ie6vy4OFIHtGS03nLxeuyk2zxk00A/XxjfWvaqeqNwBUK1tcct+BGkDWmFq/74ojERfbQhe9dWW8VOBiqmsWcJXBXqHuM9JxnhOkm8rKvfGfi9ekm4HfWY9Bz0dQE457nQl4HWY3/AYcbQbWotLdQ3s7/E5e7m9ckj9y1uXyN8a/VCfpyENOSD6uFU/Fpr6GwgTj3oZUgcKQ2GnSGQVlSC3MquOJbXZaYA8RRqa6zk7MGmBpQGeU/d84pXyyrCcp3GYz5vlvibj5ypAqJ/5FJXwIqBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VzfCggcI9Llb6ZYwaC1EorxmfQilN4sGJnbG+OW2Tw=;
 b=eJrqLWlyzIkpp0qcPf5KGwGCNYWFMbDS3sm6DnxR4mG7pOC5UrDGMGW4ECUEATEY06qNQ4yqiQyetlaybraOy214e/a27BMLPfyL876tlw1OPur3AB4Sv8HnySNJTHl0pUMYtWU66rbIuQgpnhBQDCJ2QkxVZzM/5q3gjDN6IA9eueOUPhPy7tnCw7H8tn7cwdQbUW0Mt4uPGi5XCpfrhDh6+eUaZLl9emynq+SC/Tde+2jHbpDtkpwuhJdjMGZ/IXXaMRT6eAnRsLxwyZETneO/BRficDlu8KnX+Ac0/53rFo8Z5sQbPFamsMrEyfICRD4vrwspFgIG80DW67pJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VzfCggcI9Llb6ZYwaC1EorxmfQilN4sGJnbG+OW2Tw=;
 b=AhGLAaDfMByX7D9qwXgTGq1D57e+fiztL22+sXvPoDHOXRf/6uuGXZUYGpiIIx3+uwA/o3xtQqqncAMD9JPHjkDeO/lMk0TN+AsL4bdjGUSA44WXa3xzL8BCNnhGyJq0zhQaKOKWiQ9VsZA1Pydk5sWeViKzylodl7a/VTRf4bA=
Received: from DM3PR12CA0056.namprd12.prod.outlook.com (2603:10b6:0:56::24) by
 BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 14:23:01 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::3b) by DM3PR12CA0056.outlook.office365.com
 (2603:10b6:0:56::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.23 via Frontend Transport; Wed, 21 Oct 2020 14:22:59 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:22:59 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:22:58 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/33] drm/amd/display: Add Bounding Box State for Low DF
 PState but High Voltage State
Date: Wed, 21 Oct 2020 10:22:25 -0400
Message-ID: <20201021142257.190969-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e4c3b18-e0da-4c47-37d9-08d875ccd044
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0212C46684692D393E7D4ECF8B1C0@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHWdHVs3KGtid56Go3f3x7wzQKTwVaE3fbvD3VlUaDB91SSwWNkGddwrP8xKE3HAOI6Z4I0U5NHlmdnf8snaedcn+1CkZaeGvKc2YlUTbjA9eZYDoNHTe3ce8UlYIcj1EOPKZ2AwjvHWj46F4pzn3jWZecwxC11D42usP6QFnxdTkjI8vl/9/rKzx19iguCLtsrTz0wpe8JPFxH0MHXriDukIFKUrLPfO6WHXXVF4TMBEal4YqgIL5LA2Ct+ktWGT4Fsx7VjpLG34ShIzRzvgdyZrqYfAAr2/OR0IeZNbK8MTi51HMYsTI4vqKGODSRa5rD0C6W6MTZ0XwxrYqUMCvAEer/17XAfoio9a3B4kZ8XLrTc6DZyFZvond3lzomAxzQXivPM2tAv4xlkzNStyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966005)(478600001)(2616005)(83380400001)(426003)(336012)(47076004)(36756003)(5660300002)(82740400003)(81166007)(356005)(8936002)(70206006)(70586007)(8676002)(4326008)(26005)(1076003)(2906002)(82310400003)(316002)(54906003)(6916009)(44832011)(86362001)(7696005)(186003)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:22:59.9825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4c3b18-e0da-4c47-37d9-08d875ccd044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
DF PState and Voltage State are coupled such that one cannot be
raised without raising the other. This uses more power than
is necessary in high bandwidth scenarios.

[HOW]
Add logic to create a new bounding box state that allows for
DF PState to be low while Voltage State is high. Watermarks
vlevel calculation logic was also udpated to assume
state 1 contains the new optimized state.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 71 ++++++++++++++-----
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 686e1d47faa4..72cbc13ce3da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1154,12 +1154,12 @@ void dcn21_calculate_wm(
 						&context->bw_ctx.dml, pipes, pipe_cnt);
 	/* WM Set C */
 	table_entry = &bw_params->wm_table.entries[WM_C];
-	vlevel = MIN(MAX(vlevel_req, 2), vlevel_max);
+	vlevel = MIN(MAX(vlevel_req, 3), vlevel_max);
 	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.c,
 						&context->bw_ctx.dml, pipes, pipe_cnt);
 	/* WM Set B */
 	table_entry = &bw_params->wm_table.entries[WM_B];
-	vlevel = MIN(MAX(vlevel_req, 1), vlevel_max);
+	vlevel = MIN(MAX(vlevel_req, 2), vlevel_max);
 	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.b,
 						&context->bw_ctx.dml, pipes, pipe_cnt);
 
@@ -1385,12 +1385,39 @@ struct display_stream_compressor *dcn21_dsc_create(
 	return &dsc->base;
 }
 
+static struct _vcs_dpi_voltage_scaling_st construct_low_pstate_lvl(struct clk_limit_table *clk_table, unsigned int high_voltage_lvl)
+{
+	struct _vcs_dpi_voltage_scaling_st low_pstate_lvl;
+	int i;
+
+	low_pstate_lvl.state = 1;
+	low_pstate_lvl.dcfclk_mhz = clk_table->entries[0].dcfclk_mhz;
+	low_pstate_lvl.fabricclk_mhz = clk_table->entries[0].fclk_mhz;
+	low_pstate_lvl.socclk_mhz = clk_table->entries[0].socclk_mhz;
+	low_pstate_lvl.dram_speed_mts = clk_table->entries[0].memclk_mhz * 2;
+
+	low_pstate_lvl.dispclk_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].dispclk_mhz;
+	low_pstate_lvl.dppclk_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].dppclk_mhz;
+	low_pstate_lvl.dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[high_voltage_lvl].dram_bw_per_chan_gbps;
+	low_pstate_lvl.dscclk_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].dscclk_mhz;
+	low_pstate_lvl.dtbclk_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].dtbclk_mhz;
+	low_pstate_lvl.phyclk_d18_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].phyclk_d18_mhz;
+	low_pstate_lvl.phyclk_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].phyclk_mhz;
+
+	for (i = clk_table->num_entries; i > 1; i--)
+		clk_table->entries[i] = clk_table->entries[i-1];
+	clk_table->entries[1] = clk_table->entries[0];
+	clk_table->num_entries++;
+
+	return low_pstate_lvl;
+}
+
 static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
-	unsigned int i, closest_clk_lvl;
+	unsigned int i, closest_clk_lvl = 0, k = 0;
 	int j;
 
 	dcn2_1_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
@@ -1407,27 +1434,35 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 			}
 		}
 
-		clock_limits[i].state = i;
-		clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-		clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-		clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-		clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
-
-		clock_limits[i].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-		clock_limits[i].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-		clock_limits[i].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-		clock_limits[i].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-		clock_limits[i].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-		clock_limits[i].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-		clock_limits[i].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		/* clk_table[1] is reserved for min DF PState.  skip here to fill in later. */
+		if (i == 1)
+			k++;
+
+		clock_limits[k].state = k;
+		clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+		clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+		clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
+		clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+
+		clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+		clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+		clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+		clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+		clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+		clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+		clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+
+		k++;
 	}
-	for (i = 0; i < clk_table->num_entries; i++)
+	for (i = 0; i < clk_table->num_entries + 1; i++)
 		dcn2_1_soc.clock_limits[i] = clock_limits[i];
 	if (clk_table->num_entries) {
-		dcn2_1_soc.num_states = clk_table->num_entries;
+		dcn2_1_soc.num_states = clk_table->num_entries + 1;
 		/* duplicate last level */
 		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
 		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
+		/* fill in min DF PState */
+		dcn2_1_soc.clock_limits[1] = construct_low_pstate_lvl(clk_table, closest_clk_lvl);
 	}
 
 	dml_init_instance(&dc->dml, &dcn2_1_soc, &dcn2_1_ip, DML_PROJECT_DCN21);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
