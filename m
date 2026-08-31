Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A13C624D7
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1301E10EA80;
	Mon, 31 Aug 2026 18:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSktiyLZ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013005.outbound.protection.outlook.com
 [40.107.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8293410EA6E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOmW3jjBWRSaKrN89WK+iwHxw14tIqgWrQt6/wPdcPVlfUJ6DK2XwRJRv/LdCBjyMmog1R7JAXrMnpau8ope/5k0sP9C7zq8u0ZymWL51bOtYcMchwX3NyW0823K5Vc1k7pBBlKnE0D5bfaYfkhqfVkTwXX0A/8DEKXP0m9NGpOZHWIioseIVAbcYKvonisE+GFaPKHEHdVMtXMWXX3tJyFFr7eRZcNNE/cBwM3eT27MhXIPDBRhJvnHO8I5lGI0vBNVy4snzeBrXEDnp4YTmVeH1dtgYc/Kq3zmBKj9QdgfcKsU+rBGKJAVLJuz0r/7Gy9q6NM/oORL5tlbiRwsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMvhc2vaAMC4nneIft0NY5ILDo2zrR0wSOQsILJwegI=;
 b=MkVldJZPuF4kakfLbFYavZt6vSUBbXpiVld70mqg7/XSF+dtzQvxCvZJuMifFfY0mTMdOr9WeNra8TnZVTT+JlGkaHnVYkALHo2F5tWXG5XcFbVPTAX4906JdhPuFiAkkVHA4i+eTLdIwCoDdp474YeOLuets2gH9qLQT9IRMNaAtcZQcy2ce0WyW6PsC203QMs3VxrVhnKRwMGNxTF1l5MpuiNIIG9b5zsTD/aeH2baCQgPHXtfXeOrgB/Gg8ugXA7kDK7G0Fz9jexdHswvqKMTEZsd9WWQ5U2uWsvf735UnNPizRl3iFEqvfyvPuh3B+Dxo+PMK7eoMfTRTCWJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMvhc2vaAMC4nneIft0NY5ILDo2zrR0wSOQsILJwegI=;
 b=JSktiyLZ5uyngGGDGB+p5iSSCX8vFd6eN2ZwvGps6V8oLYTSmGpHtzsTt5Th+jKeS1MDynuQM9fWOnaC4S9/+62C3zlHPmJcoNnlpCbfFX52eExHUZBnHykBskYYCygTepTwlevbt/m7VIEnADAU51HCYJY4xnznAAzjk1tJ4Po=
Received: from CH0PR04CA0117.namprd04.prod.outlook.com (2603:10b6:610:75::32)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:09 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::e) by CH0PR04CA0117.outlook.office365.com
 (2603:10b6:610:75::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 66/95] drm/amdgpu: Fix initialization flags for UALink XAs
Date: Mon, 31 Aug 2026 14:27:25 -0400
Message-ID: <20260831182754.1089811-67-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: b5357b99-9379-414e-c394-08df078dbec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SUke94bd69WIrOCm+uhj9UhTMoGcMimNjQPT4O3h6WR5IcR9crXawmdOjluiv3AsMLKQsj0eCdBV14j7twOmiwloffanpNHUucBce37dSPJEvOp3ZCtTftkxhAer6veYF41Cqh63PcN6X6Oz32QsHCIno13j0ObzavtvyVb8wWDt2OXdp+ur4oduGVx/Jr/22CuEICKrBrMn/wc1TnYOOFhnDBiiitjJSXd09YsHpf9qjpBhmFYsd2oRtRh36I864Xj+YjfjIvPjYU1T2zqcsf5x6Cdn4+iIadUK5itRJ6tsVhiWujGn6uKou5pSfu14FJ7O5RMMdcJ+z/9YgH6a2vUi7cjeIwi8YfNXYPbyZanayQN+Fr3jrdUS5JPQJcH0ls46JwktJKDz1YUKRl7NGBaWGzlxaEB0yieB6sshV2D3mZIQt6KUGymQII2+771Sygl6voS9ThZj0bHQN+nS40LQ76tz6PuQTDb/KScKM3CysO02vR6DzSttzlyhl0M6XUUSseJCTzgNuCegI8iaf4NnxkRp2/VhskdCErxViOUVhO8zOXFGFjiwt4hGqEwEaLUKLMI9gtIqpoU0Kf/P3f+EAB2iTrxisdioKnluHbiYSSdOHIB+fayw66w4lBZXKDd0m+axYpE+BPbyOW/asn2KuLWDTavfD6gVRLydeN18X1+MWXdZGLlk8P7vMDsmA9EbPd0r6iMS0D5rMtqa4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fSYtGhrgv7REuFYp/ub9y4uik3FaOAJ2D46NKpxmTywTM0AMS4SbXXvs9+c+CNPfIsKy+dVT4hj9qM9b2Vh3gaBDmb9fLb3XPXnT/ocO6gvt25XkIMos38Ho8ML8qG14rdtNSykH2lF/Qj0EKtjqxcnw2o4Mp9QR2hfZclWck8rGNx8E5bfYJA/QadImiL+/AzwBG484+fD3tT0D5Um3/PlKptcaQLTfDnmuAX6/TCKoQDAkJklysfCclNLjZfpvowTKi58ggj1BNnTv70digeLdE6ZoAnz8lKDmxt+79RNMRnqpehiCvS6+NnvtSSJtUkFivtXwKQjsqNrAz5vQKVP2lMocpcCGu2ysBi75HDHHRl84/n//Gof05JDjtseJuSao0p6z5L9fvbpwwclHCS7FOnG3TjTTDUnj3ODa3nKa4lpQE1m/euMG6m+GgTfU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:08.2063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5357b99-9379-414e-c394-08df078dbec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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

From: Mukul Joshi <mukul.joshi@amd.com>

The UALink exp_xa, imp_xa and handle_invalid_xa xarrays are only ever
accessed from process context: ioctls or workqueues. None of them run
in softirq or hardirq context, so initializing the Xarray with BH flag
is unnecessary.

Drop XA_FLAGS_LOCK_BH and use the default plain-spinlock locking
(xa_init() and the plain xa_* accessors).

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 451c3437f5bd5..be38e9ab47a7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3447,9 +3447,9 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid,
 			amdgpu_gmc_pd_addr(adev->ualink.npa_vm.root.bo));
 
-	xa_init_flags(&adev->ualink.exp_xa, XA_FLAGS_LOCK_BH);
-	xa_init_flags(&adev->ualink.imp_xa, XA_FLAGS_LOCK_BH);
-	xa_init_flags(&adev->ualink.handle_invalid_xa, XA_FLAGS_LOCK_BH);
+	xa_init(&adev->ualink.exp_xa);
+	xa_init(&adev->ualink.imp_xa);
+	xa_init(&adev->ualink.handle_invalid_xa);
 
 	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++) {
 		init_completion(&adev->ualink.conn_state[i].hello_done);
-- 
2.55.0

