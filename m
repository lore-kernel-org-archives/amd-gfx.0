Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7633BD262B9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1018D10E68E;
	Wed, 21 Jan 2026 03:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yz1RktQ8";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDE610E688
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTS5yOh4czWkQU8Qv0Y7xZUS6cpiZDlJZurT0Ix5a2+1qJW5GdjNNGj+iP1w5d7DTo7GOG2kSPMZxZhkyg3e06A4B2+a48bkCh+7hl2SfSU3SsjGCzJHcNPcXhScwc8zG/rQNfGRZizWA0ZnFDQUY31bPSWf0KUty8i+eGzZlUTbaNM+5ta1/CGmJZFrN/7Els0SQXoSM0jkFNWqAUU0JwmGY0imayMhQAwA3cP5ui4tgSc3N+Vp+dS42mSUgf2dOn4THNm43F+m1Wzc+cLnkEzb5DHPafh7X2nCsW40F5J8hiAjRIUjjLjqGxhf8e3CmmsjpnZa4hwhefLVPv+WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXLXRpw1NR8YD998dRw5MsDAJxaMIUsip+1aSoadBWo=;
 b=GiKuqdi18RvATBLicpeJNpFAKgl65HGsA1o6M1PwAQb2Lys7ZIyMsIRKO6KpvsOdNap3LncsQl5a8Wd4qY2dw0WVWQUujkmhcLIacv5CNKmkzYPDXxh4R65+0vZfZ8R7s5O7BqekWj8ZM+DbYTHhgWO6tRwBqqwswDEneWMSfvc5cI4ugeXTwUoA4kAHz7mCKQnDebAvCzmIesvgmYTddRqK5MttW8wEtTrJ14ngTmcAG6C+VIK5ncE508pEvia/scy1hSdU7UypwGF2y9n7IzKZMb10kaTedj1ORXWJ0jWBzkgfmPHa+r81cRBkz9yE7eH1CeOzFKmTGgCpwq/87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXLXRpw1NR8YD998dRw5MsDAJxaMIUsip+1aSoadBWo=;
 b=yz1RktQ8Lq2ozSmEnUiqa+HlG5CvN6OrrATilUAz5fy0tazp/4smZy9Eryw4dDfv1mkbG+BUyrToHKCQCPzTpflbVhmW1T/OirHncJGt3SaagIRvdW1OnZcs4hslxk9KuD7eNBnl7quPQqHBDJ38wgg0FN9TMXgvPIBgqT3CbA8=
Received: from SN7P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::31)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 03:01:29 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::c) by SN7P220CA0026.outlook.office365.com
 (2603:10b6:806:123::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 03:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:01:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 21:01:28 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 19:01:28 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: don't call drm_sched_stop/start() in asic
 reset
Date: Tue, 20 Jan 2026 22:00:52 -0500
Message-ID: <20260121030057.1683102-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121030057.1683102-1-alexander.deucher@amd.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 04aed22f-a276-47ef-7f36-08de58995fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tVDlic/FWY4BzuJTdduY5wB8rwI7AVoKV8/a99IYANDeYYOs0cdh3yZ8fQQq?=
 =?us-ascii?Q?32iGvx/Ey8eHPJ9ou8cZryquCEmnESyZUY3dx849o4ohstgpNgfaKi3B7I01?=
 =?us-ascii?Q?5AkT48bB9EI/PQ4aUH5lzf/CENQy9Lz7r0fCw2JZ4FC7cpA1mwUzlLpIT2eK?=
 =?us-ascii?Q?K+t/KpfPEW3puWuyd5BmNUYub9MYBk8r+MiKSWGRwr4+m+Im+KRflBpMMA8a?=
 =?us-ascii?Q?gqvQAP/HHL1girmW7fs4MM3CTlRLRrgv6oI5iv0xN+RYIYcqwos7Lur+Jsix?=
 =?us-ascii?Q?sNtL/Duux+D8q5CM4ujzeA5RUXl9n5t6hrbZlnQXmvah7wqGiKLyxd1wU5/V?=
 =?us-ascii?Q?6NgR4BF3jq3jjF9MPgSMkRmb8ePYtP3Zjt2yJXpGV/ZvlWn0PADBf/jEKqUL?=
 =?us-ascii?Q?JGqBuZwOOb8a6lVDZhvdveSVk400/1vO4DzjLi4siZkaHcJxe+qs9AdCosGa?=
 =?us-ascii?Q?MszOiOS5W4QxPPhszUfh4k0+JusUEZiIV/uJyi9afQpTVXWFX8WO+dOkcdo7?=
 =?us-ascii?Q?agUOAyySWQMFQWjmft1kAyvx+z7cBFJ+e0Zuj5pr4RQnSmgf4oOKY5tssI/9?=
 =?us-ascii?Q?u0+jBfRjmbMTuU7jup1sSnN/r7+dOk0VKJjCEyNSQRMyI3KLDet3FWPoIlv2?=
 =?us-ascii?Q?2jsTzxPv8W/jW+9qBUqeKi/N0/bsXP5NRipEnQEdVNjtFuuz6Ddn5NUawdAW?=
 =?us-ascii?Q?HU5CIioRFBXO9uS2c4Twd/w7vspdKff39Ch+pUScj144aPqL63gd5YZTGRIz?=
 =?us-ascii?Q?TbNrmkajN0vYtlDRM1ugGc16jVt66I74TwWhEdIu0JlgiXqhNpbzqX1Fdosw?=
 =?us-ascii?Q?dctW9gLm5m+rTs3p3F99x9ZWArlbFRTBqjJdeAdLrKa/CoNKO4HbjxuOyrSx?=
 =?us-ascii?Q?2XyWuhPnw1YHeBu6td1LamYoy7TUl1ht/hVQBMOEryywawJYIMUJiGynX20X?=
 =?us-ascii?Q?rfAZ97z+3tvynNqMre5HLM2Og9XE8+YpI/3mexPwGrLZ9XA96bnWQVxy2NL8?=
 =?us-ascii?Q?tmuaFFeogCC5WIVzXwPpzmPXMJUiMHuzyhh7yf220fR0mE+Y/lki4Aw10c87?=
 =?us-ascii?Q?b+IL3JnhdH9zMSftmEl2qiN+PZX57hYLQqUrY1dGQn6xCx3ed5Esu2p6cYh/?=
 =?us-ascii?Q?FmzbGUPjcYIIIoYjuthdVRav6N0tCUtQzCeRz42Z5+f5+32Lk6MT0X92zPtg?=
 =?us-ascii?Q?hg3n95rqfLYwl7inxmdALknoCZI+LNJaGvFK7yq5MVu0uAbLHPbScXyOmbXN?=
 =?us-ascii?Q?+8UgKwlDmMnttZ5pObndaVhUxsG5MIvAjTEDpWGoMjrBMakN1RMrayzXxhd3?=
 =?us-ascii?Q?LlD86xy7Gmc76dxA2/R/q5bisxSuXGJDCmQVPBiRYpccHK0Jyc51OhfhVSDp?=
 =?us-ascii?Q?7AoYbRG0B5lJUWLWSBTJ9AVC0tzVSJ9FxzjLJ43RDFRJNT4xBNhnEH3OkznQ?=
 =?us-ascii?Q?LGs1F9mKnjXurw7ZC+ZV6MRk7aKAWF7Imz+Lly6e3XdNOgj9eMs8vhWApKF2?=
 =?us-ascii?Q?np7A2Df8jYmk58UvGo0VeB6NWeFgVpuJMepBIzEEJt/hd4KKRi/R/Uw3FbAg?=
 =?us-ascii?Q?jXUY6EZqFyxyF6XOzZsMQTNE3CtfciVcgjlnse+F3h3D9/qqFYyrdgpLBIY4?=
 =?us-ascii?Q?rY5z5uaUZmBfG1nqboTK/H44GOwKR7zZxOw47cPKBAwOsB3RDNwU9sff4JoZ?=
 =?us-ascii?Q?8/Lx5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:01:29.2299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04aed22f-a276-47ef-7f36-08de58995fc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

We only want to stop the work queues, not mess with the
fences, etc.

v2: add the job back to the pending list.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 362ab2b344984..05efa31c3f6a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6310,7 +6310,10 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
+			drm_sched_wqueue_stop(&ring->sched);
+			/* add the job back to the pending list */
+			if (job && job->base.sched == &ring->sched)
+				list_add(&job->base.list, &job->base.sched->pending_list);
 
 			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
@@ -6394,7 +6397,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_start(&ring->sched, 0);
+			drm_sched_wqueue_start(&ring->sched);
 		}
 
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
-- 
2.52.0

