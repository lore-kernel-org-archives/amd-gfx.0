Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF0DC7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 21:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700C710E686;
	Tue, 11 Apr 2023 21:14:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741E110E686
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 21:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g70/uTmjvVbJ0rMylSw+1F7LpvwsVFWFA0qGETGromMv/j6gtxue9eyEep+Cs8Y8jI74/IpHcCYpEFMGEI1FVcWs+MfbcKGOGfz9bP7c4lY25d04Ez2DZVGus55nRMOIMzHl2kn9CY7rLGpVXDocRDztSfN73KP+rC8zvMCBPSpQKGsHnzVK78EkfuZOxY6o5EWrh8p8ekqOIYFqUBprXknaY2PyLX3c175ozNG0D3KGMhvkBgZuatFRNP93/BLgSQmllokdCI5CaCYd0wNRt/u7Sutrhi8/Bly9v6Vo+yf2XMqDmGNFlc4H2xXpg14VsNrdrYkPr4E65nczKnpjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXbFP+23M8CypFBwd8XkrpEVk6mYr81qXVE65apsNB8=;
 b=MyOL8bVUkhXrjNDzwYdGd+80wlzQwf1a7LWqTDO8kwjR8qWNsSmOJ3ZbB0mdLYzll0oP4OV8TCJgoIbUqB5x3Tg4HNiwj3qe/rDYAXn0txJv46pYH+a16IaiWHWBksv/aYqMxBhltkv1A7zUp5fZBeArQIgMr0krqtygh0UH2/WwBFFcSpe1iqCrJDEi6mW5GaG/3iYhSqoiOZATR8+FA+RAX1n9GceFy+ng86s4oT5FTzGfV1iU1McZXOmCPliEL1Qc5bB6ONh0/e08cVyiPUSaCDBVPSTVHgU1flPhUg9jnqbvLcyZ5KS9har8Ru+TDr3Ja7I9e7+oyXrksl71Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXbFP+23M8CypFBwd8XkrpEVk6mYr81qXVE65apsNB8=;
 b=QpQ2gPB7ZHSGCVRRyTb27BpNyBt5LMu2ey4R/TUoaWUqyTXVVrypYMY0S+QNz+TxDy8FPUkjzY78099C6i4FSBZJ8jiOYxevbZJmtK0aqhnZUeYrb6UiKradJWlaCcOdL0Qgv3DIZVYYjW8EKIHFHeiWLAfULFY9VjfEzrO9ON4=
Received: from BN9PR03CA0938.namprd03.prod.outlook.com (2603:10b6:408:108::13)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 21:14:37 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::f7) by BN9PR03CA0938.outlook.office365.com
 (2603:10b6:408:108::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Tue, 11 Apr 2023 21:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.29 via Frontend Transport; Tue, 11 Apr 2023 21:14:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 16:14:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu/gfx11: update gpu_clock_counter logic
Date: Tue, 11 Apr 2023 17:14:22 -0400
Message-ID: <20230411211422.871350-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 07db0a1b-8735-4b8d-6ed1-08db3ad1c1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3yc+nH+S05ZOjcRrIUaOHw8n9WPGgHe87lSfouHdeZEquZnsdOuksSdD/dEcZbFF6HQRzBVwBltKXGWdH/Qda2ynhpwFz224V0glTb2OEHzu9ZtcOU4ewkDPLPmVIOfyFZPIgpmkvPxFqPZSnqKN2rBkJiNE/5+7YjjXviog34OdMZIJeHr3ivdffYRooMnl0ecAjEEaKf7S1RUWZ048HowQh/V4/di6gUMwXQD3zkjGmH9mHBbHH7gDogVk/iApqrNC4kJis1VlylnMafKfI/f/GEXM3njniz75wr3xaIpnBQL7G9uMDFZI5S/crsaEsB7TOSw1ePK6VrTQg/wP8sJBHLMNaoo+VbMO8VFWwJWDS/ehOslX2w/tRVEUyR+HxoOCZ7+IG5n3S7vuFnxJhC9T8JQgdrfboqhMK+hr8CCbW0Q3L83plbIZvW22J0GeAvqclcY+dZpoYwJlyFUtHV6M/Dwt9uHQjqFg3STrsEe5C81BtVSVVqr4uspcPoe+8xfm8gRlydtxs8LjwXQH7t+IX7cWQn1IWgZ3uoOU2jEwbu/L/BJ5sQCBVsd4ko1sLbVNltmjM2obq37y21vsvt96M74gDvM+4R6jdF1MzTSJ/oYavqzSC9x6lvMe4aizDXiq7nn+LJoHnH2lhfyJqxwUAZ93PR7hGqDJYwwe6UnB1tPtky4HY/SRYprz5PgW2k9bRs4Bsj2XkJp4O0qHE9ZClf+tUHBtGBmVnLdPFg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(426003)(336012)(36756003)(81166007)(5660300002)(41300700001)(16526019)(316002)(15650500001)(40480700001)(356005)(82310400005)(8936002)(6666004)(82740400003)(6916009)(8676002)(4326008)(1076003)(26005)(83380400001)(70586007)(70206006)(186003)(2616005)(47076005)(86362001)(40460700003)(7696005)(36860700001)(2906002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 21:14:37.7547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07db0a1b-8735-4b8d-6ed1-08db3ad1c1db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This code was written prior to previous updates to this
logic for other chips.  The RSC registers are part of
SMUIO which is an always on block so there is no need
to disable gfxoff.  Additionally add the carryover and
preemption checks.

v2: rebase

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 107c487c0c37..00a06d353abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4673,24 +4673,27 @@ static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	uint64_t clock;
 	uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
 
-	amdgpu_gfx_off_ctrl(adev, false);
-	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		mutex_lock(&adev->gfx.gpu_clock_mutex);
 		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
 		clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
 		clock_counter_hi_after = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
 		if (clock_counter_hi_pre != clock_counter_hi_after)
 			clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+		mutex_unlock(&adev->gfx.gpu_clock_mutex);
+		amdgpu_gfx_off_ctrl(adev, true);
 	} else {
+		preempt_disable();
 		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
 		clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
 		clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
 		if (clock_counter_hi_pre != clock_counter_hi_after)
 			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+		preempt_enable();
 	}
 	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
-	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
+
 	return clock;
 }
 
-- 
2.39.2

