Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C9BD374A6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5439210EBC4;
	Fri,  5 Dec 2025 21:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8xHifPQ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E0710EBD1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umqWESyE9TbW/38Oh1TRpiuGRG0hCiw4WU5Q0RVIRoqDE9ERATx1GJrsgn2tPhq5/S7Lx6UOT1pjuLDYpukzony8iyzgaudvUYcbKlfKPZwAg1sASFPoIQB7HCybHUY3KH6enlyoyMAVEsDyA3b7KZvDjrKxZ7OnhTEdC/HZ29AzD1eM0UT4sYcHmNSO/+MQOfnPn/dcfY6LgD1T+m1SygC2aHACYYyxPg30AXsTuO7RGOsmfEGVi4dGWtrbkOG2+yXDjhGR7++fiaX6VdWKhNftunm/cm4cpF6YFTr586yeS8zOtGrInsPVk/EvYs6K+qPIZl73g0xY9D7WcvkoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4EfM6RKmJAgTu+xl5RG8f1WjQPGCBjcp9vr9f6qKlM=;
 b=nKyRjnAfUT9rhr3RZOyGY4LRDp4QW+fplX92h7hH+j2u5Y4l44kUz1t2UhjxPtwlnhW/HUMD+1bCAZUbnbOJCO4OGogTnc1ObhT71JuubYAMGZVyVdFCtn9BmtM9TdsNoU/nX5q3+HYvPo7SPN/qD9WcDeLUyU2dHX21MYuXuqoq/2dmdEDkLDfdKudoIDTLz+81gi1LkEzk0+uIyB7g6Hm6yMqymIDQlA8liYhPRDkl7Kbm68z6nEATuHBc1ZcEVQVL/+slsDAPyaxietYoD3LtXOIGMlSmDFPezCXjcxnMoC9pQ0LRbZY9vZGwKuXvvOgqmHxUWztkkIKx0GDXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4EfM6RKmJAgTu+xl5RG8f1WjQPGCBjcp9vr9f6qKlM=;
 b=s8xHifPQRTjD4qR8L7Q5LHCA2GP8nRTRcsY3wsKo+rHATe2incYmKC0YVHSefjUf6AJJMfho9ljM2NqlDjbewmlvBoDDewQnM12MlPmINW1Jf5gjygVZbaEpSM7dmJmQYMQRnkaxLzjZbeK4eDV2rHlqV9OqA9ZmK2QwyA1nj/k=
Received: from DM6PR01CA0025.prod.exchangelabs.com (2603:10b6:5:296::30) by
 DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.12; Fri, 5 Dec 2025 21:50:16 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::20) by DM6PR01CA0025.outlook.office365.com
 (2603:10b6:5:296::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:50:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:50:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 4/5] drm/amdkfd: Move gfx9 MQD to VRAM domain
Date: Fri, 5 Dec 2025 16:49:21 -0500
Message-ID: <20251205214922.1095629-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251205214922.1095629-1-Philip.Yang@amd.com>
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9646c6c9-a9f6-44e3-a567-08de344846a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ki2vxlcWouRM4zoL639cCv/nIM28IEr9UXZfk9qkBEXFWYV70KQ+wL8K/I80?=
 =?us-ascii?Q?cvwttmRz1oynQV6ehJWkWj0pO9/buyYtu/SlZzOvjhV7Mg4L4zA8sggOaFat?=
 =?us-ascii?Q?jNQZ/X5D2s3z2NW50UEGNgf76eIGAY+BBYReCde9dG9tPicgo74ko0D0QMLB?=
 =?us-ascii?Q?DVGwIFvU9IUH4cgt8+Q4GxhJH9Z5KjvYJOfNHIc4HFAjLg9fhPo+sEoAnXoA?=
 =?us-ascii?Q?LjEIdJim+2fHGiUg9wWMon7HGQQ/0JM1gn+55vXAUHNaIvV5m3JjI9WibtTt?=
 =?us-ascii?Q?Vkw5TkOTn/Jhzoxz2o/iaA1zRzoM36sl/Y1/035i54E1+iToXmXmTgE4AWeg?=
 =?us-ascii?Q?gTGO6PYd6ik8ZQWElQuV/X2mNtXsfHMsHl1Ha6WcD7GqTOruWofqq3NlcLeX?=
 =?us-ascii?Q?GV97Tg4KvRmM9C5sOKrw6nDigKzKEBCtieQPDqPQR/opxTls3x6hdPL9MD5b?=
 =?us-ascii?Q?/nGzhOiG775Aa8HD9hC9t2HNw4PEtBb7aoMByKMp+1ljswKsWE4x9EBQWEEA?=
 =?us-ascii?Q?PUe5rFNi464Y6kIYid5OUKbnPY/hVcTZl34yQZzYk4UmtPYASgH90P5GvHRo?=
 =?us-ascii?Q?GnGjQiRFxT1M9QY8b1uPo2crD7EWqPxa9pTVtKgZo9R0N6utyuRXXS9Kc8m8?=
 =?us-ascii?Q?ApB7/mowqk9osgUcdM//FEx4Yttp4WbcqDgjyMv1s08eJb9oNKTlfnKeNKde?=
 =?us-ascii?Q?+uKiVljOQDmvd3ZSmB8h8m1oGKPTLobCg9RYncNe7F4fokUug5u052oFDkVw?=
 =?us-ascii?Q?hQLFaSTY0SwUTXOSAOtWz9JV3xy4wqlaLAmUbowTsAqAUoswvLb4akt43/PK?=
 =?us-ascii?Q?/DoqVCNEs4fFoiwZ5reCkdr0sINvIRC7Y23vge8x8E/KVmmzgtFB0vTgXSkm?=
 =?us-ascii?Q?pmcZfYU0PHE38cmtn2u7txBJEQUMyjT1uVcfqGoYkzgII4EpBamIdm+CcowD?=
 =?us-ascii?Q?FOteG4dU13m+aCkR22uEZhrFRHaGQh5oPxBNB2CBLP/OWqM0jQmUxoUNXS7M?=
 =?us-ascii?Q?/4aC/ceo5vrolEOB7Jc7O66WHpHRpXiFFTTxiL7IaO+SH8TbNmJvimqAeY4n?=
 =?us-ascii?Q?TWp37+gya5rAzzQm9hl948UjDiZOQXuFoY37XXjf/4LTNxbiJ+buqiuJGt64?=
 =?us-ascii?Q?Sq6FjmoQ6Hq0WWVhqzoU1Un11Bj8EOAG9XrS5H4i4I2Ryi+o7n9JI3vLBdWJ?=
 =?us-ascii?Q?cML7KPIyfgGauHRrvCRta1ceULjdLaXtXCCnhpq9Tg9Z3YE4aPIGqdFjcf2Q?=
 =?us-ascii?Q?p8zNSsb7lqBlj+yU88m4Ah1fn4JdWIej7dyO2zCJaAybjBerJsYpR3+mQXAp?=
 =?us-ascii?Q?gUtv+Uq8QDCYFNyIINweOgT49hDtpKZzFVtVmDD8djgmpkpJqGPOsVahY0Cq?=
 =?us-ascii?Q?B2XoOeU+hTu1ILGCz3khx0NRmekmzjcoW0mLoXkrHfe4+Qbqrp5tENKtk5qF?=
 =?us-ascii?Q?zWzjuX4x9LCGmkQ8utC1MEpLvxOgXRUL/hMk9e/hsYrjWI7v8OL7/7mZd0V0?=
 =?us-ascii?Q?/ewpvRnwh2F4mAch4vGuGBQm39X0pfXjyWJyDmRbYOb0K736gu1pZ5GiFw2F?=
 =?us-ascii?Q?NTMqHZsqa3WIaTx7pp4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:50:15.9941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9646c6c9-a9f6-44e3-a567-08de344846a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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

