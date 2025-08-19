Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5959DCA0EED
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 09:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA91410E55F;
	Tue, 19 Aug 2025 09:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L9k0rcnC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE31910E572
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 09:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+Ep8Me6QXFUmk429MlwoHuTygWHvw9iYm2N3C8jiMOzWfPBUXjMM+a52R179YpwXtaLnEUm5Jbuqmh/EfcdqEHQH0tMbzGXPLZphF8GGTtfgseVouT+FUy3zADxwnAj1YWYQ88rjO6fVk/v9W8wQ4C/15PVLCjtjrNF6OAVMoTkkBvKYRQFMUkfIn2OZpgLi+f6/BZ3Th2S8fPBR9Zx5ys2gSWcvQrXjCtp4RcpqPY29Vb9jor36204XSZd09SUFBUYpD9aqWebTdM2vN3pI1PZhmdMwDbLZV+jzSp9iqyj/yYOgtzbeXnQhld1I44w8DqHWPzeiG/RPYyzjVdRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msW8eG3jZtPOVB2aYozjppIkGCcnfeudFhZQIVdvusE=;
 b=Bv6d3/CSmIvgcV/3fIFnM7DIC7bekUC+JZTiCU6X+4NpDbzLjKKhgu28qo0LvRy8mdj0UO+TG6loQc3WTpF+x53QTagaxOZx4+432HdCJ1dkH7dsLPFY2/94iCnV3ESwNgobY1Kzz1vGTYz896kvqhhbqaWESZ538pmOnOT6vUzcGRd6tJJbUtTSQvvBuYHrnBwQ7BH2/39+tG8Yci9DBSY+qPD+SE25owi5bSBGYRNbjmKKGRP9SCBhvn2Ny44DajolawyyhBS0Ratg74YBMyKyQXXDiZVs4xVYuAeKkITTeaHKJ5YPU2pZaEzBjII+bLel16E1mO8tyfSFJQF/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msW8eG3jZtPOVB2aYozjppIkGCcnfeudFhZQIVdvusE=;
 b=L9k0rcnCW3mKrjROyKDI+Zj4pv1f2XDqNv8DQB2Vg/yBBcObuyCym7DKKqG7ghLD2PytWwPsuIwq6paZ12DckLr2TvPVdjnycbblUhpBnoTWyHRC4mvT47BgASzR8b8H8Q7lgqfATxJfuN8uFnHg35NqVx4Ytt0AiU00Bjz234U=
Received: from SJ0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:a03:333::33)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:18:11 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::37) by SJ0PR03CA0118.outlook.office365.com
 (2603:10b6:a03:333::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 09:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 09:18:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:18:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:18:04 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 04:18:02 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v2 1/5] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
Date: Tue, 19 Aug 2025 17:17:05 +0800
Message-ID: <20250819091802.445099-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bfef0b-66ac-4032-09a0-08dddf015179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BirOs9rjF8Bw9UHF4cR/hbscvFPiUGSfy4XDYJg9mosSG+k61GlfYa+TdOxL?=
 =?us-ascii?Q?TJ8D2zMrFLicYw7UlBcYBlru59MHdkYNsc49Qbr3p6U5Ynk2LQU63FrtvuOO?=
 =?us-ascii?Q?BbmPxTFAO/2hP3yPHi+MKi8+dNYTu8FYQMfdHFT1kbX52kbKGGxYhnPuz+5Y?=
 =?us-ascii?Q?Trsc66kCqemwe2nr2lGHlQgBn5GfM+HT7ApXjU1s7i0GzTJ3jOHGpxNo1wdg?=
 =?us-ascii?Q?Te2LfZMUxvycmgyQl7I2aqRNLUnoCD7uQBvNinrOuKzM2/Oehq78TTdrRIsV?=
 =?us-ascii?Q?MhYEk1Eg3VjCbNW1IAocw4aVlZIOiwK/pCsHwB1bWQWEL5iYd7so+gRFqhKz?=
 =?us-ascii?Q?3ZYFeBLd7OPxAVKlc8iQHvH661n/cSmfxyV9DVPLjxhDUSj1l87MkVm/CQ3P?=
 =?us-ascii?Q?kskB4Y36MxhZKzf95gHSbHTotDo+eDPKvKUgt2ErQjj6x+prGR4sZZkRERAB?=
 =?us-ascii?Q?6wL4oMnetDEaqTPUzjG9AiZ9v5itPrRQKm/RNpetI+TR8KWDcgI4UaZqDZi8?=
 =?us-ascii?Q?LQ0tfHaqoA6L9x9uMxCUr1KXut4DhhZzcJgnAp9w/QjbeeMuIzu1yeZL14Gi?=
 =?us-ascii?Q?TMFD6nWoWlV45TiVPRNg8kulZGUAUHhTt1ge4zMkCi3g/hDdx7T019QIbegM?=
 =?us-ascii?Q?ziuVkZLU0/ZM29JjPqdxUe+UXZtZLWhkhZPvVBO7aND3vdQRACMyvDWhtRMM?=
 =?us-ascii?Q?HD3yG0qwuDhdsGkwX6BlOB2PK6G2gCE4eDIWWJXJcy/O8/V7GI/piQ/bqLTS?=
 =?us-ascii?Q?QLFR7yAFOdswU2ACMCnRncaWshpwNqBtT9LQeSm6yOnFhd/QaWg2b6NNbxkf?=
 =?us-ascii?Q?u5TMghAgf2Yoffem1/1HGvzSjo4m2rb6sKRqZyOkxYcsSzXPC+zYiXgqsgXj?=
 =?us-ascii?Q?MYXoJJaNCKGwqyuGhDs+Q7jkNIuSdv61oqT4x60/yzEgUkXk2LkGRv9DOpvj?=
 =?us-ascii?Q?YXoRsX61A5QtSXuBQ0N9etCs7esghTsBiptDA3fcAg7fuWfvrK1+T1ZbR2ey?=
 =?us-ascii?Q?yhwGVVkVJv6ZybYmDx3L5P25wIloPfTxBAoUxYlWWJ5Lxhz1ilt6nBr00ndf?=
 =?us-ascii?Q?LzlxDBmPwxbdPjeTaklgqdLaEyunM4VSwQLA7coXhFdeFhAnAYpCrJZ5THja?=
 =?us-ascii?Q?a/q4V26AQEJlfoKq7f1TCeJizt51k+4LeImvjafpy5jcDnZDO9XCemPBknLe?=
 =?us-ascii?Q?EJi2ACV0Np+RHUrJURqdeKlT+6a8nHuCtyz8VYC3nOKXk3GfbJhSrMAiJ4WS?=
 =?us-ascii?Q?4823dp10GgFolPi27adhWHqcqfj2oRZFRl/pKAPTKj4Qw8RhIfiFpfl3g8hB?=
 =?us-ascii?Q?9yHkFxzwJrZcC7oYXLBR8xLhSq28uhYPPJstcUI/W2b9cowgL0dXYxYUEdFR?=
 =?us-ascii?Q?Ffeqs9zq2dH1nmYD2GaZ3hgxyDDvMffv1lfbP+TWOitCYJBpzCto84HktJuC?=
 =?us-ascii?Q?k+96OZWZI3XEWvsyp8nmAvS079Ci+fPvTQXJp545lpp29jY0+BhBQTtvukdE?=
 =?us-ascii?Q?kDutbNrpEYehXwfbNFf4fk0Tw2Ijm9zwV3jY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:18:11.0662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bfef0b-66ac-4032-09a0-08dddf015179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
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

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 41 ++++++++++++++++---------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 7cb21e2b4eb0..21e48df537bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -256,6 +256,31 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v5_0_1_hw_init_inst(struct amdgpu_device *adev, int i)
+{
+	struct amdgpu_ring *ring;
+	int vcn_inst;
+	int r;
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
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 /**
  * vcn_v5_0_1_hw_init - start and test VCN block
  *
@@ -267,7 +292,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r, vcn_inst;
+	int i, r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v5_0_1_start_sriov(adev);
@@ -285,19 +310,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
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

