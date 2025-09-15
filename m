Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A74CA0EE8
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 02:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A164E10E293;
	Mon, 15 Sep 2025 02:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S5htQzQk";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F0410E28C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 02:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRtnVGjMulSxhqWEOF6d3xqTl1DKSTZIwKRZVIjTyHV13y4fG++8LNlsjHUXiSWmZx1rF1NmBI9HlWTdMfDn+P1XG2ZZulLCzvjNbngJ+WW6YWTVNzrvkMDkXiqje5OYqQeEblPGbY53DxjE22qg2wpNWMPH7u5HCfyQtJz9XpnCAIgk1n5nN4UQX3cquFqxs7W7c1FnOKxCLN/GTU0OXySQGdG1Lei3u38uCHFybmKjuM/X9JARB24WS6cjKWugMASXHdML0JGf/pVx7O19ugg5VOjXK2j5D6GU6MEX555xbLTib9Y39TRRFxT8UkwtgJi555g80OO2TIFdEmq0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyiLdIzVOTecuqvNEp0/wRB09JclT/m3RKypwa9kGsY=;
 b=aeKQXq4RgOcylduDPXHmdvZRaPxaLnN8UUgN7IjtdT42JVdgSjZX0Mz+hY5rei6WH+0g8jpGOfkgIW+zqVIp/nMfHdSeqqVFzR+gyFT9XIkbDx/MeMFBwphLO/AEbHA+xOUVE4q69u5G7cUFRA/AAL77cggE4RBp2nOqCs6WjeiI5SjrnoeDyKyMLQKz6I1+snUMVIoN+uFjprXqU6GJtAA66+/+7yT1B7lzBzo1DqDA9nT9FgHiUKL2TOhDHSEZqhd44r/KO2CSE9Eac9PMfJUwQI+voVuNP1pwZT2NhTKmqqjL2Bn/SaletXR2DSLKJaD98za53x3SlMc0J0Sy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyiLdIzVOTecuqvNEp0/wRB09JclT/m3RKypwa9kGsY=;
 b=S5htQzQkKDlb4/UL6cIq3pAYZmbpmTkm7cBy0g3SQd2YdanH4Z9UKAaTLem9WW3cD3GhFvQOjAQSdPPe0tQZhC+wd4V9H4tlX/wd25phaS7cu6OsYoaj8qhIAX1iZVJZ6g76JnmP4Zn4F6y0hCVIAbfUtwDA9SWsYDAdi6WbF0I=
Received: from BN9PR03CA0197.namprd03.prod.outlook.com (2603:10b6:408:f9::22)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 02:09:32 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::80) by BN9PR03CA0197.outlook.office365.com
 (2603:10b6:408:f9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.19 via Frontend Transport; Mon,
 15 Sep 2025 02:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Mon, 15 Sep 2025 02:09:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 14 Sep
 2025 19:09:29 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 14 Sep
 2025 21:09:29 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 14 Sep 2025 19:09:27 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v5 2/4] drm/amdgpu: Add ring reset support for VCN v5.0.1
Date: Mon, 15 Sep 2025 10:08:44 +0800
Message-ID: <20250915020924.137122-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915020924.137122-1-Jesse.Zhang@amd.com>
References: <20250915020924.137122-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: f0edc54c-e214-4de7-1b4f-08ddf3fce933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JFSi4JUt9xzkm0ZhIRPYV0f0CYY4SOpLLxBvVLPaie8ME6FpCJmX9suI/aXy?=
 =?us-ascii?Q?61cyGbBPz89+ZvZxOdUYdIPNK/hLArqgDzVCz3tLS9wbfnCfFsBUaJ9vvOT5?=
 =?us-ascii?Q?FqlkzAaoZFsidjFyLk/e9wd8OhJYNDawV63m9EPEIZiRITxGFBoSUpaIQg4f?=
 =?us-ascii?Q?ePV5/nThX3dlZNvJRBucTFHL+ncT6jmPd1parZP4xe1l7eQfUZ+AqFl9a5Em?=
 =?us-ascii?Q?i0qR92HAU1SeaLeHDBGt1vGbyI3QDymbEFeXCtdX2swnGsxmRKbtGDAbOy5F?=
 =?us-ascii?Q?yJjUJG8VfkRC62QwyYv75pbZoIQk57gDgI9BZD6QEYaq9D0IJCGnBySpF27q?=
 =?us-ascii?Q?2jWd6t+FeN5MfU9Su/FcizGkaq7AdDEnO6CTKn8Dpw8kpfYYgYeSjrKqsFiJ?=
 =?us-ascii?Q?6w8UHkS7ec52tfvCMbTbh5G1ukyp+CuhB8gKlqAYrhalfnGHZtdDeyDDprwW?=
 =?us-ascii?Q?ZRllNCyqRwmIEUmGD07XUrOGaimaEAmbmn5ouP04aEHhshzDOy/55WPNeDMC?=
 =?us-ascii?Q?5ml76fs5O8kmNTK/GOdbLIXQjMcylz0XIqE4YcIK4we+BapcW6yWs5VHrhF9?=
 =?us-ascii?Q?/YD7/o5uBO6QgD9Qs0hDPJwMQcqcuOWosCaeYUvzQE6cyEAZP/25/u+bWIm5?=
 =?us-ascii?Q?bT2rNsz1AGGs8LiZB1g8zBx9lsBGmkX6Pu4T23ysiTNL5g8iBs4lrOH4zWkS?=
 =?us-ascii?Q?joPH9+h4ezRGcFmuhmRIJYVugXFt59XYbKFIk5ZwjyqQ28R6LjDn+yN4T3jr?=
 =?us-ascii?Q?I8Fort3OpqW6DBpV4q/CpbB8eXShjSrkyIzxDjdMRwcFhsyKgRqyD1qus49s?=
 =?us-ascii?Q?jm/NWt4T4kWVXv9zL6sZwMXJjef5/4kfGniJXWmUlCtxiJeZm3L+5z5MDvIy?=
 =?us-ascii?Q?GZ+auHugUPz5AQ9VozDsfYsuP2z0rhtsX0NMuEOmxgCAjvQvjZbL/H3e1wLu?=
 =?us-ascii?Q?VxPdyGdu72JhjcVZtoTgaLNW1vHdm8UQqWJKYvH5+8nmg1lyLy5GwIblJaJt?=
 =?us-ascii?Q?Z1/UykzgyBBBANcwk7rB2j2rzUoyR5y55lX+2HbrU1Z2M9+Ztp2yW6Rs9FSy?=
 =?us-ascii?Q?OCTCUQxlEVn/CUES+6OvHYDgPWMqqdhX/02Dx3bQ55OEUtrliii5Fa6M0aFU?=
 =?us-ascii?Q?ICy2WaIlpCzMpyg1+QFIcBCqMn0gBgx+4nE7GXXJfOFF1+JqluFxBXicw9u1?=
 =?us-ascii?Q?UPfG9YsC8BwN9Uq8qpkuclV9jR2D+gMeoWFymRb5UdcDRGL3fCZOkkaEtVEN?=
 =?us-ascii?Q?KXbGr/LoPF/QHcLreUFu83MzhyICs49xdWCNgTrORaanGIgDNHYvHSUWNMRM?=
 =?us-ascii?Q?LFpMKUFgTLdBKSwdzlXWdqqBi8RYYybaumCgWZFsxZATnuh4nkCKzs/0Jd+3?=
 =?us-ascii?Q?hW0eO2lkPbjEsfbF6KJRB+tpwAqMESf0sQqAfEmZgg3okU6fgx1tc1uXvRgk?=
 =?us-ascii?Q?xtJwcFo/M2ZK9Gzk3a5FgPYCqAKUSZOh3DvYo7LSWfyQv6SvXs4wdAIdgUu9?=
 =?us-ascii?Q?uicoVl+xuYoP35okPooGZncgQVr0eAaTqmuA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 02:09:32.5799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0edc54c-e214-4de7-1b4f-08ddf3fce933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
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

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 3677ea9ffa43..11b931153ea1 100644
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

