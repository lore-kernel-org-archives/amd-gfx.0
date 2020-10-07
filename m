Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD4C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9F5207EA
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n0zrQV1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9F5207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D12C893D5;
	Wed,  7 Oct 2020 12:42:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0BD8893D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVJy6KdoZfzZYrkwClE6QS/rN3+zkJZoKDubdipgFFFMa0rxzU5sQH5BjPzZxYTJx0XxYQqMs2rvi1+Mb/1h7IQPy7/KyduFXI1icYeUKJ9nk370jzqeubEQdG2000gRzDNNPn/uvBPbnKO9St56/eJiR/DI6az93zZVMOIDkeRVY5SeFoHxo6Nucpo6IxDdP7JKfYHAahm2U03pailj27t3JVCCZjSP37n61+9mCp0DwJYY7YE8k7QtGksVjvxhJGT6SIjjIdtPTB+/KC8LPIRxvX9MhEK1LFPrnz4rNs65QcM2FpHSTDIOPFjSmh/C1qUZQABmWFcUrvxPNIzd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VzfCggcI9Llb6ZYwaC1EorxmfQilN4sGJnbG+OW2Tw=;
 b=krQguAnhwllMbUjIHTxCoyXeQvTioS0pGkqsR+u10PdRnuBFq+CTkYjovCsUEoe3Xq3FtwZhcKy5LAyDaUoWa8xv919orWQp5aclVA9s7O9chnKPakZpIwyBkL7439cbSuv3XE484R1TIk6Y/ylCnJDAUwVq9YgCEYkay2ZbHeL30j4lqZVANiVUAitmzTEzea+J2Ch84B8sIMXa19elqtFZYqSn+KZEAobEAEHIzyNY5A7ObuLd+WHMAJHnPXLl9iuG33dGJSeTXj34eYegQn7gn3hMVHQoyQIlq5LFUCYhKDx1eJ2gcpUlMJKl3dY6QoFGFpOtvGXfhojwo4gGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VzfCggcI9Llb6ZYwaC1EorxmfQilN4sGJnbG+OW2Tw=;
 b=n0zrQV1YHINl/o12/4tk+icfhyMq9oJUHRTaNN6SSR28XMCBwAFdnHWwk+qYyyzHB0ZvZRner6r2ZFVSw6SYX3TiKWWTqajF2T5Ck6B5QQ2WhBzmLVrgt0jktLqGwu41RM339kgPnDWDvWHOyvl/cCq8MaeSyVZaJ2DJ3WVsTjQ=
Received: from MWHPR19CA0001.namprd19.prod.outlook.com (2603:10b6:300:d4::11)
 by DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34; Wed, 7 Oct 2020 12:42:28 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::49) by MWHPR19CA0001.outlook.office365.com
 (2603:10b6:300:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:27 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:26 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: Add Bounding Box State for Low DF
 PState but High Voltage State
Date: Wed, 7 Oct 2020 08:42:14 -0400
Message-ID: <20201007124224.18789-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e084206-8fae-4368-5638-08d86abe7316
X-MS-TrafficTypeDiagnostic: DM5PR12MB1546:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1546FDE9AFFACA238AC58CE88B0A0@DM5PR12MB1546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfeV3s0MY8TyW7vrVgzGXG6EneDpGw4xpTmtHLX/U899cOfBeDB2IZg2UPS4QgGX+uBlui2vuLqaypTmosLI/sKD+QkqaLSaauqIZ9sqqUJP+oH4KjFIdn139PnI1J51DaoRDoKF7n3BCfPvds5r/a3Xnd+nBv2qtSVhQ0vMTWMkeO4QZp/VrCSsT+A5lWx7d6JPCkS7QB2VEYqyzsu4CKAEf59pU2bL8VmkkXQJva4Qjh5moKpc2BuWfIW2cBypxmvDjRfdftAEVDKQ7BlhLVWs0zR0vQb4FwuLf0kQY4kTVZfh7B49m5ct1wC6+kGzC5PR44wqEIoNWHK0FduDg/8IBphynI14JWqxmMJAcjJ4+vM3a/NWRL8f0Gc3Z8torVtGryiRvvZ03h5Aiob4Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(70586007)(70206006)(5660300002)(4326008)(1076003)(81166007)(6916009)(36756003)(186003)(426003)(336012)(356005)(86362001)(8936002)(478600001)(2616005)(82310400003)(83380400001)(44832011)(8676002)(54906003)(47076004)(6666004)(26005)(316002)(7696005)(2906002)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:27.8350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e084206-8fae-4368-5638-08d86abe7316
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1546
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
