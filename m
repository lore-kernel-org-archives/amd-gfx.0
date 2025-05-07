Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70BFC369DC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 04:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6588C10E0AC;
	Wed,  7 May 2025 04:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FWS9TquN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F3010E0AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 04:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQCZrMiyEHSeeI40qr6BA/4yCc5o2wpzvDpQP3Dp3KgTemjr4mgprhOpzlRiarZBy3Ff90kekrB942ai4tuq5MV0IfgFoNf1W1ov4G37ePmHxoNu3DQc4Xlki2hKRyoTzVENFDvDJoDc+bjKunpFNPBdUib+0HqmmyR2QQoS7MKo6EpY+v3sP5UpERgLjriIfXQgIsnOXKCUJP0MZVkxlyz8YikVQBBro3ActEP2n6mL7tXwqVwQmcSlwwTEuQzMOTXth2LZqyK2CculR9oeFojH5JQ6CI61RqJU8iHKyuLo82OKXRGHS/Z2zRLKxsw3/5ntXreJL8Zm0p/DB30QSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T0muim4X7skxXMnLg19okxfJ0xZBXbr6yQW9CnVaMA=;
 b=HK/Tcj3WeUj98ECr3yZPTRUFpew+PAJbStSr2aUsN7gQ2q+iyDtq7XQTxZw1Odn6kuxBd8HWTuK+eAE0dyS8+lXyaEeA/pFhw4thy4Me9XP0DlqJlogwKQxI4tIMpqfjQ4ep/fqss7y0A3oVkCrqxB83bV95EyWQchu1n0z1rvnj17Repx6uT4L5ZJLqS3GXucMVNxziC7p1w7PvV9yRQWsYVKADR6nbj7DMX2qJMYLPjl2vq5RiK8yvBpj7IOiFXaxyQ6O7qkRmlxNVJ4mOn0CMgJog/Xc7y9vaQPrXu1K93AYX1CnjprOeoFvUl4Ih10bgnHBK5L6eee11PZCjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T0muim4X7skxXMnLg19okxfJ0xZBXbr6yQW9CnVaMA=;
 b=FWS9TquNemL//czfkhnGzYaMKghm90HSNk1BvaBpBWYUKvPjrW5MLFj0y+ET9gP3Cz70NMe8mjZ8DbsEfQcnozs8mETUG7IH8EidCJeQeODiNlMqFHU871CKdBsFQy70zuVRbgFD/kOb/xdKPcxsORUheUWQMLzQ86qrRcgIqWw=
Received: from SA1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:806:2ce::6)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.35; Wed, 7 May
 2025 04:42:13 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::d6) by SA1PR04CA0006.outlook.office365.com
 (2603:10b6:806:2ce::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 7 May 2025 04:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 04:42:12 +0000
Received: from codemachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 23:42:11 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <Hawking.Zhang@amd.com>, <Likun.Gao@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
Date: Wed, 7 May 2025 12:41:59 +0800
Message-ID: <20250507044159.1006093-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 4259eb4a-3b76-4653-cf44-08dd8d21891f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wp9FsL0Vswz3fxX/RQztB/3HavnoPJwxMBvanSRGbvm5JxzVahQiqNMz7q7R?=
 =?us-ascii?Q?Y2rw8vOb90IfRk/f9i5fVcqDXw42URW0StDA1TLInevIaqtbw5NwnkfLrTEo?=
 =?us-ascii?Q?qW4MTAhxTcvOrbIKKJq6IIlWH7OPrlo6DctoQ65hSfSSv1iAZq0YzoZWk2SP?=
 =?us-ascii?Q?fOdX6X0o8IS4j/qZ6okHMst7KxBVgGzpTKobTGtWLSXSZQ7A1LLMCgEYGYt2?=
 =?us-ascii?Q?84XovwBjhVdRTpGJihY4Z5QCC5fhiH/f8uTM2ZNGRDIDZ23L+HUo1mwrBkG2?=
 =?us-ascii?Q?Pb9SFgopfYji7MnPktydV6e4llXRtnarwcjdurAUFcq+ZpbI/Wp5rSOTRBG/?=
 =?us-ascii?Q?FVdZT1rxtZMYgKAg4s16H5pOfCK+ihgw3Mgvk7S2u/4zhGvD2bVk9T6qsjbg?=
 =?us-ascii?Q?xY+VmAac+wevoGHtLjIxRZ63TswJzhvRRQXAW1QY+cYmdWlTv4vczcxQixuK?=
 =?us-ascii?Q?JNdv80ziXmKl3pxmO0t0eYzYYMaisfjU6jzr3siWELIa4hNcJn1APSofRCmF?=
 =?us-ascii?Q?Ba3KKppEeW5QEwXR1s4uK0BEPd4oKqzE8k5icbViktpOw+7bRtm2eJuJcIUm?=
 =?us-ascii?Q?UaEcGZuXYaSYlU/7Er9brDaN4ouRMl0f6GZySfLBepbjrmrINIIN2m9aTqHg?=
 =?us-ascii?Q?ofq122RJoHpWPuGXgdtRt67GeggycsBC/ypplj+KG3/qmgfMc1Q6sLxL8cEy?=
 =?us-ascii?Q?QDRHTO+og0R1QEWfiaABNkiPauLpv5PE4uL960n1jAwUpuf/YLCbU4hkG6fb?=
 =?us-ascii?Q?nRsUQOTKibdF3nrbeoF4nuNrx2FlBrOH1yEvrkLCXydX1zpRqpqyGhQAG2gt?=
 =?us-ascii?Q?15wy0o/1ii2/nVwUK4/EX+ajPFO02uWxdPK/wKwGKr+IS2YWtdBRHqDMJNbI?=
 =?us-ascii?Q?Yvemv9EyUMZA+0NvJysRt5pWQrvJ66oL6bJ7g+XUgNw+ifidGDl/9aj1x67E?=
 =?us-ascii?Q?JPOuIogct3HT9iDWGlATppcA6r6sRdySHAViyqPYDvaOU7HOnfvZxHiMB00/?=
 =?us-ascii?Q?nty7QH0VfIwniWCIRA+V0Acz22Lmeg5wBgqv5ECtjRDssnC5DZItkZlb5/Rk?=
 =?us-ascii?Q?t6smtjd2esvUYHnuvViDBTmxFDNrcLMbJFKWVDcanhx58PQGNNot2HI4uH++?=
 =?us-ascii?Q?b0p1xnlqK5RfdX+DWTzT1gr1T+gW0Rqm9IYDXknmiYRJo6GEjqLw90tD+AKl?=
 =?us-ascii?Q?+2YM35O58fwdSq5rSPduUg381cyOHBe2cfrlpc2ep68sEmK5b6s5LCh5Cabq?=
 =?us-ascii?Q?qhoposVYo86KPQRp2w2QI98026yXJDmmTPXDmYjLnLZEFxoZKfD3HoR7qTN8?=
 =?us-ascii?Q?P4fwKaD39q/HiH8Zhw0dAA5v6QdCZrBY+M8HGy8ANbd/ZTS4dJcytWfGJo7R?=
 =?us-ascii?Q?AT5qUIHHjuf7Ad6tcWrNz+FMJQluZ4B1IfdtH6GARt367aoEm5F+rxVClGHA?=
 =?us-ascii?Q?uE1yOiynD5xADVw/7CI1mihIAqJlM9QjPbibadMSg+oKxwNdb+BLpU53Hfue?=
 =?us-ascii?Q?02+xoaHATf7/l/kPknx9JbKau6lxoMpheZaJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:42:12.9758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4259eb4a-3b76-4653-cf44-08dd8d21891f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  17 ++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  40 +++++++-
 4 files changed, 161 insertions(+), 1 deletion(-)

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
index 6f9bcffda875..210a7bdda332 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4185,6 +4185,110 @@ const struct attribute_group amdgpu_flash_attr_group = {
 	.is_visible = amdgpu_flash_attr_is_visible,
 };
 
+#if defined(CONFIG_DEBUG_FS)
+static int psp_read_spirom_debugfs_open(struct inode *inode, struct file *filp)
+{
+	struct amdgpu_device *adev = filp->f_inode->i_private;
+	struct bo_address_triplet *bo_triplet;
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
+	bo_triplet = kzalloc(sizeof(struct bo_address_triplet), GFP_KERNEL);
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
+	struct bo_address_triplet *bo_triplet = adev->psp.spirom_dump_trip;
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
+	struct bo_address_triplet *bo_triplet = adev->psp.spirom_dump_trip;
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
index 3876ac57ce62..8fc4a7bb865e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -138,6 +138,7 @@ struct psp_funcs {
 	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
 	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
+	int (*dump_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*vbflash_stat)(struct psp_context *psp);
 	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
 	bool (*get_ras_capability)(struct psp_context *psp);
@@ -322,6 +323,14 @@ struct psp_runtime_scpm_entry {
 	enum psp_runtime_scpm_authentication scpm_status;
 };
 
+#if defined(CONFIG_DEBUG_FS)
+struct bo_address_triplet {
+	struct amdgpu_bo *bo;
+	uint64_t mc_addr;
+	void *cpu_addr;
+};
+#endif
+
 struct psp_context {
 	struct amdgpu_device		*adev;
 	struct psp_ring			km_ring;
@@ -409,6 +418,9 @@ struct psp_context {
 	char				*vbflash_tmp_buf;
 	size_t				vbflash_image_size;
 	bool				vbflash_done;
+#if defined(CONFIG_DEBUG_FS)
+	struct bo_address_triplet       *spirom_dump_trip;
+#endif
 };
 
 struct amdgpu_psp_funcs {
@@ -467,6 +479,10 @@ struct amdgpu_psp_funcs {
 	((psp)->funcs->update_spirom ? \
 	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
 
+#define psp_dump_spirom(psp, fw_pri_mc_addr) \
+	((psp)->funcs->dump_spirom ? \
+	(psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
+
 #define psp_vbflash_status(psp) \
 	((psp)->funcs->vbflash_stat ? \
 	(psp)->funcs->vbflash_stat((psp)) : -EINVAL)
@@ -578,6 +594,7 @@ int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,
 bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
 int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
 				   enum psp_reg_prog_id id);
+void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
 
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 17f1ccd8bd53..78f434f84c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -79,6 +79,9 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
 #define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
 #define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
 #define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
+#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf
+#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10
+#define C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
 
 /* memory training timeout define */
 #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
@@ -710,7 +713,8 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
 	/* Ring the doorbell */
 	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
 
-	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
+	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
+	    cmd == C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
 		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
 						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
 	else
@@ -766,6 +770,39 @@ static int psp_v13_0_update_spirom(struct psp_context *psp,
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
@@ -898,6 +935,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
 	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
 	.update_spirom = psp_v13_0_update_spirom,
+	.dump_spirom = psp_v13_0_dump_spirom,
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
 	.get_ras_capability = psp_v13_0_get_ras_capability,
-- 
2.34.1

