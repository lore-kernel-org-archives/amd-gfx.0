Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008A6C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 07:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EEE10E3A4;
	Sun, 28 Apr 2024 07:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KNjsWiW1";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1F510E3A4
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 07:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDOThGn8l1NwE9J6u2BoXi7VYOWAfi7nV7WDcbhoC4qleMuovS9joutFyhiheAIb0OO9QDlUSNO7w5B2KhhElYMCYHQMttQ6SYSxvmFeqbR6FYwxR0lJcJ3k+UtNLIT0UcCKqjMTsJS9Ng35jTzDmzvPkzB+unTKMEvBKyM2iOh12BRzfN88+YexQtPcn+b5t2lYBFcaHLBingx8uNpBKYaWcoRaLCXvwA5ZM8e7yj9TmIzUM/XZLe/mOvTKvtu9ksgaQRJZ2hUWbzdhuF7go4seKLm51m2IMQ0sNYl+860OqhzUBzv7/uqHRZu1nUXSS+bUB82Xq/UyUUv0qdqnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATQT3YGXFEUZhR95QvbgyOwSVFP4LayVedq5L85iQyQ=;
 b=PvsE3PH4GF2ffmhfH+Vr72p7+9+cMQ9TQvDos5u4TfFHVPGD3l7P5XYkV03dpzgoFO+iqOjVwNlyBO7ReKhSboLuIY/igNow6uUC97Yk05MYEN+MbN3CANmkYw5H+61QI86r1wjgvfQg9UW6l5mgmLNhKtUvwPmUtw0X1T/STvnCR6KXcK8XV65F0g2FwxALrblTN7kyT04ul+ho7RfrOwN4sai8QegK7kof9E0Ova/CclKEGQS1QfLPMEOt8Vkvpu3iPsqYfVDjLF+zHJTTXjv2XAKHt2xZG+YG7NdJBGzGfIQnRF5AJ604Bv9pMwO37LZHcSjEunLJGFuVO/7BmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATQT3YGXFEUZhR95QvbgyOwSVFP4LayVedq5L85iQyQ=;
 b=KNjsWiW1LovHhdr14Y/nfd+xbGIKc8gSAGt2skPykWLKbqaWCoiKBkaDBqHxUEBiuyEhLrDevQEWygfjR3qVzUJQr3a8sITbR3cmfkthI9Psp3Bwfae9YuDY3c5DUxhULVdUOi1txnvaLgA1fCfVKxyqamRcq4/l+92kahYu+dI=
Received: from CH2PR19CA0029.namprd19.prod.outlook.com (2603:10b6:610:4d::39)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 07:08:22 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::2f) by CH2PR19CA0029.outlook.office365.com
 (2603:10b6:610:4d::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Sun, 28 Apr 2024 07:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Sun, 28 Apr 2024 07:08:22 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 02:08:19 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Date: Sun, 28 Apr 2024 15:08:01 +0800
Message-ID: <20240428070801.376129-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb5c67e-26c2-4abe-624c-08dc6751fd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EB40kSkc6qLAiPmzyqC+soW/kmfPApfXfk1XvrIMK/REQtZxEmuDJ2bIAzTg?=
 =?us-ascii?Q?L99YMMG+nfXgW0f52hpTKGKTPNm73sPGl4buyw+O2EcSjAjTGab2cYsb5+b1?=
 =?us-ascii?Q?mCgOxlRBkuJQlu9oxTkEuAhOTUrXCNkQeiB84ALiPpk+y0XzmoleFpIVMqt4?=
 =?us-ascii?Q?nn9v/k1HAHEJJN9pEX/vptZpkpN4EK4aWPTGTbEzFr7FhrSW6tfPnuz7Clup?=
 =?us-ascii?Q?Xc0CATSQKzAY5nkXuhllsL3KaTgB8UIbtAQTPP3VeQpx9Ak09jgJdJoLiP2W?=
 =?us-ascii?Q?z3mapmB+sXn4MTLVaxt4fwnh3/DV3mGme/rZxfhumdilGnKOzT08BY3ileo4?=
 =?us-ascii?Q?tQAfo/ZtSnKeEf25PuRk0zEEqBhbfed+AJm1x88biqZwOjwN1oZaUwGbrWZy?=
 =?us-ascii?Q?fezpq6JG68i4HKKtxtW/r+7zfdcExEIvluv81gLMNPsUPssRIvOvvSy5595P?=
 =?us-ascii?Q?WjVgNx5h4BnsWerwfyrVpTPGB55BD2D8DtPX4LmOqqiSSRTvMLvoY2cVFdJK?=
 =?us-ascii?Q?pbzmUr29cy1CjGwnrtBBBlr79gVhP5qxoPc/YoO6m+So4r+qp5QQeRQdHrmI?=
 =?us-ascii?Q?SLPzaBCk6o3Go24EgQiGDDLB8RJ19NDFk3m5N/xaNV8moU8ISfMrSquJAd2X?=
 =?us-ascii?Q?sHLjvsHRGQlfSwqYoejfjl+5zXGdg6HpV90zwUqbcUJKbD07xhqZTLVKuFwU?=
 =?us-ascii?Q?FYZKm4HGppI1YIRqKGN6qFqY1RxwkURRHA/nsMiDjjX3aiIS7Q+kWFYBoBlI?=
 =?us-ascii?Q?FID2/J9TvbQnm8aPWLfyPAfj0cOl0yuQLLCLLC3joJ04FCyrju/Gx6FDWYtu?=
 =?us-ascii?Q?iPm7ipK3K8mGeRmMb8C+2k+Mr4PFymY1qpmpA/iflDFawIMaRJfO4rYPVwEm?=
 =?us-ascii?Q?GgqxSm9ibuJ03Epprf7A3BVXIeJkX+9wLWq9IFowHFG1+ezxaxX3f7AKaqnk?=
 =?us-ascii?Q?Uz4DkykcdZp1eG+6lgK7jawVz0lotf2Am6+lZBNUsTdJcaMgpU5tPStfgQkM?=
 =?us-ascii?Q?bYH3uQ+z9ZCK5d4HbdgEbiX48qBjzkJZKYta7+ABD5r0y4gnAY3SPOJTPUIe?=
 =?us-ascii?Q?pL1zEUJf4ebQESYeJ+Ve4j64060CWMo0q2/yyGS93pltLIxMzIUS7wP04sE3?=
 =?us-ascii?Q?37EjvMDtBO6gTmEQtP4IV/Kl9muYgt71/JSDDbD9+IcHVf/3jViiznBYmBNm?=
 =?us-ascii?Q?yEayc1rT12Nt6ExtFPCEQ3jTG6QPqXlwGuBXG/j3/7I1IBmkRe5XiiFlWLyT?=
 =?us-ascii?Q?mAFSjGhtx1V0AWUgsFmJ/4kM6an8HfywX31Jyz+tYhacRnrVx7Z50REX0qmT?=
 =?us-ascii?Q?IR2JQuvoiUQGZqS3JbhrUy9qwiAlBWvZp6JCYVAnOAfuFIChGaJam7CnDSNT?=
 =?us-ascii?Q?ZIUjzfiUoj+u4l/COR8vYEmksmoT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 07:08:22.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb5c67e-26c2-4abe-624c-08dc6751fd72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 121 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
 3 files changed, 84 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 5583e2d1b12f..fa4fea00f6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1564,6 +1564,66 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
 	}
 }
 
+static int psp_ras_send_cmd(struct psp_context *psp,
+		enum ras_command cmd_id, void *in, void *out)
+{
+	struct ta_ras_shared_memory *ras_cmd;
+	uint32_t cmd = cmd_id;
+	int ret = 0;
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
+		if (out) {
+			uint32_t *ras_status = (uint32_t *)out;
+
+			*ras_status = ras_cmd->ras_status;
+		}
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
@@ -1605,23 +1665,15 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
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
 
@@ -1645,6 +1697,8 @@ int psp_ras_terminate(struct psp_context *psp)
 
 	psp->ras_context.context.initialized = false;
 
+	mutex_destroy(&psp->ras_context.mutex);
+
 	return ret;
 }
 
@@ -1729,9 +1783,10 @@ int psp_ras_initialize(struct psp_context *psp)
 
 	ret = psp_ta_load(psp, &psp->ras_context.context);
 
-	if (!ret && !ras_cmd->ras_status)
+	if (!ret && !ras_cmd->ras_status) {
 		psp->ras_context.context.initialized = true;
-	else {
+		mutex_init(&psp->ras_context.mutex);
+	} else {
 		if (ras_cmd->ras_status)
 			dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
 
@@ -1745,12 +1800,12 @@ int psp_ras_initialize(struct psp_context *psp)
 int psp_ras_trigger_error(struct psp_context *psp,
 			  struct ta_ras_trigger_error_input *info, uint32_t instance_mask)
 {
-	struct ta_ras_shared_memory *ras_cmd;
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 	uint32_t dev_mask;
+	uint32_t ras_status;
 
-	if (!psp->ras_context.context.initialized)
+	if (!psp->ras_context.context.initialized || !info)
 		return -EINVAL;
 
 	switch (info->block_id) {
@@ -1774,13 +1829,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
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
 
@@ -1790,9 +1840,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	if (amdgpu_ras_intr_triggered())
 		return 0;
 
-	if (ras_cmd->ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
+	if (ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
 		return -EACCES;
-	else if (ras_cmd->ras_status)
+	else if (ras_status)
 		return -EINVAL;
 
 	return 0;
@@ -1802,25 +1852,16 @@ int psp_ras_query_address(struct psp_context *psp,
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
index ee16f134ae92..686023918ce3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -197,6 +197,7 @@ struct psp_xgmi_context {
 struct psp_ras_context {
 	struct ta_context		context;
 	struct amdgpu_ras		*ras;
+	struct mutex			mutex;
 };
 
 #define MEM_TRAIN_SYSTEM_SIGNATURE		0x54534942
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index ca5c86e5f7cd..87f213f92d83 100644
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

