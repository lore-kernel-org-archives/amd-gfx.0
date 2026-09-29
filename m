Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340C7C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DB610E90F;
	Tue, 29 Sep 2026 03:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gwb+fI6+";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA6310E90F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baX0BbQ7lLbiwzW6S1qC4bILEcyg8j24jAGGBH0Jw3nibVVofg9dkaWiWwloODg4nv7dRXILe4zcLA+OfTmi0wvSau42xhNUiO9vO8I6BPHXNsbtLFJ9QjSaK+xaOKRuqunEUrQQ6ZlySAgbYa1r31Fhwq8ESNb538TH1qQ0Dd4Jv+p6jWet8CzSo32yuI/IrpA2sB1sqKoZ1tbGxlo0gqob5ZqiKmoqABNK0QJmlMGSoshTMSa+FphXZ/0471lxvwD44qA+Qrs7Zgg/R1CeBLaeNKK16ZMC00EI08UsyVzT1PSMIETkiWDingvYqIjiKnMnZ9w66EurMeq6hFd8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot5WJU78KMGrN+Gg5W2offS8QcDPoTqoJpK4q6/vQGA=;
 b=cRqIWjxRuB37CzdixWYJAjnggGi/PmzSzbUUx5UioNd6yyzkMrYQC1pKZyJbUHoPXdvPX/C1oDMQWLBRCI3PZ6WlLnZFvZxYa0kxUz+2fN50tTOQxmbdWzQ5NNiIdGl/8QGXbLZddseA/PbtaBkBVbKF/0dZ03xN38fQLad3HLMIp8/+BINcpzI6y6mhpki74/P80hjMYiosMMQzLb355/ub+7BU9bbog7hDuO/+bQUNyCnNazy4uAl/RD2yJNrc55rNLQP5koFdPRpVoPsfCgiFHcCdndHws6km9z7JN3BR4eKWZGrOu8qEzpIQTKN0BaWtGDvrZj2pQAczrmmYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot5WJU78KMGrN+Gg5W2offS8QcDPoTqoJpK4q6/vQGA=;
 b=Gwb+fI6+eJ1vVWi9HX8VaCWjX4YA/ot7QmKIEIAdqByhXdsfTge7jU5NfuW4yCx9140QxvlpK3GqDiBkR0v4cnpJqW3kNC3F9WzARM0f+nO/A0kMznHgfzLCmEedrL6yYQI5duz+nFmF9yswpyWSy+hyC3wVO/YQrzj87eWHJ6Y=
Received: from CH0PR03CA0318.namprd03.prod.outlook.com (2603:10b6:610:118::26)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:55:42 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::5b) by CH0PR03CA0318.outlook.office365.com
 (2603:10b6:610:118::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 03:55:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:55:41 +0000
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:55:38 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, <Xiang.Liu@amd.com>, <Ce.Sun@amd.com>,
 <Gangliang.Xie@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amd/ras: Support invoke ras command
Date: Tue, 29 Sep 2026 11:55:24 +0800
Message-ID: <20260929035524.229925-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CY3PR12MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: eaeed213-c29d-4fac-b75d-08df1ddd8817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|6133799003|10067099003|5023799004|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: XH7aEuYhGwWJW7Tre8g1McQXcIAdKXbRtK53ndn7SXbyuVBBLw4qUEL7ZHyYfF1Pict/RfrwMiJ17NuAIUUYr/otrUyBxHnb/bFWBOozhExf3ayKqhFjbbyTRbngl6rJVdbBmHNGW4R036crY220ROllNgl0Am/vw0tIeas6fH66wWO+Sdtpm31bYYpsY60eMHX4F+QmNjpHjCWEwawYdlhBaf9OSciQjC53a1Cqf0VWEghKua5L/bwnWNPiu5wgGeInTQkE04ZeZdcmkZtbCdfkvilcIXrZlkzzF1ip12GSoGpALUoeLRnYRtzWmbfh3FqkdlIM2giR4Rb4O2f6lg604UtL23w2vL+xmDUBLS3vwXx0cJnz8MluSMnGa60HIM4t8pRGXxCxXRwWxRJlQXThcMT/iu4CqYMUKhUf8N/vUZOuSWLAhekoTs038JHnf4+i1lVTuQI54MJe5rolQdzpNfFpe3LYDeLXbFD/Xc+aXN+HlMOBQHdqTaDEB++Pwf26Ts6+r6q4h3KQPFBic6mK088p7EH6wOaND+AjC19glVmuORX7O1pSNHwnJEv3xUbqR0FpdG9e26oCfaY0UcFXgTW1fZ3a3TrCtcPVhqyupQ0HDElOkRjOw++Hg4Irg+i76mwoXvYbwL3pH9DS1c5fXwI/UMfSTauCaj7azA1JyANmtPuhpHCppIsaJYw9G8HmNNSqZ8igL9jXH4dVag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yQE4Qq5clwtfBp32mEnIaPvJ7ZJaDRrAaM1loNbhK1dfzx8h/1BC+ygcE5D164TsN5gHNX/tH4rJTxobilKFxopNfGGnJ7xE+NXmH7E2IIJsRGoBBUuqxDeqhSordaUUYqPSR7dGjnOJLYG+HwABejDusd++Vc41hO76xQyeLOjG9gtEQL1Pv961op5/s36/Zbjr1bkYnFzngwA6mcvwgkGcm12gg0wTosILPprox8JkE8OiNwNbcpc+9mhcK2kjxdo4Q9SJLyav0UfOQMlsmQfKGVBDjmaYmdz68jbFXl83UvMlkFXcXESGDzdlKraYNSBWrO2n4h6t+W16a17nxh6CxBLmsa4Te712Z/4Us1YB1xxQmYMnr9ljCP4DhfDYzmceBI4qSlCCknRLeGquCoVBQ2VQsM1L6c29nBo3IOee2QsJvAH232139CiPy5/+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:55:41.7583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaeed213-c29d-4fac-b75d-08df1ddd8817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
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

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 17 ++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.c     | 62 ++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.h     |  3 ++
 3 files changed, 82 insertions(+)

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
index ed53cd25d6bd..a1f1b671300c 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -785,6 +785,68 @@ int ras_psp_unsideload_ras_ta(struct ras_core_context *ras_core,
 	return unload_ras_ta_fw(ras_core, ras_ta_unload);
 }
 
+int ras_psp_invoke_ras_ta(struct ras_core_context *ras_core,
+		uint32_t session_id, uint32_t cmd_id,
+		void *shared_buf, uint32_t shared_buf_len)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct psp_gfx_cmd_invoke_cmd invoke_cmd = {0};
+	struct psp_cmd_resp resp = {0};
+	struct gpu_mem_block *cmd_mem;
+	int ret;
+
+	if (!shared_buf || !shared_buf_len)
+		return -EINVAL;
+
+	if (!ras_core_down_trylock_gpu_reset_lock(ras_core))
+		return -EACCES;
+
+	mutex_lock(&ta_ctx->ta_mutex);
+
+	if (!ta_ctx->ras_ta_initialized) {
+		RAS_DEV_ERR(ras_core->dev, "RAS TA is not initialized, cmd_id: %u\n", cmd_id);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	cmd_mem = ta_ctx->cmd_gpu_mem;
+	if (!cmd_mem || !cmd_mem->mem_cpu_addr) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	if (shared_buf_len > cmd_mem->mem_size) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	memset(cmd_mem->mem_cpu_addr, 0, cmd_mem->mem_size);
+	memcpy(cmd_mem->mem_cpu_addr, shared_buf, shared_buf_len);
+
+	invoke_cmd.ta_cmd_id = cmd_id;
+	invoke_cmd.session_id = session_id;
+	ret = send_psp_cmd(ras_core, GFX_CMD_ID_INVOKE_CMD,
+			&invoke_cmd, sizeof(invoke_cmd), &resp);
+	ta_ctx->resp_status = resp.status;
+	if (ret || resp.status) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Failed to invoke RAS TA (%d) and status (0x%X)\n",
+			ret, resp.status);
+		if (!ret)
+			ret = -EINVAL;
+		goto unlock;
+	}
+
+	/* Return the complete TA response, including its status, to the caller. */
+	memcpy(shared_buf, cmd_mem->mem_cpu_addr, shared_buf_len);
+
+unlock:
+	mutex_unlock(&ta_ctx->ta_mutex);
+	ras_core_up_gpu_reset_lock(ras_core);
+
+	return ret;
+}
+
 int ras_psp_reload_firmwares(struct ras_core_context *ras_core,
 		uint32_t flags)
 {
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
-- 
2.43.0

