Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6816FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3232561401
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3232561401
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11ED6E03B;
	Fri, 19 Nov 2021 16:28:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 074116E03B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 16:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPKU9HDr2pxS3Ze5a5BCXoe8rDTueWjiwOECoKLDot4GbbkGs4Gep6VvcuMfVex4iTUt0A8xRYX5O0Bj8+n5YHGC7U9N0IQiUMMZXGgELUzgQjSHXpVAK8rMlHWJYubsZKITlPjT/4J0oySXSNTMpxTr9KnI7zJEabM6yFF1dMCw3pz7Ae2M+ZM7CfAcs8N/l1qjRNPS1mi5IymTAmzOQbKhYCOTvQZXwLPPTx5PhDHNLJCDqu01813LlsswPMvCBRwCznwo8Gl7faEZ0ZepZHlgZf8F1pSrBvPapJ4Yjbp9eJ5x1hK2x23oBcfYdmI+gFMPURX4JooraYbhizGD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keUCP6ULqypsFtxVBTq3WPQ1eRERiI4k3rUSNS07lSo=;
 b=WbfdCBefB5kbxoDA3+xYuI7sP7zoQ8eJBi5RUeofcBiJ+xo3nRSkCFCdk1UWYsREQ91CvSHOvSMopLUL54DGudPP7RxVuQNdmIOUZGXx3lirZjYFDLubD5iy3hh80ybDM91j2CJx959evZbo5wEZ4OXuoCMX3RVdfYIvOqmblD4tQAwNgo59tq0VJ3k5deCEUsihzdGxiohkkIuXvkOwTTSmx5/Dm7Mz9MA/IMZusf3Y7RQv0QzHBPSkw72jTQRHFOkS/DH/TtBqw6XdLigf07GecynZatcvjaTQc0OXqDDaf//yLG9Rh767WINoWaZAp5J9J77I6U8whKgeqLOskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keUCP6ULqypsFtxVBTq3WPQ1eRERiI4k3rUSNS07lSo=;
 b=TwQrVZ2gIAwrwfT0s0qO6XrRPOep2+x0guMTz/8iu0/aTIO/TuMfw18cQnMSl+rLeZn25KC9EjJvZIWisg2ZC3+/fPHQxfRMzit9Lqsg2xQMqpxKcJM7szVRSO2x2NZRkxFmAzvlf1nQpITeb4EIKLLwP3v08+nm/x/OqKpBuZA=
Received: from DM6PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:100::37)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 16:28:36 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::fe) by DM6PR03CA0060.outlook.office365.com
 (2603:10b6:5:100::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend
 Transport; Fri, 19 Nov 2021 16:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 16:28:35 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 10:28:31 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: add kfd_device_info_init function
Date: Fri, 19 Nov 2021 11:27:58 -0500
Message-ID: <20211119162800.2111819-2-Graham.Sider@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4512832c-8dbc-40e9-148f-08d9ab79a2a4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4111:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4111CFD8F72CA2352242173F8A9C9@MN2PR12MB4111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIF2hv/qhp38TgrL3xrZl2MEpzZIy/pmb+iWLDwL5aRg6zOWKYOjql06p4YiGP7ABWiK6ZCo83smwxjubZGiuW/JwGDqGHOlAnAkmgNZWA7RbuP5g3Bh81+aq55JmNFxJaTGrTno2OtZtJNwQ+yEyGz9P8LrZ/C7KttzWruv7OpIkT/ILgzRqykglWBJFspytBRDBROqq9PmAncNBRPuwnHXjhh8fezuVYhqZ63OTe69uS5Rj8/PC0OTvRnn1kQ/vE/hAChudJIxeoLDxHx7de0ml7AvnXf940d6FTNr8usS1t0MvdJPUTxXdC+ELYzuusdfv0dN4LRxwXMEH0wFMNcnrWNRHtq4n8yYnqJeSIOyogu/RRN1oT8VRz0AhoZPOQjBoA216NPHVg1DaGXu2BUEtQeAxvafdf3IMRwxuMIBC0zFRrTEgSCv88zWzwyxpjBCuLRZlvNPj3V1F4rb3PVpSihvSU4A0CHBs7sFmnv3PdDnAqi+UHD6+IRYHyLuIKytcZ4/c6Npo1ZptD9rh5/9oTklu7bIZhvmAIG9wZgYbAr7AaORpbKiYy+1uXrScS/IhTpSTDTFTNMA5/+nftYJZ1D2Fk5q1QNaSVg96quk+tJ0zGXX5FXAEvhV50632+CHIum7v3TYfeGTqEoqA0BPtXq1hcizqpyGni9pwjEQM3lMGFdNbrbZ/1Rpg55xM+tl/g5baAA0r6Ww5qCs7qVV617V8vNy6pBrVGNfbFY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(6916009)(6666004)(70206006)(4326008)(82310400003)(26005)(8676002)(36860700001)(2616005)(16526019)(70586007)(186003)(7696005)(336012)(5660300002)(426003)(1076003)(316002)(8936002)(54906003)(356005)(47076005)(36756003)(2906002)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 16:28:35.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4512832c-8dbc-40e9-148f-08d9ab79a2a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

Initializes device_info structs given either asic_type (enum) if GFX
version is less than GFX9, or GC IP version if greater. Also takes in vf
and the target compiler gfx version.

Inclusion/exclusion to certain conditions for certain GC IP versions may
be necessary on npi bringup on a case-by-case basis, but for the most
part should be minimal (e.g. adding one || asic_version == IP_VERSION(X ,X, X) case).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 58 +++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e11fc4e20c32..23e35a466cf0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -511,6 +511,64 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
 static int kfd_resume(struct kfd_dev *kfd);
 
+static void kfd_device_info_init(struct kfd_device_info *device_info,
+				 uint32_t asic_version, bool is_soc15, bool vf,
+				 uint32_t gfx_target_version)
+{
+	device_info->max_pasid_bits = 16;
+	device_info->max_no_of_hqd = 24;
+	device_info->num_of_watch_points = 4;
+	device_info->mqd_size_aligned = MQD_SIZE_ALIGNED;
+	device_info->gfx_target_version = gfx_target_version;
+
+	if (is_soc15) {
+		device_info->doorbell_size = 8;
+		device_info->ih_ring_entry_size = 8 * sizeof(uint32_t);
+		device_info->event_interrupt_class = &event_interrupt_class_v9;
+		device_info->supports_cwsr = true;
+
+		if ((asic_version >= IP_VERSION(9, 0, 1)  &&
+		     asic_version <= IP_VERSION(9, 3, 0)) ||
+		     asic_version == IP_VERSION(10, 3, 1) ||
+		     asic_version == IP_VERSION(10, 3, 3))
+			device_info->num_sdma_queues_per_engine = 2;
+		else
+			device_info->num_sdma_queues_per_engine = 8;
+
+		// Navi2x+, Navi1x+
+		if (asic_version >= IP_VERSION(10, 3, 0))
+			device_info->no_atomic_fw_version = 145;
+		else if (asic_version >= IP_VERSION(10, 1, 1))
+			device_info->no_atomic_fw_version = 92;
+
+		// Raven
+		if (asic_version == IP_VERSION(9, 1, 0) ||
+		    asic_version == IP_VERSION(9, 2, 2))
+			device_info->needs_iommu_device = true;
+
+		// Navi1x+
+		if (asic_version >= IP_VERSION(10, 1, 1))
+			device_info->needs_pci_atomics = true;
+	} else {
+		device_info->doorbell_size = 4;
+		device_info->ih_ring_entry_size = 4 * sizeof(uint32_t);
+		device_info->event_interrupt_class = &event_interrupt_class_cik;
+		device_info->num_sdma_queues_per_engine = 2;
+
+		if (asic_version != CHIP_KAVERI &&
+		    asic_version != CHIP_HAWAII &&
+		    asic_version != CHIP_TONGA)
+			device_info->supports_cwsr = true;
+
+		if (asic_version == CHIP_KAVERI ||
+		    asic_version == CHIP_CARRIZO)
+			device_info->needs_iommu_device = true;
+
+		if (asic_version != CHIP_HAWAII && !vf)
+			device_info->needs_pci_atomics = true;
+	}
+}
+
 struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 {
 	struct kfd_dev *kfd;
-- 
2.25.1

