Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDE8C1B087
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 17:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E80610E0EE;
	Wed, 26 Feb 2025 17:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gHI5De07";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CAF10E03C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 17:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0xMjtp3WFp9TrilGIRxspc0z2ObBURMCEjeEmz2ksGx+90MsJV4nnj5NTWq9DrdwONvS+0Lac/ykyDP9e2VKNxxm4k5JSLZVGiodkPA1RkqvOn1qpz9YnkbRP/iT6zhVx6ChsVS3H9EXgG2CBXF4NXs/rxMoEM9w6HcYPvcdKcVjA4m/7ZdJolNGtpqibAWIAlTojxjxPKqYZ3lLewJGNwEKOVH+wiKuIf8M3mzcKcxY46DRWn34zVD57Sjq/+jtYTG9sEFNWSVhCG4oVoQs+3GKhWocVg9gn+Zw9UBBFXOEcjU6qgOqlxBqqHSifuAZwgzT4DZlTwd5f5Mobvemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vi4BCS19cWtv5wNZVNIUrEhtIqC9f174TKn5ur5iFHM=;
 b=hYKlae3zVwDw7COnB1eK3qRgSLIiF1Suyr0KTQhh27rC5r7AGcX0ZiLmyy5NIvGK+R3vBwc/mFwwV6uQX5zJTzy2t73nS+oKPzhYbM88kw/tZQ6u1TUf2VS40+CWnVU6uhXNOroDEZqPPDkfR/KkjNoUNp76OAYkIXMbPaFkblN+IcCKY2I81ei9PyIPcWQl8b6GPklFGZx8x7iF3je4eS79S8dNR7GmW2sYKZsoX9U8aDWTWJRmYXrdOiEYvgygt6dUvfJPncFQu1abIxuCloD2Gk2QuUM9xn67VQaVeAinzbz6ntIpJvm6wNd33yCkj2ianFE1VnsrNrRxdbparw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi4BCS19cWtv5wNZVNIUrEhtIqC9f174TKn5ur5iFHM=;
 b=gHI5De072XYJ8uFixDcJDOXPVZIdkotEVeEP7sulb0W2FpO/pPPwuq+7AG6ivmJclGBLACf3ncjZTUK5Dq1AkICPgF++jmDgNmn5QRbFHgOnqZDynQ8C+MV8B/fMG3S1EJC2SCZDA6GLAsRaFQguTAhcl9ETI9zX1ykemf9o6Lc=
Received: from PH7PR17CA0071.namprd17.prod.outlook.com (2603:10b6:510:325::28)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Wed, 26 Feb
 2025 17:15:16 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:325:cafe::32) by PH7PR17CA0071.outlook.office365.com
 (2603:10b6:510:325::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 17:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 17:15:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 11:15:14 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 0/5] Fix mode1 reset test failures
Date: Wed, 26 Feb 2025 12:14:16 -0500
Message-ID: <20250226171421.14436-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c92443-3ba0-4085-fd69-08dd568922f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uP0OdrwQbwL6+ycnGwldN5XjKaxiwCetnPRA/uaCsv0y6nuaozKywJ5ap4Sn?=
 =?us-ascii?Q?npU+g1tErs3Mmlvvdg6LJ6RL8h8ckr7js5wJOiTHfYl/kjSrp1xC+763sdP3?=
 =?us-ascii?Q?JcKWKPDu6w9SOpGHpqLACn7541gLcwQ9jEU1GcvMWihywdjX/YKKGT+mkg9w?=
 =?us-ascii?Q?mCk51LIXvPFdkNz6YS6YrA2Nblq6Oq7mLKpNbqa0tLR8nQiW/MsUvJe/SdTL?=
 =?us-ascii?Q?zRwyrCnuNgELEw8jzQqllT3BOHrA7vzc1tXPMOJzHKyCTjsmZcDvR8e1yQiZ?=
 =?us-ascii?Q?ZGoiwbmHrZ7cQJA5NZ2Yy7k6hZWSJnHt4Bxxa9DSbF4tVzQATi9D+cnU6Grj?=
 =?us-ascii?Q?M5ANLgnlEFRdKeMRwOvEjKhHoXiRv/+PrpTM+5KIlUcF+XXLYJSPVzAEOJpZ?=
 =?us-ascii?Q?q0Xtg0wILGNY9ovAZuO/QS4UjNOL1g2h0M5CXonKlACKbgqSFZnWsGrr128M?=
 =?us-ascii?Q?zjkvVjP8CazTJeJIbjAR7YhhNtujILzgzUukguK0bmRJ1SWCuphCJGu3zyo7?=
 =?us-ascii?Q?AbcgPdoEQQV43wmTHxTYpWkvPdujNYnIr9bVulBscTXw5yhYPMUH+MqTHXsb?=
 =?us-ascii?Q?WFxvUNp28r1qz7oty6coj9ZVxyBS6USavsXLYcSj89MdCqrBU2F9np7a81Sr?=
 =?us-ascii?Q?rVpqrW+ohaufotv83fAeANmRzffnGfKtcw9OcARj6Cu2VBQlycUtbzOKv4ud?=
 =?us-ascii?Q?yLHWOLscM8sELwibZCsr8XpEK5nxxA6IfkBijQBp8szY2MHJmUF5pp0Zn6kC?=
 =?us-ascii?Q?X+tLrwJU2vS5ScYKAnh44Hfw07f4khthjsZLqUgMEgBv5+hHHrTR37Srxq1l?=
 =?us-ascii?Q?hdqQEqE7oy2Yk3Xq8Ve9dEAZiL+ExbTQU+wgnkDqIn1LjSkdcBxV67SvvH1g?=
 =?us-ascii?Q?8TT/vbjqk7uz5v9AMVk3JMOunomEf8/k9oTx1HfSd7clVorfQdCrfMmOpB0T?=
 =?us-ascii?Q?4yaIJpiyFM7EBttbvYkrWcHmhIvoVrGU1FIjY7Sax8P3MTUTH5W0H9z2LGXT?=
 =?us-ascii?Q?inOJ152mrDGy4SuBbRDRC6eEhht3L1A75rjREYwa2yPjvp+Jo2/wKD2oQ5IU?=
 =?us-ascii?Q?e5mS0bRw70iNDx6NGYa0vEODEW39uVtBRI5SNp08H3xw0WlwvS6aE/4OnQgm?=
 =?us-ascii?Q?Vh1dvGgmrj3ae3TjTfjNc3t+NGGjsOgYz70z2+jdiZbiIzF7EuLhVC0MQW6k?=
 =?us-ascii?Q?F4YNc1dUIuxpgEUuM7zzwsFIraK84tEa5YuJy7j4z4wo9zj6kfn3IxkALxVA?=
 =?us-ascii?Q?JU5s4019kTTqMTPfy2gc90f26iAQoEv91V9fENEHGvWBDdRjnY99aaWYnC4a?=
 =?us-ascii?Q?Jie/vmzucbHm749hASPLXmlK4CnnyAj5cMNyuZrFHgQY36FLIz42+mEeInJ2?=
 =?us-ascii?Q?9nYXvGfLqwKo2BLi2n4gh+X7i1zdfyAaVkk5exdg2Gbq3vDoC2d8nqCSNBJH?=
 =?us-ascii?Q?yDDhgXsY8HPjwCdrY3veKmI5yxhX9hG3/wiiVgxxthBLGnECaB9/+MfJGhLC?=
 =?us-ascii?Q?TdyoE0i27U5FtN8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:15:15.1486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c92443-3ba0-4085-fd69-08dd568922f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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

mode1 reset test running with compute applications trigger many different
failures, such as machine reboot, kernel crash with general protection fault,
NULL pointer access or cpu page fault etc from random calling backtrace.

With KASAN and slub_debug enabled kernel, we capture slub left-redzone
overwrtten warning, but no KASAN warning before crash. This can confirm there is
system memory overwritten from GPU, not from CPU.

Change hanghws test to evict user queues first, then do mode1 reset test, no
crash anymore, this can confirm the system memory overwritten by user queues.
Because the user queues keep using GPU while KFD cleanup worker free the
outstanding BOs, the freed system memory is allocated and reused to create job,
resource. Then the data structure is corrupted by user queue and cause crash.

The fix is in KFD cleanup worker, after evicting all user queues, flush
reset_domain->wq to ensure ongoing mode1 reset is done or user queues are
evicted, then free outstanding BOs.

Philip Yang (5):
  drm/amdkfd: Remove kfd_process_hw_exception worker
  drm/amdkfd: KFD release_work possible circular locking
  drm/amdkfd: Fix mode1 reset crash issue
  drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
  drm/amdkfd: debugfs hang_hws skip GPU with MES

 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 +++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 33 ++++++++++++++-----
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 5 files changed, 32 insertions(+), 20 deletions(-)

-- 
2.47.1

