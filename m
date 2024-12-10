Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B3AE77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C68810EA07;
	Tue, 10 Dec 2024 22:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IybufI/8";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5B310EA07
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyEJzTOz4VwcQJJz3UBhLTXi4nzjI4yYvYQLqXpCRPWTdoZ3onn7EstSVj782k37qi5GBa3mT5FB3sHIltRTpE2w8G19EBAYfqMLySpQczYk2ojujwxFqTIgk8Ruqrtx41PL+PQtznPRdrUhCQzqYmi2Eobx8RpxEKJKL0PTJxfY/ng686JSvN0q5IxGvD7+mVH2EE0Ht2b2Ab+bX4ZLDHJ2H2oPFJLuFVMIaJGYGqJzP935fNWfuT5ivcafK/rVRvJKGi2/7EogPBrtEnkZ6Zs389V1aXqabxw0Gm0PSZN3uoU3CPvYyvSx0Iyd5fGsxl/mhg0d/iwzQ75zZ6r7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PQ58ouKkIGxVkWxVN61GvuBrrGjhCq1RkdPuWE4ZOo=;
 b=nS1dHsvo9aRDr1iaGA6ixgDx0eu9L1nt2O4vKEY1l0pSWCQJqEdmvSIc+KvXn36b2hWfkJOBAvh6tdUI0IdJeIfJ6z3+Qvakj+lnpycf0KKMSJSucLHEq/bbFTbgAd5JZY/oP4mtXcLKcsGozSo+Ri2pzn315N21WDCX/vxu590cb0fcCq/tPv5VwkM5L4rUbWsbUJuOYOp9O+grL0YF9e+T2bmF4Z2zjWcoVK+0tN/ipOfjHaeSGkfiwhdHzXl9F/bgUoB/muvPwRB0HFN+B2Vb8lRCCXzdyuhtDPtQgzVmhHss8bKKTQIE+3imZlrfCQmx6c2Sh1DAs3P+8XdOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PQ58ouKkIGxVkWxVN61GvuBrrGjhCq1RkdPuWE4ZOo=;
 b=IybufI/8GH5V2Q13A5k7hGY3KHY92wXmjNnRG1ID+Uy6fITR/K0ksSeHC1waB6N79eQhFiZlgINpTSqs6cqQ4BPCkmkfnUAmusWkMpAhBhVpamMHQ9FAiG0fYwkmgu4X2Cx7msgaMEx8T4ahGuHJFkEvdYrcs1hQq2AiVncgxaE=
Received: from MN2PR05CA0030.namprd05.prod.outlook.com (2603:10b6:208:c0::43)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:54:20 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:c0:cafe::3a) by MN2PR05CA0030.outlook.office365.com
 (2603:10b6:208:c0::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Tue,
 10 Dec 2024 22:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 48/48] drm/amdgpu: use new helper to get num instances for SDMA
Date: Tue, 10 Dec 2024 17:53:37 -0500
Message-ID: <20241210225337.75394-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f3e84f-6bf3-4241-f10a-08dd196d954d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BmdIC6q+zJt/r0JD4QD2Er9cdlDLDpNDFMxI4HhWY89YScFE8w8fkFBRoyZi?=
 =?us-ascii?Q?xX3cFL/AZ+ulIbW6Lz/OadZuQk1PS6MhQkdOPmwkCVP7H39Ld75nRDsvxFl1?=
 =?us-ascii?Q?NAkq8nP1JEbAjX8ipGkyfmuPww58AWZXycUGF+aBwPz5eA0gpccVo9N8B7k8?=
 =?us-ascii?Q?+Y8gSwaiXn2ZZF9yEOBYX0eYe2vDZIiUJg2e15HFyPfpfJRgfoB3+wd4zMEv?=
 =?us-ascii?Q?GRSMGpkKOUAAlGwG0yke7lFlTiKuTs3sEBtZ9i4zoG6HEkEmsuMG/74DqOX+?=
 =?us-ascii?Q?O8VmFlyph+xFDRii6rLtIlHE3UtupEJsG4HeQ73CWws3uqyHDv0x5L/+kRU1?=
 =?us-ascii?Q?Yrm9TLZNVAdhhmwB/UOiizS1iT9M/PQ/NX9LzygpScUCXi5ms8vxvK80ppkc?=
 =?us-ascii?Q?KunmHdgT0Oq2jBH1Wvypk+z+ZotLJyQjE++vYywU1GlixB+DiRnsy7AmU9vu?=
 =?us-ascii?Q?M/Cz7o8R5WCCicjPp0zHGFio9AxMaLvfbF9B97KbMzLsN+C+6V2TlMN+CpK3?=
 =?us-ascii?Q?N3OTvH4MRXdwDDUuQjsb3h3EoM2TcwPnA3ykd5flEzm8cvQS4+Y1WBzNknMw?=
 =?us-ascii?Q?WzNiFgnk4EEChKUjlXV0EwswXaWTbtvGzqb3tCsND55Oep2Ko3PE3A+s3qAQ?=
 =?us-ascii?Q?fIWIlgHhVpDu1rMaIVRM189RubLUBhOFq3gsjdGh49Gc6QiqJZDkM1pu2NdD?=
 =?us-ascii?Q?/lAV1fDRGPukqVyzZMZ8IGckEJlvzBBS39pyg7jNa03MFHxOB7PH1MAoDhM1?=
 =?us-ascii?Q?zjEtxROeeclsiujieuQmme4MDUZ+XvHJR57z8NpjWYbWZSWqGT8VSwt3XfY3?=
 =?us-ascii?Q?HiTZARHVN6b2PnWf4GDrhpnSmZMb8Vq/coXb1go6vvXW7RF3MlTT04Z0mEE4?=
 =?us-ascii?Q?gYwP3uys6gETlDOhR2QGGge2aS6uROo5LyKaKc1uEssKx2GJNYsBYWPi2/Lw?=
 =?us-ascii?Q?9/BeH/Ejdsb6jEPVxxOCa9D6uYuec21JTsl6Sl73S9hbOmQVtohT3anzGTiS?=
 =?us-ascii?Q?knxLTD9tYF94PVJiDEin7VYR/3D1eWpyfsV0HIdYkwDNsojLY7WPbMgeZ54j?=
 =?us-ascii?Q?079nrKoHjNEc9WUY/llA1D4m577A7WpjxQc1zCyYC0YHkWONtZHNmOr+VYm6?=
 =?us-ascii?Q?b4u+tzVEzKK6AlhBp+eNejk0+kTb82/CXaURAwG0n9cR8Dd++XY4qzAnVPL0?=
 =?us-ascii?Q?zA82gDgpSkSVs3N/mOJGhRaae2CZVn5brQ2pKd7sK52ivXhJUdgevSl/IC1x?=
 =?us-ascii?Q?wpsQwW776Cp0Fd0JUNIGqh2LeFd7dEZRWcv4C2EsJLZNGi8CACnrOPwdT/pu?=
 =?us-ascii?Q?nh0skV5o9OCr/6gIGX6wkhMPrqLDrP+2IiheAikZPyrq/YExBMKAmKi1aukQ?=
 =?us-ascii?Q?4DGMs3HVUdANzm5iz1SWOyr3L3pdyDshn64RVYxn5Moo1DdbVg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:20.2896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f3e84f-6bf3-4241-f10a-08dd196d954d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

Use the helper for all non-SDMA code which queries the number
of SDMA instances.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c          | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c       |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c           |  5 +++--
 drivers/gpu/drm/amd/amdgpu/soc15.c               |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 12 +++++++-----
 10 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 946c48829f197..79d5a9e1e195b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -73,10 +73,12 @@ const char *hw_ip_names[MAX_HWIP] = {
 static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
 				       struct drm_printer *p)
 {
+	int num_sdma_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	uint32_t version;
 	uint32_t feature;
 	uint8_t smu_program, smu_major, smu_minor, smu_debug;
 	struct atom_context *ctx = adev->mode_info.atom_context;
+	int i;
 
 	drm_printf(p, "VCE feature version: %u, fw version: 0x%08x\n",
 		   adev->vce.fb_version, adev->vce.fw_version);
@@ -156,7 +158,7 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
 		   0, smu_program, version, smu_major, smu_minor, smu_debug);
 
 	/* SDMA firmware */
-	for (int i = 0; i < adev->sdma.num_instances; i++) {
+	for (i = 0; i < num_sdma_inst; i++) {
 		drm_printf(p,
 			   "SDMA%d feature version: %u, firmware version: 0x%08x\n",
 			   i, adev->sdma.instance[i].feature_version,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 330f5cfb79218..4fee9ea68eefb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -213,6 +213,8 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 				struct drm_amdgpu_query_fw *query_fw,
 				struct amdgpu_device *adev)
 {
+	int num_sdma_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
+
 	switch (query_fw->fw_type) {
 	case AMDGPU_INFO_FW_VCE:
 		fw_info->ver = adev->vce.fw_version;
@@ -318,7 +320,7 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		}
 		break;
 	case AMDGPU_INFO_FW_SDMA:
-		if (query_fw->index >= adev->sdma.num_instances)
+		if (query_fw->index >= num_sdma_inst)
 			return -EINVAL;
 		fw_info->ver = adev->sdma.instance[query_fw->index].fw_version;
 		fw_info->feature = adev->sdma.instance[query_fw->index].feature_version;
@@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_HW_IP_DMA:
 		type = AMD_IP_BLOCK_TYPE_SDMA;
-		for (i = 0; i < adev->sdma.num_instances; i++)
+		num_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
+		for (i = 0; i < num_inst; i++)
 			if (adev->sdma.instance[i].ring.sched.ready)
 				++num_rings;
 		ib_start_alignment = 256;
@@ -686,7 +689,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			count = 1;
 			break;
 		case AMD_IP_BLOCK_TYPE_SDMA:
-			count = adev->sdma.num_instances;
+			count = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 			break;
 		case AMD_IP_BLOCK_TYPE_JPEG:
 			count = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_JPEG) *
@@ -1649,6 +1652,7 @@ void amdgpu_disable_vblank_kms(struct drm_crtc *crtc)
 static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = m->private;
+	int num_sdma_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	struct drm_amdgpu_info_firmware fw_info;
 	struct drm_amdgpu_query_fw query_fw;
 	struct atom_context *ctx = adev->mode_info.atom_context;
@@ -1832,7 +1836,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 
 	/* SDMA */
 	query_fw.fw_type = AMDGPU_INFO_FW_SDMA;
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for (i = 0; i < num_sdma_inst; i++) {
 		query_fw.index = i;
 		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index bb946fa1e912e..462c6b27c8eba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -126,6 +126,7 @@ static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
 
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
+	int num_sdma_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	int i, r;
 
 	adev->mes.adev = adev;
@@ -156,7 +157,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		    IP_VERSION(6, 0, 0))
 			adev->mes.sdma_hqd_mask[i] = i ? 0 : 0x3fc;
 		/* zero sdma_hqd_mask for non-existent engine */
-		else if (adev->sdma.num_instances == 1)
+		else if (num_sdma_inst == 1)
 			adev->mes.sdma_hqd_mask[i] = i ? 0 : 0xfc;
 		else
 			adev->mes.sdma_hqd_mask[i] = 0xfc;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 571f1c783bc66..1849f6a22e5f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -375,7 +375,8 @@ static void amdgpu_ras_instance_mask_check(struct amdgpu_device *adev,
 		mask = GENMASK(num_xcc - 1, 0);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
-		mask = GENMASK(adev->sdma.num_instances - 1, 0);
+		inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
+		mask = GENMASK(inst - 1, 0);
 		break;
 	case AMDGPU_RAS_BLOCK__VCN:
 		inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 6d020e81ff945..c3183674ab552 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -37,6 +37,7 @@
 
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 {
+	int num_sdma_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	int i;
 
 	adev->doorbell_index.kiq = AMDGPU_DOORBELL_LAYOUT1_KIQ_START;
@@ -48,7 +49,7 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 	adev->doorbell_index.xcc_doorbell_range = AMDGPU_DOORBELL_LAYOUT1_XCC_RANGE;
 
 	adev->doorbell_index.sdma_doorbell_range = 20;
-	for (i = 0; i < adev->sdma.num_instances; i++)
+	for (i = 0; i < num_sdma_inst; i++)
 		adev->doorbell_index.sdma_engine[i] =
 			AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START +
 			i * (adev->doorbell_index.sdma_doorbell_range >> 1);
@@ -399,7 +400,7 @@ static int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int x
 	int num_sdma, num_vcn, num_shared_vcn, num_xcp;
 	int num_xcc_xcp, num_sdma_xcp, num_vcn_xcp;
 
-	num_sdma = adev->sdma.num_instances;
+	num_sdma = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	num_vcn = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 	num_shared_vcn = 1;
 
@@ -463,7 +464,7 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 		return -EINVAL;
 
 	max_res[AMDGPU_XCP_RES_XCC] = NUM_XCC(adev->gfx.xcc_mask);
-	max_res[AMDGPU_XCP_RES_DMA] = adev->sdma.num_instances;
+	max_res[AMDGPU_XCP_RES_DMA] = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	max_res[AMDGPU_XCP_RES_DEC] = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 	max_res[AMDGPU_XCP_RES_JPEG] = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_JPEG);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c4e15418e187e..7ba758500c7b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5687,12 +5687,13 @@ static void gfx_v10_0_rlc_backdoor_autoload_copy_gfx_ucode(struct amdgpu_device
 /* Temporarily put sdma part here */
 static void gfx_v10_0_rlc_backdoor_autoload_copy_sdma_ucode(struct amdgpu_device *adev)
 {
+	int num_sdma_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	const __le32 *fw_data;
 	uint32_t fw_size;
 	const struct sdma_firmware_header_v1_0 *sdma_hdr;
 	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for (i = 0; i < num_sdma_inst; i++) {
 		sdma_hdr = (const struct sdma_firmware_header_v1_0 *)
 			adev->sdma.instance[i].fw->data;
 		fw_data = (const __le32 *) (adev->sdma.instance[i].fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 67cd420315719..fd24d7037a5a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5255,6 +5255,7 @@ static void gfx_v11_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
 						       bool enable)
 {
+	int num_sdma_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	uint32_t def, data;
 
 	if (!(adev->cg_flags &
@@ -5338,7 +5339,7 @@ static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 		WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);
 
 		/* Some ASICs only have one SDMA instance, not need to configure SDMA1 */
-		if (adev->sdma.num_instances > 1) {
+		if (num_sdma_inst > 1) {
 			data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
 			data = REG_SET_FIELD(data, SDMA1_RLC_CGCG_CTRL, CGCG_INT_ENABLE, 1);
 			WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
@@ -5372,7 +5373,7 @@ static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 		WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);
 
 		/* Some ASICs only have one SDMA instance, not need to configure SDMA1 */
-		if (adev->sdma.num_instances > 1) {
+		if (num_sdma_inst > 1) {
 			data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
 			data &= ~SDMA1_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;
 			WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d0697b0869e3d..add31ae766d60 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3934,6 +3934,7 @@ static int gfx_v12_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 static void gfx_v12_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
 						       bool enable)
 {
+	int num_sdma_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	uint32_t def, data;
 
 	if (!(adev->cg_flags &
@@ -4017,7 +4018,7 @@ static void gfx_v12_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 		WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);
 
 		/* Some ASICs only have one SDMA instance, not need to configure SDMA1 */
-		if (adev->sdma.num_instances > 1) {
+		if (num_sdma_inst > 1) {
 			data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
 			data = REG_SET_FIELD(data, SDMA1_RLC_CGCG_CTRL, CGCG_INT_ENABLE, 1);
 			WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
@@ -4051,7 +4052,7 @@ static void gfx_v12_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 		WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);
 
 		/* Some ASICs only have one SDMA instance, not need to configure SDMA1 */
-		if (adev->sdma.num_instances > 1) {
+		if (num_sdma_inst > 1) {
 			data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
 			data &= ~SDMA1_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;
 			WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a59b4c36cad73..3b9f069801de2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1272,11 +1272,12 @@ static int soc15_common_sw_fini(struct amdgpu_ip_block *ip_block)
 
 static void soc15_sdma_doorbell_range_init(struct amdgpu_device *adev)
 {
+	int num_sdma_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_SDMA);
 	int i;
 
 	/* sdma doorbell range is programed by hypervisor */
 	if (!amdgpu_sriov_vf(adev)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
+		for (i = 0; i < num_sdma_inst; i++) {
 			adev->nbio.funcs->sdma_doorbell_range(adev, i,
 				true, adev->doorbell_index.sdma_engine[i] << 1,
 				adev->doorbell_index.sdma_doorbell_range);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index ac0fdaa1ea23e..8e8af330db720 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -128,7 +128,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
 		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
 		bitmap_set(kfd->device_info.reserved_sdma_queues_bitmap, 0,
-			   kfd->adev->sdma.num_instances *
+			   amdgpu_device_ip_get_num_inst(kfd->adev, AMD_IP_BLOCK_TYPE_SDMA) *
 			   kfd->device_info.num_reserved_sdma_queues_per_engine);
 		break;
 	default:
@@ -1431,16 +1431,18 @@ unsigned int kfd_get_num_sdma_engines(struct kfd_node *node)
 {
 	/* If XGMI is not supported, all SDMA engines are PCIe */
 	if (!node->adev->gmc.xgmi.supported)
-		return node->adev->sdma.num_instances/(int)node->kfd->num_nodes;
+		return amdgpu_device_ip_get_num_inst(node->adev, AMD_IP_BLOCK_TYPE_SDMA) /
+			(int)node->kfd->num_nodes;
 
-	return min(node->adev->sdma.num_instances/(int)node->kfd->num_nodes, 2);
+	return min(amdgpu_device_ip_get_num_inst(node->adev, AMD_IP_BLOCK_TYPE_SDMA) /
+		   (int)node->kfd->num_nodes, 2);
 }
 
 unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_node *node)
 {
 	/* After reserved for PCIe, the rest of engines are XGMI */
-	return node->adev->sdma.num_instances/(int)node->kfd->num_nodes -
-		kfd_get_num_sdma_engines(node);
+	return amdgpu_device_ip_get_num_inst(node->adev, AMD_IP_BLOCK_TYPE_SDMA) /
+		(int)node->kfd->num_nodes - kfd_get_num_sdma_engines(node);
 }
 
 int kgd2kfd_check_and_lock_kfd(void)
-- 
2.47.1

