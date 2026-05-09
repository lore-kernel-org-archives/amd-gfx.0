Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652BFCD343F
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2026 07:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D051310E054;
	Sat,  9 May 2026 07:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y1m/bhI8";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F5D10E054
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2026 07:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9Qda9jANYREwikX2wJY8FBKqY3qFwIS8FqWwEItQ9sDTW1f7n+mbqGIvAZD6FMqWF2/yBjmmCXMmXowY/EDIIHg3LdO2bfaej2hlggk5G7AnxuOr5z4JXWKeFkgP+dMQSJ7E4ttVs8aqmL+KcEcYlC1caiHU0NaQB+HYzXDSSxCEY1KCqvrl1rZQalDjbT9IpVlb9FdKx26YBNuW6zoQQgzF5KwbTHzYixPBTh53FLE3AlTOEVnMqDP86AyZDKWUT/hbsALRSk3fgf887+X7EB+JdQOY47jGHONSbktu1HvOzq6mmi8nzjERhf1YYzspWjdE55ejl51Q2W0BEjW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=savIg1ceemFXUBNetypeGYJr0EsvaPs+DPT9QiPnY4Q=;
 b=DX4lX/kZZq4iWL+P3vd7r+tNePNguM4wjeh0n77Bmq/cRpmOcvn5zMSJagcztYjcS8Q4UjPolApIioAL1xuHBCSwK0jHoqMo9HawH5/MMA+qtGzD5HDYTOmQaD1sl4bV+WIrTmT7AHrVhIppJbIJhJq1t34YxCSMQnf9ZuezE2nmnGuXqVgqxuw2u9JNFn4Fie4Lu5aj8mQlTy+5ZiTuelARZJwBwmTFxyrtA/DrVUYG/lEzWyey+o0tNEJHOgiUGoeiigSwyC+2ZKXvJMM2gcA9MdkQvxAxD1t8o2mHU1eBaNIBZZ8eUQxGixPuBJD6tQV/sCzZfeU11MrhXDNl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=savIg1ceemFXUBNetypeGYJr0EsvaPs+DPT9QiPnY4Q=;
 b=y1m/bhI8u4c6Tt+xTNbRGcPqdRKT3LxxUOYbj/zMWmNKwsr/A6uG+UF/83aJP+ZBgezg+pVWbDeoINJedDENtwTa1onHJYmcWT5E1jeEdFzrqu/NcGkMN5sHDA+Hq+UQp7z7zUuMG1juvUbxO4qUe+vr1n3xbKa0ynn0MzNXHJk=
Received: from BYAPR06CA0062.namprd06.prod.outlook.com (2603:10b6:a03:14b::39)
 by BN7PPFCEE68E7BF.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sat, 9 May
 2026 07:26:19 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::5f) by BYAPR06CA0062.outlook.office365.com
 (2603:10b6:a03:14b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Sat,
 9 May 2026 07:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Sat, 9 May 2026 07:26:18 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 9 May
 2026 02:26:16 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix memleak of dpm_policies on smu v15
Date: Sat, 9 May 2026 15:26:06 +0800
Message-ID: <20260509072606.1663716-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|BN7PPFCEE68E7BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b0f93c-ee8a-428f-7d1d-08dead9c433e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: VWLNITA1CWMOlWPI+dFn6q1PoUg4XVA+9vO6nt3zqRN4ofExSoapnhn4dheDpBmfI92I498cvYOJGdUELwSJ5eN8CiLxWekYxV9NV2x6TdE6n5aYECFxXAW9vahAQ4lKTK+tH+wvTEP5KDzOYMh0GisJSC1NvWSP7SP4Cl5g0uMGBZU1DiqWlive1IJPnj9VxJo07Z2F/kZGHRgWTns50pnyG/myBtqNmhnRabZnO5yAsXRrg8KAeRmZ6NoENv+ElzZ9SeoDM+ZO3kIHur5G0fb/2Uv5p9w6b4NR68ZD7UZs+W+sqv7wfBZIaH+4EB1P0uk3f0oMJiwyDjek5sv8kHCRNKTm8wfypdAlZElbr85CTnJYNG5v2KyTPkrkHBX3doQ3o3opafhvq4ZYpZaBGVRUI2/N6islcKcXJNzHK4eqgetP4i2kAx8guf9KNY9Ua29uHL1rdqRsLoTN/sbM06tkdzuTsqBrOPwOrXdCzzuDKHiWm3QCPSylJ+wftlyBHGnlUUP9BWKKuQrTetlArMXcXzCQfopsnNF9ERArN9HiT2QHz3tfpHvvmI6LZjqFCSUq0py+hAuOefM7BPAN2u80AGc2oUA9rMJ19bLlEC5CJl6sgKR67iWvB/zKsU3ReB8kAjgIlaFn0MuAm4cFR5+m9vpDAhVc45QfsUHPwHj0aL9aOs2+FvnxWHbwR3J3fLb0V7mX0NTNTyXIbCQvsjmYzMNjVSjcTY28kPLpEGg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q06sNzzjP7RqZG+XNw1HpJCnfckfuqiO+5fQP6SMC95cD2Nd4DTiTF/bhGZbN3asN4YQSpSd6rFUBTgukK8ZhL2Sesi9p50T3V2Ua+eRdAl/WaTUq9N8h9W2I2FVyXU9vacIxlx9ERWTHVgrFd3m0RC1XTDSy1yuDHYnROdpoFdloH8h9oNnW0533kKJ3XOSPvpHu1XtwoS4IoTaZyKpgdngn50FMz0HSGKsvPojtCnHEnNgB5sqRB6+T4eC7eVxVg1G86uql8tRVSi2pv0+J6+B5ylcaQ4SUDeelGxXC233o5YyIJsuYoj9MBpStzg+ZEEnapkarBmP4gowwyG6YMLC5BogETEcbUrrb9OCgJcjemiqWnLCm4ybnx1FAa8800Gf2J0q3zPnZmU5O+OwLWV5yRDOVhjMRfh1bguFJC8eFdFPXRb8l025hPWfA2j0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 07:26:18.7021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b0f93c-ee8a-428f-7d1d-08dead9c433e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCEE68E7BF
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

In smu_v15_0_fini_smc_tables, dpm_policies was not freed or NULLed, causing a memory leak.
Add kfree() and NULL assignment to properly release memory and avoid dangling pointers.

Fixes: 46a072ff8ee6 ("drm/amd/pm: Add initial support for smu v15_0_8");

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 4f0c94821e3f..4a61e900131f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -435,10 +435,12 @@ int smu_v15_0_fini_smc_tables(struct smu_context *smu)
 	smu_table->watermarks_table = NULL;
 	smu_table->metrics_time = 0;
 
+	kfree(smu_dpm->dpm_policies);
 	kfree(smu_dpm->dpm_context);
 	kfree(smu_dpm->golden_dpm_context);
 	kfree(smu_dpm->dpm_current_power_state);
 	kfree(smu_dpm->dpm_request_power_state);
+	smu_dpm->dpm_policies = NULL;
 	smu_dpm->dpm_context = NULL;
 	smu_dpm->golden_dpm_context = NULL;
 	smu_dpm->dpm_context_size = 0;
-- 
2.47.3

