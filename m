Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB695CA0EEB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 03:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F46B10E0BF;
	Wed, 20 Aug 2025 03:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gozNBuF4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBB510E0BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 03:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhgyE+07miobqj8rvUctz3k8EenHJ4X5QkAHlj89StCPrlYmtcLKiyi3UEnXFA0fz4cU9u0oICpZuu8Lxv3oyYMK3ff5H+V06ED2SpwvEbXhqRB3Uox91zBFZrDNogLC0Bm/4LNxAwgzR/bM0IXHUc5VdbN14njYNiaWZs6qXp9xCvknSFseimYmW1CnqBgTPgZukuEfdfAh8qHIGhIsMstrtgj14c9HBqdiZYaomYpaFWuWY0qVdcZJk3anjaeBk9yUokZz2ILV6/5ehO/AjXz76A92Yh+yI3w1BRW5tsA6v/G0xTfzmhvlKYNOk9z/p7UNAmnK0OBFLtY625uMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWFJRUE1fxKdOHC7LUF7W231oNwV2PKFl3Hdn8lVGuE=;
 b=gbZsVCkIM18yJbWpv4nYW/SOEBovJUPT0QwL3yalXpAZiH0FHxiNzD/pCsFEzMCoTrcQkPtfplEm2wVxuSBhtpywz7ptBsFF3nNJfy0rIr718izKPn784QlwY8rG2M8mFPPLYD6XNiBHwnw1x1ub3Tt11JVDruk6sg3TxLHqpPFO7dEZel5SPZAwrhHc8bQ75JFrED/ZYC3NKx4p5LQDmsT1S6Mc6kQlfi43UrptDLxAT9X6ya0liIb3qZ1zdViO+dq+IMiG5RK5AxmLAaKpwxNtQ0TPFRjbYCfF6Y3msIB7NKro92rnCmva789Qsp9T2CK6mqH2deIpIncE9tQc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWFJRUE1fxKdOHC7LUF7W231oNwV2PKFl3Hdn8lVGuE=;
 b=gozNBuF4rGRlA2pHbhHHYshi9TtBMuAf8y+hYU7HZRZVNGlvOb3fL2fCb2PnY7Gw+8wvtXWms9uPol0PY5FvmGDyIn6NAjflISLDvvNX2J8LZ6ADzJ9u/qeShr4nYdCMZLTDkqZIET00dnyQwyiz7AT93A1DJBzK5u+I1kk/kGQ=
Received: from BN0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:141::17)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 03:04:06 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::30) by BN0PR07CA0002.outlook.office365.com
 (2603:10b6:408:141::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 03:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 03:04:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 22:04:03 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 22:04:01 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v3 1/5] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
Date: Wed, 20 Aug 2025 11:03:24 +0800
Message-ID: <20250820030400.514460-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a984f18-2109-47b6-ff8c-08dddf9639e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pJ058f7O6ZbUaWTcokn83OOeixA43WULO4Cw7lALpIjVvNRmpJJYox0ssgb3?=
 =?us-ascii?Q?24n/WeM7YLmkjXjeQ+F3hQsrgQ7XcwS7E9PfJyK+busKv88w8H1qPfFPXjur?=
 =?us-ascii?Q?4yl9DM/bUU5YPhgMXHCtJUCowwxjoS8xOilpiM89u2OEgiCnyVmssWGRU55P?=
 =?us-ascii?Q?/W18gHVXMq9AT7koO4OshRPV5mAVOlPRfjMEJaetcxWhuMJ4IqS600ZaRKKk?=
 =?us-ascii?Q?XNYxHDubw7aC571LT3DonKf6sP6fbBOp9BQOUVwYF8OzRm09PFDPsbFx5rgC?=
 =?us-ascii?Q?s56Bg6RnPlFEZuUBIaNvyikh5xHOgVnQ3kGQiINgkTyjbdxXg3nR7FC1rRit?=
 =?us-ascii?Q?TbEtsikz6KY/0p8fxPYmStawEMasRuXTaqWESYzBTrUVKFOXXZAphAk5pnws?=
 =?us-ascii?Q?JJbmAV5pU9SiS2CgAUvpsg+QAu2M7g2t37S1gAAocnKMgoY/soXbMa4ajIDQ?=
 =?us-ascii?Q?nNVs8GVUn/9njfJWOZeBsVzpPI61Ui45KkJvz+3vQJCcQBK62U3Hl4xVBqtP?=
 =?us-ascii?Q?GiJadRP1z7b7wGw4L5qIioYYbftg50qGTBqXvug2kY8StFqPWFQb+sDzep5B?=
 =?us-ascii?Q?4a6NYBp9/vEFpfFaOY6a5efvZVpJj/Y3uMvmdIndArHcw5deqwxWmiP5YWnd?=
 =?us-ascii?Q?J4U8OeEV01vGgeCVkbSJ+vr7FwUuiPjYh6HgQF70m39UGQT8fb6xUeZOY8Aw?=
 =?us-ascii?Q?6YzUgz4kbygiyNdH6SQ+f/iBssp+lZolACWvZuX+dCPDHkmLBBePp5F7Z5va?=
 =?us-ascii?Q?VhzH3aTUOWPlmb+IACcbZ6hriqto2t9XOydZ49qCC0PuBh1WLMKUixcq8NA9?=
 =?us-ascii?Q?ARzPtbmt7QUEpl3XblfS+nLd5t3GzZAakhlKS64HCb836xsQLOhEuqRHbozv?=
 =?us-ascii?Q?BtRlMuEfTPemlyzaeqrlocIwJHvvjFWA8J7YCfquk+wCXR/2pwRTOm2JD7Ue?=
 =?us-ascii?Q?QADNBnq7RARxkIJqNdXYHINTCFVUso4GfE8wr4SHWS/d+KAXy08rAC6IMn3O?=
 =?us-ascii?Q?uGs1A5hsswCUNycYD8RUkoo07A/7rPQrljEtcfC8/SOzEtXg5DRh0zPqzgBF?=
 =?us-ascii?Q?C6hu/jjsP00NjzEEc+d8UV8+mb8Ws53xcXlTNReaJs7vjp36yP9EluIMzo8v?=
 =?us-ascii?Q?0rYxesZWf+4m6eODAapygblkR7Nlo6lAtQWtkWkPJ2I1uFusQWWiMuuQIvUf?=
 =?us-ascii?Q?yGPxYQpZ4u5wbF0TMSF1RpSWVbplh7LbLYSCdmh0nuKePGVISdsAjPIGCQ7v?=
 =?us-ascii?Q?QidLp/P0caHlAujjPNpygAvQW55LYOVOyPxn3MDnf/R5O3jzwK+7e3O2JKti?=
 =?us-ascii?Q?XbX/S3BBRYreq4Em5I+7m/GXLRe7nu1rbKNeSP09h1jWhlWn9Ucq9sroUhGt?=
 =?us-ascii?Q?6uIjhb8Y/aFhsFmLWubb62dFbWhrlLH+834XVAuguK6/oJUP+9e9j4nlNs+7?=
 =?us-ascii?Q?MI2SFL9lfwB4+MWCG5kl/vQwarng0BYFfIvBwf9X0aWTOKLvQ1xIIqYP06qQ?=
 =?us-ascii?Q?yVxNWYpTfvLmzwX44QWgZo/lme8qqJZ6Kakt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:04:06.5254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a984f18-2109-47b6-ff8c-08dddf9639e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
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

Split the per-instance initialization code from vcn_v5_0_1_hw_init()
into a new vcn_v5_0_1_hw_init_inst() function. This improves code
organization by:

1. Separating the instance-specific initialization logic
2. Making the main init function more readable
3. Following the pattern used in queue reset

The SR-IOV specific initialization remains in the main function since
it has different requirements.

v2: return directly from amdgpu_ring_test_helper (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 36 +++++++++++++++----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 7cb21e2b4eb0..1b5d44fa2b57 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -256,6 +256,26 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v5_0_1_hw_init_inst(struct amdgpu_device *adev, int i)
+{
+	struct amdgpu_ring *ring;
+	int vcn_inst;
+
+	vcn_inst = GET_INST(VCN, i);
+	ring = &adev->vcn.inst[i].ring_enc[0];
+
+	if (ring->use_doorbell)
+		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+			11 * vcn_inst),
+			adev->vcn.inst[i].aid_id);
+
+	/* Re-init fw_shared, if required */
+	vcn_v5_0_1_fw_shared_init(adev, i);
+
+	return amdgpu_ring_test_helper(ring);
+}
+
 /**
  * vcn_v5_0_1_hw_init - start and test VCN block
  *
@@ -267,7 +287,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r, vcn_inst;
+	int i, r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v5_0_1_start_sriov(adev);
@@ -285,19 +305,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 		if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
 			adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			vcn_inst = GET_INST(VCN, i);
-			ring = &adev->vcn.inst[i].ring_enc[0];
-
-			if (ring->use_doorbell)
-				adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-					11 * vcn_inst),
-					adev->vcn.inst[i].aid_id);
-
-			/* Re-init fw_shared, if required */
-			vcn_v5_0_1_fw_shared_init(adev, i);
-
-			r = amdgpu_ring_test_helper(ring);
+			r = vcn_v5_0_1_hw_init_inst(adev, i);
 			if (r)
 				return r;
 		}
-- 
2.49.0

