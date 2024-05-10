Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E087C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C2E10E2AB;
	Fri, 10 May 2024 02:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JOQvfWzd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F8810E27B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2CS1atpk9TqkRjUaZzrD2ObY5qm5T+v+yFAEmKoiVfyYHavdeJ8ev67qTkfnpxPOl80RRhEoc4X1XWGvem/kc3swUySlVg0/4AZzVhzcGeHd77W6+rZqas8XhKhifVufs6C2UYqYuK6KQa4p5WpiAZcyqFo4T/4D10eXBnsnHrTv32vqIb3p+PoxRgNYvSc7kCuvTxJ2ST7Lh+oLgTT2Gh0WLG2r2CNZfI0QDZNdmnk4tdg+7r9pfzgG3/oR3302aNZL5KBdbXZboUrRJ1tmaCqmNo+73cq+zNjORA0F88Lu4QGUUE6saS64lre+IFuDIbiB7a0FsLJfFH5anDOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ilg4+ap+KdiTQYWE2hF2h+zv2e3A/OQJQeGZPxSEloI=;
 b=RUlxSs7uvYSRkpMBXRli14IRZ3JVBAQJNj2kuicKGdXYv/TkF6HqFGjTu7ULHC05KLvnSKMpSvF3Mz9qQ8cWkiJW6mY8vx+EZO5/h1hSvp7AAsfXQdKcg0BbTRayIoPsXnAc5LiZAvW6gSWgdT5BGqSsZKe97oS5TLK8XDoP5VjTlbd1YuehHASHR6MFC9wIRw18oFJDchzuIVng0x6HWY5FYezNVePscJD0LfaudYJRyhZhxCfYYORqAjMGfv6wHBesUeR8KHJRe+MsOUVJXz+yrbrY7QMA61ohgAU914QPTBhka5fQa7Sam3A+XpOQQj56L9BGI/Rq4dZoD3rYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ilg4+ap+KdiTQYWE2hF2h+zv2e3A/OQJQeGZPxSEloI=;
 b=JOQvfWzdazi0BY33+jK3xj+nXCKAaQJzoowqHzsudf6qtuA0YplPWv73rEKA2xJN+Hp1yf5KS0deiMoULMGeiKyAS+pVbEleugJhOopwk4onhYlcuuQJpVCmTkAnmtOlIDKMOJjwNUISNNedG9wAVwsq6wW+ll/BEMpu+KLId0s=
Received: from BY5PR17CA0048.namprd17.prod.outlook.com (2603:10b6:a03:167::25)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 02:54:25 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::98) by BY5PR17CA0048.outlook.office365.com
 (2603:10b6:a03:167::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 02:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:54:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:54:17 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:54:06 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Date: Fri, 10 May 2024 10:50:34 +0800
Message-ID: <20240510025038.3488381-18-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a261c7e-7d9c-4b3c-059c-08dc709c8058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kfkNfx0yo72T5XIlg3ByWvjkOorLnFEabC0fl2LuC01yYCPXfqwK2XPVF3Rf?=
 =?us-ascii?Q?n5Y7RX5ycSLGd4pYhOFgmQCfkA1p1dQMbbOlmj8E1nAecyausf55eqjU6oJG?=
 =?us-ascii?Q?spf4Bjfx6YYxU75yrKZP1aMRpInIQb5lh4uoo1W50aXgvI3ovAWoENVXSVNr?=
 =?us-ascii?Q?q2em3mdhOaddUKNi/+C8MMmzIViIC7xg4t1xlUtZN+UwNXT7RZbOOavy5yKl?=
 =?us-ascii?Q?aY8aGbDcEkS7fXqimEgXYDuBxk+fKnXzsPKxSIaf0cXRgxkl5SG5TKxFlxjA?=
 =?us-ascii?Q?kIY1NLsMCVi8iEAIN9cyi+xhWYgSaGDjPeU4McUEdch7ye0E+6fJE1derwkR?=
 =?us-ascii?Q?/sJ/v/5AxAcSfo8MMBdAx/R3mY7GIiBuuiWj56VWzqLR+lU8za5ZucsWkUqu?=
 =?us-ascii?Q?i0G3ObxwuTk9/jCG+OeEyEstZTqWkwP/e7F7MQWRuiaZT7PRqdxFT7eXXcIo?=
 =?us-ascii?Q?HdMqgPXjy11ToZrZ0AblEMA4l1gVzVQ5wUPxtSMf8QG134pwSiDfLI2FS9PR?=
 =?us-ascii?Q?3ydjYwpLN46RlcOWcCHWhP8dN84esiODK5Aa37UqtLsyULLSN87KFHpcFgii?=
 =?us-ascii?Q?vjb5kjznOvrwErmJejczRRjf7sa71/L4T9/0PvW8gbbc4ctQukbUTsHU892T?=
 =?us-ascii?Q?xmgx6Gy07JnI1fX5UvAkao2rOWDlmNEF16RghXezR3sfpXGIY0dMVMEUFZnN?=
 =?us-ascii?Q?7svw7ZAHCLDGfq4+DjqRIG8N0FiwfcrYLENo7kFZx6gef4ATaOfuB/HHYn/y?=
 =?us-ascii?Q?VKz0NCmec11hGeZYedoy/49SeG+7XcFX+IK/3VN1VdH9PDDjrF4SZnvdA/5V?=
 =?us-ascii?Q?n3DlyJGZejT08qwRZKm3qlPlmmdNRSzyHbNkiF6rxVQdZd9r0+/FMK3bdWcv?=
 =?us-ascii?Q?yBsSTzGUO+ecoR1lKnrlDqSAf3otYmW//Q4jAnhDEEU40XJpS8d72rpfcTPz?=
 =?us-ascii?Q?R/V+pTFttHVQi5E+dkkfj9xKHGhzXjltn4ugMWf6OQo07d9PuMsQKt0+AvDh?=
 =?us-ascii?Q?lLkw8q2ecURdNog9Ucxd0Am9aL4igVrqrWbZeYxtBCLrHxvu0LVtpoZkjiT8?=
 =?us-ascii?Q?OULxwRaq3qPf6AWp8iTte3HI/9gZySvcfywq564Fa0zCpDJz1rX4Jzx9LA9E?=
 =?us-ascii?Q?1+bUwpeArw+h+YW1kI23vImQ4P6x1VGrNquwFEyoCSLDMA6jve+Aa/ZdoCkE?=
 =?us-ascii?Q?JllXSlyOWpC+3TQ8gwceE8arOg/EdXXynLzIQ8Q5IiHW0afo6WnAp76Y5HJw?=
 =?us-ascii?Q?HlE552BT4eCxeBZrE+YjqvFlISQPvuZ177zrill2Ofs37Ynmw/lKG/qz5qru?=
 =?us-ascii?Q?x3KCqDKnzQfxsXaz6/5KzLNB/D1I7oVYVOpftA1vm4aqdXws4QxF001k4bLM?=
 =?us-ascii?Q?a7rcQek=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:54:24.8822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a261c7e-7d9c-4b3c-059c-08dc709c8058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

Function hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr) returns a negative number

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index f4bd8e9357e2..4433ec4e9cf2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 {
 	int result;
 	unsigned int i;
-	unsigned int table_entries;
 	struct pp_power_state *state;
-	int size;
+	int size, table_entries;
 
 	if (hwmgr->hwmgr_func->get_num_of_pp_table_entries == NULL)
 		return 0;
@@ -45,7 +44,7 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 	hwmgr->ps_size = size = hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
 					  sizeof(struct pp_power_state);
 
-	if (table_entries == 0 || size == 0) {
+	if (table_entries <= 0 || size == 0) {
 		pr_warn("Please check whether power state management is supported on this asic\n");
 		return 0;
 	}
-- 
2.25.1

