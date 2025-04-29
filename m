Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB03C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 10:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A30510E278;
	Tue, 29 Apr 2025 10:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PSU79d1b";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBEB10E301
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 10:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHFWTL0uIqRG+mXDECzzgirB78wJqfS1PkNRuQ5ObLMkXfWeSwg9/n5xghQrzb0O8deyP45Q8VhlCFkm9En8ngoSso/IDgLRjo7kGqA18gY4eI8DIhYxWNi9YOHYaqHa0x6Wr6wbgyuK11ptRJUoh60z6/xq5dUt+NenctRoEPs9ZUx3C7IlLbGJxRTwUMRtf5lb9bVYDIwLh85ozs5r/CoVg4qZfwP2A+thOsLIxVwf3/+DGlKDO7OW7tAiez2iIC95qDzM0mlNMd82fuKbmL8DJj15DMB4sh/4sisUGWfenfSsR/Hh3dYTqqmepKxq1w1BnIdxJq0UWSVV7OtHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qqd9MIF2c3q4hu6qL2rqvaUJOEHoFGBTzdIvSeDRp18=;
 b=FulMKhFtnenyPBRtQ7MlUDph8QjYoD8LTPxYLfaMQskm4r1orTcAUjJgoKVYRQDZ3QfuGSFRFnDWS9hTN2cKu6oiKMHU/WQO4OjreywmkeKocmwu0gVNfqxHak4SNDM3D17+CG7VosI3IS29Lv0fizMKc0trTKN2J4t53y69HnDPg2PGWihch7hZbXlc+Wi7vXotN7lB/jO160Ctww5zcNjQiCzUlzz0MmbNAtnLP4FWCYpQU2d7yU+Az/CXEJrIeymWwi3yh9cUcpVEQtTVU4+DRxX5bgWlikAvofdHBRY7IYkvxqyXzMCFKOrdjzlrkVlDw2f/OUUGiHOv04ug1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qqd9MIF2c3q4hu6qL2rqvaUJOEHoFGBTzdIvSeDRp18=;
 b=PSU79d1bBCHNhXP/5AZiqsDdalaLFU2f4OvSe9iFRmeGwUDlFhmDQEbGIZ0hZ5SsSS6FGvjKjAxMkNYJ4rhiNGuB3ea7+ebYyKdfhFWbze0/il+QDthh0kuP2pnyPmq0tPzFb6gJbOeZcrVM1eavdSSmfipd3wvqtxge1YNmtJQ=
Received: from CH0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:610:e7::18)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 10:30:19 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::f) by CH0PR03CA0223.outlook.office365.com
 (2603:10b6:610:e7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 29 Apr 2025 10:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 10:30:19 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 05:30:17 -0500
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Trigger Huang <Trigger.Huang@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: cleanup sriov function for psp v12
Date: Tue, 29 Apr 2025 18:29:54 +0800
Message-ID: <20250429102954.3913983-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250429102954.3913983-1-ray.huang@amd.com>
References: <20250429102954.3913983-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: aab9b420-40c8-4651-c9c2-08dd8708d720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DKPtf50B6wCW8udaklJtC38ZmeiXBWryZag6EzK7EqvyDCh9W9AFBS2Adiy6?=
 =?us-ascii?Q?9+n85FSGCq6WYbkB9o9xT0uWQ1UdqZv+p0Jx4NEXRuRj/zfaywalz5HwfC6n?=
 =?us-ascii?Q?+8a2T0AhcZI3wII8m2UpspBBqQHH6Pxg8098KHCoRW1o+Oiy3g5Lpq2IMXWf?=
 =?us-ascii?Q?TMga6F//JVoiDjmGi6tJ6e0/gnDDw/I3p2uLDSaFo1nQVqggAtgnxF/7Y8/U?=
 =?us-ascii?Q?e0RjnKykqg0lWzRC8ZomTGdzdlFr8f8c1yiE3xZFJAljXeeO2DbyyxBXQXpp?=
 =?us-ascii?Q?EKJ2PoG+36kmlTDeV1LB0dPx61D/cyMEIEF44AuiWjZBVZS+a1M3nGvjbtDi?=
 =?us-ascii?Q?Q0UPJx13/nb6K73T8gKxI/fgeRrSieAvHSGnOXOmlVIddfnSiXk6WCfs1ACG?=
 =?us-ascii?Q?9lOqh+pFh1O9/gUgY4HyBSnjJU1ritmxVO67r1oa8lAGXd+X8eizY4hCSpi4?=
 =?us-ascii?Q?ULAtw+uQoZKbU5wYSAc0SuH1VkbzhB8kBrPJ9XVTU7px19PGnqtmuKx3XlXw?=
 =?us-ascii?Q?cvG/8tV2IWG8E8inx1oO6KI1Ky2tj+PfVH2bY9s5nWjLp/saUGxFX/vyQtHk?=
 =?us-ascii?Q?C7Os2tDX96UMeKphshimlVWF7mZn2YymruaFSfp3FnTs6vn8SopDQMi0WFsE?=
 =?us-ascii?Q?bmgClFlMcvApiLmdMepEISKeS8jGhJX6Owcmr/Te65dj2tr36wi4glryjnhf?=
 =?us-ascii?Q?8+pIimzZGLqJnlFlOKVi1iq2in0/GDziC1CNc47hHknnoqWgptcksKM4hHtM?=
 =?us-ascii?Q?6W2GWHBU/HY6C273jZYT3uGbrKXe+yNOPl0xPWHUFJT6NpYcooLRMxABQAG2?=
 =?us-ascii?Q?9wMoSGH7bonpzT/1tHzdf3+Wqug+2EMehc7Bdis0ry+s5yzoNTh5CShQv2xV?=
 =?us-ascii?Q?BXZMNT30x4qY55LHcGgei9It9/xmDxGBMWIVfgafFEhK/Bdtyn6PLGx9CHPF?=
 =?us-ascii?Q?yceEn1HNKRkRiDDP7h9eg3xPHMu59dTILmAD9f6wiSgl8OsOB+CFNaGP/1/n?=
 =?us-ascii?Q?I2jxPqNEAyiFvyYo2n1slw4lr8093v3ADGKJukTlg88Aff2Aw7o6s/N2P4gw?=
 =?us-ascii?Q?LvqktAG07iEBSm2IDAsn/S9ZpFyM3+4txdHghyLhRFCxt8OKeHToRbqDOeS9?=
 =?us-ascii?Q?d0oUevDt/CYNVc/zjNoKC/7nmvaLfVOPKaI4UawDKlpSO9JR7eP9S/rTcrU2?=
 =?us-ascii?Q?s6KdwsWC9AyEds3eokBYs9dlK8UbKf6zgU3r6NEZlSlJAoVwy45b7wuQD9mx?=
 =?us-ascii?Q?GAZ/MJE1gKDyxXCx/ngFyc1L06AxlaxFW/EhLghjj3HOLrA+aTNW/05rmWT1?=
 =?us-ascii?Q?0ZAgeafCGOwkuXw4XDK2s5k19wnCZPUHH6TOi1MffM7gyv5amtlpaqXcs1S6?=
 =?us-ascii?Q?sQvXfSyy4u9Xar4TK7z+pESJ0vrzqXUoOgrBRA7Pm8L7sNkpwfpp1yFLve4H?=
 =?us-ascii?Q?CdRIPjSfpHdqVm6s/GulPQEiraEaGC1/AOAR4zdUmUGn6X3GWoTcwkWVKq7S?=
 =?us-ascii?Q?ox90PVdq0jB4bQayI96hLj3kSWcYVd3t5Izf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 10:30:19.4555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab9b420-40c8-4651-c9c2-08dd8708d720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
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

PSP v12 won't have SRIOV function.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 52 +++++++++-----------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index ed24f61e1ab8..80153f837470 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -147,41 +147,23 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
 	struct psp_ring *ring = &psp->km_ring;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (amdgpu_sriov_vf(psp->adev)) {
-		/* Write low address of the ring to C2PMSG_102 */
-		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg);
-		/* Write high address of the ring to C2PMSG_103 */
-		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_103, psp_ring_reg);
-
-		/* Write the ring initialization command to C2PMSG_101 */
-		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
-					     GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
-
-		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x8000FFFF, false);
-
-	} else {
-		/* Write low address of the ring to C2PMSG_69 */
-		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, psp_ring_reg);
-		/* Write high address of the ring to C2PMSG_70 */
-		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, psp_ring_reg);
-		/* Write size of ring to C2PMSG_71 */
-		psp_ring_reg = ring->ring_size;
-		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_71, psp_ring_reg);
-		/* Write the ring initialization command to C2PMSG_64 */
-		psp_ring_reg = ring_type;
-		psp_ring_reg = psp_ring_reg << 16;
-		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
-
-		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x8000FFFF, false);
-	}
+	/* Write low address of the ring to C2PMSG_69 */
+	psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, psp_ring_reg);
+	/* Write high address of the ring to C2PMSG_70 */
+	psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, psp_ring_reg);
+	/* Write size of ring to C2PMSG_71 */
+	psp_ring_reg = ring->ring_size;
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_71, psp_ring_reg);
+	/* Write the ring initialization command to C2PMSG_64 */
+	psp_ring_reg = ring_type;
+	psp_ring_reg = psp_ring_reg << 16;
+	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
+
+	/* Wait for response flag (bit 31) in C2PMSG_64 */
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			   0x80000000, 0x8000FFFF, false);
 
 	return ret;
 }
-- 
2.25.1

