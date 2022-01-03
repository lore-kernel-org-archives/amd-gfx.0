Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C4FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jan 2022 15:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1339F89A0E;
	Mon,  3 Jan 2022 15:24:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D70089A0E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jan 2022 15:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbQ9JttLELIJqiRGfsTSSlRBbQukU1cLVVAT7pDOmNvi9jv7sPtMq49ozzH4OWvEOIGXvVAErfblKBVmBNp5+OxC91VgWGsAo4kaueoHrBC7NT1j/jSOpwMH+y896wtxNcae6DLJETzegB84JYO9vRpAmLcqj+bRYyk4kzzUT2w2UKCsyw23Br0yYHM86MdH/3FpUYxEeqMCxK99P8ixoWs7u4RsiB3pvQFxRCsg1DwHcG90Me/e9ufRQJ+QpUK6FBKPieZsqNzcJGJlly0OzzkaUgQQBKaFL2tWx2sNKFoppz9J1TF1CorrBL1EktZM7m4qD4CbV61tIY2C77Ad8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oH5z1LtYVJmu2kmdCJ8FsZDpiba5moguoreJN5cOWvw=;
 b=MRDOd1g3kXoxss1VOee3J4U9dm1psukJz7mhKzSUOps7C9AMWxjbPVnr2YAwbm1GzRm+FGrn2uGMCmY3JqnwHWn3rEhAqwJKA8uK0LHbUKiucgjET3jTBRtwuzaPMIWTenMKZtW5M5Gx2pYQN7Av1rf9vINnB/XhVML0etPgZJdZ0kprlPTCZLq+HJ+voKZp8zGbXmpME1v3O7Y9VK23onGylYR7aiFBdDGDnOh4jwtfaMUezgM5iGEveJ9Kn115GrQAZk4+qgKg8sEMb5oud33101ctVf5dBm97buSOu+oO/VpHAzgDki9x0faXyGyAlvdUMMT8OSxgXSRR/fo+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH5z1LtYVJmu2kmdCJ8FsZDpiba5moguoreJN5cOWvw=;
 b=QVg07XgL/JTUfqLxnOSH4Gne+7fiHVIJab9RgWStLORB1QAEg6yNDGhYio+6dTBok97zIo7CGsdkgCKer86L+U9YiYgDn6noFq6IVlSHNMWoWr5tsBX0D1pEVSnLNPO1fj6poE9Wu7J2eR2NU0yOoBvLW3F8msala9mpOXMScrw=
Received: from MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::30)
 by DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 15:24:05 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::76) by MW4P221CA0025.outlook.office365.com
 (2603:10b6:303:8b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Mon, 3 Jan 2022 15:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Mon, 3 Jan 2022 15:24:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 3 Jan
 2022 09:24:04 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
Date: Mon, 3 Jan 2022 09:23:11 -0600
Message-ID: <20220103152311.1453-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103152311.1453-1-mario.limonciello@amd.com>
References: <20220103152311.1453-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5446025b-e7c0-4986-dd9b-08d9cecd1459
X-MS-TrafficTypeDiagnostic: DM6PR12MB4912:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4912B528B13010E911F407D4E2499@DM6PR12MB4912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kb+W0XsWDqLvsorOdDixiOCCEINcNrz15SKcUTGkmP1RqzB/4NPHmMBcHFTSqBttqLBQm6VW8GWeWRooX6TLnBwMbteq0ZW31aWnrmxaNo5Q7byEr4IojAUQAojVAgcahFDO+cXb48FDbV5mGbZ8utPdXRpRoayOm6OLBIe2QzCALM+3hz+YJVq9Me8QW1E8Y4GbskiB+IqK6iMr7KpYfyikZ57NYGDmJEkRPAIwEsDHA7bXMelO6ceBdFl6kiapa8tBV5df1pPJM0skfpcxjW+YgiPHXdpyBcgnf6fdotwcidcS9nuhh5+5CiENPjU/ApyW4hwcEi+T38cMnj8vDFmi2cd2ma0Vq9CbV9uPpM+VdyIV8XlOaOyH6tw5d7f9X13eC4TFO6MMxK3iA0mgO9DOeYVnZhnLxHEKnrvoeF+WgIZblDNt3g9xHsKhTEs5YqAonudUE59CvP3DyqYAYj++ZVyqYSRdbUxFt3N4tFOZPpTHgHnauRe6/VfruQ5Qd3dP16Sxj+wFF5sGZDCiZlhmhWsnjXeeUr6qWsikSwESDD36vMd7dAKjJeWuP6T2vBQQiUMjQfOSWCjuD3BFjiezd0Q2AfBx7NYaW0XNWdOL9NOv9mE1CNTYxzSfsLwhHU66HWJDfPSSxdDeFz/8AeouSThp9e2kO03GSzJ3HSrGSuK3H0nF0KcvtPcYGqOKCEyRTP2t/zuLFfjq/NrT27vKw/XzKrHxPQpToeEXGJl85sHjOqFj8fI/9RzpwvuSVnknuXdSRj7U0MkFfOGPKndSZRvzwdxLyzOIZTZkdiUBDRPHmmLfHn9qh4QECpGl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(86362001)(508600001)(1076003)(8936002)(7696005)(336012)(8676002)(47076005)(426003)(5660300002)(4744005)(83380400001)(44832011)(2906002)(356005)(81166007)(82310400004)(6916009)(316002)(2616005)(4326008)(36860700001)(70586007)(16526019)(186003)(40460700001)(26005)(6666004)(70206006)(36756003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 15:24:05.2968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5446025b-e7c0-4986-dd9b-08d9cecd1459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This makes it clearer which codepaths are in use specifically in
one state or the other.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index db2a9dfd5918..413fecc89e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2165,9 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev)
 
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
-	adev->in_s3 = true;
+	else
+		adev->in_s3 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_s3 = false;
 	if (r)
 		return r;
 	if (!adev->in_s0ix)
@@ -2188,6 +2188,8 @@ static int amdgpu_pmops_resume(struct device *dev)
 	r = amdgpu_device_resume(drm_dev, true);
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = false;
+	else
+		adev->in_s3 = false;
 	return r;
 }
 
-- 
2.25.1

