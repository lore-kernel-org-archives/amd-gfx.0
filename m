Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8776C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 15:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F9426EB1E;
	Mon, 29 Nov 2021 15:01:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DDE6EB1E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 15:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUEyBwSzYZSmAUwEb9Lq2F4q2w/fxuDZsyQ939I5O388JPG5fI9HHgt+jYt6utTi7W4z4BYz7as5NGwvGfYhpcqJJSctjFenEzReTE6qdMfP5eTls8Ya84TSY9ElLtFJWPtsECPhXMVBbVwaYExphnVTvLJNuOLirfzz5kIuG5JP8Ddg8qJCYqsrUX9EoUp5b4+UteUruaVdw9NTM4pYUA7thRx3k3LO+BUxP7AbUYEwI58nURYfW4eVBJ9T9N6GntVkYqJtL/+ikgg89xTofL40BuGaeoNvie+ZerUES+HucQ5dmUNtnWrEtmkr4iaLUkGU4LlA6M0nKIpZsvgUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEhpOVgJGTKjxMTaKUO/DV4pF+vp/XmKU9kHXIbJtzY=;
 b=OYyRqbkZhhGmzR/FOiEoIKUpWaLIBCsfQzpkGU0c1JFbBYVZmdo3Wx6Ek1rIuv/dQfWjsAfbzIyMzgPYfP3cI4bnrXzwOt9gPb2vrXSCyyRiLUv/GoJkX4Hq6IXeqvBq8kYR7klAA7RF2DBEGFne2hWL8l3CLPg6MX/9dRH3363GKkW+jjjhD3AM5KPEbW5CMZs7LLdGLY0mQUn/ZkFP7p2r4GB2vD31H19r2ukvTDm2ZfMdbgJsPyuRXsosJ+09cIDUozTHPluI7RMXlFntpJiuUxXbl5tCYl2wF6i2aNCJ4ptlJtY01Ii5XqyT8zE4joKAHJzryt7b8wbnpOuTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEhpOVgJGTKjxMTaKUO/DV4pF+vp/XmKU9kHXIbJtzY=;
 b=GzJNWjSdNqpCZDKg2ydXhRObGIgKBs3zg1V/YoSrXkBZX0gtA2y4ZJuvv1r0AJQo75ECwGSysMWQEiCBQouGEikhtZ//scpiGzW6cvzAsPujgnel2csiB2cNMokkCjStp5KpJtECT1RFpptF/4wrK3axAOhwUOw79N3IywxoO9k=
Received: from BN9PR03CA0264.namprd03.prod.outlook.com (2603:10b6:408:ff::29)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 15:01:34 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::c0) by BN9PR03CA0264.outlook.office365.com
 (2603:10b6:408:ff::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Mon, 29 Nov 2021 15:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 15:01:33 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 09:01:32 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/3] drm/amdkfd: add kfd_device_info_init function
Date: Mon, 29 Nov 2021 09:59:41 -0500
Message-ID: <20211129145942.3542707-2-Graham.Sider@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 879c1a51-9968-4dde-0a86-08d9b3492253
X-MS-TrafficTypeDiagnostic: BL1PR12MB5319:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5319E42C9ED8C464DCF20D968A669@BL1PR12MB5319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBtiWt9JcA5BHN6fucmvvuhc/LdFwU5c9D4uW6aVqQR1ty9rFn494pvrPFkgkWbHGwYhSYSMgsqI30CGtQWqkWFUrkOiTVAFAAmHnsp8eiC9t9elat4DW6vo5aDarA3oHqVa1zih0sG5KYvDYnG1O42VsEKaBXUKA4SMaw1UscCIWUJzrc1paLy7IPnQoDQpvN2PrS4+JPCqQP6G5l3gkGpq50CTtDI7qtI7n0PZIS12W8sX1Ju/sYL5epQfDYzyaeZ4V4AKo+ALQTv60x4ERuHNqiqA6VB2v+4gx45XUOm7awU6mhYbqpSeqFANi8xa89J8J978gx3lGem+zKMQ1QZyKCorhpo8emacMnVc7paYbZopdNYqud9uaGSNo6OAMu3g7MGFSil1iAamUQP5sgrmeAOzLNFXlqB7s9oYn0a2sk6LyyPJ2Fk6HA7qGp341kUPSLOBgucHDUItaYkLQboaQFYxHc9eh4b/ANErm23RDGcPHmfnOS+nkykdCKRC6RNmj9PBadWT66bWhr61q9MTPidFIf4S77xyyuRs041Fm6NEE7i2zHbPCUUo+fnT8X//FJ93Fze/jAjqi0Y5HGZqZldpZmL2ShZJ95hk5kB8/IWs8brHFzropqRQMKkBlHNoOU3pntYBlQi5QUuosFj2ORzO3uVA6qbty3ZZQfBN7HQoZXCqdsQReogZqCs4dGzxFEiAyt6Jxgvve1p0J4GyKuC6WVbuWV9yPo5G/E0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(81166007)(356005)(5660300002)(6666004)(4326008)(336012)(86362001)(316002)(508600001)(8936002)(36756003)(186003)(1076003)(2616005)(7696005)(2906002)(54906003)(426003)(16526019)(47076005)(70206006)(83380400001)(30864003)(26005)(70586007)(36860700001)(6916009)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 15:01:33.9058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 879c1a51-9968-4dde-0a86-08d9b3492253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
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

Initializes kfd->device_info given either asic_type (enum) if GFX
version is less than GFX9, or GC IP version if greater. Also takes in vf
and the target compiler gfx version. Uses SDMA version to determine
num_sdma_queues_per_engine.

Convert device_info to a non-pointer member of kfd, change references
accordingly.

Change unsupported asic condition to only probe f2g, move device_info
initialization post-switch.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 247 ++++++++++--------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     |   8 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c    |  18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   8 +-
 11 files changed, 164 insertions(+), 141 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e11fc4e20c32..5e50667cb665 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -511,193 +511,215 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
 static int kfd_resume(struct kfd_dev *kfd);
 
+static void kfd_device_info_init(struct kfd_dev *kfd,
+				 bool vf, uint32_t gfx_target_version)
+{
+	uint32_t gc_version = KFD_GC_VERSION(kfd);
+	uint32_t sdma_version = kfd->adev->ip_versions[SDMA0_HWIP][0];
+	uint32_t asic_type = kfd->adev->asic_type;
+
+	kfd->device_info.max_pasid_bits = 16;
+	kfd->device_info.max_no_of_hqd = 24;
+	kfd->device_info.num_of_watch_points = 4;
+	kfd->device_info.mqd_size_aligned = MQD_SIZE_ALIGNED;
+	kfd->device_info.gfx_target_version = gfx_target_version;
+
+	if (KFD_IS_SOC15(kfd)) {
+		kfd->device_info.doorbell_size = 8;
+		kfd->device_info.ih_ring_entry_size = 8 * sizeof(uint32_t);
+		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
+		kfd->device_info.supports_cwsr = true;
+
+		if ((sdma_version >= IP_VERSION(4, 0, 0)  &&
+		     sdma_version <= IP_VERSION(4, 2, 0)) ||
+		     sdma_version == IP_VERSION(5, 2, 1)  ||
+		     sdma_version == IP_VERSION(5, 2, 3))
+			kfd->device_info.num_sdma_queues_per_engine = 2;
+		else
+			kfd->device_info.num_sdma_queues_per_engine = 8;
+
+		/* Raven */
+		if (gc_version == IP_VERSION(9, 1, 0) ||
+		    gc_version == IP_VERSION(9, 2, 2))
+			kfd->device_info.needs_iommu_device = true;
+
+		if (gc_version < IP_VERSION(11, 0, 0)) {
+			/* Navi2x+, Navi1x+ */
+			if (gc_version >= IP_VERSION(10, 3, 0))
+				kfd->device_info.no_atomic_fw_version = 145;
+			else if (gc_version >= IP_VERSION(10, 1, 1))
+				kfd->device_info.no_atomic_fw_version = 92;
+
+			/* Navi1x+ */
+			if (gc_version >= IP_VERSION(10, 1, 1))
+				kfd->device_info.needs_pci_atomics = true;
+		}
+	} else {
+		kfd->device_info.doorbell_size = 4;
+		kfd->device_info.ih_ring_entry_size = 4 * sizeof(uint32_t);
+		kfd->device_info.event_interrupt_class = &event_interrupt_class_cik;
+		kfd->device_info.num_sdma_queues_per_engine = 2;
+
+		if (asic_type != CHIP_KAVERI &&
+		    asic_type != CHIP_HAWAII &&
+		    asic_type != CHIP_TONGA)
+			kfd->device_info.supports_cwsr = true;
+
+		if (asic_type == CHIP_KAVERI ||
+		    asic_type == CHIP_CARRIZO)
+			kfd->device_info.needs_iommu_device = true;
+
+		if (asic_type != CHIP_HAWAII && !vf)
+			kfd->device_info.needs_pci_atomics = true;
+	}
+}
+
 struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 {
-	struct kfd_dev *kfd;
-	const struct kfd_device_info *device_info;
-	const struct kfd2kgd_calls *f2g;
+	struct kfd_dev *kfd = NULL;
+	const struct kfd2kgd_calls *f2g = NULL;
 	struct pci_dev *pdev = adev->pdev;
+	uint32_t gfx_target_version = 0;
 
 	switch (adev->asic_type) {
 #ifdef KFD_SUPPORT_IOMMU_V2
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_KAVERI:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &kaveri_device_info;
-		f2g = &gfx_v7_kfd2kgd;
+		gfx_target_version = 70000;
+		if (!vf)
+			f2g = &gfx_v7_kfd2kgd;
 		break;
 #endif
 	case CHIP_CARRIZO:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &carrizo_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80001;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 #endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_HAWAII:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &hawaii_device_info;
-		f2g = &gfx_v7_kfd2kgd;
+		gfx_target_version = 70001;
+		if (!vf)
+			f2g = &gfx_v7_kfd2kgd;
 		break;
 #endif
 	case CHIP_TONGA:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &tonga_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80002;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_FIJI:
-		if (vf)
-			device_info = &fiji_vf_device_info;
-		else
-			device_info = &fiji_device_info;
+		gfx_target_version = 80003;
 		f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_POLARIS10:
-		if (vf)
-			device_info = &polaris10_vf_device_info;
-		else
-			device_info = &polaris10_device_info;
+		gfx_target_version = 80003;
 		f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_POLARIS11:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &polaris11_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80003;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_POLARIS12:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &polaris12_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80003;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_VEGAM:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &vegam_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80003;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 	default:
 		switch (adev->ip_versions[GC_HWIP][0]) {
 		case IP_VERSION(9, 0, 1):
-			if (vf)
-				device_info = &vega10_vf_device_info;
-			else
-				device_info = &vega10_device_info;
+			gfx_target_version = 90000;
 			f2g = &gfx_v9_kfd2kgd;
 			break;
 #ifdef KFD_SUPPORT_IOMMU_V2
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &raven_device_info;
-			f2g = &gfx_v9_kfd2kgd;
+			gfx_target_version = 90002;
+			if (!vf)
+				f2g = &gfx_v9_kfd2kgd;
 			break;
 #endif
 		case IP_VERSION(9, 2, 1):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &vega12_device_info;
-			f2g = &gfx_v9_kfd2kgd;
+			gfx_target_version = 90004;
+			if (!vf)
+				f2g = &gfx_v9_kfd2kgd;
 			break;
 		case IP_VERSION(9, 3, 0):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &renoir_device_info;
-			f2g = &gfx_v9_kfd2kgd;
+			gfx_target_version = 90012;
+			if (!vf)
+				f2g = &gfx_v9_kfd2kgd;
 			break;
 		case IP_VERSION(9, 4, 0):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &vega20_device_info;
-			f2g = &gfx_v9_kfd2kgd;
+			gfx_target_version = 90006;
+			if (!vf)
+				f2g = &gfx_v9_kfd2kgd;
 			break;
 		case IP_VERSION(9, 4, 1):
-			device_info = &arcturus_device_info;
+			gfx_target_version = 90008;
 			f2g = &arcturus_kfd2kgd;
 			break;
 		case IP_VERSION(9, 4, 2):
-			device_info = &aldebaran_device_info;
+			gfx_target_version = 90010;
 			f2g = &aldebaran_kfd2kgd;
 			break;
 		case IP_VERSION(10, 1, 10):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &navi10_device_info;
-			f2g = &gfx_v10_kfd2kgd;
+			gfx_target_version = 100100;
+			if (!vf)
+				f2g = &gfx_v10_kfd2kgd;
 			break;
 		case IP_VERSION(10, 1, 2):
-			device_info = &navi12_device_info;
+			gfx_target_version = 100101;
 			f2g = &gfx_v10_kfd2kgd;
 			break;
 		case IP_VERSION(10, 1, 1):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &navi14_device_info;
-			f2g = &gfx_v10_kfd2kgd;
+			gfx_target_version = 100102;
+			if (!vf)
+				f2g = &gfx_v10_kfd2kgd;
 			break;
 		case IP_VERSION(10, 1, 3):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &cyan_skillfish_device_info;
-			f2g = &gfx_v10_kfd2kgd;
+			gfx_target_version = 100103;
+			if (!vf)
+				f2g = &gfx_v10_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 0):
-			device_info = &sienna_cichlid_device_info;
+			gfx_target_version = 100300;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 2):
-			device_info = &navy_flounder_device_info;
+			gfx_target_version = 100301;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 1):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &vangogh_device_info;
-			f2g = &gfx_v10_3_kfd2kgd;
+			gfx_target_version = 100303;
+			if (!vf)
+				f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 4):
-			device_info = &dimgrey_cavefish_device_info;
+			gfx_target_version = 100302;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 5):
-			device_info = &beige_goby_device_info;
+			gfx_target_version = 100304;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 3):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &yellow_carp_device_info;
-			f2g = &gfx_v10_3_kfd2kgd;
+			gfx_target_version = 100305;
+			if (!vf)
+				f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		default:
-			return NULL;
+			break;
 		}
 		break;
 	}
 
-	if (!device_info || !f2g) {
+	if (!f2g) {
 		if (adev->ip_versions[GC_HWIP][0])
 			dev_err(kfd_device, "GC IP %06x %s not supported in kfd\n",
 				adev->ip_versions[GC_HWIP][0], vf ? "VF" : "");
@@ -712,7 +734,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 		return NULL;
 
 	kfd->adev = adev;
-	kfd->device_info = device_info;
+	kfd_device_info_init(kfd, vf, gfx_target_version);
 	kfd->pdev = pdev;
 	kfd->init_complete = false;
 	kfd->kfd2kgd = f2g;
@@ -731,7 +753,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 
 static void kfd_cwsr_init(struct kfd_dev *kfd)
 {
-	if (cwsr_enable && kfd->device_info->supports_cwsr) {
+	if (cwsr_enable && kfd->device_info.supports_cwsr) {
 		if (KFD_GC_VERSION(kfd) < IP_VERSION(9, 0, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
@@ -815,14 +837,14 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 */
 	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kfd->adev);
 	if (!kfd->pci_atomic_requested &&
-	    kfd->device_info->needs_pci_atomics &&
-	    (!kfd->device_info->no_atomic_fw_version ||
-	     kfd->mec_fw_version < kfd->device_info->no_atomic_fw_version)) {
+	    kfd->device_info.needs_pci_atomics &&
+	    (!kfd->device_info.no_atomic_fw_version ||
+	     kfd->mec_fw_version < kfd->device_info.no_atomic_fw_version)) {
 		dev_info(kfd_device,
 			 "skipped device %x:%x, PCI rejects atomics %d<%d\n",
 			 kfd->pdev->vendor, kfd->pdev->device,
 			 kfd->mec_fw_version,
-			 kfd->device_info->no_atomic_fw_version);
+			 kfd->device_info.no_atomic_fw_version);
 		return false;
 	}
 
@@ -839,7 +861,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	/* calculate max size of mqds needed for queues */
 	size = max_num_of_queues_per_device *
-			kfd->device_info->mqd_size_aligned;
+			kfd->device_info.mqd_size_aligned;
 
 	/*
 	 * calculate max size of runlist packet.
@@ -979,6 +1001,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 	}
 
 	kfree(kfd);
+	kfd = NULL;
 }
 
 int kgd2kfd_pre_reset(struct kfd_dev *kfd)
@@ -1114,7 +1137,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 	if (!kfd->init_complete)
 		return;
 
-	if (kfd->device_info->ih_ring_entry_size > sizeof(patched_ihre)) {
+	if (kfd->device_info.ih_ring_entry_size > sizeof(patched_ihre)) {
 		dev_err_once(kfd_device, "Ring entry too small\n");
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2af2b3268171..dd0b952f0173 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -108,13 +108,13 @@ static unsigned int get_num_all_sdma_engines(struct device_queue_manager *dqm)
 unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
 {
 	return kfd_get_num_sdma_engines(dqm->dev) *
-		dqm->dev->device_info->num_sdma_queues_per_engine;
+		dqm->dev->device_info.num_sdma_queues_per_engine;
 }
 
 unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
 {
 	return kfd_get_num_xgmi_sdma_engines(dqm->dev) *
-		dqm->dev->device_info->num_sdma_queues_per_engine;
+		dqm->dev->device_info.num_sdma_queues_per_engine;
 }
 
 void program_sh_mem_settings(struct device_queue_manager *dqm,
@@ -1838,7 +1838,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	struct kfd_mem_obj *mem_obj = &dqm->hiq_sdma_mqd;
 	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
 		get_num_all_sdma_engines(dqm) *
-		dev->device_info->num_sdma_queues_per_engine +
+		dev->device_info.num_sdma_queues_per_engine +
 		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
 
 	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
@@ -2082,7 +2082,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 
 	for (pipe = 0; pipe < get_num_all_sdma_engines(dqm); pipe++) {
 		for (queue = 0;
-		     queue < dqm->dev->device_info->num_sdma_queues_per_engine;
+		     queue < dqm->dev->device_info.num_sdma_queues_per_engine;
 		     queue++) {
 			r = dqm->dev->kfd2kgd->hqd_sdma_dump(
 				dqm->dev->adev, pipe, queue, &dump, &n_regs);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 768d153acff4..0dbcf54657ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -48,7 +48,7 @@
 /* # of doorbell bytes allocated for each process. */
 size_t kfd_doorbell_process_slice(struct kfd_dev *kfd)
 {
-	return roundup(kfd->device_info->doorbell_size *
+	return roundup(kfd->device_info.doorbell_size *
 			KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
 			PAGE_SIZE);
 }
@@ -180,7 +180,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
 		return NULL;
 
-	inx *= kfd->device_info->doorbell_size / sizeof(u32);
+	inx *= kfd->device_info.doorbell_size / sizeof(u32);
 
 	/*
 	 * Calculating the kernel doorbell offset using the first
@@ -201,7 +201,7 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
 	unsigned int inx;
 
 	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
-		* sizeof(u32) / kfd->device_info->doorbell_size;
+		* sizeof(u32) / kfd->device_info.doorbell_size;
 
 	mutex_lock(&kfd->doorbell_mutex);
 	__clear_bit(inx, kfd->doorbell_available_index);
@@ -239,7 +239,7 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
 	return kfd->doorbell_base_dw_offset +
 		pdd->doorbell_index
 		* kfd_doorbell_process_slice(kfd) / sizeof(u32) +
-		doorbell_id * kfd->device_info->doorbell_size / sizeof(u32);
+		doorbell_id * kfd->device_info.doorbell_size / sizeof(u32);
 }
 
 uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 20512a4e9a91..deb64168c9e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -135,7 +135,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 
 		*patched_flag = true;
 		memcpy(patched_ihre, ih_ring_entry,
-				dev->device_info->ih_ring_entry_size);
+				dev->device_info.ih_ring_entry_size);
 
 		pasid = dev->dqm->vmid_pasid[vmid];
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index bc47f6a44456..81887c2013c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -54,7 +54,7 @@ int kfd_interrupt_init(struct kfd_dev *kfd)
 	int r;
 
 	r = kfifo_alloc(&kfd->ih_fifo,
-		KFD_IH_NUM_ENTRIES * kfd->device_info->ih_ring_entry_size,
+		KFD_IH_NUM_ENTRIES * kfd->device_info.ih_ring_entry_size,
 		GFP_KERNEL);
 	if (r) {
 		dev_err(kfd_chardev(), "Failed to allocate IH fifo\n");
@@ -114,8 +114,8 @@ bool enqueue_ih_ring_entry(struct kfd_dev *kfd,	const void *ih_ring_entry)
 	int count;
 
 	count = kfifo_in(&kfd->ih_fifo, ih_ring_entry,
-				kfd->device_info->ih_ring_entry_size);
-	if (count != kfd->device_info->ih_ring_entry_size) {
+				kfd->device_info.ih_ring_entry_size);
+	if (count != kfd->device_info.ih_ring_entry_size) {
 		dev_err_ratelimited(kfd_chardev(),
 			"Interrupt ring overflow, dropping interrupt %d\n",
 			count);
@@ -133,11 +133,11 @@ static bool dequeue_ih_ring_entry(struct kfd_dev *kfd, void *ih_ring_entry)
 	int count;
 
 	count = kfifo_out(&kfd->ih_fifo, ih_ring_entry,
-				kfd->device_info->ih_ring_entry_size);
+				kfd->device_info.ih_ring_entry_size);
 
-	WARN_ON(count && count != kfd->device_info->ih_ring_entry_size);
+	WARN_ON(count && count != kfd->device_info.ih_ring_entry_size);
 
-	return count == kfd->device_info->ih_ring_entry_size;
+	return count == kfd->device_info.ih_ring_entry_size;
 }
 
 static void interrupt_wq(struct work_struct *work)
@@ -146,13 +146,13 @@ static void interrupt_wq(struct work_struct *work)
 						interrupt_work);
 	uint32_t ih_ring_entry[KFD_MAX_RING_ENTRY_SIZE];
 
-	if (dev->device_info->ih_ring_entry_size > sizeof(ih_ring_entry)) {
+	if (dev->device_info.ih_ring_entry_size > sizeof(ih_ring_entry)) {
 		dev_err_once(kfd_chardev(), "Ring entry too small\n");
 		return;
 	}
 
 	while (dequeue_ih_ring_entry(dev, ih_ring_entry))
-		dev->device_info->event_interrupt_class->interrupt_wq(dev,
+		dev->device_info.event_interrupt_class->interrupt_wq(dev,
 								ih_ring_entry);
 }
 
@@ -163,7 +163,7 @@ bool interrupt_is_wanted(struct kfd_dev *dev,
 	/* integer and bitwise OR so there is no boolean short-circuiting */
 	unsigned int wanted = 0;
 
-	wanted |= dev->device_info->event_interrupt_class->interrupt_isr(dev,
+	wanted |= dev->device_info.event_interrupt_class->interrupt_isr(dev,
 					 ih_ring_entry, patched_ihre, flag);
 
 	return wanted != 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index 73f2257acc23..66ad8d0b8f7f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -89,7 +89,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
 	}
 
 	pasid_limit = min_t(unsigned int,
-			(unsigned int)(1 << kfd->device_info->max_pasid_bits),
+			(unsigned int)(1 << kfd->device_info.max_pasid_bits),
 			iommu_info.max_pasids);
 
 	if (!kfd_set_pasid_limit(pasid_limit)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 406479a369a9..16f8bc4ca7f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -111,7 +111,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,
 	kq->rptr_kernel = kq->rptr_mem->cpu_ptr;
 	kq->rptr_gpu_addr = kq->rptr_mem->gpu_addr;
 
-	retval = kfd_gtt_sa_allocate(dev, dev->device_info->doorbell_size,
+	retval = kfd_gtt_sa_allocate(dev, dev->device_info.doorbell_size,
 					&kq->wptr_mem);
 
 	if (retval != 0)
@@ -297,7 +297,7 @@ void kq_submit_packet(struct kernel_queue *kq)
 	}
 	pr_debug("\n");
 #endif
-	if (kq->dev->device_info->doorbell_size == 8) {
+	if (kq->dev->device_info.doorbell_size == 8) {
 		*kq->wptr64_kernel = kq->pending_wptr64;
 		write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
 					kq->pending_wptr64);
@@ -310,7 +310,7 @@ void kq_submit_packet(struct kernel_queue *kq)
 
 void kq_rollback_packet(struct kernel_queue *kq)
 {
-	if (kq->dev->device_info->doorbell_size == 8) {
+	if (kq->dev->device_info.doorbell_size == 8) {
 		kq->pending_wptr64 = *kq->wptr64_kernel;
 		kq->pending_wptr = *kq->wptr_kernel %
 			(kq->queue->properties.queue_size / 4);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 7b4118915bf6..e2825ad4d699 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -71,7 +71,7 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_dev *dev,
 		return NULL;
 
 	offset = (q->sdma_engine_id *
-		dev->device_info->num_sdma_queues_per_engine +
+		dev->device_info.num_sdma_queues_per_engine +
 		q->sdma_queue_id) *
 		dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0d6d1fe1481b..0c3f911e3bf4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -230,7 +230,7 @@ struct kfd_vmid_info {
 struct kfd_dev {
 	struct amdgpu_device *adev;
 
-	const struct kfd_device_info *device_info;
+	struct kfd_device_info device_info;
 	struct pci_dev *pdev;
 	struct drm_device *ddev;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c5f5a25c6dcc..5e5c84a8e1ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -219,7 +219,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	 * Hence we also check the type as well
 	 */
 	if ((pdd->qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
-		max_queues = dev->device_info->max_no_of_hqd/2;
+		max_queues = dev->device_info.max_no_of_hqd/2;
 
 	if (pdd->qpd.queue_count >= max_queues)
 		return -ENOSPC;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index d6aa27b1ae33..948fbb39336e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -503,7 +503,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 
 	if (dev->gpu) {
 		log_max_watch_addr =
-			__ilog2_u32(dev->gpu->device_info->num_of_watch_points);
+			__ilog2_u32(dev->gpu->device_info.num_of_watch_points);
 
 		if (log_max_watch_addr) {
 			dev->node_props.capability |=
@@ -1382,7 +1382,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.simd_arrays_per_engine =
 		cu_info.num_shader_arrays_per_engine;
 
-	dev->node_props.gfx_target_version = gpu->device_info->gfx_target_version;
+	dev->node_props.gfx_target_version = gpu->device_info.gfx_target_version;
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
 	dev->node_props.capability |=
@@ -1402,7 +1402,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.num_sdma_xgmi_engines =
 					kfd_get_num_xgmi_sdma_engines(gpu);
 	dev->node_props.num_sdma_queues_per_engine =
-				gpu->device_info->num_sdma_queues_per_engine;
+				gpu->device_info.num_sdma_queues_per_engine;
 	dev->node_props.num_gws = (dev->gpu->gws &&
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		dev->gpu->adev->gds.gws_size : 0;
@@ -1578,7 +1578,7 @@ void kfd_double_confirm_iommu_support(struct kfd_dev *gpu)
 
 	gpu->use_iommu_v2 = false;
 
-	if (!gpu->device_info->needs_iommu_device)
+	if (!gpu->device_info.needs_iommu_device)
 		return;
 
 	down_read(&topology_lock);
-- 
2.25.1

