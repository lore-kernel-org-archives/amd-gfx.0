Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E04C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 09:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083E061DAD
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 09:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083E061DAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3F86E836;
	Tue, 29 Jun 2021 09:47:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9815E6E836
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 09:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVmrYXVtODFz2+HyfJF9OFGVHhMGP0Rkp88wFAvSIonfvVETr+kH/D5/SftuEphxgQ5j8LXjEw/Wg0yBUPQfXEAMTjxaY+/gZG82qEWxtv62wMnCzNJc3aEFmxdhZ6hJYQhqAaD3nqt18xLX0DJ6T5q4Of35VN/CI5afJAFAQM65V25NISJYNrhCB9fCbP0XOb7tAou5waFUqPT/ezDmNU8CNKvv7HDjVcGRHUSzpR29ma0cixK5CoyIskftn6b7zMBM++FBXCzP+7r8TWE46itZ3yQsJu1O39QJR+fctRrttmuwbfinc8m8VxEZ2pgsl2b7B+DdHDZRrLvuMGeLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7yyw7YMAWa34Zo5D/d9NWXSnaluiAy5r2ptE3GjF54=;
 b=i3CMowPQWdHugqnG86MpfzWfDVrZDZeoQRa+dAjqwX+BH4nqfvwtpM5+i4pZMRskKuJB3JMb+A5584BYLewO5S8/SJxZ2lpFJ9AtLu2MJKYYVjy3jZuL76Jy8gvfkinA6RYc05iZGd50u0P7NCRJgkmbjcAyuXandT4mrWs1yEkYbqxsuMIaKcEhTd4MLrN7ao540lxKPp8TiK8iZId841+Fu4Us/Ws8DCEDOVuJYeEBxY7DNBJWvm4j4IN106eQNCvgQ+zVdw3+MbV3O2Fi/+Muw9/zzigZ4b8R7vx79fxBYjMBPdfdcVRLs6UTxIUKAMtoNLSrulTRRKSyLbY+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7yyw7YMAWa34Zo5D/d9NWXSnaluiAy5r2ptE3GjF54=;
 b=uhHHbYm0tnPkw7IbkfZk0oqgSdGSySbf2btOZdwb1SsbLJJoiVaNBjF4p0y46TBgpvEA72gg47Q89g/YG96vurU9cldH1BbiYpOBQlaZohmbpEKhTHMngyIARK3uuPSQ3GLvqHKLA+vwgjh+R9mnwo0ya247U9xbXwu4VRpak6s=
Received: from DM6PR04CA0003.namprd04.prod.outlook.com (2603:10b6:5:334::8) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.24; Tue, 29 Jun 2021 09:47:27 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::c9) by DM6PR04CA0003.outlook.office365.com
 (2603:10b6:5:334::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 29 Jun 2021 09:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 09:47:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 04:47:26 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Tue, 29 Jun 2021 04:47:22 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce delay
Date: Tue, 29 Jun 2021 17:47:19 +0800
Message-ID: <20210629094719.1912299-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0ce5350-40c9-4b09-491f-08d93ae2e77c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0027:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00277E36C3C63056728C0A7EE5029@DM5PR1201MB0027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:397;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/J1Mj5cHPF5jYb12uVFbQS/VWlwxAbET7ocJWBQIvC9gAZnnM0FOndNLH6Nay4HUeAQ678t2iKpHncyxhga+qNKvHlDOoEmmM+lbhyOzScfiVtU4hb6NdN163c9UzpLubvvyAL6GQmxKFOuoVFS4eebjiPuhoMSPSYu+pBF2YsY/JC2BB5fitbOdJik8HhzC20ABME6A/tvozV1HaOLIkOhfG4a76pIS3Z3+6fZF0KKBAyyeModu4au0el1yY3W/gvipMPTSaWbjN7889RLP7MTZmGTJqB4eyErooM09nU6bRdvyaKIC3kC3T9ODi2zaBmhJGrilArdg+/3xpHTflyWwrAmgo1CPfjDsQiAVEywE/qd8zFyOuXmi1QEC7x2iThl2BZv4WZQQcurSxnafNIHI7zelwztr5LRwquB7glwOnJ2NgBjErqKrVVGqzZFgfPB7UdHVOyCQ/lFqWL9dRv3CSY8O6K1dDDiHAL+X9wD2MOBHrXzmy4THOCpJZGV2O8i5bRl8hft84XTc0e4YVsC/K4ig6CaH//hhrdVlUuh+j/zef6IZpjv9SjIpeJec2XyWN/I8wZJjpOW+GnIA6U6fHKcjga2K03aEtJZaV1sFnjgo1RC2dBEAA0RVSuEikvnk5pdzNQizZneswM37UtYzlZj/Q02VK/WSXdIsmvS32lwPU2ttbHQgzei+YBkcD2oDD07oOohGh9n4WItKra99WMFlKyQJtMnVdBRSnI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(426003)(83380400001)(336012)(5660300002)(82740400003)(1076003)(356005)(81166007)(2906002)(8936002)(8676002)(478600001)(6666004)(54906003)(7696005)(316002)(6916009)(4326008)(86362001)(26005)(70586007)(70206006)(2616005)(186003)(36756003)(36860700001)(82310400003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 09:47:26.9198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ce5350-40c9-4b09-491f-08d93ae2e77c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
GPU timing counters are read via KIQ under sriov, which will introduce
a delay.

[How]
It could be directly read by MMIO.

v2: Add additional check to prevent carryover issue.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ff7e9f49040e..191b9e3ee3ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7610,6 +7610,7 @@ static int gfx_v10_0_soft_reset(void *handle)
 static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
+	uint64_t clock_lo, clock_hi, hi_check;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
@@ -7620,8 +7621,16 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
 		break;
 	default:
-		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
-			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		// If carry happens, continuously read until no carry happens
+		while (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+			clock_hi = hi_check;
+			hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		}
+		clock = (uint64_t)clock_lo | ((uint64_t)clock_hi << 32ULL);
 		break;
 	}
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
