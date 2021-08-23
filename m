Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF8C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 09:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAD66137F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 09:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABAD66137F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503E789CE2;
	Mon, 23 Aug 2021 09:28:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A63C89CE2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 09:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1yguFXb64KcN+hH2Lr+AWjXln9LwCNedcDHGgqo80R5AFFs5uv5LFl0G0tINwGmkhJZ9qBzt5XCc0cW5OGdie8f5QN5GikOruxNoBIqmL9eCQbNN1OhCcfblfduhmnqi1narq/oigSi8iUZmTWttDKexb12H8yTq6Cec1UiQGhdDOofx2wopSzBvU94Vm8F1BI/2fm4oTaK6iCc0xVuoeaDkJJBe/pMpfEh2+2Evc7YIt2QEYdkTXrdy1KRUnw7cuekIDfwzh+9QJAiRyLhryK8AUVkzI/G2gsQiuTtoH6g8XSFkoKBmEUs4A7HMCixYseomvfOgTPvxBjVeoH8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLVk/8WrV2mi19FMwbnafYcpZkF87qClFwyM+WlfF8c=;
 b=EUnMdVtn8pzSH9uKqNLKjOSPko3IV4yxHwDVz3ljm/0OOmgUVY7lhDbKwh8pmAFL8HkG186c9w/Ogilgao6xwvwdWtx9hhSVLJm7Ubdom13Xp+z4QLInGqOUYwt8PXNtQ341eQyoPoW3Q4HPyki48nLZqW9NefWCRYafv6MEE7/IOGs4hFc6RlTNqIduAd0ri0mGeebyjkfv13OMAd4BR7rzJk2S0SfkIfixUYc9eB2eZT4cjZRGuKOaqBplcyhMsRJaKn7T1jf6nLC6zWF8y72CBTr/FD8jTgCNPvszAM1exjdIbC7xY871CLZHTdARQWI+jnYvdOriZLi3n7hfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLVk/8WrV2mi19FMwbnafYcpZkF87qClFwyM+WlfF8c=;
 b=NaFi/3ALlczdXmYX1G7jritV3W3GovhysQxJd/EnPvG9wZvgXg/NxSFBpeYR7r2t0RgkYupFFcDh3dX0ZV93fvywoNdJaNhUy3kRWba59tp0L4BJoftbyS3WKPFNqXibE1EhrJuoNG2Y3LD5Ogp2cW2QMT6jPMpRsT7ugxJ+lD4=
Received: from DM6PR06CA0055.namprd06.prod.outlook.com (2603:10b6:5:54::32) by
 MN2PR12MB4013.namprd12.prod.outlook.com (2603:10b6:208:163::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 08:55:25 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::b3) by DM6PR06CA0055.outlook.office365.com
 (2603:10b6:5:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 08:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 08:55:24 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 03:55:22 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amd/amdgpu: consolidate PSP TA init shared buf functions
Date: Mon, 23 Aug 2021 16:55:07 +0800
Message-ID: <20210823085507.6175-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 318c1b3e-1c90-4166-d768-08d96613bf07
X-MS-TrafficTypeDiagnostic: MN2PR12MB4013:
X-Microsoft-Antispam-PRVS: <MN2PR12MB401371B4680F16F7A463380C91C49@MN2PR12MB4013.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5M8lK8wubakVMuwWEcPebOpP9PC4oHw/WLEC6On8n7jCbEddY2T/p+7YDbzA4QEO0h6XhOo6DFqbhXEKlGDd8BZvRzcFfCuo1NFCQiQit2jibaayZaut7h67HUQHwtEzvUdptwlSFqIcKwHazPkkIp3iVRVpuOXgq1NZysznZhQCGfW16bBFmiEFlvxbCeBoKxKELiP/Iq/0L66zcUbMLolugd8oJUtLmEHdYnQQ7OgjVwA2DUeDcrLYRyFf2Q9lqFXuHYd5GUS3Q5d9gCaBDBO/I5qr1tPpFwMTpqnpwZJgDZ2DHZYSeMK0tPu+QRcdhE0fjrynH1NUhNslFk9o8Hwe+l5h1sFisccmO5SWmZl3JTLLkK6PWRQz9uOgmjN6CrOS/fWgnXyXKP3/iSXdHRgms/H0wMhAs/tY0NPpA3WRJEsHyPH0MCP4YFqWDUTcGklwNoaQvm0Pz+Qbebt7En39lWSyidaHqDCne2/TTzbQxFA/gwfdJZpkxDUtj4aZFVfODxCuT5EgGWo7R1dIRdOlhAWP+UySzo1QTeFXCA+/Jw1lCXB+VFt7b8Dj80mOIGPZ+8ernrieuN40C+fIw/h/w7eo2e3pLT5lblXeIbBS9QjbzGm4TCDIzUfNOAUHUg/iAyThDdarcefJI9oeb7Hvpq8aYGiJOzprI4QZMnkU5EGBTz2hyxSPjGDQbEyzpfAaKC62rFYqU+TD/Fs/cTMSkX5oCix3tIxxcYpL2g1nW1IRKNDOEe+70iFRuHEVpMTX3PJfoQDikKm6V3XrjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(5660300002)(1076003)(8936002)(4326008)(7696005)(2906002)(44832011)(336012)(16526019)(2616005)(356005)(70586007)(508600001)(8676002)(36756003)(186003)(6666004)(83380400001)(47076005)(316002)(36860700001)(6916009)(26005)(426003)(70206006)(82310400003)(34020700004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 08:55:24.3970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318c1b3e-1c90-4166-d768-08d96613bf07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4013
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

Change-Id: I779f4fb52ecc661c25c42ced487719f08f3d875d
Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 142 +++++++-----------------
 1 file changed, 43 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a78a832d8fea23..23efdc67250272 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -899,23 +899,37 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 	cmd->cmd.cmd_load_ta.cmd_buf_len	 = ta_shared_size;
 }
 
-static int psp_xgmi_init_shared_buf(struct psp_context *psp)
+static int psp_ta_init_shared_buf(struct psp_context *psp,
+				  struct ta_mem_context *mem_ctx,
+				  uint32_t shared_mem_size)
 {
 	int ret;
 
 	/*
-	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
-	 * physical) for xgmi ta <-> Driver
-	 */
-	ret = amdgpu_bo_create_kernel(psp->adev, PSP_XGMI_SHARED_MEM_SIZE,
-				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->xgmi_context.context.mem_context.shared_bo,
-				      &psp->xgmi_context.context.mem_context.shared_mc_addr,
-				      &psp->xgmi_context.context.mem_context.shared_buf);
+	* Allocate 16k memory aligned to 4k from Frame Buffer (local
+	* physical) for ta to host memory
+	*/
+	ret = amdgpu_bo_create_kernel(psp->adev, shared_mem_size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &mem_ctx->shared_bo,
+				      &mem_ctx->shared_mc_addr,
+				      &mem_ctx->shared_buf);
 
 	return ret;
 }
 
+static void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
+{
+	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
+			      &mem_ctx->shared_buf);
+}
+
+static int psp_xgmi_init_shared_buf(struct psp_context *psp)
+{
+	return psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context,
+				      PSP_XGMI_SHARED_MEM_SIZE);
+}
+
 static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				       uint32_t ta_cmd_id,
 				       uint32_t session_id)
@@ -1020,9 +1034,7 @@ int psp_xgmi_terminate(struct psp_context *psp)
 	psp->xgmi_context.context.initialized = false;
 
 	/* free xgmi shared memory */
-	amdgpu_bo_free_kernel(&psp->xgmi_context.context.mem_context.shared_bo,
-			&psp->xgmi_context.context.mem_context.shared_mc_addr,
-			&psp->xgmi_context.context.mem_context.shared_buf);
+	psp_ta_free_shared_buf(&psp->xgmi_context.context.mem_context);
 
 	return 0;
 }
@@ -1270,19 +1282,8 @@ int psp_xgmi_set_topology_info(struct psp_context *psp,
 // ras begin
 static int psp_ras_init_shared_buf(struct psp_context *psp)
 {
-	int ret;
-
-	/*
-	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
-	 * physical) for ras ta <-> Driver
-	 */
-	ret = amdgpu_bo_create_kernel(psp->adev, PSP_RAS_SHARED_MEM_SIZE,
-			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-			&psp->ras_context.context.mem_context.shared_bo,
-			&psp->ras_context.context.mem_context.shared_mc_addr,
-			&psp->ras_context.context.mem_context.shared_buf);
-
-	return ret;
+	return psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context,
+				      PSP_RAS_SHARED_MEM_SIZE);
 }
 
 static int psp_ras_load(struct psp_context *psp)
@@ -1466,9 +1467,7 @@ static int psp_ras_terminate(struct psp_context *psp)
 	psp->ras_context.context.initialized = false;
 
 	/* free ras shared memory */
-	amdgpu_bo_free_kernel(&psp->ras_context.context.mem_context.shared_bo,
-			&psp->ras_context.context.mem_context.shared_mc_addr,
-			&psp->ras_context.context.mem_context.shared_buf);
+	psp_ta_free_shared_buf(&psp->ras_context.context.mem_context);
 
 	return 0;
 }
@@ -1576,19 +1575,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
 // HDCP start
 static int psp_hdcp_init_shared_buf(struct psp_context *psp)
 {
-	int ret;
-
-	/*
-	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
-	 * physical) for hdcp ta <-> Driver
-	 */
-	ret = amdgpu_bo_create_kernel(psp->adev, PSP_HDCP_SHARED_MEM_SIZE,
-				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->hdcp_context.context.mem_context.shared_bo,
-				      &psp->hdcp_context.context.mem_context.shared_mc_addr,
-				      &psp->hdcp_context.context.mem_context.shared_buf);
-
-	return ret;
+	return psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_context,
+				      PSP_HDCP_SHARED_MEM_SIZE);
 }
 
 static int psp_hdcp_load(struct psp_context *psp)
@@ -1712,9 +1700,7 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 
 out:
 	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->hdcp_context.context.mem_context.shared_bo,
-			      &psp->hdcp_context.context.mem_context.shared_mc_addr,
-			      &psp->hdcp_context.context.mem_context.shared_buf);
+	psp_ta_free_shared_buf(&psp->hdcp_context.context.mem_context);
 
 	return 0;
 }
@@ -1723,19 +1709,8 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 // DTM start
 static int psp_dtm_init_shared_buf(struct psp_context *psp)
 {
-	int ret;
-
-	/*
-	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
-	 * physical) for dtm ta <-> Driver
-	 */
-	ret = amdgpu_bo_create_kernel(psp->adev, PSP_DTM_SHARED_MEM_SIZE,
-				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->dtm_context.context.mem_context.shared_bo,
-				      &psp->dtm_context.context.mem_context.shared_mc_addr,
-				      &psp->dtm_context.context.mem_context.shared_buf);
-
-	return ret;
+	return psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_context,
+				      PSP_DTM_SHARED_MEM_SIZE);
 }
 
 static int psp_dtm_load(struct psp_context *psp)
@@ -1858,10 +1833,8 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	psp->dtm_context.context.initialized = false;
 
 out:
-	/* free hdcp shared memory */
-	amdgpu_bo_free_kernel(&psp->dtm_context.context.mem_context.shared_bo,
-			      &psp->dtm_context.context.mem_context.shared_mc_addr,
-			      &psp->dtm_context.context.mem_context.shared_buf);
+	/* free dtm shared memory */
+	psp_ta_free_shared_buf(&psp->dtm_context.context.mem_context);
 
 	return 0;
 }
@@ -1870,19 +1843,8 @@ static int psp_dtm_terminate(struct psp_context *psp)
 // RAP start
 static int psp_rap_init_shared_buf(struct psp_context *psp)
 {
-	int ret;
-
-	/*
-	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
-	 * physical) for rap ta <-> Driver
-	 */
-	ret = amdgpu_bo_create_kernel(psp->adev, PSP_RAP_SHARED_MEM_SIZE,
-				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->rap_context.context.mem_context.shared_bo,
-				      &psp->rap_context.context.mem_context.shared_mc_addr,
-				      &psp->rap_context.context.mem_context.shared_buf);
-
-	return ret;
+	return psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_context,
+				      PSP_RAP_SHARED_MEM_SIZE);
 }
 
 static int psp_rap_load(struct psp_context *psp)
@@ -1958,9 +1920,7 @@ static int psp_rap_initialize(struct psp_context *psp)
 	if (ret || status != TA_RAP_STATUS__SUCCESS) {
 		psp_rap_unload(psp);
 
-		amdgpu_bo_free_kernel(&psp->rap_context.context.mem_context.shared_bo,
-			      &psp->rap_context.context.mem_context.shared_mc_addr,
-			      &psp->rap_context.context.mem_context.shared_buf);
+		psp_ta_free_shared_buf(&psp->rap_context.context.mem_context);
 
 		psp->rap_context.context.initialized = false;
 
@@ -1985,9 +1945,7 @@ static int psp_rap_terminate(struct psp_context *psp)
 	psp->rap_context.context.initialized = false;
 
 	/* free rap shared memory */
-	amdgpu_bo_free_kernel(&psp->rap_context.context.mem_context.shared_bo,
-			      &psp->rap_context.context.mem_context.shared_mc_addr,
-			      &psp->rap_context.context.mem_context.shared_buf);
+	psp_ta_free_shared_buf(&psp->rap_context.context.mem_context);
 
 	return ret;
 }
@@ -2030,19 +1988,9 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id, enum ta_rap_stat
 /* securedisplay start */
 static int psp_securedisplay_init_shared_buf(struct psp_context *psp)
 {
-	int ret;
-
-	/*
-	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
-	 * physical) for sa ta <-> Driver
-	 */
-	ret = amdgpu_bo_create_kernel(psp->adev, PSP_SECUREDISPLAY_SHARED_MEM_SIZE,
-				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->securedisplay_context.context.mem_context.shared_bo,
-				      &psp->securedisplay_context.context.mem_context.shared_mc_addr,
-				      &psp->securedisplay_context.context.mem_context.shared_buf);
-
-	return ret;
+	return psp_ta_init_shared_buf(
+		psp, &psp->securedisplay_context.context.mem_context,
+		PSP_SECUREDISPLAY_SHARED_MEM_SIZE);
 }
 
 static int psp_securedisplay_load(struct psp_context *psp)
@@ -2120,9 +2068,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	if (ret) {
 		psp_securedisplay_unload(psp);
 
-		amdgpu_bo_free_kernel(&psp->securedisplay_context.context.mem_context.shared_bo,
-			      &psp->securedisplay_context.context.mem_context.shared_mc_addr,
-			      &psp->securedisplay_context.context.mem_context.shared_buf);
+		psp_ta_free_shared_buf(&psp->securedisplay_context.context.mem_context);
 
 		psp->securedisplay_context.context.initialized = false;
 
@@ -2159,9 +2105,7 @@ static int psp_securedisplay_terminate(struct psp_context *psp)
 	psp->securedisplay_context.context.initialized = false;
 
 	/* free securedisplay shared memory */
-	amdgpu_bo_free_kernel(&psp->securedisplay_context.context.mem_context.shared_bo,
-			      &psp->securedisplay_context.context.mem_context.shared_mc_addr,
-			      &psp->securedisplay_context.context.mem_context.shared_buf);
+	psp_ta_free_shared_buf(&psp->securedisplay_context.context.mem_context);
 
 	return ret;
 }
-- 
2.17.1

