Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF33C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 08:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4837310F83C;
	Tue, 30 Jan 2024 08:21:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E9E910F83B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 08:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awh58emFkvz/2LqkPUdJ6k5TUHXkcAN4qhV29ZJykZcFrYGJ1/Ow7C7jHo28rEpQx3qpfh446mjvKh/g+2vcmPpYZEJEpgeSIKaHbf+37HWfZr4B5iKGhtFL0idnwind0dmmdwlUph0S1+c3801pcwWQ60oUYu032kXfWMG7uXwDb3ottISzG4mblKaXw9yPYkRkus48FI10HQ1VqSz2Z1BCfzpq8w4dnHDST1Gkus/F6pllvz1yfO2ohn2ckgoqh8r4dT4cM7y0Ykizwmd+bSp1msX1GGM1XUtxYuyb4ory7NRlQDpsPwPhUloTFLepR9djhFef3iQCJ2FPHJMH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUJRB/azf1VgzVdmtWslNeONSlLIg+N3xpwajnGDoNs=;
 b=eXS2Smn2dFjIXaWWKDJ+IygIFUGwS9BUqxqBWKF/k375fz2+70O5+QLAu5kKmz6XaQr2RKU2wwd0tOfEvyzjRzpC5RtFmSGo1JzZBCRY46ClfakF0ZEwrC4ChWsehvrR0syDTgvS+PKJkD9hhsmgvrKlGld1oJvEwsZQIbjEF0W4wbWkceGXVpHSyK6EGq4hAm+ytzZJMVJJlOslmuARfrGlsiObB7kwjqJxLfSty3jJQWB2qgL5df70Owx9zZHJW/v0V40cYcgVarzJM4xMgSE87VZ6T9E0a1jPRvJ7T+jVRxMIXeCXLIOVr3zNuKkQqky9Gp1sgrA6W6YBpEU6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUJRB/azf1VgzVdmtWslNeONSlLIg+N3xpwajnGDoNs=;
 b=4GcmmGvIT8Hc1XSpS7kl95KnOPHb0uFkPjaAzyWn8Ypdi0dKI/dyaByAz0/ziWih4HQG+yymUJ12PYbpNm9OVMXEj8LxNxx3Zn41wgHsiu2O3kzmjNU87sF+HL7lENvERcPaQV7TdojQcquc8rnC/TokeeJWIrhBwd/oNEotUts=
Received: from CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::13)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Tue, 30 Jan
 2024 08:21:22 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::b5) by CH5P222CA0015.outlook.office365.com
 (2603:10b6:610:1ee::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 08:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 08:21:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 30 Jan 2024 02:21:20 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing error code in
 'gmc_v6/7/8/9_0_hw_init()'
Date: Tue, 30 Jan 2024 13:51:01 +0530
Message-ID: <20240130082101.397532-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe7ae7a-e1af-44cf-1390-08dc216c7168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jz/UKY4iWOju0i7GUxfi/WoRjjovf/blvQh/VaKJVkmWfd+47XJQwM4GVelXqrokICMOlmwjv8d6/OZvQlRugmup+OY96ZTLdWY+yE3X3LnhMzbKaNp6VCKJE8tAotNxWn+8/y2QqHnSHwUZm4RrGT+N/qWmxzLIIPWJ4CTmLXYwwq/rVWA2iYrUssyoQm7mufTqlE74StqN4OYPkeIF/e8hrc8o4NvkRIo9pMgIQt8Ufx7NAE9q61WXJIXQA+hkevyEjKZzqQ7UKFTAQ6VLCOJS1drwpqaiNM8nYoUzUZZW20tasJLFwsbqyZ8ELymipqBTvC757xBiGkpk3dT3BX3waXAx3+wATwkh5cIDiRc2NAK9Mp7s1NWX4lg2Zmj7barUNoth7ukYFC6Ilz05J88u2hfXv8YPYC+IU5DNWwukarzGQWdcErpC3oUvtSguRdHrHGFGbWC4AXPCL9lZGogdrTRli7bVizfebcseykhBAg2sXO6WKCOQXJMHoaVJNOOQoiyEF6T516+E0iUQcDxxGYp51htKl+qgDyngUCNTmTreQwsCdaljYxu4yye85ClcnwYc6RSTQ+C1W5TSzK5ErGfcgvmkWWuMjuAIAAfzL9Hule1F5hCLgdkmzwSQC2n0CbHz9HDWwDdowH4ahR7ON+hx8e9ZRXGDf0W7ernfqZ99tnjdrKuzvjci1aCOc03d8QxpRpGaugro+N1bCdwggAb4paI8KGJHEWtLDVCKu+v0StF8mKe4qgbNOWB4NdbH16e4SZs1dC0HTMYtvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(426003)(2616005)(1076003)(336012)(41300700001)(40460700003)(40480700001)(26005)(47076005)(36860700001)(356005)(36756003)(478600001)(7696005)(6666004)(16526019)(83380400001)(81166007)(82740400003)(70586007)(86362001)(44832011)(2906002)(5660300002)(70206006)(110136005)(316002)(6636002)(54906003)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 08:21:22.1973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe7ae7a-e1af-44cf-1390-08dc216c7168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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

