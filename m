Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898D9D5B863
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213FB10E4B5;
	Mon, 15 Dec 2025 18:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K915ozmY";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B6410E4B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DadTFri/Ez9MoBb13tVRfKepTntzTyxt7ASQ2hJZySUtyG0dSeu93Kgg7q2emNuOaGWM9mwS+7fCfBU7Gj3p1GXrbdgxtBvnFNom5ZtO3kngawerD0cFHelU5ZsvYodm1vumzCboV1MquNpx8n6qhMuE0LPIIIrmoZSxQoql1f566QoJzB2F68bVYin9pgi30HyVPd+N4hiFD6EVUuKmzNnvCIGwCWXI3JIngmXqjhIHq2cGPIlXiAGxOgC///xWayEzQ3OcZObBgdo81vfhQTNQeTpLaxJEEkP9RkQoiIEQ/pM1Z8XFm8xO/Xz116KWpoW9ONCZLYBMlDF3yD7L3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8XDUxiM+x7OU/eKsSk+aRM1A44Z8IzKIOsQR8XQ4YA=;
 b=eHgc4m+Ggq3GhXwRoIhXA4931OW8X1iZF9Oq1OMsi9hyb9bXBGBtVaTN4/qeil4eXlQBYo4zWKKm6FMC1A4pb/46O7wpOfazep+iC+FBaUzX+G1qwRofXO3wBmvpR2AxHdDkkbF0r4yvW6JEnbKOJS0KxRG1MouSJKt9syF7GElRH6K0gxNuQlpSokir8uJiVKNL4jZQQ18SFZBJQHcnat9+9Kn5Xu6Fmz47u+ulIKj7NuUx1/wLokoEJXmTczvUYIj++nuNcuaDTK9VlFNL8SHD7Iv50cGcD+6+cFaBc7P0eM6dA6YkbJP2Ret+vObajKxr3W5moafV05CFCTVHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8XDUxiM+x7OU/eKsSk+aRM1A44Z8IzKIOsQR8XQ4YA=;
 b=K915ozmYilKllbsz9gNugfE1hOYq+E5UJn99gf15krlRT9RnMjfRk6RXNuDQS6XgBgD0x796JFpXE1bTeTy4A91CPFOnr+W3OeMwFGT9Xq9asFAAu0GljlCx+2gfObv0co8FcZnyUzQR/MGh0IumLNV6GpTLK03l/EQc8MkphfE=
Received: from BL1PR13CA0239.namprd13.prod.outlook.com (2603:10b6:208:2bf::34)
 by LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:22 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a4) by BL1PR13CA0239.outlook.office365.com
 (2603:10b6:208:2bf::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:22 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: disable burst for gfx v12_1
Date: Mon, 15 Dec 2025 13:15:51 -0500
Message-ID: <20251215181607.29132-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 5283837e-2f9f-4652-269c-08de3c060d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DeGP5OUr0xIpDisk2s3stc0rpvSrDUCBqiuOuw0IDmUj11rjOJB34pCnmb+m?=
 =?us-ascii?Q?cu3h4G7mdJHzvlPs1ipuEDDp0kAfq7t2vAKmZAK0n7uk3xUlKX39UCghAhqL?=
 =?us-ascii?Q?GKipGU/H+yx2hqXYL0tPU21q8OQ9QXF5U734krijvJcgY1elildSFASUdRhL?=
 =?us-ascii?Q?CKAZF1NMtcwbMYdKvqzcgHR8xB7loBsfyIGEfLs4yL9BUBlMVHpLvdJzGq9F?=
 =?us-ascii?Q?0PGFvNhgTORPAfLxyUNIC4jU1dmPYqaAlYgc6o8A93aVoSO2r/gQT2UXzQJu?=
 =?us-ascii?Q?6tjsulXMTO/qRUFLN3Xp3uma6DKRYpYpBOT29v7TLsVIJX6kEh0IfFEtyRCx?=
 =?us-ascii?Q?sPtUvgBjAaZR2ygvbfBajhr+kv4xiC9O8li/KrjsSvTE4i3gA/QN3EwblruA?=
 =?us-ascii?Q?+SLhT6n/r/tln9JEDf1EEqUbNkdBnGXqfdORJTAUWGuFPXPaVimuZN7/KOh6?=
 =?us-ascii?Q?wZTPWIjJSEyhryjPrGhUcFdgXm9zCek5z53QPW4q1Vs979D/LXlh7fbSbitt?=
 =?us-ascii?Q?Xukh9hNMmNJRd2EeVo6llRFAHmX9b3Pp+8HT0EzUlfW34Q6WTYX+8f36nK80?=
 =?us-ascii?Q?Yi1OR3cmXC3BriHmjNqXc/CJ1f8Ac5gC7dGkECk9qcmR6FoK0IkqiZyRxHxd?=
 =?us-ascii?Q?ZjAyQD1SaoG7ctAP2g1OGhNy9CAbj02y6EmCSsLqZ+0Byzl3Sk/EdbOi1fwp?=
 =?us-ascii?Q?bcdNMrg5GQSQ45GtwHPIWMe3AZEMdqZbbRHZf6SYFL0am0llB5pH2Kn3C6+O?=
 =?us-ascii?Q?SNkXDH9A3+aH7C5GpQKEXEes3QZoMI9CYAshwwuOywekCfHavXCbQByy6/nF?=
 =?us-ascii?Q?NOgwXySO/i8nCZMKa/sARNCm7BeFAN8mzEGG+6KSQExzRQ1p0nIMp3abhHqQ?=
 =?us-ascii?Q?qtofDdKsFvoQSGyht4h0Xs+rntUDS8OJ5GMu1oes6bPjLs8S545vYvOTqQDh?=
 =?us-ascii?Q?aLN2/5Kr7yX97r4XzFBsGTKUG1hhSVlUHXQ2CXcneSwdteXPBD4W7GjgK/EQ?=
 =?us-ascii?Q?G2LuhqHVJ9+FSxRlQtEHS9xCO4zDeBQs2tbzzrYYryGxIKTTfDDT3uYvJpCu?=
 =?us-ascii?Q?YePbxXqm1NQC06bI/MCNMnR0K2zjM/wANWThAh0V093h3czWadSE+ZIR/4EU?=
 =?us-ascii?Q?bCLK9okaRNGF8I1Tf6zdwUFMnSNI12kJF18pBRmvzgW04JuG/rdNaM1U1diO?=
 =?us-ascii?Q?JqkGlrDzUnHmEaeLGhs5G9YQ73MwNZvw96uCjuvjCH/CMkhaf4TOCxM6dwR3?=
 =?us-ascii?Q?iNnthvpoOnyeMCmR4r5Y03vOL8iMRqoxU9Hu/ZT0ZkOXrWHaW6hSoIybnvl1?=
 =?us-ascii?Q?+gullFRFwBSuBszB64hAZBePQVfADeSOb7ettTs2pyuqNfHCzZsrWkrHegyL?=
 =?us-ascii?Q?gzby9z20hdanscgbBr9gvmvc4LkAK6GXld+VZEnDQU5Vqi5agP6vdfkbwfJH?=
 =?us-ascii?Q?f3AxrWTU1MGoNlkcBYqrvbIgsz8ATOUHH8yq0uA9aUMOyr9PxDsEAdgcmwQW?=
 =?us-ascii?Q?TNLoNsGUTnLV0qiSC0B74rHwb0CVX/ew45tjRQePb8Q3I6F056pMMUvlnU0l?=
 =?us-ascii?Q?UeZv5WY6h1koGK/AA10=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:22.4029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5283837e-2f9f-4652-269c-08de3c060d57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783
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

From: Likun Gao <Likun.Gao@amd.com>

Disable burst in GL1A and GLARBA for gfx v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 6777319234969..c2b9311831646 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2637,11 +2637,19 @@ static void gfx_v12_1_xcc_enable_atomics(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regTCP_UTCL0_CNTL1, data);
 }
 
+static void gfx_v12_1_xcc_disable_burst(struct amdgpu_device *adev,
+					int xcc_id)
+{
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGL1_DRAM_BURST_CTRL, 0xf);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGLARB_DRAM_BURST_CTRL, 0xf);
+}
+
 static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 {
 	int i;
 
 	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); i++) {
+		gfx_v12_1_xcc_disable_burst(adev, i);
 		gfx_v12_1_xcc_enable_atomics(adev, i);
 		gfx_v12_1_xcc_setup_tcp_thrashing_ctrl(adev, i);
 	}
-- 
2.52.0

