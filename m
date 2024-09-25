Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4C9CCF9EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908C210E860;
	Wed, 25 Sep 2024 20:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iUk2ihqc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D9310E867
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DukdqW9bPY+y3sakFy9cHt6IdpUbG/OhlvYXFkpHUg/n5gh6WewhTgJk/b6XS+dJn4pp4szN860fP2zmGOj+FgMVkVnFTkXfqeI5sY0bWUCA6ZLBvQ9MkebxBHmir8tWwoi5O3VVU8oVSFQYcesvTcYGkoQtYuqOom7nHZ0pO0HJ7LaWf0qX88pIVltQhI+lKQeLXdvb7ilQC+4cTKqpYu3yJ5wxK4JBa9fpf57FXA463U8am3MpG/d/jYrk7p8yjhypprHutU8bMiwL4lg6DBtohgwpX0EmC6r3k4Vf37S90vOlOoJrctK7lujrFrmDQmcvuImuWWdBJvrCYorH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iqs0WxMhXoVbSOHzzcBT+kfhbllDHMeLQQDIiLNVSPw=;
 b=rnQYqKgyXCfoB31y2ziz2ltE3w6BpNTiRt6N+gYzOC2qnrYdYYpneXFdK+QnlJzdGOsMaP9+6jrLT7DmYg7aNKcyS+CZwnihS6Vu9my0r7TQ2mpRBW/nM9HnpMG5H81YL2wvvtlk4jG52c2fGgWIyVdy8bhsGPOfvtnfjgTDkP8TOxU+6gb/SMw4Jia+Dzu5Z7yRUYckQ8SGQGWsAiIaS/4EqggyXXMBWC6A4pL4wKKxNzx6k2V77/E/VtvVvMDPuUI8PmV6BWSGRYXEjxHIOlIs6vGw8+bF/VrWNrmVrTS8prVG5Qsx5sl36tIzIweIeclT4c1pbixdMMc5r6Vw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iqs0WxMhXoVbSOHzzcBT+kfhbllDHMeLQQDIiLNVSPw=;
 b=iUk2ihqcYNOe25M8WuSPczLNuEQZKNxe9twmedQKCFquEMoZxbm2IZtwiCfjC5o//INn2cQqzG3Jaep9UH0YdqCAT6saBoYUqGXhbm/LF3oHmSWHxGm2rmV2SiOlaglCNgl9sfwwepMNwXYOyQMJwksXO18MWahFpiRKhz9CXJQ=
Received: from BN9PR03CA0113.namprd03.prod.outlook.com (2603:10b6:408:fd::28)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 20:00:12 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::a8) by BN9PR03CA0113.outlook.office365.com
 (2603:10b6:408:fd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28 via Frontend
 Transport; Wed, 25 Sep 2024 20:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 20:00:12 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 15:00:10 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 07/08] drm/amdgpu: Add the missing error handling for
 xa_store() call
Date: Thu, 26 Sep 2024 01:29:27 +0530
Message-ID: <20240925195928.142001-7-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b7ee7e-bb25-4f16-eb45-08dcdd9caa74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c1tFaw19xIlk2TYHgrMk8b3oh00ZTpu1kKSbJyoyl/EbZRUg8UUICLeqIwfY?=
 =?us-ascii?Q?rnkKTa4hBYphwJzFAvvC5E3oUMNhNcUk2R59La/FAL3KLS3WpNGsBCMtYQWW?=
 =?us-ascii?Q?JAPFQ6r7IDbt9kwbzUpXWKERidtojesj/OdvQRgHDcOXGbQK/zuesdmrRHsp?=
 =?us-ascii?Q?283IinKf90Vqn6kgpKaF8uUb3tWyigfjOqkZKiPVIRaZ23X5gKvfvXNLnlTo?=
 =?us-ascii?Q?tAx5nXM+qiQhJNoxzvWWb5GeIrF6p2na15PxcAOKZJQqKQEzsTblvIXpIz+5?=
 =?us-ascii?Q?TOydfXIneNpLlafJluBgW1HIbsS1pt+Hn81DIl/ERebTJ84LvBnkHOV6wqOG?=
 =?us-ascii?Q?lAnr82aLftwKOxgJ4MhovSzI4dOnc91n1RyMMueFpW3b5+wXYOQ1oK/1I4en?=
 =?us-ascii?Q?8O9kL0A3+YB4yeb5zFa/hz50b8NaVF4+e5fWWcqq8V5H9YBrXDcJrXP3F4df?=
 =?us-ascii?Q?tczmaTZ1EqYQDZ0bTDVIZqkR2FNFsqNFPamMY5G3x73M1Lq3zlA/JXunBF7h?=
 =?us-ascii?Q?aSsQI41OFK2D/ceOUKF6IUIzrI7gSm0d98uyey3DM7n/ScFle6E6+ZpqxACD?=
 =?us-ascii?Q?HOq24s+Z6xdY790E0JUBnaPK5TY+rOp2yamVkRM5HeVKov72FkqwE/QaPRRT?=
 =?us-ascii?Q?4qv0YoiSzN4mEk2deV3rCLrzx4x8l9mNiU9ms3+aiTKs4nqY2wy+Wu7xT669?=
 =?us-ascii?Q?Y40OwYqgEgk7tnaj3n6KTX3M8KrDpmUnX8oqv00a/g4A4LNhZ/UM1Cf8CgD4?=
 =?us-ascii?Q?qJL29HizdV4IWpAlZ62yFU1vALBjusZPH+FuoLRtQY0EmPEOkUri7rX1bmlP?=
 =?us-ascii?Q?rupdRuUUS5o+2Nf0wtqUjrlHd0OYDrygaQq8KN8MDTDNL4i/T8qdkLciyk6v?=
 =?us-ascii?Q?eHkfDi28AzKQJwRrmqROv4Qh2gsluTkv3/gIFEmt3f1kSlTaDvLcmCn5mZFw?=
 =?us-ascii?Q?dwKyYrxmVGkD/m6js4p7tdpqDLmnEXptN/P5eIScCH+Eek5yvlaKVPf5NGKA?=
 =?us-ascii?Q?rylWY+eYQ8s/Jj4ao+KJE7UBnQmeNA5B3NrCXKsTYuvW8Ra5X6+zynu0sppF?=
 =?us-ascii?Q?Knuv9+q5RpCgcxG4AmDFLr0IFYhNdfEBwBYtCyV+dF9MEZquh4QkPEb+7Yww?=
 =?us-ascii?Q?3ny5o5lSO+E752tuMl0AqbAmVTbK+6LSIaNpoflvfjEN1m7MeT5vGOsxS7y4?=
 =?us-ascii?Q?ZIAGWTAdgcslYzW8mq+WJzFDh0j+XHMFk76/f5HgTSdgkuwamwA6lRru6odZ?=
 =?us-ascii?Q?4WHJVRmdjGwwGQBupt3xcG7QzNpwMx9mgTjESvT2ArUAgiHk28CRqjMMEsvW?=
 =?us-ascii?Q?/AoIOxxKQiOsjZwTHJH2T4BKmK6mEH8Xsbp+fg7Hxy0Sygg44YJ6GehUyXKv?=
 =?us-ascii?Q?A7FiilOTsefC/Uf0QVKuBwfhLJa6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:00:12.3412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b7ee7e-bb25-4f16-eb45-08dcdd9caa74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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

Add the missing error handling for xa_store() call in the function
amdgpu_userq_fence_driver_alloc().

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index f3576c31428c..43429661f62d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -101,9 +101,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	get_task_comm(fence_drv->timeline_name, current);
 
 	xa_lock_irqsave(&adev->userq_xa, flags);
-	__xa_store(&adev->userq_xa, userq->doorbell_index,
-		   fence_drv, GFP_KERNEL);
+	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
+			      fence_drv, GFP_KERNEL));
 	xa_unlock_irqrestore(&adev->userq_xa, flags);
+	if (r)
+		goto free_seq64;
 
 	userq->fence_drv = fence_drv;
 
-- 
2.34.1

