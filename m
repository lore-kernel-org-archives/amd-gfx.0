Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E90C282C6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 20:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7FF10E1E6;
	Mon,  3 Mar 2025 20:45:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3091C10E113
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 20:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NImGDQRQ3NWYn2F5cyCzeKVMqcH5R30adv2GQYRXbPSlWpjC4d58RLgMoKe7H+unPrK465Lzrtbizm7LmppjAIhBs+MFWTziPf6a+hnOnbAVhMV8CE28Lah3kaYe/6PBez07gt834TmljoGpKAdhiq1a00oYP6UMIlG6WciRmcvbIxX3VcjIRiInZ8Ydi8HqqbP89p9G3FAAltxGDnRxWaORLxHaNyFcxkdzAJhcAVpvGUNk791HmszdAqlTxYgCQ55tv3l6J/32LmD97a7Je9IaGzVpDJ8ZklmH6NKrhlVruxiV61BKvE+GTYFqQZ9RJTYRV3q6n4L0sW3+V1W2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DX4wbIjlLAcsVdpyPSNPK1Vhv02rvrdhzMEOryYYE4=;
 b=gaEfeixB4SGcFZfAcJosULQweEmZgWrXgJujO3xmwkMvSJ1+t7FRo8Si7KUjw/52YNZ51Zk+VR1bKBQAHKg56ThcwbpDJl4hsq/Xbdi1fBzY9hBu3wzNbiORzRzEAIzjzufzkVRTSw+z8SXo6guwXrIjbcEyhbYb1EueCq6CvYuwc1c6YDIxX06JRlS1+X94d039s6PLOTSN6SMHvf9n0lLxN8xk464uvgMARPURXYkFt4/+45UeaxpLNTYHGx4+wllEXorxvbISNA2bAUd3L1uY1p20ks+lFFLzvsN+vWXkGYg87wdPtxTYZQZcc5aSKqB/0rVsQViXiDNZGKz5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DX4wbIjlLAcsVdpyPSNPK1Vhv02rvrdhzMEOryYYE4=;
 b=ma4/zOHktxMcUMZvaxI4uiG7R0TSjmmcJ+gKMVnAr25+Ne7pRt9rvUypJwxhe54vLGBk9RI56e1GPjMMquT7dgWCrWFIf62t930LlIY5AG0cGEd+QRDAZMMgiGxBw63saezNfHTX0nuNa3FgQY7NalB1HLE+/AphrQPH1iWnMFI=
Received: from CH2PR17CA0001.namprd17.prod.outlook.com (2603:10b6:610:53::11)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 20:44:49 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::2e) by CH2PR17CA0001.outlook.office365.com
 (2603:10b6:610:53::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 20:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 20:44:49 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Mar 2025 14:44:48 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: Add pm_config_dequeue_wait_counts API
Date: Mon, 3 Mar 2025 15:44:26 -0500
Message-ID: <20250303204427.113261-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd446ad-d4b3-4ff1-e1f2-08dd5a943da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?joGoWswzCV7CAmzZcngbOnSj1kxcYRar9f9NuEXEb+d8YoTdbRYvLTvSw3+y?=
 =?us-ascii?Q?QDxmd4qOnW5zFfXOVJAHyD1dIibsduoUJuxga4VJAQcaUp4kyVbMaGNNtAgb?=
 =?us-ascii?Q?Axs8L+pjRjNPol1+tCYGn/S/zUH95DM+Pr/Wht2zR20D0OV/tO/pqphv9Kpb?=
 =?us-ascii?Q?fzlhTQyo8y5Ezt1v8DYJ7W/nAOUt8AbfCqzsuPOLPSIW/WL10SSxRE3VE+If?=
 =?us-ascii?Q?KPO9X4d+6HOyQI8eaQyOtXtadC5zVdqf3XXueZCTDCrRLfufpRHNEfQmU0Mg?=
 =?us-ascii?Q?zcSVnoSJUU+gfrAvbvAn9za2TKYmwG4XbRf8fCKiyMKtBAtAwozzp/7FZ5Nf?=
 =?us-ascii?Q?+6GcZGwqLjUJ33aloC+rCZj51FX5wQ+jToeqm9H1mICQ4gdhmz1N/Kkewlhh?=
 =?us-ascii?Q?OB73LfsnDJCj7fRSze8rcXjWs0jsuITevDvDW2FbCLGC3NkdZqoiubIYWzkl?=
 =?us-ascii?Q?54n8ZBRP1lNL1/ikdVCOfSWfI9gFBwKlpQH0jqG8fo7n6kQt1bCWhTD0hvoO?=
 =?us-ascii?Q?OY8x7Z7m5uhBoY2L91JULdiQft+Zmlvw7+X+H99lxD5aRnDpBsdRRkvV8LOj?=
 =?us-ascii?Q?mLP5LKgbNmcytWyPWBi/HH1tfCHRPXEff5OYMRf7D3GRE4EetsePdid5sCIl?=
 =?us-ascii?Q?wUzx58mrdAfsXI8VfygXCxPQ42Y3LB/GgtKqpQuSnaz6mcXIwuF2OSwc3WpM?=
 =?us-ascii?Q?rm79qsHC/mX5oQQxHza2eHFQiW1+mc/boJp8/QoK4vF/PzVJ5hAG714POAWx?=
 =?us-ascii?Q?XKWR4GepSyPF1yFpE+BpgM7yIK8Lsn4Wu2pF/gM4VoC+zGcL4PSvfrH9djrf?=
 =?us-ascii?Q?BJiQZjOLIFr9akoHKBFYjBWDQmwTrGo+W9myCscEFPLhvyCuH7G/Dt+nA37t?=
 =?us-ascii?Q?hN/p63KZ1ZDtKvIzojGQdooWJyZuDrNs0dJFMVhylnnEE87znTiFXegNnVaW?=
 =?us-ascii?Q?NNLJ7TzYYcJZ1UIaYmH/Ne+TDiwtbQAtvh0pF/qsUSjjwwPriZBAI1+SS9+S?=
 =?us-ascii?Q?Ueg41UQMtb8aMWQAVGy7Iz150jYkGSyUX1v/DUZ0jTBhus0PuyaPKAY0xfBd?=
 =?us-ascii?Q?ZNcDm8AV/5bNpeEyjSBMH/ya8K1QdENXIlOG/FjCmaObIZFJHOrks0ru55Nl?=
 =?us-ascii?Q?sE4DFJavZ8F2l+APMuBSsbBO5wElOWdYmJx1PirPxeCfi7G/NvTXWzbUJoto?=
 =?us-ascii?Q?P2DCJpmvQxTqn2Y3ohJeb1kIXAl5ZgBS8VvwImzntqA+/zHGpPK5Xeq9LNiJ?=
 =?us-ascii?Q?wrrppz8bCSESikPsiPJeaCYodtUuQd89piIL5+WRW4ZFMVQZg604JQwP+Wi7?=
 =?us-ascii?Q?cZvJcNKWJG0+zQPuds23PVNCBG1kCLiRakXeisfa9e/UbjrwPCTVUoCVR+MV?=
 =?us-ascii?Q?sDgL8lpS/jyUMRI4TMurp4xViH/szikLV58qzP3Auk7eSj8JYKANrALk3gad?=
 =?us-ascii?Q?bn9NYW+I4g7YOQ3rSnQD5CemLnyak2zfv3Gg3ieuV/sOstX1xhvUDZtx3ccI?=
 =?us-ascii?Q?L6PvDCgIaBXAdmI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:44:49.1860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd446ad-d4b3-4ff1-e1f2-08dd5a943da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
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
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 45 ++++++--------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h | 11 +++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 26 +++++++-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 59 ++++++++++++++-----
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 28 +++++++--
 6 files changed, 123 insertions(+), 50 deletions(-)

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
index 4984b41cd372..3f574d82b5fc 100644
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
+	if (!retval && cmd == KFD_DEQUEUE_WAIT_INIT)
+		update_dqm_wait_times(pm->dqm);
+
 out:
 	mutex_unlock(&pm->lock);
 	return retval;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index d56525201155..b9c611b249e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -297,23 +297,54 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
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
+	default:
+		pr_err("Invalid dequeue wait cmd\n");
+		return -EINVAL;
+	}
 
 	packet = (struct pm4_mec_write_data_mmio *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
@@ -415,7 +446,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
 	.set_resources		= pm_set_resources_v9,
 	.map_queues		= pm_map_queues_v9,
 	.unmap_queues		= pm_unmap_queues_v9,
-	.set_grace_period       = pm_set_grace_period_v9,
+	.config_dequeue_wait_counts = pm_config_dequeue_wait_counts_v9,
 	.query_status		= pm_query_status_v9,
 	.release_mem		= NULL,
 	.map_process_size	= sizeof(struct pm4_mes_map_process),
@@ -423,7 +454,7 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
 	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
 	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
 	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
-	.set_grace_period_size  = sizeof(struct pm4_mec_write_data_mmio),
+	.config_dequeue_wait_counts_size  = sizeof(struct pm4_mec_write_data_mmio),
 	.query_status_size	= sizeof(struct pm4_mes_query_status),
 	.release_mem_size	= 0,
 };
@@ -434,7 +465,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
 	.set_resources		= pm_set_resources_v9,
 	.map_queues		= pm_map_queues_v9,
 	.unmap_queues		= pm_unmap_queues_v9,
-	.set_grace_period       = pm_set_grace_period_v9,
+	.config_dequeue_wait_counts = pm_config_dequeue_wait_counts_v9,
 	.query_status		= pm_query_status_v9,
 	.release_mem		= NULL,
 	.map_process_size	= sizeof(struct pm4_mes_map_process_aldebaran),
@@ -442,7 +473,7 @@ const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
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

