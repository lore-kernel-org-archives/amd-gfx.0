Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C996606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JWMcEW9n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DA211209B;
	Wed, 18 Nov 2026 22:57:45 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7779F10ECE0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7371XGjugx51lRtRw/WSqmir9b3Xul1sa9Wah48F2Ktc0RecWjEjBtBAcT5K2v41f3JbDOKFEmEiStkshxPIwQglzMsTnBhjSjjzjCt81Ff6GY8FXipLjq5VfFhBbhfxD6Xv1U76I+UAKdZ9NCSYPBINgpFHo71zaSjMJgkUqCZwus+aMhm0HxqQtQyOgx45ESER63tQrRkbH/dGH25Dvi30CYKnOAHHrr6lbwHUDCVi7dpmsmxOzguLqHaGKDnAtwoPfRlB6jRVv8b7GDxfCXsamiXmC/2XyONHNE2wONjdQ2xwgcwX4/He+Wy/FhBCLhuDOD/QoMzE5dk79Uy8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWzrcvO30HVhYq5azH+GdSGXd2Lg/iZ0JwPKuaxitkQ=;
 b=p+n+1SSjxGlM6PoKUs915qQnQYtQYa4aQnZGBBxHfa4rY8HPnST2M1KEpLedOOKdTiqFhLzP6zVLkN9OmFEvh2RSarhzc+37qc90KcBAooKUXzCQxFo8QEp2c/Z/T1W5RIG1Vy+bj2Vp8va2ndExPU6kh9h2/dJpSRBjVPYa+q3SJUHj/qZ/Rc3iGh+KtrcZwPQ+r96Hrowgcc9rQNF6psanUZlzlavFMLj5O5TZ5BbZH0+g/63+8abS7yeAhGOKb3amvm2bajcbWH+LhvhhgwA8gn39Qp+9bVJ9RnwoUCSoqtm8si8CBHDKj17DJQl/4VPfXAZQNVjHQIbhmKfmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWzrcvO30HVhYq5azH+GdSGXd2Lg/iZ0JwPKuaxitkQ=;
 b=JWMcEW9nVrZN3SC0+6bUV1KqO7RO+w7Qzp8EGdOgHkt38hkovgCFPVHCc6yhTyj6gClL05Mz9fhASItue9by3TpuiSaMCnvOI5mhEotpdBnF5oSUPbNwcg0+sYJAjPNG/y4LJihfVfBctI6t7NPRc0N/Y1IoJs5cfg9u18bSqSc=
Received: from BN9PR03CA0783.namprd03.prod.outlook.com (2603:10b6:408:13f::8)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:57:35 +0000
Received: from MN1PEPF000793FF.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::17) by BN9PR03CA0783.outlook.office365.com
 (2603:10b6:408:13f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 22:57:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF000793FF.mail.protection.outlook.com (10.167.249.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:57:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:57:33 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:57:33 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Wed, 18 Nov 2026 16:57:33 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: Fix a race issue at
 svm_migrate_copy_to_ram() error path
Date: Wed, 18 Nov 2026 16:58:33 -0600
Message-ID: <20261118225834.60743-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FF:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: f99417a9-aab2-41e6-08e5-08df45c7552d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|261009223027099003|11063799006|56012099006|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 5Qe/Z4iIAdt8gkl8DZvtT4tvc1je4gjhdiN4kIpTtxP2ptgsEt/RoZKLCWbRl250xJxLq06OBEylbqP0pkNRpgOFVJQ288cffbirx3uZ0YEiEd4N8hkHzFps8XnmomqgpSs0w3UNyJpTp4kN1tsIrliAknG/xL7YLiJdf4JBDYZYbD0uH6zB3awnOS7KDvO4rt1T6XsiMUjudH9GvwKA9j2P8LsDlscV4eE75WX0CSK/5CzDIR4Xg1cKD5+6wswz5ReNZIVe0pU/2jbXMFvjDNbyy1FsMT5xPsuUPZrIkv2Aqq4c5CPryteVF5RGZ2K0R2s+/Iyb+kk9rAzxiAje4poE92OSpHmbyo3y+IFOoKCa83Z+WeODU/zMaFLaU2P26RZYYk6JHnuxjMnKGnpja9HREzvtxgaOB/3K6H3luWMR0qUVce/BzmT2uLxDd2d5Jm/SprzgMzQHEVmBhLbRhbCI+LRHJy4+fw6ghk9x7hWSO6aBQuirQee0NYz5hmjFJ31nuU7Fl7Y79SbtxWH8GW0E3b4li3stT2cuNhQxhMQvr5CiH5tpTLnINtjRfmt1oWQnbkUH/CbawPtVN/qTgWLK4ejNO2bDRtx+gnQ8PXDOp8ilkXbrBw/HZOvKGBQ244V2knei7BXTzwNvT+w1BH4m0LGMoDnto+ejiNsceTPhfqRvQs2GdAKOReKMwb2AUG0pDschnBKcXy/nyKSAvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xuuIO/RrI5I8a0TQcAs2+iiYYyyN3cuYa6K8eeie1F9+YlexcAZYXpgJyqNF4Rz4lKEgpXlubWVxUieyiA806RZN0/tQP82kqcFK5CUZ9vGymOAtjjSHrAMH4DlR/CqFQhxMpe+lu9cOyITj/+PIBABFbHoMok3NLknKRkpY75BJNIK7ayoEBXW5z2xdEOL5GjdrOZByPiUW7rsSzXt7ydv6JXKNwKzQ/45JaMKXmVWr6dC7YnTovZTZTpgg3ILV36p6o5w/yNBLQuzSMI0sVWXXX9+J+vsEEn3AP/R54K61qFdbJvMFyC4BDqTy97jcv1a3ooPRQoe7idU3l9poYy9zbScjagoHW6baE3+zc4gc6TCLIEc72wU9d+feGPI/VqILSlDwomyDMwB5YCHEKHyi1Xgxp2pLl49lshz8kNr6Wa/gIkKbAY/wpLlKNRmj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:57:33.9294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99417a9-aab2-41e6-08e5-08df45c7552d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xiaogang Chen <xiaogang.chen@amd.com>

The destination pages were freed while SDMA copies queued earlier
could still be writing into them, and while they were still DMA
mapped. The mappings were only removed later by the caller's
svm_range_dma_unmap_dev().

With swiotlb, the BIDIRECTIONAL unmap copies the bounce buffer back into
a page that may already be reused.

With an IOMM, the GPU still has a valid bus address that points at a page
now maybe owned by another user. Any SDMA write still in flight, corrupts
that page.

So, wait on the fence first, then dma unmap before release buffer.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8b96e1fe741a..9254d64588f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -716,6 +716,17 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			put_page(dpage);
 		}
 
+		/*
+		 * Copies queued before the failure may still be writing into
+		 * the destination pages. Wait for the last SDMA fence (copies
+		 * on the entity complete in order), then remove the device DMA
+		 * mappings, before the pages go back to the allocator.
+		 */
+		if (*mfence) {
+			dma_fence_wait(*mfence, false);
+			dma_fence_put(*mfence);
+		}
+
 		/* release previous allocated sys pages and unmap dma address */
 		while (i--) {
 
@@ -824,11 +835,12 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	mpages = svm_migrate_successful_pages(&migrate);
 	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 		 mpages, cpages, migrate.npages);
-
-	svm_migrate_copy_done(adev, mfence);
+	if (!r)
+		svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
+	if (!r)
+		svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 
 out_free:
 	kvfree(buf);
-- 
2.34.1

