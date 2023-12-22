Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D032C4706C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 11:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B539210E03B;
	Fri, 22 Dec 2023 11:34:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BFA10E03B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 11:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErBlMrk9jKfB+YSn1L1WuphEAss4xW4MlxU/8mr0yMsRxdsI1clo3eloCC/ixhTcIAbZ5Iz5E6B4JUwI7gksmz6wZfBn5xJRZ5iPmuawBjNrR7VZN2vHRRAAdjyWiuHUk8LSDA3gY2doTOmhCANa1hTrWokfFVPm9JimxvJJUqhJERKuZTdTOevFqhhZYXqYEoHqG44XEMqFpy0OZ5xSgNI/jW6nqGEMmLxrKjafpBka8iy/CFd0udFeOkZxTKHL2xfOZiiCwnkcE91SGUt8XZ2gzy8N0AbkW3NiIGew58G3PYDGIVXG+VEKbNaOnzIb+P3Wrvd53Dc0imtP5iAObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAB59hlXEL9xCZaj2dAlCFl91/9S1Hr+LnFgbDyAgm0=;
 b=AW+1KV6MksAV3most1GiElmZ+pcFbqFORvfeBIZL4r+7HIxEg70KMB9WSD0rual38Tr8IKNKL+2oF+GYO3eieATm33ypOB73/MJeG5bAAF/mexR6msU460F9geOYqPiYyXhfHdW/QivpOo8R0zA2uuAFohIIAgkIn1XwM7y6BWTke3EUyS4cxXo4S95cZX8qQ24PTL/mlMRG5CyDS6NywbR1LDnoBmJZR5tWeYszEQ2TCODu2HhARi9bsK6rq/Q6ECYcsVoiXUNSQi8b693O4j879a6sw5Vk4fWGhsqtaBASZQgTVt+kXUUOER98sZ8FIdZ/t2Rg7bJZubBqU70xbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAB59hlXEL9xCZaj2dAlCFl91/9S1Hr+LnFgbDyAgm0=;
 b=hdgyClGv4Q/mX13qX5iDW8NQSp4Lh0FeEUqELnY00eQ985UYV6o7rp97OFzzBdKfQDjBcF6R081n5RdF+8nQ3Xv3aGEUNYkri/sGEOqU73dYWxmwJA1lxd6xQQ0e9lPZ7eyGHnllSbPAC3PJh4aI7gYOvSJqJ7RV/lVL5yhGfYo=
Received: from SJ0PR03CA0348.namprd03.prod.outlook.com (2603:10b6:a03:39c::23)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Fri, 22 Dec
 2023 11:34:55 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::7) by SJ0PR03CA0348.outlook.office365.com
 (2603:10b6:a03:39c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 11:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 22 Dec 2023 11:34:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 22 Dec 2023 05:34:51 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9/10
 _0_hw_init()' function
Date: Fri, 22 Dec 2023 17:04:34 +0530
Message-ID: <20231222113434.1683616-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b69cff-0234-4ba3-8bea-08dc02e204c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmnGdA4Yqt2NkvjAbep5jfdu6CySG3aFApRJtkhZZ//Gm+GrTWgXUdq0qcMzGY/O/TOsLQpGZ7aIHxLMf0UNs9S95AHQHCSmOUo0r5mPCOjAPaqvAjvMTPsc8nbrwfDu9TeSe2F3NNa0m1nRGsuzLp5k4Q7NkDo5gW+qB/g2p0IkBVy7WNwNcGpFHoAnnuUJPWN6gASrGMSDL8aZxDXbK3RJyVN2iMd948nXjhh6mQRUzERHH4hvXOZzENvASHgF0ENTaNyxf3dgfqBjaPOPshLx3Xg1rdvY/Am1SSGLKIAncwHRoLi3ixs5Vu8DX8rBRi1EeqFeshR/1vWS4N8s/S1tB2udOxKLWWbJ2ybGU8yIq3JD9HAuq+n6TwWLlI6vZCnBYi9nh0eXEtLNZC6Eh0v9cn74zhCYG6wU0KabyAZdTNTbTextwqZbn7NJPODJDJomcvK1aQX5oMP1QKKDeAk5HewtZxHZGk7L1pDlLn+AgZZcTkiFA6bGhu6sjzqilBdjPMw1Ge5dzNN780wSFZDGStY2utfI4z1ADcy6l/0LJ1J5feVZX7LEugRQpo8FmAb/xOi7jueDjPZJ/plWFI38IbMV2LHhtnN1YrViAcQbVMALyFm0VoyTRj90GYURkW0m9tjYiV13avPWmtRdPYFhshcf/U56TZfesUTRBkFGEJr0ba5YjwbxpSt9Cz9pH2hX2+VhilNnwEox7qtHDPB62nQbofhBm3tET8L7o45LhT4SJWoCvuQwU5DPSuYbma7FeMwE3Uc+HrYZhIviyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(26005)(2616005)(16526019)(7696005)(478600001)(6636002)(4326008)(8936002)(8676002)(54906003)(110136005)(70206006)(316002)(70586007)(6666004)(2906002)(336012)(47076005)(36860700001)(41300700001)(1076003)(5660300002)(426003)(44832011)(81166007)(356005)(36756003)(83380400001)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 11:34:54.4790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b69cff-0234-4ba3-8bea-08dc02e204c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The gmc_v6/7/8/9/10 _0_hw_init() function in emulation checks whether
all of the memory range of shared system memory could be accessed by
GPU, from this aspect, -EIO is returned for error scenarios.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:919 gmc_v6_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1103 gmc_v7_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1223 gmc_v8_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2344 gmc_v9_0_hw_init() warn: missing error code? 'r'

Cc: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  | 11 +++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 11 +++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 11 +++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 11 +++++++----
 5 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a5a05c16c10d..6172816f54da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1004,7 +1004,7 @@ static int gmc_v10_0_hw_init(void *handle)
 	if (amdgpu_emu_mode == 1) {
 		r = amdgpu_gmc_vram_checking(adev);
 		if (r)
-			return r;
+			return -EIO;
 	}
 
 	if (adev->umc.funcs && adev->umc.funcs->init_registers)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 42e103d7077d..68e3fff02308 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -913,10 +913,13 @@ static int gmc_v6_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_emu_mode == 1)
-		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+	if (amdgpu_emu_mode == 1) {
+		r = amdgpu_gmc_vram_checking(adev);
+		if (r)
+			return -EIO;
+	}
+
+	return 0;
 }
 
 static int gmc_v6_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index efc16e580f1e..1a6bee9b4777 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1097,10 +1097,13 @@ static int gmc_v7_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_emu_mode == 1)
-		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+	if (amdgpu_emu_mode == 1) {
+		r = amdgpu_gmc_vram_checking(adev);
+		if (r)
+			return -EIO;
+	}
+
+	return 0;
 }
 
 static int gmc_v7_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ff4ae73d27ec..192041c707a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1217,10 +1217,13 @@ static int gmc_v8_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_emu_mode == 1)
-		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+	if (amdgpu_emu_mode == 1) {
+		r = amdgpu_gmc_vram_checking(adev);
+		if (r)
+			return -EIO;
+	}
+
+	return 0;
 }
 
 static int gmc_v8_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 473a774294ce..f2ef1d8107f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2338,10 +2338,13 @@ static int gmc_v9_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_emu_mode == 1)
-		return amdgpu_gmc_vram_checking(adev);
-	else
-		return r;
+	if (amdgpu_emu_mode == 1) {
+		r = amdgpu_gmc_vram_checking(adev);
+		if (r)
+			return -EIO;
+	}
+
+	return 0;
 }
 
 /**
-- 
2.34.1

