Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D900C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 13:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227AE10E1CC;
	Tue, 13 May 2025 13:50:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHr9gj1o";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F89B10E1CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 13:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPSZVCMhDFQTKrgg3xfyrN4OJkF/lmHMvM/Lj2Gv2096NfNfVuTmmav8qAzhxRIXIg8K0KW9gSIprgMAuPTHlB/iJrKXJHMk8acjidcr4n7ZR8NXyoYOe0WW+TP9XG7EqrE+M1MTG/MDOCYY9B2OQrgW/VcGOzd5IkJCxLPrkv4QkV3xfe73LdEpCD5FB+CxPhEcn9qwYWESBa6cZY8YDLDtEUQdDkk2hitxvba8RgFmB+8KjDYmaKNz5MmALekwv2/fW/8c73qQBKtBqkGL1TQyTNSca7yECkDimmXWIQTyq3JFTUC2Cmtma24vEkss8DghoxjqmkI1lRtA1+hhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2ys3L2QLhfYe0KOSmeuoi8+yxIS/parjTFvLqtc3wg=;
 b=izgUCiOO8GfjR0tjbKxKyZPIb9rkGejgH1iAZSR6FSW+OfFLH23yfwUp6oMgPBgTYaMgxXwJrmoUN+2mwxqhXwn6HLiNljazv+5Awa0SqlmmUXR98Ha9CPLNUhZbYMa4wRAPdB8VYPwcroVlmE5XZEWmgfQ6vlXHVjYXj0SxCpEZ4lPfTqLCu4FeoHOBecgTt4db488wpttVEchQi88vYaX14BsrJIOxolyWj+Tssm/ZKSYhO7V0+sDY9s/sKaQiDWuVGDzIJ14F/E5+vTB2psZP7YYQ7pymsjMI6QTkTSsH553TxJlnlzbZGeOQ1+gScFYFArw/Z/1Z3Kp067BmNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2ys3L2QLhfYe0KOSmeuoi8+yxIS/parjTFvLqtc3wg=;
 b=tHr9gj1oTnglBG6xVSUNz2rzNp6fC9nDKnpIremQZCYFDXeHE9w9QEBoaukKcrPIkBlqdVk/nI88rrpIYJK8mR2/JADKYKWghN8W+1C+xcMtSZHtjDrG4BTL1Ob3iqX+OlOeX+L5GL/Op8QwCKvTwUcCrniuDdiHEyqYPIkOdyc=
Received: from CH0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:610:76::34)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 13 May
 2025 13:50:11 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::28) by CH0PR04CA0029.outlook.office365.com
 (2603:10b6:610:76::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Tue,
 13 May 2025 13:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 13:50:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 08:50:09 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Move SMUv13.0.12 function declarations
Date: Tue, 13 May 2025 19:19:53 +0530
Message-ID: <20250513134953.417516-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4588a3-3226-4c63-f474-08dd92251468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V8s0bS9lkz6UGEduiP/BIQyDJh0VamDNEh+0GGbpRM1EnXG+Z3YrETVntLoO?=
 =?us-ascii?Q?nrUpunPgdA/OgR8m118e3/VmMymnhJWmPHuLQjhhKcXRdy7AADCprv154R/0?=
 =?us-ascii?Q?NlU7ofENv7JxFAiF8l4PcZH/FS5Piwh5N3vjXgM/v+IKOhTIxfM8z9jyoBKO?=
 =?us-ascii?Q?hDxpwZ+Y10Ful+D5xsMFb3EPfwSBJijEPH0LZ3qGe80YgcYkdM2zj9XiOUOY?=
 =?us-ascii?Q?hD8oBhoXEG87b4deLGGPWEwVnMFV4Iyt7AZ7ZXe1x7GR0GOl5qfpJQCWrgAz?=
 =?us-ascii?Q?L7vSrxPRYdCl9qK3Cj19RJg5us1QUkCsvUj+tykpQF4/PZzgeTjGINbe2O7n?=
 =?us-ascii?Q?OHZIKxCROpdsjrjSMbf+/9PueETWSyafVsu3KJ+bdi1bW9rFYjHKJaUXLF28?=
 =?us-ascii?Q?0vU8ykEfj6Zbv6zubIkNSKGw1vdbuu69EamCf0Hkhn8c9LxZm43/EVh7c/0T?=
 =?us-ascii?Q?jF+VISulROIrvNk9pcniCMJRcxVMY4RTrtcZQm5MfrQ5xcnlFhps6z0xyZrN?=
 =?us-ascii?Q?w6i9lnlBAIpHqRIbDnhpJoiDCAi9QR9CkqgTwkYsW0WCGMyLDjRsorV6IMP9?=
 =?us-ascii?Q?c4vrqkeFnVeG1utSK9yxAPGLI9CbsUEotXp48bAxvobgBnCzICs2m4tPXfBQ?=
 =?us-ascii?Q?JNcL/rgikJbm99cgoAjOcN2L2y8sI6VLK++s99EevsBl7e5anmvuRqt56pKv?=
 =?us-ascii?Q?dr3TGwlJguglmWLHEuX8Rc4ZFbBOZdw3T6K3UHEybCmrYw8WPxAEE0lrkocT?=
 =?us-ascii?Q?NSi0xjDyV+HE8nDSr7pd4V1273Hki8dNw5D60pDIoP+6q6PJwjMqBcqBCpj7?=
 =?us-ascii?Q?+/wu7AWN0TI7JcMjfYdDnn5sRl4W4wRxgWQ/8rDlm4krfPb0DSO+3gt4Lv+/?=
 =?us-ascii?Q?9XPHeyN+2T9rJpPSnai5W9f7ivhtXqLDX7/GqS3nYrxQYTu44N/sYtFC42/P?=
 =?us-ascii?Q?CoZOWYl0ahojp9OVai+NO3da/zryd+MF6dRLCEoHF7Qks3fJFE9VBHw2vcGS?=
 =?us-ascii?Q?71eUCFyub+x6FTdFyjFy77Veclr0lQu8RPFMQCHY46ayiTjTv1z+Bvg0uUhs?=
 =?us-ascii?Q?fMR7G+Lp4JS2Gf8v4UF2FaZhKRzdHKkQ006tPkWyxwmceImUxPrC5Ba6Edg6?=
 =?us-ascii?Q?uy1NvjsiPT9oBpKhIJrYb2xVveJKVi4kkyrdWb89RlQMTqtowUBHNAPxdUVh?=
 =?us-ascii?Q?qyfx4Lg7G9yht4oztrVGGNNhqRgh/2ufSMctd15SsmUnSF5mBemKcNy9x5Jd?=
 =?us-ascii?Q?nGjk8FGs/eeKt3AjlJgJGTljNYYGuNCziEjoSvXFX8BpP9X+RudcJ3crpSa8?=
 =?us-ascii?Q?2teEFZD4loHUvGUqe4/9Slk17ln2hnCSpQSKoWXwsuQPkCF9OxEktNBHHMQo?=
 =?us-ascii?Q?ZZI7FBauf+eQcY7JypE2r68fmXNk482Y/ODKgqttw832QhORO08s1G1VJgel?=
 =?us-ascii?Q?VYe8XHQZJoxnq1OOBcwBWW1WCq0o2VR7iZ4fkhWMUHxB+PT4auOHOmvb+QGI?=
 =?us-ascii?Q?pVV1A7kDOe75Fy5MVWhGxWqio4gpZJdB/uuC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 13:50:10.9805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4588a3-3226-4c63-f474-08dd92251468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
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

Move them to SMUv13.0.6 header file as they are used only in SMU
v13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         | 9 ---------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 9d4cb54a45de..4263798d716b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -298,14 +298,5 @@ int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
 
 void smu_v13_0_interrupt_work(struct smu_context *smu);
 void smu_v13_0_reset_custom_level(struct smu_context *smu);
-bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
-int smu_v13_0_12_get_max_metrics_size(void);
-int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
-int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
-				      MetricsMember_t member,
-				      uint32_t *value);
-ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table);
-extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
-extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 6e7293d3f264..1ccc150882eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -75,4 +75,12 @@ extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
 
+bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
+int smu_v13_0_12_get_max_metrics_size(void);
+int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
+int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
+				      MetricsMember_t member, uint32_t *value);
+ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table);
+extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
+extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 #endif
-- 
2.25.1

