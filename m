Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A86CCD199
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 18:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2262E10EA70;
	Thu, 16 Oct 2025 18:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K8Z5VuT9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 978A510EA72
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 18:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMQj30WABRWJ6zt2bogefvFKbQSkMZYQskD1JhEX3UIaqZuuQsN9jJbD6AGOQNiyjxMu3ME6koiWAE1drf7Js+7DLKS8PuMIEJaXD5AtWr1QvpOlV/5yrnYyT7G5Mpccm5RBSLVGy/ykA8WyP8P1tI+LJCQjC2XItUuZDvWkMFuznj7Tc9tVZVZB9ndPZcn7b7vKtOHBspYw1Oo1a8142UjytlK3exM4ySkKCHBeOoHdQMguOVYviGjK84fqktIBIWurDITSjiTh/fKZMdR/eLr+7rg2yrC6dpKRK91Ghaxiu0ueQPF6lnkcIyElKIj3D016LWXbbUbbX0pWgBs1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrDGwHj6lW0KrW69XYtPi2XjEZGjg//Jf1/enYUtOAk=;
 b=bh9N7sWyqhuU9393Ar4wRlVf4kPX8oboeWFhvnS5SDE5kSav4moTD8lTvWDFqmKkS4BLMJhBx0MeGk+bDYYYv16mzpPLd5KhTy3cxOEAj8bi9tN6EV9c5K75E8ybaSL/hQC52x5+KC5ISd5V/EKhI2+dTHNia+a4tOMJ6W6sthpdS2QKmKpfXlGjVKvPuAKMqVtuRijekK7fVdHJmi6Cb0cvtsm9Rt5C6u1jhfxkYLCvQPLOu34I5u6yQPb8pHpDDVUkrkgOde5MsdH9iZGHm5bwECHe4r6PWfwKOKr5g84j9mHZRT43FNnP6xGzIY+VUPENzLCDK507l2dD8apYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrDGwHj6lW0KrW69XYtPi2XjEZGjg//Jf1/enYUtOAk=;
 b=K8Z5VuT9wHwzNaTt+GkpB7xp49cp9AQLTwKccEWGDWGl19iYkpfsUun1dADzrmtNnFQFsYC8k0PY2rJclypgr4iV67jQMv7TVTGCGN6TM+s8gLiXGjZdo7uKmzgrc37voj409Fy3KeGVjyO2XiX9arkH+W27xE1++up90tpB4TE=
Received: from BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 18:55:41 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::84) by BY5PR04CA0004.outlook.office365.com
 (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 18:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 18:55:41 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Oct 2025 11:55:40 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Peyton.Lee@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH v5] drm/amd: Check that VPE has reached DPM0 in idle handler
Date: Thu, 16 Oct 2025 13:55:27 -0500
Message-ID: <20251016185527.1796606-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b82019-d0bb-459c-e2b0-08de0ce59a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GD7vmXnzmuB2xuKcZxcyWY6Br+JdSry4MYQLwDfd+mNGhhCmh3zs4caBlpmn?=
 =?us-ascii?Q?Tx48ykVrOPVDlvOih7BPH1cO1hGf7GB5tFWUNuXHegqvBGHHj946CuNXGHHy?=
 =?us-ascii?Q?i8nvzpD3YbVKfnwdS6SvZgEf4EQk0qi/uXCQ8E+POtM8WIYmJqIenfRbYj3m?=
 =?us-ascii?Q?aEWwr08/wWAto4okDMY+760Zv5/rhdUnhiuCNjGWuv5g4eigibN5arL4ude3?=
 =?us-ascii?Q?TeU6BJNN9DeMTF69qMVenpKKcrGk98b7/h+q55ZUAEnAkpRJUf8bE5jc7ecX?=
 =?us-ascii?Q?gUMqe/BXw2yzA3g9dXN2SrXrx5q4M7q3fheGX3udRvY5bWttSpspXt27h0BX?=
 =?us-ascii?Q?fmgo2ZpFTo0cimzXZYsIb80tdvcTm8YG9HOOpAnru9mwtYvmDzu9Acfmd57d?=
 =?us-ascii?Q?FmJ+us4mV1qMK1CeSVUEFwqqCwTirwBAh6Kh6n45Pbox/89p4igK/Mde6Ao1?=
 =?us-ascii?Q?Qyj4Xh1yJg6+ca/bPB64QYcFSepKBqR7UvjIsfjMoz2c4CqeIBhkd00Mjkh7?=
 =?us-ascii?Q?4GdqeBuD8E7RXsZ+8p5vVGuabH/vx4pOmdUH+fL2mPEEEkgamY9OF6lAXpeT?=
 =?us-ascii?Q?1CsfWP+yw8IizKHFvxJ51dZlgjXrB6lQgIHbR37oeBjA6k1u0MXaqhtkukY+?=
 =?us-ascii?Q?75a34JUIlPgnuO+oAGaKlj53d1Z0tF/Kc7zCZtF5/Rk/scz8rp7lFHEKhE6a?=
 =?us-ascii?Q?mIcEyl0tPoT705da7GI7PN581hquZfq7ZSPL4FhH9LxcYxKylVoeHnCrGISR?=
 =?us-ascii?Q?WPxBl8UOk/DF1mv045eu3iZJ9hcrgh1V1hKGG2GPGcKb58AjldFh9Qj6yRfO?=
 =?us-ascii?Q?U9wvBa1y8hRy1PCllgqYufU7U47Y3ZiyJNkqiC1Nqwo1ybs/jyt4Rt8x7+Th?=
 =?us-ascii?Q?VlPMk9bKyztWZvrNqOHc+m3GtgrHC6o3hQ3uZ791/HjpG4WD89T/5zrYrB53?=
 =?us-ascii?Q?hwNThAa22SZ1PqQFILmerO7TN5cMfwanZnk6HXB+zEx2/Y6jUkexE+HebGyQ?=
 =?us-ascii?Q?IMPcX1kMEuLf4pYV+UH4bM8UZIPTOPdV6jT6Lbgwz3CMV3C7eDhIEcdujXe2?=
 =?us-ascii?Q?nMUnj0tvW7Hbd4ECvewrWPpDPEGY3yWeJg15LjctB/5mz3CTtNIPG+5oLSsm?=
 =?us-ascii?Q?Qii3ShkNkP79/f0OrGROeIXD7GRkK1CrQmNkmvpy+GTGLhidr3X0jCLzSWXv?=
 =?us-ascii?Q?ISeE4GsH98R7Sc9ETXddLvRFqRyqYWkR9ZdB+RbnM6SSeyQlYzgnpFcz+l/g?=
 =?us-ascii?Q?sE+oc92kHEIqOD9uTjY+jHIujl8dp77kqACReLtOjI1tELhIzzBy1tSGpuMO?=
 =?us-ascii?Q?DJsv58i6o0mBe9t3z1XG4p0uJc2PWb7c8SKqRxWBV5CqoqBJasJmIvQHYMxb?=
 =?us-ascii?Q?9XGGKTGtVLjaUXLxxsXOj7WhHpVpcWnLIDWVPT4PcvHXleJlwAtEDa8SPuJX?=
 =?us-ascii?Q?0QmCG1/QWcX5zqYJ9F0QmQzH9EFIDEBprcpcRgmZK7lJRFZC9HGMG4HS7QgN?=
 =?us-ascii?Q?0Zf3i/jR0q/T58s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:55:41.1157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b82019-d0bb-459c-e2b0-08de0ce59a82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
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
Newer VPE microcode has functionality that will decrease DPM level
only when a workload has run for 2 or more seconds.  If VPE is turned
off before this DPM decrease and the PMFW doesn't reset it when
power gating VPE, the SOC can get stuck with a higher DPM level.

This can happen from amdgpu's ring buffer test because it's a short
quick workload for VPE and VPE is turned off after 1s.

[How]
In idle handler besides checking fences are drained check PMFW version
to determine if it will reset DPM when power gating VPE.  If PMFW will
not do this, then check VPE DPM level. If it is not DPM0 reschedule
delayed work again until it is.

Cc: Peyton.Lee@amd.com
Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 33 ++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 474bfe36c0c2..f4932339d79d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -322,6 +322,26 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static bool vpe_need_dpm0_at_power_down(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
+	case IP_VERSION(6, 1, 1):
+		return adev->pm.fw_version < 0x0a640500;
+	default:
+		return false;
+	}
+}
+
+static int vpe_get_dpm_level(struct amdgpu_device *adev)
+{
+	struct amdgpu_vpe *vpe = &adev->vpe;
+
+	if (!adev->pm.dpm_enabled)
+		return 0;
+
+	return RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv));
+}
+
 static void vpe_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
@@ -329,11 +349,16 @@ static void vpe_idle_work_handler(struct work_struct *work)
 	unsigned int fences = 0;
 
 	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
+	if (fences)
+		goto reschedule;
 
-	if (fences == 0)
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
-	else
-		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
+	if (vpe_need_dpm0_at_power_down(adev) && vpe_get_dpm_level(adev) != 0)
+		goto reschedule;
+
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+
+reschedule:
+	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
 
 static int vpe_common_init(struct amdgpu_vpe *vpe)
-- 
2.51.0

