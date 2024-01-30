Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13E0C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 08:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C82A10F837;
	Tue, 30 Jan 2024 08:28:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F1F10F837
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 08:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOxux34fer5VJ/JWarQiuGxcgAvsrnXzoflGpUoowOVpSu7vCZwjjUL9JNgKw7IR77JYB6TQm52uWGJLMfDANE5RIMk4u0WPutwpYnkOC2ND6h6Me/Rw3wt1PQpdPxgwSbpTr6Pq8h0VocdIqoni5Us9rpCxkbVz+bL4Jd/Yz21HUgPi78yYD8Y5CrEfPnSIDmG6WnbkDxx6mu0gLE4f4TlfRqWZLTlC6jmArlHKzFLWpH7I74mYiORmHJEtYZtMT9K6KFbkOudcUnq6RR/KSKSj1PmEsV3Klmx6aAxESbnVG2JY9c81razW0f7cNFAjaBTic3pxb4QwnZ6gIGmvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Exag3CAkRucSvKYZrBHOt25krt7PAnnKdI+r8uGZ4X8=;
 b=mGywqaSdbFQqBIG7hissD9sIexXPkd/w0BsBQhH4roqxZpSrKimnTXZOfHrNdNiTHdw5/NOCfn3fJJOWtoe+U1UfLfSah2oM62AfHKBbsMLCuLKJwlkjIX/I+4NaYJ9sfpRQewhPoM+4Uay/C/EZFO8GdsHXB6z/iZkTnEf2xSNp6i4LoIjXjgme+F5LR7E4SuN/mUA2q3tw2ToAMrUJLAtunlwhnqlQfydQyCrXZbVEoZ7HNJFbybRpAgOsFZgivDccYLYqTHiCTxuh2L56o4yK22UWd6FChFq+tl0ZIf+OFE+QUr/5bsbkfGhEW84NNg7jBJLoZ6TCzHAc3kRbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Exag3CAkRucSvKYZrBHOt25krt7PAnnKdI+r8uGZ4X8=;
 b=3FDX68QVjCE+hpFbUxKlIwicrDleR1plzHJhUCVaUpkEbUVf33K89kv1O4RhFWxE4Eo7CBU0XfrU5S1e756C5//4r4tw8YbPpQH10XxxC5EjeRb49xIWvhbueP5F+tksb/4k9fVc/FTzNCU8I5xq64TLCN8DyGdVZbMUwkucnrI=
Received: from MN2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:23a::31)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 08:27:52 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::f8) by MN2PR03CA0026.outlook.office365.com
 (2603:10b6:208:23a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 08:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 08:27:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 30 Jan 2024 02:27:44 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix missing error code in
 'gmc_v6/7/8/9_0_hw_init()'
Date: Tue, 30 Jan 2024 13:57:27 +0530
Message-ID: <20240130082727.399314-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130082101.397532-1-srinivasan.shanmugam@amd.com>
References: <20240130082101.397532-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: f88895b2-44a7-4f9a-a3c9-08dc216d59ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycdmt+BPaLyuQwBP7qhodPAmQNdiSjJ/KMxgQm6fSYqU9nDmRWkbbaAX2XH4tBH8Lu8XrzlzpFHMoMCyuRPtN6+6ry+nTKjeWSuF/hvHMTqvnVoWTUTe/QKXunW/4htOn+z4ENZt/fv7NQWieBAuAjMgV7YG+qndecaPkJDAuzVdhFuCFv7q+Pf+k1X2dVUqoC/eVWG/bI3OA1jrQBqaqjBFIgo+M9r2c+HhOZdYzRqbamLUztuy/8yEXRdg82PKyYzKFUdR3zb8aM5hTQRB0z/8ku97uNY/H9wJ/4t3Lw5T3S99y64gNnR+tLKK0CbqmSnRYUSPHu4uURU0rKIIGjQMm8lxgRXgbBiNoLqFFMk9BJ4YmGjI4j+1E3De+TURA+eHE7x73B3QlDz+QtoiSX7F0sJRCctjodWBZVMd5ANjI7PpIlvodH2wuQTD4mLS26P7Q0SfGBYAi6siEjim7xZmPQRMjECHRjkEiZjTQN6j+kk0HPM/jMFlbU77/bsvq6doip4saCMBldKbivu7c2VLaRcsuu67mEwS4Khi69ah/wFUtA7ZN+4OnWGcBF4Aw0awmLUN/Zif2Iode0tNyNQGAsW9rCfxmQ3zA++v7WqiwpRSFHQrk3gCJc6pH4HfvM2vAAslOhw/CEX5l36C1PIInvZgeAuaY6ZGZpxmXTlkIYqk6N5s20WcwmkGGes7GMOjv9UyHomzE1eHxU9WkkrPBfy5oMUUmwRJ2G2s1/PvtHhB3cMBe5o4ZAVn4a9tGEFeeJPr9tr6gGYJGIzcug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(16526019)(426003)(7696005)(336012)(6666004)(1076003)(83380400001)(36756003)(86362001)(82740400003)(26005)(356005)(81166007)(44832011)(8936002)(41300700001)(4326008)(5660300002)(36860700001)(478600001)(2616005)(316002)(47076005)(110136005)(70206006)(54906003)(2906002)(6636002)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 08:27:52.3131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88895b2-44a7-4f9a-a3c9-08dc216d59ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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

Return r for success scenairos in 'gmc_v6/7/8/9_0_hw_init()'

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
v2: 
   Changed 'return 0;' to 'return r;' in 'gmc_v9_0_hw_init' in v1.

 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 229263e407e0..7e53b7b043a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -916,8 +916,8 @@ static int gmc_v6_0_hw_init(void *handle)
 
 	if (amdgpu_emu_mode == 1)
 		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+
+	return r;
 }
 
 static int gmc_v6_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index d95f719eec55..d30b57820c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1100,8 +1100,8 @@ static int gmc_v7_0_hw_init(void *handle)
 
 	if (amdgpu_emu_mode == 1)
 		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+
+	return r;
 }
 
 static int gmc_v7_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 4eb0cccdb413..5d55e2313345 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1220,8 +1220,8 @@ static int gmc_v8_0_hw_init(void *handle)
 
 	if (amdgpu_emu_mode == 1)
 		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+
+	return r;
 }
 
 static int gmc_v8_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index a3a11538207b..b5651e0426f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2343,8 +2343,8 @@ static int gmc_v9_0_hw_init(void *handle)
 
 	if (amdgpu_emu_mode == 1)
 		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+
+	return r;
 }
 
 /**
-- 
2.34.1

