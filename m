Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED329CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 20:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9185610E20D;
	Thu,  9 Oct 2025 20:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5OZ90k0N";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FC910E20D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 20:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWOIh/6a1oux75x8ao0AkwMauyp/Or2GXg52wK/Z5vky5rwkTu2lSCZjrR8Eiwp1Jw8rhApUHowgxCp+5ZNdPfSf3ySFv7M9k0bfi8RmKKgbXAC5Tqtw53YVlpVfusHuzF/i1MBuD6Z5FPjOAsUPPGtc+ysPZh7OVi+Ek4D4HgBVpvH0gzzjU6fD0YxV+d3JE90cZuXifD+he/fg8myXLFcyAtTxT27G4wXW3nWQ9DFS+xpz6A9YF+MnpPJPpM5q8SEU7LmCmi5tcjDMZYzEQcMe4bBY741QvcgYHW50fPOW9PNL/eBDHqmSJiFiQy8HodlFi+q/1ITnTVtE6lunJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EU2sPDiNMkNu5SAydCo6k9dFVYPsXLd9J3j9KLw8ls=;
 b=P3nNOcrMzskWgby8peB9Ytj4PupjfjhtGYeBD39v2gN0mWG4dmg6dWDG1w/LzfcbP7OF0Ct2c+DQerfNLzqB41O/CLmpWfsLBFrDhaGMkdCF6yq/DTKyuygpHZyBugr5Q6rNl9jNeSSiitQDWkGUrSe/sIxfHVEien7YEXD88p8g6yLzqkCpsup2Qbg1vLReA7GKAf/whDhq86FOot6HkfqEApoPaMIh+TcLeiIw+Nj9eHq6xDKV1wRiFrqy11ARpgJNgwTWbqD3ZuS9XxjAKXIMv4tMHAwff+O++OE2Q14ZzvYX1kB41xTopYfBeg3s1w5BmkvfKpBL+O317g2EvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EU2sPDiNMkNu5SAydCo6k9dFVYPsXLd9J3j9KLw8ls=;
 b=5OZ90k0NraWPYheR3E0EwHmvK3XDPiYcsONzHSFoyMbMDPd4mxUfIoc9KKHWmUL2MohZo3lvkrSy2JO3kOwtg6JTP03pgsCGb/ozy4I7KmPnrkNTP2aQ+fWCt7ApoeF+si/Oi1YGKlcbEDjqVX2dIp2+YtPazNh141wjJf46KC8=
Received: from SJ0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:2c0::20)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9; Thu, 9 Oct 2025 20:59:22 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::59) by SJ0PR13CA0015.outlook.office365.com
 (2603:10b6:a03:2c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 20:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 20:59:21 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 13:59:21 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v5 0/4] Adjustment to power limit setting
Date: Thu, 9 Oct 2025 15:59:03 -0500
Message-ID: <20251009205907.177404-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: df5c41d1-0ada-43bf-944f-08de0776b8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?chl7+vKM4X3pX7THRKzfbiLHzRhDAtyfyPk3Jc9lVrCdjSyQAW0PhJVlSWof?=
 =?us-ascii?Q?3Ln8PqqgWQ/b87Wr10UGnh3OB+g8G5kNUJo4hskiD93u9gYUCdy+BsrK8Kru?=
 =?us-ascii?Q?9jsFyccbkpTrGq5tsxZgQGuhnKXQRKaBQDbAER5iEK3lrXZMOzoy0L+bZ2yi?=
 =?us-ascii?Q?YKeKMc21T5r22+IbHe6FlY1jIzRM2cdBVxkdxOLhbEFSv/yDxpNVROg6uG/A?=
 =?us-ascii?Q?NphmOyelkenO08E/XpNROpkB+g+x2r4G8rGDrM3hOf8M5FO4Hw3h+UMdyiop?=
 =?us-ascii?Q?lcmDrVm67P7kSwUROV94fYgiSa7tsdri/LPfKKbQFryfpq/8G/dKszam8tE+?=
 =?us-ascii?Q?yJN/bkybc9sOX2gRgWJN4uOBFYF6JKVqKfF9IR7r91nSH31riywRbTHNG1Bu?=
 =?us-ascii?Q?JxHbuT2aO5rlFbvumt50sX01OekcnoLSLRdpBE5bp1PzFNs9Eu2aazzHcA24?=
 =?us-ascii?Q?+nwVHs9g3B9tkkCvtQEfEeN/yJlme4sOF85TLJ3XRxyQAYY8C8qS5HuI1KE9?=
 =?us-ascii?Q?MrluXjVV3QPUQudNaUOV0r/U5emkQVLwqNP+3KPoHHAPRvMvOn3T1KR6/Azx?=
 =?us-ascii?Q?b/PG1ulLmYBdcZtT38RDei9XbfR/cerUf5LVuxu/vgTiy9EDGzHKGkZTEHpN?=
 =?us-ascii?Q?yPjgPjYe8yo+QsfYrWGgfT5EzkSeWCH9Ds0m++QdWGzOJUlH/JoeXPzNzA2r?=
 =?us-ascii?Q?EfHA9HnSDJaHlOR1KOAm90VZmo2Js/pMtODscUNSH3phSISQ50HZUgi9Tw46?=
 =?us-ascii?Q?ZBY6l3+VP8hAUucw9xa6i8VKc84SmB5Be04ZydeikUf8+NnPkPd9cGqdn0t2?=
 =?us-ascii?Q?k4rutd+e6pJ8TcY13n8L694tuqeLPLFcdoZ0THgu5xsVjUYlIxfsb8J53a7J?=
 =?us-ascii?Q?JUJZvxm28CF8Oa2LcXPoiDQRbUJhg+kPS74znQZCvJ9Qri8PP482eCeOPVH5?=
 =?us-ascii?Q?jB8PQbJSN5Nyv3GJqDJKASDjl/a3j4D83DdP+CoAyzIUeAMUQS8ATyhKUCcu?=
 =?us-ascii?Q?teHz6cYiasR4yBk/RkIUxVF0YY92Qf95DwYkmoDnMODS4PwxOyuiS/mciKVf?=
 =?us-ascii?Q?kR9KecZihy9yCsmVICLyd3MlJKi0cgyeOQ0TPtYo266QmUXjZbXY5aRuUBkG?=
 =?us-ascii?Q?KcD6Z6LR/kVRONDC9jURg+PVbiTvPjb9bIor9HvjAsLo1S+woO0az+puKAdb?=
 =?us-ascii?Q?97ohl6q5HuXUo8lNMVj976+uqICHSVmcNjdzZmawpLEwye3KeFKx66r9h1pC?=
 =?us-ascii?Q?nmvKtjX5iOzecuNBDm7zh6DdpVrH4KE8B52gfUnj8bePa23CsnOROxr3c6uI?=
 =?us-ascii?Q?GkSrw+Q1izLPoETDIQY8cHCqxB6enMV9BRTSu7hefC8thzc+eYlatr2x1cO1?=
 =?us-ascii?Q?Slc5ZgL/lY3+uABJJaRxUoexGnK6d4g/LR1USta6EHLWZvvtQ7piuATnT/4y?=
 =?us-ascii?Q?POid+CryQzC8UfO7a6G5QEOz0YLU9+L1gLK6nHOVpCHtcovWmE9yu8E2q8SH?=
 =?us-ascii?Q?sCns8yopXqKU93Qwsznw/D91nfP4S2ufy3RbdM4lcIuCwvDAVeUEUWRmdIyd?=
 =?us-ascii?Q?si1i6Mgrrpr5iWG29kg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:59:21.9331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5c41d1-0ada-43bf-944f-08de0776b8c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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

Lijo pointed out to me that
commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")

both should be unnecessary because smu_restore_dpm_user_profile() already
restores them.  However in looking at the code there is a case that isn't
properly restored - the FAST PPT limits supported by Van Gogh. The nuance
isn't immediately obvious because the limit variable is overloaded with
limit type.

v5:
 * Re-order limit of zero handling.
 * Drop first and last patch, which were already merged.

Mario Limonciello (4):
  drm/amd: Stop overloading power limit with limit type
  drm/amd: Remove second call to set_power_limit()
  drm/amd: Save and restore all limit types
  drm/amd: Drop calls to restore power limit and clock from smu_resume()

 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 59 ++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  1 -
 8 files changed, 31 insertions(+), 44 deletions(-)

-- 
2.51.0

