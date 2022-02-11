Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255C7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 19:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B405110E1BE;
	Fri, 11 Feb 2022 19:45:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD6510E1BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 19:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfsSseJB6GIGybyZXZsNqd7iDbFJazgZRghFrpw6LMPeUmCqdQoipXnEnHV+hmvU0+ZSk+XuWWE+6w7ji/eR/khLf3wiIF7K3AU9AI9/vrU0g9/0i28isnAY85OdM3e8D21QvRXGNbi5LDfu/YLZn9jXP8FcRHkoTjW81SjU/bEikY3Bcp1USlRVsgAQbExwiitSkTRVcI4pxRBZm4PgyIfFGXgdcIuzxmSAYEsQ4NuqXdp+176kHhLJDc5SvcdUeZrHMAU240+xsNjbrZQPOTZ01Sjr3vjl6Rv+2bSTtIXGC69cOJ1CSpwk/OZnZ4SJaLgxwXpPQWGKxy54OllkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QR5yluPSg5XRjN/KjAiukFQQ6UEKGTkTagKXWDi3sqk=;
 b=TBMncxSmSfcMYdgVzKjTLXK5kP1T6XEHezltLWKpYawDf1KpkVqAmrdVgW2pQ3NVJzL0F4TyXh26H8nm7jQaSYnAjnQEa7Ltu2Fv9n8jKNQ6mEVu6DjHiUwDqN00U52w4RS/Kpd7gr1V2OLW031e6IZqS6RUPtBQ9wkmhFyMMpEIrHOeWvmZIyUV7m84Kli+anHZie43Zs08PHw9Aco9Csy1a4GLyPyrueV4QGEQ33reEjuf0ipZYu9idpqtfaBB4kpPCSdbMfcg8mFdkd2sOaXUGLAYjiW7AicICAPmmyFIDkYsMCR35bbP3luNnmeCFaDScOcSJwQtRqiSaBxmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR5yluPSg5XRjN/KjAiukFQQ6UEKGTkTagKXWDi3sqk=;
 b=airY3WhQPyRFzCFlPhEGYGUDiZCewDivFA/wSP6a9hFDRpI3Qhoml726RvHhCaJovPZTDQoVU/gnYs7iJDLFneGb+9ludp+VHy0WDlMHOmtE1ACUjO5sWaUTfaidpbHnrHdcT1J/StLfQznjWVHf6zdSvKp6jxNXhNe2e1hR4YM=
Received: from BN9PR03CA0482.namprd03.prod.outlook.com (2603:10b6:408:130::7)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 19:45:21 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::29) by BN9PR03CA0482.outlook.office365.com
 (2603:10b6:408:130::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 19:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 19:45:21 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 13:45:20 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration
Date: Fri, 11 Feb 2022 13:45:10 -0600
Message-ID: <20220211194510.24186-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220211161758.29610-1-alex.sierra@amd.com>
References: <20220211161758.29610-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73e22164-569a-43c3-c6b7-08d9ed970a04
X-MS-TrafficTypeDiagnostic: MN2PR12MB4376:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4376788F07C910302AAC3C37FD309@MN2PR12MB4376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mHzWM7deBuTDaan0HjMk1cxW+Jw4r66V+GHzPpNwDOc6qN5TD+ERT47T74+r04g+b6Z/HwJdMHIr+o6Ugbe0gPzX1HY7RJ7sYN9uv8dZg84apl3zr+6NkAtr8840T5iv+u+mrs/edKbqCQ1LZC7gaYyk0FC22gGUs0Yfh/z3NhGT9/jbxFYY2EMEjNqozfSlKdwTHUwXylhTIw3x6FTdspVUIucb6t2nBlZ7+kKTR5m6zfmyy86QE4fcEbBDHAwd7eafG4oKFBJpuxoCIP83gMZw0+1FQcfM5k8I3Z1OmAwOWWj2nJ9lwtvUQNwRSv54kZLNHekpHsiHQE+64V6bC+UOddIT9ZNcAA8kot1p1iWZYgg0z59xbFh5t8LXc+U80rC24/oKDDp4HaP7oe3KM5AiM5+akG94m3xsQbIAGU7I7jPFC4Dvk26um91r6RslhZvA1q555V6tz6gxq71a95k/64wGU87gx7mya6Un6ApC3rHBRytRCIjpXwOxhjqeZRebHtPzAh0gaOJIRRNWsz4gpAbbgJCC4t0Lo0VkW00UKtWaUDDupLwgsUbKQLkFcwKaDOC/qNf53wm+AixSigDH+R6bcj61+R56onkAJFFd/v7mHfXYeP/l0Ckrf16qXP+8f1TeZ2rDLFTb3tNuGk1M/TofkWpUQX0ioeNs5jhY3JrfxN8X9HSBJes3tEVcdoMX+dlKzLQHoJoferxtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(2616005)(336012)(426003)(83380400001)(508600001)(6666004)(8936002)(1076003)(36756003)(16526019)(186003)(26005)(7696005)(2906002)(36860700001)(86362001)(82310400004)(47076005)(40460700003)(44832011)(356005)(6916009)(54906003)(316002)(70206006)(8676002)(4326008)(81166007)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:45:21.2784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e22164-569a-43c3-c6b7-08d9ed970a04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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
Cc: Felix.Kuehling@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid spam the kernel log on application memory allocation failures.
__func__ argument was also removed from dev_fmt macro due to
parameter conflicts with dynamic_dev_dbg.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 88db82b3d443..8ce0b169b976 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -36,7 +36,7 @@
 #ifdef dev_fmt
 #undef dev_fmt
 #endif
-#define dev_fmt(fmt) "kfd_migrate: %s: " fmt, __func__
+#define dev_fmt(fmt) "kfd_migrate: " fmt
 
 static uint64_t
 svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)
@@ -312,7 +312,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		dev_err(adev->dev, "fail %d to alloc vram\n", r);
+		dev_dbg(adev->dev, "fail %d dma_map_page\n", r);
 		goto out;
 	}
 
@@ -332,7 +332,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 					      DMA_TO_DEVICE);
 			r = dma_mapping_error(dev, src[i]);
 			if (r) {
-				dev_err(adev->dev, "fail %d dma_map_page\n", r);
+				dev_err(adev->dev, "%s: fail %d dma_map_page\n",
+					__func__, r);
 				goto out_free_vram_pages;
 			}
 		} else {
@@ -433,8 +434,8 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
-		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
-			prange->start, prange->last);
+		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
+			__func__, r, prange->start, prange->last);
 		goto out_free;
 	}
 
@@ -612,7 +613,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
-			dev_err(adev->dev, "fail %d dma_map_page\n", r);
+			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
 			goto out_oom;
 		}
 
@@ -673,8 +674,8 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
-		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
-			prange->start, prange->last);
+		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
+			__func__, r, prange->start, prange->last);
 		goto out_free;
 	}
 
-- 
2.32.0

