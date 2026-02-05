Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D00E9126C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C7010E7D4;
	Thu,  5 Feb 2026 06:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GFAhFTqC";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4441910E7D2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EooKWViDnul59LniPZQeVptzoZWweSuCkRzedaWd1WCRtgOX1rHuLkdNikZ9Y3YmwFaz3isZeR2WnivEjFykxy6Smqu8GsAbGw82A5N4k6uftxsrzocvUV5zgMmjOi939EXht5bqzYpYNmuwNp66XgVOK2sTar5DuaM1KW3MXMsYANyIsQLQ+zop/7S/JUDoe3DHADbrXXMWm3i631UXoC6DDcHyGp56MhQX9fUcWDD4IPrFTfybqDVob7cfPssjwpc9TyqCo9sX72HpMCLFzEeyoEl2qXuoBUn+yMmd0dlUAyIsLJMX1rmkGPhiQujsnMhqrAb5nbldDDYIjGcZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATsstS6H8DZlk89Tp/m6Cqdm69OL7UzUjC8omxSRR/U=;
 b=F1CqWhNAZjiGOCc+eR2/BvyfsRlSFrbWejdrsfQcHf5lK3lh2k0NsqRnbQREyAwYsoYrX9t4KyfnKPcGYpVhgTyfabgVHuXqSpv9iDgXgG+YCaInFRNfBbcW96Vozez9w++VI0Nh14l5/JyU0PnQXRNMN/EFMpHEPRD/HCOxI3Pug+HtwPsURYEt2+8nIK/9A7SJGai+PUsTOw3Ni9Bx71AN/xx0Rx//uI0EQDdyfuJ6knCF8r7BqoBVTYzh9EcBKgswN8WBqWRWh10NfEGEg6sEiDYigwXO4p3Eu1+bGlomS8uOHD9CIh5T9nNGM8ybTdEHDmUvr/oY8gRZpr3Lbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATsstS6H8DZlk89Tp/m6Cqdm69OL7UzUjC8omxSRR/U=;
 b=GFAhFTqCXGff9mmHQwmJNakXJojnE0lGuKjZUROHAkJoCL4BLtJvYGpSRGBtiSa5cWAtgYjXm1TJxbElzwYhLHcrf4kHLmoGiFRmkrr3VtZVVpEy+0C6PN2X4CdHMITw92vRjZ/xtbhvblnCeedlh5diV4lFTJrSQCjAqq+8nYY=
Received: from PH7P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::19)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:52:13 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::b7) by PH7P221CA0047.outlook.office365.com
 (2603:10b6:510:33c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 06:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:52:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:52:07 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 20/22] drm/amdgpu: add amdgpu.ptl module parameter for PTL
 control
Date: Thu, 5 Feb 2026 14:51:28 +0800
Message-ID: <20260205065130.654921-20-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: e36fb01f-0eed-4153-218e-08de64831724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?umNJO0I75mgotYGsh3yLjufI401AVKbu8s36OUDQZZsJLFWAvF5hWXA4vbML?=
 =?us-ascii?Q?41uQaX88MpTFJW/UUIId6rr0jdBtZF1jZYNEs6j2VmfG9WSrewI+l4EOL6NP?=
 =?us-ascii?Q?z4ytgGgWrVoeW9yYG1mfPSyoMqJkZwgDyg0eDYdr7Tj56npvkCeQ8ByNE1bd?=
 =?us-ascii?Q?S5ACDR8rdMIrRaTem/oHddZ2RBVKyxXQMb3i/QpJfi+Gn9ISbYBm7VbpGzTc?=
 =?us-ascii?Q?EbanGTXXlwZ0H7H1rAQpFnq4WXiLkY+jygkC9F3wcavBEYLrXhrNvjIumFc/?=
 =?us-ascii?Q?/DTQJmYvj8cIBh+Y6DXHEycOexkcpaDLKsbujmxK49OxC2QTY2zeXLYOGVKT?=
 =?us-ascii?Q?iG/aQJShPXJFXaPs4FIjKscxvD7YZAkK0OQ2Egg5HkBQsEBMyBEu5R6GJaFi?=
 =?us-ascii?Q?zAEPrgEhqS97T8GI0LVgOe5mhdtdrGWLzv0lGM1ZgvZz4+pWlaFze8xdJ1Gc?=
 =?us-ascii?Q?5GVJFjE0stkOF6K1JgOFLWmrM6wk7rM/QdD5OYXu3c4KYLZQD4Dmz4Sfwnrx?=
 =?us-ascii?Q?y7hRY2o+hBkbbUb875WgUkHNCuWVE0nXWNBFl6YabyWTeTBJ3Z2Eof2bSdZj?=
 =?us-ascii?Q?30DDc9Qgtv4+45lNS96sSx65QJzc956MDuy790artGUPpc3hNLF44HKz5wZB?=
 =?us-ascii?Q?MCjPM0rcDjEzPXgMgUxh9fNpej93TNzQTUHRv3gjY6bxh+6c61Oou1XLkoIW?=
 =?us-ascii?Q?hB+BvElnaNCF0/7xtGOpYb9/rsug4CTuBSJF1la0UYyQ85MGsZYyTHPzRMql?=
 =?us-ascii?Q?T6o4W24pbh+9lq8mOrrcbH0f1XKq+iZ/L95BtG0bUYq2NKXdO1tDu3Hm2O9m?=
 =?us-ascii?Q?oLB/L5E/Sj2AEUaMWa3JfEG+ByIiR1qR3zxs4EGJVjRctnaWD3QTq64Kr24t?=
 =?us-ascii?Q?ItcEcosMqJZiG+4TH08pT4O/ilS1FcxTd0h/N7VKk44lz3f4TmBzWWeW7I3l?=
 =?us-ascii?Q?wcG3xOgtlNkQC5k5CBnIt+cyNfXSuyOdjkB49oRFO4M+XLgTv7wFSJeXphfh?=
 =?us-ascii?Q?+KopjgGnEhut4ugdCq5N/co65HrpNUJEEK7VmtvnPljhg2GDKpOtj+3iz5zW?=
 =?us-ascii?Q?iK8ToWF5UvlCjw0Hb6LT4lwwklbr65aVahkk5GFU7xeaO+4OfoppGNWJN0dD?=
 =?us-ascii?Q?YCCSFyP3c01WrTjiqESC/tS7qN1r5lnSWS6/yK0nTUCkivtCRZEstuNH53qc?=
 =?us-ascii?Q?UKU+tAqse99G7Kq9ZXTj9dPnX12J+EeOXo1lAJ8IIoFojDwQ7A2/9PZkcNTR?=
 =?us-ascii?Q?s6jThYIpSq4p208CgVazoo+mhczMQPdPnXSAh8aO5Okzq4nXP1kltneR6Kj0?=
 =?us-ascii?Q?lctVx6hVIz0dACUokyzAmS/HUBcdTE8L3GFOpdcT/FVL8sQMVN5yIXLNu8nW?=
 =?us-ascii?Q?LiStBRNi1vPtuid1uZM9khU/ZPoDTDUpGSCvbU3ZHwzjpcjQRH9cyJroKvR4?=
 =?us-ascii?Q?4YJlNJ0Wl4pON7/R91uCDIfWn2SaDarboFTtatXk/lBth1NxeceoDXOL2Rut?=
 =?us-ascii?Q?R5/LY7QJhnYcs7EohW1iOxh0pffiQzmmAVDXeyT9SqMMlPhJT7nPryS+Kf5K?=
 =?us-ascii?Q?7uG+zr1Rl+LHl/w3va8xED5Us9uG7K0MRQH5Ju8mEAhHogE89J+B9uFJE4bx?=
 =?us-ascii?Q?+3fQEyrRXns+ZbymTmVkCmav8X9PznhmyJdxk2sad8qniWWa1fdBaWzvho67?=
 =?us-ascii?Q?smhSKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +IMn/7Ex9cCDDa9iYHhBnkHjAB4v8DX9POAQiB9Qb6MWTuz2OiOazlaLatVd/p47BX4bKZQsz2JjurfJrdr6ezgmBiLSnTh4OQbdGV7z8ZGHTT+pZ8vX96mhCu/t3ouV+B1wR0OdoJt8Nf67psCxQ1wYxvz+BJJF8XN2jYOvmpoPJ/f+s3ZKW3SBBhR8JjBzH4IQppiwnRG25qrXoAKgc7UNQxtvK2BQERE54QetUlVydAXzI9MS03HBBA+UBFmzrQj83WbQ0gU8JiNW8mIiwBuwhhHGWVml7EpiIGPYaCl4TgtxO51fzvc+V+4Yn7QKlrce8FlFmAG05kvONAy4cv7kd1aaYpNRmdRkThuair9tfgdog4OPX3yJ34l/9FsN8dIpRaf1xpqeUFSbAvhRNvBFkceayUD1dKThgI/nAc/dlMVKt0o+m0mu+UUWaypD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:52:12.4046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36fb01f-0eed-4153-218e-08de64831724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

Add a new kernel module parameter 'amdgpu.ptl' to allow
users to enable or disable PTL feature at driver loading time.

Parameter values:
  *) 0 or -1: disable PTL (default)
  *) 1: enable PTL
  *) 2: permanently disable PTL

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 28 ++++++++++++++++++++++++-
 5 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index af4042387f3b..23c58361b4d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -268,6 +268,7 @@ extern int amdgpu_rebar;
 
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
+extern int amdgpu_ptl;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95d26f086d54..482fa222292e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -248,6 +248,7 @@ int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
+int amdgpu_ptl = -1; /* auto */
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1134,6 +1135,18 @@ module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
 module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
 
+/**
+ * DOC: ptl (int)
+ * Enable PTL feature at boot time. Possible values:
+ *
+ * - -1 = auto (ASIC specific default)
+ * -  0 = disable PTL (default)
+ * -  1 = enable PTL
+ * -  2 = permanently disable PTL (cannot be re-enabled at runtime)
+ */
+MODULE_PARM_DESC(ptl, "Enable PTL (-1 = auto, 0 = disable (default), 1 = enable, 2 = permanently disable)");
+module_param_named(ptl, amdgpu_ptl, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3d7c1a788cf6..dfda694aefe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1296,6 +1296,9 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 	psp = &adev->psp;
 	ptl = &psp->ptl;
 
+	if (ptl->permanently_disabled && *ptl_state == 1)
+		return 0;
+
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) ||
 			psp->sos.fw_version < 0x0036081a)
 		return -EOPNOTSUPP;
@@ -1364,7 +1367,6 @@ static ssize_t ptl_enable_store(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct psp_context *psp = &adev->psp;
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	uint32_t ptl_state, fmt1, fmt2;
 	int ret;
@@ -1381,6 +1383,12 @@ static ssize_t ptl_enable_store(struct device *dev,
 		return -EINVAL;
 	}
 
+	/* Block enable when permanently disabled */
+	if (ptl->permanently_disabled) {
+		mutex_unlock(&ptl->mutex);
+		return -EPERM;
+	}
+
 	fmt1 = ptl->fmt1;
 	fmt2 = ptl->fmt2;
 	ptl_state = enable ? 1 : 0;
@@ -1410,9 +1418,12 @@ static ssize_t ptl_enable_show(struct device *dev, struct device_attribute *attr
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct psp_context *psp = &adev->psp;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 
-	return sysfs_emit(buf, "%s\n", psp->ptl.enabled ? "enabled" : "disabled");
+	if (ptl->permanently_disabled)
+		return sysfs_emit(buf, "permanently disabled\n");
+
+	return sysfs_emit(buf, "%s\n", ptl->enabled ? "enabled" : "disabled");
 }
 
 static ssize_t ptl_format_store(struct device *dev,
@@ -1421,7 +1432,6 @@ static ssize_t ptl_format_store(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct psp_context *psp = &adev->psp;
 	char fmt1_str[8], fmt2_str[8];
 	enum amdgpu_ptl_fmt fmt1_enum, fmt2_enum;
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2de7815c7516..1d4e53ddd38b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -394,6 +394,7 @@ struct amdgpu_ptl {
 	enum amdgpu_ptl_fmt		fmt2;
 	bool				enabled;
 	bool				hw_supported;
+	bool				permanently_disabled;
 	/* PTL disable reference counting */
 	atomic_t			disable_ref;
 	struct mutex			mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 13933e3ee096..e0782ed149e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2401,6 +2401,32 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool sta
 	return 0;
 }
 
+static int gfx_v9_4_3_ptl_hw_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	bool enable;
+
+	switch (amdgpu_ptl) {
+	case 1:
+		enable = true;
+		break;
+	case 2:
+		/* Permanently disabled - cannot be re-enabled */
+		enable = false;
+		ptl->permanently_disabled = true;
+		break;
+	case -1:
+	case 0:
+	default:
+		enable = false;
+		break;
+	}
+
+	gfx_v9_4_3_perf_monitor_ptl_init(adev, enable ? 1 : 0);
+
+	return 0;
+}
+
 static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2583,7 +2609,7 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 	    adev->gfx.ras->enable_watchdog_timer)
 		adev->gfx.ras->enable_watchdog_timer(adev);
 
-	gfx_v9_4_3_perf_monitor_ptl_init(adev, 1);
+	gfx_v9_4_3_ptl_hw_init(adev);
 
 	return 0;
 }
-- 
2.34.1

