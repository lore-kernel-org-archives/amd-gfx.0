Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451C1C54ED0
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369F110E6F9;
	Wed, 21 May 2025 15:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gaBgFVb/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D36710E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJ20nQ/ikxc0sDDRB1mchQmCSEdeGOvyB47w53q7d3JIsP1QUQzRw4LxhUTZz9GilB178Gxwx0clpRVALAbpPi+hrmQt1dh7al1aYYG/iKOjMmufwWXGitVUNl3ivJ4KJwJmP/S9ueM/gFOb9gV0HOEMA0Dxye/3hlJHnxsnqPd3tz/mH+G32nO8vb9zXr6nQBTLIGqPvrU+U50I8CdcBMdIQAMgDJcs2O0qxnIcRO1No6NDgYnHid9Aa6mSO5853Hy25App20HB5n+Qe7uFkT1CibwNhhkIdv3vRBXNdjmrfH8fERuFdQCFGImGUgjarRj2HLKIYFCzbPDyjMZ+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBU3NaUN+KRuCUHmNp5UG5C4EiAw0ITzipPPD8GOqFQ=;
 b=KMi/1pMQA/orp7Bvd0ivuDOho3pvX0SR4o0fy4JhksAxkmi9HNwfIPXns0ZkBmuKA8QhmQ0tsuWxJEWmnWk/dM7HTaV6qfSn0h+GHqbbM8tlKMpgXJtlLv43SUdIGVj0EurRGRdUtkZPASnb15TREsHJny/6QZCX/yiE0u/QjHGy/GG3Wf29nzqCmyzdW3uWjW08oZcvkiPfFJyOa4SvT7X+Bo3zUcadxkdEmTQHU9PBJmBacxL6TD4XAerfEDklT5IuWsrqrM6kBe/qSOgOEe8r9lNTm3Et1UjNXq85pe42yCAtOSBvVZiu3GrBdTPyxn0qS7zQWXiZlWGxuEFljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBU3NaUN+KRuCUHmNp5UG5C4EiAw0ITzipPPD8GOqFQ=;
 b=gaBgFVb/xgtqtcoj31oGQqKP2fSDArNQgLqhobpCtDyw23Fe5rOhyL0WcLJTHG1QDODSp9V6z0ASSWU8ix1Z6he5bhR2voDmJuVjK+rrC+nWLY0GT7CKMftrEmV0IBPSuHp3lEuR/dqCZLgNjzMWpsCU4ErBwOTwVIHXcn0VFEc=
Received: from PH8PR21CA0001.namprd21.prod.outlook.com (2603:10b6:510:2ce::25)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Wed, 21 May
 2025 15:29:41 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::b3) by PH8PR21CA0001.outlook.office365.com
 (2603:10b6:510:2ce::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.8 via Frontend Transport; Wed,
 21 May 2025 15:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/10] drm/amdgpu: adjust ring reset behavior
Date: Wed, 21 May 2025 11:29:16 -0400
Message-ID: <20250521152923.401945-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ed173e-0d6e-4212-319f-08dd987c4e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YSxikVBLD3J/0qJBjOC39hMM/sy0kcQJnsqA3FrE/do1LjmCreaNe7JUnRl9?=
 =?us-ascii?Q?akqKP5sXgdZfvR21UrhhAV9zenQBFaRHJ9fqNon6l2eF6Vo9UPjrg82Jw35v?=
 =?us-ascii?Q?vjprkQ5M5MCmTyIN0Ukyy/DM65plIAKknaPIgCDCx3LK2tfGT/Wm8ktNS6Qe?=
 =?us-ascii?Q?Z+xWreeZO5C1Gaq+qgKbry5q/eASHiTZi63bWcet8bYcJGdhXA9Mr/ALK7Um?=
 =?us-ascii?Q?Jld2VuplieTbuLA8SetleZnp8fIEwozUwwk8uycvU5ajQ3fOv0rTS2unyelA?=
 =?us-ascii?Q?VHmxc7kRHG2AvFh/2KE8QgJ5SqwbnKQUt0T2oTsDx7S2+L2w2zgkOsgSuIRf?=
 =?us-ascii?Q?4/eW1FONV7agwQEIfCaq85TgD37UW44LPChgEfWxNt/Fjitekzn7VzMwlSYL?=
 =?us-ascii?Q?J29Q13O4lJekIpzifsVGsQBYFl1ctuUmfb97nzQm/Nk75mSBEul+9kfI+M/g?=
 =?us-ascii?Q?meXI4wifgzj5qPYte5X0ireIcgmkLSYKMY/rNIiWFXAYWGwc3UwdMBB0UUso?=
 =?us-ascii?Q?OHY6xN8+dHEBBn5uVKjFLSCFylP+H539IF+vjy6Gnu40g5pcrMglNmpqPDBz?=
 =?us-ascii?Q?dTmn2vxpf/ldihbendHMIJ4K4ErrhuVyllAUQtW7AjPW8c+fpPWkE+UnFolT?=
 =?us-ascii?Q?vlIMwRXQef4DRtm/7+H6O8DlgkiMT0laP0lyJgw4+hLTX8OtdIePai6HHR28?=
 =?us-ascii?Q?quDAZ/Kgwi4hhj9Yb/lQ6rkQQNIGobHTkBOWhSboieOe08FI3cmsrjCvhFvb?=
 =?us-ascii?Q?PzVZRrJuT+SGAqP5VssKd494GxiaHPiFFFpDoIjAJo6E6VD3CdbtdXs+nr4B?=
 =?us-ascii?Q?a2uZFecOYudwC4Nl4oGUOZZDBLGYQUWsCOR+zxOBTKb8y6YdpEo7I6azq4C0?=
 =?us-ascii?Q?Rzz4F+OqrsIkSTj+08oPlcraleyoRdKlaEE1u2syIez6I4yCyQGCiNN9Egt4?=
 =?us-ascii?Q?hm7cgQgLcgu3MzUqDMyoqNU+vz8MRFib9A7lOJEWNQlNEzKphWSZEmwRcxq5?=
 =?us-ascii?Q?cBw05cyFBzhu1o3na9xBLQIyL1nkw/F5yOe+yLflEqQRKAK7Y5bIsLxl92Hu?=
 =?us-ascii?Q?HTs+OYlJx/kMYErARqHM2nvXdd4f+pWfC7mWPar1MTblo9jyXZPpQekWGMqP?=
 =?us-ascii?Q?FXviBhYbyksM0nyY8g7avUbv+xnEpR2fda08UtRf+29IUdz3DsruWZk5L3cA?=
 =?us-ascii?Q?uT9be8a2LNhC1K2v8pprkBmeZYLEYYjSuNTfasT10MHFN9dFquovb7LbTGbh?=
 =?us-ascii?Q?1RFljQtUAdT9GijN25DCx7xRt3vY92XkH0/QpSF1WM21yRbJ1jGfjbFcYxOD?=
 =?us-ascii?Q?jNlK/HzgXtU8ppgzIsNYCiB2IRx0e9mvZV/z61OfEwTY0iU4aGej+c8FK7t4?=
 =?us-ascii?Q?3la4vAubTYP2e8bwsyCYKwuYjJjtetELsVXN53KhuaA4eWFVROEQYJbtF/sb?=
 =?us-ascii?Q?rK43/gLGgqq6Yajh8+CbXCWUF0mSwOLaTpQ+F2gqt+bNHbwcAMJgc6OLvunU?=
 =?us-ascii?Q?vl5gScTrYvULBFpohjQ5ESRy4z26lOJCd6BA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:41.2255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ed173e-0d6e-4212-319f-08dd987c4e49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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

The idea here is to enable enforce isolation legacy
behavior for gfx 10+ and as such, we can adjust the
behavior to better suite that.  This aligns with how
windows handles resets and seems to work reliably
in my testing on GFX 10+. For older chips, or if
enforce isolation is disabled, the soft recovery (wave
kill) tends to work better.  Additionally, only
force completion if enforce isolation is not enabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e57401ef85140..b1618a33d5f77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -112,6 +112,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		amdgpu_job_core_dump(adev, job);
 
 	if (amdgpu_gpu_recovery &&
+	    !job->enforce_isolation &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
 		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
 			s_job->sched->name);
@@ -161,7 +162,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (!r) {
 			if (is_guilty) {
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				if (ring->funcs->type != AMDGPU_RING_TYPE_GFX)
+				if (!job->enforce_isolation)
 					amdgpu_fence_driver_force_completion(ring);
 			}
 			drm_sched_wqueue_start(&ring->sched);
-- 
2.49.0

