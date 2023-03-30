Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE4BC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAEF10EFE1;
	Thu, 30 Mar 2023 19:42:52 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F95210E210
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmpT2W/E25mTed9n/9kX3MNgQUWMAhX2VrUNEPmdjzZBTw8aU2Rn4l8c4RXUzvN7dVDOvQb1aLXwUAGF2JEhiq9H9EuWNTmb5KDjgkdIyxXFrHaeAH7BeZAms1ZyNNGML2bZJ79ng3fhRbaDDKdo6Ve99JAwoNMiLSGtxUadZ+rus+AZ2rlT5pUwG/qml0+j8IUwv7wiNFUJzXUYRmov4W4Pf2jhDYr4k7alUwU9nyLg7c8nUqjPhec+F/oD1/JcMHFvrs+inikLCRpILcQD6VN5Se9V4ki/kdPS/xp+uJAf+ALKkReIu50Ay8Fz6VDKag0outzQhfAzGNq9Jv17ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzYLs6mjS8a+gd0IA1W7F7QsdD57a6L8qhBKKORn2/Y=;
 b=gneh9jz684wwVifK8sbuWGmeQotyi1T0NhO0rYPg5FvZh0laMRRaNRG9pLesJKpy1SMqLtHGoE050iANDt1YMFeychwBmOR6HeWfdoHCOFWdukkLlifzDK/sjw1+6dEuNiPaqHQdTQUPm56EIXXvdE6pm0slZYZUqlEiP5JQTj6jeLj06c1NYeP1prYHFiVz0NqiHD67GCCPrZm5rFJnkiQzvRBDSRy55s1qPevi9C6Orbb8CkoWR9S1UZk8S6J99RjnqgVigmisoUIbSfiIcPhFSq/QKjIlXZ3u3mfQAGYymLpMX2PTMOBQpQetqdcQ/ZMXjiczrVaVzKMq8bq2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzYLs6mjS8a+gd0IA1W7F7QsdD57a6L8qhBKKORn2/Y=;
 b=VQ8Slm/0Abf03kgJufQ1PUF30xVrjHhDWHLy7BYGMkgImWRpFQ3i4EzhoAIhFU4TuZl/ovU1AglLD0iZFHPP7Esca+AVLAyMOwQ1rd+GW5Q2t71zqeqW/Fzd9yeu/of73uHQxap+Pb5Jyaa2lXsab6+jQ+E52xZyfz/rDtAgbV0=
Received: from DS7PR05CA0061.namprd05.prod.outlook.com (2603:10b6:8:57::15) by
 DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Thu, 30 Mar 2023 19:42:47 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::31) by DS7PR05CA0061.outlook.office365.com
 (2603:10b6:8:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.13 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/23] drm/amdgpu: Fix the KCQ hang when binding back
Date: Thu, 30 Mar 2023 15:42:13 -0400
Message-ID: <20230330194234.1135527-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 00052c44-7e7a-4307-4936-08db3156f0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdL56mrgHGcuxyiWoTL2Qtn63yIXYbDEQeAdbgJyMOsaY/cjEC8LycGKY2mgLMi0kTSrAxtUxRo5zB1rQ/3L35pciqzJVmCmHtSuk5ent5MnaMr1wvPKYpDLppSpmv1psaEhY6JZ2bGVnQ91TcA2WQAw7tKYNu6iWPQ3VS9c6EZQWqq1XMpoh2SFReMhljqDlIODOjOOljoxwhUsr3LxmaHaaKCzjdrjTISAcDqDLQzTZHAEaBYm8D5RIc2VKy+xmoEaLX+7jRQx4ZTWvbYG+XAxE7IsvxjyzAd5YSzpQHeno2XDD8uCutO+UG419ldymnaAhXX1LUPWBCkcKeeBwXEV+uUtrbob8jQz3BYwMVFM4QNxhz8DqsnvW3KV9v2IsKxGn1LsB0QDAfwrNWdeONGFSpJJ8JlvE62oZheuqgSZsQKnM08mg03pa6sr5sk9Fw5Xy6X4M2baY/z632LxQvmbrTnH6GiHSqS6uGm2WVOcat1L9DPWG+Wn7xYB1yIfRF4ZAPXAThrQdyImfQTdEPpweWpPN+1SWl4zpf7+yYQSIihtLgn5cJ3HwZ8DWPH01ioXAAgYFCB6EaQIKPUkP8MYv6RUixmMe6QpLUKkrDyavayTwUGRScUuGQyzIJ7HvY1elsVN7XAuYD0jTv6Dogg7fEhqK4ua7PqdxeJ5NucijdUujOlVbUoPCuGJvUCpcTtOHEaBPjgy6LtVMPkLm5274VTeocNBFVJDTfrD6p8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(16526019)(186003)(82310400005)(8936002)(478600001)(7696005)(4326008)(316002)(70206006)(36756003)(5660300002)(6916009)(41300700001)(40460700003)(8676002)(6666004)(26005)(54906003)(40480700001)(1076003)(70586007)(36860700001)(82740400003)(356005)(81166007)(83380400001)(426003)(47076005)(2616005)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:47.7440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00052c44-7e7a-4307-4936-08db3156f0b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

Just like the KIQ, KCQ need to clear the doorbell related regs as well
to avoid hangs when to load driver again after unloading.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 28 ++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 3bda7470b7ff..d652464e5ade 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1675,7 +1675,7 @@ static int gfx_v9_4_3_xcc_kiq_init_register(struct amdgpu_ring *ring,
 	return 0;
 }
 
-static int gfx_v9_4_3_xcc_kiq_fini_register(struct amdgpu_ring *ring,
+static int gfx_v9_4_3_xcc_q_fini_register(struct amdgpu_ring *ring,
 					    int xcc_id)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -1693,7 +1693,7 @@ static int gfx_v9_4_3_xcc_kiq_fini_register(struct amdgpu_ring *ring,
 		}
 
 		if (j == AMDGPU_MAX_USEC_TIMEOUT) {
-			DRM_DEBUG("KIQ dequeue request failed.\n");
+			DRM_DEBUG("%s dequeue request failed.\n", ring->name);
 
 			/* Manual disable if dequeue request times out */
 			WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE, 0);
@@ -1801,6 +1801,27 @@ static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 	return 0;
 }
 
+static int gfx_v9_4_3_xcc_kcq_fini_register(struct amdgpu_device *adev, int xcc_id)
+{
+	struct amdgpu_ring *ring;
+	int j;
+
+	for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+		ring = &adev->gfx.compute_ring[j +  xcc_id * adev->gfx.num_compute_rings];
+		if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+			mutex_lock(&adev->srbm_mutex);
+			soc15_grbm_select(adev, ring->me,
+					ring->pipe,
+					ring->queue, 0, GET_INST(GC, xcc_id));
+			gfx_v9_4_3_xcc_q_fini_register(ring, xcc_id);
+			soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+			mutex_unlock(&adev->srbm_mutex);
+		}
+	}
+
+	return 0;
+}
+
 static int gfx_v9_4_3_xcc_kiq_resume(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_ring *ring;
@@ -1929,12 +1950,13 @@ static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
 				  adev->gfx.kiq[xcc_id].ring.pipe,
 				  adev->gfx.kiq[xcc_id].ring.queue, 0,
 				  GET_INST(GC, xcc_id));
-		gfx_v9_4_3_xcc_kiq_fini_register(&adev->gfx.kiq[xcc_id].ring,
+		gfx_v9_4_3_xcc_q_fini_register(&adev->gfx.kiq[xcc_id].ring,
 						 xcc_id);
 		soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 		mutex_unlock(&adev->srbm_mutex);
 	}
 
+	gfx_v9_4_3_xcc_kcq_fini_register(adev, xcc_id);
 	gfx_v9_4_3_xcc_cp_enable(adev, false, xcc_id);
 
 	/* Skip suspend with A+A reset */
-- 
2.39.2

