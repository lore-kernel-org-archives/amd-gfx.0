Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C5AC02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 07:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB5710E339;
	Mon, 20 Jan 2025 07:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ReMGeRwv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4A310E32D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 07:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRJ3c6ciiXJJRO1feRJNqR48dhhoAcc1AGD56Juihyd1Rl1uT9Gct1JT4GeWJjWXMMAqhhaghWw376hhQjSrkMBye0FS9243CZ7h9bLxyDj6A/ckMY1q/1GZt9k/C6AbUkCsEk4m0YuxB6gcGRt3Vwhiiz96QVOLRUxYzHlMVQopQDGueAqXnKIVDDGKvHvlLHUDgLDOeWZv1JDhZNGsgWVR43S9U5dioBCJBhdXf9DpxBpajY4D24t0EJG7SrmENpvzyaH3L7MDZA039QKQvuGdmdf0Mi58Vlku3ba05VUpdwYOKjCMxK6tCMPj4rPIVp/iJWDHqvR1XoAPAB5VGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHnKKcFH5qrz9ZCj7DtkyYAgtDFl1pvaa4ClwcU0k8o=;
 b=JLNAlW5yymwdQ3NcfeybhQalaiFnclwWlj/YqRmCDjc5/oVa5d1swkYlb7iRcXUkv5sqx1u0NIwUDZjBYEIqPhdgm9dFTmptFTp0NOFAYsokhtcKdBlGgDPE+jK5oc1Ioja9dODDRlIlnv95pISG8pmovJyrEhjjbR7AS1ILvTd4Dz3t2wBIKLvAqZGVFuTmzqAYyK+/ACymc14SmpG51nToCMQPHojcl5MymIw7P/KqJQ6h1Q6vDXgcas4vfNmb4G+GqIF2/vJ8uZAMBwxr7orSPlXTU7JrWor5Z3Ft2dfRX65l2utewEb2RzBR5v7W9+MI8Q+5R955A+U98u81ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHnKKcFH5qrz9ZCj7DtkyYAgtDFl1pvaa4ClwcU0k8o=;
 b=ReMGeRwvV3cQDCGfU+sg6IYH6gE/6EoH4KZzmR0S+JJwDmWaS7o87YvXn2wQr2wQE1XZGWQNnNd5LZV8349RYWrOteyoOzGo1OKXc+G6EBllb6WyYZ8aFoWLZ4H1fNr9tPgsr/MjpM2LHUHBRst3OY4hUfrwCLtoyXAaHE/jiXk=
Received: from MW4PR04CA0379.namprd04.prod.outlook.com (2603:10b6:303:81::24)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 07:37:07 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::e5) by MW4PR04CA0379.outlook.office365.com
 (2603:10b6:303:81::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Mon,
 20 Jan 2025 07:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 07:37:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 01:37:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 01:37:04 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 20 Jan 2025 01:37:03 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <weiquan.liu@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: change the config of cgcg on gfx12
Date: Mon, 20 Jan 2025 15:37:01 +0800
Message-ID: <20250120073701.210249-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ec13a3-cd8c-49d2-811a-08dd39253d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eFg0tbnAoFGNxz3UNuW9W7f5CSu6e4eMOTIURAMQXuZAJw4R8vx50dL+tfGj?=
 =?us-ascii?Q?g6voTBoHHI55oDFfuM9zfbfw48sj3retS+bVbHhoyhMSnqr5UE6LNiGvMl25?=
 =?us-ascii?Q?TKaZmQu5pa/K5KOFpEL7OdyJFbYpiJA27UkysVKTMb73BUwA1FdwU56tacuF?=
 =?us-ascii?Q?wJITuC8FxO6+Ae6nBxATOHa/JNNQr9JOTXz7bSZ/NSONhVK+4cwEeLNv0DTl?=
 =?us-ascii?Q?zpVf1BrrfJIdLYJQBBYurYun2B0OLpBVaBmuJbdpx08PKZdzSrZrHoqXPsLk?=
 =?us-ascii?Q?TgDojUBdSI494UxCrTvkVIUmj+iOCcpvyA/JghsLsybmFS5J5OENLqImKleY?=
 =?us-ascii?Q?lbLn9wmDueJ2L26caA5V7ABp8e4a8CGLsR69/GxqtTr4yjDufDYf7s0QX52a?=
 =?us-ascii?Q?XzQN9bfBlG+Wm5uBYH3976KO7CGrjzQT4xf+8E94Di7xzTIKzKpL4mN5RQAc?=
 =?us-ascii?Q?bWDGtGKkzsduvOVFf8a94YWZOVqKnYnWPtOjlrsj4foVDrF8OzUB0qn7xAst?=
 =?us-ascii?Q?v2uZF8FURzXVETcG68/EJMi/5Ukl5qq2JOt6R3vttdfMZsAGThH91irDDuFj?=
 =?us-ascii?Q?p3+/AoXywk6HY4Rx8HXtS3UUoVwXqjKteRIATHVkOE+Pl1hGHSXdK+745Bs9?=
 =?us-ascii?Q?Lp/s7TdZbffEw73YNoN/cmyRJJc07Qr6ekaeKDF5Fbyl65eiZ7gcx7BcVUjm?=
 =?us-ascii?Q?uEkRA0MLSYa8rjd/C7CDJZ+qPwjzqrFVwQH+9mrlYqJMYcR53v6VFmun2RRH?=
 =?us-ascii?Q?epxFa9W2R3RbJI8bk3+DOZgWaVm53jwVRc7N6Ny2fGUEKIkLEZBfer/9ebLt?=
 =?us-ascii?Q?KG55eQfGt5LzLh5tWSRa1Qc39P9Y8XaJPjgw/hI2l6gG3ilLVwRCRQvnbBrk?=
 =?us-ascii?Q?CQz0G0RI1syjPFw7JZ+fYBU2l4d4iRk2u2XZeexwmVj2qqG52p5gIYw9b2Xu?=
 =?us-ascii?Q?N2wcRG8PNEW66bRFtrj6Y27YF+G0uyh9ZdVxGIOnU1va14Ybr73hI8Msj0mn?=
 =?us-ascii?Q?kA0TpO84NV0hebXNZH2uqD8rge+EisMm2XJ/T+NuGSSf0oxbHEfGCApH+hSH?=
 =?us-ascii?Q?unE+hrE7kp9a0gaxiULxJYbblC/udb/8cFstbvCpOVbl7L8BgOZ9llDi4qcJ?=
 =?us-ascii?Q?JM5yM6aMzzhNh5VQ+Kj9R4TcKlN3OljP/c3oPn1V5rAdk23sUdO2b/zKiCOz?=
 =?us-ascii?Q?aGBK2+5eBE47Cqv5PcP4SLzpvidSiBUm2Ix9Hrbqan0sp1yw2RykWEExk+X5?=
 =?us-ascii?Q?P08iIfSts51igsuIH7qKKsctoc4uHFuZeBx5nw1d3teWamyjliQCIwAXHAy9?=
 =?us-ascii?Q?XawztkAVmtOfEcHhJbA9gbKN9YlFDBoxKZSW/WsJMVdK4KGceYmbncfjWcgG?=
 =?us-ascii?Q?Afw7uWNpkMYnYR0+6DvKzcJ2AFaddpbpTMOtk/1D+68lUSLn960WIZwNiFBI?=
 =?us-ascii?Q?AtNZRWfGimySmAIBaZzoDqs7BYnoniENokIQm7dyI3OjDxQD7y62xb21dC4G?=
 =?us-ascii?Q?6YjkB/CCnn1if2Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 07:37:05.9625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ec13a3-cd8c-49d2-811a-08dd39253d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
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

change the config of cgcg on gfx12

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 2a7199880041..16842fa8dae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4072,17 +4072,6 @@ static void gfx_v12_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 
 		if (def != data)
 			WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D, data);
-
-		data = RREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL);
-		data &= ~SDMA0_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;
-		WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);
-
-		/* Some ASICs only have one SDMA instance, not need to configure SDMA1 */
-		if (adev->sdma.num_instances > 1) {
-			data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
-			data &= ~SDMA1_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;
-			WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
-		}
 	}
 }
 
-- 
2.34.1

