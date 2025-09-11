Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A76CAC596
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 17:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E83510E3DA;
	Thu, 11 Sep 2025 17:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cMtZb4bE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF6D10E3CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 17:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO6DD/GuGra33r56wWSzXw7tLNnRXEup2Ay/wWN6U/JL8a7Jlzr8uq6DgRWGIR7aPsdiw1i8VoniwwZjEaqrBw905SvcOSIDqkuvsVqAbOrH8FxDhzv/C82yYk3Qp+5dcLInlnYhBTLfpkmzghMqz9a02OFyqln+/0gXl9/crgQFvKPsPASQbVGkZEhy7Cb8E2BMpKuqhfEtcjt/WO7dia2e7YyKv8nri/hJeblLBF98y7beEe6KIZrrN3H63ZO+A1BiWNSof5XJMkVTpk2j1m6niidp02w+DS4wvHsku7SSOe2BhpO3i1bXzSuGe+cskKwX9FjzoWigDjBKUKO5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNpkwi8aHvPJc/cwcwx8l2m7qIOzkAOUXNYDliiQuc4=;
 b=Xu9mANqEz1zhmaBUiTARl90gysyOLlfvTY+97XfHjFs4MtFUMofK15aaFA1sDSN9QMhT+0pawnys5Rg07kfHczRuvMs9BEnBijzMu6vBB13kKVInP1uLGXsyR2UD8k6GwKW+Eii2hWfYp2uTHT9bszYYTXTMxj33BKS9mIPexoK8zC8Sg999dKZGx2zXj9fLobubLj4LmKcTq7qE58o6pJVaq6g3XBW3qn6LxOO644kiurpg320ZpovaE+LqVbhJTywTYbqQy6eSa77NWyglx9GX+myyyNRo2cFsmu2JHtTRmQiuYlf0J3K1MzQmrYvze5m8g4zFZUeSnUXWvc5NrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNpkwi8aHvPJc/cwcwx8l2m7qIOzkAOUXNYDliiQuc4=;
 b=cMtZb4bEAtHJXSSiKSZOGiNIEJBdXC472JpwMR3jGMfaFodH9Ks678yv9qpMusV5jf0Yn9klYPhHH7TyZi3SHimH8XSbmIdzeHQiWPbeDnkmCqqGI2+72bXNVVeBxs/hdTGazp/lE/sc6MU9bUOvBB3H7u3k3vZd+KDLZvC7Fmg=
Received: from SA0PR11CA0083.namprd11.prod.outlook.com (2603:10b6:806:d2::28)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:25:15 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::75) by SA0PR11CA0083.outlook.office365.com
 (2603:10b6:806:d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 17:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 17:25:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 10:25:05 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/sdma4.4: adjust SDMA limits
Date: Thu, 11 Sep 2025 13:24:46 -0400
Message-ID: <20250911172449.3340848-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911172449.3340848-1-alexander.deucher@amd.com>
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: c78aad83-e9ef-4a34-8311-08ddf1582c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+TcSW32DL7Nijp6C78V/v+CafIS9KSwn0C72tA4R3ewsCkussnqrj18x7er2?=
 =?us-ascii?Q?3OuVFFZY1ewPedXImfT9j3ybhHRHgHZ+WNwAX/Behk8hT5a5clqZa27RNVNC?=
 =?us-ascii?Q?Bb9bGg5EigIB5sxiHl2ZtXg+yVfbJB07GpHeMXeABuxjD8jSi6CznmoeFN3R?=
 =?us-ascii?Q?S2AHrl2UW80h5sQ9HuM3VpNDLbdHTC6bVfGdTTuygfQPp7NdmMIvDf7lGHza?=
 =?us-ascii?Q?ZJ3jWwAFUHTjPk8eeePq8U6ARLDAW+rKb4ig3HRZek+ALYMzE4MwLZtKZehG?=
 =?us-ascii?Q?OXp1xdY1bWqkHfLCKW7hQAkm11USPPi8KByx9/HPLv8hQWxfFMXZmRUFDPY6?=
 =?us-ascii?Q?6M7nFSuwE3Oot/YwImlH2ApiyPAp4smdKqUl+nNeT6zwfVhoiCwFckoOH1ac?=
 =?us-ascii?Q?uROcSQ9aUQlnX2GkwWCSZsbNaZa2eYsfI2hrm8Tpx4g99d3TBPkYUf3CzrIk?=
 =?us-ascii?Q?qnJKg8wKMWWZeWy/u0yzTTvoND3LU9d0ElxKdP6eU/3bo0r422e69gQj770w?=
 =?us-ascii?Q?c3YvTfHJRUvV+Yquql1CH+Fs7aDnjISLsE5M8knUXQEumGdI6ts6LfbseNPs?=
 =?us-ascii?Q?e5+X6WZgdsXDfGoCGYOfQGO521zIhJ8IuzhNR1wal6kThKNOB1Lnz0Zl2PPy?=
 =?us-ascii?Q?mrCkDBF3RubiaUYN+JYnEn4Mi3Wo4/mznQaSza6iKrcr640fpiYpvC9Uia2K?=
 =?us-ascii?Q?UFC4lxVkP3hE2ZCwMp4lYo0HONpJ09uYAqwfrxYInEqH3319sykEVVC5/9yh?=
 =?us-ascii?Q?b8UCPHpaza0/Wdxiq1tFVVbOc4GdnTuIcKpIfwQ744LE4ZqJiZ9lXxlqYTcI?=
 =?us-ascii?Q?f6EMjvIGzF3EVAWm/FOpVrRGB54wr7NAU/iLaAyKD4EzImcCXjN8UzusTwiX?=
 =?us-ascii?Q?OT/idETZ0uzCVWYXUCpaPr4bluYoO+BVxLJbtgiFZV6ts6wEOcxWSZu5Pgmm?=
 =?us-ascii?Q?dGkf0TANQkpxVpdcv0t9VYmpnSFMh5hQ58aNG6IUmjwjzJiSz66eTsDI8kup?=
 =?us-ascii?Q?W98EdWU89RjxDsmbkn1EhKeutMAmnonITWXTKcmAaNmYls5FJJSJkuywafxN?=
 =?us-ascii?Q?mu8HiNCSEoZD/DkUHDCYIT12NM7qLDMm+fmNztY6KFqpRF7qd2ACRqmPA2xw?=
 =?us-ascii?Q?tqlEE+WMPklb9iQ/WwNZDpyplnGWpoaibYQ6R0jaNkn0o0WVSl5znvg4GJmF?=
 =?us-ascii?Q?Y+JV+cZkf/8kgm+DMiq1LSPxisxzlA840CqXdzmtKIq+E5Zw5KQSKGbME7oE?=
 =?us-ascii?Q?7EZ44Vk0t6dY5FV+tAYvW3XzFHFR1yWsGlYZdx2YMJmiQSAXzKwtrVI70FF9?=
 =?us-ascii?Q?fFYMuIxAieimNFwNQ88Zz3aWx8DNSBNTnoPzSgUINhZiyT2ijcz8k+uKMuau?=
 =?us-ascii?Q?VWjKqviWPzcn+WZ4hj1dCfXfQBNe4nvQCUv6HGBxmPqjgsqfDgEg6TqPvVGp?=
 =?us-ascii?Q?YiqygZZbjXS9RYSgLUxcPQoZ9jDISit5JcUGFWIB8xHAIgKeteJwvbAQnh4m?=
 =?us-ascii?Q?UZ6JUv6Q9rQIxwLSAsebietGLeyqLDgcuULj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:25:15.5560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78aad83-e9ef-4a34-8311-08ddf1582c1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
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

SDMA 4.4.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 36b1ca73c2ed3..b95afb4afd032 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2298,11 +2298,11 @@ static void sdma_v4_4_2_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v4_4_2_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v4_4_2_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v4_4_2_emit_fill_buffer,
 };
-- 
2.51.0

