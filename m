Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B913C11F67
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 09:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633FE61468
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 09:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633FE61468
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193826EACD;
	Thu,  1 Jul 2021 09:57:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8656EACD
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 09:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nma9QGRYDTPndBLEOJwjKd/DjxLt6V5QR4RqEngM8JEF2ON1AMpv4KkC8u3tORAXtHpVWTY5EOeFClf4FoFSU1IY2JebTP3+LHkjxM3qrNk+dYNwpphAp4R4k9eXlLlagQCGe9XjSc3SaPkGOdNCWDwps7wcqNfgr1EauCoLV/LQnpgMiUNUtaz27hVB27Bl/sHRmhQ8ndLoCzAQR8ZYJkusq5jHm90DLEixi2PuRmWFTkQCC4BKe9VMTS/1mFLpMnWJTj2hXVn8Tu95bRgpftK6gnY/KoRLQ50pal0JfsyJvUuFA+0d2FsvAdQ6WOfkTw4iz7aBTtBhjTxmUU/Aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ3+sj73vSAsuJKvZWAawzyYRbYVgg6xgiuel1G+gbk=;
 b=IEUhAZ3BRaKrIrTS93LvxNCUNXRSfE/0IILrbbk8vhP71SKU8Lw8lyW9Kzik2rQG/pFVm+JHXWqHZKHz09Ht2lYvHw6+6D/YrDAWMfHiImaamhraWu40co+fTe88WUbEpGOQ7gUiA3gKTDOiO3fxEpzO5DLS64dZgyUEW6/8+c4279XXxIfTY0nUYa3XVk6FoHeLrhtkZdafNER5slbNe75z6zKIBeN6Dvj3x7KjQ1LKwUbCA08vwj67/faFObVuB676ltgrJJe1HPd9uk/aEiKiUaZA8fZfD/mtHKcNl4UtBXVUDfAdyOBtH8+LcsmMoZCoa6yqeMA6fWiBj9G4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ3+sj73vSAsuJKvZWAawzyYRbYVgg6xgiuel1G+gbk=;
 b=bIRXjMgwjeXsqC+OSed+eNCn/9S6fJbIcwj92Pjkp0qwJ8Y6ZMMyrdQvuA2r3zEbjmF8He23PhlqcFSA0W3i1HzlN7vHD9hSCSlKJ2CI01uVnopzQAadYTTi1TGvHk6rfGQmfZZvWSEnqnGFhsmFRzaSoGQ0EUechlzZvXQalNU=
Received: from BN0PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:e8::17)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Thu, 1 Jul
 2021 09:57:14 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::31) by BN0PR04CA0042.outlook.office365.com
 (2603:10b6:408:e8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Thu, 1 Jul 2021 09:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 09:57:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 1 Jul 2021
 04:57:13 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 1 Jul 2021 04:57:10 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce delay
 (v5)
Date: Thu, 1 Jul 2021 17:57:05 +0800
Message-ID: <20210701095705.2133251-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36f20dc5-160c-4678-d0fc-08d93c769a52
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5538875445A9A8430BE3C247E5009@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmoqFqdsLWdZb45mEhfi0uLWGRvlB3irEzRg6fuTSIuK9pzjG46KNHWDILNRbUNcf41LheO8jA3dH0y16jeyGIV4OYgohzUnwMe2TkbzEjY9dECfOGjnwrwb3imHKRFKV2AuE55E9AXGTpr0ylgV+P2mgotqkxjkjCP56gqHLMzdG+bHAd3bDnGnnNmFdrUUBRZUNaiw11+ylstw1PcG7b6+sAZP8RfOLf3tExOpT5mrpR096jIlXN9d+Nt8Tazt/QfNbpaArw9p9bxSTPRkET8HnP+ziQKvqa02+HMLQa+tWPUVr8ZE/a4jt2oCZIziQhCSyZ2uqrYeSuQunv6Q/xN6m6S3WCYDTozj1IQKPzcliUsm181VrnpdYI41jj8lvd1c9HF4mg2qRGybx+TzLSw8+Bo5UxjNt14BdshT9Ft6cXgPOV/xk7suy9nkLvoaPd9SYpANF3Wi8FWKt6hJWr7txl8XNYD/rGA+/hqEftwHmSGgS7oFq8/5ciyy+edBpjFyJcfJu1j8zrIZ2fOP1pq5U/ikP905D0xlYMO8Nvp92aqZOrlQZi0rmTF7O8NNSWOB45hNerHfizBvSeihCNjxgsJOuJZmr5V6BWv9fdpGA5eW484pnb9t0CSU2F7SS0wz/K3qCpoYqcwrnAO0bzJXMGdn6e5V59NP4dRB8YGrZ4JB6pcuk4NKBVZ5MS8DEW8avNJLZAAyF4122WdQEgwhWykSim8RZwpltdjLloQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(47076005)(7696005)(83380400001)(36860700001)(356005)(82740400003)(86362001)(82310400003)(6666004)(478600001)(81166007)(336012)(426003)(70206006)(8936002)(36756003)(2906002)(6916009)(1076003)(2616005)(316002)(186003)(70586007)(5660300002)(26005)(8676002)(54906003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 09:57:14.2042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f20dc5-160c-4678-d0fc-08d93c769a52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
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
v3: Only check for carryover for once to prevent performance issue.
v4: Add comments of the rough frequency where carryover happens.
v5: Remove mutex and gfxoff ctrl unused with current timing registers.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Acked-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ff7e9f49040e..5f4eae9c9526 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7609,10 +7609,8 @@ static int gfx_v10_0_soft_reset(void *handle)
 
 static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
-	uint64_t clock;
+	uint64_t clock, clock_lo, clock_hi, hi_check;
 
-	amdgpu_gfx_off_ctrl(adev, false);
-	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	switch (adev->asic_type) {
 	case CHIP_VANGOGH:
 	case CHIP_YELLOW_CARP:
@@ -7620,12 +7618,19 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
 		break;
 	default:
-		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
-			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		/* The GFX clock frequency is 100MHz, which sets 32-bit carry over
+		 * roughly every 42 seconds.
+		 */
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+			clock_hi = hi_check;
+		}
+		clock = (uint64_t)clock_lo | ((uint64_t)clock_hi << 32ULL);
 		break;
 	}
-	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
