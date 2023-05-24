Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4558EC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 09:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF69410E5B7;
	Wed, 24 May 2023 09:00:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CB010E5B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 09:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQEbD2TpW0E5cFgo/u6sz4Gu4YzGbb7P3pm4EKo2v2KktXvVPOVPWRLwqi6wVKgSzuYDaH83S6TTdNJmKPmUCWZ55A0lZXqF5itFr8L1c+V0KP3Uc00KqNFuwtJyu22U/q8NmHiAVKwbtMMUWaTMfHuYBkeGuoNdCPlaUN186ucbZkNVLKxdvzORnAmWM37AASQfsqhRDVHZBtabRbKwv7l73l7DH2OoXVC1UxOLSPkMfUTS2OYK2aIMEc6kFSEfksMO1VdX9r4YLaV/s9430EWT7onX/ECzkeIvpAf3mVvIZLNWqlzkedxOvUlcUIVHrZoXARbPRDC+yuOxQsOoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joHmF6qFNaUKR5O8N1HOEO6zee2UX0yGBuo3/VCB+dI=;
 b=oD0XpAl9vFgLRdmIUDNcrZn+U5PI6OLzC7hs/WDZ9AsbDl8XVVJItfVn8unIhcx1qFUL8tcivzofG6gjfwe4pZ+EbgtRLV9yJW6DhZzw0WZ0TgpPSPs1vw/zl5d9grZdb1rKagkaTteJE3L9rnu15Kj59fNKef2nTuHYYPGszxzT0qO8SG99gOh9KMfHpQq7HAJku4iHoGNpzBKjCS5SpgvBGpm6uh6vVQQQqk8D8amlMizfi128mlEwS2vdrrp/GgC5Xk5WU+GoXmwhUed/Sl2KF7hvIwXIByOIsic86SCC/n0cKRPUrXHuVB5UHSkseLMgZ5ENRjWk4Akbd5FQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joHmF6qFNaUKR5O8N1HOEO6zee2UX0yGBuo3/VCB+dI=;
 b=LvKCEBd9toFGYF5K2xmRBXqtnDX4AZKFR8qWQhb4EdaB+YA2vInBv72RPaDPQaHRB6VrdRhooGPqGX7WfAAAcKQhVEk3PaBcTUrG8Oq6TuNP//lgWLsxa18sTM+saP/KPeKM24NJeOzNfInmjleQafw66RSdfN/KwKMfo1X8yr4=
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 09:00:18 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::5a) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Wed, 24 May 2023 09:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 09:00:18 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 24 May 2023 04:00:17 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Program gds backup address as zero if no gds
 allocated
Date: Wed, 24 May 2023 17:00:01 +0800
Message-ID: <20230524090001.3276718-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc4bf8a-1cee-43c6-5b01-08db5c354c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zIYd/NwHiWu5801HRuYetRqVR525mZ1M/qzv+ZZd/OOG5plXzi0tx/wluf1cZm3Xc43kpC1WahdjumvejGPHuLOz/iydJPS+pgHbhk31qEv1mnZjO0AtQgtTNj/dj6LRGea5M+nisXhG/CX/7Cwqa+RoGCgzRureQJknHG9Jz/qLG3dM6pSuE5r6twhJ+Jm1GJLqz5FAFzrjfnjmLchIHoMKGujPuLqFbZ3DGq6JyCTMckv8y+BpwW1riFlpWUksbzB3ztmBZ9+G6EQg4OrRNH9XS4Jsk810HmG1Hph62F8bIsq1aQv2MfQkz+F8uiI6Md0Du/bPi2d79qvOIHPnD/FkuWqEX1FaSVg4VlNuh8gEJKAJzZi+81UIgXAlVY+XCkMaxrArCCNk+LBpoq0A/CVWuyYTgUaxNpA4Ot6Q2pUx2lrw4iI5eqXFWU5AGbBoXjVyXlXrRWtzyuLcJ2kd/P6dQ1RMtqAFx777tnGMaj6s0WIOKgMGPyF8b443OhvGkfg3LcD3/0uRWJ08V0VszQUMXii3Guygpyhh/fjrWz+c9QtPPAWgtJM6x9uaftgFQ3pxTGaUN7hwT5ivFXJhZ/x6KP0JSsPZoEvk1ottWSwtNWHECkY3n64FZanDTvhdL7pO3CXgpMIpPcCGBjZKpRGUIIvy+FhvMf4L6e+rD1N0T3MzofeGW3SgnNZTNirzX5M5CIZrfZKVnmWJTJdor/Bv7fX7iKajXWQIsgevh2I7oxdzR5xki8UT5MMhM7iJD3CuOuU5r9DuVpV51pVdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(40460700003)(26005)(356005)(16526019)(1076003)(81166007)(186003)(2616005)(36860700001)(47076005)(36756003)(83380400001)(426003)(2906002)(336012)(2876002)(40480700001)(7696005)(316002)(41300700001)(6666004)(82310400005)(478600001)(70206006)(70586007)(6916009)(4326008)(86362001)(8936002)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 09:00:18.4624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc4bf8a-1cee-43c6-5b01-08db5c354c43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

It is firmware requirement to set gds_backup_addrlo and gds_backup_addrhi
of DE meta both zero if no gds partition is allocated for the frame.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index cbdd9918b3e7..cbcf6126cce5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -765,7 +765,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
-static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
+static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume, bool usegds);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
 static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status);
@@ -5160,7 +5160,8 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 			gfx_v9_0_ring_emit_de_meta(ring,
 						   (!amdgpu_sriov_vf(ring->adev) &&
 						   flags & AMDGPU_IB_PREEMPTED) ?
-						   true : false);
+						   true : false,
+						   job->gds_size > 0 && job->gds_base != 0);
 	}
 
 	amdgpu_ring_write(ring, header);
@@ -5435,7 +5436,7 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
-static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
+static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume, bool usegds)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_de_ib_state de_payload = {0};
@@ -5466,8 +5467,10 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 				 PAGE_SIZE);
 	}
 
-	de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
-	de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
+	if (usegds) {
+		de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
+		de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
+	}
 
 	cnt = (sizeof(de_payload) >> 2) + 4 - 2;
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
-- 
2.25.1

