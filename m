Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875CACA0EE6
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 03:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E8210E33E;
	Wed, 20 Aug 2025 03:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8LyqHB0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277BC10E053
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 03:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeQSpGW4JDSx5v75r4ZrHx6SC/gq5ydHqtVpsMf1fInfqJL82JHExk4i1T9SOmqPJc6Soz8vbNcAzwZJCfHFDXW6caTNsgNMESvuxG+f9qkKQdteVYRBCEb6AirgbD+Eeo/l1oodvzZ8VURJ7wRxmD+5CtckHLOTP0nuE6yEjG4q2LM0UaTj9YmStQ61mF5m/KkqWLYbE4TI6DzYKFoMGMP+gT05vYzZqQGR2wHinLCJBQ1rAL/a+wUWkpHQyF6dS2hKU5sxmFIWDkG0R8RVTiH/vtrnYOfXzuIdq9uaS5yFdQs1Y+dSRM71lpF9UpcgxPsa6++tyK8xrpavvJ48cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJD37CHWiFkXyH9blePVI+uYmYJznLzThhxyZjnXlpE=;
 b=fRL15dnLftplIgyA/XB4krwDo6+LAXJaUldypJjYDxi8GptithsIRTQKc1jZZms/FY3SslbPERQl2vn4aO2Zi7JxPE3yeh4nsEOLbr/sfLka8wntFqhKQmrUjApPbpGYqBSpM5KtY8GT/EaGE8Zr1orD1OehSEFtNYVlN0/mI3F3ftXfmjJbBV7ZQGSYWLxUaeS3WktkR65NTGTbbLDLlLDSg/sSA+Ua3mhK5S/Eeu/84Rt3LjPZvTNuAb4thWG7/bXCu3qq5wW8jiPpDUZ+OYXuwhjhqtxRNtRb8c0fckX6NbIQGo61ez2kyKmesjHUROkmVzKyAMx5698CmXfPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJD37CHWiFkXyH9blePVI+uYmYJznLzThhxyZjnXlpE=;
 b=L8LyqHB0a4el/K5rX/j6h0Q0jJSz+We4iyMVsNvZvW9IN/bwLlPu6g3LQKCOMnEQglr6ZjgaVLo6d2KLSzs1BuPPzGOVickPFMIUYM0s/Fj8GrFFzoLsl0QhJYOLTuLwa3BUg7Qcdu8NE3sxWJW1VPlbNZfoUpZe8UAr+G4wQXI=
Received: from CH2PR12CA0004.namprd12.prod.outlook.com (2603:10b6:610:57::14)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 03:04:07 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::fd) by CH2PR12CA0004.outlook.office365.com
 (2603:10b6:610:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Wed,
 20 Aug 2025 03:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 03:04:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 22:04:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 19 Aug
 2025 20:04:05 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 22:04:03 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v3 2/5] drm/amdgpu: Add ring reset support for VCN v5.0.1
Date: Wed, 20 Aug 2025 11:03:25 +0800
Message-ID: <20250820030400.514460-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250820030400.514460-1-Jesse.Zhang@amd.com>
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 0283cb5d-1288-48a1-587b-08dddf9639f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QeQUBnwiUTkxtkEDBHDCA0SRPATdoSnyrhQg91C8w1qE7L7YgnTQLyxFx4ch?=
 =?us-ascii?Q?4IwugBop1hAjlG1dmIC5XAqEzWftncxUkJ5XW2oGUbD2IbqwK3DCp/JW6Vu7?=
 =?us-ascii?Q?Gg4IEIvNYPIk54tA8AMTd9I5aFh7j6rRj+UGit1vK13XgU7GV6vo1ob0zaaw?=
 =?us-ascii?Q?2m7jUsNthGhEleLqYXzKZBmYhFN9Z0Lhjttzbh4hr1RmcA2TcTI9Y5nshHjy?=
 =?us-ascii?Q?xXMeYvGaDgCeB63ln8cceAeuCR/cpcE7t7FL+DrmJqkewf0KNEo8fGgktkkh?=
 =?us-ascii?Q?dNemlBRuoS69FuG7a/GoB1/owepCTVR22VaWs2WwmIvgMbpFSM/sduLtArxe?=
 =?us-ascii?Q?OJQ6n9KgoFhanuFisq7X4Q38wvGngIbI4F7kKQIKo1q0exwSSi0ikN45ykHo?=
 =?us-ascii?Q?NGLPAPTM/t20Ptox5UvG2ry5PdLlHUI79FvF1UFLJ0WJytkL1yP+IP9vvqr+?=
 =?us-ascii?Q?m+ESRBQ1gCJnrFEJr607c1afzA+T6s5Agtoh7F3qBJvlJ5H2+2mvN7WIz5YQ?=
 =?us-ascii?Q?qPZU6jgLA1po+VuJBthc25CDLZMns9yMa1ylvltoTF3k+BRuVl4Jpu1XiSwe?=
 =?us-ascii?Q?7W7KgAHzsceG/9NnC9uvqGsOs3F5eedJ4HqGnZVp8O9V619L7Tg4OdunYUuN?=
 =?us-ascii?Q?edyYWQA5VfZA5piFQS+QAoj8l7fVI+hqXX7fnEVGyg/7dCj/hJa9pz9VBE0p?=
 =?us-ascii?Q?n/T85T1X9CPuRxkwxA24p+xG7aVfKrjmcg2J2UP+aVE4vdi6eYwLuoCoclxv?=
 =?us-ascii?Q?Tlk5B7TaAPdpO1GThyVLbvHjYi4d+mqWaKHAKdt0/vTeyG628mNfZ/KNkzm3?=
 =?us-ascii?Q?uILbvG82H3KMd04KysM2T0qP8ctNsMyEFpCSyB6DLesGUFcfYaKl3M0yvi9v?=
 =?us-ascii?Q?9giDRa4ZwbLp2/Ot7/pt5BbxuAI4e/0ESvcxcsmZroz1zhVkgU66H0jOPQ/S?=
 =?us-ascii?Q?43eKR5D2lCN2MPf5Imxcy/EKKiqpx0XyP5XzTUs1Q94OodtgKnHpMvneK6wZ?=
 =?us-ascii?Q?/1H3qfAHHpeoZEscPCkjbdjPCmiVoIODjev2zXL5NPf74twQhMTtqXgPHsC0?=
 =?us-ascii?Q?x4/AWb27BeX5uya86fDpptQoJBL/IKBQE9XJAod0QbwNJNNHy5gQiqaROz/H?=
 =?us-ascii?Q?z1Od9rJaG2U0112TJzOtO22WukM3O7xO9nWRYgJXkemlgk4ssevX/DpG4rSG?=
 =?us-ascii?Q?EZnkcVRAQNdB8LXDHTqfZVivEXECiUoruT1pliBdkL25NttRWsyqFjpa9VNb?=
 =?us-ascii?Q?Q5g621CWkebgV70sTYj1dvEl8BI0+6LSKVTEyGy/+nIbYT0TDYjlylxw/VlK?=
 =?us-ascii?Q?TC3xyrJ34XTNkb7GBtKGswjpmmCW0BF18pcd7FnFaarAhCM0IJ8AbcgG3z+D?=
 =?us-ascii?Q?NUixvd0YWOPiqPTNMEw3VusLVhPYWenCexkZu9kXMUV6vIhYJsS+T+gnuwgK?=
 =?us-ascii?Q?31GBFzdnrG4z13q3XqYlRaLNtuezmiipocifA+nZamEyGZAS7kotHXDteDhI?=
 =?us-ascii?Q?yvmK4pzUthWkUrcREUNomPzdco3LOHCl24sc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:04:06.6645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0283cb5d-1288-48a1-587b-08dddf9639f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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

Implement the ring reset callback for VCN v5.0.1 to properly handle
hardware recovery when encountering GPU hangs. The new functionality:

1. Adds vcn_v5_0_1_ring_reset() function that:
   - Prepares for reset using amdgpu_ring_reset_helper_begin()
   - Performs VCN instance reset via amdgpu_dpm_reset_vcn()
   - Re-initializes hardware through vcn_v5_0_1_hw_init_inst()
   - Restarts DPG mode with vcn_v5_0_1_start_dpg_mode()
   - Completes reset with amdgpu_ring_reset_helper_end()

2. Hooks the reset function into the unified ring functions via:
   - Adding .reset = vcn_v5_0_1_ring_reset to vcn_v5_0_1_unified_ring_vm_funcs

3. Maintains existing behavior for SR-IOV VF cases by checking RRMT status

This provides proper hardware recovery capabilities for VCN 5.0.1 IP block
during fault conditions, matching functionality available in other VCN versions.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 1b5d44fa2b57..779043eac827 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1284,6 +1284,34 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
+{
+	int r = 0;
+	int vcn_inst;
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	vcn_inst = GET_INST(VCN, ring->me);
+	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
+
+	if (r) {
+		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
+		return r;
+	}
+
+	/* This flag is not set for VF, assumed to be disabled always */
+	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
+	vcn_v5_0_1_hw_init_inst(adev, ring->me);
+	vcn_v5_0_1_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1312,6 +1340,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v5_0_1_ring_reset,
 };
 
 /**
-- 
2.49.0

