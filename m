Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3334DC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 22:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09EC10F238;
	Thu, 23 Jul 2026 22:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a2by6s00";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D34110F238
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 22:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/pLbjg23l2zxzoHiyO050h1E8WTHMf2+PAwkKzraCDeQOzppOIeN8iqJ1PPi8L48ksv3OHKIXbhgJZxwS/9Ddb4VaCs+mju5PvCgbKmycUvcdKDG5MAYBB/vgPJVw4pcqm3q4vdmks8PzCzLH9uiT0Bp9UTWNAMfBF90IdhYIJiSYfNkhJDUOizuGf2EuJ+Wpaj0TEtop1pDpSWJqUFVcQfGiz6BVJ6+9pYYr9eIfwX5umH26yn8N9Wn+0p+/OfSvV6vuUF3UohOXZWoR3DnShYZWfu88Cll+VR/LIoXAFRoQuIUWWEPsVt7bPZ/d9FnwNhouYMzSmmfa4F6tk+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTCH0zx/IFvK6x7rNc8BoloembtmIg+dKocKSNtx0g0=;
 b=PlAt6DYGZyLOK72fL+yxQe+BaMQaQkBoUMh7dYAsI+kFgbiuDVZoEvSyy28W7zvM6UHmS2F9r2NV1fUBsVkGnYLrQbE6+ExckxA4BzUAinpyqDEDkuF+Gz4wjJtK4j50fvWKWJEyWwJjJay/XDWDOHDszT1Q1M0bpInkuen4KNKODA/Xn6vevDVCuAwdP9TyRIpwe9YNSJ0bPGBCGNxcvKvJTv1QAhMDU47GDa3NNmW+Fx5MTkQW1ppSHZEbsl++zkL2cNVxVZmWR2t6zln1BMs86PHvjuxHJ2FtjVc/fnkli4I4JcrEmyhNN3Pwe37PuWZu7dbGQ+aUgsm3lk6jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTCH0zx/IFvK6x7rNc8BoloembtmIg+dKocKSNtx0g0=;
 b=a2by6s00MTMbk++sHO9wZ/urb5q8Ox2PbrNMbQDCYBZIPojp2Hv2FgK0EYMwaHCdwUL+4JwkfUxOSBg40WPUj4czFujrIvrju1jrtdOPq79us06eTKg4L9e6OXwVmBxAyfRG6RZ3z5k5zL9psrbIcvArXrC7nQoJVrKzLS8gdGk=
Received: from SA0PR12CA0011.namprd12.prod.outlook.com (2603:10b6:806:6f::16)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 22:19:15 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::30) by SA0PR12CA0011.outlook.office365.com
 (2603:10b6:806:6f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 22:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 22:19:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 17:19:13 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 17:19:12 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH v3 0/2] drm/amdgpu: Fix lockdep false positive in MMU notifier
 reclaim path
Date: Thu, 23 Jul 2026 18:18:41 -0400
Message-ID: <20260723221910.85822-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fdc5ef-c2ae-4d7b-cc88-08dee9086d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|11063799006|5023799004|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8X7dRPpIXNK2NlCPdgiqAd/qm7hQdIQuqBzBjhvs1e/GNNye0CGdMCII97MvBRaGA1XqBvg1GDbvhtCVZD8kYdF+CXpdKUrg9Q09JQJoDaIASvBjtlrzxNFgjBZZWjI7jARtvHWwMm7GNvJVVqpXYGGlJuZ58Wkq8OgB69JDbnk+Aky/fl54acojwbJX9NMmRh8vPWrEabQVW+i3bt4UZwZBzeNYu8LBK6DFSmBCTIjhATWgkddpERtZkdGYPXYXzfTfVgdOd23MoWmJ8P6vn/kqHyqeMmzg7XhHzjve/uLeK3P512x0vlwhHFaNZ5qSVU+EB5DgHBUEcJurxuwPsB2hubRuW+1czbupdOI8Yi03adQI5d82gtJc7fjB3GTnEZeVMIL0gFhdPKQETmJyFbXyZY+ce3vqMlQoZk3vapdDlKp7c60L2g0MX7L419TqXdjdfgOMkGBy9/XPkvFKMwS+wLcGwFoZZ1FE9YZcqrp+y8ePSXcah2dUVgBp9MjPradNnEymt8KRfDGzi4sxLQuyAG2pM5q1qeONV4njTRn6PtwBxcBZkmheqCwpDyDltEN7Qvno8WzBehESMGitMcPwh8m2q6bv5kqDq71lFVktUkNVt+2ImPnNLSLaqvjU8x7hR2rdKC+IJ1X0Rma6jabqHZvDhZTINhgoTIJdGTq7+/KMguDUGrLOeZiFmReBQMRu5OQW59Pyy7SIxsOs3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QasLb0Sa7jH9IbYd9nzzKiqh91JHch+aFNT/hGp1HWo0SKHd57of0NA99sJOPHgC+a1RtdyUTwdpgIe20q6ZLaMq3rTCjiKAn7rKf4fr7HBYvGqn/qTxmqIS/UCIyBxnzz1vEHYMQjh1IsT26iSeG26KGKvvP5tHNeBbKCog8ZCqxDQj5xOaA/6H5+MiwUEYHAHVoHPTPNvFaRPv4Y9DwrW8sk9SWY4owm+NyTOKiry9YTaandhrOunblNYQwjoQowa01xhQu1VR9s+1kAS/rX1YDHZivkxvOXSw87xaIhHzfQ1t9SnclxI4tznpJAWq816RZn40z6RC26WVmTfyagJ/9e7/LE9W3Ed48mx6AdX4o9/dG0jKVaRMrAnQo8g7JfmfJrFHh31k304dSXoyyf71xBTVPI5jbAf+V8NuUI/KkYwRpic4lh6ArLsiHwOG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 22:19:13.6707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fdc5ef-c2ae-4d7b-cc88-08dee9086d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

This series fixes a lockdep false positive warning that occurs when memory
reclaim triggers MMU notifiers with amdgpu userptr buffers.

The root cause is that amdgpu_lockdep_init() was teaching lockdep the
incorrect lock ordering by calling fs_reclaim_acquire() while holding
notifier_lock. At runtime, memory reclaim establishes the opposite ordering,
creating a false circular dependency.

Patch 1 adds filelist_mutex to the lockdep hierarchy (preparation).
Patch 2 moves fs_reclaim registration before all locks to fix the false positive.

This is a 7.2-cycle regression fix suitable for stable backport.

Testing: Mikhail Gavrilov's reproducer (IGT amd_lockdep test) runs 8 reclaim
cycles with no warnings after the fix. Before fix: warning on first cycle.

v3 changes (addressing Mikhail Gavrilov's technical review):
  - Clarified that fs_reclaim_acquire/release pair only REGISTERS the
    fs_reclaim lock class when called with no locks held (doesn't create
    a static lockdep edge)
  - Explained that the actual fs_reclaim -> notifier_lock dependency is
    established at runtime when memory reclaim invokes MMU notifiers
  - Added Cc: Arunpravin PaneerSelvam

v2 changes:
  - Fixed author name: Michael -> Mikhail Gavrilov in all trailers
  - Added Fixes: tag linking to original commit
  - Added Tested-by: Mikhail Gavrilov
  - Rewrote fs_reclaim comment to be technically accurate
  - Noted this is a 7.2-cycle regression for stable routing

Vitaly Prosyak (2):
  drm/amdgpu: add filelist_mutex to lockdep lock ordering annotations
  drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init

 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 48 +++++++++++++++------
 1 file changed, 35 insertions(+), 13 deletions(-)

--
2.54.0
