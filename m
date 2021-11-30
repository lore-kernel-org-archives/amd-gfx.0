Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC403C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 14:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319776E40F;
	Tue, 30 Nov 2021 14:53:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30EBE6E40F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 14:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDtrDAlfNrCT6jXV20rfs1pDn9u1Cs/k2m9H5ENt++3ErYtb3BAHvyYdr0pQ06yeZHfp61Lnx65Qxb7ewzHgQ33249OX0629lo7+WpAwfwdLUt0+978AMn+V3k/nMA4WjggEJijmMXE6x/1Ywo2is6AsqDI7iP6/B2hPVr8z0SZ4VnhMtYNaO9gN0+OrFIm7nI0Ln4jcvWWvGcETcwBddqDumo1jPVvR/Z0rh2QBZDb0RwYykvpXtdYWFsN2/UnUMMXpWVPKxzIuegv7lhIOJpNb1WDa45H4/vE1pE1ZLFW03qUQL1COMSVJJZx3oSyjrK3H0PN1y2YSsgp5CPIv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tp2LtSR04hkhu083CUui20F2/Um4ogyJIVWunDKnrM=;
 b=Hd5b42T4zfbgHFj3z3zHA9bRwUvOMddu/3OZx+Qbf4ZN6loefitv9zNA++vIdSJPZsjOqZ9rgAPbLSoAqpq4TH9TvSfdFyEcRrmni08njyJQLYRr4Zsz/I8+rU7tepOhdwWaf+XpOTrSFBHLaT7R1IEXOcLzs2/KDOX7jK1S776wwO9mrIklcEeA7093pOG1oMfH07ByeX1j0eBu9qdjT47NZi80A/zU0MC8P7qpLla8IcADik4IRhe+T0klemi490tG7qbnWA1CLD6DBXmAqxBPYwQfvKkSa5bK72fi1nFbKbjGyfP5MPswq2NI8rgE8FPA/M84Gcrus8d+Ziy8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tp2LtSR04hkhu083CUui20F2/Um4ogyJIVWunDKnrM=;
 b=xUeB6WNooNPaEhSZCvs2zliEvs/M6U58NwLTVH3T/DyQtpInGIvfVHrC0hvXzKFxZVZyvR6GEoBRwR2l7v8PV+vL4xw/4a39DOmJr7vZ0mcRBEbNCu7rK3Avcq+4hDyh6J3iXmTLcPwlbAQva5992jIzCUjqRF21RgDq9hqaevE=
Received: from MWHPR15CA0028.namprd15.prod.outlook.com (2603:10b6:300:ad::14)
 by BYAPR12MB3061.namprd12.prod.outlook.com (2603:10b6:a03:a8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 30 Nov
 2021 14:53:38 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::f5) by MWHPR15CA0028.outlook.office365.com
 (2603:10b6:300:ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Tue, 30 Nov 2021 14:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 14:53:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 08:53:36 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 08:53:36 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 30 Nov 2021 08:53:35 -0600
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: Only set vblank_disable_immediate when
 PSR is not enabled
Date: Tue, 30 Nov 2021 09:53:33 -0500
Message-ID: <20211130145333.38917-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f05fe3-1cb5-4c1f-443c-08d9b41130e1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3061:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30616C5342239136B8EC5E00EC679@BYAPR12MB3061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3iQCm0L8+nPMsceoshzkk6Z/JYiGC/JxH0mFVGmdAPi7PcU+N+oav1Td/bClCQJPxOq2yB4d6jmkaw2tjjP7X4mIoj2FaTSNx5xBOtTIV9PyY/a/LAFu2EOnl8kf+a+LyI1DhvHci6QSrQonw0HfxiBRoUbxXqT3dXg/qjUX+yjNVdg7cYFWQEst1PrcweP2fcGc7mHlgk22X/uQygkloWJm7xJlHIWnLYRrbBJw6fIYwNBi+9L6Q8GjvS3DTDkp+DT9aZ1ZL/upfiLp5/SnKtG0mni2EI588y2npwbTYkRG52HngTB++R7Iq0mWaDa9n7UAG6GqcyAeUAkWh5Hqg15FuVr9mPwjvQdZnCNCBeUAOCv5sfl+p3SjfWuRJOs1qVIfAyNd6Lt3brpzLc9j4icF9G/vpgqbxK0KsXs3AdFTvIrfhzaeGdAjvwfz+ls8t1/OV/CoDTjkcFxCqHJKJ7tRgk64qpVLlx8+FJM8z1ZMME9i++8fGPKRFpzaFRp9zUjuuNVWUqGPanLAgtkvwEvr2meur6D8nGGpvL5vxyWjKyIfhYdoG/A8DyNO0nn4Xz85s0g7DE7bqIB8ihkjHZBy0OGBubRXbxEnSf4bjE9n1nc6i9npfiq7abPrIkQbwuI0owFWvB5zQC/2tdEn5dKR5Rm4G3O1mTZI4q/VBXUlBvawgA7M4c4W0yA//klOUd0IKQRp2uyi3GoU74SWCn7DNwHnVGxBK3D9Q/1QiZbMADp8G7GxKdlWvc9JsRf3b/l//xevcuCmIPuOEJn+zKIYIAaNmw21mYTTXpJxdvq4atAYxD9unK+iSXs2cVSHBkrJ9ho17yS1edDlzCwDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(356005)(6916009)(40460700001)(36756003)(82310400004)(54906003)(70586007)(316002)(70206006)(2906002)(36860700001)(5660300002)(47076005)(86362001)(26005)(81166007)(508600001)(1076003)(2616005)(186003)(426003)(83380400001)(44832011)(4326008)(8936002)(336012)(8676002)(14773001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:53:37.5380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f05fe3-1cb5-4c1f-443c-08d9b41130e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3061
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
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
PSR currently relies on the kernel's delayed vblank on/off mechanism
as an implicit bufferring mechanism to prevent excessive entry/exit.

Without this delay the user experience is impacted since it can take
a few frames to enter/exit.

[How]
Only allow vblank disable immediate for DC when psr is not supported.

Leave a TODO indicating that this support should be extended in the
future to delay independent of the vblank interrupt.

Fixes: 3d1508b73ff1 ("drm/amdgpu/display: set vblank_disable_immediate for DC")

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0747dc7922c2..d582d44c02ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1599,9 +1599,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev_to_drm(adev)->mode_config.cursor_width = adev->dm.dc->caps.max_cursor_size;
 	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
 
-	/* Disable vblank IRQs aggressively for power-saving */
-	adev_to_drm(adev)->vblank_disable_immediate = true;
-
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
 		DRM_ERROR(
 		"amdgpu: failed to initialize sw for display support.\n");
@@ -4264,6 +4261,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	}
 
+	/*
+	 * Disable vblank IRQs aggressively for power-saving.
+	 *
+	 * TODO: Fix vblank control helpers to delay PSR entry to allow this when PSR
+	 * is also supported.
+	 */
+	adev_to_drm(adev)->vblank_disable_immediate = !psr_feature_enabled;
+
 	/* Software is initialized. Now we can register interrupt handlers. */
 	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
-- 
2.25.1

