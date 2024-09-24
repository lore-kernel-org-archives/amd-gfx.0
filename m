Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088C5CF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 14:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3F610E700;
	Tue, 24 Sep 2024 14:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dwd/8PzY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D55E10E6F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 14:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftXHgjLp2B+VA+/ZRqHwWn8HpeeNxP0fC2lC2S36vIk4Ehvq1WqxhNrTjCR1oZxDcOuvbHIHs9xKfiGg3iDQewnYlAkLBhWC4f++RFPWuBXVlFSOkVUHaWNdeZuAjvSyQq71xLGQSRmA0sI8DMm3mUY54HAiUY0oMWQm3J/mUar0V/l5rkjjdLEM1syFa0NAZU4Zcvk/CQDuFOvOYYnNqfA6IqxICRzpgn+U4/f3r3l4os/+BP9i1i+T/sy/T5K2TgKOdxRmEHm7DWG9rTn8lhR0EFSw5r/nd5i42OoDbTWlHnIO3PSQyu4K+PcphjRYWFaxyXujBtC4MODXJlB7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7KmtDDJYiYzU7Vbl+2XHmd1tY3X5aBfd/Bk2ZYNaE4=;
 b=E5NXW9LbMB7Ck81rDSfEpGBHTzuJ7ha3wfeoBfqMrQ5xrijz0rKq8/qQlkQ5oqpQgo6S5ENzQAZ+2s3Mwjwifr1zXjz4CyMfpzcQVY0ycV+UtwOBGqZO1VvB7XbNd8kmPSfqXEpy2ItpgOlf2PHCwWRBbeQmIvqb1rLtW5Ju/HCLQqX6PH4xHHaX4pFpZb/dRVvkozt/fvcsblLg3SHyxn6XwUcFfyYrLn9Klh+YjkhaNRMqFiLJCz5KMB3dMGZ6XDcE2k14DhsjBognXvG3qKOT8KohKc4pu6qYh0zg7PuSiLcC+I7Mwa0xFvNrbP1tShHWBJ8NOKurdOKv+lW1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7KmtDDJYiYzU7Vbl+2XHmd1tY3X5aBfd/Bk2ZYNaE4=;
 b=dwd/8PzYFrpaoUoDZFYPXpbKdlN1PItGjk4vqBpTgdze9Dh25u4eE4EU8t3sIl8ICG7m+ZzXgJTvxyF8W6nsxvZe+Efpl+SrSaTEMkulHY0IjkVK3ai456mcR1eZzOn3bpSD0eclvPjo3hEz2V3+20N61nys8UE71n7y+3sZkqc=
Received: from SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) by LV3PR12MB9119.namprd12.prod.outlook.com
 (2603:10b6:408:1a2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 14:16:14 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::21) by SN6PR2101CA0020.outlook.office365.com
 (2603:10b6:805:106::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.3 via Frontend
 Transport; Tue, 24 Sep 2024 14:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 14:16:13 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 09:16:09 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: Add sysfs nodes to get xcp details
Date: Tue, 24 Sep 2024 22:15:48 +0800
Message-ID: <20240924141549.244754-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924141549.244754-1-asad.kamal@amd.com>
References: <20240924141549.244754-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: a34a8452-757d-492a-395f-08dcdca372a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vOObgFuzN5wLarUGFYzPDSP1Y34ggwrjA8QgW9a3lqcXCFi+S+iZ2CAAM/7m?=
 =?us-ascii?Q?0ynXMYZE4lgPvDXWt2XOzOD/ziIUCuiYfesnk7DEvBSO493Nz6gNy5uZXcvk?=
 =?us-ascii?Q?3zFjAuQDJQqA1WZ3tGBkBPmMcTd9DI2i51rO3gqSrtRTfMC2Av3ZwpA0VDf4?=
 =?us-ascii?Q?MhGAy6GDykXFjceEXp2VmNh6yxkEVBmcXURdjGsfHacVJhaGLewIQ2u8FE0I?=
 =?us-ascii?Q?142QmY1j0p/Sw7gOvbmJyIQwpwUXfFmMzpOP0l5DVium/iuLp+FFgiI9c7LZ?=
 =?us-ascii?Q?z76sQB1AyKAprU0BN4LYQaOVLe7sLnPqqaCYJms/ZNRvP68VCNSMBZK/CLna?=
 =?us-ascii?Q?BGWCg17/mfUbReoLEP3p2Z3mZEeSODKTHSRMybU4FrBBFrUjQewtSarENx7U?=
 =?us-ascii?Q?d7PnNQztmyc498nrRwAvyUmX73k3jf7URXnYD4iElTtCAM8K0IurDQVQktJr?=
 =?us-ascii?Q?njbRkvWR1s6KfarxQIFz5Ewn3csAusITa6iPQInZ3MrZ/jFgKMGbx7+lSYLM?=
 =?us-ascii?Q?ijQWvT0HqfjOS22kdgEPYP/maH8Q3d1nWYAWEardKfDu2Ufj+ZliJFAk2Fwr?=
 =?us-ascii?Q?592XZf0q+NF7BZuqXDKgaJjW4eMvj7Wp6SRaVV5GJ/gEOeZCDa72u/8khm9R?=
 =?us-ascii?Q?D68pSTlN9wo1Clr2gH9kMqGvp1AkMVVoWAN6Lz1F1TOzZcN/rV2N2H82kbF0?=
 =?us-ascii?Q?w7HocLY5BxxtOpOZt7UnCy7RSbMCWTW5OZ/nBVaZKvPS/61J0FwIvotAdW+m?=
 =?us-ascii?Q?HOlYCLKkV63Sj6Oqa3912LdUtx+W9HFjUAjpzP4FLLaJviRaiC6dehNr8e7B?=
 =?us-ascii?Q?oIRYQpUcyh7Dwc862z1DCtSww0EU4Mjs8HsKEfUqPW9KdP7gkoFxF6VnNpmV?=
 =?us-ascii?Q?SQEyycQNCN70JKFHLd7La985CvKAi8SKfBGwB9VgfpWzWTMsck5iQWSvm5GS?=
 =?us-ascii?Q?yT6XoHpObvDCFnk0xU+4LB3WIatZ/JLd52UgiKYtkF33hBswJBam+YWuIdfx?=
 =?us-ascii?Q?Jh8DuPa78+CciCLYcv+Wr1K3CMYlmtVesc0KW7uICVhNAAT2vb7a68u1nllP?=
 =?us-ascii?Q?M4ttld7r9lOIIViXYLlsMgxlp7b2Ifl+2ItajFODVnUi22mIbb5ZueyRk8Kh?=
 =?us-ascii?Q?YQNTTr4vwYQ+8dMTT8bXvQvvJMkzrA8Y3FqRWVaMMehjRqH38Q0MZ4EoBut8?=
 =?us-ascii?Q?54Z18WER/uqR/XPVjZVviTJg8VHyUNwZ66RQUKZ8smqxV3irSJIHvrjdCbYB?=
 =?us-ascii?Q?R+PfJ0AExqJhDk2UB6aEXxxeHs/pNHknEOVr5HF5KHtkAiv7nNWl3/jpZUPC?=
 =?us-ascii?Q?27e1lB8Al2Ao+b1Sh7QRV4G194EAc+jjHVjuZU4GRmwNyJfBrm2yeFdti0UO?=
 =?us-ascii?Q?5+S/rmr+57da2bE/cj7npx42G9lJiVvZiA0Yko3IaxMjeoEORfQsB+GFSS+B?=
 =?us-ascii?Q?gpUgEApu6hzKnATHYKfVcBlbpJYdZdlD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:16:13.9869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a34a8452-757d-492a-395f-08dcdca372a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add partition config nodes in sysfs to get resource instance details for
a particular partition mode. A resource could be anything like an xcc,
vcn decoder, system dma units etc.

Details of various resource instances are available under
/sys/bus/pci/devices/.../compute_partition_config/

Select a partition configuration:
/sys/bus/pci/devices/.../compute_partition_config/xcp_config

Number of instances of a resource:
/sys/bus/pci/devices/.../compute_partition_config/<rsrc_name>/num_inst

Total partitions sharing the resource:
/sys/bus/pci/devices/.../compute_partition_config/<rsrc_name>/num_shared

v2: Update node name as per spec

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 201 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |   5 +
 3 files changed, 208 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dee57f15719e..0de81262ec7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4505,6 +4505,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_fru_sysfs_init(adev);
 	amdgpu_reg_state_sysfs_init(adev);
+	amdgpu_xcp_cfg_sysfs_init(adev);
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
@@ -4628,6 +4629,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	amdgpu_fru_sysfs_fini(adev);
 
 	amdgpu_reg_state_sysfs_fini(adev);
+	amdgpu_xcp_cfg_sysfs_fini(adev);
 
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index a6d456ec6aeb..fc4ab1d8c7c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -433,3 +433,204 @@ void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 	}
 }
 
+#define XCP_CFG_SYSFS_RES_ATTR_SHOW(_name)                         \
+	static ssize_t amdgpu_xcp_res_sysfs_##_name##_show(        \
+		struct amdgpu_xcp_res_details *xcp_res, char *buf) \
+	{                                                          \
+		return sysfs_emit(buf, "%d\n", xcp_res->_name);    \
+	}
+
+struct amdgpu_xcp_res_sysfs_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct amdgpu_xcp_res_details *xcp_res, char *buf);
+};
+
+#define XCP_CFG_SYSFS_RES_ATTR(_name)                                        \
+	struct amdgpu_xcp_res_sysfs_attribute xcp_res_sysfs_attr_##_name = { \
+		.attr = { .name = __stringify(_name), .mode = 0400 },        \
+		.show = amdgpu_xcp_res_sysfs_##_name##_show,                 \
+	}
+
+XCP_CFG_SYSFS_RES_ATTR_SHOW(num_inst)
+XCP_CFG_SYSFS_RES_ATTR(num_inst);
+XCP_CFG_SYSFS_RES_ATTR_SHOW(num_shared)
+XCP_CFG_SYSFS_RES_ATTR(num_shared);
+
+#define XCP_CFG_SYSFS_RES_ATTR_PTR(_name) xcp_res_sysfs_attr_##_name.attr
+
+static struct attribute *xcp_cfg_res_sysfs_attrs[] = {
+	&XCP_CFG_SYSFS_RES_ATTR_PTR(num_inst),
+	&XCP_CFG_SYSFS_RES_ATTR_PTR(num_shared), NULL
+};
+
+ATTRIBUTE_GROUPS(xcp_cfg_res_sysfs);
+
+#define to_xcp_attr(x) \
+	container_of(x, struct amdgpu_xcp_res_sysfs_attribute, attr)
+#define to_xcp_res(x) container_of(x, struct amdgpu_xcp_res_details, kobj)
+
+static ssize_t xcp_cfg_res_sysfs_attr_show(struct kobject *kobj,
+					   struct attribute *attr, char *buf)
+{
+	struct amdgpu_xcp_res_sysfs_attribute *attribute;
+	struct amdgpu_xcp_res_details *xcp_res;
+
+	attribute = to_xcp_attr(attr);
+	xcp_res = to_xcp_res(kobj);
+
+	if (!attribute->show)
+		return -EIO;
+
+	return attribute->show(xcp_res, buf);
+}
+
+static const struct sysfs_ops xcp_cfg_res_sysfs_ops = {
+	.show = xcp_cfg_res_sysfs_attr_show,
+};
+
+static const struct kobj_type xcp_cfg_res_sysfs_ktype = {
+	.sysfs_ops = &xcp_cfg_res_sysfs_ops,
+	.default_groups = xcp_cfg_res_sysfs_groups,
+};
+
+const char *xcp_res_names[] = {
+	[AMDGPU_XCP_RES_XCC] = "xcc",
+	[AMDGPU_XCP_RES_DMA] = "dma",
+	[AMDGPU_XCP_RES_DEC] = "dec",
+	[AMDGPU_XCP_RES_JPEG] = "jpeg",
+};
+
+static int amdgpu_xcp_get_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
+				   int mode,
+				   struct amdgpu_xcp_cfg *xcp_cfg)
+{
+	if (xcp_mgr->funcs && xcp_mgr->funcs->get_xcp_res_info)
+		return xcp_mgr->funcs->get_xcp_res_info(xcp_mgr, mode, xcp_cfg);
+
+	return -EOPNOTSUPP;
+}
+
+#define to_xcp_cfg(x) container_of(x, struct amdgpu_xcp_cfg, kobj)
+static ssize_t xcp_config_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	struct amdgpu_xcp_cfg *xcp_cfg = to_xcp_cfg(kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			  amdgpu_gfx_compute_mode_desc(xcp_cfg->mode));
+}
+
+static ssize_t xcp_config_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t size)
+{
+	struct amdgpu_xcp_cfg *xcp_cfg = to_xcp_cfg(kobj);
+	int mode, r;
+
+	if (!strncasecmp("SPX", buf, strlen("SPX")))
+		mode = AMDGPU_SPX_PARTITION_MODE;
+	else if (!strncasecmp("DPX", buf, strlen("DPX")))
+		mode = AMDGPU_DPX_PARTITION_MODE;
+	else if (!strncasecmp("TPX", buf, strlen("TPX")))
+		mode = AMDGPU_TPX_PARTITION_MODE;
+	else if (!strncasecmp("QPX", buf, strlen("QPX")))
+		mode = AMDGPU_QPX_PARTITION_MODE;
+	else if (!strncasecmp("CPX", buf, strlen("CPX")))
+		mode = AMDGPU_CPX_PARTITION_MODE;
+	else
+		return -EINVAL;
+
+	r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, mode, xcp_cfg);
+
+	if (r)
+		return r;
+
+	xcp_cfg->mode = mode;
+	return size;
+}
+
+static struct kobj_attribute xcp_cfg_sysfs_mode =
+	__ATTR_RW_MODE(xcp_config, 0644);
+
+static void xcp_cfg_sysfs_release(struct kobject *kobj)
+{
+	struct amdgpu_xcp_cfg *xcp_cfg = to_xcp_cfg(kobj);
+
+	kfree(xcp_cfg);
+}
+
+static const struct kobj_type xcp_cfg_sysfs_ktype = {
+	.release = xcp_cfg_sysfs_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_xcp_res_details *xcp_res;
+	struct amdgpu_xcp_cfg *xcp_cfg;
+	int i, r, j, rid;
+
+	if (!adev->xcp_mgr)
+		return;
+
+	xcp_cfg = kzalloc(sizeof(*xcp_cfg), GFP_KERNEL);
+	if (!xcp_cfg)
+		return;
+	xcp_cfg->xcp_mgr = adev->xcp_mgr;
+
+	r = kobject_init_and_add(&xcp_cfg->kobj, &xcp_cfg_sysfs_ktype,
+				 &adev->dev->kobj, "compute_partition_config");
+	if (r)
+		goto err1;
+
+	r = sysfs_create_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
+	if (r)
+		goto err1;
+
+	r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, xcp_cfg->xcp_mgr->mode, xcp_cfg);
+	if (r)
+		goto err1;
+
+	xcp_cfg->mode = xcp_cfg->xcp_mgr->mode;
+	for (i = 0; i < xcp_cfg->num_res; i++) {
+		xcp_res = &xcp_cfg->xcp_res[i];
+		rid = xcp_res->id;
+		r = kobject_init_and_add(&xcp_res->kobj,
+					 &xcp_cfg_res_sysfs_ktype,
+					 &xcp_cfg->kobj, "%s",
+					 xcp_res_names[rid]);
+		if (r)
+			goto err;
+	}
+
+	adev->xcp_mgr->xcp_cfg = xcp_cfg;
+	return;
+err:
+	for (j = 0; j < i; j++) {
+		xcp_res = &xcp_cfg->xcp_res[i];
+		kobject_put(&xcp_res->kobj);
+	}
+
+	sysfs_remove_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
+err1:
+	kobject_put(&xcp_cfg->kobj);
+}
+
+void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_xcp_res_details *xcp_res;
+	struct amdgpu_xcp_cfg *xcp_cfg;
+	int i;
+
+	if (!adev->xcp_mgr)
+		return;
+
+	xcp_cfg =  adev->xcp_mgr->xcp_cfg;
+	for (i = 0; i < xcp_cfg->num_res; i++) {
+		xcp_res = &xcp_cfg->xcp_res[i];
+		kobject_put(&xcp_res->kobj);
+	}
+
+	sysfs_remove_file(&xcp_cfg->kobj, &xcp_cfg_sysfs_mode.attr);
+	kobject_put(&xcp_cfg->kobj);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 648237f27d1c..7ac89d78a5bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -68,6 +68,7 @@ struct amdgpu_xcp_res_details {
 	enum amdgpu_xcp_res_id id;
 	u8 num_inst;
 	u8 num_shared;
+	struct kobject kobj;
 };
 
 struct amdgpu_xcp_cfg {
@@ -75,6 +76,7 @@ struct amdgpu_xcp_cfg {
 	struct amdgpu_xcp_res_details xcp_res[AMDGPU_XCP_RES_MAX];
 	u8 num_res;
 	struct amdgpu_xcp_mgr *xcp_mgr;
+	struct kobject kobj;
 };
 
 struct amdgpu_xcp_ip_funcs {
@@ -172,6 +174,9 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 			      struct amdgpu_ctx_entity *entity);
 
+void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev);
+
 #define amdgpu_xcp_select_scheds(adev, e, c, d, x, y) \
 	((adev)->xcp_mgr && (adev)->xcp_mgr->funcs && \
 	(adev)->xcp_mgr->funcs->select_scheds ? \
-- 
2.46.0

