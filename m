Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED381EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 07:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF17B10E186;
	Fri, 21 Jul 2023 07:49:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECD510E186
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 07:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdE7tthct0eLs2LNXvlT9bIGd7oGJXkVDZPGiFcFubRKW3Mr94/Tm23kPMyHmk6yO0X5UANPq3CuAHcB6kzjRTkjekK658HQcJgxxaDArt4itkyUKdTC2qLglSvIxf4EaVLmnsfLScP7VLFKRd5qfd845rLC4LMm3WAyLsbfNj8yHzveEFqr8G2PMIC2GMbzoEtGVHD7Fkb5p7ozEAHzb9w5cZFtGBs3TH6bZHXvLCyo9zshongmqrzqM1FaF1AnuTe29FcO/JQbwhwVUoegmD8+yvPImA7t0XEeP019WSlhQ3UAwtfHLFI3p+YRQlBDkgB8RoivqGsQIMEJ8dxWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xex0fqE9faQTWunl+7I1gKzWRjHX3nRsZJIDAg4QSgk=;
 b=R4ubPFU185W3Oi30ZFTAUJjFx2QWoK5WayyU1wCSZmkMia2Ga1gpEFYeOcsTfkuROPWBtTsUsALngbQEm/TfVbkOkGNFwTCSsnGaB+B9QBbdck0Iazsy0A5K/w1BOOKI4fSDw85X8Q+AyCYWtfc0o7LC+mcJGy7xrIEKwsZJ+8bN4GVdukV4nDoXNiwDULypj+Wc2/FUM/WreGhvqIkPfe5vGhKZ6rgRa0zEOD5A4I1ki1+IXUpF4SJVw6x/4xkiwnp9pHys7bnPI4705FFyB+Tgjeat9uipC8uYkP9s+wnTEG/YfmDlcLWchmHCTKpZf2gryog+P7n5Rf7Aojq4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xex0fqE9faQTWunl+7I1gKzWRjHX3nRsZJIDAg4QSgk=;
 b=MjDKvj+AQWhEVFB3zX7Xl6OZgmDi4qdQn8NHtqPibzoQ78kb+mELOxDd5qvKQFIY5GMBSwFhM6K+OJAlEmNq8AkSvX91mplBvbxvcBV96KLN1h1zr8MErOldvWpS4oHlOXFyLwZbZyo6VsiGpwo2CthvXjlIWJxqy6KwVUD/nJg=
Received: from DM6PR08CA0064.namprd08.prod.outlook.com (2603:10b6:5:1e0::38)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 21 Jul
 2023 07:49:33 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::59) by DM6PR08CA0064.outlook.office365.com
 (2603:10b6:5:1e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 07:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 07:49:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Jul
 2023 02:49:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Prefer #if IS_ENABLED over #if defined in
 amdgpu_drv.c
Date: Fri, 21 Jul 2023 13:19:17 +0530
Message-ID: <20230721074917.723184-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 846c7e46-d870-4ca7-d3bf-08db89bf058b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xh25y/YJ0CT95UCBa4HxexQRVDLfMHjsH5fy2xSXwJbTPGs8CWtZmmR4cYksx9sXbNXqumST1di7cNJXw84fRtNb+E64ZqZwtgR+/Fy2vA1sK/ZQy2lU68aMotczvEueJCXh+h7XQ6zE1eMiz8NSyFDrUqo8E4qxt8cmpuOtTrQNSowKyMayP31hFqKhrpp7pROebjM1VQYuAp1esWWf+BOYzMm7IVppv3756Ldg72qjNQihT7cBxQDdKbV6+DpEluq9KGMNlaURrdUXXtVpFp/RZLZwOGhEOh/rVM4XA3ccIraMXPiqK4FLxPmqVipWr1WAS/VkT8uHDSurF0gLhB+58pwiQ5vK+9LULFr5TDq4uBnkfMygotd3euJd5ajBiZ6LeqlWROdA3VyZccGDvAYpufMVnIDH0IQoOcMpfCZZZaDbofS4+BR2zui+OiP/7eOpq6IxMGG4FOgv38sT4olBw1G5UDiRc1DbAwuA282aYqcGWSFis1bNmutrSD9enxudny3p8972UgCHCsMM7bymF3cfRzDLPwjhkKwqSnnJhUPFyYkJbv9hNmNvRm18zQec2NrLuf/tSBIZpaReUug9N7PRmDoGhRKJZHnZhsfCjuwZeJR6ADj3QhrNj1JiXeAFqzJkFBNcfBe3y2KiwdScdTLYuoEat1+PBjR18f3gn9eC6a9jt63Yv8pF7n9fCFENpAf0bqla8tXswMR2QyhpEehC2+7JsVGMvkSPApFJ6MYw9K8qbUiCvQ1wgVnpsyoW4AjDBXpVV/o5J48VCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(7696005)(36860700001)(40480700001)(86362001)(36756003)(356005)(82740400003)(40460700003)(81166007)(6666004)(1076003)(26005)(2906002)(478600001)(54906003)(8676002)(8936002)(5660300002)(44832011)(4326008)(70206006)(6636002)(70586007)(110136005)(426003)(66574015)(2616005)(316002)(83380400001)(41300700001)(47076005)(186003)(16526019)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 07:49:32.7084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846c7e46-d870-4ca7-d3bf-08db89bf058b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adhere to linux coding style

Fixes the following:

WARNING: Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE
+#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)

WARNING: Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE
+#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3d9171eca11c..c315fe390e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -584,7 +584,7 @@ module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
  */
 #ifdef CONFIG_DRM_AMDGPU_SI
 
-#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
+#if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
 int amdgpu_si_support = 0;
 MODULE_PARM_DESC(si_support, "SI support (1 = enabled, 0 = disabled (default))");
 #else
@@ -603,7 +603,7 @@ module_param_named(si_support, amdgpu_si_support, int, 0444);
  */
 #ifdef CONFIG_DRM_AMDGPU_CIK
 
-#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
+#if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
 int amdgpu_cik_support = 0;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled, 0 = disabled (default))");
 #else
-- 
2.25.1

