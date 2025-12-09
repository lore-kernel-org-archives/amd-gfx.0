Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8CDD3B7F4
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 01:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F1A10E469;
	Tue,  9 Dec 2025 01:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CX5a7ywu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098F010E45F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 01:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wn7knA47/A0Hf98AEF3qZJ6WFY2y8iz7MRIKqFNL6vD2UKKQEkJyR08+CFPC8T38d+x7JGYG/InGJx3DRlIpKtNbZe7qwtoVddX3kkCxEHubJnE9GWmMkmjQ6chupjQD12JhapeGqtxap16vuyVNbD5fXF+rQWLAu9G7PoGEFhWUv3ZmS94UBFWH88WV9Gn3rtyZFE3DILCH1FVXTuZsmyY25metC45EAFB2r7MBeBTJQsxsuPzONZS2N2i1bWyfMAhzwE/vBHzQx+5Nh9sQNyhC4Ht0Fl8Js4+jK8DsEf575FVa6Vacs2Zj1z/lChS5YsxlyLYRFvvhDE5xzS8EIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4EfM6RKmJAgTu+xl5RG8f1WjQPGCBjcp9vr9f6qKlM=;
 b=Brh/uGZXZwwttaR4T1a0GrT9p8PaCq4RNfo84WcE2jGnvxlVPf8lS/ETApTQltOQ/F1x3aJkXNDpacVcXxtrCYGoupuYvyS89EF7iPOecjiWNu9+gG5ixSG/mkSV8KOoqB8JEvSkLFcrdL17vSdF47siycxB3nmqOIBtcudAWbg1cAgMQqaOBglBnOs6X7eeSKs/9xTFhzUbwom3sLbGOpXG6RjQ1sPcbgzzWB4Zp3F6ecS0w3/JMBlHl+NNc4BtyJamRrgksRn1g9xC1uaaX1SFYftsAc581H9HAB4oDBYZw57fxTVOwtr0hOdmfTLXRqy1Vyvy0ftD1GCMs0tCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4EfM6RKmJAgTu+xl5RG8f1WjQPGCBjcp9vr9f6qKlM=;
 b=CX5a7ywuna7y4C5SvhNFG7LKqeMgXKUsiWK3La0u6yWymJMQDtVG9EDimdbjWpt7kGb617K1VM1yaq0Z2RlIhOALBf7c3FXtanW8TXPXnltHRf1R92ky3cHe/Df3TvIE6iSlEPmDGoVw5r7Kub8LfwCGprTeC2wRvPT6Cu3dlP8=
Received: from DM6PR04CA0022.namprd04.prod.outlook.com (2603:10b6:5:334::27)
 by SA5PPFC3F406448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Tue, 9 Dec
 2025 01:26:15 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::40) by DM6PR04CA0022.outlook.office365.com
 (2603:10b6:5:334::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 01:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 01:26:14 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 19:26:07 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v4 4/6] drm/amdkfd: Move gfx9 MQD to VRAM domain
Date: Mon, 8 Dec 2025 20:25:35 -0500
Message-ID: <20251209012538.3882774-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209012538.3882774-1-Philip.Yang@amd.com>
References: <20251209012538.3882774-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7a8e9a-9482-4345-faca-08de36c1f1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PEUO9AB925r8cRWODkYromq3SYcKmp8NCAzWSP5AxKgT6FOQWMpWuca1SKmA?=
 =?us-ascii?Q?qFcwXu7YUy1E44z84VxRMyBmePpair6oaZ12dyprMB2W+mUpGsFxpGQ2r5CU?=
 =?us-ascii?Q?sY5DTqHD8kaEilXeel5AKohBEPiymCfp1PnNZvxtrYpNI4nFOp1+q59bYAoo?=
 =?us-ascii?Q?si8/6bT1liU8JAIYOwv6hl2Nkt409eo65zkgMTt7SL8b+4LSCT4pp31o4ZMV?=
 =?us-ascii?Q?Qt4sTZbwoBERo/c+F4A+WS2nesv2kqGwJhpCGFdM81xrAXEQjj4OUK1NP8to?=
 =?us-ascii?Q?jnizrgy9XXaHV4jAjC3z4BQM+wzNAETUqR2c8HAx6+0jg/fHwWdBrhy5BgqU?=
 =?us-ascii?Q?4FCBRifKLw1CAyuDzra+q50j6A/3vQPzt7AGMC8PqHdTKqkSA0kqU/UEVTk3?=
 =?us-ascii?Q?Aa6PeMRsJT5Nh3cQT89IP30+6cd2aoUpx7nwKHrIJ+PZ2onIjKz4uRF1YwZE?=
 =?us-ascii?Q?yo3y5t/Sn+cLVG3WL/prDrIScptwLTyMRXZruSdr9rx0W8c+aDtu2Jlh5cG+?=
 =?us-ascii?Q?GXxhVs2dEunNQKF0kqKq0yRNupttX5WwXv/o6UrdtJOfw5zKuHOM0Ts9S+Jt?=
 =?us-ascii?Q?bb8HF4D/0Y5JwMHLMoyc/Jz9ShLGYDyFhsuFOaUsxx/G14P7nbbHLFtKQbPD?=
 =?us-ascii?Q?7lPdmoQzOLI6oNLPoZUJp3lOhQSisCfk8dnh62EaPU6tKhQaOmfSb0tbwc7Q?=
 =?us-ascii?Q?/IIyhjtlxRcXe+4fNMp4420VYVwwHjoTmFjs5vOOi9qMYHXV/Gu6/mO0kPt7?=
 =?us-ascii?Q?BvufoBQOuR04XZWhKyG59FtszNHCyLuhvg7Vbv8Y/+HQc0GklftdedhAaYL0?=
 =?us-ascii?Q?1DR5WVUUGugurwGoWF187vuTL4koGiHgM82p5HPIYegxi12sv/ZiDhR4yHW9?=
 =?us-ascii?Q?KoWAw1oSUol++9EzF2yIAs8LSUW1IT+lf5AfLPnxNi6RcedWTMUsCnEoqKiB?=
 =?us-ascii?Q?Zd5BOFDfYNWWW6PwLw0XYQSbEGG68rMQKOAIYOP49V40TuvwDNhjAOJQeCXC?=
 =?us-ascii?Q?vjWMwJEiwhfC4qa7OiR4MOqnvMEsyyh4B/zSj5Y9jl9ap0u/gOst/TE5i0V7?=
 =?us-ascii?Q?qe2hxR49i645Ez7iu18SAG+EVbT3dry3Wpl33hPsUjncKpKfR4CPD85sL4bq?=
 =?us-ascii?Q?TITDapMHuAmKHybeJxDnayO9vg18OBXf3QYDuFvMnVQnQbgdQ4EBzDqzCKih?=
 =?us-ascii?Q?rzvGB73O+91zYBfQ3MdFrDzen5Of32SJGIibZE79+1bf6Htf3l/GHpc2my2K?=
 =?us-ascii?Q?Q47Oh3aRwd42lBNi3XEERg89H3dWdzlazdfGt6pNW+XFRxjl/5OdudO6pnDE?=
 =?us-ascii?Q?gPlCWwjqm3TAK+UJG61V9o2wUVRwOp+vRN05m+zd15vSBawxlkb3oTG1Qpp4?=
 =?us-ascii?Q?oDAAI4QTGYrkkheW2qIgQX06m+jmpN3mZ4gDmQVw99H00q+nPV4QgjuTz06g?=
 =?us-ascii?Q?Qs7EffRhtEQI/pyskRquEpgXZlh7c5q4aO+wBzJfpa5ta5QbyfyX7H1S/ySD?=
 =?us-ascii?Q?y5QVyDl9ts56VLnFaPivwyJYfJU98rSvfmx9QGbYWXvrMkTLIiLlmh64zxwB?=
 =?us-ascii?Q?8sC+xH5kHfwnr1M48mk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:26:14.5363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7a8e9a-9482-4345-faca-08de36c1f1c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448
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

