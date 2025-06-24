Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E490C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 09:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9D810E565;
	Tue, 24 Jun 2025 09:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KK390O9y";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B680810E565
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 09:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfKGhf8pxUW1wvr2Py3nnViBY7btVO0axAWQnPfAbPK+I8FF2uJQTKltmSb/0YpOT6704Dkt3BOaMqcTKiTtj4T0uwP9PJGGSWUqbw/0KipEtD2f16PqiIJRWiLW1VJQwwFYFdFUWrge/Iq/WBDlQ0WjcNmAtT23gIockXMF53hsLQOuiOfCM14S7kPhfDzxVKJdyCbtGltwavH6u3moU6Wxhho3K0m+IuirPKt57+/wZqpNeKGLoUrudki/RSr5mJ+VaD3Wnil3hLMgOYU+M8neU9QKMSg9digxZuHK6Fjz13OXsMsL1q2UBUKYBz8MrlCh+MFzHHqwUr8+UY8l2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubx4s8vE6Inw4ebQtQgHQXnpcGRzD6T/DagrwIWra+c=;
 b=pX0uMorcX1lHJjDwTQkOK1hHmndXvviZFAuUpQ5S8eJRz0hMd3rxPtOtFVE8zPhCu4QQhJLS9/y4yy2m4mfznGjd2WJcF6uP18z5WVV063BuaY7GiEm9176d4GaiZ6o2YDX+mUXAE0IV9IDLo02vqPGBMvZrYBrT1yFhkFQ44tM6GBiqGDwGdQBlWdRskL+gXb4VsSgLGTetrgujR7qaNK3dAqGvPDPX1l9g1NuIdS961BK9rl864f3r+ssKy/DM4F9h9o98NvnzWsS0BgNraqnrk4jr8odh/Qhlk2ebEAs9UbQr0ZBsdEcaDbvEZ1qv3EPktRfAnNV7Rcn4Inue6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubx4s8vE6Inw4ebQtQgHQXnpcGRzD6T/DagrwIWra+c=;
 b=KK390O9yrXGqYNSaGBi8UtQLMytsBEO3l4C5F8th/f8lWfjzGq5uNF+Mro0Brgn6xDfsVz7/hIhKuMJ9e23lqrJmh9pAFgTdTf8eHzTl7LgZQYyAbav3EnKUmoqWh8C6y7HvbzjEkw9h3Anq1D4Pmfeocy/2B5eIt/ba90eadWc=
Received: from MN0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:52f::35)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 09:18:29 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::40) by MN0PR03CA0021.outlook.office365.com
 (2603:10b6:208:52f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 09:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 09:18:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 04:18:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 04:18:27 -0500
Received: from lcaoubuntu-server.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 04:18:26 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <haijun.chang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lin.Cao <lincao12@amd.com>
Subject: [PATCH] drm/amdgpu: put ctx's ref count in
 amdgpu_ctx_mgr_entity_fini()
Date: Tue, 24 Jun 2025 17:18:23 +0800
Message-ID: <20250624091823.3963949-1-lincao12@amd.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 4274e1eb-e8b6-4c4f-33aa-08ddb3001520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PklHO5/ph3C9NN9BOl8IngoVR/78AZ2nvO9OQ8BEdvI5rfaToOPEI62ygTQM?=
 =?us-ascii?Q?Xnbs4tGCituvM9jCUryDRoXsSZlDl7BvoJLXgcSjoSvukqutMVAExJENXjSZ?=
 =?us-ascii?Q?1JoDH9y9S6AeWfRccWRsnqymq/8iQCceDrUHZkQzsictpBBF03oDvWcD6CmS?=
 =?us-ascii?Q?YSp47ENkVG0uv+xIeGoiB2K9Q+GZLN6hT7CGMxiczKLQ7LLRLt9x9l6OxCu4?=
 =?us-ascii?Q?rLXQIJA/2NTYHFOdkqMwzw+fcfnjOLnG2Cr7Ny8jUSf8lgb9TD2jAbMf1zZb?=
 =?us-ascii?Q?w6E2TSr/q/Abxuml2E+fCnfhtq6bMWSJybtRb6YmD3QGNs4B4/TvkUFSOpDQ?=
 =?us-ascii?Q?ySpfhe5cXKlwpLiTSR1j94OXpyOaQWkCqPyy0JQCIaCZHfL/Glk7uoc7cijS?=
 =?us-ascii?Q?Jkyi2NaPTD3b9X3EtsQi8rAf0JyXsatyMoorv37ZaGsrkAvNPxWAwpFYFlAd?=
 =?us-ascii?Q?xHIEZPR5h7cl39y9BOGlNq3RYCpxAF8il+Dn+fFZbKin9So3P1B15vXQGVmr?=
 =?us-ascii?Q?oMZFfl0UWA4vbbOX+8cf5lqVARe+ksJS8cx4CUDT0kiA5UPyC5sylSosfoN8?=
 =?us-ascii?Q?ZEAIg9CoiWWaFUC9oyCL31y0WsJd+PIQeMEub10BuoOIFMYWw3qnYjuIdqSg?=
 =?us-ascii?Q?Z4udFqnzUm1GdLikN8jlnWQ4NQ9jHdVUsij42aSa9NKHbjFkX17zwZzTqIgs?=
 =?us-ascii?Q?EkB3sM7Tg7pvdpwNnDcfSwbG799aTkOWXVyjyDHsZZyOfi+QKUR3bKytDrvX?=
 =?us-ascii?Q?k8n3yqyQQs0clYw6oOnugV6LtShg6x8UPu1fhDkdB/8qgmvKB1u9D5hcY9Jk?=
 =?us-ascii?Q?NlEBaBlRpgp6uw4ZDkRKFFTI7kTCU6cdGhAd0ik/nnpH0UX+lRzCrXauDk6P?=
 =?us-ascii?Q?JghHzBfefPpIc9LJqgB7KkNdp6zCAOGnVUz4Eb+MPWDCVG+KDcn1Dc3uWmlN?=
 =?us-ascii?Q?goq4Wzl+q8iRjdfWLAtvVPIU3lHVMNIKaBPdpEZuZaLeW/RP7EnduCJKXMz2?=
 =?us-ascii?Q?ZemEhexIN273brTsMiNoFmYQXw6IrH2YweCkPme5RTlo0wcml49vJz7OZXtj?=
 =?us-ascii?Q?gK8ZP4qCUbePUzRubFlRnxkGwO1h4LhFpXuWgPwKpjqpxQgWRl4SFULLqroy?=
 =?us-ascii?Q?MhLlvtlIY4iWEYdJuAx/qKcIWo1cYMMEk+VLzIgTNLPhd114muKU1ycXk6nt?=
 =?us-ascii?Q?SptJgMbEJqefVl7WzVIPsq3Fik8RnexvLdQHtNwdZHSF/2FfOrpnnPFg/hdA?=
 =?us-ascii?Q?xXrEqZjGKzzNsBEFhWFg5/TxsU7TZekD71T7npjCKBWHtjaLHpFIBfIIHw2v?=
 =?us-ascii?Q?lRrEjL4qLXQeFsnj3AQ6IB2ES6ieRITK9zXiQn7+aIoIkkNopDsKK6BnnRD1?=
 =?us-ascii?Q?RsBxoDqZ2nKbzuexG0cun7tq1rRw9MluBj0vjYVuZG9FpZbm3ySJKeo7cnzU?=
 =?us-ascii?Q?H9RguP8qUaK8Xne2936cP72d0Xd/VyhRUl3xUL8yLkzZNfBGx6YEiIMYd+0g?=
 =?us-ascii?Q?fM64p1OsVpZYGGsDmyEt718j2SKxG863RrRm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 09:18:29.1857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4274e1eb-e8b6-4c4f-33aa-08ddb3001520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919
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

patch "daf823f1d0cd drm/amdgpu: Remove duplicated "context still
alive" check" removed ctx put, which will cause amdgpu_ctx_fini()
cannot be called and then cause some finished fence that added by
amdgpu_ctx_add_fence() cannot be released and cause memleak.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 85567d0d9545..f5d5c45ddc0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -944,6 +944,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 				drm_sched_entity_fini(entity);
 			}
 		}
+		kref_put(&ctx->refcount, amdgpu_ctx_fini);
 	}
 }
 
-- 
2.46.1

