Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F93BE95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D939010E106;
	Mon,  9 Oct 2023 15:55:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F54810E153
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LABDeNlzuxJSqa4HXM3juFU5B8japcY1FGjdH+tuDNMZK9EOpeUYnaQ6HyaRrqPO/OHyfEDbGigGxJ13sxsrIUdA3KzNpI/fiWCeyPeulLo92kBT8JgJhlpbtu3y4pXwf5dPpGS2xPllFfVWJ1A1GWqAgMb55Snq/DA3BqOzGYclPKwLbpN0OfNKTyxR6EEgW0/pJkwdv2HWsR7xp1FHlVUKVitrjt/7XdD8jHL9WkujiQ/VxB6GGZPi9y13WqiH9JtlFhjnQcPOexygY5mUka3T4cCPH02wcD9+Sbm4t3iETaiUdiLrBz2A8P2eIOkXpEimGw40I5MpLAcH6Rim+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnxhn1vt7fRMXI8c2lvRcvUNqQ7LhKhlPnNlxiLrt+w=;
 b=ImyupnZukQwKuEDLMbIUzOoh5GEXO29rVawJjSp83Iv1jECpJNJ9EaPFbxKSI/GFLG62Hp1mIUZJFziYLiYPyVj5fGOsR9zYHxRtU6rmPEw/Qm/gOUOBMTZ3YpZunwe+owi7Z3t1Qv1wxR8WIDSNEFwr6AJZWuJSeeejAoX0+/HlgEncLMloX+3BAqV+7zJWaZnAuNHgRYokIwD3xEGzzNvRxJFlMaqEnx3400Jd1Gbu6xYYIBZ4lsoJbDhkROWXSlueduoWqaXpGvu79frjFqti1DIwHuHQ8xqIcovcV78eOUH9rwFPA8vOdH9xRVX0hl5Gsw3WwFKz+gl/GnuPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnxhn1vt7fRMXI8c2lvRcvUNqQ7LhKhlPnNlxiLrt+w=;
 b=SJsImqWsCpTjnyynfpEN8122p6xttSxBcEZoIjHvUouiQL5640vUd/RtrdIHWEhimSkT6JtkxdOgFLsmQQbi14KH/pJvziW3Fibcw3YlJdxObMbHDCgEd9660ow8DLzOFNe9kvgzxyswtDjQfR4uitS1kYwVUzdSa3Ti9fU/JPU=
Received: from CH2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:610:50::36)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 15:55:04 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::16) by CH2PR16CA0026.outlook.office365.com
 (2603:10b6:610:50::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 15:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 15:55:03 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:54:58 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 7/7] drm/amd/display: make dc_set_power_state() return type
 `void` again
Date: Mon, 9 Oct 2023 10:54:26 -0500
Message-ID: <20231009155426.96232-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009155426.96232-1-mario.limonciello@amd.com>
References: <20231009155426.96232-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d35b088-8d30-447c-5081-08dbc8e01a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BR2M+AgPy4Jrt4ovzRRS8Kr1phMf5OD5EGcwjdF1/P7m299AUh0I9gSdHoNjpgAd3Bu7ZznCiAifIvWkeHp8jc89nCx2OaKeIR9deA7mpGLiSqcphUxNe5F5CGkfujqYqYworKfxT17i7MDFGoOPMjhnAJI6q2RNDXH24HagP+sZuYA8kd5ESWI2Khl9ItWiqasjQXWdoNSTWjAoLUn9AUWNx1V9DY0krymngP6UapjHLUK3JniPoEgK0XUdgPU8h1FWygxZH4TeixXt7fai2HBQASKL5L2hznUylccF2ibbhm87qf0UB27BjzDCtyU0kYMxuVB5aRSVWJhxm9PBishlc1br1y+UoSMJkSEK40vmlwmkvLFcEHWm7Fqw/VeBceIHSKy8LplzCAw8hCz8rusrXVd6BScO/g5el8NNdvSIx7DWfUpmjsKzYE533bdWWWy5rqHS8Yy8DxXuR13DDqg+A7B+mAewECWgs24KfelDunUA02fbfT1Dtx/TFOJ9Qko1ThXEi7SM3GfQkuquE31e0IuHHBYxI/yJXRh6R+fFlFeVbkcxEUuN0AAvHlrjDD4qhjMTerFuv2N0KTD3oQywgS4Seyf2bVFbtuW3bZSnak4IwanrWHQVF5j72jaZzwMyjX2A0JtAzkA238Uxrd+onyxhjjBYZAdmbBwq/e14xHJDgAdk/DXEL3nC9Vt1GQ+I3J2P59YzULPZzhTTX8mnbkrXX08TdcKQ8R/EiMhwLIAtZHPONcfXr/1ZvUkSlCezPY5J1sev1rbeUMcAbNsH0a8dnJAb+zsiOYvOuY4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(1076003)(336012)(26005)(16526019)(426003)(2616005)(36860700001)(7696005)(478600001)(6666004)(8676002)(47076005)(44832011)(83380400001)(4326008)(2906002)(54906003)(70206006)(70586007)(41300700001)(5660300002)(316002)(6916009)(8936002)(40460700003)(81166007)(356005)(36756003)(40480700001)(86362001)(82740400003)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:55:03.7484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d35b088-8d30-447c-5081-08dbc8e01a15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908
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
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As dc_set_power_state() no longer allocates memory, it's not necessary
to have return types and check return code as it can't fail anymore.

Change it back to `void`.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++------------
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  6 ++----
 drivers/gpu/drm/amd/display/dc/dc.h             |  2 +-
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97e21bbac5cf..df0af8d1eaba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2667,11 +2667,6 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
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
@@ -2707,7 +2702,9 @@ static int dm_suspend(void *handle)
 
 	hpd_rx_irq_work_suspend(dm);
 
-	return dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+
+	return 0;
 }
 
 struct drm_connector *
@@ -2901,9 +2898,7 @@ static int dm_resume(void *handle)
 		if (r)
 			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
 
-		r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-		if (r)
-			return r;
+		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 		dc_resume(dm->dc);
 
@@ -2953,9 +2948,7 @@ static int dm_resume(void *handle)
 	}
 
 	/* power on hardware */
-	r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-	if (r)
-		return r;
+	 dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 	/* program HPD filter */
 	dc_resume(dm->dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index fd35ab2ce3a4..f602ff0d4146 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4777,12 +4777,12 @@ void dc_power_down_on_boot(struct dc *dc)
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
@@ -4805,8 +4805,6 @@ bool dc_set_power_state(
 
 		break;
 	}
-
-	return true;
 }
 
 void dc_resume(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 42a18b363e00..f16912a8791d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2341,7 +2341,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 
 /* Power Interfaces */
 
-bool dc_set_power_state(
+void dc_set_power_state(
 		struct dc *dc,
 		enum dc_acpi_cm_power_state power_state);
 void dc_resume(struct dc *dc);
-- 
2.34.1

