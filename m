Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26009C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD89B5CA8;
	Fri,  5 Aug 2022 17:59:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D56B5CA8
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW1gbeqy9tiGv0p6jW8l9eEtrjYn1hlBPcQWrLrRPcADF0uvijXiF1+1V7R/R6d9x+71TewZWngGTxRvyJ6RtO3luS32Jt9uDlRp1S4+uZppH8epe9fsPUmR34Rp9XjU5d8ZqB9TF6jyiuskKpH2At3QlX/uosAMik7Z7zeAIPyljAlt9Ow9x+tQLYkX6SJ9ZZ1ctTczdkgMcPKYDYC0mshoN7jOJYZMs/ZFYTxlg7D2i0O1scEbTRjqA6+iWUKYF0UK+eE5YSs8/x/3UgUDoldFASYL3C0jU3Jg9Q0ggP8F5hDSa7ev8sYfKGOhXWRI2WnrwTjSnAKI5IAMqn1RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCSNWWV4jWcFeTgaxt73+kS1mBOmiueCruJAhuPMbWg=;
 b=YTZSZgocL3IgP38CIP2l0czbVCz2Ks9mkhO1jKDsvKxYeDDzDv0XOy3AAhVuIpvp48u3MuHkh8vr4+WUKP8mSD82IwRNQByf/L/KhcPneTV6IvBiJs2o0ORcR7bOBjXgiRICzEgNm2mUr5DkP/jBllea0+2r2TOwOUMEWtdYHCXqABrjTfH8Gi/cwpV/mN8WPZMFm1h9V+0WmXuh4Cf8DIR1mTSZUplY53aa/5COr+GWcu2+myYNm6P4H062B59/IxGt77TZMIiQFPTHAkoq3BIw/c28uJnnmkbnmkpEkxCYDZXvft5WMXBHigCp1l+zBVIRguLWLvkEp1JXuTJ1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCSNWWV4jWcFeTgaxt73+kS1mBOmiueCruJAhuPMbWg=;
 b=lmPQDXU2ucfxBvBL3l1tyMCMI166X1EWohhS8GKKO+JjuWBlbz93vpC0tQHPrhVmz9jPkA2JvG9QcZwwgEMqns1FRk7rkrsjTmiHb8tmdqMfCkXuXI0jn1J1EU/06+DbTsjDzZAK17DB5iiG7rH4R1XSTK6dMcSLXsO2inL9n60=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by DM5PR12MB1692.namprd12.prod.outlook.com (2603:10b6:4:5::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.14; Fri, 5 Aug 2022 17:59:37 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::9d) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 17:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:59:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 10:59:18 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:59:12 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/32] drm/amd/display: Revert "fix 32 bit compilation errors
 in dc_dmub_srv.c"
Date: Sat, 6 Aug 2022 01:58:00 +0800
Message-ID: <20220805175826.2992171-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e221a53e-30ae-44e4-d771-08da770c42bd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1692:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYMSvmFccSS0tqUwHN+kzgJnghGRVv7SnrBYIsTYmbY/jUp5FJwSj6aTzYvWWlulWfebS12CdaVZL0VLTTxl8bagH6EhK3BGbmAwJCYHcgWZ9zak78aKqCB7Rep3JG6P7a/DA6tdttaZ7t0GwQByTZ2ghFqm+B6r+YbmwYysHUOA+npv+6rHqwi4TlipKpDHPnkWZhMvZcsvknOtE8jhgk38pnF+FQxPi8P7ZN1cmjNFfJg6P/ugMWc+Rzr4srFrBBKJCNx5VZNpgfgjbZBcvrbpXQFy/mjD1qxV3zJS1ftw91P+rzxGufBCqjgqi1q1CVOsBp2nvbHnZFJ/aQHnYUYxvr4aOPW/UDH+laUxykdNZ2s/Sx+b4XfZs9b8goHONz/xkJHKYUms6xJCgveqoD57AGH/POzylKHmWGLggSPR/bSePIxeoK5eLfMN/GZsD5cW5z4rShoUeW76EuQbsLLc3U3IQIFw007SzJtXuK32PuQ9qwPyB3Cc8ne66zfCSzw6gFoZNQ5Gh8eeOqTeu+HxCvWqcrh5fabd6HVUC/w2o3WrB1RfbvASt2+OUe9HqTTw9oYHvvZXBfCOvndC5HcKEqOTpjWoS7IvSawBKjwploMJHuNqExtOPYidzTiOTUIuIdafeQLz6QPBwx5pyZQU1ENeYC2Iyz4oYxpfC4Ox3SAORA8Rp3H1ApBfN0n4Tw2jmW5EbQ+kJXQDGU3BW5J6FkmhBa6uf9cecLp6kljVIVpe7s9jn7mC5Qk4AIr4RNFKBcZ7G1/IHH3xM6Nw+HvAF1DVWBBaPBuCbVgaAz+KWb9Eg6b4dvLeJt0WwWbzuocR/yZ98wO3EVtyj/NPiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(40470700004)(6916009)(2906002)(81166007)(36860700001)(8676002)(47076005)(356005)(40480700001)(5660300002)(70206006)(82310400005)(4326008)(70586007)(86362001)(82740400003)(26005)(316002)(478600001)(40460700003)(7696005)(41300700001)(8936002)(83380400001)(36756003)(54906003)(2616005)(6666004)(336012)(186003)(426003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:59:36.7522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e221a53e-30ae-44e4-d771-08da770c42bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Revert commit that refactors SubVP calculation incorrectly.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 67 ++++++++++----------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 2d61c2a91cee..c7582f834a43 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -433,28 +433,27 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	pipe_data->pipe_config.vblank_data.drr_info.use_ramping = false; // for now don't use ramping
 	pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms = 4; // hardcode 4ms DRR window for now
 
-	drr_frame_us = div64_s64(drr_timing->v_total * drr_timing->h_total,
-				 (int64_t)(drr_timing->pix_clk_100hz * 100) * 1000000);
+	drr_frame_us = drr_timing->v_total * drr_timing->h_total /
+			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
 	// P-State allow width and FW delays already included phantom_timing->v_addressable
-	mall_region_us = div64_s64(phantom_timing->v_addressable * phantom_timing->h_total,
-				   (int64_t)(phantom_timing->pix_clk_100hz * 100) * 1000000);
+	mall_region_us = phantom_timing->v_addressable * phantom_timing->h_total /
+			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000;
 	min_drr_supported_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
-	min_vtotal_supported = div64_s64(drr_timing->pix_clk_100hz * 100 *
-					 (div64_s64((int64_t)min_drr_supported_us, 1000000)),
-					 (int64_t)drr_timing->h_total);
-
-	prefetch_us = div64_s64((phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total,
-				(int64_t)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
-				dc->caps.subvp_prefetch_end_to_mall_start_us);
-	subvp_active_us = div64_s64(main_timing->v_addressable * main_timing->h_total,
-				    (int64_t)(main_timing->pix_clk_100hz * 100) * 1000000);
-	drr_active_us = div64_s64(drr_timing->v_addressable * drr_timing->h_total,
-				  (int64_t)(drr_timing->pix_clk_100hz * 100) * 1000000);
-	max_drr_vblank_us = div64_s64((int64_t)(subvp_active_us - prefetch_us - drr_active_us), 2) + drr_active_us;
+	min_vtotal_supported = drr_timing->pix_clk_100hz * 100 * ((double)min_drr_supported_us / 1000000) /
+			(double)drr_timing->h_total;
+
+	prefetch_us = (phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
+			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
+			dc->caps.subvp_prefetch_end_to_mall_start_us;
+	subvp_active_us = main_timing->v_addressable * main_timing->h_total /
+			(double)(main_timing->pix_clk_100hz * 100) * 1000000;
+	drr_active_us = drr_timing->v_addressable * drr_timing->h_total /
+			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
+	max_drr_vblank_us = (double)(subvp_active_us - prefetch_us - drr_active_us) / 2 + drr_active_us;
 	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us;
 	max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
-	max_vtotal_supported = div64_s64(drr_timing->pix_clk_100hz * 100 * (div64_s64((int64_t)max_drr_supported_us, 1000000)),
-					 (int64_t)drr_timing->h_total);
+	max_vtotal_supported = drr_timing->pix_clk_100hz * 100 * ((double)max_drr_supported_us / 1000000) /
+			(double)drr_timing->h_total;
 
 	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = min_vtotal_supported;
 	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = max_vtotal_supported;
@@ -548,10 +547,10 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 	struct dc_crtc_timing *phantom_timing1 = &subvp_pipes[1]->stream->mall_stream_config.paired_stream->timing;
 	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data = NULL;
 
-	subvp0_prefetch_us = div64_s64((phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total,
-				       (int64_t)(phantom_timing0->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us);
-	subvp1_prefetch_us = div64_s64((phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total,
-				       (int64_t)(phantom_timing1->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us);
+	subvp0_prefetch_us = (phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total /
+				(double)(phantom_timing0->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
+	subvp1_prefetch_us = (phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total /
+					(double)(phantom_timing1->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
 
 	// Whichever SubVP PIPE has the smaller prefetch (including the prefetch end to mall start time)
 	// should increase it's prefetch time to match the other
@@ -559,16 +558,16 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[1];
 		prefetch_delta_us = subvp0_prefetch_us - subvp1_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-			div64_s64(((div64_s64((int64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us), 1000000)) *
-				   (phantom_timing1->pix_clk_100hz * 100) + phantom_timing1->h_total - 1),
-				  (int64_t)phantom_timing1->h_total);
+					(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
+					(phantom_timing1->pix_clk_100hz * 100) + phantom_timing1->h_total - 1) /
+					(double)phantom_timing1->h_total;
 	} else if (subvp1_prefetch_us >  subvp0_prefetch_us) {
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[0];
 		prefetch_delta_us = subvp1_prefetch_us - subvp0_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-			div64_s64(((div64_s64((int64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us), 1000000)) *
-				   (phantom_timing0->pix_clk_100hz * 100) + phantom_timing0->h_total - 1),
-				  (int64_t)phantom_timing0->h_total);
+					(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
+					(phantom_timing0->pix_clk_100hz * 100) + phantom_timing0->h_total - 1) /
+					(double)phantom_timing0->h_total;
 	}
 }
 
@@ -619,13 +618,13 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 	// Round up
 	pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-		div64_s64(((div64_s64((int64_t)dc->caps.subvp_prefetch_end_to_mall_start_us, 1000000)) *
-			   (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1),
-			  (int64_t)phantom_timing->h_total);
+			(((double)dc->caps.subvp_prefetch_end_to_mall_start_us / 1000000) *
+			(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
+			(double)phantom_timing->h_total;
 	pipe_data->pipe_config.subvp_data.processing_delay_lines =
-		div64_s64(((div64_s64((int64_t)dc->caps.subvp_fw_processing_delay_us, 1000000)) *
-			   (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1),
-			  (int64_t)phantom_timing->h_total);
+			(((double)dc->caps.subvp_fw_processing_delay_us / 1000000) *
+			(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
+			(double)phantom_timing->h_total;
 	// Find phantom pipe index based on phantom stream
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *phantom_pipe = &context->res_ctx.pipe_ctx[j];
-- 
2.25.1

