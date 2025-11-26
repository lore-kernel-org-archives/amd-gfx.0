Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11DED111A6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 21:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EED610E702;
	Wed, 26 Nov 2025 21:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kEwWpaIi";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B5F10E6DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 21:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJuXRxO6lCAORgCIZoo7InTa0SGZlwgIc5WKP4eJOt6QoUW76bjMaKaoKQugIwgxwolIlLNRAgFPcPJ8r7tZMuweUiU9HFBB/LV9Jv1Bgiq88LL8qiJ2XvgrSlq6DlKUbvZ+BSZzfPRKAM0l30O0tjLFatNmg6OcGNTFwJN8qthb5k2rheJCjg8S8gCNfTu4ENDpf3SBuGUUs9dP+Lg3+8YFLAe/EpnaA+PeKGg9yT2Tw8NCKmNOtek0QjyFKw4dJfsr5gSti9qwx76YfeRbZr4iT7B6HY/bsWjhzdNdPw0sRetXHlSGTW7+x0RUn/T5eTxxmrdWYDUf/AWMJRBYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ispvpZWGRbrK0eZsU6M8IKMpJtTzFPr+DcnlUmoNED8=;
 b=BCm22TNeD5P7HkUMk+ZcMATNaRmZ718q9IYZfFuject3y1XVfVlPgzqy2xX2Ib9NZoVqtUdZ1F91qxGKE95f/JO5Y/t6PgvbQ2xPd99yraBqgo0ijVuiDlPslE/gZmaBi7IZT4ahs6CppSYHda+KHcrxsCBauJ/M2QtEv5JTGYLOmeP2CtToaHnWy7es2KFmol6aFNNO6lGUUJRrrqFpiR+E5C+8cPXZ6EmMcXM0HqQCQ3ik1uy3kRRmsb0uiSyKRWrqG2U8esOUjDlj4Bcp2kGYFUm7pqQqxlPdVmXvSGPSa9fqhVoJhnaTh26kexWbkh8Qp6mW7FXpSHpejgr2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ispvpZWGRbrK0eZsU6M8IKMpJtTzFPr+DcnlUmoNED8=;
 b=kEwWpaIiPlOtwVpe3PuC341/Wcx4v6fS8IqoXkZBevzNB9WN7bzKfNnGIYpnVcVsP05Bpwu9dNz4qjUa3gWvlBamhcKOz5frbui2Fb1BcPMkLdo4ey2eq44MfM6KjcbFLcos9q/4KeT0OTl2gRYG8yzz7CzDe6Ir2hzXDmGCPZI=
Received: from DS2PEPF00004568.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50c) by DS4PR12MB9611.namprd12.prod.outlook.com
 (2603:10b6:8:277::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Wed, 26 Nov
 2025 21:27:40 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:f:fc00::207) by DS2PEPF00004568.outlook.office365.com
 (2603:10b6:f:fc00::50c) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.4 via Frontend Transport; Wed,
 26 Nov 2025 21:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 21:27:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:27:38 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: Move gfx9 MQD to VRAM domain
Date: Wed, 26 Nov 2025 16:26:31 -0500
Message-ID: <20251126212632.1522315-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126212632.1522315-1-Philip.Yang@amd.com>
References: <20251126212632.1522315-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: aad5177d-89ec-4634-b125-08de2d32a09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OfAb+Bi+MfMqYlyl//RAwxdfk3r/qO+kaY1Xpi+HxviYBTXHEn+ooJ61lv8y?=
 =?us-ascii?Q?ZQzZscqYQRx/bigqvNYUeUIveqrIADcbhyjqhMHo+kI8mTMQNj3KRWFV0E61?=
 =?us-ascii?Q?LqXUOY/kxXJaSz+bpXZ4i6x0z4QlTfw4xilT0u1cMRyrpiJPEVzz0mmAyagy?=
 =?us-ascii?Q?q/HeFHUBNYYetIbNFzpFqNHJQ6ZGM/FvGAje0RtbumAEs6bjaupnb291rUMb?=
 =?us-ascii?Q?4DRIkBoV8Uzj1RQEhDePmqeiTSIqkW48u7YBCPSYvXHGQBa+ahwZu39o19XA?=
 =?us-ascii?Q?flmNwLCz/CZfIavhe3KalIUjWKH058M8tCevIpuw/jveikH67qpnhztY9RHw?=
 =?us-ascii?Q?funDI2zQ/hxpNxrLz1tQLQYyMrF5ErUFOs0jjDJONGvEfnqlHcChcN8lxaBi?=
 =?us-ascii?Q?jqvEjl95pOYQuQLGj+v6wdL0U9DwsgDKnTgHVM9w3Hks4B41lbaRJ5Z0dmsz?=
 =?us-ascii?Q?lLZy3cKjNvrmyPkseXAiP1oaDKco3f6A8iEVnsWOXDlNLEoOVkgLCqcG3ts+?=
 =?us-ascii?Q?9AA4V6RXeA64oN+3lvRuYaMHDEjbdPQi6k66A7pCyYkkKWUFyqRDR4LT+sIe?=
 =?us-ascii?Q?eFlCfJMiw3YB9BJhntI+Cd8yt+5zjWaVma+O0wedoCpbX9btbLHFJ4XTclLS?=
 =?us-ascii?Q?3zNlLQy+SC5OFfG5TBYRY1LJRQ1nMlKiMT9UvLfV2NfBrvnwkeGynhPFdm/h?=
 =?us-ascii?Q?NRvzhC1F59YO2U5txQif8+/qeB4mHqmdi0cuc52w6uXd1FrCmGpTlBOonKp1?=
 =?us-ascii?Q?nVgBIdBwtk0tuqQ5QXLNw+u050onzh09nXjJs9Wd6fmQGAGeGTqcmVXL8X8/?=
 =?us-ascii?Q?XEIZdc6Fl2aynQ8K8sc3MZgn1ddly+a+Ug6mFo1a3RP1XCbeZhxdZf6/MOKd?=
 =?us-ascii?Q?bNSygaRjgaMdfn5PfGinQEahmGxbEPkC6/OI07Fv92+Kv6Hy8z+EP+CD+iH6?=
 =?us-ascii?Q?jOXAtpt6y8NJMcGMs74x+le8pkACoRdp/Kx6Lowaxp+11mfLFPSvHO6/zTtk?=
 =?us-ascii?Q?782eLC4Kq9MKGuc0p6Km8okhqre0mr8ex40MJvjLB23HL3r8Wz0tlD+0p6vu?=
 =?us-ascii?Q?zJpTMRv9hGZNnYgFDAQ5gCGtJGRVgzTZ2AQjO+RIwv8pZqN331hWM7jc3C9P?=
 =?us-ascii?Q?e/E2gjDux5DPN9gZJZhVdIW/gahfekxL/mYZvbA83/dZjgiQu6xRGm43QHao?=
 =?us-ascii?Q?L14aLXHMCyR5o5IMnESLNP1MV9iK3f/VyaJCat29rSCX9XaSmSeJoKT5EH0t?=
 =?us-ascii?Q?7oWDv8sFR0Gtv+gDHt3fE2f5+wtcibJ+TKkWUHhRSTxQgr2aq6G254fZh1lb?=
 =?us-ascii?Q?s9BzXPnL+8IdU4+AzKi/gZbTHT9uEzFJzCY66wyIkUus6MgEMz6rueWo2t6m?=
 =?us-ascii?Q?TdWnuv+TKgYPtyaPGmz7us9evLPXn4EnW0okFLBBfuCiDaBctt36s0bOsqGk?=
 =?us-ascii?Q?M1iusRRlaonYKhXboGmWYqhLG1E7iWY7xc/s3oBsOWNJMGjYn4pv+pFAWzdv?=
 =?us-ascii?Q?RsDK92MDvrjYOmqV26TenmyCBCfMw4nIYrYxFLOlsywGKZr7+b8cfUTapVCM?=
 =?us-ascii?Q?ll84WVYSb0Cemq6Wd0c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 21:27:39.8707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad5177d-89ec-4634-b125-08de2d32a09d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
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

To reduce queue switch latency further, move MQD to VRAM domain, add
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag to allocate contiguous pages.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 9cd1660b8f60..c11e37915365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
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
index a489d43d5f64..c6945c842267 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
-			AMDGPU_GEM_DOMAIN_GTT,
+			AMDGPU_GEM_DOMAIN_VRAM,
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
-- 
2.50.1

