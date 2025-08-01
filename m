Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0ACC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 14:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354BB10E881;
	Fri,  1 Aug 2025 14:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b5vLNBts";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD11E10E114
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 14:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pve+MPjXbsy17YV2eFCAtntEFK2Z3XnrGI0kaJ6ppudpDA+jE6Y7tnejzR3ERIcU9t0uq6vRBbf17Da0MiVCWXM3c7IN6AUqwIFoyZcgDv03Qo1YuCR1ktU8pnP6j3wD7YFmc2qLpkGGcv/jv6J4Szv49PUlPciK3psrBvUjkofdSKFZYIJ2ttYbZhqpaTHob9toso6HiAbMBYXATAoMpAJ+qYL7RLS1NZiRJr+rh09qDV1gAVbwaBPrgPHEBHofAI5dA0O+UEhenJkyEnWL7eOpHHADBf6WdPnnGipK+LsGoNqYkoD4xR/IwTLM2KWsZmN9qkb4U8gXzrjuY56Btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bvfvmv4F/OeGkCPsT5oDygMz3Tz53NlYLselRzo11c=;
 b=S7DJvzNUZOei4styPYfHhaNvZJxZd1rq/+bwSwRm1flx2WlZo9fAhQNhWXyZ6hgofmKh6ZNjWucV0qEAh1a1AD0TnUqCPjad8D4o9qMdIe8q3p9gAX57nVNwL9wTFMxXkiNgTeicqF1AHOYf5D6pAqZO8S1VX1jMEGGeOvTwqi0jtWCZliR5zJR6vwWUkbWVK7V8fIjamgstSToE0GWp2jVpOJvRreJc7N46VMcdLndLrNBG48O+pWP2Ydun6zNZ2+cV/gcrC+2q802T11FHWfZhdoEzP2smS1e6AdwjK8QSJ7b3IlO2Nn0ncTT19/MmqeT8rXe/tHUmV2MEc1bihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bvfvmv4F/OeGkCPsT5oDygMz3Tz53NlYLselRzo11c=;
 b=b5vLNBts2hgQLFiCuLB+cX4ULyGuUxpIuf4mQinAJoq+eEvggf4hfcAUS89u+ZuAEv5PILMaRiUBzHCuMpCt4bzOXXCnsuKhhRLNDiHkFcSXrZB+swYktrEoWh8vADRByrKuQvtxeQACA46pc1p5OYfv5R6ROg9oIxI/i3NIoec=
Received: from CH5PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610:1f0::18)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 14:18:20 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::7) by CH5PR05CA0021.outlook.office365.com
 (2603:10b6:610:1f0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8 via Frontend Transport; Fri, 1
 Aug 2025 14:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 14:18:20 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 09:18:19 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jinhuieric.huang@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Destroy KFD debugfs after destroy KFD wq
Date: Fri, 1 Aug 2025 10:18:01 -0400
Message-ID: <20250801141801.130397-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: a1397730-0768-442f-c072-08ddd1064458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X2gaGo9THIu3/EPbx5GWI85sYJwwDjHwZqWtFbpW6P97RjGipJDFcm8/vVcJ?=
 =?us-ascii?Q?5WsTzhED2hop2uF9cYRvzDd3E1EwiVVMcS3K6xPdxomI/2y+gq0ncqgOK/kn?=
 =?us-ascii?Q?BpYw7t6v6rEho4e/97FZ8XDbKY3NpHlxrzpTmF28SFJc8BzRjJGuh3He6msK?=
 =?us-ascii?Q?URBbNr6TpmrSp6KNxrDYUV9iMtkaRPWicUOfxlM2oHoN30Ptu1GbDu3tFXY8?=
 =?us-ascii?Q?GdD1KNauuqxL4jedzu8BtY7QbMb/ozmoOV1qsZy87UNWW1YgfHZUKLSqM0zU?=
 =?us-ascii?Q?DLRKOEshc9l6uC4jEyhRHnxk+iWg3/iA8qjKLg9PPXdUSTmdUJmvF5BJDbU/?=
 =?us-ascii?Q?RfcwqXzl5Zs5nKekB1RzB3iLcueOP4G+mAlqnppc5Sk3+QGpu1GeaK+ChZd/?=
 =?us-ascii?Q?neKybl+bOdQOQtwNutfAqva2kIkTnL+SrdsO3wTyUmh0nydkvbSwDNv4NAYa?=
 =?us-ascii?Q?DiXO7eaceQk0PItu/IZlJk5sSiiQnZ2nnpr+ti5EaQs/cXuE1CTpdv0cO+aI?=
 =?us-ascii?Q?tG23ul2IJuUygj/ncZje4tmLCCKv2hnLAQp8zk8cPMTCzIeCelpZ3OsromI+?=
 =?us-ascii?Q?64h5TIGoczrQ4xJp1TwXd0zP2XDTAuWT1buX1dJUAvSO5dzyjAl97GpXFQiz?=
 =?us-ascii?Q?USckqEIBEHnGSKVAm10YNp7ptViUPUulVZzmeLQoIfFA3iK7x2TrdkFPX65b?=
 =?us-ascii?Q?/VYpcEde4S2R+m8llJo64eajKbCeHjKXiNAViy3by7Eepvt1FacpPql4eMA5?=
 =?us-ascii?Q?77gZrQh0dDKsTYtCn+MtEhfiC/tBzzpAZGjLzXslKl4scGp5KEsNdj2hFtnh?=
 =?us-ascii?Q?oE9Pk/CqjI4PhLhykyDXG9zQwU6BjALFIXT7Xqr8JUWY1ODdxop6eTtlCSn8?=
 =?us-ascii?Q?2FK1HXF5QLUZsGsM2AqVOAWE2eZlrM5syvNxen8Qyrh/ozFE3oRE+cd/cl3+?=
 =?us-ascii?Q?uy4FcTT9C5rCYdv8qipdHBahjgSQrV0soczTQR9TyBvIlHeXZWkNj9OgAkFA?=
 =?us-ascii?Q?1mb9bCJ8GGmHo0ss/Z/ANkIB5nJRQ3G2haCDpLoOPKl6vefuIXnK88kpR0RF?=
 =?us-ascii?Q?FecV1CqzwbbHkMNH3EcdA3Nil4JyX0sEqwV+s/unEHrkDl+BHEhuc2IDAnAH?=
 =?us-ascii?Q?zjU08x1WqWwcImlg31lSAne/wYB/kz6i5Tvdf0yEe04ALX9w6/rMdJ05gDzG?=
 =?us-ascii?Q?yw7uPW7eV6gkgdFznrfffvL+vJ5fRhTYbDt37wuzSuXBsP/xSwGQ/wq9zaBL?=
 =?us-ascii?Q?iYT5DhC2GdY5plH51HytN+x+5nNt3eo3MX5ruibAmvf7HsnEaggEA/YPqlaj?=
 =?us-ascii?Q?dLpJ8JjGr2JPbJAdOSHcJbkQwOLL+UIcivNBwBGtEszXf+PBzud0fMELUqTW?=
 =?us-ascii?Q?uXRPZOOoouvcSmXg2SMVTM9cfh5XgUSEhVvle9jKpGZ9bsn+7Q0/gzBoeOs5?=
 =?us-ascii?Q?rMFlwV7k9vM5FFpwVr8+uqpA4eR6JIrsE8tUcTq6xasEbCrJa0BDbqdOlED+?=
 =?us-ascii?Q?vTD/ntSWkqIlLf+bu2y+5IhhaHHaFE31XKg5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:18:20.2616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1397730-0768-442f-c072-08ddd1064458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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

Since KFD proc content was moved to kernel debugfs, we can't destroy KFD
debugfs before kfd_process_destroy_wq. Move kfd_process_destroy_wq prior
to kfd_debugfs_fini to fix a kernel NULL pointer problem. It happens
when /sys/kernel/debug/kfd was already destroyed in kfd_debugfs_fini but
kfd_process_destroy_wq calls kfd_debugfs_remove_process. This line
    debugfs_remove_recursive(entry->proc_dentry);
tries to remove /sys/kernel/debug/kfd/proc/<pid> while
/sys/kernel/debug/kfd is already gone. It hangs the kernel by kernel
NULL pointer.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index aee2212e52f6..33aa23450b3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -78,8 +78,8 @@ static int kfd_init(void)
 static void kfd_exit(void)
 {
 	kfd_cleanup_processes();
-	kfd_debugfs_fini();
 	kfd_process_destroy_wq();
+	kfd_debugfs_fini();
 	kfd_procfs_shutdown();
 	kfd_topology_shutdown();
 	kfd_chardev_exit();
-- 
2.34.1

