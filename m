Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652FCCCD186
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 13:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D10110E38A;
	Tue,  7 Oct 2025 13:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2F/U5Jk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE6410E681
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 13:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2fuRNDlyoQ1T3+9cKouQUOo3FDNBIkjAxN9lLuCCPVruYpk+TBmEaeAaKZZ2kqImXz4dutnVesSpYv5e3SZgxvAtbTmo9miXH5fUbv5Q1bIN+ctvkoAxAKRg4ALXWBJ+vtC7a5xh8M9czuls8s9qopXHtWEf/Me3dt7d9kPExAwLZZYXv/NQVRDmwbPsEcO0ZXjYX+VvOndC6NoFTkA0PUq+KYULzpqelouWgbB4zbbI6XLqQMmvr0bmddNv5I0YGVYk3Dgq5YvalcCO3U5wtmIEbiewGwy+ZZkzT1Wsx4JJcXVgM3eZjnzv9u4Kd62XlqpoOfgrX6mKu9uYG+PQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TyciJM3WdxQZdfJVte3lCY7rRRZhuGcCG8W+uxYAbw=;
 b=jbG255ckQl5amiZNTrDh6VAfFmG6iXx7xOL22Pves7XmgGBpnortEhQJSJw9H+Y6t6hK4CFNAd4yQQ53G5IbtNtQow6/CxZpPdwEpWurRlWOMG8OgL/MWLGlfIeIEQ2YcGjNXtnUDaTMACA2h+OMpCAmLu9YMLrQrwBniIYMnBbrj5VBbJpsC2Yy38hn05/NSLAgyIl3raH6BymyiVsWYDiI3Yvm2+NFRGGKRuF+5dV7dpp88RyUt8vFbuego8KPZzYw5j7NBl6RBl2eKkV7+49BUWRWNqlPyBKkc8nf97U32eWMccNRvuNyOkTnacdZquYS7EnZJRrcA4SeiyEZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TyciJM3WdxQZdfJVte3lCY7rRRZhuGcCG8W+uxYAbw=;
 b=I2F/U5JkIjIjHXwXxsesXNHrZY4EShSPr0zZIumfFeTNngWmSqFiDpuZmtrRkujQZZ7DdMZkgK6Xb79JVSfOIvRr2UB5AkUOTWKNIF/GXyT3ux/7qRdJF+owveYFZqrP7e6nJIq+ZoyzClwtouzUvo4VfHJ2EDwnjYuBhCqcnSs=
Received: from BLAPR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:32b::24)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 13:34:54 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::15) by BLAPR03CA0019.outlook.office365.com
 (2603:10b6:208:32b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 13:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 13:34:54 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Oct 2025 06:34:51 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/5] drm/amd: Save and restore all limit types
Date: Tue, 7 Oct 2025 08:34:36 -0500
Message-ID: <20251007133438.39411-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007133438.39411-1-mario.limonciello@amd.com>
References: <20251007133438.39411-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8906e1e7-df23-498d-7a12-08de05a64cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o0cjrW4fy+ps2GP3MuC1K6Tng9+M3V85SpeDPMDDPYu99JJ8nzNYxHc2a38M?=
 =?us-ascii?Q?QP6H9n86wMCBCk9isPymRF8IhcRi9upm98HCEp6m43FH3zAUxd2YIE3wuIT7?=
 =?us-ascii?Q?qpVclwZErtq9NfJmto5X1Z3ix3UA45T/jJj8q0xZ7brf7qISTsvU1ewhENeO?=
 =?us-ascii?Q?TKlkYv8a9LqmrF5La1hNu/loKFOX2JxJQI5uqnJHUamkyiT59bDAD9Am9KiZ?=
 =?us-ascii?Q?pIq5g9k4yRAOq/qd+wI7aDnCfNim0qNgFTCwg1dsc2/TU9EGXa2VzFN9L4jt?=
 =?us-ascii?Q?QVFwHBBtJqLpR0uXkFgINVX7wuhUEm2rJKAN9SUYxxRfm4bvyHXLOXiE91xP?=
 =?us-ascii?Q?MTbZC0pOIW9GrE1sSfrbsWbNf9M+TMv2FxLfKBzpcJp+5VlkLVfGf3IDLoSg?=
 =?us-ascii?Q?eexOYuHVpUgyihHLmMLMbuf9/SOq7D4hN+QCVH6RN0oyAOueS/Y/FaPh3KoK?=
 =?us-ascii?Q?qmsrzw0JA19ZeQZRZRlBD2qMMxHl3ssoEubdGmM4EA5wURfCSrhow2BBPRSi?=
 =?us-ascii?Q?J/dqVwOm9JYdRpxxsy1eEP8ZIGBsnEqjvUOaA1JtFcCiiDy3JA0MgSqSr5Ns?=
 =?us-ascii?Q?ZluUMIUFf3uijkWRFExWo3l8FWsQ6UzvuNw68nyrw87+IopEQEVBBzHXeZU9?=
 =?us-ascii?Q?fAJfmHZqhxyeQns2ugUQvByW0Lupjgxm5z3GqKhodQz7na1pG7T+1/vtPvX2?=
 =?us-ascii?Q?WS4sm1j1upnBLmJwOEeHk7hU3huZ79rXAXHjJZDJLpESFH9bKD4YK7h5GCM0?=
 =?us-ascii?Q?DmhQVq9K9NCdJTdlkdSfWcW40dOundzxu5XujX5fBlSkeOe4O3FFfWcrVbnm?=
 =?us-ascii?Q?bNljsPfLImOxFOLemdoNsbNlEILBCOwsZ2WsaG3azv4HcEfqwQCRNzkztL85?=
 =?us-ascii?Q?AclTAmL9KhCqAvU04LVqDaDRYPo/JP/djkrMGhBXLaI90yI4EgPKtEkTYa5g?=
 =?us-ascii?Q?EJvB49aXMHyLk3NAcNXL8trrUnFwUgwHHilRnZzmZ81i0Bt6duqbS2TCYor9?=
 =?us-ascii?Q?+B6JBVQCG7SlWBM1nqk1+1tOOzfNDLEIXFpM2pxJewFqp9G+qw5FLvQCfHD1?=
 =?us-ascii?Q?HhdciVHF6pXj2ZEBfWcVU87ymiOXCH4KVxb84nv/Fw3SKfDjq7/b0nqV4ETx?=
 =?us-ascii?Q?5sR3u1b9bFD6KXc8Vua0Pval+8uodjRolEV/axerJqdqUz412lqkflNVJ5Ja?=
 =?us-ascii?Q?3E5y2q0rxJNvYJFy3vlin4Nc/MZIDQ5ytq22fbfbFtFtOg1RrFyySNtnGZRh?=
 =?us-ascii?Q?zJYJljrk71Hk5fxVQB6Vg/sF04J1Xg1QkyS9Ocizt3KhJr8R3mbHVOsXmoxY?=
 =?us-ascii?Q?hvza/ZulBQoUbNhiwDT1EicFpB+qYlF2e5SMWkBOUv1WomO1YYXVLK8uHVb/?=
 =?us-ascii?Q?4NarFzKjvsdSjCyQhtCxp+di1/N98e/9H5L3Nd1VSix9FqxKcBnO9UYJmSVW?=
 =?us-ascii?Q?cDqLzQu/DwMFmj5rG8vGux+JgjtwSysLPLq6gzc6r2c/TxWuHoIjpoC8JR3b?=
 =?us-ascii?Q?wyrQ07KV9o5zfayEsgdyhfMb8m5X2PnXzlud+0ZYZ5v4pP2A5bSfwfuUViwx?=
 =?us-ascii?Q?Pt/WPmwF5jUIQ613Rm8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:34:54.2505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8906e1e7-df23-498d-7a12-08de05a64cb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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

Vangogh has separate limits for default PPT and fast PPT. Add infrastructure
to save both of these limits and restore both of them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Fix split from v2 with wrong hunk in wrong patch
v2:
 * split from previous patch
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 21 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++-
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1c5f37cd5b75..e87e729b230b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -508,11 +508,16 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	/* Enable restore flag */
 	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
 
-	/* set the user dpm power limit */
-	if (smu->user_dpm_profile.power_limit) {
-		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, smu->current_power_limit);
+	/* set the user dpm power limits */
+	for (int limit_type = SMU_DEFAULT_PPT_LIMIT; limit_type < SMU_LIMIT_TYPE_COUNT; limit_type++) {
+		if (!smu->user_dpm_profile.power_limits[limit_type])
+			continue;
+		ret = smu_set_power_limit(smu, limit_type,
+					  smu->user_dpm_profile.power_limits[limit_type]);
 		if (ret)
-			dev_err(smu->adev->dev, "Failed to set power limit value\n");
+			dev_err(smu->adev->dev, "Failed to set %d power limit value\n",
+				limit_type);
+
 	}
 
 	/* set the user dpm clock configurations */
@@ -2982,11 +2987,13 @@ static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit
 
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

