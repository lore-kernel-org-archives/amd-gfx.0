Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580B1C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 06:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05F310E0DD;
	Mon, 15 Jul 2024 06:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dw0YcG79";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8496B10E0DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 06:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM4Qb4gK6XAnSFu+Dxm2RcOkNjCdxNXgOn3ZWAi+k0bec5bQBYhLE6hHqVcOl97ctjqdINl85e4/OGw8V6/DGiSCWagrG+zEtw/DwRjLfGY1/vN4lZBFjQq46L6SEOz19JK6g1ytH+D5RtZimk3WswWsn21gheKagaO/os1+/oGcGP5qBIbdX60wf+L4PqlaedhUtBU2MobskWCluJ95Zrr6wpsLhXquuXuNtkoIEc12DZpkEbpDa2sVEwxkdm4Uis4/dpRLHnSQGYPEGVKPGw3hSwWJi4tvMFxzvSvifSM0haXi2FIbC74S5Y1YoAFePguRQGVtf/qsPLWzgxRMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnUYLcrwwW1VSmXMfhMhGp6sW2In99kXG2HviqFFdqc=;
 b=f4jXWwqPzFvz1X8UTYZXfVd+FHk8UiDgJ1P3Er8tx0S/VroR4tZJsbYoN0O2kp/mVrkIq0A1tQ+oqRIP8wDomi0iPOStl50CsGsfLt5xe3RMdJx4vwStJh/72uo9jgjNNUQ1mcp++Q+b5T7GLYBOq1OyX4uDl7CgwpspYi+AhsZJWK/dHrOgf8XjDBSyHj4iAcy/EtHQ5SJIAh7weLRvkAZiA5kHXBeIOL/bdUPnXlx1+lrIjhMECf0BKtJMBi5ZH5C3t/oArXooLP7EOsOcVy2X3/RxRdwibi9csFuM3g2Vcs5lni9bILKTPi0hafxpNSPbRij9tOFKDzL6aXPcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnUYLcrwwW1VSmXMfhMhGp6sW2In99kXG2HviqFFdqc=;
 b=Dw0YcG79G3xHTNWeO6eLtwKslviPwV1ZOb2fbl8/NzeKAgK2Vo7QJTJy/OjFVubbUJ3zgbB0lrJCEIO9MMcxd+X+Bj/K5UksLkBmmxxCGOmQCDt0x+PfzvmH+McNDkj5vidKNmk5NKurtdMCNUTcYpZeA3nLuB0/0X2EMzmIu1U=
Received: from SJ0PR05CA0116.namprd05.prod.outlook.com (2603:10b6:a03:334::31)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 06:11:25 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:334::4) by SJ0PR05CA0116.outlook.office365.com
 (2603:10b6:a03:334::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.9 via Frontend
 Transport; Mon, 15 Jul 2024 06:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 06:11:24 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 01:11:21 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: add mutex to protect ras shared memory
Date: Mon, 15 Jul 2024 14:03:58 +0800
Message-ID: <20240715060358.79736-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d4c88f-041f-428a-03f8-08dca494f4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Hg4jVslvInwpEV8Vc2UmUBeASkdewDRuxRXfGDBExYzA9MGzkPy/C0w541X?=
 =?us-ascii?Q?jvuvybRlv2+KUyIQT58QRbprOsM2k+oaDqgBpyjmWFWeZxTiJCik930/Vvjn?=
 =?us-ascii?Q?SrQuwb8tI5Ir1kbljdsJSSNBkUarhIaVEXhFWaz74Hc3d3tZFmcOFFGHC3NV?=
 =?us-ascii?Q?SRREI5Mx3t7VZtHBkT000d+D2dBcZ95/ge00/weaVrkBuRbYhn8jkA0blD3j?=
 =?us-ascii?Q?4O7Z66tmApErareHaS7PXUiY+Lyq++WpwYZqdTJOdWA3y8NX71N534Il7GuR?=
 =?us-ascii?Q?vSLpLcZWKG8PKt2CmnDnyVffIkTzzYxmkUG+iH/0hPWZ6GXlQ1p6hbjSKlzv?=
 =?us-ascii?Q?KsY3LiShfd5Xd50tac3LcWugf8pnrVXO2ljpIuSEOwV977ZtkmupQdH0t+o8?=
 =?us-ascii?Q?r29l4JaHjtY84bYbAxeP3Ov2Cv4TzEDqOtLm/2TZYgfk7HT4bL1UvD1gRz2J?=
 =?us-ascii?Q?ujbzDddShg72fsG42gMvivs/rL0ROZXqDRPomX2nkPGFeCEwxxSZaoGz1/W6?=
 =?us-ascii?Q?Cnoh/dqeseI3DBeUN7orcaBsZeADZbUVN+K56nwINrXLECwgTbfVDGLDwWWK?=
 =?us-ascii?Q?W9aqLINNF2r8GLlwdB7k8oEzP8TRHYPN16KmSfzZ3cSuAN4/wPmiprqp2qD0?=
 =?us-ascii?Q?lN0UBy5foTeYDFN7R97BMZ7WPIv2/TnChjafIm8gfosSVqKhcNkilV2ITXUS?=
 =?us-ascii?Q?3AbRR45wpNSF/vB+bANttmFOrcdI5GtGp2MH3ZC+7o9LDoHfT01aFNJ29o6q?=
 =?us-ascii?Q?CIlymXLnu725kBuBDQTmTyvRA2/oUrXAGMIkn2NvQUic0troC7nVbBqKHnnZ?=
 =?us-ascii?Q?090fc4MPnoYcRFNjO0d+uvZWgTK3u9WwDEcV8CQcZEAV6Dd9Msaag6lZnlcb?=
 =?us-ascii?Q?6RdB3pYuTnoO686NSoKbIIyWoghjBImJOSS2nm09CaMI+IcnEIiLwNJOvlbx?=
 =?us-ascii?Q?fMqYtT+DyD8jYDWqzG6DcSdFAha+TEQAIXbIySzzhGa2GT8IvKzFdjuLH/oH?=
 =?us-ascii?Q?qetCb3YfCS5zO25VcYCx2ygVG4P4s1N5gLhG6nw9md9r5GPwme5zVUjnJyF4?=
 =?us-ascii?Q?HI5Ua8oPU7AmNHtuQxe2+cchSzuFMRpwE38qWGrxhx0gOFoCtfzavQpfUf2/?=
 =?us-ascii?Q?0/+qWuby1+7aOh0Ge8DkEgp5cQvxO3jWwjSRFBkkSt6gEsaYoVM0gK+GhIlp?=
 =?us-ascii?Q?3Yk6V36r6AGWVVCGEkpcq3GVU2wfziB32oigYFnz3yfxkNNb/Abl5FWcVrwu?=
 =?us-ascii?Q?cy8Pb+bJSaPIovUJ/pesCwA1gj26kkUHuvDOgwe1Rr8ZsHbXN/cuNxwy0Emz?=
 =?us-ascii?Q?Em/WReM9o97afxDsQokUZkLV/auwHFtdI1EiNJi73pnWZNHdCCRKKqJpgjLX?=
 =?us-ascii?Q?vi+wzPCcar49XVsPl/QlsN2qyLSXirurlV3ii1etYWqUSColnk1E9Uq/PVB4?=
 =?us-ascii?Q?4WiaEYQ7UO/EHySm7Dlg2VnNOJ21QYrx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 06:11:24.7109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d4c88f-041f-428a-03f8-08dca494f4cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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

Add mutex to protect ras shared memory.

v2:
  Add TA_RAS_COMMAND__TRIGGER_ERROR command call
  status check.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 123 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
 3 files changed, 86 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index ba2abcf92d9c..e97a5e0ce208 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1591,6 +1591,68 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
 	}
 }
 
+static int psp_ras_send_cmd(struct psp_context *psp,
+		enum ras_command cmd_id, void *in, void *out)
+{
+	struct ta_ras_shared_memory *ras_cmd;
+	uint32_t cmd = cmd_id;
+	int ret = 0;
+
+	if (!in)
+		return -EINVAL;
+
+	mutex_lock(&psp->ras_context.mutex);
+	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
+	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
+
+	switch (cmd) {
+	case TA_RAS_COMMAND__ENABLE_FEATURES:
+	case TA_RAS_COMMAND__DISABLE_FEATURES:
+		memcpy(&ras_cmd->ras_in_message,
+			in, sizeof(ras_cmd->ras_in_message));
+		break;
+	case TA_RAS_COMMAND__TRIGGER_ERROR:
+		memcpy(&ras_cmd->ras_in_message.trigger_error,
+			in, sizeof(ras_cmd->ras_in_message.trigger_error));
+		break;
+	case TA_RAS_COMMAND__QUERY_ADDRESS:
+		memcpy(&ras_cmd->ras_in_message.address,
+			in, sizeof(ras_cmd->ras_in_message.address));
+		break;
+	default:
+		dev_err(psp->adev->dev, "Invalid ras cmd id: %u\n", cmd);
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	ras_cmd->cmd_id = cmd;
+	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
+
+	switch (cmd) {
+	case TA_RAS_COMMAND__TRIGGER_ERROR:
+		if (ret || psp->cmd_buf_mem->resp.status)
+			ret = -EINVAL;
+		else if (out)
+			memcpy(out, &ras_cmd->ras_status, sizeof(ras_cmd->ras_status));
+		break;
+	case TA_RAS_COMMAND__QUERY_ADDRESS:
+		if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
+			ret = -EINVAL;
+		else if (out)
+			memcpy(out,
+				&ras_cmd->ras_out_message.address,
+				sizeof(ras_cmd->ras_out_message.address));
+		break;
+	default:
+		break;
+	}
+
+err_out:
+	mutex_unlock(&psp->ras_context.mutex);
+
+	return ret;
+}
+
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
 	struct ta_ras_shared_memory *ras_cmd;
@@ -1632,23 +1694,15 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable)
 {
-	struct ta_ras_shared_memory *ras_cmd;
+	enum ras_command cmd_id;
 	int ret;
 
-	if (!psp->ras_context.context.initialized)
+	if (!psp->ras_context.context.initialized || !info)
 		return -EINVAL;
 
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
-	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-	if (enable)
-		ras_cmd->cmd_id = TA_RAS_COMMAND__ENABLE_FEATURES;
-	else
-		ras_cmd->cmd_id = TA_RAS_COMMAND__DISABLE_FEATURES;
-
-	ras_cmd->ras_in_message = *info;
-
-	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
+	cmd_id = enable ?
+		TA_RAS_COMMAND__ENABLE_FEATURES : TA_RAS_COMMAND__DISABLE_FEATURES;
+	ret = psp_ras_send_cmd(psp, cmd_id, info, NULL);
 	if (ret)
 		return -EINVAL;
 
@@ -1672,6 +1726,8 @@ int psp_ras_terminate(struct psp_context *psp)
 
 	psp->ras_context.context.initialized = false;
 
+	mutex_destroy(&psp->ras_context.mutex);
+
 	return ret;
 }
 
@@ -1756,9 +1812,10 @@ int psp_ras_initialize(struct psp_context *psp)
 
 	ret = psp_ta_load(psp, &psp->ras_context.context);
 
-	if (!ret && !ras_cmd->ras_status)
+	if (!ret && !ras_cmd->ras_status) {
 		psp->ras_context.context.initialized = true;
-	else {
+		mutex_init(&psp->ras_context.mutex);
+	} else {
 		if (ras_cmd->ras_status)
 			dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
 
@@ -1772,12 +1829,12 @@ int psp_ras_initialize(struct psp_context *psp)
 int psp_ras_trigger_error(struct psp_context *psp,
 			  struct ta_ras_trigger_error_input *info, uint32_t instance_mask)
 {
-	struct ta_ras_shared_memory *ras_cmd;
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 	uint32_t dev_mask;
+	uint32_t ras_status = 0;
 
-	if (!psp->ras_context.context.initialized)
+	if (!psp->ras_context.context.initialized || !info)
 		return -EINVAL;
 
 	switch (info->block_id) {
@@ -1801,13 +1858,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	dev_mask &= AMDGPU_RAS_INST_MASK;
 	info->sub_block_index |= dev_mask;
 
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
-	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-	ras_cmd->cmd_id = TA_RAS_COMMAND__TRIGGER_ERROR;
-	ras_cmd->ras_in_message.trigger_error = *info;
-
-	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
+	ret = psp_ras_send_cmd(psp,
+			TA_RAS_COMMAND__TRIGGER_ERROR, info, &ras_status);
 	if (ret)
 		return -EINVAL;
 
@@ -1817,9 +1869,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	if (amdgpu_ras_intr_triggered())
 		return 0;
 
-	if (ras_cmd->ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
+	if (ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
 		return -EACCES;
-	else if (ras_cmd->ras_status)
+	else if (ras_status)
 		return -EINVAL;
 
 	return 0;
@@ -1829,25 +1881,16 @@ int psp_ras_query_address(struct psp_context *psp,
 			  struct ta_ras_query_address_input *addr_in,
 			  struct ta_ras_query_address_output *addr_out)
 {
-	struct ta_ras_shared_memory *ras_cmd;
 	int ret;
 
-	if (!psp->ras_context.context.initialized)
-		return -EINVAL;
-
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
-	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-	ras_cmd->cmd_id = TA_RAS_COMMAND__QUERY_ADDRESS;
-	ras_cmd->ras_in_message.address = *addr_in;
-
-	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
-	if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
+	if (!psp->ras_context.context.initialized ||
+		!addr_in || !addr_out)
 		return -EINVAL;
 
-	*addr_out = ras_cmd->ras_out_message.address;
+	ret = psp_ras_send_cmd(psp,
+			TA_RAS_COMMAND__QUERY_ADDRESS, addr_in, addr_out);
 
-	return 0;
+	return ret;
 }
 // ras end
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 3635303e6548..74a96516c913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -200,6 +200,7 @@ struct psp_xgmi_context {
 struct psp_ras_context {
 	struct ta_context		context;
 	struct amdgpu_ras		*ras;
+	struct mutex			mutex;
 };
 
 #define MEM_TRAIN_SYSTEM_SIGNATURE		0x54534942
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 8e8afbd237bc..0c856005df6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -348,6 +348,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 
 	context->session_id = ta_id;
 
+	mutex_lock(&psp->ras_context.mutex);
 	ret = prep_ta_mem_context(&context->mem_context, shared_buf, shared_buf_len);
 	if (ret)
 		goto err_free_shared_buf;
@@ -366,6 +367,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 		ret = -EFAULT;
 
 err_free_shared_buf:
+	mutex_unlock(&psp->ras_context.mutex);
 	kfree(shared_buf);
 
 	return ret;
-- 
2.34.1

