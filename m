Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103CBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 22:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 031A410E085;
	Thu, 28 Apr 2022 22:12:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CC410E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 22:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls1o5i3j5oS/jSI7hDJrN9/FVEvkrCZsobH+39+Tx2tU1NAmjlNWWnNV+ms1iccXU13NMqvdI0zmcnJSwDcupfMro/wYYYegV8vl9DtSP6DJbub4+J9jXega5uG5st58NYLJvKXzJNTtWHJRULR54TpzDXDVl+OxrPdhEffweQu3dUJ7j5zsMx6V71+VT/DRtPqtO/Nst6j+SK8K/IS+aJLhuGXw6Bhl1Oq5JrCjgpzjMmrNIoqeywEA9aMkGbnGDPJnkXy9SI4I+Bjn2wl11ifkZspRX+UD14Fpmx5UBvdfYasBsTPiL9XU/H+Oil+w82uJdS5SkiUSLlUGXq7gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+dr0uDpCi6HzWFhrsXKWyq2/DoxAXDn2Dbo26sdCHo=;
 b=Xmft75lpqil2ED9v6wpvO8tGl/jXWzIDsLAvxbMR3MeU4R7PhQRfjrZZXMraNnOIp1btzKA+hIzdhPakaagjQGHdnlKfezSIgfcYgdUUf1sMUpCpmEKGKfRktyYkiiy5gl+WgC240JCzjiy0i1gSmoi8y1jU5WjbHIdRzMQRBGmqYYKYhYlKfbJQ9ZadyWryU6di0dFIuzdbl22aJNV01ROvMI5DOZr4J+30l7S6jKu+Zr4neWGicECk24Sj5QU66tFgcp7/afG+30vdsBbID9srFSnxZ+KyXSygoDcmxs3BvjQDMvExhs62upGnU+f3AyyLcifaeWbdPX/XEBUJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+dr0uDpCi6HzWFhrsXKWyq2/DoxAXDn2Dbo26sdCHo=;
 b=I7xBTfmAmSwHhp7DZWAzJuD0+vhwgTJfbVtxgiOWwMB24WFLP/i69zqOLjC44dX+J+qGvwgwYX5YyX4b+Wm0NZs/NDOdCDZZxqobKNxb/ykKV0uCIPk/csaxIvTsy9u5vc1JSJ0hiRipeRTK1sSwcjhBdiJDjqB79lk8DZqPPtc=
Received: from DS7PR03CA0256.namprd03.prod.outlook.com (2603:10b6:5:3b3::21)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.14; Thu, 28 Apr 2022 22:12:44 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::5e) by DS7PR03CA0256.outlook.office365.com
 (2603:10b6:5:3b3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 28 Apr 2022 22:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 22:12:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 17:12:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu/psp: drop load/unload/init_shared_buf wrappers
Date: Thu, 28 Apr 2022 18:12:28 -0400
Message-ID: <20220428221231.1030104-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428221231.1030104-1-alexander.deucher@amd.com>
References: <20220428221231.1030104-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4d1b641-17c0-4bdc-0fb3-08da29643838
X-MS-TrafficTypeDiagnostic: DM4PR12MB6232:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6232574C0FFF99D2C4BDDA81F7FD9@DM4PR12MB6232.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yc2oqsV3OUKuEyrffVa7GUENKmaHobvvos/0dK/gfVGd6blHvpUXtcrMbRgBE0kVoLkUBWHw2PVg9T28gMZqXIw2tKG4wklgzzusroyllMRoUIBQJ5OIMgcy5BvLYUM/5nML7XYvGL1i/gkPVJ+xbtGOIK8acw6DBVQB3WYmqCCEJJo/NbqhBDHFFc+F5cJEtTyqkboArJb1XQXhXXWrsuDOVuiKYdqra0GvKpngAVofXeFIbkFjCur9+qRzrQUrg+ox5Rqxo3NxeBY7/+IHfRmo5D4pnH3mPjhLwGXrnX9mLougA/xZPkuEj505TFU9MJ/K/XmRQkKFu0w3aqNhxiSmW9RpRdpCwv1qBBGG3I+TAH48irFgaN+eGNsLXkkktf/SNwLOeIivoXWoYJE6OuzfMJKlKNn+0uGNBTllTt8EBVMjcIDCmp89o1XoLO3uB+Pqd/43+JWfjVNP1NGaFmV8OIT848wBkxyd15D2QHtPHyGgRTfnuyFXieUZ94WoxlGLKn8zr/eIEPjqu70NSqTkOVjT6EqPEbdqHSboMP5Hb2PFYVv/pISrhOPbNptetMFmahnZ2s10jcZdJX0O4bd0biQ3A1gNPaOB+MSttUP7FKdVUsjwl4j5jdAr1NltF+IUj2vTx0Qz7MRO876TllJhw3MY57mQm3H+mXdzp/n29WrhTx+7Qf+J53j5+gYS5aZD22u5e8B7trZxQavvTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(426003)(336012)(16526019)(186003)(2616005)(47076005)(83380400001)(40460700003)(2906002)(1076003)(6916009)(36756003)(36860700001)(30864003)(356005)(8936002)(81166007)(7696005)(26005)(5660300002)(6666004)(508600001)(4326008)(8676002)(86362001)(70586007)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 22:12:44.2075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d1b641-17c0-4bdc-0fb3-08da29643838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just call the load/unload/init_shared_buf functions
directly.  Makes the code easier to follow.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 143 ++++--------------------
 1 file changed, 21 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0787f2e36f2a..e9dc83641c71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -866,11 +866,6 @@ static int psp_rl_load(struct amdgpu_device *adev)
 	return ret;
 }
 
-static int psp_asd_load(struct psp_context *psp)
-{
-	return psp_ta_load(psp, &psp->asd_context);
-}
-
 static int psp_asd_initialize(struct psp_context *psp)
 {
 	int ret;
@@ -886,7 +881,7 @@ static int psp_asd_initialize(struct psp_context *psp)
 	psp->asd_context.mem_context.shared_mem_size = PSP_ASD_SHARED_MEM_SIZE;
 	psp->asd_context.ta_load_type                = GFX_CMD_ID_LOAD_ASD;
 
-	ret = psp_asd_load(psp);
+	ret = psp_ta_load(psp, &psp->asd_context);
 	if (!ret)
 		psp->asd_context.initialized = true;
 
@@ -914,11 +909,6 @@ int psp_ta_unload(struct psp_context *psp, struct ta_context *context)
 	return ret;
 }
 
-static int psp_asd_unload(struct psp_context *psp)
-{
-	return psp_ta_unload(psp, &psp->asd_context);
-}
-
 static int psp_asd_terminate(struct psp_context *psp)
 {
 	int ret;
@@ -929,8 +919,7 @@ static int psp_asd_terminate(struct psp_context *psp)
 	if (!psp->asd_context.initialized)
 		return 0;
 
-	ret = psp_asd_unload(psp);
-
+	ret = psp_ta_unload(psp, &psp->asd_context);
 	if (!ret)
 		psp->asd_context.initialized = false;
 
@@ -1002,11 +991,6 @@ void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
 			      &mem_ctx->shared_buf);
 }
 
-static int psp_xgmi_init_shared_buf(struct psp_context *psp)
-{
-	return psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context);
-}
-
 static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				       uint32_t ta_cmd_id,
 				       struct ta_context *context)
@@ -1097,16 +1081,6 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
 	return ret;
 }
 
-static int psp_xgmi_load(struct psp_context *psp)
-{
-	return psp_ta_load(psp, &psp->xgmi_context.context);
-}
-
-static int psp_xgmi_unload(struct psp_context *psp)
-{
-	return psp_ta_unload(psp, &psp->xgmi_context.context);
-}
-
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
 	return psp_ta_invoke(psp, ta_cmd_id, &psp->xgmi_context.context);
@@ -1126,7 +1100,7 @@ int psp_xgmi_terminate(struct psp_context *psp)
 	if (!psp->xgmi_context.context.initialized)
 		return 0;
 
-	ret = psp_xgmi_unload(psp);
+	ret = psp_ta_unload(psp, &psp->xgmi_context.context);
 	if (ret)
 		return ret;
 
@@ -1155,13 +1129,13 @@ int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool lo
 	psp->xgmi_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->xgmi_context.context.initialized) {
-		ret = psp_xgmi_init_shared_buf(psp);
+		ret = psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context);
 		if (ret)
 			return ret;
 	}
 
 	/* Load XGMI TA */
-	ret = psp_xgmi_load(psp);
+	ret = psp_ta_load(psp, &psp->xgmi_context.context);
 	if (!ret)
 		psp->xgmi_context.context.initialized = true;
 	else
@@ -1384,21 +1358,6 @@ int psp_xgmi_set_topology_info(struct psp_context *psp,
 }
 
 // ras begin
-static int psp_ras_init_shared_buf(struct psp_context *psp)
-{
-	return psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context);
-}
-
-static int psp_ras_load(struct psp_context *psp)
-{
-	return psp_ta_load(psp, &psp->ras_context.context);
-}
-
-static int psp_ras_unload(struct psp_context *psp)
-{
-	return psp_ta_unload(psp, &psp->ras_context.context);
-}
-
 static void psp_ras_ta_check_status(struct psp_context *psp)
 {
 	struct ta_ras_shared_memory *ras_cmd =
@@ -1506,7 +1465,7 @@ int psp_ras_terminate(struct psp_context *psp)
 	if (!psp->ras_context.context.initialized)
 		return 0;
 
-	ret = psp_ras_unload(psp);
+	ret = psp_ta_unload(psp, &psp->ras_context.context);
 	if (ret)
 		return ret;
 
@@ -1582,7 +1541,7 @@ static int psp_ras_initialize(struct psp_context *psp)
 	psp->ras_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->ras_context.context.initialized) {
-		ret = psp_ras_init_shared_buf(psp);
+		ret = psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context);
 		if (ret)
 			return ret;
 	}
@@ -1595,7 +1554,7 @@ static int psp_ras_initialize(struct psp_context *psp)
 	if (!adev->gmc.xgmi.connected_to_cpu)
 		ras_cmd->ras_in_message.init_flags.dgpu_mode = 1;
 
-	ret = psp_ras_load(psp);
+	ret = psp_ta_load(psp, &psp->ras_context.context);
 
 	if (!ret && !ras_cmd->ras_status)
 		psp->ras_context.context.initialized = true;
@@ -1642,16 +1601,6 @@ int psp_ras_trigger_error(struct psp_context *psp,
 // ras end
 
 // HDCP start
-static int psp_hdcp_init_shared_buf(struct psp_context *psp)
-{
-	return psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_context);
-}
-
-static int psp_hdcp_load(struct psp_context *psp)
-{
-	return psp_ta_load(psp, &psp->hdcp_context.context);
-}
-
 static int psp_hdcp_initialize(struct psp_context *psp)
 {
 	int ret;
@@ -1672,12 +1621,12 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 	psp->hdcp_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->hdcp_context.context.initialized) {
-		ret = psp_hdcp_init_shared_buf(psp);
+		ret = psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_context);
 		if (ret)
 			return ret;
 	}
 
-	ret = psp_hdcp_load(psp);
+	ret = psp_ta_load(psp, &psp->hdcp_context.context);
 	if (!ret) {
 		psp->hdcp_context.context.initialized = true;
 		mutex_init(&psp->hdcp_context.mutex);
@@ -1686,11 +1635,6 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_hdcp_unload(struct psp_context *psp)
-{
-	return psp_ta_unload(psp, &psp->hdcp_context.context);
-}
-
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
 	/*
@@ -1719,7 +1663,7 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 			return 0;
 	}
 
-	ret = psp_hdcp_unload(psp);
+	ret = psp_ta_unload(psp, &psp->hdcp_context.context);
 	if (ret)
 		return ret;
 
@@ -1734,16 +1678,6 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 // HDCP end
 
 // DTM start
-static int psp_dtm_init_shared_buf(struct psp_context *psp)
-{
-	return psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_context);
-}
-
-static int psp_dtm_load(struct psp_context *psp)
-{
-	return psp_ta_load(psp, &psp->dtm_context.context);
-}
-
 static int psp_dtm_initialize(struct psp_context *psp)
 {
 	int ret;
@@ -1764,12 +1698,12 @@ static int psp_dtm_initialize(struct psp_context *psp)
 	psp->dtm_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->dtm_context.context.initialized) {
-		ret = psp_dtm_init_shared_buf(psp);
+		ret = psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_context);
 		if (ret)
 			return ret;
 	}
 
-	ret = psp_dtm_load(psp);
+	ret = psp_ta_load(psp, &psp->dtm_context.context);
 	if (!ret) {
 		psp->dtm_context.context.initialized = true;
 		mutex_init(&psp->dtm_context.mutex);
@@ -1778,11 +1712,6 @@ static int psp_dtm_initialize(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_dtm_unload(struct psp_context *psp)
-{
-	return psp_ta_unload(psp, &psp->dtm_context.context);
-}
-
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
 	/*
@@ -1811,7 +1740,7 @@ static int psp_dtm_terminate(struct psp_context *psp)
 			return 0;
 	}
 
-	ret = psp_dtm_unload(psp);
+	ret = psp_ta_unload(psp, &psp->dtm_context.context);
 	if (ret)
 		return ret;
 
@@ -1826,21 +1755,6 @@ static int psp_dtm_terminate(struct psp_context *psp)
 // DTM end
 
 // RAP start
-static int psp_rap_init_shared_buf(struct psp_context *psp)
-{
-	return psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_context);
-}
-
-static int psp_rap_load(struct psp_context *psp)
-{
-	return psp_ta_load(psp, &psp->rap_context.context);
-}
-
-static int psp_rap_unload(struct psp_context *psp)
-{
-	return psp_ta_unload(psp, &psp->rap_context.context);
-}
-
 static int psp_rap_initialize(struct psp_context *psp)
 {
 	int ret;
@@ -1862,12 +1776,12 @@ static int psp_rap_initialize(struct psp_context *psp)
 	psp->rap_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->rap_context.context.initialized) {
-		ret = psp_rap_init_shared_buf(psp);
+		ret = psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_context);
 		if (ret)
 			return ret;
 	}
 
-	ret = psp_rap_load(psp);
+	ret = psp_ta_load(psp, &psp->rap_context.context);
 	if (!ret) {
 		psp->rap_context.context.initialized = true;
 		mutex_init(&psp->rap_context.mutex);
@@ -1894,7 +1808,7 @@ static int psp_rap_terminate(struct psp_context *psp)
 	if (!psp->rap_context.context.initialized)
 		return 0;
 
-	ret = psp_rap_unload(psp);
+	ret = psp_ta_unload(psp, &psp->rap_context.context);
 
 	psp->rap_context.context.initialized = false;
 
@@ -1940,22 +1854,6 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id, enum ta_rap_stat
 // RAP end
 
 /* securedisplay start */
-static int psp_securedisplay_init_shared_buf(struct psp_context *psp)
-{
-	return psp_ta_init_shared_buf(
-		psp, &psp->securedisplay_context.context.mem_context);
-}
-
-static int psp_securedisplay_load(struct psp_context *psp)
-{
-	return psp_ta_load(psp, &psp->securedisplay_context.context);
-}
-
-static int psp_securedisplay_unload(struct psp_context *psp)
-{
-	return psp_ta_unload(psp, &psp->securedisplay_context.context);
-}
-
 static int psp_securedisplay_initialize(struct psp_context *psp)
 {
 	int ret;
@@ -1978,12 +1876,13 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	psp->securedisplay_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
 	if (!psp->securedisplay_context.context.initialized) {
-		ret = psp_securedisplay_init_shared_buf(psp);
+		ret = psp_ta_init_shared_buf(psp,
+					     &psp->securedisplay_context.context.mem_context);
 		if (ret)
 			return ret;
 	}
 
-	ret = psp_securedisplay_load(psp);
+	ret = psp_ta_load(psp, &psp->securedisplay_context.context);
 	if (!ret) {
 		psp->securedisplay_context.context.initialized = true;
 		mutex_init(&psp->securedisplay_context.mutex);
@@ -2022,7 +1921,7 @@ static int psp_securedisplay_terminate(struct psp_context *psp)
 	if (!psp->securedisplay_context.context.initialized)
 		return 0;
 
-	ret = psp_securedisplay_unload(psp);
+	ret = psp_ta_unload(psp, &psp->securedisplay_context.context);
 	if (ret)
 		return ret;
 
-- 
2.35.1

