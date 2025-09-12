Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD51FCAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 11:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B4010E0DC;
	Fri, 12 Sep 2025 11:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X6UwfS/1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC19510E0DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 11:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMF1aF5/9TIZ6vNsdhsv0YQYbCUBTug+RKIqaRl3Ptx9Do9vMG0Dn696kFA36++vjl1/e48CU987mBrxmbIeo77QAntI1QI1LuilheSIjmzoj6+QHeBFL3lB9d56CrXzQLjLDG4Y5PKs/hWrNl3mYbcwAP9p8NzMU9zDceEKKy7AOmVD1nYzgKV7JKV7Xlbuhl9qrASxZ/J2bTVhd9tk3+z2KxVtq/leZE0uOrbD/byvN+GgxP2HXmu2c2pxj9YLNzJwXmiw+W+s8PBcTFqaCWlwH4KB4+z9fyFwiNtT+R5wHABHZYKMDC4F0+KMm5XpOlvfSSfoUUpHtuGfyb+ANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmcVFr+lq4b0yU6H1cpR6cBnbCN+YeVLQYLNB+DW9JA=;
 b=aBgx2PYKf0CMrwP90RjQDbRhonVwOvZv7VydwDpJD36tNQce9vaPmd/oA8JaHwelaOI7Kv+gM7O7q2qH1rjBPeKAbmPfUsHRfgipBFLU1BrW3ODCJYU/z4XfKW6OIhkjFA4XCPT8zqdR93y27a5WtT/aryHuhDn4G2nbqDcfb279lt/Rmp1pmz5hvrtwwgD0F5FJra5gxnLvWA15/+EFHzs5o1tFkCHqGajB0nmKR/lTxM6Er2E2nJsA4+FuQVZb7en5/jF11X8WSYmSonMk+sm89j431JhSfZ79ecvpl0GpGlCjpqEmUI5m2NDnwpG17WPscxOLvyNBw9ryDfl3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmcVFr+lq4b0yU6H1cpR6cBnbCN+YeVLQYLNB+DW9JA=;
 b=X6UwfS/1aFooyLcoemPwEMK2bwAFUzLmbNqk6zNWW5Ib6uJOE1VuFZgIFQEgqC8S8zHd3c4L4AWnymzV+wA2AlJQiBWbnNTvbNhwzhKfZqDaUuEK0Z567KL+SKqs6/6G/ynQvQjRx3PeTlAuGUpnqeI36nqAYVqxEO0yEQvLA9w=
Received: from SJ0PR05CA0194.namprd05.prod.outlook.com (2603:10b6:a03:330::19)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::624) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:14:43 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::99) by SJ0PR05CA0194.outlook.office365.com
 (2603:10b6:a03:330::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 11:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 11:14:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 04:14:39 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu/dma-buf: Add helpers to map/unmap BAR I/O
 with dma_map_resource()
Date: Fri, 12 Sep 2025 16:41:47 +0530
Message-ID: <20250912111148.833465-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4d6ab4-10d1-4abc-24f5-08ddf1ed92a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2xVNjZZaWpra2NDUENic2REbklFL1FuWGhsWEVHTWk1b0w2enlVbnMzLzRn?=
 =?utf-8?B?d1hidTd6N1JieFpyTHFIeEl5aEtkT0hKMmNKM0VGMFltbjF1VEtQR2ZQYW1F?=
 =?utf-8?B?cVRCU28xMXBuSTJyVXVXeGlldDNlOVhZc2tTQUNiSC84NC9ZMDhrWk9tMkdK?=
 =?utf-8?B?RVdOeXBraGhQYWw1RTRMQ085TVI5ZllPNGZmaFpsdVcxcVRSMytSZW5KRDRD?=
 =?utf-8?B?ZjJKK0JHNllONUx3S0xCVDFmUUJBNmRxV0l5R3k3NUN2V3JrY2J1YlFrcEZq?=
 =?utf-8?B?K01TbGlGcHZ0aGRad3dOenZFNlJMOENhNFRIblpTb1BhaTRsUnIwVVk4VWc4?=
 =?utf-8?B?Z0F4ZXMzbWViekIwZFVaR3VjbEJENm9WeTB1SUt2cU54eWN3aWIyeFd4VVA0?=
 =?utf-8?B?K0pJVG9VcDVaUXVpYmdQRnJjdG53VTZnWTFSYTdpTnZvMWR3SnM3S0JkWnFq?=
 =?utf-8?B?YUxCMjgrcVVXeGQ4U1ZudFpyeG04K0l2OGlRMW5tcEhBbVJTNnNqRnA5RGMx?=
 =?utf-8?B?SGRSeUU4ZEl4bEtKQ2VHcG4yRHp5S3Ruc0Q0RGppSWlyWDFDeUgzRUFUaE82?=
 =?utf-8?B?cjU1b0ZFQStUNWZZQnozRXpIMXhLd204ZkZWU0NNczJXRlNlcHlQRUNSLzdR?=
 =?utf-8?B?TDFtT1dWWGM2WEh1UFliSjJhUy91MjBGbHZZSFBsOXJtbjU0bENBbUJNWkxB?=
 =?utf-8?B?MlM5QjFLRHlqUUYyMUl2SmlkZVUvWmp2aVNMR0lCTE5ETnczZGN6aDErWVF5?=
 =?utf-8?B?djRITkZVNm44cTNzUlFpQnVRM3dzU2NMd3JySWIvZEZBS084ZmVhakYydm16?=
 =?utf-8?B?bjlvd2tIZHh2SzExSWZFNzUvOXpsM2FBWWZsN3k0Nyt0ZzBwUEM3aHZJcm8x?=
 =?utf-8?B?V29tMnExYzNsd1FKMU96Wm9hbU94RE1KRmhQMEtWY1VLUkNTRjY4ZXp5aHBF?=
 =?utf-8?B?bE04elN2bGZMTDVud0s2VmN3YStsVVhrQk5jZmFUYkI4NjRGajlpYkczNHRX?=
 =?utf-8?B?QWtZNDBlV2hrQ2ZnbWJvbi9xazh3RldRWjI1Qi9HZWFsNEUxVDNRWVI5ZjRD?=
 =?utf-8?B?Sko1N2hCQnVSYXlrVWtVUHdtaU1qeUNFcGt0Zi9GRFlWRmdGU3hremk4QmhV?=
 =?utf-8?B?L2k1dkRpc2Vrek1WT1BiOFV2MnFVNkVSNk5tOHViSnBqaStwMEZ2RlFRQzY4?=
 =?utf-8?B?a0U0aEFBSWQvTTFOOWdCR1Q4K1RuVkdNWW5jUGVBdEpTT0MxUEVReDUwRnNt?=
 =?utf-8?B?TytZTnNzOGY0RUxNYW0rcks5QlQ5S2gwNlkweG5jS1V4aktEMXh1SDJVdlNS?=
 =?utf-8?B?ZUVKTVpYeFJaS1FvS2k5NE5kNjVFbFRGdWo4ZFF5d2hKWDg0bUdmUEMxYzFs?=
 =?utf-8?B?bTlLSjNHZ1RDOSt6elVTRG4wT25LYmwwQU1FZ201Rm9zSUl5NUxkemRUNnJa?=
 =?utf-8?B?Vjg3UW9MbFlRYktieUxjWC83bWh5cmQxWnBpK3pNWUxjeTR0YkdlZmhmN2E2?=
 =?utf-8?B?WldUeU9saTZ0RE5hV2xuR1hrWmxTZU9XanJkUmVLbitxVDJtK25LWnp1YVdK?=
 =?utf-8?B?SE4va0JyU1hCaFN3cWphakp5V2t5Z2tEK01naUpPNC9LeEFWQWlBR01WS29Q?=
 =?utf-8?B?Ly9FUkxsWmFZSkVleVgyUlN3cXhBb2x1UmErSnZxdHNEL2gvdTNBUlJKTW9O?=
 =?utf-8?B?SXpOaHhDWlR1b21MK0NOY0VNYlk0c2NVTWtVUCtESkRIeVFsNjhjWVBlUWhz?=
 =?utf-8?B?VFVHdWNWN0dnSXhYOUxJaldMUTgxaUdCSHZiSGtXQlZEQ00ybHBONGZaMXpE?=
 =?utf-8?B?aWdhck96SUxseE4xUjdKYUt5OXhqTStHYngyZ05zeUNRWWdsS1NyQ3B1dzFR?=
 =?utf-8?B?K3ZWZUV6SW1QY01venR2cUhmVExYejFtYWEvNEJuMEJTS2lBYlBvM3I5VnN4?=
 =?utf-8?B?UHpaLytONkJ2RkhOK1FLMWFkQTRSQWhPOGlYSC9FQThSRnNJdEJuR25zU0s3?=
 =?utf-8?B?V2RkY2UydGp4aFJXbHprdTY4YkludXk3U0NUZURBYzZkWGRhb3BQRnhNWjlz?=
 =?utf-8?Q?9foZA+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:14:42.4986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4d6ab4-10d1-4abc-24f5-08ddf1ed92a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16
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

