Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44161D3B9AD
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 23:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F9D10E63D;
	Tue,  9 Dec 2025 23:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IAgI4idM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6F210E636
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 23:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpEeNUWjzFb4Dye20MTEo90uZqRHawNyjBsIRRmd8wPCPnrVMPj/+b/cdXfXMCIvUVtGs7QAwfrUjlYrmXLuhOvMCrvhGH46pk+593LJYKVJDiqGnWmfzTRE3xw5IHQXQEe+zZKXOsZN4R2YXU9QmaoD+cX6YBaWq6pvsVRAe3LzQWgp6X060V/PuqY25C75Oqx9LdUaEOKSYVdKQZov/feS6S3TGzNHZgvYEPeqrHbaCCvQQmfCS3zteclFj80XqQEatnPL/fsdXTVfjz5IfHq8/c7g35j0Vm9h3cIdY97L1OwDPqejrxtnmFsXliwnkYHm7kSpaPot78vsNmSGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4EfM6RKmJAgTu+xl5RG8f1WjQPGCBjcp9vr9f6qKlM=;
 b=vn0J+VFJdpOS4Ke0ZhEmmemBHmU2D1WR2hps1c3fckfrCfT5lW7fX0vav1mxRVWUNaE+uRLk7/L1ze44e+SsWyU4RTorBTeOZaWqMr5RRzKFUkJmeEceRoqL4Kw/r4AtIUTii6RToi/X105n9S6fm0UtiWDXGQfgnZrMxsUnN1e34tUQbAkLF2/GD6j9oygimbwE4KtkubvHeyyVhtXojns27EYWHQMlsDbTCoroONZuZ1ANYboUAHne5wwrsd/QCH0qf09PNIE+SG0E//jj2PctQH17Qk/ajM6vZ0TlVfS9+wrZ3SUkOsuPGuSqrA22f45bpIKcBRZ6hxyetgGlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4EfM6RKmJAgTu+xl5RG8f1WjQPGCBjcp9vr9f6qKlM=;
 b=IAgI4idMc+QIp20gKWIbQBB+WeZrqjQ4EmgHmT0BtwbhTHsKHl7l3kR9FXyRQ5+lOukXlzSCmpKNa4KBbHJRyTmZNCVaGBrCdYZqP0kWOI2g5iBJctWhcI0mKNj0n0hUc6F19PIkn9ze+NWoWAErNHV2z0u1SlCjmbKMgkHxW7E=
Received: from CH0PR03CA0242.namprd03.prod.outlook.com (2603:10b6:610:e5::7)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 23:44:05 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::71) by CH0PR03CA0242.outlook.office365.com
 (2603:10b6:610:e5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 23:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 23:44:04 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 17:44:04 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 4/6] drm/amdkfd: Move gfx9 MQD to VRAM domain
Date: Tue, 9 Dec 2025 18:43:26 -0500
Message-ID: <20251209234328.625670-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209234328.625670-1-Philip.Yang@amd.com>
References: <20251209234328.625670-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 193192d0-b8dd-47d4-9819-08de377cd6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hJ8JOyXDEoqbvqvxZ1DX98hAJ//eW/sA4D60Ip73N+VltH5fzaPHDbWSudpx?=
 =?us-ascii?Q?2t6dOTD0rPDRxL6Ri5w4tF5SqfISVAgjptbEP62/yCYUTO6R1WdKdFUGIbyB?=
 =?us-ascii?Q?7OR7/wC5X4hZX23iflLphZQtNOvW5pCJz1nqxhzI/sOssf0K+LNpx7vqe/1C?=
 =?us-ascii?Q?+Y2XlAgOwIvLcZ9ajFIZX898ZvznMk93/X0fG4rNNqD4MfgGtwtUZFlm0pxv?=
 =?us-ascii?Q?c2YmLCF/5MY0bthFddezkXi9mOtYBtXKDeDhVNS/DfjMO9+WgPYNnwukxlnx?=
 =?us-ascii?Q?QfNNhykdCEibK6woJ4XnwWCbfl7EKTicPPnYQuOMJBSpPtAxXpTABcBaJXJi?=
 =?us-ascii?Q?iMw6s9DQI1j9ocaWqYgqu+4hYkeMZ0h8rD//4m38kUqkhcbz5BFcFXfOx2hc?=
 =?us-ascii?Q?kR5Pe8pMiDFRCWjXWe40AkIYyRb7IcnaJByRZ5NlzPBzgVYcDviqvT7GriLF?=
 =?us-ascii?Q?MEX+d47I0CU+wPbYvNhLLOz9oHudHg1fSTkfFBq3J2Ink92Af6PuKq5efNNf?=
 =?us-ascii?Q?JVt0rUImS1lO1KcQtOeD8Wk6KbkJ5fSUWhaXzhBQYWwSa6BUYQ5p7R04dyYK?=
 =?us-ascii?Q?8vQFgjb91w6mKQVaV0AwzdZtYnpngq76UFCHLIivy7vzgvdezdXydMufGPEf?=
 =?us-ascii?Q?DLucI5c2M8Wl4gecB3CoUjmC5HsFw+vm4OtVfdhWURf0n2GoSH7D3vR8/5dn?=
 =?us-ascii?Q?SsI3EkyjWyJg4IOZ76bongtQlujJKlL80KgWGO4QZ6p6HapJOw+Gs7jpgjuE?=
 =?us-ascii?Q?st52XJKjv4Ph5cgRUcqIeRyTqVBdfTcR0axfRx4PAP5K5xASzPubEWd7AHDR?=
 =?us-ascii?Q?x9Y8Azxjni2icLu/4p7CCa/nuG9/y9CFLGnT9t9bD9t/LNjUMdcBEbyb41yS?=
 =?us-ascii?Q?RAqCbaKdSwFYYbTpYPsk6zteV79USzWblR5rKgIRnhGKK5rfKWpwJjjVE14H?=
 =?us-ascii?Q?Y1MQpEQWAyLLX5TMhgLCZUWV2CL248ZhxDNH+gYKyVAgGAXWKVvvgNSwM1M0?=
 =?us-ascii?Q?l03/9WyFIjaFjC6mSl1sssbXwlZnXEzS+OxhXSVQsH+feUNwHBT6+jB+AfIg?=
 =?us-ascii?Q?36PD26wxAxuZdrD5Bm3HlPbKflaTqnLcv959iWlqco9ov8wXOyuosC2bngLL?=
 =?us-ascii?Q?TCM3OjHMszMEGLM4l44V9crqe8pwlqQdlyXVVvWwGn9lkx2WQF+45G+gObfA?=
 =?us-ascii?Q?WzjxYSdWG3Cpj+Yo73wsz8zYinkzo1ivFGchwujqKm1DirQYdgGP/Dtc3GiU?=
 =?us-ascii?Q?h77PzNAbpp/bb0GhK/Li6l5JzT7JjEUwIoMEUEJIYHCPmCLocDMk4yJktp4o?=
 =?us-ascii?Q?roZLNqEQHDQC1lkAwdmVmpCFD0Mxi49vqv0dhT61hvUZ+vy2EEUfaL5snHVi?=
 =?us-ascii?Q?fOsYMFkmvZbiahpL40nb2w+V/dBsYMZpuT1550vh40O3TZ1oxTCTRQaI9tWj?=
 =?us-ascii?Q?Tvyt+etIWajE+xYcTqEOl8YY4AE7uJfHF30hFvVci0e0CQtn78by4lCKCrwW?=
 =?us-ascii?Q?nyb+tAb3iuM9FtFte2W4sgo8+q9+FkPjZjInXafAvgIo9XAniG7SPJ12GlYl?=
 =?us-ascii?Q?IJlOyFndONs5pVqfaXI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 23:44:04.8770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 193192d0-b8dd-47d4-9819-08de377cd6a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

