Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE10C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 06:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759B710E5C8;
	Wed, 26 Feb 2025 06:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3T2UCQTG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B1810E5C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 06:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1LEJXslXHH2SJFvhsiaaY5KC5RDH48j6jCb5qDOaSfnfRFEETgRKRgfgynE72Ze/6aCF7ZkFAJhv/JFSiCGd0F5m7ImlxRElaVK0qBKqMhFxWcL4ZHhuZrw8eMyDZvXVwiQYqHWa4Xt+vBlMFUhEGe91ymsfU/KJCH/roy09lUDZuGaMArmFzV1ncsTj3HnP05OyKcJH1GyRfiNScfpBp+aMo3lwi8gprA0joAm1hZGTIzNQICOMy/6vTeQUTU7cHtBFxFVxJgPvaByNnT725vRHxC7MyzLdAv7T+XvMI84w/z45CB95BxbUfOWNDUXkt2O2WZC7+FTKQk6ESrpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6zmQ4ZdYIbW5pR5GPL5SZinwP5Wi21k01weGgbjoIc=;
 b=BpTk3tWv6saRmoUHH0R4U2VLtxG63BntbnOG7i3IXq3GIlWf8aPrgmDf6lERXUbAptHMI9d2/V3Lrarl8hJWzwMzODomHS9I4+qnlpmBrOi07zup9O57ERFsrMRtWZ5kZght0Ickwn/5uD3lNcYvRZSTUfdfdXBJ29wJ3qw2bDuHhFl5WlmyF1545JKeoRhsZHySTfd3er/wY7DJ5HZZO3h8Bk8PfHCVvTeMNpr8sQug9odA6yDOWLg5o+Nm+fxPHw9zbUdRbl1wMH0t5DltUZzp5uf6DBG5JgIskNnMtRAO0Sz6zqePd/+clP4+9LQANSrArGYKztLswv0ciYV9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6zmQ4ZdYIbW5pR5GPL5SZinwP5Wi21k01weGgbjoIc=;
 b=3T2UCQTGK6WPGtQEsqtKFPfEYEYUGE2AqQQh/Hcich4gcw3L9PV90EfYgPPt7zQ8Ig2dyC+E+v9R4xnRXVBlb4aaDSuukZR36Fu1uJ0PjPCqLcBW0aq9kf7MoIaafBdpz4+1dUw2fB8eakSr64hYo95yahtOMRcGJw/z6vBn4L4=
Received: from DM5PR08CA0057.namprd08.prod.outlook.com (2603:10b6:4:60::46) by
 SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Wed, 26 Feb
 2025 06:30:45 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::2) by DM5PR08CA0057.outlook.office365.com
 (2603:10b6:4:60::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Wed,
 26 Feb 2025 06:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 06:30:44 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 00:30:42 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <rohit.subedi@amd.com>, Xiang Liu
 <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Report generic instead of unknown boot time errors
Date: Wed, 26 Feb 2025 14:30:24 +0800
Message-ID: <20250226063024.52653-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b055db-9870-42a3-d7b1-08dd562f1977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iEyop6kBXvMjrAD8Xb4/2QTGnrFxMduzLcM5PzeSmhVryA17pAY9WkPgnBoP?=
 =?us-ascii?Q?4WMpuZ8JiSp2cvZXLM3y2Sg4AsAD+qMKSKErlcpbGpCJjh4S1Znyt5yUqrVt?=
 =?us-ascii?Q?7sggyzMgddxk3GTbTDeqbv1qoQwlhq0pOX0ADCpvjG1b3tN82Jz/5+sX3Tpe?=
 =?us-ascii?Q?LK0/s0uWSETZVv/jQceLIaf3Fzj5G+MyxMJrfG3jddhvrNVfjp9pXWdsZQS6?=
 =?us-ascii?Q?0sMOca3URxwygkFlR+rMVneywi329jZhAWPN/N79b+G0tnnKry0dAvGi8/kP?=
 =?us-ascii?Q?fB8kLUTQr6rlfmO28q+0YEKWEl78p9PHWcuy2Nu18steYExO5vwcNN4EqQ/n?=
 =?us-ascii?Q?88/FvthWYOyuXeUxFV6QhdXCB0QMU7YI2SBiQ9fjwStMjmNXBTnnJnihK5l+?=
 =?us-ascii?Q?srpEoDb0Rzx6GLMlhqwWNHMZGUPaMx2CIYECM/qT8zO0zV0S5bM5ga13+nBZ?=
 =?us-ascii?Q?vBWOUSw7M9wJj87YwvKcLcNW77piAmJL67OszBKvkdoS5dTbgojc08TeBMgB?=
 =?us-ascii?Q?+jJ0H9gc9PU+DDOiiSB6uDYlO/pKV4/WH1us3V3naMSGRQ53aLx2MNJ4iCKk?=
 =?us-ascii?Q?dO+gwJVUi6QYAWncvPjf8fop1VStW+4gY6/pe90Z6NlxJZtTmbIyZuYNn5B5?=
 =?us-ascii?Q?1GLZUyfwYAJdo6HZ+n6S1FnAIu3DUHcwth9HQRh7ZZLO5kZi5PxuiuHwTazw?=
 =?us-ascii?Q?bOtN0SsTPCSoS8nKnWpVMxulEcwPWgldAqD6YFAvRhY4m844GYuIWIG56Ayy?=
 =?us-ascii?Q?ywrcTEmKJbb76wmDcPvuQ3qVpPM0YxRISLJvGorbMkJdRUrcmbKOpv1qvwCE?=
 =?us-ascii?Q?gORr/ZxeNfCWlKGCnlU7fdnYet5vBJ04WdyRr+NffkG2n77ibW5bdowZ7u0R?=
 =?us-ascii?Q?1gYBVd4rNPrPYTdp2FBO+LV4dhfqDNlMv+d8ppmmULwLYRui8jxzNvW/7FFj?=
 =?us-ascii?Q?AHdYyT37EMoRijpq8xR5afOQMUs2y8R5YJybdCAFTccX9TUmXBpeiBk6Kzgp?=
 =?us-ascii?Q?fUsPj8hmzfq89G7DVZ4RVOSJWZzwEHM0zzlrNoLVa5n90yQ9aChhxcZegiZ2?=
 =?us-ascii?Q?AkYSVS3knRzRNykLE3ls7tQTqCbuYXk7v0k0JaBWrN6NOyKaRFfV7EaX9/IZ?=
 =?us-ascii?Q?wX9qvKmDsrT2i2j7Lce+EFXHTGMDU2rwEo1kFNltl1QMGT5lgiSq5YHBbl4o?=
 =?us-ascii?Q?BdA2B6t0IMHVLV3F3FMfS9mZl+llajBTGsZeWpLx903w27Y/CUf542PIsuB/?=
 =?us-ascii?Q?JvAWSfpE1rkK8HB5isB4hjF+30d/rS3IJxM7loR+U4ImV+8ifNsSgrWNW/ya?=
 =?us-ascii?Q?qrTBKj1k91BpmhtVYsj7t7Zz1p8WToEBX+rzu5GcixfI30pPk9Yt/4D3bheH?=
 =?us-ascii?Q?j6TZ8SbeZ5eaUmls5lfR0mJBFLRtetWyE0fxHQ5B3TKt7sEs4rhgFRLR0LGS?=
 =?us-ascii?Q?VQKWYFzqcMM+9xNJaHhUeieMNd8R+WoQHf5IHr5cD2QJGmotrymMBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 06:30:44.5964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b055db-9870-42a3-d7b1-08dd562f1977
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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

Change the DMESG reporting of unknown errors to "Boot Controller
Generic Error" to align with the RAS SPEC and provide more clarity
to customers.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 493dd004d6fa..285e3aa2bb2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5138,9 +5138,9 @@ static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
 			 "socket: %d, aid: %d, fw_status: 0x%x, data abort exception\n",
 			 socket_id, aid_id, fw_status);
 
-	if (AMDGPU_RAS_GPU_ERR_UNKNOWN(boot_error))
+	if (AMDGPU_RAS_GPU_ERR_GENERIC(boot_error))
 		dev_info(adev->dev,
-			 "socket: %d, aid: %d, fw_status: 0x%x, unknown boot time errors\n",
+			 "socket: %d, aid: %d, fw_status: 0x%x, Boot Controller Generic Error\n",
 			 socket_id, aid_id, fw_status);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index cc4586581dba..764e9fa0a914 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -47,7 +47,7 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_GPU_ERR_AID_ID(x)			AMDGPU_GET_REG_FIELD(x, 12, 11)
 #define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 14, 13)
 #define AMDGPU_RAS_GPU_ERR_DATA_ABORT(x)		AMDGPU_GET_REG_FIELD(x, 29, 29)
-#define AMDGPU_RAS_GPU_ERR_UNKNOWN(x)			AMDGPU_GET_REG_FIELD(x, 30, 30)
+#define AMDGPU_RAS_GPU_ERR_GENERIC(x)			AMDGPU_GET_REG_FIELD(x, 30, 30)
 
 #define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT	100
 #define AMDGPU_RAS_BOOT_STEADY_STATUS		0xBA
-- 
2.34.1

