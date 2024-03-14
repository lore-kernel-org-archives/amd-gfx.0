Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31F7C54E5D
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 08:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D63010F215;
	Thu, 14 Mar 2024 08:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ufzHeBN9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBAC10F77E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 08:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtbT/GHaqwWRzD460zxbrfb5cWnIzGjtxzLl2/4KNzH8ZD7WJKZaGgyxqQoEf2BYPlQ0B4+vCp+Gz1eURmv4kxyeCLT4ETkshj1nE5ZWB0KWmOqotHHYkLbqnq1Fn/lb4ylEm4+jF/57K6yrdN+dzBT46RKEtApj5mOFZdYRjOCS4y+ogZtVjdcq4LJOA5klQOsuu1tfHxObfcDkvIEuJLmMBubMDqQep2IIESCqbnNSLnF7h/SiAMz0vNyPSrxAIE+T63src4DlmRSjuwXkWJy/rwe0ElCdICXzneezR0/GQkrCy3VnffPTqU3uVLTzguum+dHv2uBXKY+HmxgYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5gBZBkMb949RpXssd8iXj1torlYHjREbzHSJMvFup8=;
 b=VciasXM9veAs+9xo6GqQb/Z9nb6yamcCYNEDbAerA5zjpD5TthVSC0zxCAYhBJIfEZERrW8Ck2SeoK773y/gYQnSUub18da7bHrKb1JLM1jgRUJi6dPbKz4u/4PsZZA7YC7SGjF7p4u9ZHjJgNOZwj6abPAR1It454tS34bFSL3CT9/apDWrFYP9rsFVrpHKKzFvsMK7dzaI4+ZK/DaIruAJeyPJxrS/QxAgPZwXOU7nHDIOyMjhmPSYpUEMLCj7hKgB5fSGaY08LQJomBCy9xYFYGsFE4bS8ha0SQJfeU2WMiyhSE131YDl1QVoVaM+cONdjMuy+qO4/E/4J6wtjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5gBZBkMb949RpXssd8iXj1torlYHjREbzHSJMvFup8=;
 b=ufzHeBN9WwZdWG1B1i+4LLCnh1fVU5UbSJf9+IwczRSX/cw+hAGqm9jhL8YKUowvo/8tg9/Bj6G2qJzcjKqoczH8KWWoyD1Fc+vpc7OUb0Rq0kbyBfkpFtFGoQkLdHVzRMsuQk1+y2b+MrXhzjGrdSswgXTiR0YnxM2xLtD5S/I=
Received: from BN9PR03CA0352.namprd03.prod.outlook.com (2603:10b6:408:f6::27)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 08:12:42 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::4a) by BN9PR03CA0352.outlook.office365.com
 (2603:10b6:408:f6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 14 Mar 2024 08:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 08:12:41 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 03:12:40 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yang Wang <kevinyang.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add ras event id support
Date: Thu, 14 Mar 2024 16:12:28 +0800
Message-ID: <20240314081228.3538091-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: e274119c-90a0-45a6-a8ed-08dc43fe857a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3PQntrnYrb3F130lAjvnXY5884JmTF89MD1VTvZAlniSDSx3pXo6Zeb1IErA7S8Hfn811Ou/eMBiLDjDSRaWi6N0yM2u+lwAJnpC1COl476+PYQH+VQ0YNEr4HBJnq64IhUgjfSHSFq18FkgF9O0BVi5lDpFeDsOMxAW0ZHZh0fmp9h7Rb0e1PswWSl6CD4X1OrV9xiOSH08TlGnEcEtk4IJhVXpO/97KEIZFS1p+MBjs03Z6d0Q3+pNlqSWn/8ZtWH/5V//ZZV1zI0DinXNKg5uTjq7UlBwZEn1dqBrPV+ctOgY5Q9Hx+J1Css1kEIQJeowPrb0SXZO8LkRkZdD5gglFZCmfRi2X/wK0y4oEBHz7QpqRbJPI9DbVhU964TL5fmr94QlQVYTY6IURs+mQFHlsdJwkEQWf+V5J4zf6LYgCJyN3ghfWV3UYBZJLhx2L/bwnNulOGyh8I+/WSGc5TQXaoHxuS+9y7yY9+nSL6VvfCQdbAfuLyd+qfwJ3wcePtaRUMsmUiCdPAU5jPjIB5vJWohx0IAUfJLs4VnXz1XHN9w9tscean4Uk2nmsbJP7gSzI0aIZBpK5ZzdEjJftR0Dd8E9x6tv84pXT/baMtLrNdosVg5xDjiKRkarKDcGNk93rOLdG+VDliMsqFefstS/KMH9bTS0JvHOqeE7uvrqkwybnN9hFE91OtzMtwAngfQ9Mgb539OonLBlXQavNnFfJjyyibh5CdXwudg5sy0yaimWI/a7bB/AQP1n58v
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 08:12:41.9461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e274119c-90a0-45a6-a8ed-08dc43fe857a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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

add amdgpu ras event id support to better distinguish different
error information sources in dmesg logs.

the following log will be identify by event id:
{event_id} interrupt to inform RAS event
{event_id} ACA logs
{event_id} errors statistic since from current injection/error query
{event_id} errors statistic since from gpu load

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c  |  32 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 203 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  30 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |   1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c   |  10 +-
 6 files changed, 191 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 24ad4b97177b..0734490347db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -210,22 +210,26 @@ int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 	return -EOPNOTSUPP;
 }
 
-static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, struct mca_bank_entry *entry)
+static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, struct mca_bank_entry *entry,
+					 struct ras_query_context *qctx)
 {
-	dev_info(adev->dev, HW_ERR "Accelerator Check Architecture events logged\n");
-	dev_info(adev->dev, HW_ERR "aca entry[%02d].STATUS=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_STATUS]);
-	dev_info(adev->dev, HW_ERR "aca entry[%02d].ADDR=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_ADDR]);
-	dev_info(adev->dev, HW_ERR "aca entry[%02d].MISC0=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_MISC0]);
-	dev_info(adev->dev, HW_ERR "aca entry[%02d].IPID=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_IPID]);
-	dev_info(adev->dev, HW_ERR "aca entry[%02d].SYND=0x%016llx\n",
-		 idx, entry->regs[MCA_REG_IDX_SYND]);
+	u64 event_id = qctx->event_id;
+
+	RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architecture events logged\n");
+	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].STATUS=0x%016llx\n",
+		      idx, entry->regs[MCA_REG_IDX_STATUS]);
+	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].ADDR=0x%016llx\n",
+		      idx, entry->regs[MCA_REG_IDX_ADDR]);
+	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].MISC0=0x%016llx\n",
+		      idx, entry->regs[MCA_REG_IDX_MISC0]);
+	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].IPID=0x%016llx\n",
+		      idx, entry->regs[MCA_REG_IDX_IPID]);
+	RAS_EVENT_LOG(adev, event_id, HW_ERR "aca entry[%02d].SYND=0x%016llx\n",
+		      idx, entry->regs[MCA_REG_IDX_SYND]);
 }
 
-int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_data)
+int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
+				 struct ras_err_data *err_data, struct ras_query_context *qctx)
 {
 	struct amdgpu_smuio_mcm_config_info mcm_info;
 	struct ras_err_addr err_addr = {0};
@@ -244,7 +248,7 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 	list_for_each_entry(node, &mca_set.list, node) {
 		entry = &node->entry;
 
-		amdgpu_mca_smu_mca_bank_dump(adev, i++, entry);
+		amdgpu_mca_smu_mca_bank_dump(adev, i++, entry, qctx);
 
 		count = 0;
 		ret = amdgpu_mca_smu_parse_mca_error_count(adev, blk, type, entry, &count);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index b964110ed1e0..e5bf07ce3451 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -169,6 +169,7 @@ void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root
 void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set);
 int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_entry *entry);
 void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set);
-int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_data);
+int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
+				 struct ras_err_data *err_data, struct ras_query_context *qctx);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8ebab6f22e5a..ef87f107c942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1045,6 +1045,7 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
 static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 					      struct ras_manager *ras_mgr,
 					      struct ras_err_data *err_data,
+					      struct ras_query_context *qctx,
 					      const char *blk_name,
 					      bool is_ue,
 					      bool is_de)
@@ -1052,27 +1053,28 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 	struct amdgpu_smuio_mcm_config_info *mcm_info;
 	struct ras_err_node *err_node;
 	struct ras_err_info *err_info;
+	u64 event_id = qctx->event_id;
 
 	if (is_ue) {
 		for_each_ras_error(err_node, err_data) {
 			err_info = &err_node->err_info;
 			mcm_info = &err_info->mcm_info;
 			if (err_info->ue_count) {
-				dev_info(adev->dev, "socket: %d, die: %d, "
-					 "%lld new uncorrectable hardware errors detected in %s block\n",
-					 mcm_info->socket_id,
-					 mcm_info->die_id,
-					 err_info->ue_count,
-					 blk_name);
+				RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
+					      "%lld new uncorrectable hardware errors detected in %s block\n",
+					      mcm_info->socket_id,
+					      mcm_info->die_id,
+					      err_info->ue_count,
+					      blk_name);
 			}
 		}
 
 		for_each_ras_error(err_node, &ras_mgr->err_data) {
 			err_info = &err_node->err_info;
 			mcm_info = &err_info->mcm_info;
-			dev_info(adev->dev, "socket: %d, die: %d, "
-				 "%lld uncorrectable hardware errors detected in total in %s block\n",
-				 mcm_info->socket_id, mcm_info->die_id, err_info->ue_count, blk_name);
+			RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
+				      "%lld uncorrectable hardware errors detected in total in %s block\n",
+				      mcm_info->socket_id, mcm_info->die_id, err_info->ue_count, blk_name);
 		}
 
 	} else {
@@ -1081,44 +1083,44 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 				err_info = &err_node->err_info;
 				mcm_info = &err_info->mcm_info;
 				if (err_info->de_count) {
-					dev_info(adev->dev, "socket: %d, die: %d, "
-						"%lld new deferred hardware errors detected in %s block\n",
-						mcm_info->socket_id,
-						mcm_info->die_id,
-						err_info->de_count,
-						blk_name);
+					RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
+						      "%lld new deferred hardware errors detected in %s block\n",
+						      mcm_info->socket_id,
+						      mcm_info->die_id,
+						      err_info->de_count,
+						      blk_name);
 				}
 			}
 
 			for_each_ras_error(err_node, &ras_mgr->err_data) {
 				err_info = &err_node->err_info;
 				mcm_info = &err_info->mcm_info;
-				dev_info(adev->dev, "socket: %d, die: %d, "
-					"%lld deferred hardware errors detected in total in %s block\n",
-					mcm_info->socket_id, mcm_info->die_id,
-					err_info->de_count, blk_name);
+				RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
+					      "%lld deferred hardware errors detected in total in %s block\n",
+					      mcm_info->socket_id, mcm_info->die_id,
+					      err_info->de_count, blk_name);
 			}
 		} else {
 			for_each_ras_error(err_node, err_data) {
 				err_info = &err_node->err_info;
 				mcm_info = &err_info->mcm_info;
 				if (err_info->ce_count) {
-					dev_info(adev->dev, "socket: %d, die: %d, "
-						"%lld new correctable hardware errors detected in %s block\n",
-						mcm_info->socket_id,
-						mcm_info->die_id,
-						err_info->ce_count,
-						blk_name);
+					RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
+						      "%lld new correctable hardware errors detected in %s block\n",
+						      mcm_info->socket_id,
+						      mcm_info->die_id,
+						      err_info->ce_count,
+						      blk_name);
 				}
 			}
 
 			for_each_ras_error(err_node, &ras_mgr->err_data) {
 				err_info = &err_node->err_info;
 				mcm_info = &err_info->mcm_info;
-				dev_info(adev->dev, "socket: %d, die: %d, "
-					"%lld correctable hardware errors detected in total in %s block\n",
-					mcm_info->socket_id, mcm_info->die_id,
-					err_info->ce_count, blk_name);
+				RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d, "
+					      "%lld correctable hardware errors detected in total in %s block\n",
+					      mcm_info->socket_id, mcm_info->die_id,
+					      err_info->ce_count, blk_name);
 			}
 		}
 	}
@@ -1131,77 +1133,79 @@ static inline bool err_data_has_source_info(struct ras_err_data *data)
 
 static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 					     struct ras_query_if *query_if,
-					     struct ras_err_data *err_data)
+					     struct ras_err_data *err_data,
+					     struct ras_query_context *qctx)
 {
 	struct ras_manager *ras_mgr = amdgpu_ras_find_obj(adev, &query_if->head);
 	const char *blk_name = get_ras_block_str(&query_if->head);
+	u64 event_id = qctx->event_id;
 
 	if (err_data->ce_count) {
 		if (err_data_has_source_info(err_data)) {
-			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data,
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, qctx,
 							  blk_name, false, false);
 		} else if (!adev->aid_mask &&
 			   adev->smuio.funcs &&
 			   adev->smuio.funcs->get_socket_id &&
 			   adev->smuio.funcs->get_die_id) {
-			dev_info(adev->dev, "socket: %d, die: %d "
-				 "%ld correctable hardware errors "
-				 "detected in %s block\n",
-				 adev->smuio.funcs->get_socket_id(adev),
-				 adev->smuio.funcs->get_die_id(adev),
-				 ras_mgr->err_data.ce_count,
-				 blk_name);
+			RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d "
+				      "%ld correctable hardware errors "
+				      "detected in %s block\n",
+				      adev->smuio.funcs->get_socket_id(adev),
+				      adev->smuio.funcs->get_die_id(adev),
+				      ras_mgr->err_data.ce_count,
+				      blk_name);
 		} else {
-			dev_info(adev->dev, "%ld correctable hardware errors "
-				 "detected in %s block\n",
-				 ras_mgr->err_data.ce_count,
-				 blk_name);
+			RAS_EVENT_LOG(adev, event_id, "%ld correctable hardware errors "
+				      "detected in %s block\n",
+				      ras_mgr->err_data.ce_count,
+				      blk_name);
 		}
 	}
 
 	if (err_data->ue_count) {
 		if (err_data_has_source_info(err_data)) {
-			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data,
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, qctx,
 							  blk_name, true, false);
 		} else if (!adev->aid_mask &&
 			   adev->smuio.funcs &&
 			   adev->smuio.funcs->get_socket_id &&
 			   adev->smuio.funcs->get_die_id) {
-			dev_info(adev->dev, "socket: %d, die: %d "
-				 "%ld uncorrectable hardware errors "
-				 "detected in %s block\n",
-				 adev->smuio.funcs->get_socket_id(adev),
-				 adev->smuio.funcs->get_die_id(adev),
-				 ras_mgr->err_data.ue_count,
-				 blk_name);
+			RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d "
+				      "%ld uncorrectable hardware errors "
+				      "detected in %s block\n",
+				      adev->smuio.funcs->get_socket_id(adev),
+				      adev->smuio.funcs->get_die_id(adev),
+				      ras_mgr->err_data.ue_count,
+				      blk_name);
 		} else {
-			dev_info(adev->dev, "%ld uncorrectable hardware errors "
-				 "detected in %s block\n",
-				 ras_mgr->err_data.ue_count,
-				 blk_name);
+			RAS_EVENT_LOG(adev, event_id, "%ld uncorrectable hardware errors "
+				      "detected in %s block\n",
+				      ras_mgr->err_data.ue_count,
+				      blk_name);
 		}
 	}
 
 	if (err_data->de_count) {
 		if (err_data_has_source_info(err_data)) {
-			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data,
+			amdgpu_ras_error_print_error_data(adev, ras_mgr, err_data, qctx,
 							  blk_name, false, true);
 		} else if (!adev->aid_mask &&
 			   adev->smuio.funcs &&
 			   adev->smuio.funcs->get_socket_id &&
 			   adev->smuio.funcs->get_die_id) {
-			dev_info(adev->dev, "socket: %d, die: %d "
-				 "%ld deferred hardware errors "
-				 "detected in %s block\n",
-				 adev->smuio.funcs->get_socket_id(adev),
-				 adev->smuio.funcs->get_die_id(adev),
-				 ras_mgr->err_data.de_count,
-				 blk_name);
+			RAS_EVENT_LOG(adev, event_id, "socket: %d, die: %d "
+				      "%ld deferred hardware errors "
+				      "detected in %s block\n",
+				      adev->smuio.funcs->get_socket_id(adev),
+				      adev->smuio.funcs->get_die_id(adev),
+				      ras_mgr->err_data.de_count,
+				      blk_name);
 		} else {
-			dev_info(adev->dev, "%ld deferred hardware errors "
-				 "detected in %s block\n",
-				 ras_mgr->err_data.de_count,
-				 blk_name);
+			RAS_EVENT_LOG(adev, event_id, "%ld deferred hardware errors "
+				      "detected in %s block\n",
+				      ras_mgr->err_data.de_count,
+				      blk_name);
 		}
 	}
 }
@@ -1294,6 +1298,7 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *a
 static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 						struct ras_query_if *info,
 						struct ras_err_data *err_data,
+						struct ras_query_context *qctx,
 						unsigned int error_query_mode)
 {
 	enum amdgpu_ras_block blk = info ? info->head.block : AMDGPU_RAS_BLOCK_COUNT;
@@ -1338,8 +1343,8 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 				return ret;
 		} else {
 			/* FIXME: add code to check return value later */
-			amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_data);
-			amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_data);
+			amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_data, qctx);
+			amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_data, qctx);
 		}
 	}
 
@@ -1351,6 +1356,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_i
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data;
+	struct ras_query_context qctx;
 	unsigned int error_query_mode;
 	int ret;
 
@@ -1364,8 +1370,12 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_i
 	if (!amdgpu_ras_get_error_query_mode(adev, &error_query_mode))
 		return -EINVAL;
 
+	memset(&qctx, 0, sizeof(qctx));
+	qctx.event_id = amdgpu_ras_acquire_event_id(adev, amdgpu_ras_intr_triggered() ?
+						   RAS_EVENT_TYPE_ISR : RAS_EVENT_TYPE_INVALID);
 	ret = amdgpu_ras_query_error_status_helper(adev, info,
 						   &err_data,
+						   &qctx,
 						   error_query_mode);
 	if (ret)
 		goto out_fini_err_data;
@@ -1376,7 +1386,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_i
 	info->ce_count = obj->err_data.ce_count;
 	info->de_count = obj->err_data.de_count;
 
-	amdgpu_ras_error_generate_report(adev, info, &err_data);
+	amdgpu_ras_error_generate_report(adev, info, &err_data, &qctx);
 
 out_fini_err_data:
 	amdgpu_ras_error_data_fini(&err_data);
@@ -3036,6 +3046,31 @@ static int amdgpu_get_ras_schema(struct amdgpu_device *adev)
 			AMDGPU_RAS_ERROR__PARITY;
 }
 
+static void ras_event_mgr_init(struct ras_event_manager *mgr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mgr->seqnos); i++)
+		atomic64_set(&mgr->seqnos[i], 0);
+}
+
+static void amdgpu_ras_event_mgr_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
+	ras->event_mgr = hive ? &hive->event_mgr : &ras->__event_mgr;
+
+	/* init event manager with node 0 on xgmi system */
+	if (!amdgpu_in_reset(adev)) {
+		if (!hive || adev->gmc.xgmi.node_id == 0)
+			ras_event_mgr_init(ras->event_mgr);
+	}
+
+	if (hive)
+		amdgpu_put_xgmi_hive(hive);
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -3356,6 +3391,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	amdgpu_ras_event_mgr_init(adev);
+
 	if (amdgpu_aca_is_enabled(adev)) {
 		if (amdgpu_in_reset(adev))
 			r = amdgpu_aca_reset(adev);
@@ -3472,13 +3509,37 @@ void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status)
 		atomic_set(&ras->fed, !!status);
 }
 
+bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id)
+{
+	return !(id & BIT_ULL(63));
+}
+
+u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type type)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	u64 id;
+
+	switch (type) {
+	case RAS_EVENT_TYPE_ISR:
+		id = (u64)atomic64_read(&ras->event_mgr->seqnos[type]);
+		break;
+	case RAS_EVENT_TYPE_INVALID:
+	default:
+		id = BIT_ULL(63) | 0ULL;
+		break;
+	}
+
+	return id;
+}
+
 void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 {
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
 		struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+		u64 event_id = (u64)atomic64_inc_return(&ras->event_mgr->seqnos[RAS_EVENT_TYPE_ISR]);
 
-		dev_info(adev->dev, "uncorrectable hardware error"
-			"(ERREVENT_ATHUB_INTERRUPT) detected!\n");
+		RAS_EVENT_LOG(adev, event_id, "uncorrectable hardware error"
+			      "(ERREVENT_ATHUB_INTERRUPT) detected!\n");
 
 		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		amdgpu_ras_reset_gpu(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e0f8ce9d8440..64788ae7d85d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -64,6 +64,14 @@ struct amdgpu_iv_entry;
 /* The high three bits indicates socketid */
 #define AMDGPU_RAS_GET_FEATURES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
 
+#define RAS_EVENT_LOG(adev, id, fmt, ...)				\
+do {									\
+	if (amdgpu_ras_event_id_is_valid((adev), (id)))			\
+	    dev_info((adev)->dev, "{%llu}" fmt, (id), ##__VA_ARGS__);	\
+	else								\
+	    dev_info((adev)->dev, fmt, ##__VA_ARGS__);			\
+} while (0)
+
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
 	AMDGPU_RAS_BLOCK__SDMA,
@@ -419,6 +427,21 @@ struct umc_ecc_info {
 	int record_ce_addr_supported;
 };
 
+enum ras_event_type {
+	RAS_EVENT_TYPE_INVALID = -1,
+	RAS_EVENT_TYPE_ISR = 0,
+	RAS_EVENT_TYPE_COUNT,
+};
+
+struct ras_event_manager {
+	atomic64_t seqnos[RAS_EVENT_TYPE_COUNT];
+};
+
+struct ras_query_context {
+	enum ras_event_type type;
+	u64 event_id;
+};
+
 struct amdgpu_ras {
 	/* ras infrastructure */
 	/* for ras itself. */
@@ -479,6 +502,11 @@ struct amdgpu_ras {
 	atomic_t page_retirement_req_cnt;
 	/* Fatal error detected flag */
 	atomic_t fed;
+
+	/* RAS event manager */
+	struct ras_event_manager __event_mgr;
+	struct ras_event_manager *event_mgr;
+
 };
 
 struct ras_fs_data {
@@ -879,4 +907,6 @@ void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info,
 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);
 bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
 
+bool amdgpu_ras_event_id_is_valid(struct amdgpu_device *adev, u64 id);
+u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type type);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 1592c63b3099..a3bfc16de6d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -44,6 +44,7 @@ struct amdgpu_hive_info {
 
 	struct amdgpu_reset_domain *reset_domain;
 	atomic_t ras_recovery;
+	struct ras_event_manager event_mgr;
 };
 
 struct amdgpu_pcs_ras_field {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 77af4e25ff46..4a02e1f041da 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -404,10 +404,16 @@ static int umc_v12_0_err_cnt_init_per_channel(struct amdgpu_device *adev,
 static void umc_v12_0_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 					void *ras_error_status)
 {
+	struct ras_query_context qctx;
+
+	memset(&qctx, 0, sizeof(qctx));
+	qctx.event_id = amdgpu_ras_acquire_event_id(adev, amdgpu_ras_intr_triggered() ?
+						    RAS_EVENT_TYPE_ISR : RAS_EVENT_TYPE_INVALID);
+
 	amdgpu_mca_smu_log_ras_error(adev,
-		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status);
+		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status, &qctx);
 	amdgpu_mca_smu_log_ras_error(adev,
-		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status);
+		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status, &qctx);
 }
 
 static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
-- 
2.34.1

