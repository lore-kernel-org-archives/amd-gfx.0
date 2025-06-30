Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4DAC83029
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 13:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2110810E45C;
	Mon, 30 Jun 2025 13:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rjA2wUSq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7770410E45B
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 13:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiIQDd/72aHe5kTHVBN60h3YwP2XvmiVomfvKWFAYhrbdq7r72zywqIuBSVJhFtr886dsaRrwCJYQWzusDYbW5oV3OJk7yn2CerpCnTiM3viGlLAFx2bLpfR1yujwP2M9Vu7r7duMd+c6aKHPHMmcZDoVIH8igyM+tK0PcDXLEIER3bgF+itCn/CEIay7PoSVG0SWJSbdoV9OMtnQMwD2L7xXA+YR9d3xgdaPhYx3iBOrG4SSxxcNv1Wd1SMDKKjUY+ba2w39JQv7U0oYg2czCVDNcD6uCxImqAD/qjBcOAxA0GnF03BAGSZZRoAeZo6UFZeuiO2tTYZP//KlFIUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj8xnZMOXZPoJ2hYBuvcurmXvYSdbkGkgpa+OEy7c7g=;
 b=CEnOBOHcG+Uro3nrwg8NcM384XbywLMIToOiOEq2lmnLwtEIZBanZpJqurJzuh5mf8tJcPjq8VNuIfFoAUz4bu6x/9SSrP++vHKZoKqU4GhCoY0rSbm7WOIsyo+X2d1DSypLM136iHMP/sgMz+ynfg3S09JKuybpS00qgUHeIE53LKNJg8BhtLoIWk54JxEgN/vTTfwzaXFWL3yDlXVPGhEQfOpGt1v9+gkxbuH6RDs1JVwM2VgGmGN7qEO7kSTr3s52+russzTNdayurL9gFD+4cUCB70+lE315BHQocKucSR6ti79ev9XxAKlexJCq5nwXgFuysp3efXhrHloutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj8xnZMOXZPoJ2hYBuvcurmXvYSdbkGkgpa+OEy7c7g=;
 b=rjA2wUSqbbtIrKB12Hkmbj7FrObqc0SbcdL/YuKH9uivPhGg/i2uj/CPy/5m0Ny2zjmtOdZBR0Tj/BVGV4dVUNWf4Gbn13BqiZ0jLuGwZmn0iGXvG6hxcIlHGAOQnZZbxfEJESgOQKN0ltaYTFZnbYYo76NrPhBuS/lDdCWlCV8=
Received: from BN9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::20)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 13:57:21 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::14) by BN9P223CA0015.outlook.office365.com
 (2603:10b6:408:10b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 13:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 13:57:21 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 08:57:19 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Pass adev pointers to functions
Date: Mon, 30 Jun 2025 19:27:00 +0530
Message-ID: <20250630135700.1286085-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4f8bab-3fe7-4f03-dcd9-08ddb7de08b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jBzWtfkRePggRidRJ/3Jnxx9fhB4akTcJrNJgPLchdP0KZ0rI05N7UxQ/gc7?=
 =?us-ascii?Q?S1FreEWOJ9DjbTSuZXwV3W64LMUROOpfz1l9avraITbpOMR7dB1JRZ0R9QNy?=
 =?us-ascii?Q?ZAto2KCTe/BtQCRtnuVXEG4LI6jGOMeLtvL5WzH7Or6DcQgtUnq5GL8/2lsy?=
 =?us-ascii?Q?Af5wTRAshogtGl76iu3xtiu1sx7txmiWO29yfFvpt3+EcSRU0PMDPLCV+WwF?=
 =?us-ascii?Q?7bWWh5QXApa5UWG7o6zCqlimGr59VcPVHyErU6fGRaItG4aDCJPu7Q5ozn0J?=
 =?us-ascii?Q?dwpYJSInFVJYpu6MBqNu7Jeh3gM4PHxf/SVNub2cW4dFZzsp7r4DebWx0fzm?=
 =?us-ascii?Q?H0qWKwlt0qYsZkiQjY8SDK33RKe5xvDd3FLZxNIhJremp9nZupNhdbaV6QUX?=
 =?us-ascii?Q?yQ/b0Zm8easAwPClHvYCaDDSu+BWVvfIOWjEwQeQKao66n4K6YjMNGzK5lTb?=
 =?us-ascii?Q?7lfssdJoZbqSl2wwQj999Pi6Luhi+UlzTca0BdR8lelrydPmoNUjHKHVF8bo?=
 =?us-ascii?Q?Yg5DoSNLkmq/GFmU+Y6dTpRz9YSO+DH8Yy9sPVriAqXPp6uwDVz5xCCNeLsX?=
 =?us-ascii?Q?BamAURQZMXl5kuDtcHxhqT3N3uevvbWthoxpHltBwdAEI0MCWb2JYu2hegmB?=
 =?us-ascii?Q?NTlBAlS3w4ZbV17+IQdtH+hmujdrrW1zqw+U1E2f+qYiebugIh90Py7fKRMF?=
 =?us-ascii?Q?anD9s6tqF4o5znpjGLVw8CUjVta/9ffU/9Bw9FB3Z2SOXBxwdvMG/20Z+8YF?=
 =?us-ascii?Q?EjkF8uOmRM7mzQCz4U93T8jiFgPUnWFPwYGA6oahnO/sJ/0Ipn9Fddw5P9Ja?=
 =?us-ascii?Q?ujja6WbtzfrEX9Cawy51r/M6i7UvmViAoVznycPYdHCEv9cQw3q+Wwz+8Wuz?=
 =?us-ascii?Q?/SKzeq+MPxvaG+Eq0KdYp6kuHKlLXSK2krMBvHnFHs8P01gpI/HFKGVsv0TQ?=
 =?us-ascii?Q?QRKyCnf23sFrue2KXa8DhJTj0TFuu+rj9luwZJkeoYU7yTwPUBWzOCHMK7Bf?=
 =?us-ascii?Q?m2yh9z/590V6MzMoD3k6/DJjqnWntmw3dSzITJmXtEwx0CZoIUKTsciJXXwW?=
 =?us-ascii?Q?gHtf+JaKQb3ZOdPNCSNer+dV6K1bCQo/52e3SFVDIEgGB9yE6Cn+LKd0frnO?=
 =?us-ascii?Q?er47UPbiR/5aKFUo9n1XTH7V8T1PJjNyKXGRDiP8LaqL4D06ewBulKV4Tq5C?=
 =?us-ascii?Q?Grwqnx6iGRl4Zl727nQIQI1QeV+wa8ee8tz+5ECK1msWtNHD902oGlcN/OCi?=
 =?us-ascii?Q?f0hlMWz9LUhXYw2krdEKnjjhy5ShHOA3klG8leOeKZoLgRsqSOGBDFkrDHHe?=
 =?us-ascii?Q?sfpGEhOuhEDpJ6cMPkx48A0o1fsLvkOZoNQQTEld+1jhHgh5WcD+15oaBonF?=
 =?us-ascii?Q?wVnwWVBH0AuLMmM4q8QHClPUlRUBvtkloohZTVbgmZAWNkjIo1q+SYr/pi9/?=
 =?us-ascii?Q?TcL3vyTz29fV6sXGcDv7B6j6yKX9iCAQdR4Cdkp0mBYap77wWSAd/3VS9bdC?=
 =?us-ascii?Q?winflMYP1W03keWpxc2MZSTNSMxRjByP+u8t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 13:57:21.2736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4f8bab-3fe7-4f03-dcd9-08ddb7de08b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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

Pass amdgpu device context instead of drm device context to some
amdgpu_device_* functions. DRM device context is not required in those
functions. No functional change.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 24 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 65 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 15 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  4 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c         |  4 +-
 6 files changed, 57 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f9c981a3ea05..ebc1a2203492 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1583,16 +1583,16 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 
 int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
 int amdgpu_device_link_reset(struct amdgpu_device *adev);
-bool amdgpu_device_supports_atpx(struct drm_device *dev);
-bool amdgpu_device_supports_px(struct drm_device *dev);
-bool amdgpu_device_supports_boco(struct drm_device *dev);
-bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
-int amdgpu_device_supports_baco(struct drm_device *dev);
+bool amdgpu_device_supports_atpx(struct amdgpu_device *adev);
+bool amdgpu_device_supports_px(struct amdgpu_device *adev);
+bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
+bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
+int amdgpu_device_supports_baco(struct amdgpu_device *adev);
 void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev);
-int amdgpu_device_baco_enter(struct drm_device *dev);
-int amdgpu_device_baco_exit(struct drm_device *dev);
+int amdgpu_device_baco_enter(struct amdgpu_device *adev);
+int amdgpu_device_baco_exit(struct amdgpu_device *adev);
 
 void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
 		struct amdgpu_ring *ring);
@@ -1695,7 +1695,8 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 						u8 perf_req, bool advertise);
 int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 				    u8 dev_state, bool drv_state);
-int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_state);
+int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
+				   enum amdgpu_ss ss_state);
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
 			     u64 *tmr_size);
@@ -1726,8 +1727,11 @@ static inline void amdgpu_acpi_release(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
 static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 						  u8 dev_state, bool drv_state) { return 0; }
-static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
-						 enum amdgpu_ss ss_state) { return 0; }
+static inline int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
+						 enum amdgpu_ss ss_state)
+{
+	return 0;
+}
 static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps) { }
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index ae2d08cf027e..6c62e27b9800 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -811,18 +811,18 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 /**
  * amdgpu_acpi_smart_shift_update - update dGPU device state to SBIOS
  *
- * @dev: drm_device pointer
+ * @adev: amdgpu device pointer
  * @ss_state: current smart shift event
  *
  * returns 0 on success,
  * otherwise return error number.
  */
-int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_state)
+int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
+				   enum amdgpu_ss ss_state)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r;
 
-	if (!amdgpu_device_supports_smart_shift(dev))
+	if (!amdgpu_device_supports_smart_shift(adev))
 		return 0;
 
 	switch (ss_state) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 30173daeff85..154b1f18400a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -413,19 +413,16 @@ static const struct attribute_group amdgpu_board_attrs_group = {
 
 static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
 
-
 /**
  * amdgpu_device_supports_px - Is the device a dGPU with ATPX power control
  *
- * @dev: drm_device pointer
+ * @adev: amdgpu device pointer
  *
  * Returns true if the device is a dGPU with ATPX power control,
  * otherwise return false.
  */
-bool amdgpu_device_supports_px(struct drm_device *dev)
+bool amdgpu_device_supports_px(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
-
 	if ((adev->flags & AMD_IS_PX) && !amdgpu_is_atpx_hybrid())
 		return true;
 	return false;
@@ -434,15 +431,13 @@ bool amdgpu_device_supports_px(struct drm_device *dev)
 /**
  * amdgpu_device_supports_boco - Is the device a dGPU with ACPI power resources
  *
- * @dev: drm_device pointer
+ * @adev: amdgpu device pointer
  *
  * Returns true if the device is a dGPU with ACPI power control,
  * otherwise return false.
  */
-bool amdgpu_device_supports_boco(struct drm_device *dev)
+bool amdgpu_device_supports_boco(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
-
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
@@ -455,29 +450,24 @@ bool amdgpu_device_supports_boco(struct drm_device *dev)
 /**
  * amdgpu_device_supports_baco - Does the device support BACO
  *
- * @dev: drm_device pointer
+ * @adev: amdgpu device pointer
  *
  * Return:
  * 1 if the device supports BACO;
  * 3 if the device supports MACO (only works if BACO is supported)
  * otherwise return 0.
  */
-int amdgpu_device_supports_baco(struct drm_device *dev)
+int amdgpu_device_supports_baco(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
-
 	return amdgpu_asic_supports_baco(adev);
 }
 
 void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 {
-	struct drm_device *dev;
 	int bamaco_support;
 
-	dev = adev_to_drm(adev);
-
 	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
-	bamaco_support = amdgpu_device_supports_baco(dev);
+	bamaco_support = amdgpu_device_supports_baco(adev);
 
 	switch (amdgpu_runtime_pm) {
 	case 2:
@@ -497,10 +487,12 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 		break;
 	case -1:
 	case -2:
-		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
+		if (amdgpu_device_supports_px(adev)) {
+			/* enable PX as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
 			dev_info(adev->dev, "Using ATPX for runtime pm\n");
-		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
+		} else if (amdgpu_device_supports_boco(adev)) {
+			/* enable boco as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
 			dev_info(adev->dev, "Using BOCO for runtime pm\n");
 		} else {
@@ -549,14 +541,14 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
  * amdgpu_device_supports_smart_shift - Is the device dGPU with
  * smart shift support
  *
- * @dev: drm_device pointer
+ * @adev: amdgpu device pointer
  *
  * Returns true if the device is a dGPU with Smart Shift support,
  * otherwise returns false.
  */
-bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
+bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev)
 {
-	return (amdgpu_device_supports_boco(dev) &&
+	return (amdgpu_device_supports_boco(adev) &&
 		amdgpu_acpi_is_power_shift_control_supported());
 }
 
@@ -2202,7 +2194,8 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	int r;
 
-	if (amdgpu_device_supports_px(dev) && state == VGA_SWITCHEROO_OFF)
+	if (amdgpu_device_supports_px(drm_to_adev(dev)) &&
+	    state == VGA_SWITCHEROO_OFF)
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
@@ -4194,13 +4187,13 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 	if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
 
 		task_barrier_enter(&hive->tb);
-		adev->asic_reset_res = amdgpu_device_baco_enter(adev_to_drm(adev));
+		adev->asic_reset_res = amdgpu_device_baco_enter(adev);
 
 		if (adev->asic_reset_res)
 			goto fail;
 
 		task_barrier_exit(&hive->tb);
-		adev->asic_reset_res = amdgpu_device_baco_exit(adev_to_drm(adev));
+		adev->asic_reset_res = amdgpu_device_baco_exit(adev);
 
 		if (adev->asic_reset_res)
 			goto fail;
@@ -4355,7 +4348,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 int amdgpu_device_init(struct amdgpu_device *adev,
 		       uint32_t flags)
 {
-	struct drm_device *ddev = adev_to_drm(adev);
 	struct pci_dev *pdev = adev->pdev;
 	int r, i;
 	bool px = false;
@@ -4816,7 +4808,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
-	px = amdgpu_device_supports_px(ddev);
+	px = amdgpu_device_supports_px(adev);
 
 	if (px || (!dev_is_removable(&adev->pdev->dev) &&
 				apple_gmux_detect(NULL, NULL)))
@@ -4982,7 +4974,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	kfree(adev->xcp_mgr);
 	adev->xcp_mgr = NULL;
 
-	px = amdgpu_device_supports_px(adev_to_drm(adev));
+	px = amdgpu_device_supports_px(adev);
 
 	if (px || (!dev_is_removable(&adev->pdev->dev) &&
 				apple_gmux_detect(NULL, NULL)))
@@ -5155,7 +5147,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 			return r;
 	}
 
-	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
+	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
 		dev_warn(adev->dev, "smart shift update failed\n");
 
 	if (notify_clients)
@@ -5324,7 +5316,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	}
 	adev->in_suspend = false;
 
-	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
+	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0))
 		dev_warn(adev->dev, "smart shift update failed\n");
 
 	return 0;
@@ -6369,7 +6361,8 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
 		} else {
 			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
-			if (amdgpu_acpi_smart_shift_update(adev_to_drm(tmp_adev), AMDGPU_SS_DEV_D0))
+			if (amdgpu_acpi_smart_shift_update(tmp_adev,
+							   AMDGPU_SS_DEV_D0))
 				dev_warn(tmp_adev->dev,
 					 "smart shift update failed\n");
 		}
@@ -6837,12 +6830,11 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 #endif
 }
 
-int amdgpu_device_baco_enter(struct drm_device *dev)
+int amdgpu_device_baco_enter(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	if (!amdgpu_device_supports_baco(dev))
+	if (!amdgpu_device_supports_baco(adev))
 		return -ENOTSUPP;
 
 	if (ras && adev->ras_enabled &&
@@ -6852,13 +6844,12 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 	return amdgpu_dpm_baco_enter(adev);
 }
 
-int amdgpu_device_baco_exit(struct drm_device *dev)
+int amdgpu_device_baco_exit(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int ret = 0;
 
-	if (!amdgpu_device_supports_baco(dev))
+	if (!amdgpu_device_supports_baco(adev))
 		return -ENOTSUPP;
 
 	ret = amdgpu_dpm_baco_exit(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b299e15bb5e5..4f8632737574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2457,10 +2457,10 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		/* only need to skip on ATPX */
-		if (amdgpu_device_supports_px(ddev))
+		if (amdgpu_device_supports_px(adev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		/* we want direct complete for BOCO */
-		if (amdgpu_device_supports_boco(ddev))
+		if (amdgpu_device_supports_boco(adev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
@@ -2493,9 +2493,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		 * into D0 state. Then there will be a PMFW-aware D-state
 		 * transition(D0->D3) on runpm suspend.
 		 */
-		if (amdgpu_device_supports_baco(ddev) &&
+		if (amdgpu_device_supports_baco(adev) &&
 		    !(adev->flags & AMD_IS_APU) &&
-		    (adev->asic_type >= CHIP_NAVI10))
+		    adev->asic_type >= CHIP_NAVI10)
 			amdgpu_get_secondary_funcs(adev);
 	}
 
@@ -2560,8 +2560,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(drm_dev) &&
-	    pm_runtime_suspended(dev))
+	if (amdgpu_device_supports_boco(adev) && pm_runtime_suspended(dev))
 		return 1;
 
 	/* if we will not support s3 or s2i for the device
@@ -2834,7 +2833,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		/* nothing to do */
 	} else if ((adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) ||
 			(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)) {
-		amdgpu_device_baco_enter(drm_dev);
+		amdgpu_device_baco_enter(adev);
 	}
 
 	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
@@ -2875,7 +2874,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		pci_set_master(pdev);
 	} else if ((adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) ||
 			(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)) {
-		amdgpu_device_baco_exit(drm_dev);
+		amdgpu_device_baco_exit(adev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 5d38276fc900..4aab5e394ce2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -91,7 +91,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 	if (adev->rmmio == NULL)
 		return;
 
-	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_UNLOAD))
+	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_UNLOAD))
 		DRM_WARN("smart shift update failed\n");
 
 	amdgpu_acpi_fini(adev);
@@ -161,7 +161,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	if (acpi_status)
 		dev_dbg(dev->dev, "Error during ACPI methods call\n");
 
-	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_LOAD))
+	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_LOAD))
 		DRM_WARN("smart shift update failed\n");
 
 out:
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5537dcf23b5c..c2fde0e33b38 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1897,7 +1897,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 				uint32_t mask, enum amdgpu_device_attr_states *states)
 {
-	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
+	if (!amdgpu_device_supports_smart_shift(adev))
 		*states = ATTR_STATE_UNSUPPORTED;
 
 	return 0;
@@ -1908,7 +1908,7 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 {
 	uint32_t ss_power;
 
-	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
+	if (!amdgpu_device_supports_smart_shift(adev))
 		*states = ATTR_STATE_UNSUPPORTED;
 	else if (amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
 		 (void *)&ss_power))
-- 
2.49.0

