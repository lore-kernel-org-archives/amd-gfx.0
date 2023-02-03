Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537E3C636D4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5D010E7F6;
	Fri,  3 Feb 2023 15:25:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896AA10E7F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX1iI3IR6OBj95FEkQxKqqf3Z0fsm/kTTNdaXVRSQf136mvRPmnyosNH5EFU7pk8yAT9hUAdB/sj6ORDKtq+ImMDvtXQtMK+kqqOZqJnieIWziqrb4aX3IyfdQgooTD/JFnNj7umwCUUM0PeNQXn0vIkv54zUlovErTceE1/gNvpV6jBwYvVm/hOOH160E93oFEy6fd+Xym9AXIhwYVHoW7wvra6G2tJhOt29nCueTwYYPBSuiLWdD/Bvt04pNOXZDVnzrbzAMIaWurIt4k4LLWXKg8x6Bl3II+MLY4ItjbF40Ffk9ZCHC0PbaQSj9MRyehepgTBfotg1+gnqxrKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPpJbyKXAxQ0iMtqXXuLbZ7vuU6Mudb3LMOrAGf3Ovw=;
 b=AmhUWJfEVJhLfeWQR2CrXs4GDbMpsBFyjDvQJ/iI1VX4Swa011jnczQppM3dZnMxkFwJRoh3HpCh+fV50fO9cMrw7IIXrUyhMTDrJiPbkxFnsPpAFfkJiF1h46AOkYJIa+XVibjjhAz7QVnyLUbJWdxoQtJM9cWA7BD4bxQWPc+R6tJnH/G+9/of4uxEwLwEhmJ0xfDYG0zjIlnqSFvJ6pbQ99+TF+wHMtHEaQwfNk1rnnVrnaMN1QSaNReOUFqSNnRBIx6DVt4xH2P8cEhzwFCTo+iAjIW8EsVhiM75o8fdA1HI8xsK34AZMn1Kev11FK1WpGGdqMWCZ8AxF0CXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPpJbyKXAxQ0iMtqXXuLbZ7vuU6Mudb3LMOrAGf3Ovw=;
 b=WjQjALez7FpGfcmBqEvv116iahyQpjUrxouuuwLByMKM2EPQtzoCKEzSQBY/vHJkYDkbrtp+gYvsCt1fpuWY2+kT0o++LU7Fu312ucPgsCiebazzVDFEW4RYzuBbmzAQDc7pp11Yo/OT2UQLjxrUUVj7eT5Gi1Rmh/UX58f+KRc=
Received: from MN2PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:23a::26)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 15:25:27 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::7e) by MN2PR03CA0021.outlook.office365.com
 (2603:10b6:208:23a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:26 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:24 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: Do not commit pipe when updating DRR
Date: Fri, 3 Feb 2023 10:24:42 -0500
Message-ID: <20230203152452.1441747-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5d5b90-68db-4e3e-f3de-08db05fae084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+0n5Lr/XelIvwUxx/ZRAfLDZg6GvSAJJPVIcXT2BAxHeDeSBUGyOxfY8EE1VyLZz3ncPFNC4QUPbXI3woHfty0HuR8VmQfqQHIQd+sT2Ne/O9GUfw+XumS+ShUFhJzXz3Pjbg6fCVuLLeIcw4bdn0xHihhrFCeWO3LAXmHALbzANEq4XwhVPiuHvpSCxm+XMVYu/D+/U7hd43pCOuDQtA5Xh0vuXg3wHW5SRtc5Xnc3hhlpBUUrIcK/15FAfdkl7J4fis98+2wvCAY4WR441Jcdaqyi1MM1LhSBAT1k0VL6S9HKKlK8t3oyX89GGG2Lbns8FCVG88z32BGhlRoj7hqmWXnR25ZJm9TZwlkEoRt7hfWm6HOfPl+QDJi03SlsBRHgY7KedUl8wIcOuvmt8A89dHYlEFmbTVt8G9J6a+TDlKVB8yz740clcZDRPq5NV99bNvuTZKg7sZdU6JGlgRkq96Qte1tIEFiecl5m2PTozj+t6Qg8TGXP+IuYC43gdwSucRXIaDutOJLKlGb1y7FlIInJqa2OLvNf0Z3TQ1Y3DtXvUF7rbY7djjdCbRopGqnxladKM2Y7VhDnh8TTEx6dLO3J4eAnJxq/QHg3JN7oweb+Myt1IDCSrjKaIN5tOmkuqic3wiQCP6N4LANBFxChMa35CR5v2F6pFMiwXbIaQB5wxH6C9Nb9FjzU2FBiY1hBoIilX8SeIf14LDJ031uSnVGaex8qw+Re9bC6kmM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(8936002)(83380400001)(44832011)(5660300002)(2906002)(356005)(41300700001)(186003)(70206006)(2616005)(16526019)(4326008)(40460700003)(6916009)(70586007)(316002)(8676002)(86362001)(47076005)(426003)(26005)(36756003)(1076003)(40480700001)(6666004)(54906003)(336012)(36860700001)(478600001)(82310400005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:26.9204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5d5b90-68db-4e3e-f3de-08db05fae084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
DRR and Pipe cannot be updated on
the same frame, or else underflow will
occur.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 15 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  3 ++-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  9 +++++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  2 ++
 .../drm/amd/display/dc/inc/hw/timing_generator.h  |  1 +
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f11bc8d9d0c4..35f674ac21dd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3350,6 +3350,21 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	dc_z10_restore(dc);
 
+	if (update_type == UPDATE_TYPE_FULL) {
+		/* wait for all double-buffer activity to clear on all pipes */
+		int pipe_idx;
+
+		for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[pipe_idx];
+
+			if (!pipe_ctx->stream)
+				continue;
+
+			if (pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear)
+				pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear(pipe_ctx->stream_res.tg);
+		}
+	}
+
 	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
 		/* Optimize seamless boot flag keeps clocks and watermarks high until
 		 * first flip. After first flip, optimization is required to lower
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 88ac5f6f4c96..0b37bb0e184b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -519,7 +519,8 @@ struct dcn_optc_registers {
 	type OTG_CRC_DATA_STREAM_COMBINE_MODE;\
 	type OTG_CRC_DATA_STREAM_SPLIT_MODE;\
 	type OTG_CRC_DATA_FORMAT;\
-	type OTG_V_TOTAL_LAST_USED_BY_DRR;
+	type OTG_V_TOTAL_LAST_USED_BY_DRR;\
+	type OTG_DRR_TIMING_DBUF_UPDATE_PENDING;
 
 #define TG_REG_FIELD_LIST_DCN3_2(type) \
 	type OTG_H_TIMING_DIV_MODE_MANUAL;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 867d60151aeb..08b92715e2e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -291,6 +291,14 @@ static void optc3_set_timing_double_buffer(struct timing_generator *optc, bool e
 		   OTG_DRR_TIMING_DBUF_UPDATE_MODE, mode);
 }
 
+void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_WAIT(OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_PENDING, 0, 2, 100000); /* 1 vupdate at 5hz */
+
+}
+
 void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
 {
 	optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
@@ -360,6 +368,7 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
+		.wait_drr_doublebuffer_pending_clear = optc3_wait_drr_doublebuffer_pending_clear,
 };
 
 void dcn30_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
index dd45a5499b07..fb06dc9a4893 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -279,6 +279,7 @@
 	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_END_X, mask_sh),\
 	SF(OTG0_OTG_DRR_V_TOTAL_CHANGE, OTG_DRR_V_TOTAL_CHANGE_LIMIT, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_BY2, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_BLANK_DATA_DOUBLE_BUFFER_EN, mask_sh)
 
@@ -317,6 +318,7 @@
 	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_END_X, mask_sh),\
 	SF(OTG0_OTG_DRR_V_TOTAL_CHANGE, OTG_DRR_V_TOTAL_CHANGE_LIMIT, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_PENDING, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh)
 
 void dcn30_timing_generator_init(struct optc *optc1);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 0e42e721dd15..1d9f9c53d2bd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -331,6 +331,7 @@ struct timing_generator_funcs {
 			uint32_t vtotal_change_limit);
 
 	void (*init_odm)(struct timing_generator *tg);
+	void (*wait_drr_doublebuffer_pending_clear)(struct timing_generator *tg);
 };
 
 #endif
-- 
2.25.1

