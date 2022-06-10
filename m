Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4198CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD588113FC3;
	Fri, 10 Jun 2022 20:53:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA01113FC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmyKmRGLDPRrpoGW4fXlYez+mWfa353uoGzftz0LyuSa9pbbpINNEPi4CTB33vF+DkKKbbeK2e3KeGMFmtRya7SO+nc50KqZ6w/DzB16o2Niyzy08QbK+6dlogXHiGIXMQ/h7IFwb/74+avl34z2Me5qmuWh6tYdGxtgdtMxOpbx1jDAmrhcr92Fv8dhAHGx0uRGLbBCeUZHe5gECQshRuh+7pgV7OsiS8u02mi/43zNadlfb22yt2CpzJ23LR731pfv+b2tV9EtTSfBe+NYaxcrQLh6UA/9CppW5UU7o4dfgBYSyuqKNiy5ceZTwjTxZhiDUXfAyDh43ybXpxgmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIQiiBnYlHwqlB+REW84yC9ma/whYjyJ7vvy6Pul3ow=;
 b=JjPFWRC4O+kFncbtde2cMc3jVtZCT84UaGSrP2YrEVl0oGCjB1mmtlfwlpKb+1KKeWXj2diaGK79s7XvGAmTV5FCJO1ldMOC5gGw7PAeiCgB9aPf1SxuCeH07mmlzNvo/WZB6jwBPsyGzT9K8ka8O7qXPwSkvz4fBBb3lhhHGqHCpyAZ5ekcqZuv6Vg/Eag+/QP6+qkK4nwRMZxWAro2ubHbz/AF+Ntv6WOenoE05Sb3CqJk/T5ZPKWxK00ewh659nz7xlxUt8z9bNZgYXMcn34H+J+eTuiDEkIZnDpUvmfkIQTReju/7fYE2TJ2Ra+UdykvhZtg+A4aRSCFtaWW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIQiiBnYlHwqlB+REW84yC9ma/whYjyJ7vvy6Pul3ow=;
 b=c+zJt3t/JxUN+64RRsg9XumEHo47SwrpYloqVgqQVzM22POm+HFpdoNJlxK+qGd6wl+rtSzbl0WbyhmfQmpBGgHa7IyNl+fAx9VKsws19oy918SvTqECygskAdgjIpQbhTNgyTxHugDqiqCG+3Tq4Q4T/sypga/jhRWwcsBPT1s=
Received: from MWHPR15CA0047.namprd15.prod.outlook.com (2603:10b6:300:ad::33)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 20:53:12 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::ef) by MWHPR15CA0047.outlook.office365.com
 (2603:10b6:300:ad::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:12 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:08 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/23] drm/amd/display: Reduce frame size in the bouding box
 for DCN31/316
Date: Fri, 10 Jun 2022 16:52:28 -0400
Message-ID: <20220610205245.174802-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 481aa9d6-01f5-4e9f-ec05-08da4b233baf
X-MS-TrafficTypeDiagnostic: MW5PR12MB5597:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5597037137093BD766D2206BF4A69@MW5PR12MB5597.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: geEk/f5VQASmOVUmLPAL2cjMiUFMZGldWw3xaZkhfNoxIZ5/BGo+AHF6ysGi4RbilYaC8vaNxlxqnta7+E6bOm5iQsphtrYZkJbTPjIOaDvkvfJDvskbzGGS6UY79a2hWmNnr7nUyFYoCXgnq4ITbTnd6jEV4S5wv/fTr977+i/ut4MlmQlHnotSnBl4GXOC0MvLN9wA4+6aPDlReXR2rB0rC1QTscj2kl0MhRBfMUMhqSgjkh9aQ5j7X/a+kj+p8WVZwkAD7fsY9lSEopesFCzkAEY8JPps1rPSylUQkUF5lokwBf+/A9sclWnST8rApC97oULYQUVS5QKwwmx5E1WkMKl67rj1JqRFaC1PNfNJMEyZJ7wwPaRwy5o8WJiEpdS3sCxhx7z5ShWZYMUWz2EBmQ4Ysppf7clD1ApmN5HtIc2WwAfnPVu/JuRcqewNAn5N6VY4EjKWMBk5/SBIfK1AwjAWXbHLe34D+Hx4OMWiPvg975zNSeIYFLQ23d0B6VrFNnCBvd8ihX1F9hkF6eC3AMwS2oTBfbLIXgYocsr09tqX9uDQ8Eloj3ILl7Lvnp8JV7CyWX7GN6Ds0FpDPFZuVTY8OAQW+j7wzLE0nNMEHTKPgzcuP1kDc2rXg07UPiTrYu/9LfyIfruU2NP3aup1Nsq5B2TwEPu0DuWLZ2vGQ/16QoKEtm4swkIf7VpMgkEs4o6xmIifupSGTI+LMz0RxHP7iPS+jxeUVKg4YmkpAT42f/bRzYbMausM0Vdq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(6666004)(81166007)(16526019)(508600001)(426003)(83380400001)(47076005)(86362001)(186003)(336012)(82310400005)(5660300002)(36860700001)(44832011)(356005)(2906002)(54906003)(6916009)(70586007)(316002)(8936002)(70206006)(2616005)(26005)(36756003)(40460700003)(7696005)(1076003)(4326008)(8676002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:12.1795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481aa9d6-01f5-4e9f-ec05-08da4b233baf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

GCC throw warnings for the function dcn31_update_bw_bounding_box and
dcn316_update_bw_bounding_box due to its frame size that looks like
this:

 error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

For fixing this issue I dropped an intermadiate variable.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 64 +++++++++----------
 1 file changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 1b02f0ebe957..858c5cd141b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -575,7 +575,6 @@ void dcn31_calculate_wm_and_dlg_fp(
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
 	unsigned int i, closest_clk_lvl;
 	int j;
 
@@ -608,29 +607,27 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 				}
 			}
 
-			clock_limits[i].state = i;
+			dcn3_1_soc.clock_limits[i].state = i;
 
 			/* Clocks dependent on voltage level. */
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
+			dcn3_1_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			dcn3_1_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			dcn3_1_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			dcn3_1_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
 
 			/* Clocks independent of voltage level. */
-			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
+			dcn3_1_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
 				dcn3_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
 
-			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
+			dcn3_1_soc.clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
 				dcn3_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
 
-			clock_limits[i].dram_bw_per_chan_gbps = dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_limits[i].dscclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_limits[i].dtbclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_limits[i].phyclk_d18_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_limits[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+			dcn3_1_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			dcn3_1_soc.clock_limits[i].dscclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			dcn3_1_soc.clock_limits[i].dtbclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			dcn3_1_soc.clock_limits[i].phyclk_d18_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			dcn3_1_soc.clock_limits[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 		}
-		for (i = 0; i < clk_table->num_entries; i++)
-			dcn3_1_soc.clock_limits[i] = clock_limits[i];
 		if (clk_table->num_entries) {
 			dcn3_1_soc.num_states = clk_table->num_entries;
 		}
@@ -702,7 +699,6 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
 	unsigned int i, closest_clk_lvl;
 	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 	int j;
@@ -740,34 +736,32 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 				closest_clk_lvl = dcn3_16_soc.num_states - 1;
 			}
 
-			clock_limits[i].state = i;
+			dcn3_16_soc.clock_limits[i].state = i;
 
 			/* Clocks dependent on voltage level. */
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			if (clk_table->num_entries == 1 &&
-				clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
-				/*SMU fix not released yet*/
-				clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
-			}
-			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
+			dcn3_16_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			// if (clk_table->num_entries == 1 &&
+			// 	clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
+			// 	/*SMU fix not released yet*/
+			// 	clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
+			// }
+			dcn3_16_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			dcn3_16_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			dcn3_16_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
 
 			/* Clocks independent of voltage level. */
-			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
+			dcn3_16_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
 				dcn3_16_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
 
-			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
+			dcn3_16_soc.clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
 				dcn3_16_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
 
-			clock_limits[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_limits[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_limits[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_limits[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_limits[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+			dcn3_16_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			dcn3_16_soc.clock_limits[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			dcn3_16_soc.clock_limits[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			dcn3_16_soc.clock_limits[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			dcn3_16_soc.clock_limits[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 		}
-		for (i = 0; i < clk_table->num_entries; i++)
-			dcn3_16_soc.clock_limits[i] = clock_limits[i];
 		if (clk_table->num_entries) {
 			dcn3_16_soc.num_states = clk_table->num_entries;
 		}
-- 
2.36.1

