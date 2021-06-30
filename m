Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5F5C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 10:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAC16162C
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 10:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAC16162C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0744C6E0EB;
	Wed, 30 Jun 2021 10:10:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449276E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 10:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7e3aZIF7zbq1W82h086nms4gLdHBEzk+MTF0VpUtVndscH0wlrD7nl0JWYOYTQT90BmImuLu9M45t2nhh+Z79KZ7rvEmIMyOJGFpb2eAVS1hxLdKH4WlRO3W0qveq/2ork3SyqbuTIkpGgu9l96aJLw9x/VqX8tMQ1uFx0bMzJ7Fs3V/UrY8POnGzGhtyCictaUFvOd1mwU8oDVSsEL8EElY0bbz4LHAPuEEo2TZZCWkYHQsxnuMzuA3UDIuloE0ppuba4R69zeOVn+D2xbsrh6gHTsdowmA1iE9OM+x86hE0qPVtLquQ6Lg58+Z9XTkgmU/wwbVCMJICCqBNhEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQjnrD1S0xl9nopeym4kMJkPox7PgVsDpg3GspcD7Cs=;
 b=QkwwoX1SoBBdz8q4j7TFHaEAg0pJyMsc/qRZnz5KoFJ/urWK42vhbJ18u/zznieDzaYOPx9Mo63YJ98j49aCGGGYKCkRfZ6mT+eq9HW57eGzP6tp27qSigIq/hZNovtrG2n4bTf19bU79K31MtSHGit5pntlZ4W8IBOVKaNgFRjBcFgOQBi9jMJcqZ2XxCtYFza7Q+CMPjasFeCrKcaQC61b4HTRpopyVC9BLfnu06aafZlZWsRaX06DLTxaPRINSTwqmtCY5T+/eXPAqcY/ji7tBP2lu9qgYqKK3+1YzeDbrhStcBRRauhYzG1GNMwSuyNNWsBHO1ZcWFJoNmw7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQjnrD1S0xl9nopeym4kMJkPox7PgVsDpg3GspcD7Cs=;
 b=LIBIQVdCJoAB+IG8jQRFoKYc0/bHXZOcsWh8awM9c58pj1+mSRhrhkEDYvjTYP36DmZ4se2uW9G5qqMzA19V2g4QP/T18MPUSy1P4rof6B8j3cYTBVfwNnVsZD7gXanLGiNa7MUYDjoW32uEj4SQBlRWDFLlQ8/rZghsAMF5I+I=
Received: from DM5PR15CA0030.namprd15.prod.outlook.com (2603:10b6:4:4b::16) by
 BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Wed, 30 Jun 2021 10:10:21 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::89) by DM5PR15CA0030.outlook.office365.com
 (2603:10b6:4:4b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 10:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 10:10:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 05:10:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 03:10:19 -0700
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Wed, 30 Jun 2021 05:10:16 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce delay
 (v4)
Date: Wed, 30 Jun 2021 18:10:12 +0800
Message-ID: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aacc6b6c-3c1f-44cd-f9c0-08d93baf4484
X-MS-TrafficTypeDiagnostic: BYAPR12MB3462:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3462E7F226C4CE8FD8CCFE42E5019@BYAPR12MB3462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Web9QyLrXKBy0nwlII+xuziNuVhSBSNbJJYyOiQlpbs6rlxHJxISp6lzk8WxF2a/iv/WCBd9wItdFRlIVyWiHf0hWyRK63k32ITNjgxjFy37rlLZS2HNVdUNd01T7zGP9kXofzLCvv5VNbD8qa5W3pEjnjq2xIgsCY+ftCkr7mQzB7S4WhjG6dmP835SaPVLz3HWFD8ZtUlKY4SKB+oyptlzrqE+BF+QtEl7dCUik3Tfi/3W1NyR4fvRmPPGQMPzl2MhRbCWHRSH/5mdrbZjHsVDq1NLxJcnU09UkElijVRTE4Tx+7mYYPy0shlNQmdztcLkY1FWku5kmK7zaFWas2Va3OHcz//pSZD/E69axR0CISbUqPMQqXrSUTizQ9ldZl0Lo842yrf8zc+POhoRjhG12n3dxtk1FZB9oW5Zi6s1eYDbzJeDJPXmoLJrfrzUBFoDeINrIIGZ3KI7fY3iEyP72T+i/jgC4L91w2Arlre+S3ky8NQEgsYYRwIYxE/+hB+2xPJqwN8IksS+pu0N6Su1IJwBqfEMy89xhfnoAE78hHULHHyJ6SI4/M0ozh0nbqlbdpJSmnLluPL/qNOv4ObmcmzVnn1OVQcAS5+HMUOS5fk2Kwo5lKMW61pwT3ClUDd4eQ7UmD8Vqcx9S5yv5eqs0YMGajX/M/yL/8LTa4GU9mOXjIcVk5r2OVKA85j3ghveSpvoO12pjTtZXCZtJ6tW5iLI+Mj/7BfEV7nMqls=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(316002)(86362001)(70586007)(26005)(426003)(83380400001)(6916009)(47076005)(5660300002)(2906002)(82740400003)(70206006)(54906003)(36756003)(6666004)(4326008)(2616005)(7696005)(82310400003)(81166007)(8936002)(1076003)(8676002)(478600001)(186003)(336012)(36860700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 10:10:20.3367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc6b6c-3c1f-44cd-f9c0-08d93baf4484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
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

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Acked-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ff7e9f49040e..9355494002a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7609,7 +7609,7 @@ static int gfx_v10_0_soft_reset(void *handle)
 
 static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
-	uint64_t clock;
+	uint64_t clock, clock_lo, clock_hi, hi_check;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
@@ -7620,8 +7620,15 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
 		break;
 	default:
-		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
-			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		/* Carryover happens every 4 Giga time cycles counts which is roughly 42 secs */
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+			clock_hi = hi_check;
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
