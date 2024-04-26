Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98FAC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 07:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64563112248;
	Fri, 26 Apr 2024 07:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nuxgbZRG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7AF112248
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 07:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcUXGmG4450wPNtmVFKXzZd5K9YrT1KkxVqUMxE7MgPGlfjo1/wJ5d6m4WdR/i7xWVlC9ccOAN9YvwQ41Z2kRxRzvuWvlv+0+Gca97f6vvxVtTGvcHuvTQL1cPvPlZQHfBcjXz/FmvdpjwCFDMKWw3x5hBaArTjkh2Z3XQTe8QE8RmITJ6yk6L+HT14/6KGBEjJc4sY8kMoJmL79z2C+O/rvWA5+TFc0H0Gf0MeQrC4XbIHjqzmcV5O6Ycf7XPZFeFDxH1QO5aAbYj91lhARapBx0aC8RczpnYfHvVjmqyV/N7sd9XtEIxQHGIlMLROfYznWU5seNI7JQZPasd8HOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaiBu5iRQTUMtUEASkFyMKF6W/6/fu+x4YoxOivf9Kw=;
 b=TV3ClALvEX6CKtjwd+rGaMMedXsEmX9J6J3XFjRqlVLot4wpkMWPO8dbT5nKcXSBIxc1B/hykTwbMQrmDHYAa6sAxoQpremYWt36IQTGZPrRRklwGMqxOHU6VJJIOdzjmz/Xxm0n4u10rb+kKRSnDuMcC4162LHXpNHM+LV6WkeKzwOq4gE1Erxkcdb364b4VClhDWymmdE7oMRfH3H2elVsvfWLwxOflBnV+DsmL1WKWNMKVsfPQ9kEwED5+vO6BkEftQUrVrHvj3vvS9h2olZSXKgUhTOAzUtOOM3y1/yKJ5HxO7ZCVayqOe0d9KiPztGf1zpfdq5EMTFiCD3QJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaiBu5iRQTUMtUEASkFyMKF6W/6/fu+x4YoxOivf9Kw=;
 b=nuxgbZRGWMXgPGUyJVohqJYMlv/S67Pg3c5fg4ffghUWAmJSYuKm3GwcjKPp24Mnc4Ahz0DTSPPJlVls7vleRq5LJpkbteABsui67OJm8c9DdsJLEQA2cd86thd42pVqLC/AkZU8zdX0VgJh4zJpKk100cNxCrdouLQ/bnqwaRE=
Received: from BN8PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:60::17)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 07:29:21 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::30) by BN8PR12CA0004.outlook.office365.com
 (2603:10b6:408:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 07:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 07:29:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 02:29:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 02:29:20 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Apr 2024 02:29:13 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: fix the uninitialized scalar variable warning
Date: Fri, 26 Apr 2024 15:29:13 +0800
Message-ID: <20240426072913.1063000-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: f7891c2a-cf20-43e0-35f0-08dc65c2971f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnJiVENzdE1mRmRpMFNBbjVudGJRZDRLRFdMQjdxWmVFdFhkem5udHdjRUVt?=
 =?utf-8?B?N01IeG9OVi95WVc4UE5WUlFKYjFUYU04MDNxVUtlekZPaWt5SGdKY2ZhN3dk?=
 =?utf-8?B?RkkrZE1OK0xVVGM0RURmcmtGQ2VUcDhKVFVrMEV1VWkvUzl0VDZqQm9BRjRN?=
 =?utf-8?B?SXJMQUIvTkoybXQ0ZjhLOVlxMVo4Y2k1di9oMk9GN1VRM2FFbmdLVkt1Y0Fq?=
 =?utf-8?B?U1VENHhLL3VlcmFKdURzRjMyNS9na3dIclZiejdHZFZVWis0RXc3WEtjQjZR?=
 =?utf-8?B?M0lGWGhoMTVLMGRXQ2Vjekd0TzNuSEovZm8zMjVrUHJaOU16S1ZjSUY2OXRL?=
 =?utf-8?B?TEJFN091bVpEQ0JyYU9qZkNEY0I1ZCtINEU1RS8rcDM3UjJnaGk0TU9zZHpx?=
 =?utf-8?B?S1BIWGZES1c4ZC9sYkFlRHArQVFQMXhGZ0VXZThML1k1ZWE5NzdTL3k1YS93?=
 =?utf-8?B?dmFkUUxGaGV1YjlXQk9xWjVUQU5OR0JnOUk1RTdkNGs0ekpPTVFkemlNclF5?=
 =?utf-8?B?a0djaW1ucWV0dkg0UGhSL1NFL1FuU0FDSDhuS1RDVEQwa3VZT0trQ3pYaVVl?=
 =?utf-8?B?L0s4aVN1cEdYTDRTa2ZKM0cvTXo5YktRWTVGSkZhZ05LOFVuMUVoMkE3U1U5?=
 =?utf-8?B?TUFIT053cEZBTzJ3SnBUcWpqWktVS2VxWDZ4OXo5V2REb1M2VkJZbU9rU000?=
 =?utf-8?B?M2lFTERWTjlmc1ZxOUpxSG9YUEptSTNNb1RtUFo5N2Y5S3ZLbnFPU1JqdzhX?=
 =?utf-8?B?NUR6UW5uR2VHTTFZa3FIYXVST2tRVGM2YUJBMmFKNDhBUVpSbExaelQrbTQw?=
 =?utf-8?B?SWdqWUViSWl2QVZBdGU0NEVVZ0VMMXk0UVRVWWg2V0hhSlpPVXRRUW9zekM1?=
 =?utf-8?B?N1B4OW9FN1MyN0VPVzhTSHlkUFlONE9ZSjhHQ2RFaXRnejZ3RXl1emRkU3N0?=
 =?utf-8?B?OExzZ0ovTjIxeFpCQkJoT0xBUWhpVHVFZUpuWUZlcjJ1ZGlOQ2o1YzhPdUpP?=
 =?utf-8?B?dlBJenBPdVJ2cDdDaWZBV3luSUVIb3VpU0VwZXJzOVhtNE0wVTI1Y3hVQUJk?=
 =?utf-8?B?WXBTQlp1RUFLbzcxUTRIODRBV2E1V1dISUVFVGRDb1ovbDhPNmtrVzJQaVZK?=
 =?utf-8?B?ZUo1NlFWeUhXRWluaDI0MWRGbzMxZVNMdVNvS0ZoQ1prMkRVSnpKeVFUMGpD?=
 =?utf-8?B?QTBud0ZHdFFRbWwxK3Z6S3ZPNGV5VTNFdmZOS011R2JFblFOakpBdGt6ME5q?=
 =?utf-8?B?OE12c2ZSMFpYbjhwcVdNZUpwc0xBMG11d25hN280Vk5leDN2NlR0UGU2S2d5?=
 =?utf-8?B?NlduTTJIaVVwNDFvM2J0K29OZjVmUTlLMmF5YjdJNUVIalc4YmxtaDRzVVdi?=
 =?utf-8?B?Z0NxWDQ1U0RsaUlFVFZuVVdTK0Y4ajI0Q2JhTEthS3d3Mk5GaEovU3l6Y2hh?=
 =?utf-8?B?ZVJMVVBrYyswSTZyVkkzR0FCZGdyQnRhdE9EaEdORzhGMU1JM05UelFoeTU1?=
 =?utf-8?B?SXI4aWFMQVh2b0dNV0ZpNWM0clNmdXlVOGdpV293SllQaXJqRzhNWkZncFpo?=
 =?utf-8?B?OG9XZ2FQUnNrREdRcFBQYTdjMVYvYzVsLzAwSnhwT2h6STNwb3ZEKzR6eTkw?=
 =?utf-8?B?bmJNUkxpd0FFZ1daSmd5S1dkVkZ1RjUxakl1cUJIaGV3R294YXVLb2ljZWpS?=
 =?utf-8?B?ekxMVmYxbHlCTlJvaUQ4TVpFQ2FmS3hsRnlObGtrWnY2UXg4VldKWFJoR1BR?=
 =?utf-8?B?QloyOWN3NVgzM0hXVERHSjAwTG5qdjI4YTV4Z1lqem94U05ocjg2ZHY0dUdm?=
 =?utf-8?B?SUtYRENRcFpGWVNDN01YRDByV1Vjc0swczRkQm5kcW5pSm9XZEdtaTNCNHdC?=
 =?utf-8?Q?6AIuBohp+Dm1p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:29:21.2764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7891c2a-cf20-43e0-35f0-08dc65c2971f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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

Fix warning for using uninitialized values ​​sclk_mask, mck_mask and soc_mask.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 8908bbb3ff1f..10f673b651a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -932,7 +932,7 @@ static int renoir_set_performance_level(struct smu_context *smu,
 					enum amd_dpm_forced_level level)
 {
 	int ret = 0;
-	uint32_t sclk_mask, mclk_mask, soc_mask;
+	uint32_t sclk_mask, mclk_mask, soc_mask = 0;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1018,8 +1018,10 @@ static int renoir_set_performance_level(struct smu_context *smu,
 						    &soc_mask);
 		if (ret)
 			return ret;
-		renoir_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask);
-		renoir_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+			renoir_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask);
+		else
+			renoir_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
 		renoir_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-- 
2.25.1

