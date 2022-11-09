Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1BBC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19B110E05E;
	Wed,  9 Nov 2022 06:14:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D90410E05E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc69W+uwypr4OdJCShXpCc0+hV4EySHjq6oGyHGLCoGfHGKij0hK9VmTqv7y1Fb3yQ9Ne2wvsH5haPV0gxeUjpPG97S/V3wfYciwtGJ3rgkKD/lxUufBku+Hp0n59VtiCqoIR+kTxb3EfDsszvT5WHmgC/5c1jvZE7OAei6GciJnEG2nswDiXvX1nd4d3lkbeq/wVNIDz0Q3ZuLTM4oqXMTH+KO2xla4E7cYeICIeC42UXQ4dCoY6lden1tVek/oTvlFgUGkv9U+fIw/HsUZhnNUQwgTj4MGKRKp2ukwPtbtQQ1PT1Uy4/uW/5KyVBhSll0dTHUhTgFAx/vPFXmSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jckE+WXD++CTF5WQ3MCkI869J8ka8gMtmqCyQmFhIzE=;
 b=jWDhFVRbLyPILeGniRHMa+Zf5QUp32h3QI9wDJ7dHtcxCIzh3tldHUs4x/yaL25SP4ZcEjrH+8s9V/fji1p3Lsaixeq8NgZDz4LdO/BhvGsWrgZN0hZcaGjDS4U8kiwGdf6jYw1DiFRgStiRBSRd+AGj6wKixvEyAFKWvR8nnh3nf4+hwwHUw3Jn0GK7KhDGy/Es4KeW9budiCrNkBBVHjwdydjyNGytXhQ7VL6Q/SAtqnxVSANrXRrkXsrqQ1IBowUdiVBaAU7zzTvQlGFEelaW4XHWhMOsUC6GjcoOcN0G8PfrxiXVPKgNrSV3JJgBGHO1wsHok3QgoTGh8PTZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jckE+WXD++CTF5WQ3MCkI869J8ka8gMtmqCyQmFhIzE=;
 b=QLrS79Km87pb1bI16XEXg5DuNV21E6ofp8dz4Z9JB0plgRHi/wVd8OuErwU0CDYwk5oBl1TRupzprlxGCzJ/KhOvrCSfzdPQHAsrwczohgVzCfVGqWvkMCQcrzbt5oiRmW3mTdogIIy3/BdxusDaDMA2eeXC6vQRt8quFz7itbg=
Received: from BN9P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::29)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:14:54 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::43) by BN9P222CA0024.outlook.office365.com
 (2603:10b6:408:10c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:14:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:14:53 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:14:43 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/29] drm/amd/display: Fix invalid DPIA AUX reply causing
 system hang
Date: Wed, 9 Nov 2022 14:12:53 +0800
Message-ID: <20221109061319.2870943-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|BL1PR12MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 8018f1dd-4199-4c29-3a69-08dac219b7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPg6XKw27bDj3an+EoDkkzg/gB31BAdQZYxN318mDFcPIMBgGszK8/StapeUVFYWOz5hA+6I66/f4waeARky2xTDiPIflhi7StpdLY7pZ/WMxlKOHqHMIzqQLtmthXYlimOMByzcsCXwmAQbt1xgCGO0l/WPPKCakcmde4heYesECw1RAgOEU5Ql5cdzcYCYKbmx72tLphv4Y1TywwJTr0GzZXEMIQDgpmiL9mV7vErdtKASts7DwJiXKeuDcQl8sD2TLASCkN7ynyJb+CqYu6rgTlqgGPoxKLmYZ9TG7Cjp/Y4HMrpHqX8WucFaX7ev/+bGwSyXpi/HoJAXVbr5e/spElPYxZDrWGr0Jl6tPCqkvbirfuqt8+dUvMInFpNKr7bbfCrKCUiZlYiV0mgnN0KDqNj/SQqsvViwJtyZQOaFof8nd8MYjYKRXtlJXwDXYHLcQkfB3bYz8Aczy0QTUYPzW1mD/zwlfBx/ueQIqSuR659ggvFzqdjWNFQvdh2Xi9XDY5/CdZrp1lRgZi8OGwF1u57ObW2j0Q+L25X9EXsEpaSzbaRNPJexW89nFW7Tx8X4JvFDkjyac0144/C1fjgQ4vqCdmm4HQjtJNx2jZ+b54Tj8NY+vJbKY7iiH9RPNNvG1TkdsZr5Tz5E1veTeUOgzDzizBthawF7+Jkt1w4xvb9ktR658oKjgLl0nKrAmXJGf1j9gm9OlFaejSbVQDldLML/Z0Ogx29ny6Qhl0TV4+QkIdkaX9iY60g15dW5bFd5VHfnonpV/O6UjAEe0ZeIc1Fh+IbGHwwt4zUDxfFhcTHFo3O+wQ7tPR6I45Ke
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(86362001)(70586007)(316002)(70206006)(8936002)(54906003)(6916009)(41300700001)(5660300002)(2616005)(36860700001)(2906002)(186003)(1076003)(478600001)(336012)(4326008)(26005)(82310400005)(40460700003)(36756003)(8676002)(7696005)(426003)(47076005)(83380400001)(82740400003)(356005)(6666004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:14:53.7855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8018f1dd-4199-4c29-3a69-08dac219b7bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>, stable@vger.kernel.org,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Some DPIA AUX replies have incorrect data length from original request.
This could lead to overwriting of destination buffer if reply length is
larger, which could cause invalid access to stack since many destination
buffers are declared as local variables.

[How]
Check for invalid length from DPIA AUX replies and trigger a retry if
reply length is not the same as original request. A DRM_WARN() dmesg log
is also produced.

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Cc: stable@vger.kernel.org #6.0.x
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4d90c5415d5c..e15913285250 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -144,6 +144,14 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 /* Number of bytes in PSP footer for firmware. */
 #define PSP_FOOTER_BYTES 0x100
 
+/*
+ * DMUB Async to Sync Mechanism Status
+ */
+#define DMUB_ASYNC_TO_SYNC_ACCESS_FAIL 1
+#define DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT 2
+#define DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS 3
+#define DMUB_ASYNC_TO_SYNC_ACCESS_INVALID 4
+
 /**
  * DOC: overview
  *
@@ -10215,6 +10223,8 @@ static int amdgpu_dm_set_dmub_async_sync_status(bool is_cmd_aux,
 			*operation_result = AUX_RET_ERROR_TIMEOUT;
 		} else if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_FAIL) {
 			*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
+		} else if (status_type == DMUB_ASYNC_TO_SYNC_ACCESS_INVALID) {
+			*operation_result = AUX_RET_ERROR_INVALID_REPLY;
 		} else {
 			*operation_result = AUX_RET_ERROR_UNKNOWN;
 		}
@@ -10262,6 +10272,16 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux, struct dc_context
 			payload->reply[0] = adev->dm.dmub_notify->aux_reply.command;
 			if (!payload->write && adev->dm.dmub_notify->aux_reply.length &&
 			    payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK) {
+
+				if (payload->length != adev->dm.dmub_notify->aux_reply.length) {
+					DRM_WARN("invalid read from DPIA AUX %x(%d) got length %d!\n",
+							payload->address, payload->length,
+							adev->dm.dmub_notify->aux_reply.length);
+					return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux, ctx,
+							DMUB_ASYNC_TO_SYNC_ACCESS_INVALID,
+							(uint32_t *)operation_result);
+				}
+
 				memcpy(payload->data, adev->dm.dmub_notify->aux_reply.data,
 				       adev->dm.dmub_notify->aux_reply.length);
 			}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b618b2586e7b..83436ef3b26b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -50,12 +50,6 @@
 
 #define AMDGPU_DMUB_NOTIFICATION_MAX 5
 
-/*
- * DMUB Async to Sync Mechanism Status
- */
-#define DMUB_ASYNC_TO_SYNC_ACCESS_FAIL 1
-#define DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT 2
-#define DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS 3
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
-- 
2.25.1

