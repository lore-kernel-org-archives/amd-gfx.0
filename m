Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A104CCD184
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 19:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3155510E8D3;
	Wed,  8 Oct 2025 19:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Ey6OkhG";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F3810E8D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 19:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DASzDWuM4UaMblQPO63E1hSvY7JcOEJZDCCNKPDFN+pwiH3ueTQvBuuhjMHqumDC/MmgnBsupKrl1SaGlva8SlzDcf345k7ELHMJJhlV8rZH8ATXhSyfKPrtgpUYqn2DTGlVnkWfv3G2+ywt7aQWeroT0nq8D3tO3p2q1H+1BPYwhUz7k51jpefSoXCNcRcVyS9R7wnMDvQPk/DRCX0SMHVFnUSTtjuflUwixQzr9LsOcSQ3WWbOAJ+3HU8ZWBARA95ogqVV8WT7oeZvzNIaxh7kWnFLwKedWVbfZhMPhrzLOsmi3nf/ZbDqRDtDsCCYr1tqt8coV/9Ldrbn6PKnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW+VCXp0WUY/3ic22Fc0F5/0163y/tUXFt7zSvmffoo=;
 b=rXib+telt4MFI3ch4ZZIBwRTvssh+SeCCMKt1tKIBxbGMI09UvFiojemP804xHhZCZIJY6v5Nuea4FY3sf0LXhGMo2LF64dke92wGmQIOUDBJd/m9bF02x86IhGqIhtwlgpAwyAyXqnnL4lS9dIFhqcXJD8gxU+AbgECYKyE1SvEM1Tbqh/C8ldM7FcOKOml3GEdfopMIADq9KSpVGcCwQR6ay3k6zH+OgKmT1tI+npTyoyWMHdlDSjxsQWYCEIyo8UXOLOX6yIhLyKG7bZZnkWP56KHMg3pWPg8gqJaveFMkeMjyhU6zuN5ZFXtzKz1uz+AOn9TiFos/pEZXdRGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW+VCXp0WUY/3ic22Fc0F5/0163y/tUXFt7zSvmffoo=;
 b=3Ey6OkhGk6sK0qarOymJTNgG4xUwZzLk/qcTPL7BHvo9riF91+WEfbBd/OQzXojAqUNaofd32ycjmIINJuEGnCooOuQE3g6yndiyZW6TgapVZJUaxGAbSO7ABr37fSMJO96AwTFB3lMGn+rOuQ4DMFnHonLLffluwFfOuvUZW9w=
Received: from BN0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:408:142::23)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 19:12:32 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::56) by BN0PR08CA0014.outlook.office365.com
 (2603:10b6:408:142::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.19 via Frontend Transport; Wed,
 8 Oct 2025 19:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Wed, 8 Oct 2025 19:12:32 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 12:12:14 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v4 4/6] drm/amd: Save and restore all limit types
Date: Wed, 8 Oct 2025 14:11:51 -0500
Message-ID: <20251008191153.3145554-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008191153.3145554-1-mario.limonciello@amd.com>
References: <20251008191153.3145554-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5c656a-427c-486e-5c3a-08de069ea209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EPWVIKw1voOVkCDdBcz17Bl7yhdxPFLB5hbW0M3kws/S08CmNutMTpDjxW+b?=
 =?us-ascii?Q?dW87+QmcBWNbC4Sp6H32bOpN8S3P5cpSUlHvvalhPyTSet/3uE/uGqJfzgzR?=
 =?us-ascii?Q?MxVuBicCwBW265tasVePj6CkwWm4k31EvMM+GHHEvE5z5fIcy4u+hQp/Hlr0?=
 =?us-ascii?Q?z+Qp3Bh3lJ4VR23yJ9u7U2FzMlB8rYZP7CdpazOGCoPo0xr6zIDnG+yCyBtd?=
 =?us-ascii?Q?RwHD5V1sNt1Gz+hdN1GRj1tUGichoABX6sdkqYeIDDN5WVva2gwVjtADmwJY?=
 =?us-ascii?Q?cSx9z/mB9Iev/1rjruuucoWqG7Z6lMiolt4KWmmY5iMQzEY90NmEybmgZryA?=
 =?us-ascii?Q?GXZ21kE9UWIRT9whRImGCdL6scmdsy1IXGPqi6Okr6xa4JBJNJS+Bde8ug5c?=
 =?us-ascii?Q?JgZE0cl5fNF9sWjn3OfQlGW2a7dDMsbo9GS2cL/PVPBtYjPEK4bNcIs5wWK9?=
 =?us-ascii?Q?anYrePQHOSTyy5Pq6ZeonbG4QSZ9M5PTjFSfGwLmGxr8Tf8LC5pcf4yAGf+7?=
 =?us-ascii?Q?pKalrWbZOLtF8cdQ5yzAux5BXCP3/xKh2UiRksH8sfgG+mWd5GMoxil2bXeX?=
 =?us-ascii?Q?e9l3bHUgPwQwg0/M0E7Ry4s6zHpr4op3rIQNqBbW0yGqUY/gQnFtCu3cxzIT?=
 =?us-ascii?Q?W4wcpLH+K0ai9FD+zaXGN1VlGj/RTxZOaklYfRX6kW4kMAMfUJ1TAS356+AC?=
 =?us-ascii?Q?rtsL1p6YxJmikjilNaCE7+Ta9xFWuTfMXwHOIFaEgsqiNgZRMa5X5nqg4mOb?=
 =?us-ascii?Q?vrb8NVBRaw2uy0JyWxvDKZ7hex21kUsjfOA5sNUapCxMsFycrGbELFu17EcO?=
 =?us-ascii?Q?a3nz60Bpu8pz6hP2nJSKwxTtPok08J9SG3n1MNGjgyHOWrvk61yrSgiLOAM8?=
 =?us-ascii?Q?79r+aRYsl7oUg/8ixq8FYgnmSnuMCWiWwlvEmNDjA6adP4MbHc4i7AOCAe99?=
 =?us-ascii?Q?BfMiTU+QWVLrMuKeQsUUlD/t4KUrHKwDny4ezyKFFAIhvX8J03rywEKIzOis?=
 =?us-ascii?Q?2lf7a3Q+1ljTGgf7GeeyZjVOy7jtjYzDUHESvDvtDSYtJbmFOOl1Ux8Z6VX/?=
 =?us-ascii?Q?SiI6EQxqh7xLiqX07A9Y9ASQMfFnxDXvYWxZaD49XtpS+RthfnJnb9Q3WCXa?=
 =?us-ascii?Q?6ZHbBEt9hITY5kl+sTz4DBQGTrc8gCPqjh+Htl0L4rwwJWbTLsgsrLh8M/CG?=
 =?us-ascii?Q?Y6JGy1k0S4xn6wrRrnK+zJHnI2MwH6u0J7A1uMhrGhrpv7WVlpt64BIEcqac?=
 =?us-ascii?Q?SoORJBShatqTe4DJCJxkDgWJzIVT4zWW1h3+qGAtHU+iqxIUWAsezUUVGS+O?=
 =?us-ascii?Q?9nr7dxtseSyi2XCFpMqz+lZoMqDN+2d9U1lCjWD6WW3Wl7p8aBpM21q0Lf0x?=
 =?us-ascii?Q?UddP6v2socZIqzuTJ597GZLZ2GCj7qoLBRfakWaNcShklwqKbXku+ij2i2ZS?=
 =?us-ascii?Q?7V8am+M6veEYCUeQ69SMvVCY9Z4D92kuxwKOc/UZ5PqfYmN7WITUA95D1ESY?=
 =?us-ascii?Q?I1hp/tlCGJqPbeZi9SU4amoSTCnNa3mdIMZ1ku0rRtZlYzKByqClCDSCPcEx?=
 =?us-ascii?Q?o+6Byu7yETUKlUH7LKc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:12:32.5884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5c656a-427c-486e-5c3a-08de069ea209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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
index f946effc1776..e0006fb4c94d 100644
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
@@ -2980,11 +2983,13 @@ static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit
 
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

