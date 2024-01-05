Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE0FC3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 15:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0724110E05C;
	Fri,  5 Jan 2024 15:22:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4256210E05C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 15:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNbkXrFM2UEL8mVR+8PPhLhNxmM09KP/caKhyfe5Wk8pL46m/IeVjpeFtBlQK3ysSv1jU+SFMbKUlV+EKytkpo4Ck9aDWTq1h4JQ0SpJZO7LIATIAi4WXeF1s0k2Pv/PqsXvONOCi90hvtUkmWshV1nklDMphq7wte/OtUlEZLaKfplJfio7i7h+Dcex+cMfluFeFBpJxL4c224lc3T2l1md/pdvfwCrFq0uYWww38AYGe3r1UC2mzk/+i3aTdUY1w9hiQhuxu/oXoX8kb0zUk8QSDZK7nTPBtob5CfKqatMxmKewRtnU2/REWWvgGfB8HTuUfL0NWEee7trwYowuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7QEJTGinlPYyfVA5FmdaooHh+06sWRKkTYeHIzcq1U=;
 b=R2W7R32LsmsqwRU9782XiFsHd8G5Y5oKqAGoeeg8f/aZeNXtV/WX/zqE4kjBBzNPLlSt0NRsZyvJa3bDpdbRow0iotBUP/DgzhNNAzqX6pYVXKMeV2rKN37meGtB0n/vYBZhZtoHx5M+viHIXVSFaA921u3LxjMO32fapm5iZpSdmEI4+7P2Hi9jOPiQXR8Dn/F/Rx81CUQ7tdNGI3eYCx8FwYEVPRvVMFFw09GQoCgkEtugJwX7Tt66Wg6ILuksvFhhl6xxRSfhYtZPhrqKytl2E3yXkF2KLSUJc8kYL4SoItPOJ3HSuGnRHSbj996Kasf8DJVlaYW5hOJ1Iz7qXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7QEJTGinlPYyfVA5FmdaooHh+06sWRKkTYeHIzcq1U=;
 b=L4+Hnj1k3urPCv4h85FjlJy/jip16arhnlFUMvngC4XmDz5GoIgmQ6ZBlW5fQoFkzxZnQU2MOqJ65Zwdj3naEBpe0SDqwPFW9kV3SeQii9lPtY9RANrB+aFa0bDrU5tBqys79fGKpN1KD8PV8/390cR30wWZwfO8+RTp9CE1aSs=
Received: from CY8PR12CA0005.namprd12.prod.outlook.com (2603:10b6:930:4e::13)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Fri, 5 Jan
 2024 15:22:00 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::13) by CY8PR12CA0005.outlook.office365.com
 (2603:10b6:930:4e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17 via Frontend
 Transport; Fri, 5 Jan 2024 15:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 15:22:00 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 09:21:14 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update irq disable flow during unload
Date: Fri, 5 Jan 2024 23:21:00 +0800
Message-ID: <20240105152100.471494-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 91869418-ae53-4c85-b5ff-08dc0e02100a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMM+e0MJCZnIc28FoNSytF0bn6wo15+RUCuFClxU+nHPkgQYBzwgSaSOnP0nY7vjx4m8CtVQkujWS2Cfb7IElooFzJnEXLnaae8bF6y9LnM9p88KuyUHOJNBRc1tMmS5Im+lsdk7jJzPm1bBQcocqEczO6Uf5eN3p8r5IL+RR45Atukvg1PdvmGbhm9AKUvMjKB4UrQdy6x4bFLbahwjKF8feAdKWd3xmD5ULbE2PLG0t9dk1df0g4zhklHkHQiS335cES5FnZiXzcCFtlEG1oNvdYwVgaj4fFybn+CWVZKMULmqN6DT+ilMKtMvZeOxuDIbiuOxnZLseMmDxWplyhreTAsASbws1glliK7ru3NVjMPxHp2W7D8mMBnkzQ87YpCE7jU+TT/3VCEgLbkQk0wFR0ECufvQq2+CGlE6Y+abmyGr4vGDxIQQgkwiVz8PEdWC6A8kSxwHZMZ37jl2oES0Lft5Qh2qroqv2wquNNBs+DCbKhG0tTdmBILfWHWCOesODfB/xlwTBgR3Q13j/x00cafddrjjMBnb+16OH1m7EkowDGbfZi+DoDhJCM3hEFK22skAmT/C3e29Cnz2A9I7NNUQTAz7ICa6ZX/KVmn7GGy7YfjucLeGk/aDGQV7dZP8e8LKmTHdD2VqrlL1KlfU3EoBlW5jxpOSSQ93iIr9TJum2+L+5oLJCbz7zIsWb7c5UYvoPeYAy2PFcOLsfmxsI955shX7yXG6JzximECLrCWS4UE7IhmIxRXAptfyh01JRynNS7c8Zqt9UNdeOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(82740400003)(478600001)(16526019)(36756003)(336012)(426003)(26005)(83380400001)(41300700001)(1076003)(86362001)(44832011)(2906002)(15650500001)(81166007)(54906003)(6636002)(47076005)(5660300002)(8936002)(316002)(70586007)(8676002)(356005)(110136005)(36860700001)(70206006)(4326008)(2616005)(40460700003)(7696005)(40480700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 15:22:00.0691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91869418-ae53-4c85-b5ff-08dc0e02100a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552
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
Cc: le.ma@amd.com, asad.kamal@amd.com, shiwu.zhang@amd.com, xiaohu.meng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In certain special cases, e.g device reset before module
unload, irq gets disabled as part of reset sequence and
won't get enabled back. Add special check to cover such scenarios

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c    | 13 +++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 372de9f1ce59..a4e1b9a58679 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2361,6 +2361,7 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 static int gmc_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool irq_release = true;
 
 	gmc_v9_0_gart_disable(adev);
 
@@ -2378,9 +2379,16 @@ static int gmc_v9_0_hw_fini(void *handle)
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, false);
 
-	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+	if (adev->shutdown)
+		irq_release = amdgpu_irq_enabled(adev, &adev->gmc.vm_fault, 0);
 
-	if (adev->gmc.ecc_irq.funcs &&
+	if (irq_release)
+		amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+
+	if (adev->shutdown)
+		irq_release = amdgpu_irq_enabled(adev, &adev->gmc.ecc_irq, 0);
+
+	if (adev->gmc.ecc_irq.funcs && irq_release &&
 		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
 		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 15033efec2ba..7ee835049d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1266,6 +1266,7 @@ static int soc15_common_hw_init(void *handle)
 static int soc15_common_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool irq_release = true;
 
 	/* Disable the doorbell aperture and selfring doorbell aperture
 	 * separately in hw_fini because soc15_enable_doorbell_aperture
@@ -1280,10 +1281,18 @@ static int soc15_common_hw_fini(void *handle)
 
 	if (adev->nbio.ras_if &&
 	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
-		if (adev->nbio.ras &&
+		if (adev->shutdown)
+			irq_release = amdgpu_irq_enabled(adev, &adev->nbio.ras_controller_irq, 0);
+
+		if (adev->nbio.ras && irq_release &&
 		    adev->nbio.ras->init_ras_controller_interrupt)
 			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
-		if (adev->nbio.ras &&
+
+		if (adev->shutdown)
+			irq_release = amdgpu_irq_enabled(adev,
+					&adev->nbio.ras_err_event_athub_irq, 0);
+
+		if (adev->nbio.ras && irq_release &&
 		    adev->nbio.ras->init_ras_err_event_athub_interrupt)
 			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
-- 
2.42.0

