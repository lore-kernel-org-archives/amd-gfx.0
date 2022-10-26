Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03485C38A02
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 00:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFD310E204;
	Wed, 26 Oct 2022 00:51:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0009810E1EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 00:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogHeaIl8L8ttK2ElCm9aPc4KIaDpu7p4jZaa36LuoOsRkaWESp9fZEUM9trc3z3R8MnUxlRm8mzNOLOlfqZww0A8Ilm8/d/vZ1H6BEAcNDIKgGQPRR8ykOdxHpLhy3bbu/a44YBVzXuXtVs+bZ2pZ9rjPvhDHS2qtiZqUdPxWquEiSJF5EokODPT0dU2xZnBwN6tW/O8F+Xuypd2LlmkbbOD0p84fEMN2mXZkJpNuf8e/Rtiqvo/Dsd97eUwKpU3VBHZarJwNC2GOFRTxAC05UrHs9CuhwFzTQvR3JpwoKxWwqlNt127KChpG8SiWDxmEKTJ7VBE5o0TrJ2Md8ICwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70e5uiN2FUMYy3tBqP+gZThqt4sGTtxugvorjonuvug=;
 b=AJcdS3dTR/FtXKXjwhgw/MeFy/dNP9TueRIkJu2Z/YBsiLGWVhR1q/qgTT4+Rr49fzxY2pBn9oJGHTbgqzDyqCSSJ89ocVOMjLDxZrAKzBwS6xJriY/zmxJ7TxctsgZl3oDLHqJfVDJywVW7jIp48LlUMEN2CYmeoPw45PRZD2pVdfMWMiCEmKtTceUjjNmBO4UrtsnFwRyedSbxQKW3jbKR03Bc7meWhZsAAzYC5srmwF7xhq4IxFzSwczaQ63mNuxiIzTkik3h77+QYF7JcyNDT5hMxskxY7HyPJdKEDIN/zQQhBsUVqKw6zviMIMsiY8OWV/6kyktrYcKMNzDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70e5uiN2FUMYy3tBqP+gZThqt4sGTtxugvorjonuvug=;
 b=e+/BG6qZLHotWbQWID9Qc4FmH149WM2izvuAQ8gqroVz1nk17bgvt+nzIYaH1jj12spoU9kAInt0hBQnYn0k7MUYr9MTux/L4Zu3o+LGJgfRzWs7PTYNMlaN8d8QkIbylLbSRB+M1+ZkcNBYof/HesklRjUymb5PPrSUm/WuvF0=
Received: from MW3PR06CA0018.namprd06.prod.outlook.com (2603:10b6:303:2a::23)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 00:51:26 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::4f) by MW3PR06CA0018.outlook.office365.com
 (2603:10b6:303:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 00:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 00:51:24 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 19:51:22 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Optimize TA load/unload/invoke debugfs
 interfaces
Date: Wed, 26 Oct 2022 08:50:59 +0800
Message-ID: <20221026005059.26249-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: a2edb34e-ddd4-498f-6073-08dab6ec3535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74DKhZYxyQ5AjV7JuYkZBakOFB1mbubfMGG0NEy0Ez0ecG6dCO96xTHm2xQmjxcsv49+7hTdvqzVw8UFunOGO2KQXsi/E6dz9KQ3H8LaDMmwhim4SQKrX/H3wc/jXcdbT1zh7lYQoWin10/Iw2Vx3oZEXyzRaFUd+sQzn+dTSzhDiUoAqUxz0V+LfFuU5jD5SepG+vDZzj+hDCQxIzlrmA7XDIv9VIc/awHVOGlrmkWpu0Af7nXmxK+UqlLIeEGWSoDmaJ/lOoc+kXtk9EDisefadv7PjZ+XBMbjoWfcVeOv28DPh4ssrobyewpvM3fr613sMC2KhxgRTiaH2l4sLn2/ekaV+TktFAv2P8hOOkeMziN/2RnotQ3NwB2Hx+ZDXodycP8i+67amsa5SmI8Gl/AcfggYhR3ERVFJBUtLAVKOY5dv6EmnMGRO4xkw2Wwu476SVQqd3vMGIieL0OiOxm3vGPTt9PqnOO/R39xGlZt2wuJAlk4bgCyIPSrODvxM+7CBU8qyLdpOnINrMfwUic53VPCl57zxQJdUEUH70BAApDckx6GblelAZP96FKwh2EHOJ+Zg1d7gorW10PsfdI1Mvy6bXk84hppZ+LU8xVc3rq0bwbcLQHzbXb4XgIWEHP6z+AghAh0GSiiLPBlDgW4/GocR3gcXmERjswuT4sTm28tRUB6Ju3OeS6z+UfjJ7zeSXiq4dUDiTAkDn1nI4vJBIzZQVL14JKwvfJ3EwL9QCtCoabWS5p1lRMzr9SyjKJ6+AZwwFuIOiGCMY7H2al8y3zxz1TDgvke1oS8Li1E7jHtkSU6bY/NLSGoEB+4E4mhZkz7LpeKfwmS8KXSvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(316002)(478600001)(36860700001)(6916009)(70206006)(4326008)(70586007)(7696005)(8676002)(6666004)(186003)(41300700001)(8936002)(356005)(2616005)(30864003)(44832011)(2906002)(336012)(5660300002)(26005)(16526019)(1076003)(36756003)(47076005)(426003)(83380400001)(82740400003)(81166007)(82310400005)(40460700003)(40480700001)(86362001)(461764006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 00:51:24.6011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2edb34e-ddd4-498f-6073-08dab6ec3535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Add a function pointer structure ta_funcs to psp context
2. Make the interfaces generic to all TAs
3. Leverage exisitng TA context and remove unused functions
4. Fix return code bugs

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  38 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 217 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h |   4 +
 4 files changed, 167 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 643810c4148120..cdb0605d04f7cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1071,42 +1071,6 @@ int psp_ta_init_shared_buf(struct psp_context *psp,
 				      &mem_ctx->shared_buf);
 }
 
-static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp *cmd,
-				       uint32_t ta_cmd_id,
-				       struct ta_context *context)
-{
-	cmd->cmd_id                         = GFX_CMD_ID_INVOKE_CMD;
-	cmd->cmd.cmd_invoke_cmd.session_id  = context->session_id;
-	cmd->cmd.cmd_invoke_cmd.ta_cmd_id   = ta_cmd_id;
-
-	cmd->cmd.cmd_invoke_cmd.buf.num_desc   = 1;
-	cmd->cmd.cmd_invoke_cmd.buf.total_size = context->mem_context.shared_mem_size;
-	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_size = context->mem_context.shared_mem_size;
-	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_lo =
-				     lower_32_bits(context->mem_context.shared_mc_addr);
-	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_hi =
-				     upper_32_bits(context->mem_context.shared_mc_addr);
-}
-
-int psp_ta_invoke_indirect(struct psp_context *psp,
-		  uint32_t ta_cmd_id,
-		  struct ta_context *context)
-{
-	int ret;
-	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_invoke_indirect_cmd_buf(cmd, ta_cmd_id, context);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd,
-				 psp->fence_buf_mc_addr);
-
-	context->resp_status = cmd->resp.status;
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
-}
-
 static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				       uint32_t ta_cmd_id,
 				       uint32_t session_id)
@@ -1549,7 +1513,7 @@ int psp_ras_terminate(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_ras_initialize(struct psp_context *psp)
+int psp_ras_initialize(struct psp_context *psp)
 {
 	int ret;
 	uint32_t boot_cfg = 0xFF;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 58ce3ebb446cf8..edc266f65b4e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -136,6 +136,12 @@ struct psp_funcs
 	int (*vbflash_stat)(struct psp_context *psp);
 };
 
+struct ta_funcs {
+	int (*fn_ta_initialze)(struct psp_context *psp);
+	int (*fn_ta_invoke)(struct psp_context *psp, uint32_t ta_cmd_id);
+	int (*fn_ta_terminate)(struct psp_context *psp);
+};
+
 #define AMDGPU_XGMI_MAX_CONNECTED_NODES		64
 struct psp_xgmi_node_info {
 	uint64_t				node_id;
@@ -309,6 +315,7 @@ struct psp_context
 	struct psp_gfx_cmd_resp		*cmd;
 
 	const struct psp_funcs		*funcs;
+	const struct ta_funcs		*ta_funcs;
 
 	/* firmware buffer */
 	struct amdgpu_bo		*fw_pri_bo;
@@ -463,9 +470,6 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context);
 int psp_ta_invoke(struct psp_context *psp,
 			uint32_t ta_cmd_id,
 			struct ta_context *context);
-int psp_ta_invoke_indirect(struct psp_context *psp,
-		  uint32_t ta_cmd_id,
-		  struct ta_context *context);
 
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
 int psp_xgmi_terminate(struct psp_context *psp);
@@ -479,7 +483,7 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 int psp_xgmi_set_topology_info(struct psp_context *psp,
 			       int number_devices,
 			       struct psp_xgmi_topology_info *topology);
-
+int psp_ras_initialize(struct psp_context *psp);
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 0988e00612e515..93e1c07861e47b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -41,30 +41,46 @@ static uint32_t get_bin_version(const uint8_t *bin)
 	return hdr->ucode_version;
 }
 
-static void prep_ta_mem_context(struct psp_context *psp,
-					     struct ta_context *context,
+static int prep_ta_mem_context(struct ta_mem_context *mem_context,
 					     uint8_t *shared_buf,
 					     uint32_t shared_buf_len)
 {
-	context->mem_context.shared_mem_size = PAGE_ALIGN(shared_buf_len);
-	psp_ta_init_shared_buf(psp, &context->mem_context);
+	if (mem_context->shared_mem_size < shared_buf_len)
+		return -EINVAL;
+	memset(mem_context->shared_buf, 0, mem_context->shared_mem_size);
+	memcpy((void *)mem_context->shared_buf, shared_buf, shared_buf_len);
 
-	memcpy((void *)context->mem_context.shared_buf, shared_buf, shared_buf_len);
+	return 0;
 }
 
 static bool is_ta_type_valid(enum ta_type_id ta_type)
 {
-	bool ret = false;
+	switch (ta_type) {
+	case TA_TYPE_RAS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct ta_funcs ras_ta_funcs = {
+	.fn_ta_initialze = psp_ras_initialize,
+	.fn_ta_invoke    = psp_ras_invoke,
+	.fn_ta_terminate = psp_ras_terminate
+};
 
+static void set_ta_context_funcs(struct psp_context *psp,
+						      enum ta_type_id ta_type,
+						      struct ta_context **pcontext)
+{
 	switch (ta_type) {
 	case TA_TYPE_RAS:
-		ret = true;
+		*pcontext = &psp->ras_context.context;
+		psp->ta_funcs = &ras_ta_funcs;
 		break;
 	default:
 		break;
 	}
-
-	return ret;
 }
 
 static const struct file_operations ta_load_debugfs_fops = {
@@ -85,8 +101,7 @@ static const struct file_operations ta_invoke_debugfs_fops = {
 	.owner  = THIS_MODULE
 };
 
-
-/**
+/*
  * DOC: AMDGPU TA debugfs interfaces
  *
  * Three debugfs interfaces can be opened by a program to
@@ -111,15 +126,18 @@ static const struct file_operations ta_invoke_debugfs_fops = {
  *
  * - For TA invoke debugfs interface:
  *   Transmit buffer:
+ *    - TA type (4bytes)
  *    - TA ID (4bytes)
  *    - TA CMD ID (4bytes)
- *    - TA shard buf length (4bytes)
+ *    - TA shard buf length
+ *      (4bytes, value not beyond TA shared memory size)
  *    - TA shared buf
  *   Receive buffer:
  *    - TA shared buf
  *
  * - For TA unload debugfs interface:
  *   Transmit buffer:
+ *    - TA type (4bytes)
  *    - TA ID (4bytes)
  */
 
@@ -131,59 +149,92 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 	uint32_t copy_pos   = 0;
 	int      ret        = 0;
 
-	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
-	struct psp_context   *psp    = &adev->psp;
-	struct ta_context    context = {0};
+	struct amdgpu_device *adev    = (struct amdgpu_device *)file_inode(fp)->i_private;
+	struct psp_context   *psp     = &adev->psp;
+	struct ta_context    *context = NULL;
 
 	if (!buf)
 		return -EINVAL;
 
 	ret = copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t));
 	if (ret || (!is_ta_type_valid(ta_type)))
-		return -EINVAL;
+		return -EFAULT;
 
 	copy_pos += sizeof(uint32_t);
 
 	ret = copy_from_user((void *)&ta_bin_len, &buf[copy_pos], sizeof(uint32_t));
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
 
 	copy_pos += sizeof(uint32_t);
 
 	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
 	if (!ta_bin)
-		ret = -ENOMEM;
+		return -ENOMEM;
 	if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
 		ret = -EFAULT;
 		goto err_free_bin;
 	}
 
-	ret = psp_ras_terminate(psp);
-	if (ret) {
-		dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
+	/* Set TA context and functions */
+	set_ta_context_funcs(psp, ta_type, &context);
+
+	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_terminate) {
+		dev_err(adev->dev, "Unsupported function to terminate TA\n");
+		ret = -EOPNOTSUPP;
 		goto err_free_bin;
 	}
 
-	context.ta_type             = ta_type;
-	context.ta_load_type        = GFX_CMD_ID_LOAD_TA;
-	context.bin_desc.fw_version = get_bin_version(ta_bin);
-	context.bin_desc.size_bytes = ta_bin_len;
-	context.bin_desc.start_addr = ta_bin;
+	/*
+	 * Allocate TA shared buf in case shared buf was freed
+	 * due to loading TA failed before.
+	 */
+	if (!context->mem_context.shared_buf) {
+		ret = psp_ta_init_shared_buf(psp, &context->mem_context);
+		if (ret) {
+			ret = -ENOMEM;
+			goto err_free_bin;
+		}
+	}
+
+	ret = psp_fn_ta_terminate(psp);
+	if (ret || context->resp_status) {
+		dev_err(adev->dev,
+			"Failed to unload embedded TA (%d) and status (0x%X)\n",
+			ret, context->resp_status);
+		if (!ret)
+			ret = -EINVAL;
+		goto err_free_ta_shared_buf;
+	}
+
+	/* Prepare TA context for TA initialization */
+	context->ta_type                     = ta_type;
+	context->bin_desc.fw_version         = get_bin_version(ta_bin);
+	context->bin_desc.size_bytes         = ta_bin_len;
+	context->bin_desc.start_addr         = ta_bin;
 
-	ret = psp_ta_load(psp, &context);
+	if (!psp->ta_funcs->fn_ta_initialze) {
+		dev_err(adev->dev, "Unsupported function to initialize TA\n");
+		ret = -EOPNOTSUPP;
+		goto err_free_ta_shared_buf;
+	}
 
-	if (ret || context.resp_status) {
-		dev_err(adev->dev, "TA load via debugfs failed (%d) status %d\n",
-			 ret, context.resp_status);
+	ret = psp_fn_ta_initialize(psp);
+	if (ret || context->resp_status) {
+		dev_err(adev->dev, "Failed to load TA via debugfs (%d) and status (0x%X)\n",
+			ret, context->resp_status);
 		if (!ret)
 			ret = -EINVAL;
-		goto err_free_bin;
+		goto err_free_ta_shared_buf;
 	}
 
-	context.initialized = true;
-	if (copy_to_user((char *)buf, (void *)&context.session_id, sizeof(uint32_t)))
+	if (copy_to_user((char *)buf, (void *)&context->session_id, sizeof(uint32_t)))
 		ret = -EFAULT;
 
+err_free_ta_shared_buf:
+	/* Only free TA shared buf when returns error code */
+	if (ret && context->mem_context.shared_buf)
+		psp_ta_free_shared_buf(&context->mem_context);
 err_free_bin:
 	kfree(ta_bin);
 
@@ -192,58 +243,85 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 
 static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
 {
-	uint32_t ta_id  = 0;
-	int      ret    = 0;
+	uint32_t ta_type    = 0;
+	uint32_t ta_id      = 0;
+	uint32_t copy_pos   = 0;
+	int      ret        = 0;
 
-	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
-	struct psp_context   *psp    = &adev->psp;
-	struct ta_context    context = {0};
+	struct amdgpu_device *adev    = (struct amdgpu_device *)file_inode(fp)->i_private;
+	struct psp_context   *psp     = &adev->psp;
+	struct ta_context    *context = NULL;
 
 	if (!buf)
 		return -EINVAL;
 
-	ret = copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
+	ret = copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t));
+	if (ret || (!is_ta_type_valid(ta_type)))
+		return -EFAULT;
+
+	copy_pos += sizeof(uint32_t);
+
+	ret = copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint32_t));
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
 
-	context.session_id = ta_id;
+	set_ta_context_funcs(psp, ta_type, &context);
+	context->session_id = ta_id;
 
-	ret = psp_ta_unload(psp, &context);
-	if (!ret)
-		context.initialized = false;
+	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_terminate) {
+		dev_err(adev->dev, "Unsupported function to terminate TA\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = psp_fn_ta_terminate(psp);
+	if (ret || context->resp_status) {
+		dev_err(adev->dev, "Failed to unload TA via debugfs (%d) and status (0x%X)\n",
+			ret, context->resp_status);
+		if (!ret)
+			ret = -EINVAL;
+	}
+
+	if (context->mem_context.shared_buf)
+		psp_ta_free_shared_buf(&context->mem_context);
 
 	return ret;
 }
 
 static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
 {
+	uint32_t ta_type        = 0;
 	uint32_t ta_id          = 0;
 	uint32_t cmd_id         = 0;
 	uint32_t shared_buf_len = 0;
-	uint8_t	 *shared_buf    = NULL;
+	uint8_t *shared_buf     = NULL;
 	uint32_t copy_pos       = 0;
 	int      ret            = 0;
 
-	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
-	struct psp_context   *psp    = &adev->psp;
-	struct ta_context    context = {0};
+	struct amdgpu_device *adev    = (struct amdgpu_device *)file_inode(fp)->i_private;
+	struct psp_context   *psp     = &adev->psp;
+	struct ta_context    *context = NULL;
 
 	if (!buf)
 		return -EINVAL;
 
+	ret = copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t));
+	if (ret)
+		return -EFAULT;
+	copy_pos += sizeof(uint32_t);
+
 	ret = copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint32_t));
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
 	copy_pos += sizeof(uint32_t);
 
 	ret = copy_from_user((void *)&cmd_id, &buf[copy_pos], sizeof(uint32_t));
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
 	copy_pos += sizeof(uint32_t);
 
 	ret = copy_from_user((void *)&shared_buf_len, &buf[copy_pos], sizeof(uint32_t));
 	if (ret)
-		return -EINVAL;
+		return -EFAULT;
 	copy_pos += sizeof(uint32_t);
 
 	shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
@@ -254,26 +332,39 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 		goto err_free_shared_buf;
 	}
 
-	context.session_id = ta_id;
+	set_ta_context_funcs(psp, ta_type, &context);
+
+	if (!context->initialized) {
+		dev_err(adev->dev, "TA is not initialized\n");
+		ret = -EINVAL;
+		goto err_free_shared_buf;
+	}
+
+	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_invoke) {
+		dev_err(adev->dev, "Unsupported function to invoke TA\n");
+		ret = -EOPNOTSUPP;
+		goto err_free_shared_buf;
+	}
 
-	prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
+	context->session_id = ta_id;
 
-	ret = psp_ta_invoke_indirect(psp, cmd_id, &context);
+	ret = prep_ta_mem_context(&context->mem_context, shared_buf, shared_buf_len);
+	if (ret)
+		goto err_free_shared_buf;
 
-	if (ret || context.resp_status) {
-		dev_err(adev->dev, "TA invoke via debugfs failed (%d) status %d\n",
-			 ret, context.resp_status);
-		if (!ret)
+	ret = psp_fn_ta_invoke(psp, cmd_id);
+	if (ret || context->resp_status) {
+		dev_err(adev->dev, "Failed to invoke TA via debugfs (%d) and status (0x%X)\n",
+			ret, context->resp_status);
+		if (!ret) {
 			ret = -EINVAL;
-		goto err_free_ta_shared_buf;
+			goto err_free_shared_buf;
+		}
 	}
 
-	if (copy_to_user((char *)buf, context.mem_context.shared_buf, shared_buf_len))
+	if (copy_to_user((char *)buf, context->mem_context.shared_buf, shared_buf_len))
 		ret = -EFAULT;
 
-err_free_ta_shared_buf:
-	psp_ta_free_shared_buf(&context.mem_context);
-
 err_free_shared_buf:
 	kfree(shared_buf);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
index cfc1542f63ef94..21f043bd3cbfff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
@@ -24,6 +24,10 @@
 #ifndef __AMDGPU_PSP_TA_H__
 #define __AMDGPU_PSP_TA_H__
 
+#define psp_fn_ta_initialize(psp) ((psp)->ta_funcs->fn_ta_initialze((psp)))
+#define psp_fn_ta_invoke(psp, ta_cmd_id) ((psp)->ta_funcs->fn_ta_invoke((psp), (ta_cmd_id)))
+#define psp_fn_ta_terminate(psp) ((psp)->ta_funcs->fn_ta_terminate((psp)))
+
 void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.17.1

