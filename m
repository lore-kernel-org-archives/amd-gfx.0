Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66EDC369D1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 07:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B8710E891;
	Fri, 25 Apr 2025 07:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4O8OcoEW";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61BA10E891
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 07:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pL1gU/93Q0X5IMJsrlkM9eniXCMoXXkJYS/bHURRe760IWTcjBf3slIZG9yQaE2bvaa2nzNB7Ny+FXaZNk6Mz1sKOsJDpwAfwnHEggbEi/rCnFDI/NO3i358ongkY7dydGTRGzrM8slsgwGLZfHAsqU+HOsfGjWm9eMnjNlZuISh/fgXEWHrbZYn4CfHwxUvmAPMMx5daBZnWaGtQJUDkuSL8aN6N0zBBDBOPsrw7VX+jjk4jIFytJzcnK58W41PAzShrJi22G/fdJWg1odtUkFS+2mN4vlzCqEaiom31mHmx7JCofOwFcacXNmVwuljnUrBNdrDDN6VoUjov/wl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8jf38V0gJZGA4MSOXRRE+Fw4kT2yQJMLAPh5Bx9mqg=;
 b=g/8QHlqi7OgjCQYvX9NdZaCZgANM/vpVMVhEH3r+I0rWkEtCcZ/fDI7aflLcPIYCLSCuO7f8NONI1Frbx4hPIMmS8HamuPgYJeckAUG+ZqxurDllLh+PeFfF9VuXeA4p8UyuXrFMCLGewPkPm3958XFcXbTPrrZ1ijYgu5B65ZvuX/ERCH1bBoxCeBu1pst685nCjtHJeUoh0h3sfmHC/t3Jd1svks+qCTzWnI8HeZwYbua0s3gZv0gPKaqLa2o2/UelR9y2XKZaabQehHKPAQkt3xNH9QHp6agDA+TfiJUTXe5p4Kvbevs1taMwtbaOlMDN51ofKiSqkgK0pQNc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8jf38V0gJZGA4MSOXRRE+Fw4kT2yQJMLAPh5Bx9mqg=;
 b=4O8OcoEWXDYdO96gNPmlNy8hkm9PnI18eUVlY83/cBjdsE1noWp7nIJ+/sB4FI7oGPebkgsWnnRy13gjPiOr6aADzlKLTMssovjkEtRJK0Q369EnFm7GgftFMck9Fh8wpxIh1BbxjaMh826VKdOOiU1VZyN+ZZQ1Ph+XJynb5z4=
Received: from SJ0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:a03:331::31)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 07:07:42 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::4b) by SJ0PR03CA0086.outlook.office365.com
 (2603:10b6:a03:331::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 07:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 07:07:42 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 02:07:39 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
Date: Fri, 25 Apr 2025 15:07:28 +0800
Message-ID: <20250425070730.4033803-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af9eff6-e0ae-45ea-78f3-08dd83c7df4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ghUUVJiyVtBwJFuC7DZ3StYXsdQC+5WVAziM18UWsnu+rEl9tlH/jV5getx+?=
 =?us-ascii?Q?Vd+SB7K08+N5LriqGbs3i9YxiTOHAdKZk0Cj9EhAjWqQvgmbw5Ott68lyA9Y?=
 =?us-ascii?Q?AT0+Iq0ufkQbcAl9baWhept0dj+jS/8L3HVDpCc7HNuao4wwHvyM8EN6e2fh?=
 =?us-ascii?Q?25OsuSYQbmWsSH21e2LMBQWXEjY31d3WOlzH3slVqQQSIaJ/Lbk81bhPzA5g?=
 =?us-ascii?Q?fmyzNSoy/4JHLTF+K7BRkaMB7ZOdfJ7SSQKQijKyQZ+POFgSlDYCnKdRyPzO?=
 =?us-ascii?Q?rz6Jad9CdIV71CBedPIZwVpiBHWnS+jjCvRGGzSRVirFzDUYUL4o9WgQNxeL?=
 =?us-ascii?Q?DDagY4cCDPptduraUBY/OZuMhaM5PKir21C6dfYfzlOiQmerrGIQpO52G/07?=
 =?us-ascii?Q?4waZBQ8OGM+rdDp7Dk95NUo6MkSue7aZfRvHlyiI5NXn7uZojdB5hEQEtHOp?=
 =?us-ascii?Q?FmupbOuAdqDaxirLo4fQgzfBkPp5EvNPWS+TONHJLDzNzPQCmuH1LTVwrFb8?=
 =?us-ascii?Q?BvCupGoCFk20fp3tZ8y5L6LalMhp5JxUFOzj3F9XZfGKeKxZKMHKC7vG6DrX?=
 =?us-ascii?Q?pedHuGk7RPSE4emzDJGXbc1FutmTmuJCsTGT6kasv92QHylHxW98ZSq7/55q?=
 =?us-ascii?Q?QXWoafapmjzuiLfkMNFAs7Mhy6bRvyDaW6bOmIjYLymwsn6simNmF3CBKyec?=
 =?us-ascii?Q?0R1sseEVrP8UZqHTPymH5xYgo+uYQZdWqKAJN79OUdBmlXYqKhV6LUuxO12+?=
 =?us-ascii?Q?e9MzhOf3q1tvbmaPhRex2uPC8eNBuS1/36U0O3VM5HGHkuB1oiYLyDNET0in?=
 =?us-ascii?Q?pvYQtjbiKULom6mhLIA312T7kXDOUDicDg+LRidubxg/lm5DklkXpp/QBcI+?=
 =?us-ascii?Q?acAPMvQCyezBNjmF9MI7gjJuFwErtdFGA3RL1i9E47ysh+S2KJR0/RLNtI6t?=
 =?us-ascii?Q?ciTuBceQTY+7hWXhUR6j7y/YpUhVkiRPbBgaEowekig90KUIyPq4JeRFstjv?=
 =?us-ascii?Q?NupFZJQUYGEeP/As7K/ZzExUByjkJYV2cQ4QmhDWXFASHrua2it3AS1oW1wR?=
 =?us-ascii?Q?2fN9CB7TeOc3eCBdphCp3yBpgq78opkZEENNXvXqgco9q9+Lfp631KcVzVX6?=
 =?us-ascii?Q?SXIteZdEq4bHfxAXcevihilVlZpF/s5hN6u6pazqjSfMBAmFLdImyTtoacpe?=
 =?us-ascii?Q?v5AZgMY+GBS3v9rnIXv2wjM9zFeC4eDN7VJBtGB79wqOfgZv5YIUkbOVyvSB?=
 =?us-ascii?Q?EqXLMSIDqobyhJ/0NXnikPsQuh8SJVO9FZbf9QTY0/qlD3Ojj0hwGRjA/xL+?=
 =?us-ascii?Q?borube9BVZzA/ojylgrJx/r4QswhAaWDBeoUY1r7+PBU2LRY6jYoe1j6/hR7?=
 =?us-ascii?Q?4By8T0TQyFVUBsXUkB3jHUwtdIC/eGPDjnIq+H0TEHNPtSMJQU8ZYotRzCvR?=
 =?us-ascii?Q?75Tk9ycTnRqspExLeKbM8ySRb999xkW6RLjqZRvLxLAZealah6XzCIyt5Gan?=
 =?us-ascii?Q?EhsqY5ddk2PqXH5S35PEmSqDOdaHonhYKiCc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 07:07:42.3330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af9eff6-e0ae-45ea-78f3-08dd83c7df4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183
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

The driver doesn't want to sync on the DMA_RESV_USAGE_BOOKKEEP
usage fences, so here only return and sync the dependent read
fences.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 5576ed0b508f..4e1d30ecb6cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -249,9 +249,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 
 	if (resv == NULL)
 		return -EINVAL;
-
-	/* TODO: Use DMA_RESV_USAGE_READ here */
-	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, f) {
+	/*Only return and sync the fences of usage <= DMA_RESV_USAGE_READ.*/
+	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
 		dma_fence_chain_for_each(f, f) {
 			struct dma_fence *tmp = dma_fence_chain_contained(f);
 
-- 
2.34.1

