Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1C2C48297
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Feb 2024 21:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F5410FE74;
	Fri,  9 Feb 2024 21:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRzcl3Hm";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F1410FE75
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Feb 2024 21:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhhceAK5yy0iQiCzDivEVMiN8fTitD/q7ECE0PmLWl2Kf7gg7MFaaV+TEfZPHw1xRAITaU1Sm9TCeIj0pG5v+bhTUlbRv23OH+t/IfbR3P/hdL27Dbqh5k8klx4m3PZzEc4E6VzX8jlrYjcUcmfwjDR4vKBSM66e0aiBbvdFY34TDbOO3MEzS8BLnEp/eZ/0T/EAXHMmWlrBvBsKNHoNzvaanEkJbqnnf/N8GtUMKufeaNmXHMMKKM18pWYgqsfbYTbPJWCnqr3DejDksJacqkWrc5L9ohKNn9MIcVZiFGxBKIo302cnNZ5wJkWm/YQroIHR+pGl9NnzRYouGdjhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSWPHvVffA3tfaExZu46nZn/vXhltaf78cEAZnSRRtY=;
 b=HrVYmaFCWFMAxive+aZwdW4rmG1wvYQrwSxg/nNZXurD7cCRlNOTGIcCyodaC2QslEkbazGuRJnyaLXMomATEtr/liEScXQFJg+BxMomqJ6IqsUKzpejrWXooX7J7WBHb1xRoV3or705GNVlMvvHhElQempPHfvQbD2m2Yx2l0GN/2+zoCiOw8ywMQ31ydDlCXHvLssIiREMyivv3ezfZg3c/Z7xoJhKdeu3cifq/g9to8uPIKC88F5ieXudBzKejtEAbYitlwHgnOXYBD0t7D0osUmtIwwmSjgOUdSig2pzYytlLmLz5bQpnzFM1g61Ig1RH4Wi4/ZS0fqw6cUulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSWPHvVffA3tfaExZu46nZn/vXhltaf78cEAZnSRRtY=;
 b=BRzcl3HmRwPWY0Iivr7R/DdrcG0IizPGkzLkjqNDimpZrAztjpytIHi3bJ3/LeIjYMmAKqJfz1QZKmmPKuVew6vUtMk5nWsSyOJx9rUlxJs2aJwb8RAzNZSNGIeX+NP5LGtEl2tkO/XXD53kpOzTah8G5AWXBlr/hJNqDhNHWW4=
Received: from CY5PR17CA0024.namprd17.prod.outlook.com (2603:10b6:930:17::33)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 21:46:52 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::f1) by CY5PR17CA0024.outlook.office365.com
 (2603:10b6:930:17::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26 via Frontend
 Transport; Fri, 9 Feb 2024 21:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 21:46:52 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 15:46:51 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amdgpu: respect the abmlevel module parameter value if it
 is set
Date: Fri, 9 Feb 2024 16:46:31 -0500
Message-ID: <20240209214631.23219-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: ad74f66a-0aee-4027-72b5-08dc29b8a0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZjVIgcI8Yr5Yed42BdvIncjt8HFZ14m0QBg+/v16G52NQ9abylNgiXgo0zNWzTM25/PXev2KxeMrvN0LPKze2Qo1QuDsM4quLuG51ERhd1qb+WqJzhWJozdNXalQzu4fI+E7I8Dk3fIclbMfnuUkNtEH/EaILdIb5CAisd87CEu7LatrMBI5t5GLAHFTRoQ3yXVnNRTYQUkNVg8FoJK+7MoSDzVuw/xs7Jfe4x/4ttlwG46k9o/3XZ5Gzb9DIi+Tl5bKpAZwRSOkkloYVS02fYvy5RivedcRnSFyqOcuAU7ZrGDmtriJt2v1/2hrN9D3yW6BdenKemOGEX5U8bQ4zy+4+7GDvaq1NzvCgXTIgtKuAeJvN4CX/S6YF90pgWRB4cQemQM9otM6Oxa7DJbqRG1RkDThd0wv0L6QMMbVldKphCiSJXx6lqHly3TJiIVimTlNNijRp6RWlCDMLZMQQqBgtki1Ua1gUj/V6P89PcSiNVJzpIPDN9blTdHuFB3AKy2vONejU1w3TKhNwfPi+Jq/ksC6Dly/t89oWZT0LebOWg1ri6aiCY6KGXMJqul9hAzFRJnzdzUBKIc081KoqxcVOygU6COMp9NgETuXaY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(2906002)(4326008)(8936002)(70206006)(8676002)(6916009)(316002)(5660300002)(70586007)(54906003)(44832011)(1076003)(26005)(478600001)(6666004)(16526019)(81166007)(426003)(336012)(86362001)(2616005)(82740400003)(36756003)(356005)(41300700001)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:46:52.4396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad74f66a-0aee-4027-72b5-08dc29b8a0a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, if the abmlevel module parameter is set, it is possible for
user space to override the ABM level at some point after boot. However,
that is undesirable because it means that we aren't respecting the
user's wishes with regard to the level that they want to use. So,
prevent user space from changing the ABM level if the module parameter
is set to a non-auto value.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 ++++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++-----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1291b8eb9dff..f5c8187e0d58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -196,7 +196,7 @@ extern int amdgpu_smu_pptable_id;
 extern uint amdgpu_dc_feature_mask;
 extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dc_visual_confirm;
-extern uint amdgpu_dm_abm_level;
+extern int amdgpu_dm_abm_level;
 extern int amdgpu_backlight;
 extern int amdgpu_damage_clips;
 extern struct amdgpu_mgpu_info mgpu_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6ef7f22c1152..af7fae7907d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -849,12 +849,13 @@ module_param_named(visualconfirm, amdgpu_dc_visual_confirm, uint, 0444);
  * the ABM algorithm, with 1 being the least reduction and 4 being the most
  * reduction.
  *
- * Defaults to 0, or disabled. Userspace can still override this level later
- * after boot.
+ * Defaults to -1, or disabled. Userspace can only override this level after
+ * boot if it's set to auto.
  */
-uint amdgpu_dm_abm_level;
-MODULE_PARM_DESC(abmlevel, "ABM level (0 = off (default), 1-4 = backlight reduction level) ");
-module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
+int amdgpu_dm_abm_level = -1;
+MODULE_PARM_DESC(abmlevel,
+		 "ABM level (0 = off, 1-4 = backlight reduction level, -1 auto (default))");
+module_param_named(abmlevel, amdgpu_dm_abm_level, int, 0444);
 
 int amdgpu_backlight = -1;
 MODULE_PARM_DESC(backlight, "Backlight control (0 = pwm, 1 = aux, -1 auto (default))");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fbe2aa40c21a..a5b3330879f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6513,7 +6513,8 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
+	    amdgpu_dm_abm_level < 0)
 		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
 
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
@@ -6577,9 +6578,12 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 		state->vcpi_slots = 0;
 		state->pbn = 0;
 
-		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
-			state->abm_level = amdgpu_dm_abm_level ?:
-				ABM_LEVEL_IMMEDIATE_DISABLE;
+		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+			if (amdgpu_dm_abm_level <= 0)
+				state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
+			else
+				state->abm_level = amdgpu_dm_abm_level;
+		}
 
 		__drm_atomic_helper_connector_reset(connector, &state->base);
 	}
@@ -6617,7 +6621,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 		to_amdgpu_dm_connector(connector);
 	int r;
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
+	    amdgpu_dm_abm_level < 0) {
 		r = sysfs_create_group(&connector->kdev->kobj,
 				       &amdgpu_group);
 		if (r)
-- 
2.43.0

