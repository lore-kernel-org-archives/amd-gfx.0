Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD816C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0A510E256;
	Wed,  3 Jan 2024 08:04:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1A110E256
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAkD19f9TtDz8czQnXtdjXIjIFevZjYvQsnF/cfEYLV46oJ9MZF1xzmTKLhe3qnq416vrw1PigGbp13lYKcQLa3K/xck9299aVlIascIiFlOcCdgMrzKCrRiqkb7EYHbIOp0y74eRKYiKd8VIrKBWGiMIt7t/yP8O6KfaA2/xBnG3683CLLyPnuHIJUvthYhH01qV8OE2tj53hzCbrOp8i98pLs1X2GHLS82D3SuGaHqwrWvp94eu2Zkq0ZxmCTUN7UHE6tFrwab22rTYOtEdiL5/4up3tjFiHCKAoTEa7qcUz6O3IZepvKcNBiuT9iqL8MxIcogqDWxGSLns6UFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNCk+/XBzKAFeYWo6IuxFm+XcxDISfreuvEArPxEFe4=;
 b=PVmFrxqZNf9wtm3HcFv9gRyVCgIBnb/F31qMnh1DjGp7M9RAksJk232Yi+YMFVJRVNKTt7DyioyZmYZsM++9/7qBggp/N78QCUS9A0GAxh1riHs0XHgh9ZQeIGTLkl3n5OZTtT36V0hAtBsKfcGEfMsEc9e42bC/lZF9xVfZGFVvjFPbZxYt29EAoF0sqEHw/qLq8g8YKsVWmiRBELQY/BCYzmt7PWbCzFYPupfpCDQeBkk0OolFakb9Lw/haLpVMY+/8DAb+b2XZVjwMu4dZyr/tXz1taLbz+9WRrhGMhcVppEJGaDhY/xKU/MM3t0SbOXSLnHjLHMENWPkX/IYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNCk+/XBzKAFeYWo6IuxFm+XcxDISfreuvEArPxEFe4=;
 b=HPN0E3Zj1TTWHJTqoBaD0XMvDQ5UDesInVSyMrZwpz09xWgNsS2YKKIC6g2sSOuvWcxTWRZ6b+ekQdysR9nA01RNSTCIKtYmOT9YAWIJmM9I5XewVZp2YvYghoqwTguuBIxjR8CQQPCeT/ts2tT2ZdsJb44lMB+lSuf8Vy0GdZs=
Received: from SJ0PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:33f::14)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:04:07 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::2a) by SJ0PR05CA0039.outlook.office365.com
 (2603:10b6:a03:33f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Wed, 3 Jan 2024 08:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:04:07 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:04:05 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amdgpu: remove unused smu mca smu driver
Date: Wed, 3 Jan 2024 16:02:20 +0800
Message-ID: <20240103080220.2815115-15-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103080220.2815115-1-kevinyang.wang@amd.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 4694e264-c1e5-4fd1-0596-08dc0c328fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zj+5UX+E5zitbirYjtBGef8csjiU2gLQKdUxF6tlTWfNTOiwEXsDKQDKNkAtk+K0Z1zH/n+u0WUHUEOV4vQdb+poJCQLfs+5JYbpgkUo36kp+ECbGmaerpheCQPSvMGGD48lmRI7qPz5JiNxsfre2Uds677twiqywm2x4tMPUdpFfDMxIthHvGXV1gY+JrMiJLex6JX+HwmghtqJ8RnFWrjWAKBL/TRt8dknAHIsrgpfY/3IkDyKQxDlWuSFFPiQCfcpxWdYEnWP3fsBQudB/2N2PhPfoje8jafiv3hCI7KZoyBIhRA7JXXQmCB9ltW/PsM6p8t2/+88mpA3qYU4AbEg1Kasp/7gIMSsw91jtbLsPKpZNKx4OSzQYxojmwncIdx8CVb11lDd7ms2CPqNRZfPUVwSOywH92VpjNhKSvvszLVi/Gf+huDxrsu4zf/ety7hKmmYtTyOo/WFwnMWQe//+1UmNp4B0HdXDOA2klapXmPbFj6YL3EndtzPTHUOYmplkosODs2qnXEoNX2yknPlAiqukLmV5jNkysWhmNrhxXyblj2OfUUuKJM8JzFdp4FRunS/NBUjzrhVs87ydJ49o3yPqRQGkNCf3CfWYlcTz1FZ3FcpOlbxCBhBbaTVY9lme5yihU3Qdxrh55LfAwvNlsbFfDTAFBvKrJTcUk+3JK1yQVJms/hlOIclJIykJfdeV6s15zAmFpKAL/ujzi8el3XprhH9oWPfaz5tZZ+zhw50ww1K2XCINZN8gfvr0mcjwV+ixG00M8lMnu/oeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(36840700001)(46966006)(40470700004)(26005)(1076003)(426003)(2616005)(336012)(16526019)(36860700001)(81166007)(83380400001)(356005)(47076005)(82740400003)(70586007)(70206006)(316002)(6916009)(54906003)(36756003)(478600001)(86362001)(5660300002)(2906002)(4326008)(30864003)(8676002)(8936002)(40460700003)(40480700001)(7696005)(6666004)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:04:07.6176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4694e264-c1e5-4fd1-0596-08dc0c328fa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

remove unused mca driver code.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 360 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h | 114 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  14 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |   1 -
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |   5 +-
 5 files changed, 1 insertion(+), 493 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 8911310f98df..ed1c32c6d302 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -143,363 +143,3 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set)
-{
-	if (!mca_set)
-		return;
-
-	memset(mca_set, 0, sizeof(*mca_set));
-	INIT_LIST_HEAD(&mca_set->list);
-}
-
-int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_entry *entry)
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
-void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set)
-{
-	struct mca_bank_node *node, *tmp;
-
-	list_for_each_entry_safe(node, tmp, &mca_set->list, node) {
-		list_del(&node->node);
-		kvfree(node);
-	}
-}
-
-void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs)
-{
-	struct amdgpu_mca *mca = &adev->mca;
-
-	mca->mca_funcs = mca_funcs;
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
-static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, struct mca_bank_entry *entry)
-{
-	dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture events logged\n");
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].STATUS=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_STATUS]);
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].ADDR=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_ADDR]);
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].MISC0=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_MISC0]);
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].IPID=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_IPID]);
-	dev_info(adev->dev, "[Hardware error] aca entry[%02d].SYND=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_SYND]);
-}
-
-int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_data)
-{
-	struct amdgpu_smuio_mcm_config_info mcm_info;
-	struct ras_err_addr err_addr = {0};
-	struct mca_bank_set mca_set;
-	struct mca_bank_node *node;
-	struct mca_bank_entry *entry;
-	uint32_t count;
-	int ret, i = 0;
-
-	amdgpu_mca_bank_set_init(&mca_set);
-
-	ret = amdgpu_mca_smu_get_mca_set(adev, blk, type, &mca_set);
-	if (ret)
-		goto out_mca_release;
-
-	list_for_each_entry(node, &mca_set.list, node) {
-		entry = &node->entry;
-
-		amdgpu_mca_smu_mca_bank_dump(adev, i++, entry);
-
-		count = 0;
-		ret = amdgpu_mca_smu_parse_mca_error_count(adev, blk, type, entry, &count);
-		if (ret)
-			goto out_mca_release;
-
-		if (!count)
-			continue;
-
-		mcm_info.socket_id = entry->info.socket_id;
-		mcm_info.die_id = entry->info.aid;
-
-		if (blk == AMDGPU_RAS_BLOCK__UMC) {
-			err_addr.err_status = entry->regs[MCA_REG_IDX_STATUS];
-			err_addr.err_ipid = entry->regs[MCA_REG_IDX_IPID];
-			err_addr.err_addr = entry->regs[MCA_REG_IDX_ADDR];
-		}
-
-		if (type == AMDGPU_MCA_ERROR_TYPE_UE)
-			amdgpu_ras_error_statistic_ue_count(err_data,
-				&mcm_info, &err_addr, (uint64_t)count);
-		else
-			amdgpu_ras_error_statistic_ce_count(err_data,
-				&mcm_info, &err_addr, (uint64_t)count);
-	}
-
-out_mca_release:
-	amdgpu_mca_bank_set_release(&mca_set);
-
-	return ret;
-}
-
-
-int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
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
-int amdgpu_mca_smu_get_mca_set_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					    enum amdgpu_mca_error_type type, uint32_t *total)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	struct mca_bank_set mca_set;
-	struct mca_bank_node *node;
-	struct mca_bank_entry *entry;
-	uint32_t count;
-	int ret;
-
-	if (!total)
-		return -EINVAL;
-
-	if (!mca_funcs)
-		return -EOPNOTSUPP;
-
-	if (!mca_funcs->mca_get_ras_mca_set || !mca_funcs->mca_get_valid_mca_count)
-		return -EOPNOTSUPP;
-
-	amdgpu_mca_bank_set_init(&mca_set);
-
-	ret = mca_funcs->mca_get_ras_mca_set(adev, blk, type, &mca_set);
-	if (ret)
-		goto err_mca_set_release;
-
-	*total = 0;
-	list_for_each_entry(node, &mca_set.list, node) {
-		entry = &node->entry;
-
-		count = 0;
-		ret = mca_funcs->mca_parse_mca_error_count(adev, blk, type, entry, &count);
-		if (ret)
-			goto err_mca_set_release;
-
-		*total += count;
-	}
-
-err_mca_set_release:
-	amdgpu_mca_bank_set_release(&mca_set);
-
-	return ret;
-}
-
-int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					 enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	if (!count || !entry)
-		return -EINVAL;
-
-	if (!mca_funcs || !mca_funcs->mca_parse_mca_error_count)
-		return -EOPNOTSUPP;
-
-
-	return mca_funcs->mca_parse_mca_error_count(adev, blk, type, entry, count);
-}
-
-int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-			       enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-
-	if (!mca_set)
-		return -EINVAL;
-
-	if (!mca_funcs || !mca_funcs->mca_get_ras_mca_set)
-		return -EOPNOTSUPP;
-
-	WARN_ON(!list_empty(&mca_set->list));
-
-	return mca_funcs->mca_get_ras_mca_set(adev, blk, type, mca_set);
-}
-
-int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-				 int idx, struct mca_bank_entry *entry)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	int count;
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
-	if (mca_funcs && mca_funcs->mca_get_mca_entry)
-		return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
-
-	return -EOPNOTSUPP;
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
-	struct mca_bank_entry *entry;
-	uint32_t count = 0;
-	int i, ret;
-
-	ret = amdgpu_mca_smu_get_valid_mca_count(adev, type, &count);
-	if (ret)
-		return ret;
-
-	seq_printf(m, "amdgpu smu %s valid mca count: %d\n",
-		   type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE", count);
-
-	if (!count)
-		return 0;
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
-	for (i = 0; i < count; i++) {
-		memset(entry, 0, sizeof(*entry));
-
-		ret = amdgpu_mca_smu_get_mca_entry(adev, type, i, entry);
-		if (ret)
-			goto err_free_entry;
-
-		mca_dump_entry(m, entry);
-	}
-
-err_free_entry:
-	kfree(entry);
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
-	if (!root || amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6))
-		return;
-
-	debugfs_create_file("mca_debug_mode", 0200, root, adev, &mca_debug_mode_fops);
-	debugfs_create_file("mca_ue_dump", 0400, root, adev, &mca_ue_dump_debug_fops);
-	debugfs_create_file("mca_ce_dump", 0400, root, adev, &mca_ce_dump_debug_fops);
-#endif
-}
-
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index b399f1b62887..04d91c239a2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -23,50 +23,6 @@
 
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
-enum amdgpu_mca_error_type {
-	AMDGPU_MCA_ERROR_TYPE_UE = 0,
-	AMDGPU_MCA_ERROR_TYPE_CE,
-};
-
 struct amdgpu_mca_ras_block {
 	struct amdgpu_ras_block_object ras_block;
 };
@@ -80,55 +36,6 @@ struct amdgpu_mca {
 	struct amdgpu_mca_ras mp0;
 	struct amdgpu_mca_ras mp1;
 	struct amdgpu_mca_ras mpio;
-	const struct amdgpu_mca_smu_funcs *mca_funcs;
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
-struct mca_bank_set {
-	int nr_entries;
-	struct list_head list;
-};
-
-struct amdgpu_mca_smu_funcs {
-	int max_ue_count;
-	int max_ce_count;
-	int (*mca_set_debug_mode)(struct amdgpu_device *adev, bool enable);
-	int (*mca_get_ras_mca_set)(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
-				   struct mca_bank_set *mca_set);
-	int (*mca_parse_mca_error_count)(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
-					 struct mca_bank_entry *entry, uint32_t *count);
-	int (*mca_get_valid_mca_count)(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-				       uint32_t *count);
-	int (*mca_get_mca_entry)(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-				 int idx, struct mca_bank_entry *entry);
 };
 
 void amdgpu_mca_query_correctable_error_count(struct amdgpu_device *adev,
@@ -149,25 +56,4 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev);
 
-void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs);
-int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable);
-int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count);
-int amdgpu_mca_smu_get_mca_set_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					   enum amdgpu_mca_error_type type, uint32_t *total);
-int amdgpu_mca_smu_get_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-				   enum amdgpu_mca_error_type type, uint32_t *count);
-int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					 enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count);
-int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-			       enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set);
-int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-				 int idx, struct mca_bank_entry *entry);
-
-void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
-
-void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set);
-int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_entry *entry);
-void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set);
-int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_data);
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7a5ba67c9884..ee56bf873933 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3481,20 +3481,6 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
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
-			con->is_aca_debug_mode = enable;
-	}
-
-	return ret;
-}
-
 int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 5c7212b1255f..0947eb79b6d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -783,7 +783,6 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
-int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
 int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable);
 bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device *adev);
 bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index aa0ce6103dae..9a6127824df4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -374,10 +374,7 @@ static int umc_v12_0_err_cnt_init_per_channel(struct amdgpu_device *adev,
 static void umc_v12_0_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 					void *ras_error_status)
 {
-	amdgpu_mca_smu_log_ras_error(adev,
-		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status);
-	amdgpu_mca_smu_log_ras_error(adev,
-		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status);
+	/* TODO: need to implement it base on new ACA driver. */
 }
 
 static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
-- 
2.34.1

