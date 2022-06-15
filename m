Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC108CCA473
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 16:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61EED1125A0;
	Wed, 15 Jun 2022 16:11:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D1A1125A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 16:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1AOoqXAO3gSoRsrgtNJRRZdCj0FV27RwLBeVkgVq6H4UHrw4GC18qQRJ/QHKOtK+sqC/4Xf9O8+7w4SH/r3+otSuS7xUySzWuR8ci+NHdGiObYrd2QsTTGBJlWOxSDpXQKpR2gYKuB1EhXotO2V8ptEF2w5yrOBVvl0FT/ue/PKGZHGAgvTiU1voZeEMF0GwR5bAf5o69/D0NbCiiENMwO8fia8rON4fG34cXraiXcgmI898klzStHxUph1RqIDin5zTWU/0jTniYngDqyWlg703IsRZwiStOplkDTTQy3ewnyVTyTR3ZpDIS5IcxrzpthI7t4rf5nikMq2AEwIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBrkLbJRR2/kBoyUsV8XHsLesClTGAeOCEIXl6Hnhfc=;
 b=mPmgO2muzI7XgdFpeapQwyRPoZ2hoBYlmp5tfaEyySmpw4MO+Ix8U75dFsf0d3p7AvCXwLaVvv+A1xroess2nlbQ0hthw3lc54ibEQMi2sWltD7SlQx/ZRt5jDjHNS3rRLcfZb36OjviyPD39Tbpffjb9CPxzlb0EFaXblJz9IFfYi+c6LsKlIdVhOc618f5oz3Fxcju9mv36oU+yss3R9USDrFWJ9pJOtWq2Q3oEEJXRovMFcQ23xYPEUm8kPghqUM70EKmBx8EUeQkiQ+w/qd38F3EFF0HFAhK86TE0y+YrKcAczujBoR3jHLKF9fqTKEplBI8Fli6V9nQfZ2rUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBrkLbJRR2/kBoyUsV8XHsLesClTGAeOCEIXl6Hnhfc=;
 b=uvamha4nxnxumVZ1fUIUa2gp7XH6gCXwhy/KjyQMF/hlm3+7UkOO5U8GVP0hQSpAHggVqkb+mRWEk80CtRU+PwgVunCaqrN8zyKT2ZLmISA3gkkgLobKJIBU/ceQZzUnjr4YiLh3crfpdEiRxP2+me6f/z+aIeyGJ/F4b9buVGc=
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.20; Wed, 15 Jun 2022 16:11:48 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::94) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14 via Frontend
 Transport; Wed, 15 Jun 2022 16:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 15 Jun 2022 16:11:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 11:11:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/radeon: fix incorrrect SPDX-License-Identifiers
Date: Wed, 15 Jun 2022 12:11:33 -0400
Message-ID: <20220615161133.3761804-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65933e02-a8c9-47d6-0316-08da4ee9bfec
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB607514C19513D9816203B3D1F7AD9@SJ1PR12MB6075.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTMCy2MLnOXCweewWis2s+OpEyFUbTySJNOUC1wN0dT8uXw95WhjeAZuCmbzeFZKRR+0Lyz8YqO9weJLbdgthtOis/id6SUh+YZv83vKACLBEYt1Ny59qxCGiuUhbxDPxvKEsdNmeyBYJuRvIwohfC6xzUM97CAMr+5bjiaQVWJvdT7i0dDZQ6lEtWku6491P/CE9kZKhEiMXY0DEIkNsYQ3FyabfmQ8ur8KoLD3An4VXbYvKFFkdPmSNh2LiJDGn2dyzamFr5sGNFfrlepN//X3fZBBP62CumHKyp6YN0UeY4+c3QCN8+Oxs88laYbBg9p/fYH9n4fiAEsDV2AHkku1vvr4POn9z+8eGvT2gAZiGkfh5zM30XYMbD+Xfqwy0l8B4XX8VW4kE96kUAVyUMAK80+Gsuf40XJzPytgijfBvb3ZwX5DXAPAjxa0gyeZPsDmFyB5sYExLoEe/jqk5SsvVcs4IcEnA8j1EpOw2nTzhwsPe28GX6R/pJWb0SyNRarHhfg4P9ZaViGTsPDU7+GBATm/sLi8evKZt8UeaOjcXWWOR7mtBJwEmnihpIr4iKqCRll/Jot1EZ+Q5aGFxUeA/O39HD6s+9u6pL7wsSGKSewt3dW/YdNJnjjbhJyjDVcEZPc3IkEzBoIPyip7bB+Ql+KQkbzJzlvDsTVtZOANMJFLcFAYdBy9pZCwLEk88R0/aZhuaSArddt8NgxmVKxVaEWV2yq8Alb044edDHE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(508600001)(70586007)(82310400005)(966005)(86362001)(316002)(70206006)(5660300002)(356005)(6916009)(26005)(2616005)(2906002)(4326008)(8676002)(36756003)(426003)(1076003)(47076005)(40460700003)(81166007)(83380400001)(6666004)(36860700001)(336012)(7696005)(16526019)(8936002)(186003)(49343001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 16:11:47.8264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65933e02-a8c9-47d6-0316-08da4ee9bfec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

radeon is MIT.  This were incorrectly changed in
commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to files with no license")
and
commit d198b34f3855 (".gitignore: add SPDX License Identifier")
and:
commit ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")

Fixes: d198b34f3855 (".gitignore: add SPDX License Identifier")
Fixes: ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")
Fixes: b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to files with no license")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2053
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/.gitignore | 2 +-
 drivers/gpu/drm/radeon/Kconfig    | 2 +-
 drivers/gpu/drm/radeon/Makefile   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/.gitignore b/drivers/gpu/drm/radeon/.gitignore
index 9c1a94153983..d8777383a64a 100644
--- a/drivers/gpu/drm/radeon/.gitignore
+++ b/drivers/gpu/drm/radeon/.gitignore
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: MIT
 mkregtable
 *_reg_safe.h
 
diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
index 6f60f4840cc5..52819e7f1fca 100644
--- a/drivers/gpu/drm/radeon/Kconfig
+++ b/drivers/gpu/drm/radeon/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: MIT
 config DRM_RADEON_USERPTR
 	bool "Always enable userptr support"
 	depends on DRM_RADEON
diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
index ea5380e24c3c..e3ab3aca1396 100644
--- a/drivers/gpu/drm/radeon/Makefile
+++ b/drivers/gpu/drm/radeon/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: MIT
 #
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
-- 
2.35.3

