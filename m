Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4FACDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6690710EAB6;
	Thu, 25 Jun 2026 08:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UvidEIba";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E5A10EAB6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qh/hjXuf8XniHwCfC7U5EWfQb0ZzzC83tpEkdfbxoreHRJ9MfGmgaz0Raq2X4DqP2KZftbcUpsO7rA0sXDRpav+LJz1r/MelE6uqB1Cxkka6lDuoM+h6kvaG2ezDPXmFkmWwiUhcyVqBVzB5ePjHq0xR0sS4hrDeM98VhI9/iZWFgURPINI432d3c+WmRRyoVns7QaO7uGH6CwayYydz2yjLx7P7ZeCeuHk/Gc270KXkfCW0O2+t20ZM+Es6E5ljEMMPDfOnv4TmRJrn/Qfqi+dONv+Dss2qOvttRo9sWSw3uS8qV7M8Ec9zrhGdh7HoOwT02jaagmMIWEWHEBDbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/m+65IigmhHyv9+cn2+AjtoLUzgOA15WvcAOT1YI98=;
 b=G/S665h2stiIiGEGm4EwyDnAnUkfAMdjum2dFPFy5G3OAMo9ZM7kcpcOoiuZGSJ83G0TLSt8A0ckK+7jCz8ZHicU6TUyCd/Nds+w4zG4CKT2zvarDmmK7DyCdxSYS58jEa4kizqSIbDkkhQeY14tQzkLokodxuof/dOS8bUlBjZR7g4oNvK9FC9fIN1GVh8aDElUSbbZSJ93XeiocNTCQFyZLQv9xWByJLKBrzzYUJRibzGhuI+/tS3bV6Q4DD/L5v4SByw3kDgfqOjeWYxYY7DI1Lql7wCg5sHmu1CeRFH1+0szxe48PpkEGakssmMRCzz+5GxVk5uIIUfG4VKIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/m+65IigmhHyv9+cn2+AjtoLUzgOA15WvcAOT1YI98=;
 b=UvidEIbadoWQ3FVYF5uZ/rrLe+AGkGYnQ9hjDPfqzam/m4gdEEK1jpbDkevyICKUBeL5IHoIJSg90PobajxMJkRpjaybrmqLxj6QO+yJCZUeViYkF59ezQAuKZJg3Cm3AQ5zp0EH+rGZyJGaKnGeRLfyge1/pmqhmeKP6BGfPrc=
Received: from CYXPR03CA0061.namprd03.prod.outlook.com (2603:10b6:930:d1::26)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:21:39 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::3c) by CYXPR03CA0061.outlook.office365.com
 (2603:10b6:930:d1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:39 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:37 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 44/44] drm/amdgpu: retire legacy deferred error separate
 logging
Date: Thu, 25 Jun 2026 16:19:37 +0800
Message-ID: <084da4f41fae88df1e5a0a703f9e7cffac9d2624.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 110ad57f-c4c2-477b-1ae0-08ded292c7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hIwduevvj8K8yEE0KoP4snuwYu31OxZM/b5Mnon3ZGs0Sr/78Fw4vQpVtmFw2gMrWTHCI10Vx++o3uyn3AfGg2dO8hw4FCJ4LBbIZIUhhKXa0ZRfiEZRXMsrdxRnY4Sk2+XwpN9gLLuVSGC8Jzica4SDpzpNmPq5dSouobPWxXRRnUo2CoZQ/xKPiLaTaNI+FLShZArfSyHr4LK5e/blHeGaTI8GgVFpExToDS1Lnn8Ks58sOCRIY6q6LO5OUyKfFfuzpyf450Ci7JjctoNLoJ2bP9LHRn/qR9o7MlUiCaNgtIVQXxrFdsEGheagn/9ttsQ3FDY1tdXvUW97OC/jWhXKbdZE5AKQYZegEoZM6DhIZKxeoORTR3aPeKly3PZo0AtGp6471jdbHGC25BZArtYwpqIL9BHgVpde0IS2i8qnJ7r4odpaI7pBUP4y2MC5T/9jBRxXw08Siw+R1xlP7hlsSSGXtC0ndVOZVrQKyG1rvboUpF3NSrGOFiximT6OUsviegMfnBoMjS9uWgJIPkisaRqtoSGXEudgwvd7CHQHhGEdTMt+LeQ53L9ZZvcv8JK6cLUBkhFjL9R64jm45SrFdsgmZtFxQLE5BUSHtB/RL2i1JVkDZf8oKItRWWFTypSgoTQ5EnAs1OIBb4kaBbBHxdnxmuA6xOdmilWmKrxfkj5cjdvNOCsD/m1qct2mNxu5izzlNnbcve1JvzL6fA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FOzNnepkroFkXo5oc6/Np3nKzZdLyQRr0jLMN98DOIgJ66Fa+qWvotgksbnoJAbi0twrBeTU1YbjKoVdDdYkYzmoRo1K54kjREpsnsDw6oK6kyZAS8UjwhTR6WpVoVrCWzlTmzhqXg+Gj4V5M7WkjjP/sa2PM7DfhYOsJYPQ90plSVPdBD//mPiN+/VwZYXwKCuxVZpISJtqNxZ6ge6l4R0n1p8ip+6Sxh6bzIqzPTfPuYea/XTaEBUFOiQiLd6xY+zzNtP93upjF9tC5azFrYQG1tjVBopCI49z9fVlpzzaNDfxBuNkn6aIArQtg1xJtj127v94rdmnrYp84xJwR6aQ6VsczXAwB3wfVv3xawaa1WBs7EiXvq1HKzrJ0hYyp1BxxHGDJpyvMXpRUEs8xXT32vzMdBc3kowt+Y75t9nYgxlWMwO/4sB7WNJ+Vfjy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:39.4618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 110ad57f-c4c2-477b-1ae0-08ded292c7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269
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
index 2fdfc1695a8c..dfabd6a15eb9 100644
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

