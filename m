Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A5AEA3F3D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FEE10E5FF;
	Tue, 10 Feb 2026 21:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZtQQ0r7v";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24E810E5FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho/CBw2tjK39Br86h7p1XsnM8n3FTVP+RWDOig/oO0y02/fBuDsNhatdIANQ8ZnIShC5EQWUWJZbH7kNwAIvPiidkPSPkI93PMlVPTsSsTC9n3LbWEqWBEF6C/Davk0dT6NrpQerIXz8Gb/E0i+ZefGsPeozSvQdw7SzqCGKxNR8LE5uPl9PPGcrdBXs9huqpbY+4hvWehLVS43J7Qo6dNvh9QHhRlvdAYPfDtdgLcqgXLvXwlsvVVTi+bPaonAE3Bm7XphBocq5/BGzEi0GtfrIHQ48xOgWTVCYZ+dLLLHA7iL91yHNoX4fZhtsphfwytRPG0P24bnynGht/LYLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3UzrHu21RrZX8ePpbruZWTFdsPIg5F0Z1VD8UC6NTQ=;
 b=Nnj4DvbbCrXCSivhmL5qxPPD2JxeGfWuQeyZbSZJo/Ir2xjj8Hq6iOelL6l3bseMnHUfKWEYFOcZa7cU/gHHCTzTAxpaSs1aEipiGVjnTws9O3hwtKAiI0FJEQQOEYNgj/KbENAnBN8xK8d77JyoOSKFhiH6Yk7DaYvGU+WAG821hhNYvUn09lGF7F1RBH32iCUF0h5ncoeKLcwWDriU2lujyw2IqnpEKd99vceCURGS4B6Fg/S0FdmQa2so+wtVezdfA5TJb9Di//XfIBgi9g1wC4eS+npIJyDPYdRlCvB5Puq7CG/sGUZiGnKBzweOWFdNq35AE8qlRIJiFBba2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3UzrHu21RrZX8ePpbruZWTFdsPIg5F0Z1VD8UC6NTQ=;
 b=ZtQQ0r7vjYJEOjAZHzjRE3waWV1/YRzZF/VObefA239izTP2zPnvNh0y6VwTpYtMbQtb5qoJ6DF0/XmGH3JI6m4QJFXaIbvYwXvj3tD4gSLcgt52R6+ieHH3v9AiZWDgAwtGNhllOgXJjn4NWY5pRGafOdGc9kGK8VJrID7jG1o=
Received: from BYAPR02CA0011.namprd02.prod.outlook.com (2603:10b6:a02:ee::24)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:48:06 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::50) by BYAPR02CA0011.outlook.office365.com
 (2603:10b6:a02:ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:06 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:47:59 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 "Saleemkhan Jamadar" <saleemkhan.jamadar@amd.com>
Subject: [PATCH 07/14] amdgpu/umsch: Add VCN IP init to umsch driver
Date: Tue, 10 Feb 2026 16:47:22 -0500
Message-ID: <20260210214729.80964-8-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c18bcc5-1936-49b9-f332-08de68ee12fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?43yuAYd+yztIjlPIq8UAOmXmxRMHc9j3mibXYBj2/ZZCf5rpIRopMXauV1SN?=
 =?us-ascii?Q?zf6SmqAaAPCDA9dTkUYI+f4V8zeAj3rx30Fead6vywxGi4ZfbEFUD7KOoFnf?=
 =?us-ascii?Q?+8rdEhSxzuaWmez2NFsPVT94nkXBbD0Ae3H0z4bGYXge9ZKBllxiv4nYt7uU?=
 =?us-ascii?Q?BQJPeD4l4u1F/q0hooXp+mqO9NpUglFz5SA+4fXr+FPSNE+zNCN/emd85caB?=
 =?us-ascii?Q?06DZn03EX4fzXniQU81+a8ZFNVmu77hyBrILYAU3YEYe7MR5YKHbBzkdpo2i?=
 =?us-ascii?Q?yiptteZvzWjwBuf/amYfQ9K0Ej469tGu64XNo5dSzPFXC8uq4+NycR1q6Hhh?=
 =?us-ascii?Q?HVZNo+v5oileE6bsEhWAGlQZGd6PED8+a23TjaMKEVfxHSt8iEWUroFNRbuK?=
 =?us-ascii?Q?d52dqDodxdE7m9WdMnGQHNdZypJ3ssHCAT16W/ezrUDFDc+6kvNFl8ahSVbA?=
 =?us-ascii?Q?Qg5PUUUwD1ftXY1cnDqHj9UHsO71grI/GrEb7kQ30iF+X9oM3MPJ6B4RuOhB?=
 =?us-ascii?Q?YUW31WdhfIIUyglwY9e3dvVrAL/696yik9DQBYKZeNKBvpwsgTafTd7VBSka?=
 =?us-ascii?Q?vUWfyDGLaEkJmAfXOOaJObpi4x1wSWcl/C7Rppofkc+Bnp2WPM2RcLXJf9dt?=
 =?us-ascii?Q?0vuWy+rz4F48mulHg0EQ1icDxgMekPZNSTRi5XNxQFOWw3LM3dk4C5tobjUG?=
 =?us-ascii?Q?86dNT0AmaGOvN5NdyyqAXeAAK2uq5hUgtrXL6cLwDxYJy5ZXuGiwfhMnjnfb?=
 =?us-ascii?Q?Q/c+LbrCIiele94mksm6zrN3QCai5u0z3ysIVSWELGI0jTpzNOiQQuyj6X21?=
 =?us-ascii?Q?6W/pg+V6XCfDaMpVE3rRw1Ghw5QkuMi2aar8vUsqQcnr2K2I9LJ8AGBv4SWW?=
 =?us-ascii?Q?yIxYQs751WAEVryHBJiVGi8zhghJ61Q/A9ab4s11zPPWEWEAky+eJXQrZhgb?=
 =?us-ascii?Q?JHjv5bHRr0y56q+d/QS5oSSMgYFe2j7NvKtB/ytS6deMLBOva5ZEF8+Xcyf5?=
 =?us-ascii?Q?RpqHasF9xLePpJHBviK7gvgmnaY7bD4agpCDLLacloj0hYZ4/SXbiUZ2rZyc?=
 =?us-ascii?Q?EIOD7ryHjZWTjclARgkmM5jIqxYqYzZMnPr0cXCW3R53YQmWcojrXzVBKn1d?=
 =?us-ascii?Q?wgnVgeMm1rekXHZwvuL48629UC+SoHo1ossgR5ytBIUTp7PfnBiQ8+1Negw6?=
 =?us-ascii?Q?Rwpo+Clhkh1C1Udo4rtghE7N/dkbSUKkvZJgW8d7SosFQ5ZHPSF/QDhY2lCD?=
 =?us-ascii?Q?zcpz+BsIqncgzMrLaxBVGn7buOVeRTEe+tr1WktlDYEQg0oySLOgL5UfZb3Y?=
 =?us-ascii?Q?5MH3knd9HjRUHU4NJXerhhIv2LEB+hMZYW2v77s6qu7MJlODBQWPFja/nPBZ?=
 =?us-ascii?Q?ETB2YIx1Lum9pAV1MlrUE9bmJ6ToqCwGGaydAh/DHXLF+yt9HjC+cXDxBEHz?=
 =?us-ascii?Q?kAb3pU4hUes7axXbhTYNdkqOZJAmlQdZO5qKD0ELzuZKk8c8Rx1ytcJFUW5E?=
 =?us-ascii?Q?sZQtEmXCchF75jS5ob4tAcJSIVfAaZ2YpfFKCnq77YxMxtkbeYVr65Aglx+h?=
 =?us-ascii?Q?yTVB2oRSuM2/QdLsiyVK4KGTNfUOjPbJLfNuh4dC8j5Z8tocU1Xho/CHHFKf?=
 =?us-ascii?Q?T55xMffrVPFsUJrm8W9xAmidR1rTjFEAevRxXkpgSVGSK3VdQj/j7pfHgBB5?=
 =?us-ascii?Q?RyrlYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ch2XMNBoTuTV7x5ArvxN7Aw1PTB4zv+lLGksI48W0Zm3Jvpy++o+zBuvwl7Etu2knhD/bxDWyToairiMLtkGeiJxhpeD+90wRe71TrUBFvSVXgrlieUkeFrK5z/XS0xKZ1K0DlZaBDlHbFxnvST/SRN/KJs+Qn8nc3LlO6DWuGmXPjam8pNYNTtcXrTVZYOXrzxOcZV/CKoLbL6iFt1UW74HwYBXjSqbM3HIiVIuJJxPaIUSlMSvlT99E2GxcKLkyuOdkqOjFhmjToNljtf9hrZqSdveNDPswWhW4EBnmxVuG+qbCxHgBEyuoiUuyz4PBSsYq4xoVJLR4L5toisyB6XQX5MXBqd/vYuy5m81hczRqfUHi6EyGxl4PFxy6x8JxfyQxixom67Ci1DmdzrU+bxO6Ja6DvdGjHt50+qrhz2hunTjHNCwstXH99DRzbcB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:06.1781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c18bcc5-1936-49b9-f332-08de68ee12fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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

Add VCN IP init in the umsch init sequence.

v4 - set the vmid_mask_mm_vcn to be 0xff00
     keep bit 0-7 for kernel queue VPE and JPEG
v3 - use vcn.disable_kq rather than gfx.disable_kq
v2 - configure the mqd and hqd mask based on
     usermode and kernel queue enable (Alex)

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index cd707d70a0bf..760285ad028f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -272,6 +272,17 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 	adev->umsch_mm.engine_mask = (1 << UMSCH_SWIP_ENGINE_TYPE_VPE);
 	adev->umsch_mm.vpe_hqd_mask = 0xfe;
 
+	/* reserve bit 0-7 for kernel queue VPE and JPEG */
+	adev->umsch_mm.vmid_mask_mm_vcn = 0xff00;
+	adev->umsch_mm.engine_mask |= (1 << UMSCH_SWIP_ENGINE_TYPE_VCN);
+	/*
+	 *  HQD mask values for VCN
+	 *  0xf - Use all the VCN HW Queues
+	 *  0xe - HWQ 1 is used for kernel submission
+	 *		0xe is just leaving the Q 1 and using the rest of Queues
+	 */
+	adev->umsch_mm.vcn_hqd_mask[0] = adev->vcn.disable_kq ? 0xf : 0xe;
+	adev->umsch_mm.vcn_hqd_mask[1] = adev->vcn.disable_kq ? 0xf : 0xe;
 	r = amdgpu_device_wb_get(adev, &adev->umsch_mm.wb_index);
 	if (r) {
 		dev_err(adev->dev, "failed to alloc wb for umsch: %d\n", r);
-- 
2.43.0

