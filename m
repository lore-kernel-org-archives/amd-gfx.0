Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6146CA1016
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 02:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5100010E11D;
	Tue,  9 Sep 2025 02:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ntDQeQEa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C9E10E11D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 02:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmn03LBTheqfvAlr4EJ/wZJMlyX0/X617OAD/wXfM4ZApfSbZQGuRbrX/BvBO/8vOGHhX9wSkuj7wfGN37ZDgGeWkZr3m2XcaHMzCpcCkNt4w7mMXs9l4oasoe4Dki7pqxIc/WlzDaSNTHSqRPdLPP+8j9Qqwt+d2Tb4xH7xWfedTIoTrsgF9ZUtOGH76R18Fjo/zaU7MNv7zT+s6zHEHrzH1r+/oGrsqH84CNZLW1llTVKz5Wc0CHuh6M53IgzDaJUz0VQi1jSuSUAk7FZC9RDt+E8XFEnq7J+5oPL2cfY0R/RzFByqeL0zhHgJMmGBpYuHTAobTMAJaxJH9V/ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZMjQHTFBpeqFxVSXOCvRi9opkVxoVvMcORKFYMYygk=;
 b=Cz6SRugmlde1U//cCDnBg0U6/jZAokSs+bwJkHy/6+J3MslLCRABKiTvvkH8VSP4RvLdltDu3nVY0d18W6RysZxB7IUzsy+TVL+tvNBFFN+Fae9LIWng6YLeOtYKdJJmuCf+oU0EQvC3F56zUPXskVWlDKYXsWfUq3ZjFPVaTWoKOd9g6apgzpMgn9wiOvWB14ydXPjBHn/8AUmGDToprxWSCJd0hKNZfAWnXFdZULsIuP9itLYJRUlSz+BMMun1oX1Zj+ctC46TKvIUaHgprvZk6KBl7bXBWufCTRA6jqO1WWClgdS1nu4Q4fWU683xzm0+V6NPA1MnmFLD+k7VNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZMjQHTFBpeqFxVSXOCvRi9opkVxoVvMcORKFYMYygk=;
 b=ntDQeQEaabzhmvELhP10980FxoQHDcXi+omWvrZ/g4NxdsrAYEQ26zXLDDFJP16XLaqGjDnzRugXpea28mIia3b7XHWTSGSRKShYWzti6xFh2chmgz5rrxxBvt/c9VUHVC/DafMqy2JRl4uCiVh4pd4UhBP4kGq17Y2R1gwmKoc=
Received: from SN6PR16CA0067.namprd16.prod.outlook.com (2603:10b6:805:ca::44)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 02:21:22 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::42) by SN6PR16CA0067.outlook.office365.com
 (2603:10b6:805:ca::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 02:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 02:21:21 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 19:21:20 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for smu
 v13.0.6
Date: Tue, 9 Sep 2025 10:21:10 +0800
Message-ID: <20250909022110.2695284-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc47750-263e-4204-6b52-08ddef479171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UHf3zszI3lweK7xS3hFWu/0MdPwAopojgzg6Y0nz/z8NprIMQYwqSTjzzNA8?=
 =?us-ascii?Q?omy5mvW03oQeIBXyCq9PNKA0SROIU/KxqAjMjvNtAJ4Zs4aewa9DHU/JV3wn?=
 =?us-ascii?Q?kFH3QYqeGiMtO6yMnuzGigGmISlz4DH/I7+67ALTrvrwNowih+83sujVxN8o?=
 =?us-ascii?Q?S+C9+2l2dsMv2LhzNISzdRndms3gfW3TIM/d3qyWvdKJcA6xVKyQBhwmZfMG?=
 =?us-ascii?Q?cphD6392CgZMoR0ZkQLTJM6G31RROvCSANNXnBOr1iEzjaytDkh9OGfDnoSp?=
 =?us-ascii?Q?jqVzQB445uiu2zAmJGJ1UJdAqs0VYUzBCfdJrTwQ+xb0F9IxwvKP/YtxfV8Y?=
 =?us-ascii?Q?Kv4JCe1oMFruyuNg8dbeqCQbPsiT3v1cWZaim1hMuJhCv3QCXD592bmDzZSE?=
 =?us-ascii?Q?XkeTxT415qb4RH/ov1ueNn1e3A0ZGW/pRACzhaG5EWRu/Xayo6mK6HX+dXca?=
 =?us-ascii?Q?uRN0ixDqvuxBNXGKiGQ3wu2xN5hBxV9CeEaRwHxm0RHk4J1awE7/wPo7wOCT?=
 =?us-ascii?Q?tqiR7d/4b7t2AUbxlMPjHepBIdh2yvoLfDmbBi0m+wiGtZdQelrUEYb78Qpy?=
 =?us-ascii?Q?TY5B//0C6JnFktgWtu1wROPmGqu787MfKmp59OFUi+0NPH1du9eok+vsfJqL?=
 =?us-ascii?Q?q/LkHkP9cSm92hVlMJVKISM9mZGW4UibgUiAhaaV4RFhGwUHa/Eg9Es/GPLs?=
 =?us-ascii?Q?kZZU8tZ0aKYM8p2TskCWsXpvxgafDkh2aNtR5GMf32u5pxt2PYMsOCJdPSaw?=
 =?us-ascii?Q?k6SXTAc5NZx6FwKHuPYZUcav8wFteQjAC7B+8v+JJFdD6D8ZD/VNA+UfR7tB?=
 =?us-ascii?Q?QC+JnhHEy2DC53C1ikWhbTBUPREeKimzRxNlw15erUMFRaDGvmViX/hB0PjH?=
 =?us-ascii?Q?MMooSvz5aIAdx+RtJJ4G9P4JdmuzkCyJsSUrsOBRBr0rJh0A8L95SN8y+kZd?=
 =?us-ascii?Q?Gacq573UIo/JZvKpzd1ZIQDOJwYhxDe4Zwp5uDXaBOdhGEPf/5I60lweJzEF?=
 =?us-ascii?Q?TWO9X7MuAEmc6vQPCh8aZYZuOivakA6A2dEzhEB/xqVnGukjZdd1T3bsz8bJ?=
 =?us-ascii?Q?5n3o9DOQO00YArhZyCi5+rv/YInm8k2bMoM+9hOcbE1mEDC4kX7/gi1akBi2?=
 =?us-ascii?Q?2pZQse/5Vj83All0WC8KGwaOCjaAarBZzRwX5bPiKmhu/UobzSuuN5ZcvBBE?=
 =?us-ascii?Q?S5WtgWNFUQ8rqDZFIDECFHziaHxpEySmYyRlLKZfMV63fVFP6iAqfhnKrbDu?=
 =?us-ascii?Q?IHBt7CxcrN4u/56wtECgEmMUZjU1iHXeYfsG+Il1nIXM0M0XVuWjbQy9eFf1?=
 =?us-ascii?Q?q+Ta3Vkdy9m/qQ4C7XC8QpCQXOL7y1HlgJmxuca9JelWSZxwfQoTBby5oxm3?=
 =?us-ascii?Q?F6+D51xcYu/TL/hzNsHF2Q5y0+rnRZRmJ2MwJ2PGF2oCWj19rIIgJEaNkrGd?=
 =?us-ascii?Q?B/JnSWB5EfewZHTNDPdgs9fM4KCTKDVs7h8Vz76lNlPpDtM7PnKtdq7GQiDP?=
 =?us-ascii?Q?4g0Eh3OGg/rDWPblL00N+gfaWy9eO3LjlfoO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:21:21.7684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc47750-263e-4204-6b52-08ddef479171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
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

move smu_set_temp_funcs() into smu_v13.0.6 ppt.c file to keep same code
layer in amdgpu_smu.c. (only set_ppt func in amdgpu_smu.c)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 12 +++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h |  1 -
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ae3f7f00c38f..b140f6fc50f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -766,7 +766,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
 		smu_v13_0_6_set_ppt_funcs(smu);
-		smu_v13_0_6_set_temp_funcs(smu);
 		/* Enable pp_od_clk_voltage node */
 		smu->od_enabled = true;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e506781a470..e028046b027f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3850,6 +3850,12 @@ static const struct aca_smu_funcs smu_v13_0_6_aca_smu_funcs = {
 	.parse_error_code = aca_smu_parse_error_code,
 };
 
+static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
+{
+	smu->smu_temp.temp_funcs = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
+			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -3921,12 +3927,8 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->smc_driver_if_version = SMU13_0_6_DRIVER_IF_VERSION;
 	smu->smc_fw_caps |= SMU_FW_CAP_RAS_PRI;
 	smu_v13_0_set_smu_mailbox_registers(smu);
+	smu_v13_0_6_set_temp_funcs(smu);
 	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
 	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
 }
 
-void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
-{
-	smu->smu_temp.temp_funcs = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
-			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
-}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index aae9a546a67e..4652fcd5e068 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -74,7 +74,6 @@ enum smu_v13_0_6_caps {
 };
 
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
-extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
 int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
-- 
2.34.1

