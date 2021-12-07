Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27308C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 15:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5C1EBCCA;
	Tue,  7 Dec 2021 15:32:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D02DEBCCB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 15:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBNrZrdK22I6Hle55ArxnzdjmgRYtxirNPXtTRiKipKZysHNLH6UoHhCg0neJHoTsAk1hS4BbGFJ+cQfhQ7GCi+P3LuK1vikUOKj8ux8B7c3TMVBpgXXYqvkkaY8I/nwHnhgUAVVOkYC31rfPcTOm4Cr6gl/QmIrkQq+Za041qRjy/gXawPhAnvCPRho/P6GITHtzIumOEEF9SnBRyxiH0PGhTfjS0z2VzQ1CxQrjLV5U0UARTxMLRP4UgD13KtQ4qrogtd+5CpoqH4I1Tpu1Yv6Nws0aB/kNeZM2vLDBCpfQFkkSCwwbDXwDL4zqLdetC1yFxrC6iG1yZ6yi/bgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfRZ0W+0b/w+YxccLDUq74kL5924ybH4xY8vxmsrGpQ=;
 b=ecditfwVsip8cQUHG7vPSFsktk75YIpMQ4i8OElBKl2gktSy2EfHHY3HM8NzjvFrDXsHDgVm3idnGX5Y4dVT/ipiHf/I4wXyQFKoKm7VMOF++AByOL1oiMcbtBuZxxefzktN7gaQCea5B7NmDB1vWLoX88mWsryRaGrW6BCdkbPoUeAfA9PoPitoUN803XJM+5y+2Zg2+XrVNXebfqI2k6UM7K7K39vsSXgjijjH/YPDymGmFT9/q+AHY5+Uhj4Sg9HxMDYm4uswbbWQHQ4X0bWqjgQA6ZuDrbIkjOGvPMQjzy3DJJbu0TH3LWlcoNn87Alh5Axh9ijpJaL6RMDsuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfRZ0W+0b/w+YxccLDUq74kL5924ybH4xY8vxmsrGpQ=;
 b=EdnhKGS2cjS0YOmWqabqJ4IoiHzf6EauRTdVNe54lBuWqi5zkICw12PwdWZefc95E5L3WGt+2PLCr1MNPdx00WkPUFJYQMSb+2H6jIpdsw9AQUCvuGh/jbkUWt3eONB2biGNmL60qaPvLpOwMlYJyBLW3l0hzGnxmxiJHE8lr4A=
Received: from BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::30)
 by DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 14:59:44 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::bc) by BN9P221CA0008.outlook.office365.com
 (2603:10b6:408:10a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Tue, 7 Dec 2021 14:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 14:59:44 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 08:59:23 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Detect if amdgpu in IOMMU isolation mode
Date: Tue, 7 Dec 2021 09:59:10 -0500
Message-ID: <20211207145911.2690-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05bc083f-6b10-42d9-a75f-08d9b9923446
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0123251FB511343F6EE43143E66E9@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsh+ThtGXnkunTTtwDb1MA4BbES6/xhv+3N5L5VFyyaz9UM6qjYOjoNxukS8e4ZMb1zec5xK5YiPIPe+KUU+goV8oCgoRakaK9L5rx72WWHz2C2r5gikzyW2tHkGwAd9+blxoszz8HNjSVxQFjDMmXw3s4HB8wiSxeAdkZHIfZEyE90sls7pSfNqMqlMCpvzD1f2k3E2AxMYVbe5Jy24yUXZo9nHamDz9oUZq2keS7yUD0dUH+W79ythkRk1K1ZqrYMxmF99AYT/Dy4du35AzvdjOHGgzk44ur5/U+TTjwV2E/w8IdPghb03zk3h0iEuCarVi/Dp7DGeUCIN4eqTeGkP6u2aj6xNtD6JZlLkT3ET26ZChCKhTGJLviqCH1CzmOklhP45btpNDX5o3sE4JhP3FRWzoVEk/23EgGBzwYfK7+1RwqSkcS9+biW8MdeVkHwZt064HO5FH+qnUAHZVa0kD7A2o43CcPGKqwRywu2p+QceM5IBOrhldVzoLte7xUGb5YuSWkJTEvdOEW1wsSwnLrUeU4NwvXXD0k7wBiIrl0ZMDPgTHO1F8v/jT758P4Y/HYspdRq+g4R5/3io1mUt25DBWo2K02jPP8eqk8EETwnktrVoLiYdX70iK5zSp6il1qQSvHbx9ncueo1toIboFx43ybCsTd5ITeEHCsv3GdEYZr4v/sFKV2a/gJRrcgj3c1jCrkvK1J9qTEER+2J0t+N+8wkql/lEOnvyxBbOV9kHnokIkFhyiwkHdZg/fSyJs0xCp8pDa9RgA5u0sqA2+v4p2BXAKLr1zFznFl4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(6666004)(2906002)(54906003)(40460700001)(186003)(86362001)(26005)(70586007)(36756003)(356005)(16526019)(4326008)(2616005)(5660300002)(70206006)(7696005)(1076003)(8676002)(316002)(36860700001)(336012)(8936002)(81166007)(508600001)(82310400004)(6916009)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 14:59:44.2576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bc083f-6b10-42d9-a75f-08d9b9923446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If host and amdgpu IOMMU is not enabled or IOMMU is pass through mode,
dma_map_page return address is equal to page physical address, use this
to set adev->iommu_isolation flag which will be used to optimize memory
usage for multi GPU mappings.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5cfe2926ca1..fbbe8c7b5d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,8 @@ struct amdgpu_device {
 
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
+
+	bool				iommu_isolation;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3c5afa45173c..6d0f3c477670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3364,6 +3364,31 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	return ret;
 }
 
+/**
+ * amdgpu_device_check_iommu_isolation - check if IOMMU isolation is enabled
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * device is in IOMMU isolation mode if dma_map_page return address is not equal
+ * to page physical address.
+ */
+static void amdgpu_device_check_iommu_isolation(struct amdgpu_device *adev)
+{
+	struct page *page;
+	dma_addr_t addr;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return;
+	addr = dma_map_page(adev->dev, page, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(adev->dev, addr))
+		goto out_free_page;
+	adev->iommu_isolation = (addr != page_to_phys(page));
+	dma_unmap_page(adev->dev, addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+out_free_page:
+	__free_page(page);
+}
+
 static const struct attribute *amdgpu_dev_attributes[] = {
 	&dev_attr_product_name.attr,
 	&dev_attr_product_number.attr,
@@ -3767,6 +3792,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
+	amdgpu_device_check_iommu_isolation(adev);
+
 	return 0;
 
 release_ras_con:
-- 
2.17.1

