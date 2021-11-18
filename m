Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74864C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C56561391
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C56561391
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC016EA52;
	Thu, 18 Nov 2021 16:53:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE08F6EA52
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 16:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2X5YaKJNy8uHwDwnBowgaDyfNvCyKArC3356FOhs6y+lMFkbh4DigEcnlkRddSJBTO20XEDBpcPQBY8TQcNXKw9s08EYdnID0s7k5J/CtC5XHFUQyzQKLuwz5TNjsPz5xZQDoc6JTJd8NOKYDNb2CZN5MpVl9S+ZzNCritmMJxwehJkaQfbpPtPMcl//XVkvY02DAb2fYz/GAVGsdaNPRBCgiSFMpB2VE2frG0j7UXv9VsvrAwC1BecAQhKdQbSlA+poSadvvCNjCvxCLnw+SarbFpNyxkmaoO9KI8AoN+xmgp2SGdf8GtApqFfNbrWrq6LgBkVWVPPx7aam90dAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cVg3J3zA6lhJULhTgVG7zLaEx4FnKSUAvjOK8GL9cU=;
 b=fVBmgGuiqcrmKJ+vNgBKHy4F9RHCw/1L2B2JHkSJ8oTEXYSsna8dCMg7RjqmNptepCBe6e9XkijeXehDLkYfhepT4mrivGYbkZmGFt+Y0reKQCG8D2A1LToI/nW8dr1/gj+pY5K5UASFhgOGA8SXMMcb0C6lMUNyCZqYdEVk9YgluFAq+PduZxy4WK4IWV6p408iIycQVW3hHe+7g2rhpkjlzbs5OQnd3k8Xv868xEGdFTFvVl/TuwJNOJ6MiQ4zHo8OcF8kYg5/NBQevD7l1GIeNbP/GBCGuk+DQDw5mi92vPBZbF3kIpVJf5rnAmzAbLQeyJmqHJjGFasiWr/c8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cVg3J3zA6lhJULhTgVG7zLaEx4FnKSUAvjOK8GL9cU=;
 b=5L6Mv3szWI6GNMSKaotP/xsDmGp+GjfC0UBIQRnTDg/f1cYPfe1gsjQwypUILy4R223pQfXVHkHAM9HkIHadoocXSspb2MNmKBnG0x8FgTUI4DH34OtCZlN1t++Jqg6xycXNtjr2b8KRkazSGpJix3xKBqKfSoucsS50UxLNQnA=
Received: from BN6PR14CA0016.namprd14.prod.outlook.com (2603:10b6:404:79::26)
 by BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 16:53:10 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::af) by BN6PR14CA0016.outlook.office365.com
 (2603:10b6:404:79::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 16:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 16:53:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 10:53:07 -0600
Received: from leo-VirtualBox.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 18 Nov 2021 10:53:06 -0600
From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>
To: <nicholas.kazlauskas@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Drop config guard for DC_LOG_DP2
Date: Thu, 18 Nov 2021 11:53:02 -0500
Message-ID: <20211118165302.15821-1-hanghong.ma@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 842c3a64-a127-45ae-54c2-08d9aab3e6a6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5084:
X-Microsoft-Antispam-PRVS: <BN9PR12MB50841916D0F1F0F261A9AE77F19B9@BN9PR12MB5084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wL/pTUACJt3g9p1BlCzFLi8mLzmmLvsWsWre16hmKRIR1M82tGWoPN3aoZ5tN6dgoG8My56STxRklTZQnYp8/cTCqD1XyQtBVQkycH88j7MaPJnAU3D4/uyfRbLyvrRJqq4AMmSuLq82n68509Jpa+c0nKsaz0BJ60YLfHZdvWk1RWqRCDlGFONnwJqFnIoZjWQl3uR3FM7CRPAwcFrRvFmyV9qGzksSgpUXjHc9BePgO4S9sX2es6qA34X/WzPDkBA1uF82LJBjcZgF4pui341o6zfWLRXajvIyh6FE4pxYJ5PiIDqyWWQnmnr/T0z5Ba49YnX6G5fjbmhG/FUiBPXEECDw8IqQxMfpF8CHlOvJqOf9FbiV5HMT0FIK0P/YXXcbSlLnCaBaelyV4SwnQaNnHxZtdIxpvjp+MdqY70Pp9wmo8a31/TJAvrNgud0MWSdStFnrFpatPi3syEEk1mcTBX87+2/pyO3PKDXGteW3RYRMMN0id2D1y4ZIKugeDvKqBOLZobD1bDPnlJitTjgKPcsJxR1f6O6PXfKMOS5f88Jr2EIsjKABWVCtkaicNXyPZ8t0nlWekjxhW6ieCEBt+/Vcv7v5k10wqx56xhDrFG3M5e1iGGYva32Ol680wZ2q73KApcRN+ayccCrXH5XKfosWegPGLZTs907x3taX1naarCZ6P9ZRWLNJDA0wY6VW+GpfDlDLzNgPntB0Wvx/HWJrhx5fwQzr7f/q6Is=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(47076005)(8936002)(356005)(186003)(336012)(54906003)(110136005)(81166007)(426003)(70206006)(6666004)(36860700001)(70586007)(2616005)(2906002)(4326008)(508600001)(83380400001)(5660300002)(26005)(8676002)(86362001)(36756003)(7696005)(1076003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 16:53:09.4734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842c3a64-a127-45ae-54c2-08d9aab3e6a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
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
Cc: Alexander.Deucher@amd.com, Nicholas.Choi@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
It doesn't make sense to guard DC_LOG_DP2 by CONFIG_DRM_AMD_DCN, and
this also caused build failure for allmodconfig; So drop the guard
to fix the compile failure;

Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/include/logger_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index 370fad883e33..f093b49c5e6e 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -72,9 +72,7 @@
 #define DC_LOG_DSC(...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define DC_LOG_SMU(...) pr_debug("[SMU_MSG]:"__VA_ARGS__)
 #define DC_LOG_DWB(...) DRM_DEBUG_KMS(__VA_ARGS__)
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #define DC_LOG_DP2(...) DRM_DEBUG_KMS(__VA_ARGS__)
-#endif
 
 struct dal_logger;
 
@@ -126,9 +124,7 @@ enum dc_log_type {
 	LOG_MAX_HW_POINTS,
 	LOG_ALL_TF_CHANNELS,
 	LOG_SAMPLE_1DLUT,
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	LOG_DP2,
-#endif
 	LOG_SECTION_TOTAL_COUNT
 };
 
-- 
2.17.1

