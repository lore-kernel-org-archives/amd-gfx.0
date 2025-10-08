Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FBBCAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 19:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0051010E8CD;
	Wed,  8 Oct 2025 19:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cxtaSgc6";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD6D10E8CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 19:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRDdGVtFjxhWvMphacUmflJ5MR/VrK09DZotl4TARPMyV/+s65OxpXWaUq8dQ49bHLJWHVFwLr5tsnlP0yFFlHpOFgtNM140jyGeQpo4Gd5S0m0tH8Vnrl4tTcZsLSEw/9gUWrc0fIl1cM70CWXdGrMIMKWeo21tS87tL+EFYiH18HMtPvBeykXqn0CksMTQ18GsEWYHkY/vclL0GZcz/SAJNTXwPt1CrofJZTidzVhwbENeAJdkDk3jGKELcCnuHXsTuM8yIwjV0o//ef+0QigDo+TyLfsTow4fytUWeyN+vejnhMHvP/aes8V817W+aYrpwqwZSzX5/kUIJWtSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxA4w/zTI9hvpu3IZRmNQ9RF8bgBVRfmNQkMjtwtG1s=;
 b=eu+0xI9eK5al1ROGZaYx5U4S2NT8klsB1SnjIPT4Z8zBUr5RGWptJKZQV0hwHhYIYmmghpW+Ppv4DxKUV2C3juI/+6VHnSEcivwGpebzc4/1p9FIxPJ4SM/+Q1dfSpFbxznJFjwp/6DmX563XGUgSVX8BiFj5u5cDHgZu4Dqnz0HGgKPZIuL5tiqL0WnBfXXQa04nON+82exWmtX/9xLoTCeJe2yvD6OCzhc8Z1MX9j9aBDzvc8GdP8ajmkTlNjViy2KEQ2DbV2Taf1n7WIo9CRx1WPVbBE1/X/0LnL4US3FjnnZwjQN+RO487POzjWN6ggqb6RwDw8j6XNEfPP0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxA4w/zTI9hvpu3IZRmNQ9RF8bgBVRfmNQkMjtwtG1s=;
 b=cxtaSgc61gt/p4QSKQyZ0YcJ2HvtSB+xZ54CKOV0NAPBdReWO9nFs55qOAotVjksnXq+99ddwbvRhvV9Szb28CZy+HEdB+ikTsaojxTTBggVIzQxEUd9swYn51pa3u/KiWwZKCxRsz6m1mAh5SSLYLAhCAPySfmJI5kMCcsjakQ=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 19:12:23 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::79) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 19:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Wed, 8 Oct 2025 19:12:22 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 12:12:13 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v4 1/6] drm/amd: Remove some unncessary header includes
Date: Wed, 8 Oct 2025 14:11:48 -0500
Message-ID: <20251008191153.3145554-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 72fa61e7-9e5a-4c39-1a27-08de069e9c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a4TAox82OTEn4Om3BtjnS5Pw67PYVer4CRbvjuk5+/gDmmisoxjdrOV0wzMg?=
 =?us-ascii?Q?yvAWE153U5zpFu+dleLUthmW6TLjSMQtGaurv5eCHYTGHrtei6KEohzw3yHe?=
 =?us-ascii?Q?69zwK3RRsnZC3gyva8iE0RCc4+kgGUxZJG5UKHSLrDdq8gGHwoAI81HMc2y4?=
 =?us-ascii?Q?6eG96ZTvWx+KdqIr4ZdH9ue56TBrXcUOT+7cnVOC+KQHvuoD79vfIcQDeC21?=
 =?us-ascii?Q?Yw8QqiiV4encY+wNMrBvCj18FJKpGSZZtlgkUjzKc71e2ADwYIvgb1ZKxn+x?=
 =?us-ascii?Q?fBWSUHxJUWvEvgIE1vN9ushw9zE09rJzhQofIUlzkWmxn7EJsNWp97ioCRVl?=
 =?us-ascii?Q?hNZvqs65q6typ5N6nurTZE9O/Xi/u9ue6gW6TW/F3Eyq00EpPMwOCYJmMPdq?=
 =?us-ascii?Q?L5fgZAijE6evwnAoBX98G2/QrU/uA5/YiHjrG7XPzHXq+0Ltyq0egMjQPlzh?=
 =?us-ascii?Q?N29fM04YWu5JI/6JywbuWt7NTVUW0TFir/C6ebQ30m4lL91uw3iQtmabYvpA?=
 =?us-ascii?Q?V3eXXd2l1f1g/6mud3MTfu60weB8M310b92Cmkvo8QuTFkcT3ls5s3UvXR/E?=
 =?us-ascii?Q?GVH4FDrJmtjdQ7/CYwd4Enpr1cs6sFuWZBij89Qjj5fbNuyVo1T/wLnD5gdm?=
 =?us-ascii?Q?ZSdoEsxe7tB6hjqAgAJ6SAq7E/bqG9sxir+AdHee5wIf9rZrnWY3d+JtyJ9d?=
 =?us-ascii?Q?N3A/28AcAbNHqA7EJA8guTXOMpwXBwMzGaNl444OaN96ZzYRgvCZcCyGVbmK?=
 =?us-ascii?Q?UvAzx9IvFTD+fGLP7B8xvLICGs1LZ0BMggixWk/VDyGvB9L1yapzci5edvZV?=
 =?us-ascii?Q?uv0Liz4rXglbj93Sk6JKqZfXJNXlwToIpYTPnfa3UJKQx8g6m4CkGWCjV1/k?=
 =?us-ascii?Q?YYXbQwxsbplUjyJIWymFEcbOOwGGOtNmtj4Bkv8ZyrqYeL/JdfOZJUgF+eS7?=
 =?us-ascii?Q?sexMhq6YLuX5b7bHbgPKgnfBbqDa1wk+XBMoa11eFN6L5SCaIHDjSUtl+nXL?=
 =?us-ascii?Q?Q7A1cPKMdUcS8uohiAn1WHzKh3WaxfENK28qyfslxt3zA2dCMRpuMq+gmk9Q?=
 =?us-ascii?Q?orocDCgYRfe/Qf9cyMvafv1ElxpGDlBHSFSKEukHVutGamSXtVXLadDL4ypX?=
 =?us-ascii?Q?DhdkC0xiH4aMeSEfbNjC2ok2M+m3ztah/m2xNZmEEq9pwaI53W5CHFnQoTEg?=
 =?us-ascii?Q?hkc66JFOdLZL7ptYO1rQrCD+j+5hLm5Y0GDV0ME+5gAp29P+nEeaqPv4uY+V?=
 =?us-ascii?Q?jCeSM1Y2YYJRG/uG9Cc2uRsY/Ya4FXwe6hiGwXyQiBXJv53uIN3UjIo94qSs?=
 =?us-ascii?Q?AZ5q83qGxybj8Ckn5A5mpWtGDd8c64Tpx4CkoNsOb8QLHowZOT9p3kNLSIlw?=
 =?us-ascii?Q?iIArkUcN7GIvPlBErn6jedFPVNiraIaUrOhLFAH2qL4kOwSLCsZOMQWUh8Gv?=
 =?us-ascii?Q?ckCYrDeFS4/ojnL6/k83WCwDfxzMJVIsuEeoOMgIluFC+ptZ0VwTrVVuJ9fg?=
 =?us-ascii?Q?uNeGolALqLyvtHT3vsw2A5c5RQ8MbF0TVYl6dRBtu2MzcNXc0PMyNAzCc+XQ?=
 =?us-ascii?Q?XAwLTEB7mjGcjFtN6pI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:12:22.7637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fa61e7-9e5a-4c39-1a27-08de069e9c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

Unnecessary headers can slow down the build, drop em.

No intended functional changes.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 554492dfa3c0..fb595a70bbd1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-#include "pp_debug.h"
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/gfp.h>
@@ -28,12 +27,10 @@
 #include <linux/firmware.h>
 #include <linux/reboot.h>
 #include "amd_shared.h"
-#include "amd_powerplay.h"
 #include "power_state.h"
 #include "amdgpu.h"
 #include "hwmgr.h"
 #include "amdgpu_dpm_internal.h"
-#include "amdgpu_display.h"
 
 static const struct amd_pm_funcs pp_dpm_funcs;
 
-- 
2.51.0

