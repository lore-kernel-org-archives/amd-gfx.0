Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34FC3ABC5
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 06:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07DAE10E137;
	Wed, 14 May 2025 06:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AseKc8JN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE0810E137
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 06:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9+p/6XrNftfru2/i8r1pigxck12yK56G/kVqo6YeogGc2HssUTmZi8I4nCq0prYa/cKJ7oQTcM8EVFUayjvxgG7xfuPhXlWC2/18coVfJ4CwhQqGK2xk2KVw/F/MRjQ/9Dn89YEd5fS6IUrpnH/HTYSLKvAQrYmd92rNywsFGuvZtL8TngMANzkd4uUnd+vuvSrsr7wrNL985DDAi6DIHkAqHARH+B9roBLw4vCk1C1MeEKvEY7vf7Zft0YK22WXpmPUPn3ssyEvoPgFw3E/pELFoB6kmIP6LP5esEOK+KAZsD6sJVrBfnKsUoC4OlhiSnG6nXvHZwa5mwiP+GENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ScHrU/kW9qascrKNQ4nNBa3dxFfsZPllbAYFRxkTY4=;
 b=P3HM+BgAmqyKPPTtgH+pSLjzPhTS9BIj5WoFSbb0IDE7+qnp9zxsxgkSnhn6s6wbLPrWXwaS/FnAWuXiIJZa27iLF/WKKZtZdtbO+8cZUZ2r+IFjWBBWVwv84RQA7bps3IMZ1xK+PEQoYi9K+g2hutx2TlqR9rlm4vD1nWgLWD2cIcYLQUa8y3OOvzaS8W9LykCEc15+Lb2p3h6VD5F8PrnfActkwzRjAZjFE2P9vP/oaWQBh3d5ynGmiM4nkgNvm4Ro6EQBu2vQs+uWGcTuxRkQnm+f398yrX6YSmXo5klscSlVajnTVJyDGECmMix9D3ExfNMakjHC8Y0T0oJPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ScHrU/kW9qascrKNQ4nNBa3dxFfsZPllbAYFRxkTY4=;
 b=AseKc8JNJ+nyhHVUhXue3R+h5R4XDQ/r6svjj8PmeeOcB/AbcFzBabv+tBC9rqwzryNs/v5whfC9QdbzcEFlYIQOuKeCwugpgE3a86BGFhopwXKpHlHPl1vat+7F29b/9Htdb5prr0Kaz+IaKsbKgghx2Edtzz1QwIN5xBn15Vk=
Received: from BN9PR03CA0807.namprd03.prod.outlook.com (2603:10b6:408:13f::32)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 06:22:00 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::e6) by BN9PR03CA0807.outlook.office365.com
 (2603:10b6:408:13f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Wed,
 14 May 2025 06:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 06:21:59 +0000
Received: from codemachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 01:21:58 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <Hawking.Zhang@amd.com>, <Likun.Gao@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: add debugfs for spirom IFWI dump
Date: Wed, 14 May 2025 14:21:45 +0800
Message-ID: <20250514062145.82529-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 600c68bd-bf9e-44fe-d64c-08dd92afa260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tl8wkQ0zu066a4qUUd9dGzQWmpyiufIfXEFBq3oiaMS2q2m6chAwg/Np+pEL?=
 =?us-ascii?Q?b53dXDE5zB9XIBvvCa3WbjerMzWLvIc2W/7FxTaqixswPejisaqrqxn2LdFn?=
 =?us-ascii?Q?XARWb8A+d2oEKQdveEs69LqG2YHipDeDLfV2WFGlugHutUoOirEQx7CtY6H0?=
 =?us-ascii?Q?6EOYu9eg4tsboSQ982j8eMspEfNgOLIGZ0PPO2LH1pibJ1rHaUbOAXmH70yt?=
 =?us-ascii?Q?24wEWRs4O98J6DhU2bCJPu1/JT+jazyOXzioCNfwNNDi5YQoJvQEOy5PYCbn?=
 =?us-ascii?Q?U0EkGcGmBej++G9rfUwyaA0zdnTp2kaZ/YBdtNSLoSy4mEvSZxh0k5qUrGaZ?=
 =?us-ascii?Q?OrMP8TicgEBrbuAEBDNftVFKvbWFkuKuOWBpCi16xIWC+lwM5/h5YHysXW9w?=
 =?us-ascii?Q?wxxG1vWxrXOz9BX5eR5OH67Uj+ikq6MIU5uJST4M9n/xM0x3ORs/VyEgLV4g?=
 =?us-ascii?Q?poPTnnmM6daSYs815Pn7QcxnOjRSXhtSKid5Pvm+xBCOjVAf161qcwPsljjm?=
 =?us-ascii?Q?KfVLVt9SdIKjVtIOT3eJ1Adag/UrAFl6mWsr8mA2zl3aOdmnyFcbXfXuciqO?=
 =?us-ascii?Q?taGnEkzOrxUChK+SIxAzkiVG2BRq44Q0BkSgKXzDW2umxkMN6QxURyT4BX5A?=
 =?us-ascii?Q?zKakLjN8+OEPxL8ztS0EtmWizgsBpNWIuuegDKSOM8SZh+3OyNn8TpMsCQqo?=
 =?us-ascii?Q?ZlUNW/LIrNwkMclAMJAmETGjQlApyPukXjm/xg7fko1zZt6Bx0coBvKEITXh?=
 =?us-ascii?Q?YwPoPWpxl8lieSYj6qMF4ozrzvfGyUVzfXh1pfAlgkCkvgl9ASDv8QwUSnyE?=
 =?us-ascii?Q?9QGHlMPxrKAwKpWzHMdq1c4YnEOTKYBQ3Sknx9QsuFNMxIqauNOajcNXjxr9?=
 =?us-ascii?Q?A6+wHWx0Rt/vcirf3L+HLb7rRs53e51VtaFA1ljiAA33JKCR8kGrRnpEhSOm?=
 =?us-ascii?Q?GvGr9RlmjCnp5dg/TvdzsiTHIzsfnnWSBiJ9iM1iV7s/iZUd5aLmxZLNQT9v?=
 =?us-ascii?Q?pv6rujUTz+sywjPUefq+DKMaL/OFNeF4GdrpUxUFp9/L6Jv7XczkMQZs7euF?=
 =?us-ascii?Q?4SRrnWcvQdE0zFKzbESh8Lj0yKPcj43hTIlnzPEvCMlkKPUnlhkvmkMiKz96?=
 =?us-ascii?Q?zRLJ9/g00icrdVXnta20LnlwadTIHpb2HhdFVp1LcO5Md9Hr/ySmzePBP7gH?=
 =?us-ascii?Q?AOk8S+7n8bAdExOzd7wVtdRt8fgFexCBgLQtQRnJ75dB6sjbKrEOJQclm0E7?=
 =?us-ascii?Q?82Z/cPAQWXvcp9rlZIvgOoNsC7ub+oGGX9FkpoVh695P5CRzh0vRWq9ifFJb?=
 =?us-ascii?Q?MzhuOQfQ098D5G5JkI06gNmDaoTCgeBZxid3TxYqMc6xk/HZ82/MBKswRlx3?=
 =?us-ascii?Q?vDzrsckTikV6dvj5ZfkwA3lXf+D3kTM1yzZDLvZdefV+y3KJ2PlwPR4ESPSs?=
 =?us-ascii?Q?4369ujKzxCmv/i4a2POXDELB9kojQ6MaGu5/ErIsF1MsZzWWuv6osawiHgE3?=
 =?us-ascii?Q?E2uW5epbHSZutZi+uGZO2sxEwdDCGxIHNd/y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 06:21:59.7231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600c68bd-bf9e-44fe-d64c-08dd92afa260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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

v3: return directly the result of last command execution (Lijo)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  29 ++++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  44 +++++++--
 4 files changed, 168 insertions(+), 10 deletions(-)

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
index 17f1ccd8bd53..ec9462336bcf 100644
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
@@ -766,6 +758,37 @@ static int psp_v13_0_update_spirom(struct psp_context *psp,
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
+
+	return ret;
+}
+
 static int psp_v13_0_vbflash_status(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -898,6 +921,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
 	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
 	.update_spirom = psp_v13_0_update_spirom,
+	.dump_spirom = psp_v13_0_dump_spirom,
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
 	.get_ras_capability = psp_v13_0_get_ras_capability,
-- 
2.34.1

