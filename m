Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A08C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 10:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97D210E3FD;
	Tue,  9 Jan 2024 10:14:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C5F10E3FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 10:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ip5lP7BItrOfkz7KMXfHsORetBWYLPoEWAaNKLk4fjdDPP/7TKy8O/Ub7tCwxfTMXBcP6fRHkANa6TKOxcZK0U3z3KnOhbvXW5Py9VXKbgtei98lmlNyFJ9j/g/Of+i1TrTK0zGc/RfWCycFTR3RgaLEarS0GCwpoRTvl8Oh0anBIfHX7vB3zlimvM37LYoejo+bnZnqbe5mX+4Fy8jU4RRVQq3q8Pzjy10JKfi1MbwPrCrtUdYJNkoXveZFI4K9D4PQo5BuRYOslVMzaoFugTCEVfyC8U7yMKulvbVklEH96wgpkJWH6eWOpPX6fb4j4IWKjhuEJrsgtqXtj+2KmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zruL3QbsCVC4zC5wyV05nuZb3ffHwxe7TwbWG9wt0Uk=;
 b=O7Ej+3ZZqgpf82dkwz4lMWRMSvB1UTVw0CKG5h+eYwpimWVOpOzBvIoS4k4yUmyMFYNPL60YyAwkguQ0ldpDi2PotEGM0WFoGn0LKcuHUYvgr3xMas3s3eOYkGrCPET4iV9d59tGnNAGFe6o1dAoSsQ9+AIIDpgvXNfwBmarLDlNyX78MTxfbn9lV+DgetDiS9Uz1hBDw9doonNs0o4Q6rSGX4lEeNVehMV76bNRJEl1CQUM1Aanb+HeETx5Qgi2+ZBzgMTtT+d6+OZZ+rElvl8iE1/l16F5RRjpIPaEE+Ea9wdVQpbwyNwpZPyJrJjCzyZTRDR1+QJRn+xymJvTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zruL3QbsCVC4zC5wyV05nuZb3ffHwxe7TwbWG9wt0Uk=;
 b=G+iMTRNuctT+1MGfkUA3UWeQCgw+cMKR2yUAmoBnYnDEqZOgx0muhT5jMHurq1boy5g33zmqZ3+Bh0qGFpGgYXyZm522x8JxnsXuduYLoeAZNtyOcD8SI15fudAxGdMcTL16OpjzEnZAXtAIXx1Szc1hfUYjDCf/K90BVCRTcOs=
Received: from CY5PR15CA0204.namprd15.prod.outlook.com (2603:10b6:930:82::15)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 10:14:33 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::bf) by CY5PR15CA0204.outlook.office365.com
 (2603:10b6:930:82::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 10:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 10:14:33 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 04:14:30 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Revert "drm/amdgpu: add param to specify fw bo location
 for front-door loading"
Date: Tue, 9 Jan 2024 18:13:57 +0800
Message-ID: <20240109101359.28362-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: aab9d356-34d5-40bb-6736-08dc10fbc676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wLqgwMIbTchg2gqhmM0pgt5wF6XJw0CIQFGzBSiGwlckQMjGuRBwbu90zgnxvV46pwuyRBM4dNJvBf/9UhVVaonDImam86owOWwxJrMt76kJgFiYZBHD53W+m0/Hh2YqqbsfKzn2kD7/70GopFMz4gQLP3+28fZyGCFqumi3HDgwsgCgktYzFK+yZK3oSV2o8PxFt7twWzIF/8OOaYWLRq6uIPtEbEkwL4cbIqGxeONP2OhxV2Jbiqz3i9TE3uA9+MYGSCP2jxjLK3LD5k4nrgKep+WPZjXrMpOAB4rR+91+G/mezAAk1/iI+zfWcClY59OcSnC64IQhn70x6mpaENAuspDyF1OLMtMdTcuKmLQVGdPgtiLE5cMPKIKPS9ALrnhhBI8dhJOpSArx4wVZVdooD8dF2DGuYP3BllRFo+RySbW5qDd7meDfN1x50u7/Ax91iWgyykogfmkCwTsv5aK5IaTbFJuC5ygg61y/nPeAHrl0q1YeklJQhSOZ1vnBYWcXu/OlkOCb0C7MvmrhQoCeoU6IRahsQAVq0/OLNEtVvjdFaUXHcwYBHooJj0XjHzrD9VvpVnTNIqVYdnGORmyFKkp0SloGWUoaaRtWhorsWOzueDxgt6PHgq1a0Pt80GR2/QrG+WPnEgOvUi/hCZTdujA3JVDoRafxsCjfFw/OoZVrX31v89MyJObGfWO6zRtTcIuWF63miuWeyUHVJain+upM5W+6TrfIN7zTfBIkBbJ3vbHN7xKMtD9XGpqdmY8ZO5Yc4CkfzbMLzS4+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(36840700001)(40470700004)(46966006)(36860700001)(316002)(336012)(54906003)(426003)(16526019)(8936002)(47076005)(8676002)(36756003)(6666004)(7696005)(83380400001)(44832011)(4326008)(40460700003)(70206006)(40480700001)(70586007)(2616005)(1076003)(478600001)(26005)(6916009)(82740400003)(2906002)(5660300002)(41300700001)(81166007)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 10:14:33.1314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab9d356-34d5-40bb-6736-08dc10fbc676
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
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
Cc: Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 1797d97a977280ac2cec95b1b59acc5856fea11e.

Will use debug module param instead of independent module param.

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +--
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9da14436a373..616b6c911767 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -254,8 +254,6 @@ extern int amdgpu_agp;
 
 extern int amdgpu_wbrf;
 
-extern int fw_bo_location;
-
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 852cec98ff26..880137774b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -210,7 +210,6 @@ int amdgpu_seamless = -1; /* auto */
 uint amdgpu_debug_mask;
 int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
-int fw_bo_location = -1;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -990,10 +989,6 @@ MODULE_PARM_DESC(wbrf,
 	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
 module_param_named(wbrf, amdgpu_wbrf, int, 0444);
 
-MODULE_PARM_DESC(fw_bo_location,
-	"location to put firmware bo for frontdoor loading (-1 = auto (default), 0 = on ram, 1 = on vram");
-module_param(fw_bo_location, int, 0644);
-
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0993ba4a4476..51bfe3757c89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -467,7 +467,7 @@ static int psp_sw_init(void *handle)
 	}
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-				      (amdgpu_sriov_vf(adev) || fw_bo_location == 1) ?
+				      amdgpu_sriov_vf(adev) ?
 				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 				      &psp->fw_pri_bo,
 				      &psp->fw_pri_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index d334e42fe0eb..0efb2568cb65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1062,8 +1062,7 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 {
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
 		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
-			(amdgpu_sriov_vf(adev) || fw_bo_location == 1) ?
-			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
+			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 			&adev->firmware.fw_buf,
 			&adev->firmware.fw_buf_mc,
 			&adev->firmware.fw_buf_ptr);
-- 
2.38.1

