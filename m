Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2E9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 11:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE1E10EB8A;
	Wed, 20 Apr 2022 11:14:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3998010EB8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 11:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImI/r7Sn8V4jV+i/aVBWY++JG10zMAqTYVw4cXNsrJaLw/4qoVnQxy/du7ukRZNOOjqJK2zedUW9VdrtC6tDHcfYtrAQaGl8nQZcW9JEFt6mcWcTKZ+UPZd1RpMyh9wyJSzXi/1iIBXHhTaUX0WMeemvj/18sjVHzsupHIxyUupGVtue9cQofmSCMOOHT185DI5EqjMSe7YnQZpDpR9LqtQt1YwpQFq9e5IsgzmGEfouLmNZ6/BzjFszyCgjb+xLNOpJwP+5gJGPsAGlxRIvCgAEJvuc7zO6HzseRbGcybkwTo528seR4CGCi1bs7nAY2TtB0ZDP8eud+Bfem+jx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ouk5iix1b0CzDFBlh0yEuWghv6nDFvcZswVhxyp1224=;
 b=EtkXXEgiaiNtv7tydM79RUyMDR5oOjSTI//njd/D0ScyGpX3e3KyFHsm5k4YOLrpRqfSKSTnQ0aNAS0CEU/fkx3g4by0s9XGAMNyr1X8bh8QS4206776++WYfyf0gMmTRnMa9aRniZ4m6AzVOEkJ++Bd9xTVwMVL1tRDff3d6lH/fLX3vZj2d5vHBRgEBRYq1ecLNp2cvZsdpAapJF8jdkTxFR6N9PzVgNeuQlQiILD2Y5mGntNlNGYJgSViQJKumdYhbzeaq37BhGALzcZpY6tQ/Xlr3PZOEjNtFu/7HKx1O+F0EdP7mLt/1qDN6GJS3v4IR6EbOjYmoejKVIJnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ouk5iix1b0CzDFBlh0yEuWghv6nDFvcZswVhxyp1224=;
 b=Afenx7zA/LJFvOzURc/eCDJ+un5Ocx5dCTCSnGsg28IUXUVGyiv7bSGZ68sQFA9TKkk6aW/HDiA/FSOi8cmAPuuZShPLge+W033B5bXW/udpkXLtXSvNArp4c1CE21kLTfu5vON3+Vh3YZ6JezSjIQlMIgK+SYLjwUyvkMtOYqI=
Received: from BN9PR03CA0950.namprd03.prod.outlook.com (2603:10b6:408:108::25)
 by CY4PR1201MB0215.namprd12.prod.outlook.com (2603:10b6:910:1d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Wed, 20 Apr
 2022 11:14:15 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::e7) by BN9PR03CA0950.outlook.office365.com
 (2603:10b6:408:108::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 20 Apr 2022 11:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 11:14:15 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 06:14:13 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: Use indirect buffer and save response
 status for TA load/invoke
Date: Wed, 20 Apr 2022 19:13:56 +0800
Message-ID: <20220420111357.9488-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abcc1608-48bf-4a3e-0218-08da22bee7c1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0215:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02158A3D82799FDDF957822391F59@CY4PR1201MB0215.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eqx+1b5eH6FaxGw/9RZh0hfzts7sCqzntwkz7VhJ/EH0XaOn7F3gaAvlAXhrhr3WPuDAMUu4vnsyN+Bo97VzqNslMMkGIPh20ICVhGcW0jrBajrJIVjn/dMjFZ7lBBVwiZ+o+bJdOH3C+ykNiDd88xDVtMxAdy2qMvQ3dEXORV8jTkLLPG76JrZAWFfObP066MFOythTfF0hVAhCLY4z0EeUJgD+0WAKpVcg2Za5QsQZ6bLAjy6XvvQRdDySrQAFSPHySNB9wuKbDsdGQsxCYL42XpxQCRVZ35zjNIixat9R476X5BTZWZdJJt3xFFUExpXi5SGOi2PGvtz+W1VJZi4GHPCnut0k5NPZIQ3OrCKUX8Qk0LstHQekAWGFX81GalqgEcHkZDOadFVUCVR7FIeDb00m+uYgeqf3S5Doh/cs3G9r9PEb7lvfCLBi2AeKKAEv14qR0Ja+CXoJJamQ+AGabglk2AFPm292hPL1ZzXKvNyYHVPB6blwKS0LDO36pg6c2d23PT8RcGNH8m8QqL6Cf+utWiqTv665bEtLXdHzDMxfuNNRo0d0yu/1jNlJUVHHmBQvI8sAWTXCHS6Nmm1oHAVXm+CEyP0qACgUv/7K/kkGp6+1WK96TCe5tTp98+gIEM9G9CyO/YhF57O4REGc3Mq/F1/rNzDO91kON4OYW0i62YKHzrNZtCA6Gp7arE21zWpat288y1BpTK/BGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(40460700003)(316002)(26005)(54906003)(508600001)(7696005)(83380400001)(2906002)(36756003)(5660300002)(44832011)(186003)(86362001)(6666004)(16526019)(426003)(82310400005)(36860700001)(1076003)(356005)(8676002)(4326008)(2616005)(47076005)(6916009)(336012)(70586007)(70206006)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:14:15.3194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abcc1608-48bf-4a3e-0218-08da22bee7c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0215
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
Cc: Candice Li <candice.li@amd.com>, John Clements <john.clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The upcoming TA debugfs interface needs to use indirect buffer
when performing TA invoke and check psp response status for TA
load and invoke.

Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 54 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 26 ++++++++++++
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a6acec1a6155d0..f6527aa19238a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -46,8 +46,6 @@ static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
 
 static int psp_load_smu_fw(struct psp_context *psp);
-static int psp_ta_unload(struct psp_context *psp, struct ta_context *context);
-static int psp_ta_load(struct psp_context *psp, struct ta_context *context);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
 
@@ -862,7 +860,7 @@ static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 	cmd->cmd.cmd_unload_ta.session_id = session_id;
 }
 
-static int psp_ta_unload(struct psp_context *psp, struct ta_context *context)
+int psp_ta_unload(struct psp_context *psp, struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
@@ -944,7 +942,7 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 	cmd->cmd.cmd_load_ta.cmd_buf_len = context->mem_context.shared_mem_size;
 }
 
-static int psp_ta_init_shared_buf(struct psp_context *psp,
+int psp_ta_init_shared_buf(struct psp_context *psp,
 				  struct ta_mem_context *mem_ctx)
 {
 	/*
@@ -958,7 +956,7 @@ static int psp_ta_init_shared_buf(struct psp_context *psp,
 				      &mem_ctx->shared_buf);
 }
 
-static void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
+void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
 {
 	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
 			      &mem_ctx->shared_buf);
@@ -969,6 +967,42 @@ static int psp_xgmi_init_shared_buf(struct psp_context *psp)
 	return psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context);
 }
 
+static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp *cmd,
+				       uint32_t ta_cmd_id,
+				       struct ta_context *context)
+{
+	cmd->cmd_id                         = GFX_CMD_ID_INVOKE_CMD;
+	cmd->cmd.cmd_invoke_cmd.session_id  = context->session_id;
+	cmd->cmd.cmd_invoke_cmd.ta_cmd_id   = ta_cmd_id;
+
+	cmd->cmd.cmd_invoke_cmd.buf.num_desc   = 1;
+	cmd->cmd.cmd_invoke_cmd.buf.total_size = context->mem_context.shared_mem_size;
+	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_size = context->mem_context.shared_mem_size;
+	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_lo =
+				     lower_32_bits(context->mem_context.shared_mc_addr);
+	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_hi =
+				     upper_32_bits(context->mem_context.shared_mc_addr);
+}
+
+int psp_ta_invoke_indirect(struct psp_context *psp,
+		  uint32_t ta_cmd_id,
+		  struct ta_context *context)
+{
+	int ret;
+	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
+
+	psp_prep_ta_invoke_indirect_cmd_buf(cmd, ta_cmd_id, context);
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd,
+				 psp->fence_buf_mc_addr);
+
+	context->resp_status = cmd->resp.status;
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				       uint32_t ta_cmd_id,
 				       uint32_t session_id)
@@ -978,7 +1012,7 @@ static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 	cmd->cmd.cmd_invoke_cmd.ta_cmd_id	= ta_cmd_id;
 }
 
-static int psp_ta_invoke(struct psp_context *psp,
+int psp_ta_invoke(struct psp_context *psp,
 		  uint32_t ta_cmd_id,
 		  struct ta_context *context)
 {
@@ -990,12 +1024,14 @@ static int psp_ta_invoke(struct psp_context *psp,
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
 
+	context->resp_status = cmd->resp.status;
+
 	release_psp_cmd_buf(psp);
 
 	return ret;
 }
 
-static int psp_ta_load(struct psp_context *psp, struct ta_context *context)
+int psp_ta_load(struct psp_context *psp, struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
@@ -1010,6 +1046,8 @@ static int psp_ta_load(struct psp_context *psp, struct ta_context *context)
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
 
+	context->resp_status = cmd->resp.status;
+
 	if (!ret) {
 		context->session_id = cmd->resp.session_id;
 	}
@@ -1415,7 +1453,7 @@ int psp_ras_enable_features(struct psp_context *psp,
 	return 0;
 }
 
-static int psp_ras_terminate(struct psp_context *psp)
+int psp_ras_terminate(struct psp_context *psp)
 {
 	int ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index ff7d533eb746ce..cf8d3199b35bf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -48,6 +48,17 @@ enum psp_shared_mem_size {
 	PSP_SECUREDISPLAY_SHARED_MEM_SIZE	= 0x4000,
 };
 
+enum ta_type_id {
+	TA_TYPE_XGMI = 1,
+	TA_TYPE_RAS,
+	TA_TYPE_HDCP,
+	TA_TYPE_DTM,
+	TA_TYPE_RAP,
+	TA_TYPE_SECUREDISPLAY,
+
+	TA_TYPE_MAX_INDEX,
+};
+
 struct psp_context;
 struct psp_xgmi_node_info;
 struct psp_xgmi_topology_info;
@@ -151,9 +162,11 @@ struct ta_mem_context {
 struct ta_context {
 	bool			initialized;
 	uint32_t		session_id;
+	uint32_t		resp_status;
 	struct ta_mem_context	mem_context;
 	struct psp_bin_desc		bin_desc;
 	enum psp_gfx_cmd_id		ta_load_type;
+	enum ta_type_id		ta_type;
 };
 
 struct ta_cp_context {
@@ -407,6 +420,18 @@ int psp_gpu_reset(struct amdgpu_device *adev);
 int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 			uint64_t cmd_gpu_addr, int cmd_size);
 
+int psp_ta_init_shared_buf(struct psp_context *psp,
+				  struct ta_mem_context *mem_ctx);
+void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx);
+int psp_ta_unload(struct psp_context *psp, struct ta_context *context);
+int psp_ta_load(struct psp_context *psp, struct ta_context *context);
+int psp_ta_invoke(struct psp_context *psp,
+			uint32_t ta_cmd_id,
+			struct ta_context *context);
+int psp_ta_invoke_indirect(struct psp_context *psp,
+		  uint32_t ta_cmd_id,
+		  struct ta_context *context);
+
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
 int psp_xgmi_terminate(struct psp_context *psp);
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
@@ -425,6 +450,7 @@ int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable);
 int psp_ras_trigger_error(struct psp_context *psp,
 			  struct ta_ras_trigger_error_input *info);
+int psp_ras_terminate(struct psp_context *psp);
 
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
-- 
2.17.1

