Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A044C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265FA610A5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 265FA610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40FD6E87B;
	Fri, 19 Nov 2021 19:54:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E95D6E83D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCX0RKwE+8qRkZjPbNMMRHlIeNImTQJlBo55KoFAQWM1mE0bKO7/BLrQ1Q5DqQiCLCQ4yNiBy5FS7zN0FegX5JaoubJzVbvunhf3UolfqIbTckr7ipZCdRLt8MLGNSig2uDLv648OM5/Be7bklGMYxoeKgwaXBqWmAbmrQuJ+4KWbodFK1Mg06nXzNcN4qA6042tcmEwuv2BzJ9NWP8l/3vqahpOjxiw3TGNTuhKJnjxe2N0FIJnR70pxRDZVD0DuXULAJyp+WkI3nxzvqR1+lk4rvdFTmi1AHhl3vcz9+lh1Lhmk+bvpDnOmA1T/YU4IxsB3swM+YcwT9vix1mR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFrKuPoDzmm1/aPLsK0ifAIXuzyJNuHTgASgWlG1Spk=;
 b=CGJfFf2laytZPqfVdAmMBGgI00BKKTV/n1Lv/FbR7pUdesYoiSDgxr3aC3HdW+DEpezWHcSbZr+um4ZftdHjyY3160bTy/haXQCyJDneN9eugZ+D40o2wh6m+1A6vffmbdrUXKyINmJ2oobP5sEuWwTliTCLIQTtklNgM1ioxGqQ1aMKzFc/2a1phiK9KIETxXx8JzchjICzJgw702ec8QpOD/HM6qbSJ68LGhTquvSW6Yp78hySbChpKByNWLm1gt+DkFUcffr9KCWGUpQ/Jq5krhBlUZ732aC9R76ewla4dNNa5nQQo/A1t74+Wu7fkOa+erHF2hcnZY0+M4Pp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFrKuPoDzmm1/aPLsK0ifAIXuzyJNuHTgASgWlG1Spk=;
 b=MuLgGDvvNwPyXvMFCqybQG1/RVoFVyGrZT1Gd5iO4s6pGgLHeOJFAurd7OpML9KPLISUOvdyWGiIa/y4EmkcU9CeHOTFRrxD4c49doB+mTpFcnEeYPJo1h1NOBsSpsOMBZPDH9CP8Wz7GskLwquWQKIgHUhAU6MD1bc0sbRTsXk=
Received: from MW4PR04CA0369.namprd04.prod.outlook.com (2603:10b6:303:81::14)
 by DM6PR12MB3289.namprd12.prod.outlook.com (2603:10b6:5:15d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:53:57 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::ea) by MW4PR04CA0369.outlook.office365.com
 (2603:10b6:303:81::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 19:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:53:56 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:53:54 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/4] drm/amdkfd: remove hardcoded device_info structs
Date: Fri, 19 Nov 2021 14:52:58 -0500
Message-ID: <20211119195258.2173551-4-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119195258.2173551-1-Graham.Sider@amd.com>
References: <20211119195258.2173551-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec3fbade-4652-4318-2e2a-08d9ab9652a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3289:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3289A193FD2F01600B36082A8A9C9@DM6PR12MB3289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kaKKFbtPPfU5FxfbZpByUnWwKA9DXvgooRaoa0IOZP5Eizv6Sw08Rk2FBNZ3QQ0HK6PT9qeKlr3bSI5Q0Mvm/SCYy5T+kGLta+TExVJz95AjminnZONBG7aODidQZZEQAYKOrYraypk8bJ244nJ53Chx86o0K9i9FC38HCWNCz8iLk2T7Qep/FEaAXAmuMb06HrcOCJg7frG/Ppf+oH1wKDRk8v4sMvzRtBNXtTsxrttbfIW61MtKk3pK3VojbKSgO7l5wa4/6W+/JAbM1880YaRdFJceCG1OnoZm5CA180FGkIXaYKMWvIXN+oy46Ve5crmMk0cwuf/SqYljK3a1h3kf7fGGgHZq7RtFNVOT3VwzFHGs758grkgJzNOIgZtxmg8OjFlsJI7tCgRvDMkNqnIWeiJ5f21vTlUdik0YOjBT2gE7/oYYBzCUq3hSzqa3yoq8qMk9FKOWsgG7gtTV8hy4aqd2UfXuemxVY9aMzp1trDUtdJCKCNez8ahvatZSAZt1rwsQ4G1cePrhTxPii6XxcyW8xsLbnhM69uVSkfyu1+c7ce4IlEAy8y/jJKkOOu653qf7iEYAGLYnxJ8wU7onyA082mlqB0p6vo/U7mtFwzWoFzk5dI6Hcrppg1bQYT1s8WyZ3vOSD/n0qAR1was8EeKWMUxJlDKz5UUXhbYM/hSrAk38t4ZdMP4iItaOvmUnBMPIjUgsK27ZIjg+/HfIMqrQaZWG6DwnxsVfxE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(8936002)(36860700001)(83380400001)(54906003)(47076005)(16526019)(508600001)(186003)(30864003)(82310400003)(8676002)(70586007)(356005)(81166007)(1076003)(2616005)(2906002)(6916009)(86362001)(336012)(7696005)(36756003)(426003)(26005)(70206006)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:53:56.7926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3fbade-4652-4318-2e2a-08d9ab9652a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3289
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>
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
index 7ddea653b3d9..e36487a85c93 100644
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
@@ -644,69 +194,84 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
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

