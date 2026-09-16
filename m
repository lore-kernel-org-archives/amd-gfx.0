Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5C8C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074F710E89C;
	Wed, 16 Sep 2026 17:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5lJsrKlg";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D76610E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFw86qNVDGPZsvqt+hgCEKHYUpUwEzVal+Ra+DmKs6+pSw25ZQx5D5FUyrGu3Brdy2oVYm6c0DtiWhE1TDQE24zjW+XVYWmeWvMcjNmZoYf/PksW6Mq/CXEuOw/Tx9ema6vgnfPUF7Cgms/j1v2IQ06CG8y08cpVIZabfHxZfV9MukHWyXVDN+GxZVuKTeleBjhZiyHxL+CFiMiVA1SpLlb7wuVIdDBpqfCuj7/eGb/EYGG2vbyaVi+dV9Y9JV/oGvwQzRiaQnIhONjaVzoiKNUUzyqbMWe+IAOibEDD5yOBrfFxjFOiGVJbx8mNgNZGfwa79c5hsNz+VsqoVNXl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMmZV2u7u/NK8WiJ0wCNZ/rLq/nsF4mbuVsUwgUUlBg=;
 b=dSLUKq/zHOGNzNRzgksNvF5OVp+sH73ZtFzfky+hiLsXzNphrogcXQQMYtXuOIcPxg4PtQWyExgVzp9H2DRyeucoYeR/XIakbM9FlPLeoEmVff71XlNEdLz1XXDzA1rjOWChmNqhkQBsbhvdTFO9ivEawvbJDscBDXgyeV/o8jOyzWxC4sOzjN9xN6fJdtHkm76It9ny2ECGDOeLlHVluO3C8K/QlwY1yOqmNik5Mr+POgdTrZZ62v+FYFTZAHysWbikKYep6XsVrjkpiuS3lTXLFsbdYwotfJlKxO+3/bRWSCW7iCVptVkWLJEX/RSa2nIC/8bLT3l1fd/b50s7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMmZV2u7u/NK8WiJ0wCNZ/rLq/nsF4mbuVsUwgUUlBg=;
 b=5lJsrKlg6yn478ao2ZJG8HsuFC8zFcIc/HgBDmJm0SxfdHbQXwgY/6OGfgNZdyxVji2aTo0jl6nI52MeX4AhoHoJnoygoirCtlLNGmUAB39fRM5/96JYbhillbCNJLSNfn2/7HDz4KpXlXl6GwGfuaigBRnzitrsJPzCBz8Aqoo=
Received: from CH0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:610:e5::27)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 16 Sep
 2026 17:52:34 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::62) by CH0PR03CA0262.outlook.office365.com
 (2603:10b6:610:e5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:34 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:20 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 11/64] drm/amd/display: Select KUnit helpers
Date: Wed, 16 Sep 2026 13:51:26 -0400
Message-ID: <20260916175301.368306-12-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dfde82-87f3-480b-b067-08df141b4999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: kmZBcY6gparYYmSIke8zcsmjW1u5rOCoWMYaKZhIHLDv5dsd+CUVwd7iwINLEr1+Q++mN4yzfb1nMLD/M1Tu3tVhNudvcS5IOBagtiYyhNd66h9hXloA1ifr9LM8FGh4kZS/G9TY2CRmf/QzmKzbqR3GbciR5yjOd+PDQKUwhbRzF+cvW1DMv7E3FMd3052eqsYo/BZKeyHcgGpi/wefs16yvDWTVz4lI4gH4+SOFtr+Soq4xtFhzDpxuWuumKghSsE2E2rrj53E4eaUa448nSLvv38tE+XI6CQgFKLPSCmjD7U1NKkLZJQH6N2cLTPFgAcLzfZ4apho4pgS8aVeHOW/uFzGqeBPUhWpLirgN6Q5D9dNXe4KUNtMzipzqTFDlYG0t9PJ2v6dB9Z5aPLaSOHxwwJsVJHJ35XWcDa2pmKRe8QFuIDdroo1wDFI9pqnXcH8c074Bu5ME4VKdnjsWGfPUgyyl8vAGIMXFLRD1p0w3VKkt2Ca/sGQ7m92dt0+Tfv4DTGsZ5oUXKhRecydMvS9/MKGdKr40rRBdekYt431udxO2HN29qxJd+4bYA5bjV1t/JOyjt+At4gu3YCqhLfZmHYhAXqXX0pN/XmpFzEIw7rT/OyWM9LaRhlrXn1eoukG7Lqxm17yKF7x/i282vdaZHOIpnzIrcBm6Luzdr36gDP94gvJ+vv+FlbV5iF3WjpqrcaSqsvxqtacy4jhWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /eylfyeY6JF896lUpfM0l/sjdwckOU0pqlTvb0GOBHTI4hgucK73mCvi4L+5oXUB2jOnZNG3sJ5/DIkQkL5WJcY8MN5iPv6objg4TiA70rT/wkPUP4CNYJoIQywuA+Cdt8cNwcsEzNKIZhdWKf8bt817mV6hIsH0PiIovI/BattkJHnanEHdhhYXMKRZtsTlwx8/X4tEP42biQdTPXHJ3GZYlIjfxfMf3XtdQ/pXvtz/FmsoR5rf99wh0GOFRdbeCyEsUGJ2pGeJaJWjEgq4Rewn2I39cno3gLX1ugDH+G0Lzj2HAFRtz08Qtmj/4wTo4Ra2m3QcfO3RHyIA1tJGo2eP9OCOXuXi/kNa8CFEgzBsWkJQpTHB+poX7NfDnn+SMhyyqS8O+g0OETV/6h4ZCZOyvHYht8NpR9m6ozPVnzfNPhmNqUWcTWpqAniZqrvK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:34.1092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dfde82-87f3-480b-b067-08df141b4999
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
DRM_KUNIT_TEST_HELPERS has no prompt, so it can only be turned on by a
select.  DRM_AMD_DC_KUNIT_TEST merely depended on it, which forced the
amdgpu_dm KUnit config to enable CONFIG_DRM_KUNIT_TEST as well and drag
in the entire core DRM test suite.

[HOW]
Select DRM_KUNIT_TEST_HELPERS from DRM_AMD_DC_KUNIT_TEST, matching what
DRM_KUNIT_TEST and DRM_TTM_KUNIT_TEST already do, and drop
CONFIG_DRM_KUNIT_TEST from the amdgpu_dm kunitconfig.  The amdgpu_dm
tests now build standalone and a run executes only the amdgpu_dm suites.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig                      | 3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 617bc1932524..a319680c329b 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -67,7 +67,8 @@ config DRM_AMD_SECURE_DISPLAY
 
 config DRM_AMD_DC_KUNIT_TEST
 	tristate "KUnit tests for the AMD DC display driver" if !KUNIT_ALL_TESTS
-	depends on DRM_AMD_DC && KUNIT && DEBUG_FS && DRM_KUNIT_TEST_HELPERS
+	depends on DRM_AMD_DC && KUNIT && DEBUG_FS
+	select DRM_KUNIT_TEST_HELPERS
 	default KUNIT_ALL_TESTS
 	help
 	  This option enables KUnit tests for the AMD Display Core driver.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
index c7c8527dbb10..0c26c510f7a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
@@ -6,7 +6,6 @@ CONFIG_DRM_AMD_DC=y
 CONFIG_DEBUG_FS=y
 CONFIG_DRM_AMD_DC_KUNIT_TEST=y
 CONFIG_FW_LOADER=y
-CONFIG_DRM_KUNIT_TEST=y
 CONFIG_DRM_KUNIT_TEST_HELPERS=y
 CONFIG_DRM_KMS_HELPER=y
 CONFIG_DRM_TTM=y
-- 
2.55.0

