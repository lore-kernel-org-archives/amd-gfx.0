Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D144C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 05:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E0310E4ED;
	Tue, 13 May 2025 05:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xVWvn79o";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CFCC10E4ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 05:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLNT7MH+hUdhTL/omvhud9XmnY1A75s36dfFMULMHBKeYrrEjx+nUmRfe3weiLhbx8/20qEFHNrPBrAxcryYh9RFhbQHppjA8ibiKpkwXpnja/3LZgGCMUHY27FVS0sxIZyVYoeK9KE7EmOdcB/iW5pbDqGwoHduAjgXQjIBiiYuh83zJyT+P+WGqUKV4YsfBDKoCbJXUy5hrAY5FtxTlb+rtcQksKXs/ge2Df5pvGOVdJw2WKwRHViQtkHJj/cOdYCKvhX81ngSU6DzUJwF/YcgszYIwLo+dRSc50KypFf2jLiRaS9rRDW6dSaVR8rDw1BZhE+8fEcMxW8P4m1q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4VmT0wFcrFfKP/zOoMg2Dtkwb3+Ooj5NhIFQCIU9kg=;
 b=dHsKO/q+5RZe1HMKLzxVoPjyA8FN3UbVX909/hD4nT5wrSquGKohaD7jgPpPPsvfbkqz2PMO6Qis7mYYEV1uDguSNV+U1Jp3kUKwZsweBvL9H3J1h9IGNlHVToBTnz92aJ8graV4sUfdMONhT2/1+B1PKR/gpLyqxi1+66Vg5X4Kn9CXCnZRACOANYeOW8lthpl5HJptfXG/eZNQUxNsmDNqpiD0S0w1iOWaPZcYnmluYh/wQYlQZgMJFmz30W9N5vB9xpQmtMH2ZYdiVu6/kkcbRVh8TItvArCy2bW3gkXkHuwwsZTMwoUyEB2FRvMEWjSwlMd/2YIWNx0vrZHwpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4VmT0wFcrFfKP/zOoMg2Dtkwb3+Ooj5NhIFQCIU9kg=;
 b=xVWvn79oWwJxS7mQuOvcgbPQcOdFFhYN7mi2a5JHOqzRIDgN9HGwY94u/9WDgeTsqQ230ZRAxT1C9/pNgQvT8TbNXcXB9LP11KexBPBpx6f9YVrL/646VTEZ1H1iawz5FjwEHqfpo1WmpZ9zz4McE3RNiouK5a2En1dd8eKB1mE=
Received: from BL1PR13CA0116.namprd13.prod.outlook.com (2603:10b6:208:2b9::31)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 13 May
 2025 05:11:22 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::92) by BL1PR13CA0116.outlook.office365.com
 (2603:10b6:208:2b9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.6 via Frontend Transport; Tue,
 13 May 2025 05:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 05:11:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 00:11:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 00:11:20 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 13 May 2025 00:11:19 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: Fix circular locking in userq creation
Date: Tue, 13 May 2025 13:10:14 +0800
Message-ID: <20250513051118.112575-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 71881d97-38b0-4819-406a-08dd91dc99bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?guRBshCzB7K2ak/udFlw2ak/MeOzDmo5p+wPlnr4voCe+u+Bgk1Bgdog3/Hl?=
 =?us-ascii?Q?0RnrJqKrtzXRMPSiS0VVsgTaoS9U7tT6NCOtUIIa7qGg4chbO2NpB7qVjCTU?=
 =?us-ascii?Q?eIT9hIOEhj6mtqqR6oMnoTd65oKoChoWIcCqbsGo5TClUWpPYiqbLMvyv0/4?=
 =?us-ascii?Q?A+N8jFUfPkG2tIls2lUvXn+tDvwaJ2yG8LGDmy08hDafXNm9VH5cIu3YcE8U?=
 =?us-ascii?Q?Cblj3q414JphWW39SwMkMssy14omYyBA74m5qgA3wpl3uZVvNHtlVmlpilEx?=
 =?us-ascii?Q?NqtkWShJqhByUv8xvHnwQhLH6bttXrGCsPpq+ch0s3LictwlwzaIrI/gNRVJ?=
 =?us-ascii?Q?SVwspsToYPKQ/+Rm7l3IibBPGMGIiWfZNQQyushq6sBRh/E+0UnTxvKZHkb/?=
 =?us-ascii?Q?DcccWlmx7aAKKosqKSA8fXCbwgjvQuDjptePg5abRca2FIgle1G45jbLf+YE?=
 =?us-ascii?Q?RUq36kTYxVQ5iVb74afluijxl7OmR3kFBAzl5e4/FDstzFXdyg0LQewz2k+k?=
 =?us-ascii?Q?pQLuZjjOEGWtTtVX9IUQJGf8tXgYQnc5wB1L0zYpXXPyTI3v0RZ9RXC0zGyU?=
 =?us-ascii?Q?VKaOZ3OLUtCavsgUcGnpBqMY5MqzEu/6bjLgOPsqdK9rWNRfJoqerI0CevVK?=
 =?us-ascii?Q?9blTwKlJyUqSYPzI+4ZbuSKJaKUPEgcShfFplqUdde1A1mKY07BIoDrxdF4d?=
 =?us-ascii?Q?qk79vXSESu9uybycd4NnDTeQFrcM4HY8WqM/GO64cGmIBYTCIh9ONJtaV+7R?=
 =?us-ascii?Q?8H6EBcebTAeyfgI2t2ThpmjF2whW/BxIdm9uKtsAYiqnPGtrZ2iKstfET5Um?=
 =?us-ascii?Q?VhxR4F0El4QXXlBcZxNyrHzusm6OIqV+lOSYqsiOdbShi3eD5/qHMkvBzuBb?=
 =?us-ascii?Q?S+EpF9ihVw4fpKLUmXv/e1BcjXdhcSwxdujLmlRCSxl+niFtHqTf78QfOMwr?=
 =?us-ascii?Q?FnOI2hTH+umNwLaUcIi6nqyEhO0Kyq+IoWhrnjPHtKN4/3V/PV0VRb3hPYki?=
 =?us-ascii?Q?13fObD4h98ylfxza8q365Rdz0nkmZNkl5XMjr/GCUkB+MBaIuhr0zD9nfZF6?=
 =?us-ascii?Q?JOtBg0iieT4yRPnkkqwSobIsQyhXMUbgLcUBnXx1B/9F4KPoR03sqtyCu1B0?=
 =?us-ascii?Q?uaBPtQYhxj+CVe955PrMppGojHEykLujT8Tq8bW89QLZ2xlYs1+MVIoR44Gf?=
 =?us-ascii?Q?zsVHecvjwglqvLH0SJVoi6B2bmeGp1lS2M8Fvlryii60hBTvSviqRp7djpIA?=
 =?us-ascii?Q?wCMe5aL4AIicf9+NSntsphtsvnqr+7x2VZzxzVd5LMlWHVtqu6slZOB5HRQM?=
 =?us-ascii?Q?OqF1D88V5bgPaRV4t1Wr5Yop3xalBpEzuS7S+eYYsuxVORibf+UDzhx71UiN?=
 =?us-ascii?Q?L+heS2kmcVeNlbzD80cXGbcMfgkWQY/PbXLs930AW5wmBNAGxykPT6WuGcUT?=
 =?us-ascii?Q?GmUmFbLUqtavAaI0J7njLcWlyXHnb0M4lxUd3+hEBK7HJF+AoXz+5f33QJEe?=
 =?us-ascii?Q?daZezvztGn0JS/2hcJq5s8Lf9YwzvTXjG1bT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 05:11:21.4132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71881d97-38b0-4819-406a-08dd91dc99bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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

A circular locking dependency was detected between the global
`adev->userq_mutex` and per-file `userq_mgr->userq_mutex` when
creating user queues. The issue occurs because:

1. `amdgpu_userq_suspend()` and `amdgpu_userq_resume` take `adev->userq_mutex` first, then
   `userq_mgr->userq_mutex`
2. While `amdgpu_userq_create()` takes them in reverse order

This patch resolves the issue by:
1. Moving the `adev->userq_mutex` lock earlier in `amdgpu_userq_create()`
   to cover the `amdgpu_userq_ensure_ev_fence()` call
2. Releasing it after we're done with both queue creation and the
   scheduling halt check

v2: remove unused adev->userq_mutex lock (Prike)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 697dd3cbd114..2ee63b33724d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -531,6 +531,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	 *
 	 * This will also make sure we have a valid eviction fence ready to be used.
 	 */
+	mutex_lock(&adev->userq_mutex);
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
@@ -594,7 +595,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	/* don't map the queue if scheduling is halted */
-	mutex_lock(&adev->userq_mutex);
 	if (adev->userq_halt_for_enforce_isolation &&
 	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 	     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)))
@@ -604,7 +604,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (!skip_map_queue) {
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r) {
-			mutex_unlock(&adev->userq_mutex);
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			idr_remove(&uq_mgr->userq_idr, qid);
 			amdgpu_userq_fence_driver_free(queue);
@@ -613,13 +612,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 			goto unlock;
 		}
 	}
-	mutex_unlock(&adev->userq_mutex);
 
 
 	args->out.queue_id = qid;
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 
 	return r;
 }
-- 
2.49.0

