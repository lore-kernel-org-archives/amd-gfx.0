Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16190C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F9060524
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8F9060524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F50E6E0E6;
	Tue, 17 Aug 2021 09:12:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF8D6E0E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 09:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRwHiWljfApIh7ZDj22pfOTpBZQW1k062FowdCIMS4OPm6/GnhUkeus5e6oUfLwNCixUSnCAslMyvJ/ZTaShczTNb6+wjr+2kS2ngv0grPWjlsFAmKAKT8I4UJS4n0IcB+sTQ5IUtz4JXhlCgmB5++WabmpaqORmh2Fly3O2TFjnykibeLjtu+DRz1zkRr1+phTgYxrwd5a/ZvWSn3FSqonftpgUEMRCqKp8ZKQpHtuFlUjLQcud/OX9BSuBxya0pXZe4C73CdMVr25lU+EXRQPQ3APRpyP3E3xTNbiGAJnW1Z1GmXGQSimKIExWs+dNQPA3ATBfyEdeKbt2N4NdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npzn2OaBZQMRSvRLj0OupSP3FIhfi8smaZRvCGh7USc=;
 b=fD+LZzuFs35dWFXzYiDi4ObKm2wL+ATb44cEyZvmb77NI1SixRQ5h2ebRbBMeJXg2gdjqZTVwDukjQasvjKGwqiTU3o4fwu9Ay7TAWZfAW4LIOJGhiHLa5CSkKfA3+5U0rmGkPWbbNm+KrF+sMMBNZmLjL02iBfafpfIHLI0eTv2tXjUaceE3QeaHH+8iT/9UqWRCGm1bG3gK775g9qw3Ey78CEJhMLXGtR3ma/81Q+Nzl171TF+qy2NXyetxnMD3MTKSUdPvs8KjOs0iNZG+pVId5ZTo52b9aPjiRU5I0aqnnbuKovF+Y8sorFnB6oR1Bj+vR8+DufTqhpJTO4qBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npzn2OaBZQMRSvRLj0OupSP3FIhfi8smaZRvCGh7USc=;
 b=e0uq4WujiJePiAnrRUAEIgzWQh1nODgN9BHV9zKnsvfNUa62QvDuIn3CDnQ0f3OBKLJiRJqk7usDSsRbwBa4hUD4wM1vuBMIaqx6vhVuVGBgulrNc+wY92etCXcNmBH7MtjwTZDSed8BSr4WMAX5LWkN5305SXATzwWJ7e0xOjI=
Received: from BN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:e4::26)
 by BY5PR12MB3969.namprd12.prod.outlook.com (2603:10b6:a03:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 09:12:54 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::6d) by BN0PR02CA0021.outlook.office365.com
 (2603:10b6:408:e4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Tue, 17 Aug 2021 09:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 09:12:53 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 04:12:50 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amd: consolidate TA shared memory structures
Date: Tue, 17 Aug 2021 17:11:09 +0800
Message-ID: <20210817091109.7581-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4344e9ed-05b0-48ee-3b60-08d9615f321b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3969:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3969991DEEE07FCCEEEA9E5E91FE9@BY5PR12MB3969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mjpHbrEftAlKZzyb1z7IC5ka9pe9R3vJ2pBU6++Wgkt7RIbf5PsVVeZA4uYJF8w5rRjhtlxxLDcowjhvOJpg6GNLYR8czVfi//CrlMzH/wGHuP+ieGbfMSbnsYuFtAJyrM+vOUI9NN8XGqa537wh4xrEv+i1Sa8WsE5JiTjIp33UwzXa7kj3mVPeJynuuZMVfhUawNkQrJdLwQafDD75BJLdVV5PQZ0G3aJRRodaa88M9Nk7QI0/RFc9NiJpu0Pzxn6els8FJbj9aTdHKwv7nyaWMANQZN//MesY8TD8tSzsI7w99qO3QckZQilO1ZyZHgGR9ePkzZ81CaM3mh/Bot8d/BGSrHboCwHl5JuD5MewSlKbvJoNS/P8RLcF+bxVAGw/2O6eNCSg+A9gk0RX1rI8JoGdMDE8YIYZ9cmTkyTiverZLG9kPR9+erm6KKA2BZbHC4hXBXOy2ZAByYt8xVm3/wBmlXISIcCuSjY00godg8B0Ko7E+NmxGS6NvLw0G8wbzFrfEUZiqnceYHgPlJ5DnPJG0yAekxAMA0AxjhR+nhaMX5P1ppd0wGqrb8tuz70uhv2o8QOaY03WJIkugzb2Zy9tCOix+A/5qVmYj75mdIQrocolEXAjzffRo5HhZ4x/kPEcijTRSZqWNHBtY8PFhk75r+u5bbOdxi+BPT/P6BCYUsHIbI7cSIE1TNptVC9FbzlRJscdRFWSfnQwRL8166TmeYkiE0gQJgw8s8jQlt67mmaCleJYJ8u5vuiBzmOmwpPMdfGjegqrAWmmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(46966006)(47076005)(356005)(36756003)(26005)(81166007)(83380400001)(8676002)(1076003)(186003)(30864003)(86362001)(54906003)(16526019)(8936002)(7696005)(2616005)(4326008)(82310400003)(34020700004)(36860700001)(6916009)(2906002)(44832011)(6666004)(70586007)(82740400003)(70206006)(478600001)(336012)(426003)(5660300002)(316002)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 09:12:53.9628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4344e9ed-05b0-48ee-3b60-08d9615f321b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3969
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

Change-Id: I81be5a824fced3d2244cf209444c2391f6bc6c50
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 218 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  68 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  12 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  56 ++---
 6 files changed, 167 insertions(+), 195 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cf40609f39d4f0..ebb827b6331b65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -908,9 +908,9 @@ static int psp_xgmi_init_shared_buf(struct psp_context *psp)
 	 */
 	ret = amdgpu_bo_create_kernel(psp->adev, PSP_XGMI_SHARED_MEM_SIZE,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->xgmi_context.xgmi_shared_bo,
-				      &psp->xgmi_context.xgmi_shared_mc_addr,
-				      &psp->xgmi_context.xgmi_shared_buf);
+				      &psp->xgmi_context.context.mem_context.shared_bo,
+				      &psp->xgmi_context.context.mem_context.shared_mc_addr,
+				      &psp->xgmi_context.context.mem_context.shared_buf);
 
 	return ret;
 }
@@ -957,15 +957,15 @@ static int psp_xgmi_load(struct psp_context *psp)
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
 				 psp->xgmi.size_bytes,
-				 psp->xgmi_context.xgmi_shared_mc_addr,
+				 psp->xgmi_context.context.mem_context.shared_mc_addr,
 				 PSP_XGMI_SHARED_MEM_SIZE);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
 
 	if (!ret) {
-		psp->xgmi_context.initialized = 1;
-		psp->xgmi_context.session_id = cmd->resp.session_id;
+		psp->xgmi_context.context.initialized = true;
+		psp->xgmi_context.context.session_id = cmd->resp.session_id;
 	}
 
 	release_psp_cmd_buf(psp);
@@ -990,7 +990,7 @@ static int psp_xgmi_unload(struct psp_context *psp)
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_ta_unload_cmd_buf(cmd, psp->xgmi_context.session_id);
+	psp_prep_ta_unload_cmd_buf(cmd, psp->xgmi_context.context.session_id);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -1002,26 +1002,26 @@ static int psp_xgmi_unload(struct psp_context *psp)
 
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
-	return psp_ta_invoke(psp, ta_cmd_id, psp->xgmi_context.session_id);
+	return psp_ta_invoke(psp, ta_cmd_id, psp->xgmi_context.context.session_id);
 }
 
 int psp_xgmi_terminate(struct psp_context *psp)
 {
 	int ret;
 
-	if (!psp->xgmi_context.initialized)
+	if (!psp->xgmi_context.context.initialized)
 		return 0;
 
 	ret = psp_xgmi_unload(psp);
 	if (ret)
 		return ret;
 
-	psp->xgmi_context.initialized = 0;
+	psp->xgmi_context.context.initialized = false;
 
 	/* free xgmi shared memory */
-	amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
-			&psp->xgmi_context.xgmi_shared_mc_addr,
-			&psp->xgmi_context.xgmi_shared_buf);
+	amdgpu_bo_free_kernel(&psp->xgmi_context.context.mem_context.shared_bo,
+			&psp->xgmi_context.context.mem_context.shared_mc_addr,
+			&psp->xgmi_context.context.mem_context.shared_buf);
 
 	return 0;
 }
@@ -1036,7 +1036,7 @@ int psp_xgmi_initialize(struct psp_context *psp)
 	    !psp->xgmi.start_addr)
 		return -ENOENT;
 
-	if (!psp->xgmi_context.initialized) {
+	if (!psp->xgmi_context.context.initialized) {
 		ret = psp_xgmi_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1048,7 +1048,7 @@ int psp_xgmi_initialize(struct psp_context *psp)
 		return ret;
 
 	/* Initialize XGMI session */
-	xgmi_cmd = (struct ta_xgmi_shared_memory *)(psp->xgmi_context.xgmi_shared_buf);
+	xgmi_cmd = (struct ta_xgmi_shared_memory *)(psp->xgmi_context.context.mem_context.shared_buf);
 	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
 	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__INITIALIZE;
 
@@ -1062,7 +1062,7 @@ int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id)
 	struct ta_xgmi_shared_memory *xgmi_cmd;
 	int ret;
 
-	xgmi_cmd = (struct ta_xgmi_shared_memory *)psp->xgmi_context.xgmi_shared_buf;
+	xgmi_cmd = (struct ta_xgmi_shared_memory *)psp->xgmi_context.context.mem_context.shared_buf;
 	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
 
 	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_HIVE_ID;
@@ -1082,7 +1082,7 @@ int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id)
 	struct ta_xgmi_shared_memory *xgmi_cmd;
 	int ret;
 
-	xgmi_cmd = (struct ta_xgmi_shared_memory *)psp->xgmi_context.xgmi_shared_buf;
+	xgmi_cmd = (struct ta_xgmi_shared_memory *)psp->xgmi_context.context.mem_context.shared_buf;
 	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
 
 	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_NODE_ID;
@@ -1116,7 +1116,7 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 	if (!topology || topology->num_nodes > TA_XGMI__MAX_CONNECTED_NODES)
 		return -EINVAL;
 
-	xgmi_cmd = (struct ta_xgmi_shared_memory *)psp->xgmi_context.xgmi_shared_buf;
+	xgmi_cmd = (struct ta_xgmi_shared_memory *)psp->xgmi_context.context.mem_context.shared_buf;
 	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
 
 	/* Fill in the shared memory with topology information as input */
@@ -1177,7 +1177,7 @@ int psp_xgmi_set_topology_info(struct psp_context *psp,
 	if (!topology || topology->num_nodes > TA_XGMI__MAX_CONNECTED_NODES)
 		return -EINVAL;
 
-	xgmi_cmd = (struct ta_xgmi_shared_memory *)psp->xgmi_context.xgmi_shared_buf;
+	xgmi_cmd = (struct ta_xgmi_shared_memory *)psp->xgmi_context.context.mem_context.shared_buf;
 	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
 
 	topology_info_input = &xgmi_cmd->xgmi_in_message.get_topology_info;
@@ -1206,9 +1206,9 @@ static int psp_ras_init_shared_buf(struct psp_context *psp)
 	 */
 	ret = amdgpu_bo_create_kernel(psp->adev, PSP_RAS_SHARED_MEM_SIZE,
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-			&psp->ras_context.ras_shared_bo,
-			&psp->ras_context.ras_shared_mc_addr,
-			&psp->ras_context.ras_shared_buf);
+			&psp->ras_context.context.mem_context.shared_bo,
+			&psp->ras_context.context.mem_context.shared_mc_addr,
+			&psp->ras_context.context.mem_context.shared_buf);
 
 	return ret;
 }
@@ -1227,7 +1227,7 @@ static int psp_ras_load(struct psp_context *psp)
 
 	psp_copy_fw(psp, psp->ras.start_addr, psp->ras.size_bytes);
 
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.ras_shared_buf;
+	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
 
 	if (psp->adev->gmc.xgmi.connected_to_cpu)
 		ras_cmd->ras_in_message.init_flags.poison_mode_en = 1;
@@ -1239,17 +1239,17 @@ static int psp_ras_load(struct psp_context *psp)
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
 				 psp->ras.size_bytes,
-				 psp->ras_context.ras_shared_mc_addr,
+				 psp->ras_context.context.mem_context.shared_mc_addr,
 				 PSP_RAS_SHARED_MEM_SIZE);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 			psp->fence_buf_mc_addr);
 
 	if (!ret) {
-		psp->ras_context.session_id = cmd->resp.session_id;
+		psp->ras_context.context.session_id = cmd->resp.session_id;
 
 		if (!ras_cmd->ras_status)
-			psp->ras_context.ras_initialized = true;
+			psp->ras_context.context.initialized = true;
 		else
 			dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
 	}
@@ -1275,7 +1275,7 @@ static int psp_ras_unload(struct psp_context *psp)
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_ta_unload_cmd_buf(cmd, psp->ras_context.session_id);
+	psp_prep_ta_unload_cmd_buf(cmd, psp->ras_context.context.session_id);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 			psp->fence_buf_mc_addr);
@@ -1290,7 +1290,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	struct ta_ras_shared_memory *ras_cmd;
 	int ret;
 
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.ras_shared_buf;
+	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
 
 	/*
 	 * TODO: bypass the loading in sriov for now
@@ -1298,7 +1298,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	ret = psp_ta_invoke(psp, ta_cmd_id, psp->ras_context.session_id);
+	ret = psp_ta_invoke(psp, ta_cmd_id, psp->ras_context.context.session_id);
 
 	if (amdgpu_ras_intr_triggered())
 		return ret;
@@ -1354,10 +1354,10 @@ int psp_ras_enable_features(struct psp_context *psp,
 	struct ta_ras_shared_memory *ras_cmd;
 	int ret;
 
-	if (!psp->ras_context.ras_initialized)
+	if (!psp->ras_context.context.initialized)
 		return -EINVAL;
 
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.ras_shared_buf;
+	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
 	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
 
 	if (enable)
@@ -1384,19 +1384,19 @@ static int psp_ras_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->ras_context.ras_initialized)
+	if (!psp->ras_context.context.initialized)
 		return 0;
 
 	ret = psp_ras_unload(psp);
 	if (ret)
 		return ret;
 
-	psp->ras_context.ras_initialized = false;
+	psp->ras_context.context.initialized = false;
 
 	/* free ras shared memory */
-	amdgpu_bo_free_kernel(&psp->ras_context.ras_shared_bo,
-			&psp->ras_context.ras_shared_mc_addr,
-			&psp->ras_context.ras_shared_buf);
+	amdgpu_bo_free_kernel(&psp->ras_context.context.mem_context.shared_bo,
+			&psp->ras_context.context.mem_context.shared_mc_addr,
+			&psp->ras_context.context.mem_context.shared_buf);
 
 	return 0;
 }
@@ -1460,7 +1460,7 @@ static int psp_ras_initialize(struct psp_context *psp)
 		}
 	}
 
-	if (!psp->ras_context.ras_initialized) {
+	if (!psp->ras_context.context.initialized) {
 		ret = psp_ras_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1479,10 +1479,10 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	struct ta_ras_shared_memory *ras_cmd;
 	int ret;
 
-	if (!psp->ras_context.ras_initialized)
+	if (!psp->ras_context.context.initialized)
 		return -EINVAL;
 
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.ras_shared_buf;
+	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
 	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
 
 	ras_cmd->cmd_id = TA_RAS_COMMAND__TRIGGER_ERROR;
@@ -1512,9 +1512,9 @@ static int psp_hdcp_init_shared_buf(struct psp_context *psp)
 	 */
 	ret = amdgpu_bo_create_kernel(psp->adev, PSP_HDCP_SHARED_MEM_SIZE,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->hdcp_context.hdcp_shared_bo,
-				      &psp->hdcp_context.hdcp_shared_mc_addr,
-				      &psp->hdcp_context.hdcp_shared_buf);
+				      &psp->hdcp_context.context.mem_context.shared_bo,
+				      &psp->hdcp_context.context.mem_context.shared_mc_addr,
+				      &psp->hdcp_context.context.mem_context.shared_buf);
 
 	return ret;
 }
@@ -1538,14 +1538,14 @@ static int psp_hdcp_load(struct psp_context *psp)
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
 				 psp->hdcp.size_bytes,
-				 psp->hdcp_context.hdcp_shared_mc_addr,
+				 psp->hdcp_context.context.mem_context.shared_mc_addr,
 				 PSP_HDCP_SHARED_MEM_SIZE);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
 	if (!ret) {
-		psp->hdcp_context.hdcp_initialized = true;
-		psp->hdcp_context.session_id = cmd->resp.session_id;
+		psp->hdcp_context.context.initialized = true;
+		psp->hdcp_context.context.session_id = cmd->resp.session_id;
 		mutex_init(&psp->hdcp_context.mutex);
 	}
 
@@ -1569,7 +1569,7 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->hdcp_context.hdcp_initialized) {
+	if (!psp->hdcp_context.context.initialized) {
 		ret = psp_hdcp_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1595,7 +1595,7 @@ static int psp_hdcp_unload(struct psp_context *psp)
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_ta_unload_cmd_buf(cmd, psp->hdcp_context.session_id);
+	psp_prep_ta_unload_cmd_buf(cmd, psp->hdcp_context.context.session_id);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
@@ -1612,7 +1612,7 @@ int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	return psp_ta_invoke(psp, ta_cmd_id, psp->hdcp_context.session_id);
+	return psp_ta_invoke(psp, ta_cmd_id, psp->hdcp_context.context.session_id);
 }
 
 static int psp_hdcp_terminate(struct psp_context *psp)
@@ -1625,8 +1625,8 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->hdcp_context.hdcp_initialized) {
-		if (psp->hdcp_context.hdcp_shared_buf)
+	if (!psp->hdcp_context.context.initialized) {
+		if (psp->hdcp_context.context.mem_context.shared_buf)
 			goto out;
 		else
 			return 0;
@@ -1636,13 +1636,13 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	if (ret)
 		return ret;
 
-	psp->hdcp_context.hdcp_initialized = false;
+	psp->hdcp_context.context.initialized = false;
 
 out:
 	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
-			      &psp->hdcp_context.hdcp_shared_mc_addr,
-			      &psp->hdcp_context.hdcp_shared_buf);
+	amdgpu_bo_free_kernel(&psp->hdcp_context.context.mem_context.shared_bo,
+			      &psp->hdcp_context.context.mem_context.shared_mc_addr,
+			      &psp->hdcp_context.context.mem_context.shared_buf);
 
 	return 0;
 }
@@ -1659,9 +1659,9 @@ static int psp_dtm_init_shared_buf(struct psp_context *psp)
 	 */
 	ret = amdgpu_bo_create_kernel(psp->adev, PSP_DTM_SHARED_MEM_SIZE,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->dtm_context.dtm_shared_bo,
-				      &psp->dtm_context.dtm_shared_mc_addr,
-				      &psp->dtm_context.dtm_shared_buf);
+				      &psp->dtm_context.context.mem_context.shared_bo,
+				      &psp->dtm_context.context.mem_context.shared_mc_addr,
+				      &psp->dtm_context.context.mem_context.shared_buf);
 
 	return ret;
 }
@@ -1684,14 +1684,14 @@ static int psp_dtm_load(struct psp_context *psp)
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
 				 psp->dtm.size_bytes,
-				 psp->dtm_context.dtm_shared_mc_addr,
+				 psp->dtm_context.context.mem_context.shared_mc_addr,
 				 PSP_DTM_SHARED_MEM_SIZE);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
 	if (!ret) {
-		psp->dtm_context.dtm_initialized = true;
-		psp->dtm_context.session_id = cmd->resp.session_id;
+		psp->dtm_context.context.initialized = true;
+		psp->dtm_context.context.session_id = cmd->resp.session_id;
 		mutex_init(&psp->dtm_context.mutex);
 	}
 
@@ -1716,7 +1716,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->dtm_context.dtm_initialized) {
+	if (!psp->dtm_context.context.initialized) {
 		ret = psp_dtm_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1742,7 +1742,7 @@ static int psp_dtm_unload(struct psp_context *psp)
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_ta_unload_cmd_buf(cmd, psp->dtm_context.session_id);
+	psp_prep_ta_unload_cmd_buf(cmd, psp->dtm_context.context.session_id);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
@@ -1759,7 +1759,7 @@ int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	return psp_ta_invoke(psp, ta_cmd_id, psp->dtm_context.session_id);
+	return psp_ta_invoke(psp, ta_cmd_id, psp->dtm_context.context.session_id);
 }
 
 static int psp_dtm_terminate(struct psp_context *psp)
@@ -1772,8 +1772,8 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->dtm_context.dtm_initialized) {
-		if (psp->dtm_context.dtm_shared_buf)
+	if (!psp->dtm_context.context.initialized) {
+		if (psp->dtm_context.context.mem_context.shared_buf)
 			goto out;
 		else
 			return 0;
@@ -1783,13 +1783,13 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	if (ret)
 		return ret;
 
-	psp->dtm_context.dtm_initialized = false;
+	psp->dtm_context.context.initialized = false;
 
 out:
 	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
-			      &psp->dtm_context.dtm_shared_mc_addr,
-			      &psp->dtm_context.dtm_shared_buf);
+	amdgpu_bo_free_kernel(&psp->dtm_context.context.mem_context.shared_bo,
+			      &psp->dtm_context.context.mem_context.shared_mc_addr,
+			      &psp->dtm_context.context.mem_context.shared_buf);
 
 	return 0;
 }
@@ -1806,9 +1806,9 @@ static int psp_rap_init_shared_buf(struct psp_context *psp)
 	 */
 	ret = amdgpu_bo_create_kernel(psp->adev, PSP_RAP_SHARED_MEM_SIZE,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->rap_context.rap_shared_bo,
-				      &psp->rap_context.rap_shared_mc_addr,
-				      &psp->rap_context.rap_shared_buf);
+				      &psp->rap_context.context.mem_context.shared_bo,
+				      &psp->rap_context.context.mem_context.shared_mc_addr,
+				      &psp->rap_context.context.mem_context.shared_buf);
 
 	return ret;
 }
@@ -1825,14 +1825,14 @@ static int psp_rap_load(struct psp_context *psp)
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
 				 psp->rap.size_bytes,
-				 psp->rap_context.rap_shared_mc_addr,
+				 psp->rap_context.context.mem_context.shared_mc_addr,
 				 PSP_RAP_SHARED_MEM_SIZE);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
 	if (!ret) {
-		psp->rap_context.rap_initialized = true;
-		psp->rap_context.session_id = cmd->resp.session_id;
+		psp->rap_context.context.initialized = true;
+		psp->rap_context.context.session_id = cmd->resp.session_id;
 		mutex_init(&psp->rap_context.mutex);
 	}
 
@@ -1846,7 +1846,7 @@ static int psp_rap_unload(struct psp_context *psp)
 	int ret;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_ta_unload_cmd_buf(cmd, psp->rap_context.session_id);
+	psp_prep_ta_unload_cmd_buf(cmd, psp->rap_context.context.session_id);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
@@ -1872,7 +1872,7 @@ static int psp_rap_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->rap_context.rap_initialized) {
+	if (!psp->rap_context.context.initialized) {
 		ret = psp_rap_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -1886,11 +1886,11 @@ static int psp_rap_initialize(struct psp_context *psp)
 	if (ret || status != TA_RAP_STATUS__SUCCESS) {
 		psp_rap_unload(psp);
 
-		amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
-			      &psp->rap_context.rap_shared_mc_addr,
-			      &psp->rap_context.rap_shared_buf);
+		amdgpu_bo_free_kernel(&psp->rap_context.context.mem_context.shared_bo,
+			      &psp->rap_context.context.mem_context.shared_mc_addr,
+			      &psp->rap_context.context.mem_context.shared_buf);
 
-		psp->rap_context.rap_initialized = false;
+		psp->rap_context.context.initialized = false;
 
 		dev_warn(psp->adev->dev, "RAP TA initialize fail (%d) status %d.\n",
 			 ret, status);
@@ -1905,17 +1905,17 @@ static int psp_rap_terminate(struct psp_context *psp)
 {
 	int ret;
 
-	if (!psp->rap_context.rap_initialized)
+	if (!psp->rap_context.context.initialized)
 		return 0;
 
 	ret = psp_rap_unload(psp);
 
-	psp->rap_context.rap_initialized = false;
+	psp->rap_context.context.initialized = false;
 
 	/* free rap shared memory */
-	amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
-			      &psp->rap_context.rap_shared_mc_addr,
-			      &psp->rap_context.rap_shared_buf);
+	amdgpu_bo_free_kernel(&psp->rap_context.context.mem_context.shared_bo,
+			      &psp->rap_context.context.mem_context.shared_mc_addr,
+			      &psp->rap_context.context.mem_context.shared_buf);
 
 	return ret;
 }
@@ -1925,7 +1925,7 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id, enum ta_rap_stat
 	struct ta_rap_shared_memory *rap_cmd;
 	int ret = 0;
 
-	if (!psp->rap_context.rap_initialized)
+	if (!psp->rap_context.context.initialized)
 		return 0;
 
 	if (ta_cmd_id != TA_CMD_RAP__INITIALIZE &&
@@ -1935,13 +1935,13 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id, enum ta_rap_stat
 	mutex_lock(&psp->rap_context.mutex);
 
 	rap_cmd = (struct ta_rap_shared_memory *)
-		  psp->rap_context.rap_shared_buf;
+		  psp->rap_context.context.mem_context.shared_buf;
 	memset(rap_cmd, 0, sizeof(struct ta_rap_shared_memory));
 
 	rap_cmd->cmd_id = ta_cmd_id;
 	rap_cmd->validation_method_id = METHOD_A;
 
-	ret = psp_ta_invoke(psp, rap_cmd->cmd_id, psp->rap_context.session_id);
+	ret = psp_ta_invoke(psp, rap_cmd->cmd_id, psp->rap_context.context.session_id);
 	if (ret)
 		goto out_unlock;
 
@@ -1966,9 +1966,9 @@ static int psp_securedisplay_init_shared_buf(struct psp_context *psp)
 	 */
 	ret = amdgpu_bo_create_kernel(psp->adev, PSP_SECUREDISPLAY_SHARED_MEM_SIZE,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->securedisplay_context.securedisplay_shared_bo,
-				      &psp->securedisplay_context.securedisplay_shared_mc_addr,
-				      &psp->securedisplay_context.securedisplay_shared_buf);
+				      &psp->securedisplay_context.context.mem_context.shared_bo,
+				      &psp->securedisplay_context.context.mem_context.shared_mc_addr,
+				      &psp->securedisplay_context.context.mem_context.shared_buf);
 
 	return ret;
 }
@@ -1984,14 +1984,14 @@ static int psp_securedisplay_load(struct psp_context *psp)
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
 				 psp->securedisplay.size_bytes,
-				 psp->securedisplay_context.securedisplay_shared_mc_addr,
+				 psp->securedisplay_context.context.mem_context.shared_mc_addr,
 				 PSP_SECUREDISPLAY_SHARED_MEM_SIZE);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
 	if (!ret) {
-		psp->securedisplay_context.securedisplay_initialized = true;
-		psp->securedisplay_context.session_id = cmd->resp.session_id;
+		psp->securedisplay_context.context.initialized = true;
+		psp->securedisplay_context.context.session_id = cmd->resp.session_id;
 		mutex_init(&psp->securedisplay_context.mutex);
 	}
 
@@ -2005,7 +2005,7 @@ static int psp_securedisplay_unload(struct psp_context *psp)
 	int ret;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_ta_unload_cmd_buf(cmd, psp->securedisplay_context.session_id);
+	psp_prep_ta_unload_cmd_buf(cmd, psp->securedisplay_context.context.session_id);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
@@ -2031,7 +2031,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 		return 0;
 	}
 
-	if (!psp->securedisplay_context.securedisplay_initialized) {
+	if (!psp->securedisplay_context.context.initialized) {
 		ret = psp_securedisplay_init_shared_buf(psp);
 		if (ret)
 			return ret;
@@ -2048,11 +2048,11 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	if (ret) {
 		psp_securedisplay_unload(psp);
 
-		amdgpu_bo_free_kernel(&psp->securedisplay_context.securedisplay_shared_bo,
-			      &psp->securedisplay_context.securedisplay_shared_mc_addr,
-			      &psp->securedisplay_context.securedisplay_shared_buf);
+		amdgpu_bo_free_kernel(&psp->securedisplay_context.context.mem_context.shared_bo,
+			      &psp->securedisplay_context.context.mem_context.shared_mc_addr,
+			      &psp->securedisplay_context.context.mem_context.shared_buf);
 
-		psp->securedisplay_context.securedisplay_initialized = false;
+		psp->securedisplay_context.context.initialized = false;
 
 		dev_err(psp->adev->dev, "SECUREDISPLAY TA initialize fail.\n");
 		return -EINVAL;
@@ -2077,19 +2077,19 @@ static int psp_securedisplay_terminate(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->securedisplay_context.securedisplay_initialized)
+	if (!psp->securedisplay_context.context.initialized)
 		return 0;
 
 	ret = psp_securedisplay_unload(psp);
 	if (ret)
 		return ret;
 
-	psp->securedisplay_context.securedisplay_initialized = false;
+	psp->securedisplay_context.context.initialized = false;
 
 	/* free securedisplay shared memory */
-	amdgpu_bo_free_kernel(&psp->securedisplay_context.securedisplay_shared_bo,
-			      &psp->securedisplay_context.securedisplay_shared_mc_addr,
-			      &psp->securedisplay_context.securedisplay_shared_buf);
+	amdgpu_bo_free_kernel(&psp->securedisplay_context.context.mem_context.shared_bo,
+			      &psp->securedisplay_context.context.mem_context.shared_mc_addr,
+			      &psp->securedisplay_context.context.mem_context.shared_buf);
 
 	return ret;
 }
@@ -2098,7 +2098,7 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
 	int ret;
 
-	if (!psp->securedisplay_context.securedisplay_initialized)
+	if (!psp->securedisplay_context.context.initialized)
 		return -EINVAL;
 
 	if (ta_cmd_id != TA_SECUREDISPLAY_COMMAND__QUERY_TA &&
@@ -2107,7 +2107,7 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 
 	mutex_lock(&psp->securedisplay_context.mutex);
 
-	ret = psp_ta_invoke(psp, ta_cmd_id, psp->securedisplay_context.session_id);
+	ret = psp_ta_invoke(psp, ta_cmd_id, psp->securedisplay_context.context.session_id);
 
 	mutex_unlock(&psp->securedisplay_context.mutex);
 
@@ -2727,7 +2727,7 @@ static int psp_suspend(void *handle)
 	struct psp_context *psp = &adev->psp;
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1 &&
-	    psp->xgmi_context.initialized == 1) {
+	    psp->xgmi_context.context.initialized) {
 		ret = psp_xgmi_terminate(psp);
 		if (ret) {
 			DRM_ERROR("Failed to terminate xgmi ta\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2cd84e21592a4c..dc0d6064623433 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -136,59 +136,31 @@ struct psp_asd_context {
 	uint32_t		session_id;
 };
 
-struct psp_xgmi_context {
-	uint8_t				initialized;
-	uint32_t			session_id;
-	struct amdgpu_bo                *xgmi_shared_bo;
-	uint64_t                        xgmi_shared_mc_addr;
-	void                            *xgmi_shared_buf;
-	struct psp_xgmi_topology_info	top_info;
+struct ta_mem_context {
+	struct amdgpu_bo		*shared_bo;
+	uint64_t		shared_mc_addr;
+	void			*shared_buf;
 };
 
-struct psp_ras_context {
-	/*ras fw*/
-	bool			ras_initialized;
+struct ta_context {
+	bool			initialized;
 	uint32_t		session_id;
-	struct amdgpu_bo	*ras_shared_bo;
-	uint64_t		ras_shared_mc_addr;
-	void			*ras_shared_buf;
-	struct amdgpu_ras	*ras;
+	struct ta_mem_context	mem_context;
 };
 
-struct psp_hdcp_context {
-	bool			hdcp_initialized;
-	uint32_t		session_id;
-	struct amdgpu_bo	*hdcp_shared_bo;
-	uint64_t		hdcp_shared_mc_addr;
-	void			*hdcp_shared_buf;
-	struct mutex		mutex;
-};
-
-struct psp_dtm_context {
-	bool			dtm_initialized;
-	uint32_t		session_id;
-	struct amdgpu_bo	*dtm_shared_bo;
-	uint64_t		dtm_shared_mc_addr;
-	void			*dtm_shared_buf;
-	struct mutex		mutex;
+struct ta_cp_context {
+	struct ta_context		context;
+	struct mutex			mutex;
 };
 
-struct psp_rap_context {
-	bool			rap_initialized;
-	uint32_t		session_id;
-	struct amdgpu_bo	*rap_shared_bo;
-	uint64_t		rap_shared_mc_addr;
-	void			*rap_shared_buf;
-	struct mutex		mutex;
+struct psp_xgmi_context {
+	struct ta_context		context;
+	struct psp_xgmi_topology_info	top_info;
 };
 
-struct psp_securedisplay_context {
-	bool			securedisplay_initialized;
-	uint32_t		session_id;
-	struct amdgpu_bo	*securedisplay_shared_bo;
-	uint64_t		securedisplay_shared_mc_addr;
-	void			*securedisplay_shared_buf;
-	struct mutex		mutex;
+struct psp_ras_context {
+	struct ta_context		context;
+	struct amdgpu_ras		*ras;
 };
 
 #define MEM_TRAIN_SYSTEM_SIGNATURE		0x54534942
@@ -363,10 +335,10 @@ struct psp_context
 	struct psp_asd_context		asd_context;
 	struct psp_xgmi_context		xgmi_context;
 	struct psp_ras_context		ras_context;
-	struct psp_hdcp_context 	hdcp_context;
-	struct psp_dtm_context		dtm_context;
-	struct psp_rap_context		rap_context;
-	struct psp_securedisplay_context	securedisplay_context;
+	struct ta_cp_context		hdcp_context;
+	struct ta_cp_context		dtm_context;
+	struct ta_cp_context		rap_context;
+	struct ta_cp_context		securedisplay_context;
 	struct mutex			mutex;
 	struct psp_memory_training_context mem_train_ctx;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
index 51909bf8798ccf..12010c988c8b59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
@@ -76,7 +76,7 @@ static ssize_t amdgpu_rap_debugfs_write(struct file *f, const char __user *buf,
 			dev_info(adev->dev, "RAP L0 validate test success.\n");
 		} else {
 			rap_shared_mem = (struct ta_rap_shared_memory *)
-					 adev->psp.rap_context.rap_shared_buf;
+					 adev->psp.rap_context.context.mem_context.shared_buf;
 			rap_cmd_output = &(rap_shared_mem->rap_out_message.output);
 
 			dev_info(adev->dev, "RAP test failed, the output is:\n");
@@ -119,7 +119,7 @@ void amdgpu_rap_debugfs_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 
-	if (!adev->psp.rap_context.rap_initialized)
+	if (!adev->psp.rap_context.context.initialized)
 		return;
 
 	debugfs_create_file("rap_test", S_IWUSR, minor->debugfs_root,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 123453999093d3..cc7597a15fe977 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -80,7 +80,7 @@ void psp_securedisplay_parse_resp_status(struct psp_context *psp,
 void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct securedisplay_cmd **cmd,
 	enum ta_securedisplay_command command_id)
 {
-	*cmd = (struct securedisplay_cmd *)psp->securedisplay_context.securedisplay_shared_buf;
+	*cmd = (struct securedisplay_cmd *)psp->securedisplay_context.context.mem_context.shared_buf;
 	memset(*cmd, 0, sizeof(struct securedisplay_cmd));
 	(*cmd)->status = TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE;
 	(*cmd)->cmd_id = command_id;
@@ -170,7 +170,7 @@ void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 
-	if (!adev->psp.securedisplay_context.securedisplay_initialized)
+	if (!adev->psp.securedisplay_context.context.initialized)
 		return;
 
 	debugfs_create_file("securedisplay_test", S_IWUSR, adev_to_drm(adev)->primary->debugfs_root,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 8e39e9245d063b..c5f1dc3b596143 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -79,12 +79,12 @@ static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint
 
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 
-	if (!psp->hdcp_context.hdcp_initialized) {
+	if (!psp->hdcp_context.context.initialized) {
 		DRM_WARN("Failed to get hdcp srm. HDCP TA is not initialized.");
 		return NULL;
 	}
 
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP_GET_SRM;
@@ -105,12 +105,12 @@ static int psp_set_srm(struct psp_context *psp, uint8_t *srm, uint32_t srm_size,
 
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 
-	if (!psp->hdcp_context.hdcp_initialized) {
+	if (!psp->hdcp_context.context.initialized) {
 		DRM_WARN("Failed to get hdcp srm. HDCP TA is not initialized.");
 		return -EINVAL;
 	}
 
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	memcpy(hdcp_cmd->in_msg.hdcp_set_srm.srm_buf, srm, srm_size);
@@ -414,12 +414,12 @@ static bool enable_assr(void *handle, struct dc_link *link)
 	struct ta_dtm_shared_memory *dtm_cmd;
 	bool res = true;
 
-	if (!psp->dtm_context.dtm_initialized) {
+	if (!psp->dtm_context.context.initialized) {
 		DRM_INFO("Failed to enable ASSR, DTM TA is not initialized.");
 		return false;
 	}
 
-	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
+	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.context.mem_context.shared_buf;
 
 	mutex_lock(&psp->dtm_context.mutex);
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index ade86a042398fb..e9bd84ec027d19 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -54,7 +54,7 @@ static enum mod_hdcp_status remove_display_from_topology_v2(
 			get_active_display_at_index(hdcp, index);
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
-	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
+	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.context.mem_context.shared_buf;
 
 	if (!display || !is_display_active(display))
 		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
@@ -90,7 +90,7 @@ static enum mod_hdcp_status remove_display_from_topology_v3(
 		get_active_display_at_index(hdcp, index);
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
-	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
+	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.context.mem_context.shared_buf;
 
 	if (!display || !is_display_active(display))
 		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
@@ -128,13 +128,13 @@ static enum mod_hdcp_status add_display_to_topology_v2(
 	struct mod_hdcp_link *link = &hdcp->connection.link;
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
-	if (!psp->dtm_context.dtm_initialized) {
+	if (!psp->dtm_context.context.initialized) {
 		DRM_INFO("Failed to add display topology, DTM TA is not initialized.");
 		display->state = MOD_HDCP_DISPLAY_INACTIVE;
 		return MOD_HDCP_STATUS_FAILURE;
 	}
 
-	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
+	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.context.mem_context.shared_buf;
 
 	mutex_lock(&psp->dtm_context.mutex);
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
@@ -175,13 +175,13 @@ static enum mod_hdcp_status add_display_to_topology_v3(
 	struct mod_hdcp_link *link = &hdcp->connection.link;
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
-	if (!psp->dtm_context.dtm_initialized) {
+	if (!psp->dtm_context.context.initialized) {
 		DRM_INFO("Failed to add display topology, DTM TA is not initialized.");
 		display->state = MOD_HDCP_DISPLAY_INACTIVE;
 		return MOD_HDCP_STATUS_FAILURE;
 	}
 
-	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.dtm_shared_buf;
+	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.context.mem_context.shared_buf;
 
 	mutex_lock(&psp->dtm_context.mutex);
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
@@ -253,12 +253,12 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
-	if (!psp->hdcp_context.hdcp_initialized) {
+	if (!psp->hdcp_context.context.initialized) {
 		DRM_ERROR("Failed to create hdcp session. HDCP TA is not initialized.");
 		return MOD_HDCP_STATUS_FAILURE;
 	}
 
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 
 	mutex_lock(&psp->hdcp_context.mutex);
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
@@ -293,7 +293,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_destroy_session(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	hdcp_cmd->in_msg.hdcp1_destroy_session.session_handle = hdcp->auth.id;
@@ -325,7 +325,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_rx(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	hdcp_cmd->in_msg.hdcp1_first_part_authentication.session_handle = hdcp->auth.id;
@@ -367,7 +367,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	hdcp_cmd->in_msg.hdcp1_enable_encryption.session_handle = hdcp->auth.id;
@@ -393,7 +393,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_validate_ksvlist_vp(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	hdcp_cmd->in_msg.hdcp1_second_part_authentication.session_handle = hdcp->auth.id;
@@ -436,7 +436,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_dp_stream_encryption(struct mod_hdcp
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
 
@@ -471,7 +471,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_link_maintenance(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
@@ -498,7 +498,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 
-	if (!psp->hdcp_context.hdcp_initialized) {
+	if (!psp->hdcp_context.context.initialized) {
 		DRM_ERROR("Failed to create hdcp session, HDCP TA is not initialized");
 		return MOD_HDCP_STATUS_FAILURE;
 	}
@@ -508,7 +508,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 
 	mutex_lock(&psp->hdcp_context.mutex);
 
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	hdcp_cmd->in_msg.hdcp2_create_session_v2.display_handle = display->index;
@@ -545,7 +545,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_destroy_session(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	hdcp_cmd->in_msg.hdcp2_destroy_session.session_handle = hdcp->auth.id;
@@ -579,7 +579,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_ake_init(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
@@ -611,7 +611,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_ake_cert(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
@@ -671,7 +671,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_prime(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
@@ -717,7 +717,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_lc_init(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
@@ -750,7 +750,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_l_prime(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
@@ -785,7 +785,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_eks(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
@@ -833,7 +833,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp *hdcp)
 
 	mutex_lock(&psp->hdcp_context.mutex);
 
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	hdcp_cmd->in_msg.hdcp2_set_encryption.session_handle = hdcp->auth.id;
@@ -862,7 +862,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_rx_id_list(struct mod_hdcp *hdcp)
 
 	mutex_lock(&psp->hdcp_context.mutex);
 
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
@@ -914,7 +914,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
@@ -958,7 +958,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_management(struct mod_hdcp *h
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
@@ -994,7 +994,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_hdcp *hdcp)
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
 	mutex_lock(&psp->hdcp_context.mutex);
-	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
+	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
-- 
2.17.1

