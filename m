Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109EBCCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 20:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE84910EB10;
	Thu,  9 Oct 2025 20:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Li8rUWf5";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B742310EB10
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 20:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1tUUH9UdsmPARrHcWQ41pgMBAw1RF5s0s6I71Y4+L18TyWQPDTkX840v1v8RxL2zGDps/i/Ii0Ae8TwX9W6iGmBD2fZ3Hufw7S6ztBMvLsnu8lXsHZ2hZV4ah6lvZPwiP/Hakz9EKMP6Py3J8Vm8bRWhhgRaZlUPx3G+S1renfMffwlS34CD4RSoXEoaoKAkfvU+OQVE+pJugwVW+ZVEzFkFsKCHWGSEkJ1WDERF5xj9CcwEhi6XVVaCntp3B3L+GDFwPlnF2y6iDX4S7RcsbYgUqazKzZ8glTkmgFYDjt0385Q34TlyCbqkvZWbk+Qg5u0kNH2N/CxjRnwYbUa1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCRMGKaKnPSi1W78dkoNlaZD/X89DsF3qkkCLCy29h0=;
 b=S8H0oP3KPRY0lv9B27e8FLPsliIYWzuSrslFOnsmEHKG7GTLm/N2buPtmLmkhN190WnbGiE4ZGe/PMFC5CZJK0asXJl7BmGTiEe7coPRO1RFPCdyQX2Mdw7vx/Yi96R8owfmJxyeNO1sylb2J8jJ/7+mhKEA6JIIChr5qIp+TJ5gDzIqtyqWRWD0nrcP+AjEXJtOX9INpUV5ztKMIJxVHON605d2d8GNB1WFB91HhWEMIxtMKRRxuU/meqO+dSjaaIf9JNwY9GBAe/iL9Fv2qvVecUNB1j8V6S8ahkenMAHmbfPWDTgLHZII+x/ZWH4Vva52xpNAgAFExWyU+0Fsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCRMGKaKnPSi1W78dkoNlaZD/X89DsF3qkkCLCy29h0=;
 b=Li8rUWf58N8g2+n81Q2+Y87mleKHl/hWat9MPXKP52+FnJfNAaUpFLL07UOdHXpwp0EBH/qNa8sFloc1T3ZPJE+KsgereJglZMD1Jv/r9rh/u7kWwQ/I49FzSmr6TJPXsqs9vJu3R9X79x1C8VO/9D6ffiYKEleMj+ajPrNCOQs=
Received: from SJ0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:2c0::9)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 20:59:26 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::43) by SJ0PR13CA0004.outlook.office365.com
 (2603:10b6:a03:2c0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Thu, 9
 Oct 2025 20:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 20:59:25 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 13:59:22 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v5 3/4] drm/amd: Save and restore all limit types
Date: Thu, 9 Oct 2025 15:59:06 -0500
Message-ID: <20251009205907.177404-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009205907.177404-1-mario.limonciello@amd.com>
References: <20251009205907.177404-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 12aa0ad8-d36c-4129-aad5-08de0776bb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fGzsYSQ/9iO/FfuuGFy4R8o8BP4o/kDiueiLlCcgLujg7Va+as7DUY4rM/1o?=
 =?us-ascii?Q?DacmtUIreRwIpNxVH6RqNG/7I9E5vKDRjejRudvEgcrM7XHdFaDsSXAHeBej?=
 =?us-ascii?Q?Y/54ZN7hqQ1/qiLQVLnkppxEtddmEhZBpWDnYHbxm/T+7sR2jjZVNjTVp6MU?=
 =?us-ascii?Q?vUeqyIu4CKjZQmhIc+hXzgNz1ozl9u4Sz7If8Kq4srSKUN/FV7YrxcdJGK6p?=
 =?us-ascii?Q?7o3932NZRl6cAlgGt+Kk/CAjK/bRRQFtfk4m9l0cxzG+SeyFNYJ18v4mSaLj?=
 =?us-ascii?Q?bzW0rPHOIjbu4uTGLx3SUxz3BOgv6cPg8xw1SNAAxQ2U5B1KjwBV1XQbpkl/?=
 =?us-ascii?Q?L5yTD2ZivVqt7ojfvC2cHbfhM0hWj7N8bvt5fYyw1Mt4RXGDqJV7J0GCPmb7?=
 =?us-ascii?Q?n3nD6aqgGYolXQmE3kwS1gVx1Up72lMy5ZVxlVWrCXR2Fhs5T0Cw53raRQYw?=
 =?us-ascii?Q?AHEBiUpmWwbkZq3naQvUYKKmVN2Kwmww2mo+kUucvTaNHnmWLwsw1DpYWDEj?=
 =?us-ascii?Q?zdsaq0KRbYt2iQuxSDKTCg7TjhzxKfWBZv04O6jKpaEAs6COMfPP7ZRfbfJG?=
 =?us-ascii?Q?451cap08cZ4x+TdMvKrhi9+mMUVKRA+iDNVDY55PVBI+bLAwO5Xm/ogQNPab?=
 =?us-ascii?Q?kB7ZFEU6xcgrcLiPgalikBYs7rVUsHsj3rY/EROMNa9jM1XPFaL/BP2K7i9e?=
 =?us-ascii?Q?phslc88j8JsCtNSBifJhAAaP6dseoAlWs9v4xSwrR2MrHXm/ifbKmPu4aYo/?=
 =?us-ascii?Q?OccWFIwUmIR35HACNsyzRxcZt7Mv4VOZoihIGEeX3hPlzgUSLfUO/c44AZeq?=
 =?us-ascii?Q?j+JnR9PtorEuuhYLfkT7IknEA7OwgD17koKZr03cg6+8zPXjTVOyQ/4w5H+d?=
 =?us-ascii?Q?ereRO2shlLGUwfRcvKsjKbiT60DtZT2KuHkvO3AaQ3eLae8csmQ7VPWcqSG7?=
 =?us-ascii?Q?vIcy1s9SgzqVFvXx7jOItIt1+eJJOKJq3dsLc565Dkg4UCYdlFlOWopmD4OW?=
 =?us-ascii?Q?ieyAlv2JCNOWr1UIBkc+l9+2W3RZtQlBQyJ3GzretU8lEeO7foI2dhsSCReK?=
 =?us-ascii?Q?aHtm4rNOWu1zTnP3RUf1jcgCah9L2uP1bE8uATvrvLvDcdn2kLJaKsK2dAHl?=
 =?us-ascii?Q?rjLcJ8Fz+IAVpW/pG3CiHHaWT2fQpGuafNqMlB1zJWVH1elyMLwl1SWxNyKR?=
 =?us-ascii?Q?8hpakGd6K9e84cZRZqV7E+yl+QJEc7yDjaBp+zjEEbzBD0tjzjsqsQg/Jf9V?=
 =?us-ascii?Q?0AP0dbocA35B7YLf8IcSWgm+20L+sDMyCG/TRlLAoZk1s11nK7KIQl4KvUzi?=
 =?us-ascii?Q?i7kOKRg+o+GMO1Cf1HzSIcXEY9ezv32Ymz+3kpb8IWlaXjLffn5L/QRrwemd?=
 =?us-ascii?Q?/LWm03GtESxs+pbt4d6V7DwqG56BiuWV1twlDmzg72xBMhBEg5ZA96hjUp+o?=
 =?us-ascii?Q?tLy95/JNi7EgjpuSi6YOVU5Nzd7WTrMDr8Ju1xOWj1p0cvhWpjb8L2UGBqmZ?=
 =?us-ascii?Q?0K1XL/qIpqNi0PQpvAZOlG77WcOh4owdqpJl9azA1DFETwDMCmOWWysFqO/F?=
 =?us-ascii?Q?RILvvNxkoJ2oNZVd4gw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:59:25.9643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aa0ad8-d36c-4129-aad5-08de0776bb2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC
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

Vangogh has separate limits for default PPT and fast PPT. Add
infrastructure to save both of these limits and restore both of them.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a55f94b91bc9..ea27c087ecf1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -508,11 +508,14 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	/* Enable restore flag */
 	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
 
-	/* set the user dpm power limit */
-	if (smu->user_dpm_profile.power_limit) {
-		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, smu->current_power_limit);
+	/* set the user dpm power limits */
+	for (int i = SMU_DEFAULT_PPT_LIMIT; i < SMU_LIMIT_TYPE_COUNT; i++) {
+		if (!smu->user_dpm_profile.power_limits[i])
+			continue;
+		ret = smu_set_power_limit(smu, i,
+					  smu->user_dpm_profile.power_limits[i]);
 		if (ret)
-			dev_err(smu->adev->dev, "Failed to set power limit value\n");
+			dev_err(smu->adev->dev, "Failed to set %d power limit value\n", i);
 	}
 
 	/* set the user dpm clock configurations */
@@ -2979,11 +2982,13 @@ static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit
 
 	if (smu->ppt_funcs->set_power_limit) {
 		ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
-			smu->user_dpm_profile.power_limit = limit;
+		if (ret)
+			return ret;
+		if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+			smu->user_dpm_profile.power_limits[limit_type] = limit;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 582c186d8b62..32387e8c138b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -212,6 +212,7 @@ enum smu_power_src_type {
 enum smu_ppt_limit_type {
 	SMU_DEFAULT_PPT_LIMIT = 0,
 	SMU_FAST_PPT_LIMIT,
+	SMU_LIMIT_TYPE_COUNT,
 };
 
 enum smu_ppt_limit_level {
@@ -231,7 +232,7 @@ enum smu_memory_pool_size {
 
 struct smu_user_dpm_profile {
 	uint32_t fan_mode;
-	uint32_t power_limit;
+	uint32_t power_limits[SMU_LIMIT_TYPE_COUNT];
 	uint32_t fan_speed_pwm;
 	uint32_t fan_speed_rpm;
 	uint32_t flags;
-- 
2.51.0

