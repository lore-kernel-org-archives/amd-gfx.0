Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0264AC47DDF
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 08:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAE510E8B3;
	Thu,  1 Feb 2024 08:57:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A4C10E903
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 08:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTYpOdT1t2t3Xmp6VcaxAuW2V0VtkELDzO1Crw+h7DQJqkJWcDfdP3bikrY4k4eNi59ciihC6xoRLDA6X/WeyW1oNuz9laq7yjLg2M9niAhaS9bUiiW8orAh+sPqAZfF37JhoSykGkcKTDf5tX9hjcXEaR8vSYLW1Yz5Z5n63Omta35ssX+W871MAnGwiqmrmWLFnUAlvxDQ3yLbVZoeOiX6XXJSIgBG2F42n1Jb33NLOEEmAoXZi7CH6pMx6YTl0SnFWIJQe3NEyrZUDfhga1dKb6zvLrHo3n6fV2O+k15IFQsmh8+IENB1HxLc4pZPbbTnKCJnJE21p5Z+9tNUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7KJQJjBGm6Uj5ClQRmjWkVg/vNKqnN+AGyvw1sDGHs=;
 b=KM50ONQlzVYXpfxDoG2gdIKNfalmcnn5wUzsSVei/BiBHMEvzH9S+Bdmbrh0keDhVgtmlqgARkw1y6rXrJrhop/2krpwyuCGQbQaZM0ps0pb4Po49NPp0hzQdV78U5j88DRRghiXaKyC+LajdIrpS6dwnuALACC1vMB6iXxdlDrea7XkgyBtpQFvjsQ5G7NHCu3hJ79oBzZt9nQ3DuIAmHmJPOc4xcL+TSK6i5l/hy0BOODJsog9NQ7z9fgnoTqAkmZwAM5dbmVYdhj6tqMf6J3KfV4jHLHIkRYq/cgDTB9sCoHzXXp7I1BZUrpTWdlaquGwQhT2M9P09QgjjQ8LGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7KJQJjBGm6Uj5ClQRmjWkVg/vNKqnN+AGyvw1sDGHs=;
 b=dZpvYv8pqmZ7TvWQCsYoaVqjnPEDXI43TdI88EAOOS0njwiFsN+a/4T2D7iCxzsvd+mbrjZL0vW4thKBcq1SfxKJtQJv1OWfl2jD4eAS/bBL3dzxIZ87mSO6LMY6f2J92nVpjSZeVsUcKsj82wrWGCWZ5z6cn7GATSRmzO8R9Ak=
Received: from BYAPR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:40::20)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 08:57:47 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::2a) by BYAPR04CA0007.outlook.office365.com
 (2603:10b6:a03:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Thu, 1 Feb 2024 08:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 08:57:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 02:57:44 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for suspend
 abort
Date: Thu, 1 Feb 2024 16:57:34 +0800
Message-ID: <20240201085735.989940-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CH2PR12MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4ff066-6ce6-4c2b-a97c-08dc2303dc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrvaV2SnsCSXKytVbbRbrcucvpnOW8tW8rtR8+ZHpyexpO21LRLuyiR3TquSrFhyPaEJpwmRFsXU2e94hERQjgEMI8ME+6IndKYCNRzD2tABKxEDF1xpFI4xglj4MklbnxtjedvgmdmKVzVLJk7nJEoWTwPRGliPG8X9TXhi2c21qJu7fbzcKgq2/mBI6Zy2QcAmtKpVrnpBdauGFYefjOwe3xVZco9Kx8yxtGMjPBbUu7jlkNCxGqr7SEnLOjf3Kk3jO+JQ8etTZlyJKuIbzooT/wJB11r8zh9u0La7pi7gqktFMuOnCqnydzxrvauwOgZ+O5Xjis3URYLyC/WC3GT571tQTaseqO6P/1OMc3bpBxd8V+7xqDTA8oDZgxrpYIj7qU6YTbLbu9NlZ/e2KVZCDbVqd9LQ6QFI28JuppClgvvQno3oLEradMjQIIGF/efDr124niQRSa5Tf3m/CbJouH/SUPtT4BpVk6kn5ABFXIkeb4DX4vQ9aO49qiNJBg9jlbIFDwhAKriAiUT/iaFeIGXVTpe+neiJCPglUjQWrS7vT4jowQ/9h3io4z23d3K7hL39n1jFcUoaGpq9a8B8aT8ziV5gI2CQ/mC0xVK30cBkKCjpPNz6Srf1LjRyJdxsSS5GYQ6TwPxn8PwnQMOMAIPEHbTe7GqgOjFFSJ/S3fe4tydiOksKwDms69MNrj0EPRAdrWeWDTlFvgVAJdo3avokt40tr3NWI3nkbNNEuhrw4C46CZ+GIAXh/pSmvG9o8SI0doiS+Ihsf4zUpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(36840700001)(40470700004)(46966006)(70206006)(316002)(8936002)(4326008)(8676002)(15650500001)(2906002)(5660300002)(54906003)(86362001)(70586007)(6916009)(36756003)(36860700001)(356005)(81166007)(47076005)(6666004)(83380400001)(478600001)(7696005)(82740400003)(426003)(2616005)(1076003)(336012)(26005)(41300700001)(40460700003)(40480700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 08:57:46.4845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4ff066-6ce6-4c2b-a97c-08dc2303dc39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
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
Cc: Alexander.Deucher@amd.com, Deepak.Sharma@amd.com,
 Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the suspend abort cases, the gfx power rail doesn't turn off so
some GFXDEC registers/CSB can't reset to default value and at this
moment reinitialize GFXDEC/CSB will result in an unexpected error.
So let skip those program sequence for the suspend abort case.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5f3859fd682..312dfaec7b4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1079,6 +1079,8 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
+	/* indicate amdgpu suspension status */
+	bool				suspend_complete;
 
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 475bd59c9ac2..59254144916c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2472,6 +2472,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->suspend_complete = false;
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
@@ -2486,6 +2487,7 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->suspend_complete = true;
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 57808be6e3ec..169d45268ef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3034,6 +3034,14 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	gfx_v9_0_cp_gfx_enable(adev, true);
 
+	/* Now only limit the quirk on the APU gfx9 series and already
+	 * confirmed that the APU gfx10/gfx11 needn't such update.
+	 */
+	if (adev->flags & AMD_IS_APU &&
+			adev->in_s3 && !adev->suspend_complete) {
+		DRM_INFO(" Will skip the CSB packet resubmit\n");
+		return 0;
+	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
-- 
2.34.1

