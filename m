Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833EE77187
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CE910E9F3;
	Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q702muki";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F74A10E9ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDaBM5kIra7oazeUrfb1oz5u/HWT+BTqTWX8GCPc0v1gBJN6WzoAJXK/V8N3psqBtHzDqre9l27tdxSrJcvsHwK363QUxAc+T2/qL7uAm5q0b+BERMnVHY9GzxXuxOt7IRe1CnNhwmV4N/OMHK2C6cNVUQUWUyoVXl2zZBhNYniv8Fo1ObXDQgKEJV0DUyZhcgHS6y+CW1nCgVIfbpNqmG0EO4WYXDukvn/5VXmUcoY30rZSXEB5UGsJO2i6Bt8rzycxawfd5btc1STQuHW5dBUVE++JzeVIZwMFyhtz6TyCVlVgZ98x2IHg8LbIshy8GkCS7zxgmSCKsFj88w9aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3daZKsVKsKSDbByvMSe6oOcjEq643kcBPsmlnxGVqo=;
 b=XBOPsCmnSfSdV+hm052IqQ1VaIsIACZl7vEQ6LGohP+k0UpVAU/pIHwMazdpI7FPi5GXJJ7vsgKCutVdH4RrP3OlvEXH8f2osMC+D8al1jVRtDedayTH6QSlcbLvCJRRGAPL3OdtlnWqBtf4QgB/q7fJUKcRVr3DQcCpRNUaHwCp6H3bEMMMPZFJBghb4UBdafvopZrvHD30X0w5qeyL5YS8YB5sVrgYOVk62JTKOF8gCnWBNhNedW60BXuxcMGZscESqnXaBZITkggIHlhsEtlUs1skmUCVNVrikY/nfO6OKM6MSGSjetyHFmQUpghkxBWpyYJ+WrBnykNWQVmF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3daZKsVKsKSDbByvMSe6oOcjEq643kcBPsmlnxGVqo=;
 b=Q702mukiAt/8hobKast0a/3hRfffDWF3Dn1v/2hwvAJIMaHg1HKVVN3aw+kI2PRx8VenXcJVDKRQMSddIOHO3DCLEXrOlmHVLc3oXL9WCLEAzCjbHuwYjtcVTe4+ITy96AHiVXj73dCvF2zCw+gaqZtwhCkPHjWm+jdeVt82INk=
Received: from MN2PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:c0::30)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 22:54:13 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:c0:cafe::b3) by MN2PR05CA0017.outlook.office365.com
 (2603:10b6:208:c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.13 via Frontend Transport; Tue,
 10 Dec 2024 22:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/48] drm/amdgpu/vcn5.0.0: add set_pg_state callback
Date: Tue, 10 Dec 2024 17:53:19 -0500
Message-ID: <20241210225337.75394-31-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: d70bb4b2-755b-4c90-bba7-08dd196d914c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hWjnyOQ6wo3xBHq+zBvc4iZ67Ahst4BiGfdv5Lz2nZ7oKE0DOunDdCUYtadR?=
 =?us-ascii?Q?a1VdbAu8z1vG8eTdQLDGHcwcJkZIXudRQukykCq3frMJ18rmrSNK4ycnSAJ+?=
 =?us-ascii?Q?WSt/Z/DRblW+FJhTE2IQcTQLOnl/tIio7stWlKfnjqsHXKu78J+KRCftbua6?=
 =?us-ascii?Q?6z3YRpwZi7qIhofDW1kFrHP7dGvW9eV98hhLplNBXWvkbKgO0N8EPH/mg8Am?=
 =?us-ascii?Q?i9ezIZkkBl1Dv6mY9urJZu6obVCfK+9bSZjV8bhxZpEdMiIo0NRLJ7QyaGrs?=
 =?us-ascii?Q?fNPpe+SLIZXe/w6xBe0IHI1MKG/sHnZ2e26zxV/QKHqcUAbaiGoKb+emDQ0/?=
 =?us-ascii?Q?5Ag9k+G8vuZOhSDyfP9IWbe1rXjtJGwxntwdO3dU8Z/XpnnqPkLh88c+d2hT?=
 =?us-ascii?Q?rVVclFhOWBFqrYwJVO2dyIvz4B+Gjx+qpSXq/lEsMNMCICd6PBecNKRKvmI6?=
 =?us-ascii?Q?bzBFmB1ppBqC6GFXsx8GN4geXBnxCJJkMlR9pv83g7yU/UgkQ5bmaOYABwen?=
 =?us-ascii?Q?WehESQ8KKdZiF3lt41Rov3G4YP1/dkV1Vh9imMdA6H9OlFobJ/xA0Tolm5G0?=
 =?us-ascii?Q?DNLIMIkHT6E+g0QALdzJ7CO5qsrS7DejRk3S1HE/HAsZqDWo6C81WKm9g7ug?=
 =?us-ascii?Q?Lik41BmRk5xuyrjUbnRMxmn/ubIHqkUJ4hexiW5fYWxHMb0AWNeOn7m95FDS?=
 =?us-ascii?Q?cmPP5utxCS4ADjXAyDghVV96EVRMAHS+UKlskNTyYF5Yn+MbR2x0gUSPyC/f?=
 =?us-ascii?Q?QdHqu9pR7/x/upSQ8PBjQmJ5DnGhHFB9YQLiikBOLYG7r1MQprAy9FtB7+3V?=
 =?us-ascii?Q?rbVT2vT++ECsLWt1GDJXcRoQWESjtEfHTKf1+VTrC7lX95mIyMb6SzqCWJec?=
 =?us-ascii?Q?ZlMb9BNodOdxI3eiefAO+FX10uy6prh9IW3NlOMx0oDHFOR47nIoRUqurvMd?=
 =?us-ascii?Q?AunZF1FK8xla5OBX5XbM8iC5swd/Q7/aRqHt72CtyzIVf4HBqUA4xCK/ApJA?=
 =?us-ascii?Q?KsAdc4C2jl1s4YpppUJ8GekOnXD5nHinmBCibiiFdlf4F6vmLzqzbY8yAtaj?=
 =?us-ascii?Q?ncB7gnUHFDPHG1sR8fPzykY5ot41m24XjmuvmNeeJ7oo6M35ezvpS53kVkdV?=
 =?us-ascii?Q?jnMwwm3CHFQ7O+AklmV/PTZgHxrrfZ5FZumOH5XkXiBK2Kxbq+RRB+fKMevm?=
 =?us-ascii?Q?UVWsiwPTTZDwUal5B4JfZx/xjnhBa23ZYrwaCW90Q9mb7JATA/0hfbUeHcps?=
 =?us-ascii?Q?LVXwCrPhqemT4qscFJoUvFDRM69wa7+mofyuTsbAt/xmO7TnD5siFBNUf8T5?=
 =?us-ascii?Q?FH0EzgJfkJ18Z84PchbLW5mMsxScRUtcICLwbjQ7jSAsZ2MHw82vjI6CgJAu?=
 =?us-ascii?Q?xkupBi0jS25wMDbZ9K3R94apeUvHyJXdxCq0WB/yTJSgqvwuaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:13.5551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d70bb4b2-755b-4c90-bba7-08dd196d914c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 33 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 91b57b86dc58a..9588153079675 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -78,9 +78,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i);
+static int vcn_v5_0_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -108,6 +107,8 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v5_0_0_set_irq_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v5_0_0_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -299,16 +300,18 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
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
 			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+				vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -1297,15 +1300,12 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i)
+static int vcn_v5_0_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1314,7 +1314,7 @@ static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		ret = vcn_v5_0_0_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1333,8 +1333,11 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		vcn_v5_0_0_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.47.1

