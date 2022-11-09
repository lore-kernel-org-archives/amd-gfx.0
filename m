Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52726C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF9410E583;
	Wed,  9 Nov 2022 06:16:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2849D10E57E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9MAmjpNz5cvq8vRVssQhedup6mJzsvrqVBysuB8O/85axLmnCDDFoYjoxmmCOhS6biASUGq8y5RohKJgqTNNiB/o7988OF47pna9ISZmDbWjWO344ih6jksanb7oWTxSTwS0AO1B4QgAzggDmqpCYgxT/6xoN78aA0+uYPdE1NevUaniRzpikF+zmWmxGpZM8Rn5KDor4AEOLON8zeS4dqI2SSFlFFvnCaj6+bvBi36oz5X+/nCGv3v2tHApv/K6WszczOEcs/TGbCzP/PYHBIHc9enFQQGnTaA/h34Qk0mcc0udC46IWVc2EwuKzHtUfl+fXNE9yGYQJ4heCcTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UlUldaOpbAgo8CFeJsH1IlMsSZktFrNyvwg6kLcRcs=;
 b=EO3nK7/x2YUMGV+7Y4VxhaGyxGvuq0X0dcI7qgqB5qC4bZJxCkLVFJWzA2q5QHcQ/9kg5MDGrpqsKEA72gjX5bzr64C5fyc77pIYfKEveaP+ZbHIx5ailAAH7ReQozfsiYsW0s7yTkyHpfm8SfO9327+sVzPeoP8xKUapNKzLinpPCf7a3pFk9Ir+vP08BCmOnF9IQP8+kG3uf2swQ9cKzxHSkP9h9jCkHy8aWWK1sbYmQlW6yGa1lCnCvErTIPtCdIoYDxkcend6jQzLoLn3vwVf0E0WZ74QDfQ0snpYgJWwyRqjW2zTqqAmJz++gZ1zUt8/Lxn80oCPFcXyVmnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UlUldaOpbAgo8CFeJsH1IlMsSZktFrNyvwg6kLcRcs=;
 b=AaEstr4+GhtDFJhRGWltoA09XcapCfkUvFhXRr4i2UIU3AYLswEGqdXcyjFu6O2SsNmj3HKT+oT0WYQ34lCcZhVUhU0F+ERhvk7BFnkkE8Zuq1OyTejqPdzPC/bmAm+28lZi6btaOxWJRJDBM7QzMjEKW+izBtfubHBBWnWChkc=
Received: from MW4PR04CA0084.namprd04.prod.outlook.com (2603:10b6:303:6b::29)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:16:43 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::fe) by MW4PR04CA0084.outlook.office365.com
 (2603:10b6:303:6b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:16:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:40 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:15:35 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/29] drm/amd/display: enable dchub request limit for NV32
Date: Wed, 9 Nov 2022 14:13:01 +0800
Message-ID: <20221109061319.2870943-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 712592ad-f827-4762-9aa6-08dac219f8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzYIyBKrVX3hcoUc1t/4K0WHkz1nicmAMjz504GHh63XQONxZHpr6Msz3LJ1rm6AH7oPcSw1C9ZoEy3ti36oOLPa6vxwTDvx60NoPU5U57DFbHY6qqnBa6n8soh0YJGPnwnDtzypDbw5OfwnLvQ3mO3YQ3ANr4Eh3xtN0t0DZS1CjLkVzP0oxiyfpg4f3TktJcBqW6d4sEVP8Z629K45aTlHCYtS5xs3wx4rrDPRmjHbt533ljJ5YH8jjhHfTkna7r35VdthiHF+CSAZZ3gKGp+qpn5EiQSgyOdlNMdcSaPLk3B3P395oyoPyRX9SbvLhYEsby5x4N2283mOhOMraHfgaws5y9VcPsjiHpzyw810yl6Qa8gFWEodiv06dFtqaRK++69VHS5h8/qSGatA4h/OzsuuSIp2ncQMmnHbMnOqlRp6g+NnDkm5t1uSuGBR7G1IMsffA0dWd98QS95AxdLXhhtmOAASxC+t3gptXKoTZ5LbYI2wmfIh4sTF7zuh85kJlb1vySm3Aa8XVtDrbFHOqRDubxP2JaTg8ECWp8WFFIzU9LDbkFr585zzo57Z6ctZTejZr9FahtWrtDSoGI1zlAtcnI+VSU5hmrbZi6kCiWC1mggq2ISfDb0eQ+iLJq1Oj2eimuvvGpM/EDRvDG1H3+xFWsLX+YgkQze0MmDRs0YQyatEncaGwQ0KWZ7kUHFD6dyjtj7G6mWAyshya3Y50MMkVNe3uw65MvXWHncjUfvUE01AQdOLKiSjM0S+g5KpLEiZqStfkf3dPwmbD4fsEvN7wRKybRpX3mDXGKsoYzRt3uyQefwNMQ/rDY+0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(36756003)(36860700001)(47076005)(2616005)(478600001)(2906002)(4326008)(336012)(426003)(83380400001)(186003)(1076003)(40480700001)(8676002)(70586007)(70206006)(40460700003)(316002)(6916009)(7696005)(82740400003)(6666004)(26005)(54906003)(356005)(41300700001)(81166007)(8936002)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:16:42.7365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712592ad-f827-4762-9aa6-08dac219f8b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

[why]
HW recommend we enable this for better DF QoS for NV32

[how]
Add interfaces to hubbub to program register
Add initialization as part of init_hw
Add default settings for NV32
Add registry override for debug/tuning

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h            |  1 +
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h    |  4 +++-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c    | 18 ++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h    |  8 ++++++--
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |  3 +++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c  |  3 +++
 .../drm/amd/display/dc/dcn32/dcn32_resource.h  |  3 ++-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |  1 +
 8 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index caed5597d1dc..009dab94310e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -408,6 +408,7 @@ struct dc_config {
 	bool use_default_clock_table;
 	bool force_bios_enable_lttpr;
 	uint8_t force_bios_fixed_vs;
+	int sdpif_request_limit_words_per_umc;
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
index e48fd044f572..ba1c0621f0f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
@@ -171,6 +171,7 @@ struct dcn_hubbub_registers {
 	uint32_t DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B;
 	uint32_t DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C;
 	uint32_t DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D;
+	uint32_t SDPIF_REQUEST_RATE_LIMIT;
 };
 
 #define HUBBUB_REG_FIELD_LIST_DCN32(type) \
@@ -360,7 +361,8 @@ struct dcn_hubbub_registers {
 		type DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C;\
 		type DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C;\
 		type DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D;\
-		type DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D
+		type DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D;\
+		type SDPIF_REQUEST_RATE_LIMIT
 
 
 struct dcn_hubbub_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index a88a71460521..5947c2cb0f30 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -72,6 +72,23 @@ static void dcn32_init_crb(struct hubbub *hubbub)
 	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x47F);
 }
 
+void hubbub32_set_request_limit(struct hubbub *hubbub, int memory_channel_count, int words_per_channel)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	uint32_t request_limit = 3 * memory_channel_count * words_per_channel / 4;
+
+	ASSERT((request_limit & (~0xFFF)) == 0); //field is only 24 bits long
+	ASSERT(request_limit > 0); //field is only 24 bits long
+
+	if (request_limit > 0xFFF)
+		request_limit = 0xFFF;
+
+	if (request_limit > 0)
+		REG_UPDATE(SDPIF_REQUEST_RATE_LIMIT, SDPIF_REQUEST_RATE_LIMIT, request_limit);
+}
+
+
 void dcn32_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigned int det_buffer_size_in_kbyte)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
@@ -949,6 +966,7 @@ static const struct hubbub_funcs hubbub32_funcs = {
 	.init_crb = dcn32_init_crb,
 	.hubbub_read_state = hubbub2_read_state,
 	.force_usr_retraining_allow = hubbub32_force_usr_retraining_allow,
+	.set_request_limit = hubbub32_set_request_limit
 };
 
 void hubbub32_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
index cda94e0e31bf..786f9ce07f92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
@@ -82,7 +82,8 @@
 	SR(DCN_VM_FAULT_ADDR_MSB),\
 	SR(DCN_VM_FAULT_ADDR_LSB),\
 	SR(DCN_VM_FAULT_CNTL),\
-	SR(DCN_VM_FAULT_STATUS)
+	SR(DCN_VM_FAULT_STATUS),\
+	SR(SDPIF_REQUEST_RATE_LIMIT)
 
 #define HUBBUB_MASK_SH_LIST_DCN32(mask_sh)\
 	HUBBUB_SF(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, mask_sh), \
@@ -159,7 +160,8 @@
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_VMID, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_TABLE_LEVEL, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
-	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh),\
+	HUBBUB_SF(SDPIF_REQUEST_RATE_LIMIT, SDPIF_REQUEST_RATE_LIMIT, mask_sh)
 
 bool hubbub32_program_urgent_watermarks(
 		struct hubbub *hubbub,
@@ -200,4 +202,6 @@ void hubbub32_construct(struct dcn20_hubbub *hubbub2,
 	int pixel_chunk_size_kb,
 	int config_return_buffer_size_kb);
 
+void hubbub32_set_request_limit(struct hubbub *hubbub, int umc_count, int words_per_umc);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 5e0018efe055..c8fb28f09de3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -984,6 +984,9 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->init_crb)
 		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
 
+	if (dc->res_pool->hubbub->funcs->set_request_limit && dc->config.sdpif_request_limit_words_per_umc > 0)
+		dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool->hubbub, dc->ctx->dc_bios->vram_info.num_chans, dc->config.sdpif_request_limit_words_per_umc);
+
 	// Get DMCUB capabilities
 	if (dc->ctx->dmub_srv) {
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 77e40ee488bd..08d3c9d9b251 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2413,6 +2413,9 @@ static bool dcn32_resource_construct(
 		pool->base.oem_device = NULL;
 	}
 
+	if (ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev) && (dc->config.sdpif_request_limit_words_per_umc == 0))
+		dc->config.sdpif_request_limit_words_per_umc = 16;
+
 	DC_FP_END();
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index f76120e67c16..f6bc9bd5da31 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -1244,7 +1244,8 @@ void dcn32_restore_mall_state(struct dc *dc,
       SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C),                         \
       SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D),                         \
       SR(DCN_VM_FAULT_ADDR_MSB), SR(DCN_VM_FAULT_ADDR_LSB),                    \
-      SR(DCN_VM_FAULT_CNTL), SR(DCN_VM_FAULT_STATUS)                           \
+      SR(DCN_VM_FAULT_CNTL), SR(DCN_VM_FAULT_STATUS),                          \
+      SR(SDPIF_REQUEST_RATE_LIMIT)                                             \
   )
 
 /* DCCG */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 58f758fcbce1..f2e1fcb668fb 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -186,6 +186,7 @@ struct hubbub_funcs {
 	void (*program_compbuf_size)(struct hubbub *hubbub, unsigned compbuf_size_kb, bool safe_to_increase);
 	void (*init_crb)(struct hubbub *hubbub);
 	void (*force_usr_retraining_allow)(struct hubbub *hubbub, bool allow);
+	void (*set_request_limit)(struct hubbub *hubbub, int memory_channel_count, int words_per_channel);
 };
 
 struct hubbub {
-- 
2.25.1

