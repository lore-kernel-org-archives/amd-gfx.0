Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3BBC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 14:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076D610E929;
	Thu, 11 Jan 2024 14:20:21 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A81210E929
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 14:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KACgLmd2bkTmptO7Ti00ywCCvuhrvEo95GGeYJ2nEax9cXqpM6vrigtI1TW7mzPHEFUbwB3oVN3MjLTrdkIiS+yXjaVvILZ8Al4i2inilaZ6YN2o7bVFkIjxBmZEgwwygSH6npPIKt8+f3Rmic9uYcwdXuC6JiSsjnKLasTMSpUd7115N8UyLVyYz5vHbzLV9b6+WyhBnwDOOyF/49GQGLZyktGiGV2UsqU0VTgpHdxAioc055SjUtd/RqFZZk6AisbnZ+Y+UJ528/mp4w7brN1Fl2GGrZ7mRgrPEMjl/E/f+dZD51kQfLs2sNRx6PnoNS2yxQ4wa+UNNpcUYr+5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er5ELrhKmqxPDcB0ZC9s4/Y91GT293dtFz2+KWKtnTM=;
 b=EiDvYhfWvPbRORS2/8mBntzxntDQORilPfFbTEaL2VmUjO7bXcpadRH+bFeOUsP8i4n7v6hgZuYlg/PAsRajFtSKsprdMh/h3ukJNEMYCAl0xHuUZP5HSaNbWZHL9IlROBDPMcliobveX9LJMq7F0PuJax7yfkKrNukZ3FzX25rXNquJdTIMGKNTeFN+9rkKwzpq4c0HObtQaGHdns+2WKe1QuX0V/g64nQbxVEft5YVfRjoj8+GsAIps7QOrjuV2W4ygv+NA2y+8xtYc0cdkrVGH0jb/Dn6NL/zignLxScKxmY3jgxztLNxc8sv1spWtMJvaPpSn4S7F41TAGVFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er5ELrhKmqxPDcB0ZC9s4/Y91GT293dtFz2+KWKtnTM=;
 b=BrP2HI0JDcCsjJ6FPfgf/RT36ELSiQV77ErLNFoSLb6AP9i2JhdwPvxCX7dgwi4VShp5q3JxTVXzHmDVYTJUwRzNSYqjI5vyrCD3abbfWQy5hdj2EIWb2psFTg3kjEOZ39tC7iK+pR6AV5Tdg6ss1Kzlqh40uUiBtSvXqsa9KTA=
Received: from BL1PR13CA0068.namprd13.prod.outlook.com (2603:10b6:208:2b8::13)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 14:20:17 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::78) by BL1PR13CA0068.outlook.office365.com
 (2603:10b6:208:2b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14 via Frontend
 Transport; Thu, 11 Jan 2024 14:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 14:20:17 +0000
Received: from river-G482-Z51-00.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 11 Jan 2024 08:20:16 -0600
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] SWDEV-439292 - Update RLC_SPM_MC_CNT by ring wreg
Date: Thu, 11 Jan 2024 22:19:51 +0800
Message-ID: <20240111141951.27215-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b59d83-b955-459c-3fec-08dc12b06fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxYlJKGrduF8eU/9APlgiw9I/BXn8hDbc0fAcJShFKX7z3U2gJPVm62XcoA9ntIQM/0H0bLWSoUuOOF8n3fnxp4lediannm/Yl4xRVFWRvbD5Ddb6RSfRjv0WRPWlU8NvYP+TG15rC1qF/MDbe7omZlKDLtU9XXCd3snJqqp/Wv2esRWdZECCgE8JMZSU5HC8NrSNUzZfLuNH01v8omiyTqwUK1EDVYz4WwqujIASP9DcBTat6T3IkAzZ6FIh4YjIWlxh7hTiiFMoORNG6lmbcEsl17gSgcuOajbSTPJuG7Qa3jBXpGD9Qj3iU/Pc92wX7U2c+Nv8BgXG0UGJevsfqMqKxSNWtm0H4lwZnZ0pLtOX3H2yn2ghXOjxAZmPD6+O9DwUVKFcWLn8+7mUGACZ4TOnbNmtux42hWgRwBI5lRFc1HVS9dvzrCbOJWpLI8b+6O0o15DsjiZPXH4saWfkt9SbiEu0i6CjJsI9O6IQl7RWYX2ucg5NfVqNnAs22RMnmpW9RTQctklvY7wRmdR/BQSf0l8Rns/V+mymDoht8Wiv73UiUGC3GutX4lmTNaRHRxooeKjSZxRP0nh2h/S72b0djavyMEwSgTNxtuzjS5sNu7bKdt83AnRBXy44OC12DWGLsmaf5LeXQxCi9GexGtoOFWPEQGBfcFd1sBpOwHMHxpsEyyQuGf7oxr3h0Dn5RDPVk4h0aP4lx1z+tjoV47l3Yq8w73pW2bqhihLGBDk7E/MV6PXWuV2hmEmuUeqszTNqRYs5/sHqUj72p/stA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(70206006)(70586007)(40460700003)(2616005)(26005)(40480700001)(316002)(54906003)(8936002)(16526019)(8676002)(1076003)(4326008)(6916009)(15650500001)(83380400001)(336012)(7696005)(426003)(6666004)(47076005)(2906002)(5660300002)(478600001)(36860700001)(82740400003)(41300700001)(86362001)(356005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 14:20:17.7738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b59d83-b955-459c-3fec-08dc12b06fbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
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

Why: RLC_SPM_MC_CNTL can not updated by MMIO
since MMIO protection is enabled during runtime.

How: submit command of wreg in amdgpu ring to update
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

