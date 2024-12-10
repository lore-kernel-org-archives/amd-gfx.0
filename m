Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA8E7718F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4954D10E9FA;
	Tue, 10 Dec 2024 22:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IK91d6wr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7963C10E9EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqphaDQsoQCcUZIaRLGfX/VSqGvbmYIucx48UYDRYmdW4CwaSCGAFUoxLsdGYxbE2XQio+iFIWGsd27ZSIFDWemE0FB2CJ7ePyNqkAXYXHnywThJgi11BLt7TSppGD0BwcttCFQagOtBAmq0MY0HedR6wMufx1Yx6i5EbadoIiitaG+WRjwEb+uDqPkOsbBBVC+R3AZDPZB/BnY5N1UJ/n5Nvmw6gC5uKYfkvCAfV3HuD82gXNWbkeipbP9BXvSpUgtofAXlEMyNP3PxtOd8355hFS6Ji/hKHbVnFOQ8+fhR9kh1A0JFnY5uIeFhawuVc4t/+4SYZuha5BYXL3v4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPq1nkYrtewZpKtNtsGLgp9zVc+6NzNNvmONQX/Ikqs=;
 b=L5ywvGLZTpb+hPCHVJmsw4OajoBYRmCs/SPtcswwplYPwjVrTr2Abd+EW1oIHMHabHeZ41nS1NC+54ItNHWbKHOa/CQDL3L7jhPnP2zBLY8G1AWHIRJCAoqYirHRF3OTiAIb7ll+/Jm9fNktMGIjSCavX6tqNHVMAvO7KQH0YHJgxR2IWrar2f27FBG6r9CIAwRvyIP0S+ybjS1bTe1wa3hqWsJwt2YzYdSJxFMAqY5/07FBd/vrjtQFl89+QCgEEZ6tEGA83weNMXT8Fn9OBc9kFPghPwkk4xr5fSc+E39K5Uw4h0KtHzRE10N2MH3X0ID2wZxSZG+0aqs0GFVBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPq1nkYrtewZpKtNtsGLgp9zVc+6NzNNvmONQX/Ikqs=;
 b=IK91d6wro7XJPrqZD58AtuJ0pzu7IhyTP8hOJAR1ff9v6PjwgcHyPQdur8rAW6UjJ40uzBuuvipybyEJgAx1q6PaZKpnyG3FZhA3KBRDfZp7H9Yf4oy6tjMUWWk+iRYHGrblxkl0u+01O9FNxsWBaJFZfgUquW15NAvN11QBQTY=
Received: from MN2PR01CA0036.prod.exchangelabs.com (2603:10b6:208:10c::49) by
 DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 22:54:14 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::be) by MN2PR01CA0036.outlook.office365.com
 (2603:10b6:208:10c::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 22:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/48] drm/amdgpu/vcn5.0.1: add set_pg_state callback
Date: Tue, 10 Dec 2024 17:53:20 -0500
Message-ID: <20241210225337.75394-32-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e8d528-7962-42b8-368b-08dd196d9174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pn39YwUUI0K38/2aF70nQWeiFfbe9Onhc8zBRVV1EWj/xrrE+ildiDgjcbEm?=
 =?us-ascii?Q?DNgV6iMQNNiIQAeL6tFC4E0pTCb78iHYJi6FX8XiMXWRwEAAcSlv9O8qxV+1?=
 =?us-ascii?Q?05CLH/dUtMZ72E9ys6affOod2mTHuJfot0yJx8pNWILq6iUF/8znuAtP6tkx?=
 =?us-ascii?Q?/6gLVER0fCIDx4MV+MWWQ03X7eeyB1EwlAiRzU/khnU0c/7d3aOi/4bMUtv1?=
 =?us-ascii?Q?4vZB1J0BX4vcz1Gb7NNRqz26rgcqnO2Nsvtpap9NacTQqjaa04KGudrrBxXX?=
 =?us-ascii?Q?cYIVKqU4OvdZ9kmOzS38zxQ0pW+7o7BcXHVftQAJEUPorF7CiGKlmUDBRDI2?=
 =?us-ascii?Q?4GMZn65zY9qL3UL9ZjirOzWdS66xrUfxY09jygcBSeeI6EeKIztEu9Yl7fHs?=
 =?us-ascii?Q?66J10A80gR6NN4VUbqgCIDf/cE6LlISFOcYDcXyTjZUuz4Bv6enfkCV7en4U?=
 =?us-ascii?Q?IF73kbmjkT+bNgRGpXGt3AVt1n0W59QMl7wsPIiqcf0Cnmt0UVptbip+WOz9?=
 =?us-ascii?Q?BL0y6u0cTTn204LiVilfZG7XJB0KdIv0ArdtyBbHp4QUvHHx1EOiOjWbYJMS?=
 =?us-ascii?Q?E/aSDDLaqLKOE+BwIsCFNr4ngc+Qfe1gc9F9CaZdWeEwwThx8mZZWKslcayc?=
 =?us-ascii?Q?Fz2rjIaz+Dteti9oDZRdyu4zmOijeva9rDul/kv9LKX2U3Ei673ltq/CBpA0?=
 =?us-ascii?Q?UtsXQJPBy2qAbch89EWoBErE/I5Bz8EGBmCsuNRwobxLYdwtZJA5vn7maTPS?=
 =?us-ascii?Q?Bhk5WyVmVpAKHlwPn92hExCySm6R+NI1g72jP83fNEkUMZB04H4AnuY2agB8?=
 =?us-ascii?Q?V5JuULIBd1g5/KAoHgADziwMSGFOEnMta2KxS74mOstDvKNW8dJofX5uN0H4?=
 =?us-ascii?Q?HAtuE8geNhHP7toEFGRSteH+10ilR3KLvwaAucDU6j/vTQam/1xsNETVIRCX?=
 =?us-ascii?Q?e5Do+LswHXTzk1F5VuhaYvtJHA3z1hzUWgYyp77K8SiUrjNrFgPSI3TxmOSn?=
 =?us-ascii?Q?Vy7qpZximFjcj/QMzKZy1fL0rKVKCysfE62F2B8aNmR+0QFjsRWHI26vRoxx?=
 =?us-ascii?Q?XzbBiqQPtHjL1kXIni50dgBP7PYdmEb4R9kbhsd4RUb2/mGUsOzVfSXR3W2c?=
 =?us-ascii?Q?ejE1ADhOZyzuskZK2BIuADEWcQqmoQpoLWIsYcbxr6hHZ+8+TaNWWOJoy8jA?=
 =?us-ascii?Q?hsPvTM9NCB4tCLEVG1NFN9siGBxOATr6UoNul12tnyjNUfUWtbLwEF5+Re5l?=
 =?us-ascii?Q?0jDo5552smWmMk1xnOfHC/UQKzA8iPtj85y6pVzUkAKtZBSSeSpa164omV44?=
 =?us-ascii?Q?BT/66BFzaggA5At/l6TvejZvFRU8LO/uaabWJp5StnHgRNb4eWuY1VSn0qla?=
 =?us-ascii?Q?TBq+0MixrWn0L+Jz3PARHZ5mHTtxuUvYaPrR1c2xxxpI7UKC4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:13.8139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e8d528-7962-42b8-368b-08dd196d9174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 6ac6049cb9f68..586cdef6f663e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -40,9 +40,8 @@
 
 static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i);
+static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
 static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
 static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -68,6 +67,8 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v5_0_1_set_irq_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v5_0_1_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -1031,15 +1032,12 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i)
+static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1048,7 +1046,7 @@ static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		ret = vcn_v5_0_1_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1067,8 +1065,11 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		vcn_v5_0_1_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.47.1

