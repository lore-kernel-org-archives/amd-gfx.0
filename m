Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302C4C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 20:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DB910E0FB;
	Tue,  6 May 2025 20:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XIDxEc46";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE1410E0F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 20:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkUV1UqNTlugxcqfAJuIoTwOtuOeoeyjMqFeI8npthscPg5wcoAqw0Kei/iNeT1B3cdFagykyvy13Y6htq7Ski3Tsqv8OU+dFzg4ila4bRi/PLYQDCxkRKEHnWydxQ1QK3EV13IVUmz9Eway/Q7kpxBa0fb/qh4UNyU4KPPAQxPHzPJ/CeT9fsL2/2UiLWJO3hvvmLgW+x5DKGqqqsF6cl4i6oaNkHOqYg2qXqFYGyFqm3DyWNModmDw+DgUOOENyvj0UiFpZMn5mC4J/qojnnoTWsUnHv7vvvXw6O8hT72D0owDHIlL4VAxzI2OhB8ig4iBQgl5ZL2CM51dlkEntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9x4m3em8w1bVbq7inCe02P7cqaDIMR9U1pJzZ3FPUI=;
 b=dPTGMJitja3hYSsrklGNXKSGDhgJ/49FrmgL14xlmhaKb8UA5z6w0HKpCnm/GOC76jFjnSE8Yq9gKeuYInR6Kytr66CggESZ+5xbD6p18Dftv9+VN6CYDi+JBbnPp9uNXsafXgq/4f+nylybr3kfPfVpcLz1N7w3mMoSLWltg1HYQJWG9dkiGZEpHrvc803Ew5TJNaGpDjNMI7FRnGkyC9KwhXdr6qhPmbZwrq/XZPQE6i8Dv0JooE/0Gyz07oXaB4XkDWyhY+1KQLMWNxN/MIq0+1/UGN0G6Uw37OC4jw+kCgDfeoolHOsCPGRwNt9nac+8WL2OfYp7GIqVf4VDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9x4m3em8w1bVbq7inCe02P7cqaDIMR9U1pJzZ3FPUI=;
 b=XIDxEc46vBkm6IeU3qCNTNxLtIUS6subTtoFGR8wpR2f4aX1vg/RnY1swDTzf27cQGciwVUGC5cHVnR+erHjzLseASQoxOm+64xQWZbbG17FTrl82c3eJwbaffQ9jcV6VMCgehV4iyiqnavJc9XGIEPb4aAWav+FQaoGeJAf36U=
Received: from CH2PR02CA0030.namprd02.prod.outlook.com (2603:10b6:610:4e::40)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 20:50:06 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::9d) by CH2PR02CA0030.outlook.office365.com
 (2603:10b6:610:4e::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 6 May 2025 20:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 20:50:06 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 15:50:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <David.Wu3@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/3] drm/amd: Add per-ring reset for vcn v4.0.5 use
Date: Tue, 6 May 2025 15:49:46 -0500
Message-ID: <20250506204948.12048-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506204948.12048-1-mario.limonciello@amd.com>
References: <20250506204948.12048-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 2167e640-c4a1-4cd3-d6ab-08dd8cdf9500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Sj1j108SMIk3EJpri1MDk0FDB1n3K0TWXHz5w+QPb8ahpGvj+PQtUm2iOFM?=
 =?us-ascii?Q?lPQAikgjKSP/qHYVVGAOzu/4/c3OvIwIcKoM1YCHmf3HEVTHTN7BVuE6oXO/?=
 =?us-ascii?Q?U/ci/XKX8sQwxmiY+LqjlvQSfKNrwP3+cX1pb8NXgawNFoOhucNUVC3Wttey?=
 =?us-ascii?Q?aQ03BWVjQO4XXyMErxMo4mFrI7RQbPeb0DAwdNOI3doqBgWE1xT87oE12ddQ?=
 =?us-ascii?Q?bzJwDIOHTS0dYY/TOyFlIaH5XBifEu5L1NfMTFfaImoJ+tqX0RZT9Cqhx7SL?=
 =?us-ascii?Q?NYTdQzV/GeRDrMzWp7vwzhkUKCNPKEJahA73v8dw8i4nIanRgHjY5/BkN2cc?=
 =?us-ascii?Q?gtPqT+7d0Mz1ehyobpdiVqvDx/2pd6vP7AHnk8iDCvQJKbuRAACaBnT2qR2P?=
 =?us-ascii?Q?P0vnHxk1svnHrx7R7qZ3pe1TN1/z9Jgjfuro2rD6jUyG4GFnRIzXh1OeWPGG?=
 =?us-ascii?Q?oIdfl3aQI4/HvDiLDumTHwxrZIDIRAQ6qfomQrz3V6HnjpjuA8aOa73JF1Ix?=
 =?us-ascii?Q?BtZeyf2zmKm8swlyWMMHuImwEJqf2yuMMf6KWkO/oZpiExnRMhCROoHbrAgc?=
 =?us-ascii?Q?2uCNeJOfwsSXdP+IoW2s5pu42JGYz5Kj2pennoFv2ur907q4PmXZw+BNVk8U?=
 =?us-ascii?Q?WgcTMR+9ajqTCVAnAndTNdc7Do4gp7bLvVcjJKkoLd42cDBqCCvun6adEC+X?=
 =?us-ascii?Q?s4nEnEFHlUaPyi097s2jXdzvveezX7ZS6Q+fTTGHQxBva8yIdCbhya14lP3q?=
 =?us-ascii?Q?9OzbLO4po/aox+Z6gk/NmanorhLA8R6hFFzA7uNAAo7c+gGVwE12la4yGD3O?=
 =?us-ascii?Q?DUzhL3CcROsARXPpfbJVVpRm03LNunDmMEmdpDAFbKzxo/eSb4w0QE6Jw/mc?=
 =?us-ascii?Q?WopRbPFYMXTxIceR4Wv39xbBzh0oAh1cmqoimQ0WmZHmydtkgU8Rf7Wb9/eZ?=
 =?us-ascii?Q?9brOtLp50vnAGikjlHAn49hNA8pWR3EcFvh8P/uYOH3cNtbOT6T6zs447ued?=
 =?us-ascii?Q?q//76FZVpvanBl0AmQlgxaST5cMcaupZ/iD24GTwnHtc1nBrOc8VmIrHiDe1?=
 =?us-ascii?Q?BCZFKkAVKgXoJFM2qGtNaqVZH4/YC5hEs/lSXjAZlc1sXveKoUeIHJAN/pe0?=
 =?us-ascii?Q?3rpjFbBLQvUjWA81G4DplVer6VGUoovjENjIJKMdqeRJfEucTbhlhxjNRz6L?=
 =?us-ascii?Q?qjV/hJgxwFq/bFsQM+kGPHjT3O2rDqlCjdHomVWCrzflerSGOCHlylFenA+I?=
 =?us-ascii?Q?zidztqg+kIZdZO6nL83i5b8Vzo+S/ujNEZGkYTRUjkZNIpiFhsaukw6zhYX2?=
 =?us-ascii?Q?lM4bt6ZjzE/CCIns1xh8inj3dN00ybs9dauBiEDw7tNWbQvdgEKUP9yJICEk?=
 =?us-ascii?Q?jQGXns4X5rZyobo/xZ2I5wWyPNrW8cC/S6Rd6Pbgk3teu+LnKFl0p7sv/u0e?=
 =?us-ascii?Q?5Aq8TD+LoDUcbuK1uMQC7ZRV/EM6N+S8IWMzIQrzIJZfVnKdhQB3nQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 20:50:06.1069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2167e640-c4a1-4cd3-d6ab-08dd8cdf9500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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

There is a problem occurring on VCN 4.0.5 where in some situations a job
is timing out.  This triggers a job timeout which then causes a GPU
reset for recovery.  That has exposed a number of issues with GPU reset
that have since been fixed. But also a GPU reset isn't actually needed
for this circumstance. Just restarting the ring is enough.

Add a reset callback for the ring which will stop and start VCN if the
issue happens.

Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3909
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 558469744f3a..ed00d35039c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -219,6 +219,13 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_5_pause_dpg_mode;
 	}
 
+	adev->vcn.supported_reset = amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1440,6 +1447,20 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+
+	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
+	vcn_v4_0_5_stop(vinst);
+	vcn_v4_0_5_start(vinst);
+
+	return amdgpu_ring_test_helper(ring);
+}
+
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1467,6 +1488,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v4_0_5_ring_reset,
 };
 
 /**
-- 
2.49.0

