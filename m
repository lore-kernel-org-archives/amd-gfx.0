Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB160CA1009
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Aug 2024 18:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6830510EAD1;
	Fri, 30 Aug 2024 18:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2T0CYRoR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDDE10EAD1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Aug 2024 18:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA89anyUv2FStUAB7W8Y+WZJWs8rqldHPfnGTw/fFvDp1MBsJz/UI95bLoCljz9EYSG4tChn1xtaP8rRTATAbS4FOXzkEJ0UX9Lk+5MjS45Nuw0wuwSc0S1FwjobD8YdMFx8sG/5qo/Scdadg1nEiFY2xWFEMPqnrvlAW1gdTGizM9KssAM3RHlZoJ0AJ6n+6LSHw3StjtnjConHxEMbcVia+GfaPDDwNVqy3T/ltApODHN1zuZY4fwJOgRiFgAa1uVlegk75pKfco5cJxDysblxvRmkaCUbnjXrlLb4lZSp2L8tnpebXoA7pjHBUrtUmMBSYiiVQK/t7S7lCK0qZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Sn4c5OXtlWqE3QqZMI/F0qCbkomPKfCh4ZCOp2GzF0=;
 b=nDVuPfCQpiofi1i6nblq7pyFoxTd4KgQfsR7reLC/gvpy3Y7sn5aVU/QJX9bqnwWYiQtfWvIMNQ90zf7JbN3Xb7oolR5L2hHfiWA5693wsUNsEO9vGkaGCqcrwzq3IZxdarxZ2QUGyKkShGUVdb0yqAL2W724BYGHsJJgq0CY/aw8JKcEnahY7GfS6RARc2GEAt69Fqxd5M0K4dyMJTb5cE/UKGXzrwv4diV4c5hf4JON0xeEsDBTE/N0Y21xXrQxSjmp7+mT8MxlKlYViz9oZjqBtJs7vBwHXH/FdqBJgOQXaNhiVv5YL4jM7adsMMhRXH04koyANWE7ri3S8ZIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Sn4c5OXtlWqE3QqZMI/F0qCbkomPKfCh4ZCOp2GzF0=;
 b=2T0CYRoRjrsrvI8bbgFCs2vd7if1fa1L2/Rq+Qt1NNVDvKQlAoR1YfsnOcMmmPz8ADLdWnCJg9cu5Ixyv/5n7od5OsnUTGgGcFljz9b7WwdbqhG33kaT/Lnqv3FpyA6S/G/m36V8V/vIPrkVbJBPlJ4KaZOvctjDpmdz83eTPO0=
Received: from BY3PR10CA0020.namprd10.prod.outlook.com (2603:10b6:a03:255::25)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:44:08 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::3d) by BY3PR10CA0020.outlook.office365.com
 (2603:10b6:a03:255::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21 via Frontend
 Transport; Fri, 30 Aug 2024 18:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 18:44:06 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 13:44:00 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: screen freeze and userq driver crash
Date: Sat, 31 Aug 2024 00:13:19 +0530
Message-ID: <20240830184322.1238767-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc6963a-4ac5-49c7-ed78-08dcc923baf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PEM9dSdVAr64xa5vwSrTcp6WGC0HIm6vPx22J/+E/csy7Ma4/GraOQueCXoy?=
 =?us-ascii?Q?H0jRMHOEPc/rEUAUpyPt6TTqYH8kXD2rzikg8bupM8oysYCKePJ2ygFEIUTV?=
 =?us-ascii?Q?ZkTbEgBg7lldFu7IY096AyGDQKX5J0a3b8ACtg7yp+u1Dgm0yCANWHH6+PVS?=
 =?us-ascii?Q?JdDA9slnIk8O+KhGjZsLabuJXyHSFnR6fApiQUgtrM71zHW9DEGH8oY5AGJn?=
 =?us-ascii?Q?6m+V6lNnrsq3f17tfLo1NY76TDEsrR4PGC0nZd1MAV3jpPetGl9phu4ikFFN?=
 =?us-ascii?Q?TGfxqm894Dfa9NkwItoRUVFhqVCBPXnnHtKxbuZMFKzcSLjlOn513V9DUhL4?=
 =?us-ascii?Q?WixNPmxGNO/5fynf1AYVVxSVhqoYKhR3JZo/ttgJRY6TVfo8kKdF26bd8FNW?=
 =?us-ascii?Q?VEN3cRmVNasMDiVbgBwpd8ON8jSR7DEy49jk2uyTvcIBuzGkwTULDRQJ+cDY?=
 =?us-ascii?Q?Gsj+vTgrlv8jllIA8OSq/zmff+OC1S2DeZdwP0SZPCtB1x+4lz+5Ak4gZfJY?=
 =?us-ascii?Q?uUQGH7HAI+RUyQk7ddSKMMWRCZmcPh9xRxh6vVpmPOqdwe5Pd0OMWZabD6+L?=
 =?us-ascii?Q?pR4FEq9OScpNmCrXn2n6ERmJr+FMiicBf8bT07CyAwTSoNl+aI1Sys6GAx/F?=
 =?us-ascii?Q?eS6UTNNInZ8e2UiAT9Fv+xgDtpcxHrJTG8Mtwx2KivN9O97enxd00G+E82ic?=
 =?us-ascii?Q?XnMAn4iozBCNJMYVFpmJIvyFxZUcAkAzv4kSX80cqY6ymAtkDTjES2fX0BUg?=
 =?us-ascii?Q?X3ibz78eluEGMk2jcyCP1C+gLaRfe+Qawut24WRTlLCu2OCmRihui/KCJaFJ?=
 =?us-ascii?Q?xiKe9H+1PSYaxp7i7PQHNMi6lJ/nCb784dpn0hrGXUrpqP0kUBvsMYedfIRA?=
 =?us-ascii?Q?0mVqIEUXb6koEbqA7IMUQf1SfXONerB0mATjz+uo5XlBkQpXDpECeWDzWXzL?=
 =?us-ascii?Q?rJhrMQEQ0Cr9MCh4Hx0EH/WMXCitFbZRoISJUxeB4fjnx27Wu8z7YmcWx+NO?=
 =?us-ascii?Q?IBD3YamlZkemL/AFF74sTBjCU/4ZUD0Ke06TW+swkc19BnwNTYFV1ppTcG7P?=
 =?us-ascii?Q?//V1+MG72y4rLlBO8poSQL1QNMjU23FhY0ym7bifNIB8vJgI/SqQkDxB8q7d?=
 =?us-ascii?Q?zveyvGkdLEx++eTb1P9NQjolDOsOf7Gz5KgjvMgr2a1ejjEeBVDhw1H/Z4QD?=
 =?us-ascii?Q?yeU8W2mDfQ3grDu8N1pZkQuMgCNO+dm5l3TJo2Juft+5VcsvajrPWugzTIYF?=
 =?us-ascii?Q?sg4BAeGc91bvC3Ecy2PDUxD2UtyuN/UMc0i692TV7V3EuetWFE7R0618WK+u?=
 =?us-ascii?Q?UWbG48FNf7yKYbO06lgiGSE/MMf8PLHHU5uU65vh/HOgpTxJVJhrrErUgFSx?=
 =?us-ascii?Q?R8PjszgEQEkv/T8n3tXdqLxp68zRhUKNwzTb3JpvysTL//qjEOIdCI/Jv7gz?=
 =?us-ascii?Q?+lClo2ys81tJyecXkeJUF0eQG3s2Ytvm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:44:06.7601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc6963a-4ac5-49c7-ed78-08dcc923baf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
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

Screen freeze and userq fence driver crash while playing Xonotic

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index d2e1d0d0f29f..8a3b5374cc1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -187,6 +187,7 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct amdgpu_userq_fence *userq_fence;
 	struct dma_fence *fence;
+	unsigned long flags;
 
 	fence_drv = userq->fence_drv;
 	if (!fence_drv)
@@ -230,14 +231,15 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		}
 	}
 
-	spin_lock(&fence_drv->fence_list_lock);
 	/* Check if hardware has already processed the job */
-	if (!dma_fence_is_signaled(fence))
+	if (!dma_fence_is_signaled(fence)) {
+		spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 		list_add_tail(&userq_fence->link, &fence_drv->fences);
-	else
-		dma_fence_put(fence);
 
-	spin_unlock(&fence_drv->fence_list_lock);
+		spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+	} else {
+		dma_fence_put(fence);
+	}
 
 	*f = fence;
 
-- 
2.34.1

