Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE4FE77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 20:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B226110E24D;
	Wed,  8 Jan 2025 20:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBjCzVaL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3466B10E24D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 20:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAg+T2/RBjfsVKUDdJHMS9uj+pLmCUAMjuEI+wAoT4bwVoPEgGiKwLltiJFWxK4xyjWvhlhtWJfXZ3lTwLxEZvTKeDdtmwDx7WjH7XhuuQIbl9Y2GBYYuI6rPItxTRz8BZlGVgQhB+rACy2rptT9c/XbTqsvz4qnIUROxlqyRVypvIWwfrKCUek+w/n9XqyJwpRWA8VjNlsVxqE39sjs+X0384bR/nVHdlxCnoU0pn8+ns2jIWnq8mNbt8RzuVceRsGVwWPJpj5SvIemGjSpfxotv8IHSLrFODu4NMjEuskgJHKLOA/KM0Iu/RRwy5kcPq3bYRiUSpbLgA7ZDnOEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiVaTz8pNHJ2btz8dHn0DfMa3sGLt1LIsTm9uf4+S74=;
 b=tZqsQaAZAGjYrgsJLlfeg2Ny89MOOv4IeTyPYkh6hZRqBtiDgk8riYsaYm8uaStT5veJehfJot29oKBTJsL0dCQevVmtglpkmJbL55gSK6tWTU5nNOmlW8uE8+eWhVG1AKW/qNXyPoZh4a3Itv5b4TAQTdhns2CUoW6QUXMkh3a6ftCN0NwGjy9De1akU6sGRGAmS2O1PNp3K2HGraq2V1xx2bHPAESSe9uS8nyMjtSJznKHon4EUMHwvhYmtBxxU32bwYgexTNrLCu+kGG2WyN+yYGGSgUrAwf/rZeoGXl9ssDh6OMtukRuLBu53vNYLGqd2BDB64SEUITbQVwDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiVaTz8pNHJ2btz8dHn0DfMa3sGLt1LIsTm9uf4+S74=;
 b=sBjCzVaL3N8ICAeA9MhR0O4ozJYB0ywXiplvnRV+OV7nbvkYQOGr8iIvhdxbh1om0SV/YnLlsR+X+pbs3psofYc1CnB2t6bNDmAsuiAv9mdqgBFfbSIUnwxNwjTXzF/l3ZrS8Plz3bANMoIbHjyQdgmOQgZYs+0/vUVyG7AjPeU=
Received: from SA9PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:6e::26)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 20:25:55 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::a8) by SA9PR11CA0021.outlook.office365.com
 (2603:10b6:806:6e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 20:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 20:25:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 14:25:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/smu13: update powersave optimizations
Date: Wed, 8 Jan 2025 15:25:40 -0500
Message-ID: <20250108202540.15009-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: e440867d-b090-4292-24d3-08dd3022a762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BjwI6toSintIoCrDJlbYNdBk+GSBKE0C49gp8t3psFP9kNgVncTq+4aK62wy?=
 =?us-ascii?Q?Hj5sK5e6rwwdqfKLP+/cwX1QTUVuUbmcFyeu0wcbt5SGRbc3nxHIdpOnUXIq?=
 =?us-ascii?Q?vp8hqD7R9+EA+/wOLWGPNK7XLWu6TqZ4chk/IObviADBgrACMdjhWQ0qBL+M?=
 =?us-ascii?Q?ROJZKffuCVGMQ4AyhmI9orM/pHdobjPw9975Cp8YIYD561DSS0HOInCh1at0?=
 =?us-ascii?Q?+4TKrB1kSCFiNtqpwee8/Qk9Mgp+r/Mm/GlC4YJJpZchfSIHxKS9pBjmccD7?=
 =?us-ascii?Q?EjiEMDzuWVj3taTCZbJJAMTURI+fvx+/LNsP5q8LpA70cCBsYhfhXUqjG/yq?=
 =?us-ascii?Q?2wz+9Z8QB/IE7Etr8zV+d434aEJ7gSgNQEhFTb4W+3BaA5vZtGprAS8Vn1Hy?=
 =?us-ascii?Q?hSseLTJA+drT9xK5wdUpjLMVaCaMgxz0q+hxyKtsxfaLgm0+eWwl3Ci1QMnl?=
 =?us-ascii?Q?EQJq6cWwoqWj3ZKeMAs3Ps++vKFkWyw2XtpKSVTb3tPn16KHL/ln4AJ/O8hP?=
 =?us-ascii?Q?cJUBixEXmZMuXvD4W+irVGQm9TJyUpICnGBn9NzMJ9RXigoQP/XrDCnJwj0B?=
 =?us-ascii?Q?vRBB/o1Qmk5DSgrS1LHXPP3GWPrTm8hsH6+c0OMXe/5GIAF1kInVT1EvtsTp?=
 =?us-ascii?Q?0Xj5a46+nLI3EKxtD8EOi0RkZ4RBoPFLfIopGtdubgnzaJNL1IY9mpTiOw6c?=
 =?us-ascii?Q?K0aYiEZVQcE2hZ0UgjZ5LQL8gDCORKPIgIVLrCdOPFJVUl+dJx+6isf/6YHJ?=
 =?us-ascii?Q?bNIaVVwyCMhdP2/EYCk021OvLhrL9UXqNfgQiEkDck86Rg/dH50+0AR8RrKx?=
 =?us-ascii?Q?XbwyLumfiiD1MEUQ2+Co6nnvP10RoEFmP5YTzcGirdJHEC5ozNTOajH62t6b?=
 =?us-ascii?Q?V1Go0WV0qPF83q1UI9RP42vKG+jhLQISjMlpPLRSFxQSMaTg/rsps0HVYGNk?=
 =?us-ascii?Q?Kqd5CCSL4IsRe5jhv6PeXCRtYhmTU67z7nvrSSiaQrQbfRV3UoDcG8wA+BpL?=
 =?us-ascii?Q?hHqLXVHyE2qBJVp8G8weqcTTOFBbf78HyEXTyIp98W4kw+wCDjnACOS/Dqyb?=
 =?us-ascii?Q?kFa0TN83T5tOtf4XXg/5rohZ795wBOF9ts+gOZyU3gcqpoUCMBIVF+sQSK5m?=
 =?us-ascii?Q?c2ExUh0CpO7sSO5iPvPX+YPHwmB8toXBPIyfgVjticHYPmLEN9BSEyHesXTU?=
 =?us-ascii?Q?xanUBGJ/Ia+pDUjqxgJk1oise95Tmx+WnlK1YAUGnMBfmlA4KcrgdbfnysGv?=
 =?us-ascii?Q?QGZ4GHxau8oPC+OnLHm16fXGL2wJnbu+bbduyrxxsgfxOkh+JkGYfpIWMBPK?=
 =?us-ascii?Q?ZR6xEhVX+zXbAWo+be2bfTodaJ1s00M62MXgcEKYEKbCw6g1JWhjnju3NqB6?=
 =?us-ascii?Q?K4svnmxKgsLzMUOpUihaeNpXIw9hD7KUAlMWceu+xuPvcOa/aFC5wdLmRBH9?=
 =?us-ascii?Q?UvI4aBCDUOC5CEQ3lR8VWDkDoIdESNlhwfUVIbbXYbFX7LGh+1gdGPKVqbC7?=
 =?us-ascii?Q?/ngES84Cunf5pvY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 20:25:55.0633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e440867d-b090-4292-24d3-08dd3022a762
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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

Only apply when compute profile is selected.  This is
the only supported configuration.  Selecting other
profiles can lead to performane degradations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2a09b27788e83..0551a33112171 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2643,11 +2643,12 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					  &backend_workload_mask);
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
-	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
-	     ((smu->adev->pm.fw_version == 0x004e6601) ||
-	      (smu->adev->pm.fw_version >= 0x004e7300))) ||
-	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
-	     smu->adev->pm.fw_version >= 0x00504500)) {
+	if ((workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE)) &&
+	    ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
+	      ((smu->adev->pm.fw_version == 0x004e6601) ||
+	       (smu->adev->pm.fw_version >= 0x004e7300))) ||
+	     (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
+	      smu->adev->pm.fw_version >= 0x00504500))) {
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       PP_SMC_POWER_PROFILE_POWERSAVING);
-- 
2.47.1

