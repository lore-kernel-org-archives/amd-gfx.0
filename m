Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4FACDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15EF10E575;
	Mon, 22 Jun 2026 08:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eyhuaUKD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC0B10E577
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpdUV5+eSV/rxFSg1f6zf+T9jkVDPJxyoGYO3Q3VDgI8Dhrr3pvfo3wiBnu8NhG09EZcpjg66NsrFu+OBwZFP8abNstwHRfuZn5zd0H3h3EhlwjGsm8i+I+wBJESehPj/M5KolTYkfaesHRjS6Xpkcys7ByL90vebePOw3+b1t2SOYJzt0N9ij6EpTII310qXsJSZ6aApNQWzLR3qkB2v4h+X5F4HXHs91fsZYFPDG0melkAHmXQotNRfosv6aOOac76PXpusvrWMiUJjaq369WJ39Ff+3CZOmLFzWJ0+/a0zFOjbBl5njg6TrfU5uX41m0Mei49BvURrfyN5PRs+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwq0Rlgaw/hiHkEm9PlrKIUn8HbZqmFPySc7ivaeuo4=;
 b=aF7kKhdTxFbu/RhXVhBnW50mzEnLblPjL4N8OPr8fvlcNZWJfOD2cQWLJ3AhiS+FWAJTX31ycUPGfHyNYvgK+1jgMbl9Vu8QjMNY8Gz3Vk8+gTUwFeVAocK0L1r1zwM2a3CvXPfec3DGnNiH7vRFr+aR6mbdaRUO3uvSSDeSwsQPyM8RsMqMHMs3SMuS1r2iBYgNTvySlfPS8ZqsmUBrGpdeb9Y/0n+ZjZe2kqxweGu67kn//hayyt8SJQotTFWmmbyaZ6SCfWmzhRR2OydbE9VYFjlUbav/lPBlIWY5v/lcGDsU4apGGGKDVUHOeqiPabe0/B8No5JbG7XJaPVenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwq0Rlgaw/hiHkEm9PlrKIUn8HbZqmFPySc7ivaeuo4=;
 b=eyhuaUKD7QWf6aNBb9D6Iee3iBlhSBC6B4Rrwow9dR935ydYMnsX90oFOPfGCw/oL/ZG1JQI/tKseYHk5fLKr9jOgUcUGYC+rv0kL8Hve/FivCCxAHRVKtX5s2GloYMlFlKZ5XHRadmtY8YE3e7QhPxVjg8uu61Cc7L1aBKeKo8=
Received: from PH8P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::27)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:46:10 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::79) by PH8P223CA0022.outlook.office365.com
 (2603:10b6:510:2db::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:10 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:08 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 31/48] drm/amdgpu: retire legacy PMFW bad page loading in
 page
Date: Mon, 22 Jun 2026 16:44:33 +0800
Message-ID: <aa0b1a11081813144f2e2eb0ff4043b7a7ce39f2.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 9250abc8-0ce3-445c-1748-08ded03ab57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: GDp8PUP/2AhkZoEB2pSwQBfiMfnr6yrUyBrtxYSE4BE9DRXX4FEluKb6YJH9HvRGtBsNVVsUoKJoDLhKGSlAG3YxiDVbmMhTB9iSmPxBKBGiySSU+LFwRX7wXaPCn9gE9e7510hiW369rsZse0WRaQIyEYGVhz8c0n8Jh/V+wD4HxJJTobVpFPyXo99V+s60wyN7LYkcedlsQykLcx2/tdr5bNT6/dGGjvs2xhpQesfLJNCIYaGPUgwN4jH+VUWReKo2RfL86GECPK50i3I+12P1GVN1rcr/PUHT99AZt4stHYWPkb+vRvSD4wrqydMGVBeD/9X+3KhQJ7w67+jd/zICZnxW2haBktArElmPYa6Ps69+T5Dg3CwPsFugnlK1Is6prZ7TbKtScXzIlB02h50UQE97cyFg8xFhHJbDkbkt+znOM5b9PaYQIoOwKcKmDNCCmLVlkneK9A9cdop9KoNY7P9F1g6GnOSX64JM+D+GKDJCv4elwhxyuAOIZShK/MBNGrnhtYJVd6nHfbs8JX6BxCIU49ANiJ30W2jB3HNtEzTQ2yVC+wvQhP1jnwaEKI+h9JqWN6S+LGIwiGfxI5wdye2Svq6Cwso7wyiJmL0V+67lQzCcXd/ynmxtsUuw3/Q8vyc5FebhqaKXt5Nea3ALDdOXKewiX1JbN+DsYgrnHI9X2q7Xpiq5/zRj2MF9m0N3sna6w1GbPrIOL5lCXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BvWX4Cf2gLg+iZVqI1+/FopLPTGYYGZQPg+YBDOSdyooToRzm9LjznFbX3tjz5wPxfAlwXF6v2sr2ecNustP69+NRaDD8IglPjrEQ8RK9UHtjAVzmjt/f/PbtN9uU3sTJ4yX2xcwSCyVB18xAwJaSBWjRp0zo7y3xktpTFD7vDWQlL8vchB38ax51rVAEUwaoJE171d69G7genbx/al0mhGycQnzZffvD08zKbvY0Qaai0WEgwaxOJlYYc4n38Tx/GVJWotdwhCHp+AHSGB2am0sEwid7Tog6G4ULDWBJRPP0czCJKvFbYAu+8vqsXnTeMbW8dHbnIiH7fTcdxqs6p1Wd09IYj001CmMcppABdokr4ODlm81zymjVlSV4CrVSnnSia0c/vcaln5xYdUjEU8dmkzEt87RI/sDkk7SlmGTBpL1ElabK7ebiOWMTDp6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:10.3999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9250abc8-0ce3-445c-1748-08ded03ab57f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
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

Remove the legacy logic that loads RAS bad pages from PMFW during
page retirement

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 134 +++++++++++-------------
 2 files changed, 62 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 69fca6aacdc7..996152dadd86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3045,12 +3045,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		unit_num = control->ras_num_recs -
-			control->ras_num_recs_old;
-	else
-		unit_num = data->count / adev->umc.retire_unit -
-			control->ras_num_recs;
+	unit_num = data->count / adev->umc.retire_unit - control->ras_num_recs;
 
 	save_count = con->bad_page_num - control->ras_num_bad_pages;
 	mutex_unlock(&con->recovery_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index a99f1bae7a8f..eb8aff637eb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -97,7 +97,6 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct amdgpu_ras_eeprom_control *control = &con->eeprom_control;
 	unsigned int error_query_mode;
 	int ret = 0;
 	unsigned long err_count;
@@ -118,79 +117,68 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 		err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
 
 	mutex_lock(&con->page_retirement_lock);
-	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
-		ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
-		if (ret == -EOPNOTSUPP &&
-		    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
-			if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
-			    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
-				adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev,
-								ras_error_status);
-
-			if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
-			    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
-			    adev->umc.max_ras_err_cnt_per_query) {
-				kfree(err_data->err_addr);
-				err_data->err_addr =
-					kcalloc(adev->umc.max_ras_err_cnt_per_query,
-						sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-				/* still call query_ras_error_address to clear error status
-				 * even NOMEM error is encountered
-				 */
-				if (!err_data->err_addr)
-					dev_warn(adev->dev,
-						"Failed to alloc memory for umc error address record!\n");
-				else
-					err_data->err_addr_len =
-						adev->umc.max_ras_err_cnt_per_query;
-
-				/* umc query_ras_error_address is also responsible for clearing
-				 * error status
-				 */
-				adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev,
-								ras_error_status);
-			}
-		} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
-		    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
-			if (adev->umc.ras &&
-			    adev->umc.ras->ecc_info_query_ras_error_count)
-				adev->umc.ras->ecc_info_query_ras_error_count(adev,
-								ras_error_status);
-
-			if (adev->umc.ras &&
-			    adev->umc.ras->ecc_info_query_ras_error_address &&
-			    adev->umc.max_ras_err_cnt_per_query) {
-				kfree(err_data->err_addr);
-				err_data->err_addr =
-					kcalloc(adev->umc.max_ras_err_cnt_per_query,
-						sizeof(struct eeprom_table_record), GFP_KERNEL);
-
-				/* still call query_ras_error_address to clear error status
-				 * even NOMEM error is encountered
-				 */
-				if (!err_data->err_addr)
-					dev_warn(adev->dev,
-						"Failed to alloc memory for umc error address record!\n");
-				else
-					err_data->err_addr_len =
-						adev->umc.max_ras_err_cnt_per_query;
-
-				/* umc query_ras_error_address is also responsible for clearing
-				 * error status
-				 */
-				adev->umc.ras->ecc_info_query_ras_error_address(adev,
-								ras_error_status);
-			}
-		}
-	} else {
-		if (!amdgpu_ras_eeprom_update_record_num(control)) {
-			err_data->err_addr_cnt = err_data->de_count =
-				control->ras_num_recs -	control->ras_num_recs_old;
-			amdgpu_ras_eeprom_read_idx(control, err_data->err_addr,
-				control->ras_num_recs_old, err_data->de_count);
+	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
+	if (ret == -EOPNOTSUPP &&
+	    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
+		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
+			adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev,
+							ras_error_status);
+
+		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+		    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
+		    adev->umc.max_ras_err_cnt_per_query) {
+			err_data->err_addr =
+				kcalloc(adev->umc.max_ras_err_cnt_per_query,
+					sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+			/* still call query_ras_error_address to clear error status
+			 * even NOMEM error is encountered
+			 */
+			if (!err_data->err_addr)
+				dev_warn(adev->dev,
+					"Failed to alloc memory for umc error address record!\n");
+			else
+				err_data->err_addr_len =
+					adev->umc.max_ras_err_cnt_per_query;
+
+			/* umc query_ras_error_address is also responsible for clearing
+			 * error status
+			 */
+			adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev,
+							ras_error_status);
 		}
-	}
+	} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
+	    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
+		if (adev->umc.ras &&
+		    adev->umc.ras->ecc_info_query_ras_error_count)
+			adev->umc.ras->ecc_info_query_ras_error_count(adev,
+							ras_error_status);
+
+		if (adev->umc.ras &&
+		    adev->umc.ras->ecc_info_query_ras_error_address &&
+		    adev->umc.max_ras_err_cnt_per_query) {
+			err_data->err_addr =
+				kcalloc(adev->umc.max_ras_err_cnt_per_query,
+					sizeof(struct eeprom_table_record), GFP_KERNEL);
+
+			/* still call query_ras_error_address to clear error status
+			 * even NOMEM error is encountered
+			 */
+			if (!err_data->err_addr)
+				dev_warn(adev->dev,
+					"Failed to alloc memory for umc error address record!\n");
+			else
+				err_data->err_addr_len =
+					adev->umc.max_ras_err_cnt_per_query;
+
+			/* umc query_ras_error_address is also responsible for clearing
+			 * error status
+			 */
+			adev->umc.ras->ecc_info_query_ras_error_address(adev,
+							ras_error_status);
+ 		}
+ 	}
 
 	/* only uncorrectable error needs gpu reset */
 	if (err_data->ue_count || err_data->de_count) {
-- 
2.34.1

