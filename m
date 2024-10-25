Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0866CD116E2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB9010E9DD;
	Fri, 25 Oct 2024 02:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uA3AU1sF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A9310E9DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZJbHKyXTKX5dSXE0pgCPYQHKIco7s/hzJbNlGUHaKwqJDqB/2OtIT+v4wNilr7qgzXQpLpMUp11X+GGNxwePRldnrhXpMiv++d1M1jNLfbEjfel33TtaGTOAKOVq474hQWj+X4zyMxZ7ZothOe6PSt0O2WT8p3+0uP7+ATLIqcklrFRMlgnLOGxa00Op6naJfUgXdEQuKgSHpiip/GAlN49jQ9R27eZI1YIkyfDOtW/fQydZeHslyVhqelQY2gZs6Fkww8OfU0nYn/K5KHvckEVvcJseU1ZFd9xpZymA77kX4/H2MnDeCwgSspvnDbF7S7TchL4S9JlXilK/f5IBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kUw+WMND3rAy0vSVMdLmnFZp1z6WFf2iL48+JF2Ev8=;
 b=dOdVvtmdhoEsKZeqehBlSGgD6zDrkRohYuTGMh4gSxc62PiKtrhjOSH+8gz3r3hL1NLK7VIqFv6BzKH057Gy7/RGGf75R6ICdfGlNJ1Kq8fSH8DrbXIaavj2lja0bGljwkcGwOTQ1QSOtQk5v1xuRcIjlKuiPGD6Lq7uA9eEUx8FWXTtRBnIierwXabgmAluaD7BNhLNm8PLzv6xzBnQfdykTeR3a4mrtFvj+JOn7idy60zoU6YbBPwzCEthMfJCzsnh5dnsTQ7/ihuqNAks8n+nYBt3YT1zlU24GTNDMbxe/k7733VfG7OCAucdGET1rJneCgp8p4n06SY7QOiClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kUw+WMND3rAy0vSVMdLmnFZp1z6WFf2iL48+JF2Ev8=;
 b=uA3AU1sF4U51GtiUiYzHSjlHYjc32YvBwRbFM6sbodoc0aMnaPfOTolIkqjmlJfo561pVGGf0q2kDX2Gg2I5FBC4FzvkUeTMJXw35GMN1qXxJk4D8D1CPtcdY29U3jwdz9rrftYA9byjaZxul0x5NjZPx9iWeANpF6JaV4OXrnE=
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 02:36:24 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::f4) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:23 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:19 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 24/29] drm/amdgpu: suspend for each vcn instance
Date: Thu, 24 Oct 2024 22:35:40 -0400
Message-ID: <20241025023545.465886-25-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b5fb6e-ed54-491f-cde6-08dcf49dd154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2boGSZY8nxJdRThghEXKNgtXGcthD6sP5nwujQzv8ZnOp+dXrTtY+9LCYWJd?=
 =?us-ascii?Q?2UrBRrWY1i3uNweNYFN5mXPgJoYPBnDMx6pXPOFazq4Z3VYdFsKGFcU/MzVJ?=
 =?us-ascii?Q?iQ/ZSHJr6Nyv2vfvwyrZqSUwGwOloG9klajN4+QQv4fs0AS247c5o4PwwgRj?=
 =?us-ascii?Q?3DrFwiCN9Lidm5gvQlmWQSwFYFlBFsHUFQtiFvbu3KMuPPgO3f9Nie9AJ6XM?=
 =?us-ascii?Q?HOKuczgJ6UbKq8lGm1UJnM7IDL6Db5HKjbUG4IvM3kzvq6ErsflgugBDWrmb?=
 =?us-ascii?Q?dWyhDU13vTfNBbNjXqIOFW4PErrOD9LQv/BFnDWyFToQ/YIduC934f4DVUMM?=
 =?us-ascii?Q?pPWKto0SBvSjJOwIRxqDDvsEjBchxZc426IFxnereLBHd4tKmwDc/Yih93n7?=
 =?us-ascii?Q?KGCGkY9nON/r6Wwb+D2JH++8SJ4jQcGXzrW1V6+VxYilpbQVSBkI6tCtneKa?=
 =?us-ascii?Q?7RtKi+mnagFBvEXfDn/b2E5/xuihlJ8YAjYIGHyk9SsLMRT459pvFSWBtu4R?=
 =?us-ascii?Q?+E7AliGmJjK7paHnaNgDaDLdldjfUcdT6nTl/oYYPfhDvNvvOU5UGbIN7S8c?=
 =?us-ascii?Q?jAQ6LBG3B86pPpFp71awaUdYvS7NUD+KQnemjbvSPTsv9eQbCu9Hjtyw/ZAE?=
 =?us-ascii?Q?VFNrvF9cO3wcGb6KdbtGESzy2URIXjRyX1P8tUP0/aQ6kj/uj8Lv25Ah14HG?=
 =?us-ascii?Q?gk/XUm3kCWnz59fMR2MuJIkSHz/x7/O0+CPo+TvmvWscoXlz6EBBJU1sLBXI?=
 =?us-ascii?Q?UaefJbi2dtgP/LZU1EMduVzXTMQ87Wdw+BibCC/UVUsw/1JVYzsLb9QCeMMi?=
 =?us-ascii?Q?XMqphKLsMpf/E6sMO0PINaawSPwpZA0+tBIGqVgLKaFycA+ormd0xtPRSk6Y?=
 =?us-ascii?Q?o3Sx/KPUw9KwkwMhzEiTXc9peR61v4LSFPL4g/hzjS676g+Wf9453i7w+Yks?=
 =?us-ascii?Q?Zo5wSNsg1c+BbtBix0eAECEyXSOMKryyYYlwRzwjkcPfCIEcPot4DkgKKOu1?=
 =?us-ascii?Q?g66+1hs9KkXouiZ/Kn9rUUdIL+m0iNTPWw0pa83NwqFE/QwIrkgmb8lwx2PV?=
 =?us-ascii?Q?5H6FTE26EiC6AdpxM/gzaa3/XcDkblXSRDZbdzV5V+ecG1tyaSAiRuvK6Smz?=
 =?us-ascii?Q?m/+PDbMYLyd07aFtAIUs1ImS1gQrAFpi+mkshOw91yxdo74Rrl20MIqIeVkH?=
 =?us-ascii?Q?LcjNUo6Zs339HxLr2QCVW4yGLhFpYC51xFwIPkbQBY1hrs/NU0EYqhGioyq5?=
 =?us-ascii?Q?47qE+YxDkyIDXbcS5USqOsoK269mxdETEFON4PLGFajkHLm4ESf4tB0q/VuW?=
 =?us-ascii?Q?/8eKe8oTSB9qdxx2pPUj3iv/35jIqa0FFZScP5r0CFA8EVR362WiEBX+dPif?=
 =?us-ascii?Q?01mDxGg1zHO5LsWkbIlENWf9x/CglDPW+og/Ms97GGmp0G58zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:23.6931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b5fb6e-ed54-491f-cde6-08dcf49dd154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_suspend(), and perform
suspend ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

v2: add vcn instance to amdgpu_vcn_save_vcpu_bo()

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 13 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 38 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  7 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   |  6 ++--
 11 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 24dae7cdbe95..4fc0ee01d56b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -42,13 +42,14 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 		/* XXX handle errors */
 		amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
 		adev->ip_blocks[i].status.hw = false;
-	}
 
-	/* VCN FW shared region is in frambuffer, there are some flags
-	 * initialized in that region during sw_init. Make sure the region is
-	 * backed up.
-	 */
-	amdgpu_vcn_save_vcpu_bo(adev);
+		/* VCN FW shared region is in frambuffer, there are some flags
+		* initialized in that region during sw_init. Make sure the region is
+		* backed up.
+		*/
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN)
+			amdgpu_vcn_save_vcpu_bo(adev, adev->ip_blocks[i].instance);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d515cfd2da79..50047c636904 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -294,47 +294,45 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
 	return ret;
 }
 
-int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
+int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst)
 {
 	unsigned int size;
 	void *ptr;
-	int i, idx;
+	int idx;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->vcn.inst[i].vcpu_bo == NULL)
-			return 0;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
-		ptr = adev->vcn.inst[i].cpu_addr;
+	if (adev->vcn.inst[inst].vcpu_bo == NULL)
+		return 0;
 
-		adev->vcn.inst[i].saved_bo = kvmalloc(size, GFP_KERNEL);
-		if (!adev->vcn.inst[i].saved_bo)
-			return -ENOMEM;
+	size = amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
+	ptr = adev->vcn.inst[inst].cpu_addr;
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-			memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
-			drm_dev_exit(idx);
-		}
+	adev->vcn.inst[inst].saved_bo = kvmalloc(size, GFP_KERNEL);
+	if (!adev->vcn.inst[inst].saved_bo)
+		return -ENOMEM;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		memcpy_fromio(adev->vcn.inst[inst].saved_bo, ptr, size);
+		drm_dev_exit(idx);
 	}
 
 	return 0;
 }
 
-int amdgpu_vcn_suspend(struct amdgpu_device *adev)
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst)
 {
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
 	if (in_ras_intr)
 		return 0;
 
-	return amdgpu_vcn_save_vcpu_bo(adev);
+	return amdgpu_vcn_save_vcpu_bo(adev, inst);
 }
 
 int amdgpu_vcn_resume(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index ce8000ca11ef..be681bcab184 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -486,7 +486,7 @@ enum vcn_ring_type {
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_suspend(struct amdgpu_device *adev);
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
@@ -520,6 +520,6 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
-int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev);
+int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 44370949fa57..a3845e7747b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -226,7 +226,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int inst = ip_block->instance;
 	int r;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -300,9 +300,10 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	bool idle_work_unexecuted;
+	int r;
 
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (idle_work_unexecuted) {
@@ -314,7 +315,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7b5f2696e60d..8e943d1fae17 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -257,7 +257,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -335,13 +335,15 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v2_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 8ce3cea6cf44..9ca07e56b052 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -316,7 +316,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -412,13 +412,15 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v2_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 36100c2612d9..a25d2b9784be 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -325,7 +325,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -444,13 +444,15 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v3_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 00ff7affc647..fcf7b23cca90 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -277,7 +277,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -372,13 +372,15 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index feb373a96cfb..ece9b1df2743 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -235,7 +235,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -331,13 +331,15 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_3_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index fb1e1d5bcdbe..f1ec632a9eb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -246,7 +246,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -323,13 +323,15 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 137c3b452433..fdfb3084d54e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -210,7 +210,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		drm_dev_exit(idx);
 	}
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -287,13 +287,15 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v5_0_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
-- 
2.34.1

