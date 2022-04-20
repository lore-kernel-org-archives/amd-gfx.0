Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1F7C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 21:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDDB10E151;
	Wed, 20 Apr 2022 21:47:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927DB10E151
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 21:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kcq6t8ctBf3qZvmi/xlBptitM9uLGu12d0dbxxICuk9pBU08OyBS/COhDLxBu2r4SpwHHfcJRl6u0lalV9MvPcAIJvIIOdZuR70ww0/GYNxSyAPfJRm6/v/ciRq58Tm6RwOy2KXYvOL6TGkNPsf7eYR1FaQMs1wdSFsa1F1fz5XV3r4QBZLl4CaxgYDgwenObTZge6+4ZIDzlZmSYAGQaeOfeG4nC+95Kga74Ulm9jSanLutHVKo3Fqm+Ih3umULzr9EmpaMr2InUHVHIv8Yq6B6m/FNg2SDvdYKPbxKMvPQA9Iaz573nQdbodd2Oe4p+lhJKTktL1SkzgYSftduYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnyK+XvmSm91bXvv6yIxxhfSw8oLtYowpv2G1w1aoVQ=;
 b=Aro5W4nLvthMwRLE7NArGnGWlxpxxZRtXoQx4IMUjZWxIllXejxuaHbozq95k8wO0TlYfW3RpFVaIignGI81VRkctdbDxYzpjULQIDNxcQQa0RoF5F15QtVuKyZj7DXdO8m2vD/fX76u0QB+OTmiNzgg1ZiQUmgzaqhR2WQAk2O0iPAIGhR8+D7FCb8cztWiMkfnNwaw7Ge5cjdqxv6rdvmte/sMsxBF3IEHUM8fWKnvSS9EChg0p6BVTtgihefmJABj8U9mKWAgrL54MxBuXmDMSuzZf3F/PTVFCboLLzoR56+o4Uc2l/qa/E8zqx0NBWdjQUY5EYnMq7IQgOsCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnyK+XvmSm91bXvv6yIxxhfSw8oLtYowpv2G1w1aoVQ=;
 b=hVe3onFSFwVKj8jrrmZEY3hLMqq9J0cPR6LAkIw74nEhnIfp58XU9KjaGZqEBU13O1rIhF8u/IPGIEFJQr7Cb4pHlrMe4LbHnyglvOk0EgtuH/0D1JJHxrKMnGN2Kw7mAwZm+zlkp4+p6jcS9nqi4rGq73lS0lmOh7qGkKqRruo=
Received: from BN9PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:fb::23)
 by MWHPR12MB1951.namprd12.prod.outlook.com (2603:10b6:300:113::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 21:47:36 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::63) by BN9PR03CA0048.outlook.office365.com
 (2603:10b6:408:fb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 21:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 21:47:35 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 16:47:34 -0500
From: Alice Wong <shiwei.wong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed v2
Date: Wed, 20 Apr 2022 17:47:15 -0400
Message-ID: <20220420214715.2644898-1-shiwei.wong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88e32e96-7e34-4132-f2b1-08da231761b3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1951:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB195136143271DA6F0CD9DB9CEBF59@MWHPR12MB1951.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUvoYdv9bcinsYsYBJxNGq84qaTSYK38egge7JwYlyD2cM5EfwxHKrmp4AL8jEtk+DZtamt5WmYq/zNYIK4UWE/84/6uVAtaL2b/e2emONikNG5BOBg/4hvTPydlq4mQBZCBnTKXTXUUw3zM90cBnPnsx0EJB3kz6yRIiI15Xa31LWOaYCgC01SmojTKkpJzSRpUj7KVWrJ5quQYV/xxkG3vWF7e2NIdXuGbxbsqHf72c3VbVEW+gKvg1Lr5VT57mumkRhfcnsQL5HDCEM9YFZxs7bQwifT/5fbY8kOx+rDX419qREaNr9CLEnkvQjlp6kg7irzXxtObyeCzvOxMlMJAgFMAI6gU4SxSRLYel/B5z6/Ag1rm97sTbOTlsFYu47DrtLEgfWHUa43IYEMMdtdwsXAVb1EJGv9RqyLYRezzMx2axNVb0Rwt6Pm9dipjeM5R9HpNDg4ovSMI5Ci15pQ6BLN4BJsvME86Fx6wKoElvLjYShWMrQv/qMOY/1J4aOmucAtjdNKQ7gt60xgqAG9XQw9PghgKdEyCEawNhKuSKgQqOxJgNMuQd4gUOXW8AXS9fv1qRXqnUWKwQQ+2mpI+kgL4nJxRA80ITtpLHbMZuHqmeEiS3w54Ndr4pWrXtVKytofFCukYkfHQ+fXHUTZRjzv1rD3g/Q7ywbnz3TJxRgQ28s+//YriQSMaQzVP2O9sFaIG2WuPCl6Pyl89YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(81166007)(356005)(2616005)(47076005)(1076003)(16526019)(426003)(6666004)(186003)(4326008)(36756003)(336012)(316002)(26005)(508600001)(7696005)(6916009)(82310400005)(70586007)(8676002)(36860700001)(5660300002)(83380400001)(86362001)(70206006)(40460700003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 21:47:35.5968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e32e96-7e34-4132-f2b1-08da231761b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1951
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

If at any point psp_hw_init failed, psp_hw_fini would not be called
during unload due to ip_blocks[PSP].status.hw not being set to true.
This could cause a memory leak when the driver unloads.
As a rule of thumb, each IP block should cleanup themselves when
their hw_init fails. Only previously intialized blocks should
be cleaned up by the common framework.

v1: Call IP blocks' respective hw_fini when hw_init failed from
    the common framework
v2: Call psp_hw_fini when psp_hw_init failed.

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

