Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C19C10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 03:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C466610E360;
	Tue,  7 May 2024 03:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DhOGO+uS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4488610E360
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 03:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er3KTZuF8K3WwDsHUAK+uiZzhQ2/MgccVxR4Mx90w7yVTS3R3KcIZhxVSxt1tCrqK1Lehg9HBUjYx1YNSuOvY9snFzbrCjQe9BxafdFISBCs8BlKIWhUbUhjUNT3DyydTFBxe9BEc5D0bUA506+18gcZJPuTXDdWufahEUODFkUrK78Ca1V+IjXwCioSkzdr33RdPGYybT0BRk2tPayOEwjq4s4NTff0fYe3qLPA8jR2ppxBlIcOQvompz9VTHw1rH48lTAQQJ1hi/7StZCJHHxDhU2+g0Ltqk+PubAPu7ZsmAVJsmhJ/Of4MvG8nMqPHqUA1dKGShzp4n/eHa92CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrLVvOCh4f608IVLtgVPjcZ57u1E45cW451jbkV/0gI=;
 b=hGdi9fjj20Hge4HYWiSy6vvhv+774e/41Ifz25m6kCFJGqIyAamGYs8Mt8mhoC5orW2P1j6G6yTuS1muo3M5eSOQpGoxuX+rIGAgw4qmjhoQtMx14qrflFCKBgM47Cz4/7WfEkDmAgpC1XiMXvYDPb1jiPae8JyTHXPta/qeI5U3qMG3Idb9vfxcxKrttpw8sb9FQ5o56jTaB0+sI6C6t1sdwNtNQRnbJ+rQlbHyybJ7ovQuHa8EjjcZsIQRi69RWKEMQELaGRlGgYUAscXcdPPwVX23qp4d9m8rmMTnxrLzesUGgpQoNp8zZnaAxzWN+8qXMR4qNpRuIxWzUEBwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrLVvOCh4f608IVLtgVPjcZ57u1E45cW451jbkV/0gI=;
 b=DhOGO+uSO6H7hcIcW7Y7F3SGyZZpzvG+enk0O6/21TY9NtWjOtHPBmD/QA5Fh4T5XY7zi9U/agMSs5kt6c7LNVKPQQ9yccKtIEozvuSFDmNNG7tsPPjibM9FDefXV257RG+e710ZaII/4Jrtg0Ig46a18o4EbX9bqSrh6vk2+pI=
Received: from MN2PR22CA0015.namprd22.prod.outlook.com (2603:10b6:208:238::20)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 03:43:36 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::52) by MN2PR22CA0015.outlook.office365.com
 (2603:10b6:208:238::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Tue, 7 May 2024 03:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 03:43:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 22:43:34 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 6 May 2024 22:43:18 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: enable UMD Pstate profile level for renoir
Date: Tue, 7 May 2024 11:43:12 +0800
Message-ID: <20240507034312.3177370-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: d32accba-8c46-4001-f8f3-08dc6e47e04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TiG6DOyeF8AVQJ/tcAJ5eMLKv1JgLJtf3hx5oWVPQ5SzNF9V/GCxrJRdIPDC?=
 =?us-ascii?Q?vta69gudobz65lmqqeKnr/ZdFg1bcm838LUPsoA6FSCnATyUDekRTRooGQH3?=
 =?us-ascii?Q?jo7n/+rMC/N+6uE68E/79n3zNa1341ksCftnwSUkw7+Uk+2G6KUnuOsbj8Ez?=
 =?us-ascii?Q?ztzC7N/7o/Pog4wnCWpkJg8rwpb7QCPjm9uGymC1ZchP7l4BQ/MtnJGii/0+?=
 =?us-ascii?Q?boTJjwDrPKvf3uSN0C4ueD70jWLaNe+sg9FiL4wF0j9ss1y+d8Y0L2YLD8je?=
 =?us-ascii?Q?V8R2sID0kHUhsqzZjgPgAO9jXIFv0ZFZjBsjEDiU4Ej1WCIHbZXTyn0fQq78?=
 =?us-ascii?Q?qaU04pZG+qR/gm0nJs33UrOymEgfAT2AXKitdosdTk+/NLbDsiZ41G3rkpm3?=
 =?us-ascii?Q?iJH9EJfoeu9hqvPsqrzX0xDNO6aMwO76cmHJmz0su5Zv93YMY09ize9UsH23?=
 =?us-ascii?Q?qEc95Boy+zrwktvyPnetgnqNiUGnmiPH2WvxGD/K0qeovhfuXrIir6kDVUTd?=
 =?us-ascii?Q?eftreZdsZTzvuYRIg5RjQ22ZDjKT70Mw9LJ0PWekZUQSfY0htE7jkfQ2MFjH?=
 =?us-ascii?Q?hjuj1gstBuHnmUwoCtHl2TvGpfxU8n7CmBNMq2bcdV/qxxFXn6IwoxdAnOtW?=
 =?us-ascii?Q?TWVGDoiUznQzCV75u8qvRbwjkLjkjT1UxBNTAp4AbcdA+mIA4zds9mdplmBX?=
 =?us-ascii?Q?d/Va4fxEOhJcNpcudJD2xfNFRtkb2+W7dgLooUN8xBgXGlAKNe9p2yqDLRPJ?=
 =?us-ascii?Q?6Q4DQbGxonC9UHIsKkL3kgWepXc0AjxDGvKgSzKrs04LuyecpbWVEjcgWKhx?=
 =?us-ascii?Q?YYWfGfrQjcF3JyJdCivHXdhQJk/gbsLFIYQkaQkDH3G27R/pz90o6er5aVdc?=
 =?us-ascii?Q?JaTcBOv3FS667NeqZOScnWxgDgutsw2srBzeyg3I0qfarFT4Qyqbq10ohyi0?=
 =?us-ascii?Q?4Gqkr9i7OnaND6odd0ycv6QV38wF934TTGe7WKyB/oiQLCZCrAViB0PHfUzM?=
 =?us-ascii?Q?eLrFvhLGUK86psfu7OgwDIEN/YzXFPAykFEK8w4eFe1lOO5ur1PTFLHeLfnC?=
 =?us-ascii?Q?/oGEn9jFruk9J7B4VH6VRSCnbObmZUwMRU8ztCWMD1o84ch3Xh8vKThot8Kt?=
 =?us-ascii?Q?S2m783STmY8YB8y27C5BOiiMmT1bG5hBvFOc2pgtSpAlGlXEW5fh3aSdeAAA?=
 =?us-ascii?Q?D2nfz7+fFkiEsG2ehtz0D7ni8CFYSmn7W9YvLiZWi/bqsZj6Qwq14ZtpukYU?=
 =?us-ascii?Q?DC86Z6VRl94xXwuDuWu0Z215SbkmwpjPe2yEhcrgpdmV1kxlrerRLskviiAJ?=
 =?us-ascii?Q?WexDdLnGaFciERvMNfmfgsYO7LkWYzpEDDgX+f88kdBNbOf3sdzVNw7ReCBL?=
 =?us-ascii?Q?xPq/+Jf2kpl+o/t0H7PbeGLQ17b3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 03:43:36.3927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32accba-8c46-4001-f8f3-08dc6e47e04d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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

This patch enable UMD Pstates profile
level for the renoir_set_performance_level interface.

 -profile_min_sclk
 -profile_min_fclk

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 58 +++++++++++++++----
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 8908bbb3ff1f..e56b7afb5b78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -928,11 +928,55 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	return ret;
 }
 
+static int renior_set_dpm_profile_freq(struct smu_context *smu,
+                                       enum amd_dpm_forced_level level,
+                                       enum smu_clk_type clk_type)
+{
+       int ret = 0;
+       uint32_t sclk = 0, socclk = 0, fclk = 0;
+
+       switch (clk_type) {
+       case SMU_GFXCLK:
+       case SMU_SCLK:
+               sclk = RENOIR_UMD_PSTATE_GFXCLK;
+               if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       renoir_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk);
+               else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+                       renoir_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk, NULL);
+               break;
+       case SMU_SOCCLK:
+               socclk = RENOIR_UMD_PSTATE_SOCCLK;
+               if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       renoir_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk);
+               break;
+       case SMU_FCLK:
+               fclk = RENOIR_UMD_PSTATE_FCLK;
+               if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+                       renoir_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk);
+               else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)
+                       renoir_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk, NULL);
+               break;
+       default:
+               ret = -EINVAL;
+               break;
+       }
+
+       if (sclk)
+               ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk, sclk);
+
+       if (socclk)
+               ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_SOCCLK, socclk, socclk);
+
+       if (fclk)
+               ret = smu_v12_0_set_soft_freq_limited_range(smu, SMU_FCLK, fclk, fclk);
+
+       return ret;
+}
+
 static int renoir_set_performance_level(struct smu_context *smu,
 					enum amd_dpm_forced_level level)
 {
 	int ret = 0;
-	uint32_t sclk_mask, mclk_mask, soc_mask;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1012,15 +1056,9 @@ static int renoir_set_performance_level(struct smu_context *smu,
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
-		ret = renoir_get_profiling_clk_mask(smu, level,
-						    &sclk_mask,
-						    &mclk_mask,
-						    &soc_mask);
-		if (ret)
-			return ret;
-		renoir_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask);
-		renoir_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
-		renoir_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask);
+		renior_set_dpm_profile_freq(smu, level, SMU_SCLK);
+		renior_set_dpm_profile_freq(smu, level, SMU_MCLK);
+		renior_set_dpm_profile_freq(smu, level, SMU_SOCCLK);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
-- 
2.25.1

