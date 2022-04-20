Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E292DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 19:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845CC10F1C0;
	Wed, 20 Apr 2022 19:27:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892C210F1BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 19:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwRldbNCWR1MRuBIZr6Qv9v58HKjIYdhmcnHq3OWigyjDnSLNdPoz89LG6gLPl17lts+GzSQAL8FhIMwEQxkaJ4DyFKhfQAs9ZFaS5yhyVhb0SPrTInlg6KiTXxxjzXcnIMYD11VzkIWY52h2wt8gYLWaqW/YEmpi2c+obG5qjyVQfLE0LKaWsnkTS/Urdo6rlyWVV8WHveRoDgAeUfg/rQO7TK6ypR0tPgs4YvPMkiiJ5DWK28rH/EnYSka8pRxKex0uuo9y376sHCq1sRLB0n1J1d3KrR65uH9Fdfu/Q5iMI7+G9LKEj+OUN62i278Y4RpKevU3YXC4Zz28SkPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GCNdOBQXByCoBUQf8O0n98m0yj2s2ocqGY0Xz0HykI=;
 b=hQ7U3XzT88tLsVtSlVBizeH9qxccFzhY1NPpkj8BChPDnDjmY/3Gelu7lGkXHjj2qf5MYIU2FPQLemqjRvCgdalrluzo6SMf43rqCr+UMb034CBf6QkWMRl6zfmPwr5OFtJg1YB6aIdccCRaP9SO+ce7NcQAGhcr421btB+GNNZEHLDrlY6dLlsrgGKtjB5dZGniFk3LZgO+ntBLkZvIhcPBJTlYNinKowfcM62wqWF3OlAmUig8GXc25IH9LGYXdjy5ZMAfCsuDVAxZ0s2n/Td3STf8eblIh8myHln3/v5W+8RuN+sIRcwrjBLoo9vfqG1hY09yAZJ8tjSoeB9aqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GCNdOBQXByCoBUQf8O0n98m0yj2s2ocqGY0Xz0HykI=;
 b=1yukK8xVVE5Sy6xN2g8FGypGRMjY32VcOQNtBiX3LVWjUwsxABOzowchp7I9Lxd9d7Hq5xmcaNbwm3T/L9yiyubSLT+hLru4pRx/JflwXpx80H1ucRa8EZOedKCXfuvIZWV2LQZuz3XXHVQXYjl4ZYbfofdaMYTjN/zC7BQpsM4=
Received: from BN0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:408:e6::26)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 19:27:20 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::fb) by BN0PR03CA0021.outlook.office365.com
 (2603:10b6:408:e6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 19:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 19:27:20 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 14:27:19 -0500
From: Alice Wong <shiwei.wong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed
Date: Wed, 20 Apr 2022 15:25:19 -0400
Message-ID: <20220420192519.1422203-1-shiwei.wong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89ba2b18-751e-4ab8-3f5a-08da2303c9db
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12410E8744FF638A1B9B2B43EBF59@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D38eDDUlpLARFyf0OejaLdIbofrmL9FwY9piZsTaVum0uMqnYv3/+c8TaULiTO70J2sOsNhOp0H2ozlrXp3+u2ASxe1ozzU73OOzkkIZeE4k0Ewm6O5ObCBdy5v4AvGzi1OdRbzHpd7fHtn8NKgXDEgwY7vnIADN75MNwz2uiSdsr17Amvh06wMWhBINF9BITQTjIZDQFQ0QujvRtzHoMxoEoS1gE6CC9KmfgtS062rG5ZYB83mOiHJgh69K4KsaC1LyNaIRF0aWsfd2gxTy6PMuIiEZMqPB7Tg4ST/bN5q1AcyEEgFA5iidfSiOjRc8krg7jFj56uR44fXYHVmTNyBRGo7YYPmrNQ1zAk4DZeg9UuL5GTzWxf9bz2VrAFF7pqgWpL7yIjWkrPz9NA0trFgZ1sT0g29R/in1C/RmN18t8fN9H1Xo7VEORhcPjARTvRyHMYqdPFXnaUSBB0WukmO7w3bWtHLUDUF7O1+GnpwaZ256NaNL9SxS7gc7nQxFQev+MM9i8Z+0ll+ASYJsGiK4wjQsnea4RRb8ondT6kdV46wTsH/luUd0sqN9xW0KkSx1ZMLQfyPSxVVhPY3Ua077570qaHPm7Q8/A4NgQ3bwgd+8YIi+M6yTZDg7oK2Mn9Yfe2IK5WhrBN/qLHlhGtksnSEso8ff7Fp9Pfz3k4bPBpSXGk/PP22fum0aHL+Hp0gfeJQLZs22uSIjB4d9Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(36860700001)(83380400001)(6916009)(2906002)(86362001)(508600001)(40460700003)(356005)(336012)(186003)(70206006)(81166007)(82310400005)(1076003)(26005)(16526019)(426003)(4326008)(8676002)(70586007)(2616005)(316002)(47076005)(36756003)(7696005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 19:27:20.4028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ba2b18-751e-4ab8-3f5a-08da2303c9db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
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

BUG:SWDEV-332449
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

