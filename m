Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DCCC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2A110E7FF;
	Fri,  1 Aug 2025 08:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2UAE7q2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1402B10E7FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGO/ZRrZoz4bfBi30X/0wzyL/ZhBxVpX+kGIyyKwWVFRQ2KJyNcrrSj6gAjFHwKoKenqVjhYPZLot8g205Qu+WwrkGdh0eMR6IhVzWm3mnsbqMnjN3C5RbMScXm+b6/qa5Fsas/bRsyHDJVY5EtFcdrBFPa7hfYFIzkLyRvnwHjGqQMnsbhmXL7E1pFjOU1h7bCqgvJaKaj/Nv8zhTD17Ztq2ipT4wH58jIC9s118fkAxPqRhfrTAuf3E5uHXjBN488rRR2fLg2SOoTYS0Fh9x60p7MX/iMTMCccotC21fNwfNXwS3En/63bNtlIzcCABmPzRWChZifiVf/8APWO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw46yn9TbizQFs0A6Tnu+sUbnMn6wqvi1BdopdZK8/s=;
 b=MFCLDG1oSwYq883kad4B4PnyTOnPN2IG7s9V8eFFtuh4wLJKT/kJveR2OmbnWVTyMg7iiZV5XtAdLoMq6B81UbC4DJ3/XjfP8AMhUeWpXcxXLyqDsv6VNXKbKxBFHWDyQ5hZfmzV+FcDz3W0Sf0FLOuS+0dC4Z96TNXHP/CQbcnjBd8ChqbjHY+MrgbgXyMKQtGIWW/UIpQEYcsJqH36cy8VBSht65IgCwIaWI2zHMzr6aUkTrmzXLPiAi0WAv+t6+l15r+833GKtZNYoLIk2TVKj/dC8A13V5I1yGVyNkwwaOR0FvoCS7JnbLs+pbCXIACtM56pIMIRTSCWomWrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw46yn9TbizQFs0A6Tnu+sUbnMn6wqvi1BdopdZK8/s=;
 b=R2UAE7q2PAq9S/V5rULJ+EgChvGc/UOmcfJyoppE4SWfqpL4LESNfIWDAy7vKvm1lHwUOnaCuiCASU9JxLrxVKXveNGEeYWib/pvDat36JDaV2xSP2qTx9c/TbpzMG2vi7ljk0pfwFHzLYBz7RT9Ps97ZCX3T2IDYmdFtu8+Knk=
Received: from SJ0PR13CA0077.namprd13.prod.outlook.com (2603:10b6:a03:2c4::22)
 by SA5PPFF1E6547B5.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 1 Aug
 2025 08:56:32 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::53) by SJ0PR13CA0077.outlook.office365.com
 (2603:10b6:a03:2c4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.5 via Frontend Transport; Fri, 1
 Aug 2025 08:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:32 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:29 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 07/10] amdkfd: process USERPTR allocation only on the
 primary kfd process
Date: Fri, 1 Aug 2025 16:55:53 +0800
Message-ID: <20250801085556.8504-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801085556.8504-1-lingshan.zhu@amd.com>
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SA5PPFF1E6547B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e833ad9-13f6-462f-fa43-08ddd0d94fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zc2OHichwI5bBgsmhZr8pVp00ST9xFpVlRn8C7WJYg/4agEVfNMrhWsqSP+t?=
 =?us-ascii?Q?tAxo7bwvTmJYXPR2wfbZAufNXiq/OnyYJacTw/IrEAhV/pbe0zYoE0S4k2Bo?=
 =?us-ascii?Q?5Ns3/f9Z+S96mSpa7E0sJQH1eTwz49txgLMwCM2ZX5haEPWk6LmkdzH04VRV?=
 =?us-ascii?Q?uey3aLyHMSWlTFkQV1sDUc1oAS5T73Mtfh1sNw1I/rVLfPEyMBrAAgonc8RJ?=
 =?us-ascii?Q?YmcLFRZ9Lt2EAWzgFKpnWvWuNa6z8WUK1zYqzyosNDYtaYftrD1jXbrRHuOu?=
 =?us-ascii?Q?jVAZCttx1oKTSUmbssKLDy/AbJ7CMAhyiFEPao6x13O08EejHEwX2Tms2PrM?=
 =?us-ascii?Q?EN+a58v3twLttkUTaFUgkJkVKTxG4Iw3M4/qmqWBfFWJXIYP9HTLcPxrr3j1?=
 =?us-ascii?Q?ZHxmOexX+WZgUc4hBUNl3Uy0oPKAEj9W0nWVRVCwMVqr+FivhNvj/EJDXkup?=
 =?us-ascii?Q?hViz1pLUOFpoP6u1CrS7g2RbzuroDKnqkKJPoLgxbWbQqagomBwA77oxkhmH?=
 =?us-ascii?Q?PyBCygwhF19q8WVTnTwFD29xFGEs77ph51QIr+7T/uVJu1lTthjpQ3RSWAGh?=
 =?us-ascii?Q?ECFWim8d6zRf9blTBe40aq4VYzjvVqWIpFgIGDjccarpdX+x0jijR0kPX9Jd?=
 =?us-ascii?Q?hU/tF29ozLIcVCymtbk3f/1U3I3n+WZpgMFuKx/PqUxmyVE2KLGsAQU1IsMV?=
 =?us-ascii?Q?rz/yNaBxtNP5Kccukfk8pXAs5eLawZYILba7UOS80KfwsbY5jmiRcRCUCWML?=
 =?us-ascii?Q?uvrvWM3LfM8Mc127+RCtVX0XlKC7QcaYQF5nAjg0Oh6mf07I7a9BLN4ijmJC?=
 =?us-ascii?Q?kSMaRZfyQUscAnbxppHCJhjrKAFqFJMrfvTYqRT4kH4xbfZk6u2/fDQ5sSEp?=
 =?us-ascii?Q?/hbGRpctRexliYJ0Ks7X68l/Z2ozwUFbLUgV2rKPhPLiSEQ5+9GUCC/PYhzG?=
 =?us-ascii?Q?ii3EYCfE7q1hwZnL7moZViIpH78AcCfxmq+6trJh2Ts/pMiaZcEreUxJmjM1?=
 =?us-ascii?Q?iVWHQNmwsC9u4DUbFZ9EaGZ8KwMbWCB1O9be6y+OcX3Gyj6dohYXtNwz8o3e?=
 =?us-ascii?Q?yv50JhgLIHGPVLfjD6uPdw3FJvyZBk2FjXs3d9nC8aifQKGOZe5Q7fxKEuzj?=
 =?us-ascii?Q?rMH9es9vPUu+x4KK4zu22o8kURpIAZC+YS5xulstjH1AYVeNqRL5lQFfVhED?=
 =?us-ascii?Q?3VP2u70DMaCk7S2S09c+wK1R45yHhkqX3bT2s084e1kjE6c6ai8OOedboCex?=
 =?us-ascii?Q?lf/GOAEcMMDpksJeExhJjbCqfBmayeJGK3JvjlTiCSJmNyL9Mw/3m9OZ3W4D?=
 =?us-ascii?Q?X5Jce/wEjEvQXro15ErYkguH+C7NIYFddNGVq5lbWQdm237KadQZKeQQuk+T?=
 =?us-ascii?Q?cGlF2MfYnkX8kc/le4rFy7BhWLnsp0QQ5myXmXaRG/vSBZzXJlru+TvGq7e7?=
 =?us-ascii?Q?GUbuKu1aPzSDOFXxmHykY6jeAGOqI5YHEEAUbC7kmPQwc2t9ljqD5lvldgdT?=
 =?us-ascii?Q?6AIa3MTwKz/Pdk4pooIv892wORuJEhxS4JYH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:32.0250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e833ad9-13f6-462f-fa43-08ddd0d94fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF1E6547B5
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

The lifecycle of the primary kfd process is tied to
the user space program, all secondary kfd process
would be destroyed when fd close. Thus only the primary
kfd process should process USERPTR memory allocation.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b1ab1565a4cd..5b22e1c47b2e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1069,6 +1069,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
+	if (!p->primary && (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+		pr_debug("USERPTR is not supported on non-primary kfd_process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 	/* Flush pending deferred work to avoid racing with deferred actions
 	 * from previous memory map changes (e.g. munmap).
-- 
2.47.1

