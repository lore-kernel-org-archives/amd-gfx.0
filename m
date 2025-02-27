Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBEEC282C1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 17:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8639110EB56;
	Thu, 27 Feb 2025 17:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wwly4x98";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516FD10EB56
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 17:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0Qy/aF4rl55S7Gt9UnhKPg3gB/UP7lhO3ZLxvfbOZwV+GwJW64M9XgfzTBZ8VMSsISnr3GUIdf+fdlou5lmJCo3R6tKvbGnoYiRiY1zzq+wHyKuM0f0nrVXEKHW/2EbPLF78MbBdKX+C8ATO0WxNpgF3F1wcGT3UsMtdKZHpelmVVQnYG3g2vcFisXycCDnKnQwIeF9pTlS+xgW70bRha92/d4+BUjwAlJd1ZD2ZNoLp5aMlNJ6Q+W6pJ66sE4j+gwwuQuBEUoF1T5oPHFHQJ/h0s/JDQWViM0Tvr0UJWjWvCtDJ+5O/p9NyNIbuygV0DS1WCDVvVEcs3ZyI+wXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WiI2QXPb/GeU5PpE4uLhUp0CA4YL9VHPcPBy8trfRc=;
 b=EF6I2jWOTRTqcyAnTLgXPKkUVAgIfiMu2V7g1CAkXGOo0nNX4GRlPZNEu3RAL9X4QZM+NkpvUgrg7OZbHF5eNu6MhcnaI3ednR6B0acIdNlQGJE+qBkaf8gHPp935RsJthqQvY2BxfnDpNRinLeb/klnT/MEbPa13FHXZDKAXGoV44E4t+zxqqZOvLxZNmiAi5u/0tpsyBlrGJkKHpcqOnKiPqix5mY1A7a1n/be9Ja+n1jjrTyqHPrlBT8eA6ATE0NWPfRdbBT774gaJyEt2jxx/CreRztDmyHX1nyS4EnkM0qXiBgc8BzQmp06BIIdGnV9TgZyF2fnsyn/QcFx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WiI2QXPb/GeU5PpE4uLhUp0CA4YL9VHPcPBy8trfRc=;
 b=Wwly4x9856LR9WTRXRmmfVOiGrKi7yWs4qhNOQYiOJeJZRfNwJT5YvwIZy1E/4x8WmpB4ApqMQpxw+PTJTgxBMCKDlF09I6s9tSjQXo7hh+Vp7V86B5GEM8Wl21Pz6IvnFPqOhSxXpmHfhryxLYpfdzFl2h0BlPak/MCe3KhRII=
Received: from SJ0PR13CA0099.namprd13.prod.outlook.com (2603:10b6:a03:2c5::14)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 17:32:25 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::56) by SJ0PR13CA0099.outlook.office365.com
 (2603:10b6:a03:2c5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 17:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 17:32:24 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 11:31:30 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: remove unused debug gws support status variable
Date: Thu, 27 Feb 2025 12:31:00 -0500
Message-ID: <20250227173100.3160647-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: c46f8c1a-a813-449f-f621-08dd5754b317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TEjYxp7C4ErcYYUY5eE1+xTnvN37fkoqA+6IBHYcoPF2+UcUVtAhByuz4apB?=
 =?us-ascii?Q?a0bkqci9thxhJsDxlOynylcN24oAwuRxtSCTZf2Zuo9kb5ZzS3xp4ptXercB?=
 =?us-ascii?Q?ymP8CmvIHMwd2QT2EC4qrmFr9aZf50iakIbUAeSKOvTuIVMUa8pqX6QuObEc?=
 =?us-ascii?Q?2OUMQjRMxoJbJUmfyfeEzHTwrBEe+2LqCjIJJRM0wjEsPpVWIa5ZBXd1rtnx?=
 =?us-ascii?Q?wFKL7Dqj+os0bayYZBdvulC/Lfr9sle2QOHpHm6j38tDlpCj8Kbt7Xl1hdua?=
 =?us-ascii?Q?qAju4t5ehnLUm5PKJFzODb8LdLCd2WNFKTsRBKhAMp/xLErvuXIRl3g27gKk?=
 =?us-ascii?Q?PtjlSZcz5M4IKH4ThmxKFgFmKX/K+wiumS2umQpxF5YXSYxaTwlfZKG1tK5R?=
 =?us-ascii?Q?3Z+dST6VS5aCb3l5dRiWlI/D5ctlzj/elst7pKkdp2WjI+S92XQ3DffbPj5d?=
 =?us-ascii?Q?4jr/RgaZYfKgCLw/4hQ6nzW+dupxiVO32uHl18JABf3B4zuGZk6m5Ok6aObn?=
 =?us-ascii?Q?Ii04BNdK5j0UuxmWNtZySPmt6F3mAnSIzd3RmzHegMScz9kVy76Gd55IFxSL?=
 =?us-ascii?Q?gsbAc9IpwpQEhhutnNYGseRiankjRjSdNqk2zNTtoxDa+0poxnhYQVSp10uz?=
 =?us-ascii?Q?wDg2Hn4FDBv6LVaPFMa6fbyfNg83rIlUe5ul9L76Bl7/2axJQZz26bwLEYZ1?=
 =?us-ascii?Q?FUk3ZFJTF05iY8jRnTCT1DWE78nD5KEDyAfh1rOa6eW5jrdrvrRNcOSS2aHy?=
 =?us-ascii?Q?Dm2kRk6MVe6miSYwvDkzaMqIC3NSxqDqwRWGPROrDogfqXQN082u7y5n+eOW?=
 =?us-ascii?Q?OfrurVAwe0AgZu26tTee7692a9EF0OA+EL6p1XgalGc7ISwFQ4vzq16b1q7t?=
 =?us-ascii?Q?uSq9SC51BcYfoE/yr7R+FIgCig3YS+8JyPoYN+RrnVCBTvxHr+Vn3ovYQa9A?=
 =?us-ascii?Q?hu01IouB9fpJuUB8P6/L33jBUwNXf5r3qluPN8PGZMidgyLymsMYB/Bu1O+u?=
 =?us-ascii?Q?3FKGUbGt7pzoslU8QTmoo6KUou5+o2Xym0sbkmaM2GEi+2J2GKhtUQGEpAV5?=
 =?us-ascii?Q?5Lbduk+zeMPXJDLawEmGwMUkE3fOhdkyfFoJpvKjVXqHUCMmBF3S/nCGcbWk?=
 =?us-ascii?Q?NgMPEpdyYFKsUaYniJRReV5RjAaoSLvV6jO14dp+kU5Hi+DMvAtcSkg1hUR9?=
 =?us-ascii?Q?l4FV+iv3mdXzlmr3lbDTB0ZelhgrZSouKbrPjc1kLeHfJdxIoXIfLHfYJ7uh?=
 =?us-ascii?Q?5rUzUJlB/I5r2VzKvACEirlzChMPv8OSFseINOX2EKJ0mRvSKqBFO+xLZPY2?=
 =?us-ascii?Q?cbtONCr/r0Ol53fGj5Yez8HYNPOyeJz0ojfDVqOAe+rbiBVCOMhHeWbn+KlL?=
 =?us-ascii?Q?zYVI0Od3GUk7tE1nqZOjlb88o8DXAsrOG0eRzEa1UM4CVV+LTA1tnI/8w8Oz?=
 =?us-ascii?Q?gxhrU2CrQSrsKNqkFnP3JXWqTsCZ8RgpqipQH0RTQ7MYZbG6dnDaIQgeQjW5?=
 =?us-ascii?Q?rWiaOj3geALGGLs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:32:24.8321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46f8c1a-a813-449f-f621-08dd5754b317
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

Remove unused declaration of gws_debug_workaround.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 59619f794b6b..43950f3e6672 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -289,7 +289,6 @@ struct kfd_node {
 
 	/* Global GWS resource shared between processes */
 	void *gws;
-	bool gws_debug_workaround;
 
 	/* Clients watching SMI events */
 	struct list_head smi_clients;
-- 
2.34.1

