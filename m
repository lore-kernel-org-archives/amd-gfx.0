Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533FAC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AE1112BE7;
	Mon, 22 Apr 2024 15:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xrE+PdIZ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA68F112BE7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV4PPx9JRe97f7+6VfB0bKYOEd4Y6hZSP9ccX3qNPFCzhEBBsBYUqIJDUYGbp9JJnzB4kAZk/EeIn6GWoD8m4Cuv9yLrhMM3C4Tvjn2DVUHPftqPYtR29oQOOrq6jsajItmOJ/9d7NfvZfFi2+Si+hBi3UCpUxUXUdzMFxhoi6mr16C1LfvKxr+wqwM+RwZd5JWavfhvG+Ry9LeOw6hVy7gTaAhFfFF8nuuVf+Pg3zm9x3qObbgOGB260glXS3b2kVc9CYszdse0qgfHB+RA74PI3rxmo/dkH/kqqZxcrGL7i0/yf4kUBWwJv158ZVa/MImzxRDsQj2v0THAZukrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fBgTa9l3tgxuIpfUFPclqI6aaVidxPQ4qAmjIIv0+Q=;
 b=T5Cko+x6lcuW+I1f7cMh69HnyMmxIL0Tw6RcMUTHfyWYWJKhA72z0liFCULPXpMAq4cc+iMaNFWeb1XBurhPoRpc30cb+VBfGEj+lqCGYEoMfqHN5syhuvwZZGqSirmyccNZfo8hgLy0DgdHSxMBlmIzPBmVYlf2RxqpFgvaOr+WhefN9VAyf6iHLOEwEe3Hjv7+egU5Ays7AU/maSr8w7sLYCtAMywuF4zuriYdYH8upB1Ihmklau/2ITsfx0nTCZQRp/4nWaHvMUkKHHRCYWSwixXI8WO86SbYfEQ4olgUPzwU3d4rBsRgJbUQCZ2Sy5F1lPbhTBnogDTo5SNmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fBgTa9l3tgxuIpfUFPclqI6aaVidxPQ4qAmjIIv0+Q=;
 b=xrE+PdIZYWghTpnxkrRMtzDpcIG5oWyKB8AO1y1lhH7YlxdUvIB0dx9CfrMP7hVpSJzfsgtxWARol3Sz6Ek2zDMAqPo++ZoW/MPPIchXrCrUNcYdiXLofiI+EiPIm2QSPGobk3DMp2UdA5cqYyPiZ4wGS8BYMLyJNM61icHi/+0=
Received: from PR0P264CA0231.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::27)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:28:55 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10a6:100:1e:cafe::78) by PR0P264CA0231.outlook.office365.com
 (2603:10a6:100:1e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:28:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:53 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:47 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 07/37] drm/amd/display: Clean up code in DC
Date: Mon, 22 Apr 2024 11:27:16 -0400
Message-ID: <20240422152817.2765349-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b81f94b-1abb-47f4-9eaa-08dc62e0eb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+TQWCmwmEaoL3KuHO048JIQG90ahPGbeomSGUsbYkQF9ibrBYXNDm0DUJvWE?=
 =?us-ascii?Q?4i87znJRo2/faTkd8+T3pmQH665yY9WPl8y2IweRo6KA+7tXltjO9WVXXrEV?=
 =?us-ascii?Q?Vgpglo/3P5D7AO4zvHYh9VHJXMM5vuhbHJOwcFP2tfD1pDsyIkNd+ox45Dlo?=
 =?us-ascii?Q?fvGuYnlowEln9VMfHRkCHhftIr9CJtTz2n7irMvEE1uJlCvRbLQuTS2zW6Ln?=
 =?us-ascii?Q?oDYLosJ0FuGFDEW+jrwaAwtsMdq0gD5mo3nJYNPBMkuZnuuzskuEmgJf1ef2?=
 =?us-ascii?Q?DwY3M5f8AdqwatW6fRt1waAfbn0x85yT2tkiUTE7kFefTj4QszYAuXIKns7G?=
 =?us-ascii?Q?MdG8X8y0eFAaZce3xrDkpIROGOH6PQ581CrGQOk3C67YaUa1dsZ/XoALCI3V?=
 =?us-ascii?Q?vN2vErvIwYHJB1c6KviY7nfr5rGKYoYtv3UFZoQ+b+6zf5Jt0kXDHQM3vbYI?=
 =?us-ascii?Q?bCXUMoe/9+Kqw7qI9HojT7CXYAWoM6bK4oKFLSmW2T48TnWUR5b9+PA/aEm/?=
 =?us-ascii?Q?Kzo0fXwMlGpwu+gwtQJLXtJ2UckhJk2RMZKX+P1HDR+D+/eNT4nreHuxzc2I?=
 =?us-ascii?Q?s8H0CZiynG5CPD+1JBZWP1gbP5U3yTmMsuXQQCckzI1tMLAQP3Zs5MIONg6x?=
 =?us-ascii?Q?CUx7AqAn7NbAAVR0Mi+SsDxRu6A7X2SJfUmN3kUY9Axzs9uid8T3ozOE/R8w?=
 =?us-ascii?Q?+2YGkTSgdky68LKkrgX9/HE/CBIsM2W53Od8hivMIyk0MPSvzeKJyEMchJsm?=
 =?us-ascii?Q?BuiiSha7LaYE1FKrxiSM2kYKdzLxT+DLk5z3iGLGE+RYPgk2dEQpE+cJyNQ9?=
 =?us-ascii?Q?Xl8tCNJGt/RsklZbLAxuBl1iQT+X3JJ4enJfA6d2bgCPpPiw7QdiCeVFDfS6?=
 =?us-ascii?Q?lqmzjLHwDW5Nzb/1pVkcKMmESvQB7oydI/42JidFL8buECt6TGHLaO3emQJN?=
 =?us-ascii?Q?RtBK9F/J8Zjq/kT4FUI9InOYY1uocPhFZhKZM5ZUIs+WhFnyr/WvjuyWHplp?=
 =?us-ascii?Q?DjkAP7rcHAwC7Ff7XD90GgZW9sSEuPqU450/SLFuwQstsbt4bIO2/rvAYehR?=
 =?us-ascii?Q?IUY/NLM4Cf6eJ1i8lhHqXv7BeAgTQI4cDbNnkxuCG5jVDEmHZs0X0eRgp8WB?=
 =?us-ascii?Q?fzoVrS25jg3rLYRJFuDQeR6iXM4LO5RjD0dlvDwtCqIqcsJUmhbWr5HJxl0q?=
 =?us-ascii?Q?BgHWYrmTHqrU4s5FthMtMH6IYKC2XVWhb0/ImBnvp9wDBBJSU+YZ5QNo4+QO?=
 =?us-ascii?Q?lnhBQaMlyyVhzfvZUXzYfBJg0px+qlOwDeMArboewXwFMVonyZNoUgGKkU51?=
 =?us-ascii?Q?gjPL/ME7LmJ7BsH9BJ+8lDzBECWW0cw0gkyJlEFrFxg403fF3bUX0mY1LS+F?=
 =?us-ascii?Q?Je9EAnmFhBRp7ANd14GHM4QtEfi6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:28:54.3987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b81f94b-1abb-47f4-9eaa-08dc62e0eb98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit removes some unnecessary code and makes the required
adjustments to replace other parts of the code with a short option.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h    |  1 -
 .../drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c |  6 +++---
 .../drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h | 10 +---------
 .../amd/display/dc/dcn321/dcn321_dio_link_encoder.c   |  5 -----
 drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h  |  3 +--
 .../amd/display/dc/resource/dcn20/dcn20_resource.c    | 11 +++++------
 6 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
index cbce194ec7b8..68324ac62ae3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
@@ -441,7 +441,6 @@
 	type DCP_RGB_RANDOM_ENABLE; \
 	type DCP_HIGHPASS_RANDOM_ENABLE; \
 	type DENORM_MODE; \
-	type INTERLEAVE_EN; \
 	type PIXEL_DEPTH; \
 	type PIXEL_EXPAN_MODE; \
 	type GAMUT_REMAP_C11; \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index 8a0460e86309..d9ff95cd2dbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -248,13 +248,13 @@ void dcn32_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
-
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
 	enc10->base.features = *enc_features;
 
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
+
 	enc10->base.transmitter = init_data->transmitter;
 
 	/* set the flag to indicate whether driver poll the I2C data pin
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
index 2d5f25290ed1..35d23d9db45e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
@@ -26,15 +26,7 @@
 #ifndef __DC_LINK_ENCODER__DCN32_H__
 #define __DC_LINK_ENCODER__DCN32_H__
 
-#include "dcn31/dcn31_dio_link_encoder.h"
-
-#define LE_DCN32_REG_LIST(id)\
-	LE_DCN31_REG_LIST(id),\
-	SRI(DIG_FIFO_CTRL0, DIG, id)
-
-#define LINK_ENCODER_MASK_SH_LIST_DCN32(mask_sh) \
-	LINK_ENCODER_MASK_SH_LIST_DCN31(mask_sh),\
-	LE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, mask_sh)
+#include "dcn30/dcn30_dio_link_encoder.h"
 
 void dcn32_link_encoder_construct(
 	struct dcn20_link_encoder *enc20,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
index 13be5f06d987..a406c5619c45 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
@@ -127,11 +127,6 @@ void dcn321_link_encoder_construct(
 	 * while doing the DP sink detect
 	 */
 
-/*	if (dal_adapter_service_is_feature_supported(as,
-		FEATURE_DP_SINK_DETECT_POLL_DATA_PIN))
-		enc10->base.features.flags.bits.
-			DP_SINK_DETECT_POLL_DATA_PIN = true;*/
-
 	enc10->base.output_signals =
 		SIGNAL_TYPE_DVI_SINGLE_LINK |
 		SIGNAL_TYPE_DVI_DUAL_LINK |
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index dbe7afa9d3a2..af9183f5d69b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -163,12 +163,11 @@ struct link_encoder_funcs {
 
 	enum signal_type (*get_dig_mode)(
 		struct link_encoder *enc);
+
 	void (*set_dio_phy_mux)(
 		struct link_encoder *enc,
 		enum encoder_type_select sel,
 		uint32_t hpo_inst);
-	void (*set_dig_output_mode)(
-			struct link_encoder *enc, uint8_t pix_per_container);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index d521fc65afe3..6406d31ceefe 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -62,6 +62,9 @@
 #include "dcn20/dcn20_vmid.h"
 #include "dce/dce_panel_cntl.h"
 
+#include "dcn20/dcn20_dwb.h"
+#include "dcn20/dcn20_mmhubbub.h"
+
 #include "navi10_ip_offset.h"
 
 #include "dcn/dcn_2_0_0_offset.h"
@@ -71,9 +74,6 @@
 
 #include "nbio/nbio_2_3_offset.h"
 
-#include "dcn20/dcn20_dwb.h"
-#include "dcn20/dcn20_mmhubbub.h"
-
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
 
@@ -83,11 +83,10 @@
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
 #include "vm_helper.h"
-#include "link_enc_cfg.h"
-
-#include "amdgpu_socbb.h"
 
+#include "link_enc_cfg.h"
 #include "link.h"
+
 #define DC_LOGGER_INIT(logger)
 
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
-- 
2.44.0

