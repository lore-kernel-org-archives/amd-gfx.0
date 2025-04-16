Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A46C369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 05:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829AA10E200;
	Wed, 16 Apr 2025 05:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KPsSLDjJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D9F10E200
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2RvQ7RFYgKLlhTRclAAuW++qlRsaFk2Lx+n0UbUjVbzEO6r5o99/swtsikVUEPlNKxsBja3lp/5LIQR0duc2A880DFs/XDR6YpAgNyDgZPiKyTfvt6Ye9OCp1JhjsvplKd6zlWq0sW84yiPC97jyPS643ITfAgGzhQAoTxtihItPnAD4zef5q8y1hGb2rtNR2ZHrAChgmcO2ZCxQ8akjSJHofbftMgKy9wUxnvHJzys5EXsQHGiaU3GQyvFLkJv+/OErLX5PovUi8POzKef28T0xBbnO7F1sn+Y06XO/29qC+XBQz4hZT7+vZYNIu2VnC9LMQBJCj6gKHv+1C8vbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRHuLYLsSsk+zcyh5nD5+xqEjunRcOs+DU+rz3FKNeA=;
 b=sTdpbCr2lp3cj49esUO7RGVT9HAPtk60aqxkxKVc5GZbuLUBE+RIPZJGVCoZ/EL1wQIPGLiXS+qSOInBYH5WtMk7oxDEPhX8H5AjuH2MI0tHfiUdR+qSs25LXSKwkfsgW5nd9D9wfztiNd1gLLRxUr4CfAEK0cl2NWJB3IHt/5yeM7UmJnlYGw4X9XoOKh5I37jmFV0uDEa8yTFUhPCdDfztXZfqb52oqfOMpTR68zOxi+/l/Y3Ujzq2N09mYN7/OyQZHxIc7flcOs2EvILCQtM4HiIvSXV+bSbURpFgBuAc0ZyZA5h+yy7h4khtDPcwXsRB3bMtYgoKhii9iLimvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRHuLYLsSsk+zcyh5nD5+xqEjunRcOs+DU+rz3FKNeA=;
 b=KPsSLDjJHBp19JgppaClRH8Uh7viquBfUKvqdx48xN3ANs9W3Q24nkcLyYfA6YK5nrkTWSLrtOC5tKeRVctYDmkupqYSjkzIIW6ItrirwRruXxAUz5/n8WIEuViSZwdgfz518aaCum4McVbWW9pWyPfO+0/rElAzLdYEbCbhjhw=
Received: from SJ0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:2c0::6)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 05:31:47 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::95) by SJ0PR13CA0001.outlook.office365.com
 (2603:10b6:a03:2c0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 16 Apr 2025 05:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 05:31:46 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 00:31:43 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 2/7] drm/amd/pm: Update pmfw headers for smu_v_13_0_6
Date: Wed, 16 Apr 2025 13:31:22 +0800
Message-ID: <20250416053127.377955-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250416053127.377955-1-asad.kamal@amd.com>
References: <20250416053127.377955-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 62869bab-5bde-40fd-900b-08dd7ca7fadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XLD2KROMqsm6YQJmjuo/GMQ3rZ6HK3DCX9uf9ESWc4O0pdGZ/ipiH1o8cqa6?=
 =?us-ascii?Q?//tftjxLTveKnH6pwMhm4K0awk/WbkMH+mfk2xKnFyBFeA7TJHfp3wW3zLwG?=
 =?us-ascii?Q?oyBiR0UC5gnNcrntQKh6bvRvrvCGbyVrRPnsEtZsWeXeTyTef0AhqjsOzbgT?=
 =?us-ascii?Q?lk/AGAgAEGtnjgXPxtuJu9qNUb+LUSpaAb+NFx5368TI0iQcdEiCrMi2ShYy?=
 =?us-ascii?Q?2ZbPOZados4DsV8TQndbZD+jilMhAuv7cwgktslkHVOKVgF3AJAieJAcTk2k?=
 =?us-ascii?Q?Z2/j7NhkVdwnW2kh0YgwyOs4+r9LlsXNwSGSyx5xl6pT/3QCG1eTJFV1MqZx?=
 =?us-ascii?Q?sUCGcYzBHsu7IrWptPvQz4oTNFHMD1s54Cf4ZUsfHE6bWk0n3VxXfoTBvclF?=
 =?us-ascii?Q?yDTSR+OetXSyCgTsq7zZzVZoWzOYamh8GlHuEsgVT6WNNFFtI6QOKpB2DZ6k?=
 =?us-ascii?Q?xs3MNFzTr/8B8Knc3vy95FRNTkKyxxfLmJa9mZxSbV9Q/Ye6djX0D/Dh1hmY?=
 =?us-ascii?Q?F2YqU8tcWyq5rWWrnyZHYfW7Qgmwtaj3qLoKeNgmFb8vNpZLSsZkCfqFknIC?=
 =?us-ascii?Q?ygSCLi+SmR5s3Q0Gy3t2KQJl/ceKKm5DamqxD0lsGF6zcAseb3UJyTJZs3vG?=
 =?us-ascii?Q?QXsaujTd/MyQ7t80UZmIWBPaYGjaDlUvNBOwMO9oP9vksXroNUO0TNlF0vd/?=
 =?us-ascii?Q?hQV7rnRuw2YZ+fdyi6hfQbWNaWe2mioJ7KVyJX5O8qY3Dk/aRDW+KLcCU8OF?=
 =?us-ascii?Q?1zkwaxU+ca0uzTjcZe9FDUlH3j2F4/SwsWnEpAMByyJ0ZCYznrN6YLeHNeps?=
 =?us-ascii?Q?/EZ1OI1ejfCEoWr6GWPSe4S2MCVKnxsmfKQG+K1i6BvONqccWUDboLKRB391?=
 =?us-ascii?Q?J0TFniI8AbiFszquSkI0HzH+9nqDxglJNppe1oJ1gCkC7T43+lfzstg5DPiG?=
 =?us-ascii?Q?u5fEQxHvHb88c8LsJL9EMxxX9fvlY+pJ5ahDKg4OEXFgFenLa7pk/q2w9iGz?=
 =?us-ascii?Q?2e2UH8/79wQxzjmgsObSmJ7NuVh8dAHbf2tc/ENSHOinU4VRWDxgkII8+GTM?=
 =?us-ascii?Q?lmbUd2YnkMdNBElISainaAPO9vkDx3HkgOzJ6YoVIkbRkzznpVXCQF//cdJP?=
 =?us-ascii?Q?33TzhK7+ZAl4JGhUvOlXtpodyAsbwhkZ6UJOJXcveRrfhgR75ABOzamm6hN9?=
 =?us-ascii?Q?EFB7DTuay8jyFM4i0QWAE98LBz90dlt6SJfDwWutOJHj+6plzcfxbn/U07o4?=
 =?us-ascii?Q?f8WQkGDkeLsjxEk/b0xM6yMt1cWUgXg5bSzPfkQV8YskHEXW6jEsjDC6AdDJ?=
 =?us-ascii?Q?LysBDStiPftKvofhrUdmVntkKWtAQbAnf8+fGiseeh0gtw10UqJAAZI/GuH3?=
 =?us-ascii?Q?MQQh+RyuUjmqVGjyN0b3vxONS6OjOG5jdZuRxvyh4zwM1yANBlMfegkeCjYd?=
 =?us-ascii?Q?baXmYMIs/VeBKQ3yEfb4QAIUdT3BA6EBIPd2nSPmH1RnIpO8872QnRgDQzO/?=
 =?us-ascii?Q?ddmxQ20tD1SYXbdnPuAhLFV6qnM1yFNJ4lx0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 05:31:46.5213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62869bab-5bde-40fd-900b-08dd7ca7fadc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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

Update pmfw headers for smu_v_13_0_6 to include static metrics table

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 7 +++++++
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index d26f35119a12..3d9e5e967c94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -459,4 +459,11 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint64_t AccGfxclkBelowHostLimit;
 } VfMetricsTable_t;
 
+#pragma pack(push, 4)
+typedef struct {
+  // Telemetry
+  uint32_t InputTelemetryVoltageInmV;
+} StaticMetricsTable_t;
+#pragma pack(pop)
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 348d06a3200c..41f268313613 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -95,7 +95,8 @@
 #define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_MSG_ResetVCN                          0x4E
-#define PPSMC_Message_Count                         0x4F
+#define PPSMC_MSG_GetStaticMetricsTable             0x59
+#define PPSMC_Message_Count                         0x5A
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.46.0

