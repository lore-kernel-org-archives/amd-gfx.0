Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C219FC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43107113FC4;
	Fri, 10 Jun 2022 20:53:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EF0113FBA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIoIw/+1y+2ZiURalhZzP2WxSfytQVGfae86NwO+n6UI5hhsk7ns2wKko5P3CrIYdtINfs/up4umJIhGMoIi0Jjhlgrkx6H/oHUkyZvGVMRGvIez75M3g+ZknkOZ62bUZA+ITPnNAaP/WMZbLCco+J5PPnhngO8+yn97WxeoNzLNCcmQqGx1mj+mtqX2oPPTj2jiXv2VWtupwmd0/10dyMibZdYVHTuGe7ciOnYLSBnJ3agp2XhOIxsAxxk1crZE2d/UFJwCXi4r96n1Nq4BBHQqnVAZc8zvwXS2OlOsGdkMgEwPVngCwXJPo3zGlQ1hbkU/YhuW3CWkfiESdnGpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcKkwebvtTttQSHbG5BLoN8u/bkZMzxIgyRwlJ41fpo=;
 b=QliGuMF6rcGTumyhuc3v+CR1f0KAsFeG0/qgWF7ujfqttcKBAMxDOUdBR9HXs68Z6T2/4RcfnIgF0U28jJQ4ss/tu4oL+R121dKxMoTRbn/gHL9Kr57AbJXmJTInyV/hV/BKhtIBNZ7lz0X2eGJzVTsSm3Uul9+AbIen/KSV7awD5s0wEDsFE8aL47t2CbBlzyPee7Uc02ZyZUYXHrFLOLrbfL08T2SHRm57lZ9LAdNY2JO/DN7PeAm00HrhhMpSEK77V/tGWXEwd/5bhfr9nL/3pECm+R1/ZusWeKIdBMey9pjkajrEXC/XiLNuKQ2KYAAv3jjMEtWBs0NQKfiueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcKkwebvtTttQSHbG5BLoN8u/bkZMzxIgyRwlJ41fpo=;
 b=oAv0w8SXvKB7d5SC+fFPflykg5D7vTSWw61I42p8iERAWpATgVE+9QMatNYgG246KyQrgQ+oasy42+BZqrSj/c4hCFq303c5jvh67UcAzpgeG7KJa2B3ETrS/9GxF8fVy06iVPXlUwCvFMvMALvR9PvUHJuAxgJ/RL3u8Q5ln1Q=
Received: from MWHPR15CA0040.namprd15.prod.outlook.com (2603:10b6:300:ad::26)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 20:53:11 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::e6) by MWHPR15CA0040.outlook.office365.com
 (2603:10b6:300:ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:11 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:06 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/23] drm/amd/display: Reduce frame size in the bouding box
 for DCN301
Date: Fri, 10 Jun 2022 16:52:27 -0400
Message-ID: <20220610205245.174802-6-hamza.mahfooz@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 53e8dfe1-cc56-430f-b8bb-08da4b233b38
X-MS-TrafficTypeDiagnostic: IA1PR12MB6627:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB662744BDA77371F094BE0B53F4A69@IA1PR12MB6627.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPI7iFlCWj0jGkBeg1Xlc0qqjF2Rbb40MWaadTA8rgHKoHiJ/ontmkTzw+Dk3cUIgCKY7P4JWglhYMmVR2p7DyGv9xHFYRUXvCWu+sR8/o+IyOsrGF/24XdudtcmQ6t2ORR4IncpmghHkC48XQMUkmt1qEdhr1Pg1cMrIfKN83ahee+g8CxI5VeEZJFFM4O8Vw2jpggvRQGKGvb029lPW7Ucgvehh6pxCfxofHYEzy6sExtFIqdPzaEON8ZzOayiorhNv7sePT7rNuWOhlt8o9oDomanzPB64fBGRGCtDinLAWZDbOjBwVJG4nIXwMa4jteIfMjEJPG/5uB6iD39rvuQqUKEF6xbnq3LVP5uUTuUx4y4p60bkTZWaE6Uwvp8i6ZhkM2hbhKiu7sPFAmXJMnhbmS5nvG7Ba2KsKxj26oP6JpglN+B5W4nn/FJUHdBdcTEHk6wNkp1qePMt/xSy7n3Q807hZo6P2fhRQ9gnA062VAJ0KTnsK1t0OImeRHbY5HyILMXXVnGZWCCdZt2a/gr5DgEmnz8N70ciLsWBF9cKFXb3l01sbFLY4VC06DEDvd0GPz0Y4IME8p1A4xbxJMrwPgN+m03qCXHf59sPq1qvu/nEh+QPBBHRffIEZ7mC/AkGw+VOeht7xiVUFj2ZeF8OY1aI5H1uA40ZpD6xFWlRlB3K276Xkx2VqUku7wVdLtiJciJn0P/QkMtT2kYn7ptY+gybiE2GGUySry0cPKGIiKZRJ+O1ahufHqhMlY+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(44832011)(70206006)(8676002)(36756003)(4326008)(2906002)(54906003)(316002)(6916009)(7696005)(6666004)(5660300002)(8936002)(26005)(82310400005)(508600001)(2616005)(1076003)(336012)(426003)(47076005)(83380400001)(356005)(186003)(16526019)(36860700001)(70586007)(81166007)(40460700003)(86362001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:11.3983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e8dfe1-cc56-430f-b8bb-08da4b233b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
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

GCC throw warnings for the function dcn301_fpu_update_bw_bounding_box
due to its frame size that looks like this:

 error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

For fixing this issue I dropped an intermadiate variable.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 30 ++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 0a7a33864973..62cf283d9f41 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -249,7 +249,6 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 {
 	struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
 	unsigned int i, closest_clk_lvl;
 	int j;
 
@@ -271,24 +270,21 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 				}
 			}
 
-			clock_limits[i].state = i;
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
-
-			clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-			clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-			clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+			dcn3_01_soc.clock_limits[i].state = i;
+			dcn3_01_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			dcn3_01_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			dcn3_01_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			dcn3_01_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+
+			dcn3_01_soc.clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+			dcn3_01_soc.clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+			dcn3_01_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			dcn3_01_soc.clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			dcn3_01_soc.clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			dcn3_01_soc.clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			dcn3_01_soc.clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 		}
 
-		for (i = 0; i < clk_table->num_entries; i++)
-			dcn3_01_soc.clock_limits[i] = clock_limits[i];
-
 		if (clk_table->num_entries) {
 			dcn3_01_soc.num_states = clk_table->num_entries;
 			/* duplicate last level */
-- 
2.36.1

