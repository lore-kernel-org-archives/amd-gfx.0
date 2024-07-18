Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C2AC3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 03:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC8E10E4D6;
	Thu, 18 Jul 2024 03:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rk9LqnHZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC1010E4D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 03:20:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKSvp+HAiZbSyyyEaHeioqrzPtrOYJAVNlGfPwUkJOalnbMZ8QntCNoz8fmbtC6TTPiYka9vc62M+m1uEiIg4firidh/P6iO4TWPxFqv8hnnZkbyosjV8p6qtIUn1oC37Lj6ySwOED9NoW5z8lW1OZkSyQTqhJlM9/j5olkB5dFkYmxru4fdU8KPj24ueOEYRfoI/RGXtZryZVqJa2cEa2yJFG5K9AfJ7jt8GUeWPJ3UEaxgPnwVhzm7noaoP3oslgmaqgY4uMvMqz0ozdn4S8rl5QeA9evOebqFV+lfS/8LATJuaTUyjUe3i0OBmAqqVleJZc/1niGaarvhDslZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIRPevGaL6/1R3VQlN+wnWWfp4SgtcpwYFx9vqu4xOQ=;
 b=Ksr89f8FuNBn98Ot7oAf4IvOEXLZwZ6QMHhR483v1G2tJEwGnFlrr7YL3EsCf/Fbudi9SGM0z21ePJBMCdT+TBpS7dFws1lYKyLa+d2CnbjgO37Kub5MwHEZutOX7og+Sf8nT34t7TFFoWng8HYC0RdOZkvVWcsyq9GOy0YrUmp7MK+ujWUmIbkRUA6nSMPkNxcmxcHwGWy/tHhHcqQSiiEpvmL0vGD3rZ0iXsRXN9igvL70zU61ifTTl1LbnZK7sUsWwG3ZM+0A34qWyP4Mc4lR2gPdM8gQhuanmRLPHcNT1nD4mA3txa7KKgYccc4kpAyXbsvd4kN+Gj4HdQuDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIRPevGaL6/1R3VQlN+wnWWfp4SgtcpwYFx9vqu4xOQ=;
 b=Rk9LqnHZljHbqKMAQr/yazePFAL5JFJMP6Ir5Yx6u2at/OPWCAFl4wuZl4kEB2SzoKNu2athSL+8lmr/An9lK+Pk7LsiyCOlD7doUhKbpQjard0rQuFLsFCk4L1i0nxqVsPUPoTztF4QLlGS9jEmDxhEYnI3DZyt15qQryHi2vo=
Received: from BN9PR03CA0784.namprd03.prod.outlook.com (2603:10b6:408:13f::9)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 03:19:55 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::bd) by BN9PR03CA0784.outlook.office365.com
 (2603:10b6:408:13f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 03:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 03:19:55 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 22:19:49 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count
Date: Thu, 18 Jul 2024 11:19:32 +0800
Message-ID: <20240718031932.1353653-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: c6133baa-7a51-4e91-bc74-08dca6d87edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zQaewVcW4EuGLi5rjtrjBAahGgtcZNuQZKDTWgaLMR8iH1abFFzR9yvlFXLb?=
 =?us-ascii?Q?UTnAdOL8FLQgzOW+e5rbCzZYlZ4hB2b78xXXYs6l/v+XvvJTaFGbrCv06JVF?=
 =?us-ascii?Q?3lL5inmE54owRMfjfPCdSAXIKmZNC3wHd5/cKybnjm4UJZ2yeSsrhaQR0D9I?=
 =?us-ascii?Q?xJEqCfvxHRWmU+CGa06xpyTdAFYLXGD3VmpNj1BSHpnuBUKKGp1BHhjA3qJg?=
 =?us-ascii?Q?kaEbnDKOV57YxKJGjhqcPfZrLbP8gN93wjGTtKvZ8NNUnhEc0syERrCfIkfw?=
 =?us-ascii?Q?pw8wRu7BOqosG24r7JcafUVcBbgmEDdtoOgkyvRuY6BXzk3vYX6EwFB2XIoh?=
 =?us-ascii?Q?VWllVj16gGJHrmjcsJ9/KzPs6fzYzOg+cyxjAf8kpvPrMh1S7UhKCVRmvViJ?=
 =?us-ascii?Q?3IHHXNc4bwidGclAPiC9bx4t3/qNFO7nEoHg7DwsSFRkPRLNgjNEFPrLCZjA?=
 =?us-ascii?Q?dxQhJVFvcPsFD+Fr6cW08OhvZYn0+YACez2+c6xcU2rHxcw4sqhPHPuKgxq1?=
 =?us-ascii?Q?f2/8X2sAxR8jSG9vF59k7sA0cZbuOsN82+M/3RyXR39FM3txuN9M9qlfrUVR?=
 =?us-ascii?Q?eKbDuuRyn/VYczWYeiD3HtYHPchW08MW1Vs+iLB+vgkO9N83ygDRn/J+VApc?=
 =?us-ascii?Q?xYBi0XDTHBSX355+Cyar1x02Qtsv4eTIerxl0pINNSYfDmjDJbnlhl0x/yYR?=
 =?us-ascii?Q?fXp2ngCGn8swDva+MAZ5Kyw+dlU5FTlu2UeTMLI9RolZbLG+pTij52XqqU9N?=
 =?us-ascii?Q?Xa6ObEmd0CAziTlYLf4xR+QLwDqFD9qNC8mLVIpMwcDkIX5NNJo6PFVq+dxf?=
 =?us-ascii?Q?CUmB2sGaHQuuB/fouHQL3cQ+bCftiONpf0WN48wAxGSFhQP5iV0+svMSsFZL?=
 =?us-ascii?Q?gcEKQI9gOgdDZEAWnYUO/uxoPnVj88zIub7rad1A2FZazIkAcGuK8YHDJhBq?=
 =?us-ascii?Q?CRqWO+nMA5IWcWvWlyOI5tChaBOMTnT+C51untr8oTn5NTTMniirupAgkEH7?=
 =?us-ascii?Q?bkgo3vLtolzfopiZHRcZpnras4WuplC6BXEnYb9CoGWmvvj4L/khHEAElyPq?=
 =?us-ascii?Q?wdyRVnJNB0cNi+0OGHsxFOaL4OMJZAFDK/ldRgOD3Ru1cD0R9OdB5MTropU2?=
 =?us-ascii?Q?+MMB/r8Pl8JlTp0ZlPmNKbmd/KFqXmG1JZj/8yEOb8nume33F/shDX1CfeA3?=
 =?us-ascii?Q?Qc5oYdYQotmcKM7q9gr0WK1kKA8V1pVTEGmyRFU9zWQKztE102pgPGvqyptU?=
 =?us-ascii?Q?G5WoYdfUe1ugCpq3KkxbOo38dVxdRg+1c+q8GfVKvstnP0mFa9h2g5TaMsiV?=
 =?us-ascii?Q?Hq33LKjumqzOP7C6jLQ/28eYwWa/rMvXzLlz7EqwE93kwUxKbgcrqeI2GV6I?=
 =?us-ascii?Q?3Yd4OC87zXs/QPyevc0jTSt72h1/+24QRLNDKBYPSeL5SssoH+3aR8aeXCig?=
 =?us-ascii?Q?T4OEUabDuC46vZil46NiEmTqzCtwV5Ca?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 03:19:55.0463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6133baa-7a51-4e91-bc74-08dca6d87edb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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

The eeprom table is empty before initializing,
set eeprom table version first before initializing.

Changed from V1:
	Reuse amdgpu_ras_set_eeprom_table_version function

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index eae0a555df3c..aab8077e5098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1011,6 +1011,9 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 
 uint32_t amdgpu_ras_eeprom_max_record_count(struct amdgpu_ras_eeprom_control *control)
 {
+	/* get available eeprom table version first before eeprom table init */
+	amdgpu_ras_set_eeprom_table_version(control);
+
 	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
 		return RAS_MAX_RECORD_COUNT_V2_1;
 	else
-- 
2.25.1

