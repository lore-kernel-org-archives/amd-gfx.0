Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206F7C43327
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E0B10E16E;
	Tue, 30 Jun 2026 04:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8dMNB9j";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD4B10E16E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWyHxbXKEMLNhNC5l7Wqfe+8RHqFCtordAVkm2/P0T7DfbsPYqo2Ojd4Ts5ui8RQ6bEtqt6OIJV5OhYFuTsZ7hkqlcW9ZjTpDFXtPnKrGAR1jNB+h0z22ttxpiLegwLRG9qlPQmtgBwVe3Ga4T6IODW8FaI9bQneChf8PSM5u61DYjekQGQ66XgzxcXALoTd/pdFbnQ5f2aky29BcvuQVFuLz4f0m4GrXjUZHtRzGhYOot0Tjxn0wSU5+vDOjPLhz1kuxrr4P/hV1Sf3CKWQ+57R0GnIPEwffkjErnoGfBsomEX6klUFOsUSr+J5M6QAwQ+lW9goVqDo4k7IEuqf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7OaWjqcRS3wfdTqeQiF42lLQbYigtOhFyv8g5Nyi+4=;
 b=eoJHNxkF+GW79osi9kXin5VfHkGLIOof5MBDAGXuxFlt5A/Gjy3amlCtYbz3sLBKYDqj1Aszdz3SmkvuS07HZWkrkzzZr17PemUmoHRc+AgDGDBDcV1JjgU53tMJE9CvwpKVyigNKMDTTkmIdTp0MbNw04gXiKvv81RH+HjPOKekTlCEgYticN6vFm4xJxcAyz/4rAq0cRxiVguUeci4Kt3IjM0BFThygWMAti3DvTTL0mBmdyk9DnBLoYAK7yz83XBD8ZNZIxi32LPbXPrnDup469rx/paCBTy2gEgd9CQXWcG0q0NVi5NQvSTEilFxXn6cUExje7JHFDGsMm8Y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7OaWjqcRS3wfdTqeQiF42lLQbYigtOhFyv8g5Nyi+4=;
 b=L8dMNB9jvlQ7HuBemCbpfm/x23fZ7QixYWpZmLR7HsxDBqYFVKB8V4HcVq7YLMN6JYtX4a/IqzoeR0KSvpY4C/lPWIqk6Y7p0jeBXn+wuB0xadjJvQbrpTtLYyh16nMNaZ+JUqTPrkIFQHUFqekz2qky7IhjfX+6pkFUw05IJK0=
Received: from CH0PR03CA0298.namprd03.prod.outlook.com (2603:10b6:610:e6::33)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:37:30 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::45) by CH0PR03CA0298.outlook.office365.com
 (2603:10b6:610:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 04:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:37:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:37:29 -0500
Received: from granthali.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 21:37:27 -0700
From: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Pratik.Vishwakarma@amd.com>,
 <Suresh.Guttula@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>, Granthali Vinodkumar Dhandar
 <granthali.vinodkumardhandar@amd.com>
Subject: [PATCH v2 4/5] drm/amdgpu: add support for SMU version 15.0.9
Date: Tue, 30 Jun 2026 10:06:54 +0530
Message-ID: <20260630043655.1284069-4-Granthali.VinodkumarDhandar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
References: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ead4b2-2917-4fc2-bac5-08ded6614b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: RkJBGOcr4bbrlGjp4uXcr2ffiDt99tdLmVD9UBiL3SsTGAkyeHTpo+YqfgRtfeoJoZkQpIzY5SFO9NfPQulH+49UI9P+YLBedDWPBqLnMqZbjlz5Ml1fcrXMPYVvRp9SKz5/f8HEhZ6dn6mJNKcQNEKYOueH3HsyZAODYSM+DTFa8t/4x6HOx4CVat6qXTnWGxLjA/w6ZvxhghQabrttGMb4GDZ3DX9wVWGRgoDBikXd6Lf8kGE5xKYKK6worKL5mHD1Gh6MsDBXu8pTQ6NES87gdM/KPbF1VUR7y2XyGCKzKGfTPJTSyZq8Pv+nK6/bm7mHjg/a0IYuu58b83TCMIvS4h+pQInX6bZ72s4DGzR8109S1elHPhEdfWgR/e2xpBpd8MmJ/pvSTA4TOK5zehOR6Yvw0CiYH5bW/r1PmWOnKOs04oVZ0hX508n4e+yjADdxEzstA45fN6tBr9L1JLWD9MlKbeUMws4uBhrYlghU39xZbQv+ch1SdTj0Lui4iFA/MHsPpjBzB4l7wSYlIuTRiIfRKLVttN+2MlTZuuSO2UsV7xVdzoGE8Om9A9096O65vG87c/L8FrDLvJYiR3NPMgWo6iesfMULbdQ5Dt8jfEiH8BwqhIAsqCdDs3/OWMAU33ebutc7BZf3j/kYeiDceKGghts4j6TbeDX20m2PrQo9S3rBinEwTvInDDTKw4K/pys+HPbZkmbSv1rICQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xVrnV+DgRNyR3kPHqmZO2I6eQ6WWdqYuegpxI2kKxV+P5ZLG+QygcTRk1xENjrJKmDDITtIJP3w1q72edgeBVhBv/OGtZlCXC1LPta4v65lbhKzKrf35EerItC3NJXNAYPPkDLIXxBTS5McvueqAnH9ffTaSqGa3lgyKSefLy+HF0ZdCSJK8Aj1+P6a/YxjFmVw0ZJt3xtSFe7RNaJyT26uHUCiEr5+SDKt8R2Mhfb7q8jqaxf2KxRTuBAJCgE7LDwp9CcydgZLEALVP+TLHd6BmHA/pReXxUpP06udbLBXUx75ZqjMwOg7qTKbzYNxeY/ibiSsfbU+uwq9Ujj86KASun76ZysjXLXStdI/eMj2dY1/2DFKgHXzGe5+7r+buNN1HoGNiK2LQ60aJIwV/I1Ku8XFcMpgfi2ShzPpOGCDCHzuz5T/elVWH3S6oFH8p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:37:30.1136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ead4b2-2917-4fc2-bac5-08ded6614b98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569
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

From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>

Initialize SMU Version 15_0_9

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c        | 1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c                   | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c       | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 3 ++-
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 16606155a92e..b309c9fabeaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2593,6 +2593,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(15, 0, 0):
 	case IP_VERSION(15, 0, 5):
 	case IP_VERSION(15, 0, 8):
+	case IP_VERSION(15, 0, 9):
 		amdgpu_device_ip_block_add(adev, &smu_v15_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 1677e88a4e36..a2733d1637f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -406,6 +406,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 4):
 	case IP_VERSION(14, 0, 5):
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 9):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ae44437af86b..c0699741e711 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -802,6 +802,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(15, 0, 0):
 	case IP_VERSION(15, 0, 5):
+	case IP_VERSION(15, 0, 9):
 		smu_v15_0_0_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(15, 0, 8):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 4a61e900131f..ec7c72983224 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -665,6 +665,7 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 9):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 3cf47ecdffda..4033012fa39c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1177,7 +1177,8 @@ static int smu_v15_0_common_get_dpm_profile_freq(struct smu_context *smu,
 			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
 		break;
 	case SMU_FCLK:
-		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 0))
+		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 0) ||
+			amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 9))
 			smu_v15_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
 		else
 			clk_limit = SMU_15_0_UMD_PSTATE_FCLK;
-- 
2.43.0

