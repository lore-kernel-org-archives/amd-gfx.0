Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F49C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995A710E828;
	Fri, 28 Jan 2022 14:05:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46BA410E828
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD1/hNhYZTHP3Kv68z8lkC8T+Yc+dNL3FzIBv1fvuZIMZI41rMHsoN/kb55MXr0cFy9KHi4rgMUAoXGMI1X1EwGcPRS/OJLjCFTqDUCjfskHrcjbsSDBZ/pJCIZdyrEhoI72AjNr5pwTnuLTO9dmbekBHaZOyTuW5HFLEDR97oX4nrOmEfjXbjDZ+6X3I92r8ldkj4VR+6gVlWzDCG2+lUASL6fphvUyzbzGDVTf+YHaTJBLObUg+/YQ8fyeTMQkX6U65ZsQh0pWH+uIivEi/hHqVmKsrUhB80tAdGbxsdI8ofsE6fa1CFVf6LGdmzyWMa7Y0JgPEHNbbMXaBDFghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/7UXveMT41ExXPTEc0Y3xjCQY0kMA1U1VEb1L6+uoQ=;
 b=BsfdBUtNSKot1kWpKnKN8f6ratldHUEwZsXk96/W3IGFOXjku/reEKmcIrTOfItV91dHQCCUHK6mVMz5VnpQSS5TC5X2Y/pEtaethrhF6sp+tZ1ZQR3A84QEWZtQgtagRxAC4zeI5CyRAho0MreV95su+Jld+rorJbG1fM7RBLYaPN52PG4J5wykIFyLaZJrAGVyzTgFAGsMIvHF+jJzcpdnWbOk6sbjJ7pLtOBNc8RQoXI5AYVU+hDd7V9Pbq9agsxwwWOjYz2Leg8ElhrS45FyHldkOHtY349aEEJvf0u08cP0sCEXMyGasJCJF5fnKNuOai+eG7xwYNtOObd/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/7UXveMT41ExXPTEc0Y3xjCQY0kMA1U1VEb1L6+uoQ=;
 b=Cv+e8sAa3cKwCljex/q75dJzhPfLoGa8KeCwu595b3wbaarxpKxnmpSD8Pu6aLvjw1h0/+4489dONOu/ZTqTRBF6jnyBa8LC9s3c+cGxrwUjVAjrA58uQxTN5d0rb7TqA0iXXJ8EeXLM7kafZBoVi0PhV6VkiT4gtQy/7kwC5qU=
Received: from DM6PR07CA0103.namprd07.prod.outlook.com (2603:10b6:5:330::35)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 14:05:52 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::ee) by DM6PR07CA0103.outlook.office365.com
 (2603:10b6:5:330::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:51 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:46 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/17] drm/amd/display: move get_link_hwss to dc_resource
Date: Fri, 28 Jan 2022 22:04:06 +0800
Message-ID: <20220128140411.3683309-13-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb68b43f-be37-49ab-f692-08d9e2674b1a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5210:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5210BD0DC5B566D92800E415FF229@BN9PR12MB5210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZckQT38mMStkquCLq1vD1J9oQ/2mSIuRPkz0lXULWBE1liEVc0viQIeiEmzdDLh2CCOB+IdKI7NZCc+DXKJieJasy5sejmQiytiFDtPEh6k+cZ+OkW4Lmq79ixaaaiZAupqUL+ZTMUFHhwRlltqecUVvu8EsUCfjzUZbRDpv59gxPlVgqU3bYk9TseViPWNiQ2qNAB0wovCpzFvoSct0ZldUtaN3T3LXzEfmRukPcw9kF9NOXDVzyoKIOteVWITJKmbneaf+GDDjrCZTfy/7L1OqiYzJ+SSWxcjSBJulDKrEswxpxWPxBUmNx1tofztywYozs93iPAvr9fPuhvGaKCNNW3iCwkTo6lmVyOdZGORDoYzTcjGF9UDAIWqT0ue9RJi+rRot1Cf4w0YtmKqhEjzIlR3kcIEDMElU1uBey/ayk7vkcADgt/kDn6jYjA0IiUN4nZK0nNb1gRwunfirjzATSICVfxvOMnoFbYM3PD1cs1V8lVnAz/jJqIBNcgzECT/925Tm6hhR+C2roNhGhS6n1Ja7QcV19pBs6tmgut4ndHeQ5tBeXei4tRagvGidBqX3xUYw6j8efTLbyOEN+2DGI+yTcopkgImSTB/hnRmZ4D7Cjh2wducLMtHFPDTIyHTWYwKAsKDnq7ynYQU8trmF+uIBFDyayLbEUfxgFkhiTW1NAuorqGBxZh5seNM/lqrliz3c9C1sPfaQY2VP4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(54906003)(316002)(83380400001)(16526019)(6916009)(336012)(186003)(26005)(426003)(1076003)(36860700001)(47076005)(86362001)(7696005)(6666004)(2616005)(508600001)(82310400004)(2906002)(8676002)(40460700003)(4326008)(5660300002)(81166007)(70206006)(70586007)(8936002)(44832011)(356005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:51.7953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb68b43f-be37-49ab-f692-08d9e2674b1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Isolate the way to obtain link_hwss from the actual implemenation
of link_hwss. So the caller can call link_hwss without knowing
the implementation detail of link_hwss.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 51 ++++++++++++-------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 33 ++++++++++++
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    | 17 ++++++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 ++
 4 files changed, 85 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 96414f99c671..dab532cf52b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -29,12 +29,6 @@ static void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx);
 static void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx);
 
 /************************* below goes to dio_link_hwss ************************/
-static bool can_use_dio_link_hwss(const struct dc_link *link,
-		const struct link_resource *link_res)
-{
-	return link->link_enc != NULL;
-}
-
 static void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -135,14 +129,19 @@ static const struct link_hwss dio_link_hwss = {
 	},
 };
 
-/*********************** below goes to hpo_dp_link_hwss ***********************/
-static bool can_use_dp_hpo_link_hwss(const struct dc_link *link,
+bool can_use_dio_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res)
 {
-	return link_res->hpo_dp_link_enc != NULL;
+	return link->link_enc != NULL;
 }
 
-static void set_dp_hpo_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
+const struct link_hwss *get_dio_link_hwss(void)
+{
+	return &dio_link_hwss;
+}
+
+/*********************** below goes to hpo_dp_link_hwss ***********************/
+static void set_hpo_dp_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
 	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder =
@@ -155,7 +154,7 @@ static void set_dp_hpo_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 			throttled_vcp_size);
 }
 
-static void set_dp_hpo_hblank_min_symbol_width(struct pipe_ctx *pipe_ctx,
+static void set_hpo_dp_hblank_min_symbol_width(struct pipe_ctx *pipe_ctx,
 		const struct dc_link_settings *link_settings,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -328,22 +327,27 @@ static const struct link_hwss hpo_dp_link_hwss = {
 	.setup_stream_encoder = setup_hpo_dp_stream_encoder,
 	.reset_stream_encoder = reset_hpo_dp_stream_encoder,
 	.ext = {
-		.set_throttled_vcp_size = set_dp_hpo_throttled_vcp_size,
-		.set_hblank_min_symbol_width = set_dp_hpo_hblank_min_symbol_width,
+		.set_throttled_vcp_size = set_hpo_dp_throttled_vcp_size,
+		.set_hblank_min_symbol_width = set_hpo_dp_hblank_min_symbol_width,
 		.enable_dp_link_output = enable_hpo_dp_link_output,
 		.disable_dp_link_output = disable_hpo_dp_link_output,
 		.set_dp_link_test_pattern  = set_hpo_dp_link_test_pattern,
 		.set_dp_lane_settings = set_hpo_dp_lane_settings,
 	},
 };
-/*********************** below goes to dpia_link_hwss *************************/
-static bool can_use_dpia_link_hwss(const struct dc_link *link,
+
+bool can_use_hpo_dp_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res)
 {
-	return link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign;
+	return link_res->hpo_dp_link_enc != NULL;
 }
 
+const struct link_hwss *get_hpo_dp_link_hwss(void)
+{
+	return &hpo_dp_link_hwss;
+}
+
+/*********************** below goes to dpia_link_hwss *************************/
 static const struct link_hwss dpia_link_hwss = {
 	.setup_stream_encoder = setup_dio_stream_encoder,
 	.reset_stream_encoder = reset_dio_stream_encoder,
@@ -356,7 +360,18 @@ static const struct link_hwss dpia_link_hwss = {
 	},
 };
 
-/*********************** below goes to link_hwss ******************************/
+bool can_use_dpia_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	return link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign;
+}
+
+const struct link_hwss *get_dpia_link_hwss(void)
+{
+	return &dpia_link_hwss;
+}
+/*********************** below goes to virtual_link_hwss ******************************/
 static void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 9af8794c5b24..19e06331169d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3310,3 +3310,36 @@ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter tr
 #endif
 	return phy_idx;
 }
+
+const struct link_hwss *get_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	/* Link_hwss is only accessible by getter function instead of accessing
+	 * by pointers in dc with the intent to protect against breaking polymorphism.
+	 */
+	if (can_use_hpo_dp_link_hwss(link, link_res))
+		/* TODO: some assumes that if decided link settings is 128b/132b
+		 * channel coding format hpo_dp_link_enc should be used.
+		 * Others believe that if hpo_dp_link_enc is available in link
+		 * resource then hpo_dp_link_enc must be used. This bound between
+		 * hpo_dp_link_enc != NULL and decided link settings is loosely coupled
+		 * with a premise that both hpo_dp_link_enc pointer and decided link
+		 * settings are determined based on single policy function like
+		 * "decide_link_settings" from upper layer. This "convention"
+		 * cannot be maintained and enforced at current level.
+		 * Therefore a refactor is due so we can enforce a strong bound
+		 * between those two parameters at this level.
+		 *
+		 * To put it simple, we want to make enforcement at low level so that
+		 * we will not return link hwss if caller plans to do 8b/10b
+		 * with an hpo encoder. Or we can return a very dummy one that doesn't
+		 * do work for all functions
+		 */
+		return get_hpo_dp_link_hwss();
+	else if (can_use_dpia_link_hwss(link, link_res))
+		return get_dpia_link_hwss();
+	else if (can_use_dio_link_hwss(link, link_res))
+		return get_dio_link_hwss();
+	else
+		return get_virtual_link_hwss();
+}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 43c6c0e0ddd9..fd4bfa22eda8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -75,6 +75,21 @@ struct link_hwss {
 	void (*reset_stream_encoder)(struct pipe_ctx *pipe_ctx);
 };
 
-const struct link_hwss *get_link_hwss(const struct dc_link *link, const struct link_resource *link_res);
+
+/*********************** below goes to virtual_link_hwss **********************/
+const struct link_hwss *get_virtual_link_hwss(void);
+/*********************** below goes to dpia_link_hwss *************************/
+bool can_use_dpia_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res);
+const struct link_hwss *get_dpia_link_hwss(void);
+/*********************** below goes to hpo_dp_link_hwss ***********************/
+bool can_use_hpo_dp_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res);
+const struct link_hwss *get_hpo_dp_link_hwss(void);
+/************************* below goes to dio_link_hwss ************************/
+bool can_use_dio_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res);
+const struct link_hwss *get_dio_link_hwss(void);
 
 #endif /* __DC_LINK_HWSS_H__ */
+
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index b2d09330de78..2369f38ed06f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -214,4 +214,7 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 
 uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter);
 
+const struct link_hwss *get_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res);
+
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.34.1

