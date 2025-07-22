Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A44C83F34
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45BD110E721;
	Tue, 22 Jul 2025 22:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QYfzfkg5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAF110E720
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKtl80B1UCf/Mxx5veWJSGHKycDDO2yCtrmUxS+RKwQ8ZGZsvNN+3MEfkIuPxbQCP/UPtafQWH/Nq7CxE9BIplhwkrw6gNYG/q9n0QPRihmVUUjrVHaAAD/e7iqTvl0D0sGtZ4ZT4xxcmMq9/bCTKmoI7igzajZWmVbAzabyym/H2OoyRdmLk60x77QLrp2qZg0s5EX/U3qEDS/uf9ARf/GgWJwKHPxgcrjtBX7lJoG+4w3ZWMlVCMPEXs2Twb1EjT84xXgWbSRr0Q0sGh6vrPbDJ0a8JS4z6nnRYK0ATnBUnYLzkz28QallCDCseDrPxpeDcNj0lVWk6rAboz0a8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Onw9q4KPJ8OD1/aN8j8+Na8PiiUN4CNsAs1YiQzicqE=;
 b=yqCajbUWRLVccJJ6yfFxxUO3Ytywg/cP6jCIEBhqG92RPMQ9tLqkP/g79Vps7y7RVm1mZaMz0TZThr5fI+JMMQPsO3SPXiq+XAmIMPBxzZjU35XOEfWRL6vWPFK+8N3fqKBP0jotyZE1RKzLCq0SrD8yZ19MxbZoTWyfRm7MpN4RL4jEMstFT3ulMSXrI5u2UZaP0yZjGcobjcLE+1bkF/Y68+XtYcY5e23CryIrgPMA3BYewYlAWW/q/tJJ/R0Idc6tLky4Qf1D/YrBz184A/1g4jirD79d+fui6nYP0PTM8/fQYxRkn4k5d9hXf+myXp7b4TkI6HS3PmkMmuBpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Onw9q4KPJ8OD1/aN8j8+Na8PiiUN4CNsAs1YiQzicqE=;
 b=QYfzfkg50qJgoTjPPhY+rxpJVsx76mNJ6aRt+OR/90Yc3yw8lv1BKS+drptbU9xfSA1ZVMeKZwVnvGDLu6M2Icrns5xJ/eg2rvyy4tOaAaSZprpmImO34zMPFLh8QKlho8OQKoB712/JwldtzqJixNWsgasVczWfHipoZ6fYvw0=
Received: from MN2PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:c0::15)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:39:26 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::db) by MN2PR05CA0002.outlook.office365.com
 (2603:10b6:208:c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:24 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:24 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 07/25] drm/amd/display: Add missing SPDX license identifier
Date: Tue, 22 Jul 2025 18:36:13 -0400
Message-ID: <20250722223911.2655505-8-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 0636cc33-e4f3-4408-9256-08ddc9709c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x84yjr5HoMB2PmdM9py3minrxOyRWFZy3+UQ+Dqm6wLoEaAzL/REmBaUjBLj?=
 =?us-ascii?Q?AETVfjjthRQinpRPFTpuI6SL9eUFcGJeH/VKcfV+eRzflFQARtIp8CUMiR3e?=
 =?us-ascii?Q?9A/2zq3Wsop1HV1h76vO4i9Nd/PVU4nHquVFZ1YsPlVE1Ws2HFAkqhEW6q9S?=
 =?us-ascii?Q?X+RYbOQ2z9qjJ6PNwd0ZH5z7/XZCmJJGC9mmXiUjZjhQkkzE/vCiJCS9Y5e+?=
 =?us-ascii?Q?U9f3cITxs1hD97CaY9ST5RFuwljKjlo1a8kv1x60e/pggZnZrzPK6opS13H2?=
 =?us-ascii?Q?Zu2z7DnC6xfzF5mIfroiWD9rviRBaI9cwYkhJ4gZjammhsxPznE7ASYXg0id?=
 =?us-ascii?Q?3JQ+yJfcX5OoICFGRNScLQzcT4rFx8mG3M5G5C8dT8uDU9ru3v/NwbxTH2Ot?=
 =?us-ascii?Q?f9vcyuv9OKSccqbd5pmkxvUaPtcF353LpWrB1LipAhd/L0hkKIqsfl1M+yD3?=
 =?us-ascii?Q?QopmQbyViAgh32062Ec3bgP5he8JCDfHue8P2BLYp31FZKe99awJV2ncaZDr?=
 =?us-ascii?Q?/AmohDaegUsai6akfdcIHxOoM2A5/ZDFdk3qOjXqouSyzdPPyptkvndb47V7?=
 =?us-ascii?Q?C4gyBPNbHDY8eMl4OydJbONdz2tCQe6Q286m2eyR+VNG4VuFKvuJTxRsd80q?=
 =?us-ascii?Q?EcL6EnycaaOl4P12sa/IevV0tRPGD1vABtUB1+wo+CsOHPxbbn/Xr+JKhR3U?=
 =?us-ascii?Q?5RWOBFmRrM9uNzdgAt6eNsKT2DAjUT8TejjZWWQ1oOiDi1SqX2lcnt6ZEEua?=
 =?us-ascii?Q?zPeFYhYSw4aLFg3HwV0TznM+4V3p+w3JKsdj2AMfR42JvBiO5KJUe++KN0Qw?=
 =?us-ascii?Q?jDrPditcrMsKAcOfix/vgCtuiY5AhrfJNA77DdGH1Qqxt5umbXQQzebYsL+L?=
 =?us-ascii?Q?LcoJcbflIfqpKL9BgRdhvBaNAN63w2H/1HKpxDpJMQxcE/j1hgwra1Y4olF6?=
 =?us-ascii?Q?MHV7wWO53Ss4KOaJWGgI1IPleDQOmvxBH1T0fc0xQxGhthnnzO68Hle39a0G?=
 =?us-ascii?Q?TidZZ/4IUs0JC53SS7Pt/HM9s5kFPgaUdDmHOCkPpYpw0yT9qCjeeqc5fYAB?=
 =?us-ascii?Q?8V8b2XYEEKYR84jr465l5gDoRgy4nmf/r8+OGmVdydAwN9EP+WGWls3oDJLN?=
 =?us-ascii?Q?vr3w9nBuXszDMlhbUtaMum0i95ddmvfysGKAZ/n4rWLXcQynm7oJjZa5gYwq?=
 =?us-ascii?Q?0miVNLhz9IGabwITpNlX1Xbg97QaX1JOtdz1dAAg8yRfXZl8YWIB5k/dYwUr?=
 =?us-ascii?Q?mMlSTDtIeKMh/XSfZ13Tmye4I1F1CEIbiZdYC9wI/7O6eNI7t1LswzGRNsJS?=
 =?us-ascii?Q?ddJkTWUUskEDoCRFHiPjllDSeBsZOpqLnOHgBVhKYSdiDZhJQkCW/Udl7yR/?=
 =?us-ascii?Q?6F2vHwCNhgMqzYjIwJhDNN1Bdn9QYxwPsySqmMUpFpXOngQeUEoQZiRieIp7?=
 =?us-ascii?Q?bo3SDvIhPPar9RrXYR7DzoOBFiS+6Iqj+obvWhvxEX+8xtweSBpHdxjS5bHK?=
 =?us-ascii?Q?jPCPobkwxtl8bU6wpSlcL8k1Zo6ro+ctuG+F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:25.3918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0636cc33-e4f3-4408-9256-08ddc9709c6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
All files should be properly classified.

[How]
Add missing SPDX-License-Identifier.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            | 2 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h            | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c      | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c        | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h        | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h    | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c       | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h       | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c        | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h        | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h  | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c     | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c        | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h        | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c     | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h     | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c   | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h      | 1 +
 22 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 129476b6d5fa..7e024632399f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2015 Advanced Micro Devices, Inc.
  *
@@ -10392,6 +10393,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 				if (amdgpu_dm_crc_window_is_activated(crtc)) {
 					uint8_t cnt;
+
 					spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 					for (cnt = 0; cnt < MAX_CRC_WINDOW_NUM; cnt++) {
 						if (acrtc->dm_irq_params.window_param[cnt].enable) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b937da0a4e4a..67c3a7a967f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright (C) 2015-2020 Advanced Micro Devices, Inc. All rights reserved.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index ebabfe3a512f..ff97785b60a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2018 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 033bd817d871..e20aa7438066 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2015 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 3da056c8d20b..95bdb8699d7f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2019 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index b726bcd18e29..484691335fd6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2018 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h
index 071200473c27..122cdc124b3b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2018 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 26922d870b89..d1c853732c2e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2019 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 69b445b011c8..4faa344f196e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2019 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9e3e51a2dc49..fe100e4c9801 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2015 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index b61e210f6246..a1c722112c22 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2015 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index ba17c23b2706..4f6b58f4f90d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2015 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
index 6c9de834455b..3c9995275cbd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2020 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7187d5aedf0a..137f18d41f1b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2012-15 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 600d6e221011..65f76a7d00db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2012-15 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 848c5b4bb301..e5771f490f2e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2018 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index f984cb0cb889..5d7098c337d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2021 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index e2366321a3c1..4fb8626913cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2021 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 41f07f13a7b5..82ea3fe5e764 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2023 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
index 8126bdb1eb6b..73b6c67ae5e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2021 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 0005f5f8f34f..132de4071efd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -1,3 +1,4 @@
+//SPDX-License-Identifier: MIT
 /*
  * Copyright 2015 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 95f890fda8aa..aa56fd6d56c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -1,3 +1,4 @@
+//SPDX-License-Identifier: MIT
 /*
  * Copyright 2018 Advanced Micro Devices, Inc.
  *
-- 
2.43.0

