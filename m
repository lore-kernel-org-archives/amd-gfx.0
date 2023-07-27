Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA737C00528
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2581910E5E2;
	Thu, 27 Jul 2023 18:11:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A3710E5E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYMJsmwmhG0kJF6AkYmFFNvPHMsXaV9pd3gLJQnhD5WKLs6FOq9OYJA4/QLfDS7jjhJVEEQgz9BrDq7dm3FLeL7D6cha9neBJg9OR6FVTZGcG61knEFmfT0wW4tscOXAFKkbl8QN67ZA8HnBj/chZzNiu3uoM/uhogJTEsS2aQt1vH+ihflwDAcFntaZ06JEOsifQWiisRNcQal5ebDtb5org2ubMHZZtf2YqpBYReMhqH8ABfSXDMcmehsY77t75kVjvFHdddLmXG1zlje5HPCRZCXSyUI5QUfF6Dh0/a7TJzLzCTmG8YrpFXUaHaPCscu+PqjzcoSh5UkHZ96bAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV++7Pvbh7MNwOZjmpLK4KzHVSLcG9u1Mt39LZB1oQA=;
 b=RubfOroigzItnpEDrM5X45eWcuXiCIJlQcukVeOIAaW8nBHmIG0sLZ050ig9xFUeOQftlHAKr7s+odh1CYXqeyQ2Cy65vhlIADb0N0f2cHWSz7TUo1K70J88KK7BUOX21pJwy+T0cCDP4Xef9eSqmGLgGQQhAooiNO6mwyCQ1DKueXraeGSVDwvq+9hVLNgGPH5M+IQX3h8vJrLCkFnu1zYF2x4IKATGRq2b983JCK1+AMK9B+bockThbr0PMUzIV+1h4EsWhpOdGjSRq7sG1s9KP/rxOawrddrXZ5yonLg6/piWSFYXf+xMTVC2moMHJAEZaAqOTpZhU78PX2tOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV++7Pvbh7MNwOZjmpLK4KzHVSLcG9u1Mt39LZB1oQA=;
 b=5NK/qEIvzBm+kNA5QGMKVYCkTkUpOtubFg1DwJRtw7sCnoR+4LGtcrsodxQ9mk0B7kjFfQBUsdwJWMzvO5wmlIWgRd+tokEwldfG8Et9s6zT2Mpt4UOGMO8cQIOjXhvFZdl1T/KyTzgP0vXqie+NxF9fprPuHYBcOZGHcH97Dr0=
Received: from BN9PR03CA0682.namprd03.prod.outlook.com (2603:10b6:408:10e::27)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 18:11:21 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::2c) by BN9PR03CA0682.outlook.office365.com
 (2603:10b6:408:10e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 18:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 18:11:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 13:11:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: cache gpuvm fault information for gmc7+
Date: Thu, 27 Jul 2023 14:10:46 -0400
Message-ID: <20230727181048.1222388-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727181048.1222388-1-alexander.deucher@amd.com>
References: <20230727181048.1222388-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e203d4-54ee-436f-d5f8-08db8ecce16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mh30r48RJme9mtJry5k5yGXt738sGe3MsJQNg6tfDk6JuovcffX064ez49zoXV0VgWlk1BwtKIP5EFurm+GZxYB+qg6FtSqQZE/Ohme5Pho2wiSUO9dXqCxR95RCw0H2CBW1cqV9mWln8TRvQ0GzmXt9/fnL+FMzjR3gvDG1q7CX4/uixSu+rPlGKXHJvyT2Ke61MIiq9Qb7/QIaFRsMIQ7OKssEEuCOMJsqQ5S/rHneMKCcdASnapO9xQbspgDa3cJrG+pSCJY0rsjF9HUXhyRMRr/y9EvqziEk4xicKCKuCekCCpQoi27YfnTo1PAB+O6jQwYXcTQcpTED81lPEO9KhU3YdD2tT6bATHPB7XpAvKygCfUJNa4SF0n2EJFYOcKJa/j3EHVv1PxsGd1RoGhnJtxwTfC6Iu9qtpTz28WSLcGfEDOaUJirDowUyx9U1NnxB+SK8JW1y/WH1JVPAQudVzZ3y9rrW9pOVn4Q3GH1FPl8XAUf+En8whlbW9+iCk8YwoXzu1NSuTjXxVB9m1XeYec8OSzOcWqRYyeuX02p80Gvc3JkleCoH84RxqWJ9jMvfj2yzDBgxVUVVm8DpVbw3BJgBKnOrAG+8tdngGegzoNaynhByLD+e7aHQmtWjFUwDZ8MTichtQVjevMPiTTtrqTOiGwrSK4na4n2ca7SRzuwdyVMmv59zynmAzPUArXDGlpowmlJ9kkwayQj/+ZuxR14mu7/nnfT944erGphuDQBg9rJoVSgCMxUU/4UwXUkLLr+SdXYJbumEmP+ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(70206006)(356005)(81166007)(478600001)(54906003)(7696005)(6666004)(5660300002)(41300700001)(82740400003)(6916009)(70586007)(316002)(4326008)(8936002)(8676002)(16526019)(36860700001)(336012)(83380400001)(47076005)(186003)(426003)(1076003)(26005)(2616005)(86362001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:11:20.9001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e203d4-54ee-436f-d5f8-08db8ecce16b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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
index 6b430e10d38ed..167f4ba3d00f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -148,6 +148,9 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
 
 	if (!printk_ratelimit())
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index a6ee0220db562..8deed09baa434 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -115,6 +115,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
 
 	if (printk_ratelimit()) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 6a6929ac27482..9384a70395459 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1273,6 +1273,9 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
+
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v7_0_set_fault_enable_default(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 5af2352025132..4886701fe3e2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1442,6 +1442,9 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
+
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 880460cd32398..cc91bb9d36be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -554,6 +554,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
 	const char *hub_name;
+	unsigned int vmhub;
 	u64 addr;
 	uint32_t cam_index = 0;
 	int ret, xcc_id = 0;
@@ -566,10 +567,10 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
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
@@ -578,8 +579,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			if (xcc_id < 0)
 				xcc_id = 0;
 		}
-		hub = &adev->vmhub[xcc_id];
+		vmhub = xcc_id;
 	}
+	hub = &adev->vmhub[vmhub];
 
 	if (retry_fault) {
 		if (adev->irq.retry_cam_enabled) {
@@ -625,7 +627,6 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
@@ -661,6 +662,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
+
 	dev_err(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-- 
2.41.0

