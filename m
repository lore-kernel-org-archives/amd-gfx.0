Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFA1C2FC0F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD37210E54F;
	Thu, 17 Aug 2023 18:11:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE0A10E545
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrxlgh+4StYGGlQnDMhMCcr/k8x1/JxL0fqMiGgnD0qKMALN6FPTEmNZvppxS/i0LBCnC4/6X2CRYXwqcsK3f5RyEIjqH+YS+cRjjevLajnSyrPGaDKzRviLKj4+kISAVO7mzDkE9NNXLk+/PUZRy++76mz63fNZR5WPiJSsYbZCjivTK3PxmCYtyDvGcVjNrqWUdespNGIvfkmGmzCVqpoJc+nHHeymlzqORJrxFbQP/iMAQjlChuQ6Of2DFLnLfjop0i5MVcDd5XcT4fmJPnA5ia9yVgiT+cYc8XdUmOKGkQwqW460slONcJm2tH516y0m0/c0f8w085UtvVey3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2foQzyrBfCiItuSL4kKp30h3WM+oO6oI7wbVS4ub1Js=;
 b=HBoxMjTeogMhV43Pt9Uqd0VGx5DxUydooellYeKNHolnB/Gs9lPFGOskYXW2qP2N4mZBqwjeouQMvSYFmmO3pS5T6h6fja+vt/EPrnA1qVueRpYZViGxL+yA1fLhVM8aZp1uYeqLNShZMAw2sAtND1QCV3rZaFfe8AFRISm0uWhTEYIh+ZKB4Pa9tbwzHsHKrodG6vAn/016A1YmEPW/L9EA/8NQHEQLVRvJWS3HUUSj7VJ0HMaAmgjUb0oJBa1stIwBPPOYo1gs2MSHlcFfwVqdzvdsqJPOD4JkupjNTIWxfnIp6nIXIA1R2f5wlBCSiAK0AUEZ8cKRDv8nRbaNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2foQzyrBfCiItuSL4kKp30h3WM+oO6oI7wbVS4ub1Js=;
 b=k2cLZDjNqsGDhCryFCD3jEet4aunW4xPhdcJTdzIDySh01jxnmm/cg7koR+1mLwkgJPfbvnC5Gl3txvrL+bAwg9N1hRnIl3Y8J2FzDW3nNsGwr9rU4TuTHTfxM60ULS5sKioVW3be/rEX3kuY7wJFXZPlf/U38IE6ZZCZFI0PyA=
Received: from PH8PR21CA0011.namprd21.prod.outlook.com (2603:10b6:510:2ce::19)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 18:11:44 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::5c) by PH8PR21CA0011.outlook.office365.com
 (2603:10b6:510:2ce::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.7 via Frontend
 Transport; Thu, 17 Aug 2023 18:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 18:11:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:11:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amdgpu/discovery: enable mes block for gc 11.5.0
Date: Thu, 17 Aug 2023 14:11:20 -0400
Message-ID: <20230817181122.1543473-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181122.1543473-1-alexander.deucher@amd.com>
References: <20230817181122.1543473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b4bb94-9d7d-46c8-bbe7-08db9f4d6a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGTYqNl3UZsN9ASrzzF+PKs7i/yR9JvP6zzUXmqwKt2wYTsndejB8eb1/7RGEEzjsprnBGZKWTGMUfh8eTaVOwaK8dyYH+uI9fIXN7eJXWG/0LRTPoD6/cWcm6V180ZCkZji2KR8jTjsyO6MtjLhFmelMOOYf91cCVPD1trwq1gNKsXSuc0Lggs5BsvPRoXbcqGqhbfi+Dj1i4nQrcXq9D6msoIjsto+OT/H9bHLEsUN7bey30KPScUWyXdSM8AMe7oTmnfqm0GhZf26VQELx5dCSe/dZwW7UjR8fSD4NQ3gilKwOM4iGJAu2v0SZJuhIoBVDyUhX36DPiapdvQsVFLbJzi6/1e1fg8bdUpD8iS2um0UKw1zqZI85Y99sotehW6EeRj1RqWuhGXUXJBaoM9LDTX9DizI6AtRxSDnEKRuctQXamu/amP+S9b/0zZz1DyRduDbnjM0/oUg8MfrysMmdhb448XTstokI95x/QfemuyfGe8Diev0TYMNnmNAuc8diPCNtI3XwPQscAeJLnvLE/ZVYDpIA4PUMTxgFLqRs/JogCqRtcIp5C3ho9+VcIRhFx+CbRrXloeA8i5Np4vnGLpgBkONPLDtgXbdZBAJ5MkGaBOOX6nS8roCPUgeMJfuRH362j8zeRCKE8SsQ0pDYS8NXVhG5djhNRb9wRTumza7TkqVeRmidqDOZoIbxdxwHPaE2AbZ04lmVqWa5hb6wvL5CVoAV2gqopT/KNNRF5sLLkNw3kQ2ljr9CcePN7MH+PgeQsYeOOt5wjtBfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(83380400001)(4744005)(26005)(86362001)(336012)(40480700001)(478600001)(426003)(36756003)(7696005)(6666004)(2616005)(1076003)(16526019)(5660300002)(36860700001)(41300700001)(82740400003)(356005)(316002)(54906003)(70586007)(70206006)(81166007)(6916009)(4326008)(8676002)(8936002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:11:44.4653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b4bb94-9d7d-46c8-bbe7-08db9f4d6a26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add to IP discovery table.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6ad2dae3bf90..c9b688d372a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2096,6 +2096,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
-- 
2.41.0

