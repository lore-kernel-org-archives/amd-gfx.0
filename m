Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E356CC4707B
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jan 2024 06:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F243D10E071;
	Sat, 13 Jan 2024 06:58:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547FB10E071
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jan 2024 06:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHT+k5duauUI4LUhotztYSKlCV6/WgF++ExMThl//iIA43fdxd7f0Ly29+O+ltei/IL2Y3fxF7V2IWbs8iIJjrJRi4LsJokWFB8CsxzASVtTpfOO1XVEisVV/pcEOSfa2Ucf2N10Aqe9iQlSJrBwZ1WTn9FVQ3LSLENtgIxvz7m1pa3T8kH1GW/V3g/XQY7KZKQYHJJkUSAIiYABEEr5cI4m9JFAZCNCbTyOyDLsFleUhMXWP65dJNW+Njz6qytWx/hyX9wLCfiPbEbzSi12Y3yEyzDM80/Ftn7vetpNXuLXwmfouu5+WpIbaJd6Iel/+h9HI3N+w6MMYW9y5AYP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TK9IHVXNrOeR+DENp5DmU78rBsaZ7cqWZDtB2BzAZg=;
 b=LsUFIkrqB1HKcfiLEfkVbtWqSNblJusMEBQQyFhefnaEYZ28wq6T1zd5YRPDtaXOD7fvS3sqbN6bOR9xxz1h2pk35uaRy58PKxluO8yGt7DNv1iOAP42NFi4fsJdWHLoRqcTMCnJym7gLsWQpuI4iswX8tMa17XPz/BVnYXf9T5ekfuOj68mq5dCKOq7rIMkPloGevto7IhZAp2cuiI4UfwX0r8sjrNDsGmegErVmkY60ts05pnapjBUx3kL7wlh1h6xFW5kNVNxiqSgVCamZdcc000169I//VpnpN4DYS56ZYincuMfPsl6UjgsHqiuKMV8soGeao26d38uZdrkCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TK9IHVXNrOeR+DENp5DmU78rBsaZ7cqWZDtB2BzAZg=;
 b=PJ3Y0BC4MffC6SFEDmrdTeQIW/JLVwaTf7XxaPvkvcgzG0CTzU+WKtmVaPySMlj7KRMX5dZsbu7iRaQqLtuJc8ATIBuyOTN3Z3Z5MFOEd2CHzOFWNo2FzyFjHKnO5iJI6qNvxttRsqBY8RT8O3Hy0qSCLJ6HNbqc4eQlDa2uyX0=
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Sat, 13 Jan
 2024 06:58:32 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::ae) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Sat, 13 Jan 2024 06:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Sat, 13 Jan 2024 06:58:31 +0000
Received: from river-G482-Z51-00.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 13 Jan 2024 00:58:29 -0600
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/amdgpu: Update RLC_SPM_MC_CNT by ring wreg
Date: Sat, 13 Jan 2024 14:58:20 +0800
Message-ID: <20240113065820.60040-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: ec28acba-6ab7-44f8-ebf0-08dc14050db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqk6NOUW6xn2GGB7STzv/nHESRTjCGRot8gupsVCL/XszDfQbsB1cOkaLQ0dZNC195A71Q2p3xiCwmIprczldbwlQIE08i6v2esnqi6kjG/OmqWThZ3HLdkZeEfW8g0tIvieGnz8+jOpeluqtWTDdbv3stz0QiKiGbzfrfOdl7WYdPDHzvH0HqZVclURulGkrg2XpC9BtFVj1qhU+gaDTmM35Y2g7lCbNfgQcGnBlNy2BzihNmoe6p/1NCg6q7SM8PW+CYl3/hDaoJBaDz6MkRFfAjytTxSa57efKX/wyK43p1f6LH9ceQRuA5VhyWBYZikJjghkZ6S15L4XgF2PJAD8N1TipeR/q8GBp3LryUAmrblltomzYOlnRo8xPkZFK1Mtz9Wdq7YdIPNL6rYF0aUv8bbYRx43kEGWM+qfdFZSqqcx9ORuTFuNdfL0iF3InjnrD459Jd9vyswK5QOgmcZ5x4m1Pa6Q2mf3Si4VFbDVkOfe4uNWbMuUynMLC3xFlM/SDsRz4vfwlRp3DNLvJqWTEjP1KLsNsCbnZHMal/+f3kouxCJ0KuUNTaA64N6GYdEo4lxb+XVPC2o+GGgpb/7bmsfqSiDxck0/TQUUb8zLMKraZt68Vs196o22DK60rGKzUVkZADsA67rVIq43cY0El6co115QDVVBy5VBlOhQ18TdwoIQBEFy5IIy8v/SXi3e2VWZOmKU4zVcNBr3H4DvzDnlorRUUbbm2nuYbbdAWO+lG8FVGRVfgOq7b+SsyRx7VtfIqgMi7Fg9cCsznw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(15650500001)(4326008)(5660300002)(70586007)(478600001)(336012)(16526019)(7696005)(6666004)(70206006)(1076003)(8676002)(26005)(2616005)(6916009)(83380400001)(426003)(8936002)(82740400003)(36860700001)(316002)(81166007)(54906003)(356005)(36756003)(86362001)(2906002)(41300700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 06:58:31.5517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec28acba-6ab7-44f8-ebf0-08dc14050db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388
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
index c659ef0f47ce..42e9976c053e 100644
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
+		uint32_t reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
+		amdgpu_ring_emit_wreg(ring, reg, data);
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

