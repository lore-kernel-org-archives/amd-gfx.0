Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01B5FA3743
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C70810E2FE;
	Mon, 31 Oct 2022 16:25:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2C410E2ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDflZbvfWB7SCLVtfKg6XUNrDUHbckDUjsj0PaRsjuQ5PNPNMC0QET3Hjyeuq6pugcIOWCIL6CTGu0I+9z52jvGNEFKJdtCwyRjy7SCL/VAmU40hA3ef+0rWMfwxpRmu1mnpJiL9GfiYShpTHP3qRYzDz4pvGkER2w08cB8+LMTJhgULtSFSUP7NhquuFvbch347sXIkq67nT2Biy2RIIBxECCmrTCqTyzrihLZsGlYYwvBMc+c8MHKsPApqXR+gbbxorMY+Am5PMfdFm/l+dLCQxYAmbEb7yk7LSvNlu76NuWcR2U6ahXvmK+TEUry48xml1/l6Jt5UdSR6WkPC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5noCrnq1wyVWTwUMuiOTshGgBeSuwv0yjW+tp+eyy0=;
 b=llMmtkNkbckPJT8mNf7s7OIx4joCHnQgdszwhmokeN9VrNiRa1K+53s8FtugjbEvABaNndbKrlPIuyGTG0A+W/PI3wQPPTmvwDj+6f6VGxJWk18vMBbRO9nNCAAe42BmTR35M+WP6/WF0tk+Gpfcdd9ntBXpx+5/w47HZPTad6YtcX4tvNxlO/2LGmQ6X/nXykfHpBQqtwp1hJWBDQ0q8GqKbjLV0iU+HjMLSHzvb8wVGJZ3/Dx0z7dALPA3j6WoGeKsGPlSN1IJB9pMKehSGip1JpjEQ955Z9MISo320LRWW93AoxpZB9M1U0vnIOkd0yYgw54s82VI2dL96hOw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5noCrnq1wyVWTwUMuiOTshGgBeSuwv0yjW+tp+eyy0=;
 b=znaX1Ar5EA0nubPaHg/Z/UvKM1H6FY5+uChkpNAXmzH294+cqrUo1slF6qPEoIIwnrBqMitexZg1WsVtqU1dQwM5wDJFCmGaldwUD9SzBvjuYqWXEwoWIdCs6T08EXbWe5oL3mporjRBi/bl9zBeGAC/IaPhsU0kPyJmK3SKnF4=
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 16:24:29 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::73) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:29 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:25 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/29] drm/amdgpu: prepare map process for multi-process debug
 devices
Date: Mon, 31 Oct 2022 12:23:42 -0400
Message-ID: <20221031162359.445805-12-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: da86f972-8aac-44ab-3686-08dabb5c62b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+DjOVIh1S2XRab+AShj25M3mmelS9e4CZUKWrzxVENQhjPfTqsT/c7UQ5CFsCib5Z5wtTc5g0OzZ8yy09rwIagyMMkRrTRwDcTy8U+4fDMcR3wrxyyGGsaKAvUihtkXKR44kFgNMOlimAol1C2foAb6QBHqRDl9KrsItahmzOB6q+WS4Iw7K38hNQTEv4xSpVawq6hetAr+7RbHVScrZ0llRlVz8poeTSoP8ivpGIfkYmOlnMp7nNKA2U0/B9kzY8k0MxRIzdC3JnFOgXSE5vNsk9kbXRwWLsLJmeFpOHxMNqOoxZbIP/QK0vYfZRIktTrph01mxVQD1FJAH0e/iNPlRPsFUeRMfCgMFg6+wid/xI94Mx1Pb+Y/JzF6vsZXv66SrA4J4t9fSbwOOpuQ+6Po9ekPRMOii+UNLkRfY9i2j3LxUXu/6Yy8Ss/KpO52WO3Zjnv2IqdL/p+qOvGUq40/njtS4WZn/ZUhT768vItKAfKcE3E/dvjen2pDsXET6x9dNbIA8FTmbLe/lOAeQkPIURUPGfWAY3NtsFPJcYPBM58H2GOJmbiY2qqD7lNo6ekEKcACte8e4so3rGMZCs4jIIiH8t2Cg9T7aWJA13GPJBw1sZ+1UP+OFeQE7dwzyTVVYWMSYOlyKAj3yxK8IjFU+SpI17hrFDJKe8UyymTNs5Ep46ge6wJGPORRRL/SnJlYDWCRYXg8qvmcesjHyqT4oVTWPbb7PnZmShe6ULhFs33lWcpy/rR6/LdPY6LS+eUHjAIiPREDBwQr7hJpcyiwePiGarL6oS9DBkChAnw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(356005)(6666004)(47076005)(2906002)(426003)(5660300002)(1076003)(186003)(8936002)(36756003)(44832011)(336012)(16526019)(70586007)(70206006)(8676002)(7696005)(4326008)(2616005)(86362001)(82740400003)(41300700001)(26005)(82310400005)(81166007)(83380400001)(40460700003)(36860700001)(40480700001)(316002)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:29.2172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da86f972-8aac-44ab-3686-08dabb5c62b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unlike single process debug devices, multi-process debug devices allow
debug mode setting per-VMID (non-device-global).

Because the HWS manages PASID-VMID mapping, the new MAP_PROCESS API allows
the KFD to forward the required SPI debug register write requests.

To request a new debug mode setting change, the KFD must be able to
preempt all queues then remap all queues with these new setting
requests for MAP_PROCESS to take effect.

Note that by default, debug mode must be disabled for performance reasons
for multi-process debug devices for performance reasons.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  7 +++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 50 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 ++
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 15 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  5 ++
 6 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 8aa7a3ad4e97..b7ecd603f277 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -32,5 +32,12 @@ int kfd_dbg_trap_disable(struct kfd_process *target);
 int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 			void __user *runtime_info,
 			uint32_t *runtime_info_size);
+
+static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_dev *dev)
+{
+	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2); /* Aldebaran */
+}
+
 void debug_event_write_work_handler(struct work_struct *work);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 62bb92ef1acd..1634cc2ee202 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2556,6 +2556,56 @@ int release_debug_trap_vmid(struct device_queue_manager *dqm,
 	return r;
 }
 
+int debug_lock_and_unmap(struct device_queue_manager *dqm)
+{
+	int r;
+
+	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
+		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
+		return -EINVAL;
+	}
+
+	if (!kfd_dbg_is_per_vmid_supported(dqm->dev))
+		return 0;
+
+	dqm_lock(dqm);
+
+	r = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, 0, false);
+	if (r)
+		dqm_unlock(dqm);
+
+	return r;
+}
+
+int debug_map_and_unlock(struct device_queue_manager *dqm)
+{
+	int r;
+
+	if (dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
+		pr_err("Unsupported on sched_policy: %i\n", dqm->sched_policy);
+		return -EINVAL;
+	}
+
+	if (!kfd_dbg_is_per_vmid_supported(dqm->dev))
+		return 0;
+
+	r = map_queues_cpsch(dqm);
+
+	dqm_unlock(dqm);
+
+	return r;
+}
+
+int debug_refresh_runlist(struct device_queue_manager *dqm)
+{
+	int r = debug_lock_and_unmap(dqm);
+
+	if (r)
+		return r;
+
+	return debug_map_and_unlock(dqm);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static void seq_reg_dump(struct seq_file *m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 0cb1504d24cf..bef3be84c5cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -286,6 +286,9 @@ int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd);
 int release_debug_trap_vmid(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd);
+int debug_lock_and_unmap(struct device_queue_manager *dqm);
+int debug_map_and_unlock(struct device_queue_manager *dqm);
+int debug_refresh_runlist(struct device_queue_manager *dqm);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 363cf8e005cc..f19c506da23d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -88,6 +88,10 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
 {
 	struct pm4_mes_map_process_aldebaran *packet;
 	uint64_t vm_page_table_base_addr = qpd->page_table_base;
+	struct kfd_dev *kfd = pm->dqm->dev;
+	struct kfd_process_device *pdd =
+			container_of(qpd, struct kfd_process_device, qpd);
+	int i;
 
 	packet = (struct pm4_mes_map_process_aldebaran *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mes_map_process_aldebaran));
@@ -102,6 +106,17 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
 	packet->bitfields14.num_oac = qpd->num_oac;
 	packet->bitfields14.sdma_enable = 1;
 	packet->bitfields14.num_queues = (qpd->is_debug) ? 0 : qpd->queue_count;
+	/* TRAP_EN is set on boot so keep it set in non-debug mode. */
+	packet->spi_gdbg_per_vmid_cntl = pdd->spi_dbg_override |
+						pdd->spi_dbg_launch_mode;
+
+	if (pdd->process->debug_trap_enabled) {
+		for (i = 0; i < kfd->device_info.num_of_watch_points; i++)
+			packet->tcp_watch_cntl[i] = pdd->watch_points[i];
+
+		packet->bitfields2.single_memops =
+				!!(pdd->process->dbg_flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP);
+	}
 
 	packet->sh_mem_config = qpd->sh_mem_config;
 	packet->sh_mem_bases = qpd->sh_mem_bases;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a851f814bc9d..6360b365973c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -782,6 +782,12 @@ struct kfd_process_device {
 	uint64_t faults;
 	uint64_t page_in;
 	uint64_t page_out;
+
+	/* Tracks debug per-vmid request settings */
+	uint32_t spi_dbg_override;
+	uint32_t spi_dbg_launch_mode;
+	uint32_t watch_points[4];
+
 	/*
 	 * If this process has been checkpointed before, then the user
 	 * application will use the original gpu_id on the
@@ -918,6 +924,9 @@ struct kfd_process {
 
 	bool xnack_enabled;
 
+	/* Tracks debug per-vmid request for debug flags */
+	bool dbg_flags;
+
 	/* Work area for debugger event writer worker. */
 	struct work_struct debug_event_workarea;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index efb81ccef8f5..a57a55f6ccee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1558,6 +1558,11 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	}
 
 	p->pdds[p->n_pdds++] = pdd;
+	if (kfd_dbg_is_per_vmid_supported(pdd->dev))
+		pdd->spi_dbg_override = pdd->dev->kfd2kgd->disable_debug_trap(
+							pdd->dev->adev,
+							false,
+							0);
 
 	/* Init idr used for memory handle translation */
 	idr_init(&pdd->alloc_idr);
-- 
2.25.1

