Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AEFC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 20:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB82C10F856;
	Fri, 12 Apr 2024 20:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLeqpaDa";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E515C10F856
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 20:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P47RNursawjoYAmct9fb/zZRBpNEON3SY48XDyAja6XhaSMLwoupkltSRI7Xdw1+8jvbtzMsfYlaiBagSPajBBuK5D+TVvX0Bs0jXf0/TxwUgZgC3gUoTuVbI8SJzacfNlTp+/b89rPhQ8Vqcghx2rJVh1tN7B/gLOGq7qqnchlXq8TlloCNmvfdPpqGw42pfVRRtfBlVV8o5GuQI9w4avK2RvCA8lm+JCBIi1iXqFigr5uDpIxmqOdD/8ZNqTzuWrvFUejVeQJ5s/2IuCDfrMC4mVVPXgg4AMCHhKu7wocjWd/2foHp6lDuysJzrFVm6zTMj5YmIoVAPwlRUyhJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nynQjdBdwu6Kt7uaDmxOKC5oEnw29H/ugBvTOFAf/II=;
 b=UFOqY1QnXCvJZc+TWh+pHwQSGS25pVXkNtVV8PlMnREhWvqFt1EanqmMKQcLn0RCBaXYXedM0N5Cz1sKAUHueGvgrK/zS8FEIRrCnKLvGwl2BzLj7Igj6WfrZiaTZfvPmp+CosyKuo31qlJV3oaJfJHWEJ0Nx0MnWLxQRuq08QU929Yt6BpcaSr6Vs8pcDkAgzgAMeruVJ8M2PbcJpBQ0hX9Omt4D+mW130CRuuwQIwyEjawaKXtcBj7ToWLFbZoQMQekfH03zd3SYoRCloj4SRMtPnvkpjv5/O3O5ysmtPcNP6LmQbS78tYbTsKYN5lEoSK8d3aqUJg3EmIjC2WdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nynQjdBdwu6Kt7uaDmxOKC5oEnw29H/ugBvTOFAf/II=;
 b=xLeqpaDaCl3LcskrBTdT38iFHE045EGsuZxTv81m3wwM54TxFTOmN3j8/+Vgx6dBNRAa2nL1chtggoFlWZmt1wrGDo79SUPnt92dZPV2MfJYLQu+ccscKq0SRz4/OK1pO3q2JbJCDlK8crW6c3RZZDKZ6IKdkTZcXWmOdZL97nQ=
Received: from BY5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:1d0::15)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 20:13:45 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::97) by BY5PR04CA0005.outlook.office365.com
 (2603:10b6:a03:1d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27 via Frontend
 Transport; Fri, 12 Apr 2024 20:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 20:13:45 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 15:13:40 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: Skip dma map resource for null RDMA device
Date: Fri, 12 Apr 2024 16:13:00 -0400
Message-ID: <20240412201301.14154-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240412201301.14154-1-Philip.Yang@amd.com>
References: <20240412201301.14154-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4580fd-9846-4c8e-b0ad-08dc5b2d0e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cx39pWdjTDQms0KJZE3HCbd/R7eKh3jFlwyZo1cRhHtM3Rk+kluREFiCtr1dvmsUiCWhyNBZEjgWfaxKagPli26QAyAjqWxUQIkKEDJcdHnNLjc/xgDrD9sCH3isFR+QC3DkH0SkHXL8K7Ty2ngyZ87E1UKj+RPBOLpw3zTEO2/aKYw05WEuviiY/S5z3RMNdETzamEFKc10SlznNfkoKhfBIh1MEHw6nvxvOKm0q0CX2nMvi7XCSYqiptWBwYLcSsKb5JJ+6r8utD+priRmeWDx2jeW9uwO56i0Fptiv1hP9kr/GHhiA11tNsmfKT5MLnSFQFc5i+64Rz1xHzdfOKL9b2HbN7UD1alXFdOlPMUkiPCJ6R3XYiAfuURDiH16kk0ItJXZQ9xzDXvbb8K58To1jaRMCbhYwJqkNHIjFOCZQ+rHXwrmPHbclUs99wLcIImQlwNOd00/ZzcJz+36yYgeYrtdYlHHmvBlfQxy0T2gyc4T3gfobjpf+Wv5iuEfh9Dbl9gp0R2y641v+plr9WdL/rb0FW73T+xhzgstwQ21VzaUjd4nnaeKVRlxKujYVsbQ40uRvjVoXDQR44p+6tbWwSQz/yuMXp9JsVpl1NeKAipQH0zBa/ZksgE6lcQwbbd84wvI8hZpIuALPMj8IiGhxB+hQ5fANmdTsiNbyaAVFTHdnD7tvgvhImsu6xrLK+qmnv3QCDR0z8tjC4e2DxbOfE4uEyMi9zEIwYGU+ZPR61OJzofhBAfhLWVnWG3Q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:13:45.1890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4580fd-9846-4c8e-b0ad-08dc5b2d0e6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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
device, the get dma pages pass in null device pointer, skip the
dma map resource to avoid null device pointer access.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 33 +++++++++++---------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 1d6e45e238e1..93fb63f4dae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -674,12 +674,15 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
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
@@ -693,10 +696,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
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
 
@@ -721,10 +724,12 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
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

