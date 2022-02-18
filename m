Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA21C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4BC810EDE4;
	Fri, 18 Feb 2022 22:26:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30FA10EDE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYMRQfe05TZ3BLwD6ofKRC7mzNaHyyZeGGLySJBZjLmJVBGjHy8hImDcp2+hpPFWvCyQHb9pGKJyB37KzHn0T9QRUsP3Rnil8PqytuVs9l9q/8eYJSmE4irEGRqnpLOhhUgTiOY0aS6FesB+2TnetXYDP5keQlRmP140n7+L6q2QabNjVQC+BgpFvlNoT6x6PkldDGNvmINBpOdxvSX90m3TnRVdkW6xU2oPhB5DSi5w3//a1aoWRLBIdwpmdXVhQ6IJ/6d5il49JfLvrZob+Ms9rjRnJJVyUnLiB1iBk4eKoacsxT1ljEbkyCI27z09e7YsVnnQoBRPOVo1cmaOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNFMQa7RD52H2Rw6aeuUlBOPRUiM4exwRoElh2j69+g=;
 b=C6cVRt/MpIVMbhScEIL6Ew/XZQ3M+LAS7NnNUDaSHbnrvluW9sZA/Q0quWFnB9k+HwxSh4m+OweGtumUqcnKeepnlhv+ArrqyFZ1rwtHMTkeQLNFrhZGZxYv/hpWN8R0YBYu9YyJMp68YL5bhkIPMc1bHTIX7ihMtjUJFKzRl8kNUX1EVhV1X4C2L69T3v3Dux1Oum4RSpQ4uAoKhjx34fA9JWEH6vtMp2wjdImrMe0hrn7vabUxdM1DjlHxHnaQi+8/nhHFJJ8Viw14WBiQ4D1sycv76CKUkJw3gk3iIame4yV7WCFxugA08VaHCBQcBdxjwt1MnZoM7Wd7wQNZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNFMQa7RD52H2Rw6aeuUlBOPRUiM4exwRoElh2j69+g=;
 b=QV4vjKTxoH10ZtH78POCRioVI8XeowPnZJZhJU4MadaZtevSQA3NGW04XDqhpUsN2eR8BWg4CyugrGoP9tKIk4CFs3f1Z7xul5+deJNnU3raRe3mVv2sQxnSMNm1gbi5rMxB+cynYQkIJZM8Qa6IMTeBNMBHBCLxAEt1Szhgz/8=
Received: from MWHPR20CA0019.namprd20.prod.outlook.com (2603:10b6:300:13d::29)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Fri, 18 Feb
 2022 22:26:19 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::b2) by MWHPR20CA0019.outlook.office365.com
 (2603:10b6:300:13d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 18 Feb 2022 22:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:26:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:26:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: drop benchmark module parameter
Date: Fri, 18 Feb 2022 17:26:02 -0500
Message-ID: <20220218222603.25470-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218222603.25470-1-alexander.deucher@amd.com>
References: <20220218222603.25470-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1497d13-b8ec-4fab-5c15-08d9f32dafbe
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5609:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB56098F016F8211F08F802247F7379@SJ0PR12MB5609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkCccAGkaQ7NQEPx3XCGOkYGkM0fl+3NPt1YDhitpO4hAhovpi3MUzNo//Orbx0kP7wipgo84tDwXYPe2kEteIF/vfJbELoiJsJzBlw14nKVo4r/z3IKjwSuh8BwkM7Oc9xM5P5dFkmsOmzrE/FvhZbaeHQ9VDi0n9u41O8ZndNWcI7TdwUk54O8HYW1UdpvGFYFGeMPwc0XdFVXzd90d7ubch9fAxEHJw9Hm9cGb6mpY5Vxn9vkI6xhjwnRCas9OpSmEXiUnlQHL6986w/7VTU+0MiQcvdYdsVtz7F492uzoCgKXtzc/BwmC8IwZODG1V0C9dVNM4+Wl5ESu3ER9ni0Ff0TDIUzqW4PcOq/FmvdglBjhWBssZv/9OOM36nvWAc7JJXLxXIXFJigVzJudQUyADOthcOAjbIEDUSIvXUjYY1OOX6vjv1nv+jpSZEKXH9iyZol/4+FOGQcyEzcc/s7Mb1I6nLZRcXnQ8ODeyp55wXWsnVBFXyIp7MaKqiHcejmXeTxDmGJUfhg9El/GJ7AA1DqZNDZueLfpeFLVRW5zIUOJq7BrppRImVPSHkz7oWTtvIFTd3OSymujVBcEEK4JDvBTxVzhMmZCkibH7Vu69meiPN4SdEVcJbgMGGHfkdjLSHiL0nueoelhnsn5Nr+VIrZDfLMm/qtVzpdTcPpDCUTmvAZ+dCzZ5N2Te7EC7D4V+ariW7y9ODV7Imc7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(426003)(8936002)(5660300002)(6666004)(7696005)(70586007)(16526019)(70206006)(8676002)(4326008)(1076003)(40460700003)(186003)(26005)(2906002)(86362001)(2616005)(508600001)(82310400004)(47076005)(36860700001)(81166007)(356005)(6916009)(83380400001)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:26:19.5327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1497d13-b8ec-4fab-5c15-08d9f32dafbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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

Now that we expose the benchmarks via debugfs, there is no
longer a need for the module parameter.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 --------
 3 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c736c30e0a0a..d6cf2e343a43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -155,7 +155,6 @@ extern int amdgpu_vis_vram_limit;
 extern int amdgpu_gart_size;
 extern int amdgpu_gtt_size;
 extern int amdgpu_moverate;
-extern int amdgpu_benchmarking;
 extern int amdgpu_testing;
 extern int amdgpu_audio;
 extern int amdgpu_disp_priority;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 63b4876e13c1..02863e2ea3c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3811,12 +3811,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		else
 			DRM_INFO("amdgpu: acceleration disabled, skipping move tests\n");
 	}
-	if (amdgpu_benchmarking) {
-		if (adev->accel_working)
-			amdgpu_benchmark(adev, amdgpu_benchmarking);
-		else
-			DRM_INFO("amdgpu: acceleration disabled, skipping benchmarks\n");
-	}
 
 	/*
 	 * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a0b5cf9a41cc..a76d78a6dc54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -110,7 +110,6 @@ int amdgpu_vis_vram_limit;
 int amdgpu_gart_size = -1; /* auto */
 int amdgpu_gtt_size = -1; /* auto */
 int amdgpu_moverate = -1; /* auto */
-int amdgpu_benchmarking;
 int amdgpu_testing;
 int amdgpu_audio = -1;
 int amdgpu_disp_priority;
@@ -231,13 +230,6 @@ module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
 MODULE_PARM_DESC(moverate, "Maximum buffer migration rate in MB/s. (32, 64, etc., -1=auto, 0=1=disabled)");
 module_param_named(moverate, amdgpu_moverate, int, 0600);
 
-/**
- * DOC: benchmark (int)
- * Run benchmarks. The default is 0 (Skip benchmarks).
- */
-MODULE_PARM_DESC(benchmark, "Run benchmark");
-module_param_named(benchmark, amdgpu_benchmarking, int, 0444);
-
 /**
  * DOC: test (int)
  * Test BO GTT->VRAM and VRAM->GTT GPU copies. The default is 0 (Skip test, only set 1 to run test).
-- 
2.35.1

