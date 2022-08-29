Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF4CC0502C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143D110F300;
	Mon, 29 Aug 2022 14:32:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B3510F2EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgeTUIx+ZJa5mjfAraDTHbL/4rM6tpCB2nsGEUtXdJKSqlz7FlCwG9o8rC8M4LTX6HJL8wnLNiCKpjtlHpYtcNTE1uF/0Hn+kPRcGCDIz9CIvqzIdzOCUp6qHlJlnhnuTa7/brYCF6augNl6gBLVtHak+ylHU34aT0ba/2OiPQFYn0CaOYD3/+hG5YVPiZxTVjfQAX+11ffajnNwY+xyW/lZ7yN8j+Xqk0G3ePuGKj0onbRxbze6ozV6tDbxEwFOQyWVqDW6stRfSxLpQhqkWmi4USLl8Rrv9EFnwwIB1k4ObWdmqWIGGh/KTNqZolUY95+97cSgTBKGeSFKjr5d1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krWS+VAZR2rTy9q+zfhUPG4u5lnbtB0SQ5pWh3F20fU=;
 b=DvjlSfaV6WRJl735WLlCfkqnZnVJr1BdhWVnrdCbI/bd9VcsHYmBJ+SUAdtKACV+YGHUywyyhcl8DclgyPlg2aeAMeKvB8AoW3srwHOdGuX+r15i40GXHboM0uBS2bfIvnYU4EFsXNio7vGTjkIb5LmhBqqqnbE6ljC5o8gKIRWR51TUqB46DfWT+o2bdxZKPLcS2oUXvNqXJQCRZAsNWzJ45WjGG3guZGkx6cLdoMXU2tLDf4LmCUOLPWqxAcnm4dFzyMpYelNaPQmQQRdKO+dOFAnTqWJG7wkHtfTumTjLJJlTmyp8ZexRlqpYjCrqb9I9KvgSX/hDBqrlgOJGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krWS+VAZR2rTy9q+zfhUPG4u5lnbtB0SQ5pWh3F20fU=;
 b=cKxWZNCHJHG0vrrsBw2I3cgEUlHyllCCQdHhUA0j3Vs1IP0B8ynhgg3AihJUNj9MRokhZ496V0H99t74Tvaix+bpmUL+lPuO8Hm73IxBkHaKQBl57I6jA0BucYqROyAMLHpvFGEea10owmtzwEbzZ6kEOxmOlpgxPBPGRF0xmis=
Received: from MW4PR04CA0101.namprd04.prod.outlook.com (2603:10b6:303:83::16)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 14:31:10 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::5c) by MW4PR04CA0101.outlook.office365.com
 (2603:10b6:303:83::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:09 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:46 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/29] drm/amdgpu: prepare map process for multi-process debug
 devices
Date: Mon, 29 Aug 2022 10:30:09 -0400
Message-ID: <20220829143026.1509027-13-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b49c9e16-8b1c-45f2-02c8-08da89cb1df9
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRwE7E/cFnC6qvhgTqQj+QC0RzpW4AA4AkDiBxVaOHk2oqz8ahaz4eGrgA9OOcHcKPBTF6G9NEJAP/qbE5AU4+ou5M0oLAiwQUvEcf8UMvkWEM1aET3pVGbdDixJUv78cwq3FgaqSvrsoFvFvd5v1cMLg+zQivcwzVzt9REsffU7OjCrlABH0wigWdCUbtqqFDikEKZhH9akWlTrhaL/5of3OWUJKjGIOmKmI8UddJnkLnC/+Z/eFaAxBxrO9C9BpReomJJFepw9HbJGjUyJm+sc0sAL9yWYjaYmdR/WjTybs7D7TAGQg/gMif09R5FpWUBjmpXUaVZBIxFP+fdGUSJ4Xqs+4xOuYWT3mjkqahbQ0UaIgqA+XaDTVYOj0AxBU/xkgwWTagIHSzih5Ylu5zVRen37EU+WiCbJ5DqaloX+oHUg/zopMSJjkrbXf/xDUe36VQa6fy2fQNmEu+dcWHDSYC9w6v1rSVq7LhX3j3PVWRPLkLbT+lTsmZngg4hijlgEmVrKm8LCiI1iLrhXCL7s2kld6uYooxpsqFvlGk8AoXgo4G8tBULj/rAMXooLUSeMt655FlMAfXflRQfqnDc2KXRPVisW2MPbpPvWp7C7plr2doptHiVsaPMvShURTWWyF0n+a8mszWHvDcYK4ArkGXBJ7WqCYS2MiVuaSI+SbTKrHDD0kaCtKuKLtNjv+V1SQM+cvsDoE0hgIjld6orN4HhDFZ79Q5I97RkChH+oSVQbfSSWCfrQDuM/PvtFyiylNnU0+3zju4XtCS00sjctFti32//Vv41qLGmdre8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(40470700004)(36840700001)(46966006)(356005)(81166007)(8676002)(4326008)(70206006)(70586007)(36860700001)(86362001)(82740400003)(36756003)(83380400001)(47076005)(426003)(186003)(41300700001)(16526019)(336012)(1076003)(7696005)(478600001)(26005)(6666004)(82310400005)(316002)(6916009)(40460700003)(54906003)(40480700001)(2906002)(2616005)(8936002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:09.8696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b49c9e16-8b1c-45f2-02c8-08da89cb1df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
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
index 254434371951..7c983f5f2d6e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2559,6 +2559,56 @@ int release_debug_trap_vmid(struct device_queue_manager *dqm,
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
index 9e2a0615647f..2a38b3d8f8dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1563,6 +1563,11 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
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

