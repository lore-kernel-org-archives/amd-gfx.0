Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB76CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97CC10EB62;
	Thu, 11 Sep 2025 14:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EI6RloQ7";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE9310EB62
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dg1Epidrbr1ijqAZ68LMmPOHepl84isaw+XplhI2YOKD8Pd24MmfDs7/9XUAIygLZRJ3vJfCZXm3OIA7bUqiUTOiOeG9Yt45cVtCMmDMpuDaqixjQ2uvaKuXk562COW+dQNTkYACSsIBJsI67RRup3hzGIQr0uAH4poWoQaFNVKxpDn9X5o+a7iMflWwYk4yUBVX+60kat1K3od/q/dZyj2B8Asf5GZkg/Uk6vrRKOeqvtt0CmplJCGlM1klcAc5tOsvsl/mUmcS4oaRD+rm5aGQusf3axVNKAeuuGprimr2/wkD3DKF7PfOLxMdgq0kw5xlUoQOSEjtNn4wSdPuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmcVFr+lq4b0yU6H1cpR6cBnbCN+YeVLQYLNB+DW9JA=;
 b=ZogINwixzDAr7kFAbCpw95oF0pgvGI4tNGBCCfDzLFYy0EcYT9wGMxe6vsp+yWa66PWplAMuCGmCE/KhdW2WCBnU5TJ61Xzgq2abz2MBSP8fFdJKw+aE9MjFKNFuF599TRGFiTl8P/tvMTjONnaESIBODK9pl2yl3Y8ak4O4Rx49XtEGqMS0IvFoDa8Mqc5OfsocwwaoG+Dyt1yd2JdX8W+aqgjrL6XdSAzhqn3cP62fPkLv/XrFGidpLG6RRZoUypeT2OQrEhHLea4khCzNuufo/WnmwAWEUW+bt0cKAsV3I+w6kyRZaLuF0rAQ+IQbRuNJejOBhFciwU0OAH2dTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmcVFr+lq4b0yU6H1cpR6cBnbCN+YeVLQYLNB+DW9JA=;
 b=EI6RloQ7w7iByZsQlQueut7NmL1I7EsB8LHiI+mWSB6p9hYpQoIK7HK5CZjNfAzRJ/DvZ2SPbIJcHXB6fUw+mKJdxdgKiSnR4xiVI/TtPFawjiXd1KYrcB9CaSy5d9ti9DSyKz9jx2/QlxdaPuto1LTzPdgni6a+W52uojjexY4=
Received: from SN7PR04CA0229.namprd04.prod.outlook.com (2603:10b6:806:127::24)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:39:45 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::ec) by SN7PR04CA0229.outlook.office365.com
 (2603:10b6:806:127::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 14:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:39:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 07:39:40 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 1/4] drm/amdgpu/dma-buf: Add helpers to map/unmap BAR I/O
 with dma_map_resource()
Date: Thu, 11 Sep 2025 20:08:12 +0530
Message-ID: <20250911143815.825607-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
References: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: a2294f16-8f46-460f-1ee6-08ddf1410cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aElqemE0aThJZGNEbmMyU2NGNFhKeVFvR0V1NTZzNG94ckVqUUEwZENtOStG?=
 =?utf-8?B?QXZIUTh4NEVYVG05ejl5UHZBaVZCaVB1TFRCTDhiYjVtYTZqUFJDeVJSU3Ra?=
 =?utf-8?B?cGxscU1hY2Q2OGdFbGU2VWpoR2xTOXQvb3h3UFBVc2tvTXkrSnROa1poRjlK?=
 =?utf-8?B?Nm16R3hyNzM3OGs3UFdiaVpreG9aTlNLM1lEWWJaM0VrbzB2WmhhVmIrU1Bl?=
 =?utf-8?B?M2tjZEQyYTR4eEQ2M2MyWGxURFN2dFNSaGdvQmxBbWc2MHcrYUpSdUNmNll5?=
 =?utf-8?B?MGtnQU4yRUt1RXhTQmFQQVdrSmpndTJReFg3VW9kcUV5cGpzRy9USUxBWUgw?=
 =?utf-8?B?aWpMVGltRVZvMWNZc1FTQ0xDbldpdUEvY1hWSGI3OU1MWkMveWFPTFhtUGpz?=
 =?utf-8?B?bjZ0ZFpaTFpGOTU0eGNmeUxkYzdmK1BsZVR3L21oZWppVHh6VnVtWG91clNM?=
 =?utf-8?B?akNpM21BR0UxbkhIU2ZJWUc0eitabTFZd3dIR2M1Q3A4OWlDdS9JWlhTSXR4?=
 =?utf-8?B?TzRIV3AzU0tOdlNldWJzL3lURVJwdG1HQTJyaTZxZHllSjFvSmlhS1ZiOEEr?=
 =?utf-8?B?YTFJTWJqVEJuQU93K3ZNTlRFSzJEZU9OZTZBQWErT0NMTy9ZeDJRSmtEOXpr?=
 =?utf-8?B?dUR4MFg0KzdJaXJYT05rbmEzMUM3bjRRaEVJc3VmUnZOK1VRTjdXbUVsclNG?=
 =?utf-8?B?eStiQ2luR1RrbHllcXBocThiUXh3WDNETUluYzdON0JITHdHN2R0MXY5MlJB?=
 =?utf-8?B?Q01CcXhGZ3NOV2Z3NEpETzFJQUYzcHQ5c3VQMU8rS3ovWG9vZjM4VCtXd1Nt?=
 =?utf-8?B?VlNPaGhUZlgxUXNGaFozVHRVU0ZSOXlQTmlvdW8reXI3eC9zTlZzZmhNQVVO?=
 =?utf-8?B?cGpSMG03YzJlQ0NSYndFN3UxTTVLankyRXFRN3pMK3IyZTFBV3U4QWZRa1dx?=
 =?utf-8?B?V2d2OUVlZXoxZlJZUWF1a2tLb05nMTk0eGt3Wm9KZXBHb3dXcHpDQWlBTzFy?=
 =?utf-8?B?OVhCQ3FBT2ZybHUzVVkzeXMyQXowL2hSMzNnRlYxU0hUSHNRUFA4bjN1dFNn?=
 =?utf-8?B?S1pNdDRCUG5xZTQzL1ZweW4zajYwaG45aW9qcWlZZ1pnSS8zSER5SllZajlS?=
 =?utf-8?B?aHZPQnVTMlFnWE9XcmZVamx4Ykh6R2ZjSDg2QnI1amNZdWszQ2ovNHREQVI3?=
 =?utf-8?B?MEIzNk4yek5wdFdrdG1oOUFIdEFFWVhxY29hZ0d4QVNPRWxQQllvQ3doK1RR?=
 =?utf-8?B?eW1IazFhOEdwRmpmY2ZIRWFnTE11S2ZBczdZY0pWUExLNmIvT01nZVlRNzBK?=
 =?utf-8?B?Y0FzTklKNUROZW1Ccmk3NXc2ZUhkU1hXUW5PUDhXcjlSSWVnclFPL1pTYWRt?=
 =?utf-8?B?K0JHYlhjcS95S29ucnFCMWYzaGwrK3hUYVlkeUtXOWhBNjIreEIxQXBzQjB1?=
 =?utf-8?B?aDVMZXlKQzY4dzAyckN1dWVPbEl2TytLQVlpWGxFOXNOZmhXNWhJM0o2MEF1?=
 =?utf-8?B?MU1vUTg4VVFPUlFINk9ZUHJLUmYzOGVpVDNyY2FnMzAvNHUxZmtqNGRjWWQz?=
 =?utf-8?B?WEcxZFFVb0E4M3FabEJvVTN4Z1AwTzN0QjVNOVRYdFNDc0ViNHdEVGdiOFZs?=
 =?utf-8?B?cjhXc0phYjY4YkNuZjV3emduYzAwK1UzQlVIcExMMVoyZE1pSXRlVDlqcitj?=
 =?utf-8?B?UzBaQmZFeEF5LzhjUWQ5T3g5aWhkcFkwQUZLZ0pRWjRKazlIVmdWcVhId2hh?=
 =?utf-8?B?YVdiRWRXODJTTXNRbjFELzMraUpjeGlZdGVwazhYRGRaWEdJM2dtSUJsSVdj?=
 =?utf-8?B?SGc3QXBWSFhpNndCcGpBS1UzOVpBMkhQNkZPM21tdXErQW9ONkdSVGdlUnBz?=
 =?utf-8?B?MW1iNDlWNDdja2J6NUpPRjJ1TFBLL3hiRDliR1lLMk1MY1RySGZmenNzalZm?=
 =?utf-8?B?ZDNpWmE3Y1JFWmlPRlBSS0MrV3V3OXBGTDlsemJDZmVpeEpuWEtPbkxlc1RS?=
 =?utf-8?B?UGp4Q2NWMm5EOW1LbytMME1Ma3RZQlh2NG1SV2Y1dEhWcEFFUjI1RlRQT0gz?=
 =?utf-8?Q?bChzMB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:39:44.5177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2294f16-8f46-460f-1ee6-08ddf1410cc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511
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

Add helpers to map/unmap a hardware MMIO register window (PCI BAR) as a
1-entry sg_table using dma_map_resource()/dma_unmap_resource(). This
will be used by MMIO_REMAP.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 51 +++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index ff98c87b2e0b..33fa17a927ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -37,11 +37,15 @@
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_object.h"
 #include <drm/amdgpu_drm.h>
 #include <drm/ttm/ttm_tt.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
@@ -146,6 +150,53 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
 	amdgpu_bo_unpin(bo);
 }
 
+/* Map a BAR-backed I/O span as a 1-entry sg_table via dma_map_resource(). */
+static __maybe_unused struct sg_table *
+amdgpu_dmabuf_map_iomem(struct device *dev, resource_size_t phys,
+			size_t size, enum dma_data_direction dir)
+{
+	struct sg_table *sgt;
+	unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC; /* no P2PDMA attr */
+	dma_addr_t dma;
+
+	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt)
+		return ERR_PTR(-ENOMEM);
+
+	if (sg_alloc_table(sgt, 1, GFP_KERNEL)) {
+		kfree(sgt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* No struct page backing for I/O regions. */
+	sg_set_page(sgt->sgl, NULL, size, 0);
+
+	dma = dma_map_resource(dev, phys, size, dir, attrs);
+	if (dma_mapping_error(dev, dma)) {
+		sg_free_table(sgt);
+		kfree(sgt);
+		return ERR_PTR(-EIO);
+	}
+
+	sg_dma_address(sgt->sgl) = dma;
+	sg_dma_len(sgt->sgl) = size;
+	return sgt;
+}
+
+static __maybe_unused void
+amdgpu_dmabuf_unmap_iomem(struct device *dev, struct sg_table *sgt,
+			  enum dma_data_direction dir)
+{
+	/* attrs must match map side; we only used SKIP_CPU_SYNC above */
+	dma_unmap_resource(dev,
+			   sg_dma_address(sgt->sgl),
+			   sg_dma_len(sgt->sgl),
+			   dir,
+			   0);
+	sg_free_table(sgt);
+	kfree(sgt);
+}
+
 /**
  * amdgpu_dma_buf_map - &dma_buf_ops.map_dma_buf implementation
  * @attach: DMA-buf attachment
-- 
2.34.1

