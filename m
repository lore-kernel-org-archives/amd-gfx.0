Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE5CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2554206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2554206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6601E89450;
	Fri, 15 Jan 2021 17:31:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF38C89450
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZn2KYUzOgRcqbDGy4gjiAemy7ogvFCDzCTGASI3ivHEpnshhlNSvPX3Myodvb/aRbTu/jQnLqhpzMmi0IPJbR5OrH6j8V+9rjIVXtuBPOYO0KjqFdh+wRYnxWzwFMK0YV/vdxl42kN/g9C+uzGhXTPPfctWNYW2+Sct4yeUGgQzXtN6SP4F5y38CuiSQaCNUjmzMEDeVCRXHxldavP4BS+nKX5OrlIDDygIqZ0vBRYgo+GgVg4Cbitcns7mSluuHfoXnWMxeAqgQXSFM8QRYjs7iN5piIIughVKfL1lgcQR8c4Z9CeyiptA+pPZDg0WFn+JBvyNt5dUkbmn+jSjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h2sTGBJsqplzk0KSXa6hz4b3sk4INR4c6IRmW/4SQk=;
 b=T7mo6XfHj13+VNs5aqYDnHi79xBV3ROFAmltjQijUE3wpecrqRrQhyHQDhvxguk9jEMungUWnlBAdzJUmdTPmsplMdx2erCA79F7b7pNTlOQ2mgKIhvE5VkMkQ9nMl4XNZomfWEwHsNLank3dtzUvN29hhcOOSPmMkJ0nCmxuW2L331hNrkEqu1l7ewhLqBjYYP5b2cWc/gZJKd6ILa2IJiOfN2+NIIHhoUr4Ucyl1/ViSCcaH/7npazofy4GIuOvBB1fAQTAjFi8r7f7xZ90jNeCDD3jDTT4Ue8tJi923ERFkBkUrz/0pHhdQR44k7AF5wA77O4YEk9BNGLzghA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h2sTGBJsqplzk0KSXa6hz4b3sk4INR4c6IRmW/4SQk=;
 b=DDFjgFGEO1eCIzbMKPOna/4ECGKYNB9jud3dFzu/DR6+Ou6saKdysVGQWGJOjQTN90Kj1okjqgaLiUWEIeF3/dxfe9EWpvyGeVBz2CBQmWB9qX/93C3Y+XF0HEPZWHd4ks3AbFegSsrx9UhKqXW/W6oJbUllfsABZOeokGB7epc=
Received: from DM5PR06CA0058.namprd06.prod.outlook.com (2603:10b6:3:37::20) by
 MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 17:31:30 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::81) by DM5PR06CA0058.outlook.office365.com
 (2603:10b6:3:37::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:31:27 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:27 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:31:21 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Log link/connector info provided in
 BIOS object table
Date: Fri, 15 Jan 2021 12:27:13 -0500
Message-ID: <20210115172714.126866-12-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82959563-5484-4088-ba68-08d8b97b63d0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3759:
X-Microsoft-Antispam-PRVS: <MN2PR12MB375915FD41AF4DDC89A98599EBA70@MN2PR12MB3759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuvabCjwZGokSs6szehmHN4ZQftvMPefyTlb+RU3qI0Kz4v4Nn447DNopMja3uTiqqb8ul0J7HawWkFNt9rBdQyOOBdjrOhN9bEYVlWGbASVJOpZRcljiTked34fX8Bi9Jg7RDAa5Phxb5WcQAmkqry78RKOusrGPZu8MAssKpJrFyBDTPGfxkefEUZ7OSFgHwCBeBrNgm5ZfgShbMoHVzEaP9UNL2UaIUh6PSOUfK2At/jWZSlpzdXhWoU66REChWLwLObErtnTDjBOIXCuCQ0CtTRWJfH6zzURxGV6etWfizJG7ohA/vyLbYO4aHpyub4orTq0v8S0U8+Gvx3F2hD0HRBoq0CsdhCSzJwQsex0sTNsrinpvhLv7Wu5e4CXxR4r0bJG7c3Yvzj7hEox+1nsEyQ9pLbio6hLJBe8C9P24I2W5Z56P9rCvPKy6JQJ397nNeKKc7OosB2dsVn/qsieVm6Waby4OqsUCR7M3CBfdM8mxfn8pvhw0x4U2Kn4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(1076003)(186003)(86362001)(6916009)(316002)(82310400003)(426003)(2906002)(2616005)(4326008)(34020700004)(36756003)(7696005)(8936002)(6666004)(70586007)(70206006)(47076005)(83380400001)(478600001)(81166007)(5660300002)(8676002)(82740400003)(356005)(26005)(336012)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:31:27.8655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82959563-5484-4088-ba68-08d8b97b63d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 George Shen <george.shen@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why/How]
Add logging statements to assist in debugging
errors in the BIOS object table.

Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c       |  6 ++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c  | 18 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c  |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7801b44cfaec..e9d0afa65e07 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -175,6 +175,8 @@ static bool create_links(
 
 	connectors_num = bios->funcs->get_connectors_number(bios);
 
+	DC_LOG_DC("BIOS object table - number of connectors: %d", connectors_num);
+
 	if (connectors_num > ENUM_ID_COUNT) {
 		dm_error(
 			"DC: Number of connectors %d exceeds maximum of %d!\n",
@@ -193,6 +195,8 @@ static bool create_links(
 		struct link_init_data link_init_params = {0};
 		struct dc_link *link;
 
+		DC_LOG_DC("BIOS object table - printing link object info for connector number: %d, link_index: %d", i, dc->link_count);
+
 		link_init_params.ctx = dc->ctx;
 		/* next BIOS object table connector */
 		link_init_params.connector_index = i;
@@ -225,6 +229,8 @@ static bool create_links(
 		}
 	}
 
+	DC_LOG_DC("BIOS object table - end");
+
 	for (i = 0; i < num_virtual_links; i++) {
 		struct dc_link *link = kzalloc(sizeof(*link), GFP_KERNEL);
 		struct encoder_init_data enc_init = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 8b2d387a46dc..d570e7cbcdaf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1398,10 +1398,12 @@ static bool dc_link_construct(struct dc_link *link,
 	link->link_id =
 		bios->funcs->get_connector_id(bios, init_params->connector_index);
 
+	DC_LOG_DC("BIOS object table - link_id: %d", link->link_id.id);
 
 	if (bios->funcs->get_disp_connector_caps_info) {
 		bios->funcs->get_disp_connector_caps_info(bios, link->link_id, &disp_connect_caps_info);
 		link->is_internal_display = disp_connect_caps_info.INTERNAL_DISPLAY;
+		DC_LOG_DC("BIOS object table - is_internal_display: %d", link->is_internal_display);
 	}
 
 	if (link->link_id.type != OBJECT_TYPE_CONNECTOR) {
@@ -1416,10 +1418,14 @@ static bool dc_link_construct(struct dc_link *link,
 
 	link->hpd_gpio = get_hpd_gpio(link->ctx->dc_bios, link->link_id,
 				      link->ctx->gpio_service);
+
 	if (link->hpd_gpio) {
 		dal_gpio_open(link->hpd_gpio, GPIO_MODE_INTERRUPT);
 		dal_gpio_unlock_pin(link->hpd_gpio);
 		link->irq_source_hpd = dal_irq_get_source(link->hpd_gpio);
+
+		DC_LOG_DC("BIOS object table - hpd_gpio id: %d", link->hpd_gpio->id);
+		DC_LOG_DC("BIOS object table - hpd_gpio en: %d", link->hpd_gpio->en);
 	}
 
 	switch (link->link_id.id) {
@@ -1516,6 +1522,8 @@ static bool dc_link_construct(struct dc_link *link,
 	link->link_enc =
 		link->dc->res_pool->funcs->link_enc_create(&enc_init_data);
 
+	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
+
 	if (!link->link_enc) {
 		DC_ERROR("Failed to create link encoder!\n");
 		goto link_enc_create_fail;
@@ -1543,6 +1551,10 @@ static bool dc_link_construct(struct dc_link *link,
 		if (link->device_tag.dev_id.device_type == DEVICE_TYPE_LCD &&
 		    link->connector_signal == SIGNAL_TYPE_RGB)
 			continue;
+
+		DC_LOG_DC("BIOS object table - device_tag.acpi_device: %d", link->device_tag.acpi_device);
+		DC_LOG_DC("BIOS object table - device_tag.dev_id.device_type: %d", link->device_tag.dev_id.device_type);
+		DC_LOG_DC("BIOS object table - device_tag.dev_id.enum_id: %d", link->device_tag.dev_id.enum_id);
 		break;
 	}
 
@@ -1561,10 +1573,14 @@ static bool dc_link_construct(struct dc_link *link,
 			    path->device_acpi_enum == link->device_tag.acpi_device) {
 				link->ddi_channel_mapping = path->channel_mapping;
 				link->chip_caps = path->caps;
+				DC_LOG_DC("BIOS object table - ddi_channel_mapping: 0x%04X", link->ddi_channel_mapping.raw);
+				DC_LOG_DC("BIOS object table - chip_caps: %d", link->chip_caps);
 			} else if (path->device_tag ==
 				   link->device_tag.dev_id.raw_device_tag) {
 				link->ddi_channel_mapping = path->channel_mapping;
 				link->chip_caps = path->caps;
+				DC_LOG_DC("BIOS object table - ddi_channel_mapping: 0x%04X", link->ddi_channel_mapping.raw);
+				DC_LOG_DC("BIOS object table - chip_caps: %d", link->chip_caps);
 			}
 			break;
 		}
@@ -1583,6 +1599,7 @@ static bool dc_link_construct(struct dc_link *link,
 
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
+	DC_LOG_DC("BIOS object table - dc_link_contruct finished successfully.\n");
 	return true;
 device_tag_fail:
 	link->link_enc->funcs->destroy(&link->link_enc);
@@ -1599,6 +1616,7 @@ static bool dc_link_construct(struct dc_link *link,
 		link->hpd_gpio = NULL;
 	}
 
+	DC_LOG_DC("BIOS object table - dc_link_contruct failed.\n");
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index c5936e064360..26f3d5dd0453 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -37,6 +37,8 @@
 #include "dc_link_ddc.h"
 #include "dce/dce_aux.h"
 
+#define DC_LOGGER_INIT(logger)
+
 /*DP to Dual link DVI converter*/
 static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
 static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
@@ -194,6 +196,10 @@ static void ddc_service_construct(
 	if (BP_RESULT_OK != dcb->funcs->get_i2c_info(dcb, init_data->id, &i2c_info)) {
 		ddc_service->ddc_pin = NULL;
 	} else {
+		DC_LOGGER_INIT(ddc_service->ctx->logger);
+		DC_LOG_DC("BIOS object table - i2c_line: %d", i2c_info.i2c_line);
+		DC_LOG_DC("BIOS object table - i2c_engine_id: %d", i2c_info.i2c_engine_id);
+
 		hw_info.ddc_channel = i2c_info.i2c_line;
 		if (ddc_service->link != NULL)
 			hw_info.hw_supported = i2c_info.i2c_hw_assist;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
