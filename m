Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6547C531DF
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 02:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3247910EBFC;
	Fri, 23 Aug 2024 02:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JDSywCVl";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0BC10EBFC
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 02:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eM9bao99HHTP5inSVZX8RPmrNYCj/EpxN7TxicFapKhVqQewC7ewO7z82M7CJz7sgkaYGNVerdNPeDMZtkd3WOWfejlI1hS5H0ATUIpwSNSx4OnEXyVTqEqn+XJ423wmeJOifopbUq6UWq48jOritQBsn2KISxz2VhSSQr7k7DeH8KFrHAztpYEmZ3hXjgq6Rg4rSHYVje5uVmtFXk6ETTxJbTsHsQuf0q133qyn3giTQMRnsPs6hGg6xKeNCWpFqI+gSCUZoSarYfODin48v+Z+yEwbBjQ0uP4FI66NAO1KSF4Ggg1enwHSnK7w84pytAjeW8/hd7g275HmU/h0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VP0OV4FApOkoOdacRtwvGmiPocR9QM+LlUOmaAGvl5Q=;
 b=ctSTVvJUrARl07cE+OOcuwXlkM3jgREJANhS8YQNFbULC1/pSrmhA8evdIwdSLtert3/yrme/JoeJbtAdZJSh6kukTcBbOUNBMjtrh7HIJ8vVwWnE93/9c+DMckXXWki8+rdnbx1krALc6Sq9p4r8snxwa19Lmrq4l5v9jI7SkIxni/csn7OaNyHW0VA0fthtIKKpBmPiSKkQhp3f2Nu2Lp27wrhdMBx0s/dR2cwyTLoLqb0HegWMnXGzdSFqPQjdQb/OY81JWVCDv6mz0mnK+qGDK5NneisiKDRDesMk3UN+qs+tYxJRLF2+fXeG6M5HHD4DgeFR4hUiMSPT0c6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP0OV4FApOkoOdacRtwvGmiPocR9QM+LlUOmaAGvl5Q=;
 b=JDSywCVl2ss24/g6qcdM2ob+Lc0nL/3LnMxo/+2AUA1u4Mo9O8yMWSA+dfAREEHh1ND8k9twQNe4JaXcwH8vdHLVitOmhhKeKueVvs0SPRBUZBkRAYj76cjovvj8IlGp7zFTXOiwjRXfXeBfvj9397qCYpScF4/YcZybbM/8d8I=
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 02:12:58 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::e2) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Fri, 23 Aug 2024 02:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 02:12:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 21:12:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: align pp_power_profile_mode with kernel docs
Date: Thu, 22 Aug 2024 22:12:19 -0400
Message-ID: <20240823021220.9928-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e214c2-d9b0-471b-4c09-08dcc3191b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HffFEOBnNS3PWunKyu+01ZCbqIz2Yj6NRbq+/Wj+3MN3oIvPHk5ASVj1Dnzs?=
 =?us-ascii?Q?NcgZ2EQCdgZHttmwrGZ2E2aRdwbwzUCqZDbVcTCSuFb40mH2ugl6X410ed7r?=
 =?us-ascii?Q?7qXjcGcUTCuiJBOJVu+/Pc64O+CQxaR1PEOBe6nxzJpRXWO7XhC/Aov22sMo?=
 =?us-ascii?Q?ohKoSlUT1zcx0GHfA0+Plab5KIyNMsmLznu0rrZDI74S2vITPY72xT5/zfJ2?=
 =?us-ascii?Q?D07MFcN+0K8Ng+24J+tbK1ROmr2YQfwaeOFQHjFaLQizT9WrzCqYvi090Zcc?=
 =?us-ascii?Q?iR/end/6xzx+AuOMxxsWtElLend18QxL13tcbTfSU879KgRQMF+XJqSYwmAl?=
 =?us-ascii?Q?h0IJN/3i73UaJFZ24/zD325++i47QJR2g2tKJsgbUOdDwutfRUXvY9y9Gzvi?=
 =?us-ascii?Q?4GhDSVHKSy78+t+I79T6aSZZsDRBxVj6QGFUz2KOaqlXH49bF4PS7ZG3CGYV?=
 =?us-ascii?Q?F41nYqWPfiXXwCD1CG/0MJFsFG8FQT5FNq7tyKd4t+aUbHiQ2gkrTKtD7IHx?=
 =?us-ascii?Q?ApVP3U88nFiJ8P/jcryHuOKjOLaU1QpahX1MZISVGeaxVIF6bmGZZ+Qwj07c?=
 =?us-ascii?Q?CrC4ooxETejXweooCZIz5QLC3a6D6VHZp/iREl8+WMQp4WtqhLo7gAmc5hCG?=
 =?us-ascii?Q?nON+HMFEI3Pr0DpPL5UpYqtVEIpka1Oe7QrA2V3dwVB6tKRVCpKOqrjD5Pgp?=
 =?us-ascii?Q?zJt2kNLFsTzjzcAuiXlqUSNfsL4jwYwCDOCPJuqYKZY0tBeDCzfgZwM1bn7s?=
 =?us-ascii?Q?/teWO1GBTHGI7d/EJZuJT7pmccHyEmz9Gk5hMx4XiJ3JYdpGMsLXGpiFhq8C?=
 =?us-ascii?Q?KzPEkM/h6Ma4w2PuEhfHio5sUPODBhDWHL5QNW9WyyFWRXhtWuuZbSLE8i/j?=
 =?us-ascii?Q?/Li3h/sKJREU0D7AWzw8cxq76d3jXQHJ5QeAZcdji8Fa8aiydXkRVAATyU4C?=
 =?us-ascii?Q?gPI6HyiRiCsDt1IpYaYZQFClQQGaYGkQ5PR4PmeiN1NNz2kBKXRoRmzHxn51?=
 =?us-ascii?Q?eM/3/cv1/7kVgeJZPuG2b3Z9V1Se9ElRJ581bm90TFvWXVyD2aCfbTLsimur?=
 =?us-ascii?Q?ODnHydebUkvwHmEC27JrsGaca57i/sHAgAsSUa0ariN+8hxl6IuMeHo+xySg?=
 =?us-ascii?Q?wdRA0S5YoIu/XdzqKpZCzMHcvlaE29u4QUsguvohTqXmQ+7RHxzIdJlycrOb?=
 =?us-ascii?Q?Lnf7exmUeXE2p+6z4zcXwuoyGiaEkY0tzyz9Q2CLC6dsz8D21ujk+tsQTG6P?=
 =?us-ascii?Q?OznEx8ABK1G2yfDp5MeRjMxP3dTUUTlvgF2GyftMluNhWWyddmyokXRl9Iim?=
 =?us-ascii?Q?rk7tq80hi2ZAMcGhfDNGl5iqSDOgh9wJGvcfJlk63/ml+br3iV4f4gsYzOUU?=
 =?us-ascii?Q?b49LmLNgyv6loa2yRl5e5ZD4e2/qgavkQ1q3QRtz1a7i5dk2SzZYW00xfOTM?=
 =?us-ascii?Q?LJIKHmiXuQL27rd1lnQ6DwGwbzJ9nZqQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:12:57.9815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e214c2-d9b0-471b-4c09-08dcc3191b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
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

The kernel doc says you need to select manual mode to
adjust this, but the code only allows you to adjust it when
manual mode is not selected.  Remove the manual mode check.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2cf951184561..74e35f8ddefc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2266,8 +2266,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		smu_dpm_ctx->dpm_level = level;
 	}
 
-	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
@@ -2346,8 +2345,7 @@ static int smu_switch_power_profile(void *handle,
 		workload[0] = smu->workload_setting[index];
 	}
 
-	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, workload, 0);
 
 	return 0;
-- 
2.46.0

