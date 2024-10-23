Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6E9CFA474
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 21:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FD110E861;
	Wed, 23 Oct 2024 21:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ePHPqDkb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DA510E237
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 21:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmseE9MQk3g8ZlcbBbbh01ao3O+PBAr4DMAMxsEBNxOdtPqb3Th8GkGPnk8hkqjNh9R2O+Lzleua6hw2+toE9tiziA6yJyLXZFGpuyqEfYlh5KzOVpo/ThNhIG+2htz2W4G4LZS9ZSsiTm3EHUJAypqQM4T7TxpDOrJY8NoZmKeXDqaJQLeLvkvbSj02cmvLKq4+nuIh0B8v40uq8LPO5uMfL3/xh9jl95VHk2e6oZ6B7NVkWmTWB8un1onVzBYFw6V3Kb9ahWAKFwrWdNWGf+4V8Yevc34F8EyrAhKvusvmlqqGnoU8QMoXVniPn3Z558Pkmv8cn3xuRdLNVWpgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diZRhkUP5P5NFjJ7zOVk3JFPiszkq+4S9q3pawp4ekE=;
 b=uAk3ZA0TBDqfFbv6g/F12zrDjZq8/BBfrQUHfVFtsOKoFDSp3syL1OFEy8AIRrNWy7Zhy1OFtx03YlPo4MSPQW9JbbpSDuDnzqVfYi9EIBHoFtgbHTDsW6e09b9KPeOrRyNQ3DXv5kpLcx1zRfF6lkh+21q6V7JsdlGFxavG1YDISjqlKkQvfGPi9nsXfHPsN5HNfUd4nT0oIQw2KyLNRGpcF+6o5fRG/VLh7DLe8E7HqUtHsmSZXCzEo4TGYkykiQTg1ByHgqJRRD5SYkUj4RFgQ3i520Ey/NLxuLQglHjTylFhyjMlOKQVvcMyY5HoNbznWVSvHXNNAWQBvRLu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diZRhkUP5P5NFjJ7zOVk3JFPiszkq+4S9q3pawp4ekE=;
 b=ePHPqDkb5Mm1CfsQaRMM1DX1/F5WZye4oDfozhdO2UlRGHCROIKeJqNoOnhb1Iqi4xZwhMnrornyEbHEOALoWrgamNxsi93QoqeUNSy9mG5dxCRKkxH5c8APYx2HIbJVjyYnOTx40ujBr5qvUJTUkv/EKTItrc/CMQM5jq35bVY=
Received: from BN7PR06CA0070.namprd06.prod.outlook.com (2603:10b6:408:34::47)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 21:03:58 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::45) by BN7PR06CA0070.outlook.office365.com
 (2603:10b6:408:34::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 21:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 21:03:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 16:03:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Adjust debugfs eviction and IB access
 permissions
Date: Wed, 23 Oct 2024 17:03:41 -0400
Message-ID: <20241023210342.685808-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023210342.685808-1-alexander.deucher@amd.com>
References: <20241023210342.685808-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: b2af8c2b-8047-4d79-a52a-08dcf3a63614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s3KxYJfx+TcsDieXI3eVJh4gWvvg8l48Gn+bywx1m8YaoZJlM9meSOP9uA+C?=
 =?us-ascii?Q?o7CADczuslH4URXx4RZ6BMcUCtugPWEC30C3ZnXw/7rSNDHrBL6DRrhfGgxe?=
 =?us-ascii?Q?saNgTpIrhamzl8A9tKPbOag2ccexvq2zD2RvgWRxZpAZ3ohnAbY0vJCy4Wri?=
 =?us-ascii?Q?0aZzmG2p2ak18gg2jWtQrx6rQJ29a7fgoSk6ZLo7gdFcTlDgW/qn9UyaR3sh?=
 =?us-ascii?Q?0pR3moKiT2J0O02UkI9RaFnD9DyUUEqHNVjd84EcpcPQzttWegf5/ncxFYU2?=
 =?us-ascii?Q?VqLhyP8jLc6xITfT5EPSG9XBQE25ctAQUcFlxqOkAVBnRlAkVDBfEFaahN5u?=
 =?us-ascii?Q?qZVpxs6hOAw+ujbhoIXlyLg4JyhnzQMsqE8krbZr7gbhm17hiHk10k6HHV1p?=
 =?us-ascii?Q?7LKDAyKyGzHGafkZPeZ03jPr8BN1o76tK02HOL+QL8PC+Ser+W+iILUZzLO6?=
 =?us-ascii?Q?KdlTYNeLHqR9LsNikwlKxLGusynwD+YqlgLPdUSsM7yCppb1a06KUbjCZcuU?=
 =?us-ascii?Q?tuHFXBagb+2ZYe09CPnmzamZNsj2hBkxrxyArrt4oPmP3JkToon2WxbdTuDh?=
 =?us-ascii?Q?q7lBxkOBifkbIENzydfjSIfP1BjLriKnOOpVAg4FU/rc7Kc61ZprBIjWjlfo?=
 =?us-ascii?Q?o5IXexPL9g8KYwDqYBXyWCNFYJviMss++ZOqGR1zzxIOmVprnSxemFXj7I8a?=
 =?us-ascii?Q?u71QvkIA6In/dKR5sFSNWERiIEPlC1zYFLvMf/jLDwJubr8ziKGPynyrhIh3?=
 =?us-ascii?Q?54tbCNRLyOywM9beEoM3QAfzhrVKjvxHWSESYpIOxZddCPtQL3j2VeCORS34?=
 =?us-ascii?Q?AXmE1LYd3lVlXMklowK8gQbkbKDu7YVcxBgcFE30F3prpHEoBRgJHWqMdyu6?=
 =?us-ascii?Q?HT05PPaLzJZHAFkPa993Quwb1se5Thx1g9rdDR/+6uM62hfPgWKr/d/Fa6HO?=
 =?us-ascii?Q?nO9ZbPt3+DJfNZbMCjO9BIbPFTxrhGXAc8VEbLhU0NYWp/OmQun39fTpo08L?=
 =?us-ascii?Q?yZYL5RQPZdx/TZCXXseA15lhWOzkV0agecadYmFN1tX2MYZ5q1GgYRYP7Nwx?=
 =?us-ascii?Q?8iOzsy7gtSvO9rSESHAtj6Fl6RulUOPfqANWyuALHGzE8PrIqQaHjbEWMGjV?=
 =?us-ascii?Q?IiyXHfNc7+ecDnHng9bkl4Jp3ADiJRdwMkmhx9Z7Iu0CXG/NC1+N81odhyn4?=
 =?us-ascii?Q?uv/c4zLBXzyLT56L7t2dDmfT+QIbDsF/duRre+y47eUdLIs2TVFyAo+ZJfhX?=
 =?us-ascii?Q?s0gNXsN24vD8F669/U7wfbGfA+P5iOQ5g+DJe6iSbjpb/j3egBxFFDhDrmow?=
 =?us-ascii?Q?PEXsApP7igYQFGFQz75jnHHKNRN4iVO+rphVCd9OFWNuF1079JAnZwDNl1GE?=
 =?us-ascii?Q?cQ9NWDLUSiJMbdWHlwK2PVyGGcg/3TTG0XN/9bRhbg93ZrelNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:03:57.6586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2af8c2b-8047-4d79-a52a-08dcf3a63614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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

Users should not be able to run these.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index e44a44405266..2ef7bcfdb2e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2108,11 +2108,11 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	amdgpu_securedisplay_debugfs_init(adev);
 	amdgpu_fw_attestation_debugfs_init(adev);
 
-	debugfs_create_file("amdgpu_evict_vram", 0444, root, adev,
+	debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
 			    &amdgpu_evict_vram_fops);
-	debugfs_create_file("amdgpu_evict_gtt", 0444, root, adev,
+	debugfs_create_file("amdgpu_evict_gtt", 0400, root, adev,
 			    &amdgpu_evict_gtt_fops);
-	debugfs_create_file("amdgpu_test_ib", 0444, root, adev,
+	debugfs_create_file("amdgpu_test_ib", 0400, root, adev,
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
-- 
2.46.2

