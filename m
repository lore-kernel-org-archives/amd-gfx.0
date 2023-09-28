Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD2AE732E9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 20:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336FB10E6A6;
	Thu, 28 Sep 2023 20:06:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9E510E3E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 20:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoOK6sbHSFFvbPdwiQc9TWna/GvCM3JM6wLY9IZuhEiYbBAeN3UNQg5cJBVugyJpgl6GSXNb7ouT0C+biq6+MCPGV8tq0KZ1FEjOtORy7Q1gaO6B+EG5GxY91GfCSrUS6r9NyeuUdjxMmP8q7DV1j6DN0intmD+0svTyWiryCMbpe/oZ2hVNeq+M11in48ykeqejhGAnoxaAiRKv5eMvu8dDvYRW85e7/kBaY94gpOp9ar+XEzz2Rsfh8gBzfbtAUiqVgVmsWAQ9H92eWg/RkJEZSSJEZ7yX/8f+grt95wTRIlKfJRMnLUYy7D1jVjBec4qedSxNOCk4t1znUYc3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb+bYAAODVoWndNfph7m4n9RArQneG3X/04qghCyTLs=;
 b=BrWg/cKZEVleC3M7iOP3WOKM3Qzz3KF3IWL7jrY89sBa0XUc8zgYKeOdKh/FClfwFJ5I/b/0/YMCfWHs6hh7p5F4CCVo3avpJpAM6XpqnKBtnZe5w2mCGTUWDSrFFKQ6iEsexe4scWQ25LZIcegvuiKNbv5iQcfEayrObqS/4sEMczd3m0fbkcPBC9t4x5/3dygGK8HElXaYKAU953F5f07XioLfH2PHp3ELVgGkh8aar5369R0eHV7vokRTAYnAFtQEfblXHCTpwn3Ked6O1L71s9c/NmYML3ZGK2DBh0cKT72v01f/Y81mrn5rfT2mFZgWQUCyuKJcMPHh01+PnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb+bYAAODVoWndNfph7m4n9RArQneG3X/04qghCyTLs=;
 b=viJNMgBPdZ9XPwi81Vtge3vRFHpQ1zit0WAHcIPFk32RGChTFXmjMYFyTCoIPxhsP96f3h5vKwCl6KOlwO9i/dM5nXOBPtPFTQ+ervLHrTNh/gsxUprKdk9U2b6O3DYCaEdgn++w6lYbU3oDE6f320cTp+5x7GYiuygnk7d67Tg=
Received: from MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 28 Sep
 2023 20:06:24 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::33) by MW2PR2101CA0015.outlook.office365.com
 (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.13 via Frontend
 Transport; Thu, 28 Sep 2023 20:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.25 via Frontend Transport; Thu, 28 Sep 2023 20:06:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 15:06:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: cache gpuvm fault information for gmc7+
Date: Thu, 28 Sep 2023 16:06:06 -0400
Message-ID: <20230928200608.2857534-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928200608.2857534-1-alexander.deucher@amd.com>
References: <20230928200608.2857534-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8653a8fc-ae9b-465c-ed64-08dbc05e6380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aELZvZCi7jSd4h49Od3bjqj8ff0k5P0rcNMgXoh7efCx4OPtgCNYqLUkyrTzzrw8bj0+DlRCzswkDpuqjQJjMwKqTjd4nrsxfM/SMHSzb0tMyZfLnMskQXv3xeeSLGUwpOAK8OgAypr4aUpTmZEAkDKbC2MdNHvBg9Lxd2cugekAiGz0xL75fy3q2a+QK8mNrIBswiRlFXT2DnQWBZg8juIInblANHcKf389X2yNLSalkqspUg3Uwdp9Wi+kdPGSNeWmB8jPHzxZAi+y4rntB+T8xcuhDNA8zGG1GR4uzZ7LUpzsdCUVVmpqKxmAOip+O6Ohn6UcE+XfvAoclxxZonp58BmYRVcWYyXgXLIds6AmDJ3RzT0Yw/TRJduy04UpShmUPWUUOdONHQrrsUKWdGwjiAxwp0euwqkyCzGbptl1CCS19ynVVAycNCcaBIEKS5ETPav2XE9gMIFcNLGJaP/Bz9+T7ZUxsQhwaoR1RXaZenT3/3EPXtl7OcoQmDaqE49pZx1WXBzVUGn70qXoRTQJa35a146j3eG7UCo34AWjoVvKL5x5EORbke15eweroMRZeStRMW8MjHEVzPTbgg5PYFn90lcU0SNvS9FZLf+4k7Z9ZIGSr+snNujYe/TcSGTE8LgeOh3SY9G4eSYLKG78ADC7gkfFCAwPMuomRnqAqZLxGeOacsXo9m3f7VqGHMWh7+9j2y6AsTW65kp/uInS7AS4qt8KuJLSfdAvYPEtxz9HtLuQ1hEjOQhsLtCgBlGxcUPRjbuP5Y1qZ045Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(478600001)(8676002)(6916009)(41300700001)(4326008)(8936002)(40480700001)(70586007)(47076005)(70206006)(6666004)(316002)(2906002)(5660300002)(7696005)(1076003)(16526019)(83380400001)(26005)(36860700001)(2616005)(336012)(36756003)(426003)(40460700003)(82740400003)(86362001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 20:06:23.0347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8653a8fc-ae9b-465c-ed64-08dbc05e6380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cache the current fault info in the vm struct.  This can be queried
by userspace later to help debug UMDs.

Cc: samuel.pitoiset@gmail.com
Acked-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 11 +++++++----
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 70370b412d24..79fac90f423d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -149,6 +149,9 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
 
 	if (!printk_ratelimit())
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index d0a9ee2f12d3..a8d513f56148 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -119,6 +119,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
 
 	if (printk_ratelimit()) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index a72dc21cf6fc..516505161f51 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1268,6 +1268,9 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
+
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v7_0_set_fault_enable_default(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 8ce77d074d17..39ad04119f31 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1436,6 +1436,9 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
+
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6b15677c0314..35fef255c1a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -553,6 +553,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
 	const char *hub_name;
+	unsigned int vmhub;
 	u64 addr;
 	uint32_t cam_index = 0;
 	int ret, xcc_id = 0;
@@ -565,10 +566,10 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
 	if (entry->client_id == SOC15_IH_CLIENTID_VMC) {
 		hub_name = "mmhub0";
-		hub = &adev->vmhub[AMDGPU_MMHUB0(node_id / 4)];
+		vmhub = AMDGPU_MMHUB0(node_id / 4);
 	} else if (entry->client_id == SOC15_IH_CLIENTID_VMC1) {
 		hub_name = "mmhub1";
-		hub = &adev->vmhub[AMDGPU_MMHUB1(0)];
+		vmhub = AMDGPU_MMHUB1(0);
 	} else {
 		hub_name = "gfxhub0";
 		if (adev->gfx.funcs->ih_node_to_logical_xcc) {
@@ -577,8 +578,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			if (xcc_id < 0)
 				xcc_id = 0;
 		}
-		hub = &adev->vmhub[xcc_id];
+		vmhub = xcc_id;
 	}
+	hub = &adev->vmhub[vmhub];
 
 	if (retry_fault) {
 		if (adev->irq.retry_cam_enabled) {
@@ -624,7 +626,6 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
@@ -660,6 +661,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
+
 	dev_err(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-- 
2.41.0

