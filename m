Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833D9C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 18:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0766B11223F;
	Fri,  3 Jun 2022 18:51:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5602511223B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 18:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLKQp0BWoxV4HgbrrsPSgoqE0KJoQLSO4PPoFfoKafmQqBzHvAdQ4bDGbdRQ0inBWXs9mkdDaaXAkdVg3SdsXsdSXElHSsPSGm8v74/ioIuSPqahlUv1cpmjL4xHcPye2nRkyMlkjkzAenjjZiA0T7ZFtvxF4JmEkFrz2Av5PZqgx6btphLJokVjklh6V1VnAFJhOlHdRJzFSK6dExjJ426RzV7ZSTv92E+hPqOlsemXRYfZ4tD2Uzpn/s+ZIhJ3Z551fy9NwPhzpVH99Fe+ZLoBxOMSN+fDxhtQpccOk6bxJJMzGdk7Jh7riO5gzGgJaqk4Xcx/HRWhzk2NljISAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txeo07QhZf2A7sP76Q/JIgP5AmUdEjHBupshL569hJw=;
 b=c1knhC6O3xWFLpd1/YSb8SH7y/4IwqJk584FWCRbKTLW5g8w4HuYmJ4nOkLG5qkUcPoE1jA6c3iQcA2R+0D2w2UlibcwaFwu2p0VBmIskAiBNpQoNzyuLM1BEsc6NnU/dVbHu0QBvqWDfQJNIRnyfuVQ+qFTuj15a4UcuOnlam1c4VyVoOCstVmof3gklp5qbVVSFE22UkdBEEZ+qPUq9yrI7958PJUmkWfNFV4R3QW3uciK3OeaptERdBzkPRIfOdI1UNOKMrdPh36tYh67wmCK5KXJPMOAC+B0y1uobAeKGAm/UvJXoCQjP2iau+D7Ussl3REfIpoSM0XWChmDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txeo07QhZf2A7sP76Q/JIgP5AmUdEjHBupshL569hJw=;
 b=u7k0ecR5xnk1JxSNnNcvfh/SBVvui86ZQ1enjPERtmSttk2L2SRpuXcmcIcbvRmdEf7DxM1JFj11RLNwVBrxago5SXv6X6LBZBVUay70FqVlye2nYeWT5kYKQ1YMLTh7C4MLPhOHvLUTZSyxj0KX2eqd/8ml+sIgiOSzCUTNlrI=
Received: from BN0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:141::32)
 by MWHPR12MB1439.namprd12.prod.outlook.com (2603:10b6:300:12::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 18:51:04 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::a6) by BN0PR07CA0011.outlook.office365.com
 (2603:10b6:408:141::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 18:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 18:51:04 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 13:51:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amd/display: Reduce frame size in the bouding box for
 DCN21
Date: Fri, 3 Jun 2022 14:50:41 -0400
Message-ID: <20220603185042.3408844-6-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e8a4440-a2ba-4f7e-9ae7-08da4592031c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1439:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1439D51715ED1DC8D28C725F98A19@MWHPR12MB1439.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RqEP5+R5lEW7RjFrlgkHbJ/eGpxmkh6qUjK7GNH6oQvfyxEbPG9dSj+HImpO9Cg18/ZjeHQaSxqQu6NwnjPg21zi9O8VAQZ2LVfDQa3Zp0aY0iUyEijz2HKQyFf7tPPcUr399UFYSFriHq1ki8b29kdBk1UI5v/+Xh0lU/1cSaTLF0Bkb4ro4fyUb2kWSCXNSS2KbcjBhXQacQanOrZ5x7NkJfDJM/V5mwL1LMPg3SGbW06WkeSQFab2QLjJaxPzsQl8o2OhRhbtgU2KIkr89R5ZE2YsqUOO2NLk13oWdyhFE3d/5eW/XRhUWXErARh8oPOFgJ4KLelN3x5RcWPW6cIzvCWUh5G84BUR9ihpySBYZpZIrVzZhxHl0pdU2MEV2NSbValLx/1YJwjZYD9T6a96ByTBZ8c+v1T8JTZd/2vcbvtDwu9v/HOg9eLVmmz2uLwAd3GgJzGZq7DEaqek3Ou8/CS86LYUkynE6yA2iREryb1o0TwlThMWsWz5WL0B7Qvd1A8Xqg/tkscrTFJCNReMHbrP/OSrTf/NUlc18ubb6EO6Oelvmdj841s3fmbYHLZRQD4DsNBG2P7X57aHKLL2/IVWJtiSdgcJvs0Z8+kwbZMNq7bJkgSg3fgHZHnI8v5D+wIHDtXOELiy36TNwLJpGhGnqPop7ssmfs3v7PddYVTNsUCIxbDqg4YcffqMu5+rhnqbXw6WaIOUp0RJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(82310400005)(508600001)(2906002)(5660300002)(26005)(16526019)(81166007)(36756003)(2616005)(426003)(4326008)(40460700003)(70206006)(70586007)(47076005)(7696005)(86362001)(8676002)(316002)(6916009)(36860700001)(6666004)(356005)(54906003)(336012)(8936002)(1076003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 18:51:04.5469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8a4440-a2ba-4f7e-9ae7-08da4592031c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1439
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

GCC throw warnings for the function dcn21_update_bw_bounding_box and
dcn316_update_bw_bounding_box due to its frame size that looks like
this:

 error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

For fixing this issue I dropped an intermadiate variable.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 29 +++++++++----------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index d9cc178f6980..c2fec0d85da4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2004,7 +2004,6 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 {
 	struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
 	unsigned int i, closest_clk_lvl = 0, k = 0;
 	int j;
 
@@ -2017,7 +2016,7 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	ASSERT(clk_table->num_entries);
 	/* Copy dcn2_1_soc.clock_limits to clock_limits to avoid copying over null states later */
 	for (i = 0; i < dcn2_1_soc.num_states + 1; i++) {
-		clock_limits[i] = dcn2_1_soc.clock_limits[i];
+		dcn2_1_soc.clock_limits[i] = dcn2_1_soc.clock_limits[i];
 	}
 
 	for (i = 0; i < clk_table->num_entries; i++) {
@@ -2033,24 +2032,22 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		if (i == 1)
 			k++;
 
-		clock_limits[k].state = k;
-		clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-		clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-		clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
-		clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+		dcn2_1_soc.clock_limits[k].state = k;
+		dcn2_1_soc.clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+		dcn2_1_soc.clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+		dcn2_1_soc.clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
+		dcn2_1_soc.clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
 
-		clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-		clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-		clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-		clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-		clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-		clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-		clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		dcn2_1_soc.clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+		dcn2_1_soc.clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+		dcn2_1_soc.clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+		dcn2_1_soc.clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+		dcn2_1_soc.clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+		dcn2_1_soc.clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+		dcn2_1_soc.clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 
 		k++;
 	}
-	for (i = 0; i < clk_table->num_entries + 1; i++)
-		dcn2_1_soc.clock_limits[i] = clock_limits[i];
 	if (clk_table->num_entries) {
 		dcn2_1_soc.num_states = clk_table->num_entries + 1;
 		/* fill in min DF PState */
-- 
2.25.1

