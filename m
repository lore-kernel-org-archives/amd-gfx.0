Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF06CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 14:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5913618AB0E;
	Thu,  7 Jul 2022 14:57:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92D2818AC43
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 14:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZLXHB5Camunab5XsDcg72nPg5bmtmuQugDQa0ufAg64RnNZbh5GPvGYAogU6MCW3GiwkhVFlAFhMFKJgA+QGYsvK4VC/pEwzXWsbSUNrV/Ft+3VBP7XLjHTcyiewtHH9WRbGEpYp01Fs2GxfmJk8Vw2+NDpqR8gI81QZWDrst82PmXZYzViFdDlnobqwzHgcWS/bryZLqqLndWMMZFBGVKqpGcoXGZXwstujYeYGtRJArex4AKvvosYWDRmPydSXLV6c7ybQiMlFkLJtIJzOjeL+I64MIAjYQ2rhUOhilNGaQOdTOweYx4UU8bITYnl9rSY+KDlIxShw+alIcVCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1DkdPyuMJGvr8zCmZR/TvpJZ3yCTjYcVzOd64SteS0=;
 b=iz9MtnRCU2z2F4gzQ8DLSAKhlsnZinL1THWc6PYeuY/fJzZiBn5Heyv0vSjD4lHVSxRK0xf7miYph28INfZ8s1Z5B0+kwV2VdeHktU7+zsQzBtHgmaq/gEw4mAC2a6gAIHuY3fO3tt2aOz7Hryh1vhDknh5DkU1ChAFDW4+gY8TcAIRvWbL4Cqls8r4UlMV+fg62Lb29qFiIfz7w3eBzF+8Kj9kWWdDbZlna3cRVhMF/UwM/A0nwZQJY+70bzUfnfKJAaUJFBu7jLaj2ekGh3iZBPSDYjw3T+Ca1DTrXg4LicRXZ2AKZgV3jD6Q6T7bB4mRdsDBICnjGrU/yc4/r+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1DkdPyuMJGvr8zCmZR/TvpJZ3yCTjYcVzOd64SteS0=;
 b=SMyWjP08YWb5o+IOz+/b6B+WEQWSK0e8TfjTnk6PzcrpaqqHWTtskFlN0Rph103Ez83YgrgMaZCcIAsvQQCVl1mf671sK2HXoIx1lYMOT6OccbT7aa9RnVmxe7zv7S3svd5gWaHBGLg9dJq62hLuLuGsAfgaDXAjQcGBMF1523s=
Received: from DM6PR06CA0026.namprd06.prod.outlook.com (2603:10b6:5:120::39)
 by MW2PR12MB2377.namprd12.prod.outlook.com (2603:10b6:907:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 14:57:28 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::2c) by DM6PR06CA0026.outlook.office365.com
 (2603:10b6:5:120::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 14:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 14:57:27 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 09:57:26 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Add visualconfirm module parameter
Date: Thu, 7 Jul 2022 10:56:55 -0400
Message-ID: <20220707145656.565627-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f767c23-1576-48e2-b751-08da60290264
X-MS-TrafficTypeDiagnostic: MW2PR12MB2377:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F02l5saoKPOmCVnUrUqWyJZAZIuXIcPPKftu44Ph6HnpH86O+D/tyFQ/6PKvp5VjRlfNMYMhj5q9WF5HqYcP46FN+sr2iGLgMxNaBFDvAxDv+uhrfaMhWWzvU8UAz0jki3DhqBuO3Sy6iIs9w4I9TaIBa5oJvKb2zeTXENYV6Qw4IJp18byMTDEmWDPonWPn86xuGH3fr4/Z80PUAkaIXe28ocxTMFIQJMvBHI7Y8nGP3wX5HsLbJnZF+Dr5FzIJ8cYXd2IXB/WST4sJIzDs7IPznnOjMJ9idn4ogYpXlZ67a7Bov6m5OMGEaj09KLvYLOuoOUW0V4wyGCsBvRzQoNPRh9qarqJqU8fsuO60IVyMEbdAwL1C/xTBiykuyPjSshW1K+tTxr3Wmh0tjYh9bWooC16gUQ8nAfa7ig2GXx65xLz+H5GFuHhiZ7tIq3dMTO3geKeB6cYex36AiilqvDPKkvPBHwdrGn5DK5hZK2kMC9SX7n+bN8nyYATPt6KTzJk5sS44WVOgCYYdfCHyLQqLCVVQKQ4M0VVKm1+u/1C63jltqx+BHPqs/Pgf+SIVW+fhkBw5WWeAhCAe57gGA61sNwM5GsCp15WBVKTMmQXoCUR4uw42rRdQ4zH0/oDvKZVZ9PCxHQJwBVkVGVSJghoGOXUJtl0AiVXVWngwGSl9DaOz0OUgdpiyaW02s4d+pzaGpTEU/AUIbGRdCJVOh3FikVzTcH+Rmf4pxw4yOizgty2whHoLj+Ni+RlYyrhBFoKoLq6CCyAJcFu+40TTrt94fA184QmlmI5r7/DrgWGc0L17Dpiucz+1/zkWwgdPEj144Aw/yKGX6knDg40b/XCg9h0J8rUScBzGdvjPlfLJNYgWS7pPbL4FsP5fiM6d
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(40480700001)(5660300002)(336012)(426003)(82310400005)(186003)(16526019)(4326008)(47076005)(8676002)(316002)(70206006)(54906003)(34020700004)(36860700001)(356005)(83380400001)(36756003)(70586007)(6916009)(40460700003)(2876002)(2616005)(8936002)(478600001)(26005)(2906002)(7696005)(86362001)(6666004)(41300700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:57:27.5489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f767c23-1576-48e2-b751-08da60290264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2377
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

Being able to configure visual confirm at boot or in cmdline is helpful
when debugging.

[How]

Add a module parameter to configure DC visual confirm, which works the
same way as the equivalent debugfs entry.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 4 ++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 845d6054992a..4629bef6c44e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -197,6 +197,7 @@ extern uint amdgpu_smu_memory_pool_size;
 extern int amdgpu_smu_pptable_id;
 extern uint amdgpu_dc_feature_mask;
 extern uint amdgpu_dc_debug_mask;
+extern uint amdgpu_dc_visual_confirm;
 extern uint amdgpu_dm_abm_level;
 extern int amdgpu_backlight;
 extern struct amdgpu_mgpu_info mgpu_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1cc9260e75de..e1e8cf70e719 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -167,6 +167,7 @@ int amdgpu_smu_pptable_id = -1;
  */
 uint amdgpu_dc_feature_mask = 2;
 uint amdgpu_dc_debug_mask;
+uint amdgpu_dc_visual_confirm;
 int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp;
 int amdgpu_discovery = -1;
@@ -827,6 +828,9 @@ module_param_named(dcfeaturemask, amdgpu_dc_feature_mask, uint, 0444);
 MODULE_PARM_DESC(dcdebugmask, "all debug options disabled (default))");
 module_param_named(dcdebugmask, amdgpu_dc_debug_mask, uint, 0444);
 
+MODULE_PARM_DESC(visualconfirm, "Visual confirm (0 = off (default), 1 = MPO, 5 = PSR)");
+module_param_named(visualconfirm, amdgpu_dc_visual_confirm, uint, 0444);
+
 /**
  * DOC: abmlevel (uint)
  * Override the default ABM (Adaptive Backlight Management) level used for DC
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eb5efb4aa2ba..d7208c0b76b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1562,6 +1562,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
 		adev->dm.dc->debug.force_subvp_mclk_switch = true;
 
+	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
+
 	r = dm_dmub_hw_init(adev);
 	if (r) {
 		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
-- 
2.37.0

