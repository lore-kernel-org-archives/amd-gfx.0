Return-Path: <SRS0=CFUU=N4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DCBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 08:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2A660F45
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 08:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C2A660F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0591C89AEB;
	Mon,  6 Sep 2021 08:34:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3D689AEB
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Sep 2021 08:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDV8pP37ttaFcC6xJNYxPhHu/LCy6MVn1IQ+udMxjVZTpqrbC6DwHFNlE1sT5Kgj9dtv86EThhL3GKMVtAme7qz3rkqUvhDDPfkVEbgQApPR3HPI/Ul6jz6LX+aUyiVCne4I0Xf3LV3QqNw2bBAAMAFwM3WzmIqaieXtKhnyFvkOONUWkS+PDejNlhp0nonvvMtdvB8BARffoZpd4oI8j9WEWQW8lssYpyVlGXJTYkPMBbzhY7q8uLxy8fwQjUKKZlT76kaVgfLAuelR6KZJmkuJV6FB1B+cC/ApeD9bUWXvaUopxlxCUNpxiJ+EjXdbBE+kRJ4AEPTxqGfc+NbF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=cUm1NzQUCbjWICLC03PQiDVN47B9N01aTaEk6va/+f4=;
 b=n3GjkPY99XyhuB496UsxQygPhGHAdQXi1XFLYhRoUEtztGm0GuZTAIAYL4BuOf+dad7WR8TtvOTDEg3O6SeHnbfDdY9MrURcALVs1eFdEpViFcfihTQT3IcsDw24LrLTg/jLJ7DO3BodjCp1fO4G1PzFbSlhe3dGCjk+yA/HGBgDb3dxaUGFO7TrQqaVrsoJDz/3Ngi1pgsyxbLFU10RhdpXiFpMmKgndubtnlPgDohdtiAK1yyty5xrRTFu6ypXxH/FGTTQ3qJeIN73kjUcp8+loGEbbr1Oo7p2y50bo/W4h7p/tWjYDE9jBgFppUDm+TIlXwrhYHccVl1K9UFeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUm1NzQUCbjWICLC03PQiDVN47B9N01aTaEk6va/+f4=;
 b=G8p3r31PaOCLoucbAPeiKTfh+8rlOsBC38FIi8w3Gscxeo0hTaXePfiSvfWSlLsfVg6etBBjeD2lOr+UDUgHrJpWP7AykX9kiSXD+p5FJhZqsUtX9IexEa9B0yb2BrGJtCSCJy4GGT4S6Ys7Jqj32WvpFzY4Kk/2zAkldJ8BZNw=
Received: from DM5PR06CA0091.namprd06.prod.outlook.com (2603:10b6:3:4::29) by
 CY4PR12MB1749.namprd12.prod.outlook.com (2603:10b6:903:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Mon, 6 Sep
 2021 08:34:27 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::fc) by DM5PR06CA0091.outlook.office365.com
 (2603:10b6:3:4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Mon, 6 Sep 2021 08:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 08:34:26 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 6 Sep 2021
 03:34:24 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Create common PSP TA load function
Date: Mon, 6 Sep 2021 16:34:12 +0800
Message-ID: <20210906083412.27473-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6877f0fd-5eab-4f81-9008-08d971112333
X-MS-TrafficTypeDiagnostic: CY4PR12MB1749:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1749D20A7A9FB998D6ED742F91D29@CY4PR12MB1749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqjllDZQWiH+9fkPiksPzjVOXyjhO4RAKY5ErwYpN+LHcaVdd07nuSGd9u7SQRZHdkxDxJJuIru41gD746mE0KvqQGkcI4eP982QoIceF0q/8IybLvepng20Wt3up+aGp1uUU81s3/JmnZ4iILs8pevQp7DgIECTb3seVVu1HUTNnBG6OxMVex9hgH0khxvLOpUYwAGzle5mupbl3T0z2ePSo1k6SB+9xjrFi9vii4lV+m4N5OjnfT3aPYt2n0LB7pAiKvtIpYI9tdvZ1eUcvWF9pd9jOu7pWqfG9gY0GcTOUyBlw4/SevAKge79JUcq553pp6nAohwf+KES8137oVM3vENW8Ij9qYHMXlwp/pRpeOP9ewJtjUz6Cyfw3kT+HAZPDhhvFOnBGotpWAiYKIAGGrG0CFA1IaG8QDZVrEsqBwoFYyDAOiLGqoUeFPVT/XXZCRTnT0NrM7M8pe6NQGxOSL3V1zBULb1u87aPApaSqMTe2ofOIeKPbCxtBMCcbyWG2T0gIL1QoNj08B9m+rImHK5XgeqJlQbNtS6IQT7IJbt6NPs7YolJm03dFSouqe0q5B7bSoQB3+CnewekmMRYvuI/Zb5YJBdy/PdSzakKLak2Qy7F24feNPrX6V/Xc6SO+xn6bzZbGPBEs+NPe1KPdF4SMC523mUhYaiZ0HoUVseuod4t5FpD8s3mBOJDVwlKOBw/ba7CcwMI4dCy435CkhGkDKuJPHJNskBPG00=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(44832011)(70586007)(70206006)(47076005)(186003)(86362001)(5660300002)(1076003)(82310400003)(83380400001)(8676002)(426003)(82740400003)(336012)(30864003)(2906002)(6916009)(4326008)(16526019)(81166007)(7696005)(316002)(6666004)(2616005)(54906003)(356005)(36860700001)(36756003)(478600001)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 08:34:26.7650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6877f0fd-5eab-4f81-9008-08d971112333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1749
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

Creat common PSP TA load function and update PSP ta_mem_context
with size information.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 280 +++++++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  17 +-
 2 files changed, 93 insertions(+), 204 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 54c26432c65b3d..75eed18370eb12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -901,22 +901,20 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				     uint64_t ta_bin_mc,
 				     uint32_t ta_bin_size,
-				     uint64_t ta_shared_mc,
-				     uint32_t ta_shared_size)
+				     struct ta_mem_context *mem_ctx)
 {
 	cmd->cmd_id				= GFX_CMD_ID_LOAD_TA;
 	cmd->cmd.cmd_load_ta.app_phy_addr_lo 	= lower_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_len		= ta_bin_size;
 
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo = lower_32_bits(ta_shared_mc);
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi = upper_32_bits(ta_shared_mc);
-	cmd->cmd.cmd_load_ta.cmd_buf_len	 = ta_shared_size;
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo = lower_32_bits(mem_ctx->shared_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi = upper_32_bits(mem_ctx->shared_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_len	 = mem_ctx->shared_mem_size;
 }
 
 static int psp_ta_init_shared_buf(struct psp_context *psp,
-				  struct ta_mem_context *mem_ctx,
-				  uint32_t shared_mem_size)
+				  struct ta_mem_context *mem_ctx)
 {
 	int ret;
 
@@ -924,8 +922,8 @@ static int psp_ta_init_shared_buf(struct psp_context *psp,
 	* Allocate 16k memory aligned to 4k from Frame Buffer (local
 	* physical) for ta to host memory
 	*/
-	ret = amdgpu_bo_create_kernel(psp->adev, shared_mem_size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
+	ret = amdgpu_bo_create_kernel(psp->adev, mem_ctx->shared_mem_size,
+				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
 				      &mem_ctx->shared_bo,
 				      &mem_ctx->shared_mc_addr,
 				      &mem_ctx->shared_buf);
@@ -941,8 +939,7 @@ static void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
 
 static int psp_xgmi_init_shared_buf(struct psp_context *psp)
 {
-	return psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context,
-				      PSP_XGMI_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context);
 }
 
 static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
@@ -971,31 +968,27 @@ static int psp_ta_invoke(struct psp_context *psp,
 	return ret;
 }
 
-static int psp_xgmi_load(struct psp_context *psp)
+static int psp_ta_load(struct psp_context *psp,
+			   struct psp_bin_desc *bin_desc,
+			   struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
 
-	/*
-	 * TODO: bypass the loading in sriov for now
-	 */
-
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_copy_fw(psp, psp->xgmi.start_addr, psp->xgmi.size_bytes);
+	psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
 
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
-				 psp->xgmi.size_bytes,
-				 psp->xgmi_context.context.mem_context.shared_mc_addr,
-				 PSP_XGMI_SHARED_MEM_SIZE);
+				 bin_desc->size_bytes,
+				 &context->mem_context);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
 
 	if (!ret) {
-		psp->xgmi_context.context.initialized = true;
-		psp->xgmi_context.context.session_id = cmd->resp.session_id;
+		context->session_id = cmd->resp.session_id;
 	}
 
 	release_psp_cmd_buf(psp);
@@ -1003,6 +996,11 @@ static int psp_xgmi_load(struct psp_context *psp)
 	return ret;
 }
 
+static int psp_xgmi_load(struct psp_context *psp)
+{
+	return psp_ta_load(psp, &psp->xgmi, &psp->xgmi_context.context);
+}
+
 static int psp_xgmi_unload(struct psp_context *psp)
 {
 	return psp_ta_unload(psp, psp->xgmi_context.context.session_id);
@@ -1051,6 +1049,8 @@ int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool lo
 	if (!load_ta)
 		goto invoke;
 
+	psp->xgmi_context.context.mem_context.shared_mem_size = PSP_XGMI_SHARED_MEM_SIZE;
+
 	if (!psp->xgmi_context.context.initialized) {
 		ret = psp_xgmi_init_shared_buf(psp);
 		if (ret)
@@ -1059,7 +1059,9 @@ int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool lo
 
 	/* Load XGMI TA */
 	ret = psp_xgmi_load(psp);
-	if (ret)
+	if (!ret)
+		psp->xgmi_context.context.initialized = true;
+	else
 		return ret;
 
 invoke:
@@ -1281,57 +1283,12 @@ int psp_xgmi_set_topology_info(struct psp_context *psp,
 // ras begin
 static int psp_ras_init_shared_buf(struct psp_context *psp)
 {
-	return psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context,
-				      PSP_RAS_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context);
 }
 
 static int psp_ras_load(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-	struct ta_ras_shared_memory *ras_cmd;
-
-	/*
-	 * TODO: bypass the loading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	psp_copy_fw(psp, psp->ras.start_addr, psp->ras.size_bytes);
-
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
-
-	if (psp->adev->gmc.xgmi.connected_to_cpu)
-		ras_cmd->ras_in_message.init_flags.poison_mode_en = 1;
-	else
-		ras_cmd->ras_in_message.init_flags.dgpu_mode = 1;
-
-	cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->ras.size_bytes,
-				 psp->ras_context.context.mem_context.shared_mc_addr,
-				 PSP_RAS_SHARED_MEM_SIZE);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd,
-			psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->ras_context.context.session_id = cmd->resp.session_id;
-
-		if (!ras_cmd->ras_status)
-			psp->ras_context.context.initialized = true;
-		else
-			dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	if (ret || ras_cmd->ras_status)
-		amdgpu_ras_fini(psp->adev);
-
-	return ret;
+	return psp_ta_load(psp, &psp->ras, &psp->ras_context.context);
 }
 
 static int psp_ras_unload(struct psp_context *psp)
@@ -1458,6 +1415,7 @@ static int psp_ras_initialize(struct psp_context *psp)
 	int ret;
 	uint32_t boot_cfg = 0xFF;
 	struct amdgpu_device *adev = psp->adev;
+	struct ta_ras_shared_memory *ras_cmd;
 
 	/*
 	 * TODO: bypass the initialize in sriov for now
@@ -1512,17 +1470,33 @@ static int psp_ras_initialize(struct psp_context *psp)
 		}
 	}
 
+	psp->ras_context.context.mem_context.shared_mem_size = PSP_RAS_SHARED_MEM_SIZE;
+
 	if (!psp->ras_context.context.initialized) {
 		ret = psp_ras_init_shared_buf(psp);
 		if (ret)
 			return ret;
 	}
 
+	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
+	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
+
+	if (psp->adev->gmc.xgmi.connected_to_cpu)
+		ras_cmd->ras_in_message.init_flags.poison_mode_en = 1;
+	else
+		ras_cmd->ras_in_message.init_flags.dgpu_mode = 1;
+
 	ret = psp_ras_load(psp);
-	if (ret)
-		return ret;
 
-	return 0;
+	if (!ret && !ras_cmd->ras_status)
+		psp->ras_context.context.initialized = true;
+	else {
+		if (ras_cmd->ras_status)
+			dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
+		amdgpu_ras_fini(psp->adev);
+	}
+
+	return ret;
 }
 
 int psp_ras_trigger_error(struct psp_context *psp,
@@ -1556,43 +1530,12 @@ int psp_ras_trigger_error(struct psp_context *psp,
 // HDCP start
 static int psp_hdcp_init_shared_buf(struct psp_context *psp)
 {
-	return psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_context,
-				      PSP_HDCP_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_context);
 }
 
 static int psp_hdcp_load(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the loading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	psp_copy_fw(psp, psp->hdcp.start_addr,
-		    psp->hdcp.size_bytes);
-
-	cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->hdcp.size_bytes,
-				 psp->hdcp_context.context.mem_context.shared_mc_addr,
-				 PSP_HDCP_SHARED_MEM_SIZE);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->hdcp_context.context.initialized = true;
-		psp->hdcp_context.context.session_id = cmd->resp.session_id;
-		mutex_init(&psp->hdcp_context.mutex);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_load(psp, &psp->hdcp, &psp->hdcp_context.context);
 }
 static int psp_hdcp_initialize(struct psp_context *psp)
 {
@@ -1610,6 +1553,8 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 		return 0;
 	}
 
+	psp->hdcp_context.context.mem_context.shared_mem_size = PSP_HDCP_SHARED_MEM_SIZE;
+
 	if (!psp->hdcp_context.context.initialized) {
 		ret = psp_hdcp_init_shared_buf(psp);
 		if (ret)
@@ -1617,10 +1562,12 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_hdcp_load(psp);
-	if (ret)
-		return ret;
+	if (!ret) {
+		psp->hdcp_context.context.initialized = true;
+		mutex_init(&psp->hdcp_context.mutex);
+	}
 
-	return 0;
+	return ret;
 }
 
 static int psp_hdcp_unload(struct psp_context *psp)
@@ -1673,42 +1620,12 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 // DTM start
 static int psp_dtm_init_shared_buf(struct psp_context *psp)
 {
-	return psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_context,
-				      PSP_DTM_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_context);
 }
 
 static int psp_dtm_load(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the loading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	psp_copy_fw(psp, psp->dtm.start_addr, psp->dtm.size_bytes);
-
-	cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->dtm.size_bytes,
-				 psp->dtm_context.context.mem_context.shared_mc_addr,
-				 PSP_DTM_SHARED_MEM_SIZE);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->dtm_context.context.initialized = true;
-		psp->dtm_context.context.session_id = cmd->resp.session_id;
-		mutex_init(&psp->dtm_context.mutex);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_load(psp, &psp->dtm, &psp->dtm_context.context);
 }
 
 static int psp_dtm_initialize(struct psp_context *psp)
@@ -1727,6 +1644,8 @@ static int psp_dtm_initialize(struct psp_context *psp)
 		return 0;
 	}
 
+	psp->dtm_context.context.mem_context.shared_mem_size = PSP_DTM_SHARED_MEM_SIZE;
+
 	if (!psp->dtm_context.context.initialized) {
 		ret = psp_dtm_init_shared_buf(psp);
 		if (ret)
@@ -1734,10 +1653,12 @@ static int psp_dtm_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_dtm_load(psp);
-	if (ret)
-		return ret;
+	if (!ret) {
+		psp->dtm_context.context.initialized = true;
+		mutex_init(&psp->dtm_context.mutex);
+	}
 
-	return 0;
+	return ret;
 }
 
 static int psp_dtm_unload(struct psp_context *psp)
@@ -1790,36 +1711,12 @@ static int psp_dtm_terminate(struct psp_context *psp)
 // RAP start
 static int psp_rap_init_shared_buf(struct psp_context *psp)
 {
-	return psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_context,
-				      PSP_RAP_SHARED_MEM_SIZE);
+	return psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_context);
 }
 
 static int psp_rap_load(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	psp_copy_fw(psp, psp->rap.start_addr, psp->rap.size_bytes);
-
-	cmd = acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->rap.size_bytes,
-				 psp->rap_context.context.mem_context.shared_mc_addr,
-				 PSP_RAP_SHARED_MEM_SIZE);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->rap_context.context.initialized = true;
-		psp->rap_context.context.session_id = cmd->resp.session_id;
-		mutex_init(&psp->rap_context.mutex);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_load(psp, &psp->rap, &psp->rap_context.context);
 }
 
 static int psp_rap_unload(struct psp_context *psp)
@@ -1844,6 +1741,8 @@ static int psp_rap_initialize(struct psp_context *psp)
 		return 0;
 	}
 
+	psp->rap_context.context.mem_context.shared_mem_size = PSP_RAP_SHARED_MEM_SIZE;
+
 	if (!psp->rap_context.context.initialized) {
 		ret = psp_rap_init_shared_buf(psp);
 		if (ret)
@@ -1851,7 +1750,10 @@ static int psp_rap_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_rap_load(psp);
-	if (ret)
+	if (!ret) {
+		psp->rap_context.context.initialized = true;
+		mutex_init(&psp->rap_context.mutex);
+	} else
 		return ret;
 
 	ret = psp_rap_invoke(psp, TA_CMD_RAP__INITIALIZE, &status);
@@ -1923,35 +1825,13 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id, enum ta_rap_stat
 static int psp_securedisplay_init_shared_buf(struct psp_context *psp)
 {
 	return psp_ta_init_shared_buf(
-		psp, &psp->securedisplay_context.context.mem_context,
-		PSP_SECUREDISPLAY_SHARED_MEM_SIZE);
+		psp, &psp->securedisplay_context.context.mem_context);
 }
 
 static int psp_securedisplay_load(struct psp_context *psp)
 {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
-
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-	memcpy(psp->fw_pri_buf, psp->securedisplay.start_addr, psp->securedisplay.size_bytes);
-
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 psp->securedisplay.size_bytes,
-				 psp->securedisplay_context.context.mem_context.shared_mc_addr,
-				 PSP_SECUREDISPLAY_SHARED_MEM_SIZE);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	if (!ret) {
-		psp->securedisplay_context.context.initialized = true;
-		psp->securedisplay_context.context.session_id = cmd->resp.session_id;
-		mutex_init(&psp->securedisplay_context.mutex);
-	}
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_load(psp, &psp->securedisplay,
+			   &psp->securedisplay_context.context);
 }
 
 static int psp_securedisplay_unload(struct psp_context *psp)
@@ -1976,6 +1856,9 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 		return 0;
 	}
 
+	psp->securedisplay_context.context.mem_context.shared_mem_size =
+		PSP_SECUREDISPLAY_SHARED_MEM_SIZE;
+
 	if (!psp->securedisplay_context.context.initialized) {
 		ret = psp_securedisplay_init_shared_buf(psp);
 		if (ret)
@@ -1983,7 +1866,10 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_securedisplay_load(psp);
-	if (ret)
+	if (!ret) {
+		psp->securedisplay_context.context.initialized = true;
+		mutex_init(&psp->securedisplay_context.mutex);
+	} else
 		return ret;
 
 	psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 8ef2d28af92aeb..cc09b9e911199a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -34,17 +34,19 @@
 
 #define PSP_FENCE_BUFFER_SIZE	0x1000
 #define PSP_CMD_BUFFER_SIZE	0x1000
-#define PSP_XGMI_SHARED_MEM_SIZE 0x4000
-#define PSP_RAS_SHARED_MEM_SIZE 0x4000
 #define PSP_1_MEG		0x100000
 #define PSP_TMR_SIZE(adev)	((adev)->asic_type == CHIP_ALDEBARAN ? 0x800000 : 0x400000)
-#define PSP_HDCP_SHARED_MEM_SIZE	0x4000
-#define PSP_DTM_SHARED_MEM_SIZE	0x4000
-#define PSP_RAP_SHARED_MEM_SIZE	0x4000
-#define PSP_SECUREDISPLAY_SHARED_MEM_SIZE	0x4000
-#define PSP_SHARED_MEM_SIZE		0x4000
 #define PSP_FW_NAME_LEN		0x24
 
+enum psp_shared_mem_size {
+	PSP_XGMI_SHARED_MEM_SIZE			= 0x4000,
+	PSP_RAS_SHARED_MEM_SIZE				= 0x4000,
+	PSP_HDCP_SHARED_MEM_SIZE			= 0x4000,
+	PSP_DTM_SHARED_MEM_SIZE				= 0x4000,
+	PSP_RAP_SHARED_MEM_SIZE				= 0x4000,
+	PSP_SECUREDISPLAY_SHARED_MEM_SIZE	= 0x4000,
+};
+
 struct psp_context;
 struct psp_xgmi_node_info;
 struct psp_xgmi_topology_info;
@@ -140,6 +142,7 @@ struct ta_mem_context {
 	struct amdgpu_bo		*shared_bo;
 	uint64_t		shared_mc_addr;
 	void			*shared_buf;
+	enum psp_shared_mem_size	shared_mem_size;
 };
 
 struct ta_context {
-- 
2.17.1

