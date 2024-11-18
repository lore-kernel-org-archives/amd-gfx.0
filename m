Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E00D591B1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 20:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBB510E171;
	Mon, 18 Nov 2024 20:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aHutsmqq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBEFA10E171
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 20:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GedR0ZSgwqXWzGUmiENLXQmgB9iLhEp5UbHvZ3Bqe6dfGKW2bFUUlj611h2oN7+MlNXOhOAqC49ZUIlFfgllNprTHcs93qk/VwULacW1jMMLcgdFbfLxZfAEzKChGLvPrI8Egrhx5N+xUstrYbkiQdz3wx8DOOg6SPMWioH5+r/dAE440B9mZXzATV4iV28FICm1uqPPfLHB3HgnakmyEYqkvuVK4gq9GcsSp/MjZo6mLaN+/m6NZ5sU+IULrvih0/3XleTkbT5zT01oQmcD+P0sgoVcrWrNJrE2xwFN3cJBTJVnwZ/hLB0R9F3CESY3ByCbiwU+pIyarra8P4Zb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k4I3NS2Bl+OOfO90hpd+olKR/yKTkSnU43R+L+++dk=;
 b=ZDDA9HPeiTWjZgYGLOuZvfmyWN0MVYMLGQBrjjGfTj0L3GknXBalJhSg+5QRYe9/BpAnmrkb+6JDOgR1GFqweI/yZncHGPPyIAgaOEfkWVcbkLYiGZH/NQ6oBQSQq6PieaV3s+aYGNmbbBuxib1xk/xUPUU+YJtSPb0Ky0+aysWSJCZap56luhXqmLUnGKydVvQszbZO9khFsS6DfFirr5lZXFSCduW11xeaJtbuMD7A0we3j3Hax/FB2EENuhvXwQGHD1Dr8ZApt0P9S2QIiEwHO89B800ItiRAcUYYDFI/jVpZqvz8eahXNGJwMhXeMLLgzazNwRIrmYEzLiWLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k4I3NS2Bl+OOfO90hpd+olKR/yKTkSnU43R+L+++dk=;
 b=aHutsmqq5Fia2kRV0eAqVc2rphmnxm9CttKJ4nX0Hjn5MBP54oNChPiK5vPbgNY9CrPucV/hO9ZZ5gOjG3lzkVOSrFW2pbU0Zclz+0KV/+43ZrlzRCEOZl11gBAc3hHnhPA7n9Z7b+uZcNKuWVUlj1M/vCo6mCKTjy1i6sVlQk4=
Received: from PH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:510:5::6) by
 PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 20:03:40 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:5:cafe::b2) by PH0PR07CA0001.outlook.office365.com
 (2603:10b6:510:5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 20:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 20:03:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 14:03:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Add Suspend/Hibernate notification callback support
Date: Mon, 18 Nov 2024 14:03:23 -0600
Message-ID: <20241118200323.16541-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 622f8fff-ef49-4211-754e-08dd080c184a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eMoTT8rqaxcA2mG857/EyUpHuZqxYa7L4B/Yv/GFKoBEswAECdcIUwvDMpYx?=
 =?us-ascii?Q?ycd7QLphxS2oCP7KBXOyMSL5rgLibrv6NzxDOROVlXXmP1TYDTuZt5z1E006?=
 =?us-ascii?Q?naldfyIQwmDRx1k67UquSRh+eHBs3TnXZxl4mM4zYjuUy+U4MD6FLZ6nld0D?=
 =?us-ascii?Q?pL6QljpUpv8h0Z2GDtnx0C0qhvK+8shZTRZ7WuNPCIaW+fY+om7Ima8rmnWK?=
 =?us-ascii?Q?NosDcogtAvs2ZJ4Nalx7an1qunthUIfraOfvvAX8+szoKxoTrKU1jljfcIcN?=
 =?us-ascii?Q?nI7VsiKMH4Ili6ys4uMNcd7JidRvct+lpMnsfujOItTL3Enq0j/D7jM5jZAg?=
 =?us-ascii?Q?DdP/hK//faZ/uTBQZgjcsR2h88T26d2aGcglicg6UQ3N50CK8Tszf5mfJx1A?=
 =?us-ascii?Q?Prcd5qjdVQEPun9GJht+Urmls+6kob0m/CNwuDQjIvcSZ7lZxYEuE5h9URrN?=
 =?us-ascii?Q?z0dklvYbz+1mDy9CeT/cHNyFaUZ2tWIzVllcCkp7JISOUibIKAmFwASYYrwR?=
 =?us-ascii?Q?fsc9GmjZJDzBS2fQVHOtKW6ffQoyrDHUf9sZozE8y8Rf5SVcLTlq2eFwRL4E?=
 =?us-ascii?Q?7bb8ECi/qiG50kU23nkshLdUus7Db0wM7wl/H9GLlv2B3DPmZD54SKfkMxTh?=
 =?us-ascii?Q?D2t0zf4CQobZOP7D0k1NAJbzbcAMdw0/thQwayCiJbZ39vs3wBo5OJ+9/AiN?=
 =?us-ascii?Q?9TGX8bXNijEsQvUrmiFtQ4BuMmSjQiFdNDAN/QqDmdRKWY3en4mqbMLyhvkg?=
 =?us-ascii?Q?3vlKmPTqzdk/GXk03+z9nnAOMWIkbC4/CZOHLR2V9+PB+912x1K34jUKebJq?=
 =?us-ascii?Q?eBCGSqN3mzJgRkhfEiU1YGoUuj16bjZF9ltILXyyYahqzeXq/0feQXIFzqXP?=
 =?us-ascii?Q?aPRT7trJai1WuK8XrrXEVFYOxkqX4w61h0jie6FqiLReIrbg5Rn72C+uX3Ic?=
 =?us-ascii?Q?Iz9wmP0AFlne4JYDaCp4QXenvyIAr3Ac+9m5s4jp+GoOacxDgaWOIHhalZ5V?=
 =?us-ascii?Q?XpEPdX7fJUsFIEpsM5zoCh+0zyHmqQVWDqurUpXyRHawbbobwOp0KLOLK9MH?=
 =?us-ascii?Q?E0ulPULsOuoxc7YgqFbXA4r0MFNDUtnR3SU4uKw+Cvvr5vuQ+jL+ZuFfn67O?=
 =?us-ascii?Q?82YqA7An5hq6G3n2xm1LluioNrUaSNa4P0TbvwMtpFS8uyCFiNUXn06zqKF8?=
 =?us-ascii?Q?8he7HCOOgKiZai8xGdfDf8v30GnbXgCuFD1C/THMv4Ov2CulZiVQ7SYgdkHM?=
 =?us-ascii?Q?59gF3VmetG3Qv1jSjctlb4/OCLNg9s0Sur6oQEhvU3BxrjCBaK2nRCb9gndP?=
 =?us-ascii?Q?CSW2tN5NyuOiy0H4ywD1XR7tUB+bJIlbTfvfoGEYuvyuZJ55vv0Vddn2lVjV?=
 =?us-ascii?Q?knt+RUE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 20:03:39.5078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622f8fff-ef49-4211-754e-08dd080c184a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a37e687acbbc5..e70ca85151046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -885,6 +885,7 @@ struct amdgpu_device {
 	bool				need_swiotlb;
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
+	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
 	struct debugfs_blob_wrapper     debugfs_discovery_blob;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3ca911e55d61..5a4e9c7daf895 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -190,6 +190,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
 }
 
 static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data);
 
 /**
  * DOC: pcie_replay_count
@@ -4582,6 +4584,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_check_iommu_direct_map(adev);
 
+	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
+	r = register_pm_notifier(&adev->pm_nb);
+	if (r)
+		goto failed;
+
 	return 0;
 
 release_ras_con:
@@ -4646,6 +4653,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		drain_workqueue(adev->mman.bdev.wq);
 	adev->shutdown = true;
 
+	unregister_pm_notifier(&adev->pm_nb);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 */
@@ -4777,6 +4786,33 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
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
2.43.0

