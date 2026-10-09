Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F162CA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 06:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1368310FE85;
	Fri,  9 Oct 2026 06:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Eb5T5qr";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A60410FE66
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 06:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2Nh7OFe3ovutygzuvCG6Sst4I+sIBQ+eg6pnR/rNy1DzoCvk+M7Nxrv7wR5kH9SR861t2bay2vs0uIGUsiiguA4mORIQx9FWynhzXUPq9IQYCONoHKq1gOsddd8ekcPJ+L1j4iGt3jYNjczpkxede99bnPl1Z1P0y6wxeo5nIRE2Mqgb8vtmZJ4maJNt7cwtPJrQ26d1vLqIv2yF6g33zUtlvP3/+BawXtLbmRfX1WbFx/A9rGLhMMwp7aBscUVd2q7AHHv9QDUeiN/PZrhQfK6pVBK+gHZhRq6Ar5Vnanow5H7xdIJO0GlZavn6FETUhE6DOJy+qvJx9iPokMKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh2vPte5w2dusjKb2L9+NmeEpKAWeu5Jk9OIEk+f2k4=;
 b=X2o6WsM6xfVoA86NhbCIs1PmVoJEKTnEFnBPZyVUa0yUaIMFu+vvzgj1kgu2f/xj31ZvREP/oheJ2Z1o+nl50NVW5H2nyTzolAje6MTmEW/fbHB9huAVVuGfsZmCmuqtqTdOJmunRGiRRbwy00lQ2aaQyxr+5vFSmltn6HmQg+g8fE7RH78NcnqCSDRUXVPtgnX3pO9Epyr5y7Om1tyffMZIVpM1O1aYMPaQ95sHVK9txaOBD+Oc+BmrM1fVLlA95Mg19c0qjoiIPrwv8L6eNetQ+WrrnOZlpqPku3YI1brRDRtyamFIm/wdJv2KSEwbc8K4J9CQIRaDF62A/8MPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lh2vPte5w2dusjKb2L9+NmeEpKAWeu5Jk9OIEk+f2k4=;
 b=3Eb5T5qrbnz0CHaQWkl6mi78spuPtMOeV3FQG+zFEpa/ac1TNip6fHfZOwr24ADMTIe5ipEicx8PcI80E87adY35dfDVK4ledI3OmxRQxwC1b13P/N/yrfmWYoCsfWjTMYkBdEZPEc8K8B5hyfXGLLjTHIATkibputXQ2MgzosA=
Received: from YT4PR01CA0467.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d6::23)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 06:06:21 +0000
Received: from BN2PEPF0000A88E.namprd04.prod.outlook.com
 (2603:10b6:b01:d6:cafe::7e) by YT4PR01CA0467.outlook.office365.com
 (2603:10b6:b01:d6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 06:06:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88E.mail.protection.outlook.com (10.167.248.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 06:06:20 +0000
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 01:06:13 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, <Xiang.Liu@amd.com>, <Ce.Sun@amd.com>,
 <Gangliang.Xie@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review v2 1/1] drm/amd/ras: Support invoke ras command
Date: Fri, 9 Oct 2026 14:05:53 +0800
Message-ID: <20261009060553.62203-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88E:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: bef684da-1abb-4588-0a35-08df25cb70c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|6133799003|18002099003|3023799007|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: fJUUq7iquYXHeAV+kSGH48z0mGX5m068DvexKntHLYpwHgSZQx8gOTRZVYHFvnUyw/LFFnCyOSkmMlYQaSDMmFV4IVS/A7pwT1qyIAPjgJhO8qw+263XdioCI7JKruUoZb9u/nOKKO2VB3kdN4JsXaPRB8HCMW2dmTTapTDE1qqgGNmP1Q4Q3rq5aVVpKva5FyvGPAT7WBM+iHP7yXAaRjYPJwXaQo1L6bhWDI3gbbHDeUEwfglicAyW2qlnwG4oV+Adiz0Ek9TerBlsi09FhiXoIopzOkGykVgsK+HwoQa4JIcHyRDc836BM0tT3ZKhKd6M6SBCCwszN1Azj/zIDbtcI3CT5ehe3Uitynvo+WDUUzMLYlwhYwzgpRRA7nbCBaoyw3vmFd6EgoENPTCsn6yaqy5ryERe1FkVBP7/dWHCr+uoGfQxRv3j1nCeshJXpaF4Gtqv1FSRcPeLkLzIew4ip4aMR8Tg3rhM8Nwbc4FcqKTGuxOEJCkVYbzmC28jnynM5oP5klbjaSe4IiZR/6B+083sEmjsXewF0SyUaGjZerzeSpuhM1nwR3jI0AGfUegN31LYrbqUeFvqlrOwjoBI09glxZdzX9D8GxJ7On69AOJIyk1MPSlbVe1GUuUCqpjnNLBQtpwAKSvnjixNOJamXMaVkl5V6n4Oj+9UuDZ0tiWJH6X68nCjreSlBV4u/kOYQOtMheP06CzQ22Lt1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(6133799003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uYX0OgPS+zYLaijealG++yFbQlk1pn2IvO9dVIanI9p5RALgXBkTpzw3DusvKWlS2uC7dAbzAvcIicTJib7x/S8JpYooRTgW4t75533NDCdXcgVtUhLlqSHwTcf+GZBjX+kFBGzxc7GfY6G9uSVluYkOfdLVZ/V/Glg5KNDS0JU+UQgAwp2cf00hCLQu8WiPfmN16B25B3N26pHFcpWcOHPxuEQuGZtwGAy/weohTwCppp3eGO6oF9tXkAfoouAxM9olSOSf2gzpHdJHKGz3bsk1RUeRL5i/uXDznYqmC20QFi35O0Kuc/MsRTeYDQzRVHj+aogyUQvOaS+76Kkx+NOUMJTsgzHb4Y0NhRRNpA9HBXu5j11nZM9zIehc7v1Nl1GrKhWKLlfjyrQLtFEO2Fjm+aL0lliMjSm6ZPkGfUsbjjJU6POkswah+LUIkVfS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 06:06:20.9698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef684da-1abb-4588-0a35-08df25cb70c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
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

Use uniras core to invoke ras command.

Changed from v1:
	use common function send_ras_ta_runtime_cmd in ras_psp_invoke_ras_ta

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 17 +++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.c     | 40 +++++++++++++++++-----
 drivers/gpu/drm/amd/ras/core/ras_psp.h     |  3 ++
 drivers/gpu/drm/amd/ras/core/ta_if.h       |  1 +
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 8ae72c862d11..2d494ac57eb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_psp_ta.h"
+#include "amdgpu_ras_mgr.h"
 
 #if defined(CONFIG_DEBUG_FS)
 
@@ -330,6 +331,22 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 	if (IS_ERR(shared_buf))
 		return PTR_ERR(shared_buf);
 
+	if (ta_type == TA_TYPE_RAS && amdgpu_uniras_enabled(adev)) {
+		struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+		if (!ras_mgr || !ras_mgr->ras_core) {
+			ret = -EINVAL;
+			goto free_shared_buf;
+		}
+
+		ret = ras_psp_invoke_ras_ta(ras_mgr->ras_core, ta_id, cmd_id,
+					   shared_buf, shared_buf_len);
+		if (!ret && copy_to_user((char *)&buf[copy_pos], shared_buf, shared_buf_len))
+			ret = -EFAULT;
+
+		goto free_shared_buf;
+	}
+
 	set_ta_context_funcs(psp, ta_type, &context);
 
 	if (!context || !context->initialized) {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index ed53cd25d6bd..c3c6039bfe7a 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -426,7 +426,8 @@ static int __check_ras_ta_cmd_resp(struct ras_core_context *ras_core,
 }
 
 static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
-			enum ras_ta_cmd_id cmd_id, void *in, uint32_t in_size,
+			uint32_t session_id, enum ras_ta_cmd_id cmd_id,
+			void *in, uint32_t in_size,
 			void *out, uint32_t out_size)
 {
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
@@ -467,7 +468,7 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 	memcpy(&ras_cmd->ras_in_message, in, in_size);
 
 	invoke_cmd.ta_cmd_id = cmd_id;
-	invoke_cmd.session_id = ta_ctx->session_id;
+	invoke_cmd.session_id = session_id;
 
 	ret = send_psp_cmd(ras_core, GFX_CMD_ID_INVOKE_CMD,
 			&invoke_cmd, sizeof(invoke_cmd), &resp);
@@ -494,10 +495,15 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 		goto unlock;
 	}
 
-	if (!ras_cmd->ras_status && out && out_size)
+	/* Hand the TA output back regardless of status; ret carries the status. */
+	if (out && out_size)
 		memcpy(out, &ras_cmd->ras_out_message, out_size);
 
-	ret = __check_ras_ta_cmd_resp(ras_core, ras_cmd);
+	/* cmd from user space requires special handling for CHECK_ACA_BANK_ERROR_TYPES */
+	if (cmd_id == RAS_TA_CMD_ID__CHECK_ACA_BANK_ERROR_TYPES)
+		__check_ras_ta_cmd_resp(ras_core, ras_cmd);
+	else
+		ret = __check_ras_ta_cmd_resp(ras_core, ras_cmd);
 
 unlock:
 	mutex_unlock(&ta_ctx->ta_mutex);
@@ -536,7 +542,9 @@ static int trigger_ras_ta_error(struct ras_core_context *ras_core,
 	dev_mask &= RAS_TA_INST_MASK;
 	info->sub_block_index |= dev_mask;
 
-	return send_ras_ta_runtime_cmd(ras_core, RAS_TA_CMD_ID__TRIGGER_ERROR,
+	return send_ras_ta_runtime_cmd(ras_core,
+				ras_core->ras_psp.ta_ctx.session_id,
+				RAS_TA_CMD_ID__TRIGGER_ERROR,
 				info, sizeof(*info), NULL, 0);
 }
 
@@ -785,6 +793,21 @@ int ras_psp_unsideload_ras_ta(struct ras_core_context *ras_core,
 	return unload_ras_ta_fw(ras_core, ras_ta_unload);
 }
 
+int ras_psp_invoke_ras_ta(struct ras_core_context *ras_core,
+		uint32_t session_id, uint32_t cmd_id,
+		void *shared_buf, uint32_t shared_buf_len)
+{
+	/* The debugfs caller hands over a full ras_ta_cmd shared buffer. */
+	struct ras_ta_cmd *ras_cmd = shared_buf;
+
+	if (!shared_buf || shared_buf_len < sizeof(*ras_cmd))
+		return -EINVAL;
+
+	return send_ras_ta_runtime_cmd(ras_core, session_id, cmd_id,
+			&ras_cmd->ras_in_message, sizeof(ras_cmd->ras_in_message),
+			&ras_cmd->ras_out_message, sizeof(ras_cmd->ras_out_message));
+}
+
 int ras_psp_reload_firmwares(struct ras_core_context *ras_core,
 		uint32_t flags)
 {
@@ -810,7 +833,7 @@ int ras_psp_enable_features(struct ras_core_context *ras_core,
 		return -ENOEXEC;
 	}
 
-	return send_ras_ta_runtime_cmd(ras_core,
+	return send_ras_ta_runtime_cmd(ras_core, ta_ctx->session_id,
 			enable ? RAS_TA_CMD_ID__ENABLE_FEATURES :
 				 RAS_TA_CMD_ID__DISABLE_FEATURES,
 			info, sizeof(*info), NULL, 0);
@@ -846,8 +869,9 @@ int ras_psp_query_address(struct ras_core_context *ras_core,
 	if (!addr_in || !addr_out)
 		return -EINVAL;
 
-	return send_ras_ta_runtime_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS,
-		addr_in, sizeof(*addr_in), addr_out, sizeof(*addr_out));
+	return send_ras_ta_runtime_cmd(ras_core, ta_ctx->session_id,
+		RAS_TA_CMD_ID__QUERY_ADDRESS, addr_in, sizeof(*addr_in),
+		addr_out, sizeof(*addr_out));
 }
 
 int ras_psp_sw_init(struct ras_core_context *ras_core)
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index 4cc133c6a6d3..91d17fdd6bda 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -196,6 +196,9 @@ int ras_psp_sideload_ras_ta(struct ras_core_context *ras_core,
 		struct ras_psp_ta_load *ta_load);
 int ras_psp_unsideload_ras_ta(struct ras_core_context *ras_core,
 		struct ras_psp_ta_unload *ras_ta_unload);
+int ras_psp_invoke_ras_ta(struct ras_core_context *ras_core,
+		uint32_t session_id, uint32_t cmd_id,
+		void *shared_buf, uint32_t shared_buf_len);
 int ras_psp_enable_features(struct ras_core_context *ras_core,
 	struct ras_ta_enable_features_input *info, bool enable);
 int ras_psp_trigger_error(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/ta_if.h b/drivers/gpu/drm/amd/ras/core/ta_if.h
index 30c058a524db..87d5aa3f8477 100644
--- a/drivers/gpu/drm/amd/ras/core/ta_if.h
+++ b/drivers/gpu/drm/amd/ras/core/ta_if.h
@@ -44,6 +44,7 @@ enum ras_ta_cmd_id {
 	RAS_TA_CMD_ID__QUERY_BLOCK_INFO,
 	RAS_TA_CMD_ID__QUERY_SUB_BLOCK_INFO,
 	RAS_TA_CMD_ID__QUERY_ADDRESS,
+	RAS_TA_CMD_ID__CHECK_ACA_BANK_ERROR_TYPES = 10,
 	MAX_RAS_TA_CMD_ID
 };
 
-- 
2.43.0

