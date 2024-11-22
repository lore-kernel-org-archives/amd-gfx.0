Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA674E69190
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 19:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F7710EC64;
	Fri, 22 Nov 2024 19:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sT329w5e";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 901A110EC5A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 19:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBmQPIW99VqYpHXNBKN/Zh0Y0eVF9TiR3qvB6XANBEl5uJ4j1YWFSsZqRvX2/2Jul9JqCmQ0ooAR8JhfMWeHyzM/x3rmANwSM9Jfw9Uh1mT9YAA6P1lgV8BWZkqGLOADXJVXovQPj48WLuaiuDsNzU1a/fiXUrEs5NG+fiF+4y40is46536he/c8ibjL2dgrq1xFyv6VtMHblagq96JvkPpPB0Ykhg1tRs1pNxSJO9tueFA18ExVNmTu3LmmMJ0cVJlEvvKXnuR99HWaB54yv7Z0pSZv82LtgSnOfHkkq2WmCJXQk/o5XX2EKqID7uefyf/C7xO+LZzjEeBiqwcfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFY00ole2n0H4fI1pS4VB+8e3/Yjo81GitQQ7GXMR8k=;
 b=Xg5UdZsZYzJAPzYYQ+dkh5tbwbqtgOrTHYFKqTc9URnMqK+4XqBO+mrFyjzLvBDRWF5iVtMu3GFn6CGCgYMv1bVsYgYz8nSLuZN+MfCzlf836pTmJlsrrcdVDyNUzrqaGQdK4bmi/ZEgId3Kp8WJo/f0nqYSCsyyZR4j2keHnuUod5q8UTOshq1FRx/QdDi8w77qaDBmeKHlC+esb5ZZeMknAvRRxJPWWaoLC2w/5WIr2uE08W8h0VEy5ZI/hSPMQHmtIyQqstAmPcwWlBe4laDb+5qpevFHLgnWJ1LBdZccbqQdsx9TYgRtTKr0tUlzuTcUXLWC6umG+C1tsjh7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFY00ole2n0H4fI1pS4VB+8e3/Yjo81GitQQ7GXMR8k=;
 b=sT329w5e3mYNV8LFoVCIa+QmTkO0JASqjmgVYrVz0meZD19A6MKM8JtyCtm1qzsiA6EOqHFAMZqFKuuu7xZuoHZUC0RZQDqTpmXONwcLIXcRM/zVVCL2ypVmXaWIPRq4055qrWIqfmZDa4njvOKt0Eusc1Y4O7ABBps/f0jUihk=
Received: from DS7PR06CA0028.namprd06.prod.outlook.com (2603:10b6:8:54::33) by
 CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.18; Fri, 22 Nov 2024 19:06:43 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::7d) by DS7PR06CA0028.outlook.office365.com
 (2603:10b6:8:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Fri, 22 Nov 2024 19:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 19:06:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 13:06:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/3] drm/amd: Add Suspend/Hibernate notification callback
 support
Date: Fri, 22 Nov 2024 13:06:25 -0600
Message-ID: <20241122190626.19305-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122190626.19305-1-mario.limonciello@amd.com>
References: <20241122190626.19305-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 03795f50-ae5c-4d28-4d27-08dd0b28cd8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5DdQuy/YHxBam4uHBYe9NwzvQu29b9wB/1fjN+cWQMAvLXq00tpjubgkZwvE?=
 =?us-ascii?Q?s8ou3iKgahjRx6B9bCyBPy/zFIZg1e2kVU9I4OrucY+tywGB033pnnQ56EyK?=
 =?us-ascii?Q?7++knB1dEeCgcIb30TLiAfazVbL5ANdcNdAiVcHLbStqoxGaf7sA54rJPFiv?=
 =?us-ascii?Q?LTnYDc2Ii2wlSonZOGFidsZlj+VgBwLEexDeMg0jVqCU8RpuLd6PSbL9UXve?=
 =?us-ascii?Q?rXsKc0cEwj2T6nLmzTHviK2L5ramZ88qUdl8yxt9wJaY+NazM3NIB7QgStxk?=
 =?us-ascii?Q?S1meZEG8aXnXYEmcL7r3bHX/DVMfVl9cR0uv7+YJXtUgeg2QjGcL0UMDPejb?=
 =?us-ascii?Q?ihy1wFp20xCpl13JnQMXNAwylA1EBr8Kp9onbNRikQK3NAqK0bdkRZPuuBlN?=
 =?us-ascii?Q?xAQ4gnxlCAUsnUJMsB7wKA1b3fRvNhji8KocKr1i2FFf2USb7jNeTA64c8QT?=
 =?us-ascii?Q?S9Hb01VGnU908ooFmQaYzFNNCH7sLEMtkyA9UGBM1WafZDe+m/J+K0istC9M?=
 =?us-ascii?Q?K1DAP8FW/ZhXyGfS3CAOzESl6CGFOvDYbk/hbKU0bbc9kof87k1HsWaPEppX?=
 =?us-ascii?Q?I11GNi6mOi3GtEcBW4U+BGqwhYu7jsABpCqSdI+nDHR+Bsi9Hv0nGvjYMFN7?=
 =?us-ascii?Q?7VBbKwTTTtM48VG/lQpeydt35V9mST7PQeIm8YpZ2RVx+u70PG2XFCgg3exD?=
 =?us-ascii?Q?Rg6hMDaB6zy6fukyVQ3UyvmLtnGBXo5ZSCMFwcYiBuaqQJHgnBtp3jZoSaLd?=
 =?us-ascii?Q?L3XRWKS9lac4Z/V2h7O67zXdE5Me37ZgIPrmQQlOHPTIa7Trr9TugQV2n93Y?=
 =?us-ascii?Q?OW0YhY5QZ/b9mKQrN82K9+Y13jnc9FdSuWFn9KR/OH9Br2RzEJk02n6Tj+K8?=
 =?us-ascii?Q?hoY2RPj4xBYJF8Lkgeyg2xTgUCJ7f2eAsdKnZfAqYrfEyLN9HTqdJIAGHhjR?=
 =?us-ascii?Q?1CvwpRuLfktNFsym2bcFvj6Ywu2rp7eSGdc0SEbCBOyOo/UuvNHDf1ojW4lr?=
 =?us-ascii?Q?upUJBZPh/XFRMB5oOGYSMorTJxCszRFVvaIhCpa/cJizIOABb2OkamT/lIbP?=
 =?us-ascii?Q?LGDGYQ/vKQHmMZlsjV0740IEZQXptM2TEvQWJSThIy0yrVBvAwSeFHx4E/Xk?=
 =?us-ascii?Q?vBP7405/EME4mmPflCquLlRR7VRB9B+gDL+wGoz9tIs5E1VXtNNcRbuYLEDS?=
 =?us-ascii?Q?d8QHlhGkMO+lH71DwK7VS7ozW2C1S9OD7r/GhA6vPCiDhUZhwNuUnSFIavQD?=
 =?us-ascii?Q?gSg6x7I4/s0eKNnkewUx5J6oWghseeCgkO+kbG1v8oalLlFJkYYd54grwn/Z?=
 =?us-ascii?Q?lfaNxGyJCTq4c5RUucCFAMM8yXoYWwsFYDiAfDHfKXQkd769KlWiN/VT2pOA?=
 =?us-ascii?Q?se9/G8o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 19:06:43.0858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03795f50-ae5c-4d28-4d27-08dd0b28cd8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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

As part of the suspend sequence VRAM needs to be evicted on dGPUs.
In order to make suspend/resume more reliable we moved this into
the pmops prepare() callback so that the suspend sequence would fail
but the system could remain operational under high memory usage suspend.

Another class of issues exist though where due to memory fragementation
there isn't a large enough contiguous space and swap isn't accessible.

Add support for a suspend/hibernate notification callback that could
evict VRAM before tasks are frozen. This should allow paging out to swap
if necessary.

Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Drop A-b
 * Set adev->is_s4 for s4.
v2:
 * Collect tags
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9424974c662d..9ece32d284c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -886,6 +886,7 @@ struct amdgpu_device {
 	bool				need_swiotlb;
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
+	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
 	struct debugfs_blob_wrapper     debugfs_discovery_blob;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d511ba949dff..be87491d1851 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -198,6 +198,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
 }
 
 static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data);
 
 /**
  * DOC: pcie_replay_count
@@ -4562,6 +4564,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_check_iommu_direct_map(adev);
 
+	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
+	r = register_pm_notifier(&adev->pm_nb);
+	if (r)
+		goto failed;
+
 	return 0;
 
 release_ras_con:
@@ -4626,6 +4633,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		drain_workqueue(adev->mman.bdev.wq);
 	adev->shutdown = true;
 
+	unregister_pm_notifier(&adev->pm_nb);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 */
@@ -4757,6 +4766,37 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 /*
  * Suspend & resume.
  */
+/**
+ * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
+ * @nb: notifier block
+ * @mode: suspend mode
+ * @data: data
+ *
+ * This function is called when the system is about to suspend or hibernate.
+ * It is used to evict resources from the device before the system goes to
+ * sleep while there is still access to swap.
+ */
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data)
+{
+	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
+	int r;
+
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+		adev->in_s4 = true;
+		fallthrough;
+	case PM_SUSPEND_PREPARE:
+		r = amdgpu_device_evict_resources(adev);
+		adev->in_s4 = false;
+		if (r)
+			return NOTIFY_BAD;
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 /**
  * amdgpu_device_prepare - prepare for device suspend
  *
-- 
2.34.1

