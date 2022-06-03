Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3BCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 18:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565C411223C;
	Fri,  3 Jun 2022 18:51:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B4411222D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 18:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUf3I03XJfz+0tanYch3iCWeZ2Qu7w/F6fg6BQY0NoiSHjdUSIZ2C+JHbwUFbbYoxKxyGYlBguYaxLK6xYI8X9ka1S0qHSi78SkTQoXY6c2GQs20JSzOcV45lO02dQ93yp2NeTIHx2uo4r2pUycoNolx9+0Pdob9Z/xaqr/EzM9l8GuIb9rSYb41yhTcwCiY3hzaFkSRfe+98NUSJiVrXoOVEvrsxlUEKXWcUbB5LoZViwJh8FuO7gewV5ow6Sm32vFaW3rD4kdSOSDtochGsB34HaIJScuv2730D1LoP0+0f8w8k0egAhnBYl27A24QeN10ZErNWZhQjqoNkFWsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h81RH0sgB1GneHy0NDSBgV8lItX4o3bz0rl4DfkR63w=;
 b=elASTNaN7QIpbJTwQbOrlpMZZuGbMqDpOwulTAzkNd8IuJ2VrtVN1C3qoANQS5u+M+n9+dlWiqnyhvnYtIMaBeMwhOtJIdv1JvqpALxXuJj2pXgzObN/7bRyoxLh1AeE6fa+hoSMHhfiUS4cAVt9hoeCF6xPy1pYFF7j0OcrFfQJXtHeYj5ysfzjIdUNuQz7epOT8YSPx6mjjMaLVSthIYNb4jCMxA3YpKwoXthBa6rUXi6QLw4GqxxdUe6o4NwiZZiwAImafzJG48l5tPIZwxwRGhiIgA85VNgEuLM7DalpGYKs1vhqBFPEjI1IGin5sPQYogmIwr6u57rlzz1rZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h81RH0sgB1GneHy0NDSBgV8lItX4o3bz0rl4DfkR63w=;
 b=EzPuC/Gh1WPrJMkBljZhTkS/LviDWf38uwhnQnFuvqQ0G9w9Xr8mSZL+8er7WEUhWWETe+TYXr5xVtdLkeWr7x0RUrk13yccnIwgG+/Imu/Dc+nHtt3wqdkDOkJ6E3ub2Y+JRDanCcfwi0d0s4fPfTi1JqjNZIoqJyy/vjqSlwc=
Received: from BN0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:141::16)
 by BYAPR12MB4725.namprd12.prod.outlook.com (2603:10b6:a03:a2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 18:51:04 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::9e) by BN0PR07CA0021.outlook.office365.com
 (2603:10b6:408:141::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.14 via Frontend
 Transport; Fri, 3 Jun 2022 18:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 18:51:03 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 13:51:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amd/display: Reduce frame size in the bouding box for
 DCN31/316
Date: Fri, 3 Jun 2022 14:50:40 -0400
Message-ID: <20220603185042.3408844-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42a94765-9143-4c24-1b11-08da45920278
X-MS-TrafficTypeDiagnostic: BYAPR12MB4725:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4725A574D61CFC083B9F3A3998A19@BYAPR12MB4725.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kt7X0nSbrmUkQpDmiKwqc1mALOpxzPPO/XHbOH338wiG34FrK0t10fEGIHFeRhtDOlDdhtlMvdwb9TeiRB7g98VBlL1TZjI9nFklvIgs+WmuSqVetWicu7Le8H+B7hq6M2NpjkL/1YJkcKZ5g61Z2MVfAXBWwryBgk9zVaW6r/aNt62sy5hW1+BYwOmBxPChWlvKk2DopjhrsokaDims1KAnkXbzgb/du/GLuK9JSibbG/JJR6MBh6AibO8+sffoFBILpx0bvMOWmqw6escqTdQ6YgAuYbtqhcz2LopyLANxAtuCeeTrDxa2l14y/M5mCEw0OIpwM3UzNUxh0hqXGI4P1keDtPXVM4FkcwdpmcRC6Eg6cmfB8Y1RvsHk/cgtVrMbl6ttlWTS/8HFxLBZceAwAxEymsE7Cw6Gc/5GhxbtQGApPshHuqj/pP64iBIIlcMpwZ1XRLjETeQuuBHTTjwLzotMUUBVYrtRm0bkiqJ9m8x+ackP5na7G7FngIYAfHnG4zmw8v79kXAl0r0nv2zNGoWM3UGvWxqpCox1iwHJ1ezRtMYCEwwmmLFcTf8CtvI9S0P3fchmHIZVTqKfIMznQnj2URqA+1fotXubsPTCbn9wmjYVd9hHr/nwq7+HX8YmMHZM4Y/HOytVKRtfeJ9PmAjBVuG4Jm+meWC3k9PUGjvFpdT3QHc40EJKyq6w7903IsEscA9Yix8qm9Efg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(4326008)(336012)(8676002)(36756003)(86362001)(81166007)(8936002)(5660300002)(2906002)(1076003)(47076005)(70586007)(70206006)(16526019)(2616005)(186003)(26005)(83380400001)(6666004)(54906003)(82310400005)(426003)(7696005)(316002)(6916009)(508600001)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 18:51:03.4688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a94765-9143-4c24-1b11-08da45920278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4725
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GCC throw warnings for the function dcn31_update_bw_bounding_box and
dcn316_update_bw_bounding_box due to its frame size that looks like
this:

 error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

For fixing this issue I dropped an intermadiate variable.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 58 +++++++++----------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 54db2eca9e6b..ee898bc93fd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -574,7 +574,6 @@ void dcn31_calculate_wm_and_dlg_fp(
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
 	unsigned int i, closest_clk_lvl;
 	int j;
 
@@ -607,29 +606,27 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
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
@@ -701,7 +698,6 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
 	unsigned int i, closest_clk_lvl;
 	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 	int j;
@@ -739,34 +735,32 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 				closest_clk_lvl = dcn3_16_soc.num_states - 1;
 			}
 
-			clock_limits[i].state = i;
+			dcn3_16_soc.clock_limits[i].state = i;
 
 			/* Clocks dependent on voltage level. */
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			dcn3_16_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
 			if (clk_table->num_entries == 1 &&
-				clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
+				dcn3_16_soc.clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
 				/*SMU fix not released yet*/
-				clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
+				dcn3_16_soc.clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
 			}
-			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
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
2.25.1

