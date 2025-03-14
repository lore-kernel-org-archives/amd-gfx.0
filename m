Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EABDC282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 18:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD2E10E30A;
	Fri, 14 Mar 2025 18:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PBtuKbWn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCA310E30A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 18:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skY92l1Boh6DXtAJ/o0CYdNbI9osiLF9/3xDd1k+1dThM3BIZldHThQHsflxJnQAmaBtRvnmBYf87axmMSXtKZcwLb+xIsBuLi4UvgNRQnvG7GW7fdGyrtMhaj4Z4UI43fUSSuFViEpm/8UaMSHKWsLCxc2eQuokwNKx6OEFIpxHYllb9MTG0bK29F637gB1/MrPiTsdYu7Zl9ooOFTUuLm7Jg7e2E5p/1tJQ7OVgHRZz2wgrOF4aShGHaLJ0OuKxb23Af3LCZB5aFQzRgMifNYa8x0DnvzkOLLjhOoaYvbRKuSGKfJ1F5Vp43OWUZzSR1PU0SHfKNVDjxnQ/KelAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVD2FPE/zj9aGNukWbp4zjExGLLEoTxPDEyXCvNx4Fg=;
 b=pqkf2Ar2s5StWxmKI3LgT3PjyEOFo92AxILeDUnyh19FVlTJsj3erKSBBVDPu7y7k8unlSE1dLpqy3DVM2uO6UHb3nu7Gk9+D1RQspHAlCVTCBFlc9S7RYz356U22Uf9CJhv+2HCKt2sOefHhChnuJqMwYkAdQlYA/BESwycnJAEC7dq1O+mEbfed8vphE/xCPAYWxN3Mwjd2pB+SSPNn/33r3NuwrU3hLOD7LYcPRGkuRjibhsH2RLvQ/N4V2Sb24Sv/GlzD0XBAByAUW6lluqPyPaAOh6bRDwkc06W44fv/THy8b24tumYdNJg7TZmNgVYHrvZF9jcCOzSavgQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVD2FPE/zj9aGNukWbp4zjExGLLEoTxPDEyXCvNx4Fg=;
 b=PBtuKbWnQzKhJvEjs3AzbaC6+vfUWyMM/f8l3TLmKJQXVo6nHNT1uF6+DChdZ5uL1FjtfUkinKX3675Ik/nFfodPQGCf1JeJSNd65tyM65ZoYVo+q2l4n3XLGDYmZmi4u++WYdmtNPnikKkOE1VKqvXglbuwq7BeeYw37fItaRw=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 18:46:20 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::ef) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Fri,
 14 Mar 2025 18:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 18:46:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 13:46:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: adjust workload profile handling
Date: Fri, 14 Mar 2025 14:45:59 -0400
Message-ID: <20250314184559.3607419-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314184559.3607419-1-alexander.deucher@amd.com>
References: <20250314184559.3607419-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 471806a1-20b4-4956-6f84-08dd632882d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jhf3+mECN76KDkSg893BkMdBO4Srje+K4FA/T5IzBJZmlIOKH0FAaggbh8p0?=
 =?us-ascii?Q?ufMAIBV6upRLdMIzXFeKfU6y/LqScThbCvEWZkYBcBas0OvN9XgKe8kmEjfF?=
 =?us-ascii?Q?6TVKZpGCj98imXGpJPlvE1ZDXLvqckAcrRwuGaNAi6cYC9X382dWnLqN2cGa?=
 =?us-ascii?Q?eBwqXTxwRMjHqDcDIV9eZQj0pqH30ksqO7bNT130ER7VSkOc9bnWudfp5mg7?=
 =?us-ascii?Q?djMJow6hS7W2yddc8aICADJXbAsukpczg0x8Y6S8QUXcOk9hnpnrQBC6duKs?=
 =?us-ascii?Q?JqZFwtanP2Q6sku8HngK4Sup1eQYOO99ki01RiAYLqd4og5Tpz15mgHB48Uz?=
 =?us-ascii?Q?vmII0BzXTCgDuyI+ljn7CwG5EuCQoe3KdRdMgcbbyJ/aRxOlXhFAljYFAIBf?=
 =?us-ascii?Q?FS3qL/omjwP4z1+VMMcBvIFW219p9/59GJoZknaEwfZTWdLbiYV1d/VHIiEY?=
 =?us-ascii?Q?l8Gk3ASU8bul0Y7OltiGazlSBFI5162q0p9EmyqG/7J+loNgnuBnZI1+vliK?=
 =?us-ascii?Q?R+pJGXgvqL6IWPfhMGJSl/FgTtLccsijnQO9oE3duvKm3qdfm9HliftY7IpG?=
 =?us-ascii?Q?SPHjT6p/LIIJU/gE27OWE0jIDnFb6e9Lxyypo/9wcMpvM7E/3y6Zgae8FSz4?=
 =?us-ascii?Q?nWN8Jzcq2m9/zmbapLI67GO3TbpIseKGAeLcBAYC+ozK8J/wHd2Bn/qwQ8RJ?=
 =?us-ascii?Q?/ik01sI8Fcq2MuRRGQp4jaPoARkTUvhOjAkjTv/1j/trib+7ZXEEpcZMlMc7?=
 =?us-ascii?Q?iDe8vDHrHz6lgZtCSebYgJQNgEIOlXMyPkcYDYBMr0mpmt7kCn4mmYdhtnfb?=
 =?us-ascii?Q?qYqoGXFG8XnR6hVEQXzhRumWsfVdJoqp+ORYbayunDP5pC/AblraKOQHbmOL?=
 =?us-ascii?Q?+0w9dGsTVfnc+JdMl5wmElfiGKXy/UyxtMa0Swni7KiTG0pT8MjTM9583/OA?=
 =?us-ascii?Q?KoAs2BTso0a6pPAevCeWr69pat4NoD6EFHjcq2hUkxxz63VDE3VZAdtd0gdv?=
 =?us-ascii?Q?TIF15F+R3pfjGcJ67roOSOWIfJiaM22wZ1s9ioSu8cHprR8iZyVcwB+1VrGH?=
 =?us-ascii?Q?dzYy4aHI2RJtQ0LNowDJ+MISKlVsJF2GwaoHGMcdV4zvyC5LPYfOADucGmtd?=
 =?us-ascii?Q?1X1pawFhE3ujahOYnBFzmx8oVtGdYuvtyapMvZ/nsW7HkDV/VtgAKRi0mXNv?=
 =?us-ascii?Q?zxZ8r8dN5zH8oXOYyTbKpQWoqgEX94GY3pQLCN1RGCtWrLGyzrRoD2BmRXTV?=
 =?us-ascii?Q?bxoF4DddGMTpMADf7bVlULYH92uuuQolKOZeFvE7/5e4sXSGXAMsvW/NaFyq?=
 =?us-ascii?Q?mtWxyZ20skfYEFQVBJJWXo7GI1+9cBjA6h3Ke4UdYdcZYmCnn+gBw62iXdxQ?=
 =?us-ascii?Q?rFQnBVO6EHV2SO3kTxyfuqcEqc+r3Qg2n6xaiStsTcQLb9m4Ko+kH0mju4aZ?=
 =?us-ascii?Q?+tcoMdNjJTjxyAZA5oM0ZXfznhQms7ROGWXKG2r6gqaZedQil0ovPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 18:46:20.0393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471806a1-20b4-4956-6f84-08dd632882d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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

No need to make the workload profile setup dependent
on the results of cancelling the delayed work thread.
We have all of the necessary checking in place for the
workload profile reference counting, so separate the
two.  As it is now, we can theoretically end up with
the call from begin_use happening while the worker
thread is executing which would result in the profile
not getting set for that submission.  It should not
affect the reference counting.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 20 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6b410e601bb65..0ab74b46bcb0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -460,17 +460,17 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&vcn_inst->total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
-		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (!adev->vcn.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-							    true);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
-			adev->vcn.workload_profile_active = true;
-		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+	cancel_delayed_work_sync(&vcn_inst->idle_work);
+
+	mutex_lock(&adev->vcn.workload_profile_mutex);
+	if (!adev->vcn.workload_profile_active) {
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+		adev->vcn.workload_profile_active = true;
 	}
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b4b8091980ad5..8c7c50f34fce0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -169,17 +169,17 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
-		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (!adev->vcn.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-							    true);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
-			adev->vcn.workload_profile_active = true;
-		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
+
+	mutex_lock(&adev->vcn.workload_profile_mutex);
+	if (!adev->vcn.workload_profile_active) {
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+		adev->vcn.workload_profile_active = true;
 	}
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
 	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-- 
2.48.1

