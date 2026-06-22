Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B92CDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3D310E56C;
	Mon, 22 Jun 2026 08:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pj0LPSol";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6597310E572
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8hcDdI3pus1XOZxdWHNuCVUHRxlaJKkKkWRm9F4u4ocz6LyWegRgEktqejyV1jZvvh439JdyW/577kN7pHaD5xWaafcdiyLB2acJPNY9qn+YoCFrhpePxzhUhj0g9V3Bken0GM+NmyuXuPsVGVk/kphb6Z1EnywxZCPfHvsZlBLYyPw/jD/2NsGH8OX3hoYfuDJMhAIVXrW8h0ZBOBqku875SevvZiUwq5nvpHmUf+b0BPo+1R5r3nEmU65O0avn/9ztC3pR+N+lWuwMSSI/RWjnjpmDjVSUuAy7wtRyem8+qYa1ZbQAjWHLZ0qDP0zrWAVjShPH3WM3oqefeGGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6jmQJOoyxbUQsr+RGwPkQ2nRp6/k7n6dZRvy6+f92c=;
 b=FOkCH8TAJWkFTPHw8wPDB/+elA2km6f3nBfOqHcHK6DJBxsxO6UaBKLqNSMqTRbVlx1ds7O6jGb+V111GHZ7Zk5uM+t24l8HEU7A+RRmKcVufk7CfmXL4HsX4IJstY1/DDRRbLHLG2eJi+7bxJea7GbrgKxCoefANa0K88H4yOa45qcP4Gg3FVF6UL6WHQ/kxPn+ZlEh5+K60ss2i9TRgJzT/qK6xLV7XQldB/8K9tZu6PBZjX58syFMS38Cbyx8A+HyJRBxtg9sU8oW6u1E8K9BnH326N9SKZNIlreffgGU9ZAY7xJepsL/Tdsy0UcZG1k8/as8mT+LinuiRv7i3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6jmQJOoyxbUQsr+RGwPkQ2nRp6/k7n6dZRvy6+f92c=;
 b=Pj0LPSolKeg017zQ40bzw7eBMikPJiUZL/Y8e76kD4bAIrUh5CKXdqZpxK+O1PC/nFbGKtO+LrXaI4VEXMjKnJ6Nm423uHHI9oKa9xiHQOC7wuvGXYPZ1eahBjNFkSimaAgCJyxM8ioDUukOLm4up7R+AL3WlXkflGxuXRVJu/8=
Received: from CY5PR16CA0024.namprd16.prod.outlook.com (2603:10b6:930:10::9)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 08:45:43 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::ab) by CY5PR16CA0024.outlook.office365.com
 (2603:10b6:930:10::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:43 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:40 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 17/48] drm/amdgpu: retire MCA support
Date: Mon, 22 Jun 2026 16:44:19 +0800
Message-ID: <fe2f56a89cc24bde4c8d231dd3f4b69e424a9083.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f55f710-64d8-46ad-4ce8-08ded03aa52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|56012099006|11063799006|6133799003|18092099006|22082099003|18002099003|10086099003;
X-Microsoft-Antispam-Message-Info: GGzLbWImo1dw9u1Luy3CtqTB6mnedS/RR03yXHrZroKRhzo4ldLiZvakm98Q27C5w4IhtS9kdTbgV/oEsdF45h0HP6vpGnxDwz4c/rNlGHAaVJDeIjsnYyUzMSi0ZmHWFPx9Y86YVkACyvOUjQFcHthXrzpEy32aHilyyPjCb36/Esu+O6GG538nttcSkMTks2tocfkAlkr5buQRdAcPHNwlG7EDl5/qK7aSmtPC+tNcNt3GjODOpdqaI7ji60GPJ/vmonNR1KY9LLuLxajl4fvXhsjt7RJJ9XyodCubcciIGMf/rxuADsVP7iSDZH+HuhEfJNBx+YoPksPZAQycmIWSJVk0+rQdwsANxrlAq32ej007mPIDPldMYiDaLGXrxgXUrPY2F86ip1/CKS9YB9C75oNJbimrC3zZxDJV81ldGchojGOmRJI6XhLjJwiAKZVZprT8p+1aVddm89WjQuT4CQBT/mhXM8gc7WVI13NabY5FLyQqhWJyrqDk3AYbIRlvM//6xBPY2K9eRWaqGf7jc9DS1DqoeQTgsQuOTVvOdWFR1Ccwmu/UxJwy6G85FZykamFcS0EUASBYyjbgTYA/ZzK/Oo3INFo3IStibqHQzqIZjXqaN1kZvNI7jC7i6aEjduFO3AVowhqxMVXpG9S+maSKZ5B6UaFr2k1n/TB5CeCA15YqQuuniGabksYco5IBAFGPF7yAj/pMPq+fQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(6133799003)(18092099006)(22082099003)(18002099003)(10086099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nb0p/4TSY8k/av6n9QsSBtrxcC6p0AIluZFOpwZq2sUF5ltY7tZa2l8pW9EZg9hqxIFGxikmYF4WX8/mCWHSXQN2XvWpr571jAdI+wfjgso1iz0gGTysprmgm2E21iN3SLvqrv7sdJmu1YAri/fHUXJxXB4AY08t0GzKOs9l9pxgoTFpPdhU0vvcT9eaIW7hQTpy13eQwbpAwOyqIJs+91TPDN2x1OQS8ojcg+qotVf71G4ErEAL41E9k4E6+qA+euhB8VWKvGwJZcZcDlGrQqRfANGebpz6FcnxBNWXBLa68/wTuSiQKOf8nDxAAuduO3D2U2U6LI+Cqw34BfQE/Qw92/PgVF0gSGgdkeq0ybapVYy0Vj2gcctPWD6z0BcSS3Ir9x2AljffgHOUySgALtI6c2yrYnHmfxT8zEh6plFDvygWP/wd7gnIO+33hUso
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:43.0189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f55f710-64d8-46ad-4ce8-08ded03aa52d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
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

retire MCA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 486 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h | 107 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  45 +--
 3 files changed, 3 insertions(+), 635 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index e1e4a61b1301..9a7f7d2b2767 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -27,16 +27,6 @@
 #include "umc/umc_6_7_0_offset.h"
 #include "umc/umc_6_7_0_sh_mask.h"
 
-static bool amdgpu_mca_is_deferred_error(struct amdgpu_device *adev,
-					uint64_t mc_status)
-{
-	if (adev->umc.ras->check_ecc_err_status)
-		return adev->umc.ras->check_ecc_err_status(adev,
-				AMDGPU_MCA_ERROR_TYPE_DE, &mc_status);
-
-	return false;
-}
-
 void amdgpu_mca_query_correctable_error_count(struct amdgpu_device *adev,
 					      uint64_t mc_status_addr,
 					      unsigned long *error_count)
@@ -155,479 +145,3 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
-
-static void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set)
-{
-	if (!mca_set)
-		return;
-
-	memset(mca_set, 0, sizeof(*mca_set));
-	INIT_LIST_HEAD(&mca_set->list);
-}
-
-static int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_entry *entry)
-{
-	struct mca_bank_node *node;
-
-	if (!entry)
-		return -EINVAL;
-
-	node = kvzalloc(sizeof(*node), GFP_KERNEL);
-	if (!node)
-		return -ENOMEM;
-
-	memcpy(&node->entry, entry, sizeof(*entry));
-
-	INIT_LIST_HEAD(&node->node);
-	list_add_tail(&node->node, &mca_set->list);
-
-	mca_set->nr_entries++;
-
-	return 0;
-}
-
-static int amdgpu_mca_bank_set_merge(struct mca_bank_set *mca_set, struct mca_bank_set *new)
-{
-	struct mca_bank_node *node;
-
-	list_for_each_entry(node, &new->list, node)
-		amdgpu_mca_bank_set_add_entry(mca_set, &node->entry);
-
-	return 0;
-}
-
-static void amdgpu_mca_bank_set_remove_node(struct mca_bank_set *mca_set, struct mca_bank_node *node)
-{
-	if (!node)
-		return;
-
-	list_del(&node->node);
-	kvfree(node);
-
-	mca_set->nr_entries--;
-}
-
-static void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set)
-{
-	struct mca_bank_node *node, *tmp;
-
-	if (list_empty(&mca_set->list))
-		return;
-
-	list_for_each_entry_safe(node, tmp, &mca_set->list, node)
-		amdgpu_mca_bank_set_remove_node(mca_set, node);
-}
-
-void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs)
-{
-	struct amdgpu_mca *mca = &adev->mca;
-
-	mca->mca_funcs = mca_funcs;
-}
-
-int amdgpu_mca_init(struct amdgpu_device *adev)
-{
-	struct amdgpu_mca *mca = &adev->mca;
-	struct mca_bank_cache *mca_cache;
-	int i;
-
-	atomic_set(&mca->ue_update_flag, 0);
-
-	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
-		mca_cache = &mca->mca_caches[i];
-		mutex_init(&mca_cache->lock);
-		amdgpu_mca_bank_set_init(&mca_cache->mca_set);
-	}
-
-	return 0;
-}
-
-void amdgpu_mca_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_mca *mca = &adev->mca;
-	struct mca_bank_cache *mca_cache;
-	int i;
-
-	atomic_set(&mca->ue_update_flag, 0);
-
-	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
-		mca_cache = &mca->mca_caches[i];
-		amdgpu_mca_bank_set_release(&mca_cache->mca_set);
-		mutex_destroy(&mca_cache->lock);
-	}
-}
-
-int amdgpu_mca_reset(struct amdgpu_device *adev)
-{
-	amdgpu_mca_fini(adev);
-
-	return amdgpu_mca_init(adev);
-}
-
-int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-
-	if (mca_funcs && mca_funcs->mca_set_debug_mode)
-		return mca_funcs->mca_set_debug_mode(adev, enable);
-
-	return -EOPNOTSUPP;
-}
-
-static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, struct mca_bank_entry *entry,
-					 struct ras_query_context *qctx)
-{
-	u64 event_id = qctx ? qctx->evid.event_id : RAS_EVENT_INVALID_ID;
-
-	RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architecture events logged\n");
-	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].STATUS=0x%016llx\n",
-		      idx, entry->regs[MCA_REG_IDX_STATUS]);
-	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].ADDR=0x%016llx\n",
-		      idx, entry->regs[MCA_REG_IDX_ADDR]);
-	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].MISC0=0x%016llx\n",
-		      idx, entry->regs[MCA_REG_IDX_MISC0]);
-	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].IPID=0x%016llx\n",
-		      idx, entry->regs[MCA_REG_IDX_IPID]);
-	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].SYND=0x%016llx\n",
-		      idx, entry->regs[MCA_REG_IDX_SYND]);
-}
-
-static int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-
-	if (!count)
-		return -EINVAL;
-
-	if (mca_funcs && mca_funcs->mca_get_valid_mca_count)
-		return mca_funcs->mca_get_valid_mca_count(adev, type, count);
-
-	return -EOPNOTSUPP;
-}
-
-static int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-					int idx, struct mca_bank_entry *entry)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	int count;
-
-	if (!mca_funcs || !mca_funcs->mca_get_mca_entry)
-		return -EOPNOTSUPP;
-
-	switch (type) {
-	case AMDGPU_MCA_ERROR_TYPE_UE:
-		count = mca_funcs->max_ue_count;
-		break;
-	case AMDGPU_MCA_ERROR_TYPE_CE:
-		count = mca_funcs->max_ce_count;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (idx >= count)
-		return -EINVAL;
-
-	return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
-}
-
-static bool amdgpu_mca_bank_should_update(struct amdgpu_device *adev, enum amdgpu_mca_error_type type)
-{
-	struct amdgpu_mca *mca = &adev->mca;
-	bool ret = true;
-
-	/*
-	 * Because the UE Valid MCA count will only be cleared after reset,
-	 * in order to avoid repeated counting of the error count,
-	 * the aca bank is only updated once during the gpu recovery stage.
-	 */
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE) {
-		if (amdgpu_ras_intr_triggered())
-			ret = atomic_cmpxchg(&mca->ue_update_flag, 0, 1) == 0;
-		else
-			atomic_set(&mca->ue_update_flag, 0);
-	}
-
-	return ret;
-}
-
-static bool amdgpu_mca_bank_should_dump(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-					struct mca_bank_entry *entry)
-{
-	bool ret;
-
-	switch (type) {
-	case AMDGPU_MCA_ERROR_TYPE_CE:
-		ret = amdgpu_mca_is_deferred_error(adev, entry->regs[MCA_REG_IDX_STATUS]);
-		break;
-	case AMDGPU_MCA_ERROR_TYPE_UE:
-	default:
-		ret = true;
-		break;
-	}
-
-	return ret;
-}
-
-static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set,
-				      struct ras_query_context *qctx)
-{
-	struct mca_bank_entry entry;
-	uint32_t count = 0, i;
-	int ret;
-
-	if (!mca_set)
-		return -EINVAL;
-
-	if (!amdgpu_mca_bank_should_update(adev, type))
-		return 0;
-
-	ret = amdgpu_mca_smu_get_valid_mca_count(adev, type, &count);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < count; i++) {
-		memset(&entry, 0, sizeof(entry));
-		ret = amdgpu_mca_smu_get_mca_entry(adev, type, i, &entry);
-		if (ret)
-			return ret;
-
-		amdgpu_mca_bank_set_add_entry(mca_set, &entry);
-
-		if (amdgpu_mca_bank_should_dump(adev, type, &entry))
-			amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx);
-	}
-
-	return 0;
-}
-
-static int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-						enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-
-	if (!count || !entry)
-		return -EINVAL;
-
-	if (!mca_funcs || !mca_funcs->mca_parse_mca_error_count)
-		return -EOPNOTSUPP;
-
-	return mca_funcs->mca_parse_mca_error_count(adev, blk, type, entry, count);
-}
-
-static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
-				       struct mca_bank_set *mca_set, struct ras_err_data *err_data)
-{
-	struct amdgpu_smuio_mcm_config_info mcm_info;
-	struct mca_bank_node *node, *tmp;
-	struct mca_bank_entry *entry;
-	uint32_t count;
-	int ret;
-
-	if (!mca_set)
-		return -EINVAL;
-
-	if (!mca_set->nr_entries)
-		return 0;
-
-	list_for_each_entry_safe(node, tmp, &mca_set->list, node) {
-		entry = &node->entry;
-
-		count = 0;
-		ret = amdgpu_mca_smu_parse_mca_error_count(adev, blk, type, entry, &count);
-		if (ret && ret != -EOPNOTSUPP)
-			return ret;
-
-		if (!count)
-			continue;
-
-		memset(&mcm_info, 0, sizeof(mcm_info));
-
-		mcm_info.socket_id = entry->info.socket_id;
-		mcm_info.die_id = entry->info.aid;
-
-		if (type == AMDGPU_MCA_ERROR_TYPE_UE) {
-			amdgpu_ras_error_statistic_ue_count(err_data,
-							    &mcm_info, (uint64_t)count);
-		} else {
-			if (amdgpu_mca_is_deferred_error(adev, entry->regs[MCA_REG_IDX_STATUS]))
-				amdgpu_ras_error_statistic_de_count(err_data,
-								    &mcm_info, (uint64_t)count);
-			else
-				amdgpu_ras_error_statistic_ce_count(err_data,
-								    &mcm_info, (uint64_t)count);
-		}
-
-		amdgpu_mca_bank_set_remove_node(mca_set, node);
-	}
-
-	return 0;
-}
-
-static int amdgpu_mca_add_mca_set_to_cache(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, struct mca_bank_set *new)
-{
-	struct mca_bank_cache *mca_cache = &adev->mca.mca_caches[type];
-	int ret;
-
-	mutex_lock(&mca_cache->lock);
-	ret = amdgpu_mca_bank_set_merge(&mca_cache->mca_set, new);
-	mutex_unlock(&mca_cache->lock);
-
-	return ret;
-}
-
-int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
-				 struct ras_err_data *err_data, struct ras_query_context *qctx)
-{
-	struct mca_bank_set mca_set;
-	struct mca_bank_cache *mca_cache = &adev->mca.mca_caches[type];
-	int ret;
-
-	amdgpu_mca_bank_set_init(&mca_set);
-
-	ret = amdgpu_mca_smu_get_mca_set(adev, type, &mca_set, qctx);
-	if (ret)
-		goto out_mca_release;
-
-	ret = amdgpu_mca_dispatch_mca_set(adev, blk, type, &mca_set, err_data);
-	if (ret)
-		goto out_mca_release;
-
-	/* add remain mca bank to mca cache */
-	if (mca_set.nr_entries) {
-		ret = amdgpu_mca_add_mca_set_to_cache(adev, type, &mca_set);
-		if (ret)
-			goto out_mca_release;
-	}
-
-	/* dispatch mca set again if mca cache has valid data */
-	mutex_lock(&mca_cache->lock);
-	if (mca_cache->mca_set.nr_entries)
-		ret = amdgpu_mca_dispatch_mca_set(adev, blk, type, &mca_cache->mca_set, err_data);
-	mutex_unlock(&mca_cache->lock);
-
-out_mca_release:
-	amdgpu_mca_bank_set_release(&mca_set);
-
-	return ret;
-}
-
-#if defined(CONFIG_DEBUG_FS)
-static int amdgpu_mca_smu_debug_mode_set(void *data, u64 val)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)data;
-	int ret;
-
-	ret = amdgpu_ras_set_mca_debug_mode(adev, val ? true : false);
-	if (ret)
-		return ret;
-
-	dev_info(adev->dev, "amdgpu set smu mca debug mode %s success\n", val ? "on" : "off");
-
-	return 0;
-}
-
-static void mca_dump_entry(struct seq_file *m, struct mca_bank_entry *entry)
-{
-	int i, idx = entry->idx;
-	int reg_idx_array[] = {
-		MCA_REG_IDX_STATUS,
-		MCA_REG_IDX_ADDR,
-		MCA_REG_IDX_MISC0,
-		MCA_REG_IDX_IPID,
-		MCA_REG_IDX_SYND,
-	};
-
-	seq_printf(m, "mca entry[%d].type: %s\n", idx, entry->type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE");
-	seq_printf(m, "mca entry[%d].ip: %d\n", idx, entry->ip);
-	seq_printf(m, "mca entry[%d].info: socketid:%d aid:%d hwid:0x%03x mcatype:0x%04x\n",
-		   idx, entry->info.socket_id, entry->info.aid, entry->info.hwid, entry->info.mcatype);
-
-	for (i = 0; i < ARRAY_SIZE(reg_idx_array); i++)
-		seq_printf(m, "mca entry[%d].regs[%d]: 0x%016llx\n", idx, reg_idx_array[i], entry->regs[reg_idx_array[i]]);
-}
-
-static int mca_dump_show(struct seq_file *m, enum amdgpu_mca_error_type type)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
-	struct mca_bank_node *node;
-	struct mca_bank_set mca_set;
-	struct ras_query_context qctx;
-	int ret;
-
-	amdgpu_mca_bank_set_init(&mca_set);
-
-	qctx.evid.event_id = RAS_EVENT_INVALID_ID;
-	ret = amdgpu_mca_smu_get_mca_set(adev, type, &mca_set, &qctx);
-	if (ret)
-		goto err_free_mca_set;
-
-	seq_printf(m, "amdgpu smu %s valid mca count: %d\n",
-		   type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE", mca_set.nr_entries);
-
-	if (!mca_set.nr_entries)
-		goto err_free_mca_set;
-
-	list_for_each_entry(node, &mca_set.list, node)
-		mca_dump_entry(m, &node->entry);
-
-	/* add mca bank to mca bank cache */
-	ret = amdgpu_mca_add_mca_set_to_cache(adev, type, &mca_set);
-
-err_free_mca_set:
-	amdgpu_mca_bank_set_release(&mca_set);
-
-	return ret;
-}
-
-static int mca_dump_ce_show(struct seq_file *m, void *unused)
-{
-	return mca_dump_show(m, AMDGPU_MCA_ERROR_TYPE_CE);
-}
-
-static int mca_dump_ce_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mca_dump_ce_show, inode->i_private);
-}
-
-static const struct file_operations mca_ce_dump_debug_fops = {
-	.owner = THIS_MODULE,
-	.open = mca_dump_ce_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int mca_dump_ue_show(struct seq_file *m, void *unused)
-{
-	return mca_dump_show(m, AMDGPU_MCA_ERROR_TYPE_UE);
-}
-
-static int mca_dump_ue_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mca_dump_ue_show, inode->i_private);
-}
-
-static const struct file_operations mca_ue_dump_debug_fops = {
-	.owner = THIS_MODULE,
-	.open = mca_dump_ue_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-DEFINE_DEBUGFS_ATTRIBUTE(mca_debug_mode_fops, NULL, amdgpu_mca_smu_debug_mode_set, "%llu\n");
-#endif
-
-void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
-{
-#if defined(CONFIG_DEBUG_FS)
-	if (!root)
-		return;
-
-	debugfs_create_file("mca_debug_mode", 0200, root, adev, &mca_debug_mode_fops);
-	debugfs_create_file("mca_ue_dump", 0400, root, adev, &mca_ue_dump_debug_fops);
-	debugfs_create_file("mca_ce_dump", 0400, root, adev, &mca_ce_dump_debug_fops);
-#endif
-}
-
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index e80323ff90c1..6d12f8a516d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -23,45 +23,6 @@
 
 #include "amdgpu_ras.h"
 
-#define MCA_MAX_REGS_COUNT	(16)
-
-#define MCA_REG_FIELD(x, h, l)			(((x) & GENMASK_ULL(h, l)) >> l)
-#define MCA_REG__STATUS__VAL(x)			MCA_REG_FIELD(x, 63, 63)
-#define MCA_REG__STATUS__OVERFLOW(x)		MCA_REG_FIELD(x, 62, 62)
-#define MCA_REG__STATUS__UC(x)			MCA_REG_FIELD(x, 61, 61)
-#define MCA_REG__STATUS__EN(x)			MCA_REG_FIELD(x, 60, 60)
-#define MCA_REG__STATUS__MISCV(x)		MCA_REG_FIELD(x, 59, 59)
-#define MCA_REG__STATUS__ADDRV(x)		MCA_REG_FIELD(x, 58, 58)
-#define MCA_REG__STATUS__PCC(x)			MCA_REG_FIELD(x, 57, 57)
-#define MCA_REG__STATUS__ERRCOREIDVAL(x)	MCA_REG_FIELD(x, 56, 56)
-#define MCA_REG__STATUS__TCC(x)			MCA_REG_FIELD(x, 55, 55)
-#define MCA_REG__STATUS__SYNDV(x)		MCA_REG_FIELD(x, 53, 53)
-#define MCA_REG__STATUS__CECC(x)		MCA_REG_FIELD(x, 46, 46)
-#define MCA_REG__STATUS__UECC(x)		MCA_REG_FIELD(x, 45, 45)
-#define MCA_REG__STATUS__DEFERRED(x)		MCA_REG_FIELD(x, 44, 44)
-#define MCA_REG__STATUS__POISON(x)		MCA_REG_FIELD(x, 43, 43)
-#define MCA_REG__STATUS__SCRUB(x)		MCA_REG_FIELD(x, 40, 40)
-#define MCA_REG__STATUS__ERRCOREID(x)		MCA_REG_FIELD(x, 37, 32)
-#define MCA_REG__STATUS__ADDRLSB(x)		MCA_REG_FIELD(x, 29, 24)
-#define MCA_REG__STATUS__ERRORCODEEXT(x)	MCA_REG_FIELD(x, 21, 16)
-#define MCA_REG__STATUS__ERRORCODE(x)		MCA_REG_FIELD(x, 15, 0)
-
-#define MCA_REG__MISC0__ERRCNT(x)		MCA_REG_FIELD(x, 43, 32)
-
-#define MCA_REG__SYND__ERRORINFORMATION(x)	MCA_REG_FIELD(x, 17, 0)
-
-enum amdgpu_mca_ip {
-	AMDGPU_MCA_IP_UNKNOW = -1,
-	AMDGPU_MCA_IP_PSP = 0,
-	AMDGPU_MCA_IP_SDMA,
-	AMDGPU_MCA_IP_GC,
-	AMDGPU_MCA_IP_SMU,
-	AMDGPU_MCA_IP_MP5,
-	AMDGPU_MCA_IP_UMC,
-	AMDGPU_MCA_IP_PCS_XGMI,
-	AMDGPU_MCA_IP_COUNT,
-};
-
 enum amdgpu_mca_error_type {
 	AMDGPU_MCA_ERROR_TYPE_UE = 0,
 	AMDGPU_MCA_ERROR_TYPE_CE,
@@ -77,77 +38,20 @@ struct amdgpu_mca_ras {
 	struct amdgpu_mca_ras_block *ras;
 };
 
-struct mca_bank_set {
-	int nr_entries;
-	struct list_head list;
-};
-
-struct mca_bank_cache {
-	struct mca_bank_set mca_set;
-	struct mutex lock;
-};
-
 struct amdgpu_mca {
 	struct amdgpu_mca_ras mp0;
 	struct amdgpu_mca_ras mp1;
 	struct amdgpu_mca_ras mpio;
-	const struct amdgpu_mca_smu_funcs *mca_funcs;
-	struct mca_bank_cache mca_caches[AMDGPU_MCA_ERROR_TYPE_DE];
-	atomic_t ue_update_flag;
-};
-
-enum mca_reg_idx {
-	MCA_REG_IDX_STATUS		= 1,
-	MCA_REG_IDX_ADDR		= 2,
-	MCA_REG_IDX_MISC0		= 3,
-	MCA_REG_IDX_IPID		= 5,
-	MCA_REG_IDX_SYND		= 6,
-	MCA_REG_IDX_COUNT		= 16,
-};
-
-struct mca_bank_info {
-	int socket_id;
-	int aid;
-	int hwid;
-	int mcatype;
-};
-
-struct mca_bank_entry {
-	int idx;
-	enum amdgpu_mca_error_type type;
-	enum amdgpu_mca_ip ip;
-	struct mca_bank_info info;
-	uint64_t regs[MCA_MAX_REGS_COUNT];
-};
-
-struct mca_bank_node {
-	struct mca_bank_entry entry;
-	struct list_head node;
-};
-
-struct amdgpu_mca_smu_funcs {
-	int max_ue_count;
-	int max_ce_count;
-	int (*mca_set_debug_mode)(struct amdgpu_device *adev, bool enable);
-	int (*mca_parse_mca_error_count)(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
-					 struct mca_bank_entry *entry, uint32_t *count);
-	int (*mca_get_valid_mca_count)(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-				       uint32_t *count);
-	int (*mca_get_mca_entry)(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-				 int idx, struct mca_bank_entry *entry);
 };
 
 void amdgpu_mca_query_correctable_error_count(struct amdgpu_device *adev,
 					      uint64_t mc_status_addr,
 					      unsigned long *error_count);
-
 void amdgpu_mca_query_uncorrectable_error_count(struct amdgpu_device *adev,
 						uint64_t mc_status_addr,
 						unsigned long *error_count);
-
 void amdgpu_mca_reset_error_count(struct amdgpu_device *adev,
 				  uint64_t mc_status_addr);
-
 void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 				      uint64_t mc_status_addr,
 				      void *ras_error_status);
@@ -155,15 +59,4 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev);
 
-void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs);
-int amdgpu_mca_init(struct amdgpu_device *adev);
-void amdgpu_mca_fini(struct amdgpu_device *adev);
-int amdgpu_mca_reset(struct amdgpu_device *adev);
-int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable);
-int amdgpu_mca_smu_get_mca_set_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					   enum amdgpu_mca_error_type type, uint32_t *total);
-void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
-int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
-				 struct ras_err_data *err_data, struct ras_query_context *qctx);
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 05d65bf06c71..0e76aa46b453 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1392,7 +1392,7 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 
 	if (error_query_mode == AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY) {
 		return amdgpu_virt_req_ras_err_count(adev, blk, err_data);
-	} else if (error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
+	} else {
 		if (info->head.block == AMDGPU_RAS_BLOCK__UMC) {
 			amdgpu_ras_get_ecc_info(adev, err_data);
 		} else {
@@ -1413,10 +1413,6 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 					block_obj->hw_ops->query_ras_error_status(adev);
 			}
 		}
-	} else {
-		/* FIXME: add code to check return value later */
-		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_data, qctx);
-		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_data, qctx);
 	}
 
 	return 0;
@@ -1533,7 +1529,6 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
 	if (!block_obj || !block_obj->hw_ops) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
@@ -1541,16 +1536,14 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		return -EOPNOTSUPP;
 	}
 
-	if (!amdgpu_ras_is_supported(adev, block) ||
-	    !amdgpu_ras_get_mca_debug_mode(adev))
+	if (!amdgpu_ras_is_supported(adev, block))
 		return -EOPNOTSUPP;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EOPNOTSUPP;
 
 	/* skip ras error reset in gpu reset */
-	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
-	    mca_funcs && mca_funcs->mca_set_debug_mode)
+	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
 		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
@@ -4724,39 +4717,10 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	int ret = 0;
-
-	if (con) {
-		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
-		if (!ret)
-			con->is_mca_debug_mode = enable;
-	}
-
-	return ret;
-}
-
-bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-
-	if (!con)
-		return false;
-
-	if (mca_funcs && mca_funcs->mca_set_debug_mode)
-		return con->is_mca_debug_mode;
-	else
-		return true;
-}
-
 bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 				     unsigned int *error_query_mode)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
 	if (!con) {
 		*error_query_mode = AMDGPU_RAS_INVALID_ERROR_QUERY;
@@ -4765,9 +4729,6 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev)) {
 		*error_query_mode = AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY;
-	} else if (mca_funcs && mca_funcs->mca_set_debug_mode) {
-		*error_query_mode =
-			(con->is_mca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
 	} else {
 		*error_query_mode = AMDGPU_RAS_DIRECT_ERROR_QUERY;
 	}
-- 
2.34.1

