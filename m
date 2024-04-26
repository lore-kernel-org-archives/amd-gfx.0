Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BB8C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 09:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA2D10F1D8;
	Fri, 26 Apr 2024 09:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E3dZysF7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9BC10F1D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 09:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feuYI20aAr/mDP30cMiokhG18CRYWsOH82MOuRonQE8qzdAUyNQQVfOGOlxtaK3XWDN6Z3B0oss3KUhaGA6Kk/XvkHFormXPXrlGgg2Trg/iOE1pYcwoqXIUmkYMyrJl0+hfytiv5yA5VAyU2ncJoCOhj98CzW+DZq1rdt4NOFEyNK4wr52sehxRT0lFNdmzpJI5S1Jm1UHj1KzxZbnIR+9oI9Lc7hdOIduYQqKpIuqlRZ0UZ9XZeJZKm+9XHecGOqoVwZjOae01UK+Ya7P3mxWCjhLcNKu2QHI/ZPo90idRGM4lmhGu3mrTrXM0y1kulCxoNeDcK+/3msoWWdmMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sFNzaH9Tc57yM3JlwJj77+zPY0fxmDpQeENU7TuYaM=;
 b=XYpYVsUxjs80FtmHI2jHz9rMyihCWYlTI3M+PuGt4uXDhtBz6wRNyGMxmG8gJZntHAVhnKHRjTWE6MrwVDxsK8MDkB2vdMkUICsmVZdJct6UaodSppNmXM/uSS+ZA/NNWYnHGODnPk4ZnDfNk9FGq6SrVGWA2WViQ3+UJ2iaGMjDGzyZlEoaOVYEtNiw9cPR85opeyxyhm70L/q4yJebNFf5FZp6GQjZJPSo1f+/b7nOO06aIh04eLuO8Tz4d9Q0SEKWg4cuxWqwampnKNolwcd4hhW8r8LD7Pu45C0Z9nAWclGeOrY3Wie3I4wdt1jw7/dJn96nlkLSSsv0E9Uhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sFNzaH9Tc57yM3JlwJj77+zPY0fxmDpQeENU7TuYaM=;
 b=E3dZysF7N+H6oGRj1LzkaTSBnwEAdvqxCq7h2XLmUkWRO8M3XjgAJAsSu4POHXMo9rhT55Ptl0oUaHoTdJ0IBGCmHjlvH9CO+pXt4lFUmcKNaB5mkQp78e3hMgVYcwLJXZtmp4jlyBjgvqGjVnB9UR4bIVytFM4hgcWNYZZwuGc=
Received: from MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26) by
 CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:153::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Fri, 26 Apr 2024 09:29:36 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::3d) by MN2PR01CA0057.outlook.office365.com
 (2603:10b6:208:23f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 09:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 09:29:35 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 04:29:34 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: fix uninitialized variable warning for smu8_hwmgr
Date: Fri, 26 Apr 2024 17:29:09 +0800
Message-ID: <20240426092909.1350037-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|CH3PR12MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 636afead-e157-49b5-d373-08dc65d36376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ZGSK5h/fCqv6N2KdrUyD0ZtTXKYMQWwaUDv3soRxCGUQ3apHOZFahG3q93n?=
 =?us-ascii?Q?XyIFIag8ujVRQEUuwGn0UGldb/MxG3mhtL4YYfQeU14dK79hsgDQjsopW0rF?=
 =?us-ascii?Q?62pRik4nOTm7vFxle9GxqePQcEFieTSMun/AbZ7q9eO4g9nBAJz5TXjWadzV?=
 =?us-ascii?Q?7RQ9Wnnt+O18aBcjo55YSva4hAnMFBsQUSaXl7m9rOnGoSgVYf1yaKxp5Ytr?=
 =?us-ascii?Q?vsJUhn3lR3SamGP7UaRsmdQ7tEWXj76Vq59LpTSGRO4Za8uVScwWkHspqcxz?=
 =?us-ascii?Q?jGSVYjzJ9awjMW4ri3XNgwoh8yvQHRkegfdlp6xRCnxHitITpD97Bq2dMZEI?=
 =?us-ascii?Q?Szhbowa5vrXFyAqYAboOHibE5816eFgfMQagOebX+PEVesYCJMxuYuj710H3?=
 =?us-ascii?Q?1AVm9SkNWkRTx5V3vwYy58r2aJZxuiv03cO4PdjS2EDtPChdGCgodDyb3BDz?=
 =?us-ascii?Q?qr3Q7T/fwWnMGYq5uhqvbfmqIFaeCGl23y0UG0fHaaHfWYK0Srrq5d3kVCqb?=
 =?us-ascii?Q?+zf4io63hSDvxQCB7dtgELpmLY8uF1uHOIzYwN0zy8ARlWGO7BcEv3y4wzi0?=
 =?us-ascii?Q?NKU8mM4u2tZ7ZV5B4CTw6mTjbKfrXtB+ctIpNthhCU+moRDC86+abBg1HoeI?=
 =?us-ascii?Q?XDEwNHJ6Gmd+aazWA94NmdH+ZUOfo91EQAG9JTlAhRIwEYzMMHAB5yCRPqbm?=
 =?us-ascii?Q?v/qGPX6SJllbzCMD1Eunrxo+1wchuG4S+i/YU/W7v7XMusYAuO7o7SbQOZDa?=
 =?us-ascii?Q?qdprEEG6KEA6iI1PC5EvVUC1j4P6UAiHaetQxF0u8kKlGkJjGtlyGKF0Oj1V?=
 =?us-ascii?Q?7YoJvEIyiqBAECE4rwar+aj88ZUKcgoCUrkSOAosUuzZalqHg1m/IenlXx3w?=
 =?us-ascii?Q?nvxUbd2YNlP2XsE1Yv+J2q3yLtK+1ihkMfHgIGP8I5WF9deqrGlhqy0AemHj?=
 =?us-ascii?Q?NB5wcbklmlXjLyZ4CLDyz02Pc8vdE10JJvJmUwDqXtbIt4dfwDrbp/1Oj0K0?=
 =?us-ascii?Q?sxvb/SJiFzdBK6xS6ayIytgqhEkeZNL5E614iCw4W8Oz6UVsW8Y+KBZCPSk6?=
 =?us-ascii?Q?YKqiZMR3z/EpQQZFMGhBmJCJhjWsRPonect0u9n3EkzhNpxTk85+c4bdrYhb?=
 =?us-ascii?Q?pE6TkLUxLA4iR+Arz08OxgYTH+7p9OpJoI92AA5ZqDu4aXA8dwfU/gDWHLMO?=
 =?us-ascii?Q?Bqa7UZ8+85D4HYad5+MyPcdBSPDujsxvSEkY4srJM0xfiHeQBi7UafRnPXUl?=
 =?us-ascii?Q?J8bc1uDC0civ2GrLBgGgDwNnDL53Q3S6wuCgojYenemBGXYXV3xK7dURg5R0?=
 =?us-ascii?Q?BGc3JzzRzBQ0LtDR8F9poa2pXj3BRVWVoBENUqqoAIcqCmwI6miNlz6XgCzI?=
 =?us-ascii?Q?DCBV1fU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 09:29:35.9441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 636afead-e157-49b5-d373-08dc65d36376
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
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

Clear warnings that using uninitialized value level when fails
to get the value from SMU.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b015a601b385..4e4146ce71c1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -584,6 +584,7 @@ static int smu8_init_uvd_limit(struct pp_hwmgr *hwmgr)
 				hwmgr->dyn_state.uvd_clock_voltage_dependency_table;
 	unsigned long clock = 0;
 	uint32_t level;
+	int ret;
 
 	if (NULL == table || table->count <= 0)
 		return -EINVAL;
@@ -591,7 +592,10 @@ static int smu8_init_uvd_limit(struct pp_hwmgr *hwmgr)
 	data->uvd_dpm.soft_min_clk = 0;
 	data->uvd_dpm.hard_min_clk = 0;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxUvdLevel, &level);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxUvdLevel, &level);
+
+	if (ret)
+		return ret;
 
 	if (level < table->count)
 		clock = table->entries[level].vclk;
@@ -611,6 +615,7 @@ static int smu8_init_vce_limit(struct pp_hwmgr *hwmgr)
 				hwmgr->dyn_state.vce_clock_voltage_dependency_table;
 	unsigned long clock = 0;
 	uint32_t level;
+	int ret;
 
 	if (NULL == table || table->count <= 0)
 		return -EINVAL;
@@ -618,7 +623,10 @@ static int smu8_init_vce_limit(struct pp_hwmgr *hwmgr)
 	data->vce_dpm.soft_min_clk = 0;
 	data->vce_dpm.hard_min_clk = 0;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxEclkLevel, &level);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxEclkLevel, &level);
+
+	if (ret)
+		return ret;
 
 	if (level < table->count)
 		clock = table->entries[level].ecclk;
@@ -638,6 +646,7 @@ static int smu8_init_acp_limit(struct pp_hwmgr *hwmgr)
 				hwmgr->dyn_state.acp_clock_voltage_dependency_table;
 	unsigned long clock = 0;
 	uint32_t level;
+	int ret;
 
 	if (NULL == table || table->count <= 0)
 		return -EINVAL;
@@ -645,7 +654,10 @@ static int smu8_init_acp_limit(struct pp_hwmgr *hwmgr)
 	data->acp_dpm.soft_min_clk = 0;
 	data->acp_dpm.hard_min_clk = 0;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxAclkLevel, &level);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxAclkLevel, &level);
+
+	if (ret)
+		return ret;
 
 	if (level < table->count)
 		clock = table->entries[level].acpclk;
-- 
2.39.2

