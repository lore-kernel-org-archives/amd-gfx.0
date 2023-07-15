Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AFAC0015E
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Jul 2023 15:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0CF10E14C;
	Sat, 15 Jul 2023 15:26:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0668B10E14C
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jul 2023 15:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikt3Lmnrb1wS/jL4q3VsCyYaJRiK9Y9lZfb9XvlVYhufdJZykYMXDapmv7Ajgt6kibCeQ7SQif98m922ZzSyphCacZNolgwr+6BIzvxhZgsD2lp5CSG3e+vW9/EWAzsTaNHhjGkcyn18w5Fn4R9oY/6StvPW9CJQXCTxYEsnQzVcEi51JEe7PJlRbj7T4zvoQO3i9HNYi7aw5m8l62MKraNzHhygmjKZxmSJz4hGCjFFZJc9TP1X8VUHbZittoiHadpEhx0qhy0dA7sUX6+TIHhVP2HWQXNFiouOhhcsUMArNio9AjLp3v+6SBjtUMnjF/4OsP1QixOezYUooEuHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwSEPljTENT9m3PBBpVG45WjuqY4Z6hYUtLyN0asKjs=;
 b=ANWXCO17zgUjbLXRnhvUyXAT7yQP+ZWw5Dp1JJzymWB9Lxq35PC0c7HpkeILTDWPlvt7G9TmFUWI2Fnk+fCuY4R573EN5gHtlC2EdP+zbDJ2Jt2KoFqZHkE1/w2qShf58CkiIaL9NXSKZ8qs2L2s6fOl/6b/O3FoUUt17mBQHFce0g5CtMFqFOr2rcFSYgeWndg5Is430xKbMB9VHp1BZQi/YHaA6uY85ambc28l48iyZ2cBkcFrP9ujDyc0Vv8TnQ+CFzjLbEn4VFBI0ClqM6c/h6CLLJc61FKBvRNgfjvjmZag7VUdkK2RMIqTXt/QMWofRcIJ2bsdD9tkNhQuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwSEPljTENT9m3PBBpVG45WjuqY4Z6hYUtLyN0asKjs=;
 b=qlCRXOxNAKYic6iF7YtIq/JqiNKKxdw0OkD442sSFdX1nFfwjzcQ5Qpu6ZNLmVFHauPswVWC8+QSctzUDbLxLbHcWqIQR6+hngxNXHJ0IvBQxg2dijxc+i2azKtY+7QAyq/LTLoMv2Ec9VDBr0bv2U1MLT2R25GgrseQSIU5B34=
Received: from DS7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::11) by
 CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.28; Sat, 15 Jul 2023 15:26:36 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::4f) by DS7P222CA0009.outlook.office365.com
 (2603:10b6:8:2e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31 via Frontend
 Transport; Sat, 15 Jul 2023 15:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.28 via Frontend Transport; Sat, 15 Jul 2023 15:26:36 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 15 Jul
 2023 10:26:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/radeon: Avoid externs & do not initialize globals to 0 in
 radeon_drv.c
Date: Sat, 15 Jul 2023 20:56:18 +0530
Message-ID: <20230715152618.946712-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 75418db0-91f3-45fa-1b92-08db8547e09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faNFxQwZOZQMvc2BkGJ7PwyIYYKDGUvp59Rg3SEMp4EgcItl6d8T0aAPDnJqfP9waYNbFQF8qpWIJ+ygyMWYM1FWRm/1eytHI+DaAurDW4daOKJ3VxTRec1vXvE0jJAvoz1hu+AYw86Zbqz/x4CalUWvj9ftgvX9JuAtA70RU1/SPR6ivjtYAHccoR2fljns+XyOAEUpszwKKgVKhemtnRWhU+kKlc1t76KuwqGFRrbx+SL3kKmU+6PQZs38dRp3wrSC2qDlTwgZFZ33hHe/0ZSMRZqPt8gOa5Y0uzX4Cew3XXOHXyBs/gzCsMrLcnldfpzLI5VLBYnglMaXtZTa19AaivzrIRY1MFfWT+iVOQQo3po2tq/+HdMJrau5sOG39qhvSjAXJTZDTuRSmfEskzoVVjUxxOWSTqTSfb1cG8ewop+n9QI9VjOHAkzYuZ5CZ1jKKQL9vVb631G+UtClc17paGdf4NpRwqr1Wj3TqvzNFVDLVvNKGWpa9ZyjSHW5ubmclROAlRlKut3yiN9+5FQ7LupZjh5WZhfTTTFTDHFnC/g7YQojxX6wrrdfgY+9kVR9pLD6OUyXnVq0NUdGHXwQ3F5dacUG26xQTkCC0H9q9pfmlUgx4D+em1oeQ6b4q0qrBRAa+5MOjV4mup9V7gtqQZWXehSTWYn/UNIkvn8c9Te4OTQGxd5Ug+p9V6dx0lSxQAEO7SsXYe3vc65zcpdv9nbZ2fg5cW2O26cr7Uzf4kFKJJHGTtsFmpsoBDjwDgTSMQR+bMwp23m/eYFr1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(5660300002)(44832011)(8676002)(8936002)(40460700003)(356005)(316002)(81166007)(41300700001)(40480700001)(86362001)(2906002)(82740400003)(1076003)(26005)(6666004)(7696005)(2616005)(47076005)(83380400001)(66574015)(336012)(426003)(36756003)(16526019)(36860700001)(186003)(70586007)(478600001)(54906003)(110136005)(70206006)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 15:26:36.0062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75418db0-91f3-45fa-1b92-08db8547e09e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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

Fixes the following:

 - WARNING: externs should be avoided in .c files
 - ERROR: do not initialise globals to 0
 - WARNING: Missing a blank line after declarations

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 51 ++++++++---------------------
 drivers/gpu/drm/radeon/radeon_drv.h | 13 ++++++++
 2 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index e4374814f0ef..aa02697e5ea3 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -113,59 +113,32 @@
 #define KMS_DRIVER_MAJOR	2
 #define KMS_DRIVER_MINOR	50
 #define KMS_DRIVER_PATCHLEVEL	0
-int radeon_suspend_kms(struct drm_device *dev, bool suspend,
-		       bool fbcon, bool freeze);
-int radeon_resume_kms(struct drm_device *dev, bool resume, bool fbcon);
-extern int radeon_get_crtc_scanoutpos(struct drm_device *dev, unsigned int crtc,
-				      unsigned int flags, int *vpos, int *hpos,
-				      ktime_t *stime, ktime_t *etime,
-				      const struct drm_display_mode *mode);
-extern bool radeon_is_px(struct drm_device *dev);
-int radeon_mode_dumb_mmap(struct drm_file *filp,
-			  struct drm_device *dev,
-			  uint32_t handle, uint64_t *offset_p);
-int radeon_mode_dumb_create(struct drm_file *file_priv,
-			    struct drm_device *dev,
-			    struct drm_mode_create_dumb *args);
-
-/* atpx handler */
-#if defined(CONFIG_VGA_SWITCHEROO)
-void radeon_register_atpx_handler(void);
-void radeon_unregister_atpx_handler(void);
-bool radeon_has_atpx_dgpu_power_cntl(void);
-bool radeon_is_atpx_hybrid(void);
-#else
-static inline void radeon_register_atpx_handler(void) {}
-static inline void radeon_unregister_atpx_handler(void) {}
-static inline bool radeon_has_atpx_dgpu_power_cntl(void) { return false; }
-static inline bool radeon_is_atpx_hybrid(void) { return false; }
-#endif
 
 int radeon_no_wb;
 int radeon_modeset = -1;
 int radeon_dynclks = -1;
-int radeon_r4xx_atom = 0;
+int radeon_r4xx_atom;
 int radeon_agpmode = -1;
-int radeon_vram_limit = 0;
+int radeon_vram_limit;
 int radeon_gart_size = -1; /* auto */
-int radeon_benchmarking = 0;
-int radeon_testing = 0;
-int radeon_connector_table = 0;
+int radeon_benchmarking;
+int radeon_testing;
+int radeon_connector_table;
 int radeon_tv = 1;
 int radeon_audio = -1;
-int radeon_disp_priority = 0;
-int radeon_hw_i2c = 0;
+int radeon_disp_priority;
+int radeon_hw_i2c;
 int radeon_pcie_gen2 = -1;
 int radeon_msi = -1;
 int radeon_lockup_timeout = 10000;
-int radeon_fastfb = 0;
+int radeon_fastfb;
 int radeon_dpm = -1;
 int radeon_aspm = -1;
 int radeon_runtime_pm = -1;
-int radeon_hard_reset = 0;
+int radeon_hard_reset;
 int radeon_vm_size = 8;
 int radeon_vm_block_size = -1;
-int radeon_deep_color = 0;
+int radeon_deep_color;
 int radeon_use_pflipirq = 2;
 int radeon_bapm = -1;
 int radeon_backlight = -1;
@@ -384,6 +357,7 @@ radeon_pci_shutdown(struct pci_dev *pdev)
 static int radeon_pmops_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
 	return radeon_suspend_kms(drm_dev, true, true, false);
 }
 
@@ -404,12 +378,14 @@ static int radeon_pmops_resume(struct device *dev)
 static int radeon_pmops_freeze(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
 	return radeon_suspend_kms(drm_dev, false, true, true);
 }
 
 static int radeon_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
 	return radeon_resume_kms(drm_dev, false, true);
 }
 
@@ -494,6 +470,7 @@ long radeon_drm_ioctl(struct file *filp,
 	struct drm_file *file_priv = filp->private_data;
 	struct drm_device *dev;
 	long ret;
+
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/radeon/radeon_drv.h b/drivers/gpu/drm/radeon/radeon_drv.h
index 2ffe0975ee54..34a1c73d3938 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.h
+++ b/drivers/gpu/drm/radeon/radeon_drv.h
@@ -124,4 +124,17 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv);
 void radeon_driver_postclose_kms(struct drm_device *dev,
 				 struct drm_file *file_priv);
 
+/* atpx handler */
+#if defined(CONFIG_VGA_SWITCHEROO)
+void radeon_register_atpx_handler(void);
+void radeon_unregister_atpx_handler(void);
+bool radeon_has_atpx_dgpu_power_cntl(void);
+bool radeon_is_atpx_hybrid(void);
+#else
+static inline void radeon_register_atpx_handler(void) {}
+static inline void radeon_unregister_atpx_handler(void) {}
+static inline bool radeon_has_atpx_dgpu_power_cntl(void) { return false; }
+static inline bool radeon_is_atpx_hybrid(void) { return false; }
+#endif
+
 #endif				/* __RADEON_DRV_H__ */
-- 
2.25.1

