Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE92C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 08:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A4410E3C4;
	Fri, 11 Jul 2025 08:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gmz44Pxz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C82F810E3C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 08:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUYjTHEUunYTuMyiP4SL4JRJ0Qo4qA0oPDYYwpWaB6dQf7hI2/4CQiBOM8ySJWrl+xTSbau4usaVyR/oXvkP0sznGXjHO8TwvbVRCd9Lo8JbIT6Yx5jRVAX0L/BssWrqLIJ6Ha0c9YtUsZeRF5l0kjmkCiL9u3jetuiQuHEyGpsDy4I0kZws7nhBBdNCqh2NziySy5PkAu26W/VqmlpYM3eoAFq+UBWjrW2ck/08M29XzYrQ3wFhipMtw71dj7/IpS+RiunVWnboEgAW3tv4uXL57e9aIbwJUF1BvTQCSDu2M3cVQQuda17p9hEWgilCw8F/wzPfM+kBQ4qHTOv2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ODKOgFUg/yYUQk3mT2fDc5kRHH0tk+7s6l5xuMEyeA=;
 b=otyEpjkl17jn1Xh7gwVkmfgEthvszSSO9JcnualOusNMkDc+EfrvNQMZ4YJTibYfEJP3zJxiTF71WCNusRiaZAXD79drGc2RigbZ56FRyCznI3wL2kehWsxRmXEHfCSvx6YvmddlJPMLd9QvFFTQAeoQiNdhbTK2WCvDIs9vlxOrIgzwd8IxmN+hwB4ZqdDhMrziDELj+kTOTN9oisYifdEoEFv6ulDsdnlYDKU/8HVTFEshFXNTUVvSxOIJbQJsHc/DrB9MAd/i4wXff/39OtiEsKmUjF9SGvq1ylb/oNZ4miukd0h8uRDn8Hq5qn+kKjgrYAz09R26Mhu1VL0zJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ODKOgFUg/yYUQk3mT2fDc5kRHH0tk+7s6l5xuMEyeA=;
 b=Gmz44PxzKjsToN7dg2EokKPJQ8l8P6T+1RcMePd+KwRki8Xq85rc3b+Ncn4Q+iWRXCwSKy+3M/iroN6t/OqMVSavBCwTWeX4hn6qrAWKUP4ScyV514gPL6vvnl4jgpJuyAh7qYNNkXBVpL4ZR1F/WmHl9c7h4HkThNPrFP2zpjI=
Received: from BYAPR08CA0017.namprd08.prod.outlook.com (2603:10b6:a03:100::30)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 08:36:08 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::58) by BYAPR08CA0017.outlook.office365.com
 (2603:10b6:a03:100::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 08:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 08:36:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 03:36:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 03:36:05 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Jul 2025 03:35:59 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add atomic CPU-GPU clock counter correlation
Date: Fri, 11 Jul 2025 16:35:58 +0800
Message-ID: <20250711083558.1372311-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 72621ccf-16c4-49fc-0f4a-08ddc055fb7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rljHFjf05+rY0ox8wOcY8Vh58wbpDs2lMWueRrGQvwxxB4bNBFRs/8oPyHEY?=
 =?us-ascii?Q?g6oEsklzh9lOl+igxTgw1PK4dcTFsUvqYY2o0zcUf+M4+XUMTladkazK365D?=
 =?us-ascii?Q?HGuLOq2If/Vh2Ow65nfGQq27nJmjKMJvaGSJ9t1ANZskb+a/iKcaRUJvMU1h?=
 =?us-ascii?Q?w+P3wbRvZjqo8TQUYQa8Fp1fGNtH6oTAyvQKMw2TjSuaAnn7gOtHXVgnCoTd?=
 =?us-ascii?Q?l0irzNytck1xuyYNCFuqE+MLSEixNXCJVhWrkmb+ZRFqS5KMrCEcVKYd5ycH?=
 =?us-ascii?Q?Y47AJFIH4Mf5rdOk4UIzGdMmqFEdd637H9jSlgCj0RmTNY/JG6RftTnxg5ti?=
 =?us-ascii?Q?ZUK3CKd139jHGS3QtFC6DIBu/3GjEa6mCQcYPW4ahK8rimXSkApQA8jxgpuG?=
 =?us-ascii?Q?oczYrlKAhQz/YmdSaZLYW0vCMqWb7JJ9Kll8GIR9cLh2PA/7fTMuJtdH5Fay?=
 =?us-ascii?Q?JN0sbfRc3coO3b/ns2v80rhZ9oGKT3lot9JAfLD8xRKTQK3dPvl0UmgRs3IN?=
 =?us-ascii?Q?QDvalak9oE7cutXIl+zFYXxAmAnq5m0EdwwFHoOaCfkJGD3WGdSdrRrp8mfT?=
 =?us-ascii?Q?GkMRj5dJIpLVmH7IPNDA13tYp6pOLu2InxG5w3uA8L2O/4gRJKQr51Po5iEe?=
 =?us-ascii?Q?+/hHA8jDHRoJ8MQEvdFXKXj7yo57QWkb46NgxjjzIWu5g/KiLs7WLKgpdF2G?=
 =?us-ascii?Q?k4Jf3k+qYKBD+Z1h0QEoWJoD5Y4hzePGUdI1p3eXjsmMtisd8xwEDES9yHik?=
 =?us-ascii?Q?AWYWKXPEUqorWoRVd8jzZg0DK5ANhPx3DeN97cnHobGXnB3SQ9vU81CjLBps?=
 =?us-ascii?Q?1wkyMEXQY82K4Zm58FDtpaysRKFpATaiOx11SW8C1uvThTI6nD53BInoPPwk?=
 =?us-ascii?Q?kGSnDYJdsYDWpzxysyAlzUyoeomlr8+EvhAA+5rkvQ5giMiN4xjczb/IB1SZ?=
 =?us-ascii?Q?jePSOJcCqNhWMFBfaQLJwukcEg13PU+7H07G+TMSoLnsaVvKgn4DW4IQK9lf?=
 =?us-ascii?Q?JWpmQb4UQYoL7FwAH+d31RuVk5F0wvIg6VuPIDEZRtJAGk/tZoLfbAuiGm0Q?=
 =?us-ascii?Q?925BG9RoH5i21J9n9HkSPXwZf0Wtog0OdaRNjGx5cknqxU/3jZzOzUET8In6?=
 =?us-ascii?Q?Ohk3AJMJVXQ5xcHS+/jE2+0MKBgUW+nxiN2DV/xnev2ypxL8lNAVognBGHdr?=
 =?us-ascii?Q?05TE/EDqp3muUT4JAuOpLDWfaO2P2e2LgD7QA6NjSzd1HAhuVj4m6/EnQwSb?=
 =?us-ascii?Q?2RjyEOt9kukvGOAC122A5L/c2eDUXuHXQShJ5fETpFujGeQwuCxoN2pkLDAm?=
 =?us-ascii?Q?D61hr2nAtklpUZCJ3u1qGt0npuaiFfzXHsaHxgL/HSdV5FQ3Dfo5ZO6feU8D?=
 =?us-ascii?Q?xRCJlQ5EVdZ2W9+s42Dj1SXFJxL/ypWah9h3ILB0wxc5nOUeUzqr26Kesdo6?=
 =?us-ascii?Q?rXJE8evKRxzq5wIe/AXpc2qVUvMu8XUllRsQWtqslZpIKXDFd0rEsTJ27Q3m?=
 =?us-ascii?Q?tidvoanz7R+J8I8Nx4SylvA5aJeVoHOP76KT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:36:07.9246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72621ccf-16c4-49fc-0f4a-08ddc055fb7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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

This patch introduces a new IOCTL to provide tightly correlated
CPU and GPU timestamps for accurate performance measurements
and synchronization between host and device timelines.

Key improvements:
1. Adds AMDGPU_INFO_CLOCK_COUNTERS query type (0x06)
2. Implements atomic sampling of clocks with:
   - preempt_disable()
   - local IRQ disabling
   - GPU timestamp sampled first (higher latency)
   - CPU timestamps sampled immediately after
3. Provides three correlated clocks:
   - GPU clock counter (ns)
   - CPU raw monotonic time (ns)
   - System boottime (ns)
4. Includes system clock frequency (1GHz) for reference

The implementation addresses the need for precise CPU-GPU
timestamp correlation in ROCm applications, particularly for:
- Performance analysis tools
- Compute pipeline synchronization
- Graphics/compute interoperability
- Low-latency VR/AR applications

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 19 +++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 931c52c918c4..8412c88aada9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -595,6 +595,43 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+/**
+ * get_cpu_gpu_counters - Atomically sample CPU and GPU clocks
+ * @adev: amdgpu device pointer
+ * @args: structure to store clock counters
+ *
+ * Samples CPU and GPU clocks as close to simultaneously as possible
+ * by disabling preemption and interrupts during the sampling.
+ * Returns 0 on success.
+ */
+static int get_cpu_gpu_counters(struct amdgpu_device *adev,
+                               struct drm_amdgpu_info_clock_counters *args)
+{
+	unsigned long flags;
+
+	/* Disable preemption and interrupts on local CPU */
+	preempt_disable();
+	local_irq_save(flags);
+
+	if (adev->gfx.funcs->get_gpu_clock_counter)
+		args->gpu_clock_counter = adev->gfx.funcs->get_gpu_clock_counter(adev);
+	else
+		args->gpu_clock_counter = 0;
+
+	/* No access to rdtsc. Using raw monotonic time */
+	args->cpu_clock_counter = ktime_get_raw_ns();
+	args->system_clock_counter = ktime_get_boottime_ns();
+
+	/* Since the counter is in nano-seconds we use 1GHz frequency */
+	args->system_clock_freq = 1000000000;
+
+	/* Restore previous state */
+	local_irq_restore(flags);
+	preempt_enable();
+
+	return 0;
+}
+
 /*
  * Userspace get information ioctl
  */
@@ -734,6 +771,13 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_INFO_TIMESTAMP:
 		ui64 = amdgpu_gfx_get_gpu_clock_counter(adev);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
+	case AMDGPU_INFO_CLOCK_COUNTERS: {
+		struct drm_amdgpu_info_clock_counters counters;
+
+		 memset(&counters, 0, sizeof(counters));
+		get_cpu_gpu_counters(adev, &counters);
+		return copy_to_user(out, &counters, min(size, sizeof(counters))) ? -EFAULT : 0;
+	}
 	case AMDGPU_INFO_FW_VERSION: {
 		struct drm_amdgpu_info_firmware fw_info;
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..e8adbbd076ca 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1056,6 +1056,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_HW_IP_COUNT			0x03
 /* timestamp for GL_ARB_timer_query */
 #define AMDGPU_INFO_TIMESTAMP			0x05
+/* get synchronized CPU and GPU clock counters  */
+#define AMDGPU_INFO_CLOCK_COUNTERS		0x06
 /* Query the firmware version */
 #define AMDGPU_INFO_FW_VERSION			0x0e
 	/* Subquery id: Query VCE firmware version */
@@ -1598,6 +1600,23 @@ struct drm_amdgpu_info_uq_metadata {
 	};
 };
 
+/**
+ * struct drm_amdgpu_info_clock_counters - Clock counter information
+ *
+ * Used to correlate timestamps between CPU and GPU with minimal skew.
+ * All counters are in nanoseconds for consistent comparison.
+ */
+struct drm_amdgpu_info_clock_counters {
+	/* GPU clock counter in nanoseconds */
+	__u64 gpu_clock_counter;
+	/* CPU clock counter (raw monotonic) in nanoseconds */
+	__u64 cpu_clock_counter;
+	/* System boottime clock counter in nanoseconds */
+	__u64 system_clock_counter;
+	/* System clock frequency in Hz (always 1GHz) */
+	__u64 system_clock_freq;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.34.1

