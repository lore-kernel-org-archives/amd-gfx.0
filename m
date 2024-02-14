Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039F2C48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 21:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A406D10E42E;
	Wed, 14 Feb 2024 21:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbmlHWdQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4D810E42E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 21:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF85UzIXomnYO8Y5gUOO3ZzYMnO2BcaqJ+gWumTThCSVpX/6+cRC/bhWPSkP70u+OuyPJ9SxCEck/Be1NPRHeBxENlpL6JHWyhHEPmr77E16X8KikCbWMcOsEQJIC0RLQENiLNM9CtPSxyjiCQUKh0+nQXjLpCbyOkNMXpSHFw0i65iIHTH/mXQyNA5xXe3UAVmDsMr4ehPUGOotmqsVmnqAuQeH8dRvL/Z+GF/CXLBxphLQvlbaTXgpvET3ePsKipQmRmG5uJs0amtYbCwH6XnQ5QfvN7A6Xuryxy0IXY4cdV5XMkanBqJtUzu++wNzIbBhcm3dV4ePnEFWf95D/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rhGp+N9cIJEiy7/xWFLdERgVtNgjKo3WB2EQ9JCIsw=;
 b=mYPc7vhclMCKOI5g/U9v7zsxxOpdzgKE9co3OBlxZwJwZvx960CK1znwiT8thKRlrMD2iqW9mVmrcPgn1iMGiTXdbA1OHJ/dofgS/MbAzqujZ6Jbm9UvNEGDFn8yxH+yly9RGP4cvfC0od5UIO/GxjvGEVX5nNsD8+P+ZSdcFdb3XUqYioEnX72N7feD5QfKOob0reucF9A3c+2/vTdytQ+6d4B3HWvqPd4rQd0XjBIRBl9hHc5AOv6TuOHDHAbYRuQw1AOFKckbFl3QM8oDkqSOHrqbn+aEFJFP1FVo68csC3Kpfa06VMMtkvQQ1M94vS4MizvKgABKwTbDw528Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rhGp+N9cIJEiy7/xWFLdERgVtNgjKo3WB2EQ9JCIsw=;
 b=wbmlHWdQDROIJsB9XOBVbwB7pBClyo6fRfHk9GEVdJfrC7JJlNwoCLW3ZfDfwG7t4do87GhkdkwgftNtiJYuXhQgtQiRpRUCkd9Zc2aOfbh6aSoF1fkuFLVVVX3a+x97j3SfzwfcgGuszQ2/c1R9q23pZ2YTaN+zmrKhHuja5UU=
Received: from CY5P221CA0142.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::17)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.27; Wed, 14 Feb 2024 21:35:47 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::5) by CY5P221CA0142.outlook.office365.com
 (2603:10b6:930:6a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 21:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 21:35:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 15:35:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add sdma 6.1.1 firmware
Date: Wed, 14 Feb 2024 16:35:27 -0500
Message-ID: <20240214213528.2592338-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: de021511-565c-4dc5-ae98-08dc2da4e81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCHJxMBaWXME9asePEYnKHPaXDmAAT7H0xtUj5KbR7dpbV+8pV7VcwTBbT3KVe+Cm3VoFnkItHs6Md2tqBO6qEm2X1yjCSoZcFdYzloCQEqb6Rd+0Zexz5eT9MVjF4d3oap0ur65+5JVAOTDwO0YAIWQ/FcducqJQJbELYs6ZR+mCh+0twmhUhBNoyvqswhqBgrdF5CobUl1VDsZX6BZZ5g82XnK15EYsIWOyzI2omqJzyG8yiQJ/BspyixTZtKQXrxJ4oHIILYHB9B+SeOBzbmu0fIPlFUXBlg59O2tQEZ+HgdaXeb4eFpZoExHszvpTMdyyXcrPikjxYO2OI73LqK9y5BFSBMu5HOHpx5FYM9xu63ZlQCIWOzm8YWyHfy/Hgae4qBA9jD6nXSqW7ixfMSxLv8nB8LSS8K+am/0aCGY5k8ohtJTJ2hMfC0L44Mvb/kC5ms2cZl1JGOk+RNkAk8dl84ovI2NreG9w9imgeBdAI9Q+hxD0c2hLF3pO/fo23kTx3RvXsKjaUIwSNoh4BGnWevuPHv9I1VGuGHMgG6Z8Oq5vsl6arNM4lQZFQzQKZblVXf9awfDu5Ie+NfyETcFpU9kmbroH+wA3uEN2a79bSvnOlSxwfIgEefRW5k40M9V9gn/8997EzZAdI3xJEEe+bQPtk60CXLNACvTwt4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(36860700004)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(478600001)(41300700001)(6666004)(2906002)(8676002)(8936002)(4744005)(4326008)(5660300002)(7696005)(54906003)(316002)(70586007)(70206006)(6916009)(2616005)(336012)(16526019)(86362001)(426003)(356005)(81166007)(82740400003)(36756003)(1076003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:35:47.0950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de021511-565c-4dc5-ae98-08dc2da4e81f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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

This patch to add sdma 6.1.1 firmware declaration.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 7e4d5188cbfa..93cf98304a29 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -49,6 +49,7 @@ MODULE_FIRMWARE("amdgpu/sdma_6_0_1.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_2.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_0.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
-- 
2.42.0

