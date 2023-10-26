Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A218C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 13:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00CA810E7DA;
	Thu, 26 Oct 2023 13:35:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFCD10E7E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 13:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buMdfTAB1u2iJ25MRxTusWOq2hJhn+uORp+x2wYBFRKunZsc5yNjgD9sc5xREQFQHMlkWciRbQ59+uPFPYKKkwWXbgoT3m17bLmSdDThSmFPjua+PEnqOegdoW2BWiHTu7fkLsn+0oMFnDqEeZ4f2gK+hB9mydjllNuUX7PLWh/OwHyzn/D+CkTWiJe9VPp6Aks+IbGotMz+0FZm+JekE699BR+uyMHcNWxCKigNV7IsZUMbgdRz9ViZjcTAgFqDfZpidjYz8+6IAs8SPelnPwRa1/vurHMltp7JFPqR0uj3Q77VRMdIJDg/m3ro1wTK51jdSVp2MDuolr2pxbatmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5313gU9HwfNVJGY6Jr4wLVIvA8Y4UzOR/CGc+l2yeXs=;
 b=BqU81wOyj676PrabTdZjpcMWhn9a94EbmdQBAj2KJtm3N41m4au6KmQuog6lVRZ4FubYp2S+s5l5P9+kkSLu27VgcuSDf2055OnFm8BaBXV1M2xVhqAu5p6ucp7AJW4S6ILGe+TQmLegLzJV1qY8pvUb2+fltIBE3b8e4MuRYStpZ4xDQode2BKNAsEKpTqxFuy49zmtUfPthiV8fdQjij/5In04/SUuOHh1BizDd5KQe8qcQZvvVTe/rj6gxRLDgyLazBDQi3UktG7mHKXo1YRvWq3ROWk+4QoAt/gUv/lmhFkeXx5I47k2ESGxmOyyIz5MOSOMqyHRfKtibmac4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5313gU9HwfNVJGY6Jr4wLVIvA8Y4UzOR/CGc+l2yeXs=;
 b=oNgExwcWzMqgoc7Hr1m3HahbtV2L7LHstU0tvEEq+uML+PBSzVSFFFh/GbKaCdh2QB5NTmMPilSptukU9uYbTYTZ7ihIsG/HI149CkJrXiEbRckATB6yqamJw2cKoN0b9MoWxLu/RlkupWhVpMYC+/FsrtE+UXcNZwxE0Bfel90=
Received: from BLAPR03CA0049.namprd03.prod.outlook.com (2603:10b6:208:32d::24)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 13:34:57 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::84) by BLAPR03CA0049.outlook.office365.com
 (2603:10b6:208:32d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Thu, 26 Oct 2023 13:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 13:34:57 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 08:34:50 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove amdgpu_mes_self_test in gpu recover
Date: Thu, 26 Oct 2023 21:34:36 +0800
Message-ID: <20231026133436.1716057-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6412a8-686b-43e5-72c2-08dbd6285840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6V21Q9hfqjbf09CuGbsq5cCcba8RxPffgRFav2K/aSL4kafTwLpDk0/CxdIwa57z8ZGWcectjwL+Y+UrnBKupYv+GRK6PDbxE4F+9fieLI+bX0Rhws9eC0DZ+9dpkZmrzeNyXI1nwiNDPNe6X9y5CwUQITCxtnCG7BRTgDt5t8vK4GdXv8MQ8UBoD79lIPrMwbPi6TP0JXkcFjPFjLwLWdMIWN3siIwNdyGFsAhfgYbxfoyjG0A9wdGVDTNHL1ix8dPjrjbrLL8wPiD2/H/2vRRMAxpxSSNKKHZbsVtBra1jZsSYHYBq3u2DVVPw3Yp356h31hKTEE/8cRDUs2S60qPKfPcMU1cgqlXhnMSpgi5QB1DBoH3LbyYQjnGaqfINjkWTOw+x3pzJw6mklwdppivv29Twup6st1f1gRaBIT+6KDGwtUiI8XUqdGpAhS527bBh9oZCxdVWVlcf4RhoTsOhmhKkC9u9xcJD3IHwKOXYjsjyK1JO5MLbIdoTMyulhEI4gQR63x7tEBqs+UhwtLO+AjEkAI5z4V+mrUjr4LbMMpZSzKoa1pQER7yfR1UvcrLXnO0+Kdaszg7uycBtrI0b1PPCrLpR2KbmLy/k7sq64ESmQwxQbwD3lxxTNI92B58L933+0fPW8lKRuX8x9jfzaFoJnUzWWYRFyqeCQl3snPfCM2Gs+hpHCQZqQ6Sx3aS/2ePm1/Ky8qbWqK9dM61HRDzKF5B2G1Ytj1TBUHZC3nLWtmcupUKa/hCAUbT8elZL5qRM96iulCeaRDMXvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(40460700003)(54906003)(40480700001)(5660300002)(6666004)(7696005)(70206006)(86362001)(41300700001)(70586007)(478600001)(6916009)(316002)(2906002)(4326008)(8676002)(336012)(81166007)(36860700001)(356005)(426003)(2616005)(16526019)(36756003)(1076003)(47076005)(82740400003)(26005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 13:34:57.0243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6412a8-686b-43e5-72c2-08dbd6285840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>, christian.koenig@amd.com, li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gpu tlb flush is skipped if reset sem is held, it makes
mes_self_test fail since it involves add_hw_queue/remove_hw_queue
which needs tlb flush functional. Remove mes_self_test in gpu
recover sequence.

This patch is to fix the recover failure in gfx11.

[ 1831.768292] [drm] ring sdma_32769.3.3 was added
[ 1831.768313] [drm] ring gfx_32769.1.1 ib test pass
[ 1831.768337] [drm] ring compute_32769.2.2 ib test pass
[ 1831.768399] amdgpu 0000:c2:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:24 vmid:8 pasid:32769, for process  pid 0 thread  pid 0)
[ 1831.768434] amdgpu 0000:c2:00.0: amdgpu:   in page starting at address 0x0000aec200000000 from client 10
[ 1831.768456] amdgpu 0000:c2:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00800A30
[ 1831.768473] amdgpu 0000:c2:00.0: amdgpu:      Faulty UTCL2 client ID: CPC (0x5)
[ 1831.768489] amdgpu 0000:c2:00.0: amdgpu:      MORE_FAULTS: 0x0
[ 1831.768501] amdgpu 0000:c2:00.0: amdgpu:      WALKER_ERROR: 0x0
[ 1831.768513] amdgpu 0000:c2:00.0: amdgpu:      PERMISSION_FAULTS: 0x3
[ 1831.768521] amdgpu 0000:c2:00.0: amdgpu:      MAPPING_ERROR: 0x0
[ 1831.768529] amdgpu 0000:c2:00.0: amdgpu:      RW: 0x0
[ 1831.931229] amdgpu 0000:c2:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring sdma_32769.3.3 test failed (-110)
[ 1832.062917] [drm:mes_v11_0_submit_pkt_and_poll_completion.constprop.0 [amdgpu]] *ERROR* MES failed to response msg=3
[ 1832.063107] [drm:amdgpu_mes_remove_hw_queue [amdgpu]] *ERROR* failed to remove hardware queue, queue id = 3

Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")
Reported-by: Li Ma <li.ma@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ec32b44df05..5169e55b7fd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5557,10 +5557,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			drm_sched_start(&ring->sched, true);
 		}
 
-		if (adev->enable_mes &&
-		    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3))
-			amdgpu_mes_self_test(tmp_adev);
-
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
 
-- 
2.37.3

