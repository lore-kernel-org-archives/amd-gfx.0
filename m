Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ECEC48BF4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A294A10E77A;
	Thu, 15 Feb 2024 20:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WRDXPSga";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A749A10E4A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihZdESiX8bTTHvqZAmuAMjQqeuvnT9AwZZRxG/blk/jplH6UUdlQUi201nDarMo6oVWOJCUBJALRYk8d+d3cJNZ8tY5FF/Tme3FsKg27cSNzQ7LY+GWdaz4utqQjvl8nZkXeMCozEXIOR/f/yGlRPin2v0ZPiaUnhUeqb4VrlSN+jaaWt2vpwzJkpLAeqgzPNZ2i9zkg9RYHZn9LbEOOQqqblJwgA0MXX8wVMdyTXilyeN//TpdWwYLzZi+Du9haul3RM3Gptz5Vn7ckW/k8sJswRoU3IUsBustUn7C9x64lBVdESF6fh3Q8GhF/voGXnCdxLXsJ2eur9v0f1qCrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJI96enynRza/eWXNRSQFKZXRAiHFPWKz5VhTCdjuSk=;
 b=ZRf8bXrSKLWqK++iLo8674WzYm88AX6/bPR2eOR4gGo97rlyvurk9b+jaoPjwm8gJdW631YrgCWjS5G/4OTifi3O36dXFrjN1z/gzbzzvAneIAmh9e5w9BdsY0457Z52tIkE8+nFDVtuRFp0yjSncnMlfpPyW/uVBHTQC1RL4FvU5+S8RQFkS0726V0+M1Qa0M5aj9MjKzro7Zjqb4y2P+1LbFJK8fXDVMg3jCI0sqObnJpdx3GuNXiOvB1JOHtjw+Ock+PwMyL+milkQOiwunXzi0J6aDLgeW1lTgp8xuF7v7qK3u+QwAff30nKTN9zlIKh1DLmP5O8waw8553etA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJI96enynRza/eWXNRSQFKZXRAiHFPWKz5VhTCdjuSk=;
 b=WRDXPSgaZeKjQ8wWg6U/0TNLHsbsHt1hWTwbeBtgr3WwnokFdtqCEt5cfFYmgXdvlwNzu5P0+qyDWZ/28SQku+bEther0sRmk5PFmzK6XG6BFXV99zVw32hc0U4NYOKanAlMVylFBF3zanN6BNWnCE5c7BbEJokCCxmPIYpcD+Q=
Received: from DS7PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:2a::25) by
 SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 20:40:19 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::6e) by DS7PR06CA0007.outlook.office365.com
 (2603:10b6:8:2a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27 via Frontend
 Transport; Thu, 15 Feb 2024 20:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:40:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:40:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: add firmware for GC 11.5.1
Date: Thu, 15 Feb 2024 15:39:48 -0500
Message-ID: <20240215203955.415314-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215203955.415314-1-alexander.deucher@amd.com>
References: <20240215203955.415314-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 028f0b5d-377c-4e32-8589-08dc2e6652f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22mgobSpHs5byu+O7X5jqeAjviT8P11aiF9HDCnkmDtr2HisetO3mFb0ZynksvVDB1bLCZ1VBKJlYKmf+3UbJRT24TEKODHfnlUjzK5r4wgk406qs9gaMq0BJefu2AH+G+Ataf4nqb3ErFq8rkIjtf81GtYFwz7uspMZw0/W9EO6TATEFuCfZzcKNal/rB8LvkxS0UhueMzhhGW7Xf/HTvABlTeOC+L2p4aEfr/KKzHRsQRdAZkJmSjii6V/OsljXGJcHsGKnXyLyr1RUulaC51HJdb5MPKzunCCer6YDRFIOSm2rlJYYCpty1t0S7r8vqJceLji5qQ2uUeMWqS5P7GjWonRFFHcCmDULUiyEOD9i0mwuOIJN1haj8l8OBbGuF1kgA2/mqq7jlV7koF0kefK/XrL+SNUVWpmD2Iwrji4egRvFd4mAN1KH3h/pH3pKLIdwVOzpNs+4+UkzhQ1p+Gp7b8KO4bDNQUIHnGwR5XSRQi39jwHwET+jO+wDNVwPL6mqJ4Xb6dvi21HxMtZ1wlXfIRTIsI2BqSg64JffwUq65k67B8dZCcHti+U6NuR1WvCbKeduAM+hR6xvWWfO1HxLNgTKCobVetqoypexQRFLjiyauRlSYQoNrlV90wyMAG/H0Ci1qTmH/Tfl1vKcLqkQxGqQyFnTMLmCpR+npU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(36860700004)(451199024)(46966006)(40470700004)(86362001)(5660300002)(8676002)(70206006)(4326008)(6916009)(16526019)(478600001)(7696005)(2906002)(356005)(82740400003)(336012)(81166007)(2616005)(1076003)(41300700001)(426003)(26005)(70586007)(8936002)(36756003)(316002)(6666004)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:40:19.1397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 028f0b5d-377c-4e32-8589-08dc2e6652f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch is to add firmware for GC 11.5.1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2fb1342d5bd9..83a03cd9d404 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -89,6 +89,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_1_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_1_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_1_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_1_rlc.bin");
 
 static const struct soc15_reg_golden golden_settings_gc_11_0[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
-- 
2.42.0

