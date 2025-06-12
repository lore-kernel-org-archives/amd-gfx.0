Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97739C71136
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 12:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAD410E826;
	Thu, 12 Jun 2025 12:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EwbchjqE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3683F10E820
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 12:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y80RGAv6vIQmxO+LkNl8+bNkmipbed4n+9mz6oLWGaCKxcIU/gtPLX4HkWkLTOd4ce8xBgbm7CO4l/1rdMPQovYC68S3JfBT02DGpf3lGsWtm+kG+j7AXs6eeNQalV6hLwOjDx0YafchBl8Bu6Cdm1GZsjMm2KvRm6Me9qoKBjC3fIuGrw+WugllgjmeZy+Y32MwCzrWC7v9xZCPplTH9n0XR6euLDJtDSd8iGo2TkWI/BdUTIx1IWPuPJ1T4s2HoKXmgRLSbsDyz6RyBGYCjfpXvSFPLJYjAbCK7b9YEUMJ8P7gCQjBUhIKZochJByKO9tXaTi7rIpTTs1OyMg4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNd1guuKgWzoo/rWLacSyXm/5fM27MyUzUpZKchm9PY=;
 b=X2gD3nJrDAbYI5zayhaadtKIcsA7P3fabFtYSAQVwog8gVIABGzdWXr1KhmtNaEZjHpavexAVGN3Ui4J6sM5HHE/2Fsq47Zx5MA7irghy12QYnJYZKvkbK5IinvaMjL9XqEW9s3n44oFifVU1CxkgFQx8TvNoWYN828NPSonQqJncD1aEUDArx4qxKTZO1pg4zrS+dYBe1t/DmxVq/XJo9fSDounV7vUuVWz6zEvv841vYZ0hGBN13KDpWrmynYQYvlRQVOsfSr44rJuDrbEiyHYwSL0wMKnb0Hc+Qf5/RTkOwTfrKwC30RvAWGaE3Tir2d8fwWEehq7ixkG/Wb56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNd1guuKgWzoo/rWLacSyXm/5fM27MyUzUpZKchm9PY=;
 b=EwbchjqECIKkhq31noJSSd2NuvO7nNdd4hFaYleJrFckRkbuNG5c0V3DapfIyioRx/7DbFzjZHr+jSPS29vNSe+4JSs4e+BLBxt148PpYCpglK7j1Wg3bo0O+/lVIUQdCyq7h8EsQGLVvFFdK0egZxHWcVSScXjZHyeGWYCGuGU=
Received: from CH0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:610:e7::34)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Thu, 12 Jun
 2025 12:23:40 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::54) by CH0PR03CA0239.outlook.office365.com
 (2603:10b6:610:e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 12:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 12:23:39 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 07:23:37 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kent.russell@amd.com>, <palmer@dabbelt.com>
Subject: [PATCH] drm/amd/pm: Use pointer type for typecheck()
Date: Thu, 12 Jun 2025 17:53:21 +0530
Message-ID: <20250612122321.801690-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: b8057c5a-fd26-45ea-c009-08dda9abf692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?brj1aRVTtEOxmhq2aj4wKZhMCZVhh+iM5QMba2lqBI3NoJDHty49dpDlMaBK?=
 =?us-ascii?Q?ajWLcxxewhI5aJoqtbTtOCj6Kg/foKHlb4epkpL3uAG240Iqvr0LN/meS+R2?=
 =?us-ascii?Q?+BkRGbv+8hh15oJzAc3NA3QWRbFiC8Tj09LtgYw0yPiU4jQ4Ly4XGf8rrrTD?=
 =?us-ascii?Q?rSb/IWvj7BNcFLZin8Wj653ezWyGjgX9b6dQlzILCNjvOyr646aIjs8F3azT?=
 =?us-ascii?Q?UREBrTTqgocy0cpD/J+LR4sxPvEFVh8xajq3yVxZpFzZaZkawkXo4fPDB3nH?=
 =?us-ascii?Q?Lkjc/rTiB0b183PvG3AgsRfDQpV4wWarB8NTgGcYihZhZbG6FmEWXWVM/l2A?=
 =?us-ascii?Q?hQ4+KbiUBXkp1aQVJwqUk87o6XTmmNhc031pHi50NegCCMiCzsNggifvgKRw?=
 =?us-ascii?Q?cNaZALVFqD1X6fwu4wUoo40rWE7iJo8dCRK5d1ASsI5LM6eKYr8wKrK3QexV?=
 =?us-ascii?Q?4wQVvhT51AJwN/Eou4Rh799QpV2t9d9ofbgoW76SM8tCOOqyApzLx0ReX+oO?=
 =?us-ascii?Q?4REIouWZoFAPju66G+B3ErD3S+pCVybLQE1bAp8q3vmgdlb4yECEO9fX/Jzt?=
 =?us-ascii?Q?ftPzd8p2b3WrnGzUXJgwciN1QXV+eLuqhM3s0MGrvD9JrDJREL34BNj9MNQZ?=
 =?us-ascii?Q?4Lu/4ysZyRynSMsBmXegi1oekzX6NBQGl5MfL1kWGQwajR+SdutsCP5vq78o?=
 =?us-ascii?Q?mAMRUdp7tIXoagLzfMygguI45xPw6QEakWkDYAACH+vK9ff5pYmcJmwdhSe4?=
 =?us-ascii?Q?z3woOpMEyPMHqNnLn0DciGMlsr4boylG4SefFkuRbPnBFzuzm8Bnfcs7fWig?=
 =?us-ascii?Q?a8hdmDVPQza0b3C2EtywhAIJZkdcNzeibvZlcWfKFyeNET/raqSQOU27OEnE?=
 =?us-ascii?Q?mhHgvP7ZIAXESGVC2z9D/q7ke2/yBn4KXGnq42H7lgGHIEHS36+wd7z3WhO4?=
 =?us-ascii?Q?uJxJ7+ScwAn7l0FLtjXjxTMT+tDFfXJOhsUEPwCve5z2KJ1PguAHqszECnNm?=
 =?us-ascii?Q?DDWYGBpzzz/TRBvYU3CXsxrWxzkAnGLZsqyV0b/PD6x7sPlVtu38P05KGf5Y?=
 =?us-ascii?Q?A+lDFaICSgPYRgvMDrlUFFNCSiP0SbmOINj0QV9F040RarpQuBCw0rFptYfu?=
 =?us-ascii?Q?6QDbrYWZgWoRvN7Tfaw3xfGPmgr3SEKC7X7UKiC2b0XqSPvp1uvBpu61nGPP?=
 =?us-ascii?Q?59QfV4fLSOQ8gyuQgB6c5pywDjp4HpHd9twdwaD/gU/vfeftf/S8yOND20wN?=
 =?us-ascii?Q?Uo2kk4pIZVKmXBDgaDZLsxNqn3sGI8OmqoPism0vfVs2Zl8o4SDmBZMVC9Vh?=
 =?us-ascii?Q?sPwknJaFfitdtVeFkWZFQDc3DxuNDACzv1m6gxs1N44KrC8jXPxb14bKu0AK?=
 =?us-ascii?Q?HaIPbVmqaidHgT42zcmrDJ6asKpLVNyyNizMhCo78MMz2dBqycwbG5eXQyIH?=
 =?us-ascii?Q?orH8Mo3oZWoboCteS9ByKTWFafus5vpMhv89bHnsZrMv1PUt5gKjq7SQvhOc?=
 =?us-ascii?Q?HeSQotrhu1woWuhUfz9S47hc+hoegrbRx5z2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:23:39.7237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8057c5a-fd26-45ea-c009-08dda9abf692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
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

typecheck creates local variables based on the type passed. That could
result in stack frame size warnings like below in certain configs:

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:2885:1: error: the frame size of 8304 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Checking against the pointer type is sufficient for the purpose of
getting a diagnostic message during build time.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 41 +++++++++++++-------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 7473672abd2a..a608cdbdada4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,28 +40,29 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
 
-#define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)         \
-	do {                                                   \
-		typecheck(struct gpu_metrics_v##frev##_##crev, \
-			  typeof(*(ptr)));                     \
-		struct metrics_table_header *header =          \
-			(struct metrics_table_header *)(ptr);  \
-		memset(header, 0xFF, sizeof(*(ptr)));          \
-		header->format_revision = frev;                \
-		header->content_revision = crev;               \
-		header->structure_size = sizeof(*(ptr));       \
+#define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)                   \
+	do {                                                             \
+		typecheck(struct gpu_metrics_v##frev##_##crev *, (ptr)); \
+		struct gpu_metrics_v##frev##_##crev *tmp = (ptr);        \
+		struct metrics_table_header *header =                    \
+			(struct metrics_table_header *)tmp;              \
+		memset(header, 0xFF, sizeof(*tmp));                      \
+		header->format_revision = frev;                          \
+		header->content_revision = crev;                         \
+		header->structure_size = sizeof(*tmp);                   \
 	} while (0)
 
-#define smu_cmn_init_partition_metrics(ptr, frev, crev)                     \
-	do {                                                                \
-		typecheck(struct amdgpu_partition_metrics_v##frev##_##crev, \
-			  typeof(*(ptr)));                                  \
-		struct metrics_table_header *header =                       \
-			(struct metrics_table_header *)(ptr);               \
-		memset(header, 0xFF, sizeof(*(ptr)));                       \
-		header->format_revision = frev;                             \
-		header->content_revision = crev;                            \
-		header->structure_size = sizeof(*(ptr));                    \
+#define smu_cmn_init_partition_metrics(ptr, fr, cr)                        \
+	do {                                                               \
+		typecheck(struct amdgpu_partition_metrics_v##fr##_##cr *,  \
+			  (ptr));                                          \
+		struct amdgpu_partition_metrics_v##fr##_##cr *tmp = (ptr); \
+		struct metrics_table_header *header =                      \
+			(struct metrics_table_header *)tmp;                \
+		memset(header, 0xFF, sizeof(*tmp));                        \
+		header->format_revision = fr;                              \
+		header->content_revision = cr;                             \
+		header->structure_size = sizeof(*tmp);                     \
 	} while (0)
 
 extern const int link_speed[];
-- 
2.25.1

