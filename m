Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC82C2BBCA
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 02:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC26D10E103;
	Wed, 26 Jun 2024 02:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F2CBT142";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9A610E103
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 02:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAWVmEuoodaOg6Z6fScPxLx+H6xWSuzarZhXQS1VlTB7o0F83CQo4Azds7lua1wwkWzPwxkdmETCplcA3GaQ3fSFeINyU0saz7xOc7Jxg3istGg+ayHWW7ErNVcNnsGqU3zbyb0SbiFG4WEqyKfWyV6FO3gcAaoOA4NxS3IQHX1xl8pwNSOsznuY8L3hXmczL7uqbvPdWPmzooWo0GJrn220IBK6A3y/tLHrANG+QE99w6Uf2l07l2+TMUeDMMC/kio3Mrt+MSXepij7QFQtYPIlJnJOiyiHPCKLJhAcct09+j2OLLd2WD3DqaQlnGmx8sckKhL6G/wI/HYp1QhGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2ezwx14pOQGoj6YGn5JzQXcKchCfyAZc7F5Qf3fYXI=;
 b=fK8p6fv/8pW26vHE1bhzeMGuxuEC7CNCukrCD9EkvSDUdYOsTxj3PFp76E+PiSUdPLbugBuGd8ciDQkLsF6M8edGjXjCvaZA8/IZbSDxq7gOa+4N6EBLi7tumt79+eF9H71lI6HANSKQgWBbjhxfHIHY14InkUcReL+RqfWO0UzEfZG4A71MTr6V1kv3RF29U9nerXNNPCb6BWwL1WV+9zkSSqgwZ5cqmHahxBudhx0gxpWu62+/GYp5CTCbY1smnV8L93JSN3FiJX9fd36baq7ufCjQ9/qkYOw2Vz2xXipsTjEabbCPVz4R6HsBswtlRRQToATjQKsrrpYgYtLw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2ezwx14pOQGoj6YGn5JzQXcKchCfyAZc7F5Qf3fYXI=;
 b=F2CBT142HMe9pc0HAYDxhSMEqyC2tnmUSzaXzHQTmvqdeokl6D2LD+TBrt+J2XMgrldN1eNzTX2kzKZ8OZoAuRuwGJsFplEASlDe3m+caAs70dgv/Enx57JcRDldO2JnzNlosUB9ENyVmwYEQAAwEwV0oyNu4Eo0Nvy6ZOR9ypY=
Received: from MW4PR03CA0228.namprd03.prod.outlook.com (2603:10b6:303:b9::23)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 02:20:29 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::c8) by MW4PR03CA0228.outlook.office365.com
 (2603:10b6:303:b9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 02:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 02:20:28 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 21:20:26 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Date: Wed, 26 Jun 2024 10:20:01 +0800
Message-ID: <20240626022001.1139403-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 96aad4f7-55c2-4f84-158d-08dc95868c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|376012|82310400024|36860700011|1800799022; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A97jYU5ZD0kOVyneWsBvchE+uXrp2pkF8tyRVZdkP7Al7oPeI4CcjGS4QW0v?=
 =?us-ascii?Q?DgmYKMflSw9BkJkrHfRq2ShURPAyhmG4au1g36DWLODYzqbhZ4E6xVaD3aBm?=
 =?us-ascii?Q?7CAkeYcrJnPXO6K+dNXmxYoLa9cAgE0m7AaOwJzqjgeqLR95FZod4vR4xW2l?=
 =?us-ascii?Q?8xeHSBzkphWi5B6d/iLQvizeO9lU3VAMofUudQt7yTbRdKdR6O7vFqiF2Qt5?=
 =?us-ascii?Q?VptBAsfkNuGXQxR2tKW9kJxLeOZjaqeQ7b7gpcW1fTk4zL74mfBDaq1SlfRj?=
 =?us-ascii?Q?XO41ICUcBBVBvVC6LCBSzhtaSpHMT3J1qzrdUBtUYBOxR5h0TWgPFzolZXZt?=
 =?us-ascii?Q?y4/Tov+17jI61dqKUZJM5m2ZWTz2PJ2IvCi+yvnneEohMa2qdvnZadpAVApR?=
 =?us-ascii?Q?Cb45iyg1tzI8LnGjcgwC2uRXq1WrcipAhMEOggR2g8dgJedvWoZv9sXEE6bu?=
 =?us-ascii?Q?rCsgCaVSmf2SelirK79uFQIDJp17JpMSRwTC3+enO5NzdWgRSjUNoP6TlaZ2?=
 =?us-ascii?Q?NkNPvdktZCKGlQPE6oT3ZjzFDxpwVyM8iG2bIjLEOm6c3yEoX5l+batbupUl?=
 =?us-ascii?Q?VammgdBaw04QrjI1+vadHY3ZwR2heJZVIJdngKHT9KeUcX/JKzAKknGqFMbf?=
 =?us-ascii?Q?p3BZZKpCjHNlgMrewOx/V5Q0wiN91/d29IPbXtYZp69p+O3qLe8LFs3XgwDI?=
 =?us-ascii?Q?VWe/S+silhx16fcygLVPAPoTBQLpnm032NptErQ310S94YFnt87TqEbHlboe?=
 =?us-ascii?Q?3S9qe95dTRczuD9oZgEcE/g6AAWBk1dR1N/gXiSaXdD89cDJ2ROHffaTq72q?=
 =?us-ascii?Q?0qcbvFgGjaAAvfOtfZtSh8SId/zmdMe3keHY9CoFEhDe71utc6uxoXN1zgb9?=
 =?us-ascii?Q?/ziD26RcSwJ2Eb4RQOAvE0b7ZFveyQASxwTsuZyWR0oxB/52BC4rV4YGnBzl?=
 =?us-ascii?Q?j9UthVwsXucgNdpI4Y4Lc+FqJ9KChoFv5iuMbpoAjSfrFSwTglmHtFpyYaOH?=
 =?us-ascii?Q?xfjEd5oq1UK5a2aNS2NEwoZh9PB/z2KADc5cOIQo1mVrXuwyg4OjdAI7NTEN?=
 =?us-ascii?Q?OPXRQumZN5iybYjh7zNypu0pSGDY22sGcbPXXCxLiwycx/4CTcbgXLvi5EN/?=
 =?us-ascii?Q?UT+xzG3nMMupzf3qqFE2MqVFmVHVW7VwJdpZUg/YLBfJoa948Y1d76DE0GUr?=
 =?us-ascii?Q?LsYsWwOdh7SJxHc5IbmshGnOvcGpgi965dNB57MjZhvlHcrxN2AiyKy4VFIU?=
 =?us-ascii?Q?xtxQ4mkSREuaoV3mhqQfLrhDG7GZAUYjGZ2gEM4WIj0XNzGIPPFZvKdO1f+z?=
 =?us-ascii?Q?6iJ+727OXXIziSro5WtdAguIgy1uSX/37An7I3UvjZAJmyIh0vCR9FUKtgau?=
 =?us-ascii?Q?MVubNuRlvExqcg3DhLseIQc5DdgMZGXAGczhfdx2+3W2EdbMuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230038)(376012)(82310400024)(36860700011)(1800799022); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 02:20:28.7224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aad4f7-55c2-4f84-158d-08dc95868c24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 124 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
 3 files changed, 87 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index fec968d8340f..323b3c470c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1573,6 +1573,69 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
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
@@ -1614,23 +1677,15 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
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
 
@@ -1654,6 +1709,8 @@ int psp_ras_terminate(struct psp_context *psp)
 
 	psp->ras_context.context.initialized = false;
 
+	mutex_destroy(&psp->ras_context.mutex);
+
 	return ret;
 }
 
@@ -1738,9 +1795,10 @@ int psp_ras_initialize(struct psp_context *psp)
 
 	ret = psp_ta_load(psp, &psp->ras_context.context);
 
-	if (!ret && !ras_cmd->ras_status)
+	if (!ret && !ras_cmd->ras_status) {
 		psp->ras_context.context.initialized = true;
-	else {
+		mutex_init(&psp->ras_context.mutex);
+	} else {
 		if (ras_cmd->ras_status)
 			dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
 
@@ -1754,12 +1812,12 @@ int psp_ras_initialize(struct psp_context *psp)
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
@@ -1783,13 +1841,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
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
 
@@ -1799,9 +1852,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	if (amdgpu_ras_intr_triggered())
 		return 0;
 
-	if (ras_cmd->ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
+	if (ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
 		return -EACCES;
-	else if (ras_cmd->ras_status)
+	else if (ras_status)
 		return -EINVAL;
 
 	return 0;
@@ -1811,25 +1864,16 @@ int psp_ras_query_address(struct psp_context *psp,
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

