Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94473C02195
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEEC10E3D5;
	Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UkZ1dw5E";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C5310E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZlHnQpMxlVDU5Tst4OyewbI5yxfBWVByc2MBPC5z2Blyd8YJ1JEKtvUxxivE4o1HWKHHWdkqh4XQ1WOQQq1ND90A5SOtAbgFNLqbB2qb4zhv12eaPWmOMCUlOzBOQKc9WnOCvl6RQa/WqIzODt9ifsAYMWj9MtRxiSr4MDgZDCP25uMD5t8T3MDd8X40/GLl/3GtPVjUCMagUfZcXTDCWGlPgDj7A1VNUtIdUY2hLJ/rcI9yNDk3rlRSyJ129XrN+zLd076x9y20ff8KAS6h2w3KbUNGNONQNMf+cd4RDrP6gzZqE84uai/KLMzF/n0QdKAgKc4TphAINBdwplBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0oUs2jw2phEG/GCVxYf1M4Hb6yp1RioxlbJoQ5ayMU=;
 b=kiQZxgyPdBoIvtlu5lKN6FdG7uK1EkcodujRtclxUugCvgB7EpBoPgifbgcEJjHf+gUddaAO6bBbARj1+UO5FbgDECUKcV01Nb5cUQIpGZslpic9na4oztePvhY2i1OpK3xwDKU31gyN4NEPgFfSP2VZMp6/7GrlcBzZMqLKu6QPAPrN/4MqX4pfElrjWBOFPkq6AgUBVEOiZKYxJKWMErg+9SSd0LB/92j2yF+9rWsqbE/kWOO0nwyKBmJehxltz+49WCkmkLAOWX8bd6KCfk0x2wR9OO8iEnFGYVZV5+gVSYyYsNM/SGGnY7mX1IC9HxZNiNCJ9aMmSl7I55GEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0oUs2jw2phEG/GCVxYf1M4Hb6yp1RioxlbJoQ5ayMU=;
 b=UkZ1dw5EcjFbn5N29iPITo3fsScAfV3TaYfuuOxA0G7WKbEXmYtiQQd5mvCzqHcIq+BUNJhqVXdjXqzPar29BfhfeKVKIq0GkXzL0vuu9FlXxjquh7mZlhyR+fH4Qmr/NwAWlCblA/3HWcfmbawtjL1415oUrlfH0aED+DbFL1I=
Received: from CH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::7)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:18 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::7) by CH5P220CA0001.outlook.office365.com
 (2603:10b6:610:1ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/44] drm/amdgpu/vcn3.0: add set_pg_state callback
Date: Fri, 31 Jan 2025 11:57:22 -0500
Message-ID: <20250131165741.1798488-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d126cf-cd7f-4162-1289-08dd421875f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kmEXzyKN7bKw/4Vg8XOHosIxBUQeTLm6E+UQ341W3frufuCBeXAj8YJxwbDa?=
 =?us-ascii?Q?FH1IHj0XnnR7VSIbySAqUcPWfKzZp0HYg4fFdLx3XYSWg9hy8Nus/DKn6xR2?=
 =?us-ascii?Q?xbPILyYj3UGpT5TLWQJhPtaUak7Bj96d7eqVK/FOXeXUzc8FVEWNNtTahJpE?=
 =?us-ascii?Q?xPSBnVinH8k81lenYqDSJRrCkcXwNf0QsS5BR4qeWOGp3PuRZEeML8ffd63y?=
 =?us-ascii?Q?DI0TA0fothWrL3+nxEWdPkDP16K9tH+89Kerc+z67EeIXtkCB3ccZvRZiVlF?=
 =?us-ascii?Q?a0r+00y44mdbyHtwHt7vyMAPL0/pEqEWTvb9Zxg1gkLbO+tWOku1XWbvIYDy?=
 =?us-ascii?Q?IbfyTNgTq859SN+KREDiLLhm1G7tNctViewmKR4y8vGL60ihU4goRUabOhQL?=
 =?us-ascii?Q?aDAH2a6F4/F6YxWCMH557noF/thB8SYlPg3zNJRCrpQ8KWOUJOztoqqXDBch?=
 =?us-ascii?Q?XX6qsOeN2oDe7irbcy2nDPAAO1U21lOosxUR+n1EhF1eZT87+Z0+8qBJlwsn?=
 =?us-ascii?Q?v6nQCg/oKbJ9zPSjfWu9zAsrs2yFyUrJidY33mZdRVTDdNm5B8uTby9nfPeZ?=
 =?us-ascii?Q?R3aQaz///XeGMAqmP5+zBN7C/yJFmi+bTvZ8uiPCabL0VXvnpGjVRHcG/QRA?=
 =?us-ascii?Q?pcWJOLILCAZdZT9puYkv13yY+334YBXZl5E6CkorOKDxyMGu1HrnHmwPJTDq?=
 =?us-ascii?Q?rNlT3jM7xEbRecdj5wFtnVLeb9A+3Iuemsgjh3uT0rShMKISkfrGWbSibfFR?=
 =?us-ascii?Q?jlxXXsg70qHvHP9KcybQUxDfDdL/bJIpcVv2hohXIXg3rJ2R1sj8M84AGwG4?=
 =?us-ascii?Q?FWrFqJ1sUHWKmYXwOr2d7iC6c3zHOov/2W7aoKkmLLqMgEpAIOT5czVwYRLl?=
 =?us-ascii?Q?aSCJm1R11FdttbFXRiUqk8PriPeC8MhGxfh4ayyZxxaIIHIKW6HnH18XG7Ig?=
 =?us-ascii?Q?cifF0nM2MY+Kh+SIjj/mCtJAXciWAxz5VfKoVrH8s22hozmRVK1cV6Hw6tMe?=
 =?us-ascii?Q?jl2bmn/SYmh9v2LtJ/qtS+ba7qoznXDiKYr5SnoAfXWqzP/tHjZMchNHV6PH?=
 =?us-ascii?Q?Gvk07OECpetXfvte8SEyfr4JSblhRG/alelbShM35dAzfq2qDDUVpmE8jrO9?=
 =?us-ascii?Q?v3ifBu2vVc5B+dFxNOc7wVdEJAh5hb9n+rkUdKvdf7s0xdBqU/MI0fbmzaWY?=
 =?us-ascii?Q?BjpxYWEjh+1Sg0qEZklUNGRBU+GDLrwa3RnU4ZzBwZnFe8GgN0LmL9RCksdr?=
 =?us-ascii?Q?P1lYX5wtTAlMJ+zsbSv3gsyqGwPeZsheTv2xlQatHnmr77+Ed/q6b+XB4JLx?=
 =?us-ascii?Q?mD7IurBW3Ya5TzBhU7xwCE5u1B34UALUKEMaqXAfP1gVBAalq1oQ3IvdXJgo?=
 =?us-ascii?Q?85ZVKRuZPWYef/ketuhKX295fDCpni6Io4OyqrdrEZVXCBn/Or7SxasPE9SK?=
 =?us-ascii?Q?QEd5e3lj2AoEknxBt/m4WkMdui/ZLKtUWFrK6RWtxJn3MFm0rd9j0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:18.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d126cf-cd7f-4162-1289-08dd421875f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 39 ++++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2a17a7e108001..353aab5565702 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -105,9 +105,8 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i);
+static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -155,6 +154,8 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v3_0_set_irq_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		adev->vcn.inst[i].set_pg_state = vcn_v3_0_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -440,18 +441,18 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		cancel_delayed_work_sync(&vinst->idle_work);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			    (vinst->cur_state != AMD_PG_STATE_GATE &&
 			     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state_inst(ip_block,
-								    AMD_PG_STATE_GATE,
-								    i);
+				vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -2200,12 +2201,10 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i)
+static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+	struct amdgpu_device *adev = vinst->adev;
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2213,11 +2212,11 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
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
@@ -2226,7 +2225,7 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v3_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -2237,9 +2236,11 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		ret |= vcn_v3_0_set_powergating_state_inst(ip_block,
-							   state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.48.1

