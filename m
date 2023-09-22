Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7EACE7A81
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 20:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6168D10E107;
	Fri, 22 Sep 2023 20:13:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5654D10E107
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 20:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSverPEUCnWsDEbSgpWykfRgsN5yCENQPbZSuKaak83Yf23qM+yaA7jTr7K/u+Trq+IyjymTSlSLPHxWBS1Xtadc90A6FN5uHEDDQ+hYtBCHTZOhHDBjfKn8FoXI5dLGVV/sUw1SQW+ItEGwgL8MonUzToJoQN0UGqnjfP7NxzFMwB7UxrAHpVe3OM+oTTKrlaP8njyO4Tw2XaiRdZ3YYZLdhy8+Mvs/uN6hZxdw6ncGd1W8fnI1zB3w2vJ43Piucj2TZKnNIlcpGrpRkJ5QehITiPTeJ4YA1Kc/oIzmIEhnu3Y/15CPSdAQ8CGzfspiRHrURFHfNMjus//EvQWtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMKg+tCoFqMOvH/2o+lTVGoP16WAUvMIi04sLSRNT1M=;
 b=aSir9+TpY6f/+rWqmIzAAfkkcZWjMgknyulWUyW6C4GbahJpq/a5vPlRxWNvM2Mwc85/fV4VPIddH7axIPPs1pg3/gfJB9NzAt9pg4lPm+qzLc1Tbio9gJ/L/E6hs8IlCFXRxc5WDI/Zmh5VFqtkc52w4o3mFPbF6yBlMbYMpWlYrKsBlUqwXqayYvrl8hhcBOgQwczumcCiH4s33lsjG5hjFPX9EFOQpbVS1cbDA/7Uagmz/dxsG8mlXRuiWUy4PTPu5PsRvq1ZINkaXNvXctoej2ozaDP7YBdXWOLqnfc5SMyNnqMDVSMZnWiuUJXNiueLeflDFJTnjJt9CAIwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMKg+tCoFqMOvH/2o+lTVGoP16WAUvMIi04sLSRNT1M=;
 b=CVEWjGBG3Adk43/Aq4nFk6H46rSZaxRtxIPSGUK7RcBVJRD5sVVJ2RpwkFzxKUzpoTp48X57XpFX6Kvf8Ul/2ba6ItVU726vjbQS21NQ4zYYL1j35xsvpYLZ5mH4bW1F9ZW0bV3oUdFq0h+BG15h3EqbsWqUjmya5hQd7Drmmu4=
Received: from CH2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610::22) by
 PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Fri, 22 Sep 2023 20:12:59 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::b) by CH2PR05CA0009.outlook.office365.com
 (2603:10b6:610::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11 via Frontend
 Transport; Fri, 22 Sep 2023 20:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 22 Sep 2023 20:12:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 15:12:56 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Propagate failures in dc_set_power_state()
Date: Fri, 22 Sep 2023 15:12:43 -0500
Message-ID: <20230922201243.104935-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 963fc3e2-7749-45fd-b378-08dbbba850a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wshUYy5eHNaadz5ay3Gy7ibVtHn28jsI9awHNNq5ASG0ZdIDSDbVebS1/5mtXMcrtv68fK2t5IuGR+QIgCd6hO9TXyADN4b9A6gNMydYGaIcwoAitmvgoXWs36c+tBNrCkhDJJLkVCSif1/5Dmuq70wazHqFb8jtZM4WkCE+xui36ca79dswH2BgXIO9zw97aVdBzF6OTCkJBnICELxwfPEjz3WhUi7SI0MAwvtTsdsK6DzU1Ns1pmD6hBcRfwMoDbnLU3EaX+xUA0g/rt34jJ5FtRYzFRSP0Bm9ay3yolY/QLQwLYM050wOtNOfFJaN1TSUr+BdihQ58jIX7veMUW5eqyiF+PskjbZiodjFSHLpuhdP0BCKn7VcYS1IxeaxaAR1KHlN58uorseFgywBXFtLw0KrntpNmfnYS2sWlNDLOfZGQ9etNP1/hdDWnexpeg1txOvfgtfLQiGd7GiA0gOzXf8dvRBXCH6Gh+cxDObK1znqPt1XFThfUjcMMXL/27SZYdRd/LzHwMKPwKPnAajQRBK0B1b52oyWOPd0uPeeYZlFYUMELUGAMMeVLxCwl/QPmMB/l63K6OZdWWV2jxNwqbSqLPYT3rLzPAJc9OJPr7SE8H/DPm364IoAL8iuFehr/qJn8G7AkNSawGhoDiPaIBPTv/SsSYbvBqeuXhiqEWnYL+pxYycHTfUIEgPTPs7tBNQz2p6DORMXQrweruS6iGQOTRj7lS9HiacpOELAOgZtGlrwQHE4faEnJgqIzyxTy9KTKaChBvixPNbZqp/2cvKFKlOONIWZLAcyyaE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(82310400011)(230921699003)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(7696005)(6666004)(26005)(1076003)(47076005)(6916009)(2906002)(478600001)(336012)(83380400001)(966005)(16526019)(5660300002)(426003)(41300700001)(316002)(70586007)(8936002)(54906003)(8676002)(44832011)(40460700003)(70206006)(4326008)(81166007)(2616005)(356005)(82740400003)(36860700001)(86362001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 20:12:58.3950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963fc3e2-7749-45fd-b378-08dbbba850a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During the suspend process dc_set_power_state() will use kzalloc
to allocate memory, but this potentially fails with memory pressure.
If it fails, the suspend should be aborted.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Harry.Wentland@amd.com
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c          |  8 +++++---
 drivers/gpu/drm/amd/display/dc/dc.h               |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 373884ca38b9..2acb555343ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2670,9 +2670,7 @@ static int dm_suspend(void *handle)
 
 	hpd_rx_irq_work_suspend(dm);
 
-	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
-
-	return 0;
+	return dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 }
 
 struct amdgpu_dm_connector *
@@ -2865,7 +2863,10 @@ static int dm_resume(void *handle)
 		if (r)
 			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
 
-		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
+		r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
+		if (r)
+			return r;
+
 		dc_resume(dm->dc);
 
 		amdgpu_dm_irq_resume_early(adev);
@@ -2914,7 +2915,9 @@ static int dm_resume(void *handle)
 	}
 
 	/* power on hardware */
-	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
+	r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
+	if (r)
+		return r;
 
 	/* program HPD filter */
 	dc_resume(dm->dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 293489c41086..a1593d550526 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4711,7 +4711,7 @@ void dc_power_down_on_boot(struct dc *dc)
 		dc->hwss.power_down_on_boot(dc);
 }
 
-void dc_set_power_state(
+int dc_set_power_state(
 	struct dc *dc,
 	enum dc_acpi_cm_power_state power_state)
 {
@@ -4719,7 +4719,7 @@ void dc_set_power_state(
 	struct display_mode_lib *dml;
 
 	if (!dc->current_state)
-		return;
+		return 0;
 
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
@@ -4746,7 +4746,7 @@ void dc_set_power_state(
 
 		ASSERT(dml);
 		if (!dml)
-			return;
+			return -ENOMEM;
 
 		/* Preserve refcount */
 		refcount = dc->current_state->refcount;
@@ -4764,6 +4764,8 @@ void dc_set_power_state(
 
 		break;
 	}
+
+	return 0;
 }
 
 void dc_resume(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index faf897ac75d8..82013ebcba91 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2329,7 +2329,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 
 /* Power Interfaces */
 
-void dc_set_power_state(
+int dc_set_power_state(
 		struct dc *dc,
 		enum dc_acpi_cm_power_state power_state);
 void dc_resume(struct dc *dc);
-- 
2.34.1

