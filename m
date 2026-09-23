Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB480C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 17:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B23010E098;
	Wed, 23 Sep 2026 17:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jXjSJzXz";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012033.outbound.protection.outlook.com
 [40.107.200.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5A710E098
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 17:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYCOIfQO6lxBrCJtznbviwvfOo9W2h5H3nVGsNhZM07v+jaZEbVJ9IQFrve5lt+rjWm+NhZOM9qTQimdlFzqvoNNbDtVSSKidoHhEI7qI3Wg89dF1hpWtkcngd9zmHm/lqhlqW87M4tKJWrzuvKQU8s0Rn+t6O5kvRsvhA9Mvm+IcI+mw5w+1LsruprTfgdgfXl/CY1tg+zec5IvrpOd2S/vaM6kae2ONBgi1Hk/W0jACDArABxwvTo+xiNlz4C1BbGq6e89pgnwtlQ9XARK665M/vN5HVFAxOyOEfVVg9hVPT3kSQzM9SMYZUFpmWbt+g95BydUZtk2BjqcB6BUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW9BeSU6UsTnEf9cqpqdHvMDTRLmEozP6jnFOHc8ccI=;
 b=iTpVpLwTfs7H2YlAQJeC7c74h+umDj8QaLhNIbOK5B5dSgces0NdzKOL8WVj/3dxVG0X2+swU8dLvfJPDfxZChi0KM25xouKih2bMg86c8QKTI4gn3R2nZ7iKe5fsehCEuDzeUeST3yyNi01/6SgqIuzV3hv+h8viVJqvimCL5Ce4mXnHQimEqf3GdT/CyHCkfpmbwcF/mljuvPalsfhKUU02SJaEa1J5RXGTjFXO799+SY8xdvggJp6NDWJy7KgFQZJqC7kcf8Jj/+8epdyfI5pccu8epFBYncMx9z6mgnRaEwMv/6HoYhHDYgqELrOzZw+CwCTFlVKtTEmdaaf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW9BeSU6UsTnEf9cqpqdHvMDTRLmEozP6jnFOHc8ccI=;
 b=jXjSJzXzgM8HXc4Wctag6LIiSICW54wlCZgA8Ti9GoRXoMmbtQvt6Me4iRHDiVAxjqJ4knCuIfGOoOrsx51M6QoIaEZFKnXVA/8H7md9pWMDN4gQBvXlhfXlOYouXBNKA9fQS3tVWTWM94SpxVgosel0MtgaG5EMfhfLP61Orm4=
Received: from PH7P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::24)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 17:32:58 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::46) by PH7P223CA0014.outlook.office365.com
 (2603:10b6:510:338::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 17:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:32:45 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:32:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <harry.wentland@amd.com>
CC: Alex Hung <alex.hung@amd.com>
Subject: [PATCH] drm/amd/display: Relax DML frame limit with UBSAN
Date: Wed, 23 Sep 2026 11:31:18 -0600
Message-ID: <20260923173118.383887-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc67e46-f3f1-4413-9eb5-08df1998ae59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|11063799006|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: Z6wA4pXxZ9445BPegEeTMiYO9mxhbuklJrxSQE+Xxa28lGTH0UJVMBRKeskP0rH9ZSHflcEkuAi1GPykUe9NJnzKgLHcKdu/PcTLPeQ6bJZTV86DXqovBxvRO6pVCpusAShGDslOZ5l2U+JXDxokptRnaedzb2IloQeg049KrJ0MVU+5NGkze4WdWI8xysNqFHXT6+jT+CV2KVaRt4uOAMXwnSz3sff41oJVbYe+SAkhTM8yAplnj3GemgJnEW2BCEnO5VU4jQCKL1djRsMyA87d3uvejgegwqhX0dDZ3LjqSzHNYkh9BXbneiMPFFDq84/TRlR5rlQjx/d1/uldr80cDkVIAyBn8pEZifx3FDObh/vMnfGkeOEmYhKhflVob/JRn2gVSiuT64f3kvdpgjUB/3dMV8qR1x8VGzgKKQqM0m41nMzPRbx5U+UxVSaI0JBseSbuiWjn4uwfZQjJQEJitmXZprgxaFv4FMdX1pDPlWr7oEDy2OgfZ3/A1MiN4XBkFyeClEAv/k0YSk910xRC9+bNqaHxcefR1Vk+Mqv/Qe3lwZZxGelx5ddZ9ngriNtxm9vrH/sS1tGP40BP0MpNfoVNhy862uPQ76HzEcX/GXe9DpjoRffFQb3y6iB7xVF3RoEDMUJ9NNoum7qbc9LEiqvvNxOY95i3Uu+mdweLGfG9hhhVmoZ1wlIea8TXVAfYdSr+TpojNE/Ek6m98g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /iQc9/r0XOTdfwHgdcjBe5o72I2p3j9MBujSPjero4mj729zC9Rbn6L+1w+Qs56Hf3eIy9VCLUVx+pZDtXqp984AzA3w3ZvBH+7yqH07LsQlBcTb1Vks/d3njMGuLDDzSf7KMpX/Z7dxNiG1DE5KmMz4HLpF0292TkD6SpAh4jsu8DGFpBar+XiKnmsss4S7nft4p+bil2GHQBoP3BmCt5M8jo0Qh1n37OF2ZYlNXdKCiEnZl3hGNbcCTYDddDaxGe3v5zED8YZ2dW8mqO7AZhEu8xCBDVg18OS4irw8YCyAp5zg8JSmWy8h3LAwYPYaazAKR5Laj5wSLLRfJjuWIrtG+rIKobPy3lqSVcDgOyZGjq0NwOCA3Opd5h6nL9oyGulK8mk+wNcY26V+E7CkXjJBb16BarXiz1+gqPkUqAnVc/YpB0Ft5yWBOetzXWhu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:32:45.9681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc67e46-f3f1-4413-9eb5-08df1998ae59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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

[WHY]
UBSAN instrumentation adds checks and handler calls and increases
stack usage in the large DML calculation functions, similar to
KASAN and KCSAN. With UBSAN enabled these files exceed the default
-Wframe-larger-than limit and fail to build when -Werror is in effect.

Reproduced with LLVM (make LLVM=1, clang 19.1.1), CONFIG_UBSAN=y,
CONFIG_GCOV_PROFILE_ALL=y and CONFIG_DRM_AMDGPU_WERROR=y on x86_64.

[HOW]
Include CONFIG_UBSAN in the sanitizer check that selects the
higher per-file frame warning limit in the dml and dml2_0
Makefiles.

Suggested-by: Leo Li <sunpeng.li@amd.com>
Assisted-by: Copilot:Claude-Opus-5.5
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile    | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 10d4ace04d4f..096520bd27c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -29,7 +29,7 @@ dml_ccflags := $(CC_FLAGS_FPU)
 dml_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
         ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
             frame_warn_limit := 4096
         else
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 7ebe799e3b24..615cd0ca9450 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -28,7 +28,7 @@ dml2_ccflags := $(CC_FLAGS_FPU)
 dml2_rcflags := $(CC_FLAGS_NO_FPU)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
         ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
             frame_warn_limit := 4096
         else
-- 
2.43.0

