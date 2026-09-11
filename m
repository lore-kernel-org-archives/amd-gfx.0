Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9167C88E50
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 12:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337BC10F592;
	Fri, 11 Sep 2026 12:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X4Qaw1R4";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EA910F592
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 12:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhjdulMaZLzpPBKXyRYH+ADi/MWLpgiYw9McsH3cK/GUgPkOtDd6WhS87l4QubIvtmdevyG1zt2PFYzuPGIytmFFqvsbDCr98yraMlq8Zu2hUI2NXqy+qCbNxtT25qvX8YH+EGK3d79QhWqGOEDkLl+YZu1Zw8AUaJ1kCgfFm2rLxd9mtN88GLKLIT0TJ8XXtU2W1BDOjb1aCcAEWV4QQdLwxZ9XOy4FWEIt8Yh6prfZUHQ1tvX46uky+0221sIH5oniQJx37kpajbIwY2bLhDmaHpP/tILiTbiovkwtfNZp/NhZScSQ+hJnB6AoZRz93u3hghZhWrgaVjevJHXP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j13oo/BVWUPoQVgP9y6uEGvzxMnbKS0e3mChHYZsYxw=;
 b=nT2Usdj5tJ6RLVWPUpnnUx8whgQXiaXQpz86JcgCO8k52likV0U/HD+4j542p7wBIwfDqgwZMGKTjJvF0nS8HmqVdGfG44nuLXAq3w1CbyJ9TP7/eXRi1ex5b6p5IvGHkjJJ8dXbM8xGWCVEUkGvu9KRdI5PNzbZ8AQntEset/s2cS5fGaU8Vt2P9gi4bFE5ikRZ9yinN9IC5YoSVe8akBHbd1iSEhk6p6gS5G8H+OXN4gE7IxOngHhhN194msaIZnkJBKyqwUuP5LndVU1bHOPzHYRDS4zVeiqHifQVrXR06sV7Cp/Y0/1wmaXR9SmkEuCIwA3EOuapkWdlulw9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j13oo/BVWUPoQVgP9y6uEGvzxMnbKS0e3mChHYZsYxw=;
 b=X4Qaw1R4Aq47Ng3yWpWQWQ9Y5sptpzZmL8yQ/UKtipags3TnihBZvy5sOSmEbKIZymrpYaGOrv8nTdkiSnVuQD+eIAH2GkmSRZh2TSQqyrL4w1LXGw5ifDDZ9Cy2bLAfIE+sTLuK245eAR3nUcdcU8ByT8vsJITw38JAmJTKASQ=
Received: from CH0PR03CA0224.namprd03.prod.outlook.com (2603:10b6:610:e7::19)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:31:41 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::7) by CH0PR03CA0224.outlook.office365.com
 (2603:10b6:610:e7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 12:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 12:31:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 11 Sep 2026 07:31:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix sizeof(void) warning in GPU memory KUnit
 test
Date: Fri, 11 Sep 2026 18:01:22 +0530
Message-ID: <20260911123122.420227-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cc010d-f3ec-4ec0-773d-08df1000a18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8xZvIVXuGb4kdVgOWPWSkjcBwZlfRi1/OvYaJEtPV1rgi70AsdK4fabhjytPxXp+y4azncRPilawr70nz5iSRGDd1//Cd3kpmu7eLahX7+rbp/bxDBUGNbiz6O8h8XTPyh1Ks8rmrQ8lCiFkhpEHlnaZBSHSPrtOhhW571gdL0af12WV6gvQkTpoHnTqZsb/hRAr2BQKnFWMk/RdAZ5DF4+bhO83rOgTrFsnInwEUxEtcYA7bDgZ+lGIT31JcidmzBzyFOqqCnIQ/a2dufHmWqhTg28xjFQraDmUB5KDNK4fFqcA1X5hASSl258tQadJrEF+1ytDvVlTHAQm5i7Nl06yzmN1Ze8CHhE0uwKOFdK//2IUgYYrB+sPQ2VVY7YGaBtbmyujYmw3sRUf7fg3E/biVepT2ZsuXGY7NoHHA+khWnT68ud77oT14/pr52EPMesFQ30bZzMfBbACYt6n/LvzpLqFNrKlQyBl67uGNoSqrCNp0t6OmXHzbOrEW6JwTHfG/NftUv/7Q53VxB5fBOsFcm6K5vX687SMEZTxMeS3BqOWk25AVwI0F/99a+oTg3VnwoVFAQConm6sEDpcivChuq1itn0eClabw9FqjFAnzJ6u9BoOf+TuDEpNwR+svwo5avEqVArdHi6rNDRbbaToBgCw7TGhHIJeUH+CtCx5QokqeJ/XLLTq5tzrZcWSnXDqTQSA0NEVDyWSJHXzxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T+ymkxnDiMa3nX//PwJf8Gk+YmwP5C2kO/nXAFIS4XLz1TPAzxTPlDrrxQcvtwaP9vRNJHlR2Fx23ERruxO9HO7SSLPxWwozWYzxj2aOfYXlcqWdbkUgVtodcz+XwraNBFYwZQusjYWCO7JtI4Z71fq3E+K+LjR7PItF6Y7TPIZSvVJzySEI/0/qJ4pz+RjpJ7biLy4GnRrYfIv5kjcUacgnFndyD8jCYhO4hKynNBD6YJ+4Xg8qFacSzvU+zTAUloHyVGEoh2B8SLDRPRKli3K3B78/ONguzys2VeUgTqTlODQfdtKvThAhDHNEQv1i6nnNGi7nsJV/Ei40oQOQMIkYHDd4QvY4V3N/a0R3zauQsGsJeJUOn0+uCRcg4YaKz1o7RuxvSGQuMNruBddG7AOAqpxJ15LKHgmlj2VAcNbZJw2toSD/LZT0baPaCTDa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:31:40.6242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cc010d-f3ec-4ec0-773d-08df1000a18f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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

dm_test_gpu_mem_init() declares cpu_ptr as void *, then passes
sizeof(*cpu_ptr) to kunit_kzalloc(). Dereferencing a void pointer gives
sizeof(void), which is meaningless and triggers a Smatch static checker
warning.

The pointer is only used as a fake CPU address sentinel in the mock
bo_create_kernel() hook; its allocation size is never stored or
inspected. Change the type to u8 * so that sizeof(*cpu_ptr) resolves to
1 and the warning is gone. The u8 * assigns to the void * field
  dm_test_bo_ops_ctx.cpu_ptr without a cast.

Fixes: 0b73216c7dea ("drm/amd/display: Test GPU memory allocation")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Ivan Lipski <ivan.lipski@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
index 4ff430e4b23b..4a9b0e65bbb3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
@@ -335,7 +335,7 @@ static const struct amdgpu_dm_services_kunit_ops dm_test_bo_ops = {
  */
 static int dm_test_gpu_mem_init(struct kunit *test)
 {
-	void *cpu_ptr;
+	u8 *cpu_ptr;
 
 	cpu_ptr = kunit_kzalloc(test, sizeof(*cpu_ptr), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, cpu_ptr);
-- 
2.34.1

