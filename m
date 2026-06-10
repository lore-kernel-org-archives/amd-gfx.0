Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CDDCD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 05:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F21310E703;
	Wed, 10 Jun 2026 05:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xbziN7a5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C0510E703
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 05:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOpNfA1eOad/7xwWEhgAnbY9FFwzt8vBMTt1u05UoQh39cMUmhSwzyQRM/bwk8ZKQALNNAjB0C5mNROFbdB++yCz5YQmcFHYWvXEXSiVlNipdaZoRYEVXb3cQgalBiu62Y6Nb7uVnHULqjGMMotrwlgeSDYxnEK82Fm2cNCpPUetmKpLkm6FagLDS/GKHq3cYJbszMm8eLTO198p3fPQehEBFGiEH6hUMXoPkhiwFp+8cVoM0etqBhrTlC2nlr3ZwVMfJW13RNa9zYHfDvSl1RgkyuQSVZGAUHk+44hut8MGn1Fv19xn+fs6uSDSblSxaIKAgwLmRwGhrDfFG+KkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhRIPIA2Bl3nCirJSIUR2AXAtUV+3tEpo3miE/rdmA8=;
 b=WJqAiuwToGCAObGlGBy9mwBXTuWwC8ZT5hcw0ekVhHWshXY6DxS0B07B0wzBFgjozREqjOogGhU4erks+1KjK5sHJAvj3jEX5Rs9jvT9REfv0k5q7hAQF3bSA8Aj2MyR/1VjAFoNc00YWpvV4p9kjfxN89oeqSgOpFaMh1Biq2bRMg96dWNIwWfw2a3IDxPtQGdjiIHdTqBWhOQiApR5PksHKQrM8ajMjHIQ8m6E2B3D2GJ2y9Vk58IW5Zcix5ufHybIt61WyoR847XoMS5O48CQt15b9V+Q+aZlZqD41MRwvMZdEY9SxJVF7rneTHtMZq67BrZ4NRTrESc7764QsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhRIPIA2Bl3nCirJSIUR2AXAtUV+3tEpo3miE/rdmA8=;
 b=xbziN7a5wjJrqnKfG2dbCzTjEHOHi7Knm5uemePnpeH10GN3ULMs+2KI0rrNS3aDmBM/Sp8vukubFzWrLJmnGABJ2XtEM1RnxVcOE2fTrwi1IYBMZKBQYM7/Nfh/Ve82IsrLOhrvUitoFnqLjaIoVWYuEAl15WKfhmav0mgIkTk=
Received: from CY5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:930::31) by
 SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.11; Wed, 10 Jun 2026 05:57:57 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:930:0:cafe::59) by CY5PR13CA0003.outlook.office365.com
 (2603:10b6:930::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 05:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 05:57:57 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 00:57:55 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>, "Huang
 Trigger" <Trigger.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
Date: Wed, 10 Jun 2026 13:57:36 +0800
Message-ID: <20260610055736.951241-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: b775e4e4-f359-4938-d49a-08dec6b53860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: P6NsvYjOH2Clso9zA24oV5D0dIREOYfI0ox2Xr5rRmvGpYQikcfgj2mRxAT6g5ZlFR0VkFBy0bZSqFq+Ua5p4qeNGikerP7mtwB0lhsyZL8qj74N4pDXz6xGPnMp2+bu6vjuJmmVNvtntpyDeUTLwS2mhMZgkzCHvz2pI8lJtqGi8CP3IRGXW1Suk0JYw/Zd67iSKffDC2B0uCy1D0CjYLYQrwZfn5SB1RYc3rwwjlToeLbPb5VnJpEuTYBNOdp/kWox4ByWzvr8VgRXciDVj8JZ+JnPGIpTSYPmxfK4o/tHU7CoK0R0vnrWAqJmke7fO8+eYVZTYg2hRujUwElJR1ZTbkIE7TzaJSyv6WvAlGt0UX2FHrWS+tA+BJc6qOxD49IHdtK7eGh6qeivmtXOKvw6G0rqUFeeg8ieB+yk65VgOSCxNsXy1p/Kald5p5TCSTx8IoBAJgcLLbqRfxCh1/qtZeGFgtSY7wSZheaNkwSBavlQYtJEvkKjF0ZaphkpdcfVKPCv02q41Ywobdp2tj4zx0htU4ko97Un+7DWJmndiVCHWxGCzJziVp0T7H0h4gI0zt3aQOXcPNzeAY7TtBeOp9jdoRwrLJLx6rkxv2W/d8S/BDIVZElBiwjsQ6VzvvG7+WhAMcNFzjUPGjUCdKHDbZ1lU73s2dHolvf8+X984KaDMe6zY3+z1fIDBG2RrZwVM1qQJG4OI4HwABUn1NsqITksqYXBUnULiOcjw/k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UAfLwDNjBm1donmT0YcyJJ2joPhCoKj4EggXi12CXFoBFdi/m6Q0Dh1hHVpE/e3DrILkyJrfyiZw60hXFkA8ODxdEQrKWMwmaaJLLD0zvbm2rolhUhqgGj/xejFPkWwt3qk6UnsjjJs6cF5M3zKKMoCEzqWThfQAPh1rQCrYpC8lnGIhjooDZObJ+O7xinoMEuTjKzN3ZDv3M1yiiz3jsxzphjQnZ3L9cD3Yos02oB2vM5oarvanDWpI/zUh0lTfKNfCkiix12wZc4npc5QOHfCQ8DYJrBbtXgcyg3moqvVzi7Et1LX776uWlbUCrB95OZMwlPNr6qxxYtqlN6lF7pw87HBSsiqgrajuep5ke36muSLkmXPAHtvTq22+eKGhpK6YEwA254WlKsL9d9y2RxxGysiTFzv65Jl6SjH/TpJLCjXwi1YaC5cQurXg7LwB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 05:57:57.0114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b775e4e4-f359-4938-d49a-08dec6b53860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
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

For Renior APU with gfx9, in some test scenarios with disabling
ring_reset, like accessing an unmapped invalid address, it can
trigger a gpu job timeout event, then driver uses Mode2 reset
to reset GPU, but after Mode2, the CPC and CPF are still stuck,
that causes compute Ring tests fail. What's more, the HQDs of
MECs are still active, that causes MECs use stale HQDs when MECs
are unhalted before driver restore MQDs, then causes compute IB
tests fail.

So, add sequences to reset CPC and CPF after Mode2, and de-active
HQDs of MECs before unhalting MECs and mapping compute queues.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
Hi all,

My board is Renior APU with gfx9, smu12. I run a testcase that
accesses an invalid address to trigger a amdgpu_job_timedout()
with disabling ring_reset, so that driver will call mode2 reset
directly. After mode2 reset I found compute Ring tests and compute
IB tests fail randomly on random compute ring.
We checked the scan dump of GPU, we can see the CPC and CPF are
still stuck, that may cause Compute Ring tests fail.
I added printings in driver codes (gfx_v9_0_cp_resume), and found
the HQDs of MECs are still active, that may cause MECs use stale
HQDs when MECs are unhalted before mapping compute queues (restore
MQDs to HQDs).
So, I send this patch to fix above problems.
There are two main changes of my patches:
One is to reset CPC and CPF before resuming KCQ.
Another is to disable HQDs beofre unhalting MECs.
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 40 ++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 47721d0c3781..dc0978bc312c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3944,7 +3944,8 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
 
 static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
 {
-	int r, i;
+	u32 tmp;
+	int r, i, j, k;
 	struct amdgpu_ring *ring;
 
 	if (!(adev->flags & AMD_IS_APU))
@@ -3967,6 +3968,43 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
 		gfx_v9_0_cp_gfx_enable(adev, false);
 	gfx_v9_0_cp_compute_enable(adev, false);
 
+	if ((adev->flags & AMD_IS_APU) &&
+		(adev->apu_flags & AMD_APU_IS_RENOIR) && amdgpu_in_reset(adev)) {
+		/*
+		 * CPC and CPF are still stuck after Mode2 reset, that causes later
+		 * compute ring test fail and then loop Mode2 reset infinitely
+		 */
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1);
+		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+		udelay(50);
+
+		tmp &= ~(GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK |
+				GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK);
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+		udelay(50);
+
+		/*
+		 * CP_HQD_ACTIVE survives Mode2 reset. Deactivate every MEC HQD to
+		 * prevent MEC use stale HQD when MEC unhalted before restoring MQD.
+		 * Otherwise, later compute IB test may fail
+		 */
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+					mutex_lock(&adev->srbm_mutex);
+					soc15_grbm_select(adev, i + 1, j, k, 0, 0);
+					WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
+					soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+					mutex_unlock(&adev->srbm_mutex);
+				}
+			}
+		}
+	}
+
 	r = gfx_v9_0_kiq_resume(adev);
 	if (r)
 		return r;
-- 
2.39.5

