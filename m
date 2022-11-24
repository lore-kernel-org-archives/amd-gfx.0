Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A36CC4321E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC3EE10E276;
	Thu, 24 Nov 2022 21:14:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45E510E265
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ia8FDK7bFJNn4UF3ZQ6Nh4GNg8zpH8TG1U8GeVrsimbL22gaemha+hZRHkBm8QEbYkU2rIr4fJSBHBY01ul6QsJAcKhEBUe/RvdSvLsEbO1oIrItQkiiXeelxUE2oBezrbpTr+s9k+4PheBx5DfELDCfjHF+XXU/2zx5FNbjEdubX86UquO/kIAVc/OruqeTXI7eM5LPcbaHOzIeCIGVP/DVoOg7xFW3GOlgBfnXSDMqvpNSC/VyngQYuLlpRz0X1Gl+xWcEIgUI7DhYMOR8QLBeMVeXwbe89aTp8DpRGjLvq6STPlqP091CwlUTe0J5+I9ITeMzQd6fc9JmmShKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fkyu5AV3McUbD99voeZ/qwkw+s7St1+KyyjyIFEPe0=;
 b=Jqk8+x9hwooTkQdWea6JzgKTwY3Ega/T7bP+JrPcF6W2wrmk9Y8LocgiyA8aQs8BXdXm02Vn8BLCKw592C1DjeYFP4eZQZYozo+Ajm+/a7onHWc76firvPF3Yn89StQjK/cC3A6ncYNOvdwNk0qMH22iU5VNJMM3xoy/mYe4zHH1oBzcuUyKnq9w+g/nXvK+dhWJihurlMglknSVqjA8OQ0DzvxYlbEnjz1XE9sRUPCXnE91IhNi/hbF6Jq43h87dr+R/HmIzuQX7zpNT5p2uJxc6ZJfILLx7eikwBf34tc3072yqvUqszSqxa+CzWkVDlqBcpYYHUY3a6elcBQlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fkyu5AV3McUbD99voeZ/qwkw+s7St1+KyyjyIFEPe0=;
 b=pVyJ8kewU4ZCx1S4JGE+uItol83RKeGF59Y3R0tp3XKTbZEDaXfoZ3UEONDOVVpp4SocuhKQBHS/rb5LtZkdvTmds33GCLBOP5AYjnNv1CdXs5YXF0He0XUItGWU6zs4MtHg4qp0w/ZqtOa3tIFCbylXubF0aFHJ1B/9U+HPAko=
Received: from BN9PR03CA0476.namprd03.prod.outlook.com (2603:10b6:408:139::31)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 21:14:02 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::e) by BN9PR03CA0476.outlook.office365.com
 (2603:10b6:408:139::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.19 via Frontend Transport; Thu, 24 Nov 2022 21:14:01 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:00 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: Fix race condition in DPIA AUX transfer
Date: Thu, 24 Nov 2022 16:13:37 -0500
Message-ID: <20221124211348.214136-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|DM4PR12MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7abae2-d653-440d-8bd7-08dace60cf84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3F5AvSGtqSFAYmteHdjh4MP3AlWqI8gFM1cAsPahBj/3Aje9IyJEC7wCpdIGzVHZfWBRkOtl1mIhugUocPCydEzeO74gb6qslFZ3wDRiUWgWn+Z5iVKBab2xaAGALZqoIg2HxoikEpGTOsuTqxN1f+AYkXN3FirqjQIbldORpMYorsNOvHvBnZOBw8avUEpZhbRongzAAWiiotIbTycDv6q766KRr47MGCIugR8xpEzTalwh09nRl6+GyISfxZZJxBo/hj3I38tZkWsu8yGdPb5z0Nu4sPrb2prNTrJlbfZTq6ZUFQplU6+squNgr5ZkqAAC3MCBhr/2mQKvptEF/YKbCGGaka6qCb6NIwQBZvm7+zH3GQmlwRR7S0J0ogehn/dwYWBaM5JqGauhrWJUk1UOtbVP6p/FCUSRmJxyYClO3go9IQTk8FN9PxRkWgk1k+TfW9W6zffWbVlZQEHl6s2HkkrNPvJA1riPdEa+0vOP75+B2X7EO7vppWigrv+BAHPgDjJ2AvLnoufLd0LLNJkvD/0YpoMHlyefQC5ZUcMhoVA+APaALa6hpojh8ARl2j2RMqKbhW97X3Q1DJoxMfv4052adJLQROqKG7JPVtbA/S4nuWFZMaR3dHGweCpT0k9NjUmbEW2aqUdI6An+P5M6qaJ9AnBP85yKNNsqnxIHR6iAuPkrVtlviRscldMqG6Uae9UAyCFG65s8A5cFHRqJ+Oewm+nYu1cctDlLLwk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(8676002)(8936002)(81166007)(4326008)(2906002)(356005)(82740400003)(36860700001)(83380400001)(426003)(1076003)(2616005)(30864003)(6916009)(47076005)(478600001)(70586007)(336012)(16526019)(54906003)(186003)(41300700001)(316002)(5660300002)(6666004)(40460700003)(40480700001)(70206006)(26005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:01.9786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7abae2-d653-440d-8bd7-08dace60cf84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
This fix was intended for improving on coding style but in the process
uncovers a race condition, which explains why we are getting incorrect
length in DPIA AUX replies. Due to the call path of DPIA AUX going from
DC back to DM layer then again into DC and the added complexities on top
of current DC AUX implementation, a proper fix to rely on current dc_lock
to address the race condition is difficult without a major overhual
on how DPIA AUX is implemented.

[How]
- Add a mutex dpia_aux_lock to protect DPIA AUX transfers
- Remove DMUB_ASYNC_TO_SYNC_ACCESS_* codes and rely solely on
  aux_return_code_type for error reporting and handling
- Separate SET_CONFIG from DPIA AUX transfer because they have quiet
  different processing logic
- Remove unnecessary type casting to and from void * type

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 151 +++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  10 +-
 3 files changed, 91 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4fe7971e3e58..da1be67831d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -147,14 +147,6 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 /* Number of bytes in PSP footer for firmware. */
 #define PSP_FOOTER_BYTES 0x100
 
-/*
- * DMUB Async to Sync Mechanism Status
- */
-#define DMUB_ASYNC_TO_SYNC_ACCESS_FAIL 1
-#define DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT 2
-#define DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS 3
-#define DMUB_ASYNC_TO_SYNC_ACCESS_INVALID 4
-
 /**
  * DOC: overview
  *
@@ -1442,6 +1434,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	memset(&init_params, 0, sizeof(init_params));
 #endif
 
+	mutex_init(&adev->dm.dpia_aux_lock);
 	mutex_init(&adev->dm.dc_lock);
 	mutex_init(&adev->dm.audio_lock);
 
@@ -1806,6 +1799,7 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 
 	mutex_destroy(&adev->dm.audio_lock);
 	mutex_destroy(&adev->dm.dc_lock);
+	mutex_destroy(&adev->dm.dpia_aux_lock);
 
 	return;
 }
@@ -10211,91 +10205,92 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 	return value;
 }
 
-static int amdgpu_dm_set_dmub_async_sync_status(bool is_cmd_aux,
-						struct dc_context *ctx,
-						uint8_t status_type,
-						uint32_t *operation_result)
+int amdgpu_dm_process_dmub_aux_transfer_sync(
+		struct dc_context *ctx,
+		unsigned int link_index,
+		struct aux_payload *payload,
+		enum aux_return_code_type *operation_result)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	int return_status = -1;
 	struct dmub_notification *p_notify = adev->dm.dmub_notify;
+	int ret = -1;
 
-	if (is_cmd_aux) {
-		if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS) {
-			return_status = p_notify->aux_reply.length;
-			*operation_result = p_notify->result;
-		} else if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT) {
-			*operation_result = AUX_RET_ERROR_TIMEOUT;
-		} else if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_FAIL) {
-			*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
-		} else if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_INVALID) {
-			*operation_result = AUX_RET_ERROR_INVALID_REPLY;
-		} else {
-			*operation_result = AUX_RET_ERROR_UNKNOWN;
+	mutex_lock(&adev->dm.dpia_aux_lock);
+	if (!dc_process_dmub_aux_transfer_async(ctx->dc, link_index, payload)) {
+		*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
+		goto out;
+ 	}
+
+	if (!wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, 10 * HZ)) {
+		DRM_ERROR("wait_for_completion_timeout timeout!");
+		*operation_result = AUX_RET_ERROR_TIMEOUT;
+		goto out;
+	}
+
+	if (p_notify->result != AUX_RET_SUCCESS) {
+		/*
+		 * Transient states before tunneling is enabled could
+		 * lead to this error. We can ignore this for now.
+		 */
+		if (p_notify->result != AUX_RET_ERROR_PROTOCOL_ERROR) {
+			DRM_WARN("DPIA AUX failed on 0x%x(%d), error %d\n",
+					payload->address, payload->length,
+					p_notify->result);
 		}
-	} else {
-		if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS) {
-			return_status = 0;
-			*operation_result = p_notify->sc_status;
-		} else {
-			*operation_result = SET_CONFIG_UNKNOWN_ERROR;
+		*operation_result = AUX_RET_ERROR_INVALID_REPLY;
+		goto out;
+ 	}
+
+
+	payload->reply[0] = adev->dm.dmub_notify->aux_reply.command;
+	if (!payload->write && p_notify->aux_reply.length &&
+			(payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK)) {
+
+		if (payload->length != p_notify->aux_reply.length) {
+			DRM_WARN("invalid read length %d from DPIA AUX 0x%x(%d)!\n",
+				p_notify->aux_reply.length,
+					payload->address, payload->length);
+			*operation_result = AUX_RET_ERROR_INVALID_REPLY;
+			goto out;
 		}
-	}
 
-	return return_status;
+		memcpy(payload->data, p_notify->aux_reply.data,
+				p_notify->aux_reply.length);
+ 	}
+
+	/* success */
+	ret = p_notify->aux_reply.length;
+	*operation_result = p_notify->result;
+out:
+	mutex_unlock(&adev->dm.dpia_aux_lock);
+	return ret;
 }
 
-int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux, struct dc_context *ctx,
-	unsigned int link_index, void *cmd_payload, void *operation_result)
+int amdgpu_dm_process_dmub_set_config_sync(
+		struct dc_context *ctx,
+		unsigned int link_index,
+		struct set_config_cmd_payload *payload,
+		enum set_config_status *operation_result)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	int ret = 0;
+	bool is_cmd_complete;
+	int ret;
 
-	if (is_cmd_aux) {
-		dc_process_dmub_aux_transfer_async(ctx->dc,
-			link_index, (struct aux_payload *)cmd_payload);
-	} else if (dc_process_dmub_set_config_async(ctx->dc, link_index,
-					(struct set_config_cmd_payload *)cmd_payload,
-					adev->dm.dmub_notify)) {
-		return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux,
-					ctx, DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS,
-					(uint32_t *)operation_result);
-	}
+	mutex_lock(&adev->dm.dpia_aux_lock);
+	is_cmd_complete = dc_process_dmub_set_config_async(ctx->dc,
+			link_index, payload, adev->dm.dmub_notify);
 
-	ret = wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, 10 * HZ);
-	if (ret == 0) {
+	if (is_cmd_complete || wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, 10 * HZ)) {
+		ret = 0;
+		*operation_result = adev->dm.dmub_notify->sc_status;
+	} else {
 		DRM_ERROR("wait_for_completion_timeout timeout!");
-		return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux,
-				ctx, DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT,
-				(uint32_t *)operation_result);
-	}
-
-	if (is_cmd_aux) {
-		if (adev->dm.dmub_notify->result == AUX_RET_SUCCESS) {
-			struct aux_payload *payload = (struct aux_payload *)cmd_payload;
-
-			payload->reply[0] = adev->dm.dmub_notify->aux_reply.command;
-			if (!payload->write && adev->dm.dmub_notify->aux_reply.length &&
-			    payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK) {
-
-				if (payload->length != adev->dm.dmub_notify->aux_reply.length) {
-					DRM_WARN("invalid read from DPIA AUX %x(%d) got length %d!\n",
-							payload->address, payload->length,
-							adev->dm.dmub_notify->aux_reply.length);
-					return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux, ctx,
-							DMUB_ASYNC_TO_SYNC_ACCESS_INVALID,
-							(uint32_t *)operation_result);
-				}
+		ret = -1;
+		*operation_result = SET_CONFIG_UNKNOWN_ERROR;
+ 	}
 
-				memcpy(payload->data, adev->dm.dmub_notify->aux_reply.data,
-				       adev->dm.dmub_notify->aux_reply.length);
-			}
-		}
-	}
-
-	return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux,
-			ctx, DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS,
-			(uint32_t *)operation_result);
+	mutex_unlock(&adev->dm.dpia_aux_lock);
+	return ret;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 83436ef3b26b..df3c25e32c65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -59,7 +59,9 @@
 #include "signal_types.h"
 #include "amdgpu_dm_crc.h"
 struct aux_payload;
+struct set_config_cmd_payload;
 enum aux_return_code_type;
+enum set_config_status;
 
 /* Forward declarations */
 struct amdgpu_device;
@@ -542,6 +544,13 @@ struct amdgpu_display_manager {
 	 * occurred on certain intel platform
 	 */
 	bool aux_hpd_discon_quirk;
+
+	/**
+	 * @dpia_aux_lock:
+	 *
+	 * Guards access to DPIA AUX
+	 */
+	struct mutex dpia_aux_lock;
 };
 
 enum dsc_clock_force_state {
@@ -785,9 +794,11 @@ void amdgpu_dm_update_connector_after_detect(
 
 extern const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs;
 
-int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux,
-					struct dc_context *ctx, unsigned int link_index,
-					void *payload, void *operation_result);
+int amdgpu_dm_process_dmub_aux_transfer_sync(struct dc_context *ctx, unsigned int link_index,
+					struct aux_payload *payload, enum aux_return_code_type *operation_result);
+
+int amdgpu_dm_process_dmub_set_config_sync(struct dc_context *ctx, unsigned int link_index,
+					struct set_config_cmd_payload *payload, enum set_config_status *operation_result);
 
 bool check_seamless_boot_capability(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index e47098fa5aac..ba9526d62902 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -817,9 +817,8 @@ int dm_helper_dmub_aux_transfer_sync(
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
-	return amdgpu_dm_process_dmub_aux_transfer_sync(true, ctx,
-			link->link_index, (void *)payload,
-			(void *)operation_result);
+	return amdgpu_dm_process_dmub_aux_transfer_sync(ctx,link->link_index, payload,
+			operation_result);
 }
 
 int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
@@ -827,9 +826,8 @@ int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 		struct set_config_cmd_payload *payload,
 		enum set_config_status *operation_result)
 {
-	return amdgpu_dm_process_dmub_aux_transfer_sync(false, ctx,
-			link->link_index, (void *)payload,
-			(void *)operation_result);
+	return amdgpu_dm_process_dmub_set_config_sync(ctx,link->link_index, payload,
+			operation_result);
 }
 
 void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
-- 
2.34.1

