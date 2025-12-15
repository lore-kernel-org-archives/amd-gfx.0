Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CE7D5B85A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E284510E5F0;
	Mon, 15 Dec 2025 16:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DZR07fJo";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B778010E3C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY8sPNeu2iR68YG1T3PQ8SrwhxXwbdAJCMpwkRsUcKIIRitR/Snbvj05v5YD/WogSF9Q6Fc9vG3J69hbDRKo0Pem/Tcr+E58sIx0KW0uq6T6KQfwZpU77tq3D3jNCXjjATGs5jj/c/C23da9AyOGiTwZKW3ZiybeIJKB8jW5IJkFFAH2eHDhrohyUSZugNs/5DBMe8vbm7oSPW+Mu0H2ef+9EdL1yPtUmlkfYcCmpS+9z5Lvph1mcD3TKTcJobHwgVk9mazy0qghufWLR+sbUxHu1I6NQ7W1VgOP8ovJL4HUG7gx0jKBuWdrbM7UpKGmb2kWpKcVx5keRdGDFEz7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4EfM6RKmJAgTu+xl5RG8f1WjQPGCBjcp9vr9f6qKlM=;
 b=kks3t1Y+s03a75fFX9Y6DeAETQ/NlGejBUmV6mFfYoM+h64X4eU9UmHzC52byc+U5ruFajDJfg1QNnLSWYAry8fQlcs2xYSX/sIZrbADZcSgfbi/hVhYNudn+BcQfrhSxv6gBcsEgO96GvMuUeyrS0yWWWcgi/BRfxqwNr4XNtsxm5odFqOvk0cI3jJbUIEsotHqIjo6JarCDETX2XPyCkIg08HqpTR/SVWrkv07TchM5HR9Z2bSDZ1h305R4dTzqC6ubvygweMjmn5i6pjsZkpk34V3JxeE7rlZ8N7XxapHaEEy26pRnh0p8kK66UZg0qzfs/Cef3ZSm3Mg6LDB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4EfM6RKmJAgTu+xl5RG8f1WjQPGCBjcp9vr9f6qKlM=;
 b=DZR07fJox6iSgnlOGf5fQHZoLAJB84MhYfysFvpKyQe0UYYVxLZnSDX1oUpLNlE1rzO69ePq2NJNd9YxCEG/esW/ldDz5M/JnjP2gf1HNwoqS7Hx6G+F/8j+sc9It7xpBCziN9tkuOxUEZJ9QCRN/7hXkKtEes+dKYaY+FHZXj8=
Received: from SJ0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:a03:33e::21)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:57:07 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::f8) by SJ0PR03CA0046.outlook.office365.com
 (2603:10b6:a03:33e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:57:07 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:56:50 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 4/6] drm/amdkfd: Move gfx9 MQD to VRAM domain
Date: Mon, 15 Dec 2025 11:56:28 -0500
Message-ID: <20251215165630.1172383-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215165630.1172383-1-Philip.Yang@amd.com>
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db4144f-92aa-4b3d-9e49-08de3bfafb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JY7GIq69HA253RgaOEn79O/j+HHYSxmaATCxRnY7cByYVqFTo8UCdOIJFy+K?=
 =?us-ascii?Q?3Kr1Yn+cyNDyjRXdw/mHEQmd7ZKjyORXDTODWsb1IgFtprC6Kt3WExjZsHov?=
 =?us-ascii?Q?X51vqJsMHK6mwwX7wuF8VzvPpTqSEytCDUcIuXU0lKf3Vj9JYyAKx5ZZ7zap?=
 =?us-ascii?Q?1eEpm78PsS4VpGPrsVNFY4pWEm1Oje8DUiGlgF3o6crKPPOXvQMuKkKplF0E?=
 =?us-ascii?Q?/4fm7LUo2lR3/JQsVxc/uo0cqA3gxvUcMZIgSxW93U8aFZW6VP0NMis9UQAw?=
 =?us-ascii?Q?bzT9KPphTZ9NlJVgu5m1p1D/5Cz54gq2Pt4Y0aSLTlizzkgi/Lqyrg2IKF0P?=
 =?us-ascii?Q?jmPaE1fysrhT7SSveprwbn7HaF+ExBrkKlO1I6KDT8uo73N2nb75mSpVqmVw?=
 =?us-ascii?Q?2DmZPE2Ly2MK9HQz6uqvgfY2owpDtJdY8LcxDb0jqhoIx5PIQDFy06TNDOAu?=
 =?us-ascii?Q?12Rg3XlPHeidfH7DVccMVgMyJEAeLLovNGf4oKzAPdUK8giS7wycdChKTUOr?=
 =?us-ascii?Q?9z2unQi5WOwf7DORuzQARoNb2caeQ+Drg4vhMEe7EJixPrR+z+H99tAxICnS?=
 =?us-ascii?Q?sXgCoyaa2zH7uZrxJuDrKzQBe0C8dFNqe0bfrKz45DSJN8W2DwzlfogcQ7gs?=
 =?us-ascii?Q?DRfg1VJIvnXzEVLaGwsmTeaJYv1SB7y9eNFcPLihOeXa+lkCtbbtbVzs/O0s?=
 =?us-ascii?Q?pSXD7pNHL/2V+x9+51p0e1odJ+sc1IKWbcX/Z1RVMDO0BmQG1R2ohNKy+R/Y?=
 =?us-ascii?Q?Nsuox00yy/oiFRkPcJ32za9LsCsWwVsq8tGH9it3HaWiOOW4p21tLjspSFYh?=
 =?us-ascii?Q?mTdAMB4Aj1JOVoH7MKOYQdDUCETftGG5M8wnXPbOvbTb4IbO2oqBI0dW+2sy?=
 =?us-ascii?Q?Qe9gRTtd/E/fnHQLb9fy98rbsUAqY2EON+7OwTq2iNep8jtlgUyh6/1VVR23?=
 =?us-ascii?Q?v/edtCOXSdhTfQkL5c8KqYEJb2DNDYBR9WREKl3BIsz+iZmplTxNSG4c2V0P?=
 =?us-ascii?Q?FXvColM+SfNDzgCF2VpHbwA0QH+Lvgzp1JxtG2bqpsOTMTLEmk1S9PzTm31/?=
 =?us-ascii?Q?CmABJDjnUGMT3QUbbdMxS7vLYl+d2iwN4Bv/t3rIh0QGX95pbRg4cwxXp9sR?=
 =?us-ascii?Q?iudXnljEwEJbPg5e5WqOL1sHh6ZbygMCu0erB1AV6zQBpuZmAdtiQH/NK7/O?=
 =?us-ascii?Q?3ouzSbr5BHhvJ5qNr42uXFs+fGF9fzXagEtWjGnV0EC0woK3oB55GkLdMltB?=
 =?us-ascii?Q?+113PWwBWdrMSSOyaO0fJb79BLmKww3aruYydRtmTRjFJEy3LMXyO2My3FMd?=
 =?us-ascii?Q?WE6iIBy9uXSRtKYueYTM7XoMMI0HB4Es5n1uOypVTZoO2xQpJ9ng4gLHXlfG?=
 =?us-ascii?Q?QHKhEWwi1KUaciHFd5Bsf/YNkZ6I6VGxqDHk7T9kuuABJLtNBIwtU/fsQ2Vh?=
 =?us-ascii?Q?07/XiZ98NXzIDJFO2TLS6LBIEQo4kdclPsNwGwX7VpdJTGPcZfjMYYPwj1ZE?=
 =?us-ascii?Q?kpECdxyjojOcEw5PF95hTq52+AxZKD+qyAx15SlITS7Vc7yqAf0BPv0v1WD4?=
 =?us-ascii?Q?wITHWMaFi0mxiqvYb0U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:57:07.6926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db4144f-92aa-4b3d-9e49-08de3bfafb5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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

To reduce queue switch latency further, move MQD to VRAM domain,
CP access MQD and control stack via FB aperture, this requires
contiguous pages.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 090d17911bc4..113c058cf7b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
 	bp.size = size;
 	bp.byte_align = PAGE_SIZE;
 	bp.domain = domain;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+		   AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index d234db138182..14123e1a9716 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
-			AMDGPU_GEM_DOMAIN_GTT,
+			AMDGPU_GEM_DOMAIN_VRAM,
 			&(mqd_mem_obj->mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
-- 
2.50.1

