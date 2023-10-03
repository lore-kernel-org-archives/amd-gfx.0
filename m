Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92E0E8FDB3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 20:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41FDA10E319;
	Tue,  3 Oct 2023 20:57:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324C210E318
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 20:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7hmOU9w4rDQ9sojIWh+p6yYXHpPZ3mEYorCqfolQLgwuy5O/gAljv8JNxL9ddC6L4Er6G7UDhJwsyvDKykF2yYT8tZYpFa70yCShA3Crm3rhY5CvR52f27uRzk6foADk8k9xby/TYgrD+MWCw757HMhxuX6jEzmhjeyqM8VmmWqNgcEj6+MdO3QnWu2hpuLy0jTwDi4k0xLAOLXI0K5etPteTjyp95K6S4ryX3AP/o6wd3a4+fhUQ2vjb/HpAdb3iUjIh1qBa3+ZwIMAzQrwe1wktM3Hs5LTB+v0x1TxP0GKhHyowl9QeR3jt8+TUmx/oC5yaFHkOooB5NqS2kv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXUV74fz4G0myvVPYDmzpVyVtC1sLbYwOP/WkUvqDZg=;
 b=No7DPkXJEtWZ0af6K20nurtxTlVOvPIdx2Uz21HbuQb7SnH9E6FHFRHbA4Py4X7pT/QLtW74NQGqnxVaAwYKBFpj6Pusr+9U9bMz9EDCOYKGrSuXGW3fE4mZ8QuNcSHfh4vr49U6kD9N3P45GTIkqAcURzrKfM3wGkoawEVrn0J2C6STeBeFsG5K70RCZA+5BZnZRC0TdnKlRYybxhiV1qvpyBo8f/81fAv0CeplH85BRlKyCrlrPXMaZkoOrUWsVgu1dpFW8Jo3NoxPHjWLYuEaGCSEp9oC8YsP1aLrhFqPfsOjTTmQYwqyj2UPCN+C8c+7vBrctnm/xxf0+UJH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXUV74fz4G0myvVPYDmzpVyVtC1sLbYwOP/WkUvqDZg=;
 b=FUAmI0NWkBBK+yXyPgyJIYvo+eEep/cbeaaadRVfz29zi1igeVEJcMzia/JtHOQ35/D7qQpX8RB/G/SIt8IBF0TnagBiLnHW+E3eR9yx+snDK49Mt07eiNjyUW/t6vCVGyWZ/pwGuhtGUigj049qeGhE/B5D4+Qj7bnXVjHFWzw=
Received: from CYZPR12CA0024.namprd12.prod.outlook.com (2603:10b6:930:8b::23)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 3 Oct
 2023 20:57:32 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::48) by CYZPR12CA0024.outlook.office365.com
 (2603:10b6:930:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Tue, 3 Oct 2023 20:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 20:57:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 15:57:28 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/4] drm/amd/display: make dc_set_power_state() return type
 `void` again
Date: Tue, 3 Oct 2023 15:54:37 -0500
Message-ID: <20231003205437.123426-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003205437.123426-1-mario.limonciello@amd.com>
References: <20231003205437.123426-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 2241c3e4-df0d-4429-f547-08dbc4535ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uC3DM8l4Pg+gcyLEHEBlOpqBriWOrMoGgBhQg81ZZuqK918mDCwutQ2uZ4osNOa0mex8OycE5RiiKaShmVacmSy5M3N177wwcLfsNfsSxacD399/c016zH9YHgYo43aHIyGavn0/pDdIw6DokgcdKEWWnun5dV76g4GA8cHmy5SmxLlWlsCGrxPZ4bHO9IsiqL3UqJGs76UD+41oA/ZBvTHayymsRkIHY2Yj1MiSWpZeWBZqD0tqXgl89RRT2peHXGqnoU3uMjt6/+zcZiN2/RNmu+aD2h9EFnP08Nj51CVPSjJ7Ryfr79yq6zzoJ1mfDg625TFBVzy74ZAXdyzJp+pZpDJ8z0JPtuGhd8fIe7fUUqwjKpqKhtg5rc3/tqGOJqyjUrsI1UN1QO7LrfI8MUSnYVhG0E/b5skPMfGRc5QQFON2DdxwO59hoQOHlG5FNvvZybKhaMdoWoxjw5KqfbBlPiMFEZkHCR/YVx9/Vib5BRh5yKYaOCh2729MfI5zsgm5LvvD5eJOT/ZlPWLs6s3JjFRTAnhc2iCzMGueBHuHVYPLZOQL2teb0TXFPFXPmsPWpnCTYoi350Jczi4OmQE10AUPMp+JpHT7k0zJoP1/6A+adQx0QUsdwJzur3CMeZ9MqOKFah/sdBpK1buQ8AAZxfhc9QyMHSdE3d8ZyUzhDLMSaqCWu2cKiZpveKW2F3u18PaZ99PEolbicNREvO+JhdFtASgNd7i7j9iimHaXOXkQqmYvq/BPEdmSk4W20SfOGf23wqhzRZb9kiM+a06J7Ztv/dyWLmXK6mWeOMQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(54906003)(316002)(70206006)(70586007)(6916009)(1076003)(6666004)(16526019)(26005)(356005)(81166007)(7696005)(2616005)(41300700001)(5660300002)(4326008)(44832011)(8676002)(426003)(336012)(8936002)(478600001)(40460700003)(36860700001)(83380400001)(40480700001)(86362001)(82740400003)(36756003)(47076005)(2906002)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:57:32.1867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2241c3e4-df0d-4429-f547-08dbc4535ce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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
index 32156609fbcf..80f653e631b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2686,11 +2686,6 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
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
@@ -2724,7 +2719,9 @@ static int dm_suspend(void *handle)
 
 	hpd_rx_irq_work_suspend(dm);
 
-	return dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+
+	return 0;
 }
 
 struct drm_connector *
@@ -2918,9 +2915,7 @@ static int dm_resume(void *handle)
 		if (r)
 			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
 
-		r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-		if (r)
-			return r;
+		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 		dc_resume(dm->dc);
 
@@ -2970,9 +2965,7 @@ static int dm_resume(void *handle)
 	}
 
 	/* power on hardware */
-	r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
-	if (r)
-		return r;
+	 dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 	/* program HPD filter */
 	dc_resume(dm->dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e917530e4024..4b66d2730a88 100644
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

