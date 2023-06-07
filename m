Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D265C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1AA210E1E9;
	Wed,  7 Jun 2023 17:02:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CE110E1E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwsxDQGzYaO+73clPOsnsJcjnKRtHwWnbXhiNarQGjrpsJrV5AheqSrnlYwYyZItOSbC0kE65E79LytrPBAVEm0WQ4femCOg490ZVCNHq1Ink6D3QdfFwqBmNnsvP2uxfwKNK134hJTai5jPYDj2sauPREQh477CQlIkFk5Ns9Mj+gWKGj5xBFV3DPstCgW+1Iz0Yc/W8dTrLFFru28tz3m8ePbYjDSE4RTzE5EPqBKkcnGsZoLBKFqyvF5J15Jg4H+R55D04kueZvmU+uzbM1VKQfF38G7sojXIR09RmmJnZpLMJ9AkavC2/ZFfL9mz5Ro5KWA3BUowdcQC5b6fGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKq+ENvCYfZFMPe4fujNmIhrtYG86YA3UewQzjEr4KQ=;
 b=j5V4CKUcIZc1mef8aycGW4HfDBTuPfYK2inNz82vHvePXo6JnS84RxCTHh+ZNeO10vewTHZScKmovoK0gSvZulHDhXw9GyICLNaQnSTTjZqNndhZP+/z6GwpMFm48cxb7HfcyRk2fY3+njhcqsvCuLee25tk/Xpf/lJE7BcINtXfOPiqsCp8jYKbAg0MXJ1cN6hgO3TYNyrx8qHOpHo+WQQZYLCc70jsA/34HDoigRN90mc74isA83viymrTwpQzdHqH2Ife5TV8PLcFL6fEIU9jlpmcrP3ThelML0FZ4b88WBdUusUh/RfirP+3HcJoGvMJk4xpn8h4NGV+WlsLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKq+ENvCYfZFMPe4fujNmIhrtYG86YA3UewQzjEr4KQ=;
 b=GNt26sTDzk8cUAiqdFhQaabx3tURvmeAFP+S50GoEpYgf7siWRScru8r6BzIrK7lBXdzZekRNW8rYV7MWPrRdxOWzY8yLw32Xjd2a+kCVJ6huChcXvRJZSzLRwk9Y96dZcrgK2txQ9tuZupjFFJ+kVy10LvxPx3jQhAoMByL1Qc=
Received: from BN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:e4::22)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:02:42 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::66) by BN0PR02CA0017.outlook.office365.com
 (2603:10b6:408:e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 17:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 17:02:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:02:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: expand runpm parameter
Date: Wed, 7 Jun 2023 13:02:28 -0400
Message-ID: <20230607170228.964876-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b00b31d-a238-455f-55eb-08db677901ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRHQKzGxJEan6VVZqFykjjFKMLD0sxkMsAQdsWqVKkfnw7GV8Upz1bKuwY168lkiWL71Rujf6VbiPdQ9WVP3GNbt+Qb+aM79DoSkZvW7I2rggYOIwzZQFxVxlJXH3RvugVwvdpKDj8+a8eyf1ywwCZBEl/or4qeGObhuCLIEYSgTq6epSbYo4+JtM5OzzK2spE+x0Fo1N0YhgbDZ978Tf3SRWfxEnYX4JpAI2YGvns+mVu6zABZ+D5IrhxIKYlzP8yCPlxJICBedqYTyC+CbcMS4u/WqGA+grE+B0KAYG8AiuhGq8CNqpqwiDXIMdvKA83cuWMj9rvL9YVR3Qq0SpbmO9WTsV5d++K0pvJySE5cHTGN3hDDsJcj8Bdgd5ASHzv3R1SGKJr/0d3mAdk1DpWX3ZVgNLsVqi68cHc8pFLC06LWmqO9AB0UDD0QaNxc1Q8DvCgYkimyjQxeKZKYkP1uLSYvpBJSUeXq9ALJX0kEL0pb0DhQ+LnuH/OU3Un3ug7G86RwZMdt/keuJuREP2cikjvaUnqCEIeiEbJeVL1ROkbNjviNZ539E7gy7zMFNZm0IYUu32n4yPChEpBcv/ZQTkrHfzzTqO8huuKT6pr4pOc1qR68RHRqz9RE0/wLtXnBxDViIKOsFqdhVE4cLdPdQXW9/NUsho367ulC4lPbOF/edUN6BKOhgX0raeKojDoGGve7lty2Q72w3TRpjh/+VDB/1VY777Tt17/UwxTFFLjOtBV4C/H0P4aJXGWiC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(26005)(2616005)(1076003)(16526019)(81166007)(356005)(316002)(40480700001)(6916009)(83380400001)(4326008)(70206006)(70586007)(966005)(7696005)(6666004)(186003)(336012)(36860700001)(426003)(82310400005)(478600001)(36756003)(40460700003)(2906002)(5660300002)(8936002)(8676002)(82740400003)(86362001)(41300700001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:02:42.1329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b00b31d-a238-455f-55eb-08db677901ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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

Allow the user to specify -2 as auto enabled with displays.

By default we don't enter runtime suspend when there are
displays attached because it does not work well in some
desktop environments due to the driver sending hotplug
events on resume in case any new displays were attached
while the GPU was powered down.  Some users still want
this functionality though, so this lets you enable it.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2428
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 37 +++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 62cca1edcc32..0d9adcc4a4e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -350,8 +350,9 @@ module_param_named(aspm, amdgpu_aspm, int, 0444);
  * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
  * the dGPUs when they are idle if supported. The default is -1 (auto enable).
  * Setting the value to 0 disables this functionality.
+ * Setting the value to -2 is auto enabled with power down when displays are attached.
  */
-MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 = force enable with BACO, 0 = disable, -1 = auto)");
+MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 = force enable with BACO, 0 = disable, -1 = auto, -2 = autowith displays)");
 module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
 
 /**
@@ -2649,24 +2650,26 @@ static int amdgpu_runtime_idle_check_display(struct device *dev)
 		struct drm_connector_list_iter iter;
 		int ret = 0;
 
-		/* XXX: Return busy if any displays are connected to avoid
-		 * possible display wakeups after runtime resume due to
-		 * hotplug events in case any displays were connected while
-		 * the GPU was in suspend.  Remove this once that is fixed.
-		 */
-		mutex_lock(&drm_dev->mode_config.mutex);
-		drm_connector_list_iter_begin(drm_dev, &iter);
-		drm_for_each_connector_iter(list_connector, &iter) {
-			if (list_connector->status == connector_status_connected) {
-				ret = -EBUSY;
-				break;
+		if (amdgpu_runtime_pm != -2) {
+			/* XXX: Return busy if any displays are connected to avoid
+			 * possible display wakeups after runtime resume due to
+			 * hotplug events in case any displays were connected while
+			 * the GPU was in suspend.  Remove this once that is fixed.
+			 */
+			mutex_lock(&drm_dev->mode_config.mutex);
+			drm_connector_list_iter_begin(drm_dev, &iter);
+			drm_for_each_connector_iter(list_connector, &iter) {
+				if (list_connector->status == connector_status_connected) {
+					ret = -EBUSY;
+					break;
+				}
 			}
-		}
-		drm_connector_list_iter_end(&iter);
-		mutex_unlock(&drm_dev->mode_config.mutex);
+			drm_connector_list_iter_end(&iter);
+			mutex_unlock(&drm_dev->mode_config.mutex);
 
-		if (ret)
-			return ret;
+			if (ret)
+				return ret;
+		}
 
 		if (adev->dc_enabled) {
 			struct drm_crtc *crtc;
-- 
2.40.1

