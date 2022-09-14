Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A88ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71E810E410;
	Wed, 14 Sep 2022 05:12:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFD410E410
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhc/fTL9zm1WdCBU98wL10F75amo3SAkK3nAVbTjVUQj7VDfyxSYMHijtdKxPogslLFYhKjXCYFogLbUFWNxxQknFiySr+NTEBMbkXVBdAEJwgcTvnv+NMeHQaIr9frQiU3oAF8ucKsEkMgqzflpSJzZxPKznAoBNkxv0P/TBwdYn1/txEISnMnxqX31+uDycpOvzGDlP9/rIgWSRp8Q0w4tN/VNcSEcQJwmOM4+o7U5d7gCSVyUNZzg9jmWxAKi7slHNCRjM1ZwDNsOjcizgf2yzh2YuLeq3F8aQM7cgmsswoV2CmVzLgwhtXIeikQQYa3N+cKsRV0HYd3E44aLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Aq4TlKukSkX2KEP9xRHBKZPydJ9LJ0dVxC5V665cqM=;
 b=hcAuPGbOvvZvyKBIIjsIk43zx9ND9jkxJKEHG/1wJgu52NtN7l683lRWxxKNvQXfK8WMPyYPXIhdFcukID9rFnKf46qVXWrkWjFKb23puk98w+ZvJWBvlV7eXM28XaRjSnBwlncUeXLHJg1sCNrLTFPAk7xl7rgjR37Cnbx7VQOG6gBDpJumXtM+B7eL/ZtyhCxaeqfGb3G9iNPKQvW4RsCDFGa01s/lDfKxgAMMuGa8qrnH4XFXugs4bnK54Z00lApZgA2W2lKHvSspPJOtRaXpDXkqAj76BhkZLFB0wmA0GtEG5KGhoipZKXrZU2WUmAoIAdiXVe9cSkj7eUzy1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Aq4TlKukSkX2KEP9xRHBKZPydJ9LJ0dVxC5V665cqM=;
 b=sUAAJWnp4xbsjO/CbCoXXMzr7CB7m9dpCCmTuX9rOStZh5XEvXL8nzI3j/RJT1Oi31kNunUCzktqqifhMlIZEfnwVQCB0REhRFJFE4URvVeypI6sIeL4fuq0IpzY99e9b25kmXe5ucrOd0sSZM8psVi+3K8MKMcpIFTcpD3hU8I=
Received: from DM6PR10CA0036.namprd10.prod.outlook.com (2603:10b6:5:60::49) by
 CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Wed, 14 Sep 2022 05:12:41 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::7) by DM6PR10CA0036.outlook.office365.com
 (2603:10b6:5:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:12:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:12:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:12:10 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:12:04 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 04/47] drm/amd/display: add debug option for
 dramclk_change_latency in apu
Date: Wed, 14 Sep 2022 13:10:03 +0800
Message-ID: <20220914051046.1131186-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|CH0PR12MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb1cf57-08d8-4fa5-be14-08da960fc001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCUaR7cLTQ2+9gF9HddkgA5XjOJDq6oAWcRu/AENTNxos/6iM0Qy2hdCkLgaq1o2KM5R6Le0N20f2zmtVR/tS3lz/YfbuGGfOu3X1wH4OfqglaX0hxZMawuldcBNutNP9vGFXoOUbR9p9YLGryvY9ffMc2rEFYZqdjF/JSmJ6VhPbCwvtOKSMDiYuExPJz7HIpkY9dLXJX+Z8OblfZJ13IkQyL64KMFwYyUXYcJmbc4Xv33nfyLHjjuDNdzkMZDfJ5tcynyzWH0HUt+p1BOvxPd+Kx3/LsLrxzXUvV19AQwra4yN6XuhpcPQ+ypPXrIbLJNJEaoKzhpSIHACJWkHW4eujqzyh0kYal8t+QnqB4Wl9m7TWCti/5v9e7n4VgP4YGLE6tGVG84oR7UjaJQhRcoqXVoZbWk4tguWA1c0I5Z3+a6+iFj1TAsAohLqHllDZRUZK0sAldvbMOOyfvi7ToWophn9ZqqSiVP3Yrq2Q3nb6s2FrinGdgzM5U1iGGrc7LafkZ99V/YPhtYd73dwtua4IMFo1VijOgUM02s8RciQZ0Lq12k+rbTicdHqRKL7zvJ762nFoGzu08hZ/8hLbfmCjXbtj95bGBl+MKl6SwaSIrmk5qS1H6FEUU/l25zcsXT43BX3PQm79op11hFJIxD4mm1KRN2ylmwteURDCd4+zQU9eK46anQq8b0J4ZtP7gVxju//gErSLBTn5t4GSQg8yvAbX7bEqaXW+I8hKoSGQqieUlKHoq79d9lZb2T8cDzQqAookpObttDYXDpz+6iLBjE2GQR12ge2W76HwOWUm3BLDZFb88bM/yItpcTR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(336012)(186003)(83380400001)(8676002)(2906002)(26005)(82740400003)(36756003)(86362001)(40480700001)(356005)(47076005)(478600001)(41300700001)(1076003)(426003)(54906003)(8936002)(36860700001)(2616005)(5660300002)(7696005)(70586007)(4326008)(82310400005)(81166007)(40460700003)(6916009)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:12:41.5424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb1cf57-08d8-4fa5-be14-08da960fc001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
Support dramclk change latency change via debug option and add some
code isolation.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dml/dcn301/dcn301_fpu.c  |  5 +++++
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c    | 17 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn314/dcn314_fpu.c  |  5 +++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 241d28d0b7fb..422f17aefd4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -379,6 +379,11 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	dcn3_01_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
+	if ((int)(dcn3_01_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_01_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000.0;
+	}
 	dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 0e62eb823e34..43230709bd11 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -667,6 +667,12 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	dcn3_1_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
+	if ((int)(dcn3_1_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_1_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
+	}
+
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip, DML_PROJECT_DCN31);
 	else
@@ -721,6 +727,12 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	 */
 	dcn3_15_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 
+	if ((int)(dcn3_15_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_15_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
+	}
+
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31);
 	else
@@ -813,6 +825,11 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 		dcn3_16_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 	}
+	if ((int)(dcn3_16_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_16_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
+	}
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 4bb3b31ea7e0..ce477c090987 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -264,6 +264,11 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 	}
 
+	if ((int)(dcn3_14_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_14_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
+	}
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN314);
 	else
-- 
2.37.3

