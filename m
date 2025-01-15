Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA13C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 21:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F6B10E820;
	Wed, 15 Jan 2025 21:36:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qPZ4tuM9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D4D10E820
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 21:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+nTM+92Bg7Z6NXYcrIzEy23CqVkEmLmCOqC1PrQo5AgNRQxC8eVjxq9P9b3dUA2LMRzZYzVqFd6LD6MhYb8Ya9VR5tPJpME6GZCfcJJqhwJbREVurpe38ppsDd+2LClhs+ApzPc3Vxr/eCAYIeVx8RDT3cw+4nFyyWY7HAqx4CU99mIxhQRThBdQbUMhJOPHZyfu7Ck4pmHjcDhytad0f62BA3H9NXgvqnd1hhn7RU2J2TAxMlLv/1vRA1FVQK3n+L8HYQ2drX0XJM3g1hhqgP7aLruilwyWUQ2NAnvzmkvaIAkqRVQBOsZULygJtD/SXyfwzOH5q7QblHse1CITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R48J3NqIvpWINcXBXQ7Iwcy6fys/jZ4zGpiWsNALgT0=;
 b=KT0rnMs649Jz3WOMlwlw287epGg3uUAs59oOuug+BWKGEVnoihW9hTeRCSA7oq/q1TerqQ/q0Y77kzGufmJCJGCVzIrorQTOwE7CYLqq7QyUvpVuvFZeDtk/sFlAbU2Yv6VBLPhVABb30WGiddHGtk7rC+WpPPRAOiyImWOt/mHlKVWkSG9WbAlc6CcDeES1kuc6xR9Ov9rinGsnZqSRI54LgrlI9f5TcIuadPRxEXzPVnuf52qM7gMWv6uyoKhT3VHEc4+5nA76KN+h1djPbRdXjGvoabGYs71wghg5uDuubMWqJ4xvstAkDTZ13BS5Zlt0GZ4qt1nxyt7e7dSprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R48J3NqIvpWINcXBXQ7Iwcy6fys/jZ4zGpiWsNALgT0=;
 b=qPZ4tuM9MNhskgSjI2jif6ESjrpIEXJdqVRaVSWU12Y1jNCYk99dsOu20xiZCZ3DK5S0jJz+jMEIb3UaHuZIxcwX3i2MNwtarQivqmmRtlqxBQffPobinhYzDWJHQcN/19xCEUKvj412g9MaLMs+O7q5QnkYcft+OGcGM65FGvc=
Received: from MW4PR03CA0315.namprd03.prod.outlook.com (2603:10b6:303:dd::20)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 21:36:15 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::80) by MW4PR03CA0315.outlook.office365.com
 (2603:10b6:303:dd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 21:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 21:36:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 15:36:14 -0600
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 15 Jan 2025 15:36:08 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, <Emily.Deng@amd.com>, <felix.kuehling@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: Change page discontinuity handling at
 svm_migrate_copy_to_vram
Date: Wed, 15 Jan 2025 15:40:01 -0600
Message-ID: <20250115214001.335607-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: e3351a9a-7bfb-46b5-623b-08dd35aca3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hjxyh+HyZ2Q6yhyPOqio0k5Xf80xG/mC2bnV85I2pKoDZXd5jUqphlHYIaRq?=
 =?us-ascii?Q?GIBVOSX+XLVWW4q2nKhU9Na5YDQ/PAy4mv/2ijfHdYns78j+Sz0hlt7L8fmL?=
 =?us-ascii?Q?jRum6f7m2XqrX5PDfDsyMAZEDHAPha9Xhlz1R7PtTJ0DKTUhzn/exZ/8YLIT?=
 =?us-ascii?Q?dt5jcGm+jTS9ezYNPbkj1uGXYQeX+OmmRK1h0sNXQMFQ3Ba0biNI6JOZ5Qjf?=
 =?us-ascii?Q?0EX6M+Nd6+87v0DR6pmSVX/kP25mUDpXrVgoI0daMiXyE3MgMIui20x/2hoU?=
 =?us-ascii?Q?iFLEMX1hnFePL+9nsOG4jd7JvG2UBVm3MnzKoFHjQ0IMCwvwBCl1tpwdYoWs?=
 =?us-ascii?Q?OPkp34bkeh+ucrIjSbmDkZCVgNxj/qug+tvIKw28fUd+8RgegcSZEQ5sGlJk?=
 =?us-ascii?Q?lllxNf/LsrPH6riQIzQSIIZ4VWi2puIW4PvmSDsoiABJfOSGicla9WRh3Qlb?=
 =?us-ascii?Q?buccODA5KJZOiuC42GflidwuhBB0T7tdbAs84YG0QNVGaPFDOX8q2IXMnW03?=
 =?us-ascii?Q?P+EoCyApmcXmJWxdVtbPYRDc58OcJwDvL/mk/KZ8jUojTlpMkCIsMfwJaFf1?=
 =?us-ascii?Q?PyXVwAlYHYs1SPvEeUqWAl2+04YQeCEi66DX+n42vb4DcJ9VbQJBu+rzElvH?=
 =?us-ascii?Q?aPOnrxIs4OFrZvZrjTF6LyUJj9qB4gJtPakURpdFs1q5iZvxbtfcIn6gVe2a?=
 =?us-ascii?Q?MbYdc8oPGLDeNpPuKs8YHfZfj0MrAUiPzZwZPg0BVe/KLrS9vIc594sbA7QS?=
 =?us-ascii?Q?WGj4tu1aicbbJYWvbUHkz0c22TKnYUJnV7gJA1mA9P2xrLEkfnF63j97ZUXh?=
 =?us-ascii?Q?aBpFi4MFASTEl+icLjiHOnsGdjCS+ym5ovuOLp/unwMQYGIYGhVqTLu3v5NO?=
 =?us-ascii?Q?B12Yy0DIK0/iagi0xa8FlRUBlr8y3ZkkBvow7vwwGe/du1kXPCMQ0TP3Wgw8?=
 =?us-ascii?Q?zRQQCuWyjsqDs6TDODDidsFwNb1twD+tWk5dvoB/f59n3QQK5zkJUf5ip/UX?=
 =?us-ascii?Q?N2qvr7Az9Y6Px5QiNWVmK9ecN/wV7unFKJxb0bRwCaAVNcAnSxktjiRcy42y?=
 =?us-ascii?Q?R256H4a48TKJ7mdy4yc5EmJY1rfqWkY+kRc34bgkEzcsCKaPhDXv6Pq8qPxu?=
 =?us-ascii?Q?6/8uw2ZcQMHewZFMGSNnOvnwYYMhdQ8nVYeREJQ8KXdyoYAYh60S7J5PLfBO?=
 =?us-ascii?Q?Rbl7IuhJovMNoZj0vWnFXu6S3XJEVzwiW7Z9Srw+5UITVD2AVETEYe181jqJ?=
 =?us-ascii?Q?ssaxuj6y80x+zqLeE8Ip1giIIfZo67CRB7cUHH/UQZl8lEMTr7sQVVlACqv6?=
 =?us-ascii?Q?KXrd0KLVgltEXeklIzxr4L3v9LyYOpk8tN0jRErWsL9cFwIek+xqCWu5uq7b?=
 =?us-ascii?Q?CRnLCA090sWolgw3+ET3KsD5Fp1aHLfZFlCLqLzkwB1XS+otlfWJvRIj57la?=
 =?us-ascii?Q?F85ASf0RqNql/Qfkt9e4zw3SC2V5oetUK3Dxnw2q06GXpB4dItN910mpLdTu?=
 =?us-ascii?Q?iCNK/ou72QpZLFQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 21:36:15.4233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3351a9a-7bfb-46b5-623b-08dd35aca3d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Current svm_migrate_copy_to_vram handles sys pages(src) and dst pages (vram)
discontinuation in different way. When src got discontinuity migrates j pages
that ith page is not migrated; When dst got discontinuity migrates j+1 pages
that ith page is migrated. That cause error path have to iterate all pages to
find which page got migrated before error happened. Also makes code more
difficult to read.

This patch handles src and dst page discontinuity in consistent way, has its
logic and error recovery straight forward.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 68 ++++++++++++------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d05d199b5e44..2ce78c77f203 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -299,6 +299,19 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
 		struct page *spage;
 
+		/* accumulated pages more than current cursor's block has */
+		if (j >= (cursor.size >> PAGE_SHIFT)) {
+			r = svm_migrate_copy_memory_gart(adev, src + i - j,
+							 dst + i - j, j,
+							 FROM_RAM_TO_VRAM,
+							 mfence);
+			if (r)
+				goto out_free_vram_pages;
+
+			amdgpu_res_next(&cursor, j * PAGE_SIZE);
+			j = 0;
+		}
+
 		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j << PAGE_SHIFT);
 			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
@@ -306,17 +319,10 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 			mpages++;
 		}
+
 		spage = migrate_pfn_to_page(migrate->src[i]);
-		if (spage && !is_zone_device_page(spage)) {
-			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_BIDIRECTIONAL);
-			r = dma_mapping_error(dev, src[i]);
-			if (r) {
-				dev_err(dev, "%s: fail %d dma_map_page\n",
-					__func__, r);
-				goto out_free_vram_pages;
-			}
-		} else {
+		if (!spage || is_zone_device_page(spage)) {
+			/* sdma accumulated pages before src got gap */
 			if (j) {
 				r = svm_migrate_copy_memory_gart(
 						adev, src + i - j,
@@ -325,29 +331,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 						mfence);
 				if (r)
 					goto out_free_vram_pages;
-				amdgpu_res_next(&cursor, (j + 1) << PAGE_SHIFT);
+
+				amdgpu_res_next(&cursor, (j+1) << PAGE_SHIFT);
 				j = 0;
-			} else {
+			} else
 				amdgpu_res_next(&cursor, PAGE_SIZE);
-			}
+
 			continue;
 		}
 
-		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
-				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
-
-		if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages - 1) {
-			r = svm_migrate_copy_memory_gart(adev, src + i - j,
-							 dst + i - j, j + 1,
-							 FROM_RAM_TO_VRAM,
-							 mfence);
-			if (r)
-				goto out_free_vram_pages;
-			amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
-			j = 0;
-		} else {
-			j++;
+		src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
+				DMA_BIDIRECTIONAL);
+		r = dma_mapping_error(dev, src[i]);
+		if (r) {
+			dev_err(dev, "%s: fail %d dma_map_page\n", __func__, r);
+			goto out_free_vram_pages;
 		}
+
+		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
+							 src[i] >> PAGE_SHIFT, page_to_pfn(spage));
+		j++;
 	}
 
 	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
@@ -356,12 +359,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free_vram_pages:
 	if (r) {
 		pr_debug("failed %d to copy memory to vram\n", r);
-		for (i = 0; i < npages && mpages; i++) {
-			if (!dst[i])
-				continue;
-			svm_migrate_put_vram_page(adev, dst[i]);
-			migrate->dst[i] = 0;
-			mpages--;
+		while (i--) {
+			if (migrate->dst[i]) {
+				svm_migrate_put_vram_page(adev, dst[i]);
+				migrate->dst[i] = 0;
+			}
 		}
 	}
 
-- 
2.25.1

