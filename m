Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5322FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 15:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D866A6EB16;
	Mon, 29 Nov 2021 15:01:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52546EB16
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 15:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agHZu0vil5qZ4bX2xEo3PpwVOL1Qq87dKE1KmA8SXwxu6NT2z9wyVkCR4fGFOoWBFtRyxnAO4lfKxlJnAtjX8/6NP540pWJqpcFLccUgpuJ8v2t5XaFr+lMvi2Egkw04sVic5NeBXIILKLvzaAsVxuXUXFSp1sB+2IudMoEVE0Z4MM7kReybu/0cTkcc8btIwvvSNq24hKPuuCQ82xWzAOnvnonPPEFqDO9EMMCtgaiL3jXSRjDi0PuRMAfG+eVRs4hdlL2+CNcehob5MeohHf4ufRCuz2a7cR50R2WQWoofr91EqmPUub2sjXzp0DNQ5EFvLOcUe9liVgoujJ6Qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFbmgeuYph6Av22g8w72T/lz1vY4qsilP68Jww48hPk=;
 b=LXeGC6/Fu00a/z5SjsedKFdy/XNL82HKkO8yEhcl+iC2oDdEYYHsuwr6TllrWFc11D55fg8+mkt7aNlhG0moY+tyJceRsy62e5M8VS2emnwptw44vZnl3YfZHgcMvS4oIKm7h8gRhjbuAs6yo0oxheAWuaMtFcR9uqf5lKJxSI/VD/1RnLerPez72eDLU7L2mBil0Z+1ArFFvhdZKaFXZXD/ZDrA1M+jIKIvcANamwJU9bsBIPidgraKhoc4PEm49Hv2awz8GZdRpvLVzyvPwFrfKiBI2IhmMb67GkaPC0Oy/F0oxp6aaCzoB7gDSZCXCtf4qL6/BpS2ZKZsxQArCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFbmgeuYph6Av22g8w72T/lz1vY4qsilP68Jww48hPk=;
 b=hc73V6q+qUJ6Lz71VQ0z7Uujz4lq2CfEHbidNYBDd99uR3FMs+sj6wOHNIWCh+KSmzLEDEIpYCkHDBrR3SIUw1GmR2eXvjmJlFeeRYFm79oeOEGQPn3+fxzztamMDkbwTaLkzYXWsO4sIjII6Tnr1odX9qKilZTkPRAfdxqq23I=
Received: from BN7PR06CA0055.namprd06.prod.outlook.com (2603:10b6:408:34::32)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Mon, 29 Nov
 2021 15:01:36 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::cf) by BN7PR06CA0055.outlook.office365.com
 (2603:10b6:408:34::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Mon, 29 Nov 2021 15:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 15:01:34 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 09:01:32 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] drm/amdkfd: remove hardcoded device_info structs
Date: Mon, 29 Nov 2021 09:59:42 -0500
Message-ID: <20211129145942.3542707-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129145942.3542707-1-Graham.Sider@amd.com>
References: <20211129145942.3542707-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2dad13e-5747-4ec0-4649-08d9b34922d4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4247:
X-Microsoft-Antispam-PRVS: <CH2PR12MB42473476AB87503D91749B598A669@CH2PR12MB4247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FWqUtiCdgo1Kx8v5k9mThP+nhh8AaH9aRdE03Hq4pSthgn87zoU7LrS6/r7p4dqkLMyabpR0jeL2yYvj5iTS4Xptppg079w5nXbUz7EGSQjsqDT+2qXqYmRW1mUhr4YuAWqbw28I4am5Z2nQTywkVQ23lJdrGWJm7SHPSQdA9k86D8+yo7hwRelQK2FDjHZk0y2AdV9PEBdiGPDXtLQGay0nrg6sgT7nXrwrg4ZtlBo4lI0N3+ZX/OyOsSBgwLo/xfXzvi0vHPzUUxSDeOR5WfKBWXbiRyBBsbgMXBTK/57xbessULExdUKIiESfXhZY9kM9bJhe6zCoFVVDKjcvbobW7/VfuRBTQCC0Co3aL77h3uQRaZkJ9g/7PB9fC7NcVtC9a6eEXJ6uncNZHI/iffDCBicrh6j5Dt5PYFEDlxMAVDd3XT8ZKi/5YbXymm6nSutE8y+hphNmmFBmrjgHL57IRj/bb8GdcDt7Q0MjEQgN+oUEwuRPbZActjoyk0bt09wd+S/ZYXtrji0NIQJCBSHXcVj/dYotjTRe1M02OCj64YTPcEzrmcAHwe4G2DcOOYKdCUk2KEwMvbEUvxPtDxR92jFdP8Vn74RYH3DxBowszxZDGzGIPdEzddgEC/Z5oWlRxtxgdfmDfLqITEd49kVs7nR91pm+7ndUk+YlyFbawTW1vgKZxbvdnaOPGqzBsV8hzlyaiNMXO4SwHFytKOWYzfIPJwaQXiFVJc1xG4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(30864003)(2906002)(16526019)(316002)(1076003)(63370400001)(36756003)(36860700001)(5660300002)(8676002)(7696005)(82310400004)(8936002)(47076005)(83380400001)(2616005)(336012)(186003)(6916009)(70586007)(426003)(63350400001)(70206006)(356005)(54906003)(81166007)(4326008)(26005)(6666004)(508600001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 15:01:34.7527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dad13e-5747-4ec0-4649-08d9b34922d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 469 +-----------------------
 1 file changed, 17 insertions(+), 452 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 5e50667cb665..eb6851be1224 100644
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
@@ -633,11 +181,13 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 		break;
 	default:
 		switch (adev->ip_versions[GC_HWIP][0]) {
+		/* Vega 10 */
 		case IP_VERSION(9, 0, 1):
 			gfx_target_version = 90000;
 			f2g = &gfx_v9_kfd2kgd;
 			break;
 #ifdef KFD_SUPPORT_IOMMU_V2
+		/* Raven */
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
 			gfx_target_version = 90002;
@@ -645,69 +195,84 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
 #endif
+		/* Vega12 */
 		case IP_VERSION(9, 2, 1):
 			gfx_target_version = 90004;
 			if (!vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
+		/* Renoir */
 		case IP_VERSION(9, 3, 0):
 			gfx_target_version = 90012;
 			if (!vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
+		/* Vega20 */
 		case IP_VERSION(9, 4, 0):
 			gfx_target_version = 90006;
 			if (!vf)
 				f2g = &gfx_v9_kfd2kgd;
 			break;
+		/* Arcturus */
 		case IP_VERSION(9, 4, 1):
 			gfx_target_version = 90008;
 			f2g = &arcturus_kfd2kgd;
 			break;
+		/* Aldebaran */
 		case IP_VERSION(9, 4, 2):
 			gfx_target_version = 90010;
 			f2g = &aldebaran_kfd2kgd;
 			break;
+		/* Navi10 */
 		case IP_VERSION(10, 1, 10):
 			gfx_target_version = 100100;
 			if (!vf)
 				f2g = &gfx_v10_kfd2kgd;
 			break;
+		/* Navi12 */
 		case IP_VERSION(10, 1, 2):
 			gfx_target_version = 100101;
 			f2g = &gfx_v10_kfd2kgd;
 			break;
+		/* Navi14 */
 		case IP_VERSION(10, 1, 1):
 			gfx_target_version = 100102;
 			if (!vf)
 				f2g = &gfx_v10_kfd2kgd;
 			break;
+		/* Cyan Skillfish */
 		case IP_VERSION(10, 1, 3):
 			gfx_target_version = 100103;
 			if (!vf)
 				f2g = &gfx_v10_kfd2kgd;
 			break;
+		/* Sienna Cichlid */
 		case IP_VERSION(10, 3, 0):
 			gfx_target_version = 100300;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		/* Navy Flounder */
 		case IP_VERSION(10, 3, 2):
 			gfx_target_version = 100301;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		/* Van Gogh */
 		case IP_VERSION(10, 3, 1):
 			gfx_target_version = 100303;
 			if (!vf)
 				f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		/* Dimgrey Cavefish */
 		case IP_VERSION(10, 3, 4):
 			gfx_target_version = 100302;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		/* Beige Goby */
 		case IP_VERSION(10, 3, 5):
 			gfx_target_version = 100304;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		/* Yellow Carp */
 		case IP_VERSION(10, 3, 3):
 			gfx_target_version = 100305;
 			if (!vf)
-- 
2.25.1

