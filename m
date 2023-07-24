Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB746EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 19:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 886E710E34A;
	Mon, 24 Jul 2023 19:49:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FF510E348
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 19:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB09FuIuehYrk4SsSNmsnEAAEWHky7+27lXcWzmGJhmzw165qAR5U6Xoq65s5I27mX0sVxBc9YWn46nkxAJG5xEpqsEDpxiVxfgrT054o3IaRKf2HrhIz7Y7H8m2rjygx2gqD6Z6jtV4iVk0en8XvfObR1VX6v8STpBsgceeLlvPz4znjpLMmbNtxOsu5vT7H0KjyM/gcCRl4SQkmfUbHC3npNCtFNPJ9C85vIM2A07C1z6NwMG9K0dyPAhg0tQ4+wMUO1Fd4Orxu2ewFLSZWMtaV39NtXgp00w/L+eYSf8lZlXy1eK2OEIO7POfejS7zAkC4U9V7D9C+RjCp5zRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+feNc57hJUnwrAnEF9Qex+0nX/bLqAGNvUQ2UGA410=;
 b=T5bpjA/Gb8bCGz7A3jvI3+p3GwA4k/3IpXTvaT/gulGs/qrHoUmRo/k9hTYZcnnGB0pDbRJqVi34HKmBHth/5R4pBwBM2DB8UpGpmPCkhkMfog1BWP2L6/gpE9ED5k/NcxUhmJr+HMU2LAuNJkAdwhXSeyG70hHRThEJn9+UHMl6LcZSPO7oTebElHxyl9eKbz03TWJ4Pm+cFvRLVazZ12jB5ZselJJWmn5yIRqpuj2Em24GnpMf868nl2WVKfTd6jyb61KdUyGMSZA4sfI+j30oeApYaEUZf+nX4S9bdE52kB5YFczCCjO9AtxO6cIj++sOuiI4IuW7tsBbKuGcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+feNc57hJUnwrAnEF9Qex+0nX/bLqAGNvUQ2UGA410=;
 b=XHjH8YUxg1Uub6GmgXGgOAHoFfBzqOfmmSRub/rGXAjzD37RqmWDLz2DV5yYmMMd2Cm7ZNNLaznD44IhHhFntDX5Z8/EeLx0+KdEGo/IRMYALP8o38OOlEHwaEdA5YlLtI4sMWY7zfwl2hYe4tk9sqV+tuuoT4ivjik7qpvJBSc=
Received: from DM6PR06CA0058.namprd06.prod.outlook.com (2603:10b6:5:54::35) by
 SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Mon, 24 Jul 2023 19:49:48 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::5a) by DM6PR06CA0058.outlook.office365.com
 (2603:10b6:5:54::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 19:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:49:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 14:49:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/sdma6: initialize sdma 6.1.0
Date: Mon, 24 Jul 2023 15:49:29 -0400
Message-ID: <20230724194930.763966-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: b40e8aad-2557-4b22-b7d3-08db8c7f22f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qjo+ZDmuvP8e7vBV/TODf2MpqZt45n8UTwI62LKZSjM5eLZVWIX78S9r1f1eXkWDJRGO6lrxXBfxTQNjo8wNRa+yaKtt2Bbc2BgHoAeyo0QqjVMuGX+H/rzSyuD/NETL35Sqhe8SsyMXNE7rMAg2RuvnIafQrFGnZrMjpfNfKLd+v+k7kKJ/subQ1dU33h0v5DiOovcYwdTeA0iDXAVR5vQ8D7Pgvx/MxyNhATBgsy7/zMK3DwKyW+u+gNRk9Jznsaoelp6W9flkKdqm7U0hLni/RmEyj1ONd8ozlj8JzAtTUWT1T4Tj0ZB4UEJ9tbBlSSY8iAIdFBcFILXXwmcBK9/poV8nuuULpU59dpTcAcMuwTvq9lWObOnEbMvKwJcmnFRNeaqa4iZ7cG8g1SODrTQJpGd4A2cxAaF2lkYcobv1SfR7Ldxpl/FLuyeOHMseKE76OCfxeNjTA84epX5rgS04KJkoHoB6oWViVrBs+B1eeozmGqrCuiyI/lyjVZGJaiHnkICUJd8Q/hWjYdURVIta53x6mIA69G/zLdX/WX3Jkd3Bp7wiju/EFRf2Irucdiq7NBX6qYUaWC2XwpsWhv+a5oO8tcPPL827jLHxK6aVg/9TX5X/nFdWzSdMf3E/kuBM9uXgic+edL7Gi1Ex0Vv6NnYd7mEKkyg3pAUIauNYBxIwl/H7Lwxg4PCMdfCqE0KqHEL7IGBT657qM+81H7UCwDbKi8msee95WU7Q8XV0w/0yYvQ+Ih8sDoUy8yQ7sdTDJnXbubSoURjyc82OXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(86362001)(36756003)(82740400003)(40460700003)(40480700001)(478600001)(54906003)(2616005)(47076005)(36860700001)(1076003)(16526019)(426003)(186003)(336012)(26005)(6916009)(4326008)(70586007)(70206006)(316002)(41300700001)(8936002)(8676002)(5660300002)(7696005)(6666004)(356005)(81166007)(4744005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:49:47.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40e8aad-2557-4b22-b7d3-08db8c7f22f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add firmware declaration.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3b03dda854fdc..45be0af2570b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -48,6 +48,7 @@ MODULE_FIRMWARE("amdgpu/sdma_6_0_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_1.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_2.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_1_0.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
-- 
2.41.0

