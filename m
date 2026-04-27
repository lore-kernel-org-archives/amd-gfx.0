Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACF6FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 07:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A8310E5CB;
	Mon, 27 Apr 2026 07:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gw2Atv7G";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E943B10E5CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 07:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqQbeBD7OBFohHXV/UhXdGRSKtgV4wFJ2UUICRmVQFCoIr4rJt/85A9Pcv+FNsLPMJyLNammjAzXkbsJnEpKNjctuYVrpd1vXTlbe8ijqdR5ap7QgJQc7/Us1iIomaoql7aq2sF/RyO19r4d/VckBHOYHWhKBAbQLmMP3qg2NF64fOyNPDY0l3YQGnmuHZ3xKDZlHwo1Rn7adsloUVtBaKM5W2jkOVpeXa+eL+rN0gK1Z0xMC/KXmf4AcnPKH2lhNsSiHTtYbcPNSyFYh5Ow0hVWQVezRTQsG76gwBoa8i5WWB0h2ZSaL2GAfaGmRpsA6KRL5vi9WLm8mkYCSrtnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPZRQyvKMrmW4KCRbl1/rYtq/Z0l2x5qupgJCpQ90R0=;
 b=Eb4MLpBDle25l02RSOntgVxgkzddNYml1sGkxYc1ZAnPwgFoZRL/t0ZikqKVApdNwNBx747Uv18O/p1GqmgTP8S6TdV+TVTbD/6eO/vvgKTwIFy10kq6y489EXFxbH0hA/t8rzLwoEg8tRhyy7vHNTrCU5zgluQuXq1S36CEB7w9tzJ11ukoGxOPQRdqNYSLJzOLWwh+conOPU8NXw0WDlx3+eubRWgn4Q3SEdgE5SBS8g79roiE/bspisccKo/sQjGtacn9Gj7zS2nMXD0hEwpH3nWP0JQuFeTa4n4prt9tTgjf9T3d9CCGMcv0ogJ/qikRrtnpCRXOpOAP+riRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPZRQyvKMrmW4KCRbl1/rYtq/Z0l2x5qupgJCpQ90R0=;
 b=gw2Atv7Gxj09OyumGBaByGqRviKwGv0AyY5ndwT/CDSqsN+EuRIGaYlyCUH7rLE/ymGmyiCLBzPBcLXHi5rO9CmyB4iaeNWuK2B2LlPDti5BtHObb2v9kQ8DRJ8sB+w7XZfPNQ3O8G9BKY7+1OuOT5BAv0e0BOjMZkg5OXDUM3U=
Received: from PH7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:510:339::7)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 07:34:18 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::ff) by PH7PR03CA0024.outlook.office365.com
 (2603:10b6:510:339::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 07:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 07:34:18 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 02:34:15 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: add SMU multi-msgs helpers
Date: Mon, 27 Apr 2026 15:33:52 +0800
Message-ID: <20260427073355.3363500-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427073355.3363500-1-kevinyang.wang@amd.com>
References: <20260427073355.3363500-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: a0adfe76-2974-4dcf-3a43-08dea42f6401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003|11006099003;
X-Microsoft-Antispam-Message-Info: oW7rPpm4cZf53egZ/Yl7pVrv+qRV/LcqmMZrq11Y5rjYuLqBkh30BhPJmkodjGVV1XGQNwKfiXCWy4ial+vviZ7tVM+/6SgzcxEGTucShLQ+UAFMh//b+7h3kggEErFfkAjUMZhWOb2Tpn17RLZUYLMo++OqqfkSrXavLG64Dvn6Aw/XfgI6kapq0pUupSdxJAe/Vh6+aSIlGCqFdemwGRGw31EA/buPY6K3uusC+Gp2UNaUbdU7SKz8yKoITBdKg3+ILI0r5u8LUNoyjo9cVxsSRFxyO4nX071tA8u+1oprwiK5ehU/wDp1AS5rpKMTWWgDOWEeKb/dtAPcQZVOq2AnvD/qHls+oiv2DTNLle9ewB4cB0EDNEDqvs01vO6h1oYEK6abzQrO69hhGF0qR8zTziP4mE6C3rZyP541TkBtr8Tc2/OK1l8gqCR9qevh87RAcB+05zbHTeC7N+Jp63SYWyzP//XJ8eEcihQORvC4VfWLF/Tkl2oj8MDTIWHm804Wsg8TXJELWEiSMTZdOjegbCGvFeRU4qDToD4a71n1+ICMonLJIPU4oO8YsMqPoQBPR708XH3HhZheShsbMVcTxUaUf4yjDTjw/O2ZuFTYOwLJ4r+rTgZhQE956Sgxxl410a/N0Epe1jAy74iyI2LwWp88AXkzWz386KOmV97YisBuPm7J2/lh0tnnSZKIN6fbx/42XqfZ8NYtZxP+hf5I1f30KY6btQqWlco04Sj7p2lQP+9/sn+wF1b7RtreTgV1pVevC4p+dZnyVOfHMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11006099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2juBGuAZolzLmCLcNQz6mx6tFGXvtP5nELpqSwdUC/0wNqnktAjh39g/8kMEmOfZY6f3Nm8mqjWaFxrELiiRPbwTj0vp3vKr2PZQezSrUqn4wJ53HaOYXgw9syrz1aL0i9SgY6N90apEaD/CKoZZwJpFWblrfaG3ERmwD9o0RPEWOaejK6v6jjB5aX7neUPDme+uFPO0E47h+ZU0MyR3KMh2gfdyKbrspl1SsKqZeasZflOeAS3Zgm0Sh8wZYs4lrtM/vgWeFn+/CKuZXAbhFrkqfIcCnPnzJiU1wsl59Mf6GRMp/mOD6wmzKnY5WD/3eNpYrCuLyd0L50ziF8k5kh+5yWnuacp5uTE24iXc7x44qcOenqGdlxjP0ZEE34AYeUN07Fzv7m9MONm6VA1OM43hDaGGCPXwcuFLhkAQX4JY3Vs3K1LBUeE+b/tVfrfN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:34:18.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0adfe76-2974-4dcf-3a43-08dea42f6401
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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

SMU15 driver messages can carry multiple input parameters and return
values, but callers still have to build struct smu_msg_args directly.

Add common SMU multi-msgs helpers in smu_cmn and reuse them in the
single-parameter wrapper and the shared table transfer path.

Keep smu_cmn_send_smc_msg() semantics unchanged for older callers.

No functional change intended.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 96 ++++++++++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 ++++++
 2 files changed, 88 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3d49e58794d2..ba0e6a61991f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -127,6 +127,61 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
 	return smu_msg_wait_response(&smu->msg_ctl, 0);
 }
 
+/**
+ * smu_cmn_send_smc_msg_with_params_ext - send an SMU message with 0..N args
+ * @smu: pointer to an SMU context
+ * @msg: message to send
+ * @params: optional input argument array
+ * @num_params: number of input arguments in @params
+ * @read_args: optional output argument array
+ * @num_read_args: number of output arguments to read back
+ * @flags: message flags (SMU_MSG_FLAG_*)
+ * @timeout: per-message timeout in us (0 = use default)
+ *
+ * This helper keeps the raw protocol semantics of struct smu_msg_args while
+ * hiding the per-call boilerplate. It is intended for true multi-parameter
+ * messages. Legacy wrappers such as smu_cmn_send_smc_msg() retain their
+ * existing single-zero-parameter behavior for compatibility.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int smu_cmn_send_smc_msg_with_params_ext(struct smu_context *smu,
+					 enum smu_message_type msg,
+					 const uint32_t *params,
+					 size_t num_params,
+					 uint32_t *read_args,
+					 size_t num_read_args,
+					 uint32_t flags,
+					 uint32_t timeout)
+{
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {
+		.msg = msg,
+		.num_args = num_params,
+		.num_out_args = num_read_args,
+		.flags = flags,
+		.timeout = timeout,
+	};
+	int ret;
+
+	if ((num_params && !params) || (num_read_args && !read_args))
+		return -EINVAL;
+
+	if (num_params > SMU_MSG_MAX_ARGS || num_read_args > SMU_MSG_MAX_ARGS)
+		return -EINVAL;
+
+	if (num_params)
+		memcpy(args.args, params, num_params * sizeof(*params));
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (num_read_args)
+		memcpy(read_args, args.out_args,
+		       num_read_args * sizeof(*read_args));
+
+	return ret;
+}
+
 /**
  * smu_cmn_send_smc_msg_with_param -- send a message with parameter
  * @smu: pointer to an SMU context
@@ -164,23 +219,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
-	struct smu_msg_ctl *ctl = &smu->msg_ctl;
-	struct smu_msg_args args = {
-		.msg = msg,
-		.args[0] = param,
-		.num_args = 1,
-		.num_out_args = read_arg ? 1 : 0,
-		.flags = 0,
-		.timeout = 0,
-	};
-	int ret;
-
-	ret = ctl->ops->send_msg(ctl, &args);
-
-	if (read_arg)
-		*read_arg = args.out_args[0];
-
-	return ret;
+	return smu_cmn_send_smc_msg_with_params(smu, msg,
+						&param, 1,
+						read_arg, read_arg ? 1 : 0);
 }
 
 int smu_cmn_send_smc_msg(struct smu_context *smu,
@@ -1071,13 +1112,12 @@ int smu_cmn_update_table_read_arg(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *table = &smu_table->driver_table;
-	struct smu_msg_ctl *ctl = &smu->msg_ctl;
-	struct smu_msg_args args;
 	int table_id = smu_cmn_to_asic_specific_index(smu,
 						      CMN2ASIC_MAPPING_TABLE,
 						      table_index);
 	uint32_t table_size;
 	int ret = 0;
+	uint32_t param;
 
 	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
 		return -EINVAL;
@@ -1093,18 +1133,14 @@ int smu_cmn_update_table_read_arg(struct smu_context *smu,
 		amdgpu_hdp_flush(adev, NULL);
 	}
 
-	args.msg = drv2smu ? SMU_MSG_TransferTableDram2Smu : SMU_MSG_TransferTableSmu2Dram;
-	args.args[0] = ((argument & 0xFFFF) << 16) | (table_id  & 0xffff);
-	args.num_args = 1;
-	args.out_args[0] = 0;
-	args.num_out_args = read_arg ? 1 : 0;
-	args.flags = read_arg ? SMU_MSG_FLAG_FORCE_READ_ARG : 0;
-	args.timeout = 0;
-
-	ret = ctl->ops->send_msg(ctl, &args);
+	param = ((argument & 0xFFFF) << 16) | (table_id & 0xffff);
 
-	if (read_arg)
-		*read_arg = args.out_args[0];
+	ret = smu_cmn_send_smc_msg_with_params_ext(
+		smu,
+		drv2smu ? SMU_MSG_TransferTableDram2Smu :
+			  SMU_MSG_TransferTableSmu2Dram,
+		&param, 1, read_arg, read_arg ? 1 : 0,
+		read_arg ? SMU_MSG_FLAG_FORCE_READ_ARG : 0, 0);
 
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index c6ac0e876aea..0e119965ce13 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -118,6 +118,28 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg);
 
+int smu_cmn_send_smc_msg_with_params_ext(struct smu_context *smu,
+					 enum smu_message_type msg,
+					 const uint32_t *params,
+					 size_t num_params,
+					 uint32_t *read_args,
+					 size_t num_read_args,
+					 uint32_t flags,
+					 uint32_t timeout);
+
+static inline int smu_cmn_send_smc_msg_with_params(struct smu_context *smu,
+						   enum smu_message_type msg,
+						   const uint32_t *params,
+						   size_t num_params,
+						   uint32_t *read_args,
+						   size_t num_read_args)
+{
+	return smu_cmn_send_smc_msg_with_params_ext(smu, msg,
+						    params, num_params,
+						    read_args, num_read_args,
+						    0, 0);
+}
+
 int smu_cmn_send_smc_msg(struct smu_context *smu,
 			 enum smu_message_type msg,
 			 uint32_t *read_arg);
-- 
2.47.3

