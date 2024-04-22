Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C37C10F15
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9ED112936;
	Mon, 22 Apr 2024 09:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DrV3q8SH";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E99112934
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+s1uD3F5j4lw59LD7IcbWoPGGVSB3964T2QBwrtCrcRXMuDxVg6Q2bA+rKg1CKE+CnrJhKeH6dp6MWL4Ww2cpzVUshMtIW7bXsWPMfwq7PW5f4YwfwE4Uu5ylLiSkCC6cpHgHMsZfY8X/CBN7c6CnfwFlzIOfzcu/GRNAjfbRpCcRNYSQjeSpKqT4Lz0eppE9i8pQkgsG8dKWcD0RIzCYmyX7Uu4PD0zgQunBD4SUncS3t82OD3Vgr2EAoDcLIy/21BR/bvGueaEXfEupwakJkBAAyLyxmW5RN9/ANzxaQwMPsj7SBgq6WxIYp7lXpnv6oeBePynIgygFkj2E8Oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ+t2RXJ/45KDmsHlWpzagiGbAztqPrqT9Xr8rWrFfs=;
 b=mcAhSA7dgGdYkPOQA84PocjuGZGaz6qQaiOZufcY0LABP8CAaXpB9P7aL2TFZBSkMp80MbeoflJSznJl5tOA3fjQrQX7wONZIcAjK+7Uk/O2ex26NrbNe7bNRouwf8jfa94YWnfkdDqf68hKv2VWK2naJTnC9wGmHvNoNq8q9pK4GrLgxvhKjrd4Ngocud9Vs5xFRGlNunA8AazV9iYefW/W8hBF2EzKKx6Qp7X8cpuEUN2e37hbuJ+tyzbFAYHLUzIQjCsLnPsTWp9RbZmROyjEkW6ZoZUBXYMpZOgmOj1gheyDzE0HjgUw5enQYolc23JpPIO7Tdiv8ZZUf48lTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ+t2RXJ/45KDmsHlWpzagiGbAztqPrqT9Xr8rWrFfs=;
 b=DrV3q8SHIihjAW8/7J6y2T3SI3RrIu0FZtD1RSE8IavhGUgWRprPoKnBcyd8Ch5QK2snokQF0Ier1C7z2OUidDq/UMRFJMpyfFz47BFDDOmXbAqrA/NL7Yq5yyGUcspgWXClvMRvcSE9pqXBNBkCJw7ZitI2IyjXtj+5vjLEHAA=
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:36:14 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::2d) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 09:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 09:36:13 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 04:36:10 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add MCA smu cache support
Date: Mon, 22 Apr 2024 17:35:36 +0800
Message-ID: <20240422093536.2689784-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422093536.2689784-1-kevinyang.wang@amd.com>
References: <20240422093536.2689784-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 346d3e79-3c98-438c-9bfa-08dc62afa6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pzoFz9stwqONEvo35Iy6EC53RKXLe8MXQ60EFXuM3RqetsLEwGbdApEkNNIk?=
 =?us-ascii?Q?5C//tSRxjlWpactSgbF/tyXqUqrTnRjk50BC7wsPci5wXV2KJeayq3NXlEj5?=
 =?us-ascii?Q?8YkZx6EwoM+4LFFY4qUxYGwh8CMKGQxrGk/mwbhOqkOdO2m3mEgacCMhDOgz?=
 =?us-ascii?Q?INhVo0raN71uS6L+h0DSS2xkfSqd73n2A9qORnGCra3kfpKLuWXYnkmOgGg1?=
 =?us-ascii?Q?00b50QC+mB21y61HVrXt/0zaRH+FzOOWhuf1NlEghSdVEbBqT4GwURmwJmAp?=
 =?us-ascii?Q?OTh1Y5Wtvv0MgJGVGqFRoNCw+j+bQOEhIeVi0qquRLcJ9GvmLHvIIf3ZGLs0?=
 =?us-ascii?Q?9whACZADzoSvnupLl99jnWV17lyjzX9dliXqprRZa/gTzb8pSr8DTHilskA8?=
 =?us-ascii?Q?1ngY+4pjkt0wOdMmmVXTGn4sbP6BbpwHSrRpgKxde4DNAVcclmF6KK1LMoAj?=
 =?us-ascii?Q?hFeq6F3fX1VXyRyGAB2EfQUeyprqqWBnZ3MjWiGNGDhMJ9LOhkw1ahAuoUgt?=
 =?us-ascii?Q?1CE2r0LX3KkRkMD0oyDx6Y7tW5Af2LWOhIaFOb1ZHZvuqxOXXcinNkAJZoYP?=
 =?us-ascii?Q?+HoLR0KAazqwv3TV1X+hFceWQ581359vnDrQ7pfH6cFb1qjM0KHhvZJ/Xi8Z?=
 =?us-ascii?Q?T49dLS1Ko+NIpTPb61XF/fADE7Kr1YWA63qMfmW3Dz/jvlKDHJFs4MM4dOGE?=
 =?us-ascii?Q?HgP0W9scZmvVME+ea0Fn5iGT/SCa5xMv0xaV831RJ3HqXq/vhyp1JTAH+eCm?=
 =?us-ascii?Q?kx4G9/xEAwBMFEjI4sW5i3NIZEkY8oL4+fc45Nk8wOcYiKMGPS+rDXIWYBFu?=
 =?us-ascii?Q?etAaJdcbKBhcUgtWGbpqgiFJcq0/o9+HyvZfyQg8qjaGzToBn9brdd3fWZg9?=
 =?us-ascii?Q?sdEo6gDPB0F5f2KS5fDTE+TDaMxOJ7Pcofk78yry8K8gsMcjTg++Jmtve1B1?=
 =?us-ascii?Q?Sqy7p2yMy/MQG2bd8tkTlhAt84fFtu0Poad8C7ywQaXOha8mb8LfcWv4Hg/W?=
 =?us-ascii?Q?si+9FIO+C1giB6+oOLs250bm0D3q7KlXpH5FCKnRnJpqFJ0Nkj0TMXsmmLMi?=
 =?us-ascii?Q?GaQxHGM1DIjoQJZDPFYRpc8c/A7I4JJHQGU/OfNMGXmXRco0K1rlrA6OfDMR?=
 =?us-ascii?Q?gXEAx6+uCpchh2xtJ3jN9OjdZ5+kAtMc5IRHn9a4aVv8xurMwmXLIGcFTAZQ?=
 =?us-ascii?Q?ll7SEU3et7TENYb6RQJFbT0P2UidzF9mFTHsCiuvOupilXsCxg+mspDin1K5?=
 =?us-ascii?Q?5LXvN39D4hDN9JhzL6LaAEPfreqdPnA2ZWnn5egbu58HmCYIj/cLPm6UjUD5?=
 =?us-ascii?Q?8rAqJ9UBj0Uk/hCMG5gq+nEHbK0GeaRlqKYVdT4vPdTkpo6ZaNG9mAm91eXP?=
 =?us-ascii?Q?8BBQC7sj10L1lmnQZ49rhW9dmj5t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:36:13.2769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 346d3e79-3c98-438c-9bfa-08dc62afa6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 94 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h | 20 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  9 +++
 3 files changed, 116 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 68b0e3608b9c..db4640016fe2 100644
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
@@ -322,7 +380,7 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_r
 	if (!mca_set)
 		return -EINVAL;
 
-	list_for_each_entry(node, &mca_set->list, node) {
+	list_for_each_entry_safe(node, tmp, &mca_set->list, node) {
 		entry = &node->entry;
 
 		count = 0;
@@ -356,15 +414,30 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_r
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
@@ -374,6 +447,21 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 		goto out_mca_release;
 
 	ret = amdgpu_mca_dispatch_mca_set(adev, blk, type, &mca_set, err_data);
+	if (ret)
+		goto out_mca_release;
+
+	/* add remain mca bank to mca cache */
+	if (type == AMDGPU_MCA_ERROR_TYPE_CE && mca_set.nr_entries) {
+		ret = amdgpu_mca_add_mca_set_to_cache(adev, type, &mca_set);
+		if (ret)
+			goto out_mca_release;
+
+		/* dispatch mca set again if mca cache has valid data */
+		mutex_lock(&mca_cache->lock);
+		if (mca_cache->mca_set.nr_entries)
+			ret = amdgpu_mca_dispatch_mca_set(adev, blk, type, &mca_cache->mca_set, err_data);
+		mutex_unlock(&mca_cache->lock);
+	}
 
 out_mca_release:
 	amdgpu_mca_bank_set_release(&mca_set);
@@ -440,6 +528,8 @@ static int mca_dump_show(struct seq_file *m, enum amdgpu_mca_error_type type)
 	list_for_each_entry(node, &mca_set.list, node)
 		mca_dump_entry(m, &node->entry);
 
+	amdgpu_mca_add_mca_set_to_cache(adev, type, &mca_set);
+
 err_free_mca_set:
 	amdgpu_mca_bank_set_release(&mca_set);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 4d0a0f91c375..96fc632b38fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -66,6 +66,7 @@ enum amdgpu_mca_error_type {
 	AMDGPU_MCA_ERROR_TYPE_UE = 0,
 	AMDGPU_MCA_ERROR_TYPE_CE,
 	AMDGPU_MCA_ERROR_TYPE_DE,
+	AMDGPU_MCA_ERROR_TYPE_COUNT,
 };
 
 struct amdgpu_mca_ras_block {
@@ -77,11 +78,22 @@ struct amdgpu_mca_ras {
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
@@ -113,11 +125,6 @@ struct mca_bank_node {
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
@@ -149,6 +156,9 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev);
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

