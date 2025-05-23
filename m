Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745BAC54ED0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 07:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D2C10E7B7;
	Fri, 23 May 2025 07:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IymsTl3b";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8846A10E7A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 07:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G88KmDsnYiwUnVQfI850B1jpuFjaBUvjyirrM0N4fwqxvQl1tvpWFYtY2uDaO5fpaWOfhP4mgIf/3/X/KL7BDRdZP4RbdJTemVHeM8CEtWb1OEpuhSMy7YCjHtTU2SH8xWb6B9xO6cVSpV0gNUkhhXbFLbs4Iax3ns8U9F3jC7OoTTm0E9nUPANEjZpgY8DNCzWd7lYVJ2aSD91px1I3QuyOL9q2DICqnkbJfz5Kwu1tHJnVgY4GUulCTVnmVgqclUqrnM26M6mTpTPF5QK5o+y/ldDtJqQcVMF5tjTC7rV/Ar1uVrUe+NhZuiHLRPeX0UH5EGxXugw6U7oScVJ+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJOBksny3run7dV2CPGWxUpqgfIhkiLq/jZ4Y2Lv/8U=;
 b=r/u7366jPfrwSzWkVZuzACWjKhLkDqIdCZ7Y+hMIbHDRKmuunNhCwMTaoRKTq17i7THXoEVcmICf7EvDGvFDEo8lqXzb8Aqn7S3imcRALuvUa2LAaxQnwPx/ETNNvsRbQVA0JoVbtD0Z1mJE2ULbWjsj4Bej0kcw/tvkt9FV5uDehOHA/0pNTo3tmU+tVbMtSmi5V5dIVnOOg9ZVVv1DdM3T//A1XQUefRLR5qoOTPV2PBf/Ue4SDXyQRz/DcUcHZj+BmfZDv4rdJrjbfJysfMnGm4OPkj9Y7jOE0R5/izxiR5J5kHUXTudYRgmwmT6Gjh1WJ4r+3QzEBEvqC6yXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJOBksny3run7dV2CPGWxUpqgfIhkiLq/jZ4Y2Lv/8U=;
 b=IymsTl3brFPvEf8KD4PT8rl998KR6XDFrhtiAnPJOSbdno818mPipGTlRMqTEaGLctItpKEXbT73XrgcQdahaHH23FhuL5D41CXR/HC+tez16mcSaz4jKLh85DeeK7DPRv2tWiGwQgLm3vYynuthKZxxZUC/vpjxLNFJ3YAHU+g=
Received: from BN0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:e7::6)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 07:22:24 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::12) by BN0PR03CA0031.outlook.office365.com
 (2603:10b6:408:e7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 23 May 2025 07:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 07:22:23 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 02:22:21 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdkfd: Map wptr BO to GART unconditionally
Date: Fri, 23 May 2025 15:22:07 +0800
Message-ID: <20250523072207.544432-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ee8f4e-97cd-4ec7-ac35-08dd99ca8ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aqiazgUWXckBeyJpvDR0vgSE3kW+e964JEL0qh0yi4nYPIDxfv3FccFkw2Ld?=
 =?us-ascii?Q?XjKUHBdon7iIYp5i9eMKlaX3625xdnGku5khH+6JdktjEkEW1vlqc8GPnEg0?=
 =?us-ascii?Q?i6arljCmWZniCOADJl/NWhlFNnNU5TxXeBeMOH8k4A2iIdEkrNbBMLGdkEpU?=
 =?us-ascii?Q?DHLeMdNQrsHOXKefFfbJO2i1QDdorwNwjGRc8EuEKiPjHO/WeAtCTkQCkuV4?=
 =?us-ascii?Q?xoRhxo4+FxriAUGZhOaQ8n+d5B0zOznDOcoJ2Iy0MOenOT83Lf4jfbet19/u?=
 =?us-ascii?Q?4sGQZecAJuNjn5HwFFqCcoxCPfJtLn5SGG9L6iX5bL5Obej8ixR3KutBoJmu?=
 =?us-ascii?Q?9dYvHuyqTbpszLCrw8RXW/8iIl+HxGSX7drjAhk3mVKOjLYoWJTdtz9hr1vD?=
 =?us-ascii?Q?7jaZfTpXVQz0+5PEpNl1tCfnGcRKmXeZ54LlxaViAigOwlNcefNAz8BM/CYQ?=
 =?us-ascii?Q?IPLEuCLcxupE7CxLDGm52KRo9wXRvnXY6w0X3jMpsxPaFG1x+f9Ih9xIw+2p?=
 =?us-ascii?Q?ofzwO+Ht+W/UqAp415OouE1VGknN14iIPfR1qTkYxwKgWQR40nb4Wyituz1w?=
 =?us-ascii?Q?HDyOfkLEdM/Mz9JVpDRH1Y/xf7150kW+J9RdVPmKwo8ftXLI3oWQ8x44O8vX?=
 =?us-ascii?Q?3vcaRzrspw9rDTBLrXUpdgem2PCsoZJ7LZIbgs+6gWguvvhk54+sSYDjxLzP?=
 =?us-ascii?Q?9p75zwYkAgg5aHiHW6rct3cgP392RWv8hXWDGE69lXKx3djSrT0k0RA30Lta?=
 =?us-ascii?Q?RzDOqgqBqvXhwp/UnUTf9Vauh4pRoWz4xuiGG5quKQO4LgvMIKmfZCvm8HxT?=
 =?us-ascii?Q?WXFgZk914yvrdchYQu7J1Z8F+QJTX9kL981bEPODehFxi/K0EwaVTVWy0a9n?=
 =?us-ascii?Q?RDRtKiFsxRC9iiIJWl9R3ifoLvlVkQp0g6lKl5Rlxy9/xsXOVYVR+l5m33m+?=
 =?us-ascii?Q?1nWlABURdifnfnJjgk2OZfvNWoVy+r4NamTVi7X2fjQJ2GUhz0G7/zDMrudP?=
 =?us-ascii?Q?6uGgB4NQhnq6BkrwznZBEnaG7TGADtlxyEJGD+NF357b01fnrM/3f6gB9118?=
 =?us-ascii?Q?1HEAGGlfWQhNEYAdx0mfdHKa1VrAtTIAoKsGrf99BptS2wcyvqCjFfnOoVTm?=
 =?us-ascii?Q?AbHzQ/CE9zPQC/5VpQXhyhfoNdLEu0FgiXD82PdmYPCp6M2GLe4sf8E3g2hP?=
 =?us-ascii?Q?4rk6EtpfuXdnsc6tGsf4U7R03ABN4w+vldC3rBYPS6/rcsgsbGU6D+aMmzT1?=
 =?us-ascii?Q?CtoAOeYbag9Vc0rKJlXXSGJwbEGNRP4m0PIcGVJroZo3EB4m7E185qGwhOov?=
 =?us-ascii?Q?ERMN1CMSETFz2v78OR5nZV5RTgaMP0/mz0dq0dGm732ZItaq3gt77UfubWDQ?=
 =?us-ascii?Q?uzukPRl8l0tkeCXKcjjjz660sLCkUU2wo60h8WZE7dmdx4lNAK/HI+EpJfBr?=
 =?us-ascii?Q?hab6KMjdCUwBhoD6iOkuM2bq3XDDa4HPWSogbm7utZaNcWoor65GX4Aau9ri?=
 =?us-ascii?Q?GIWngFiiCwT6IZg4DWdumDd+QBcESVUvglvO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 07:22:23.3411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ee8f4e-97cd-4ec7-ac35-08dd99ca8ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

This avoids potential reference count imbalance in
amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart)
and warning on unpinned BO in amdgpu_bo_gpu_offset(q->properties.wptr_bo).

Compared with adding version check here and there, this simplifies things.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6d5fa57d4a23..c643e0ccec52 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -279,20 +279,17 @@ static int init_user_queue(struct process_queue_manager *pqm,
 		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
 		 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
 		 */
-		if (((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
-		    >> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
-			if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
-				pr_err("Queue memory allocated to wrong device\n");
-				retval = -EINVAL;
-				goto free_gang_ctx_bo;
-			}
+		if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
+			pr_err("Queue memory allocated to wrong device\n");
+			retval = -EINVAL;
+			goto free_gang_ctx_bo;
+		}
 
-			retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
-								  &(*q)->wptr_bo_gart);
-			if (retval) {
-				pr_err("Failed to map wptr bo to GART\n");
-				goto free_gang_ctx_bo;
-			}
+		retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
+							  &(*q)->wptr_bo_gart);
+		if (retval) {
+			pr_err("Failed to map wptr bo to GART\n");
+			goto free_gang_ctx_bo;
 		}
 	}
 
-- 
2.34.1

