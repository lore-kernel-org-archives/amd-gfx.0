Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8714C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 02:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6E410E0C5;
	Fri,  2 Aug 2024 02:20:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I8rb1ROP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C96610E0C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 02:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wbt8yyayGo5EbVe5nGC1fv394oBKvxNQdm7/5NSC3gTyVt1GWvJSxD9/uwbbTRHg9yT9ftY5DjTAJ/lOqpCqKH7v7+oyJFasxGf3aGKAA8tTFYs5c1zx62hu3xCj5PP7goYrCWeuyZXh2bfrc0dDCvMjWRP1IsKhg4hzl8e0sPts4wu19pqR7HBRStvOfKi0KbKQFtoIaxh5eUf25I/C1jeAjtsU4P9MkZ8DZkqrwORCJ5vLvgy7jEvTQV7OViGapSdu094d0SGrjNYgssUbfdzXs4zTsqvhdGoqB+8VvdeYyozdUFnweYkpskTjYDQa9K6o/ziTs+gVjih/DA9qLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO1HMyonVu4sG5XFpJwi4E4t+D6tA1OuTXcywCaJlgw=;
 b=zFJVZ3mV9qPeLncmPsoSoW+zw3TiTyIlphck4nGIx9pAG767DgcXDObJNgfC3Qr6y9MDPx0BeJBQs9i/JYQhQmh7tkcAqePuKBk84aTOwXNasJBciygAk9mGuHjszgqsBonjKkgrcSu7iTxeVSecdUhlaPwMtZQsgX35VDYTXtmgGPumgjNrnjzcwFeza0Danj0RBfqF3qU/qLgIWQaptWZsD72Yuxl9XhaQW5DzIuXiQSZPpAucGxaVk5euXHPlQVAgxGchFQ6tV446vTe4MplYJoV21MVQRx+faa9qUsll3u8Bf/TNN1JwPsJSu8gojjIoptK0ghN5gNect4yG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO1HMyonVu4sG5XFpJwi4E4t+D6tA1OuTXcywCaJlgw=;
 b=I8rb1ROPxA7IWQDCTzxAEl81FHBIwCf4g8t7tAFpxdQupcxcqC2G3vi+KOQfDCobCS5fJXZkCrnUJX8/YnqD30bXKRbmf/o0oivFSW7i3z+S3/17qhjG6CEHo9KBQ4MBSENyv1hDTyiqwbMfvmrSjqFtCs7ppWA7GJRKtrLnyhg=
Received: from BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Fri, 2 Aug
 2024 02:20:32 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::94) by BY3PR04CA0020.outlook.office365.com
 (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 02:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 02:20:32 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 21:18:16 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdgpu: remove RAS unused paramter 'err_addr'
Date: Fri, 2 Aug 2024 10:18:05 +0800
Message-ID: <20240802021805.2093640-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9adce8-0530-4c56-add3-08dcb299afac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZUhUFvHpJh5fqaubRFXY0Ep3VXktrffY7F+3IVkifDC0MyF12xgy64IdAvZU?=
 =?us-ascii?Q?xnL4VrZouB47+96HrRaB037PUnA8I/Azxrh2bowNKv+Euur0ujHh2ytfWyiR?=
 =?us-ascii?Q?ZLcL3XnSet5ng4AQrdEjQi+zdfZ+tLgsCPJhMq1NwiaFRiwl3sTtzQDGo/l5?=
 =?us-ascii?Q?TNLwutxa+lPntOMWAwPr/TVK0qfbBRbRsaSiCUe0hm8aym37h6t0VgIMsYjr?=
 =?us-ascii?Q?4zbDZ3T9jiaoO4JrEKuIwqQeDjB3FjozlxIp2jLYUg22yvRBqTz3qPj1htuO?=
 =?us-ascii?Q?2/o4yyyzsHVKu9p7Z5a5f2r+gfHiUmJ7Hspf6Y4GgSNKc16ICkRv11RZVvNN?=
 =?us-ascii?Q?r7hozFrpZm+sYAF6csxIt/CJzyNsgpmJyWjMOW/wy2K6M65SMtBcQT9818ed?=
 =?us-ascii?Q?hokJeZ8wozcGio4wGqEvsg9MDLDDkL0KgslHbhC+p4kGNmdCMtYI0ynOXILH?=
 =?us-ascii?Q?BHqjVtrlKejy1C7EY7k0HxfEyEdA2sfsQnGJkyHqx5uH3JvCRjB/cVjUY+Gf?=
 =?us-ascii?Q?pjXsY9uMLk6nO/VUdMG3MdrqGXLtRByTfedZFHNc2xJtW2+susxvqTuSNxtg?=
 =?us-ascii?Q?+FCw7J65VAsPG5Y/r8rwQxyy5VVDZBbF0b4nt+IHo0gELoU12aW7CFa/4UPo?=
 =?us-ascii?Q?Rf35rpRtdm9mtApmw/DcLxQjzW1RL2sIa5dPzvyZX95+PUOVmFHBo/zECwu6?=
 =?us-ascii?Q?H62nPdZhwhioxHEnQKA4T9lRhuGGvTR1Uj6qNk35+5JIuInVf595oQQWOphZ?=
 =?us-ascii?Q?1HIyb7feCJ990vU1aEJQk17bobDxLKfC5s4tcHyvDeKchglxB7OYllyjwdPI?=
 =?us-ascii?Q?QSyJlZmqlVV+0ykPGvZPTLptyHlw1c7IWuK/dEXMH/46OzWJwMJrbn/UiqLI?=
 =?us-ascii?Q?LzXlSuxqiHijVGS9Ll8gTM0qhR6AIM/+mhu6CHbJYso98zSPiFy2tegHSWgc?=
 =?us-ascii?Q?YzQtHsvX5mB88WPqdhNtlnTs/TVArXOwAmQDq7l8dVlfrm//xe1DQYJEFitW?=
 =?us-ascii?Q?cdzk4HrhezRwpMSxhbADGOY78atJIcxYSVe0j4xXphnqsOlp8GB1OCGdoodw?=
 =?us-ascii?Q?1i/MsJmEm8CV9sSWShJMUFXDdhmK4IPn6NWEINy0EgM/e5tdi3lWzABSssC3?=
 =?us-ascii?Q?ahpm6kvx1RkfA7oTjKePDEtxn9EBceflR0lI4ckHbRIb8y0pK73U31XunHfv?=
 =?us-ascii?Q?2bJiCSumCZy4Ym6+g1qxN+cMDjyxV15p2rJ9q0jbGh3G9Y2/dAQqKx+uecsr?=
 =?us-ascii?Q?NKaSyMaeHBMlV20TWzTKaWF0y09/w0tzRXam8Jd3EaQADV415o3/ewFAidBe?=
 =?us-ascii?Q?t5pKdSAO7t9UaTGaJYwLFGP1YEsyz7XGsrOTWFBqhs1fERKqyz4/1viJmAr9?=
 =?us-ascii?Q?wNagROdvHPdSj6KCDsirOGpVDc3VLVt/IXAG+NAdA2XegEXRJMMkELLV9cjv?=
 =?us-ascii?Q?ud0Eeu5EdU2cfk/eU+IMHsq5NY7pI9fc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 02:20:32.4493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9adce8-0530-4c56-add3-08dcb299afac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
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

- amdgpu_ras_error_statistic_ue_count()
- amdgpu_ras_error_statistic_ce_count()
- amdgpu_ras_error_statistic_de_count()

The parameter 'err_addr' is no longer used since following patch.
Fixes: efc4009da0dc ("drm/amdgpu: Remove unused code")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c  | 14 +++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 18 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c   |  6 +++---
 9 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 19158cc30f31..929095a2e088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -453,13 +453,13 @@ static int aca_log_aca_error_data(struct aca_bank_error *bank_error, enum aca_er
 
 	switch (type) {
 	case ACA_ERROR_TYPE_UE:
-		amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, count);
+		amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, count);
 		break;
 	case ACA_ERROR_TYPE_CE:
-		amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, count);
+		amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, count);
 		break;
 	case ACA_ERROR_TYPE_DEFERRED:
-		amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, NULL, count);
+		amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, count);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 2542bd7aa7c7..18ee60378727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -396,7 +396,6 @@ static int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum
 static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
 				       struct mca_bank_set *mca_set, struct ras_err_data *err_data)
 {
-	struct ras_err_addr err_addr;
 	struct amdgpu_smuio_mcm_config_info mcm_info;
 	struct mca_bank_node *node, *tmp;
 	struct mca_bank_entry *entry;
@@ -421,27 +420,20 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_r
 			continue;
 
 		memset(&mcm_info, 0, sizeof(mcm_info));
-		memset(&err_addr, 0, sizeof(err_addr));
 
 		mcm_info.socket_id = entry->info.socket_id;
 		mcm_info.die_id = entry->info.aid;
 
-		if (blk == AMDGPU_RAS_BLOCK__UMC) {
-			err_addr.err_status = entry->regs[MCA_REG_IDX_STATUS];
-			err_addr.err_ipid = entry->regs[MCA_REG_IDX_IPID];
-			err_addr.err_addr = entry->regs[MCA_REG_IDX_ADDR];
-		}
-
 		if (type == AMDGPU_MCA_ERROR_TYPE_UE) {
 			amdgpu_ras_error_statistic_ue_count(err_data,
-							    &mcm_info, &err_addr, (uint64_t)count);
+							    &mcm_info, (uint64_t)count);
 		} else {
 			if (amdgpu_mca_is_deferred_error(adev, entry->regs[MCA_REG_IDX_STATUS]))
 				amdgpu_ras_error_statistic_de_count(err_data,
-								    &mcm_info, &err_addr, (uint64_t)count);
+								    &mcm_info, (uint64_t)count);
 			else
 				amdgpu_ras_error_statistic_ce_count(err_data,
-								    &mcm_info, &err_addr, (uint64_t)count);
+								    &mcm_info, (uint64_t)count);
 		}
 
 		amdgpu_mca_bank_set_remove_node(mca_set, node);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0fb2d9285834..d9546a756542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1223,11 +1223,11 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 		for_each_ras_error(err_node, err_data) {
 			err_info = &err_node->err_info;
 			amdgpu_ras_error_statistic_de_count(&obj->err_data,
-					&err_info->mcm_info, NULL, err_info->de_count);
+					&err_info->mcm_info, err_info->de_count);
 			amdgpu_ras_error_statistic_ce_count(&obj->err_data,
-					&err_info->mcm_info, NULL, err_info->ce_count);
+					&err_info->mcm_info, err_info->ce_count);
 			amdgpu_ras_error_statistic_ue_count(&obj->err_data,
-					&err_info->mcm_info, NULL, err_info->ue_count);
+					&err_info->mcm_info, err_info->ue_count);
 		}
 	} else {
 		/* for legacy asic path which doesn't has error source info */
@@ -4618,8 +4618,8 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_d
 }
 
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
-		struct amdgpu_smuio_mcm_config_info *mcm_info,
-		struct ras_err_addr *err_addr, u64 count)
+					struct amdgpu_smuio_mcm_config_info *mcm_info,
+					u64 count)
 {
 	struct ras_err_info *err_info;
 
@@ -4640,8 +4640,8 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 }
 
 int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
-		struct amdgpu_smuio_mcm_config_info *mcm_info,
-		struct ras_err_addr *err_addr, u64 count)
+					struct amdgpu_smuio_mcm_config_info *mcm_info,
+					u64 count)
 {
 	struct ras_err_info *err_info;
 
@@ -4662,8 +4662,8 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 }
 
 int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
-		struct amdgpu_smuio_mcm_config_info *mcm_info,
-		struct ras_err_addr *err_addr, u64 count)
+					struct amdgpu_smuio_mcm_config_info *mcm_info,
+					u64 count)
 {
 	struct ras_err_info *err_info;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7ddd13d5c06b..ad75359dfda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -937,14 +937,14 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_device *adev,
 int amdgpu_ras_error_data_init(struct ras_err_data *err_data);
 void amdgpu_ras_error_data_fini(struct ras_err_data *err_data);
 int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
-		struct amdgpu_smuio_mcm_config_info *mcm_info,
-		struct ras_err_addr *err_addr, u64 count);
+					struct amdgpu_smuio_mcm_config_info *mcm_info,
+					u64 count);
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
-		struct amdgpu_smuio_mcm_config_info *mcm_info,
-		struct ras_err_addr *err_addr, u64 count);
+					struct amdgpu_smuio_mcm_config_info *mcm_info,
+					u64 count);
 int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
-		struct amdgpu_smuio_mcm_config_info *mcm_info,
-		struct ras_err_addr *err_addr, u64 count);
+					struct amdgpu_smuio_mcm_config_info *mcm_info,
+					u64 count);
 void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_instances);
 int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 			       const struct aca_info *aca_info, void *data);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 821ba2309dec..7de449fae1e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1389,10 +1389,10 @@ static void __xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, struct a
 
 	switch (xgmi_v6_4_0_pcs_mca_get_error_type(adev, status)) {
 	case ACA_ERROR_TYPE_UE:
-		amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, NULL, 1ULL);
+		amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, 1ULL);
 		break;
 	case ACA_ERROR_TYPE_CE:
-		amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, NULL, 1ULL);
+		amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, 1ULL);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 98fe6c40da64..673926d3c6d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4075,8 +4075,8 @@ static void gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
 	/* the caller should make sure initialize value of
 	 * err_data->ue_count and err_data->ce_count
 	 */
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_count);
-	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_count);
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
 }
 
 static void gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 621761a17ac7..915203b91c5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -670,8 +670,8 @@ static void mmhub_v1_8_inst_query_ras_error_count(struct amdgpu_device *adev,
 					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 					&ue_count);
 
-	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_count);
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_count);
+	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
 }
 
 static void mmhub_v1_8_query_ras_error_count(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9d4091175d29..57f16c09abfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2243,7 +2243,7 @@ static void sdma_v4_4_2_inst_query_ras_error_count(struct amdgpu_device *adev,
 					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 					&ue_count);
 
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_count);
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
 }
 
 static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0e6c3ce3ea8f..1a8ea834efa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -157,9 +157,9 @@ static int umc_v12_0_query_error_count(struct amdgpu_device *adev,
 	umc_v12_0_query_error_count_per_type(adev, umc_reg_offset,
 					    &de_count, umc_v12_0_is_deferred_error);
 
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_count);
-	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_count);
-	amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, NULL, de_count);
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
+	amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, de_count);
 
 	return 0;
 }
-- 
2.34.1

