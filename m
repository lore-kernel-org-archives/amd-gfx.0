Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10059C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CECB10EA53;
	Thu,  6 Mar 2025 18:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uaSOMNQi";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8918C10EA53
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INwKVxYw98VWdlUdOjd/75TpMLlUFGoTDL9cVfdZ1jzmSNhTn0XItSkjZniO+DM2BUZR95yiMRnQiWei7ODMecuMU0ThK0KVrnefPgWPMMxazGjaPJcIujvu94iH4elBNjhQfesotewOR4+t7zD6iH2T7sbZjHG6nc6k2EH2NKHf1PPqpA39wA8hFphRdlI3L0/iAFUWn3Cws1Jqf3+HnzKSOxsR0NefF6D3W3KDAbXvRznmBx8GnuCZCuNeyUPguGsmPE0UzoNqexx0JQ9OyrFyzBoxA+6BSAZPGFDNlfCnsFQO3WyIm+os4LyLHJ4dyP/7qQGsF/gh01f8OXbw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsDGQ0hF5bf5YerjfYIJIH5mCdG1xweSXN7fbpRutSM=;
 b=RDHIn9DyfdZ8F+7FLKn9xS14o3k3KSpOGT4Pz5Bz06p63HoU1yedlrM7PbNEHAaDe+EDuBzZTq+b/Yj/PPsp1lpb87kdA5/+DEQ5tRb3F96CScuJOi2j+xsPZYDXlUHa0VeHBxhsqO5+syykeVCBQjeHpI2lTcreZCJnmMnkENgaPOjgojabGNWKc4+nGdXmVrbnZptkofigPo1NuPll5e0EdK9ioYIjAEZYz5MYTE428g4gRkMw6/AGY5BYY3yS2w0WBA2Wi2/NnDTOvyzNpVfAUwkE9LHPivfyg229BIZ9X2vLLzgcXJ2EpIu4SsnpUiEgkfOqHoZOfmQlhBAKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsDGQ0hF5bf5YerjfYIJIH5mCdG1xweSXN7fbpRutSM=;
 b=uaSOMNQiGQGPL3h31PfkboNAOYV9AJuCMK/Brr1q4zAg9XA1eFPRnJglASuWlWVNF+JSJ9WihxjX2LCZSm32nkF2cc7K3W7lsATo5umlrlFkgYt2Dnksl06iMqx66JdkJZpZnkOu6WI0ExxMcHzkOmVIOpzzmCVABE8yJwLaI6w=
Received: from BN8PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:94::32)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 18:20:06 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::a9) by BN8PR03CA0019.outlook.office365.com
 (2603:10b6:408:94::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 18:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:20:04 +0000
Received: from vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:20:03 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add missing GC 11.5.0 register
Date: Thu, 6 Mar 2025 13:19:56 -0500
Message-ID: <20250306181956.14459-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 25770546-18ab-4ab6-1e46-08dd5cdb84ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o2lxzm0IzLz6SAusCrizzIH0NtQxtdMQx0NwsJjd1F1yFoxIEqh+0ZxBrmz7?=
 =?us-ascii?Q?OJuzn5zXpWHcO4whOxIwXX/rdX7Kc8kfgeGLQFfcBgEOmBic/ZpPGGLyZhsy?=
 =?us-ascii?Q?CAGKHOb4M3gEzt81CAIdSrKaH1SM1apicaDGq6v30UP8LTdveVGaWWunwjJK?=
 =?us-ascii?Q?hJmms9wavF9XTEPf4x1enDgklOEFZLL2tsOCgEPa8FDLm0lvAKfd0RUnqXbc?=
 =?us-ascii?Q?F0CuGoXbygITDBDWSFyVBoUqLCHdsW6bc94V2NLlPoZDTX7e6IsF3yQGUw4f?=
 =?us-ascii?Q?wT2hroAOuMcqVLOmQN+cJbQb3n/eAtfr0gAXYprJlOZcoexV6kDTUgAVN0Mh?=
 =?us-ascii?Q?AOcLMJo/d8EKRaBX0ZSWptabw6II0BfuJ9kggYx4KiK/mrKfpyTRjzLV84j2?=
 =?us-ascii?Q?WtOwLwqPnsdhgxbY1KORyeu5R2eVF0ZOOm0QeupnROdbR52+yxbKDGbEvXWy?=
 =?us-ascii?Q?9iII+Q24NlKhUQI8zmTVwUioi2R/fN5ximejsjntipO0t0eTDYu+PqYqEpgg?=
 =?us-ascii?Q?AWbnM7PQoyTNwlzZU/LyM+TJo9MMjRcuVJJ6C6cbNrHAhh7S5m2v6eYenHP9?=
 =?us-ascii?Q?leZq6w5amZw2VBG1PqgPwD0h1mkBoOxqVNyR6lBFVd3HCNXDXyASEC0auv4Q?=
 =?us-ascii?Q?8BPrLAhdNisksfs41o0gBURLQDQRcPNA43pHZe1BkolwkBnryzeKHj4EpnxP?=
 =?us-ascii?Q?IONVzRPIExLQ6SaHZVf/zaCdhPpU1rizHtNub1DIxS8nuSVYWs1HdJXyn0Vd?=
 =?us-ascii?Q?nCI5rden66Zp70QDI9nHdRZGgsv75GbpZqCfG8Uajl3N7DatI2HrHe67mAUO?=
 =?us-ascii?Q?ziTV3B53kS+UM7libqdnoqENzTAgdpo8QG3WYetRNDIjDYHqhw0BNrGZlWek?=
 =?us-ascii?Q?IC2O92s6Dw1wZHfhAlXTOJcd0jXGiea6FL/UbuedsfRnCoQroUxwJAqChpVU?=
 =?us-ascii?Q?9K49WiKlcFmKHjrmmY9Yvc/hhz8y3OqskKDyo62K+4/7lQ1e5LC2TYKABfyk?=
 =?us-ascii?Q?R7CcJf8++jx5smNvLO1oXAu7ACEEcFv2QfY+6+IJN2ARHfptMXvrAmZaDHNE?=
 =?us-ascii?Q?GMHClXy4KazM6F5EnddJBMbo7iImc2QFLk4oKEtN1mKeaQu+OgwwGuL2zLZY?=
 =?us-ascii?Q?enKaQCaWVM+WiYqOY27aUecEGUeiuonLetlrWuX24R2r3c2lsqqCG30sGgTv?=
 =?us-ascii?Q?EC6M9J32I4xYBTanuoQ9w176enc28kqD9LxqjnmbkRVaubqHl62JhOoDiZPL?=
 =?us-ascii?Q?POj+2i1WQgXJhyEg9UL15TFQze5ai7SJ43dekm1FuvDCPGzkW3MM3wAEir3r?=
 =?us-ascii?Q?X79ivvJNRUM4LGhTRDR6FzaRoWhCpqqta0fV2P032TWFb6YRI9qA4iCfIguB?=
 =?us-ascii?Q?R/f9rQv32QBQYAPx0TOr7UQwIGsO1BSD26+g+KresdBhGILvYI1PYs4JuY5L?=
 =?us-ascii?Q?0CuuyRo0MgFNAA+/RtkZc2+hckJ7Hy1JIRe4jgmvY4hWB4NUmFnSvV6Fg2pq?=
 =?us-ascii?Q?Oy+ja+yr+lZ4XMo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:20:04.9540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25770546-18ab-4ab6-1e46-08dd5cdb84ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
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

Adds register needed for debugging purposes.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
index abdb8728156e..d6c02cf815be 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
@@ -9478,6 +9478,8 @@
 #define regRLC_GFX_IMU_CMD_BASE_IDX                                                                     1
 #define regGFX_IMU_RLC_STATUS                                                                           0x4054
 #define regGFX_IMU_RLC_STATUS_BASE_IDX                                                                  1
+#define regGFX_IMU_STATUS										0x4055
+#define regGFX_IMU_STATUS_BASE_IDX									1
 #define regGFX_IMU_SOC_DATA                                                                             0x4059
 #define regGFX_IMU_SOC_DATA_BASE_IDX                                                                    1
 #define regGFX_IMU_SOC_ADDR                                                                             0x405a
-- 
2.45.2

