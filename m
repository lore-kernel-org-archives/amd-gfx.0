Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ED3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 19:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6A710E315;
	Wed, 20 Apr 2022 19:37:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723DE10E315
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 19:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6m2Zs1SqIebhrI+OOEnbQTLYsQjoYLZ/GOV3tPmX3Io73wWCAewaIn+7w+TZX39e1anxkXmKAM3dV1dg4DdgVfsdGL6jpECu0+GogZdJ6ilRtkaPFt5U2ROkADYxTErUwjXd0Az6dki/PlYrsXSBm2HiUTc+PK0+S9PGtO9+aKwZoCs/pos5Vx/gq9cHlucX66xa3AwUlrLV6PqMfkERPyI2nDDin68bSad14XX/tHqH8N/18dF1sBQ6hfGwQ3XouldPccfdjWsk+JI4+Tj8L0c8pFqJtYfN9Xy0x4HUBPrtIgv/zpkXQGWHqicUGZvs/58+JJkMBJPjgHijr95kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUjx30RPeaPs9PZrj+W+18+pCBnaJXM3vjcRB54pNro=;
 b=gbBWqmsLeGxmGbnVvO84ZrsyQBSaG2pWI3sdpSw8AA3zFIUHFHrX8vn4CAqWcRt0XLn+Ezcn0p5U6aUyI8seKmZCce2hVj+4iXm9plr0Og6OkpQQyqL8GsUs+NNCeuvNn5QukQpYrwCNl1mcfPnVQuXAiVMsP0a9VIe4BtrcFh1Tkiz6qcTu66vzoIDL85AXt0iscb1ugZ3BhISW2j/zsVsgepMYEA8NT3dHJLifUKFH8rUrEsZKD91Z6cWIsUGDDcZ5IRxskvThwCT2J8i5Q/qK4dG5yfacq8ALTTknl4ObKwB5SkgBS3IqNj39g8RWJJCRXN2H8UsrdjRzjJ6tAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUjx30RPeaPs9PZrj+W+18+pCBnaJXM3vjcRB54pNro=;
 b=0/6BWFvYcYoMXmv1SYEPQw4FtTsaOSPg563VFb1KZf25FEqQwWicz3vF58WZf4fn35VdFiuQ7XQxCOzauN1HOHbv94KzXDnPtp+7Ob6tbMYMG3AzqErhanrZVck9xju0qACcRUkc0XSzMzdjTkfiUDqx4aD795eodhJuce1N25g=
Received: from MW4PR03CA0053.namprd03.prod.outlook.com (2603:10b6:303:8e::28)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 19:37:20 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::9) by MW4PR03CA0053.outlook.office365.com
 (2603:10b6:303:8e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 19:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 19:37:20 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 14:37:15 -0500
From: Alice Wong <shiwei.wong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed v2
Date: Wed, 20 Apr 2022 15:37:00 -0400
Message-ID: <20220420193700.1878150-1-shiwei.wong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52957158-4ef3-4ee5-44bd-08da23052f79
X-MS-TrafficTypeDiagnostic: MW3PR12MB4521:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB452197A1A2DBA0DEA01497D1EBF59@MW3PR12MB4521.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3RkF6eOHYX57MdkQzEFxince8igmpOvy665T7O4CPTkWH1ZCxAh6q4CEPrx2Icpg+AEVCAzv0Qyi5+o9gMhLzxL5j5OOYUdTMMhOlDfflL4yj+5TdBOO9PZ1vOL2jhYtxFoEnR2R0Xv/U9LgLe9AjHhUxgWeHXjc6vYER0Bh+Y0hZUeIlZD0/DQ+eomSz353QuIKMYSspkgABGPdcUu03rmaVEur+pEvyBeTP2jvFEwPTUQg3XAJaXF3rO9UMJUpDvafylx9k193wPbpW3lYRYgOMxmBBtQHaqOqS+wANARfzCc24U7Q8MiqtV1UB3c0/82ppZhLALmpomkEV5+4De6gmJj+5LejzHepzD7NX8EeefYTm6leJk75D638h3oM0j/KI76P2vl0bnZ7FHlVaegw906kuwuKSkMbaiAPuh+1cO3qoB3b3FXt+Gqhdh4gliMMbW/LUeoT18iZHb65W/sxU0KRLKSP2XNCuTq8nQZFSCo8ZPNTLB6X2RXNP/DLoPrjxtgGJBVWwFaEPNgLqEUi6QQtWaRnQWGlm9CisdqaXZ1yTxn1FST3zXeJhrPT0wHGqrPt2nQ6K1cIsHYwNcOzbhZTb5d2sJihHT4/GUvRjfITVY+NkQ+pJyDBEWOM4huYnHYlG1DKcWxTS44CXC2da1G+rCTW6eyi/qVT7vr9kIKmyDwPfbKUFKx63yZpRMM6yK1TAWR85N3LS0ctg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(36860700001)(8676002)(6666004)(7696005)(508600001)(70586007)(36756003)(40460700003)(82310400005)(6916009)(86362001)(70206006)(336012)(4326008)(356005)(426003)(2616005)(5660300002)(316002)(186003)(8936002)(2906002)(83380400001)(16526019)(81166007)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 19:37:20.2913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52957158-4ef3-4ee5-44bd-08da23052f79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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
Cc: Alice Wong <shiwei.wong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Call psp_hw_fini when psp_hw_init failed.

Signed-off-by: Alice Wong <shiwei.wong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 57 +++++++++++++------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 5b9e48d44f5b..52b14efa848a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2537,6 +2537,34 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	return ret;
 }
 
+static int psp_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct psp_context *psp = &adev->psp;
+
+	if (psp->ta_fw) {
+		psp_ras_terminate(psp);
+		psp_securedisplay_terminate(psp);
+		psp_rap_terminate(psp);
+		psp_dtm_terminate(psp);
+		psp_hdcp_terminate(psp);
+	}
+
+	psp_asd_terminate(psp);
+
+	psp_tmr_terminate(psp);
+	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
+
+	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
+			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
+	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
+			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
+			      (void **)&psp->cmd_buf_mem);
+
+	return 0;
+}
+
 static int psp_hw_init(void *handle)
 {
 	int ret;
@@ -2563,37 +2591,10 @@ static int psp_hw_init(void *handle)
 failed:
 	adev->firmware.load_type = AMDGPU_FW_LOAD_DIRECT;
 	mutex_unlock(&adev->firmware.mutex);
+	psp_hw_fini(handle);
 	return -EINVAL;
 }
 
-static int psp_hw_fini(void *handle)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct psp_context *psp = &adev->psp;
-
-	if (psp->ta_fw) {
-		psp_ras_terminate(psp);
-		psp_securedisplay_terminate(psp);
-		psp_rap_terminate(psp);
-		psp_dtm_terminate(psp);
-		psp_hdcp_terminate(psp);
-	}
-
-	psp_asd_terminate(psp);
-
-	psp_tmr_terminate(psp);
-	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
-
-	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
-			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
-	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
-			      &psp->fence_buf_mc_addr, &psp->fence_buf);
-	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
-			      (void **)&psp->cmd_buf_mem);
-
-	return 0;
-}
-
 static int psp_suspend(void *handle)
 {
 	int ret;
-- 
2.25.1

