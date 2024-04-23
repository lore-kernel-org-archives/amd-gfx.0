Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352CAC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 08:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A52E1131EB;
	Tue, 23 Apr 2024 08:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5a1nHhO4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD721131E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 08:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eynA6X9a+3tcIFkxrwG1pRpmmXWFVuTLweW5A6sKHTpybt6i7YRevNOuHn60KTFYSzSm0xCo7VJkRf7aHtHlg1FvFly4uHERyILoZKqUE8/g1f5gtV24mmEBBeExKuGnr6q7uvXLCxgTrPM4KqOtdQpok+3MSDoR9TX5eiIrqy2jXUWuJMPlQh+c8HxfzCEDkmz8x9p3JzDqQVi+kVKvCpJQYGHdx88zpgSVY22BJIoEH+oGagj+iRPO6LeBkxWT4QdbZCUaq+OqNtET816YRqdECYiU+w8VoXJaJ2/E0P1g1lbnw56VAqoaw7zSMrrCE4uk/H1xI0TOdHtcCPy/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhiczASRaQmbkvrxuUuT796v7uAYkTc99r7tnDjeUB8=;
 b=Fp+qf07z2G1SSfel7NJYzUVDLSrh3Vk7g81FujiY4/LWXQXoZbCLAFwCX5Ti6tqCbq/deM/OKwrlRf+FY0x6Y8iRfdkZw2JUuyGHuIW/1cwVdxOqmD3Lwy9gklp6vWl6RNNrf60e2lDr1sN3LeKpkdNCQogM3UtmsJcWFsfs/FM7D9wQDSDJDZ7G5W2h/uDn7VY4QfSYTWTSP9X4Uk9ReiRQIcs98LwVGuQzYRpVGh86oySkVQdI+36ugpEUGPvz/43BtfttZCby6EQrk0csNKD8eGZGeRNDJD0enL7nYDd5H0Byet9670TjwNyZwlqwwhXGrZfgj7nPgrObo14IlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhiczASRaQmbkvrxuUuT796v7uAYkTc99r7tnDjeUB8=;
 b=5a1nHhO4/mZu8PeTmHms/oRkC17AfrMzw+CZFAzr+vbjZEs6PN4tMaOg/FoD5piZTTph5Ac/AV24vyx9+wZRT/gEKf/ett8uv7T21rzqs93WgT92/tJTv0xiG9wORPOOi9vMNXyQXYntSIP5grH6rdngPtfFzShm19QbpzPdb8I=
Received: from BN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:408:e4::21)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:26:57 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::eb) by BN0PR02CA0016.outlook.office365.com
 (2603:10b6:408:e4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 08:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 08:26:57 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 03:26:55 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add MCA smu cache support
Date: Tue, 23 Apr 2024 16:26:39 +0800
Message-ID: <20240423082640.3273762-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423082640.3273762-1-kevinyang.wang@amd.com>
References: <20240423082640.3273762-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e918d1-4e0d-4be3-056f-08dc636f23b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gl5fUj1T1eMYA3eHBBrIZHF6C/+QUWT3ZXRwInCeiQ1jdz/Wfd6Z1Ovd6lDI?=
 =?us-ascii?Q?Lac61Npe3BZYSc2tfQeOsg7B27B/g10x3tjM458O+UN54sK1EdvyMMwpTGl6?=
 =?us-ascii?Q?EUEC3GNthxV0+iczDBwuoPgOTcuw+wHwLWKL76v28+QErnMIK+ewYKhDsWl3?=
 =?us-ascii?Q?d98g823wKMKgYRhyuSraUAnKoC1AwnyxvuMNjjmBKDi6mr90BNJM2diZc3vF?=
 =?us-ascii?Q?qw1ZHYMu4mW1x7ioVClh1XDIIgTCr14B/D56rp7nG58xls5MXXoCyWqudkWS?=
 =?us-ascii?Q?0dJ5jhqg2d+SkrLxPiIT2geAjApMxXHJix1E+eP0+kWl04eajWF8SrKu/0KW?=
 =?us-ascii?Q?iw7meaBPbWxx2F+/y5TWS/hkM7Sv+bKWsu8LuM+T8FDVsj8O/0fjMZSRJH62?=
 =?us-ascii?Q?WLq2LrukHC8xIQ7qAM6MOSUin36q8MO0Ycv1kERcQMGnJ7RkZQHQJZ0u6zeR?=
 =?us-ascii?Q?nK63Q1/yRT2gMbrkbAjiQoHXnzILs5jngG8deMGOlqeL6y2m1PLi2tEDuGa6?=
 =?us-ascii?Q?h2Gm+VBS9k338z7pLmU9oRFmMbsqgQsJ9LTA4IfbaIJ/kANnC65ec8pv0u3V?=
 =?us-ascii?Q?YYfdyGARqkI7DUKG1aN/EyGjzt6aTPXqy7E/5lfi4G7suQllnLDYA0WaRYzW?=
 =?us-ascii?Q?mzoXx/AU/lNsDaP89EbV687PULyNiB2/rMm30EtMcWJy8Jf1gOPA4u+kejsd?=
 =?us-ascii?Q?qhCA0boqHaff8vyPuK/Pk0zisoxAeVd9Hxc1pA5IImWDRe0lLb+Y+EeTW7JQ?=
 =?us-ascii?Q?qhJunugWv+d5NgS2/slDvyQ8yScgEBdOpYUNcuJfyyrq3Nv9yQ4fTxgtLdfp?=
 =?us-ascii?Q?kFkwT777d/iXL4LijrYZJ29dwXyrikSX0BUJVsgIjm7+4+jgdxNMIKgPOr3B?=
 =?us-ascii?Q?NwbTqZXWd303YqeOplwfpMpUW5lkmcsqb5UtX5j4VwHmOriKsZRNO370oTBz?=
 =?us-ascii?Q?reFuY0mYfLZK0XwdFlSOXnIGPcK11KO33naOhboYusWwCWam6rdtS7sQsMcK?=
 =?us-ascii?Q?8p/37dKDd7RWCQPlccGnNHIb3fmMZUecj2w9OtsM2ECOmtkQRLI66DhEvBy1?=
 =?us-ascii?Q?TPKatXgHFZ67ngn1trkSZ6Piwso/AYFMmrCyrf2Lu7YLZ/SXF4QUxBIWCH3e?=
 =?us-ascii?Q?v4qgLyTDJLlOFyCal2cMYGQrOksfFwWi2xrIsCQuNyQ6T+yYmVahZVbW3Yhr?=
 =?us-ascii?Q?rDqFoQm3NuWItU0S6OCDm8bTrpMRZxEvdhkdHUJm9o7TXvCn+BoM/5kjVyJO?=
 =?us-ascii?Q?4m23C5LGewoy9j+hPRrulmYtFtjpscRyvLl8OOxUr791pQwaMBPh7bZdJnW3?=
 =?us-ascii?Q?myFHyXkPj2W8asWpZDmP60ViKr+H3RQpYMHNJ8UXwmO86n4R7RcprZlo05N0?=
 =?us-ascii?Q?MnvqdZLkvxX7tpELRjymO6XpU8zW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:26:57.0622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e918d1-4e0d-4be3-056f-08dc636f23b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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

v1:
because SMU CE valid mca bank will be cleared after reading,
this patch adds mca cache at the driver level to ensure that the mca bank is not lost.

v2:
refine amdgpu_mca_init/fini/reset() function name.

v3:
add mca_cache.lock support
only add CE bank to mca bank cache.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 95 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h | 19 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  9 +++
 3 files changed, 116 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 859d594c02a5..264f56fd4f66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -183,6 +183,29 @@ static int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mc
 	return 0;
 }
 
+static int amdgpu_mca_bank_set_merge(struct mca_bank_set *mca_set, struct mca_bank_set *new)
+{
+	struct mca_bank_node *node;
+
+	list_for_each_entry(node, &new->list, node)
+		amdgpu_mca_bank_set_add_entry(mca_set, &node->entry);
+
+	return 0;
+}
+
+static int amdgpu_mca_bank_set_remove_node(struct mca_bank_set *mca_set, struct mca_bank_node *node)
+{
+	if (!node)
+		return -EINVAL;
+
+	list_del(&node->node);
+	kvfree(node);
+
+	mca_set->nr_entries--;
+
+	return 0;
+}
+
 static void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set)
 {
 	struct mca_bank_node *node, *tmp;
@@ -200,6 +223,41 @@ void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_m
 	mca->mca_funcs = mca_funcs;
 }
 
+int amdgpu_mca_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_mca *mca = &adev->mca;
+	struct mca_bank_cache *mca_cache;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
+		mca_cache = &mca->mca_caches[i];
+		mutex_init(&mca_cache->lock);
+		amdgpu_mca_bank_set_init(&mca_cache->mca_set);
+	}
+
+	return 0;
+}
+
+void amdgpu_mca_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_mca *mca = &adev->mca;
+	struct mca_bank_cache *mca_cache;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
+		mca_cache = &mca->mca_caches[i];
+		amdgpu_mca_bank_set_release(&mca_cache->mca_set);
+		mutex_destroy(&mca_cache->lock);
+	}
+}
+
+int amdgpu_mca_reset(struct amdgpu_device *adev)
+{
+	amdgpu_mca_fini(adev);
+
+	return amdgpu_mca_init(adev);
+}
+
 int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
@@ -314,7 +372,7 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_r
 {
 	struct ras_err_addr err_addr;
 	struct amdgpu_smuio_mcm_config_info mcm_info;
-	struct mca_bank_node *node;
+	struct mca_bank_node *node, *tmp;
 	struct mca_bank_entry *entry;
 	uint32_t count;
 	int ret;
@@ -325,7 +383,7 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_r
 	if (!mca_set->nr_entries)
 		return 0;
 
-	list_for_each_entry(node, &mca_set->list, node) {
+	list_for_each_entry_safe(node, tmp, &mca_set->list, node) {
 		entry = &node->entry;
 
 		count = 0;
@@ -359,15 +417,30 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_r
 				amdgpu_ras_error_statistic_ce_count(err_data,
 								    &mcm_info, &err_addr, (uint64_t)count);
 		}
+
+		amdgpu_mca_bank_set_remove_node(mca_set, node);
 	}
 
 	return 0;
 }
 
+static int amdgpu_mca_add_mca_set_to_cache(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, struct mca_bank_set *new)
+{
+	struct mca_bank_cache *mca_cache = &adev->mca.mca_caches[type];
+	int ret;
+
+	mutex_lock(&mca_cache->lock);
+	ret = amdgpu_mca_bank_set_merge(&mca_cache->mca_set, new);
+	mutex_unlock(&mca_cache->lock);
+
+	return ret;
+}
+
 int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
 				 struct ras_err_data *err_data, struct ras_query_context *qctx)
 {
 	struct mca_bank_set mca_set;
+	struct mca_bank_cache *mca_cache = &adev->mca.mca_caches[type];
 	int ret;
 
 	amdgpu_mca_bank_set_init(&mca_set);
@@ -377,6 +450,21 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 		goto out_mca_release;
 
 	ret = amdgpu_mca_dispatch_mca_set(adev, blk, type, &mca_set, err_data);
+	if (ret)
+		goto out_mca_release;
+
+	/* add remain mca bank to mca cache */
+	if (mca_set.nr_entries) {
+		ret = amdgpu_mca_add_mca_set_to_cache(adev, type, &mca_set);
+		if (ret)
+			goto out_mca_release;
+	}
+
+	/* dispatch mca set again if mca cache has valid data */
+	mutex_lock(&mca_cache->lock);
+	if (mca_cache->mca_set.nr_entries)
+		ret = amdgpu_mca_dispatch_mca_set(adev, blk, type, &mca_cache->mca_set, err_data);
+	mutex_unlock(&mca_cache->lock);
 
 out_mca_release:
 	amdgpu_mca_bank_set_release(&mca_set);
@@ -443,6 +531,9 @@ static int mca_dump_show(struct seq_file *m, enum amdgpu_mca_error_type type)
 	list_for_each_entry(node, &mca_set.list, node)
 		mca_dump_entry(m, &node->entry);
 
+	/* add mca bank to mca bank cache */
+	ret = amdgpu_mca_add_mca_set_to_cache(adev, type, &mca_set);
+
 err_free_mca_set:
 	amdgpu_mca_bank_set_release(&mca_set);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 4d0a0f91c375..9b97cfa28e05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -77,11 +77,22 @@ struct amdgpu_mca_ras {
 	struct amdgpu_mca_ras_block *ras;
 };
 
+struct mca_bank_set {
+	int nr_entries;
+	struct list_head list;
+};
+
+struct mca_bank_cache {
+	struct mca_bank_set mca_set;
+	struct mutex lock;
+};
+
 struct amdgpu_mca {
 	struct amdgpu_mca_ras mp0;
 	struct amdgpu_mca_ras mp1;
 	struct amdgpu_mca_ras mpio;
 	const struct amdgpu_mca_smu_funcs *mca_funcs;
+	struct mca_bank_cache mca_caches[AMDGPU_MCA_ERROR_TYPE_DE];
 };
 
 enum mca_reg_idx {
@@ -113,11 +124,6 @@ struct mca_bank_node {
 	struct list_head node;
 };
 
-struct mca_bank_set {
-	int nr_entries;
-	struct list_head list;
-};
-
 struct amdgpu_mca_smu_funcs {
 	int max_ue_count;
 	int max_ce_count;
@@ -149,6 +155,9 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev);
 
 void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs);
+int amdgpu_mca_init(struct amdgpu_device *adev);
+void amdgpu_mca_fini(struct amdgpu_device *adev);
+int amdgpu_mca_reset(struct amdgpu_device *adev);
 int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable);
 int amdgpu_mca_smu_get_mca_set_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 					   enum amdgpu_mca_error_type type, uint32_t *total);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 46b7f0c5cd8a..23766bdffe5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3426,6 +3426,13 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 
 		amdgpu_ras_set_aca_debug_mode(adev, false);
 	} else {
+		if (amdgpu_in_reset(adev))
+			r = amdgpu_mca_reset(adev);
+		else
+			r = amdgpu_mca_init(adev);
+		if (r)
+			return r;
+
 		amdgpu_ras_set_mca_debug_mode(adev, false);
 	}
 
@@ -3498,6 +3505,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 
 	if (amdgpu_aca_is_enabled(adev))
 		amdgpu_aca_fini(adev);
+	else
+		amdgpu_mca_fini(adev);
 
 	WARN(AMDGPU_RAS_GET_FEATURES(con->features), "Feature mask is not cleared");
 
-- 
2.34.1

