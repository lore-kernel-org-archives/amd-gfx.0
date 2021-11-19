Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42FFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E5561B1E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0E5561B1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E376E0F3;
	Fri, 19 Nov 2021 16:28:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C786E03B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 16:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR3OzflXeuyT3CS/C516cbDyAK/6da5mun4BfO7csUIDNmRuPUbsXTMdBjySLlT2FlG9sp2tjbU0lkVz40b8r9Sx228peXNZMFMObGRaztPpVXiPoV2YHMhHFcMceAvZG8Vg9lZCDBC8IA2pUvroLj/wneqsxiBkq2GHZ/Spb/v8Kb2a6JfjNEGAcNAqHOmDSRdS1SVfBukmnRGrJH53bI+ZmrGIz0kHxf+g5eff15LGWnKAiMfQ2ylVQAdg8gwWaxVmFQc6J933U1AXPgntVOOhCXIcbcnMz7BjugNdQrPiJU9tp6d07NMhwxvxX/ADmGWEylQIAO2x9oQR3V4+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9XwYjhWL2f9Q6BdfR9mUq3PgsM7yoTjAUlhqkEoQaw=;
 b=m0olBPIKYX51QtyeKOXazBd33A8aMtAjUBblqLFribKEC+wKmDyKghSz4oRRoDXkam33DQdDLmv0WzUc+z9kWxe8vwEJHNkrqGgeFJIhOSVQkYjNea555KfRzxOBdUqJbnZQJf16/cdFt67TOFq5qKQcjajI9rDrLD7+euu6MiEiQDr+pbONkEztNSpeHVv0Voa5HlnZNaKTd16LeaIgQ4qvKAcpiSWODBMC4NIr+eOVQ3NVqeJdrMHjju+KifF6iyymeZdH1ZBL9LrbMut+EszV+mZZrSpdJNuyD9VXF+s2L9tD5Gpgmhb7UCxrlBTNr2dfva1LJk/FzcoIlcpQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9XwYjhWL2f9Q6BdfR9mUq3PgsM7yoTjAUlhqkEoQaw=;
 b=C3VyYeLr8R+x4AR9K1oc6iGOZxweVVMJn79YNo6OeAz101zT7TKV4InmhZWuOPBQq69TYPoRYad5nBB4oSfMlPEkPS2bZDtj9I/ZByna0plNnLrCuzAoQufQkhuZwDVuI4AjB89V+gtBWm0cxZDV3EDvHvGH3iJDSBNpc+EuspU=
Received: from DM6PR03CA0047.namprd03.prod.outlook.com (2603:10b6:5:100::24)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 16:28:36 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::21) by DM6PR03CA0047.outlook.office365.com
 (2603:10b6:5:100::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 16:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 16:28:36 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 10:28:32 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdkfd: remove hardcoded device_info structs
Date: Fri, 19 Nov 2021 11:28:00 -0500
Message-ID: <20211119162800.2111819-4-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119162800.2111819-1-Graham.Sider@amd.com>
References: <20211119162800.2111819-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a523e95e-2a47-4dce-2373-08d9ab79a306
X-MS-TrafficTypeDiagnostic: MN2PR12MB4064:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40648A2F0E72286F08ECD0F48A9C9@MN2PR12MB4064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzUuR8ZdlhX3l/04LydJlu+XLhpeW2w/F+1AaIH7OW7UvQCQogi9CkRNMmFF6mxF/WAmw0zHGGoUU2g7fqbei5THCen2N6NHAC1VSeVEKoYCZBOsxCW8S+N/rMrLcuLF9wFxYZkj2gM6STOUkjrCwrNBUbLvHzITQqhREJUgpNavXuLLKjCPjb3wAy2tXt4B4Ds5XCqZGFCKw5ojg4JyFbq3Ixx19iSSCOX/fST8Dhx/JvwNRYxJM4z4gB4D0t7R/hzYZ924n06Is9WvHdpwgc8quWLwextDKaoTiBAMal5uGa3w+0w2tPGTqiAUpYY+yN3EFwWoORefK/QxiyGOCm5aGb+PMtvbkGobrTpdFDIDUWmkpBPhJqpyRqZu9uv7LBUIg0+CWlioYq/mkR3F2kHj3YsInIdrwuDnb+hI522dlh4yVrfxXEw6eJf1MXTgDUheGtljyA8iHMpanTzw5NuMoBE8eQnM0lyf8GxRNlHRI3sfyHgIgj1WobrOG1z2aei8V5imTOXgVjQCtNYSOmO0la6hNz3+CPOYhr3izXmBozsBLgQ0WEQldvDoSn+qpy1expCwK+6agZTzD492xOeimgl8hn/WQfdIIXkDdETuf6FK5DisfcX+XY4w5nGcfva+Zud5RyQz/dDIYFfNwmJBqlZbGjoiCNe0d3q8CLvDnQu9auUHBMV113pywPfhm6J3f5/myHc/AKn+BiiinJ9gdjW0K+jHJzRfo6j7WeU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(336012)(2906002)(316002)(2616005)(36860700001)(47076005)(356005)(7696005)(426003)(83380400001)(5660300002)(81166007)(30864003)(8936002)(6916009)(6666004)(70586007)(1076003)(70206006)(16526019)(4326008)(82310400003)(54906003)(26005)(508600001)(86362001)(186003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 16:28:36.3297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a523e95e-2a47-4dce-2373-08d9ab79a306
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With device_info initialization being handled in kfd_device_info_init,
these structs may be removed. Also add comments to help matching IP
versions to asic names.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 469 +-----------------------
 1 file changed, 17 insertions(+), 452 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 65e0eb5e2926..536cd227c9d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -53,458 +53,6 @@ extern const struct kfd2kgd_calls aldebaran_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
 
-#ifdef KFD_SUPPORT_IOMMU_V2
-static const struct kfd_device_info kaveri_device_info = {
-	.gfx_target_version = 70000,
-	.max_pasid_bits = 16,
-	/* max num of queues for KV.TODO should be a dynamic value */
-	.max_no_of_hqd	= 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = false,
-	.needs_iommu_device = true,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info carrizo_device_info = {
-	.gfx_target_version = 80001,
-	.max_pasid_bits = 16,
-	/* max num of queues for CZ.TODO should be a dynamic value */
-	.max_no_of_hqd	= 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = true,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info raven_device_info = {
-	.gfx_target_version = 90002,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = true,
-	.needs_pci_atomics = true,
-	.num_sdma_queues_per_engine = 2,
-};
-#endif
-
-#ifdef CONFIG_DRM_AMDGPU_CIK
-static const struct kfd_device_info hawaii_device_info = {
-	.gfx_target_version = 70001,
-	.max_pasid_bits = 16,
-	/* max num of queues for KV.TODO should be a dynamic value */
-	.max_no_of_hqd	= 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = false,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 2,
-};
-#endif
-
-static const struct kfd_device_info tonga_device_info = {
-	.gfx_target_version = 80002,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = false,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = true,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info fiji_device_info = {
-	.gfx_target_version = 80003,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = true,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info fiji_vf_device_info = {
-	.gfx_target_version = 80003,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 2,
-};
-
-
-static const struct kfd_device_info polaris10_device_info = {
-	.gfx_target_version = 80003,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = true,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info polaris10_vf_device_info = {
-	.gfx_target_version = 80003,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info polaris11_device_info = {
-	.gfx_target_version = 80003,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = true,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info polaris12_device_info = {
-	.gfx_target_version = 80003,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = true,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info vegam_device_info = {
-	.gfx_target_version = 80003,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 4,
-	.ih_ring_entry_size = 4 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_cik,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = true,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info vega10_device_info = {
-	.gfx_target_version = 90000,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info vega10_vf_device_info = {
-	.gfx_target_version = 90000,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info vega12_device_info = {
-	.gfx_target_version = 90004,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info vega20_device_info = {
-	.gfx_target_version = 90006,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd	= 24,
-	.doorbell_size	= 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info arcturus_device_info = {
-	.gfx_target_version = 90008,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd	= 24,
-	.doorbell_size	= 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info aldebaran_device_info = {
-	.gfx_target_version = 90010,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd	= 24,
-	.doorbell_size	= 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info renoir_device_info = {
-	.gfx_target_version = 90012,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.supports_cwsr = true,
-	.needs_iommu_device = false,
-	.needs_pci_atomics = false,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info navi10_device_info = {
-	.gfx_target_version = 100100,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.no_atomic_fw_version = 145,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info navi12_device_info = {
-	.gfx_target_version = 100101,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.no_atomic_fw_version = 145,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info navi14_device_info = {
-	.gfx_target_version = 100102,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.no_atomic_fw_version = 145,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info sienna_cichlid_device_info = {
-	.gfx_target_version = 100300,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.no_atomic_fw_version = 92,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info navy_flounder_device_info = {
-	.gfx_target_version = 100301,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.no_atomic_fw_version = 92,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info vangogh_device_info = {
-	.gfx_target_version = 100303,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.no_atomic_fw_version = 92,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info dimgrey_cavefish_device_info = {
-	.gfx_target_version = 100302,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.no_atomic_fw_version = 92,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info beige_goby_device_info = {
-	.gfx_target_version = 100304,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.no_atomic_fw_version = 92,
-	.num_sdma_queues_per_engine = 8,
-};
-
-static const struct kfd_device_info yellow_carp_device_info = {
-	.gfx_target_version = 100305,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.no_atomic_fw_version = 92,
-	.num_sdma_queues_per_engine = 2,
-};
-
-static const struct kfd_device_info cyan_skillfish_device_info = {
-	.gfx_target_version = 100103,
-	.max_pasid_bits = 16,
-	.max_no_of_hqd  = 24,
-	.doorbell_size  = 8,
-	.ih_ring_entry_size = 8 * sizeof(uint32_t),
-	.event_interrupt_class = &event_interrupt_class_v9,
-	.num_of_watch_points = 4,
-	.mqd_size_aligned = MQD_SIZE_ALIGNED,
-	.needs_iommu_device = false,
-	.supports_cwsr = true,
-	.needs_pci_atomics = true,
-	.num_sdma_queues_per_engine = 8,
-};
-
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size);
 static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
@@ -632,11 +180,13 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 		break;
 	default:
 		switch (gc_version) {
+		// Vega 10
 		case IP_VERSION(9, 0, 1):
 			gfx_target_version = 90000;
 			f2g = &gfx_v9_kfd2kgd;
 			break;
 #ifdef KFD_SUPPORT_IOMMU_V2
+		// Raven
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
 			gfx_target_version = 90002;
@@ -644,69 +194,84 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
 #endif
+		// Vega12
 		case IP_VERSION(9, 2, 1):
 			gfx_target_version = 90004;
 			if (!vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
+		// Renoir
 		case IP_VERSION(9, 3, 0):
 			gfx_target_version = 90012;
 			if (!vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
+		// Vega20
 		case IP_VERSION(9, 4, 0):
 			gfx_target_version = 90006;
 			if (!vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
+		// Arcturus
 		case IP_VERSION(9, 4, 1):
 			gfx_target_version = 90008;
 			f2g = &arcturus_kfd2kgd;
 			break;
+		// Aldebaran
 		case IP_VERSION(9, 4, 2):
 			gfx_target_version = 90010;
 			f2g = &aldebaran_kfd2kgd;
 			break;
+		// Navi10
 		case IP_VERSION(10, 1, 10):
 			gfx_target_version = 100100;
 			if (!vf)
 				f2g = &gfx_v10_kfd2kgd;
 			break;
+		// Navi12
 		case IP_VERSION(10, 1, 2):
 			gfx_target_version = 100101;
 			f2g = &gfx_v10_kfd2kgd;
 			break;
+		// Navi14
 		case IP_VERSION(10, 1, 1):
 			gfx_target_version = 100102;
 			if (!vf)
 				f2g = &gfx_v10_kfd2kgd;
 			break;
+		// Cyan Skillfish
 		case IP_VERSION(10, 1, 3):
 			gfx_target_version = 100103;
 			if (!vf)
 				f2g = &gfx_v10_kfd2kgd;
 			break;
+		// Sienna Cichlid
 		case IP_VERSION(10, 3, 0):
 			gfx_target_version = 100300;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		// Navy Flounder
 		case IP_VERSION(10, 3, 2):
 			gfx_target_version = 100301;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		// Van Gogh
 		case IP_VERSION(10, 3, 1):
 			gfx_target_version = 100303;
 			if (!vf)
 				f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		// Dimgrey Cavefish
 		case IP_VERSION(10, 3, 4):
 			gfx_target_version = 100302;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		// Beige Goby
 		case IP_VERSION(10, 3, 5):
 			gfx_target_version = 100304;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		// Yellow Carp
 		case IP_VERSION(10, 3, 3):
 			gfx_target_version = 100305;
 			if (!vf)
-- 
2.25.1

