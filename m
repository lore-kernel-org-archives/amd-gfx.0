Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DDAEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 15:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0168D10E00B;
	Wed, 12 Jul 2023 15:53:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A2B10E00B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 15:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQU5Y7abQTQjdZf0sU2gQfKzE1tSFmRxgy8yFHIVEMUgAAbaUz2vtqUyH0OrXNpU4n2cSqy/yIxVc2DzRiKPAd/UUlJsso0YqCgqDQmnk9CtrUNfl9zyb3XSJ1H27vXmzPkgsTIqcpDp6x69G6zvxEXiYLXvVDiiKmGuyL3MyRTDYFnrcWeIuPtAPv0qihUikwJMhlw7KBhcdwcDnYBgWC7JKG/9izGFPHHoZ755/Dc0P9KLKp6qfCZbHhd+Vs2NACypyqC/GDR7dwFsyRQtTvFhtL7NHhThmhu4TOlbA7uA0vdxd0WNYy8Pe+B6/5+fo04zSFbzQZVasuAodUG42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3Oe/cqKLZh/EQ3Xh7iXCAdbRD1CN609Ad3e9u+dyPs=;
 b=MPf6AqSIvjgoMGH+i5plEtGtmk3koqtfOAS18fh4UakPpzeOhrfQvRdvolULmoblfWVMCXKrFEt6qkoY+3GJGSx7G0Blpx2NL09MdnRlWSm1zvfZreu6q7R0Fqdhcb6x6booSVjZvCdkgBbgX8z8nKK+m6TaH+1z1MD3mxYmxQKXF6YHs489HCwrNeM0eIY6ri9PzXOeBkOkDFPCHObgYV2CmaSZWWCk2lM4qxPuVbHouXNLd+HAqzrfEZ9rrkgdJHt2qXUtRndHaFFDoCtdcm8nO2urxfhNQ9y3GowTuRhkxI1CLFpK5p2GO2QariImQ/Elj6TT2GxA91UIvt/XJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3Oe/cqKLZh/EQ3Xh7iXCAdbRD1CN609Ad3e9u+dyPs=;
 b=RSzKHEIgPAi7E9C/ZemgbXoLXv2tonJRsTnIdaL7mJCqdHGk63uvznjVU5VsJv1e2TmOPJtGoLRJjZg7Zuy9ycAoNOvTKFYvgVXbKA76eo70WNs7N8Zpb+2GgnxwBNcKsCaq9jkcsUIC5x9ldWrI5vx4LKy79n8TmCKyfqXsrG8=
Received: from MW4PR04CA0366.namprd04.prod.outlook.com (2603:10b6:303:81::11)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 15:52:59 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::5d) by MW4PR04CA0366.outlook.office365.com
 (2603:10b6:303:81::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 15:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 15:52:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:52:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: expand runpm parameter
Date: Wed, 12 Jul 2023 11:52:45 -0400
Message-ID: <20230712155245.2940715-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|BN9PR12MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e9906e-b1ad-46a1-731b-08db82f010f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmJTUN6otIm9zqofexVqYJz0IMIWfJbS8P5pOxihzuj+X5kpYszLJvkCQuLqFrPXReuQRWDFQg35pXhHzQoeCnCcR55OYS9hsXee1PgN0EaACxtB/icM106u2H/h2VKTEoDbeOXooCw7kKdRCkXAHJj7w7lbjrYEpaaqqnue/BzE6z+o3sw76oDGjIOQFAPWivyhPVwV2BiBxNOBZc7T0wvO+wqCv4Fl936i0HXjZhW7iMUxFtPomLnoqB3EJ9Tk/w8RsQSurWyv1RrstgRCNgBZXMxPpef/8WI/15AkgNE8yLDC2k3izY2B+VXVH41kAWIe5waZguIPxiLE0vNB+9bIXXfadNmKdjRC04R8JdtZI4ZJ692txrWw79EHT9E9A2GzO7QJWmrtLanf1AJRk+fwl+XyhTSP4R85YU0nEWzpp3xCTGchE6Fr6bbHTIu7iAZgeDGFGon+A4dCUoEZUNLsO3Pf5ZZnt6yCCEYea81blORzR0rWAGU0wXgmNFFKP816vw/g+PcM16nYV291pKMm9qLJfhpQxzlvDgesO4jm9H5wfz4W0JbBlxcp1jEV/0v9RqgCqgCHJY2CGxADQeKUKTZg9oFjFJu6nGY5AWv0A2N+9GM8JJ5SUrte2qsYHW/cWOHZRtyuRw+J/yuJoUPl7FVRfnJeCnuBHXHRx+x1qHGX8ONRLpFEXtpG275O0GWdEvtKy3NlFPtJwoLDaWxUXeD7C+N3L2Ln83Td2g8I8lyGlYyPrSQyA134B62ojrzMiKJ73ihsJvsL3Ff+CVvICgyQ9XkIUNBjhYaqJlk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(4326008)(70206006)(6916009)(70586007)(316002)(41300700001)(2906002)(478600001)(8676002)(8936002)(5660300002)(36860700001)(6666004)(7696005)(40460700003)(966005)(40480700001)(1076003)(26005)(186003)(16526019)(36756003)(426003)(83380400001)(336012)(47076005)(81166007)(356005)(82740400003)(82310400005)(2616005)(86362001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 15:52:58.9581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e9906e-b1ad-46a1-731b-08db82f010f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
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
index 721f3c6160bcb..33e370d998a87 100644
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
@@ -2657,24 +2658,26 @@ static int amdgpu_runtime_idle_check_display(struct device *dev)
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
2.41.0

