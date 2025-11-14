Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CBDCE7B13
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 14:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB52210EA89;
	Fri, 14 Nov 2025 14:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nah68aZQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD7910EA89
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 14:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwrp3KG3nQefcYH1HqlM1i4rkq4Azgg4HOtwK5bxeDipLSEaautQj3vzkJes3Zz8/jqSfxIiHHqN9JsmvAodOfEkQPJfjsSnxByVa2xehhKwv131UjBQEyPm9JzJWGXaIv9LMTd5FAfy/F64KJvWTVV/3J3+1XgWLWy67MFnq2vnbNJHgElucHUPBmewlZXI3Gqc9rwhcEUXPr2rEGpPhXfIW5F1CGyZSIMnUjckzCic569nSi7i63cPXCXRiE87L+G6PPEeam00BvIt6Y/6vgPPAcZDY3K/80zoxSwDoYXMCaEFgwvEZGlSKmRFAZeKvj+tTUQ9e30M+XqzGP/j0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqJkOiYr6cjhbfVLRveOQ2YXbWstlOWZwp1vGvHMfak=;
 b=IqaBrLPn4r3haU7v4HrEp+BmlkFt5fUk/DiwpspdAFvNxh8YNqIBeQjw3RvQm6wKHV4MQrDlJXFj3oCXPQWhNGvf/CgYO8Q4NVDByeyqZAVOEWZNXDmdi0WLGHkwC9rjzxRYVBqNd+0qdUHq9EM6EtV3bt6IB0+3GRP3FYzPJ6M3Id8XMF7xHjDiVqKIbAzG5GLsZdV6fFhRAQuEnuEXaKQOxszLXYa7kuOWJWQOL3oWvsBDCn6ADS95lYLmKj3mBsNDPMuKuLfpG6YoMKzbjHz+qNbhnpa/6qGjF+mIPZ6vMwXFDJXowVD3nen5HEoGPxLTW2V4iQ8PnovBxkQPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqJkOiYr6cjhbfVLRveOQ2YXbWstlOWZwp1vGvHMfak=;
 b=Nah68aZQZMkUdAUBqJkPqOIiKuiWzqhuXtrei+FNR6z6XUVQkxyyRUniTSlKi9snisur5n76P+fs+y/YnvN+U4o1fQKt2YyASO+uIwTlxidjsLy+XEJpbcdFLqrXWKJOF5iwJYDZdKGsOwIOqi/QT3UMFL51Tuad3yayIIhkYOY=
Received: from SN6PR16CA0053.namprd16.prod.outlook.com (2603:10b6:805:ca::30)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 14 Nov
 2025 14:40:51 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::d7) by SN6PR16CA0053.outlook.office365.com
 (2603:10b6:805:ca::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 14:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 14:40:50 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 14 Nov 2025 06:40:49 -0800
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH] drm/amdkfd: FORWARD NULL
Date: Fri, 14 Nov 2025 09:40:33 -0500
Message-ID: <20251114144033.1432008-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 85648170-088d-4dac-d44c-08de238bce9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kAt5zcX3bMdU4ig4fNOdWWE2EaMya8pb5ggFjQM2/IFwPsp3r5BuMcUrCMDG?=
 =?us-ascii?Q?3nMKkBqWTrD3vdrhuhYdb3ODABeL22yLFk65DxHoG+2q5QaLERmHYlcHAZaq?=
 =?us-ascii?Q?rx0rfTFiftLKR7CwJZTUVyv1bQRfPGQ8u8BAa+f8HorNbGvTWlnU9bcfkMot?=
 =?us-ascii?Q?/ifTouR9Wb8SxQYZjN4t95Ribwyi2CSdG26UF/utYL9sRQU6Yc8vEybuzigI?=
 =?us-ascii?Q?WdybW8taq07UjOnKhWNhS8Lhl3zm6Npi6zb1TVsVFYX7TeqHV7AiQ2YVaGmY?=
 =?us-ascii?Q?88NFCURmXb0IcbKMkr7Gm4+teQ5ZsBcP+kuBCEfm0BOLgyu7IbCRrI3jyNY8?=
 =?us-ascii?Q?bNSOYryX+KazAytS0HJULl7CROckB6JHsJJVhrBXkzeFhFkxkshDaGU7uTR4?=
 =?us-ascii?Q?S2KjK3zMI5X0U7OuTgmY+UpdvvuOZ3jTxCOnCuIfLkPeB/RKyhNuwq0/B4jk?=
 =?us-ascii?Q?ZK2UtppDnm7vf4ebWE5m1MMs/5RtnG5yqcVBBBL2VmjkVwSoqd62MPpjNDSL?=
 =?us-ascii?Q?IQAoOEWjH56Au9SLOQbO1+BkQViK4Y5J/FkYeN/+22OqQqsvWEDgUKGt9wed?=
 =?us-ascii?Q?AROKbwVtu3e2AugVibuQEk43ThoNd5SKGi6BU9qIsk8V8Hs0L+PomgrjOsr2?=
 =?us-ascii?Q?gipXLjjx8wkjc52HhQYOOy3ZZ0RepE5cJyQDAMBdm1PyGGLnVWu8Yg2BgJwQ?=
 =?us-ascii?Q?6qthn1bF4btmGFgtpSW96/wc/IO9aCQc7synrWkj4UT4M7fUftUl9nAdvEoO?=
 =?us-ascii?Q?TpFKvylEbqUoWXav15/9PHB7ksZiKkW5z4oZ4E6ElbhsPGJcGoRPAnCtGVu1?=
 =?us-ascii?Q?ztpdx0zIHq/Yjf91NqgcL+8CqU0hWoPzCXzXgvSMHVL34Ub3NFeLPYRebhLw?=
 =?us-ascii?Q?uYFRdheQcbFcq4Pnsv0P/h//+4xsK/2F+DfMfWHHm/1+MWiKR8sCmdAMBRaG?=
 =?us-ascii?Q?EN470ZEhf1SuO3okoaetMko0Mz83Jm9e+E+guHJwN4l7pDwGCq99jAjp+iR5?=
 =?us-ascii?Q?9EsiDh3M6qBWev/ZfFBg57BFPUPjcXsCTFNMqlECjqsl+ItacHUp0vRmf0xy?=
 =?us-ascii?Q?UysqrBEGMAzHm+lhY7ovnO6H32lJI6oY5Rd/V2hIY/IqElEK30X2EWOTCdYm?=
 =?us-ascii?Q?08+DE8gnojAcVnHXZKSYsZop5vCov5v0tQo6YVkvG7xYE36/BJiohoDyb+W5?=
 =?us-ascii?Q?Uj7GiWDb/ZG26gL97NOvp8gFlU91Ou46gEj6IrcXWxsh2q0dSuRq43npxAv1?=
 =?us-ascii?Q?zAaTQt81NaM7x/7OyV6KtTAH3r4t6HUJUsgaJ4wN7rNTmXq7D9V69OaTxFdm?=
 =?us-ascii?Q?+JoJg6zIbcDmwwZyakNJu+et49PhhUFIBtHvKpOFICk0VUl8WoRNw7jj0zZi?=
 =?us-ascii?Q?1ReC5XrOvb91slCcUMFKyDGftVDVznvkZbOF+ncwyfrm4sCDN622gzcJRrYy?=
 =?us-ascii?Q?qw5hW65ZYBwbedTle4hcXBr0UPZvNoMdf93M+gJ3l3qKiMgIQqVHYo9HdY4r?=
 =?us-ascii?Q?AHXrtHwndtsLZgDI2v6IxdUX/60nSkgHq8sJY4O7AaXlAW6m0yXoyaS+LsK8?=
 =?us-ascii?Q?z/z8WKMmJivmYNzYRdk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:40:50.6406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85648170-088d-4dac-d44c-08de238bce9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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

This patch fixes issues when the code moves forward with a potential
NULL pointer, without checking.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..71b7db5de69f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -104,6 +104,8 @@ static const char *amdkfd_fence_get_driver_name(struct dma_fence *f)
 static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
+	if (!fence)
+		return NULL;
 
 	return fence->timeline_name;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba99e0f258ae..42fa137bdb2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -517,7 +517,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_topology_device *topo_dev =
-				kfd_topology_device_by_id(target->pdds[i]->dev->id);
+			kfd_topology_device_by_id(target->pdds[i]->dev->id);
+		if (!topo_dev)
+			continue;
 		uint32_t caps = topo_dev->node_props.capability;
 
 		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
@@ -1071,6 +1073,8 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 	for (i = 0; i < tmp_num_devices; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 		struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+		if (!topo_dev)
+			continue;
 
 		device_info.gpu_id = pdd->dev->id;
 		device_info.exception_status = pdd->exception_status;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f5d173f1ca3b..f40d93f82ede 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1685,6 +1685,9 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	struct kfd_node *dev;
 	int ret;
 
+	if (!pdd)
+		return -EINVAL;
+
 	if (!drm_file)
 		return -EINVAL;
 
-- 
2.43.0

