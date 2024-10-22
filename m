Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D9CD1CDAB
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 07:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125DE10E5FE;
	Tue, 22 Oct 2024 07:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZ/Zpmtk";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D7E10E5FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 07:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPY2dzSND5YXk5IE7utNgOIVqm2dLeoTVTbWXCDhFU8TqPB2SBZnDhv1+zw3JQ88X8z107zMlweUmH9KEAyK9ow1L0H47/QlKaaKwN9Fw/mFOBwetmSup+6HvMwCcMK3L2Ic/d0u/pPGQMS3D96TQj9mIPCeGQyAxEml6pxZjN5O53tE7MS7NGZ0vbFZNQptFSHWgge6XDsefkouHP1sqWChOniwzet84VyTV1DPMUMmJutU5tQbHUlhglGeISZDfhHv41RpIrZMI4Z1MrOwqdB75HupLtF4qJEyrmIrOGtMSsaJplV44vFO8Xnz+6wuQ8iFCQd6huFsLzblwoUW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rwPBCUFjdfA+76c2Yrd6MbI0NFsiwCp5pRwh0W2cc4=;
 b=CYZXESOOVfpBnr6u4JAO1SsCyzIGf60dpev3lMXTxgagZyTS2sq0XyTIaVb02amILAw0hc/Olc7pI1y580K4zJ0w88PVm+RWWzXC/eCWnMZAYWZftq/24Rxd2lGLYbBQZhK2QvzbfDEHD4CrT6O1zcZtb8c5WTcCTz++Jwx/JRYKjhF08ouX7bgYRJ7fDWJIJ7pKpPTbUyvq2zWR53acILhtm4esb8NE8OccricQp2YhE4luawuxq4NR8OdbWw7iMQWwKI3Vc423nt83ctD48RFe1hUBMYzirl0y4j42HzhXkg5Hb9Zgp1wrdOT0w0kxUnAWDhbpRZ93NSFwGD62sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rwPBCUFjdfA+76c2Yrd6MbI0NFsiwCp5pRwh0W2cc4=;
 b=dZ/ZpmtkoO4wECLEYcRLlJ0owNIhOexVJKgFWzk6567oXPpMmeABlFMmYLjHaC1tVZIfyh4AlORQqZvEJuW9lhahSrXv3uvs7ZpW0V5QagAnjrxFKPWZaW+aB6MuSHro2co7U0XSrr3FBHNHzDSiFEKWaheJ35VTTM8UN1D0JE0=
Received: from BN9P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::8)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 07:59:17 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::63) by BN9P221CA0017.outlook.office365.com
 (2603:10b6:408:10a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 07:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 07:59:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 02:59:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 02:59:16 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 02:59:10 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Date: Tue, 22 Oct 2024 15:59:05 +0800
Message-ID: <20241022075909.2530386-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0e2aa3-67bd-4406-8f1e-08dcf26f6d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r/oUbL3FZX5PYGsR4lyx0LxBVxE2d6wrrzEF4lh0pIKMVo3uvZhXNxDmfd6T?=
 =?us-ascii?Q?MXyVhnp3I7p960VrAsmOzZFpoq8JaLHh3YnGVYEnXsRCceNypTTk1MyLcdCW?=
 =?us-ascii?Q?afXIBs3CZxiq8i8Z6QaoRg65+Xvw7acZPSpvN9ZVpyeua0JGWlWa1MQaMdxa?=
 =?us-ascii?Q?jb0FnyYtYWvO8d6jydmJ9ONbrFZyN5m0CZH6jsAg01F4RMrwboe8SyPKPE7T?=
 =?us-ascii?Q?tW8bXU7OOUIm8Fk/PuB8DCDE+3ijHz1fph+ssul/3m9kDIWxP4zvqeNAD2yw?=
 =?us-ascii?Q?/wTZw2t67FmNn6ox+llTaM0ZSccCqFwfu5G1vRfTUh2DYaIKchqqS9k5nnaQ?=
 =?us-ascii?Q?xvV7SLB1VCKKnTwzTTK4DFefrfHiN8rIgE6mXx5trKDIpTa/Gf8UgMUcUqN0?=
 =?us-ascii?Q?ZWQci+cY/W4WI5pjoOLp9CAPuF08jFMb2CBg5qJ/GFLuPpRzALRyNOv6+aEM?=
 =?us-ascii?Q?cYNTvjXYf7u2dwT74f9DLe6YJZ0+0C+RNPBNknoeytjbuTUWz0IRQ9sTenuR?=
 =?us-ascii?Q?hblBllkYRhlcRrBcwEy1aOgn4NIkqMq2mYi0cu7mJFckhfqiA7GDMoi2dtWs?=
 =?us-ascii?Q?ZbXzZ1wQ0IV4N+E5z+qZTJgLNc42v/o6ofrZ7oGiFdoekkYCGy6eeXp9AEVK?=
 =?us-ascii?Q?9si5eFjVNByfuA9s2QGOYASMKXhuQscET0T09/uHFv6RgitmxZqfuiHIgEoc?=
 =?us-ascii?Q?pAasr9PDbH8KK8GOpGVX9yJcIOl/CUarWEciTiUr74UkloHYqOtEx3+dq6Ca?=
 =?us-ascii?Q?dQWzoQupalDDllFI+Bim4TNp6Q345wFNAsC261p4OOVaNI71GNXTgZcaM5Gd?=
 =?us-ascii?Q?NzF3yVijumFX3BYQ4EbMhwNQhiwaZZhvHHCnhXMDHk7TKR26xNg7ILp33h8E?=
 =?us-ascii?Q?feUYdf3pjgrACC+J5RUTV9WuJQ0xsftOZATk3liyDveCSptm6pSRqQUrpkPM?=
 =?us-ascii?Q?++9B012TcP7V3UkTJD/0UGzcFexu774AWEA104CbEHVDOnvmXk/xVKDbLC5e?=
 =?us-ascii?Q?et94QwYcQYgtF8HzbxnpR4AUYXNBaWM+T/YSNPdApi1zNelv9LFta7Rn+ci8?=
 =?us-ascii?Q?dkF67YN1HbSD7QTC39PK1o1/iSgW+G20m2dtsiXGBWCGQrj+z8mlbRfDABYF?=
 =?us-ascii?Q?wS+AmyBCT4XtaPR29TRmONmAbYIIru4DdE49YazrUlDMpDhNaby/UGsG/Kf4?=
 =?us-ascii?Q?1iIXsi0xOSduUtKKpdfYxz04WqQu9ZLNBWqH6czTuRhr1x1siWG4NX+TgEaH?=
 =?us-ascii?Q?bCTV3MJgNB4HQmN9hHbfgmhqbdxaQTnnF9vSKHq66hKxAuCy1rNM5FBhCGnu?=
 =?us-ascii?Q?BSy0TQuF0mT8Lv76ShJ+dcNmZ4mJow0FkDSQDmXkHr2SO6K9UTx0l88rHBUQ?=
 =?us-ascii?Q?qG4ZuBVgxxTLAWJ4dtyl4vB8TCpqtAvOW7MCPdr+4rG8Sel11A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:59:17.3476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0e2aa3-67bd-4406-8f1e-08dcf26f6d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
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

Add two sysfs interfaces for gfx and compute:
gfx_reset_mask
compute_reset_mask

These interfaces are read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 122 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |   6 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |   5 +
 8 files changed, 156 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..0dd475c30267 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -300,6 +300,12 @@ extern int amdgpu_wbrf;
 #define AMDGPU_RESET_VCE			(1 << 13)
 #define AMDGPU_RESET_VCE1			(1 << 14)
 
+/* reset mask */
+#define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset, mode1/mode2/BACO/etc. */
+#define AMDGPU_RESET_TYPE_SOFT_RESET (1 << 1) /* IP level soft reset */
+#define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2) /* per queue */
+#define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe */
+
 /* max cursor sizes (in pixels) */
 #define CIK_CURSOR_WIDTH 128
 #define CIK_CURSOR_HEIGHT 128
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..b4706355ece8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1588,6 +1588,94 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	return count;
 }
 
+static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = &adev->gfx.gfx_ring[0];
+
+	if (!adev || !ring)
+		return -ENODEV;
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		size |= AMDGPU_RESET_TYPE_FULL;
+
+	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
+			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
+		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
+
+	if (amdgpu_gpu_recovery && ring->funcs->reset) {
+                switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+                case IP_VERSION(9, 2, 2): //reven2
+                case IP_VERSION(9, 3, 0): //renior
+                case IP_VERSION(9, 4, 0): //vega20
+                case IP_VERSION(10, 1, 0): //navi10
+                case IP_VERSION(10, 1, 1): //navi12
+                case IP_VERSION(10, 1, 2): //navi13
+                        /* Skip flag setting because some cases
+                         * are not supported by current firmware.
+                         */
+                        break;
+
+                default:
+                        size |= AMDGPU_RESET_TYPE_PER_QUEUE;
+                        break;
+		}
+        }
+
+	size = sysfs_emit_at(buf, 0, "%lu\n", size);
+	return size;
+}
+
+static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
+
+	if (!adev || !ring)
+		return -ENODEV;
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		size |= AMDGPU_RESET_TYPE_FULL;
+
+	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
+			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
+		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
+
+	if (amdgpu_gpu_recovery && ring->funcs->reset) {
+                switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+                case IP_VERSION(9, 2, 2): //reven2
+                case IP_VERSION(9, 3, 0): //renior
+                case IP_VERSION(9, 4, 0): //vega20
+                case IP_VERSION(10, 1, 0): //navi10
+                case IP_VERSION(10, 1, 1): //navi12
+                case IP_VERSION(10, 1, 2): //navi13
+                        /* Skip flag setting because some test cases
+                         * are not supported by current firmware.
+                         */
+                        break;
+
+                default:
+                        size |= AMDGPU_RESET_TYPE_PER_QUEUE;
+                        break;
+		}
+        }
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+			adev->gfx.mec_fw_version >= 0x0000009b)
+		size |= AMDGPU_RESET_TYPE_PER_PIPE;
+
+	size = sysfs_emit_at(buf, 0, "%lu\n", size);
+	return size;
+}
+
 static DEVICE_ATTR(run_cleaner_shader, 0200,
 		   NULL, amdgpu_gfx_set_run_cleaner_shader);
 
@@ -1602,6 +1690,12 @@ static DEVICE_ATTR(current_compute_partition, 0644,
 static DEVICE_ATTR(available_compute_partition, 0444,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
+static DEVICE_ATTR(gfx_reset_mask, 0444,
+		   amdgpu_gfx_get_gfx_reset_mask, NULL);
+
+static DEVICE_ATTR(compute_reset_mask, 0444,
+		   amdgpu_gfx_get_compute_reset_mask, NULL);
+
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
@@ -1702,6 +1796,34 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 			    cleaner_shader_size);
 }
 
+int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->gfx.num_gfx_rings) {
+		r = device_create_file(adev->dev, &dev_attr_gfx_reset_mask);
+		if (r)
+			return r;
+	}
+
+	if (adev->gfx.num_compute_rings) {
+		r = device_create_file(adev->dev, &dev_attr_compute_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->gfx.num_gfx_rings)
+		device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
+
+	if (adev->gfx.num_compute_rings)
+		device_remove_file(adev->dev, &dev_attr_compute_reset_mask);
+}
+
 /**
  * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD (Graphics Driver)
  * @adev: amdgpu_device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f710178a21bc..0cf2151b3cf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -582,6 +582,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
+int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..2baa76095232 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4856,6 +4856,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
 	if (r)
 		return r;
+
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -4908,6 +4913,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v10_0_free_microcode(adev);
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..32d14b9cc6e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1721,6 +1721,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1783,6 +1787,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v11_0_free_microcode(adev);
 
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..925b7ca49b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1470,6 +1470,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1530,6 +1534,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v12_0_free_microcode(adev);
 
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b4c4b9916289..0de199c1cfdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2394,6 +2394,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -2432,6 +2436,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v9_0_free_microcode(adev);
 
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..87cfd77e2fb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1175,6 +1175,10 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1200,6 +1204,7 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v9_4_3_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
-- 
2.25.1

