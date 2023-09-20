Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F343C04ABA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 17:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0936C10E529;
	Wed, 20 Sep 2023 17:46:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46AC610E529
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 17:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH/s1ay6b2LzaLOYVZ1fiCGq6fVE6wrby2duW7dMGh5H6coHbwyjZR8EOevpc7l0pjQ4vXTXatPmK68nB61yg4rXtA9VWntsH4aLhWT5UMv7x6m08ROEPJ0WssQDzZq3bwQFfFoW0C6ZeMNpvBdGrK+yxb9phN9XK0OumHlQ7czAqgiK7J5hZ2G8mq1uy2IIopjl1e4TX7Lm3qnc5jLNPp6tkNzWgQVuYVPBZM3V7+y8ZduH+cG7MwNoy4drEz06KccEUCEWsUeJx6IzDvshWqn8Glb2hLFHuS7vbW9FJBbXlV99xdyoR6Jq6RbLvGefrhCf8NEbSjkTNXgzuOENVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0B+ZgEXXDxxKyKejiw9N2sFBascDrD8TEGJb6ndZiI=;
 b=aYOEPGVRVE/MwZ1k+Mv3zzqzHrMKL0Ju8a1aU7juILqlRiMNNPAGdx5dCdg3Lrmw/eR15P7ZLTst1c402kZYF4KqSyIEYByD+BfATH+dDfxc/sESw0DXgUZ7HA1nFCcKrZGBz4InHsh+eQ083d9Dbj2UEY7NjU2C2fjLmVw4SLYbOMWFAsQEjIU+Nu7BVJxIYCF4nkr1+wVddfZX2tgjPPJsMzVdt1HQmSTTFswkrjHlQj5aGHzDwoEvhEurnhUobPQUl1vzKUHyPEyqVYrJ62QmbgwjsDz6rQpkHABZGAxbeC0rOy6meoaGRZd/gnGWVP0ki70w+m9mU57xixkq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0B+ZgEXXDxxKyKejiw9N2sFBascDrD8TEGJb6ndZiI=;
 b=k8zGUwsBEvHPa3kPe+M4MOSOC/CNpZUQicFsKSsX1PuSDTvCo5NnSGXa5uyMO/fmT7aalC8mwtEHVxot9jtrtAvbwJ4Hv4eLOt7PWz6u04HK1SiLb2Z5YvtvylTmwZNvphUer8ZYZJgFcxg71P8fdlf08ZCoWpdv/GUVIjqhRFk=
Received: from DS7PR03CA0103.namprd03.prod.outlook.com (2603:10b6:5:3b7::18)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 17:46:28 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::7) by DS7PR03CA0103.outlook.office365.com
 (2603:10b6:5:3b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 17:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:46:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 12:46:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/gmc6-8: properly disable the AGP aperture
Date: Wed, 20 Sep 2023 13:46:04 -0400
Message-ID: <20230920174606.3086966-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: bf704f52-ca41-4cd5-0bef-08dbba0184ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2Iu7x38gcvX37ctuQ2S7vb51RDrxdMBGWdtt/hDAvo9jRvUp4hNjHeN1thvAJlU7H4tIq2kfjcXk95R5wt96IN1KEGy5kgfQzc5NrV5OrPRaV6zoqxXIKN3t1nkvtyQd9ourvzUQa4NNz6FsFoqEEOHo/eWs2Rqrn3uLpLCj8V1DQ2Vg+7mbtGl7YIFcQB1xUgjrlr/f41J+CTisjeQvr/1TvYdJluHPOW0yk4MLRAfWNAzVUW3FN37yu+8hzhKPiTEnUalx2Pb42rPppWkXa2mpg86XyR5ytkOcsZ68dCUb3fj9SMq0Fk5FSy1MNAAiq7hKgf0JKJOFEQtOolQv3wAdRBlD0/EKbWezt0ivMYmK6sWNeH3A1vEOleEI/was07rUjRi3frM8jZQ2Zi1c7j7LTeK2HZY0qwgtI2gIkfyI9DZTjNk0NiiIt7Nsye2AAoqSX0jNh/JqYcp7+2y3+vIPgps8IfN2/OP0aeZAy8T7j+KHlJDzMSih1ZqpP74wehc2sLwkYmmYWIe9Zs8i2/LYJouYoj8JBl8wQ5EnRFelt99YzpgddHkv2xcr23zf9cSDCzBc4lpl5lyhbY5mWnrakLaR7xj/xk//JsaDbsuI/H7KRvxuZfM8Hxs3o3NihF8ikDgd+V71JgOxhUqUAG8uomtHKzpIjbFx8hbvlXCd5Ibi8BfX4PDdWY7g29JPyP2GBSNfK6gUQUefY+j+9Q2aYEphm+QwF9G6doDmqxBxjuI9xkibKnHYDtDiOuoPucyjfOhEAaIcS5zBx7BnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(478600001)(41300700001)(5660300002)(83380400001)(40480700001)(6666004)(2906002)(70206006)(316002)(6916009)(70586007)(8936002)(8676002)(4326008)(7696005)(1076003)(26005)(2616005)(40460700003)(16526019)(336012)(426003)(47076005)(36860700001)(356005)(81166007)(36756003)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:46:28.5877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf704f52-ca41-4cd5-0bef-08dbba0184ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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

The BOT register needs to be larger than the TOP register
for this to be properly disabled.  The lower 22 bits
of the BOT address are always 0 and the lower 22 bits of
the TOP register are always 1 so you need to make
the upper bits of BOT larger than the upper bits of BOT.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 5b837a65fad2..07579fa26fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -253,7 +253,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, 0);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
 
 	if (gmc_v6_0_wait_for_idle((void *)adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 6a6929ac2748..e77e5593e1ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -288,7 +288,7 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, 0);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
 	if (gmc_v7_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 5af235202513..6acf649469dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -473,7 +473,7 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	}
 
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, 0);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
 	if (gmc_v8_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
-- 
2.41.0

