Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B466C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 10:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1F4A112EF1;
	Tue, 30 Jan 2024 10:19:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FE0112EF1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 10:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hocL5MtGmXXowh61k3ZALF12kSNedPU01cXZrSJHE4giA3Qn5O+nU8Ymj0OSO1H4+DUNxxodIsen6PzriJvTUTt9u7no2tC8HPk6TSSGs8Y28qINBZMPYh1i1LQ5A7+iWCy1NPJ/HJYSlSbl+a1JjF9uo5DE5Y2eLGCxYBQjG9yOfUUPsYm0FYHwo4cNv22MlBIo/pXaueXPuW43z9dzOBn4grwKAdwL25/3YEXdbp1gvuRZEBZQ9NMSTO6KGWdjy6hqfFrKEl09KndD3mDUOR7QswrQYNumWFSU2uBnhP5BQjHK9ubFdOL63B6EVNZb7TfQKHQw/AawGRNkN76w0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBXvcB5ZV6fFFrEpwBr+S+STPF2+iTx5kjyZdMqlM3g=;
 b=FQLYjUvn2OF9c8tCKiSDE/ufD2wBjZ0yUuwuEcYvQvpZ3ek+WNFsO7FvgzQ9JuOV/URI9M3i9Q8+4D4v3XRmRpLxfJKfXhZjA3+ZITK3rJPyijOZhoVlSwkfvP/EEKuk9QQK+1g6nes9tWIXeKeCsupr8HQ1XjL56iySOm4fy050vuN0TJyZVeOyb9GK+iYN1i4wAYpn+5Uu2dh24hiEiMqUDjmc62S6S0kinRhvl2/gRjaYi9P5wY0PIbPDTBeAnHritJLQkemIO3zcpy9zeGPu6OgrCz0P3TMA4nRqf8d/h1r+6NhUFaPPbqvvE6uWaeTTrdwS6eok3HMomr7/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBXvcB5ZV6fFFrEpwBr+S+STPF2+iTx5kjyZdMqlM3g=;
 b=NHY1icwI0SrrD6PMXUYyb3q0FU62+AzpYZZfWyftAyWNTJGgSW72OvH+ApePz4wytbqCF9A5S4X4BLzlJuW61892Xexy2GwNo46E78O0BhpX9MH67xnipuj8JoQZ+nayt6V0VpY5kgLK3oRtDuWXTmi978W5EUU2KjVmj/Mkfyc=
Received: from BYAPR08CA0020.namprd08.prod.outlook.com (2603:10b6:a03:100::33)
 by DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.36; Tue, 30 Jan
 2024 10:19:36 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::c9) by BYAPR08CA0020.outlook.office365.com
 (2603:10b6:a03:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 10:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 10:19:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 30 Jan 2024 04:19:29 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix missing error code in
 'gmc_v6/7/8/9_0_hw_init()'
Date: Tue, 30 Jan 2024 15:49:08 +0530
Message-ID: <20240130101908.429223-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130082727.399314-1-srinivasan.shanmugam@amd.com>
References: <20240130082727.399314-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM4PR12MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2792efd2-3f94-418b-a0e3-08dc217cf56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8DLTB9Rl7fRSbLVOT4DYlLip0WgYQ5NBjMIZ7gdvsBJqldzJ4RTrVehy4n4eKf8Le0I2aK5iRM8ypbVx3lJ9gc470wl4ApnEY1MMw8UuVxrjaN4VY+z5Rt5mPhfBcUuzvTv9IeVCzz9TlBe/gzxCr3JDrHOEg/qYZE0o9ZotgmDuTHWFJKP8H/lAE4SySCspc3dk4Aszc5kKGKHKQ3yz8mXagw28k6dSsi/RC7jLs2Fv/hY2b6BxaSbrF3nTLin7ynXFXwESwLg+Bs38NGgPy6cFBPkD/U2CwOcO8ACxtfA73x7yFFX8me7j39nIW71zLyfdAYOL1aeZMLHyKnZE7AzVau8CjhgiN4cx+Hj/0Q81dNyCD7JQ40O4YyEnKlJ3Cel5NSVDoslVhKDMyksFDgWCZrhn5iwq6ER712RbS5+4MmaT89RIaUQ8JGyFb7EqFyGNgN5J5yifGrw97XDX6RjyytqfJVzD9gfgoXbjBiHEelO2KO/YlD/6NjRxmtHfGpZSQ36W64WnzP7E7sHVDIUxI5KqUUo+wQms6ecvwOxmGKW717XUZj6LMzlUR4mDfnOYPHoPfxpXI/5wNzFscGVQIohoN5c9zsaLJCBeeegS6DOnv/AKklWXE17FEh8VoDvMUxq7vYxvRwrm7oxZ5aj35iUpsJHTFRGBsyRFzrtDfK7dhEJWK7rdHarE8z7dzwPT/u+zS3rJHAIHNc7VKziCkLp+GXgRKChtj9EoPVr3BizWv3ZnaO3n0uHonPFo5RfS9UZS7ry4htl51GJEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(8676002)(4326008)(8936002)(2906002)(44832011)(5660300002)(86362001)(316002)(110136005)(70586007)(70206006)(54906003)(6636002)(36756003)(36860700001)(47076005)(82740400003)(81166007)(356005)(7696005)(478600001)(6666004)(83380400001)(2616005)(16526019)(1076003)(426003)(336012)(41300700001)(26005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 10:19:35.6275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2792efd2-3f94-418b-a0e3-08dc217cf56b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5102
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return 0 for success scenairos in 'gmc_v6/7/8/9_0_hw_init()'

Fixes the below:
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:920 gmc_v6_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1104 gmc_v7_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1224 gmc_v8_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2347 gmc_v9_0_hw_init() warn: missing error code? 'r'

Fixes: 8301de8fcadc ("drm/amdgpu: Fix with right return code '-EIO' in 'amdgpu_gmc_vram_checking()'")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v3: 
  - Changed from 'return r;' to 'return 0' (Christian)

 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 229263e407e0..23b478639921 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -916,8 +916,8 @@ static int gmc_v6_0_hw_init(void *handle)
 
 	if (amdgpu_emu_mode == 1)
 		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+
+	return 0;
 }
 
 static int gmc_v6_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index d95f719eec55..3da7b6a2b00d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1100,8 +1100,8 @@ static int gmc_v7_0_hw_init(void *handle)
 
 	if (amdgpu_emu_mode == 1)
 		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+
+	return 0;
 }
 
 static int gmc_v7_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 4eb0cccdb413..969a9e867170 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1220,8 +1220,8 @@ static int gmc_v8_0_hw_init(void *handle)
 
 	if (amdgpu_emu_mode == 1)
 		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+
+	return 0;
 }
 
 static int gmc_v8_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index a3a11538207b..4a50537252ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2343,8 +2343,8 @@ static int gmc_v9_0_hw_init(void *handle)
 
 	if (amdgpu_emu_mode == 1)
 		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+
+	return 0;
 }
 
 /**
-- 
2.34.1

