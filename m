Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706D1C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 15:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050FC10E700;
	Thu, 17 Sep 2026 15:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="INZK4cAf";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0569710E6F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 15:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2uhEicoVYTxN99fmPEnENMVW2ZZhnzyq19I8pgfjd/GEOVJwlUOjhGY1f4rbjLm7Ag66zkzD1gzCsoP2m+KzT1Cw3sqmDjn+ycoomSGX3Ye0A2HlAAxqIrnHhNhEfKMWF6JJE/ZLdZ4NED0siHuBhc7H3cHDSU+XBZR08Ji8NEaYUx1mBQ0LMVD45e6QXGgj2qTX/LR0Iskm6Xv6H0D9EumLq3QlPQDWE9gVeOgVJwaHuC5y3F+VU8loicFg8DPPR2KVAnvYSp5K6jDTI0j69bv91NbMh6y5J9G3aWL3sve0F35CHu9375DvCe2HqjfMqJOQggscYqnJMsOgK1p9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kQLPvNqDQt8DzbCf3rX2p67rqhvr+68xVvWq3kIKok=;
 b=yLb0Y1CN+c9fWhiWEg5oEVJFpMHgUyP73+bMH/ewrDs4sD5ABCu7mq9w3Vkm3+dOrD0Borz66Q2Bl2GKQ2E5q0UYwAZH6xqz5HcyMSTqE14WppftkGPum+UxJcgA30wMKl+fDWASQkYuDRXfSWNCFyPSVO0kWqDPbobIEBaHBux9+yioAsl8TSL0ZsfZOmWZcfoVxtRUzvZ2TgGHmlYjqKv6ftHET3MVFtyEJ4hlI1ciKukzmoZnXMSAEh4BVgDnTFFaMjmFzQfE5FA1ywec8RhjQNYjUAnzdCp25Me6AozoCpdKex8e9o4tkZsRa153kguUWQZqkEK3G/7D/p6S8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kQLPvNqDQt8DzbCf3rX2p67rqhvr+68xVvWq3kIKok=;
 b=INZK4cAfO2+skSm7z7g3cxN3xKdth+t4daV5wMg9FnQ/cLDr/WbNKWGF38mgzN4hn2HJtrGnJXfig2yPI95C0uPe8CdS6Q76O6I6qdmXxWopNm1TJxvPLHoUANcuAKskl7v8S3lbrLkM7DKs0OEzQpHkQh+jx60nqXuBgIvw4B8=
Received: from BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 15:34:13 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::7f) by BY3PR05CA0054.outlook.office365.com
 (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 15:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 15:34:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 10:34:10 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 10:34:09 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
Subject: [PATCH 2/3] Revert "drm/amdgpu: reserve eviction-fence slot at WPTR
 caller"
Date: Thu, 17 Sep 2026 11:32:05 -0400
Message-ID: <20260917153404.17610-3-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917153404.17610-1-vitaly.prosyak@amd.com>
References: <20260917153404.17610-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: ca10821d-c830-4069-72b9-08df14d1206d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9FlAkx8Sb/RooF27j89bcKo2hDKm4+vm9+ZsN2AiDMaE9jYLumgzJWZ4UiuMerdAD4k+dNkIGNl1ma/DhUbWLhowKX7vbNoi1xMKxYZ5NamsBJwEcNjrxRrv5KvXG5SojiREMoDCqdbm3f3k8pT6f+ZHdJL0fQ5Xp7jzFqeJsnToh3WDQMEhB1R8+ay/WmN1+f2nRevSVRu881CFbFJv+oEIfrPQuLzhyLne48F26owQlKz4PO3ns3FbaR+2K34K5+Z63jr2olBLk4J5wpj3B4vtnQ56F9gNJt2Y8/yLgM9nH4RVmgKzLvEyy6aOo5P8K3i6aeIeyoaxdNUQ5tixZK2xUY1yOP3qB4aS7VtTBphang61IgoaE0S1IuysjdIuk/lsYRezurtayL48n8UeDbbKz4ZJBA6Fm0rA15DC8TbVk15XFq/ui6nuocxGPd18Dm3XrWUkmD48QvS1polrEuN7hXwPe8v/nKGCfQPeFLLQRAi4g7ig7aMY8oTesWXUyeQRJC9WuxlxEDAGBO3vzj62POwjQwveDLhiTxEtEMS4WtWVfOR9TN7Yt8YJ8GSA9wkQpiuAEwueM53aHuXddMywQqTjTRKiGdJJWF0xj7nJ6ZexDAF+uqy51wZ7M0QLRUtiVYjFNs7VSRYVO6ut92MWCeAw/UJRG/E8wSOHkeE9E3FGMHZsz4ziRbod7/1YhDCpvabtGE3Ji6cFOPod1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eEk1DH86vo2Mf4ZgvDb9LVuqQownGpE8lQQOBcODTwJVgfx4DczHjLG20YZWHmFpwzf012bs5R+Zr40Adk+9CuK3Lkaf6EcGEQW9n/nJs5E8cgQSFbSNnc9vSgrHprbRHAAegNgL4+RWgYhXv/OnOunB/L50EpPguMcpD4g1FMA0PXMVnzLM0QW8zXj5zFY+V0M65FwiJI6+F7JwwbGOUfy+C4RQGmJmF5uksnpcQCR5Op5n3RyF+C6iOp/ujNQWINQQWJcrcl+L+TZPUqka/qvGzTnh3IFcoDRass6A3oY2W0Xp9O8eHyKwWc+33pUV40XzRBxtp4dnAdY5hMI5RXxwVfp8ZU1dg8lRqPz4HKvj8IL23we0I8+HOQcSwRksfgUu+LNO8N6vR1Xs6S/c+OZYwH28ekFwDPMHbpyEKwtb312mrYlZ9scAOrB4wzmQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:34:13.3290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca10821d-c830-4069-72b9-08df14d1206d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

The WPTR caller no longer needs to reserve an eviction-fence slot.
The reservation is now performed in amdgpu_evf_mgr_rearm() immediately before
the replacement BOOKKEEP fence is attached. That is the operation that can add
the fence after the BO reservation was unlocked, so the caller-side reservation
is unnecessary and should be removed.

This reverts commit 118037152820 ("drm/amdgpu: reserve eviction-fence slot at WPTR caller").

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: I6158879300c8dba05e8e56da5573b8ab46c1d2c0
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index fe49aa4dc5ff..68beccee9fc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -60,8 +60,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 		}
 
 		obj = wptr_mapping->bo_va->base.bo;
-		ret = drm_exec_prepare_obj(&exec, &obj->tbo.base,
-					   TTM_NUM_MOVE_FENCES + 1);
+		ret = drm_exec_lock_obj(&exec, &obj->tbo.base);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto fail_lock;
-- 
2.55.0

