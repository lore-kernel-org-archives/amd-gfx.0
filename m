Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D352C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 15:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D397710F190;
	Thu, 19 May 2022 15:58:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5233A10F190
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 15:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkdbbVdx85Hrd6UB0AkhCerIRYXt8f+Gj23pkYFp00v6XI7NcvDrhjdIZ55PBreuZoP9l6j0+wHrnLDWIYiIrxtVpqMnU04pjhACzplGHnKvRiYFDTuFoFzFMJ9BOaNxTTjgDsMprg8VRf+Z2/+80cRSIdqH6RL9j0IJ5rXN+9s+RCuzcyXtocCDiILSIhcqkX4aYsG/BMbqYJNehjPevYtGLyuf8VgEbnYUmANm8c2G4GyXL/MB6YFR6sMyuNsOoGbEZgLsAL7jnTMkYzoqBVAjERpt6BvevmNk2yWTikzhgj7kwYhAEOLU3IGTQgFiq6GGWMbEUQ28Yje1GAmJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A7vKt1EdaPbU4n5K0QJKKwDLfdbibfjQYZQ8JWxcsU=;
 b=fpkiPso2Iw2JDHeMlol97MW3O9XMMC//i3pojSu46yTmd6ic/Ay2pJ3Xjlz/lq0EshpJNC22LDVg0vhwIK6q9lJdyt48X+txQvjmhyJMXloj3htwC2x+4vlKLJLSOPyY9V//XAoqJchxc8hwg3zJLZHEsyVLl592Q1dI8DT1xU3XGYBFKvctfH4CIsaTGYKXXvBypih+18FtOsOVq3c22RBYRLvESfBN6Z+j6x11ULh7l+cgTbJ23BkClbMHrGADQyR/3YebQMHFiof62D/7qWNY/L/67O2v4RJksRKLS7oAw1PpV1wfxIFsPfuCOLynDQHDxd2QkcEqhxqZuahChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A7vKt1EdaPbU4n5K0QJKKwDLfdbibfjQYZQ8JWxcsU=;
 b=tgGvZVAOnrPXrd/+aFnpBEeglNyRcgLnDZLArepfnYYMcFGvNp3VdRnYV2DhPN3IXCdtmUl1QWls5+2Pi1v61+5qafK6cyfIAK8dkVUbAYni4ALWO97ckymq37j88oiIakL3lXJnVHIf5N3mvisTNoxBuQrs5ZeH6GEs+pUpyQU=
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 15:58:20 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::10) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 19 May 2022 15:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 15:58:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 10:58:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Adjust logic around GTT size (v2)
Date: Thu, 19 May 2022 11:57:59 -0400
Message-ID: <20220519155759.93428-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8fc1ce1-a509-4c7e-93b1-08da39b0651f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5361B0E8A97B97372F6E0375F7D09@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywSUSinKyCH9izzJWKKT/bfeFxGmvskeZ3jBKV+eu3eOYf24P6yVAZpLoorZARKlNViohAPeDVsyhaRHuHZ9CpjB041YWnSazRtN9QBnB1uVgZLF250k6V+/MVPDP+lRcXU+CwG1GpvNA74f9+GETUt+ulwx0uJoR2QrfQEg48deR55zf48PpSVPcE4xq6qD3Y8HFEybMRnZJS9nL4e0vftDJNHGL5UrPqAPWTa8D5FxjyOAfsSmXPxbb2b4LDNiWSt4geEEaZ2ATVRq3tDTgJx71hTEDWUYaMYbQogn9uvMguP0qgAB0Lv013cvsN1IuuNeaEoALdZrPHkU3JragbzufUctMEHXY5eSw1avBzOAgOrRCErufivlejxhvLHOQProvVwyhCzn61iD058jMtEsiSubgPBbOJdirpBdczQ7rIASycJ4akGhBFUNyAQDELj1t5nqPEYDoybSTfSK3kJk3ogH/Z/GZMWQwDNy6b2IbsPV6ZTE0BOuH+my+7kchnQh78I/DtWEaOZmXxKFmk5WBlXbIOST1n4l8W0+D2/f1kYHUeRTFdvlz3ny7EzUnjnFBiAr4o8sb6s3Xi4kEVZb/p3xT/Oe1MiMjISV7kRn/t5akRM1P0XxATg4irOrfM81+WPkOeA+9EZrAIadEkxpnotVAJgCOxCDX84kHYsP0Zw+ZLIevPvEeC+RJ8YGEOPiY166Jj1idHXjM2ZMKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(426003)(336012)(47076005)(82310400005)(508600001)(36860700001)(16526019)(5660300002)(36756003)(2906002)(40460700003)(83380400001)(186003)(86362001)(70586007)(6916009)(2616005)(316002)(8936002)(1076003)(70206006)(8676002)(81166007)(26005)(7696005)(6666004)(4326008)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:58:19.8067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fc1ce1-a509-4c7e-93b1-08da39b0651f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
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

Certain GL unit tests for large textures can cause problems
with the OOM killer since there is no way to link this memory
to a process.  This was originally mitigated (but not necessarily
eliminated) by limiting the GTT size.  The problem is this limit
is often too low for many modern games so just make the limit 3/4
of system memory. The OOM accounting needs to be addressed, but
we shouldn't prevent common 3D applications from being usable
just to potentially mitigate that corner case.

Set default GTT size to 3/4 of system ram by default.

v2: drop previous logic and default to 3/4 of ram

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4b9ee6e27f74..4966412024a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1804,12 +1804,19 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		struct sysinfo si;
 
 		si_meminfo(&si);
-		gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
-			       adev->gmc.mc_vram_size),
-			       ((uint64_t)si.totalram * si.mem_unit * 3/4));
-	}
-	else
+		/* Certain GL unit tests for large textures can cause problems
+		 * with the OOM killer since there is no way to link this memory
+		 * to a process.  This was originally mitigated (but not necessarily
+		 * eliminated) by limiting the GTT size.  The problem is this limit
+		 * is often too low for many modern games so just make the limit 3/4
+		 * of system memory. The OOM accounting needs to be addressed, but
+		 * we shouldn't prevent common 3D applications from being usable
+		 * just to potentially mitigate that corner case.
+		 */
+		gtt_size = (u64)si.totalram * si.mem_unit * 3 / 4;
+	} else {
 		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
+	}
 
 	/* Initialize GTT memory pool */
 	r = amdgpu_gtt_mgr_init(adev, gtt_size);
-- 
2.35.3

