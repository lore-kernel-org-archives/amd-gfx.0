Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FBFCD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 23:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E2010EAB1;
	Wed, 27 May 2026 23:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QSWqYPAj";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160EC10EAB1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 23:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noPHPFiGxWhw+yW7goAJPvvg+RzPV/vJF2SAz214hpMjp3fp5ylg0yqgZCRvdgHVw5Sguj9tnFaWugGldYjAhqAf9uEYmstE96FvFpCp/Ikd2+VVqjEVSU1n/eB3nRsFRwfef06U4s6NnuVA4bTtJi6e1J47OXOUz6iCq6gRqp4xRqm86STHQZDDYMkPWTHfjUrGsd9yAr/nuk7ATq+pUTqFcTKpDRN9dcEMAKjsvtrL2dtOVPL3tr6ggvXt9okJDx4x0biRZSBsfsaXNsaoPpnmwbJnWurx34dfeeEjUdSJOHUIkHGA9C9P7dxZeBPRr4sd3rZ1Q14eItmOfnsJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpcDiNcjpMxK0Kta5KpiSS/MbhLIPIqTIfEBHwFg2Tc=;
 b=eSIQ3fsB4n53Xvm/7sbAiDlXNHXBDEHLyHQ2DCIiggeMBFZDYlPR/smxS3MkmnQXJ6rdliXOzmglt4tFWecNV+nBOjTQP1GVCqQuw3jymob9juSdZXWyWVsW77fyFErvQHEyFRkSQDkN7ARqyVrDSfFdrACTL1S8Omr29Bu33DZS/oYmzoDOXeYLOC+YQS1R3afpuz2JY6kcge+q4QbkZqflbpuH+3LcbubyM6hl/cSaZIYsf4p+CW1BJF/IjsLWqljPRHIRV/Nc57JTOm8/b0/IUB0U6OKysgaQ7YKUfS1rq4Cu+SdPLjJuNccxV4+/g957S3KDDmQBcloyc86s1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpcDiNcjpMxK0Kta5KpiSS/MbhLIPIqTIfEBHwFg2Tc=;
 b=QSWqYPAjiRIY5PpHOWsHs5dYDUQ5jJAG7yvjU7c0K/WjDixr49jen1Dkyvwkvcmc7AznO+jZstJWWydp9QtjajAPnoXU4GLDHyEjLCt3koCq+zkf65lkTu8tVK3PnumCEQFKGFz/IUDFn+AcvUTrnt5fiM1lomjC7ooYSaDlokc=
Received: from BL1PR13CA0339.namprd13.prod.outlook.com (2603:10b6:208:2c6::14)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 23:36:17 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::92) by BL1PR13CA0339.outlook.office365.com
 (2603:10b6:208:2c6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 23:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 23:36:17 +0000
Received: from yunxiali-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 18:36:16 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx: move fault and EOP IRQ get/put to
 hw_init/hw_fini
Date: Wed, 27 May 2026 19:35:04 -0400
Message-ID: <20260527233504.1830940-3-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260527233504.1830940-1-Yunxiang.Li@amd.com>
References: <20260527233504.1830940-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a5d839-ae62-477d-e486-08debc48bfcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: WQcNR1n49XE/46N7tSrJYfIA6KX7tU4kKdaVKE6AjrCx82z2VhIBECNu2P8FEHOqvNXoBNvMDQeE5TyrFIfO9idFaheWmFsDaaJZVSeAXuKT9dCifrENkbs4XjVJytle64vmDzjtneQJPlTfWydNLqCFqjq/imDSzfJb0Wiw2+P3/9QQAI2dLIxYSp2EkDRzSzx1f+9IGBcz+YvgSraHqaY89UQz8KpoEdfAT0YMvaDHaqIylnhOrFBegWPOnIV9/fUXt4vuys5VxOnDVOMSoE7xTuqe8VX0PXtgbmy8DODOLKMWZfjdWQzUaxpZD81pvL92ayysCMAUF2YIRL8monjaq38/dVI34YG2dGnh14unpd4nOQWXBxmNfhmjQphJFtpuW7eC175VUjqM01Ot5QbBGUGEUJRQO2fMR08rZ8Z4plMMRhdsSeSVK4pH9Wpo3YuNqpaOXK8UGoqtZWHo32QSlgWATLbFQesXHa1f0RQJykucqE6afMlr8LMXlB6PNP6VxFNo3RuNwRxeSvjfRAjWLbWGvgEYgTJWLc/8h9uXxEud87F4+vtzSGGKy1AnqiZQfJktML3Y8cqYY+PThvJGDQx5NhowMsKE9+IhcxqDAPHDLFvEf2/Yu7M22kx+2FnUqrf5dtUK/rH160RGs5LKqG2wHnkGfU39qKawEnHV8mOw2P4Kd5IAalBsEpNasphxtqKuHPqpnWNAjOn2gAA+u1R1cpSwwC0p3ObgsGw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dROEqojaiMpBcCiSRqfEWLAFKBZ8KDS1URjdtDyYGpViCYvNtsSm4S+L7Jv0svBdNul9P6sj3yVsb7pqZ6RDXyGmrsdSZxvw6ELkPaH5HPAmcXd1vkfvKBYNH4KD2nlafh1U77lcAHmbsScbY4ebv+1Kt6CM2sHf3EU4gS5k/NDGw6TksOuly0yYzd0SpIh4aHhGhgvi9GEoTSbJj9eDosWYSXqiKjXTjmKzviOLJIv9/gHArXbM0kWH4PWd65KRgI18n6S2omKCOf63FVWwQ5kP9cs4M69Y+4R2Zt3heHoDsv4AzqtXII8u0jbVmJ1L8iZdxPVKS99EfsfYmboJ9q5lc//MLdAZzbRRDFPqFD94l9GGjhU9EYZaEDhn54v4NtaVXzT1pGOyGSwcd2sYPwxjKEzxEDQpbuy7L2RF8KF7rCwC1Zmt4EfV/JHwyPpn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:36:17.4515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a5d839-ae62-477d-e486-08debc48bfcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

priv_reg / priv_inst / bad_op and (on v11+) userq EOP IRQs are
acquired in late_init but released in hw_fini.  This split forced
gfx_v9_0_hw_fini() to defensively guard each put with
amdgpu_irq_enabled() because hw_fini runs on paths that may not
reach late_init.

amdgpu_ip_block_hw_fini() only runs after hw_init returns success,
and suspend / resume cycle the refs through the same path, so
hw_init / hw_fini pair without any extra tracking.  Move the gets
there and drop the guards.

While here, fix the pre-existing partial-failure leak in
set_userq_eop_interrupts() (gfx11 / 12_0 / 12_1).  amdgpu_irq_get()
increments the refcount before calling .set, so a failure partway
through the loop leaves earlier successful gets stranded.  Track
the loop position and roll back on the enable path.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  43 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 162 ++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 162 ++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 114 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  39 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  35 ++---
 6 files changed, 315 insertions(+), 240 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 58c69dcb527f7..0780c5e5de4ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7523,32 +7523,50 @@ static int gfx_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	r = gfx_v10_0_cp_resume(adev);
 	if (r)
 		return r;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 0))
 		gfx_v10_3_program_pbb_mode(adev);
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0) && !amdgpu_sriov_vf(adev))
 		gfx_v10_3_set_power_brake_sequence(adev);
 
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
+	if (r)
+		goto err_priv_inst;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		goto err_bad_op;
+
+	return 0;
+
+err_bad_op:
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+err_priv_inst:
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	return r;
 }
 
 static int gfx_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
 	cancel_delayed_work_sync(&adev->gfx.idle_work);
 
-	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 
 	/* WA added for Vangogh asic fixing the SMU suspend failure
 	 * It needs to set power gating again during gfxoff control
 	 * otherwise the gfxoff disallowing will be failed to set.
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 1))
 		gfx_v10_0_set_powergating_state(ip_block, AMD_PG_STATE_UNGATE);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
@@ -7830,40 +7848,20 @@ static int gfx_v10_0_early_init(struct amdgpu_ip_block *ip_block)
 	gfx_v10_0_set_gds_init(adev);
 	gfx_v10_0_set_rlc_funcs(adev);
 	gfx_v10_0_set_mqd_funcs(adev);
 
 	/* init rlcg reg access ctrl */
 	gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
 
 	return gfx_v10_0_init_microcode(adev);
 }
 
-static int gfx_v10_0_late_init(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
-	if (r)
-		return r;
-
-	return 0;
-}
-
 static bool gfx_v10_0_is_rlc_enabled(struct amdgpu_device *adev)
 {
 	uint32_t rlc_cntl;
 
 	/* if RLC is not enabled, do nothing */
 	rlc_cntl = RREG32_SOC15(GC, 0, mmRLC_CNTL);
 	return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true : false;
 }
 
 static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
@@ -9798,21 +9796,20 @@ static void gfx_v10_0_ring_begin_use(struct amdgpu_ring *ring)
 static void gfx_v10_0_ring_end_use(struct amdgpu_ring *ring)
 {
 	amdgpu_gfx_profile_ring_end_use(ring);
 
 	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
 }
 
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.name = "gfx_v10_0",
 	.early_init = gfx_v10_0_early_init,
-	.late_init = gfx_v10_0_late_init,
 	.sw_init = gfx_v10_0_sw_init,
 	.sw_fini = gfx_v10_0_sw_fini,
 	.hw_init = gfx_v10_0_hw_init,
 	.hw_fini = gfx_v10_0_hw_fini,
 	.suspend = gfx_v10_0_suspend,
 	.resume = gfx_v10_0_resume,
 	.is_idle = gfx_v10_0_is_idle,
 	.wait_for_idle = gfx_v10_0_wait_for_idle,
 	.soft_reset = gfx_v10_0_soft_reset,
 	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fabdbbd0abb7c..de0bf6e1f64d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4800,20 +4800,92 @@ static void gfx_v11_0_disable_gpa_mode(struct amdgpu_device *adev)
 
 	data = RREG32_SOC15(GC, 0, regCPC_PSP_DEBUG);
 	data |= CPC_PSP_DEBUG__GPA_OVERRIDE_MASK;
 	WREG32_SOC15(GC, 0, regCPC_PSP_DEBUG, data);
 
 	data = RREG32_SOC15(GC, 0, regCPG_PSP_DEBUG);
 	data |= CPG_PSP_DEBUG__GPA_OVERRIDE_MASK;
 	WREG32_SOC15(GC, 0, regCPG_PSP_DEBUG, data);
 }
 
+static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	unsigned int irq_type;
+	int m, p, r;
+
+	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
+		for (m = 0; m < adev->gfx.me.num_me; m++) {
+			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
+				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq, irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+				if (r) {
+					if (!enable)
+						return r;
+					goto err_gfx;
+				}
+			}
+		}
+	}
+
+	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
+		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+					+ (m * adev->gfx.mec.num_pipe_per_mec)
+					+ p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq, irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+				if (r) {
+					if (!enable)
+						return r;
+					goto err_compute;
+				}
+			}
+		}
+	}
+
+	return 0;
+
+err_compute:
+	for (p--; p >= 0; p--) {
+		irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+			+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+		amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+	}
+	for (m--; m >= 0; m--) {
+		for (p = adev->gfx.mec.num_pipe_per_mec - 1; p >= 0; p--) {
+			irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+				+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+			amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+		}
+	}
+	m = adev->gfx.me.num_me;
+err_gfx:
+	for (p--; p >= 0; p--) {
+		irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+		amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+	}
+	for (m--; m >= 0; m--) {
+		for (p = adev->gfx.me.num_pipe_per_me - 1; p >= 0; p--) {
+			irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+			amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+		}
+	}
+	return r;
+}
+
 static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
 				       adev->gfx.cleaner_shader_ptr);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
 		if (adev->gfx.imu.funcs) {
@@ -4897,76 +4969,57 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	gfx_v11_0_tcp_harvest(adev);
 
 	r = gfx_v11_0_cp_resume(adev);
 	if (r)
 		return r;
 
 	/* get IMU version from HW if it's not set */
 	if (!adev->gfx.imu_fw_version)
 		adev->gfx.imu_fw_version = RREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_0);
 
-	return r;
-}
-
-static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
-					      bool enable)
-{
-	unsigned int irq_type;
-	int m, p, r;
-
-	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
-		for (m = 0; m < adev->gfx.me.num_me; m++) {
-			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
-				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
-				if (enable)
-					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				else
-					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				if (r)
-					return r;
-			}
-		}
-	}
-
-	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
-		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
-			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
-				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
-					+ (m * adev->gfx.mec.num_pipe_per_mec)
-					+ p;
-				if (enable)
-					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				else
-					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				if (r)
-					return r;
-			}
-		}
-	}
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
+	if (r)
+		goto err_priv_inst;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		goto err_bad_op;
+
+	r = gfx_v11_0_set_userq_eop_interrupts(adev, true);
+	if (r)
+		goto err_userq_eop;
 
 	return 0;
+
+err_userq_eop:
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+err_bad_op:
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+err_priv_inst:
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	return r;
 }
 
 static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
 	cancel_delayed_work_sync(&adev->gfx.idle_work);
 
-	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 	gfx_v11_0_set_userq_eop_interrupts(adev, false);
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring &&
 		    !adev->gfx.disable_kq) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
 
 		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
@@ -5342,44 +5395,20 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	gfx_v11_0_set_gds_init(adev);
 	gfx_v11_0_set_rlc_funcs(adev);
 	gfx_v11_0_set_mqd_funcs(adev);
 	gfx_v11_0_set_imu_funcs(adev);
 
 	gfx_v11_0_init_rlcg_reg_access_ctrl(adev);
 
 	return gfx_v11_0_init_microcode(adev);
 }
 
-static int gfx_v11_0_late_init(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
-	if (r)
-		return r;
-
-	r = gfx_v11_0_set_userq_eop_interrupts(adev, true);
-	if (r)
-		return r;
-
-	return 0;
-}
-
 static bool gfx_v11_0_is_rlc_enabled(struct amdgpu_device *adev)
 {
 	uint32_t rlc_cntl;
 
 	/* if RLC is not enabled, do nothing */
 	rlc_cntl = RREG32_SOC15(GC, 0, regRLC_CNTL);
 	return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true : false;
 }
 
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
@@ -7194,21 +7223,20 @@ static void gfx_v11_0_ring_begin_use(struct amdgpu_ring *ring)
 static void gfx_v11_0_ring_end_use(struct amdgpu_ring *ring)
 {
 	amdgpu_gfx_profile_ring_end_use(ring);
 
 	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
 }
 
 static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.name = "gfx_v11_0",
 	.early_init = gfx_v11_0_early_init,
-	.late_init = gfx_v11_0_late_init,
 	.sw_init = gfx_v11_0_sw_init,
 	.sw_fini = gfx_v11_0_sw_fini,
 	.hw_init = gfx_v11_0_hw_init,
 	.hw_fini = gfx_v11_0_hw_fini,
 	.suspend = gfx_v11_0_suspend,
 	.resume = gfx_v11_0_resume,
 	.is_idle = gfx_v11_0_is_idle,
 	.wait_for_idle = gfx_v11_0_wait_for_idle,
 	.soft_reset = gfx_v11_0_soft_reset,
 	.check_soft_reset = gfx_v11_0_check_soft_reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f47928dcd8480..f66293fc675e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3648,20 +3648,92 @@ static void gfx_v12_0_init_golden_registers(struct amdgpu_device *adev)
 		if (adev->rev_id == 0)
 			soc15_program_register_sequence(adev,
 					golden_settings_gc_12_0_rev0,
 					(const u32)ARRAY_SIZE(golden_settings_gc_12_0_rev0));
 		break;
 	default:
 		break;
 	}
 }
 
+static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	unsigned int irq_type;
+	int m, p, r;
+
+	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
+		for (m = 0; m < adev->gfx.me.num_me; m++) {
+			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
+				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq, irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+				if (r) {
+					if (!enable)
+						return r;
+					goto err_gfx;
+				}
+			}
+		}
+	}
+
+	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
+		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+					+ (m * adev->gfx.mec.num_pipe_per_mec)
+					+ p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq, irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+				if (r) {
+					if (!enable)
+						return r;
+					goto err_compute;
+				}
+			}
+		}
+	}
+
+	return 0;
+
+err_compute:
+	for (p--; p >= 0; p--) {
+		irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+			+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+		amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+	}
+	for (m--; m >= 0; m--) {
+		for (p = adev->gfx.mec.num_pipe_per_mec - 1; p >= 0; p--) {
+			irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+				+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+			amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+		}
+	}
+	m = adev->gfx.me.num_me;
+err_gfx:
+	for (p--; p >= 0; p--) {
+		irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+		amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+	}
+	for (m--; m >= 0; m--) {
+		for (p = adev->gfx.me.num_pipe_per_me - 1; p >= 0; p--) {
+			irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+			amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+		}
+	}
+	return r;
+}
+
 static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
 		if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
 			/* RLC autoload sequence 1: Program rlc ram */
 			if (adev->gfx.imu.funcs->program_rlc_ram)
 				adev->gfx.imu.funcs->program_rlc_ram(adev);
@@ -3735,77 +3807,58 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	/*
 	 * init golden registers and rlc resume may override some registers,
 	 * reconfig them here
 	 */
 	gfx_v12_0_tcp_harvest(adev);
 
 	r = gfx_v12_0_cp_resume(adev);
 	if (r)
 		return r;
 
-	return r;
-}
-
-static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
-					      bool enable)
-{
-	unsigned int irq_type;
-	int m, p, r;
-
-	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
-		for (m = 0; m < adev->gfx.me.num_me; m++) {
-			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
-				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
-				if (enable)
-					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				else
-					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				if (r)
-					return r;
-			}
-		}
-	}
-
-	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
-		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
-			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
-				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
-					+ (m * adev->gfx.mec.num_pipe_per_mec)
-					+ p;
-				if (enable)
-					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				else
-					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				if (r)
-					return r;
-			}
-		}
-	}
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
+	if (r)
+		goto err_priv_inst;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		goto err_bad_op;
+
+	r = gfx_v12_0_set_userq_eop_interrupts(adev, true);
+	if (r)
+		goto err_userq_eop;
 
 	return 0;
+
+err_userq_eop:
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+err_bad_op:
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+err_priv_inst:
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	return r;
 }
 
 static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t tmp;
 
 	cancel_delayed_work_sync(&adev->gfx.idle_work);
 
-	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 	gfx_v12_0_set_userq_eop_interrupts(adev, false);
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
 
 		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
 
@@ -3920,44 +3973,20 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	gfx_v12_0_set_irq_funcs(adev);
 	gfx_v12_0_set_rlc_funcs(adev);
 	gfx_v12_0_set_mqd_funcs(adev);
 	gfx_v12_0_set_imu_funcs(adev);
 
 	gfx_v12_0_init_rlcg_reg_access_ctrl(adev);
 
 	return gfx_v12_0_init_microcode(adev);
 }
 
-static int gfx_v12_0_late_init(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
-	if (r)
-		return r;
-
-	r = gfx_v12_0_set_userq_eop_interrupts(adev, true);
-	if (r)
-		return r;
-
-	return 0;
-}
-
 static bool gfx_v12_0_is_rlc_enabled(struct amdgpu_device *adev)
 {
 	uint32_t rlc_cntl;
 
 	/* if RLC is not enabled, do nothing */
 	rlc_cntl = RREG32_SOC15(GC, 0, regRLC_CNTL);
 	return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true : false;
 }
 
 static void gfx_v12_0_set_safe_mode(struct amdgpu_device *adev,
@@ -5433,21 +5462,20 @@ static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
 static void gfx_v12_0_ring_end_use(struct amdgpu_ring *ring)
 {
 	amdgpu_gfx_profile_ring_end_use(ring);
 
 	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
 }
 
 static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
 	.name = "gfx_v12_0",
 	.early_init = gfx_v12_0_early_init,
-	.late_init = gfx_v12_0_late_init,
 	.sw_init = gfx_v12_0_sw_init,
 	.sw_fini = gfx_v12_0_sw_fini,
 	.hw_init = gfx_v12_0_hw_init,
 	.hw_fini = gfx_v12_0_hw_fini,
 	.suspend = gfx_v12_0_suspend,
 	.resume = gfx_v12_0_resume,
 	.is_idle = gfx_v12_0_is_idle,
 	.wait_for_idle = gfx_v12_0_wait_for_idle,
 	.set_clockgating_state = gfx_v12_0_set_clockgating_state,
 	.set_powergating_state = gfx_v12_0_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 033f15e21ad33..61c3577f829fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2728,20 +2728,64 @@ static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 	int i;
 
 	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); i++) {
 		gfx_v12_1_xcc_disable_burst(adev, i);
 		gfx_v12_1_xcc_enable_atomics(adev, i);
 		gfx_v12_1_xcc_disable_early_write_ack(adev, i);
 		gfx_v12_1_xcc_disable_tcp_spill_cache(adev, i);
 	}
 }
 
+static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	unsigned int irq_type;
+	int m, p, r;
+
+	if (!adev->gfx.disable_kq)
+		return 0;
+
+	for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+		for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+			irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+				+ (m * adev->gfx.mec.num_pipe_per_mec)
+				+ p;
+			if (enable)
+				r = amdgpu_irq_get(adev, &adev->gfx.eop_irq, irq_type);
+			else
+				r = amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+			if (r) {
+				if (!enable)
+					return r;
+				goto err_unwind;
+			}
+		}
+	}
+
+	return 0;
+
+err_unwind:
+	for (p--; p >= 0; p--) {
+		irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+			+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+		amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+	}
+	for (m--; m >= 0; m--) {
+		for (p = adev->gfx.mec.num_pipe_per_mec - 1; p >= 0; p--) {
+			irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+				+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+			amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+		}
+	}
+	return r;
+}
+
 static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, i, num_xcc;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
 		/* rlc autoload firmware */
 		r = gfx_v12_1_rlc_backdoor_autoload_enable(adev);
 		if (r)
 			return r;
@@ -2796,20 +2840,38 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 	/*
 	 * init golden registers and rlc resume may override some registers,
 	 * reconfig them here
 	 */
 	gfx_v12_1_tcp_harvest(adev);
 
 	r = gfx_v12_1_cp_resume(adev);
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
+	if (r)
+		goto err_priv_inst;
+
+	r = gfx_v12_1_set_userq_eop_interrupts(adev, true);
+	if (r)
+		goto err_userq_eop;
+
+	return 0;
+
+err_userq_eop:
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+err_priv_inst:
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	return r;
 }
 
 static void gfx_v12_1_xcc_fini(struct amdgpu_device *adev,
 			      int xcc_id)
 {
 	uint32_t tmp;
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_gfx_disable_kcq(adev, xcc_id))
@@ -2821,55 +2883,28 @@ static void gfx_v12_1_xcc_fini(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev)) {
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
 		tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS);
 		tmp &= 0xffffff00;
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp);
 	}
 	gfx_v12_1_xcc_cp_compute_enable(adev, false, xcc_id);
 	gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
 }
 
-static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *adev,
-					      bool enable)
-{
-	unsigned int irq_type;
-	int m, p, r;
-
-	if (adev->gfx.disable_kq) {
-		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
-			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
-				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
-					+ (m * adev->gfx.mec.num_pipe_per_mec)
-					+ p;
-				if (enable)
-					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				else
-					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
-							   irq_type);
-				if (r)
-					return r;
-			}
-		}
-	}
-
-	return 0;
-}
-
 static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, num_xcc;
 
-	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	gfx_v12_1_set_userq_eop_interrupts(adev, false);
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		gfx_v12_1_xcc_fini(adev, i);
 	}
 
 	adev->gfxhub.funcs->gart_disable(adev);
 
 	adev->gfx.is_poweron = false;
 
@@ -2956,40 +2991,20 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 	gfx_v12_1_set_irq_funcs(adev);
 	gfx_v12_1_set_rlc_funcs(adev);
 	gfx_v12_1_set_mqd_funcs(adev);
 	gfx_v12_1_set_imu_funcs(adev);
 
 	gfx_v12_1_init_rlcg_reg_access_ctrl(adev);
 
 	return gfx_v12_1_init_microcode(adev);
 }
 
-static int gfx_v12_1_late_init(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
-	if (r)
-		return r;
-
-	r = gfx_v12_1_set_userq_eop_interrupts(adev, true);
-	if (r)
-		return r;
-
-	return 0;
-}
-
 static bool gfx_v12_1_is_rlc_enabled(struct amdgpu_device *adev)
 {
 	uint32_t rlc_cntl;
 
 	/* if RLC is not enabled, do nothing */
 	rlc_cntl = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CNTL);
 	return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true : false;
 }
 
 static void gfx_v12_1_xcc_set_safe_mode(struct amdgpu_device *adev,
@@ -3869,21 +3884,20 @@ static void gfx_v12_1_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0xffffff);  /* CP_COHER_SIZE_HI */
 	amdgpu_ring_write(ring, 0); /* CP_COHER_BASE */
 	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE_HI */
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
 static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
 	.name = "gfx_v12_1",
 	.early_init = gfx_v12_1_early_init,
-	.late_init = gfx_v12_1_late_init,
 	.sw_init = gfx_v12_1_sw_init,
 	.sw_fini = gfx_v12_1_sw_fini,
 	.hw_init = gfx_v12_1_hw_init,
 	.hw_fini = gfx_v12_1_hw_fini,
 	.suspend = gfx_v12_1_suspend,
 	.resume = gfx_v12_1_resume,
 	.is_idle = gfx_v12_1_is_idle,
 	.wait_for_idle = gfx_v12_1_wait_for_idle,
 	.set_clockgating_state = gfx_v12_1_set_clockgating_state,
 	.set_powergating_state = gfx_v12_1_set_powergating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index bec0720f70552..47721d0c37812 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4043,33 +4043,48 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	r = gfx_v9_0_cp_resume(adev);
 	if (r)
 		return r;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
 	    !amdgpu_sriov_vf(adev))
 		gfx_v9_4_2_set_power_brake_sequence(adev);
 
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
+	if (r)
+		goto err_priv_inst;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		goto err_bad_op;
+
+	return 0;
+
+err_bad_op:
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+err_priv_inst:
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	return r;
 }
 
 static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
-		amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_inst_irq, 0))
-		amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-	if (amdgpu_irq_enabled(adev, &adev->gfx.bad_op_irq, 0))
-		amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 
 	/* DF freeze and kcq disable will fail */
 	if (!amdgpu_ras_intr_triggered())
 		/* disable KCQ to avoid CPC touch memory not valid anymore */
 		amdgpu_gfx_disable_kcq(adev, 0);
 
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v9_0_cp_gfx_enable(adev, false);
 		/* must disable polling for SRIOV when hw finished, otherwise
 		 * CPC engine may still keep fetching WB address which is already
@@ -4856,32 +4871,20 @@ static int gfx_v9_0_ecc_late_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.ras->enable_watchdog_timer(adev);
 
 	return 0;
 }
 
 static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
-	if (r)
-		return r;
-
 	r = gfx_v9_0_ecc_late_init(ip_block);
 	if (r)
 		return r;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
 		gfx_v9_4_2_debug_trap_config_init(adev,
 			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
 	else
 		gfx_v9_0_debug_trap_config_init(adev,
 			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9f76e1af8a553..510266ba0c388 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2364,20 +2364,38 @@ static int gfx_v9_4_3_hw_init(struct amdgpu_ip_block *ip_block)
 	gfx_v9_4_3_constants_init(adev);
 
 	r = adev->gfx.rlc.funcs->resume(adev);
 	if (r)
 		return r;
 
 	r = gfx_v9_4_3_cp_resume(adev);
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
+	if (r)
+		goto err_priv_inst;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		goto err_bad_op;
+
+	return 0;
+
+err_bad_op:
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+err_priv_inst:
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	return r;
 }
 
 static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	uint32_t ptl_state = enable ? 1 : 0;
 	uint32_t fmt1, fmt2;
 	int r;
 
@@ -2439,23 +2457,23 @@ static int gfx_v9_4_3_ptl_hw_init(struct amdgpu_device *adev)
 }
 
 static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, num_xcc;
 
 	if (adev->psp.ptl.hw_supported && !amdgpu_in_reset(adev))
 		gfx_v9_4_3_perf_monitor_ptl_init(adev, false);
 
-	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		gfx_v9_4_3_xcc_fini(adev, i);
 	}
 
 	return 0;
 }
 
 static int gfx_v9_4_3_suspend(struct amdgpu_ip_block *ip_block)
@@ -2604,33 +2622,20 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
 
 	/* init rlcg reg access ctrl */
 	gfx_v9_4_3_init_rlcg_reg_access_ctrl(adev);
 
 	return gfx_v9_4_3_init_microcode(adev);
 }
 
 static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
-	if (r)
-		return r;
-
-	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
-	if (r)
-		return r;
 
 	if (adev->gfx.ras &&
 	    adev->gfx.ras->enable_watchdog_timer)
 		adev->gfx.ras->enable_watchdog_timer(adev);
 
 	gfx_v9_4_3_ptl_hw_init(adev);
 
 	return 0;
 }
 
-- 
2.51.2

