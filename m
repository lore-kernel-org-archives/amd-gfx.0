Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AF2E6916C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 15:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6D7110EBDF;
	Fri, 22 Nov 2024 15:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h4W9hiQO";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03B710EBDF
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 15:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuRDhNdY1E/dBh+rreRNqKNbWuXLvnuHMSdsJj7gNfPLhmkka4/PNkWxtvDx4p1DFz2LhJHm34B1oMmYxLSLw0QWyfIPDn10spBn1Q0urVY0I0fA2gScuulw+403BTKVsrBBJMtO6+WUE3/Hmtu5QwooTxUlG/gzePu5iDz6p1z/MJB0F0wJt4LwkePKOY8F10hPhklRPrCwBneQxv9dcK8hsvu29RDpeSrH8E6/HzUOwb0z80/ewwb09JSUpfRN61zxxbtBRd/kRoxmpm2/M/EAc+QPdbCrPzb9kq11JVT87HM22Xr687hM/MoA0i4eKeU8CM3GmL1Wou9CKPCiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt4fXw4UNNiUx0oMC8Fn0BwXGYsXRGx3CXrhnKpcE/A=;
 b=P7Qq4wiorH9nxbK+xv0yBJElMrbWzSdJREnYf4bO9yORBhJt5+dT9ozHAeIivnf4pxbuX4p5fMKSwdzb203Sbfx06JI7fui4YIj0NwCnSSGuWnbgdN+sVN7Ez9ltl/C3WNuWeQMsy2x/2UnG2eFnY6M+jnIOZE68ynK2tOsINLpKhV684QqJIs1amvijtug2IAMAaZbr+aIj8Yv32rDDwdNBqv1kBsZEgseLyD1nglTuzn46MffALwzOD59TdYJpz2pZNAtMFTg/+jP5ezf2SAuC7GWiyA9RCMfPnrTzXVz98cyjmpqZqmWi9zMtCACMgJJHu9N5xRayFot0aedvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt4fXw4UNNiUx0oMC8Fn0BwXGYsXRGx3CXrhnKpcE/A=;
 b=h4W9hiQOMpkB+hUeAveZNCCC49fHfmJZCS/hXNsTVijcrkTyvEfX52qp8Yl+Wd/iz19i9P5sSrZPQp2HGxnkFS5zdDzHOp1kS/tdoK0f1eXnXbSBsfWQCcV1tHA6YCVLMLpXuVDTl1d+KOmTQjybo9HHZ93Kc/5nciLmdpP/oVk=
Received: from MW4PR03CA0355.namprd03.prod.outlook.com (2603:10b6:303:dc::30)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 15:50:24 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::83) by MW4PR03CA0355.outlook.office365.com
 (2603:10b6:303:dc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Fri, 22 Nov 2024 15:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 15:50:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 09:50:22 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v2 2/2] drm/amd: Add Suspend/Hibernate notification callback
 support
Date: Fri, 22 Nov 2024 09:50:04 -0600
Message-ID: <20241122155004.3565-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122155004.3565-1-mario.limonciello@amd.com>
References: <20241122155004.3565-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ee0f3d-8786-459a-ab9e-08dd0b0d60ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CcCAPuebZaEWLFS81GRaX+ZWXo35QvZERnTaphhF0MorXm2uucTclLZD6nP9?=
 =?us-ascii?Q?5hne3HD+5hkHwvfjyBBDjEsi5HIEwz0MrqTPUfYny+3Il+dQKEmGz1Ju+AyS?=
 =?us-ascii?Q?8COSFHABX0dz2fsen/VwHpruGCtkSUqC8DURUNb8rf/Uco+uvdxiERTWXAUC?=
 =?us-ascii?Q?Dqs9+Vm1rwf4O1NyRnJeGC3T+KfOLZVRXBRB7sI3C3s3gjvbcd6HJUjX6keZ?=
 =?us-ascii?Q?SOKRkXbx5ZeY9mBfahvUVMCGr4VmYsaosbTZtgveWLE7zQ9NLdORjapCGRjh?=
 =?us-ascii?Q?PZqUQywM0wOhBsI5Iq2SHX7RP/eerFRAQZA/wlWULXb2NCWj52M1yffqJCgG?=
 =?us-ascii?Q?eBq/7aGCx0z0+siioOwxgntjIAgjmxowBe7SOxYSxbjC7y/9AE99p3INC4N3?=
 =?us-ascii?Q?sqqdtagE8J1OlgMuwSwRbNaHudqy4YU5XAdgPIi32elYt+sAvrKezRIAGEna?=
 =?us-ascii?Q?N3iZxLvc6fuDkh65ZAVSmtZOQC9NW1dbdzuCYsmD32M6UbuBFL5Cn7uU0wRM?=
 =?us-ascii?Q?/8o7Alie+WmhWwrrghKt7uy9E+qQ0kKZR9GJYb59hfo9ICw3rvmU46FaSyk8?=
 =?us-ascii?Q?55Li0Y+wkw2mqYFnNTpFCK6dDQsv27RaApinm3mipc19Wx87nFDTnFy2mcMT?=
 =?us-ascii?Q?PKr29xUpstmjbWjF/6VQ123neFmv6+aZ7ZRBNbly2iz6fKXpShcbs50vyDTg?=
 =?us-ascii?Q?BJLJnZ6t24me83xx4X3VFOZ6/MyMXs3RY0rkYBk119UquPB6WZvZ3AMGeXyC?=
 =?us-ascii?Q?8M5nqlFau3BtXongRz+3gxfeffUvUfG+ViecQ7Q/+U5du2+r7JaEOXqSmVbW?=
 =?us-ascii?Q?Z6okGWBXrVeMUMCJu0C8QizxfUiynl9QS7INVeJ3VVBVzICygEXiDyokCIes?=
 =?us-ascii?Q?t8/oD6zGpLcfcoLlG7NVNcSgRLAKE8Z+Qxwd9namd6oiOMyPKxqhUhH4fUEi?=
 =?us-ascii?Q?8VrXuVrr+eGHXzvyZuE6JFyElS9t9DWr/yEqyrnutIIs9KhSq/0/NvyD3t4T?=
 =?us-ascii?Q?4aGtQOd/5DlY7eSshJDidRsvAwMs5XD5u6avlgvjWhnOsurohL5zGNP5/KMk?=
 =?us-ascii?Q?y2nDQxY1mOm/H2ENCE6BEHkYojHoO4JFXXjtAKwse5NKSI55uLzthLT4jGiH?=
 =?us-ascii?Q?mlAscI6NYysQvl1MzJJWQWcaR3ykaioFkF4rO2g6M7u05aVi9zgr+PdVzxp0?=
 =?us-ascii?Q?KdE5FcO1Lnom0jstFZJx+5yUUXWOeZlb0RG6e+7IjEh/9OpAKTZh95tZJYP/?=
 =?us-ascii?Q?vegNK4eTmPFlXlRFoayBEt/rhHvNOgf/N/WZPRuyAXZDlAtsC+MvNmUYq3x0?=
 =?us-ascii?Q?yeMh5f+DwgIz295g0C9eByBTJDj+5sFJg2gYTB5Xa3RTJoUPC1DoDn72f28d?=
 =?us-ascii?Q?iOWNf5w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 15:50:23.9300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ee0f3d-8786-459a-ab9e-08dd0b0d60ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Collect tags
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
index d511ba949dff..3f75601ee634 100644
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
@@ -4757,6 +4766,33 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
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
+ *
+ */
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data)
+{
+	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
+
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+		if (amdgpu_device_evict_resources(adev))
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

