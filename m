Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D818C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 16:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2464112769;
	Wed,  8 Jun 2022 16:49:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E671112769
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 16:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxRhjQpAaaMQeoi9xhvEULNZRQUwceHx6La9fxU8nr/Vw7ZhzT7NUbG1sqFFZ3xCnIFh0Etea6fubEdjFh+n2bNxecC7Hw+Z4i//UX7kSvwCibi9CxNY1GCPBGGYqYdAyu3Y3999ZeKIALH/HgFVjN/mktdIU66qfpue7QQRJrunjxVt1AzpJFeSmRhe1D5LCIOMJi+fWHwGnnElr1FcJjmQ80YcCN0mTkM5GHL+yQtlnXGmaMchJjBxh8W6jwfWwasAmku6ZDQsoZXN7Nqq/zFGKTDT/hs0UCXe/hXswzo74GOj5E+9vyoQ9SxPkCxJ0mrc/fUvcCUssKP4NaMSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qweIg7pUzVEX3Yw9vdHzl36CCp4KLEnOsLOwgJdF1v8=;
 b=Ri6shQ9b7To1q9m6BKt2sgPauisO9QcWQjVDMZeiTCu/so5LeP0z7jAkA7/frcrD2ccNXUDwH/dKGmb3+BMbmhrivnE6h1N672WF6KBjXizDPvu06N+7I4N+QORjk9wq4AEAjOAfh2ILhV+kDA9pw90510vT3CSlbCt3Fr49v9YZfdsQnPi5zG1ZHcBC8t65RIkAN0WQdTXa5hqERY9W/wUIqNavzifO8YLZlX9HOvoZRrL37EjlS5FEle3FgD/I5sLSaWhBGVK0tcAGSc1T6yzRegZTwInI727DplzjgXnza/nz98f6mndG0UsWVA1R9MZC51iarOOiETMvQ8qidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qweIg7pUzVEX3Yw9vdHzl36CCp4KLEnOsLOwgJdF1v8=;
 b=FHCp6AfvstABe7Zm0itnSlfz9YlnZQjx8GCO1ku8pxlm9Ut+sPm+oIL2xC5RNU0aRMeoUPW9AW2g5ZJyCkGwbYTVyVuVYGp1f2DQlwiDGktinTQgvQbjU0pbYO7d6vQpp91gEP7HNyFiKF2qIOiZ5sfQqh/pHLOBJQ74FeQ8Zco=
Received: from BN0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:141::30)
 by BYAPR12MB2904.namprd12.prod.outlook.com (2603:10b6:a03:137::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Wed, 8 Jun
 2022 16:49:20 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::4b) by BN0PR07CA0015.outlook.office365.com
 (2603:10b6:408:141::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Wed, 8 Jun 2022 16:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 8 Jun 2022 16:49:20 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 11:49:19 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Use pre-allocated temp struct for bounding
 box update
Date: Wed, 8 Jun 2022 12:48:56 -0400
Message-ID: <20220608164856.1870594-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4601fa2a-2a4c-4f04-e09b-08da496ed569
X-MS-TrafficTypeDiagnostic: BYAPR12MB2904:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29042996B2473A89F641B0E182A49@BYAPR12MB2904.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sls78o5sIPZVNA6pD7YyuLlddquxRZJyU010KnfnLcpnbnWj9rNNS2p1wZQPK6aQlabOzcyGKYeiQOQvfjIt/gmpE9GUJHXg8KIuWZ5tA6Q+0n/sHFYsWziI0mJqX2U5zuZ6FeC2SPPqRSGLYeLjlKh1ZmVZ8H7DEA61y2ytqW/tOIukdLW/38sdaxdRUZRn6QZVEBttuOzGhzNdui9ftyJ1+nrXoviRgMKnEGCNJTO1coWkhrRR1fdHGkJTdlqtoo/E3S3QC+48SNnJyQvQT8hr0gnvqmfq4LQ+SELySQ4Jiaea/nmc8iZtty2ET7n5CpVetEgoreQLxdp1596HLam9MMTPjUc5U8t2wR1Z8W7RNW1cqEHqc+msawkf6ofGfiUV3ikv6fg7h/CHrvx3h/85/tBwax2qXpZC2C6ZZTqy8bXRiYUagT14o3o9ZELKZk+ZLdpfG2xNx07pPghWmalEXMRwMR/IdJD2VVHdDaxB+w8aTh/OXQjaQnn3VtA0xe5KZSgmcdlerzGFmZFZHpfREP5m0nwyL2DDUUtHYu+h3ek1x08JLidzB9OaBnaaWycyDXBfwBxAyK4FJKNu0nl7RmeKrxo9AMWBE/sW6A0KlDzSyCkp1gC8RypyQmLZNYSV54QpfRTqVkJjlanTLOa+e1lAtlOBko0SXuXNEDpVtRY58HlGPYrdkuAu1Go0a175pa8yMu629tGt4o8nYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(54906003)(36860700001)(316002)(6666004)(82310400005)(30864003)(4326008)(8676002)(15650500001)(2876002)(2906002)(70206006)(70586007)(86362001)(6916009)(36756003)(7696005)(81166007)(83380400001)(40460700003)(26005)(5660300002)(2616005)(336012)(1076003)(186003)(426003)(16526019)(356005)(508600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:20.1437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4601fa2a-2a4c-4f04-e09b-08da496ed569
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2904
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo.Siqueira@amd.com,
 aurabindo.pillai@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

There is a theoretical problem in prior patches for reducing the stack
size of *update_bw_bounding_box() functions.

By modifying the soc.clock_limits[n] struct directly, this can cause
unintended behavior as the for loop attempts to swap rows in
clock_limits[n]. A temporary struct is still required to make sure we
stay functinoally equivalent.

[How]

Add a temporary clock_limits table to the SOC struct, and use it when
swapping rows.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 33 +++++-----
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 36 ++++++-----
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 64 +++++++++++--------
 .../amd/display/dc/dml/display_mode_structs.h |  5 ++
 4 files changed, 82 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index c2fec0d85da4..e247b2270b1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2015,9 +2015,8 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 
 	ASSERT(clk_table->num_entries);
 	/* Copy dcn2_1_soc.clock_limits to clock_limits to avoid copying over null states later */
-	for (i = 0; i < dcn2_1_soc.num_states + 1; i++) {
-		dcn2_1_soc.clock_limits[i] = dcn2_1_soc.clock_limits[i];
-	}
+	memcpy(&dcn2_1_soc._clock_tmp, &dcn2_1_soc.clock_limits,
+	       sizeof(dcn2_1_soc.clock_limits));
 
 	for (i = 0; i < clk_table->num_entries; i++) {
 		/* loop backwards*/
@@ -2032,22 +2031,26 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		if (i == 1)
 			k++;
 
-		dcn2_1_soc.clock_limits[k].state = k;
-		dcn2_1_soc.clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-		dcn2_1_soc.clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-		dcn2_1_soc.clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
-		dcn2_1_soc.clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+		dcn2_1_soc._clock_tmp[k].state = k;
+		dcn2_1_soc._clock_tmp[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+		dcn2_1_soc._clock_tmp[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+		dcn2_1_soc._clock_tmp[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
+		dcn2_1_soc._clock_tmp[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
 
-		dcn2_1_soc.clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-		dcn2_1_soc.clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-		dcn2_1_soc.clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-		dcn2_1_soc.clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-		dcn2_1_soc.clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-		dcn2_1_soc.clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-		dcn2_1_soc.clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		dcn2_1_soc._clock_tmp[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+		dcn2_1_soc._clock_tmp[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+		dcn2_1_soc._clock_tmp[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+		dcn2_1_soc._clock_tmp[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+		dcn2_1_soc._clock_tmp[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+		dcn2_1_soc._clock_tmp[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+		dcn2_1_soc._clock_tmp[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 
 		k++;
 	}
+
+	memcpy(&dcn2_1_soc.clock_limits, &dcn2_1_soc._clock_tmp,
+	       sizeof(dcn2_1_soc.clock_limits));
+
 	if (clk_table->num_entries) {
 		dcn2_1_soc.num_states = clk_table->num_entries + 1;
 		/* fill in min DF PState */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 62cf283d9f41..e4863f0bf0f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -254,6 +254,9 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 
 	dc_assert_fp_enabled();
 
+	memcpy(&dcn3_01_soc._clock_tmp, &dcn3_01_soc.clock_limits,
+	       sizeof(dcn3_01_soc.clock_limits));
+
 	/* Default clock levels are used for diags, which may lead to overclocking. */
 	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		dcn3_01_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
@@ -270,29 +273,32 @@ void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 				}
 			}
 
-			dcn3_01_soc.clock_limits[i].state = i;
-			dcn3_01_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			dcn3_01_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			dcn3_01_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			dcn3_01_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
-
-			dcn3_01_soc.clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-			dcn3_01_soc.clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-			dcn3_01_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			dcn3_01_soc.clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			dcn3_01_soc.clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			dcn3_01_soc.clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			dcn3_01_soc.clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+			dcn3_01_soc._clock_tmp[i].state = i;
+			dcn3_01_soc._clock_tmp[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			dcn3_01_soc._clock_tmp[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			dcn3_01_soc._clock_tmp[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			dcn3_01_soc._clock_tmp[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+
+			dcn3_01_soc._clock_tmp[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+			dcn3_01_soc._clock_tmp[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+			dcn3_01_soc._clock_tmp[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			dcn3_01_soc._clock_tmp[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			dcn3_01_soc._clock_tmp[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			dcn3_01_soc._clock_tmp[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			dcn3_01_soc._clock_tmp[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 		}
 
 		if (clk_table->num_entries) {
 			dcn3_01_soc.num_states = clk_table->num_entries;
 			/* duplicate last level */
-			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states] = dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
-			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
+			dcn3_01_soc._clock_tmp[dcn3_01_soc.num_states] = dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
+			dcn3_01_soc._clock_tmp[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
 		}
 	}
 
+	memcpy(&dcn3_01_soc.clock_limits, &dcn3_01_soc._clock_tmp,
+	       sizeof(dcn3_01_soc.clock_limits));
+
 	dcn3_01_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 6da702923226..7be3476989ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -580,6 +580,9 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 
 	dc_assert_fp_enabled();
 
+	memcpy(&dcn3_1_soc._clock_tmp, &dcn3_1_soc.clock_limits,
+	       sizeof(dcn3_1_soc.clock_limits));
+
 	// Default clock levels are used for diags, which may lead to overclocking.
 	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
@@ -607,32 +610,35 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 				}
 			}
 
-			dcn3_1_soc.clock_limits[i].state = i;
+			dcn3_1_soc._clock_tmp[i].state = i;
 
 			/* Clocks dependent on voltage level. */
-			dcn3_1_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			dcn3_1_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			dcn3_1_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			dcn3_1_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
+			dcn3_1_soc._clock_tmp[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			dcn3_1_soc._clock_tmp[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			dcn3_1_soc._clock_tmp[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			dcn3_1_soc._clock_tmp[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
 
 			/* Clocks independent of voltage level. */
-			dcn3_1_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
+			dcn3_1_soc._clock_tmp[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
 				dcn3_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
 
-			dcn3_1_soc.clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
+			dcn3_1_soc._clock_tmp[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
 				dcn3_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
 
-			dcn3_1_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			dcn3_1_soc.clock_limits[i].dscclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			dcn3_1_soc.clock_limits[i].dtbclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			dcn3_1_soc.clock_limits[i].phyclk_d18_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			dcn3_1_soc.clock_limits[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+			dcn3_1_soc._clock_tmp[i].dram_bw_per_chan_gbps = dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			dcn3_1_soc._clock_tmp[i].dscclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			dcn3_1_soc._clock_tmp[i].dtbclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			dcn3_1_soc._clock_tmp[i].phyclk_d18_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			dcn3_1_soc._clock_tmp[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 		}
 		if (clk_table->num_entries) {
 			dcn3_1_soc.num_states = clk_table->num_entries;
 		}
 	}
 
+	memcpy(&dcn3_1_soc.clock_limits, &dcn3_1_soc._clock_tmp,
+	       sizeof(dcn3_1_soc.clock_limits));
+
 	dcn3_1_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
@@ -705,6 +711,9 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 
 	dc_assert_fp_enabled();
 
+	memcpy(&dcn3_16_soc._clock_tmp, &dcn3_16_soc.clock_limits,
+	       sizeof(dcn3_16_soc.clock_limits));
+
 	// Default clock levels are used for diags, which may lead to overclocking.
 	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 
@@ -736,37 +745,40 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 				closest_clk_lvl = dcn3_16_soc.num_states - 1;
 			}
 
-			dcn3_16_soc.clock_limits[i].state = i;
+			dcn3_16_soc._clock_tmp[i].state = i;
 
 			/* Clocks dependent on voltage level. */
-			dcn3_16_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			dcn3_16_soc._clock_tmp[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
 			if (clk_table->num_entries == 1 &&
-				dcn3_16_soc.clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
+			    dcn3_16_soc._clock_tmp[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
 				/*SMU fix not released yet*/
-				dcn3_16_soc.clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
+				dcn3_16_soc._clock_tmp[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
 			}
-			dcn3_16_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			dcn3_16_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			dcn3_16_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
+			dcn3_16_soc._clock_tmp[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			dcn3_16_soc._clock_tmp[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			dcn3_16_soc._clock_tmp[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
 
 			/* Clocks independent of voltage level. */
-			dcn3_16_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
+			dcn3_16_soc._clock_tmp[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
 				dcn3_16_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
 
-			dcn3_16_soc.clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
+			dcn3_16_soc._clock_tmp[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
 				dcn3_16_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
 
-			dcn3_16_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			dcn3_16_soc.clock_limits[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			dcn3_16_soc.clock_limits[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			dcn3_16_soc.clock_limits[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			dcn3_16_soc.clock_limits[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+			dcn3_16_soc._clock_tmp[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			dcn3_16_soc._clock_tmp[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			dcn3_16_soc._clock_tmp[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			dcn3_16_soc._clock_tmp[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			dcn3_16_soc._clock_tmp[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
 		}
 		if (clk_table->num_entries) {
 			dcn3_16_soc.num_states = clk_table->num_entries;
 		}
 	}
 
+	memcpy(&dcn3_16_soc.clock_limits, &dcn3_16_soc._clock_tmp,
+	       sizeof(dcn3_16_soc.clock_limits));
+
 	if (max_dispclk_mhz) {
 		dcn3_16_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 74afa10e70f8..2bdf60846762 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -161,6 +161,11 @@ struct _vcs_dpi_voltage_scaling_st {
 
 struct _vcs_dpi_soc_bounding_box_st {
 	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
+	/*
+	 * This is a temporary stash for updating @clock_limits with the PMFW
+	 * clock table. Do not use outside of *update_bw_boudning_box functions.
+	 */
+	struct _vcs_dpi_voltage_scaling_st _clock_tmp[DC__VOLTAGE_STATES];
 	unsigned int num_states;
 	double sr_exit_time_us;
 	double sr_enter_plus_exit_time_us;
-- 
2.36.1

