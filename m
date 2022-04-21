Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567FCC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 12:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011F910E05F;
	Thu, 21 Apr 2022 12:33:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2A210E05F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 12:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SumWlzwCwRfSe2OC51eDWnhsaalmNsPpg04dXLFsrbeV+Tg7lek8/z8GXVMQwQby/GQhFbUDxKGOxd7tUEFJkTFOn4A4fg2q3CrDW0n/1pYwUeypk2DIhmVcv4HjeweTkgNunGf7OguiFyck81wPskLflS0Z7zWe4QhohaS8Veu2nU7IshSOytGb6PouZxOcKXxkJUwBdiVx2RP4O/ndIrkDeWsRpZ+EfVKxk2iLfQkj0yEBq8jipRz+Gd0mI8J9JiSdRzyZZQGKWWQ4HJ+ClF+rTSiDb9m9FSSyB18DrAQsm2jYPRMD4AbyWtkWuwiCmpJIV59MM2LsuHKlcJMajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tQEKRL5RDzUm2XaTdBQCuVz6YnNEwM1UWZ7wxvBqOU=;
 b=kxDyVVBx8KXAywVg4dO35aBlSa2sJcBSZg+kB9gLq8/Yt3DqIwlFuHam9YZEbdWDlJ25eCS75nbasRgaOev/y6g9XhCY7RRP0CUl2mYZG/phEcka5agqFlr8gm7dA53QTBN+zP5U/9orKsTBHrVUtnNSR6iUmr3+/jrEwBlTH0hRGIC3YH+Xdyq94R/wpJtfDTPWjWH5ENSojAGVEL8/a1kCiX6pAd71xLnIk1OC8GH6A4m+jM3ZhUxKlgrLQ4vCTtMiPbv/p9EEQ0aikgAkAWiwapShMgy4N+yuH0YXo5XyDWRvvhULPAZeECi61g4YfNekX5zcwYWwythqPKJLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tQEKRL5RDzUm2XaTdBQCuVz6YnNEwM1UWZ7wxvBqOU=;
 b=QXwnQUZ+IJU2UPRy+yAtt0O/4qfrhbShYlc4wnOW972zmv0zNSc14MKvTz43ehaJzhSAK6hUIzETmC4uiR4fVQbvcdLVlIfIpOCE13IOGl2h0i6HOOw6WmyH9EqdI6oXmclydOeenyrRslfgqXcTlYO34wYTyLuRM39aeXolel4=
Received: from BN9PR03CA0150.namprd03.prod.outlook.com (2603:10b6:408:fe::35)
 by SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 12:33:37 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::ef) by BN9PR03CA0150.outlook.office365.com
 (2603:10b6:408:fe::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 12:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 12:33:37 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 07:33:35 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: use kvcalloc() instead of kvmalloc() in
 kfd_migrate
Date: Thu, 21 Apr 2022 20:33:22 +0800
Message-ID: <20220421123322.1833664-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc206ac-07e6-48e4-a22e-08da23932865
X-MS-TrafficTypeDiagnostic: SA0PR12MB4589:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4589B6929D1DEEA531168A1B82F49@SA0PR12MB4589.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZftnXcxVrZ/z55PjjvcCVdRErPDg9953zn5Ydyvg7XzASuIL55pqIEKrZ+tVix/7P0elDVdHoB9zZGURWHj1edU7nr1PMYIHnvV/xLXVqx/MGhRDPnaEdplq7uBzP1Q3glVty6cDkhSM6nrfLxD6qvo6GjPyj38O6sVyXN7wOVbjJ4noIthTOoEvoOoSwwMIkOQOnnk9rwpKtH1VCDPCV0wv3RJ2ovvHTkwF9cYkY5JPFVPsjmPzP0GejCBQHj8G3+95xEPHaElbSWdJ53da+9FcVpkYkOEQCeOK6Mu6cxmLihEn2vghwebPyHSqSoNsjU7JSwRfUCuFpZeY88s/cHTY7GKceYaC7QPIFyNC+7Y33hsrpt6mP/yHkD8Q4nKWGh19dgtF5eBqfJNSYbnvCPO6bFPvX+guWgBsyWnO3UFgH42i1V3KfTIRmXsKAWC92JqzFlhUZp6UcAuzmYLsZ9P1awQj6DEtWKDvasLoNjqOi1i9Bc2UsWcXAPCIs5cvpfeMxwGfqJE5cxl8BnZhXotSIpfZ+e1EZo3COn7rVF+wO/E8UR39nyAFutf+RU1QXMnhz7Ei8D2HEQVK5X2t++dJ1cVxUryJGGeAbyrNd/6O0fvrJSp8o+iLfJnWDiiN6/c98/eSgWnzFrh9dW6lAw+7EcNRqjYwveh9b8a8vAwbu0haj1PefTXKSOffPzzcU6hHKnk51pR7qyRjay1GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(54906003)(70206006)(186003)(70586007)(4326008)(16526019)(508600001)(8676002)(81166007)(6916009)(2616005)(356005)(316002)(1076003)(86362001)(36860700001)(40460700003)(336012)(6666004)(47076005)(426003)(26005)(2906002)(83380400001)(36756003)(8936002)(7696005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 12:33:37.0479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc206ac-07e6-48e4-a22e-08da23932865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
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
Cc: felix.kuehling@amd.com, Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

simplify programming with existing functions.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 3a29d857640b..43cd47723946 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -410,7 +410,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	struct migrate_vma migrate;
 	unsigned long cpages = 0;
 	dma_addr_t *scratch;
-	size_t size;
 	void *buf;
 	int r = -ENOMEM;
 
@@ -421,9 +420,9 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
-	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
-	size *= npages;
-	buf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	buf = kvcalloc(npages,
+		       2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t),
+		       GFP_KERNEL);
 	if (!buf)
 		goto out;
 
@@ -665,7 +664,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate;
 	dma_addr_t *scratch;
-	size_t size;
 	void *buf;
 	int r = -ENOMEM;
 
@@ -676,9 +674,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
-	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
-	size *= npages;
-	buf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	buf = kvcalloc(npages,
+		       2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t),
+		       GFP_KERNEL);
+
 	if (!buf)
 		goto out;
 
-- 
2.25.1

