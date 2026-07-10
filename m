Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9C3C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 14:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331C610E1D2;
	Fri, 10 Jul 2026 14:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HEijiZIz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7980210E1D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 14:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PworiVweW2FlzZXMlgEMerr4hRRo5NQWaHE26wSMkr8c53mQ9X69/CpFt2mDLvB0Oy5YWt88fFqUeS+7uAHiOwOzV2AYZl72d5XWjim7dWIVXPi3KwyhJS1iQNZSdGyYyKBc2J6pPzsdsESvYmISStoL7+v9nYeRz6P2zHPUWrxBXLJ3qxMNhsddKv9MZqBR+jRKjMlB893vwx5LIXqZPQT9Qp9wx4wcCRmaXwfBE9VYd/byadIIsj3lpHUsUhtbd4HMqiipEPv3kG4oWH0n0dmXY0gmOl2pPKHNzr8B2sbNYotPwF4k0VyjqjXBla/1/KjQETZVfsI89Bb5x8ouzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GgCNnl2GEsemu4Whz7ry3HTorFxUEOPSdpUi1tKIRA=;
 b=oW6DCrQIiF0rdQSjxKuCPQVvamCMSyYK2eUU+H3aSLF8GA4N3oeBTpww1LFChu1cDBF8asmupspFThOWHO7CqFtnmGJCpPTwGnhwPMVy4WmWfboweKj7UPr6qDvbpDjV+VUDsrYVF4SPKUgtxi7YXnNTz7Oy0JOp6+iKv6RfQU8sasaXb9H1QU4bIrVKyxdWoGcf06cWNbGAXfw7EW8BE7UubfGkT4wpBLPmk3FpjSkILuouL4AGHhMQfS5ZSsFHCXBerERe1XtkCs1ET39Eb1BaC3ZOutobAThuK7vSnxJrgmiwg//ekzGaNFPTCH4/sAkWmGDrLW/ztumsf4hgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GgCNnl2GEsemu4Whz7ry3HTorFxUEOPSdpUi1tKIRA=;
 b=HEijiZIzWOEBNupO0pttnaRU/gOaZoBQvR1FUStNsFLDGLYnIpvtafsMdFl0Gn10p8ng6Nae+iM5hn0W4bIGHOLBf+ZwIepGtwOUYTwNEX1tQai7ZHT7rYroeCt66Xdr8nwJ2l3V+ADmtShYoNAe4p3XlqVX2mxqxabrfCXSp7I=
Received: from BN9PR03CA0875.namprd03.prod.outlook.com (2603:10b6:408:13c::10)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 10 Jul
 2026 14:36:50 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::8) by BN9PR03CA0875.outlook.office365.com
 (2603:10b6:408:13c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 14:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 14:36:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 10 Jul 2026 09:36:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, George Zhang
 <george.zhang@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Run FP-disabled MST stub test only without
 DC FP
Date: Fri, 10 Jul 2026 20:06:33 +0530
Message-ID: <20260710143633.3227281-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca9f72d-c115-4059-75da-08dede90ad82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 1efZSQN9lLpFCFKNtegCI5Eh8ref1noCkWUG/d24D44MQ0P9bFGXGt5tSlUd9R3RSorSVFvw13nQzfLN1IluoluafY+k1Y0v4fvKJny6kacAzrkrvPuC+A4dKk/DYWojwclC39aIbl7yo38s04KcLIxN0LaxM/yFBBHYmiTOddO4b2D9Iagyucx9bPjQyTpNOLVEsoBlGHivPwVTYSguP4D/2xOBtBEdACLTeH2urYlvuY1nhB3gFS5/A+O7Wi3xB4ec+rrH1j3H8YsQcsV0GVaG8N2nIkW1lBCLVtzIBXnShQCjHs73Ko49pNWeAiEF3lkE8m+dKsGX2t4Knh+fU67xKymDJPi3P+jRMJn5RzANkohjd98RAP1Fg061QpO6VgkGEs2CnSZWM932S26PYUx6iBufwfSmCE/KhV2vwa1FRGKFhbjoy19l8gRuYr6xiKHSKfWNH8q8qUZMmpo8QeHAgMplscgrI057cGUfs4620ypuyVr3U/E419F2PjvhSgNZYJmfO4rWy9UsA80NunrwOFPrPtIwcnRWwNAv/hmJV0X+g6sVVftkZX2cdQRlQAtQYuU10Un4li8DKrWukpznb0L5SKBQUdZsEpLrpDsG3k9qC2Zq8WhOjk1gEGZjCAU2Fe+QjQVjtilBzEhSL+aaMgRobG9kTh+kacfRJdhmu5gc4GrpyXqfM3te1SwYVIc5Gh2zSI+mcRMtNgTdlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4tUR9RbHdBi9Doxnd7wMFn/lNePikK3fWvVuUh3EJ4fS8As8ZCE36vk9jfEzH9g/Zncg5Ph4QZmmgSAJj1JxWmA/B1/U9DnL+Qq5RHScgw/NHyzR4+XEMA765YmX50gSWvmNptsnvu23QflhLJZfXBW9WB40PkP1n+HUoFVio0yKrO6OXttpdQar000P9Nl5xfHPpINnxHbR8H1SLLseM2csRorXhNNDa9LSESkw6vB+GRNQvdcypi0G3dcywJtF/UQzPIgm9FBPjYgkuEPPkDyZ+QDfw5wYMixGv1TxhSSzOHe1rUHqMvKlxSmoSMhZqD1DBtP/6RxCbUhKzyUcW0EoHkrlZc0Ghp6eMAW92WjA/+TJN+xQn5Qke+Q9rG66SotqCA9t4l0PtjfJ6l9t4bY9XTwYJPBPcZnTAA46tpcG52wq0xquH99LCjBhj7u4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:36:50.0407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca9f72d-c115-4059-75da-08dede90ad82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

dm_mst_test_fp_guarded_public_stubs() passes NULL arguments to
dm_dp_mst_is_port_support_mode() to test the stub implementation when
CONFIG_DRM_AMD_DC_FP is disabled.

However, this test is always registered. When CONFIG_DRM_AMD_DC_FP is
enabled, the real implementation is used instead of the stub. The real
implementation expects valid pointers, so passing NULL can lead to a
NULL pointer dereference.

Register this test only when CONFIG_DRM_AMD_DC_FP is disabled.

Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 3f591e3914d9..666fd2ad903e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -1015,6 +1015,7 @@ static void dm_mst_test_detect_unregistered(struct kunit *test)
 			(int)connector_status_disconnected);
 }
 
+#if !defined(CONFIG_DRM_AMD_DC_FP)
 /**
  * dm_mst_test_fp_guarded_public_stubs - Test FP-off public fallbacks
  * @test: KUnit test context
@@ -1027,6 +1028,7 @@ static void dm_mst_test_fp_guarded_public_stubs(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(NULL, NULL),
 			(enum dc_status)DC_OK);
 }
+#endif
 
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
@@ -1077,7 +1079,9 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	/* dm_dp_mst_detect tests */
 	KUNIT_CASE(dm_mst_test_detect_unregistered),
 	/* CONFIG_DRM_AMD_DC_FP disabled public paths */
+#if !defined(CONFIG_DRM_AMD_DC_FP)
 	KUNIT_CASE(dm_mst_test_fp_guarded_public_stubs),
+#endif
 	{}
 };
 
-- 
2.34.1

