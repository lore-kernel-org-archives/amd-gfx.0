Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30301C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F287561352
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F287561352
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09BF6F5AA;
	Tue,  5 Oct 2021 07:59:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1916F5AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY4jORDW3TgsZTWB8EKQT/KyPE7El5iFjnF0/9OGeEIv5RZx+UhPitRUyPLhZsHaFlgDdWpFdx/9icBxX9bHPcgz2Rc/+d6vIxDpWogz9mXx12Xmkxxf5TBCjQs1+GBAxhlEmv7k9hiTiS4qpFwS3k88AZwfV0/3FMqWqXHj3xkWyzuGu+0d2jyS7PVN+PPjGEBWcJzE/yFadEJl6k2nZLGz9Oh3Z9TFnI1p4GIe3dkpf4wGXdjUjiVfZd1NXGRUfV1ekT+OJauh18EX26VbuHeZ+wFQtpdck1AGHMAlKK6hzcUjXrVoG5uQ5nwnIDrPKl2m73m3zgaeAGKlgbsvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0427d6XLZpmb1d3q0LI4OdYc1davqsVT8GwaZ9MrYY=;
 b=bj9gnhDulH5Bls9SM/U8Ut6Ew7YtCwinc2L8hP0gjNO8yxsK2POSU7sJmyd8GmMwkK9ANEKt9wVNyvM4+ttFGXrvsblM7TcRG62mJDZj03lFK8SVLkBeZznpfdAtn0aBa/3u+7PotRyf/iqlQB0by7RW2eES0K3rnDnHidi7dAiCeVe5tZ25nYJhQ+VJrv9GncAyaButypYnCVNNMDrmQXkv1TLn21A7z0VNZRhLXPYoIMXt9zqShec5G6rweMGq2uBNR/vkFvxkEVyyD04LRp6nmsGw42laCvTj4+hXXuy2l/XK2zhuFTjrW5cqf3M3FZikCVBYkzYpg2ws5Ypa2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0427d6XLZpmb1d3q0LI4OdYc1davqsVT8GwaZ9MrYY=;
 b=LKDZa08XAXvXuKyIKEOEuXHEz0KRW9iDbIQUIMU33vkRqxIvwmsgjLNdR9wlMAhJswFjYIUHMneC1De6uRxP7bag1UiEN3nCIaFriCZQAdj8itvjB61iXMZn1XZYeD1tfXX+svpD8zCLnAki4Nru9tcN5ZoRKYAntgeZAWwrUn8=
Received: from BN0PR04CA0078.namprd04.prod.outlook.com (2603:10b6:408:ea::23)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Tue, 5 Oct
 2021 07:59:29 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a4) by BN0PR04CA0078.outlook.office365.com
 (2603:10b6:408:ea::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 07:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:59:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:59:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 00:59:26 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:59:14 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jude Shih
 <shenshih@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, "Wayne
 Lin" <Wayne.Lin@amd.com>
Subject: [PATCH v2 17/23] drm/amd/display: Support for SET_CONFIG processing
 with DMUB
Date: Tue, 5 Oct 2021 15:51:59 +0800
Message-ID: <20211005075205.3467938-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ce8b355-fc51-46ca-c792-08d987d60e3d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:
X-Microsoft-Antispam-PRVS: <DM6PR12MB370873EA41861774E1159E3EFCAF9@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IbnFYKOfFAOR3awhrwwXVan/zDFpGMl8zWkLgnIRrWag0cNuovzBILBSaVNwhgIkWojI+02hZKaIxulPuBqp4khGYRGmqbpgZGHeCro9Xapu35hAkTzVR5AGiPEe8UIxqO1WSjjwwiuxlx707KPye4simt5LPbQdJ8p5iwFvEl5nT9spgedQEgQnpmip1Ch8PESIg9pqWHND2yyVfP7VcH/M6JKoeYdRiicp96nzai4KfoEzgAxvJ6UO0SeKMPq1g0zgGDT50HTrFAlALcrW8HsWngP16R8rA5kCn+ZmOt9JfCYJ9weWFCZWLLClPKcYm8Rr0TLmUz2t6IQ6sUv4pAbdQ6tTt8EMowXe5HZmF3pz8ZVdrqNRDRYWCsYIDqTk/Pl4GKYN80+fJsMgkFGRHbrMV3QBu2niPrHUfvw/jyLwm7B7tTENAl0ZPKY+woLEsOmiG8PEmXIzVJbH0tiV4d1lb7sj0L9Tyr51soEz4JqYvJ4v4BCdwlmg0BN2UzI21NswuMUiUcpGS6VnNfl4zM9wNdnXlXVvILGaKwDgciZZKy7pSCw/D1joOoxZASJdW3fh7TuraxYgKN3cNlv7tLpw29b2ROoS12BAf+mNU0JdHKvYJ9XOlWgzH56/022S4rsJV0kLAx6acmKRK8f9xkSMnkWssUkNSfy5A1v8yUIhel+EgqSmI34u0Mvn60T9ycVMx/DIb3TKxHu1LwJ/izigLW2W3H5oHRqRR7W56w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(36756003)(7696005)(8936002)(5660300002)(356005)(54906003)(81166007)(508600001)(316002)(6916009)(2906002)(8676002)(82310400003)(86362001)(70586007)(336012)(186003)(1076003)(4326008)(83380400001)(47076005)(426003)(36860700001)(26005)(70206006)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:59:28.0886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce8b355-fc51-46ca-c792-08d987d60e3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
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

