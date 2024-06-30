Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1457C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5809410E1BD;
	Sun, 30 Jun 2024 14:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dJqCQN+k";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E6C10E0F0
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T36siT4jv3/9rgtw4/MK6KQVaQ4s/5kpQywFvYGfZy0XK+J1o74pOZ/xGM97bexEHruuNVfbE3N1Wlgp7GJ4ZnKDY0AHzneb5gWwgTye5r+L0MKDhmvN6KdaYTWwhp9E2Kj5A7E6NBx8mUEq70YNjCSlYkHeUw1vqwmEarhEVXRYDcVTCgChmxO7vyL4eloRn5hq2PFgbqllgr/3eDMMntLMlrxQwJskEHBzMroXjoLu+LhRWQ8TDnu6F4EVxRzJKHH+dp7iZTGw4s2PxTMvVKkkZZrxd2VG0cz2bG9EtHXsqbes2nzqvfGeYPWzCtvfngXDfqZtQFfoVZD83HB5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37MRlSMmt5b02+DpGvct42rjihMMF9kihKwUMajl30k=;
 b=TujWNAcL0rBsV1mPNPfY1vNizMeLdS5ZhAAXg7r5VNmmZQCMEydpJdOlKKlIhub+ihZV5DN8sP5Nj3Cgf03kxX4+WV79dlWBuVnGlfRxahI/b0DBNmcSAW7KxIVG8PAV0T14gKJIL3+eMiP327f1L1wxgK4lPlpnpohnM45qUUGIUsGxymeEXjy4rtweS0Yjk3zQiGsQ6OP4h60Wywz8FWDIWLg4ENTyxH8I/pRJYBL8ng3AnVRvb0MCFsuduKaTwZCEXsW6n1V3cBHgDqApVJnrTWzHgsfbqagf59pEVupyztz8irxyU8O4LKp3EnRBxXvhakAeU7PgSYh9yU1IzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37MRlSMmt5b02+DpGvct42rjihMMF9kihKwUMajl30k=;
 b=dJqCQN+kLYmpWIs1b1A51oP2K7Pju0sVFhd7TZdSlrDgTki4PXjWu3OHfP9ToAubCcgyH7ht/8AmAMuLgNgwtNQHnkwCXsAdnhh0i/Gkp0/u/RFtLj3mjIjXMxSQU9oFlcIUhXW5B/AxaIddcgyyDiGPPfeHEXsGBRoWYgxW5lQ=
Received: from SA9PR13CA0053.namprd13.prod.outlook.com (2603:10b6:806:22::28)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:40:58 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::ce) by SA9PR13CA0053.outlook.office365.com
 (2603:10b6:806:22::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.16 via Frontend
 Transport; Sun, 30 Jun 2024 14:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:40:58 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:40:55 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: add firmware for GC IP v11.5.2
Date: Sun, 30 Jun 2024 22:38:36 +0800
Message-ID: <20240630143836.2015991-7-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630143836.2015991-1-Tim.Huang@amd.com>
References: <20240630143836.2015991-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: e38af13b-75f4-4b0f-a555-08dc9912a7a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zSp7LxMIcrIWIYMu73RLHMu8xgqEvkm1WuWkYLOYjG7Q0gue/kR+8LjRpO0E?=
 =?us-ascii?Q?cW4RbaEGxAVMQoHqU3YLeOzvVJ/l3rjSeARzOHVvQnp+Soncdtfy4W5rolXT?=
 =?us-ascii?Q?2YFipCqXdaNYzsUq2+OuBB5n27wrbonianbguN+7IZ28AfM8+rzV+a3oqqHl?=
 =?us-ascii?Q?g6yGO1FCUf/U8ZiFbEQDLnFCkZFmQ/cwnb8wLvsnvTlIDG3kRlf8bYWVsine?=
 =?us-ascii?Q?wZADzE/tQNO61BWtSSZ5jLJ5TMWDwtJ2w4OC/g3Q5Rf2rmxMvKFbRFCxQeQm?=
 =?us-ascii?Q?9GOLcarVtjR4rDG/w6odMBmMXilcnnwa+j6ep4Xrip/R52jBZZqUTJo/C4V5?=
 =?us-ascii?Q?LlPSW94kKbWunSL1Hl4WvptSvlQaCOWT4NC38qxpGL7qrGWEX5r8iYeimeTi?=
 =?us-ascii?Q?tdTK3XD/ai5giSXkrNdxCnPcSRDx9gjpY31tO1f3hSwplfwiwTq07KMgh+wy?=
 =?us-ascii?Q?nsRU66DJznFhAGZfJk9aN5r/h5+spamodMzc1b0Z157ca3u0UOZqg/MDqR0N?=
 =?us-ascii?Q?pWi2zMFDdTeJcOq5qvcCg+vTcWC3Z6VWg5uJXBBdqLqL9W2C6cojnEWjs9xW?=
 =?us-ascii?Q?86SFPf7TQEpTuC7ZbDKElKHhncUTWvOkHRcUigSqkqDOmdpLpVdfMqMte0jo?=
 =?us-ascii?Q?Xr8NSXyyZLMy4Br922UqZSM9z536Fz0yNENJILOHHkEanuyyYspfyzi+20mg?=
 =?us-ascii?Q?upvXKWEW6RlSU2/7yG4d/eO7X+CwiuyG6XkCqeSh5stJ828B+Yca3BfVBhC5?=
 =?us-ascii?Q?UaLGWrS4Tf85PG1SQb1a7om3P/xNXfvaMwpowgqPJeYq/cxAQkpGZ4yRdhIu?=
 =?us-ascii?Q?6G3ip9iBgOJDaM1y0RyTZEzSDki5HlhYtYKAYhZVJkUUHIIMRTtgyPJhWEjq?=
 =?us-ascii?Q?Xijbp9raQzlPWABTcvTlCre0X7054arqJjhI9GKjxsMHiwobsUGqjbIH6/SR?=
 =?us-ascii?Q?kMpTVzZrw9djD2T6mn+a+hgs1qeAkG95EHT8swMwmn+ZvPjJ8UbZJHz/gThL?=
 =?us-ascii?Q?3g5WhakazCpzUNLKalhoZZnBkTXhqLQqo5U2EPPVmIp99lvKFkI3fZ/xGoOI?=
 =?us-ascii?Q?5/6GYOylBQ+bvkCzIqz4VSlLQrsfaSPajR1oORBR7Px62c5U1/gIpsBc+znz?=
 =?us-ascii?Q?UMJn+Ej1htzz69cKfeBYCliFMjMqdDwtfOEuY/FhckuvkE2eTVsDTFmWdXyR?=
 =?us-ascii?Q?jG+cRrCXJz8n7KVzUAQSztZXBpv+koA5I/ZvApgaabnZhOmCzPGJtDyakfvp?=
 =?us-ascii?Q?27G09pmM7OdApheCiKlw6/6ADQ3ALx488OXvRZxfn7yp3cp1pjpDEOaZAbW5?=
 =?us-ascii?Q?uIq/YnALIfpLJHSQSnr5HojHXGvNkVVd331Vcnp7a6Cmvfw4oryCHyBo2y/0?=
 =?us-ascii?Q?ZcS/JihjlqFK+SvBB4sYl76wKwfk68A206hN7XRRlWt5rOqYe2gbY7A3cT44?=
 =?us-ascii?Q?NnZP0udvz/WuS56byuxvoDmIKvX5WOsg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:40:58.0296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e38af13b-75f4-4b0f-a555-08dc9912a7a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
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

This patch is to add firmware for GC 11.5.2.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9acdabd7719a..38150398a31b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -93,6 +93,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_1_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_rlc.bin");
 
 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index a9f5d9e4610d..6c1891889c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -38,6 +38,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3b1f6ad99100..1376b6ff1b77 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -51,6 +51,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes1.bin");
 
 static int mes_v11_0_hw_init(void *handle);
 static int mes_v11_0_hw_fini(void *handle);
-- 
2.43.0

