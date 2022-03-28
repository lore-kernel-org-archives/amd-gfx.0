Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729EDC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 08:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F361010E63F;
	Mon, 28 Mar 2022 08:48:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 841ED10E63D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 08:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+k5/IpC09z6c0YpwBzVRB2eXRnmr05B3mvSrS5B1Fa8f/ZLVQe8lGjE+/R8Rm20/R25LinqYnirbvqrzzdIB86Ilmrky/GisqRsgE7kl8NYjQPrkEiwSIUyAh5cfz0yuMpPy/okKEuVFnwgooHt+6tyuUvh89gpIcR6nQwS3smA6mPCOCqEnRN771F3HMbp0tbNNPcbNAAmLwVodPPBS7xCJICT+HTNsk21S1aDubq2GzKIh4qoNrOeH6u9OoFnqmMf0XmI9cXWYuNOFyBi7yjk6TDm4zoeS2v+U0LM3NtPE7Jxu/HChh5Nc9sDJD1BmhVpmfAnml+//IAe1gUL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOsRT74o3kgwRSkfJpditv/e7z4Rud5WHtB25xYN/g4=;
 b=EoXWDwIADn3HKO8Hr43xJPTuwOiocRgivMoFl8SAdF4koEllxWnhoQemxqSk4+0PHFpsO1d/vC79+pAawaoJnbjC4HL7+Tu0BUA/mXLB5OrFMqREsZoipLesiv+TOReDU+dZYYalu+ko2vwfm/5CI+sl1AUzFBe4iyz53NGdUiIzUyvXXJ67BMOhWhiAvXmdPKPYZdHogStJOCsMYd/DZL0K9fL/YXpogK9VK3ac4dI2mRnrS8WRUScfRXRAmKrFRncggsQP/LsS+RcTh58wlJT2Omcain32Fva7OiRtIV3oUs3StCIPjRN1EXL7o6NUiPkduj12Wuf894z/aL45bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOsRT74o3kgwRSkfJpditv/e7z4Rud5WHtB25xYN/g4=;
 b=CbSwPvwmnSGlb5MHKWTIWtKIusSgGo/vlLElGS3+0Gp+Lka0U0tgNA432ouYgZiRi9hHJAdONeq5pYalqT7vzhmLFpRrlCNYtQFEp8KnuHE5aMlBDUJh8RVibzrKSn31jmodjnvSM85Y3LCmNJldO8V9D0SpzBmlzyQtlobFjsI=
Received: from DM5PR19CA0072.namprd19.prod.outlook.com (2603:10b6:3:116::34)
 by MWHPR1201MB0047.namprd12.prod.outlook.com (2603:10b6:301:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 08:48:01 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::ef) by DM5PR19CA0072.outlook.office365.com
 (2603:10b6:3:116::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 08:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 08:48:01 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 03:47:59 -0500
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Reorder ttm_resource_manager_evict_all() before
 disabling ttm resource manager
Date: Mon, 28 Mar 2022 16:47:10 +0800
Message-ID: <20220328084710.6569-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 037a839d-c17e-4ba3-27f4-08da1097aa84
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0047:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00474F87E15342CB545A9436E01D9@MWHPR1201MB0047.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvrb3xJ5/IubED0b2E1pvBKzT/1opCJ6NRySf1t3B/q3284YyKg40U7u1w8QUMRB+TJyQpGCRYPE2I5i6XG2M9tvpMn1d06ywBzZ9M74mIaZqmM4uzkO6GijIfcviyw33KfbGWVE1iLJ//3o7AFN4RDsv9bm62nfolRmkhoD7GTHkZhvzzzSlJIFFysT4QaqHnIuTfkzS3RzFT1IrXe9lSfH40rFK1K/EIvPCf3kIIVZNYIzeBtjfIMjll6rYM1eR4R8fsDCSrRyyaznDeu0vHLt+IDpuH8EeJaERSA0c2ypS+tyOVGNxDwBtfGaGbcV0hhr+tIq6qrGbXKIK3lbvPgR9/UBBnt2lxucaArUL04QRgysw+HOrL9wk/led/H0ivt2mi4HMj/KPH24BmIcIaNrBT794KLRRRTEMPXTv5pB4cHfIMp0X3VWiIZXqKE3F3893LwOFapadkbGoxrt/irfgRWAKPxbiMK3cquXNA24RUm877ynb82TJ4xA5NL7/Ai+VKC1RcAYwJrhoHcm4jZMGy1hT97GiqD3eVZIrXLpRNcnecn8GujWpkslHJ4gKmqSDSWkNlydaFSq0ndG/zvz8C7eo+ikjZk6LAiwa7qKFrC58FPlZsqZZAo06Brta8DtT4BJ5AvRZmf+DmGUbUAQoDHwYDDbtx2DpDCpW6u1dOsmYeVclqlovO4MdoBSbMZSc4JrouXqHjRltB5PVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(81166007)(36860700001)(8676002)(2906002)(8936002)(47076005)(6666004)(70206006)(356005)(4326008)(26005)(110136005)(6636002)(54906003)(7696005)(82310400004)(70586007)(86362001)(36756003)(316002)(83380400001)(508600001)(40460700003)(336012)(426003)(2616005)(16526019)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 08:48:01.2146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037a839d-c17e-4ba3-27f4-08da1097aa84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0047
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
Cc: yuliang.shi@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ttm_resource_manager_evict_all() evicts objects out of resource manager
until lru is empty. ttm_resource_manager_set_used() WARN_ON non-empty lru.
This patch exchanges these two function calls to avoid following call trace
during amdgpu driver unload:

WARNING: CPU: 6 PID: 22873 at
include/drm/ttm/ttm_resource.h:229 amdgpu_vram_mgr_fini+0x145/0x160 [amdgpu]

Call Trace:
    amdgpu_ttm_fini+0x2c2/0x370 [amdgpu]
    amdgpu_bo_fini+0x25/0x90 [amdgpu]
    gmc_v10_0_sw_fini+0x2b/0x40 [amdgpu]
    amdgpu_device_fini_sw+0xd2/0x370 [amdgpu]
    amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
    drm_dev_release+0x28/0x40 [drm]
    devm_drm_dev_init_release+0x30/0x50 [drm]
    devm_action_release+0x15/0x20
    release_nodes+0x19a/0x1e0
    devres_release_all+0x3f/0x50
    device_release_driver_internal+0x11e/0x1e0
    driver_detach+0x4c/0x90
    bus_remove_driver+0x5c/0xd0
    driver_unregister+0x31/0x50
    pci_unregister_driver+0x40/0x90
    amdgpu_exit+0x15/0x12a [amdgpu]

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index c5263908caec..e472a0d639fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -308,12 +308,12 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
 	struct ttm_resource_manager *man = &mgr->manager;
 	int ret;
 
-	ttm_resource_manager_set_used(man, false);
-
 	ret = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
 	if (ret)
 		return;
 
+	ttm_resource_manager_set_used(man, false);
+
 	spin_lock(&mgr->lock);
 	drm_mm_takedown(&mgr->mm);
 	spin_unlock(&mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index 786afe4f58f9..798be117c3bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -182,12 +182,12 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	struct ttm_resource_manager *man = &mgr->manager;
 	int ret;
 
-	ttm_resource_manager_set_used(man, false);
-
 	ret = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
 	if (ret)
 		return;
 
+	ttm_resource_manager_set_used(man, false);
+
 	device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
 
 	ttm_resource_manager_cleanup(man);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 6c99ef700cc8..f94f2b271544 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -718,12 +718,12 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 	int ret;
 	struct amdgpu_vram_reservation *rsv, *temp;
 
-	ttm_resource_manager_set_used(man, false);
-
 	ret = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
 	if (ret)
 		return;
 
+	ttm_resource_manager_set_used(man, false);
+
 	spin_lock(&mgr->lock);
 	list_for_each_entry_safe(rsv, temp, &mgr->reservations_pending, node)
 		kfree(rsv);
-- 
2.25.1

