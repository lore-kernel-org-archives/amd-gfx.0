Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9914FC19F2E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 19:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4953A10E9D8;
	Wed, 26 Feb 2025 19:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FM6akU95";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7703910E9D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 19:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfO2DFapzcvcmHmZAisoqe0rmzlD1ePNLHicI0DeoHmu0OdbYwZjIqZCGcqr6F9NXEXfQ2YzKrG0TlrKNEi6iVFRU0+VCr2GY409LCVg+iLFxfbNCnDivJRljoGzJp2H8pt6sfkzvTUd8a2Mm0NlKWpCF8JC5Bh+b1kAO31JTr689kHzeNFzsyhe0KR0fKhEmKhcIwKefjrJnspGfA7PUFh5v6oNkHPKAZ08f56ANK8ZpnWV2FvKhiqg+IsnXjwHBnc4ZomxJPoErycQNRmQKD5lfCT0bckQZmafqde7TpjJsCelk0j2onWZUpGdx9P/p+KQMDAV7fN4Wq9TFI89Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=io5p3d8rx9LQTDo91b4WD2Zyjmn3ht6xLV6QLk4I0+o=;
 b=m/Rs2G6bAc73e8Sp3xawp46RFsC67D1lzNSY1Xo5VvAfWVK3jBh3cdbBPHHiANQecWfzh7tV90x2aPoYR1bkRcz0cuV2SHM6VpzLI/cgzrfWeeewMUZ6DQ/sR8R4qyxNf7mDHPZO2d2xUP73Vq/PY/PHyeOq7GkUcu0lJPJQh9oRBpx85WaWWcmO2+/6AOZRr9Xs60il4b79aOGPhQzqOjT53dOZoCvN/WUzH7HeiGS/arkbzfuFMc8hjawZep8LTvsu/KtmGOZMh2xqhZGHx20bNwT/Gcb/H5K+NwdsqmpRmnCvOwG/QZCx+13KM0VK7jtTwV0ZRXmUvWoTeuRysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io5p3d8rx9LQTDo91b4WD2Zyjmn3ht6xLV6QLk4I0+o=;
 b=FM6akU95epeH/fN2UBKaBvKsRzoOPJ/8N+UXK0rXIktk4b2g99OmFFfwUXwf2MDjoV+8RU3rNP0vtM3eX9T8A6VOm+fsZqiyanDy2kKaSUhyRo5GpuyZdaKZuW7WQDPd5ixfgjeEw4bm/RELGWsvp9uoRp6rVmXs7yOGIPZ7GRE=
Received: from BYAPR06CA0049.namprd06.prod.outlook.com (2603:10b6:a03:14b::26)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 19:23:27 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::3d) by BYAPR06CA0049.outlook.office365.com
 (2603:10b6:a03:14b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 19:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 19:23:25 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Feb 2025 13:23:23 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
Date: Wed, 26 Feb 2025 14:23:02 -0500
Message-ID: <20250226192303.48552-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a484a58-6067-4128-c61a-08dd569b0ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tfxCgWHXcowULdINQjvUvK47rwCtgIXHrnmB0Qyx0kEcXHFQtFDYXgdpQQO0?=
 =?us-ascii?Q?6mKjI1z/+K1cs8psWB61/clsmkxUX4wH6YmxmH6GPEGzdvamS2sSWfcQO+bu?=
 =?us-ascii?Q?FX8rnrEt/TvoR5/23Ei9o7fvdgOk/BlmJ5vtVaTps/9xX/Zf+xrGAIERR5H/?=
 =?us-ascii?Q?IRa4r9dnz3mD1PmsbbOkVVW9XbD1x6xW3TJMXk93ipedJ6Ffnm/fPIU0yxsO?=
 =?us-ascii?Q?DsOcaNbxucpNR/lHbQuy9irgPbIldIWw4aL5VO1OIBzr4xfVOPk2+v5asgJS?=
 =?us-ascii?Q?rW+oIRQGhvv37QYBCXbz/Qilk4bJOCZvzvaE4CgIP43+5O8rwQdogt6T0qzq?=
 =?us-ascii?Q?rY0agYoGKUq4+yIMFwNuFGiem8F5F2LKXiI0AKSBZOuebF72oroMz9cxgV3i?=
 =?us-ascii?Q?hBhLqO+1pnU1hhXAM9OR6cnxTnrFdia3UuDAhLMTPNv8278Ld3B3CIpEWBvB?=
 =?us-ascii?Q?4wsMwt9pGWseoWY1mAsybNWoLuna+yLb19Z79duNbiFSruxMjw1rwoWLcV1u?=
 =?us-ascii?Q?bhY1if8PM9AxiH34Diq1nz0+F2aclllJtLNE0vDGpc3UuwT8gUUj+kTGrzg+?=
 =?us-ascii?Q?77WaSW61X8li/XDYTjIUN8Z6aaR1LwJMl4ZG4keCFk60JtIPLrl1FOLq9BtF?=
 =?us-ascii?Q?abFaVdR8wPYSjMjavA80knjtH2+h8hAI41k5LSVqe7zD2/eHtZLCTCfVjBcw?=
 =?us-ascii?Q?sdCzFPuRXC6+3HfUngCQSWZG6Qx1E4ur/wrwhFyvQCLsEok6SAcG6fITqfPY?=
 =?us-ascii?Q?1ZW5TOh/vj1pvtZNUZb6VRxfSuCKcui6dxpOldOng2PCJHkaMWDAdlwsanPf?=
 =?us-ascii?Q?eZV9crprhIRVI/Am4WC31fk2bYNzsck8O6HMpiyjFeqfvW1Gn8C0aegC9xqx?=
 =?us-ascii?Q?KtHI6ZMVJCExm5uF7pWUjSSkoqeZGtMpwX/21gSBriGlJfVlM7OTPe6D62wi?=
 =?us-ascii?Q?3SqkP1zNBmuXFQacwTAlU+w1to0giI4rNxeHYCHdbX1dk8N7W7lEUIqfsSjM?=
 =?us-ascii?Q?5rIxgzGaHe/RZzqHaF1EPp2GmShiCC4It1RLOyOhk9wMQv11CxjZR0Lg1JJ6?=
 =?us-ascii?Q?4PIPNgBwtp4dWNiC95x1I6+W1dU11c9mB7UXhglVhu8jnn1s5m4RKtXvaYVz?=
 =?us-ascii?Q?X1SQCwiLf0nI3v36cmJD6M9QpxnGZArnGSoIbztFVyItNQw7yM6SK7A01PBm?=
 =?us-ascii?Q?ITOOIrHD4Cx4Iy/FzuKfM52bslOQfEBKEr5c552VHVoafPaRGWwQJ0HT7tFX?=
 =?us-ascii?Q?W1TlOdGk021VBaB+mEOJpLUAc9ggx4258s+OjjYgM2ytSbKscISJrK+5FlIz?=
 =?us-ascii?Q?BOZxGXiCxRJeCrhZF0o0yPvDcUfU6YtxrYbnwZbcM/WYrT/0hoYV0qDV1Sfv?=
 =?us-ascii?Q?rctmcr02tOASrVJ+0Q8OnSgSSo5sRzl+7DbSB3CbL0n9+3qKOcEo2wrcXSdN?=
 =?us-ascii?Q?Rre1lT9aNPf0OL/cgX8Xpngx03tPAfMIU3s2nbJ+oi+NVVLN+/KUS4SJBzGS?=
 =?us-ascii?Q?S5+vOme6UDpLURQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:23:25.7625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a484a58-6067-4128-c61a-08dd569b0ae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201
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

Update pm_update_grace_period() to more cleaner
pm_config_dequeue_wait_counts(). Previously, grace_period variable was
overloaded as a variable and a macro, making it inflexible to configure
additional dequeue wait times.

pm_config_dequeue_wait_counts() now takes in a cmd / variable. This
allows flexibility to update different dequeue wait times.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 45 +++++++--------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h | 11 +++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 26 ++++++++-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 56 ++++++++++++++-----
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 28 ++++++++--
 6 files changed, 120 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 94b1ac8a4735..cc7465f9562a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -42,6 +42,8 @@
 /* Size of the per-pipe EOP queue */
 #define CIK_HPD_EOP_BYTES_LOG2 11
 #define CIK_HPD_EOP_BYTES (1U << CIK_HPD_EOP_BYTES_LOG2)
+/* See unmap_queues_cpsch() */
+#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
 
 static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
 				  u32 pasid, unsigned int vmid);
@@ -1745,10 +1747,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 
 	init_sdma_bitmaps(dqm);
 
-	if (dqm->dev->kfd2kgd->get_iq_wait_times)
-		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
-					&dqm->wait_times,
-					ffs(dqm->dev->xcc_mask) - 1);
+	update_dqm_wait_times(dqm);
 	return 0;
 }
 
@@ -1844,25 +1843,11 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	/* clear hang status when driver try to start the hw scheduler */
 	dqm->sched_running = true;
 
-	if (!dqm->dev->kfd->shared_resources.enable_mes)
+	if (!dqm->dev->kfd->shared_resources.enable_mes) {
+		if (pm_config_dequeue_wait_counts(&dqm->packet_mgr,
+				KFD_DEQUEUE_WAIT_INIT, 0 /* unused */))
+			dev_err(dev, "Setting optimized dequeue wait failed. Using default values\n");
 		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
-
-	/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
-	if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
-	    (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))) {
-		uint32_t reg_offset = 0;
-		uint32_t grace_period = 1;
-
-		retval = pm_update_grace_period(&dqm->packet_mgr,
-						grace_period);
-		if (retval)
-			dev_err(dev, "Setting grace timeout failed\n");
-		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
-			/* Update dqm->wait_times maintained in software */
-			dqm->dev->kfd2kgd->build_grace_period_packet_info(
-					dqm->dev->adev,	dqm->wait_times,
-					grace_period, &reg_offset,
-					&dqm->wait_times);
 	}
 
 	/* setup per-queue reset detection buffer  */
@@ -2261,7 +2246,14 @@ static int reset_queues_on_hws_hang(struct device_queue_manager *dqm)
 	return r;
 }
 
-/* dqm->lock mutex has to be locked before calling this function */
+/* dqm->lock mutex has to be locked before calling this function
+ *
+ * @grace_period: If USE_DEFAULT_GRACE_PERIOD then default wait time
+ *   for context switch latency. Lower values are used by debugger
+ *   since context switching are triggered at high frequency.
+ *   This is configured by setting CP_IQ_WAIT_TIME2.SCH_WAVE
+ *
+ */
 static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
 				uint32_t filter_param,
@@ -2280,7 +2272,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 		return -EIO;
 
 	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
-		retval = pm_update_grace_period(&dqm->packet_mgr, grace_period);
+		retval = pm_config_dequeue_wait_counts(&dqm->packet_mgr,
+				KFD_DEQUEUE_WAIT_SET_SCH_WAVE, grace_period);
 		if (retval)
 			goto out;
 	}
@@ -2324,8 +2317,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 
 	/* We need to reset the grace period value for this device */
 	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
-		if (pm_update_grace_period(&dqm->packet_mgr,
-					USE_DEFAULT_GRACE_PERIOD))
+		if (pm_config_dequeue_wait_counts(&dqm->packet_mgr,
+				KFD_DEQUEUE_WAIT_RESET, 0 /* unused */))
 			dev_err(dev, "Failed to reset grace period\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 09ab36f8e8c6..917717cfe9c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -37,7 +37,6 @@
 
 #define KFD_MES_PROCESS_QUANTUM		100000
 #define KFD_MES_GANG_QUANTUM		10000
-#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
 
 struct device_process_node {
 	struct qcm_process_device *qpd;
@@ -359,4 +358,14 @@ static inline int read_sdma_queue_counter(uint64_t __user *q_rptr, uint64_t *val
 	/* SDMA activity counter is stored at queue's RPTR + 0x8 location. */
 	return get_user(*val, q_rptr + 1);
 }
+
+static inline void update_dqm_wait_times(struct device_queue_manager *dqm)
+{
+	if (dqm->dev->kfd2kgd->get_iq_wait_times)
+		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
+					&dqm->wait_times,
+					ffs(dqm->dev->xcc_mask) - 1);
+}
+
+
 #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 4984b41cd372..dd19ae40f0ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -396,14 +396,29 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 	return retval;
 }
 
-int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
+/* pm_config_dequeue_wait_counts: Configure dequeue timer Wait Counts
+ *  by writing to CP_IQ_WAIT_TIME2 registers.
+ *
+ *  @cmd: See emum kfd_config_dequeue_wait_counts_cmd definition
+ *  @value: Depends on the cmd. This parameter is unused for
+ *    KFD_DEQUEUE_WAIT_INIT and KFD_DEQUEUE_WAIT_RESET. For
+ *    KFD_DEQUEUE_WAIT_SET_SCH_WAVE it holds value to be set
+ *
+ */
+int pm_config_dequeue_wait_counts(struct packet_manager *pm,
+		enum kfd_config_dequeue_wait_counts_cmd cmd,
+		uint32_t value)
 {
 	struct kfd_node *node = pm->dqm->dev;
 	struct device *dev = node->adev->dev;
 	int retval = 0;
 	uint32_t *buffer, size;
 
-	size = pm->pmf->set_grace_period_size;
+	if (!pm->pmf->config_dequeue_wait_counts ||
+	    !pm->pmf->config_dequeue_wait_counts_size)
+		return 0;
+
+	size = pm->pmf->config_dequeue_wait_counts_size;
 
 	mutex_lock(&pm->lock);
 
@@ -419,13 +434,18 @@ int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
 			goto out;
 		}
 
-		retval = pm->pmf->set_grace_period(pm, buffer, grace_period);
+		retval = pm->pmf->config_dequeue_wait_counts(pm, buffer,
+							     cmd, value);
 		if (!retval)
 			retval = kq_submit_packet(pm->priv_queue);
 		else
 			kq_rollback_packet(pm->priv_queue);
 	}
 
+	/* If default value is modified, cache that value in dqm->wait_times */
+	if (cmd == KFD_DEQUEUE_WAIT_INIT)
+		update_dqm_wait_times(pm->dqm);
+
 out:
 	mutex_unlock(&pm->lock);
 	return retval;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index d56525201155..9cb21af1d0af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -297,23 +297,51 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 	return 0;
 }
 
-static int pm_set_grace_period_v9(struct packet_manager *pm,
+static inline void pm_build_dequeue_wait_counts_packet_info(struct packet_manager *pm,
+			uint32_t sch_value, uint32_t *reg_offset,
+			uint32_t *reg_data)
+{
+	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
+		pm->dqm->dev->adev,
+		pm->dqm->wait_times,
+		sch_value,
+		reg_offset,
+		reg_data);
+}
+
+static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 		uint32_t *buffer,
-		uint32_t grace_period)
+		enum kfd_config_dequeue_wait_counts_cmd cmd,
+		uint32_t value)
 {
 	struct pm4_mec_write_data_mmio *packet;
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
 
-	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
-			pm->dqm->dev->adev,
-			pm->dqm->wait_times,
-			grace_period,
-			&reg_offset,
-			&reg_data);
-
-	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
+	switch (cmd) {
+	case KFD_DEQUEUE_WAIT_INIT:
+		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
+		if (amdgpu_emu_mode == 0 && pm->dqm->dev->adev->gmc.is_app_apu &&
+		   (KFD_GC_VERSION(pm->dqm->dev) == IP_VERSION(9, 4, 3)))
+			pm_build_dequeue_wait_counts_packet_info(pm, 1, &reg_offset, &reg_data);
+		else
+			return 0;
+		break;
+	case KFD_DEQUEUE_WAIT_RESET:
+		/* function called only to get reg_offset */
+		pm_build_dequeue_wait_counts_packet_info(pm, 0, &reg_offset, &reg_data);
 		reg_data = pm->dqm->wait_times;
+		break;
+
+	case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
+		/* The CP cannot handle value 0 and it will result in
+		 * an infinite grace period being set so set to 1 to prevent this.
+		 */
+		if (!value)
+			value = 1;
+		pm_build_dequeue_wait_counts_packet_info(pm, value, &reg_offset, &reg_data);
+		break;
+	}
 
 	packet = (struct pm4_mec_write_data_mmio *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
@@ -415,7 +443,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
 	.set_resources		= pm_set_resources_v9,
 	.map_queues		= pm_map_queues_v9,
 	.unmap_queues		= pm_unmap_queues_v9,
-	.set_grace_period       = pm_set_grace_period_v9,
+	.config_dequeue_wait_counts = pm_config_dequeue_wait_counts_v9,
 	.query_status		= pm_query_status_v9,
 	.release_mem		= NULL,
 	.map_process_size	= sizeof(struct pm4_mes_map_process),
@@ -423,7 +451,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
 	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
 	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
 	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
-	.set_grace_period_size  = sizeof(struct pm4_mec_write_data_mmio),
+	.config_dequeue_wait_counts_size  = sizeof(struct pm4_mec_write_data_mmio),
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= 0,
 };
@@ -434,7 +462,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
 	.set_resources		= pm_set_resources_v9,
 	.map_queues		= pm_map_queues_v9,
 	.unmap_queues		= pm_unmap_queues_v9,
-	.set_grace_period       = pm_set_grace_period_v9,
+	.config_dequeue_wait_counts = pm_config_dequeue_wait_counts_v9,
 	.query_status		= pm_query_status_v9,
 	.release_mem		= NULL,
 	.map_process_size	= sizeof(struct pm4_mes_map_process_aldebaran),
@@ -442,7 +470,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
 	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
 	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
 	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
-	.set_grace_period_size  = sizeof(struct pm4_mec_write_data_mmio),
+	.config_dequeue_wait_counts_size  = sizeof(struct pm4_mec_write_data_mmio),
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= 0,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index 347c86e1c378..a1de5d7e173a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -304,7 +304,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs = {
 	.set_resources		= pm_set_resources_vi,
 	.map_queues		= pm_map_queues_vi,
 	.unmap_queues		= pm_unmap_queues_vi,
-	.set_grace_period	= NULL,
+	.config_dequeue_wait_counts	= NULL,
 	.query_status		= pm_query_status_vi,
 	.release_mem		= pm_release_mem_vi,
 	.map_process_size	= sizeof(struct pm4_mes_map_process),
@@ -312,7 +312,7 @@ const struct packet_manager_funcs kfd_vi_pm_funcs = {
 	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
 	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
 	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
-	.set_grace_period_size	= 0,
+	.config_dequeue_wait_counts_size	= 0,
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= sizeof(struct pm4_mec_release_mem)
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 59619f794b6b..4c8026947a73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1392,6 +1392,24 @@ int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
 #define KFD_FENCE_COMPLETED (100)
 #define KFD_FENCE_INIT   (10)
 
+/**
+ * enum kfd_config_dequeue_wait_counts_cmd - Command for configuring
+ *  dequeue wait counts.
+ *
+ * @KFD_DEQUEUE_WAIT_INIT: Set optimized dequeue wait counts for a
+ *	certain ASICs. For these ASICs, this is default value used by RESET
+ * @KFD_DEQUEUE_WAIT_RESET: Reset dequeue wait counts to the optimized value
+ *	for certain ASICs. For others set it to default hardware reset value
+ * @KFD_DEQUEUE_WAIT_SET_SCH_WAVE: Set context switch latency wait
+ *
+ */
+enum kfd_config_dequeue_wait_counts_cmd {
+	KFD_DEQUEUE_WAIT_INIT = 1,
+	KFD_DEQUEUE_WAIT_RESET = 2,
+	KFD_DEQUEUE_WAIT_SET_SCH_WAVE = 3
+};
+
+
 struct packet_manager {
 	struct device_queue_manager *dqm;
 	struct kernel_queue *priv_queue;
@@ -1417,8 +1435,8 @@ struct packet_manager_funcs {
 	int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
 			enum kfd_unmap_queues_filter mode,
 			uint32_t filter_param, bool reset);
-	int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer,
-			uint32_t grace_period);
+	int (*config_dequeue_wait_counts)(struct packet_manager *pm, uint32_t *buffer,
+			enum kfd_config_dequeue_wait_counts_cmd cmd, uint32_t value);
 	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
 			uint64_t fence_address,	uint64_t fence_value);
 	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
@@ -1429,7 +1447,7 @@ struct packet_manager_funcs {
 	int set_resources_size;
 	int map_queues_size;
 	int unmap_queues_size;
-	int set_grace_period_size;
+	int config_dequeue_wait_counts_size;
 	int query_status_size;
 	int release_mem_size;
 };
@@ -1452,7 +1470,9 @@ int pm_send_unmap_queue(struct packet_manager *pm,
 
 void pm_release_ib(struct packet_manager *pm);
 
-int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period);
+int pm_config_dequeue_wait_counts(struct packet_manager *pm,
+			enum kfd_config_dequeue_wait_counts_cmd cmd,
+			uint32_t wait_counts_config);
 
 /* Following PM funcs can be shared among VI and AI */
 unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size);
-- 
2.34.1

