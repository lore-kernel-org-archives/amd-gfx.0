Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1790CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 14:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5458E10E502;
	Thu, 19 Oct 2023 14:51:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DF410E504
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 14:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdL4/C6NMZSODC/4QQB7wHI3561Rhw/2+dM4ik6V8fPHZcbd7/KDiEIH4csvAi+aS1EX2igHZmJr062aSWb7lzrC7euaxkL1UkA7cchQP6TyxksxVT5Vww1SUDsLY0q9/vIC4XGlvrl3I54M9oRXF7LVRgO4GyZbf2D2tS+ujW3jUcFywI+oUU52+euNsnYIkR9EFKTvUOOBVzafb1t5egZ3HG3xzSK7Jz6W8ieO6E/0/kaeayiqVcNhhO5rxQ4ZsFTPUsp5HwryrcIABWhVUps/ZgI8B7HypIulq6lbyCBDMo4uoXGGuCpB+SmTzCECtC5a8CZinm49N/NYpaCfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJVezJ77ydBJ4TkItLqKeq0MkSSzhZw6wan7ur+Anik=;
 b=jsa2Gt4oGl1rolKUxxE2VWuVA2I/XNfppE0ylywBVHcHAJu0BKjUxUm8nrFaUjFCceygQZnEGooJuM3eFa2hiaJto8VH6pq6rncBrs2FgaHylMVSh4MoUlYPVLl8u5CVOlsrFlTZy2gM0H+Pc25EXEJElNBspRM37t8W5f5ZAccB6g4bJul+162dbgZD68iOb1oe0GyJzyPEfX5qDcfy8wOwRbpXdAYWgO3c3cprWyb/BV6KI8MuPjIifivzBui5OP2bsiQjeLvhWXiXnber7f2KSiJyuOXTU4y50V8yzUNluBNZm5wgmlemljyxPi9a5iUpzVU9ayfd+AndXR4h9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJVezJ77ydBJ4TkItLqKeq0MkSSzhZw6wan7ur+Anik=;
 b=NQNKhlMrkr0JZUbUtx2jnuh4l54mo4ULroKvG1vVETBOFiE0/K7D6OkXindwc62M8MX7/N0F+uWx1UwBhP0OkdJC+NbgrMUIiKAgzQv7aUNxvsIRsFo2CtNN7TW3UrKYdVBzng8Yc1TgwlFgNXG+PwG37FTzkGGVtkEATKKCMFg=
Received: from BLAPR03CA0056.namprd03.prod.outlook.com (2603:10b6:208:32d::31)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 14:51:34 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::84) by BLAPR03CA0056.outlook.office365.com
 (2603:10b6:208:32d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 14:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 14:51:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 09:51:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 07:51:33 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 09:51:32 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Enable RAS feature by default for APU
Date: Thu, 19 Oct 2023 22:51:30 +0800
Message-ID: <20231019145130.3314590-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 6817306c-0d8f-4255-78ab-08dbd0b2e333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaLWcXgQGfL00M2w2wIxKE+38qBgxRYwjGU2UF3FBzrjatsoF4IhzfoNl8su3Gtb6Iv8f/J39pwE8A6cKK54qZCoyfXEz1LvW8raUpUhAq2MzoqGhfJpIDo2Mz8dYhuuQSN3YdwJg2iE9c4JNA9VapBkr5f0RNYQedQcakpoPY0iqRtqn1snRvHpJu3nYPO1WNStbMiYZcHxoAXWld3uF6OAUmetWceCGXGC1JHrn2MZvvnmRdRuuIBZZEA5R7BjUDZDUshW+shpd+6DVmhWfGvAjta3+osNH2ZeZs+SsCBlyWXKSgVZa4XAa/4m6g9BWepUUMc0Wt4jkRk/iUsdkkqlHaLtnhxSPTh4IqvDrFOXv9ilmyNqXDRVi48rIl3WySjDUShfQTZ9OjCH4Dxfk7CCp3KPJiE/xPqp/urueZaCXb5nRYe5RfHIiTnlRLDa7FwD/rnQgMPgvKwgFKgurVS17fLBormanagtcdNnP6qqsNsXCT3dCubYZRwtaEJZ7kJWhwEWatIta4ITRopok4XRTsfXaevWVzg6THb8mJcX/LSVa582jaDxFfKnhQanPHPzsAih4NQNPOq5jq2G+0mEccEGgEMgWTHf++I25IHIEgZR/iFD71jQruB7uKm7CtBrM4h9UuwJhRqp/EX5G5xJqeH1XhxPsm/q4FK/IuXPC7gTE4PF3AdEo3SBhf8ztr7pxLrNRsi+CGyqTRNk/tvCM3mgqB2rWug0ekXFHf5/et81LMvegt7zgwkbqKvl8DGbbKWEpbcO+RXtgmNb1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(8936002)(82740400003)(356005)(40460700003)(26005)(336012)(426003)(1076003)(2616005)(81166007)(478600001)(5660300002)(41300700001)(8676002)(86362001)(4326008)(2906002)(70206006)(316002)(6916009)(36756003)(70586007)(7696005)(36860700001)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:51:33.7145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6817306c-0d8f-4255-78ab-08dbd0b2e333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable RAS feature by default for aqua vanjaram on apu
platform.

Change-Id: I02105d07d169d1356251c994249a134ca5dd2a7a
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 01c2e8e8fb69..3dc82a213e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2640,18 +2640,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	/* hw_supported needs to be aligned with RAS block mask. */
 	adev->ras_hw_enabled &= AMDGPU_RAS_BLOCK_MASK;
 
-
-	/*
-	 * Disable ras feature for aqua vanjaram
-	 * by default on apu platform.
-	 */
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) &&
-	    adev->gmc.is_app_apu)
-		adev->ras_enabled = amdgpu_ras_enable != 1 ? 0 :
-			adev->ras_hw_enabled & amdgpu_ras_mask;
-	else
-		adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
-			adev->ras_hw_enabled & amdgpu_ras_mask;
+	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
+		adev->ras_hw_enabled & amdgpu_ras_mask;
 }
 
 static void amdgpu_ras_counte_dw(struct work_struct *work)
-- 
2.25.1

