Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5085DCCA473
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 18:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E591112238;
	Fri,  3 Jun 2022 18:51:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE1A112230
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 18:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnRDkbJGIgWW5CrEqBpjSky6qwhAV01e6MYIDjJSzZqpyE1q8HcdDpvBJ/NI203Ym5+UhA+C5JxCSngi66/5RBr9J1UNR8JQq2bbGVRlnx4kJ41j6dGtIhJRQbOmAvi5s6gZ9Mf2aWlDxptUI7prx7YE9Lhm7lxZrCLd6o5hCnzuN5QcaHtNTWpRLmgkVOSvjGqOv2gWBv9IIl79w1H+O0/drgvfKrsKzeIeHrgZiLUKXMCJ05hD1HgYdm0UZYn5FGxFSF9nQuTrJpbw1PWiT8X4rPhB0OPq/qaTYoz+GSNRhCbq7t0zxXkxlRsYN5aAVjUCb9zW2qEU0uo6CNQOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFvmNMqiUhGkO/+ZdKpHUrqHRynJ8W7rA5vwLqbwSXI=;
 b=kHMoyE7nPkuYH9LtCU0HPNhMyPO+D0ukVzR5HnTJuJ1rWgl8S+TpSHDRSCg6Ha+8WVSz8GvT+9AxylBvs28UiwwKCiW07995gjRVp838zL62ndFR8QgdgST4qyys6pAtYC5tAMa++xNWMgPfp5Engea8DbNsMNwbzJOf6/AkHYLeZvr2cS2jianVH5tsJAZ6KhlGLrhWvJnP9A443at6fpFHUZWD9Fnivdkjco6bw2yJ8OQGjxY8AkH2GNJdG+vTbZMYf2FZDbm2YmprTTwobpJ1Y9QY2k3M1mP5PP/kJ+Dpuj3iZRj2C/XaOfagSMz8m+dnZanPIiP9jJ4L0xLvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFvmNMqiUhGkO/+ZdKpHUrqHRynJ8W7rA5vwLqbwSXI=;
 b=jvaMP4r9Qk68OPvScJHfz1A9ztj93NRwDZhqCdar9DB1yNCTobr2QNDyeYNiM0SvMi4yjMNLQ7d98o8H+wSkq+TTD18L9Tg9EtnkdjPfc57FuLea/e8iU9tsork82lgksILfdGXigGd8rp6+tHI1nzbV//jpsYVovLanRhCzDwk=
Received: from BN0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:141::17)
 by CY4PR12MB1687.namprd12.prod.outlook.com (2603:10b6:910:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 18:51:03 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::aa) by BN0PR07CA0002.outlook.office365.com
 (2603:10b6:408:141::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16 via Frontend
 Transport; Fri, 3 Jun 2022 18:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 18:51:02 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 13:51:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amd/display: Reduce frame size in the bouding box for
 DCN301
Date: Fri, 3 Jun 2022 14:50:39 -0400
Message-ID: <20220603185042.3408844-4-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 684aa762-1438-4841-0e36-08da45920208
X-MS-TrafficTypeDiagnostic: CY4PR12MB1687:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1687FF7C3C7C4C03D1CD387A98A19@CY4PR12MB1687.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mn3LY0x6dRcP+kIXrMM84+PHg93Tjv+nEg92rrBs7OPAZyK32zz8RybABRZP0QeK0Dhi3/b5PTcEXgRSknECsdyYoq45H6Tar5iZwIqWPTHvWVdpnX9MZ9oM8qqZlbDlNhIs4Fysji33zYmbhxbtaHUIOlnzlnA+/gMwoEZ4DWcMhEBnsIvY87aPbHXub/LeisMcDDPKGNp9Nfbb9hv7rMjp7c9pzOyUInlJ8/6iJEgEhOQR3exz6ttnbX1awqR3PzZf/szD7BOtzZCEOtuqr+Msa4yclWx0/wV3s8w+C5PrUMPR91zzbzm1UG+WhvCjEDdLH20F0bmVEit1klvLyOBaHN+b6apqxtO+DhSz02ENRztqeFZl1udc8lbYpUTuA7zJ7VX0L5Byl1StKq80I598lkH1gEOtXCQmxDaWMZNR5r6N6jM1wPXeT6SJzuJglq3Jlv+3OFrQw/UN8A/cLIbM4FmGdCFpp2NnlrYHbXwWddp9OqqvKjRQAMUhgfaxdMKBmBFzkjx7a28X29cNw2NwpVe7dFka9tew1/qXWoQ7Hw+HKg8aZRFDyOPcR01yZCSE3zwlQ3PF8aMJ0FWsfgVrdE2IuUbIuAjsAbYfWKvi8cntm+w2766pVu4zf2pyBfCsXgzkWDh6YPCCQukUaemLLSKK2JQke08tImES0LNit2Gjs7Qz8BuURaNHNTve2rsbSjO4hOEmRxeh9nzgug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(70586007)(356005)(40460700003)(82310400005)(336012)(16526019)(5660300002)(83380400001)(47076005)(426003)(36860700001)(54906003)(2906002)(6916009)(8936002)(86362001)(36756003)(70206006)(8676002)(1076003)(2616005)(316002)(186003)(4326008)(26005)(7696005)(81166007)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 18:51:02.7189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 684aa762-1438-4841-0e36-08da45920208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1687
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

GCC throw warnings for the function dcn301_fpu_update_bw_bounding_box
due to its frame size that looks like this:

 error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

For fixing this issue I dropped an intermadiate variable.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
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
2.25.1

