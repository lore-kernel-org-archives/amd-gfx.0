Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA468E77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 22:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8466C10E2E9;
	Thu, 12 Dec 2024 22:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d9+XRDuq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC91110E214
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 22:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqxiCr2+mjXcXXnQDeonQSJw3zsJOMkVasV+9FmAAGYl8GrjsCgKOs1GuXtyswiQxIFHOYJyoP1Y6PBdfaS+oI88uJJrXHRCcR+ui/HstmW/kNNhR7epAYZ36jBlZ1mYyISkpFljPUtZ+E3oDnmGPM5jrRYw4w5aS6rPkDtoPUHTohmgE/ey8gb7wWBaV3rBp3DlGNyh/C50mM/yivgXsf7Ws3dBpB3ZR/JcYIFS/vwUx3GfHNNCRterEtntdNNbltFfXbXCkaO48ooB6hCTdDJyqbyNellnWxXt2R/6PT3H3lwsdcOpXEVrWo6UihkqDsCNPuNWX8GIDzAzgRyktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+OqsveUJrT0osICIrLikxK9UE7+hANQLRYsoC30LXw=;
 b=SD1faaO5G7J0FP4gk9tW5sfu7KGpQMHQAgohkabCEMmh5zTysOVZJYfiYOWTrIwrKCVygutr+tfXxr04cn99GDm9ceJuNeYRiYcWIIyyMkc/4J25u3P5ErDr8JPZU50qn6Frx/Lp4iSq7YjJYkTpHYWH00QQ+6UyMdVXSQG9H3opTAngDDng+VMgB/qtHKRZ2+FldGAUiCLEsCk7Ql6hdCa1RZSrLfRW0zXBDiq/8ZKG5d1GJOy4TdhBfbpm7EsRRUfxBx1UAT8DEUxV/dBLaxiWbRKfFqwBM04GCsQyTrCtm0TAgGfkfhG5KK9NDMvyGH0wxcws6VVnsxFc3S6F3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+OqsveUJrT0osICIrLikxK9UE7+hANQLRYsoC30LXw=;
 b=d9+XRDuqzSaBodKP3h1H+g3JlJp7HN9S2noXLXRCwdCvSao+ZR2Zj4cEmCXouTE9iQ5tiVbVehzS6U1rQjaObG5CaEryFxX4Ioixylq4G1W/B8HE4WRUY3mWU+7AJ4Jp0s6f5yet40OATZg9VspZNoQtGws6rRmpGo1/J7LVCF8=
Received: from BL1PR13CA0254.namprd13.prod.outlook.com (2603:10b6:208:2ba::19)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 22:09:13 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::6b) by BL1PR13CA0254.outlook.office365.com
 (2603:10b6:208:2ba::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.12 via Frontend Transport; Thu,
 12 Dec 2024 22:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:09:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 16:09:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/smu14.0.2: fix IP version check
Date: Thu, 12 Dec 2024 17:08:55 -0500
Message-ID: <20241212220855.790502-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212220855.790502-1-alexander.deucher@amd.com>
References: <20241212220855.790502-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: c47cd507-4b7b-4003-b301-08dd1af99cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nGr13uGIqNwgbcms2UTe0jxK/vGe8kla1VeXJVZe9ljGimzwfmBQm0H2S+B5?=
 =?us-ascii?Q?uHEPq7snoahPPDLk2GUIMUBj0OUArvwPZjmKoMVA3hvv9tXxWPaB+veRiHtY?=
 =?us-ascii?Q?KJZF334jqHUQbCNN3QeKJ/Yp1SyGRLosBF5wHa97GfgL9niVe238SS/uvRIE?=
 =?us-ascii?Q?M3tPu1dNG7MSLPIAuQgOpkqUOqehEopygA5p2kFokn37vhU10eczVV9hoqjC?=
 =?us-ascii?Q?G5SF1hCWGUdJWvwnVyUVP9F7fK2zRLwenNQCmbWTtugoFgHpp8BToXR4faGK?=
 =?us-ascii?Q?y5+9SMcrmZipWt857oC0xkoP2w48SKFIvCY2lw8A5ixiXFrbt/R1eePDqT8K?=
 =?us-ascii?Q?cZ1cfd5Lrt0XxIO6w9iWqPYuwZaX61SeawGx8aQQuwsRnUaAsiTuQG76AIHi?=
 =?us-ascii?Q?Cdpty6ehcxVSnIdbvp2MV2v0T5DuIHgLD9jO6TGPgzauucwjY3li9JD0V04q?=
 =?us-ascii?Q?EhPvwqeDIm9V31ZsnPmlxLo1ldMEblWZIqL1paRyePhxhU9tAqAFH4mvpIH/?=
 =?us-ascii?Q?a+3RNxmA9SE7a4S6InqnViuH8ueDFN2wKvXTeqAzmb5T91wPPrbu0c48iceu?=
 =?us-ascii?Q?GQrHAbMNu5DquhuzfjOyYODLAq61xFT7TO9mh/a+Zr9ue/B71LocWSsKJ8kR?=
 =?us-ascii?Q?RVVmbjLyIHvzj7Bv14BGUQn5k0TpV9HwtkaK1zNi4OFTguHOcQ3lqRbC5QRz?=
 =?us-ascii?Q?R28stf4dlS7TXlFnPzVXKcJjbq/DqmCPN9LplMbf6QTmcc//7/j+OzdC2kHF?=
 =?us-ascii?Q?5tZ3p9XGpnzuoSzqvH8HQXC4FaH9EASIF1ilZq7l905apVMbWvhnVwAHvNlf?=
 =?us-ascii?Q?NnmmvCSDUxvbaYUHGwlKhwhmvPNYRfVcQYsrwHXY8yYMBWXDe71RkafXgyl1?=
 =?us-ascii?Q?WyjWuheesvD+lNlWURoMrSEzkhmIlMcb4mEeiykDcGkzt0B1KdJFDos3N7is?=
 =?us-ascii?Q?5oUJYSNfm+wfK1PK8+InPZmZtvBhA1s3WCWfRnMI5jZJqC6r19yxtqm76V4L?=
 =?us-ascii?Q?8xV0gzmb86sFP6/AvHf2QOWUegBtjPz+6ZrSuGefOPsms86V6zwgyKpEnQBE?=
 =?us-ascii?Q?cLntbUbqfLjByMeOG9Qos4qJKKyrO8PZiaMbYaOhmtR5ZrPtEEWCCz1LurWq?=
 =?us-ascii?Q?liMhGltkgoo0K+N3sHNvX5az7p+ugbeWqUgkRAxT0WIYKw26jkabg1Jr10XS?=
 =?us-ascii?Q?1/P/0hQeH6ScaB+Mbnhdl4k6wV07E/sU++w7hgltQ8pRSMtGYK4T0s1Z0Zte?=
 =?us-ascii?Q?0jtOpWms5Aio/tYJ/bxJtL1dhIG1m0stQhGTI3xQhePU5p6bapjjPJCtnljy?=
 =?us-ascii?Q?AXepLlxLAyME0DFRFwtqBwV43Z24OHY9rXbPhbl5uu6nuCXF02jaIoq7abu1?=
 =?us-ascii?Q?mRb89K9YrB84t1tjcxumHZ0frGD6fgABH9nZMwAAHm+LT3uYUkF+0rqe4XO/?=
 =?us-ascii?Q?GRvLyOjqzciWnHz4LaMZZPKpZD+TDUBx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:09:13.4125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47cd507-4b7b-4003-b301-08dd1af99cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 6a565ce74d5b3..5cad09c5f2ff2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2096,7 +2096,7 @@ static int smu_v14_0_2_enable_gfx_features(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(14, 0, 2))
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 2))
 		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableAllSmuFeatures,
 										   FEATURE_PWR_GFX, NULL);
 	else
-- 
2.47.1

