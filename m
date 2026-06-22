Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530D3CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E394F10E48B;
	Mon, 22 Jun 2026 04:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BqY3H86d";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E48810E491
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcLihpIuoPJoH17iR1iPijULgeQb+PHJQENA+Jpq3IdBP9CnNFNULYn9p9lUd7DTQdNR+c1XkbFjXR1HwZDMge/fjr4u6H5Dd1Mj7awqopcShHu+AjDO6Hss8nDsVSSJsY+AkKsfCBQM87SrlyCgQgGn8d+tVsH1ICxiwD92hAxvn/dIEW3yr+6GKzz2jWwEHRY9JfptbXHCYRfVZan5eyJ5tns9pdbgwKP39uk/iLbvnRkzKuzDzU9+G7LDjwYuhIWcxjufNzKERE8IDuIenOOHJKbLSHY8909OyP3VYATlqNjsBRHqL1BGy53LSb0srL3BpNTItlX6Hl74w6uJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2xZDV9QdgQY+pbdlA24sqTRqxbA/GBauAVhULo06Xw=;
 b=LDUEw47iyIgoNGYCiMGx3nWxyXUOLnKuJxBdzc10P+DNwYa6jbAgF22CbrA2mTqnE3AfBaHi9Y2rrZxH+tv8YGUTv5I/bXMBkVgmbFG9Z0ddbdNs1SO6/mrFffQ2oRkt94+Dd4ABmn5GC0OjE3fqdOSgtFUShNzG+qb0TVjCJLhd1lIEJGkJHHJP27yFm7G+v4Ig8Zl07gg7rBZKIreFLU9z5/HX4Sp2XSq/b9xwAD0qjE/3LdmXVbT5nR11+YF7/G03Zg906u4SD/yxw4PVl+V25mzkIY2DwOaNPNdQXNSlGTCJcaBlqM5kkWzwVazb389FdzjuZAyXdXKMr7TF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2xZDV9QdgQY+pbdlA24sqTRqxbA/GBauAVhULo06Xw=;
 b=BqY3H86d+WvZBcGgqxkHp+eXGTZ82k3oOAzeDg4/6RWduUXotBW6jPJl07rImvQ3x/SK0RcDqgx9hn84BUpNTujF9nNEB2dTbcAIadbNMJF8/wgDmq01rdGqX9YcDoucCREwz9Bp3b41d/1umD1h9kxS7rTl+dCOZlGvFjIl770=
Received: from IA1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::9)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:43:27 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::9c) by IA1P220CA0003.outlook.office365.com
 (2603:10b6:208:461::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.15 via Frontend Transport; Mon,
 22 Jun 2026 04:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:27 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:24 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 46/48] drm/amdgpu: retire legacy deferred error separate
 logging
Date: Mon, 22 Jun 2026 12:40:35 +0800
Message-ID: <387362c3104b3f6566971080056a89a0f01e478f.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 692595e3-392e-4e58-6b13-08ded018cd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0IpFWRAIp8zL7mxwWzWRglKihf6vNnXYqNaNpkSabS8+YGtDFCSPY1FnRxM48uI9kQ6Oc2h7OJk66nXtCHPHEFAamfQojZWHtRqlvtVqjGwj5Z32C1yb7FsUE9r/aQ/PyiyVkBGmB4nGjugdcHe9Z3f3X58SOq8q4rrMwIwyW1HwjO9OxdwJD1+yES4hr6Zrs2bzelSKtZUlEWsf1L9qPwi8NtobB95aYjHpx5jsZ+iqX0dbm7iNMtWo+4hOjr2QvjU+jryAPUa/0WRmBdkmWyaHWaoX9kvrDOUkND6fsFW8nyW2gPWNR72mJkG1l9nJmwqvgxrYIImd2LHEz38V7sNgt+mgiyEM6+jBPE7i2278Tia2cmuUGdBx+752NwDMOoUepmWKSFSeTnmdCBDwUI/O/U4whfvX8OC9X28UiBTPH8pwuXJv/Ka5OiUenFwyT4JjmRYPY6QK4vu30LYITEHGfdvLhZBf5vsSxJcLeUYnBFOxy7Qo3GrMMYd3zqS+ncxu/Rx0lETUDF7H1pjf+Y3h3U8nz4bQjPoHi1yJCqJjSoKnzFlQyu93CmDGMwSkWxaeyVToUa8nL6sP/igspmR3Ip79UlTEKCBiR/8UsqZYmyO3iVz24Z8VJy2PGRZocqJZb0kvHC7eV4VaxwSZRpeS2jfYBXdQJJyi+tkHSDnVLZ3AsxoyO8pZScQYb1j761PzpFLDnX0E0I/ay9W4YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mkmaoq/hbrw4Ce0R43Cj5Pq82dLMilcv30du2vG6OKDENWytpjXe2QT6LiQrh9r6IEsYelcz9vp5XR5QxKEB7cWN2TVW9jZos1IyofzLZ66OQ4h7/jr9X3yKOmliHehwy5C7WUKWNiBO7C5bkW2WD2wHQahQlzxCk7dTTFtGFnlBE8Ki2GDsVvyEvkBRbCOF2m+h+HzAwiNL8ggcDkupOLOVPckBndE/9uhLpMMBr9PyQozwbNeQ65teH9XkPuVxrrSMlSj+zbz3X8o39u2NGuefdetTDd4K4FWhkWQzR/J+btoc3xfsNCRvpXnBDXS69Nwps63NBxGCkieSXHsVeNZOtbVfpkG42bYQ6z2B51OTeQYhnS6s80CvgyXMDlXjK+a4XUcT4DFvQIOEsF3WORrklWZTqzEWPorDYBTETTzd3KJpvVHT8Tcif0gbukjo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:27.3496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692595e3-392e-4e58-6b13-08ded018cd37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

Remove the legacy logic that logs deferred errors separately

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 122 +++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |   1 -
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  25 -----
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  |   3 -
 5 files changed, 23 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 90f746ee90f8..465f82c660f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1137,8 +1137,7 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 					      struct ras_err_data *err_data,
 					      struct ras_query_context *qctx,
 					      const char *blk_name,
-					      bool is_ue,
-					      bool is_de)
+					      bool is_ue)
 {
 	struct amdgpu_smuio_mcm_config_info *mcm_info;
 	struct ras_err_node *err_node;
@@ -1168,53 +1167,29 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 		}
 
 	} else {
-		if (is_de) {
-			for_each_ras_error(err_node, err_data) {
-				err_info = &err_node->err_info;
-				mcm_info = &err_info->mcm_info;
-				if (err_info->de_count) {
-					RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
-						      "%lld new deferred hardware errors detected in %s block\n",
-						      mcm_info->socket_id,
-						      mcm_info->die_id,
-						      err_info->de_count,
-						      blk_name);
-				}
-			}
+		if (adev->debug_disable_ce_logs)
+			return;
 
-			for_each_ras_error(err_node, &ras_mgr->err_data) {
-				err_info = &err_node->err_info;
-				mcm_info = &err_info->mcm_info;
+		for_each_ras_error(err_node, err_data) {
+			err_info = &err_node->err_info;
+			mcm_info = &err_info->mcm_info;
+			if (err_info->ce_count) {
 				RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
-					      "%lld deferred hardware errors detected in total in %s block\n",
-					      mcm_info->socket_id, mcm_info->die_id,
-					      err_info->de_count, blk_name);
-			}
-		} else {
-			if (adev->debug_disable_ce_logs)
-				return;
-
-			for_each_ras_error(err_node, err_data) {
-				err_info = &err_node->err_info;
-				mcm_info = &err_info->mcm_info;
-				if (err_info->ce_count) {
-					RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
-						      "%lld new correctable hardware errors detected in %s block\n",
-						      mcm_info->socket_id,
-						      mcm_info->die_id,
-						      err_info->ce_count,
-						      blk_name);
-				}
+					      "%lld new correctable hardware errors detected in %s block\n",
+					      mcm_info->socket_id,
+					      mcm_info->die_id,
+					      err_info->ce_count,
+					      blk_name);
 			}
+		}
 
-			for_each_ras_error(err_node, &ras_mgr->err_data) {
-				err_info = &err_node->err_info;
-				mcm_info = &err_info->mcm_info;
-				RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
-					      "%lld correctable hardware errors detected in total in %s block\n",
-					      mcm_info->socket_id, mcm_info->die_id,
-					      err_info->ce_count, blk_name);
-			}
+		for_each_ras_error(err_node, &ras_mgr->err_data) {
+			err_info = &err_node->err_info;
+			mcm_info = &err_info->mcm_info;
+			RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
+				      "%lld correctable hardware errors detected in total in %s block\n",
+				      mcm_info->socket_id, mcm_info->die_id,
+				      err_info->ce_count, blk_name);
 		}
 	}
 }
@@ -1235,8 +1210,7 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 
 	if (err_data->ce_count) {
 		if (err_data_has_source_info(err_data)) {
-			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, qctx,
-							  blk_name, false, false);
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, qctx, blk_name, false);
 		} else if (!adev->aid_mask &&
 			   adev->smuio.funcs &&
 			   adev->smuio.funcs->get_socket_id &&
@@ -1258,8 +1232,7 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 
 	if (err_data->ue_count) {
 		if (err_data_has_source_info(err_data)) {
-			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, qctx,
-							  blk_name, true, false);
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, qctx, blk_name, true);
 		} else if (!adev->aid_mask &&
 			   adev->smuio.funcs &&
 			   adev->smuio.funcs->get_socket_id &&
@@ -1278,29 +1251,6 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 				      blk_name);
 		}
 	}
-
-	if (err_data->de_count) {
-		if (err_data_has_source_info(err_data)) {
-			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, qctx,
-							  blk_name, false, true);
-		} else if (!adev->aid_mask &&
-			   adev->smuio.funcs &&
-			   adev->smuio.funcs->get_socket_id &&
-			   adev->smuio.funcs->get_die_id) {
-			RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d "
-				      "%ld deferred hardware errors "
-				      "detected in %s block\n",
-				      adev->smuio.funcs->get_socket_id(adev),
-				      adev->smuio.funcs->get_die_id(adev),
-				      ras_mgr->err_data.de_count,
-				      blk_name);
-		} else {
-			RAS_EVENT_LOG(adev, event_id, "%ld deferred hardware errors "
-				      "detected in %s block\n",
-				      ras_mgr->err_data.de_count,
-				      blk_name);
-		}
-	}
 }
 
 static void amdgpu_ras_virt_error_generate_report(struct amdgpu_device *adev,
@@ -1347,8 +1297,7 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 	if (err_data_has_source_info(err_data)) {
 		for_each_ras_error(err_node, err_data) {
 			err_info = &err_node->err_info;
-			amdgpu_ras_error_statistic_de_count(&obj->err_data,
-					&err_info->mcm_info, err_info->de_count);
+
 			amdgpu_ras_error_statistic_ce_count(&obj->err_data,
 					&err_info->mcm_info, err_info->ce_count);
 			amdgpu_ras_error_statistic_ue_count(&obj->err_data,
@@ -1358,7 +1307,6 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 		/* for legacy asic path which doesn't has error source info */
 		obj->err_data.ue_count += err_data->ue_count;
 		obj->err_data.ce_count += err_data->ce_count;
-		obj->err_data.de_count += err_data->de_count;
 	}
 }
 
@@ -1466,7 +1414,6 @@ static int amdgpu_ras_query_error_status_with_event(struct amdgpu_device *adev,
 
 	info->ue_count = obj->err_data.ue_count;
 	info->ce_count = obj->err_data.ce_count;
-	info->de_count = obj->err_data.de_count;
 
 out_fini_err_data:
 	amdgpu_ras_error_data_fini(&err_data);
@@ -2385,7 +2332,6 @@ static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
 		 */
 		obj->err_data.ue_count += err_data.ue_count;
 		obj->err_data.ce_count += err_data.ce_count;
-		obj->err_data.de_count += err_data.de_count;
 	}
 
 	amdgpu_ras_error_data_fini(&err_data);
@@ -4763,28 +4709,6 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 	return 0;
 }
 
-int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
-					struct amdgpu_smuio_mcm_config_info *mcm_info,
-					u64 count)
-{
-	struct ras_err_info *err_info;
-
-	if (!err_data || !mcm_info)
-		return -EINVAL;
-
-	if (!count)
-		return 0;
-
-	err_info = amdgpu_ras_error_get_info(err_data, mcm_info);
-	if (!err_info)
-		return -EINVAL;
-
-	err_info->de_count += count;
-	err_data->de_count += count;
-
-	return 0;
-}
-
 #define mmMP0_SMN_C2PMSG_92	0x1609C
 #define mmMP0_SMN_C2PMSG_126	0x160BE
 static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 5cd26535dae1..7ea02066948e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -950,9 +950,6 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 					struct amdgpu_smuio_mcm_config_info *mcm_info,
 					u64 count);
-int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
-					struct amdgpu_smuio_mcm_config_info *mcm_info,
-					u64 count);
 void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_instances);
 
 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 537813482781..3b1dce300ef5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -260,7 +260,6 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 			if (ret == AMDGPU_RAS_SUCCESS && obj) {
 				obj->err_data.ue_count += err_data.ue_count;
 				obj->err_data.ce_count += err_data.ce_count;
-				obj->err_data.de_count += err_data.de_count;
 			}
 
 			amdgpu_ras_error_data_fini(&err_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index d3eeaead7ca2..99d19de42525 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -28,30 +28,8 @@
 #include "umc/umc_12_0_0_sh_mask.h"
 #include "mp/mp_13_0_6_sh_mask.h"
 
-bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
-{
-	dev_dbg(adev->dev,
-		"MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%llu, PCC:%llu, UC:%llu, TCC:%llu\n",
-		mc_umc_status,
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val),
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Poison),
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred),
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC),
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC),
-		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC)
-	);
-
-	return (amdgpu_ras_is_poison_mode_supported(adev) &&
-		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
-		((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1) ||
-		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Poison) == 1)));
-}
-
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
-	if (umc_v12_0_is_deferred_error(adev, mc_umc_status))
-		return false;
-
 	return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
 		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
@@ -60,9 +38,6 @@ bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_um
 
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
-	if (umc_v12_0_is_deferred_error(adev, mc_umc_status))
-		return false;
-
 	return (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1 ||
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 &&
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 9d9e84d8d3bb..906dc7fa1008 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -66,12 +66,9 @@
 	(((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
 	 (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
 
-bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 
-typedef bool (*check_error_type_func)(struct amdgpu_device *adev, uint64_t mc_umc_status);
-
 extern struct amdgpu_umc_ras umc_v12_0_ras;
 
 #endif
-- 
2.34.1

