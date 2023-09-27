Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D52E82CBB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 18:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E1910E05E;
	Wed, 27 Sep 2023 18:13:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D08F10E58D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 18:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4BN/dXHCwH5rId2+WT2QeD9nBJD5D7qF6kqT62Lg1aLHn7uUMMBIUdZcDSTG6hBIiYt303PT1TR9vdZhMcBd61O2e1Z1yEaRoLLh8zQ8ZdAHvRacNu4GarObyVHY6+4iJ5AqRZwRv0L5RMrDz05rlAPL0v4bFK9G/RLsOG5T3i4Jhsy6i+kDig6ZoFWKce/XFgJUcuFBdgApQhrdc+RsCxL/OvBn6qgFL+qWGFs3KfR3i6vPUMfMLNg/XNcyTVy1/Lnw1umAlA3H1fTpcp6V2GO6mOaxMyXFiHlIxXAji7Xe7lQOlcIDn4bpyVOco3ap9tYyekxYnVj+KoH9wcbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxS9n4ZmNO3TThUVYbGyoPqOg3Jj+ow6kLX6KNPECe4=;
 b=BvluRrsCRU6HRHW1cRk9uRS7OFYY64lZQ86iooBJRdYbZTNmGvwKn99bFlJx8wC/lCSRkHCRNfUpd2zxUp7JlildiAVl5f7GonBGU2bMP3rRinAKLbp7z90RsP4VeVutdWwttrR5IN3+gv5sg4gOcU/OfoByO8C0V+LGl4tsGfKrrFSs7m8jNTfrK1Xfr1i96tDfp+icWueBpSxA/9VCMrIP4y8UmagWq+uXF9KJf85Nw61+IafEeyTvN0fmMI1p8k/AQcdjnJB65y51xVuFhskYcEIyGzgQ4xRVN16gGJNmWz0897nrKcqB5kZyNRcsmIuR6OJk938zsdIkxiQkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxS9n4ZmNO3TThUVYbGyoPqOg3Jj+ow6kLX6KNPECe4=;
 b=GwCvNOIN4pbLyCKreX5uRqj5T1A3mtsJ8qC/95df571u9vzUPwOEncXiYDbuJMUtrd8mUGtDcdkNfb/QUlcQtE8ht1207HHOp2DuyuHjNxFP8lSWN7vN+i37DdMqOeA4qSDzEmXhI2sEQ/9yU8PyzQVKc4JsmSgp0+XwsmPQ1kk=
Received: from DM6PR06CA0050.namprd06.prod.outlook.com (2603:10b6:5:54::27) by
 CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Wed, 27 Sep 2023 18:13:06 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::a0) by DM6PR06CA0050.outlook.office365.com
 (2603:10b6:5:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 18:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 18:13:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:13:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gmc11: set gart placement GC11
Date: Wed, 27 Sep 2023 14:12:51 -0400
Message-ID: <20230927181251.2364633-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927181251.2364633-1-alexander.deucher@amd.com>
References: <20230927181251.2364633-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f699a61-a5db-4be0-dad0-08dbbf8565a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVt1g+XyUCmwPbT8JyOni4JnTJIg5Kdhnj0DdOclpp7ufoaxpYfoDxFW7QZYhARa53ACyEU5VY+07MAkmGvVfAyPscPH4bA7RU4k/lh+GHUUCSfBn4ezL+PDWwMxGyIFbu1vZsD4Qad3brecd0ZP7CJF3R4nRnFMhUvz+oUOZAl860OWzRuoQy9e7dyqKFwjNEp1jpjl2fHsHO2dNVCvWciRvkgS4+J4GHGgGwpEoO2oIiPFI37jEg5vqvAdiloVI7IKAO7O8ZW76ZSF9KObPh8CNpqq2xqoz7f3MylbTshk3c2loHwRtEThCW5hodsaYN6gD3eXgwZXzrBn8HhY07BHTAXOKBT+LjiESZcB4lrDQ7riM8dXHBOsuNonXeydNYBhNGXDpcsUqw6jNNWrFI+mG4a4r0APmkYypTLrSgSVZfI91ZPhwr0jQ9l8ZVl4ycQjZbQIqqPNLnTO7GXdkcdfoPu75xrAinbyTiumQKK9HiItaFxC40oTL+p6ZX96BqmQfezwXYST7K6d3JVHk17oJhhrtslSMzkE4CuaKGoqUySoKKus3TQJbpG5Xjv9KxusCnq/F81zcjvLekkPUZBcHRppyxc9CLuq9rnHFdmTpNBfqPXR4cIK25nJXcKWdZ2iouXPeVNqNvHqdghxSaXmh0UWnVFrWldZOEo4450rO0l0cjeAyiDyNhTpghkXvWmLTK/mpkN2URnrhAVzWjxzndUW+osEmC4nOZtoHeGrLiRNmnhBeogSTaXZ5TAhBXMe0pz0k4SDwBD34uGDVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(1076003)(2616005)(7696005)(4326008)(8936002)(8676002)(336012)(426003)(478600001)(83380400001)(6666004)(16526019)(26005)(47076005)(316002)(40480700001)(6916009)(70206006)(70586007)(82740400003)(356005)(4744005)(36756003)(81166007)(86362001)(2906002)(41300700001)(36860700001)(40460700003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:13:05.8977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f699a61-a5db-4be0-dad0-08dbbf8565a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
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

Needed to avoid a hardware issue.

v2: force high for all GC11 parts for consistency (Alex)
v3: rebase

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index d611d2efce3b..07f50ca8d481 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -634,7 +634,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 	base = adev->mmhub.funcs->get_fb_location(adev);
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
-	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
+	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
 	if (!amdgpu_sriov_vf(adev) ||
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
 		amdgpu_gmc_agp_location(adev, mc);
-- 
2.41.0

