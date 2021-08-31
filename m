Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F93DC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 21:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3F260F46
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 21:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC3F260F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58E346E0E4;
	Tue, 31 Aug 2021 21:57:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037D56E0E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 21:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1hp4jqgR8rNuT4yhGqyMMKhJ6w6VnxVFT05gNnG6dphq/evJyYOVbH8CXVxgv0HUMiD9ZugAXuM0EE7I1FP9rBatmFHEssDG/YkFgoj/CIswNkjCoasosMylDB9sMkq/yVSvx5+DHpTAhSK9L71e7Vt74G4BW9lATVrpHgcbcGe6xNtT8nZ0ilZ+/hS4uwd6aacVC5ozQVHzAlwcXDcw0nCnGPx7EYW2dQv+hZv3pYJN7Nlfaa6JcQE8ng4/1KgPKbym/d5uLT3/qGWf9Hb+4TzT/cMbP1W/2ndTntwJ/PAXCO6iCxPfAubNZAAfL+SB3x5C/hOtcQ97+axUzojUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPEJYi6/IZQeUXmBXzxpz097/4cWKcmPGA5LGHOa/PA=;
 b=fqcX6yOSiOuHG73voGNMLwfIg8fLfiMj7JS/gzN0gHFfkp1siX2bgbvPKfX652GKDgXevS0I4zNYQusGXjZMpFEQeGg0iHmdfQ0UiXqJe9IJNTodFpDKofFTtMWgRfVa75L9PYmzAPc97+cGDx0sHEHm1hgtfoCccjenPHJbigGhpyQgeRiJbBn1rTqU5iPGN32Zccg6PmcYOzJPDT5d+sO4HW9P2fEwGWwAtQY1De4mHSFnt0KBffXRpEuOu5iAy8ctsBFJOaokwLzAvggJEm0l3ThryRqwLsIKsg7tAY2tj0B21iaecA2ZS5VbZ9VAnaOiqjmJaX6pSzdG2EKpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPEJYi6/IZQeUXmBXzxpz097/4cWKcmPGA5LGHOa/PA=;
 b=ifAOlbIEEqTOPQvin4VqWrmBBR+HvTyZyJZ5xOz/new3JbwXrm1hXrpLllIIKABw+oIQ5QT3cUXwSCyxyrKRp0qc2QU5htF8AzQ6bGTzpKXS444uewwgUZDVOpAvwZANGSbdG57qxsdK+NDCaxV6gLfcErymWofacFzOojfWroM=
Received: from DM3PR12CA0073.namprd12.prod.outlook.com (2603:10b6:0:57::17) by
 SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Tue, 31 Aug 2021 21:57:02 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::68) by DM3PR12CA0073.outlook.office365.com
 (2603:10b6:0:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Tue, 31 Aug 2021 21:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Tue, 31 Aug 2021 21:57:02 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 31 Aug
 2021 16:56:59 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version dependent
Date: Tue, 31 Aug 2021 17:56:32 -0400
Message-ID: <20210831215632.195506-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc7a6f9-682a-433b-5608-08d96cca4383
X-MS-TrafficTypeDiagnostic: SA0PR12MB4542:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4542AC1375CDEB62E427E68592CC9@SA0PR12MB4542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUYpGhffq5kubwIVdaRTvQOOfCNQSh8fVeieUh41stHOrP6JA2Xyps9s9pldqhvE7t1x/PkPrhkdXGBJeOOJFIg5X2DWSkHyXUqU/YDSyVry4OYkmbPd0FHtaEZAcxg+mvaxltS0gRKMiefH/ABhq1/9NRWUG33Q1/fN6Nb4GIZYc4Dh91UuTDg1YhqOXDyAyM1YRdF5c4vOFurJnmXnzgGA3Wj36KmHs0XAGQ4oHNB2ZqcJ4YVU2JuwLA+gdG5hlmAka3JVmwRaNeGfEhoD6D4GxxuKHJDd296BTb/BtExwqUsFFRnzkoxFlnHJfxF/ehBr0CP8D9f/RduVkfV6LAgcot8HWnY7XbcHO1B5k28LBrhsSCmSILSKwLbUA8aBjfLbcR3Gs08gvt6j28zgXu4b9k9MF5AGmDtHY57qCA/B7PPvfW3txhUrBqy9bswEcGkdWwxeJjTn7UdhXc2t9D6EyLI1BLZKyxJNnQNLJs0uGhiQCgbmiYsnYSSw7XWVTsTmCCcp6Q7KYGZ1FWSVffKGvZsUikrUXdfJrXaZCeLg8r1AYsuQ824W9ybvGQJ5Iub9h7p25XrdRnc0ZS6CqoC0LMG+TA7Z3PJx8ot6IpVCK5ffokvVmc7dQIi35K39boM0T8r2u6g4yjilC62Rtpkk6g4uvQzxShJmLuWQwKrcDpPkjPn6/jC4A5liCAry+5OFoTI8SYk++tSVP5JmlvQGX0QfDceGRwNBT2MaxBs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39850400004)(36840700001)(46966006)(47076005)(1076003)(2906002)(356005)(70586007)(26005)(8936002)(6666004)(70206006)(336012)(5660300002)(426003)(478600001)(186003)(16526019)(82310400003)(7696005)(86362001)(2616005)(6916009)(36860700001)(82740400003)(8676002)(83380400001)(81166007)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 21:57:02.0570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc7a6f9-682a-433b-5608-08d96cca4383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 16a57b70cc1a..655ee5733229 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -688,6 +688,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 	struct kfd_dev *kfd;
 	const struct kfd_device_info *device_info;
 	const struct kfd2kgd_calls *f2g;
+	uint32_t fw_version;
 
 	if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void *) * 2)
 		|| asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
@@ -713,8 +714,12 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
 	 * supported.
 	 */
 	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kgd);
-	if (device_info->needs_pci_atomics &&
-	    !kfd->pci_atomic_requested) {
+	fw_version = amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1);
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

