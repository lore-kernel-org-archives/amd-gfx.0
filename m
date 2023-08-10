Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D2AC04A94
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 03:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F57A10E638;
	Fri, 11 Aug 2023 03:40:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D05A10E631
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS0/LYx7P5yURT8MtG4AVIl07dElgAcR5M1hUicZe6dEgL1bVtnLYjkRStw30aynmNAZfdhjCCZGxHkav7rbVVJuFaUwqLxYIeij0hC4+rCguTBlUNioHzaTap1AGOVHWBuWbn5V7T+2QB9PfHcNJZqyg7XwHTnSCh44mM3qkij0yl9+AG+eKOyZ3Zoaq7qROumEShNGb89GgxzrtMDxMfR66f3kjemqpi/ZFSaAXSTOddSDTar+T1jBvh4pvl+Rl1XJ/FLKMkqfHvp4tUGsenrWDC6N2R/t8RtaUfy2tDGd5fQa9c+zcxc7y3uF/5EPivbDuVdjub+qx4/xOzpiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxjZohQu8GjLEB8YE2vR5NQVayL+AzdK+sUleMkNw3k=;
 b=lwlpg4uyPnHlocmktMlpGXrFqur69uJRHeCw0mfs/n9ZMsauwCzqxf3L5wqX2EXorPrM3l49BS75IuajvZ9pncP71QSfdTiv0BPVMhjzXQS9Xz0Jw44TI/aN+3A3Sv7MgKDQ62smcaK0FexMupsVFPIBsH0o9gR5APsWCDitIXZtxrGCfzuCC1IpS00fofPg79I5vflU/xC5Gy2QD8l1f4Asu1V0251a44OHX6xkKZIKT8o6Uckaxc6MzyNq1XCEz7naYo6niEr6JXWXhgQrv233ETlInTo7nuyyvotIt3p7HiYSKqju9tiWzcBSAu+0c8/h6o8wxf8vCVuGoaEhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxjZohQu8GjLEB8YE2vR5NQVayL+AzdK+sUleMkNw3k=;
 b=XJuVQ1iX8ay9YZqLGISDvPTbgPvMnpACvejfxcf3o7yrszinfSrtGg5NLGy21j4KXZL3v6ZEFqSBmeVaPXnMPTCekNtpg5gVnjNG1Hr2FPwRQ4zl6NZbRFej6LfqYdyh9GNOt2/F4pIgMp0NVckk/xrD8h6eyGPVrj9wDBXuFKo=
Received: from SA1PR02CA0017.namprd02.prod.outlook.com (2603:10b6:806:2cf::23)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 03:40:47 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::13) by SA1PR02CA0017.outlook.office365.com
 (2603:10b6:806:2cf::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 03:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 03:40:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:40:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amd: Show both power attributes for vega20
Date: Thu, 10 Aug 2023 05:32:00 -0500
Message-ID: <20230810103202.141225-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103202.141225-1-mario.limonciello@amd.com>
References: <20230810103202.141225-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 92043e11-0bc9-42d7-72c4-08db9a1cbfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqTco3whaY5Sfxk6yb8mKlpgCdZVt0SZcFd73gc4IMKIHD2QQJL4hiOvc1VzzIYko5RhjtD+Kdm2cq6hOtc5Cbiwb0Prn35PZyVoIVjgZnHmdCbPnvbE3O6PcbPHKsnVxyuE0vKPPpZMEVbp3NqqDa8Im4e+aURkgHFgHtbGEwEy5o+SWHfLeDbnuUmzopAlUxATw6OdCaLCfhx2hLXiRfHQa7gUygYcB02dLYjfNnpMjI7WqPyF28laFkZ3ANCnfB2HhujS+1HwbJe7/uu0fMehp1+FrlY6nEW05pv9mGZIkAFDa/F9TSfM/g2Uj67lwZOY650iI40Uz/0Cl4Ngn0Nwm8x+LWMAeeYY6/r0JqvftO+C8+xzrekCOXSPqlbjE4MB7njLLmMWFc3JvKrGXmpj9UAIArRXsQTa9GBEBSPpnevUjw//dzCAjsDN/SG/D+vswvhjm+t0XRl+WRYjmeJoOHYLCcfpFsZjiIGIKcrAJ9KVvGwjvuRVlL7ietPxTsyAjUPnfuT6ssok8lq90ScPFzp5x/e8AlsZ7bLihO8OEKQWSbb1Str/4ZPyyn2fsOMSkQ3mIFsXJZW1Bvwt6cyQFhMV6kw1m1rMDybSeqWSS5a74Ik/kI7ZTOu78LnAf0FZrO4Jxp6knvrgqxJGQXDRmlLjsiVDSydx6AuIk2dH9EMBZAaEmaPoQAFTNLw+08U6n3v7oR+n3GYUYnNlLLaBT9fs6CQh/PC5wXdkj45VcJ9B2xEXnvDNf3yDTjEAoe16badDGa/NQrFOnoG09Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(1800799006)(186006)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(426003)(2616005)(6666004)(478600001)(356005)(26005)(1076003)(7696005)(82740400003)(81166007)(70206006)(70586007)(83380400001)(36860700001)(336012)(16526019)(6916009)(4326008)(47076005)(44832011)(316002)(40460700003)(8936002)(8676002)(5660300002)(66899021)(41300700001)(2906002)(36756003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 03:40:47.0786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92043e11-0bc9-42d7-72c4-08db9a1cbfd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Vega20 can offer average power in some versions of the PMFW and current
power in others.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index b6dd7f8daf725..ad40395be6028 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2129,7 +2129,7 @@ static int vega20_get_metrics_table(struct pp_hwmgr *hwmgr,
 	return ret;
 }
 
-static int vega20_get_gpu_power(struct pp_hwmgr *hwmgr,
+static int vega20_get_gpu_power(struct pp_hwmgr *hwmgr, int idx,
 		uint32_t *query)
 {
 	int ret = 0;
@@ -2140,10 +2140,17 @@ static int vega20_get_gpu_power(struct pp_hwmgr *hwmgr,
 		return ret;
 
 	/* For the 40.46 release, they changed the value name */
-	if (hwmgr->smu_version == 0x282e00)
-		*query = metrics_table.AverageSocketPower << 8;
-	else
+	switch (idx) {
+	case AMDGPU_PP_SENSOR_GPU_POWER:
+		if (hwmgr->smu_version == 0x282e00)
+			*query = metrics_table.AverageSocketPower << 8;
+		else
+			ret = -EOPNOTSUPP;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		*query = metrics_table.CurrSocketPower << 8;
+		break;
+	}
 
 	return ret;
 }
@@ -2253,9 +2260,10 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = data->vce_power_gated ? 0 : 1;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GPU_POWER:
 	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
 		*size = 16;
-		ret = vega20_get_gpu_power(hwmgr, (uint32_t *)value);
+		ret = vega20_get_gpu_power(hwmgr, idx, (uint32_t *)value);
 		break;
 	case AMDGPU_PP_SENSOR_VDDGFX:
 		val_vid = (RREG32_SOC15(SMUIO, 0, mmSMUSVI0_TEL_PLANE0) &
-- 
2.34.1

