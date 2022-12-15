Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559A7C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 22:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EDF10E584;
	Thu, 15 Dec 2022 22:11:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2758810E583
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 22:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+GahaOD9b/WJ1oczYf8PGE+5crGXvYq4ezCGaYFYI2c0Yu6DkTWkIZrvgn6rVH6d8SCGJWqKngDGjxlEmUExKrS9eerLeg1qwS3SCZCVSp+ie0YoNDovf9hWuam5xO35k9QaFcbPlmO5YMqU7d+mXnUQsZ3VO3J71XUy1flG1KgoSPC8dSnGJ0rwh57VnAfhyCqtwEBJVZk+nbBorRE/Ons8OPGlOgVPcxSTIT4iwRg1lJL4vhOsulYN/hOELSxGvUUrGPA1OzFGLaJAGJFbG9V/xgvux2TTm2ODnJYuuXXDirI0FcctW7Q0MPvSAh4xVuJyt7sycQ+k8lVCgIZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phNeERq726jxj67Q7gKViaZOo/rTuaCIi3JP1uTGg8c=;
 b=VRLF/it3lYzQBWMvAiWx2nbh4CxFChJac/EDIqoHKlD7ZEYTV5tdVKt3xYoErHTl3ET/OwCHh/EyoRBZBV4Q7sN1ecC5CNd4CaPtRXOPouPfX+kF9Er1MJGjdHygi3eHI0n6LtSyG/N+DTkjxsA6xdJOxzqV5fnh1cFj9kVoszYD09OfIHUxI2RrDqAOZ7moL7LK9FwIlskUEHs5gSw2f20Ctn6Ee1eO89dfOxRzbdFJgtKtzwM6Ez2aVPUxVtM+0RhCFnahDiCksFS9ssfSKBveHTFqpF9csRl2cGjoQGaCc0TdLBxIE9ETBc34IXCKJzfPckQkCSAusfgkO6mjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phNeERq726jxj67Q7gKViaZOo/rTuaCIi3JP1uTGg8c=;
 b=PMTkV7deINFKm74GmqrXAN9XhBnxC8sziuJoHL1iboWj9P/X4jxMMbsuzVcnzVKdxFWg2WTLrpzS91mtMdiZoFpom4q7jvpSMsP5eItaDF+sdnB7cOO52HqsOth6iJ7LpEIvAzXcd6YOokmkEmPH+y0NlnfkFTWRMHa1nJ1kVKU=
Received: from BL1PR13CA0304.namprd13.prod.outlook.com (2603:10b6:208:2c1::9)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 22:11:19 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::28) by BL1PR13CA0304.outlook.office365.com
 (2603:10b6:208:2c1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 22:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.10 via Frontend Transport; Thu, 15 Dec 2022 22:11:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 16:11:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] Revert "drm/amdgpu: force exit gfxoff on sdma resume for
 rmb s0ix"
Date: Thu, 15 Dec 2022 17:10:59 -0500
Message-ID: <20221215221059.509565-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215221059.509565-1-alexander.deucher@amd.com>
References: <20221215221059.509565-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dfe4ac-2bc6-41d1-b840-08dadee94a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w76wBHt/JuEqVEnTvcsejYPd06jLUHRoEeCfHjRwCzNV5vXsxPZVkRR++/Q03Eoo79rqjQEAlNjNayXG2wjY7lK1R6Rn1pn90Vz96zSWPkwX4Rhbvow3jqQxzfV/9wIxq6pleFoIqpgmsHUANWioi+vjlZvsM4nxPLZjqWPOX/lntsdYctixReWuPXGIJYY1woW7EcySzNOP9lE8uE3sX/LfCZy6rV0YxagZb69t1iIdU2tRrMmsgh9StqBhsZXoknNW5sdih1hadEr7lXfpu+bHgqYloikW2ejlrLwZMe/bEh8+tzx99r6cRfWRdhaXBnaVLZ7PpmdW7F/R/6QPJ2hkv6PTSsR09CHgNuVWuFSb96zBFYQjD+z3oP24fUwsxwo31rvpS1z4w3ytdj2A4/UlLAY2sYSz12VA9Df6pAJQqJACeYX4tOZv9OrNnP1D98FJpWX4zHkYKu0SrPz2PJUmWdZEY4Xh4LP/ARkzubP0GWgmYaj5GmymYqonTOCfdVYUgDobTj6MbABap2hyxwmeCD85Vo1qfdZjrUn9FDA9Nh8kZU7R81ZZkVzPtCngbJQ0z1UjYSckcb6sFaOOkfDy+xf12O4bCe0GTQgvP3Wo7dj8L/m4ahseR5IC5yEkF1EQD3FxnaC8+UuGORPHTf2wU31WRNNentfsuaD67Qq7wINlqexqymDMZQ/cUMSWBZwWh9XgT5911iQZGAqn9CudhRKqa+Ch1Tq4BbZT0o4FdHWWAZOloXslxrO+APYrpJIa3iQvIlvQsfshTVtxHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(81166007)(356005)(336012)(2616005)(2906002)(82740400003)(1076003)(16526019)(40480700001)(40460700003)(6916009)(6666004)(5660300002)(316002)(8936002)(41300700001)(36756003)(26005)(478600001)(186003)(83380400001)(36860700001)(7696005)(426003)(47076005)(86362001)(70586007)(4326008)(8676002)(70206006)(82310400005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:11:18.4508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dfe4ac-2bc6-41d1-b840-08dadee94a7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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

This reverts commit e5d59cfa330523e47cba62a496864acc3948fc27.

This is no longer needed since we no longer suspend SDMA during
S0ix.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 809eca54fc61..65e7a710298d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -809,12 +809,6 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 			msleep(1000);
 	}
 
-	/* TODO: check whether can submit a doorbell request to raise
-	 * a doorbell fence to exit gfxoff.
-	 */
-	if (adev->in_s0ix)
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	sdma_v5_2_soft_reset(adev);
 	/* unhalt the MEs */
 	sdma_v5_2_enable(adev, true);
@@ -823,8 +817,6 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 
 	/* start the gfx rings and rlc compute queues */
 	r = sdma_v5_2_gfx_resume(adev);
-	if (adev->in_s0ix)
-		amdgpu_gfx_off_ctrl(adev, true);
 	if (r)
 		return r;
 	r = sdma_v5_2_rlc_resume(adev);
-- 
2.38.1

