Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538A7CF9C71
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 05:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067F710E4CE;
	Tue, 24 Sep 2024 05:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VSnVcthX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B2310E4D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 05:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2JD7uzY3bePQfs86vhdjBJAOiZVX95cNy18mrr4HORr/M4TjbVZ3x1aoc9qIMRt3iWXdlFflU1hZeijjwXPqMLcNzW8RvGjPGli73WVKAn0ElzzOzNayAJ8cHrfJxIKhFNaEqrCKdKt3PDvato1HKWxGpvbTCmoyu90oTfOHPRW8q4AIZQ68Oeb22aa87/zg0qKE0cryYYDl8RKkzsOIEMEWCvn24YiLi38HFpm8P7H0zJ0ncyBM8woubqYtx78RJ5qdvii4YCKr1pLJUpwJUHPMYe+TPWUyG1ZID2wfo+ifoYMVZczf5bszXbPTOI/q0f1h7sTSl97X4qXR1fUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFSap/n6miAiRmcUo/R768WLwBVXGztbWjsY1A0ZZTQ=;
 b=G5tlzxrVsfe0eGkUs+ZP0MnoRuROE9CqOApI9moJ9HCxahXiCdBzetiPUGGKNRbPSRbn8Iw8rnYiixkwHoxM5/f8LgIwF+z07CiASKs0T5Y3BjmAtlYhey5O9dv0kHrSIdudhC+GixhMGmf2onUfTzMUJW4ZKWr+ZOnp5Hcln2b05IWc457rQ7Tofk9HX3crTr/V00Zg+GxBld3XRkr28APrBXoK9Ywzejhiero6RhnpwORrRm7sWzECfhClkF2WwF4SfkkQblhH3oOvQtPTBFEsT9ggZA4Skpikx7Q9NEhik3eAMa4fCug9onWIJuzPPmuBy4wrW54Fm2PlSkbWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFSap/n6miAiRmcUo/R768WLwBVXGztbWjsY1A0ZZTQ=;
 b=VSnVcthXB3rdaV+roYNB9IXs0e17euIq6Bp9ZBH0ZqMrDj2UnsqXjiFueEvmNzQLii8B0082ndQGu9HZc4Wf/N9O93jF6MQhZHX9tzDo/lAmJUhbN8bFAYXjBYfKUTQYOz3fxxbQs7xCpjH5gMJL5/b71aCyhIJTJAezdSsVOXo=
Received: from DM6PR12CA0011.namprd12.prod.outlook.com (2603:10b6:5:1c0::24)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 05:57:29 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f7) by DM6PR12CA0011.outlook.office365.com
 (2603:10b6:5:1c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23 via Frontend
 Transport; Tue, 24 Sep 2024 05:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 05:57:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 00:57:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <rajneesh.bhardwaj@amd.com>,
 <Ramesh.Errabolu@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: Add NPS switch support for GC 9.4.3
Date: Tue, 24 Sep 2024 11:26:52 +0530
Message-ID: <20240924055652.2678433-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924055652.2678433-1-lijo.lazar@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: a84fb4f5-6425-47bf-55c5-08dcdc5dc635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hiG+DoW/KaNx4FcXcolwQNoMZyvfdvM58HyFEnc1RwvnLF1UVqyfyFP1lCEh?=
 =?us-ascii?Q?LXM0OIt88LTLVirj2gvaQENQnoz80XRMwlOijcQXEPPOMTFueNTiOaSQVIUY?=
 =?us-ascii?Q?KHVIjDUhPocp+Xt5sdq7HBMpbaGhw9UtaJl52Df3k+VDotn6NA2YM10dZjyC?=
 =?us-ascii?Q?ib9t5j2n6Wxe2igAm4JBKeTdP7+QQWDfenQ6VtL/bgjfdrbYHm913XcCQWZb?=
 =?us-ascii?Q?zJAZJebmaUfwC4OrW5HO3N50aB89BBitl4pKBiwTNtVCVDeuYfhjTUm2txzS?=
 =?us-ascii?Q?IY5fjXbaOX+ztNkauasz9jCPnpbQfnskkSaJj0DfNYLgGd7Fsim8s6XKmHBB?=
 =?us-ascii?Q?i6KLb3h3m3h+gD5WnMkqlEYCTmds9kRTFUQF1prmGrr8J/+nDMpEGQZM46Qy?=
 =?us-ascii?Q?qX3q4NoSit2rwWVoyKUe/lXI0DMWi4ZSk1HJfMNwIVy678H8ZZ7zCUSXFe0G?=
 =?us-ascii?Q?+k2bZr41r8tTGXGO9YUJqq+2zCmyo6Kn6vVqNSn+4d/BaogLhfM3SKfgr5Rs?=
 =?us-ascii?Q?QsmyWpunguMH7byOOKTUoM5YYXczOmdenc058ancl8lTKwocu1rKp12187vw?=
 =?us-ascii?Q?oclohf1cQvYPIVqkfvDWLqp6zQeYBe4gFqOzB2ktFteIBM2oDI32ByFgmSQJ?=
 =?us-ascii?Q?0R8wLKmavVoTPlNmwKrvE2t1suEzckWPZZzIR/FIvzB4ONA4mdwJXdE8VNMP?=
 =?us-ascii?Q?KKbWZSjH9sRP3rn36dBnFTz0MiwuOC5hPNnqm/oe2EIC0tIApPDAHe8ceaY3?=
 =?us-ascii?Q?+VUXUHHMzUZLIAbYG6wuIM1p+XZuYt6f2S2jh5k18OHgJ4L+bEQvpYcin5Y2?=
 =?us-ascii?Q?HaHD24xxKCIuug6pvz8MBYrUSBgt2u4ZTT42ja3xWFORNb44l/UZ7LbbRVI1?=
 =?us-ascii?Q?GfAUCMcK2WIHMYDNS4i7i5nefVetv9f5jFAWrDWjh8onjgzbI8u5qWPNWeyP?=
 =?us-ascii?Q?7yjOIhc8QKiy56YBlsdXkBZZpW12GHCRv3BWgULcqpG7HKVv/DwBvae8mem1?=
 =?us-ascii?Q?2HJV9S93IbKX07D8c8qcNMqAQSTaxE6zoQosst2vf/S9Az4IVrQ8eb46c7xf?=
 =?us-ascii?Q?Thnz/zc5Hwms1MReKoCH0LygWChLHgdaL15jA4BUyAXXGCDhqff509VeD4Vb?=
 =?us-ascii?Q?CCb69sRBju0eT2SCbYFrFxUNKRyJEaM8wVFBmlOLtk3GLxByX4htVi/9ultL?=
 =?us-ascii?Q?5Kwp2yb8UYstH18TOgxXom1nOYOKPnLVcNQ1ulehQn47uPbN47l2xfUB4ZeS?=
 =?us-ascii?Q?tOZ3hXxJrtnQHxra/r4pVgfz8/HR6oRRNlprI0G2wK7gm3cWAnzWhdyIuICW?=
 =?us-ascii?Q?H9Va/OH2C3NDPP6PlYriDDS3GtP5O/67Y1WXDDZP7fMw0tEmgK9UJGO3dmBf?=
 =?us-ascii?Q?ixk/qCad81RstPZ7Vsa+bzNJn3nlyGGwmHn13H9+m1JUgG3XVt3a3Apix7a+?=
 =?us-ascii?Q?yRi3hwl004F6NdXPtDUTubQZD/JP94Ke?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 05:57:29.4127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a84fb4f5-6425-47bf-55c5-08dcdc5dc635
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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

Add dynamic NPS switch support for GC 9.4.3 variants. Only GC v9.4.3 and
GC v9.4.4 currently support this. NPS switch is only supported if an SOC
supports multiple NPS modes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 44 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 12 +++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index f61d117b0caf..79c2f807b9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -101,6 +101,7 @@ struct amdgpu_nbio_funcs {
 	int (*get_compute_partition_mode)(struct amdgpu_device *adev);
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
+	bool (*is_nps_switch_requested)(struct amdgpu_device *adev);
 	u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
 	void (*set_reg_remap)(struct amdgpu_device *adev);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cafcb24449df..6a95402985ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1395,6 +1395,17 @@ gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
 	return gmc_v9_0_get_memory_partition(adev, NULL);
 }
 
+static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev)
+{
+	if (adev->nbio.funcs &&
+	    adev->nbio.funcs->is_nps_switch_requested(adev)) {
+		adev->gmc.reset_flags |= AMDGPU_GMC_INIT_RESET_NPS;
+		return true;
+	}
+
+	return false;
+}
+
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
@@ -1406,6 +1417,8 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
 	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
 	.query_mem_partition_mode = &gmc_v9_0_query_memory_partition,
+	.request_mem_partition_mode = &amdgpu_gmc_request_memory_partition,
+	.need_reset_on_init = &gmc_v9_0_need_reset_on_init,
 };
 
 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
@@ -1545,6 +1558,28 @@ static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev)
 		adev->gmc.xgmi.ras = &xgmi_ras;
 }
 
+static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev)
+{
+	adev->gmc.supported_nps_modes = 0;
+
+	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+		return;
+
+	/*TODO: Check PSP version also which supports NPS switch. Otherwise keep
+	 * supported modes as 0.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		adev->gmc.supported_nps_modes =
+			BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			BIT(AMDGPU_NPS4_PARTITION_MODE);
+		break;
+	default:
+		break;
+	}
+}
+
 static int gmc_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -2165,6 +2200,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	gmc_v9_0_init_nps_details(adev);
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
@@ -2440,6 +2476,14 @@ static int gmc_v9_0_resume(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* If a reset is done for NPS mode switch, read the memory range
+	 * information again.
+	 */
+	if (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS) {
+		gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
+		adev->gmc.reset_flags &= ~AMDGPU_GMC_INIT_RESET_NPS;
+	}
+
 	r = gmc_v9_0_hw_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index d1bd79bbae53..8a0a63ac88d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -401,6 +401,17 @@ static int nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
 	return px;
 }
 
+static bool nbio_v7_9_is_nps_switch_requested(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
+	tmp = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_MEM_STATUS,
+			    CHANGE_STATUE);
+
+	/* 0x8 - NPS switch requested */
+	return (tmp == 0x8);
+}
 static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev,
 					       u32 *supp_modes)
 {
@@ -508,6 +519,7 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.remap_hdp_registers = nbio_v7_9_remap_hdp_registers,
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
+	.is_nps_switch_requested = nbio_v7_9_is_nps_switch_requested,
 	.init_registers = nbio_v7_9_init_registers,
 	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
 	.set_reg_remap = nbio_v7_9_set_reg_remap,
-- 
2.25.1

