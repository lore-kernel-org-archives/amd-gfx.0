Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F10BC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 08:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E700D10FA94;
	Sun, 28 Apr 2024 08:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rvW4q8a7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9518E10FA94
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 08:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2QmT1pJJO7GvwK8dBKOlZ7Ph9dHJX2CWhJjAZ0HqmfMHE3y6GtmLVOP7jROmbVpvtT49B+bvm9tAlF4hPmMwnvcJb0OtcNUR+r4MGfKzYk661lHJ0/YJP6lROvFGTnNJjnafR/NUT03gxn0hcBDsptL4Ojri7tBlfFN7r0pXIQ4JYvVv9TlVdJYalgMzyJ7aUpHfIL7EbkCFKKFN70KnepaeuaRDebG5GnQDsX3I+oBYrGgRC7oHpa+w6DBq4H6Zpy8pqFVRlBmms0ewAVdXojvJnMmBfAT1iITV4fNySPoQ/E20IDlUtOJ43GglLZt6Ths2S+elNLylMwriXlVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYUylQEalZlBUEYePGzrfHUTU1N3AjbQyz0jdQ+xIUM=;
 b=UvmIOp7renVLQHIWP7aROWku7zo78dGLNi38coVgUXtApVa+b8PfbAMTLWVgJRyyjAfF9SaN+hu8NpASWj+iiT4xWHcFEXJyAiwrsGJhkXxFgW0hvd7EqbAOZLhVhuthl5D30lVI27M+e3y4w8kxbVx1r9U7GtaOtsPvrDURI07wNAKnPR5IzDKoWB/90AFAWcJXFvYp/+gFR7inNfcvqydwVk96+SCLLGWB79CRF4vhbdPkinFkTPw1Fid+CeBRi/6NCnYBMON8YUmR9YnaZWWpRNXEus8SMY4Kgo/111aeuAbwE+pa4/XbT/u9P07zlEq8C1i8XEONM5eu8qfEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYUylQEalZlBUEYePGzrfHUTU1N3AjbQyz0jdQ+xIUM=;
 b=rvW4q8a7WdXzHeubgaOkjMss9hyL0f/MUmuhW+G4CNx7wcf5MuEK4yyNfnGy34eo4SnZ7wcO6yA9AJiJ6Mb4HHOGXDkoNledi0s+AAJAhv2eHY5CbAvuJH/XO4dyGWreFj8qzwF3sKj83qHXnSTZip8sGZ2trhwo1i4pLtIeEe0=
Received: from SJ0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:a03:3a0::35)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 08:45:40 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::c5) by SJ0PR03CA0270.outlook.office365.com
 (2603:10b6:a03:3a0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Sun, 28 Apr 2024 08:45:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sun, 28 Apr 2024 08:45:39 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 03:45:37 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: fix uninitialized variable warnings for
 vangogh_ppt
Date: Sun, 28 Apr 2024 16:45:11 +0800
Message-ID: <20240428084511.1646356-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240428084511.1646356-1-Tim.Huang@amd.com>
References: <20240428084511.1646356-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: a2996d1b-643d-4c5d-a7e3-08dc675f951e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GdbCaXdDXL1e932Zox3vSmpDjUBYr5B1eY7GyUFEEDYzH3ht5ByIk2ltdfPV?=
 =?us-ascii?Q?6G+MlstixJYAT2uvkzLcnniLdAKGYavanVOicr+ekhWzflZbks23Ddaxq+B7?=
 =?us-ascii?Q?X51iVppU1cQXtbPulgZ96a0UyB/eWRM3GE39jSVcvCuxfZ0pBBNLp43qd33j?=
 =?us-ascii?Q?F8eegE5BYFTkHvxI/kNmKkaH/vkW1EbAwczdXavwCK935HVrJGq8ekskekTG?=
 =?us-ascii?Q?XQBCnjRncFtJIHrmgxQymAnDi1kySAXa0G2d5OyN2etQDqNsd47Ttdg3rtgy?=
 =?us-ascii?Q?6Xg9l6PbQZ0SW/fe+hFqo9wUC+0mcylnu8dB1ZuXjuymcAQMBiHS74wVdByQ?=
 =?us-ascii?Q?oD3Qa28Og8GaD6lz4yOE9xBDL63kiG+yKGEhfOWkoNJB6XdhQg5QPNr+cVY9?=
 =?us-ascii?Q?kpcx1xK+ydvR6Q40IEG/4zFYGbDSqScM7hmimQKVp/YQXi3cjXYmsbPHlKWR?=
 =?us-ascii?Q?D+n6rwnzZAB9IQwzKf2FmGndeuY1NawIQNke2hGBqJNebND2TRl4b/fkLsky?=
 =?us-ascii?Q?HmG3wJQHjC6aqdjRWClABgn6BO8rz4Yoz6MiRvjg89b/eTaAWCLgk1P6Cetq?=
 =?us-ascii?Q?D3xFV7b5/bW4KjtWPMLxw0PxebCT8l/XzZqizUx8IrZzf7fl5MJfmlxHGbEb?=
 =?us-ascii?Q?a6AjvVerKfVs18kHgbzzCvpBAZ6PqWdVwitdTae/KKyab01p+9IRrY5uFt5A?=
 =?us-ascii?Q?QEOuAEmAUUIQt8WVgFg+9OfqWVd2HwC3R2sGwHujQR1wgXZHIM7PzzM56c4E?=
 =?us-ascii?Q?NNbYIZVqbJnFwqffSzdDQwYqoypYeg3bC6zTM1V9BGbWZfAn0S25/q7NYy0T?=
 =?us-ascii?Q?W6olIytW9+K3Xr3+X5LQ9YwgTXb4OXfGf6DoOeHbWnsm8OdEcsC8MnorjKR/?=
 =?us-ascii?Q?mAvR2e0+nwrfT0MRTlwIWHAyJICl644h9fAyFYdM7ayFwVwZzG1f9gR4V3UL?=
 =?us-ascii?Q?oDFUJw5ZgDupDivCkPbRTEWOh5JYpvSzZ1HRQGhe4NVPR1Hm5S1Z/OUbOW9O?=
 =?us-ascii?Q?jZAflLekd2KJgVGQIU+ZIqslqbkKjEbCoJl7bEii8Ld/HaXHAhpH5JjjKRBi?=
 =?us-ascii?Q?OvzSNgwzroGdyQCoCX5r5hgdR7fw9eIQOjwaSAbtJxmM+BZqSC4tHC0Gxa9h?=
 =?us-ascii?Q?EXaCMDQ2820tZJcR219q5tq20e7HsLWm7NKpVhxzA0nyA2x0OcMVP25YcgE/?=
 =?us-ascii?Q?81bHKonPqAj0SRob97vVvmd+BcEBVO9OJD8UV1hYIX1jN34GDcYEFKo3Nplp?=
 =?us-ascii?Q?EZ0KZqLnxbmDD4HXMQ848g8xoz2g/R9yt40+hh8gxXrIXjLyyTPqM2COx2kv?=
 =?us-ascii?Q?g9sddPraK8cvmlnDaHKwxQKUiY9MDGD0jV//LrUFJ9cU4jWROm0KxppWNUNx?=
 =?us-ascii?Q?YTPqqoH1kh2kqGmoCrwkqRTEpRAt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 08:45:39.9729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2996d1b-643d-4c5d-a7e3-08dc675f951e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
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

1. Fix a issue that using uninitialized mask to get the ultimate frequency.
2. Check return of smu_cmn_send_smc_msg_with_param to avoid using
uninitialized variable residency.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 29295941aca9..b40cb4e255e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -976,6 +976,18 @@ static int vangogh_get_dpm_ultimate_freq(struct smu_context *smu,
 		}
 	}
 	if (min) {
+		ret = vangogh_get_profiling_clk_mask(smu,
+						     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK,
+						     NULL,
+						     NULL,
+						     &mclk_mask,
+						     &fclk_mask,
+						     &soc_mask);
+		if (ret)
+			goto failed;
+
+		vclk_mask = dclk_mask = 0;
+
 		switch (clk_type) {
 		case SMU_UCLK:
 		case SMU_MCLK:
@@ -2450,6 +2462,8 @@ static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool start)
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LogGfxOffResidency,
 					      start, &residency);
+	if (ret)
+		return ret;
 
 	if (!start)
 		adev->gfx.gfx_off_residency = residency;
-- 
2.39.2

