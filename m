Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7A9E7C4EA
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 17:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB2B10E3AC;
	Wed,  4 Oct 2023 17:19:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1661910E3AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 17:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+Xn/eapef8Tw7FsppgwFuBzND+G9/0cqAJVh4SxQVzrY/wUh0PJ5m/KS0n3iYZB2fW68eiRGsb0N/c9P4w/upTE9OxQ3C6wHFl7uo4vjFGwV+XLwY6KLqRACO2ULz38kfRHazCxue4CAjRpyc/HqYjoUW+MHn5aQY0ZFPP4uZ2q32vfDKLbvqN6otvnY+jUqvI8aTvwuae5Vgo+cLkfOt8+jgFYIsoaxbU42GtUXFUVjpyTKZsex2AUDOEKxZsPbvFt/UvYFFkgvjrXIsqJankY63SLe3JBhv/JP7d5vY1FlGMXjIOAqisCAD0fLadVzf1oBdFG0LFHKZdKR5/1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0nMBNtAoweWJ+LcwfXr/YWQ9HoWHatRZknRCcP7ikU=;
 b=oCfY/xbI56Y/0ONBavIAYfu9e/0Ngm7Mqviza65tIzkN809ARt1+tbYux2xGd3Ewmh6Zt/aBsXEPnpqUauUVhQ+N4mcn1475rwJB/pDeW/oBSWnU/hg0NjTsg3fAzHV7QT0XSCP5AWhYIXK/wQ5y0qVxM4GUkq8LvOHrYGMABxt4O2bioe5yyr/Zs8T2tM7teymcwe89x8fCphi0S4RWXvItj/Q7KfxZjI0FjGppIHqPK+92B+88tL2oH/3DvDl6Qb2e9pTaqGQriHRTE6gflp7/poaxg/rw4OFhCPFcm0f2CFqpRNMJancyoFtd2Jc7RjbP+wW2DP1RwkKn87JH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0nMBNtAoweWJ+LcwfXr/YWQ9HoWHatRZknRCcP7ikU=;
 b=1vyOE3/rYfyiXVprYG6xrmc/gpL4GMzgJK6irDcjFbIXMcq3Ch49uDSrCf+TfxKYvBPuYU1I6F7vxzQJWwAX6VjtYhfB3jGZItosfD+ezCBTbVQCmzcgrE5yba6eqXaJK0FOYCWIobnn/qGIKuvie+CaFn7gjQCA39e0MQ7j1cw=
Received: from MW4PR03CA0166.namprd03.prod.outlook.com (2603:10b6:303:8d::21)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Wed, 4 Oct
 2023 17:19:02 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::a2) by MW4PR03CA0166.outlook.office365.com
 (2603:10b6:303:8d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Wed, 4 Oct 2023 17:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 17:19:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 12:18:59 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/3] drm/amd/display: make dc_set_power_state() return type
 `void` again
Date: Wed, 4 Oct 2023 12:18:38 -0500
Message-ID: <20231004171838.168215-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004171838.168215-1-mario.limonciello@amd.com>
References: <20231004171838.168215-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ddb6c0-5eba-4654-f4c5-08dbc4fe00df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8ApnSEcQB0oPnqcNuboIgte5sDF/g0wspuixtGp0bLmrOx0GS9L59gTdAPm3rplAK+ZiHONaZpIMDWTd9XxA9h/0dD1DeWRgzSRB6jAhilbQrtMJ5IwfoT8/jwlsK5A/voJpJTcDXcMj40aQX4FiBWAY6+i1J4luLDsuXeZovRcQVm2hxatH1FpUFZy4m/FF9MKy1Epvd/xkDpHpQiHGQeW4eSyjZYcXwbJyNXL9RRHz9Ckis+pB2dcz2b4PlbZe7JX30OekpUxqbb53gadkc9AKuUY38kJqfVh2e5vCdC0E4wqXBU/Tqq4+Tk5ALJ6r2CXrUTE2lm0Cvv3Wi5ZrLxGCbq/SP7skAmXw0e9xMB1yF+2NP0Xuwc9acaot9NMv+7ffXKZ46nrP54DBd86bUbhkQ4MeqLzUdGue69AKtt2AHDf+jOxjoJY8vOa+fgJ3jEV+wd1f1uq/AOw9B4AW++kFime07+qyEHvYSS+Qeq6bLEX+cVfcuSjXX6dtDZAGequXL78lU7iLQBBbmOfaZpSlBDoW733vgov/fQdZotOECFs0wbR0X/gCCKl2/svhjnp8Di1fdy24XolHdzqt8I5rUdUkHPX5wFdQl7XUsRMeO7qQVfKiERIG1p72kBORn1QgqXIu4SnMTBVr6RIoIH1Cp9r/LCSBInKEcK/r788dMlu9b1e9YeD3VGF1JV37ItqxSJ77Ld9FpI7rc18cCI7TV71c/kQ0Rg9pd/45mOjmN8M61sNGL9+BirgYFI4VTqgUKfI6uSYOQFDGnD+gCCBl4rpEU8Yn6QConSwTbI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(426003)(1076003)(6666004)(7696005)(5660300002)(40460700003)(44832011)(36756003)(83380400001)(16526019)(26005)(336012)(2906002)(36860700001)(86362001)(82740400003)(81166007)(47076005)(356005)(2616005)(40480700001)(4326008)(8936002)(54906003)(8676002)(316002)(41300700001)(478600001)(6916009)(70586007)(70206006)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:19:01.6752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ddb6c0-5eba-4654-f4c5-08dbc4fe00df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
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

As dc_set_power_state() no longer allocates memory, it's not necessary
to have return types and check return code as it can't fail anymore.

Change it back to `void`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++------------
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  6 ++----
 drivers/gpu/drm/amd/display/dc/dc.h             |  2 +-
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a59a11ae42db..df9d9437f149 100644
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
@@ -2723,7 +2718,9 @@ static int dm_suspend(void *handle)
 
 	hpd_rx_irq_work_suspend(dm);
 
-	return dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+
+	return 0;
 }
 
 struct drm_connector *
@@ -2917,9 +2914,7 @@ static int dm_resume(void *handle)
 		if (r)
 			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
 
-		r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-		if (r)
-			return r;
+		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 		dc_resume(dm->dc);
 
@@ -2969,9 +2964,7 @@ static int dm_resume(void *handle)
 	}
 
 	/* power on hardware */
-	r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-	if (r)
-		return r;
+	 dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 	/* program HPD filter */
 	dc_resume(dm->dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cb8c7c5a8807..2645d59dc58e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4724,12 +4724,12 @@ void dc_power_down_on_boot(struct dc *dc)
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
@@ -4752,8 +4752,6 @@ bool dc_set_power_state(
 
 		break;
 	}
-
-	return true;
 }
 
 void dc_resume(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b140eb240ad7..b6002b11a745 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2330,7 +2330,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 
 /* Power Interfaces */
 
-bool dc_set_power_state(
+void dc_set_power_state(
 		struct dc *dc,
 		enum dc_acpi_cm_power_state power_state);
 void dc_resume(struct dc *dc);
-- 
2.34.1

