Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34BFC8303F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 04:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AEA210E6F3;
	Wed, 27 Aug 2025 04:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bharmev7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4CF10E6F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 04:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8W6hPg5+59rMACvbdB2blpRv9RI3rNYnmVo9WqONkc1y3clcw3YVysfp9HaDvKoOWoPoWuBlG/nGAfqK9intEezZU2hcfv5cwF4pFWDCoEY8cmzWDswXwytaJWoguFFnnh/KrJjlCkutMZFpjcSchvimjREcn5cugoL5JouwVedttbVchZDjJ4j7tqeztVFE1bv4FhpVGrgd+hlt23XV0ByLE+uamwPYA3uQ22Db4b7mrhJHHpCNRhQ64fTgYg4H7VPDgxcPqrUIkkGRdmL28mTUX4FNcNzP1u7l1mUrHuw02BJOTRuH+mjrRnbzHIQ72UoeBTTKom0/lb0zamHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GLdOxM/mUASA78EeoUB4BnGqcvksqpd4rtuM+iryrI=;
 b=EpGk/ti3LieWofZ4q+c1Rq8pHCi3d+frIWo562F0eRXfcRzfrekvoPAuze8VI5prP0e5+l5v1NR+3qNtdCunbC1RwfT6Z7Z+W/vCa2G7sB0Sgd3rQs6Iq/KqdMdPyDrVE1a6znbvFC1dpazndoqdWn1/Jb+zcE8CUxFnd4X67rsdpx2spEJkj7unWx5Tt9H0pcGKyE68BuTjHC5zaPACC9j+IWUbYxxESuY2lYb4JVDtB6ddY0LuVjqGilHULbCSeVAWZizTV+G9uUOrGcX2K6gaQqaw/kMt6W9ICeQ3t/nBGIGwZZmgZkqdY+ctAk5cGnnV2w0VVCSNPUmWFhcoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GLdOxM/mUASA78EeoUB4BnGqcvksqpd4rtuM+iryrI=;
 b=Bharmev7oGF3NPOdzfzr8Gb1AhA871NWNpFqEfbb8kEtdZICokrWmsVmqGI4BfXaOB37cWwtcQUpjHzA8sClVw31u6vn7eRqEoXAkkOaoRtVb7tDuBF1rwT6eJE82iVSi1sI9pHvu6O+3JBXnoy129792QrRTavRe5qAN6u3Sag=
Received: from CH0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:610:74::12)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 04:34:52 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::64) by CH0PR04CA0067.outlook.office365.com
 (2603:10b6:610:74::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 04:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 04:34:52 +0000
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Aug 2025 23:34:49 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>
CC: <haijun.chang@amd.com>, <ZhenGuo.Yin@amd.com>, Yifan Zha
 <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Disable gfx IB preemption with gang submit
Date: Wed, 27 Aug 2025 12:34:24 +0800
Message-ID: <20250827043425.1944682-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d0126e-b79b-4520-b57f-08dde5231095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ow+3GepbM1hCNO3ImbbVPRJy6H5/RlJ25stBF3l3bwGb6DWBRUCX1q0bOLY?=
 =?us-ascii?Q?3pnmgy/5CsofVzgWBtSIXSz8eFLClnuo14a8rL2xQk/ArnAxA/4/jo9M7ivv?=
 =?us-ascii?Q?N7b6uNOeUsjOuSLAU6UoGcrIgLn5wwWkKZFt9s8n7kZkV0oTWFxQaVEap4Jr?=
 =?us-ascii?Q?Pg1+FwgnfZ17L/IZwjC2jvXmcBaReWO2Bwjpd6QTh45y6Lac0mkZl8iQvxxz?=
 =?us-ascii?Q?L86MaJlUsPnAdpB+USWmgwEdmU1ko6UjAk0iQ/2NV/jjz+UjXnPNt16cQ/RG?=
 =?us-ascii?Q?Hx3NhPAmXcPgfyQGtA1kckR+zMNPNs8wfh9NWB907AUk1fwz4tzgTMcfz2hY?=
 =?us-ascii?Q?fVWmmNjRVKjXa+ZnQUcIeg5at+e194vm7USsxhbIbFW9/5Szr6wVAaG2Fzx8?=
 =?us-ascii?Q?pToScz1cbLVQrIdgGm7SIEU5YdS5euoMl1cqRhD8rUkL/zZ6UU7c4/DVDQkH?=
 =?us-ascii?Q?qXLR199FMtdmaEQ9WgA5hcWgTjA4aFN4JHz8lnuuziUNUeJRWKyrVPRZ80vs?=
 =?us-ascii?Q?VL90wxywkBX5k0wyPrQyLD+ECQSDg2UBJRX6gq57lNEtO1o/aAOsZ2e6CEaw?=
 =?us-ascii?Q?PgxLzzHl+Lj4+styilQ3qjxvs0m14FSv4qIZNUbgD0K+RVCtoL7bnhFhdtr5?=
 =?us-ascii?Q?c1Hux7aKVS3HaCLnOrByI74PY9CKtP94VmK+dFae70QjS+DkkPHHg6K5i2tX?=
 =?us-ascii?Q?hAhPKzppJqIz88Lt0rBCPhQB2zN2abt9rdG+UG+Kdcv+xDEWWi0pbW5CeI9J?=
 =?us-ascii?Q?bZsqrMY9nKwCSZ3IwBXTDQ0Bgy/NUK+7VM6Z/emMKj9xF5ddddtU1oByYC7h?=
 =?us-ascii?Q?tS03KqjosdSOeOHgjNv7QjyI9AaEi3IBxCeK9/+lg5azgZFuVsvv9ndId0Kf?=
 =?us-ascii?Q?c3sfau4ZwAyq/6vNmYEF5kwhLFDzZgbqAa/wqOo7XWxV0QLjMlSV3SMwF1jT?=
 =?us-ascii?Q?PB5uq6Inzy7XAHqI1lp2MmZrH/4laneGz2kIB2Qid1NerCyqPANyVhgYIOZw?=
 =?us-ascii?Q?ZNb+ij7jKkGdgKg+ae/M1yiwNogag6so4dF4iNDu39TnbPTEuPKG/d5aX+S8?=
 =?us-ascii?Q?WQIAGEl7JJPanmA1AJH5KcEECO2q4fjZXuKP22WyhYHg/Z/iPT/RHrMCzmXh?=
 =?us-ascii?Q?+5M9pkPPFKfySPYEYHyb3iQZnaMCEXvM9uQUsshb/qHaMLsYFpe3d+adq7L1?=
 =?us-ascii?Q?+TzpjenrCnLisjfbccvdmUMY1qVyI8JaaW7gm+Uln/Ra/3mlj7Roz7DU3BI1?=
 =?us-ascii?Q?5TeBxkPVhqEPzHYcSvPA66sCtURAhpEUSMEdESO9g/e60c0xs6xh5GhpPJqw?=
 =?us-ascii?Q?X3FVDAJ1628c0DtvAgyNNebwYpUceg49/9ST440JwFv3y5CsCuz+SIwLoPRh?=
 =?us-ascii?Q?wm8Ddt4Uoa+XbH0lEeXphTKpw8WUrTIWCkVnksKLnkZOX6Lcf6kzqcPAFD/m?=
 =?us-ascii?Q?+LAECBJDL9wy6mtjyHW28xSv/jkEelaA5vB+1FqTQo/31bqvRctEv3oVzrYB?=
 =?us-ascii?Q?Z9N9ugz1n8itg3cS8nwzvBi2m8j4Oh00RzgW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:34:52.0809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d0126e-b79b-4520-b57f-08dde5231095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716
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

[Why]
Gang submit has conflict with IB preemption which will
break the synchronization between enginees.
Specifically, MCBP is enabled default under SRIOV.
It will causes gang submit use case failure.

[How]
Disable gfx IB preemption when it is gang submit.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 3 ++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 264183ab24ec..c4506be4d723 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8653,7 +8653,9 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if (ring->adev->gfx.mcbp &&
+		(ib->flags & AMDGPU_IB_FLAG_PREEMPT) &&
+		(job->gang_submit != &job->base.s_fence->scheduled)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 456ba758fa94..725b0e4d9bf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2424,7 +2424,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdgpu_device *adev)
 			if (version_minor == 3)
 				gfx_v11_0_load_rlcp_rlcv_microcode(adev);
 		}
-		
+
 		return 0;
 	}
 
@@ -3872,7 +3872,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	memcpy(fw, fw_data, fw_size);
-	
+
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 
@@ -5855,7 +5855,9 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if (ring->adev->gfx.mcbp &&
+		(ib->flags & AMDGPU_IB_FLAG_PREEMPT) &&
+		(job->gang_submit != &job->base.s_fence->scheduled)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 367449d8061b..843761947b73 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6051,7 +6051,9 @@ static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if (ring->adev->gfx.mcbp &&
+		(ib->flags & AMDGPU_IB_FLAG_PREEMPT) &&
+		(job->gang_submit != &job->base.s_fence->scheduled)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a6ff9a137a83..47b10528e07b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5420,7 +5420,8 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
+	if ((ib->flags & AMDGPU_IB_FLAG_PREEMPT) &&
+		(job->gang_submit != &job->base.s_fence->scheduled)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
-- 
2.43.0

