Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D868C44520
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 15:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A6910E271;
	Mon, 20 Jul 2026 15:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4c/HCpWH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6023A10E271
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 15:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjGo7EV5Dhyut8rywcGlSDj1bkxSiBytj7AJyJ78tS2zh1mDTdXMOsM431/UJvCdckllzi9gzQB1VtWk+0sC6+MDdqcFBzuZ7wkCsU6nOhVOhS6MCT9l8KaTmBLpt/PxfipVbpX8kSLjApX8RIaIafn2PAD7agqnLEKYxn8hA7uKACCynje2uYRqkbxgRqkV+aKPi+FuPfdmOiWIXFz2Uagweo+ZWvHGgpzbdrEFD51E+dSPprsAsAyaBuf7spiZbPrDLT9IaDTH59YsPrxsg5V5M+RzRc5B0ozxWqGY0czqzE4Y4+MuvmT8h+2yuFjm6iQ/uNfAPAYbZ6qOv2UF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7bJBKQVBeIiFmdrDxjOxE/RpnfUwV6J2qOzzERoiwc=;
 b=FCX7jRoZqY3k2Tx6zsyKTMwuCvHOkMdO2vVCk+FB41K41W3LTnlRaBlHQ8lkzKgVi1RvScOVN6OUrApduQ1T/spNDGi4Muu/OyE30IBLrtpOUT6puKLayUV9BhQWOUoF/70CDRVQCZUO7pQq3eTbhkQ+gmbaa+LmKiFRJqn1/M6J+uNmixDY/MaWgKIaTTGjHVvu85UXTzDGLZNam+xSt86eDQi2mc9PD1Iz3jxnBoGBlloLjTA1aKo5pM12SqkiNHlHzejxmr8ieGWhWhRR1eDuv+S82R7qi58SFgDku7pkcu200X/K04md3TZzdRDkWtE7/fWKrvmQm/yjyaYJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7bJBKQVBeIiFmdrDxjOxE/RpnfUwV6J2qOzzERoiwc=;
 b=4c/HCpWHthy0LlJg8QpYkYIccaYCnPcixCgZ6BLN6MpYaYI70gbLj8asraWWkEGXLCZ6Ha1VunCZSRkk9EFEFMBgmrsFwVjxL40X2AWCrxMXhnzXSjtXeE/pzX9UR2n0r9Bobuu4F0dar6BSelRdL7SfkQWnaxB71uBVhM/Fn5Q=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:31:19 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::80) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 15:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 15:31:18 +0000
Received: from devkfd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 10:31:18 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <--cc=Kent.Russell@amd.com>
Subject: [PATCH] drm/amdkfd: Fix missing authorization check in
 KFD_IOC_DBG_TRAP_DISABLE
Date: Mon, 20 Jul 2026 11:31:12 -0400
Message-ID: <20260720153112.53712-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: e28a8067-f359-46ec-b32d-08dee673f1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Q09rOswoosIwDL/1eISPlVAArAo8+MRFDk+0YwyU8WdNKAMBIRqSpu9eBdZw9X1w8/FRPdvjIbhusn2SUDdQaT6bSQnWqhaeg/O7P889LqfdZUfan9LQxukV2tqJD+Xw+i+7NepDRw4kG/VMQYNdnLCM3Jkd4lHMW6qXm8eGoUqeBmjFqYBAcNjN/Po6fgClJ3Ta34rZj3WkTVUFSpomi0BAS0PL/aM3zHMnSRdjQdsNI+4JOPrDVK/DE3/w01in/dIs0wkARDaYfvnKyC4N4ZmPaeV2nOMzTjFgjm4K3+5cgtSzBqyr2amOVH/FXnkg75bIGe7SLELNar0YFfTaZxPFAyyiO5tZ8PsGypElLEo7Gvz6dX7lbvv9/UzzqGF9kRLhQgf/1QX95oGn+uIXDAZXqhjZRf/6girjQ/i60Y3F/n3MTHyHTepzUzyp/GNopxPGWnqkep1nWCUYWNJRxPA0ekq3hSHTm+jEV88Q+gs0a4Nrs4hhX8SdBWHba9NwxqloKM7pp76N/ylJlk48IrKIZJmCewV41iNupDrnyaxqZC1Z39BWHqaqOzSjtLzGj0aFVtVDCArfsOTwJph1cAnFoPA4LPYUpXoNv8iUNNvOUIgldsm1QGIbO5ppCGvyUv4gHPQ/yaralZpZn/gB/Zwymwfa1P9eWyd1y6IIsoxn8BjnuDXPB4QVHeIAhRa9LXwSVhjRviirajIGhQlqvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uqG+HJIVfoDI8nSABQHQJpwcpSUikZg/DUuGL4eShVMmWYo/eSUbIZdXp9dT23XHBTBmYJQ4lsSafZFl2Ip2rjuJctpIOXFgBH3kUr1QQ7OcLZdGXi4NR+C/9/XApdWO3U/bWv3DZF+Zc55bcwno74G1U4ZOScbKoRw/4sMAFaDP2tLfdbGIBEPFuYyDGkAIS7M6Rsnr69Yf7Z36EpSVT0P4jTlnpQD9qncgrDZo5Y6i2hZMmeCKvWzfCoPc0fVdJszz6eIY2Iz6BEMWyl9R7xJRF3qsT87vzv6iTW98D+w/PQaGNt3we5BnieGuFWw5rpHAdQsiOvus65kOOwHy7RxiEMEau1KnYQl7HZ7RKAJaN8dqcSGTWrD2Vi72vDHOr/Z9aCu/S6nJU4+8BSSU6yEySZM7PJAZFSGrcZXRTJACWYfRctm+hSJnXcCwXchk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:31:18.5624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28a8067-f359-46ec-b32d-08dee673f1dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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

Prevent unauthorized termination of active GPU debug sessions.
Previously, users with /dev/kfd access could terminate another process's
debug session without proper ownership or ptrace authorization.

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7d058d93e219..05dd0b6a87f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3112,10 +3112,14 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		goto out;
 	}
 
-	/* Check if target is still PTRACED. */
+	/*
+	 * Verify debugger has permission to debug target process.
+	 * For cross-process debugging, require active ptrace relationship.
+	 * This applies to ALL operations to prevent unauthorized interference.
+	 */
 	rcu_read_lock();
-	if (target != p && args->op != KFD_IOC_DBG_TRAP_DISABLE
-				&& ptrace_parent(target->lead_thread) != current) {
+	if (target != p && ptrace_parent(target->lead_thread) != current
+	                && target->debugger_process != p) {
 		pr_err("PID %i is not PTRACED and cannot be debugged\n", args->pid);
 		r = -EPERM;
 	}
-- 
2.54.0

