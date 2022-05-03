Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D0FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1571E10EA7A;
	Tue,  3 May 2022 20:29:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AE510E742
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD/Oy2gbn7W83lAj29ed6ANd/4BsS/aiTKbSQbqL4t5RhkZevJ/ldtW5F7F9h5y7pDGexivdT96Evc81a5Ty4D7PycBrMt6VR2H6xv2yUEyAcJj1itlDbGxNo7Y30wovRY6WZ+FoHv1P339m3qiCWgchKKw1yU6sFmocs0Tqmc44Y8HiNcS1lUhT82gFCGatY9MqzvdIt/0Wi8zUjXbfsm+M1VbRbIHSvwAWZ43K3gCx6WLRPLVZq//eWXtu2n8ENEW08je1oTQBq+kq7GvQA08r0f5nlLopFhaCXq9mLdANzSkLx/fYmLBDLr5CHmIwWqoMBSo8NK4E+rNKsKJyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdIEM18bTVf8II0fpqUt16+XCLKwOEfHLNRx2aXLhe0=;
 b=McVinU/8yr18zkH4ZDmL3cwIRPDQ+XQXBy5ltk8iEfV++452GSLIsaEO7fs2Wdk+cHDO35AM1/PQjPm0XOeGRHAjEpibsnYXDuROStf8Zw5LH5GFVYR0n8dvqH0l+XTat8ggdy1YKVjPA1xixxvGNUSklQ0YWePrqSRtpH0FMCcTcv+jz763hYsLm5PQ8nxfpqWfPlepC3ay+NNFzVzsysB/fPo5aNP3Av5wffAGa2FPN5tGtykA0VfER6QY2FUfRIKbdQ2DVUsNYeeZNWcFg0NeE0y2FfXQLqv46ajGAzAM8eRb+ykYci+UBSDstlw49SklyFbHppSEbhHNuH4U+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdIEM18bTVf8II0fpqUt16+XCLKwOEfHLNRx2aXLhe0=;
 b=Ka68RbehNPn7QeU/y97KSb683PqMjsabeUuP/tKEPmLp05U808/CsLUpf0r6rwzgJFe/PEfc12JDy+yxXSFYpWRoELp3ZHwCYoZ777YvuXdb7eCKWC21gQB3ZO1G2+N79CJTr+xQ2me0oRIpmORrFUrPDSVPM0OE8U0KxW/eUD4=
Received: from DM6PR13CA0012.namprd13.prod.outlook.com (2603:10b6:5:bc::25) by
 MWHPR12MB1552.namprd12.prod.outlook.com (2603:10b6:301:a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.17; Tue, 3 May 2022 20:29:26 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::5f) by DM6PR13CA0012.outlook.office365.com
 (2603:10b6:5:bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Tue, 3 May 2022 20:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add GMC11 support for GC 11.0.2
Date: Tue, 3 May 2022 16:28:49 -0400
Message-ID: <20220503202912.1211009-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e3bbce3-61d9-4d8e-e2cf-08da2d439de7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1552:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1552442A7B9B49D9B3A0A94BF7C09@MWHPR12MB1552.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmdpTFFi4pLUTQLBXlzQE0v2KRbxUJjvTZpuMComavUM0QDUUQQlrwRyAco1w3tPMnfI/eIQVzONIul7x5XGPqhmHby6/QbhK175sRnycv/Jr/N0tGpWswylVCA+imWEHrHa06cPueSz+yCoYyIXyLU1fdEjEd2HnAlLI9LWJbxtB7MJmxfjD1t6Qyk5OQ+7UyfgVXYs6KFa9NHhMoqdJwJ52JSUTRLyUyoEG3NaR7tO+7ueL67bjsApgAKmUwA0D+jmKjRFe49sFBbPZxjqOyuYVzsY2x7vwDYL9qcQFsbTSiSKwvsaDsyR1S72RI3lNksjAQE/KPjO4Yziy8MD2zpcsKCS2VfZ1sNQXH60tiK09HJdrmktcNVtYCroT0kRpSdAG6aw/tPmJjrr0/VdEKX6el742TKJjidmFS3Gut9ZL48GO3fkqgiraywD4cJo5jd0LegdBdaAU8tNBoQYzzs8zFzS4T5E6Su8XGLjq3Psv2tBwZCntJv6zQkbat7Yzi2BPpBTYJOrYQy3dtaE9bzLnKUDT6sagGyxav41SHLXaoDz1pWNQKZNTLnSd/8IFEwwqBXzQp2G7JTb0GmTCHSoMOwkUzI7b7EcX+eR2c2r5LQ+oXbN6C3ItOtvGKDIophpFhbQb+qRxrYr75bHH4U0BaQCZ4lTST1ORg07u3C3vf8fe8kAQdA2cDI2UCRMHAeZRLNNBGM8xWW/50E2WA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(4326008)(4744005)(8676002)(47076005)(426003)(336012)(316002)(356005)(6916009)(26005)(1076003)(70586007)(16526019)(186003)(70206006)(6666004)(86362001)(7696005)(81166007)(5660300002)(8936002)(36860700001)(508600001)(40460700003)(54906003)(82310400005)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:26.0687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3bbce3-61d9-4d8e-e2cf-08da2d439de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1552
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Add initial support for GC 11.0.2.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 2b4241aaf6cc..2f3debbb1a52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -747,6 +747,7 @@ static int gmc_v11_0_sw_init(void *handle)
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
-- 
2.35.1

