Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02835EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 15:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287F110E26F;
	Tue, 13 Jun 2023 15:07:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BEA210E3AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 15:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqPYsJL2WfnhjV+7p3djmf5u4dUOqGPbvoAwGJXXEBQgA/vS7HSFPhlnATqIkLGjT85YQ9tqtEJjPP0OHesZYcrOaJgQoexi3NlE7GlBWQu9qXzxMFwC+as6ylxWgNkz6MBO/5G50yJcb+iXPiD1SdsAqClQNjGqVxAdMCciMao6o5udRornoGCx9qLWekwfWz54AA/Gfcj467dXnXxqeTvqUp92wrcLVFhX7L0lyKF/mO/X69aO1W1lsgw5sB4gssaOctt1ijV4MGVLQYExpcmPuEdd3AiZ/59WI0vPaSkfBFzOPtZkKi1VUoElbnecLkldziNz0TBVdOL31Claug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yotUwdR63UZ829T6OTjqW4lJlT2RLNfibbiAEvjX1s=;
 b=IgvZruFsVmNZ1vl1EMW9aue7HoTxu7TwZ1rNmRxkY7FTAOzpENGEqAd0qmNjfrh0CHYLLr8IeW5EK0zo2k0el+i8WHnvcX7JLBSPzAGUGkR4lhsIsC4CdU3co5sykUzHWhUJx4LjUekSZZk/hCwcq9I4+JcUqQiI3V73wb1EB/WSebTI95ibvzLxg0C7kUvvJ6m3Evr7xluudwHWMNRK21LKP0gvK5xctAX7+yU0JGHC12IgQmmNPHGeGwh8wIPsd0UK6unz7hQUdBhBH5q2qAWgsHWxGAhmAA3kR7Ev4574FgaY/vI9o2rdrwUmAw+9FSJDXhSqc+rcmRfdqOHMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yotUwdR63UZ829T6OTjqW4lJlT2RLNfibbiAEvjX1s=;
 b=ak3eX3fMpQ8gwx4MlsE/eh3zpMVJF31gnILLJBdwH4I4iVnX0nMO6B7SF+vSXXINpHaz0PW4zCwxCH406z5OVSLV9SCVEW1NqWqwqnKXUnB2ejOxyh74kLk7Aqr/vgfI04pdu/SPzrfPwzTXd6ZGoMONs8LY+0Cd+wkBuvLvUqU=
Received: from BN9PR03CA0120.namprd03.prod.outlook.com (2603:10b6:408:fd::35)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 13 Jun
 2023 15:07:47 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::f6) by BN9PR03CA0120.outlook.office365.com
 (2603:10b6:408:fd::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:07:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:07:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: cache gpuvm fault information for gmc7+
Date: Tue, 13 Jun 2023 11:07:11 -0400
Message-ID: <20230613150712.1703987-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613150712.1703987-1-alexander.deucher@amd.com>
References: <20230613150712.1703987-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 4acb588d-f5a8-4e87-aa72-08db6c1ff28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CF8jOb/UctxpfU1kXWMVRrCzhAAnISmtdXjhc3vgv9FU8waJCYLFmLEPF/VAayKTl3/Q9vfuKBjP00vIQA9hwmf5ipddOwz8xuGTcH776Qw2wPHeX7RrJzjZRJg0zlxZOn80nYGDXP++0RNy1EVzLgpTch62dwAyIHUcQ/trxDhXVnITYy76psM3Qj9Yilw9KiEpt0iD35oF9OolBs17m2VAqifaA+qFxMYTeNnpP2v7eO4LWI+hwQaBj1hvryAqa9WGU4tojd5r+vfg0ZO9CapLjColjRyNbIwEgNLBPqJywCYriE4cy+5KfEkjOBie/PB6u6OyEveIzGizUaV6+Nyuxyfz2nVYBF03/S+uz/LmtqCAYtzWcFnMFZIv4RexIgmT7ZJblI6F4ICEleL5k+m5F56qBjt2oGJxvSjSLbfypLsL50QU7y/Y4/rl1zmn68sOvOivxTWVRqPFeYZdmy04GQ4qWcywRoEHg5t3Hp1WPZ/StzgUnD6sAbpC+vC+ggw81biptzru2HNxfc3S1s8z73eK/Zrpw+HlNiiPrN5PKftlLjEfLcCRUwNrmECLA14zkfGykcbye/QZaswXdXwa7ae3Qb0ZJ2j8O6hEPE6cdtWhfuALHiSOaa7lYgiYyQzNDLic6y8kDwMtxZ440zD84ezkNUmBkBCgQ8ZxzDSNCSMI5T9aHBABDQmDLmJix5oEB915uu/OnNP00v6U0XFZfn+dVKay+ejRp6zd+ocjgSs5YgYbK2pMxkqarURdxGlJyKWITxZsMlcYIkzz7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(40460700003)(6666004)(7696005)(478600001)(36860700001)(47076005)(1076003)(186003)(83380400001)(426003)(36756003)(16526019)(86362001)(82310400005)(2616005)(26005)(336012)(81166007)(356005)(40480700001)(70586007)(70206006)(6916009)(4326008)(316002)(8936002)(8676002)(5660300002)(41300700001)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:07:47.1875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acb588d-f5a8-4e87-aa72-08db6c1ff28f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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
index b2e42f1b0f12..ccb69f5b06fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -155,6 +155,9 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
+					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
 
 	if (!printk_ratelimit())
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c571f0d95994..ae35dc6ba502 100644
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
index acd2b407860f..d51cad788769 100644
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
index 85dead2a5702..8ce7455ff3f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1448,6 +1448,9 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
+
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3ed286b72cae..fbd65872050a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -555,6 +555,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
 	const char *hub_name;
+	unsigned int vmhub;
 	u64 addr;
 	uint32_t cam_index = 0;
 	int ret, xcc_id = 0;
@@ -567,10 +568,10 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
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
@@ -579,8 +580,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			if (xcc_id < 0)
 				xcc_id = 0;
 		}
-		hub = &adev->vmhub[xcc_id];
+		vmhub = xcc_id;
 	}
+	hub = &adev->vmhub[vmhub];
 
 	if (retry_fault) {
 		if (adev->irq.retry_cam_enabled) {
@@ -626,7 +628,6 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
@@ -663,6 +664,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
+	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
+
 	dev_err(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-- 
2.40.1

