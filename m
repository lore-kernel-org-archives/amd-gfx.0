Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4562BC47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1999B61C53
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1999B61C53
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763536EDC7;
	Wed,  2 Jun 2021 16:51:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2A06EDD7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgvuZ4tP1B+kdK2AwXfPlhDkMcpzVyMoKA3Pdc+kYdAVAsTl2pc/Vs+zNOCYV9BekMV+rvzVJ5Y5S6w7sn6fRYPj/c+npzrq6SZB48ExNNL9tdrJjfIRZM6/MhJEPJ38uG6KoGaSq9JytTjMiaVS4LkjH1lYAe7ZhR4M0y6K9EZ2in26oCVOeqYh672c3IOeId299STmMbU9CP6l+HNvR/Ye2sA28ahXmEQlsTB+vYDAIvEfYpVisGSXbJm8Hudk99so1EnwzWPDdjlkyDSYWVCCtJItaIvOtPspSfHEnoK1v84gdHe/iUevkV40Xkfw7xt3Q+pwyLjkbaUAqyVYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD7ARki4G2EJg76vBru9szPf5juz0GEuDyLCStKb3Eg=;
 b=JtY7k0+NVEec1EE17Fc/DKB7PQtNndOgF2jnLKWiDeD+YzCq3hV/4ZW9gdFLD5Tj5R/ft1W/o6GnjF+r4fYMu3bkFMOH1ammom9K0hJhF+PE13Ukw5xgMILPcNi7V78HIviEjSeO9NH1Z7tr03xpTf1Fka8QBoSkRfO0O6vI1eVaFoM8wNZ47cR6dYvfLpoPzIsZ2bQ27bj+U0NEH/Ewkrb7BQMMzU9RIBthHLW7xz0csPAeQ8giCu33djGehv7d/DBrV+2qOiu05F/67c+p4VQ7zyFMSyNzawi7gHfNOw4XVVPNFmXSBgHflb7uxvwNUxigNyaeM7fq/78ec8mwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD7ARki4G2EJg76vBru9szPf5juz0GEuDyLCStKb3Eg=;
 b=ejOFpT24BrvqosgigFDYeiZW7dAdSZ7d/isTOjqRSJRegYmatXLCzj4+eagiugv+ZA8VGe9lC8c6UgNEnjCdO5hTd7Sy8oZ+PejVYFW65/FjVsy4/4ccbtbSu72BSQl3N+X6d0wKlSrlix6fAD4WjQ2W9GkIoNVvq6XhAEExhZI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:19 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:19 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 73/89] drm/amd/display: Add DCN3.1 DIO
Date: Wed,  2 Jun 2021 12:48:52 -0400
Message-Id: <20210602164908.2848791-73-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4d527ab-f4ad-4912-db4e-08d925e680e4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB453472357ED12C545F755B6BF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+Jktd8ECXhXuv9QjHf8S+9T0/htJJyWX+3viO3P2OciL53p3CfJa/DvFQ3f7reqySIULoloT82vaBFZEg6FM2mXX6cROeO0F4meZERMk75/mZUdAeKFCdK+noR55O9JoNLeKqSsK3thJgstcgG6bFWax0brNhjBtGkBgGmIVvrjyh+3iaCxD+dwSwsLe9KwUT4+WB1qeEDaBOV7RQmeAOLXF/BJCsUwgyrWAX9yqGb78uHSOPhqZ1MqpX62cE9tPB0hs46LZsqrIWkAEjF05kvcxpfFAIafYQ/tu7gxYG2ne8x6pV7OdiKl9iUn7oZZEl3LRvY8En8KW0JEFyzPzfENcBFStHQkP7Gg/F+e9EE57nPekj5m5nZoCUwY4FtVsx1Lx2j3L933Myo/WZ2WaupYMdt4qYWaPElEu2gWXNBJCXWe6RmDK1O4g3FcDoKwOnnFppzJ1Q5sZYmHHl+FayJWP4bdKz2M6mCrqqfUr5xrel/8SheVsz0BMbKdfaCHuaW6xmx83QPSvdoXnfuhdvofNA/8nSWOzBZ7viTj57kCH+8xS3YeOhHX36621B2NQXrE/p/6U31pg6q0vdn7Zc/VnTtsAUMZv0k4PfbFUukmD+czEeGVDH8lmnVw0iybOTjON9MEOHa4TNf8pz9aSOLmQ8BqXbiUDkUSW+OsDdCPC+VIF6kZeN7Aih5oV06o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(30864003)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fKMjxZum0G+hgOK4mzEJbUt2k0BKW5BW+T4qBV24Dd67JENTTX3vzy3KFCEN?=
 =?us-ascii?Q?AI4zHQGWKrpOXlEA+grGjvQXntYomn40l5yi+ea5VeUh2UQSzppFHw8wluU1?=
 =?us-ascii?Q?g/UJpMPDjPcMMvf2juwNj4MRYvVurCxLLq1kvPiCvBZgxI9qajeytMQQRb3R?=
 =?us-ascii?Q?RR8piLOJjmoAYAVlx3shu3d6wvCJxOFoJEGZxxA+vDE8xsixpHt/htOcF2uL?=
 =?us-ascii?Q?exh+3lNF+3I0roSRpkkQPw/pJr6lpKdfSgZwKmfIkWwYgcMuxUR7FUJ9qlW0?=
 =?us-ascii?Q?CFUKa0J/5kz9xuY/aYRH96+1S2q8kUqkfluHdbPY31ONtlG2rwTeKUNXQFGL?=
 =?us-ascii?Q?zxNg7Kf1fPYd7Vw1ZktugbP67eaTafr/sd2cSdB+t8eZuFm87unT9olSHePd?=
 =?us-ascii?Q?Ss3opkVen3bFFWWUqVeWkqm9qaF6QSbBQsC8p+fmox46uG5euRvu9yKlHaCz?=
 =?us-ascii?Q?VIIEn7JGN7cc6bPsgXPGWdqEqWKBUTZPWyN9CJGplRXLYvwOkYC9q1AKTD2j?=
 =?us-ascii?Q?YGZJehBzaZxtwx5vmnqMNkPfaQuC7j5F6pZgoC5d0YbkCXueqWx55n8OobGp?=
 =?us-ascii?Q?SBKXsfrBsaPK0V8QFtH9FtMhA60LQF5FFII/Z65zJPmrcnPzeXgbd5yi5Mza?=
 =?us-ascii?Q?gjb/8zE5ra/jwMhSqb5zP5n3x5sR664WjM6kFOTH2TWZ2lmK4NwZ7zmNr8u1?=
 =?us-ascii?Q?OOL1zdM+ZH7CooRhT2KiFw1a8FO2sG23X86Ecj8bjKjDGbYQHOE9joxbtZ7d?=
 =?us-ascii?Q?ftniK0Mruncjl7VbNe/G1jdhI6t9phgGaK4turuF32ptQ8THT0TPcXMT3hIi?=
 =?us-ascii?Q?tc3fzOWtAdvRTFDaHqU0+KXsLNS+G28sCCdo9IQzpVpF47aFW+uqSRV0BxlN?=
 =?us-ascii?Q?aRPYR/In8MBpcdkfNGciJDZoC6qC7fdYmaHr/ngPwbppKz8l32GgJgYolztQ?=
 =?us-ascii?Q?RwnYYbM3EOgHKWVeT/x8fKjEgBHRmiXb0884GUu1b073FmEb0pPd4DHuPmTR?=
 =?us-ascii?Q?WiB4xjpWRtQJ3cc5oReOlqfkhkswzke4Qu9ZCSF5FOcmWbuR80AQklenin12?=
 =?us-ascii?Q?gg6uTPDqQYg+L4+kbIJclOzuJV7yuaf66djEu6UvrwWAidAHflWjFImgMu9z?=
 =?us-ascii?Q?5h9tSxaQuQmnjn45hSwStL6G/DwUZbLmRv8m26e/jS1CiNvOqr5GA6d7Pqjv?=
 =?us-ascii?Q?LDRUsHUMxt/3rPb+5PnXoEqn3pUl7RKXQ26n/S6UTWbz7eNR+Ih4OH02cU8I?=
 =?us-ascii?Q?2sRPkbFS8iqLqpihOmqw/aGxOD0e9iOW+nVPL5c26h0+MNGMClE+2Ur1eFmW?=
 =?us-ascii?Q?G0AvMt3dmEJS2pjjhG6Vvp73?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d527ab-f4ad-4912-db4e-08d925e680e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:18.6984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAzNR+0pG2tFL/SxvLAA58eRczoEEs/Uw029sOksHq7x0uK3mq9h1lWR+0rqg/luSCHCAosq2xRoSXXGAP6Qyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Add support for the DIO (Display IO) block of DCN3.1 which controls
legacy HDMI/DP stream/link encoding.

HW Blocks:

    +--------+       +--------+
    |  DIO   |       |  DCCG  |
    +--------+       +--------+

Includes some updates to core logic for link encoder assignment and
future support for new high bandwidth output.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  10 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |  20 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 412 ++++++++++++++++++
 .../display/dc/dcn31/dcn31_dio_link_encoder.h | 246 +++++++++++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  14 +
 6 files changed, 716 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c07b45c021d5..31ba40746a2f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2875,8 +2875,16 @@ bool dc_link_setup_psr(struct dc_link *link,
 	psr_context->psr_level.u32all = 0;
 
 	/*skip power down the single pipe since it blocks the cstate*/
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	if (link->ctx->asic_id.chip_family >= FAMILY_RV) {
+		psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
+		if (link->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP && !dc->debug.disable_z10)
+			psr_context->psr_level.bits.SKIP_CRTC_DISABLE = false;
+	}
+#else
 	if (link->ctx->asic_id.chip_family >= FAMILY_RV)
 		psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
+#endif
 
 	/* SMU will perform additional powerdown sequence.
 	 * For unsupported ASICs, set psr_level flag to skip PSR
@@ -3208,8 +3216,14 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 				dp_get_panel_mode(pipe_ctx->stream->link);
 
 		config.otg_inst = (uint8_t) pipe_ctx->stream_res.tg->inst;
+		/*stream_enc_inst*/
 		config.dig_fe = (uint8_t) pipe_ctx->stream_res.stream_enc->stream_enc_inst;
 		config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+		config.stream_enc_idx = pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA;
+		config.link_enc_idx = pipe_ctx->stream->link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+		config.phy_idx = pipe_ctx->stream->link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+#endif
 		config.dpms_off = dpms_off;
 		config.dm_stream_ctx = pipe_ctx->stream->dm_stream_context;
 		config.assr_enabled = (panel_mode == DP_PANEL_MODE_EDP);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index cd864cc83539..56188cd30d62 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2114,6 +2114,16 @@ enum dc_status dc_validate_global_state(
 
 	if (!new_ctx)
 		return DC_ERROR_UNEXPECTED;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+
+	/*
+	 * Update link encoder to stream assignment.
+	 * TODO: Split out reason allocation from validation.
+	 */
+	if (dc->res_pool->funcs->link_encs_assign)
+		dc->res_pool->funcs->link_encs_assign(
+			dc, new_ctx, new_ctx->streams, new_ctx->stream_count);
+#endif
 
 	if (dc->res_pool->funcs->validate_global) {
 		result = dc->res_pool->funcs->validate_global(dc, new_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index 3e1a582e4b88..ba47553081a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -160,6 +160,14 @@ struct dcn10_link_enc_registers {
 	uint32_t PHYA_LINK_CNTL2;
 	uint32_t PHYB_LINK_CNTL2;
 	uint32_t PHYC_LINK_CNTL2;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	uint32_t DIO_LINKA_CNTL;
+	uint32_t DIO_LINKB_CNTL;
+	uint32_t DIO_LINKC_CNTL;
+	uint32_t DIO_LINKD_CNTL;
+	uint32_t DIO_LINKE_CNTL;
+	uint32_t DIO_LINKF_CNTL;
+#endif
 };
 
 #define LE_SF(reg_name, field_name, post_fix)\
@@ -459,17 +467,29 @@ struct dcn10_link_enc_registers {
 	type DPCS_TX_DATA_SWAP_10_BIT;\
 	type DPCS_TX_DATA_ORDER_INVERT_18_BIT;\
 	type RDPCS_TX_CLK_EN
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+#define DCN31_LINK_ENCODER_REG_FIELD_LIST(type) \
+	type ENC_TYPE_SEL;\
+	type HPO_DP_ENC_SEL;\
+	type HPO_HDMI_ENC_SEL
+#endif
 
 struct dcn10_link_enc_shift {
 	DCN_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN20_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN30_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	DCN31_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
+#endif
 };
 
 struct dcn10_link_enc_mask {
 	DCN_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 	DCN20_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 	DCN30_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	DCN31_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
+#endif
 };
 
 struct dcn10_link_encoder {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
new file mode 100644
index 000000000000..b281a4ad152a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -0,0 +1,412 @@
+/*
+ * Copyright 2012-15 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+
+#include "reg_helper.h"
+
+#include "core_types.h"
+#include "link_encoder.h"
+#include "dcn31_dio_link_encoder.h"
+#include "stream_encoder.h"
+#include "i2caux_interface.h"
+#include "dc_bios_types.h"
+
+#include "gpio_service_interface.h"
+
+#include "link_enc_cfg.h"
+#include "dc_dmub_srv.h"
+
+#define CTX \
+	enc10->base.ctx
+#define DC_LOGGER \
+	enc10->base.ctx->logger
+
+#define REG(reg)\
+	(enc10->link_regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	enc10->link_shift->field_name, enc10->link_mask->field_name
+
+#define IND_REG(index) \
+	(enc10->link_regs->index)
+
+#define AUX_REG(reg)\
+	(enc10->aux_regs->reg)
+
+#define AUX_REG_READ(reg_name) \
+		dm_read_reg(CTX, AUX_REG(reg_name))
+
+#define AUX_REG_WRITE(reg_name, val) \
+			dm_write_reg(CTX, AUX_REG(reg_name), val)
+
+void dcn31_link_encoder_set_dio_phy_mux(
+	struct link_encoder *enc,
+	enum encoder_type_select sel,
+	uint32_t hpo_inst)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	switch (enc->transmitter) {
+	case TRANSMITTER_UNIPHY_A:
+		if (sel == ENCODER_TYPE_HDMI_FRL)
+			REG_UPDATE(DIO_LINKA_CNTL,
+					HPO_HDMI_ENC_SEL, hpo_inst);
+		else if (sel == ENCODER_TYPE_DP_128B132B)
+			REG_UPDATE(DIO_LINKA_CNTL,
+					HPO_DP_ENC_SEL, hpo_inst);
+		REG_UPDATE(DIO_LINKA_CNTL,
+				ENC_TYPE_SEL, sel);
+		break;
+	case TRANSMITTER_UNIPHY_B:
+		if (sel == ENCODER_TYPE_HDMI_FRL)
+			REG_UPDATE(DIO_LINKB_CNTL,
+					HPO_HDMI_ENC_SEL, hpo_inst);
+		else if (sel == ENCODER_TYPE_DP_128B132B)
+			REG_UPDATE(DIO_LINKB_CNTL,
+					HPO_DP_ENC_SEL, hpo_inst);
+		REG_UPDATE(DIO_LINKB_CNTL,
+				ENC_TYPE_SEL, sel);
+		break;
+	case TRANSMITTER_UNIPHY_C:
+		if (sel == ENCODER_TYPE_HDMI_FRL)
+			REG_UPDATE(DIO_LINKC_CNTL,
+					HPO_HDMI_ENC_SEL, hpo_inst);
+		else if (sel == ENCODER_TYPE_DP_128B132B)
+			REG_UPDATE(DIO_LINKC_CNTL,
+					HPO_DP_ENC_SEL, hpo_inst);
+		REG_UPDATE(DIO_LINKC_CNTL,
+				ENC_TYPE_SEL, sel);
+		break;
+	case TRANSMITTER_UNIPHY_D:
+		if (sel == ENCODER_TYPE_HDMI_FRL)
+			REG_UPDATE(DIO_LINKD_CNTL,
+					HPO_HDMI_ENC_SEL, hpo_inst);
+		else if (sel == ENCODER_TYPE_DP_128B132B)
+			REG_UPDATE(DIO_LINKD_CNTL,
+					HPO_DP_ENC_SEL, hpo_inst);
+		REG_UPDATE(DIO_LINKD_CNTL,
+				ENC_TYPE_SEL, sel);
+		break;
+	case TRANSMITTER_UNIPHY_E:
+		if (sel == ENCODER_TYPE_HDMI_FRL)
+			REG_UPDATE(DIO_LINKE_CNTL,
+					HPO_HDMI_ENC_SEL, hpo_inst);
+		else if (sel == ENCODER_TYPE_DP_128B132B)
+			REG_UPDATE(DIO_LINKE_CNTL,
+					HPO_DP_ENC_SEL, hpo_inst);
+		REG_UPDATE(DIO_LINKE_CNTL,
+				ENC_TYPE_SEL, sel);
+		break;
+	case TRANSMITTER_UNIPHY_F:
+		if (sel == ENCODER_TYPE_HDMI_FRL)
+			REG_UPDATE(DIO_LINKF_CNTL,
+					HPO_HDMI_ENC_SEL, hpo_inst);
+		else if (sel == ENCODER_TYPE_DP_128B132B)
+			REG_UPDATE(DIO_LINKF_CNTL,
+					HPO_DP_ENC_SEL, hpo_inst);
+		REG_UPDATE(DIO_LINKF_CNTL,
+				ENC_TYPE_SEL, sel);
+		break;
+	default:
+		/* Do nothing */
+		break;
+	}
+}
+
+void enc31_hw_init(struct link_encoder *enc)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+/*
+	00 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__1to2 : 1/2
+	01 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__3to4 : 3/4
+	02 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__7to8 : 7/8
+	03 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__15to16 : 15/16
+	04 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__31to32 : 31/32
+	05 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__63to64 : 63/64
+	06 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__127to128 : 127/128
+	07 - DP_AUX_DPHY_RX_DETECTION_THRESHOLD__255to256 : 255/256
+*/
+
+/*
+	AUX_REG_UPDATE_5(AUX_DPHY_RX_CONTROL0,
+	AUX_RX_START_WINDOW = 1 [6:4]
+	AUX_RX_RECEIVE_WINDOW = 1 default is 2 [10:8]
+	AUX_RX_HALF_SYM_DETECT_LEN  = 1 [13:12] default is 1
+	AUX_RX_TRANSITION_FILTER_EN = 1 [16] default is 1
+	AUX_RX_ALLOW_BELOW_THRESHOLD_PHASE_DETECT [17] is 0  default is 0
+	AUX_RX_ALLOW_BELOW_THRESHOLD_START [18] is 1  default is 1
+	AUX_RX_ALLOW_BELOW_THRESHOLD_STOP [19] is 1  default is 1
+	AUX_RX_PHASE_DETECT_LEN,  [21,20] = 0x3 default is 3
+	AUX_RX_DETECTION_THRESHOLD [30:28] = 1
+*/
+	AUX_REG_WRITE(AUX_DPHY_RX_CONTROL0, 0x103d1110);
+
+	AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c7a);
+
+	//AUX_DPHY_TX_REF_CONTROL'AUX_TX_REF_DIV HW default is 0x32;
+	// Set AUX_TX_REF_DIV Divider to generate 2 MHz reference from refclk
+	// 27MHz -> 0xd
+	// 100MHz -> 0x32
+	// 48MHz -> 0x18
+
+#ifdef CLEANUP_FIXME
+	/*from display_init*/
+	REG_WRITE(RDPCSTX_DEBUG_CONFIG, 0);
+#endif
+
+	// Set TMDS_CTL0 to 1.  This is a legacy setting.
+	REG_UPDATE(TMDS_CTL_BITS, TMDS_CTL0, 1);
+
+	/*HW default is 5*/
+	REG_UPDATE(RDPCSTX_CNTL,
+			RDPCS_TX_FIFO_RD_START_DELAY, 4);
+
+	dcn10_aux_initialize(enc10);
+}
+
+static const struct link_encoder_funcs dcn31_link_enc_funcs = {
+	.read_state = link_enc2_read_state,
+	.validate_output_with_stream =
+			dcn30_link_encoder_validate_output_with_stream,
+	.hw_init = enc31_hw_init,
+	.setup = dcn10_link_encoder_setup,
+	.enable_tmds_output = dcn10_link_encoder_enable_tmds_output,
+	.enable_dp_output = dcn31_link_encoder_enable_dp_output,
+	.enable_dp_mst_output = dcn31_link_encoder_enable_dp_mst_output,
+	.disable_output = dcn31_link_encoder_disable_output,
+	.dp_set_lane_settings = dcn10_link_encoder_dp_set_lane_settings,
+	.dp_set_phy_pattern = dcn10_link_encoder_dp_set_phy_pattern,
+	.update_mst_stream_allocation_table =
+		dcn10_link_encoder_update_mst_stream_allocation_table,
+	.psr_program_dp_dphy_fast_training =
+			dcn10_psr_program_dp_dphy_fast_training,
+	.psr_program_secondary_packet = dcn10_psr_program_secondary_packet,
+	.connect_dig_be_to_fe = dcn10_link_encoder_connect_dig_be_to_fe,
+	.enable_hpd = dcn10_link_encoder_enable_hpd,
+	.disable_hpd = dcn10_link_encoder_disable_hpd,
+	.is_dig_enabled = dcn10_is_dig_enabled,
+	.destroy = dcn10_link_encoder_destroy,
+	.fec_set_enable = enc2_fec_set_enable,
+	.fec_set_ready = enc2_fec_set_ready,
+	.fec_is_active = enc2_fec_is_active,
+	.get_dig_frontend = dcn10_get_dig_frontend,
+	.get_dig_mode = dcn10_get_dig_mode,
+	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
+	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
+};
+
+void dcn31_link_encoder_construct(
+	struct dcn20_link_encoder *enc20,
+	const struct encoder_init_data *init_data,
+	const struct encoder_feature_support *enc_features,
+	const struct dcn10_link_enc_registers *link_regs,
+	const struct dcn10_link_enc_aux_registers *aux_regs,
+	const struct dcn10_link_enc_hpd_registers *hpd_regs,
+	const struct dcn10_link_enc_shift *link_shift,
+	const struct dcn10_link_enc_mask *link_mask)
+{
+	struct bp_encoder_cap_info bp_cap_info = {0};
+	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
+	enum bp_result result = BP_RESULT_OK;
+	struct dcn10_link_encoder *enc10 = &enc20->enc10;
+
+	enc10->base.funcs = &dcn31_link_enc_funcs;
+	enc10->base.ctx = init_data->ctx;
+	enc10->base.id = init_data->encoder;
+
+	enc10->base.hpd_source = init_data->hpd_source;
+	enc10->base.connector = init_data->connector;
+
+	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
+
+	enc10->base.features = *enc_features;
+
+	enc10->base.transmitter = init_data->transmitter;
+
+	/* set the flag to indicate whether driver poll the I2C data pin
+	 * while doing the DP sink detect
+	 */
+
+/*	if (dal_adapter_service_is_feature_supported(as,
+		FEATURE_DP_SINK_DETECT_POLL_DATA_PIN))
+		enc10->base.features.flags.bits.
+			DP_SINK_DETECT_POLL_DATA_PIN = true;*/
+
+	enc10->base.output_signals =
+		SIGNAL_TYPE_DVI_SINGLE_LINK |
+		SIGNAL_TYPE_DVI_DUAL_LINK |
+		SIGNAL_TYPE_LVDS |
+		SIGNAL_TYPE_DISPLAY_PORT |
+		SIGNAL_TYPE_DISPLAY_PORT_MST |
+		SIGNAL_TYPE_EDP |
+		SIGNAL_TYPE_HDMI_TYPE_A;
+
+	/* For DCE 8.0 and 8.1, by design, UNIPHY is hardwired to DIG_BE.
+	 * SW always assign DIG_FE 1:1 mapped to DIG_FE for non-MST UNIPHY.
+	 * SW assign DIG_FE to non-MST UNIPHY first and MST last. So prefer
+	 * DIG is per UNIPHY and used by SST DP, eDP, HDMI, DVI and LVDS.
+	 * Prefer DIG assignment is decided by board design.
+	 * For DCE 8.0, there are only max 6 UNIPHYs, we assume board design
+	 * and VBIOS will filter out 7 UNIPHY for DCE 8.0.
+	 * By this, adding DIGG should not hurt DCE 8.0.
+	 * This will let DCE 8.1 share DCE 8.0 as much as possible
+	 */
+
+	enc10->link_regs = link_regs;
+	enc10->aux_regs = aux_regs;
+	enc10->hpd_regs = hpd_regs;
+	enc10->link_shift = link_shift;
+	enc10->link_mask = link_mask;
+
+	switch (enc10->base.transmitter) {
+	case TRANSMITTER_UNIPHY_A:
+		enc10->base.preferred_engine = ENGINE_ID_DIGA;
+	break;
+	case TRANSMITTER_UNIPHY_B:
+		enc10->base.preferred_engine = ENGINE_ID_DIGB;
+	break;
+	case TRANSMITTER_UNIPHY_C:
+		enc10->base.preferred_engine = ENGINE_ID_DIGC;
+	break;
+	case TRANSMITTER_UNIPHY_D:
+		enc10->base.preferred_engine = ENGINE_ID_DIGD;
+	break;
+	case TRANSMITTER_UNIPHY_E:
+		enc10->base.preferred_engine = ENGINE_ID_DIGE;
+	break;
+	case TRANSMITTER_UNIPHY_F:
+		enc10->base.preferred_engine = ENGINE_ID_DIGF;
+	break;
+	default:
+		ASSERT_CRITICAL(false);
+		enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
+	}
+
+	/* default to one to mirror Windows behavior */
+	enc10->base.features.flags.bits.HDMI_6GB_EN = 1;
+
+	result = bp_funcs->get_encoder_cap_info(enc10->base.ctx->dc_bios,
+						enc10->base.id, &bp_cap_info);
+
+	/* Override features with DCE-specific values */
+	if (result == BP_RESULT_OK) {
+		enc10->base.features.flags.bits.IS_HBR2_CAPABLE =
+				bp_cap_info.DP_HBR2_EN;
+		enc10->base.features.flags.bits.IS_HBR3_CAPABLE =
+				bp_cap_info.DP_HBR3_EN;
+		enc10->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
+		enc10->base.features.flags.bits.DP_IS_USB_C =
+				bp_cap_info.DP_IS_USB_C;
+	} else {
+		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
+				__func__,
+				result);
+	}
+	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
+		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
+	}
+}
+
+void dcn31_link_encoder_construct_minimal(
+	struct dcn20_link_encoder *enc20,
+	struct dc_context *ctx,
+	const struct encoder_feature_support *enc_features,
+	const struct dcn10_link_enc_registers *link_regs,
+	enum engine_id eng_id)
+{
+	struct dcn10_link_encoder *enc10 = &enc20->enc10;
+
+	enc10->base.funcs = &dcn31_link_enc_funcs;
+	enc10->base.ctx = ctx;
+	enc10->base.id.type = OBJECT_TYPE_ENCODER;
+	enc10->base.hpd_source = HPD_SOURCEID_UNKNOWN;
+	enc10->base.connector.type = OBJECT_TYPE_CONNECTOR;
+	enc10->base.preferred_engine = eng_id;
+	enc10->base.features = *enc_features;
+	enc10->base.transmitter = TRANSMITTER_UNKNOWN;
+	enc10->link_regs = link_regs;
+
+	enc10->base.output_signals =
+		SIGNAL_TYPE_DISPLAY_PORT |
+		SIGNAL_TYPE_DISPLAY_PORT_MST |
+		SIGNAL_TYPE_EDP;
+}
+
+void dcn31_link_encoder_enable_dp_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	/* Enable transmitter and encoder. */
+	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
+
+		dcn20_link_encoder_enable_dp_output(enc, link_settings, clock_source);
+
+	} else {
+
+		/** @todo Handle transmitter with programmable mapping to link encoder. */
+	}
+}
+
+void dcn31_link_encoder_enable_dp_mst_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	/* Enable transmitter and encoder. */
+	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
+
+		dcn10_link_encoder_enable_dp_mst_output(enc, link_settings, clock_source);
+
+	} else {
+
+		/** @todo Handle transmitter with programmable mapping to link encoder. */
+	}
+}
+
+void dcn31_link_encoder_disable_output(
+	struct link_encoder *enc,
+	enum signal_type signal)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	/* Disable transmitter and encoder. */
+	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
+
+		dcn10_link_encoder_disable_output(enc, signal);
+
+	} else {
+
+		/** @todo Handle transmitter with programmable mapping to link encoder. */
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
new file mode 100644
index 000000000000..32d146312838
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
@@ -0,0 +1,246 @@
+/*
+ * Copyright 2012-15 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_LINK_ENCODER__DCN31_H__
+#define __DC_LINK_ENCODER__DCN31_H__
+
+#include "dcn30/dcn30_dio_link_encoder.h"
+
+
+#define LE_DCN31_REG_LIST(id)\
+	LE_DCN3_REG_LIST(id),\
+	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
+	SR(DIO_LINKA_CNTL), \
+	SR(DIO_LINKB_CNTL), \
+	SR(DIO_LINKC_CNTL), \
+	SR(DIO_LINKD_CNTL), \
+	SR(DIO_LINKE_CNTL), \
+	SR(DIO_LINKF_CNTL)
+
+#define LINK_ENCODER_MASK_SH_LIST_DCN31(mask_sh) \
+	LINK_ENCODER_MASK_SH_LIST_DCN10(mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_FEC_EN, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_FEC_READY_SHADOW, mask_sh),\
+	LE_SF(DP0_DP_DPHY_CNTL, DPHY_FEC_ACTIVE_STATUS, mask_sh),\
+	LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_START_WINDOW, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_HALF_SYM_DETECT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_TRANSITION_FILTER_EN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_ALLOW_BELOW_THRESHOLD_PHASE_DETECT, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_ALLOW_BELOW_THRESHOLD_START, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_ALLOW_BELOW_THRESHOLD_STOP, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_PHASE_DETECT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL0, AUX_RX_DETECTION_THRESHOLD, mask_sh), \
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_TX_PRECHARGE_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_TX_PRECHARGE_SYMBOLS, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_TX_CONTROL, AUX_MODE_DET_CHECK_DELAY, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_PRECHARGE_SKIP, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN, mask_sh),\
+	LE_SF(DP_AUX0_AUX_DPHY_RX_CONTROL1, AUX_RX_TIMEOUT_LEN_MUL, mask_sh),\
+	LE_SF(DIO_LINKA_CNTL, ENC_TYPE_SEL, mask_sh),\
+	LE_SF(DIO_LINKA_CNTL, HPO_DP_ENC_SEL, mask_sh),\
+	LE_SF(DIO_LINKA_CNTL, HPO_HDMI_ENC_SEL, mask_sh)
+
+#define DPCS_DCN31_REG_LIST(id) \
+	SRI(TMDS_CTL_BITS, DIG, id), \
+	SRI(RDPCSTX_PHY_CNTL3, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL4, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL5, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL6, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL7, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL8, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL9, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL10, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL11, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL12, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL13, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL14, RDPCSTX, id), \
+	SRI(RDPCSTX_CNTL, RDPCSTX, id), \
+	SRI(RDPCSTX_CLOCK_CNTL, RDPCSTX, id), \
+	SRI(RDPCSTX_INTERRUPT_CONTROL, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL0, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_CNTL2, RDPCSTX, id), \
+	SRI(RDPCS_TX_CR_ADDR, RDPCSTX, id), \
+	SRI(RDPCS_TX_CR_DATA, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE0, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE1, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE2, RDPCSTX, id), \
+	SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
+	SR(RDPCSTX0_RDPCSTX_SCRATCH), \
+	SRI(RDPCSTX_PHY_RX_LD_VAL, RDPCSTX, id),\
+	SRI(RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCSTX, id)
+
+#define DPCS_DCN31_MASK_SH_LIST(mask_sh)\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_CLK_RDY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_CLK_RDY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_CLK_RDY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_CLK_RDY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_DATA_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX0_TERM_CTRL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX1_TERM_CTRL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX2_TERM_CTRL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX3_TERM_CTRL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_DP_MPLLB_MULTIPLIER, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX0_WIDTH, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX0_RATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX1_WIDTH, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX1_RATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX2_PSTATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX3_PSTATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX2_MPLL_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX3_MPLL_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL7, RDPCS_PHY_DP_MPLLB_FRACN_QUOT, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL7, RDPCS_PHY_DP_MPLLB_FRACN_DEN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL8, RDPCS_PHY_DP_MPLLB_SSC_PEAK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL9, RDPCS_PHY_DP_MPLLB_SSC_UP_SPREAD, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL9, RDPCS_PHY_DP_MPLLB_SSC_STEPSIZE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL10, RDPCS_PHY_DP_MPLLB_FRACN_REM, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_DP_REF_CLK_MPLLB_DIV, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_HDMI_MPLLB_HDMI_DIV, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_SSC_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_DIV5_CLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_TX_CLK_DIV, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_WORD_DIV2_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_STATE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL13, RDPCS_PHY_DP_MPLLB_DIV_CLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL13, RDPCS_PHY_DP_MPLLB_DIV_MULTIPLIER, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL14, RDPCS_PHY_DP_MPLLB_FRACN_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL14, RDPCS_PHY_DP_MPLLB_PMIX_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE0_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE1_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE2_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE3_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_RD_START_DELAY, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_EXT_REFCLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SRAMCLK_BYPASS, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SRAMCLK_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SRAMCLK_CLOCK_ON, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SYMCLK_DIV2_CLOCK_ON, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SYMCLK_DIV2_GATE_DIS, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SYMCLK_DIV2_EN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_DISABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_REQ, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_REQ, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_REQ, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_REQ, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_ACK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_ACK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_ACK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_ACK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_RESET, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_CR_MUX_SEL, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_REF_RANGE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_SRAM_BYPASS, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_SRAM_EXT_LD_DONE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_HDMIMODE_ENABLE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_SRAM_INIT_DONE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2, RDPCS_PHY_DP4_POR, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_REG_FIFO_ERROR_MASK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_TX_FIFO_ERROR_MASK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_DPALT_DISABLE_TOGGLE_MASK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_DPALT_4LANE_TOGGLE_MASK, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCS_TX_CR_ADDR, RDPCS_TX_CR_ADDR, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCS_TX_CR_DATA, RDPCS_TX_CR_DATA, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_MPLLB_V2I, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_POST, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_MPLLB_FREQ_VCO, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_MPLLB_CP_INT, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_MPLLB_CP_PROP, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_POST, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_POST, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_MAIN, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_FINETUNE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_RANGE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_PRE, mask_sh),\
+	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_POST, mask_sh)
+
+void dcn31_link_encoder_construct(
+	struct dcn20_link_encoder *enc20,
+	const struct encoder_init_data *init_data,
+	const struct encoder_feature_support *enc_features,
+	const struct dcn10_link_enc_registers *link_regs,
+	const struct dcn10_link_enc_aux_registers *aux_regs,
+	const struct dcn10_link_enc_hpd_registers *hpd_regs,
+	const struct dcn10_link_enc_shift *link_shift,
+	const struct dcn10_link_enc_mask *link_mask);
+
+/*
+ * Create a minimal link encoder object with no dc_link object associated with it.
+ */
+void dcn31_link_encoder_construct_minimal(
+	struct dcn20_link_encoder *enc20,
+	struct dc_context *ctx,
+	const struct encoder_feature_support *enc_features,
+	const struct dcn10_link_enc_registers *link_regs,
+	enum engine_id eng_id);
+
+void dcn31_link_encoder_set_dio_phy_mux(
+	struct link_encoder *enc,
+	enum encoder_type_select sel,
+	uint32_t hpo_inst);
+
+/*
+ * Enable DP transmitter and its encoder.
+ */
+void dcn31_link_encoder_enable_dp_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source);
+
+/*
+ * Enable DP transmitter and its encoder in MST mode.
+ */
+void dcn31_link_encoder_enable_dp_mst_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source);
+
+/*
+ * Disable transmitter and its encoder.
+ */
+void dcn31_link_encoder_disable_output(
+	struct link_encoder *enc,
+	enum signal_type signal);
+
+#endif /* __DC_LINK_ENCODER__DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 80bc99500645..f643fe3ed064 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -127,6 +127,14 @@ struct link_enc_state {
 
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	enum encoder_type_select {
+		ENCODER_TYPE_DIG = 0,
+		ENCODER_TYPE_HDMI_FRL = 1,
+		ENCODER_TYPE_DP_128B132B = 2
+	};
+#endif
+
 struct link_encoder_funcs {
 	void (*read_state)(
 			struct link_encoder *enc, struct link_enc_state *s);
@@ -185,6 +193,12 @@ struct link_encoder_funcs {
 
 	enum signal_type (*get_dig_mode)(
 		struct link_encoder *enc);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	void (*set_dio_phy_mux)(
+		struct link_encoder *enc,
+		enum encoder_type_select sel,
+		uint32_t hpo_inst);
+#endif
 };
 
 /*
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
