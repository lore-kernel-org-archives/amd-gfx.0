Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270B2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB9260F8F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFB9260F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829BE6E125;
	Mon, 13 Sep 2021 07:54:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE6CC6E135
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 07:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3FVddJH3jxj+toBvW/GJrkEvjy7joJFMnBf6jrDkNPcUrW7AmRZLm7UFoWhWr2E5PLixUn+p+eOcqwZYJ/Ngl8PB6NG4n+sNlPnziC7GBdPByCpayX0SQwgdSQiQUAWnfc64XubGeqH7baOLg9lM0SSt4ZPwzQs1id9Hvj9/3rcZpmrAbPn0rENzwEbqHX1+pkepR/q1sKPOBZRit8xAmFAGcp53iVkiwwKf62/m0Dz37wvz6P4a3BI9qpryx+d1VWdOTLnlWrlCaEeFT4yDlHR2rue0Kg95v/jSjSNGaI54d6c9l7AX5B46ChwWNPjPpmxUfUhU6cQTzUnNuZYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=clb82LdTLzVtk2jr1n9UQ86I+fc8TuTELPtU5adTUZM=;
 b=YtiXq4CbGOlrhHSoIMGzJGiKfS5Ta7ffrMPszQbxaSTh4Gqqz0j689P6wKyqKzv+Lp7utVAmiAYS6erPpYL8jsWiTIeyoXR6/CW3fF6t2L9VQq4INMT0xsjyfNB+daz7YMNkbaQ3NnKL89VoVdxgLZy5+0+gI1DPa/r0GDJlumE+IC20cAhMVKztIAN8L4W3d9yZybjpMrUH3Q6Yn2y1jnh8bgz9TxONJWiZtXLf1b+v0TyBhi62qkXTS08mue9iJkB5JKGOPaNn3MQzaBLsGHPhWWTic0OWiM6uMfSOlOo4wJ0dn66+7HpZLBHUfM9pMK6BLO103lwT2dhVZG3jaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clb82LdTLzVtk2jr1n9UQ86I+fc8TuTELPtU5adTUZM=;
 b=uNDcLxIn0lW1f0qIvqg21sxN5HLkreZgPZ4jyxGYC4T91My47JhhZJjfWWL5EXzJMrDNsoQc/aqzTQNqBYmZokreFdik1XzobyXT6fCXIIYFSSr9MlwUuBYMGZz2X7rHuYoXtm6wOblclIu1PT6JnUxIAKqtc1M32a59HKOZmK8=
Received: from DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 07:54:49 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::56) by DM5PR04CA0027.outlook.office365.com
 (2603:10b6:3:12b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 07:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 07:54:49 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 02:54:47 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Conform ASD header/loading to generic TA systems
Date: Mon, 13 Sep 2021 15:54:34 +0800
Message-ID: <20210913075434.23276-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c276dbe-70d3-494d-bdd9-08d9768bc32a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2485CB6E6F95C0A87D384C2891D99@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOIextIfZ+JyUexLfGOkJJ9Q5D8se+ldygsKRz8b5btGWqyVHeX46Yu4cfMFcfEAINdTNpsujOwE1th0Z89Bk8kUVaIxEl/VjlEVfjPtk1yYvobVYRlgN2XFPlp73UeU7Mgx8TvM80G405mt4A15F47ZZ3qYF7trU+ZaEii5TOw8CC364RFDjKHJaDRHjTQF+6zloLjmMcyie1dAC0sYEvvU3Xaf6/OHnBBNeCATYa6WJDocEiAm1JM6YpWQvthovM0x6jpXrBDu6PGpXXkmhqnbj+zO5Bd2KWEmpFLOhYAwTvzrBJ1bsWY7y0WBd9MOcqDiQ1EVeERwHm1o7wJVwflQaHHXTCexgcO/wzGmJxdY2Ke6tPg3UVIjc4xjxJSv9sN9HIaqG+J/Zyvw+1HUGT6QpdEwt9cP4zsWNGbqjbLt1v9vkXm/s9Oh4Wxu2yysWFnACoR9Rk3TwlL1hIVyF+9hGUWcFNomLla7rDjA766jp8YWwBHWy+EACg+NhfF13xfpnlSsBKQPVn45Towd/ngV3POwVmLZYxhUXPr/wRDBmih6suHx44Pqu1V3v8QO7ouIU4783gv9qpjHDjxxhMkKmtRZkanGvW13ujMbgipY77hakSuf7uFWY1BmkFi6iORUit/INj/CKXojb63WRgUsVq2edrRmZSOImIoH34lz4/ITxcngZzhKIZNxZmFxB6xWtA+378F7nBqgLGjBDGgsAqSA9Q/0sAO60uw6QkTrDEv7DuyNGtBa/rO7qR0miby1xw/qLWQa9i00naz6cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(16526019)(8936002)(478600001)(2906002)(36860700001)(6666004)(82310400003)(5660300002)(54906003)(83380400001)(81166007)(186003)(82740400003)(8676002)(7696005)(316002)(26005)(36756003)(70206006)(1076003)(70586007)(356005)(6916009)(2616005)(47076005)(86362001)(4326008)(44832011)(336012)(426003)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 07:54:49.5612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c276dbe-70d3-494d-bdd9-08d9768bc32a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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

Update asd_context structure and add asd_initialize function to
conform ASD header/loading to generic TA systems.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 60 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 10 ++---
 2 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 071dadf3a4509f..bc861f2fe0ecf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -47,6 +47,7 @@ static void psp_sysfs_fini(struct amdgpu_device *adev);
 
 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_ta_unload(struct psp_context *psp, uint32_t session_id);
+static int psp_ta_load(struct psp_context *psp, struct ta_context *context);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
 
@@ -781,23 +782,14 @@ static int psp_rl_load(struct amdgpu_device *adev)
 	return ret;
 }
 
-static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
-				uint64_t asd_mc, uint32_t size)
+static int psp_asd_load(struct psp_context *psp)
 {
-	cmd->cmd_id = GFX_CMD_ID_LOAD_ASD;
-	cmd->cmd.cmd_load_ta.app_phy_addr_lo = lower_32_bits(asd_mc);
-	cmd->cmd.cmd_load_ta.app_phy_addr_hi = upper_32_bits(asd_mc);
-	cmd->cmd.cmd_load_ta.app_len = size;
-
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo = 0;
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi = 0;
-	cmd->cmd.cmd_load_ta.cmd_buf_len = 0;
+	return psp_ta_load(psp, &psp->asd_context);
 }
 
-static int psp_asd_load(struct psp_context *psp)
+static int psp_asd_initialize(struct psp_context *psp)
 {
 	int ret;
-	struct psp_gfx_cmd_resp *cmd;
 
 	/* If PSP version doesn't match ASD version, asd loading will be failed.
 	 * add workaround to bypass it for sriov now.
@@ -806,22 +798,13 @@ static int psp_asd_load(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev) || !psp->asd_context.bin_desc.size_bytes)
 		return 0;
 
-	cmd = acquire_psp_cmd_buf(psp);
+	psp->asd_context.mem_context.shared_mc_addr  = 0;
+	psp->asd_context.mem_context.shared_mem_size = PSP_ASD_SHARED_MEM_SIZE;
+	psp->asd_context.ta_load_type                = GFX_CMD_ID_LOAD_ASD;
 
-	psp_copy_fw(psp, psp->asd_context.bin_desc.start_addr,
-		    psp->asd_context.bin_desc.size_bytes);
-
-	psp_prep_asd_load_cmd_buf(cmd, psp->fw_pri_mc_addr,
-				  psp->asd_context.bin_desc.size_bytes);
-
-	ret = psp_cmd_submit_buf(psp, NULL, cmd,
-				 psp->fence_buf_mc_addr);
-	if (!ret) {
-		psp->asd_context.asd_initialized = true;
-		psp->asd_context.session_id = cmd->resp.session_id;
-	}
-
-	release_psp_cmd_buf(psp);
+	ret = psp_asd_load(psp);
+	if (!ret)
+		psp->asd_context.initialized = true;
 
 	return ret;
 }
@@ -859,13 +842,13 @@ static int psp_asd_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->asd_context.asd_initialized)
+	if (!psp->asd_context.initialized)
 		return 0;
 
 	ret = psp_asd_unload(psp);
 
 	if (!ret)
-		psp->asd_context.asd_initialized = false;
+		psp->asd_context.initialized = false;
 
 	return ret;
 }
@@ -903,7 +886,7 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				     uint64_t ta_bin_mc,
 				     struct ta_context *context)
 {
-	cmd->cmd_id				= GFX_CMD_ID_LOAD_TA;
+	cmd->cmd_id				= context->ta_load_type;
 	cmd->cmd.cmd_load_ta.app_phy_addr_lo 	= lower_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
@@ -970,8 +953,7 @@ static int psp_ta_invoke(struct psp_context *psp,
 	return ret;
 }
 
-static int psp_ta_load(struct psp_context *psp,
-			   struct ta_context *context)
+static int psp_ta_load(struct psp_context *psp, struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
@@ -981,9 +963,7 @@ static int psp_ta_load(struct psp_context *psp,
 	psp_copy_fw(psp, context->bin_desc.start_addr,
 		    context->bin_desc.size_bytes);
 
-	psp_prep_ta_load_cmd_buf(cmd,
-				 psp->fw_pri_mc_addr,
-				 context);
+	psp_prep_ta_load_cmd_buf(cmd, psp->fw_pri_mc_addr, context);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -1051,6 +1031,7 @@ int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool lo
 		goto invoke;
 
 	psp->xgmi_context.context.mem_context.shared_mem_size = PSP_XGMI_SHARED_MEM_SIZE;
+	psp->xgmi_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->xgmi_context.context.initialized) {
 		ret = psp_xgmi_init_shared_buf(psp);
@@ -1450,6 +1431,7 @@ static int psp_ras_initialize(struct psp_context *psp)
 	}
 
 	psp->ras_context.context.mem_context.shared_mem_size = PSP_RAS_SHARED_MEM_SIZE;
+	psp->ras_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->ras_context.context.initialized) {
 		ret = psp_ras_init_shared_buf(psp);
@@ -1539,6 +1521,7 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 	}
 
 	psp->hdcp_context.context.mem_context.shared_mem_size = PSP_HDCP_SHARED_MEM_SIZE;
+	psp->hdcp_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->hdcp_context.context.initialized) {
 		ret = psp_hdcp_init_shared_buf(psp);
@@ -1630,6 +1613,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
 	}
 
 	psp->dtm_context.context.mem_context.shared_mem_size = PSP_DTM_SHARED_MEM_SIZE;
+	psp->dtm_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->dtm_context.context.initialized) {
 		ret = psp_dtm_init_shared_buf(psp);
@@ -1727,6 +1711,7 @@ static int psp_rap_initialize(struct psp_context *psp)
 	}
 
 	psp->rap_context.context.mem_context.shared_mem_size = PSP_RAP_SHARED_MEM_SIZE;
+	psp->rap_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->rap_context.context.initialized) {
 		ret = psp_rap_init_shared_buf(psp);
@@ -1842,6 +1827,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 
 	psp->securedisplay_context.context.mem_context.shared_mem_size =
 		PSP_SECUREDISPLAY_SHARED_MEM_SIZE;
+	psp->securedisplay_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->securedisplay_context.context.initialized) {
 		ret = psp_securedisplay_init_shared_buf(psp);
@@ -2419,7 +2405,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (ret)
 		goto failed;
 
-	ret = psp_asd_load(psp);
+	ret = psp_asd_initialize(psp);
 	if (ret) {
 		DRM_ERROR("PSP load asd failed!\n");
 		return ret;
@@ -2616,7 +2602,7 @@ static int psp_resume(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = psp_asd_load(psp);
+	ret = psp_asd_initialize(psp);
 	if (ret) {
 		DRM_ERROR("PSP load asd failed!\n");
 		goto failed;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index cfd7ac976cd1e6..f29afabbff1fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -39,6 +39,7 @@
 #define PSP_FW_NAME_LEN		0x24
 
 enum psp_shared_mem_size {
+	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
 	PSP_XGMI_SHARED_MEM_SIZE			= 0x4000,
 	PSP_RAS_SHARED_MEM_SIZE				= 0x4000,
 	PSP_HDCP_SHARED_MEM_SIZE			= 0x4000,
@@ -140,12 +141,6 @@ struct psp_bin_desc {
 	uint8_t *start_addr;
 };
 
-struct psp_asd_context {
-	bool			asd_initialized;
-	uint32_t		session_id;
-	struct psp_bin_desc		bin_desc;
-};
-
 struct ta_mem_context {
 	struct amdgpu_bo		*shared_bo;
 	uint64_t		shared_mc_addr;
@@ -158,6 +153,7 @@ struct ta_context {
 	uint32_t		session_id;
 	struct ta_mem_context	mem_context;
 	struct psp_bin_desc		bin_desc;
+	enum psp_gfx_cmd_id		ta_load_type;
 };
 
 struct ta_cp_context {
@@ -331,7 +327,7 @@ struct psp_context
 	const struct firmware		*ta_fw;
 	uint32_t			ta_fw_version;
 
-	struct psp_asd_context		asd_context;
+	struct ta_context		asd_context;
 	struct psp_xgmi_context		xgmi_context;
 	struct psp_ras_context		ras_context;
 	struct ta_cp_context		hdcp_context;
-- 
2.17.1

