Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E59CAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507B410E4BB;
	Mon, 15 Sep 2025 13:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cYK/7EDT";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2142310E4B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUno0BIAvazguyeMtluHosXxUPs/JUBTnAhrk2gfn+EWUqnOCfz0mqGWEtNmCCf7Nh+2DvwGw7bn1b0BiJSRzFoL0BgQEhwTehampsn7H4RgGLWWjsLtQ13gki903rQDuU9s/UewcB053FkojYN4yMOCkQMUky4mvQ+MjgOwdwQx/GiZ5t6r6klgGPxM23CM31KSYiRNk/iD38TcsYYIpPtv1mUh+x9KL/SeTv6P5YWHPB9f8QScmwurmVULdkyHkLhJYcG2Jex9RwdHjsGwWom6fDjHmBopRg4hQS4J0SNkICdw9d5Mt07FebpOdmFoopFxTOhcPiQJIcPsSca/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNpkwi8aHvPJc/cwcwx8l2m7qIOzkAOUXNYDliiQuc4=;
 b=CTszUoA3bIqa7x0g6V6MuVBuZr+LNRzIrGIjUdVxoIrKtFBLom+mVlXr5lF83xuB+Sb3x4xpf7H6vYX/tmZq0Gb3XOLdrEAZe5LOsfHTI8+MwoprgmG6z72JGnxin2d/JLwlqjsJW9p6sjQmdcQFPHMi2ZP3kbDGP/GoC4qsdCC4733gwZx6ckxIoMTV5iG9WNqvW0Zwnp1rbxN0VodA8pHZVdn8LH7RpM0b6Yz9ZIdYdU5s/A1rTuBnvg3MNPTO6HoW8+WeIfEASg2NzlKekoA+tz24oweW+2ElA6Uq73ptMgY59e/fN0c4SfjyZ2BCzuiAEkmf1CE3CdqrDduYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNpkwi8aHvPJc/cwcwx8l2m7qIOzkAOUXNYDliiQuc4=;
 b=cYK/7EDTVUMfrGysXisWa0m4U000eDe3xfl3A9MFDDkEAWvjCNARtlOCvSVem9MapGl0GynrXcN87OGrh2RGIW1gkX9HEfPePAC8IwnNy0a91aSw2xSV2ENn/4rEPbFaDm6vVXgCAWxdPBp+h3QfkRRjUemegPlD8Bs5i01uRcM=
Received: from MW4PR03CA0016.namprd03.prod.outlook.com (2603:10b6:303:8f::21)
 by SJ5PPF01781787B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::986) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 13:32:15 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::85) by MW4PR03CA0016.outlook.office365.com
 (2603:10b6:303:8f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:32:14 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:32:13 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/sdma4.4: adjust SDMA limits
Date: Mon, 15 Sep 2025 09:31:58 -0400
Message-ID: <20250915133201.3547033-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915133201.3547033-1-alexander.deucher@amd.com>
References: <20250915133201.3547033-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: 9029652d-5dc8-47aa-822c-08ddf45c4851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2+jivY9FDzjWUmwm3dCzumlGffRxU6a6adXWZ7UTQYv3+ZJDfrT0P9cHY4nb?=
 =?us-ascii?Q?mlfSkSzWYqQcyLbuYfxpoudnzS6mNWgAh8PC+02/Bs1kipwmHftEwmDxfQRi?=
 =?us-ascii?Q?R8IJM0RBIQpTynaTCzmBMnLJvT7Hh5iysAQ/74oV9oXgpxCOn6xywM0yGgQP?=
 =?us-ascii?Q?YjevnEaKY8/3VTay6xlqLIIxSsBGCowa5eS0SO5DMopg+W6pONXZ0fSbovUi?=
 =?us-ascii?Q?BuN192ZEnLNGleqWH20zMCClNW/2AvEjKWVs8oESdjaiTpnDFdvJiQJDyp9q?=
 =?us-ascii?Q?IMX5d/xYmMW06oh3X63gwBRSOtN6SG1Qbje5ukD68sm7Fs4IokbOpd/kaLzm?=
 =?us-ascii?Q?FLfb6ZJ7ZaC4xY0Y5TZrodEMRikLpQch4h6mgPgu3k9nfvB95z4fdl69AfwW?=
 =?us-ascii?Q?NHNAV8PgnZrnnbC/6HUyOyVJ/BHhkEq/xupABmviHM1eCtf5I89/O0eZXhP/?=
 =?us-ascii?Q?n6ka1CQJMFhKW9utxPfRz5OJOtmmxstLsmdmkfIaoiZ77N8B7h4P0lIsLwCx?=
 =?us-ascii?Q?bb1U3nEJ1e34RbvPgoWECUAR3XQww/7Ew/A9CnbPdoq1PZSW3qHtVsddkOWU?=
 =?us-ascii?Q?RDlGWC2md0ybJLVsa/lHr+O+DrhbNUmqme6PFb3jVmTTEAnvOWwN9+vdVCjo?=
 =?us-ascii?Q?eY5a1gPPQnlqpw0761TbWwCHDGt0OJD75NBHX8u/TSfYRIeydkiSCzW7m6TC?=
 =?us-ascii?Q?/msn5h27rV+ker/6ymL+7OMYnB5Msge8Tub80up/1DWJZgnLhfiIaSTiSKHB?=
 =?us-ascii?Q?9qMxXT4xdANIuxhlEKxYI7vapnenmMOKeFeBpsAINCmFdp8WTOQAx6V8MGUO?=
 =?us-ascii?Q?MmZVvIlJPCWRjPI4EEG+j2iPMs/ZHZthvz+tF5J9xcYk6k6n9aQGxFoYuo6Q?=
 =?us-ascii?Q?/I337LNzFXn1c6B7KQ/W+JbP/7LYO72pgVNnK1eqphlP40TEOQr3LboVqq/P?=
 =?us-ascii?Q?TN7qRTEeIOmX2xONSfDLmK01KhhmYn6PSZAa8DStdXFN7GZkCc518UV77rV9?=
 =?us-ascii?Q?Clpva+JUI4NZWu3rO8laLBNORjs35wEPeprc8H3Z4Eu3tlnRwAq5LB9yR6TH?=
 =?us-ascii?Q?2W4X6tvCbtr0CHCGVVmbV8RvxFCtDOHkj4RhrzuDWnAo69QBEDK8OkZiiQjj?=
 =?us-ascii?Q?YV7nJTEgFQeegSwdqXiCu/fb2YGrayMiUnGGKwmibY4hQUK8cQ3tHDcjsZ5e?=
 =?us-ascii?Q?Cqn0NIdB5UPxwAb+w4rap3z23W0bF0JhHnFWv51ZyPCiHcSj9d7oUrMvRRv/?=
 =?us-ascii?Q?dxa/kjH99N49mWMVmDJPO+Xu24XysQje95+IqhnyA9O2quY+wpkusQVp/sSg?=
 =?us-ascii?Q?XD1LhS5hXnJ1Gj6SIxwUGz5GicPO2fiTc/zKqT7+SW/lDwnLlqQ1ooc2CKV0?=
 =?us-ascii?Q?SJSLxg5PLxtgJnBHhqO0BlpnbQUGfZIv7ETMLZWF2gH+2bLcxOxVFLeCYvGC?=
 =?us-ascii?Q?Kr2dFqp68QjcmE0ePtQAV0jqjS1pKbQxsdAgheLjh732uVgv34JPqcRUI7+V?=
 =?us-ascii?Q?taOzsys4WWokGJqVbiuDkYhZaNtojZNTH3Tg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:32:14.2603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9029652d-5dc8-47aa-822c-08ddf45c4851
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B
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

SDMA 4.4.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 36b1ca73c2ed3..b95afb4afd032 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2298,11 +2298,11 @@ static void sdma_v4_4_2_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v4_4_2_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v4_4_2_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v4_4_2_emit_fill_buffer,
 };
-- 
2.51.0

