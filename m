Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A0CC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D1710EFDF;
	Thu, 30 Mar 2023 19:38:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBD410EFDF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc/q+bYpwHGv8Qqk27NTXFQjwdk36nQXTGM2lsWHuZsSS7vufEfDFrIdDSVQK1hRSkWOso2WWJR0qRGaHIh9YVjndG+zxpxoj9EIIQPPRjC6PuO3+PnPHg9jxxiRUDp3FY8s34UFoBrRcoaK7FiJGGjOceR79cgMYIBJodo22pxFzKfY2n/2jrEG9FuQEUsdvPOG/2yVE8nhQ5zHCQ6BmHPIRsER+4FulrKyOCbal4qUyBTP8J6QK/2wUznMDUvcAY3SCfi0U2H8DfGXZgnPq3PG+lJofTT/er3a7HPGJFKMdhnL+bnTPNfcPeIgzYsfukQcNnC5EEnlO4muSw0tdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzYLs6mjS8a+gd0IA1W7F7QsdD57a6L8qhBKKORn2/Y=;
 b=F2TgcD/VNtbfMqw/PeSGPNb4+ZRWXgMa1A0pOw5LOQV4P/8o/qQV08yoxMtRE3SEMbZUzLlK7UPrYHf7E18B5WyS9UPBXgE7/skcsEodfb1e2aI/jYUms6ypH7SeSB0/r1N4LTY1UIfu7VHM+iVDq/IOaI1y3O8Sq6rpxmiJusR6iVq/Tkjguorl6uLhEE2x9q9bOa6of4yhPm60uusmi4FXhWaeAWR3DBXB8yHkoBZ5AZvk/Eiao3TtPrbJLgpZAdRVI8zWeCKOGJGMXCSFLhQDzd958qd+IlIs7Fjy0//1oyMmz9BjsTUSQ6T4Kjjy1W6rZkfHLzG0fFWm5AHQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzYLs6mjS8a+gd0IA1W7F7QsdD57a6L8qhBKKORn2/Y=;
 b=u3WCUycvE76RW/g1d6ViYH0dgIGegoqnVk/VNcgJHIgqnLbUYJyLmf3Ro+fIYCZqQtxz/g+EOUu8Agt08mKwb9IRhMVjXoUukzHHyKJHjWHnOo/uyaW1k5cLom8rqTJ2TsWy294YU7uwKiLf5zu52LEEiZ9ToSfJEJfOIMjnaOE=
Received: from MW4PR04CA0386.namprd04.prod.outlook.com (2603:10b6:303:81::31)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 19:38:34 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::ae) by MW4PR04CA0386.outlook.office365.com
 (2603:10b6:303:81::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Thu, 30 Mar 2023 19:38:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:38:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/23] drm/amdgpu: Fix the KCQ hang when binding back
Date: Thu, 30 Mar 2023 15:37:59 -0400
Message-ID: <20230330193820.1135411-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193820.1135411-1-alexander.deucher@amd.com>
References: <20230330193820.1135411-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 537c5879-f5b5-4aa2-17b2-08db315659a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JmR61tyVxHRn+Y1onolhgUCi60IhtCrdvLmNzpVzAJzSzvi4SZ/TXEpORQgEaSaVdpjLR2taWmsdm5BhzU0P9GXa1psuOKKF7RAxm5HUyDELdHVDZoXleqD1WYHGQpTrOYOlGgjs2BdfbvG9grz7sbTyPzCrckV+3xC/4qa/x8kKA6mi3D6davFmePfkRxgARmtMsiynLv36TYR9ip8cpdTAdBZ0H0Zbrl7X8dgJo1YlTImBQG2RJP0Cy4fFbR/TP1IrbCWIW+VDaFp0Y50CwbPCtkPdk6f3n+hoFNsnSYKdastn6eXHaVu3RB8Zo/uvwgA8wxWsqKWLjtZ3tkJx4nvVVpekK2d7Ia/KTQVLkyLCCeeK6MbckVg8r5V6gZXA/3JSNmXc4I/6zk4BLTcxEz4WN8Qv0Vv78O9spDCKOEpHuZUbb5poEST2Im/Me1rZnhlEsx/gtRcTQUTZhRZyqZEdb0pmKEm3zfnXpNryJ5UtbtXZGz/WWEM3NmwNqlvsP3OBWszlN9wXoMwZOxUQW/0DYDdF3KaF1+zj97cq88T1rXK2YY4WnVWWOX8VzPV/uvDwvO9lK4DYcuEknCWN6HRiqQ0dJSvf/UoYTnPtPwfoLTHcK1VaHeSka6QSl3LHuTm+sGMjn0NT8wkZ44fC9Xt0KGUsxTxAhuwNi320jZ3IxshjkNjBLzdVZaqs4UEM4/z9Od0ngrZGE3vTRmhupao5tzyPrBg4RfPPaknagE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(6916009)(2906002)(336012)(2616005)(83380400001)(426003)(54906003)(70586007)(4326008)(70206006)(8676002)(478600001)(16526019)(26005)(1076003)(316002)(82310400005)(6666004)(186003)(7696005)(36756003)(86362001)(36860700001)(40460700003)(40480700001)(5660300002)(356005)(81166007)(82740400003)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:38:34.2303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537c5879-f5b5-4aa2-17b2-08db315659a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
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

