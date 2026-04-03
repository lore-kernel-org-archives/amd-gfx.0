Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35FED7309B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 04:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E51410E31A;
	Fri,  3 Apr 2026 04:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XG8gRNBu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4809D10E094
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 04:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGpvcnkTJZohkSOyQGphYk2qxv2Ayb5xGh3lm1iurnSocSebqjGIdJiGWZxTshMmxcik1lVl5Kr2BvSrgMd+wG35WgIkf0raUY1/7mdIepPNOwRMTrws1QP9KqxWQJqROfKm37tU6pW7kB9KXnOjgSM/X4YdO4p9rsYScRajng3gFDgN0GCAyBhsB33hK5stzrfh6SEj1/vhO76QtnSSNYxxSgh8I394FgbEMt1xHpIAW2PFlEL7LbBy8P0CdIzKppVSuTWljbOF9KRoweiS+uGQ8ty8sno8led8WG9gptx3DHq34bzUqLje7syXaSLq2Wh7R/iS2uOSvo/tlWtHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhaBtkS35BS7KN+VGbRY4WlEJinCpg4H94y5xYQMXjI=;
 b=o7NFuSHJiYEzJGICb5OnkRZpX7OeiZoJ2v22OEU6oC0OCHP8VYAlVvjS8JefJ3G9/uXZAZZ2Mbqzzk4PIuSRCfWMPT5suBYIl8THnYNtIDzbtMK6aWWvRqJxuFSS+M0yNb9wUgUw9ixc0lHsaJr63VnhwAzOlbvXf8hndukDhq+Zic7Wd3mEV9DnTiM9/sLXOrP194Z6JgpIO0v0NN2OYSDVwOe68SdbDnaM0Q9rsv7lbQnVw76krTJUC6h0iRO0MN5eyiDOtajZRUp04NVAvwnX3J3g5nW9Mh3v253+t5Fla3vs62fDLmfheXf0DGFxSnLWHe6Gnm9g/tpRU81WZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhaBtkS35BS7KN+VGbRY4WlEJinCpg4H94y5xYQMXjI=;
 b=XG8gRNBuIdTW2mLUMs2yBkdLY4dtzv4jTa30wmY5Ko5EO79aaQR5fabsgGunSg3UBnDFiPZT9krUiYgp5fko4xtN+JDIvJEjr1Ewq1+EDQ/vyQfw6dTeiLI9go2zjqi/I3dJmw+a5xTbW4H9sl+33GInZkEdXPGhYshV3djwV3Q=
Received: from SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 04:51:55 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::62) by SJ0PR03CA0091.outlook.office365.com
 (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Fri,
 3 Apr 2026 04:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 04:51:54 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 23:51:38 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: add read arg support to smu_cmn_update_table
Date: Fri, 3 Apr 2026 00:51:27 -0400
Message-ID: <20260403045128.1977879-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 1faea06a-a6c5-4977-a89b-08de913cbaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: WB4K2EuP2dlJBW8JjF/Gzvhy3HcpV+mSFzzHdDL7CCDQpWih/AbPEi1cWKU4Ul4wJhOrOi5uez+IagWOu6OUVP+iNl3RsmPeNJe5hLRY7Rz4W01N8/QPGk+OpOK5T2fB099MFzZqiAHyokQNYcCdW+M2ESHi1+qr9xPgulv+b79OqwI3/Ja8+1G1H3uFma+00/qPRSkc68JqhOMTI2unhz9Aj9eR2W9HdUOyzn5KqaW0KBEh2KvldvHvRUlHEbXxNoQmKIUxMWTX7co0FWnRKZoPkmSTqUVGLg6UuKdksdv0buX8t867484IbMWGiFEFSGMIiLMlv8I7OnfP9pXuu15dFO63WrSL+L23NENr22polQz124ZPKu8Miq+jF5LyOI75gF6FhcR5KY0p3A6dxkwmJR3kIxbmWYSy8Sx7V66hTZpA1SsHWoAN/nGjWA/Qzw6qsjBJFTfkcUenBHKtGPkq+UtKYfDThKPRvFgr7S8tyf7jQJ3s0VeBbJIcr6/ttXnocNOzPRjH6fYK2YfC+8o4ClEa7IXqQLOQcaiMGGnOvi+HCBlCq3oJtRZeCD6F/RZBq/Nc6CGOAUeW6nADia/g65DAJvnE13IYLSxc5DiyKk8VGsn7GPtGFD0GcNX7OUMCV5orz1/LSufmfYgMK4+G5vAUb1g714kaH7R8FBP+Bcvutnlk2rEz6HNQEwceFzILuOzlqHH6TltoD278OWNhZ6ViOTxPQ8AuvI/LsYB91aPXDfUuT/AIlv+HuUbGoGJnEBhmATVSgRCmPbfECA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Z4aQWP2o0gGNUwq2JLvqd2WNhjnlj7eHM05Rt22t66KFj/pjgs8shZgQYSHW1RxIA9xNxwSeq0hNb0fGChFLiwVCpPOFs4bx8Wvf8qXop4+zCc3ZtgsIPlJ6A073WT29/NCMS4d+1UZ/jhfXeC4QnbC6pKx+E5RLsCpOcHzldH88w1x+NMKO4DPajS0wzxxfYglfo3cdShthjHp1PfdZ0D+R/eR02anavsBarSaHmfL2hw97dC39SoE9XgT8crPUS88v7V+sZCiChRyZeeO1/1Z7dFrcTcZZO3qqBoHDgBt6Z83ALyryYWWsrTWwGt6QC+JzJaZqYgZ2sidpMg1rCs2xzAVWNijV8dPHIq44NOM0meJBlKccJ79MA4DR7VTORZP0NnCFyWSm8Sdqdg3RBOtO1h+Zx3FSvkwegga1VEkKIltGihd3qL3itTfa1pL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 04:51:54.7132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faea06a-a6c5-4977-a89b-08de913cbaa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

