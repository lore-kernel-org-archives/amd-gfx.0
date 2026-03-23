Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F6CFC72C5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 23:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E3D10E47D;
	Mon, 23 Mar 2026 23:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qtw3En4w";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B00410E456
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 23:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gv7KxbjesZjKHp6nS8PXYnCNSMXQcofH0oxLlbZpbsIsR5d7/gnmCEh5aY/E/l7fqsk2dMn2nD6XkNYfSVkEsq84NRv/PfAVH6CQSE7D6ib4dIII1X0/55Whn2HptzAG6UCBNnTnbGxjWouZh8dcLIDb9jYv73fpdUnegku3SJj2kwC8f+yKMj6J42B7FesmN6Amf8+t5pTiN1c8gZWgTWASXR7CZhvfebIxzSTsho8yEb03mDLyemRS9vciGfimyLEie0p4mpMFTK+nYdBAFMiJf7uybepyRN/0pDq9DzZg5mBAGq8mCRtCNL7GrMR5M3IYpoBrvjgRFsNBuAioKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM5vzpsQMu//9Ha7vuH72c6E45UlJQdW13iekY0a3y4=;
 b=VU/TUuCV8N3mFvVFNNUuwb80QXCcIQ/8tba+yLX6lh67CmQ3Ce2/Wu1Cavw9s8iREFJqXI8qGyTmwc39WZtsJKA8utajvieJuggeXcbibx5svH9Ffsj5rERIzWpKhLCrCrWt62AewJfjHQT2mG5E/7wSf+lMmoPROkujh5N1dFKP2VK5j8zqrZSoxE4v21076naKymjPm3KV106mNdM67eXH8YTmMddtEJEpishjcs4kRFve6HnrbedXejeh177bkQQFjrdSN+xPj6UlLcfqd6hMe/BcWIEz/VASZHxuuF9WcMGloY+Xw9+83gDXhKvPRfEOL6kp1pWntzX6kO80Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM5vzpsQMu//9Ha7vuH72c6E45UlJQdW13iekY0a3y4=;
 b=qtw3En4wFnuE5FG9YqdZ0l+Om+AWOp5WKXHWaiVCiAzKkyWwJSpGohNyB39ZK/ydOGaQ+W5yH6a7kmSseV0YWcZ+90eVbkBtkNRskh5wlaF+48haXqME7Cc6XNDr09LSvq1uO7klw4ovzpP8mY3tZa1PPAA+6N8K5m5crg6+ieM=
Received: from SJ0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:a03:39f::32)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 23:12:30 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::cb) by SJ0PR03CA0237.outlook.office365.com
 (2603:10b6:a03:39f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 23:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 23:12:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 18:12:24 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: use helper smu_cmn_send_msg() to simplify smu
 v15 code logic
Date: Mon, 23 Mar 2026 19:12:06 -0400
Message-ID: <20260323231206.722067-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231206.722067-1-kevinyang.wang@amd.com>
References: <20260323231206.722067-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 461eb41f-71b5-40c9-e6eb-08de8931a6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: f8sU1JzjEHMxXi8uZfpJif4fzdjJ6q/wDvqpyBPobW+DnkTxDy2lreIP4xWmm59zNiiPiD6871D4gg1iAQ0D2FOF58z/zr5mhyfD2HvcBuXd2c333B4USAwvm5VICYu8CpRA/umGefq4Sg9fFNTG0FyxLfVss4YlyuQib+yXig1+TZFt+9iJDxRh5uT1CbgOwjrq7In+29lRX8ysx6j7XkribGdPmDpZMs6EfL2bgn8lHlf97PcBul/7UwIvufydmtEcKAC/yUPtuhCRwkfC4rvvRzLCKIlbVSlmm8POBxVhXyGNxQXPZWHT4uhCoo9bj9tcw3cBIOkVJXWs8lDtIU4XJQLmPR5USUKSaYcJtXYySpmQiZ23Ork+U8e4DvB9OKdvT3pPZlFptDO+ufg0kk7QmOdsyYFO8uzeSWQCP1S8oOLFiTkeIEvYRm5UtSsSmHl0ZhmdqN/s6xaprMa/0uHK1hMYiv0ukxBi+Hqdb0G9TWodbrLlKmFMHvmcQ6+5iFng6+zu9PpBCklE3WdyXNxSejiM31jQYrxN9Vjgqq8O49E971rJE7Lfah5eVOYZblDw5r5mZgk9qhnYoZ0Ymo5OmVByIpVySUN340TMkMB0+eSCKicTw1iFjDKVlyDNRHWxoC/WOfc9RUYOLdyIGIHm4bYDlizMYPdUich0ie83TDBWiMUrl5mQdj4VPs02v/QCkPd7FVWqhYyDkehZI9MZbLE+mVpFm6vDXbGziCEyhJPDEd7vIw/2Pq4jDq/6Bs7+mDnnVZiG/6SxSfxxfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8mxMEFIbMpTaoUtLOyAL798lVUjHlgqVQXC5ToJlrX4+WZJ7dTCZtErzsGGLRtVrIPgIzzqKO36x4wlQY8/kaullVkWuufjsFXd1fblt4Thy3AHCDolqrkIJoQW9S4U3KEVqXbJXh3qkQre+vCH8bPHi0QpojLLbOhy59ZWSgyr5EvNQQdmdBxCx9X6Ouec0c0UyJi6qNYBtJv592JdrNEHt8xo+p/mz7tzWFHuNin1Fnp7v4t9aXFAM0loZmaGLeLEFCmaMClGTXQC67ZbY+Qh2PBg0PRi+3/fByAJCyayfjhLu4OrcA8XPF1Tryg/PEpEghXB5Gb7si2r1Z/hjgjrdU4xFrFaaGGNG+bMMs3LaeH6QZhKLUhCJ4XVv1hRfgTlrpWzV0gOr4oCmebJNl0PCePWrp6gzQGk+3GjNYzH5Bnazk1KhixYkuDQGLray
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 23:12:27.8335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461eb41f-71b5-40c9-e6eb-08de8931a6e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346
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

use helper smu_cmn_send_msg API to simplify smu v15 code logic.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 41 ++++++++-----------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 8e95a62e186c..51246a098335 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -590,52 +590,43 @@ int smu_v15_0_notify_memory_pool_location(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *memory_pool = &smu_table->memory_pool;
-	struct smu_msg_args args = {
-		.msg = SMU_MSG_DramLogSetDramAddr,
-		.num_args = 3,
-		.num_out_args = 0,
-	};
+	u32 param[3];
 
 	if (memory_pool->size == 0 || memory_pool->cpu_addr == NULL)
 		return 0;
 
 	/* SMU_MSG_DramLogSetDramAddr: ARG0=low, ARG1=high, ARG2=size */
-	args.args[0] = lower_32_bits(memory_pool->mc_address);
-	args.args[1] = upper_32_bits(memory_pool->mc_address);
-	args.args[2] = (u32)memory_pool->size;
+	param[0] = lower_32_bits(memory_pool->mc_address);
+	param[1] = upper_32_bits(memory_pool->mc_address);
+	param[2] = (u32)memory_pool->size;
 
-	return smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
+	return smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramAddr,
+				3, param, 0, NULL);
 }
 
 int smu_v15_0_set_driver_table_location(struct smu_context *smu)
 {
 	struct smu_table *driver_table = &smu->smu_table.driver_table;
-	struct smu_msg_args args = {
-		.msg = SMU_MSG_SetDriverDramAddr,
-		.num_args = 2,
-		.num_out_args = 0,
-	};
+	u32 param[2];
 
-	args.args[0] = lower_32_bits(driver_table->mc_address);
-	args.args[1] = upper_32_bits(driver_table->mc_address);
+	param[0] = lower_32_bits(driver_table->mc_address);
+	param[1] = upper_32_bits(driver_table->mc_address);
 
-	return smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
+	return smu_cmn_send_msg(smu, SMU_MSG_SetDriverDramAddr,
+				2, param, 0, NULL);
 }
 
 int smu_v15_0_set_tool_table_location(struct smu_context *smu)
 {
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
-	struct smu_msg_args args = {
-		.msg = SMU_MSG_SetToolsDramAddr,
-		.num_args = 2,
-		.num_out_args = 0,
-	};
+	u32 param[2];
 
 	/* SMU_MSG_SetToolsDramAddr: ARG0=low, ARG1=high */
-	args.args[0] = lower_32_bits(tool_table->mc_address);
-	args.args[1] = upper_32_bits(tool_table->mc_address);
+	param[0] = lower_32_bits(tool_table->mc_address);
+	param[1] = upper_32_bits(tool_table->mc_address);
 
-	return smu->msg_ctl.ops->send_msg(&smu->msg_ctl, &args);
+	return smu_cmn_send_msg(smu, SMU_MSG_SetToolsDramAddr,
+				2, param, 0, NULL);
 }
 
 int smu_v15_0_set_allowed_mask(struct smu_context *smu)
-- 
2.47.3

