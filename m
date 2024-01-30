Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD59EC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 11:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72549112F2E;
	Tue, 30 Jan 2024 11:09:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9FC112F2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 11:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMZn1wrTvEHHosZDEswBGZgZH3Gz29bG+U7GKB6NsgcQBidSj5trgYc2uOVkWiIgfjJ3TQX58yWFEjyNA1uS/iMfWLsCt4p3xbQTZP/pJgSmJI7cUkXIoKCCzNfvMFY6pCg75sWGn/tqM4bT5B2orGPXBNXkcrUbK1y/HNK58zwTZ1hsz0dWZPpMw+o/HRDWfH99WYS2SBdJdA3aSx77QcMcOoYycfEM895eF0Hb7DrOcaFrdFKAGetaV2gTqFrCuXp+mwOPyDYLoOv4tc2QMLulNkWd3NNtGcMNhIOI2fbDhwZRm4ynfG4+CHZcpF9LIHL/MnCJjCeM98SX7AXNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEbxyEEDg7iND43ajCaMxY6Cb75U6MCX4+NC/EmNFJ8=;
 b=RaGBsVb4GbNChC4y5McSARLU3ppo4Gi1rv0pKwfTXXfsFh4Oq6Las3qiZ9wmTxpIs+0jbsYQum9PYHomZxWL7YKoXm7NnlFJpHqBvmBgMVdx5MOOA5LhQEByfQmiAEjRIyWVseEHIK7Wx8N5SNUFD2UOWfkn4Wllo2uwH57VrbFtLTAF/AFaXHPPqrsau7dcjY5FzJKwiwrUXnyfzY/mXn5SfQSqqKYWuhJI8C++0bFSuS1uKOFD6zNKfQ0SfGSZDMXAw9CstbiPDIg3ApfPDy9CSbECPSS3xd+7rKhUoBDzDqdNkG3x3S06XOUCGL+vZ74T5GrJqhrbAXRzFw9P6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEbxyEEDg7iND43ajCaMxY6Cb75U6MCX4+NC/EmNFJ8=;
 b=t3XrkwonsM3z4L+/5/ZbuTpUTS4HpENGWjk4HWqy3wemMOsjI/qsMBj+OWY5/E5qYsJTPRSdCuxwDr/S6iE9N0CCYhwYLoCfnIgBIknjdYeCqahjNHYMSxpekeFO+WV5ql6IcuMiVPRbcS0lNqCVS2F4MmZ/vVDe1DFHEBU0weA=
Received: from MN2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:208:23c::14)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 11:09:24 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::26) by MN2PR18CA0009.outlook.office365.com
 (2603:10b6:208:23c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 11:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 11:09:24 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 05:09:23 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] add PSP RAS address query command
Date: Tue, 30 Jan 2024 19:09:13 +0800
Message-ID: <20240130110914.295366-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 5180ef08-319e-44ba-984a-08dc2183eaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsztYgwSUuBEo5GYJK+ZCULpNszF9aVi14iP2Af6CcKno+UZnhjMkMgDKgYeCaIklvtaHqCiM+Qb1SKBOA0egsS2yQBFcG225RueOSs2cRZosOACQIf6BHFAYUfeLrlOO/g0OEj/SCsViKYDyfI94Lqsk2Jxv6xpRZxQ1xwwwzkUn3EvTDDZ/Sz45mAYpAZSfgZJwE6afzLwjsjiEul84DBUnG9PrA0N5KSbYhDjmm1i031ONOH8nS+FwK5cnwGsea2PWwmWNF8bGQcfpgmR0Lx2a+q8QUe8j6ejjZ9DqXxwzhQs6Ck/WUf9WoUqavbvRsXNOkkoQM3eIyqZr7FnfPxs+mMuDiky++ovVeCdP9Dy7q7wulFbKC2G0EPuJVdpwyc/ToE2IytTiaSp3/FpRP6ArPO6QOl1PAcBgUAlLjOEyRYkMgB1AIVnS289McPE46fTK2tCV0HwQCm7Ak4RJJL3pUX/43sR2be54Zv1dseXBHse7s4F3pm1tPxvWtfdWFZl//xHPPfzcZuN4tJYzoQb31LI/x7s7IYwDJl3nmK5LrfV7R0bg6JcfYgNR364AyHZoTuNYVGYC5lWTwvZ9J69c3YK82HdVsc7KYOqyYAoOi9NCpcRyP1+5hc0Mz+fRQpI/VCvS7N9/Hftf8rOf27uToI5Q1bpzUYxXJUy5Zp31zxwVBmQF+xcVsmrvmrYrrA3izvQEPr9Rke99rbbVLZsDqin2SQcdl1y/hZGn+yCMuszsGdKWmZU9feRlhxG1i3pubQTzNQqHBfroh+wAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(26005)(40480700001)(40460700003)(16526019)(426003)(7696005)(336012)(6666004)(1076003)(83380400001)(36756003)(86362001)(82740400003)(356005)(8936002)(41300700001)(4326008)(5660300002)(36860700001)(478600001)(2616005)(316002)(47076005)(70206006)(6916009)(2906002)(81166007)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:09:24.5982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5180ef08-319e-44ba-984a-08dc2183eaf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert mca address to physical address or vice versa via RAS TA.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 25 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 36 +++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9eff8753f9b9..bb2d419fe914 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1782,6 +1782,31 @@ int psp_ras_trigger_error(struct psp_context *psp,
 
 	return 0;
 }
+
+int psp_ras_query_address(struct psp_context *psp,
+			  struct ta_ras_query_address_input *addr_in,
+			  struct ta_ras_query_address_output *addr_out)
+{
+	struct ta_ras_shared_memory *ras_cmd;
+	int ret;
+
+	if (!psp->ras_context.context.initialized)
+		return -EINVAL;
+
+	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
+	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
+
+	ras_cmd->cmd_id = TA_RAS_COMMAND__QUERY_ADDRESS;
+	ras_cmd->ras_in_message.address = *addr_in;
+
+	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
+	if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
+		return -EINVAL;
+
+	*addr_out = ras_cmd->ras_out_message.address;
+
+	return 0;
+}
 // ras end
 
 // HDCP start
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 652b0a01854a..9951bdd022de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -502,6 +502,9 @@ int psp_ras_enable_features(struct psp_context *psp,
 int psp_ras_trigger_error(struct psp_context *psp,
 			  struct ta_ras_trigger_error_input *info, uint32_t instance_mask);
 int psp_ras_terminate(struct psp_context *psp);
+int psp_ras_query_address(struct psp_context *psp,
+			  struct ta_ras_query_address_input *addr_in,
+			  struct ta_ras_query_address_output *addr_out);
 
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 879bb7af297c..056d4df8fa1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -36,6 +36,9 @@ enum ras_command {
 	TA_RAS_COMMAND__ENABLE_FEATURES = 0,
 	TA_RAS_COMMAND__DISABLE_FEATURES,
 	TA_RAS_COMMAND__TRIGGER_ERROR,
+	TA_RAS_COMMAND__QUERY_BLOCK_INFO,
+	TA_RAS_COMMAND__QUERY_SUB_BLOCK_INFO,
+	TA_RAS_COMMAND__QUERY_ADDRESS,
 };
 
 enum ta_ras_status {
@@ -105,6 +108,11 @@ enum ta_ras_error_type {
 	TA_RAS_ERROR__POISON			= 8,
 };
 
+enum ta_ras_address_type {
+	TA_RAS_MCA_TO_PA,
+	TA_RAS_PA_TO_MCA,
+};
+
 /* Input/output structures for RAS commands */
 /**********************************************************/
 
@@ -133,12 +141,38 @@ struct ta_ras_init_flags {
 	uint8_t channel_dis_num;
 };
 
+struct ta_ras_mca_addr {
+	uint64_t err_addr;
+	uint32_t ch_inst;
+	uint32_t umc_inst;
+	uint32_t node_inst;
+};
+
+struct ta_ras_phy_addr {
+	uint64_t pa;
+	uint32_t bank;
+	uint32_t channel_idx;
+};
+
+struct ta_ras_query_address_input {
+	enum ta_ras_address_type addr_type;
+	struct ta_ras_mca_addr ma;
+	struct ta_ras_phy_addr pa;
+};
+
 struct ta_ras_output_flags {
 	uint8_t ras_init_success_flag;
 	uint8_t err_inject_switch_disable_flag;
 	uint8_t reg_access_failure_flag;
 };
 
+struct ta_ras_query_address_output {
+	/* don't use the flags here */
+	struct ta_ras_output_flags flags;
+	struct ta_ras_mca_addr ma;
+	struct ta_ras_phy_addr pa;
+};
+
 /* Common input structure for RAS callbacks */
 /**********************************************************/
 union ta_ras_cmd_input {
@@ -146,12 +180,14 @@ union ta_ras_cmd_input {
 	struct ta_ras_enable_features_input	enable_features;
 	struct ta_ras_disable_features_input	disable_features;
 	struct ta_ras_trigger_error_input	trigger_error;
+	struct ta_ras_query_address_input	address;
 
 	uint32_t reserve_pad[256];
 };
 
 union ta_ras_cmd_output {
 	struct ta_ras_output_flags flags;
+	struct ta_ras_query_address_output address;
 
 	uint32_t reserve_pad[256];
 };
-- 
2.34.1

