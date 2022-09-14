Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB18EECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418EC10E7E7;
	Wed, 14 Sep 2022 03:26:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 137AF10E7E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4ru4b1sXEJHc6y4EO3Hd3Ep5Ejzf564QQNCcqfa0xAb7GLDXu5b3GrnmbhyN5buxuCruUIM0ZVFMGO29JBYkwzsEZ26CoQKHLgzAGU5kPmS5M+ipFUzZmS1bmfVtnst6rKOZdVJK1MjnTfAPITV73pBfFe0Eaq2XsfWSDQGi96Hjd6vK1ilzlxXJEqoOw6s+ZFBOAkCFJHdYPGTzGb/5aPTNP9RjOBHC4ejBResJ0205opgwDw58zQNhLqe16YVlxpgSuRHGPyykXFtS3gPA03oUCd9VIQgvTcR10LPiNui2O3ZV6BhK+NGuxzPXCcPOAjifmi5iOTyfoeXKvfvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Aq4TlKukSkX2KEP9xRHBKZPydJ9LJ0dVxC5V665cqM=;
 b=nJlaeOwxv95yzZu/kB2B0H0ZdPMB2YqOyq6vmcxCsX2VwyuJV5XMS9Mi5uZcyl5FXnvd2Y73sNxwNY+2NIMUI81w0kFqpx5CTW2qCPQYqdVtu600QDIks8DFRS8lmqFEXb4+ABUHu/ZO3nnaOkuktthdgG5XawOeoeDcX+0AZwfn0ywL8zUl1YVCVhRYm5r7vvWzdI/12o7UjnCXgr86gwOMU2ZpC9+teZF0vY2nG9Gmbh8PN+idkfdhqU4jch2H+jk9lJjLe5jCXhJYMw7D15pdBsubPZaHsRUSajImk1tFe+0N4iTQhfKjmEZ1xYakmYpgJhameWQd+VyhOvR71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Aq4TlKukSkX2KEP9xRHBKZPydJ9LJ0dVxC5V665cqM=;
 b=Y445LD5dCdSEY3X3DxPA4W99yMWVA1Luan2SxOt8N78GgrArATuyLUyo2NY1cm541Yi/drPyage6xUm9639P7N0pfZrukZlcc9c4GULYm/TImVNV0Wm+BqSagHAuUqAbjlU3NFyD5qXwURBmtcNdaZOOvLiyv/KrIPdxjShBq84=
Received: from DM6PR11CA0004.namprd11.prod.outlook.com (2603:10b6:5:190::17)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:26:07 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::2b) by DM6PR11CA0004.outlook.office365.com
 (2603:10b6:5:190::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:26:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:26:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:26:06 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:26:02 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/47] drm/amd/display: add debug option for
 dramclk_change_latency in apu
Date: Wed, 14 Sep 2022 11:23:58 +0800
Message-ID: <20220914032441.1075031-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d64cd00-93fb-45b7-ca07-08da9600dcb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FY9wxVPsC5LgudeAYnj2jMb2M3sgPTJgftu3XinqqGYaLFwxgZyya9qqveDygR8vwmuK7o1/7M/UxUB9Xx46Ju56vDeVQXh49MlUxQrPwX4R7I9PKxPgS1LE8IyV8+dC0DMqjWjHG7nE3EAo9tEIsm9Y7vJ4AFXrPHzkEL3PAyCGQPafKpFIa3my5qoIkwnXN+grwBVw6RSduO/oItX0zNFIvnokeZCAoeHj2+TZacjrXj72yX69z9gtjvKST4wSBqocpH6Le+xhOKycxuY2reo8oJdrDMN81vjN1FYEd8rl4dG90SktKUd9M05DQPx3tsXBa6H7LQUucDY0FOAPkshlFQYzrzOsfRd+H7nEmL2xUtuLJz8iiigAH/9jhO+dtK9PyZUJ9XgeHxT6rRSKZyyRXCkx8gd1DWoVQlPJxfWo9+gcXYtSyLCsIBVt3NKQK6echi97bmNnGUIAs8LqurXCmgg4GPZt5UJjYi2r2oY2/bUDYuJEN3KgYJ/qp/JEHeIUupM8x34Vwi7s5ht1/6uTpnSgO8XDTRWCPu6OKIV2UcSClvpIwC7EKLS36nkd7Gll5/G/9U2uYXs3wl7k68T+owaScNvFJcn6aO6vz6FbLmg/zL/Aztuor09pl1UPFQ3PLnt25NB4tc+XfetgBLv/lhxQzi2cwvYsG2Ci0qo8fUolFyi2g1r9SkqR3uWbwJmVa6zP2MEXbXr28SN856+FFVmAXe1sOD9ZFMwIlpSeGZpyVJELrhZI4jpjTRR4dF1O89VXAdNRAFm8yR2HDjQ1cc+TNQ2lgQm7M/fjVXF894Kz16WEnSdbyIUDQlQy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(426003)(6666004)(8936002)(5660300002)(356005)(7696005)(36756003)(4326008)(82310400005)(478600001)(82740400003)(186003)(83380400001)(36860700001)(70586007)(47076005)(81166007)(2906002)(1076003)(6916009)(54906003)(8676002)(40460700003)(86362001)(26005)(2616005)(316002)(40480700001)(70206006)(41300700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:26:07.2476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d64cd00-93fb-45b7-ca07-08da9600dcb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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

