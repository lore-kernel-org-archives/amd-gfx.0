Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62E0FB5188
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 03:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2F710E31C;
	Tue,  7 Apr 2026 03:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N6Ijo4YO";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7868B10E31C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 03:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjqG559lZ2hc0QqRQjfdOjVYrerSgViVpsQZ7YSaRYjEF9KXwaKG2pO4vHLCNiAgI5vnKGCH8NijEC4QxNI0qAsUvfgCAi45BpJ63NXao8J4Z87NE0DRBdN+mKeKHf4n2wmZv/iL0Y7aKv64j9HB2/OBJlFSrz0jZszi0sC0U6i7jHlmueEF/NmTwVnzow4fD7ewsQuGBW8D7a+f7E+o0zPXdBgKE+e/slJgb1kbMGU7vtXEvvhm+iHMZ2D7Tplh+VAPPA7m+XC6NnRYjypveBy49heb0EKtunDHzK3kHGnxTphtHmozOZbMpVQ4513XEeOBJeTZMcJQqheIjgkhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhaBtkS35BS7KN+VGbRY4WlEJinCpg4H94y5xYQMXjI=;
 b=S/6X5xyAh85O/sYCdurjBGwwXRrg6rZrhj33tx9zPTq6YgzSvbjvhiqW/KzpJ4Fe2Id9aeyjUCFQ2nx/PqbfVL33KeT1MvDHVzvGStPV7sXaQutO+SMuAuMoRREr0ljcuVfbrISEBUvN/0IZ+fnO8s2Zme0QZAmMsdOtDoItQwAWMfnm5VijlrvMa+SvY8ljlQloNvSe4Gxk++VgEVOBVLtz1OxyvXgY955y5FutepinQwXNLewJEN1ymvp+HD1RdrM+DGDwVvnZxSdQkTN++UM4E1Tqh2roQ77IlA9fzG51iDVs2vpT8ewJ3YlTc2gXYjyKR27UaciGQU9A95/hrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhaBtkS35BS7KN+VGbRY4WlEJinCpg4H94y5xYQMXjI=;
 b=N6Ijo4YOgPk1nZI+wqx7Jb87rKS1S9MLJGcaGVvBTvfwol6QYPSU93HTUzLbb9zf2D0l/6qY2l1qV0PczJXc5m0uXPS1XotAA600VyRIrhSh9TvaDYpF0NaeqdyAFGtwwILPrp+CtnNedQmnd3uD4r8mpAU/vi1jTD7s+KKegTk=
Received: from DM6PR06CA0082.namprd06.prod.outlook.com (2603:10b6:5:336::15)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 7 Apr
 2026 03:09:48 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::e6) by DM6PR06CA0082.outlook.office365.com
 (2603:10b6:5:336::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 03:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 03:09:47 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 22:09:45 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: add read arg support to smu_cmn_update_table
Date: Mon, 6 Apr 2026 23:09:30 -0400
Message-ID: <20260407030931.2024335-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: b78a7817-274c-4302-2814-08de94531ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: l3+I+ENQU26VMTyzVOjxVvtUp8IOxRxWo7czA9R0DFkN/hrE2r6XV9lrAPM8JQYneQC5YuhJ6mahpQSXip50tmMoExoi26gfdi5VnCJkwkaIBzYbeupv31WbaPgI/jGHU0sFpeZpYcOsjyhBQHBDuDX43hFAeLwiwG9XPm38DCYgmJaPPvxTdyRNPH7+YoyoBCLJ+tz3eAtb2oZx20W9Lkyq2qWFSvs0t0m/xnwhToWX/L0UmEKPU+3emx9ZLAnDDcErgvTH2pyEDXH+XQEfGe6QWCYxcu2QPnasNHmItzq3h5X2HldEq8O9nOlnZ4AnDOxZtivN30AHabQK2eEMSF2JuxQVc0zpmaOsB1agVZ8pbtywMdpMyJk/aD2Ece54WiAGafsgoUb/LGIDG0dMY4j1nMRMhPVNL4vizOkQI+qmMV8jjK4OZUZ8D/R8aO7NVCu+0VQx1cmr1mSlrJyM1o14KaBpOgXIhgTF5D7okGtX/30aA23eU5d5R9hOrnTUqhBjZNBiT6TEGafUIES8hntoQVJA6BW0so7pk6ZK5nK/ZzfhvIEzIHwhY7A2thXxAdK0iM91zLxOZjEs+RNFByIM27RWTylwRijrT2RBEyClSx+s9kX7orDLQ9Ock11veyk14IfOKlpfNk8AVnVi88h0+4P1Bbf4mxPVMIh7mvw+10D0pcNsj6lizeDE3WdtfXEZe1mSD6OXwc8u4MZGzotLR957nhc6mIuFq/rQYobyHG9GqQMkcRTbXSK6v7d1AOCUCMpGH9qM/vWa9Tq9lQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xIFYsbIvoceMwPdkwN4r0qp9hs/wn2UKCcgFEbe1SFerSmrH3noGfpDnFjPfOdGYda1pYJ7sWU0GsfJFjb6+iDSw/ni3gf5O9qyqAk0okBtG/hYe/9wRKEryNu8ywPL8e2cpxebQ48zKvmNIS0BTJYwmDN210Eexy8bK9nYKwF/m2sfiss7F0hvhZtqtclTbM7Yijjd5utM4qtJhsMTp3cQttCEPRUD4flbh1aUHsatWO1EFV8awuzDCOtLP19A0+NuKYBUuATIpwK30PUlraTbtxrXzQzhnziYCZk9KkdhTDScFUxpX8Oum5DxPHF+4DYpLDKpHCmgJJbkHgld0MvJ7tGF2DuI6+AlbtHZ9hD6FwWt/AH0UWBMsXnR4EuEGmKThI+OZR3nS+4bDrEEEuOYwW+F+e0Vwi/N75uIVnXyy/Zc4bnO+vNxOaH6Hmua2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 03:09:47.2388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78a7817-274c-4302-2814-08de94531ffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

Extend the smu_cmn_update_table function to support reading a 32-bit return
argument from the SMU firmware during table transfer operations.

- Rename the original function to smu_cmn_update_table_read_arg
- Add a uint32_t *read_arg output parameter to capture firmware response
- Pass the read_arg pointer to the SMU message command
- Keep full backward compatibility using a macro wrapper for the old API

This allows the driver to retrieve status codes, results, or configuration
feedback from the SMU firmware after table data transfer.

No functional changes for existing users of the original smu_cmn_update_table()
API.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 37 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 14 ++++---
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 126fc54cb511..d76e0b005308 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -584,6 +584,7 @@ struct cmn2asic_mapping {
 /* Message flags for smu_msg_args */
 #define SMU_MSG_FLAG_ASYNC	BIT(0) /* Async send - skip post-poll */
 #define SMU_MSG_FLAG_LOCK_HELD	BIT(1) /* Caller holds ctl->lock */
+#define SMU_MSG_FLAG_FORCE_READ_ARG	BIT(2)	/* force read smu arg from pmfw */
 
 /* smu_msg_ctl flags */
 #define SMU_MSG_CTL_DEBUG_MAILBOX	BIT(0) /* Debug mailbox supported */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 006ef585a377..3d49e58794d2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -496,7 +496,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	}
 
 	/* Read output args */
-	if (ret == 0 && args->num_out_args > 0) {
+	if ((ret == 0 || (args->flags & SMU_MSG_FLAG_FORCE_READ_ARG)) &&
+	    args->num_out_args > 0) {
 		__smu_msg_v1_read_out_args(ctl, args);
 		dev_dbg(adev->dev, "smu send message: %s(%d) resp : 0x%08x",
 			smu_get_message_name(smu, args->msg), index, reg);
@@ -1060,20 +1061,24 @@ int smu_cmn_check_fw_version(struct smu_context *smu)
 	return 0;
 }
 
-int smu_cmn_update_table(struct smu_context *smu,
-			 enum smu_table_id table_index,
-			 int argument,
-			 void *table_data,
-			 bool drv2smu)
+int smu_cmn_update_table_read_arg(struct smu_context *smu,
+				    enum smu_table_id table_index,
+				    int argument,
+				    void *table_data,
+				    uint32_t *read_arg,
+				    bool drv2smu)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct amdgpu_device *adev = smu->adev;
+	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *table = &smu_table->driver_table;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args;
 	int table_id = smu_cmn_to_asic_specific_index(smu,
 						      CMN2ASIC_MAPPING_TABLE,
 						      table_index);
 	uint32_t table_size;
 	int ret = 0;
+
 	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
 		return -EINVAL;
 
@@ -1088,11 +1093,19 @@ int smu_cmn_update_table(struct smu_context *smu,
 		amdgpu_hdp_flush(adev, NULL);
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, drv2smu ?
-					  SMU_MSG_TransferTableDram2Smu :
-					  SMU_MSG_TransferTableSmu2Dram,
-					  table_id | ((argument & 0xFFFF) << 16),
-					  NULL);
+	args.msg = drv2smu ? SMU_MSG_TransferTableDram2Smu : SMU_MSG_TransferTableSmu2Dram;
+	args.args[0] = ((argument & 0xFFFF) << 16) | (table_id  & 0xffff);
+	args.num_args = 1;
+	args.out_args[0] = 0;
+	args.num_out_args = read_arg ? 1 : 0;
+	args.flags = read_arg ? SMU_MSG_FLAG_FORCE_READ_ARG : 0;
+	args.timeout = 0;
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (read_arg)
+		*read_arg = args.out_args[0];
+
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d129907535bd..1cd2ccb11b29 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -168,11 +168,15 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
 			    uint32_t *if_version,
 			    uint32_t *smu_version);
 
-int smu_cmn_update_table(struct smu_context *smu,
-			 enum smu_table_id table_index,
-			 int argument,
-			 void *table_data,
-			 bool drv2smu);
+#define smu_cmn_update_table(smu, table_index, argument, table_data, drv2smu) \
+	smu_cmn_update_table_read_arg((smu), (table_index), (argument), (table_data), NULL, (drv2smu))
+
+int smu_cmn_update_table_read_arg(struct smu_context *smu,
+				  enum smu_table_id table_index,
+				  int argument,
+				  void *table_data,
+				  uint32_t *read_arg,
+				  bool drv2smu);
 
 int smu_cmn_vram_cpy(struct smu_context *smu, void *dst,
 		     const void *src, size_t len);
-- 
2.47.3

