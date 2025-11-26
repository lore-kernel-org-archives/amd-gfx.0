Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBECD111A7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5129810E73C;
	Wed, 26 Nov 2025 23:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VeSNBY18";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128AE10E73D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaKX6Vjrz0vLWx7kr1flu6Hu+9B1HcKQS4i/Nm9T24MSL73CPAzCAl1XodJji6DyAZypBxomkxke9zP3h6j++o1iu/vWGcVPV1tu/PairWn+H2q8HGMfBNY/A1AviMcM5/8y53PFEJ9hbKfAD3h8Qh9WYZctyKrd9BPaZj216PgU9oHRkHEfKoxxd+aJvYbkGrBlkF43bzUFgghx2XU8vjUoQkalCbF/5+IfMTHJqocrHt6nM64KJ94ngEBAcl/Im+0XKz0+Oswe9+ZpZL3yN2yEq0kbsGxGm6dow8Iley3jJwX8d52Q2oNpyzEjQG8iGyfvRMJVxGGmluoTEEyCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb4V2pF5wSXobNtMwOeuPBeHtfoGAsl6jD2u9fs16+I=;
 b=q6HyDVO6GDMhz+LkZs7/Qekio8i1eMAuyZ5TzoA+p72e2ngVU7E3W/BXjGmYnURjxSpy6pAU/9r+HRfr4KxEUdgrqIJgsAeu/zF2Ewp+llsPOO9ha5DXr8j/FdV+kthORXt2glMHyFiH/fxT+xuls+3vR8ZFlSKzqpnf3WCy65P0NpQgDgMRmC/6YNwGLKZDP3ZOTkv7qpW7K7nk7R8AY70snotaPjbdnWdnf9nHXDRLvTJKX/mT1833FFcF0CVv+uCpi6MeXKrm/yZLxBqWjtdiYzU34RcGJ7h6/QYKCT4xrShE4cVfxL7RaZN55GcwiFIEUOj8hyhowuxgNGV2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb4V2pF5wSXobNtMwOeuPBeHtfoGAsl6jD2u9fs16+I=;
 b=VeSNBY18oIaUYnH+0aR1m50JyQBJ0adha7bZjW9uii/W45RzSTqtiffWcWvDXaS7d0i3evrBFebSwqZYDRp3a5y0qo8117OfrTCi+QAoWJgtxF0jXkad0gjM94yKuPuxEmOkdls7vX0cJnv+gEWcVg1l6bK1/l3Fp1J/qAggdls=
Received: from SA0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:130::34)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:06:39 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::2e) by SA0PR13CA0029.outlook.office365.com
 (2603:10b6:806:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 23:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:37 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Nov
 2025 17:06:36 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:36 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 05/14] drm/amd/display: refactor HPD to increase flexibility
Date: Wed, 26 Nov 2025 18:06:05 -0500
Message-ID: <20251126230614.13409-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ceaa016-f7c0-4212-214b-08de2d4074b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jASRVQK0eStaEdHQ+SDsHRGPoVWFiat8vQ2TekUrqxxu1/QjCfKQJjm8VWQg?=
 =?us-ascii?Q?MqpnCtmn0PeQJiCynkRubJuSpaeRhsL+fTF4kCkMhqvt7rnxrwOY8mPnhEe3?=
 =?us-ascii?Q?bIyD8eG/HBtFv2Iclb5CzGFC5h7rj0sPZDhsv425C/nf9bCxziLqKmstUqlf?=
 =?us-ascii?Q?IfmBvGfdFuBMxnQZI+YJzOvs8wedjvj5fAVY17oSYIrp34LgY3JLoIbuBHhk?=
 =?us-ascii?Q?voT/h10ziM5gaPghTztHIuV/seKc9NKqDbjypqBK/aYH+dB41j3TBbYibjww?=
 =?us-ascii?Q?k7ifJ5Yvg/HlVNKLfsmOIH80zP22PrA1fTVcsDkZLwDIm1Tc3O88KGP/wSHA?=
 =?us-ascii?Q?8dz2K9+HlIUBdOw5jUw+Vy2HHwwP739HPr6rmZPIDGwyNMtdyVtMcyLhdedt?=
 =?us-ascii?Q?ijg98oyyT6K665DOpT6z7k9Qe7JITuzscgEWip1NRV6iR/0w0ka1MHkVSu9E?=
 =?us-ascii?Q?EP8ZDTFQNLTUrBPZYAZm2BFr3J1XMQbgUYSCaKBCt6cTqcl1+dN32nX19ysA?=
 =?us-ascii?Q?zYVoaz3hrD1ZHdAqVtBsOY/FuYZw41kDhyZ766O8CkAeMuLdDWKf1cV1uOaE?=
 =?us-ascii?Q?u44hzwIXum7FgrxHtk6HsOxOw6tR6CSW1Iy0zI99ZF2bOL9qBa5ZT//McaAS?=
 =?us-ascii?Q?h/2gMRPEZDolklADgP42KocYyRQbM1SK/Tz37AjqufdBZNIYbqelUo5Yjvhi?=
 =?us-ascii?Q?8tqHignAYbxVPiczGDs9BPbU0KbD0/sr2xvRoE27gUbe7SXjIDOkMdhZsN6K?=
 =?us-ascii?Q?CUyFLqB06XuWe+Xi4Rp02lLqJtT2/hK1i+KRFFcQ4q1xkRsuOZ3RPn1ASiNy?=
 =?us-ascii?Q?J5jF6BUIfNLYgOAQGVyd4ymAlrs6pUdyoBrVSoZ71vSaUiptN7xn4xEUcacV?=
 =?us-ascii?Q?qS83PIrmEAtr6pTLKgl5EuU9qVuCSSGup2xt0GgBmw/43nK4CoC1gDs5hWyQ?=
 =?us-ascii?Q?0BxIdv0Wbtfk9phXGLdUWjCKqkqtj5zdmVAA7StSgzrLsDKlqqUgJSYjc36M?=
 =?us-ascii?Q?hszVebREcUixWFMTozXQAdks4eWduvdh/ZZXAFeSgWD7+AGvd393UYbRH/CY?=
 =?us-ascii?Q?HIq2r1rmR+2mkocuSf24zm3+hPwsxwpi0g5VlI+adm81Vlroq3/GfGLlp21A?=
 =?us-ascii?Q?GEjDIc74oNzT30SGRMRgMXgCZ03tXN3XBlVqBvYxED0vk2QVTz9bXy4i2Jy9?=
 =?us-ascii?Q?djzgiW485VVg+C3nmr4UUXCXglnQzTZesohLM7dokxO9qEbkxDMJhuiAotmB?=
 =?us-ascii?Q?p3Fd654jn4VuuYz8om8wu1TRy+7tBL5xSuvxD73tZZeI1SOC3npPjgMBc5Xx?=
 =?us-ascii?Q?z0KRPB21+lP7shV4m2R8t6sh67QWBUurWSrn3+dT4pNjnuEZbLa6DKMVvaYu?=
 =?us-ascii?Q?6W+P+o8ec1ybdMDkBzxwwndC/7l9JUFAR8z13MJvx2ZwzLT7eJweWEJ5Od9i?=
 =?us-ascii?Q?aMkF9WuInAtcgxgBepxVvdUOC52cz9YMTigsxx6LOImGfPLhVY2yY38aUx2L?=
 =?us-ascii?Q?Pg3Zp9yH0GQmqCsFokvF5bjBdO8UHTw+3eSslkGAokgPydEGdqVfw9NsuCse?=
 =?us-ascii?Q?DDP7OXGgHn/RzHugqCc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:39.1840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceaa016-f7c0-4212-214b-08de2d4074b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Currently all dcn revisions have to follow the same codepath for
hotplug detection. This change allows per dcn hpd handling consolidating
hpd code in link_encoder.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 -
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  47 ++++-
 .../drm/amd/display/dc/dce/dce_link_encoder.h |   8 +-
 .../display/dc/dcn201/dcn201_link_encoder.c   |   3 +
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |   3 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |  43 ++++
 .../display/dc/dio/dcn10/dcn10_link_encoder.h |  11 +-
 .../display/dc/dio/dcn20/dcn20_link_encoder.c |   3 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |   3 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |   3 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   3 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |   3 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  22 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   4 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   3 -
 .../drm/amd/display/dc/link/link_detection.c  |  10 +-
 .../drm/amd/display/dc/link/link_factory.c    | 193 ++++++++++--------
 .../amd/display/dc/link/protocols/link_hpd.c  | 165 +++++----------
 .../amd/display/dc/link/protocols/link_hpd.h  |   1 -
 .../dc/resource/dcn32/dcn32_resource.h        |   5 +-
 23 files changed, 293 insertions(+), 250 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 60c5d8627bc7..458883adfc28 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1708,7 +1708,6 @@ struct dc_scratch_space {
 	struct dc_link_status link_status;
 	struct dprx_states dprx_states;
 
-	struct gpio *hpd_gpio;
 	enum dc_link_fec_state fec_state;
 	bool is_dds;
 	bool is_display_mux_present;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 87dbb8d7ed27..b44c364519dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -117,6 +117,8 @@ static const struct link_encoder_funcs dce110_lnk_enc_funcs = {
 	.destroy = dce110_link_encoder_destroy,
 	.get_max_link_cap = dce110_link_encoder_get_max_link_cap,
 	.get_dig_frontend = dce110_get_dig_frontend,
+	.get_hpd_state = dce110_get_hpd_state,
+	.program_hpd_filter = dce110_program_hpd_filter,
 };
 
 static enum bp_result link_transmitter_control(
@@ -851,6 +853,7 @@ void dce110_link_encoder_construct(
 	enc110->base.ctx = init_data->ctx;
 	enc110->base.id = init_data->encoder;
 
+	enc110->base.hpd_gpio = init_data->hpd_gpio;
 	enc110->base.hpd_source = init_data->hpd_source;
 	enc110->base.connector = init_data->connector;
 
@@ -1053,6 +1056,11 @@ void dce110_link_encoder_hw_init(
 
 void dce110_link_encoder_destroy(struct link_encoder **enc)
 {
+	if ((*enc)->hpd_gpio) {
+		dal_gpio_destroy_irq(&(*enc)->hpd_gpio);
+		(*enc)->hpd_gpio = NULL;
+	}
+
 	kfree(TO_DCE110_LINK_ENC(*enc));
 	*enc = NULL;
 }
@@ -1751,6 +1759,40 @@ void dce110_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	*link_settings = max_link_cap;
 }
 
+bool dce110_get_hpd_state(struct link_encoder *enc)
+{
+	uint32_t state = 0;
+
+	if (!enc->hpd_gpio)
+		return false;
+
+	dal_gpio_lock_pin(enc->hpd_gpio);
+	dal_gpio_get_value(enc->hpd_gpio, &state);
+	dal_gpio_unlock_pin(enc->hpd_gpio);
+
+	return state;
+}
+
+bool dce110_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_ms, int delay_on_disconnect_in_ms)
+{
+	/* Setup HPD filtering */
+	if (enc->hpd_gpio && dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
+		struct gpio_hpd_config config;
+
+		config.delay_on_connect = delay_on_connect_in_ms;
+		config.delay_on_disconnect = delay_on_disconnect_in_ms;
+
+		dal_irq_setup_hpd_filter(enc->hpd_gpio, &config);
+
+		dal_gpio_unlock_pin(enc->hpd_gpio);
+
+		return true;
+	} else {
+		ASSERT(0);
+		return false;
+	}
+}
+
 #if defined(CONFIG_DRM_AMD_DC_SI)
 static const struct link_encoder_funcs dce60_lnk_enc_funcs = {
 	.validate_output_with_stream =
@@ -1775,7 +1817,9 @@ static const struct link_encoder_funcs dce60_lnk_enc_funcs = {
 	.is_dig_enabled = dce110_is_dig_enabled,
 	.destroy = dce110_link_encoder_destroy,
 	.get_max_link_cap = dce110_link_encoder_get_max_link_cap,
-	.get_dig_frontend = dce110_get_dig_frontend
+	.get_dig_frontend = dce110_get_dig_frontend,
+	.get_hpd_state = dce110_get_hpd_state,
+	.program_hpd_filter = dce110_program_hpd_filter,
 };
 
 void dce60_link_encoder_construct(
@@ -1794,6 +1838,7 @@ void dce60_link_encoder_construct(
 	enc110->base.ctx = init_data->ctx;
 	enc110->base.id = init_data->encoder;
 
+	enc110->base.hpd_gpio = init_data->hpd_gpio;
 	enc110->base.hpd_source = init_data->hpd_source;
 	enc110->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index c58b69bc319b..9ba533aa6f88 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -130,11 +130,6 @@
 	SRI(DP_DPHY_HBR2_PATTERN_CONTROL, DP, id), \
 	SR(DCI_MEM_PWR_STATUS)
 
-#define LE_DCN10_REG_LIST(id)\
-	LE_COMMON_REG_LIST_BASE(id), \
-	SRI(DP_DPHY_BS_SR_SWAP_CNTL, DP, id), \
-	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
-	SRI(DP_DPHY_HBR2_PATTERN_CONTROL, DP, id)
 
 struct dce110_link_enc_aux_registers {
 	uint32_t AUX_CONTROL;
@@ -319,4 +314,7 @@ bool dce110_is_dig_enabled(struct link_encoder *enc);
 void dce110_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	struct dc_link_settings *link_settings);
 
+bool dce110_get_hpd_state(struct link_encoder *enc);
+bool dce110_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_ms, int delay_on_disconnect_in_ms);
+
 #endif /* __DC_LINK_ENCODER__DCE110_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c
index 8d31fa131cd6..9459e8f28338 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_link_encoder.c
@@ -104,6 +104,8 @@ static const struct link_encoder_funcs dcn201_link_enc_funcs = {
 	.fec_is_active = enc2_fec_is_active,
 	.is_in_alt_mode = dcn201_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn201_link_encoder_get_max_link_cap,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn201_link_encoder_construct(
@@ -125,6 +127,7 @@ void dcn201_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
index eb9abb9f9698..36456c9971c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
@@ -325,6 +325,8 @@ static const struct link_encoder_funcs dcn21_link_enc_funcs = {
 	.get_dig_frontend = dcn10_get_dig_frontend,
 	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn21_link_encoder_construct(
@@ -346,6 +348,7 @@ void dcn21_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index 1c1228116487..13e14aad3daa 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -88,8 +88,11 @@ static const struct link_encoder_funcs dcn10_lnk_enc_funcs = {
 	.get_dig_mode = dcn10_get_dig_mode,
 	.destroy = dcn10_link_encoder_destroy,
 	.get_max_link_cap = dcn10_link_encoder_get_max_link_cap,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
+
 static enum bp_result link_transmitter_control(
 	struct dcn10_link_encoder *enc10,
 	struct bp_transmitter_control *cntl)
@@ -682,6 +685,7 @@ void dcn10_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
@@ -873,6 +877,11 @@ void dcn10_link_encoder_hw_init(
 
 void dcn10_link_encoder_destroy(struct link_encoder **enc)
 {
+	if ((*enc)->hpd_gpio) {
+		dal_gpio_destroy_irq(&(*enc)->hpd_gpio);
+		(*enc)->hpd_gpio = NULL;
+	}
+
 	kfree(TO_DCN10_LINK_ENC(*enc));
 	*enc = NULL;
 }
@@ -1472,3 +1481,37 @@ void dcn10_link_encoder_get_max_link_cap(struct link_encoder *enc,
 
 	*link_settings = max_link_cap;
 }
+
+bool dcn10_get_hpd_state(struct link_encoder *enc)
+{
+	uint32_t state = 0;
+
+	if (!enc->hpd_gpio)
+		return false;
+
+	dal_gpio_lock_pin(enc->hpd_gpio);
+	dal_gpio_get_value(enc->hpd_gpio, &state);
+	dal_gpio_unlock_pin(enc->hpd_gpio);
+
+	return state;
+}
+
+bool dcn10_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_ms, int delay_on_disconnect_in_ms)
+{
+	/* Setup HPD filtering */
+	if (enc->hpd_gpio && dal_gpio_lock_pin(enc->hpd_gpio) == GPIO_RESULT_OK) {
+		struct gpio_hpd_config config;
+
+		config.delay_on_connect = delay_on_connect_in_ms;
+		config.delay_on_disconnect = delay_on_disconnect_in_ms;
+
+		dal_irq_setup_hpd_filter(enc->hpd_gpio, &config);
+
+		dal_gpio_unlock_pin(enc->hpd_gpio);
+
+		return true;
+	} else {
+		ASSERT(0);
+		return false;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h
index b7a89c39f445..eedbd5d2756e 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.h
@@ -79,6 +79,8 @@ struct dcn10_link_enc_aux_registers {
 
 struct dcn10_link_enc_hpd_registers {
 	uint32_t DC_HPD_CONTROL;
+	uint32_t DC_HPD_INT_STATUS;
+	uint32_t DC_HPD_TOGGLE_FILT_CNTL;
 };
 
 struct dcn10_link_enc_registers {
@@ -274,7 +276,10 @@ struct dcn10_link_enc_registers {
 	type TMDS_CTL0;\
 	type AUX_HPD_SEL;\
 	type AUX_LS_READ_EN;\
-	type AUX_RX_RECEIVE_WINDOW
+	type AUX_RX_RECEIVE_WINDOW;\
+	type DC_HPD_SENSE;\
+	type DC_HPD_CONNECT_INT_DELAY;\
+	type DC_HPD_DISCONNECT_INT_DELAY
 
 
 #define DCN20_LINK_ENCODER_DPCS_REG_FIELD_LIST(type) \
@@ -656,4 +661,8 @@ enum signal_type dcn10_get_dig_mode(
 
 void dcn10_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	struct dc_link_settings *link_settings);
+
+bool dcn10_get_hpd_state(struct link_encoder *enc);
+bool dcn10_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_ms, int delay_on_disconnect_in_ms);
+
 #endif /* __DC_LINK_ENCODER__DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c
index 51a57dae1811..3bd35f3392dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c
@@ -384,6 +384,8 @@ static const struct link_encoder_funcs dcn20_link_enc_funcs = {
 	.get_dig_frontend = dcn10_get_dig_frontend,
 	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn20_link_encoder_construct(
@@ -405,6 +407,7 @@ void dcn20_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
index b8e31b5ea114..57b9ae5fca1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
@@ -84,6 +84,8 @@ static const struct link_encoder_funcs dcn30_link_enc_funcs = {
 	.get_dig_mode = dcn10_get_dig_mode,
 	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn30_link_encoder_construct(
@@ -105,6 +107,7 @@ void dcn30_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
index 1b39a6e8a1ac..47d84a2a48ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
@@ -73,6 +73,8 @@ static const struct link_encoder_funcs dcn301_link_enc_funcs = {
 	.get_dig_mode = dcn10_get_dig_mode,
 	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn301_link_encoder_construct(
@@ -94,6 +96,7 @@ void dcn301_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
index 84cc2ddc52fe..07d362ef0daf 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
@@ -276,6 +276,8 @@ static const struct link_encoder_funcs dcn31_link_enc_funcs = {
 	.is_in_alt_mode = dcn31_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn31_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn31_link_encoder_construct(
@@ -297,6 +299,7 @@ void dcn31_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
index 06907e8a4eda..44a4e3c4efb9 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
@@ -224,6 +224,8 @@ static const struct link_encoder_funcs dcn32_link_enc_funcs = {
 	.is_in_alt_mode = dcn32_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn32_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn32_link_encoder_construct(
@@ -245,6 +247,7 @@ void dcn32_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
index 2ed382a8e79c..968f89295b64 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
@@ -89,6 +89,8 @@ static const struct link_encoder_funcs dcn321_link_enc_funcs = {
 	.is_in_alt_mode = dcn20_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn20_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn321_link_encoder_construct(
@@ -110,6 +112,7 @@ void dcn321_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
index 9972911330b6..319eb1061ba8 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
@@ -162,6 +162,8 @@ static const struct link_encoder_funcs dcn35_link_enc_funcs = {
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
 	.enable_dpia_output = dcn35_link_encoder_enable_dpia_output,
 	.disable_dpia_output = dcn35_link_encoder_disable_dpia_output,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn35_link_encoder_construct(
@@ -183,6 +185,7 @@ void dcn35_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
index 7e558ca195ef..e1f0a1bf1075 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
@@ -215,6 +215,8 @@ static const struct link_encoder_funcs dcn401_link_enc_funcs = {
 	.is_in_alt_mode = dcn32_link_encoder_is_in_alt_mode,
 	.get_max_link_cap = dcn32_link_encoder_get_max_link_cap,
 	.set_dio_phy_mux = dcn31_link_encoder_set_dio_phy_mux,
+	.get_hpd_state = dcn10_get_hpd_state,
+	.program_hpd_filter = dcn10_program_hpd_filter,
 };
 
 void dcn401_link_encoder_construct(
@@ -236,6 +238,7 @@ void dcn401_link_encoder_construct(
 	enc10->base.ctx = init_data->ctx;
 	enc10->base.id = init_data->encoder;
 
+	enc10->base.hpd_gpio = init_data->hpd_gpio;
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 21cee49c128f..1783a3c59061 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -729,7 +729,6 @@ void dce110_edp_wait_for_hpd_ready(
 {
 	struct dc_context *ctx = link->ctx;
 	struct graphics_object_id connector = link->link_enc->connector;
-	struct gpio *hpd;
 	bool edp_hpd_high = false;
 	uint32_t time_elapsed = 0;
 	uint32_t timeout = power_up ?
@@ -753,31 +752,16 @@ void dce110_edp_wait_for_hpd_ready(
 	 * we need to wait until SENSE bit is high/low.
 	 */
 
-	/* obtain HPD */
-	/* TODO what to do with this? */
-	hpd = ctx->dc->link_srv->get_hpd_gpio(ctx->dc_bios, connector, ctx->gpio_service);
-
-	if (!hpd) {
-		BREAK_TO_DEBUGGER();
-		return;
-	}
-
 	if (link->panel_config.pps.extra_t3_ms > 0) {
 		int extra_t3_in_ms = link->panel_config.pps.extra_t3_ms;
 
 		msleep(extra_t3_in_ms);
 	}
 
-	dal_gpio_open(hpd, GPIO_MODE_INTERRUPT);
-
 	/* wait until timeout or panel detected */
 
 	do {
-		uint32_t detected = 0;
-
-		dal_gpio_get_value(hpd, &detected);
-
-		if (!(detected ^ power_up)) {
+		if (!(link->dc->link_srv->get_hpd_state(link) ^ power_up)) {
 			edp_hpd_high = true;
 			break;
 		}
@@ -787,10 +771,6 @@ void dce110_edp_wait_for_hpd_ready(
 		time_elapsed += HPD_CHECK_INTERVAL;
 	} while (time_elapsed < timeout);
 
-	dal_gpio_close(hpd);
-
-	dal_gpio_destroy_irq(&hpd);
-
 	/* ensure that the panel is detected */
 	if (!edp_hpd_high)
 		DC_LOG_DC("%s: wait timed out!\n", __func__);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index df512920a9fa..cff705c49564 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -44,6 +44,7 @@ struct pipe_ctx;
 struct encoder_init_data {
 	enum channel_id channel;
 	struct graphics_object_id connector;
+	struct gpio *hpd_gpio;
 	enum hpd_source_id hpd_source;
 	/* TODO: in DAL2, here was pointer to EventManagerInterface */
 	struct graphics_object_id encoder;
@@ -87,6 +88,7 @@ struct link_encoder {
 	enum engine_id analog_engine;
 	struct encoder_feature_support features;
 	enum transmitter transmitter;
+	struct gpio *hpd_gpio;
 	enum hpd_source_id hpd_source;
 	bool usbc_combo_phy;
 };
@@ -178,6 +180,8 @@ struct link_encoder_funcs {
 	void (*disable_dpia_output)(struct link_encoder *link_enc,
 		uint8_t dpia_id,
 		uint8_t digmode);
+	bool (*get_hpd_state)(struct link_encoder *enc);
+	bool (*program_hpd_filter)(struct link_encoder *enc, int delay_on_connect_in_ms, int delay_on_disconnect_in_ms);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index 2f805ba19a52..4b092a9ee4c6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -114,9 +114,6 @@ struct link_service {
 			struct dc_sink_init_data *init_data);
 	void (*remove_remote_sink)(struct dc_link *link, struct dc_sink *sink);
 	bool (*get_hpd_state)(struct dc_link *link);
-	struct gpio *(*get_hpd_gpio)(struct dc_bios *dcb,
-			struct graphics_object_id link_id,
-			struct gpio_service *gpio_service);
 	void (*enable_hpd)(const struct dc_link *link);
 	void (*disable_hpd)(const struct dc_link *link);
 	void (*enable_hpd_filter)(struct dc_link *link, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index f9258d71b68e..373e68cf2bde 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1400,8 +1400,6 @@ static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *ty
  */
 bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *type)
 {
-	uint32_t is_hpd_high = 0;
-
 	if (link->connector_signal == SIGNAL_TYPE_LVDS) {
 		*type = dc_connection_single;
 		return true;
@@ -1436,10 +1434,7 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 	}
 
 
-	if (!query_hpd_status(link, &is_hpd_high))
-		goto hpd_gpio_failure;
-
-	if (is_hpd_high) {
+	if (link_get_hpd_state(link)) {
 		*type = dc_connection_single;
 		/* TODO: need to do the actual detection */
 	} else {
@@ -1452,9 +1447,6 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 	}
 
 	return true;
-
-hpd_gpio_failure:
-	return false;
 }
 
 bool link_detect(struct dc_link *link, enum dc_detect_reason reason)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 90a4f37a5da3..56fdd1446a59 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -73,7 +73,6 @@ static void construct_link_service_detection(struct link_service *link_srv)
 	link_srv->add_remote_sink = link_add_remote_sink;
 	link_srv->remove_remote_sink = link_remove_remote_sink;
 	link_srv->get_hpd_state = link_get_hpd_state;
-	link_srv->get_hpd_gpio = link_get_hpd_gpio;
 	link_srv->enable_hpd = link_enable_hpd;
 	link_srv->disable_hpd = link_disable_hpd;
 	link_srv->enable_hpd_filter = link_enable_hpd_filter;
@@ -363,11 +362,6 @@ static void link_destruct(struct dc_link *link)
 {
 	int i;
 
-	if (link->hpd_gpio) {
-		dal_gpio_destroy_irq(&link->hpd_gpio);
-		link->hpd_gpio = NULL;
-	}
-
 	if (link->ddc)
 		link_destroy_ddc_service(&link->ddc);
 
@@ -536,25 +530,76 @@ static bool construct_phy(struct dc_link *link,
 	if (link->dc->res_pool->funcs->link_init)
 		link->dc->res_pool->funcs->link_init(link);
 
-	link->hpd_gpio = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
+	ddc_service_init_data.ctx = link->ctx;
+	ddc_service_init_data.id = link->link_id;
+	ddc_service_init_data.link = link;
+	link->ddc = link_create_ddc_service(&ddc_service_init_data);
+
+	if (!link->ddc) {
+		DC_ERROR("Failed to create ddc_service!\n");
+		goto ddc_create_fail;
+	}
+
+	if (!link->ddc->ddc_pin) {
+		DC_ERROR("Failed to get I2C info for connector!\n");
+		goto ddc_create_fail;
+	}
+
+	link->ddc_hw_inst =
+		dal_ddc_get_line(get_ddc_pin(link->ddc));
+
+	enc_init_data.ctx = dc_ctx;
+	enc_init_data.connector = link->link_id;
+	enc_init_data.channel = get_ddc_line(link);
+	enc_init_data.transmitter = transmitter_from_encoder;
+	enc_init_data.encoder = link_encoder;
+	enc_init_data.analog_engine = link_analog_engine;
+	enc_init_data.hpd_gpio = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
 				      link->ctx->gpio_service);
 
-	if (link->hpd_gpio) {
-		dal_gpio_open(link->hpd_gpio, GPIO_MODE_INTERRUPT);
-		dal_gpio_unlock_pin(link->hpd_gpio);
-		link->irq_source_hpd = dal_irq_get_source(link->hpd_gpio);
+	if (enc_init_data.hpd_gpio) {
+		dal_gpio_open(enc_init_data.hpd_gpio, GPIO_MODE_INTERRUPT);
+		dal_gpio_unlock_pin(enc_init_data.hpd_gpio);
+		link->irq_source_hpd = dal_irq_get_source(enc_init_data.hpd_gpio);
+		enc_init_data.hpd_source = get_hpd_line(link);
+		link->hpd_src = enc_init_data.hpd_source;
+
+		DC_LOG_DC("BIOS object table - hpd_gpio id: %d", enc_init_data.hpd_gpio->id);
+		DC_LOG_DC("BIOS object table - hpd_gpio en: %d", enc_init_data.hpd_gpio->en);
+	} else {
+		struct graphics_object_hpd_info hpd_info;
+
+		if (link->ctx->dc_bios->funcs->get_hpd_info(link->ctx->dc_bios, link->link_id, &hpd_info) == BP_RESULT_OK) {
+			link->hpd_src = hpd_info.hpd_int_gpio_uid - 1;
+			link->irq_source_hpd =  DC_IRQ_SOURCE_HPD1 + link->hpd_src;
+			enc_init_data.hpd_source = link->hpd_src;
+			DC_LOG_DC("BIOS object table - hpd_int_gpio_uid id: %d", hpd_info.hpd_int_gpio_uid);
+		} else {
+			ASSERT(0);
+			enc_init_data.hpd_source = HPD_SOURCEID_UNKNOWN;
+		}
+	}
 
-		DC_LOG_DC("BIOS object table - hpd_gpio id: %d", link->hpd_gpio->id);
-		DC_LOG_DC("BIOS object table - hpd_gpio en: %d", link->hpd_gpio->en);
+	link->link_enc =
+		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
+
+	if (!link->link_enc) {
+		DC_ERROR("Failed to create link encoder!\n");
+		goto link_enc_create_fail;
 	}
 
+	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
+	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
+
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A:
 		link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 
-		if (link->hpd_gpio)
+		if (link->link_enc->hpd_gpio)
 			link->irq_source_read_request =
-					dal_irq_get_read_request(link->hpd_gpio);
+					dal_irq_get_read_request(link->link_enc->hpd_gpio);
+		else if (link->hpd_src != HPD_SOURCEID_UNKNOWN)
+			link->irq_source_read_request = DC_IRQ_SOURCE_DCI2C_RR_DDC1 + link->hpd_src;
 		break;
 	case CONNECTOR_ID_SINGLE_LINK_DVID:
 	case CONNECTOR_ID_SINGLE_LINK_DVII:
@@ -572,9 +617,11 @@ static bool construct_phy(struct dc_link *link,
 	case CONNECTOR_ID_USBC:
 		link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
 
-		if (link->hpd_gpio)
+		if (link->link_enc->hpd_gpio)
 			link->irq_source_hpd_rx =
-					dal_irq_get_rx_source(link->hpd_gpio);
+					dal_irq_get_rx_source(link->link_enc->hpd_gpio);
+		else if (link->hpd_src != HPD_SOURCEID_UNKNOWN)
+			link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX + link->hpd_src;
 
 		break;
 	case CONNECTOR_ID_EDP:
@@ -584,37 +631,45 @@ static bool construct_phy(struct dc_link *link,
 			goto create_fail;
 
 		link->connector_signal = SIGNAL_TYPE_EDP;
+		if (!link->dc->config.allow_edp_hotplug_detection
+			&& !is_smartmux_suported(link))
+			link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 
-		if (link->hpd_gpio) {
-			if (!link->dc->config.allow_edp_hotplug_detection
-				&& !is_smartmux_suported(link))
-				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
-
-			switch (link->dc->config.allow_edp_hotplug_detection) {
-			case HPD_EN_FOR_ALL_EDP:
+		switch (link->dc->config.allow_edp_hotplug_detection) {
+		case HPD_EN_FOR_ALL_EDP:
+			if (link->link_enc->hpd_gpio) {
 				link->irq_source_hpd_rx =
-						dal_irq_get_rx_source(link->hpd_gpio);
-				break;
-			case HPD_EN_FOR_PRIMARY_EDP_ONLY:
-				if (link->link_index == 0)
+						dal_irq_get_rx_source(link->link_enc->hpd_gpio);
+				} else if (link->hpd_src != HPD_SOURCEID_UNKNOWN) {
+					link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX + link->hpd_src;
+				}
+			break;
+		case HPD_EN_FOR_PRIMARY_EDP_ONLY:
+			if (link->link_index == 0) {
+				if (link->link_enc->hpd_gpio) {
 					link->irq_source_hpd_rx =
-						dal_irq_get_rx_source(link->hpd_gpio);
-				else
-					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
-				break;
-			case HPD_EN_FOR_SECONDARY_EDP_ONLY:
-				if (link->link_index == 1)
+						dal_irq_get_rx_source(link->link_enc->hpd_gpio);
+				} else if (link->hpd_src != HPD_SOURCEID_UNKNOWN) {
+					link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX + link->hpd_src;
+				}
+			} else
+				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+			break;
+		case HPD_EN_FOR_SECONDARY_EDP_ONLY:
+			if (link->link_index == 1) {
+				if (link->link_enc->hpd_gpio) {
 					link->irq_source_hpd_rx =
-						dal_irq_get_rx_source(link->hpd_gpio);
-				else
-					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
-				break;
-			default:
+						dal_irq_get_rx_source(link->link_enc->hpd_gpio);
+				} else if (link->hpd_src != HPD_SOURCEID_UNKNOWN) {
+					link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX + link->hpd_src;
+				}
+			} else
 				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
-				break;
-			}
+			break;
+		default:
+			link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+			break;
 		}
-
 		break;
 	case CONNECTOR_ID_LVDS:
 		link->connector_signal = SIGNAL_TYPE_LVDS;
@@ -629,45 +684,6 @@ static bool construct_phy(struct dc_link *link,
 		  init_params->connector_index,
 		  signal_type_to_string(link->connector_signal));
 
-	ddc_service_init_data.ctx = link->ctx;
-	ddc_service_init_data.id = link->link_id;
-	ddc_service_init_data.link = link;
-	link->ddc = link_create_ddc_service(&ddc_service_init_data);
-
-	if (!link->ddc) {
-		DC_ERROR("Failed to create ddc_service!\n");
-		goto ddc_create_fail;
-	}
-
-	if (!link->ddc->ddc_pin) {
-		DC_ERROR("Failed to get I2C info for connector!\n");
-		goto ddc_create_fail;
-	}
-
-	link->ddc_hw_inst =
-		dal_ddc_get_line(get_ddc_pin(link->ddc));
-
-	enc_init_data.ctx = dc_ctx;
-	enc_init_data.connector = link->link_id;
-	enc_init_data.channel = get_ddc_line(link);
-	enc_init_data.hpd_source = get_hpd_line(link);
-	enc_init_data.transmitter = transmitter_from_encoder;
-	enc_init_data.encoder = link_encoder;
-	enc_init_data.analog_engine = link_analog_engine;
-
-	link->hpd_src = enc_init_data.hpd_source;
-
-	link->link_enc =
-		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
-
-	if (!link->link_enc) {
-		DC_ERROR("Failed to create link encoder!\n");
-		goto link_enc_create_fail;
-	}
-
-	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
-	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
-
 	/* Update link encoder tracking variables. These are used for the dynamic
 	 * assignment of link encoders to streams.
 	 */
@@ -776,19 +792,16 @@ static bool construct_phy(struct dc_link *link,
 	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
 	return true;
 device_tag_fail:
-	link->link_enc->funcs->destroy(&link->link_enc);
 link_enc_create_fail:
-	if (link->panel_cntl != NULL)
-		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 panel_cntl_create_fail:
-	link_destroy_ddc_service(&link->ddc);
 ddc_create_fail:
 create_fail:
-
-	if (link->hpd_gpio) {
-		dal_gpio_destroy_irq(&link->hpd_gpio);
-		link->hpd_gpio = NULL;
-	}
+	if (link->ddc)
+		link_destroy_ddc_service(&link->ddc);
+	if (link->panel_cntl)
+		link->panel_cntl->funcs->destroy(&link->panel_cntl);
+	if (link->link_enc)
+		link->link_enc->funcs->destroy(&link->link_enc);
 
 	DC_LOG_DC("BIOS object table - %s failed.\n", __func__);
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
index caa617883f62..29f3a03687b2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
@@ -35,62 +35,75 @@
 
 bool link_get_hpd_state(struct dc_link *link)
 {
-	uint32_t state = 0;
-
-	dal_gpio_lock_pin(link->hpd_gpio);
-	dal_gpio_get_value(link->hpd_gpio, &state);
-	dal_gpio_unlock_pin(link->hpd_gpio);
-
-	return state;
+	if (link->link_enc)
+		return link->link_enc->funcs->get_hpd_state(link->link_enc);
+	else
+		return false;
 }
 
 void link_enable_hpd(const struct dc_link *link)
 {
-	struct link_encoder *encoder = link->link_enc;
-
-	if (encoder != NULL && encoder->funcs->enable_hpd != NULL)
-		encoder->funcs->enable_hpd(encoder);
+	if (link->link_enc)
+		link->link_enc->funcs->enable_hpd(link->link_enc);
 }
 
 void link_disable_hpd(const struct dc_link *link)
 {
-	struct link_encoder *encoder = link->link_enc;
-
-	if (encoder != NULL && encoder->funcs->enable_hpd != NULL)
-		encoder->funcs->disable_hpd(encoder);
+	if (link->link_enc)
+		link->link_enc->funcs->disable_hpd(link->link_enc);
 }
 
 void link_enable_hpd_filter(struct dc_link *link, bool enable)
 {
-	struct gpio *hpd;
-
 	if (enable) {
 		link->is_hpd_filter_disabled = false;
 		program_hpd_filter(link);
 	} else {
 		link->is_hpd_filter_disabled = true;
-		/* Obtain HPD handle */
-		hpd = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id, link->ctx->gpio_service);
-
-		if (!hpd)
-			return;
-
-		/* Setup HPD filtering */
-		if (dal_gpio_open(hpd, GPIO_MODE_INTERRUPT) == GPIO_RESULT_OK) {
-			struct gpio_hpd_config config;
+		if (link->link_enc)
+			link->link_enc->funcs->program_hpd_filter(link->link_enc, 0, 0);
+	}
+}
 
-			config.delay_on_connect = 0;
-			config.delay_on_disconnect = 0;
+bool program_hpd_filter(const struct dc_link *link)
+{
+	int delay_on_connect_in_ms = 0;
+	int delay_on_disconnect_in_ms = 0;
 
-			dal_irq_setup_hpd_filter(hpd, &config);
+	if (link->is_hpd_filter_disabled || !link->link_enc) {
+		ASSERT(link->link_enc);
+		return false;
+	}
 
-			dal_gpio_close(hpd);
-		} else {
-			ASSERT_CRITICAL(false);
-		}
-		/* Release HPD handle */
-		dal_gpio_destroy_irq(&hpd);
+	/* Verify feature is supported */
+	switch (link->connector_signal) {
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		/* Program hpd filter */
+		delay_on_connect_in_ms = 500;
+		delay_on_disconnect_in_ms = 100;
+		break;
+	case SIGNAL_TYPE_DISPLAY_PORT:
+	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		/* Program hpd filter to allow DP signal to settle */
+		/* 500:	not able to detect MST <-> SST switch as HPD is low for
+		 * only 100ms on DELL U2413
+		 * 0: some passive dongle still show aux mode instead of i2c
+		 * 20-50: not enough to hide bouncing HPD with passive dongle.
+		 * also see intermittent i2c read issues.
+		 */
+		delay_on_connect_in_ms = 80;
+		delay_on_disconnect_in_ms = 0;
+		break;
+	case SIGNAL_TYPE_LVDS:
+	case SIGNAL_TYPE_EDP:
+	default:
+		/* Don't program hpd filter */
+		return false;
 	}
+
+	return link->link_enc->funcs->program_hpd_filter(link->link_enc, delay_on_connect_in_ms, delay_on_disconnect_in_ms);
 }
 
 struct gpio *link_get_hpd_gpio(struct dc_bios *dcb,
@@ -108,7 +121,6 @@ struct gpio *link_get_hpd_gpio(struct dc_bios *dcb,
 		hpd_info.hpd_int_gpio_uid, &pin_info);
 
 	if (bp_result != BP_RESULT_OK) {
-		ASSERT(bp_result == BP_RESULT_NORECORD);
 		return NULL;
 	}
 
@@ -117,21 +129,6 @@ struct gpio *link_get_hpd_gpio(struct dc_bios *dcb,
 					   pin_info.mask);
 }
 
-bool query_hpd_status(struct dc_link *link, uint32_t *is_hpd_high)
-{
-	struct gpio *hpd_pin = link_get_hpd_gpio(
-			link->ctx->dc_bios, link->link_id,
-			link->ctx->gpio_service);
-	if (!hpd_pin)
-		return false;
-
-	dal_gpio_open(hpd_pin, GPIO_MODE_INTERRUPT);
-	dal_gpio_get_value(hpd_pin, is_hpd_high);
-	dal_gpio_close(hpd_pin);
-	dal_gpio_destroy_irq(&hpd_pin);
-	return true;
-}
-
 enum hpd_source_id get_hpd_line(struct dc_link *link)
 {
 	struct gpio *hpd;
@@ -172,69 +169,3 @@ enum hpd_source_id get_hpd_line(struct dc_link *link)
 
 	return hpd_id;
 }
-
-bool program_hpd_filter(const struct dc_link *link)
-{
-	bool result = false;
-	struct gpio *hpd;
-	int delay_on_connect_in_ms = 0;
-	int delay_on_disconnect_in_ms = 0;
-
-	if (link->is_hpd_filter_disabled)
-		return false;
-	/* Verify feature is supported */
-	switch (link->connector_signal) {
-	case SIGNAL_TYPE_DVI_SINGLE_LINK:
-	case SIGNAL_TYPE_DVI_DUAL_LINK:
-	case SIGNAL_TYPE_HDMI_TYPE_A:
-		/* Program hpd filter */
-		delay_on_connect_in_ms = 500;
-		delay_on_disconnect_in_ms = 100;
-		break;
-	case SIGNAL_TYPE_DISPLAY_PORT:
-	case SIGNAL_TYPE_DISPLAY_PORT_MST:
-		/* Program hpd filter to allow DP signal to settle */
-		/* 500:	not able to detect MST <-> SST switch as HPD is low for
-		 * only 100ms on DELL U2413
-		 * 0: some passive dongle still show aux mode instead of i2c
-		 * 20-50: not enough to hide bouncing HPD with passive dongle.
-		 * also see intermittent i2c read issues.
-		 */
-		delay_on_connect_in_ms = 80;
-		delay_on_disconnect_in_ms = 0;
-		break;
-	case SIGNAL_TYPE_LVDS:
-	case SIGNAL_TYPE_EDP:
-	default:
-		/* Don't program hpd filter */
-		return false;
-	}
-
-	/* Obtain HPD handle */
-	hpd = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
-			   link->ctx->gpio_service);
-
-	if (!hpd)
-		return result;
-
-	/* Setup HPD filtering */
-	if (dal_gpio_open(hpd, GPIO_MODE_INTERRUPT) == GPIO_RESULT_OK) {
-		struct gpio_hpd_config config;
-
-		config.delay_on_connect = delay_on_connect_in_ms;
-		config.delay_on_disconnect = delay_on_disconnect_in_ms;
-
-		dal_irq_setup_hpd_filter(hpd, &config);
-
-		dal_gpio_close(hpd);
-
-		result = true;
-	} else {
-		ASSERT_CRITICAL(false);
-	}
-
-	/* Release HPD handle */
-	dal_gpio_destroy_irq(&hpd);
-
-	return result;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h
index af529328ba17..b4e449de960e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h
@@ -43,7 +43,6 @@ bool program_hpd_filter(const struct dc_link *link);
  * Returns true if HPD high.
  */
 bool dpia_query_hpd_status(struct dc_link *link);
-bool query_hpd_status(struct dc_link *link, uint32_t *is_hpd_high);
 bool link_get_hpd_state(struct dc_link *link);
 struct gpio *link_get_hpd_gpio(struct dc_bios *dcb,
 		struct graphics_object_id link_id,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 99f0432288b4..684945fdd378 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -317,7 +317,10 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
   AUX_REG_LIST_RI(id), SRI_ARR(AUX_DPHY_TX_CONTROL, DP_AUX, id)
 
 /* HDP */
-#define HPD_REG_LIST_RI(id) SRI_ARR(DC_HPD_CONTROL, HPD, id)
+#define HPD_REG_LIST_RI(id)                                                  \
+  SRI_ARR(DC_HPD_CONTROL, HPD, id),                                          \
+      SRI_ARR(DC_HPD_INT_STATUS, HPD, id),                                   \
+      SRI_ARR(DC_HPD_TOGGLE_FILT_CNTL, HPD, id)
 
 /* Link encoder */
 #define LE_DCN3_REG_LIST_RI(id)                                                \
-- 
2.34.1

