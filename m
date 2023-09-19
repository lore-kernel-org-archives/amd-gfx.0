Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944A8CD5BCA
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 14:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A2710E292;
	Tue, 19 Sep 2023 14:38:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E3910E292
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 14:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muE37bY7YuWnwgC6yPc83ifUffq3X21SXb1f6jCo+8Mk3ikOcakS8+c522/9BGt6jr68iFhZf0RHtPK1IZkLSXAAVw9XNNgaTstsn3o5haqdOsitqCrbABwd7THfRadiYJeuitrLs6WvoDcJkMHbXgFx8bEwKFMVnzmJG/sncBpsMc8oPiDp8lSerQGVte8MWEnMn6aoVcKOnKVWVT5DOvv21pchga/W6qcUCtut8rrZXLqZq+4yN4qBVPHGElX3BqwM6isRctUzuKli0tMZWeZPaHDZOCqsVI4MmOJgBNSA2ESu6C9y7WXSRrPGPQpdchRKLKZcuZWzjTWF1y0BCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Kq02OAmBZIKO294pnQTE2v0Wgoy3v7BdnuzK4p6jUg=;
 b=OXPQvwtS5IGOxV370UF+HUcw+iqVQ9NVoO+19NqP6PBszBp9INOy/oqjgyhL7pAXSQmlwsSpRGUctH/Os7fZP2lTZobHe+gDHhc0tl+BA6vFm8/gxXu8XPMC0yD/W3fMYPvDrHdDBjS/bLwRoezTgFcA30aq1hRWMz9qe1DyzCVv2qNM99vFMcLB+mMtnHkpIfZ9nx+wnvA195NJqEUfRXNP6MCaINajVat5d9BNcbt8PX+mA3JOybgiTEpeFrzEwbIh2LUoKdSerx5ipA6S5Zrdrh4haOrDQN25yBZv4mXxKvckwuc6GD9tY0nu5+ROSN6aCLezFTdZlCEcYsSjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Kq02OAmBZIKO294pnQTE2v0Wgoy3v7BdnuzK4p6jUg=;
 b=kx5XKlbeUPqVAM4OfTJ3WKGcttMcgj4peNXp2i2nRcKOq3uwreNcaUEfga14agbrK1UV1p6Dj2EWjP64sCs2h7nSM4Dhmnqpn60vwRe/CPfmdBGMT8VxdsauqdN3VJ2Ge9v7DouWvt30neqQtQ3FfF1fRYv8WUd5e+5nVfidhlk=
Received: from MN2PR05CA0032.namprd05.prod.outlook.com (2603:10b6:208:c0::45)
 by BL0PR12MB4929.namprd12.prod.outlook.com (2603:10b6:208:1c4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 14:38:17 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:c0:cafe::ec) by MN2PR05CA0032.outlook.office365.com
 (2603:10b6:208:c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 14:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 14:38:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 09:38:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc11: disable AGP on GC 11.5
Date: Tue, 19 Sep 2023 10:37:34 -0400
Message-ID: <20230919143734.2618529-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|BL0PR12MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aba0004-6fbb-4742-fffc-08dbb91e1039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUkKSIeOaH+auxwua2VyFTdWIDxeZRonqNn+NXFc72ZgKsNFUBz+VsPOiiPK5vcrfkuNVeIgSlFHm9hNKvzU/OkzN9kQTg25Eo5aGPi+2DOavLWPNYJ93jIysS0m1rFqL5DUdIR1sTfmUo/KTAy0XNnVsHLU7dCNz2OYpxmJSoG3KkwU8vmYvJycDIJn0LqVPSTwQO9Yy7XK2ZG7bjmdnVkjmys4nnSXQrJFZ4WrO0pbD/EBeG5W+eBtuT6luJ/CaTrIwdQZjFHSlyyO7uLP3lnTyoVZV+x9fNNuynUI7h6tncWCtp7+MTs6Uivjgo8xIQ1UwZJv7VUCGjdufNTmkWdIV/Mu4avbp3t8zfHKzwQfWgLAQfhn5LUzl396VTlkwQp1wpOwHLoRIacDh2NphlT8iAIQgqtVNpAL/ZErjzxLh1vUNo7lclzJYiIEVruhytb7iy/o/q6LcKIAc9hXP/qi8V82a0MXn5qOzeiPoWbizud8qIBW4iBDOrIMeLUUVn/rVK+N1atQZ2tHU3rQUuyFYdjZtB5mLVHdHUXWyKx6pT/jp+1ilXkCPqM1c6EaxAbgnCVh97GXwukqgKxp3Cal+X+lJkYfW0drGXzqqEagYZbYsjT9F3Gqofv7NOTsKKZdTbLTrxuXBkyqrRRsUbPI/JDTvsVLelMndBveHqKxqXiqeS3j9rKvAh/5KWH+OY1ziFvdaDS07BsntFF7S3iSu6YbSoCVqptjXLMfH3FJAIHdpnjk0SqMo2I65y/zycfPAN/4P6MoBG8w1by0EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(70586007)(70206006)(40480700001)(6916009)(316002)(478600001)(6666004)(81166007)(40460700003)(2906002)(4744005)(86362001)(36756003)(41300700001)(5660300002)(4326008)(8676002)(8936002)(47076005)(2616005)(16526019)(26005)(336012)(426003)(1076003)(83380400001)(7696005)(356005)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 14:38:17.4982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aba0004-6fbb-4742-fffc-08dbb91e1039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4929
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

AGP aperture is deprecated and no longer functional.

v2: fix typo (Alex)
v3: just skip the agp setup call

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 69f65e9c4f93..01cff4a3d4b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -689,7 +689,8 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc);
-	amdgpu_gmc_agp_location(adev, mc);
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0))
+		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
 	if (amdgpu_sriov_vf(adev))
-- 
2.41.0

