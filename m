Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37ACCA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 02:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E0610E087;
	Tue, 19 Aug 2025 02:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EL2hFq3L";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8814A10E087
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 02:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuOetjHxVgIqdXOkopoc6+1YgwwalRk3tvKLluSs2VrnkB+kpTKApqmPROPyny/jwhgM0KZ1O0noO2CJtyKl+aY4RJzjT5Dhh8J3WHe1Y+VOzQO4telbIE3smipEEL527dhAIHLjl5rKilZCI5clPa2eu4rxOStgYBXg27p7/jozkoDooeG8bo7O19t7hfFU3uBHze6MfvYFGYX+9GidZFS8WHmjYs/XgSWZRaWnY/CIYbhlzJRzTPy94BEY5v8lbVkr+TwXvKneB5nCNl5w+iOC5zz8t6MUNBzBz1XzKpjLa7wbZ4YTBnsvxFnyGKAV/xG2HEz2kZKV896woPg03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRn23Ru7LesQC2uFrMr6s/hRww/2GHuyOSZFCYdET38=;
 b=oWfTeTRj2VV4u7t3EjHPzcfYC/3DnzGiZNIl7f0I7v+tdzTMlyyZx1ILdv8NwJ2Hr2v4QmwHTp5SAFINteQjcNjSu+SKbXZ8B34x4K7qjxGnF9JjFDQkSCV+4NvYJvuwiWPZ8WE8fw9gleJTw6mq5ILKx1hud1n455f4YHit/jeO6FL8VMzizRwgEYSf9w2Jhdv8blfGvFXnmiPovB0l4MEGz62h7FFSweKhUStdo6NlPE4lTJXVCUBQPuowQkiqKmJJhmCq7ycMPHxsASsE35GqzDWBE8/LFn3BC4ZtWgk1ZWS+AWjO5MnkznPmE0Z4zpC294UMuL+8E+t3k2Ss2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRn23Ru7LesQC2uFrMr6s/hRww/2GHuyOSZFCYdET38=;
 b=EL2hFq3L6ucl37L6TbEtnp6e3CIGABK8V/gu19y7hCXyLrByP35vqbdgkZO0z5OPxg2FiZNsv19QynwWu2T4KOv50wjEP/MsQJS4eDBvBddLKNJpA9bUpm0KiAyxjYxrTCPHGICKVBSoSO6jK2NzEAjjwvz+22IWz2B8u0m86sI=
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 02:15:16 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::3a) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 02:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 02:15:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 21:15:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 19:15:14 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 18 Aug 2025 21:15:12 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
Date: Tue, 19 Aug 2025 10:12:20 +0800
Message-ID: <20250819021511.4002952-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: 53256a5f-7992-420c-e90a-08dddec63c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tbxz1HlfyiXml6+FMq/c03w7ju+etDG97OAVOHJIx1QgkB6cKrO3t6VaOvhI?=
 =?us-ascii?Q?Sbldu/CN8CnmUGKQ7VH3GyY2lO+4R5NVPbkzqkVzvAX6n/nCJaoa4vxwBQOW?=
 =?us-ascii?Q?mbsMQ6f0XLXP7HTN/jNJu6gvfEUkQwKeIxFHQXB6cOOMwjD2R1GbwhAWyd4F?=
 =?us-ascii?Q?d0P0luzIdu+SyIdldVca8+HFJzhjTtf6pKrZg6XliNI+9m8JrvjdASFQzegt?=
 =?us-ascii?Q?eFFGB4dngdsWwfWpCOqWfrN472CS80bCNZ3nJZaLxStKetfBFDz0/GmNGAUI?=
 =?us-ascii?Q?hrfm3HI8lkMfKXviuHiHGpgYdaUl4AQmGEHloJCaGAVXIrLYaBXcKWXfXoLv?=
 =?us-ascii?Q?Vdnm7mDvEfkgPWH9Db5QopS0GF3wuqtI7r47827mvJtbDsRBTvtMoMyd8emF?=
 =?us-ascii?Q?tM3rfmcExZKMFQBLTB9aGY9GsRK0o21p0RJRfHXM+E6UOJs60wAhVJfashGj?=
 =?us-ascii?Q?MsmTeTQ6+ZfEGE8XOecEG5Vx5alcFcsyuFWPJvm/WI6a9ImgTuEWXofonxbe?=
 =?us-ascii?Q?JAdq6eeOm+5pqNW0pgfuandURt0UNNAoWA4h7JvN+/NfWuMwfjKSJQgHyz97?=
 =?us-ascii?Q?n8yMb9izbgUNuwnAbZo61T6Mna2JmoKJN7XP2w4UdGRMpR5xR7zvtd6EGTqi?=
 =?us-ascii?Q?YB/UnNQG94GHGIKNH9qnAjXbsRE9vayA3jGIowytIYZg6HnyAN+R3HWqCzP+?=
 =?us-ascii?Q?4GQZKaHRNoO8dEjICivLMATZG5NCXukEftFqBipcUMfTF4RGqvgzxuTzX/ye?=
 =?us-ascii?Q?b+Kqgb+qaBUujk+5l2p/IKkn6zDDB3NdjmZFuuXJUiJsAAovyxzyIaSHzqMy?=
 =?us-ascii?Q?flYETMXJSBcjkVgeRCuIj1eNGnBkJAQXpZ2ss2h/Nx4KXgB49icFnJAX5USX?=
 =?us-ascii?Q?IhWSBOPU17p2lRjb+pW9LAUXYn1gWGgK9KhEvstFSc5ZBBj5zgcC/Rtiy4nJ?=
 =?us-ascii?Q?mBeNMlnmhvTVdxka/DD5Wviu4N4uirzdP78lAyHXqSTNgogi5geXQyMenuCA?=
 =?us-ascii?Q?ZbC/dcGGwNY0XIFUe30uyLjKrYdTKLI9eT/aXH/VeEPcB3AeJeYasjqVtuOn?=
 =?us-ascii?Q?US+SQmy0jqFrL/ML240YAUvkxWcNNymBFtgWz4zHV+W31Oftj+pnglhSPKEj?=
 =?us-ascii?Q?sOZzoByh7SS2fskJAVFM5TwqusMln+V8kQkgyUaBFvjSRJ7leuELOvHqN70W?=
 =?us-ascii?Q?/QuSSFjJjLVTaVuiFaEQNuy5cp9kgHAEE0PpzEIJlBkR344qTBX2thOscS3n?=
 =?us-ascii?Q?KXnksCoDpeu6LkVOshUrfsrQprVDrUK1l1/ecEapvTxE6FqEaG6hNX5j76NS?=
 =?us-ascii?Q?hoo7hIADyMmWDeYj0EXhpDVbE/Z0/fw5Pgf9mNFr6IBgRWJexMRmwqR2CiVL?=
 =?us-ascii?Q?6hznkhh9ZaDUwv1pAUyEYd3L1810cRLa0+KqEhc+tdYkKTgz+c+kXDC8S4pF?=
 =?us-ascii?Q?ErwXN4XNAduue+ypiMoxdR48g8ytEFSCavc6q3T+Y5b/dPT2aYkFMiVCiSFS?=
 =?us-ascii?Q?zNXBMSAMwc6pChg2lXJZfrhx4JFlPayzjN3b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 02:15:15.0649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53256a5f-7992-420c-e90a-08dddec63c3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529
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

