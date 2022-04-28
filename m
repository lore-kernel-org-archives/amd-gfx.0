Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6D6C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 22:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0512710E718;
	Thu, 28 Apr 2022 22:12:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6917510E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 22:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm76kGa/Jvq8elpQoxS9r4SOrPBDlh7A3U/85Vz0UeL1wzWIOBWKosMQqY/IjvAnsNqpkELvpRB7l3UvZMlSCfsvjuCojv7OMT/1+ooemuJ4nSwGbX1G5eGQMC72e5oANYirEWhFXt8CcqmKtuQrtmhJV4dXE9rj4dDlqvchEySyhRfPCJiRCFqnNealbrq1dkh1b5PWCF/P+t8yIi/AhV8R9gFFzy34RhdXiODfa7dWB1H54goPK20YOTijPU5B1cyPxdjWPKyP3v2WO6jbGCpUjZGeutN77t95oYLwG0KexKS6pcl7VulIyU6FxmLxmhVK6zkd3x7saBsaFK4WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEyICsmCi5RD+ShpaWR3rs8SYq6DYV3IQSOSno3j4O0=;
 b=d+eOWysq8tpu+OO/8vPXSOzRPSQbNVEwOv/hUF0nu2F2Pbdmux5fqCJGSdT5OFJq71kn6m9BLxmLNioV5qfc/NUpCbCiTZxL6x+XsAmDD1BjBEnhqKdMYZ6JMI7g2rQNn8HJJI+jY/o+p201au2IXLkxMv4YRkaLoyjI3NpGqCNSCocR/qJaxR5ehfSoV/F9jJ+0lFxtvRAuVk7X0ky6b1hJPtbiPUN0O/oTsTBP53+PJTzUKopvWXs//5IhuWwncLAURgpO1CEFlSeGA9DVY5Epp+4AN8Zt8nr1FtIKovU3oIXZyWO5OjMkQrycPefnEy6CQTthLhO045Mg7B29Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEyICsmCi5RD+ShpaWR3rs8SYq6DYV3IQSOSno3j4O0=;
 b=EmBlPWe8v9HfvuLPLVgGR3e/cn4GBcra2hFAz+rWKZCv6AZQGhpE+JeOAzb03s/w0D+D9RHLngNPE5afRIPn6dCGGnIXFDaCWnFwbif4bxjNFZ5jPTUOLW/8Ogksdrlx+19L4H2MCLvTlUk4bC1AahCmS4ltQfsxgmL/uP0KhqQ=
Received: from DS7PR03CA0250.namprd03.prod.outlook.com (2603:10b6:5:3b3::15)
 by MWHPR12MB1869.namprd12.prod.outlook.com (2603:10b6:300:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 28 Apr
 2022 22:12:43 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::22) by DS7PR03CA0250.outlook.office365.com
 (2603:10b6:5:3b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 28 Apr 2022 22:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 22:12:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 17:12:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu/psp: move PSP memory alloc from hw_init to
 sw_init
Date: Thu, 28 Apr 2022 18:12:27 -0400
Message-ID: <20220428221231.1030104-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64314afd-4ab7-476f-8ca5-08da296437d1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1869:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB18695166D195AAA3C1E1ADB0F7FD9@MWHPR12MB1869.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZlmpQEKJYB5VnWDrTyMtVKH9GiLZclucy9gZN0e+xyADehVo1C5j7hMw9bI4Cqj051k64Wul6btSmS+NGYImTxC3ykJK5N8ZJIZwg+2XyxGZm3kL64e3SA4pnq+a8Y7ZS8MTVy8DOwUwgMyXhMEMSw5yIu9gTwjERfVFNU79x3Eqo+ZMSUlqb+fwm5SZ5wq5Ryo3FzrNDh8iXm1BQG5tKSAVsk2xFnr70DkZHfevQE+cCgUvc/JFm7SLlJRsDcxrZ9ilS5P1ZHfobvHhcqbX4sFIeoIeiSnWQVWnNeKj40Vo52Vu8Dls9eSE9xyfn8QN7XNl4zyV3LNL7Gu4eDhNgiedfs872TVLRcjOA8OgOQSQiuy1ialpB0FNh5fwux4HrjCaU8jR64ELvXjJIWmJ7MM/2UdwgbCyvrTZS1zA8PdCCpbeZX7g5ZGN58DuPZCRGEyRh9iqJ8tn1RNL1VUZWFRVVEhQO20So4m8bFXaWJ06KZ2Z7uTyF8acEP6laft07kfaFeOzX8N+ZoVX2SwUIxfUe5uU5v0mof7KfH33zMA1ZbxSJlKzgKoleJ795lnEP6VZGiPhLyPUWrMZ5EfIQ/C76LRP42MgMcMfr/TEC9hOGwJsGU1YodKvFbZ6RUF33vOfCf+aLyG0sB7XBTXJo5HsDJ0GMXNoK8WSkVzHvPvLtW26hrj9LFhgchtx/wlVwaY9Kfq80FDBLzEPB8JNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(6666004)(26005)(7696005)(5660300002)(186003)(316002)(6916009)(40460700003)(16526019)(8936002)(508600001)(86362001)(8676002)(2616005)(1076003)(81166007)(336012)(426003)(47076005)(356005)(36756003)(82310400005)(4326008)(36860700001)(83380400001)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 22:12:43.5201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64314afd-4ab7-476f-8ca5-08da296437d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1869
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

Memory allocations should be done in sw_init.  hw_init should
just be hardware programming needed to initialize the IP block.
This is how most other IP blocks work.  Move the GPU memory
allocations from psp hw_init to psp sw_init and move the memory
free to sw_fini.  This also fixes a potential GPU memory leak
if psp hw_init fails.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 95 ++++++++++++-------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0bd22ebcc3d1..0787f2e36f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -356,7 +356,39 @@ static int psp_sw_init(void *handle)
 		}
 	}
 
+	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+				      amdgpu_sriov_vf(adev) ?
+				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
+				      &psp->fw_pri_bo,
+				      &psp->fw_pri_mc_addr,
+				      &psp->fw_pri_buf);
+	if (ret)
+		return ret;
+
+	ret = amdgpu_bo_create_kernel(adev, PSP_FENCE_BUFFER_SIZE, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &psp->fence_buf_bo,
+				      &psp->fence_buf_mc_addr,
+				      &psp->fence_buf);
+	if (ret)
+		goto failed1;
+
+	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
+				      (void **)&psp->cmd_buf_mem);
+	if (ret)
+		goto failed2;
+
 	return 0;
+
+failed2:
+	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
+			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
+failed1:
+	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
+			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+	return ret;
 }
 
 static int psp_sw_fini(void *handle)
@@ -390,6 +422,13 @@ static int psp_sw_fini(void *handle)
 	kfree(cmd);
 	cmd = NULL;
 
+	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
+			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
+	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
+			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
+			      (void **)&psp->cmd_buf_mem);
+
 	return 0;
 }
 
@@ -2469,51 +2508,18 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	struct psp_context *psp = &adev->psp;
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev)) {
-		psp_ring_stop(psp, PSP_RING_TYPE__KM); /* should not destroy ring, only stop */
-		goto skip_memalloc;
-	}
-
-	if (amdgpu_sriov_vf(adev)) {
-		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-						AMDGPU_GEM_DOMAIN_VRAM,
-						&psp->fw_pri_bo,
-						&psp->fw_pri_mc_addr,
-						&psp->fw_pri_buf);
+		/* should not destroy ring, only stop */
+		psp_ring_stop(psp, PSP_RING_TYPE__KM);
 	} else {
-		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-						AMDGPU_GEM_DOMAIN_GTT,
-						&psp->fw_pri_bo,
-						&psp->fw_pri_mc_addr,
-						&psp->fw_pri_buf);
-	}
-
-	if (ret)
-		goto failed;
-
-	ret = amdgpu_bo_create_kernel(adev, PSP_FENCE_BUFFER_SIZE, PAGE_SIZE,
-					AMDGPU_GEM_DOMAIN_VRAM,
-					&psp->fence_buf_bo,
-					&psp->fence_buf_mc_addr,
-					&psp->fence_buf);
-	if (ret)
-		goto failed;
-
-	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
-				      (void **)&psp->cmd_buf_mem);
-	if (ret)
-		goto failed;
+		memset(psp->fence_buf, 0, PSP_FENCE_BUFFER_SIZE);
 
-	memset(psp->fence_buf, 0, PSP_FENCE_BUFFER_SIZE);
-
-	ret = psp_ring_init(psp, PSP_RING_TYPE__KM);
-	if (ret) {
-		DRM_ERROR("PSP ring init failed!\n");
-		goto failed;
+		ret = psp_ring_init(psp, PSP_RING_TYPE__KM);
+		if (ret) {
+			DRM_ERROR("PSP ring init failed!\n");
+			goto failed;
+		}
 	}
 
-skip_memalloc:
 	ret = psp_hw_start(psp);
 	if (ret)
 		goto failed;
@@ -2631,13 +2637,6 @@ static int psp_hw_fini(void *handle)
 	psp_tmr_terminate(psp);
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
 
-	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
-			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
-	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
-			      &psp->fence_buf_mc_addr, &psp->fence_buf);
-	amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
-			      (void **)&psp->cmd_buf_mem);
-
 	return 0;
 }
 
-- 
2.35.1

