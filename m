Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B20BCCD19A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14A510EB73;
	Fri, 17 Oct 2025 08:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gm7rcRGc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004AD10EB70
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsqIUWnLCBO2uGBS4MZ2OBXbwm39AuEkgcbFmx7wH10rMzHNVYIfkRMy1fV+D1FF0ROrkN+HtPzhednoVCSMw5dS/Tgko7vDpoNAxGucYplETsDL1kx73itkpXF6w+eqIf4qz4mkH4eIcb/jGofuhIPUmtLX5rEizgrlAOBUZQPstLiwr8K4ejsNJQ37UDk79tjO58keukE4PzGYv1WQAVv6K1IfvSjuR8hrpTEfmMpv76NE9a14SIA7Dit7nUu9Eihq0rzTMy3gj2KfqDisnDXL7aIryamxd9d6U2SWrfxbOTP2k2nv/8uXo+4L5F4kOGtYTVJ5WDcp5zDzcuRu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtmFcs9pqcn5q4wHhAUZkirSUw1+BlblHeygLwsimJM=;
 b=iRn3xIKu0rK4b+fi7joH0up/W+qNWpXKtLgKic1WXfQxqvTHNRf+8NVgSv1sbXgvATAcnxSmybpes/kvwAAtpGH63oicRLhQ66BNcC9Oc7xNJ8dsS1R0ars6NNE/C9NmwuP8B8ur7RIx9Oy7WS1QuFD2B6Mbaegi9CwdOY4mOq+z4v9OaA5EBK0nZDBxqyuglOwkM6NI6eRCuCtK/rQ+yhhLUvdbnoHohAwS/Uv0GiAMrhFDy9QlCL3PH/s4fqSt4l3XJQ2bpcmzvFKonKEMssb3sf11lctawu2Js9+tpaaawCqEKLGy2sFFH/c8PFQ76GnFp7YGkZiB8tXOz95eaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtmFcs9pqcn5q4wHhAUZkirSUw1+BlblHeygLwsimJM=;
 b=Gm7rcRGcLpk7oHE5qZeb0/z/3uh4He7NJa2JB7rfKCbfKRYU2rkEFvB6MyvmWWFkn1GxzzY3v0r5CbAtHMxihJnWqWvL6xqIhcsoSxbPe3s4PQNq8J5OkFumTlCblcb/HPMx44tptl5afqOiYzCgzMEaTICIZkI64z6BD3MhI+E=
Received: from DS7PR07CA0017.namprd07.prod.outlook.com (2603:10b6:5:3af::14)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:43:38 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::2a) by DS7PR07CA0017.outlook.office365.com
 (2603:10b6:5:3af::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 08:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:37 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:36 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 17/18] amdkfd: process debug trap ioctl only on a primary
 context
Date: Fri, 17 Oct 2025 16:42:21 +0800
Message-ID: <20251017084222.54721-18-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d781df7-5368-4e20-7dce-08de0d59442b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?euDAWlO2/tgDIVVCgrPsz/s8g+qOgz/rwLiFRlpFuTB8LU+sgf8b5BXa+6DY?=
 =?us-ascii?Q?58/JpRpWTfcLTtjsW9962Qdrq/DFQT/8RW+Wa96uWJXHZbpJROSco5NVXN6f?=
 =?us-ascii?Q?bZE3vRass49cCixLWrIJziAkC/Wg3/h4NEB8+btyHyb5q+CLxKkURLkgkLqI?=
 =?us-ascii?Q?i+MEm7Ww6Pjvw8pJHql9Arbtv6jWe49Paunj30iZvi01aUPs3wYsvVfi+V1s?=
 =?us-ascii?Q?kjRJnxA9uKpiZTSf0G+QYAW+pTdkXsP6d59W1hLESok1SUydyD4Lcd/EocbJ?=
 =?us-ascii?Q?n74RvnTf8MqmNdlhKvIQ0P3/exram+DrZj+3L2GGBq61tlYSBcZGkuTd8gVE?=
 =?us-ascii?Q?93li3g2011zDWKTlTCt8N30c+GtAwlO7xqhdoHB25lpGd9U5aRrCXG+8d1fR?=
 =?us-ascii?Q?ND/gDqyDbd4wNjLIaEz3oNUwPVvY7k8fyKJ3TzjvGKI6H+x8WL/YX7GNb2rM?=
 =?us-ascii?Q?uKyHi73LAPwPRwxkNVWSrfw8TW4Mg7t0Pu9mfNWqe9nkMrRI35pmZ55sWJq9?=
 =?us-ascii?Q?U3SR4mbitoZU6AP0iZ7tLoAy2AuiT1gGA3VW314tkVAwv+yXUqQufvAVWRX7?=
 =?us-ascii?Q?um117Li5pMNhe4pckx+yyY1+i5FROSxNd+h5uAyGgGA2qFO8rEGATZUWeAIf?=
 =?us-ascii?Q?ia5zGEnYSuaEAgJeOtkp/1zDemHMY4rhmw567pYAk6FLSJEDYG3+JvQKqU9n?=
 =?us-ascii?Q?MXCzLTG/zUZYoPQTxnScuyXFk/iHXxieGSqq3Hch+8CjQoTuAKvVWcMRxRp3?=
 =?us-ascii?Q?/m5EFWybeuBSpwCFhTsEKhSAoGb7ddtdUsIBj6x2qa9QrYpjOPh7vER1DA3U?=
 =?us-ascii?Q?uVdG3kBSy2ZcBNTTCAy5koGEXoOC4KYhLwElXjjkaZRrqbf4JJeSs0Z1DPvJ?=
 =?us-ascii?Q?ejmRr7cfD/EbayQb87kxtAcFduiwZin/w0429RbeeZGhOAjlP5y7ecamjY5r?=
 =?us-ascii?Q?+boeSVuGPilrFSKvyE1eFijN18oqCCXKDDjAxIiPhnT9v2R36l0NZkoD/QSi?=
 =?us-ascii?Q?1BT5LuV4n5DnBqhaDqb/0wcjv/7Az5KegsLCb6xnVSeaGQcRD+Eqk7sEa2HE?=
 =?us-ascii?Q?vM00+1pwX49Trv8igvKdRRoxdPg7XzwmKIEim+6kkarP7UwA9oHmPV7uyMIy?=
 =?us-ascii?Q?QSop4XdyEI6t22rdl5LNac4j7iFwbq6hyuL6oDFkX/Zt/e8VY2E8x5qp6U+h?=
 =?us-ascii?Q?7OY3nLR6nDPRIgFbkXu4AuSZHQWLcN6QwevWSKZ0n3LWTWV7XbipWt+b0dEE?=
 =?us-ascii?Q?hEKpjUbteAX0W1VX+a+W1lUfpdfO4NUbcSVxt5fJQWdW16I03RGIOMBkneNr?=
 =?us-ascii?Q?pWVDgrxfV7pXsoN5ARkeGBFLmAMWmqQX/QXgFjVrbLpQvNL3Mm8jbhPlCXSY?=
 =?us-ascii?Q?VZPD6W9z47NuT09u6TPNT8+10rqVUJYEHToXJBZw2G+LD95pFKUSAfh4BSy3?=
 =?us-ascii?Q?v3RoYYUs6w+7myo/Q8TphUETMGMR0Ud0rK5Fn1aa9aIcxsn3z21nQwxBtktT?=
 =?us-ascii?Q?xfxkw8uaKTZ/Wd/UH3kJi+G7UyqWB0WhSGryJtWCxhoajHrv3INaMNwLV+4+?=
 =?us-ascii?Q?SRWBPBoFCmqYNUMmBJc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:37.9354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d781df7-5368-4e20-7dce-08de0d59442b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
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

Set_debug_trap ioctl should work on a specific kfd_process
even when multiple contexts feature is implemented.

For consistency, this commit allow set_debug_trap ioctl only work on the
primary kfd process of a user space program

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 73de2de8be0f..7c02e8473622 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2964,6 +2964,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		target = kfd_lookup_process_by_pid(pid);
 	}
 
+	if (target->context_id != KFD_CONTEXT_ID_PRIMARY) {
+		pr_debug("Set debug trap ioctl not supported on non-primary kfd process\n");
+		r = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (IS_ERR_OR_NULL(target)) {
 		pr_debug("Cannot find process PID %i to debug\n", args->pid);
 		r = target ? PTR_ERR(target) : -ESRCH;
-- 
2.51.0

