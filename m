Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1252C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE0E6145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE0E6145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D136D6ED82;
	Thu, 29 Apr 2021 07:54:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585786ED82
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APjwRJCZs8CmLwMtoI7P39d/NzFtSMSwUO4THE0Hb/bKEn7/Bx9yNeHc0FhhfiCt1djgvnGypw619JdNg5fRzQ/5A3UAoxiWOorHVcdy1mkxQ6+OLPmraDv0U4M9pGcU5tQAmK9n7gltfHWAa/W5vnzQAyR1Pfm67PYfKJF1SrGPXrodP8oCR6mJenuOze0mjq5vd6s3YC2pu3fNvQiRcDMfdlZ+zuArKCRB7DfchGlx67Zw0/MEyia6khKqces1LMiTXOAEURW9gg1NILGc9ZZvjVnXXR3UPsxh5H808wqNBNluZB+CAYZ/5Y7VuZmFnxM93W+xZdSB3zxw021UJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7WIm9lKqmZksWepeH6G4DIwh7yIiIzdrYJ+lk2Kq5w=;
 b=RAHvZst6z0Uh+9Sgd6+yoijbfOWQw63hGybA4sSqHwswgLl1gXozQR4qP7bDFFZHiQv+BY4GMSZ2z2L95guUWoDlWegBj8/F8sD58z4ukDh6y3IbA+YNJbyZ38RCo/P1JGSdj8SGVlR92Y5hnpAwKGQNdfgnVGtBLtm92leCzd5857PGevdhUpeDKC6J0prOK3x2SCd8bEh41DhBFCe+WdaQYpGHFiwJ7axFqOfdrmde78OXG9C8/W0kq2hJCCSjvRDMpiPWlKE17bS+kuFWTPhYai3k4udyLPZvQX4Ma03lKm9g11Zl7jrIq4IGHK8kUV/K3F+dY9NXQOLc+Z1GyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7WIm9lKqmZksWepeH6G4DIwh7yIiIzdrYJ+lk2Kq5w=;
 b=lehzf6U7i4bVLYuL/45i0vtUABL19uZUM71TX8u2VMAIIwS9Hqo2wMqbeasJJPCbgGQgSopW+nV7ZmDpwDpW16Qz4t5gUnjLArzEo27VWVOHLZsMvH0PiezJMvNxJQ6bg9+nwsuU9w+dxlujaGzHXjJ81ocMHqPSYrD4mh4WtKc=
Received: from DS7PR03CA0290.namprd03.prod.outlook.com (2603:10b6:5:3ad::25)
 by BN6PR1201MB0177.namprd12.prod.outlook.com (2603:10b6:405:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 07:54:29 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::25) by DS7PR03CA0290.outlook.office365.com
 (2603:10b6:5:3ad::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 07:54:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:28 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:25 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: Support for DMUB AUX
Date: Thu, 29 Apr 2021 15:51:58 +0800
Message-ID: <20210429075206.15974-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8ec570f-e1ec-4847-0ca3-08d90ae40483
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0177:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB017720F21A103023D79B2016FC5F9@BN6PR1201MB0177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+EWtepkwDDAvKBEkcjtWN4a8jXn117IHHYkPGJUGVAOszmyGBtYlQgEPUZ60lR7C9RKxzYtGBa2e1edyFMUsFRaojkpinL1Qt8E3nue46Dxb1oAQ5YGRNARvFeFSHkLcZfuBPu5NKbZT4Sql43I5o+9tpK1vqOogXGZsi5yNAh+0moPgYPGQCb+B2I1dhEWmEOFXkfB6VUu+QvFyWyqdoQI9Tv5wMdyzo4AFqIRJtg5SLvPsgbHQ6kNcXRWayv3RxiTLoWqhEVEXyOEmyOOeQ5Z/CjP2htEwIjfV0tPCFZmthXUPbKPJB3sXZCEWysKb5G5WtILRbkeRpkb3J71ztzXbjZsmlBZvu1h5H+Z2D5YkZl62pfQCV0WbVMF6H8k/jejefFHLbYIYsXxYRCdoEJdk+XDKPHrOkxAi/N/kd8SeF6LQpnKqDd6tnER0Dm1fMryajmspcPpS2WD6+C9sqhhcc7UUe2/IaF+h2A74s2ktuEG6xA8VVe3GiyKNhFDBqqATqVUY9/pGS/lXcN3MFV40Tx71FUndUnovLW+G/j5VHdip9oXIyV/m0jPf/eYqTVkNaNmS2PQ398orFf866fAp2ICbxcy0K5dl/5TzUgjDUM/J7pr0AzeA3oWkupACRkCFdlEbBZ3d0VB+OUD86qZLEK7Oj6MvkAPYN11s9hF08zZUrTJUHXy6d3cGbcRbNw2k31k2XNpa2HnBTC6AA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(46966006)(7696005)(6666004)(1076003)(36756003)(86362001)(478600001)(47076005)(83380400001)(2906002)(316002)(70206006)(8676002)(26005)(186003)(5660300002)(426003)(81166007)(82310400003)(70586007)(54906003)(6916009)(2616005)(82740400003)(8936002)(336012)(36860700001)(4326008)(356005)(30864003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:29.3194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ec570f-e1ec-4847-0ca3-08d90ae40483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0177
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jude Shih <shenshih@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jude Shih <shenshih@amd.com>

[WHY]
To process AUX transactions with DMUB using inbox1 and outbox1 mail boxes.

[How]
1) Added inbox1 command DMUB_CMD__DP_AUX_ACCESS to issue AUX commands
   to DMUB in dc_process_dmub_aux_transfer_async(). DMUB processes AUX cmd
   with DCN and sends reply back in an outbox1 message triggering an
   outbox1 interrupt to driver.
2) In existing driver implementation, AUX commands are processed
   synchronously by configuring DCN reg. But in DMUB AUX, driver sends an
   inbox1 message and waits for a conditional variable (CV) which will be
   signaled by outbox1 ISR.
3) DM will retrieve Outbox1 message and send back reply to upper layer
   and complete the AUX command

Signed-off-by: Jude Shih <shenshih@amd.com>
Reviewed-by: Hanghong Ma <Hanghong.Ma@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 193 +++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  11 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  13 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  27 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  19 ++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |   3 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   9 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  18 +-
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   2 +-
 13 files changed, 240 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e24f92e87295..9dbb9c29c059 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -35,6 +35,7 @@
 #include "dc/inc/hw/abm.h"
 #include "dc/dc_dmub_srv.h"
 #include "dc/dc_edid_parser.h"
+#include "dc/dc_stat.h"
 #include "amdgpu_dm_trace.h"
 
 #include "vid.h"
@@ -59,6 +60,7 @@
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
+#include "i2caux_interface.h"
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -620,6 +622,58 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 #endif
 #endif
 
+/**
+ * dm_dmub_outbox1_low_irq() - Handles Outbox interrupt
+ * @interrupt_params: used for determining the Outbox instance
+ *
+ * Handles the Outbox Interrupt
+ * event handler.
+ */
+#define DMUB_TRACE_MAX_READ 64
+static void dm_dmub_outbox1_low_irq(void *interrupt_params)
+{
+	struct dmub_notification notify;
+	struct common_irq_params *irq_params = interrupt_params;
+	struct amdgpu_device *adev = irq_params->adev;
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct dmcub_trace_buf_entry entry = { 0 };
+	uint32_t count = 0;
+
+	if (dc_enable_dmub_notifications(adev->dm.dc)) {
+		if (irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
+			do {
+				dc_stat_get_dmub_notification(adev->dm.dc, &notify);
+			} while (notify.pending_notification);
+
+			if (adev->dm.dmub_notify)
+				memcpy(adev->dm.dmub_notify, &notify, sizeof(struct dmub_notification));
+			if (notify.type == DMUB_NOTIFICATION_AUX_REPLY)
+				complete(&adev->dm.dmub_aux_transfer_done);
+			// TODO : HPD Implementation
+
+		} else {
+			DRM_ERROR("DM: Failed to receive correct outbox IRQ !");
+		}
+	}
+
+
+	do {
+		if (dc_dmub_srv_get_dmub_outbox0_msg(dm->dc, &entry)) {
+			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
+							entry.param0, entry.param1);
+
+			DRM_DEBUG_DRIVER("trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
+				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
+		} else
+			break;
+
+		count++;
+
+	} while (count <= DMUB_TRACE_MAX_READ);
+
+	ASSERT(count <= DMUB_TRACE_MAX_READ);
+}
+
 static int dm_set_clockgating_state(void *handle,
 		  enum amd_clockgating_state state)
 {
@@ -938,32 +992,6 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 }
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-#define DMUB_TRACE_MAX_READ 64
-static void dm_dmub_trace_high_irq(void *interrupt_params)
-{
-	struct common_irq_params *irq_params = interrupt_params;
-	struct amdgpu_device *adev = irq_params->adev;
-	struct amdgpu_display_manager *dm = &adev->dm;
-	struct dmcub_trace_buf_entry entry = { 0 };
-	uint32_t count = 0;
-
-	do {
-		if (dc_dmub_srv_get_dmub_outbox0_msg(dm->dc, &entry)) {
-			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
-							entry.param0, entry.param1);
-
-			DRM_DEBUG_DRIVER("trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
-				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
-		} else
-			break;
-
-		count++;
-
-	} while (count <= DMUB_TRACE_MAX_READ);
-
-	ASSERT(count <= DMUB_TRACE_MAX_READ);
-}
-
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
 {
 	uint64_t pt_base;
@@ -1221,6 +1249,16 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	adev->dm.crc_rd_wrk = amdgpu_dm_crtc_secure_display_create_work();
 #endif
+	if (dc_enable_dmub_notifications(adev->dm.dc)) {
+		init_completion(&adev->dm.dmub_aux_transfer_done);
+		adev->dm.dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_KERNEL);
+		if (!adev->dm.dmub_notify) {
+			DRM_INFO("amdgpu: fail to allocate adev->dm.dmub_notify");
+			goto error;
+		}
+		amdgpu_dm_outbox_init(adev);
+	}
+
 	if (amdgpu_dm_initialize_drm_device(adev)) {
 		DRM_ERROR(
 		"amdgpu: failed to initialize sw for display support.\n");
@@ -1294,6 +1332,11 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.dc->ctx->dmub_srv = NULL;
 	}
 
+	if (dc_enable_dmub_notifications(adev->dm.dc)) {
+		kfree(adev->dm.dmub_notify);
+		adev->dm.dmub_notify = NULL;
+	}
+
 	if (adev->dm.dmub_bo)
 		amdgpu_bo_free_kernel(&adev->dm.dmub_bo,
 				      &adev->dm.dmub_bo_gpu_addr,
@@ -3154,38 +3197,51 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 
 	}
 
-	if (dc->ctx->dmub_srv) {
-		i = DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT;
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->dmub_trace_irq);
+	/* HPD */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DC_HPD1_INT,
+			&adev->hpd_irq);
+	if (r) {
+		DRM_ERROR("Failed to add hpd irq id!\n");
+		return r;
+	}
 
-		if (r) {
-			DRM_ERROR("Failed to add dmub trace irq id!\n");
-			return r;
-		}
+	register_hpd_handlers(adev);
 
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+	return 0;
+}
+/* Register Outbox IRQ sources and initialize IRQ callbacks */
+static int register_outbox_irq_handlers(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	struct common_irq_params *c_irq_params;
+	struct dc_interrupt_params int_params = {0};
+	int r, i;
+
+	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
+	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
+
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT,
+			&adev->dmub_outbox_irq);
+	if (r) {
+		DRM_ERROR("Failed to add outbox irq id!\n");
+		return r;
+	}
+
+	if (dc->ctx->dmub_srv) {
+		i = DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT;
+		int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
 		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
+		dc_interrupt_to_irq_source(dc, i, 0);
 
-		c_irq_params = &adev->dm.dmub_trace_params[0];
+		c_irq_params = &adev->dm.dmub_outbox_params[0];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
 		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_dmub_trace_high_irq, c_irq_params);
-	}
-
-	/* HPD */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DC_HPD1_INT,
-			&adev->hpd_irq);
-	if (r) {
-		DRM_ERROR("Failed to add hpd irq id!\n");
-		return r;
+				dm_dmub_outbox1_low_irq, c_irq_params);
 	}
 
-	register_hpd_handlers(adev);
-
 	return 0;
 }
 #endif
@@ -3664,6 +3720,22 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 
+	/* Use Outbox interrupt */
+	switch (adev->asic_type) {
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
+#endif
+	case CHIP_RENOIR:
+		if (register_outbox_irq_handlers(dm->adev)) {
+			DRM_ERROR("DM: Failed to initialize IRQ\n");
+			goto fail;
+		}
+		break;
+	default:
+		DRM_DEBUG_KMS("Unsupported ASIC type for outbox: 0x%X\n", adev->asic_type);
+	}
+
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
@@ -10743,3 +10815,30 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 
 	return value;
 }
+
+int amdgpu_dm_process_dmub_aux_transfer_sync(struct dc_context *ctx, unsigned int linkIndex,
+				struct aux_payload *payload, enum aux_return_code_type *operation_result)
+{
+	struct amdgpu_device *adev = ctx->driver_context;
+	int ret = 0;
+
+	dc_process_dmub_aux_transfer_async(ctx->dc, linkIndex, payload);
+	ret = wait_for_completion_interruptible_timeout(&adev->dm.dmub_aux_transfer_done, 10*HZ);
+	if (ret == 0) {
+		*operation_result = AUX_RET_ERROR_TIMEOUT;
+		return -1;
+	}
+	*operation_result = (enum aux_return_code_type)adev->dm.dmub_notify->result;
+
+	if (adev->dm.dmub_notify->result == AUX_RET_SUCCESS) {
+		(*payload->reply) = adev->dm.dmub_notify->aux_reply.command;
+
+		// For read case, Copy data to payload
+		if (!payload->write && adev->dm.dmub_notify->aux_reply.length &&
+		(*payload->reply == AUX_TRANSACTION_REPLY_AUX_ACK))
+			memcpy(payload->data, adev->dm.dmub_notify->aux_reply.data,
+			adev->dm.dmub_notify->aux_reply.length);
+	}
+
+	return adev->dm.dmub_notify->aux_reply.length;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a8966685b708..d9ece7210947 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -55,6 +55,8 @@
 #include "irq_types.h"
 #include "signal_types.h"
 #include "amdgpu_dm_crc.h"
+struct aux_payload;
+enum aux_return_code_type;
 
 /* Forward declarations */
 struct amdgpu_device;
@@ -63,6 +65,7 @@ struct dc;
 struct amdgpu_bo;
 struct dmub_srv;
 struct dc_plane_state;
+struct dmub_notification;
 
 struct common_irq_params {
 	struct amdgpu_device *adev;
@@ -180,6 +183,8 @@ struct amdgpu_display_manager {
 	 */
 	struct dmub_srv *dmub_srv;
 
+	struct dmub_notification *dmub_notify;
+
 	/**
 	 * @dmub_fb_info:
 	 *
@@ -351,6 +356,9 @@ struct amdgpu_display_manager {
 	struct common_irq_params
 	dmub_trace_params[1];
 
+	struct common_irq_params
+	dmub_outbox_params[1];
+
 	spinlock_t irq_handler_list_table_lock;
 
 	struct backlight_device *backlight_dev;
@@ -423,6 +431,7 @@ struct amdgpu_display_manager {
 	 * DAL fb memory allocation list, for communication with SMU.
 	 */
 	struct list_head da_list;
+	struct completion dmub_aux_transfer_done;
 };
 
 enum dsc_clock_force_state {
@@ -606,4 +615,6 @@ void amdgpu_dm_update_connector_after_detect(
 
 extern const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs;
 
+int amdgpu_dm_process_dmub_aux_transfer_sync(struct dc_context *ctx, unsigned int linkIndex,
+					struct aux_payload *payload, enum aux_return_code_type *operation_result);
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index e8b325a828c1..90eacdac0ea0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -640,7 +640,14 @@ enum dc_edid_status dm_helpers_read_local_edid(
 
 	return edid_status;
 }
-
+int dm_helper_dmub_aux_transfer_sync(
+		struct dc_context *ctx,
+		const struct dc_link *link,
+		struct aux_payload *payload,
+		enum aux_return_code_type *operation_result)
+{
+	return amdgpu_dm_process_dmub_aux_transfer_sync(ctx, link->link_index, payload, operation_result);
+}
 void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
 {
 	/* TODO: something */
@@ -698,12 +705,12 @@ void dm_helpers_free_gpu_mem(
 	}
 }
 
-bool dm_helpers_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enable)
+bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enable)
 {
 	enum dc_irq_source irq_source;
 	bool ret;
 
-	irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX0;
+	irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX;
 
 	ret = dc_interrupt_set(ctx->dc, irq_source, enable);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index b3ed7e777720..40f617bbb86f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -769,6 +769,18 @@ static int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
 		__func__);
 }
 
+static int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int crtc_id,
+					enum amdgpu_interrupt_state state)
+{
+	enum dc_irq_source irq_source = DC_IRQ_SOURCE_DMCUB_OUTBOX;
+	bool st = (state == AMDGPU_IRQ_STATE_ENABLE);
+
+	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	return 0;
+}
+
 static int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
 					   unsigned int crtc_id,
@@ -805,6 +817,11 @@ static const struct amdgpu_irq_src_funcs dm_vline0_irq_funcs = {
 	.process = amdgpu_dm_irq_handler,
 };
 
+static const struct amdgpu_irq_src_funcs dm_dmub_outbox_irq_funcs = {
+	.set = amdgpu_dm_set_dmub_outbox_irq_state,
+	.process = amdgpu_dm_irq_handler,
+};
+
 static const struct amdgpu_irq_src_funcs dm_vupdate_irq_funcs = {
 	.set = amdgpu_dm_set_vupdate_irq_state,
 	.process = amdgpu_dm_irq_handler,
@@ -827,13 +844,15 @@ static const struct amdgpu_irq_src_funcs dm_hpd_irq_funcs = {
 
 void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev)
 {
-
 	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
 	adev->crtc_irq.funcs = &dm_crtc_irq_funcs;
 
 	adev->vline0_irq.num_types = adev->mode_info.num_crtc;
 	adev->vline0_irq.funcs = &dm_vline0_irq_funcs;
 
+	adev->dmub_outbox_irq.num_types = 1;
+	adev->dmub_outbox_irq.funcs = &dm_dmub_outbox_irq_funcs;
+
 	adev->vupdate_irq.num_types = adev->mode_info.num_crtc;
 	adev->vupdate_irq.funcs = &dm_vupdate_irq_funcs;
 
@@ -846,6 +865,12 @@ void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev)
 	adev->hpd_irq.num_types = adev->mode_info.num_hpd;
 	adev->hpd_irq.funcs = &dm_hpd_irq_funcs;
 }
+void amdgpu_dm_outbox_init(struct amdgpu_device *adev)
+{
+	dc_interrupt_set(adev->dm.dc,
+		DC_IRQ_SOURCE_DMCUB_OUTBOX,
+		true);
+}
 
 /**
  * amdgpu_dm_hpd_init - hpd setup callback.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 82f8e761beca..2349238a626b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -82,6 +82,7 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
 
 void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev);
 
+void amdgpu_dm_outbox_init(struct amdgpu_device *adev);
 void amdgpu_dm_hpd_init(struct amdgpu_device *adev);
 void amdgpu_dm_hpd_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index f33847299bca..5cd89f7e7772 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -54,7 +54,7 @@ AMD_DC = $(addsuffix /Makefile, $(addprefix $(FULL_AMD_DISPLAY_PATH)/dc/,$(DC_LI
 
 include $(AMD_DC)
 
-DISPLAY_CORE = dc.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
+DISPLAY_CORE = dc.o  dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
 dc_surface.o dc_link_hwss.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o \
 dc_link_enc_cfg.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 64414c51312d..3bdd54e6248a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -658,7 +658,10 @@ int dc_link_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
-	return dce_aux_transfer_raw(ddc, payload, operation_result);
+	if (dc_enable_dmub_notifications(ddc->ctx->dc))
+		return dce_aux_transfer_dmub_raw(ddc, payload, operation_result);
+	else
+		return dce_aux_transfer_raw(ddc, payload, operation_result);
 }
 
 /* dc_link_aux_transfer_with_retries() - Attempt to submit an
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 6b72af2b3f4c..c5dc3a947020 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -180,5 +180,5 @@ bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_bu
 
 void dc_dmub_trace_event_control(struct dc *dc, bool enable)
 {
-	dm_helpers_dmub_outbox0_interrupt_control(dc->ctx, enable);
+	dm_helpers_dmub_outbox_interrupt_control(dc->ctx, enable);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 87d57e81de12..83d97dfe328f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -595,6 +595,25 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
 	return res;
 }
 
+int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
+		struct aux_payload *payload,
+		enum aux_return_code_type *operation_result)
+{
+	struct ddc *ddc_pin = ddc->ddc_pin;
+
+	if (ddc_pin != NULL) {
+		struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
+		/* XXX: Workaround to configure ddc channels for aux transactions */
+		if (!acquire(aux_engine, ddc_pin)) {
+			*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
+			return -1;
+		}
+		release_engine(aux_engine);
+	}
+
+	return dm_helper_dmub_aux_transfer_sync(ddc->ctx, ddc->link, payload, operation_result);
+}
+
 #define AUX_MAX_RETRIES 7
 #define AUX_MAX_DEFER_RETRIES 7
 #define AUX_MAX_I2C_DEFER_RETRIES 7
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
index 566b1bddd8cc..e69f1899fbf0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
@@ -304,6 +304,9 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *cmd,
 		enum aux_return_code_type *operation_result);
 
+int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
+		struct aux_payload *payload,
+		enum aux_return_code_type *operation_result);
 bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		struct aux_payload *cmd);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 7617fab9e1f9..304d50d16d01 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -34,6 +34,8 @@
 #include "dc.h"
 
 struct dp_mst_stream_allocation_table;
+struct aux_payload;
+enum aux_return_code_type;
 
 /*
  * Allocate memory accessible by the GPU
@@ -158,6 +160,11 @@ void dm_set_dcn_clocks(
 		struct dc_context *ctx,
 		struct dc_clocks *clks);
 
-bool dm_helpers_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enable);
+bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enable);
 
+int dm_helper_dmub_aux_transfer_sync(
+		struct dc_context *ctx,
+		const struct dc_link *link,
+		struct aux_payload *payload,
+		enum aux_return_code_type *operation_result);
 #endif /* __DM_HELPERS__ */
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 1a5be2792055..ed54e1c819be 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -58,8 +58,8 @@ enum dc_irq_source to_dal_irq_source_dcn21(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT:
-		return DC_IRQ_SOURCE_DMCUB_OUTBOX0;
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
 	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
 		return DC_IRQ_SOURCE_DC1_VLINE0;
 	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
@@ -187,7 +187,7 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.ack = NULL
 };
 
-static const struct irq_source_info_funcs dmub_trace_irq_info_funcs = {
+static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
@@ -301,11 +301,11 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vline0_irq_info_funcs\
 	}
 
-#define dmub_trace_int_entry()\
-	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
-		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
-			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
-		.funcs = &dmub_trace_irq_info_funcs\
+#define dmub_outbox_int_entry()\
+	[DC_IRQ_SOURCE_DMCUB_OUTBOX] = {\
+		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX1_READY_INT_ACK),\
+		.funcs = &dmub_outbox_irq_info_funcs\
 	}
 
 #define dummy_irq_entry() \
@@ -426,7 +426,7 @@ irq_source_info_dcn21[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	vline0_int_entry(4),
 	vline0_int_entry(5),
-	dmub_trace_int_entry(),
+	dmub_outbox_int_entry(),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn21 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index ae8f47ec0f8c..5f9346622301 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -150,7 +150,7 @@ enum dc_irq_source {
 	DC_IRQ_SOURCE_DC4_VLINE1,
 	DC_IRQ_SOURCE_DC5_VLINE1,
 	DC_IRQ_SOURCE_DC6_VLINE1,
-	DC_IRQ_DMCUB_OUTBOX1,
+	DC_IRQ_SOURCE_DMCUB_OUTBOX,
 	DC_IRQ_SOURCE_DMCUB_OUTBOX0,
 
 	DAL_IRQ_SOURCES_NUMBER
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
