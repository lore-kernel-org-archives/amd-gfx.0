Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9C5C83030
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 21:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D8F10E4C9;
	Mon, 30 Jun 2025 21:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nJFzcg+H";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62FDE10E4C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 21:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPmp37gng0MDJuul2rvoT8XbG28xQAY7DvZtjQ8FSiSTCZp8OAcPCFV1chlGDNb8glAf8f2+ErH4gHguTnLbGKgFpPJJ7yySxqmPzF9p8eqy7RWgJRWoa7NIr+Exp+P9GAFg3/pvs5tdqGxEx3KWzoyfeiV/9pK+qw9ZasUwYqNht0OmOoRffa7Yuq+Oeyokizt0irvTcDTJwm/WLzQMVO8qJMa+RSc/09Qmw3Nvq2RO9BWJW8KRDKXhvAElw/VgCjtprR0Z7EJRBW+Z8+AzXIlviQ/8HZcaWRsWUAlrsAd0ElN8AhTlE+8ElE6U26UpnK8mEDS/kI5oNfgLteTRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2tkpH3iGhvJaiMTHfsIMV8q/zdtHkUHkmyU1NgA1u4=;
 b=ZewtnVen3qoTrxvST2D2nsdsTWQdEZ0Lgtr+hfTp+H8jDad6aTGau6bHEHfGq4dp0ZeZWy87sx2MXU45Npe9IYCUvjaD4c9borZI69mzT+ijXd8w27ucNW4g1b1F5zq9i7s+RHxgRq/7p8buVrKOjtZ48YvhdjmD2Fql4HOXZG7V8ffuRA+KGTtWXI7y2NREbFaG9NuhcMBDgt7BJPjFNC1UsJyJqDUjpk6Web6H6idltFyYk8UI/XNt+rVloLOl6ucrZoSPTyt8su8FHNVnYt5weO/tRGINCZ+Z8jEg++wNzKkXPz3bBPuV0r8cKFiWLZR9jLag7WIl6eUuBJTaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=bestguesspass action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2tkpH3iGhvJaiMTHfsIMV8q/zdtHkUHkmyU1NgA1u4=;
 b=nJFzcg+HgvVl12qOszAAvyWElLahLbvMuCDDKhMpeT/bKbB9ZhQ9RvUBp6k+rKu5Q97pKWcu6m1mAb+soLtGZC5hVfYDEPn37ad6ERl/8SPWRcKhYVW1cgrM45UttH+dfIrF1unwmVzEV+WFg5lB2FHnQvj+yi0EGMGCih9drUo=
Received: from BN0PR04CA0136.namprd04.prod.outlook.com (2603:10b6:408:ed::21)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 21:27:17 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::4f) by BN0PR04CA0136.outlook.office365.com
 (2603:10b6:408:ed::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 21:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 21:27:16 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Jun 2025 16:27:14 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v3] drm/amd/amdgpu: Add helper functions for isp buffers
Date: Mon, 30 Jun 2025 17:24:25 -0400
Message-ID: <20250630212658.1848515-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fc7d50-6555-4f97-c97c-08ddb81ce34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xCUX9FQhIzhtaM0uQU4B7e/iRgkp54AdkQvgwvyoPQ9OhANSM+gkbB0YeHxV?=
 =?us-ascii?Q?AFBruKVOyCJkwu6YOy6RxbmLww0hTJ6ebgTym61rToQbH8AXXRx97DhX0+H+?=
 =?us-ascii?Q?1ud+zKhUj4CBcmOo+//6oVdlSYO384ElbkfqCA+rseN8nuPiZWzpesSoNFN7?=
 =?us-ascii?Q?83qAAlcDhGQ7K9YxahzXht5d3dWQ8RzYKQl4pYoHCv/KzYFWXMdqoLus5Hu2?=
 =?us-ascii?Q?/httZDm3maMFVr3GAfTEa8OFzu5wsoRXyMfKJm8DruafzZfuC4oSeUaZ1LtN?=
 =?us-ascii?Q?jVMkFTgKndFy93UXSBkd8Vv8AVAdbwU43BvM+l7r4uhjHnVIzIFwW00xB1DR?=
 =?us-ascii?Q?1119baV/uZ+obd+f0kXhSg6FQJgjF3le8hhjq0yQ7Tc9NyMEe2i4uP5WEFa2?=
 =?us-ascii?Q?jeX5aBSK9kSEit4CUcL+LCFqp3W1hqsEIRkp5OkaESKHU8ddIc0CH63PaWBB?=
 =?us-ascii?Q?+Y8ph8vd30aJK9gkJwzXoKfMsbciS/6ajgC7ZkKfWlVbW5c0Q43XZKjBII1n?=
 =?us-ascii?Q?oncvN9v3pr8ymur7pY9T2PGvBmXkxdXS92hMNXFNFaAGJYNv8N2eb96Nk56z?=
 =?us-ascii?Q?IoP/Y5JyLgmqEp4cJxsc8XpEpDnSL1MSSIwegLj+N6JrMBxgEVRoPa1zwMhH?=
 =?us-ascii?Q?79qeh9rQuWc1os2HmqEtiNW8Fvw+BbKVQrLUDuWbqZ6Fb/K/GhB+Y4a/zvhs?=
 =?us-ascii?Q?sDCPVA4ZMhazVWQfZnKHRTylIbrH4udIEV9a+KC0NCTwMRcOTdRUZNEmvO+n?=
 =?us-ascii?Q?WgiNSm29SD3487PvW/11ePzE5+NbsvZXFMbMizs7snZwxIdbblQPODh6diLz?=
 =?us-ascii?Q?BYyYHwIw2+PZTymvsOaG0FmhqC32Dv8ABcTYXAqW7Xc1n+whKQh+Q/s90S4k?=
 =?us-ascii?Q?9YqvNi1R1p1fsUZnuwmGzoJI2E1/UbA6eAyzBQyIuauND2fEaJsoPeTHo3UL?=
 =?us-ascii?Q?a2qh/zm1kzVE1f4hB/+dbOXEe5dyw9CvnVQz/A4+4WPtMigY77B5rBGiiMiE?=
 =?us-ascii?Q?tjkovGRKLmcPz/431LExbMFqbg9J6SzyBDZaRrjSxKEYF0JAzenOhvDtK0dp?=
 =?us-ascii?Q?XgziCm3wvGhkRG9Ttn88IRUon5HrzJaDDiNizC3E0lYepLwKY5Xjxzb8fecm?=
 =?us-ascii?Q?YvP9XvO34fA1RB8ACPueWxEJIKpkK+L+fA96a+lHBzuWgymMS8R9pnSt97zz?=
 =?us-ascii?Q?pdBV8WS5A4lTd9DpxkvrH7T5IH56dwRgVvUOjaUs5Wnw3LxYT3kYtgzRyWB4?=
 =?us-ascii?Q?FoVB1N/fQ9JsGwcLwN0Bflp59umzr89iy8nkblUu1YmP2T6kWiUD5k0829B2?=
 =?us-ascii?Q?IDIUacTh04aJX4BGgK52HjLIZvdj0Ac31n7/t5+hbahyj0o6JRiGkL7jAmi1?=
 =?us-ascii?Q?mFi6ZUhIy1uOOlF1e8kIRwLvOetKCpJjFytKQV+99ykNExxS8qHMQaqDMNAJ?=
 =?us-ascii?Q?LZeLwbqTypyDFMu5dFAbanPyp4swHGNtOiLIsi62P2y3sx7So1kb81zAuZUW?=
 =?us-ascii?Q?it5Z7WA1cU2pPfToxm1mqQmdN1UxGyBtSkHt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 21:27:16.7978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fc7d50-6555-4f97-c97c-08ddb81ce34a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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

Accessing amdgpu internal data structures "struct amdgpu_device"
and "struct amdgpu_bo" in ISP V4L2 driver to alloc/free GART
buffers is not recommended.

Add new amdgpu_isp helper functions thats takes opaque params
from ISP V4L2 driver and calls the amdgpu internal functions
amdgpu_bo_create_isp_user() and amdgpu_bo_create_kernel() to
alloc/free GART buffers.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
Changes v2 -> v3:

* Move isp.h to include/drm/amd/
* Add function headers for exported symbols
* Add checks to validate isp device handle
* Add checks to validate exported symbols args

 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c    | 177 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h    |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 -
 include/drm/amd/isp.h                      |  51 ++++++
 4 files changed, 228 insertions(+), 11 deletions(-)
 create mode 100644 include/drm/amd/isp.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 43fc941dfa57..15868bbb064f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -33,6 +33,8 @@
 #include "isp_v4_1_0.h"
 #include "isp_v4_1_1.h"
 
+#define ISP_MC_ADDR_ALIGN (1024 * 32)
+
 /**
  * isp_hw_init - start and test isp block
  *
@@ -78,7 +80,7 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
 
 	/* read isp fw */
 	r = amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_OPTIONAL,
-				"amdgpu/%s.bin", ucode_prefix);
+				 "amdgpu/%s.bin", ucode_prefix);
 	if (r) {
 		amdgpu_ucode_release(&adev->isp.fw);
 		return r;
@@ -141,6 +143,179 @@ static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int is_valid_isp_device(struct device *isp_parent, struct device *amdgpu_dev)
+{
+	if (isp_parent != amdgpu_dev)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * isp_user_buffer_alloc - create user buffer object (BO) for isp
+ *
+ * @dev: isp device handle
+ * @dma_buf: DMABUF handle for isp buffer allocated in system memory
+ * @buf_obj: GPU buffer object handle to initialize
+ * @buf_addr: GPU addr of the pinned BO to initialize
+ *
+ * Imports isp DMABUF to allocate and pin a user BO for isp internal use. It does
+ * GART alloc to generate GPU addr for BO to make it accessible through the
+ * GART aperture for ISP HW.
+ *
+ * This function is exported to allow the V4L2 isp device external to drm device
+ * to create and access the isp user BO.
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
+			  void **buf_obj, u64 *buf_addr)
+{
+	struct platform_device *ispdev = to_platform_device(dev);
+	const struct isp_platform_data *isp_pdata;
+	struct amdgpu_device *adev;
+	struct mfd_cell *mfd_cell;
+	struct amdgpu_bo *bo;
+	u64 gpu_addr;
+	int ret;
+
+	if (WARN_ON(!ispdev))
+		return -ENODEV;
+
+	if (WARN_ON(!buf_obj))
+		return -EINVAL;
+
+	if (WARN_ON(!buf_addr))
+		return -EINVAL;
+
+	mfd_cell = &ispdev->mfd_cell[0];
+	if (!mfd_cell)
+		return -ENODEV;
+
+	isp_pdata = mfd_cell->platform_data;
+	adev = isp_pdata->adev;
+
+	ret = is_valid_isp_device(ispdev->dev.parent, adev->dev);
+	if (ret)
+		return ret;
+
+	ret = amdgpu_bo_create_isp_user(adev, dmabuf,
+					AMDGPU_GEM_DOMAIN_GTT, &bo, &gpu_addr);
+	if (ret) {
+		drm_err(&adev->ddev, "failed to alloc gart user buffer (%d)", ret);
+		return ret;
+	}
+
+	*buf_obj = (void *)bo;
+	*buf_addr = gpu_addr;
+
+	return 0;
+}
+EXPORT_SYMBOL(isp_user_buffer_alloc);
+
+/**
+ * isp_user_buffer_free - free isp user buffer object (BO)
+ *
+ * @buf_obj: amdgpu isp user BO to free
+ *
+ * unpin and unref BO for isp internal use.
+ *
+ * This function is exported to allow the V4L2 isp device
+ * external to drm device to free the isp user BO.
+ */
+void isp_user_buffer_free(void *buf_obj)
+{
+	amdgpu_bo_free_isp_user(buf_obj);
+}
+EXPORT_SYMBOL(isp_user_buffer_free);
+
+/**
+ * isp_kernel_buffer_alloc - create kernel buffer object (BO) for isp
+ *
+ * @dev: isp device handle
+ * @size: size for the new BO
+ * @buf_obj: GPU BO handle to initialize
+ * @gpu_addr: GPU addr of the pinned BO
+ * @cpu_addr: CPU address mapping of BO
+ *
+ * Allocates and pins a kernel BO for internal isp firmware use.
+ *
+ * This function is exported to allow the V4L2 isp device
+ * external to drm device to create and access the kernel BO.
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int isp_kernel_buffer_alloc(struct device *dev, u64 size,
+			    void **buf_obj, u64 *gpu_addr, void **cpu_addr)
+{
+	struct platform_device *ispdev = to_platform_device(dev);
+	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
+	const struct isp_platform_data *isp_pdata;
+	struct amdgpu_device *adev;
+	struct mfd_cell *mfd_cell;
+	int ret;
+
+	if (WARN_ON(!ispdev))
+		return -ENODEV;
+
+	if (WARN_ON(!buf_obj))
+		return -EINVAL;
+
+	if (WARN_ON(!gpu_addr))
+		return -EINVAL;
+
+	if (WARN_ON(!cpu_addr))
+		return -EINVAL;
+
+	mfd_cell = &ispdev->mfd_cell[0];
+	if (!mfd_cell)
+		return -ENODEV;
+
+	isp_pdata = mfd_cell->platform_data;
+	adev = isp_pdata->adev;
+
+	ret = is_valid_isp_device(ispdev->dev.parent, adev->dev);
+	if (ret)
+		return ret;
+
+	ret = amdgpu_bo_create_kernel(adev,
+				      size,
+				      ISP_MC_ADDR_ALIGN,
+				      AMDGPU_GEM_DOMAIN_GTT,
+				      bo,
+				      gpu_addr,
+				      cpu_addr);
+	if (!cpu_addr || ret) {
+		drm_err(&adev->ddev, "failed to alloc gart kernel buffer (%d)", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(isp_kernel_buffer_alloc);
+
+/**
+ * isp_kernel_buffer_free - free isp kernel buffer object (BO)
+ *
+ * @buf_obj: amdgpu isp user BO to free
+ * @gpu_addr: GPU addr of isp kernel BO
+ * @cpu_addr: CPU addr of isp kernel BO
+ *
+ * unmaps and unpin a isp kernel BO.
+ *
+ * This function is exported to allow the V4L2 isp device
+ * external to drm device to free the kernel BO.
+ */
+void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr)
+{
+	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
+
+	amdgpu_bo_free_kernel(bo, gpu_addr, cpu_addr);
+}
+EXPORT_SYMBOL(isp_kernel_buffer_free);
+
 static const struct amd_ip_funcs isp_ip_funcs = {
 	.name = "isp_ip",
 	.early_init = isp_early_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index 1d1c4b1ec7e7..d6f4ffa4c97c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -28,18 +28,13 @@
 #ifndef __AMDGPU_ISP_H__
 #define __AMDGPU_ISP_H__
 
+#include <drm/amd/isp.h>
 #include <linux/pm_domain.h>
 
 #define ISP_REGS_OFFSET_END 0x629A4
 
 struct amdgpu_isp;
 
-struct isp_platform_data {
-	void *adev;
-	u32 asic_type;
-	resource_size_t base_rmmio_size;
-};
-
 struct isp_funcs {
 	int (*hw_init)(struct amdgpu_isp *isp);
 	int (*hw_fini)(struct amdgpu_isp *isp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c5fda18967c8..122a88294883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -352,7 +352,6 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 
 	return 0;
 }
-EXPORT_SYMBOL(amdgpu_bo_create_kernel);
 
 /**
  * amdgpu_bo_create_isp_user - create user BO for isp
@@ -421,7 +420,6 @@ int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
 
 	return r;
 }
-EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
 
 /**
  * amdgpu_bo_create_kernel_at - create BO for kernel use at specific location
@@ -525,7 +523,6 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 	if (cpu_addr)
 		*cpu_addr = NULL;
 }
-EXPORT_SYMBOL(amdgpu_bo_free_kernel);
 
 /**
  * amdgpu_bo_free_isp_user - free BO for isp use
@@ -548,7 +545,6 @@ void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo)
 	}
 	amdgpu_bo_unref(&bo);
 }
-EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
 
 /* Validate bo size is bit bigger than the request domain */
 static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
diff --git a/include/drm/amd/isp.h b/include/drm/amd/isp.h
new file mode 100644
index 000000000000..ec868288abf2
--- /dev/null
+++ b/include/drm/amd/isp.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ */
+
+#ifndef __ISP_H__
+#define __ISP_H__
+
+#include <linux/types.h>
+
+struct device;
+
+struct isp_platform_data {
+	void *adev;
+	u32 asic_type;
+	resource_size_t base_rmmio_size;
+};
+
+int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
+			  void **buf_obj, u64 *buf_addr);
+
+void isp_user_buffer_free(void *buf_obj);
+
+int isp_kernel_buffer_alloc(struct device *dev, u64 size,
+			    void **buf_obj, u64 *gpu_addr, void **cpu_addr);
+
+void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr);
+
+#endif
-- 
2.43.0

