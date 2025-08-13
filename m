Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C8FCA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 10:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FB310E6ED;
	Wed, 13 Aug 2025 10:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vyquicwp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E66F10E6ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 10:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIGCE516k3iVqcyJmfyidFdPwpoZaEhHYq6CymxLdc2oWvaoTeuiR8MeKnlV/JEYLV2QmBrZCgtLayqfGN5wSxRNVSa0fpqANQKqmp8z2eVi0Of2BvD4KuU+KbCY1tzDaupXLE99doDZpVUjARNkfOQuaHPVVoJqSfJhOTTJnQEgzUl+NFzPlnbb5BZ+O5Ci4glGZUPgdoKXO0kT1OolYL9UDW5WfNKf/a95LZENQm5qYmc4l5iXbeRmQEQv2wwjiviyOI6nG8Ze6R9rSyzdSzyNrPLU9/XbwM784dGNgHrDI6G29kRLxsNtlGHTB0GNv5Cgs3+AL06EI8pQ2XAufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mth7G+qNVNwe+p8CIjsAblTmmAe+lD81jWWMCgo3suA=;
 b=m5qYZ/OHCWaMmJ1Q1ShkR+kTYrCjAsGG8oNoRIB3wJ+yDPTUC0x7oYOC2JGysn8Nim9JgobmFrvKCgRb9vC7KrP9K4cddTXV9mFv+i9TSTl39hlSmw2ezB2I5zlMSeCI4yVdMAdqCDUIi8VM+oAigeis3tB2zqjqcRyaPkGejdxsSIxjPQDHgqO8UiEjkQHffctS08gIDXKzla16tgrixbLn1jv4IzFHQ3uDSKitGRcd2XRuCkiI23FFgTMH8fTZmpNWYPreTfTxex1KPALU0PQpoy788TF/onBN0C8KXs+vt02D9KT+pQJQYC9vtg4Zncq3ikpETce+manMyEp/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mth7G+qNVNwe+p8CIjsAblTmmAe+lD81jWWMCgo3suA=;
 b=VyquicwpwMoAMkerZPDZgWMi/iFIt+qVkznQmFtSuQ0d+CWPkTB9/RgfosH7lZ8enAvpqFL+7fbgrunbtCLhMvmH1Fd87mxrfJnvWkkmsMJt1P2vTA7A0IgQ0HJAKAy2PbtV1GpBEG3ZCWvUmEgJAlNVEOasjOzf33MOg6doOLI=
Received: from BN9PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:fb::28)
 by BN3PR12MB9596.namprd12.prod.outlook.com (2603:10b6:408:2cb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 10:35:52 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::a1) by BN9PR03CA0053.outlook.office365.com
 (2603:10b6:408:fb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 10:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 10:35:52 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 05:35:49 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 3/3 v2] drm/amdgpu: Correct the loss of aca bank reg info
Date: Wed, 13 Aug 2025 18:35:40 +0800
Message-ID: <20250813103540.264516-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|BN3PR12MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 071efac6-88ae-4dae-c699-08ddda552d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vRBMCzx0HjH7n/EXTRREW5d7s8CKOGLwCU2GYO+uey3MhV6FKGW1LKNBVBZD?=
 =?us-ascii?Q?kDwhLTDvb+2PP0wIXXtSW3nbqwHYRUeGkFHBen4BFJuzyY8KCTF1wzIOiR6z?=
 =?us-ascii?Q?NExly7F71za0HRd69UEz1FeDe2agQho6UWTo1HRCYXHEwwHnbEuhLAGZwsXs?=
 =?us-ascii?Q?n6qM5scQWqb3xdK4J/On4breccgtKFr/RsWrMgIUeCmfi2r6YUi2vziYTgTd?=
 =?us-ascii?Q?VX2hNBr2O8NVoUh3/tPy0lTDVqYnDHDR0HCY9c92ZQI/wV/RYq6aQ5QLu0E7?=
 =?us-ascii?Q?FITCHchxHdQBe57OKIRGCD7X8iwYbjsYjmCSgArzUsvGAa8ZIOaWVQYMP7Sc?=
 =?us-ascii?Q?w9RwRl+cSJRnFfrFSxxdF8NDhDNL3U+nOp/qoeAeP4BEgmbTk9eaezu9xqAc?=
 =?us-ascii?Q?2gzWhNtF35YbGm+E/s7kkHbX+/j0IjBiJBGHlbpQ9rrPTMPPJDwgxiwmvBtw?=
 =?us-ascii?Q?++JGnKg3kQBBWOJ9NTbS8wQDTWbW/1YCl08AJUqcx+2XRItnwzi5NhxF8kXE?=
 =?us-ascii?Q?MOGRMcfJhsIEzMVK/o9XQJ+dixARKYaw7+Yui17EgN8OAmtFYeWxKExN1Gu3?=
 =?us-ascii?Q?J9HH35I3KlsdsEz+adLBBOI+zKnMS2XY/7u8NEevABNothzjMuztx2XxPAvI?=
 =?us-ascii?Q?pUh+pkHzdsCqGsBRCEXdMVc+TEX7J7XLm5BMbUAwYG0KUWH4EH3RgDo3NPUg?=
 =?us-ascii?Q?QuPkV5b++25hadaJ5/4XW7iAyQyZcpChRNWRo99LEKwEBM9KVFA82T2DxyfC?=
 =?us-ascii?Q?SVADiE6j5m72fP/4yD1bI/+4MAM6Ll2XVSDU5wXktJyAKVjSn3SMMD1v318P?=
 =?us-ascii?Q?xCpXRezW1DW6RNTshsPypaRlpm49nFuLO+AopJs9UO1kErJR/WeKc5QtGGLX?=
 =?us-ascii?Q?V0VQnnnmLg/fJ1ATvYMkk3mGQa9dx2CsVepS3fATV4f6nEGXSTqD/58prihR?=
 =?us-ascii?Q?+WRfvNUbrv7LxtQFyWPY22FDg3SmdQsvaxyjfPSnmc4cjcjgiwq/frT/2Qtq?=
 =?us-ascii?Q?9ZPcB860twbgu9X/Wmc1Xhl206Hg/TjLnN6qZACv91J+eXnvFaxV5hjPNHmR?=
 =?us-ascii?Q?38BGrPh09m2psRod3TFwxHIEpXNbCS104TEPklPCp8aXNk1jFcTG9LeedtdQ?=
 =?us-ascii?Q?0hBxKBMqEh+kPuJULf4133eO7iYpcR9mUk/PWETMaAE0Te+Uq4A+em0x4kzt?=
 =?us-ascii?Q?4Kl2pid+xxmBvP5JkafLlpQPBOzvr7YppcHqndeKUsatfx+4+ahaiGy74SFM?=
 =?us-ascii?Q?vmnfgtOhMgmVNUpQ4n5+XpmdgJf0Xo3rkP/Vsu4RcqwuxcmurYQCzV70xvcH?=
 =?us-ascii?Q?nqgGox5WszdujFh/w6q/Wxjwx5mDdGNGgeExV6AalCYg8Jd4y83O0Xsfbjvb?=
 =?us-ascii?Q?nfmGqA0OMJeIxjRNi44Xc2x4FHAnQx6Wyf3rM6zvrXnCCa5W7Grs1OCEPjxJ?=
 =?us-ascii?Q?4OFuWYwBUKvf6dNYTRMAaRpP0PD8nPty0yTA39oaRmG7xgKhCsiv1Eps0U2k?=
 =?us-ascii?Q?0HAWHmwZIVgEjKiSShskQYvsH1uIs/dpXtWR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 10:35:52.4088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 071efac6-88ae-4dae-c699-08ddda552d5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9596
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

By polling, poll ACA bank count to ensure that valid
ACA bank reg info can be obtained

v2: add corresponding delay before send msg to SMU to query mca bank info.
(Stanley)

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 44 +++++++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  7 +---
 4 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 92c2370831b3..2beaf30ccb96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -877,7 +877,7 @@ size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev)
 
 void amdgpu_aca_clear_bank_count(struct amdgpu_device *adev)
 {
-	atomic64_set(&aca->bank_count, 0);
+	atomic64_set(&adev->aca.bank_count, 0);
 }
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 185b9e538f98..23f583492bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3306,8 +3306,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
 	mutex_init(&ecc_log->lock);
 
 	INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-	ecc_log->de_queried_count = 0;
-	ecc_log->prev_de_queried_count = 0;
 }
 
 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
@@ -3326,8 +3324,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 	mutex_unlock(&ecc_log->lock);
 
 	mutex_destroy(&ecc_log->lock);
-	ecc_log->de_queried_count = 0;
-	ecc_log->prev_de_queried_count = 0;
 }
 #endif
 
@@ -3381,49 +3377,33 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 				uint32_t poison_creation_count)
 {
 	int ret = 0;
-	struct ras_ecc_log_info *ecc_log;
 	struct ras_query_if info;
-	uint32_t timeout = 0;
+	uint32_t timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	uint64_t de_queried_count;
-	uint32_t new_detect_count, total_detect_count;
-	uint32_t need_query_count = poison_creation_count;
 	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
+	uint64_t prev_de_queried_count = 0;
+	uint64_t bank_count = 0;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
 
-	ecc_log = &ras->umc_ecc_log;
-	total_detect_count = 0;
 	do {
 		ret = amdgpu_ras_query_error_status_with_event(adev, &info, type);
 		if (ret)
 			return ret;
 
-		de_queried_count = ecc_log->de_queried_count;
-		if (de_queried_count > ecc_log->prev_de_queried_count) {
-			new_detect_count = de_queried_count - ecc_log->prev_de_queried_count;
-			ecc_log->prev_de_queried_count = de_queried_count;
-			timeout = 0;
+		bank_count = amdgpu_aca_get_bank_count(adev);
+		if (bank_count) {
+			prev_de_queried_count = bank_count;
+			amdgpu_aca_clear_bank_count(adev);
+			timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
 		} else {
-			new_detect_count = 0;
-		}
-
-		if (new_detect_count) {
-			total_detect_count += new_detect_count;
-		} else {
-			if (!timeout && need_query_count)
-				timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
-
-			if (timeout) {
-				if (!--timeout)
-					break;
-				msleep(1);
-			}
+			--timeout;
+			msleep(1);
 		}
-	} while (total_detect_count < need_query_count);
+	} while (timeout);
 
-	if (total_detect_count)
+	if (prev_de_queried_count)
 		schedule_delayed_work(&ras->page_retirement_dwork, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7f10a7402160..df93791eb645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,6 @@ struct ras_ecc_err {
 struct ras_ecc_log_info {
 	struct mutex lock;
 	struct radix_tree_root de_page_tree;
-	uint64_t	de_queried_count;
-	uint64_t	prev_de_queried_count;
 };
 
 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index e590cbdd8de9..b3bdcf70df2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -581,17 +581,12 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 
 	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
 	if (ret) {
-		if (ret == -EEXIST)
-			con->umc_ecc_log.de_queried_count++;
-		else
+		if (ret != -EEXIST)
 			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
-
 		kfree(ecc_err);
 		return ret;
 	}
 
-	con->umc_ecc_log.de_queried_count++;
-
 	memset(page_pfn, 0, sizeof(page_pfn));
 	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				pa_addr,
-- 
2.34.1

