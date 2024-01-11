Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979B0C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 14:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12AC910E900;
	Thu, 11 Jan 2024 14:41:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC8610E900
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 14:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTaXAsDkilVUrB5mckRsO+OogCXYCDg1+V2hpbKMAt+cpaRt+RothN8HBCeiIEaRA9wleReegrTa/w7uGZsPU4mgRaIe5QC296WARzoLORoyOBOYEPRGuP0bRWPDL9otecDT3aLaMgeXZqiFI7rOG/OdDXFUww7yUdfR14QluWxpElQJIeel7elbPGVfNctEo3cnf/qw+iYS+GMVL4eIO27N20J3YR6Z/k9XwfVA/GPF1QUqoY2DEKQ1Xt9rP/MjfPYbYy8hz0fRvapXJlel+dB4M2c4pr8cpXCH67egfoD4P5prkRaFfcYsyxbUEkF0tpQUghF4uQhQGAzCWnF4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWGcdXn+F93I1dTq4zT9TYwf6Xdm4nzzV9hezWQc6KQ=;
 b=gw7XqnnDw4zgFP19CWFW97npB97bog8VKjFy92t5bw7NiPAyf+ZwjH6rlca6xslPS+PDNDA7kffUK6OKY9Sj6W1bJ3Dn/QNOlOowUpTDU4ce7A6JHdiVdQvyB9ECxiix6kuiRwrrQnafwvRkspaFv4AncLH4kphtg7hGme3Scr9rIUg5T+Rtm6iMG1aRBwFMFeh+05ESQNCTWEPzWVhJIvsIXfb2G8BxwxIVT+SPX9VKBwxRC7QaPaTEaoJ1mFXZxBE8O/GihiQdMQsJxY31wVKB3hWorg1M9rWGxQBlRKPKuUVyRmg5AuZD2GX9IwR97rWhE2e6JdS1t5osWPoucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWGcdXn+F93I1dTq4zT9TYwf6Xdm4nzzV9hezWQc6KQ=;
 b=BvjLPMbiKGM9OrWn5+/mhwLtwnqEKVRJQuUxT6mj71a55/vh1O8zk3t2T7jpf6gHhjaYA2Qx3r/BBZNbULqXeR5TVsUpNeqpdxLdpeJ+V4iL8E6gzbY21Tmqy2mJQGXlKejy7u7Q7MVx5dz/MLY8BHZxXzpeYrz8ATEN+L4Aqek=
Received: from CY8PR22CA0017.namprd22.prod.outlook.com (2603:10b6:930:45::20)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 14:41:41 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::8d) by CY8PR22CA0017.outlook.office365.com
 (2603:10b6:930:45::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Thu, 11 Jan 2024 14:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 14:41:40 +0000
Received: from river-G482-Z51-00.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 11 Jan 2024 08:41:39 -0600
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/amdgpu: Update RLC_SPM_MC_CNT by ring wreg
Date: Thu, 11 Jan 2024 22:41:28 +0800
Message-ID: <20240111144128.27726-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: f48f494d-0a7c-41dc-4ad9-08dc12b36c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTJOwBnTUIDZ+yrcr1T8Mu74MRJCYAB9Fm4popGd5E24KyHQ42lWUvZyz3L0W5ztyqzIKrNuOXjq6u56LjpNwywiHFN57UNrls9TvcQtQ/Nx25+2Rt2KyHuWHzEjKvo2D7WZQqV8nTvTajmI2ur9TOlgG+wWyTXEZEtFFyfsfXZKw1RPX/A+8pV57/Om4uQz1WK8K6JJvH7Ox6SMoOYUrSNINJ867uWPTAQjdPTf7JO3dem7kq4Wt4Fmywso7Nz0gm5eClztl4SxfemkkAN/xhqahEobm4NjUgmJKxB8iSOtlQo2/YlLl6vYOboCVFx2Mio+UTNDFdCAnR6qBeizwBM8A/BzUb5G1H+DhDqaqrKMGO8a8YNvqUzpzhPbpbONlt2uNdhJ6B4VsICApTlIoqxQMXa9Tx0xp6dbtdJR/Q70ZBktUjYsqWk61ZxPOcC/bHvd8d29JMj6exe6S6F7gpOO+jKaDFEy7sCZoVxrg0qdXVtbjqYmc1A59Se/FeCMRcvZAEyT2EyLcQyRdcCL690/aBXxSFqSEtfUXB13Jdiu6eCkeRmY5U6Hyf6d//K8+dRnzF48bqEcnzsn7Me2Fwcru/SfJJXJTRqN+mHF+rE4zxl41iAZXmA/1KlguGLLFovL7AzX1MolHm6WY/o9fxBUt/GeIeK/TTuuQLWXk4sWGWigEE0YifJFB0E9yVE/LFoZ8zg8+KtI5ag+B2DY5y1k/zyhK/GgX4WxRgOwsc4szUCimbs7h7mm/s8UzE8MR2409nz5oX6+BXgt8D/Fgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(15650500001)(2906002)(5660300002)(41300700001)(83380400001)(2616005)(40480700001)(26005)(426003)(16526019)(40460700003)(336012)(47076005)(1076003)(478600001)(7696005)(81166007)(6666004)(356005)(86362001)(36860700001)(82740400003)(36756003)(70206006)(8936002)(8676002)(54906003)(316002)(6916009)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 14:41:40.8777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f48f494d-0a7c-41dc-4ad9-08dc12b36c94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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
Cc: yuansmao@amd.com, YuanShang <YuanShang.Mao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
RLC_SPM_MC_CNTL can not updated by MMIO
since MMIO protection is enabled during runtime in
guest machine.

[How]
Submit command of wreg in amdgpu ring to update
RLC_SPM_MC_CNT.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  4 ++--
 8 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index b591d33af264..5a17e0ff2ab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -169,7 +169,7 @@ struct amdgpu_rlc_funcs {
 	void (*stop)(struct amdgpu_device *adev);
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
-	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
+	void (*update_spm_vmid)(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned vmid);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7da71b6a9dc6..13b2c82e5f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -650,7 +650,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
 	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
 
 	if (!ring->is_mes_queue && ring->funcs->emit_gds_switch &&
 	    gds_switch_needed) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c8a3bf01743f..830ed6fe1baf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7951,7 +7951,7 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 	WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
-static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned int vmid)
+static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned int vmid)
 {
 	amdgpu_gfx_off_ctrl(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c659ef0f47ce..a981071e7c93 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -749,7 +749,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);
 
 	return 0;
 }
@@ -5002,7 +5002,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 data;
 
@@ -5013,9 +5013,15 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
-	WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
+	if (ring == NULL)
+		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
 
 	amdgpu_gfx_off_ctrl(adev, true);
+
+	if (ring) {
+			uint32_t reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
+			amdgpu_ring_emit_wreg(ring, reg, data);
+	}
 }
 
 static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index c2faf6b4c2fc..86a4865b1ae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3274,7 +3274,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);
 
 	return 0;
 }
@@ -3500,7 +3500,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 1943beb135c4..ea174b76ee70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1288,7 +1288,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);
 
 	return 0;
 }
@@ -5579,7 +5579,7 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 	}
 }
 
-static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 69c500910746..57808be6e3ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4894,7 +4894,7 @@ static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
-static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned int vmid)
+static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned int vmid)
 {
 	amdgpu_gfx_off_ctrl(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 00b21ece081f..acf7d2898665 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1109,7 +1109,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);
 
 	return 0;
 }
@@ -1320,7 +1320,7 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
+static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 				       unsigned vmid)
 {
 	u32 reg, data;
-- 
2.34.1

