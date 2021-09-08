Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6984BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 22:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2079B610CE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 22:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2079B610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD15D6E334;
	Wed,  8 Sep 2021 22:48:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8526E334
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 22:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3YSmO3hCrCgJ/lK6CkXeVd8+2nqiuDvYNDj33h3bfTpAxF4WcGJ9Np9m1l4zycJDSDdjbgS45yrWsmsd0w5L+Tovyj8yeBmxJai8QhFmLUzv7vE/WUAlzCKOWzWpuj3o2lXd15iCr+ewO+qYkWPDM+BL0Jw9jhTJs4g/T2ZEBgG5VXlAtboF5aJYgmY6EA0qoosZgEtHpicaO6oFUiPb1e9Z12EZ8zc+iID914XNycINdz1jgVZRV/IE0Pd+zflhmGEuxuZ7d/NwmnHWKazkHDgU3j2eEaFlm9XZmdguMhHgnz1Wv/tC2ov8KQ4qx3D23WwklTvlI8OQpcEyE8jYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=C3wT+FG4ftrnoT8TZQRwDX4G68dzPjnfAAmp/cXTHfs=;
 b=P5lCEEKOmS9j8umgwRvtu7PMJwgeSPRgtKQz64ls1E6AjvdMycgTqyKoq1SQvgfMnBZnMf9aS4xJk7TpaDDj+KeOfI5KCCCO3PoHVZ2AK0Z1FRZ6UnwCKNvt6qz84VR/hC8v0ZU+jJ1UgDRx6+fau/uGUJ48MasUPBFWbUQGgJj7Ok24IkSPZk6iR8OdNazzKAFBSzMfOL+ZBe7hspc7lifF5kBvXxfarvsohcfKFVt8P2o0HWoS0ngqjUw2qtGldomGK3WhcO/S7+qiQlugTDgVyGb3OnE5U0x+A7j7DJmp21AtZLO+z36nqLsl1hqhmV1H+6UMQ0HFUnkb9FpRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3wT+FG4ftrnoT8TZQRwDX4G68dzPjnfAAmp/cXTHfs=;
 b=0V8iAoD1ekZ0NUcOVTQ9MfS+657WLUy1LWmqA4lXKSY0xUQXubhQb+Ya8eRD/zULNcVS4nGeGzzvc5RfhmzgzHIr7LVObWnFvzIi+Z7j0Yp2mr3Y0XefA8z82tQ3BBdzh3rzh1OA6Qx431H1MtRV3DRkSGt5lD9kAIA4n66SYqM=
Received: from DM5PR04CA0050.namprd04.prod.outlook.com (2603:10b6:3:ef::12) by
 MWHPR12MB1663.namprd12.prod.outlook.com (2603:10b6:301:e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.20; Wed, 8 Sep 2021 22:48:34 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::44) by DM5PR04CA0050.outlook.office365.com
 (2603:10b6:3:ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 22:48:34 +0000
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
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:48:34 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:48:32 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
Date: Wed, 8 Sep 2021 18:48:22 -0400
Message-ID: <20210908224822.1500405-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 396a299e-4170-4a78-35e4-08d9731ac9d2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1663:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1663597D342DF444F5951C2B92D49@MWHPR12MB1663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NphhxQqLog8ODS9utd6hUY0eUUKGgqG+FM96z48rKK7pzId8tiYoKmuYIDscxEEWSbMiZbt80hAxUSSWvmz+vsYrObcUsZJuBkIslpjMAJFvboff4dAOoSZYZ0MvWjLhszMyOCvu4KSyXL+0pKG4p4skr52GTNGl3uNBEkMp1APOnhfwfk1GYKQLTreu4Sie0M+gDVB0ygDSKsPOkZ95L93kcxfTZWocozB5DwYHpfGwT51deiNvvDmdoLZ0UpfrRkQDEB6GoIoPJ1OcHBVjBDUy1Vclqn55zXwHRNeBgDDNYc4fig+yGou939Kg6uBIWg9sf9Mv8pBSskChcWlmFrWjW4eBXSy+J3B1aBWZw58gWcrZet0xTOR71aqtwf46+muU+rTls8gqzX0OBlw2XubvZH80pFl4N1miEjk5uzdXCIQWxInT4WPFZI5p32U63xIIjrBoJyRYnORBeIE2gMcnibHBUpXZFci6mQPpbOa03pUp/9KLOHE5rnrE6UZ5k1fysLtjfqn/X4TWQoAgpAzVg88su0dAHrrKZ60V9LCylVXwKbfWjNwtoXqB+dv8gD7qtVIwrXlTq+P998X7A8cyTnuE19cGorJw/WG/qoT2C3swrQGQMS4Qb9KSe/6qwbIIpK3MOkBzkzOVfCbXE6hVNslcQPuT7B7GRQ7/MQqYiv3yiosTADQY/4CYcgHg83eALMME/E3XMUcdyviVvhacv64rU3XGOfS1UKtCKM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(70206006)(316002)(7696005)(70586007)(336012)(16526019)(82310400003)(86362001)(8676002)(186003)(2906002)(478600001)(26005)(2616005)(83380400001)(47076005)(6666004)(426003)(81166007)(36756003)(356005)(5660300002)(36860700001)(82740400003)(6916009)(8936002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:48:34.1027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396a299e-4170-4a78-35e4-08d9731ac9d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1663
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

Move PCIe atomic detection from kgf2kfd_probe into kgf2kfd_device_init
because the MEC firmware is not loaded yet at the probe stage.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 44 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  1 +
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 16a57b70cc1a..30fde852af19 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -468,6 +468,7 @@ static const struct kfd_device_info navi10_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 145,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -487,6 +488,7 @@ static const struct kfd_device_info navi12_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 145,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -506,6 +508,7 @@ static const struct kfd_device_info navi14_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 145,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -525,6 +528,7 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 4,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -544,6 +548,7 @@ static const struct kfd_device_info navy_flounder_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -562,7 +567,8 @@ static const struct kfd_device_info vangogh_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 1,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
@@ -582,6 +588,7 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -601,6 +608,7 @@ static const struct kfd_device_info beige_goby_device_info = {
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
 	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 1,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -619,7 +627,8 @@ static const struct kfd_device_info yellow_carp_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
+	.no_atomic_fw_version = 92,
 	.num_sdma_engines = 1,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
@@ -708,20 +717,6 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 	if (!kfd)
 		return NULL;
 
-	/* Allow BIF to recode atomics to PCIe 3.0 AtomicOps.
-	 * 32 and 64-bit requests are possible and must be
-	 * supported.
-	 */
-	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kgd);
-	if (device_info->needs_pci_atomics &&
-	    !kfd->pci_atomic_requested) {
-		dev_info(kfd_device,
-			 "skipped device %x:%x, PCI rejects atomics\n",
-			 pdev->vendor, pdev->device);
-		kfree(kfd);
-		return NULL;
-	}
-
 	kfd->kgd = kgd;
 	kfd->device_info = device_info;
 	kfd->pdev = pdev;
@@ -821,6 +816,23 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	kfd->vm_info.vmid_num_kfd = kfd->vm_info.last_vmid_kfd
 			- kfd->vm_info.first_vmid_kfd + 1;
 
+	/* Allow BIF to recode atomics to PCIe 3.0 AtomicOps.
+	 * 32 and 64-bit requests are possible and must be
+	 * supported.
+	 */
+	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kfd->kgd);
+	if (!kfd->pci_atomic_requested &&
+	    kfd->device_info->needs_pci_atomics &&
+	    (!kfd->device_info->no_atomic_fw_version ||
+	     kfd->mec_fw_version < kfd->device_info->no_atomic_fw_version)) {
+		dev_info(kfd_device,
+			 "skipped device %x:%x, PCI rejects atomics %d<%d\n",
+			 kfd->pdev->vendor, kfd->pdev->device,
+			 kfd->mec_fw_version,
+			 kfd->device_info->no_atomic_fw_version);
+		return false;
+	}
+
 	/* Verify module parameters regarding mapped process number*/
 	if ((hws_max_conc_proc < 0)
 			|| (hws_max_conc_proc > kfd->vm_info.vmid_num_kfd)) {
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

