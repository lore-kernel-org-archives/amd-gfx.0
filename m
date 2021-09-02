Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E785C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 20:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F0260F4B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 20:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30F0260F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B005E6E808;
	Thu,  2 Sep 2021 20:27:52 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 592C76E808
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 20:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwynF6bOtfpE6rd7uh2YnIzNKXw1TJPIKCq6LiCyxuyeBzurkzZpu6xY1gm0vhu7sQ0+vy15c3nOp0ezR6PQsk65uFteXWlCtVlG6tCTyNumCE6ISm7IRNVlIfoXr3Z8iRvrhrvH9i8RoK3/eiuIhqLNtTo//HcxX9NZHGpsQ6p6XG0NX46cHxHkbG/8lUq1JKXfwRtU3GMqpeweZNcvUK47OH3kjNUvdzm9eWLUTC3oHSpun1ccXqNIbgS+dYwPDH0TCvG7P9qUDg1qrBo3FmCjr7jnXpFXW8dKgYCoWonoz5VZaohx+3yDNWQnOxVRQDCKZhQaaA33vbHUyZjJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=OBMlUMKpdk/Oqf5Ai2xJbyb8TrT6ZnRNNsttfs5V704=;
 b=KkTVdJuFsPksPyzhR2vqQEyZY6MlBUxYCsZcN0XfNTNJR0Bv1NihDyiYJUt9xB9YIIjGp8cNKYfUvdsZPVKagXuyqeiVzAPUayhTOxOSRdQy3hDesJcOagZSDZjkpDH2XLBo1oySBFb1OOiufu8tnPewaGta4+zrIIpQ9H9EZuV8KVZ6Ff8HO0RMwYGzjwq5ZjOQ0RjP0nQJlz372opu7CzBF5r1tjbS4UUsnmtj+37ik26pLjuXEbIzpzCwkgAbqySbVkPQsg561OGDKQotNNxF5o8+q6KAkMoJdm1EHynvwP4t2IZ7+mK8iSjOM4yNPJdJzeWf1K4SnHWhkhyK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBMlUMKpdk/Oqf5Ai2xJbyb8TrT6ZnRNNsttfs5V704=;
 b=fatXzgZaTOM8hW3WnOXDTIKRwyzjCqBJBAN7HebRGLKSklxeXIa+a12+vLfUnyfGTryEJn1tcBS/AwzQv+seXZqs+aJEctKaePbCfAMA94TkvPX7W4TtlCqGJvbowUKcOtZ135ifOyzdojNCYSh13fBxpJbrDjm4A6xcDT+svfM=
Received: from DM5PR06CA0093.namprd06.prod.outlook.com (2603:10b6:3:4::31) by
 DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.20; Thu, 2 Sep 2021 20:27:49 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::69) by DM5PR06CA0093.outlook.office365.com
 (2603:10b6:3:4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Thu, 2 Sep 2021 20:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 20:27:49 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 2 Sep
 2021 15:27:48 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Oak Zeng <Oak.Zeng@amd.com>
Subject: [PATCH v2 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
Date: Thu, 2 Sep 2021 16:27:09 -0400
Message-ID: <20210902202709.217004-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ec465a3-aee3-4442-f688-08d96e5021c6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5053:
X-Microsoft-Antispam-PRVS: <DM4PR12MB50534C957C8420279E31D8F792CE9@DM4PR12MB5053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8cUStVsjhq00dE8zgfqbf/pxtk3K1VnDFaP9Kf6urLkDS1dvBD4D1vyGsNGO5ATOaQ+B48BMH5yVWz1rhKHBSWt37v4WAeDUQiwzVbEBHhmDlHZPYj3nktfIPsTuKOpd8qfVG70MiPeytkSXXs2u/Ml8tJppfAGS66qHASbUsXvVUdSOZMc2Cn+QdT6q+1//IIeAiDjF9/EIeSHXGPahAYJPyvfwG8K8SfQD/Ac+vCX48S12IkIPicjVXDmLmd+v0M39Y7NvjUGhWyCmHh67lxhWYAZbs+u030CTZEOTRe7LummCZhivWH2gjIjS2aM2msR4HZA9gApnrreqtK7TeVWN6UeBtGmCptkGHaw52PsLreMD9Hd6JHOgyMZiBKZyXOIhkB5n5/FySELgZssXT+knuPerrCskEOUqeyuVZ9/FUUaatMQ1Bb8wyonn5ZAHMdDiiC2Q0FYJWuvl4SMW9UU/SsZ5J4G3Zn+egJ5eqF7yz9H9lYB2TCEr3FO5IAOxMaRZEr8fs8Jj6TPahj/6AfX9O3Obg4IPyeKr0cHiYAvr2gPin5LhmQtWfDCQo3BMa8RJ1qN/eMIyJ9AgjZ76AoFuog4BobNeVmtZH06aqSMceGvxmCqJRwy9J7vP7v1fQz0Ma8JNNYT6GrPAN/78iRpGAL1qbAwFSyxCIYjTw5YZKNHkB60cobUptxr9fSc8hzU5UKQNbLLlmDCz2p8OV/I74kC/SR+JuzdAfa/f7M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(1076003)(2906002)(4326008)(26005)(6666004)(86362001)(8936002)(6916009)(16526019)(478600001)(81166007)(5660300002)(83380400001)(36756003)(7696005)(186003)(356005)(316002)(8676002)(82740400003)(36860700001)(82310400003)(70586007)(70206006)(426003)(336012)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 20:27:49.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec465a3-aee3-4442-f688-08d96e5021c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
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

On some GPUs the PCIe atomic requirement for KFD depends on the MEC
firmware version. Add a firmware version check for this. The minimum
firmware version that works without atomics can be updated in the
device_info structure for each GPU type.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13 +++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 16a57b70cc1a..d5379c79c739 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -525,6 +525,7 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 4,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -544,6 +545,7 @@ static const struct kfd_device_info navy_flounder_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -563,6 +565,7 @@ static const struct kfd_device_info vangogh_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = false,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 1,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
@@ -582,6 +585,7 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -601,6 +605,7 @@ static const struct kfd_device_info beige_goby_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 1,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -620,6 +625,7 @@ static const struct kfd_device_info yellow_carp_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = false,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 1,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
@@ -713,8 +719,11 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 	 * supported.
 	 */
 	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kgd);
-	if (device_info->needs_pci_atomics &&
-	    !kfd->pci_atomic_requested) {
+	if (!kfd->pci_atomic_requested &&
+	    device_info->needs_pci_atomics &&
+	    (!device_info->no_atomic_fw_version ||
+	      amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1) <
+			device_info->no_atomic_fw_version)) {
 		dev_info(kfd_device,
 			 "skipped device %x:%x, PCI rejects atomics\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ab83b0de6b22..6d8f9bb2d905 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -207,6 +207,7 @@ struct kfd_device_info {
 	bool supports_cwsr;
 	bool needs_iommu_device;
 	bool needs_pci_atomics;
+	uint32_t no_atomic_fw_version;
 	unsigned int num_sdma_engines;
 	unsigned int num_xgmi_sdma_engines;
 	unsigned int num_sdma_queues_per_engine;
-- 
2.32.0

