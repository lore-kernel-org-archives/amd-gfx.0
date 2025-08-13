Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8EECA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 18:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A9410E799;
	Wed, 13 Aug 2025 18:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dbGUy+K6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D7410E799
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 18:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAygvm9y98enay+3zqqUGHVoOKUyiBeT92FuRDHsMGlMYuy9WxyabwTEqCetFm1RG88bm3FAY896Azu05aXDHbLPzXJktNtz5dv0qoic29Vcl/9hgmYTwIXDApvvGYdx00cx8fgo2troUvcuvtEGinIcX81aocxC2qlEw8Dpus7rkpd0GR9ym/67WCNgBw46NQ4Eq0xDDA2E1WKdmu9jErov7LJxCOFsJs0q7wmNQQKaTllQNHGch8/srGD5+kelrqfg1VRR/SuFE+RSTPQNm7PL2Ck+hVnkoOk8qkNiFkwthQlzQuK0eUvqQsQ5vPnGG0fEvuWgKYbWvz136pFE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAWSuKBcNc+PfIJgE5gIdh4AV0oTBzRX7BzSMDoIGl4=;
 b=LR/oD0Km2i7I/MsLQwE0em2pDuyB0ftPLmlsVd5hO9n/U9t9WhrpZ/hC3T29AbZ+57YYd6qUs8SWw6Alk7GCE9Pa3c5ymW/+/C5Gfp6xZwoEXEHJRpajAIbc1bwp7z9+tycAgdxdK19+jirOeOMkAwCTTAO+HhWK90rt5WG4FH3CyAdWGQKHJ8fLXgil9pesGaI3DzZ6Tk/7yHBbANy7tkyomo5ywbCzjwIsPy0Fpruz3FrdcrQiTmiRkE6RQif88C89Bar3dDnzguF2nQNHT+jYQwaI7qPRQ5GAy/+af8eC4W9RDEH0MnAiyy3spoESpeJ/JWFOajUMSNy468bnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAWSuKBcNc+PfIJgE5gIdh4AV0oTBzRX7BzSMDoIGl4=;
 b=dbGUy+K6gzSfYLzRVeWPfVRrnr+2vphm3E8ahsr+8hf1VApJ2/YfchC1opMF/5ePz+YRCHMwih/J14CXTSICW36ITFwRnxELuhqzyNjC4S45Iz4GLPSVBjF3KqUV9MLS6E1gd/ITW5UdjjM6x/Nav+PMNExHJTqewy+mJoaxL9c=
Received: from SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 18:50:11 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::66) by SJ0PR05CA0016.outlook.office365.com
 (2603:10b6:a03:33b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 18:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:50:10 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 13:50:07 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v14 1/4] drm/amdgpu: Allow more flags to be set on gem create.
Date: Wed, 13 Aug 2025 14:49:50 -0400
Message-ID: <20250813184953.3666821-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813184953.3666821-1-David.Francis@amd.com>
References: <20250813184953.3666821-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 478a49d6-9300-47a1-ea03-08ddda9a3b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ltO5AE2JOpp38IJMOHxfeRbM/FXVyY1TTZdbdrGVtXAmIv5F878c5AQeD1Rw?=
 =?us-ascii?Q?Ty76SZMKEEH9NRIbfo0ITQMhPnqVcI6d9b3B5Lo6fpcuC2ZiSYB+rEqJddSJ?=
 =?us-ascii?Q?frff+hMkkspwEr6wIx4WFtbrnUdT8ts0xh7MAU9hCY2pzs7TEBVv+OGHle+t?=
 =?us-ascii?Q?tWVvBQn4BqmLYF90u/vkP6jz/4lrmTqZP/1H4Pxhq8hbD7TLyirObfgBhGSe?=
 =?us-ascii?Q?9hfpjKrXMpBGlQIw2kxLD7Jc8XcteMoea7ATIHs3o/mQT6XNDvWemwaoef0v?=
 =?us-ascii?Q?PaMJLs5qh14JuiUVb+MtqmNDLaGmaG10lQKFy0yauplG8M0e00UyNA7zbB6R?=
 =?us-ascii?Q?X6HE0r61Zh1ZmAD04Ar6uPRz+hPcE4yxoJGPzJvXe8mnxoPw4Ex8IbeY9932?=
 =?us-ascii?Q?2hhP/b5UytUHfMsQ64ZRb5A/Gnh1wbvGMS2VcOU+MCsR+ZCZPUvIfDSB5Pb5?=
 =?us-ascii?Q?p4ZhSrmcRmt61R3hxa8HD5Id8GKADUYPBagIYW06MkbINFFmzoAt6T3tOFdA?=
 =?us-ascii?Q?ccmlOMYafWmsP6mxQMf8Lfc+db9uyYWnMrVzF0jVg0ueAlxsZXRYpx/n8z2c?=
 =?us-ascii?Q?7fAcduajz4H3fTuQWqc+0ZGE9ljWWi2oSnfmzS+cbJVsegZeVkTYo06OukvO?=
 =?us-ascii?Q?Cbm4H8I0ZZNvw7dt2JpEhAZ145dVYDUvcETH+OXNUKqoB09rU5lSMDqP22Nq?=
 =?us-ascii?Q?upHV12IKjObO9U21kKM9pFVP/NU0AqCf6m1nebyJWcY5uaCphODLcNq38kLC?=
 =?us-ascii?Q?gPiRBlOzYZKpyDKY6ae8DsfjO9WccQkFUWHzIDqLk02znLs7wugHmOvyVBK4?=
 =?us-ascii?Q?L9umKQRwNnW+zjOt+SbcFBosWGLzI2kyhBQ+t/arHt+iawtltFViM0gPJILB?=
 =?us-ascii?Q?tCYKKpV2yQF+TWYomrbLe3C1k6LtYRnKXx40MnL1+L5fUM9r3lNo5+XAOfBm?=
 =?us-ascii?Q?QEKcAi7Wje3ZUfZ7D+a7oQFcEu3XucIv33PF5+WE7DIfP9u+mWW5+NKqyY0+?=
 =?us-ascii?Q?tbNxl0S5fih7iCWR+8RLb5G2SyJg0jftk1a/dxWbiuXNeFsfboEZY75oJuBU?=
 =?us-ascii?Q?laDYRaUZU7YQjZ4neExwUVcxsQXZuAagmXZ0vJ6J+gzIyDLOWQRd9EYXMk4Z?=
 =?us-ascii?Q?cpEmHsL4m8G8e7dL2xAHlhKaDdq1XJt+B2gYlMjDJEVyQIUsj33S698PyEWi?=
 =?us-ascii?Q?CpFF9XY5QI51MPyBJ07b+RbGSi7uNyzC5NDmHE7U8NqIpz0kgZwfQ+3TLgxb?=
 =?us-ascii?Q?Nm7AbEeorjJiY1ZgqrswYwiLlUoV62QcCWPXabgdMLdTfKspyTXEFvP1fZJj?=
 =?us-ascii?Q?lN+R0VjNBJWlvUuQWwacmly4GItw6AkttmNOmZ2PSsGGFWcj0znEWl1m9LSU?=
 =?us-ascii?Q?jJMWuII9UiprheBb0oVcwrok8ByhvxCgTnHopNVpCYyAnR1/wnak9xMTyhbP?=
 =?us-ascii?Q?wkP09LfwSc7qYBcK/CNjEkdzv9ItBdgummibzURGgwtmLE69cO6ABz3bB6AJ?=
 =?us-ascii?Q?V/K2Wy+SHK6TJkj2Te4Ei6y5GrQqU/+vTNPM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:50:10.8276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478a49d6-9300-47a1-ea03-08ddda9a3b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
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

AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE is a flag that
specifies that gem memory contains sensitive information and
should be cleared to prevent snooping.

The COHERENT and UNCACHED gem create flags enable memory
features related to sharing memory across devices.

These should be settable in GEM_CREATE_IOCTL but weren't.

Make a new define AMDGPU_GEM_CREATE_SETTABLE_MASK to
track which gem flags can be used with gem create, and add
these flags to it.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 +---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3f65977eeee..aefae3a9e6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -442,15 +442,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	int r;
 
 	/* reject invalid gem flags */
-	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
-		      AMDGPU_GEM_CREATE_CPU_GTT_USWC |
-		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
-		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
-		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
-		      AMDGPU_GEM_CREATE_ENCRYPTED |
-		      AMDGPU_GEM_CREATE_GFX12_DCC |
-		      AMDGPU_GEM_CREATE_DISCARDABLE))
+	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
 		return -EINVAL;
 
 	/* reject invalid gem domains */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b51e8f95ee86..b3047d73fe07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -71,4 +71,18 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
 
+#define AMDGPU_GEM_CREATE_SETTABLE_MASK	(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED | \
+	AMDGPU_GEM_CREATE_NO_CPU_ACCESS | \
+	AMDGPU_GEM_CREATE_CPU_GTT_USWC | \
+	AMDGPU_GEM_CREATE_VRAM_CLEARED | \
+	AMDGPU_GEM_CREATE_VM_ALWAYS_VALID | \
+	AMDGPU_GEM_CREATE_EXPLICIT_SYNC | \
+	AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE | \
+	AMDGPU_GEM_CREATE_ENCRYPTED | \
+	AMDGPU_GEM_CREATE_GFX12_DCC | \
+	AMDGPU_GEM_CREATE_DISCARDABLE | \
+	AMDGPU_GEM_CREATE_COHERENT | \
+	AMDGPU_GEM_CREATE_UNCACHED | \
+	AMDGPU_GEM_CREATE_EXT_COHERENT)
+
 #endif
-- 
2.34.1

