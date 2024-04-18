Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C82FC001CC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02747113947;
	Thu, 18 Apr 2024 03:02:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X4TgAVXP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B123D113947
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqixXNymrvyu9hFJiMT5BnwzCYLQeTQ3sitNnTtuTGCd9DGYwmMDCIgSBq3RdmwCDKSXrrkyg7IsL7Y224+/3mqo9E8OrzICXQY1/BRw0Rf949kCfHCRThQ8YO9ELBqHwZUpMSlrl8GPFkHBHT6AcrkjP2Y89YfRj5q6NPgVxs6DVWdiFE/hldr4jmX2M/mQ6ud/L7hMChiJ4EoeDWV4865tZ+XnWwMp3gK63pHH4G5VhNNcBD1ZDdVJOXwg389IJaFks7n0P0rSiii2mk9p6ttQN9QIwIdTXf3T2LB5VXbgtwoHx+4+AfYxpazcZI+6mrds44PO6VrJL8f6ZFIi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI6EOmTxIKe/8ncTdLsaoIkEYy/BHWUj31c5E1UsBJk=;
 b=HtGkZ7OOpEhHm6hLxBBluHcNgrPOYaRJPa+ZLO5N3L0rgL7fmgm7ZA43qnibHQ4kdzFpgIt0vkwwHtWWG7f4pvHybujW/QTQtFzZb+yU24IA8A45WhCWGTZiESEtpFGdl32d6TBZbhRPE87UPOeQUloUS0WXWnHz0WWbjGM6LfwoLsuNaWVa6kRy6iAkFh0FB4aZ+y2KrRHsWk5sV2SiC5kviUd6Tlq2lp1gpmfCZBnWgCfooehzS6zSTXiz7RkcIQlea+qP5s6fJ7nWsic4Qs7PSPCI0dDZ4JpGpt/IGwoYJ7tCRGyQAap9uarajO92O293wdDuEWEGMl8TKSfWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI6EOmTxIKe/8ncTdLsaoIkEYy/BHWUj31c5E1UsBJk=;
 b=X4TgAVXP/PnUCaKSeOPgp9TeIfWCxBJzZn8uYSWtPFGPVPht4l6Ajitf4lWr6SuHhGl54sdXEq49scl1kJy7jb30/nVbrW6bTJkvjQcVpf1nX3X9BXSkKd9w/lTY63+D/KE6ZnuVIWAPWEbrfC0qucKXgcT9Ux3KTnjjCOWHpWA=
Received: from MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 03:01:58 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::1) by MN2PR05CA0058.outlook.office365.com
 (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:58 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:54 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
Date: Thu, 18 Apr 2024 10:58:31 +0800
Message-ID: <20240418025836.170106-10-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 610d6192-cc1f-413e-b3bf-08dc5f53e96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvAELFxMa7PDPlGRYD/2wxLGg26aCHzhpIy7ZrQSDAdQoyzlQhZnSg7YDQ3vWTrt3l6nkb5wmbdYjZONIHeDCrTkUt17dDkrZyH1UIRVu8JvCCIBpaPBayY/jmQ8hwZhJGPIk1v9W0rBkFmUY79L12KbMB+60thJOAAZkGCO/lgEtR1wq/OPCuIbGxbFpX+8r8g2e4yTbQqVpvOSIyAewO4aoTDyyJLeLOZX2JgzuqKxibCmmYrmdbuXjt9lg5TSz+FufHEIZ7OojUKDVHATOiIOHzu5pDgcidR5nZRPvO5FwGf0bSV3b34vEih4z3JMJYZkzp9+YrM7P1P1Wwvf00IlnNTSZNH0RJpZOYBotQ2aCjBp9D2YSoas3Hp36aswFmrAOo6WGMxEprGeMoezXVtsaDpsACz4L4g4CgF1MklSuZ0HctLwUzz/t0N6c8pc0H45CwXpf4Rqiwk5SRGoUGtKj6X7Ug4sOt/SEhO8fdBXBzLReoVNrHhIpqaZyRaa00K4Iki3TuiIigkfEKKDUFdKOP4FbvxI0yUSH54FNCN0wfk45JfrW7qMKgdoh2Ok55c75c9gVhXoZX6ziBuZR2fCHb7t7xgxLxJlCazEY8MHjkrQQ88mQpoi882sIMGm1h/sSifUea9ki7pWRjVuEI9BclcEOfmvqJ3mgfBNOHmhBgFzC1Xh9X5A7a7Hq47q/1eLN42q5NjRNdqtSw5YNvAwJK46jT+kQhJslspV8oSfwZ6EcRYgCfXSh2PvgNvI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:58.0629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610d6192-cc1f-413e-b3bf-08dc5f53e96d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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

Retire bad pages for umc v12_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 57 +++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 6c2b61ef5b57..bd917eb6ea24 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -28,6 +28,8 @@
 #include "umc/umc_12_0_0_sh_mask.h"
 #include "mp/mp_13_0_6_sh_mask.h"
 
+#define MAX_ECC_NUM_PER_RETIREMENT  16
+
 static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *adev,
 					    uint32_t node_inst,
 					    uint32_t umc_inst,
@@ -633,6 +635,58 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
+				struct ras_ecc_err *ecc_err, void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	uint32_t i = 0;
+	int ret = 0;
+
+	if (!err_data || !ecc_err)
+		return -EINVAL;
+
+	for (i = 0; i < ecc_err->err_pages.count; i++) {
+		ret = amdgpu_umc_fill_error_record(err_data,
+				ecc_err->addr,
+				ecc_err->err_pages.pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
+				MCA_IPID_2_UMC_CH(ecc_err->ipid),
+				MCA_IPID_2_UMC_INST(ecc_err->ipid));
+		if (ret)
+			break;
+	}
+
+	err_data->de_count++;
+
+	return ret;
+}
+
+static void umc_v12_0_query_ras_ecc_err_addr(struct amdgpu_device *adev,
+					void *ras_error_status)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_ecc_err *entries[MAX_ECC_NUM_PER_RETIREMENT];
+	struct radix_tree_root *ecc_tree;
+	int new_detected, ret, i;
+
+	ecc_tree = &con->umc_ecc_log.de_page_tree;
+
+	mutex_lock(&con->umc_ecc_log.lock);
+	new_detected = radix_tree_gang_lookup_tag(ecc_tree, (void **)entries,
+			0, ARRAY_SIZE(entries), UMC_ECC_NEW_DETECTED_TAG);
+	for (i = 0; i < new_detected; i++) {
+		if (!entries[i])
+			continue;
+
+		ret = umc_v12_0_fill_error_record(adev, entries[i], ras_error_status);
+		if (ret) {
+			dev_err(adev->dev, "Fail to fill umc error record, ret:%d\n", ret);
+			break;
+		}
+		radix_tree_tag_clear(ecc_tree, entries[i]->hash_index, UMC_ECC_NEW_DETECTED_TAG);
+	}
+	mutex_unlock(&con->umc_ecc_log.lock);
+}
+
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
@@ -640,8 +694,7 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	},
 	.err_cnt_init = umc_v12_0_err_cnt_init,
 	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
-	.ecc_info_query_ras_error_count = umc_v12_0_ecc_info_query_ras_error_count,
-	.ecc_info_query_ras_error_address = umc_v12_0_ecc_info_query_ras_error_address,
+	.ecc_info_query_ras_error_address = umc_v12_0_query_ras_ecc_err_addr,
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.update_ecc_status = umc_v12_0_update_ecc_status,
 };
-- 
2.34.1

