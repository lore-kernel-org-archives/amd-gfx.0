Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AB8C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 09:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCB510E4A3;
	Wed,  7 Aug 2024 09:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IFuwqY0L";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD75610E4A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 09:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9B+fJK7pVUBtUJTHSXJfuu9VeIFQIqNAoJoyJVzquqbgNM7EQQXswXFAszkjJ45CTe4xKsAp9qaIdU9Y6d1Pe8o6XfzXkGTh4Fx188lJKhtQpXjPm5aKd0YpmEjwYKaUm+UEC8MIG2cXYR4G5O5MOb9Qd0QtTA0xXKOYVn5oYjGUK6WFEe8ZFzJyZBlwzYFSS8jH9kJAb6ZOkn4Kba7HsZrRzRKwMWF7GUUZxZA4LqzNFmtoW1fmtrhyonrh88Zb36zqvf3PGsV5sq7ccgG6adHJRI26NZmuxoZC4fBHjp3OgTjLfPapn/Aya0PC6U/oNNcUjx+ORcQNikqviw2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UelJUO9e5dtJkxYpzADfvdgL55v8ejpx1aHwk7nFra4=;
 b=SdUM8o6ixLv7/fyNiz0bbp02IQ4wJdslWe3OdZ8nA6sjwQoAarZGsFB8EfzdFfz89XWD+zbWYZYVU27H5njNi7awnRG+jyTHh2vIpo4Ac1nb+6K/qx4/qOhdJEE2pnFwoGXzXTn766ka17y1LgFUzUYNf6R1uPLTZcb0U58vP1Y+PpQp8xuEXzDWYr+AUjIohqGolQEV9ErGQDo6xlpO+ISZlmcdh+IsCL9vox0kND+A+A+IHbEfpMcHfaRUFf7FRqvwUoRXGVCbMIBD6OnFnZBD7mTjzws2Lh9+UbIrF7PX9SoLyjPPEgnunYNxuJ3U8jaoc0Sc1MZhJX3601UM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UelJUO9e5dtJkxYpzADfvdgL55v8ejpx1aHwk7nFra4=;
 b=IFuwqY0LniabPLa9dhHJtu56Vo9GO4I07Hk78Hcl45X+Mo7RJFgej+68TY9c7Y2FNqt2WIZPAf+7URz7APls7ThD7l+6o9RT+YS4n7zzfpe5tVOeXEK/TYvnuD86GJb2V+OUSYp1QQkJ0QDqQ/sfFPrKq2a+waEtDVEmirqU4W0=
Received: from DM6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:5:174::17)
 by SA1PR12MB9003.namprd12.prod.outlook.com (2603:10b6:806:389::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 7 Aug
 2024 09:39:09 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::57) by DM6PR21CA0007.outlook.office365.com
 (2603:10b6:5:174::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8 via Frontend
 Transport; Wed, 7 Aug 2024 09:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:39:09 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 04:39:07 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 0/8] enable mes pipe0 and pipe1 for unified mes fw.
Date: Wed, 7 Aug 2024 17:38:39 +0800
Message-ID: <20240807093847.2084710-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA1PR12MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa2e4fb-c3b5-4995-40b0-08dcb6c4c9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9VMC0wiWPt6+EPCmD0OUYsxHQyGXfvyx2ajVXURq1DgwWwaEAXHK9Js56tf5?=
 =?us-ascii?Q?o19Z1yQ5+lM/+OsGUcJQHhIABQmnSwWZgmqh4K/l21T2/kOCRy2ICImPqKHh?=
 =?us-ascii?Q?V/LL1xN5Tg4oM/EPCZqjkMp5wwXn9Mf784afUDnzRKRnVUoQVmCMuUGbLhMT?=
 =?us-ascii?Q?XVDhyXz0dG20mZu6EXSQCPWIIV/kxBWXVpRpJPS0tl+gkq57N9EdXfKK9BEc?=
 =?us-ascii?Q?U0WeMJ8TWMtUfuNQuMOoOaQ9GSc+c5Q4m+d4YcqLIO21aGQgjJXIA4sS7N+h?=
 =?us-ascii?Q?60i5X7veHcakJGgaV98hgSzK3qf/GP6r8wE7lFObomL9h8nAMma2jzMeIx69?=
 =?us-ascii?Q?naU1OIi914YMhfPo4QOJNpSM2Uvvq2SJvpo8S+ufu+9oc1tIfP+bXD/8RTa2?=
 =?us-ascii?Q?1GhyI6fVOLx/kG8quM/I1++GdoRPmZlxRe3Zhjx0tgfXk3t75gDLnYkPXZJb?=
 =?us-ascii?Q?Krn/W+1OAhbI/69h9Fuf7zFxpabIdmdjkQ1AftL3GVASYbxXP2SNyDF94BXm?=
 =?us-ascii?Q?gmmEhPd5jNRCq/+T+NAXMfJvOnU4y284uPRE6mhnULhYJEtXPzfe7LEL7lzl?=
 =?us-ascii?Q?2o3UJ5/AW8rz/JXqqkLKZVHK3003QN5myY7mZ1yRFsGxBd3URK8UexnNSm9s?=
 =?us-ascii?Q?lgJZ2/gARSZ2iUWNeX9mnwwSsFEf6Pv014R9xF6HmxFw4vnsu6H2b3wOHiFz?=
 =?us-ascii?Q?pdyH7DgjeL+jPQrhDfJfyJ7aX+h8Fz9BZp+tINhLfm5p0wN1hpGgkG3phpZ7?=
 =?us-ascii?Q?NSKDbA6RgXmH0WyoBA5gvNkXsXo9eqrJSZxk/P2g1bOu0U+lQnd7m6stwmmt?=
 =?us-ascii?Q?KtkfPKxZ4jdZmTkaBF9xdKN/w2jAwp2dxPK7VOLw8gusZvFTEg14hNIVOKAz?=
 =?us-ascii?Q?3l/WBLpPh6OklbPs8bZTioiuGCMsXZ7JaC76zDSrS/Z8RkBACQ8MKDubsX1s?=
 =?us-ascii?Q?476pyNBHCMqWzQqPXbCdxcGX+KaYKP9n5O9GQCdSbrIkSUvWMPGd270+41Il?=
 =?us-ascii?Q?3+A6AjDfhfNVrimcDP6k2i4LayOuFiQxeaM0hAYFPFUKKrVsrwuZwBKtVf/C?=
 =?us-ascii?Q?GokSsr3y7rg434yZGQWHLRlYlsi/lb2AF+XPXs9dRBX15EOhP5ITOcMbI2Cz?=
 =?us-ascii?Q?BPolFIMwVk1jZHRDZYFz+jwBu5FKxwuzsWJIsa57zJkroU/ykJb8xXGD4Sky?=
 =?us-ascii?Q?sDKHFnTH+SKdOs6mFdf5Ld5sUE27//1AUGdx/VRmwT6eDJV/gcpw3++iZ36w?=
 =?us-ascii?Q?2irs0ew1Rsll/60NcsCHRYe1mbXRRqNiIJb3IVo8Y5xzLkEbEwbtJrGXz3Pv?=
 =?us-ascii?Q?9hG8EPcd9F32296I9T7TNh8Cqy1R3JaHE7V7n1Wh4oKoMpwb/6a5ID1D5+Qc?=
 =?us-ascii?Q?MbYB+fIoh3QbzDF8m7XGcgJAn85+zzagRr+h8dsFeo8cSegQx+Izxm6q0+UJ?=
 =?us-ascii?Q?17oahB98bzT2BdzVeZ5bR14DY0Sop3Yb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:39:09.2487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa2e4fb-c3b5-4995-40b0-08dcb6c4c9b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9003
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

Enable both pipe0 and pipe1 running unified mes firmware.
They are almost identical pipe, but pipe1 behaves more like legacy kiq.
As per fw design, pipe0 is required to be mapped by pipe1 to make
some fw feature work.

Jack Xiao (8):
  drm/amdgpu/mes12: update mes_v12_api_def.h
  drm/amdgpu/mes: add multiple mes ring instances support
  drm/amdgpu/mes12: load unified mes fw on pipe0 and pipe1
  drm/amdgpu/mes12: add mes pipe switch support
  drm/amdgpu/mes12: adjust mes12 sw/hw init for multiple pipes
  drm/amdgpu/mes12: configure tow pipes hardware resources
  drm/amdgpu/mes12: sw/hw fini for unified mes
  drm/amdgpu/mes12: fix suspend issue

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  83 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  27 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  41 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 278 +++++++++---------
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |   7 +-
 11 files changed, 262 insertions(+), 227 deletions(-)

-- 
2.41.0

