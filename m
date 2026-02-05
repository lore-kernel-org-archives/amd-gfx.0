Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC289ECD983
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 16:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30FB310E154;
	Thu,  5 Feb 2026 16:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hr9gLbO4";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8961D10E154
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 16:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkXVYrxXoPJJfLiXrRdea83XMxVQVOqg+bTKSCt7b3TkApnmKE8RCShtjG7rUEFfmQuNJcEeeKjcgqcGr/Di/wL2f64QiJY7taVt/8Ukj3DWVnfgKt9NFJiNO2xHdU3Z0s0acCFcSKfgA7L69cT5YehJHj2MyuRIWgFSZY8SBM9MDnV4g0XL04mVlOjhmg97yzKJdC+kGSrAlpGxWRBFsamThmp2B6gucdq26/dQaPIPcaGFWzetirTsI7kqsCRuXdzi1cKlItp1WFhIdTpRYaLcmRosS/WDsDGxccIOw7mwHkoLyTZXqOlPVK23yze0WtvN45QBhhj/UdazQHfFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+pwGnwbUaf0+8Q3xKjJglqvF0BVUhDjAnxIJkBpiq4=;
 b=RLjGS39Fj+UKhr0rAr6piTPlD6NbJgfY/lp3v1fzlzDhKh/ROVPVk0I8B0Ro1mUGwNh3txAWbUTWi12kkixkrsQrDItTaslULd02SfGCSCCDziPmaH/PltCDNy6HaavwXHYjUoPKWzd2Ev25jL8Q+96iwVX/vaNwL55OftZi4Urq2JukgUiyhvD0Qhje/WAvZIqhm/LbLO63L1O2PocFe812hWTvH08Hd2pLBeIq6WwyDt7DZgZJ9Jz7D+Q3yoaKXOOYnTY9+NyNbtLqXDxzCqDBubt2jPdxC3gPubIIWF8fxxRcVfqg+1eKRxNAN+tfn8jKHZ/SpgRRxsgiqj04iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+pwGnwbUaf0+8Q3xKjJglqvF0BVUhDjAnxIJkBpiq4=;
 b=hr9gLbO493iIguChI8nUVFcQNwxxmKYv97sv3/3jwouEhvGJG0f7uANI0XVxjxRIoYTqT3Yp6pwzwZGSr9wgWN/i3LD6EhFp42Rd65NNoC3SUeZRpH5+q0PxYNGLPL3uTiN9Gi1+a8N3ybtOXSKjJkO4yyYcL/Fna122ZNOWRzU=
Received: from BN9PR03CA0448.namprd03.prod.outlook.com (2603:10b6:408:113::33)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 16:29:36 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::84) by BN9PR03CA0448.outlook.office365.com
 (2603:10b6:408:113::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Thu, 5
 Feb 2026 16:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 16:29:35 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Feb
 2026 10:29:34 -0600
From: "Alysa.Liu@amd.com" <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <harish.kasiviswanathan@amd.com>,
 "Alysa.Liu@amd.com" <Alysa.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
Date: Thu, 5 Feb 2026 11:28:46 -0500
Message-ID: <20260205162846.106865-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6ed6ab-85f3-4ced-898c-08de64d3bff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HSBWc3Dp82g3f86O1NTtsudU0nJKAiyN7iPrHOFoZeMMlREO4eIYhheL/+vc?=
 =?us-ascii?Q?F+HBxJi1oaPJCM2qbviOuGWo5d6sYhX2hzt7frRrUFUnoHge/AYpEMAZNgGw?=
 =?us-ascii?Q?EkA6o3vPdbK3Nl3ho1MCGkHt5y33x5zoz3+HHM2MbwaDmjqx5lhXAGHv62B0?=
 =?us-ascii?Q?0J1agcaU4ORtM9IIzCGsYZ9NuawW+rlMoWiL9Xst8R3RKj1gSvxMpHp2zntl?=
 =?us-ascii?Q?pKlbVM4nsb2k/IXlRLfeAQvMnLfhiVQr43a9r0iyc5auvx775P223/P9adnD?=
 =?us-ascii?Q?muxOfC0CpO6fcAfJRaXcGUSgbbbVZPIGE4vFCfx/9pKx1109EPML0vqPRDGt?=
 =?us-ascii?Q?bETyqmfNUVhmhfPgd3pYkQwQSreW6QZazpp0IfNn15TSTBrc+d8izoolrI3A?=
 =?us-ascii?Q?eENRnin1swocMFvxE1wAtt6kBH3Lh1K07EsZiCuoRx3aIICIt5hSdYd5yU3d?=
 =?us-ascii?Q?JPgptwQCF5XGaJNnnE19sbvrwInyHjd9zLjXayI/IsizkACDEiDqo2e9Xv5g?=
 =?us-ascii?Q?5P/ld+XDOwJaG9gENAKYXkv16nk9AQ11jvMSfGjfPT2AoTA6Th83ASNxJGD3?=
 =?us-ascii?Q?jMsRHtE88uAW19j4VJz2iyvKa+aZLzB/m+ZPawqwunt6mEk3B2JXfsZ4hgma?=
 =?us-ascii?Q?8qeEAKE7xj7GB+74+FPUh6Zxk80tktggI4u5ydw88EtRooODEZyAQeff26v2?=
 =?us-ascii?Q?R8bkBpcmUVfe+ycIzjUzHpW849BMidamM2E8kU3Ewj9+Dzg6gbW/Jno7SctG?=
 =?us-ascii?Q?3trbXqvkHf3YrJ+o6M7j1yOewlFNZGGFkm6vWNZsU6ON/yWMH0x42V9QwPEE?=
 =?us-ascii?Q?hWAedzLUnGvH0RpWu9isWag/Qp/ez/PgvGMjuSrDk1/HcMHB+EGHBJcB9Ivx?=
 =?us-ascii?Q?7uLP74cWjG97Qsqwz/R/wqxBYpBhtaP1mTFAG4ekgwFeGy6fVzg21yLhHFZR?=
 =?us-ascii?Q?0s99Ejmeu3WXZGsHFWMGTQSELR3GSZ+5xqjW4B6avPuwgNLX49WA1fUzcAS3?=
 =?us-ascii?Q?cMfHMxQpSUqEg7dH75iUwrEvBymyYjckK5PC+u2xCW6+/m6YRVkmc+/n7v5z?=
 =?us-ascii?Q?frZFNu4/D99y4MOp+M5EwyGg8+2np/ZbHbvDbje2mmDgezA1negssKCVq5aE?=
 =?us-ascii?Q?W/6NkG6ggZqfgn4DHOeXKYL+0tySDpddfva1Pjztye8ovGtiB+GkLrP0gFlm?=
 =?us-ascii?Q?KbemKNHC/orIWIwTShVwzkmA6AGrOPr8JuWX8nFnit4bgNqVytC9W+N0X4gy?=
 =?us-ascii?Q?E7Z0nnAescQEy0rpFTBk3C/LEpnx9ffI2RNVbujz88yXebMgqeyX5VUaLsYI?=
 =?us-ascii?Q?NEJXiriJrgldDH5abNy4M0vHagB+4nbAYKk1WORITv+jOdhrnOM26R01nOhR?=
 =?us-ascii?Q?a3Hd3iDxjJpZ4jnS3pTCgRSBURmSFVdWzQG15Uf5asfAcFiJEKpUouKb9W3k?=
 =?us-ascii?Q?HSnx6qOIfDP1ljSMBIdx46s2dO/K5sI/sDAhWxjjaZtver80GNQ79NBMoPqA?=
 =?us-ascii?Q?CEuVgpxSNJya83dryrUOMiZnfRHY5SLTTlfYAQRR10B76+ILEn+VkU6wVusq?=
 =?us-ascii?Q?lc3eUdcOVExvXFXQvz+2NbJJAESDBANAwtYELQfK+WDdgPRX/pvjDU/AP9jp?=
 =?us-ascii?Q?1LBvNGRWbh4alZDWx4tjAgfg4ZvdgVJudehUnWT1Ggmx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hfwmzyY4K6RbtaSG6wM3zdl1V4yLBiWTgwoZWBNog6o1xeKatO43l12dKRAeHnZthSGBgWiLhFl/6oO5+cmiOkANK3UPHaIMuM9ylWZyvy8xhiyXsCc4fbmCMxY9ePS6U8bjp+VA7UyD1yRWu13bpYbOsW+Vt1t/hjwAkVTWRPTMU4Xk5xQs92OdxLCFpdan6hwQFmQ7oWugVQhyfAQJS5uc9f3t86cyRNaoidKyeCuKroTCMksxK8UL09F+VijvlfL+vo6LZY2ZfISem4Zp8EqWRUTfn7juKehtQbRQ6kOqdcpjbrUGwb1uA1qfTK6PdP75NeKnpIXiY2Zm7DrxWuir7yjiYucf4rxzqUh0QLgVQZrQNOEIjivmrJNeoFBc34KvW3DbJXUMZ/lZOrjC2/u0qR7ehb/JHk/W8KZOgDVz+f1a0F1MHM3EKTLH4MHa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:29:35.4288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6ed6ab-85f3-4ced-898c-08de64d3bff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
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

Replace non-atomic vm->process_info assignment with cmpxchg()
to prevent race when parent/child processes sharing a drm_file
both try to acquire the same VM after fork().

Signed-off-by: Alysa.Liu@amd.com <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 00ea69baa126..f7b2358a0303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		*process_info = info;
 	}
 
-	vm->process_info = *process_info;
+	if (cmpxchg(&vm->process_info, NULL, *process_info) != NULL) {
+		ret = -EINVAL;
+		goto already_acquired;
+	}
 
 	/* Validate page directory and attach eviction fence */
 	ret = amdgpu_bo_reserve(vm->root.bo, true);
@@ -1472,6 +1475,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	amdgpu_bo_unreserve(vm->root.bo);
 reserve_pd_fail:
 	vm->process_info = NULL;
+already_acquired:
 	if (info) {
 		dma_fence_put(&info->eviction_fence->base);
 		*process_info = NULL;
-- 
2.34.1

