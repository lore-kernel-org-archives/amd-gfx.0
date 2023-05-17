Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401E5C77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA25410E3F1;
	Wed, 17 May 2023 11:38:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C21410E3F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1zFr6AhYkMIXbuRhS1eJ1rwkRJRZL9IqmJEGoV03s36b2meGdIWp9sO0ITMysVSK/LTpZVpUtOjLJAi7oZYogktE0QEKl5EKgUGBwJuYDJAVP9q7oayYSBuL3My3BR8wTYI1TfbeqN9L83n9CPnk1fbNqgu+XDTyCviRU8agZAar8NLHj63Q5kXNEcNdoriIdCtO5L15r3smZVAAXvhrPXjRCEcSdlYKE0x8zv+/eF2Wm8KncCQdzwrBCMmHBf5wuI11CEDf81J2lxyQziP4PI57vqHaI48XCG82fuzB+l38LryYwWnmf0HfUg7doIC0+vo69peN6SD0IOQwJtMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sd/Ds8NBeyLnAgfzHlzUp+5mPIlLctnBmNbWwGZh80=;
 b=kvZSSSgnjyym2/ww7YZYFe+CLnqKjxTRTP4/jcZFU8KbflWkQOfuur43Dg6ChoXQC4B9n+iwVDyzHkVj8eEx3Ta0kpNLkAREP0gJTy3d9KdAe6X76FBWq7sMtqUIWhcroCH1ivkO8AUGydAmy02qlgRUGmzUQVZplahWh1Agv7HgcPPVtvYn8Y6m/MMmH0GSaj0MTfdt0yUtJZe3s1cipfiUK9gmr7m8adSU+s2IgS/YJTfjZJiHwE1aheCZLvQqVlOdl753K+3Fm8TmmR7pqIUkvOKG79/5+Qdt91M4WBodXZYO/QWisEZ0EGsOuRDQFrxZjqD3YA2RkmEgF7PhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sd/Ds8NBeyLnAgfzHlzUp+5mPIlLctnBmNbWwGZh80=;
 b=iQbTDkHrXM3X7VNXEXQHh/WMog8VoO1WCCvSQ0Klv0M+GO6N6leKHsBrZez9g5dDUqmkqMEEJsYsqnspNBlg3gThSvDllMMX8mKOjSp3m4eqf4RsdYY5t+1DMizt0J4yoescdtUeGo4IqDnve7zI9z5nENEfMolDPwPMCd9y3FQ=
Received: from BN9PR03CA0499.namprd03.prod.outlook.com (2603:10b6:408:130::24)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 11:38:12 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::b8) by BN9PR03CA0499.outlook.office365.com
 (2603:10b6:408:130::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 11:38:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:38:11 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:37:56 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/18] drm/amd/display: improve the message printed when
 loading DC
Date: Wed, 17 May 2023 19:37:06 +0800
Message-ID: <20230517113723.1757259-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|CH0PR12MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8d1149-da86-46ea-8d7d-08db56cb3258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSmi+hgXhIq1ROt296e9euiZYrJKhE5Msyd39V9HULQFWlTF3eKgBHRTt056xU1YXhOSDKF2M28Q5LPSDsST5x/A9nVrmmnWTfZSfnbLSPQKuXTK7QQJRfKdlgs2OBLEpJOLtp+EtEkjDIMhPuF7jUWwgg4J5G3ua7u0vbLsbctsB//7Vu0Yh65voMyjXzsN5jWaA/XMj83WZY/ik0JyOS7ITu8XV0Ke8sZvYiXAYwEBaR6EVCvN2DHKP+hTRnmn4MlomH4iyUnsX08yTN24uT9wtzLl/7UNUzA5C1Y8PNhceZb1pX/2fZ8yf1DoqwaSE9ZLyUJKGn6ApniqJS/wEAeXYQ+qNZPmugHuYb1ogXt/Skwh54E5pU0h9lMjApN4A5yMSzSnIGDiE4ydVuDAxNUzxxo/zQd0AngO1XNXxpphsuq9Y4W2TylV+56mC9drvsZgLxpWkmrx9bNQDoLck9tf5JqeRI57aQq1X/sCX9qyusIZd8JBFXdNykBLG0PdZcsAfr5yOshr9B9AW10IrVUUb8eiXzFq3AXQLxWvgnvf+hlXKIGZCmWXUjwcTqa+uP41FoRczH9ki0PD09UtPB5WDx9v9err4AfM434TfDTRMm8PYh2LJ9+f6+0qSRbM3byivMT88naddSLb0Pm/qSlIMeNljzi3wq9FqwBuzn4pVRCKu930W3NPzNTEG20mzonunNsGcDE7GP2O/MXviadw3drrvBZEjV0o8X6pbIVOI2pLzLCZjPLLxWjzm9/seZ2yXZIzHOIi7JBW6DJ8gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(70586007)(70206006)(54906003)(6916009)(4326008)(316002)(7696005)(6666004)(478600001)(41300700001)(5660300002)(40460700003)(26005)(186003)(1076003)(8676002)(8936002)(40480700001)(83380400001)(47076005)(336012)(36756003)(2616005)(2906002)(36860700001)(426003)(82740400003)(356005)(82310400005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:38:12.5602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8d1149-da86-46ea-8d7d-08db56cb3258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
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
Cc: stylon.wang@amd.com, Tom
 Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Change how DC version and hardware version is printed when driver is
loaded.

- Remove exclamation
- Add DC version and hardware version to both success and failure cases
- Add version in between appropriate filler words to make a complete
  statement.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 14b296e1d0f6..45b778631430 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1666,10 +1666,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev->dm.dc = dc_create(&init_data);
 
 	if (adev->dm.dc) {
-		DRM_INFO("Display Core initialized with v%s! %s\n", DC_VER,
+		DRM_INFO("Display Core v%s initialized on %s\n", DC_VER,
 			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
 	} else {
-		DRM_INFO("Display Core failed to initialize with v%s!\n", DC_VER);
+		DRM_INFO("Display Core v%s failed to initialize on %s\n", DC_VER,
+			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
 		goto error;
 	}
 
-- 
2.25.1

