Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A0BCD4F5E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0C310EE15;
	Tue, 19 May 2026 18:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mXd8JEhE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013031.outbound.protection.outlook.com
 [40.93.196.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E3D10EE2F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xijj20+EGbn4enSZtFbBKOwo5qpme77Ajq0jWPqowyJEs9/aznLUF1mEuWsgoLxO1NQlTVqZ0qH9hnGXjGQh7KV+eaaNgQpGQiPIGAclptToCLAhXC27+XyxYxykzIvHf/d85zDNfwZ537ss6Zezf0Az5I4koE65hpbOC6rNFncYMXeGBPGw5bapONv35X8I2XD30fmRNrpmd4UTiMg284URhajary25l7klZIiwuWdRPSJb7EsOlwMaaEO+U7YlDa/AY2E0gQpKSaT3Jdz1DI9AtoNEJFhQipJD5favkwqP8gM5uBz4A49Ms42VoaTZX4DfO3B+6sMNkPjXTg5mZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8LO2GOaPdsun6IyDB4GozOr3GawCquaN5CQlSBJ9XA=;
 b=B6RUJRodpLgWsTV+wJan/txvXZLMdFDyNZqwIpI5C3WihgTSpb4CF+uKHru9/VVuBFIEpeA412hSWHSy3jsZbD9wdssfBG/j+4/+//qJEG/oQrdFbREcdF7MRBKA73J40SljsTzXbpBCzOwQ64kpw/uaB19LdO6SJh0rAZI0KyWh1IDJsUwrphbKo911XiCPUum2rQtbyJDzC1oU16z6XVYcCXYkiVebq+oUUv5tttTpOvF9YgeHXg7MPw4cIxrw1OmsbN+LINKFaP9O+ZkpO/uOzK1iimTqCSW7hlSiU6qxSz5QBBF/xmj9BnzT4FwPuo5NOlkqtAv+guSjxDf+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8LO2GOaPdsun6IyDB4GozOr3GawCquaN5CQlSBJ9XA=;
 b=mXd8JEhEB3grfUDvH0LJHMGJntZLFThA23CMkXqf1pFNw/zdA3YTYGYeJImt6AFw1IZTVMlV28r00WB8nAzjzm7RMU3OfGU5YgiUrb9oMp5FwCYStSMgJScMlF1efe/6XY4dINVtKTtG2KF0DDDtsGeOGO1CjuTM1QRYdfJIQPo=
Received: from SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::10)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 18:32:11 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::4b) by SA1P222CA0123.outlook.office365.com
 (2603:10b6:806:3c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 19 May 2026 18:32:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 19 May
 2026 13:32:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 May
 2026 13:32:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:32:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu/mes11: move pipe reset to mes use_mmio patch
Date: Tue, 19 May 2026 14:30:54 -0400
Message-ID: <20260519183055.22275-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183055.22275-1-alexander.deucher@amd.com>
References: <20260519183055.22275-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 442195a9-a48f-4bb9-8a79-08deb5d4f0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: HCe8eeqWhGnNdV0msq7TSSQBwj2tjV10KoCim4RHRs9eAFr37OvaBA/T4EYUhlt0i9z/k4GHErOSQaTc6uRq+OVAwlJrzTcUxZi9IjMvYJARshy7vrURBGYonaJdhPxcIb9W6jm/nriUbRuojiKccwuktrCZunAgkBelS1cnrXtgJiSqAfGtw51xgquRryx5BerQz6xjIpgSd6HJ9jwUPnMXjrK5Ij6HbB99qnmG5eY4LSvEMwskImqzlu5kD20ldMUfror8p3WIxv4hcAE3O89/Lhe7aNYvNJ4VnQCgX9I7lpgYIKfCWDyhTZ9luQnPXH9k9OUpKY2rUnUK106WnFACqA+rFyrORll3JUPSsZEzVjrQBNpX30scsclzQ1x3/z1BT+Qej6fZzikg5A02V6TYbMSFzmvihWw4MC0LE0bbJDA39/5xJvxQiPSFb0Pe9NLTevlMXYVvqwXU0cnPvOdjBtIeE0lgQXN7ManNh1jTcTfNrfQkHKLahacQYPpQHGFL86Zdw2PZuntpG+7EXmFoLHztAtZIW6Hol/B/7cnx9dKNEosim1vIExLENWV2CEUZMKc+N8EuQsF0a76A2cSqkIzPm/Vim8hX9SI24RQLUcRQjot2FxjwA9rbxW6F3Jkql9q6J2aSlk6PZgTlfi+e2ZP7FmxPFL0I4Qw6PEoKHCc/y3Lwr8N+VNfuq2L/S6ufs8zutp0R6M48jsUbdHY/67ZDBjZ0kyBXct0lQAg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cK0z3RypXpe8FH0HLSakeRnyVcp5HNuWSXLVWpgDnhSVVFEnNQCQIKd78qOXV2BakYghK071VYQRKPzDSHMHQaXntUFzaEQXOZtjhYhSIxyKtV1XW6S2la0UzWUkyD6IABJtesLQKoDKS5ROP9TlRO1rc6y1HB5UWz60qZ7qwVARDN7JVA9lXiP3NLHyXWt9M8aWHxio1YQCQYFA5GgAkIaWQOBRnZWM7Rf6Gl80MYdfbBLQokmhHlb57jhpdJRT4ArBCoJ9OaA5g0x7WnvAVGFGQPycHzBkJNGKqRP0vFkz23zheCTqRw798JtjRsAgXa4GG3QqSGRVNujMFcI3eVedMGawbkf1qU8wUKBLrRV+ECYP9ZTf9rnS4REDf1In1JFLfL8oHgMNxsGSFRPJO2Xmi3QgGxaPVzN9+pmChlnqoKkbRWhHx5T8/FHUAH0D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:32:11.1965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442195a9-a48f-4bb9-8a79-08deb5d4f0e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

This makes the code flows cleaner and it's only supported on
the use_mmio path.

v2: fix typo
v3: fix typo

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 244 +-----------------------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 253 ++++++++++++++++++++++++-
 2 files changed, 253 insertions(+), 244 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1995de5e69991..f268d46e07598 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6775,69 +6775,6 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
-static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
-
-static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t reset_pipe = 0, clean_pipe = 0;
-	int r;
-
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
-	gfx_v11_0_set_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	switch (ring->pipe) {
-	case 0:
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   PFP_PIPE0_RESET, 1);
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   ME_PIPE0_RESET, 1);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   PFP_PIPE0_RESET, 0);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   ME_PIPE0_RESET, 0);
-		break;
-	case 1:
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   PFP_PIPE1_RESET, 1);
-		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
-					   ME_PIPE1_RESET, 1);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   PFP_PIPE1_RESET, 0);
-		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
-					   ME_PIPE1_RESET, 0);
-		break;
-	default:
-		break;
-	}
-
-	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
-	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
-
-	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
-						RS64_FW_UC_START_ADDR_LO;
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	gfx_v11_0_unset_safe_mode(adev, 0);
-
-	dev_info(adev->dev, "The ring %s pipe reset to the ME firmware start PC: %s\n", ring->name,
-			r == 0 ? "successfully" : "failed");
-	/* FIXME: Sometimes driver can't cache the ME firmware start PC correctly,
-	 * so the pipe reset status relies on the later gfx ring test result.
-	 */
-	return 0;
-}
-
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
@@ -6849,13 +6786,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r) {
-
-		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
-		r = gfx_v11_reset_gfx_pipe(ring);
-		if (r)
-			return r;
-	}
+	if (r)
+		return r;
 
 	if (use_mmio) {
 		r = gfx_v11_0_kgq_init_queue(ring, true);
@@ -6874,170 +6806,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-/*
- * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
- * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
- * asserted; only then clear the pipe reset bit.
- * Caller must hold adev->srbm_mutex.
- */
-static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
-					     u32 pipe)
-{
-	unsigned int q;
-	int j;
-
-	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
-		soc21_grbm_select(adev, me, pipe, q, 0);
-		/* Start from a clean HQD dequeue state before forcing HQD inactive. */
-		WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
-		if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
-			WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
-			for (j = 0; j < adev->usec_timeout; j++) {
-				if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-					break;
-				udelay(1);
-			}
-		}
-
-		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
-	}
-}
-
-static int gfx_v11_0_reset_compute_pipe(struct amdgpu_device *adev,
-					   u32 me, u32 pipe, u32 queue)
-{
-	uint32_t reset_val, clean_val;
-	int r;
-
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
-	gfx_v11_0_set_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	soc21_grbm_select(adev, me, pipe, queue, 0);
-
-	if (adev->gfx.rs64_enable) {
-		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
-		clean_val = reset_val;
-
-		switch (pipe) {
-		case 0:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE0_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE0_RESET, 0);
-			break;
-		case 1:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE1_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE1_RESET, 0);
-			break;
-		case 2:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE2_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE2_RESET, 0);
-			break;
-		case 3:
-			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE3_RESET, 1);
-			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
-						  MEC_PIPE3_RESET, 0);
-			break;
-		default:
-			break;
-		}
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
-		gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
-		soc21_grbm_select(adev, me, pipe, queue, 0);
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
-		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
-					RS64_FW_UC_START_ADDR_LO;
-	} else {
-		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
-		clean_val = reset_val;
-
-		if (me == 1) {
-			switch (pipe) {
-			case 0:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE0_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE0_RESET, 0);
-				break;
-			case 1:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE1_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE1_RESET, 0);
-				break;
-			case 2:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE2_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE2_RESET, 0);
-				break;
-			case 3:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE3_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME1_PIPE3_RESET, 0);
-				break;
-			default:
-				break;
-			}
-			/* mec1 fw pc: CP_MEC1_INSTR_PNTR */
-		} else {
-			switch (pipe) {
-			case 0:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE0_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE0_RESET, 0);
-				break;
-			case 1:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE1_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE1_RESET, 0);
-				break;
-			case 2:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE2_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE2_RESET, 0);
-				break;
-			case 3:
-				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE3_RESET, 1);
-				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
-							  MEC_ME2_PIPE3_RESET, 0);
-				break;
-			default:
-				break;
-			}
-			/* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
-		}
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
-		gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
-		soc21_grbm_select(adev, me, pipe, queue, 0);
-		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
-		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
-	}
-
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	gfx_v11_0_unset_safe_mode(adev, 0);
-
-	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
-		me, pipe, queue, r == 0 ? "successfully" : "failed");
-	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
-	 * reset status relies on the compute ring test result.
-	 */
-	return 0;
-}
-
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
@@ -7049,12 +6817,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r) {
-		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
-		r = gfx_v11_0_reset_compute_pipe(adev, ring->me, ring->pipe, ring->queue);
-		if (r)
-			return r;
-	}
+	if (r)
+		return r;
 
 	if (use_mmio) {
 		r = gfx_v11_0_kcq_init_queue(ring, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a926a330700e9..385dbb1680b3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -390,6 +390,245 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static bool mes_v11_0_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/* Disable the pipe reset until the CPFW fully support it.*/
+	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
+	return false;
+}
+static int mes_v11_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
+					 u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!mes_v11_0_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, me, pipe, queue, 0);
+
+	switch (pipe) {
+	case 0:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 0);
+		break;
+	case 1:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 0);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
+
+	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
+						RS64_FW_UC_START_ADDR_LO;
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_info(adev->dev, "The gfx pipe reset to the ME firmware start PC: %s\n",
+			r == 0 ? "successfully" : "failed");
+	/* FIXME: Sometimes driver can't cache the ME firmware start PC correctly,
+	 * so the pipe reset status relies on the later gfx ring test result.
+	 */
+	return 0;
+}
+
+/*
+ * With MEC pipe reset asserted, clear CP_HQD_ACTIVE / CP_HQD_DEQUEUE_REQUEST for
+ * every queue on (me, pipe). HQDs must be torn down while pipe reset stays
+ * asserted; only then clear the pipe reset bit.
+ * Caller must hold adev->srbm_mutex.
+ */
+static void mes_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u32 me,
+					     u32 pipe)
+{
+	unsigned int q;
+	int j;
+
+	for (q = 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+		soc21_grbm_select(adev, me, pipe, q, 0);
+		/* Start from a clean HQD dequeue state before forcing HQD inactive. */
+		WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
+		if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+			WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+			for (j = 0; j < adev->usec_timeout; j++) {
+				if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+					break;
+				udelay(1);
+			}
+		}
+
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
+	}
+}
+
+static int mes_v11_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
+					     u32 me, u32 pipe, u32 queue)
+{
+	uint32_t reset_val, clean_val;
+	int r;
+
+	if (!mes_v11_0_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, me, pipe, queue, 0);
+
+	if (adev->gfx.rs64_enable) {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+		clean_val = reset_val;
+
+		switch (pipe) {
+		case 0:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE0_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE1_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE1_RESET, 0);
+			break;
+		case 2:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE2_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE2_RESET, 0);
+			break;
+		case 3:
+			reset_val = REG_SET_FIELD(reset_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE3_RESET, 1);
+			clean_val = REG_SET_FIELD(clean_val, CP_MEC_RS64_CNTL,
+						  MEC_PIPE3_RESET, 0);
+			break;
+		default:
+			break;
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
+		mes_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc21_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
+		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) -
+					RS64_FW_UC_START_ADDR_LO;
+	} else {
+		reset_val = RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+		clean_val = reset_val;
+
+		if (me == 1) {
+			switch (pipe) {
+			case 0:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE0_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE1_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE2_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE3_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME1_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec1 fw pc: CP_MEC1_INSTR_PNTR */
+		} else {
+			switch (pipe) {
+			case 0:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE0_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE1_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE2_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_val = REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE3_RESET, 1);
+				clean_val = REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+							  MEC_ME2_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
+		mes_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+		soc21_grbm_select(adev, me, pipe, queue, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
+		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
+	}
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW start PC: %s\n",
+		me, pipe, queue, r == 0 ? "successfully" : "failed");
+	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
+	 * reset status relies on the compute ring test result.
+	 */
+	return 0;
+}
+
+static int mes_v11_0_reset_pipe_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				     uint32_t me_id, uint32_t pipe_id,
+				     uint32_t queue_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = mes->adev;
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX)
+		return mes_v11_0_reset_gfx_pipe_mmio(adev, me_id, pipe_id, queue_id);
+	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
+		return mes_v11_0_reset_compute_pipe_mmio(adev, me_id, pipe_id, queue_id);
+	else
+		return -EOPNOTSUPP;
+}
+
 static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				      uint32_t me_id, uint32_t pipe_id,
 				      uint32_t queue_id, uint32_t vmid)
@@ -762,10 +1001,16 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
 
-	if (input->use_mmio)
-		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
-						  input->me_id, input->pipe_id,
-						  input->queue_id, input->vmid);
+	if (input->use_mmio) {
+		int r = mes_v11_0_reset_queue_mmio(mes, input->queue_type,
+						   input->me_id, input->pipe_id,
+						   input->queue_id, input->vmid);
+		if (r)
+			return mes_v11_0_reset_pipe_mmio(mes, input->queue_type,
+							 input->me_id, input->pipe_id,
+							 input->queue_id, input->vmid);
+		return 0;
+	}
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
-- 
2.54.0

