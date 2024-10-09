Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEF3CED614
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 07:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B41910E095;
	Wed,  9 Oct 2024 07:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yUu/AQQP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC9410E095
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 07:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mttXPg1FBR8bpFhFxrKT0yHu7UW9urmJkjhTj98Ay6J9ZeeGf6RxV6+FDz+uWMJ+sGhxwjp9ys1lDsMQJYrHNGUVLzmWnTJKKx53L/JrbCN/rAeAhyNGw/2Ceg3fgX3DPSpKgr9Dk3mdmlGhsWYvwiRZRo+k66b5pzEE3KCIg8whnUcNz3BVu4mPNy3sciqBr/WF+FCNVe9Ge9BnLuW5YN/wuFsiW8KNLZzHT8789OaJVcxMuCf6cq/wce9Lj5SgrIkFKs8RyUyMKH1QAY8KcucIYtiGtfeSpCy0rL8TzAfNvLAVPMIfYADSN7oxISJm5JDlm0Ytl9o475cyZDF0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhhQEudBm8Sp60D2o7Q9iOrPZ09PSJoiNhEWmY+4cMY=;
 b=xKMhFQSbP5jJnQbAWJwOkslSMgLDt3P8MPMl6xjfPZ/Rf9jCEtYlyLEyFZ8YTEPl0YU1wPtcka45NJJvrVHHJVs6o270vXghop6K7hS62cAlAsOik9Np0F51rtoVf2jGhO53/iTKaYUVf8wDluoAHlYyd/XqMcQcBhwFT1F3ZNW4GEUHBhc/Ls4+HyUngoGRQfEDTVH8atDulJbWo90l4TKxpF8+sn+geqb05MnPYyp/1qt327efkoLrPNpkctEXCNnW7KNiJ5YyTpxUHhHleLlfy2KkyWV+I6v8RIHAHGjcuZ0qhBInQARTRFSoPBnbLr267tBcjbNBNXPCvbPXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhhQEudBm8Sp60D2o7Q9iOrPZ09PSJoiNhEWmY+4cMY=;
 b=yUu/AQQP7lzFOR7C00Nt58GzkCL74GYXsI8pt6k5cM1cwBNxpCsrnmtCLGo7sxLdBbRbhH6z/Vuk9s9wX8M+OPUER5X03ju1VKx5N6oVUbwqCuhQJu96YbC4DQQHreaRCFn3I7INsg4ASy/Q8FIQJspZYOSGtMWJVZG8KOQBdJ8=
Received: from CH0P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::27)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 07:23:55 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::cc) by CH0P221CA0044.outlook.office365.com
 (2603:10b6:610:11d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 07:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 07:23:54 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 02:23:53 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v3 1/3] drm/amd/pm: update smu_v13_0_6 smu header
Date: Wed, 9 Oct 2024 15:22:47 +0800
Message-ID: <20241009072249.546857-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 171b52f6-936e-41b1-3856-08dce833551f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?co/1Hnb/T4Ed+PLuU6dt4JCEfD4t2yOB8hhwmPsH3ygPfx2hfoR948pbOTFb?=
 =?us-ascii?Q?P3u7/NZPZqO3Lr+fxwUOnHEQofh7fC8opzgp8WWIwkx0Fxn8Vzj8GtqmVTD+?=
 =?us-ascii?Q?oQLJXm7wB4gjwkAOsC4ZyOIebAs/klvSeJ5k4HMSM+JZLDq1qwTDc7GGzmaJ?=
 =?us-ascii?Q?lH3TTmcUF+/I3VVHR2FhFj4VRfawibn3vlfzGwHGGEEAiqWHKGP7E/oebDYX?=
 =?us-ascii?Q?kl0q1tsKPq9nEd40h12iG4gQBjWdnggA83d+pFFcipYpfl8UhReMJyI2m19W?=
 =?us-ascii?Q?l4GGKqPQCxLQ2eZeVYLPLK+PvlubfTJYpo4x8pXQZBlHgxnFgNSeQjOqjT3y?=
 =?us-ascii?Q?HMsyyIN+arQ9xZmUlJ6aRqloQYAIOAgBK/Jul+djXzZ1lkDm9Y3Z089ezFh+?=
 =?us-ascii?Q?F1zNWSvY9qFq5h+lMuBeodbNOJbPIFerGhfhdQR1GOSJxIj0RNSzgS8pnaO5?=
 =?us-ascii?Q?MNeNsRa8sDHxqUq+WY+3DhKDObW0Upag/3Mj1TiHZkzPBZDsYBCvq01/furX?=
 =?us-ascii?Q?xn7ZBQZ1Ze/8kVCnNqZBgogTlmxOMuBGscWzgxiTIEG+OcANWwj9n0UdbgEc?=
 =?us-ascii?Q?9vm9wumoZCIUNgD6h6ImaeXaziilzJXHaBOOUAYjSqH0WVj8ojtmRERrU/3x?=
 =?us-ascii?Q?UGjIX/RIhU5NRK6MznbHyKny7PmiJVYGyyXFnFEI/7jIIEfUZeWwNuDt6+cI?=
 =?us-ascii?Q?iCvjaefpPcBaGQlXwlGhS7MmyZP3nrwmPErvHSZ/878Ir3fHkAQagyo2Ytb/?=
 =?us-ascii?Q?/jA9hHTEIGWzPQ763Jdgghv3AGy4J5QUzVqbCQJXjXHKrTlH3Czyd9OBUQ8f?=
 =?us-ascii?Q?JzvwbJT9xjB1UvSqOp0DrBY5mB53F/nECByPvv9hX21NAXI3/4T9d+9eicsv?=
 =?us-ascii?Q?CCDY7xK0MyNPDMHC+2ewaOD0QOGNZXew+5tFd86RktjbvblexJ1eaLiFp9fB?=
 =?us-ascii?Q?VlrBn8zJdp4cnNkg/eXo70nFRdAzspAZnzU5FMjUvvDZVYuQaSAep1AvRH4D?=
 =?us-ascii?Q?g7eJMzQ7B+H0tIcnScQ+XUA7OiXtTDW9dIb4xtUQcRNtLYC14h+Omz0IfZQL?=
 =?us-ascii?Q?9E42UXr2nOH+4Jsi2RsKuBSezlpbsvpSfz3NFL0oVapV2EBVK/tpCbBj4dBY?=
 =?us-ascii?Q?luLFP9xoI9drboJGXdAQxFOM1ny6tugiyG6HX+/1V0tflFb5Nto0Db40u0Dt?=
 =?us-ascii?Q?DfqN8NoDcyQwAnm2WtdYMhvxgQhILkZnGd2edOAOcCoYt+4SEduuucvHvOWe?=
 =?us-ascii?Q?eMidUQI+fdpNMLUjKjypnIix4CCxWcB3GcQtG6uyHrBISeHX1a9nnS2QeSOG?=
 =?us-ascii?Q?IyxtxhIxC+VKzGQf/17u8bKgqeI6bhuB6W9vGNfoNgc5QF5mtJbwkR/wtSYH?=
 =?us-ascii?Q?1OwUQ/4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 07:23:54.8072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171b52f6-936e-41b1-3856-08dce833551f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

update smu header for sdma soft reset.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 41cb681927e2..147bfb12fd75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -93,7 +93,8 @@
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SelectPstatePolicy                0x44
-#define PPSMC_Message_Count                         0x45
+#define PPSMC_MSG_ResetSDMA                         0x4D
+#define PPSMC_Message_Count                         0x4E
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.25.1

