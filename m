Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93743C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4DA10E519;
	Wed,  2 Sep 2026 12:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Cln2tXy";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134EC10F1B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNJ4apIgk1/io4OW7FDLdlVdj1mERIWSqlfHVH9QHNqoCyLW7Gk1gR6GoepFIj0IGWGxN01QDLo/DXWidhHAiPNx1x+q5QqadWVjXdnHxcwSZOsG+rYyaGM+Ihvkf6hlh2sNvN56xibOMTWO41VVsAZK7pq9P/vVaXZSJcBrRv4SZsbgiL8abtdMNoWV1rdlUtmZHTX8bWoqMtOBV7LyLCKfybO5La8pluVl0Q5KDHw4FKsjsWUEwUUAi1ADXItixFsw5vbr0MTSuQKAojUpkG6T5PQimWmMabvCwIANiAKgT8aYUegzitDCMGoH7dZJaEpLcVJHf9XTos+1ezYbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkFPnK+PeUfUVwE8yDm0zXSh0/CwAkotNw2mlP4k2SI=;
 b=EnB3GIK8Lz9IP+IbwyP1vqQTIZ88G+eL86RR4pu38qUkM/AttDF/oQ8smCfkBEhWxr7SNlULnMu7mtAZuf+D/4yeFosOjDnQM7QJ/EIFX0CJKE+edIx1y22X5Sc6nY/xRSALygggvA2SE86MaUKwvCLRt5jLeeKPryv1GoroUIbDnsNVTU9UhkoxIS9cCxYWkxag6CbTGQ6qf7rK4DMAq88glaqfs3YhfKg0dsFxVMCHOZqev95/bJ0X8TlV9vIKyXac27pOBXmlpUJ3+2ViXX0XOvUfavkFprUqfR3MFfbOxfo8ypwTyuOLaas7n1FjoA0U3J7ezQcYnwwbRdWJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkFPnK+PeUfUVwE8yDm0zXSh0/CwAkotNw2mlP4k2SI=;
 b=0Cln2tXy07qmd6Rk4ARviK0PI8ct7RNb8ZCus+TenRjv2zAOmU/ymPK4q8D/HfWzsEJK9u/JEK9pCO0apBWTC4STo+Md85vY4fTq5UfVTG3s8rfx0lnjnpcbHgvKnGfnKyY0wtnCKarQN2Ppi6azeB1k6USva7aD/mmwDIKa8lQ=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by EAYPR12MB999179.namprd12.prod.outlook.com (2603:10b6:303:2bf::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:33 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::6d) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 12:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:32 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:31 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 13/18] drm/amdgpu: allocate dma_fence slot explicitly for
 rearming eviction fence
Date: Wed, 2 Sep 2026 20:49:56 +0800
Message-ID: <20260902125001.621629-13-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|EAYPR12MB999179:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fbac0f-f4d2-44fd-7f24-08df08f0c6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zjuwpySqJ1hGhV3P0B4pZ58na6Wiyqhhn8UHPFLR1Dr/wQDVheB1FkHN2aELy2wFntZD5xFvPBSlWbHFC1XYSmZ/AzCMAP6Qaql6y/Xz+Ogn3cjgUMkE+BEE7aS7kRwqBFiNg/JgflaL5E9md2FyX6VyzLlI+/gZH+2GIw/4xrKfCxfc02dEwhTX7jBBTiL37HKaJztxc7v+OZm5KAvqC7Uv/XtZvH65XYzxgBtv31QMXGqV/LAQtkZdjazYkh0G2KLA1R/x2GVsaEQrrqHKM/JtsK2sJa7se6hx9Q4rXmQddclhDK6nfVK9uZ7oTgWHxBMJOg+xy61UDqamzDuEsmfwaV/8fTnK8RzY4tdTRchHvtBGp5mBkJTCwkiz2EsNNcNcLCwwxSVb3KSpM6Qyqe/saJdwnhqxU8LJBXGlYoPi3q9h7VIttYyvIP9QMQMeJBbIkKDXOMNw1hX8+sycXSZZJ7EYA24IDUo9QaHVf0cvvMH6YItncE8FS42AEVWqcQuNGHfDLnPNBf0C7ST3zPBoMuO3yPTjIl/RWMHtLTnCHS1QGpfa/T0eRVPEo3F7IH1tp20TTcXkgUqCzRLuelipWMUFB+joJnbDCV+QLfcq3a8xHdIkoXYCfocHAVNL8NBaRAFLMZLCr9/zXsaLQjdcK1AFS1BvjXAzM4UzK9RAFYw6300BJ26YbzLJ1Ny9jxI9C9JjDayXDoQTUwQ3ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OfbPetZ4Kqbxdbm0uIg19scmgMMq8wpHEbXZ+Yox4nZFbsE7x41h9qtig6rZaS7okiDNE1pFn2KdPzgO82zclxglUz2rKk+BELmVyg3Er/aXDO1ft7yUls+TpK2KH/kHrmlGpydRqXStiT+m4kUqcKyulUQeSNJqMj7N2jk9I60SmLurWhZuJcCjUGkHazUh17/EQodIKVUcrc/e9c+3LNKlHz0Y8pUbx1yE+oIDAhTQUyvuacQwpBJu07jynX/+UkJJO7+CTBKDXEZYJncz09oH9McyUegJZ8DUoKCq41h0ofaPXlprCMtzjhBOXBb2wlNvlYohkETA5jd3yP93YI1Y3l6xj0WyySsRc96cD0wNe8PxT90SJLDxT/2C8e18Bfux2MHUsTlwUTvQ7BdIruJoYx3ywNAxl8mu8g+wIDj6/GygmSf9chptnpwEU+k0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:32.9020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fbac0f-f4d2-44fd-7f24-08df08f0c6cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999179
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

It needn't to explicitly reserve the dma_resv slot here, the slot
should ideally be reserved at the call site (e.g., amdgpu_userq_vm_
validate_and_restore_queue()). This patch is needed as a workaround
in the meantime

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 93307cbf55dc..11ae2558f3fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -126,9 +126,13 @@ int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 
 		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-		if (!ret)
-			dma_resv_add_fence(resv, ev_fence,
-					   DMA_RESV_USAGE_BOOKKEEP);
+		if (!ret) {
+			/*TODO: Figure out where the reserve fence slots are missing. */
+			ret = dma_resv_reserve_fences(resv, 1);
+			if (!ret)
+				dma_resv_add_fence(resv, ev_fence,
+						   DMA_RESV_USAGE_BOOKKEEP);
+		}
 	} else {
 		ret = 0;
 	}
-- 
2.34.1

