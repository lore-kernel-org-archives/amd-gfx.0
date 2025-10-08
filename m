Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1057CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 19:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6519C10E8D0;
	Wed,  8 Oct 2025 19:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gLF46jKW";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F65D10E8CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 19:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdw4Ojcq/7EG23Lsk8ShroQkXMyG/Evb+DwD+cpzcRze28ylhLFe/zV7HK8wSgHUfiCtzicI2QqRMjDLu1J2P9TmSB/QSynzBml7NxKkYzRiqcU7sHtLQeApU0jjprFMOyPrWJ4u9f2MfV1zvhgn1phxEtxRbnRA/BV72hL85b+lOofn3bAw2nJu1nBdMK5+KN1PkzbpOlqvgkICbZO05yFfwc7ujdm7xgFsxbN7Tl3DOfmLIMy/4kynG0F1X6nVdvGpsX1lw2g5jkSyEl9wWphdn+AmuXWN7FJfRbkMzsrfFXRF4iozUOMJosbyDkgUVqu04YS/diWATWfOIOrMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re+X6CXoGQHXNRKJlt+Z4pmOfJf0/dkGE2mOgcyEwIo=;
 b=sRbvZxyM0P/YiVzBESa6FfzdKdF2l3FTqkhmjJgZ2Lmw6N9HPXx5JUnYnemRBsTexoy9IV1RJHmGrt2DL9wb52O3mpO6OKUxy9X0aD10s5vzmu7gBX62Zds5MXyam9IXuEq/dLlHPX+ixW1ycB3bA8Lru+g1UL0RaN0fU3Lk3QlvRSR1Lg95r/uMdQo+qiR25MGZdRbhIFG0qsE/O3QMs+fSoIDmxHyRY/7+PYsdSqu0yMSGxEk2V1rMsTqNFtHgTUzubIegGpbKDx2f1cB3RAJ+Tcp8Yfzsfma/UDlfnt0p8/fNmbQC4V7R5IiirI0363F7Csw3ZPAMsCozuWN73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re+X6CXoGQHXNRKJlt+Z4pmOfJf0/dkGE2mOgcyEwIo=;
 b=gLF46jKW3F/b8MyhZwT6Jfuvd9FSj+0+QXxtD+xLac1kdyStKl30usaZtGJaLV3KVlZVSOqORhkKjJuquO1v+5tiFjoOwt0MIo9inh8h5FGL3jfbHAklAsngwR2W3RsZ7OkZ/viYBnYA0PB0D14La6aLBznP8F+JpmiF3zdb08M=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 19:12:33 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::2b) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Wed,
 8 Oct 2025 19:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Wed, 8 Oct 2025 19:12:33 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 12:12:15 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v4 6/6] drm/amd: Adjust whitespace for vangogh_ppt
Date: Wed, 8 Oct 2025 14:11:53 -0500
Message-ID: <20251008191153.3145554-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008191153.3145554-1-mario.limonciello@amd.com>
References: <20251008191153.3145554-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b4e44b-93a8-4578-44a6-08de069ea286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ptrs8mbnDM3NAXQOcvkN6V/Acp2GLTo27nCiN766ZAArTRG+rlJA07iN7J/P?=
 =?us-ascii?Q?e2dH/uJ79Ny/voU0jS+sIAa5tHr8sRerhOnPnTpOcfPyXHghS9RhbakBFLrS?=
 =?us-ascii?Q?pPvJJQK6suTqK6DIXRUoCStyek18oLHF+KBm5j+gzeheUFxRNXERtfE/bjUw?=
 =?us-ascii?Q?4aZFXmeFoU9kM+UvjkCs2sxXEw/7/yN08tv0GVg8WoPeZXdn9Cy5xAywugPz?=
 =?us-ascii?Q?myTJUoxJg2ABMfDpnlxD9tLi+FK7Ghqeq8DOZr2MX9KSi//OsSCqhBVTdwV8?=
 =?us-ascii?Q?JTTgMizKUsti4RScm3zYywrjgNmgzVXrTmzyQ2ofaL4Uw69RBkuvHzG2FJKa?=
 =?us-ascii?Q?laYV8r3djSE/IQHr+ipk3qd3MzEMZEhuONdUGxMXnEwWMr4g3w+6JAEy44L+?=
 =?us-ascii?Q?RK42S7A4RYvjI36jBTU1XK8cHFje5LPHi68/DQDGrkFnNqBmY3kewFs3HbrV?=
 =?us-ascii?Q?L4R9FXU8sf/HqHMyxXSEs6eHF2axOkO5NNhedrlecrm+8pKhVHI5zvPrqB9b?=
 =?us-ascii?Q?SakU4rYAJ9ddpMd+p34u53BSPL3lnG6Rw2bb3PmVaPwneQZlPJH4DLfgDrEO?=
 =?us-ascii?Q?AjaYaJRNFl6NPKaLSqcBWQ8LxV+TX9CK4yNdkv6l/VmaK8jOkeIgQ85RXUO5?=
 =?us-ascii?Q?zxlzs9x7hd6p3sir4Y+/UVdOMYmQBT8rnQYUnHjadJriFEmvrqRBh2iC5I5y?=
 =?us-ascii?Q?tQjuy7BXsDrxfK6aAzo1+KPMxEV4MCm3uJVo9kMKTbWsOma7/U4OrbKW0cpA?=
 =?us-ascii?Q?eCz7oQGghJbmyagBP9O6cE31MFLRR85hzqlG2dwrQDI4PvN1UrehgIPAXSIJ?=
 =?us-ascii?Q?GhD26OeUMM+0kgNEC4OjjzZr5J0PRzZlqJi3XfwG/Pp0Rar4JGAHdvgfhpGq?=
 =?us-ascii?Q?4FbcKdutj4tH2c5HF/2CwGOjTIleEqACE6P0zQhDcBY4RmaPSxmckLGAPkTH?=
 =?us-ascii?Q?RldOjOk5aawOy4FFTa7zBvzFQsxMkX89PumlOomxRAVkGlNUWP2qK7sR6juS?=
 =?us-ascii?Q?q2SI8iGiFEPrJ9jCvrh5jiRDFDjnmy+dI4I9aV+k4hqOotOSKW/Lgx9tvSNP?=
 =?us-ascii?Q?DfJUD+MqPORUE+gvPLfYKIzJzUDUTgB7LkEGrxr5NKvIQbEHXb8yeapgeZNZ?=
 =?us-ascii?Q?zWj+/NTaQFg9K+iQbsOt6KXkIq6PQTkhCDNuNJGjVdKYHSYPEKR3XBdrZBZM?=
 =?us-ascii?Q?+h2Yf5LSibeMC3puC7kOIPrrZTWKHN6EGTac++K11ibFogsDxUi6c0lfACs3?=
 =?us-ascii?Q?hZ2IFgGAjEr7FYIVxghjx3faFxFftYljJyZEAXBPfZYOc1RIdxys8538h528?=
 =?us-ascii?Q?9i135o2Bas288oH9hgY0HIgLu6SOWk3kxtASpb7oQWXH4ZOVyG8HZqlkY+QA?=
 =?us-ascii?Q?IlZY9S+zF/DSwYfxq0V7MXNfOgtirFTbIof/AXGus/KkTl3QSkisa9yrmNfS?=
 =?us-ascii?Q?M/yrthi7MLHlp37e0qJOREQ92M7NR7ffE4B0SWA/0lauQwkS5/LmXLLGe680?=
 =?us-ascii?Q?Hc4OMaI1bMUbtRxq/V3RmjFU9jAAjFpeWxgVUrelFTlBmyYVBpbrsX8YmKQj?=
 =?us-ascii?Q?di19OzoRA3bL4O4607E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:12:33.4076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b4e44b-93a8-4578-44a6-08de069ea286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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

A few changes have more whitespace than needed.  Clean them up.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 81077a3969e9..1dcbf250f486 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2308,8 +2308,7 @@ static int vangogh_get_power_limit(struct smu_context *smu,
 				   uint32_t *max_power_limit,
 				   uint32_t *min_power_limit)
 {
-	struct smu_11_5_power_context *power_context =
-								smu->smu_power.power_context;
+	struct smu_11_5_power_context *power_context = smu->smu_power.power_context;
 	uint32_t ppt_limit;
 	int ret = 0;
 
@@ -2345,12 +2344,11 @@ static int vangogh_get_power_limit(struct smu_context *smu,
 }
 
 static int vangogh_get_ppt_limit(struct smu_context *smu,
-								uint32_t *ppt_limit,
-								enum smu_ppt_limit_type type,
-								enum smu_ppt_limit_level level)
+				 uint32_t *ppt_limit,
+				 enum smu_ppt_limit_type type,
+				 enum smu_ppt_limit_level level)
 {
-	struct smu_11_5_power_context *power_context =
-							smu->smu_power.power_context;
+	struct smu_11_5_power_context *power_context = smu->smu_power.power_context;
 
 	if (!power_context)
 		return -EOPNOTSUPP;
-- 
2.51.0

