Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AF9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B216137D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6B216137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5BD6EA0B;
	Mon,  4 Oct 2021 14:45:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B0B6EA0B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiZ2L4sELMio9vQR3TPC/xuN/hrQxzRTdK4Q4+NNAjiUwiBr/WS6KwGnNEPX7zC/zgPjmUNvDDxZhfWLrG51UDQHzOruXL5sQ98c7Op9FFN0i10pYJy/Mjtgc3SP1xOEcoSA767i8CgLu2e/FpbxxzIb02tYfpPAIH7cowyVSnfizdujzZE1DVEfwjdcNdSpB77Km0l5lOzY2GBWrll2PdtDCQvR5uHpNS5X7PyHt0PepJCi3NhGbENtHNLWsJvDjSmKIfMliZajad4vmxvPHOJ/eJAB51X6eleYLMXTFwAT0Jcruv/cPTw7iSW64MA6IHioKJ0Ss6DdI0e2ST75aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0427d6XLZpmb1d3q0LI4OdYc1davqsVT8GwaZ9MrYY=;
 b=cBF/B4NHv72/K0T6qBIMKHYjQJclfQaaEbAs/ZKTefUamWciV8TMqyi24aJsOLi8R+WAmZeAzC0rviBjDBZv8cbsB5GdTvEXGitvq1nQIlo8fWF74dPfKrUh7R6yJ/Rr7CRf8bF8DFMxOM3iYGKBHADTOVwS2Xum1SsFrA2OF3ReIY1p6TYYhLUhEkbXl9oaPT/EFaZSZyGx4IA+FMubW19OWtHh/4ShNoczy4U3oNfuYwuv6HaAoEltNDvs9wPbYw1U33nm8y2oL6YD2/0D4VL1ZJN77hazp+o+PoExeMG+NtMHwmrs9WptmxgFTPQRvQv3fOhbGI9elf+My+2ybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0427d6XLZpmb1d3q0LI4OdYc1davqsVT8GwaZ9MrYY=;
 b=YUv0rX9lWflSfQB/NXkyxmEPA+HY9QyAcM3RDFMxpT0UL1wIvUsndn3kAqneGXfcCntStNHWFGZ3/h1t/f3IUVueAu0OdZ/u1CDMhKiSpUDRMfs2sbUPP36X/O7OOXG+toyi+n5iwBZmlLsVumGWsdDZVXfxXaESljBZet25Bio=
Received: from MWHPR17CA0060.namprd17.prod.outlook.com (2603:10b6:300:93::22)
 by CY4PR12MB1765.namprd12.prod.outlook.com (2603:10b6:903:120::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Mon, 4 Oct
 2021 14:45:06 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::2) by MWHPR17CA0060.outlook.office365.com
 (2603:10b6:300:93::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Mon, 4 Oct 2021 14:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:45:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:45:01 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:44:48 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jude Shih
 <shenshih@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, "Wayne
 Lin" <Wayne.Lin@amd.com>
Subject: [PATCH 17/23] drm/amd/display: Support for SET_CONFIG processing with
 DMUB
Date: Mon, 4 Oct 2021 22:40:44 +0800
Message-ID: <20211004144050.3425351-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5541d48e-e2c3-402f-99a2-08d987458e51
X-MS-TrafficTypeDiagnostic: CY4PR12MB1765:
X-Microsoft-Antispam-PRVS: <CY4PR12MB176553FB28817B96A828B245FCAE9@CY4PR12MB1765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfJYPyfmGyKhXZMo083Z0PhyilHdeuvdKq/nqZeYfIHD/FeIO1xr5QHOILZ76qgbkJpnBON69lU9FKP22r9UqgfEN7V+GxyX3e+o08tNsrqtKOo4wcdIqjE4SYhXCXFpwwYdGuF5W20wkCnsOGsIFvmRiaH2OXY0QkqfLz3tQGD6Z9QQSzo9YSIuZMI8/+uoN1HFauMOxLLMxVHo3o3p0Qfzb/ndlclzMAuf8Mygseu/hIJZUwXTMyYQKZeGcY96+3wSQdFbJx8RbmLguFoLaxJfcbRF8JHEOICYDgIeUz/v+Xq2e43bCoyBSfGRrChWObml4j1RReOyAiEbBxGkApvATj9QmEyzVVRcc+tqD4TPLA7fCTKUoGb3Sbisq4rmBgDwuDol0JE8zQqegls1TY59iQ54IlK0FWNaN2HC5uhI8x38fpFek2NSH/sbaGetrNyGHyu19TX1X+3B5EMGAfcLyq3mGUhVnwVyDBHxwpJNRJLCNZq27qT26UvIx4hOwdJnaH+hIZ1X13lT0l49+MmnkXBuTlDLHurTsgGXiffmm2iv0lArjpqMEZYpdYhRk9OCvcH8GYHlJ7yUwBw2gPKgA3xj++zhEjBOH+3pxQQ2YVmeKfXwffUVHWYY+mBO44CZLaKhdpmRwRPLGQHDOO/i521c2L3csidTWO8EViMz3rLxjr17bznem/PsrW/tW+veTmnMSCyrxcMy7DeIhQyL3YQ3LSAyWkVdFLqczYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(356005)(336012)(83380400001)(7696005)(70586007)(36756003)(26005)(426003)(2906002)(8676002)(70206006)(4326008)(316002)(2616005)(81166007)(186003)(6916009)(47076005)(6666004)(86362001)(54906003)(1076003)(5660300002)(508600001)(36860700001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:45:05.7882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5541d48e-e2c3-402f-99a2-08d987458e51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1765
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

From: Jude Shih <shenshih@amd.com>

[Why]
To process SET_CONFIG transactions with DMUB using inbox1 and
outbox1 mail boxes.

[How]
1) DMUB posts SET_CONFIG reply as an Outbox1 message of type
   DMUB_OUT_CMD__SET_CONFIG_REPLY.
2) The dmub async to sync mechanism for AUX is modified to accommodate
   SET_CONFIG commands for both command issue and reply code paths.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Jude Shih <shenshih@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 73 +++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 12 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 17 ++++-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  6 +-
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  6 ++
 5 files changed, 94 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3c7a8f869b40..41692ae30822 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11333,29 +11333,74 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 	return value;
 }
 
-int amdgpu_dm_process_dmub_aux_transfer_sync(struct dc_context *ctx, unsigned int linkIndex,
-				struct aux_payload *payload, enum aux_return_code_type *operation_result)
+int amdgpu_dm_set_dmub_async_sync_status(bool is_cmd_aux, struct dc_context *ctx, uint8_t status_type,
+	uint32_t *operation_result)
+{
+	struct amdgpu_device *adev = ctx->driver_context;
+	int return_status = -1;
+	struct dmub_notification *p_notify = adev->dm.dmub_notify;
+
+	if (is_cmd_aux) {
+		if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS) {
+			return_status = p_notify->aux_reply.length;
+			*operation_result = p_notify->result;
+		} else if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT) {
+			*operation_result = AUX_RET_ERROR_TIMEOUT;
+		} else if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_FAIL) {
+			*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
+		} else {
+			*operation_result = AUX_RET_ERROR_UNKNOWN;
+		}
+	} else {
+		if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS) {
+			return_status = 0;
+			*operation_result = p_notify->sc_status;
+		} else {
+			*operation_result = SET_CONFIG_UNKNOWN_ERROR;
+		}
+	}
+
+	return return_status;
+}
+
+int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux, struct dc_context *ctx, unsigned int link_index,
+						void *cmd_payload, void *operation_result)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 	int ret = 0;
 
-	dc_process_dmub_aux_transfer_async(ctx->dc, linkIndex, payload);
+	if (is_cmd_aux) {
+		dc_process_dmub_aux_transfer_async(ctx->dc,
+			link_index, (struct aux_payload *)cmd_payload);
+	} else if (dc_process_dmub_set_config_async(ctx->dc, link_index,
+					(struct set_config_cmd_payload *)cmd_payload,
+					adev->dm.dmub_notify)) {
+		return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux,
+					ctx, DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS,
+					(uint32_t *)operation_result);
+	}
+
 	ret = wait_for_completion_interruptible_timeout(&adev->dm.dmub_aux_transfer_done, 10*HZ);
 	if (ret == 0) {
-		*operation_result = AUX_RET_ERROR_TIMEOUT;
-		return -1;
+		return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux,
+				ctx, DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT,
+				(uint32_t *)operation_result);
 	}
-	*operation_result = (enum aux_return_code_type)adev->dm.dmub_notify->result;
 
-	if (adev->dm.dmub_notify->result == AUX_RET_SUCCESS) {
-		(*payload->reply) = adev->dm.dmub_notify->aux_reply.command;
+	if (is_cmd_aux) {
+		if (adev->dm.dmub_notify->result == AUX_RET_SUCCESS) {
+			struct aux_payload *payload = (struct aux_payload *)cmd_payload;
 
-		// For read case, Copy data to payload
-		if (!payload->write && adev->dm.dmub_notify->aux_reply.length &&
-		(*payload->reply == AUX_TRANSACTION_REPLY_AUX_ACK))
-			memcpy(payload->data, adev->dm.dmub_notify->aux_reply.data,
-			adev->dm.dmub_notify->aux_reply.length);
+			payload->reply[0] = adev->dm.dmub_notify->aux_reply.command;
+			if (!payload->write && adev->dm.dmub_notify->aux_reply.length &&
+			    payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK) {
+				memcpy(payload->data, adev->dm.dmub_notify->aux_reply.data,
+				       adev->dm.dmub_notify->aux_reply.length);
+			}
+		}
 	}
 
-	return adev->dm.dmub_notify->aux_reply.length;
+	return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux,
+			ctx, DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS,
+			(uint32_t *)operation_result);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a85b09986aab..37e61a88d49e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -49,6 +49,13 @@
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
 #define AMDGPU_DMUB_NOTIFICATION_MAX 5
+
+/**
+ * DMUB Async to Sync Mechanism Status
+ **/
+#define DMUB_ASYNC_TO_SYNC_ACCESS_FAIL 1
+#define DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT 2
+#define DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS 3
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
@@ -721,6 +728,7 @@ void amdgpu_dm_update_connector_after_detect(
 
 extern const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs;
 
-int amdgpu_dm_process_dmub_aux_transfer_sync(struct dc_context *ctx, unsigned int linkIndex,
-					struct aux_payload *payload, enum aux_return_code_type *operation_result);
+int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux,
+					struct dc_context *ctx, unsigned int link_index,
+					void *payload, void *operation_result);
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 1aa69dd8e02f..ff0f91c93ba4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -683,8 +683,21 @@ int dm_helper_dmub_aux_transfer_sync(
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
-	return amdgpu_dm_process_dmub_aux_transfer_sync(ctx, link->link_index, payload, operation_result);
+	return amdgpu_dm_process_dmub_aux_transfer_sync(true, ctx,
+			link->link_index, (void *)payload,
+			(void *)operation_result);
 }
+
+int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
+		const struct dc_link *link,
+		struct set_config_cmd_payload *payload,
+		enum set_config_status *operation_result)
+{
+	return amdgpu_dm_process_dmub_aux_transfer_sync(false, ctx,
+			link->link_index, (void *)payload,
+			(void *)operation_result);
+}
+
 void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
 {
 	/* TODO: something */
@@ -799,4 +812,4 @@ void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable)
 {
 	/* TODO: add peridic detection implementation */
 }
-#endif
\ No newline at end of file
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index dd6c473be072..b0f1cd7268c8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -659,10 +659,12 @@ int dc_link_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
-	if (dc_enable_dmub_notifications(ddc->ctx->dc))
+	if (ddc->ctx->dc->debug.enable_dmub_aux_for_legacy_ddc ||
+	    !ddc->ddc_pin) {
 		return dce_aux_transfer_dmub_raw(ddc, payload, operation_result);
-	else
+	} else {
 		return dce_aux_transfer_raw(ddc, payload, operation_result);
+	}
 }
 
 /* dc_link_aux_transfer_with_retries() - Attempt to submit an
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index fb0d8b8a840a..7407c755a73e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -128,6 +128,12 @@ static enum dc_status core_link_send_set_config(struct dc_link *link,
 	payload.msg_type = msg_type;
 	payload.msg_data = msg_data;
 
+	if (!link->ddc->ddc_pin && !link->aux_access_disabled &&
+	    (dm_helpers_dmub_set_config_sync(link->ctx, link,
+					     &payload, &set_config_result) == -1)) {
+		return DC_ERROR_UNEXPECTED;
+	}
+
 	/* set_config should return ACK if successful */
 	return (set_config_result == SET_CONFIG_ACK_RECEIVED) ? DC_OK : DC_ERROR_UNEXPECTED;
 }
-- 
2.25.1

