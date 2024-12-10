Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80C2E77185
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B4510EA06;
	Tue, 10 Dec 2024 22:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47i//hTt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB0910E9FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtQ2LUC9wTG161fW5jmkikFzu1I1+gGuQ2NR7cD0eV17cB2u9/EFEmHG2UmZwvhpl8f23iq929IdrA2KjcBsBEww6By3UwAWlkHowlqeJMdfIqUw5lx0/GqQzswGT2iGRY5BGxVjQBQUAQykMK5SvgF0oo/RrQjZUDqXRvciPw5bWQxWii0m3myej04GNMYfmss8sogq+dsnoWE3gsWjowbHD/47wjgccY+KSzGdkNGlmdSXXB8qfvbqw8N7x56YHNUQkZoGvoiFREhAykX9ZX6oTxhLDTE8IbWWIcrdx4iw8GAchXK8Yd4Q+rRZ7KkNoJxtayMQh1Gc4bcX0wQ3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XetkKZEFeIH/fI9HLbxtrA96KLK3jZd8jOOEc6qLmw=;
 b=vG8OfDxMFsxLDNnUjcqm4D6n0MAwq3xyNbZH+h/KA34S7SvweSLLsa5ExfFNXWF9OcYHA6m0RNDLCwUuX/QN1tqw3bovJh/WcGq+XFqEUHxcewm2Y2beIHq8vBVIFtzm2e3/iGZ+gvWYowQF3ggAE7bTnsLypBFqbicYpSC07I0WKSTWeUGspQaJ2yByqSyQxNBUmQN2yXY3XZTuJfOpUIXIP0Nv4b2TaTBQwdnJOlDGJGkoHWdXmFeUYuyR5BX33JQyBKk5gyh7QPeB3occC4QB0gzwPQvPVz7eOs5GDCbegfbvE0+Td4Tm81oE3Fn1RRDP0Ewcv+fv6cRHhulNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XetkKZEFeIH/fI9HLbxtrA96KLK3jZd8jOOEc6qLmw=;
 b=47i//hTtKpOf8HRItRHHmYszz8f/TR3WISagg3JK9VbbZf0YthKnX5Qo7lvqA41td65E4OdVGUWjKDG7J4wqGyy+xsvOcj2rjiVktUStVTdDifrPuCmBdSYK798y+LxQcfK3YKJIpdr3UmSYg3NvkWiUZzD+j394jVE06HNA/7E=
Received: from MN2PR01CA0035.prod.exchangelabs.com (2603:10b6:208:10c::48) by
 DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 22:54:13 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::7e) by MN2PR01CA0035.outlook.office365.com
 (2603:10b6:208:10c::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 10 Dec 2024 22:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/48] drm/amdgpu/vcn4.0.3: add set_pg_state callback
Date: Tue, 10 Dec 2024 17:53:17 -0500
Message-ID: <20241210225337.75394-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f163e20-9006-483a-c74d-08dd196d90e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?icSYlgVRqblOVlVmKTJgBKxL8o6U+mKMJ5MstIflFiaEjabIVWZr0ee+syWG?=
 =?us-ascii?Q?1XW02ZhIgw+x6Qlqb0XTyeeVWGPzMwviSkNUiKtnj1R1voXImOwH7cDYZ1vS?=
 =?us-ascii?Q?/JCCVU2x1iMoGgHSPyVa51O/2JiDPYVUxu4sGqDdid8zGF0CV/j65EFK6Bqb?=
 =?us-ascii?Q?k4MCLHlBmqIHv3mngUGFZw26b5t52MDwGKSkEuHDnGggaEhkOoiK0P6R1jfo?=
 =?us-ascii?Q?7hX3q/n0tii5w/mCHCtE20MH9gDsboIs5Qq5lFPRBjS3WYmCKREIHqZ8eLWZ?=
 =?us-ascii?Q?PCSq7gKh2xMC1JxvRHw2r7o9UCMED1mXNBRWHjYDKPKtvoyZqAqUPjEI6Bkf?=
 =?us-ascii?Q?NYXUFJVEjVPCwHNTA2vpw9cAAbt0tKls177T7y0NYOV2T0fnpKAzj4AcBoK6?=
 =?us-ascii?Q?qJ06vrCclzDXlkkZt6EZdunozl3bNxvjW6XR1hgWxGuCVLb6TNZIdgoKX1MT?=
 =?us-ascii?Q?6V0KeDzTFG7WYNF78n2qpVdQXLel/uEXWY6DulfofIvtMlb+8zj+IDkRAbFm?=
 =?us-ascii?Q?r6afdFjgr3r+Ea8T9zC/rt7DDHOhyrtHJZLGr6Sf5aZZChzz2r2Vhslqq46E?=
 =?us-ascii?Q?IvD2YWiUVLh/fcoLxdkXr04q7rSKZ/HkZIISj5c5YG1k8yhCviygUG/Lm1WW?=
 =?us-ascii?Q?m9iwNx3Bg2sVUhznfBugzjk9/MSa7oO5CrpR4c28KX3Oq2eHGPCgznyzDjW7?=
 =?us-ascii?Q?UNYqc0Pl15ttPS4RsRkFzuVD/Cl954T6VDrSpcJ1ZXD0VPSIvEYKCsvL/J9L?=
 =?us-ascii?Q?igve8Qiw87rjTbc6Ep42s0QfEl0muihxmVgwS6TcG/BdLFoyufpLzaC4uIhk?=
 =?us-ascii?Q?QnWGCekcO/KBHCWzbigB3MmRTPJy1in/BfnRH4Jata85yiVoS4JzFuSgLQ0L?=
 =?us-ascii?Q?9cX7mRhb3lIMvHUnD30HRukzixaiHGTmhfWDa3WarFfzWdSwwjcgpZPTVG+D?=
 =?us-ascii?Q?RBT52rtiYxxmCvcBSeafuBNCaPpCucG1hS9Z/R+aU8tzMP/101sN2dKRhYuV?=
 =?us-ascii?Q?jDmfPILQyD1SshnoyiysXRlkvPMqGUg+WfnDJ+vCTvzf/uiLCIGoCJ6TnM9I?=
 =?us-ascii?Q?lnfNHpYeEQXJRveSASHVHOxDmYWMDO6+0ZPFHGhaNv08PeemS9B/jS50clQS?=
 =?us-ascii?Q?uDAq0Z6c5zeXmGSSy9O92+Y/U/KCaf/8sUkUOVpC8HSudz/Vn+jurb7ueD9L?=
 =?us-ascii?Q?ohbJKJGgMhD95qDPhm5gGY/CRpq/wKb4S3L3phHLz27TAw5DQ8st+xMtPFu+?=
 =?us-ascii?Q?lYLG18bOZSWKbaAguLfcqO63Vjj11sUq1Ff9y6D2pvmrAK2hWpaTi/SBrP5y?=
 =?us-ascii?Q?cyrRMh1q2OmNhEQ+q8xXLRJqycR+oFkB/xY/cpN1DB6mZVQj/hKzqlhlGXPG?=
 =?us-ascii?Q?2MRtVNW5X/ggTAiECDMSMAQtVEB5LADnI2c9qLk84F+7TRycbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:12.8764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f163e20-9006-483a-c74d-08dd196d90e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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

Rework the code as a vcn instance callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 36 ++++++++++++++-----------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index b823114cdf552..b6e1466f4635c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -87,9 +87,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i);
+static int vcn_v4_0_3_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -126,6 +125,8 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_3_set_ras_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v4_0_3_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -367,10 +368,12 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		cancel_delayed_work_sync(&vinst->idle_work);
 
-		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE)
-			vcn_v4_0_3_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+		if (vinst->cur_state != AMD_PG_STATE_GATE)
+			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
 
 	return 0;
@@ -1681,12 +1684,10 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i)
+static int vcn_v4_0_3_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+	struct amdgpu_device *adev = vinst->adev;
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -1694,11 +1695,11 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
+		vinst->cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1707,7 +1708,7 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		ret = vcn_v4_0_3_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1726,8 +1727,11 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		vcn_v4_0_3_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.47.1

