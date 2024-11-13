Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2B4D41C24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 09:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBAC410E35F;
	Wed, 13 Nov 2024 09:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YgVtX5kx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0DA10E35F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 09:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAApucpU+OY6hbH/pZJhjFYxkhij/zO97ySBxn0LXNZ3Up3nzsRxo6pnDmzPuBcOHf9liTRoOLpwgyeIYALOKTv+lYg540jBElF9LGvhy740qfgp6p7cAZCLDpLi1o9y3coZ/v6cob0pm6jl3uUVy+hCXk+cyG5Gp81+9BABd55yLRg0NwM6wS9tVegDgLOcKKIBLcBpdwIAgDSWg1y09gtubhy32qcRn18nLo7T1eiz/Pos/HIQF27ZLkJ1Upu9srXsv0qX4tzSsb9pFptj+Dbs5vkCcgxgYpSYz7r4aJQpXvSq7sXu7TWSuPinuEvp0jCyCi4A5F4w8O5dbgPHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdhxsllJvFi9X0Q+XydzZIyh64PynxigzWx+HfDASu0=;
 b=nBjFhZUN3B8yMgvVk+7rjk0KidTAojAmXoypLqTjyX6Wp79u7cceKFQtooYTGcNZSfZg0Z5B9f90S7E9FjlvPzESqptKMnhfVJ8Mh8gUnfiY6coK9dKK8fH94eCi/h+BIhZykHqfFCH6bvh5jLQ+novKEcUZeoTfNxmyl+Nkycf/l90tPDyEKl9zutiMeoBpqbxYo8c9xTv76ZgM2d1Z/qbDROxflPN1GZt1+5q5rqwXM9X6CnUKNnbPKJ64DmLuxX5B5y1mKoIju7HgrwqM3NyBn1fT2UduVmsjShOxCsYXwzW5bp6zZa2hyIHU8afEe7J58p00OPQXX0YPnuTa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdhxsllJvFi9X0Q+XydzZIyh64PynxigzWx+HfDASu0=;
 b=YgVtX5kxPWvt1pXzFP0XvVeWgQzw6CNqL7SfH+H8d78sUV0Q4lyEX5va8kIcujLlYejVCoOcgiPN7B6jmDJoPUU3dX+cIiqsgaeKgWssXQKHgd4WVkdw9Svj0uODP4kL0LZSGbA4S0vCRDFl/PkIsHBUwio//pZKz8QR/qyqmfI=
Received: from BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38) by
 DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Wed, 13 Nov 2024 09:31:01 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::92) by BYAPR01CA0061.outlook.office365.com
 (2603:10b6:a03:94::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 09:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 09:31:00 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 03:30:57 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <kevinyang.wang@amd.com>, <hawking.zhang@amd.com>
CC: <le.ma@amd.com>, <shiwu.zhang@amd.com>, <Asad.Kamal@amd.com>,
 <charis.poag@amd.com>, <donald.cheung@amd.com>, <sepehr.khatir@amd.com>,
 <daniel.oliveira@amd.com>
Subject: [PATCH] drm/amd/pm: Update data types used for uapi i/f
Date: Wed, 13 Nov 2024 17:30:43 +0800
Message-ID: <20241113093043.1313004-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: b56f467c-de39-4b33-0afd-08dd03c5e30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xz8KrQBQPmpDtwSn84TUQUqsTa44DFAupUMC+/B/qgJNuckfBg5F5QNkcpDB?=
 =?us-ascii?Q?h3xbyGaJFdwU/MzCmYkyLgntZ/oaowSHYnUFOn0aM05LneP83Djv794jtJsS?=
 =?us-ascii?Q?E5v6WyELzwEvruFTAuR4rk6a6xv2jTy81P5042iygE3g8WXl2ghk+3NAP5cN?=
 =?us-ascii?Q?Wn2xxz5WBUHnk1TNmwu9Nd38tpV89vnJPkTJ8VP4+lmgC1hCOtcJipfVLR+U?=
 =?us-ascii?Q?HSDAp+Bc89IDb8E0gv36pqXZ70m9GF5sYP6SesJod1nk/cIpxzV3BXMNNS1B?=
 =?us-ascii?Q?COE86BGtP9deKgBcG7+7V6PAv5IJJgEoinXpFD8trnsX86tWQX4DBA4bA/1M?=
 =?us-ascii?Q?ZqUetqC0jUIRWOCfrTJdhoob5XM++/E53dCYb2Ydh2w/pquYrpkOBgUvKaB7?=
 =?us-ascii?Q?xMWPtZUY7fCIJp4LYciT48lq5r56CO/1WkZWgfMrWFe1HEv13cnD4EV+xE/U?=
 =?us-ascii?Q?h1zk6f+pvxe5lUjJB5E6lP6f/gJ+qTDwTaKzClHi3tRbouXZ9WjrITZQ01O4?=
 =?us-ascii?Q?0/UR3r9ultvkALwEpbxNEpcoCpmDipokTcxMLYxp1JistSHFciHZsc3w+nb0?=
 =?us-ascii?Q?toDplPh0/WrwT9vc4tX9cObk6476oekBVyPRTkpSMahCOHCx0W7UVAHtuyQ7?=
 =?us-ascii?Q?H7BdV1Hgxdc21102Km2hm0NguEPllHs5Emlzjy9HRBrW3Ibba4UZCg1bV96J?=
 =?us-ascii?Q?pv2UJIslTh0wYx14GhD7rOt6w1a2flOeQdMuNWVi4a9Ocxl/rxYqt+vutap7?=
 =?us-ascii?Q?o4RocZabH7ziDAGmefMS23QWgiX1YooGtz9Rqhm4B/O9zyj1mzw1iZHbuHPt?=
 =?us-ascii?Q?6gktwYM12osUzQ641pn0H85RmWSiia6nYqZMc+ARVEXcnYq2nnkOHZmt80/N?=
 =?us-ascii?Q?cGVJx2eV69gdyTIFB3W7V/RLMC7DgCFpJI75jGyrhiTIoCANGkqCheVyZFvU?=
 =?us-ascii?Q?rhTSiRBpaQrcfWeQYCqifFRST2E/F6na0cIhgleydQAEQD6GzCrDJPf0LVhJ?=
 =?us-ascii?Q?WAxTzCzPrXrWe1rbl3hoX/EyU8r6EStunfBfa1jxJS2iePTm8L8cGm5W0S88?=
 =?us-ascii?Q?oyQMEdt6ThLTnDPk2EOazy41hUSL8vQrNvDjZZRvSe21rAdqdOhM4md2NON6?=
 =?us-ascii?Q?EW4TdI2BtwL7NLrzVKgrLQbC14EluK9NWrva7ckJUdlLVFXxPjQg64cZG4Jm?=
 =?us-ascii?Q?X/UXr//VUfOa1kSznp4oZ2PaOxbOYZf56Q9wFFgry/te6GHgjWV0JPira2g3?=
 =?us-ascii?Q?PnZvhYinBnCf+XBskJPiW6C8FnYHOkEcfJdGxAQ4vEg99lEONqpUqn2VdiEK?=
 =?us-ascii?Q?jBtYDTNSAGA26wToyosph6hx+DRFeR4LGOeHDtl6fAAA/0bGnTRyqiP+P2z9?=
 =?us-ascii?Q?X1ovTjYsQFyUIo2QDR340wfSkufd+V7zswHCUqXb3Wg9zmaqWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:31:00.7639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b56f467c-de39-4b33-0afd-08dd03c5e30d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
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

Update member's data type in amdgpu_xcp_metrics from linux specific
to the ones compatible to uapi interface

Fixes: 155fa7ced39b ("drm/amd/pm: Add gpu_metrics_v1_6")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index ee8170cda1d7..80f7afc5c959 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -357,11 +357,11 @@ struct dpm_clocks;
 
 struct amdgpu_xcp_metrics {
 	/* Utilization Instantaneous (%) */
-	u32 gfx_busy_inst[MAX_XCC];
-	u16 jpeg_busy[NUM_JPEG_ENG];
-	u16 vcn_busy[NUM_VCN];
+	uint32_t gfx_busy_inst[MAX_XCC];
+	uint16_t jpeg_busy[NUM_JPEG_ENG];
+	uint16_t vcn_busy[NUM_VCN];
 	/* Utilization Accumulated (%) */
-	u64 gfx_busy_acc[MAX_XCC];
+	uint64_t gfx_busy_acc[MAX_XCC];
 };
 
 struct amd_pm_funcs {
-- 
2.46.0

