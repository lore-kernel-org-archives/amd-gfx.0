Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEAFC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 10:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4619210EAC9;
	Thu,  9 Jul 2026 10:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dKYx/Iyc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C25310EAC9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 10:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwHE7+XNkxi0EG39H8sBxztQKdiWnsGrQxKXJVYEsmb2jbHFn5PIi7gAW5MuWtR8n9C2y3wwrWiXBAP8OiT5o5UifYKLFv2Xgv0oGknxfWs6LoSP7mUumR5I+iz91hhBweJD1L+w+Ek/hEIHjWu9xH7O9to4ItIhKFhJJ3tL27MzVmBPeaTvRgSbOwMPHI9Uzhad7aGAdXfOZXlL7V56DJm3bjWfdkfujnAZCnTf3RLnOwnRGFFf8drjKeOdn86UCcUlb/kL4heJjAGubUKM1S1fzkvXEN8Wfb++VDT8gP3vy0dBWOenVcAZaVflMVDGzNUpNcxcjF6l/AbvxNxHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+fIzKJ6bJCjuj2rjXFB7PyKlQtCLGotmfQCYDv/tn0=;
 b=kuj+Sd9jwIKRlsl89Sp2VyMfTA4BK5QEzqRS0TtjArHbEkQb7URfiJifAN2AIcDqAhQ2dyrfcKHgugslKlnojICNLol5WmyV3rTQDQQ3AD2bbQQ6ztqQJG2CHSn1XLgkUmpnQx6MKZ3afUpK++CvKkATuwzLwvzKywiCHvlUrTDcT7uiFjEzpbYkHUYqfaVIX/iIb9of3pjaNA+WLz90M4hRP9jergIuf4AhPAVHf9oqb60QhDBkIm3Xcc/zD14uz598eFYYELLCKVXL1ILfp9UYExlzVN148sd+pOm/HBFQoPvE+5AuOopHI1FOLlmBYGkZ77o8944q8A46B18Hzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+fIzKJ6bJCjuj2rjXFB7PyKlQtCLGotmfQCYDv/tn0=;
 b=dKYx/IycvXH3fMwLhhV4z/bLsTv3pGcRs/5nxczbsUDZkjHb7lUD8SbWV2h0uilGRGe811YeI3g3FDWIz+maixqA1Ia7jtazEwg0691aaMo0rth6ynm9nmNkqJsk4+4Kr9JsaJNNs0OCQNoxaDnZ9HDqbosAWYiVZnTk9z4SDOw=
Received: from DS1P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::12) by
 CH1PPF989868826.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 10:42:51 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:8:44b:cafe::46) by DS1P222CA0016.outlook.office365.com
 (2603:10b6:8:44b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 10:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 10:42:50 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 05:42:48 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: align smu_v13_0_6 gpu metrics acc types
Date: Thu, 9 Jul 2026 18:42:25 +0800
Message-ID: <20260709104226.1768300-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c9c926-4187-43ee-6da9-08dedda6d327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: v8pdibeQCRjWtQgqdC/XxkBhp6sMXePVgjvt+CIt1vhlF28Uusm3NSdFZzj+A3a8Ldwjlp17rsTls4IAGFgwCpOTxBxwGHZH3uT8YWW6mMnoZoXQhiBvBSrilCb10oW+0kF4gD3AdxYVUqULRYmlBOPrMQe0KPRBp5k6ICROmMddxhs7Biayf69n+sEmiFghqRxFM8aUpisL/DlJnuz4OyzLRgEuAzGOyTq2i/ighKiXr4qsuA4GZY8de8HWaSxuCYVDi+eBxFecZi2aq1E7LWTl+XouNhzAC0aeA29dNeCDYWVU6mlYXvW8RUrCbTDDG/rc8K6aoI0GlR7/IdDYccIFV2m99YB+chkZPCdf6J5HPzoA+tf1aD0DmxPsH/m1cQs1jHurg82R5D9n5QPShtqiL8TYbk/R4SXGaoLqFG5XOC+f2GZrPa7LTAJQlsTHDchvSwrkEKM2hSmY7U+p1kYJ4HmLFX1xm+ROYxVUfRXU8F7Rm+JX3QE7gMtow7qfj0DVFYD576KvOCE+Hcy233BOK1xbFDNA8fzxV1NW6WeHGIALMU1T1CVg+eQAaWKdd3MTJ/YlkldUllWcYotnul48k+yPwzD4KkOeeDN58+Se5wuOxyUKk0nKx6Fk73MN0uCOLqCUQNtMDVx5tmkv7U70a6NI0Kd0+uhWGYaaYIYPUru45afNEO7Ap3tT5us8etY7nopQSfEGEyWroYaU4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vGAqWdISzcMVTxDmsdz53Y8vhdthfry5ukn3WDmgcXugQpHShNmH01Yv6JDCJdxiLeN2njdUNtIgKxTFyd9t8QgM3FkOSz5nq2SZYIzBC2aMu3WVm9EK9w0K4s1zmQvfW2Xol4Mn+CcPT4xhuiDLFXF47y1r/Trg4WnYdIkqcKrfXRoLHFJSeg5ZiM36RSxIl8Sb4pAH0woqBjHn5bfAjyD6sABk2lsm1rQ8JmTYQgO5dF6YKBBHgbYUpd0sict9ijh46plEtYo4gPq3cqYylPdd3iMos8jrSTfXz9SyNxwasl23j6GT1xY55ODxjMiimtq4uxqDUumiFgWfBwENteYdINUhbQYIxJ8BBcvSRELeIGvNlhZ0kWbrC9xN+odD5U0nQ8ZnpUImMqSVymlUY+GQ1fz1TRcgcon+zqy05VJPfQenqaDEEk5I5YtD5mbc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:42:50.9285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c9c926-4187-43ee-6da9-08dedda6d327
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826
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

Widen several accumulated counter fields in the smu_v13_0_6 GPU
metrics definition from U32 to U64 to be consistent with the
equivalent field definitions in smu_v15_0_8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index a66bf33dbb58..011fc6eeb7ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -144,15 +144,15 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
 		   SMU_MTYPE(U64), accumulation_counter);                      \
 	SMU_SCALAR(SMU_MATTR(PROCHOT_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
-		   SMU_MTYPE(U32), prochot_residency_acc);                     \
+		   SMU_MTYPE(U64), prochot_residency_acc);                     \
 	SMU_SCALAR(SMU_MATTR(PPT_RESIDENCY_ACC), SMU_MUNIT(NONE),              \
-		   SMU_MTYPE(U32), ppt_residency_acc);                         \
+		   SMU_MTYPE(U64), ppt_residency_acc);                         \
 	SMU_SCALAR(SMU_MATTR(SOCKET_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),       \
-		   SMU_MTYPE(U32), socket_thm_residency_acc);                  \
+		   SMU_MTYPE(U64), socket_thm_residency_acc);                  \
 	SMU_SCALAR(SMU_MATTR(VR_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),           \
-		   SMU_MTYPE(U32), vr_thm_residency_acc);                      \
+		   SMU_MTYPE(U64), vr_thm_residency_acc);                      \
 	SMU_SCALAR(SMU_MATTR(HBM_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
-		   SMU_MTYPE(U32), hbm_thm_residency_acc);                     \
+		   SMU_MTYPE(U64), hbm_thm_residency_acc);                     \
 	SMU_SCALAR(SMU_MATTR(GFXCLK_LOCK_STATUS), SMU_MUNIT(NONE),             \
 		   SMU_MTYPE(U32), gfxclk_lock_status);                        \
 	SMU_SCALAR(SMU_MATTR(PCIE_LINK_WIDTH), SMU_MUNIT(NONE),                \
@@ -164,9 +164,9 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 	SMU_SCALAR(SMU_MATTR(XGMI_LINK_SPEED), SMU_MUNIT(SPEED_1),             \
 		   SMU_MTYPE(U16), xgmi_link_speed);                           \
 	SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(PERCENT),            \
-		   SMU_MTYPE(U32), gfx_activity_acc);                          \
+		   SMU_MTYPE(U64), gfx_activity_acc);                          \
 	SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(PERCENT),            \
-		   SMU_MTYPE(U32), mem_activity_acc);                          \
+		   SMU_MTYPE(U64), mem_activity_acc);                          \
 	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(PERCENT),          \
 		   SMU_MTYPE(U64), pcie_bandwidth_acc);                        \
 	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_INST), SMU_MUNIT(BW_1),            \
@@ -178,9 +178,9 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 	SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_ROVER_COUNT_ACC), SMU_MUNIT(NONE),    \
 		   SMU_MTYPE(U64), pcie_replay_rover_count_acc);               \
 	SMU_SCALAR(SMU_MATTR(PCIE_NAK_SENT_COUNT_ACC), SMU_MUNIT(NONE),        \
-		   SMU_MTYPE(U32), pcie_nak_sent_count_acc);                   \
+		   SMU_MTYPE(U64), pcie_nak_sent_count_acc);                   \
 	SMU_SCALAR(SMU_MATTR(PCIE_NAK_RCVD_COUNT_ACC), SMU_MUNIT(NONE),        \
-		   SMU_MTYPE(U32), pcie_nak_rcvd_count_acc);                   \
+		   SMU_MTYPE(U64), pcie_nak_rcvd_count_acc);                   \
 	SMU_ARRAY(SMU_MATTR(XGMI_READ_DATA_ACC), SMU_MUNIT(DATA_1),            \
 		  SMU_MTYPE(U64), xgmi_read_data_acc,                          \
 		  SMU_13_0_6_NUM_XGMI_LINKS);                                  \
@@ -203,7 +203,7 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 	SMU_SCALAR(SMU_MATTR(CURRENT_UCLK), SMU_MUNIT(CLOCK_1),                \
 		   SMU_MTYPE(U16), current_uclk);                              \
 	SMU_SCALAR(SMU_MATTR(PCIE_LC_PERF_OTHER_END_RECOVERY),                 \
-		   SMU_MUNIT(NONE), SMU_MTYPE(U32),                            \
+		   SMU_MUNIT(NONE), SMU_MTYPE(U64),                            \
 		   pcie_lc_perf_other_end_recovery);                           \
 	SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),                \
 		  SMU_MTYPE(U32), gfx_busy_inst, SMU_13_0_6_MAX_XCC);          \
-- 
2.46.0

