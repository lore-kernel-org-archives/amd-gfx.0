Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD9ECCD19A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410FC10EB69;
	Fri, 17 Oct 2025 08:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kXwCxwNZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D0810EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loGMDS2ksgca5h62x1JSe4inrzH75tVAKLg0UdOXAK6vw4mFlH3RMbVgYribi3EfPBQuL0p0uIo2XXXG1ujQcJeN8TZCjIrerrBAp6qREiiJkcEtsI4wvdbGq3HCSjSW7e0JJbPTyCe5aedwOB0vGcq+r/eEt46vKnt6pJMP8dVNvJEnndlQnSpsLraaJ1nTXs/Ltc+SkRPfQy5GxuvMh9JAqtDGyaFwCunDx9el5gn0+dsGgZBbVu7L15A1HABu5y1R42zXLQ34esui50TqOHq+PlkxZCi5LyBQTsrxIgEqyXreWbukq3a5YReOCipIlhFakTdSbWURasRO3ljeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hhlcg4LviI2YY21Plo2URAaEk+p1QEdbn9IQ6plIuhA=;
 b=f2X5qclXIyaIp2W8g1bZRbSTU9fMGe9zf9+Z8NlBnGQogEdcnPsTd667w89OzI69myjX7Tn73+jENUlMW223zA/q9qj54Cx4m4v98Gr6K2UTRQt3TMDAcqfp12hQ3BF47lpJeRtJ4OxwUMMGjGGaVSER2AMjWrM63s8ZcWXtP8l88p0jo4AuROc5kc8CY5E720a4obSAu1VBJGLcPnzHyGxXPKRx0rBFyf8XHWRZqA8zVtVCSupjInf4LmW0Ns58pdHo2nq4ZOwjtWgqsuh2GmXR5nzXOCrkqtuguCzzpiv1YLRTzh9uEL/uejaqTe+2twj1TILZergiSqtDmZFvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhlcg4LviI2YY21Plo2URAaEk+p1QEdbn9IQ6plIuhA=;
 b=kXwCxwNZxvbbkMWpIiAm9W9bYYU2GRgMm2IgB6NQwOHLiYVK3pKLloQnigu1CYPWh1wLGAg7p1RNQZeKEtNrmyEnX9+22tcCxfc1vTRKkxcR1r6ejEfXc3rrAztM6JPOIKpedeDkaQ4wrZpbDG5Kw5wx9Sg5YJJg0NDMK11nuzI=
Received: from DM6PR01CA0010.prod.exchangelabs.com (2603:10b6:5:296::15) by
 IA1PR12MB9468.namprd12.prod.outlook.com (2603:10b6:208:596::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 08:43:22 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::9c) by DM6PR01CA0010.outlook.office365.com
 (2603:10b6:5:296::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 08:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:22 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:18 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 07/18] amdkfd: process USERPTR allocation only on the
 primary kfd process
Date: Fri, 17 Oct 2025 16:42:11 +0800
Message-ID: <20251017084222.54721-8-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA1PR12MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e166d6-5599-4043-f2e5-08de0d593ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oiR0evIv8245k0o8rIBe6+8YDmvQMbyfGqmYL5Lv3wWJV39SyXCeI+vFkAHs?=
 =?us-ascii?Q?PRFL+y0jElvHGmSBFf8RWQQuJa0/TIYLvUQMSVNXP1x0ozjG06OiOujcPPQv?=
 =?us-ascii?Q?oonJp7qVb6upcSapiWS8Qo5KhBVpptefCyEtksYtVPMeq9+MYL9pDHdCEnDG?=
 =?us-ascii?Q?NfPBfkwmOXCsTxTWXHDq0g4wzuGqXMB8BY6rM1zJybTdMILIqsscrV5ZU9+c?=
 =?us-ascii?Q?pLJHSrAoAPkDLUWNVpRPkfSzwEN+tJuX5dMU4bdL/KGZiLH7OdfE2t76C1nb?=
 =?us-ascii?Q?S2pQ2zHN6JH4CmvPVcRqYopNe6lXznVZuNOiKQcSwE032dKnIFxLw/41BkmX?=
 =?us-ascii?Q?ULF6LNH0usX3ZweVzhFXWC5DOzKDDWjLWidvKFlGsKMujT/8Y51Hwr7297S2?=
 =?us-ascii?Q?uwIF4GykW7oOyTcvVD7d8ndeolhTtX+xDE0aDCZ0tCXF09WXQHFON1IU8JSK?=
 =?us-ascii?Q?i3uKdzBcwamlLP02zdmT/xGhOZg3vDFOg8hRhzEl/+mhgREDP8IJ1rW6mb95?=
 =?us-ascii?Q?drW6uuJAPLG8DNmuS56KKazxog9UCmXRizQ6wVdqTRpo7KA4/LQFOR1F58/N?=
 =?us-ascii?Q?HQhcpdz//UTdWILuZzGVevggwSl1wjLcx8E8J/mKSEulK+INaRCt0KX3IRfU?=
 =?us-ascii?Q?gWHR9BVEN9ogim1UK+1udVZkIYKtIP/xZcTy5Lfx5Ao+Qb7VleSkOl182FYh?=
 =?us-ascii?Q?0KHUdaxU+xxDsC7nv8Trg7bjLn10PbmshOfzaWXNOI9j1tETyfHgTPV5XewR?=
 =?us-ascii?Q?UL0q9VyLvdGZDGoYhec3TpARYOUCDK2bZTnDPfePmDh3q9K/VbXlUqsO+u+w?=
 =?us-ascii?Q?E3HLG90Gnu+awrZGR4H5gqAWQRqtVZaa1C8GyKYDvWlKPgy2c0SCPcquNTNb?=
 =?us-ascii?Q?NSRpT+5A4+P21NPfPPrV9OohJh2AmjRHASb91F1+KN+2e/wJEmdNGbenW9rv?=
 =?us-ascii?Q?x3VaV7LkDGpZRrvc0Bfru0kKysHB8PEd6d7TsgbPKOHg4J94BKF+5AwhQPPM?=
 =?us-ascii?Q?VnrwyyI9SwoRLkfLN7zzftkfbaLelTJqpWfvZQ1LIu/MmTQm48HR2+4qM2oh?=
 =?us-ascii?Q?dKSTdyChaThvjL5BTj+1lQrLwVlAZqPvKOlN9llGyyBH3vfTH3hL8X1oPZzg?=
 =?us-ascii?Q?cn9bNxL7BDHIMUanvzekv7aSQBJkFH304PGNKiNVOR2klvSqYtBtvHFB6oRd?=
 =?us-ascii?Q?8faQyeMTYes7jD/kjAcb2mKbC7ardxfvMacZq5zCbQzQSX4O/3MiXthdoMyG?=
 =?us-ascii?Q?hrruyBdLpJzMi8qAGXN87YKA51HIH/OKARZqV//9fSe2z28228hDPOfWTo2p?=
 =?us-ascii?Q?UJLvOPWLw7661Ze8tKz3xAWggnNhVonqCLD3rODn2tHxv0v6FCUigS6Ckw4X?=
 =?us-ascii?Q?u18uteGKQUwm8YJuDOsOjneh++eEH4SfzGxlm8aE12VBPLYNiAwf1yTBb/Dn?=
 =?us-ascii?Q?RoftMDY17kR2UVszgIJpC/OOVKiTpK9Xh1YasFd6pBmh/4XbmHsOvQ2dIBmH?=
 =?us-ascii?Q?KyVq1JhjD8LlGUc2jHOq8sQ64c7il3t24YsvJKU6Mo/nH6aYLAHjcteXLP3w?=
 =?us-ascii?Q?4t6ud8NXoYjoAqd80Tc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:22.3719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e166d6-5599-4043-f2e5-08de0d593ae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9468
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
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 58d90bebdff7..d1cb22f48b00 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1062,6 +1062,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY && (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+		pr_debug("USERPTR is not supported on non-primary kfd_process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 	/* Flush pending deferred work to avoid racing with deferred actions
 	 * from previous memory map changes (e.g. munmap).
-- 
2.51.0

