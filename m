Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB098D2F7F7
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 14:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE5B10E26D;
	Fri,  5 Dec 2025 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0iWMpCcf";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E553A10E26D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 14:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOU7maRxtZYGsWtKLBmUXyEkM4sgicNzm2ZwUiiDxOtChazHQzboUy9/SbfqSPIk55w0L9RBpJJOxSFVsHqdSzBInPlXdrTpbp6nHZtMmXlYrWHnCOKPqSr0A+IOIom0U44z6i8ZhkGhxrjLRPGPF2Ff1RsxnRxc0+ah1u/w448iZkoxFtQO4gIDj/l3icwN+bnNbrR3U4WRa3v2uRXOcyVxUUjZ/3cfmNHv3nTTlohDguGv7rXMjaOXyZJeEo58T15Y7eIplWtOsB8LovaUcZR/72l6V/VllB/M/MrSmVTqhc88Zmz+6c5RANTi1JBh3Ss+dC7iXqBWl0IlcizdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yVIWi8vPyxSpxBvAPYbq/+eK1SazIjiGXc1aZJwEtM=;
 b=AxPQDaFqHmHaWs6SgjPArH/NTO9LPJ1wl6GmwpbyWgyIFkaOgI8OnapYBimhMNq2sm5EAC4LQTdfkFtJfnMyCDjcdVegYVn1VcdsxCraWIBX6V3ispGA3ZSXuDPwpeezSzg6GBtueOxgki5yXuCmBYPU0jL+pwQ6P30jL3CGYQwrA7lJx8Ew4LKUHslvCMMUwcVXXaxITFovMiPJ0wj6ZnyTD+jXXiAqzNqwJMsUDeOEFPRbzppoC/YW16eHTtSSN87Y1UuMoOMgyPTknbMomcQpQEPoQXz3W4c0Uk+iNi0cpJ/tIuO79EF0SjVQsEFDbxeHD6/lwXJkJLp2c07BVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yVIWi8vPyxSpxBvAPYbq/+eK1SazIjiGXc1aZJwEtM=;
 b=0iWMpCcfndWt988Ww+YzxaXeORIhZI2g/oEnBQDV4RmulTmg1D5YxlSzJLYdREojxQWG2yO/yXrBw+e/D7UfG57GltUk62XkzGY4PlbvO/j+K/E0zSe0GjvP3w1FKLmixULTHtf9Yy/E+U5VXkmP97Xpvo+m5t3gGC+xWCglEHc=
Received: from PH0PR07CA0089.namprd07.prod.outlook.com (2603:10b6:510:f::34)
 by IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 14:05:08 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:f:cafe::9e) by PH0PR07CA0089.outlook.office365.com
 (2603:10b6:510:f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 14:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Fri, 5 Dec 2025 14:05:07 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Dec 2025 08:05:07 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Stella Laurenzo
 <stella.laurenzo@amd.com>
Subject: [PATCH] amdkfd: Bump ABI to indicate presence of Trap handler support
 for expert scheduling
Date: Fri, 5 Dec 2025 08:04:41 -0600
Message-ID: <20251205140441.2094767-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|IA4PR12MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b8b307-e277-4b9d-4539-08de34074bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2z5RB9FshmcJ7HOcFO+tL3+r573hM7tfaD9GnuVk+EkmTm50aTHvoytM+Gin?=
 =?us-ascii?Q?6Sm6U8ED0HEJOart8+fLVM7BrIJwS191fgn3PA4v49lppuSW8D5EGONnrg24?=
 =?us-ascii?Q?MGvZDvqC7KL3+riKECRDeaEBwiMUTojfft2QoIlEPcg1iMcEAcsqtKPivgv7?=
 =?us-ascii?Q?iNEbe8k4qmmmTE+RWluLMyEYVg+IlfHxG+Jw5tNjWTRqj4R/HrBDcQE20yPf?=
 =?us-ascii?Q?ccmw56VmBXmwfOoP6ohkcdxcgx78/+AYkW76f2rF9tB0jIspYa+rGUWdg1LP?=
 =?us-ascii?Q?9wouFR6vkDgOZonK6l4qWlagkSWojOBkRidNBCFSCZPqLFNfav7d0JPgWerc?=
 =?us-ascii?Q?M5IWo60qqHTHb4zSaB5udkaTvxXbWIT8Fx+MQBDfRiiJrGBMxmGVM7eigFS6?=
 =?us-ascii?Q?jMfaujU4c0RffVGnroa72eO8qItQz6r99oICEkALEn+QwBrkiwD26Jg6tCP4?=
 =?us-ascii?Q?uEwQeGkHadOPrX7oKv2d3XXd2V6nYjRJzT9Hm7nIVpCrNdhn1uVw5hej11xG?=
 =?us-ascii?Q?h0ZnZrqM/qdNL1eB36LKc26THPwPw7+QKvj0KtMh3Yypdml/wZgeJPx8LNd5?=
 =?us-ascii?Q?IwmP2U4EI3z3o3ByGeMwdaUh2+XPRWdXN1VwAMGoNY5VZauDDvPZsJ0evDWL?=
 =?us-ascii?Q?w4DQLHSToghnXk9MGZ+Lc4ND0Q4e05fQEDqWQ+3ueNcY34OFRqo9Y6EVR37q?=
 =?us-ascii?Q?Qn8FeLJZP/EQ4XgU7wRULGSyAgB+LeAQKPho7sTJUJmRROmusnMjrYlDOcO6?=
 =?us-ascii?Q?Dx5ZxyaP/XprJNF0rWElb6SQ16zDqYRgY472PB6jg6Aezbuy6RqEYdjebq3p?=
 =?us-ascii?Q?Ti2hwpewS2Xt9vso5Tr8pI4o9pq01O20GKtHC2xg4qDSH6rQYfhsWQIehrWg?=
 =?us-ascii?Q?DaPosH8qQ7ZA51lB9aKhH7ADZiW8pTb15B7vH3Q05wk5Yi8kAXswgXk9evcd?=
 =?us-ascii?Q?DZAXR10DEyvlQ67tJyBuQBWdErMALjXlOFAkya7KlAOLnLiui+T/f25pofBc?=
 =?us-ascii?Q?uJiaGJkbLmU3Z4ffPN/9UsC1SJISNQV7VcBVnNUrHDlNCLbg40CzxdDT/y5j?=
 =?us-ascii?Q?HpNLf/dVdEXJBXfOgX7vNZKaJLDd64ldr2CSdjrHl/YBTEBX6F6OILUAPA/2?=
 =?us-ascii?Q?OwpPz0zCc4ug0sVeuQyiXCXcnOqSnz1Jj5EfAB8AhTRa1uUD4yuumRta1VM6?=
 =?us-ascii?Q?Wtpe7jtP7GVqQ5q2iXlZz/wH7CmcsmxY+bzc5d54U8labYHCDlWGveuUY3NQ?=
 =?us-ascii?Q?UYoumiczhzFuRWyvXVLEVqDqbbHH7mjIZDDzRIqDdq6iPw7blfP9dFbC6gFz?=
 =?us-ascii?Q?6nYIjnuGortFkQjQrO5MZsX2/y1EcgfQX2cuwG+DvvtnJh/qQAyXNOAY5C1d?=
 =?us-ascii?Q?QyxuGHh/6jLyEwqVw/sb4oVbXM753M8OKoDal64ax8H/ibxxE3tkV95nz+oq?=
 =?us-ascii?Q?Pv6k1+IFjUWhuriIFgPvm5AE+1Eskd2seO2pWXM44NIbQlEvc6WV6R6qf8Uc?=
 =?us-ascii?Q?Lju8drTNcHgdUV70wV6xVk3cdmrjM78kn+VG5MTJS7Hg7Wb6xBhE42cd2lKF?=
 =?us-ascii?Q?XP19oAjtIGuC2lkeXVM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 14:05:07.6481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b8b307-e277-4b9d-4539-08de34074bfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9763
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

commit 0f0c8a6983db ("drm/amdkfd: Trap handler support for expert
scheduling mode") introduced support for a trap handler when expert
scheduling mode. However userspace needs to know whether or not a trap
handler support is present.

Bump the KFD IOCTL API so that userspace can key off this to decide.

Suggested-by: Stella Laurenzo <stella.laurenzo@amd.com>
Fixes: 0f0c8a6983db ("drm/amdkfd: Trap handler support for expert scheduling mode")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 84aa24c02715..4d0c1a53f9d5 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -45,9 +45,10 @@
  * - 1.17 - Add SDMA queue creation with target SDMA engine ID
  * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
  * - 1.19 - Add a new ioctl to craete secondary kfd processes
+ * - 1.20 - Trap handler support for expert scheduling mode available
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 19
+#define KFD_IOCTL_MINOR_VERSION 20
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.51.2

