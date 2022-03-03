Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9D3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 03:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC6C10EDBC;
	Thu,  3 Mar 2022 03:19:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4472C10EDF4
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 03:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFkjXds+IoMB/pstBukLDIPmJBD40qr72oss5FVEGETcYnO7Yl2m9iU1cHfTymRjWEUNv/hUrSCU4bub4k+6HDCoiX0PFl7cL6smeKptugmD/Bi2CijARTR2cGlIxyyLmzTBHy1MQ0BdnAZ/qbg5877TrVIEUw/UWmn3wltpo3BG7bonNPWq10v1O0tqX1MZOj7C9+WmQD/mn3jzWvxOvaeYrq8auCpAGy3uo6W0VkjU35YQruemnv8Far7rcol7V9IwjqCZsOAhyWmTZ008dPdFnWkpYxUxEpWpujtZwMiTH/aZSzkTV7WQ4aXdHsVCHdzwQQ2hl7CjIdyYSTVmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/onP9lKyia16pFZ02Aa9xSTQVNhFcHeDuTXG8rmCyY=;
 b=BYzB2AiAGY5cKwDofnioC5Y7DtbmiuOr38duUtmwZ0DXQ26q9TBn7LPkH6SXZE/PD8BbhzUb53QpZKLSVgpj9zSisIkNykESc7ivHzanyxxMTnuwkP5o+JChLXuva/0x0OIfVd7yOA8mCLM9KNKgzsd3YrPsehxF8vPgKgITX1t5wAivbVUEvuYbVWYWzLWW1AJ3ocAAbP+vm1rYbv3F5yTH8mVtui8I3Bkhl7Jv0ib3yMrNORfAo7IkNSsjICNF/utdERHmwWhu7QnHLkAfRjJo8DuYOfLgUA395R14o97pwD9btKxDsDhM0PbyFcSPX1DKG0Spz/829TPqtsXfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/onP9lKyia16pFZ02Aa9xSTQVNhFcHeDuTXG8rmCyY=;
 b=srr5fmh8w7NdarwlCTCoZndsuCBjWbojoHt46y8rWP9AhbMS+rPdPenPALwGkrUgtqELZolh4wPuA5NF/awiDczG/qA/ZZZDKVFVfh91XArcjQnQimRgAKzbxIzWRsr9UZpdnbDIa3M+4c+Evx7YL2qpdpKZtcYbBTkUnXka/CQ=
Received: from BN0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:408:ec::27)
 by DM6PR12MB3948.namprd12.prod.outlook.com (2603:10b6:5:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 03:19:45 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::45) by BN0PR04CA0112.outlook.office365.com
 (2603:10b6:408:ec::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 03:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 03:19:45 +0000
Received: from MSDN-LAPTOPDYU.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 2 Mar 2022 21:19:44 -0600
From: David Yu <David.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran
Date: Wed, 2 Mar 2022 22:19:36 -0500
Message-ID: <20220303031936.27454-1-David.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5409e9f-b6ba-4284-5f1d-08d9fcc4aa63
X-MS-TrafficTypeDiagnostic: DM6PR12MB3948:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB394810484242B3F91CFCDC7681049@DM6PR12MB3948.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 628jFaqx/1Wg98qSPxHY5cUWSuNt6vUuxnHenjyPv6GHb0Z90h49WQmc6htfYw7Fb6g7/e/nuC1PpPvMwXZi+H4xGD0XY+mQpq2ezOcgt1w8VsaT+KrZ7eW/ldiymvbtwOmab1LEPw4B7qSmIJgB6c2m9wo/8lhE/iHJs+sbQq83nrW5PkljQquCASkBSeBi9QKn346+DVo8n6A7+WCkHkRWnejJOqcdpIcxzAbUKYrMi9+a4WXz7sOcSai/PbmNxWcbUy/T/TP2VtKuDfzvzJim12h4qNMpAYfbcBoClz+DHIvjds+M5A0sK+vucQPwyY/vGM5yBQRWL/D6kGu80GVMnhphBVG3hWoFgElzsW3kXbWifQhU8k2/O21WPDnWoe69XOl/5a63eQZwQUTfTdCJRW9Yr/1K8mUR6IurIJaF23k9b0pz6AA5P+OyooEo6/jCtGShf3wYxe6hzjqHAGGXjKKCoaCNegCriXXYjqkaceOadq5Cs415na2Yzqq/Nyb6JwdYSRTvJChzUnO+0khU8yzRwXCjmLCehuoiJ/zyZf3GNavtq3KQcAc6GDJgqJAxa4Gtdpp2qsjvOFQ/xKmqf88TZJgeCXvDolQRENPAayMYxd5MTHn/13RqiDl8DZv5O8tmF7RkDnmR9NtPbnf7ciPgLXupJ1ySlmHYYoUARB4uVa0c7x2YvIGjaCa9tUzLdgIVNVsqxtyATOW9Fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(316002)(8936002)(83380400001)(86362001)(6916009)(36756003)(426003)(47076005)(36860700001)(336012)(26005)(186003)(40460700003)(16526019)(2616005)(1076003)(5660300002)(82310400004)(356005)(81166007)(70586007)(70206006)(508600001)(8676002)(4326008)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 03:19:45.0658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5409e9f-b6ba-4284-5f1d-08d9fcc4aa63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3948
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
Cc: David Yu <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add DFC CAP support for aldebaran

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 94bfe502b55e..3ce1d38a7822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -277,7 +277,7 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		ret = psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret = psp_init_ta_microcode(psp, "aldebaran");
+		ret = psp_init_cap_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 2c6070b90dcf..024f60631faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -31,6 +31,7 @@
 
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
-- 
2.25.1

