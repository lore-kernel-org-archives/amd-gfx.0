Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B70CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 18:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312A410E73E;
	Wed,  1 Oct 2025 18:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IoSTFis0";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00C610E321
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 18:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhh5t3bje30CNtEPFOBAjN/O3bcLW4rooyeqmiht8LMluywdtv2UaskmS+37si+lL+uOhIjdWeYXi/IxoxLGR0icUcIgVpg0h1CwMC046hIQxdZwKvk3unlfhdEOqi0hOxJK6f3egvD+F9U7ycQlv7VTHW10w94v+hMTNj/aH/xU5FlzEwny4S9lVnyG5pJULT5Qi9fdJYKPVLInUAt452Nmn1CHSJ4krdyPyG2yxiVdwpM78Wiz1l2UNcjYwQkzNIU0yyOpygMRKrla8tMF+gWie6MSeUBHCIjglDSk2s2+Bvmv9+N8AhZ4AVmwuxcjRihKbgNmTbnJgEUkNBpL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTtuCrqFI2xqwWYm1CzBAaBKjMw3m6xabe5tcXc1/b0=;
 b=qBjTc+hief1l6+IQ3akyZLh5rUltk+iyDqAfo6gcGBZp/SpYy4LV7ld6XyqPTikiQzu1wrsVA+Y7IguHC14OepSKkR3MOjsua01f7qtpMEq42GDaU8nYinSSozgH7OQdTB4NS2OPItSTVxwduha9FIt6b2T8gxr1unOvlJ51uELsf8HimubVMhCuK9gUz7nGXgMOLcDbLBoe4vz8NPEXn0Yk36Zf3aglLm4tzP/G/U327Q4hBRCQHhxaw6fVT1e1s8TNPDfptSBUjlXJrNIxvBoGKU+C85T1iueJIeHXYVXJxYodNbfWyE8i265vW8ft29l2jyHyMCscf5ERmz2NqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTtuCrqFI2xqwWYm1CzBAaBKjMw3m6xabe5tcXc1/b0=;
 b=IoSTFis0949xaJi0ABo/w1PCpEjYCyHBFkV9O9t7yk1fZ3uXBu3C11HZYFR04gF5bKWtpY3YLXMrHuFQXG6WhQd9y3Dm/emVS3lTrqfl+SM8BVbEMPKKDSs963AUZmifnICQ0RI3rmE29sdBDiojp0Sh6PblssFDIXvNRJxLHoA=
Received: from DS7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:8:54::21) by
 LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Wed, 1 Oct
 2025 18:03:53 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::80) by DS7PR06CA0051.outlook.office365.com
 (2603:10b6:8:54::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 18:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 18:03:53 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Oct 2025 11:03:52 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH 1/3] drm/amd: Remove some unncessary header includes
Date: Wed, 1 Oct 2025 13:03:33 -0500
Message-ID: <20251001180335.625453-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001180335.625453-1-mario.limonciello@amd.com>
References: <20251001180335.625453-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7b5ee8-2210-4976-5d46-08de0114e1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VFN6BTnnDvPtYN8/6hj9Ss151QTDbnUF1AbVjrTFrZKYj7aZ4em+1omhhBv5?=
 =?us-ascii?Q?twIeqCPPuIQ5vQJBg69151YoyNxldA+ja2by33O82/CBaokMObKEgvYePGmu?=
 =?us-ascii?Q?DPDJr6I/vCn2ULfPqg5bHKfoQoR6vq/14thEPxm8GEsJM9bAPEOWUyYsyi+s?=
 =?us-ascii?Q?KV1hySS309MN5j+MztSVKSqCbtgZVsNII18F6lvslN4V0ifp+QQZGz7+DkIF?=
 =?us-ascii?Q?y3fii0KGwZYzXZ9kbjzx1HLztBzKR8L+L6BpGJFCf1ICCla+WFq18DJd58V1?=
 =?us-ascii?Q?GP7f8g95moKeon+Jo95f7WJZiHwcsP4UEcXQWkI0cUdG+z97VIwP6wkhNLjC?=
 =?us-ascii?Q?v2gcReG2n/IJqZTK5sKue3ZwGkCTDujqUg/HfsJ3GwCaMLJ3Z51eRhla3A1s?=
 =?us-ascii?Q?TIBKG7k2tRDG07RNF8Yo2ZCna5F+QbZG5fyJQn8hNH3p+FnWlKBChs3mN4Yj?=
 =?us-ascii?Q?390YP+EGPZceRLYuTb/FYiYn3S6OIc1Qv7XHn62J1Ime9rMU43L8MW9zL6oB?=
 =?us-ascii?Q?mFIwyp0miy/o3O2e1EG5iG39THhbH6gm6rkEnpuSCtBLZfW7yV9OMhXKaPo4?=
 =?us-ascii?Q?swNOylhDwoXMlodSwh0SmSzF7VsZQ3q4dhzK1wy96ON1MZT0ceZvc+CtHgqU?=
 =?us-ascii?Q?AII5jgMLL2ejs0/UF9U3LkIvqLu1VCufDDjokuavJhLBDNB9rMLWp6y8cOFj?=
 =?us-ascii?Q?uDI4rHRfPtOp59OQB+Y3/q0CS/1yYoscHl7c+aWphYcrv3FZtDKBV3LWAUjD?=
 =?us-ascii?Q?K5ES2BH4P215sjkx3fLMM/5XMf1NSP7Nu5ML5CDLdMKJAK/zq1miqCHwEHkX?=
 =?us-ascii?Q?x8J7357sw8mlhQ5takUJBYKn/YcfEEpt3cExpmnXh6D3JD1+ckQ67hUg98SK?=
 =?us-ascii?Q?dZIeu85fROQBjlTKYTjXXxcJaLgSs2I7qoLepVLPOWV+op8rLQ+eefPVyN+D?=
 =?us-ascii?Q?VI0/2r8TxdJzHhPp+VbrvI4KCPpZm6btLv7NMGe1A013DFQRyMp2uCtTlkWo?=
 =?us-ascii?Q?OZE+uZKqaqkJGKZNIpAXqxiK9si+oPueklw1nQ+y7BB7hacf7BB07ztF45r4?=
 =?us-ascii?Q?JoPbbzL7h7ML9TdgslxxyfeaItQnGDscnAdQjfSxiMNOr3lcrQARnwd0CCmK?=
 =?us-ascii?Q?GZ/n8csiq/dAzfx0QTUg5JSIVHOQ4ThjAj4tJmmsmTs+5nuzaGy3se2N1kH1?=
 =?us-ascii?Q?TXRsl2RJ4WF2iRIoYT5n6YaZYu66p/nIplMX2IPPp/0SgpFPuA3dYt4m0hvb?=
 =?us-ascii?Q?qxTQ4ImMvsyOMAie3FkOf40ASLL5LvvGjz0+RFLMxF2h8Nt0332/2YnRp5+q?=
 =?us-ascii?Q?cjZaN3ydZ1rqV482Odz6VACdfZv5+jkBK7NdexFMapnpJqYVyqoOooVm7B6j?=
 =?us-ascii?Q?/cqzRGtihsxryCHd4aUSryhxYPPTvB+SlqgCnWk869Mslij16SjkMjJAdVKK?=
 =?us-ascii?Q?3IiWftYQLyb/eL8+Vk5l6ySahwXlTcuEv9gz0UpGm9UyHE0BHZLEFHZZXkDL?=
 =?us-ascii?Q?jVMY7TIMVarARUZwaMCzt/rfYtN++Ou12nX06N6speqmnt4HJSMRMXePajk0?=
 =?us-ascii?Q?KUXgxI7b2nPgWPyWHfI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 18:03:53.0612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7b5ee8-2210-4976-5d46-08de0114e1be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666
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

Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index b48a031cbba0..9041002dea6a 100644
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

