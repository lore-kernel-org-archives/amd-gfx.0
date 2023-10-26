Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD9EC25B6B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 18:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D0710E860;
	Thu, 26 Oct 2023 18:56:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609B810E860
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 18:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlNqFQAikKIm8v/FBaFc+Feyl7IwIRKr+vLnhRE4Y/Dd73FfhpwJW3uTJAsFVPa5QH+ikwMop73J3GZibqVqzvL7lD3T7h1k9zylcZHdHUKH1mc5AcN1sQiiJ5Ir4/i1qJCVkgMy+/o5sv/kRrSeMGeMoyA3+lk8Ri4CbLHplshCfu5lWkbjF2oS2j3TVxtYLM7fcUI/+wtrvPzyZuvKqKdxw/jo4dQPLOCd5KWvnwVfizE3wIefP5Xq2E9awD+ZRo31yoA1LD5UKDPjDxllizs3V9ZVdPnYBzy9gFoL9NeO1vpLC95x+GG5sloBqj9tZ0Wr0a8liNtHKSEXitzUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmsKniDuULVziEvNOwU4VFwyqRMUQwCpP5b5kX2ENAU=;
 b=PBboIC4yIBlsAXmvqarvYKaUChrfmr5T8FjKKLnQmcp2+XhXcsDSkAaWsbY977TQtT9i9k+bpFtsQ6BWqKqMhxcoak5O/efguaQlrpv0A3n/jE2wel5fwY+Kpw7jPl+cqwUkeHNnS2W70vIcdEz0H4a9Pr3GFntkAUus7SOQdf0ZxH2JxM3UbXPnLeeO4sX6A01P4kM8AZkEkA84vvJ6pZg00ZFa59mA/udo14ZQCIMTIZFywz8EipEKTetYXXaZTSO1DJYKU+GaP46DDThNbF37BE92iYqWP9JKkPPIioWAOgKOi7ILSmO7JoPTdxWKGCZRSBe9tVYB1O58AOc6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmsKniDuULVziEvNOwU4VFwyqRMUQwCpP5b5kX2ENAU=;
 b=u44VvxSJJfa9SvzlbkVMezl4LwDkI3NoRJYW1gWKAy7kZk2oMl751pNCnv6VdneXoGW1chBRnilQIUNILRPRphxMZE8edI35gBY/FWHSCOA1zJLLL+zJbTMxFY1sRlSiB1Z1xvb6bwySzvsbMDqZsPA5YuAdjlKb1SgfyKqBoyw=
Received: from CH2PR14CA0035.namprd14.prod.outlook.com (2603:10b6:610:56::15)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 18:56:24 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::ec) by CH2PR14CA0035.outlook.office365.com
 (2603:10b6:610:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Thu, 26 Oct 2023 18:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 18:56:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 13:56:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10,11: use memcpy_to/fromio for MQDs
Date: Thu, 26 Oct 2023 14:56:08 -0400
Message-ID: <20231026185609.28627-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a624a14-8537-47a5-1854-08dbd6553f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGesfbkGOMz0w9YUzworQrV77wQaUMPssE6XevdQdUO77ezTHEcLnchnTGNI2k67VOyx3K9gwOT11I5z+JPxWFXn51n/SP1g82elIO7OmabyJyZbmdosZV1Oi6tE3Bs3AK0AbnPnM2sFxXpmGy6q4nyGSnINfd9g5AACsOFSCVZ7HokeSP2VB2GPTv1IGIQceCPh/bSAvUMZUSuM/7pYc2Z2+Ax8Fu281XsEtsfWgft+67Hbtnseh4GvSXdjfB6UoeApSC59+dvWVuZ4Enhyi6pO5sm8jI+4g08DTUALPhdsAqb2e4FfZXw3xvj0hQkGfwPa175sMFxHF8cevkHHIvs1lr8ZlrXVaSiARvJuJ/uvlU2fX1vCZfpVIlqaJ23vjG5jy0xtIzpDJE6eF6fbOmovKYLKSQbHMeTd5pY0bYpyObYklZVAagPzS+5ruXjtR0YW+72mss5ZRsez5cgkojBBgQF6Swof0wCaGdFCIkHzOC/LQpGhWOso9JNGvxTet4d986Z4ImiNvO5gC+d/NNAVwM8obaY4x5xHETUee7wFat27zSrGsOO01WEadalJPY4meKd4LhCVxhbzJ9LQzrKfpRk7JQcqMiDoLw/HIr54GXxWT2oPehq/aMHozmG6XNj/Ts1kMDFYdlVeOIZWNSIN352jRK/Gdlt4j+zhvqvs4ZkkFl2xCV6VUXiBytDcIS0I6WCmbu0dOR4q5gv+dudL/hHlbM1MpdQXlBoe28xK2K0xbD8Rj2eI70yTFDXOdUElQ9E7pYjqJzIa6REmAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(81166007)(2906002)(40480700001)(86362001)(47076005)(336012)(83380400001)(1076003)(4326008)(356005)(16526019)(82740400003)(36860700001)(41300700001)(5660300002)(26005)(2616005)(7696005)(478600001)(6666004)(8936002)(36756003)(70586007)(426003)(6916009)(316002)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:56:22.3218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a624a14-8537-47a5-1854-08dbd6553f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
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

Since they were moved to VRAM, we need to use the IO
variants of memcpy.

Fixes: 1cfb4d612127 ("drm/amdgpu: put MQDs in VRAM")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9032d7a24d7c..306252cd67fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6457,11 +6457,11 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		nv_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
 		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
 		*ring->wptr_cpu_addr = 0;
@@ -6735,7 +6735,7 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.kiq[0].mqd_backup)
-			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
 
 		/* reset ring buffer */
 		ring->wptr = 0;
@@ -6758,7 +6758,7 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.kiq[0].mqd_backup)
-			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
 	}
 
 	return 0;
@@ -6779,11 +6779,11 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
 		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset ring buffer */
 		ring->wptr = 0;
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 762d7a19f1be..43d066bc5245 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3684,11 +3684,11 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
 		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
 		*ring->wptr_cpu_addr = 0;
@@ -3977,7 +3977,7 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.kiq[0].mqd_backup)
-			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
 
 		/* reset ring buffer */
 		ring->wptr = 0;
@@ -4000,7 +4000,7 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.kiq[0].mqd_backup)
-			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
 	}
 
 	return 0;
@@ -4021,11 +4021,11 @@ static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
 		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset ring buffer */
 		ring->wptr = 0;
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
-- 
2.41.0

