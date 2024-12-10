Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B97E77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB3D10E9E5;
	Tue, 10 Dec 2024 22:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SI+BT6eT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F5F10E9E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFV2/+/SF+QQoUB/h0i74jVuZh7v+lVXzAr9no1SNflL5SAQ8iLTuNV0TJCa2tdJRs1vxSrgF0dx0l/qyomV4JbBu4qmm0KOnYTIHG3tyzSCY9JuepaVNdJE7RaXfLJgxhjkzI6pIJskEdlK/JoYyIYHUoMCI0oyACuCCiI1jVKkTLU2jF9b4bEOsB71nLeYBtz6O/xzSTvsuqZZXPnU73w2nQl5JDjg2xH7SLh+oloO4qrhlTkim/gnuW8OJocFQR5NjWZWkHLf74apgHSkc1PxV1GC7FP6gZwi4Zrl9J0PVtZNdiF4+aBwJWlhXGfXCTxBxtg0+Tj8xn2+tmcDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYB+8+3g24EL8wI8ZPwrMTwCRlm12f0y3PqF0Cy1sC8=;
 b=WT1tMClZBDKVG6B95PqZ7wCG6t0tncQmFHO/QgO1sx1MmPDC1clKHpUjRSKfd8TPJtuV6vFJ619H2UxNZXIGWm80PTvNPicFcs2GfFnSAVQYU0xSxXI2cgDefvf7iUR4aIdaoIZPZ1HU4gQhA8XsXsYZO0Bq7CX9jnQ1tMh91yh6QxMX7SWpuQqAHz6tJOs1iu2mN6Utq7Vx7iVpHPIY5VT/6mwWzgqbXWvRhdWwVK10AmJVAYSEdyV+474kPhKL4/2Acz1tqfDHaSp9ug5C8HnNtVy63W4Hz5TrOyQeDgH/TfNG2vCAFYbeuZiUmXw4JjQg7kYpDx/phhmj1QJYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYB+8+3g24EL8wI8ZPwrMTwCRlm12f0y3PqF0Cy1sC8=;
 b=SI+BT6eTPMZWoXmz2fTxguibugJLER2IUSWXTgBwM1FIul9tImc8Ccssa63pHJLAXuuO32HEN9MD4J0raVKvY65c37X4T7/G999UEanBGNGYTxTvxeX9kIiYQE8nENTYjp9iRaXNvPSvYPkBuX10Tlcjm83PoccSL5T0as8JUGQ=
Received: from BN9PR03CA0240.namprd03.prod.outlook.com (2603:10b6:408:f8::35)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 22:54:12 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::2b) by BN9PR03CA0240.outlook.office365.com
 (2603:10b6:408:f8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
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
 2024 16:54:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/48] drm/amdgpu/vcn2.5: add set_pg_state callback
Date: Tue, 10 Dec 2024 17:53:14 -0500
Message-ID: <20241210225337.75394-26-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 6891ecf8-353b-41b9-d475-08dd196d90a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pyAcJtqSAxxagS7eZm+TBGkIqE1spwzrQA7P3gXHzndkbH4LBDF6L+p2gBJA?=
 =?us-ascii?Q?UOMxTijrFEx3fYkTaamjZ2PTTV5w3OqG36qW1SAzGEkjNLZIBJMzUtuhxLA+?=
 =?us-ascii?Q?5kTZaNA/tfnSuxf6rC33MjrXLormU4HfiVYVKXuazT0tDxOfuo0YgZ1oRMyn?=
 =?us-ascii?Q?csx1iptMW9085AUNbbn6wOApaq3QoOSrsvebKe9rEcFP8mymONftcZB32Tky?=
 =?us-ascii?Q?aj6EQTgofxWKuyTZvdwrJqY17imyUmaR1CWiEC5XC/r5B8sHKZTuf3PUoJwI?=
 =?us-ascii?Q?Ld3UGzSYtWMPC5cnICMX2ifWKlgaVuC0F77o3GdQYlTiMUoHCc0CsSgF3YOo?=
 =?us-ascii?Q?4Yh2c10QUlMUwwCcHltacYyNxSb8DmeuynlwZyMLE/mtjAA2EBwBShF4pZ8J?=
 =?us-ascii?Q?E6+N9PrrVOlEuCATW7awEU732msFw03QYIW8SC1DanX0fJUMSoQHmc0bDNeD?=
 =?us-ascii?Q?i4nWjFRu7JeRp+K48K57A+e4z5NjJiedZYweVLokXRLFEMXTgu3KoMvekb3f?=
 =?us-ascii?Q?ug2Q8C5taYK6cd9/tYLu60DYV7WVQXFMXBlxOZeTQ47R9X96Fo9JPo/eylri?=
 =?us-ascii?Q?qgRwsF5hD3BhsDmzYjqtqj4k1FIe8t1xBeZYkVd1hNr0+dX4UfaohXQxQ7Zn?=
 =?us-ascii?Q?eiyyAZUGIE178MO9vXVX2/FULpthxk6BPMMaHKKsIj+AbzqV0D+8TYKO4633?=
 =?us-ascii?Q?tTMztNzdixEHtw4EOpwKD/9WEB0AUGbPRFuUBI/lcQ+o5U9C7Vb7uxhdi41w?=
 =?us-ascii?Q?9GpjuxACBls4096DVhqWN/1UErYUxhTdYlRUnT5bYqbFzttBYsl/OBIX/ilz?=
 =?us-ascii?Q?lnUbmWOX2qYLciOzQ4wCcB1H9bBimU4EmMb8FHYpTU6vlkl5jJSjlSNlrO/C?=
 =?us-ascii?Q?fGkjuZZqXB0r27XxyoImShcrU0zZ5cLSnJQezp2ctHygIhjJkMiiE4pTHhrB?=
 =?us-ascii?Q?pQYaOdyA3U7eMk8M23LuLWdmBxOTJRjM7QN5vfAvwb5t3l2pNk2+4sNOlHgK?=
 =?us-ascii?Q?AsTrQjysu29BVFom0lFGG/XZDffdnmMFIkLpU7t/W7id780OHAk18qISvrps?=
 =?us-ascii?Q?4ANpuH4xSBqbsSx1LULutKbHqhPu/Cz52yCG/aCPfjif19sc940AeXd+qiTU?=
 =?us-ascii?Q?DhO4CFD9hntSzFIh9KmDAl7XiDg+O/8kdwSO8ONmMPP0dHbCPvILCGp8QkJ2?=
 =?us-ascii?Q?/Mxy2xB6CVEyk0RM0auADd0DHWZ/iqpaLr/fiMmB+ERMkbF71MEjeVSKInqC?=
 =?us-ascii?Q?b9v0XEsbnI2qJLLnZtPsI2eZIskD5zhO7GRMHDvHwLbT4baH00aKGVgurRB9?=
 =?us-ascii?Q?93JkvJv0B7LhzEMRuQlC1b9sIg7uQAFi3Do5q0VJUd69XZ2D81mlEeIyHJq0?=
 =?us-ascii?Q?qhIr6C0rkaM7cVo+fXqOjyXtZ9RvDgUFnD+0J43rohNZd6vcHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:12.4966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6891ecf8-353b-41b9-d475-08dd196d90a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 37 +++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d5921a954948e..f5889d1bd0d4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -95,9 +95,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i);
+static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -150,6 +149,8 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_5_set_ras_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		adev->vcn.inst[i].set_pg_state = vcn_v2_5_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -400,18 +401,20 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		cancel_delayed_work_sync(&vinst->idle_work);
 
 		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+		    (vinst->cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v2_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
-			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
+			amdgpu_irq_put(adev, &vinst->ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -1844,18 +1847,16 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i)
+static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+	struct amdgpu_device *adev = vinst->adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1864,7 +1865,7 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v2_5_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1875,9 +1876,11 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		ret |= vcn_v2_5_set_powergating_state_inst(ip_block,
-							   state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.47.1

