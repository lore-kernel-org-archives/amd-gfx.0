Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2AECA0EFA
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 02:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB3310EA48;
	Fri, 22 Aug 2025 02:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Q3PlufZ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5305A10E310
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 02:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVVZxybd1UnAcDlc8GQ7drFE9Dgiwri9KQgx8T0NMxzQFixgyIcFklDlrs7uvwPU0EUHqZ3HS4TTYpfavvZuWO0ALZBBvnaVfBgQycFSWBNfafVzrW/vaFUy0TXaeKir9wqeeRp5I5GMOALinockz6kzFxFveZg7qRiFOlqD4i94b2YWdzQVjJ/hnBuW0TcRFMO5OOUY7Ep12pH0VDgs2r5YSVKpNGYf15rqZdaDtj1tUNpz2mM+B5gEEp48FDH+Rj0ZbEkopsggKj69CKvY6yFOK4CX1BGzeIovfJw8E0WQyO6fp5yMMNx9hQhLTHj8Jh+JX6OSKUCWyzLTMQHOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wdk95w09TKunWZT7FOmZoGJnQeoqJZL7eTvYRxEKH1E=;
 b=A12xN+eZo5kHoFU84D4vv/g8hR3180w5sXN6NjkeL575Cp4eO5rkj5fgrbN69lZMs4MmkuYaNdEqHAMccpZ8gVd3QduQqaLSGkvoxMAQACgIaH7JGTFAl0dKCok6/OUtO0JzDPhE7GIr9sW4tW81tMLiIoUdZSr357ZntLW8JHpxWbd52rcwEF0R1o8QG+w3DoytrVAyi8vvZ1oCJuzACP4daJQr2d1vDXvjt8EC/BMgK+bp/WNBOy5EUTLHweK9p/k6k6UdTLpWSVFOrj6V12cUKUumZEWADHgjksBcO4HhKHrHqzggaTXUKB10H85+TxgoRy6RTHC21ESzEjpeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wdk95w09TKunWZT7FOmZoGJnQeoqJZL7eTvYRxEKH1E=;
 b=0Q3PlufZZZNAH1hJ3oRhceUuz2Fbi3JHgtcrNnqlKtuk1l/Azr46H9MEHkEePRpo2bohc9l3UQRdWu2zQV8L9cH+EWJnyzfAuf10ImJdUyzw/AMHEAG3dtEBJZJktH4VkLnPm25TDCVAtftNV4+CXbIls9/IFiUUPZzblkWJZu8=
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 02:18:12 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::16) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.6 via Frontend Transport; Fri,
 22 Aug 2025 02:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 02:18:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 21:18:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 21:18:11 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 21:18:09 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v4 2/4] drm/amdgpu: Add ring reset support for VCN v5.0.1
Date: Fri, 22 Aug 2025 10:17:33 +0800
Message-ID: <20250822021801.630568-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822021801.630568-1-Jesse.Zhang@amd.com>
References: <20250822021801.630568-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: bd56d22d-d6de-40d0-6b02-08dde122252f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g+98NYuuspce4c2+Z4IbLoKixbsXR9n/+joCDiUjhD4f6gnMtz5OgeA+Orj+?=
 =?us-ascii?Q?K+rXfGdR5xm/6M2ThTBwmER3ZhbbJ7HGhSy0MXatyu1ixr08UPXKXMNwycir?=
 =?us-ascii?Q?FELgRB6Lak8LLO4Do8wRDxyMPeh03Sawq1JkrEWZwfY7tOgAhtMe867sBq0/?=
 =?us-ascii?Q?6eMB6OEMco3jllcXDB88gQNJ8/b/suTFp0xYSCMyM6wPcdt3BOCmClTDYNa0?=
 =?us-ascii?Q?nBnIBXyRM7D1hVp/hDaA7DQOmpwgKpV+nbvcMkRrTBJhFHk0Ig3tC+zDj2wX?=
 =?us-ascii?Q?Xda6sFaBucjPJOnlm0bMhXyiCWYoF2oiPIPCqkMds97+oCbdqSP7YsiPkUoS?=
 =?us-ascii?Q?3oGsac9SANQUUQE2VcbT+b1a9c6EaRGLNIRRd5jDOc5042Da+LRxj8AsLKTF?=
 =?us-ascii?Q?jAjMEZjFE0h7TJR9gFDBNTYXrgD/S67mK8o5OoZZ9eY2SLNQHWTvosTp61TO?=
 =?us-ascii?Q?ZqH12MgKUOPePyH/+TOEvQPDjx7Dy/zseGLYVMT0T6sJbPf98eOom9OSTB1/?=
 =?us-ascii?Q?IWKU5HQkuBhSgE7bJAbN4HoHbpfbUWzlBja4mL64ezFnQClBjGLSGNCsQTkb?=
 =?us-ascii?Q?bFKPUHxR+sIY4rl1uXMvStxWmZlPpvzC48gvf6N/U9ngtGV94UWKBZqNYhkZ?=
 =?us-ascii?Q?nOxaY0UkQLvUBM4GGSuJsTWsqmE8iY9LI6VwQx8+no+2NfBuGrWO8Z6g5PJh?=
 =?us-ascii?Q?Om3KTgG3hwbn34yR3XLjPyOmK0GfkFAAL2I4QdlPxGe5G7x+kOSbcqgEk5RX?=
 =?us-ascii?Q?NKcvuFIDrxnrempBiXaNoUaUtQQ7yryRsP6+S9KjGQyChXHq2OXFFixugCNg?=
 =?us-ascii?Q?0TVQfBQwOYORhxctTk41LuN997oNIx8WX7rA/Nt0bI8PXUy8y/CzBcyPZPi+?=
 =?us-ascii?Q?ZquUTRiFjd2Pnb5bODngbHTmBllxHKdF6OnegYdRnxY3lXtZ+Xs5CTMOHX1v?=
 =?us-ascii?Q?OjxdYwfmzEXDGcKb0owIhulx1S9Mkycwr6zkg1ubl/6hDgZ/kGG6qFfLu1ie?=
 =?us-ascii?Q?gR4FxXWB06/2VCv350AWy/2cT2kDvn5t0jDFJsDRWma6ZWSBXDKTQpCFZvRW?=
 =?us-ascii?Q?h+9SJSr2CyVeSi6Ur5HpU6W0OxQn7cfkSNy42y0NKQla31u5gdVwJBrDmhjF?=
 =?us-ascii?Q?7qQLcXvAonHdJzqK25TVIX6+vr0MybsDbyq3h0C86HeTV/g6Li7aniipBmln?=
 =?us-ascii?Q?4ME6+Uvshm668SPuNzv3ZGv2xN76GG5efseW5ecICpEBkXPW98WjCT85Uoz7?=
 =?us-ascii?Q?c7UnAkXo2vXlQNYSujZtdT/h2OkugsZoXN4JB3lWlfXy0n3+sbjVIQE01SW1?=
 =?us-ascii?Q?KNSQFbGANDSeORaFIw1SkmKdblVCN+Vq4XlO5U7ejOzw8RQV6AdF9280eyVD?=
 =?us-ascii?Q?5zMaQ3NhKM0om90RfpG7xenNpp6OT15vgRP0bOibs8YJNfVzrg2aBnBBYrDg?=
 =?us-ascii?Q?e2VM/9joVHFv+UwZKOjcRV+uVI4PB01VsmpNBAGJEuDr8r7dTX35t1XeTmHl?=
 =?us-ascii?Q?/up6kq76PVmJyb2VduaYXTTkaplGxBt1nbhA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:18:12.4139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd56d22d-d6de-40d0-6b02-08dde122252f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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

Implement the ring reset callback for VCN v5.0.1 to properly handle
hardware recovery when encountering GPU hangs. The new functionality:

1. Adds vcn_v5_0_1_ring_reset() function that:
   - Prepares for reset using amdgpu_ring_reset_helper_begin()
   - Performs VCN instance reset via amdgpu_dpm_reset_vcn()
   - Re-initializes hardware through vcn_v5_0_1_hw_init_inst()
   - Restarts DPG mode with vcn_v5_0_1_start_dpg_mode()
   - Completes reset with amdgpu_ring_reset_helper_end()

2. Hooks the reset function into the unified ring functions via:
   - Adding .reset = vcn_v5_0_1_ring_reset to vcn_v5_0_1_unified_ring_vm_funcs

3. Maintains existing behavior for SR-IOV VF cases by checking RRMT status

This provides proper hardware recovery capabilities for VCN 5.0.1 IP block
during fault conditions, matching functionality available in other VCN versions.

v2: Remove the RRMT_ENABLED cap setting in the reset function
    and replace adev->vcn.inst[ring->me].indirect_sram with vinst->indirect_sram (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 1b5d44fa2b57..60fb50a03a63 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1284,6 +1284,31 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v5_0_1_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
+{
+	int r = 0;
+	int vcn_inst;
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	vcn_inst = GET_INST(VCN, ring->me);
+	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
+
+	if (r) {
+		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
+		return r;
+	}
+
+	vcn_v5_0_1_hw_init_inst(adev, ring->me);
+	vcn_v5_0_1_start_dpg_mode(vinst, vinst->indirect_sram);
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1312,6 +1337,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v5_0_1_ring_reset,
 };
 
 /**
-- 
2.49.0

