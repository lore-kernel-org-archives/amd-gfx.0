Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4972CC83000
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 04:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C5710E051;
	Mon, 30 Jun 2025 04:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXyN4LcA";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C80510E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 04:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8Kl4EHER8m2xpEBdtlmG3ivEgbk19oBgWSRHtf70DyDew3nWuGFyl8JNJYKD4il6Hc7Y/4GFxeL9oej4REWCIxJyjMbThzcJpjtlhfICLPwEihp4bF2F3yyVkvkpCBfp/ebO6cUnPL4IFtnI0pKthAYGaOTRf5wM4JYRnkXgpTTkNi/PXQFT79YZ7qBV+MtU53DjQ8z0Umy873FccXaMjoTHESBA9XTdHYSOiJPiHZ8aT3YqBWkBDTE/pGNLYReVZYcaI0oriTHNqJKHSS/w9X2V672QYzLZlzxKMU7nd4MyTokstPBieMMyqn0I/+ruE1kUkab+h+h8cDDfj3XdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jHFNlkxLwxgjxXE9YTdaeQc1W3orbZWT6d8dvetmnM=;
 b=ZQz/uzqKByG6/c92hzokC80lRF+A6wjNvcn1PRz0dvJeX2ltPvbbIQ1i32yA5RqEhZiNfPhRTrgNZRIi6fGpmRPDZ0rGy+Z/qfhVtJiXTWPmVkDdc2MLB/FpBHcLDGNF6M1+LAvOvR2Ghq77PEMHoGfrkgLQ98VZBIvq75SRfGNv1XPUPECknkRLR8b9SGg+ZpXMF+ALCmQAyhxqI6Xo7ljqtyIci/SO9m5+U1MaxGSDOVvocG7XhxDUT3uRrZ3J/EkvNj/mAWrJ1VueSR9xwGldghQC8+7SEpvjiRJuqlu4d66cwjAuxiXqGOLsSnhoeaN7yjvZ170ZM5sz1YsuIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jHFNlkxLwxgjxXE9YTdaeQc1W3orbZWT6d8dvetmnM=;
 b=LXyN4LcAvhIH9xlJ86H/ReMV4A5AeRWYqWtgbreuCZJgE5/VMk599CZcTARSd2G71MvucggxGy2aqftddR9nv2MiGxW4rST8OnqOLXJnFE5UWuncHSHIo26sSthTpYDQzMjENBzrjzbjUINpR7ql4wz0reQNcLaYw93Q2QTSvC0=
Received: from BLAPR03CA0101.namprd03.prod.outlook.com (2603:10b6:208:32a::16)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 30 Jun
 2025 04:41:42 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::2f) by BLAPR03CA0101.outlook.office365.com
 (2603:10b6:208:32a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Mon,
 30 Jun 2025 04:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.1 via Frontend Transport; Mon, 30 Jun 2025 04:41:41 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 29 Jun
 2025 23:41:39 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Avoid queue reset if disabled
Date: Mon, 30 Jun 2025 10:11:23 +0530
Message-ID: <20250630044123.1261300-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f15d3e7-9219-49a2-77fb-08ddb79068b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ghHU577+JaIEUpqnYstGb3uqwr0sV2lqJPgBseW2wSK7vsJ9ROfdr6NEi/RS?=
 =?us-ascii?Q?Kd8gRJlwm/sJfp9vFKFtvxw9QoJjV4LSPBUoD9a6norPJcL72Ga91RXRYF25?=
 =?us-ascii?Q?xFb8+senZlmr8Aaem4t0+t2KQmjoy6mJYpoOR4PAggERCTqNBIWBYv4tM7cN?=
 =?us-ascii?Q?ARLYc9GhIOvEbEO8qgNrqzL8NAWSC9XlKH9ZBtMylHFSeSXgFOZPeW/SSasM?=
 =?us-ascii?Q?AaGZtHiNtcukPbW6s4ejPnx3GDlS8HfO8VAM32lwJHXTAvnzheI0XUL8jtVR?=
 =?us-ascii?Q?C/tZlRYNLdAlefLXAkR+zhTATCfsGO/L36XwwPxSn3IslwOP4YdYGr/hUHpa?=
 =?us-ascii?Q?Vv1yM4qIKHtuhZX2U7A4TwOp6m6m3+HNice9A5BaW5qJ680i/Fwr+cdVNtT3?=
 =?us-ascii?Q?6vmAIS93OX2ARCXj6etmHbuZMxdCIO1aTJhwar2efH87NuZxSosOS6uc4ipU?=
 =?us-ascii?Q?Kh97XhHl5nIlP1LOb0PWfYPEooNjQfTbMZ98BEy4k1MKYfYWz/xqJ6qKDKaQ?=
 =?us-ascii?Q?Zc0QVbxNBS0krIeekbZDSUz35GUUlYpIUYElP0XmCl48lN34UYsGbJi+KoZW?=
 =?us-ascii?Q?UX4fY8Ub6vzoHS70tIxPtuFguMcZPq/nMy1tVxhkjqIBiqXYSW5XqMVf+87S?=
 =?us-ascii?Q?rg4+LbEcpuhiwZ0RZZs+hQsqopUdq+Lgq9Z58hGxNyD9wibZ8fU7NrmY5do/?=
 =?us-ascii?Q?fsEj1RwEw9qWca2jkf8+jHWVD3QzyTBLe7ewdImWXfP13yPdODst6mjZDe7D?=
 =?us-ascii?Q?C0ChsYoYxHe7Wv8CKS5QYMDe6wKgQasmN5k+4ePYltCZJ94X4TTCGlrT9rsm?=
 =?us-ascii?Q?exFd25DU907JSHzFAaYhafV9HFeKwJ7cDBj7xKHKnoJse0g/A+VUf5S7we5N?=
 =?us-ascii?Q?zhMoYLyqn3zymHcpencygC/6Al5np5OwdCJHgozV8xazLzu0mo7+YgYfXqgs?=
 =?us-ascii?Q?2cwlSEqRV9KR23ZNlZPEZgyu8F6JTd94Ri066HzvskOFH5BRtW5ocPVRshIh?=
 =?us-ascii?Q?JPIoM+hR+RWxY9fiaxPGNu7vB+eGkWT6I60XZdpiqUO/ZkZVUaTWjQbi0T28?=
 =?us-ascii?Q?f4s3C4KyX4TtJRTls+VjDjHwYeWwa9XqGLjueZPVt32kCp1k0wb4RWj1ZgLB?=
 =?us-ascii?Q?wv4HjfMo7jLjdHs8Fg77RU1sI4krisYBGjWN3c72ukbZch7AEqHX94ptsSPl?=
 =?us-ascii?Q?bRJtmK1QEXXoDsxIGle3mG2HZDMvhvjH89BHgC+L1Lka5WT6ZAAwUFP3IEnd?=
 =?us-ascii?Q?lwCDx78km8qhw7SugYJxenYVtKOjI6ahfs9s1IAIU2k6AB6FqhhaKJxzTEmy?=
 =?us-ascii?Q?qeyr1w1kH5WQQOmRUEygYHtBEeWH8Adpu42ZOrgvimphAhoeWcjWtqsxSuJH?=
 =?us-ascii?Q?Z4jLdhpB4TKmXNAvN6C0Xf1bDcgR9E3v0Z6kYprvY8B813hd1K4NWkXyAT/D?=
 =?us-ascii?Q?QKq1kBvdmj2cuas2A7qrtSUhmbdpHJnV0so2ywrU47ccD9NjUDztEAT9g0FC?=
 =?us-ascii?Q?G/htDnaECM78qTYmK669WBH+RsYh/WTr7Fb/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:41:41.6210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f15d3e7-9219-49a2-77fb-08ddb79068b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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

If ring reset is disabled, skip resetting queues. Instead, fall back to
device based reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a..500f51552038 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2339,9 +2339,18 @@ static int reset_hung_queues_sdma(struct device_queue_manager *dqm)
 
 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma)
 {
+	struct amdgpu_device *adev = dqm->dev->adev;
+
 	while (halt_if_hws_hang)
 		schedule();
 
+	if (adev->debug_disable_gpu_ring_reset) {
+		dev_info_once(adev->dev,
+			      "%s queue hung, but ring reset disabled",
+			      is_sdma ? "sdma" : "compute");
+
+		return -EPERM;
+	}
 	if (!amdgpu_gpu_recovery)
 		return -ENOTRECOVERABLE;
 
-- 
2.49.0

