Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33369C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 13:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D5910E76C;
	Tue, 30 Apr 2024 13:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WQxbLLeK";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0663410FC79
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 13:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcZELF6Uf42OnZed0/Xw9bhqzeR6117DL7eZ0/mPLlUnviLlcRydBnNTwWh8HbaF+l+w30mHGeaoN9UqA4RY6hHwttU/mq4dnAGG32IyUOMFLghRFeMnub7X1L2y0BnDPS2y32dgL93OHkKGsPhUeq1fcOJgzcqy3fehgDFoTedWNxHqt5WFHPzkAnGJZjSKviGvilsbF8MG1c6c5QhM/Yo09VzjzmJ2ETbI528d1hNm84uAvUJwDYAafVsimTyyEo3bIiuRhzwKaf8kghZ7BnqRs2nz831ICwSXfOJq2Df9OyBVr1uG/v2aDXw4TkJ1lwaTfTmbNGCqDlfcb6qi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3r18mfT2LOs83SA3MPNUvyg+8Tfr1bE9i5IJjYKSVA=;
 b=BJnpEFf+TNADulabqIw6oeSitywJjnlNnWJ6h1hjE4uv6YbjC4iHQH+3l7ANBT4M1dkyeS2QN5QxfIcXLaRPZJCP9wOGXLX6vOtGYC6kx2liOzOJ1CCu0NeMpZ4zwXUe8jCDCuwDlzfO8czLAgtagagqvMO/I1OzUFI+UVHgLJeIb0gGC1+YGt+MOM7V+3ln7gr9FcY9lP1bO3ozuexN1r1lC7UKjTK0e3m6Tx+C6BEjKqXYMw1E3ukbyb5Eg90JV0C4I5+f9zQ3a2Ot1PBkW5TJrUaSfhoQbMB9tZ20jiTY9ERjtSboP3vty/K7qZuTC7ZdTL8EH+gup8C7I6bEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3r18mfT2LOs83SA3MPNUvyg+8Tfr1bE9i5IJjYKSVA=;
 b=WQxbLLeKNN7Uv6jlfvkiO93xMO0g6uCDGb2Fs/B8CccsLgSQ3x3ft/9T8UdjhdezHuOxex8v/uuNiE7idfTvoYLq4a85++epB/GEhxGG6uD2/sLyREh/WpLWojpx6vRxpR2F0oMCVtnjpH19wnyFkGtCJqbs5yQfN+pwRGYzqmA=
Received: from SN6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:805:66::41)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 13:23:41 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::48) by SN6PR08CA0028.outlook.office365.com
 (2603:10b6:805:66::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 13:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 13:23:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 08:23:40 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Tue, 30 Apr 2024 08:23:40 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Override DCN410 IP version
Date: Tue, 30 Apr 2024 09:23:40 -0400
Message-ID: <20240430132340.16902-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9d83a1-d403-4e95-c5a2-08dc6918c0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RQ/e97SkJ3yCo5aV1AX1EG+x7kkBCYtL9WOpyIFgcIn2SMNBgnmoBjxhAMl/?=
 =?us-ascii?Q?EuGn8iHLoMGhk6Jz3VYkVzKa78AgBKjiyrlqlibjqA/OxjLbsgzYyE/9SAIy?=
 =?us-ascii?Q?doav0GgOT1wCbJJF9XmPjSpAUiKtpGwaoiuNOP5KfpZ95VUd9Vkx0Z0Tc3nd?=
 =?us-ascii?Q?Mpq5u8UMARTrJRy1MgXB3x8HNFz0gTjCnGeTj7nvO7yy7+1X4RConlu9yV5x?=
 =?us-ascii?Q?UeyVHmNq9XFCo3/K+OxHAmm5O7jGL4x8NJk0aZFQDkqZCPKtMa+TKsu+W75F?=
 =?us-ascii?Q?NvCuzILLbCAkFnPKDF8FCXPducU82XuqnPfzpJn5wdgCcjvLgLGQioBwLtJY?=
 =?us-ascii?Q?fmmDfbI52xty+FIuEFmWlhXec8inqBUTDsF69+fhDPzmVMzahDicX8V1wMjU?=
 =?us-ascii?Q?oBD208Hv4UmCVAKeNoPpF1nDPRku7d8feAddv+6mi5CcyR/4LEKbUj6G6GBu?=
 =?us-ascii?Q?ksBJh6yWkcjy8l3FmwwKoIW9I54/0AANwJEg8A/0im0iJAcRE1fgW+Z6dNiG?=
 =?us-ascii?Q?2vTIpiFgPjXoiRRRgRz5+YSCm+cfrYcgTFd4T8A4RBDKCqQjQ7cXzBdtiL8R?=
 =?us-ascii?Q?XXOJa/SoRbgOhu32q0ap6H1DhLV4Y+y0q53WqFWZ9BxXekgXto+Rd3DCZh9T?=
 =?us-ascii?Q?Z9mSBk/Jvs4k6HxP8Nnn7HWFfN86gUDPnVlfni7reUPJrt5izfb1cjRe/+pq?=
 =?us-ascii?Q?uarnhHd283cDGbuqFVciXLpOlgdXab+1mVJi20fQKK97BCF53IFfB0Zq3p72?=
 =?us-ascii?Q?X8APmjTaXw6hTIIKxvLPQGEzEs5dPUPc7pnVOvngcxiJVWWxJ8VRN4PUeymH?=
 =?us-ascii?Q?D6NQW5n/9Wxrqv9MNuc9dTpoRtN5MfG4ExYxbIDGgsbCs0FvhJ9P/F6S3B7l?=
 =?us-ascii?Q?KZTkZTmljhx2nXEsU4JVp/vd6hTG0qZvoW1/riy9vYKfIM2ZPf254cUrZImc?=
 =?us-ascii?Q?nn0W7OOKFFD+4yzU0wyPcyioYt+BmOqXqotqtj1TbpVft0GBCOlEALANa6B7?=
 =?us-ascii?Q?08BLCHl594aIAKVSHrWH7bZABMUehBc+t1qYKVceeVxfonYiyg/GXPm3f2zK?=
 =?us-ascii?Q?o/Q8v7QDIXUxumbza5f8M3KBke8vDuM7AXttT2huPLfdd8qyXACzCj82ylW5?=
 =?us-ascii?Q?49zfP74tinthNYbc3kjXDUyeLvGZLcLQMDZtyQ2NS7nvYyoPjbjTaBvGXzFQ?=
 =?us-ascii?Q?xcg4aykkjPf/WBzRdSO5y4FXeGN/Qk9KMdfFmp4w46BDkAmRQp9XNcU/0IkK?=
 =?us-ascii?Q?cj7KX0bFbxkxa5gUQ8DkhV6k94eJVg/iNUaCXluwnOUDKwunUUpNOvAUqfyZ?=
 =?us-ascii?Q?hYsVZDYsMaNzVyf6AkLek2tlFg7ziOPgWRC4uRLUgLi6Lmo8WGge+niVCt5t?=
 =?us-ascii?Q?+yCeIfVzR2rK/5dAT1DjFUYb639X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:23:41.2346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9d83a1-d403-4e95-c5a2-08dc6918c0b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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

Override DCN IP version to 4.0.1 from 4.1.0 temporarily until change is
made in DC codebase to use 4.1.0

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2aad1ba0ab9d..87a2f15c8a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1965,6 +1965,11 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
+		case IP_VERSION(4, 1, 0):
+			/* TODO: Fix IP version. DC code expects version 4.0.1 */
+			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
+                               adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
+
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
-- 
2.44.0

