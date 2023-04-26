Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DE5C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8A010EA41;
	Wed, 26 Apr 2023 21:22:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D010110EA29
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfRWoo0SLdl+26NZoGfOIBOU290VsiYI8UX2IZeSCxFGFPsQG/XoZ0apT9GNDNP8p8bSQIe5pffm0r5d0uJbVdhV6KdHigREV5YrcMKeMYLujIZ/oPZ8Y3lSDGhfBs6CMNHhBr3wDXLENZY+VSmAiuzrFohSyyTm5ui6geWc2HsM2WQ/ciQCzhAwpI543TqYZuIu1+PmffoKeSRDClaNvc123ztlO+GYuMBhLmsV/rL93Gs5KHAcQ7S7GD6XEVBenOrpTn9ON77Y+1ZAXDkhi0jYvyqvgl9FoQi2PuDRfm4FuR+wC7GU7L71Np4Yniwl/4wBbuJKNVtqI2oHUjrQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmbklG45ZFRi9PtiN5AVDXqQEkRxQgkSP2QhNmZvbRg=;
 b=I3CaLmiIu9T8SsqBCujKnM1OCHppV+s/3bYO9uMfg19t3qzm2eNSeshbmXqiyYWZQ6jePodB6uJ0/y6lnwkn9craxGDf6FhrsVcD9dzVHVPjG5UzpTgx5i06mSBuNTMCOL3490DREIrue0gCqHt/ifv7w2QI+2t4R3WSggRLZjHXDf07ZatdRLG/YXkNb9WMivzoQk8iA5Mbmnewx8iAdjSmmUBu9rhYLO+LHWSpA3qZtNYK/ATjmvm4216VgAvXIaB7hbgVagEcEDaHYsu1uQajzT1YoXEi9W7VAEBsJPfn4ZyL6LM+94N3LY3qfpfofP+3I77RSfUcQmzNVNqKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmbklG45ZFRi9PtiN5AVDXqQEkRxQgkSP2QhNmZvbRg=;
 b=th85jVSlMj0aeXbcWue19vZXx8AkvM0b7CIUiTQwUEkUTTWEIkHpbzjeuZ/xL/G9zJ3pmx+9MUiLRNdWCPelThCTkqiUoY0A2lqGPV17tQGVlhsteaf1yPCzWq/vM5qHCMC+orwXRz6jdBNdOCQmXWum8WKnUOjH3a5HVe3+hOc=
Received: from DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31) by
 DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Wed, 26 Apr 2023 21:22:05 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::5c) by DS7P222CA0025.outlook.office365.com
 (2603:10b6:8:2e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amdgpu/gfx10: always restore kcq/kgq MQDs
Date: Wed, 26 Apr 2023 17:21:41 -0400
Message-ID: <20230426212143.7696-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bff9de-820e-4a09-8dfa-08db469c48b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GX8gDGyRJqiEMVQ5pHtRwDjhgMEW9O1CpSYDcxcKfXt/sIhIpvm07q92DMreY+pvhzQw/Ilyu2muW0nxZAV9g/LdnqlPrCwG7PdcwfU/zKDxaFjJehddxULgafIXH2iZA+FzBeIgUjZlM7GSv3faQ0xQNjg3ZC2hTp1ISgmjaPVddseDBgMz97CZ9u4eevOc+KBc4IyCoSLrGv8R9mS1Fv6qo2CN3mo+CtdQAwh4UEUwMQsw1ENSyYnTybKdDx+CDtAR4gdBmq+VY7sbamXnEc9BFZ7iMSfD29kfWqSe5sPLkDnDpN5e/Ha6CjKFmPF6dfJuWQu8lY/oabAkhxzOrOcRUukTYoBNWTtoEdRcfEvc1MuiJppZrwjTMpIN/IdAmiLbAuWxIhosQR//pi6t+UPBs7VTcdW/xJKWkXQnLuz28BgbQ1E9n1+6lvZT61gYG5lsnzm+34T9X4z1sQm3DoiOl8fJsCTcvi5argDO0+UvBqHjoh08vLmOiIJ5/3/H62JP9rlQQjXBCMvlCqGeEOruHSzUfUJ81G8NVtOUS8Q5pvFPFW3ZSOcEMJsyMTWaHbmBxfRYkb6mhANkXSWGhBDlPBbec6Gohw+6+4amlwZH9DUDeQj5Admu4yt2Mkp53+9tVywX13da8wqIaGjhRh/gCEl/9SIOVspYyhO0jKlBLuErd2OzgcJilWOaoFE91efzSeiZcOZEvuTDrvS1eyGb2mBqNI4b8JLN3MWXd4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(7696005)(6666004)(16526019)(186003)(1076003)(26005)(83380400001)(336012)(426003)(2616005)(47076005)(82310400005)(40460700003)(36860700001)(36756003)(8936002)(4326008)(82740400003)(6916009)(316002)(8676002)(86362001)(70206006)(478600001)(2906002)(40480700001)(81166007)(70586007)(5660300002)(356005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:05.0976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bff9de-820e-4a09-8dfa-08db469c48b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
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

Always restore the MQD not just when we do a reset.
This allows us to move the MQD to VRAM if we want.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 29 +++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5c67c91c4297..c6afaa375b11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6447,15 +6447,16 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (amdgpu_in_reset(adev)) {
-		/* reset mqd with the backup copy */
+	} else {
+		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
-		/* reset the ring */
-		ring->wptr = 0;
-		*ring->wptr_cpu_addr = 0;
-		amdgpu_ring_clear_ring(ring);
-	} else {
+
+		if (amdgpu_in_reset(adev)) {
+			/* reset the ring */
+			ring->wptr = 0;
+			*ring->wptr_cpu_addr = 0;
+		}
 		amdgpu_ring_clear_ring(ring);
 	}
 
@@ -6780,16 +6781,16 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 
-		/* reset ring buffer */
-		ring->wptr = 0;
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
-		amdgpu_ring_clear_ring(ring);
-	} else {
+		if (amdgpu_in_reset(adev)) {
+			/* reset ring buffer */
+			ring->wptr = 0;
+			atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		}
 		amdgpu_ring_clear_ring(ring);
 	}
 
-- 
2.40.0

