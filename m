Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C2DC624D3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE3510EF08;
	Tue,  1 Sep 2026 20:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cPu6uPs5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA1910EF08
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTupyP1UzBeQp7h/gmO3CwQ9jJy9Nk2T0YB9DP8duRZGX/8P1XlxUWVqPAeDwsHZdsU75AMrV3MhtTJnr++gFx2J5pIR2cgBpXGFW7CKgiNTsoFUi20SrlfZevPS90o6YFbAH60DvkOjJ+4JJ9qNx8wl30XST5j0vpd81GpiPz1OLXiGphYaH+RjMQIeM1EqLir3I5BaO7WhrnTI1rvYYNZJUZgphZT/7wpbVATl5kdtWtm7KBeNQ6cr87HWYTXF9ry5n32a5cN8pHiVMt3J9YVrLeyH+UwmVgrMuVkjG7XD9ZmlN4S+oNNrQADMDXSb+TUQ34pZ8xNKvJBbnq42sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHX+Zi0a/K6hC17YtwYk7kqhjDfvji/jR5vW4KEnNf4=;
 b=TEaEHX4CdLSL8m2t/F6C+AbEGn5XLtWIruE8gNsr1qdFdDxmTDipksyuLLimWwfqfFODdvBUca0ITM8ruSa1wj3Gy/XLWwAesdKG+Jzbbl3MaJzoURHkxawz8XW4mYgZLaYhmoEYQCbT2XOdxVUywuICAwguHKDKB+NxUx+En4vxx/8VEuNn1xUedlnNbBH51KSpJuSeihwh0+EVt1b1BBfnENxT17i7HWGaoZSUpIaSohwYx4El/GCfFKm8ilDuiJOG1VfOtyeiCnjhc5ao6gcNlyug0FRFl7+OpbUmycURc5hZMOba05FZ4shrX6PN4gUVUr5eXh/Jb5R9Xe0KuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHX+Zi0a/K6hC17YtwYk7kqhjDfvji/jR5vW4KEnNf4=;
 b=cPu6uPs58/o2gCYMUEh9PISAtaubm+Sb4EBkVq4Y2rmKLaAHXjzxydod1aywofp7Hm7teGgdEqPkqSBAcMspuSXtoMwONIP/cMIFxYf3yrZzYvoes7nghTKdHig69FB7S0idPaRI+/rMbUkZMt4RSacg4s0xqSCHTpabj1/Xj64=
Received: from CH0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:610:b2::18)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:55 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::61) by CH0PR13CA0043.outlook.office365.com
 (2603:10b6:610:b2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/31] drm/amdgpu/gmc10: use MMIO for TLB flushes
Date: Tue, 1 Sep 2026 16:10:11 -0400
Message-ID: <20260901201034.2960437-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS2PR12MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce1a40a-1ca9-49b1-6c5c-08df0865212d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3jzP1J4SLAhqEqyZWnTRExPx6ViHq7yVCZSEkKyvS7hxwrRmfCafS9UeZFbKzlxAJ+0+vBFSxYe6IEPDRzcZLYvsu+sM68xiF4fkJq8nKK1D0Qm6ejNJE0AvAGw21sT90c8UYcM2M8h4FK7xsXP4CbBeeC4yjZe4/sYd25wQHRkgmMidGh5VYG61Qz/SBNflPJRkHdz8dWM8caZ6OQ5b/hYZsdNoLxlRvuD9uOf9TsNb3Ov43l/+ZNwXch8c8w9d7dU7s8nTfgzQfrO8SncdyQHYYltCfVWs18555cCpe2FuN00WpMhtABZ2CwtGQmcAqx4DfdgYLjwG4KoxW7Qyxqd9NRl3Gw8F8+5/yDtJE57TF2axm3eaJkmIcLa6fpKX7Pb1qufXz5wXsnXiF+I/T3dyZGUs95TuPjDqnPN92JS/pggzP8wyfIWUrr1d1QntUZbqNVr9HC7Kh18vRUCtTYyWrWMC8o3+IgRhLEil6MzqZ2LYvk5XmnGHbzyUWZvc+ez8zgfjYuhu6BhiYCRu3GlyQcbRxWKVTjl6KH+UwbUWHM7Beqg9+q1eRqTt5rpvMEgrcF1nyg0NkOroG0So+e+Uc4/qTfGekKCuSA+v4zWjRrgQoZNRgn35Dq5AWG25HDtUduJ8jBtB3Q5d83zpCVfipUoAIzMsl4Ons8YPM6uwp0qqiLOmj69XTDlIfEfb4966fY3BxWjEv3XU24q9vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: asCwGsNz9MZCt6iWfggucsRAMwO6w1n7ADMYjEyHfeqPuAVwmpOQWPcHYMtcIC51jzVRFjaD7pPeTGfSyqXcn41qKlNK6mCl12JZFfkocLmgtV++/Al1heyV2m/P4H5WkeJ9pYJkaOisKMKqi3gCVlKYAeO93cUdPtvfhJKfUm6lhidQNe8jd8BLITpybi+AkvyEvfWDoNueIQ5aGNpxjKv+IaNX8jAOLfPwuY3Wu2juE3J5nxLr7+X+iDSyM1Zfgy1doYNeLFQklV3HvISZ1THyCwPymJJjwn5jxwTkvOVkmCc0TFzBgcB2TuM/Psh51IzdWHwwXaVSyQNZ2q53soU3sOOxnpeR8vHrvySGoTi2oEV0BVNSQPet0zCmumJkt2fDrYOy59w0YbY9QHvSoZ9wvmdBo5a5WmLg0grA3ar5nodzxp9joVEcBJsBZ5JU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:55.0793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce1a40a-1ca9-49b1-6c5c-08df0865212d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661
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

KIQ handles scheduling on GC 10 so it can get delayed if
there are a lot of queues active.

KIQ was used to avoid disallowing GFXOFF, but since the
KIQ will wake GFX anyway, just disallow it when we
flush and use MMIO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7ea1c4b878e97..23d9fe995a2b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -884,7 +884,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	adev->gmc.use_mmio_for_tlb_flush =
-		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+		!amdgpu_sriov_runtime(adev);
 
 	return 0;
 }
-- 
2.55.0

