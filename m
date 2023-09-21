Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6008E7107A
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 14:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5075310E134;
	Thu, 21 Sep 2023 14:13:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D679910E096
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 14:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmUnMgeIUuuR2+chj/S1f1/Y/iYoZ74L4As1Mjg2zU3tuE3ROn/8Prl3Ktc6UENfd5q5mDNcUQ9QCIndWLVmyOP4MDaQnuavzOZQrN0QkYuQPHpVDF6NVa7U8GL4f3OzphPDJoR51KHaqahX4lXIzNmSFFAFcr7j1PpA9bdR9Gvzgxdbr+9UkY4sgDAEyw5S4k3WsVGvDf9BYgEF8B+C036PAoVnHtIiKEl4Jgi2npkMyKA8+F9Ef+W+gwqsZGcMLFIA/tw3mXkxaAhiGAzat5/UXfM0E8Kqaa5NqgUaoiciWkOyLt5Ugq/sBYaMWqW4+MQxtZLB/P5/+iBtI/z/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9cdlBssBPwyWoNREModWZt+UufW4b8xLm3+urKprek=;
 b=Q4yOJquylOaqpMyOrHSFIrEPs+bL1hwW6AO8aziwRSi27Jpd9DMFwCXP5DvTmr8igoQVMMJGmWbcd2rCbXKdsOOqyLKEK4nYeQNT0z9oIuSrDGhXZIONVuOOfwAPvXjLcL7WGtJVqRcrHasIe8iTOvxcDl23Sbf7SiRHqXHgzfyQmIKyGosC44DCByUuL4myOUPGSB3SSExsxpHbwgcW587Jrc/Eyg+kbhGBS3vZssnvRnFXC4g7vAedUJPLnohyAXumgtcO0ybHKn+BQktm6EOef8lIQum0dZQrzI3OVeD5c+e3XSH7j2M6O+36E4o0Pt5TKVTYHDYyD9QdkMXkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9cdlBssBPwyWoNREModWZt+UufW4b8xLm3+urKprek=;
 b=oexQ8JAULVryzx/kzZb+RWOQA/QR1JlcegkQ3FrQWx4JFoO98a1JdLP6Z3NfaDlm5Ogs4Kbc5145LeOxC4n8ly2znTAKdwtSWL/QMdMJfQbpfkN6Axj1UBiu4FAn9N8Fegec3oVgfsQF+AkmH7hmVInV6OFbDt9hQT8D0ljvdOE=
Received: from SJ0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:2c0::8)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 14:13:17 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::93) by SJ0PR13CA0003.outlook.office365.com
 (2603:10b6:a03:2c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20 via Frontend
 Transport; Thu, 21 Sep 2023 14:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 14:13:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 09:13:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/gmc6-8: properly disable the AGP aperture
Date: Thu, 21 Sep 2023 10:12:58 -0400
Message-ID: <20230921141300.415876-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef19a5f-1322-46f0-e92e-08dbbaace6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCH1+TRrXrkOww7N8Al404izSFgRCJI8t5JV8BW42EGJ3DviUNrydChcUIYMbIDi/JPSpmfN0Hvcsh5enydibEHtCOVxkf/0BHfzEp2J2A3xhM8BF+Pg3hSpZ5ru0KVcWmu8qAvim6xUjpoHAJ1CnrJZcshiyoYA2Tu1E4nOWPXU3Mff2NhPRlXqk1mdZRB2jLDtrF/odjn6WQ7XmLW1NeHqYW8+oNdl5hBa46adC6lGvuR+Ms3RKdgAC9LLtOSwSBMBn+yMW1kOuPG4tlneCFh07H6pazk4wkx3QlwCFaWhRhw3Cr4HVvgh1bvtuXaJndKpam2WC8KOX99YAS63eIEjyitXTtJhNdOQqceg/S967OZNfrp69Tc9VUMI1IwF7NO89/EWORHq+mGGMffowripYl8EyDN+dbnfjM57g0aTBlkFx+w24EVZm4slmfyu1z7K3xwYlGbphznu96yutPexcLeNzGMmMzIJESp8u3gUhiJRt82SeWWxsLjrGVF08j/QogTGaz9QBjo5PodNLN5qIavpvQIJ4Kq3PAzMiH5pnOCRobC/F0WmrBrP5b7RrRvlW7zIo3k24GJEbTDgJpV9yj+pwUiCp6aNTpjM4vBIHukne6BcllYLkBX5MYP9KuhgQyhicLCMA+p50gym+fYBnbImZx3MjI1dcshs1uHWLkusDFfMnGF1kyChXo0sk2xJvWewU5+eoyDs70RHXrNK+z2o6OrGy6OsfIdZFoxUdZJ78mw++ZWgs+GXOu9YkbM1DiWJrzfywe/UB/Kbyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(41300700001)(2616005)(8676002)(4326008)(8936002)(40480700001)(82740400003)(6916009)(316002)(54906003)(70586007)(70206006)(83380400001)(478600001)(5660300002)(336012)(26005)(16526019)(81166007)(7696005)(1076003)(6666004)(356005)(47076005)(2906002)(426003)(36860700001)(40460700003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 14:13:16.9423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef19a5f-1322-46f0-e92e-08dbbaace6b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The BOT register needs to be larger than the TOP register
for this to be properly disabled.  The lower 22 bits
of the BOT address are always 0 and the lower 22 bits of
the TOP register are always 1 so you need to make
the upper bits of BOT larger than the upper bits of BOT.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
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

