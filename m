Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6262CCD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 07:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EADDC10E6CC;
	Mon, 18 May 2026 07:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TzKkFJCg";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012030.outbound.protection.outlook.com
 [40.93.195.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3ED410E6B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icv9PMir8Qh4NrGSjzDlShE5KJD9062HfwrZ7BBTOLZRmo06njyZFiAezJX9yhHEvRXDFkzPC/xg7GEgqRX5MGCg68e8J5LgrCTpGCvUkr95XkOpz8f75pfVIkJncCBCq8y5LKWt/M7ftDRJiZlqPVNRVaOi0bU3KIJe492Psx3IHBxQG0i+4b31eyoxc6FZo3gQu8iLhBatsNzKlGEmkzQq0iQU5YR/baMGY61zHF26Fa7Z5lkNUehfdHEA5hW1pW8spKNtOFkqtxwukeqz7r1osvfnnfWEROd6KOirvFUE5yZ5vrP2oGu3QPoFplW2WWpJjD9wbvaacpqliZfLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXNP2lCGEBwXY3XLdB3Z6CXkdogb6IikifCwHU0gupU=;
 b=UvGa0+I1G4DGCpcnSwQxPCrw1nHfocT0WGMq0vyyUBnO9PjVoCDQEHzOk1COfX84SuMubtzw1M6mKerBZV1dLJrayzSkUGO3mwRC2UkfT0ntq7wOmHloR4m+sDDiSpTmKo8/PCaJiOr+WpIOQ6DkgRcuu7Wq7a9vfVnoASxrzEhiNVUEjv4mEgY3icKchGeYEMPfBtI7Jd+zF87ivxchgI6YlA65NGVuBz1rEuGmarSBu3Uo3HLEteMg1g3F3Ds19A6MhknOwfKKC5Kp8g4scXEW27ExSMbkkP2DdrwJ9JyHwfNZpr30tt3pJtciYsWAbPIHciLuz364+J1EE1/vFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXNP2lCGEBwXY3XLdB3Z6CXkdogb6IikifCwHU0gupU=;
 b=TzKkFJCgDen6yWpAxJVtfJGEHXaiCrxVK1DDfh3hJtAxwESW3Nq5a2UEVreX7l4EFx8NjNBag1+q9/sIKpfyelCtRe5h6j7cyEigPPMR8nh88ZwrLLKTqdkv17Ai+3BVB9qqh0S2TF2+USkFnmvNfzDBBlG8gx8q114s1+l+uj0=
Received: from BN0PR08CA0028.namprd08.prod.outlook.com (2603:10b6:408:142::27)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 07:23:23 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::5d) by BN0PR08CA0028.outlook.office365.com
 (2603:10b6:408:142::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 07:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:23:22 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 02:23:20 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 5/7] drm/amd/ras: add length check for ras command output
 buffer
Date: Mon, 18 May 2026 15:22:13 +0800
Message-ID: <20260518072215.3647120-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: eb945532-fd5e-452b-69ee-08deb4ae582e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|22082099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: vAlfZb6YFYFaU3hmJkrPo+7tBnfg7V2ZSz+8CsGWfTQ41XMcciFiHR+Kzu5HhN0M7Qi1hHOusdWRi/y1lcwW1oeoWXHZZaNW6lPJO72NiafCi2QojXhSxmZICNK5sp6NWLttQbtrDolJ2HnVxo0wun6oN1RXhfzHHN+AmyHmggOlyv8NGvV9hwtB/YChz1K+grX2izPcr653fhxPSnyBH32/Qa32bXnBn2EGx52in8jnzYItmFfrgrBqvbETOnwcGnh9wr65eaNmdEraGHch0/yU1CyK9nqYnqh71NN4bPk5ZwS+KF1y9+41Bu2AAzVhz42vv9MeRhZjdZoZw/Sq619R11yTO5DuCdofFLpo0YVsRcTQuHATGqqSTF4arKufEXGqlfGMT4n16UT59rm8ujHRuphiFO3DmevPm32UC6evAIU9zuB6nG7p8v2V4yh9i8mtbns2QxsaGcbL8SIxHj8D4+aRhEx8QZIK4gd9uHk74oTVP7gKMjDQB+1ZLU/YNbJ5s75R6UF/yZ33qiRKNhTfmCcc8zr5KkKYtyYdiEjPgMGJN7lFmD0cgNoA2kp9yMab7iRKGGGSg6ItwxBimQR2x2tM3skWfKDkDZOqaHods9N6agNHTlJafV0aWvEH71pdtyJkPwYBQ89UkhPJocghRY/2YYwcEfdiVQspNJHyafy+Ko6wkouCXYAo1tTA8chTHqnsYP1epMn4hRWmPjWRHURy4FbOnYHyb6sT0bE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003)(11063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gFNxHa22Y9zq1RKpXLQLtTPG3+E4g8GRNcB2pfpXZgGf7dH/wpoFm1D9J5ncsYk+EUjaYD5SovZ3PZAFrcC55ryUJvUpMkbdF7WM7aKBd6/jalw9fC81CqAdeP+Q9A1paAfVUpIyn36KLfw5gSa7jIfs2O04EMc2fd8WY6SKlontths+yOyIY9QDMY/tWPYbXENzPHCsCnGSXmA4fLq4ERAgNbcL4M5Zqo5KvJYjl5wjUS+ak7ROU3pLFejYIC+P7S6cQ1nJgzlOwa2saSUQE4SfDfs6WtPe320Cj/BHADlqmdgsq4GiJ5MQpfrqvC+Uc9F1cXtAxD/2NJp7Xv5vl1ThKv8G9jhqciGe++v5TMhGnUnBjwipbhuHN7aQHWB9xyEOy2NOY1GxqC11SvmRvrbPocfg3N9TPZ/+urr/EtX751uiIIG4jcW0vD1ZTFd2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:23:22.9512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb945532-fd5e-452b-69ee-08deb4ae582e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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

Add length check for ras command output buffer.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  8 ++++---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c |  5 +++--
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c     | 22 ++++++++++++++-----
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index cb6498c30834..c22e53e84207 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -139,7 +139,8 @@ static int amdgpu_ras_get_ras_safe_fb_addr_ranges(struct ras_core_context *ras_c
 	struct amdgpu_mem_partition_info *mem_ranges;
 	uint32_t i = 0;
 
-	if (cmd->input_size != sizeof(*input_data))
+	if ((cmd->input_size != sizeof(*input_data)) ||
+		(cmd->output_buf_size < sizeof(*ranges)))
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
 	mem_ranges = adev->gmc.mem_partitions;
@@ -207,7 +208,8 @@ static int amdgpu_ras_translate_fb_address(struct ras_core_context *ras_core,
 			(struct ras_cmd_translate_fb_address_rsp *)cmd->output_buff_raw;
 	int ret = RAS_CMD__ERROR_GENERIC;
 
-	if (cmd->input_size != sizeof(struct ras_cmd_translate_fb_address_req))
+	if ((cmd->input_size != sizeof(struct ras_cmd_translate_fb_address_req)) ||
+		(cmd->output_buf_size < sizeof(*rsp_buff)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	if ((req_buff->src_addr_type >= RAS_FB_ADDR_UNKNOWN) ||
@@ -279,7 +281,7 @@ int amdgpu_ras_submit_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx
 
 	cmd->cmd_res = res;
 
-	if (cmd->output_size > cmd->output_buf_size) {
+	if (!res && (cmd->output_size > cmd->output_buf_size)) {
 		RAS_DEV_ERR(cmd_core->dev,
 			"Output size 0x%x exceeds output buffer size 0x%x!\n",
 			cmd->output_size, cmd->output_buf_size);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 4775a56e47dc..b8e9442b2ca5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -278,7 +278,8 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	uint8_t *out_buf;
 	int ret = 0, i, count;
 
-	if (cmd->input_size != sizeof(struct ras_cmd_cper_record_req))
+	if (cmd->input_size != sizeof(struct ras_cmd_cper_record_req) ||
+		(cmd->output_buf_size < sizeof(*rsp)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
@@ -491,7 +492,7 @@ int amdgpu_virt_ras_handle_cmd(struct ras_core_context *ras_core,
 
 	cmd->cmd_res = res;
 
-	if (cmd->output_size > cmd->output_buf_size) {
+	if (!res && (cmd->output_size > cmd->output_buf_size)) {
 		RAS_DEV_ERR(ras_core->dev,
 			"Output data size 0x%x exceeds buffer size 0x%x!\n",
 			cmd->output_size, cmd->output_buf_size);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
index 1136db9e29c4..5b7a36596b02 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -38,7 +38,8 @@ static int ras_get_block_ecc_info(struct ras_core_context *ras_core,
 	struct ras_ecc_count err_data;
 	int ret;
 
-	if (cmd->input_size != sizeof(struct ras_cmd_block_ecc_info_req))
+	if ((cmd->input_size != sizeof(struct ras_cmd_block_ecc_info_req)) ||
+		(cmd->output_buf_size < sizeof(*output_data)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	memset(&err_data, 0, sizeof(err_data));
@@ -122,7 +123,8 @@ static int ras_cmd_get_bad_pages(struct ras_core_context *ras_core,
 			(struct ras_cmd_bad_pages_info_rsp *)cmd->output_buff_raw;
 	int ret;
 
-	if (cmd->input_size != sizeof(struct ras_cmd_bad_pages_info_req))
+	if ((cmd->input_size != sizeof(struct ras_cmd_bad_pages_info_req)) ||
+		(cmd->output_buf_size < sizeof(*output_data)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	ret = ras_cmd_get_group_bad_pages(ras_core, input_data->group_index, output_data);
@@ -177,7 +179,8 @@ static int ras_cmd_get_cper_snapshot(struct ras_core_context *ras_core,
 			(struct ras_cmd_cper_snapshot_rsp *)cmd->output_buff_raw;
 	struct ras_log_batch_overview overview;
 
-	if (cmd->input_size != sizeof(struct ras_cmd_cper_snapshot_req))
+	if ((cmd->input_size != sizeof(struct ras_cmd_cper_snapshot_req)) ||
+		(cmd->output_buf_size < sizeof(*output_data)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	ras_log_ring_get_batch_overview(ras_core, &overview);
@@ -206,7 +209,8 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	uint8_t *buffer;
 	int ret = 0, i, count;
 
-	if (cmd->input_size != sizeof(struct ras_cmd_cper_record_req))
+	if ((cmd->input_size != sizeof(struct ras_cmd_cper_record_req)) ||
+		(cmd->output_buf_size < sizeof(*rsp)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
@@ -264,7 +268,8 @@ static int ras_cmd_get_batch_trace_snapshot(struct ras_core_context *ras_core,
 	struct ras_log_batch_overview overview;
 
 
-	if (cmd->input_size != sizeof(struct ras_cmd_batch_trace_snapshot_req))
+	if ((cmd->input_size != sizeof(struct ras_cmd_batch_trace_snapshot_req)) ||
+		(cmd->output_buf_size < sizeof(*rsp)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	ras_log_ring_get_batch_overview(ras_core, &overview);
@@ -292,7 +297,8 @@ static int ras_cmd_get_batch_trace_records(struct ras_core_context *ras_core,
 	uint64_t id;
 	bool completed = false;
 
-	if (cmd->input_size != sizeof(struct ras_cmd_batch_trace_record_req))
+	if ((cmd->input_size != sizeof(struct ras_cmd_batch_trace_record_req)) ||
+		(cmd->output_buf_size < sizeof(*output_data)))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
 	if ((!input_data->batch_num) || (input_data->batch_num > RAS_CMD_MAX_BATCH_NUM))
@@ -423,6 +429,10 @@ static int ras_cmd_inject_error(struct ras_core_context *ras_core,
 		.value = req->method,
 	};
 
+	if ((cmd->input_size != sizeof(*req)) ||
+		(cmd->output_buf_size < sizeof(*output_data)))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
 	ret = ras_psp_trigger_error(ras_core, &block_info, req->instance_mask);
 	if (!ret) {
 		output_data->version = 0;
-- 
2.43.0

