Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1051E7718A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D5A10E9EB;
	Tue, 10 Dec 2024 22:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eORXmSD6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E9D10E9E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbEV/5vOsfy4agGT8Eyx9SUCxJa9Vn1OSmYtKpnUvYQaVksYRk8UC8IvsrILzuv1irbj/ycO61XEl6edCJeF3/2QEnBYChQ2VdAG/ThH+uNDgDGm8MB684jEmDZWW/e7TdRONqRgStphE+aZiQsMuXrYClYriNqsEnp9SlQPFR11X58XBu3hmhOCl7D04+aiW3aSfa6//TfJiEFpARAYLM8MAFN//VowzXgbma34ztIpZO7YGa8cNJiS8GxGgL/VReienA9gTCpOB94Sy2fzexv0Ry9V6v1C1ZYqNx7MA2KvFKt2CcbJkQwV8TIylbREi1bVqpKKyOXm6FDQ2Th1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clGCuQSgWw3IUkv1HNrRcWuU0ZhYPSNnDV+GOarkh48=;
 b=V55qkNJxSWdU1vWEfoEfvnMQrHCtDmWcONqKxf87TzXbM4fmFa7soP5TDKMEzGluUdyxdIgdz5Omt9z4lCk3qdLDMt6z0YPTNd1LgQzKmPcC1I6oJt3E5KhOg76UnDAci4NL7gzhLqhqFzG+I/3vKktHcXhRqdhpvQ1x+eNVLAYRZnJhOXJV+OnTaY2iO9RJGIPFqJrWfggpUttrwQEAE5rQO2h0+z9S4VtjoKQxoOaHqpZ9riXtnMXb3c5CklPT9liaWMlTRDa1YEk2ugCcSAykNAz1PqQjQo5N1TziaovPYMQ/Mk+5OejZ8OpOjieo+0V9Q0O+TqdkeDK4u+yUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clGCuQSgWw3IUkv1HNrRcWuU0ZhYPSNnDV+GOarkh48=;
 b=eORXmSD6v7x/+UqOryzPJB7cqq+yTd+bVYicVXznxtSaohwMHGXWaWotQNpHOHQrnVD20J+E0r8bdchNYJDGBUpsYo78Kzv13C6u5Qqp3Zhzyri055qOQIJPkY7arhzxWkDDSoAz/jHWfTAYiCUjSLO0TouColTwKnfTuH6FtVU=
Received: from MN2PR01CA0007.prod.exchangelabs.com (2603:10b6:208:10c::20) by
 CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 22:54:13 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::f1) by MN2PR01CA0007.outlook.office365.com
 (2603:10b6:208:10c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.21 via Frontend Transport; Tue,
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
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/48] drm/amdgpu/vcn4.0.5: add set_pg_state callback
Date: Tue, 10 Dec 2024 17:53:18 -0500
Message-ID: <20241210225337.75394-30-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 27651f25-5c72-4324-c463-08dd196d9120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WghSFCfUwRVkb11yW8PjTNKqRcxTK3y7+j208hODrTrRhtV5yFYO/h5mIpTq?=
 =?us-ascii?Q?9UMrzCt10nOo+COEAdyMI51KUVkPnG0HdkEQLPsZ6SXkxzXwETFqvBn0P+Iw?=
 =?us-ascii?Q?XAXshKmaiaa1qjdnMzLUUK7cZIWA31VEDn7NvJkBbhCqrKlSNwmjOslr2/kw?=
 =?us-ascii?Q?n+TQWwaX83/8kKkwT9/WOtmE3vLT/bKD6hoJUHFc67JjzN8pZN6RyrDDM7FE?=
 =?us-ascii?Q?a2as5RaZcBRjFCMJjHzXfWOSfKEKwZaQ7FcCFfV+anL55MfW10aFpLPRy7QF?=
 =?us-ascii?Q?O0CvSfBMh6wRUs12JK5Vh67nQqYUqLLw2NqqbPVPH9EyqCn7RPPk4a59TAYE?=
 =?us-ascii?Q?HGRSF/92idNvjdRTPjsg3Miqt0AluWxUCCacIPbg7lO2/wymHEPB9vM4qj8R?=
 =?us-ascii?Q?tN2y7fBt2ivfxI+ARzsfuyDjC6UBqFlhWRK3YZvqqvjFLWeSpdHgz9MDX8k1?=
 =?us-ascii?Q?BTPoU76cWstSSQ1elzZl9UbU5rNxB1FK/Tt8lOPRsmfob7KGzSlzQPnxCB5g?=
 =?us-ascii?Q?UrfuS7entKwC/b8sJ3hmx0NDCFI77+eOgcEo5CDIqsZ5hIFsEk/HzZwQiM6q?=
 =?us-ascii?Q?rqdDzngq6/ySN6xQtdihomj5G97FKvklE59s0NSQ5gPiRGfGi3epCcPhhCM5?=
 =?us-ascii?Q?eSV8ZsoYAI83NMq1rNMxOrtAlPeg7/zgczL0SVTT+FvFjUm8T8Spnia9xqBW?=
 =?us-ascii?Q?jsd0vMbPNk04x84SM13r8ciECIW1y7qmR4VnIt9Z9tPLxK/H51NLhpra/rLH?=
 =?us-ascii?Q?4g9Ze/g2eay/BCte25wNDLsCKdL3o4Nockw+hS5LSWAyd8jfBXrwUcpv3cBJ?=
 =?us-ascii?Q?X1ptqEJJ90KJLaggt4Owl3l+dRjEBNo3AxJFut+LIK0fqWRpRoPi2hZeQ0ZH?=
 =?us-ascii?Q?JwGK1kV/v+Q8v4v+38l83Qgs7gsgMCV/kAtYhuA8UL4BHU84jwxerGrGlvuw?=
 =?us-ascii?Q?30ow79atJNO4ApxxfNjAsahMAtcwJzVyC2FnP7GTotoHtd8eupgqdHFKpU3H?=
 =?us-ascii?Q?E6C+9SgSEYbzUwB6G1OaREOxwwa4GLKoJARp+zDigUZ7/Nr7qVdqUVnslTf6?=
 =?us-ascii?Q?s7goJE4VKhuonX6cTL4xDCmlQi64UjMjCF2wm/POEkwU75sS/lji6WfrhsJb?=
 =?us-ascii?Q?8bAMbrY3T6z8FuvW6W21P/61MULnpCfkgSkO4r67qyjmcm+KdFwiUbDIIQxW?=
 =?us-ascii?Q?amGldSOg8pigsQbecamnqP3XSI8MbvHQPzZCIwrlH98vRsmIJntVSDwffw7x?=
 =?us-ascii?Q?cEdVsOI8PKYQMSnH5Ud5QbYBNXRXXNjzA+zDa7Il4CkDEp2vlH6eSEgGElZy?=
 =?us-ascii?Q?2jzeq9mjJhxk24OBxnnpsqx3T1r0/unDu4jXbABR8A3a4fXsPxTwc7Bc1xr6?=
 =?us-ascii?Q?rJ36pHIZWHLWsrFjCfr4WQ8LYBThtvHBNZXEfLMtEsiGZXjxJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:13.2670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27651f25-5c72-4324-c463-08dd196d9120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 33 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a00c74d287a69..0ac41249755db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -95,9 +95,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i);
+static int vcn_v4_0_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -124,6 +123,8 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_5_set_irq_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v4_0_5_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -317,16 +318,18 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
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
-				vcn_v4_0_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+				vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 			}
 		}
 	}
@@ -1558,15 +1561,12 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-						 enum amd_powergating_state state,
-						 int i)
+static int vcn_v4_0_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1575,7 +1575,7 @@ static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		ret = vcn_v4_0_5_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1594,8 +1594,11 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		vcn_v4_0_5_set_powergating_state_inst(ip_block, state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.47.1

