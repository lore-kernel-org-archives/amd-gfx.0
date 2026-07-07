Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD492C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED4910EE20;
	Tue,  7 Jul 2026 15:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vQ8dEjxG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0A110EE20
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkQxUaQ5y9KukVVdG5Ykc8MViLlFKBuM9TgNBf2wHLMyqM7M7bYKzFrPOZU+4Mq1XJD8amgr2Hsw4umsV6B7P/xVK68GReYreNbAgGovxdW++LAktcwSrDJ4Ai26HXzbQtjs3l8w591+7QNX9nVGLab0+Y+OvkbZlZDegWx2fgJR0BkeWgZ4CqB3flKwEe8LfB62p60wFJU6tRxNrrtp2e2Tj1Re+xmBxZ9E/x6FyeNUua2hMf+bL9cu+aEPo155FcC+0up8CCk/KST1gw/R5emPCviOEQFhBXU3wdcydPB6b51agkh1/AVLyWFVYiLga69Ds8BEl/BA7hAei2gRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL/gPioOODtsRVjZNglYm0TUQ3w+NN6E70vwneZ71Nc=;
 b=ytSTfYl0ly7Cn6Z0o4MVc+1N8AsRASU7lrpc0zqa6iHodi3H6uuM4sbidRSLvC0fEoFkesuG78/pMT2up1fpAgctODyqABSlmWpzMRGrep8XMN2E8Tx/lfuSf20JMInsodSZmqnvd7+3jqwbUDj44CYL+aJIjqaYjG7ejpQOxhL7D42XnoSeVoeiSjCKsKUFebqSw7vh11aE0riJyF3xacQ7YWAnn04xowxHErws2jrUCJ5QWfptNlXDvnRGvyLxKyekdOEdZoTUpOnjNWpbtKcffM+mTHoFPTnOoQ2EbuiViEhpGKYWFpwEEXlw2KideAD0dAD6ltU1ua2tGdpkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL/gPioOODtsRVjZNglYm0TUQ3w+NN6E70vwneZ71Nc=;
 b=vQ8dEjxGr8IuE+gw4fhsRhtYQNC7JNJpLlDoE4qgU50BZhOi+n9vKJkL106PxJ58Zy0AOAyd602j8mXf4fLeE8AWam6OMDrrqP29lyQMT2fa7pkVVi6GPR93au7lkLdKQa5Hz/B4lNA99MP0b+Bfv9nlgVNZSfNtrItLUQA1R1Q=
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 15:42:30 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::83) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/30] drm/amdgpu/psp11: replace BUG() with an error
Date: Tue, 7 Jul 2026 11:41:51 -0400
Message-ID: <20260707154203.2603209-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 361d6d77-26d5-4f6f-bc26-08dedc3e597a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HxoCqnnfqw56x+875hF2aIOKyOmyQf5+Jg42JorDghRdeals5H+zZI8QDqGC7kCOheZ0zvjYjVCfPXoKV/LqD/tgRG4vUn6x3MZZTPWMBTcght6T2SOl+KJXZzJQd5fOL0gdg2GhXKW0+9nkiddpPmrgREVok7Fx9Xj9Jh4boIectNxVlT3XBvrmEfUQiend2ItER5h2wQKGAb5k2AdkqU5vxBtslsJpfzq6ioqA8QRpRpozEAMKVyyZTN2UUhvV5ZZHni/vmSeGJLRX5huYMcX4JEN5tDwfcNDAv5xbFdAZ4NlirWJgzCjjuhbuzaLvWDaro3VGHxTWMT0QWllgZ7g0L4kFfN/EhK8CE3hCcxi4T0Dy1wTUbz3m9F7KtC5AJEwjAF4N/ldA0CrjqK77Lv3I93m6iFa/XtSYnNL8HJK4YSFcYHAiW8XxH6YJo/UYQnBGs9Rqs13rpDHSkd3RXkqIjIWD29ZUM89dlqh4lAGP6nq5ET5O7pzKpDYAv8M2QzhQiXEE0ONszbWLtVwVssdVBeTUC1N+wYueI8O0gmgkvW5+Nzq89SYBoqEjaHu2dUaWn2w8aVVpVDkOVxN+CczaMouembjNJXWDu1j2g+WyGdROFCE4PGNAN8DP8j8oCANDEO3MegC6dVky1o7OAdXfeP6Y5I3DrrsQue+HTt+iwnQpFm6kMQMxqehGO+DAc+ojOH/oLMTcvnBAI+xuVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MPFhfrazxtI4aGKcBZMLdZIvVnsV0luEstxSoGfswp8R06Njbb6qMupUblMjj1Uq/v4vuRrcmr1wFmDHUAcgD8VHGEp6Kyvfx38nbLxMvixTnNBkz8+nW4qemUSfKEMQopVn0FQH8YDgKuE7eYMQY3BmixWzLlS7aOmdT1FvoSzN2szWG8lkSx0YQWT2T92uL4mK/wk5Oo8Mt9LRkccSso25tTiiPj8cY+ZBFIRFX6TCS5vPFGJqxl8Ha8EyCIuLif7ikZmkD6goSjaeTSWPoxKEsBW4hWizxcAWSZyOmrXkQDvG1VKMq/0Wkg+p6waqrod+a8/VLd2HdSf/85hWt+KAF+50z66oJtJiVAoJdu3eRR5q35mek+GcqBB7FJg1ArjNIjXcPbGU1uWOMV/56v5mV7EEBPR9kG2JjBkD0hJ+kjYZa+XSJ8xxCPNZinWq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:28.0051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361d6d77-26d5-4f6f-bc26-08dedc3e597a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 479690c44f0d5..ca36d434cfe1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -136,7 +136,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		err = psp_init_toc_microcode(psp, ucode_prefix);
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	return err;
-- 
2.55.0

