Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC2E77185
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796C110E9EF;
	Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pl40xOwD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE61510E9E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DB34KDujDYIp9z+zYBzrCHgQqIJVzFGSRiFdVcTLNuXClZOjxy2j64Yf00b8nhRiLoFpHae/ee7ePHjX7t6BdLQTK4gzvAcuuoKnRAUmo1aZFEkiAx0QPoztsAMXB/VCGBvbx/TT4kmynYzCmFgol9dylFCPGP9PoHhLfq63yHhjH7WbjH1WQv/qVeY4EV54tdeVCEgVnVsdh71yZqTr957zJOBGtc+rMw/TVZ+3Ocy4GIDNi1lz/bR2RRu/XZkpiT8CgCSfuMottQdfK/NVgoFNdl8ScomSu77x2R4LXIM5KBKw5Gtr+dd5xAvoPmnNJasbm4W4LcPsbSKzuCZbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHIVwHrt7gqqyllEx4uqejkjXTwJbVkUBKI77KFlr6Q=;
 b=YAeS8mWrGrBIbOUmGo/Qv+JJIOswvTvtc+qOJBhFRO1JPj/HBCdUSqIjxPFQ2sJhzn6BRw1RsWFs/ve+27xdrxcMyy4EKjolFrVdpqln85YSNMgOEx0aVkr1WI9U+4sH2ncqJXCFO+pc0TVBjSageGRdZ/0H+vb4Khr4EPGqvcT1+PgG9KsZU+rOklLOjey6MYoO7Tar+lQRrzj/UI7jhW7bDQSHGb7Y3eIyCz5GoKu4OZQhSH4i6jrSX4ir/DSpJX5RnUSqxSApXVFtKthqHfgRvzB+8FY1WiEEB4hZ/4qDLMOezoSqh+kl8Ms4+UlXjYtc8Qfw1VT09egr1Rkkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHIVwHrt7gqqyllEx4uqejkjXTwJbVkUBKI77KFlr6Q=;
 b=pl40xOwDgCBpQ3lV1TarRDLyMRUgcDGadMHu86WlujX2J9Y/IYMq2LE+6/7JOgUmE0rza4vcsrxn1mjdeFwPXvlgCZYQJYf6UbSXiRLlmokcFjzeB8/g8rQuHgE+tFHJEcpVOlyXKwt4yBXgVmp/aeyYRzigPn6nL0xPtjOYv3g=
Received: from MN2PR01CA0015.prod.exchangelabs.com (2603:10b6:208:10c::28) by
 SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Tue, 10 Dec 2024 22:54:12 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::45) by MN2PR01CA0015.outlook.office365.com
 (2603:10b6:208:10c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Tue,
 10 Dec 2024 22:54:08 +0000
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
 2024 16:54:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/48] drm/amdgpu/vcn2.0: add set_pg_state callback
Date: Tue, 10 Dec 2024 17:53:13 -0500
Message-ID: <20241210225337.75394-25-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ef9ff9-b4ac-45c5-a4c4-08dd196d907e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hCWUXO6FYcG+ErNHy4VQjPoKBSJqcZPDvXQXBKmik0Oz9PCXoAUIvKgr+h2N?=
 =?us-ascii?Q?gg0NIku0x9skWvYHQnjDX1pPTZzTnNALjMcbhJ9CqPt3zG+0SLMI6dspAPGI?=
 =?us-ascii?Q?nZi9sWaWWgr2Dm8VahvbFxAXb/JVTQR40cgrJZUkbFQnvr8VHgNVr3/pYzF3?=
 =?us-ascii?Q?a8aaG7ILSSD62VlsU7evhebhFoxP76MiN98ARGOOGyOLAX+OBhZlLRAVC2fx?=
 =?us-ascii?Q?jFr1eNQteiM7LUkt3SG22oAdl075wVzf2hVDK4FuDFk6xIvuUk8+3xFnboOd?=
 =?us-ascii?Q?TQnepVf6mAfTzT0PVGiun6zZww9bEBlcstz9Omgby8ieBl34/X9vqYmpsBiu?=
 =?us-ascii?Q?V7mqM12qgJ6lKF5vNGB8kPIJ+qHuZls5WDqyQUG5tV2nDmlvSo+rKz6rWJSY?=
 =?us-ascii?Q?10ym7NYfuYdFBZKGYU7DTbOdSpqRjJeb/CaWe7Oq2g1Hknec7mUDI5SbgsjC?=
 =?us-ascii?Q?swCt1hJEXxjMErPbe5kqbybTEvzBB26kWQNTcmOAijfXg1DIxuWrAOB6Vvhw?=
 =?us-ascii?Q?5jd6ENEDwBGwO6pGwMqNqoG0QdeI9SCaMWT0wLyw5kSvdgs9isgosvLIGQpp?=
 =?us-ascii?Q?O/Om4qqkGhOE688Q0Z2GCIXvubOSWkOtvcjID6YHCRLI1NxZ2LUpg2nNRJ1U?=
 =?us-ascii?Q?tlD7f6NioRdw0REd6TA2gGU54rbkAn9SkdtyCJ88lfgQJGQzJCaQP5JR2JFW?=
 =?us-ascii?Q?WiPkmSGprJ/+oQ7yXWdOPLG+X1XdrYHti7eP1aSk52DHUYY3WEBk6vQGm58L?=
 =?us-ascii?Q?wBGizLxaq3X1zn4728jPWNneE4A6B9FF3T2PNKwHaNcAcCzQCVdzzUNotTN7?=
 =?us-ascii?Q?ex1jvkXjKLp1qPxuwPigqyVgBJ8kJow2lmSLtps1Vqf1w6nBMAer3yAwvztY?=
 =?us-ascii?Q?VXRiM1gmLziM4oD999UaSDKfbNgbqXNTmkzMU5l0R162N7ZykSWxOfpdOG9+?=
 =?us-ascii?Q?AVnCwW6nt3euqk6sqIU4pf39g+dq9sd/dsyoFJ5PkwNTju+EG2Nzhpjexl65?=
 =?us-ascii?Q?aJ1MLJ9Z9sPewYGc6HZI/iIyfco5VX22W4ymARaOOC2GlVDV8aPgPeE0yied?=
 =?us-ascii?Q?IhK+z+Ffi7AFuT4ama/PcWR9meNpymWXixBoSYR6PHmcyk6z0cKLRUc8xbi/?=
 =?us-ascii?Q?04ms6CiI+MRqvAsYbQmqRUr5FL6JInRPdsHrkShIN02wq3AOka+2wqdx4M2d?=
 =?us-ascii?Q?LSfDMaAeDCKjt9zjQDrI1sWLwOHvevi1DTU4sAetQSsE8JkcuoG/dg6pcPbs?=
 =?us-ascii?Q?92w4pTyN7nqqWWbIsxdpJPpYso96JInr25yZhiaztGvhLelHTbg4TWpP7iuQ?=
 =?us-ascii?Q?M59Mp7h42l5V3wGgkzCTeBNRbDFu4Kc9C92k6Y+tuA9gtcLWaXr/w5NjcPeC?=
 =?us-ascii?Q?/582tRm53qaHQS+Kc2eyBNaPtTjOj0cTYwBCI4OoUaBKOnWioQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:12.2045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ef9ff9-b4ac-45c5-a4c4-08dd196d907e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 35 ++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 3207909c0d55d..93e2cc41e19c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -92,6 +92,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_0[] = {
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -114,6 +116,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 	else
 		adev->vcn.inst->num_enc_rings = 2;
 
+	adev->vcn.inst->set_pg_state = vcn_v2_0_set_pg_state;
 	vcn_v2_0_set_dec_ring_funcs(adev);
 	vcn_v2_0_set_enc_ring_funcs(adev);
 	vcn_v2_0_set_irq_funcs(adev);
@@ -312,13 +315,14 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
+	cancel_delayed_work_sync(&vinst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
+	    (vinst->cur_state != AMD_PG_STATE_GATE &&
 	     RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
-		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+		vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 
 	return 0;
 }
@@ -1810,8 +1814,8 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 }
 
 
-static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
 	/* This doesn't actually powergate the VCN block.
 	 * That's done in the dpm code via the SMC.  This
@@ -1821,27 +1825,36 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * the smc and the hw blocks
 	 */
 	int ret;
-	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_device *adev = vinst->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.inst->cur_state = AMD_PG_STATE_UNGATE;
+		vinst->cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.inst->cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_0_stop(adev->vcn.inst);
+		ret = vcn_v2_0_stop(vinst);
 	else
-		ret = vcn_v2_0_start(adev->vcn.inst);
+		ret = vcn_v2_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst->cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
 
+static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
+
+	return vinst->set_pg_state(vinst, state);
+}
+
 static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
 				struct amdgpu_mm_table *table)
 {
-- 
2.47.1

