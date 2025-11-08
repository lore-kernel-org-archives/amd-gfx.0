Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E30CCF9E3
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Nov 2025 00:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53ADA10E143;
	Sat,  8 Nov 2025 00:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ewYVsnnQ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084D410E143
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Nov 2025 00:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpVJFX1fX5y3bQc/qfQArviFDTNUDzqKi0J32hi3s60HUxWnoA78Alo9Bj1FUDZZme0RmKtvCH52O9RcMaSjr7J6ZL5IPXvUz9wBFb3J8ScVE2VX7YUOTOMowqk8PfnOvu4LPpIyb2fagdakWONks60ofvTGPb/0ABumnPXYu5uiKMbS5NSCsDY8FtPWJwAB5wRKH9CTLrOGw6wqqYmeJzd7KtUrm5MbWS1ThPSkljU8DRTvNszWH0ZhuuOz5nLqP84A6ohb0DqTYh6ao7AcRd+JrYeMqa+scFCvSrWYicjzVU4XjK3pUdwV9jQ93M1Hc+Odz8W7gPWF03HQJf0gSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4+/EWob/gcPIFHrisaITIZs61xjad6JIA58e6H/BlE=;
 b=XDrC1O7HXIgwaYY/HuLKNa9KZRa2qFlY4uzaRt/uV3t/i0M9TMK2w59NeStqQ/TtyLo3I+l44xXe9oo5dI7+4wepAlAJlXfDVtJrwM01DuC9O6E6qZLQUYk2e+hiBIkCuJ+wuWUNZqwVG2jJ5j0jBvd6gTyKc6Bp8ADtH706WxdA23IHt1NnZ0l5p1xufWS8lTXV2j5kdLcSFS/If/xz5K8/qXpQIzHBC5KOZ4jO0RqNb4l/5CBr7YzObZBoUBVKzK/K8LY1MqoA5meXforAsgEEswsrPpoMFxb8WKhIalpIrMggJu44f++ghEy3r0fA/zS2vUXzPa+2KOvTKHMWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4+/EWob/gcPIFHrisaITIZs61xjad6JIA58e6H/BlE=;
 b=ewYVsnnQdGbwgRrGqzZNOrUhGaMuOZmPvcMeZxFlqCFhs16/6nmUjbEsfF0xvdQ0RviB6qF5nQQorIwZmRuHleICrePvmw1ycxrQID5QXqtPz8BoI/vCzsjIQNXrEmlsTBoF2LMM97eki85bOTguXmd/US127eF/bi4BZ2CxVIs=
Received: from BL0PR02CA0110.namprd02.prod.outlook.com (2603:10b6:208:35::15)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 00:57:26 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::56) by BL0PR02CA0110.outlook.office365.com
 (2603:10b6:208:35::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Sat,
 8 Nov 2025 00:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Sat, 8 Nov 2025 00:57:25 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 16:57:25 -0800
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Lancelot.six@amd.com>, <Philip.Yang@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: relax checks for over allocation of save area
Date: Fri, 7 Nov 2025 19:57:17 -0500
Message-ID: <20251108005717.3414138-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: de6f9778-04fb-401f-5dc4-08de1e61c88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XNoBE15WnkYYfsU2qsjg7HvPLstPQBxSKR8ptEYrAN4nwUyTjjGjOnkc3Y2K?=
 =?us-ascii?Q?YPc3MeflCw1AVzu1iNjzx7d6uaLzD2aeZCe+Nb18dtUBlYO5ZI6sLFpX7wS2?=
 =?us-ascii?Q?l1Uc5CBviW/7Rwbz2fi7w+CzEHXip4wu/UJ+V+2n0WElYSmnkp3lCX11Ayei?=
 =?us-ascii?Q?N6z1QWJI+onZrGa68m3K88DCYfhg0+wemkIsmwRu+U3V70OIysFWga6cOSkX?=
 =?us-ascii?Q?2TdXdoamuY8h7HouhOxEPRRrkcQdlKGraE71nmK+aVrQl4XLpni+QiaX124u?=
 =?us-ascii?Q?J5RwpaMFxHCVOr3fU9HbsJn//HAC4Whoj0UiplxY6PUP9pXFfWn6AeTCTndJ?=
 =?us-ascii?Q?2m+AWtjiHS1eZV492xnjRSCMzhqJtsxZQ5J3A0bk1NlbiMpht042vQA0/rd/?=
 =?us-ascii?Q?aW5SYPgf5zBZYEexkTRUUlOPS6kdDQ9QlRABRFDx0eAbo8KvJUs/6SlokRM1?=
 =?us-ascii?Q?mnNdv22r/GYWJXJHpRCwtUVupMiFQUvzFAu2zwolu5/fApLMeRb8iVGGIfGN?=
 =?us-ascii?Q?PtQvUlCEpenExoEG+Pl+TQvyn0t5ykPzfJa+9yHFs9rD+3ZCZlwFawsBRIaK?=
 =?us-ascii?Q?J2InP1PGQIFWNNOiTRnhTPCzj0v20yKDaxwrUJX1CG4Mdd4c+HOzb47uuZCw?=
 =?us-ascii?Q?EmAjXAhOys/adNjj4ncNrdBMY8iRYaDt2aK+9vSjYOjRxlaTPOMnWKAOuYAD?=
 =?us-ascii?Q?t3kSNX6MyK750bCABIF2p6RjRHAMu5Zw4kvPDBofAqgJjOYFi2AQ9kO/9cNZ?=
 =?us-ascii?Q?6fXAW6OVTM+atZDtNXBy0zjotqiMMlyC7KjqpBQA571nTkMYDQmwrFKEhUhU?=
 =?us-ascii?Q?+NzK6K2w6g/Sx+djLeMWyA7ztfWATj+VVtiGJHcrFBs3FFqH2OMGayN5QPGo?=
 =?us-ascii?Q?oYE8AzLarI2XMzHVL0QnQ0g0EI7fErexBZjz7SYEhtmHX+UoFUOEbMmiHlVT?=
 =?us-ascii?Q?rzE8OW/edwKIrDC9R8wlhUqYOBKSRsfNO7svRl3ZqVEHwtNpuztYNHU9XehR?=
 =?us-ascii?Q?ObUIyI0qz4Vx+xoimPCUYfwjC8IeZGbS7hPrKXi4YX5G6MVkUB8PitG44kXh?=
 =?us-ascii?Q?mtkrzmrcB+GHQZAspE1s9c0uPmcwK7v8iEAnBhFiO6tRHPSkgGhIdDiS+p82?=
 =?us-ascii?Q?KeEDOAEmiq0UAN7wWroRMENdfthVviLB1DK1ZODhmboTqgoqemM+dybtM8g9?=
 =?us-ascii?Q?tm5eSUS0OxahXEoCM2RxiD4r9DuK9DTGUfiy/0rWFgMFoCO3hhgw3q+zt8al?=
 =?us-ascii?Q?+AZqaHZmBwsQo9bAd9rLJSCW2kt+i2qDMCS9fbp85o9DPwmHSnqCvTPBt+4s?=
 =?us-ascii?Q?xvBP4p7/2cluctwmQZKqVyc3dgoJozccINUgntBOCWOExWMdKUE//0YR5hSV?=
 =?us-ascii?Q?iSmV0qFXf35g7CwUnYJgcUPfe/GEqF+1nVdDA4f9PkKW/KpKtkcLWQnENstP?=
 =?us-ascii?Q?9OCaOOMRReNx2HSMnwgmk78Y/kfXVitz3E3BUxsKtrZubVFwF2dfe0zmixtc?=
 =?us-ascii?Q?DqtlRmVgQCLHSTE212C2XvXYQMa5UN5Z3srcVJSw2D5c75plIegkU+/HwC3o?=
 =?us-ascii?Q?HaQ1gCwTgcG/3ytF1HE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 00:57:25.8122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de6f9778-04fb-401f-5dc4-08de1e61c88d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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

Over allocation of save area is not fatal, only under allocation is.
ROCm has various components that independently claim authority over save
area size.

Unless KFD decides to claim single authority, relax size checks.

v2: remove warning

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index a65c67cf56ff..f1e7583650c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -297,16 +297,16 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 	}
 
-	if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
-		pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
+	if (properties->ctx_save_restore_area_size < topo_dev->node_props.cwsr_size) {
+		pr_debug("queue cwsr size 0x%x not sufficient for node cwsr size 0x%x\n",
 			properties->ctx_save_restore_area_size,
 			topo_dev->node_props.cwsr_size);
 		err = -EINVAL;
 		goto out_err_unreserve;
 	}
 
-	total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
-			  * NUM_XCC(pdd->dev->xcc_mask);
+	total_cwsr_size = (properties->ctx_save_restore_area_size +
+			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
@@ -352,8 +352,8 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
 	if (!topo_dev)
 		return -EINVAL;
-	total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
-			  * NUM_XCC(pdd->dev->xcc_mask);
+	total_cwsr_size = (properties->ctx_save_restore_area_size +
+			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
 	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
 
 	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);
-- 
2.34.1

