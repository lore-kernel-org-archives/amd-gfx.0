Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A18E81E1F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 18:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC3010E55E;
	Fri,  6 Oct 2023 18:51:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDC110E560
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 18:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DniQrS9sTHZEvAOyUwCHSbzW2LGjfIXW8knlf5ERxFd+CeXuzA6uHhKsaom0tQxzhAen1TbVHqY4fdzW+uN+iCQU8HzJDvaJYNkXkmwUdzDXjT+R57RFZLbOSfwI3iSjb1aoOYNzcRUpi0FA7GpbocSB4tmoIGycQWgRaJlgdu1XvV2YY+/LoytkFVoWMvP7DZeZUuelwXpvJFrstodZ5DSenAH+fc/gPJsx8BeNLRFIWZqxY0KXG9mGrkbj9kFoZU0xCoj8VFJSs9QCdePY3t5RaXhBQmuRq6+K/qQDhFvbh4NvokmPT/ufohnmzfi/0UYa57N7m6T2o5hyISen+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUn4e79S9M+I9I0kNIc8JCWAicmJB7HsKen4133jZzo=;
 b=IU9o3ICozDinidWaf0sPSAWY7o66irUwijyySe3vzfSq0m1jnAknio7HMUY/5MV5OXW8D/zBARioESdQzkeWzvqdFpAEXuJfGAzO4JouGRzRCnZ6LDa9sjAeGKBOQm2CKdk3Z+v4GyM2yGyM/JtuaM1c8Y3XIXE+1Xw4zLhaQeJRoeZxDiXDRSau0tsrpXV682ak6LTIHfJ91TnoReqIww1OMfVYkOcReXXB6JqpugWwlrs/u6M7LbuoZPP/vP0DCuwBgpafJCH+/PSfDW9HAB4F7Q6N03wcRCvKGr3zRuiAPn7zbvbjyuWtGjGs3mbLfQVWzDi84aCn5XLx2xkNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUn4e79S9M+I9I0kNIc8JCWAicmJB7HsKen4133jZzo=;
 b=rNW/SvnEFOpSFLMqkBJH4WBhMgSW9iWCuTdGLsbnX/voQGcZcRWxMw7+3PZ1+BtAM34EvkyTIeoWg8cJFzivck3WVXc1eOOGtNVe3zUSzu5RenMUNoeniXN14kWqIRihT7T9hhvh4pL5RfmyH1qSoorfIzujn7pEDLP+4/X6l8E=
Received: from BL1PR13CA0260.namprd13.prod.outlook.com (2603:10b6:208:2ba::25)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 18:51:24 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::3) by BL1PR13CA0260.outlook.office365.com
 (2603:10b6:208:2ba::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 18:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 18:51:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 13:51:22 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 7/7] drm/amd/display: make dc_set_power_state() return type
 `void` again
Date: Fri, 6 Oct 2023 13:50:26 -0500
Message-ID: <20231006185026.5536-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006185026.5536-1-mario.limonciello@amd.com>
References: <20231006185026.5536-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MW3PR12MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b33a64-7269-496c-3559-08dbc69d3d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IASCOYhaI9ewysn7Qv8b2Eog3I9yPHTwsV0pYiEOvsoSpOhuQMlWHTFxLZldG6roVJskIObXBsxYBjWZ6QybcATyV9FWWBlsb0phoZii0snXoBvTriQYnCuES/niLh1DTFw3Z4kW47wvovnR7KEySokeooUJ+Jb4ocjZg177a17yaq29zGxXBM6rqqSJPQfPwxBPUboh20qzpUs+pyFnN/rsF1lI9Wh/m+q/edPiqjBOwmu3hP8X+eWOX9B2mlqC7wKl3QKwga/pXnMMSDpiN9f+wVctGJWUNQiq96kpVz2skd6dttLy+p7uZS0tkCUYwSWVm8NEU+tmqd6etuRVwdtQ3QtKg9rcFb/in/xEHFihVrMFy0F8juQR9hFVez4+c+XCTRwmOa0ROmVZiUNM5QfEzclz+AtsiedQxk8lpLC1/ky8i2U2ogvTPc00iYr8/+dsxTeVJEj8qkfraO7mPKFivyWN/6d36w9XiRedG5O7PBPTW7G4cbkwmILtA5z79CvjCE4m87XsRW0IWppX+/dZwVODiX2Ikm4im0IcAOKwcWDEi2WCMU3XaKZ+ywXV6x36xRDI7Y6IKlUG/enq+ou075JOA4fhRxn+p3KblYQ20eVk798+JWcNXftms4aC2skwwvgHs5tCtjDqCYpnlvEo0UaIkcjxN0T/mQlHLXTHtrSWVOUecBVi64uWdjGceCh1hxePGxJ7uTxi4N70ag+kd8GlqEQ9By4G0wmhv9VhuF54b3J0ex8EVLOcL51Yz9r/dZV9L4eri4De/DZmhgZhnQLvtPOfe7/wUgzCdLY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(7696005)(478600001)(336012)(16526019)(426003)(2616005)(1076003)(26005)(2906002)(41300700001)(6916009)(5660300002)(54906003)(70586007)(70206006)(316002)(44832011)(8676002)(8936002)(4326008)(36756003)(36860700001)(47076005)(86362001)(356005)(82740400003)(81166007)(83380400001)(40480700001)(40460700003)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:51:23.8439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b33a64-7269-496c-3559-08dbc69d3d04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As dc_set_power_state() no longer allocates memory, it's not necessary
to have return types and check return code as it can't fail anymore.

Change it back to `void`.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Pick up tag
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++------------
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  6 ++----
 drivers/gpu/drm/amd/display/dc/dc.h             |  2 +-
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 63944d3b9e8c..a293edf1ee40 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2685,11 +2685,6 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 	}
 }
 
-static int dm_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
-{
-	return dc_set_power_state(dc, power_state) ? 0 : -ENOMEM;
-}
-
 static int dm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -2725,7 +2720,9 @@ static int dm_suspend(void *handle)
 
 	hpd_rx_irq_work_suspend(dm);
 
-	return dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+
+	return 0;
 }
 
 struct drm_connector *
@@ -2919,9 +2916,7 @@ static int dm_resume(void *handle)
 		if (r)
 			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
 
-		r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-		if (r)
-			return r;
+		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 		dc_resume(dm->dc);
 
@@ -2971,9 +2966,7 @@ static int dm_resume(void *handle)
 	}
 
 	/* power on hardware */
-	r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-	if (r)
-		return r;
+	 dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 	/* program HPD filter */
 	dc_resume(dm->dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 55e7b5a8ec8e..2e5e44f289a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4700,12 +4700,12 @@ void dc_power_down_on_boot(struct dc *dc)
 		dc->hwss.power_down_on_boot(dc);
 }
 
-bool dc_set_power_state(
+void dc_set_power_state(
 	struct dc *dc,
 	enum dc_acpi_cm_power_state power_state)
 {
 	if (!dc->current_state)
-		return true;
+		return;
 
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
@@ -4728,8 +4728,6 @@ bool dc_set_power_state(
 
 		break;
 	}
-
-	return true;
 }
 
 void dc_resume(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 885f272a54c1..59f429064da2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2340,7 +2340,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 
 /* Power Interfaces */
 
-bool dc_set_power_state(
+void dc_set_power_state(
 		struct dc *dc,
 		enum dc_acpi_cm_power_state power_state);
 void dc_resume(struct dc *dc);
-- 
2.34.1

