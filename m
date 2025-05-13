Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA1C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 09:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF19710E508;
	Tue, 13 May 2025 09:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1jyFSIa5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E02610E508
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 09:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW0Gr/SLCil2ItJfyAUOSsRxwOJFnClpEue23grOcE1avXxyzpGjWyYlq3WADfb5WW8OhIdo5UU+nIxyLn0IqhZwaTWc8VVwgJsrEKHyfoevKYIzTNffsga/HhIq+fdW5jQn4JDMuO+icsYbwuQehO0j4OibCQoqUxuhJYDPDFViCLYXf4XgUjSw3/6YYdkFpwnJKCiVBcs2IOeo8Aj0jilf5GJXWMh273NvGPKt55Qrj75i2YFw7ZX/dBpJ+ufgG7T77BzmyrIbm1yg5eqQDndRVBiJEuKYPXeC8PQLuSsvB9hfFAie16fKp1Whh6EnFHfzbmKhJ1PAY+JDEhVuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6DmNnV7tyNGK5ayjAr03V8RrvezVGJ/dF3BzltrIDw=;
 b=rp5OogHGTqGyM0YekvbIcdpezw/RAtYjiqIbQiKro1gw9IaFhbPZV4R8qLZJ5uyzqtils2t2r0CfIdxRVEhyvIlPoGVKMInFWGkvPwsRCtxiajdI4nh2f8Na2YiR8/bNThMybANsXC+HB9JbH1Ni0G+d8X4x7qMdrHuRblRXh5jVDZLhameSqXolwxh6DreNA+efeSbP08Vpxay/NTEAGU6mx3vNhC/kw5wo9R73hb1Na+3uTobYz6XuIk8Y66pvewkG5/fQyOQ3BFzRRnzbgpQG8dLsR39jV2EETMAOChLsdGj//qcKE+ReF65ArEdrAyCTTZo445X+NOZXqLXHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6DmNnV7tyNGK5ayjAr03V8RrvezVGJ/dF3BzltrIDw=;
 b=1jyFSIa5t76H1PbJylhLA/kiLHJgcr7teJfHCAMot0ld/25E3NRPIfjbLBgPZ1QiwccDfsbZxkGNqiA1xBgllcy0c7gvJQv+IKVOVl+IdqLYkLXZh1IbrhPDFppgBNPinQSjKLxkPYRJ53J9CfvZmnEiGWNwELYTBVUMsQYynzA=
Received: from SA1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::18)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 09:14:03 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::5f) by SA1P222CA0018.outlook.office365.com
 (2603:10b6:806:22c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Tue,
 13 May 2025 09:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 09:14:02 +0000
Received: from codemachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 04:14:01 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <Hawking.Zhang@amd.com>, <Likun.Gao@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: add debugfs for spirom IFWI dump
Date: Tue, 13 May 2025 17:13:48 +0800
Message-ID: <20250513091348.57701-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9ece98-9b83-4697-4f14-08dd91fe80d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zt8YAySF562vNm55sVkspqZN6pYFnJutW7egn3nGBKT35U9UTiPqXcfv1oYV?=
 =?us-ascii?Q?W52sS1DucbV5CIdWA0EQbRKdZafb+YqXYWDl1+i0AfzPWh+QKmrtS663uxME?=
 =?us-ascii?Q?lhkR9HcXOeMW2Xv56MncAPr5gaxiSeDT6KAyO6v1/J4H5fsUZxnFkKWS2YIg?=
 =?us-ascii?Q?nhRrQxPEv3i1GQnGGPVA0AGk8jve5yICxCNwHKCqDGteHO5auvg54FcIURkA?=
 =?us-ascii?Q?r9ScRmEB7BIeDXjjm73pQKXtWiJK/m2lCdr+73iCv5bHkC+TfhJpr/MPILhs?=
 =?us-ascii?Q?v2mFDN4bPXpFffnxJmy9MG9seUHAQ1mPlFmdoNg7JA3W4gbOXa9Z2p4zCQnP?=
 =?us-ascii?Q?Pcv80z1bK4ncyvvtxZ3hYORIJnYzt7fqiPicZRgDQJyqNn0eEN2UMyDz9XoC?=
 =?us-ascii?Q?S0Qb/Mau0VFQLG5Hlbv2mU8pSMzEUdhzS+GJGN7LrpbXnGBvZ7TMyIe1eGHh?=
 =?us-ascii?Q?3v1YazUgaF5SAkflyuohy9NTTApgESctOyciXoXmiM/jxc4kKv5oe02YIhlh?=
 =?us-ascii?Q?WJz03HiBVSJf7L0CVKiaNFLEZ0IZlDzkVlhINhlPCPMtSjDTogVsKvuVu5J/?=
 =?us-ascii?Q?gH3uXuWbXqYyRo/2wBNfafaFcw9tvQbobVdHwDHii8KeRTKWtSNpZAcHG2lo?=
 =?us-ascii?Q?z4YLW2MfVD8jhJnwyv/SGbVbtd9MUeTGtkB/ZL7xMugeaLqzaYADM4WVfxnq?=
 =?us-ascii?Q?g13yMRAP6GJOui33KVVuiouPQCxtNbXXCX976t67w71wGX7EWfTC2Bm1znRa?=
 =?us-ascii?Q?rsIyfXCncyN0W8AWGiuSpsmTCLzEFx7XwnTxuTNTQ2mhAHfYYzVduBBzxbAx?=
 =?us-ascii?Q?dFlX3EGz/7EuIBTNie+YBt6tiXMmJgV8ceW7YUF8G0p9Z2aoJ05biebFIE/R?=
 =?us-ascii?Q?jkLcmZB6RfaC0C7y2kAhlz923zp5YPhuhDtcl3hvMZBZs629prtrkbdEa7XO?=
 =?us-ascii?Q?yx2gRaQgQhafKMvkGnXScp6IZ0gUHgxdikDiIcg9z5HPfsV69dtP4QDl+wy1?=
 =?us-ascii?Q?pNmfROR+n+2slZQTDVtLDTOhWfVu3yy5HXuKOOVmCfaJ3oA5pgah6SRHVuWV?=
 =?us-ascii?Q?2mGlrdpiAziE02NAfeVGUh8ravRym7QoaKZ5PhTsPfzdasXTrHtzMLj4j63U?=
 =?us-ascii?Q?vbbBeLTMyB1v4EBSFV6DiZJWvjWaIT19YrrmsyF1pTGkjFfOYp+kf69At6vl?=
 =?us-ascii?Q?hSC+MASNyXT/XnZTvNcZQnVs+MB8eHOBn0jjOY88dslH2ugi81TK2Frp9L3x?=
 =?us-ascii?Q?m8lVnS9DsM5SKDJi05D3pRwlpj3DEzRtjbBqS1ck3hcj+9zgG1TEbvmsyNoB?=
 =?us-ascii?Q?UxlbybDURtMJbKJTpr6JmpWQ37ihzjz9INjBMAXwfKJZ/ceQQgHLoOmr17HS?=
 =?us-ascii?Q?iUybYIa5RWQbb5vg3j7bWjxeqYG+sOKDmYAdl4KnY/0b2RS/IX+Ey1elVcz4?=
 =?us-ascii?Q?6It0lkiebzYkAa7neNGq10horuEecMiSTyx5pE+lIheAvLQ7ezD5wuObVGne?=
 =?us-ascii?Q?sbRu/fI2AthrtktJQMq+xKrJouT1RHjaOcC/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 09:14:02.5191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9ece98-9b83-4697-4f14-08dd91fe80d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974
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

Expose the debugfs file node for user space to dump the IFWI image
on spirom.

For one transaction between PSP and host, it will read out the
images on both active and inactive partitions so a buffer with two
times the size of maximum IFWI image (currently 16MByte) is needed.

v2: move the vbios gfl macros to the common header and rename the
    bo triplet struct to spirom_bo for this specfic usage (Hawking)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  29 ++++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  46 +++++++--
 4 files changed, 170 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 4835123c99f3..bfa3b1519d4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	amdgpu_rap_debugfs_init(adev);
 	amdgpu_securedisplay_debugfs_init(adev);
 	amdgpu_fw_attestation_debugfs_init(adev);
+	amdgpu_psp_debugfs_init(adev);
 
 	debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
 			    &amdgpu_evict_vram_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6f9bcffda875..3a27ce75f80c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4185,6 +4185,110 @@ const struct attribute_group amdgpu_flash_attr_group = {
 	.is_visible = amdgpu_flash_attr_is_visible,
 };
 
+#if defined(CONFIG_DEBUG_FS)
+static int psp_read_spirom_debugfs_open(struct inode *inode, struct file *filp)
+{
+	struct amdgpu_device *adev = filp->f_inode->i_private;
+	struct spirom_bo *bo_triplet;
+	int ret;
+
+	/* serialize the open() file calling */
+	if (!mutex_trylock(&adev->psp.mutex))
+		return -EBUSY;
+
+	/*
+	 * make sure only one userpace process is alive for dumping so that
+	 * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is consumed.
+	 * let's say the case where one process try opening the file while
+	 * another one has proceeded to read or release. In this way, eliminate
+	 * the use of mutex for read() or release() callback as well.
+	 */
+	if (adev->psp.spirom_dump_trip) {
+		mutex_unlock(&adev->psp.mutex);
+		return -EBUSY;
+	}
+
+	bo_triplet = kzalloc(sizeof(struct spirom_bo), GFP_KERNEL);
+	if (!bo_triplet) {
+		mutex_unlock(&adev->psp.mutex);
+		return -ENOMEM;
+	}
+
+	ret = amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B * 2,
+					AMDGPU_GPU_PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_GTT,
+					&bo_triplet->bo,
+					&bo_triplet->mc_addr,
+					&bo_triplet->cpu_addr);
+	if (ret)
+		goto rel_trip;
+
+	ret = psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
+	if (ret)
+		goto rel_bo;
+
+	adev->psp.spirom_dump_trip = bo_triplet;
+	mutex_unlock(&adev->psp.mutex);
+	return 0;
+rel_bo:
+	amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
+			      &bo_triplet->cpu_addr);
+rel_trip:
+	kfree(bo_triplet);
+	mutex_unlock(&adev->psp.mutex);
+	dev_err(adev->dev, "Trying IFWI dump fails, err = %d\n", ret);
+	return ret;
+}
+
+static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char __user *buf, size_t size,
+				loff_t *pos)
+{
+	struct amdgpu_device *adev = filp->f_inode->i_private;
+	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
+
+	if (!bo_triplet)
+		return -EINVAL;
+
+	return simple_read_from_buffer(buf,
+				       size,
+				       pos, bo_triplet->cpu_addr,
+				       AMD_VBIOS_FILE_MAX_SIZE_B * 2);
+}
+
+static int psp_read_spirom_debugfs_release(struct inode *inode, struct file *filp)
+{
+	struct amdgpu_device *adev = filp->f_inode->i_private;
+	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
+
+	if (bo_triplet) {
+		amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
+				      &bo_triplet->cpu_addr);
+		kfree(bo_triplet);
+	}
+
+	adev->psp.spirom_dump_trip = NULL;
+	return 0;
+}
+
+static const struct file_operations psp_dump_spirom_debugfs_ops = {
+	.owner = THIS_MODULE,
+	.open = psp_read_spirom_debugfs_open,
+	.read = psp_read_spirom_debugfs_read,
+	.release = psp_read_spirom_debugfs_release,
+	.llseek = default_llseek,
+};
+#endif
+
+void amdgpu_psp_debugfs_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+
+	debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_root,
+				adev, &psp_dump_spirom_debugfs_ops, AMD_VBIOS_FILE_MAX_SIZE_B * 2);
+#endif
+}
+
 const struct amd_ip_funcs psp_ip_funcs = {
 	.name = "psp",
 	.early_init = psp_early_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 3876ac57ce62..089b6ae48329 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -39,6 +39,18 @@
 #define PSP_TMR_ALIGNMENT	0x100000
 #define PSP_FW_NAME_LEN		0x24
 
+/* VBIOS gfl defines */
+#define MBOX_READY_MASK 0x80000000
+#define MBOX_STATUS_MASK 0x0000FFFF
+#define MBOX_COMMAND_MASK 0x00FF0000
+#define MBOX_READY_FLAG 0x80000000
+#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
+#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
+#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
+#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf
+#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10
+#define C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
+
 extern const struct attribute_group amdgpu_flash_attr_group;
 
 enum psp_shared_mem_size {
@@ -138,6 +150,7 @@ struct psp_funcs {
 	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
 	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
+	int (*dump_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*vbflash_stat)(struct psp_context *psp);
 	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
 	bool (*get_ras_capability)(struct psp_context *psp);
@@ -322,6 +335,14 @@ struct psp_runtime_scpm_entry {
 	enum psp_runtime_scpm_authentication scpm_status;
 };
 
+#if defined(CONFIG_DEBUG_FS)
+struct spirom_bo {
+	struct amdgpu_bo *bo;
+	uint64_t mc_addr;
+	void *cpu_addr;
+};
+#endif
+
 struct psp_context {
 	struct amdgpu_device		*adev;
 	struct psp_ring			km_ring;
@@ -409,6 +430,9 @@ struct psp_context {
 	char				*vbflash_tmp_buf;
 	size_t				vbflash_image_size;
 	bool				vbflash_done;
+#if defined(CONFIG_DEBUG_FS)
+	struct spirom_bo *spirom_dump_trip;
+#endif
 };
 
 struct amdgpu_psp_funcs {
@@ -467,6 +491,10 @@ struct amdgpu_psp_funcs {
 	((psp)->funcs->update_spirom ? \
 	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
 
+#define psp_dump_spirom(psp, fw_pri_mc_addr) \
+	((psp)->funcs->dump_spirom ? \
+	(psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
+
 #define psp_vbflash_status(psp) \
 	((psp)->funcs->vbflash_stat ? \
 	(psp)->funcs->vbflash_stat((psp)) : -EINVAL)
@@ -578,6 +606,7 @@ int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,
 bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
 int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
 				   enum psp_reg_prog_id id);
+void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
 
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 17f1ccd8bd53..99ff0bfd9d4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -71,15 +71,6 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
 /* Retry times for vmbx ready wait */
 #define PSP_VMBX_POLLING_LIMIT 3000
 
-/* VBIOS gfl defines */
-#define MBOX_READY_MASK 0x80000000
-#define MBOX_STATUS_MASK 0x0000FFFF
-#define MBOX_COMMAND_MASK 0x00FF0000
-#define MBOX_READY_FLAG 0x80000000
-#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
-#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
-#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
-
 /* memory training timeout define */
 #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
 
@@ -710,7 +701,8 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
 	/* Ring the doorbell */
 	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
 
-	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
+	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
+	    cmd == C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
 		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
 						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
 	else
@@ -766,6 +758,39 @@ static int psp_v13_0_update_spirom(struct psp_context *psp,
 	return 0;
 }
 
+static int psp_v13_0_dump_spirom(struct psp_context *psp,
+				   uint64_t fw_pri_mc_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	/* Confirm PSP is ready to start */
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
+			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
+	if (ret) {
+		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
+		return ret;
+	}
+
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, lower_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
+	if (ret)
+		return ret;
+
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, upper_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
+	if (ret)
+		return ret;
+
+	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int psp_v13_0_vbflash_status(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -898,6 +923,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
 	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
 	.update_spirom = psp_v13_0_update_spirom,
+	.dump_spirom = psp_v13_0_dump_spirom,
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
 	.get_ras_capability = psp_v13_0_get_ras_capability,
-- 
2.34.1

