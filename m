Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1199DC04FFF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 13:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E47113CAB;
	Thu, 18 Apr 2024 13:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pPgwFRAw";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A76810FC8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 13:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3S3OuXo1TzvWCeDu8zSguYb/HU51ZwORhgiMoDlR0UWU39YCDvrdlyj+oKpbQRfa2gVsxqclzqvfhn+hTZmjOeTnC6cIeRRXNIANaeY9lI2jIEMaDs1Vbibm2xMjXITAGit8iySCbose5bYkUIFt51wSCnd7zeX6BBWMZ7ygiqXUkFouCbbD87jnsyFkSnjV31b38kk9ZfYiioxrbjwPu61tvGEZcU9x4GP3LWzxnhk13AgqBzmei3EbzYx4NJllMvf+ObpmePiKR61Hc3/qJLPtE6t9DRkXH7Cw67os8lHbwIuclB27vuKHPzoBBH2cHl/eJT+a7y/kNva4jATgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cR+RdldrfdgurbGS5YoHtpyFuNLcPPV+iGrtZlMYcJU=;
 b=i3GyGzg80uaqLv6NFr9d88xMFLkC+Tx96NwoEXHIaMVkoQRyFQUhZPwuWwxQjBLaNpH0A/rXSmuhQiwii0v5rowyXZk0x3XQyaYO2WdwpD1+tF8aDdpmI9UjK0xXd/TgRUBmL/bDElHWBVaMQlvfzHzs9Qt1GIIYlPi/HHQusKceK7f//vcBCibR6NvbasO+2UBl1H7CKKyNRK9GPUr2ojvS8/+LMljxOPvyNYtTOmDKKI06x6jBxIif8h9JFQRl4BE+dqv7f+pOX1rIzAgHkZKJGn8eoIGDkxeosUKvmdVbs8kjbktdwFJ4zFZJMNjx/9e5iRrvXSdL/WQxlAgz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR+RdldrfdgurbGS5YoHtpyFuNLcPPV+iGrtZlMYcJU=;
 b=pPgwFRAwoa7yirrEj4rzEImUyt+DnEOCW8LUB+solib/YTxVVe94UJBxH+CehFENKkADoA8/FZJxEouTlnPke5mZ7bv2/TntX/uAjE6uyCqvncREf0ETYhm60c/wmzHeoHtxHSzDrk9BZUVqbJKSQVtdnRSzd9jEHo5iyeHmnEg=
Received: from BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 13:58:41 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::25) by BLAPR03CA0027.outlook.office365.com
 (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Thu, 18 Apr 2024 13:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:58:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 08:58:37 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 5/6] drm/amdgpu: Skip dma map resource for null RDMA device
Date: Thu, 18 Apr 2024 09:58:02 -0400
Message-ID: <20240418135803.17365-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418135803.17365-1-Philip.Yang@amd.com>
References: <20240418135803.17365-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: f57941d9-e945-47c1-3822-08dc5fafa759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixcW1zz7Z4dqwPrmZfIhlYhuvLk7UC/wxv9I/hF3cItf7CckxpTF4RjDOGuDYo/DDL/qLQI/f9Vjr+HsSHkalHt56D3T1xyl7DcB+NMQLKQiDYUp9iUr1DjPJyBR8dZo74w2ztmqvXaBHgXfKrg739mhuvRWxln/g/8eTCRkVf4q38+BOwBsGyhFzHCoJwhIfoHOW7UJ7xXX29Bo4DhKnG7D2HGzRQ3abym4QipVsN+1UcpwJBvvvCU/DoTg4Mv/xkMCWgKqOKuJsxQDWe8Rumh6Ds9SZQMo2g70lJdxrTLk0s4rWWbXOfwGygYk+eCFjks5gpjUhTAqcwNNJk5zMpHZVtFbpchwdEX8VBByUuBz2JLwQ/lE7eEnDviBRhKhv4mCSrpVtGh08o3Dq7rmCp0u54REo4NNizo5Ui9iu8lSy9DH2ujIDt5D6V0IUh71FDO9JK09pqUCXAU/tP9SHCsKrY/ZVH3styk/36VFlAcfTHIHp8Y9j7ds63Ah7UX/zDYfIZN1AAvXvpiS1pooLxmdG2hfgAjbyWvmnNIoQt6KuRKHypHVdiTsho25/XiEmAi2N9gHn8DL3QUcUTnrbC+WST9N4ovj8O7bVrxukoGsQhK+SIdEAWqLDqM6PDdD6AwDH2cMlbxmUzdeZG3rnUycBxSyb6RMwPDgeQSTsF2RBT+yQpQy9pWjpugS0kbUsqtiZBkCWbCZ7XzKTxkP770IYRDC2Ki615ywh7qbWqdzA9qp2HnCHW84mg4vhjE+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:58:40.9762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57941d9-e945-47c1-3822-08dc5fafa759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
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

To test RDMA using dummy driver on the system without NIC/RDMA
device, the get/put dma pages pass in null device pointer, skip the
dma map/unmap resource to avoid null pointer access.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 33 +++++++++++---------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 2f2ae7177771..4c512a372ec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -703,12 +703,15 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 		size_t size = cursor.size;
 		dma_addr_t addr;
 
-		addr = dma_map_resource(dev, phys, size, dir,
-					DMA_ATTR_SKIP_CPU_SYNC);
-		r = dma_mapping_error(dev, addr);
-		if (r)
-			goto error_unmap;
-
+		if (dev) {
+			addr = dma_map_resource(dev, phys, size, dir,
+						DMA_ATTR_SKIP_CPU_SYNC);
+			r = dma_mapping_error(dev, addr);
+			if (r)
+				goto error_unmap;
+		} else {
+			addr = phys;
+		}
 		sg_set_page(sg, NULL, size, 0);
 		sg_dma_address(sg) = addr;
 		sg_dma_len(sg) = size;
@@ -722,10 +725,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	for_each_sgtable_sg((*sgt), sg, i) {
 		if (!sg->length)
 			continue;
-
-		dma_unmap_resource(dev, sg->dma_address,
-				   sg->length, dir,
-				   DMA_ATTR_SKIP_CPU_SYNC);
+		if (dev)
+			dma_unmap_resource(dev, sg->dma_address,
+					   sg->length, dir,
+					   DMA_ATTR_SKIP_CPU_SYNC);
 	}
 	sg_free_table(*sgt);
 
@@ -750,10 +753,12 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sgtable_sg(sgt, sg, i)
-		dma_unmap_resource(dev, sg->dma_address,
-				   sg->length, dir,
-				   DMA_ATTR_SKIP_CPU_SYNC);
+	if (dev) {
+		for_each_sgtable_sg(sgt, sg, i)
+			dma_unmap_resource(dev, sg->dma_address,
+					   sg->length, dir,
+					   DMA_ATTR_SKIP_CPU_SYNC);
+	}
 	sg_free_table(sgt);
 	kfree(sgt);
 }
-- 
2.43.2

