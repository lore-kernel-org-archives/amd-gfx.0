Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A563FC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Apr 2022 02:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3610A10E82B;
	Sat, 23 Apr 2022 02:25:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8045F10E82B
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Apr 2022 02:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExcnCAOCOc2GlmlgbxIJ2pb1Tv5gELS6JzrCMp8uMqgVzdyPeMITZyzZhyUG7ZzRVQ54SJVlVlO6m0uboemwH/4LfWzPxnBQ+OVCOVrBfK0NwDEkE5TrBBrC8Q5uVeexvfpeHhnojAxbbPFyzoxERsGgNNO4SgG8n8ZEcsowaQSRPLFxcO52JAnUJcnwi9KiUCLxiMEqhus6G4y5yWpbb4KkAK1Tz2iRolccQhJeCfA4vCmYmqOIoaRcg2185AiLMaO3u+Gt/iS2FjsupARzYDaWhejHFaJewnFn3SfHEnmyjX7PuK1PGqVtPYBTHMR9iS4YfomvRjMfiSNVEA1/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy4azLE5Jz7ouO2qzV9MAR3v/dTYO9V8eGWnFQyRU6k=;
 b=fQuabbvBvYn9F/yCH0afB6/tjOVM6vp2wt9ESOQWROCJgUKexfBdqLgM5LWNyOi1P8GI4zGxspcSLih2H0K74Zx7NZ3vBFJncvq05qgIka/LM74ozETarmt8ogUoOk8nsTv4IsaKjbAF6lHMH5Jo4NS8ANC00OMZPVVrsJGusmkUSJUGv+icbTQA4Bt+ocxkLNSu8RHlOZQNT8QcdDqd1MEerRKgCYUOwDMyWoMrMsWa/xv42/ZFRfSRxkxWBVI38O1dk3+sXhXgep5gdSDM7hcJCO82xMVfMc74UDoo/i5Ct0GeXINhqRf1cihNR2x/ujTSMlUYEw/n70hNKIMmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy4azLE5Jz7ouO2qzV9MAR3v/dTYO9V8eGWnFQyRU6k=;
 b=tfcQlrXUxdYeSJcgfoKwMMBhcpHNE3hTU7v8g/zUGlekOAyeKpfbbGx3IZaFMW7OeH1sckGkS/gQGdKcke+6NiumQTrLphJAKNtNMgWp8TjV3aCYZ3I52DAhe2ajbYxaUT95a5zAtbwskRlCy56ihrUWhBGfu8N1XvfdeshnQAw=
Received: from DM6PR13CA0070.namprd13.prod.outlook.com (2603:10b6:5:134::47)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sat, 23 Apr
 2022 02:24:58 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::36) by DM6PR13CA0070.outlook.office365.com
 (2603:10b6:5:134::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Sat, 23 Apr 2022 02:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 02:24:58 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 21:24:57 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: replace VM fault error by info logs
Date: Fri, 22 Apr 2022 21:24:45 -0500
Message-ID: <20220423022445.7238-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 023960af-d183-43e3-c15e-08da24d076a0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4433:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4433579DF9796B549504C108FDF69@DM6PR12MB4433.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkczhK03HvS+YVAAh2UUJJH68ZlfKwh3Yf0G0B+9RJepBOnO6/IAvYReJgorrxWCEIJY77RkJFMDBiZMtFrYrgObD8qSCGwqiAlNocjWUxKgvx5/E7fWcns0aL4WnOndob9POSTDc1Oc2E5a8bUvaOeOli1WhzDN6tXt7ATzjY3IpT91iiUNSElor4+sOI9y8OqmpFLyqNeA5G0MmNz8r20l+rriPqUarpZNUH1dBPQ4Wqu1QZiqYDkXH3c3Z39B0yhYckDXUiKDxFjOp9GRM76ra8Gdb/kskCfzscumOxpM7GnYP+vi85D432U9sfrNzDlQMN7GUjCmYhRyV61bVncBYnGJTBfsJH21ab0hhQw/xyRyNKSR8Pm6PCQFS/BR/7NjughzW6khCmIXPjQK++ZH0gD5VPhQA49suTneKHdlZdaklbHpFDcAHQPWTC0IyTnP4RyecyTqlCY0VkNMcaF2p/zByFu/W+ve1DUKzNG8UqG1zvFhqxwcvzG52IbVPEiVaKZbuqFo5D/3zdc+bPKABf74Rp52nBA1NPESaXVcs1GCRaqO7qA7kvzLVNwoX45svBnfLmgNWhjkNeLWguh6KUtsYOaFhAok7hjRHvBQO5x+P+i2k7w8/PM1dXreQIj4KmVUyTvXysTjLxPP17lSL56u9P805ZTUnUncpz7mNiG1Wpt47TIGPVxkbxasJJqpG+WQ0TpweBCM8qwLBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(81166007)(2906002)(508600001)(16526019)(8676002)(30864003)(316002)(4326008)(356005)(6666004)(83380400001)(86362001)(1076003)(70586007)(5660300002)(186003)(47076005)(2616005)(70206006)(44832011)(336012)(426003)(26005)(82310400005)(8936002)(40460700003)(36860700001)(6916009)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 02:24:58.7297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023960af-d183-43e3-c15e-08da24d076a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is not a kernel error. These logs are caused by VM faults that
could not be handled. Typically, generated by user mode applications.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c    |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c    |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c    |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 20 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 14 +++++++-------
 9 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 6e0ace2fbfab..c226a4803086 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -79,25 +79,25 @@ gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	u32 cid = REG_GET_FIELD(status,
 				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
 
-	dev_err(adev->dev,
+	dev_info(adev->dev,
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
 		cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
+	dev_info(adev->dev, "\t RW: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index ff738e9725ee..fdcca1477592 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -82,25 +82,25 @@ gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	u32 cid = REG_GET_FIELD(status,
 				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
 
-	dev_err(adev->dev,
+	dev_info(adev->dev,
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
 		cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
+	dev_info(adev->dev, "\t RW: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a455e59f41f4..864fcc0edb90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -148,14 +148,14 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-	dev_err(adev->dev,
+	dev_info(adev->dev,
 		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, "
 		"for process %s pid %d thread %s pid %d)\n",
 		entry->vmid_src ? "mmhub" : "gfxhub",
 		entry->src_id, entry->ring_id, entry->vmid,
 		entry->pasid, task_info.process_name, task_info.tgid,
 		task_info.task_name, task_info.pid);
-	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
+	dev_info(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ec291d28edff..3d830fd7706b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -620,7 +620,7 @@ static void gmc_v6_0_vm_decode_fault(struct amdgpu_device *adev,
 	mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			      MEMORY_CLIENT_ID);
 
-	dev_err(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
+	dev_info(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
 	       protections, vmid, addr,
 	       REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     MEMORY_CLIENT_RW) ?
@@ -1083,11 +1083,11 @@ static int gmc_v6_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v6_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
+		dev_info(adev->dev, "GPU fault detected: %d 0x%08x\n",
 			entry->src_id, entry->src_data[0]);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
+		dev_info(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
 			addr);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
+		dev_info(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
 			status);
 		gmc_v6_0_vm_decode_fault(adev, status, addr, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 979da6f510e8..1f3ceb03b47b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -781,7 +781,7 @@ static void gmc_v7_0_vm_decode_fault(struct amdgpu_device *adev, u32 status,
 	mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			      MEMORY_CLIENT_ID);
 
-	dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
+	dev_info(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
 	       protections, vmid, pasid, addr,
 	       REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     MEMORY_CLIENT_RW) ?
@@ -1286,11 +1286,11 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v7_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
+		dev_info(adev->dev, "GPU fault detected: %d 0x%08x\n",
 			entry->src_id, entry->src_data[0]);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
+		dev_info(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
 			addr);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
+		dev_info(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
 			status);
 		gmc_v7_0_vm_decode_fault(adev, status, addr, mc_client,
 					 entry->pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 382dde1ce74c..5be3f4f77c49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1021,7 +1021,7 @@ static void gmc_v8_0_vm_decode_fault(struct amdgpu_device *adev, u32 status,
 	mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			      MEMORY_CLIENT_ID);
 
-	dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
+	dev_info(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
 	       protections, vmid, pasid, addr,
 	       REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     MEMORY_CLIENT_RW) ?
@@ -1466,12 +1466,12 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
+		dev_info(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
 			entry->src_id, entry->src_data[0], task_info.process_name,
 			task_info.tgid, task_info.task_name, task_info.pid);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
+		dev_info(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
 			addr);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
+		dev_info(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
 			status);
 		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
 					 entry->pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 22761a3bb818..98c8de7307be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -582,14 +582,14 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-	dev_err(adev->dev,
+	dev_info(adev->dev,
 		"[%s] %s page fault (src_id:%u ring:%u vmid:%u "
 		"pasid:%u, for process %s pid %d thread %s pid %d)\n",
 		hub_name, retry_fault ? "retry" : "no-retry",
 		entry->src_id, entry->ring_id, entry->vmid,
 		entry->pasid, task_info.process_name, task_info.tgid,
 		task_info.task_name, task_info.pid);
-	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
+	dev_info(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
 
@@ -611,11 +611,11 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
 
-	dev_err(adev->dev,
+	dev_info(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 	if (hub == &adev->vmhub[AMDGPU_GFXHUB_0]) {
-		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 			cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
 			gfxhub_client_ids[cid],
 			cid);
@@ -648,22 +648,22 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			mmhub_cid = NULL;
 			break;
 		}
-		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 			mmhub_cid ? mmhub_cid : "unknown", cid);
 	}
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	dev_info(adev->dev, "\t RW: 0x%x\n", rw);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 636abd855686..ec8c8b2cab36 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -150,7 +150,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status,
 			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
 
-	dev_err(adev->dev,
+	dev_info(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 	switch (adev->ip_versions[MMHUB_HWIP][0]) {
@@ -169,21 +169,21 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		mmhub_cid = NULL;
 		break;
 	}
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	dev_info(adev->dev, "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index ff44c5364a8c..72dda850e7d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -87,7 +87,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status,
 			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
 
-	dev_err(adev->dev,
+	dev_info(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 	switch (adev->ip_versions[MMHUB_HWIP][0]) {
@@ -100,21 +100,21 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		mmhub_cid = NULL;
 		break;
 	}
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	dev_info(adev->dev, "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v2_3_setup_vm_pt_regs(struct amdgpu_device *adev,
-- 
2.32.0

