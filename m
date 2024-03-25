Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2192CD11DD
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C1910E713;
	Mon, 25 Mar 2024 10:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ly3Ql0ik";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A0110E704
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 10:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0h2gN9VNCH7J9m8U1SPaj+YmhvXOc31xIsHjf5VoJS3qw8K43B1Sx07xlKHs0b/0C2glU+rz889PsD8tPl+IJ1ZteL7+MITyRpigyzG115yJYwgyHjfGGvWbd3x51viDa/uJjRstwHM/DlMu7RbfkXvYnCptz2Coahs6GX3HNRNuzYYC8UsPS8ko0rhMumWrf+rd+QTJcQ3LYhTHnBck3xoAAAt4ooEAXlt3x3wMyIlGVSrttsJLBCyXfO2Zu/Z/MuCF2JXlbiRwpdLdEOKH9UvmnhoXsDFp1V0FItBLEAUvDttRMCZPt9oW1CMIlwZhHFpoDDAhayB1f7vDrTUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se4Nh3X9IPP1Hyp8eKSMkm0Od16lkH6Kq0L0xdDOI24=;
 b=CeCs0AJo3HbcYKs5qYnbUdH+qtxBYvCFZNmh9sjDuzEt0K2TCtM2zO7BHvBKKmpJdSzvMgTQd9Jpfh2+V1munu93Wh2NKCFBaZE9nRQ3td6TcKI0rdu87+efLJmkNgGnD894xrNXohAkTHd593msxmUqoQ1SeCLXC+NRpofFqi3/3zgPNrqU+yYidDlVa5AQZlX1BAICeIaGWIluB9y2uhBjVUR59D4+O3QrhHtNdJ4gpdQarPKc6U5lJzgdygtKNaf/bcAHJaTooYh43rZ1U+GeHihKkVTHhZU6jVTyQhIuXkbaS+iYHrH9CkXqqC94CpZ3H6S7mgeKZZknvlQStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se4Nh3X9IPP1Hyp8eKSMkm0Od16lkH6Kq0L0xdDOI24=;
 b=ly3Ql0ik/cSdp8bzmmglWJ+hQV+6tD8OdlleXDmUFMQviY9IlloBJFh0h/faB/Pt5mDMrumjncvQogStTr22hzGEHZeX6KRKuY8myivVW9Tj2mqqzK8WfcRVuUtiJRy72uExrTZ7BCylKUiOQYeNCh74Nljwa2eUlOi1PxwqIBo=
Received: from BYAPR06CA0016.namprd06.prod.outlook.com (2603:10b6:a03:d4::29)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 10:16:30 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::43) by BYAPR06CA0016.outlook.office365.com
 (2603:10b6:a03:d4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 10:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 10:16:29 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 05:16:25 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/pm: Add support for MACO flag checking
Date: Mon, 25 Mar 2024 18:15:57 +0800
Message-ID: <20240325101559.2807629-3-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325101559.2807629-1-Jun.Ma2@amd.com>
References: <20240325101559.2807629-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ee78f4-0fed-462c-4d98-08dc4cb4a35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMYX+LFw+g0RjIwaVWxWpWt6Zh/dtxjCCMo6/VMte0L7bFkYNatZp/MhVnFppX95SfiXzfLSh6EPhfMpZzdlsjn+8h0Y9eVPfHVSRLQcc2p1EOia1z7wd3gOaY51aMiW1+o+yU8oYGzirUqYaNc95gaYRrSaIfO4XClKqov53bZx+ZFTvBanBEmHCSN2CKfXn+AN38DVFroa97EydR6if/O3cg5ld2dFzEQTWdAxzaxQlGn0OMwnibJFOi6DbtxCbxhCgRzMNTF8+hh5QxoeSDbx0R6uO2gKUene0xomWA11B2jGKO8r1dIpmfWEHdA4d5kDx6gsoS2ZyOuy1qfoLZQNjYgG/3FNaB4PCNFjfeW6CVIjdt5oSdcgadWKRShtUQ02QBZh2v2eR+9ey9ZcyRe5B2ryAZbSOXiGx1vf23v+gj9A0R6LYpI9kQ2JzXLPqKAF8AIrQAQ7SmpPksCHwp23n53W9yli6mbNqBHEYQ+TzGE04ciE3qi68WKjLRy7ROuunSYMQymRCKf2TcioNx5Ee96ROhaVDBDhVRIXTQJhtCVCA1t8a8vmQEPtOpWHC9/yDtruGGuKEzgP5qszu4R7jYuG/aOBM0jCILVYF1Dnaw7JenwzKboCyam0SdFItcERti/v3G7RYnk1q+bMZtiglz669lrIqP9UU5VTF+FuOhPCjWzGGFLlDg9WB3oIuSDzzZc+0HefAGmSYIdErrdUuyhKgylIaRTtuvzsT5ldw/msCDEk++nx4hipjqDH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 10:16:29.6543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ee78f4-0fed-462c-4d98-08dc4cb4a35b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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

Add support for MACO flag checking.
MACO mode only works if BACO is supported.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/si.c                    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c                 | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  8 ++++----
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  8 ++++----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c |  6 +++---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c |  8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h |  2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c   |  8 ++++----
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h   |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 14 +++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 14 +++++++++-----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     | 14 +++++++++-----
 27 files changed, 74 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c62552bec34..3723235f5818 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -605,7 +605,7 @@ struct amdgpu_asic_funcs {
 	/* PCIe replay counter */
 	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
 	/* device supports BACO */
-	bool (*supports_baco)(struct amdgpu_device *adev);
+	int (*supports_baco)(struct amdgpu_device *adev);
 	/* pre asic_init quirks */
 	void (*pre_asic_init)(struct amdgpu_device *adev);
 	/* enter/exit umd stable pstate */
@@ -1407,7 +1407,7 @@ bool amdgpu_device_supports_atpx(struct drm_device *dev);
 bool amdgpu_device_supports_px(struct drm_device *dev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);
 bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
-bool amdgpu_device_supports_baco(struct drm_device *dev);
+int amdgpu_device_supports_baco(struct drm_device *dev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev);
 int amdgpu_device_baco_enter(struct drm_device *dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 12dc71a6b5db..aecb55d6963a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -341,7 +341,7 @@ bool amdgpu_device_supports_boco(struct drm_device *dev)
  * Returns true if the device supporte BACO,
  * otherwise return false.
  */
-bool amdgpu_device_supports_baco(struct drm_device *dev)
+int amdgpu_device_supports_baco(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index a3a643254d7a..fdbc26346b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1375,14 +1375,14 @@ static int cik_asic_pci_config_reset(struct amdgpu_device *adev)
 	return r;
 }
 
-static bool cik_asic_supports_baco(struct amdgpu_device *adev)
+static int cik_asic_supports_baco(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
 		return amdgpu_dpm_is_baco_supported(adev);
 	default:
-		return false;
+		return 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 23e4ef4fff7c..67e179c7e347 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1409,9 +1409,9 @@ static int si_gpu_pci_config_reset(struct amdgpu_device *adev)
 	return r;
 }
 
-static bool si_asic_supports_baco(struct amdgpu_device *adev)
+static int si_asic_supports_baco(struct amdgpu_device *adev)
 {
-	return false;
+	return 0;
 }
 
 static enum amd_reset_method
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index dec81ccf6240..c8abbf5da736 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -502,7 +502,7 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 static enum amd_reset_method
 soc15_asic_reset_method(struct amdgpu_device *adev)
 {
-	bool baco_reset = false;
+	int baco_reset = 0;
 	bool connected_to_cpu = false;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
@@ -540,7 +540,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 			 */
 			if (ras && adev->ras_enabled &&
 			    adev->pm.fw_version <= 0x283400)
-				baco_reset = false;
+				baco_reset = 0;
 		} else {
 			baco_reset = amdgpu_dpm_is_baco_supported(adev);
 		}
@@ -620,7 +620,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 	}
 }
 
-static bool soc15_supports_baco(struct amdgpu_device *adev)
+static int soc15_supports_baco(struct amdgpu_device *adev)
 {
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(9, 0, 0):
@@ -628,13 +628,13 @@ static bool soc15_supports_baco(struct amdgpu_device *adev)
 		if (adev->asic_type == CHIP_VEGA20) {
 			if (adev->psp.sos.fw_version >= 0x80067)
 				return amdgpu_dpm_is_baco_supported(adev);
-			return false;
+			return 0;
 		} else {
 			return amdgpu_dpm_is_baco_supported(adev);
 		}
 		break;
 	default:
-		return false;
+		return 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 1a98812981f4..2415355b037c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -897,7 +897,7 @@ static int vi_asic_pci_config_reset(struct amdgpu_device *adev)
 	return r;
 }
 
-static bool vi_asic_supports_baco(struct amdgpu_device *adev)
+static int vi_asic_supports_baco(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_FIJI:
@@ -908,14 +908,14 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
 	case CHIP_TOPAZ:
 		return amdgpu_dpm_is_baco_supported(adev);
 	default:
-		return false;
+		return 0;
 	}
 }
 
 static enum amd_reset_method
 vi_asic_reset_method(struct amdgpu_device *adev)
 {
-	bool baco_reset;
+	int baco_reset;
 
 	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
@@ -935,7 +935,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
 		baco_reset = amdgpu_dpm_is_baco_supported(adev);
 		break;
 	default:
-		baco_reset = false;
+		baco_reset = 0;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index afb930b70615..805c9d37a2b4 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -421,7 +421,7 @@ struct amd_pm_funcs {
 	int (*set_hard_min_dcefclk_by_freq)(void *handle, uint32_t clock);
 	int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
 	int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
-	bool (*get_asic_baco_capability)(void *handle);
+	int (*get_asic_baco_capability)(void *handle);
 	int (*get_asic_baco_state)(void *handle, int *state);
 	int (*set_asic_baco_state)(void *handle, int state);
 	int (*get_ppfeature_status)(void *handle, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f84bfed50681..eee919577b44 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -199,14 +199,14 @@ int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
 	return ret;
 }
 
-bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
+int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	bool ret;
+	int ret;
 
 	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
-		return false;
+		return 0;
 	/* Don't use baco for reset in S3.
 	 * This is a workaround for some platforms
 	 * where entering BACO during suspend
@@ -217,7 +217,7 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 	 * devices.  Needs more investigation.
 	 */
 	if (adev->in_s3)
-		return false;
+		return 0;
 
 	mutex_lock(&adev->pm.mutex);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index e6cad9f7aaeb..501f8c726e8d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -411,7 +411,7 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
 int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev);
 
-bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
+int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
 
 bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index fafd4e0b7908..d4b7a80c649a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1371,7 +1371,7 @@ static int pp_set_active_display_count(void *handle, uint32_t count)
 	return phm_set_active_display_count(hwmgr, count);
 }
 
-static bool pp_get_asic_baco_capability(void *handle)
+static int pp_get_asic_baco_capability(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
index 1ab4fbfe0cde..4ce068c08cb8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
@@ -33,7 +33,7 @@
 #include "smu/smu_7_1_2_d.h"
 #include "smu/smu_7_1_2_sh_mask.h"
 
-bool smu7_baco_is_support(struct pp_hwmgr *hwmgr)
+int smu7_baco_is_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
@@ -44,9 +44,9 @@ bool smu7_baco_is_support(struct pp_hwmgr *hwmgr)
 	reg = RREG32(mmCC_BIF_BX_FUSESTRAP0);
 
 	if (reg & CC_BIF_BX_FUSESTRAP0__STRAP_BIF_PX_CAPABLE_MASK)
-		return true;
+		return BACO_SUPPORT;
 
-	return false;
+	return 0;
 }
 
 int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
index df142c2eec8e..a2d6b71789f8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool smu7_baco_is_support(struct pp_hwmgr *hwmgr);
+extern int smu7_baco_is_support(struct pp_hwmgr *hwmgr);
 extern int smu7_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int smu7_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
index 687cd80ebad8..3684bca772bb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
@@ -28,13 +28,13 @@
 #include "vega10_inc.h"
 #include "smu9_baco.h"
 
-bool smu9_baco_is_support(struct pp_hwmgr *hwmgr)
+int smu9_baco_is_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg, data;
 
 	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_BACO))
-		return false;
+		return 0;
 
 	WREG32(0x12074, 0xFFF0003B);
 	data = RREG32(0x12075);
@@ -43,10 +43,10 @@ bool smu9_baco_is_support(struct pp_hwmgr *hwmgr)
 		reg = RREG32_SOC15(NBIF, 0, mmRCC_BIF_STRAP0);
 
 		if (reg & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
-			return true;
+			return BACO_SUPPORT;
 	}
 
-	return false;
+	return 0;
 }
 
 int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
index 24461f1e3b01..2decf7d549d5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool smu9_baco_is_support(struct pp_hwmgr *hwmgr);
+extern int smu9_baco_is_support(struct pp_hwmgr *hwmgr);
 extern int smu9_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index bc0ff417921b..934d530a9cce 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -36,22 +36,22 @@ static const struct soc15_baco_cmd_entry clean_baco_tbl[] = {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, 0},
 };
 
-bool vega20_baco_is_support(struct pp_hwmgr *hwmgr)
+int vega20_baco_is_support(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	uint32_t reg;
 
 	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_BACO))
-		return false;
+		return 0;
 
 	if (((RREG32(0x17569) & 0x20000000) >> 29) == 0x1) {
 		reg = RREG32_SOC15(NBIF, 0, mmRCC_BIF_STRAP0);
 
 		if (reg & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
-			return true;
+			return BACO_SUPPORT;
 	}
 
-	return false;
+	return 0;
 }
 
 int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
index 006eb6633ce8..13eef042ec42 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
@@ -25,7 +25,7 @@
 #include "hwmgr.h"
 #include "common_baco.h"
 
-extern bool vega20_baco_is_support(struct pp_hwmgr *hwmgr);
+extern int vega20_baco_is_support(struct pp_hwmgr *hwmgr);
 extern int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 extern int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 extern int vega20_baco_apply_vdci_flush_workaround(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 83f903d8e994..bee0eedc2b3f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -351,7 +351,7 @@ struct pp_hwmgr_func {
 	int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_hard_min_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_soft_max_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
-	bool (*baco_is_support)(struct pp_hwmgr *hwmgr);
+	int (*baco_is_support)(struct pp_hwmgr *hwmgr);
 	int (*get_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 	int (*set_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
 	int (*get_ppfeature_status)(struct pp_hwmgr *hwmgr, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 246b211b1e85..1f0a34251b9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3200,7 +3200,7 @@ static int smu_set_xgmi_pstate(void *handle,
 	return ret;
 }
 
-static bool smu_get_baco_capability(void *handle)
+static int smu_get_baco_capability(void *handle)
 {
 	struct smu_context *smu = handle;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a870bdd49a4e..dad43894cab2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1175,7 +1175,7 @@ struct pptable_funcs {
 	/**
 	 * @baco_is_support: Check if GPU supports BACO (Bus Active, Chip Off).
 	 */
-	bool (*baco_is_support)(struct smu_context *smu);
+	int (*baco_is_support)(struct smu_context *smu);
 
 	/**
 	 * @baco_get_state: Get the current BACO state.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index a0e5ad0381d6..7cd991069a79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -237,7 +237,7 @@ int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu);
 int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 		struct pp_smu_nv_clock_table *max_clocks);
 
-bool smu_v11_0_baco_is_support(struct smu_context *smu);
+int smu_v11_0_baco_is_support(struct smu_context *smu);
 
 enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index fbd57fa1a004..b81aa9c521e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -210,7 +210,7 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu);
 int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 					       struct pp_smu_nv_clock_table *max_clocks);
 
-bool smu_v13_0_baco_is_support(struct smu_context *smu);
+int smu_v13_0_baco_is_support(struct smu_context *smu);
 
 int smu_v13_0_baco_enter(struct smu_context *smu);
 int smu_v13_0_baco_exit(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 3f7463c1c1a9..5e887f551b3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -159,7 +159,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu);
 int smu_v14_0_baco_set_armd3_sequence(struct smu_context *smu,
 				      enum smu_baco_seq baco_seq);
 
-bool smu_v14_0_baco_is_support(struct smu_context *smu);
+int smu_v14_0_baco_is_support(struct smu_context *smu);
 
 enum smu_baco_state smu_v14_0_baco_get_state(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5e5da9b16718..d0c6dad24458 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1557,23 +1557,27 @@ int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
 }
 
-bool smu_v11_0_baco_is_support(struct smu_context *smu)
+int smu_v11_0_baco_is_support(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	int bamaco_support = 0;
 
 	if (amdgpu_sriov_vf(smu->adev) || !smu_baco->platform_support)
-		return false;
+		return 0;
+
+	if (smu_baco->maco_support)
+		bamaco_support |= MACO_SUPPORT;
 
 	/* return true if ASIC is in BACO state already */
 	if (smu_v11_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
-		return true;
+		return bamaco_support |= BACO_SUPPORT;
 
 	/* Arcturus does not support this bit mask */
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
 	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
-		return false;
+		return 0;
 
-	return true;
+	return (bamaco_support |= BACO_SUPPORT);
 }
 
 enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 0467864a1aa8..33da5347880a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1582,11 +1582,11 @@ static void aldebaran_get_unique_id(struct smu_context *smu)
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
 }
 
-static bool aldebaran_is_baco_supported(struct smu_context *smu)
+static int aldebaran_is_baco_supported(struct smu_context *smu)
 {
 	/* aldebaran is not support baco */
 
-	return false;
+	return 0;
 }
 
 static int aldebaran_set_df_cstate(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ce16f2a08a47..a65877eeaa8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2268,22 +2268,26 @@ static int smu_v13_0_baco_set_state(struct smu_context *smu,
 	return ret;
 }
 
-bool smu_v13_0_baco_is_support(struct smu_context *smu)
+int smu_v13_0_baco_is_support(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	int bamaco_support = 0;
 
 	if (amdgpu_sriov_vf(smu->adev) || !smu_baco->platform_support)
-		return false;
+		return 0;
+
+	if (smu_baco->maco_support)
+		bamaco_support |= MACO_SUPPORT;
 
 	/* return true if ASIC is in BACO state already */
 	if (smu_v13_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
-		return true;
+		return bamaco_support |= BACO_SUPPORT;
 
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
 	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
-		return false;
+		return 0;
 
-	return true;
+	return (bamaco_support |= BACO_SUPPORT);
 }
 
 int smu_v13_0_baco_enter(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 443233563a52..02b098d81ebf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2078,11 +2078,11 @@ static void smu_v13_0_6_get_unique_id(struct smu_context *smu)
 	adev->unique_id = pptable->PublicSerialNumber_AID;
 }
 
-static bool smu_v13_0_6_is_baco_supported(struct smu_context *smu)
+static int smu_v13_0_6_is_baco_supported(struct smu_context *smu)
 {
 	/* smu_13_0_6 does not support baco */
 
-	return false;
+	return 0;
 }
 
 static const char *const throttling_logging_label[] = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 9e39f99154f9..cc7cc2a6d871 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1590,23 +1590,27 @@ int smu_v14_0_baco_set_armd3_sequence(struct smu_context *smu,
 	return 0;
 }
 
-bool smu_v14_0_baco_is_support(struct smu_context *smu)
+int smu_v14_0_baco_is_support(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	int bamaco_support = 0;
 
 	if (amdgpu_sriov_vf(smu->adev) ||
 	    !smu_baco->platform_support)
-		return false;
+		return 0;
+
+	if (smu_baco->maco_support)
+		bamaco_support |= MACO_SUPPORT;
 
 	/* return true if ASIC is in BACO state already */
 	if (smu_v14_0_baco_get_state(smu) == SMU_BACO_STATE_ENTER)
-		return true;
+		return (bamaco_support |= BACO_SUPPORT);
 
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
 	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
-		return false;
+		return 0;
 
-	return true;
+	return (bamaco_support |= BACO_SUPPORT);
 }
 
 enum smu_baco_state smu_v14_0_baco_get_state(struct smu_context *smu)
-- 
2.34.1

