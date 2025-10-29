Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0778ECCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A231F10E70E;
	Wed, 29 Oct 2025 07:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vLiYH8d3";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8600310E70F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDJtL/HBAiKtHZKtUkYXXTFBUCYPbOAnUmFIu3XUHbz5kssmAl+13nqeXAzZrI3xpYDjoxFUYNevJu4HAB1zXU1Gwnj4/wBIEelZ2M2VwxETlweVGEAORUjhhqtXfD5nCfpyRttHXMIJpB7sxFbvP4/cnot8eXZIMJI9MLkPeNaXr2JEbHJ/kYTPPuBZaUeSZK0NTjYYKqp1sOHe+A0011HXeCcdMzY1OPgxHrkC8/OdGz4urbeyBOxFHveF14YGPQ7BLIVF8lO+FisQnuRRPX44/TdTb9Soyq+i4snhnOOYH7fHY42F54t8vnToaKbuGvCKcKKIO8oV9QveAho7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kH9g/BR15X6aZzA/yJ8FjDaoLSBXv/2/g+pMQ2iyomc=;
 b=fmmAHIbUAYE35e1uxZEERrteQFA/3Q4QyB17I1e5icce6HMrEJAZueigIMaSwj0nI/Og/zw0CTjB3+EkpOlEK8UArdVgPktjIT/sAmzENCRGPHj600pC2+Rq/EZ3JTJKFIW/9TLivg/dgA1A+5oO99xqFmCNCXONDrVitlMUO/c5LMyswbJfI/Ynt01S1ZUF4JIuooZmlH2Re/OyLAjgkikAOyFZjaPVSULqOxkIOnG6Qidlr56DRMreBuIe9uiU6yBbjL5Q+O10GxSYFAu2HZz0fDe7UsYf3C0SCt/kFaP6uX/uHhsGT2J0VSZt3XvvXJn9vwgEz/XnOeC4nVIJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kH9g/BR15X6aZzA/yJ8FjDaoLSBXv/2/g+pMQ2iyomc=;
 b=vLiYH8d3aniSa09/zgPP+gyeDwbuGHAwptyj/dL1czLfHwFHXQHsVMhaZjrmALIdC6cCOlmsduf3ROxEfW6a6awxz2cSSj6o+i6LkDGVrXnZQ3KP9+ihSmvVRKTKTFw2kPzuRgibJMRJyukEvR/lzJu4fiAF7QE5DTklqB6w+as=
Received: from CH0PR03CA0330.namprd03.prod.outlook.com (2603:10b6:610:118::22)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 07:32:13 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:118:cafe::ef) by CH0PR03CA0330.outlook.office365.com
 (2603:10b6:610:118::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 07:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:32:13 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:32:12 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 10/10] drm/amd/pm: check pmfw eeprom feature bit
Date: Wed, 29 Oct 2025 15:31:08 +0800
Message-ID: <20251029073108.1698129-10-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029073108.1698129-1-ganglxie@amd.com>
References: <20251029073108.1698129-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 69df9ebf-1355-4d8e-f261-08de16bd478e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e6DeQRR/yXCnWfQLGgj2BZH6Jlfp0vxPKXYqvC4TO507uPMo0Zwd5p3dcKlU?=
 =?us-ascii?Q?uhO90LkITZK/C9XtlLN1VITphNQg1j6x1PnpnhUmcTz4zbvanIgiLLg0lN7k?=
 =?us-ascii?Q?1NEgFVNQ95nlW9pAHrau1N2FDP4NutPa+YBxIbeA1fB8RGTrn/UYXwMvxkNn?=
 =?us-ascii?Q?S00cfeUzWRTDhfAxgeE2sHyB8hfgvwbdN7hYqJqoUg+/VSyA5BbbiQ+qBIr0?=
 =?us-ascii?Q?7IZqW9g9JWsIDh+ePjKzSYu0udGy+c3S18pRHi/+1IaYsm++IYCrS4om2JaI?=
 =?us-ascii?Q?zvuxaWWJvrNqwtRSl0Is/AZdzeNLAbXK/7Xe8oUG0EXzsXVUBTMEuoBGWQPX?=
 =?us-ascii?Q?WhrK2rD8JZ6cn4RNhFbbDzkzNqzVU8GIlUsjeW4mQuGtZYWxefbkZA2phSyb?=
 =?us-ascii?Q?cCpvVy3Qz0wu1rHXjw66ahsR+CpHlTaCS4skKXss/4NN83v1nLt32WPwOgJY?=
 =?us-ascii?Q?r+jvyQH3sqEwNnxvdlEX/rY/bFoCPiXxKelSko6kocVMw5RNNLDuagL9X1TN?=
 =?us-ascii?Q?CTutVeaTOtzYokht/bAOrgPp/e+X1XIahEylaqluCccJzcNzb8DVN7ZywhoO?=
 =?us-ascii?Q?FymxXJNKFR4apAEF9y4nhFWfwcc8/stVso56aQseXyIFX0OjPCLd0nbESHqr?=
 =?us-ascii?Q?GzVQ62MnOgWIdcD6HXCGSGG7PBsm3NyIER4qqkyXDqayWjSv9jIeAhiV7HTr?=
 =?us-ascii?Q?hXlOVEl1u/AnN9XTwQo3OHsvSdGb6HfDFT6KaCWt4aYqTlMoBrYX/WUk3wK7?=
 =?us-ascii?Q?bFnod6hXAor2dt6+6PV+i7WuXPrpGu7t7OHyfEQ1uiqs/F38QlSvmUeQc0jO?=
 =?us-ascii?Q?NVUm/FNn14rbk2u0jVNIcC4LLaWAbsy9BbNi5OoGZFO88EWV69KckgV1uY6S?=
 =?us-ascii?Q?AHOCdOkrpvtu9Zm8yYAAWkDJQsw+ZkXrxG3ZF8RDZ1RSGYkgD6Bm9NrKls6S?=
 =?us-ascii?Q?0fi8fNf2wD/6Rmra4vP5ldMCnBsGr4E2qO1l8IPr8pdXgD5LYHi342OWB8mf?=
 =?us-ascii?Q?dTl4/d2U0WYYL4WNI6WqncieuyR/1ZXf1LnifKc7stH0qDA5SJ3ocQafnSzC?=
 =?us-ascii?Q?CtoUgHUzTxrSR03b+WLa5eek5cJVJsANXnNxj8FvFsXuljNx1lNQnW/hzVdE?=
 =?us-ascii?Q?TxAs2BjPSjOWKUf31V6gT8L8LHPMLTlL4H9vRk7yFVQ7WY4Y8R7q3grlVl8d?=
 =?us-ascii?Q?Gw3/acforjfJbRcG+J38eV0KnbE+A0oOsm81BN2MsIZCAKbfgUzHj9lKZLtB?=
 =?us-ascii?Q?negd9z709DO2qnU5bjLJkFiLOB2SoVnO/Lr4l3GAuTkK2IYCST83CyL+diOb?=
 =?us-ascii?Q?kVftysAnqGDUu2iSmpSj5UDhOJNC3rl/VcjaDYs/W25lgH0SE7afIXZMrNf1?=
 =?us-ascii?Q?HyeHrK6Z/4fFu90AFY6W1gaL5VIVsGb/Ybs9q/7675ghsw6ZV/3gKJvQ6VQE?=
 =?us-ascii?Q?HIRBtPZqSVGltdfJ9ERHEVQl+C2aQNPKvb7O0x4JX8S8n7S/Cf70qGbvVnti?=
 =?us-ascii?Q?Y/eI148vBLA781sNzz2s7tREY4M12P0KzLKql4AdBOUJdszEejpbEECm81UZ?=
 =?us-ascii?Q?WFGkx3T6+WnKZwYWpmM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:32:13.7843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69df9ebf-1355-4d8e-f261-08de16bd478e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
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

get and check the pmfw eeprom feature bit to
decide if pmfw eeprom is supported

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h   | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c      | 7 +++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index bf6aa9620911..fa43d2e229a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -87,7 +87,7 @@ typedef enum {
 /*37*/  FEATURE_DVO                         = 37,
 /*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       = 38,
 /*39*/  FEATURE_GLOBAL_DPM                  = 39,
-/*40*/  FEATURE_NODE_POWER_MANAGER          = 40,
+/*40*/  FEATURE_HROM_EN                     = 40,
 
 /*41*/  NUM_FEATURES                        = 41
 } FEATURE_LIST_e;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 9315ce49b396..3a3930ef7ed9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -465,7 +465,8 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(GFX_EDC_XVMIN),				\
        __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),				\
        __SMU_DUMMY_MAP(FAN_ABNORMAL),				\
-       __SMU_DUMMY_MAP(PIT),
+       __SMU_DUMMY_MAP(PIT),				\
+       __SMU_DUMMY_MAP(HROM_EN),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 14b46e110730..16678efabed6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -82,6 +82,7 @@ const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] =
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MPIOCLK_BIT,			FEATURE_DS_MPIOCLK),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MP0CLK_BIT,			FEATURE_DS_MP0CLK),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PIT_BIT,			FEATURE_PIT),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_HROM_EN_BIT,			FEATURE_HROM_EN),
 };
 
 const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] = {
@@ -1060,10 +1061,16 @@ static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
 
 static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
 {
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
 	if (!flags)
 		return;
 
 	*flags = 0ULL;
+
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_HROM_EN_BIT))
+		*flags |= RAS_SMU_FEATURE_BIT__RAS_EEPROM;
+
 }
 
 const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
-- 
2.34.1

