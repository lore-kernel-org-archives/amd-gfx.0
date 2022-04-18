Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7862EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Apr 2022 03:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA74010EAB7;
	Mon, 18 Apr 2022 03:10:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6204910EAB7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 03:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDRiTWh6OyotgkfCbGtQrScIzFjyCixKkS8haECCDhXmTo/YyVK9L706jxDkaYTv4aF8C02YfFjGX8Lp3kRwis7AKAX0GK5xPulbnzSpM6njKN8mpt1zoc1IVFpNEoLy5Zf/kRTNNKjZ5M8LaJNNqAatImDsed2jYE1JYYYkq8DzPSsGhe1vRdxjVU2bjpIBusbhOI6a+uHPJwMdyYs7wjGgGPhOKAHGfTcrdQMqw3VruC6XnDMUd5KCkA8VS4DQENk+5EJjOJpQFmrnOoAT3DBz6QSqp+KuD+4VjHbJTUQkIyfaoXLLar0Z1TGLkIvjz5HXi2zTU6J3kTw+i+JOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymhmo1DNFoR6HdSLYrCrWWIt4cQiXspGsNiu4XVd4OU=;
 b=KsteYEhRAz3zBChpQGzWQmYIcQfQiX7JRah+f3qLXUpQIy94WVSoU1UT+xEKs6+9byTIBLKwkqIFho32QoY4el5+EKXcs8J4kIstUOcIly1hM7rL4itbkEdNnWIpka5rkUz4oJQGH8PaP1gsv2qXz4eYX3h/MndN2poe2Ys9VGfpeHYIn/kcjJnzIJgqrIDfX6PgXRI9f05z+gHNi/aJIGe15DO6sKcJHHIWR30ZG7VDmL5WKAkicjTVK/3Zga4ZQm0QrBGzWX3g3bAJ0RbF3wzlVX/07+2Jep5YfuYKoWnazkwa0rDzbPhWwTo2DFe3kKUyz1vBhwo3Rio2A4U6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymhmo1DNFoR6HdSLYrCrWWIt4cQiXspGsNiu4XVd4OU=;
 b=RAGko8iv837owd42nU0hcPhE4OWawTmx5rQX60G5WSbTzw1zkge/phhwlARKIKrbouQFxc/vEDIFbpW5qZEL9jxl+zJhXay+r3ghuEDdmAnUrDjg3maBkeNG8Ml/QG0z+XUIv6bJZpFELVA2p4OA4XdpgrCtaL41J2+Q7LgF8qI=
Received: from MWH0EPF00056D1A.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:17) by DM6PR12MB2777.namprd12.prod.outlook.com
 (2603:10b6:5:51::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Mon, 18 Apr
 2022 03:09:56 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by MWH0EPF00056D1A.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.11 via Frontend
 Transport; Mon, 18 Apr 2022 03:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 03:09:55 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 17 Apr
 2022 22:09:53 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Use indirect buffer and save response status
 for TA load/invoke
Date: Mon, 18 Apr 2022 11:09:26 +0800
Message-ID: <20220418030927.11320-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ff3e51-bcb3-4120-cdca-08da20e8e9fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB2777:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27779BB422B0B2EFDC9EA47791F39@DM6PR12MB2777.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Vi/eChiNmucuypgR14mAXmPNkHX02jaUYvcON3N9JJy5xPWVMxKorC/EE8aRhN3ZQiRMqM5myRx1LilZbffomgQTsYG6eitCe/jWGUxXv0/AFf5TXP722mFavnGcoaBXKugkiEy3++Afga8o5229SZmbikIdvEMM0x07+WyVbfkgyakAHKCgANqxXf/j4BdO0zahbwYMGlf90oK5kin4CZa9gTFUVIAKR9pa2YcrBCJ+J4dk9JMWBBN8Ul/Mt38Hs91TIZlhjzHGu7KecxdcEnA4g1VgTnBjq7gCq/GW2Lhr3jN+NRLI8VVXohB3qpl9Dl/WIxrZ8exxLS/H0pk+Kt3BpLB3vj/bqLQ5xh4rHp5FZoO4J/2Zyxt+GoNHIlOFkofnEN294oZyTNIdI0eMeYOhM5Vmdf8cyDwYMTuvqXrlxn1D7tAFWH9dHcYT3YeJUqRiHIrV+zGpaswzEnAvcJGgJdSAFi1WbW6F2slKqTJ3kLyyH4HCHtR4eaeRaQdIDQmUDj0kc1v2SjGcGbX7dQvlAT9cp0P58il4xJKkPrmeWV8ymU+up8NiLx/tUJ48LspoPo8Ysto9LPKeF/K7soeF3GUqGjfkDQUyVA8cWgkw8o81bVX27okrTSew62ymrtarxp5ETjScdjORjAR9nwWXjz8+b21nDnKkJa0lgZ1wq4jUTrKaH0iXBOmG0WFAi+FqiwYA3ksnPyZ94bnnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(47076005)(44832011)(508600001)(70206006)(426003)(2616005)(336012)(81166007)(6666004)(8676002)(26005)(16526019)(8936002)(186003)(83380400001)(5660300002)(316002)(2906002)(36860700001)(1076003)(356005)(70586007)(54906003)(6916009)(7696005)(40460700003)(86362001)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 03:09:55.4566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ff3e51-bcb3-4120-cdca-08da20e8e9fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2777
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 60 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 26 +++++++++++
 2 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a6acec1a6155d0..cb7e081b1ef426 100644
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
@@ -1415,16 +1453,10 @@ int psp_ras_enable_features(struct psp_context *psp,
 	return 0;
 }
 
-static int psp_ras_terminate(struct psp_context *psp)
+int psp_ras_terminate(struct psp_context *psp)
 {
 	int ret;
 
-	/*
-	 * TODO: bypass the terminate in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
 	if (!psp->ras_context.context.initialized)
 		return 0;
 
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

