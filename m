Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE47910A88FB
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 18:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723A110EAD9;
	Thu, 26 Mar 2026 18:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pbxk72cI";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B45F10E295
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 17:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKeOPMpwiFmAH6GR7xR2NA0iykvT5DwCOV7DsCX6NfXGLNSLf1no1Pe3d7zDQdPWZsTSslFIJAvDBkGixDH3efu9Lzbt3MfnXBNBf9dEdVX8thdCx6lMuMJ9J4JQqSu6YZG2xa7R8CKcVWuh8+cMyB7ohoSqSsIFpb7auUcJryInY3rqeAcDoQg8Nzq7d1UCh4yRoZ4Ps2KrFzBK4sMd/woW/Uz9yymFAQ/Cna0mx2exJJHQ3oOWqJ/2I+bY/YtL7qWmrQ2hnF2RecTQH/zj8CBx9xwoYmtYItttCSsxqJaXQ0zfOAPgf+/aT+iyrooaqxjqnvPz08PUvmazZHHyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3CMJeTIqzqcjwYDPDDFG5ivrjU9o9QIH/ftpwJQGoo=;
 b=lYUH2t6yE3sL4dqesDFwPcQBBpuwsLolJui4JII6NjoYXzMtjeh+chGXEqJ2JHd8ehQ617c+bpSHHJAzRsBsMK3XtK8BjwvXBhvV4jPI5jbS/EuYALj78DLqNBTT089mIAHj5kgnv+uMBdjILklZww/qhrSeKD5yQwYdadUUEkBpnujf797ei8MgwdJicpvRJ/jtkg9CoED48KXivswKSx23LH78eJqq5VzBlQm6S4daSq93h1KIuNRN9HmnIGVXfM0cbqwEqfIthrew5ClIyAbjk/dO+UKNExEitEA0vs8Ki7eXmcHlFeHRDIyEMzb0R6m8Bz9ePASASuv1Fd0VoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3CMJeTIqzqcjwYDPDDFG5ivrjU9o9QIH/ftpwJQGoo=;
 b=Pbxk72cIDRESKe52AsQWpKUVIQ1wc1DfrtFaXfsGMo9YrP+NnJ9uwRQYIad+l/vzFKgF7scpHu4Q5pQRonyQlYk65Wi8xAf3U2XlBPntWYQAZkABVll/r+fc9Ji6B3porChdhZUTWTkBOIRfYVlLpmTzrL20hnl92qijAlw3WFQ=
Received: from CH0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:610:cc::28)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 17:51:57 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::86) by CH0PR03CA0083.outlook.office365.com
 (2603:10b6:610:cc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 17:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 17:51:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 12:51:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 12:51:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 12:51:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
Date: Thu, 26 Mar 2026 13:51:40 -0400
Message-ID: <20260326175140.52753-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: becea86c-a8a4-4850-cb8d-08de8b605fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: MAYt6uNdo48qNRFL+joNxirGEr55ucuK+K9jhTmbRzZBNr+v8J9B0LoHDkYmN8g09u9Z8Wnb2ilr8ldTAGCU1J5X/zRDoKKUTH5xdIxHSJvDMF4Bw8tRJc++qlq4OYmfiwYxtPQS20sztL1JF6GjtRa/VIGaP+DlZOUaUfxCn6M7L96CHLygkl7Yw2wGH9X/oha0KDoOuRsCG//vPB5UkAy+Ilf/FRJPIZJTVbtt75qVY6/MmQHJ4ae0AdOO27egBuoN0NEvC/YXAtupnqzG4pMqeF1xowKYZCMV4FTFw+KSnAtZ21BlHLMDroKqDFYdhPFvf4vxDhtvel4a0PAUI4mmsfkOgpxnSoGM4O4/I0yYQEgBSz3duCI1g/gcQITkeVXB3wqQrGNw9eoxskfmR6mRWMgYRclBDBpdqizDOrUVo1Se85l44mKjiuIGVPeVlHXMFLNZ7557iV1VGpAWpW3rKVXQar8viKmJqf4V3U0gYHWCC57G4aDDjBFShCGuOkDyQ5nT6HGfKwMA5al/Zt6+I2On05bLt1//ST7bccLpKlqwJc229tgbPbIvfMVk6N0JZFcZYXxK95I7hAc3MVtbdXQ/Z3XV8jWK5MjxvlTmWfUpkbcnG3mbILTSZm/WWHTHRbqMAmBoxu+kTQ2AkKbG6Zme1h17kNoIOP4Ufd2YqRVlinq6g9FdWrsz+rvNVNSCE9UA/Ja8qbKfkFQRsCVcbbfqkHaWU+ccglQpo9yBtsd38k8GYSWHYUz1mL86xD1Dj8oA04lEcjriZUweog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6FwJJ7HMXOcqvZzzZw2/qWicxC3B725Yt+WJRhtn1+K1sNS/HplVvNAAV2vaTyldmeX4remNTjJUcQjjKs5XYFFbh2w5mEVKpl6C56lBHtsdj3sN2gPSeT6Dnt8CGH1teJy+EqaJvfHcKy1dcNc8KqtKAKwhnQHae6R/+CdoC6WZyxusaPaQYqKaNWsZ0fQBjWnm5F1idbksO36LY+Ai7UCAmJK9XomVfQGy0dBlmAbWexrbopiEbDSzYBBTCEMInwJzRpVQOfeInjOQIe3AHVCl8VzxEYh4/eTqtS3tgy3EZHQe7cSgfxcF3HoyRixkXQPmtoV5WG6Jm8t5sMIF8ntVP9Tww4LITCtgHlBn5b2CNLObdIQonuvAITe7UTZauFT0AWDkel/pYUsBLZwfIgRlsN4Hxe5d+lZzhi9qZxXzw7g6dVxYNz1PmG/qNhvM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 17:51:57.1947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: becea86c-a8a4-4850-cb8d-08de8b605fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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

Plumb in support for disabling kernel queues and make it
the default.  For testing, kernel queues can be re-enabled
by setting amdgpu.user_queue=0.  Kernel queues are still
created for use by the kernel driver for memory management,
etc., just not user submissions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index f20e0fc3fc743..061934a2e93a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1268,6 +1268,18 @@ static int sdma_v7_1_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	switch (amdgpu_user_queue) {
+	case -1:
+	default:
+		adev->sdma.no_user_submission = true;
+		adev->sdma.disable_uq = true;
+		break;
+	case 0:
+		adev->sdma.no_user_submission = false;
+		adev->sdma.disable_uq = true;
+		break;
+	}
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r) {
 		DRM_ERROR("Failed to init sdma firmware!\n");
-- 
2.53.0

