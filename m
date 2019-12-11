Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AACC2D0C9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5625222B48
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KM+D5tGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5625222B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E47C6EB78;
	Wed, 11 Dec 2019 15:34:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348E96EB74
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYAmDyidGQ8Jbjm6awDGt3w9BNPFWs8w02DxvncwDKDVLOkAUa4MqA6pcyClqoBJoX8dx9GaQOozSeHb7zbV70am3+QRqTZrtB/vusfk/oFSMFcyXW1eZ88Cuj0FVJDgtiWhYlIo6Z5H9ARNaLwQBlmAmqZM0Xd4wROjfbjftR6Bj6QENjENMgcEbXWH7jNTYEXF0kjeX121LJdhN9rXUXwo/YU7whZa3lJNBQxqQUXwAI7N3W41t19HW287dYdbbrREoGSH0rlOXqGsH9D7IlNJSeM958JZVH6KLmMpl5jPu9G0hpvr0YiMjjNFgjcIk3i+bUgwH+VvEogmvmKMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv85upyN3RJDOTQSQEOAtZOVQZF8jh4+SrCNeuTGw1s=;
 b=g+7He4bpghrpW3WjX4AuO/B5qHTd5MDTb1PJhN5Z2s6TICx2CURbtyXlGV5FCMF7GVmuBGbROzshqbRQQWY/Qqm7y9WT31/2vaBTHZy22zpUAFYtwCf7gb5Sj4vlJNX+UTICbR8cjKotXpxbvieEx3C5CYuu/BkHRsRv8X3f+/WNz2WIo51R7MVnEYXyP2K0ad8udpvAIzAPtZz2QBoMmHsaQZLN+1+WSk5dgCROUC6rDG9rSNCF0FX/DFybTY9HBTOf2vjCJyFouATpbinN/kUEpJfHjGdMnPG3RcB3N5uIUm8EgOMrJlU+vYSi2PFQG5Akq0rf4KzssXmyzGbWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv85upyN3RJDOTQSQEOAtZOVQZF8jh4+SrCNeuTGw1s=;
 b=KM+D5tGKZcGZP2yN8Urt68DlF6Oc3jVjxk35rRRDZcrSKJ92YwLBGIgDYk6WA6AfS7QYAsB9fC/C6YqoP2QK01XXOkf3HbVX73/e03Z7tRzztSzmkQwuicikdKDaWdycMoSH/L8b0+uM2PiKUqdl8TxiF6Ooic93DWzoGk1LngQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:15 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:15 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/39] drm/amd/display: support virtual DCN
Date: Wed, 11 Dec 2019 10:32:48 -0500
Message-Id: <20191211153253.2291112-35-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 053713c6-bb39-4ca0-d83d-08d77e4f834c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491A8ACF5BE0A5C272C22F4985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfhw3coQy6++OuQd2Op+NDxuc1QR7KBNuI3ONCCFAkBdY+aT+VUbHwu5c5Yc52Mv7TzVPnRFQ+pCycOVmZ8RhlVYcDIwTdxUAqbN/RDj5pWgsNEjoRjLNbxcsW0bmybPYh4bqzMaL99v6vTEB4jI4UhiV75GFDwPcFH5wpDtSUwJPxvwavCRf0fNN6cFigednADGTFuqfjoFKkg9Cpdb125+0ckliKc2/v1nUo0Pen3F6Vc57wQ+n1BYDS3vkN4IRIqnFJzEeedFwSD6yIxY6+RCOiaMV2/OlUNRzw9b6ly5d/VKnN1QcU1Jk8JKVqZMmn5YZpTt4WTMHiWwiyfraEFsWqpyOYYftkSYP8jC8LAfIVARZ10MJb19DO1YIVXkzSxIF4cIED5C7ey3UMHRt+MO+DpQoF/5EVXvW/CvGN4WTyB6BCpelx2TlbIf0h75
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053713c6-bb39-4ca0-d83d-08d77e4f834c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:46.8321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdSxS+M2KwD7T/zZ3+xPMKzcnWqLg0KJFap8Z+oAz2kFVjtdpDohXPrTJXhtk1gimD/ZUoCDHQ6Qo/LgcLeYWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <Jun.Lei@amd.com>

[why]
DAL3 should support SRIOV

[how]
Add support for the virtual dal flag.  This flag should skip
most/all of DC construction since the HW isn't accessible, but
still construct WindowsDM (almost) normally but with only SW display
targets

Signed-off-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c  | 113 +++++++++++++---------
 drivers/gpu/drm/amd/display/dc/dc_types.h |   7 +-
 2 files changed, 74 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c13480685853..3d89904003f0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -582,6 +582,40 @@ static void dc_destruct(struct dc *dc)
 
 }
 
+static bool dc_construct_ctx(struct dc *dc,
+		const struct dc_init_data *init_params)
+{
+	struct dc_context *dc_ctx;
+	enum dce_version dc_version = DCE_VERSION_UNKNOWN;
+
+	dc_ctx = kzalloc(sizeof(*dc_ctx), GFP_KERNEL);
+	if (!dc_ctx)
+		return false;
+
+	dc_ctx->cgs_device = init_params->cgs_device;
+	dc_ctx->driver_context = init_params->driver;
+	dc_ctx->dc = dc;
+	dc_ctx->asic_id = init_params->asic_id;
+	dc_ctx->dc_sink_id_count = 0;
+	dc_ctx->dc_stream_id_count = 0;
+	dc_ctx->dce_environment = init_params->dce_environment;
+
+	/* Create logger */
+
+	dc_version = resource_parse_asic_id(init_params->asic_id);
+	dc_ctx->dce_version = dc_version;
+
+	dc_ctx->perf_trace = dc_perf_trace_create();
+	if (!dc_ctx->perf_trace) {
+		ASSERT_CRITICAL(false);
+		return false;
+	}
+
+	dc->ctx = dc_ctx;
+
+	return true;
+}
+
 static bool dc_construct(struct dc *dc,
 		const struct dc_init_data *init_params)
 {
@@ -593,7 +627,6 @@ static bool dc_construct(struct dc *dc,
 	struct dcn_ip_params *dcn_ip;
 #endif
 
-	enum dce_version dc_version = DCE_VERSION_UNKNOWN;
 	dc->config = init_params->flags;
 
 	// Allocate memory for the vm_helper
@@ -639,26 +672,12 @@ static bool dc_construct(struct dc *dc,
 	dc->soc_bounding_box = init_params->soc_bounding_box;
 #endif
 
-	dc_ctx = kzalloc(sizeof(*dc_ctx), GFP_KERNEL);
-	if (!dc_ctx) {
+	if (!dc_construct_ctx(dc, init_params)) {
 		dm_error("%s: failed to create ctx\n", __func__);
 		goto fail;
 	}
 
-	dc_ctx->cgs_device = init_params->cgs_device;
-	dc_ctx->driver_context = init_params->driver;
-	dc_ctx->dc = dc;
-	dc_ctx->asic_id = init_params->asic_id;
-	dc_ctx->dc_sink_id_count = 0;
-	dc_ctx->dc_stream_id_count = 0;
-	dc->ctx = dc_ctx;
-
-	/* Create logger */
-
-	dc_ctx->dce_environment = init_params->dce_environment;
-
-	dc_version = resource_parse_asic_id(init_params->asic_id);
-	dc_ctx->dce_version = dc_version;
+        dc_ctx = dc->ctx;
 
 	/* Resource should construct all asic specific resources.
 	 * This should be the only place where we need to parse the asic id
@@ -673,7 +692,7 @@ static bool dc_construct(struct dc *dc,
 		bp_init_data.bios = init_params->asic_id.atombios_base_address;
 
 		dc_ctx->dc_bios = dal_bios_parser_create(
-				&bp_init_data, dc_version);
+				&bp_init_data, dc_ctx->dce_version);
 
 		if (!dc_ctx->dc_bios) {
 			ASSERT_CRITICAL(false);
@@ -681,17 +700,13 @@ static bool dc_construct(struct dc *dc,
 		}
 
 		dc_ctx->created_bios = true;
-		}
-
-	dc_ctx->perf_trace = dc_perf_trace_create();
-	if (!dc_ctx->perf_trace) {
-		ASSERT_CRITICAL(false);
-		goto fail;
 	}
 
+
+
 	/* Create GPIO service */
 	dc_ctx->gpio_service = dal_gpio_service_create(
-			dc_version,
+			dc_ctx->dce_version,
 			dc_ctx->dce_environment,
 			dc_ctx);
 
@@ -700,7 +715,7 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
-	dc->res_pool = dc_create_resource_pool(dc, init_params, dc_version);
+	dc->res_pool = dc_create_resource_pool(dc, init_params, dc_ctx->dce_version);
 	if (!dc->res_pool)
 		goto fail;
 
@@ -731,8 +746,6 @@ static bool dc_construct(struct dc *dc,
 	return true;
 
 fail:
-
-	dc_destruct(dc);
 	return false;
 }
 
@@ -825,29 +838,38 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 	if (NULL == dc)
 		goto alloc_fail;
 
-	if (false == dc_construct(dc, init_params))
-		goto construct_fail;
+	if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
+		if (false == dc_construct_ctx(dc, init_params)) {
+			dc_destruct(dc);
+			goto construct_fail;
+		}
+	} else {
+		if (false == dc_construct(dc, init_params)) {
+			dc_destruct(dc);
+			goto construct_fail;
+		}
+
+		full_pipe_count = dc->res_pool->pipe_count;
+		if (dc->res_pool->underlay_pipe_index != NO_UNDERLAY_PIPE)
+			full_pipe_count--;
+		dc->caps.max_streams = min(
+				full_pipe_count,
+				dc->res_pool->stream_enc_count);
 
-	full_pipe_count = dc->res_pool->pipe_count;
-	if (dc->res_pool->underlay_pipe_index != NO_UNDERLAY_PIPE)
-		full_pipe_count--;
-	dc->caps.max_streams = min(
-			full_pipe_count,
-			dc->res_pool->stream_enc_count);
+		dc->optimize_seamless_boot_streams = 0;
+		dc->caps.max_links = dc->link_count;
+		dc->caps.max_audios = dc->res_pool->audio_count;
+		dc->caps.linear_pitch_alignment = 64;
 
-	dc->optimize_seamless_boot_streams = 0;
-	dc->caps.max_links = dc->link_count;
-	dc->caps.max_audios = dc->res_pool->audio_count;
-	dc->caps.linear_pitch_alignment = 64;
+		dc->caps.max_dp_protocol_version = DP_VERSION_1_4;
 
-	dc->caps.max_dp_protocol_version = DP_VERSION_1_4;
+		if (dc->res_pool->dmcu != NULL)
+			dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
+	}
 
 	/* Populate versioning information */
 	dc->versions.dc_ver = DC_VER;
 
-	if (dc->res_pool->dmcu != NULL)
-		dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
-
 	dc->build_id = DC_BUILD_ID;
 
 	DC_LOG_DC("Display Core initialized\n");
@@ -865,7 +887,8 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 
 void dc_hardware_init(struct dc *dc)
 {
-	dc->hwss.init_hw(dc);
+	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW)
+		dc->hwss.init_hw(dc);
 }
 
 void dc_init_callbacks(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2cce8ed014ac..b1a372c8df83 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -60,7 +60,12 @@ enum dce_environment {
 	DCE_ENV_FPGA_MAXIMUS,
 	/* Emulation on real HW or on FPGA. Used by Diagnostics, enforces
 	 * requirements of Diagnostics team. */
-	DCE_ENV_DIAG
+	DCE_ENV_DIAG,
+	/*
+	 * Guest VM system, DC HW may exist but is not virtualized and
+	 * should not be used.  SW support for VDI only.
+	 */
+	DCE_ENV_VIRTUAL_HW
 };
 
 /* Note: use these macro definitions instead of direct comparison! */
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
