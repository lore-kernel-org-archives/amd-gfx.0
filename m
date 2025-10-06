Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2045DCCA470
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 18:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F8A810E112;
	Mon,  6 Oct 2025 18:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fV41Ph/V";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6708E10E112
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 18:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWxRKsTxeeiQW1K1oAIBBGv+hGMRcK43c520Z+i9SOekznQavEAqmgURtB4WwQLx9eTJue/qkBXm9QtaORnlPBwNQQfDEKJwFZ+1/kPqzRqQW7eO7zx/7wBZ12Ax+zrroAIxGlFGYfuzPpYkuc0D7BVjTWCdRFm9c1DP4u53vqGWCkm08tq8npBHK3lsFK/eVGPS/gUkGNAq6nGQkupxPlcG0neLp5GVZl7qcTOUHh154bXTRiuiKtqRTHCVWgKNvb6+NFKNLFNEGO+Xn65tvMQtKvNW+ZRkNjYYO+WKgFGD7OKwzCwjCdt1myjgN4HcjH0wXl+UGIcFdHngftw/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNPvbotzbpXy5Wu0tnCh95Q48Sl3d0smJTshmyL5Nyc=;
 b=NNWL5T65EwsUD8WNXDgCGOR7A2xp9e47KTQso2P8cppYuQAUAAX3O0nq8k7si7yDZaWYm9zqRkjp1vxbFcvHsZ3gwxCqmOHRQPlOgcqVBgvfhC/CT0GR3Ctw5PIM9SELFaJZYrj/UG4tL6UAVqrp0RjArnGNDVE42riem9LZEfFpjS2d6Q7IAIJcQ3kRkIEHmrddv7bingMRF65bJ2YoWYTJ+t+YN0IWIb5vm5IDfiZgnjfTNvyzRLAiKTY75DMX0uCyjBDI09YuFtmdBBkfNxaHiiKot+HwDafwfatCkaTnm3FW9YvmI/Ebw1fKZwnOWSiw8Nooav6tjaXUr0GdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNPvbotzbpXy5Wu0tnCh95Q48Sl3d0smJTshmyL5Nyc=;
 b=fV41Ph/Vag3M38qqkci6p7tG+Vn7CuoQFACXAx8xDlPbXzu7HMYzmbKEI3al8dF4ZmqLO7brZR0C58a97a0gloxjw1jRt9GmlA4OiynbJAEj+ap1Omk/mEDBntycgJ5CCqCyJGvIwDe0bqcZuz1hwJDYxppEK7CStmNgAVEG0Sw=
Received: from BY5PR20CA0025.namprd20.prod.outlook.com (2603:10b6:a03:1f4::38)
 by CH1PPF946CC24FA.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 6 Oct
 2025 18:26:12 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::8c) by BY5PR20CA0025.outlook.office365.com
 (2603:10b6:a03:1f4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 18:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 18:26:11 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 11:26:08 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes: adjust the VMID masks
Date: Mon, 6 Oct 2025 14:25:50 -0400
Message-ID: <20251006182550.90535-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|CH1PPF946CC24FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d41e6d6-902b-4b19-b207-08de0505d372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oQqld2TKaaHuUUYOad5U5F7WF7zZIRmcvjIw2TYa59WkbACoOFe4r/hma1S5?=
 =?us-ascii?Q?93w+xIbHwXZpfNKwibv+itQf/a2IS8w62tQoecigaKviy5KzFvbwZ9N9gqRc?=
 =?us-ascii?Q?CvdzEoWvDYRBHzi3OsEHk5IZk0D5KLJyq9auI6QuEIH09ke9FxYCg//1ckcf?=
 =?us-ascii?Q?WZLOnk31ipFyHBoVw8h89ffM1Nr4kgD4081p/uWeaNA4Sh0TwpqrDeHTFiUq?=
 =?us-ascii?Q?43lj310fz0WU8CoxKR2cjamcvyVfSlLJVW9tuCRKnRgDeHMbGEHNAju2PFYy?=
 =?us-ascii?Q?edTMxEQWybxkOYOTRCN6F5UnZjwvy7ru3uLADqkOocNDk6dOgkGCtz7camOE?=
 =?us-ascii?Q?RxiHW9v1OGfWkYYBcFw8X6xvxr8YCrDt2DhMVoJ8zaoEm7P/2mhJBprcelBs?=
 =?us-ascii?Q?8BiPZe4IdHR3kNOWAPrp4Uyg+yobqhT8FcVf6RQlM6/U78J/d7QKo87MZwU9?=
 =?us-ascii?Q?UTdkxUPouRRKMQqnaoQUF+silXjw6mzUndp2NCeLgc1eY2xZ9tvlwviVaJsB?=
 =?us-ascii?Q?2v3ZqjkTdhhd3bLdBcBeUL0A627fUZVxcTJII/P+Mw6Wq1xPLXh40xarVEtm?=
 =?us-ascii?Q?ONFsLb1lCpCbZTT/CR1fbH/5UcgFUtbdHCHdkhQi6fcaOiTadjObsmN1ocoY?=
 =?us-ascii?Q?cvDuHeqRnQWh1mavGhKoPzzNpl2K3Nqt7OlkxT/h7X/M2MYsSp+hKw0MIRpA?=
 =?us-ascii?Q?Av9V1vdA8dKMVmN8cA63DgW35HuJrMg124Tb6yRsz3wC8/F+b32TMJf1Gkub?=
 =?us-ascii?Q?PO43fFjxjHUB7jtDU/bnpwPqmfQ0V12WvhH8nzd4hH02jloQTFMKL7h1NAsQ?=
 =?us-ascii?Q?0qOCyYXcPHOIurOvwvMchfhRIef4+qnjsrP/Au+1E/u+6/aDiwl4z4lPkV5c?=
 =?us-ascii?Q?iQnXP2uAiUFxk8QfkfEQN4CUgK29ihGRPjKQLSudTaYG28kQGhWgC78Zk2m0?=
 =?us-ascii?Q?oxz2ZxSdWDkx4WgaqHRVUd2WZHz9eB1ahse5t01+M8VhCo6JyCiGlAdvTj9L?=
 =?us-ascii?Q?6LQ8Vb+m9lvh/nugV7jtnhTMpaP8/OKe7hBEMgFTg5I081/m5Zgta645XLxI?=
 =?us-ascii?Q?Arppse6uixLK2BOD06CKDvW3zH4J+42CunCgz1HY9zZsFZzaqFysAGbNl/DP?=
 =?us-ascii?Q?0EzzO4kwQoKuZ5BK2K9GqBz5ICFuRrX0B6ziIozalH+zvXg5wjJ7SMY4WLMS?=
 =?us-ascii?Q?5RcGd7g8jiq70gdtlAN1ype9rHvs1zWrlOqanZADmAlgiimR1RuEh0LWUnbc?=
 =?us-ascii?Q?JmuNuyRfoxPPGCvY5apjHFXRVFGv19k7kbiNv4BQP7W59DbOVD9GqZWo2bSw?=
 =?us-ascii?Q?tJrZhmYeOuRrpTENyYhkMe/Pl7qW61YEUUkfs1vyu77jTd3QshdPOCQJqr4y?=
 =?us-ascii?Q?PxYZXtXD81W6VGJ0pzImQEokCqVrZMFMwTxK6dnsos8znIfwTUzIQ5lr5eyx?=
 =?us-ascii?Q?sYV0LR+2jvh0OomghaV6tKqaleb3JbUlaEbEcDfKhem1R5L6ApayJ58bYvl/?=
 =?us-ascii?Q?6dbKhGngxzKllZjijDjKQF4wP0pP7KBdTc0gTz9F5oJFy5ufeq6Twqy2t134?=
 =?us-ascii?Q?ugkDX4t5c6l7xik++vY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 18:26:11.2330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d41e6d6-902b-4b19-b207-08de0505d372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF946CC24FA
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

The firmware limits the max vmid, but align the
settings with the hw limits as well just to be safe.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 2a397cdbb38ed..aa4db2c81d17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -105,8 +105,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		spin_lock_init(&adev->mes.ring_lock[i]);
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
-	adev->mes.vmid_mask_mmhub = 0xffffff00;
-	adev->mes.vmid_mask_gfxhub = adev->gfx.disable_kq ? 0xfffffffe : 0xffffff00;
+	adev->mes.vmid_mask_mmhub = 0xFF00;
+	adev->mes.vmid_mask_gfxhub = adev->gfx.disable_kq ? 0xFFFE : 0xFF00;
 
 	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
 	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
-- 
2.51.0

