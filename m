Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80402CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022C310E813;
	Thu,  6 Nov 2025 06:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1pHHkyFI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2B310E813
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBrDruLysUpYJLgHL3ghzSkB2iYTIRNcXMQt4KUwsCpUyT2XuIQbVQWLEOB9gi+Q/B96GzH7Mz0i/ID1KYeOHILXl6tmHuWPBYdzeRRnMjFApk/2d1OTbWl1CI5SgbYUp8ngNykkh2EEmv02Lbqi9I8WnOyxpzEMc9PdGxZg+js/L1vC5jvbRabeNynmCYsnPN+A9xXH4oPC5DxWhaXE2KeijAq4GDwHhCJ8C6D4bVn9U/lgYQVfwGTLfqtozTgwrBxK5yilg239ENZQctrmV+M4+3R6Rd2cBNf8shgJUylW1YKVam1UmPqxtmR6wtPmfyQlusBZg5CLA3H61oi3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOxt/nwvCnLNWqLKPFZ6IdTCHu4VvgrKGRs7yfYpYSU=;
 b=sVJcPt3RfQsWI4bVvyADuLXfFMdf/2B7HK9bx4ruTedb6QMI/Uar3U03zHUP30qi67hp/9VMeAaEmQQ9Q2hxJ+wxVmskpcMyIR0Lwf5Z3z1VWNxXC7VO7vyyDMHYM7hj9TK9gY+yuYRW7VvnK5byDIoDhCm6yNoKSofVPK+wgh67LVtvO8p4TajfZ7miN0+niyGOACooKokLGsv0l6g+LBjIb0wd7Yp8OVctZEJVSimtq0MZfoNN0DCfi/IgpmGDgw6eMUYn0YN1Z//7rTCrExQKB5WVm5CCmItFXWv7iZ1j4FeMHZ0BgFkPkVYyal6VFQWjdKZ4S+snNIEvJzVkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOxt/nwvCnLNWqLKPFZ6IdTCHu4VvgrKGRs7yfYpYSU=;
 b=1pHHkyFIopMry5r3TWDCCAs7RrMMILFnsfW+FhXZr8FHSYLb3Sw7y7Nzuw+mYilrjwuGcTJ8ICcSvdxwduqHPovCzX6oOXIk/hIOth1X20dV/+uzGJr6HA8+wGSgvmgNeziaeLwUfInYqM+GaNq96NKyMSk+1uSLp/iuD3oJ/Eg=
Received: from BY3PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:39b::9)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:08:30 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2f) by BY3PR05CA0034.outlook.office365.com
 (2603:10b6:a03:39b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 06:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:29 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:27 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 14/18] amdkfd: record kfd context id into kfd process_info
Date: Thu, 6 Nov 2025 14:07:35 +0800
Message-ID: <20251106060739.2281-15-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e91056-43d3-451b-3b26-08de1cfae870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZQm0QI6vxSAAIFj+Yv9m1HFlBHldmmGkdtMMVOTxFKjQLuv6QCSVz6m30EcP?=
 =?us-ascii?Q?zOCUR+cOPzKSybjFhYwA19oAZRrDRR+5gwQ6DqKyO6YI4jvMUph47f2PoRPO?=
 =?us-ascii?Q?62yw2jjEglqUFNAkEApx1MdP9vFA4fHc5b/Zepw7SwgrE8fwNhrh7Od5xmx2?=
 =?us-ascii?Q?Jtyhi8MAS5U66cZGcUnMvjttqL/ev3m16dJfdVFLsqti0ABW+lhu0VbmpH+9?=
 =?us-ascii?Q?X59wM/sWu1LluEAWeWqcN+nrs0M4z97+0xGbFNWSW5LIJig8p42fw/3RXAmy?=
 =?us-ascii?Q?jSX604PniNX6UGLmWmSjfTrwqnBZ6IWRUaYB5+As0k8Zs07+FaQ6l5oTgSLS?=
 =?us-ascii?Q?yayjv/Sga1/MiO6dC/FtdQVKyzcvfocoU3WlNIBXT/p70B1qys1J7bJ+e1Jb?=
 =?us-ascii?Q?Ei23eurjVQdY+/62ujnXaVJSsLB1AbnQJvZp+tjIEsP4WPbwFDQVjUzFVn6Z?=
 =?us-ascii?Q?9OreqC2LyKeZtnGZ9tXZrEac5wIt+bPOFVc798Y0Z9wXYO4ZIScQQiwDOaV3?=
 =?us-ascii?Q?Ov1WZ5X2lKKvnXl9M7zddygxrloehIcNPS5gFn6fcXxkWCwt/ktHbdG1+3VC?=
 =?us-ascii?Q?NwPXcngFXZOJqj2KaPzMiHcHzcJJew7GKsU0gn4rakzMSrfT7djGBkoLz8Jq?=
 =?us-ascii?Q?TMXj2wImWtdxeGUo0+raJlt+UDo7+CDHJd0xEGjRiX/8oNsyKeabKFwFX0+6?=
 =?us-ascii?Q?wW0fZVDacz8si67mW4cxLJI+6vs57Rmaow8ItOFHET7GsJ+PN3uAbNS85Ts6?=
 =?us-ascii?Q?Ps0T0905bD6doXRWw+wAbUNsAiYlXosxiY/JGIGkQS3JgQiOhkF6D/IASEBl?=
 =?us-ascii?Q?eNIL+O5cVZGn07PcXVkS9opIw9fDSATg+0UcWdqNXq5VJfvP86R1I/tCMW2u?=
 =?us-ascii?Q?mbHqyK3eBbfoM/Ym6Mo34xavrJw8ZGWnhxHGxIvDc//VngjK4BIq4Ahc15VY?=
 =?us-ascii?Q?9t+8xL87+qi+Tp+BjHg16PVwyV5QJw7rAckq66Q1iFuRyD6kLC4MkeyL0BnK?=
 =?us-ascii?Q?rOp9qEQDojmBNzua0FWYojAx2kkBxAK0qPjy0O7DRgd/4VVjk23o/Pgg20K5?=
 =?us-ascii?Q?VYEM9z3lSQQ0vOwBoIz7WKnZPu3QPbpR3plO11RatvUULOpKE41F4OV706Bm?=
 =?us-ascii?Q?aG+cKnhHu12eGTPET0vl+C8teZg/rehryYg4iiqh1BX6py4aabFHyeVRH3OH?=
 =?us-ascii?Q?iH18T0q7akiA66tHXgDCqg9idAnKTtEWOiZJab6ayz+DG+lcjV2BAnwNazD3?=
 =?us-ascii?Q?0+E8iMX/BlNi2H04eUzNqaU01q/KBUQjxnXMDJI6117qq7JxRr9FOD2GcjvK?=
 =?us-ascii?Q?sbV/lxw7gaxcIUmnsgwiqsZ79kwFMAGSB5IXF1gLvMzt9L60syWYPmHAtsg9?=
 =?us-ascii?Q?e7KY93djiHA7Y0YicdNmSaIyvKFME6S0AsjyYmkDhWlzkPHcpCzEBhD29MD2?=
 =?us-ascii?Q?7UHqb5QJzC8GtaQUlqnFW2NIqePGJOJTjNpusCkZoQxIX/cG5ntUMY8roDGU?=
 =?us-ascii?Q?ffjviXtfTJBB3nIiy4qxJsds7fGh+Q6CiwSbo/iwNf4wn0QUax5gOH7n/uu7?=
 =?us-ascii?Q?p9ariyC0wb1DJ5llyQQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:29.8907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e91056-43d3-451b-3b26-08de1cfae870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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

This commit records the context id of the owner
kfd_process into a kfd process_info when
create it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 9e120c934cc1..28b54d7ee1f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -148,6 +148,8 @@ struct amdkfd_process_info {
 	/* MMU-notifier related fields */
 	struct mutex notifier_lock;
 	uint32_t evicted_bos;
+	/* kfd context id */
+	u16 context_id;
 	struct delayed_work restore_userptr_work;
 	struct pid *pid;
 	bool block_mmu_notifications;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a2ca9acf8c4e..722440d62290 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1386,8 +1386,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		       struct dma_fence **ef)
 {
 	struct amdkfd_process_info *info = NULL;
+	struct kfd_process *process = NULL;
 	int ret;
 
+	process = container_of(process_info, struct kfd_process, kgd_process_info);
 	if (!*process_info) {
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
@@ -1414,6 +1416,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		INIT_DELAYED_WORK(&info->restore_userptr_work,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
+		info->context_id = process->context_id;
+
 		*process_info = info;
 	}
 
-- 
2.51.0

