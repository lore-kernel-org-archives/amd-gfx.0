Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED75BCD3445
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 08:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CFCE10EFD2;
	Thu,  7 May 2026 08:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZaWylMrH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EA910E7B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 08:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cf5WyHbMcFzBEnbiGxfAibDtF8ckrUrIg4Rq6PXRcuJ6EOphI8joqMALYzIuvq5fkoYti6L56iKuNn0ApBjW1bPQ4vms9/BEO8UYMm6PTG70c5odPIos/FK4nwCQWJjfrBmN0ByzE4ZEKjl7ebB5jJ5tyxsl8RjfT1XXdi/GSqt4i6nL5FYf1H9GErUmIs2lsZva/OTZ807FypF5CaP+VwzI5ugKly64kt53v/nFCUHa0pV/SiS4O/LYjlmRG40Z1yGgB9+7g3MJ/EX9esHYOgozjYgcXfmzckDdZ2PJXiqloU//BuKkNq/YFein9XZXXzPq/VBbkYlenGoklIVqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrdpvSn9wvYZp8TaVCaDyDrKeOAYRpwP/AHIlHNjsy8=;
 b=XbMOmNgSojcMA7w20dXRvA9I6strp7zGVuFpHdQpP6q1FV89YxGRB+PJI0yHIJMGECF8EWM3zCTg1fbw4WAuGNL4J6U9C7ZyJJjBnjOV4DJlxNHhq6jlwb6nVsuyS11gpSNara+iengTlXM5MQ9jjBCtJwhf6C+mptydvbxDey32tVE/3XxPxepTgMPoabWgGlJ0y1kI2d7BbGW4VjZ6IB3zgRDRagPbLkxBubgL0X4ZIkH+Nfx6PwR0YcA3CSv8Ja2WLHguHedDimznILD9duWhquMoQQO47LK+Jlg/v6AtNiNvWeLVV2W7hL2/6SuDijfa3LXRZNM49yH1Y2L31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrdpvSn9wvYZp8TaVCaDyDrKeOAYRpwP/AHIlHNjsy8=;
 b=ZaWylMrHbvl0zqXRxcw1aJfx7z0Klt5/8RkbjystR6jzAH9cUyYKDkOmMTuNAa354x2q8rKxsqTDvUbdRxa5dYBozXlkhq51j2E3HBQKuyILLYNtVE7N2J8dtYodivz8/zgnKzAIsx2hN3tl3EVVfkhFKpidtrqnRy0qJbBWY2U=
Received: from BN0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:408:ec::19)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Thu, 7 May
 2026 08:02:13 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::21) by BN0PR04CA0104.outlook.office365.com
 (2603:10b6:408:ec::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 08:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 08:02:13 +0000
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 03:02:11 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 1/1] drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
 set_soft_freq_limited_range
Date: Thu, 7 May 2026 13:31:37 +0530
Message-ID: <20260507080137.841442-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507080137.841442-1-Priya.Hosur@amd.com>
References: <20260507080137.841442-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 551dfc37-8dd0-48cc-a9e0-08deac0ef28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: XuQdRG1GxV9Ax/is4r+yMDsxu4TLogDotenzprtNUB9RVJcCVCIm9lejnhke3IBTD5eRsLCZHG576EA8BUBSk1khwAzKtsbcmWiWBsnKPvNf/BLgkmt0mJClGeNax6SYw0cAQ3A62nZsSEJChVs/xFwTTqhof6V5ZqcG5Iz35EbSeXiInC5Y2q0C8I2twuyNTU1KmN+jX5g5i9djaLDRIegjSnTJUGX1XWEy+mkKwvv1JmMjLNXcOLre9wVg32wbXMxudb1duJXMpbg+EQeiNlj5BZ7ZgWrJkTvuMU16SApMO4IKXVg9fJBhw2ECXrrWGxoZ+4JpFprVQMELRQ4Jusc6jxvdvxG9Trb3366d2mxC0y2PpDPBiwMdLJz2iS69tjQ7Zkhl57m6ZQzgyw6+8CxEVlegjDR4sHdbfBqGhu+1RoK2ik+enwHEOfx/i4BnKDACSArYrL/EbKqKbhGx47ZN89lQfNFKFmdrlVIi3fF9AkA5UFSeaGeiCsdU8VKXf1GFZj0QwbgTDlqzh60FAff1T2ARfTTBTYXktYRaTZgOpHsceqva6fxdJd7s5/yNuzk9lQen3KT63G+2EPYFQP4rpdLhubwAGR97FyHlzwx19Re3F2TsMbLhNoMyXtBKUWGortR8Oe//pH448zS9CSvPN0r3wlttla00Q2FCdBnhnNSet4tRAxdKJWVrQbCQmKIUs0cGwwrGw1xUyzjv+/m6pyq8dZVM6vEWXPIMJiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NiDjXkuWPpWPY79HJCJ1eGGUv16FxieGtI8x+coGnWb8OsOrFo5eZNuHEFNohljd1UjeykE98DePhvr+u+S0ZYnFfGfJBSPi6p6+IO/eEhteJsTnKhhsvlKKm0hsbKtHt1IE+zhxKvOhBiY+abyPc4WLqTreTW0kwPMDSeFX5d0WcrbyRJe0oPHh91/NNYJxi3bQ+4nZo3ejGBhoSfa28Pbwr152pr6k71hYERZQ8AIwSqJ9CSrFAQezvslX+HcwEthBgOrj5AM7lP8s7IkIZCSnR2SSqTjerNAA4hQSiUuJpCY/EhyNgNCjQrT2YGT5GwGdDNE63RIR3Nl1WYm/ME9a7l7bAvQ8TX74o/LmQbys3GlcFGwD2r0iSMd4Laok0wxBZeuAELB/SqsLY6PJgis0KoX9Gh2BCsHzz5e3OvhilrmT/UMprqKcsgfZIP0F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:02:13.1628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551dfc37-8dd0-48cc-a9e0-08deac0ef28c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
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

In smu_v14_0_0_set_soft_freq_limited_range(), the gfxclk floor is
programmed via SetHardMinGfxClk together with SetSoftMaxGfxClk. Under
power_dpm_force_performance_level=high this pins HardMin to peak gfxclk.

In PMFW arbitration HardMin has higher priority than SoftMax, so the
firmware thermal/PPT throttler cannot clamp gfxclk via SoftMax once
HardMin is set to peak. Replace SetHardMinGfxClk with SetSoftMinGfxclk
so the driver still requests peak performance but the firmware
throttler retains the ability to clamp gfxclk under thermal/PPT
pressure. SoftMax handling is unchanged and no other clock domains
are affected.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index c76b1f07885e..2fe006de927a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1231,7 +1231,8 @@ static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		/* SoftMin lets PMFW throttle gfxclk; HardMin would override SoftMax. */
+		msg_set_min = SMU_MSG_SetSoftMinGfxclk;
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
 	case SMU_FCLK:
-- 
2.43.0

