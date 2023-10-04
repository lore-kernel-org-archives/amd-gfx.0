Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B0FE776F4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B2C10E354;
	Wed,  4 Oct 2023 09:23:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A4C10E34E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiDk2Tg/EK/YyxhBfGqtUfDfGrVPRSFOwnR3pQubgANlHJOdgcuUfQviKTOjet+LyZUEYDxAWoTF9wOBh7IJv0YtT+LwLli+k2Erw3jzMN/1SCqoC3z4a9YLPAGJ/flgR4VCudSgtN5vHxOtawMQ5zw60fWJM/sutuTMCy1cwXNVaeM+MZWeudrYKCDcdGsM8UKETIYKDun2jr2Djk6+5hN6myNbCPUz9SHY4CRkNrCuWm/rTtrAirTZQ4ppb5eIAgvetEJAXe4VdCEGC6LKx125Krlweywo9FIeLNnJpyELwANC/GHK0F/EMCsYX11KXcilaIppnXt5DtQ6/WYTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUNcUqRKJaYey5pOe+NUFKL+9V8XE1daMVGzNi6UOQo=;
 b=dnizlox0dJm5rEfRWxybdOk/aJlPy4pLgQUvHHwd0NYQBwj6WiVABR7Zue6e0b0pvOoT65BiaBQmEyE91IZVoczup7a5sDSa1v0DefJuVeEbSwcIXbJ5OJfc7JlkBasSoJq+7gGFsRAQj6eynDr4xxad9BTRfEAouYbJwOZ9xSpBUzNxNvJejPlWSUgU96JmsFr/4Jesgu0hf6m1zfmjKJKOcaFqIVFvORTzDF49cCPLRlhBLxs8jLsLnMOYqCjCIkCH9mwSJm0Ib2cZFh5ADLWxqx3hy+SjxppqlAihxIQYrGFUtKF9XkNyQZ+k71TzgjfF5ZPMngQ43fk7rxCeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUNcUqRKJaYey5pOe+NUFKL+9V8XE1daMVGzNi6UOQo=;
 b=fmmeFFLSy2xnsEUZV00c9wvUFS9fEDuP7nsZ56PTaKQl55a4bRA4Rel2sJaQ9/Spa4FZMmMqJmjw/SxJKn3DG5VdDH6XtjAdDfuF2ecbb8LmPEuNwDrR6FepTxfEcprzEUKKBhGqqsot2Q94CI21LQWtOI6mF8jHI1Tvx3y6FYo=
Received: from BLAPR03CA0165.namprd03.prod.outlook.com (2603:10b6:208:32f::9)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 09:23:47 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::63) by BLAPR03CA0165.outlook.office365.com
 (2603:10b6:208:32f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 09:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:23:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:23:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:23:45 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:23:40 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: Modify Vmin default value
Date: Wed, 4 Oct 2023 17:22:49 +0800
Message-ID: <20231004092301.2371458-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c74abd-18bc-4ef6-00fa-08dbc4bb9ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RijHv/NCE04UqemJclMloN+agwQjXzjMlTJr2G77irMcHhqYzwaiV09LsmEObWtxNgXT+cghcNvhmJ1Pl0UN57NF4j+kIe6cwerabn7Q0sA6Gv/rrKAH59qVDMkQnTRhNgCOcwMab7FHdVqRwmB9HuBvwBnUSbnqTW5WeuFGpW3vfvAWrMniyfkIWaFC9qGXaELIbh1ITUy9mIzBnqMztIbpGBLcojXfaHxTygMY5/7y+5EdAaU/PIHITz4m8aelvp/PTZ0f5RyHCr065hAa54JWZJh3aYlgAmuTNccb7upVCRtwyNkegxqlMUcGUcI31UiqfwlQEkVQum1qV2kZQIjyf8wU41sHUgKkNFl4YHHlYzcpUmnjs3ZXvzKcOQmcfD4LisMLw0pBpxM3WXKJ8hrGfs4xLtmUdZZTTrPHeCZLCJPr/6nfQbqJuONMZLh63gFlL6kQ2iEvvnaHqIPXZ+2j8lPEG94ZFLvPtqmUp/HhWNxk5QiR3QglZMXJwgRdlZM+Qk268mnGm6nOdeKHXyzei1uWC02Lx0Qx4zBx3zFLOTCi4g/KJy88kOBcmjjoZDxYj9y/b7/K+VrwJlWHrmjK14qC1IsAs+Clbqt/d9VZHQ23PX7AGMdeHfsbgNpRaOX4Y+yKHN8JXye3bFkWL/kl/ziU443H9iO18kU9rYcopNuDuS9L8yrLtNVaWddSve4lbYCULJQGuHvQLBn5v0oV44n94HxIhDtYoVMG+RpI18usnG1GFhjJQrRlr30cSOtmsQvAa17bA9iiS07SZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(36840700001)(46966006)(40470700004)(82740400003)(40480700001)(7696005)(356005)(26005)(40460700003)(336012)(426003)(81166007)(2616005)(5660300002)(8676002)(1076003)(8936002)(86362001)(2906002)(6916009)(41300700001)(316002)(36756003)(70206006)(70586007)(54906003)(4326008)(478600001)(83380400001)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:23:46.8223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c74abd-18bc-4ef6-00fa-08dbc4bb9ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Max Tseng <max.tseng@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Robin Chen <robin.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Max Tseng <max.tseng@amd.com>

Fine tune the Vmin clock value

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Max Tseng <max.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c   | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index d8fa229d78ce..64a2692fd4f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1914,7 +1914,7 @@ static bool dcn314_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
-	dc->caps.max_disp_clock_khz_at_vmin = 694000;
+	dc->caps.max_disp_clock_khz_at_vmin = 650000;
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 693c7ba4b34d..24b455f3ac3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -1831,7 +1831,13 @@ static bool dcn35_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
-	dc->caps.max_disp_clock_khz_at_vmin = 669154;
+	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
+	 * to provide some margin.
+	 * It's expected for furture ASIC to have equal or higher value, in order to
+	 * have determinstic power improvement from generate to genration.
+	 * (i.e., we should not expect new ASIC generation with lower vmin rate)
+	 */
+	dc->caps.max_disp_clock_khz_at_vmin = 650000;
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
-- 
2.25.1

