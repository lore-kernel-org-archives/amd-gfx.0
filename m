Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC66BC5DF9C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D1010E87B;
	Mon, 24 Aug 2026 22:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zRuvBB5h";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5DF10E888
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVnatsWNedUHDAYJ2xFb0ScRNHxhMhST6QhBA8/UlxcKu7v5aCKDJUhaa8CY38ng4L+Ls808B3jwcJO6u68Q3v3sFxmcUyubg5ldcFQLZOKvqazPwgoeUR9KO4epDRelnhnvhUE+mTTMOofNdNIhm7FoAwhWT7dXli8GKpeUtTbMfDCC3uPreWJupM3wkDAgrz55cdPosf73WWiEmq5sv8Y7yBA2krNtF8pPzevNTCKxw0gE6Ktm7Yy+G5k2Hle9qbVHVKV80yf1WduQwT8YHAhCGG/bnkEoNFQBAM2N4UlCZYsPiemb5gKz0PRHWLLVUCwOy7terQQur95E7n7nqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG3oqorGCFIKExYXyP5FmIoKu8pYnhDBAT4LozZWHzw=;
 b=bGLOtFzB/QIKjjAQecKa5A0mHw0wkdCqyGYVYCJBiGuZXEhqBq5SApcc29RXtGYzxx+35jp8er5FpViKpa2fhdK/LIKYFZNHgfEEE0ldJqxqmUislhh6M9Mj6xy0vWcEAu+f5hzehumGymkjn+tz0HJ6gtDY6UCK3+2nwHDVz20UPjMiDY2e0KkzSljyythA9EDNShJW0vGweHD9qk5aewY3A33QL+Ohg4r93HtMnJ4W9HzXnRln7usq21C4mXMK/QCvyTOE/OQlQd02CQNHAOHzWKG1Hg90l4I99dgfB6LyDQclwRWYYZO7LEQIMLD+uk+jZxPvPrjRypx5mni2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG3oqorGCFIKExYXyP5FmIoKu8pYnhDBAT4LozZWHzw=;
 b=zRuvBB5hHy8R/KAmFxddtxsonajf4Z/BvotCiBqV2RxgMSHWXZkwjbOA3bvGgNu9w8mHft2JS42xmKcCrVmf77sR9Pk9cLEA8WdOqUi4oimT/e8f2hyh1V+1Tx5QlNGx34ChN+vc58ze5KwMdeS9XEh/iZmWJrLf01ZDxxn3/Ho=
Received: from DS7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::13) by
 DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 22:14:24 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::26) by DS7P220CA0021.outlook.office365.com
 (2603:10b6:8:223::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/30] drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
Date: Mon, 24 Aug 2026 18:13:44 -0400
Message-ID: <20260824221352.1793542-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8a2e79-fabf-4150-71ae-08df022d0e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Aigvd0HYmmMJvVS1vZ0RGfoJzmQYfY2yBOL8RAp1giw27ET0RYPy9YAlZHhEqJC7GZ95FTe5ybX/8PDQr+BvD6oFmX0vkGKyHU3UAZaobowgtvoMBTT2u7CqwTso5jM23+5em81EL+3xZS2L70GMxynXtdibsNqKj9rYOk4DacgoUuBE/QU0KsTIXqT4qwvRvpyCyCFpPjk3aAaVsc2KF1TTOq1TPX77umg90BDEdNFMT6ICX4mNKN/xaj4DFy7S0LJh9HCM9Yot9TEEhucWX7MuHGkVW4Y4767UfdxAS4pJaQl75m7QzUeFV577SXUsKhat7ocDq0cgXETMK2VC3t6VyejE+fEU9XAbM5/S5Q+5dG6So18MwDdT5Kqdzhrnv6E96YvX8+7jko7l+IJQNNF5lpOofIPr5Xx/tZPe+QNrnkrOHd5RrPDGSLMZQLfyRruBBCRwjmRlIR8xLTqIhDniF+PB1vPhMEMHhwqwLE39XXbWhx0VTfuEyCdUQTsLk+yOw9+yfVmnhJHBT71kvLFzd9YKQORsHkWgjsDZU3siMNNeAAthHfiIE1vQNB+UNbI81EuZy5Cq64yvTrAO9gngGy8eyinhjMJ72mc7yUkzlb2PxcfwYdEFuyDjymvYCH0SjYaoSbvCbd7vCo2qY077IoCTAMIhmBitF5F5n7Qzw1Pi+XIqcrWrsBQgkbULMjg0YWyKAJrso+Ad4gNAGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e725LU0/s/FNSIuXWwOQFX+tq4pNrrs7zsMiOGJBPqlIvl2/V69vYOc/5KOpA4qHLkQiTrsWSCw97VLsXEQaPN/IHey00xRQ+S8qBwmmfOtjg6DDgrumC3Rig8gwi47qGmP/L8WVyVBg8vW9m5RHsqBHK7J2wcGVHowTvDuwfkaZ0+y1lXq1p+4hLmyEXAaLvoz+2WcvHuE9ZixM0r6Hw2N4Tya8V4KKpcS7o3iqlZXcG0nhxDfBEmzyNJspoKBapSedwHJNtKt2T3wYLDjfYWDLY+Z/uAGQ673cpBajLKBPi/MmS9+o2yOpmAtBuHE+2WhkBFx4n3LNC9LaxG+wcv1mSTBsWJZbxg7WtJwAAZkF/Z+4CQ32NRH2l7UL8aC/tNTe9Ig8NIAiMEGEBLXDAaA43jCcxh54UG21Sd5k++FkNf4JeJ+9dkE6ajDsukn1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:24.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8a2e79-fabf-4150-71ae-08df022d0e16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
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

Use SDMA rather than MMIO on vega20 and older.  The avoids
the need to disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e9e5a1e183231..2b359c56f8d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2183,6 +2183,8 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.flush_pasid_uses_kiq = true;
 	if (adev->gmc.flush_pasid_uses_kiq)
 		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) <= IP_VERSION(9, 4, 0))
+		adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* Vega20+XGMI caches PTEs in TC and TLB. Add a heavy-weight TLB flush
 	 * (type 2), which flushes both. Due to a race condition with
-- 
2.55.0

