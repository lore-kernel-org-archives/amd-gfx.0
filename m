Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DEC35658
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B12222C4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z944wYRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B12222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782426F4B8;
	Fri, 21 Feb 2020 16:04:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0256F4AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZzz7sr9o6SSLGaCPPSPfWyj2+SGHRW87mKJ4Nwnzr5bmz0Sdik5w0JxxhlOgFjWNa9UZSz7NaqXD9tFqeV4Z5HocFkooF6HfaKlVhz22I1DD1Czu4rB0eem1nMC4eAoDTPi9If+KcHhuqtLpuj0vmsvwkPmvf+5bckXqaIy9qDWxbONe0F+CP79yKcUtRjdZZKs/KYmgNZHtQKUu9aWM3XrJxzF8ZO1imXL/XozXPDB5r+mNQC8cdGAjqOdxLwjLH+6chymBUJefRFmU3CPhqdsZFxA+koBbmRI0wdrId/gLWJW1+1bHEawOnrbWjm4EFi0+E+7kVDzTuDZQNikqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mhnv2z0MBp18of4c9P426uiy6eLHb0FRA69mLTcJsA=;
 b=HQXPgfWkN1yimQISbT2gk/bmGgNSs2wL4oQZ8IIzFlMy8pnoLhRLnNYzpitbw4PuLym7ydgY2RQjSb5aT+Q1l0tb3DCPcgQQ+B+8nG/0YxRjiayF7HaF9J4udxZKdWiVsrZo0L354qyXo1D0lv631wkuSNA6AvKWGSd/3qxGWm3uAScwOrN/Hbc1WSUM+OeUvDQsKnkoUIhTNWCvNAm5ZpPs18B07lagqLl6u179Umx5n2i4mwW+TJLBKVOj+/vQ4Da+ZB/d7HFD6MAycK4Tkh7DA6f8uxWusyOqqIct7is2ADUAN3GLRZkTDu2rqnP+K2XhiNOmeao46UaSEL8J8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mhnv2z0MBp18of4c9P426uiy6eLHb0FRA69mLTcJsA=;
 b=Z944wYRKRdwYvHIeE3Cu9xf+eiPMWLRj0Rmul0fD2qTGGPT9W8Tz93pkBLyS1ID21M7lI9gyXWkaO63QTVr2TTd93liM9IIVhFMaON3/+Yx9/hbmgfF/NXqX/nYpAs8UO7v6UtQXsn0GzOm9qVFp1s9S7m7mrTslu/ZOqtXdtkM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:13 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:13 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/35] drm/amd/display: Add driver support for enabling PSR on
 DMCUB
Date: Fri, 21 Feb 2020 11:03:16 -0500
Message-Id: <20200221160324.2969975-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:09 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7041fe67-faf0-4714-973f-08d7b6e7afbb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24097F9A52E87016EB94DA0C98120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:68;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arxg4qIzawZwAiUY6Ct5lqmuCs2kaKqMShA6P5xrMS+b/X1+APFgr4gz5IKSWXAd7WIkJ5lWP3oMwwmBG1Xeag3AJOsXzIoxfz9TAmgtiJebb2FDPJP1Y38keyF9vYQltqMy+2f0i9J+cK/sB5zDhCYVVOPb7WOwfBhXYm4ZG/sccv0m0KPKMC2/dQUSqqkFhAYt/eIjh155XfkFM9NIcDbgwigDI9ScxqJ+WToy/kGZ+O0brHeP9RSnoz8eiHGvr6oK+2iy9+lSiAqV8V3f1FCRehanZjTRcyi6QecNh/jQT8PdUmBULEs1Z1oZBHEEdZYV9k6r/fsgmBlgw42ILmVv1UlanQXREBjPs8pri4cPeC4SsYXHyKw9QKw1ysnkhTsfERGXzFhk/GnXAa2XbKPdrDS+BsYzFgYEx3V2s4IouSJo0cg1wAHV9P51t9f0
X-MS-Exchange-AntiSpam-MessageData: HyJZVlx7v+vkh5InKKoDs0+iGgvTFNmrcsnKwXKZFsUhyRty3ofgFAzN5bcios3/sn0V1PJBLbeq1FScC7J4cRaGgDGnynRcQhkI9Sbd5BNKy62LsxyxnJ1TOIN5h7u0BPV6xQnyImhoTA6PLQQT4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7041fe67-faf0-4714-973f-08d7b6e7afbb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:10.0540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tm1KzSVcOnYXsGwUbG0AFWuGRB15foCJkL1jS6Co+Ceuo+bIMi7Np6kEVxjfHizPrzXNtOzHk+gZADZ8CHCCog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
We want to be able to enable PSR on DMCUB, and fallback to
DMCU when necessary.

[How]
Add infrastructure to enable and disable PSR on DMCUB.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c   |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h             |  1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h        |  1 +
 drivers/gpu/drm/amd/display/dc/dce/Makefile     |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c   |  5 +++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h   |  3 ++-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c   | 17 +++++++++++++----
 .../drm/amd/display/dmub/inc/dmub_gpint_cmd.h   |  1 +
 8 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3420d098d771..2ccc2db93f5d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -45,7 +45,7 @@
 #include "dpcd_defs.h"
 #include "dmcu.h"
 #include "hw/clk_mgr.h"
-#include "../dce/dmub_psr.h"
+#include "dce/dmub_psr.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -2433,7 +2433,7 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dmub_psr *psr = dc->res_pool->psr;
 
-	if ((psr != NULL) && link->psr_feature_enabled)
+	if (psr != NULL && link->psr_feature_enabled)
 		psr->funcs->psr_enable(psr, allow_active);
 	else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_feature_enabled)
 		dmcu->funcs->set_psr_enable(dmcu, allow_active, wait);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f8ee2b75d2b8..e10d5a7d0cb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -410,6 +410,7 @@ struct dc_debug_options {
 	bool dmub_offload_enabled;
 	bool dmcub_emulation;
 	bool dmub_command_table; /* for testing only */
+	bool psr_on_dmub;
 	struct dc_bw_validation_profile bw_val_profile;
 	bool disable_fec;
 	bool disable_48mhz_pwrdwn;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 5f341e960506..c45c7680fa58 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -26,6 +26,7 @@
 #ifndef DC_LINK_H_
 #define DC_LINK_H_
 
+#include "dc.h"
 #include "dc_types.h"
 #include "grph_object_defs.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/drm/amd/display/dc/dce/Makefile
index fdf3d8f87eee..fbfcff700971 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
@@ -29,7 +29,7 @@
 DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_hwseq.o \
 dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
 dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o \
-dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o
+dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o
 
 AMD_DAL_DCE = $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 22cd68f7dca0..2c932c29f1f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -27,7 +27,7 @@
 #include "dc.h"
 #include "dc_dmub_srv.h"
 #include "../../dmub/inc/dmub_srv.h"
-#include "dmub_fw_state.h"
+#include "../../dmub/inc/dmub_gpint_cmd.h"
 #include "core_types.h"
 
 #define MAX_PIPES 6
@@ -131,8 +131,9 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		= &cmd.psr_copy_settings.psr_copy_settings_data;
 	struct pipe_ctx *pipe_ctx = NULL;
 	struct resource_context *res_ctx = &link->ctx->dc->current_state->res_ctx;
+	int i = 0;
 
-	for (int i = 0; i < MAX_PIPES; i++) {
+	for (i = 0; i < MAX_PIPES; i++) {
 		if (res_ctx &&
 			res_ctx->pipe_ctx[i].stream &&
 			res_ctx->pipe_ctx[i].stream->link &&
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index 3de7b9439f42..f404fecd6410 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -27,6 +27,7 @@
 #define _DMUB_PSR_H_
 
 #include "os_types.h"
+#include "dc_link.h"
 
 struct dmub_psr {
 	struct dc_context *ctx;
@@ -44,4 +45,4 @@ struct dmub_psr *dmub_psr_create(struct dc_context *ctx);
 void dmub_psr_destroy(struct dmub_psr **dmub);
 
 
-#endif /* _DCE_DMUB_H_ */
+#endif /* _DMUB_PSR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index e7076b0d7afb..f453de10aa2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -84,7 +84,7 @@
 #include "dcn21_resource.h"
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
-#include "../dce/dmub_psr.h"
+#include "dce/dmub_psr.h"
 
 #define SOC_BOUNDING_BOX_VALID false
 #define DC_LOGGER_INIT(logger)
@@ -995,6 +995,9 @@ static void dcn21_resource_destruct(struct dcn21_resource_pool *pool)
 	if (pool->base.dmcu != NULL)
 		dce_dmcu_destroy(&pool->base.dmcu);
 
+	if (pool->base.psr != NULL)
+		dmub_psr_destroy(&pool->base.psr);
+
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
 
@@ -1843,9 +1846,15 @@ static bool dcn21_resource_construct(
 		goto create_fail;
 	}
 
-	// Leave as NULL to not affect current dmcu psr programming sequence
-	// Will be uncommented when functionality is confirmed to be working
-	pool->base.psr = NULL;
+	if (dc->debug.psr_on_dmub) {
+		pool->base.psr = dmub_psr_create(ctx);
+
+		if (pool->base.psr == NULL) {
+			dm_error("DC: failed to create psr obj!\n");
+			BREAK_TO_DEBUGGER();
+			goto create_fail;
+		}
+	}
 
 	pool->base.abm = dce_abm_create(ctx,
 			&abm_regs,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
index e13685917dab..652d6fc061b6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
@@ -63,6 +63,7 @@ enum dmub_gpint_command {
 	DMUB_GPINT__INVALID_COMMAND = 0,
 	DMUB_GPINT__GET_FW_VERSION = 1,
 	DMUB_GPINT__STOP_FW = 2,
+	DMUB_GPINT__GET_PSR_STATE = 7,
 };
 
 /**
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
