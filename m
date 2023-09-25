Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6CACE7AB9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 18:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2C910E2CA;
	Mon, 25 Sep 2023 18:24:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602F710E2CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 18:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLXixUyFQ5Y6g2OTBGSSQPn7SrScacr1YnK2jXtyH0MZIB6FrPIarrCy0T9ZkZvGyxP+TMPHuEmH5lIwvzM2NdNU3GEBOBHQcIRUjrSy/789Lk43/mZ0heRs/e6lvNn4Jd65Lp7HiFfDxQI9WBvdsIB3kv5sOihqPCs92wOycAvlY78xydiwg8h6A3MQmQViBYGOF6TTgAW+u3xakJtvhkOeb81pa/0aKwplqDZJjlN85S8BPBRkRzRpbrpcqFQwr7zP4Q8GZXJxflsvJ/N4XLorKUnV+yw/QvDI6/tqSXeD9rb0UuegPwct2nEYKKfHXz14XBnvCXHycItw/lbbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnSNN6ISQd7aGytbfLfE6lHc7Lm2mZ7MVwCuPDXduVM=;
 b=ZHEn6m0oG2nRtu+issPJc5dVVWJHOvuP+wCBhdq8RlgL7xGhzQ8L3OTJC1bT5gzDI17XpDSQ1GIOnQXnpZ84wRrrbdYKMPuC8TIT2yGCHmG4a8QDX7zeRGL4cfStaGvZuAQp9rOkBhqR6CJViGq5xHJy+bqkQiC9tjLz/BMzFhDMrlHiRo4M2gnFacgLKS3MAijkB8XXxTIDpA3PfLoBRZDbSP5RysMYbnDfvSLri4+CJA2NvCVnBsJaYLcUxMx2y7yqkU/k+303u40pJ9PQv44klIg80Njy8JIa8S5drtDDlRDyMwa8cXRyQYNvk4JJUDUiGwU2xJuwTNZnDbYObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnSNN6ISQd7aGytbfLfE6lHc7Lm2mZ7MVwCuPDXduVM=;
 b=2znKEyKk+GKd5LzTtE1pH9Qk70UKf+O/bWLJl0DWLg7w9tgx6bp7eEY5jCfHNvW2N4sKy329EAmSu4fKq0p4TacjpxdhA2a73bqclUJa0rna4adOKNJNMlKBzmfgoo/08JlpTCWJxki+shYzVxKs5V3jCapdeTNBqwK74TjtGAM=
Received: from DM6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:5:1b3::36)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 18:24:22 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::df) by DM6PR17CA0023.outlook.office365.com
 (2603:10b6:5:1b3::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 18:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 18:24:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 13:24:21 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Change dc_set_power_state() to bool instead
 of int
Date: Mon, 25 Sep 2023 13:24:07 -0500
Message-ID: <20230925182407.109250-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7e8654-f893-48a5-ec50-08dbbdf4a3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqWPO80jk1JHbdZtWOt7tGthNglrP7sygkpKi/gGMGMqBYVE1KAnSeoZMO6FIhfiwOJn0JS+GfswX1+Nw8uEwzVBPa0ubV5hHNn5TtgK+N/z4RgHhfzekLfGRdMHaJRedbsJHugNQCRqR18pKpA24XhBEYvTj7yPbL2yBTtaQ6ynXhl7ob29MgLmlOvoiRuLJzpthEWPi0Cuedl1QMoC2qXowhWowD7/2oznWALV/bLbQRqrnATtX+TgolEFa5tiKmgZ4Xs6X3WCpha1g97rt54WMhrKJV+p85rmDMKT9UQECkYXdYVKb1DbbLRBNmj8FaCBK09HWTxf2laI34j2Iskd5etirsnnLLBXcybtl7V+TTTnqo7HFsaY9J67PUyWVuIqSLvZEgmU7vEpE2NZCc1lC1/B2WDz4fB2HbDfdJfWnk4n9EJLRhj9X/ZvgRPueqr6tNzm51UTOE1MpLr6bRRgCLweRBgPHUBmPoknl7KjTBiscwDvAgMamzcFQpVFlapOI+KURcDK2Ui7ipxZZPTt2ymYvJZ95HmqDw/40hUGF6ha9iOlVOyNOrTZ7zs2emGCjtP5Ls0i/5zzLgZp8gjUrzri7Mf3j7Y6zHoXFw+D2PCGNs9O3rkqAN+x8afXPSXSzYVbIGHugEMmqq1VeLqOgcSsyDB1xg8kpk+FblnYzTs60YWyEAmFPGsTQQIq+e02KYtow82kc8D/UaiC7Kn9bovNH8vyXk5MKiKV8IW9rYj6oIiBjX3//Mf+ABaNMxJTxQVq1K8nTm7lIOcDVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(6666004)(356005)(26005)(16526019)(36756003)(2616005)(41300700001)(316002)(1076003)(336012)(8676002)(426003)(8936002)(7696005)(40480700001)(4326008)(40460700003)(70206006)(70586007)(54906003)(6916009)(2906002)(36860700001)(478600001)(86362001)(47076005)(83380400001)(82740400003)(44832011)(5660300002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 18:24:22.1765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7e8654-f893-48a5-ec50-08dbbdf4a3e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DC code is reused by other OSes and so Linux return codes don't
make sense.  Change dc_set_power_state() to boolean and add a wrapper
dm_set_power_state() to return a Linux error code for the memory
allocation failure.

Suggested-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---
 drivers/gpu/drm/amd/display/dc/core/dc.c          |  8 ++++----
 drivers/gpu/drm/amd/display/dc/dc.h               |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 58609a8cb49d..f06136a0bba9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2638,6 +2638,11 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 	}
 }
 
+static int dm_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
+{
+	return dc_set_power_state(dc, power_state) ? 0 : -ENOMEM;
+}
+
 static int dm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -2671,7 +2676,7 @@ static int dm_suspend(void *handle)
 
 	hpd_rx_irq_work_suspend(dm);
 
-	return dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+	return dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 }
 
 struct amdgpu_dm_connector *
@@ -2865,7 +2870,7 @@ static int dm_resume(void *handle)
 		if (r)
 			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
 
-		r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
+		r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 		if (r)
 			return r;
 
@@ -2917,7 +2922,7 @@ static int dm_resume(void *handle)
 	}
 
 	/* power on hardware */
-	r = dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
+	r = dm_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3b060e08707d..cb3cb2db90ee 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4723,7 +4723,7 @@ void dc_power_down_on_boot(struct dc *dc)
 		dc->hwss.power_down_on_boot(dc);
 }
 
-int dc_set_power_state(
+bool dc_set_power_state(
 	struct dc *dc,
 	enum dc_acpi_cm_power_state power_state)
 {
@@ -4731,7 +4731,7 @@ int dc_set_power_state(
 	struct display_mode_lib *dml;
 
 	if (!dc->current_state)
-		return 0;
+		return true;
 
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
@@ -4758,7 +4758,7 @@ int dc_set_power_state(
 
 		ASSERT(dml);
 		if (!dml)
-			return -ENOMEM;
+			return false;
 
 		/* Preserve refcount */
 		refcount = dc->current_state->refcount;
@@ -4777,7 +4777,7 @@ int dc_set_power_state(
 		break;
 	}
 
-	return 0;
+	return true;
 }
 
 void dc_resume(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d30de81b4779..b140eb240ad7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2330,7 +2330,7 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 
 /* Power Interfaces */
 
-int dc_set_power_state(
+bool dc_set_power_state(
 		struct dc *dc,
 		enum dc_acpi_cm_power_state power_state);
 void dc_resume(struct dc *dc);
-- 
2.34.1

