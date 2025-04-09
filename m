Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188EBC369A6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 05:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D1210E7D7;
	Wed,  9 Apr 2025 05:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f77i4TOq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB6F10E009
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 05:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRwspDyZHK2hyeB6TVw1egxl+JWTxYOYKcj4XKiYSRuGBxBvcBUujxp7XcufU5xbiaVqiTKkien01VBqXDy9vDcXE5136gzkLgtiQW7u3pR7f3piMghOlW7BAvmXFIawSe3yyZEZHbKSytM/eDgPqw+6zN049xHz5QRcPuNLmEXBifP1ypb0fXlNu61mvap2JhzMNNCQUXZFbiFlKJQ4BuT9vVqD+wW1KPTLMN/DHoQehqdc6G5qv25MOvqPea6wkzxxx/lTonVTNJwEpbfvvmakpEAoKkFM20eUAyMrDljG8cvVHs7PJi6wrBm93dHXvWTF944DnnUCBgGvEqPbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CexJY/vvMat0wPllMUJ4xVIjHjkMrqo+GmefvNuHg4=;
 b=YLhiPJ7LXYxkI3NXaJyYnj5zCPzSgJFgRk/LgHWW9dWkTTJ1FINe94nrCQua8sOkn8EKBBsqEuUm9tR/I/XBMInxTHxBz0KmR6DVkhFoHd6PbRmOZhabqJC4cWgPUPmKzf5oocui8M5MR0eWYw0VmYiID0b1RLQwcO6GFT+peQ15HtjxmZixOlDzPBkUzN/2/adFanCR/2UaUE0x+u1GiFvYRgC6veCuR4tom/tK2Sb6QsCua3QyI3V6zNwSAenByK8gSFrSziymBnG/CTm2O//s+NtASvaJBq8PpNzIxdN+1kd7N1tOhXVMmiHoZ0nkviG7nnEyd017vD9wnGTY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CexJY/vvMat0wPllMUJ4xVIjHjkMrqo+GmefvNuHg4=;
 b=f77i4TOqB6h6tbVVghWaBtrc6RengY2ef4qrffaR5z3OPmnRL0OtfMmGntTrMUia9mJ3grzdhRUUmYS6xxOmHAfVGHkLEit3LuRfYjEs8tG3TTIkdNqGfuJtgmxEYCeJaWnRdIdfdd9oGdXX1mbMjzvOkecQvsrkpWYGnzTPoUM=
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 05:49:20 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::e) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Wed,
 9 Apr 2025 05:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Wed, 9 Apr 2025 05:49:20 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Apr 2025 00:49:17 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/userq: Fix DEBUG_LOCKS_WARN_ON(lock->magic !=
 lock)
Date: Wed, 9 Apr 2025 11:18:29 +0530
Message-ID: <20250409054831.2411-4-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
References: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7c2f65-4d8c-48e6-eb23-08dd772a45ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FYilQpv5jW55Eev9Vo/UY2F1TNhZkfRsPfFYUfMwBLT1bj2vhaoE9os92rbs?=
 =?us-ascii?Q?hTKRxa2HHS1yLcsKA/YQLHizAH5fTXPyZhgNBAIyxr+Qf9XJVfXk/q5TyF6o?=
 =?us-ascii?Q?1f2oZbEk1saqawPWIp7k/kqOb43pVHbzDr2s2nTEuFoX7EExJ5Difd9TQbeg?=
 =?us-ascii?Q?HQBVwekPVkMFBNyyHNEqLF6qZXnquNZadwJ7xJQtpzlvtumQyY72rrOSB7oE?=
 =?us-ascii?Q?CyDN1XYcqp03I+BZ2HAWx18neK5yWOF1F9nv8FBrFL9awwPQa4a79yx9TxdD?=
 =?us-ascii?Q?l3WDfaTfrCQ6/yracXD3+KUnErLl0ByRDfBdaRSyrux0hmAgEHqOsq9CUADK?=
 =?us-ascii?Q?H+rjKN/bPOUVukZzddncaRMg8bM7Xr1WyL70aTaCmPLgi2OgOfykACqYrJFX?=
 =?us-ascii?Q?5lBD17YJLawQPJXkhC9857DOZA0202wIThqPBsBqc8JYMziZwHX+H6k0bUNw?=
 =?us-ascii?Q?im4GGv6Z9nF8wX3P6sTLzwIdjpO+fHNQ+S5z9ZGiqC5oXsISth9JvyQMF2cs?=
 =?us-ascii?Q?1MnNEImwFnGn+o6zmD5SJgO7hSYygtSMHhf1oC9cHjgCWshhxkPq/R1OBOJE?=
 =?us-ascii?Q?yAgGSuHBeSOm+jHy95Egd8umH5jCMh3PHWcD5bEV2ugf6SH8V/AnQGQBcHDW?=
 =?us-ascii?Q?iKMLRPkwhFD/rma8gx5AoXQ7H0zQSBRaBoJKLd+b+DqLYPLv/C/9sVBPVy5f?=
 =?us-ascii?Q?VeUSeUbKQ1HNav5i4uAa3JuCs7166WCfhZ2BxBHqEUrqM+UzuVX4Iu/7x5JZ?=
 =?us-ascii?Q?wgxwtjmTo1liPdLbgifolqzvCVU+MXQEcL/1PxOIeWsXT5Q3idD2ttJ7OjJO?=
 =?us-ascii?Q?ipTQzkLCdXIC0ODwon9hC/8E7mHzntCGaFG2SKl8140of/9gSyBZJCFfuLAw?=
 =?us-ascii?Q?G2r+igVb2nlyjXAAH0KyGHfYvRwDqpcEly41if3AZhUxwFqah5TN8vIoLLGb?=
 =?us-ascii?Q?c1CZIVANc/zuJS2F/IylIEJ5ETCz9+OU5/INN7S/snjkLgyBZpurIeNCFemg?=
 =?us-ascii?Q?S33lrBUjfZd7K0Co4OEvazfYK+fBwFUGHqb93bvVjJqqX9sdKvSwiDWOrUPj?=
 =?us-ascii?Q?59QuXa+FeuuWuYOSFsIaMTIDECE3RoWVUHgmYMU4LXRLmK1xqjF7V1fy5kI/?=
 =?us-ascii?Q?c8K6X73funTEfBQWaiGcOkTuSfwQvZqeZR9REVe/I8ellRFv2ACXCPigad/Z?=
 =?us-ascii?Q?4UyEDykS91dFSz2Jp4z5bdEsUESBvC7iKz0nJqx0eApc6wMrOnuPwGD5CwAl?=
 =?us-ascii?Q?R7YLQ/iBLfwNPmLZ9N5vorLTWyy4YNtrFKzkGo71QnC4ggcGxekNsfFnyb9w?=
 =?us-ascii?Q?O9WClnL9Bu4/2hIrl0Qt8yy+F+9iM39fSeBbulZpCpyADNzqJeKyrHMruWYU?=
 =?us-ascii?Q?mTuAcfFAxPPk/akAd/Z4fFCZoY9VvHKPlvZ+NJThhu7B6KumZKnGdEdhlZ1K?=
 =?us-ascii?Q?AVmEjqsm8hZExsEgMZu94g9oiwO/asdtHHLSZ9PX6ms4CLyVDizGEPe24n3n?=
 =?us-ascii?Q?pWFs3qmIHCUTYz0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:49:20.0548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7c2f65-4d8c-48e6-eb23-08dd772a45ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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

Fix DEBUG_LOCKS_WARN_ON(lock->magic != lock) warning logs.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cd6eb7a3bc58..1d7e2b85f45a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1413,16 +1413,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	mutex_init(&fpriv->bo_list_lock);
 	idr_init_base(&fpriv->bo_list_handles, 1);
 
+	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
+	if (r)
+		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
+
 	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
 	if (r)
 		goto error_vm;
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
-	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
-	if (r)
-		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
-
 	file_priv->driver_priv = fpriv;
 	goto out_suspend;
 
-- 
2.43.0

