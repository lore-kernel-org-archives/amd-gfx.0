Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE14E77186
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB92A10E9E9;
	Tue, 10 Dec 2024 22:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hzNqZInk";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F022010E9E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPRp1P3FsqpzRaOnayWdOhY5otRzqHCa3q+c/0dhopqkenJkl9QGEg9QJE/HHRrTyW8y2gt/Y0baoN2Y7qHHtZHESDMvTY3wnl9E6M+GEEfH3RfJInPFVRlrC1xndcTWF52RIuvSVweMgqog49CT5aW5aLI4MoaklOOaTtnqrlRFf1bLW6pBw0JsoT0a5l3yXZPhc/XuEL/q2ASQGVMIVC+fcykDEfdxxadTXfWjZiTczbg1t6YS4q2WJIymKDJ27AVL/a0Lu24pXAoykwq87N+ww5/Ee+AleeDeJwyoOKfwPHx4i1RiYtLQ3ozc9vv3X61FopyICv1d28EcQYXEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV0ZZ4pZtIuJR8Oc2sd+ulB9zlhDhbvFaDJj66a2o38=;
 b=TVbSbvfHaul5GLCIYcx3F6x2OYYU+vvZXJKbKouA3inhe72U/hbUNEzc+fGDso5fA8KHXoLyRzSxQg5JXRCp5cYsu+QJ1GHGU3Ze+/u5l5/dTPbLzlJ0A8yDw5KHwVF2XiG3wOx4Mxw9Otxlyf5xKPAOgwPceaECby94tAITf5uRbZuMaSe593T2fj6iLSCycCDY2gUfv7R13zHNQnYYx4G9JV5MKpDqYHluXVFXuClVM5YZYJczhxbwBVZHBqRZJKF8o/DFIllchrTiWuk2jwzy4Rt2UKXevidnm/HU1FDW8uvjKfHSm1FhAiVy8L47nuIW6ECYDIenDprGZaBBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV0ZZ4pZtIuJR8Oc2sd+ulB9zlhDhbvFaDJj66a2o38=;
 b=hzNqZInkO2baMJHBi9hz5gHy/+BTiUDDGlgOReoH3E5yd3cR7C8Px5E7CLMyHbpJ28J/Jx2gMFWOHKuA7WR+vytO8vK91goHQXpRbz7yOtjB5fNms8sFPSX9XqgYPRKrPEBfPRXMrR7dBDnC5E+4vxr+Z8uwvzIWw6fTpounCdU=
Received: from BN9PR03CA0221.namprd03.prod.outlook.com (2603:10b6:408:f8::16)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:54:13 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::16) by BN9PR03CA0221.outlook.office365.com
 (2603:10b6:408:f8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 22:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/48] drm/amdgpu/vcn4.0: add set_pg_state callback
Date: Tue, 10 Dec 2024 17:53:16 -0500
Message-ID: <20241210225337.75394-28-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 77609d95-0bc1-4775-4851-08dd196d90dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lNZUUhPeRBLj97Y0v7libhoKknOE0/qzDQ4XjYBcknIH3mMfssy2rOEzAQPD?=
 =?us-ascii?Q?N1dJDPAXKZHyLeSjJ0NI1LdeMyBXyvtkhUaVfmagGI61xOr3tN9DyMG5jwyP?=
 =?us-ascii?Q?IWOBwomqcwzjDhES4x5sBAbZkiJCU0hy0KNRg+VoANzFgtM2nBx4WBXwZEjM?=
 =?us-ascii?Q?Bz3UBfhv0ThdKzYYjc4BBldeZt3wKszfGBQ3BpUyAHKmz60RrJRQFn9izy0S?=
 =?us-ascii?Q?eennRcTKOUeYPw7vZARrBMS5ywa9W/dhC12cEDT1LtiX/sSTz9z6fnsZro44?=
 =?us-ascii?Q?Z9SK3jqocNUpQN/upVR6une0JI3Lr/37kfS/0JtXf8KoEMRCUGcoKKKU8Xbv?=
 =?us-ascii?Q?5KrVMTTagndrkY4oCQpyMO+txAHA5hB41SbRINT8PEP+vhGnlZvhNPN+bsk1?=
 =?us-ascii?Q?To6mn4hgYyGFb6Ff1K79Fdm1qy+sOyB/MkhqBPZtYdLVbeug0P3mIS7ziE44?=
 =?us-ascii?Q?iJK406zWqy1g7OGoudhjKJTN+/VY7vwmLJkERcwSqzc9jfZqLEpuxe0YnHYx?=
 =?us-ascii?Q?bvB9/FeD8eP45rgE153idtIS9VKmzKrki3N4MSqj28IxIqDKVX6PzAjH+bnL?=
 =?us-ascii?Q?iyu9GYcuxADbC9DrW/FSV1MbIwtdt6TxPh9MztHwhAkVXnB8plQz0mfca4Ea?=
 =?us-ascii?Q?qVOLtlfHrmDCKa9oCavqMMB0h8YhWf0VaEPSfby0anSzMjkLfEJ9vSMVNd/Q?=
 =?us-ascii?Q?1auyCkqoRJ+0pHHbdOu29g3HTL+x36RjrWqTg1ip9UDFxVg31HizmCthQHhJ?=
 =?us-ascii?Q?dQxIuLTkG3oB6YzC6BSSIvVnCCr3BkM7Y58EiRF51X9YEVLSsaKshg8hdAzb?=
 =?us-ascii?Q?S+YhMXWrGF9OVmhYTMXVJaf5ilxltGro9y4AJWEPqnGrbHVKNvJwlXxbplix?=
 =?us-ascii?Q?8ggPGWLCPK1z+Ylz1ZkqCG77f568SQaqKi98fEjXPxjTci7Zej9k0Be8Wwfv?=
 =?us-ascii?Q?k0i7J7jLlCLWkaB/WtfsOMhcFF6Dc6Stmpn4a8VpLHcfJTA3SmkWnw6filPA?=
 =?us-ascii?Q?NxpN6ctppZx2ZN1D9f5S+8s8Enb7MbrIPP2lwcHeBuloaXDotFopdscY7VEY?=
 =?us-ascii?Q?F5uXATiYPyTmotNCqUZWKXkj7QyX+WyCRz5yAtzq5UsljTcC4oUX2xqhEtBv?=
 =?us-ascii?Q?QKqtLIAgSINCsai6Oo0oBAbdldLyrpSxvjiZXz/uHEUlF3s713F/Jr2w1kxf?=
 =?us-ascii?Q?Gfayp6ZbR5EiArtg2sjBU7OYK5gedAqxL2z/699+glMRtzQUHj/0p/RE18cK?=
 =?us-ascii?Q?iwUP4hxfZcW9BnziCDVqHXHnyIwW0pIAOYFttXtCV7B4uyoN8JddmApEdAI2?=
 =?us-ascii?Q?cSXK+smAWj2NbESsHOqaS0xtM8mrGL4w/poHGNbYkP+qdCvDyVcHCX1pjM9u?=
 =?us-ascii?Q?8MPJ63ljsppsGrMilTBHSNVbQ0GvIuicNQ9V7RNGpqRmqrOz+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:12.7935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77609d95-0bc1-4775-4851-08dd196d90dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 38 +++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 2ad217470c8c6..790b533605849 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -96,9 +96,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i);
+static int vcn_v4_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -138,6 +137,8 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_set_ras_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v4_0_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -379,20 +380,22 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
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
-				(adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			    (vinst->cur_state != AMD_PG_STATE_GATE &&
 				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+				vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 			}
 		}
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
-			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
+			amdgpu_irq_put(adev, &vinst->ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -2077,12 +2080,10 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i)
+static int vcn_v4_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+	struct amdgpu_device *adev = vinst->adev;
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2090,11 +2091,11 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
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
@@ -2103,7 +2104,7 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -2122,8 +2123,11 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		ret |= vcn_v4_0_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.47.1

